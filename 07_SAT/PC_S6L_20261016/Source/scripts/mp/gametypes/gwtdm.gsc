// scripts\mp\gametypes\gwtdm.gsc  (hash_0d17503f56b92539.gscc) (size: 101194 Bytes / 0x18b4a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b9792e9 (462918377)
// size ...... 101194 (0x18b4a)
// includes .. 63  (offset: 0x1711e)
// strings ... 302 (offset: 0x17316)
// dev strs .. 36  (offset: 0x1896a)
// exports ... 152 (offset: 0x11dd2)
// cseg ...... 0x199e + 0x10434 (0x11dd2)
// imports ... 424 (offset: 0x13592)
// animtree1 . 0   (offset: 0x18b4a)
// animtree2 . 0   (offset: 0x18b4a)
#using script_5ee7de915dfb9de4;
#using scripts\common\cap;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_airdrop;
#using scripts\common\vehicle_tracking;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\cash;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\game_utility_mp;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\dmz\gametypes\dmz_ai;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\parachute;
#using scripts\mp\playerlogic;
#using scripts\mp\rally_point;
#using scripts\mp\rank;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
#using scripts\mp\squads;

#namespace gwtdm;

// Namespace gwtdm
// Params 0
// Checksum 0x97aa31b8, Offset: 0x19bc
// Size: 0x9b3
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    allowed[ 1 ] = "arm";
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    setdvar( @"ai_allowdormancy", 0 );
    setdvar( @"hash_405e7e20d91344cc", 0 );
    setdvar( @"scr_allow_technicals", 1 );
    setdvar( @"scr_runlean_max_technicals", 30 );
    setdvar( @"hash_e4fa721677f03de0", 1 );
    setdvar( @"cg_friendlyrevivenameplateenabled", 0 );
    updategametypedvars();
    join_team_aggregator::registeronplayerjointeamcallback( &onjoinedteam );
    level.var_94f7e9904f6d47e4 = getdvarint( @"hash_c3babb46fe3fd12b", 1 ) == 1;
    level.scoreperplayer = undefined;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.onrespawndelay = &getrespawndelay;
    level.onnormaldeath = &onnormaldeath;
    level.var_efaf30b680072745 = &function_efaf30b680072745;
    level.var_21c20150e6597b09 = &function_21c20150e6597b09;
    level.onplayerconnectstream = &onplayerconnectstream;
    level.var_6788ac4109778b4b = [ "thermite_mp", "semtex_mp", "frag_grenade_mp", "jup_smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp" ];
    level.var_cec0acea1f6401cf = &function_cec0acea1f6401cf;
    level.requiredplayercountoveride = 1;
    level.requiredplayercount[ "allies" ] = 24;
    level.requiredplayercount[ "axis" ] = 24;
    level.var_5fb58f5bb9552416 = &getmissedinfilcamerapositions;
    level.var_81d027302ddd38f4 = &calculatecameraoffset;
    game[ "dialog" ][ "gametype" ] = "dx_mp_gwtd_game_mili_gtnm";
    
    if ( getdvarint( @"scr_diehard" ) )
    {
        game[ "dialog" ][ "gametype" ] = "dh_" + game[ "dialog" ][ "gametype" ];
    }
    else if ( dvars::function_13909a5327c395b9( "promode" ) )
    {
        game[ "dialog" ][ "gametype" ] = game[ "dialog" ][ "gametype" ] + "_pro";
    }
    
    game[ "dialog" ][ "offense_obj" ] = "dx_mp_gwtd_game_uktl_gtbs";
    game[ "dialog" ][ "defense_obj" ] = "dx_mp_gwtd_game_uktl_gtbs";
    game[ "dialog" ][ "lead_taken" ] = "dx_mp_gwtd_game_uktl_gtlg";
    game[ "dialog" ][ "lead_lost" ] = "dx_mp_gwtd_game_uktl_gtll";
    game[ "dialog" ][ "lead_tied" ] = "dx_mp_gwtd_game_uktl_gtlt";
    game[ "dialog" ][ "gwtdm_push_foward" ] = "dx_mp_gwtd_game_uktl_gtpo";
    game[ "dialog" ][ "gwtdm_fall_back" ] = "dx_mp_gwtd_game_uktl_gtpd";
    game[ "dialog" ][ "score_25_winning" ] = "dx_mp_gwtd_game_uktl_wi25";
    game[ "dialog" ][ "score_25_losing" ] = "dx_mp_gwtd_game_uktl_lo25";
    game[ "dialog" ][ "score_50_winning" ] = "dx_mp_gwtd_game_uktl_wi50";
    game[ "dialog" ][ "score_50_losing" ] = "dx_mp_gwtd_game_uktl_lo50";
    game[ "dialog" ][ "score_75_winning" ] = "dx_mp_gwtd_game_uktl_wi75";
    game[ "dialog" ][ "score_75_losing" ] = "dx_mp_gwtd_game_uktl_lo75";
    game[ "dialog" ][ "score_90_winning" ] = "dx_mp_gwtd_game_uktl_wi90";
    game[ "dialog" ][ "score_90_losing" ] = "dx_mp_gwtd_game_uktl_lo90";
    game[ "dialog" ][ "carepackage_inc" ] = "dx_mp_gwtd_game_uktl_gtcp";
    game[ "dialog" ][ "vehicles_inc" ] = "dx_mp_gwtd_game_uktl_gtv1";
    game[ "dialog" ][ "vehicles2_inc" ] = "dx_mp_gwtd_game_uktl_gtv2";
    game[ "dialog" ][ "tier2_friendly" ] = "dx_mp_gwtd_game_uktl_frt2";
    game[ "dialog" ][ "tier2_enemy" ] = "dx_mp_gwtd_game_uktl_ent2";
    game[ "dialog" ][ "tier3_friendly" ] = "dx_mp_gwtd_game_uktl_frt3";
    game[ "dialog" ][ "tier3_enemy" ] = "dx_mp_gwtd_game_uktl_ent3";
    level.nosuspensemusic = 1;
    level._effect[ "vfx_smk_signal_gr" ] = loadfxasset( "vfx_requests_mp_gameplay_smoke_signal_gr" );
    level._effect[ "vfx_snatch_ac130_clouds" ] = loadfxasset( "vfx_iw8_mp_gamemode_snatch_ac130_clouds" );
    level._effect[ "vfx_br_infil_cloud_scroll" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_cloud_scroll" );
    level._effect[ "vfx_br_infil_jump_smoke_01" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_smoke_01" );
    level._effect[ "vfx_br_infil_jump_smoke_01_enemy" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_smoke_01_enemy" );
    level._effect[ "vfx_br_infil_jump_smoke_01_friendly" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_smoke_01_friendly" );
    level._effect[ "vfx_br_infil_jump_wisp_01" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_wisp_01" );
    level._effect[ "vfx_br_infil_jump_wisp_02" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_wisp_02" );
    level._effect[ "vfx_br_infil_omni_light" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_omni_light" );
    level._effect[ "vfx_br_infil_spot_light" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_spot_light" );
    level._effect[ "vfx_gameplay_tier2_helmet_pop" ] = loadfxasset( "vfx_iw9_gameplay_mp_tier2_helmet_pop" );
    level._effect[ "vfx_gameplay_tier3_helmet_pop" ] = loadfxasset( "vfx_iw9_gameplay_mp_tier3_helmet_pop" );
    level.disablespectate = getdvarint( @"hash_6228446f42d1367f", 1 ) == 1;
    level.userallypointvehicles = getdvarint( @"hash_9381d93d96c2f50b", 1 );
    level.hideenemyhq = getdvarint( @"hash_5309488dd7832413", 0 );
    level.hideenemyfobs = getdvarint( @"hash_7aefd938edd32dcc", 0 );
    level.completelyremovelittlebird = getdvarint( @"hash_e39e476d418a5b03", 0 );
    level.var_7f0a2d7de93a21d3 = getdvarint( @"hash_e4a8296b521a6dee", 1 ) == 1;
    level.var_1273a5ffe332df4d = getdvarfloat( @"hash_91d950c33d45ae50", 60 );
    level.var_4e367de5c2d6631e = getdvarfloat( @"hash_58c456ebd6371a4b", 60 );
    level.var_b9ea12c4f2229c53 = getdvarint( @"hash_19e5cada53ccf044", 0 ) == 1;
    level.var_65526c5c4e8f9d90 = getdvarint( @"hash_67a32114ce80b58f", 0 ) == 1;
    level.var_576f7155d6a0fa48 = getdvarint( @"hash_27abaa55d7ec8eb9", 1 ) == 1;
    level.var_49774490cf05bdac = getdvarint( @"hash_a3d174d73bea831", 1 ) == 1;
    level.var_8bca5ca707b08206 = getdvarint( @"hash_d23a54732db0acd0", 1 ) == 1;
    level.var_8bca5ba707b07fd3 = getdvarint( @"hash_d23a57732db0b369", 1 ) == 1;
    level.var_2d9fd980185f6441 = getdvarint( @"hash_72771bed0cb9e6fb", 1 ) == 1;
    level.var_17ba11f8d5742c70 = getdvarint( @"hash_d141c82b315573ed", 9 );
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
    level.numnonrallyvehicles = getdvarint( @"scr_arm_numnonrallyvehicles", 25 );
    level.disablepersonalnuke = getdvarint( @"hash_f271257bddc28c95", 0 );
    level.personalnukecostoverride = getdvarint( @"scr_personalnukecostoverride", 30 );
    level.showteamtanks = getdvarint( @"scr_arm_showteamtanks", 1 );
    level.spawnselectionafktime = getdvarint( @"hash_da4e1d4c2111a1bc", 120 );
    level.manualadjustlittlebirdlocs = getdvarint( @"hash_1d04716268113cb5", 1 );
    level.var_36fe9de96e296f76 = getdvarint( @"hash_47d44a6b84f34214", 1 );
    level.var_a9acecc24d824633 = [];
    
    if ( level.showteamtanks )
    {
        level.trackedtanks = [];
        level.trackedtanks[ "axis" ] = [];
        level.trackedtanks[ "allies" ] = [];
    }
    
    level.modecontrolledvehiclespawningonly = 1;
    level.disableteamstartspawns = 1;
    level.spawnprotectionexception = &spawnprotectionexception;
    thread function_e42623be2d62d389();
    utility::flag_init( "stealth_enabled" );
    utility::flag_init( "level_stealth_initialized" );
    utility::flag_init( "stealth_spotted" );
    
    /#
        level thread function_4825c3ae120a715c();
        level thread debugnodes();
    #/
}

// Namespace gwtdm
// Params 1
// Checksum 0x31657a23, Offset: 0x2377
// Size: 0x10a
function function_cec0acea1f6401cf( tier )
{
    switch ( tier )
    {
        case 1:
            return utility::array_random( [ "equip_semtex", "equip_frag", "equip_gas_grenade" ] );
        case 2:
            return utility::array_random( [ "equip_semtex", "equip_frag", "equip_smoke", "equip_concussion", "equip_flash", "equip_gas_grenade", "equip_decoy" ] );
        case 3:
            return utility::array_random( [ "equip_thermite", "equip_semtex", "equip_frag", "equip_smoke", "equip_concussion", "equip_flash", "equip_snapshot_grenade", "equip_gas_grenade", "equip_decoy" ] );
        default:
            return;
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xd5f7ae07, Offset: 0x2489
// Size: 0xdb
function debugnodes()
{
    while ( true )
    {
        foreach ( t in getnodearray( "traverse", #targetname ) )
        {
            if ( issubstr( t.animscript, "jump_" ) )
            {
                /#
                    line( t.origin, t.origin + ( 0, 0, 1024 ), ( 1, 0, 0 ), 1, 0, 150 );
                #/
            }
        }
        
        wait 5;
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xeb7a91b2, Offset: 0x256c
// Size: 0xcd
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_gwtdm_zonelifetime", getmatchrulesdata( "kothData", "zoneLifetime" ) );
    setdynamicdvar( @"scr_gwtdm_zonecapturetime", getmatchrulesdata( "kothData", "zoneCaptureTime" ) );
    setdynamicdvar( @"scr_gwtdm_zoneactivationdelay", getmatchrulesdata( "kothData", "zoneActivationDelay" ) );
    setdynamicdvar( @"scr_gwtdm_randomlocationorder", getmatchrulesdata( "kothData", "randomLocationOrder" ) );
    setdynamicdvar( @"scr_gwtdm_additivescoring", getmatchrulesdata( "kothData", "additiveScoring" ) );
    setdynamicdvar( @"scr_gwtdm_pausetime", getmatchrulesdata( "kothData", "pauseTime" ) );
    setdynamicdvar( @"hash_13b7111b0a7197b", getmatchrulesdata( "tdefData", "spawnDelay" ) );
}

// Namespace gwtdm
// Params 0
// Checksum 0x5e7408e7, Offset: 0x2641
// Size: 0x353
function onstartgametype()
{
    utility::flag_init( "frontline_data_init" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    foreach ( team in level.teamnamelist )
    {
        game_utility_mp::setobjectivehinttext( team, &"objectives/gwtdm_hint" );
    }
    
    setclientnamemode( "auto_change" );
    level.objectives = [];
    level.uncapturableobjectives = [];
    level.var_f2008c8cec87e2a0 = getdvarint( @"hash_b43bff2a3dd04855", 0 ) == 1;
    debug_setupmatchdata();
    setuphqs();
    initspawns();
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
    calculatehqmidpoint();
    sethqmarkerobjective();
    
    if ( level.usespawnselection )
    {
        level thread function_d02568f191a3a990();
    }
    
    if ( level.userallypointvehicles )
    {
        rally_point::init();
        level thread arm_vehicles::init_rallyvehicles();
    }
    
    level.numhqtanks_axis = 0;
    level.numhqtanks_allies = 0;
    level.maxhqtanks = 0;
    thread arm_vehicles::function_8d849241da3b9f6e();
    level thread spawnselection::updatefobindanger();
    dialog::initstatusdialog();
    emergency_cleanupents();
    level thread function_27b8e503a3ebacc8();
    
    if ( getdvarint( @"hash_248a817b330f8bea", 1 ) == 1 )
    {
        level function_92af315acf2d769c();
    }
    
    parachute::initparachutedvars();
    
    if ( getdvarint( @"hash_48d28ba522840d33", 1 ) == 1 )
    {
        level thread initai();
    }
    
    if ( getdvarint( @"hash_289d6da5e0aff476", 1 ) == 1 )
    {
        level thread function_8e7db35db37b293c();
    }
    
    level thread function_eef6ed990b709dfc();
    level thread function_86d33777378071d9();
    
    if ( level.frontlinedata[ 0 ].lanedata[ 0 ].frontvolume.size > 0 )
    {
        level thread function_c60ac6c44b0f37dd( "axis" );
        level thread function_c60ac6c44b0f37dd( "allies" );
    }
    
    level thread function_3097b40a9007d703();
}

// Namespace gwtdm
// Params 0
// Checksum 0xe083c010, Offset: 0x299c
// Size: 0x17f
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.var_e9b33636f46b851c = dvars::dvarintvalue( "gainPlantedSites", 0, 0, 1 );
    level.var_34690de86f48cef7 = dvars::dvarintvalue( "loseDestroyedSites", 1, 0, 1 );
    level.var_8da7159612e82989 = dvars::dvarintvalue( "gainDestroyedSites", 0, 0, 1 );
    level.pausescoring = dvars::dvarintvalue( "pauseTime", 1, 0, 1 );
    level.spawndelay = dvars::dvarfloatvalue( "spawnDelay", 5, 0, 30 );
    level.flagcapturetime = dvars::dvarfloatvalue( "flagCaptureTime", 30, 0, 30 );
    level.flagsrequiredtoscore = dvars::dvarintvalue( "flagsRequiredToScore", 1, 1, 3 );
    level.pointsperflag = dvars::dvarintvalue( "pointsPerFlag", 1, 1, 300 );
    level.flagneutralization = dvars::dvarintvalue( "flagNeutralization", 0, 0, 1 );
    level.precappoints = dvars::dvarintvalue( "preCapPoints", 0, 0, 1 );
    level.capturedecay = dvars::dvarintvalue( "captureDecay", 1, 0, 1 );
    level.capturetype = dvars::dvarintvalue( "captureType", 1, 0, 3 );
    level.numflagsscoreonkill = dvars::dvarintvalue( "numFlagsScoreOnKill", 0, 0, 3 );
    level.objectivescaler = dvars::dvarfloatvalue( "objScalar", 4, 1, 10 );
    level.pointsperkillai = dvars::dvarintvalue( "pointsperkill_ai", 1, 0, 10 );
}

// Namespace gwtdm
// Params 0
// Checksum 0x9662fe0b, Offset: 0x2b23
// Size: 0x2
function seticonnames()
{
    
}

// Namespace gwtdm
// Params 0
// Checksum 0x3974980e, Offset: 0x2b2d
// Size: 0x334
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
    
    if ( level.localeid == "locale_6" )
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

// Namespace gwtdm
// Params 0
// Checksum 0x40bb8477, Offset: 0x2e69
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

// Namespace gwtdm
// Params 1
// Checksum 0x221d9bda, Offset: 0x2fc9
// Size: 0xc
function onjoinedteam( player )
{
    
}

// Namespace gwtdm
// Params 0
// Checksum 0xbfcbde9c, Offset: 0x2fdd
// Size: 0x36
function debug_setupmatchdata()
{
    level.var_76c4dc73f6b30344 = [];
    level.var_76c4dc73f6b30344[ "axis" ] = "gw_fob_axisHQ";
    level.var_76c4dc73f6b30344[ "allies" ] = "gw_fob_alliesHQ";
}

// Namespace gwtdm
// Params 0
// Checksum 0x75b35ccd, Offset: 0x301b
// Size: 0x14c
function setupwaypointicons()
{
    while ( !isdefined( game[ "killstreakTable" ] ) )
    {
        waitframe();
    }
    
    foreach ( var_990d1998908bd83c, data in game[ "killstreakTable" ].tabledatabyref )
    {
        level.waypointcolors[ var_990d1998908bd83c + "_incoming" ] = "neutral";
        level.waypointbgtype[ var_990d1998908bd83c + "_incoming" ] = 1;
        level.waypointstring[ var_990d1998908bd83c + "_incoming" ] = "";
        level.waypointshader[ var_990d1998908bd83c + "_incoming" ] = data.hudicon;
        level.waypointpulses[ var_990d1998908bd83c + "_incoming" ] = 0;
        level.waypointcolors[ var_990d1998908bd83c ] = "neutral";
        level.waypointbgtype[ var_990d1998908bd83c ] = 1;
        level.waypointstring[ var_990d1998908bd83c ] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
        level.waypointshader[ var_990d1998908bd83c ] = data.hudicon;
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x9b7ae335, Offset: 0x316f
// Size: 0xf1
function setuphqs()
{
    level.gw_objstruct = spawnstruct();
    level.gw_objstruct.axishqloc = spawnstruct();
    level.gw_objstruct.axishqloc.trigger = game_utility::getlocaleent( level.var_76c4dc73f6b30344[ "axis" ] );
    
    if ( !isdefined( level.gw_objstruct.axishqloc ) )
    {
        assert( 0, "<dev string:x24>" );
    }
    
    level.gw_objstruct.allieshqloc = spawnstruct();
    level.gw_objstruct.allieshqloc.trigger = game_utility::getlocaleent( level.var_76c4dc73f6b30344[ "allies" ] );
    
    if ( !isdefined( level.gw_objstruct.allieshqloc ) )
    {
        assert( 0, "<dev string:x45>" );
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0x5c1c1896, Offset: 0x3268
// Size: 0x205
function function_d02568f191a3a990( numobjs )
{
    level.spawnareas = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.spawnareas[ entry ] = [ level.var_76c4dc73f6b30344[ entry ] ];
    }
    
    spawnselection::setspawnlocations( level.spawnareas[ "axis" ], "axis" );
    spawnselection::setspawnlocations( level.spawnareas[ "allies" ], "allies" );
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    waitframe();
    
    if ( isdefined( level.spawnselectionlocations[ level.var_76c4dc73f6b30344[ "axis" ] ][ "axis" ].anchorentity ) )
    {
        level.spawnselectionlocations[ level.var_76c4dc73f6b30344[ "axis" ] ][ "axis" ].anchorentity.origin = level.gw_objstruct.axishqloc.trigger.origin;
    }
    
    if ( isdefined( level.spawnselectionlocations[ level.var_76c4dc73f6b30344[ "allies" ] ][ "allies" ].anchorentity ) )
    {
        level.spawnselectionlocations[ level.var_76c4dc73f6b30344[ "allies" ] ][ "allies" ].anchorentity.origin = level.gw_objstruct.allieshqloc.trigger.origin;
    }
    
    level thread objective_manageobjectivesintrovisibility();
}

// Namespace gwtdm
// Params 0
// Checksum 0xd01331eb, Offset: 0x3475
// Size: 0x26f
function objective_manageobjectivesintrovisibility()
{
    wait 1;
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.axishqloc.marker.objidnum );
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.allieshqloc.marker.objidnum );
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.axishqloc.enemymarker.objidnum );
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.allieshqloc.enemymarker.objidnum );
    
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
    
    objidpoolmanager::objective_teammask_addtomask( level.gw_objstruct.axishqloc.marker.objidnum, "axis" );
    objidpoolmanager::objective_teammask_addtomask( level.gw_objstruct.allieshqloc.marker.objidnum, "allies" );
    
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

// Namespace gwtdm
// Params 0
// Checksum 0x25ced85d, Offset: 0x36ec
// Size: 0x10a
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
    
    team = "allies";
    forward = level.spawnselectionteamforward[ team ];
    
    if ( level.usespawnselection )
    {
        keys = [ "gw_fob_alliesHQ", "_d", "_e", "_f" ];
    }
    else
    {
        keys = [ "default" ];
    }
    
    spawncamera::function_b0323f4b0200f492( keys, team, forward, -8500, 7000 );
    team = "axis";
    forward = level.spawnselectionteamforward[ team ];
    
    if ( level.usespawnselection )
    {
        keys = [ "gw_fob_axisHQ", "_a", "_b", "_c" ];
    }
    else
    {
        keys = [ "default" ];
    }
    
    spawncamera::function_b0323f4b0200f492( keys, team, forward, -8500, 7000 );
}

// Namespace gwtdm
// Params 0
// Checksum 0xc7671bcb, Offset: 0x37fe
// Size: 0x509
function sethqmarkerobjective()
{
    visibility = "any";
    origin = level.gw_objstruct.axishqloc.trigger.origin;
    marker = gameobjects::createobjidobject( origin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, "axis" );
    objidpoolmanager::objective_teammask_addtomask( marker.objidnum, "axis" );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    objidpoolmanager::update_objective_icon( marker.objidnum, "icon_waypoint_hq_friendly" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 6 );
    marker.lockupdatingicons = 1;
    level.gw_objstruct.axishqloc.marker = marker;
    level.uncapturableobjectives[ level.uncapturableobjectives.size ] = marker;
    marker = gameobjects::createobjidobject( origin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, "axis" );
    objidpoolmanager::objective_teammask_addtomask( marker.objidnum, "allies" );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    objidpoolmanager::update_objective_icon( marker.objidnum, "icon_waypoint_hq_enemy" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 7 );
    marker.lockupdatingicons = 1;
    level.gw_objstruct.axishqloc.enemymarker = marker;
    level.uncapturableobjectives[ level.uncapturableobjectives.size ] = marker;
    origin = level.gw_objstruct.allieshqloc.trigger.origin;
    marker = gameobjects::createobjidobject( origin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, "allies" );
    objidpoolmanager::objective_teammask_addtomask( marker.objidnum, "allies" );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    objidpoolmanager::update_objective_icon( marker.objidnum, "icon_waypoint_hq_friendly" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 6 );
    marker.lockupdatingicons = 1;
    level.gw_objstruct.allieshqloc.marker = marker;
    level.uncapturableobjectives[ level.uncapturableobjectives.size ] = marker;
    marker = gameobjects::createobjidobject( origin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, "allies" );
    objidpoolmanager::objective_teammask_addtomask( marker.objidnum, "axis" );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    objidpoolmanager::update_objective_icon( marker.objidnum, "icon_waypoint_hq_enemy" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 7 );
    marker.lockupdatingicons = 1;
    level.gw_objstruct.allieshqloc.enemymarker = marker;
    level.uncapturableobjectives[ level.uncapturableobjectives.size ] = marker;
    level.spawnselectionteamforward = [];
    level.spawnselectionteamforward[ "allies" ] = vectornormalize( level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin );
    level.spawnselectionteamforward[ "axis" ] = vectornormalize( level.gw_objstruct.allieshqloc.trigger.origin - level.gw_objstruct.axishqloc.trigger.origin );
}

// Namespace gwtdm
// Params 3
// Checksum 0xbfd55209, Offset: 0x3d0f
// Size: 0x4b
function dropcrate( killstreakname, droplocation, team )
{
    crate = airdrop::function_33be22261f18a20d( team, killstreakname, droplocation.origin, ( 0, randomint( 360 ), 0 ), undefined );
    return crate;
}

// Namespace gwtdm
// Params 3
// Checksum 0x1cd173d3, Offset: 0x3d63
// Size: 0xf2
function docratedropsmoke( crate, droplocation, duration )
{
    var_281ff1613bb07988 = droplocation + ( 0, 0, 2000 );
    spawnpos = utility::groundpos( var_281ff1613bb07988, ( 0, 0, 1 ) );
    vfxent = spawn( "script_model", spawnpos );
    vfxent setmodel( "tag_origin" );
    vfxent.angles = ( 0, 0, 0 );
    vfxent playloopsound( "smoke_carepackage_smoke_lp" );
    wait 1;
    playfxontag( utility::getfx( "vfx_smk_signal_gr" ), vfxent, "tag_origin" );
    
    if ( isdefined( crate ) )
    {
        crate utility::waittill_any_timeout( duration, "crate_dropped" );
    }
    else
    {
        wait duration;
    }
    
    stopfxontag( utility::getfx( "vfx_smk_signal_gr" ), vfxent, "tag_origin" );
    vfxent delete();
}

// Namespace gwtdm
// Params 0
// Checksum 0x483c60cc, Offset: 0x3e5d
// Size: 0x21b
function function_92af315acf2d769c()
{
    level.cratelocs = [];
    locs = utility::getstructarray( "carepackage_loc", "targetname" );
    
    foreach ( loc in locs )
    {
        struct = spawnstruct();
        struct.origin = loc.origin;
        struct.angles = loc.angles;
        struct.inuse = 0;
        struct.isvehiclerestricted = 0;
        
        if ( loc.script_noteworthy == "noVehicleDrop" )
        {
            struct.isvehiclerestricted = 1;
        }
        
        /#
            if ( getdvarint( @"hash_1af6b48d9e65d84c", 0 ) == 1 )
            {
                color = ( 0, 1, 0 );
                
                if ( struct.isvehiclerestricted )
                {
                    color = ( 1, 0, 0 );
                }
                
                print3d( struct.origin, "<dev string:x68>" + struct.origin[ 0 ] + "<dev string:x6b>" + struct.origin[ 1 ] + "<dev string:x6b>" + struct.origin[ 2 ] + "<dev string:x6e>", ( 1, 1, 1 ), 1, 1, 9999, 1 );
                thread debug::drawsphere( struct.origin, 128, 9999, color );
                thread debug::drawline( struct.origin, struct.origin + ( 0, 0, 2000 ), 9999, color );
            }
        #/
        
        level.cratelocs[ level.cratelocs.size ] = struct;
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xd2df8105, Offset: 0x4080
// Size: 0x22a
function killstreakcrateloop()
{
    level endon( #"game_ended" );
    level notify( #"killstreakcrateloop" );
    level endon( #"killstreakcrateloop" );
    level.var_3a32ce25e2d60704 = 0;
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    interval = getdvarint( @"hash_25b96a647e40df81", 120 );
    var_fd333c79f9d50eff = getdvarint( @"hash_4220024cbeafaee2", 1 ) == 1;
    
    while ( true )
    {
        foreach ( team in level.teamnamelist )
        {
            dialog::statusdialog( "carepackage_inc", team, 1 );
            hud_util::showsplashtoteam( team, "gwtdm_carepackage_inc" );
        }
        
        if ( !var_fd333c79f9d50eff )
        {
            dropkillstreakcrate();
        }
        else
        {
            data = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ];
            
            for ( lanekey = 0; lanekey < data.lanedata.size ; lanekey++ )
            {
                lanedata = data.lanedata[ lanekey ];
                
                if ( level.var_f9f9bdd4e4094d63 < level.startingfrontline && function_1c40c0f13631d550( "axis" ) )
                {
                    droporigin = lanedata.frontvolume[ "axis" ].origin;
                }
                else if ( level.var_f9f9bdd4e4094d63 > level.startingfrontline && function_1c40c0f13631d550( "allies" ) )
                {
                    droporigin = lanedata.frontvolume[ "allies" ].origin;
                }
                else
                {
                    droporigin = lanedata.origin;
                }
                
                dropkillstreakcrate( droporigin );
                wait randomintrange( 5, 8 );
            }
        }
        
        wait interval;
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0xa10784a9, Offset: 0x42b2
// Size: 0x70, Type: bool
function function_1c40c0f13631d550( var_43be3d3179fa8261 )
{
    axisscore = getteamscore( "axis" );
    alliesscore = getteamscore( "allies" );
    
    if ( var_43be3d3179fa8261 == "axis" )
    {
        if ( axisscore * 1.3 < alliesscore )
        {
            return true;
        }
    }
    else if ( var_43be3d3179fa8261 == "allies" )
    {
        if ( alliesscore * 1.3 < axisscore )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gwtdm
// Params 1
// Checksum 0xd2d6a241, Offset: 0x432b
// Size: 0xcd
function dropkillstreakcrate( droporigin )
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
    
    if ( level.var_3a32ce25e2d60704 >= level.var_17ba11f8d5742c70 )
    {
        return;
    }
    
    location = choosecratelocation( droporigin );
    
    if ( isdefined( location ) )
    {
        thread runkillstreakreward( location, owningplayer );
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0xd4a40726, Offset: 0x4400
// Size: 0x30c
function choosecratelocation( droporigin )
{
    if ( isdefined( droporigin ) )
    {
        var_940651cc6f36caac = droporigin;
    }
    else
    {
        randfrac = randomfloatrange( 0, 1 );
        
        if ( level.var_f9f9bdd4e4094d63 < level.startingfrontline && function_1c40c0f13631d550( "axis" ) )
        {
            minpoint = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ 0 ].frontvolume[ "axis" ].origin;
            var_4520fb744be884c6 = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata.size;
            maxpoint = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ var_4520fb744be884c6 ].frontvolume[ "axis" ].origin;
        }
        else if ( level.var_f9f9bdd4e4094d63 > level.startingfrontline && function_1c40c0f13631d550( "allies" ) )
        {
            minpoint = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ 0 ].frontvolume[ "allies" ].origin;
            var_4520fb744be884c6 = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata.size;
            maxpoint = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ var_4520fb744be884c6 ].frontvolume[ "allies" ].origin;
        }
        else
        {
            minpoint = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].minpoint;
            maxpoint = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].maxpoint;
        }
        
        var_940651cc6f36caac = vectorlerp( minpoint, maxpoint, randfrac );
    }
    
    trace = trace::ray_trace( var_940651cc6f36caac, var_940651cc6f36caac - ( 0, 0, 100000 ) );
    var_940651cc6f36caac = trace[ "position" ];
    var_ef72f25a3bc4b7f8 = findclosestdroplocation( var_940651cc6f36caac );
    
    if ( false )
    {
        thread debug::drawline( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].minpoint, level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].maxpoint, 1000, ( 0, 1, 1 ) );
        thread debug::drawsphere( var_940651cc6f36caac, 100, 1000, ( 1, 0, 0 ) );
        thread debug::drawsphere( var_ef72f25a3bc4b7f8.origin, 100, 1000, ( 0, 1, 0 ) );
        thread debug::drawline( var_940651cc6f36caac, var_ef72f25a3bc4b7f8.origin, 1000, ( 0, 1, 0 ) );
    }
    
    return var_ef72f25a3bc4b7f8;
}

// Namespace gwtdm
// Params 2
// Checksum 0x80af4b5e, Offset: 0x4715
// Size: 0x90
function findclosestdroplocation( origin, isvehicledrop )
{
    sortedlocs = function_628bac9faa9d1e86( level.cratelocs, origin );
    
    for ( i = 0; i < sortedlocs.size ; i++ )
    {
        loc = sortedlocs[ i ];
        
        if ( loc.inuse )
        {
            continue;
        }
        
        if ( isvehicledrop && loc.isvehiclerestricted )
        {
            continue;
        }
        
        loc.inuse = 1;
        return loc;
    }
}

// Namespace gwtdm
// Params 2
// Checksum 0xe0116f13, Offset: 0x47ae
// Size: 0x36b
function runkillstreakreward( location, creditplayer )
{
    level endon( #"game_ended" );
    streakname = airdrop::function_7d75d85a4d6963a4( creditplayer.team );
    crate = undefined;
    object = gameobjects::createobjidobject( location.origin, "neutral", ( 0, 0, 72 ), undefined, "any" );
    object.origin = location.origin;
    thread docratedropsmoke( undefined, location.origin, 16 );
    object.iconname = "_incoming";
    object.lockupdatingicons = 0;
    object gameobjects::setobjectivestatusicons( "carepackage" );
    objidpoolmanager::update_objective_setbackground( object.objidnum, 8 );
    object.lockupdatingicons = 1;
    waittime = getdvarint( @"hash_41f80710e72eb107", 5 );
    wait waittime;
    crate = airdrop::function_33be22261f18a20d( creditplayer.team, streakname, location.origin, ( 0, randomint( 360 ), 0 ), undefined );
    
    if ( !isdefined( crate ) )
    {
        object gameobjects::setvisibleteam( "none" );
        object gameobjects::releaseid();
        object.visibleteam = "none";
        location.inuse = 0;
        return;
    }
    
    crate.skipminimapicon = 1;
    crate.nevertimeout = 0;
    crate.waitforobjectiveactivate = 1;
    crate.killminimapicon = 0;
    crate.disallowheadiconid = 1;
    crate.isarmcrate = 1;
    level.var_3a32ce25e2d60704 += 1;
    usetime = getdvarfloat( @"hash_d25321c867cf3a80", 10 );
    crate.usetimeoverride = usetime;
    crate waittill( #"crate_dropped" );
    
    if ( !isdefined( crate ) )
    {
        object gameobjects::setvisibleteam( "none" );
        object gameobjects::releaseid();
        object.visibleteam = "none";
        location.inuse = 0;
        return;
    }
    
    object.useobj = crate;
    object.origin = crate.origin;
    crate notify( #"objective_activate" );
    objidpoolmanager::update_objective_onentity( object.objidnum, crate );
    objidpoolmanager::update_objective_setzoffset( object.objidnum, 72 );
    object.iconname = "";
    object.lockupdatingicons = 0;
    object gameobjects::setobjectivestatusicons( "carepackage" );
    object.lockupdatingicons = 1;
    objidpoolmanager::update_objective_setbackground( object.objidnum, 8 );
    objective_setlabel( object.objidnum, "" );
    crate waittill( #"death" );
    level.var_3a32ce25e2d60704 -= 1;
    object gameobjects::setvisibleteam( "none" );
    object gameobjects::releaseid();
    object.visibleteam = "none";
    location.inuse = 0;
}

// Namespace gwtdm
// Params 0
// Checksum 0x84d5fb40, Offset: 0x4b21
// Size: 0x516
function initspawns()
{
    level.gamemodestartspawnpointnames = [];
    
    if ( spawnselection::function_fc43ecf617088f49() )
    {
        var_8e0b555d6a1fce7c = "mp_gw_spawn_allies_start";
        var_ce31d0f10d5f8fab = "mp_gw_spawn_axis_start";
        level.gamemodestartspawnpointnames[ "allies" ] = var_8e0b555d6a1fce7c;
        level.gamemodestartspawnpointnames[ "axis" ] = var_ce31d0f10d5f8fab;
        level.gamemodespawnpointnames = [];
        level.gamemodespawnpointnames[ "allies" ] = "mp_tdm_spawn";
        level.gamemodespawnpointnames[ "axis" ] = "mp_tdm_spawn";
        spawnlogic::function_6dbabb72223a4bca();
        spawnlogic::setactivespawnlogic( #"default" );
        spawnlogic::addstartspawnpoints( var_8e0b555d6a1fce7c );
        spawnlogic::addstartspawnpoints( var_ce31d0f10d5f8fab );
        spawnlogic::addspawnpointslegacy( "allies", var_8e0b555d6a1fce7c );
        spawnlogic::addspawnpointslegacy( "axis", var_ce31d0f10d5f8fab );
        alliesstartspawns = spawnlogic::getspawnpointarray( var_8e0b555d6a1fce7c );
        axisstartspawns = spawnlogic::getspawnpointarray( var_ce31d0f10d5f8fab );
        spawnlogic::registerspawnset( "start_allies", alliesstartspawns );
        spawnlogic::registerspawnset( "start_axis", axisstartspawns );
        spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn" );
        spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn" );
        spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn_secondary", 1, 1 );
        spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn_secondary", 1, 1 );
        spawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
        spawnssecondary = spawnlogic::getspawnpointarray( "mp_tdm_spawn_secondary" );
        spawnlogic::registerspawnset( #"primary", spawns );
        spawnlogic::registerspawnset( #"fallback", spawnssecondary );
        spawnlogic::finalizemap();
        level.spawnpoints = spawns;
    }
    else if ( level.var_f2008c8cec87e2a0 )
    {
        level.modespawnclient = &modespawn;
        level.modeplayerkilledspawn = &playerkilledspawn;
        level.parachutedeploydelay = getdvarfloat( @"hash_922022ea1fcaa09a", 1.5 );
    }
    else
    {
        var_8e0b555d6a1fce7c = "mp_gw_spawn_allies_start";
        var_ce31d0f10d5f8fab = "mp_gw_spawn_axis_start";
        var_ccffb551411b7e87 = "mp_tdm_spawn";
        spawnlogic::function_6dbabb72223a4bca();
        level.var_c81115c94d2d62b3 = [];
        level.var_c81115c94d2d62b3[ "allies" ] = "start_allies";
        level.var_c81115c94d2d62b3[ "axis" ] = "start_axis";
        level.var_2ce763571761b799 = [];
        level.var_2ce763571761b799[ "allies" ] = "normal_allies";
        level.var_2ce763571761b799[ "axis" ] = "normal_axis";
        spawnlogic::addstartspawnpoints( var_8e0b555d6a1fce7c );
        spawnlogic::addstartspawnpoints( var_ce31d0f10d5f8fab );
        spawnlogic::addspawnpointslegacy( "allies", var_8e0b555d6a1fce7c );
        spawnlogic::addspawnpointslegacy( "axis", var_ce31d0f10d5f8fab );
        alliesstartspawns = spawnlogic::getspawnpointarray( var_8e0b555d6a1fce7c );
        axisstartspawns = spawnlogic::getspawnpointarray( var_ce31d0f10d5f8fab );
        spawnlogic::registerspawnset( "start_allies", alliesstartspawns );
        spawnlogic::registerspawnset( "start_axis", axisstartspawns );
        spawnlogic::addspawnpointslegacy( "allies", var_ccffb551411b7e87 );
        spawnlogic::addspawnpointslegacy( "axis", var_ccffb551411b7e87 );
        spawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
        allyspawns = [];
        axisspawns = [];
        
        foreach ( s in spawns )
        {
            if ( s.target == "axis" )
            {
                axisspawns[ axisspawns.size ] = s;
                continue;
            }
            
            if ( s.target == "allies" )
            {
                allyspawns[ allyspawns.size ] = s;
                continue;
            }
            
            targets = utility::getstructarray( s.target, "targetname" );
            
            if ( targets.size > 0 )
            {
                continue;
            }
            
            fwd = anglestoforward( s.angles );
            axishq = level.gw_objstruct.axishqloc.trigger.origin;
            toaxis = vectornormalize( axishq - s.origin );
            axisdot = vectordot( fwd, toaxis );
            allieshq = level.gw_objstruct.allieshqloc.trigger.origin;
            toallies = vectornormalize( allieshq - s.origin );
            alliesdot = vectordot( fwd, toallies );
            
            if ( axisdot > alliesdot )
            {
                allyspawns[ allyspawns.size ] = s;
                continue;
            }
            
            axisspawns[ axisspawns.size ] = s;
        }
        
        spawnlogic::registerspawnset( "normal_allies", allyspawns );
        spawnlogic::registerspawnset( "normal_axis", axisspawns );
        spawnlogic::finalizemap();
    }
    
    level thread function_99f005b62c14ee37();
}

// Namespace gwtdm
// Params 0
// Checksum 0x1b1292fe, Offset: 0x503f
// Size: 0x1c6
function function_99f005b62c14ee37()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::finalizemap();
    parachuteheight = getdvarint( @"hash_54449fe780ddb32f", 3000 );
    utility::flag_wait( "frontline_data_init" );
    
    for ( key = 0; key < level.frontlinedata.size ; key++ )
    {
        data = level.frontlinedata[ key ];
        
        for ( lanekey = 0; lanekey < data.lanedata.size ; lanekey++ )
        {
            lanedata = data.lanedata[ lanekey ];
            lanedata.redeployspawn = [];
            
            foreach ( team in level.teamnamelist )
            {
                spawnpoint = spawnstruct();
                groundorigin = utility::drop_to_ground( lanedata.origin, undefined, undefined, ( 0, 0, 1 ) );
                spawnpoint.origin = groundorigin + ( 0, 0, 1 ) * parachuteheight;
                spawnpoint.angles = vectortoangles( level.spawnselectionteamforward[ team ] );
                spawnpoint.time = gettime();
                spawnpoint.index = -1;
                lanedata.redeployspawn[ team ] = spawnpoint;
            }
        }
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xab5b2c79, Offset: 0x520d
// Size: 0x15f
function generatespawnpoint()
{
    lanekey = randomint( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata.size );
    spawnpoint = function_f7a16cfa00bd675( self.team, lanekey );
    randradius = getdvarint( @"hash_5f04f6bef3a9be7", 512 );
    self.redeployspawn.origin = ( spawnpoint.origin[ 0 ] + randomfloatrange( randradius * -1, randradius ), spawnpoint.origin[ 1 ] + randomfloatrange( randradius * -1, randradius ), spawnpoint.origin[ 2 ] );
    self.redeployspawn.angles = spawnpoint.angles;
    self.redeployspawn.time = gettime();
    self.redeployspawn.team = self.team;
    self.redeployspawn.index = -1;
    self.redeployspawn.lifeid = self.lifeid;
    self.redeployspawn.lanekey = lanekey;
    return self.redeployspawn;
}

// Namespace gwtdm
// Params 2
// Checksum 0x976240d0, Offset: 0x5375
// Size: 0x419
function function_f7a16cfa00bd675( team, lanekey )
{
    var_a624dc57f2daa421 = level.var_f9f9bdd4e4094d63 + 1;
    
    if ( team == "axis" )
    {
        var_a624dc57f2daa421 = level.var_f9f9bdd4e4094d63 - 1;
    }
    
    if ( var_a624dc57f2daa421 == level.frontlinedata.size )
    {
        if ( !isdefined( level.gw_objstruct.var_d7646ceafa81f510 ) )
        {
            parachuteheight = getdvarint( @"hash_54449fe780ddb32f", 3000 );
            spawnpoint = spawnstruct();
            groundorigin = utility::drop_to_ground( level.gw_objstruct.allieshqloc.trigger.origin, undefined, undefined, ( 0, 0, 1 ) );
            spawnpoint.origin = groundorigin + ( 0, 0, 1 ) * parachuteheight;
            spawnpoint.angles = vectortoangles( level.spawnselectionteamforward[ team ] );
            spawnpoint.time = gettime();
            spawnpoint.index = -1;
            level.gw_objstruct.var_d7646ceafa81f510 = spawnpoint;
        }
        
        return level.gw_objstruct.var_d7646ceafa81f510;
    }
    else if ( var_a624dc57f2daa421 < 0 )
    {
        if ( !isdefined( level.gw_objstruct.var_49ce60be267f3e55 ) )
        {
            parachuteheight = getdvarint( @"hash_54449fe780ddb32f", 3000 );
            spawnpoint = spawnstruct();
            groundorigin = utility::drop_to_ground( level.gw_objstruct.axishqloc.trigger.origin, undefined, undefined, ( 0, 0, 1 ) );
            spawnpoint.origin = groundorigin + ( 0, 0, 1 ) * parachuteheight;
            spawnpoint.angles = vectortoangles( level.spawnselectionteamforward[ team ] );
            spawnpoint.time = gettime();
            spawnpoint.index = -1;
            level.gw_objstruct.var_49ce60be267f3e55 = spawnpoint;
        }
        
        return level.gw_objstruct.var_49ce60be267f3e55;
    }
    
    var_a624dc57f2daa421 = int( clamp( var_a624dc57f2daa421, 0, level.frontlinedata.size - 1 ) );
    
    if ( !isdefined( lanekey ) )
    {
        lanekey = randomint( level.frontlinedata[ var_a624dc57f2daa421 ].lanedata.size );
    }
    
    current = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ lanekey ].origin;
    neighbor = level.frontlinedata[ var_a624dc57f2daa421 ].lanedata[ lanekey ].origin;
    var_c692db39d8e04fdd = vectornormalize( neighbor - current );
    offset = getdvarint( @"hash_82bce2fb4193e57", 8000 );
    idealorigin = current + var_c692db39d8e04fdd * offset;
    var_91b407a476629301 = undefined;
    closestdist = undefined;
    
    foreach ( frontlinekey, frontlinedata in level.frontlinedata )
    {
        dist = distance2dsquared( idealorigin, frontlinedata.lanedata[ lanekey ].origin );
        
        if ( !isdefined( closestdist ) || dist < closestdist )
        {
            var_91b407a476629301 = frontlinekey;
            closestdist = dist;
        }
    }
    
    return level.frontlinedata[ var_91b407a476629301 ].lanedata[ lanekey ].redeployspawn[ team ];
}

// Namespace gwtdm
// Params 1
// Checksum 0x67d02aa, Offset: 0x5797
// Size: 0x15, Type: bool
function modespawn( revivespawn )
{
    thread playerrespawn();
    return true;
}

// Namespace gwtdm
// Params 2
// Checksum 0xd0624239, Offset: 0x57b5
// Size: 0x29, Type: bool
function playerkilledspawn( deathdata, finaldeath )
{
    deathdata.victim thread playerrespawn();
    return true;
}

// Namespace gwtdm
// Params 0
// Checksum 0x62df750f, Offset: 0x57e7
// Size: 0x175
function playerrespawn()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( level.gameended )
    {
        return;
    }
    
    playerlogic::waitforremoteend();
    spawnpoint = getspawnpoint();
    tofrontline = vectornormalize( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ spawnpoint.lanekey ].origin - spawnpoint.origin );
    spawnpoint.angles = vectortoangles( tofrontline );
    timeoutms = getdvarint( @"hash_eeb59cee28a5eab7", 3000 );
    streamorigin = br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint, timeoutms );
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        fadedownduration = 0;
        fadeupduration = 0.5;
        thread playerlogic::managerespawnfade( fadedownduration, fadeupduration );
        
        if ( fadedownduration > 0 )
        {
            self waittill( #"fadedown_complete" );
        }
    }
    
    br_spectate::playerclearspectatekillchainsystem();
    br::spawnintermission( spawnpoint.origin, spawnpoint.angles );
    spectating::setdisabled();
    streamhint::playerwaittillstreamhintcomplete();
    playerlogic::spawnplayer( undefined, 0 );
    br_gulag::gulagwinnerrespawn( 1, undefined, spawnpoint, 1, streamorigin, undefined, undefined, 0, 0, 1 );
    damage::resetplayervariables();
    damage::resetplayeromnvarsonspawn();
}

// Namespace gwtdm
// Params 0
// Checksum 0x87721adb, Offset: 0x5964
// Size: 0x175
function getspawnpoint()
{
    if ( level.var_f2008c8cec87e2a0 )
    {
        if ( !isdefined( self.redeployspawn ) )
        {
            self.redeployspawn = spawnstruct();
            return generatespawnpoint();
        }
        
        if ( isdefined( self.setspawnpoint ) )
        {
            return self.setspawnpoint;
        }
        else if ( self.redeployspawn.lifeid != self.lifeid )
        {
            return generatespawnpoint();
        }
        
        return self.redeployspawn;
    }
    
    spawnteam = self.pers[ "team" ];
    idealdist = getdvarint( @"hash_a66b78681b2d0805", 4096 );
    spawnparams = [];
    spawnparams[ "teamForward" ] = level.spawnselectionteamforward[ spawnteam ];
    spawnparams[ "idealDistSq" ] = idealdist * idealdist;
    
    if ( spawnlogic::shoulduseteamstartspawn() )
    {
        spawnlogic::setactivespawnlogic( #"start" );
        spawnlogic::activatespawnset( level.var_c81115c94d2d62b3[ spawnteam ], 1 );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, level.var_c81115c94d2d62b3[ spawnteam ], undefined, undefined, spawnparams );
    }
    else
    {
        spawnlogic::setactivespawnlogic( #"default" );
        spawnlogic::activatespawnset( level.var_2ce763571761b799[ spawnteam ], 1 );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, level.var_2ce763571761b799[ spawnteam ], undefined, undefined, spawnparams );
    }
    
    return spawnpoint;
}

// Namespace gwtdm
// Params 0
// Checksum 0xe5ed670, Offset: 0x5ae1
// Size: 0x106
function updateprestream()
{
    self endon( #"death_or_disconnect" );
    frontlineorigin = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].origin;
    idealdist = getdvarint( @"hash_a66b78681b2d0805", 4096 );
    hqorigin = frontlineorigin;
    
    if ( self.team == "axis" )
    {
        hqorigin = level.gw_objstruct.axishqloc.trigger.origin;
    }
    else
    {
        hqorigin = level.gw_objstruct.allieshqloc.trigger.origin;
    }
    
    tohq = vectornormalize( hqorigin - frontlineorigin );
    streamorigin = frontlineorigin + tohq * idealdist;
    streamorigin = utility::groundpos( streamorigin, ( 0, 0, 1 ) );
    streamhint::playerstreamhintlocation( streamorigin );
}

// Namespace gwtdm
// Params 1
// Checksum 0x44b5972a, Offset: 0x5bef
// Size: 0x59
function onspawnplayer( revivespawn )
{
    self.forcespawnnearteammates = undefined;
    thread updatematchstatushintonspawn();
    cash::function_3909082084ad6974();
    squads::updatesquadomnvars( self.team, self.sessionsquadid );
    
    if ( level.spawnprotectiontimer > 0 )
    {
        thread common::removespawnprotectiononnotify();
        thread common::removespawnprotectiononads();
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xa337b3dd, Offset: 0x5c50
// Size: 0x1e
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    hud_message::function_ef4318a0090caa0f( #"push_frontline" );
}

// Namespace gwtdm
// Params 10
// Checksum 0xfbeb4738, Offset: 0x5c76
// Size: 0xbe
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    squads::updatesquadomnvars( self.team, self.sessionsquadid );
    
    if ( level.dropbrloot )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        dropstruct.dropidx = 14;
        br_pickups::dropbrhealthpack( dropstruct );
        br_plunder::playerdropplunderondeath( dropstruct, attacker, 1 );
    }
    
    thread updateprestream();
}

// Namespace gwtdm
// Params 1
// Checksum 0xb8a83194, Offset: 0x5d3c
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

// Namespace gwtdm
// Params 1
// Checksum 0xaddd44bb, Offset: 0x5f7c
// Size: 0x82
function onplayerconnect( player )
{
    if ( isdefined( level.rallypointvehicles ) )
    {
        thread rally_point::rallypoint_showtoplayer( player );
    }
    
    caninfil = flags::gameflag( "infil_will_run" ) && !flags::gameflag( "infil_started" );
    
    if ( !level.usespawnselection && !flags::gameflag( "prematch_done" ) && !caninfil )
    {
        player thread manageprematchfade();
    }
    
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
}

// Namespace gwtdm
// Params 0
// Checksum 0xf2098c4e, Offset: 0x6006
// Size: 0xe
function manageprematchfade()
{
    self endon( #"disconnect" );
}

// Namespace gwtdm
// Params 1
// Checksum 0x73c33f3f, Offset: 0x601c
// Size: 0xc
function onplayerdisconnect( player )
{
    
}

// Namespace gwtdm
// Params 0
// Checksum 0x9e5942bd, Offset: 0x6030
// Size: 0xc
function getrespawndelay()
{
    self.spawncameraskipthermal = 0;
}

// Namespace gwtdm
// Params 6
// Checksum 0xc7868d45, Offset: 0x6045
// Size: 0x1c1
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( getdvarint( @"hash_2e405e2912dc4a44", 0 ) == 1 )
    {
        attacker thread rank::scoreeventpopup( hashcat( #"hash_2c8bcbb02ec7ff9b", level.scoremod[ "kill" ] ) );
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
    {
        if ( isdefined( attacker.leaderboarddata[ "contribution" ] ) )
        {
            attacker.leaderboarddata[ "contribution" ] = attacker.leaderboarddata[ "contribution" ] + level.scoremod[ "kill" ];
        }
        
        if ( isdefined( level.leaderboardfunc[ "contribution" ] ) )
        {
            [[ level.leaderboardfunc[ "contribution" ] ]]( attacker, level.scoremod[ "kill" ] );
        }
        
        assert( isint( level.scoremod[ "<dev string:x70>" ] ) || isfloat( level.scoremod[ "<dev string:x70>" ] ), "<dev string:x75>" );
        
        if ( isdefined( attacker.pers[ "contribution" ] ) )
        {
            attacker.pers[ "contribution" ] = attacker.pers[ "contribution" ] + level.scoremod[ "kill" ];
        }
    }
    
    attacker stats::setextrascore0( attacker.pers[ "contribution" ], "contribution" );
}

// Namespace gwtdm
// Params 0
// Checksum 0x8ad59d4e, Offset: 0x620e
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

// Namespace gwtdm
// Params 3
// Checksum 0x30b77390, Offset: 0x63a0
// Size: 0x4b
function setteammapposition( configref, team, posinfo )
{
    if ( !isdefined( level.spectatorcameras[ configref ] ) )
    {
        level.spectatorcameras[ configref ] = [];
    }
    
    level.spectatorcameras[ configref ][ team ] = posinfo;
}

// Namespace gwtdm
// Params 0
// Checksum 0x17d5e417, Offset: 0x63f3
// Size: 0x13
function applythermal()
{
    self visionsetthermalforplayer( "proto_apache_flir_mp" );
    self thermalvisionon();
}

// Namespace gwtdm
// Params 0
// Checksum 0x6c834d8f, Offset: 0x640e
// Size: 0x8
function removethermal()
{
    self thermalvisionoff();
}

// Namespace gwtdm
// Params 0
// Checksum 0xad2fb628, Offset: 0x641e
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

// Namespace gwtdm
// Params 0
// Checksum 0xebd6b72d, Offset: 0x652b
// Size: 0x16
function dohalfwayflash()
{
    wait 0.4;
    thread playslamzoomflash();
    applythermal();
}

// Namespace gwtdm
// Params 0
// Checksum 0x466b8ed2, Offset: 0x6549
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

// Namespace gwtdm
// Params 3
// Checksum 0xeb63cbeb, Offset: 0x6570
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

// Namespace gwtdm
// Params 0
// Checksum 0x2e4af29, Offset: 0x6667
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

// Namespace gwtdm
// Params 0
// Checksum 0x4d12dd38, Offset: 0x6759
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

// Namespace gwtdm
// Params 0
// Checksum 0x9135cfaa, Offset: 0x6838
// Size: 0xf1
function arm_initoutofbounds()
{
    level.outofboundstriggers = [];
    potentialoobtriggers = getentarray( "OutOfBounds", #targetname );
    
    foreach ( trigger in potentialoobtriggers )
    {
        if ( isdefined( game_utility::getlocaleid() ) && isdefined( trigger.script_noteworthy ) && trigger.script_noteworthy == level.localeid && game_utility_mp::modeusesgroundwarteamoobtriggers( trigger ) )
        {
            level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
            continue;
        }
        
        trigger delete();
    }
}

/#

    // Namespace gwtdm
    // Params 1
    // Checksum 0xc2d247d9, Offset: 0x6931
    // Size: 0x1a, Type: dev
    function debugprint( text )
    {
        if ( false )
        {
            println( text );
        }
    }

#/

// Namespace gwtdm
// Params 1
// Checksum 0x2710a5ec, Offset: 0x6953
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

// Namespace gwtdm
// Params 1
// Checksum 0xd330a951, Offset: 0x69ba
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

// Namespace gwtdm
// Params 12
// Checksum 0x3ee76e1d, Offset: 0x6a60
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
        assert( isstring( org ), "<dev string:x9b>" );
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

// Namespace gwtdm
// Params 1
// Checksum 0x1c646eaa, Offset: 0x6c2a
// Size: 0x98a
function getmissedinfilcamerapositions( team )
{
    assert( isdefined( game_utility::getlocaleid() ), "<dev string:xf8>" );
    var_4d57251d6a098bb9 = spawnstruct();
    var_4d57251d6a098bb9.startorigin = undefined;
    var_4d57251d6a098bb9.endpos = undefined;
    
    if ( level.mapname == "mp_locale_test" )
    {
        switch ( level.localeid )
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
        switch ( level.localeid )
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
            default:
                var_4d57251d6a098bb9.startorigin = ( 0, 0, 0 );
                var_4d57251d6a098bb9.startangles = ( 0, 0, 0 );
                var_4d57251d6a098bb9.endorigin = ( 0, 0, 0 );
                var_4d57251d6a098bb9.endangles = ( 0, 0, 0 );
                break;
        }
    }
    
    return var_4d57251d6a098bb9;
}

// Namespace gwtdm
// Params 0
// Checksum 0xcf763e8c, Offset: 0x75bd
// Size: 0xea
function calculatehqmidpoint()
{
    level.hqmidpoint = ( level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin ) * 0.5;
    level.hqvecttomid_allies = level.gw_objstruct.axishqloc.trigger.origin - level.hqmidpoint;
    level.hqvecttomid_axis = level.gw_objstruct.allieshqloc.trigger.origin - level.hqmidpoint;
    level.hqdisttomid = length( level.hqvecttomid_axis );
}

// Namespace gwtdm
// Params 2
// Checksum 0x8432b9c4, Offset: 0x76af
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

// Namespace gwtdm
// Params 0
// Checksum 0x1da8aab1, Offset: 0x790d
// Size: 0x29, Type: bool
function spawnprotectionexception()
{
    if ( isdefined( self.selectedspawnarea ) && issubstr( self.selectedspawnarea, "HQ" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace gwtdm
// Params 0
// Checksum 0x3403002c, Offset: 0x793f
// Size: 0x11
function function_e42623be2d62d389()
{
    wait 5;
    audio_utility::snd_transient_load( "mp_gamemode_gw" );
}

// Namespace gwtdm
// Params 0
// Checksum 0xd8e26164, Offset: 0x7958
// Size: 0x13a
function function_27b8e503a3ebacc8()
{
    level.var_f9f9bdd4e4094d63 = 0;
    level.var_807ee08a0a5ad15f = [];
    frontlineinfo = spawnstruct();
    frontlineinfo.origin = ( level.gw_objstruct.allieshqloc.trigger.origin + level.gw_objstruct.axishqloc.trigger.origin ) * 0.5;
    level.var_807ee08a0a5ad15f[ "player" ] = frontlineinfo;
    frontlineinfo = spawnstruct();
    frontlineinfo.origin = ( level.gw_objstruct.allieshqloc.trigger.origin + level.gw_objstruct.axishqloc.trigger.origin ) * 0.5;
    level.var_807ee08a0a5ad15f[ "agent" ] = frontlineinfo;
    level function_b3b1cdfc2bca96bb();
    level thread updateplayerfrontline();
    level thread function_cf810ad6d8212c2d();
    level thread function_672c01e5cf383991();
    level thread function_565b1501f1b8b32c();
}

// Namespace gwtdm
// Params 0
// Checksum 0x45930600, Offset: 0x7a9a
// Size: 0x811
function function_672c01e5cf383991()
{
    frontlinebehavior = getdvarint( @"hash_7ba9b97c63a992b5", 0 );
    var_66bf4de75a67d599 = getdvarfloat( @"hash_1b0e9faa2b5e36e4", 30 );
    var_521fa8ab2472f316 = getdvarint( @"hash_6240b7bdf606e6ab", 60 ) * 1000;
    var_601ca5f302e2e290 = getdvarint( @"hash_c52aee495ff0598a", 180 ) * 1000;
    var_498aaabd825ba633 = getdvarint( @"hash_4c9d7f8dede759c7", 1 );
    var_d131548ee593b3a7 = getdvarint( @"hash_73d5df0e713e122f", 200 );
    offensivepenalty = getdvarfloat( @"hash_b9ec3bea41ddd71b", 0.2 );
    buffer = 0;
    initialset = 0;
    level.startingfrontline = 0;
    var_9497df40cdbbefbd = 0;
    var_4e8e0b717a72408d = spawnstruct();
    var_4e8e0b717a72408d.var_30f3c3232a46a73f = level.var_f9f9bdd4e4094d63;
    var_4e8e0b717a72408d.var_ae83a72fab1e5b4b = 0;
    var_4e8e0b717a72408d.axisscore = getteamscore( "axis" );
    var_4e8e0b717a72408d.alliesscore = getteamscore( "allies" );
    
    while ( true )
    {
        waitframe();
        currenttime = gettime();
        var_34f25eac138a87ec = getteamscore( "axis" ) - var_4e8e0b717a72408d.axisscore;
        var_37782b47d4cc517d = getteamscore( "allies" ) - var_4e8e0b717a72408d.alliesscore;
        var_c4b1221c81c1fa1f = abs( level.var_f9f9bdd4e4094d63 - level.startingfrontline );
        axisscalar = level.var_f9f9bdd4e4094d63 > level.startingfrontline ? 1 + var_c4b1221c81c1fa1f * offensivepenalty : 1;
        alliesscalar = level.var_f9f9bdd4e4094d63 < level.startingfrontline ? 1 + var_c4b1221c81c1fa1f * offensivepenalty : 1;
        
        if ( getdvarint( @"hash_13fae9c305971d06", 0 ) == 1 )
        {
            stepy = 25;
            startx = 800;
            starty = 50;
            linecount = 0;
            
            /#
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x132>", ( 1, 1, 1 ), 1 );
            #/
            
            linecount++;
            
            /#
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x141>" + level.var_f9f9bdd4e4094d63, ( 1, 1, 1 ), 1 );
            #/
            
            linecount++;
            
            /#
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x157>" + var_9497df40cdbbefbd, ( 1, 1, 1 ), 1 );
            #/
            
            linecount++;
            
            /#
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x168>" + buffer, ( 1, 1, 1 ), 1 );
            #/
            
            linecount++;
            var_1bd275576b1cc46b = max( 0, ( var_4e8e0b717a72408d.var_ae83a72fab1e5b4b + var_521fa8ab2472f316 - currenttime ) / 1000 );
            
            /#
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x178>" + var_1bd275576b1cc46b, ( 1, 1, 1 ), 1 );
            #/
            
            linecount++;
            var_1bd275576b1cc46b = max( 0, ( var_4e8e0b717a72408d.var_ae83a72fab1e5b4b + var_601ca5f302e2e290 - currenttime ) / 1000 );
            
            /#
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x185>" + var_1bd275576b1cc46b, ( 1, 1, 1 ), 1 );
            #/
            
            linecount++;
            
            /#
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x198>" + var_d131548ee593b3a7, ( 1, 1, 1 ), 1 );
            #/
            
            linecount++;
            
            /#
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x1b8>" + var_34f25eac138a87ec + "<dev string:x1cc>" + var_d131548ee593b3a7 * axisscalar, ( 1, 1, 1 ), 1 );
            #/
            
            linecount++;
            
            /#
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x1d0>" + var_37782b47d4cc517d + "<dev string:x1cc>" + var_d131548ee593b3a7 * alliesscalar, ( 1, 1, 1 ), 1 );
            #/
            
            linecount++;
        }
        
        if ( getdvarint( @"hash_4daef99e4fc56e2a", -1 ) != -1 )
        {
            var_4e8e0b717a72408d.var_30f3c3232a46a73f = level.var_f9f9bdd4e4094d63;
            level.var_f9f9bdd4e4094d63 = getdvarint( @"hash_4daef99e4fc56e2a", -1 );
            var_4e8e0b717a72408d.var_ae83a72fab1e5b4b = gettime();
            var_4e8e0b717a72408d.axisscore = getteamscore( "axis" );
            var_4e8e0b717a72408d.alliesscore = getteamscore( "allies" );
            
            if ( level.var_f9f9bdd4e4094d63 != var_4e8e0b717a72408d.var_30f3c3232a46a73f )
            {
                if ( var_4e8e0b717a72408d.var_30f3c3232a46a73f < level.var_f9f9bdd4e4094d63 )
                {
                    dialog::statusdialog( "gwtdm_fall_back", "allies", 1 );
                    dialog::statusdialog( "gwtdm_push_foward", "axis", 1 );
                    advancingteam = "axis";
                }
                else
                {
                    dialog::statusdialog( "gwtdm_fall_back", "axis", 1 );
                    dialog::statusdialog( "gwtdm_push_foward", "allies", 1 );
                    advancingteam = "allies";
                }
                
                function_6f56cc5d59b4bc0();
                level function_993bb84177c80527( advancingteam );
                level notify( #"frontline_moved" );
            }
            
            continue;
        }
        
        switch ( frontlinebehavior )
        {
            case 0:
                var_9497df40cdbbefbd = function_3fce2946a0dc1edb();
                break;
            default:
                var_9497df40cdbbefbd = function_3fce2946a0dc1edb();
                break;
        }
        
        if ( !initialset )
        {
            initialset = 1;
            var_9497df40cdbbefbd = function_3fce2946a0dc1edb();
            level.startingfrontline = var_9497df40cdbbefbd;
            level.var_f9f9bdd4e4094d63 = var_9497df40cdbbefbd;
            var_4e8e0b717a72408d.var_30f3c3232a46a73f = level.var_f9f9bdd4e4094d63;
            var_4e8e0b717a72408d.var_ae83a72fab1e5b4b = gettime();
            var_4e8e0b717a72408d.axisscore = getteamscore( "axis" );
            var_4e8e0b717a72408d.alliesscore = getteamscore( "allies" );
            function_6f56cc5d59b4bc0();
        }
        
        if ( !flags::gameflag( "prematch_done" ) )
        {
            continue;
        }
        
        if ( currenttime > var_4e8e0b717a72408d.var_ae83a72fab1e5b4b + var_601ca5f302e2e290 )
        {
            if ( var_34f25eac138a87ec >= var_d131548ee593b3a7 * axisscalar || var_37782b47d4cc517d >= var_d131548ee593b3a7 * alliesscalar )
            {
                if ( var_34f25eac138a87ec > var_37782b47d4cc517d )
                {
                    var_9497df40cdbbefbd = int( clamp( level.var_f9f9bdd4e4094d63 + 1, 0, level.frontlinedata.size - 1 ) );
                }
                else
                {
                    var_9497df40cdbbefbd = int( clamp( level.var_f9f9bdd4e4094d63 - 1, 0, level.frontlinedata.size - 1 ) );
                }
                
                buffer = var_66bf4de75a67d599;
            }
        }
        
        if ( var_9497df40cdbbefbd != level.var_f9f9bdd4e4094d63 )
        {
            buffer += level.framedurationseconds;
            
            if ( currenttime > var_4e8e0b717a72408d.var_ae83a72fab1e5b4b + var_521fa8ab2472f316 && buffer > var_66bf4de75a67d599 )
            {
                buffer = 0;
                var_4e8e0b717a72408d.var_ae83a72fab1e5b4b = gettime();
                var_4e8e0b717a72408d.var_30f3c3232a46a73f = level.var_f9f9bdd4e4094d63;
                var_4e8e0b717a72408d.axisscore = getteamscore( "axis" );
                var_4e8e0b717a72408d.alliesscore = getteamscore( "allies" );
                
                if ( var_498aaabd825ba633 )
                {
                    if ( var_9497df40cdbbefbd > level.var_f9f9bdd4e4094d63 )
                    {
                        level.var_f9f9bdd4e4094d63++;
                    }
                    else
                    {
                        level.var_f9f9bdd4e4094d63--;
                    }
                }
                else
                {
                    level.var_f9f9bdd4e4094d63 = var_9497df40cdbbefbd;
                }
                
                if ( var_4e8e0b717a72408d.var_30f3c3232a46a73f < level.var_f9f9bdd4e4094d63 )
                {
                    dialog::statusdialog( "gwtdm_fall_back", "allies", 1 );
                    dialog::statusdialog( "gwtdm_push_foward", "axis", 1 );
                    advancingteam = "axis";
                }
                else
                {
                    dialog::statusdialog( "gwtdm_fall_back", "axis", 1 );
                    dialog::statusdialog( "gwtdm_push_foward", "allies", 1 );
                    advancingteam = "allies";
                }
                
                function_6f56cc5d59b4bc0();
                level function_993bb84177c80527( advancingteam );
                level notify( #"frontline_moved" );
            }
            
            continue;
        }
        
        buffer = 0;
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xcd3ddd70, Offset: 0x82b3
// Size: 0x154
function function_3fce2946a0dc1edb()
{
    closestdistsq = undefined;
    closestfrontline = undefined;
    
    foreach ( key, data in level.frontlinedata )
    {
        closestpoint = pointonsegmentnearesttopoint( data.minpoint, data.maxpoint, level.var_807ee08a0a5ad15f[ "player" ].origin );
        distsq = distance2dsquared( closestpoint, level.var_807ee08a0a5ad15f[ "player" ].origin );
        
        if ( getdvarint( @"hash_13fae9c305971d06", 0 ) == 1 )
        {
            level thread debug_utility::drawline( closestpoint, level.var_807ee08a0a5ad15f[ "player" ].origin, level.framedurationseconds, ( 1, 0, 1 ) );
        }
        
        if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
        {
            closestdistsq = distsq;
            closestfrontline = key;
        }
    }
    
    return closestfrontline;
}

// Namespace gwtdm
// Params 0
// Checksum 0x9c964f34, Offset: 0x8410
// Size: 0x7f5
function function_565b1501f1b8b32c()
{
    while ( true )
    {
        waitframe();
        
        if ( getdvarint( @"hash_13fae9c305971d06", 0 ) == 0 )
        {
            continue;
        }
        
        foreach ( key, data in level.var_807ee08a0a5ad15f )
        {
            vertstep = 256;
            
            for ( i = 0; i < 5 ; i++ )
            {
                height = vertstep * i;
                color = ( 1, 1, 1 );
                
                switch ( key )
                {
                    case #"hash_87d1443ef2805760":
                        color = ( 0, 1, 0 );
                        break;
                    case #"hash_f67e929c23b9fc86":
                        color = ( 0, 1, 1 );
                        break;
                }
                
                level thread debug_utility::drawsphere( data.origin + ( 0, 0, 1 ) * height, vertstep, level.framedurationseconds, color );
            }
        }
        
        for ( key = 0; key < level.frontlinedata.size ; key++ )
        {
            data = level.frontlinedata[ key ];
            level thread debug_utility::drawline( data.minpoint, data.maxpoint, level.framedurationseconds, ( 1, 0, 0 ) );
            color = level.var_f9f9bdd4e4094d63 == key ? ( 0, 1, 0 ) : ( 1, 1, 1 );
            
            /#
                print3d( data.origin, "<dev string:x1e6>" + key, color, 1, 20, 1, 1 );
            #/
            
            prev = undefined;
            
            for ( lanekey = 0; lanekey < data.lanedata.size ; lanekey++ )
            {
                lanedata = data.lanedata[ lanekey ];
                color = level.var_f9f9bdd4e4094d63 == key ? ( 0, 1, 0 ) : ( 1, 1, 1 );
                
                /#
                    print3d( lanedata.origin, "<dev string:x1f2>" + lanekey, color, 1, 10, 1, 1 );
                #/
                
                foreach ( team, locs in lanedata.coverzones )
                {
                    color = ( team == "axis" ? ( 1, 0, 0 ) : ( 0, 0, 1 ) ) * ( level.var_f9f9bdd4e4094d63 == key ? 1 : 0.5 );
                    
                    foreach ( loc in locs )
                    {
                        level thread debug_utility::drawline( lanedata.origin, loc.origin, level.framedurationseconds, color );
                        
                        /#
                            print3d( loc.origin, "<dev string:x1f9>" + key + "<dev string:x204>" + lanekey + "<dev string:x206>" + team, color, 1, 5, 1, 1 );
                        #/
                    }
                }
                
                foreach ( team, loc in lanedata.backvolume )
                {
                    color = ( team == "axis" ? ( 1, 0, 0 ) : ( 0, 0, 1 ) ) * ( level.var_f9f9bdd4e4094d63 == key ? 1 : 0.5 );
                    level thread debug_utility::drawline( lanedata.origin, loc.origin, level.framedurationseconds, color );
                    
                    /#
                        print3d( loc.origin, "<dev string:x209>" + key + "<dev string:x204>" + lanekey + "<dev string:x206>" + team, color, 1, 5, 1, 1 );
                    #/
                }
                
                foreach ( team, loc in lanedata.frontvolume )
                {
                    color = ( team == "axis" ? ( 1, 0, 0 ) : ( 0, 0, 1 ) ) * ( level.var_f9f9bdd4e4094d63 == key ? 1 : 0.5 );
                    level thread debug_utility::drawline( lanedata.origin, loc.origin, level.framedurationseconds, color );
                    
                    /#
                        print3d( loc.origin, "<dev string:x215>" + key + "<dev string:x204>" + lanekey + "<dev string:x206>" + team, color, 1, 5, 1, 1 );
                    #/
                }
                
                foreach ( team, loc in lanedata.redeployspawn )
                {
                    level thread debug_utility::drawline( loc.origin - ( 0, 0, 500 ), loc.origin + ( 0, 0, 500 ), level.framedurationseconds, ( 0, 1, 0 ) );
                }
                
                if ( key + 1 < level.frontlinedata.size )
                {
                    color = ( 1, 1, 1 );
                    
                    if ( level.var_dff8718904005c44 )
                    {
                        color = ( 1, 1, 0 );
                    }
                    
                    level thread debug_utility::drawline( lanedata.origin, level.frontlinedata[ key + 1 ].lanedata[ lanekey ].origin, level.framedurationseconds, color );
                }
                
                if ( isdefined( prev ) )
                {
                    startpos = prev;
                    endpos = lanedata.origin;
                    var_88459977060dfad5 = ( 0.5, 0.5, 0.5 );
                    
                    if ( level.var_4de890eb918bbbab )
                    {
                        var_88459977060dfad5 = ( 0, 1, 1 );
                    }
                    
                    color = level.var_f9f9bdd4e4094d63 == key ? ( 0, 1, 0 ) : var_88459977060dfad5;
                    level thread debug_utility::drawline( startpos, endpos, level.framedurationseconds, color );
                }
                
                prev = lanedata.origin;
            }
        }
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xa1a20d5, Offset: 0x8c0d
// Size: 0x12b
function updateplayerfrontline()
{
    while ( true )
    {
        axisavg = spawnfactor::getfrontlineteamcenter( "axis" );
        
        if ( !isdefined( axisavg ) )
        {
            axisavg = level.gw_objstruct.axishqloc.trigger.origin;
        }
        
        alliesavg = spawnfactor::getfrontlineteamcenter( "allies" );
        
        if ( !isdefined( alliesavg ) )
        {
            alliesavg = level.gw_objstruct.allieshqloc.trigger.origin;
        }
        
        axisavg = ( axisavg[ 0 ], axisavg[ 1 ], level.gw_objstruct.axishqloc.trigger.origin[ 2 ] );
        alliesavg = ( alliesavg[ 0 ], alliesavg[ 1 ], level.gw_objstruct.axishqloc.trigger.origin[ 2 ] );
        origin = ( axisavg + alliesavg ) * 0.5;
        level.var_807ee08a0a5ad15f[ "player" ].origin = origin;
        waitframe();
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xe044afea, Offset: 0x8d40
// Size: 0x182
function function_cf810ad6d8212c2d()
{
    while ( !isdefined( level.agentmanager ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        agents = [];
        
        foreach ( team in level.teamnamelist )
        {
            foreach ( lanedata in level.agentmanager[ team ] )
            {
                agents = arraycombine( agents, lanedata.currentagents );
            }
        }
        
        if ( agents.size > 0 )
        {
            avgpos = entity::getaverageorigin( agents );
            level.var_807ee08a0a5ad15f[ "agent" ].origin = ( avgpos[ 0 ], avgpos[ 1 ], level.gw_objstruct.axishqloc.trigger.origin[ 2 ] );
        }
        
        waitframe();
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x98fc99d, Offset: 0x8eca
// Size: 0xafe
function function_b3b1cdfc2bca96bb()
{
    frontlinestructs = utility::getstructarray( "frontlineData", "script_noteworthy" );
    
    if ( !isdefined( frontlinestructs ) || frontlinestructs.size == 0 )
    {
        frontlinestructs = function_6e83ecc75244fef7();
    }
    
    level.frontagents = [];
    level.frontagents[ "axis" ] = [];
    level.frontagents[ "allies" ] = [];
    level.backagents = [];
    level.backagents[ "axis" ] = [];
    level.backagents[ "allies" ] = [];
    array_unique = [];
    
    foreach ( item in frontlinestructs )
    {
        keep = 1;
        
        foreach ( _item in array_unique )
        {
            if ( distance2dsquared( item.origin, _item.origin ) < 16384 )
            {
                keep = 0;
                break;
            }
        }
        
        if ( keep )
        {
            array_unique[ array_unique.size ] = item;
        }
    }
    
    frontlinestructs = array_unique;
    
    foreach ( data in frontlinestructs )
    {
        if ( !isdefined( data.angles ) )
        {
            data.angles = ( 0, 0, 0 );
        }
        
        data.forward = anglestoforward( data.angles );
        data.right = anglestoright( data.angles );
        data.radius = randomfloatrange( 2048, 4096 );
        data.minpoint = data.origin - data.right * data.radius;
        data.maxpoint = data.origin + data.right * data.radius;
        lanestructs = utility::getstructarray( data.target, "targetname" );
        
        if ( isdefined( lanestructs ) && lanestructs.size > 0 )
        {
            lanedata = spawnstruct();
            lanedata = [];
            
            foreach ( lanestruct in lanestructs )
            {
                if ( issubstr( lanestruct.script_noteworthy, "center" ) )
                {
                    continue;
                }
                
                lanekey = int( strtok( lanestruct.script_noteworthy, "_" )[ 1 ] ) - 1;
                
                if ( !isdefined( lanedata[ lanekey ] ) )
                {
                    lanedata[ lanekey ] = spawnstruct();
                    lanedata[ lanekey ].coverzones = [];
                    lanedata[ lanekey ].frontvolume = [];
                    lanedata[ lanekey ].backvolume = [];
                }
                
                if ( !isdefined( lanestruct.script_team ) )
                {
                    lanestruct.script_team = "axis";
                }
                
                lanestruct.radius = 1024;
                volumes = getentarray( "frontline0" + int( data.script_label ) + 1 + "_lane0" + int( lanekey ) + 1 + "_" + lanestruct.script_team, "script_noteworthy" );
                lanestruct.goalvolume = volumes[ 0 ];
                var_a72227fab0b42c1a = "frontline0" + int( data.script_label ) + 1 + "_lane0" + int( lanekey ) + 1 + "_front_" + lanestruct.script_team;
                volumes = getentarray( var_a72227fab0b42c1a, #script_noteworthy );
                lanedata[ lanekey ].frontvolume[ lanestruct.script_team ] = volumes[ 0 ];
                var_8de5e357e86f6ce6 = "frontline0" + int( data.script_label ) + 1 + "_lane0" + int( lanekey ) + 1 + "_back_" + lanestruct.script_team;
                volumes = getentarray( var_8de5e357e86f6ce6, #script_noteworthy );
                lanedata[ lanekey ].backvolume[ lanestruct.script_team ] = volumes[ 0 ];
                
                if ( !isdefined( lanedata[ lanekey ].coverzones[ lanestruct.script_team ] ) )
                {
                    lanedata[ lanekey ].coverzones[ lanestruct.script_team ] = [];
                }
                
                lanedata[ lanekey ].coverzones[ lanestruct.script_team ][ lanedata[ lanekey ].coverzones[ lanestruct.script_team ].size ] = lanestruct;
            }
            
            foreach ( lanestruct in lanestructs )
            {
                if ( issubstr( lanestruct.script_noteworthy, "center" ) )
                {
                    lanekey = int( strtok( lanestruct.script_noteworthy, "_" )[ 1 ] ) - 1;
                    lanedata[ lanekey ].origin = lanestruct.origin;
                }
            }
            
            foreach ( lanekey, lane in lanedata )
            {
                if ( !isdefined( lane.origin ) )
                {
                    assertmsg( "<dev string:x222>" + lanekey + "<dev string:x228>" );
                    avgposition = ( 0, 0, 0 );
                    count = 0;
                    
                    foreach ( coverzones in lane.coverzones )
                    {
                        foreach ( point in coverzones )
                        {
                            avgposition += point.origin;
                            count++;
                        }
                    }
                    
                    lane.origin = avgposition / count;
                }
            }
            
            data.lanedata = lanedata;
        }
        else
        {
            data.lanedata = function_5acd7201f6b5fcc9( data );
        }
        
        if ( isdefined( data.lanedata[ 0 ] ) )
        {
            lanevector = vectornormalize( data.lanedata[ 0 ].origin - data.lanedata[ data.lanedata.size - 1 ].origin );
            data.right = lanevector;
            data.forward = vectorcross( lanevector, ( 0, 0, 1 ) );
            data.radius = randomfloatrange( 2048, 4096 );
            data.minpoint = data.lanedata[ 0 ].origin;
            data.maxpoint = data.lanedata[ data.lanedata.size - 1 ].origin;
        }
    }
    
    var_eae80bc125c15cf2 = [];
    
    foreach ( data in frontlinestructs )
    {
        var_eae80bc125c15cf2[ int( data.script_label ) ] = data;
    }
    
    var_aefdbcb8b66e4650 = getdvar( @"hash_3560171963b3f075", "" );
    var_aefdbcb8b66e4650 = strtok( var_aefdbcb8b66e4650, " " );
    validstructs = [];
    
    if ( var_aefdbcb8b66e4650.size > 0 )
    {
        foreach ( skipkey in var_aefdbcb8b66e4650 )
        {
            var_eae80bc125c15cf2[ int( skipkey ) ] = undefined;
        }
        
        var_ad5a1ae089e5af07 = 0;
        
        for ( searchindex = 0; var_ad5a1ae089e5af07 < var_eae80bc125c15cf2.size ; searchindex++ )
        {
            if ( isdefined( var_eae80bc125c15cf2[ searchindex ] ) )
            {
                validstructs[ var_ad5a1ae089e5af07 ] = var_eae80bc125c15cf2[ searchindex ];
                var_ad5a1ae089e5af07++;
            }
        }
    }
    else
    {
        validstructs = var_eae80bc125c15cf2;
    }
    
    level.frontlinedata = validstructs;
    function_265e75646f05a073();
    utility::flag_set( "frontline_data_init" );
    
    /#
        if ( getdvarint( @"hash_c035e447af342805", 0 ) == 1 )
        {
            level thread function_cedaaf62838dbf35();
        }
    #/
}

// Namespace gwtdm
// Params 0
// Checksum 0x947ab906, Offset: 0x99d0
// Size: 0x1e4
function function_265e75646f05a073()
{
    foreach ( frontline in level.frontlinedata )
    {
        foreach ( lanedata in frontline.lanedata )
        {
            lanedata.frontvolume[ "axis" ].heading = vectornormalize2( lanedata.frontvolume[ "allies" ].origin - lanedata.frontvolume[ "axis" ].origin );
            lanedata.frontvolume[ "allies" ].heading = lanedata.frontvolume[ "axis" ].heading * -1;
            lanedata.backvolume[ "axis" ].heading = lanedata.frontvolume[ "axis" ].heading;
            lanedata.backvolume[ "allies" ].heading = lanedata.frontvolume[ "allies" ].heading;
        }
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x26000b7c, Offset: 0x9bbc
// Size: 0x8fa
function function_11f0f1d536131bf7()
{
    foreach ( frontline in level.frontlinedata )
    {
        lanedata = frontline.lanedata[ 0 ];
        thread debug::drawsphere( lanedata.frontvolume[ "axis" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.frontvolume[ "axis" ].origin + lanedata.frontvolume[ "axis" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.frontvolume[ "axis" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 1 ];
        thread debug::drawsphere( lanedata.frontvolume[ "axis" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.frontvolume[ "axis" ].origin + lanedata.frontvolume[ "axis" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.frontvolume[ "axis" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 2 ];
        thread debug::drawsphere( lanedata.frontvolume[ "axis" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.frontvolume[ "axis" ].origin + lanedata.frontvolume[ "axis" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.frontvolume[ "axis" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 0 ];
        thread debug::drawsphere( lanedata.backvolume[ "axis" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.backvolume[ "axis" ].origin + lanedata.backvolume[ "axis" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.backvolume[ "axis" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 1 ];
        thread debug::drawsphere( lanedata.backvolume[ "axis" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.backvolume[ "axis" ].origin + lanedata.backvolume[ "axis" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.backvolume[ "axis" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 2 ];
        thread debug::drawsphere( lanedata.backvolume[ "axis" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.backvolume[ "axis" ].origin + lanedata.backvolume[ "axis" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.backvolume[ "axis" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 0 ];
        thread debug::drawsphere( lanedata.frontvolume[ "allies" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.frontvolume[ "allies" ].origin + lanedata.frontvolume[ "allies" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.frontvolume[ "allies" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 1 ];
        thread debug::drawsphere( lanedata.frontvolume[ "allies" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.frontvolume[ "allies" ].origin + lanedata.frontvolume[ "allies" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.frontvolume[ "allies" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 2 ];
        thread debug::drawsphere( lanedata.frontvolume[ "allies" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.frontvolume[ "allies" ].origin + lanedata.frontvolume[ "allies" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.frontvolume[ "allies" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 0 ];
        thread debug::drawsphere( lanedata.backvolume[ "allies" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.backvolume[ "allies" ].origin + lanedata.backvolume[ "allies" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.backvolume[ "allies" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 1 ];
        thread debug::drawsphere( lanedata.backvolume[ "allies" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.backvolume[ "allies" ].origin + lanedata.backvolume[ "allies" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.backvolume[ "allies" ].origin, endpoint, 60, ( 0, 0, 1 ) );
        lanedata = frontline.lanedata[ 2 ];
        thread debug::drawsphere( lanedata.backvolume[ "allies" ].origin, 256, 60, ( 1, 0, 0 ) );
        endpoint = lanedata.backvolume[ "allies" ].origin + lanedata.backvolume[ "allies" ].heading * 1024;
        level thread debug_utility::drawline( lanedata.backvolume[ "allies" ].origin, endpoint, 60, ( 0, 0, 1 ) );
    }
}

/#

    // Namespace gwtdm
    // Params 0
    // Checksum 0x1832f09e, Offset: 0xa4be
    // Size: 0x160, Type: dev
    function function_cedaaf62838dbf35()
    {
        foreach ( frontline in level.frontlinedata )
        {
            for ( i = 0; i < frontline.lanedata.size ; i++ )
            {
                frontline.lanedata[ i ].backvolume[ "<dev string:x261>" ] thread draw_bounds( ( 1, 0, 0 ) );
                frontline.lanedata[ i ].frontvolume[ "<dev string:x261>" ] thread draw_bounds( ( 1, 0, 0 ) );
                frontline.lanedata[ i ].backvolume[ "<dev string:x266>" ] thread draw_bounds( ( 0.5, 0.5, 1 ) );
                frontline.lanedata[ i ].frontvolume[ "<dev string:x266>" ] thread draw_bounds( ( 0.5, 0.5, 1 ) );
            }
        }
    }

    // Namespace gwtdm
    // Params 1
    // Checksum 0xfe53ebac, Offset: 0xa626
    // Size: 0x1f, Type: dev
    function draw_bounds( color )
    {
        thread utility::draw_entity_bounds( self, 200000, color, 0 );
    }

#/

// Namespace gwtdm
// Params 0
// Checksum 0x775f68d, Offset: 0xa64d
// Size: 0x14c
function function_6e83ecc75244fef7()
{
    level.var_4de890eb918bbbab = 1;
    structs = [];
    startorigin = level.gw_objstruct.axishqloc.trigger.origin;
    totaldistance = distance( level.gw_objstruct.allieshqloc.trigger.origin, level.gw_objstruct.axishqloc.trigger.origin );
    
    for ( i = 0; i < 6 ; i++ )
    {
        frac = ( i * 2 + 1 ) / 12;
        origin = startorigin + level.spawnselectionteamforward[ "axis" ] * totaldistance * frac;
        data = spawnstruct();
        data.origin = origin;
        data.angles = vectortoangles( level.spawnselectionteamforward[ "axis" ] );
        data.target = "";
        structs[ structs.size ] = data;
    }
    
    return structs;
}

// Namespace gwtdm
// Params 1
// Checksum 0x2485caa0, Offset: 0xa7a2
// Size: 0x274
function function_5acd7201f6b5fcc9( data )
{
    level.var_dff8718904005c44 = 1;
    lanestructs = [];
    lanecount = 3;
    randompointcount = 3;
    startorigin = data.origin - data.right * data.radius;
    width = data.radius * 2;
    
    for ( i = 0; i < lanecount ; i++ )
    {
        var_5f7bdeaeb05a3cc9 = ( i * 2 + 1 ) / lanecount * 2;
        lanedata = spawnstruct();
        lanedata.origin = startorigin + data.right * var_5f7bdeaeb05a3cc9 * width;
        lanedata.coverzones = [];
        
        foreach ( team in level.teamnamelist )
        {
            lanedata.coverzones[ team ] = [];
            positive = vectordot( data.forward, level.spawnselectionteamforward[ team ] ) < 0;
            
            if ( randompointcount > 0 )
            {
                randompointcount = 1 + randomint( randompointcount );
            }
            else
            {
                randompointcount = 1;
            }
            
            for ( j = 0; j < randompointcount ; j++ )
            {
                centerorigin = lanedata.origin + data.forward * 1024 * 1.5 * ( positive ? 1 : -1 );
                struct = spawnstruct();
                struct.origin = br_circle::getrandompointincircle( centerorigin, 512 );
                struct.team = team;
                struct.radius = randomfloatrange( 256, 512 );
                lanedata.coverzones[ team ][ lanedata.coverzones[ team ].size ] = struct;
            }
        }
        
        lanestructs[ lanestructs.size ] = lanedata;
    }
    
    return lanestructs;
}

// Namespace gwtdm
// Params 3
// Checksum 0xb03f3306, Offset: 0xaa1f
// Size: 0x42
function function_b5a13951294d51aa( team, frontlinekey, lanekey )
{
    return level.frontlinedata[ frontlinekey ].lanedata[ lanekey ].coverzones[ team ];
}

// Namespace gwtdm
// Params 2
// Checksum 0x266323f, Offset: 0xaa6a
// Size: 0x4b
function function_43d43a72eeb7fbe1( team, lanekey )
{
    return level.agentmanager[ team ][ lanekey ].var_9dfc097ba9b3c109[ randomint( level.agentmanager[ team ][ lanekey ].var_9dfc097ba9b3c109.size ) ];
}

// Namespace gwtdm
// Params 3
// Checksum 0xe306d8f6, Offset: 0xaabe
// Size: 0x33b
function function_42128510cdea417b( origin, team, lanekey )
{
    volumes = [];
    
    foreach ( frontline in level.frontlinedata )
    {
        foreach ( index, lanedata in frontline.lanedata )
        {
            if ( isdefined( lanekey ) && lanekey != index )
            {
                continue;
            }
            
            if ( lanedata.backvolume.size > 0 )
            {
                foreach ( index1, volume in lanedata.backvolume )
                {
                    if ( isdefined( team ) && team != index1 )
                    {
                        continue;
                    }
                    
                    volumes[ volumes.size ] = volume;
                }
                
                foreach ( index2, volume in lanedata.frontvolume )
                {
                    if ( isdefined( team ) && team != index2 )
                    {
                        continue;
                    }
                    
                    volumes[ volumes.size ] = volume;
                }
                
                continue;
            }
            
            foreach ( index3, var_42b52acf2e41cfe9 in lanedata.coverzones )
            {
                if ( isdefined( team ) && team != index3 )
                {
                    continue;
                }
                
                foreach ( var_7958085d4de85a7e in var_42b52acf2e41cfe9 )
                {
                    volumes[ volumes.size ] = var_7958085d4de85a7e.goalvolume;
                }
            }
        }
    }
    
    volumes = sortbydistance( volumes, origin );
    return volumes[ 0 ];
}

// Namespace gwtdm
// Params 3
// Checksum 0x36d405f1, Offset: 0xae02
// Size: 0x1c1
function function_47658bdfdb845e7a( agent, team, lanekey )
{
    array = [];
    index = 0;
    increment = 1;
    
    if ( team == "allies" )
    {
        index = level.frontlinedata.size - 1;
        increment = -1;
    }
    
    while ( index != level.var_f9f9bdd4e4094d63 )
    {
        coverzones = level.frontlinedata[ index ].lanedata[ lanekey ].coverzones[ team ];
        coverzone = coverzones[ randomint( coverzones.size ) ];
        array[ array.size ] = coverzone.origin;
        index += increment;
    }
    
    coverzones = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ lanekey ].coverzones[ team ];
    coverzone = coverzones[ randomint( coverzones.size ) ];
    array[ array.size ] = coverzone.origin;
    validorigins = [];
    
    foreach ( origin in array )
    {
        toorigin = vectornormalize( origin - agent.origin );
        
        if ( vectordot( level.spawnselectionteamforward[ team ], toorigin ) > 0 )
        {
            validorigins[ validorigins.size ] = origin;
        }
    }
    
    return validorigins;
}

// Namespace gwtdm
// Params 0
// Checksum 0xba0de452, Offset: 0xafcc
// Size: 0x2f2
function initai()
{
    if ( getdvarint( @"scr_default_maxagents", 120 ) == 0 )
    {
        return;
    }
    
    level.var_d95835502ec96520 = getdvarint( @"hash_55d8273e8c59f973", 45 );
    level.var_c98a3a72c3f25319 = getdvarint( @"hash_9b987a555b7e16af", 256 );
    level.agenttier = 1;
    level.teamnationality = [];
    level.teamnationality[ "axis" ] = "aq_gwtdm";
    level.teamnationality[ "allies" ] = "pmc";
    level thread dmz_ai::init();
    ai_mp_controller::init();
    function_d5b381155557128c();
    ai_mp_controller::function_2b1cc53b284373( &function_eb40fe818a5cfaff );
    level.var_f0d527566ff71ca9 = &function_f8dea7df1a56e64e;
    utility::flag_wait( "frontline_data_init" );
    level.agentmanager = [];
    level.var_dedc9aa98a73db9c = 1;
    
    foreach ( team in level.teamnamelist )
    {
        level.agentmanager[ team ] = [];
        
        foreach ( lanekey, lanedata in level.frontlinedata[ 0 ].lanedata )
        {
            data = spawnstruct();
            data.lanekey = lanekey;
            data.var_21b4e7b2ee56d24c = level.var_d95835502ec96520 / level.frontlinedata[ 0 ].lanedata.size;
            data.var_9dfc097ba9b3c109 = function_b5a13951294d51aa( team, level.var_f9f9bdd4e4094d63, lanekey );
            data.currentagents = [];
            data.var_1e69802e27a5eeed = 0;
            level.agentmanager[ team ][ lanekey ] = data;
        }
    }
    
    level.defaultspawnset = "gwtdm";
    
    while ( !isdefined( level.agentarray ) )
    {
        waitframe();
    }
    
    function_f27f579d65445c08();
    level thread function_eb2b0550ab4e4172();
    level thread function_706d6c9afc1dbc18( "axis" );
    level thread function_706d6c9afc1dbc18( "allies" );
    
    if ( getdvarint( @"hash_69cfaa4519ba27d9", 1 ) == 1 )
    {
        level thread function_3ef533c52fe65d13();
    }
    
    level thread function_c75e96ead41ff2b4();
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    level thread function_5f158bddfe789f90();
    level thread function_fdeebb700e38834c();
}

// Namespace gwtdm
// Params 2
// Checksum 0xc20def01, Offset: 0xb2c6
// Size: 0x1d7
function function_f8dea7df1a56e64e( agent, badpathpos )
{
    if ( !isalive( agent ) )
    {
        return;
    }
    
    agent endon( #"death" );
    team = agent.team;
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        return;
    }
    
    lanekey = agent.lanekey;
    
    if ( !isdefined( lanekey ) )
    {
        return;
    }
    
    if ( !isdefined( agent.var_367b67f6d8106157 ) )
    {
        agent.var_367b67f6d8106157 = 1;
    }
    
    agent.var_367b67f6d8106157++;
    
    if ( agent.var_367b67f6d8106157 == 3 )
    {
        closestvolume = function_42128510cdea417b( agent.origin, team, lanekey );
        agent cleargoalvolume();
        agent setgoalvolumeauto( closestvolume, closestvolume.heading );
        wait 5;
        return;
    }
    
    if ( agent.var_367b67f6d8106157 > 10 )
    {
        agent.imstuck = 1;
        return;
    }
    
    rushorigins = function_47658bdfdb845e7a( agent, team, lanekey );
    
    if ( rushorigins.size > 0 )
    {
        agent.rushorigins = rushorigins;
        agent thread function_17b8acaeeba69407();
        agent thread rushoriginremover();
        agent thread ai_behavior::function_556a769454945ed0( agent, agent.rushorigins, 1024, 1024, 1024 );
        return;
    }
    
    agent.rushorigins = [];
    coverzone = function_43d43a72eeb7fbe1( team, lanekey );
    increasedvariance = level.var_c98a3a72c3f25319 * 3;
    origin = getclosestpointonnavmesh( coverzone.origin + ( randomfloatrange( increasedvariance * -1, increasedvariance ), randomfloatrange( increasedvariance * -1, increasedvariance ), 0 ) );
    agent thread ai_behavior::function_ec43a817c7bf1915( agent, origin );
}

// Namespace gwtdm
// Params 2
// Checksum 0x44998638, Offset: 0xb4a5
// Size: 0x2e2
function overrideagent( agent, lanekey = utility::array_random( getarraykeys( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata ) ) )
{
    agent.lanekey = lanekey;
    level.backagents[ agent.team ][ level.backagents[ agent.team ].size ] = agent;
    agent.backagent = 1;
    agent.frontagent = 0;
    var_27751c88d6b2f170 = 0;
    
    foreach ( team in level.teamnamelist )
    {
        foreach ( var_fc0356337f00899d, struct in level.agentmanager[ team ] )
        {
            if ( arraycontains( level.agentmanager[ team ][ var_fc0356337f00899d ].currentagents, agent ) )
            {
                level.agentmanager[ team ][ var_fc0356337f00899d ].currentagents = arrayremove( level.agentmanager[ team ][ var_fc0356337f00899d ].currentagents, agent );
                var_27751c88d6b2f170 = 1;
                break;
            }
        }
        
        if ( var_27751c88d6b2f170 )
        {
            break;
        }
    }
    
    level.agentmanager[ agent.team ][ lanekey ].currentagents[ level.agentmanager[ agent.team ][ lanekey ].currentagents.size ] = agent;
    
    if ( agent.team == "axis" || agent.bodyoverridden )
    {
        body = undefined;
        head = undefined;
    }
    else
    {
        body = undefined;
        head = undefined;
        agent.bodyoverridden = 1;
    }
    
    grenade_type = agent_utils::function_c7ac99e13a55d70e();
    grenadeammo = getdvarint( @"hash_2e7cc22bee3354df", 1 );
    agent agent_utils::overrideagentsettings( body, head, undefined, grenade_type, grenadeammo );
    ai_mp_controller::function_e054dd1fa33a600a( agent, "gwtdm" );
    agent.revive_bleedouttime = 10000;
    agent thread function_439e0822501c0588();
}

// Namespace gwtdm
// Params 1
// Checksum 0xf6285f83, Offset: 0xb78f
// Size: 0xc4
function function_8b33536b22b930cc( team )
{
    lowestkey = undefined;
    lowestcount = undefined;
    
    foreach ( lanekey, lanedata in level.agentmanager[ team ] )
    {
        count = lanedata.currentagents.size;
        
        if ( !isdefined( lowestcount ) || count < lowestcount )
        {
            lowestcount = count;
            lowestkey = lanekey;
        }
    }
    
    return lowestkey;
}

// Namespace gwtdm
// Params 1
// Checksum 0x18ef912e, Offset: 0xb85c
// Size: 0xbe
function function_4a05ac53c86e495a( origin )
{
    closestkey = undefined;
    closestdist = undefined;
    
    for ( key = 0; key < level.frontlinedata.size ; key++ )
    {
        data = level.frontlinedata[ key ];
        
        for ( lanekey = 0; lanekey < data.lanedata.size ; lanekey++ )
        {
            dist = distance2dsquared( data.lanedata[ lanekey ].origin, origin );
            
            if ( !isdefined( closestdist ) || dist < closestdist )
            {
                closestdist = dist;
                closestkey = lanekey;
            }
        }
    }
    
    return closestkey;
}

// Namespace gwtdm
// Params 1
// Checksum 0x5f06ad14, Offset: 0xb923
// Size: 0xae
function function_334acb395604074a( agent )
{
    lanekey = function_8b33536b22b930cc( agent.team );
    overrideagent( agent, lanekey );
    agent.c130spawn = 1;
    success = function_7f8fe4f187f715f4( agent, agent.team, level.var_f9f9bdd4e4094d63, lanekey );
    
    if ( !success )
    {
        agent.rushorigins = function_47658bdfdb845e7a( agent, agent.team, lanekey );
        agent thread ai_behavior::function_556a769454945ed0( agent, agent.rushorigins, 1024, 1024, 1024 );
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0x15fa3ca0, Offset: 0xb9d9
// Size: 0xae
function overrideagent_paratrooper( agent )
{
    lanekey = function_4a05ac53c86e495a( agent.origin );
    overrideagent( agent, lanekey );
    agent.c130spawn = 1;
    success = function_7f8fe4f187f715f4( agent, agent.team, level.var_f9f9bdd4e4094d63, lanekey );
    
    if ( !success )
    {
        agent.rushorigins = function_47658bdfdb845e7a( agent, agent.team, lanekey );
        agent thread ai_behavior::function_556a769454945ed0( agent, agent.rushorigins, 1024, 1024, 1024 );
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x7b7f47a1, Offset: 0xba8f
// Size: 0x153
function function_f27f579d65445c08()
{
    level.var_26c64a818e8ea257 = [];
    level.var_26c64a818e8ea257[ "allies" ] = [];
    struct = spawnstruct();
    struct.body = "body_sp_ally_mex_sf_tier_1_1_1";
    struct.head = "head_sp_ally_mex_sf_tier_1_1_1";
    level.var_26c64a818e8ea257[ "allies" ][ level.var_26c64a818e8ea257[ "allies" ].size ] = struct;
    struct = spawnstruct();
    struct.body = "body_sp_ally_mex_sf_tier_1_2_1";
    struct.head = "head_sp_ally_mex_sf_tier_1_2_1";
    level.var_26c64a818e8ea257[ "allies" ][ level.var_26c64a818e8ea257[ "allies" ].size ] = struct;
    struct = spawnstruct();
    struct.body = "body_sp_ally_mex_sf_tier_1_3_1";
    struct.head = "head_sp_ally_mex_sf_tier_1_3_1";
    level.var_26c64a818e8ea257[ "allies" ][ level.var_26c64a818e8ea257[ "allies" ].size ] = struct;
    struct = spawnstruct();
    struct.body = "body_sp_ally_mex_sf_tier_1_4_1";
    struct.head = "head_sp_ally_mex_sf_tier_1_4_1";
    level.var_26c64a818e8ea257[ "allies" ][ level.var_26c64a818e8ea257[ "allies" ].size ] = struct;
}

// Namespace gwtdm
// Params 0
// Checksum 0x1ccbd714, Offset: 0xbbea
// Size: 0x87
function function_439e0822501c0588()
{
    self endon( #"death" );
    
    while ( true )
    {
        waitframe();
        
        if ( getdvarint( @"hash_997720413afa2a67", 0 ) == 0 )
        {
            continue;
        }
        
        color = self.team == "allies" ? ( 0, 0, 1 ) : ( 1, 0, 0 );
        level thread debug_utility::drawsphere( self gettagorigin( "j_spinelower" ), 32, level.framedurationseconds, color );
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x2d201d87, Offset: 0xbc79
// Size: 0xfd
function function_17b8acaeeba69407()
{
    self endon( #"death" );
    
    while ( true )
    {
        waitframe();
        
        if ( !isdefined( self.rushorigins ) || self.rushorigins.size == 0 )
        {
            break;
        }
        
        if ( getdvarint( @"hash_90faa795702e8f9", 0 ) == 0 )
        {
            continue;
        }
        
        startpos = self.origin;
        endpos = self.rushorigins[ 0 ];
        level thread debug_utility::drawline( startpos, endpos, level.framedurationseconds, ( 0, 1, 0 ) );
        
        for ( i = 0; i < self.rushorigins.size - 1 ; i++ )
        {
            startpos = self.rushorigins[ i ];
            endpos = self.rushorigins[ i + 1 ];
            level thread debug_utility::drawline( startpos, endpos, level.framedurationseconds, ( 1, 1, 0 ) );
        }
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x1e54dae, Offset: 0xbd7e
// Size: 0x87
function rushoriginremover()
{
    self notify( #"rushoriginremover" );
    self endon( #"rushoriginremover" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_66eb8219383213f4" );
        rushorigins = [];
        
        for ( i = 1; i < self.rushorigins.size ; i++ )
        {
            rushorigins[ rushorigins.size ] = self.rushorigins[ i ];
        }
        
        self.rushorigins = rushorigins;
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xf67e699, Offset: 0xbe0d
// Size: 0x220
function function_8e7db35db37b293c()
{
    while ( true )
    {
        waitframe();
        frontlinekey = getdvarint( @"hash_91b9c2673018accc", -1 );
        lanekey = getdvarint( @"hash_7fc4e6c8f23e5735", -1 );
        
        if ( frontlinekey == -1 || lanekey == -1 )
        {
            continue;
        }
        
        setdvar( @"hash_91b9c2673018accc", -1 );
        setdvar( @"hash_7fc4e6c8f23e5735", -1 );
        
        foreach ( team in level.teamnamelist )
        {
            coverzones = function_b5a13951294d51aa( team, frontlinekey, lanekey );
            var_2291abb54275f111 = coverzones[ randomint( coverzones.size ) ].origin;
            groupname = ai_mp_controller::function_391d43ea550a7a49( var_2291abb54275f111 );
            numagents = 5;
            agentpackage = ai_reinforcements::function_c6a741f41aaede19( numagents, undefined, level.agenttier, "gwtdm" );
            agentpackage.reinforcementtype = "Helicopter";
            agents_heli = [[ utility::getsharedfunc( #"heli", #"requestReinforcements" ) ]]( "heli", "requestReinforcements", numagents, var_2291abb54275f111, "medium", "everybody", "captureAgents", groupname, team, 0, undefined, undefined, undefined, agentpackage, 1, 1 );
            
            foreach ( agent in agents_heli )
            {
                overrideagent( agent, lanekey );
            }
        }
    }
}

// Namespace gwtdm
// Params 3
// Checksum 0x74201a8b, Offset: 0xc035
// Size: 0x427
function function_cca65f2b108d0bef( desired_origin, var_6d02049e49f1e1a0, team )
{
    unload_locs = undefined;
    
    if ( false )
    {
        level thread debug::drawsphere( desired_origin, 32, 60, ( 1, 1, 1 ) );
    }
    
    closestpoint = pointonsegmentnearesttopoint( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].minpoint, level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].maxpoint, desired_origin );
    
    if ( false )
    {
        level thread debug::drawsphere( closestpoint, 32, 60, ( 0, 1, 1 ) );
    }
    
    unload_locs = sortbydistance( level.helireinforcestruct.unload_locs, closestpoint );
    var_53d608b7c7ac0e21 = 5;
    
    if ( var_6d02049e49f1e1a0 )
    {
        var_53d608b7c7ac0e21 = 1;
    }
    
    close_unload_locs = [];
    
    foreach ( loc in unload_locs )
    {
        if ( close_unload_locs.size == var_53d608b7c7ac0e21 )
        {
            break;
        }
        
        if ( outofbounds::ispointinoutofbounds( loc.origin, team ) )
        {
            continue;
        }
        
        var_e153b0570cd74635 = vectornormalize( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].origin - loc.origin );
        
        if ( vectordot( level.spawnselectionteamforward[ team ], var_e153b0570cd74635 ) < 0 )
        {
            continue;
        }
        
        dropoffclosestpoint = pointonsegmentnearesttopoint( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].minpoint, level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].maxpoint, loc.origin );
        mindist = getdvarint( @"hash_8ea81d61879b569f", 3000 );
        mindistsq = mindist * mindist;
        distsq = distance2dsquared( loc.origin, dropoffclosestpoint );
        
        if ( distsq < mindistsq )
        {
            if ( false )
            {
                level thread debug::drawsphere( loc.origin, 32, 60, ( 1, 0, 0 ) );
                level thread debug::drawline( dropoffclosestpoint, loc.origin, 60, ( 1, 0, 0 ) );
            }
            
            continue;
        }
        
        if ( false )
        {
            level thread debug::drawsphere( loc.origin, 32, 60, ( 0, 1, 0 ) );
            level thread debug::drawline( dropoffclosestpoint, loc.origin, 60, ( 0, 1, 0 ) );
        }
        
        close_unload_locs[ close_unload_locs.size ] = loc;
    }
    
    if ( !level.forceclosest )
    {
        close_unload_locs = arrayrandomize( close_unload_locs );
    }
    
    foreach ( node in close_unload_locs )
    {
        if ( utility::callsharedfunc( #"heli", #"hash_ae5ac6ed06687f8e", node ) )
        {
            return node;
        }
    }
    
    foreach ( node in unload_locs )
    {
        if ( utility::callsharedfunc( #"heli", #"hash_ae5ac6ed06687f8e", node ) )
        {
            return node;
        }
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0xa0a4aa08, Offset: 0xc464
// Size: 0x29d
function function_eb40fe818a5cfaff( params )
{
    agent = self;
    attacker = params.eattacker;
    
    if ( isdefined( attacker ) && isdefined( attacker.owner ) )
    {
        attacker = attacker.owner;
    }
    
    team = agent.team;
    
    if ( isplayer( attacker ) && !isagent( attacker ) && attacker.team != team )
    {
        gamescore::giveteamscoreforobjective( attacker.team, level.pointsperkillai, 0 );
        
        if ( getdvarint( @"hash_2e405e2912dc4a44", 0 ) == 1 )
        {
            attacker thread rank::scoreeventpopup( hashcat( #"hash_2c8bcbb02ec7ff9b", level.pointsperkillai ) );
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "contribution" ] ) )
            {
                attacker.leaderboarddata[ "contribution" ] = attacker.leaderboarddata[ "contribution" ] + level.pointsperkillai;
            }
            
            if ( isdefined( level.leaderboardfunc[ "contribution" ] ) )
            {
                [[ level.leaderboardfunc[ "contribution" ] ]]( attacker, level.pointsperkillai );
            }
            
            assert( isint( level.pointsperkillai ) || isfloat( level.pointsperkillai ), "<dev string:x75>" );
            
            if ( isdefined( attacker.pers[ "contribution" ] ) )
            {
                attacker.pers[ "contribution" ] = attacker.pers[ "contribution" ] + level.pointsperkillai;
            }
        }
        
        attacker stats::setextrascore0( attacker.pers[ "contribution" ], "contribution" );
        
        if ( isplayer( attacker ) )
        {
            killfeeddata = 0;
            killfeeddata += 2;
            killfeeddata += level.pointsperkillai << 4;
            attacker common::killfeedevent( killfeeddata, -1 );
        }
    }
    
    lanekey = agent.lanekey;
    
    if ( !isdefined( agent.lanekey ) || !team_utility::isgameplayteam( team ) )
    {
        return;
    }
    
    level.agentmanager[ team ][ lanekey ].currentagents = arrayremove( level.agentmanager[ team ][ lanekey ].currentagents, agent );
}

// Namespace gwtdm
// Params 1
// Checksum 0x7697024e, Offset: 0xc709
// Size: 0x1ee
function function_706d6c9afc1dbc18( team )
{
    var_1c025155366cfdcf = getdvarint( @"hash_a190addb512ec71a", 2 );
    var_f38458d7f5c000ec = getdvarint( @"hash_60235d2ae0550bc5", 6 );
    var_89b69b6927ff1081 = getdvarint( @"hash_bad4b491469253ef", 30 ) * 1000;
    helireinforcements = getdvarint( @"hash_289d6da5e0aff476", 1 );
    budgetname = "spawnHQ_" + team;
    ai_mp_controller::aibudget_registercategory( budgetname, int( level.var_d95835502ec96520 * 1.5 ) );
    function_837d23a635e6dc84( team, helireinforcements, var_f38458d7f5c000ec );
    wait getdvarfloat( @"hash_eb2244b6b2a89169", 15 );
    
    while ( true )
    {
        wait 5;
        currenttime = gettime();
        
        if ( !ai_mp_controller::function_5c695081e6879c5f( var_1c025155366cfdcf ) )
        {
            continue;
        }
        
        foreach ( lanekey, lanedata in level.agentmanager[ team ] )
        {
            if ( lanedata.currentagents.size >= lanedata.var_21b4e7b2ee56d24c - 1 )
            {
                continue;
            }
            
            success = 0;
            
            if ( helireinforcements && ( currenttime > lanedata.var_1e69802e27a5eeed + var_89b69b6927ff1081 || lanedata.var_1e69802e27a5eeed == 0 ) )
            {
                success = level function_54507734a7791693( var_f38458d7f5c000ec, team, level.var_f9f9bdd4e4094d63, lanekey );
                
                if ( success )
                {
                    lanedata.var_1e69802e27a5eeed = currenttime;
                }
            }
            
            if ( !success )
            {
                level spawnhqagents( var_1c025155366cfdcf, team, lanekey );
            }
        }
    }
}

// Namespace gwtdm
// Params 3
// Checksum 0x7d1d050b, Offset: 0xc8ff
// Size: 0x1eb
function function_837d23a635e6dc84( team, helireinforcements, var_f38458d7f5c000ec )
{
    gamelogic_mp::waitforplayers( level.prematchperiod, 0, 0 );
    heliintro = 1;
    
    if ( getdvarint( @"hash_3d8fbe08639da15a", 1 ) == 0 )
    {
        heliintro = 0;
    }
    
    helistarted = helireinforcements && heliintro ? 0 : 1;
    ac130started = !level.var_2d9fd980185f6441;
    
    if ( helistarted && ac130started )
    {
        return;
    }
    
    var_5f3f9d0d28473a82 = 0;
    
    if ( level.infilskip )
    {
        var_5f3f9d0d28473a82 = 12;
    }
    
    var_caa9765031d5bc4e = 20 - var_5f3f9d0d28473a82;
    waittime_heli = level.prematchperiodend - var_caa9765031d5bc4e;
    waittime_heli = waittime_heli > 0 ? waittime_heli : 0;
    var_9c4d2a0ae597ac9a = 20 - var_5f3f9d0d28473a82;
    waittime_ac130 = level.prematchperiodend - var_9c4d2a0ae597ac9a;
    waittime_ac130 = waittime_ac130 > 0 ? waittime_ac130 : 0;
    
    for ( timepassed = 0; !helistarted || !ac130started ; timepassed++ )
    {
        if ( !helistarted && timepassed >= waittime_heli )
        {
            foreach ( lanekey, lanedata in level.agentmanager[ team ] )
            {
                level thread function_fd3953f45ce411a( team, lanedata, lanekey, var_f38458d7f5c000ec );
            }
            
            helistarted = 1;
        }
        
        if ( !ac130started && timepassed >= waittime_ac130 )
        {
            function_effbca31a07902a4( 10, level.var_f9f9bdd4e4094d63, team );
            ac130started = 1;
        }
        
        wait 1;
    }
}

// Namespace gwtdm
// Params 3
// Checksum 0x56d92bc2, Offset: 0xcaf2
// Size: 0x97
function function_5b454d6e9ce9fe35( team, lanedata, lanekey )
{
    var_101905361e2c167e = 2;
    var_20a1c0be5d4a6a6a = 0;
    var_8fac49599c8e5729 = int( lanedata.var_21b4e7b2ee56d24c / 2 );
    
    while ( var_20a1c0be5d4a6a6a < var_8fac49599c8e5729 )
    {
        var_f8b160b2a48244c0 = var_101905361e2c167e;
        
        if ( var_20a1c0be5d4a6a6a + var_101905361e2c167e > var_8fac49599c8e5729 )
        {
            var_f8b160b2a48244c0 = var_8fac49599c8e5729 - var_20a1c0be5d4a6a6a;
        }
        
        level spawnhqagents( var_f8b160b2a48244c0, team, lanekey );
        var_20a1c0be5d4a6a6a += var_f8b160b2a48244c0;
        wait randomfloatrange( 2.5, 4 );
    }
}

// Namespace gwtdm
// Params 4
// Checksum 0xa05c9e66, Offset: 0xcb91
// Size: 0x93
function function_fd3953f45ce411a( team, lanedata, lanekey, var_f38458d7f5c000ec )
{
    var_8fac49599c8e5729 = int( lanedata.var_21b4e7b2ee56d24c / 4 );
    numhelis = var_8fac49599c8e5729 / var_f38458d7f5c000ec;
    
    for ( i = 0; i < numhelis ; i++ )
    {
        wait randomfloatrange( 1, 3 ) + ( lanekey + 2 ) * 2;
        level function_54507734a7791693( var_f38458d7f5c000ec, team, level.var_f9f9bdd4e4094d63, lanekey );
    }
}

// Namespace gwtdm
// Params 3
// Checksum 0xbc661fa8, Offset: 0xcc2c
// Size: 0x4c3
function spawnhqagents( numagents, team, lanekey )
{
    if ( level.usespawnselection )
    {
        hqstring = "gw_fob_" + team + "HQ";
        var_8ac28db1d6e83438 = level.spawnselectionlocations[ hqstring ][ team ].spawnpoints;
        budgetname = "spawnHQ_" + team;
        
        for ( i = 0; i < numagents ; i++ )
        {
            aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, "gwtdm", undefined, level.agenttier, level.teamnationality[ team ] );
            agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, var_8ac28db1d6e83438[ i ].origin, var_8ac28db1d6e83438[ i ].angles, "medium", budgetname, undefined, undefined, team, undefined, undefined, 1 );
            
            if ( isdefined( agent ) )
            {
                overrideagent( agent, lanekey );
                success = function_7f8fe4f187f715f4( agent, team, level.var_f9f9bdd4e4094d63, lanekey );
                
                if ( !success )
                {
                    agent.rushorigins = function_47658bdfdb845e7a( agent, team, lanekey );
                    agent thread function_17b8acaeeba69407();
                    agent thread rushoriginremover();
                    agent thread ai_behavior::function_556a769454945ed0( agent, agent.rushorigins, 1024, 1024, 1024 );
                }
            }
        }
        
        return;
    }
    
    if ( level.agenttier == 1 && !level.var_8bca5ca707b08206 || level.agenttier == 2 && !level.var_8bca5ba707b07fd3 )
    {
        if ( !level.var_49774490cf05bdac )
        {
            return;
        }
        
        players = teams::getteamdata( team, "players" );
        
        if ( players.size > 0 )
        {
            spawnpoint = players[ 0 ] getspawnpointforplayer();
            
            if ( isdefined( spawnpoint ) )
            {
                aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, "gwtdm", undefined, level.agenttier, level.teamnationality[ team ] );
                agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnpoint.origin, spawnpoint.angles, "medium", "spawnHQ_" + team, undefined, undefined, team, undefined, undefined, 1 );
                
                if ( isdefined( agent ) )
                {
                    overrideagent( agent, lanekey );
                    success = function_7f8fe4f187f715f4( agent, team, level.var_f9f9bdd4e4094d63, lanekey );
                    
                    if ( !success )
                    {
                        agent.rushorigins = function_47658bdfdb845e7a( agent, team, lanekey );
                        agent thread function_17b8acaeeba69407();
                        agent thread rushoriginremover();
                        agent thread ai_behavior::function_556a769454945ed0( agent, agent.rushorigins, 1024, 1024, 1024 );
                    }
                }
            }
        }
        
        return;
    }
    
    if ( level.var_f66265d7644a0a55 )
    {
        players = teams::getteamdata( team, "players" );
        
        if ( !isdefined( players ) || players.size == 0 )
        {
            return;
        }
        
        idealdist = getdvarint( @"hash_a66b78681b2d0805", 4096 );
        spawnparams = [];
        spawnparams[ "teamForward" ] = level.spawnselectionteamforward[ team ];
        spawnparams[ "idealDistSq" ] = idealdist * idealdist;
        spawnlogic::activatespawnset( level.var_2ce763571761b799[ team ], 1 );
        spawnpoint = players[ 0 ] spawnlogic::getspawnpointlegacy( players[ 0 ], team, level.var_2ce763571761b799[ team ], undefined, undefined, spawnparams );
        
        if ( isdefined( spawnpoint ) )
        {
            aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, "gwtdm", undefined, level.agenttier, level.teamnationality[ team ] );
            agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnpoint.origin, spawnpoint.angles, "medium", "spawnHQ_" + team, undefined, undefined, team, undefined, undefined, 1 );
            
            if ( isdefined( agent ) )
            {
                overrideagent( agent, lanekey );
                success = function_7f8fe4f187f715f4( agent, team, level.var_f9f9bdd4e4094d63, lanekey );
                
                if ( !success )
                {
                    agent.rushorigins = function_47658bdfdb845e7a( agent, team, lanekey );
                    agent thread function_17b8acaeeba69407();
                    agent thread rushoriginremover();
                    agent thread ai_behavior::function_556a769454945ed0( agent, agent.rushorigins, 1024, 1024, 1024 );
                }
            }
        }
        
        return;
    }
    
    spawnpoint = function_f7a16cfa00bd675( team, lanekey );
    heading = vectortoangles( level.spawnselectionteamforward[ team ] );
    agents = level [[ utility::getsharedfunc( #"hash_3b1120debc62f8b", #"requestReinforcements" ) ]]( numagents, spawnpoint.origin, undefined, undefined, "medium", "spawnHQ_" + team, "debug", team, undefined, undefined, heading, &overrideagent_paratrooper, 1, 1, level.agenttier );
}

// Namespace gwtdm
// Params 4
// Checksum 0xa75860b2, Offset: 0xd0f7
// Size: 0x178, Type: bool
function function_54507734a7791693( numagents, team, frontlinekey, lanekey )
{
    coverzone = function_43d43a72eeb7fbe1( team, lanekey );
    groupname = ai_mp_controller::function_391d43ea550a7a49( coverzone.origin, numagents );
    agentpackage = ai_reinforcements::function_c6a741f41aaede19( numagents, undefined, level.agenttier, "gwtdm" );
    agentpackage.reinforcementtype = "Helicopter";
    agents_heli = [[ utility::getsharedfunc( #"heli", #"requestReinforcements" ) ]]( numagents, coverzone.origin, "medium", "everybody", "captureAgents", groupname, team, 0, undefined, undefined, undefined, agentpackage, 1, 1 );
    
    if ( !isdefined( agents_heli ) )
    {
        return false;
    }
    
    foreach ( agent in agents_heli )
    {
        overrideagent( agent, lanekey );
        agent.helispawn = 1;
        function_870b176bbe92e79a( agent, agent.team, lanekey );
    }
    
    return true;
}

// Namespace gwtdm
// Params 1
// Checksum 0xf7809e8c, Offset: 0xd278
// Size: 0x29b
function function_993bb84177c80527( advancingteam )
{
    if ( !isdefined( level.agentmanager ) )
    {
        return;
    }
    
    level thread function_9a783169aa3ef4fa();
    
    foreach ( team in level.teamnamelist )
    {
        level.backagents[ team ] = [];
        level.frontagents[ team ] = [];
        level thread function_c60ac6c44b0f37dd( team );
        
        if ( team == advancingteam )
        {
            level thread function_df0277c0a8dfc95c( team );
        }
        else
        {
            level thread function_8d2da178e1f3d9dd( team );
        }
        
        foreach ( lanekey, lanedata in level.agentmanager[ team ] )
        {
            lanedata.var_9dfc097ba9b3c109 = function_b5a13951294d51aa( team, level.var_f9f9bdd4e4094d63, lanekey );
            
            foreach ( agent in lanedata.currentagents )
            {
                if ( agent.frontagent )
                {
                    level.frontagents[ team ][ level.frontagents[ team ].size ] = agent;
                    agent.backagent = 0;
                    agent.frontagent = 1;
                    agent.var_cd4355a515279871 = 0;
                }
                else
                {
                    level.backagents[ team ][ level.backagents[ team ].size ] = agent;
                    agent.backagent = 1;
                    agent.frontagent = 0;
                    agent.var_cd4355a515279871 = 0;
                }
                
                if ( agent.var_68a58465ed3f2958 )
                {
                    continue;
                }
                
                if ( !isalive( agent ) )
                {
                    continue;
                }
                
                agent thread function_870b176bbe92e79a( agent, team, lanekey );
            }
        }
    }
}

// Namespace gwtdm
// Params 3
// Checksum 0xa5b15d5a, Offset: 0xd51b
// Size: 0x1a2
function function_870b176bbe92e79a( agent, team, lanekey )
{
    agent endon( #"death" );
    
    if ( !isalive( agent ) )
    {
        return;
    }
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    if ( !isdefined( team ) )
    {
        team = agent.team;
    }
    
    if ( !isdefined( lanekey ) )
    {
        lanekey = agent.lanekey;
    }
    
    if ( !( isdefined( team ) && isdefined( lanekey ) ) )
    {
        return;
    }
    
    if ( agent.capdelaytime > 0 )
    {
        wait agent.capdelaytime + 1;
    }
    
    success = function_7f8fe4f187f715f4( agent, team, level.var_f9f9bdd4e4094d63, lanekey );
    
    if ( !success )
    {
        rushorigins = function_47658bdfdb845e7a( agent, team, lanekey );
        
        if ( rushorigins.size > 0 )
        {
            agent.rushorigins = rushorigins;
            agent thread function_17b8acaeeba69407();
            agent thread rushoriginremover();
            agent thread ai_behavior::function_556a769454945ed0( agent, agent.rushorigins, 1024, 1024, 1024 );
            return;
        }
        
        agent.rushorigins = [];
        coverzone = function_43d43a72eeb7fbe1( team, lanekey );
        origin = getclosestpointonnavmesh( coverzone.origin + ( randomfloatrange( level.var_c98a3a72c3f25319 * -1, level.var_c98a3a72c3f25319 ), randomfloatrange( level.var_c98a3a72c3f25319 * -1, level.var_c98a3a72c3f25319 ), 0 ) );
        agent thread ai_behavior::function_ec43a817c7bf1915( agent, origin, 1024, 1024, 1024, undefined, undefined, undefined, &ai_behavior::function_52624f664c165308 );
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0xcd46a0cf, Offset: 0xd6c5
// Size: 0x101
function function_552126a0f1af01b2( agent )
{
    if ( getdvarint( @"hash_6243ee712b007b0b", 0 ) == 1 )
    {
        return;
    }
    
    agent endon( #"death" );
    agent notify( #"hash_5955f48185997567" );
    agent endon( #"hash_5955f48185997567" );
    timesclose = 0;
    lastdist = undefined;
    
    while ( true )
    {
        wait 0.5;
        dist = distance2dsquared( agent.var_79845720de15eab6.origin, agent.origin );
        
        if ( dist < 65536 )
        {
            if ( !isdefined( lastdist ) )
            {
                lastdist = dist;
            }
            else if ( abs( lastdist - dist ) < 4096 )
            {
                timesclose++;
                lastdist = dist;
            }
            else
            {
                timesclose = 0;
            }
        }
        else
        {
            timesclose = 0;
        }
        
        if ( timesclose >= 3 )
        {
            agent thread function_c6043d04012724b2( agent, agent.team );
            agent notify( #"hash_5955f48185997567" );
        }
    }
}

// Namespace gwtdm
// Params 2
// Checksum 0x835612c0, Offset: 0xd7ce
// Size: 0x62
function function_9cca644273d484fa( agent, time )
{
    agent endon( #"death" );
    
    for ( timepassed = 0; timepassed < time ; timepassed++ )
    {
        thread debug::drawsphere( agent.origin, 128, 1, ( 0, 1, 1 ) );
        wait 1;
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0xa8370bfa, Offset: 0xd838
// Size: 0x193
function function_df0277c0a8dfc95c( team )
{
    capname = "cap_bark_orders";
    animset = "cap_bark_orders_advance";
    
    foreach ( lanedata in level.agentmanager[ team ] )
    {
        agents = arrayrandomize( lanedata.currentagents );
        var_ff673f2c042ef02c = 6;
        numrun = 0;
        origin = function_760e359e69fa8a00( agents );
        
        if ( isdefined( origin ) )
        {
            playsoundatpos( origin, "mp_walla_invasion_charge_group" );
        }
        
        foreach ( agent in agents )
        {
            if ( numrun >= var_ff673f2c042ef02c )
            {
                break;
            }
            
            if ( !function_da9c638d992fbf74( agent ) )
            {
                continue;
            }
            
            numrun++;
            agent thread function_6a5e5cb1a7562765( agent, agent.origin, capname, animset, undefined, undefined, "mp_walla_invasion_charge_individual" );
        }
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0x3561dd87, Offset: 0xd9d3
// Size: 0x1b9
function function_8d2da178e1f3d9dd( team )
{
    capname = "cap_bark_orders";
    animset = "cap_bark_orders_fallback";
    
    foreach ( lanedata in level.agentmanager[ team ] )
    {
        agents = arrayrandomize( lanedata.currentagents );
        var_3e2906d7e1191c48 = 6;
        var_da129fa1e2d51b11 = 0;
        var_843fe6668716b3a7 = 3;
        var_ba43391cc0037a7a = 0;
        origin = function_760e359e69fa8a00( agents );
        
        if ( isdefined( origin ) )
        {
            playsoundatpos( origin, "mp_walla_invasion_retreat_group" );
        }
        
        foreach ( agent in agents )
        {
            if ( !function_da9c638d992fbf74( agent ) )
            {
                continue;
            }
            
            if ( var_da129fa1e2d51b11 < var_3e2906d7e1191c48 )
            {
                var_da129fa1e2d51b11++;
                agent thread function_6a5e5cb1a7562765( agent, agent.origin, capname, animset );
                continue;
            }
            
            if ( var_ba43391cc0037a7a < var_843fe6668716b3a7 )
            {
                var_ba43391cc0037a7a++;
                function_47d81f05f6d78450( agent );
            }
        }
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x42491549, Offset: 0xdb94
// Size: 0x33d
function function_fdeebb700e38834c()
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_efa65def009de58c", 0 ) == 1 )
    {
        return;
    }
    
    var_8924bc2d2874fa81 = getdvarint( @"hash_fbc6c90a51e19cfa", 10 );
    var_8bc2955c2b27549 = getdvarint( @"hash_726c19967a7eb54c", 33 );
    var_62beb66c1a596e9a = getdvarint( @"hash_13411e313136639f", 33 );
    var_5be156428d71ae50 = getdvarint( @"hash_1818a2df93845813", 33 );
    totaltickets = var_8924bc2d2874fa81 + var_8bc2955c2b27549 + var_62beb66c1a596e9a + var_5be156428d71ae50;
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    wait 30;
    var_e7c9c64ee3da3459 = 0;
    var_c1ef70d445ec78b9 = 0;
    closestagents = undefined;
    
    while ( true )
    {
        var_6410a1dc9b61cb3 = 0;
        randomplayerindex = -1;
        
        for ( possibleplayers = level.players; !var_6410a1dc9b61cb3 && possibleplayers.size > 0 ; possibleplayers = level.players )
        {
            randomplayerindex = randomint( possibleplayers.size );
            
            if ( isalive( possibleplayers[ randomplayerindex ] ) )
            {
                var_6410a1dc9b61cb3 = 1;
                break;
            }
            else
            {
                possibleplayers[ randomplayerindex ] = undefined;
            }
            
            if ( possibleplayers.size <= 0 )
            {
                wait 1;
            }
        }
        
        playerteam = undefined;
        
        if ( randomplayerindex > -1 )
        {
            closestagents = sortbydistance( level.agentarray, possibleplayers[ randomplayerindex ].origin );
            playerteam = possibleplayers[ randomplayerindex ].team;
            possibleplayers[ randomplayerindex ] = undefined;
        }
        
        success = 0;
        
        foreach ( agent in closestagents )
        {
            if ( function_da9c638d992fbf74( agent ) && isdefined( playerteam ) && agent.team == playerteam && ( !isdefined( agent.var_5b34f5a378f060dd ) || agent.var_5b34f5a378f060dd < gettime() + 10000 ) )
            {
                agent.var_5b34f5a378f060dd = gettime();
                roll = randomint( totaltickets );
                
                if ( roll <= var_8924bc2d2874fa81 && isdefined( agent.enemy ) )
                {
                    agent thread function_ea9085bb0b86b57a( agent );
                }
                else if ( roll <= var_8924bc2d2874fa81 + var_8bc2955c2b27549 )
                {
                    agent thread function_47d81f05f6d78450( agent );
                }
                else if ( roll <= var_8924bc2d2874fa81 + var_8bc2955c2b27549 + var_62beb66c1a596e9a )
                {
                    agent thread function_6a5e5cb1a7562765( agent, agent.origin, "cap_bark_orders", "cap_bark_orders_advance" );
                }
                else
                {
                    agent thread function_6a5e5cb1a7562765( agent, agent.origin, "cap_bark_orders", "cap_bark_orders_fallback" );
                }
                
                success = 1;
            }
            
            if ( success )
            {
                var_e7c9c64ee3da3459++;
                wait 5;
                break;
            }
            
            var_c1ef70d445ec78b9++;
            
            if ( var_c1ef70d445ec78b9 >= 5 )
            {
                var_c1ef70d445ec78b9 = 0;
                waitframe();
            }
        }
        
        if ( !success || var_e7c9c64ee3da3459 >= 5 )
        {
            possibleplayers = level.players;
            wait 5;
        }
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xad75ba5e, Offset: 0xded9
// Size: 0xed
function function_9a783169aa3ef4fa()
{
    foreach ( agent in level.agentarray )
    {
        if ( !function_da9c638d992fbf74( agent ) )
        {
            continue;
        }
        
        if ( !agent.imstuck )
        {
            continue;
        }
        
        if ( !agent asmhasstate( agent.asmname, "choose_long_death" ) )
        {
            continue;
        }
        
        agent.var_a084b666aeaef9c1 = 1;
        agent.imstuck = 0;
        agent.revive_bleedouttime = 5000;
        agent thread function_ea9085bb0b86b57a( agent );
        wait randomfloatrange( 2, 3 );
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0xad843509, Offset: 0xdfce
// Size: 0xba, Type: bool
function function_da9c638d992fbf74( agent )
{
    if ( !isalive( agent ) )
    {
        return false;
    }
    
    if ( isint( agent.vehicle_position ) )
    {
        return false;
    }
    
    if ( agent.var_a084b666aeaef9c1 )
    {
        return false;
    }
    
    if ( isdefined( agent.landing_spot ) )
    {
        return false;
    }
    
    if ( agent isinscriptedstate() )
    {
        return false;
    }
    
    if ( agent.doinglongdeath )
    {
        return false;
    }
    
    if ( isdefined( agent getinteractionid() ) )
    {
        return false;
    }
    
    if ( !agent isonornearstairs() )
    {
        return false;
    }
    
    negotiationnode = agent getnearbynegotiationinfo( 32 );
    
    if ( isdefined( negotiationnode ) )
    {
        return false;
    }
    
    if ( agent.asmname != agent.defaultasm )
    {
        return false;
    }
    
    return true;
}

// Namespace gwtdm
// Params 7
// Checksum 0x740899a1, Offset: 0xe091
// Size: 0xc5
function function_6a5e5cb1a7562765( agent, origin, capname, animset, delaymin, delaymax, var_64dc322212521914 )
{
    agent endon( #"death" );
    
    if ( !isdefined( delaymin ) )
    {
        delaymin = 0.1;
    }
    
    if ( !isdefined( delaymax ) )
    {
        delaymax = 2;
    }
    
    agent.capdelaytime = randomfloatrange( delaymin, delaymax );
    wait agent.capdelaytime;
    agent.capdelaytime = -1;
    
    if ( !function_da9c638d992fbf74( agent ) )
    {
        return;
    }
    
    agent thread cap::function_b26f782b6bed85d5( origin, capname, animset, 1 );
    
    if ( isdefined( var_64dc322212521914 ) )
    {
        playsoundatpos( agent.origin, var_64dc322212521914 );
    }
}

// Namespace gwtdm
// Params 5
// Checksum 0x29edb979, Offset: 0xe15e
// Size: 0xa0
function function_47d81f05f6d78450( agent, useinplace, var_352241c1dec9c073, delaymin, delaymax )
{
    agent endon( #"death" );
    
    if ( !isdefined( delaymin ) )
    {
        delaymin = 0.1;
    }
    
    if ( !isdefined( delaymax ) )
    {
        delaymax = 2;
    }
    
    if ( !isdefined( useinplace ) )
    {
        useinplace = 1;
    }
    
    agent.capdelaytime = randomfloatrange( delaymin, delaymax );
    wait agent.capdelaytime;
    agent.capdelaytime = -1;
    
    if ( !function_da9c638d992fbf74( agent ) )
    {
        return;
    }
    
    namespace_c522e27d9c6b70c9::function_e875f085e6e6363b( agent, useinplace, var_352241c1dec9c073 );
}

// Namespace gwtdm
// Params 4
// Checksum 0xa7fa9701, Offset: 0xe206
// Size: 0xa3
function function_ea9085bb0b86b57a( agent, helper, delaymin, delaymax )
{
    agent endon( #"death" );
    
    if ( !isdefined( delaymin ) )
    {
        delaymin = 1;
    }
    
    if ( !isdefined( delaymax ) )
    {
        delaymax = 4;
    }
    
    agent.capdelaytime = randomfloatrange( delaymin, delaymax );
    wait agent.capdelaytime;
    agent.capdelaytime = -1;
    
    if ( !function_da9c638d992fbf74( agent ) )
    {
        return;
    }
    
    if ( agent asmhasstate( agent.asmname, "choose_long_death" ) )
    {
        namespace_c522e27d9c6b70c9::function_a4e32abcc0e367d4( agent, helper );
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x9edf7d2d, Offset: 0xe2b1
// Size: 0x2ba
function function_c75e96ead41ff2b4()
{
    if ( !flags::gameflag( "infil_will_run" ) )
    {
        return;
    }
    
    if ( level.prematchperiodend > 0 )
    {
        level waittill( #"match_start_real_countdown" );
    }
    else
    {
        return;
    }
    
    landinglocs = [];
    navobstacleids = [];
    
    foreach ( team in game[ "infil" ] )
    {
        if ( !isdefined( team[ 1 ] ) )
        {
            continue;
        }
        
        foreach ( infiltype in team[ 1 ] )
        {
            foreach ( var_bd1f6c6a3b32a44b in infiltype )
            {
                landinglocs[ landinglocs.size ] = var_bd1f6c6a3b32a44b.path;
            }
        }
    }
    
    foreach ( landingloc in landinglocs )
    {
        navobstacleids[ navobstacleids.size ] = createnavobstaclebybounds( landingloc.origin, ( 200, 128, 200 ), landingloc.angles );
    }
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    wait 3;
    
    foreach ( var_41b13d8ba52c12e0 in navobstacleids )
    {
        destroynavobstacle( var_41b13d8ba52c12e0 );
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0x2857a88c, Offset: 0xe573
// Size: 0xaf
function function_760e359e69fa8a00( agents )
{
    origins = [];
    
    foreach ( agent in agents )
    {
        if ( function_da9c638d992fbf74( agent ) )
        {
            origins[ origins.size ] = agent.origin;
        }
    }
    
    if ( origins.size > 0 )
    {
        return averagepoint( origins );
    }
    
    return;
}

// Namespace gwtdm
// Params 0
// Checksum 0xf6ffac02, Offset: 0xe62a
// Size: 0x286
function function_eb2b0550ab4e4172()
{
    stepy = 25;
    
    while ( true )
    {
        waitframe();
        
        if ( getdvarint( @"hash_ae55816cba943c57", 0 ) == 0 )
        {
            continue;
        }
        
        foreach ( team in level.teamnamelist )
        {
            startx = 400;
            
            if ( team == "allies" )
            {
                startx = 800;
            }
            
            starty = 300;
            
            /#
                printtoscreen2d( startx, starty, team, ( 1, 1, 1 ), 1 );
            #/
            
            foreach ( lanekey, lanedata in level.agentmanager[ team ] )
            {
                linecount = 1;
                
                /#
                    printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x26d>" + lanekey + "<dev string:x277>", ( 1, 1, 1 ), 1 );
                #/
                
                linecount++;
                
                foreach ( index, agent in lanedata.currentagents )
                {
                    color = ( 1, 1, 1 );
                    
                    if ( agent.helispawn )
                    {
                        color = ( 0, 1, 0 );
                    }
                    else if ( agent.c130spawn )
                    {
                        color = ( 0, 1, 1 );
                    }
                    
                    /#
                        printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x279>" + index + "<dev string:x27b>" + agent getentitynumber(), color, 1 );
                    #/
                    
                    linecount++;
                }
                
                startx += 100;
            }
        }
    }
}

// Namespace gwtdm
// Params 3
// Checksum 0x15b6a3bd, Offset: 0xe8b8
// Size: 0x2bb
function function_efaf30b680072745( killstreakname, killstreakteam, attacker )
{
    if ( isdefined( attacker ) && isdefined( attacker.owner ) )
    {
        attacker = attacker.owner;
    }
    
    if ( !( isdefined( attacker ) && isdefined( attacker.team ) && isdefined( killstreakteam ) ) )
    {
        return;
    }
    
    if ( !isenemyteam( killstreakteam, attacker.team ) )
    {
        return;
    }
    
    if ( isagent( attacker ) )
    {
        return;
    }
    
    var_b953543d7e8d89ac = 0;
    
    switch ( killstreakname )
    {
        case #"hash_27002778019fb447":
        case #"hash_4d5aa76e8707f47b":
        case #"hash_634b246c3da5c56f":
        case #"hash_9e36e3bd3a9dd00d":
        case #"hash_ab5712e297cd430e":
        case #"hash_cf0ef5bef19a311b":
        case #"hash_e40585107590f016":
            var_b953543d7e8d89ac = 5;
            break;
        case #"hash_bf2f9adbd2b41d5":
        case #"hash_2289ec11d77bce8f":
        case #"hash_349713b5ad494dda":
        case #"hash_887ad77192b9c4fb":
            var_b953543d7e8d89ac = 10;
            break;
        case #"hash_413c38e72fe8b5bf":
        case #"hash_4ad475e6e15635bd":
            var_b953543d7e8d89ac = 15;
            break;
    }
    
    if ( var_b953543d7e8d89ac > 0 )
    {
        gamescore::giveteamscoreforobjective( attacker.team, var_b953543d7e8d89ac, 0 );
        
        if ( getdvarint( @"hash_2e405e2912dc4a44", 0 ) == 1 )
        {
            attacker thread rank::scoreeventpopup( hashcat( #"hash_2c8bcbb02ec7ff9b", var_b953543d7e8d89ac ) );
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "contribution" ] ) )
            {
                attacker.leaderboarddata[ "contribution" ] = attacker.leaderboarddata[ "contribution" ] + var_b953543d7e8d89ac;
            }
            
            if ( isdefined( level.leaderboardfunc[ "contribution" ] ) )
            {
                [[ level.leaderboardfunc[ "contribution" ] ]]( attacker, var_b953543d7e8d89ac );
            }
            
            assert( isint( var_b953543d7e8d89ac ) || isfloat( var_b953543d7e8d89ac ), "<dev string:x75>" );
            
            if ( isdefined( attacker.pers[ "contribution" ] ) )
            {
                attacker.pers[ "contribution" ] = attacker.pers[ "contribution" ] + var_b953543d7e8d89ac;
            }
        }
        
        attacker stats::setextrascore0( attacker.pers[ "contribution" ], "contribution" );
        
        if ( isplayer( attacker ) )
        {
            killfeeddata = 0;
            killfeeddata += 4;
            killfeeddata += var_b953543d7e8d89ac << 4;
            attacker common::killfeedevent( killfeeddata, -1 );
        }
    }
}

// Namespace gwtdm
// Params 3
// Checksum 0xd46e300, Offset: 0xeb7b
// Size: 0x28d
function function_21c20150e6597b09( vehiclename, vehicleteam, attacker )
{
    if ( isdefined( attacker ) && isdefined( attacker.owner ) )
    {
        attacker = attacker.owner;
    }
    
    if ( !( isdefined( attacker ) && isdefined( attacker.team ) && isdefined( vehicleteam ) ) )
    {
        return;
    }
    
    if ( vehicleteam == "neutral" || !isenemyteam( vehicleteam, attacker.team ) )
    {
        return;
    }
    
    if ( isagent( attacker ) )
    {
        return;
    }
    
    var_b953543d7e8d89ac = 0;
    
    switch ( vehiclename )
    {
        case #"hash_44d67727616d3059":
        case #"hash_9d4e22a00fc630b5":
        case #"hash_d212f4961f28eb58":
        case #"hash_d63b8f48fb92540d":
        case #"hash_fc4bff8ee315386a":
            var_b953543d7e8d89ac = 5;
            break;
        case #"hash_41afa3eacdeba917":
        case #"hash_66c8846b85d8c948":
        case #"hash_7c54070d9b704f70":
        case #"hash_cb2498c4a1e415fd":
            var_b953543d7e8d89ac = 10;
            break;
    }
    
    if ( var_b953543d7e8d89ac > 0 )
    {
        gamescore::giveteamscoreforobjective( attacker.team, var_b953543d7e8d89ac, 0 );
        
        if ( getdvarint( @"hash_2e405e2912dc4a44", 0 ) == 1 )
        {
            attacker thread rank::scoreeventpopup( hashcat( #"hash_2c8bcbb02ec7ff9b", var_b953543d7e8d89ac ) );
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "contribution" ] ) )
            {
                attacker.leaderboarddata[ "contribution" ] = attacker.leaderboarddata[ "contribution" ] + var_b953543d7e8d89ac;
            }
            
            if ( isdefined( level.leaderboardfunc[ "contribution" ] ) )
            {
                [[ level.leaderboardfunc[ "contribution" ] ]]( attacker, var_b953543d7e8d89ac );
            }
            
            assert( isint( var_b953543d7e8d89ac ) || isfloat( var_b953543d7e8d89ac ), "<dev string:x75>" );
            
            if ( isdefined( attacker.pers[ "contribution" ] ) )
            {
                attacker.pers[ "contribution" ] = attacker.pers[ "contribution" ] + var_b953543d7e8d89ac;
            }
        }
        
        attacker stats::setextrascore0( attacker.pers[ "contribution" ], "contribution" );
        
        if ( isplayer( attacker ) )
        {
            killfeeddata = 0;
            killfeeddata += 4;
            killfeeddata += var_b953543d7e8d89ac << 4;
            attacker common::killfeedevent( killfeeddata, -1 );
        }
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x9a61e507, Offset: 0xee10
// Size: 0x225
function function_3097b40a9007d703()
{
    level endon( #"game_ended" );
    percent_25 = level.scorelimit * 0.25;
    percent_50 = level.scorelimit * 0.5;
    percent_75 = level.scorelimit * 0.75;
    percent_90 = level.scorelimit * 0.9;
    past25 = 0;
    past50 = 0;
    past75 = 0;
    past90 = 0;
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        axisscore = gamescore::getteamscore( "axis" );
        alliesscore = gamescore::getteamscore( "allies" );
        winningteam = axisscore > alliesscore ? "axis" : "allies";
        losingteam = team_utility::getotherteam( winningteam );
        
        if ( !past25 && ( axisscore >= percent_25 || alliesscore >= percent_25 ) )
        {
            past25 = 1;
            level thread function_b2e8ac9569474e99();
            dialog::statusdialog( "score_25_winning", winningteam, 1 );
            dialog::statusdialog( "score_25_losing", losingteam, 1 );
        }
        
        if ( !past50 && ( axisscore >= percent_50 || alliesscore >= percent_50 ) )
        {
            past50 = 1;
            level thread killstreakcrateloop();
            dialog::statusdialog( "score_50_winning", winningteam, 1 );
            dialog::statusdialog( "score_50_losing", losingteam, 1 );
            level thread function_cf329eb2df77ca11( 6 );
        }
        
        if ( !past75 && ( axisscore >= percent_75 || alliesscore >= percent_75 ) )
        {
            past75 = 1;
            level thread function_efc8b591573148fc();
            dialog::statusdialog( "score_75_winning", winningteam, 1 );
            dialog::statusdialog( "score_75_losing", losingteam, 1 );
        }
        
        if ( !past90 && ( axisscore >= percent_90 || alliesscore >= percent_90 ) )
        {
            past90 = 1;
            dialog::statusdialog( "score_90_winning", winningteam, 1 );
            dialog::statusdialog( "score_90_losing", losingteam, 1 );
        }
        
        wait 1;
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x118e839, Offset: 0xf03d
// Size: 0x468
function function_b2e8ac9569474e99()
{
    level.var_e842068db84b5d09 = [];
    level.var_e0c7ae2e42f7d604 = [];
    var_4103c35b0cfea4e1 = [];
    
    foreach ( team in level.teamnamelist )
    {
        level.var_e842068db84b5d09[ team ] = 0;
        level.var_e0c7ae2e42f7d604[ team ] = 0;
        var_4103c35b0cfea4e1[ team ] = 0;
    }
    
    utility::registersharedfunc( %"hash_406987d5bb9cf080", #"ondeathrespawn", &function_857ea22c8616d258 );
    vehiclecount = getdvarint( @"hash_bda20dac0244506b", 2 );
    respawninterval = int( getdvarfloat( @"hash_6ff4efb459d8b415", 30 ) * 1000 );
    
    foreach ( team in level.teamnamelist )
    {
        dialog::statusdialog( "vehicles_inc", team, 1 );
        hud_util::showsplashtoteam( team, "gwtdm_vehicles_inc" );
    }
    
    wait 5;
    
    while ( true )
    {
        currenttime = gettime();
        
        foreach ( team in level.teamnamelist )
        {
            if ( level.var_e842068db84b5d09[ team ] < vehiclecount )
            {
                if ( var_4103c35b0cfea4e1[ team ] && currenttime < level.var_e0c7ae2e42f7d604[ team ] + respawninterval )
                {
                    continue;
                }
                
                randfrac = randomfloatrange( 0, 1 );
                randomorigin = vectorlerp( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].minpoint, level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].maxpoint, randfrac );
                originhq = level.gw_objstruct.allieshqloc.trigger.origin;
                
                if ( team == "axis" )
                {
                    originhq = level.gw_objstruct.axishqloc.trigger.origin;
                }
                
                offsetdist = getdvarint( @"hash_345e75bc0b7aba35", 3000 );
                offsetdir = vectornormalize( randomorigin - originhq );
                offset = offsetdir * offsetdist;
                randomorigin -= offset;
                trace = trace::ray_trace( randomorigin, randomorigin - ( 0, 0, 100000 ) );
                randomorigin = trace[ "position" ];
                droplocation = findclosestdroplocation( randomorigin, 1 );
                
                if ( !isdefined( droplocation ) )
                {
                    continue;
                }
                
                spawndata = spawnstruct();
                spawndata.origin = droplocation.origin + ( 0, 0, 100 );
                spawndata.angles = droplocation.angles;
                spawndata.spawntype = "GAME_MODE";
                spawndata.gwtdmteam = team;
                vehicle = vehicle_airdrop::vehicle_airdrop( %"hash_406987d5bb9cf080", spawndata );
                
                if ( isdefined( vehicle ) )
                {
                    level.var_e842068db84b5d09[ team ]++;
                    
                    if ( !var_4103c35b0cfea4e1[ team ] && level.var_e842068db84b5d09[ team ] == vehiclecount )
                    {
                        var_4103c35b0cfea4e1[ team ] = 1;
                    }
                    
                    level.var_e0c7ae2e42f7d604[ team ] = currenttime;
                    vehicle thread cleanupdroplocation( droplocation );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xf6a52a5, Offset: 0xf4ad
// Size: 0x48e
function function_efc8b591573148fc()
{
    level.var_171d416a37f1c172 = [];
    level.var_d8aca191198f4727 = [];
    var_4103c35b0cfea4e1 = [];
    
    foreach ( team in level.teamnamelist )
    {
        level.var_171d416a37f1c172[ team ] = 0;
        level.var_d8aca191198f4727[ team ] = 0;
        var_4103c35b0cfea4e1[ team ] = 0;
    }
    
    vehiclecount = getdvarint( @"hash_d3a11571b804dcd2", 2 );
    respawninterval = int( getdvarfloat( @"hash_bcca4bdb0041285a", 60 ) * 1000 );
    
    foreach ( team in level.teamnamelist )
    {
        dialog::statusdialog( "vehicles2_inc", team, 1 );
        hud_util::showsplashtoteam( team, "gwtdm_vehicles2_inc" );
    }
    
    wait 5;
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"ondeathrespawn", &function_60043bcc799433d );
    
    while ( true )
    {
        currenttime = gettime();
        
        foreach ( team in level.teamnamelist )
        {
            if ( level.var_171d416a37f1c172[ team ] < vehiclecount )
            {
                if ( var_4103c35b0cfea4e1[ team ] && currenttime < level.var_d8aca191198f4727[ team ] + respawninterval )
                {
                    continue;
                }
                
                randfrac = randomfloatrange( 0, 1 );
                randomorigin = vectorlerp( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].minpoint, level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].maxpoint, randfrac );
                originhq = level.gw_objstruct.allieshqloc.trigger.origin;
                
                if ( team == "axis" )
                {
                    originhq = level.gw_objstruct.axishqloc.trigger.origin;
                }
                
                offsetdist = getdvarint( @"hash_345e75bc0b7aba35", 3000 );
                offsetdir = vectornormalize( randomorigin - originhq );
                offset = offsetdir * offsetdist;
                randomorigin -= offset;
                trace = trace::ray_trace( randomorigin, randomorigin - ( 0, 0, 100000 ) );
                randomorigin = trace[ "position" ];
                droplocation = findclosestdroplocation( randomorigin, 1 );
                
                if ( !isdefined( droplocation ) )
                {
                    continue;
                }
                
                spawndata = spawnstruct();
                spawndata.origin = droplocation.origin + ( 0, 0, 100 );
                spawndata.angles = droplocation.angles;
                spawndata.spawntype = "GAME_MODE";
                spawndata.spawnmethod = "airdrop_at_position_unsafe";
                spawndata.gwtdmteam = team;
                faildata = spawnstruct();
                vehicle = vehicle::spawn( %"vehiclebundle:light_tank_mp", spawndata, faildata );
                
                if ( isdefined( vehicle ) )
                {
                    level.var_171d416a37f1c172[ team ]++;
                    
                    if ( !var_4103c35b0cfea4e1[ team ] && level.var_171d416a37f1c172[ team ] == vehiclecount )
                    {
                        var_4103c35b0cfea4e1[ team ] = 1;
                    }
                    
                    level.var_d8aca191198f4727[ team ] = currenttime;
                    vehicle thread cleanupdroplocation( droplocation );
                    wait 5;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xcea9e1bb, Offset: 0xf943
// Size: 0x46
function function_857ea22c8616d258()
{
    spawndata = vehicle_tracking::get_spawn_data();
    
    if ( isdefined( spawndata.basevehiclespawndata ) )
    {
        spawndata = spawndata.basevehiclespawndata;
    }
    
    level.var_e842068db84b5d09[ spawndata.gwtdmteam ]--;
}

// Namespace gwtdm
// Params 0
// Checksum 0xe80ff404, Offset: 0xf991
// Size: 0x46
function function_60043bcc799433d()
{
    spawndata = vehicle_tracking::get_spawn_data();
    
    if ( isdefined( spawndata.basevehiclespawndata ) )
    {
        spawndata = spawndata.basevehiclespawndata;
    }
    
    level.var_171d416a37f1c172[ spawndata.gwtdmteam ]--;
}

// Namespace gwtdm
// Params 1
// Checksum 0x97e3a4fa, Offset: 0xf9df
// Size: 0x71
function cleanupdroplocation( droplocation )
{
    self waittill( #"landed" );
    var_5896b8fdcff1a59f = 262144;
    
    while ( isdefined( self ) )
    {
        distsq = distancesquared( self.origin, droplocation.origin );
        
        if ( distsq > var_5896b8fdcff1a59f )
        {
            break;
        }
        
        wait 1;
    }
    
    droplocation.inuse = 0;
}

// Namespace gwtdm
// Params 4
// Checksum 0x33fafc5b, Offset: 0xfa58
// Size: 0x11e
function function_c4a36fc37329730e( numagents, reinforceorigin, team, delaymax )
{
    heading = undefined;
    
    if ( team == "allies" )
    {
        heading = vectortoangles( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].maxpoint - level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].minpoint );
    }
    else
    {
        heading = vectortoangles( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].minpoint - level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].maxpoint );
    }
    
    wait randomfloat( delaymax );
    agents = level [[ utility::getsharedfunc( #"hash_3b1120debc62f8b", #"requestReinforcements" ) ]]( numagents, reinforceorigin, undefined, undefined, "medium", "spawnHQ_" + team, "debug", team, undefined, undefined, heading, &function_334acb395604074a, undefined, 1, level.agenttier );
}

// Namespace gwtdm
// Params 3
// Checksum 0x354b0d46, Offset: 0xfb7e
// Size: 0xe8
function function_effbca31a07902a4( numagents, frontlinekey, team )
{
    reinforceorigin = level.frontlinedata[ frontlinekey ].origin;
    originhq = level.gw_objstruct.allieshqloc.trigger.origin;
    
    if ( team == "axis" )
    {
        originhq = level.gw_objstruct.axishqloc.trigger.origin;
    }
    
    offsetdist = getdvarint( @"hash_7456a259db14a9a2", 3000 );
    offset = vectornormalize( reinforceorigin - originhq ) * offsetdist;
    reinforceorigin -= offset;
    level thread function_c4a36fc37329730e( numagents, reinforceorigin, team, 4 );
}

// Namespace gwtdm
// Params 0
// Checksum 0x66e786d2, Offset: 0xfc6e
// Size: 0x38
function ac130_matchstart()
{
    function_effbca31a07902a4( 14, level.var_f9f9bdd4e4094d63, "axis" );
    function_effbca31a07902a4( 14, level.var_f9f9bdd4e4094d63, "allies" );
    level thread function_5f158bddfe789f90();
}

// Namespace gwtdm
// Params 0
// Checksum 0x3ac7da9d, Offset: 0xfcae
// Size: 0x1ca
function function_5f158bddfe789f90()
{
    level endon( #"game_ended" );
    percent_25 = level.scorelimit * 0.25;
    percent_50 = level.scorelimit * 0.5;
    percent_80 = level.scorelimit * 0.8;
    var_e82019ced10f4d01 = 0;
    var_2787921d2bd8355 = 0;
    var_d02c1e77dda8be84 = 0;
    var_bd91ad4053944866 = 0;
    var_f602d6bb30765602 = 0;
    var_4da221a97c0c2e2f = 0;
    
    while ( true )
    {
        axisscore = gamescore::getteamscore( "axis" );
        alliesscore = gamescore::getteamscore( "allies" );
        
        if ( axisscore >= percent_25 && !var_e82019ced10f4d01 )
        {
            function_effbca31a07902a4( 5, level.var_f9f9bdd4e4094d63, "axis" );
            var_e82019ced10f4d01 = 1;
        }
        else if ( axisscore > percent_50 && !var_2787921d2bd8355 )
        {
            var_2787921d2bd8355 = 1;
        }
        else if ( axisscore > percent_80 && !var_d02c1e77dda8be84 )
        {
            function_effbca31a07902a4( 9, level.var_f9f9bdd4e4094d63, "axis" );
            var_d02c1e77dda8be84 = 1;
        }
        
        if ( alliesscore >= percent_25 && !var_bd91ad4053944866 )
        {
            function_effbca31a07902a4( 5, level.var_f9f9bdd4e4094d63, "allies" );
            var_bd91ad4053944866 = 1;
        }
        else if ( alliesscore > percent_50 && !var_f602d6bb30765602 )
        {
            var_f602d6bb30765602 = 1;
        }
        else if ( alliesscore > percent_80 && !var_4da221a97c0c2e2f )
        {
            function_effbca31a07902a4( 9, level.var_f9f9bdd4e4094d63, "allies" );
            var_4da221a97c0c2e2f = 1;
        }
        
        if ( var_e82019ced10f4d01 && var_2787921d2bd8355 && var_d02c1e77dda8be84 && var_bd91ad4053944866 && var_f602d6bb30765602 && var_4da221a97c0c2e2f )
        {
            return;
        }
        
        wait 1;
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x1c2c7c8f, Offset: 0xfe80
// Size: 0xa2
function function_4825c3ae120a715c()
{
    self endon( #"game_ended" );
    
    while ( true )
    {
        if ( getdvarint( @"scr_give_score_allies" ) != 0 )
        {
            gamescore::giveteamscoreforobjective( "allies", getdvarint( @"scr_give_score_allies" ), 0 );
            break;
        }
        else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
        {
            gamescore::giveteamscoreforobjective( "axis", getdvarint( @"scr_give_score_axis" ), 0 );
            break;
        }
        
        wait 1;
    }
    
    /#
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
    #/
    
    thread function_4825c3ae120a715c();
}

// Namespace gwtdm
// Params 5
// Checksum 0x1f4821d1, Offset: 0xff2a
// Size: 0x161
function function_7f8fe4f187f715f4( agent, team, frontlineindex, lanekey, var_922c962b84963468 )
{
    if ( !isalive( agent ) )
    {
        return;
    }
    
    lanedata = level.frontlinedata[ frontlineindex ].lanedata[ lanekey ];
    
    if ( isdefined( lanedata.frontvolume ) && isdefined( lanedata.backvolume ) && lanedata.frontvolume.size > 0 && lanedata.backvolume.size > 0 )
    {
        if ( agent.frontagent )
        {
            volume = lanedata.frontvolume[ team_utility::getotherteam( team ) ];
        }
        else
        {
            volume = lanedata.backvolume[ team ];
        }
    }
    else
    {
        volume = level.frontlinedata[ frontlineindex ].lanedata[ lanekey ].coverzones[ team ][ 0 ].goalvolume;
    }
    
    if ( isdefined( volume ) )
    {
        agent cleargoalvolume();
        agent setgoalvolumeauto( volume, volume.heading );
        agent.var_79845720de15eab6 = volume;
        
        if ( !var_922c962b84963468 )
        {
            level thread ai_behavior::ai_watchforbadpath( agent );
            agent thread function_552126a0f1af01b2( agent );
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace gwtdm
// Params 0
// Checksum 0x758f81d1, Offset: 0x10094
// Size: 0x17d
function function_eef6ed990b709dfc()
{
    level endon( #"game_ended" );
    level.var_e70f52c1ba69ab22 = [];
    level.var_e70f52c1ba69ab22[ "axis" ] = [];
    level.var_e70f52c1ba69ab22[ "allies" ] = [];
    level.huntedplayers = [];
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    utility::flag_wait( "frontline_data_init" );
    gamelogic_mp::waitforplayers( level.prematchperiod, 0, 0 );
    level thread function_4930e9b7c0c530df( "axis" );
    level thread function_4930e9b7c0c530df( "allies" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            playerentnum = player getentitynumber();
            
            if ( isdefined( level.var_e70f52c1ba69ab22[ player.team ][ playerentnum ] ) )
            {
                continue;
            }
            
            if ( !isdefined( level.huntedplayers[ playerentnum ] ) && function_5f835a834afcac18( player ) )
            {
                level.var_e70f52c1ba69ab22[ player.team ][ playerentnum ] = player;
            }
        }
        
        wait 1;
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0x88eb7989, Offset: 0x10219
// Size: 0x242
function function_4930e9b7c0c530df( team )
{
    level endon( #"game_ended" );
    enemyteam = team_utility::getotherteam( team );
    
    while ( true )
    {
        foreach ( key, player in level.var_e70f52c1ba69ab22[ team ] )
        {
            if ( !isalive( player ) )
            {
                level.var_e70f52c1ba69ab22[ team ][ key ] = undefined;
                continue;
            }
            
            agents = entity::function_cd55d7a649cb9c44( player.origin, 5000, enemyteam );
            agents = sortbydistance( agents, player.origin );
            chosenagents = [];
            
            foreach ( agent in agents )
            {
                if ( isplayer( agent ) )
                {
                    continue;
                }
                
                if ( chosenagents.size >= 5 )
                {
                    break;
                }
                
                if ( agent.var_68a58465ed3f2958 || isint( agent.vehicle_position ) )
                {
                    continue;
                }
                
                chosenagents[ chosenagents.size ] = agent;
            }
            
            if ( chosenagents.size > 0 )
            {
                level.var_e70f52c1ba69ab22[ player.team ][ key ] = undefined;
                level.huntedplayers[ key ] = player;
                
                foreach ( agent in chosenagents )
                {
                    function_2ce5aebc745dc4d( player, agent );
                }
            }
        }
        
        wait 5;
    }
}

// Namespace gwtdm
// Params 2
// Checksum 0x667604d2, Offset: 0x10463
// Size: 0xa5
function function_2ce5aebc745dc4d( player, agent )
{
    agent cleargoalvolume();
    agent function_4925679368869b06( player, 40 );
    agent.var_68a58465ed3f2958 = 1;
    agent thread ai_behavior::function_ec43a817c7bf1915( agent, player.origin, 8, 8, undefined, 1, undefined, 0, &function_f50c7ae21ea56be6, player );
    agent.previousbaseaccuracy = agent.baseaccuracy;
    agent.baseaccuracy += getdvarfloat( @"hash_67a1af3428021a00", 0.5 );
    agent thread function_193b8b6d8dadd563( agent, player );
}

// Namespace gwtdm
// Params 2
// Checksum 0x4bf4d8c, Offset: 0x10510
// Size: 0x48
function function_f50c7ae21ea56be6( agent, targetent )
{
    if ( agent.var_68a58465ed3f2958 )
    {
        agent thread ai_behavior::function_ec43a817c7bf1915( agent, targetent.origin, 8, 8, undefined, 1, undefined, 0, &function_f50c7ae21ea56be6, targetent );
    }
}

// Namespace gwtdm
// Params 2
// Checksum 0x33abc178, Offset: 0x10560
// Size: 0xa3
function function_193b8b6d8dadd563( agent, player )
{
    agent notify( #"hash_8b1be56ed42fd312" );
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent endon( #"hash_8b1be56ed42fd312" );
    playerentnum = player getentitynumber();
    player utility::waittill_notify_or_timeout( "death", 20 );
    level.huntedplayers[ playerentnum ] = undefined;
    agent.var_68a58465ed3f2958 = 0;
    agent.baseaccuracy = agent.previousbaseaccuracy;
    function_870b176bbe92e79a( agent );
}

// Namespace gwtdm
// Params 1
// Checksum 0xfd3426c1, Offset: 0x1060b
// Size: 0x75, Type: bool
function function_47c41c63340fff97( player )
{
    frontlineorigin = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].origin;
    toorigin = vectornormalize( frontlineorigin - player.origin );
    
    if ( vectordot( level.spawnselectionteamforward[ player.team ], toorigin ) < 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace gwtdm
// Params 1
// Checksum 0x44434012, Offset: 0x10689
// Size: 0x11c, Type: bool
function function_5f835a834afcac18( player )
{
    lanedata = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ 1 ];
    
    if ( !isdefined( lanedata.backvolume ) || lanedata.backvolume.size <= 0 )
    {
        var_8b7a2a80dc4a522d = level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ 1 ].coverzones[ player.team ][ 0 ].goalvolume.origin;
    }
    else
    {
        var_8b7a2a80dc4a522d = lanedata.backvolume[ team_utility::getotherteam( player.team ) ].origin;
    }
    
    toorigin = vectornormalize( var_8b7a2a80dc4a522d - player.origin );
    
    if ( vectordot( level.spawnselectionteamforward[ player.team ], toorigin ) < 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace gwtdm
// Params 0
// Checksum 0xa9bde263, Offset: 0x107ae
// Size: 0x281
function function_f13f83dce9df6ac()
{
    ai_mp_controller::function_7f833bacb64445a6();
    
    while ( true )
    {
        axiscount = 0;
        alliescount = 0;
        
        foreach ( agent in level.agentarray )
        {
            if ( isalive( agent ) )
            {
                color = ( 0, 1, 0 );
                
                if ( agent.team == "axis" )
                {
                    color = ( 1, 0, 0 );
                    axiscount++;
                }
                else
                {
                    alliescount++;
                }
                
                thread debug::drawsphere( agent.origin, 32, 0.05, color );
                
                if ( agent.var_68a58465ed3f2958 )
                {
                    thread debug::drawsphere( agent.origin, 42, 0.05, ( 1, 0, 1 ) );
                }
                
                if ( agent.frontagent )
                {
                    thread debug::drawsphere( agent.origin, 52, 0.05, ( 1, 1, 1 ) );
                }
            }
        }
        
        /#
            printtoscreen2d( 300, 50, "<dev string:x27f>" + axiscount, ( 0, 0, 1 ), 2.5, 1 );
            printtoscreen2d( 300, 100, "<dev string:x28c>" + alliescount, ( 0, 0, 1 ), 2.5, 1 );
            line( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ 0 ].origin, level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ 1 ].origin, ( 0, 1, 0 ) );
            line( level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ 1 ].origin, level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata[ 2 ].origin, ( 0, 1, 0 ) );
        #/
        
        waitframe();
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x906ad978, Offset: 0x10a37
// Size: 0x11b
function function_86d33777378071d9()
{
    self endon( #"game_ended" );
    ai_mp_controller::function_7f833bacb64445a6();
    
    while ( true )
    {
        foreach ( agent in level.agentarray )
        {
            if ( isalive( agent ) && !agent.var_68a58465ed3f2958 )
            {
                if ( isint( agent.vehicle_position ) )
                {
                    continue;
                }
                
                if ( isdefined( agent.landing_spot ) )
                {
                    continue;
                }
                
                lanekey = agent.lanekey;
                
                if ( isdefined( lanekey ) )
                {
                    if ( agent.var_cd4355a515279871 )
                    {
                        continue;
                    }
                    
                    function_7f8fe4f187f715f4( agent, agent.team, level.var_f9f9bdd4e4094d63, lanekey );
                }
            }
        }
        
        wait 5;
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0xa4e66272, Offset: 0x10b5a
// Size: 0x221
function function_c60ac6c44b0f37dd( team )
{
    self endon( #"game_ended" );
    level notify( "resetAgentVolumeMovementThink" + team );
    level endon( "resetAgentVolumeMovementThink" + team );
    ai_mp_controller::function_7f833bacb64445a6();
    utility::flag_wait( "frontline_data_init" );
    wait 5;
    
    while ( true )
    {
        agentpicked = 0;
        level.backagents[ team ] = arrayrandomize( level.backagents[ team ] );
        
        foreach ( index, agent in level.backagents[ team ] )
        {
            if ( isalive( agent ) && !isdefined( agent.vehicle ) && ( agent.var_cd4355a515279871 || !function_9225d9a1d064afce( agent ) ) )
            {
                function_c6043d04012724b2( agent, team, index );
                agentpicked = 1;
                break;
            }
        }
        
        if ( !agentpicked )
        {
            foreach ( index, agent in level.backagents[ team ] )
            {
                if ( isalive( agent ) && !isdefined( agent.vehicle ) && !function_9225d9a1d064afce( agent ) )
                {
                    level.backagents[ team ][ index ] = undefined;
                    level.frontagents[ team ][ level.frontagents[ team ].size ] = agent;
                    agent.frontagent = 1;
                    agent playsoundtoteam( "mp_walla_invasion_charge_individual", agent.team );
                    function_870b176bbe92e79a( agent );
                    break;
                }
            }
        }
        
        wait randomfloatrange( 4, 7 );
    }
}

// Namespace gwtdm
// Params 3
// Checksum 0xf96342ad, Offset: 0x10d83
// Size: 0xaa
function function_c6043d04012724b2( agent, team, var_88d8dacc25229236 )
{
    agent.var_cd4355a515279871 = 0;
    
    if ( isdefined( var_88d8dacc25229236 ) )
    {
        level.backagents[ team ][ var_88d8dacc25229236 ] = undefined;
    }
    else
    {
        level.backagents[ team ] = arrayremove( level.backagents[ team ], agent );
    }
    
    level.frontagents[ team ][ level.frontagents[ team ].size ] = agent;
    agent.frontagent = 1;
    agent playsoundtoteam( "mp_walla_invasion_charge_individual", agent.team );
    function_870b176bbe92e79a( agent );
}

// Namespace gwtdm
// Params 1
// Checksum 0x48983339, Offset: 0x10e35
// Size: 0x5b
function function_9225d9a1d064afce( agent )
{
    if ( !isalive( agent ) || !isdefined( agent.agent_type ) )
    {
        return;
    }
    
    if ( issubstr( agent.agent_type, "rpg" ) || issubstr( agent.agent_type, "sniper" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace gwtdm
// Params 0
// Checksum 0xf85c3500, Offset: 0x10e99
// Size: 0x306
function function_d5b381155557128c()
{
    level.introscene = [];
    level.introscene[ "axis" ] = [];
    level.introscene[ "allies" ] = [];
    nodesaxis = utility::getstructarray( "intro_scene_axis", "script_noteworthy" );
    
    foreach ( intronode in nodesaxis )
    {
        spawnerlocs = utility::getstructarray( intronode.target, "targetname" );
        
        foreach ( loc in spawnerlocs )
        {
            script_noteworthy = tolower( loc.script_noteworthy );
            
            if ( isdefined( script_noteworthy ) && !isdefined( level.introscene[ "axis" ][ script_noteworthy ] ) )
            {
                level.introscene[ "axis" ][ script_noteworthy ] = [];
            }
            
            level.introscene[ "axis" ][ script_noteworthy ][ level.introscene[ "axis" ][ script_noteworthy ].size ] = loc;
        }
    }
    
    nodesallies = utility::getstructarray( "intro_scene_allies", "script_noteworthy" );
    
    foreach ( intronode in nodesallies )
    {
        spawnerlocs = utility::getstructarray( intronode.target, "targetname" );
        
        foreach ( loc in spawnerlocs )
        {
            script_noteworthy = tolower( loc.script_noteworthy );
            
            if ( isdefined( script_noteworthy ) && !isdefined( level.introscene[ "allies" ][ script_noteworthy ] ) )
            {
                level.introscene[ "allies" ][ script_noteworthy ] = [];
            }
            
            level.introscene[ "allies" ][ script_noteworthy ][ level.introscene[ "allies" ][ script_noteworthy ].size ] = loc;
        }
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0xd740eebe, Offset: 0x111a7
// Size: 0x34a
function function_3ef533c52fe65d13()
{
    ai_mp_controller::function_7f833bacb64445a6();
    waitframe();
    
    foreach ( posename, posearray in level.introscene[ "axis" ] )
    {
        foreach ( poseloc in posearray )
        {
            [ capname, rotationoffset, delayoffsettime ] = function_f787eebcfe2c7766( posename );
            budgetname = "spawnHQ_axis";
            aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, "guard", undefined, level.agenttier, level.teamnationality[ "axis" ] );
            origin = getclosestpointonnavmesh( poseloc.origin );
            agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, poseloc.angles + rotationoffset, "medium", budgetname, undefined, undefined, "axis", undefined, undefined, 1 );
            
            if ( isalive( agent ) )
            {
                agent thread function_bce1d8e38d91cca( agent, capname, "intro_cap_complete", delayoffsettime );
                agent thread function_3e1f747510578143( agent );
            }
        }
    }
    
    foreach ( posename, posearray in level.introscene[ "allies" ] )
    {
        foreach ( poseloc in posearray )
        {
            [ capname, rotationoffset, delayoffsettime ] = function_f787eebcfe2c7766( posename );
            budgetname = "spawnHQ_allies";
            aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, "guard", undefined, level.agenttier, level.teamnationality[ "allies" ] );
            origin = getclosestpointonnavmesh( poseloc.origin );
            agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, poseloc.angles + rotationoffset, "medium", budgetname, undefined, undefined, "allies", undefined, undefined, 1 );
            
            if ( isalive( agent ) )
            {
                agent thread function_bce1d8e38d91cca( agent, capname, "intro_cap_complete", delayoffsettime );
                agent thread function_3e1f747510578143( agent );
            }
        }
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0x83f85016, Offset: 0x114f9
// Size: 0x120
function function_f787eebcfe2c7766( posename )
{
    capname = undefined;
    rotationoffset = ( 0, 0, 0 );
    delayoffsettime = 6 + randomfloatrange( -0.75, 0.75 );
    
    switch ( posename )
    {
        case #"hash_d8c4e5876be97da":
            capname = "rebel_peptalk_01";
            break;
        case #"hash_d8c4d5876be9647":
            capname = "rebel_peptalk_01";
            break;
        case #"hash_d8c4c5876be94b4":
            capname = "rebel_peptalk_01";
            break;
        case #"hash_d8c4b5876be9321":
            capname = "rebel_peptalk_04";
            break;
        case #"hash_4059cfe6b7ea61be":
            capname = "rebel_stand_05";
            rotationoffset = ( 0, -90, 0 );
            break;
        case #"hash_4059cee6b7ea602b":
            capname = "rebel_stand_02";
            rotationoffset = ( 0, -90, 0 );
            break;
        case #"hash_3476ad55eb745a44":
            capname = "rebel_peptalk_leader";
            break;
    }
    
    return [ capname, rotationoffset, delayoffsettime ];
}

// Namespace gwtdm
// Params 4
// Checksum 0x53bf9994, Offset: 0x11622
// Size: 0xea
function function_bce1d8e38d91cca( agent, capname = "rebel_peptalk_01", var_27e0ebcde5dd152c, delayoffsettime )
{
    waitframe();
    agent thread cap::cap_start( "cap_single", capname );
    waittime = 3;
    
    if ( level.prematchperiodend > 0 )
    {
        level waittill( #"match_start_real_countdown" );
        waittime = level.prematchperiodend - delayoffsettime;
        waittime = 0 < waittime ? waittime : 0;
    }
    
    wait waittime;
    agent.exitcap = 1;
    remainingtime = 7;
    randomtime = randomfloatrange( 4, 6 );
    wait randomtime;
    playsoundatpos( agent.origin, "mp_walla_invasion_charge_individual" );
    wait remainingtime - randomtime;
    agent cap::cap_exit();
    agent notify( var_27e0ebcde5dd152c );
}

// Namespace gwtdm
// Params 1
// Checksum 0x5aef8d1a, Offset: 0x11714
// Size: 0xdb
function function_3e1f747510578143( agent )
{
    if ( agent.team == "allies" )
    {
        artpair = level.var_26c64a818e8ea257[ agent.team ][ randomint( level.var_26c64a818e8ea257[ agent.team ].size ) ];
        agent agent_utils::overrideagentsettings( artpair.body, artpair.head );
        agent.bodyoverridden = 1;
    }
    
    agent waittill( #"intro_cap_complete" );
    lanekey = function_4a05ac53c86e495a( agent.origin );
    function_7f8fe4f187f715f4( agent, agent.team, level.var_f9f9bdd4e4094d63, lanekey );
    overrideagent( agent, lanekey );
}

// Namespace gwtdm
// Params 0
// Checksum 0x66fdde2b, Offset: 0x117f7
// Size: 0x3f1
function function_6f56cc5d59b4bc0()
{
    while ( !level.var_aeb6f04033bb30b0 )
    {
        waitframe();
    }
    
    foreach ( team in level.teamnamelist )
    {
        frontlineorigin = ( 0, 0, 0 );
        
        foreach ( lanedata in level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata )
        {
            frontlineorigin += lanedata.origin;
        }
        
        frontlineorigin /= level.frontlinedata[ level.var_f9f9bdd4e4094d63 ].lanedata.size;
        
        if ( team == "allies" )
        {
            forward = level.spawnselectionteamforward[ "allies" ] * -1;
        }
        else
        {
            forward = level.spawnselectionteamforward[ "axis" ] * -1;
        }
        
        offsetdist = getdvarint( @"hash_25e538731b72b1b4", 10000 );
        height = getdvarint( @"hash_b78ef73b0670b310", 2000 );
        camerapos = frontlineorigin + forward * offsetdist;
        trace = trace::ray_trace( camerapos + ( 0, 0, 10000 ), camerapos - ( 0, 0, 20000 ) );
        
        if ( trace[ "hittype" ] == "hittype_none" )
        {
            camerapos = ( camerapos[ 0 ], camerapos[ 1 ], spawncamera::getstartspawnavg( team )[ 2 ] ) + ( 0, 0, height );
        }
        else if ( trace[ "position" ][ 2 ] < spawncamera::getstartspawnavg( team )[ 2 ] )
        {
            camerapos = ( camerapos[ 0 ], camerapos[ 1 ], spawncamera::getstartspawnavg( team )[ 2 ] ) + ( 0, 0, height );
        }
        else
        {
            camerapos = trace[ "position" ] + ( 0, 0, height );
        }
        
        toground = vectornormalize( frontlineorigin - camerapos );
        cameraang = script::vectortoanglessafe( toground, ( 0, 0, 1 ) );
        level.spawncameras[ "default" ][ team ].origin = camerapos;
        level.spawncameras[ "default" ][ team ].angles = cameraang;
        var_445783959e00252 = getdvarint( @"hash_a66b78681b2d0805", 4096 );
        hintpos = frontlineorigin + forward * var_445783959e00252;
        hintpos = utility::drop_to_ground( hintpos );
        level.spawncameras[ "default" ][ team ].prestreamorigin = hintpos;
        
        if ( getdvarint( @"hash_13fae9c305971d06", 0 ) == 1 )
        {
            color = ( 1, 0, 0 );
            
            if ( team == "allies" )
            {
                color = ( 0, 0, 1 );
            }
            
            thread debug::drawline( camerapos + ( 0, 0, 10000 ), camerapos - ( 0, 0, 20000 ), 60, ( 1, 1, 0 ) );
            thread debug::drawsphere( camerapos, 100, 60, color );
            thread debug::drawline( camerapos, frontlineorigin, 60, color );
            thread debug::drawline( camerapos, hintpos, 60, ( 0, 1, 0 ) );
        }
    }
}

// Namespace gwtdm
// Params 1
// Checksum 0xbe4f543c, Offset: 0x11bf0
// Size: 0xde
function function_cf329eb2df77ca11( splashdelay )
{
    level.agenttier = 2;
    
    if ( !isdefined( splashdelay ) )
    {
        splashdelay = 0;
    }
    
    wait splashdelay;
    
    foreach ( team in level.teamnamelist )
    {
        dialog::statusdialog( "tier2_friendly", team, 1 );
        hud_util::showsplashtoteam( team, "gwtdm_tier2_agents_inc" );
    }
    
    function_effbca31a07902a4( 7, level.var_f9f9bdd4e4094d63, "axis" );
    function_effbca31a07902a4( 7, level.var_f9f9bdd4e4094d63, "allies" );
}

// Namespace gwtdm
// Params 1
// Checksum 0xf1f82560, Offset: 0x11cd6
// Size: 0xb0
function function_cf329db2df77c7de( splashdelay )
{
    level.agenttier = 3;
    
    if ( !isdefined( splashdelay ) )
    {
        splashdelay = 0;
    }
    
    wait splashdelay;
    
    foreach ( team in level.teamnamelist )
    {
        dialog::statusdialog( "tier3_friendly", team, 1 );
        hud_util::showsplashtoteam( team, "gwtdm_tier3_agents_inc" );
    }
}

// Namespace gwtdm
// Params 0
// Checksum 0x9afa26e9, Offset: 0x11d8e
// Size: 0x43, Type: bool
function onplayerconnectstream()
{
    if ( !isdefined( self.sessionteam ) || self.sessionteam == "spectator" || self.sessionteam == "none" || self isplayerheadless() )
    {
        return false;
    }
    
    return true;
}

