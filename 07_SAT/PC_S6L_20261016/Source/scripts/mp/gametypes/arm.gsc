// scripts\mp\gametypes\arm.gsc  (hash_3ba4f32e41f63b36.gscc) (size: 83475 Bytes / 0x14613 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef44e38d (4014269325)
// size ...... 83475 (0x14613)
// includes .. 63  (offset: 0x12ca3)
// strings ... 307 (offset: 0x12e9b)
// dev strs .. 14  (offset: 0x1453b)
// exports ... 127 (offset: 0xe223)
// cseg ...... 0x17b5 + 0xca6e (0xe223)
// imports ... 414 (offset: 0xf5fb)
// animtree1 . 0   (offset: 0x14613)
// animtree2 . 0   (offset: 0x14613)
#using script_2f4866552f0ba818;
#using script_382bf8d77c4fd348;
#using script_6800334345ed1df0;
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_airdrop;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\ai_sentry_turret;
#using scripts\mp\bots\bots;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\cash;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\nuke;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\game_utility_mp;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\entityheadicons;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arm_upgrades;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\dom;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\playerlogic;
#using scripts\mp\rally_point;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
#using scripts\mp\squads;

#namespace arm;

// Namespace arm
// Params 0
// Checksum 0x1ca77f0a, Offset: 0x17d3
// Size: 0xc24
function main()
{
    level.arm = {};
    level.exfilpoi = getdvarint( @"scr_gw_exfil", 0 ) == 1;
    level.var_c83ebcd6f3aeab1b = getdvarfloat( @"hash_c1500e49d11c3d8b", 30 );
    level.var_d2f40b81c9a9a97a = getdvarfloat( @"hash_99498c3cd07bd62a", 30 );
    level.var_15cbe4222c448d68 = getdvarint( @"hash_24da5a5f8f351756", 1 ) == 1;
    level.var_1c200ed73d3a02b5 = getdvarint( @"hash_2574f7be00216c7d", 0 ) == 1;
    level.var_ead45b85f69790c5 = getdvarint( @"hash_99890ee8a4f2b929", 1 ) == 1;
    level.spawndelay = undefined;
    
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
    setdvar( @"hash_405e7e20d91344cc", 0 );
    setdvar( @"scr_allow_technicals", 1 );
    setdvar( @"scr_runlean_max_technicals", 30 );
    setdvar( @"hash_e4fa721677f03de0", 1 );
    setdvar( @"cg_friendlyrevivenameplateenabled", 0 );
    setomnvar( "ui_num_dom_flags", 5 );
    updategametypedvars();
    join_team_aggregator::registeronplayerjointeamcallback( &onjoinedteam );
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.scoreperplayer = undefined;
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onrespawndelay = &getrespawndelay;
    level.onnormaldeath = &onnormaldeath;
    level.onobjectivecomplete = &dom::onflagcapture;
    level.updatefobspawnselection = &updatefobspawnselection;
    
    /#
        level.var_c7f22dd7cb861f3 = &function_c7f22dd7cb861f3;
    #/
    
    level.var_40cd999d911308e0 = &game_utility_mp::function_abefb3841cda328e;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_90ed3e9fed444ef5;
    level.checkcustomclosetoscorelimit = &checkcustomclosetoscorelimit;
    level.domflag_setneutral = &obj_dom::domflag_setneutral;
    level.dompoint_setcaptured = &obj_dom::dompoint_setcaptured;
    level.requiredplayercountoveride = 1;
    level.requiredplayercount[ "allies" ] = 24;
    level.requiredplayercount[ "axis" ] = 24;
    level.var_5fb58f5bb9552416 = &getmissedinfilcamerapositions;
    level.var_81d027302ddd38f4 = &calculatecameraoffset;
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        game[ "dialog" ][ "gametype" ] = "dx_mp_grnd_game_mili_name";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "dx_mp_grnd_game_mili_name";
    }
    
    if ( getdvarint( @"scr_diehard" ) )
    {
        game[ "dialog" ][ "gametype" ] = "dh_" + game[ "dialog" ][ "gametype" ];
    }
    else if ( dvars::function_13909a5327c395b9( "promode" ) )
    {
        game[ "dialog" ][ "gametype" ] = game[ "dialog" ][ "gametype" ] + "_pro";
    }
    
    game[ "dialog" ][ "offense_obj" ] = "dx_mp_grnd_game_mili_bost";
    game[ "dialog" ][ "defense_obj" ] = "dx_mp_grnd_game_mili_bost";
    game[ "dialog" ][ "securing_a" ] = "dx_mp_domi_game_uktl_dsca";
    game[ "dialog" ][ "securing_b" ] = "dx_mp_domi_game_uktl_dscb";
    game[ "dialog" ][ "securing_c" ] = "dx_mp_domi_game_uktl_dscc";
    game[ "dialog" ][ "securing_d" ] = "dx_mp_domi_game_uktl_dscd";
    game[ "dialog" ][ "securing_e" ] = "dx_mp_domi_game_uktl_dsce";
    game[ "dialog" ][ "secured_a" ] = "dx_mp_domi_game_uktl_dcpa";
    game[ "dialog" ][ "secured_b" ] = "dx_mp_domi_game_uktl_dcpb";
    game[ "dialog" ][ "secured_c" ] = "dx_mp_domi_game_uktl_dcpc";
    game[ "dialog" ][ "secured_d" ] = "dx_mp_domi_game_uktl_dcpd";
    game[ "dialog" ][ "secured_e" ] = "dx_mp_domi_game_uktl_dcpe";
    game[ "dialog" ][ "losing_a" ] = "dx_mp_domi_game_uktl_dlsa";
    game[ "dialog" ][ "losing_b" ] = "dx_mp_domi_game_uktl_dlsb";
    game[ "dialog" ][ "losing_c" ] = "dx_mp_domi_game_uktl_dlsc";
    game[ "dialog" ][ "losing_d" ] = "dx_mp_domi_game_uktl_dlsd";
    game[ "dialog" ][ "losing_e" ] = "dx_mp_domi_game_uktl_dlse";
    game[ "dialog" ][ "lost_a" ] = "dx_mp_domi_game_uktl_dloa";
    game[ "dialog" ][ "lost_b" ] = "dx_mp_domi_game_uktl_dlob";
    game[ "dialog" ][ "lost_c" ] = "dx_mp_domi_game_uktl_dloc";
    game[ "dialog" ][ "lost_d" ] = "dx_mp_domi_game_uktl_dlod";
    game[ "dialog" ][ "lost_e" ] = "dx_mp_domi_game_uktl_dloe";
    game[ "dialog" ][ "lost_all" ] = "dx_mp_domi_game_uktl_doml";
    game[ "dialog" ][ "secure_all" ] = "dx_mp_domi_game_uktl_domw";
    level.nosuspensemusic = 1;
    level._effect[ "vfx_smk_signal_gr" ] = loadfxasset( "vfx_requests_mp_gameplay_smoke_signal_gr" );
    level._effect[ "vfx_snatch_ac130_clouds" ] = loadfxasset( "vfx_iw8_mp_gamemode_snatch_ac130_clouds" );
    level._effect[ "vfx_br_infil_cloud_scroll" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_cloud_scroll" );
    level._effect[ "vfx_br_infil_jump_smoke_01" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_smoke_01" );
    level._effect[ "vfx_br_infil_jump_wisp_01" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_wisp_01" );
    level._effect[ "vfx_br_infil_jump_wisp_02" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_wisp_02" );
    level._effect[ "vfx_br_infil_omni_light" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_omni_light" );
    level._effect[ "vfx_br_infil_spot_light" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_spot_light" );
    level.disablespectate = getdvarint( @"hash_6228446f42d1367f", 1 ) == 1;
    level.nukeselectactive = getdvarint( @"hash_720c7a325f31f44b", 0 );
    level.killstoearnnukeselect = getdvarint( @"hash_b081c1dd5ea0af33", 7 );
    level.useobjectives = getdvarint( @"hash_f487c553b2ae0bdb", 1 );
    level.var_f6d84c3d34a4d13c = getdvarint( @"hash_a661e1dcd40b7f5b", 1 );
    level.userallypointvehicles = getdvarint( @"hash_9381d93d96c2f50b", 1 );
    level.hideenemyfobs = getdvarint( @"hash_7aefd938edd32dcc", 0 );
    level.completelyremovelittlebird = getdvarint( @"hash_e39e476d418a5b03", 0 );
    level.usec130spawn = getdvarint( @"hash_9d9bb5a2f8144fb0", 0 );
    level.usec130spawnfirstonly = getdvarint( @"hash_930ce0bf448dadaa", 0 );
    level.c130movementmethod = getdvarint( @"hash_2a34ac7d0124085e", 0 );
    level.c130flightdist = getdvarfloat( @"hash_2d511cfd4eb77221", 4000 );
    level.c130distapart = getdvarfloat( @"hash_ef46594cd3335bd3", 5000 );
    level.c130alignedtolocale = getdvarfloat( @"hash_f4da32c36b5dcd26", 1 );
    level.var_7f0a2d7de93a21d3 = getdvarint( @"hash_e4a8296b521a6dee", 1 ) == 1;
    level.var_1273a5ffe332df4d = getdvarfloat( @"hash_91d950c33d45ae50", 60 );
    level.var_4e367de5c2d6631e = getdvarfloat( @"hash_58c456ebd6371a4b", 60 );
    level.var_b9ea12c4f2229c53 = getdvarint( @"hash_19e5cada53ccf044", 0 ) == 1;
    level.var_65526c5c4e8f9d90 = getdvarint( @"hash_67a32114ce80b58f", 0 ) == 1;
    level.var_576f7155d6a0fa48 = getdvarint( @"hash_27abaa55d7ec8eb9", 1 ) == 1;
    level.var_693302e6ea51684f = getdvarint( @"scr_game_infilskip", 0 ) == 1 || getdvarint( @"hash_ff5233fcf546c6b1", 0 ) == 1;
    level.var_dfb2277145204ce4 = &arm_upgrades::function_dfb2277145204ce4;
    level.var_4aabf66864c03ef4 = &arm_upgrades::function_4aabf66864c03ef4;
    level.var_bb6300af9683b504 = &arm_upgrades::function_bb6300af9683b504;
    level.skydiveredeploy = &arm_upgrades::skydiveredeploy;
    level.dropbrloot = getdvarint( @"hash_1d196605f8a290e3", 0 );
    level.br_plunder_enabled = getdvarint( @"scr_game_cash", 0 );
    
    if ( level.br_plunder_enabled )
    {
        loot::init();
        level.var_415fc308a7faccd9 = 0;
    }
    
    level.var_99e6db424e4b2f5c = getdvarint( @"hash_644f043f54d141f5", 0 );
    level.var_f44b0da5db239f15 = getdvarint( @"hash_8fd67e929af907eb", 0 );
    
    if ( level.var_99e6db424e4b2f5c )
    {
        level.var_cc4ceaea968640d2 = &points::function_cc4ceaea968640d2;
    }
    
    level.spawnselectionshowenemy = getdvarint( @"scr_spawnselectionshowenemy", 0 );
    level.spawnselectionshowfriendly = getdvarint( @"scr_spawnselectionshowfriendly", 0 );
    level.forcetopickafob = getdvarint( @"scr_arm_forcespawning", 0 );
    level.maxhqtanks = getdvarint( @"scr_arm_maxhqtanks", 2 );
    level.tankrespawntime = getdvarint( @"hash_b624863894a18f21", 120 );
    level.apcrespawntime = getdvarint( @"hash_ba2474692378b203", 120 );
    level.longdialoguecooldown = getdvarint( @"hash_e01953fcf34a5d51", 1 );
    level.mercymatchending_nuke = getdvarint( @"hash_647cfd0a848d6ed6", 1 );
    level.mercymatchending_time = getdvarint( @"scr_arm_mercyendingtime", 30 );
    level.numnonrallyvehicles = getdvarint( @"scr_arm_numnonrallyvehicles", 25 );
    level.disablepersonalnuke = getdvarint( @"hash_f271257bddc28c95", 0 );
    level.personalnukecostoverride = getdvarint( @"scr_personalnukecostoverride", 30 );
    level.showteamtanks = getdvarint( @"scr_arm_showteamtanks", 1 );
    level.spawnselectionafktime = getdvarint( @"hash_da4e1d4c2111a1bc", 120 );
    level.manualadjustlittlebirdlocs = getdvarint( @"hash_1d04716268113cb5", 1 );
    level.var_3416583522672ad3 = getdvarint( @"hash_a9937f1a2710bcd8", 1 );
    level.updatedinit = getdvarint( @"hash_918a1c9cbdedcfa6", 0 );
    level.var_9ed836e326023da5 = getdvarint( @"hash_4c7256e45a15bd91", 0 ) == 1;
    level.var_c3b8f183c54800f4 = getdvarint( @"hash_25637b1761f5544", 0 ) == 1;
    
    if ( level.showteamtanks )
    {
        level.trackedtanks = [];
        level.trackedtanks[ "axis" ] = [];
        level.trackedtanks[ "allies" ] = [];
    }
    
    if ( level.useobjectives || level.userallypointvehicles || level.usesquadspawnselection )
    {
        setdvar( @"scr_game_usespawnselection", 1 );
        level.disablespawncamera = 0;
        setdvar( @"hash_1a2c3b67392b6657", 1 );
    }
    else
    {
        setdvar( @"scr_game_usespawnselection", 0 );
        level.disablespawncamera = 1;
        setdvar( @"hash_1a2c3b67392b6657", 1 );
    }
    
    if ( level.c130movementmethod == 1 )
    {
        level.c130pathkilltracker = [];
        level.c130pathkilltracker[ "axis" ] = 0;
        level.c130pathkilltracker[ "allies" ] = 0;
    }
    
    level.modecontrolledvehiclespawningonly = 1;
    level.spawnprotectionexception = &spawnprotectionexception;
    thread function_e42623be2d62d389();
    
    if ( getdvarint( @"hash_60a5cd40eb9c3192", 0 ) == 1 )
    {
        level thread namespace_14ab7f658b8ad5e4::function_a1e291f650f8bab3();
    }
    
    utility::flag_init( "stealth_enabled" );
    utility::flag_init( "level_stealth_initialized" );
    utility::flag_init( "stealth_spotted" );
    level.var_3908518e49f7ee02 = &function_3908518e49f7ee02;
    function_5887502d62f0e88b();
    function_680ed35851d114c8();
    
    if ( level.userallypointvehicles )
    {
        rally_point::init();
        level thread arm_vehicles::init_rallyvehicles();
    }
}

// Namespace arm
// Params 1
// Checksum 0x83ee308, Offset: 0x23ff
// Size: 0x23
function function_3908518e49f7ee02( team )
{
    return game[ "switchedsides" ] ? team_utility::getotherteam( team ) : team;
}

// Namespace arm
// Params 0
// Checksum 0x1862f972, Offset: 0x242b
// Size: 0xcd
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_arm_zonelifetime", getmatchrulesdata( "kothData", "zoneLifetime" ) );
    setdynamicdvar( @"scr_arm_zonecapturetime", getmatchrulesdata( "kothData", "zoneCaptureTime" ) );
    setdynamicdvar( @"scr_arm_zoneactivationdelay", getmatchrulesdata( "kothData", "zoneActivationDelay" ) );
    setdynamicdvar( @"scr_arm_randomlocationorder", getmatchrulesdata( "kothData", "randomLocationOrder" ) );
    setdynamicdvar( @"scr_arm_additivescoring", getmatchrulesdata( "kothData", "additiveScoring" ) );
    setdynamicdvar( @"scr_arm_pausetime", getmatchrulesdata( "kothData", "pauseTime" ) );
    setdynamicdvar( @"hash_56b7b535b0bd8d1a", getmatchrulesdata( "tdefData", "spawnDelay" ) );
}

// Namespace arm
// Params 0
// Checksum 0x45dd99ba, Offset: 0x2500
// Size: 0x427
function onstartgametype()
{
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
    
    foreach ( team in level.teamnamelist )
    {
        game_utility_mp::setobjectivehinttext( team, &"objectives/armsrace_hint" );
    }
    
    setclientnamemode( "auto_change" );
    level.objectives = [];
    level.uncapturableobjectives = [];
    level thread initspawns();
    seticonnames();
    level.usedomflag = 0;
    level.killstreakqueue = [];
    level.teamkillstreakqueue = [];
    level.teamkillstreakqueue[ "allies" ] = [];
    level.teamkillstreakqueue[ "axis" ] = [];
    level.killstreaklist = [];
    level.killstreaklist[ 4 ] = [ "cruise_predator", "scrambler_drone_guard" ];
    level.killstreaklist[ 3 ] = [ "precision_airstrike", "multi_airstrike", "bradley" ];
    level.killstreaklist[ 2 ] = [ "toma_strike", "chopper_gunner", "pac_sentry", "gunship" ];
    level.teamkillstreakqueue[ "allies" ] = [ "cruise_predator", "precision_airstrike", "cruise_predator" ];
    level.teamkillstreakqueue[ "axis" ] = [ "cruise_predator", "precision_airstrike", "cruise_predator" ];
    level thread setupwaypointicons();
    debug_setupmatchdata();
    setuphqs();
    sethqmarkerobjective();
    calculatehqmidpoint();
    
    if ( level.useobjectives )
    {
        setupobjectives();
        runobjectives();
        level thread hackfixcameras();
        level thread objective_manageobjectivesintrovisibility();
        level thread allowobjectiveuseaftermatchstart();
        level.var_aed2551dbad09889 = 1;
    }
    
    if ( level.usec130spawn )
    {
        level thread arm_vehicles::managec130spawns();
    }
    
    /#
        level thread function_662cf4c1bdb0bdc3();
    #/
    
    thread arm_vehicles::init_groundwarvehicles();
    ai_sentry_turret::init();
    level thread updatedomscores();
    dialog::initstatusdialog();
    
    if ( level.mercymatchending_nuke )
    {
        level thread nuke_mercyending_init();
    }
    
    emergency_cleanupents();
    parachute::initparachutedvars();
    
    if ( getdvarint( @"scr_br_armory_kiosk", 0 ) == 1 )
    {
        common_kiosk::setbuystation( "gw_basic" );
        level thread arm_upgrades::function_e4f4a4cdd42c6c59();
    }
    
    if ( level.br_plunder_enabled && getdvarint( @"hash_cdbbb44046b62549", 1 ) == 1 )
    {
        level thread arm_upgrades::function_ab53d8d8cafe4f07();
    }
    
    if ( getdvarint( @"hash_94ff1f40ff78051e", 0 ) == 1 )
    {
        level thread namespace_14ab7f658b8ad5e4::armai_defenders();
    }
    
    vehicle_spawn::get_data( %"hash_57d0b185054b4bd4" ).respawndelay = 10000;
    vehicle_spawn::get_data( %"hash_32b7b34facdfbf9" ).respawndelay = 10000;
    vehicle_spawn::get_data( %"hash_755adbf0f147c02" ).respawndelay = 10000;
    
    foreach ( team in level.teamnamelist )
    {
        level thread function_ead0d01c88e8bdd0( team );
        level thread function_966acd158d15b6a4( team );
    }
    
    level thread function_4ec32d549c4e343e();
}

// Namespace arm
// Params 0
// Checksum 0x57eeb1b, Offset: 0x292f
// Size: 0x137
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.pausescoring = dvars::dvarintvalue( "pauseTime", 1, 0, 1 );
    level.spawndelay = dvars::dvarfloatvalue( "spawnDelay", 5, 0, 30 );
    level.flagcapturetime = dvars::dvarfloatvalue( "flagCaptureTime", 30, 0, 30 );
    level.flagsrequiredtoscore = dvars::dvarintvalue( "flagsRequiredToScore", 1, 1, 3 );
    level.pointsperflag = dvars::dvarintvalue( "pointsPerFlag", 1, 1, 300 );
    level.scoreInterval = dvars::dvarintvalue( "scoreInterval", 5, 1, 60 );
    level.flagneutralization = dvars::dvarintvalue( "flagNeutralization", 0, 0, 1 );
    level.precappoints = dvars::dvarintvalue( "preCapPoints", 0, 0, 1 );
    level.capturedecay = dvars::dvarintvalue( "captureDecay", 1, 0, 1 );
    level.capturetype = dvars::dvarintvalue( "captureType", 1, 0, 3 );
    level.numflagsscoreonkill = dvars::dvarintvalue( "numFlagsScoreOnKill", 0, 0, 3 );
    level.objectivescaler = dvars::dvarfloatvalue( "objScalar", 4, 1, 10 );
}

// Namespace arm
// Params 0
// Checksum 0xce7b374c, Offset: 0x2a6e
// Size: 0x72
function seticonnames()
{
    level.iconcapture = "waypoint_capture";
    level.iconneutral = "waypoint_captureneutral";
    level.icondefend = "waypoint_defend";
    level.iconcontested = "waypoint_contested";
    level.icondefending = "waypoint_defending";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.iconclearing = "waypoint_clearing";
}

// Namespace arm
// Params 0
// Checksum 0x93a0e1e8, Offset: 0x2ae8
// Size: 0x33d
function emergency_cleanupents()
{
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    game_utility::removematchingents_bykey( "vehicle_volume", "script_noteworthy" );
    game_utility::removematchingents_bykey( "vehicle_volume_simplified", "script_noteworthy" );
    game_utility::removematchingents_bykey( "super", "script_noteworthy" );
    game_utility::removematchingents_bykey( "militarybase", "script_noteworthy" );
    game_utility::removematchingents_bykey( "location_volume", "targetname" );
    game_utility::removematchingents_bykey( "locale_area_trigger", "targetname" );
    game_utility::removematchingents_bykey( "bank_entry_detector", "targetname" );
    game_utility::removematchingents_bykey( "shadow_blocker", "targetname" );
    game_utility::removematchingents_bymodel( "door_prison_cell_metal_mp", 1 );
    game_utility::removematchingents_bymodel( "veh8_mil_air_acharlie130", 1 );
    game_utility::removematchingents_bymodel( "door_wooden_panel_mp_01", 1 );
    game_utility::removematchingents_bymodel( "me_electrical_box_street_01", 1 );
    game_utility::removematchingents_bycodeclassname( "light" );
    game_utility::removematchingents_bycodeclassname( "trigger_use_touch" );
    
    if ( game_utility::getlocaleid() == "locale_6" )
    {
        game_utility::removematchingents_bykey( "locale_8", "script_noteworthy" );
    }
    
    var_8d16bd8ef76edfb3 = [];
    var_8d16bd8ef76edfb3[ 0 ] = ( -22592, 27367, 1000 );
    var_8d16bd8ef76edfb3[ 1 ] = ( -22592, 27303, -448 );
    var_8d16bd8ef76edfb3[ 2 ] = ( 7837, -9674, 1154 );
    var_8d16bd8ef76edfb3[ 3 ] = ( 7637, -9674, 1154 );
    var_8d16bd8ef76edfb3[ 4 ] = ( 7901, -9674, -270 );
    var_8d16bd8ef76edfb3[ 5 ] = ( 7701, -9674, -270 );
    var_8d16bd8ef76edfb3[ 6 ] = ( 10366, -11606, 66 );
    var_8d16bd8ef76edfb3[ 7 ] = ( 10366, -11813, 66 );
    var_8d16bd8ef76edfb3[ 6 ] = ( 10366, -11670, -270 );
    var_8d16bd8ef76edfb3[ 7 ] = ( 10366, -11877, -270 );
    var_8d16bd8ef76edfb3[ 8 ] = ( 7498, -11716, 66 );
    var_8d16bd8ef76edfb3[ 9 ] = ( 7498, -11652, -270 );
    var_8d16bd8ef76edfb3[ 10 ] = ( -1200, -18954, -242 );
    var_8d16bd8ef76edfb3[ 11 ] = ( -1215, -19016, 774 );
    ents = getentarray();
    
    foreach ( ent in ents )
    {
        if ( ent.model == "tag_origin" )
        {
            var_3b3ac614c0ebfb81 = 0;
            
            foreach ( badtagorigin in var_8d16bd8ef76edfb3 )
            {
                if ( var_3b3ac614c0ebfb81 )
                {
                    break;
                }
                
                if ( distancesquared( ent.origin, badtagorigin ) < 144 )
                {
                    var_3b3ac614c0ebfb81 = 1;
                }
            }
            
            if ( var_3b3ac614c0ebfb81 )
            {
                ent delete();
            }
        }
    }
}

// Namespace arm
// Params 0
// Checksum 0xce1a2db8, Offset: 0x2e2d
// Size: 0x158
function removepatchablecollision_delayed()
{
    wait 5;
    var_c9dd889ed0e5fc94 = [];
    var_c9dd889ed0e5fc94[ 0 ] = "tactical_cover_col";
    var_c9dd889ed0e5fc94[ 1 ] = "tactical_ladder_col";
    var_c9dd889ed0e5fc94[ 2 ] = "clip8x8x256";
    var_c9dd889ed0e5fc94[ 3 ] = "player8x8x256";
    var_c9dd889ed0e5fc94[ 4 ] = "ladderMetal264";
    var_c9dd889ed0e5fc94[ 5 ] = "ladderWood192";
    var_c9dd889ed0e5fc94[ 6 ] = "ladderMetal192";
    var_c9dd889ed0e5fc94[ 7 ] = "mount128";
    var_c9dd889ed0e5fc94[ 8 ] = "mount64";
    var_c9dd889ed0e5fc94[ 9 ] = "mount32";
    var_c9dd889ed0e5fc94[ 10 ] = "mount256";
    var_c9dd889ed0e5fc94[ 11 ] = "ladderWood264";
    var_c9dd889ed0e5fc94[ 12 ] = "nosight256x256x8";
    var_c9dd889ed0e5fc94[ 13 ] = "nosight128x128x8";
    var_c9dd889ed0e5fc94[ 14 ] = "mountCorner128";
    var_c9dd889ed0e5fc94[ 15 ] = "mantle256";
    var_c9dd889ed0e5fc94[ 16 ] = "mantle128";
    var_c9dd889ed0e5fc94[ 17 ] = "mantle64";
    var_c9dd889ed0e5fc94[ 18 ] = "mantle32";
    var_c9dd889ed0e5fc94[ 19 ] = "stairsHalfFlight128";
    var_c9dd889ed0e5fc94[ 20 ] = "stairsFullFlight128";
    
    foreach ( name in var_c9dd889ed0e5fc94 )
    {
        game_utility::removematchingents_bykey( name, "targetname" );
    }
}

// Namespace arm
// Params 1
// Checksum 0x1f757630, Offset: 0x2f8d
// Size: 0x15
function onjoinedteam( player )
{
    player arm_upgrades::function_c7d2f4bdf8ac4c13();
}

// Namespace arm
// Params 0
// Checksum 0xf9601965, Offset: 0x2faa
// Size: 0x177
function setupwaypointicons()
{
    while ( !( isdefined( level.streakglobals ) && isdefined( level.streakglobals.streakbundles ) ) )
    {
        waitframe();
    }
    
    foreach ( var_990d1998908bd83c, bundle in level.streakglobals.streakbundles )
    {
        level.waypointcolors[ var_990d1998908bd83c + "_incoming" ] = "neutral";
        level.waypointbgtype[ var_990d1998908bd83c + "_incoming" ] = 1;
        level.waypointstring[ var_990d1998908bd83c + "_incoming" ] = "";
        level.waypointshader[ var_990d1998908bd83c + "_incoming" ] = bundle.hudicon ?? "";
        level.waypointpulses[ var_990d1998908bd83c + "_incoming" ] = 0;
        level.waypointcolors[ var_990d1998908bd83c ] = "neutral";
        level.waypointbgtype[ var_990d1998908bd83c ] = 1;
        level.waypointstring[ var_990d1998908bd83c ] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
        level.waypointshader[ var_990d1998908bd83c ] = bundle.hudicon ?? "";
    }
}

// Namespace arm
// Params 0
// Checksum 0x7390e0f8, Offset: 0x3129
// Size: 0x1a5
function debug_setupmatchdata()
{
    level.var_76c4dc73f6b30344 = [];
    level.var_76c4dc73f6b30344[ game[ "switchedsides" ] ? "allies" : "axis" ] = "gw_fob_axisHQ";
    level.var_76c4dc73f6b30344[ game[ "switchedsides" ] ? "axis" : "allies" ] = "gw_fob_alliesHQ";
    level.startingfobnames_allies = [];
    level.startingfobnames_axis = [];
    level.startingfobnames_neutral = [ "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05", "gw_fob_06", "gw_fob_07", "gw_fob_08", "gw_fob_09" ];
    level.var_ce7353f26614ab21 = [];
    
    if ( game_utility_mp::isroundbased() )
    {
        level.var_ce7353f26614ab21[ 0 ] = [ "gw_fob_axisHQ", "gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02" ];
        return;
    }
    
    level.var_ce7353f26614ab21[ 0 ] = [ "gw_fob_axisHQ0", "gw_fob_alliesHQ0", "gw_fob_01", "gw_fob_02" ];
    level.var_ce7353f26614ab21[ 1 ] = [ "gw_fob_axisHQ1", "gw_fob_alliesHQ1", "gw_fob_03", "gw_fob_04" ];
    level.var_ce7353f26614ab21[ 2 ] = [ "gw_fob_axisHQ2", "gw_fob_alliesHQ2", "gw_fob_05", "gw_fob_06" ];
}

// Namespace arm
// Params 0
// Checksum 0x2d1af9c9, Offset: 0x32d6
// Size: 0x209
function setuphqs()
{
    level.gw_objstruct = spawnstruct();
    level.gw_objstruct.axishqloc = spawnstruct();
    level.gw_objstruct.allieshqloc = spawnstruct();
    level.gw_objstruct.axishqloc.trigger = game_utility::getlocaleent( level.var_76c4dc73f6b30344[ game[ "switchedsides" ] ? "allies" : "axis" ] );
    level.gw_objstruct.allieshqloc.trigger = game_utility::getlocaleent( level.var_76c4dc73f6b30344[ game[ "switchedsides" ] ? "axis" : "allies" ] );
    
    if ( !isdefined( level.gw_objstruct.axishqloc ) )
    {
        assert( 0, "<dev string:x24>" );
    }
    
    if ( !isdefined( level.gw_objstruct.allieshqloc ) )
    {
        assert( 0, "<dev string:x45>" );
    }
    
    level.spawnselectionteamforward = [];
    level.spawnselectionteamforward[ game[ "switchedsides" ] ? "allies" : "axis" ] = vectornormalize( level.gw_objstruct.allieshqloc.trigger.origin - level.gw_objstruct.axishqloc.trigger.origin );
    level.spawnselectionteamforward[ game[ "switchedsides" ] ? "axis" : "allies" ] = vectornormalize( level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin );
}

// Namespace arm
// Params 1
// Checksum 0x7b8124e8, Offset: 0x34e7
// Size: 0x18b
function exfilflow( newindex )
{
    if ( level.var_15cbe4222c448d68 )
    {
        foreach ( player in level.players )
        {
            player thread showrespawnwarningmessage();
        }
        
        wait 5;
        level thread updaterespawntimer();
    }
    
    level thread function_8e3667cedd323d9f();
    level thread heliexfil();
    wait level.var_c83ebcd6f3aeab1b;
    
    foreach ( player in level.players )
    {
        if ( player.hasexfilled )
        {
            continue;
        }
        
        if ( player::isreallyalive( player ) )
        {
            player.var_99785ac1853ef492 = 1;
            player playerlogic::spawnclient( 0 );
            continue;
        }
        
        player.forcedspawncameraref = "gw_fob_" + player.team + "HQ" + newindex;
        player thread spawncamera::movetospawncamera( 0 );
    }
    
    level thread finishexfil();
}

// Namespace arm
// Params 0
// Checksum 0x9008f8e0, Offset: 0x367a
// Size: 0x333
function heliexfil()
{
    objvector = level.objectives[ "_b" ].trigger.origin - level.objectives[ "_a" ].trigger.origin;
    midpoint = ( level.objectives[ "_b" ].trigger.origin + level.objectives[ "_a" ].trigger.origin ) * 0.5;
    triggerorigins = [];
    triggerorigins[ 0 ] = midpoint;
    triggerorigins[ 1 ] = midpoint - objvector;
    triggerorigins[ 2 ] = midpoint + objvector;
    level.exfiltriggers = [];
    level.exfilsites = [];
    
    foreach ( origin in triggerorigins )
    {
        trigger = spawn( "trigger_radius", origin, 0, 256, 128 );
        level.exfiltriggers[ level.exfiltriggers.size ] = trigger;
        site = spawn( "script_model", origin );
        site setmodel( "dmz_exfil_site_xmodel" );
        level.exfilsites[ level.exfilsites.size ] = site;
    }
    
    foreach ( trigger in level.exfiltriggers )
    {
        marker = {};
        marker.objidnum = objidpoolmanager::requestobjectiveid();
        objidpoolmanager::update_objective_position( marker.objidnum, trigger.origin + ( 0, 0, 200 ) );
        objidpoolmanager::update_objective_state( marker.objidnum, "current" );
        objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
        namespace_1cdb218d68ef13f6::set_objective_icon_state( marker.objidnum, #"team_hq" );
        trigger.marker = marker;
    }
    
    wait 1;
    
    foreach ( site in level.exfilsites )
    {
        site setscriptablepartstate( "dmz_exfil_smoke", "smoking", 0 );
    }
}

// Namespace arm
// Params 0
// Checksum 0x725268c7, Offset: 0x39b5
// Size: 0x188
function finishexfil()
{
    foreach ( site in level.exfilsites )
    {
        site setscriptablepartstate( "dmz_exfil_smoke", "stop", 0 );
    }
    
    wait 5;
    
    foreach ( trigger in level.exfiltriggers )
    {
        objidpoolmanager::returnobjectiveid( trigger.marker.objidnum );
        trigger delete();
    }
    
    foreach ( site in level.exfilsites )
    {
        site delete();
    }
}

// Namespace arm
// Params 0
// Checksum 0x9fb6d021, Offset: 0x3b45
// Size: 0x384
function setupobjectives()
{
    level.gw_objstruct.startingfobs_allies = [];
    level.gw_objstruct.startingfobs_axis = [];
    level.gw_objstruct.startingfobs_neutral = [];
    var_6e96ef3a633c62f3 = [ "_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i" ];
    var_f79a818f3ccf1a46 = 0;
    
    foreach ( fobname in level.startingfobnames_allies )
    {
        fob = spawnstruct();
        fob.name = fobname;
        fob.trigger = game_utility::getlocaleent( fobname );
        fob.trigger.objkey = var_6e96ef3a633c62f3[ var_f79a818f3ccf1a46 ];
        var_f79a818f3ccf1a46++;
        level.gw_objstruct.startingfobs_allies[ level.gw_objstruct.startingfobs_allies.size ] = fob;
    }
    
    foreach ( fobname in level.startingfobnames_axis )
    {
        fob = spawnstruct();
        fob.name = fobname;
        fob.trigger = game_utility::getlocaleent( fobname );
        fob.trigger.objkey = var_6e96ef3a633c62f3[ var_f79a818f3ccf1a46 ];
        var_f79a818f3ccf1a46++;
        level.gw_objstruct.startingfobs_axis[ level.gw_objstruct.startingfobs_axis.size ] = fob;
    }
    
    foreach ( fobname in level.startingfobnames_neutral )
    {
        trigger = game_utility::getlocaleent( fobname );
        
        if ( isdefined( trigger ) )
        {
            fob = spawnstruct();
            fob.name = fobname;
            fob.trigger = trigger;
            fob.trigger.objkey = var_6e96ef3a633c62f3[ var_f79a818f3ccf1a46 ];
            var_f79a818f3ccf1a46++;
            level.gw_objstruct.startingfobs_neutral[ level.gw_objstruct.startingfobs_neutral.size ] = fob;
        }
    }
    
    if ( game_utility_mp::isroundbased() )
    {
        setomnvar( "ui_num_dom_flags", 2 );
        return;
    }
    
    setomnvar( "ui_num_dom_flags", level.gw_objstruct.startingfobs_neutral.size );
}

// Namespace arm
// Params 0
// Checksum 0x99344420, Offset: 0x3ed1
// Size: 0x2e8
function updatedomscores()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    level thread spawnselection::updatefobindanger();
    
    while ( !level.gameended )
    {
        wait level.scoreInterval;
        hostmigration::waittillhostmigrationdone();
        domflags = arm_upgrades::getowneddomflags();
        
        if ( !isdefined( level.scoretick ) )
        {
            level.scoretick = [];
        }
        
        foreach ( entry in level.teamnamelist )
        {
            level.scoretick[ entry ] = 0;
        }
        
        var_d9425977785add8f = [];
        
        foreach ( team in level.teamnamelist )
        {
            var_d9425977785add8f[ team ] = 0;
        }
        
        if ( domflags.size )
        {
            foreach ( domflag in domflags )
            {
                team = gameobjects_shared::function_623b07f4735aecb2( domflag );
                assert( team_utility::isgameplayteam( team ) );
                var_d9425977785add8f[ team ]++;
                
                if ( var_d9425977785add8f[ team ] >= level.flagsrequiredtoscore )
                {
                    if ( level.var_9ed836e326023da5 )
                    {
                        var_3ac424dee51a9b20 = namespace_277c922f0d0dc523::function_6f7e649cce3dd66b( domflag );
                        score = level.pointsperflag;
                        
                        switch ( var_3ac424dee51a9b20 )
                        {
                            case 0:
                            case 1:
                                score = level.pointsperflag;
                                break;
                            case 2:
                                score = level.pointsperflag + 1;
                                break;
                            case 3:
                                score = level.pointsperflag + 2;
                                break;
                        }
                        
                        level.scoretick[ team ] += score;
                        continue;
                    }
                    
                    level.scoretick[ team ] += level.pointsperflag;
                }
            }
        }
        
        updatescores();
    }
}

// Namespace arm
// Params 0
// Checksum 0x110ffed4, Offset: 0x41c1
// Size: 0x1a5
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
    
    var_5bd83029350992ed = gamescore::calculatewinningteam();
    
    foreach ( entry in level.teamnamelist )
    {
        if ( level.scoretick[ entry ] > 0 )
        {
            gamescore::giveteamscoreforobjective( entry, level.scoretick[ entry ], 1, undefined, 1 );
        }
    }
    
    var_b68dc93240b77466 = gamescore::calculatewinningteam();
    
    if ( var_5bd83029350992ed != var_b68dc93240b77466 )
    {
        gamescore::playscorestatusdialog( var_b68dc93240b77466, 1, var_5bd83029350992ed );
    }
}

// Namespace arm
// Params 1
// Checksum 0x2a382ba8, Offset: 0x436e
// Size: 0x56, Type: bool
function checkcustomclosetoscorelimit( team )
{
    assert( isdefined( team ) );
    scorelimit = level.roundscorelimit;
    checkroundlimit = 25;
    var_d262c35ec7ded597 = scorelimit - getteamscore( team );
    
    if ( var_d262c35ec7ded597 <= checkroundlimit )
    {
        return true;
    }
    
    return false;
}

// Namespace arm
// Params 1
// Checksum 0x548cb71, Offset: 0x43cd
// Size: 0x91f
function runobjectives( numobjs )
{
    level.spawnareas = [];
    level.var_3297f3d0b4e2f8da = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.spawnareas[ entry ] = [ level.var_76c4dc73f6b30344[ entry ] ];
        level.var_3297f3d0b4e2f8da[ entry ] = [ level.var_76c4dc73f6b30344[ entry ] ];
    }
    
    level.allfobs = [];
    
    if ( level.useobjectives )
    {
        callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_e119853d3fabcff );
        callback::function_dc654a4d4126a928( #"hash_5d939c5f097361e9", #"hash_6947ec89a1af6d69", &function_122e3ffe86139e33 );
        callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_25287125d0c872fd );
        callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_293e81a992d5bac5 );
        callback::function_dc654a4d4126a928( #"hash_47fedf1df6eafa30", #"hash_6947ec89a1af6d69", &function_decbd018a9bcf78c );
        callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &function_30642aad2c1693ea );
        callback::function_dc654a4d4126a928( #"hash_3aba7df6443df11d", #"hash_6947ec89a1af6d69", &function_856b89ca12a64ee2 );
        callback::function_dc654a4d4126a928( #"hash_2e3e0663aecb6f19", #"hash_6947ec89a1af6d69", &function_d8b39037a002b160 );
        callback::function_dc654a4d4126a928( #"hash_29eede2365f9349a", #"hash_6947ec89a1af6d69", &function_2f53c380c14c079f );
        callback::function_dc654a4d4126a928( #"hash_33ab895f04e4eec9", #"hash_6947ec89a1af6d69", &function_c99c73b22179c9e );
        callback::function_dc654a4d4126a928( #"hash_a836ce9ab43d9e2", #"hash_6947ec89a1af6d69", &function_e0a7fe0601365413 );
        callback::function_dc654a4d4126a928( #"hash_300ad54dcc9beab1", #"hash_6947ec89a1af6d69", &function_d4b22d655a2862b2 );
        callback::function_dc654a4d4126a928( #"hash_629949853fbabab8", #"hash_6947ec89a1af6d69", &function_388e5b690ab13813 );
        callback::function_dc654a4d4126a928( #"hash_e3206e8d5d3df1e3", #"hash_6947ec89a1af6d69", &function_73da63d164186f8e );
        callback::function_dc654a4d4126a928( #"hash_a4277d17a7a228c9", #"hash_6947ec89a1af6d69", &function_f2f9f8568f62caf9 );
        callback::function_dc654a4d4126a928( #"hash_ae8f0f5e3b866b53", #"hash_6947ec89a1af6d69", &function_d22b4b542b3280d3 );
        var_24290c36e2cab388 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_24290c36e2cab388.use_time_seconds = level.flagcapturetime;
        var_24290c36e2cab388.var_333d3689d793bcc7 = level.var_e56cac0580f1c92c ?? level.flagcapturetime;
        
        foreach ( fob in level.gw_objstruct.startingfobs_axis )
        {
            var_6d463f70795a3052 = structcopy( var_24290c36e2cab388 );
            var_6d463f70795a3052.origin = fob.trigger.origin;
            var_6d463f70795a3052.angles = fob.trigger.angles;
            var_6d463f70795a3052.var_7f4958ce4e4277c3 = #"hash_ce911e3bbe99421f";
            gameobjects_common::initialize_game_object( fob.trigger.targetname, var_6d463f70795a3052, fob.trigger, &function_e3085032be92c327, fob.trigger.objkey );
            level.allfobs[ level.allfobs.size ] = fob;
            level.spawnareas[ "axis" ][ level.spawnareas[ "axis" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "axis" ][ level.var_3297f3d0b4e2f8da[ "axis" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "allies" ][ level.var_3297f3d0b4e2f8da[ "allies" ].size ] = fob.name;
        }
        
        foreach ( fob in level.gw_objstruct.startingfobs_allies )
        {
            var_6d463f70795a3052 = structcopy( var_24290c36e2cab388 );
            var_6d463f70795a3052.origin = fob.trigger.origin;
            var_6d463f70795a3052.angles = fob.trigger.angles;
            var_6d463f70795a3052.var_7f4958ce4e4277c3 = #"hash_7118f9343873352b";
            gameobjects_common::initialize_game_object( fob.trigger.targetname, var_6d463f70795a3052, fob.trigger, &function_e3085032be92c327, fob.trigger.objkey );
            level.allfobs[ level.allfobs.size ] = fob;
            level.spawnareas[ "allies" ][ level.spawnareas[ "allies" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "allies" ][ level.var_3297f3d0b4e2f8da[ "allies" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "axis" ][ level.var_3297f3d0b4e2f8da[ "axis" ].size ] = fob.name;
        }
        
        foreach ( fob in level.gw_objstruct.startingfobs_neutral )
        {
            var_6d463f70795a3052 = structcopy( var_24290c36e2cab388 );
            var_6d463f70795a3052.origin = fob.trigger.origin;
            var_6d463f70795a3052.angles = fob.trigger.angles;
            gameobjects_common::initialize_game_object( fob.trigger.targetname, var_6d463f70795a3052, fob.trigger, &function_e3085032be92c327, fob.trigger.objkey );
            level.allfobs[ level.allfobs.size ] = fob;
            level.var_3297f3d0b4e2f8da[ "axis" ][ level.var_3297f3d0b4e2f8da[ "axis" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "allies" ][ level.var_3297f3d0b4e2f8da[ "allies" ].size ] = fob.name;
        }
        
        utility::flag_wait( "gameobject_system_post_init" );
        utility::flag_wait( "gw_game_objects_constructed" );
        waitframe();
    }
    
    if ( level.usespawnselection )
    {
        if ( level.var_3416583522672ad3 )
        {
            spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ "axis" ], "axis" );
            spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ "allies" ], "allies" );
            return;
        }
        
        spawnselection::setspawnlocations( level.spawnareas[ "axis" ], "axis" );
        spawnselection::setspawnlocations( level.spawnareas[ "allies" ], "allies" );
    }
}

// Namespace arm
// Params 0
// Checksum 0x816d0222, Offset: 0x4cf4
// Size: 0x9f
function allowobjectiveuseaftermatchstart()
{
    flags::gameflagwait( "prematch_done" );
    
    foreach ( fob in level.allfobs )
    {
        fob.trigger.gameobject gameobjects::allowuse( "enemy" );
    }
}

// Namespace arm
// Params 0
// Checksum 0x401eec15, Offset: 0x4d9b
// Size: 0x357
function objective_manageobjectivesintrovisibility()
{
    wait 1;
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.axishqloc.marker.objidnum );
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.allieshqloc.marker.objidnum );
    
    foreach ( fob in level.allfobs )
    {
        objidpoolmanager::objective_playermask_hidefromall( fob.trigger.gameobject.objidnum );
    }
    
    if ( isdefined( level.rallypointvehicles ) )
    {
        foreach ( rallypoint in level.rallypointvehicles )
        {
            objidpoolmanager::objective_playermask_hidefromall( rallypoint.marker.objidnum );
        }
    }
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    objidpoolmanager::objective_teammask_addtomask( level.gw_objstruct.axishqloc.marker.objidnum, game[ "switchedsides" ] ? "allies" : "axis" );
    objidpoolmanager::objective_teammask_addtomask( level.gw_objstruct.allieshqloc.marker.objidnum, game[ "switchedsides" ] ? "axis" : "allies" );
    
    foreach ( fob in level.allfobs )
    {
        objidpoolmanager::objective_playermask_showtoall( fob.trigger.gameobject.objidnum );
    }
    
    if ( isdefined( level.rallypointvehicles ) )
    {
        foreach ( rallypoint in level.rallypointvehicles )
        {
            if ( isdefined( rallypoint ) )
            {
                objidpoolmanager::objective_teammask_addtomask( rallypoint.marker.objidnum, rallypoint.team );
            }
        }
    }
}

// Namespace arm
// Params 0
// Checksum 0xc37fd0d9, Offset: 0x50fa
// Size: 0x30f
function hackfixcameras()
{
    if ( level.usestaticspawnselectioncamera )
    {
        return;
    }
    
    while ( !level.var_aeb6f04033bb30b0 )
    {
        waitframe();
    }
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    waitframe();
    team = game[ "switchedsides" ] ? "axis" : "allies";
    forward = level.spawnselectionteamforward[ team ];
    
    if ( game_utility_mp::isroundbased() )
    {
        keys = [ "gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02" ];
    }
    else
    {
        keys = [ "gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05" ];
    }
    
    spawncamera::createOrientedCameras( keys, team, forward, -8500, 7000 );
    team = game[ "switchedsides" ] ? "allies" : "axis";
    forward = level.spawnselectionteamforward[ team ];
    
    if ( game_utility_mp::isroundbased() )
    {
        keys = [ "gw_fob_axisHQ", "gw_fob_01", "gw_fob_02" ];
    }
    else
    {
        keys = [ "gw_fob_axisHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05" ];
    }
    
    spawncamera::createOrientedCameras( keys, team, forward, -8500, 7000 );
    level.spawncameras[ "default" ][ game[ "switchedsides" ] ? "axis" : "allies" ].origin = level.spawncameras[ "gw_fob_alliesHQ" ][ game[ "switchedsides" ] ? "axis" : "allies" ].origin;
    level.spawncameras[ "default" ][ game[ "switchedsides" ] ? "axis" : "allies" ].angles = level.spawncameras[ "gw_fob_alliesHQ" ][ game[ "switchedsides" ] ? "axis" : "allies" ].angles;
    level.spawncameras[ "default" ][ game[ "switchedsides" ] ? "allies" : "axis" ].origin = level.spawncameras[ "gw_fob_axisHQ" ][ game[ "switchedsides" ] ? "allies" : "axis" ].origin;
    level.spawncameras[ "default" ][ game[ "switchedsides" ] ? "allies" : "axis" ].angles = level.spawncameras[ "gw_fob_axisHQ" ][ game[ "switchedsides" ] ? "allies" : "axis" ].angles;
}

// Namespace arm
// Params 0
// Checksum 0xe4036d6a, Offset: 0x5411
// Size: 0x321
function updatefobspawnselection()
{
    level.spawnareas = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.spawnareas[ entry ] = [ level.var_76c4dc73f6b30344[ entry ] ];
    }
    
    foreach ( fob in level.allfobs )
    {
        gameobject = fob.trigger.gameobject;
        
        if ( gameobject.ownerteam == ( game[ "switchedsides" ] ? "allies" : "axis" ) )
        {
            level.spawnareas[ game[ "switchedsides" ] ? "allies" : "axis" ][ level.spawnareas[ game[ "switchedsides" ] ? "allies" : "axis" ].size ] = fob.name;
            continue;
        }
        
        if ( gameobject.ownerteam == ( game[ "switchedsides" ] ? "axis" : "allies" ) )
        {
            level.spawnareas[ game[ "switchedsides" ] ? "axis" : "allies" ][ level.spawnareas[ game[ "switchedsides" ] ? "axis" : "allies" ].size ] = fob.name;
        }
    }
    
    if ( level.var_3416583522672ad3 )
    {
        spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ game[ "switchedsides" ] ? "allies" : "axis" ], game[ "switchedsides" ] ? "allies" : "axis" );
        spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ game[ "switchedsides" ] ? "axis" : "allies" ], game[ "switchedsides" ] ? "axis" : "allies" );
        return;
    }
    
    spawnselection::setspawnlocations( level.spawnareas[ game[ "switchedsides" ] ? "allies" : "axis" ], game[ "switchedsides" ] ? "allies" : "axis" );
    spawnselection::setspawnlocations( level.spawnareas[ game[ "switchedsides" ] ? "axis" : "allies" ], game[ "switchedsides" ] ? "axis" : "allies" );
}

// Namespace arm
// Params 0
// Checksum 0x81e44856, Offset: 0x573a
// Size: 0x21e
function sethqmarkerobjective()
{
    var_5e72c04b7d095966 = {};
    var_5e72c04b7d095966.objidnum = objidpoolmanager::requestobjectiveid();
    level.gw_objstruct.axishqloc.marker = var_5e72c04b7d095966;
    objidpoolmanager::update_objective_position( var_5e72c04b7d095966.objidnum, level.gw_objstruct.axishqloc.trigger.origin );
    objidpoolmanager::update_objective_ownerteam( var_5e72c04b7d095966.objidnum, game[ "switchedsides" ] ? "allies" : "axis" );
    objidpoolmanager::update_objective_state( var_5e72c04b7d095966.objidnum, "current" );
    objidpoolmanager::objective_teammask_addtomask( var_5e72c04b7d095966.objidnum, game[ "switchedsides" ] ? "allies" : "axis" );
    objidpoolmanager::objective_pin_global( var_5e72c04b7d095966.objidnum, 0 );
    var_eb3fa66c4f4e5849 = {};
    var_eb3fa66c4f4e5849.objidnum = objidpoolmanager::requestobjectiveid();
    level.gw_objstruct.allieshqloc.marker = var_eb3fa66c4f4e5849;
    objidpoolmanager::update_objective_position( var_eb3fa66c4f4e5849.objidnum, level.gw_objstruct.allieshqloc.trigger.origin );
    objidpoolmanager::update_objective_ownerteam( var_eb3fa66c4f4e5849.objidnum, game[ "switchedsides" ] ? "axis" : "allies" );
    objidpoolmanager::update_objective_state( var_eb3fa66c4f4e5849.objidnum, "current" );
    objidpoolmanager::objective_teammask_addtomask( var_eb3fa66c4f4e5849.objidnum, game[ "switchedsides" ] ? "axis" : "allies" );
    objidpoolmanager::objective_pin_global( var_eb3fa66c4f4e5849.objidnum, 0 );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( var_5e72c04b7d095966.objidnum, #"team_hq" );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( var_eb3fa66c4f4e5849.objidnum, #"team_hq" );
}

// Namespace arm
// Params 0
// Checksum 0x44733c08, Offset: 0x5960
// Size: 0x28
function objective_oncontested()
{
    obj_dom::dompoint_oncontested();
    
    if ( !self.updatedoncontestedspawnselection )
    {
        updatefobspawnselection();
        self.updatedoncontestedspawnselection = 1;
    }
}

// Namespace arm
// Params 1
// Checksum 0xbfc65fe5, Offset: 0x5990
// Size: 0x32
function objective_onuncontested( lastclaimteam )
{
    obj_dom::dompoint_onuncontested( lastclaimteam );
    
    if ( self.updatedoncontestedspawnselection )
    {
        updatefobspawnselection();
        self.updatedoncontestedspawnselection = 0;
    }
}

// Namespace arm
// Params 1
// Checksum 0xa1c6220, Offset: 0x59ca
// Size: 0x1c
function objective_onusebegin( player )
{
    obj_dom::dompoint_onusebegin( player );
    updatefobspawnselection();
}

// Namespace arm
// Params 3
// Checksum 0xb631a6a8, Offset: 0x59ee
// Size: 0x30
function objective_onuseend( team, player, success )
{
    obj_dom::dompoint_onuseend( team, player, success );
    updatefobspawnselection();
}

// Namespace arm
// Params 1
// Checksum 0x32d10b45, Offset: 0x5a26
// Size: 0x9c
function objective_onuse( claim_player )
{
    obj_dom::dompoint_onuse( claim_player );
    updatefobspawnselection();
    
    if ( level.var_65526c5c4e8f9d90 )
    {
        level thread namespace_14ab7f658b8ad5e4::function_cac6dbdf1966b849( self.objectivekey, self.ownerteam );
    }
    
    otherteam = team_utility::getotherteam( claim_player.team );
    arm_upgrades::function_db60687d3222dcb4( otherteam, self.objectivekey );
    arm_upgrades::function_da6d0f03ca3101ad( self.objectivekey, otherteam );
    arm_upgrades::function_6a2e5bbf85fdef54( self.objectivekey, self.ownerteam );
}

// Namespace arm
// Params 1
// Checksum 0x8c4354a3, Offset: 0x5aca
// Size: 0x1c
function objective_onpinnedstate( player )
{
    updatefobspawnselection();
    obj_dom::dompoint_onunpinnedstate( player );
}

// Namespace arm
// Params 1
// Checksum 0xc870a77a, Offset: 0x5aee
// Size: 0x1c
function objective_onunpinnedstate( player )
{
    updatefobspawnselection();
    obj_dom::dompoint_onunpinnedstate( player );
}

// Namespace arm
// Params 2
// Checksum 0xf83e872f, Offset: 0x5b12
// Size: 0xf4
function runobjflag( objective, startingteam )
{
    level endon( #"game_ended" );
    
    if ( !level.updatedinit )
    {
        while ( !isdefined( level.spawnselectionlocations ) )
        {
            waitframe();
        }
    }
    
    objective.script_label = objective.objkey;
    domflag = obj_dom::setupobjective( objective, undefined, undefined, undefined, 0 );
    domflag.origin = objective.origin;
    domflag gameobjects::allowuse( "none" );
    domflag.didstatusnotify = 0;
    domflag gameobjects::setownerteam( startingteam );
    visibility = "any";
    
    if ( startingteam != "neutral" )
    {
        if ( level.hideenemyfobs )
        {
            visibility = "friendly";
        }
        
        domflag.capturetime = gettime();
    }
    
    domflag gameobjects::setvisibleteam( visibility );
    return domflag;
}

// Namespace arm
// Params 3
// Checksum 0x89001c37, Offset: 0x5c0f
// Size: 0x4b
function dropcrate( killstreakname, droplocation, team )
{
    crate = airdrop::droparmcratefromscriptedheli( team, killstreakname, droplocation.origin, ( 0, randomint( 360 ), 0 ), undefined );
    return crate;
}

// Namespace arm
// Params 3
// Checksum 0x90861814, Offset: 0x5c63
// Size: 0x134
function docratedropsmoke( crate, droplocation, duration )
{
    var_281ff1613bb07988 = droplocation.origin + ( 0, 0, 2000 );
    spawnpos = utility::groundpos( var_281ff1613bb07988, ( 0, 0, 1 ) );
    droplocation.vfxent = spawn( "script_model", spawnpos );
    droplocation.vfxent setmodel( "tag_origin" );
    droplocation.vfxent.angles = ( 0, 0, 0 );
    droplocation.vfxent playloopsound( "smoke_carepackage_smoke_lp" );
    wait 1;
    playfxontag( utility::getfx( "vfx_smk_signal_gr" ), droplocation.vfxent, "tag_origin" );
    
    if ( isdefined( crate ) )
    {
        crate utility::waittill_any_timeout( duration, "crate_dropped" );
    }
    else
    {
        wait duration;
    }
    
    stopfxontag( utility::getfx( "vfx_smk_signal_gr" ), droplocation.vfxent, "tag_origin" );
    droplocation.vfxent delete();
}

// Namespace arm
// Params 0
// Checksum 0x186a23ba, Offset: 0x5d9f
// Size: 0x1ab
function registervaliddroplocations()
{
    airdrop::initplundercratedata();
    level.validdroplocationstruct = spawnstruct();
    level.validdroplocationstruct.clusters = utility::getstructarray( "dropBagClusterNode", "script_noteworthy" );
    potentialdroplocations = utility::getstructarray( "dropBagLocation", "script_noteworthy" );
    
    foreach ( location in potentialdroplocations )
    {
        location.inuse = 0;
        
        foreach ( cluster in level.validdroplocationstruct.clusters )
        {
            if ( location.target == cluster.targetname )
            {
                if ( !isdefined( cluster.droplocations ) )
                {
                    cluster.droplocations = [];
                }
                
                cluster.droplocations[ cluster.droplocations.size ] = location;
            }
        }
    }
    
    level.nextkillstreakgoal = 100;
    
    if ( false )
    {
        thread debug_testcratedroplocationpicker();
    }
}

// Namespace arm
// Params 0
// Checksum 0x13ed9971, Offset: 0x5f52
// Size: 0x14
function debug_testcratedroplocationpicker()
{
    while ( true )
    {
        choosecratelocation();
        wait 1;
    }
}

// Namespace arm
// Params 1
// Checksum 0xbd735912, Offset: 0x5f6e
// Size: 0x41
function checkkillstreakcratedrop( team )
{
    if ( game[ "teamScores" ][ team ] >= level.nextkillstreakgoal )
    {
        level.nextkillstreakgoal += 100;
        dropkillstreakcrates( 2 );
    }
}

// Namespace arm
// Params 1
// Checksum 0x130ce269, Offset: 0x5fb7
// Size: 0xd1
function dropkillstreakcrates( var_c214785f2fc4e656 )
{
    owningplayer = undefined;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            owningplayer = player;
            break;
        }
    }
    
    for ( i = 0; i < var_c214785f2fc4e656 ; i++ )
    {
        location = choosecratelocation();
        thread runkillstreakreward( location, owningplayer, getkillstreak( 1 ) );
        wait 5;
    }
}

// Namespace arm
// Params 0
// Checksum 0xa884a466, Offset: 0x6090
// Size: 0x175
function choosecratelocation()
{
    randfrac = randomfloatrange( 0, 1 );
    var_3d28facc2e2d628a = vectorlerp( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, randfrac );
    var_3d28f9cc2e2d6057 = vectorlerp( level.c130pathstruct_b.endpt, level.c130pathstruct_b.startpt, randfrac );
    var_940651cc6f36caac = vectorlerp( var_3d28facc2e2d628a, var_3d28f9cc2e2d6057, 0.5 );
    trace = trace::ray_trace( var_940651cc6f36caac, var_940651cc6f36caac - ( 0, 0, 100000 ) );
    var_940651cc6f36caac = trace[ "position" ];
    var_ef72f25a3bc4b7f8 = findclosestdroplocation( var_940651cc6f36caac );
    
    if ( false )
    {
        thread debug::drawsphere( var_3d28facc2e2d628a, 1000, 100, ( 0, 0, 1 ) );
        thread debug::drawsphere( var_3d28f9cc2e2d6057, 1000, 100, ( 0, 0, 1 ) );
        thread debug::drawsphere( var_940651cc6f36caac, 1000, 100, ( 1, 0, 0 ) );
        thread debug::drawsphere( var_ef72f25a3bc4b7f8.origin, 1000, 100, ( 0, 1, 0 ) );
        thread debug::drawline( var_940651cc6f36caac, var_ef72f25a3bc4b7f8.origin, 3, ( 0, 1, 0 ) );
    }
    
    return var_ef72f25a3bc4b7f8;
}

// Namespace arm
// Params 1
// Checksum 0x1a2f03b5, Offset: 0x620e
// Size: 0x143
function findclosestdroplocation( origin )
{
    var_a81d35a55404701b = sortbydistance( level.validdroplocationstruct.clusters, origin );
    
    foreach ( cluster in var_a81d35a55404701b )
    {
        var_fa99ddd29deeab6f = arrayrandomize( cluster.droplocations );
        
        if ( false )
        {
            return var_fa99ddd29deeab6f[ 0 ];
        }
        
        foreach ( location in var_fa99ddd29deeab6f )
        {
            if ( !location.inuse )
            {
                location.inuse = 1;
                return location;
            }
        }
    }
}

// Namespace arm
// Params 0
// Checksum 0x180e9167, Offset: 0x635a
// Size: 0x107
function choosenukecratelocation()
{
    randx = randomfloatrange( level.mapsafecorners[ 1 ][ 0 ], level.mapsafecorners[ 0 ][ 0 ] );
    randy = randomfloatrange( level.mapsafecorners[ 1 ][ 1 ], level.mapsafecorners[ 0 ][ 1 ] );
    var_940651cc6f36caac = ( randx, randy, 100000 );
    trace = trace::ray_trace( var_940651cc6f36caac, var_940651cc6f36caac - ( 0, 0, 100000 ) );
    var_940651cc6f36caac = trace[ "position" ];
    var_ef72f25a3bc4b7f8 = findclosestdroplocation( var_940651cc6f36caac );
    
    if ( false )
    {
        thread debug::drawsphere( var_940651cc6f36caac, 1000, 100, ( 1, 0, 0 ) );
        thread debug::drawsphere( var_ef72f25a3bc4b7f8, 1000, 100, ( 0, 1, 0 ) );
        thread debug::drawline( var_940651cc6f36caac, var_ef72f25a3bc4b7f8.origin, 3, ( 0, 1, 0 ) );
    }
    
    return var_ef72f25a3bc4b7f8;
}

// Namespace arm
// Params 3
// Checksum 0x7cce9088, Offset: 0x646a
// Size: 0x246
function runkillstreakreward( location, creditplayer, streakname )
{
    level endon( #"game_ended" );
    crate = undefined;
    object = gameobjects::createobjidobject( location.origin, "neutral", ( 0, 0, 72 ), undefined, "any" );
    object.origin = location.origin;
    object.angles = location.angles;
    thread docratedropsmoke( undefined, location, 16 );
    object.iconname = "_incoming";
    object.lockupdatingicons = 0;
    object gameobjects::setobjectivestatusicons( streakname );
    object.lockupdatingicons = 1;
    wait 4;
    crate = airdrop::droparmcratefromscriptedheli( creditplayer.team, streakname, location.origin, ( 0, randomint( 360 ), 0 ), undefined );
    crate.skipminimapicon = 1;
    crate.nevertimeout = 0;
    crate.waitforobjectiveactivate = 1;
    crate.killminimapicon = 0;
    crate.disallowheadiconid = 1;
    crate.isarmcrate = 1;
    crate waittill( #"crate_dropped" );
    object.useobj = crate;
    object.origin = crate.origin;
    wait 1;
    crate notify( #"objective_activate" );
    objidpoolmanager::update_objective_onentity( object.objidnum, crate );
    objidpoolmanager::update_objective_setzoffset( object.objidnum, 72 );
    object.iconname = "";
    object.lockupdatingicons = 0;
    object gameobjects::setobjectivestatusicons( streakname );
    object.lockupdatingicons = 1;
    objective_setlabel( object.objidnum, "" );
    crate waittill( #"death" );
    object gameobjects::setvisibleteam( "none" );
    object gameobjects::releaseid();
    object.visibleteam = "none";
}

// Namespace arm
// Params 1
// Checksum 0x62500891, Offset: 0x66b8
// Size: 0x4c
function getkillstreak( tier )
{
    if ( !isdefined( level.killstreaktierlist ) )
    {
        processkillstreaksintotiers();
    }
    
    level.killstreaktierlist[ tier ] = arrayrandomize( level.killstreaktierlist[ tier ] );
    return level.killstreaktierlist[ tier ][ 0 ];
}

// Namespace arm
// Params 0
// Checksum 0x87318c7c, Offset: 0x670d
// Size: 0xa6
function processkillstreaksintotiers()
{
    level.killstreaktierlist = [];
    level.killstreaktierlist[ 3 ] = [ "cruise_predator", "scrambler_drone_guard", "uav" ];
    level.killstreaktierlist[ 2 ] = [ "precision_airstrike", "multi_airstrike", "bradley" ];
    level.killstreaktierlist[ 1 ] = [ "toma_strike", "uav", "pac_sentry", "white_phosphorus" ];
    level.killstreaktierlist[ 0 ] = [ "uav" ];
}

// Namespace arm
// Params 1
// Checksum 0x21f8569f, Offset: 0x67bb
// Size: 0x54
function br_getrewardicon( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( isdefined( bundle ) && isdefined( bundle.hudicon ) )
    {
        return bundle.hudicon;
    }
    
    return "";
}

// Namespace arm
// Params 0
// Checksum 0xa34c2dd8, Offset: 0x6818
// Size: 0x22
function nuke_mercyending_init()
{
    flags::gameflagwait( "prematch_done" );
    
    if ( level.useobjectives )
    {
        level thread nuke_mercyending_think();
    }
}

// Namespace arm
// Params 0
// Checksum 0x76c63752, Offset: 0x6842
// Size: 0x72
function nuke_mercyending_think()
{
    level endon( #"game_ended" );
    level endon( #"hash_f820681d2ed0d10f" );
    
    while ( true )
    {
        if ( calculateobjectivesheld( "axis" ) == level.objectives.size )
        {
            level thread nuke_startmercycountdown( "axis" );
        }
        else if ( calculateobjectivesheld( "allies" ) == level.objectives.size )
        {
            level thread nuke_startmercycountdown( "allies" );
        }
        
        waitframe();
    }
}

// Namespace arm
// Params 1
// Checksum 0x2b2e436a, Offset: 0x68bc
// Size: 0x13e
function nuke_startmercycountdown( team )
{
    level notify( #"hash_f820681d2ed0d10f" );
    level endon( #"hash_71fa673dc344f809" );
    setomnvar( "ui_nuke_timer_type", 1 );
    setomnvar( "ui_arm_dominatingTeam", team == "axis" ? 1 : 2 );
    setomnvar( "ui_nuke_timer_time", level.mercymatchending_time );
    setomnvar( "ui_nuke_countdown_active", 1 );
    starttime = gettime();
    endtime = level.mercymatchending_time * 1000 + starttime;
    setomnvar( "ui_nuke_end_milliseconds", level.mercymatchending_time * 1000 + starttime );
    
    if ( isdefined( level.nukeinfo.player ) )
    {
        setomnvar( "ui_nuke_player_id", level.nukeinfo.player getentitynumber() );
    }
    
    while ( calculateobjectivesheld( team ) == level.objectives.size )
    {
        waitframe();
        
        if ( gettime() > endtime )
        {
            nuke_triggermercywin( team );
            level notify( #"hash_71fa673dc344f809" );
            setomnvar( "ui_nuke_countdown_active", 0 );
        }
    }
    
    setomnvar( "ui_nuke_countdown_active", 0 );
    level thread nuke_mercyending_think();
}

// Namespace arm
// Params 1
// Checksum 0x4a5d3cc8, Offset: 0x6a02
// Size: 0x20f
function nuke_triggermercywin( team )
{
    level endon( #"game_ended" );
    level.mercywintriggered = 1;
    level.blocknukekills = 1;
    
    foreach ( objective in level.objectives )
    {
        objective gameobjects::allowuse( "none" );
    }
    
    setomnvar( "ui_nuke_countdown_active", 0 );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && !isbot( player ) && player.inspawnselection )
        {
            if ( isdefined( player.operatorsfx ) )
            {
                player clearsoundsubmix( "iw8_mp_spawn_camera" );
                player.operatorsfx stoploopsound( player.operatorsfxalias );
                player.operatorsfx delete();
                player.operatorsfx = undefined;
                player.operatorsfxalias = undefined;
            }
        }
    }
    
    if ( isdefined( level.teamdata[ team ][ "alivePlayers" ][ 0 ] ) )
    {
        var_78e28e74ac1a8348 = level.teamdata[ team ][ "alivePlayers" ][ 0 ];
        var_78e28e74ac1a8348 nuke::tryusenuke( "nuke_multi" );
        return;
    }
    
    level thread gamelogic_mp::endgame( team, game[ "end_reason" ][ "mercy_win" ], game[ "end_reason" ][ "mercy_loss" ], 0, 1 );
}

// Namespace arm
// Params 1
// Checksum 0x27da710e, Offset: 0x6c19
// Size: 0x8b
function nukeselectgimmewatcher( killer )
{
    if ( !killer.hasnukeselectks )
    {
        remainder = killer.killcountthislife % level.killstoearnnukeselect;
        
        if ( remainder >= 0 && killer.killcountthislife >= level.killstoearnnukeselect )
        {
            killer.hasnukeselectks = 1;
            killer thread killstreaks::givekillstreak( "nuke_select_location", 0, 0 );
            killer hud_message::showkillstreaksplash( "nuke_select_location", undefined, 1 );
        }
    }
}

// Namespace arm
// Params 1
// Checksum 0x7b6b2da, Offset: 0x6cac
// Size: 0xc28
function initspawns( var_ac03d2bf36c55e04 )
{
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        readycount = 3;
        
        if ( game_utility_mp::isroundbased() )
        {
            readycount = 2;
        }
        
        while ( level.objectives.size < readycount )
        {
            waitframe();
        }
        
        waitframe();
        spawnlogic::function_3a25709674572ad6( #"start", #"start_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ] );
        spawnlogic::function_3a25709674572ad6( #"start", #"start_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ] );
        spawnlogic::function_3a25709674572ad6( #"primary", #"primary_attackers", spawnkey, "start_attacker", game[ "attackers" ] );
        spawnlogic::function_3a25709674572ad6( #"primary", #"primary_defenders", spawnkey, "start_defender", game[ "defenders" ] );
        
        if ( game_utility_mp::isroundbased() )
        {
            spawnlogic::function_3a25709674572ad6( #"hq", #"hq_attacker", spawnkey, "hq_attacker", game[ "attackers" ] );
            spawnlogic::function_3a25709674572ad6( #"hq", #"hq_defender", spawnkey, "hq_defender", game[ "defenders" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_1", #"hash_b1d5379091af3984", spawnkey, "fob1_attacker", game[ "attackers" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_1", #"hash_fe0cd6af57f63c70", spawnkey, "fob1_defender", game[ "defenders" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_2", #"hash_e2ddeb514ddbf2db", spawnkey, "fob2_attacker", game[ "attackers" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_2", #"hash_78fabe9d744550e3", spawnkey, "fob2_defender", game[ "defenders" ] );
        }
        else
        {
            spawnlogic::function_3a25709674572ad6( #"hq", #"hq_attacker", spawnkey, "hq_attacker", game[ "attackers" ] );
            spawnlogic::function_3a25709674572ad6( #"hq", #"hq_defender", spawnkey, "hq_defender", game[ "defenders" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_1", #"hash_b1d5379091af3984", spawnkey, "fob1_attacker", game[ "attackers" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_1", #"hash_fe0cd6af57f63c70", spawnkey, "fob1_defender", game[ "defenders" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_2", #"hash_e2ddeb514ddbf2db", spawnkey, "fob2_attacker", game[ "attackers" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_2", #"hash_78fabe9d744550e3", spawnkey, "fob2_defender", game[ "defenders" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_3", #"hash_e5ec9291a3dbcf7a", spawnkey, "fob3_attacker", game[ "attackers" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_3", #"hash_8452261841db8836", spawnkey, "fob3_defender", game[ "defenders" ] );
            spawnlogic::function_3a25709674572ad6( #"fob_4", #"hash_f3848d8a25812f19", spawnkey, "fob4_attacker", game[ "attackers" ], 1 );
            spawnlogic::function_3a25709674572ad6( #"fob_4", #"hash_941e4f7dfd79dcd9", spawnkey, "fob4_defender", game[ "defenders" ], 1 );
            spawnlogic::function_3a25709674572ad6( #"fob_5", #"hash_79c5b45e6623d8b0", spawnkey, "fob5_attacker", game[ "attackers" ], 1 );
            spawnlogic::function_3a25709674572ad6( #"fob_5", #"hash_7d9ddaff715e44c", spawnkey, "fob5_defender", game[ "defenders" ], 1 );
        }
        
        if ( game[ "attackers" ] == ( game[ "switchedsides" ] ? "allies" : "axis" ) )
        {
            var_ec30a82b3dd5b256 = level.gw_objstruct.axishqloc.trigger;
            var_e5fd603f6c1ccdda = level.gw_objstruct.allieshqloc.trigger;
            var_fb4ca4c3d86927df = "gw_fob_axisHQ";
            var_ca4a807cb5077b3 = "gw_fob_alliesHQ";
        }
        else
        {
            var_ec30a82b3dd5b256 = level.gw_objstruct.allieshqloc.trigger;
            var_e5fd603f6c1ccdda = level.gw_objstruct.axishqloc.trigger;
            var_fb4ca4c3d86927df = "gw_fob_alliesHQ";
            var_ca4a807cb5077b3 = "gw_fob_axisHQ";
        }
        
        if ( game_utility_mp::isroundbased() )
        {
            spawnselection::function_a94137c3c19e4581( #"hq", var_fb4ca4c3d86927df, undefined, game[ "attackers" ], var_ec30a82b3dd5b256.origin, ( 0, 0, 75 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_1", "gw_fob_01", "_a", game[ "attackers" ], level.objectives[ "_a" ].trigger.origin, ( 0, 0, 75 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_2", "gw_fob_02", "_b", game[ "attackers" ], level.objectives[ "_b" ].trigger.origin, ( 0, 0, 75 ) );
            spawnselection::function_a94137c3c19e4581( #"hq", var_ca4a807cb5077b3, undefined, game[ "defenders" ], var_e5fd603f6c1ccdda.origin, ( 0, 0, 75 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_1", "gw_fob_01", "_a", game[ "defenders" ], level.objectives[ "_a" ].trigger.origin, ( 0, 0, 75 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_2", "gw_fob_02", "_b", game[ "defenders" ], level.objectives[ "_b" ].trigger.origin, ( 0, 0, 75 ) );
        }
        else
        {
            spawnselection::function_a94137c3c19e4581( #"hq", var_fb4ca4c3d86927df, undefined, game[ "attackers" ], var_ec30a82b3dd5b256.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_1", "gw_fob_01", "_a", game[ "attackers" ], level.objectives[ "_a" ].trigger.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_2", "gw_fob_02", "_b", game[ "attackers" ], level.objectives[ "_b" ].trigger.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_3", "gw_fob_03", "_c", game[ "attackers" ], level.objectives[ "_c" ].trigger.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_4", "gw_fob_04", "_d", game[ "attackers" ], level.objectives[ "_d" ].trigger.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_5", "gw_fob_05", "_e", game[ "attackers" ], level.objectives[ "_e" ].trigger.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"hq", var_ca4a807cb5077b3, undefined, game[ "defenders" ], var_e5fd603f6c1ccdda.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_1", "gw_fob_01", "_a", game[ "defenders" ], level.objectives[ "_a" ].trigger.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_2", "gw_fob_02", "_b", game[ "defenders" ], level.objectives[ "_b" ].trigger.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_3", "gw_fob_03", "_c", game[ "defenders" ], level.objectives[ "_c" ].trigger.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_4", "gw_fob_04", "_d", game[ "defenders" ], level.objectives[ "_d" ].trigger.origin, ( 0, 0, 100 ) );
            spawnselection::function_a94137c3c19e4581( #"fob_5", "gw_fob_05", "_e", game[ "defenders" ], level.objectives[ "_e" ].trigger.origin, ( 0, 0, 100 ) );
        }
    }
    else
    {
        level.gamemodestartspawnpointnames = [];
        
        if ( var_ac03d2bf36c55e04 )
        {
            var_8e0b555d6a1fce7c = "mp_gw_spawn_allies_start";
            var_ce31d0f10d5f8fab = "mp_gw_spawn_axis_start";
            var_19bc72a7d53cad1c = spawnlogic::getspawnpointarray( "mp_gw_spawn_allies_start_mod" );
            
            if ( var_19bc72a7d53cad1c.size > 0 )
            {
                var_8e0b555d6a1fce7c = "mp_gw_spawn_allies_start_mod";
            }
            
            var_159c53d1db1f6985 = spawnlogic::getspawnpointarray( "mp_gw_spawn_axis_start_mod" );
            
            if ( var_159c53d1db1f6985.size > 0 )
            {
                var_ce31d0f10d5f8fab = "mp_gw_spawn_axis_start_mod";
            }
        }
        else
        {
            var_8e0b555d6a1fce7c = "mp_gw_spawn_allies_start";
            var_ce31d0f10d5f8fab = "mp_gw_spawn_axis_start";
        }
        
        level.gamemodestartspawnpointnames[ game[ "switchedsides" ] ? "axis" : "allies" ] = var_8e0b555d6a1fce7c;
        level.gamemodestartspawnpointnames[ game[ "switchedsides" ] ? "allies" : "axis" ] = var_ce31d0f10d5f8fab;
        level.gamemodespawnpointnames = [];
        level.gamemodespawnpointnames[ "allies" ] = "mp_tdm_spawn";
        level.gamemodespawnpointnames[ "axis" ] = "mp_tdm_spawn";
        spawnlogic::setactivespawnlogic( #"default" );
        spawnlogic::addstartspawnpoints( var_8e0b555d6a1fce7c );
        spawnlogic::addstartspawnpoints( var_ce31d0f10d5f8fab );
        spawnlogic::addspawnpointslegacy( game[ "attackers" ], var_8e0b555d6a1fce7c );
        spawnlogic::addspawnpointslegacy( game[ "defenders" ], var_ce31d0f10d5f8fab );
        attackers = spawnlogic::getspawnpointarray( var_8e0b555d6a1fce7c );
        defenders = spawnlogic::getspawnpointarray( var_ce31d0f10d5f8fab );
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
        level.spawnpoints = spawns;
    }
    
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::finalizemap();
}

// Namespace arm
// Params 0
// Checksum 0x76cfcdf9, Offset: 0x78dc
// Size: 0x122
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    
    if ( spawnlogic::shoulduseteamstartspawn() )
    {
        if ( spawnteam == game[ "attackers" ] )
        {
            spawnlogic::activatespawnset( #"start_attackers", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_attackers" );
        }
        else
        {
            spawnlogic::activatespawnset( #"start_defenders", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_defenders" );
        }
    }
    else
    {
        spawnlogic::activatespawnset( #"primary", 1 );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"fallback" );
    }
    
    if ( level.usesquadspawn && self.squadspawnconfirmed )
    {
        spectatingteammate = self getspectatingplayer();
        
        if ( isdefined( spectatingteammate ) && self.team == spectatingteammate.team && self.sessionsquadid == spectatingteammate.sessionsquadid )
        {
            spawnpoint = spawnscoring::findteammatebuddyspawn( spectatingteammate );
        }
    }
    
    return spawnpoint;
}

// Namespace arm
// Params 1
// Checksum 0x3fe76c29, Offset: 0x7a07
// Size: 0x3d
function onspawnplayer( revivespawn )
{
    self.forcespawnnearteammates = undefined;
    thread updatematchstatushintonspawn();
    cash::function_3909082084ad6974();
    squads::updatesquadomnvars( self.team, self.sessionsquadid );
}

// Namespace arm
// Params 0
// Checksum 0xae571a69, Offset: 0x7a4c
// Size: 0x3e
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.nukeprogress ) )
    {
        hud_message::function_ef4318a0090caa0f( #"nuke_capture" );
        return;
    }
    
    hud_message::function_ef4318a0090caa0f( #"dom_cap_defend" );
}

// Namespace arm
// Params 1
// Checksum 0xdd601416, Offset: 0x7a92
// Size: 0x20f
function function_8314535b81f548e( deathdata )
{
    einflictor = deathdata.inflictor;
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    idamage = deathdata.damage;
    smeansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    vdir = deathdata.direction_vec;
    shitloc = deathdata.hitloc;
    psoffsettime = deathdata.psoffsettime;
    deathanimduration = deathdata.deathanimduration;
    killid = deathdata.lifeid;
    victim squads::updatesquadomnvars( victim.team, victim.sessionsquadid );
    victim obj_dom::awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    
    if ( level.dropbrloot )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        dropstruct.dropidx = 14;
        victim br_plunder::playerdropplunderondeath( dropstruct, attacker, 1 );
    }
    
    if ( level.nukeselectactive && isplayer( attacker ) && smeansofdeath != "MOD_SUICIDE" )
    {
        if ( !attacker.hasnukeselectks )
        {
            if ( !isdefined( attacker.killcountthislife ) )
            {
                attacker.killcountthislife = 0;
            }
            
            attacker.killcountthislife++;
        }
        
        nukeselectgimmewatcher( attacker );
    }
    
    if ( !isdefined( level.c130pathkilltracker ) || level.c130movementmethod != 1 )
    {
        return;
    }
    
    level.c130pathkilltracker[ victim.team ] += 1;
}

// Namespace arm
// Params 1
// Checksum 0x547c3e63, Offset: 0x7ca9
// Size: 0x238
function managedroppedents( droppedents )
{
    if ( !isdefined( level.br_droppedloot ) )
    {
        level.br_droppedloot = [];
    }
    
    if ( level.br_droppedloot.size > 64 )
    {
        for ( i = 0; i < 16 ; i++ )
        {
            if ( isdefined( level.br_droppedloot[ i ] ) )
            {
                level.br_droppedloot[ i ] delete();
                level.br_droppedloot[ i ] = undefined;
            }
        }
        
        temparray = [];
        
        for ( i = 16; i < level.br_droppedloot.size ; i++ )
        {
            temparray[ i - 16 ] = level.br_droppedloot[ i ];
        }
        
        level.br_droppedloot = temparray;
    }
    
    foreach ( ent in droppedents )
    {
        level.br_droppedloot[ level.br_droppedloot.size ] = ent;
    }
    
    if ( !isdefined( level.br_pickups.droppeditems ) )
    {
        level.br_pickups.droppeditems = [];
    }
    
    if ( level.br_pickups.droppeditems.size > 64 )
    {
        for ( i = 0; i < 16 ; i++ )
        {
            if ( isdefined( level.br_pickups.droppeditems[ i ] ) )
            {
                level.br_pickups.droppeditems[ i ] delete();
                level.br_pickups.droppeditems[ i ] = undefined;
            }
        }
        
        temparray = [];
        
        for ( i = 16; i < level.br_pickups.droppeditems.size ; i++ )
        {
            temparray[ i - 16 ] = level.br_pickups.droppeditems[ i ];
        }
        
        level.br_pickups.droppeditems = temparray;
    }
}

// Namespace arm
// Params 1
// Checksum 0x60c80aaa, Offset: 0x7ee9
// Size: 0x2e
function onplayerconnect( player )
{
    if ( isdefined( level.rallypointvehicles ) )
    {
        thread rally_point::rallypoint_showtoplayer( player );
    }
    
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
}

// Namespace arm
// Params 1
// Checksum 0xfd6296f0, Offset: 0x7f1f
// Size: 0xc
function onplayerdisconnect( player )
{
    
}

// Namespace arm
// Params 0
// Checksum 0x15654275, Offset: 0x7f33
// Size: 0x7b
function updategamemodespawncamera()
{
    activezonename = "lane02_4";
    
    if ( isdefined( level.activezone ) )
    {
        activezonename = level.activezone.zonetrigger.script_label;
    }
    
    spawncamera::setgamemodecamera( "allies", level.spawncameras[ activezonename ][ "allies" ] );
    spawncamera::setgamemodecamera( "axis", level.spawncameras[ activezonename ][ "axis" ] );
}

// Namespace arm
// Params 0
// Checksum 0xafbf22b4, Offset: 0x7fb6
// Size: 0x162
function debugdrawtocameras()
{
    while ( true )
    {
        wait 0.25;
        
        if ( !isdefined( level.players[ 0 ] ) )
        {
            continue;
        }
        
        foreach ( teamarray in level.spawncameras )
        {
            foreach ( team, camera in teamarray )
            {
                thread debug::drawangles( camera.origin, camera.angles, 0.25, 50 );
                thread debug::drawsphere( camera.origin, 50, 0.25, team == "allies" ? ( 0, 0, 1 ) : ( 1, 0, 0 ) );
            }
        }
    }
}

// Namespace arm
// Params 1
// Checksum 0xa830d84c, Offset: 0x8120
// Size: 0x22
function onplayerspawned( player )
{
    while ( true )
    {
        player waittill( #"spawned" );
    }
}

// Namespace arm
// Params 0
// Checksum 0xaf9800f5, Offset: 0x814a
// Size: 0x60
function updaterespawntimer()
{
    starttime = gettime();
    currenttime = starttime;
    endtime = starttime + level.var_c83ebcd6f3aeab1b * 1000;
    
    while ( currenttime < endtime )
    {
        currenttime = gettime();
        level.spawndelay = ( endtime - currenttime ) / 1000 + 0.1;
        waitframe();
    }
}

// Namespace arm
// Params 0
// Checksum 0xb5a6a92c, Offset: 0x81b2
// Size: 0x13f
function function_8e3667cedd323d9f()
{
    timer = int( level.var_c83ebcd6f3aeab1b );
    
    while ( timer > 0 )
    {
        foreach ( player in level.players )
        {
            if ( player::isreallyalive( player ) )
            {
                if ( timer == 5 )
                {
                    game_utility::fadetoblackforplayerkeepui( player, 1, 3 );
                }
                
                player setclientomnvar( "ui_match_start_countdown", timer );
            }
        }
        
        timer--;
        wait 1;
    }
    
    foreach ( player in level.players )
    {
        game_utility::fadetoblackforplayerkeepui( player, 0, 0 );
    }
}

// Namespace arm
// Params 0
// Checksum 0xf64cb1b7, Offset: 0x82f9
// Size: 0x26
function getrespawndelay()
{
    if ( level.exfilpoi )
    {
        return level.spawndelay;
    }
    
    self.spawncameraskipthermal = 0;
    return;
}

// Namespace arm
// Params 0
// Checksum 0xd99a5b91, Offset: 0x8327
// Size: 0x35
function showrespawnwarningmessage()
{
    self endon( #"death_or_disconnect" );
    self setclientomnvar( "ui_hq_norespawn", 1 );
    self playlocalsound( "mp_hq_respawn_disabled" );
    wait 5;
    self setclientomnvar( "ui_hq_norespawn", 0 );
}

// Namespace arm
// Params 6
// Checksum 0xcb9daba1, Offset: 0x8364
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace arm
// Params 0
// Checksum 0x6de24962, Offset: 0x83b4
// Size: 0x18a
function initspecatatorcameras()
{
    level.spectatorcameras = [];
    level.currentspectatorcamref = "cop_2";
    configstructs = utility::getstructarray( "tac_ops_map_config", "targetname" );
    
    foreach ( configstruct in configstructs )
    {
        configref = configstruct.script_noteworthy;
        childstructs = utility::getstructarray( configstruct.target, "targetname" );
        
        foreach ( childstruct in childstructs )
        {
            switch ( childstruct.script_label )
            {
                case #"hash_11e1630c6c429f23":
                    setteammapposition( configref, "allies", childstruct );
                    break;
                case #"hash_e66f1db565904926":
                    setteammapposition( configref, "axis", childstruct );
                    break;
            }
        }
    }
}

// Namespace arm
// Params 3
// Checksum 0xbe16da5f, Offset: 0x8546
// Size: 0x4b
function setteammapposition( configref, team, posinfo )
{
    if ( !isdefined( level.spectatorcameras[ configref ] ) )
    {
        level.spectatorcameras[ configref ] = [];
    }
    
    level.spectatorcameras[ configref ][ team ] = posinfo;
}

// Namespace arm
// Params 0
// Checksum 0x5d9d77f0, Offset: 0x8599
// Size: 0x20
function applythermal()
{
    if ( !level.updatedinit )
    {
        self visionsetthermalforplayer( "proto_apache_flir_mp" );
        self thermalvisionon();
    }
}

// Namespace arm
// Params 0
// Checksum 0xc4271753, Offset: 0x85c1
// Size: 0x15
function removethermal()
{
    if ( !level.updatedinit )
    {
        self thermalvisionoff();
    }
}

// Namespace arm
// Params 0
// Checksum 0xc162d6dc, Offset: 0x85de
// Size: 0x105
function startspectatorview()
{
    if ( game_utility_mp::isteamreviveenabled() )
    {
        return;
    }
    
    waitframe();
    player::updatesessionstate( "spectator" );
    spectating::setdisabled();
    
    if ( isdefined( self.lastdeathangles ) )
    {
        self setplayerangles( self.lastdeathangles );
    }
    
    wait 0.1;
    player::setdof_default();
    zoffset = 1000;
    var_b371bf092c77fda3 = self.origin + ( 0, 0, zoffset );
    var_9149918291092f13 = self.angles;
    self.deathspectatepos = var_b371bf092c77fda3;
    self.deathspectateangles = var_9149918291092f13;
    cameraent = spawn( "script_model", self getvieworigin() );
    cameraent setmodel( "tag_origin" );
    cameraent.angles = var_9149918291092f13;
    self.spectatorcament = cameraent;
    self.isusingtacopsmapcamera = 1;
    self cameralinkto( cameraent, "tag_origin", 1 );
    thread dohalfwayflash();
    cameraent movecameratomappos( self, var_b371bf092c77fda3, var_9149918291092f13 );
}

// Namespace arm
// Params 0
// Checksum 0x65771ee2, Offset: 0x86eb
// Size: 0x16
function dohalfwayflash()
{
    wait 0.4;
    thread playslamzoomflash();
    applythermal();
}

// Namespace arm
// Params 0
// Checksum 0xc8ca271d, Offset: 0x8709
// Size: 0x1f
function endspectatorview()
{
    if ( !isdefined( self.spectatorcament ) )
    {
        return;
    }
    
    removethermal();
    thread runslamzoomonspawn();
}

// Namespace arm
// Params 3
// Checksum 0x872eab1f, Offset: 0x8730
// Size: 0xef
function movecameratomappos( player, var_9956298e86821c5a, finalangles )
{
    player endon( #"spawned_player" );
    self moveto( var_9956298e86821c5a, 2, 1, 1 );
    player playlocalsound( "mp_cmd_camera_zoom_out" );
    player setclienttriggeraudiozonepartialwithfade( "spawn_cam", 0.5, "mix" );
    self rotateto( finalangles, 2, 1, 1 );
    wait 1.1;
    driftoffset = anglestoforward( finalangles ) * 300;
    driftoffset *= ( 1, 1, 0 );
    
    if ( isdefined( player ) && isdefined( player.spectatorcament ) )
    {
        self moveto( var_9956298e86821c5a + driftoffset, 15, 1, 1 );
        player earthquakeforplayer( 0.03, 15, var_9956298e86821c5a + driftoffset, 1000 );
    }
}

// Namespace arm
// Params 0
// Checksum 0x6ea9cfdd, Offset: 0x8827
// Size: 0xea
function runslamzoomonspawn()
{
    self waittill( #"spawned_player" );
    targetpos = self geteye();
    targetangles = self.angles;
    player::updatesessionstate( "spectator" );
    self cameralinkto( self.spectatorcament, "tag_origin", 1 );
    self visionsetnakedforplayer( "tac_ops_slamzoom", 0.2 );
    self.spectatorcament moveto( targetpos, 0.5 );
    self playlocalsound( "mp_cmd_camera_zoom_in" );
    self clearclienttriggeraudiozone( 0.5 );
    self.spectatorcament rotateto( targetangles, 0.5, 0.5 );
    wait 0.5;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self visionsetnakedforplayer( "", 0 );
    thread playslamzoomflash();
    player::updatesessionstate( "playing" );
    self cameraunlink();
    self.spectatorcament delete();
}

// Namespace arm
// Params 0
// Checksum 0xc3b374f7, Offset: 0x8919
// Size: 0xd7
function playslamzoomflash()
{
    overlay = newclienthudelem( self );
    overlay.x = 0;
    overlay.y = 0;
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = 1;
    overlay.foreground = 1;
    overlay setshader( "white", 640, 480 );
    overlay fadeovertime( 0.4 );
    overlay.alpha = 0;
    wait 0.4;
    overlay destroy();
}

// Namespace arm
// Params 0
// Checksum 0x4407e263, Offset: 0x89f8
// Size: 0x1da
function arm_initoutofbounds()
{
    level.outofboundstriggers = [];
    potentialoobtriggers = getentarray( "OutOfBounds", #targetname );
    
    foreach ( trigger in potentialoobtriggers )
    {
        if ( trigger.var_35de086b67d27219 )
        {
            level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
            continue;
        }
        
        if ( ( game_utility::getgametype() == "sd" || game_utility::getgametype() == "rescue" || game_utility::getgametype() == "cyber" ) && trigger.classname == "trigger_rotatable_radius" )
        {
            level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
            continue;
        }
        
        if ( isdefined( game_utility::getlocaleid() ) && isdefined( trigger.script_noteworthy ) && trigger.script_noteworthy == game_utility::getlocaleid() && game_utility_mp::modeusesgroundwarteamoobtriggers( trigger ) )
        {
            level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
            continue;
        }
        
        if ( level.mapname == "mp_nogales_gw2" && ispointinvolume( ( 20500, 31700, 2500 ), trigger ) && distancesquared( ( 14038, 35144, 4608 ), trigger.origin ) < 100 )
        {
            level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
            continue;
        }
        
        trigger delete();
    }
}

/#

    // Namespace arm
    // Params 1
    // Checksum 0xae9f272d, Offset: 0x8bda
    // Size: 0x1a, Type: dev
    function debugprint( text )
    {
        if ( false )
        {
            println( text );
        }
    }

#/

// Namespace arm
// Params 1
// Checksum 0xa9b10c23, Offset: 0x8bfc
// Size: 0x5f
function isobjectivecontested( gameobject )
{
    if ( gameobject.ownerteam == "axis" )
    {
        return ( gameobject.numtouching[ "allies" ] > 0 );
    }
    
    if ( gameobject.ownerteam == "allies" )
    {
        return ( gameobject.numtouching[ "axis" ] > 0 );
    }
}

// Namespace arm
// Params 1
// Checksum 0xdd2c424, Offset: 0x8c63
// Size: 0x9d
function calculateobjectivesheld( team )
{
    var_e75a27fd127b284f = 0;
    
    foreach ( objective in level.objectives )
    {
        if ( objective.ownerteam == team )
        {
            var_e75a27fd127b284f++;
        }
    }
    
    return var_e75a27fd127b284f;
}

// Namespace arm
// Params 12
// Checksum 0x52aa0ee9, Offset: 0x8d09
// Size: 0x1c2
function createhintobject( org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, useent )
{
    hintobj = undefined;
    
    if ( isdefined( useent ) )
    {
        hintobj = useent;
    }
    else
    {
        hintobj = spawn( "script_model", org );
    }
    
    hintobj makeusable();
    
    if ( isdefined( useent ) && isdefined( org ) )
    {
        assert( isstring( org ), "<dev string:x68>" );
        hintobj sethinttag( org );
    }
    
    if ( isdefined( type ) )
    {
        hintobj setcursorhint( type );
    }
    else
    {
        hintobj setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( icon ) )
    {
        hintobj sethinticon( icon );
    }
    
    if ( isdefined( hintstring ) )
    {
        hintobj sethintstring( hintstring );
    }
    
    if ( isdefined( priority ) )
    {
        hintobj setusepriority( priority );
    }
    else
    {
        hintobj setusepriority( 0 );
    }
    
    if ( isdefined( duration ) )
    {
        hintobj setuseholdduration( duration );
    }
    else
    {
        hintobj setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( onobstruction ) )
    {
        hintobj sethintonobstruction( onobstruction );
    }
    else
    {
        hintobj sethintonobstruction( "hide" );
    }
    
    if ( isdefined( hintdist ) )
    {
        hintobj sethintdisplayrange( hintdist );
    }
    else
    {
        hintobj sethintdisplayrange( 200 );
    }
    
    if ( isdefined( hintfov ) )
    {
        hintobj sethintdisplayfov( hintfov );
    }
    else
    {
        hintobj sethintdisplayfov( 160 );
    }
    
    if ( isdefined( usedist ) )
    {
        hintobj setuserange( usedist );
    }
    else
    {
        hintobj setuserange( 50 );
    }
    
    if ( isdefined( usefov ) )
    {
        hintobj setusefov( usefov );
    }
    else
    {
        hintobj setusefov( 120 );
    }
    
    if ( !isdefined( useent ) )
    {
        return hintobj;
    }
}

/#

    // Namespace arm
    // Params 0
    // Checksum 0xba4db620, Offset: 0x8ed3
    // Size: 0x541, Type: dev
    function function_662cf4c1bdb0bdc3()
    {
        setdevdvar( @"hash_24d9f7f9324e9c61", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_24d9f7f9324e9c61" ) != 0 )
            {
                if ( isdefined( level.lane_1_obj_struct ) )
                {
                    foreach ( cluster in level.lane_1_obj_struct.clustertriggers )
                    {
                        foreach ( objective in cluster.domobjectives )
                        {
                            thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                        }
                    }
                }
                
                if ( isdefined( level.lane_2_obj_struct ) )
                {
                    foreach ( cluster in level.lane_2_obj_struct.clustertriggers )
                    {
                        foreach ( objective in cluster.domobjectives )
                        {
                            thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                        }
                    }
                }
                
                if ( isdefined( level.lane_3_obj_struct ) )
                {
                    foreach ( cluster in level.lane_3_obj_struct.clustertriggers )
                    {
                        foreach ( objective in cluster.domobjectives )
                        {
                            thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                        }
                    }
                }
                
                if ( isdefined( level.tdmzones[ "<dev string:xc5>" ] ) )
                {
                    foreach ( objective in level.tdmzones[ "<dev string:xc5>" ] )
                    {
                        thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                    }
                }
                
                if ( isdefined( level.tdmzones[ "<dev string:xc8>" ] ) )
                {
                    foreach ( objective in level.tdmzones[ "<dev string:xc8>" ] )
                    {
                        thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                    }
                }
                
                if ( isdefined( level.tdmzones[ "<dev string:xcb>" ] ) )
                {
                    foreach ( objective in level.tdmzones[ "<dev string:xcb>" ] )
                    {
                        thread debug::drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                    }
                }
            }
            
            wait 1;
        }
    }

    // Namespace arm
    // Params 1
    // Checksum 0xdacb2e05, Offset: 0x941c
    // Size: 0x71d, Type: dev
    function function_c7f22dd7cb861f3( var_b93b834d7024dd99 )
    {
        if ( var_b93b834d7024dd99 <= 5 )
        {
            key = "<dev string:xce>" + var_b93b834d7024dd99;
            spawns_axis = level.spawnselectionlocations[ key ][ "<dev string:xd7>" ].spawnpoints;
            spawns_allies = level.spawnselectionlocations[ key ][ "<dev string:xdc>" ].spawnpoints;
            
            foreach ( spawnpos in spawns_axis )
            {
                thread debug::drawsphere( spawnpos.origin, 30, 60, ( 1, 0, 0 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread debug::drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 1000 ), 60, ( 1, 0, 0 ) );
            }
            
            foreach ( spawnpos in spawns_allies )
            {
                thread debug::drawsphere( spawnpos.origin, 30, 60, ( 0, 0, 1 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread debug::drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 1000 ), 60, ( 0, 0, 1 ) );
            }
            
            safekey = "<dev string:xce>" + var_b93b834d7024dd99 + "<dev string:xe3>";
            var_7515b299e5fb9abe = undefined;
            var_243741269fbac141 = undefined;
            
            if ( isdefined( level.spawnselectionlocations[ safekey ][ "<dev string:xd7>" ] ) )
            {
                var_7515b299e5fb9abe = level.spawnselectionlocations[ safekey ][ "<dev string:xd7>" ].spawnpoints;
            }
            
            if ( isdefined( level.spawnselectionlocations[ safekey ][ "<dev string:xdc>" ] ) )
            {
                var_243741269fbac141 = level.spawnselectionlocations[ safekey ][ "<dev string:xdc>" ].spawnpoints;
            }
            
            if ( !isdefined( var_7515b299e5fb9abe ) )
            {
                var_7515b299e5fb9abe = spawns_axis;
            }
            
            if ( !isdefined( var_243741269fbac141 ) )
            {
                var_243741269fbac141 = spawns_allies;
            }
            
            foreach ( spawnpos in var_7515b299e5fb9abe )
            {
                thread debug::drawsphere( spawnpos.origin, 15, 60, ( 0.5, 0, 0 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread debug::drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 500 ), 60, ( 0.5, 0, 0 ) );
            }
            
            foreach ( spawnpos in var_243741269fbac141 )
            {
                thread debug::drawsphere( spawnpos.origin, 15, 60, ( 0, 0, 0.5 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread debug::drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 500 ), 60, ( 0, 0, 0.5 ) );
            }
            
            return;
        }
        
        if ( var_b93b834d7024dd99 == 6 )
        {
            key = "<dev string:xe9>";
            spawns = level.spawnselectionlocations[ key ][ "<dev string:xd7>" ].spawnpoints;
            
            foreach ( spawnpos in spawns )
            {
                thread debug::drawsphere( spawnpos.origin, 30, 60, ( 1, 0, 0 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
            }
            
            return;
        }
        
        if ( var_b93b834d7024dd99 == 7 )
        {
            key = "<dev string:xf7>";
            spawns = level.spawnselectionlocations[ key ][ "<dev string:xdc>" ].spawnpoints;
            
            foreach ( spawnpos in spawns )
            {
                thread debug::drawsphere( spawnpos.origin, 30, 60, ( 1, 0, 0 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread debug::drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
            }
        }
    }

#/

// Namespace arm
// Params 3
// Checksum 0x5d02d3eb, Offset: 0x9b41
// Size: 0x213
function calculatedroplocationnearlocation( location, mindist, maxdist )
{
    pos = location.origin;
    x = undefined;
    y = undefined;
    diceroll = randomint( 2 );
    direction = diceroll ? -1 : 1;
    
    if ( direction > 0 )
    {
        x = randomfloatrange( pos[ 0 ] + mindist * direction, pos[ 0 ] + maxdist * direction );
        
        if ( x >= level.br_level.br_corners[ 0 ][ 0 ] )
        {
            x = level.br_level.br_corners[ 0 ][ 0 ] - 250;
        }
    }
    else
    {
        x = randomfloatrange( pos[ 0 ] + maxdist * direction, pos[ 0 ] + mindist * direction );
        
        if ( x <= level.br_level.br_corners[ 1 ][ 0 ] )
        {
            x = level.br_level.br_corners[ 1 ][ 0 ] + 250;
        }
    }
    
    diceroll = randomint( 2 );
    direction = diceroll ? -1 : 1;
    
    if ( direction > 0 )
    {
        y = randomfloatrange( pos[ 1 ] + mindist * direction, pos[ 1 ] + maxdist * direction );
        
        if ( y >= level.br_level.br_corners[ 0 ][ 1 ] )
        {
            y = level.br_level.br_corners[ 0 ][ 1 ] - 250;
        }
    }
    else
    {
        y = randomfloatrange( pos[ 1 ] + maxdist * direction, pos[ 1 ] + mindist * direction );
        
        if ( y >= level.br_level.br_corners[ 1 ][ 1 ] )
        {
            y = level.br_level.br_corners[ 1 ][ 1 ] + 250;
        }
    }
    
    droplocation = spawnstruct();
    droplocation.origin = ( x, y, pos[ 2 ] );
    return droplocation;
}

// Namespace arm
// Params 1
// Checksum 0x79e7c561, Offset: 0x9d5d
// Size: 0x1186
function getmissedinfilcamerapositions( team )
{
    assert( isdefined( game_utility::getlocaleid() ), "<dev string:x107>" );
    var_4d57251d6a098bb9 = spawnstruct();
    var_4d57251d6a098bb9.startorigin = undefined;
    var_4d57251d6a098bb9.endpos = undefined;
    
    if ( level.mapname == "mp_jup_st_c_gw" )
    {
        intermission_ent = playerlogic::getspectatepoint();
        var_4d57251d6a098bb9.startorigin = intermission_ent.origin;
        var_4d57251d6a098bb9.startangles = intermission_ent.angles;
        var_4d57251d6a098bb9.endorigin = intermission_ent.origin;
        var_4d57251d6a098bb9.endangles = intermission_ent.angles;
        return var_4d57251d6a098bb9;
    }
    
    if ( level.mapname == "mp_locale_test" )
    {
        switch ( game_utility::getlocaleid() )
        {
            case #"hash_369d88655b32bac0":
            case #"hash_369d96655b32d0ca":
                if ( team == "axis" )
                {
                    var_4d57251d6a098bb9.startorigin = ( 2094, -1804, 2763 );
                    var_4d57251d6a098bb9.startangles = ( 54, 40, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 2094, -1804, 2763 );
                    var_4d57251d6a098bb9.endangles = ( 54, 40, 0 );
                }
                else
                {
                    var_4d57251d6a098bb9.startorigin = ( 2315, 1956, 2763 );
                    var_4d57251d6a098bb9.startangles = ( 54, 296, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 2094, -1804, 2763 );
                    var_4d57251d6a098bb9.endangles = ( 54, 40, 0 );
                }
                
                break;
            default:
                var_4d57251d6a098bb9.startorigin = ( 0, 0, 0 );
                var_4d57251d6a098bb9.startangles = ( 0, 0, 0 );
                var_4d57251d6a098bb9.endorigin = ( 0, 0, 0 );
                var_4d57251d6a098bb9.endangles = ( 0, 0, 0 );
                break;
        }
    }
    else
    {
        var_845fe7b1ccd5f3c7 = utility::getstructarray( "hq_intro_camera_start", "targetname" );
        var_175654d4f59c2078 = utility::getstructarray( "hq_intro_camera_end", "targetname" );
        var_bef98f0a6149aba7 = undefined;
        var_c5d58b4e05958ba2 = undefined;
        
        foreach ( cam in var_845fe7b1ccd5f3c7 )
        {
            if ( cam.script_team == team )
            {
                var_bef98f0a6149aba7 = cam;
            }
        }
        
        foreach ( cam in var_175654d4f59c2078 )
        {
            if ( cam.script_team == team )
            {
                var_c5d58b4e05958ba2 = cam;
            }
        }
        
        if ( isdefined( var_bef98f0a6149aba7 ) && isdefined( var_c5d58b4e05958ba2 ) )
        {
            var_4d57251d6a098bb9.startorigin = var_bef98f0a6149aba7.origin;
            var_4d57251d6a098bb9.startangles = var_bef98f0a6149aba7.angles;
            var_4d57251d6a098bb9.endorigin = var_c5d58b4e05958ba2.origin;
            var_4d57251d6a098bb9.endangles = var_c5d58b4e05958ba2.angles;
        }
        else
        {
            switch ( game_utility::getlocaleid() )
            {
                case #"hash_369d93655b32cc11":
                    if ( team == "axis" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( 38864, -14018, -396 );
                        var_4d57251d6a098bb9.startangles = ( 3, 250, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 38473, -14077, 401 );
                        var_4d57251d6a098bb9.endangles = ( 15, 252, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( 30526, -38262, -483 );
                        var_4d57251d6a098bb9.startangles = ( 0, 72, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 30024, -38403, 560 );
                        var_4d57251d6a098bb9.endangles = ( 19, 67, 0 );
                    }
                    
                    break;
                case #"hash_369d96655b32d0ca":
                    if ( team == "axis" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( 16977, -23256, 169 );
                        var_4d57251d6a098bb9.startangles = ( 9, 69, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 16899, -23467, 683 );
                        var_4d57251d6a098bb9.endangles = ( 15, 68, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( 18607, 1423, -355 );
                        var_4d57251d6a098bb9.startangles = ( 8, 289, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 18100, 1083, 503 );
                        var_4d57251d6a098bb9.endangles = ( 22, 302, 0 );
                    }
                    
                    break;
                case #"hash_369d88655b32bac0":
                    if ( team == "axis" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( 18672, -26836, -129 );
                        var_4d57251d6a098bb9.startangles = ( 359, 76, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 18518, -26909, 314 );
                        var_4d57251d6a098bb9.endangles = ( 14, 69, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( 18607, 1423, -355 );
                        var_4d57251d6a098bb9.startangles = ( 8, 289, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 18100, 1083, 503 );
                        var_4d57251d6a098bb9.endangles = ( 22, 302, 0 );
                    }
                    
                    break;
                case #"hash_2cd4bf8e90f233e7":
                case #"hash_369d95655b32cf37":
                    if ( team == "axis" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( 24893, 28349, 1408 );
                        var_4d57251d6a098bb9.startangles = ( 15, 54, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 25613, 29274, 1255 );
                        var_4d57251d6a098bb9.endangles = ( 19, 53, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( 39490, 48919, 2302 );
                        var_4d57251d6a098bb9.startangles = ( 17, 235, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 39254, 48584, 1542 );
                        var_4d57251d6a098bb9.endangles = ( 18, 245, 0 );
                    }
                    
                    break;
                case #"hash_369d89655b32bc53":
                    if ( team == "axis" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( 48331, -24822, 514 );
                        var_4d57251d6a098bb9.startangles = ( 12, 77, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 48424, -24421, -240 );
                        var_4d57251d6a098bb9.endangles = ( 2, 77, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( 46188, 2520, 49 );
                        var_4d57251d6a098bb9.startangles = ( 7, 295, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 46571, 2664, 526 );
                        var_4d57251d6a098bb9.endangles = ( 16, 276, 0 );
                    }
                    
                    break;
                case #"hash_2cd4bd8e90f230c1":
                    if ( team == "axis" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( -11083, 22197, 381 );
                        var_4d57251d6a098bb9.startangles = ( 10, 181, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -12112, 23761, 381 );
                        var_4d57251d6a098bb9.endangles = ( 11, 201, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( -31134, 11924, -116 );
                        var_4d57251d6a098bb9.startangles = ( 0, 36, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -31134, 11924, 434 );
                        var_4d57251d6a098bb9.endangles = ( 11, 36, 0 );
                    }
                    
                    break;
                case #"hash_2cd4be8e90f23254":
                    if ( team == "axis" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( 9215, 984, 325 );
                        var_4d57251d6a098bb9.startangles = ( 357, 186, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 9107, 628, 1144 );
                        var_4d57251d6a098bb9.endangles = ( 19, 182, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( -5351, 641, 408 );
                        var_4d57251d6a098bb9.startangles = ( 2, 352, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -5282, 996, 1103 );
                        var_4d57251d6a098bb9.endangles = ( 11, 347, 0 );
                    }
                    
                    break;
                case #"hash_2cd4b58e90f22429":
                    if ( team == "axis" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( -22847, -28632, 34 );
                        var_4d57251d6a098bb9.startangles = ( 12, 42, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -22694, -28429, 356 );
                        var_4d57251d6a098bb9.endangles = ( 12, 40, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( -8084, -20649, 72 );
                        var_4d57251d6a098bb9.startangles = ( 10, 185, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -9092, -20635, 224 );
                        var_4d57251d6a098bb9.endangles = ( 12, 184, 0 );
                    }
                    
                    break;
                case #"hash_2cd7bb8e90f46c32":
                case #"hash_2cdb2a8e90f75986":
                case #"hash_2cdb2d8e90f75e3f":
                    if ( team == "axis" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( -8111.37, -50208.9, 1201.16 );
                        var_4d57251d6a098bb9.startangles = ( 15, 176, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -13177.5, -45326.2, 2957.64 );
                        var_4d57251d6a098bb9.endangles = ( 41, 267, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( 7966.23, -35390.7, 1891.99 );
                        var_4d57251d6a098bb9.startangles = ( 19, 352, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 11447.2, -40764, 2908.09 );
                        var_4d57251d6a098bb9.endangles = ( 29, 76, 0 );
                    }
                    
                    break;
                case #"hash_2ce1348e90fbe672":
                case #"hash_2ce1358e90fbe805":
                    if ( team == "axis" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( -37269.9, -27684.2, 1093.4 );
                        var_4d57251d6a098bb9.startangles = ( 13, 135, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -38918.5, -22218, 2139 );
                        var_4d57251d6a098bb9.endangles = ( 37, 240, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( -31446.2, -18677.9, 883.622 );
                        var_4d57251d6a098bb9.startangles = ( 10, 36, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -30766.5, -23149.7, 1726.86 );
                        var_4d57251d6a098bb9.endangles = ( 34, 42, 0 );
                    }
                    
                    break;
                case #"hash_8c21d36e30da718e":
                    if ( team == "allies" )
                    {
                        var_4d57251d6a098bb9.startorigin = ( 7124, 11776, 2556 );
                        var_4d57251d6a098bb9.startangles = ( 13.829, 335.3, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 9004, 10088, 1988 );
                        var_4d57251d6a098bb9.endangles = ( 24.9985, 220.001, -0.000213426 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( -15827.3, -133.42, 1550.86 );
                        var_4d57251d6a098bb9.startangles = ( 13.829, 335.3, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -14335.3, -3621.42, 1550.86 );
                        var_4d57251d6a098bb9.endangles = ( 8.53518, 55.9275, 2.37782 );
                    }
                    
                    break;
                case #"hash_3f076ed34a27c07e":
                case #"hash_6073c29dbc93b7a4":
                case #"hash_6073c39dbc93b937":
                    if ( team == ( game[ "switchedsides" ] ? "axis" : "allies" ) )
                    {
                        var_4d57251d6a098bb9.startorigin = ( -38715, -22700, 2785 );
                        var_4d57251d6a098bb9.startangles = ( 22, 32, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -36570, -23920, 1905 );
                        var_4d57251d6a098bb9.endangles = ( 23, 88, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( -49500, -34300, 2170 );
                        var_4d57251d6a098bb9.startangles = ( 22, 276, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -46760, -36225, 2170 );
                        var_4d57251d6a098bb9.endangles = ( 28, 216, 0 );
                    }
                    
                    break;
                case #"hash_708eedd45c7bc979":
                case #"hash_acc9b04d96dde111":
                    if ( team == ( game[ "switchedsides" ] ? "axis" : "allies" ) )
                    {
                        var_4d57251d6a098bb9.startorigin = ( -19300, -50500, 2540 );
                        var_4d57251d6a098bb9.startangles = ( 15, 342, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -14575, -49885, 1525 );
                        var_4d57251d6a098bb9.endangles = ( 10, 275, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( -25700, -35400, 2400 );
                        var_4d57251d6a098bb9.startangles = ( 17, 121, 0 );
                        var_4d57251d6a098bb9.endorigin = ( -25840, -32745, 1600 );
                        var_4d57251d6a098bb9.endangles = ( 15, 166, 0 );
                    }
                    
                    break;
                case #"hash_5a9052a4259eeb75":
                    if ( team == ( game[ "switchedsides" ] ? "axis" : "allies" ) )
                    {
                        var_4d57251d6a098bb9.startorigin = ( 12285, -32400, 2325 );
                        var_4d57251d6a098bb9.startangles = ( 15, 80, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 18470, -29470, 3140 );
                        var_4d57251d6a098bb9.endangles = ( 27, 143, 0 );
                    }
                    else
                    {
                        var_4d57251d6a098bb9.startorigin = ( 15500, -42600, 3000 );
                        var_4d57251d6a098bb9.startangles = ( 30, -170, 0 );
                        var_4d57251d6a098bb9.endorigin = ( 13250, -40300, 1600 );
                        var_4d57251d6a098bb9.endangles = ( 10, -122, 0 );
                    }
                    
                    break;
                default:
                    var_4d57251d6a098bb9.startorigin = ( 0, 0, 0 );
                    var_4d57251d6a098bb9.startangles = ( 0, 0, 0 );
                    var_4d57251d6a098bb9.endorigin = ( 0, 0, 0 );
                    var_4d57251d6a098bb9.endangles = ( 0, 0, 0 );
                    break;
            }
        }
    }
    
    return var_4d57251d6a098bb9;
}

// Namespace arm
// Params 0
// Checksum 0xa33b5e78, Offset: 0xaeec
// Size: 0xea
function calculatehqmidpoint()
{
    level.hqmidpoint = ( level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin ) * 0.5;
    level.hqvecttomid_allies = level.gw_objstruct.axishqloc.trigger.origin - level.hqmidpoint;
    level.hqvecttomid_axis = level.gw_objstruct.allieshqloc.trigger.origin - level.hqmidpoint;
    level.hqdisttomid = length( level.hqvecttomid_axis );
}

// Namespace arm
// Params 2
// Checksum 0xe87fd930, Offset: 0xafde
// Size: 0x256
function calculatecameraoffset( team, objectiveorigin )
{
    switch ( level.mapname )
    {
        case #"hash_7a28db3c5928c489":
            var_9aeeec533ac4cd45 = 0.25;
            var_f776d2686256c018 = 0.35;
            break;
        case #"hash_863773b8960b3944":
            var_9aeeec533ac4cd45 = 0.25;
            var_f776d2686256c018 = 0.8;
            break;
        case #"hash_a8b272dba33a4aed":
            var_9aeeec533ac4cd45 = 0.5;
            var_f776d2686256c018 = 0.3;
            break;
        default:
            var_9aeeec533ac4cd45 = 0;
            var_f776d2686256c018 = 0;
            break;
    }
    
    len = distance( objectiveorigin, level.hqmidpoint );
    
    if ( len < 2048 )
    {
        return ( 0, 0, 0 );
    }
    
    if ( team == "axis" )
    {
        var_367861ab2439dd31 = distance( level.gw_objstruct.axishqloc.trigger.origin, objectiveorigin );
        fulloffset = level.hqvecttomid_axis;
    }
    else
    {
        var_367861ab2439dd31 = distance( level.gw_objstruct.allieshqloc.trigger.origin, objectiveorigin );
        fulloffset = level.hqvecttomid_allies;
    }
    
    if ( var_367861ab2439dd31 < 2048 )
    {
        return ( fulloffset * var_9aeeec533ac4cd45 );
    }
    
    if ( var_367861ab2439dd31 > level.hqdisttomid )
    {
        if ( team == "axis" )
        {
            var_367861ab2439dd31 = distance( level.gw_objstruct.allieshqloc.trigger.origin, objectiveorigin );
        }
        else
        {
            var_367861ab2439dd31 = distance( level.gw_objstruct.axishqloc.trigger.origin, objectiveorigin );
        }
        
        percentage = 100 - var_367861ab2439dd31 * 100 / level.hqdisttomid;
        offset = fulloffset * var_f776d2686256c018 * -1 * percentage / 100;
        return offset;
    }
    
    percentage = 100 - var_367861ab2439dd31 * 100 / level.hqdisttomid;
    offset = fulloffset * var_9aeeec533ac4cd45 * percentage / 100;
    return offset;
}

// Namespace arm
// Params 0
// Checksum 0x71e5ca45, Offset: 0xb23c
// Size: 0x29, Type: bool
function spawnprotectionexception()
{
    if ( isdefined( self.selectedspawnarea ) && issubstr( self.selectedspawnarea, "HQ" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace arm
// Params 0
// Checksum 0xbaa2a9e3, Offset: 0xb26e
// Size: 0x11
function function_e42623be2d62d389()
{
    wait 5;
    audio_utility::snd_transient_load( "mp_gamemode_gw" );
}

// Namespace arm
// Params 1
// Checksum 0x3ccd7b37, Offset: 0xb287
// Size: 0x184
function function_3327783ff0ce3137( team )
{
    self notify( #"hash_aefd1d48deff0b5d" );
    self endon( #"hash_aefd1d48deff0b5d" );
    level endon( #"hash_9582f68025ea67b1" );
    level.warningteam = team;
    level thread function_934cc86b3da735b7();
    
    foreach ( player in level.players )
    {
        player thread function_46758069ff9465d();
    }
    
    wait 5;
    timer = int( level.var_d2f40b81c9a9a97a );
    
    while ( timer > 0 )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_match_start_countdown", timer );
        }
        
        timer--;
        wait 1;
    }
    
    currentscore = getteamscore( team );
    gamescore::giveteamscoreforobjective( team, level.roundscorelimit - currentscore, 1, undefined, 1 );
}

// Namespace arm
// Params 0
// Checksum 0xd6047f3d, Offset: 0xb413
// Size: 0x41
function function_46758069ff9465d()
{
    level endon( #"hash_9582f68025ea67b1" );
    self endon( #"death_or_disconnect" );
    self setclientomnvar( "ui_hq_norespawn", 2 );
    self playlocalsound( "mp_hq_respawn_disabled" );
    wait 5;
    self setclientomnvar( "ui_hq_norespawn", 0 );
}

// Namespace arm
// Params 0
// Checksum 0x304cac5a, Offset: 0xb45c
// Size: 0xb1
function function_934cc86b3da735b7()
{
    self notify( #"hash_f63cf7f8d6c2631b" );
    self endon( #"hash_f63cf7f8d6c2631b" );
    level waittill( #"hash_9582f68025ea67b1" );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_hq_norespawn", 0 );
        player setclientomnvar( "ui_match_start_countdown", 0 );
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0xf28cbc19, Offset: 0xb515
// Size: 0x106
function private function_2361b046dd0332a6( team_name )
{
    self endon( #"ownership_changed" );
    uavstruct = spawnstruct();
    uavstruct.origin = gameobjects_common::get_origin( self );
    uavstruct.team = team_name;
    uavstruct.radius = 1000;
    uavstruct.sweeptime = 10;
    uavstruct.var_bfad811bac7c2ef3 = int( uavstruct.sweeptime * 1000 );
    otherteam = team_utility::getotherteam( team_name );
    wait 3;
    dialog::leaderdialog( #"local_uav_online", team_name );
    dialog::leaderdialog( #"enemy_reward_uav", otherteam );
    
    while ( true )
    {
        triggerportableradarpingteam( uavstruct.origin, uavstruct.team, uavstruct.radius, uavstruct.var_bfad811bac7c2ef3 );
        wait uavstruct.sweeptime;
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x4b8ef0d5, Offset: 0xb623
// Size: 0x1de
function private airdropvehicle( vehicletype )
{
    level endon( #"game_ended" );
    self endon( #"ownership_changed" );
    team = namespace_277c922f0d0dc523::get_claim_team_name( self );
    otherteam = team_utility::getotherteam( team );
    droplocation = level.var_f65ff577a8afa9c1[ self.name_hash ][ team ][ vehicletype ];
    spawndata = spawnstruct();
    spawndata.origin = droplocation.origin + ( 0, 0, 100 );
    spawndata.angles = droplocation.angles;
    spawndata.team = team;
    
    while ( true )
    {
        if ( isdefined( level.var_6305f97960e8c4a4[ self.name_hash ][ team ][ vehicletype ] ) )
        {
            level.var_6305f97960e8c4a4[ self.name_hash ][ team ][ vehicletype ] waittill( #"death" );
            wait 30;
        }
        
        vehicle = vehicle_airdrop::vehicle_airdrop( vehicletype, spawndata );
        
        if ( isdefined( vehicle ) )
        {
            vehicle thread entityheadicons::setheadicon_factionimage( 0, 50, 0, 4000 );
            vehicle function_5824cd07debbba4f( 1 );
            level.var_6305f97960e8c4a4[ self.name_hash ][ team ][ vehicletype ] = vehicle;
            
            if ( vehicletype == %"hash_755adbf0f147c02" )
            {
                dialog::leaderdialog( #"jltv_inbound", team );
                dialog::leaderdialog( #"hash_2b33e631bce9c664", otherteam );
            }
            else
            {
                dialog::leaderdialog( #"tank_inbound", team );
                dialog::leaderdialog( #"hash_2b33e631bce9c664", otherteam );
            }
            
            if ( level.var_c3b8f183c54800f4 )
            {
                return;
            }
            
            vehicle waittill( #"death" );
            wait 30;
            continue;
        }
        
        wait 5;
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0xb51d180a, Offset: 0xb809
// Size: 0x1ac
function private function_ead0d01c88e8bdd0( team )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_d9edc330297d117 ) )
    {
        level.var_d9edc330297d117 = [];
        
        foreach ( loc in vehicle_spawn::get_spawn_structs( %"hash_57d0b185054b4bd4", undefined, [] ) )
        {
            spawndata = spawnstruct();
            spawndata.origin = loc.origin + ( 0, 0, 100 );
            spawndata.angles = loc.angles;
            spawndata.team = loc.script_team;
            level.var_d9edc330297d117[ loc.script_team ] = spawndata;
        }
        
        level.var_1313d7a16469ab73 = [];
    }
    
    level waittill( #"prematch_done" );
    wait 60;
    
    while ( true )
    {
        vehicle = vehicle_airdrop::vehicle_airdrop( %"hash_57d0b185054b4bd4", level.var_d9edc330297d117[ team ] );
        
        if ( isdefined( vehicle ) )
        {
            level.var_1313d7a16469ab73[ team ] = vehicle;
            vehicle thread entityheadicons::setheadicon_factionimage( 0, 50, 0, 4000 );
            vehicle function_5824cd07debbba4f( 1 );
            vehicle waittill( #"death" );
            wait 60;
            continue;
        }
        
        wait 5;
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0xed2e6880, Offset: 0xb9bd
// Size: 0x1ca
function private function_966acd158d15b6a4( team )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_34ca7b4f728810d5 ) )
    {
        level.var_34ca7b4f728810d5 = [];
        jltvspawns = vehicle_spawn::get_spawn_structs( %"hash_755adbf0f147c02", undefined, [] );
        
        foreach ( loc in jltvspawns )
        {
            spawndata = spawnstruct();
            spawndata.origin = loc.origin + ( 0, 0, 100 );
            spawndata.angles = loc.angles;
            spawndata.team = loc.script_team;
            level.var_34ca7b4f728810d5[ loc.script_team ] = spawndata;
        }
        
        level.var_60ba99f45a56ec05 = [];
    }
    
    if ( !isdefined( level.var_34ca7b4f728810d5[ team ] ) )
    {
        return;
    }
    
    level waittill( #"prematch_done" );
    wait 30;
    
    while ( true )
    {
        vehicle = vehicle_airdrop::vehicle_airdrop( %"hash_755adbf0f147c02", level.var_34ca7b4f728810d5[ team ] );
        
        if ( isdefined( vehicle ) )
        {
            level.var_60ba99f45a56ec05[ team ] = vehicle;
            vehicle thread entityheadicons::setheadicon_factionimage( 0, 50, 0, 4000 );
            vehicle function_5824cd07debbba4f( 1 );
            vehicle waittill( #"death" );
            wait 60;
            continue;
        }
        
        wait 5;
    }
}

// Namespace arm
// Params 0
// Checksum 0x4d22479d, Offset: 0xbb8f
// Size: 0x249
function function_5887502d62f0e88b()
{
    level.var_f65ff577a8afa9c1 = [];
    level.var_6305f97960e8c4a4 = [];
    airdropdata = utility::getstructarray( "reinforce_vehicles", "targetname" );
    
    foreach ( drop in airdropdata )
    {
        if ( !issubstr( drop.script_label, "gw_fob_0" ) )
        {
            tokens = strtok( drop.script_label, "0" );
            fobname = tokens[ 0 ] + "_0" + tokens[ 1 ];
            var_40caba4eed839eae = getxhash( fobname );
        }
        else
        {
            var_40caba4eed839eae = getxhash( drop.script_label );
        }
        
        if ( !isdefined( level.var_f65ff577a8afa9c1[ var_40caba4eed839eae ] ) )
        {
            level.var_f65ff577a8afa9c1[ var_40caba4eed839eae ] = [];
            level.var_6305f97960e8c4a4[ var_40caba4eed839eae ] = [];
        }
        
        if ( !isdefined( level.var_f65ff577a8afa9c1[ var_40caba4eed839eae ][ drop.script_team ] ) )
        {
            level.var_f65ff577a8afa9c1[ var_40caba4eed839eae ][ drop.script_team ] = [];
            level.var_6305f97960e8c4a4[ var_40caba4eed839eae ][ drop.script_team ] = [];
        }
        
        if ( drop.script_parameters == "cougar" )
        {
            vehicletype = %"hash_32b7b34facdfbf9";
        }
        else
        {
            vehicletype = %"hash_755adbf0f147c02";
        }
        
        /#
            color = drop.script_team == "<dev string:xd7>" ? ( 1, 0.5, 0.5 ) : ( 0.5, 0.5, 1 );
            thread debug::drawline( drop.origin, drop.origin + ( 0, 0, 10000 ), 999, color );
        #/
        
        level.var_f65ff577a8afa9c1[ var_40caba4eed839eae ][ drop.script_team ][ vehicletype ] = drop;
    }
}

// Namespace arm
// Params 0, eflags: 0x4
// Checksum 0x135556a7, Offset: 0xbde0
// Size: 0x3ce
function private function_680ed35851d114c8()
{
    level.var_179584883851c36a = [];
    level.activecarepackages = [];
    airdropdata = utility::getstructarray( "reinforce_carepackages", "targetname" );
    
    if ( airdropdata.size == 0 )
    {
        origins = [ ( -45300, -34900, 1400 ), ( -44500, -29900, 1400 ), ( -38200, -28800, 1400 ) ];
        fobnames = [ "gw_fob_01", "gw_fob_02", "gw_fob_03" ];
        teams = [ "allies", "axis" ];
        
        for ( i = 0; i < 3 ; i++ )
        {
            fobname = fobnames[ i ];
            origin = origins[ i ];
            
            for ( j = 0; j < 3 ; j++ )
            {
                foreach ( team in teams )
                {
                    origin = utility::getrandompointincircle( origin, 1500 );
                    origin = utility::drop_to_ground( origin );
                    var_7a1852a8eee51d4e = spawnstruct();
                    var_7a1852a8eee51d4e.origin = origin;
                    var_7a1852a8eee51d4e.script_label = fobname;
                    var_7a1852a8eee51d4e.script_team = team;
                    airdropdata[ airdropdata.size ] = var_7a1852a8eee51d4e;
                }
            }
        }
    }
    
    foreach ( drop in airdropdata )
    {
        var_40caba4eed839eae = getxhash( drop.script_label );
        
        if ( !isdefined( level.var_179584883851c36a[ var_40caba4eed839eae ] ) )
        {
            level.var_179584883851c36a[ var_40caba4eed839eae ] = [];
            level.activecarepackages[ var_40caba4eed839eae ] = [];
        }
        
        if ( !isdefined( level.var_179584883851c36a[ var_40caba4eed839eae ][ drop.script_team ] ) )
        {
            level.var_179584883851c36a[ var_40caba4eed839eae ][ drop.script_team ] = [];
            level.activecarepackages[ var_40caba4eed839eae ][ drop.script_team ] = [];
        }
        
        /#
            color = drop.script_team == "<dev string:xd7>" ? ( 1, 0, 0 ) : ( 0, 0, 1 );
            thread debug::drawline( drop.origin, drop.origin + ( 0, 0, 3000 ), 999, color );
        #/
        
        level.var_179584883851c36a[ var_40caba4eed839eae ][ drop.script_team ][ level.var_179584883851c36a[ var_40caba4eed839eae ][ drop.script_team ].size ] = drop;
        var_9ddc6081582235fd = spawnstruct();
        var_9ddc6081582235fd.origin = drop.origin;
        var_9ddc6081582235fd.inuse = 0;
        level.activecarepackages[ var_40caba4eed839eae ][ drop.script_team ][ level.activecarepackages[ var_40caba4eed839eae ][ drop.script_team ].size ] = var_9ddc6081582235fd;
    }
}

// Namespace arm
// Params 2, eflags: 0x4
// Checksum 0x307d3849, Offset: 0xc1b6
// Size: 0x9e
function private function_7128e875dff2d82f( var_785fdebae64bdade, team )
{
    foreach ( location in level.activecarepackages[ var_785fdebae64bdade ][ team ] )
    {
        if ( location.inuse )
        {
            continue;
        }
        
        return location;
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0xad52ced0, Offset: 0xc25d
// Size: 0x190
function private function_7019255133284760( team )
{
    self endon( #"ownership_changed" );
    otherteam = team_utility::getotherteam( team );
    wait 3;
    dialog::leaderdialog( #"care_package_inbound", team );
    dialog::leaderdialog( #"enemy_care_package_inbound", otherteam );
    streakinfo = killstreak_utility::createstreakinfo( "airdrop" );
    
    while ( true )
    {
        streakname = airdrop::function_1e33ae1ce2ad299f();
        location = function_7128e875dff2d82f( self.name_hash, team );
        
        if ( !isdefined( location ) )
        {
            wait 5;
            continue;
        }
        
        vehicleisreserved = vehicle_tracking::reserve_vehicle();
        scenenode = airdrop::dropkillstreakcratefromscriptedheli( undefined, team, streakname, location.origin, ( 0, randomint( 360 ), 0 ), location.origin, vehicleisreserved, streakinfo );
        
        if ( isdefined( scenenode ) )
        {
            thread docratedropsmoke( undefined, location, 16 );
            
            foreach ( crate in scenenode.crates )
            {
                crate thread function_8dd4f1182e1b0a5f( location );
            }
            
            wait 90;
            continue;
        }
        
        wait 5;
    }
}

// Namespace arm
// Params 1
// Checksum 0x32df18e4, Offset: 0xc3f5
// Size: 0x34
function function_8dd4f1182e1b0a5f( location )
{
    location.inuse = 1;
    self waittill( #"death" );
    location.inuse = 0;
}

// Namespace arm
// Params 2, eflags: 0x4
// Checksum 0x80e8502c, Offset: 0xc431
// Size: 0x194
function private function_e3085032be92c327( game_object, objective_key_override )
{
    game_object.objective_key = objective_key_override;
    
    if ( gameobjects_common::has_trigger_group( game_object ) )
    {
        trigger_group = gameobjects_common::get_trigger_group( game_object );
        trigger_group.gameobject = game_object;
    }
    else
    {
        trigger = gameobjects_common::get_trigger( game_object );
        trigger.gameobject = game_object;
    }
    
    game_object_origin = gameobjects_common::get_origin( game_object );
    objective_icon_offset = gameobjects_common::get_objective_icon_offset( game_object );
    objective_icon_origin = game_object_origin + objective_icon_offset;
    game_object.objidnum = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_playermask_showtoall( game_object.objidnum );
    objidpoolmanager::objective_show_progress( game_object.objidnum, 1, 0 );
    objidpoolmanager::update_objective_position( game_object.objidnum, objective_icon_origin );
    objidpoolmanager::update_objective_state( game_object.objidnum, "active" );
    update_objective_icon_state( game_object );
    game_object thread function_b2257c2b3697f27f( game_object.objidnum );
    captureflag::function_dfdb63cdb68b35ec( game_object );
    game_utility_mp::add_gametype_objective( game_object );
    spawnlogic::addspawninfluencer( #"hash_9a3103dcc9d3b69a", gameobjects_common::get_origin( game_object ) );
    gameobjects_common::activate( game_object );
    objective_list = game_utility_mp::get_gametype_objectives( gameobjects_common::get_instance_id( game_object ) );
    
    if ( objective_list.size == ( game_utility_mp::isroundbased() ? 2 : 3 ) )
    {
        utility::flag_set( "gw_game_objects_constructed" );
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0xb0325974, Offset: 0xc5cd
// Size: 0x37
function private function_e119853d3fabcff( params )
{
    game_object = params.game_object;
    objidpoolmanager::objective_show_progress( game_object.objidnum, 1 );
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0xb4a3c521, Offset: 0xc60c
// Size: 0x49
function private function_122e3ffe86139e33( params )
{
    game_object = params.game_object;
    var_7ed0697b0eea44f8 = gameobjects_common::function_7ed0697b0eea44f8( game_object );
    objidpoolmanager::objective_show_progress( game_object.objidnum, var_7ed0697b0eea44f8 );
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x2728ca9d, Offset: 0xc65d
// Size: 0x64
function private function_25287125d0c872fd( params )
{
    game_object = params.game_object;
    player = params.player;
    player.var_c36e159445e2a48b = 0;
    objidpoolmanager::objective_pin_player( game_object.objidnum, player );
    objidpoolmanager::function_b3b969f2930890eb( 2, player );
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x23185912, Offset: 0xc6c9
// Size: 0x61
function private function_293e81a992d5bac5( params )
{
    game_object = params.game_object;
    player = params.player;
    player.var_c36e159445e2a48b = undefined;
    objidpoolmanager::objective_unpin_player( game_object.objidnum, player );
    objidpoolmanager::function_b3b969f2930890eb( 0, player );
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x3ef1526e, Offset: 0xc732
// Size: 0x2c7
function private function_decbd018a9bcf78c( params )
{
    game_object = params.game_object;
    claim_team_name = params.claim_team_name;
    progress = params.progress;
    instance_id = params.instance_id;
    objidpoolmanager::objective_set_progress( game_object.objidnum, progress );
    
    if ( !level.gameended && !game_utility_mp::isanymlgmatch() )
    {
        current_time_ms = gettime();
        
        if ( !isdefined( game_object.lastsfxplayedtime ) )
        {
            game_object.lastsfxplayedtime = current_time_ms;
        }
        
        if ( game_object.lastsfxplayedtime + 995 < current_time_ms )
        {
            game_object.lastsfxplayedtime = current_time_ms;
            var_6154b136827fcee6 = "shared_obj_capturing_tick_0" + int( progress * 10 );
            game_object.visuals gameplay_sound_fx::function_6dac8db778849e61( var_6154b136827fcee6, claim_team_name );
        }
    }
    
    if ( !game_object.didstatusnotify && !level.var_4a5de2a2eae8e2b0 )
    {
        if ( gameobjects_common::get_use_time_seconds( game_object ) > 0.05 )
        {
            var_7f4958ce4e4277c3 = namespace_277c922f0d0dc523::function_9b71aa2788e21706( game_object );
            objective_key = gameobjects_common::get_objective_key( game_object );
            
            if ( var_7f4958ce4e4277c3 == #"hash_bb332da19f9944df" )
            {
                dialog::statusdialog( hashcat( #"securing", objective_key ), claim_team_name );
                objective_list = game_utility_mp::get_gametype_objectives( instance_id );
                var_f860618021b86ac7 = objective_list.size == 3 && !level.ingraceperiod;
                var_ccec9686557bd5b9 = objective_list.size == 5 && ( objective_key == "_b" || objective_key == "_c" || objective_key == "_d" );
                
                if ( var_f860618021b86ac7 || var_ccec9686557bd5b9 )
                {
                    other_team_name = team_utility::getotherteam( claim_team_name );
                    dialog::statusdialog( hashcat( #"losing", objective_key ), other_team_name );
                }
            }
            else
            {
                var_536395db3d80fedb = namespace_277c922f0d0dc523::get_claim_team_hash( game_object );
                
                if ( var_7f4958ce4e4277c3 != var_536395db3d80fedb )
                {
                    var_56dd2b153c7e8453 = function_80e2c69a995aac1a( var_536395db3d80fedb, instance_id );
                    var_65830a7e9d5af679 = var_56dd2b153c7e8453 ? #"securing_all" : hashcat( #"securing", objective_key );
                    var_a068fafbfa7d9191 = var_56dd2b153c7e8453 ? #"losing_all" : hashcat( #"losing", objective_key );
                    dialog::statusdialog( var_65830a7e9d5af679, claim_team_name );
                    dialog::statusdialog( var_a068fafbfa7d9191, namespace_277c922f0d0dc523::get_owning_team_name( game_object ) );
                }
            }
        }
        
        game_object.didstatusnotify = 1;
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x84fbbb75, Offset: 0xca01
// Size: 0xb0
function private function_30642aad2c1693ea( params )
{
    game_object = params.game_object;
    var_dbd0d4c325a7ae15 = params.var_dbd0d4c325a7ae15;
    objidpoolmanager::objective_show_progress( game_object.objidnum, 0 );
    
    if ( game_utility_mp::isroundbased() )
    {
        if ( captureflag::function_ae0c1c2a2553b7d( var_dbd0d4c325a7ae15.team, 0 ) == 2 )
        {
            if ( level.warningteam != var_dbd0d4c325a7ae15.team )
            {
                level thread function_3327783ff0ce3137( var_dbd0d4c325a7ae15.team );
            }
            
            return;
        }
        
        level.warningteam = undefined;
        level notify( #"hash_9582f68025ea67b1" );
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0xa1dba424, Offset: 0xcab9
// Size: 0x109
function private function_856b89ca12a64ee2( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    var_536395db3d80fedb = team_name == "all" || team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( team_name ) ? #"hash_ce911e3bbe99421f" : team_name == "none" || team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( var_536395db3d80fedb == #"hash_7118f9343873352b" || var_536395db3d80fedb == #"hash_ce911e3bbe99421f" )
    {
        objidpoolmanager::function_84651f3f2873ee19( game_object.objidnum, team_name );
    }
    else
    {
        objidpoolmanager::function_84651f3f2873ee19( game_object.objidnum, undefined );
    }
    
    update_objective_icon_state( game_object );
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0xea35ca4e, Offset: 0xcbca
// Size: 0x116
function private function_d8b39037a002b160( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    var_7f4958ce4e4277c3 = team_name == "all" || team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( team_name ) ? #"hash_ce911e3bbe99421f" : team_name == "none" || team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( var_7f4958ce4e4277c3 == #"hash_7118f9343873352b" || var_7f4958ce4e4277c3 == #"hash_ce911e3bbe99421f" )
    {
        objidpoolmanager::update_objective_ownerteam( game_object.objidnum, team_name );
    }
    else
    {
        objidpoolmanager::update_objective_ownerteam( game_object.objidnum, undefined );
    }
    
    update_objective_icon_state( game_object );
    game_object notify( #"ownership_changed" );
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x13d6b5e5, Offset: 0xcce8
// Size: 0x109
function private function_2f53c380c14c079f( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    var_d07b2b95cdf20f0c = team_name == "all" || team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( team_name ) ? #"hash_ce911e3bbe99421f" : team_name == "none" || team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( var_d07b2b95cdf20f0c == #"hash_7118f9343873352b" || var_d07b2b95cdf20f0c == #"hash_ce911e3bbe99421f" )
    {
        objidpoolmanager::objective_set_progress_team( game_object.objidnum, team_name );
    }
    else
    {
        objidpoolmanager::objective_set_progress_team( game_object.objidnum, undefined );
    }
    
    update_objective_icon_state( game_object );
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x3ced2203, Offset: 0xcdf9
// Size: 0x4dd
function private function_e0a7fe0601365413( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    var_dbd0d4c325a7ae15 = params.var_dbd0d4c325a7ae15;
    var_2b03add3a518dea6 = params.var_2b03add3a518dea6;
    instance_id = params.instance_id;
    level.playholdtwovo = 1;
    game_object.capturetime = gettime();
    other_team_name = team_utility::getotherteam( team_name );
    team_flag_count = captureflag::function_ae0c1c2a2553b7d( team_name, 0 );
    other_team_flag_count = captureflag::function_ae0c1c2a2553b7d( other_team_name, 0 );
    
    if ( !isdefined( level.teamscoresonkill ) )
    {
        level.teamscoresonkill[ team_name ] = team_flag_count >= level.numflagsscoreonkill && team_flag_count >= level.flagsrequiredtoscore;
        level.teamscoresonkill[ other_team_name ] = other_team_flag_count >= level.numflagsscoreonkill && other_team_flag_count >= level.flagsrequiredtoscore;
    }
    
    objective_key = gameobjects_common::get_objective_key( game_object );
    
    if ( !isagent( var_dbd0d4c325a7ae15 ) || bots::function_e8c1a1cd1aaa5f82( var_dbd0d4c325a7ae15 ) )
    {
        hud_util::teamplayercardsplash( "callout_securedposition" + objective_key, var_dbd0d4c325a7ae15 );
    }
    
    dom::function_e1e9267b0fce374b( game_object, var_dbd0d4c325a7ae15 );
    dom::function_a76fd5e4a4f8281e( game_object, var_dbd0d4c325a7ae15, 0 );
    
    foreach ( var_bfcacfc3e65ffcb1 in var_2b03add3a518dea6 )
    {
        dom::function_e1e9267b0fce374b( game_object, var_bfcacfc3e65ffcb1 );
        dom::function_a76fd5e4a4f8281e( game_object, var_bfcacfc3e65ffcb1, 1 );
    }
    
    if ( level.usestrongholdscoring && team_flag_count == level.flagsrequiredtoscore )
    {
        dialog::statusdialog( #"friendly_scoring", team_name );
        dialog::statusdialog( #"enemy_scoring", other_team_name );
    }
    
    objective_list = game_utility_mp::get_gametype_objectives( instance_id );
    
    if ( !isdefined( level.firstcapture[ team_name ] ) )
    {
        foreach ( team in level.teamnamelist )
        {
            level.firstcapture[ team ] = 1;
        }
    }
    
    if ( team_flag_count < objective_list.size )
    {
        if ( level.firstcapture[ team_name ] )
        {
            level.firstcapture[ team_name ] = 0;
            dialog::leaderdialog( hashcat( #"captured", game_object.objective_key, "_first" ), team_name );
        }
        else
        {
            dialog::leaderdialog( hashcat( #"captured", game_object.objective_key ), team_name );
        }
        
        if ( namespace_277c922f0d0dc523::function_42fe8a34960d7a25( game_object ) == #"hash_bb332da19f9944df" )
        {
            if ( objective_list.size == 5 && ( objective_key == "_c" || objective_key == "_d" ) || objective_key == "_b" )
            {
                dialog::leaderdialog( hashcat( #"enemy_captured", objective_key ), other_team_name );
            }
        }
        else
        {
            dialog::leaderdialog( hashcat( #"enemy_captured", objective_key ), other_team_name );
        }
    }
    else
    {
        level callback::callback( #"music_event", { #team:team_name, #event_type:#"dominating" } );
        dialog::statusdialog( #"gamestate_domwinning", team_name );
        
        if ( function_73ed6c39195e9279( team_name, instance_id ) )
        {
            dialog::statusdialog( #"hash_155f070f08f4a32", other_team_name );
        }
        else
        {
            dialog::statusdialog( #"gamestate_domlosing", other_team_name );
        }
    }
    
    var_230c51749de05728 = team_flag_count == objective_list.size;
    var_d64a5f75a8ae9938 = var_230c51749de05728 ? #"dom_flag_captured_all" : #"dom_flag_captured";
    var_ec9f18f23b5e8565 = var_230c51749de05728 ? #"dom_flag_lost_all" : #"dom_flag_lost";
    gameplay_sound_fx::function_e319dc8e16c85fcb( var_d64a5f75a8ae9938, teams::getteamdata( team_name, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( var_ec9f18f23b5e8565, teams::getteamdata( other_team_name, "players" ) );
    level notify( #"dom_flag_captured", objective_key );
    game_object notify( #"dom_flag_captured" );
    var_dbd0d4c325a7ae15 notify( #"player_zone_captured", objective_key );
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x62f3ebf8, Offset: 0xd2de
// Size: 0x12b
function private function_c99c73b22179c9e( params )
{
    game_object = params.game_object;
    var_dbd0d4c325a7ae15 = params.var_dbd0d4c325a7ae15;
    var_2b03add3a518dea6 = params.var_2b03add3a518dea6;
    dom::function_70d9106ee4ee7de7( game_object, var_dbd0d4c325a7ae15, 0 );
    
    foreach ( var_bfcacfc3e65ffcb1 in var_2b03add3a518dea6 )
    {
        dom::function_70d9106ee4ee7de7( game_object, var_bfcacfc3e65ffcb1, 1 );
    }
    
    var_d0880e0df62e9f1 = namespace_277c922f0d0dc523::function_6f5941c8ee118d52( game_object );
    gameplay_sound_fx::function_6dac8db778849e61( #"dom_flag_neutralized_friendly", var_dbd0d4c325a7ae15.team );
    gameplay_sound_fx::function_6dac8db778849e61( #"dom_flag_neutralized_enemy", var_d0880e0df62e9f1 );
    level notify( #"dom_flag_neutralized", gameobjects_common::get_objective_key( game_object ) );
    game_object notify( #"dom_flag_neutralized" );
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x1fde7a49, Offset: 0xd411
// Size: 0x181
function private function_d4b22d655a2862b2( params )
{
    game_object = params.game_object;
    objidpoolmanager::update_objective_sethot( game_object.objidnum, 1 );
    objective_key = gameobjects_common::get_objective_key( game_object );
    var_27906a41998083f3 = function_5d53071a906a5c2( gameobjects_common::get_instance_id( game_object ) );
    dialogue_hash = var_27906a41998083f3 ? #"contested_all" : hashcat( #"contested", objective_key );
    
    foreach ( team_name in level.teamnamelist )
    {
        dialog::statusdialog( dialogue_hash, team_name );
    }
    
    current_time_ms = gettime();
    
    if ( !isdefined( level.arm.var_5d763679686d0227 ) || level.arm.var_5d763679686d0227 < current_time_ms )
    {
        game_object_origin = gameobjects_common::get_origin( game_object );
        level.arm.var_5d763679686d0227 = current_time_ms + 3000;
        gameplay_sound_fx::function_28103d3430792dce( game_object_origin, #"dom_flag_contested" );
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x17c8969e, Offset: 0xd59a
// Size: 0x121
function private function_388e5b690ab13813( params )
{
    game_object = params.game_object;
    objidpoolmanager::update_objective_sethot( game_object.objidnum, 0 );
    
    if ( gameobjects_common::function_7ed0697b0eea44f8( game_object ) )
    {
        objidpoolmanager::objective_show_progress( game_object.objidnum, 1 );
    }
    
    var_7f4958ce4e4277c3 = namespace_277c922f0d0dc523::function_9b71aa2788e21706( game_object );
    var_feacd6e9542ddd64 = namespace_277c922f0d0dc523::function_f559b5c2d3f6c691( game_object );
    
    if ( var_7f4958ce4e4277c3 == #"hash_bb332da19f9944df" || var_feacd6e9542ddd64 == #"hash_bb332da19f9944df" )
    {
        game_object.didstatusnotify = undefined;
    }
    
    current_time_ms = gettime();
    
    if ( !isdefined( level.arm.var_9269d8edf41adf0 ) || level.arm.var_9269d8edf41adf0 < current_time_ms )
    {
        game_object_origin = gameobjects_common::get_origin( game_object );
        level.arm.var_9269d8edf41adf0 = current_time_ms + 3000;
        gameplay_sound_fx::function_28103d3430792dce( game_object_origin, #"dom_flag_uncontested" );
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x6b1e5089, Offset: 0xd6c3
// Size: 0x2e
function private function_73da63d164186f8e( params )
{
    game_object = params.game_object;
    game_object.didstatusnotify = undefined;
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x4f115292, Offset: 0xd6f9
// Size: 0xd8
function private function_f2f9f8568f62caf9( params )
{
    game_object = params.game_object;
    var_3fb67f294d22fb9a = params.var_dbd0d4c325a7ae15;
    
    foreach ( player in var_3fb67f294d22fb9a )
    {
        dom::function_a0a44b051aa5b4e2( game_object, player );
        player stats::setextrascore2( player.pers[ "extraScore2" ] + 1 );
    }
    
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_c2dafde3d41b7bf7", var_3fb67f294d22fb9a );
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x35ad1319, Offset: 0xd7d9
// Size: 0x18b
function private function_d22b4b542b3280d3( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    var_efea8c5223ca7ba7 = params.var_efea8c5223ca7ba7;
    
    if ( var_efea8c5223ca7ba7 == 1 )
    {
        game_object thread function_2361b046dd0332a6( team_name );
        splashref = "gw_reinforce_tier_1";
    }
    else if ( var_efea8c5223ca7ba7 == 2 )
    {
        game_object thread function_7019255133284760( team_name );
        splashref = "gw_reinforce_care_package";
    }
    else if ( var_efea8c5223ca7ba7 == 3 )
    {
        game_object thread airdropvehicle( %"hash_32b7b34facdfbf9" );
        splashref = "gw_reinforce_tier_3";
    }
    
    otherteam = team_utility::getotherteam( team_name );
    dialog::leaderdialog( hashcat( #"enemy_reinforced", game_object.objective_key ), otherteam );
    playersinrange = getplayersinradius( gameobjects_common::get_origin( game_object ), 1024, undefined, undefined, undefined, team_name );
    
    foreach ( player in playersinrange )
    {
        player thread hud_message::showsplash( splashref );
        player thread points::doscoreevent( #"hash_e8d68b39aea47f06" );
    }
    
    update_objective_icon_state( game_object );
}

// Namespace arm
// Params 5, eflags: 0x4
// Checksum 0x184a2126, Offset: 0xd96c
// Size: 0xe7
function private function_c4c994513e12e838( splashref, origin, team, friendlydialogue, enemydialogue )
{
    playersinrange = getplayersinradius( origin, 1024, undefined, undefined, undefined, team );
    
    foreach ( player in playersinrange )
    {
        player thread hud_message::showsplash( splashref );
    }
    
    dialog::leaderdialog( friendlydialogue, team );
    
    if ( isdefined( enemydialogue ) )
    {
        otherteam = team_utility::getotherteam( team );
        dialog::leaderdialog( enemydialogue, otherteam );
    }
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0x57caefa9, Offset: 0xda5b
// Size: 0x169
function private update_objective_icon_state( game_object )
{
    state_hash = undefined;
    objective_key = gameobjects_common::get_objective_key( game_object );
    var_3ac424dee51a9b20 = namespace_277c922f0d0dc523::function_6f7e649cce3dd66b( game_object );
    
    if ( namespace_277c922f0d0dc523::is_contested( game_object ) )
    {
        state_hash = #"flag_contested";
    }
    else
    {
        var_536395db3d80fedb = namespace_277c922f0d0dc523::get_claim_team_hash( game_object );
        var_7f4958ce4e4277c3 = namespace_277c922f0d0dc523::function_9b71aa2788e21706( game_object );
        var_d07b2b95cdf20f0c = namespace_277c922f0d0dc523::function_a33241bbed7a745d( game_object );
        
        if ( var_7f4958ce4e4277c3 == #"hash_bb332da19f9944df" || var_536395db3d80fedb == #"hash_bb332da19f9944df" )
        {
            state_hash = #"flag_idle";
        }
        else if ( var_7f4958ce4e4277c3 != var_536395db3d80fedb )
        {
            state_hash = #"hash_539be8fb439cd022";
        }
        else if ( var_d07b2b95cdf20f0c == #"hash_bb332da19f9944df" || var_d07b2b95cdf20f0c == var_7f4958ce4e4277c3 )
        {
            var_af523c05ab1bbc54 = namespace_277c922f0d0dc523::function_865dc8c8e74399eb( game_object );
            
            if ( var_3ac424dee51a9b20 < var_af523c05ab1bbc54 )
            {
                state_hash = #"hash_cd7b7405122baba0";
            }
            else
            {
                state_hash = #"flag_defending";
            }
        }
        else
        {
            state_hash = #"flag_clearing";
        }
    }
    
    /#
        if ( !isdefined( state_hash ) )
        {
            assertmsg( "<dev string:x141>" );
            return;
        }
    #/
    
    state_hash = hashcat( state_hash, objective_key );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( game_object.objidnum, state_hash );
    setomnvar( "ui_overcap" + objective_key, var_3ac424dee51a9b20 );
}

// Namespace arm
// Params 1, eflags: 0xc
// Checksum 0xac60e87b, Offset: 0xdbcc
// Size: 0x55
function private function_b2257c2b3697f27f( objective_id )
{
    self notify( #"hash_3088321e7f08e6db" );
    self endon( #"hash_3088321e7f08e6db" );
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    objidpoolmanager::objective_set_play_intro( objective_id, 1 );
    objidpoolmanager::update_objective_state( objective_id, "current" );
}

// Namespace arm
// Params 2, eflags: 0x4
// Checksum 0x8c0682a1, Offset: 0xdc29
// Size: 0x96, Type: bool
function private function_80e2c69a995aac1a( team_hash, instance_id )
{
    foreach ( game_object in game_utility_mp::get_gametype_objectives( instance_id ) )
    {
        if ( namespace_277c922f0d0dc523::get_claim_team_hash( game_object ) != team_hash )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace arm
// Params 1, eflags: 0x4
// Checksum 0xb3142aa1, Offset: 0xdcc8
// Size: 0x8b, Type: bool
function private function_5d53071a906a5c2( instance_id )
{
    foreach ( game_object in game_utility_mp::get_gametype_objectives( instance_id ) )
    {
        if ( !namespace_277c922f0d0dc523::is_contested( game_object ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace arm
// Params 2, eflags: 0x4
// Checksum 0xa5c2e300, Offset: 0xdd5c
// Size: 0xc3, Type: bool
function private function_73ed6c39195e9279( team_hash, instance_id )
{
    foreach ( game_object in game_utility_mp::get_gametype_objectives( instance_id ) )
    {
        var_7f4958ce4e4277c3 = namespace_277c922f0d0dc523::function_9b71aa2788e21706( game_object );
        var_54c587af6e056efe = namespace_277c922f0d0dc523::function_42fe8a34960d7a25( game_object );
        
        if ( var_7f4958ce4e4277c3 != team_hash || var_54c587af6e056efe != #"hash_bb332da19f9944df" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace arm
// Params 0, eflags: 0x4
// Checksum 0xe586b613, Offset: 0xde28
// Size: 0x3fb
function private function_4ec32d549c4e343e()
{
    while ( !isdefined( level.sentrysettings[ "ai_sentry_turret" ] ) )
    {
        wait 1;
    }
    
    level.sentrysettings[ "ai_sentry_turret" ].health = 999999;
    level.sentrysettings[ "ai_sentry_turret" ].maxhealth = 10000;
    level.sentrysettings[ "ai_sentry_turret" ].burstmin = 20;
    level.sentrysettings[ "ai_sentry_turret" ].burstmax = 120;
    level.sentrysettings[ "ai_sentry_turret" ].pausemin = 0.15;
    level.sentrysettings[ "ai_sentry_turret" ].pausemax = 0.35;
    level.sentrysettings[ "ai_sentry_turret" ].lockstrength = 1;
    level.sentrysettings[ "ai_sentry_turret" ].sentrymodeon = "sentry";
    level.sentrysettings[ "ai_sentry_turret" ].var_3f1bd78402246e78 = "manual";
    level.sentrysettings[ "ai_sentry_turret" ].sentrymodeoff = "sentry_offline";
    level.sentrysettings[ "ai_sentry_turret" ].spinuptime = 1.5;
    level.sentrysettings[ "ai_sentry_turret" ].overheattime = 8;
    level.sentrysettings[ "ai_sentry_turret" ].cooldowntime = 0.3;
    level.sentrysettings[ "ai_sentry_turret" ].burstmaxtime = 4;
    level.sentrysettings[ "ai_sentry_turret" ].var_d435b063b8c608b2 = 3;
    level.sentrysettings[ "ai_sentry_turret" ].var_cb2d3675356e0b50 = 1;
    level.sentrysettings[ "ai_sentry_turret" ].leftarc = 70;
    level.sentrysettings[ "ai_sentry_turret" ].rightarc = 70;
    level.sentrysettings[ "ai_sentry_turret" ].fxtime = 0.3;
    level.sentrysettings[ "ai_sentry_turret" ].targetrange = 2500;
    level.sentrysettings[ "ai_sentry_turret" ].weaponinfo = "incursion_sentry_turret_mp";
    level.sentrysettings[ "ai_sentry_turret" ].playerweaponinfo = "incursion_sentry_turret_mp";
    level.sentrysettings[ "ai_sentry_turret" ].modelbaseground = "weapon_wm_shield_turret";
    level.sentrysettings[ "ai_sentry_turret" ].modeldestroyedground = "weapon_wm_shield_turret";
    struct_array = utility::getstructarray( "aiSentryTurret", "script_noteworthy" );
    
    if ( struct_array.size == 0 )
    {
        return;
    }
    
    foreach ( struct in struct_array )
    {
        turret = ai_sentry_turret::turret_spawn( struct );
        
        if ( isdefined( turret ) )
        {
            turret laseroff();
            turret.var_4b7baeb6c421bc04 = 1;
            turret makeusable();
            turret function_ec095c4067f1edba();
            turret setmode( "manual" );
            turret setuserange( 80 );
            turret sethintdisplayrange( 200 );
            turret setusefov( 120 );
            turret sethintdisplayfov( 120 );
            turret setcursorhint( "HINT_BUTTON" );
            turret sethintstring( &"mp/use_turret" );
        }
    }
}

