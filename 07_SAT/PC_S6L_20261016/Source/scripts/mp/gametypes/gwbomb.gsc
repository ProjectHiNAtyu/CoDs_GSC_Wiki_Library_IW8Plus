// scripts\mp\gametypes\gwbomb.gsc  (hash_7c07dabb66babf80.gscc) (size: 61083 Bytes / 0xee9b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72311e8e (1915821710)
// size ...... 61083 (0xee9b)
// includes .. 47  (offset: 0xd787)
// strings ... 331 (offset: 0xd8ff)
// dev strs .. 13  (offset: 0xedd7)
// exports ... 90  (offset: 0xa487)
// cseg ...... 0x1b96 + 0x88f1 (0xa487)
// imports ... 282 (offset: 0xb297)
// animtree1 . 0   (offset: 0xee9b)
// animtree2 . 0   (offset: 0xee9b)
#using script_2f4866552f0ba818;
#using scripts\common\game_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\cash;
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
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arm_upgrades;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\rally_point;
#using scripts\mp\rank;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
#using scripts\mp\squads;

#namespace gwbomb;

// Namespace gwbomb
// Params 0
// Checksum 0x448c0f4, Offset: 0x1bb4
// Size: 0xda4
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
    setdvar( @"hash_405e7e20d91344cc", 0 );
    setdvar( @"scr_allow_technicals", 1 );
    setdvar( @"scr_runlean_max_technicals", 30 );
    setdvar( @"hash_e4fa721677f03de0", 1 );
    setdvar( @"cg_friendlyrevivenameplateenabled", 0 );
    setomnvar( "ui_num_dom_flags", 6 );
    updategametypedvars();
    join_team_aggregator::registeronplayerjointeamcallback( &onjoinedteam );
    level.scoreperplayer = undefined;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.onrespawndelay = &getrespawndelay;
    level.onnormaldeath = &onnormaldeath;
    level.onobjectivecomplete = &onobjectivecomplete;
    level.updatefobspawnselection = &updatefobspawnselection;
    
    /#
        level.var_c7f22dd7cb861f3 = &function_c7f22dd7cb861f3;
    #/
    
    level.domflag_setneutral = &obj_dom::domflag_setneutral;
    level.dompoint_setcaptured = &obj_dom::dompoint_setcaptured;
    level.requiredplayercountoveride = 1;
    level.requiredplayercount[ "allies" ] = 24;
    level.requiredplayercount[ "axis" ] = 24;
    level.var_5fb58f5bb9552416 = &getmissedinfilcamerapositions;
    level.var_81d027302ddd38f4 = &calculatecameraoffset;
    level.var_13d81b4887ce5b8b = &function_a40bb805b501896e;
    game[ "dialog" ][ "gametype" ] = "iw9_gwbm_mode_uktl_name";
    
    if ( getdvarint( @"scr_diehard" ) )
    {
        game[ "dialog" ][ "gametype" ] = "dh_" + game[ "dialog" ][ "gametype" ];
    }
    else if ( dvars::function_13909a5327c395b9( "promode" ) )
    {
        game[ "dialog" ][ "gametype" ] = game[ "dialog" ][ "gametype" ] + "_pro";
    }
    
    game[ "dialog" ][ "offense_obj" ] = "iw9_gwbm_mode_uktl_gbbs";
    game[ "dialog" ][ "defense_obj" ] = "iw9_gwbm_mode_uktl_gbbs";
    game[ "dialog" ][ "lead_taken" ] = "iw9_gwbm_mode_uktl_gblg";
    game[ "dialog" ][ "lead_lost" ] = "iw9_gwbm_mode_uktl_gbll";
    game[ "dialog" ][ "lead_tied" ] = "iw9_gwbm_mode_uktl_gblt";
    game[ "dialog" ][ "gwbomb_progress_defense" ] = "iw9_gwbm_mode_uktl_gbpd";
    game[ "dialog" ][ "gwbomb_progress_offense" ] = "iw9_gwbm_mode_uktl_gbpa";
    game[ "dialog" ][ "gwbomb_last_site_defense" ] = "iw9_gwbm_mode_uktl_gbld";
    game[ "dialog" ][ "gwbomb_last_site_offense" ] = "iw9_gwbm_mode_uktl_gblo";
    game[ "dialog" ][ "bomb_planting_a" ] = "iw9_gwbm_mode_uktl_gbxa";
    game[ "dialog" ][ "bomb_planted_a" ] = "iw9_gwbm_mode_uktl_gpoa";
    game[ "dialog" ][ "enemy_bomb_a" ] = "iw9_gwbm_mode_uktl_gpda";
    game[ "dialog" ][ "bomb_defused_a" ] = "iw9_gwbm_mode_uktl_gdda";
    game[ "dialog" ][ "enemy_bomb_defused_a" ] = "iw9_gwbm_mode_uktl_gdoa";
    game[ "dialog" ][ "site_destroyed_a" ] = "iw9_gwbm_mode_uktl_gxda";
    game[ "dialog" ][ "enemy_site_destroyed_a" ] = "iw9_gwbm_mode_uktl_gxoa";
    game[ "dialog" ][ "bomb_planting_b" ] = "iw9_gwbm_mode_uktl_gbxb";
    game[ "dialog" ][ "bomb_planted_b" ] = "iw9_gwbm_mode_uktl_gpob";
    game[ "dialog" ][ "enemy_bomb_b" ] = "iw9_gwbm_mode_uktl_gpdb";
    game[ "dialog" ][ "bomb_defused_b" ] = "iw9_gwbm_mode_uktl_gddb";
    game[ "dialog" ][ "enemy_bomb_defused_b" ] = "iw9_gwbm_mode_uktl_gdob";
    game[ "dialog" ][ "site_destroyed_b" ] = "iw9_gwbm_mode_uktl_gxdb";
    game[ "dialog" ][ "enemy_site_destroyed_b" ] = "iw9_gwbm_mode_uktl_gxob";
    game[ "dialog" ][ "bomb_planting_c" ] = "iw9_gwbm_mode_uktl_gbxc";
    game[ "dialog" ][ "bomb_planted_c" ] = "iw9_gwbm_mode_uktl_gpoc";
    game[ "dialog" ][ "enemy_bomb_c" ] = "iw9_gwbm_mode_uktl_gpdc";
    game[ "dialog" ][ "bomb_defused_c" ] = "iw9_gwbm_mode_uktl_gddc";
    game[ "dialog" ][ "enemy_bomb_defused_c" ] = "iw9_gwbm_mode_uktl_gdoc";
    game[ "dialog" ][ "site_destroyed_c" ] = "iw9_gwbm_mode_uktl_gxdc";
    game[ "dialog" ][ "enemy_site_destroyed_c" ] = "iw9_gwbm_mode_uktl_gxoc";
    game[ "dialog" ][ "bomb_planting_d" ] = "iw9_gwbm_mode_uktl_gbxd";
    game[ "dialog" ][ "bomb_planted_d" ] = "iw9_gwbm_mode_uktl_gpod";
    game[ "dialog" ][ "enemy_bomb_d" ] = "iw9_gwbm_mode_uktl_gpdd";
    game[ "dialog" ][ "bomb_defused_d" ] = "iw9_gwbm_mode_uktl_gddd";
    game[ "dialog" ][ "enemy_bomb_defused_d" ] = "iw9_gwbm_mode_uktl_gdod";
    game[ "dialog" ][ "site_destroyed_d" ] = "iw9_gwbm_mode_uktl_gxdd";
    game[ "dialog" ][ "enemy_site_destroyed_d" ] = "iw9_gwbm_mode_uktl_gxod";
    game[ "dialog" ][ "bomb_planting_e" ] = "iw9_gwbm_mode_uktl_gbxe";
    game[ "dialog" ][ "bomb_planted_e" ] = "iw9_gwbm_mode_uktl_gpoe";
    game[ "dialog" ][ "enemy_bomb_e" ] = "iw9_gwbm_mode_uktl_gpde";
    game[ "dialog" ][ "bomb_defused_e" ] = "iw9_gwbm_mode_uktl_gdde";
    game[ "dialog" ][ "enemy_bomb_defused_e" ] = "iw9_gwbm_mode_uktl_gdoe";
    game[ "dialog" ][ "site_destroyed_e" ] = "iw9_gwbm_mode_uktl_gxde";
    game[ "dialog" ][ "enemy_site_destroyed_e" ] = "iw9_gwbm_mode_uktl_gxoe";
    game[ "dialog" ][ "bomb_planting_f" ] = "iw9_gwbm_mode_uktl_gbxf";
    game[ "dialog" ][ "bomb_planted_f" ] = "iw9_gwbm_mode_uktl_gpof";
    game[ "dialog" ][ "enemy_bomb_f" ] = "iw9_gwbm_mode_uktl_gpdf";
    game[ "dialog" ][ "bomb_defused_f" ] = "iw9_gwbm_mode_uktl_gddf";
    game[ "dialog" ][ "enemy_bomb_defused_f" ] = "iw9_gwbm_mode_uktl_gdof";
    game[ "dialog" ][ "site_destroyed_f" ] = "iw9_gwbm_mode_uktl_gxdf";
    game[ "dialog" ][ "enemy_site_destroyed_f" ] = "iw9_gwbm_mode_uktl_gxof";
    game[ "dialog" ][ "bomb_planting_g" ] = "iw9_gwbm_mode_uktl_gbxg";
    game[ "dialog" ][ "bomb_planted_g" ] = "iw9_gwbm_mode_uktl_gpog";
    game[ "dialog" ][ "enemy_bomb_g" ] = "iw9_gwbm_mode_uktl_gpdg";
    game[ "dialog" ][ "bomb_defused_g" ] = "iw9_gwbm_mode_uktl_gddg";
    game[ "dialog" ][ "enemy_bomb_defused_g" ] = "iw9_gwbm_mode_uktl_gdog";
    game[ "dialog" ][ "site_destroyed_g" ] = "iw9_gwbm_mode_uktl_gxdg";
    game[ "dialog" ][ "enemy_site_destroyed_g" ] = "iw9_gwbm_mode_uktl_gxog";
    game[ "dialog" ][ "bomb_planting_h" ] = "iw9_gwbm_mode_uktl_gbxh";
    game[ "dialog" ][ "bomb_planted_h" ] = "iw9_gwbm_mode_uktl_gpoh";
    game[ "dialog" ][ "enemy_bomb_h" ] = "iw9_gwbm_mode_uktl_gpdh";
    game[ "dialog" ][ "bomb_defused_h" ] = "iw9_gwbm_mode_uktl_gddh";
    game[ "dialog" ][ "enemy_bomb_defused_h" ] = "iw9_gwbm_mode_uktl_gdoh";
    game[ "dialog" ][ "site_destroyed_h" ] = "iw9_gwbm_mode_uktl_gxdh";
    game[ "dialog" ][ "enemy_site_destroyed_h" ] = "iw9_gwbm_mode_uktl_gxoh";
    level._effect[ "vfx_smk_signal_gr" ] = loadfxasset( "vfx_requests_mp_gameplay_smoke_signal_gr" );
    level._effect[ "vfx_snatch_ac130_clouds" ] = loadfxasset( "vfx_iw8_mp_gamemode_snatch_ac130_clouds" );
    level._effect[ "vfx_br_infil_cloud_scroll" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_cloud_scroll" );
    level._effect[ "vfx_br_infil_jump_smoke_01" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_smoke_01" );
    level._effect[ "vfx_br_infil_jump_wisp_01" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_wisp_01" );
    level._effect[ "vfx_br_infil_jump_wisp_02" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_jump_wisp_02" );
    level._effect[ "vfx_br_infil_omni_light" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_omni_light" );
    level._effect[ "vfx_br_infil_spot_light" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_spot_light" );
    level.var_20c310324a5716ad = 1;
    level.bombsplanted = 0;
    level.ddbombmodel = [];
    level.aplanted = 0;
    level.bplanted = 0;
    level.nukeselectactive = getdvarint( @"hash_720c7a325f31f44b", 0 );
    level.killstoearnnukeselect = getdvarint( @"hash_b081c1dd5ea0af33", 7 );
    level.useobjectives = getdvarint( @"hash_f487c553b2ae0bdb", 1 );
    level.userallypointvehicles = getdvarint( @"hash_9381d93d96c2f50b", 1 );
    level.hideenemyhq = getdvarint( @"hash_5309488dd7832413", 0 );
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
    level.var_3416583522672ad3 = getdvarint( @"hash_8f147ae2cd92aca", 1 );
    
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
    level.disableteamstartspawns = 1;
    level.spawnprotectionexception = &spawnprotectionexception;
    thread function_e42623be2d62d389();
    
    if ( getdvarint( @"hash_60a5cd40eb9c3192", 0 ) == 1 )
    {
        level thread namespace_14ab7f658b8ad5e4::function_a1e291f650f8bab3();
    }
    
    utility::flag_init( "stealth_enabled" );
    utility::flag_init( "level_stealth_initialized" );
    utility::flag_init( "stealth_spotted" );
}

// Namespace gwbomb
// Params 0
// Checksum 0x11b1f238, Offset: 0x2960
// Size: 0xcd
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_gwbomb_zonelifetime", getmatchrulesdata( "kothData", "zoneLifetime" ) );
    setdynamicdvar( @"scr_gwbomb_zonecapturetime", getmatchrulesdata( "kothData", "zoneCaptureTime" ) );
    setdynamicdvar( @"scr_gwbomb_zoneactivationdelay", getmatchrulesdata( "kothData", "zoneActivationDelay" ) );
    setdynamicdvar( @"scr_gwbomb_randomlocationorder", getmatchrulesdata( "kothData", "randomLocationOrder" ) );
    setdynamicdvar( @"scr_gwbomb_additivescoring", getmatchrulesdata( "kothData", "additiveScoring" ) );
    setdynamicdvar( @"scr_gwbomb_pausetime", getmatchrulesdata( "kothData", "pauseTime" ) );
    setdynamicdvar( @"hash_97df2d78c43bcb98", getmatchrulesdata( "tdefData", "spawnDelay" ) );
}

// Namespace gwbomb
// Params 0
// Checksum 0xccbd51df, Offset: 0x2a35
// Size: 0x348
function onstartgametype()
{
    setomnvar( "ui_victory_condition_completed", 0 );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    foreach ( team in level.teamnamelist )
    {
        game_utility_mp::setobjectivehinttext( team, &"objectives/gwbomb_hint" );
    }
    
    setclientnamemode( "auto_change" );
    level.bombplanted = 0;
    level.bombdefused = 0;
    level.bombexploded = 0;
    level.multibomb = 1;
    level._effect[ "bomb_explosion" ] = loadfxasset( "vfx_iw9_dmz_bombsite_explo" );
    level._effect[ "vehicle_explosion" ] = loadfxasset( "vfx_core_explo_small_vehicle_new" );
    level._effect[ "building_explosion" ] = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
    level.objectives = [];
    level.uncapturableobjectives = [];
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
    debug_setupmatchdata();
    setuphqs();
    calculatehqmidpoint();
    
    if ( level.useobjectives )
    {
        level thread setupobjectives();
    }
    
    level thread runobjectives();
    
    if ( level.usec130spawn )
    {
        level thread arm_vehicles::managec130spawns();
    }
    
    /#
        level thread function_662cf4c1bdb0bdc3();
    #/
    
    if ( level.userallypointvehicles )
    {
        rally_point::init();
        level thread arm_vehicles::init_rallyvehicles();
    }
    
    thread arm_vehicles::init_groundwarvehicles();
    level thread spawnselection::updatefobindanger();
    dialog::initstatusdialog();
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
}

// Namespace gwbomb
// Params 0
// Checksum 0x8ea2be0e, Offset: 0x2d85
// Size: 0x1e5
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.bombtimer = dvars::dvarintvalue( "bombtimer", 45, 1, 300 );
    level.planttime = dvars::dvarfloatvalue( "planttime", 5, 0, 20 );
    level.defusetime = dvars::dvarfloatvalue( "defusetime", 5, 0, 20 );
    level.resetprogress = dvars::dvarintvalue( "resetProgress", 1, 0, 1 );
    level.var_4ef3f193ae5be5d2 = dvars::dvarintvalue( "allowPlantedSites", 1, 0, 1 );
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
}

// Namespace gwbomb
// Params 0
// Checksum 0x7367311c, Offset: 0x2f72
// Size: 0x2
function seticonnames()
{
    
}

// Namespace gwbomb
// Params 0
// Checksum 0xd9fb52cf, Offset: 0x2f7c
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

// Namespace gwbomb
// Params 0
// Checksum 0xa5be4b60, Offset: 0x32b8
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

// Namespace gwbomb
// Params 1
// Checksum 0x74d110e8, Offset: 0x3418
// Size: 0x15
function onjoinedteam( player )
{
    player arm_upgrades::function_c7d2f4bdf8ac4c13();
}

// Namespace gwbomb
// Params 0
// Checksum 0x3ae5b342, Offset: 0x3435
// Size: 0x8a
function debug_setupmatchdata()
{
    level.var_76c4dc73f6b30344 = [];
    level.var_76c4dc73f6b30344[ "axis" ] = "gw_fob_axisHQ";
    level.var_76c4dc73f6b30344[ "allies" ] = "gw_fob_alliesHQ";
    level.startingfobnames_axis = [ "_a", "_b", "_c" ];
    level.startingfobnames_allies = [ "_d", "_e", "_f" ];
    level.startingfobnames_neutral = [];
}

// Namespace gwbomb
// Params 0
// Checksum 0x5b4e2907, Offset: 0x34c7
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

// Namespace gwbomb
// Params 0
// Checksum 0x4a479f18, Offset: 0x361b
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

// Namespace gwbomb
// Params 0
// Checksum 0x8c824c94, Offset: 0x3714
// Size: 0x459
function setupobjectives()
{
    level.gw_objstruct.startingfobs_allies = [];
    level.gw_objstruct.startingfobs_axis = [];
    level.gw_objstruct.startingfobs_neutral = [];
    bombzones = getentarray( "gwbombzone", #targetname );
    
    foreach ( fobname in level.startingfobnames_allies )
    {
        foreach ( bomb in bombzones )
        {
            if ( bomb.script_label == fobname )
            {
                trigger = bomb;
                
                if ( isdefined( trigger ) )
                {
                    fob = spawnstruct();
                    fob.name = fobname;
                    fob.trigger = trigger;
                    fob.trigger.objkey = fobname;
                    level.gw_objstruct.startingfobs_allies[ level.gw_objstruct.startingfobs_allies.size ] = fob;
                }
            }
        }
    }
    
    foreach ( fobname in level.startingfobnames_axis )
    {
        foreach ( bomb in bombzones )
        {
            if ( bomb.script_label == fobname )
            {
                trigger = bomb;
                
                if ( isdefined( trigger ) )
                {
                    fob = spawnstruct();
                    fob.name = fobname;
                    fob.trigger = trigger;
                    fob.trigger.objkey = fobname;
                    level.gw_objstruct.startingfobs_axis[ level.gw_objstruct.startingfobs_axis.size ] = fob;
                }
            }
        }
    }
    
    foreach ( fobname in level.startingfobnames_neutral )
    {
        foreach ( bomb in bombzones )
        {
            if ( bomb.script_label == fobname )
            {
                trigger = bomb;
                
                if ( isdefined( trigger ) )
                {
                    fob = spawnstruct();
                    fob.name = fobname;
                    fob.trigger = trigger;
                    fob.trigger.objkey = fobname;
                    level.gw_objstruct.startingfobs_neutral[ level.gw_objstruct.startingfobs_neutral.size ] = fob;
                }
            }
        }
    }
    
    level.objectivessetup = 1;
}

// Namespace gwbomb
// Params 0
// Checksum 0x2a52d3db, Offset: 0x3b75
// Size: 0x25e
function updatedomscores()
{
    level endon( #"game_ended" );
    teamscore = undefined;
    otherteamscore = undefined;
    level waittill( #"prematch_done" );
    level thread spawnselection::updatefobindanger();
    
    while ( !level.gameended )
    {
        wait 10;
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
        
        if ( domflags.size )
        {
            for ( i = 1; i < domflags.size ; i++ )
            {
                domflag = domflags[ i ];
                flagscore = gettime() - domflag.capturetime;
                
                for ( j = i - 1; j >= 0 && flagscore > gettime() - domflags[ j ].capturetime ; j-- )
                {
                    domflags[ j + 1 ] = domflags[ j ];
                }
                
                domflags[ j + 1 ] = domflag;
            }
            
            foreach ( domflag in domflags )
            {
                team = domflag gameobjects::getownerteam();
                assert( team_utility::isgameplayteam( team ) );
                teamscore = getteamscore( team );
                var_d9425977785add8f = obj_dom::getteamflagcount( team );
                
                if ( var_d9425977785add8f >= level.flagsrequiredtoscore )
                {
                    level.scoretick[ team ] += level.pointsperflag;
                }
            }
        }
        
        updatescores();
    }
}

// Namespace gwbomb
// Params 0
// Checksum 0x145021f6, Offset: 0x3ddb
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

// Namespace gwbomb
// Params 1
// Checksum 0x4bca69d9, Offset: 0x3f88
// Size: 0xafd
function runobjectives( numobjs )
{
    while ( !level.objectivessetup )
    {
        waitframe();
    }
    
    level.spawnareas = [];
    level.var_3297f3d0b4e2f8da = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.spawnareas[ entry ] = [ level.var_76c4dc73f6b30344[ entry ] ];
        level.var_3297f3d0b4e2f8da[ entry ] = [];
    }
    
    level.allfobs = [];
    
    if ( level.useobjectives )
    {
        foreach ( fob in level.gw_objstruct.startingfobs_axis )
        {
            activefob = function_e3e8fce24767b2e0( fob.trigger, "axis" );
            level.allfobs[ level.allfobs.size ] = fob;
            level.spawnareas[ "axis" ][ level.spawnareas[ "axis" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "axis" ][ level.var_3297f3d0b4e2f8da[ "axis" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "allies" ][ level.var_3297f3d0b4e2f8da[ "allies" ].size ] = fob.name;
        }
        
        foreach ( fob in level.gw_objstruct.startingfobs_allies )
        {
            activefob = function_e3e8fce24767b2e0( fob.trigger, "allies" );
            level.allfobs[ level.allfobs.size ] = fob;
            level.spawnareas[ "allies" ][ level.spawnareas[ "allies" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "allies" ][ level.var_3297f3d0b4e2f8da[ "allies" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "axis" ][ level.var_3297f3d0b4e2f8da[ "axis" ].size ] = fob.name;
        }
        
        foreach ( fob in level.gw_objstruct.startingfobs_neutral )
        {
            activefob = function_e3e8fce24767b2e0( fob.trigger, "neutral" );
            level.allfobs[ level.allfobs.size ] = fob;
            level.var_3297f3d0b4e2f8da[ "axis" ][ level.var_3297f3d0b4e2f8da[ "axis" ].size ] = fob.name;
            level.var_3297f3d0b4e2f8da[ "allies" ][ level.var_3297f3d0b4e2f8da[ "allies" ].size ] = fob.name;
        }
        
        foreach ( fob in level.allfobs )
        {
            level.objectives[ fob.trigger.gameobject.objectivekey ] = fob.trigger.gameobject;
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ "allies" ] ) )
            {
                level.spawnselectionlocations[ fob.name ][ "allies" ].objectivekey = fob.trigger.gameobject.objectivekey;
            }
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ "axis" ] ) )
            {
                level.spawnselectionlocations[ fob.name ][ "axis" ].objectivekey = fob.trigger.gameobject.objectivekey;
            }
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ "allies" ].anchorentity ) )
            {
                level.spawnselectionlocations[ fob.name ][ "allies" ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
            }
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ "axis" ].anchorentity ) )
            {
                level.spawnselectionlocations[ fob.name ][ "axis" ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
            }
        }
    }
    
    level.var_8a86e28edb2ccd9b = getdvarint( @"hash_15bed23553aa71e4", 1 ) == 1;
    
    if ( level.var_8a86e28edb2ccd9b )
    {
        level.var_34e36cc0c79a5356 = getdvarint( @"hash_9cb1c06efe33ebf1", 1 ) == 1;
        allies = [];
        axis = [];
        allies[ 0 ] = strtok( getdvar( @"hash_4eefa769cd185940", "_d" ), " " );
        axis[ 0 ] = strtok( getdvar( @"hash_c40b0e26158d885b", "_c" ), " " );
        allies[ 1 ] = strtok( getdvar( @"hash_6acf684caf26d595", "_e _f" ), " " );
        axis[ 1 ] = strtok( getdvar( @"hash_acad4dd64982c63a", "_a _b" ), " " );
        allies[ 2 ] = strtok( getdvar( @"hash_42aaefc5b1e75dee", "" ), " " );
        axis[ 2 ] = strtok( getdvar( @"hash_247b839a052b5299", "" ), " " );
        level.var_7a9ee7758c1c261e = [];
        level.var_7a9ee7758c1c261e[ "allies" ] = allies;
        level.var_7a9ee7758c1c261e[ "axis" ] = axis;
        level.var_93d39687ec7d938b = [];
        level.var_93d39687ec7d938b[ "allies" ] = 0;
        level.var_93d39687ec7d938b[ "axis" ] = 0;
        
        foreach ( objective in level.objectives )
        {
            if ( !arraycontains( level.var_7a9ee7758c1c261e[ objective.ownerteam ][ 0 ], objective.objectivekey ) )
            {
                objective.inactive = 1;
                objective gameobjects::setobjectivestatusicons( "waypoint_locked", "waypoint_locked" );
                objective gameobjects::allowuse( "none" );
                
                if ( level.var_34e36cc0c79a5356 )
                {
                    objective gameobjects::setvisibleteam( "friendly" );
                }
                
                if ( level.var_3416583522672ad3 )
                {
                    otherteam = team_utility::getotherteam( objective.ownerteam );
                    level.var_3297f3d0b4e2f8da[ otherteam ] = arrayremove( level.var_3297f3d0b4e2f8da[ otherteam ], objective.objectivekey );
                }
            }
        }
    }
    
    if ( level.usespawnselection )
    {
        if ( level.var_3416583522672ad3 )
        {
            spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ "axis" ], "axis" );
            spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ "allies" ], "allies" );
        }
        else
        {
            spawnselection::setspawnlocations( level.spawnareas[ "axis" ], "axis" );
            spawnselection::setspawnlocations( level.spawnareas[ "allies" ], "allies" );
        }
        
        sethqmarkerobjective();
        
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
    }
    
    level thread objective_manageobjectivesintrovisibility();
    hackfixcameras();
    level thread allowobjectiveuseaftermatchstart();
}

// Namespace gwbomb
// Params 0
// Checksum 0x30985ead, Offset: 0x4a8d
// Size: 0xc4
function allowobjectiveuseaftermatchstart()
{
    flags::gameflagwait( "prematch_done" );
    
    foreach ( fob in level.allfobs )
    {
        if ( fob.trigger.gameobject.inactive )
        {
            continue;
        }
        
        fob.trigger.gameobject gameobjects::allowuse( "enemy" );
    }
}

// Namespace gwbomb
// Params 0
// Checksum 0x8955e663, Offset: 0x4b59
// Size: 0x406
function objective_manageobjectivesintrovisibility()
{
    wait 1;
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.axishqloc.marker.objidnum );
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.allieshqloc.marker.objidnum );
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.axishqloc.enemymarker.objidnum );
    objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.allieshqloc.enemymarker.objidnum );
    
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
    
    objidpoolmanager::objective_teammask_addtomask( level.gw_objstruct.axishqloc.marker.objidnum, "axis" );
    objidpoolmanager::objective_teammask_addtomask( level.gw_objstruct.allieshqloc.marker.objidnum, "allies" );
    
    foreach ( fob in level.allfobs )
    {
        if ( level.var_34e36cc0c79a5356 && fob.trigger.gameobject.inactive )
        {
            objidpoolmanager::objective_teammask_addtomask( fob.trigger.gameobject.objidnum, fob.trigger.gameobject.ownerteam );
            continue;
        }
        
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

// Namespace gwbomb
// Params 0
// Checksum 0x374a1f4e, Offset: 0x4f67
// Size: 0x176
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
    
    if ( level.var_3416583522672ad3 )
    {
        keys = [ "gw_fob_alliesHQ", "_a", "_b", "_c", "_d", "_e", "_f" ];
    }
    else
    {
        keys = [ "gw_fob_alliesHQ", "_d", "_e", "_f" ];
    }
    
    spawncamera::createOrientedCameras( keys, team, forward, -8500, 7000 );
    team = "axis";
    forward = level.spawnselectionteamforward[ team ];
    
    if ( level.var_3416583522672ad3 )
    {
        keys = [ "gw_fob_axisHQ", "_a", "_b", "_c", "_d", "_e", "_f" ];
    }
    else
    {
        keys = [ "gw_fob_axisHQ", "_a", "_b", "_c" ];
    }
    
    spawncamera::createOrientedCameras( keys, team, forward, -8500, 7000 );
}

// Namespace gwbomb
// Params 0
// Checksum 0xc3706d28, Offset: 0x50e5
// Size: 0x31d
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
        
        if ( gameobject.ownerteam == "axis" )
        {
            level.spawnareas[ "axis" ][ level.spawnareas[ "axis" ].size ] = fob.name;
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ "axis" ].anchorentity ) )
            {
                level.spawnselectionlocations[ fob.name ][ "axis" ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
            }
            
            continue;
        }
        
        if ( gameobject.ownerteam == "allies" )
        {
            level.spawnareas[ "allies" ][ level.spawnareas[ "allies" ].size ] = fob.name;
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ "allies" ].anchorentity ) )
            {
                level.spawnselectionlocations[ fob.name ][ "allies" ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
            }
        }
    }
    
    if ( level.var_3416583522672ad3 )
    {
        spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ "axis" ], "axis" );
        spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ "allies" ], "allies" );
        return;
    }
    
    spawnselection::setspawnlocations( level.spawnareas[ "axis" ], "axis" );
    spawnselection::setspawnlocations( level.spawnareas[ "allies" ], "allies" );
}

// Namespace gwbomb
// Params 0
// Checksum 0x2262d4dc, Offset: 0x540a
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

// Namespace gwbomb
// Params 0
// Checksum 0xf90320d1, Offset: 0x591b
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

// Namespace gwbomb
// Params 1
// Checksum 0x2b6433c, Offset: 0x594b
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

// Namespace gwbomb
// Params 1
// Checksum 0xb76c7ef9, Offset: 0x5985
// Size: 0x1c
function objective_onusebegin( player )
{
    obj_dom::dompoint_onusebegin( player );
    updatefobspawnselection();
}

// Namespace gwbomb
// Params 3
// Checksum 0xb41ba71, Offset: 0x59a9
// Size: 0x30
function objective_onuseend( team, player, success )
{
    obj_dom::dompoint_onuseend( team, player, success );
    updatefobspawnselection();
}

// Namespace gwbomb
// Params 1
// Checksum 0x4a7d5e0d, Offset: 0x59e1
// Size: 0x76
function objective_onuse( claim_player )
{
    obj_dom::dompoint_onuse( claim_player );
    updatefobspawnselection();
    otherteam = team_utility::getotherteam( claim_player.team );
    arm_upgrades::function_db60687d3222dcb4( otherteam, self.objectivekey );
    arm_upgrades::function_da6d0f03ca3101ad( self.objectivekey, otherteam );
    arm_upgrades::function_6a2e5bbf85fdef54( self.objectivekey, self.ownerteam );
}

// Namespace gwbomb
// Params 1
// Checksum 0x3133487a, Offset: 0x5a5f
// Size: 0x1c
function objective_onpinnedstate( player )
{
    updatefobspawnselection();
    obj_dom::dompoint_onunpinnedstate( player );
}

// Namespace gwbomb
// Params 1
// Checksum 0x7500bba3, Offset: 0x5a83
// Size: 0x1c
function objective_onunpinnedstate( player )
{
    updatefobspawnselection();
    obj_dom::dompoint_onunpinnedstate( player );
}

// Namespace gwbomb
// Params 2
// Checksum 0x81a7a1de, Offset: 0x5aa7
// Size: 0xe7
function runobjflag( objective, startingteam )
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
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

// Namespace gwbomb
// Params 2
// Checksum 0x286cd6e, Offset: 0x5b97
// Size: 0xc4
function function_e3e8fce24767b2e0( objective, ownerteam )
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    objective.script_label = objective.objkey;
    bombzone = obj_bombzone::setupobjective( objective );
    
    if ( isdefined( bombzone ) )
    {
        bombzone.onbeginuse = &onbeginuse;
        bombzone.onenduse = &onenduse;
        bombzone.onuse = &onuseplantobject;
        bombzone gameobjects::setownerteam( ownerteam );
        bombzone gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
        bombzone gameobjects::setvisibleteam( "any" );
    }
    
    return bombzone;
}

// Namespace gwbomb
// Params 1
// Checksum 0x55778790, Offset: 0x5c64
// Size: 0x15
function onbeginuse( player )
{
    obj_bombzone::bombzone_onbeginuse( player );
}

// Namespace gwbomb
// Params 3
// Checksum 0x7a77ff28, Offset: 0x5c81
// Size: 0x29
function onenduse( team, player, result )
{
    obj_bombzone::bombzone_onenduse( team, player, result );
}

// Namespace gwbomb
// Params 1
// Checksum 0x8e037ed5, Offset: 0x5cb2
// Size: 0xdb
function onuseplantobject( player )
{
    skipplayers = [];
    skipplayers[ skipplayers.size ] = player;
    level thread hud_message::notifyteam( "emp_planted", "emp_planted_enemy", player.team, skipplayers );
    player thread hud_message::showsplash( "emp_planted", rank::getscoreinfovalue( #"plant" ) );
    obj_bombzone::bombzone_onuseplantobject( player );
    
    if ( level.var_e9b33636f46b851c )
    {
        if ( !level.var_3416583522672ad3 )
        {
            level.spawnareas[ player.team ][ level.spawnareas[ player.team ].size ] = self.objectivekey;
            spawnselection::setspawnlocations( level.spawnareas[ player.team ], player.team );
        }
    }
}

// Namespace gwbomb
// Params 1
// Checksum 0x53febb59, Offset: 0x5d95
// Size: 0xcb
function function_a40bb805b501896e( plantteam )
{
    otherteam = team_utility::getotherteam( self.ownerteam );
    gamescore::giveteamscoreforobjective( otherteam, 1, 0, undefined, 1 );
    self.id = "destroyed_site";
    otherteamscore = getteamscore( otherteam );
    
    if ( otherteamscore == level.roundscorelimit - 1 )
    {
        dialog::statusdialog( "gwbomb_last_site_offense", otherteam, 1 );
        dialog::statusdialog( "gwbomb_last_site_defense", self.ownerteam, 1 );
        return;
    }
    
    dialog::statusdialog( "enemy_site_destroyed" + self.objectivekey, otherteam, 1 );
    dialog::statusdialog( "site_destroyed" + self.objectivekey, self.ownerteam, 1 );
}

// Namespace gwbomb
// Params 6
// Checksum 0xc8dab3bd, Offset: 0x5e68
// Size: 0x4b0
function onobjectivecomplete( objectivetype, objectivekey, credit_player, team, oldteam, obj )
{
    otherteam = team_utility::getotherteam( self.ownerteam );
    
    if ( self.id != "destroyed_site" )
    {
        if ( level.var_e9b33636f46b851c )
        {
            if ( !level.var_3416583522672ad3 )
            {
                level.spawnareas[ otherteam ] = arrayremove( level.spawnareas[ otherteam ], self.objectivekey );
                spawnselection::setspawnlocations( level.spawnareas[ otherteam ], otherteam );
            }
        }
        
        return;
    }
    
    if ( level.var_3416583522672ad3 )
    {
        level.var_3297f3d0b4e2f8da[ self.ownerteam ] = arrayremove( level.spawnareas[ self.ownerteam ], self.objectivekey );
        spawnselection::setspawnlocations( level.spawnareas[ self.ownerteam ], self.ownerteam );
        level.var_3297f3d0b4e2f8da[ otherteam ] = arrayremove( level.spawnareas[ otherteam ], self.objectivekey );
        spawnselection::setspawnlocations( level.spawnareas[ otherteam ], otherteam );
    }
    
    if ( level.var_34690de86f48cef7 )
    {
        if ( !level.var_3416583522672ad3 )
        {
            level.spawnareas[ self.ownerteam ] = arrayremove( level.spawnareas[ self.ownerteam ], self.objectivekey );
            spawnselection::setspawnlocations( level.spawnareas[ self.ownerteam ], self.ownerteam );
        }
    }
    
    if ( level.var_8da7159612e82989 )
    {
        if ( !level.var_3416583522672ad3 )
        {
            level.spawnareas[ otherteam ][ level.spawnareas[ otherteam ].size ] = self.objectivekey;
            spawnselection::setspawnlocations( level.spawnareas[ otherteam ], otherteam );
        }
        
        gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
        gameobjects::setownerteam( otherteam );
        gameobjects::setvisibleteam( "friendly" );
    }
    else if ( level.var_e9b33636f46b851c )
    {
        if ( !level.var_3416583522672ad3 )
        {
            level.spawnareas[ otherteam ] = arrayremove( level.spawnareas[ otherteam ], self.objectivekey );
            spawnselection::setspawnlocations( level.spawnareas[ otherteam ], otherteam );
        }
    }
    
    if ( level.var_8a86e28edb2ccd9b )
    {
        canprogress = 1;
        
        foreach ( key in level.var_7a9ee7758c1c261e[ self.ownerteam ][ level.var_93d39687ec7d938b[ self.ownerteam ] ] )
        {
            if ( level.objectives[ key ].id != "destroyed_site" )
            {
                canprogress = 0;
                break;
            }
        }
        
        if ( canprogress )
        {
            level.var_93d39687ec7d938b[ self.ownerteam ]++;
            
            foreach ( key in level.var_7a9ee7758c1c261e[ self.ownerteam ][ level.var_93d39687ec7d938b[ self.ownerteam ] ] )
            {
                objective = level.objectives[ key ];
                objective.inactive = 0;
                objective gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
                objective gameobjects::setvisibleteam( "any" );
                objective gameobjects::allowuse( "enemy" );
                
                if ( level.var_3416583522672ad3 )
                {
                    otherteam = team_utility::getotherteam( objective.ownerteam );
                    level.var_3297f3d0b4e2f8da[ otherteam ][ level.var_3297f3d0b4e2f8da[ otherteam ].size ] = key;
                    spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ otherteam ], otherteam );
                }
            }
            
            level thread function_ac8c6e3dd13d7319( self.ownerteam, otherteam );
        }
    }
}

// Namespace gwbomb
// Params 2
// Checksum 0x6e681480, Offset: 0x6320
// Size: 0x47
function function_ac8c6e3dd13d7319( ownerteam, otherteam )
{
    level endon( #"game_ended" );
    wait 5;
    dialog::statusdialog( "gwbomb_progress_defense", ownerteam, 1 );
    dialog::statusdialog( "gwbomb_progress_offense", otherteam, 1 );
}

// Namespace gwbomb
// Params 3
// Checksum 0x347000ee, Offset: 0x636f
// Size: 0x4b
function dropcrate( killstreakname, droplocation, team )
{
    crate = airdrop::droparmcratefromscriptedheli( team, killstreakname, droplocation.origin, ( 0, randomint( 360 ), 0 ), undefined );
    return crate;
}

// Namespace gwbomb
// Params 3
// Checksum 0xfb227ecc, Offset: 0x63c3
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

// Namespace gwbomb
// Params 0
// Checksum 0xb180b394, Offset: 0x64ff
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

// Namespace gwbomb
// Params 0
// Checksum 0xae9d85a8, Offset: 0x66b2
// Size: 0x14
function debug_testcratedroplocationpicker()
{
    while ( true )
    {
        choosecratelocation();
        wait 1;
    }
}

// Namespace gwbomb
// Params 1
// Checksum 0x345cb, Offset: 0x66ce
// Size: 0x41
function checkkillstreakcratedrop( team )
{
    if ( game[ "teamScores" ][ team ] >= level.nextkillstreakgoal )
    {
        level.nextkillstreakgoal += 100;
        dropkillstreakcrates( 2 );
    }
}

// Namespace gwbomb
// Params 1
// Checksum 0xf190151d, Offset: 0x6717
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

// Namespace gwbomb
// Params 0
// Checksum 0x15f4b8bf, Offset: 0x67f0
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

// Namespace gwbomb
// Params 1
// Checksum 0x8845bd32, Offset: 0x696e
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

// Namespace gwbomb
// Params 0
// Checksum 0xa57e8dbe, Offset: 0x6aba
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

// Namespace gwbomb
// Params 3
// Checksum 0x7cff654c, Offset: 0x6bca
// Size: 0x260
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
    currentwait = 0;
    interval = 0.1;
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

// Namespace gwbomb
// Params 1
// Checksum 0x9f46e49, Offset: 0x6e32
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

// Namespace gwbomb
// Params 0
// Checksum 0xec95eaa4, Offset: 0x6e87
// Size: 0xa6
function processkillstreaksintotiers()
{
    level.killstreaktierlist = [];
    level.killstreaktierlist[ 3 ] = [ "cruise_predator", "scrambler_drone_guard", "uav" ];
    level.killstreaktierlist[ 2 ] = [ "precision_airstrike", "multi_airstrike", "bradley" ];
    level.killstreaktierlist[ 1 ] = [ "toma_strike", "uav", "pac_sentry", "white_phosphorus" ];
    level.killstreaktierlist[ 0 ] = [ "uav" ];
}

// Namespace gwbomb
// Params 1
// Checksum 0x2e81f90e, Offset: 0x6f35
// Size: 0x36
function br_getrewardicon( streakname )
{
    return level.killstreakglobals.streaktable.tabledatabyref[ streakname ].hudicon;
}

// Namespace gwbomb
// Params 0
// Checksum 0x1e3c3101, Offset: 0x6f74
// Size: 0x22
function nuke_mercyending_init()
{
    flags::gameflagwait( "prematch_done" );
    
    if ( level.useobjectives )
    {
        level thread nuke_mercyending_think();
    }
}

// Namespace gwbomb
// Params 0
// Checksum 0x1d62518a, Offset: 0x6f9e
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

// Namespace gwbomb
// Params 1
// Checksum 0x6569e9ef, Offset: 0x7018
// Size: 0x106
function nuke_startmercycountdown( team )
{
    level notify( #"hash_f820681d2ed0d10f" );
    level endon( #"hash_71fa673dc344f809" );
    setomnvar( "ui_nuke_timer_type", 1 );
    setomnvar( "ui_arm_dominatingTeam", team == "axis" ? 1 : 2 );
    setomnvar( "ui_nuke_timer_time", level.mercymatchending_time );
    setomnvar( "ui_nuke_countdown_active", 1 );
    mercytimer = 0;
    starttime = gettime();
    endtime = level.mercymatchending_time * 1000 + starttime;
    setomnvar( "ui_nuke_end_milliseconds", level.mercymatchending_time * 1000 + starttime );
    
    while ( calculateobjectivesheld( team ) == level.objectives.size )
    {
        waitframe();
        
        if ( gettime() > endtime )
        {
            nuke_triggermercywin( team );
            level notify( #"hash_71fa673dc344f809" );
        }
    }
    
    setomnvar( "ui_nuke_countdown_active", 0 );
    level thread nuke_mercyending_think();
}

// Namespace gwbomb
// Params 1
// Checksum 0x6dfb1856, Offset: 0x7126
// Size: 0x20a
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
        var_78e28e74ac1a8348 nuke::tryusenuke();
        return;
    }
    
    level thread gamelogic_mp::endgame( team, game[ "end_reason" ][ "mercy_win" ], game[ "end_reason" ][ "mercy_loss" ], 0, 1 );
}

// Namespace gwbomb
// Params 1
// Checksum 0x4c7e17d6, Offset: 0x7338
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

// Namespace gwbomb
// Params 1
// Checksum 0x67b13a08, Offset: 0x73cb
// Size: 0x229
function initspawns( var_ac03d2bf36c55e04 )
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
    
    level.gamemodestartspawnpointnames[ "allies" ] = var_8e0b555d6a1fce7c;
    level.gamemodestartspawnpointnames[ "axis" ] = var_ce31d0f10d5f8fab;
    level.gamemodespawnpointnames = [];
    level.gamemodespawnpointnames[ "allies" ] = "mp_tdm_spawn";
    level.gamemodespawnpointnames[ "axis" ] = "mp_tdm_spawn";
    spawnlogic::function_6dbabb72223a4bca();
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
    spawnlogic::finalizemap();
    level.spawnpoints = spawns;
}

// Namespace gwbomb
// Params 0
// Checksum 0xcbbfd120, Offset: 0x75fc
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

// Namespace gwbomb
// Params 1
// Checksum 0x5750fba4, Offset: 0x7727
// Size: 0x8a
function onspawnplayer( revivespawn )
{
    self.forcespawnnearteammates = undefined;
    thread updatematchstatushintonspawn();
    cash::function_3909082084ad6974();
    squads::updatesquadomnvars( self.team, self.sessionsquadid );
    
    if ( game_utility_common::isgameparticipant( self ) )
    {
        self.isplanting = 0;
        self.isdefusing = 0;
        self.isbombcarrier = 1;
        self setclientomnvar( "ui_hud_carried_item_index", 0 );
        self setclientomnvar( "ui_hud_carried_item_count", 0 );
        self setclientomnvar( "ui_carrying_bomb", 0 );
    }
}

// Namespace gwbomb
// Params 0
// Checksum 0xc5f37cb1, Offset: 0x77b9
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

// Namespace gwbomb
// Params 10
// Checksum 0x8b27cf23, Offset: 0x77ff
// Size: 0x163
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
    
    if ( level.nukeselectactive && isplayer( attacker ) && smeansofdeath != "MOD_SUICIDE" )
    {
        if ( !isdefined( attacker.killcountthislife ) )
        {
            attacker.killcountthislife = 0;
        }
        
        if ( !attacker.hasnukeselectks )
        {
            attacker.killcountthislife++;
        }
        
        nukeselectgimmewatcher( attacker );
    }
    
    if ( !isdefined( level.c130pathkilltracker ) || level.c130movementmethod != 1 )
    {
        return;
    }
    
    level.c130pathkilltracker[ self.team ] += 1;
}

// Namespace gwbomb
// Params 1
// Checksum 0x4587612, Offset: 0x796a
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

// Namespace gwbomb
// Params 1
// Checksum 0xddb81673, Offset: 0x7baa
// Size: 0x2e
function onplayerconnect( player )
{
    if ( isdefined( level.rallypointvehicles ) )
    {
        thread rally_point::rallypoint_showtoplayer( player );
    }
    
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
}

// Namespace gwbomb
// Params 1
// Checksum 0x96c6f028, Offset: 0x7be0
// Size: 0xc
function onplayerdisconnect( player )
{
    
}

// Namespace gwbomb
// Params 0
// Checksum 0x7ec124ad, Offset: 0x7bf4
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

// Namespace gwbomb
// Params 0
// Checksum 0xcdad0847, Offset: 0x7c77
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

// Namespace gwbomb
// Params 1
// Checksum 0xc394be94, Offset: 0x7de1
// Size: 0x22
function onplayerspawned( player )
{
    while ( true )
    {
        player waittill( #"spawned" );
    }
}

// Namespace gwbomb
// Params 0
// Checksum 0x7b5c8daa, Offset: 0x7e0b
// Size: 0xc
function getrespawndelay()
{
    self.spawncameraskipthermal = 0;
}

// Namespace gwbomb
// Params 6
// Checksum 0xa039cd79, Offset: 0x7e20
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace gwbomb
// Params 0
// Checksum 0xaaf360b6, Offset: 0x7e70
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

// Namespace gwbomb
// Params 3
// Checksum 0xd5b2bc87, Offset: 0x8002
// Size: 0x4b
function setteammapposition( configref, team, posinfo )
{
    if ( !isdefined( level.spectatorcameras[ configref ] ) )
    {
        level.spectatorcameras[ configref ] = [];
    }
    
    level.spectatorcameras[ configref ][ team ] = posinfo;
}

// Namespace gwbomb
// Params 0
// Checksum 0xf2d02b00, Offset: 0x8055
// Size: 0x13
function applythermal()
{
    self visionsetthermalforplayer( "proto_apache_flir_mp" );
    self thermalvisionon();
}

// Namespace gwbomb
// Params 0
// Checksum 0xbdbe31a2, Offset: 0x8070
// Size: 0x8
function removethermal()
{
    self thermalvisionoff();
}

// Namespace gwbomb
// Params 0
// Checksum 0x715bc27b, Offset: 0x8080
// Size: 0x132
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
    var_a1227b6c346658d4 = 0;
    bestflag = undefined;
    camorigin = ( 0, 0, 0 );
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

// Namespace gwbomb
// Params 0
// Checksum 0xed3783a, Offset: 0x81ba
// Size: 0x16
function dohalfwayflash()
{
    wait 0.4;
    thread playslamzoomflash();
    applythermal();
}

// Namespace gwbomb
// Params 0
// Checksum 0xa36e41c5, Offset: 0x81d8
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

// Namespace gwbomb
// Params 3
// Checksum 0xb393eb5f, Offset: 0x81ff
// Size: 0x10d
function movecameratomappos( player, var_9956298e86821c5a, finalangles )
{
    player endon( #"spawned_player" );
    movetime = 1;
    rotatetime = 1;
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

// Namespace gwbomb
// Params 0
// Checksum 0xd3d9d304, Offset: 0x8314
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

// Namespace gwbomb
// Params 0
// Checksum 0xa817122f, Offset: 0x8406
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

// Namespace gwbomb
// Params 0
// Checksum 0xd40b5073, Offset: 0x84e5
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

    // Namespace gwbomb
    // Params 1
    // Checksum 0x13ef3bf4, Offset: 0x85de
    // Size: 0x1a, Type: dev
    function debugprint( text )
    {
        if ( false )
        {
            println( text );
        }
    }

#/

// Namespace gwbomb
// Params 1
// Checksum 0xc2156afb, Offset: 0x8600
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

// Namespace gwbomb
// Params 1
// Checksum 0x6676a2fc, Offset: 0x8667
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

// Namespace gwbomb
// Params 12
// Checksum 0xefda1230, Offset: 0x870d
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

    // Namespace gwbomb
    // Params 0
    // Checksum 0x7d5c9ff4, Offset: 0x88d7
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

    // Namespace gwbomb
    // Params 1
    // Checksum 0xd5038dd9, Offset: 0x8e20
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

// Namespace gwbomb
// Params 3
// Checksum 0xe072cf32, Offset: 0x9545
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

// Namespace gwbomb
// Params 1
// Checksum 0xf961a1bd, Offset: 0x9761
// Size: 0x98a
function getmissedinfilcamerapositions( team )
{
    assert( isdefined( game_utility::getlocaleid() ), "<dev string:x107>" );
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

// Namespace gwbomb
// Params 0
// Checksum 0x1e4b42a1, Offset: 0xa0f4
// Size: 0xea
function calculatehqmidpoint()
{
    level.hqmidpoint = ( level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin ) * 0.5;
    level.hqvecttomid_allies = level.gw_objstruct.axishqloc.trigger.origin - level.hqmidpoint;
    level.hqvecttomid_axis = level.gw_objstruct.allieshqloc.trigger.origin - level.hqmidpoint;
    level.hqdisttomid = length( level.hqvecttomid_axis );
}

// Namespace gwbomb
// Params 2
// Checksum 0x550fc5e9, Offset: 0xa1e6
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

// Namespace gwbomb
// Params 0
// Checksum 0xcc95d69c, Offset: 0xa444
// Size: 0x29, Type: bool
function spawnprotectionexception()
{
    if ( isdefined( self.selectedspawnarea ) && issubstr( self.selectedspawnarea, "HQ" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace gwbomb
// Params 0
// Checksum 0xd106cf3b, Offset: 0xa476
// Size: 0x11
function function_e42623be2d62d389()
{
    wait 5;
    audio_utility::snd_transient_load( "mp_gamemode_gw" );
}

