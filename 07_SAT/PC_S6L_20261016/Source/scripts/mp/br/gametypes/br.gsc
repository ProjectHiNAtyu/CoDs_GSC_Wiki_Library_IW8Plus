// scripts\mp\br\gametypes\br.gsc  (hash_28320ecc98c34e49.gscc) (size: 217137 Bytes / 0x35031 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb2eaccec (3001732332)
// size ...... 217137 (0x35031)
// includes .. 185 (offset: 0x312d1)
// strings ... 802 (offset: 0x31899)
// dev strs .. 34  (offset: 0x34e69)
// exports ... 406 (offset: 0x2211d)
// cseg ...... 0x4293 + 0x1de8a (0x2211d)
// imports ... 1369 (offset: 0x2608d)
// animtree1 . 0   (offset: 0x35031)
// animtree2 . 0   (offset: 0x35031)
#using script_26a390d7e02d3f8d;
#using script_26ccbfe3954cacf4;
#using script_2b062cc62170d7a8;
#using script_3a5f079804604bc4;
#using script_3cb3908b3094b567;
#using script_50914162bf70e498;
#using script_52f6a474645b8e9a;
#using script_5757e9f873fc5cf3;
#using script_68bfedf2ed730bd;
#using script_6962ddc481c4af49;
#using script_70ac8a06d80020b0;
#using script_72af5a878a9d3397;
#using script_78fc8c746d423a6d;
#using script_be7da0439d09064;
#using scripts\common\ai\stealth\manager;
#using scripts\common\ai\stealth\player;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\gasmask;
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\scriptable_ascender;
#using scripts\common\scriptable_group_spatial;
#using scripts\common\scripted_widgets;
#using scripts\common\telemetry_utils;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\ai_loot;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_sentry_turret;
#using scripts\mp\armor;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\br\ammorestock;
#using scripts\mp\br\gamelogic;
#using scripts\mp\br\gametypes\br_alt_mode_arcade_royale;
#using scripts\mp\br\gametypes\br_alt_mode_shock;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_c130airdrop;
#using scripts\mp\br\gametypes\br_callouts;
#using scripts\mp\br\gametypes\br_challenges;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_common_kiosk;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_dev_phoenix;
#using scripts\mp\br\gametypes\br_dom_gulag;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_ending_chopper;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\br\gametypes\br_events;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_extract_quest;
#using scripts\mp\br\gametypes\br_fogofwar;
#using scripts\mp\br\gametypes\br_functional_poi;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_infils_legacy;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_jugg_common;
#using scripts\mp\br\gametypes\br_killstreaks;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_respawn;
#using scripts\mp\br\gametypes\br_rewards;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\br\gametypes\br_task_person_of_interest;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\br\gametypes\br_vehicles;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\br\init_shared_funcs;
#using scripts\mp\br\music_and_dialog;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\callouts;
#using scripts\mp\cash;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\common\equipment\balloon_extract;
#using scripts\mp\common\equipment\fulton;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\equipment\support_box;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\popsmoke;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\supers\super_stimpistol;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\backpack;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\currency;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\execution;
#using scripts\mp\final_killcam;
#using scripts\mp\fire_traps;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\gametypes\barter_system;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\skydive_protection;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\javelin;
#using scripts\mp\killcam;
#using scripts\mp\laststand;
#using scripts\mp\leagueplay_br;
#using scripts\mp\loot;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_gasmask;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\loot\common_item_super;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\menus;
#using scripts\mp\mp_gameskill;
#using scripts\mp\music_and_dialog;
#using scripts\mp\overlord;
#using scripts\mp\parachute;
#using scripts\mp\personal_bests;
#using scripts\mp\playerlogic;
#using scripts\mp\playerstats_interface;
#using scripts\mp\poi;
#using scripts\mp\potg;
#using scripts\mp\rank;
#using scripts\mp\scoreboard;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\squads;
#using scripts\mp\supers;
#using scripts\mp\team_assimilation;
#using scripts\mp\teams;
#using scripts\mp\tripwire;
#using scripts\mp\validation;
#using scripts\mp\weaponrank;
#using scripts\mp\weapons;

#namespace br;

// Namespace br
// Params 0
// Checksum 0x47d13dbf, Offset: 0x42b1
// Size: 0x1849
function main()
{
    /#
        level thread initdevgui();
        setdvar( @"hash_949fe6b9860bd2c2", 65534 );
    #/
    
    globallogic::init();
    globallogic::setupcallbacks();
    level.callbackstartgametype = &gamelogic_br::callback_startgametype;
    level.no_winners_circle = 1;
    level.clearstockondrop = 1;
    level.disablespawncamera = 1;
    level.armoronweaponswitchlongpress = 1;
    level.dangerzoneskipequipment = 1;
    level.noweaponfalloff = 0;
    level.clampstepbulletdamage = 2;
    level.var_56856119e1f4aeab = getdvarint( @"hash_736b569488dc222c", 1 );
    level.br_allowloadout = getmatchrulesdata( "brData", "allowLoadout" );
    level.br_allowloadoutonlyinprelobby = getmatchrulesdata( "brData", "allowLoadoutPreLobbyOnly" );
    level.br_strongholds = getdvarint( @"scr_br_strongholds", 0 );
    level.var_6a8faefd19f2a7ce = getdvarint( @"hash_1a1007f742526dfd", 0 );
    level.var_2932c33578ad13e9 = getdvarint( @"hash_74c08dc52c036afa", 0 );
    level.var_20709a567373e521 = getdvarint( @"hash_586d32848f833922", 1 );
    level.var_3bf0c553963d5f37 = getdvarint( @"hash_7a1da73fa673ed8", 1 );
    level.disableprematchsuper = getdvarint( @"scr_disableprematchsuper", 0 );
    level.var_29494481caeebcbc = getdvarint( @"scr_use_playerdata_weapon_slot", 1 );
    level.var_a3f9326c4f4851ab = getdvarint( @"hash_6282debf96cfbaee", 0 );
    level.var_31797ef307bfd722 = getdvarint( @"hash_e1c7f11528b8f4fd", 0 );
    level.var_6b152f29f8944b74 = &br_default_inventory::function_c9881d78b87650af;
    level.var_20582ffa76d6281e = getdvarint( @"hash_4cc6ceeda13f1f54", 1 );
    level.var_a151dfa60c97bfc7 = getdvarint( @"hash_1ad0cd9844bd9993", 1 ) == 1;
    level.var_2e39067b524b6828 = getdvarint( @"hash_c5f7fceb072a49c4", 30 );
    level.var_3e575559a8cd5064 = utility::function_edc4cc03e9e60b3e( @"hash_5e95caf85824bb6a", 1, level.gametypebundle.var_9db300d368a77f46 ) == 1;
    utility::registersharedfunc( #"player", #"hash_c631568a218d88a6", &class::function_63f75b40675b196f );
    utility::registersharedfunc( #"player", #"hash_3f6034cbc65791c3", &class::function_11d5729edc847aa6 );
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    level.br_strongholds = istrue( level.gametypebundle.strongholdsenabled );
    level.var_4d2ffb649fcef6ea = game_utility::getgametype() != "dmz";
    allowed[ 0 ] = game_utility::getgametype();
    
    if ( allowed[ 0 ] != "br" )
    {
        allowed[ allowed.size ] = "br";
    }
    
    gameobjects::main( allowed );
    level.var_90854497526d85e2 = getdvarint( @"hash_38c2fc8b2e1387e8", 0 );
    level.var_58cdd295b0c5dafa = getdvarint( @"hash_ad47420125a85024", 0 );
    level.var_ed6ba5511b904dbd = getdvarint( @"hash_97a6fd51b5e218ee", 0 );
    
    if ( !isdefined( level.brgametype ) )
    {
        br_gametypes::init();
    }
    else
    {
        if ( isdefined( level.var_dd10333ade220938 ) )
        {
            [[ level.var_dd10333ade220938 ]]();
        }
        
        level callback::callback( "brGametypeInit" );
    }
    
    var_d10ff1e2e2827e98 = getmatchrulesdata( "brData", "giveFavoriteLoadout" );
    
    switch ( var_d10ff1e2e2827e98 )
    {
        case #"hash_d15f334d0d0b228f":
            level.var_55c170b8b6e8daa8 = 1;
            break;
        case #"hash_2edf2e1e1075edf1":
            level.var_55c170b8b6e8daa8 = 1;
            level.var_891db96300e47e39 = 1;
            break;
    }
    
    if ( level.var_55c170b8b6e8daa8 )
    {
        utility::registersharedfunc( #"gametype", #"givefavoriteloadout", &function_c83cb027f9f56818 );
    }
    
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    defineplayerloadout();
    updategametypedvars();
    parachute::initparachutedvars();
    table = level.classtablename;
    level.var_4164bb2f5bac2fb0 = 10;
    
    if ( br_gametypes::isfeatureenabled( #"prematchblueprints" ) )
    {
        level thread prematchinitblueprintloadouts();
    }
    else
    {
        prematchinitloadouts( table );
    }
    
    if ( level.br_allowloadout )
    {
        level.modeloadoutupdateammo = &brloadoutupdateammo;
        level.var_bece8079501efa50 = &function_ea36aaaded0fd51f;
        
        if ( !level.br_allowloadoutonlyinprelobby )
        {
            level.br_loadout_option = 0;
        }
        
        level.giveloadouteverytime = 1;
    }
    
    thread initsound();
    thread waitthensetstatgroupreadonly();
    level.teambased = 0;
    level.overridecrateusetime = 0.5;
    level.onplayerscore = &onplayerscore;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.modifyplayerdamage = &brmodifyplayerdamage;
    level.modifyvehicledamage = &brmodifyvehicledamage;
    level.onplayerdamaged = &onplayerdamaged;
    level.onnormaldeath = &onnormaldeath;
    level.ondeadevent = &ondeadevent;
    level.ononeleftevent = &ononeleftevent;
    level.onplayerkilled = &onplayerkilled;
    level.onsuicidedeath = &onsuicidedeath;
    level.objvisall = 1;
    level.ontimelimit = &ontimelimit;
    level.prewaitandspawnclient = &brprewaitandspawnclient;
    level.modeplayerskipdialog = &br_public::modeplayerskipdialog;
    level.allowfauxdeath = 0;
    level.var_861afd6b8f08f49a = &brendgame;
    
    if ( getdvarint( @"hash_af9925796dbfa9d", 0 ) == 1 )
    {
        level.br_endgamesplashcallback = &function_9c929d466557a460;
    }
    
    level.var_d473ce16938624c2 = &function_4388e2f9d9ab4302;
    level.var_3c4eb636fe7d9813 = &function_3c4eb636fe7d9813;
    level.var_1b5a671c7d0d6efe = &br_gametypes::isfeaturedisabled;
    level.migratespectators = &br_spectate::migratespectators;
    level.var_5bbfdd7562b793 = &function_60b79b097ebfd27f;
    level.var_b1065270f009bbf7 = &function_f5856ce19f60fb97;
    namespace_9fd3ecf626067599::registeronplayerjoinsquadcallback( &onplayerjoinsquad );
    join_team_aggregator::registeronplayerjointeamcallback( &onplayerjointeam );
    
    if ( !level.br_allowloadout && !level.var_a7f6c0960b7f13de )
    {
        level.parachutetakeweaponscb = &parachute::takeweaponsdefaultfunc;
        level.parachuterestoreweaponscb = &nakeddrop;
    }
    else
    {
        level.parachutetakeweaponscb = &parachute::takeweaponsdefaultfunc;
        level.parachuterestoreweaponscb = &loadoutdrop;
    }
    
    level.modeshoulddofauxdeathfunc = &br_respawn::playershoulddofauxdeath;
    level.modeonlaststandfunc = &br_respawn::playersetinlaststand;
    level.modeonexitlaststandfunc = &playerexitlaststand;
    level.endgame = &brendgame;
    level.laststandweaponcallback = &brchooselaststandweapon;
    level.modelaststandallowed = &modelaststandallowed;
    level.preplayerdamaged = &brpreplayerdamaged;
    level.modevalidatekillcam = &brvalidatekillcam;
    level.modespawnclient = &spawnclientbr;
    level.onsupportboxusedbyplayer = &onsupportboxusedbyplayer;
    level.onarmorboxusedbyplayer = &onarmorboxusedbyplayer;
    level.var_c70c786e914a4337 = &function_c70c786e914a4337;
    level.var_a1a56d352c70c610 = &function_a1a56d352c70c610;
    level.var_4161f6bfb35eb94e = &function_4161f6bfb35eb94e;
    level.onnewequipmentpickup = &onnewequipmentpickup;
    level.ongrenadeused = &ongrenadeused;
    level.modeplayerkilledspawn = &brplayerkilledspawn;
    level.modemayconsiderplayerdead = &brmayconsiderplayerdead;
    level.onplayerconnectstream = &onplayerconnectstream;
    level.playerisstreaming = &playerisstreaming;
    level.lastdroppableweaponchanged = &lastdroppableweaponchanged;
    level.regendelayspeedfunc = &brregendelayspeed;
    level.modeaddtoteamlives = &brmodeaddtoteamlives;
    level.moderemovefromteamlives = &brmoderemovefromteamlives;
    level.modeallowmeleevehicledamage = &modeallowmeleevehicledamage;
    level.modeignorevehicleexplosivedamage = &modeignorevehicleexplosivedamage;
    level.modevalidatekillstreakslot = &brmodevalidatekillstreakslot;
    level.var_2b99407369ed59ae = &function_2b99407369ed59ae;
    level.var_d0594eb464c4d6ee = &function_9ea6f24223d24688;
    level.var_5092ad40df5693fd = &streamhint::function_bac26315148e18d3;
    level.var_6be9e2dc9b025c26 = &function_416f972f3727d9f0;
    
    if ( !isdefined( level.modeiskillstreakallowed ) )
    {
        level.modeiskillstreakallowed = &briskillstreakallowed;
    }
    
    level.updategameevents = &br_updategameevents;
    level.checkforlaststandfinish = &br_checkforlaststandfinish;
    level.checkforlaststandwipe = &br_checkforlaststandwipe;
    level.vehicleoccupantdeathcustomcallback = &br_public::br_onvehicledeath;
    level.allowclasschoicefunc = &brallowclasschoicefunc;
    level.tacticaltimemod = dvars::dvarfloatvalue( "tacticalTimeMod", 2.5, 0.5, 5 );
    level.dontshootwhileparachuting = 1;
    level.disablecopycatloadout = 1;
    level.disableinitplayergameobjects = 1;
    level.killstreakweaponfiredcontinue = &killstreakweaponfiredcontinue;
    level.makedroneguardscrambler = 1;
    level.traceselectedmaplocation = &traceselectedmaplocation;
    level.var_760bf54d2dd70c96 = &function_43ffb50893982936;
    level.totalalivecount = 0;
    
    if ( getdvarint( @"hash_a5b745959e0e554f", 0 ) )
    {
        level.updatealiveomnvars = &function_560399c2f487a786;
    }
    else
    {
        level.updatealiveomnvars = &utility::empty_init_func;
    }
    
    if ( getdvarint( @"scr_br_prematchffa", 1 ) )
    {
        level.br_prematchffa = 1;
        
        if ( !level.var_1b5acf96f4b833d5 )
        {
            level.allowprematchdamage = 1;
        }
        
        level.recordfinalkillcam = 0;
        level.ignorescoring = 1;
        level.disableweaponstats = 1;
        level.disablestattracking = 1;
        level.prematchaddkillfunc = &brprematchaddkill;
        level.onattackerdamagenottracked = &bronattackerdamagenottracked;
        level.var_9b3243830eeafdbd = 1;
        level.numlives = 0;
    }
    
    level.var_5ece30396ddd4663 = &function_5ece30396ddd4663;
    callback::add( #"menu_class_edit", &onclasseditcallback );
    callback::add( #"player_update_played_time", &function_856b58442869a805 );
    callback::add( #"team_revive_respawn", &br_teamrevive::function_b62c1443b3c06bd6 );
    callback::add( #"hash_22f10ed00278cf01", &br_teamrevive::function_22a3e3e6a751194b );
    callback::add( #"init_shared_func", &namespace_c1ef74c9f31af95d::init );
    callback::add( #"hash_2fd481f23e5e677a", &function_f4dd45d820b8f71d );
    callback::add( #"hash_6dd1d7b87f599c7c", &function_2e8f5e082750dc17 );
    callback::add( #"cache_opened", &function_9e18e80c7af507fb );
    callback::add( #"player_match_end_analytics", &function_ddfd6706b28c96c4 );
    ui::lui_registercallback( "exit_loadout_bag", &function_dea516253845d656 );
    ui::lui_registercallback( "class_select", &function_977d10e894425865 );
    level.br_prematchloot = [];
    level.br_prematchlootparts = [];
    setomnvar( "scriptable_loot_hide", 1 );
    setomnvar( "ui_killcam_copycat", 0 );
    level.bypassclasschoicefunc = &pickclassbr;
    setomnvarforallclients( "ui_skip_loadout", 0 );
    level.assists_disabled = undefined;
    game[ "dialog" ][ "gametype" ] = "wrzn_wzan_gmty";
    game[ "dialog" ][ "offense_obj" ] = "klll_wzan_hint";
    game[ "dialog" ][ "defense_obj" ] = "hint_ffa";
    game[ "dialog" ][ "obj_extraction" ] = "objective_extraction";
    game[ "dialog" ][ "prematch_enter" ] = "prmt_wzan_gmst";
    game[ "dialog" ][ "prematch_end" ] = "prmn_wzan_gmst";
    game[ "dialog" ][ "deploy_squad_leader" ] = "dpsl_wzan_gmst";
    game[ "dialog" ][ "first_circle" ] = "crcf_wzan_gmst";
    game[ "dialog" ][ "new_circle" ] = "crcn_wzan_gmst";
    game[ "dialog" ][ "circle_closing" ] = "crrc_wzan_gmst";
    game[ "dialog" ][ "final_circle" ] = "crrf_wzan_gmst";
    game[ "dialog" ][ "last_man_standing" ] = "lsms_wzan_gmst";
    game[ "dialog" ][ "match_start" ] = "btry_wzan_gmty";
    game[ "dialog" ][ "primary_objective" ] = "btry_wzan_objt";
    game[ "dialog" ][ "supply_drop_incoming" ] = "sppd_wzan_gmst";
    game[ "dialog" ][ "team_loss" ] = "lose_wzan_gmst";
    game[ "dialog" ][ "team_victory" ] = "win1_wzan_gmst";
    game[ "dialog" ][ "top_2" ] = "tp02_wzan_gmst";
    game[ "dialog" ][ "top_3" ] = "tp03_wzan_gmst";
    game[ "dialog" ][ "top_5" ] = "tp05_wzan_gmst";
    game[ "dialog" ][ "top_10" ] = "tp10_wzan_gmst";
    game[ "dialog" ][ "top_25" ] = "tp25_wzan_gmst";
    game[ "dialog" ][ "top_50" ] = "tp50_wzan_gmst";
    game[ "dialog" ][ "top_5_lose" ] = "t05l_wzan_gmty";
    game[ "dialog" ][ "top_10_lose" ] = "t10l_wzan_gmty";
    game[ "dialog" ][ "top_25_lose" ] = "t25l_wzan_gmty";
    game[ "dialog" ][ "finish_calls" ] = "game_end_prompt_finish_calls";
    game[ "dialog" ][ "respawning_enemy_in_area" ] = "nmnr_wzan_rspw";
    game[ "dialog" ][ "br_sitrep_circle_in" ] = "rdtn_wzan_bscn";
    game[ "dialog" ][ "br_sitrep_circle_mixed" ] = "rdtn_wzan_bscm";
    game[ "dialog" ][ "br_sitrep_circle_out" ] = "rdtn_wzan_bsco";
    game[ "dialog" ][ "br_sitrep_circle_outfar" ] = "rdtn_wzan_bscf";
    level notify( #"hash_bb95e0eb0e85637" );
    level.disabledamagestattracking = 1;
    level.disabledamagestattrackingfunc = &brdisabledamagestattracking;
    level.startingspawns = [];
    level._effect[ "vfx_smk_signal" ] = loadfxasset( "vfx_requests_mp_gameplay_smoke_signal" );
    level._effect[ "vfx_smk_signal_gr" ] = loadfxasset( "vfx_requests_mp_gameplay_smoke_signal_gr" );
    level._effect[ "vfx_smk_signal_red" ] = loadfxasset( "vfx_iw8_cp_prop_smoke_signal_red" );
    level.bots_ignore_team_balance = 1;
    level.modespecificparachutecompletecb = &parachutecomplete;
    level.onfirstlandcallback = &onfirstlandcallback;
    level.squadleaderboon = getdvarint( @"hash_8ad87bd26869ec0d", 0 );
    
    if ( !isdefined( level.skipprematchdropspawn ) )
    {
        level.skipprematchdropspawn = getdvarint( @"hash_d182f4551b978e2b", 0 );
    }
    
    level.br_debugsolotest = getdvarint( @"scr_br_solo_test", 0 );
    level.var_5c17be258ea12206 = getdvarint( @"hash_732cd1e227920a87", 0 );
    
    if ( function_ee15a28564f11e4e() )
    {
        level.disableforfeit = 1;
    }
    
    level.br_infils_disabled = getdvarint( @"scr_br_infils_disable", 0 ) || br_gametypes::isfeaturedisabled( #"infil" );
    
    if ( !isdefined( level.br_circle_disabled ) )
    {
        level.br_circle_disabled = getdvarint( @"scr_br_circle_disable", 0 );
    }
    
    level.extractplunderheliinvulnerable = getdvarint( @"scr_plunder_extract_heli_invulnerable", 1 );
    level.br_ending_delay = getdvarint( @"scr_br_ending_delay", 5 );
    level.roundenddelay = 0.5;
    level.postroundtime = 9;
    level.var_a7ab4a7d847b718a = #"hash_7b291077bc2403ca";
    
    if ( !level.var_6ff1da58d8eb6fbb )
    {
        level.var_d15d8e645776c167 = 0;
    }
    
    level.playermaxheath = getmatchrulesdata( "commonOption", "maxHealth" );
    level.br_pelletmaxdamage = getdvarint( @"scr_br_pelletmaxdamage", -1 );
    level.br_pelletmaxdamagefast = getdvarint( @"scr_br_pelletmaxdamagefast", -1 );
    level.br_slugmaxdamage = getdvarint( @"scr_br_slugmaxdamage", -1 );
    level.var_415fc308a7faccd9 = getdvarint( @"inventory_backpack_size", 9 );
    level.var_34f728a694b965f7 = getdvarint( @"unified_backpack_size", 0 );
    level.var_40d8cae54a6dee6a = &function_d47075b9f5ca65ad;
    level.var_4e94f64deb0c4e18 = getdvarint( @"hash_170c10715af6a431", -1 );
    level.var_66a069174249c72b = getdvarint( @"hash_eca4cf1db65156c9", 0 );
    level.var_cc4ef85c57e9c83 = getdvarint( @"hash_ccd72baa1f9838c", 0 );
    level.var_76b3c0b7aff5a045 = getdvarint( @"hash_bb9ca2724c97686b", 1 );
    level.var_c7696bc1e0d0289e = getdvarint( @"hash_4dd57309d51b9d0a", 1 ) == 1;
    level.var_6af8c7e49b1398b2 = getdvarint( @"hash_aeb97a5fada9c62f", 1 ) == 1;
    level.var_52ec0ab267f26a6e = getdvarint( @"hash_166b51bf7450fc22", 0 ) == 0;
    level.var_9a6d992db0cf6e29 = getdvarint( @"hash_171034830e297d9d", 6 );
    level.var_fd0d570b65132e4f = getdvarint( @"hash_6132d06d6475b2e0", 1 ) == 1;
    level.var_d47d77389e8e75e2 = &function_81c3d73b94698167;
    level.getplayerbackpacksize = &common_inventory::function_9cd65c8312048802;
    level.getlootidatbackpackindex = &common_inventory::inventory_getlootidatbackpackindex;
    level.var_804be5b78f843a63 = &br_default_inventory::getquantityatbackpackindex;
    level.var_6310be831221241a = getdvarint( @"hash_66bfb6c375bbe6fa", 0 );
    level.var_a1b687d967943e5c = getdvarint( @"hash_66bfb6c375bbe6fa", 0 );
    level.finalkillcamskipteamremaining = &finalkillcamskipteamremaining;
    level.minplunderdropondeath = getmatchrulesdata( "brData", "plunderDeathDropMin" ) ?? 0;
    level.var_3e31ac1c46a58193 = getdvarint( @"hash_fce1ad7cbbea2287", 1 );
    level.var_257df25e2dcf0f03 = getdvarint( @"hash_a8b409016d9e0b43", 0 ) == 1;
    level.var_5d9949b5e09130cc = game_utility::function_bf2984e0278cf917( level.gametypebundle.var_2cacdb96fffd3b08 );
    level.var_7a699d76269b09dd = utility::function_edc4cc03e9e60b3e( @"scr_br_default_spawn_height", 14000, level.var_5d9949b5e09130cc.var_ecd4eda81de1427d );
    level.var_4000387528ae054e = utility::function_edc4cc03e9e60b3e( @"scr_br_dynamic_spawn_height_enable", 1, level.var_5d9949b5e09130cc.var_33d69b8339728f86 );
    level.var_83c0d2a5e8ba8f63 = utility::function_48f723fdc612ec65( @"scr_br_dynamic_spawn_height_reduction_percent", 0.09, level.var_ebda12b58250b203 );
    level.var_33202c0f3d019a6a = utility::function_edc4cc03e9e60b3e( @"scr_br_dynamic_spawn_height_circle_index_limit", 6, level.var_56142312bcfcdf0a );
    level.var_e2f750d22e646497 = utility::function_edc4cc03e9e60b3e( @"scr_br_dynamic_spawn_height_minimum", 6500, level.var_7acf2af51641d2b7 );
    level.var_4cfd4ec4016c4601 = getdvarint( @"hash_7c4d26c59246963e", 0 ) == 1;
    level.var_1acc5d70465c5287 = getdvarint( @"hash_7e3b597b760ba9af", 0 ) == 1;
    level.var_f23b4a10de35697 = getdvarint( @"hash_f0ca0e57f87e1c38", 0 ) == 1;
    level.throttle_dist_tracking = throttle::throttle_initialize( "dist_tracking", getdvarint( @"hash_a5863203bd890f51", 1 ) );
    level.throttle_log_starting_loadout = throttle::throttle_initialize( "log_starting_loadout", getdvarint( @"hash_7753e675e77cb21f", 1 ) );
    level.throttle_inc_rank_xp = throttle::throttle_initialize( "inc_rank_xp", getdvarint( @"hash_4261bac4ca06ff45", 1 ) );
    level.var_ea1c5851a8ccf08d = getdvarint( @"hash_e04adda70034ca31", 0 );
    level.var_261edf33a465cdf = getdvarint( @"hash_318a2cf32785dbe0", 200 );
    
    if ( common_item::items_isenabled() )
    {
        br_common_kiosk::init();
    }
    
    function_ac29aaa257cf7811();
    function_59a48af3dafdbb88();
    
    if ( !isdefined( level.br_loadout_option ) )
    {
        brinitloadoutoption();
    }
    
    br_spawnrespawn::function_aa3d7586c93300d();
    br_analytics::branalytics_init();
    br_vehicles::brvehiclesinit();
    br_infils_legacy::main();
    br_killstreaks::init();
    common_cache::function_2a790ff752bdb267( &function_e5e12e5a774d90f5 );
    var_34266094fed47bab = level.modifyplayerdamage == &brmodifyplayerdamage;
    assert( var_34266094fed47bab, "<dev string:x24>" );
    
    if ( var_34266094fed47bab )
    {
        skydive_protection::init( &brmodifyplayerdamage );
    }
    
    if ( level.br_strongholds )
    {
        thread br_strongholds::init();
    }
    else
    {
        thread function_e2227cea56b8d35e();
    }
    
    level thread br_ftue_popups::init();
    level thread namespace_c6e391ebf419f41d::init();
    
    if ( !br_gametypes::isfeaturedisabled( #"gulag" ) )
    {
        level thread namespace_a8afdcd7738e364e::function_8e7f7d52c1481618();
        level thread namespace_a974e4dd85555bc2::function_f3d31c54c906d814();
        level thread namespace_13234c7eaab1a112::function_3d61b8ff8e6c7694();
    }
    
    thread br_stealth_event_distances();
    thread function_90dbeac8877294f5();
    initializetweakableoverrides();
    entcleanup();
    level thread announceplayercountlandmarks();
    level.noinventory = getdvarint( @"hash_19fae1aad58e8c50", 0 );
    setdvarifuninitialized( @"hash_a5ab8ed6cc1b486a", 3 );
    setdvarifuninitialized( @"hash_d9b119233df13ac1", 600 );
    setdvarifuninitialized( @"hash_fdeb104ec6908df8", 600 );
    setdvarifuninitialized( @"hash_9775c39c335aab23", 600 );
    setdvar( @"hash_7b5549fcfa5138bc", 30 );
    
    /#
        if ( !isdedicatedserver() )
        {
            setdvar( @"hash_5e767ceb6b77e053", 0 );
        }
    #/
    
    br_alt_mode_shock::init();
    br_alt_mode_arcade_royale::init();
    thread br_c130airdrop::init();
    thread br_jugg_common::init();
    thread br_dev::init();
    
    if ( getdvarint( @"sv_ai_spawn_director_enabled", 0 ) == 0 )
    {
        thread ai_mp_controller::init();
    }
    
    thread initapril();
    thread function_f4ff01e34eacb2ca();
    ai_mp_controller::function_2b1cc53b284373( &function_32db763006f55e44 );
    
    if ( !utility::flag_exist( "stealth_enabled" ) )
    {
        utility::flag_init( "stealth_enabled" );
        utility::flag_init( "level_stealth_initialized" );
        utility::flag_init( "stealth_spotted" );
    }
    
    if ( getdvarint( @"scr_dmz_nukemapdataafterprematch", 1 ) == 1 )
    {
        level thread nukemapdataafterprematch();
    }
    
    utility::registersharedfunc( #"UTILITY", #"drop_to_ground", &br_public::drop_to_ground_br );
    utility::registersharedfunc( #"hud", #"showbrdmzsplash", &br_gametype_dmz::showdmzsplash );
    br_dev_phoenix::init();
    utility::registersharedfunc( #"gametype", #"hash_2329eb23ec58c745", &br_plunder::playerdropplunderondeath );
    utility::registersharedfunc( #"game", #"hash_9a424766e665a6f7", &function_6ed043163481a439 );
    utility::registersharedfunc( #"game", #"hash_bfde49be4ac35343", &br_commonitemweaponcannotdropweapon );
    utility::registersharedfunc( #"game", #"hash_f5f661388892926c", &function_17d84987a4050282 );
    utility::registersharedfunc( #"game", #"hash_897c59c034e10acb", &function_779c052686ae8325, 1 );
    
    if ( !utility::issharedfuncdefined( #"gametype", #"hash_24ecc9dd35043a79" ) )
    {
        utility::registersharedfunc( #"gametype", #"hash_24ecc9dd35043a79", &namespace_a974e4dd85555bc2::function_831861a029b85f4c, 1 );
    }
    
    if ( namespace_5ab67a14d18bea3f::function_43c57123ed24d409() )
    {
        utility::registersharedfunc( #"gametype", #"canitemfitinbackpack", &br_canitemfitinbackpack );
    }
    
    utility::registersharedfunc( #"gamemode", #"ammorestockused", &ammorestock_br::ammorestock_used );
    utility::registersharedfunc( #"game", #"hash_b6b5399db45fe301", &function_6637184afcde5ddf );
    utility::registersharedfunc( #"killstreak", #"refundkillstreak", &refundkillstreak );
    callback::add( #"vehicle_occupancy_init", &vehicle_occupancy_br::vehicle_occupancy_br_init );
    function_603ccbd541bc3151();
    callback::add( "lootcache_looted", &function_f5125ee6f75fbda9 );
    callback::add( #"hash_8daeabb90e45c6bc", &function_3675dbc7027a14f2 );
    callback::add( #"hash_906ce08d1b0ca8ce", &function_3675dbc7027a14f2 );
    callback::add( #"hash_ccb2ffae1085d28f", &function_3675dbc7027a14f2 );
    callback::add( #"hash_8c05ac10cfd33502", &function_3675dbc7027a14f2 );
    level callback::add( #"player_spawned", &on_player_spawn_reset );
    level thread hotzonepois();
    level thread br_analytics::function_c6ed0838e835cb05();
    callback::add( #"player_damaged", &function_9b69222366762863 );
    utility::flag_set( "br_init", 1 );
}

// Namespace br
// Params 0
// Checksum 0x3c619cda, Offset: 0x5b02
// Size: 0x6a2
function function_a4785bf1d05110c2()
{
    mapinfo = level.mapinfobundle ?? getmapscriptbundle();
    assert( isdefined( mapinfo ) );
    
    if ( !isdefined( level.br_level ) )
    {
        level.br_level = {};
    }
    
    level.br_level.br_corners = [];
    level.br_level.br_corners[ 0 ] = ( mapinfo.var_441f389c912865ca.x ?? 0, mapinfo.var_441f389c912865ca.y ?? 0, mapinfo.var_441f389c912865ca.z ?? 0 );
    level.br_level.br_corners[ 1 ] = ( mapinfo.var_32fdad034214bb3c.x ?? 0, mapinfo.var_32fdad034214bb3c.y ?? 0, mapinfo.var_32fdad034214bb3c.z ?? 0 );
    heightoverride = mapinfo.heightoverride;
    dvarheightoverride = getdvarint( @"scr_game_c130heightoverride", -1 );
    
    if ( dvarheightoverride != -1 )
    {
        heightoverride = dvarheightoverride;
    }
    
    br_c130::setc130heightoverrides( heightoverride, mapinfo.sealeveloverride );
    level.br_level.c130_speedoverride = mapinfo.speedoverride;
    minx = min( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] );
    maxx = max( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] );
    miny = min( level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] );
    maxy = max( level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] );
    
    if ( mapinfo.overridemapbounds )
    {
        minx = min( level.br_level.br_corners[ 0 ][ 0 ], level.br_level.br_corners[ 1 ][ 0 ] );
        maxx = max( level.br_level.br_corners[ 0 ][ 0 ], level.br_level.br_corners[ 1 ][ 0 ] );
        miny = min( level.br_level.br_corners[ 0 ][ 1 ], level.br_level.br_corners[ 1 ][ 1 ] );
        maxy = max( level.br_level.br_corners[ 0 ][ 1 ], level.br_level.br_corners[ 1 ][ 1 ] );
    }
    
    level.br_level.br_mapboundsfull = [];
    level.br_level.br_mapboundsfull[ 0 ] = ( maxx, maxy, 0 );
    level.br_level.br_mapboundsfull[ 1 ] = ( minx, miny, 0 );
    
    if ( mapinfo.var_e02ddf7fb8697d58 )
    {
        minx *= mapinfo.var_13fc1a51be561164.minx;
        maxx *= mapinfo.var_13fc1a51be561164.maxx;
        miny *= mapinfo.var_13fc1a51be561164.miny;
        maxy *= mapinfo.var_13fc1a51be561164.maxy;
    }
    else
    {
        minx *= mapinfo.var_af908f9f39f0bd88;
        maxx *= mapinfo.var_af908f9f39f0bd88;
        miny *= mapinfo.var_af908f9f39f0bd88;
        maxy *= mapinfo.var_af908f9f39f0bd88;
    }
    
    level.br_level.br_mapbounds = [];
    level.br_level.br_mapbounds[ 0 ] = ( maxx, maxy, 0 );
    level.br_level.br_mapbounds[ 1 ] = ( minx, miny, 0 );
    level.br_level.br_mapcenter = ( ( minx + maxx ) / 2, ( miny + maxy ) / 2, 0 );
    level.br_level.br_mapsize = ( abs( maxx - minx ), abs( maxy - miny ), abs( ( level.br_level.c130_heightoverride ?? 0 ) - ( level.br_level.c130_sealeveloverride ?? 0 ) ) );
    level.br_level.var_cd92896f34e2d8ef = mapinfo.var_e19d3f45bafc368f;
    level.br_level.var_7dd04763bfd623c1 = mapinfo.var_b5b42f7b65eecf19;
    level.br_level.var_a8250ecaf9608f68 = mapinfo.var_8039f4a6c04d40b9;
    level.br_level.var_b87f1926d764d03a = ( mapinfo.var_df529e0faa3a1c60.x ?? 0, mapinfo.var_df529e0faa3a1c60.y ?? 0, mapinfo.var_df529e0faa3a1c60.z ?? 0 );
    br_circle::function_cfdf3903125095d7();
    br_circle::applycirclesettings();
    
    if ( !level.br_circle_disabled && !( isdefined( level.br_level.br_circleclosetimes ) && isdefined( level.br_level.br_circledelaytimes ) && isdefined( level.br_level.br_circleshowdelaydanger ) && isdefined( level.br_level.br_circleshowdelaysafe ) && isdefined( level.br_level.br_circleminimapradii ) && isdefined( level.br_level.br_circleradii ) ) )
    {
        assertmsg( "<dev string:xa4>" );
    }
}

// Namespace br
// Params 1
// Checksum 0xc739d82, Offset: 0x61ac
// Size: 0x1e
function onclasseditcallback( params )
{
    function_cb855b2ad040737d( params.class );
}

// Namespace br
// Params 1
// Checksum 0xf2c88020, Offset: 0x61d2
// Size: 0xcb
function function_856b58442869a805( params )
{
    if ( br_public::isplayeringulag() )
    {
        self.timeplayed[ "gulag" ] = self.timeplayed[ "gulag" ] + self.timeplayed[ "game" ];
        return;
    }
    
    if ( br_public::isplayerwaitingresurgencerespawn() )
    {
        self.timeplayed[ "resurgenceRespawn" ] = self.timeplayed[ "resurgenceRespawn" ] + self.timeplayed[ "game" ];
        return;
    }
    
    if ( isdefined( self.c130 ) || self.brneverlanded )
    {
        self.timeplayed[ "infil" ] = self.timeplayed[ "infil" ] + self.timeplayed[ "game" ];
    }
}

// Namespace br
// Params 1
// Checksum 0x799d6abf, Offset: 0x62a5
// Size: 0x52, Type: bool
function function_29339c30e6d1b395( player )
{
    if ( player.pers[ "distTrackingPassed" ] )
    {
        if ( getdvarint( @"hash_b42e148f11d9d225", 0 ) == 1 )
        {
            if ( player.pers[ "passedAFKActions" ] )
            {
                return true;
            }
        }
        else
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br
// Params 0
// Checksum 0x673b5e, Offset: 0x6300
// Size: 0x454
function function_60b79b097ebfd27f()
{
    if ( self.c130 || self.brneverlanded )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    if ( self.sessionstate == "spectator" || self.sessionstate == "intermission" || self.sessionstate == "playing_but_spectating" )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    if ( br_public::isplayeringulag() || self.ffsm_isgulagrespawn )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    if ( !isdefined( self.pers[ "timePlayedOnFirstSpawn" ] ) )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    if ( mp_afk::dontconsiderafk() )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    if ( self.var_90534cd58b6798f9 )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    if ( self iscommandinputrepetitive() )
    {
        kickreason = "brCheckForAFK(): IsCommandInputRepetitive() - " + self.name;
        mp_afk::function_a710eba86b2e3782( self, kickreason, 2, 1 );
        return;
    }
    
    var_fcf0dac7fbcf7ba0 = level.var_4dd914bb587df856;
    var_a881648444e96d87 = 180;
    
    if ( self.var_64484dbc6cb3dff6 )
    {
        var_a881648444e96d87 = getdvarint( @"hash_14a16eaa061ea9ec", 60 );
    }
    else if ( self.brkickedfromplane )
    {
        var_a881648444e96d87 = getdvarint( @"hash_613644ac82dead59", 60 );
    }
    else
    {
        var_a881648444e96d87 = getdvarint( @"hash_a6a8cfe5f012e87a", 180 );
    }
    
    var_4572dd5c88d12c71 = mp_afk::function_a10af3f5e26c28da();
    
    if ( getdvarint( @"hash_b42e148f11d9d225", 0 ) == 1 )
    {
        if ( !self.pers[ "passedAFKActions" ] )
        {
            var_19eb3b30f62dd319 = var_a881648444e96d87;
            var_f6f9c024d1b11413 = mp_afk::function_3a77ec8a437459f( var_4572dd5c88d12c71, var_19eb3b30f62dd319, var_fcf0dac7fbcf7ba0 );
            
            if ( var_f6f9c024d1b11413 == 2 )
            {
                kickreason = "brCheckForAFK(): AFK Action System - " + self.name + " timePlayedSec(" + var_4572dd5c88d12c71 + ") >= afkActionTimeThresholdSec(" + var_19eb3b30f62dd319 + ")";
                mp_afk::function_a710eba86b2e3782( self, kickreason, 2, 1 );
                return;
            }
        }
    }
    
    if ( self.pers[ "distTrackingPassed" ] || ( self.var_186c72a9d88370e7 ?? 0 ) > gettime() )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    if ( !isdefined( self.pers[ "killsSinceLastAFKCheck" ] ) )
    {
        mp_afk::function_9592b6d120cfac02();
    }
    
    kills = self.pers[ "kills" ] - self.pers[ "killsSinceLastAFKCheck" ];
    
    if ( kills > 0 )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    downs = self.pers[ "downs" ] - self.pers[ "downsSinceLastAFKCheck" ];
    
    if ( downs > 0 )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    assists = self.pers[ "assists" ] - self.pers[ "assistsSinceLastAFKCheck" ];
    
    if ( assists > 0 )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    var_31649686e47da1ff = self.pers[ "distTrackingPassedOrResetTime" ] ?? 0;
    var_41bb640befb8c8a2 = var_4572dd5c88d12c71 - var_31649686e47da1ff;
    
    if ( self iscommandinputstale() && self.sessionstate == "playing" )
    {
        afkstate = mp_afk::function_3a77ec8a437459f( var_41bb640befb8c8a2, var_a881648444e96d87, var_fcf0dac7fbcf7ba0 );
        kickreason = undefined;
        
        if ( afkstate == 2 )
        {
            kickreason = "brCheckForAFK(): IsCommandInputStale() - " + self.name;
            mp_afk::function_a710eba86b2e3782( self, kickreason, afkstate, 1 );
            return;
        }
    }
    
    if ( self.var_c38ca5641e393f49 >= 3 )
    {
        mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
        return;
    }
    
    if ( self.pers[ "lastDamageTime" ] )
    {
        recentdamagestate = mp_afk::function_3a77ec8a437459f( gettime() - self.pers[ "lastDamageTime" ], 60000, var_fcf0dac7fbcf7ba0 * 1000 );
        
        if ( recentdamagestate == 0 )
        {
            mp_afk::function_a710eba86b2e3782( self, undefined, 0, 0 );
            return;
        }
    }
    
    kickreason = undefined;
    afkstate = mp_afk::function_3a77ec8a437459f( var_41bb640befb8c8a2, var_a881648444e96d87, var_fcf0dac7fbcf7ba0 );
    
    if ( afkstate == 2 )
    {
        kickreason = "brCheckForAFK(): Timeout - " + self.name + " - timeSinceLastPassedDistCheckSec(" + var_41bb640befb8c8a2 + ") >= afkTimeThresholdSec(" + var_a881648444e96d87 + ")";
    }
    
    mp_afk::function_a710eba86b2e3782( self, kickreason, afkstate, 1 );
}

// Namespace br
// Params 0, eflags: 0x4
// Checksum 0x7d295935, Offset: 0x675c
// Size: 0xec
function private init_currency()
{
    if ( utility::callsharedfunc( #"br", #"hash_424c76fef63e7847" ) )
    {
        utility::callsharedfunc( #"br", #"hash_4d3de9d92532e9d" );
        return;
    }
    
    utility::registersharedfunc( #"points", #"hash_baeedb15f9b11623", &br_get_currency );
    utility::registersharedfunc( #"points", #"set_currency", &function_b08d416503035ea7 );
    utility::registersharedfunc( #"points", #"take_currency", &function_3217a8ed05a17a16 );
    utility::registersharedfunc( #"points", #"add_currency", &br_add_currency );
    callback::add( #"player_connect", &init_cash_currency );
    currency::register_currency_type( #"cash", &br_get_currency, &function_b08d416503035ea7, &br_add_currency, &function_3217a8ed05a17a16, undefined, undefined );
}

// Namespace br
// Params 1, eflags: 0x4
// Checksum 0x3697d5a7, Offset: 0x6850
// Size: 0x4e
function private init_cash_currency( params )
{
    startingamount = 0;
    
    if ( getdvarint( @"hash_d5d3cbbdd6f5454b", 0 ) > 0 )
    {
        startingamount = getdvarint( @"hash_d5d3cbbdd6f5454b", 0 );
    }
    
    currency::init_player_currency( #"cash", startingamount );
}

// Namespace br
// Params 0
// Checksum 0x45dfd790, Offset: 0x68a6
// Size: 0x33
function br_get_currency()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !common_item::items_isenabled() )
    {
        return self.plundercount;
    }
    
    return self.currency[ #"cash" ];
}

// Namespace br
// Params 1
// Checksum 0x989e4d15, Offset: 0x68e2
// Size: 0x178
function br_add_currency( amount )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !common_item::items_isenabled() )
    {
        self.plundercount += amount;
        return;
    }
    
    params = spawnstruct();
    params.amount = amount;
    params.originaltotal = self.currency[ #"cash" ];
    newtotal = minint( self.currency[ #"cash" ] + amount, level.br_plunder.plunderlimit );
    self.currency[ #"cash" ] = newtotal;
    self.plundercount = self.currency[ #"cash" ];
    cash::playersetplunderomnvar( self.currency[ #"cash" ] );
    
    if ( isbot( self ) || isautopilot( self ) )
    {
        if ( isdefined( self._blackboard ) )
        {
            self._blackboard.var_2b77845002145c3a = self.currency[ #"cash" ];
        }
    }
    
    params.currenttotal = self.currency[ #"cash" ];
    thread gameplay_telemetry::function_383cde919fd850c4( "cash_earned", 2, amount );
    callback::callback( "br_currency_changed", params );
}

// Namespace br
// Params 1
// Checksum 0x8a0647eb, Offset: 0x6a62
// Size: 0xd1
function function_b08d416503035ea7( amount )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !common_item::items_isenabled() )
    {
        self.plundercount = amount;
        return;
    }
    
    params = spawnstruct();
    params.amount = amount;
    params.originaltotal = self.currency[ #"cash" ];
    self.currency[ #"cash" ] = amount;
    self.plundercount = amount;
    cash::playersetplunderomnvar( self.currency[ #"cash" ] );
    params.currenttotal = self.currency[ #"cash" ];
    callback::callback( "br_currency_changed", params );
}

// Namespace br
// Params 1
// Checksum 0x6b55ec72, Offset: 0x6b3b
// Size: 0x115
function function_3217a8ed05a17a16( amount )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !common_item::items_isenabled() )
    {
        self.plundercount -= amount;
        
        if ( self.plundercount < 0 )
        {
            self.plundercount = 0;
        }
        
        return;
    }
    
    params = spawnstruct();
    params.amount = amount;
    params.originaltotal = self.currency[ #"cash" ];
    amount = self.currency[ #"cash" ] - amount;
    
    if ( amount < 0 )
    {
        amount = 0;
    }
    
    self.currency[ #"cash" ] = amount;
    self.plundercount = amount;
    cash::playersetplunderomnvar( self.currency[ #"cash" ] );
    params.currenttotal = self.currency[ #"cash" ];
    callback::callback( "br_currency_changed", params );
}

/#

    // Namespace br
    // Params 0, eflags: 0x4
    // Checksum 0x7433cb6d, Offset: 0x6c58
    // Size: 0x12, Type: dev
    function private initdevgui()
    {
        wait 1;
        adddebugcommand( "<dev string:x134>" );
    }

#/

// Namespace br
// Params 0
// Checksum 0xfe5cb492, Offset: 0x6c72
// Size: 0x1b
function function_603ccbd541bc3151()
{
    level.var_10cdddd9174f6d1c = istrue( getdvarint( @"hash_2e5b8ec324d79730", 1 ) );
}

// Namespace br
// Params 0
// Checksum 0x29389087, Offset: 0x6c95
// Size: 0x7b
function initsound()
{
    gametype = game_utility::getgametype();
    mapname = game_utility::getmapname();
    level.nosuspensemusic = 1;
    waittillframeend();
    thread music_and_dialog::stopsuspensemusic();
    
    if ( gametype != "dmz" )
    {
        audio_utility::snd_transient_load( "mp_gamemode_br" );
    }
    
    if ( level.gametype == "bongo" )
    {
        audio_utility::snd_transient_load( "saw_gametype_bongo_override" );
        return;
    }
    
    audio_utility::snd_transient_load( "wz2_s3_overrides" );
}

// Namespace br
// Params 0
// Checksum 0xd3abcea, Offset: 0x6d18
// Size: 0xf
function function_90dbeac8877294f5()
{
    level waittill( #"infils_ready" );
}

// Namespace br
// Params 0
// Checksum 0x4b21195, Offset: 0x6d2f
// Size: 0x358
function br_stealth_event_distances()
{
    if ( !getdvarint( @"activewarzone_enabled", 0 ) )
    {
        return;
    }
    
    level waittill( #"infils_ready" );
    function_f750be7c4e3a297b( "br_saba_aieventlist" );
    array[ "spotted" ][ "ally_damaged" ] = 512;
    array[ "hidden" ][ "ally_damaged" ] = 512;
    array[ "spotted" ][ "ally_hurt_peripheral" ] = 512;
    array[ "hidden" ][ "ally_hurt_peripheral" ] = 512;
    array[ "spotted" ][ "ally_killed" ] = 256;
    array[ "hidden" ][ "ally_killed" ] = 256;
    array[ "spotted" ][ "attack" ] = 512;
    array[ "hidden" ][ "attack" ] = 512;
    array[ "spotted" ][ "object_impact" ] = 128;
    array[ "hidden" ][ "object_impact" ] = 128;
    array[ "spotted" ][ "death" ] = 256;
    array[ "hidden" ][ "death" ] = 128;
    array[ "spotted" ][ "decoy_grenade" ] = 256;
    array[ "hidden" ][ "decoy_grenade" ] = 128;
    array[ "spotted" ][ "defaultevent" ] = 256;
    array[ "hidden" ][ "defaultevent" ] = 128;
    array[ "spotted" ][ "door_bash" ] = 512;
    array[ "hidden" ][ "door_bash" ] = 256;
    array[ "spotted" ][ "explosion" ] = 256;
    array[ "hidden" ][ "explosion" ] = 128;
    array[ "spotted" ][ "footstep" ] = 180;
    array[ "hidden" ][ "footstep" ] = 180;
    array[ "spotted" ][ "footstep_walk" ] = 180;
    array[ "hidden" ][ "footstep_walk" ] = 180;
    array[ "spotted" ][ "footstep_sprint" ] = 360;
    array[ "hidden" ][ "footstep_sprint" ] = 240;
    array[ "spotted" ][ "glass_destroyed" ] = 384;
    array[ "hidden" ][ "glass_destroyed" ] = 256;
    array[ "spotted" ][ "grenade danger" ] = 256;
    array[ "hidden" ][ "grenade danger" ] = 128;
    array[ "spotted" ][ "grenade_ping" ] = 256;
    array[ "hidden" ][ "grenade_ping" ] = 128;
    array[ "spotted" ][ "gunshot" ] = 960;
    array[ "hidden" ][ "gunshot" ] = 480;
    array[ "spotted" ][ "gunshot_impact" ] = 240;
    array[ "hidden" ][ "gunshot_impact" ] = 180;
    array[ "spotted" ][ "gunshot_teammate" ] = 256;
    array[ "hidden" ][ "gunshot_teammate" ] = 256;
    array[ "spotted" ][ "pain" ] = 256;
    array[ "hidden" ][ "pain" ] = 128;
    array[ "spotted" ][ "projectile_impact" ] = 256;
    array[ "hidden" ][ "projectile_impact" ] = 256;
    array[ "spotted" ][ "silenced_shot_impact" ] = 64;
    array[ "hidden" ][ "silenced_shot_impact" ] = 64;
    array[ "spotted" ][ "throwingknife_impact" ] = 96;
    array[ "hidden" ][ "throwingknife_impact" ] = 96;
    array[ "spotted" ][ "window_open" ] = 128;
    array[ "hidden" ][ "window_open" ] = 0;
    stealth_manager::set_event_distances( array );
}

// Namespace br
// Params 0
// Checksum 0x531cb737, Offset: 0x708f
// Size: 0x36
function waitthensetstatgroupreadonly()
{
    self endon( #"game_ended" );
    wait 1;
    
    if ( isdefined( level.playerstats ) )
    {
        playerstats_interface::makeplayerstatgroupreadonly( "losses" );
        playerstats_interface::makeplayerstatgroupreadonly( "winLoss" );
    }
}

// Namespace br
// Params 0
// Checksum 0x9b05176d, Offset: 0x70cd
// Size: 0x69
function entcleanup()
{
    for ( i = 1; i < 10 ; i++ )
    {
        _delete_ents( "script_noteworthy", "locale_" + i );
    }
    
    _delete_ents( "script_noteworthy", "locale_99" );
    
    if ( getdvarint( @"hash_38828aebce9812f2", 1 ) == 1 )
    {
        game_utility::removematchingents_bykey( "volume_covergen_exclusion", "classname" );
    }
}

// Namespace br
// Params 2
// Checksum 0x121cc236, Offset: 0x713e
// Size: 0x34
function _delete_ents( key, value )
{
    ents = getentarray( value, key );
    utility::array_call( ents, &delete );
}

// Namespace br
// Params 2
// Checksum 0xf4a02a82, Offset: 0x717a
// Size: 0x4a3
function initstandardloadout( tablename, classindex )
{
    numloadouts = class::function_868832c7872f848e( tablename );
    assert( classindex < numloadouts );
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    loadout[ "loadoutPrimary" ] = class::table_getitem( tablename, classindex ).primaryweapon.weapon;
    loadout[ "loadoutPrimaryAttachment" ] = class::table_getitem( tablename, classindex ).primaryweapon.attachment1;
    loadout[ "loadoutPrimaryAttachment2" ] = class::table_getitem( tablename, classindex ).primaryweapon.attachment2;
    loadout[ "loadoutPrimaryAttachment3" ] = class::table_getitem( tablename, classindex ).primaryweapon.attachment3;
    loadout[ "loadoutPrimaryAttachment4" ] = class::table_getitem( tablename, classindex ).primaryweapon.attachment4;
    loadout[ "loadoutPrimaryAttachment5" ] = class::table_getitem( tablename, classindex ).primaryweapon.attachment5;
    loadout[ "loadoutPrimaryCamo" ] = class::table_getitem( tablename, classindex ).primaryweapon.camo;
    loadout[ "loadoutPrimaryReticle" ] = class::table_getitem( tablename, classindex ).primaryweapon.reticle;
    loadout[ "loadoutSecondary" ] = class::table_getitem( tablename, classindex ).secondaryweapon.weapon;
    loadout[ "loadoutSecondaryAttachment" ] = class::table_getitem( tablename, classindex ).secondaryweapon.attachment1;
    loadout[ "loadoutSecondaryAttachment2" ] = class::table_getitem( tablename, classindex ).secondaryweapon.attachment2;
    loadout[ "loadoutSecondaryAttachment3" ] = class::table_getitem( tablename, classindex ).secondaryweapon.attachment3;
    loadout[ "loadoutSecondaryAttachment4" ] = class::table_getitem( tablename, classindex ).secondaryweapon.attachment4;
    loadout[ "loadoutSecondaryAttachment5" ] = class::table_getitem( tablename, classindex ).secondaryweapon.attachment5;
    loadout[ "loadoutSecondaryCamo" ] = class::table_getitem( tablename, classindex ).secondaryweapon.camo;
    loadout[ "loadoutSecondaryReticle" ] = class::table_getitem( tablename, classindex ).secondaryweapon.reticle;
    loadout[ "loadoutTertiary" ] = class::table_getitem( tablename, classindex ).tertiaryWeapon.weapon;
    loadout[ "loadoutTertiaryCamo" ] = class::table_getitem( tablename, classindex ).tertiaryWeapon.camo;
    loadout[ "loadoutTertiaryReticle" ] = class::table_getitem( tablename, classindex ).tertiaryWeapon.reticle;
    loadout[ "loadoutMeleeSlot" ] = "none";
    loadout[ "loadoutEquipmentPrimary" ] = class::table_getitem( tablename, classindex ).equipment.primary;
    loadout[ "loadoutEquipmentSecondary" ] = class::table_getitem( tablename, classindex ).equipment.secondary;
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = "super_ammo_drop";
    loadout[ "loadoutPerks" ] = [ class::table_getitem( tablename, classindex ).perks.perk1, class::table_getitem( tablename, classindex ).perks.perk2, class::table_getitem( tablename, classindex ).perks.perk3, class::table_getitem( tablename, classindex ).extraperks.perk1, class::table_getitem( tablename, classindex ).extraperks.perk2, class::table_getitem( tablename, classindex ).extraperks.perk3 ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "loadoutFieldUpgrade1" ] = "none";
    loadout[ "loadoutFieldUpgrade2" ] = "none";
    loadout[ "tableColumn" ] = classindex;
    return loadout;
}

// Namespace br
// Params 3
// Checksum 0x66331a86, Offset: 0x7626
// Size: 0xdf
function givestandardtableloadout( classindex, quickloadout, noextraammo )
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_6c05b3acbd2dd56b" ) )
    {
        argsstruct = utility::callsharedfunc( #"gametype", #"hash_6c05b3acbd2dd56b" );
        standardloadout = argsstruct.respawnloadout;
        noextraammo = argsstruct.noextraammo;
        quickloadout = argsstruct.quickloadout;
    }
    else
    {
        if ( !isdefined( level.br_standard_loadout ) )
        {
            level.br_standard_loadout = initstandardloadout( level.classtablename, classindex );
            assert( isdefined( level.br_standard_loadout ) );
        }
        
        standardloadout = level.br_standard_loadout;
    }
    
    function_52bb5fd0b7a29e12( standardloadout, quickloadout, noextraammo );
}

// Namespace br
// Params 3
// Checksum 0xb6427c27, Offset: 0x770d
// Size: 0x11c
function function_52bb5fd0b7a29e12( standardloadout, quickloadout, noextraammo )
{
    self.pers[ "gamemodeLoadout" ] = arraycopy( standardloadout );
    self.class = "gamemode";
    self.prevweaponobj = undefined;
    utility::callsharedfunc( #"personal_weapons", #"hash_49417c39456a188c", { #class:self.class } );
    struct = class::loadout_getclassstruct();
    struct = class::loadout_updateclass( struct, "gamemode" );
    class::preloadandqueueclassstruct( struct, 1, 1 );
    self takeallweapons();
    class::giveloadout( self.team, "gamemode", quickloadout, quickloadout, undefined, undefined, noextraammo );
    
    if ( isdefined( struct.loadoutprimaryobject ) )
    {
        self givestartammo( struct.loadoutprimaryobject );
    }
    
    if ( isdefined( struct.loadoutsecondaryobject ) )
    {
        self givestartammo( struct.loadoutsecondaryobject );
    }
    
    givelaststandifneeded( self );
    self notify( #"ammo_update" );
}

// Namespace br
// Params 0
// Checksum 0x79be59a7, Offset: 0x7831
// Size: 0xb8
function function_1d024eb81dd3ec49()
{
    classtables = class::function_8cc2758f17a3d70a( #"headless" );
    
    if ( classtables.size == 0 )
    {
        class::preloadandqueueclass( self.class, 1 );
        thread class::swaploadout();
        inventory_utility::_takeweapon( level.defaultfist );
        return;
    }
    
    var_26b91ec76275c797 = randomint( classtables.size );
    classtablename = classtables[ var_26b91ec76275c797 ].bundle;
    numloadouts = class::function_868832c7872f848e( classtablename );
    randomloadoutindex = randomint( numloadouts );
    standardloadout = initstandardloadout( classtablename, randomloadoutindex );
    function_52bb5fd0b7a29e12( standardloadout );
}

// Namespace br
// Params 0
// Checksum 0xdc5dda47, Offset: 0x78f1
// Size: 0x1a1
function nakeddrophandleloadout()
{
    if ( function_19ef84cc9d20f71() )
    {
        if ( utility::issharedfuncdefined( #"gametype", #"givefavoriteloadout" ) )
        {
            utility::callsharedfunc( #"gametype", #"givefavoriteloadout" );
        }
        else
        {
            respawnloadout = br_spawnrespawn::function_a4305f2e039b471e();
            level.br_standard_loadout = respawnloadout[ 0 ];
            noextraammo = respawnloadout[ 1 ];
            givestandardtableloadout( 0, 1, noextraammo );
        }
        
        return;
    }
    
    if ( brdoesloadoutoptiongivestandardloadoutimmediately() )
    {
        quickloadout = 0;
        
        if ( self.hasspawnweapons )
        {
            return;
        }
        
        var_66dfc6a2a7eb8e29 = isdefined( self.hasspawnweapons ) && !self.hasspawnweapons;
        
        if ( var_66dfc6a2a7eb8e29 )
        {
            quickloadout = 1;
        }
        
        loadoutindex = brgetloadoutoptionstandardloadoutindex();
        givestandardtableloadout( loadoutindex, quickloadout );
        
        if ( isbrgamemode() && !level.var_dd8633765c6a1db9 && getdvarint( @"hash_1ca10ca828658cf7", 1 ) == 1 )
        {
            var_c21d9d544e0d1923 = getmatchrulesdata( "commonOption", "infilArmor" );
            infilreserveplates = getmatchrulesdata( "commonOption", "infilReservePlates" );
            armor::givestartingarmor( var_c21d9d544e0d1923, infilreserveplates );
        }
        
        if ( var_66dfc6a2a7eb8e29 )
        {
            self.hasspawnweapons = 1;
        }
        
        return;
    }
    
    if ( brdoesloadoutoptionusedropbags() )
    {
        givematchloadoutfordropbags();
        return;
    }
    
    if ( brdoesloadoutoptiongivecustomweaponsimmediately() )
    {
        ammomult = brgetloadoutammomultiplier();
        ammomax = brgetloadoutammomax();
        givematchloadout( ammomult, ammomax );
    }
}

// Namespace br
// Params 0
// Checksum 0x6ed101b5, Offset: 0x7a9a
// Size: 0x2e
function isinstancedspace()
{
    if ( !isdefined( level.is_instanced_space ) )
    {
        level.is_instanced_space = getdvarint( @"hash_741256d4a75b3e28", 0 );
    }
    
    return level.is_instanced_space;
}

// Namespace br
// Params 0
// Checksum 0xa734ef6d, Offset: 0x7ad1
// Size: 0x55
function function_a4e03dfaa3f6a302()
{
    if ( !isbot( self ) )
    {
        assertmsg( "<dev string:x147>" );
        return;
    }
    
    utility::callsharedfunc( #"gametype", #"playerdropbonuses" );
    self.var_e6ac0a1f19668b8e = 1;
    function_af48c5a61b4c073b();
    self.var_e6ac0a1f19668b8e = undefined;
    function_b965062c0e3e525f();
}

// Namespace br
// Params 0
// Checksum 0xc4962f5d, Offset: 0x7b2e
// Size: 0xf3
function nakeddrop()
{
    if ( manager::function_aac2f27c8c7188b2() )
    {
        logstring( "Ignore the nakedDrop as loadout has been pre-given to " + self.name );
        return;
    }
    
    utility::callsharedfunc( #"gametype", #"playerdropbonuses" );
    var_73f8d07d1dece4fd = br_gulag::gulagwinnerrestoreloadout();
    
    if ( !var_73f8d07d1dece4fd && level.br_prematchstarted && !self.gulag )
    {
        if ( getdvarint( @"hash_4799897b190d65", 1 ) && isdmzgamemode() )
        {
            if ( utility::issharedfuncdefined( #"inventory", #"isbackpackinventoryenabled" ) && [[ utility::getsharedfunc( #"inventory", #"isbackpackinventoryenabled" ) ]]() )
            {
                for ( packitemindex = 0; packitemindex < common_inventory::function_9cd65c8312048802() ; packitemindex++ )
                {
                    br_default_inventory::function_39f0833282ad6f6( packitemindex );
                }
            }
        }
        
        function_af48c5a61b4c073b();
    }
    
    function_b965062c0e3e525f();
}

// Namespace br
// Params 0
// Checksum 0x746a15d6, Offset: 0x7c29
// Size: 0x89
function function_af48c5a61b4c073b()
{
    if ( self isplayerheadless() )
    {
        if ( utility::issharedfuncdefined( #"gametype", #"hash_1ca6f9c7ab29f828" ) )
        {
            utility::callsharedfunc( #"gametype", #"hash_1ca6f9c7ab29f828" );
        }
        else
        {
            function_1d024eb81dd3ec49();
        }
        
        return;
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"playernakeddroploadout" ) )
    {
        utility::callsharedfunc( #"gametype", #"playernakeddroploadout" );
        return;
    }
    
    nakeddrophandleloadout();
}

// Namespace br
// Params 0
// Checksum 0x323669af, Offset: 0x7cba
// Size: 0x5c
function function_b965062c0e3e525f()
{
    if ( br_default_inventory::isbackpackinventoryenabled() && getdvarint( @"hash_68a323d5bd07266c", 0 ) == 1 )
    {
        br_default_inventory::function_86f211f994ea95a3( "brloot_nvg" );
    }
    
    if ( getdvarint( @"hash_422a89a3665fcbbb", 1 ) == 1 )
    {
        function_675d16974324587b( self );
    }
    
    self notify( #"naked_spawn" );
    thread br_displayperkinfo();
}

// Namespace br
// Params 0
// Checksum 0xe3cdf7b6, Offset: 0x7d1e
// Size: 0x1c6
function loadoutdrop()
{
    if ( manager::function_aac2f27c8c7188b2() )
    {
        logstring( "Ignore the loadoutDrop as loadout has been pre-given to " + self.name );
        return;
    }
    
    utility::callsharedfunc( #"gametype", #"playerdropbonuses" );
    
    if ( self.isredeploykeepweapons )
    {
        self.isredeploykeepweapons = undefined;
        return;
    }
    
    class = self.class;
    
    if ( self.initiallandingcomplete && !level.giveloadouteverytime )
    {
        self.pers[ "gamemodeLoadout" ] = level.br_respawn_loadout;
        class = "gamemode";
    }
    
    class::preloadandqueueclass( class, 1 );
    thread class::swaploadout();
    
    if ( class != "gamemode" )
    {
        inventory_utility::_takeweapon( level.defaultfist );
    }
    
    self.tokenrespawned = 0;
    
    if ( !self.prematchintiallandingcomplete || getdvarint( @"hash_2a9b84e756b256c6", 1 ) )
    {
        if ( level.giveloadouteverytime )
        {
            thread brgivestartfieldupgrade();
        }
    }
    
    self.prematchintiallandingcomplete = 1;
    
    if ( !self.initiallandingcomplete )
    {
        if ( level.br_prematchstarted )
        {
            if ( level.giveloadouteverytime )
            {
                thread brgivestartfieldupgrade();
            }
            
            self.initiallandingcomplete = 1;
        }
    }
    
    if ( isbrgamemode() && getdvarint( @"hash_1ca10ca828658cf7", 1 ) == 1 )
    {
        var_4b0b17846cf1e4e1 = getmatchrulesdata( "commonOption", "respawnArmor" );
        respawnreserveplates = getmatchrulesdata( "commonOption", "respawnReservePlates" );
        armor::givestartingarmor( var_4b0b17846cf1e4e1, respawnreserveplates );
    }
    
    if ( getdvarint( @"hash_422a89a3665fcbbb", 1 ) == 1 )
    {
        function_675d16974324587b( self );
    }
    
    thread br_displayperkinfo();
}

// Namespace br
// Params 4
// Checksum 0x8b2d93b4, Offset: 0x7eec
// Size: 0x29a
function function_abafdefb2f831e7b( cratemover, player, updist = 75, downdist = -75 )
{
    contents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
    watercontents = trace::function_bbd81e56529ef225();
    contents &= ~watercontents;
    crateradius = 70;
    toplayerorigin = player.origin - cratemover.origin;
    var_42a9700c022b6f83 = ( toplayerorigin[ 0 ], toplayerorigin[ 1 ], 0 );
    toplayeryaw = 0;
    
    if ( length2d( var_42a9700c022b6f83 ) > 0.001 )
    {
        var_b980be662f7f9c1b = vectornormalize( var_42a9700c022b6f83 );
        toplayerangles = vectortoangles( var_b980be662f7f9c1b );
        toplayeryaw = angleclamp180( toplayerangles[ 1 ] );
    }
    
    crateorigin = cratemover.origin;
    traceoffset = ( cos( toplayeryaw ), sin( toplayeryaw ), 0 );
    traceoffset = vectornormalize( traceoffset );
    traceoffset *= crateradius;
    result = br_public::raytraceoffset( crateorigin, traceoffset[ 0 ], traceoffset[ 1 ], updist, downdist, contents, cratemover );
    
    if ( result[ "fraction" ] < 1 && result[ "normal" ][ 2 ] > 0 )
    {
        safepoint = result[ "position" ] + ( 0, 0, 0.001 );
        walltracestart = crateorigin + ( 0, 0, 30 );
        walltraceresult = trace::ray_trace( walltracestart, safepoint, cratemover, contents );
        
        if ( walltraceresult[ "fraction" ] >= 1 )
        {
            function_dc3fc3f13189a1fd( cratemover, player, safepoint );
            player setorigin( safepoint );
            return;
        }
    }
    
    result = br_public::raytraceoffset( crateorigin, 0, 0, updist, downdist, contents );
    
    if ( result[ "fraction" ] < 1 && result[ "normal" ][ 2 ] > 0 )
    {
        clearstartpoint = result[ "position" ] + ( 0, 0, 0.2 );
        clearendpoint = result[ "position" ] + ( 0, 0, 1 );
        cleartracepoint = playerphysicstrace( clearstartpoint, clearendpoint );
        
        if ( cleartracepoint == clearendpoint )
        {
            function_dc3fc3f13189a1fd( cratemover, player, result[ "position" ] );
            player setorigin( result[ "position" ] );
            return;
        }
    }
    
    player kill( cratemover.origin );
}

// Namespace br
// Params 3
// Checksum 0xb3fc0f4c, Offset: 0x818e
// Size: 0xfe
function function_dc3fc3f13189a1fd( cratemover, player, teleportposition )
{
    displacementsqr = distancesquared( player.origin, teleportposition );
    
    if ( !isdefined( level.var_261edf33a465cdf ) )
    {
        level.var_261edf33a465cdf = getdvarint( @"hash_318a2cf32785dbe0", 200 );
    }
    
    if ( displacementsqr > level.var_261edf33a465cdf * level.var_261edf33a465cdf )
    {
        logstring( "[CRATE_COL_TELEPORT]: Player significantly displaced by unresolved crate collision teleport. " + "Player: " + player.name + ", " + "displacement: " + sqrt( displacementsqr ) + ", " + "playerPos: " + player.origin + ", " + "teleportPos: " + teleportposition + ", " + "cratePos: " + cratemover.origin + ", " + "crateType: " + cratemover.cratetype );
    }
}

// Namespace br
// Params 0
// Checksum 0x3c46198f, Offset: 0x8294
// Size: 0x87
function brgivestartfieldupgrade()
{
    level endon( #"prematch_done" );
    self endon( #"death_or_disconnect" );
    
    if ( level.disableprematchsuper )
    {
        return;
    }
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    self waittill( #"parachute_landed" );
    
    if ( level.allowsupers )
    {
        super = supers_mp::getcurrentsuper();
        
        if ( isdefined( super ) )
        {
            supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded() );
        }
        
        return;
    }
    
    item_super::function_ea946b46f6cd671f( self.loadoutbrfieldupgrade );
}

// Namespace br
// Params 2
// Checksum 0xc9b60b66, Offset: 0x8323
// Size: 0x7a, Type: bool
function brplayerhudoutlineforteammatessafe( player, otherplayer )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !isalive( player ) )
    {
        return false;
    }
    
    if ( player.gulag )
    {
        return false;
    }
    
    if ( !isdefined( player.team ) )
    {
        return false;
    }
    
    if ( isdefined( otherplayer ) && otherplayer.team != player.team )
    {
        return false;
    }
    
    if ( otherplayer == player )
    {
        return false;
    }
    
    return true;
}

// Namespace br
// Params 1
// Checksum 0x2adb2fc8, Offset: 0x83a6
// Size: 0x1de
function brplayerhudoutlineforteammatesupdate( player )
{
    if ( !( isdefined( player ) && isdefined( player.sessionuimemberindex ) && isdefined( player.teammateoutlineids ) ) )
    {
        return;
    }
    
    playersquad = teams::getfriendlyplayers( player.team, 1 );
    assetname = "outline_nodepth_brplayer" + player.sessionuimemberindex + 1;
    distmax = getdvarint( @"hash_4530f1e48da9e83a", 1024 );
    var_c1a0a4ed85558615 = squared( distmax );
    playerisvalid = brplayerhudoutlineforteammatessafe( player );
    
    foreach ( teammate in playersquad )
    {
        entnum = teammate getentitynumber();
        var_dc950e1898e8ced6 = playerisvalid && brplayerhudoutlineforteammatessafe( teammate, player );
        
        if ( var_dc950e1898e8ced6 )
        {
            dist = distancesquared( player.origin, teammate.origin );
            
            if ( dist > var_c1a0a4ed85558615 )
            {
                var_dc950e1898e8ced6 = 0;
            }
        }
        
        if ( !var_dc950e1898e8ced6 )
        {
            if ( isdefined( player.teammateoutlineids[ entnum ] ) )
            {
                outline::outlinedisable( player.teammateoutlineids[ entnum ], player );
                player.teammateoutlineids[ entnum ] = undefined;
            }
            
            continue;
        }
        
        if ( !isdefined( player.teammateoutlineids[ entnum ] ) )
        {
            player.teammateoutlineids[ entnum ] = outline::outlineenableforplayer( player, teammate, assetname, "level_script" );
        }
    }
}

// Namespace br
// Params 1
// Checksum 0xe221d035, Offset: 0x858c
// Size: 0x37
function brplayerhudoutlineupdatefromnotify( player )
{
    player endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"hash_7f6b2a7b2d05df3e" );
        brplayerhudoutlineforteammatesupdate( player );
    }
}

// Namespace br
// Params 1
// Checksum 0x4d0b389b, Offset: 0x85cb
// Size: 0x70
function brplayerhudoutlineforteammates( player )
{
    player endon( #"disconnect" );
    
    if ( !isdefined( player.sessionuimemberindex ) )
    {
        return;
    }
    
    if ( !level.br_infils_disabled )
    {
        player waittill( #"infil_jump_done" );
    }
    
    player.teammateoutlineids = [];
    player thread brplayerhudoutlineupdatefromnotify( player );
    
    while ( true )
    {
        brplayerhudoutlineforteammatesupdate( player );
        wait 1;
    }
}

// Namespace br
// Params 0
// Checksum 0x1d6123ae, Offset: 0x8643
// Size: 0x2
function initializetweakableoverrides()
{
    
}

// Namespace br
// Params 0
// Checksum 0x710ed2c3, Offset: 0x864d
// Size: 0x80
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    dvars::function_99012ab10f8154de( "brData", "brLoadouts" );
    dvars::function_99012ab10f8154de( "brData", "crateDropTimer" );
    dvars::function_99012ab10f8154de( "brData", "infilC130" );
    dvars::function_99012ab10f8154de( "brData", "gulag" );
    dvars::function_99012ab10f8154de( "brData", "circleDamageMultiplier" );
    dvars::function_99012ab10f8154de( "brData", "startingWeapon" );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "promode" ), 0 );
}

// Namespace br
// Params 0
// Checksum 0xca298264, Offset: 0x86d5
// Size: 0xf9
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.numendgame = dvars::dvarintvalue( "numEndGame", 4, 0, 20 );
    level.brloadouts = dvars::dvarintvalue( "brLoadouts", 0, 0, 5 );
    level.cratedroptimer = dvars::dvarintvalue( "crateDropTimer", 60, 0, 300 );
    level.goalenabletimer = dvars::dvarfloatvalue( "goalEnableTimer", 60, 0, 300 );
    level.goalmovetimer = dvars::dvarfloatvalue( "goalMoveTimer", 0, 0, 300 );
    level.radarendgame = dvars::dvarfloatvalue( "radarEndGame", 1, 0, 1 );
    level.usegulag = dvars::dvarintvalue( "gulag", 1, 0, 1 );
    level.circledamagemultiplier = dvars::dvarfloatvalue( "circleDamageMultiplier", 1, 0.5, 4 );
    level.startingweapon = dvars::dvarintvalue( "startingWeapon", 0, 0, 8 );
    level.timetoadd = 30;
}

// Namespace br
// Params 0
// Checksum 0x5f065a30, Offset: 0x87d6
// Size: 0xbd
function pickclassbr()
{
    class = "";
    
    if ( !level.br_prematchstarted && level.br_prematchffa && gamelogic_mp::inprematch() )
    {
        class = pickprematchrandomloadout();
    }
    else
    {
        pickedloadout = level.br_loadouts[ "default" ];
        
        if ( utility::issharedfuncdefined( #"gametype", #"getdefaultloadout" ) )
        {
            pickedloadout = utility::callsharedfunc( #"gametype", #"getdefaultloadout" );
        }
        
        self.pers[ "gamemodeLoadout" ] = pickedloadout;
        class = "gamemode";
    }
    
    self.pers[ "class" ] = class;
    return class;
}

// Namespace br
// Params 0
// Checksum 0xe6dde48, Offset: 0x889c
// Size: 0x1c
function brallowclasschoicefunc()
{
    if ( level.br_allowloadout && !br_public::function_379fb7b09f4ef13e() )
    {
        return 1;
    }
}

// Namespace br
// Params 0
// Checksum 0xc511c3af, Offset: 0x88c0
// Size: 0x136
function function_b6d5e1addb3751c8()
{
    wait 5;
    iprintln( "Loadout verification starting in 10 seconds." );
    wait 5;
    iprintln( "5 seconds to start." );
    wait 5;
    iprintln( "Verification start!" );
    
    for ( testindex = 0; testindex < level.var_4164bb2f5bac2fb0 ; testindex++ )
    {
        iprintln( "Loadout: " + testindex );
        self.pers[ "gamemodeLoadout" ] = level.prematchloadouts[ level.prematchrandomloadout[ testindex ] ];
        self.class = "gamemode";
        class::preloadandqueueclass( self.pers[ "class" ] );
        class::swaploadout();
        br_weapons::br_ammo_player_max_out();
        wait 5;
        inventory_utility::_switchtoweapon( self.secondaryweapon );
        wait 4;
    }
    
    self.pers[ "gamemodeLoadout" ] = level.prematchloadouts[ level.prematchrandomloadout[ 0 ] ];
    self.class = "gamemode";
    class::preloadandqueueclass( self.pers[ "class" ] );
    class::swaploadout();
    br_weapons::br_ammo_player_max_out();
    iprintln( "Verification done!" );
}

// Namespace br
// Params 0
// Checksum 0xa3e9e761, Offset: 0x89fe
// Size: 0x43
function function_8e34b266371e3c8d()
{
    if ( self isplayerheadless() )
    {
        if ( self.pers[ "gamemodeLoadout" ][ "loadoutEquipmentPrimary" ] == "equip_molotov" )
        {
            self.pers[ "gamemodeLoadout" ][ "loadoutEquipmentPrimary" ] = "equip_frag";
        }
    }
}

// Namespace br
// Params 0
// Checksum 0xb6a9dd7f, Offset: 0x8a49
// Size: 0x1a3
function pickprematchrandomloadout()
{
    class = "";
    
    if ( getdvarint( @"hash_c7eeced4234b1158", 1 ) )
    {
        if ( !isdefined( level.prematchrandomloadout ) )
        {
            level.prematchrandomloadout = [];
            
            for ( index = 0; index < level.var_4164bb2f5bac2fb0 ; index++ )
            {
                level.prematchrandomloadout[ level.prematchrandomloadout.size ] = index;
            }
            
            if ( getdvar( @"hash_fc5f34b202c7515e", "" ) == "" && getdvarint( @"hash_8fd5e2fbd99396a4", 0 ) == 0 )
            {
                level.prematchrandomloadout = arrayrandomize( level.prematchrandomloadout );
            }
            
            self.prematchloadoutindex = level.var_4164bb2f5bac2fb0 - 2;
        }
        
        if ( !isdefined( self.prematchloadoutindex ) || self.prematchloadoutindex < 0 || self.prematchloadoutindex >= level.var_4164bb2f5bac2fb0 - 1 )
        {
            self.prematchloadoutindex = 0;
        }
        else
        {
            self.prematchloadoutindex++;
        }
        
        assert( level.prematchloadouts[ level.prematchrandomloadout[ self.prematchloadoutindex ] ][ "<dev string:x16f>" ] != "<dev string:x17e>", "<dev string:x17f>" );
        self.pers[ "gamemodeLoadout" ] = level.prematchloadouts[ level.prematchrandomloadout[ self.prematchloadoutindex ] ];
        class = "gamemode";
        function_8e34b266371e3c8d();
    }
    else
    {
        class = "default" + randomint( 10 ) + 1;
    }
    
    return class;
}

// Namespace br
// Params 0
// Checksum 0xd4214bae, Offset: 0x8bf5
// Size: 0x10c
function prematchinitblueprintloadouts()
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.weaponmapdata ) )
    {
        waitframe();
    }
    
    level.prematchloadouts = [];
    buildingarray = [];
    buildingarray[ "classIdxPrimaryArray" ] = [];
    buildingarray[ "classIdxSecondaryArray" ] = [];
    
    /#
        classidx = getdvarint( @"hash_a1967148d48b7992", -1 );
        
        if ( classidx >= 0 )
        {
            level.prematchloadouts[ level.prematchloadouts.size ] = updateprematchloadoutarray( level.classtablename, classidx, classidx );
            return;
        }
    #/
    
    buildingarray = buildloadoutindices( buildingarray );
    
    for ( var_1388710c3c36451 = 0; var_1388710c3c36451 < buildingarray[ "classIdxPrimaryArray" ].size ; var_1388710c3c36451++ )
    {
        primaryindex = buildingarray[ "classIdxPrimaryArray" ][ var_1388710c3c36451 ];
        secondaryindex = buildingarray[ "classIdxSecondaryArray" ][ var_1388710c3c36451 ];
        level.prematchloadouts[ level.prematchloadouts.size ] = updateprematchloadoutarray( level.classtablename, primaryindex, secondaryindex );
    }
}

// Namespace br
// Params 1
// Checksum 0x596670e7, Offset: 0x8d09
// Size: 0x1be
function buildloadoutindices( buildingarray )
{
    var_a4eb9d8dcba15349 = 0;
    var_dbff6b03580df0d4 = 2;
    var_b516f7de0241090e = 2;
    var_f3ddb087bc1505ff = 1;
    var_1901c9fefc3d8128 = 1;
    var_f50de991eca89fe3 = 2;
    var_a03d18dd497de370 = 2;
    allloadouts = [ var_dbff6b03580df0d4, var_b516f7de0241090e, var_f3ddb087bc1505ff, var_1901c9fefc3d8128, var_f50de991eca89fe3, var_a03d18dd497de370 ];
    
    while ( var_a4eb9d8dcba15349 < allloadouts.size )
    {
        var_b3f1d3684ac2b740 = 0;
        retry = 0;
        maxtry = 5;
        
        while ( var_b3f1d3684ac2b740 < allloadouts[ var_a4eb9d8dcba15349 ] )
        {
            var_1aeca48d6711b1ed = giverandomloadoutindex( var_a4eb9d8dcba15349 );
            
            if ( !arraycontains( buildingarray[ "classIdxPrimaryArray" ], var_1aeca48d6711b1ed ) || retry >= maxtry )
            {
                var_b3f1d3684ac2b740++;
                retry = 0;
                buildingarray[ "classIdxPrimaryArray" ][ buildingarray[ "classIdxPrimaryArray" ].size ] = var_1aeca48d6711b1ed;
                continue;
            }
            
            retry++;
        }
        
        var_a4eb9d8dcba15349++;
    }
    
    var_7456a4f403374ee4 = 0;
    
    for ( secondarycounter = 0; secondarycounter < buildingarray[ "classIdxPrimaryArray" ].size ; secondarycounter++ )
    {
        if ( var_7456a4f403374ee4 < 3 )
        {
            if ( randomint( 4 ) == 1 )
            {
                var_a9b14308a8d2b999 = giverandomloadoutindex( 6 );
            }
            else
            {
                var_a9b14308a8d2b999 = giverandomloadoutindex( 5 );
            }
            
            var_7456a4f403374ee4++;
        }
        else
        {
            var_a9b14308a8d2b999 = giverandomloadoutindex( 7 );
        }
        
        buildingarray[ "classIdxSecondaryArray" ][ buildingarray[ "classIdxSecondaryArray" ].size ] = var_a9b14308a8d2b999;
    }
    
    buildingarray[ "classIdxPrimaryArray" ] = arrayrandomize( buildingarray[ "classIdxPrimaryArray" ] );
    buildingarray[ "classIdxSecondaryArray" ] = arrayrandomize( buildingarray[ "classIdxSecondaryArray" ] );
    return buildingarray;
}

// Namespace br
// Params 1
// Checksum 0x7e010655, Offset: 0x8ed0
// Size: 0x10d
function giverandomloadoutindex( index )
{
    chosenindex = 0;
    
    switch ( index )
    {
        case 0:
            chosenindex = 0 + randomint( 10 );
            break;
        case 1:
            chosenindex = 10 + randomint( 7 );
            break;
        case 2:
            chosenindex = 23 + randomint( 5 );
            break;
        case 3:
            chosenindex = 28 + randomint( 8 );
            break;
        case 4:
            chosenindex = 36 + randomint( 6 );
            break;
        case 5:
            chosenindex = randomint( 42 );
            break;
        case 6:
            chosenindex = 42 + randomint( 3 );
            break;
        case 7:
            chosenindex = 17 + randomint( 6 );
            break;
        default:
            assertmsg( "<dev string:x1cd>" );
            break;
    }
    
    return chosenindex;
}

// Namespace br
// Params 3
// Checksum 0x89c98fa7, Offset: 0x8fe6
// Size: 0x41e
function updateprematchloadoutarray( table, primaryindex, secondaryindex )
{
    if ( primaryindex == secondaryindex )
    {
        if ( secondaryindex > 0 )
        {
            secondaryindex--;
        }
        else
        {
            secondaryindex = 1;
        }
    }
    
    loadoutarray = [];
    loadoutarray[ "loadoutArchetype" ] = "archetype_assault";
    loadoutarray[ "loadoutPrimaryAttachment" ] = "none";
    loadoutarray[ "loadoutPrimaryAttachment2" ] = "none";
    loadoutarray[ "loadoutPrimaryAttachment3" ] = "none";
    loadoutarray[ "loadoutPrimaryAttachment4" ] = "none";
    loadoutarray[ "loadoutPrimaryAttachment5" ] = "none";
    loadoutarray[ "loadoutPrimaryCosmeticAttachment" ] = "none";
    loadoutarray[ "loadoutPrimarySticker" ] = "sticker_none";
    loadoutarray[ "loadoutPrimarySticker1" ] = "sticker_none";
    loadoutarray[ "loadoutPrimarySticker2" ] = "sticker_none";
    loadoutarray[ "loadoutPrimarySticker3" ] = "sticker_none";
    loadoutarray[ "loadoutSecondary" ] = "none";
    loadoutarray[ "loadoutSecondaryAttachment" ] = "none";
    loadoutarray[ "loadoutSecondaryAttachment2" ] = "none";
    loadoutarray[ "loadoutSecondaryAttachment3" ] = "none";
    loadoutarray[ "loadoutSecondaryAttachment4" ] = "none";
    loadoutarray[ "loadoutSecondaryAttachment5" ] = "none";
    loadoutarray[ "loadoutSecondarySticker" ] = "sticker_none";
    loadoutarray[ "loadoutSecondarySticker1" ] = "sticker_none";
    loadoutarray[ "loadoutSecondarySticker2" ] = "sticker_none";
    loadoutarray[ "loadoutSecondarySticker3" ] = "sticker_none";
    loadoutarray[ "loadoutSecondarySticker4" ] = "sticker_none";
    loadoutarray[ "loadoutMeleeSlot" ] = "none";
    loadoutarray[ "loadoutStreakType" ] = "assault";
    loadoutarray[ "loadoutKillstreak1" ] = "none";
    loadoutarray[ "loadoutKillstreak2" ] = "none";
    loadoutarray[ "loadoutKillstreak3" ] = "none";
    loadoutarray[ "loadoutSuper" ] = "none";
    loadoutarray[ "loadoutFieldUpgrade1" ] = "none";
    loadoutarray[ "loadoutFieldUpgrade2" ] = "none";
    loadoutarray[ "tableColumn" ] = primaryindex;
    loadoutarray[ "loadoutPrimary" ] = class::table_getweapon( table, primaryindex, 0 );
    wildcard = class::function_6e209ed6e2db2b0b( table, primaryindex );
    maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        attachstring = class::getattachmentloadoutstring( attachmentindex, #"primary" );
        loadoutarray[ attachstring ] = class::table_getweaponattachment( table, primaryindex, 0, attachmentindex );
    }
    
    loadoutarray[ "loadoutPrimaryCamo" ] = class::table_getweaponcamo( table, primaryindex, 0 );
    loadoutarray[ "loadoutPrimaryReticle" ] = class::table_getweaponreticle( table, primaryindex, 0 );
    loadoutarray[ "loadoutPrimaryVariantID" ] = class::table_getweaponvariantid( table, primaryindex, 0, loadoutarray[ "loadoutPrimary" ] );
    loadoutarray[ "loadoutSecondary" ] = class::table_getweapon( table, secondaryindex, 0 );
    wildcard = class::function_6e209ed6e2db2b0b( table, secondaryindex );
    maxsecondaryattachments = weapon::getmaxsecondaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
    {
        attachstring = class::getattachmentloadoutstring( attachmentindex, #"secondary" );
        loadoutarray[ attachstring ] = class::table_getweaponattachment( table, secondaryindex, 0, attachmentindex );
    }
    
    loadoutarray[ "loadoutSecondaryCamo" ] = class::table_getweaponcamo( table, secondaryindex, 0 );
    loadoutarray[ "loadoutSecondaryReticle" ] = class::table_getweaponreticle( table, secondaryindex, 0 );
    loadoutarray[ "loadoutSecondaryVariantID" ] = class::table_getweaponvariantid( table, secondaryindex, 0, loadoutarray[ "loadoutSecondary" ] );
    loadoutarray[ "loadoutEquipmentPrimary" ] = getrandomprematchequipment( "lethal" );
    
    if ( utility::cointoss() )
    {
        loadoutarray[ "loadoutExtraEquipmentPrimary" ] = "TRUE";
    }
    else
    {
        loadoutarray[ "loadoutExtraEquipmentPrimary" ] = "FALSE";
    }
    
    loadoutarray[ "loadoutEquipmentSecondary" ] = getrandomprematchequipment( "tactical" );
    
    if ( loadoutarray[ "loadoutEquipmentSecondary" ] != "equip_smoke" && utility::cointoss() )
    {
        loadoutarray[ "loadoutExtraEquipmentSecondary" ] = "TRUE";
    }
    else
    {
        loadoutarray[ "loadoutExtraEquipmentSecondary" ] = "FALSE";
    }
    
    loadoutarray[ "loadoutPerks" ] = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        perk = class::table_getperk( table, primaryindex, i );
        
        if ( perk != "specialty_null" )
        {
            loadoutarray[ "loadoutPerks" ][ loadoutarray[ "loadoutPerks" ].size ] = perk;
        }
    }
    
    loadoutarray[ "loadoutGesture" ] = "playerData";
    loadoutarray[ "loadoutExecution" ] = "playerData";
    return loadoutarray;
}

// Namespace br
// Params 2
// Checksum 0x7959fd09, Offset: 0x940d
// Size: 0x3bb
function updatex1prematchloadoutarray( table, loadoutidx )
{
    loadoutarray = [];
    loadoutarray[ "loadoutArchetype" ] = "archetype_assault";
    loadoutarray[ "loadoutPrimaryAttachment" ] = "none";
    loadoutarray[ "loadoutPrimaryAttachment2" ] = "none";
    loadoutarray[ "loadoutPrimaryAttachment3" ] = "none";
    loadoutarray[ "loadoutPrimaryAttachment4" ] = "none";
    loadoutarray[ "loadoutPrimaryAttachment5" ] = "none";
    loadoutarray[ "loadoutPrimaryCosmeticAttachment" ] = "none";
    loadoutarray[ "loadoutPrimarySticker" ] = "sticker_none";
    loadoutarray[ "loadoutPrimarySticker1" ] = "sticker_none";
    loadoutarray[ "loadoutPrimarySticker2" ] = "sticker_none";
    loadoutarray[ "loadoutPrimarySticker3" ] = "sticker_none";
    loadoutarray[ "loadoutSecondary" ] = "none";
    loadoutarray[ "loadoutSecondaryAttachment" ] = "none";
    loadoutarray[ "loadoutSecondaryAttachment2" ] = "none";
    loadoutarray[ "loadoutSecondaryAttachment3" ] = "none";
    loadoutarray[ "loadoutSecondaryAttachment4" ] = "none";
    loadoutarray[ "loadoutSecondaryAttachment5" ] = "none";
    loadoutarray[ "loadoutSecondarySticker" ] = "sticker_none";
    loadoutarray[ "loadoutSecondarySticker1" ] = "sticker_none";
    loadoutarray[ "loadoutSecondarySticker2" ] = "sticker_none";
    loadoutarray[ "loadoutSecondarySticker3" ] = "sticker_none";
    loadoutarray[ "loadoutSecondarySticker4" ] = "sticker_none";
    loadoutarray[ "loadoutMeleeSlot" ] = "none";
    loadoutarray[ "loadoutStreakType" ] = "assault";
    loadoutarray[ "loadoutKillstreak1" ] = "none";
    loadoutarray[ "loadoutKillstreak2" ] = "none";
    loadoutarray[ "loadoutKillstreak3" ] = "none";
    loadoutarray[ "loadoutSuper" ] = "none";
    loadoutarray[ "loadoutFieldUpgrade1" ] = "none";
    loadoutarray[ "loadoutFieldUpgrade2" ] = "none";
    loadoutarray[ "tableColumn" ] = loadoutidx;
    loadoutarray[ "loadoutPrimary" ] = class::table_getweapon( table, loadoutidx, 0 );
    wildcard = class::function_6e209ed6e2db2b0b( table, loadoutidx );
    maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        attachstring = class::getattachmentloadoutstring( attachmentindex, #"primary" );
        loadoutarray[ attachstring ] = class::table_getweaponattachment( table, loadoutidx, 0, attachmentindex );
    }
    
    loadoutarray[ "loadoutPrimaryCamo" ] = class::table_getweaponcamo( table, loadoutidx, 0 );
    loadoutarray[ "loadoutPrimaryReticle" ] = class::table_getweaponreticle( table, loadoutidx, 0 );
    loadoutarray[ "loadoutPrimaryVariantID" ] = class::table_getweaponvariantid( table, loadoutidx, 0, loadoutarray[ "loadoutPrimary" ] );
    loadoutarray[ "loadoutSecondary" ] = class::table_getweapon( table, loadoutidx, 1 );
    maxsecondaryattachments = weapon::getmaxsecondaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
    {
        attachstring = class::getattachmentloadoutstring( attachmentindex, #"secondary" );
        loadoutarray[ attachstring ] = class::table_getweaponattachment( table, loadoutidx, 1, attachmentindex );
    }
    
    loadoutarray[ "loadoutSecondaryCamo" ] = class::table_getweaponcamo( table, loadoutidx, 1 );
    loadoutarray[ "loadoutSecondaryReticle" ] = class::table_getweaponreticle( table, loadoutidx, 1 );
    loadoutarray[ "loadoutSecondaryVariantID" ] = int( tablelookup( table, 0, "loadoutSecondaryVariantID", loadoutidx + 1 ) );
    loadoutarray[ "loadoutEquipmentPrimary" ] = tablelookup( table, 0, "loadoutEquipmentPrimary", loadoutidx + 1 );
    
    if ( utility::cointoss() )
    {
        loadoutarray[ "loadoutExtraEquipmentPrimary" ] = "TRUE";
    }
    else
    {
        loadoutarray[ "loadoutExtraEquipmentPrimary" ] = "FALSE";
    }
    
    loadoutarray[ "loadoutEquipmentSecondary" ] = tablelookup( table, 0, "loadoutEquipmentSecondary", loadoutidx + 1 );
    
    if ( loadoutarray[ "loadoutEquipmentSecondary" ] != "equip_smoke" && utility::cointoss() )
    {
        loadoutarray[ "loadoutExtraEquipmentSecondary" ] = "TRUE";
    }
    else
    {
        loadoutarray[ "loadoutExtraEquipmentSecondary" ] = "FALSE";
    }
    
    loadoutarray[ "loadoutPerks" ] = [];
    loadoutarray[ "loadoutGesture" ] = "playerData";
    loadoutarray[ "loadoutExecution" ] = "playerData";
    return loadoutarray;
}

// Namespace br
// Params 1
// Checksum 0x62969309, Offset: 0x97d1
// Size: 0x106
function getrandomprematchequipment( slot )
{
    equipmentarray = [];
    assert( isdefined( slot ), "<dev string:x1e9>" );
    
    if ( slot == "lethal" )
    {
        equipmentarray = [ "equip_at_mine", "equip_claymore", "equip_c4", "equip_frag", "equip_molotov", "equip_semtex", "equip_thermite", "equip_throwing_knife", "equip_throwing_knife_fire", "equip_throwing_knife_electric" ];
    }
    else if ( slot == "tactical" )
    {
        equipmentarray = [ "equip_adrenaline", "equip_concussion", "equip_decoy", "equip_flash", "equip_gas_grenade", "equip_smoke", "equip_snapshot_grenade" ];
    }
    else
    {
        assertmsg( "<dev string:x213>" );
    }
    
    equipment = equipmentarray[ randomint( equipmentarray.size ) ];
    return equipment;
}

// Namespace br
// Params 1
// Checksum 0x6b76ef6a, Offset: 0x98e0
// Size: 0x1cb
function prematchinitloadouts( table )
{
    var_2f4e6505b731029a = class::function_868832c7872f848e( table );
    level.prematchloadouts = [];
    loadoutset = 0;
    
    if ( getdvar( @"hash_fc5f34b202c7515e", "" ) != "" )
    {
        debugloadouts = strtok( getdvar( @"hash_fc5f34b202c7515e" ), " " );
        intloadouts = [];
        
        for ( debugindex = 0; debugindex < debugloadouts.size ; debugindex++ )
        {
            intloadouts[ intloadouts.size ] = int( debugloadouts[ intloadouts.size ] );
        }
        
        for ( intindex = 0; intindex < intloadouts.size ; intindex++ )
        {
            level.prematchloadouts[ level.prematchloadouts.size ] = initstandardloadout( table, intloadouts[ intindex ] );
        }
        
        level.var_4164bb2f5bac2fb0 = intloadouts.size;
        return;
    }
    else if ( getdvarint( @"hash_c7eeced4234b1158", 1 ) )
    {
        if ( getdvarint( @"hash_8fd5e2fbd99396a4", 0 ) == 1 && getdvarint( @"hash_b1d09189d817146", -1 ) == -1 )
        {
            loadoutset = 0;
        }
        else
        {
            loadoutset = int( randomint( var_2f4e6505b731029a - 1 ) * 0.1 ) * 10;
            
            if ( getdvarint( @"hash_b1d09189d817146", -1 ) != -1 )
            {
                loadoutset = getdvarint( @"hash_b1d09189d817146", -1 );
            }
            
            var_42dbec6f10f35988 = loadoutset + 10;
            var_2f4e6505b731029a = int( min( var_2f4e6505b731029a, var_42dbec6f10f35988 ) );
        }
        
        level.var_4164bb2f5bac2fb0 = var_2f4e6505b731029a;
    }
    
    for ( classindex = loadoutset; classindex < var_2f4e6505b731029a ; classindex++ )
    {
        level.prematchloadouts[ level.prematchloadouts.size ] = initstandardloadout( table, classindex );
    }
}

// Namespace br
// Params 0
// Checksum 0x2dc5faa3, Offset: 0x9ab3
// Size: 0x2ed
function defineplayerloadout()
{
    level.br_loadouts[ "default" ][ "loadoutArchetype" ] = "archetype_assault";
    level.br_loadouts[ "default" ][ "loadoutPrimary" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutPrimaryAttachment" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutPrimaryCamo" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutPrimaryReticle" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSecondary" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSecondaryAttachment" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSecondaryCamo" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSecondaryReticle" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutMeleeSlot" ] = level.defaultfist.basename;
    level.br_loadouts[ "default" ][ "loadoutEquipmentPrimary" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutEquipmentSecondary" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutStreakType" ] = "assault";
    level.br_loadouts[ "default" ][ "loadoutKillstreak1" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutKillstreak2" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutKillstreak3" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutSuper" ] = "super_ammo_drop";
    level.br_loadouts[ "default" ][ "loadoutPerks" ] = [ "specialty_null" ];
    level.br_loadouts[ "default" ][ "loadoutGesture" ] = "playerData";
    level.br_loadouts[ "default" ][ "loadoutFieldUpgrade1" ] = "none";
    level.br_loadouts[ "default" ][ "loadoutFieldUpgrade2" ] = "none";
    level.br_loadouts[ "allies" ] = level.br_loadouts[ "default" ];
    level.br_loadouts[ "axis" ] = level.br_loadouts[ "default" ];
    level.br_respawn_loadout = level.br_loadouts[ "default" ];
    level.br_respawn_loadout[ "loadoutSecondary" ] = "jup_cp24_pi_glima21";
}

// Namespace br
// Params 0
// Checksum 0x20fddb1, Offset: 0x9da8
// Size: 0x105
function onprecachegametype()
{
    level._effect[ "vfx_gas_ring_player" ] = loadfxasset( "vfx_iw8_cp_br_ring_gas_player" );
    level._effect[ "vfx_gas_ring_puffy" ] = loadfxasset( "vfx_iw8_cp_br_ring_gas_puffy" );
    level._effect[ "vfx_gas_mask_break" ] = loadfxasset( "vfx_iw8_br_gameplay_gasmask_dest" );
    level._effect[ "vfx_gameplay_tier2_helmet_pop" ] = loadfxasset( "vfx_iw9_gameplay_mp_tier2_helmet_pop" );
    level._effect[ "vfx_gameplay_tier3_helmet_pop" ] = loadfxasset( "vfx_iw9_gameplay_mp_tier3_helmet_pop" );
    
    if ( br_alt_mode_shock::function_480f16a04286f001() )
    {
        level._effect[ "vfx_lightning_zaps_main" ] = loadfxasset( "vfx_iw9_gameplay_mp_lightning_zaps_main" );
        level._effect[ "vfx_lightning_zaps_impact" ] = loadfxasset( "vfx_iw9_gameplay_mp_lightning_zaps_impact" );
        level._effect[ "vfx_lightning_zaps_flare_ch" ] = loadfxasset( "vfx_iw9_gameplay_mp_lightning_zaps_flare_ch" );
        level._effect[ "vfx_lightning_zaps_trail_ch" ] = loadfxasset( "vfx_iw9_gameplay_mp_lightning_zaps_trail_ch" );
        level._effect[ "vfx_lightning_zaps_screen_1p" ] = loadfxasset( "vfx_iw9_gameplay_mp_lightning_zaps_screen_1p" );
    }
}

// Namespace br
// Params 0
// Checksum 0x4d2b03dd, Offset: 0x9eb5
// Size: 0x605
function onstartgametype()
{
    println( "<dev string:x243>" );
    utility::callsharedfunc( #"gametype", #"onstartgametypepre" );
    level.graceperiod = 3;
    level.ingraceperiod = level.graceperiod;
    level.prematchperiodend = 0;
    
    if ( isdefined( level.var_7fa88e51e3c2f8dc ) )
    {
        level.prematchperiodend = level.var_7fa88e51e3c2f8dc;
    }
    
    br_default_inventory::function_3c3f2e6d975dc468();
    setclientnamemode( "auto_change" );
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/dm" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/dm" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/dm_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/dm_hint" );
    }
    
    initspawns();
    br_publicevents::init();
    utility::flag_set( "public_event_init_attempted" );
    
    if ( !isdefined( level.br_multi_circle.circles[ 0 ].circlecenters ) )
    {
        br_circle::initcircle();
    }
    
    br_weapons::br_ammo_init();
    br_c130::init();
    level thread br_functional_poi::init();
    
    if ( getdvarint( @"scr_disable_br_callouts", 0 ) != 1 )
    {
        br_callouts::init();
    }
    
    thread br_contract_manager::function_2c05e0c3d3568609();
    br_events::breventsinit();
    br_challenges::init();
    br_supply_drops::init();
    loot::init();
    level thread barter_system::init();
    init_currency();
    level.br_crates = [];
    level.var_e091695dc2372402 = [];
    br_gulag::initgulag();
    utility::registersharedfunc( #"br", #"superslotcleanup", &common_inventory::function_38ff1a66cd956902 );
    utility::registersharedfunc( #"br", #"challengeevaluator", &br_challenges::challengeevaluator );
    utility::registersharedfunc( #"airdrop", #"registercrateforcleanup", &airdrop_registercrateforcleanup );
    utility::registersharedfunc( #"airdrop", #"unregistercrateforcleanup", &function_a006ede6fbe57ff8 );
    utility::registersharedfunc( #"airdrop", #"bronloadoutcratedestroyed", &airdrop_bronloadoutcratedestroyed );
    utility::registersharedfunc( #"gasmask", #"breakgasmaskbr", &item_gasmask::function_417db22e0343b00a );
    utility::registersharedfunc( #"backpack", #"removesmallestitemstackbackpack", &br_default_inventory::removesmallestitemstackbackpack );
    utility::registersharedfunc( #"backpack", #"additemtobackpackbyref", &br_default_inventory::additemtobackpackbyref );
    utility::registersharedfunc( #"backpack", #"gettotalitemcountinbag", &br_default_inventory::gettotalitemcountinbag );
    utility::registersharedfunc( #"br", #"isinstancedspace", &isinstancedspace );
    utility::registersharedfunc( #"gametype", #"packclientmatchdata", &br_packclientmatchdata );
    utility::registersharedfunc( #"gametype", #"hash_344ee3ce3711e38c", &function_7e7b2e900be477ae );
    utility::registersharedfunc( #"popsmoke", #"deploy", &popsmoke::popsmoke_deploy );
    utility::registersharedfunc( #"outline", #"outlineenableforteam", &outline::outlineenableforteam );
    utility::registersharedfunc( #"audio", #"hash_671f2d06615c8a65", &br_public::brleaderdialogteam );
    utility::registersharedfunc( #"br", #"hash_ccc082092db526b8", &br_public::updatebrscoreboardstat );
    utility::registersharedfunc( #"br", #"hash_665b0dffeda837cd", &calculateclientmatchdataextrainfopayload );
    utility::registersharedfunc( #"dmz", #"didExtractWithWeaponCase", &dmz_weapon_case::didextractwithweaponcase );
    utility::registersharedfunc( #"laststand", #"hash_2eede4e4383aa6a2", &laststand::updatesquadmemberlaststandreviveprogress );
    utility::registersharedfunc( #"telemetry", #"hash_c2ff97bbe61f0a3f", &function_5b5db9dfa00f69eb, 1 );
    callback::add( #"on_ping", &function_f8d4f0e87b5151be );
    
    if ( team_assimilation::function_8fe74e094005f15d() )
    {
        level thread team_assimilation::init();
    }
    
    initloot();
    tripwire::init();
    
    if ( isdefined( level.var_d2a069e71fe9643b ) )
    {
        [[ level.var_d2a069e71fe9643b ]]();
    }
    
    ai_sentry_turret::init();
    fire_traps::init();
    level thread onprematchstarted();
    thread turnofftimer();
    level thread watchprematchdone();
    level thread br_vehicles::brvehiclesonstartgametype();
    namespace_6fe0f1cba107e99::init();
    
    if ( game_utility::getgametype() == "dmz" )
    {
        level.mrapspawns = vehicle_spawn::get_spawn_structs( %"hash_3585a3d351c5e6ff" );
        namespace_6fe0f1cba107e99::spawnpalfa();
        br_gametype_dmz::function_6a8ba004c43e487e();
    }
    
    thread waitandstartparachuteoverheadmonitoring();
    
    if ( getdvarint( @"hash_183efaf41e5dc7a6", 0 ) == 0 )
    {
        level thread updateplayerlocationcallouts();
    }
    
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    disconnect_event_aggregator::function_f460203966e88ab0( &function_8906dfc9917bf7b );
    lui_game_event_aggregator::registeronluieventcallback( &handleexitsquadeliminatedstate );
    
    if ( loot_mp::function_1c8bb57e5f495dec() )
    {
        lui_game_event_aggregator::registeronluieventcallback( &loot_mp::function_1cb8c3d990595192 );
    }
    
    level.var_f0eb3711b5eb893 = [];
    callback::add( #"player_vehicle_enter", &function_606c40fc1dfe6f64 );
    callback::add( #"player_vehicle_seat_switch", &function_606c40fc1dfe6f64 );
    
    if ( brdoesloadoutoptionusedropbags() )
    {
        thread br_rewards::initdropbagsystem();
        thread cleanupdropbagsoncircle();
    }
    
    level.killstreakbeginusefunc = &brkillstreakbeginusefunc;
    br_fogofwar::init();
    level callback::callback( #"register_activity_variant_definitions" );
    utility::callsharedfunc( #"gametype", #"hash_e1a48c13a7e1e696" );
    function_2fc8850df08f1103();
}

// Namespace br
// Params 0
// Checksum 0x3903584f, Offset: 0xa4c2
// Size: 0xd2
function function_2fc8850df08f1103()
{
    if ( getdvarint( @"hash_4d33368b232fe205", 1 ) == 0 )
    {
        return;
    }
    
    foreach ( name, leveldata in level.cratedata.configs )
    {
        if ( name == "airdrop_deployable_kiosk" || name == "airdrop_loadout_crate" || name == "airdrop_deployable_kiosk_lightweight" )
        {
            leveldata.exclusiveuse = 0;
            continue;
        }
        
        leveldata.exclusiveuse = 1;
    }
}

// Namespace br
// Params 0
// Checksum 0x47275ae0, Offset: 0xa59c
// Size: 0xb8
function cleanupmolotovs()
{
    println( "<dev string:x273>" );
    grenades = getentarray( "grenade", #classname );
    
    foreach ( grenade in grenades )
    {
        if ( isdefined( grenade ) && grenade.weapon_name == "molotov_mp" )
        {
            thread molotov::molotov_cleanup_pool( grenade );
        }
    }
}

// Namespace br
// Params 1, eflags: 0x4
// Checksum 0x7a029590, Offset: 0xa65c
// Size: 0x30
function private function_1cbaf70696bc641a( throttle )
{
    self endon( #"disconnect" );
    
    if ( throttle )
    {
        throttle::throttle_wait_gate( throttle );
    }
    
    resetplayerinventory( undefined, 1 );
}

// Namespace br
// Params 0
// Checksum 0xa167572f, Offset: 0xa694
// Size: 0x28d
function onprematchfadedone()
{
    flags::gameflagwait( "prematch_fade_done" );
    
    if ( !level.skipprematch )
    {
        level thread resetalldoors( 2.1 );
        level thread calloutmarkerping::function_e2222b6148ff1148( 1 );
        
        if ( game_utility::getgametype() != "dmz" )
        {
            level thread br_vehicles::brvehicleonprematchstarted();
        }
        
        resetglass();
    }
    
    level thread br_functional_poi::onprematchdone();
    
    if ( !level.skipprematch )
    {
        cleanupmolotovs();
        br_vehicles::emptyallvehicles();
        var_775a02eb972898fd = !br_gametypes::isfeaturedisabled( #"gulag" );
        throttle = throttle::throttle_initialize_gate( "onPrematchFadeDone_initPlayers", 15 );
        
        foreach ( player in level.players )
        {
            if ( !level.br_infils_disabled )
            {
                if ( !level.var_a7f6c0960b7f13de )
                {
                    player thread function_1cbaf70696bc641a( throttle );
                }
                
                if ( player.hasspawned )
                {
                    if ( player isonascender() )
                    {
                        player br_utility::function_a8021859c16f9008();
                    }
                    
                    player thread weapons::deleteplacedequipment( 1 );
                }
                
                if ( level.squadleaderboon )
                {
                    player setclientomnvar( "ui_squad_leader_pack_dropped", 0 );
                }
            }
            
            if ( isdefined( player.burninginfo ) )
            {
                player molotov::molotov_clear_burning();
            }
            
            player.var_70c1f4b75530023f = var_775a02eb972898fd;
            player javelin::javelin_forceclear();
        }
        
        level notify( #"prematch_cleanup" );
        callback::callback( #"prematch_cleanup", {} );
    }
    
    level.disabledamagestattracking = 0;
    
    foreach ( i, lootinstance in level.br_prematchloot )
    {
        lootinstance setscriptablepartstate( level.br_prematchlootparts[ i ], "visible" );
    }
    
    level.br_prematchloot = undefined;
    level.br_prematchlootparts = undefined;
    flags::gameflagset( "prematch_cleanup_done" );
    
    if ( !level.br_circle_disabled )
    {
        level thread br_circle::runcircles( 1 );
    }
}

// Namespace br
// Params 0
// Checksum 0x9733fe27, Offset: 0xa929
// Size: 0x1f6
function onprematchstarted()
{
    level thread onprematchfadedone();
    br_infils_legacy::function_48b822fa69cfe126();
    
    if ( !level.skipprematch && !game_utility::function_d3f8957534dc62af() && !getdvarint( @"hash_1bf2afd8a32b6892", 0 ) )
    {
        foreach ( team in level.teamnamelist )
        {
            setteamradar( team, 1 );
            setteamradarstrength( team, 1 );
        }
    }
    
    level waittill( #"prematch_started" );
    
    if ( !level.skipprematch )
    {
        foreach ( team in level.teamnamelist )
        {
            setteamradar( team, 0 );
            setteamradarstrength( team, 0 );
        }
    }
    
    if ( level.br_allowloadout && level.br_allowloadoutonlyinprelobby )
    {
        setomnvarforallclients( "ui_open_menu_from_script", -1 );
    }
    
    if ( br_infils_legacy::function_bb14cfd60cc8058() )
    {
        br_infils_legacy::postprematch();
    }
    else
    {
        flags::gameflagwait( "br_ready_to_jump" );
    }
    
    if ( level.br_ftue_active )
    {
        level thread br_ftue_popups::function_e0f2f6db293c4367();
    }
    
    level thread function_96d4cb50a3cf30c2();
    level thread handlematchscoreboardinfo();
    
    if ( !br_gametypes::isfeaturedisabled( #"teamspectate" ) )
    {
        level thread br_spectate::spectate_init();
    }
    
    level.br_prematchstarted = 1;
    level notify( #"infils_ready" );
    setomnvar( "ui_br_infil_start_timestamp", gettime() );
}

// Namespace br
// Params 0
// Checksum 0xe1052e39, Offset: 0xab27
// Size: 0x69
function handlematchscoreboardinfo()
{
    if ( game_utility_mp::isprophuntgametype() )
    {
        return;
    }
    
    scoreboard::processmatchscoreboardinfo();
    
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        if ( game_utility_mp::matchmakinggame() && !game_utility_mp::privatematch() )
        {
            setclientmatchdata( "isPublicMatch", 1 );
        }
        else
        {
            setclientmatchdata( "isPublicMatch", 0 );
        }
    }
    
    level utility::waittill_notify_or_timeout( "br_c130_left_bounds", 120 );
    scoreboard::processmatchscoreboardinfo();
}

// Namespace br
// Params 0
// Checksum 0xccc41bb6, Offset: 0xab98
// Size: 0xce
function function_96d4cb50a3cf30c2()
{
    if ( getdvarint( @"hash_4c8e33496c92cd2e", 0 ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_c0833dddb3742de3", 0 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    
    if ( !br_public::istutorial() && !br_public::isbrpracticemode() )
    {
        if ( brdoesloadoutoptionusedropbags() && brareloadoutdropbagsdelayed() )
        {
            delayarray = brgetloadoutdropbagsdelayseconds();
            br_rewards::delaydropbags( delayarray );
            
            if ( br_gametypes::isfeatureenabled( #"dropbagloop" ) )
            {
                while ( true )
                {
                    br_rewards::delaydropbags( delayarray );
                }
            }
        }
        else if ( function_7759b233270594b8() && !level.br_circle_disabled )
        {
            delayarray = function_9b0eda41c7cf9617();
            level thread br_supply_drops::function_f1b2aef69d09b0c( delayarray );
        }
    }
    
    level.dropbagstruct = undefined;
}

// Namespace br
// Params 1
// Checksum 0x7c69bd0, Offset: 0xac6e
// Size: 0x2a
function resetalldoors( delaytime )
{
    level endon( #"game_ended" );
    
    if ( isdefined( delaytime ) )
    {
        wait delaytime;
    }
    
    brclosealldoors( 50 );
}

// Namespace br
// Params 2
// Checksum 0x3377f610, Offset: 0xaca0
// Size: 0x2c
function handleexitsquadeliminatedstate( notification, slotindex )
{
    if ( notification == "exit_squad_eliminated" )
    {
        self setclientomnvar( "ui_br_squad_eliminated_active", 0 );
    }
}

// Namespace br
// Params 0
// Checksum 0x4cef3ee0, Offset: 0xacd4
// Size: 0xdc
function waitandstartparachuteoverheadmonitoring()
{
    level endon( #"game_ended" );
    level.activeparachutersfactionvo = [];
    level.activeparachutersfactionvo[ "uktl" ] = "dx_bra_uktl_respawning_enemy_in_area";
    level.activeparachutersfactionvo[ "rutl" ] = "dx_bra_rutl_respawning_enemy_in_area";
    level.parachuteoverheadwarningtimeoutms = getmatchrulesdata( "commonOption", "parachuteOverheadWarningTimeoutMs" );
    level.parachuteoverheadwarningprematchtimeoutms = getmatchrulesdata( "commonOption", "parachuteOverheadWarningPrematchTimeoutMs" );
    level.parachuteoverheadwarningradius = getmatchrulesdata( "commonOption", "parachuteOverheadWarningRadius" );
    level.parachuteoverheadwarningheight = getmatchrulesdata( "commonOption", "parachuteOverheadWarningHeight" );
    level thread watchparachutersoverhead( level.parachuteoverheadwarningprematchtimeoutms, 1 );
    flags::gameflagwait( "prematch_done" );
    level notify( #"hash_4206268f4427df25" );
    waitframe();
    level thread watchparachutersoverhead( level.parachuteoverheadwarningtimeoutms, 0 );
}

// Namespace br
// Params 2
// Checksum 0x48bc69ba, Offset: 0xadb8
// Size: 0x284
function watchparachutersoverhead( intervalms, isprematch )
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_8a3309883e32e261" ) )
    {
        shouldwatch = utility::callsharedfunc( #"gametype", #"hash_8a3309883e32e261", isprematch );
        
        if ( !shouldwatch )
        {
            return;
        }
    }
    
    level endon( #"game_ended" );
    level endon( #"hash_4206268f4427df25" );
    
    while ( true )
    {
        foreach ( xuid, player in level.activeparachuters )
        {
            if ( !isdefined( player ) || !player::isreallyalive( player ) || !( player isparachuting() || player isinfreefall() ) )
            {
                level.activeparachuters[ xuid ] = undefined;
                continue;
            }
            
            nearbyplayers = utility::playersincylinder( player.origin, level.parachuteoverheadwarningradius, undefined, level.parachuteoverheadwarningheight, player.team, 1 );
            
            foreach ( targetplayer in nearbyplayers )
            {
                if ( isdefined( targetplayer.c130 ) )
                {
                    continue;
                }
                
                if ( !player::isreallyalive( targetplayer ) )
                {
                    continue;
                }
                
                targetparachuting = targetplayer isparachuting() || targetplayer isinfreefall();
                
                if ( targetparachuting )
                {
                    continue;
                }
                
                time = gettime();
                heardrecently = isdefined( targetplayer.heardparachuteoverheadtime ) && time - targetplayer.heardparachuteoverheadtime < intervalms;
                
                if ( heardrecently )
                {
                    continue;
                }
                
                targetplayer.heardparachuteoverheadtime = time;
                br_public::brleaderdialog( "respawning_enemy_in_area", 1, [ targetplayer ], undefined, undefined, undefined, level.brgametype.dialogprefix );
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace br
// Params 0
// Checksum 0xe7fdd547, Offset: 0xb044
// Size: 0x21d
function updateplayerlocationcallouts()
{
    level endon( #"game_ended" );
    level.calloutglobals.calloutzones = getentarray( "location_volume", #targetname );
    
    if ( !level.calloutglobals.calloutzones.size )
    {
        return;
    }
    
    while ( true )
    {
        var_6ea9aa7ddce025fd = 0;
        
        foreach ( player in level.players )
        {
            if ( !isplayer( player ) || !isalive( player ) )
            {
                continue;
            }
            
            if ( isdefined( player.br_currentcalloutzone ) && player istouching( player.br_currentcalloutzone ) )
            {
                continue;
            }
            
            isinzone = 0;
            
            foreach ( calloutzone in level.calloutglobals.calloutzones )
            {
                if ( player istouching( calloutzone ) )
                {
                    isinzone = 1;
                    player.br_currentcalloutzone = calloutzone;
                    player callouts::setplayercalloutarea( calloutzone.script_noteworthy );
                    player thread utility::callsharedfunc( #"gametype", #"hash_90d675ba25829b8b", calloutzone.script_noteworthy );
                    break;
                }
            }
            
            if ( !isinzone )
            {
                player.br_currentcalloutzone = undefined;
                player callouts::setplayercalloutarea( "none" );
            }
            
            var_6ea9aa7ddce025fd = ( var_6ea9aa7ddce025fd + 1 ) % 2;
            
            if ( var_6ea9aa7ddce025fd == 0 )
            {
                waitframe();
            }
        }
        
        waitframe();
    }
}

// Namespace br
// Params 0
// Checksum 0x7c57b2f4, Offset: 0xb269
// Size: 0x205
function function_59a48af3dafdbb88()
{
    versionnum = getdvarint( @"scr_drop_on_death_version", 4 );
    level.uselootablecorpse = getmatchrulesdata( "brData", "useLootableCorpse" );
    
    switch ( versionnum )
    {
        case 0:
            level.var_32411caa1b74d35c = 0;
            level.var_efb95dae14917cbc = 1;
            level.var_45a89e982ebc0183 = 1;
            level.explodingbackpack = 0;
            break;
        case 1:
            level.var_32411caa1b74d35c = 1;
            level.var_efb95dae14917cbc = 1;
            level.var_45a89e982ebc0183 = 1;
            level.explodingbackpack = 0;
            level.var_491ca5bc4d326996 = getdvarint( @"hash_3f8e6e632099c5f", 1 );
            break;
        case 2:
            level.var_32411caa1b74d35c = 0;
            level.var_efb95dae14917cbc = 1;
            level.var_45a89e982ebc0183 = 1;
            level.explodingbackpack = 1;
            break;
        case 3:
            level.var_32411caa1b74d35c = 0;
            level.var_efb95dae14917cbc = 0;
            level.var_45a89e982ebc0183 = 0;
            level.explodingbackpack = 0;
            break;
        case 4:
            level.var_32411caa1b74d35c = 1;
            level.var_efb95dae14917cbc = 0;
            level.var_45a89e982ebc0183 = 0;
            level.explodingbackpack = 0;
            level.var_cebc472cce388632 = 1;
            break;
        case 5:
            level.var_32411caa1b74d35c = 0;
            level.var_efb95dae14917cbc = 1;
            level.var_45a89e982ebc0183 = 1;
            level.explodingbackpack = 0;
            level.var_312ec2b4a11f5b45 = 1;
            level.var_977a2c9bb663c729 = 1;
            break;
        default:
            level.var_32411caa1b74d35c = 0;
            level.var_efb95dae14917cbc = 1;
            level.var_45a89e982ebc0183 = 1;
            level.explodingbackpack = 0;
            break;
    }
}

// Namespace br
// Params 0
// Checksum 0x916462, Offset: 0xb476
// Size: 0x3, Type: bool
function getusingproxdoors()
{
    return false;
}

// Namespace br
// Params 2
// Checksum 0x92b9aa30, Offset: 0xb482
// Size: 0x1f6
function function_f5ccfa758d234cac( gasmaskdamage, position )
{
    foreach ( player in self.playersintrigger )
    {
        if ( player.gasmaskhealth > 0 && !player getinairpocket() )
        {
            player gasmask::processdamage( gasmaskdamage );
            
            if ( common_inventory::function_5c64d2b24a8c3e18() )
            {
                player common_inventory::function_6525f6bbec67b15e( level.var_6a8b6f867f6e7ad4, gasmaskdamage );
            }
        }
    }
    
    var_6b3cd44c8b012487 = getlootscriptablearrayinradius( "brloot_equip_gasmask", undefined, position, self.radius );
    var_ae25617435ef25ff = getlootscriptablearrayinradius( "brloot_equip_gasmask_durable", undefined, position, self.radius );
    var_6b3cd44c8b012487 = arraycombine( var_6b3cd44c8b012487, var_ae25617435ef25ff );
    
    for ( index = var_6b3cd44c8b012487.size - 1; index >= 0 ; index-- )
    {
        gasmask = var_6b3cd44c8b012487[ index ];
        
        if ( !isdefined( gasmask ) )
        {
            continue;
        }
        
        zdisplacement = gasmask.origin[ 2 ] - self.origin[ 2 ];
        
        if ( gasmask.var_69c7f935014de621 || zdisplacement < 0 || zdisplacement > self.height || gasmask function_363477bc8bd88260() )
        {
            continue;
        }
        
        newhealth = int( gasmask.count - gasmaskdamage );
        
        if ( newhealth <= 0 )
        {
            gasmask setscriptablepartstate( gasmask.type, "death" );
            gasmask common_item::items_scriptable_waitandcleanup( 1 );
            continue;
        }
        
        gasmask.count = newhealth;
    }
}

// Namespace br
// Params 0
// Checksum 0xc752cab1, Offset: 0xb680
// Size: 0x7e, Type: bool
function function_363477bc8bd88260()
{
    if ( self && level.decon_station.instances && level.decon_station.radius )
    {
        stations = function_6a293b884c444a20( level.decon_station.instances, self.origin, level.decon_station.radius ).size ?? 0;
        return ( stations > 0 );
    }
    
    return false;
}

// Namespace br
// Params 1
// Checksum 0xc7faa04, Offset: 0xb707
// Size: 0x48
function function_ce601d6f64265108( position )
{
    self endon( #"death" );
    wait 0.1;
    function_f5ccfa758d234cac( 20, position );
    
    while ( true )
    {
        wait 1;
        function_f5ccfa758d234cac( 5, position );
    }
}

// Namespace br
// Params 0
// Checksum 0x2e4e379d, Offset: 0xb757
// Size: 0x284
function watchprematchdone()
{
    flags::gameflagwait( "prematch_fade_done" );
    utility::flag_set( "br_prematchEnded" );
    totalplayers = game_utility_mp::getlivingplayers();
    level.totalplayers = totalplayers.size;
    startingteamcount = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( teams::getteamdata( entry, "aliveCount" ) > 0 )
        {
            startingteamcount++;
        }
    }
    
    level.startingteamcount = max( 1, startingteamcount );
    level.prematchendtime = gettime();
    level.recordfinalkillcam = 1;
    level.ignorescoring = 0;
    level.disableweaponstats = 0;
    level.disablestattracking = 0;
    level.prematchaddkillfunc = undefined;
    level.var_9b3243830eeafdbd = 0;
    level thread brclearscoreboardstats();
    
    if ( !br_gametypes::isfeatureenabled( #"allowlatejoiners" ) )
    {
        level.allowlatecomers = 0;
        setnojiptime( 1, 1 );
        setnojipscore( 1, 1 );
    }
    
    brmatchstarted();
    setomnvar( "scriptable_loot_hide", 0 );
    level notify( #"scriptable_loot_hide_off" );
    
    foreach ( player in level.players )
    {
        player setclientdvar( @"ui_opensummary", 1 );
        namekey = getgametypenamekey();
        
        if ( isdefined( namekey ) )
        {
            player setclientdvar( @"hash_6662b40ecc02a63c", namekey == "battleroyale_ftue_bt" );
        }
        
        if ( isalive( player ) )
        {
            player.health = player.maxhealth;
        }
    }
    
    br_analytics::branalytics_playercount( totalplayers.size );
    level setplacementxpshare();
    
    if ( getdvarint( @"hash_1295aa08e53fc39d", 0 ) == 0 )
    {
        removeallcorpses();
    }
    
    if ( getdvarint( @"hash_3d82b17bac600216", 1 ) == 1 )
    {
        removeallfxmarks();
    }
}

// Namespace br
// Params 0
// Checksum 0xd99a3c72, Offset: 0xb9e3
// Size: 0x11
function turnofftimer()
{
    wait 1;
    setomnvar( "ui_match_timer_hidden", 1 );
}

// Namespace br
// Params 0
// Checksum 0xd76b4a92, Offset: 0xb9fc
// Size: 0x10
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::finalizemap();
}

// Namespace br
// Params 0
// Checksum 0x8f240f3f, Offset: 0xba14
// Size: 0x211
function initprematchspawnlocations()
{
    if ( !br_public::isbrpracticemode() )
    {
        level.startingspawns = spawnlogic::getspawnpointarray( "mp_dm_spawn_start" );
        
        if ( level.startingspawns.size == 0 )
        {
            level.startingspawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
        }
        
        if ( isdefined( level.var_1ffee61a2edaade3 ) )
        {
            level.prematchspawnorigins = [[ level.var_1ffee61a2edaade3 ]]();
        }
        else
        {
            level.prematchspawnorigins = getprematchlocationspawnorigins();
        }
        
        if ( level.var_66a069174249c72b == 1 )
        {
            arenas = utility::getstructarray( "gulag_dom", "targetname" );
            
            if ( isdefined( arenas ) && arenas.size > 0 )
            {
                foreach ( arena in arenas )
                {
                    arenastructs = utility::getstructarray( arena.target, "targetname" );
                    
                    foreach ( arenastruct in arenastructs )
                    {
                        if ( arenastruct.script_noteworthy == "gulag_dom_prematch_spawn" )
                        {
                            level.prematchspawnorigins[ 0 ].origin = arenastruct.origin;
                        }
                    }
                }
            }
            
            return;
        }
        
        if ( level.var_66a069174249c72b == 2 )
        {
            if ( br_dom_gulag::function_bf5c033346d6e717() )
            {
                level.prematchspawnorigins[ 0 ].origin = ( -1880, -640, 430 );
            }
        }
    }
}

/#

    // Namespace br
    // Params 0
    // Checksum 0x5029fd71, Offset: 0xbc2d
    // Size: 0xfe, Type: dev
    function function_8117ae3d717c0a38()
    {
        while ( true )
        {
            if ( isdefined( level.prematchspawnorigins ) )
            {
                foreach ( location in level.prematchspawnorigins )
                {
                    [ minradius, radius ] = getprematchradius( location );
                    sphere( location.origin, radius, ( 0, 1, 0 ) );
                    
                    if ( minradius > 0 )
                    {
                        sphere( location.origin, minradius, ( 1, 1, 0 ) );
                    }
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace br
// Params 0
// Checksum 0x6e9cdac5, Offset: 0xbd33
// Size: 0x58, Type: bool
function usedropspawn()
{
    var_436f60a402fbc6cd = getdvarint( @"hash_3f36284b49b3d7a", 0 ) != 0;
    return ( !level.br_prematchstarted || level.br_allowdropspawnafterprematch ) && !level.skipprematchdropspawn && !var_436f60a402fbc6cd && !level.infilcinematicactive;
}

// Namespace br
// Params 1
// Checksum 0xe43b9bd0, Offset: 0xbd94
// Size: 0x29f
function getspawnpoint( prespawn )
{
    if ( isdefined( self.prespawnspawn ) )
    {
        spawnpoint = self.prespawnspawn;
        self.prespawnspawn = undefined;
        return spawnpoint;
    }
    
    if ( isdefined( self.initialprespawn ) )
    {
        spawnpoint = self.initialprespawn;
        return spawnpoint;
    }
    
    isprematchdone = flags::gameflagexists( "prematch_done" ) && flags::gameflag( "prematch_done" );
    
    if ( !isdefined( level.prematchspawnorigins ) && !isprematchdone )
    {
        initprematchspawnlocations();
    }
    
    if ( prespawn || usedropspawn() )
    {
        dropspawnangles = ( getdvarfloat( @"hash_d6f7a211c05b441f", 75 ), randomintrange( 0, 360 ), 0 );
        dropstruct = getprematchspawnorigin();
        [ minradius, radius ] = getprematchradius( dropstruct );
        var_f5ced79f9d86b834 = randomfloatrange( minradius, radius );
        
        if ( level.var_4e94f64deb0c4e18 > -1 )
        {
            var_f5ced79f9d86b834 = level.var_4e94f64deb0c4e18;
        }
        
        if ( getdvarint( @"hash_8b70bee2041ed89d", 0 ) == 1 )
        {
            farspawnangles = vectortoangles( dropstruct.origin );
            dropspawnangles = ( 0, farspawnangles[ 1 ], 0 ) * -1;
            var_f5ced79f9d86b834 = radius;
        }
        
        dropvector = anglestoforward( dropspawnangles ) * -1;
        offsetvector = dropvector * var_f5ced79f9d86b834;
        dropspawnorigin = dropstruct.origin + offsetvector;
        
        if ( isdefined( self.setspawnpoint ) )
        {
            spawnoffset = br_infils_util::getinfilspawnoffset();
            dropspawnorigin = self.setspawnpoint.playerspawnpos + ( 0, 0, spawnoffset );
            dropspawnangles = self.setspawnpoint.playerspawnangles;
            playerlogic::spawnpoint_clearspawnpoint( 0, 1 );
        }
        
        spawnpoint = { #index:-1, #forceangles:1, #angles:dropspawnangles, #origin:dropspawnorigin };
        return spawnpoint;
    }
    
    spawnpoints = level.startingspawns;
    spawnpoint = spawnlogic::getspawnpoint_random( spawnpoints );
    
    if ( !isdefined( spawnpoint ) )
    {
        spawnpoint = spawnstruct();
        spawnpoint.origin = ( 0, 0, 0 );
        spawnpoint.angles = ( 0, 0, 0 );
        spawnpoint.index = -1;
    }
    
    return spawnpoint;
}

// Namespace br
// Params 3
// Checksum 0xf403882d, Offset: 0xc03c
// Size: 0x5a
function createspawnlocation( origin, minradius, maxradius )
{
    loc = spawnstruct();
    loc.origin = origin;
    loc.minradius = minradius;
    loc.radius = maxradius;
    return loc;
}

// Namespace br
// Params 0
// Checksum 0xb4fd5313, Offset: 0xc09f
// Size: 0x361
function getprematchlocationspawnorigins()
{
    var_ee5bad5819023830 = 0;
    spawnlocations = utility::getstructarray( "br_prematch_insertion_point", "targetname" );
    var_369a3849c4293d8f = getdvarint( @"hash_500929cf224e1d03", 0 );
    
    if ( var_369a3849c4293d8f )
    {
        prematchspawnpos = getdvarvector( @"hash_15fab3c9c51ca75e", ( 0, 0, 0 ) );
        var_b4e4ce5ce189640d = getdvarint( @"hash_d7079d5a45600c6a", 0 );
        assert( prematchspawnpos != ( 0, 0, 0 ) && var_b4e4ce5ce189640d != 0 );
        spawnlocations = [ createspawnlocation( prematchspawnpos, 0, var_b4e4ce5ce189640d ) ];
    }
    else if ( isdefined( level.br_prematchspawnlocations ) )
    {
        var_ee5bad5819023830 = 1;
        spawnlocations = level.br_prematchspawnlocations;
    }
    else if ( !spawnlocations.size )
    {
        var_ee5bad5819023830 = 1;
        spawnlocations = getentarray( "vehicle_volume", #script_noteworthy );
    }
    
    /#
        if ( !spawnlocations.size && getdvar( @"hash_344ec7639d9d44", "<dev string:x17e>" ) != "<dev string:x17e>" )
        {
            spawnlocations = level.startingspawns;
            
            if ( level.var_66a069174249c72b == 1 )
            {
                spawnlocations[ 0 ].origin = level.prematchspawnorigins[ 0 ].origin;
            }
            
            return spawnlocations;
        }
    #/
    
    assert( spawnlocations.size, "<dev string:x283>" );
    
    foreach ( location in spawnlocations )
    {
        location.groundorigin = location.origin;
        
        if ( !isdefined( location.radius ) )
        {
            location.radius = 5000;
        }
        
        if ( !isdefined( location.minradius ) )
        {
            location.minradius = 500;
        }
    }
    
    maxprematchlocations = getdvarint( @"scr_br_maxprematchlocations", 5 );
    
    if ( function_fbffef816ea445e0() && level.var_a7b65f5a37e3ba00 < maxprematchlocations )
    {
        maxprematchlocations = level.var_a7b65f5a37e3ba00;
    }
    
    if ( maxprematchlocations > 0 && maxprematchlocations < spawnlocations.size )
    {
        spawnlocations = utility::array_slice( arrayrandomize( spawnlocations ), 0, maxprematchlocations );
    }
    
    foreach ( location in spawnlocations )
    {
        if ( var_ee5bad5819023830 )
        {
            location.origin = getoffsetspawnorigin( location.origin );
            continue;
        }
        
        minz = getoffsetspawnorigin( location.origin )[ 2 ];
        
        if ( location.origin[ 2 ] < minz )
        {
            location.origin = ( location.origin[ 0 ], location.origin[ 1 ], minz );
        }
    }
    
    return spawnlocations;
}

// Namespace br
// Params 0
// Checksum 0xe3200926, Offset: 0xc409
// Size: 0x4
function function_c01db5f0551dc1ac()
{
    return 5;
}

// Namespace br
// Params 2
// Checksum 0x4b86f750, Offset: 0xc416
// Size: 0xb9
function getoffsetspawnorigin( origin, dropspawnoffset )
{
    tracecontents = trace::create_default_contents( 1 );
    traceoffset = ( 0, 0, 5000 );
    tracestart = origin + traceoffset;
    traceend = origin - traceoffset;
    trace = trace::ray_trace( tracestart, traceend, undefined, tracecontents );
    locationbase = origin;
    
    if ( trace[ "hittype" ] != "hittype_none" )
    {
        locationbase = trace[ "position" ];
    }
    
    if ( !isdefined( dropspawnoffset ) )
    {
        zoffset = br_infils_util::getinfilspawnoffset();
        dropspawnoffset = ( 0, 0, zoffset );
    }
    
    return locationbase + dropspawnoffset;
}

// Namespace br
// Params 2
// Checksum 0x86c60d8f, Offset: 0xc4d8
// Size: 0x7b
function getoffsetspawnoriginmultitrace( origin, dropspawnoffset )
{
    tracecontents = trace::create_default_contents( 1 );
    updist = 5000;
    downdist = -5000;
    groundorigin = br_public::droptogroundmultitrace( origin, updist, downdist, tracecontents );
    
    if ( !isdefined( dropspawnoffset ) )
    {
        zoffset = br_infils_util::getinfilspawnoffset();
        dropspawnoffset = ( 0, 0, zoffset );
    }
    
    return groundorigin + dropspawnoffset;
}

// Namespace br
// Params 0
// Checksum 0xa7f4572b, Offset: 0xc55c
// Size: 0x1d
function getexpectednumberofteams()
{
    numteams = int( 150 / br_public::function_ab5e009b1898c081() );
    return numteams;
}

// Namespace br
// Params 0
// Checksum 0x480babae, Offset: 0xc582
// Size: 0x25e
function getprematchspawnorigin()
{
    assert( isdefined( self.sessionteam ) );
    assert( arraycontains( level.teamnamelist, self.sessionteam ) );
    
    if ( !isdefined( level.prematchspawnoriginsforteams ) )
    {
        level.prematchspawnoriginsforteams = [];
        level.prematchspawnoriginnextidx = randomint( level.prematchspawnorigins.size );
        level.prematchspawnoriginteamcount = [];
        
        for ( i = 0; i < level.prematchspawnorigins.size ; i++ )
        {
            level.prematchspawnoriginteamcount[ i ] = 0;
        }
    }
    
    spawnorigin = undefined;
    
    if ( isdefined( level.squaddata[ self.sessionteam ][ self.sessionsquadid ] ) && squads::function_eee6396d37a87f96( self.sessionteam, self.sessionsquadid, "prematchSpawnOrigin" ) )
    {
        spawnorigin = squads::getsquaddata( self.sessionteam, self.sessionsquadid, "prematchSpawnOrigin" );
    }
    
    if ( !isdefined( level.prematchspawnoriginsforteams[ self.sessionteam ] ) )
    {
        level.prematchspawnoriginsforteams[ self.sessionteam ] = level.prematchspawnorigins[ level.prematchspawnoriginnextidx ];
        level.prematchspawnoriginteamcount[ level.prematchspawnoriginnextidx ]++;
        var_fb7d0b48a255033e = isbrgamemode() && function_fbffef816ea445e0();
        
        if ( var_fb7d0b48a255033e )
        {
            level.prematchspawnoriginnextidx = ( level.prematchspawnoriginnextidx + 1 ) % level.prematchspawnorigins.size;
        }
        else
        {
            expectednumberofteams = getexpectednumberofteams();
            var_76dec8b7834c22fa = int( expectednumberofteams / level.prematchspawnorigins.size );
            
            if ( level.prematchspawnoriginteamcount[ level.prematchspawnoriginnextidx ] >= var_76dec8b7834c22fa )
            {
                level.prematchspawnoriginnextidx = ( level.prematchspawnoriginnextidx + 1 ) % level.prematchspawnorigins.size;
            }
        }
    }
    
    spawnorigin = level.prematchspawnoriginsforteams[ self.sessionteam ];
    spawnoverrideindex = getdvarint( @"hash_da9368d09cdd8075", -1 );
    
    if ( spawnoverrideindex >= 0 && spawnoverrideindex < level.prematchspawnorigins.size )
    {
        spawnorigin = level.prematchspawnorigins[ spawnoverrideindex ];
    }
    
    assert( isdefined( spawnorigin ) );
    return spawnorigin;
}

// Namespace br
// Params 1
// Checksum 0xe5d6205, Offset: 0xc7e9
// Size: 0x3e2
function onplayerconnect( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !level.var_9b348be2e4333da2 && !level.leagueplaymatch )
    {
        player validation::function_a360601d1cdfc8();
    }
    
    if ( level.var_4d2ffb649fcef6ea )
    {
        if ( !isdefined( player.pers[ "objectivesCompleted" ] ) )
        {
            player.pers[ "objectivesCompleted" ] = 0;
        }
    }
    
    player.needtoplayintro = undefined;
    player.br_infil_type = undefined;
    player.equipment = [];
    player.endmatchstats = [];
    player.var_d5e836adfb09a0ef = [];
    player.br_isplayerbeforeinitialinfildeploy = 1;
    player.var_b6d6f990bce951ef = 0;
    player.var_f62c9dea27fe9bf8 = 0;
    player.var_fdb17a3789226971 = 0;
    player thread br_default_inventory::function_3e818c02bf6469d3( player, 1 );
    player thread br_weapons::br_ammo_player_init();
    player thread jumpmasterwatch();
    
    if ( br_public::function_2d9074b461a9f5cb() )
    {
        if ( common_item::items_isenabled() )
        {
            player item_redeploy_token::function_a8dbeb883ac6e5d4();
        }
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"playerwelcomesplashes" ) )
    {
        player thread utility::callsharedfunc( #"gametype", #"playerwelcomesplashes" );
    }
    else
    {
        player thread playerwelcomesplashes();
    }
    
    player thread function_fb199c4913048111();
    utility::callsharedfunc( #"gametype", #"hash_a407cc94ad2c6279", player );
    
    if ( isdefined( player ) && player iscodcaster() )
    {
        if ( !isdefined( level.codcasters ) )
        {
            level.codcasters = [];
        }
        
        level.codcasters[ level.codcasters.size ] = player;
        player.lastclientnum = player getentitynumber();
        player thread br_gulag::function_a76cab32d240aeb1();
        player thread codcaster_utils::function_64859d45e0270ca8();
    }
    
    if ( isdefined( player ) && team_assimilation::function_8fe74e094005f15d() && getdvarint( @"hash_e57fc6a3ec1c560b", 1 ) )
    {
        player thread function_a1b34bd531f8f8f2();
    }
    
    if ( isdefined( player ) && utility::level_supports_ai() )
    {
        if ( !isdefined( level.difficultytype ) )
        {
            level ai_mp_controller::function_71bf1a00b0b8d267();
        }
        
        player.gameskill = mp_gameskill::get_gameskill();
        player mp_gameskill::set_difficulty_from_locked_settings();
        player.owner = undefined;
        utility::flag_wait( "level_stealth_initialized" );
        
        while ( !isdefined( player.team ) )
        {
            waitframe();
        }
        
        player player::main();
    }
    
    if ( isdefined( level.var_1b4613a64e689a9a ) )
    {
        player [[ level.var_1b4613a64e689a9a ]]();
    }
    
    player br_analytics::function_75d9144fab811d63();
    
    if ( !level.prematchstarted )
    {
        player.radarmode = "slow_radar";
        level waittill( #"prematch_started" );
        wait 1.4;
    }
    
    if ( !isdefined( player.streakdata ) )
    {
        waittillframeend();
    }
    
    if ( isdefined( player ) )
    {
        if ( !br_public::function_379fb7b09f4ef13e() && !br_public::istutorial() && !br_public::isbrpracticemode() && !game_utility_mp::isprophuntgametype() )
        {
            if ( !level.skipprematch )
            {
                if ( !level.var_9b348be2e4333da2 )
                {
                    player br_weapons::br_ammo_player_clear();
                    player resetplayerinventory( 0, 1 );
                }
            }
            
            player game_utility::startkeyearning();
        }
        
        /#
            if ( level.br_infils_disabled )
            {
                player function_7f8e68c8640a640e();
            }
        #/
        
        if ( function_c4ecdfd88386f9f4() && !br_public::istutorial() && !br_public::function_379fb7b09f4ef13e() && !game_utility_mp::isprophuntgametype() )
        {
            player thread monitorweaponswitchbr();
        }
        
        player.radarmode = "normal_radar";
        thread br_contract_manager::onplayerconnect( player );
        
        if ( !level.var_2f77eda9458c9df6 )
        {
            initializeaardata( player );
        }
        
        player br_gulag::function_a7357f7a8eb52832();
    }
}

// Namespace br
// Params 0
// Checksum 0xcc02f348, Offset: 0xcbd3
// Size: 0x3d, Type: bool
function function_c4ecdfd88386f9f4()
{
    if ( level.var_bf319b0aeb8a0378 )
    {
        return false;
    }
    
    if ( isdefined( level.br_gun_game ) )
    {
        return false;
    }
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_343d3f3f77c83350":
            return false;
    }
    
    return true;
}

// Namespace br
// Params 0
// Checksum 0x4f95d892, Offset: 0xcc19
// Size: 0x66
function playerwelcomesplashes()
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    wait 1;
    
    if ( !self.infil_landing_done )
    {
        self waittill( #"infil_landing_done" );
    }
    
    wait 1;
    br_public::brleaderdialogplayer( "primary_objective", self, 0, undefined, undefined, undefined, level.brgametype.dialogprefix );
    function_81c3d73b94698167();
}

// Namespace br
// Params 0
// Checksum 0xa48aeb3d, Offset: 0xcc87
// Size: 0xc3
function function_fb199c4913048111()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !level.br_infils_disabled )
    {
        self waittill( #"br_jump" );
        
        while ( !self isonground() && !self isswimming() && !self ishanging() && !self isonladder() && !self isvehicleactive() )
        {
            waitframe();
        }
    }
    else
    {
        level waittill( #"prematch_done" );
    }
    
    self.infil_landing_done = 1;
    self notify( #"infil_landing_done" );
    br_analytics::branalytics_landing( self );
    var_1db4f479a1d154cb = spawnstruct();
    var_1db4f479a1d154cb.reasonrespawn = "infil";
    br_analytics::function_253a50887835eec2( self, var_1db4f479a1d154cb );
}

// Namespace br
// Params 0
// Checksum 0xa6659245, Offset: 0xcd52
// Size: 0x159
function function_48a77bf6c5c416()
{
    if ( !level.br_prematchstarted )
    {
        return;
    }
    
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_1db4f479a1d154cb = spawnstruct();
    var_1db4f479a1d154cb.respawnedtime = gettime();
    var_1db4f479a1d154cb.reasonrespawn = player.var_1be091ba55db848e ?? "";
    var_1db4f479a1d154cb.respawnedx = player.origin[ 0 ];
    var_1db4f479a1d154cb.respawnedy = player.origin[ 1 ];
    var_1db4f479a1d154cb.respawnedz = player.origin[ 2 ];
    var_1db4f479a1d154cb.starthealth = player.health ?? -1;
    var_1db4f479a1d154cb.startarmor = player.armorhealth ?? -1;
    
    while ( player br_public::isplayerinorgoingtogulag() || !player isonground() && !player isswimming() && !player ishanging() && !player isonladder() && !player isvehicleactive() )
    {
        waitframe();
    }
    
    br_analytics::function_253a50887835eec2( player, var_1db4f479a1d154cb );
    
    if ( isdefined( player ) )
    {
        player.var_1be091ba55db848e = undefined;
    }
}

// Namespace br
// Params 1
// Checksum 0x29c0d8e3, Offset: 0xceb3
// Size: 0x238
function onspawnplayer( revivespawn )
{
    self notify( #"br_spawned" );
    
    if ( isbot( self ) )
    {
        if ( getdvarint( @"hash_da01f2f560ec65a8", 0 ) == 1 )
        {
            self botsetflag( "no_enemy_search", 1 );
        }
    }
    else
    {
        keeploadout = self.gulag || level.var_a629e0989043efd8;
        resetplayerinventory( keeploadout );
    }
    
    br_functional_poi::initplayer( revivespawn );
    
    if ( !br_gametypes::isfeaturedisabled( #"teamspectate" ) )
    {
        br_spectate::initplayer();
    }
    
    if ( level.var_ea1c5851a8ccf08d )
    {
        val::nuke( "sprint" );
    }
    
    self.oldprimarygun = undefined;
    self.newprimarygun = undefined;
    self.healthregendisabled = 0;
    self.needtoplayintro = undefined;
    self.gunnlessweapon = undefined;
    self.brdownedbyairstriketime = undefined;
    
    if ( !br_gametypes::isfeaturedisabled( #"hash_ee46d235dcd7bb0" ) )
    {
        thread waitloadoutdone( revivespawn );
    }
    
    level.superdelay = 0;
    level.superpointsmod = 1;
    
    if ( level.parachutecancutautodeploy )
    {
        self skydive_cutautodeployon();
    }
    else
    {
        self skydive_cutautodeployoff();
    }
    
    if ( level.parachutecancutparachute )
    {
        self skydive_cutparachuteon();
    }
    else
    {
        self skydive_cutparachuteoff();
    }
    
    if ( getdvarint( @"hash_621ca7153d2b5c1d", 0 ) > 0 )
    {
        level thread brplayerhudoutlineforteammates( self );
    }
    
    br_public::setplayerdownedextrainfo( 0 );
    laststand::setplayerbeingrevivedextrainfo( 0 );
    br_public::function_4b66f0c3d7997b1a( 0 );
    laststand::updatesquadmemberlaststandreviveprogress( self, self, 0, 1 );
    self setclientomnvar( "ui_securing", 0 );
    utility::callsharedfunc( #"gametype", #"onspawnplayer" );
    thread function_61e2f390df19d678();
    
    if ( getdvarint( @"bg_bristotallynormal", 0 ) && getdvarint( @"hash_dc29833577096d47", 0 ) )
    {
        thread tnbrmonitorlauncherammorestock();
    }
    
    boostval = self getclientomnvar( "ui_speedboost_overlay" );
    
    if ( boostval == 0 )
    {
        self setclientomnvar( "ui_speedboost_overlay", 2 );
    }
    
    thread events::function_ae66e9c9792546bf();
    
    if ( isdefined( level.var_cd027313d113e09b ) )
    {
        self visionsetnakedforplayer( level.var_cd027313d113e09b, 1 );
    }
    
    level thread updateplayerandteamcountui();
}

// Namespace br
// Params 2
// Checksum 0x302ded06, Offset: 0xd0f3
// Size: 0x66
function waittill_return( confirmstring, ent )
{
    if ( confirmstring != "death" )
    {
        self endon( #"death" );
    }
    
    ent endon( #"die" );
    self waittill( confirmstring, location, angle );
    ent notify( #"returned", location, angle, confirmstring );
}

// Namespace br
// Params 3
// Checksum 0x56b1c946, Offset: 0xd161
// Size: 0xf4
function waittill_confirm_or_cancel( confirmstring, cancelstring, endstring )
{
    if ( confirmstring != "death" && cancelstring != "death" )
    {
        self endon( #"death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( confirmstring ) )
    {
        childthread waittill_return( confirmstring, ent );
    }
    
    if ( isdefined( cancelstring ) )
    {
        childthread waittill_return( cancelstring, ent );
    }
    
    if ( isdefined( endstring ) )
    {
        childthread waittill_return( endstring, ent );
    }
    
    ent waittill( #"returned", location, angle, string );
    ent notify( #"die" );
    returninfo = spawnstruct();
    returninfo.location = location;
    returninfo.angles = angle;
    returninfo.string = string;
    return returninfo;
}

// Namespace br
// Params 1
// Checksum 0x3272ceec, Offset: 0xd25e
// Size: 0xa1
function traceselectedmaplocation( location )
{
    startlocationtrace = location + ( 0, 0, 10000 );
    var_2ba7a759e251c071 = location - ( 0, 0, 10000 );
    drivablevehicles = vehicle_tracking::function_5820a38c9873992e();
    killstreakmodels = level.activekillstreaks;
    var_847f780b10d918e5 = arraycombine( drivablevehicles, killstreakmodels );
    contentoverride = trace::create_contents( 0, 1, 0, 1, 1, 0, 0, 0, 0 );
    return trace::ray_trace( startlocationtrace, var_2ba7a759e251c071, var_847f780b10d918e5, contentoverride, 0, 1 );
}

// Namespace br
// Params 0
// Checksum 0x3bd143d9, Offset: 0xd308
// Size: 0x44
function giveprematchloadout()
{
    self endon( #"death_or_disconnect" );
    
    if ( !level.br_prematchffa )
    {
        return;
    }
    
    if ( isdefined( level.var_5ece30396ddd4663 ) && !level.var_389f79c31f7b06b6 )
    {
        self [[ level.var_5ece30396ddd4663 ]]();
    }
}

// Namespace br
// Params 0
// Checksum 0xc1ba3451, Offset: 0xd354
// Size: 0x103
function function_5ece30396ddd4663()
{
    var_72b6b0ec977c4226 = getdvarint( @"hash_9a965c244b485a82", 0 ) == 1;
    
    if ( !var_72b6b0ec977c4226 )
    {
        thread class::loadout_clearperks();
        
        if ( namespace_5ab67a14d18bea3f::function_43c57123ed24d409() )
        {
            namespace_5ab67a14d18bea3f::function_9477f4690296f31();
        }
        
        defaultperks = class::function_c8d9816a5c9f1f97( self );
        assert( isdefined( defaultperks ), "<dev string:x2bd>" );
        
        if ( defaultperks )
        {
            foreach ( perk in defaultperks )
            {
                class::loadout_giveperk( perk );
            }
        }
    }
    
    if ( !level.allowsupers && !level.giveloadouteverytime && !level.disableprematchsuper )
    {
        waitframe();
        common_inventory::function_38ff1a66cd956902();
    }
}

// Namespace br
// Params 2
// Checksum 0x16d3bae, Offset: 0xd45f
// Size: 0x278
function givematchloadout( ammomult = 0.5, ammomax = 20 )
{
    player = self;
    var_d695710502e81d03 = player class::loadout_getorbuildclassstruct( player.class );
    
    if ( !isdefined( var_d695710502e81d03 ) )
    {
        return;
    }
    
    player.prevweaponobj = undefined;
    player class::loadout_clearperks();
    player class::loadout_updateplayerperks( var_d695710502e81d03 );
    givelaststandifneeded( player );
    gunsgiven = 0;
    
    if ( isdefined( var_d695710502e81d03.loadoutsecondaryobject ) && !isnullweapon( var_d695710502e81d03.loadoutsecondaryobject ) )
    {
        br_weapons::br_forcegivecustomweapon( player, var_d695710502e81d03.loadoutsecondaryobject, var_d695710502e81d03.loadoutsecondaryfullname, var_d695710502e81d03.loadoutsecondary, ammomult, ammomax );
        gunsgiven++;
    }
    
    if ( isdefined( var_d695710502e81d03.loadoutprimaryobject ) && !isnullweapon( var_d695710502e81d03.loadoutprimaryobject ) )
    {
        br_weapons::br_forcegivecustomweapon( player, var_d695710502e81d03.loadoutprimaryobject, var_d695710502e81d03.loadoutprimaryfullname, var_d695710502e81d03.loadoutprimary, ammomult, ammomax );
        gunsgiven++;
    }
    
    if ( isdefined( var_d695710502e81d03.var_9dcef9a8722c3abb ) && !isnullweapon( var_d695710502e81d03.var_9dcef9a8722c3abb ) )
    {
        player class::function_d89bbcdf1e49045c( player.classstruct, undefined, 0 );
        gunsgiven++;
    }
    
    if ( gunsgiven > 1 )
    {
        player takeweapon( level.defaultfist );
    }
    
    equipment = [];
    
    if ( isdefined( var_d695710502e81d03.loadoutequipmentprimary ) )
    {
        equipment[ equipment.size ] = var_d695710502e81d03.loadoutequipmentprimary;
    }
    
    if ( isdefined( var_d695710502e81d03.loadoutequipmentsecondary ) )
    {
        equipment[ equipment.size ] = var_d695710502e81d03.loadoutequipmentsecondary;
    }
    
    foreach ( equipref in equipment )
    {
        scriptablename = common_item::function_70d4affb770e8103( equipref );
        item = { #count:1, #type:scriptablename };
        common_item::function_2b5e2ff57d5f392( item, 0, 0 );
    }
}

// Namespace br
// Params 0
// Checksum 0xa8240261, Offset: 0xd6df
// Size: 0x2c
function givematchloadoutfordropbags()
{
    player = self;
    player.prevweaponobj = undefined;
    player class::loadout_clearperks();
    givelaststandifneeded( player );
}

// Namespace br
// Params 0
// Checksum 0x4dce4088, Offset: 0xd713
// Size: 0x33
function prematchdeployparachute()
{
    self endon( #"disconnect" );
    
    while ( self.sessionstate != "playing" )
    {
        waitframe();
    }
    
    thread parachute::startfreefall( 2, 0, undefined, undefined, 1, 0 );
}

// Namespace br
// Params 1
// Checksum 0x3faf3130, Offset: 0xd74e
// Size: 0x93
function getprematchradius( dropstruct )
{
    radius = dropstruct.radius;
    minradius = dropstruct.minradius;
    radiusoverride = getdvarint( @"hash_3e97a62800ff7a1a", -1 );
    
    if ( radiusoverride >= 0 )
    {
        radius = radiusoverride;
    }
    
    radiusoverride = getdvarint( @"hash_cad542096552c754", -1 );
    
    if ( radiusoverride >= 0 )
    {
        minradius = radiusoverride;
    }
    
    if ( minradius >= radius )
    {
        radius = minradius + 1;
    }
    
    return [ minradius, radius ];
}

// Namespace br
// Params 1
// Checksum 0x7a2bcf75, Offset: 0xd7ea
// Size: 0xa6
function givelaststandifneeded( player )
{
    if ( level.forcedisablelaststand )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    issolos = level.maxteamsize == 1;
    hasselfrevivetoken = player laststand::hasselfrevivetoken();
    
    if ( issolos && !hasselfrevivetoken && !level.var_c8e29985e3968710 )
    {
        return;
    }
    
    if ( !iscontender( player ) )
    {
        return;
    }
    
    if ( isdefined( player.perks[ "specialty_pistoldeath" ] ) )
    {
        return;
    }
    
    if ( !isbrgamemode() )
    {
        return;
    }
    
    player perk::giveperk( "specialty_pistoldeath" );
}

// Namespace br
// Params 1
// Checksum 0x843c391d, Offset: 0xd898
// Size: 0x2bf
function waitloadoutdone( revivespawn )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self notify( #"hash_ee46d235dcd7bb0" );
    self endon( #"hash_ee46d235dcd7bb0" );
    self waittill( #"giveloadout" );
    
    if ( !isagent( self ) )
    {
        val::reset_all( "spawnVehicleDelay" );
    }
    
    if ( level.var_eda7b39474060e6 )
    {
        self.attached_bag = undefined;
        backpacksize = self getplayerdata( level.var_6f9b00680ed002d8, level.backpacksize );
        var_71057ccb7dc45dc0 = br_default_inventory::function_269d933ef7b39d72( self );
        backpack::attachbag( var_71057ccb7dc45dc0 );
    }
    
    if ( br_public::istutorial() || br_public::function_379fb7b09f4ef13e() || revivespawn )
    {
        return;
    }
    
    if ( br_public::isbrpracticemode() )
    {
        if ( !br_gametypes::isfeaturedisabled( #"armor" ) )
        {
            thread function_634ae2f481992300();
        }
        
        return;
    }
    
    fromprematch = 0;
    
    if ( !level.br_prematchstarted )
    {
        fromprematch = 1;
        thread giveprematchloadout();
        
        if ( !br_gametypes::isfeaturedisabled( #"armor" ) )
        {
            thread function_634ae2f481992300();
        }
        
        perk::giveperk( "specialty_pistoldraw" );
        
        if ( !self.prematchplayedwelcomevo )
        {
            self.prematchplayedwelcomevo = 1;
            
            if ( game_utility::getgametype() != "dmz" )
            {
                utility::delaythread( 1, &br_public::brleaderdialogplayer, "prematch_enter", self, undefined, undefined, undefined, undefined, level.brgametype.dialogprefix );
                
                if ( !flags::gameflag( "prematch_done" ) )
                {
                    br_lobby_intro = audio_utility::function_d4d265f3dcd0a13c( "br_lobby_intro" );
                    self setplayermusicstate( br_lobby_intro );
                }
            }
        }
        
        level waittill( #"infils_ready" );
        
        if ( level.allowsupers )
        {
            supers_mp::clearsuper( 0 );
        }
    }
    
    if ( level.var_8a80723669278851 )
    {
        br_weapons::br_ammo_player_clear();
    }
    
    if ( !fromprematch && !self.gulag && !br_gametypes::isfeaturedisabled( #"armor" ) )
    {
        thread function_634ae2f481992300();
    }
    
    if ( isdefined( level.var_a65dd5bf315b695b ) )
    {
        self thread [[ level.var_a65dd5bf315b695b ]]();
    }
    
    givelaststandifneeded( self );
    
    /#
        if ( getdvarint( @"hash_f66218d4c610a345", 0 ) > 0 )
        {
            if ( !level.usegulag )
            {
                level.gulag = spawnstruct();
                br_gulag::gulaggesturesinit();
            }
            
            thread br_gulag::playergulaggestures();
        }
    #/
    
    if ( self.isrespawn )
    {
        return;
    }
    
    if ( self.gulag || self.respawningbr )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "dmz" )
    {
        return;
    }
}

// Namespace br
// Params 5
// Checksum 0xbd591785, Offset: 0xdb5f
// Size: 0x32
function onplayerscore( event, player, points, victim, eventinfo )
{
    return points;
}

// Namespace br
// Params 1
// Checksum 0xd6e37282, Offset: 0xdb9a
// Size: 0xba, Type: bool
function function_e5e12e5a774d90f5( cache )
{
    player = self;
    
    if ( !level.var_3e575559a8cd5064 || level.br_circle_disabled || !isdefined( level.var_ea96217a33eb6457 ) )
    {
        return true;
    }
    
    isingas = exclusion_zones::function_1efc19de6199fff6( cache.origin, 0, 0 ) == -1 && !br_circle_util::ispointindangercircle( cache.origin, level.var_ea96217a33eb6457 );
    
    if ( isingas && player )
    {
        if ( isplayer( player ) )
        {
            player playlocalsound( "fly_pickup_deny" );
            player hud_message::showerrormessage( %"hash_7dd202adae2cb7c2" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace br
// Params 11
// Checksum 0x71de5268, Offset: 0xdc5d
// Size: 0x6d6
function brmodifyplayerdamage( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    if ( game_utility::function_d3f8957534dc62af() )
    {
        idamage = damage::gamemodemodifyplayerdamage( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 );
    }
    
    if ( isdefined( eattacker ) && eattacker.gulagjailer )
    {
        jailermaxdamage = getdvarfloat( @"br_ai_gulag_jailer_maxdamage", 49 );
        idamage = min( jailermaxdamage, idamage );
    }
    
    if ( isagent( eattacker ) && isdefined( eattacker.agent_type ) && issubstr( eattacker.agent_type, "rusher" ) && smeansofdeath == "MOD_MELEE" )
    {
        idamage = min( idamage, getdvarint( @"hash_22b45420bf5f62c5", 30 ) );
        var_cdd29ad5d1362c2 = idamage;
    }
    
    if ( victim br_public::isplayeringulag() && isagent( eattacker ) && isdefined( eattacker.agent_type ) && issubstr( eattacker.agent_type, "baton" ) )
    {
        switch ( smeansofdeath )
        {
            case #"hash_61e42661ac27b9f2":
                return idamage;
            case #"hash_17b830a6c297d440":
                return idamage;
        }
    }
    
    if ( isbot( eattacker ) && eattacker br_public::isplayeringulag() && eattacker.gulagarena )
    {
        damagedata = damage_utility::packdamagedata( eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir );
        damagedata.shitloc = shitloc;
        idamage = bots_gametype_br_super::function_3dc9b2cedb07250d( damagedata );
        return idamage;
    }
    
    if ( victim br_public::isplayeringulag() && victim.gulagarena && getdvarint( @"scr_gulag_mp_damage", 1 ) )
    {
        return idamage;
    }
    
    if ( !isdefined( var_cdd29ad5d1362c2 ) )
    {
        var_cdd29ad5d1362c2 = idamage;
    }
    
    if ( idamage > 0 )
    {
        if ( victim.insertingarmorplate && ( !victim damage_utility::function_9144ab79884c5758( objweapon ) || getdvarint( @"scr_radiation_cancelsarmor", 0 ) && !isdefined( victim.perks[ "specialty_outlander" ] ) ) )
        {
            victim notify( #"try_armor_cancel", "damage_received" );
        }
        
        if ( loot_mp::iscontaineropen( victim ) && !damage_utility::function_9144ab79884c5758( objweapon ) && !loot_mp::function_287f2ac76698bc1( victim ) )
        {
            victim notify( #"close_container" );
        }
        
        weaponrootname = weapon::getweaponrootname( objweapon );
        weapontype = weaponclass( objweapon );
        
        if ( smeansofdeath == "MOD_FALLING" )
        {
            if ( isdefined( level.modifybrfalldamage ) )
            {
                idamage = victim [[ level.modifybrfalldamage ]]( idamage );
            }
            else if ( victim killstreak::isjuggernaut() )
            {
            }
            else if ( getdvarint( @"scr_br_alt_mode_rocketjump", 0 ) )
            {
                if ( victim isskydiving() )
                {
                    victim skydive_interrupt();
                }
                
                idamage = 0;
            }
        }
        else if ( isdefined( einflictor ) && einflictor vehicle::is_vehicle() )
        {
            if ( isdefined( level.modifybrvehicledamage ) )
            {
                idamage = victim [[ level.modifybrvehicledamage ]]( idamage );
            }
        }
        else if ( weaponrootname == "iw9_dm_crossbow" && smeansofdeath != "MOD_PISTOL_BULLET" )
        {
        }
        else if ( smeansofdeath == "MOD_MELEE" )
        {
            allowscaling = istrue( self.inlaststand ) && isdefined( level.gametypebundle ) && istrue( level.gametypebundle.var_1bbadd348b2ce5ef );
            
            if ( !allowscaling )
            {
                idamage = int( var_cdd29ad5d1362c2 );
            }
            
            if ( utility::issharedfuncdefined( #"perk_cqc", #"perk_apply_effect" ) && isdefined( victim.perks[ "specialty_close_quarter" ] ) )
            {
                idamage = [[ utility::getsharedfunc( #"perk_cqc", #"perk_apply_effect" ) ]]( idamage, victim, eattacker, 0 );
            }
        }
        else if ( weapon::iskillstreakweapon( objweapon ) )
        {
            if ( victim.inlaststand && killstreak::getkillstreaknamefromweapon( objweapon ) == "precision_airstrike" )
            {
                if ( isdefined( victim.brdownedbyairstriketime ) )
                {
                    var_59cf25ff347c76c0 = gettime() - victim.brdownedbyairstriketime < ( getmatchrulesdata( "brData", "precision_airstrike_damageDebounceTime" ) ?? 5000 );
                    
                    if ( var_59cf25ff347c76c0 )
                    {
                        idamage = 0;
                    }
                }
            }
        }
        else if ( getdvarint( @"scr_br_alt_mode_gg", 0 ) && smeansofdeath != "MOD_TRIGGER_HURT" )
        {
            idamage = brclampdamagealtmodegg( idflags, weapontype, weaponrootname, shitloc, idamage );
        }
        else if ( level.var_2932c33578ad13e9 && !victim armor::hasarmor() && getdvarint( @"hash_6b68c911dbd04fd2", level.clampstepbulletdamage ) && smeansofdeath != "MOD_TRIGGER_HURT" )
        {
            idamage = brclampdamage( idflags, weapontype, weaponrootname, shitloc, var_cdd29ad5d1362c2, idamage, objweapon, smeansofdeath );
        }
        
        if ( brgulagdamagefilter( victim ) )
        {
            if ( weaponrootname != "rock_mp" )
            {
                idamage = 0;
                
                if ( isdefined( eattacker ) )
                {
                    eattacker damagefeedback::updatedamagefeedback( "standard", 0, 0, "standard", 0 );
                    
                    if ( !getdvarint( @"hash_e85a5754c5d82758", 0 ) )
                    {
                        victim damage::finishplayerdamagewrapper( einflictor, eattacker, 0, idflags, smeansofdeath, 0, objweapon, vpoint, vdir, shitloc, 0, 0, "", 0, 0, 0, 1 );
                    }
                }
            }
            else
            {
                idamage = 1;
            }
            
            if ( victim.health - idamage <= 0 )
            {
                idamage = 0;
            }
        }
        
        if ( ( isdefined( einflictor ) || level.brgametype.var_26ab2a6e5be5a425 ) && getdvarint( @"scr_br_alt_mode_rocketjump", 0 ) )
        {
            if ( function_b311f5273fea3929( smeansofdeath ) )
            {
                damagescale = getdvarfloat( @"hash_d4f0bbe5df7312cc", 0.1 );
                
                if ( eattacker == victim )
                {
                    damagescale = 0;
                }
                
                idamage = int( idamage * damagescale );
                victim thread br_alt_mode_impulse_player( einflictor, vpoint );
            }
        }
        
        if ( utility::issharedfuncdefined( #"gametype", #"hash_f35ff151066da2df" ) )
        {
            damagedata = damage_utility::packdamagedata( eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir );
            damagedata.shitloc = shitloc;
            profilestart();
            idamage = utility::callsharedfunc( #"gametype", #"hash_f35ff151066da2df", damagedata );
            profilestop();
        }
        
        weaponrootstring = getweaponrootstring( objweapon );
        
        if ( isdefined( level.brmodifyweapondamage[ weaponrootstring ] ) )
        {
            idamage = [[ level.brmodifyweapondamage[ weaponrootstring ] ]]( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 );
        }
        
        if ( isbot( eattacker ) )
        {
            damagedata = damage_utility::packdamagedata( eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir );
            damagedata.shitloc = shitloc;
            idamage = bots_gametype_br_super::function_3dc9b2cedb07250d( damagedata );
        }
    }
    
    return idamage;
}

// Namespace br
// Params 1
// Checksum 0x82981dbb, Offset: 0xe33c
// Size: 0x4d
function brmodifyvehicledamage( data )
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_b1c3c93f0fe003bc" ) )
    {
        return utility::callsharedfunc( #"gametype", #"hash_b1c3c93f0fe003bc", data );
    }
    
    return data.damage;
}

// Namespace br
// Params 1
// Checksum 0x31c8e07c, Offset: 0xe392
// Size: 0x43
function modeallowmeleevehicledamage( data )
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_7af8e4ae0ab0a773" ) )
    {
        return utility::callsharedfunc( #"gametype", #"hash_7af8e4ae0ab0a773", data );
    }
    
    return 0;
}

// Namespace br
// Params 1
// Checksum 0x3d8874c7, Offset: 0xe3de
// Size: 0x43
function modeignorevehicleexplosivedamage( data )
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_e480d1b4c1bf83f1" ) )
    {
        return utility::callsharedfunc( #"gametype", #"hash_e480d1b4c1bf83f1", data );
    }
    
    return 0;
}

// Namespace br
// Params 4
// Checksum 0x68f61831, Offset: 0xe42a
// Size: 0x4c, Type: bool
function function_416f972f3727d9f0( victim, attacker, var_bc5b68d5112061e6, assistweapon )
{
    if ( !isdefined( assistweapon ) )
    {
        return false;
    }
    
    weaponrootname = weapon::getweaponrootname( assistweapon );
    return weaponrootname == "rock_mp";
}

// Namespace br
// Params 2
// Checksum 0xa072b3a3, Offset: 0xe47f
// Size: 0x1cc, Type: bool
function function_2b99407369ed59ae( player, mover )
{
    if ( isdefined( mover ) && mover.var_58f58ae1d854e3e4 )
    {
        function_abafdefb2f831e7b( mover, player, 75, -75 );
        return true;
    }
    
    if ( isnavmeshloaded() && ( !isdefined( mover.var_87038cec80bd2c66 ) || mover.var_87038cec80bd2c66 ) )
    {
        safepoint = undefined;
        
        if ( isdefined( mover ) && !mover.var_ee2b9c9187a8adde )
        {
            safepoint = getclosestpointonnavmesh( mover.origin );
            
            if ( isdefined( safepoint ) )
            {
                testendpoint = safepoint + ( 0, 0, 5 );
                endpos = playerphysicstrace( safepoint, testendpoint );
                
                if ( endpos != testendpoint )
                {
                    safepoint = undefined;
                }
            }
        }
        
        if ( !isdefined( safepoint ) )
        {
            groundorigin = br_public::droptogroundmultitrace( player.origin, 30 );
            safepoint = getclosestpointonnavmesh( groundorigin );
        }
        
        if ( isdefined( safepoint ) && isdefined( mover ) && mover.var_6e884911217f07ff )
        {
            var_e5f1febf1918d2c9 = [];
            
            if ( isarray( mover.var_e5f1febf1918d2c9 ) )
            {
                var_e5f1febf1918d2c9 = mover.var_e5f1febf1918d2c9;
            }
            
            contents = trace::create_contents( 1, 1, 1, 1, 1, 1 );
            trace = trace::ray_trace( player gettagorigin( "tag_eye" ), safepoint, arraycombine( var_e5f1febf1918d2c9, [ mover ] ), contents );
            
            if ( isdefined( trace[ "hittype" ] ) && trace[ "hittype" ] != "hittype_none" || !canspawn( safepoint ) )
            {
                safepoint = undefined;
            }
        }
        
        if ( isdefined( safepoint ) )
        {
            player setorigin( safepoint );
            return true;
        }
    }
    
    return false;
}

// Namespace br
// Params 2
// Checksum 0x9e13c6ce, Offset: 0xe654
// Size: 0x227
function br_alt_mode_impulse_player( einflictor, vpoint )
{
    playercenter = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 36 );
    
    if ( self isonground() )
    {
        tracestart = self.origin + ( 0, 0, 18 );
        traceend = self.origin + ( 0, 0, 90 );
        contents = trace::create_contents( 0, 1, 0, 1, 1, 0, 1 );
        var_df23d78146ad82b = trace::capsule_trace_passed( tracestart, traceend, 12, 72, undefined, einflictor, contents );
        
        if ( var_df23d78146ad82b )
        {
            neworigin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 18 );
            self setorigin( neworigin );
        }
    }
    
    impulseorigin = level.brgametype.var_26ab2a6e5be5a425 ? vpoint : einflictor.origin;
    vdir = playercenter - impulseorigin;
    vdir = vectornormalize( vdir );
    var_85b54c8f83bd18fa = getdvarfloat( @"hash_f904c89ec86aed27", 1300 );
    minz = undefined;
    
    if ( vdir[ 2 ] > -0.3 )
    {
        minz = getdvarfloat( @"hash_1b50fa9f9d44136f", 600 );
    }
    
    explosiondist = distance2d( impulseorigin, self.origin ) - 20;
    distscalar = clamp( explosiondist, 0, 80 ) / 100 * 0.5;
    basescalar = 1;
    scalar = basescalar - distscalar;
    vdir = vdir * var_85b54c8f83bd18fa * scalar;
    
    if ( isdefined( minz ) )
    {
        minzscalar = basescalar - distscalar * 0.5;
        minz *= minzscalar;
        vdir = ( vdir[ 0 ], vdir[ 1 ], max( minz, vdir[ 2 ] ) );
    }
    
    self setvelocity( vdir );
}

// Namespace br
// Params 1
// Checksum 0xad40fc28, Offset: 0xe883
// Size: 0x16d
function function_b311f5273fea3929( smeansofdeath )
{
    var_cb7896c2f6b00eb9 = !isdefined( level.var_1d1489046ec43acf );
    
    /#
        var_cb7896c2f6b00eb9 = var_cb7896c2f6b00eb9 || getdvarint( @"hash_dacba2db6c050591", 0 );
    #/
    
    if ( var_cb7896c2f6b00eb9 )
    {
        /#
            setdvar( @"hash_dacba2db6c050591", 0 );
        #/
        
        if ( getdvarint( @"hash_33ac50155c7ef8f8", 0 ) )
        {
            availablemods = [ "MOD_EXPLOSIVE_BULLET", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_IMPACT", "MOD_FIRE", "MOD_FIRE_BULLET" ];
            level.var_1d1489046ec43acf = [];
            
            for ( i = 0; i < availablemods.size ; i++ )
            {
                moddvarstr = hashcat( @"hash_69cfaef4362b6a26", tolower( availablemods[ i ] ) );
                
                if ( getdvarint( moddvarstr ) )
                {
                    level.var_1d1489046ec43acf[ level.var_1d1489046ec43acf.size ] = availablemods[ i ];
                }
            }
        }
        else
        {
            level.var_1d1489046ec43acf = [ "MOD_EXPLOSIVE", "MOD_EXPLOSIVE_BULLET", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE_SPLASH", "MOD_FIRE" ];
        }
    }
    
    return arraycontains( level.var_1d1489046ec43acf, smeansofdeath );
}

// Namespace br
// Params 5
// Checksum 0x5439945e, Offset: 0xe9f9
// Size: 0xda
function brclampdamagealtmodegg( idflags, weapontype, weaponrootname, shitloc, idamage )
{
    if ( isdefined( idflags ) && idflags & 8 )
    {
        var_41d9c6854b76aec5 = 1;
    }
    else
    {
        var_41d9c6854b76aec5 = 0;
    }
    
    if ( !var_41d9c6854b76aec5 )
    {
        switch ( weapontype )
        {
            case #"hash_719417cb1de832b6":
                if ( weaponrootname == "iw8_pi_decho" || weaponrootname == "iw8_pi_cpapa" )
                {
                    if ( shitloc == "head" || shitloc == "helmet" )
                    {
                        idamage = 250;
                    }
                    else
                    {
                        idamage = 150;
                    }
                }
                
                break;
            case #"hash_6191aaef9f922f96":
                if ( weaponrootname == "iw9_dm_crossbow" )
                {
                    idamage = 250;
                }
                
                break;
            default:
                break;
        }
    }
    
    return idamage;
}

// Namespace br
// Params 1
// Checksum 0x96d6fcfb, Offset: 0xeadc
// Size: 0x18, Type: bool
function isbulletpenetration( idflags )
{
    return isdefined( idflags ) && idflags & 8;
}

// Namespace br
// Params 1
// Checksum 0xa9b61562, Offset: 0xeafd
// Size: 0x44, Type: bool
function issnipersemi( weaponrootname )
{
    return weaponrootname == "iw8_sn_delta" || weaponrootname == "iw8_sn_golf28" || weaponrootname == "iw8_sn_mike14" || weaponrootname == "iw8_sn_sbeta" || weaponrootname == "iw8_sn_sksierra";
}

// Namespace br
// Params 3
// Checksum 0xab6f956b, Offset: 0xeb4a
// Size: 0x3b, Type: bool
function isxmike109explosivedamage( weaponrootname, smeansofdeath, idamage )
{
    return weaponrootname == "iw8_sn_xmike109" && smeansofdeath == "MOD_PISTOL_BULLET" && idamage == 1;
}

// Namespace br
// Params 8
// Checksum 0x765daef5, Offset: 0xeb8e
// Size: 0x2c3
function brclampdamage( idflags, weapontype, weaponrootname, shitloc, var_cdd29ad5d1362c2, idamage, objweapon, smeansofdeath )
{
    var_41d9c6854b76aec5 = isbulletpenetration( idflags );
    
    if ( !var_41d9c6854b76aec5 )
    {
        switch ( weapontype )
        {
            case #"hash_8cdaf2e4ecfe5b51":
                scaler = idamage / var_cdd29ad5d1362c2;
                
                if ( getweaponammopoolname( objweapon ) == %"hash_6aa606a18241ad16" )
                {
                    if ( level.br_slugmaxdamage >= 0 )
                    {
                        scaler = idamage / var_cdd29ad5d1362c2;
                        idamage = min( idamage, level.br_slugmaxdamage );
                        idamage = int( scaler * idamage );
                    }
                    
                    break;
                }
                
                if ( weaponrootname == "iw8_ar_falpha" )
                {
                    arclamp = 1;
                }
                else
                {
                    arclamp = level.clampstepbulletdamage;
                }
                
                idamage = brclampstepdamage( var_cdd29ad5d1362c2, objweapon, arclamp, idflags );
                idamage = int( scaler * idamage );
                break;
            case #"hash_719417cb1de832b6":
            case #"hash_fa24dff6bd60a12d":
                scaler = idamage / var_cdd29ad5d1362c2;
                idamage = brclampstepdamage( var_cdd29ad5d1362c2, objweapon, level.clampstepbulletdamage, idflags );
                idamage = int( scaler * idamage );
                break;
            case #"hash_6191aaef9f922f96":
                if ( shitloc == "head" || shitloc == "helmet" )
                {
                    if ( isxmike109explosivedamage( weaponrootname, smeansofdeath, idamage ) )
                    {
                        idamage = 75;
                    }
                    else if ( issnipersemi( weaponrootname ) )
                    {
                        idamage = 175;
                    }
                    else
                    {
                        idamage = 250;
                    }
                }
                else if ( isxmike109explosivedamage( weaponrootname, smeansofdeath, idamage ) )
                {
                    return idamage;
                }
                else if ( weaponrootname == "iw9_dm_crossbow" )
                {
                    idamage = 200;
                }
                else
                {
                    scaler = idamage / var_cdd29ad5d1362c2;
                    
                    if ( issnipersemi( weaponrootname ) )
                    {
                        sniperclamp = 1;
                    }
                    else
                    {
                        sniperclamp = level.clampstepbulletdamage;
                    }
                    
                    idamage = brclampstepdamage( var_cdd29ad5d1362c2, objweapon, sniperclamp, idflags );
                    idamage = int( scaler * idamage );
                }
                
                break;
            case #"hash_900cb96c552c5e8e":
                scaler = idamage / var_cdd29ad5d1362c2;
                idamage = brclampstepdamage( var_cdd29ad5d1362c2, objweapon, 3, idflags );
                idamage = int( scaler * idamage );
                break;
            case #"hash_690c0d6a821b42e":
                if ( level.br_pelletmaxdamage >= 0 )
                {
                    if ( ( weaponrootname == "iw8_sh_oscar12" || weaponrootname == "iw8_sh_aalpha12" ) && level.br_pelletmaxdamagefast >= 0 )
                    {
                        var_f569ff2b8e0c7636 = level.br_pelletmaxdamagefast;
                    }
                    else
                    {
                        var_f569ff2b8e0c7636 = level.br_pelletmaxdamage;
                    }
                    
                    scaler = idamage / var_cdd29ad5d1362c2;
                    idamage = min( idamage, var_f569ff2b8e0c7636 );
                    idamage = int( scaler * idamage );
                }
            default:
                break;
        }
    }
    
    return idamage;
}

// Namespace br
// Params 1
// Checksum 0x616849bb, Offset: 0xee5a
// Size: 0x27, Type: bool
function brgulagdamagefilter( player )
{
    return player.gulag && !player.gulagarena;
}

// Namespace br
// Params 4
// Checksum 0xc72c2ec6, Offset: 0xee8a
// Size: 0xc7
function brclampstepdamage( var_cdd29ad5d1362c2, weapon, stepclamp, idflags )
{
    var_551535f4a3ade4ad = 0;
    
    if ( idflags & 262144 )
    {
        weapondamagetype = 2;
    }
    else
    {
        weapondamagetype = 0;
    }
    
    if ( stepclamp == 4 )
    {
        var_551535f4a3ade4ad = weapon getmid3damage( weapondamagetype );
    }
    else if ( stepclamp == 3 )
    {
        var_551535f4a3ade4ad = weapon getmid2damage( weapondamagetype );
    }
    else if ( stepclamp == 2 )
    {
        var_551535f4a3ade4ad = weapon getmid1damage( weapondamagetype );
    }
    
    if ( var_551535f4a3ade4ad <= 0 )
    {
        var_551535f4a3ade4ad = weapon getmindamage( weapondamagetype );
    }
    
    if ( stepclamp == 1 || var_551535f4a3ade4ad <= 0 )
    {
        var_551535f4a3ade4ad = weapon getmaxdamage( weapondamagetype );
    }
    
    if ( var_cdd29ad5d1362c2 < var_551535f4a3ade4ad )
    {
        return int( var_551535f4a3ade4ad );
    }
    
    return var_cdd29ad5d1362c2;
}

// Namespace br
// Params 15
// Checksum 0xd45f7237, Offset: 0xef59
// Size: 0x317
function onplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage )
{
    damagedata = damage_utility::packdamagedata( eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir, undefined, undefined, undefined, undefined, undefined, undefined, shitloc, lightarmordamage );
    utility::callsharedfunc( #"gametype", #"onPlayerDamaged", damagedata );
    
    if ( victim.gulag )
    {
        arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( victim );
        
        if ( isdefined( arena ) )
        {
            if ( !isdefined( victim.var_f4ced78321048739 ) )
            {
                victim.var_f4ced78321048739 = 0;
            }
            
            victim.var_f4ced78321048739 += idamage;
        }
    }
    
    if ( eattacker != victim && isplayer( eattacker ) )
    {
        if ( idamage >= var_ca02bfdd611a56f4 )
        {
            idamage = var_ca02bfdd611a56f4;
        }
        
        if ( idamage > 0 )
        {
            victim br_ftue_popups::function_882bc4a418cc66db();
            
            if ( objweapon.basenamehash == %"rock_mp" && isalive( victim ) )
            {
                victim playlocalsound( "br_gulag_rock_player_impact" );
            }
        }
        
        eattacker br_public::updatebrscoreboardstat( "damageDealt", eattacker.pers[ "damage" ] );
    }
    else if ( isdefined( einflictor ) && einflictor vehicle::is_vehicle() )
    {
        vehicle = einflictor;
        
        if ( isplayer( vehicle.owner ) && vehicle.owner != victim )
        {
            victim br_ftue_popups::function_882bc4a418cc66db();
            vehicle.owner br_public::updatebrscoreboardstat( "damageDealt", vehicle.owner.pers[ "damage" ] );
        }
    }
    else if ( isdefined( eattacker ) && eattacker vehicle::is_vehicle() )
    {
        vehicle = eattacker;
        
        if ( isplayer( vehicle.owner ) && vehicle.owner != victim )
        {
            victim br_ftue_popups::function_882bc4a418cc66db();
            vehicle.owner br_public::updatebrscoreboardstat( "damageDealt", vehicle.owner.pers[ "damage" ] );
        }
    }
    else if ( eattacker != victim && isagent( eattacker ) )
    {
        victim br_ftue_popups::function_882bc4a418cc66db();
    }
    
    if ( isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon ) )
    {
        killedbyairstrike = idamage >= var_ca02bfdd611a56f4 && killstreak::getkillstreaknamefromweapon( objweapon ) == "precision_airstrike";
        var_631b3f1fa0429d41 = istrue( victim.inlaststand );
        
        if ( killedbyairstrike && var_631b3f1fa0429d41 )
        {
            victim.brdownedbyairstriketime = gettime();
        }
    }
}

// Namespace br
// Params 6
// Checksum 0x2d6cbdfa, Offset: 0xf278
// Size: 0x19d
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !level.br_prematchstarted )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_23084725a4675de7" ) )
    {
        utility::callsharedfunc( #"gametype", #"hash_23084725a4675de7", victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    }
    
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( victim isswimming() )
    {
        function_1fbc342360eed417( victim );
    }
    else
    {
        victim.consecutivesuicides = 0;
    }
    
    if ( game_utility::getgametype() == "dmz" || game_utility::getgametype() == "plunder" || game_utility::getgametype() == "kingslayer" )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        liveplayers = game_utility_mp::getlivingplayers();
        victim.score = level.totalplayers - liveplayers.size;
        
        foreach ( player in liveplayers )
        {
            player.score = victim.score + 1;
        }
    }
}

// Namespace br
// Params 1
// Checksum 0xbd0a7c98, Offset: 0xf41d
// Size: 0x1d8
function function_8d7ce309210fce88( includegulag )
{
    alivecounttotal = 0;
    
    if ( includegulag )
    {
        foreach ( entry in level.teamnamelist )
        {
            alivecounttotal += teams::getteamdata( entry, "aliveCount" );
        }
    }
    else
    {
        foreach ( entry in level.teamnamelist )
        {
            alivecount = teams::getteamdata( entry, "aliveCount" );
            
            if ( alivecount )
            {
                aliveplayers = teams::getteamdata( entry, "alivePlayers" );
                
                foreach ( player in aliveplayers )
                {
                    if ( isdefined( player ) && !player.gulag && !player function_a29e5f57c1ef9e35() )
                    {
                        alivecounttotal += 1;
                    }
                }
            }
        }
    }
    
    alivecounttotal += function_6f7e22d4e6adac55();
    return alivecounttotal;
}

// Namespace br
// Params 1
// Checksum 0x6eb6f648, Offset: 0xf5fe
// Size: 0x48
function getalivecount( includegulag )
{
    if ( getdvarint( @"hash_e56d26f512acb545", 0 ) )
    {
        return function_8d7ce309210fce88( includegulag );
    }
    
    if ( includegulag )
    {
        return level.var_fc71e82557e9a9c2;
    }
    
    return level.var_fc71e82557e9a9c2 - level.var_bb25c34ae28e413f;
}

// Namespace br
// Params 2
// Checksum 0x80ee67b1, Offset: 0xf64f
// Size: 0x108
function doplayerkilledsplashes( victim, attacker )
{
    if ( victim.var_e436fb0d53597797 )
    {
        victim.var_e436fb0d53597797 = undefined;
        return;
    }
    
    if ( level.usegulag && victim br_public::isplayeringulag() )
    {
        return;
    }
    
    if ( level.var_a27e6eedf72c9dd1 )
    {
        return;
    }
    
    teammates = teams::function_d032b36d01bbbab3( victim.team, victim.sessionsquadid, 1 );
    
    foreach ( teammate in teammates )
    {
        if ( !isdefined( teammate ) )
        {
            continue;
        }
        
        if ( teammate != victim )
        {
            teammate thread hud_message::showsplash( "br_teammate_dead", undefined, victim );
        }
    }
}

// Namespace br
// Params 0
// Checksum 0x9a9da604, Offset: 0xf75f
// Size: 0x6f
function shutdowngulagforalivecount()
{
    if ( level.usegulag && !level.gulag.shutdown )
    {
        var_85da2d056d5ef24c = getdvarint( @"hash_2665fc757a822eb2", -1 );
        
        if ( var_85da2d056d5ef24c < 0 )
        {
            return;
        }
        
        count = getalivecount( 0 );
        
        if ( count <= var_85da2d056d5ef24c )
        {
            br_gulag::shutdowngulag( "player_count", count );
        }
    }
}

// Namespace br
// Params 1
// Checksum 0xede01288, Offset: 0xf7d6
// Size: 0x280
function onplayerdisconnect( player )
{
    if ( !br_gametypes::isfeaturedisabled( #"teamspectate" ) )
    {
        if ( !player rejoin_utility::function_e421863f0f4de34() && !player manager::isuibot() )
        {
            br_spectate::migratespectators( player, undefined, 0 );
        }
    }
    
    level thread updateplayerandteamcountui();
    
    if ( level.br_prematchstarted )
    {
        shutdowngulagforalivecount();
        br_gulag::onplayerdisconnect( player );
        shouldhandledeath = player.inlaststand && !player function_a29e5f57c1ef9e35() && game_utility::getgametype() != "plunder" && game_utility::getgametype() != "kingslayer" && level.var_6af8c7e49b1398b2 && !player.var_4b1f798ecbed7345;
        
        if ( shouldhandledeath )
        {
            if ( dmz_dog_tag::function_8ee07314dbc6f4d7() )
            {
                dmz_dog_tag::function_34d0a7ddfa21db1c( player, player.laststandattacker );
            }
            
            if ( isdefined( player.laststandattacker ) )
            {
                [ suspiciouskill, suspiciousdown ] = player.attacker function_9ba73c5ed781b998( player, player.laststandattacker, 1 );
                
                if ( suspiciouskill <= 0 && suspiciousdown <= 0 )
                {
                    player.laststandattacker damage::playerincrementscoreboardkills( player );
                }
            }
        }
    }
    
    br_analytics::branalytics_disconnect( player, int( player::isreallyalive( player ) ) );
    
    if ( isdefined( player.var_1c8f83acf99b4207 ) && isdefined( player.var_7d6bcb4efeec5380 ) && !player manager::isuibot() )
    {
        player dlog_recordplayerevent( "dlog_event_br_anticheat_player_assists", [ "attacker_player", player.var_7d6bcb4efeec5380, "victim_player", player.var_1c8f83acf99b4207 ] );
        player.var_7d6bcb4efeec5380 = undefined;
        player.var_1c8f83acf99b4207 = undefined;
    }
    
    utility::callsharedfunc( #"gametype", #"onPlayerDisconnect", player );
    
    if ( level.var_6af8c7e49b1398b2 && level.br_prematchstarted && !level.gameended && !player.infilactive && player::isreallyalive( player ) && game_utility::getgametype() != "dmz" && !isbot( player ) )
    {
        player droponplayerdeath();
    }
    
    br_elite_broken_arrow::arrow_onplayerdisconnect( player );
}

// Namespace br
// Params 2
// Checksum 0xc87ba56c, Offset: 0xfa5e
// Size: 0x239
function droponplayerdeath( attacker, killedbyvehicle )
{
    victim = self;
    
    if ( getdvarint( @"hash_18c54f044520ba50", 0 ) )
    {
        if ( isbot( victim ) )
        {
            return;
        }
    }
    
    if ( getdvarint( @"hash_307fc239dc43be41", 0 ) )
    {
        return;
    }
    
    disabledropondeath = victim.disabledropondeath;
    victim.disabledropondeath = undefined;
    
    if ( disabledropondeath )
    {
        return;
    }
    
    if ( game_utility_mp::isteamreviveenabled() )
    {
        self.var_640934ba73e304d6 = 1;
    }
    
    if ( utility::callsharedfunc( #"gametype", #"droponplayerdeath" ) )
    {
        return;
    }
    
    if ( !br_gulag::function_b31a927d9159eb86() )
    {
        return;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( victim );
    spawnoptions.isdeathevent = 1;
    spawnoptions.var_50e31f8c119ef961 = 0;
    spawnoptions.analyticssource = "death";
    
    if ( !level.var_4cfd4ec4016c4601 )
    {
        spawnoptions.var_50e31f8c119ef961 = 1;
    }
    else if ( !level.var_1acc5d70465c5287 && killedbyvehicle )
    {
        spawnoptions.var_50e31f8c119ef961 = 1;
    }
    
    additionalitems = level callback::response( 6, #"hash_ab3afa9c65b57dc9", { #victim:victim, #attacker:attacker } );
    
    if ( level.gametypebundle.var_41e0ba91419c8833 )
    {
        var_7a166247da860246 = victim common_inventory::function_4c281d89a14b4a16( spawnoptions ).var_7a166247da860246;
        var_7a166247da860246 = arraycombine( var_7a166247da860246, additionalitems );
        
        if ( var_7a166247da860246.size > 0 )
        {
            backpack = common_item::function_61c2c0251e742ffd( level.gametypebundle.var_41e0ba91419c8833, 1, spawnoptions );
            var_2501b96e55995719 = common_item::items_initspawnoptions_spawnfromentity( backpack );
            var_2501b96e55995719.var_7a166247da860246 = var_7a166247da860246;
            backpack.spawnoptions = var_2501b96e55995719;
        }
    }
    else
    {
        victim common_inventory::function_4c281d89a14b4a16( spawnoptions );
        spawnoptions.var_7a166247da860246 = arraycombine( spawnoptions.var_7a166247da860246, additionalitems );
        level thread common_inventory::function_993f81a1c4d8bbc1( spawnoptions );
    }
    
    self notify( #"hash_12374a61aa115bf5" );
}

// Namespace br
// Params 1
// Checksum 0x6668dd7e, Offset: 0xfc9f
// Size: 0x216
function function_f5856ce19f60fb97( weaponsdropped )
{
    player = self;
    level endon( #"game_ended" );
    var_b3ede3fa0568e1a4 = 300000;
    droptime = gettime();
    
    foreach ( item in weaponsdropped )
    {
        if ( isdefined( item ) && !item.critical )
        {
            item.critical = 1;
        }
    }
    
    while ( true )
    {
        wait 5;
        
        if ( !isdefined( player ) || player.disconnecting )
        {
            break;
        }
        
        weaponsdropped = function_5713d46873b29625( weaponsdropped );
        
        if ( weaponsdropped.size == 0 )
        {
            break;
        }
        
        foreach ( weapon in weaponsdropped )
        {
            var_89ed9f13198e75fe = scriptable_group_spatial::is_instance_in_gas( weapon );
            
            if ( var_89ed9f13198e75fe )
            {
                weapon.critical = undefined;
                weaponsdropped = arrayremove( weaponsdropped, weapon );
            }
        }
        
        if ( gettime() - droptime >= var_b3ede3fa0568e1a4 )
        {
            break;
        }
    }
    
    foreach ( item in weaponsdropped )
    {
        if ( isdefined( item ) )
        {
            item.critical = undefined;
        }
    }
}

// Namespace br
// Params 1
// Checksum 0x9858c1d2, Offset: 0xfebd
// Size: 0x20a
function function_8906dfc9917bf7b( player )
{
    if ( isdefined( player ) && !player manager::isuibot() && player.team != "codcaster" )
    {
        enemyteams = team_utility::getenemyteams( player.team );
        remainingteams = [];
        
        foreach ( entry in enemyteams )
        {
            uibotcount = function_e45241986b39c3a8( entry );
            
            if ( teams::getteamdata( entry, "aliveCount" ) || uibotcount > 0 )
            {
                remainingteams[ remainingteams.size ] = entry;
            }
        }
        
        teamplacement = remainingteams.size + 1;
        
        if ( flags::gameflag( "prematch_done" ) )
        {
            if ( !player.extracted )
            {
                [ brbonusxp, var_245a2f5a93850587, var_33c0e792d2053e19 ] = player calculatebrbonusxp( teamplacement, player.team );
                
                if ( brbonusxp > 0 )
                {
                    player givebrbonusxp( brbonusxp, undefined, "disconnect" );
                    player.matchbonus = var_245a2f5a93850587;
                    player.placementbonus = var_33c0e792d2053e19;
                    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
                    
                    if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
                    {
                        gamelogic_mp::function_a7f2ba55c82bfa95( player );
                    }
                }
                
                player setplacementstats( teamplacement );
                gamelogic_mp::_setplayerteamrank( player, teamplacement );
                updateclientmatchdata( player );
                player gamelogic_mp::function_93ec47a6ed4b516b();
            }
        }
        
        player thread handlebrdefeatedpostgamestate( teamplacement );
    }
}

// Namespace br
// Params 0
// Checksum 0x3aab59ee, Offset: 0x100cf
// Size: 0xea
function function_81c3d73b94698167()
{
    player = self;
    
    if ( !level.var_fd0d570b65132e4f )
    {
        return;
    }
    
    for ( i = 0; i < player common_inventory::function_9cd65c8312048802() ; i++ )
    {
        currentlootid = player common_inventory::inventory_getlootidatbackpackindex( i );
        currentquantity = player br_default_inventory::getquantityatbackpackindex( i );
        player setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, i, "lootID", 1 );
        player setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, i, "quantity", 1 );
        player setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, i, "lootID", currentlootid );
        player setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, i, "quantity", currentquantity );
    }
}

// Namespace br
// Params 1
// Checksum 0x55db70f0, Offset: 0x101c1
// Size: 0x44
function updateclientmatchdata( player )
{
    gamelogic_mp::processlobbydataforclient( player );
    scoreboard::processcommonplayerdataforplayer( player );
    var_2505a68ce1f149cd = getdvarint( @"online_mp_clientmatchdata_enabled", 0 );
    
    if ( var_2505a68ce1f149cd )
    {
        player sendclientmatchdataforclient();
    }
}

// Namespace br
// Params 10
// Checksum 0x6dc4918b, Offset: 0x1020d
// Size: 0x3a7
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    deathdata = damage_utility::packdamagedata( attacker, self, idamage, objweapon, smeansofdeath, einflictor, undefined, vdir );
    
    if ( isdefined( attacker ) )
    {
        var_b5fb56ce2f5f56fa = function_11eb4174b39b6c4c( [ attacker.team ] );
        attacker.teamplacement = getteamplacement( var_b5fb56ce2f5f56fa );
    }
    
    callback::callback( "br_player_killed_early", deathdata );
    
    if ( level.br_prematchstarted )
    {
        if ( dmz_dog_tag::function_8ee07314dbc6f4d7() )
        {
            dmz_dog_tag::function_34d0a7ddfa21db1c( self, attacker, smeansofdeath );
        }
        
        if ( smeansofdeath == "MOD_EXECUTION" )
        {
            self.wasexecuted = 1;
        }
        else
        {
            self.wasexecuted = 0;
        }
        
        killedbyvehicle = damage::playerkilled_washitbyvehicle( smeansofdeath, einflictor );
        droponplayerdeath( attacker, killedbyvehicle );
        doplayerkilledsplashes( self, attacker );
        shutdowngulagforalivecount();
        br_utility::function_98eeb9dcfa19a943( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    }
    
    br_jugg_common::onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    
    if ( attacker.gulag )
    {
        if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagOnPlayerKilled" ) )
        {
            namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagOnPlayerKilled", attacker );
        }
    }
    
    br_weapons::br_ammo_player_clear();
    var_da57c852045d3fb1 = self.lastdroppableweaponobj;
    var_da57c852045d3fb1 = weapon::mapweapon( var_da57c852045d3fb1, einflictor );
    
    if ( isdefined( var_da57c852045d3fb1 ) )
    {
        thread gamelogic_mp::trackleaderboarddeathstats( attacker, self, var_da57c852045d3fb1, smeansofdeath );
        self.var_e3b23da2a73823c5 = self.lifeid;
    }
    
    if ( !isbot( self ) )
    {
        resetplayerinventory( undefined, undefined, 1 );
    }
    
    onplayerscore( "kill", attacker, 0, self );
    
    if ( isdefined( self.laststandoutlineid ) )
    {
        outline::outlinedisable( self.laststandoutlineid, self );
        self.laststandoutlineid = undefined;
    }
    
    namespace_ddca46d216b096e2::logplayerkilled( attacker, self, smeansofdeath, idamage );
    thread utility::callsharedfunc( #"gametype", #"onplayerkilled", deathdata );
    callback::callback( "br_player_killed", deathdata );
    
    if ( !level.br_prematchstarted )
    {
        br_plunder::playerplunderlivelobbydropondeath( smeansofdeath );
        return;
    }
    
    if ( level.br_strongholds )
    {
        if ( getdvarint( @"hash_ec7375cc2a0ca633", 1 ) )
        {
            br_analytics::function_5d67df7eec58703f( deathdata );
        }
        
        thread br_task_person_of_interest::brtask_onplayerkilled( deathdata );
    }
    
    if ( namespace_5ab67a14d18bea3f::function_43c57123ed24d409() )
    {
        thread namespace_5ab67a14d18bea3f::onplayerkilled( attacker, self );
    }
    
    thread br_contract_manager::onplayerkilled( attacker, self );
    thread br_respawn::playerdied( attacker, objweapon );
    br_public::setplayerdownedextrainfo( 0 );
    laststand::setplayerbeingrevivedextrainfo( 0 );
    laststand::updatesquadmemberlaststandreviveprogress( self, self, 0, 1 );
    
    if ( self.inlaststand )
    {
        if ( isplayer( attacker ) )
        {
            attacker incrementcleanupsstat();
        }
    }
    
    eliminated = utility::callsharedfunc( #"gametype", #"markplayeraseliminatedonkilled" );
    
    if ( !isdefined( eliminated ) )
    {
        eliminated = !level.usegulag;
    }
    
    if ( eliminated )
    {
        br_utility::markplayeraseliminated( self, "onPlayerKilled" );
    }
    
    if ( br_public::isbrpracticemode() )
    {
        if ( isbot( self ) && isplayer( attacker ) && !attacker br_public::isplayeringulag() )
        {
            attacker notify( #"killed_enemy" );
        }
    }
    
    if ( getdvarint( @"hash_5854369d7b98c88b", 0 ) )
    {
        self setclientomnvar( "ui_br_multi_circle_player_inside", 0 );
    }
    
    level thread updateplayerandteamcountui();
    level notify( #"player_killed" );
}

// Namespace br
// Params 0
// Checksum 0xaa955ed1, Offset: 0x105bc
// Size: 0x4f
function incrementcleanupsstat()
{
    player = self;
    
    if ( !isdefined( player.br_cleanups ) )
    {
        player.br_cleanups = 0;
    }
    
    player.br_cleanups++;
    player br_public::updatebrscoreboardstat( "cleanups", player.br_cleanups );
}

// Namespace br
// Params 1
// Checksum 0x1831218f, Offset: 0x10613
// Size: 0x29
function registercrateforcleanup( crate )
{
    level.br_crates = arraycombineunique( level.br_crates, [ crate ] );
}

// Namespace br
// Params 1
// Checksum 0xf9a253f5, Offset: 0x10644
// Size: 0x69
function unregistercrateforcleanup( crate )
{
    if ( isdefined( crate ) && arraycontains( level.br_crates, crate ) )
    {
        level.br_crates = arrayremove( level.br_crates, crate );
        level.br_crates = function_5713d46873b29625( level.br_crates );
        level.br_crates = arrayremoveduplicates( level.br_crates );
    }
}

// Namespace br
// Params 0
// Checksum 0x8a698de, Offset: 0x106b5
// Size: 0x227
function initloot()
{
    level.br_weaponweights = [];
    level.br_weaponweights[ "iw8_ar_mike4" ] = 20;
    level.br_weaponweights[ "iw8_sm_mpapa5" ] = 40;
    level.br_weaponweights[ "iw8_sh_dpapa12" ] = 40;
    level.br_weaponweights[ "iw8_la_gromeo" ] = 30;
    level.br_weaponweights[ "iw8_lm_kilo121" ] = 10;
    level.br_weaponweights[ "iw8_sn_alpha50" ] = 10;
    level.br_weaponweights[ "iw8_knife" ] = 5;
    level.br_weaponweights[ "iw8_pi_golf21" ] = 50;
    level.br_weaponweights[ "iw8_ar_akilo47" ] = 20;
    level.br_weaponweighttotal = 0;
    
    foreach ( weight in level.br_weaponweights )
    {
        level.br_weaponweighttotal += weight;
    }
    
    level.baseraritymap = [];
    level.baseraritymap[ "iw8_ar_mike4" ] = 1;
    level.baseraritymap[ "iw8_ar_akilo47" ] = 1;
    level.baseraritymap[ "iw8_sm_mpapa5" ] = 1;
    level.baseraritymap[ "iw8_sh_dpapa12" ] = 1;
    level.baseraritymap[ "iw8_la_gromeo" ] = 1;
    level.baseraritymap[ "iw8_lm_kilo121" ] = 1;
    level.baseraritymap[ "iw8_sn_alpha50" ] = 3;
    level.baseraritymap[ "iw8_knife" ] = 0;
    level.baseraritymap[ "iw8_pi_golf21" ] = 0;
    level.attachraritymap = [];
    level.attachraritymap[ "holo" ] = 1;
    level.attachraritymap[ "silencer" ] = 2;
    level.attachraritymap[ "gl" ] = 2;
}

// Namespace br
// Params 2
// Checksum 0x47325e2f, Offset: 0x108e4
// Size: 0x108, Type: bool
function weaponlocallowed( loc, locused )
{
    foreach ( l in locused )
    {
        low = l.origin[ 2 ] - 24;
        high = l.origin[ 2 ] + 90 - 24;
        
        if ( distance2dsquared( l.origin, loc.origin ) < 147456 && loc.origin[ 2 ] >= low && loc.origin[ 2 ] <= high )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br
// Params 1
// Checksum 0x1c1191f0, Offset: 0x109f5
// Size: 0x35
function startendgame( firsttime )
{
    if ( function_ee15a28564f11e4e() )
    {
        return;
    }
    
    gamelogic_mp::pausetimer();
    level.timepausestart = gettime();
    level.timelimitoverride = 1;
}

// Namespace br
// Params 1
// Checksum 0xb7c3fa06, Offset: 0x10a32
// Size: 0x14e
function debugtestcirclevfx( number )
{
    if ( isdefined( level.circleemitters ) )
    {
        destroyemitters( level.circleemitters );
    }
    
    level notify( #"hash_7da589985ebacc0b" );
    waitframe();
    
    switch ( number )
    {
        case 1:
            level thread rundebugvfxcircletest( 1000, 0, 15, 2000 );
            break;
        case 2:
            level thread rundebugvfxcircletest( 2500, 1000, 20, 2000 );
            break;
        case 3:
            level thread rundebugvfxcircletest( 4500, 2500, 25, 2000 );
            break;
        case 4:
            level thread rundebugvfxcircletest( 7000, 4500, 40, 2000 );
            break;
        case 5:
            level thread rundebugvfxcircletest( 10500, 7000, 70, 2000 );
            break;
        case 6:
            level thread rundebugvfxcircletest( 15000, 10500, 80, 2000 );
            break;
        case 7:
            level thread rundebugvfxcircletest( 20000, 15000, 80, 2000 );
            break;
        case 8:
            level thread rundebugvfxcircletest( 50000, 20000, 80, 2000 );
            break;
    }
}

// Namespace br
// Params 1
// Checksum 0xb100e7e4, Offset: 0x10b88
// Size: 0x9c
function groundraycast( pos )
{
    contents = trace::create_contents( 0, 1, 0, 0, 1, 1 );
    caststart = pos + ( 0, 0, 10000 );
    castend = caststart + ( 0, 0, -20000 );
    castresults = physics_raycast( caststart, castend, contents, undefined, 0, "physicsquery_closest", 1 );
    
    if ( isdefined( castresults ) && castresults.size > 0 )
    {
        return castresults[ 0 ][ "position" ];
    }
    
    return ( 0, 0, 0 );
}

// Namespace br
// Params 0
// Checksum 0x1f9c10c2, Offset: 0x10c2d
// Size: 0xea
function debugplayercirclevfx()
{
    while ( true )
    {
        waitframe();
        
        if ( !( isdefined( level.circledebugpos ) && isdefined( level.circledebugradius ) ) )
        {
            continue;
        }
        
        incircle = distance2d( self.origin, level.circledebugpos ) < level.circledebugradius;
        
        if ( self.debugcircleincircle )
        {
            if ( !incircle && level.debugcircleplayerfx == 0 )
            {
                playfxontag( level._effect[ "vfx_gas_ring_player" ], self, "tag_eye" );
                level.debugcircleplayerfx = 1;
                self.debugcircleincircle = 0;
            }
            
            continue;
        }
        
        if ( incircle && !self.debugcircleincircle )
        {
            self.debugcircleincircle = 1;
            stopfxontag( level._effect[ "vfx_gas_ring_player" ], self, "tag_eye" );
            level.debugcircleplayerfx = 0;
        }
    }
}

// Namespace br
// Params 4
// Checksum 0xe6027480, Offset: 0x10d1f
// Size: 0x191
function rundebugvfxcircletest( startradius, endradius, time, var_bb10feb0e87484dd )
{
    level endon( #"game_ended" );
    level endon( #"hash_7da589985ebacc0b" );
    
    if ( !level.debugcircleplayerfx )
    {
        level.players[ 0 ] thread debugplayercirclevfx();
    }
    
    respawntime = 5;
    groundpos = level.players[ 0 ] groundraycast( level.players[ 0 ].origin );
    level.circleemitters = spawnentsincircle( groundpos, startradius, var_bb10feb0e87484dd );
    level.circledebugpos = groundpos;
    wait 0.1;
    spawnvfxincircle( level.circleemitters );
    starttime = time;
    
    while ( time > 0 )
    {
        pct = time / starttime;
        newradius = endradius + ( startradius - endradius ) * pct;
        
        if ( respawntime < 0 )
        {
            destroyemitters( level.circleemitters );
            
            if ( newradius <= 0 )
            {
                return;
            }
            
            level.circledebugradius = newradius;
            respawntime = 5;
            level.circleemitters = spawnentsincircle( groundpos, newradius, var_bb10feb0e87484dd );
            wait 0.1;
            spawnvfxincircle( level.circleemitters );
        }
        else
        {
            updateemitterpositions( groundpos, newradius, level.circleemitters );
        }
        
        time -= level.framedurationseconds;
        respawntime -= level.framedurationseconds;
        waitframe();
    }
}

// Namespace br
// Params 1
// Checksum 0xf1fa1688, Offset: 0x10eb8
// Size: 0x55
function destroyemitters( emitters )
{
    for ( i = 0; i < emitters.size ; i++ )
    {
        if ( isdefined( emitters[ i ] ) )
        {
            stopfxontag( level._effect[ "vfx_gas_ring_puffy" ], emitters[ i ], "tag_origin" );
            emitters[ i ] delete();
        }
    }
}

// Namespace br
// Params 3
// Checksum 0x4818de4e, Offset: 0x10f15
// Size: 0xc8
function updateemitterpositions( center, newradius, emitters )
{
    count = emitters.size;
    stepdegrees = 360 / count;
    
    for ( i = 0; i < count ; i++ )
    {
        angle = stepdegrees * i;
        y = sin( angle ) * newradius;
        x = cos( angle ) * newradius;
        groundpos = groundraycast( center + ( x, y, 0 ) );
        emitters[ i ].origin = groundpos;
        emitters[ i ].angles = ( 0, angle + 180, 0 );
    }
}

// Namespace br
// Params 3
// Checksum 0x2c807fd2, Offset: 0x10fe5
// Size: 0x149
function spawnentsincircle( center, radius, var_bb10feb0e87484dd )
{
    emitters = [];
    circum = 6.2831 * radius;
    steps = circum / var_bb10feb0e87484dd;
    
    if ( steps < 200 )
    {
        iprintlnbold( "Using " + int( steps ) + " emitters" );
    }
    else
    {
        iprintlnbold( "Can't use " + int( steps ) + " emitters, using 200 instead" );
    }
    
    steps = min( steps, 200 );
    stepdegrees = 360 / steps;
    
    for ( i = 0; i < steps ; i++ )
    {
        angle = stepdegrees * i;
        y = sin( angle ) * radius;
        x = cos( angle ) * radius;
        groundpos = groundraycast( center + ( x, y, 0 ) );
        emitters[ i ] = spawn( "script_model", groundpos );
        emitters[ i ] setmodel( "tag_origin" );
        emitters[ i ].origin = groundpos;
        emitters[ i ].angles = ( 0, angle + 180, 0 );
    }
    
    return emitters;
}

// Namespace br
// Params 1
// Checksum 0x6cf1c2eb, Offset: 0x11137
// Size: 0x44
function spawnvfxincircle( emitters )
{
    for ( i = 0; i < emitters.size ; i++ )
    {
        playfxontag( level._effect[ "vfx_gas_ring_puffy" ], emitters[ i ], "tag_origin" );
    }
}

// Namespace br
// Params 0
// Checksum 0xe44383a3, Offset: 0x11183
// Size: 0x23
function ontimelimit()
{
    if ( isdefined( level.numendgame ) )
    {
        level thread startendgame( 1 );
    }
    
    level.numendgame = undefined;
}

// Namespace br
// Params 1
// Checksum 0xdb76db77, Offset: 0x111ae
// Size: 0x7c
function onplayerjoinsquad( player )
{
    if ( !isdefined( player.team ) )
    {
        script::demoforcesre( "onPlayerJoinTeam: !IsDefined( player.team ) - " + player.name );
    }
    
    if ( !team_utility::isgameplayteam( player.team ) )
    {
        script::demoforcesre( "onPlayerJoinTeam: !isGameplayTeam( player.team ) - " + player.name + " " + player.team );
    }
    
    thread function_2e7b12996ffa015d( player );
}

// Namespace br
// Params 0
// Checksum 0xaba3ad52, Offset: 0x11232
// Size: 0x6f
function function_a818d609795b21dd()
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    
    if ( br_public::isplayerbrsquadleader() )
    {
        thread hud_message::showsplash( "br_become_new_jump_leader" );
        return;
    }
    
    squadleader = squad_utility::getsquadleader( self.team, self.sessionsquadid );
    
    if ( isdefined( squadleader ) )
    {
        thread hud_message::showsplash( "br_jump_leader_changed", squadleader getentitynumber() );
    }
}

// Namespace br
// Params 1
// Checksum 0x24c3451a, Offset: 0x112a9
// Size: 0x10c
function function_2e7b12996ffa015d( player )
{
    player endon( #"disconnect" );
    waittillframeend();
    
    if ( level.teambased )
    {
        squadleader = squad_utility::getsquadleader( player.team, player.sessionsquadid );
        
        if ( !br_gametypes::isfeaturedisabled( #"hash_1d015a3890edfd10" ) )
        {
            if ( squads::function_69cf2efe88610e4f() )
            {
                teammembers = teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid );
                
                foreach ( player in teammembers )
                {
                    player setplayerbrsquadleader( squadleader == player );
                }
                
                return;
            }
            
            player setplayerbrsquadleader( squadleader == player );
        }
    }
}

// Namespace br
// Params 1
// Checksum 0xd88a52f7, Offset: 0x113bd
// Size: 0x2a
function onplayerjointeam( player )
{
    if ( getdvarint( @"hash_b2b6bc454af40904", 0 ) )
    {
        player.sessionuimemberindex = 0;
    }
}

// Namespace br
// Params 1
// Checksum 0xea6de125, Offset: 0x113ef
// Size: 0x1c9
function ondeadevent( team )
{
    if ( !isdefined( team ) || level.br_debugsolotest || function_45fb04620e678531( team ) )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"gametype", #"hash_e5952e921a56e06a", team ) )
    {
        return;
    }
    
    if ( team != "all" )
    {
        if ( level.var_309e3d9dac389de6 )
        {
            teamplayers = teams::getteamdata( team, "players" );
            
            foreach ( player in teamplayers )
            {
                if ( isdefined( player ) )
                {
                    player thread br_utility::rankedquittimer( 1 );
                }
            }
        }
        
        br_utility::printteameliminated( team );
        thread onteameliminated( team );
        gamelogic_mp::default_ondeadevent( team );
    }
    else
    {
        level notify( #"all_players_dead" );
        
        if ( level.var_309e3d9dac389de6 )
        {
            foreach ( player in level.players )
            {
                if ( player getclientomnvar( "ui_league_play_br_leave_penalty_timer" ) > br_utility::function_610b0cb5697b361a() )
                {
                    player thread br_utility::rankedquittimer( 1 );
                }
            }
        }
    }
    
    if ( level.var_18de0cbf8cab18c6 )
    {
        thread [[ level.var_18de0cbf8cab18c6 ]]( team );
    }
}

// Namespace br
// Params 1
// Checksum 0xb34bcff1, Offset: 0x115c0
// Size: 0x1b2
function function_1f2e8fad0c533e2d( team )
{
    if ( isdefined( level.uibotmanager ) )
    {
        players = teams::getteamdata( team, "players" );
        alivecount = 0;
        
        foreach ( player in players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !player.br_iseliminated && !player function_a29e5f57c1ef9e35() )
            {
                alivecount++;
            }
        }
        
        uibotcount = function_e45241986b39c3a8( team ) ?? 0;
        alivecount += uibotcount;
        return alivecount;
    }
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() && level.var_cc4ef85c57e9c83 )
    {
        alivecount = teams::getteamdata( team, "aliveCount" );
        players = teams::getteamdata( team, "players" );
        
        foreach ( player in players )
        {
            if ( !isalive( player ) && player.gulagarena )
            {
                alivecount++;
            }
        }
        
        return alivecount;
    }
    
    return teams::getteamdata( team, "aliveCount" );
}

// Namespace br
// Params 0
// Checksum 0x76257155, Offset: 0x1177a
// Size: 0xa5, Type: bool
function finalkillcamskipteamremaining()
{
    player = self;
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( level.var_52ec0ab267f26a6e )
    {
        var_4159a07b9bc754d9 = level.var_5aaf221daf42f53c;
        
        if ( !isdefined( var_4159a07b9bc754d9 ) )
        {
            [ remainingteams, remainingplayers ] = function_d0a17b0653ef321a( [ player.team ] );
            var_4159a07b9bc754d9 = remainingteams.size;
        }
        
        teamplacement = getteamplacement( var_4159a07b9bc754d9 );
        
        if ( teamplacement == 2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br
// Params 1
// Checksum 0xf80f9a57, Offset: 0x11828
// Size: 0x29a
function function_287d823080ccf18e( exfilledplayers )
{
    exfilledteams = [];
    
    foreach ( player in exfilledplayers )
    {
        if ( isdefined( player ) )
        {
            exfilledteams = arraycombineunique( exfilledteams, [ player.team ] );
        }
    }
    
    [ remainingteams, remainingplayers ] = function_d0a17b0653ef321a( exfilledteams );
    teamplacement = getteamplacement( remainingteams.size );
    
    foreach ( player in exfilledplayers )
    {
        if ( isdefined( player ) )
        {
            [ brbonusxp, var_245a2f5a93850587, var_33c0e792d2053e19 ] = player calculatebrbonusxp( teamplacement, player.team );
            player givebrbonusxp( brbonusxp, undefined, "squadEliminated" );
            player.matchbonus = var_245a2f5a93850587;
            player.placementbonus = var_33c0e792d2053e19;
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
            
            if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
            {
                gamelogic_mp::function_a7f2ba55c82bfa95( player );
            }
        }
    }
    
    foreach ( player in exfilledplayers )
    {
        if ( isdefined( player ) )
        {
            player thread handlebrdefeatedpostgamestate( teamplacement );
            gamelogic_mp::_setplayerteamrank( player, teamplacement );
            updateclientmatchdata( player );
            
            if ( level.var_309e3d9dac389de6 )
            {
                player leagueplay_br::match_end( teamplacement, 0, 0 );
            }
        }
    }
    
    setaardata( undefined, exfilledplayers );
}

// Namespace br
// Params 1
// Checksum 0x1104dae2, Offset: 0x11aca
// Size: 0xd2
function function_d0a17b0653ef321a( var_179737d844d0e4b )
{
    remainingteams = [];
    remainingplayers = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( arraycontains( var_179737d844d0e4b, entry ) )
        {
            continue;
        }
        
        var_1258ac31d654c37f = function_1f2e8fad0c533e2d( entry );
        
        if ( var_1258ac31d654c37f > 0 )
        {
            remainingteams[ remainingteams.size ] = entry;
            remainingplayers += var_1258ac31d654c37f;
        }
    }
    
    return [ remainingteams, remainingplayers ];
}

// Namespace br
// Params 1
// Checksum 0x600e40d0, Offset: 0x11ba5
// Size: 0x11
function getteamplacement( var_4159a07b9bc754d9 )
{
    return var_4159a07b9bc754d9 + 1;
}

// Namespace br
// Params 1
// Checksum 0x373d5bde, Offset: 0x11bbf
// Size: 0xc7
function function_11eb4174b39b6c4c( var_179737d844d0e4b = [] )
{
    level.var_5aaf221daf42f53c = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( arraycontains( var_179737d844d0e4b, entry ) )
        {
            continue;
        }
        
        var_1258ac31d654c37f = function_1f2e8fad0c533e2d( entry );
        
        if ( var_1258ac31d654c37f > 0 )
        {
            level.var_5aaf221daf42f53c++;
        }
    }
    
    return level.var_5aaf221daf42f53c;
}

// Namespace br
// Params 1
// Checksum 0xf83c046e, Offset: 0x11c8f
// Size: 0x247
function onteameliminated( team )
{
    var_b5fb56ce2f5f56fa = function_11eb4174b39b6c4c( [ team ] );
    remainingplayers = level.totalalivecount;
    
    if ( isdefined( level.var_d15d8e645776c167 ) )
    {
        var_5cfe35509f6075fc = getdvarint( @"hash_b732d750ae36e4e0", 3 );
        
        if ( var_5cfe35509f6075fc != -1 && var_b5fb56ce2f5f56fa <= var_5cfe35509f6075fc && utility::issharedfuncdefined( #"teamassim", #"permanentlydisableassim" ) )
        {
            [[ utility::getsharedfunc( #"teamassim", #"permanentlydisableassim" ) ]]();
        }
    }
    
    if ( br_gametypes::isfeatureenabled( #"pleaforhelp" ) )
    {
        self [[ utility::getsharedfunc( #"pleaforhelp", #"hash_2de65edea9110188" ) ]]( team );
    }
    
    teamplacement = getteamplacement( var_b5fb56ce2f5f56fa );
    level callback::callback( #"on_squad_eliminated", { #remaining_players:remainingplayers, #remaining_team_count:var_b5fb56ce2f5f56fa, #placement:teamplacement, #team:team } );
    function_6ddae5560541fc65( team, teamplacement, remainingplayers, 0 );
    
    if ( isdefined( level.var_38896f7c8ea269da ) )
    {
        [[ level.var_38896f7c8ea269da ]]( "placement", team );
    }
    
    if ( hasomnvar( "ui_br_player_personal_best" ) && !level.brgametype.var_aa811c5b6c109904 )
    {
        teamplayers = teams::getteamdata( team, "players" );
        
        foreach ( player in teamplayers )
        {
            level thread function_b9a0e2e2e762917f( player );
        }
    }
    
    if ( level.var_309e3d9dac389de6 )
    {
        if ( getdvarint( @"hash_ec4c94a9646f819f", 1 ) == 1 )
        {
            if ( !rejoin_utility::function_34321209fb4483f3() )
            {
                leagueplay_br::function_2016316708f14845();
                return;
            }
            
            if ( level.var_ad0ce3b7be0a4ebf )
            {
                leagueplay_br::function_566a3530d661827c( team );
            }
        }
    }
}

// Namespace br
// Params 1
// Checksum 0x605f7afb, Offset: 0x11ede
// Size: 0x2ef
function function_b9a0e2e2e762917f( player )
{
    if ( !isdefined( player ) || level.brgametype.var_aa811c5b6c109904 )
    {
        return;
    }
    
    categories = [ "kills", "revives", "assist", "contracts", "respawns" ];
    suffixs = [ "_c" ];
    var_b8cadcf6b4c3748f = [ "pb_kill", "pb_revive", "pb_assist", "pb_contract", "pb_return" ];
    var_bf50d1bcc390bd6f = [ "_chapter", "_seasonal", "_rolling" ];
    playerscurrent = [];
    playerscurrent[ 0 ] = player.pers[ "kills" ];
    playerscurrent[ 1 ] = player.pers[ "rescues" ];
    playerscurrent[ 2 ] = player.pers[ "assists" ];
    playerscurrent[ 3 ] = player.pers[ "contracts" ];
    playerscurrent[ 4 ] = player.pers[ "kioskRevives" ];
    pbsuccess = undefined;
    var_73ee1337bed56eb8 = 0;
    
    for ( j = 0; j < suffixs.size ; j++ )
    {
        for ( i = 0; i < categories.size ; i++ )
        {
            pb = personal_bests::function_1c98bb816268b0f5( player, categories[ i ] + suffixs[ j ] );
            
            if ( playerscurrent[ i ] > pb )
            {
                pbsuccess = var_b8cadcf6b4c3748f[ i ] + var_bf50d1bcc390bd6f[ j ];
                var_73ee1337bed56eb8 = playerscurrent[ i ];
                break;
            }
        }
        
        if ( isdefined( pbsuccess ) )
        {
            break;
        }
    }
    
    /#
        dvarval = getdvar( @"hash_a14c5b08548457d8", "<dev string:x17e>" );
        
        if ( dvarval != "<dev string:x17e>" )
        {
            stringlist = strtok( dvarval, "<dev string:x2fe>" );
            
            if ( stringlist.size > 1 )
            {
                pbsuccess = stringlist[ 0 ];
                var_73ee1337bed56eb8 = int( stringlist[ 1 ] );
            }
        }
    #/
    
    if ( isdefined( pbsuccess ) && isdefined( level.var_3abb05bb58a5e16e[ pbsuccess ] ) )
    {
        accoladeindex = level.var_3abb05bb58a5e16e[ pbsuccess ];
        var_794529507543c518 = int( var_73ee1337bed56eb8 );
        assert( isdefined( accoladeindex ) );
        assert( accoladeindex >= 0 && accoladeindex < 256 );
        var_8cdadf7b291501d7 = 0;
        
        if ( isdefined( player ) )
        {
            var_8cdadf7b291501d7 = player getentitynumber();
        }
        
        assert( var_8cdadf7b291501d7 >= 0 && var_8cdadf7b291501d7 < 256 );
        omnvarvalue = var_8cdadf7b291501d7;
        omnvarvalue |= accoladeindex << 8;
        
        if ( var_794529507543c518 != 0 )
        {
            omnvarvalue |= var_794529507543c518 << 16;
        }
        
        player setclientomnvar( "ui_br_player_personal_best", omnvarvalue );
    }
}

// Namespace br
// Params 2
// Checksum 0x45228ef6, Offset: 0x121d5
// Size: 0xbc
function function_c61ccf4925eea7f0( team, var_6be7aea77639ed4c )
{
    remainingsquads = function_d126c907c5dad4fe().size;
    wait 1.5;
    teamplayers = teams::getteamdata( team, "players" );
    
    if ( !var_6be7aea77639ed4c && remainingsquads < 5 )
    {
        br_public::brleaderdialog( "top_5_lose", 0, teamplayers, 1 );
    }
    else if ( !var_6be7aea77639ed4c && remainingsquads < 10 )
    {
        br_public::brleaderdialog( "top_10_lose", 0, teamplayers, 1 );
    }
    else if ( !var_6be7aea77639ed4c && remainingsquads < 25 )
    {
        br_public::brleaderdialog( "top_25_lose", 0, teamplayers, 1 );
    }
    
    br_public::brleaderdialog( "team_loss", 0, teamplayers, 1 );
}

// Namespace br
// Params 3
// Checksum 0xcf86b604, Offset: 0x12299
// Size: 0xb4
function function_63d82733f094f412( team, remainingplayers, skipremainingplayers )
{
    wait 1.5;
    teamplayers = teams::getteamdata( team, "players" );
    
    if ( !skipremainingplayers && remainingplayers < 5 )
    {
        br_public::brleaderdialog( "top_5_lose", 0, teamplayers, 1 );
    }
    else if ( !skipremainingplayers && remainingplayers < 10 )
    {
        br_public::brleaderdialog( "top_10_lose", 0, teamplayers, 1 );
    }
    else if ( !skipremainingplayers && remainingplayers < 25 )
    {
        br_public::brleaderdialog( "top_25_lose", 0, teamplayers, 1 );
    }
    
    br_public::brleaderdialog( "team_loss", 0, teamplayers, 1 );
}

// Namespace br
// Params 4
// Checksum 0xc31fcc70, Offset: 0x12355
// Size: 0x2ed
function function_6ddae5560541fc65( team, teamplacement, remainingplayers, skipremainingplayers )
{
    /#
        println( "<dev string:x300>" );
        iprintlnbold( "<dev string:x33b>" + int( team ) + "<dev string:x346>" + int( teamplacement ) );
    #/
    
    setteamplacement( team, teamplacement );
    br_analytics::branalytics_teameliminated( team, teamplacement );
    teamplayers = teams::getteamdata( team, "players" );
    
    if ( teamplayers.size > 0 )
    {
        [ brbonusxp, var_245a2f5a93850587, var_33c0e792d2053e19 ] = teamplayers[ 0 ] calculatebrbonusxp( teamplacement, team );
        var_95e9f9cef207d5f2 = self.var_abf725bca27206a1;
        var_6dc538bbf37451a2 = self.var_254727439a41ca6f;
    }
    
    foreach ( player in teamplayers )
    {
        if ( isdefined( player ) && !player.extracted )
        {
            player.var_abf725bca27206a1 = var_95e9f9cef207d5f2;
            player.var_254727439a41ca6f = var_6dc538bbf37451a2;
            player givebrbonusxp( brbonusxp, undefined, "squadEliminated" );
            player.matchbonus = var_245a2f5a93850587;
            player.placementbonus = var_33c0e792d2053e19;
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
            
            if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
            {
                gamelogic_mp::function_a7f2ba55c82bfa95( player );
            }
            
            player utility::callsharedfunc( #"player", #"hash_20c82231856fcf19" );
        }
    }
    
    if ( level.var_a151dfa60c97bfc7 )
    {
        level thread function_c61ccf4925eea7f0( team, skipremainingplayers );
    }
    else
    {
        level thread function_63d82733f094f412( team, remainingplayers, skipremainingplayers );
    }
    
    foreach ( player in teamplayers )
    {
        if ( isdefined( player ) && !player.extracted )
        {
            player thread handlebrdefeatedpostgamestate( teamplacement );
            player setplacementstats( teamplacement );
            gamelogic_mp::_setplayerteamrank( player, teamplacement );
            updateclientmatchdata( player );
            
            if ( level.var_309e3d9dac389de6 )
            {
                player leagueplay_br::match_end( teamplacement, 1, 0 );
            }
        }
    }
    
    setaardata( team );
}

// Namespace br
// Params 1
// Checksum 0x22bce9a3, Offset: 0x1264a
// Size: 0x2c2
function handlebrdefeatedpostgamestate( teamplacement )
{
    player = self;
    player endon( #"disconnect" );
    
    if ( isdefined( teamplacement ) )
    {
        if ( getdvarint( @"br_ftue_active", 0 ) == 1 )
        {
            player namespace_c6e391ebf419f41d::function_19c459a55be9500();
        }
        else
        {
            player setclientomnvar( "ui_br_player_position", teamplacement );
            player setplayerdata( level.var_6f9b00680ed002d8, "aarData", "matchResult", teamplacement == 1 ? game[ "round_end" ][ "victory" ] : game[ "round_end" ][ "defeat" ] );
        }
    }
    
    player br_ftue_popups::function_3575388e7b3207cb();
    
    if ( player.extracted )
    {
        return;
    }
    
    if ( !player.br_spectatorinitialized )
    {
        player waittill( #"br_spectatorInitialized" );
        
        if ( !isdefined( player ) )
        {
            return;
        }
    }
    
    if ( level.var_9381c9551ae893de )
    {
        player setclientomnvar( "ui_dmz_extract_successful", 0 );
        currentstreak = player getplayerdata( level.var_6f9b00680ed002d8, "currentStreakCount" );
        
        /#
            if ( getdvarint( @"hash_539db9b5fa27f149", 0 ) )
            {
                currentstreak = getdvarint( @"hash_539db9b5fa27f149", 0 );
            }
        #/
        
        if ( currentstreak > 0 )
        {
            if ( currentstreak == 1 )
            {
                overlord::playevent( "streak_fail_single", [ player ], undefined, 1 );
            }
            else
            {
                overlord::playevent( "streak_fail_multiple", [ player ], undefined, 1 );
            }
        }
    }
    
    if ( getdvarint( @"hash_af9925796dbfa9d", 0 ) == 1 )
    {
        var_ded5ecd8e321bd40 = gettime();
        
        while ( !player player::isinkillcam() && gettime() - var_ded5ecd8e321bd40 < 1000 )
        {
            waitframe();
        }
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( player player::isinkillcam() )
        {
            player utility::waittill_any( "br_final_killcam_complete", "killcam_ended", "killcam_canceled", "abort_killcam" );
            
            if ( !isdefined( player ) )
            {
                return;
            }
        }
        
        player thread function_ec690cc971b0f2ef( player, teamplacement );
        player waittill( "scripted_widget_destroyed_" + "vds_screen" );
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player setclientomnvar( "ui_br_squad_eliminated_active", 1 );
    player setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "defeat" ] );
    player setclientomnvar( "ui_round_end_reason", game[ "end_reason" ][ "br_eliminated" ] );
    player setclientdvar( @"ui_opensummary", 1 );
    namekey = getgametypenamekey();
    
    if ( isdefined( namekey ) )
    {
        player setclientdvar( @"hash_6662b40ecc02a63c", namekey == "battleroyale_ftue_bt" );
    }
    
    if ( level.var_e7dc93c451678766 )
    {
        player br_gametype_dmz::function_ff01c205a999d3ae();
        player br_gametype_dmz::function_8ad966643eb205e0();
    }
    
    player lower_message::setlowermessageomnvar( "clear_lower_msg" );
    player notify( #"br_team_fully_eliminated" );
}

// Namespace br
// Params 0
// Checksum 0x93051a3e, Offset: 0x12914
// Size: 0x58
function function_6ad5351233953071()
{
    self endon( #"death_or_disconnect" );
    self endon( "scripted_widget_destroyed_" + "vds_screen" );
    
    while ( true )
    {
        self waittill( #"hash_60a58c5927a45d1" );
        
        /#
            iprintlnbold( "<dev string:x35b>" );
        #/
        
        if ( scripted_widgets::is_active( "vds_screen" ) )
        {
            thread scripted_widgets::destroy( "vds_screen" );
        }
    }
}

// Namespace br
// Params 3
// Checksum 0x5a0d82c4, Offset: 0x12974
// Size: 0x157
function function_ec690cc971b0f2ef( player, placement, iswinner )
{
    if ( scripted_widgets::is_active( "vds_screen" ) )
    {
        thread scripted_widgets::destroy( "vds_screen" );
    }
    
    vds_gametype = scripted_widgets::function_652736891a41e948( "scripted_widget_victory_defeat_screen" );
    player scripted_widgets::create( "vds_screen", vds_gametype );
    fields = [];
    fields[ "placement" ] = placement;
    var_31389415574c377f = getscriptbundle( vds_gametype );
    animation_state = "";
    
    if ( placement == 1 && isdefined( iswinner ) && iswinner == 0 )
    {
        animation_state = "state_defeat";
    }
    else if ( placement == 1 )
    {
        animation_state = "state_victory";
    }
    else if ( level.gametype == "bongo" )
    {
        animation_state = "state_defeat";
    }
    else if ( placement == 2 )
    {
        animation_state = "state_defeat_placement";
    }
    else
    {
        animation_state = isdefined( var_31389415574c377f.states[ #"state_defeat_placement_small" ] ) ? "state_defeat_placement_small" : "state_defeat_placement";
    }
    
    player scripted_widgets::set_param( "vds_screen", animation_state );
    player scripted_widgets::set_state( "vds_screen", animation_state );
    player scripted_widgets::function_dd7a63eea5bde0dc( "vds_screen", fields, 1 );
    player thread function_6ad5351233953071();
}

// Namespace br
// Params 1
// Checksum 0xa991a70f, Offset: 0x12ad3
// Size: 0x543
function setplacementstats( teamplacement )
{
    player = self;
    
    if ( !isdefined( player ) || player.placementstatsset )
    {
        return;
    }
    
    player.placementstatsset = 1;
    player.teamplacement = teamplacement;
    
    if ( isdefined( player.pers[ "telemetry" ] ) )
    {
        player.pers[ "telemetry" ].teamplacement = teamplacement;
    }
    
    if ( player.br_iseliminated )
    {
        telemetry_utils::function_c54601d44e7b8e8a( player );
    }
    
    challenges::function_4e55542d7cb05e55( player );
    
    if ( teamplacement <= 25 )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "topTwentyFive" ] ) )
            {
                player.leaderboarddata[ "topTwentyFive" ] = player.leaderboarddata[ "topTwentyFive" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "topTwentyFive" ] ) )
            {
                [[ level.leaderboardfunc[ "topTwentyFive" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x380>" );
            
            if ( isdefined( player.pers[ "topTwentyFive" ] ) )
            {
                player.pers[ "topTwentyFive" ] = player.pers[ "topTwentyFive" ] + 1;
            }
        }
        
        if ( teamplacement <= 10 )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "topTen" ] ) )
                {
                    player.leaderboarddata[ "topTen" ] = player.leaderboarddata[ "topTen" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "topTen" ] ) )
                {
                    [[ level.leaderboardfunc[ "topTen" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x380>" );
                
                if ( isdefined( player.pers[ "topTen" ] ) )
                {
                    player.pers[ "topTen" ] = player.pers[ "topTen" ] + 1;
                }
            }
            
            if ( teamplacement <= 5 )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                {
                    if ( isdefined( player.leaderboarddata[ "topFive" ] ) )
                    {
                        player.leaderboarddata[ "topFive" ] = player.leaderboarddata[ "topFive" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "topFive" ] ) )
                    {
                        [[ level.leaderboardfunc[ "topFive" ] ]]( player, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x380>" );
                    
                    if ( isdefined( player.pers[ "topFive" ] ) )
                    {
                        player.pers[ "topFive" ] = player.pers[ "topFive" ] + 1;
                    }
                }
                
                if ( teamplacement == 1 )
                {
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                    {
                        if ( isdefined( player.leaderboarddata[ "wins" ] ) )
                        {
                            player.leaderboarddata[ "wins" ] = player.leaderboarddata[ "wins" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "wins" ] ) )
                        {
                            [[ level.leaderboardfunc[ "wins" ] ]]( player, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x380>" );
                        
                        if ( isdefined( player.pers[ "wins" ] ) )
                        {
                            player.pers[ "wins" ] = player.pers[ "wins" ] + 1;
                        }
                    }
                    
                    if ( dmz_weapon_case::didextractwithweaponcase( player ) )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                        {
                            if ( isdefined( player.leaderboarddata[ "weaponCaseWins" ] ) )
                            {
                                player.leaderboarddata[ "weaponCaseWins" ] = player.leaderboarddata[ "weaponCaseWins" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "weaponCaseWins" ] ) )
                            {
                                [[ level.leaderboardfunc[ "weaponCaseWins" ] ]]( player, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x380>" );
                            
                            if ( isdefined( player.pers[ "weaponCaseWins" ] ) )
                            {
                                player.pers[ "weaponCaseWins" ] = player.pers[ "weaponCaseWins" ] + 1;
                            }
                        }
                        
                        challenges::function_37e945722d6497f3( player, "weapons_case_win", 1 );
                    }
                }
            }
        }
        
        player gamelogic_mp::updateplayerleaderboardstats();
    }
}

// Namespace br
// Params 0
// Checksum 0xb02c3aac, Offset: 0x1301e
// Size: 0x71
function getbrbonusxppermillisecond()
{
    var_cebee2e73f7e2729 = 0.001692;
    
    if ( getdvarint( @"hash_78c13a450d84f3c1", 0 ) == 1 )
    {
        return getdvarfloat( @"hash_11afd7f54bfebd24", var_cebee2e73f7e2729 );
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"getbrbonusxppermillisecond" ) )
    {
        return utility::callsharedfunc( #"gametype", #"getbrbonusxppermillisecond" );
    }
    
    return var_cebee2e73f7e2729;
}

// Namespace br
// Params 2
// Checksum 0xe1d02904, Offset: 0x13097
// Size: 0x2cb
function calculatebrbonusxp( teamplacement, inteam )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return [ 0, 0, 0 ];
    }
    
    gametype = game_utility::getgametype();
    
    if ( gametype == "dmz" || gametype == "plunder" || gametype == "kingslayer" )
    {
        return [ 0, 0, 0 ];
    }
    
    if ( !isdefined( level.xp_per_millisecond ) )
    {
        level.xp_per_millisecond = getbrbonusxppermillisecond();
    }
    
    if ( !( isdefined( level.startofxptime ) && isdefined( teamplacement ) && isdefined( level.xpperplayerpershare ) ) || level.startofxptime <= 0 || teamplacement <= 0 || level.xpperplayerpershare <= 0 )
    {
        return [ 0, 0, 0 ];
    }
    
    timeactive = gettime() - level.startofxptime;
    timexp = int( level.xp_per_millisecond * timeactive + 0.5 );
    placementxp = int( level.xpperplayerpershare * ( level.xpteamsatmatchstart - teamplacement + 1 ) );
    
    if ( isdefined( self ) )
    {
        self.var_254727439a41ca6f = timexp;
        
        if ( isdefined( self.var_abf725bca27206a1 ) )
        {
            self.var_abf725bca27206a1 = maxint( self.var_abf725bca27206a1, placementxp );
        }
        else
        {
            self.var_abf725bca27206a1 = placementxp;
        }
    }
    
    logstring( "PLACEMENT PART LOGa: time               =" + timeactive + "; timeXP=" + timexp + "; teamPlacement=" + teamplacement + "; placementXp=" + placementxp );
    logstring( "PLACEMENT PART LOGb: xp_per_millisecond =" + level.xp_per_millisecond + "; xpPerPlayerPerShare=" + level.xpperplayerpershare );
    
    if ( isdefined( inteam ) )
    {
        players = teams::getteamdata( inteam, "players" );
        validplayer = 0;
        
        foreach ( player in players )
        {
            if ( !player function_a29e5f57c1ef9e35() )
            {
                validplayer++;
            }
        }
        
        if ( validplayer > 0 )
        {
            placementxp = int( placementxp * level.maxteamsize / validplayer );
        }
    }
    
    rewardxp = timexp + placementxp;
    timexp = rank::function_2a856625855f3ca3( timexp );
    placementxp = rank::function_2a856625855f3ca3( placementxp );
    return [ rewardxp, timexp, placementxp ];
}

// Namespace br
// Params 1
// Checksum 0x91a3283c, Offset: 0x1336b
// Size: 0x3b, Type: bool
function function_60369db834608843( player )
{
    if ( getdvarint( @"hash_86874c5f2c4d9bb", 0 ) )
    {
        return true;
    }
    
    if ( !mp_afk::function_7d37470e35348dd4() && !function_29339c30e6d1b395( player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br
// Params 3
// Checksum 0x3f9965c9, Offset: 0x133af
// Size: 0x19a
function givebrbonusxp( brbonusxp, objweapon, reason = "undefined" )
{
    if ( !isdefined( self ) || isbot( self ) || istestclient( self ) )
    {
        return;
    }
    
    if ( !game[ "timePassed" ] )
    {
        return;
    }
    
    if ( !( game_utility_mp::matchmakinggame() || getdvarint( @"force_challenges" ) ) )
    {
        return;
    }
    
    if ( !function_60369db834608843( self ) )
    {
        logstring( "giveBRBonusXP: Player " + self.name + " failed isBRBonusXPAllowed check." );
        return;
    }
    
    gametype = game_utility::getgametype();
    
    if ( gametype == "dmz" || gametype == "plunder" || gametype == "kingslayer" )
    {
        return;
    }
    
    if ( self.brbonusxpallowed === 0 )
    {
        return;
    }
    
    if ( brbonusxp > 0 )
    {
        suppresspopup = 0;
        
        switch ( reason )
        {
            case #"hash_8a3297e83141974b":
                suppresspopup = 1;
                break;
            case #"hash_58fc9e134ee88311":
                suppresspopup = 1;
                break;
            case #"hash_2e41475963f16ce8":
            case #"hash_6201f99dbadb9e66":
                suppresspopup = 1;
                break;
            case #"hash_b61583709daf623":
            default:
                suppresspopup = 0;
                assertmsg( "<dev string:x3a6>" );
                break;
        }
        
        forceimmediate = 1;
        rank::giverankxp( #"hash_9be8184eb12293ba", brbonusxp, undefined, suppresspopup, forceimmediate, 1 );
        br_analytics::branalytics_bonusxp_debugdata( brbonusxp, reason );
    }
    
    self.brbonusxpallowed = 0;
}

// Namespace br
// Params 0
// Checksum 0x23feb291, Offset: 0x13551
// Size: 0x80
function setplacementxpshare()
{
    if ( utility::issharedfuncdefined( #"gametype", #"getplacementxpsharevalues" ) )
    {
        [ pool, max, min ] = utility::callsharedfunc( #"gametype", #"getplacementxpsharevalues" );
        function_bacac3241d060924( pool, max, min );
        return;
    }
    
    function_bacac3241d060924();
}

// Namespace br
// Params 3
// Checksum 0xaea44e0b, Offset: 0x135d9
// Size: 0x1e3
function function_bacac3241d060924( overridepool, overridemax, overridemin )
{
    var_e27fb554125cbd0d = overridepool ?? 142308;
    var_8a56d104e1212bd9 = overridemax ?? 80;
    var_ddc311b5bcc23177 = overridemin ?? 15;
    var_63061d2a9900ad65 = var_e27fb554125cbd0d;
    teamsize = max( 1, level.maxteamsize );
    numberofteams = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( teams::getteamdata( entry, "teamCount" ) )
        {
            numberofteams++;
        }
    }
    
    numberofteams = max( 1, numberofteams );
    totalshares = int( numberofteams * ( numberofteams + 1 ) / 2 );
    totalshares = max( totalshares, 1 );
    xpperplayerpershare = int( var_63061d2a9900ad65 / totalshares * teamsize + 0.9 );
    xpperplayerpershare = int( clamp( xpperplayerpershare, var_ddc311b5bcc23177, var_8a56d104e1212bd9 ) );
    
    if ( getdvarint( @"hash_4910824add4f33d9", 0 ) == 1 )
    {
        xptouse = getdvarint( @"scr_br_placement_xp_share", xpperplayerpershare );
    }
    else
    {
        xptouse = xpperplayerpershare;
    }
    
    logstring( "PLACEMENT CALCULATION LOGa: placementPool=" + var_e27fb554125cbd0d + "; numberOfTeams=" + numberofteams + "; totalShares=" + totalshares + "; xpPerPlayerPerShare=" + xpperplayerpershare + "; xpToUse=" + xptouse );
    level.xpperplayerpershare = xptouse;
    level.xpteamsatmatchstart = numberofteams;
    level.startofxptime = gettime();
}

// Namespace br
// Params 1
// Checksum 0x97812787, Offset: 0x137c4
// Size: 0x65
function giveweaponxpfromtimebr( awardtime )
{
    weapon_xp_millisecond = getdvarfloat( @"hash_64ab4e1c10d28ab0", 0.004125 );
    lastweaponobj = self.lastnormalweaponobj;
    value = int( awardtime * weapon_xp_millisecond );
    givebrweaponxp( #"", value, lastweaponobj, 1, 0 );
}

// Namespace br
// Params 5
// Checksum 0x3cf3637d, Offset: 0x13831
// Size: 0xda
function givebrweaponxp( type, value, objweapon, suppresspopup, forceimmediate )
{
    if ( !isdefined( objweapon ) || weapon::iskillstreakweapon( objweapon ) || vehicle::isvehicleweapon( objweapon ) )
    {
        return;
    }
    
    if ( isdefined( self.owner ) && !isbot( self ) )
    {
        self.owner givebrweaponxp( type, value, objweapon );
        return;
    }
    
    if ( isai( self ) || !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( value ) || value <= 0 )
    {
        return;
    }
    
    if ( !isdefined( suppresspopup ) )
    {
        suppresspopup = 0;
    }
    
    if ( !isdefined( forceimmediate ) )
    {
        forceimmediate = 0;
    }
    
    if ( !suppresspopup )
    {
        points::displayscoreeventpoints( value, type );
    }
    
    if ( !level.playerxpenabled )
    {
        return;
    }
    
    thread waitandapplybrweaponxp( type, value, objweapon, forceimmediate );
}

// Namespace br
// Params 4
// Checksum 0xfcde4d2b, Offset: 0x13913
// Size: 0x141
function waitandapplybrweaponxp( type, value, objweapon, forceimmediate )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( forceimmediate ) )
    {
        forceimmediate = 0;
    }
    
    if ( !forceimmediate )
    {
        waitframe();
        script::waittillslowprocessallowed();
    }
    
    weapon_xp = 0;
    
    if ( !isdefined( objweapon ) || !weaponrank::weaponshouldgetxp( objweapon ) )
    {
        return;
    }
    
    weapon_xp = value;
    weapon_xp *= weaponrank::getweaponrankxpmultipliertotal();
    weapon_xp = int( weapon_xp );
    rank::incrankxp( 0, objweapon, weapon_xp, #"brweaponxp" );
    
    if ( level.playerxpenabled && !isai( self ) )
    {
        if ( isdefined( objweapon ) && ( weapon::iscacprimaryweapon( objweapon ) || weapon::iscacsecondaryweapon( objweapon ) ) )
        {
            telemetry_data = { #weaponobj:objweapon, #variantid:-1, #statupdates:[ { #value:weapon_xp, #name:"xp_earned" } ], #fullweaponname:getcompleteweaponname( objweapon ), #weaponname:weapon::getweaponrootname( objweapon ) };
            telemetry_utils::function_af2d366f9522f76f( "callback_update_weapon_stats", telemetry_data );
        }
    }
}

// Namespace br
// Params 2
// Checksum 0xeaf2fa4f, Offset: 0x13a5c
// Size: 0xb1
function calculatepurchasexp( plunderspent, itemtype )
{
    var_529a8251a6ca780c = getdvarint( @"hash_b6bd80ba75fa61af", 0 );
    var_31c2bdd7d7a1966a = getdvarint( @"hash_e8d8c6b25c9b387", 30 );
    plunderspent /= 100;
    xpvalue = var_529a8251a6ca780c + int( plunderspent * var_31c2bdd7d7a1966a );
    xpcap = getdvarint( @"hash_e3ca7808574d931b", 100 );
    xpmin = getdvarint( @"hash_1c5b8086da25737", 10 );
    
    if ( xpvalue > xpcap )
    {
        xpvalue = xpcap;
    }
    else if ( xpvalue < xpmin )
    {
        xpvalue = xpmin;
    }
    
    return xpvalue;
}

// Namespace br
// Params 0
// Checksum 0xc893ced6, Offset: 0x13b16
// Size: 0x71
function resetpostgamestateonjoinedspectators()
{
    self endon( #"disconnect" );
    starttime = gettime();
    
    if ( !self.br_spectatorinitialized )
    {
        self waittill( #"br_spectatorInitialized" );
    }
    
    minsecs = 3;
    deltasec = ( gettime() - starttime ) / 1000;
    
    if ( deltasec < minsecs )
    {
        wait minsecs - deltasec;
    }
    
    self setclientomnvar( "post_game_state", 0 );
}

// Namespace br
// Params 0
// Checksum 0x807132d, Offset: 0x13b8f
// Size: 0x28, Type: bool
function function_ee15a28564f11e4e()
{
    return level.var_ee15a28564f11e4e || level.br_debugsolotest || game_utility::getgametype() == "dmz";
}

// Namespace br
// Params 1
// Checksum 0xe2ec07d5, Offset: 0x13bc0
// Size: 0xc3
function ononeleftevent( team )
{
    if ( function_ee15a28564f11e4e() || function_45fb04620e678531( team ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        var_306393a938622f32 = game_utility_mp::getlastlivingplayer( team );
        
        if ( isdefined( var_306393a938622f32 ) )
        {
            level thread battlechatter_mp::trysaylocalsound( var_306393a938622f32, #"bc_status_inform_last_one", 3 );
            var_306393a938622f32 utility::delaythread( 0.5, &br_public::brleaderdialog, "last_man_standing", 0, [ var_306393a938622f32 ], undefined, undefined, undefined, level.brgametype.dialogprefix );
        }
        
        return;
    }
    
    level.lastplayerwins = game_utility_mp::getlastlivingplayer();
    level thread gamelogic_mp::endgame( level.lastplayerwins, game[ "end_reason" ][ "enemies_eliminated" ] );
}

// Namespace br
// Params 1
// Checksum 0xa6161d31, Offset: 0x13c8b
// Size: 0x7e
function function_1fbc342360eed417( victim )
{
    if ( victim.brneverlanded || victim.var_fec1009788ed39b6 )
    {
        if ( !isdefined( victim.consecutivesuicides ) )
        {
            victim.consecutivesuicides = 1;
        }
        else
        {
            victim.consecutivesuicides++;
        }
        
        if ( victim.consecutivesuicides >= getdvarint( @"hash_f43737c13c504e05", 5 ) )
        {
            level thread mp_afk::kickafkplayer( victim );
        }
    }
}

// Namespace br
// Params 1
// Checksum 0xba13d71b, Offset: 0x13d11
// Size: 0xce
function onsuicidedeath( victim )
{
    if ( !level.teambased )
    {
        liveplayers = game_utility_mp::getlivingplayers();
        victim.score = level.totalplayers - liveplayers.size;
        
        foreach ( player in liveplayers )
        {
            player.score = victim.score + 1;
        }
    }
    
    function_1fbc342360eed417( victim );
}

// Namespace br
// Params 0
// Checksum 0x8563325b, Offset: 0x13de7
// Size: 0x24, Type: bool
function needdefaultendgameflowonly()
{
    if ( isdefined( level.forcedend ) )
    {
        return ( br_public::isbrpracticemode() && level.forcedend );
    }
    
    return false;
}

// Namespace br
// Params 3
// Checksum 0x4bbd2e21, Offset: 0x13e14
// Size: 0x10ec
function brendgame( winner, endreasontext, nukedetonated )
{
    if ( level.gameended )
    {
        return;
    }
    
    level.gameended = 1;
    level.gameendtime = gettime();
    br_ending::preload_ending();
    waittillframeend();
    
    foreach ( player in level.players )
    {
        telemetry_utils::function_c54601d44e7b8e8a( player );
        player thread gameplay_telemetry::function_3e91d2222fa2419f( 1 );
    }
    
    game[ "state" ] = "postgame";
    level notify( #"game_ended" );
    logstring( "[KEY_MOMENT] gameEnded winner = " + ( winner ?? "undefined" ) );
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        if ( endreasontext == 25 )
        {
            level.br_ending_delay = 0;
            
            if ( utility::issharedfuncdefined( #"dmztut", #"empty" ) )
            {
                func = utility::getsharedfunc( #"dmztut", #"empty" );
                level.br_endgamesplashcallback = func;
            }
        }
        else if ( utility::issharedfuncdefined( #"dmztut", #"hash_e60abb386c3b694f" ) )
        {
            [[ utility::getsharedfunc( #"dmztut", #"hash_e60abb386c3b694f" ) ]]();
        }
    }
    
    br_gulag::shutdowngulag( "end_game", 0, 1 );
    
    if ( br_public::isbrpracticemode() )
    {
        level.gameisending = 1;
    }
    
    br_vehicles::emptyallvehicles();
    level callback::callback( #"game_ended", { #winner:winner } );
    thread utility::callsharedfunc( #"gametype", #"endgame", winner, endreasontext );
    
    if ( needdefaultendgameflowonly() )
    {
        gamelogic_mp::endgame_regularmp( winner, endreasontext, game[ "end_reason" ][ "br_eliminated" ], nukedetonated );
        return;
    }
    
    if ( !nukedetonated && level.var_52ec0ab267f26a6e )
    {
        if ( !isdefined( level.finalkillcam_winner ) )
        {
            level.finalkillcam_winner = winner;
        }
        
        thread potg::onroundended( winner );
        thread final_killcam::preloadfinalkillcam();
    }
    
    setomnvarforallclients( "ui_br_transition_type", 0 );
    winnerplayers = undefined;
    
    if ( isdefined( winner ) && winner != "tie" && winner != "none" )
    {
        if ( isdefined( level.brwinnerscircle ) )
        {
            [[ level.brwinnerscircle.setwinners ]]( winner );
            
            foreach ( team in level.teamnamelist )
            {
                if ( level.brwinnerscircle.usesquads )
                {
                    foreach ( id, data in level.squaddata[ team ] )
                    {
                        [[ level.brwinnerscircle.var_de4265ac3d27121c ]]( team, undefined, id );
                    }
                    
                    continue;
                }
                
                [[ level.brwinnerscircle.var_de4265ac3d27121c ]]( team );
            }
        }
        
        winnerviewsetup();
        winnerplayers = [];
        teamplayers = teams::getteamdata( winner, "players" );
        
        foreach ( teamplayer in teamplayers )
        {
            if ( isdefined( teamplayer ) && !teamplayer.extracted )
            {
                winnerplayers[ winnerplayers.size ] = teamplayer;
            }
        }
        
        foreach ( winningplayer in winnerplayers )
        {
            winningplayer utility::callsharedfunc( #"scorpion_event", #"player_win" );
        }
        
        dmz_weapon_case::function_7a94d3bdaf4c4656( winnerplayers );
        var_a77646ba5d2da7d4 = level.var_d0dcfd1df517304f ?? 1;
        
        if ( var_a77646ba5d2da7d4 && ( nukedetonated || br_public::function_379fb7b09f4ef13e() && endreasontext == 25 ) )
        {
            var_a77646ba5d2da7d4 = 0;
        }
        
        if ( var_a77646ba5d2da7d4 )
        {
            br_public::brleaderdialog( "team_victory", 0, winnerplayers, undefined, 1.5, undefined, level.brgametype.dialogprefix );
        }
        
        if ( utility::issharedfuncdefined( #"gametype", #"hash_9274b776f2a290a6" ) )
        {
            utility::callsharedfunc( #"gametype", #"hash_9274b776f2a290a6", winnerplayers );
        }
        else
        {
            br_ending::update_winning_players( winnerplayers );
        }
        
        foreach ( player in winnerplayers )
        {
            player utility::callsharedfunc( #"player", #"hash_20c82231856fcf19" );
        }
        
        winnerplayers = arraycombine( winnerplayers, level.codcasters );
        
        foreach ( player in winnerplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            [ brbonusxp, var_245a2f5a93850587, var_33c0e792d2053e19 ] = player calculatebrbonusxp( 1, winner );
            
            if ( endreasontext == game[ "end_reason" ][ "nuke_end" ] )
            {
                brbonusxp *= isdefined( level.arrow ) ? level.arrow.dvars.var_928fc5c3171c5a69 : 1;
            }
            
            if ( player.inlaststand )
            {
                player thread laststand::exit( "last_stand_self_revive" );
            }
            
            if ( player.gasmaskequipped )
            {
                player thread common_inventory::function_eb484185711f8cc0();
            }
            
            if ( player.insertingarmorplate )
            {
                player notify( #"try_armor_cancel", "game_end" );
            }
            
            if ( player.ishaywire )
            {
                player setscriptablepartstate( "shockStickVfx", "off", 0 );
                player notify( #"shockstick_interrupt" );
            }
            
            player damage_effects::onexitdeathsdoor( 0 );
            
            if ( !nukedetonated )
            {
                player br_spawnrespawn::function_24b79e9319c6f02f();
            }
            
            player.spawnprotection = 1;
            player.falldamageprotection = 1;
            
            if ( !player iscodcaster() )
            {
                player setclientomnvar( "ui_br_player_position", 1 );
                player setplayerdata( level.var_6f9b00680ed002d8, "aarData", "matchResult", game[ "round_end" ][ "victory" ] );
            }
            else
            {
                teamindex = function_f02c63b99c9614c9( level.allteamnamelist, winner );
                player setclientomnvar( "ui_br_player_position", teamindex );
            }
            
            player givebrbonusxp( brbonusxp, undefined, "winner" );
            player.matchbonus = var_245a2f5a93850587;
            player.placementbonus = var_33c0e792d2053e19;
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
            
            if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
            {
                gamelogic_mp::function_a7f2ba55c82bfa95( player );
            }
            
            br_analytics::branalytics_inventory_snapshot( player, "player_win" );
            player setplacementstats( 1 );
            gamelogic_mp::_setplayerteamrank( player, 1 );
            player gamelogic_mp::updateplayerleaderboardstats();
            updateclientmatchdata( player );
            player br_ftue_popups::function_3575388e7b3207cb();
            
            if ( br_public::isbrpracticemode() && !isbot( player ) )
            {
                player thread [[ level.end_game_tutorial_func ]]();
            }
            
            if ( level.var_309e3d9dac389de6 )
            {
                player leagueplay_br::match_end( 1, 1, 0 );
                player setclientomnvar( "ui_league_play_br_can_leave_with_party", 1 );
            }
        }
        
        var_ee837c1ab4c6d9f1 = [];
        
        foreach ( losingteam in level.teamnamelist )
        {
            if ( losingteam == winner )
            {
                continue;
            }
            
            if ( level.var_3b6a18a58216c585 )
            {
                alivecount = teams::getteamdata( losingteam, "teamCount" );
            }
            else
            {
                alivecount = function_1f2e8fad0c533e2d( losingteam );
            }
            
            if ( alivecount > 0 )
            {
                var_ee837c1ab4c6d9f1[ var_ee837c1ab4c6d9f1.size ] = losingteam;
            }
        }
        
        if ( var_ee837c1ab4c6d9f1.size > 0 )
        {
            var_ee837c1ab4c6d9f1 = arraysort( var_ee837c1ab4c6d9f1, undefined, &br_ending::function_6211c053901cea1e );
            
            for ( var_ba5fee5a3f096167 = 0; var_ba5fee5a3f096167 < var_ee837c1ab4c6d9f1.size ; var_ba5fee5a3f096167++ )
            {
                losingteam = var_ee837c1ab4c6d9f1[ var_ba5fee5a3f096167 ];
                
                if ( utility::issharedfuncdefined( #"gametype", #"hash_be8a8c525d1b00bb" ) )
                {
                    teamplacement = utility::callsharedfunc( #"gametype", #"hash_be8a8c525d1b00bb", losingteam );
                }
                else
                {
                    teamplacement = var_ba5fee5a3f096167 + 2;
                }
                
                function_6ddae5560541fc65( losingteam, teamplacement, undefined, 1 );
            }
        }
        
        setaardata( winner );
        level notify( #"team_won", winner );
    }
    else
    {
        remainingteams = [];
        
        foreach ( entry in level.teamnamelist )
        {
            if ( teams::getteamdata( entry, "aliveCount" ) )
            {
                remainingteams[ remainingteams.size ] = entry;
            }
        }
        
        teamplacement = remainingteams.size;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isbot( player ) || istestclient( player ) )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            [ brbonusxp, var_245a2f5a93850587, var_33c0e792d2053e19 ] = player calculatebrbonusxp( teamplacement );
            player givebrbonusxp( brbonusxp, undefined, "endGame" );
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
            
            if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
            {
                gamelogic_mp::function_a7f2ba55c82bfa95( player );
            }
            
            telemetry_utils::function_c54601d44e7b8e8a( player );
            player.spawnprotection = 1;
            player setclientomnvar( "ui_br_player_position", 1 );
            player setplayerdata( level.var_6f9b00680ed002d8, "aarData", "matchResult", game[ "round_end" ][ "victory" ] );
            player br_ftue_popups::function_3575388e7b3207cb();
        }
        
        foreach ( entry in remainingteams )
        {
            setaardata( entry );
        }
    }
    
    var_c71a8bc30a7b241b = undefined;
    
    if ( isdefined( winnerplayers ) )
    {
        var_c71a8bc30a7b241b = br_ending_util::get_center_of_array( winnerplayers );
    }
    
    activeplayers = [];
    
    foreach ( potentialplayer in level.players )
    {
        if ( !potentialplayer br_public::isplayeringulag() && player::isreallyalive( potentialplayer ) )
        {
            activeplayers[ activeplayers.size ] = potentialplayer;
        }
    }
    
    br_analytics::branalytics_economy_snapshot( activeplayers );
    function_b4cf2c4a105f7d32();
    
    if ( !level.var_b1c24afd146c3795 )
    {
        wait 1.5;
    }
    
    if ( isdefined( level.brwinnerscircle ) )
    {
        foreach ( player in level.players )
        {
            if ( [[ level.brwinnerscircle.var_41b10fd9fb1a88d3 ]]( player ) )
            {
                player thread function_30d1343701d4f02a();
            }
        }
    }
    
    if ( isdefined( level.br_endgamesplashcallback ) )
    {
        level thread [[ level.br_endgamesplashcallback ]]( winner );
        
        if ( isdefined( level.br_ending_delay ) )
        {
            wait level.br_ending_delay;
        }
    }
    else
    {
        level thread handleendgamesplash( winner, nukedetonated );
        level thread handleendgamespectatingsplash( winner, nukedetonated );
        
        if ( level.shownonspectatingwinnersplash )
        {
            level thread handleendgamenonwinnersplash( winner, nukedetonated );
        }
        
        if ( isdefined( level.var_e0308e22e5b02b6c ) )
        {
            level thread [[ level.var_e0308e22e5b02b6c ]]( winnerplayers, var_c71a8bc30a7b241b );
        }
        
        if ( isdefined( level.br_ending_delay ) )
        {
            wait level.br_ending_delay;
        }
    }
    
    utility::callsharedfunc( #"gametype", #"hash_385107960a7e13ad", winner );
    level notify( #"post_end_game_splash" );
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        if ( isdefined( level.dmztutendgame ) )
        {
            level thread [[ level.dmztutendgame ]]( winner, endreasontext, game[ "end_reason" ][ "br_eliminated" ] );
            return;
        }
    }
    
    if ( !nukedetonated && level.var_52ec0ab267f26a6e )
    {
        function_c4586a68ec5bc374();
    }
    
    thread function_5c38914a82f45587();
    
    foreach ( player in winnerplayers )
    {
        player perks::_clearperks();
    }
    
    function_fe2241c0cd2008fb( winnerplayers, var_c71a8bc30a7b241b, nukedetonated );
    
    if ( isdefined( level.brwinnerscircle ) )
    {
        thread [[ level.brwinnerscircle.activatewinnerscircle ]]();
        level waittill( #"br_winners_circle_finished" );
    }
    else
    {
        level notify( #"spawning_intermission" );
        intermissionspawnpointoverride = gamelogic_mp::getintermissionspawnpointoverride();
        
        foreach ( player in level.players )
        {
            player thread game_utility_mp::setuipostgamefade( 0 );
            
            if ( !isdefined( level.modespawnendofgame ) || !player [[ level.modespawnendofgame ]]() )
            {
                player thread playerlogic::spawnintermission( intermissionspawnpointoverride );
            }
        }
    }
    
    gamelogic_mp::endgame_regularmp( winner, endreasontext, game[ "end_reason" ][ "br_eliminated" ] );
}

// Namespace br
// Params 0
// Checksum 0xe01a49bf, Offset: 0x14f08
// Size: 0x56
function function_30d1343701d4f02a()
{
    self endon( #"disconnect" );
    
    if ( level.var_52ec0ab267f26a6e )
    {
        level thread game_utility::fadetoblackforplayer( self, 1, 2, 1 );
        thread function_fb9a2701c723571d();
        wait 2;
    }
    
    self thread [[ level.brwinnerscircle.deactivateimmediate ]]();
    player::updatesessionstate( "intermission" );
}

// Namespace br
// Params 0
// Checksum 0xd9b35d2b, Offset: 0x14f66
// Size: 0x30
function function_fb9a2701c723571d()
{
    self endon( #"disconnect" );
    utility::waittill_any( "showing_final_br_killcam", "br_final_killcam_complete" );
    level thread game_utility::fadetoblackforplayer( self, 0, 0.1, 1 );
}

// Namespace br
// Params 1
// Checksum 0xb410b49a, Offset: 0x14f9e
// Size: 0xa9
function function_ea44611c9efd2a1d( endreasontext )
{
    level endon( #"exitlevel_called" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, val );
        
        if ( channel == "skip_end_scene" )
        {
            level.skipfinalkillcam = 1;
            self setclientomnvar( "ui_world_fade", 1 );
            self.var_ee74e8eed7f0fe09 = 1;
            br_ending_chopper::chopperexfil_music_stop();
            level thread gamelogic_mp::endgame_regularmp( level.endgamewinner, endreasontext, game[ "end_reason" ][ "br_eliminated" ], undefined, undefined, undefined, self );
            return;
        }
    }
}

// Namespace br
// Params 0
// Checksum 0xc1aaff40, Offset: 0x1504f
// Size: 0x1f8
function function_c4586a68ec5bc374()
{
    function_b44403946558dddb();
    var_f9b601ae93807322 = [];
    previous_spectateplayer = [];
    
    foreach ( player in level.players )
    {
        var_6aae07e96f2ec785 = player getentitynumber();
        var_f9b601ae93807322[ var_6aae07e96f2ec785 ] = player.sessionstate;
        previous_spectateplayer[ var_6aae07e96f2ec785 ] = player.playertospectate;
    }
    
    foreach ( player in level.players )
    {
        player thread function_e02fc88abd92e4e7( player.sessionstate, player.playertospectate );
    }
    
    level.var_90b47db0527eb6c5 = 1;
    level.var_9ea2f011b00a0134 = 1;
    level.var_40457022b646ec93 = gamelogic_mp::getbrendsplashpostgamestate();
    gamelogic_mp::endgame_showkillcam();
    level.var_9ea2f011b00a0134 = 0;
    level.brdisablefinalkillcam = 1;
    
    foreach ( player in level.players )
    {
        player notify( #"br_final_killcam_complete" );
    }
}

// Namespace br
// Params 2
// Checksum 0x565b18a0, Offset: 0x1524f
// Size: 0x113
function function_e02fc88abd92e4e7( prevsessionstate, playertospectate )
{
    self endon( #"disconnect" );
    utility::waittill_any( "br_final_killcam_complete", "killcam_ended", "killcam_canceled", "abort_killcam" );
    var_4cac55462863faa7 = self getclientomnvar( "post_game_state" );
    
    if ( var_4cac55462863faa7 == 3 || var_4cac55462863faa7 == 4 )
    {
        killcam::killcamcleanup( 0, undefined, 1 );
        self function_f80e60cdd07b8d8e( 0 );
        
        if ( level.var_6dec2a870f55b3c2 )
        {
            player_utility::function_dbe5a52a6654a982();
            playerlogic::respawn_asspectator( self geteye(), self.angles );
            thread gamelogic_mp::freezeplayerforroundend();
            br_spawnrespawn::function_1d2f70d591e967bc();
        }
        else if ( isdefined( prevsessionstate ) )
        {
            if ( prevsessionstate == "spectator" )
            {
                playertospectate = br_spectate::getbestspectatecandidate( self, playertospectate );
                
                if ( isdefined( playertospectate ) )
                {
                    br_spectate::assignspectatortospectateplayer( self, playertospectate );
                }
            }
            else if ( prevsessionstate == "dead" )
            {
                playertospectate = br_spectate::getbestspectatecandidate( self );
                
                if ( isdefined( playertospectate ) )
                {
                    br_spectate::assignspectatortospectateplayer( self, playertospectate );
                }
            }
            else
            {
                player::updatesessionstate( prevsessionstate );
            }
        }
    }
    
    self clearclienttriggeraudiozone();
}

// Namespace br
// Params 0
// Checksum 0xed54b641, Offset: 0x1536a
// Size: 0x34
function function_5c38914a82f45587()
{
    var_54a0b6bc5eacdf05 = getdvarfloat( @"hash_2e566b9447582e8d", 90 );
    
    if ( var_54a0b6bc5eacdf05 < 0 )
    {
        return;
    }
    
    wait var_54a0b6bc5eacdf05;
    level notify( #"ending_scene_terminate" );
}

// Namespace br
// Params 0
// Checksum 0x3d883a5a, Offset: 0x153a6
// Size: 0xa
function function_b4cf2c4a105f7d32()
{
    level thread br_analytics::branalytics_endgame();
}

// Namespace br
// Params 1
// Checksum 0x7b983dda, Offset: 0x153b8
// Size: 0xc
function winnerviewsetup( winners )
{
    
}

// Namespace br
// Params 3
// Checksum 0xbfd26623, Offset: 0x153cc
// Size: 0x23d
function handleendgamesplash( winner, nukedetonated, winnerplayers )
{
    if ( !isdefined( winnerplayers ) )
    {
        winnerplayers = [];
        
        if ( isdefined( winner ) && winner != "tie" && winner != "none" )
        {
            winnerplayers = teams::getteamdata( winner, "players" );
        }
    }
    
    var_ca079f0038cca1c5 = gamelogic_mp::getbrendsplashpostgamestate();
    
    if ( game_utility::getgametype() == "dmz" || game_utility::getgametype() == "plunder" || game_utility::getgametype() == "kingslayer" )
    {
        thread music_and_dialog_br::plunder_endgame_music();
    }
    
    winnerplayers = arraycombine( winnerplayers, level.codcasters );
    
    foreach ( player in winnerplayers )
    {
        player setclientomnvar( "post_game_state", var_ca079f0038cca1c5 );
        player setclientomnvar( "ui_br_end_game_splash_type", 1 );
        
        if ( nukedetonated )
        {
            player setclientomnvar( "ui_br_elite_ending", 1 );
            
            if ( !player iscodcaster() )
            {
                player setclientomnvar( "ui_br_player_position", 1 );
                player setplayerdata( level.var_6f9b00680ed002d8, "aarData", "matchResult", game[ "round_end" ][ "victory" ] );
            }
            else
            {
                teamindex = function_f02c63b99c9614c9( level.allteamnamelist, winner );
                player setclientomnvar( "ui_br_player_position", teamindex );
            }
            
            continue;
        }
        
        if ( level.elite_ironclad && level.elite_ironclad.endingdisarmed )
        {
            player setclientomnvar( "ui_br_elite_ending", 2 );
            
            if ( !player iscodcaster() )
            {
                player setclientomnvar( "ui_br_player_position", 1 );
                continue;
            }
            
            if ( player.team == level.elite_ironclad.cq_team )
            {
                player setclientomnvar( "ui_br_player_position", 3 );
                continue;
            }
            
            player setclientomnvar( "ui_br_player_position", 2 );
        }
    }
}

// Namespace br
// Params 1
// Checksum 0xb77215, Offset: 0x15611
// Size: 0x28b
function function_9c929d466557a460( winner )
{
    var_ca079f0038cca1c5 = gamelogic_mp::getbrendsplashpostgamestate();
    winnerplayers = [];
    
    if ( isdefined( winner ) && winner != "tie" && winner != "none" )
    {
        teamplayers = teams::getteamdata( winner, "players" );
        
        foreach ( teamplayer in teamplayers )
        {
            if ( isdefined( teamplayer ) && !teamplayer.extracted )
            {
                winnerplayers[ winnerplayers.size ] = teamplayer;
            }
        }
    }
    
    winnerplayers = arraycombine( winnerplayers, level.codcasters );
    
    foreach ( player in winnerplayers )
    {
        if ( player iscodcaster() )
        {
            placement = function_f02c63b99c9614c9( level.allteamnamelist, winner ) ?? 1;
        }
        else
        {
            placement = player.teamplacement ?? 1;
        }
        
        player thread function_ec690cc971b0f2ef( player, placement );
        player setclientomnvar( o"post_game_state", var_ca079f0038cca1c5 );
        player setclientomnvar( o"ui_br_end_game_splash_type", 1 );
    }
    
    foreach ( player in level.players )
    {
        if ( player.sessionstate == "spectator" && !arraycontains( winnerplayers, player ) )
        {
            placement = 1;
            iswinner = 0;
            player thread function_ec690cc971b0f2ef( player, placement, iswinner );
            player setclientomnvar( o"post_game_state", var_ca079f0038cca1c5 );
            player setclientomnvar( o"ui_br_end_game_splash_type", 1 );
        }
    }
}

// Namespace br
// Params 0
// Checksum 0x684b60cd, Offset: 0x158a4
// Size: 0x26
function function_f77c92447538eda9()
{
    wait 10;
    setomnvarforallclients( "ui_br_elite_arrow_aar_state", 1 );
    wait 5;
    setomnvarforallclients( "ui_br_elite_arrow_aar_state", 2 );
}

// Namespace br
// Params 2
// Checksum 0x7f4b24e6, Offset: 0x158d2
// Size: 0x1e1
function handleendgamespectatingsplash( winner, nukedetonated )
{
    if ( isdefined( winner ) && winner != "tie" )
    {
        var_ca079f0038cca1c5 = gamelogic_mp::getbrendsplashpostgamestate();
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.playertospectate ) && player.team != winner && !isdefined( player.hasseenendgamesplash ) )
            {
                player setclientomnvar( "post_game_state", var_ca079f0038cca1c5 );
                player setclientomnvar( "ui_br_end_game_splash_type", 1 );
                player.hasseenendgamesplash = 1;
                
                if ( nukedetonated )
                {
                    player setclientomnvar( "ui_br_elite_ending", 1 );
                    player setclientomnvar( "ui_br_player_position", 2 );
                    continue;
                }
                
                if ( isdefined( level.arrow ) && isdefined( level.arrow.defused ) )
                {
                    if ( level.arrow.defused == 1 )
                    {
                        level thread function_f77c92447538eda9();
                    }
                    
                    continue;
                }
                
                if ( level.elite_ironclad && level.elite_ironclad.endingdisarmed )
                {
                    player setclientomnvar( "ui_br_elite_ending", 2 );
                    
                    if ( player.team == level.elite_ironclad.cq_team )
                    {
                        player setclientomnvar( "ui_br_player_position", 3 );
                        continue;
                    }
                    
                    player setclientomnvar( "ui_br_player_position", 2 );
                }
            }
        }
    }
}

// Namespace br
// Params 2
// Checksum 0x60938097, Offset: 0x15abb
// Size: 0x1d1
function handleendgamenonwinnersplash( winner, nukedetonated )
{
    if ( isdefined( winner ) && winner != "tie" )
    {
        var_ca079f0038cca1c5 = gamelogic_mp::getbrendsplashpostgamestate();
        
        foreach ( player in level.players )
        {
            if ( player.team != winner && !isdefined( player.hasseenendgamesplash ) )
            {
                player setclientomnvar( "post_game_state", var_ca079f0038cca1c5 );
                player setclientomnvar( "ui_br_end_game_splash_type", 1 );
                player.hasseenendgamesplash = 1;
                
                if ( nukedetonated )
                {
                    player setclientomnvar( "ui_br_elite_ending", 1 );
                    player setclientomnvar( "ui_br_player_position", 2 );
                    continue;
                }
                
                if ( isdefined( level.arrow ) && isdefined( level.arrow.defused ) )
                {
                    if ( level.arrow.defused == 1 )
                    {
                        level thread function_f77c92447538eda9();
                    }
                    
                    continue;
                }
                
                if ( level.elite_ironclad && level.elite_ironclad.endingdisarmed )
                {
                    player setclientomnvar( "ui_br_elite_ending", 2 );
                    
                    if ( player.team == level.elite_ironclad.cq_team )
                    {
                        player setclientomnvar( "ui_br_player_position", 3 );
                        continue;
                    }
                    
                    player setclientomnvar( "ui_br_player_position", 2 );
                }
            }
        }
    }
}

// Namespace br
// Params 3
// Checksum 0x59a682fc, Offset: 0x15c94
// Size: 0x7f
function function_fe2241c0cd2008fb( winnerplayers, var_c71a8bc30a7b241b, nukedetonated )
{
    level endon( #"ending_scene_terminate" );
    
    if ( isdefined( winnerplayers ) && isdefined( var_c71a8bc30a7b241b ) )
    {
        if ( nukedetonated )
        {
            if ( utility::issharedfuncdefined( #"gametype", #"hash_8e68efc61fb05745" ) )
            {
                utility::callsharedfunc( #"gametype", #"hash_8e68efc61fb05745", winnerplayers, var_c71a8bc30a7b241b );
            }
            
            return;
        }
        
        br_ending::play_ending( winnerplayers, var_c71a8bc30a7b241b );
    }
}

// Namespace br
// Params 1
// Checksum 0x85db4fdc, Offset: 0x15d1b
// Size: 0x2e7
function function_ddfd6706b28c96c4( params )
{
    player = self;
    [ remainingteams, remainingplayers ] = function_d0a17b0653ef321a( [ player.team ] );
    teamplacement = getteamplacement( remainingteams.size );
    
    if ( !isdefined( player.endmatchstats[ "distancePlayerTravel" ] ) )
    {
        player.endmatchstats[ "distancePlayerTravel" ] = 0;
    }
    
    player.endmatchstats[ "distancePlayerTravel" ] = player.endmatchstats[ "distancePlayerTravel" ] + distance2d( player.origin, player.endmatchstats[ "lastLandingSpot" ] ?? player.origin );
    player.endmatchstats[ "lastLandingSpot" ] = undefined;
    player dlog_recordplayerevent( "dlog_event_br_anticheat_match_end_activity", [ "distance_from_spawn_respawn_total", player.endmatchstats[ "distancePlayerTravel" ] ?? 0, "loot_cache_opened_num", player.lootcachesopened ?? player.cachesopened ?? 0, "money_looted_num", player.endmatchstats[ "moneyPickupTimes" ] ?? 0, "placement", teamplacement, "shots_fired_num", player.endmatchstats[ "totalShots" ] ?? 0, "server_time", int( gettime() / 1000 ), "plates_equipped_num", player.endmatchstats[ "platesInserted" ] ?? 0, "vehicle_entered_num", player.endmatchstats[ "vehicleEnter" ] ?? 0, "contracts_started_num", player.endmatchstats[ "teamContractsAssigned" ] ?? 0, "buystation_purchases_num", player.endmatchstats[ "totalPurchases" ] ?? 0, "deaths_num", player.endmatchstats[ "playerDeaths" ] ?? 0, "loadout_opened_num", player.endmatchstats[ "loadoutsOpened" ] ?? 0, "circle_index", level.br_circle.circleindex ?? -1, "map_name", game_utility::getmapname() ?? "", "playlist_id", getplaylistid(), "playlist_name", getplaylistname() ] );
}

// Namespace br
// Params 1
// Checksum 0x2b6f46f, Offset: 0x1600a
// Size: 0x12
function function_7c2313dee0222a3( var_b55d5f06d88a35a7 )
{
    return var_b55d5f06d88a35a7 & 65280;
}

// Namespace br
// Params 1
// Checksum 0xd1623f80, Offset: 0x16025
// Size: 0x14
function function_3de28729170831f5( var_b55d5f06d88a35a7 )
{
    return ( var_b55d5f06d88a35a7 & 255 ) >> 8;
}

// Namespace br
// Params 0
// Checksum 0xca5ced0c, Offset: 0x16042
// Size: 0xe7
function parachutecomplete()
{
    if ( brdoesloadoutoptionusedropbags() && !brareloadoutdropbagsdelayed() && !self.dropbagspawned && !level.precomputeddropbags )
    {
        if ( br_public::isplayerbrsquadleader() )
        {
            thread br_rewards::spawndropbagonlanding();
            
            foreach ( player in level.teamdata[ self.team ][ "players" ] )
            {
                player.dropbagspawned = 1;
            }
        }
    }
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        thread br_armory_kiosk::showdiscountsplash( 5 );
    }
}

// Namespace br
// Params 2
// Checksum 0x6e424b94, Offset: 0x16131
// Size: 0x60
function spawnintermission( spawnorigin, spawnangles )
{
    playerlogic::setspawnvariables();
    self freezecontrols( 1 );
    player::updatesessionstate( "intermission" );
    player::clearkillcamstate();
    self.friendlydamage = undefined;
    self spawn( spawnorigin, spawnangles );
    player::printspawnmessage( "playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + spawnorigin );
    player::setdof_spectator();
}

// Namespace br
// Params 1
// Checksum 0x886cc514, Offset: 0x16199
// Size: 0x116
function brprewaitandspawnclient( revivespawn )
{
    if ( !isdefined( self.prespawnspawn ) || self isplayerheadless() )
    {
        self setclientomnvar( "ui_br_extended_load_screen", 0 );
        return;
    }
    
    thread brprewaitandspawnclientcleanup();
    
    if ( !isdefined( self.initialprespawn ) && !revivespawn )
    {
        streamorigin = self.prespawnspawn.origin;
        droporigin = br_public::playerstreamhintdroptoground( streamorigin );
        timeout = getdvarint( @"hash_6ce81e74109af8d3", 9000 );
        streamhint::playerstreamhintlocation( droporigin, timeout, 1 );
        
        if ( !level.x1playertransition && !self.x1playertransition )
        {
            function_db10c8f42ea08ad5();
            self setclientomnvar( "ui_br_transition_type", 4 );
        }
        
        wait 0.5;
        spawnintermission( droporigin, self.prespawnspawn.angles );
        spectating::setdisabled();
    }
    else
    {
        self.initialprespawn = undefined;
    }
    
    streamhint::playerwaittillstreamhintcomplete();
    self freezecontrols( 0 );
}

// Namespace br
// Params 1
// Checksum 0x2f018f36, Offset: 0x162b7
// Size: 0x26
function function_4388e2f9d9ab4302( revivespawn )
{
    streamhint::playerwaittillstreamhintcomplete();
    self setclientomnvar( "ui_br_extended_load_screen", 0 );
    self freezecontrols( 0 );
}

// Namespace br
// Params 0
// Checksum 0xee80909a, Offset: 0x162e5
// Size: 0x4f
function brprewaitandspawnclientcleanup()
{
    self endon( #"disconnect" );
    self waittill( #"hash_36e455a1fbf78b10" );
    
    if ( streamhint::function_bac26315148e18d3() )
    {
        self clearpredictedstreampos();
    }
    
    if ( !level.x1playertransition )
    {
        self setclientomnvar( "ui_br_transition_type", 0 );
    }
    
    self setclientomnvar( "ui_br_extended_load_screen", 0 );
}

// Namespace br
// Params 0
// Checksum 0x80177c39, Offset: 0x1633c
// Size: 0xc
function brprematchaddkill()
{
    self.kills++;
}

// Namespace br
// Params 1
// Checksum 0x8506d324, Offset: 0x16350
// Size: 0x50
function bronattackerdamagenottracked( damage )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        if ( isdefined( self.pers[ "damage" ] ) )
        {
            self.pers[ "damage" ] = self.pers[ "damage" ] + damage;
        }
    }
}

// Namespace br
// Params 0
// Checksum 0x626e4cae, Offset: 0x163a8
// Size: 0x176
function brclearscoreboardstats()
{
    foreach ( player in level.players )
    {
        player.kills = 0;
        player.pers[ "kills" ] = 0;
        player.deaths = 0;
        player.pers[ "deaths" ] = 0;
        player.score = 0;
        player.pers[ "score" ] = 0;
        player.brmissionscompleted = 0;
        player.pers[ "contracts" ] = 0;
        player br_public::updatebrscoreboardstat( "missionsCompleted", 0 );
        player.pers[ "damage" ] = 0;
        player br_public::updatebrscoreboardstat( "damageDealt", 0 );
        
        if ( level.gamemodebundle.var_2fc669d4ccb1f63e && isdefined( player.pers[ "telemetry" ] ) )
        {
            player.pers[ "telemetry" ].eliminations = 0;
        }
        
        player mp_afk::function_9592b6d120cfac02();
        waitframe();
    }
}

// Namespace br
// Params 1
// Checksum 0xc3af0cfa, Offset: 0x16526
// Size: 0xf6
function brclosealldoors( var_2a2f438cc088aed3 )
{
    level endon( #"game_ended" );
    doors = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "door" );
    var_43ba82285c8164ec = 0;
    var_161ebf5f1f5d2368 = isint( var_2a2f438cc088aed3 );
    
    foreach ( door in doors )
    {
        if ( door scriptableisdoor() && !door scriptabledoorisclosed() && door getscriptablepartstate( "door" ) != "invisible" )
        {
            door scriptabledoorclose();
            
            if ( var_161ebf5f1f5d2368 )
            {
                var_43ba82285c8164ec++;
                
                if ( var_43ba82285c8164ec >= var_2a2f438cc088aed3 )
                {
                    var_43ba82285c8164ec = 0;
                    waitframe();
                }
            }
        }
    }
}

// Namespace br
// Params 1
// Checksum 0x838c5343, Offset: 0x16624
// Size: 0x48
function function_3a5a6da2f713a021( timeoutval )
{
    notifystruct = spawnstruct();
    thread function_5e16152a74132b2d( notifystruct );
    thread waittilltimeout_proc( notifystruct, timeoutval );
    notifystruct waittill( #"waittill_proc" );
    return notifystruct.result;
}

// Namespace br
// Params 1
// Checksum 0x75affd18, Offset: 0x16675
// Size: 0x4d
function function_5e16152a74132b2d( notifystruct )
{
    notifystruct endon( #"waittill_proc" );
    self waittill( #"hash_ecaee5fe31e41a5c", newclass );
    notifystruct.result = newclass;
    notifystruct notify( #"waittill_proc" );
}

// Namespace br
// Params 2
// Checksum 0x16608a49, Offset: 0x166ca
// Size: 0x32
function waittilltimeout_proc( notifystruct, timeoutval )
{
    notifystruct endon( #"waittill_proc" );
    wait timeoutval;
    notifystruct notify( #"waittill_proc" );
}

// Namespace br
// Params 1
// Checksum 0x3f24ad0a, Offset: 0x16704
// Size: 0x18
function function_dea516253845d656( value )
{
    self notify( #"hash_ccc5903b99aa1c2f" );
}

// Namespace br
// Params 1
// Checksum 0x57f3b73f, Offset: 0x16724
// Size: 0x1a
function function_977d10e894425865( value )
{
    self notify( #"hash_ecaee5fe31e41a5c", value );
}

// Namespace br
// Params 1
// Checksum 0xa44a43e1, Offset: 0x16746
// Size: 0x270
function playerselectspawnclass( crateent )
{
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"halo_kick_c130" );
    self endon( #"meatshield_victim_start" );
    self endon( #"hash_ccc5903b99aa1c2f" );
    self endon( #"br_selectdropbagclass_done" );
    self endon( #"pushed_too_far" );
    self endon( #"player_ishaywire" );
    level endon( #"game_ended" );
    level endon( #"end_spawn_selection" );
    
    if ( getdvarint( @"hash_206a763969420ce0", 0 ) == 1 && isbrgamemode() && game_utility::getgametype() != "plunder" && game_utility::getgametype() != "sandbox" )
    {
        classchoicefunc = isdefined( level.allowclasschoicefunc ) && self [[ level.allowclasschoicefunc ]]();
        script::demoforcesre( "playerSelectSpawnClass() " + self.name + " ui_open_menu_from_script = UI_MENU_LOADOUT_MENU, allowClassChoiceFunc = " + classchoicefunc );
    }
    
    self setclientomnvar( "ui_open_menu_from_script", 2 );
    childthread common_kiosk::_proximitywatcher( crateent );
    initialchoice = "custom1";
    self.pers[ "class" ] = initialchoice;
    self.class = initialchoice;
    class::preloadandqueueclass( initialchoice );
    var_fea6887953d02815 = getdvarfloat( @"scr_br_dropbag_timeout", 0 );
    var_cdd1595cc55d3eb7 = 0;
    var_c8082ee0927132a1 = var_fea6887953d02815 > 0;
    
    while ( true )
    {
        channel = undefined;
        newclass = undefined;
        
        if ( var_c8082ee0927132a1 )
        {
            result = function_3a5a6da2f713a021( 1 );
            
            if ( !isdefined( result ) )
            {
                var_cdd1595cc55d3eb7 += 1;
                
                if ( var_cdd1595cc55d3eb7 > var_fea6887953d02815 )
                {
                    self setclientomnvar( "ui_open_menu_from_script", -1 );
                    return 0;
                }
                
                self setclientomnvar( "ui_open_menu_from_script", 2 );
                continue;
            }
            
            newclass = result;
        }
        else
        {
            self waittill( #"hash_ecaee5fe31e41a5c", newclass );
        }
        
        retval = 0;
        
        if ( newclass >= 0 )
        {
            newclasschoice = menus::getclasschoice( newclass );
            self.pers[ "class" ] = newclasschoice;
            self.class = newclasschoice;
            class::preloadandqueueclass( newclasschoice );
            retval = 1;
        }
        
        self setclientomnvar( "ui_open_menu_from_script", -1 );
        return retval;
    }
}

// Namespace br
// Params 0
// Checksum 0xdf309a6c, Offset: 0x169be
// Size: 0x198
function monitorjumpmasterclaim()
{
    player = self;
    player endon( #"disconnect" );
    player thread listenforjumpmasterclaimluanotify();
    
    for ( jumpmasterclaimed = 0; !flags::gameflag( "end_spawn_selection" ) ; jumpmasterclaimed = 1 )
    {
        msg = player utility::waittill_any_ents_return( player, "attempt_jumpmaster_claim", player, "squad_jumpmaster_claimed", level, "end_spawn_selection" );
        
        if ( msg == "attempt_jumpmaster_claim" )
        {
            if ( !jumpmasterclaimed )
            {
                player br_public::updatebrscoreboardstat( "jumpMasterState", 2 );
                player.issquadleader = 1;
                player lower_message::setlowermessageomnvar( "br_player_is_jumpmaster" );
                members = teams::getfriendlyplayers( player.team, 0 );
                
                foreach ( member in members )
                {
                    if ( member != player )
                    {
                        member.issquadleader = 0;
                        member br_public::updatebrscoreboardstat( "jumpMasterState", 0 );
                        member notify( #"squad_jumpmaster_claimed" );
                        member lower_message::setlowermessageomnvar( "br_teammate_is_jumpmaster" );
                    }
                }
            }
            else
            {
                player br_public::updatebrscoreboardstat( "jumpMasterState", 1 );
                player lower_message::setlowermessageomnvar( "br_player_deploy_solo" );
            }
            
            continue;
        }
        
        if ( msg == "squad_jumpmaster_claimed" )
        {
        }
    }
}

// Namespace br
// Params 0
// Checksum 0xe3cf32f4, Offset: 0x16b5e
// Size: 0x86
function listenforjumpmasterclaimluanotify()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"hash_b0cf5a014a01e960" );
    player endon( #"hash_b0cf5a014a01e960" );
    level endon( #"end_spawn_selection" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", notification );
        
        if ( notification == "attempt_jumpmaster_claim" )
        {
            player notify( #"attempt_jumpmaster_claim" );
        }
    }
}

// Namespace br
// Params 0
// Checksum 0xc327c9be, Offset: 0x16bec
// Size: 0x4b
function sendafksquadmembertogulag()
{
    player = self;
    player.br_infilstarted = 1;
    player setclientomnvar( "ui_br_infil_started", 1 );
    player setclientomnvar( "ui_br_infiled", 1 );
    player player_utility::function_b54a1e23734ef07( 1 );
    player kill();
}

// Namespace br
// Params 0
// Checksum 0x17a9d6, Offset: 0x16c3f
// Size: 0x53
function br_displayperkinfo()
{
    self endon( #"disconnect" );
    
    if ( isdefined( level.isstandardsandbox ) && !level.isstandardsandbox )
    {
        return;
    }
    
    if ( br_public::function_f15af281b8fa7b96() )
    {
        return;
    }
    
    self setclientomnvar( "ui_br_display_perk_info", 1 );
    wait 0.1;
    self setclientomnvar( "ui_br_display_perk_info", 0 );
}

// Namespace br
// Params 3
// Checksum 0x48a8df06, Offset: 0x16c9a
// Size: 0x423
function br_giveselectedclass( player, dropcurrent, dropbehind )
{
    player.gettingloadout = 1;
    player.var_b4c45c2992c2e37c = {};
    player.var_b4c45c2992c2e37c.stackprimary = player equipment_mp::getcurrentequipment( "primary" ) == player.preloadedclassstruct.loadoutequipmentprimary;
    player.var_b4c45c2992c2e37c.stacksecondary = player equipment_mp::getcurrentequipment( "secondary" ) == player.preloadedclassstruct.loadoutequipmentsecondary;
    dropstruct = br_clearinventory( player, dropcurrent, dropbehind );
    options = player utility::callsharedfunc( #"loadout", #"hash_848489887bcebdd5" );
    
    if ( !namespace_5ab67a14d18bea3f::function_43c57123ed24d409() || !isdefined( player.var_24633d8241ca5c23.var_3cb7bc08e98113e2 ) || player.var_24633d8241ca5c23.var_3cb7bc08e98113e2 != "brloot_perkpack_specialist_jup" )
    {
        player.prevweaponobj = undefined;
        
        if ( !options.var_dc70254216f48951 )
        {
            player class::loadout_clearperks();
        }
        
        givelaststandifneeded( player );
    }
    else
    {
        newperkpackage = namespace_5ab67a14d18bea3f::function_4369e50a95cc3940( player.classstruct.loadoutperks );
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( player );
        common_item::items_spawnitemfromscriptable( newperkpackage, 1, spawnoptions );
    }
    
    player class::giveloadout( player.team, player.class, undefined, 1, 0, 0, 0, 1, options );
    var_908edfb703ce80d1 = "none";
    var_5a1ed6750ff09281 = "none";
    var_87ebce4cb9d9243c = 0;
    var_42a17be4f1eba70c = 0;
    
    if ( isdefined( player.classstruct.loadoutequipmentprimary ) )
    {
        var_908edfb703ce80d1 = player.classstruct.loadoutequipmentprimary;
        
        if ( player.classstruct.var_a1191d5606e653f0 > 0 )
        {
            var_87ebce4cb9d9243c = player.classstruct.var_a1191d5606e653f0;
        }
    }
    
    if ( isdefined( player.classstruct.loadoutequipmentsecondary ) )
    {
        var_5a1ed6750ff09281 = player.classstruct.loadoutequipmentsecondary;
        
        if ( player.classstruct.var_9481e959139fe88 > 0 )
        {
            var_42a17be4f1eba70c = player.classstruct.var_9481e959139fe88;
        }
    }
    
    if ( getdvarint( @"hash_b8f058869941e6eb", 1 ) )
    {
        if ( var_87ebce4cb9d9243c == 0 && var_42a17be4f1eba70c == 0 )
        {
            player.var_8cf9648fae56099c = undefined;
        }
        else
        {
            player.var_8cf9648fae56099c = [];
            
            if ( var_87ebce4cb9d9243c != 0 )
            {
                player.var_8cf9648fae56099c[ var_908edfb703ce80d1 ] = var_87ebce4cb9d9243c;
            }
            
            if ( var_42a17be4f1eba70c != 0 )
            {
                player.var_8cf9648fae56099c[ var_5a1ed6750ff09281 ] = var_42a17be4f1eba70c;
            }
        }
    }
    
    player.gettingloadout = 0;
    player notify( #"giveloadout" );
    player thread br_displayperkinfo();
    inlaststand = istrue( player.inlaststand );
    
    if ( inlaststand )
    {
        laststandoldweaponobj = player getcurrentprimaryweapon();
        
        if ( !isweapon( laststandoldweaponobj ) )
        {
            laststandoldweaponobj = makeweapon( laststandoldweaponobj );
        }
        
        self.laststandoldweaponobj = laststandoldweaponobj;
        laststandweapon = player brchooselaststandweapon();
        
        if ( !isweapon( laststandweapon ) )
        {
            laststandweapon = makeweapon( laststandweapon );
        }
        
        player laststand::givelaststandweapon( laststandweapon );
        
        if ( !isdefined( player.perks[ "specialty_pistoldeath" ] ) )
        {
            player perk::giveperk( "specialty_pistoldeath" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"ongiveselectedclass" ) )
    {
        player utility::callsharedfunc( #"gametype", #"ongiveselectedclass" );
    }
    
    player.var_b4c45c2992c2e37c = undefined;
}

// Namespace br
// Params 3
// Checksum 0xb312330, Offset: 0x170c5
// Size: 0x81
function br_clearinventory( player, dropcurrent, dropbehind )
{
    if ( dropcurrent )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( player );
        
        if ( dropbehind )
        {
            spawnoptions.spawnpositionindex = 17;
            spawnoptions.var_12d76a8b35ac875d = 13;
        }
        
        player common_inventory::function_3644767c4087b4cc( spawnoptions );
        player common_inventory::function_1e5fbfd034d154ff( spawnoptions );
        return;
    }
    
    player common_inventory::inventory_clearloadout();
    player common_inventory::function_1202b827227d4ad2();
}

// Namespace br
// Params 1, eflags: 0x4
// Checksum 0xdd99f275, Offset: 0x1714e
// Size: 0x2e
function private function_2945e6179a6c0483( crateent )
{
    self endon( #"br_selectdropbagclass_done" );
    crateent waittill( #"death" );
    function_977d10e894425865( undefined );
}

// Namespace br
// Params 1
// Checksum 0x683abc28, Offset: 0x17184
// Size: 0x78
function br_selectdropbagclass( crateent )
{
    self endon( #"disconnect" );
    childthread function_2945e6179a6c0483( crateent );
    self freezecontrols( 1 );
    self setclientomnvar( "ui_open_loadout_bag", 1 );
    retval = playerselectspawnclass( crateent );
    self setclientomnvar( "ui_open_menu_from_script", -1 );
    self setclientomnvar( "ui_open_loadout_bag", 0 );
    self freezecontrols( 0 );
    self notify( #"br_selectdropbagclass_done" );
    return retval;
}

// Namespace br
// Params 1
// Checksum 0x6eda429c, Offset: 0x17205
// Size: 0x3e
function bronloadoutcratedestroyed( immediate )
{
    level notify( "dropbag_kill_callout_" + self.origin );
    
    if ( isbrgamemode() )
    {
        br_analytics::branalytics_dropbagdestroyed( self.team, self.origin );
    }
}

// Namespace br
// Params 0
// Checksum 0x9cab79b2, Offset: 0x1724b
// Size: 0xfe
function cleanupdropbagsoncircle()
{
    if ( !getdvarint( @"hash_e91068b532510e98", 0 ) )
    {
        return;
    }
    
    level waittill( #"br_circle_started" );
    
    while ( level.br_crates.size > 0 )
    {
        remainingcrates = [];
        
        foreach ( crate in level.br_crates )
        {
            if ( isdefined( crate ) && ( !isdefined( crate.curprogress ) || crate.curprogress == 0 ) )
            {
                crate thread airdrop::destroycrate();
                continue;
            }
            
            remainingcrates[ remainingcrates.size ] = crate;
        }
        
        level.br_crates = remainingcrates;
        remainingcrates = undefined;
        wait 1;
    }
}

// Namespace br
// Params 0
// Checksum 0xfa6dcfd9, Offset: 0x17351
// Size: 0x2f
function brchooselaststandweapon()
{
    downedplayer = self;
    laststandweapon = downedplayer player::function_bb5faf1c22bd8139();
    
    if ( !isdefined( laststandweapon ) )
    {
        laststandweapon = "iw9_gunless";
    }
    
    return laststandweapon;
}

// Namespace br
// Params 1
// Checksum 0x325658eb, Offset: 0x17389
// Size: 0x15
function playerexitlaststand( revived )
{
    br_gulag::playerexitlaststand( revived );
}

// Namespace br
// Params 9
// Checksum 0x46481e53, Offset: 0x173a6
// Size: 0xb8
function modelaststandallowed( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    damagedata = damage_utility::packdamagedata( attacker, self, idamage, objweapon, smeansofdeath, einflictor, undefined, vdir );
    damagedata.hitloc = shitloc;
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_7176c1a02c5f7181" ) )
    {
        return utility::callsharedfunc( #"gametype", #"hash_7176c1a02c5f7181", damagedata );
    }
    
    return 1;
}

// Namespace br
// Params 1
// Checksum 0x56f11606, Offset: 0x17467
// Size: 0x204, Type: bool
function isvalidkillcam( deathdata )
{
    attacker = deathdata.attacker;
    
    if ( !isdefined( attacker ) )
    {
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "isValidKillcam - !isdefined( attacker )" );
        }
        
        return false;
    }
    
    if ( deathdata.assistedsuicide )
    {
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "isValidKillcam - deathData.assistedSuicide" );
        }
        
        return false;
    }
    
    var_7de4ef0e63f15c42 = br_gametypes::isfeaturedisabled( #"gulag" );
    enabledkillcam = isdefined( level.var_56c3cc3dc37f1728 ) && level.var_56c3cc3dc37f1728.var_e49cc02cc5353ed2;
    attackeringulag = istrue( attacker.gulag );
    
    if ( !var_7de4ef0e63f15c42 && !enabledkillcam && attackeringulag )
    {
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "isValidKillcam - Disable killcam in wz2 gulag" );
        }
        
        return false;
    }
    
    if ( br_public::isbrpracticemode() )
    {
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "isValidKillcam - br_public::isBrPracticeMode()" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace br
// Params 1
// Checksum 0xdddd5d69, Offset: 0x17674
// Size: 0xe5
function brvalidatekillcam( deathdata )
{
    if ( isdefined( deathdata ) )
    {
        if ( !isvalidkillcam( deathdata ) )
        {
            deathdata.dokillcam = 0;
            
            if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
            {
                logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "brValidateKillcam - !isValidKillcam - deathData.doKillcam=" + deathdata.dokillcam );
            }
        }
        
        if ( !deathdata.dokillcam && streamhint::function_bac26315148e18d3() )
        {
            deathdata.victim clearpredictedstreampos();
        }
        
        if ( !br_gametypes::isfeaturedisabled( #"teamspectate" ) )
        {
            br_spectate::migratespectators( deathdata.victim, deathdata.attacker, 1 );
        }
    }
}

// Namespace br
// Params 1
// Checksum 0xc060ec6c, Offset: 0x17761
// Size: 0x43, Type: bool
function iscontender( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !isalive( player ) )
    {
        return false;
    }
    
    if ( player.gulag )
    {
        return false;
    }
    
    if ( player.inlaststand )
    {
        return false;
    }
    
    return true;
}

// Namespace br
// Params 1
// Checksum 0xae78fe54, Offset: 0x177ad
// Size: 0xab
function getteamcontenders( team )
{
    contenders = [];
    teamplayers = teams::getteamdata( team, "players" );
    
    foreach ( player in teamplayers )
    {
        if ( iscontender( player ) )
        {
            contenders[ contenders.size ] = player;
        }
    }
    
    return contenders;
}

// Namespace br
// Params 2
// Checksum 0xa59a111, Offset: 0x17861
// Size: 0xbe
function onkillingblow( eattacker, victim )
{
    laststandpistol = player::function_bb5faf1c22bd8139();
    eattacker thread br_ftue_popups::function_75685f2376c4d9dd( victim );
    
    if ( iscontender( victim ) && !isdefined( laststandpistol ) )
    {
        teamcontenders = getteamcontenders( victim.team );
        
        if ( teamcontenders.size < 2 && level.gametypebundle.var_11ae6843139d3a29 )
        {
            if ( isdefined( victim.perks[ "specialty_pistoldeath" ] ) )
            {
                victim perk::removeperk( "specialty_pistoldeath" );
            }
        }
        
        if ( !br_gametypes::isfeaturedisabled( #"armor" ) )
        {
            victim armor::breakarmor();
        }
    }
}

// Namespace br
// Params 13
// Checksum 0x6319ee71, Offset: 0x17927
// Size: 0xa2
function brpreplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname )
{
    if ( isdefined( eattacker ) && eattacker != victim && idamage >= victim.health )
    {
        onkillingblow( eattacker, victim );
    }
}

// Namespace br
// Params 1
// Checksum 0xc2e110e6, Offset: 0x179d1
// Size: 0xc9
function brgetloadoutoptionforname( optionname )
{
    switch ( optionname )
    {
        case #"hash_637736d2cc79a66a":
            return 0;
        case #"hash_6802d55b718bb80c":
            return 1;
        case #"hash_5c4a066eee06656f":
            return 2;
        case #"hash_1044c90df8c82a06":
            return 3;
        case #"hash_b7bf6d462722cd22":
            return 4;
        case #"hash_7e142e28390437c3":
            return 5;
        case #"hash_598a22fbc1839c23":
            return 6;
        case #"hash_20b5567cb6b9bd05":
            return 7;
        case #"hash_13736900bcbfc080":
            return 8;
        case #"hash_d038971dd19d318e":
            return 9;
        default:
            assertmsg( "<dev string:x3d1>" + optionname );
            return 0;
    }
}

// Namespace br
// Params 0
// Checksum 0x58292dab, Offset: 0x17aa2
// Size: 0x70
function brinitloadoutoption()
{
    optionname = getmatchrulesdata( "brData", "loadoutOption" );
    
    if ( optionname == "" && getprojectname() == "REW" )
    {
        optionname = "pistolarmordropbagtime";
    }
    
    optionval = brgetloadoutoptionforname( optionname );
    level.br_loadout_option = optionval;
    level.var_8b5c8ccd3713ff45 = getdvarint( @"hash_d70b4de72ad5ad0b", 0 );
}

// Namespace br
// Params 0
// Checksum 0x4e801191, Offset: 0x17b1a
// Size: 0x3c, Type: bool
function brdoesloadoutoptionrequireclassselection()
{
    return isdefined( level.br_loadout_option ) && ( level.br_loadout_option == 1 || level.br_loadout_option == 2 || level.br_loadout_option == 3 );
}

// Namespace br
// Params 0
// Checksum 0xe6748852, Offset: 0x17b5f
// Size: 0x50, Type: bool
function brdoesloadoutoptionusedropbags()
{
    if ( br_gametypes::isfeaturedisabled( #"hash_56a2d01019099833" ) )
    {
        return false;
    }
    
    return isdefined( level.br_loadout_option ) && ( level.br_loadout_option == 4 || level.br_loadout_option == 5 || level.br_loadout_option == 6 );
}

// Namespace br
// Params 0
// Checksum 0xad1d0069, Offset: 0x17bb8
// Size: 0x40, Type: bool
function brareloadoutdropbagsdelayed()
{
    if ( br_gametypes::isfeaturedisabled( #"hash_56a2d01019099833" ) )
    {
        return false;
    }
    
    return isdefined( level.br_loadout_option ) && ( level.br_loadout_option == 5 || level.br_loadout_option == 6 );
}

// Namespace br
// Params 0
// Checksum 0x2b74629, Offset: 0x17c01
// Size: 0x29, Type: bool
function function_a0a90a9479ad06ce()
{
    return isdefined( level.br_loadout_option ) && level.var_8b5c8ccd3713ff45 && level.br_loadout_option == 6;
}

// Namespace br
// Params 0
// Checksum 0x33204d5a, Offset: 0x17c33
// Size: 0x30, Type: bool
function function_7759b233270594b8()
{
    if ( br_gametypes::isfeaturedisabled( #"hash_56a2d01019099833" ) )
    {
        return false;
    }
    
    return isdefined( level.br_loadout_option ) && level.br_loadout_option == 9;
}

// Namespace br
// Params 0
// Checksum 0xed59716, Offset: 0x17c6c
// Size: 0x144
function brgetloadoutdropbagsdelayseconds()
{
    delayarray = [];
    
    if ( !isdefined( level.br_level ) )
    {
        delayarray[ delayarray.size ] = 1;
        return delayarray;
    }
    
    var_9b98e189af07e092 = level.brgametype.dropbagdelay;
    
    if ( isdefined( var_9b98e189af07e092 ) )
    {
        if ( isarray( var_9b98e189af07e092 ) )
        {
            delayarray = var_9b98e189af07e092;
        }
        else
        {
            delayarray[ delayarray.size ] = var_9b98e189af07e092;
        }
        
        return delayarray;
    }
    
    var_a18546b2b072c907 = -15;
    circleindex = getdvarint( @"scr_br_dropbag_circle_index", 0 );
    firsttime = br_circle::getcircleclosetime( circleindex );
    firstdefaultval = max( 0, firsttime + var_a18546b2b072c907 );
    firstdelay = getdvarfloat( @"scr_br_dropbag_delay", firstdefaultval );
    delayarray[ delayarray.size ] = firstdelay;
    
    if ( getdvarint( @"scr_br_dropbag2_enabled", 0 ) && !br_gametypes::isfeatureenabled( #"dropbagloop" ) )
    {
        var_4363209175961d6d = 15;
        secondtime = br_gulag::gettimetogulagclosed();
        seconddefaultval = max( 0, secondtime + var_4363209175961d6d );
        seconddelay = getdvarfloat( @"hash_3771b5264b3f0789", seconddefaultval );
        delayarray[ delayarray.size ] = seconddelay;
    }
    
    return delayarray;
}

// Namespace br
// Params 0
// Checksum 0xc66e3112, Offset: 0x17db9
// Size: 0x114
function function_9b0eda41c7cf9617()
{
    delayarray = [];
    var_9b98e189af07e092 = level.brgametype.dropplanedelay;
    
    if ( isdefined( var_9b98e189af07e092 ) )
    {
        delayarray[ delayarray.size ] = var_9b98e189af07e092;
        return delayarray;
    }
    
    circleindex = getdvarint( @"hash_7073e48b9fd3d775", 1 ) - 1;
    var_6e6ff8fe385db3a = getdvarint( @"hash_431d9d141b0ff196", 1 );
    
    if ( circleindex >= 0 )
    {
        waittime = function_807095f9190709fb( circleindex, var_6e6ff8fe385db3a );
        waitdelta = getdvarint( @"hash_edb26fb318f05407", 40 );
        waittime = max( 5, waittime - waitdelta );
        delayarray[ delayarray.size ] = waittime;
    }
    
    circleindex = getdvarint( @"hash_c65a2ca664793f10", 4 ) - 1;
    var_6e6ff8fe385db3a = getdvarint( @"hash_a1fa1d5514626abd", 1 );
    
    if ( circleindex >= 0 )
    {
        waittime = function_807095f9190709fb( circleindex, var_6e6ff8fe385db3a );
        waitdelta = getdvarint( @"hash_3d529093f4ec34e2", 15 );
        waittime = max( 5, waittime - waitdelta );
        delayarray[ delayarray.size ] = waittime;
    }
    
    return delayarray;
}

// Namespace br
// Params 2
// Checksum 0x1e33641f, Offset: 0x17ed6
// Size: 0x4b
function function_807095f9190709fb( circleindex, var_6e6ff8fe385db3a )
{
    waittime = br_circle::getcircleclosetime( circleindex );
    
    if ( !var_6e6ff8fe385db3a )
    {
        waittime -= level.br_level.br_circleclosetimes[ circleindex ];
    }
    
    return waittime;
}

// Namespace br
// Params 0
// Checksum 0x5b5d4480, Offset: 0x17f2a
// Size: 0x4c, Type: bool
function brdoesloadoutoptiongivestandardloadoutimmediately()
{
    return isdefined( level.br_loadout_option ) && ( level.br_loadout_option == 6 || level.br_loadout_option == 7 || level.br_loadout_option == 8 || level.br_loadout_option == 9 );
}

// Namespace br
// Params 0
// Checksum 0xcf8196ef, Offset: 0x17f7f
// Size: 0x70
function brgetloadoutoptionstandardloadoutindex()
{
    assert( isdefined( level.br_loadout_option ) );
    
    switch ( level.br_loadout_option )
    {
        case 6:
        case 7:
        case 8:
        case 9:
            return 0;
        default:
            assertmsg( "<dev string:x3ea>" );
            break;
    }
}

// Namespace br
// Params 0
// Checksum 0x317a5400, Offset: 0x17ff7
// Size: 0x3c, Type: bool
function brdoesloadoutoptiongivecustomweaponsimmediately()
{
    return isdefined( level.br_loadout_option ) && ( level.br_loadout_option == 1 || level.br_loadout_option == 2 || level.br_loadout_option == 3 );
}

// Namespace br
// Params 0
// Checksum 0x2c97eb6a, Offset: 0x1803c
// Size: 0x41
function brgetloadoutammomultiplier()
{
    if ( isdefined( level.br_loadout_option ) )
    {
        if ( level.br_loadout_option == 2 )
        {
            return 0.5;
        }
        else if ( level.br_loadout_option == 3 )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace br
// Params 0
// Checksum 0x3cc9e7df, Offset: 0x18086
// Size: 0x21
function brgetloadoutammomax()
{
    if ( isdefined( level.br_loadout_option ) )
    {
        if ( level.br_loadout_option == 2 )
        {
            return 20;
        }
    }
}

// Namespace br
// Params 0
// Checksum 0x1b77d160, Offset: 0x180b0
// Size: 0xc, Type: bool
function function_19ef84cc9d20f71()
{
    return isdefined( level.respawnloadout );
}

// Namespace br
// Params 1
// Checksum 0x5a0bcfb1, Offset: 0x180c5
// Size: 0x149
function brloadoutupdateammo( loadoutweapons )
{
    prematchactive = flags::gameflagexists( "prematch_done" ) && !flags::gameflag( "prematch_done" );
    
    foreach ( weapon in loadoutweapons )
    {
        givemaxammo = weapon hasattachment( "maxammo" ) || prematchactive || level.var_8a80723669278851;
        
        if ( givemaxammo )
        {
            item_ammo::function_46e5ccf39665fcf4( weapon, 0, 0, 1 );
            continue;
        }
        
        currentammo = item_ammo::function_f01abfab49a719a0( self, weapon );
        ammotype = item_ammo::function_b162feeed34a4640( weapon );
        
        if ( !isdefined( ammotype ) )
        {
            continue;
        }
        
        desiredammo = level.magcount * item_ammo::function_b956ec34b65538e( ammotype );
        var_8bb1b2bde27b267c = desiredammo - ( currentammo ?? 0 );
        
        if ( var_8bb1b2bde27b267c > 0 )
        {
            item_ammo::function_46e5ccf39665fcf4( weapon, 0, 0, 0, var_8bb1b2bde27b267c );
        }
    }
}

// Namespace br
// Params 2
// Checksum 0xf0a78ee7, Offset: 0x18216
// Size: 0x1bb
function function_ea36aaaded0fd51f( equipmentrefs, var_300f5fc91e32413f )
{
    prematchactive = flags::gameflagexists( "prematch_done" ) && !flags::gameflag( "prematch_done" );
    
    foreach ( equipmentref in equipmentrefs )
    {
        if ( equipmentref == "none" )
        {
            continue;
        }
        
        var_7cbc22bb9e612dea = equipment_mp::getequipmentmaxammo( equipmentref );
        
        if ( prematchactive )
        {
            equipment_mp::setequipmentammo( equipmentref, var_7cbc22bb9e612dea, var_7cbc22bb9e612dea );
            continue;
        }
        
        if ( equipment_mp::isequipmentlethal( equipmentref ) && self.var_b4c45c2992c2e37c.stackprimary || equipment_mp::isequipmenttactical( equipmentref ) && self.var_b4c45c2992c2e37c.stacksecondary )
        {
            currentammo = equipment_mp::getequipmentammo( equipmentref );
            equipment_mp::setequipmentammo( equipmentref, int( min( currentammo + level.startingEquipmentCount, var_7cbc22bb9e612dea ) ), var_7cbc22bb9e612dea );
            
            if ( currentammo + level.startingEquipmentCount > var_7cbc22bb9e612dea )
            {
                spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
                itembundle = common_item::function_cf68ad18114498b2( equipmentref );
                item = common_item::function_61c2c0251e742ffd( itembundle, currentammo + level.startingEquipmentCount - var_7cbc22bb9e612dea, spawnoptions );
            }
            
            continue;
        }
        
        equipment_mp::setequipmentammo( equipmentref, level.startingEquipmentCount, var_7cbc22bb9e612dea );
    }
}

// Namespace br
// Params 1
// Checksum 0xe5b53ef8, Offset: 0x183d9
// Size: 0x25
function function_cb855b2ad040737d( loadoutchoice )
{
    var_b0349102295e411a = undefined;
    var_b0349102295e411a = class::preloadandqueueclass( loadoutchoice );
    return var_b0349102295e411a;
}

// Namespace br
// Params 0
// Checksum 0x58795375, Offset: 0x18407
// Size: 0x4b0
function function_d8d054ee4230fa94()
{
    savedloadout = spawnstruct();
    savedloadout.primaries = [];
    savedloadout.ammoclip = [];
    savedloadout.ammoclipleft = [];
    savedloadout.ammostock = [];
    savedloadout.offhands = [];
    savedloadout.equipslots = [];
    savedprimaries = [];
    allprimaries = self getweaponslistprimaries();
    
    foreach ( primary in allprimaries )
    {
        isfistweapon = weapon::isfistweapon( primary ) || primary.classname == "fist";
        
        if ( !weapon::ismeleeoverrideweapon( primary ) && !isfistweapon && !weapon::isgunlessweapon( primary ) && !weapon::isunderwaterweapon( primary ) && !weapon::isclimbweapon( primary ) )
        {
            savedprimaries[ savedprimaries.size ] = primary;
        }
    }
    
    foreach ( weaponobj in savedprimaries )
    {
        weaponname = getcompleteweaponname( weaponobj );
        savedloadout.ammoclip[ weaponname ] = weaponclipsize( weaponobj );
        savedloadout.ammostock[ weaponname ] = self getweaponammostock( weaponobj );
        
        if ( weapon::isakimbo( weaponobj ) )
        {
            savedloadout.ammoclipleft[ weaponname ] = self getweaponammoclip( weaponobj, "left" );
        }
        
        if ( getsubstr( weaponname, 0, 4 ) == "alt_" )
        {
            continue;
        }
        
        savedloadout.primaries[ savedloadout.primaries.size ] = weaponobj;
    }
    
    if ( isdefined( self.lastcacweaponobj ) && self.lastcacweaponobj != makeweapon( "none" ) )
    {
        foreach ( primary in savedloadout.primaries )
        {
            if ( self.lastcacweaponobj == primary )
            {
                savedloadout.current = self.lastcacweaponobj;
                break;
            }
        }
    }
    
    alloffhands = self getweaponslistoffhands();
    
    foreach ( offhandobj in alloffhands )
    {
        if ( offhandobj.basename == "bandage_br" )
        {
            continue;
        }
        
        offhandammo = self getweaponammoclip( offhandobj );
        
        if ( offhandammo <= 0 )
        {
            continue;
        }
        
        savedloadout.offhands[ savedloadout.offhands.size ] = offhandobj;
        offhandname = getcompleteweaponname( offhandobj );
        savedloadout.ammoclip[ offhandname ] = offhandammo;
    }
    
    foreach ( slot, equipref in self.equipment )
    {
        savedloadout.equipslots[ equipref ] = slot;
    }
    
    savedloadout.superref = undefined;
    
    if ( !level.var_31797ef307bfd722 && isdefined( self.super ) && !self.super.usepercent )
    {
        savedloadout.superref = supers_mp::getcurrentsuperref();
    }
    
    self.savedloadout = savedloadout;
}

// Namespace br
// Params 0
// Checksum 0x89b8380d, Offset: 0x188bf
// Size: 0x4ab
function playerloadoutrestore()
{
    self endon( #"disconnect" );
    self takeallweapons( 0, 1 );
    br_weapons::br_ammo_player_clear();
    self.equipment[ "primary" ] = undefined;
    self.equipment[ "secondary" ] = undefined;
    self.equipment[ "health" ] = undefined;
    self.equipment[ "super" ] = undefined;
    fists = level.defaultfist;
    
    if ( self.savedloadout.primaries.size < 2 )
    {
        self giveweapon( fists );
    }
    
    var_f174ed9cc33055ac = 0;
    
    foreach ( weaponobj in self.savedloadout.primaries )
    {
        if ( weapon::function_6b74ecd475e99b4( weaponobj ) )
        {
            self giveweapon( weaponobj );
            weapon::function_b4c9549dee5d0fc5( weaponobj );
            self assignweaponmeleeslot( weaponobj );
        }
        else
        {
            if ( weapon::isbackuppistol( weaponobj ) )
            {
                self giveweapon( weaponobj, 0, 0, 0, 1, 1 );
            }
            else
            {
                inventory_utility::_giveweapon( weaponobj );
                item_weapon::function_92b8514cdacab7f9( weaponobj );
            }
            
            if ( !var_f174ed9cc33055ac )
            {
                weaponname = getcompleteweaponname( weaponobj );
                self assignweaponprimaryslot( weaponname );
                inventory_utility::_switchtoweapon( weaponobj );
                var_f174ed9cc33055ac = 1;
            }
        }
        
        weapon::fixupplayerweapons( self, weaponobj );
    }
    
    foreach ( offhandobj in self.savedloadout.offhands )
    {
        equipref = equipment_mp::getequipmentreffromweapon( offhandobj );
        
        if ( !isdefined( equipref ) )
        {
            continue;
        }
        
        slot = self.savedloadout.equipslots[ equipref ];
        
        if ( !isdefined( slot ) )
        {
            continue;
        }
        
        equipment_mp::giveequipment( equipref, slot );
    }
    
    foreach ( weaponname, ammo in self.savedloadout.ammostock )
    {
        self setweaponammostock( weaponname, ammo );
        weaponobj = makeweapon( getweaponbasename( weaponname ) );
        item_ammo::function_46e5ccf39665fcf4( weaponobj, 0, 0, 0, ammo );
    }
    
    foreach ( weaponname, ammo in self.savedloadout.ammoclip )
    {
        self setweaponammoclip( weaponname, ammo );
    }
    
    foreach ( weaponname, ammo in self.savedloadout.ammoclipleft )
    {
        self setweaponammoclip( weaponname, ammo, "left" );
    }
    
    waitframe();
    var_51fb46d6c62615e2 = fists;
    
    if ( isdefined( self.savedloadout.current ) )
    {
        var_51fb46d6c62615e2 = self.savedloadout.current;
    }
    else if ( isdefined( self.savedloadout.primaries[ 0 ] ) )
    {
        var_51fb46d6c62615e2 = self.savedloadout.primaries[ 0 ];
    }
    
    self switchtoweaponimmediate( var_51fb46d6c62615e2 );
    
    if ( isdefined( self.savedloadout.superref ) )
    {
        item_super::function_ea946b46f6cd671f( self.savedloadout.superref );
    }
    
    teams::setupplayermodel();
    self setactionslot( 3, "altmode" );
    item_weapon::function_f9f12ddfa1766b72();
    self.savedloadout = undefined;
}

// Namespace br
// Params 0
// Checksum 0xa87b999e, Offset: 0x18d72
// Size: 0xf8
function function_b44403946558dddb()
{
    var_82cf28e831b9276f = 0;
    var_66ab612f7b0c0168 = 1;
    
    while ( var_66ab612f7b0c0168 && var_82cf28e831b9276f < level.var_9a6d992db0cf6e29 )
    {
        playersinkillcam = 0;
        
        foreach ( player in level.players )
        {
            if ( isplayer( player ) && player player::isinkillcam() )
            {
                playersinkillcam = 1;
                break;
            }
        }
        
        var_66ab612f7b0c0168 = playersinkillcam;
        
        if ( var_66ab612f7b0c0168 )
        {
            var_82cf28e831b9276f += getframeduration() / 1000;
            waitframe();
        }
    }
    
    if ( var_82cf28e831b9276f >= level.var_9a6d992db0cf6e29 )
    {
        brskipplayerkillcams();
        wait 1;
    }
}

// Namespace br
// Params 0
// Checksum 0xcdd5ccbf, Offset: 0x18e72
// Size: 0xa2
function brskipplayerkillcams()
{
    foreach ( player in level.players )
    {
        if ( isplayer( player ) && player player::isinkillcam() )
        {
            player notify( #"abort_killcam" );
            player.cancelkillcam = 1;
        }
    }
}

// Namespace br
// Params 1
// Checksum 0x2ec1912c, Offset: 0x18f1c
// Size: 0x5a
function brhandleinvulnerability( time )
{
    invulnerabilitytime = getdvarint( @"hash_eddaebb33871cf7d", 30 );
    
    if ( invulnerabilitytime > time )
    {
        invulnerabilitytime = time;
    }
    
    wait time - invulnerabilitytime;
    level.allowprematchdamage = 0;
    wait invulnerabilitytime / 2;
    brskipplayerkillcams();
    wait invulnerabilitytime / 2;
}

// Namespace br
// Params 1
// Checksum 0xf8ad1786, Offset: 0x18f7e
// Size: 0x1ea
function spawnclientbr( revivespawn )
{
    self endon( #"disconnect" );
    self.var_7f11590a9240bfb5 = undefined;
    
    if ( br_public::iswaitingtoentergulag( self ) )
    {
        self notify( #"attempted_spawn" );
        br_gulag::entergulag( self );
        self.waitingtospawn = 0;
        return;
    }
    
    if ( self.waitingtospawnamortize || br_public::isrespawningfromtoken( self ) || utility::callsharedfunc( #"gametype", #"hash_251cc1c137f65b9e", self ) )
    {
        self notify( #"attempted_spawn" );
        self.waitingtospawn = 0;
        return;
    }
    
    if ( !playerlogic::mayspawn() )
    {
        waitframe();
        self notify( #"attempted_spawn" );
        
        if ( utility::issharedfuncdefined( #"gametype", #"hash_58dc1430bbcfb053" ) )
        {
            utility::callsharedfunc( #"gametype", #"hash_58dc1430bbcfb053" );
        }
        else if ( level.infiltransistioning || level.snatchspawnalltoc130done || level.br_c130spawndone )
        {
            if ( isdefined( level.brlatespawnplayer ) )
            {
                self thread [[ level.brlatespawnplayer ]]();
            }
            
            return;
        }
        
        return;
    }
    
    if ( revivespawn )
    {
        level.snatchspawnalltoc130done = 0;
    }
    
    if ( level.infilcompleted && !revivespawn )
    {
        if ( isdefined( level.var_7edf012adda42ec5 ) )
        {
            self thread [[ level.var_7edf012adda42ec5 ]]();
        }
        
        return;
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_58dc1430bbcfb053" ) )
    {
        utility::callsharedfunc( #"gametype", #"hash_58dc1430bbcfb053" );
    }
    else if ( level.infiltransistioning || level.snatchspawnalltoc130done || level.br_c130spawndone )
    {
        if ( isdefined( level.brlatespawnplayer ) )
        {
            self thread [[ level.brlatespawnplayer ]]();
        }
        
        return;
    }
    
    function_82887b14ec3a0b5f( revivespawn );
}

// Namespace br
// Params 1
// Checksum 0x8a07a077, Offset: 0x19170
// Size: 0x230
function function_82887b14ec3a0b5f( revivespawn )
{
    self endon( #"disconnect" );
    
    if ( !level.br_allowloadout )
    {
        if ( isdefined( level.bypassclasschoicefunc ) )
        {
            self.class = self [[ level.bypassclasschoicefunc ]]();
        }
        else
        {
            self.class = pickclassbr();
        }
    }
    
    if ( getdvarint( @"hash_8fd5e2fbd99396a4", 0 ) == 1 )
    {
        thread function_b6d5e1addb3751c8();
    }
    
    println( "<dev string:x401>" );
    prespawndvarvalue = getdvarint( @"hash_c04bdbe0595bf776", 1 );
    prespawn = prespawndvarvalue && usedropspawn() && !isbot( self );
    
    if ( prespawndvarvalue > 1 )
    {
        prespawn = prespawn && !self.hasspawned;
    }
    
    if ( prespawn )
    {
        self.prespawnspawn = getspawnpoint( prespawn );
    }
    
    if ( !level.br_allowloadout || level.br_allowloadoutonlyinprelobby )
    {
        self.var_8cd4fafa67a4f362 = 1;
    }
    
    playerlogic::waitandspawnclient( revivespawn );
    self freezecontrols( 1 );
    
    if ( usedropspawn() )
    {
        thread prematchdeployparachute();
    }
    
    waitframe();
    
    if ( game_utility::getgametype() != "dmz" )
    {
        self skydive_setdeploymentstatus( 0 );
        self skydive_setbasejumpingstatus( 0 );
    }
    
    waitforstreaming = !self isplayerheadless();
    teams::getcustomization();
    var_2e1f073ff5b26205 = gettime();
    
    if ( waitforstreaming )
    {
        while ( isalive( self ) && isdefined( self.operatorcustomization.skinref ) && isdefined( self.weaponlist ) && !self function_16495e02aff8ee53( self.operatorcustomization.skinref ) && !self hasloadedviewweapons( self.weaponlist ) )
        {
            if ( var_2e1f073ff5b26205 + 3000 < gettime() )
            {
                break;
            }
            
            waitframe();
        }
        
        extrawaittime = getdvarfloat( @"hash_3e0e124917f2104b", 1 );
        
        if ( extrawaittime > 0 )
        {
            wait extrawaittime;
        }
    }
    
    self notify( #"hash_36e455a1fbf78b10" );
    self.waitingtospawn = 0;
    self freezecontrols( 0 );
}

// Namespace br
// Params 0
// Checksum 0x80eab35e, Offset: 0x193a8
// Size: 0x2a
function playerexecutionsdisable()
{
    if ( execution::hasexecution() )
    {
        self.savedexecutionref = self.executionref;
        execution::_clearexecution();
        self disableexecutionattack();
    }
}

// Namespace br
// Params 0
// Checksum 0xbb24958b, Offset: 0x193da
// Size: 0x2f
function playerexecutionsenable()
{
    if ( isdefined( self.savedexecutionref ) )
    {
        execution::_giveexecution( self.savedexecutionref );
        self enableexecutionattack();
        self.savedexecutionref = undefined;
    }
}

// Namespace br
// Params 0
// Checksum 0xc6350d32, Offset: 0x19411
// Size: 0x13b
function watchforbrsquadleadershift()
{
    level endon( #"game_ended" );
    self notify( #"hash_cc0a4fb4c64034eb" );
    self endon( #"hash_cc0a4fb4c64034eb" );
    player = self;
    teamname = player.team;
    squadindex = player.sessionsquadid;
    
    while ( true )
    {
        msg = "";
        
        if ( game_utility::getgametype() == "dmz" || game_utility::getgametype() == "plunder" || game_utility::getgametype() == "sandbox" )
        {
            msg = player utility::waittill_any_return_no_endon_death( "disconnect", "br_pass_squad_leader" );
        }
        else
        {
            msg = player utility::waittill_any_return_no_endon_death( "death", "disconnect", "remove_from_alive_count", "br_pass_squad_leader" );
        }
        
        if ( msg == "br_pass_squad_leader" )
        {
            if ( !teamhasfreshsquadleadercandidate( teamname ) )
            {
                player playlocalsound( "fly_pickup_deny" );
                continue;
            }
        }
        
        if ( msg != "disconnect" )
        {
            if ( !flags::gameflag( "prematch_done" ) )
            {
                continue;
            }
            
            if ( !player.br_infilstarted )
            {
                continue;
            }
        }
        
        if ( player abandonbrsquadleader( teamname, squadindex ) )
        {
            return;
        }
    }
}

// Namespace br
// Params 1
// Checksum 0xa6d10ac8, Offset: 0x19554
// Size: 0x46
function function_6b4dda86ffb422cf( squadindex )
{
    player = self;
    newextrainfo = player.game_extrainfo & 65528;
    newextrainfo |= squadindex;
    player.game_extrainfo = newextrainfo;
}

// Namespace br
// Params 1
// Checksum 0x9d5eb6fb, Offset: 0x195a2
// Size: 0x8b
function setplayerbrsquadleader( isleader )
{
    player = self;
    
    if ( isleader == player br_public::isplayerbrsquadleader() )
    {
        return;
    }
    
    player.isbrsquadleader = isleader;
    
    if ( isleader )
    {
        player.game_extrainfo |= 16384;
        player thread watchforbrsquadleadershift();
        return;
    }
    
    player notify( #"hash_cc0a4fb4c64034eb" );
    player.game_extrainfo &= ~16384;
}

// Namespace br
// Params 2
// Checksum 0x65a5904f, Offset: 0x19635
// Size: 0x1b0
function abandonbrsquadleader( teamname, squadindex )
{
    player = self;
    
    if ( !isdefined( teamname ) )
    {
        teamname = player.team;
    }
    
    if ( !isdefined( squadindex ) )
    {
        squadindex = player.sessionsquadid;
    }
    
    if ( isdefined( player ) && !player br_public::isplayerbrsquadleader() )
    {
        assertmsg( "<dev string:x447>" );
        return 0;
    }
    
    if ( isdefined( player ) )
    {
        player.haspassedsquadleader = 1;
    }
    
    teammembers = teams::function_d032b36d01bbbab3( teamname, squadindex );
    bestplayerscore = 0;
    bestsquadleader = undefined;
    
    foreach ( teammember in teammembers )
    {
        teammemberscore = playerbrsquadleaderscore( teammember );
        
        if ( teammemberscore > bestplayerscore )
        {
            bestplayerscore = teammemberscore;
            bestsquadleader = teammember;
        }
    }
    
    success = 0;
    
    if ( isdefined( bestsquadleader ) )
    {
        if ( isdefined( player ) )
        {
            player setplayerbrsquadleader( 0 );
        }
        
        bestsquadleader setplayerbrsquadleader( 1 );
        success = 1;
        
        if ( !level.br_c130spawndone && game_utility::getgametype() == "br" )
        {
            level br_public::brleaderdialogplayer( "deploy_squad_leader", bestsquadleader, 1, 0, undefined, undefined, level.brgametype.dialogprefix );
        }
    }
    
    updatesquadleaderpassstateforteam( teamname, squadindex );
    return success;
}

// Namespace br
// Params 2
// Checksum 0xe449edec, Offset: 0x197ee
// Size: 0xfb
function teamhasfreshsquadleadercandidate( teamname, squadindex )
{
    teammembers = teams::function_d032b36d01bbbab3( teamname, squadindex );
    var_a1bac077a7782ba0 = 0;
    
    foreach ( teammember in teammembers )
    {
        if ( !isdefined( teammember ) || teammember br_public::isplayerbrsquadleader() )
        {
            continue;
        }
        
        if ( !isalive( teammember ) )
        {
            continue;
        }
        
        if ( teammember iscodcaster() || teammember isspectatingplayer() )
        {
            continue;
        }
        
        if ( teammember br_public::isplayeringulag() )
        {
            continue;
        }
        
        if ( !teammember.haspassedsquadleader )
        {
            var_a1bac077a7782ba0 = 1;
            break;
        }
    }
    
    return var_a1bac077a7782ba0;
}

// Namespace br
// Params 2
// Checksum 0xfdcb5308, Offset: 0x198f2
// Size: 0xb2
function updatesquadleaderpassstateforteam( teamname, squadindex )
{
    teammembers = teams::function_d032b36d01bbbab3( teamname, squadindex );
    var_a1bac077a7782ba0 = teamhasfreshsquadleadercandidate( teamname, squadindex );
    
    foreach ( teammember in teammembers )
    {
        teammember setclientomnvar( "ui_br_squad_leader_can_pass", var_a1bac077a7782ba0 );
    }
}

// Namespace br
// Params 1
// Checksum 0x1d3b561e, Offset: 0x199ac
// Size: 0x6a
function playerbrsquadleaderscore( player )
{
    if ( player br_public::isplayerbrsquadleader() || player iscodcaster() || player isspectatingplayer() || !isalive( player ) )
    {
        return 0;
    }
    
    if ( player br_public::isplayeringulag() )
    {
        return 1;
    }
    
    if ( player.inlaststand )
    {
        return 2;
    }
    
    if ( player.haspassedsquadleader )
    {
        return 3;
    }
    
    return 4;
}

// Namespace br
// Params 5
// Checksum 0x2f16658f, Offset: 0x19a1f
// Size: 0xd0
function teamsplashbr( splash, owner, team, optionalnumber, splashlistoverride )
{
    teamplayers = teams::getteamdata( team, "players" );
    
    foreach ( player in teamplayers )
    {
        if ( !player.gulag )
        {
            player thread hud_message::showsplash( splash, optionalnumber, owner, undefined, undefined, splashlistoverride );
        }
    }
}

// Namespace br
// Params 0
// Checksum 0x7215cdbd, Offset: 0x19af7
// Size: 0xbe
function endsuperdisableweaponbr()
{
    var_6817f5af1b44cc2b = "super_delay_mp";
    currentsuper = supers_mp::getcurrentsuper();
    
    if ( isdefined( currentsuper ) )
    {
        superweapon = currentsuper.staticdata.weapon;
        ammo = 0;
        
        if ( supers_mp::function_31f00fe6e0334d03() )
        {
            ammo = supers_mp::issuperready() ? 1 : 0;
        }
        else
        {
            ammo = self.var_33129007db246c94 ? 1 : 0;
        }
        
        inventory_utility::_giveweapon( superweapon );
        self setweaponammoclip( superweapon, ammo );
        self assignweaponoffhandspecial( superweapon );
        inventory_utility::_takeweapon( var_6817f5af1b44cc2b );
    }
    
    self notify( #"hash_9d454d284ead1775" );
    self.var_7aeb6bd11bce3a42 = 1;
}

// Namespace br
// Params 0
// Checksum 0xfeaac59d, Offset: 0x19bbd
// Size: 0x38
function getsuperweapondisabledammobr()
{
    ammo = equipment_mp::getequipmentslotammo( "super" );
    
    if ( !supers_mp::issuperdisabled() )
    {
        return ammo;
    }
    
    if ( self.var_33129007db246c94 )
    {
        ammo = 1;
    }
    
    return ammo;
}

// Namespace br
// Params 2
// Checksum 0x5a4d3dbb, Offset: 0x19bfe
// Size: 0x125, Type: bool
function onsupportboxusedbyplayer( player, spawnoptions )
{
    var_4c48fad50fa1fc28 = [];
    allweaps = player getweaponslistprimaries();
    
    if ( player killstreak::isjuggernaut() )
    {
        if ( !isdefined( allweaps ) || allweaps.size == 0 )
        {
            minigun = player getcurrentweapon();
            var_83a8675f9e45e80d = player getcurrentweaponclipammo();
            var_6021453cd8e527b4 = weaponclipsize( minigun );
            
            if ( var_83a8675f9e45e80d < var_6021453cd8e527b4 )
            {
                player setweaponammoclip( minigun, var_6021453cd8e527b4 );
                player damagefeedback::hudicontype( "br_ammo" );
                player playlocalsound( "fly_pickup_ammo_gen" );
                return true;
            }
        }
    }
    
    var_4c48fad50fa1fc28 = function_eda453b0a2202cbd( player, spawnoptions, var_4c48fad50fa1fc28 );
    var_4c48fad50fa1fc28 = function_4568d30da6d65aee( player, spawnoptions, var_4c48fad50fa1fc28 );
    
    if ( utility::issharedfuncdefined( #"game", #"showStockLootFeed" ) && var_4c48fad50fa1fc28.size > 0 )
    {
        level thread [[ utility::getsharedfunc( #"game", #"showStockLootFeed" ) ]]( player, var_4c48fad50fa1fc28 );
    }
    
    player damagefeedback::hudicontype( "ammobox" );
    support_box::supportbox_playusesound( player );
    thread support_box::supportbox_onplayeruseanim();
    return true;
}

// Namespace br
// Params 3
// Checksum 0x9ab6a210, Offset: 0x19d2c
// Size: 0x2c
function function_eda453b0a2202cbd( player, spawnoptions, var_4c48fad50fa1fc28 )
{
    var_4c48fad50fa1fc28 = function_fff6b9d270057a67( player, spawnoptions, var_4c48fad50fa1fc28 );
    return var_4c48fad50fa1fc28;
}

// Namespace br
// Params 3
// Checksum 0x8ee9d3cb, Offset: 0x19d61
// Size: 0xac
function function_4568d30da6d65aee( player, spawnoptions, var_4c48fad50fa1fc28 )
{
    if ( isdefined( player.equipment[ "primary" ] ) )
    {
        var_4c48fad50fa1fc28 = function_10c95caf0aa2348f( player, self.bundle.var_f99cea43f70c6b58, player.equipment[ "primary" ], spawnoptions, var_4c48fad50fa1fc28 );
    }
    
    if ( isdefined( player.equipment[ "secondary" ] ) )
    {
        var_4c48fad50fa1fc28 = function_10c95caf0aa2348f( player, self.bundle.var_e1e79753db03d114, player.equipment[ "secondary" ], spawnoptions, var_4c48fad50fa1fc28 );
    }
    
    return var_4c48fad50fa1fc28;
}

// Namespace br
// Params 5
// Checksum 0xc9350eeb, Offset: 0x19e16
// Size: 0x19d
function function_10c95caf0aa2348f( player, var_43985a7b592b1702, equipmentref, spawnoptions, var_4c48fad50fa1fc28 )
{
    var_bdcc14c8fd506325 = player equipment_mp::getequipmentammo( equipmentref );
    var_3177082b0a783798 = player equipment_mp::getequipmentmaxammo( equipmentref );
    
    if ( !isdefined( itembundle ) )
    {
        itembundle = common_item::function_cf68ad18114498b2( equipmentref );
    }
    
    var_462b8fae81401057 = var_bdcc14c8fd506325;
    
    if ( itembundle.var_2b0a27d4be7d298b )
    {
        var_7e81aabe6ca3a45f = equipment_mp::getcallback( equipmentref, "equipmentDurabilityGet" );
        
        if ( isdefined( var_7e81aabe6ca3a45f ) )
        {
            var_462b8fae81401057 = player [[ var_7e81aabe6ca3a45f ]]();
        }
        else
        {
            var_462b8fae81401057 = common_item::function_ea3b3088d82fd357( itembundle );
        }
    }
    
    var_43985a7b592b1702 = var_3177082b0a783798;
    
    if ( isdefined( self.equipmentref ) )
    {
        var_43985a7b592b1702 = support_box::function_59fd58aae407eb8e( equipmentref, var_43985a7b592b1702, self );
    }
    
    amountrefilled = minint( var_43985a7b592b1702, var_3177082b0a783798 - var_bdcc14c8fd506325 );
    player equipment_mp::incrementequipmentammo( equipmentref, amountrefilled );
    
    if ( self.bundle.var_d6fc5dd97236d1e3 && isdefined( spawnoptions ) && flags::gameflag( "prematch_done" ) )
    {
        var_9afaa0c09341a192 = var_43985a7b592b1702 - amountrefilled;
        
        if ( itembundle.var_2b0a27d4be7d298b )
        {
            var_9afaa0c09341a192 = var_462b8fae81401057;
        }
        
        if ( var_9afaa0c09341a192 > 0 )
        {
            common_item::function_325e28c0fb65c36a( equipmentref, var_9afaa0c09341a192, spawnoptions );
        }
    }
    
    if ( amountrefilled > 0 )
    {
        scriptablename = common_item::function_70d4affb770e8103( equipmentref );
        var_4c48fad50fa1fc28[ scriptablename ] = spawnstruct();
        var_4c48fad50fa1fc28[ scriptablename ].ref = equipmentref;
        var_4c48fad50fa1fc28[ scriptablename ].count = int( amountrefilled );
    }
    
    return var_4c48fad50fa1fc28;
}

// Namespace br
// Params 3
// Checksum 0x72aa7379, Offset: 0x19fbc
// Size: 0x42d
function function_fff6b9d270057a67( player, spawnoptions, var_4c48fad50fa1fc28 )
{
    var_2840504c67b99ce5 = self.bundle.var_92a5bdc95b2847d4 && isdefined( level.var_d157a47d96f8c663 );
    givemaxammo = self.bundle.var_b54bc0d3a2cf15e;
    clipcount = self.bundle.var_42677e2a28d3d899;
    var_96f5b3848f40bff1 = arraycopy( level.var_d157a47d96f8c663 );
    
    if ( self.bundle.var_af2c7b4a2b0518b5 && level.var_e9d733627b29a6 )
    {
        itembundle = common_item::function_cf68ad18114498b2( level.var_e9d733627b29a6 );
        item = common_item::function_77600f92048df72d( itembundle, item_ammo::function_bc44ebafb97454a0( itembundle ) * ( clipcount ?? 1 ) );
        player common_item::function_41751a7f86839f01( item, undefined, 1, undefined, undefined, spawnoptions );
        return;
    }
    
    if ( !var_2840504c67b99ce5 )
    {
        foreach ( ammotype, ammocount in level.var_d157a47d96f8c663 )
        {
            ammoequipped[ ammotype ] = 0;
        }
        
        var_a58bad85f47a2be2 = player getweaponslistprimaries();
        
        foreach ( weap in var_a58bad85f47a2be2 )
        {
            if ( !item_weapon::function_46d840bd6268e2ce( weap ) )
            {
                continue;
            }
            
            ammotype = item_ammo::function_b162feeed34a4640( weap );
            
            if ( isdefined( ammotype ) )
            {
                ammoequipped[ ammotype ] = 1;
            }
        }
        
        foreach ( ammotype, var_c1611a65af8736a3 in ammoequipped )
        {
            if ( !var_c1611a65af8736a3 )
            {
                var_96f5b3848f40bff1[ ammotype ] = undefined;
            }
        }
    }
    
    foreach ( ammotype, ammocount in var_96f5b3848f40bff1 )
    {
        itembundle = common_item::function_80af1e9daffacc7d( ammotype );
        maxammoamount = player common_item::function_38334193bd9b5956( itembundle );
        count = givemaxammo ? maxammoamount : ammocount * clipcount;
        item = { #count:common_item::function_598dd39282efb544( count ), #type:ammotype };
        lootid = common_item::function_779887309ec71dfe( itembundle );
        var_5b42a0d4f4232af1 = player common_inventory::function_99741e85ee9c3d18( lootid );
        var_43985a7b592b1702 = maxammoamount;
        amountrefilled = min( maxammoamount - var_5b42a0d4f4232af1, var_43985a7b592b1702 );
        item.count = int( amountrefilled );
        player common_item::function_96119bed8ab4c5d9( item, 0, 1 );
        
        if ( self.bundle.var_fe85802878d2d43b && isdefined( spawnoptions ) && flags::gameflag( "prematch_done" ) )
        {
            var_9afaa0c09341a192 = var_43985a7b592b1702 - amountrefilled;
            
            if ( var_9afaa0c09341a192 > 0 )
            {
                common_item::function_325e28c0fb65c36a( itembundle.ref, var_9afaa0c09341a192, spawnoptions );
            }
        }
        
        if ( amountrefilled > 0 )
        {
            var_4c48fad50fa1fc28[ ammotype ] = item;
            var_4c48fad50fa1fc28[ ammotype ].ref = ammotype;
            var_4c48fad50fa1fc28[ ammotype ].count = int( amountrefilled );
        }
    }
    
    return var_4c48fad50fa1fc28;
}

// Namespace br
// Params 2
// Checksum 0xf5020500, Offset: 0x1a3f2
// Size: 0xe1, Type: bool
function onarmorboxusedbyplayer( player, spawnoptions )
{
    var_a01a56cb216e142d = player armor::function_db9ebf086f67fe92();
    armorplatescriptable = "brloot_armor_plate";
    item = { #count:common_item::function_598dd39282efb544( var_a01a56cb216e142d ), #type:armorplatescriptable };
    var_cb4215a3f5c0f23c = player common_item::function_2b5e2ff57d5f392( item, 0, 1 );
    player damagefeedback::hudicontype( "br_armor" );
    
    if ( self.bundle.var_e6a4f1e7b623d8b0 && isdefined( spawnoptions ) && flags::gameflag( "prematch_done" ) )
    {
        var_9afaa0c09341a192 = var_a01a56cb216e142d - var_cb4215a3f5c0f23c;
        
        if ( var_9afaa0c09341a192 > 0 )
        {
            common_item::items_spawnitemfromscriptable( armorplatescriptable, var_9afaa0c09341a192, spawnoptions );
        }
    }
    
    support_box::supportbox_playusesound( player );
    thread support_box::supportbox_onplayeruseanim();
    return true;
}

// Namespace br
// Params 1
// Checksum 0x157b646b, Offset: 0x1a4dc
// Size: 0xe, Type: bool
function function_c70c786e914a4337( player )
{
    return true;
}

// Namespace br
// Params 1
// Checksum 0x947bb598, Offset: 0x1a4f3
// Size: 0xe8, Type: bool
function function_a1a56d352c70c610( player )
{
    selfrevivescriptable = "brloot_self_revive";
    item = { #count:1, #type:selfrevivescriptable };
    result = common_item::function_2b5e2ff57d5f392( item, 0, 0 );
    
    if ( result )
    {
        player damagefeedback::hudicontype( "br_armor" );
        method = challenges::function_a23641f33e985edb( 0, 0 );
        method = challenges::function_a23641f33e985edb( method, 2 );
        lootid = loot::function_d3e3bcaea591a6a2( selfrevivescriptable );
        challenges::reportlootitemevent( player, lootid, undefined, method, 1 );
    }
    else
    {
        droppickup = spawnstruct();
        droppickup.scriptablename = selfrevivescriptable;
        droppickup.count = 1;
        lootid = loot::function_d3e3bcaea591a6a2( selfrevivescriptable );
        player br_default_inventory::additemtobackpack( lootid, droppickup );
    }
    
    return true;
}

// Namespace br
// Params 1
// Checksum 0x879c1a06, Offset: 0x1a5e4
// Size: 0x1db, Type: bool
function function_4161f6bfb35eb94e( player )
{
    altitemlist = tolower( getdvar( hashcat( @"hash_af9284300060dcb3", "" ) ) );
    
    if ( !isdefined( altitemlist ) || altitemlist == "" )
    {
        item = { #count:1, #type:"brloot_plate_carrier_2" };
        result = common_item::function_2b5e2ff57d5f392( item, 0, 1 );
    }
    else
    {
        itemlist = strtok( altitemlist, " " );
        
        foreach ( item in itemlist )
        {
            if ( !isdefined( loot::function_d3e3bcaea591a6a2( item ) ) )
            {
                assertmsg( "<dev string:x491>" + item + "<dev string:x4b3>" );
                continue;
            }
            
            count = 1;
            
            switch ( item )
            {
                case #"hash_755a9bafcd63b343":
                    count = getdvarint( @"hash_e2706d365ad75b50", 3 );
                    break;
                case #"hash_1cd9ffa488237604":
                case #"hash_57e5eda4a702c559":
                case #"hash_672892a4af1e94cc":
                case #"hash_f1734c15f85881ca":
                    count = getdvarint( @"hash_5970233d0ac3eb9e", 30 );
                    break;
            }
            
            item = { #count:count, #type:item };
            result = common_item::function_2b5e2ff57d5f392( item, 0, 1 );
        }
    }
    
    player damagefeedback::hudicontype( "br_ammo" );
    support_box::supportbox_playusesound( player );
    thread support_box::supportbox_onplayeruseanim();
    return true;
}

// Namespace br
// Params 1
// Checksum 0x65c8726e, Offset: 0x1a7c8
// Size: 0x15
function airdrop_registercrateforcleanup( crate )
{
    registercrateforcleanup( crate );
}

// Namespace br
// Params 1
// Checksum 0x298b8148, Offset: 0x1a7e5
// Size: 0x15
function function_a006ede6fbe57ff8( crate )
{
    unregistercrateforcleanup( crate );
}

// Namespace br
// Params 1
// Checksum 0xfb1656a1, Offset: 0x1a802
// Size: 0x15
function airdrop_bronloadoutcratedestroyed( immediate )
{
    bronloadoutcratedestroyed( immediate );
}

// Namespace br
// Params 2
// Checksum 0x60ec0841, Offset: 0x1a81f
// Size: 0x61
function onnewequipmentpickup( player, equipmentref )
{
    scriptablename = common_item::function_70d4affb770e8103( equipmentref );
    item = { #fromground:1, #count:1, #type:scriptablename };
    player common_item::function_2b5e2ff57d5f392( item, 0, 0 );
}

// Namespace br
// Params 2
// Checksum 0xe53fc999, Offset: 0x1a888
// Size: 0xfc
function ongrenadeused( weaponname, grenade )
{
    weapon = utility::function_64003742d8f5c781( weaponname );
    
    switch ( weapon.basenamehash )
    {
        case %"iw8_fulton_bag_mp":
        case %"sat_fulton_bag_wz":
            thread fulton::fulton_used( grenade );
            break;
        case %"rock_mp":
        case %"rew_rock":
        case %"sat_rock_wz":
            thread br_gulag::rock_used( grenade );
            break;
        case %"balloon_extract_mp":
            thread balloon_extract::function_c6139d2fb3b87922( grenade );
            break;
        default:
            utility::callsharedfunc( #"gametype", #"ongrenadeused", weaponname, grenade );
            break;
    }
    
    if ( weaponname == "rock_mp" && self.var_7f11590a9240bfb5 )
    {
        grenade delete();
        self.var_7f11590a9240bfb5 = undefined;
    }
}

// Namespace br
// Params 0
// Checksum 0x751ed97c, Offset: 0x1a98c
// Size: 0x80
function playershouldrespawn()
{
    if ( utility::issharedfuncdefined( #"gametype", #"playershouldrespawn" ) )
    {
        return utility::callsharedfunc( #"gametype", #"playershouldrespawn" );
    }
    
    if ( !level.br_prematchstarted )
    {
        return 1;
    }
    
    if ( br_public::iswaitingtoentergulag( self ) )
    {
        return 1;
    }
    
    if ( br_public::isrespawningfromtoken( self ) && !( self.var_ad882e8f12cd3d2a > 0 ) )
    {
        return 1;
    }
    
    if ( self.aetherisland )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br
// Params 2
// Checksum 0xda3f2881, Offset: 0x1aa15
// Size: 0x30f
function brplayerkilledspawn( deathdata, finaldeath )
{
    victim = deathdata.victim;
    
    if ( isplayer( victim ) )
    {
        victim damage::resetplayervariables();
        victim damage::resetplayeromnvarsonspawn();
        victim br_public::updatebrscoreboardstat( "hasArmorSatchel", 0 );
        
        if ( isdefined( victim.var_296ecaac501ba30d ) )
        {
            victim val::group_reset( victim.var_296ecaac501ba30d );
        }
    }
    
    victim notify( #"hash_bf9e476bbaabf508" );
    result = utility::callsharedfunc( #"gametype", #"playerkilledspawn", deathdata, finaldeath );
    
    if ( isdefined( result ) )
    {
        return result;
    }
    else if ( game_utility::getgametype() == "plunder" || game_utility::getgametype() == "kingslayer" || game_utility::getgametype() == "soc" || game_utility::getgametype() == "codmas_clash" )
    {
        if ( getdvarint( @"hash_fe3afd6ead4aa523", 1 ) == 1 )
        {
            if ( isdefined( self.c130 ) )
            {
                return 1;
            }
            
            if ( !flags::gameflag( "prematch_done" ) )
            {
                return 0;
            }
            
            if ( deathdata.victim.hasrespawntoken || level.useautorespawn )
            {
                if ( br_public::function_379fb7b09f4ef13e() )
                {
                    if ( isbot( deathdata.victim ) )
                    {
                        return 1;
                    }
                }
                
                deathdata.victim thread br_spawnrespawn::plunderplayerrespawn();
                teamcount = teams::getteamdata( deathdata.victim.team, "teamCount" );
                
                if ( teamcount > 1 && !br_gametypes::isfeaturedisabled( #"spectateondeath" ) )
                {
                    deathdata.victim thread br_spectate::spawnspectator( deathdata, finaldeath, 1 );
                }
                
                return 1;
            }
        }
        else
        {
            if ( !flags::gameflag( "prematch_done" ) )
            {
                return 0;
            }
            
            if ( deathdata.victim.hasrespawntoken || level.useautorespawn )
            {
                if ( br_public::function_379fb7b09f4ef13e() )
                {
                    if ( isbot( deathdata.victim ) )
                    {
                        return 1;
                    }
                }
                else if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    deathdata.victim thread playerlogic::respawn_asspectator( deathdata.victim.origin + ( 0, 0, 60 ), deathdata.victim.angles );
                }
                
                deathdata.victim thread br_spawnrespawn::plunderplayerrespawn();
                return 1;
            }
        }
    }
    else if ( !playershouldrespawn() )
    {
        if ( !damage::playershoulddofauxdeath( 0 ) && !br_gametypes::isfeaturedisabled( #"spectateondeath" ) )
        {
            deathdata.victim thread br_spectate::spawnspectator( deathdata, finaldeath );
        }
        else if ( level.var_b05cefe0c59dde7f )
        {
            self.br_spectatorinitialized = 1;
            self notify( #"br_spectatorInitialized" );
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace br
// Params 1
// Checksum 0x2de66f59, Offset: 0x1ad2d
// Size: 0xc0
function brmayconsiderplayerdead( player )
{
    result = utility::callsharedfunc( #"gametype", #"mayconsiderplayerdead", player );
    
    if ( isdefined( result ) )
    {
        return result;
    }
    
    isprematchdone = flags::gameflag( "prematch_done" );
    
    if ( isprematchdone && utility::callsharedfunc( #"teamassim", #"isenabled" ) )
    {
        utility::callsharedfunc( #"teamassim", #"disableplayer", player, "player_dead" );
    }
    
    var_68d761bd2e9f9f28 = player br_gulag::trygulagspawn();
    
    if ( isprematchdone && !var_68d761bd2e9f9f28 )
    {
        br_utility::markplayeraseliminated( player, "brMayConsiderPlayerDead" );
    }
    
    return !var_68d761bd2e9f9f28;
}

// Namespace br
// Params 0
// Checksum 0x83486946, Offset: 0x1adf6
// Size: 0x73
function monitorweaponswitchbr()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    for ( lastweaponchangetime = gettime(); true ; lastweaponchangetime = newtime )
    {
        self waittill( #"weapon_change" );
        newtime = gettime();
        
        if ( newtime - lastweaponchangetime >= 3000 )
        {
            awardtime = newtime - lastweaponchangetime;
            thread giveweaponxpfromtimebr( awardtime );
        }
    }
}

// Namespace br
// Params 0
// Checksum 0x786bb7aa, Offset: 0x1ae71
// Size: 0x10e
function announceplayercountlandmarks()
{
    f_threshold = getdvarfloat( @"hash_7383409df4ea8bd2", 0.6 );
    
    if ( !f_threshold )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level waittill( #"prematch_started" );
    
    if ( getdvarint( @"hash_d9f5b4d05943b70c", 0 ) == 1 )
    {
        level function_5bd92764a4fe95b1( 50, f_threshold );
        level function_5bd92764a4fe95b1( 25, f_threshold );
        level function_5bd92764a4fe95b1( 10, f_threshold );
        level function_5bd92764a4fe95b1( 5, f_threshold );
        return;
    }
    
    if ( level.var_a151dfa60c97bfc7 )
    {
        level function_b4b3eadfb9952ad2( 50, f_threshold );
        level function_b4b3eadfb9952ad2( 25, f_threshold );
        level function_b4b3eadfb9952ad2( 10, f_threshold );
        level function_b4b3eadfb9952ad2( 5, f_threshold );
        level function_b4b3eadfb9952ad2( 3, f_threshold );
        level function_b4b3eadfb9952ad2( 2, f_threshold );
        return;
    }
    
    level playersleftloop( 50, f_threshold );
    level playersleftloop( 25, f_threshold );
    level playersleftloop( 10, f_threshold );
    level playersleftloop( 5, f_threshold );
}

// Namespace br
// Params 2
// Checksum 0x8d21cc11, Offset: 0x1af87
// Size: 0x146
function playersleftloop( numplayers, f_threshold )
{
    if ( level.brgametype.var_fdfb65e9b9a5f91b )
    {
        return;
    }
    
    if ( getdvarint( @"party_maxplayers", 20 ) * f_threshold < numplayers )
    {
        return;
    }
    
    level endon( #"game_ended" );
    playersleft = getbrplayersnoteliminated();
    var_eab95be35247f31 = game_utility::getgametype() == "resurgence" && level.brgametype.issolos;
    
    while ( playersleft.size > numplayers )
    {
        level utility::waittill_any( "br_player_eliminated", "players_remaining_changed" );
        playersleft = getbrplayersnoteliminated();
        
        if ( playersleft.size <= numplayers )
        {
            var_79c7a029988a3f16 = !level.usegulag || level.gulag.shutdown;
            
            if ( var_eab95be35247f31 || var_79c7a029988a3f16 )
            {
                var_d2e823e8dea69430 = getdvarint( @"hash_2bd10bf6d780fed0", 0 ) ? undefined : function_aa0fbbd622092c4e();
                br_public::brleaderdialog( "top_" + numplayers, 0, var_d2e823e8dea69430, 1, undefined, undefined, level.brgametype.dialogprefix );
            }
            
            break;
        }
    }
}

// Namespace br
// Params 2
// Checksum 0xd00e7783, Offset: 0x1b0d5
// Size: 0x146
function function_b4b3eadfb9952ad2( numsquads, f_threshold )
{
    if ( level.brgametype.var_fdfb65e9b9a5f91b )
    {
        return;
    }
    
    if ( getdvarint( @"party_maxplayers", 20 ) * f_threshold < numsquads )
    {
        return;
    }
    
    level endon( #"game_ended" );
    squadsleft = function_d126c907c5dad4fe();
    var_eab95be35247f31 = game_utility::getgametype() == "resurgence" && level.brgametype.issolos;
    
    while ( squadsleft.size > numsquads )
    {
        level utility::waittill_any( "br_player_eliminated", "players_remaining_changed" );
        squadsleft = function_d126c907c5dad4fe();
        
        if ( squadsleft.size <= numsquads )
        {
            var_79c7a029988a3f16 = !level.usegulag || level.gulag.shutdown;
            
            if ( var_eab95be35247f31 || var_79c7a029988a3f16 )
            {
                var_d2e823e8dea69430 = getdvarint( @"hash_2bd10bf6d780fed0", 0 ) ? undefined : function_aa0fbbd622092c4e();
                br_public::brleaderdialog( "top_" + numsquads, 0, var_d2e823e8dea69430, 1, undefined, undefined, level.brgametype.dialogprefix );
            }
            
            break;
        }
    }
}

// Namespace br
// Params 2
// Checksum 0xbd274876, Offset: 0x1b223
// Size: 0x291
function function_5bd92764a4fe95b1( numplayers, f_threshold )
{
    if ( getdvarint( @"party_maxplayers", 20 ) * f_threshold < numplayers )
    {
        return;
    }
    
    level endon( #"game_ended" );
    playersleft = getbrplayersnoteliminated();
    var_eab95be35247f31 = game_utility::getgametype() == "resurgence" && level.brgametype.issolos;
    var_cf339568f0cf82d5 = [];
    activeteams = [];
    
    for ( i = 0; i < playersleft.size ; i++ )
    {
        player = playersleft[ i ];
        
        if ( player function_a29e5f57c1ef9e35() )
        {
            continue;
        }
        
        if ( !isdefined( activeteams[ player.team ] ) )
        {
            activeteams[ player.team ] = 1;
            var_cf339568f0cf82d5[ var_cf339568f0cf82d5.size ] = player.team;
        }
    }
    
    while ( playersleft.size > numplayers && var_cf339568f0cf82d5.size > 0 )
    {
        level utility::waittill_any( "br_player_eliminated", "players_remaining_changed" );
        playersleft = getbrplayersnoteliminated();
        var_153daac21c8ddf8d = [];
        
        foreach ( team in var_cf339568f0cf82d5 )
        {
            var_75e58e8ee6526db1 = teams::getteamdata( team, "alivePlayers" );
            
            if ( !isdefined( var_75e58e8ee6526db1 ) )
            {
                var_75e58e8ee6526db1 = [];
            }
            
            if ( playersleft.size - var_75e58e8ee6526db1.size <= numplayers )
            {
                var_79c7a029988a3f16 = !level.usegulag || level.gulag.shutdown;
                
                if ( var_eab95be35247f31 || var_79c7a029988a3f16 )
                {
                    br_public::brleaderdialogteam( "top_" + numplayers, team, 0, undefined, 1, level.brgametype.dialogprefix );
                }
                
                var_153daac21c8ddf8d[ var_153daac21c8ddf8d.size ] = team;
            }
        }
        
        foreach ( team in var_153daac21c8ddf8d )
        {
            var_cf339568f0cf82d5 = arrayremove( var_cf339568f0cf82d5, team );
        }
    }
}

// Namespace br
// Params 0
// Checksum 0xade7a1f, Offset: 0x1b4bc
// Size: 0xbd
function getbrplayersnoteliminated()
{
    playersnoteliminated = [];
    
    foreach ( player in level.players )
    {
        if ( player.br_iseliminated )
        {
            continue;
        }
        
        if ( player br_public::playeriszombie() )
        {
            continue;
        }
        
        if ( level.codcasterenabled )
        {
            if ( player iscodcaster() )
            {
                continue;
            }
        }
        
        playersnoteliminated[ playersnoteliminated.size ] = player;
    }
    
    return playersnoteliminated;
}

// Namespace br
// Params 0
// Checksum 0xd2f6683d, Offset: 0x1b582
// Size: 0x12c
function function_aa0fbbd622092c4e()
{
    playersactive = [];
    
    foreach ( team in level.teamnamelist )
    {
        if ( isbrteameliminated( team ) )
        {
            continue;
        }
        
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            if ( player br_public::playeriszombie() )
            {
                continue;
            }
            
            if ( level.codcasterenabled )
            {
                if ( player iscodcaster() )
                {
                    continue;
                }
            }
            
            playersactive[ playersactive.size ] = player;
        }
    }
    
    return playersactive;
}

// Namespace br
// Params 0
// Checksum 0xbd958f2b, Offset: 0x1b6b7
// Size: 0x122
function function_d126c907c5dad4fe()
{
    teamsactive = [];
    
    foreach ( team in level.teamnamelist )
    {
        if ( isbrteameliminated( team ) )
        {
            continue;
        }
        
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            if ( level.codcasterenabled && player iscodcaster() )
            {
                continue;
            }
            
            teamsactive[ teamsactive.size ] = team;
            break;
        }
    }
    
    return teamsactive;
}

// Namespace br
// Params 1
// Checksum 0x7befa87a, Offset: 0x1b7e2
// Size: 0x54, Type: bool
function isbrteameliminated( team )
{
    allplayersdead = teams::getteamdata( team, "aliveCount" ) == 0;
    teamcanrespawn = isdefined( level.teamcanrespawn ) && level.teamcanrespawn[ team ];
    return allplayersdead && !teamcanrespawn;
}

// Namespace br
// Params 2
// Checksum 0x7e2c62df, Offset: 0x1b83f
// Size: 0x118
function resetafkchecks( player, fromlaststand )
{
    if ( isdefined( player.gulaguses ) && player.gulaguses > 0 || player.ffsm_isgulagrespawn || fromlaststand )
    {
        player.ignoreafkcheck = 0;
        
        if ( !player.pers[ "distTrackingPassed" ] )
        {
            if ( player.pers[ "deaths" ] == 0 && getdvarint( @"hash_b7416f39aecaad8", 0 ) )
            {
                player.pers[ "distTrackingPassedOrResetTime" ] = player mp_afk::function_a10af3f5e26c28da();
            }
            
            player thread playerlogic::totaldisttracking( player.origin );
            return;
        }
        
        player notify( #"afk_tracking_resume" );
        return;
    }
    
    player.pers[ "distTrackingPassed" ] = 0;
    player.pers[ "totalDistTraveledAFK" ] = 0;
    player.var_c38ca5641e393f49 = undefined;
    player thread playerlogic::totaldisttracking( player.origin );
}

// Namespace br
// Params 1
// Checksum 0x65e99ad1, Offset: 0x1b95f
// Size: 0x3e
function function_e3aa69b55abb5756( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player waittill( #"laststand_revived" );
    onfirstlandcallback_internal( player, 1 );
}

// Namespace br
// Params 1
// Checksum 0xa3bb19ee, Offset: 0x1b9a5
// Size: 0x40
function onfirstlandcallback( player )
{
    player function_11d1451480b85d27( 0 );
    
    if ( !player::isreallyalive( player ) )
    {
        return;
    }
    
    if ( player::isinlaststand( player ) )
    {
        level thread function_e3aa69b55abb5756( player );
        return;
    }
    
    onfirstlandcallback_internal( player );
}

// Namespace br
// Params 1
// Checksum 0x5d8c3579, Offset: 0x1b9ed
// Size: 0x4b
function function_7ddb0ffa43312f4d( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( !player isswimming() )
        {
            player.var_fec1009788ed39b6 = undefined;
            break;
        }
        
        wait 0.5;
    }
}

// Namespace br
// Params 2
// Checksum 0xe439e705, Offset: 0x1ba40
// Size: 0xff
function onfirstlandcallback_internal( player, fromlaststand = 0 )
{
    resetafkchecks( player, fromlaststand );
    player.brneverlanded = undefined;
    level thread function_7ddb0ffa43312f4d( player );
    
    if ( getdvarint( @"hash_9f0aea8fba119184", 1 ) == 1 )
    {
        player player_utility::function_b54a1e23734ef07( 1 );
    }
    
    if ( level.squadleaderboon )
    {
        if ( level.squadleaderboon != 0 )
        {
            if ( !level.teamdata[ player.team ][ "squadBoonDropped" ] )
            {
                if ( flags::gameflag( "prematch_done" ) && flags::gameflag( "br_ready_to_jump" ) )
                {
                    if ( player br_public::isplayerbrsquadleader() )
                    {
                        player squadleaderboon_dropbag();
                        level.teamdata[ player.team ][ "squadBoonDropped" ] = 1;
                    }
                }
            }
        }
    }
    
    utility::callsharedfunc( #"gametype", #"hash_c08c137acd7fb9c0", player );
}

// Namespace br
// Params 1
// Checksum 0x71d7d50a, Offset: 0x1bb47
// Size: 0x1a4
function calculateclientmatchdataextrainfopayload( player )
{
    var_7239e3fe811afceb = [ 0, 0, 0, 0 ];
    
    if ( isdefined( player ) && isdefined( player.brmissiontypescompleted ) )
    {
        currentidx = 0;
        
        foreach ( contracttype, completioncount in player.brmissiontypescompleted )
        {
            contractid = br_contract_manager::getquesttableindex( contracttype );
            assert( contractid < 15 );
            shiftedcount = int( clamp( completioncount, 0, 15 ) ) << 4;
            var_7239e3fe811afceb[ currentidx ] = shiftedcount + contractid;
            currentidx++;
            
            if ( currentidx >= 4 )
            {
                break;
            }
        }
    }
    
    payloadbundles = [];
    payloadbundles[ 0 ] = ( var_7239e3fe811afceb[ 0 ] << 8 ) + var_7239e3fe811afceb[ 1 ];
    payloadbundles[ 1 ] = ( var_7239e3fe811afceb[ 2 ] << 8 ) + var_7239e3fe811afceb[ 3 ];
    payloadbundles[ 2 ] = utility::get_int_or_0( player.br_contractxpearned );
    var_2c1e79df9b8b499d = int( clamp( utility::get_int_or_0( player.sessionuimemberindex ) - 1, 0, 3 ) );
    payloadbundles[ 3 ] = var_2c1e79df9b8b499d << 14;
    payloadbundles[ 3 ] += utility::get_int_or_0( player.pers[ "damage" ] );
    return payloadbundles;
}

// Namespace br
// Params 0
// Checksum 0xff7ddf42, Offset: 0x1bcf4
// Size: 0x118, Type: bool
function onplayerconnectstream()
{
    if ( !isdefined( self.sessionteam ) || self.sessionteam == "spectator" || self.sessionteam == "none" || isdefined( self.initialprespawn ) || self isplayerheadless() )
    {
        return false;
    }
    
    if ( level.codcasterenabled && self iscodcaster() )
    {
        return true;
    }
    
    if ( br_public::isbrpracticemode() && !isbot( self ) )
    {
        self setclientomnvar( "ui_br_extended_load_screen", 1 );
        return false;
    }
    
    if ( !usedropspawn() )
    {
        return true;
    }
    
    spawnpoint = getspawnpoint();
    self.initialprespawn = spawnpoint;
    self setclientomnvar( "ui_br_extended_load_screen", 1 );
    droporigin = br_public::playerstreamhintdroptoground( spawnpoint.origin );
    spawnintermission( droporigin, spawnpoint.angles );
    timeout = getdvarint( @"hash_3f23e1c2bbc2681a", 15000 );
    streamhint::playerstreamhintlocation( droporigin, timeout, 1, 1 );
    return false;
}

// Namespace br
// Params 0
// Checksum 0xd06cb3e9, Offset: 0x1be15
// Size: 0x88, Type: bool
function function_3c4eb636fe7d9813()
{
    if ( !isdefined( self.sessionteam ) || self.sessionteam == "spectator" || self.sessionteam == "none" || self isplayerheadless() )
    {
        return false;
    }
    
    spawnpoint = self getorigin();
    self setclientomnvar( "ui_br_extended_load_screen", 1 );
    timeout = getdvarint( @"hash_3f23e1c2bbc2681a", 15000 );
    streamhint::playerstreamhintlocation( spawnpoint, timeout, 1, 1 );
    return false;
}

// Namespace br
// Params 0
// Checksum 0xdb5ff42, Offset: 0x1bea6
// Size: 0x1f, Type: bool
function playerisstreaming()
{
    return self.sessionstate == "intermission" && isdefined( self.initialprespawn );
}

// Namespace br
// Params 0
// Checksum 0xc73a4b2d, Offset: 0x1bece
// Size: 0x39
function lastdroppableweaponchanged()
{
    weap_index = -1;
    
    if ( isdefined( self.lastdroppableweaponobj ) )
    {
        weap_index = getweaponindex( self.lastdroppableweaponobj );
    }
    
    self setclientomnvar( "ui_br_last_droppable_weapon", weap_index );
}

// Namespace br
// Params 1
// Checksum 0xe3f218b6, Offset: 0x1bf0f
// Size: 0x41
function brregendelayspeed( regenspeed )
{
    var_59595954b289b9a5 = utility::callsharedfunc( #"gametype", #"hash_d9593ba248d990c8", regenspeed );
    
    if ( isdefined( var_59595954b289b9a5 ) )
    {
        return var_59595954b289b9a5;
    }
    
    return regenspeed;
}

// Namespace br
// Params 3
// Checksum 0x8c1dc348, Offset: 0x1bf58
// Size: 0x52
function brmodeaddtoteamlives( player, team, context )
{
    level.totalalivecount++;
    utility::callsharedfunc( #"gametype", #"hash_56dca3b9bd0bc547", player, team );
    player br_utility::function_309ab680afb1439e( 1, team, context );
}

// Namespace br
// Params 3
// Checksum 0xfaf5faa6, Offset: 0x1bfb2
// Size: 0x6c
function brmoderemovefromteamlives( player, team, context )
{
    level.totalalivecount--;
    utility::callsharedfunc( #"gametype", #"hash_4800934d9c465657", player, team );
    player br_utility::function_309ab680afb1439e( 0, team, context );
    
    if ( isdefined( level.checkforlaststandwipe ) )
    {
        [[ level.checkforlaststandwipe ]]( player );
    }
}

// Namespace br
// Params 0
// Checksum 0x5bc38ab8, Offset: 0x1c026
// Size: 0x34f
function updateplayerandteamcountui()
{
    level notify( #"updatePlayerAndTeamCountUI" );
    level endon( #"updatePlayerAndTeamCountUI" );
    waittillframeend();
    
    if ( utility::issharedfuncdefined( #"gametype", #"updatePlayerAndTeamCountUI" ) )
    {
        utility::callsharedfunc( #"gametype", #"updatePlayerAndTeamCountUI" );
        return;
    }
    
    aliveplayercount = 0;
    var_651503a2996db478 = 0;
    activeteams = [];
    var_c5cbf1f144b365a7 = [];
    var_230a51f6e209fdbc = getmatchrulesdata( "brData", "includeEliminatedPlayersInPlayerCount" );
    
    foreach ( player in level.players )
    {
        if ( player function_a29e5f57c1ef9e35() || player.team == "spectator" || player.team == "codcaster" )
        {
            continue;
        }
        
        if ( !player.br_iseliminated || var_230a51f6e209fdbc )
        {
            if ( ( player.iszombie || player.isghost ) && !player.var_55a095bcd9f557f6 )
            {
                var_651503a2996db478++;
                activeteams[ player.team ] = player.team;
            }
            else
            {
                if ( !player.var_35ce72930b294835 )
                {
                    aliveplayercount++;
                }
                
                activeteams[ player.team ] = player.team;
                var_c5cbf1f144b365a7[ player.team ] = 1;
            }
        }
        
        if ( !isdefined( var_c5cbf1f144b365a7[ player.team ] ) )
        {
            result = utility::callsharedfunc( #"gametype", #"isteameliminated", player.team );
            
            if ( isdefined( result ) )
            {
                if ( !result )
                {
                    activeteams[ player.team ] = player.team;
                }
            }
            
            var_c5cbf1f144b365a7[ player.team ] = 1;
        }
    }
    
    foreach ( uibot in function_cda6de7e2ba52066() )
    {
        aliveplayercount++;
        activeteams[ uibot.team ] = uibot.team;
    }
    
    level.var_fc71e82557e9a9c2 = aliveplayercount;
    level.var_227b8a3a9c083621 = activeteams.size;
    level.activeteams = activeteams;
    
    /#
        var_2d13161b905894b7 = 255;
        assert( var_651503a2996db478 <= var_2d13161b905894b7 );
        assert( aliveplayercount <= var_2d13161b905894b7 );
        assert( activeteams.size <= var_2d13161b905894b7 );
    #/
    
    var_a187995f65a64fdb = ( var_651503a2996db478 << 16 ) + ( activeteams.size << 8 ) + aliveplayercount;
    setomnvar( "ui_br_match_stats", var_a187995f65a64fdb );
}

// Namespace br
// Params 0
// Checksum 0x14fafd79, Offset: 0x1c37d
// Size: 0x8b1
function br_updategameevents()
{
    totalplayers = 0;
    level.teamswithplayers = [];
    var_d33c4f38e6bd094a = 0;
    
    foreach ( team in level.activeteams )
    {
        teamcount = teams::getteamdata( team, "teamCount" );
        
        if ( isdefined( level.uibotmanager ) )
        {
            teamcount += teams::getteamdata( team, "UIBotCount" );
        }
        
        if ( teamcount )
        {
            totalplayers += teamcount;
            var_d33c4f38e6bd094a++;
            level.teamswithplayers[ level.teamswithplayers.size ] = team;
            
            if ( var_d33c4f38e6bd094a > 1 )
            {
                break;
            }
        }
    }
    
    if ( game_utility_mp::matchmakinggame() && !level.ingraceperiod && !level.disableforfeit )
    {
        if ( level.teambased )
        {
            if ( level.teamswithplayers.size == 1 && game[ "state" ] == "playing" )
            {
                thread gamelogic_mp::onforfeit( level.teamswithplayers[ 0 ] );
                return;
            }
            
            if ( level.teamswithplayers.size > 1 )
            {
                level.forfeitinprogress = undefined;
                level notify( #"abort_forfeit" );
            }
        }
        else
        {
            if ( totalplayers == 1 && level.maxplayercount > 1 )
            {
                thread gamelogic_mp::onforfeit();
                return;
            }
            
            if ( totalplayers > 1 )
            {
                level.forfeitinprogress = undefined;
                level notify( #"abort_forfeit" );
            }
        }
    }
    
    if ( var_d33c4f38e6bd094a == 1 && level.br_debugsolotest )
    {
        return;
    }
    
    if ( !game_utility_mp::getgametypenumlives() && !level.disablespawning )
    {
        return;
    }
    
    if ( !game_utility_mp::gamehasstarted() )
    {
        return;
    }
    
    if ( level.ingraceperiod && !isdefined( level.overrideingraceperiod ) )
    {
        return;
    }
    
    br_checkforlaststandfinish();
    
    if ( level.teambased )
    {
        livescount = [];
        haslivescount = 0;
        hasalivecount = 0;
        var_6ae587c36a113408 = [];
        
        foreach ( entry in level.activeteams )
        {
            livescount[ entry ] = 0;
            
            if ( !level.disablespawning )
            {
                teamplayers = teams::getteamdata( entry, "players" );
                
                foreach ( player in teamplayers )
                {
                    if ( !player.hasspawned || player.team == "spectator" || player.team == "codcaster" || player.team == "free" )
                    {
                        continue;
                    }
                    
                    if ( player.pers[ "lives" ] )
                    {
                        livescount[ entry ] += player.pers[ "lives" ];
                        haslivescount = 1;
                    }
                }
            }
            
            alivecount = teams::getteamdata( entry, "aliveCount" );
            
            if ( alivecount == 0 )
            {
                alivecount = function_e45241986b39c3a8( entry );
            }
            
            var_331f001849d0da10 = alivecount > 0;
            
            if ( !hasalivecount && var_331f001849d0da10 )
            {
                hasalivecount = 1;
            }
            
            if ( !var_331f001849d0da10 )
            {
                shouldeliminate = 1;
                result = utility::callsharedfunc( #"gametype", #"isteameliminated", entry );
                
                if ( result === 0 )
                {
                    shouldeliminate = 0;
                }
            }
            
            if ( shouldeliminate && teams::getteamdata( entry, "hasSpawned" ) && !var_331f001849d0da10 && !livescount[ entry ] && !teams::getteamdata( entry, "deathEvent" ) )
            {
                var_6ae587c36a113408[ var_6ae587c36a113408.size ] = entry;
                continue;
            }
            
            if ( alivecount == 1 )
            {
                if ( gettime() > teams::getteamdata( entry, "oneLeftTime" ) + 5000 && !teams::getteamdata( entry, "oneLeft" ) )
                {
                    teammatelives = 0;
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
                        teams::setteamdata( entry, "oneLeftTime", gettime() );
                        teams::setteamdata( entry, "oneLeft", 1 );
                        
                        if ( players.size > 1 )
                        {
                            [[ level.ononeleftevent ]]( entry );
                        }
                    }
                }
                
                continue;
            }
            
            teams::setteamdata( entry, "oneLeft", 0 );
        }
        
        if ( !hasalivecount && !haslivescount )
        {
            if ( level.postgameexfil && level.gameended )
            {
                level notify( #"exfil_continue_game_end" );
            }
            
            if ( level.nukeinfo.incoming )
            {
                return;
            }
            
            return [[ level.ondeadevent ]]( "all" );
        }
        
        if ( level.postgameexfil && level.gameended )
        {
            level notify( #"exfil_continue_game_end" );
        }
        
        if ( !level.skipondeadevent && !level.nukeinfo.incoming )
        {
            foreach ( entry in var_6ae587c36a113408 )
            {
                if ( level.multiteambased )
                {
                    teams::setteamdata( entry, "deathEvent", 1 );
                    [[ level.ondeadevent ]]( entry );
                    continue;
                }
                
                return [[ level.ondeadevent ]]( entry );
            }
        }
    }
    else
    {
        livescount = 0;
        
        foreach ( player in level.players )
        {
            if ( player.team == "spectator" || player.team == "codcaster" )
            {
                continue;
            }
            
            livescount += player.pers[ "lives" ];
        }
        
        alivecounttotal = 0;
        
        foreach ( entry in level.teamnamelist )
        {
            alivecounttotal += teams::getteamdata( entry, "aliveCount" );
        }
        
        if ( !alivecounttotal && !livescount )
        {
            if ( level.nukeinfo.incoming )
            {
                return;
            }
            
            return [[ level.ondeadevent ]]( "all" );
        }
        
        liveplayers = game_utility_mp::getpotentiallivingplayers();
        
        if ( liveplayers.size == 1 )
        {
            return [[ level.ononeleftevent ]]( "all" );
        }
    }
    
    utility::callsharedfunc( #"gametype", #"hash_297586d88e5e3385" );
}

// Namespace br
// Params 1
// Checksum 0x87b5d6de, Offset: 0x1cc36
// Size: 0x3f, Type: bool
function br_laststandfinishplayerisincapacitated( var_8fa435c114d34294 )
{
    var_43f78b3f71563cd3 = var_8fa435c114d34294 && br_gulag::checkgulagusecount();
    return self.inlaststand && !laststand::hasselfrevivetoken() && !var_43f78b3f71563cd3;
}

// Namespace br
// Params 0
// Checksum 0x8f1447c2, Offset: 0x1cc7e
// Size: 0x3f3
function br_highlightlaststandfinishplayers()
{
    attackers = [];
    victims = [];
    var_8fa435c114d34294 = isdefined( level.gulag ) && !level.gulag.shutdown;
    
    if ( level.teambased )
    {
        foreach ( entry in level.teamnamelist )
        {
            var_9468d6569216b372 = 0;
            
            foreach ( player in level.teamdata[ entry ][ "alivePlayers" ] )
            {
                if ( player br_laststandfinishplayerisincapacitated( var_8fa435c114d34294 ) )
                {
                    continue;
                }
                
                var_9468d6569216b372 = 1;
                break;
            }
            
            if ( var_9468d6569216b372 )
            {
                foreach ( player in level.teamdata[ entry ][ "alivePlayers" ] )
                {
                    if ( player br_laststandfinishplayerisincapacitated( var_8fa435c114d34294 ) )
                    {
                        continue;
                    }
                    
                    attackers[ attackers.size ] = player;
                }
                
                continue;
            }
            
            foreach ( player in level.teamdata[ entry ][ "alivePlayers" ] )
            {
                if ( player br_laststandfinishplayerisincapacitated( var_8fa435c114d34294 ) )
                {
                    victims[ victims.size ] = player;
                }
            }
        }
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( player br_laststandfinishplayerisincapacitated( var_8fa435c114d34294 ) )
            {
                victims[ victims.size ] = player;
                continue;
            }
            
            if ( isalive( player ) )
            {
                attackers[ attackers.size ] = player;
            }
        }
    }
    
    if ( !br_public::istutorial() )
    {
        br_public::brleaderdialog( "finish_calls", 0, attackers );
        
        foreach ( player in attackers )
        {
            player setclientomnvar( "ui_br_end_game_splash_type", 19 );
            player playlocalsound( "br_finish_them_splash" );
        }
        
        foreach ( player in victims )
        {
            player hudoutlineenable( "outline_nodepth_red" );
        }
    }
}

// Namespace br
// Params 0
// Checksum 0x8c327333, Offset: 0x1d079
// Size: 0x270
function br_checkforlaststandfinish()
{
    if ( !getdvarint( @"hash_9513d33b9343f1a0", 0 ) )
    {
        return;
    }
    
    if ( level.laststandfinisherdone )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "plunder" || game_utility::getgametype() == "kingslayer" )
    {
        return;
    }
    
    var_8fa435c114d34294 = isdefined( level.gulag ) && !level.gulag.shutdown;
    var_836a19b616e6f2ff = 0;
    var_6c7e6064e00597a8 = 0;
    
    if ( level.teambased )
    {
        foreach ( entry in level.teamnamelist )
        {
            var_9468d6569216b372 = 0;
            
            foreach ( player in level.teamdata[ entry ][ "alivePlayers" ] )
            {
                if ( player br_laststandfinishplayerisincapacitated( var_8fa435c114d34294 ) )
                {
                    var_6c7e6064e00597a8 = 1;
                    continue;
                }
                
                var_9468d6569216b372 = 1;
                break;
            }
            
            if ( var_9468d6569216b372 )
            {
                var_836a19b616e6f2ff++;
                
                if ( var_836a19b616e6f2ff > 1 )
                {
                    return;
                }
            }
        }
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player br_laststandfinishplayerisincapacitated( var_8fa435c114d34294 ) )
            {
                var_6c7e6064e00597a8 = 1;
                continue;
            }
            
            var_836a19b616e6f2ff++;
            
            if ( var_836a19b616e6f2ff > 1 )
            {
                return;
            }
        }
    }
    
    if ( var_836a19b616e6f2ff == 0 || !var_6c7e6064e00597a8 )
    {
        return;
    }
    
    assert( var_836a19b616e6f2ff == 1 );
    level.laststandfinisherdone = 1;
    br_highlightlaststandfinishplayers();
}

// Namespace br
// Params 2
// Checksum 0xded4b20, Offset: 0x1d2f1
// Size: 0x8cb
function br_checkforlaststandwipe( victim, islaststanddeath )
{
    if ( !getdvarint( @"hash_b11f030e3dc6e3ff", 1 ) )
    {
        return 0;
    }
    
    if ( br_public::isbrpracticemode() )
    {
        return 0;
    }
    
    if ( isdefined( level.incheckforlaststandwipe ) )
    {
        return 0;
    }
    
    level.incheckforlaststandwipe = 1;
    profilestart();
    var_8fa435c114d34294 = isdefined( level.gulag ) && !istrue( level.gulag.shutdown );
    var_3e6fac9889bb0679 = [];
    killedvictim = 0;
    var_ce91be58a32283ac = [];
    var_8585a2af43d8149d = [];
    var_b31d3846db742605 = isdefined( victim.team ) ? [ victim.team ] : level.teamnamelist;
    
    foreach ( entry in var_b31d3846db742605 )
    {
        if ( function_45fb04620e678531( entry ) )
        {
            continue;
        }
        
        var_4de07b1b1d430047 = 1;
        var_3e6fac9889bb0679 = [];
        var_12e379a62ae10c55 = 0;
        squadindices = br_public::function_ec36cf40e2b38aa6( entry );
        
        for ( i = 0; i < squadindices.size ; i++ )
        {
            squadindex = squadindices[ i ];
            teammates = teams::function_d032b36d01bbbab3( entry, squadindex, 0 );
            aliveteammates = teams::getteamdata( entry, "alivePlayers" );
            
            foreach ( player in teammates )
            {
                var_b6d5f3da11c121df = victim == player;
                var_9b07ba3490c46ccd = !arraycontains( aliveteammates, player ) && !player::isinlaststand( player ) && !istrue( player.playergoingintols );
                
                if ( var_9b07ba3490c46ccd && !var_b6d5f3da11c121df )
                {
                    continue;
                }
                
                isingulag = istrue( var_8fa435c114d34294 ) && player br_public::isplayerinorgoingtogulag();
                
                if ( isingulag )
                {
                    continue;
                }
                
                if ( islaststanddeath && var_b6d5f3da11c121df )
                {
                    var_12e379a62ae10c55 = 1;
                    continue;
                }
                
                isinlaststand = istrue( player.inlaststand ) || var_b6d5f3da11c121df;
                
                if ( isinlaststand && !player laststand::hasselfrevivetoken() && !player super_stimpistol::function_5544ffc601cb83dd() && !player br_public::playeriszombie() && !player.var_1f3d2436a2463a6f )
                {
                    var_3e6fac9889bb0679[ var_3e6fac9889bb0679.size ] = player;
                    continue;
                }
                
                var_4de07b1b1d430047 = 0;
                break;
            }
        }
        
        var_684943273be1d13 = var_4de07b1b1d430047 && ( var_3e6fac9889bb0679.size > 0 || istrue( islaststanddeath ) && var_12e379a62ae10c55 );
        
        if ( var_684943273be1d13 )
        {
            var_755c703e786af312 = level.brgametype.respawnenable && !( victim.respawndelay > 0 );
            var_3635968ced118f1b = var_755c703e786af312 && ( victim.issolo || victim && teams::getteamdata( victim.team, "teamCount" ) == 1 );
            var_684943273be1d13 = !var_3635968ced118f1b;
            
            if ( var_3635968ced118f1b )
            {
                killedvictim = 1;
                
                if ( victim.vehicle )
                {
                    if ( !br_spawnrespawn::function_cbf2e3ddae51ea99() && !getdvarint( @"hash_d8cfd656ad7cd6c5", 0 ) )
                    {
                        victim val::reset_all( "vehicle_occupant" );
                    }
                }
            }
        }
        
        if ( var_684943273be1d13 && !istrue( level.brgametype.var_27018aab4e737fb3 ) )
        {
            attackers = [];
            var_c01ed6c016634ac4 = getdvarint( @"hash_ffa712bbab83e958", 0 );
            delayindex = 0;
            
            foreach ( var_2f2e3e7373fe30f6 in var_3e6fac9889bb0679 )
            {
                if ( isdefined( var_2f2e3e7373fe30f6.laststandattacker ) && !arraycontains( attackers, var_2f2e3e7373fe30f6.laststandattacker ) )
                {
                    var_2f2e3e7373fe30f6.laststandattacker.wipeweapon = var_2f2e3e7373fe30f6.var_a54cf862f580156;
                    attackers[ attackers.size ] = var_2f2e3e7373fe30f6.laststandattacker;
                }
                
                if ( isdefined( victim ) && victim == var_2f2e3e7373fe30f6 )
                {
                    killedvictim = 1;
                }
                
                var_2f2e3e7373fe30f6 notify( #"squad_wipe_death" );
                var_2f2e3e7373fe30f6.squadwiped = 1;
                
                if ( var_c01ed6c016634ac4 )
                {
                    if ( isdefined( victim ) && victim == var_2f2e3e7373fe30f6 )
                    {
                        var_2f2e3e7373fe30f6.var_3fd757d47a3afc0d = 1;
                        var_2f2e3e7373fe30f6 damage::_suicide( 0 );
                        var_2f2e3e7373fe30f6.var_3fd757d47a3afc0d = undefined;
                    }
                    else
                    {
                        delayindex++;
                        var_2f2e3e7373fe30f6 thread function_c1eeb1b01a197122( delayindex );
                    }
                    
                    continue;
                }
                
                var_2f2e3e7373fe30f6.var_3fd757d47a3afc0d = 1;
                var_2f2e3e7373fe30f6 damage::_suicide( 0 );
                var_2f2e3e7373fe30f6.var_3fd757d47a3afc0d = undefined;
            }
            
            laststandattacker = victim.laststandattacker ?? victim.attacker;
            
            if ( islaststanddeath && isdefined( laststandattacker ) && !arraycontains( attackers, laststandattacker ) )
            {
                attackers[ attackers.size ] = laststandattacker;
            }
            
            foreach ( attacker in attackers )
            {
                if ( !isdefined( attacker ) )
                {
                    continue;
                }
                
                if ( isdefined( attacker.team ) && !isdefined( var_8585a2af43d8149d[ attacker.team ] ) )
                {
                    var_8585a2af43d8149d[ attacker.team ] = 1;
                    attackerteammates = level.teamdata[ attacker.team ][ "alivePlayers" ];
                    
                    foreach ( attackerteammate in attackerteammates )
                    {
                        attackerteammate thread gameplay_telemetry::function_383cde919fd850c4( "teamWipe", 2 );
                        attackerteammate thread points::doscoreevent( function_831efb80c2b0ab7b( victim ), attackerteammate.wipeweapon );
                    }
                    
                    wipeweapon = self.var_a54cf862f580156;
                    
                    if ( !isdefined( wipeweapon ) )
                    {
                        wipeweapon = isdefined( laststandattacker ) ? laststandattacker.currentweapon : attacker.currentweapon;
                    }
                    
                    attacker thread teamwipedobituary( victim, attacker, wipeweapon );
                    
                    if ( attacker challenges::challengesenabledforplayer() && !level.gametypebundle.var_f4bba6aecc94789c )
                    {
                        challenges::function_d2b9666e88748bb0( attacker );
                    }
                }
                
                attacker.wipeweapon = undefined;
                
                if ( !isdefined( var_ce91be58a32283ac[ attacker.team ] ) && !damage::function_193057578506a224() )
                {
                    var_ce91be58a32283ac[ attacker.team ] = 1;
                    
                    foreach ( player in level.teamdata[ attacker.team ][ "players" ] )
                    {
                        if ( !player br_public::isplayeringulag() )
                        {
                            player playlocalsound( "uin_wz2_splash_team_wipe" );
                        }
                    }
                }
            }
            
            if ( istrue( var_c01ed6c016634ac4 ) && delayindex > 0 )
            {
                level thread function_43162bdf743c98f2( attackers, victim, delayindex );
                continue;
            }
            
            level callback::callback( #"on_squad_wiped", { #victim:victim, #attackers:attackers } );
        }
    }
    
    profilestop();
    level.incheckforlaststandwipe = undefined;
    return killedvictim;
}

// Namespace br
// Params 1
// Checksum 0x1a7a5f0b, Offset: 0x1dbc5
// Size: 0x63
function function_bcd13dd19b0c04e2( victim )
{
    gametype = game_utility::getgametype();
    
    switch ( gametype )
    {
        case #"hash_59b8e9d05b31ff9":
            obituarymod = "MOD_TEAM_REPOSITIONING";
            break;
        default:
            obituarymod = function_35ccba314a4f8380( victim, 1 );
            break;
    }
    
    return obituarymod;
}

// Namespace br
// Params 2
// Checksum 0x771e4660, Offset: 0x1dc31
// Size: 0x103
function function_35ccba314a4f8380( victim, var_da0da0923872357f )
{
    if ( level.usegulag && !isgulagshutdown() )
    {
        foreach ( player in level.teamdata[ victim.team ][ "players" ] )
        {
            if ( !isdefined( player ) || !isdefined( player.gulaguses ) )
            {
                continue;
            }
            
            if ( player br_gulag::function_f3e1e2a67d51fba8( 1 ) )
            {
                return ( var_da0da0923872357f ? "MOD_TEAM_TO_GULAG" : #"team_to_gulag" );
            }
        }
    }
    
    return var_da0da0923872357f ? "MOD_TEAM_WIPED" : #"team_wiped";
}

// Namespace br
// Params 1
// Checksum 0xb0dc8e14, Offset: 0x1dd3d
// Size: 0x65
function function_831efb80c2b0ab7b( victim )
{
    gametype = game_utility::getgametype();
    
    switch ( gametype )
    {
        case #"hash_59b8e9d05b31ff9":
            obituarymod = #"team_repositioning";
            break;
        default:
            obituarymod = function_35ccba314a4f8380( victim );
            break;
    }
    
    return obituarymod;
}

// Namespace br
// Params 4
// Checksum 0xf56bf0d7, Offset: 0x1ddab
// Size: 0xdb
function teamwipedobituary( victim, attacker, laststandweapon, obituarymod )
{
    attackerteam = attacker.team;
    waitframe();
    
    if ( getdvarint( @"hash_1d9a01ca1d7e9e82", 0 ) )
    {
        if ( isdefined( victim ) && isdefined( attackerteam ) )
        {
            obitplayers = [];
            
            if ( isdefined( level.codcasters ) )
            {
                obitplayers = level.codcasters;
            }
            
            obitplayers = arraycombine( obitplayers, teams::function_d032b36d01bbbab3( attacker.team, attacker.sessionsquadid, 0 ) );
            var_924abc145a22046e = br_spectate::getspectatorsofplayer( attacker );
            
            if ( isdefined( var_924abc145a22046e ) )
            {
                obitplayers = arraycombine( obitplayers, var_924abc145a22046e );
            }
            
            obituarymod = function_bcd13dd19b0c04e2( victim );
            obituary( victim, attacker, laststandweapon, obituarymod, obitplayers );
        }
    }
}

// Namespace br
// Params 1
// Checksum 0xe54850ec, Offset: 0x1de8e
// Size: 0x26, Type: bool
function brdisabledamagestattracking( player )
{
    if ( brgulagdamagefilter( player ) )
    {
        return false;
    }
    
    if ( isagent( player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br
// Params 1
// Checksum 0x7a1939f7, Offset: 0x1debd
// Size: 0x15f
function initializeaardata( player )
{
    if ( player game_utility_mp::rankingenabled() && player hasplayerdata() )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 0, 0 );
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 1, 0 );
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 2, 0 );
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 3, 0 );
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 4, 0 );
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 5, 0 );
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 6, 0 );
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 7, 0 );
        initialxp = player getplayerdata( "common", "mpProgression", "playerLevel", "xp" );
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 8, initialxp );
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 9, initialxp );
        player setplayerdata( level.var_6f9b00680ed002d8, "aarData", "matchResult", game[ "round_end" ][ "draw" ] );
    }
}

// Namespace br
// Params 2
// Checksum 0xbf41a09f, Offset: 0x1e024
// Size: 0x334
function setaardata( team, players )
{
    if ( level.var_2f77eda9458c9df6 )
    {
        return;
    }
    
    if ( !isdefined( players ) )
    {
        players = teams::getteamdata( team, "players" );
    }
    
    foreach ( player in players )
    {
        if ( !player game_utility_mp::rankingenabled() || !player hasplayerdata() || player.extracted )
        {
            continue;
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
        supportxp = player.pers[ "supportXP" ];
        
        if ( !isdefined( supportxp ) )
        {
            supportxp = 0;
        }
        
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 3, supportxp );
        reconxp = player.pers[ "reconXP" ];
        
        if ( !isdefined( reconxp ) )
        {
            reconxp = 0;
        }
        
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 4, reconxp );
        matchbonus = 0;
        
        if ( isdefined( player.matchbonus ) )
        {
            matchbonus = int( player.matchbonus );
        }
        
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 5, matchbonus );
        placementbonus = 0;
        
        if ( isdefined( player.placementbonus ) )
        {
            placementbonus = int( player.placementbonus );
        }
        
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 6, placementbonus );
        squadplayxp = player.pers[ "squadPlayXP" ];
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 7, squadplayxp ?? 0 );
        initialxp = player getplayerdata( level.var_6f9b00680ed002d8, "aarValue", 8 );
        finalxp = initialxp + player.pers[ "summary" ][ "xp" ];
        player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 9, finalxp );
        player setplayerdata( "common", "brSubGameType", game_utility::getgametype() );
        player notify( #"br_player_aar_data_set" );
    }
}

// Namespace br
// Params 2
// Checksum 0xfcee3362, Offset: 0x1e360
// Size: 0x48, Type: bool
function briskillstreakallowed( streakitem, slotnumber )
{
    if ( isdefined( self.vehicle ) )
    {
        streakname = streakitem.streakname;
        
        if ( streakname == "manual_turret" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br
// Params 1
// Checksum 0x63753183, Offset: 0x1e3b1
// Size: 0x68
function brkillstreakbeginusefunc( streakinfo )
{
    if ( !isdefined( streakinfo ) )
    {
        return 0;
    }
    
    player = streakinfo.owner;
    
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    if ( isplayer( player ) && !streakinfo.skipequippedstreakcheck && !player killstreak::doesstreakinfomatchequippedstreak( streakinfo, 1 ) )
    {
        return 0;
    }
    
    return killstreaks::streakglobals_onkillstreakbeginuse( streakinfo );
}

// Namespace br
// Params 1
// Checksum 0x4607e8a5, Offset: 0x1e422
// Size: 0x11, Type: bool
function brmodevalidatekillstreakslot( slotnumber )
{
    return slotnumber == 1;
}

// Namespace br
// Params 0
// Checksum 0x383ab6c, Offset: 0x1e43c
// Size: 0x51
function killstreakweaponfiredcontinue()
{
    curweapon = self.currentprimaryweapon;
    
    if ( isdefined( curweapon ) && isdefined( curweapon.basename ) && curweapon.basename == "iw9_spotter_scope_mp" )
    {
        self setweaponammoclip( curweapon, self getcurrentweaponclipammo() + 1 );
    }
}

// Namespace br
// Params 3
// Checksum 0x8baa7c87, Offset: 0x1e495
// Size: 0x12e
function function_db10c8f42ea08ad5( var_fcc703d23f4764b0, var_fcc704d23f4766e3, radius )
{
    if ( isdefined( var_fcc703d23f4764b0 ) && isdefined( var_fcc704d23f4766e3 ) && isdefined( radius ) )
    {
        omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_cursor_pos_override_x", var_fcc703d23f4764b0 );
        omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_cursor_pos_override_y", var_fcc704d23f4766e3 );
        omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_size_override", radius );
        return;
    }
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) )
    {
        omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_cursor_pos_override_x", level.br_circle.dangercircleent.origin[ 0 ] );
        omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_cursor_pos_override_y", level.br_circle.dangercircleent.origin[ 1 ] );
        omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_size_override", level.br_circle.dangercircleent.origin[ 2 ] );
        return;
    }
    
    omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_cursor_pos_override_x", 0 );
    omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_cursor_pos_override_y", 0 );
    omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_size_override", 0 );
}

// Namespace br
// Params 0
// Checksum 0x67e69281, Offset: 0x1e5cb
// Size: 0x8, Type: bool
function function_a29e5f57c1ef9e35()
{
    return manager::function_7f3b0449df3d77e();
}

// Namespace br
// Params 0
// Checksum 0xb6ae7a1e, Offset: 0x1e5dc
// Size: 0x8
function function_cda6de7e2ba52066()
{
    return manager::function_cda6de7e2ba52066();
}

// Namespace br
// Params 0
// Checksum 0x5a00deb2, Offset: 0x1e5ed
// Size: 0x8
function function_6f7e22d4e6adac55()
{
    return manager::function_6f7e22d4e6adac55();
}

// Namespace br
// Params 1, eflags: 0x4
// Checksum 0x785f08f, Offset: 0x1e5fe
// Size: 0x50, Type: bool
function private function_43ffb50893982936( team )
{
    if ( !level.teambased || !isdefined( team ) || team == "all" )
    {
        return ( manager::function_6f7e22d4e6adac55() == 0 );
    }
    
    return !manager::isinitialized() || teams::getteamdata( team, "UIBotCount" ) <= 0;
}

// Namespace br
// Params 1
// Checksum 0xa30548fa, Offset: 0x1e657
// Size: 0x15, Type: bool
function function_45fb04620e678531( team )
{
    return !function_43ffb50893982936( team );
}

// Namespace br
// Params 0
// Checksum 0x21e7a56b, Offset: 0x1e675
// Size: 0x22, Type: bool
function isgulagshutdown()
{
    return level.usegulag && level.gulag.shutdown;
}

// Namespace br
// Params 0
// Checksum 0x5495cb22, Offset: 0x1e6a0
// Size: 0x8f
function function_634ae2f481992300()
{
    self endon( #"disconnect" );
    
    if ( !level.br_prematchstarted )
    {
        if ( isbrgamemode() && !level.var_dd8633765c6a1db9 )
        {
            return;
        }
        
        var_4b0b17846cf1e4e1 = getmatchrulesdata( "commonOption", "respawnArmor" );
        respawnreserveplates = getmatchrulesdata( "commonOption", "respawnReservePlates" );
        armor::givestartingarmor( var_4b0b17846cf1e4e1, respawnreserveplates );
        return;
    }
    
    if ( !level.br_prematchstarted )
    {
        level waittill( #"infils_ready" );
    }
    
    armor::givestartingarmor();
}

// Namespace br
// Params 0
// Checksum 0x20e331d4, Offset: 0x1e737
// Size: 0xbb
function function_d47075b9f5ca65ad()
{
    if ( level.var_6a8faefd19f2a7ce )
    {
        maxplates = level.var_6a8faefd19f2a7ce;
    }
    else
    {
        typeref = level.var_d7c7b92362c2f4c0;
        armorbundle = level.var_870309755966253b;
        
        if ( !isdefined( typeref ) )
        {
            armorbundlename = common_item_database::function_ca9ca606e66b5911( %"brloot_armor_plate" );
            armorbundle = getscriptbundle( armorbundlename );
            typeref = common_item::function_16e8c106491eeaca( armorbundle );
            level.var_d7c7b92362c2f4c0 = typeref;
            level.var_870309755966253b = armorbundle;
        }
        
        maxplates = common_item::function_5f3f8e423378acd6( armorbundle, typeref );
    }
    
    if ( self.hasplatepouch )
    {
        maxplates += level.var_19e654be23bff1c8;
    }
    
    return maxplates;
}

// Namespace br
// Params 0
// Checksum 0xdc64660b, Offset: 0x1e7fb
// Size: 0x21
function setplayerprematchallows()
{
    val::set( "prematch", "player_for_spawn_logic", 0 );
    self allowmelee( 0 );
    self disableoffhandweapons();
}

// Namespace br
// Params 0
// Checksum 0x3d20ff4, Offset: 0x1e824
// Size: 0x10
function freefallstartfunc()
{
    self allowmelee( 1 );
    self enableoffhandweapons();
}

// Namespace br
// Params 1
// Checksum 0x305a60f, Offset: 0x1e83c
// Size: 0x1f
function function_68f609db838ec9c0( callbackthread )
{
    game_utility::function_c4ff84a7288ed707();
    [[ callbackthread ]]();
    game_utility::function_48cf7b776b9642d3();
}

// Namespace br
// Params 0
// Checksum 0x322c7b3c, Offset: 0x1e863
// Size: 0x51
function nukemapdataafterprematch()
{
    waittillframeend();
    wait 1;
    
    while ( !flags::gameflagexists( "prematch_done" ) )
    {
        waitframe();
    }
    
    flags::gameflagwait( "prematch_done" );
    waittillframeend();
    
    while ( level.var_c4ff84a7288ed707 )
    {
        waitframe();
    }
    
    utility::function_a56cf359233cf85b();
    
    /#
        setdvar( @"hash_949fe6b9860bd2c2", 6000 );
    #/
}

// Namespace br
// Params 0
// Checksum 0xdfb1dc17, Offset: 0x1e8bc
// Size: 0x45
function squadleaderboon_dropbag()
{
    player = self;
    teamsize = level.teamdata[ player.team ][ "players" ].size;
    br_default_inventory::function_ec61d7588b044316( player, 8554, 1, teamsize );
}

// Namespace br
// Params 1
// Checksum 0x12305d9f, Offset: 0x1e909
// Size: 0x150
function function_32db763006f55e44( params )
{
    agent = self;
    killer = params.eattacker;
    
    if ( isdefined( killer ) && killer vehicle::is_vehicle() )
    {
        killer = vehicle_occupancy::get_driver( killer );
    }
    
    if ( isplayer( killer ) )
    {
        if ( !isdefined( killer.agentkills ) )
        {
            killer.agentkills = 0;
        }
        
        killer.agentkills += 1;
        gametype = game_utility::getgametype();
        
        if ( gametype != "plunder" )
        {
            killer br_public::updatebrscoreboardstat( "agentKills", killer.agentkills );
        }
        
        if ( !level.var_42440e0ca1525e31 )
        {
            var_550b1aa78dbb41a5 = killer getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "modeStats", level.gametype, "agentKills" );
            var_550b1aa78dbb41a5 += 1;
            killer setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "modeStats", level.gametype, "agentKills", var_550b1aa78dbb41a5 );
        }
        
        killer function_9dae0f70e3900cca( agent );
        utility::callsharedfunc( #"gametype", #"playerkilledzombie", killer );
    }
}

// Namespace br
// Params 1
// Checksum 0xa5372857, Offset: 0x1ea61
// Size: 0x44d
function function_9dae0f70e3900cca( agent )
{
    if ( isagent( agent ) )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "agentKills" ] ) )
            {
                self.leaderboarddata[ "agentKills" ] = self.leaderboarddata[ "agentKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "agentKills" ] ) )
            {
                [[ level.leaderboardfunc[ "agentKills" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x380>" );
            
            if ( isdefined( self.pers[ "agentKills" ] ) )
            {
                self.pers[ "agentKills" ] = self.pers[ "agentKills" ] + 1;
            }
        }
        
        category = agent.category;
        tier = agent.tier;
        elite = agent.elite;
        
        if ( category == "elites" )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "bossAgentKills" ] ) )
                {
                    self.leaderboarddata[ "bossAgentKills" ] = self.leaderboarddata[ "bossAgentKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "bossAgentKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "bossAgentKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x380>" );
                
                if ( isdefined( self.pers[ "bossAgentKills" ] ) )
                {
                    self.pers[ "bossAgentKills" ] = self.pers[ "bossAgentKills" ] + 1;
                }
            }
            
            return;
        }
        
        if ( isdefined( tier ) )
        {
            if ( elite == 1 )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "tier" + tier + "EliteAgentKills" ] ) )
                    {
                        self.leaderboarddata[ "tier" + tier + "EliteAgentKills" ] = self.leaderboarddata[ "tier" + tier + "EliteAgentKills" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "tier" + tier + "EliteAgentKills" ] ) )
                    {
                        [[ level.leaderboardfunc[ "tier" + tier + "EliteAgentKills" ] ]]( self, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x380>" );
                    
                    if ( isdefined( self.pers[ "tier" + tier + "EliteAgentKills" ] ) )
                    {
                        self.pers[ "tier" + tier + "EliteAgentKills" ] = self.pers[ "tier" + tier + "EliteAgentKills" ] + 1;
                    }
                }
                
                return;
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "tier" + tier + "NormalAgentKills" ] ) )
                {
                    self.leaderboarddata[ "tier" + tier + "NormalAgentKills" ] = self.leaderboarddata[ "tier" + tier + "NormalAgentKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "tier" + tier + "NormalAgentKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "tier" + tier + "NormalAgentKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x380>" );
                
                if ( isdefined( self.pers[ "tier" + tier + "NormalAgentKills" ] ) )
                {
                    self.pers[ "tier" + tier + "NormalAgentKills" ] = self.pers[ "tier" + tier + "NormalAgentKills" ] + 1;
                }
            }
        }
    }
}

// Namespace br
// Params 0
// Checksum 0xfeed1b45, Offset: 0x1eeb6
// Size: 0x1a7
function tnbrmonitorlauncherammorestock()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self notify( #"tnbrmonitorlauncherammorestock" );
    self endon( #"tnbrmonitorlauncherammorestock" );
    
    while ( !flags::gameflagexists( "prematch_done" ) )
    {
        waitframe();
    }
    
    flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        var_b0642c57c2fa9c37 = getdvarfloat( @"hash_2c016fd52c45f297", 5 );
        wait var_b0642c57c2fa9c37;
        
        if ( !player::isaliveandnotinlaststand( self ) )
        {
            continue;
        }
        
        if ( br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        var_2bf2325533ab2e72 = 0;
        weaponsarray = self getweaponslistprimaries();
        
        foreach ( weapon in weaponsarray )
        {
            ammotype = br_weapons::br_ammo_type_for_weapon( weapon );
            
            if ( ammotype == "brloot_ammo_rocket" )
            {
                var_2bf2325533ab2e72 = 1;
                break;
            }
        }
        
        if ( !var_2bf2325533ab2e72 )
        {
            continue;
        }
        
        var_c1df172be583f215 = utility::get_int_or_0( self.br_ammo[ "brloot_ammo_rocket" ] );
        var_a5f423910c73745a = level.br_ammo_max_stock[ "brloot_ammo_rocket" ];
        
        if ( var_c1df172be583f215 < var_a5f423910c73745a )
        {
            br_weapons::br_ammo_give_type( self, "brloot_ammo_rocket", 1, 0 );
        }
    }
}

// Namespace br
// Params 0
// Checksum 0x6616bb7b, Offset: 0x1f065
// Size: 0x1e
function function_9ea6f24223d24688()
{
    var_80e3f99b37e0667c = getdvarint( @"hash_4bded611decf41c5", 0 );
    return var_80e3f99b37e0667c;
}

// Namespace br
// Params 1
// Checksum 0x4a4399b4, Offset: 0x1f08c
// Size: 0x50
function function_f2d49b5c22624ea2( modeloverride )
{
    if ( !isdefined( self.carryflag ) )
    {
        self.carryflag = modeloverride ?? "prop_king_game_flag";
        self attach( self.carryflag, "tag_stowed_back3", 1 );
        self setclientomnvar( "ui_flag_player_hud_icon", 1 );
    }
}

// Namespace br
// Params 0
// Checksum 0x12aed6de, Offset: 0x1f0e4
// Size: 0x39
function function_ccd86d629929e144()
{
    if ( isdefined( self.carryflag ) )
    {
        self detach( self.carryflag, "tag_stowed_back3" );
        self.carryflag = undefined;
        self setclientomnvar( "ui_flag_player_hud_icon", 0 );
    }
}

// Namespace br
// Params 0
// Checksum 0xc290503b, Offset: 0x1f125
// Size: 0x92
function function_a1b34bd531f8f8f2()
{
    self endon( #"disconnect" );
    
    if ( utility::issharedfuncdefined( #"teamassim", #"disableplayer" ) )
    {
        [[ utility::getsharedfunc( #"teamassim", #"disableplayer" ) ]]( self, "untilMatchStart" );
    }
    
    flags::gameflagwait( "br_ready_to_jump" );
    
    if ( utility::issharedfuncdefined( #"teamassim", #"enableplayer" ) )
    {
        [[ utility::getsharedfunc( #"teamassim", #"enableplayer" ) ]]( self, "untilMatchStart" );
    }
}

// Namespace br
// Params 0
// Checksum 0xe5c1ed54, Offset: 0x1f1bf
// Size: 0x83
function function_f4ff01e34eacb2ca()
{
    level endon( #"game_ended" );
    var_d2865b005f56e114 = getdvarint( @"hash_f4d1714fd7d712eb", 0 );
    
    if ( var_d2865b005f56e114 > 0 )
    {
        level waittill( #"prematch_done" );
        wait max( 0, var_d2865b005f56e114 - 10 );
        
        for ( countdown = 10; countdown > 0 ; countdown-- )
        {
            iprintln( "MAP SWAP STARTING IN " + countdown );
            wait 1;
        }
        
        utility::set_area_swap_state( "test_observatory", "after", 10 );
    }
}

// Namespace br
// Params 1
// Checksum 0xc15732df, Offset: 0x1f24a
// Size: 0x87
function function_f8d4f0e87b5151be( params )
{
    pingowner = params.player;
    pingindex = params.pingindex;
    
    if ( isdefined( pingowner ) && isdefined( pingindex ) )
    {
        var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
        
        if ( calloutmarkerping::function_b658b8c35408496a( var_6675b0888e2dbc2 ) )
        {
            if ( !isdefined( pingowner.var_c38ca5641e393f49 ) )
            {
                pingowner.var_c38ca5641e393f49 = 0;
            }
            
            pingowner.var_c38ca5641e393f49++;
        }
    }
}

// Namespace br
// Params 0
// Checksum 0x4fbc2717, Offset: 0x1f2d9
// Size: 0x58
function function_e2227cea56b8d35e()
{
    if ( getdvarint( @"hash_738b7382a23ac132", 0 ) )
    {
        return;
    }
    
    while ( !flags::gameflagexists( "prematch_done" ) )
    {
        waitframe();
    }
    
    flags::gameflagwait( "prematch_done" );
    utility::registersharedfunc( #"ai", #"droplootonagentdeath", &ai_loot::droplootonagentdeath );
    ai_loot::function_69b4db6b064345dc();
}

// Namespace br
// Params 0
// Checksum 0xd1e8d108, Offset: 0x1f339
// Size: 0x8b
function function_ac29aaa257cf7811()
{
    if ( !isdefined( level.var_9c3445d6dd24e0f5 ) )
    {
        level.var_9c3445d6dd24e0f5 = [];
    }
    
    if ( !isdefined( level.var_46ca940741779160 ) )
    {
        level.var_46ca940741779160 = [];
    }
    
    scriptable_ascender::function_959621fba91be23a( &function_c68df9a913f1f844 );
    scriptable_ascender::function_432ef320b0c53fcd( &function_b2928829d88e8953 );
    scriptable_ascender::function_784813a62abce5fe( &function_787ff6af177fe7d );
    
    if ( getdvarint( @"redeploy_ascenders_enabled", 0 ) )
    {
        level.var_4a4bea82789b5312 = [];
        utility::registersharedfunc( #"redeploy_drone", #"can_use_callback", &function_e338bdbc069482d5 );
    }
}

// Namespace br
// Params 1
// Checksum 0x47f358, Offset: 0x1f3cc
// Size: 0x39
function function_44274c8d804a57fd( func )
{
    if ( !isdefined( level.var_9c3445d6dd24e0f5 ) )
    {
        level.var_9c3445d6dd24e0f5 = [];
    }
    
    level.var_9c3445d6dd24e0f5[ level.var_9c3445d6dd24e0f5.size ] = func;
}

// Namespace br
// Params 1
// Checksum 0xd8ea7540, Offset: 0x1f40d
// Size: 0x39
function function_c4ab1bb15d73f6e( func )
{
    if ( !isdefined( level.var_46ca940741779160 ) )
    {
        level.var_46ca940741779160 = [];
    }
    
    level.var_46ca940741779160[ level.var_46ca940741779160.size ] = func;
}

// Namespace br
// Params 1
// Checksum 0xc902649b, Offset: 0x1f44e
// Size: 0x30
function function_98b3f00f63d6579c( func )
{
    if ( isdefined( level.var_4a4bea82789b5312 ) )
    {
        level.var_4a4bea82789b5312[ level.var_4a4bea82789b5312.size ] = func;
    }
}

// Namespace br
// Params 6
// Checksum 0xf8b6d40f, Offset: 0x1f486
// Size: 0xc8
function function_c68df9a913f1f844( instance, player, edgeindex, isvertical, isinverted, isgoingup )
{
    foreach ( func in level.var_9c3445d6dd24e0f5 )
    {
        var_7237854e3be197ca = [[ func ]]( instance, player, edgeindex, isvertical, isinverted, isgoingup );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
}

// Namespace br
// Params 5
// Checksum 0xfbf15742, Offset: 0x1f556
// Size: 0xef
function function_b2928829d88e8953( instance, player, edgeindex, isinverted, isvertical )
{
    foreach ( func in level.var_46ca940741779160 )
    {
        result = [[ func ]]( instance, player, edgeindex, isinverted );
        
        if ( isdefined( result ) )
        {
            if ( result )
            {
                function_5e675fa36e9b0103( instance, player, isvertical );
            }
            
            return result;
        }
    }
    
    if ( armor::function_eecfbcb181240dd9( player.currentweapon ) )
    {
        return 0;
    }
    
    function_5e675fa36e9b0103( instance, player, isvertical );
    return 1;
}

// Namespace br
// Params 3
// Checksum 0x6149fa56, Offset: 0x1f64e
// Size: 0x117
function function_5e675fa36e9b0103( instance, player, isvertical )
{
    eventparams = [];
    eventparams[ eventparams.size ] = "match_time";
    eventparams[ eventparams.size ] = gettime();
    eventparams[ eventparams.size ] = "map_name";
    eventparams[ eventparams.size ] = game_utility::getmapname() ?? "";
    eventparams[ eventparams.size ] = "ascender_type";
    eventparams[ eventparams.size ] = instance.type ?? "";
    eventparams[ eventparams.size ] = "ascender_x";
    eventparams[ eventparams.size ] = instance.origin[ 0 ] ?? 0;
    eventparams[ eventparams.size ] = "ascender_y";
    eventparams[ eventparams.size ] = instance.origin[ 1 ] ?? 0;
    eventparams[ eventparams.size ] = "ascender_z";
    eventparams[ eventparams.size ] = instance.origin[ 2 ] ?? 0;
    eventparams[ eventparams.size ] = "is_vertical";
    eventparams[ eventparams.size ] = isvertical;
    player dlog_recordplayerevent( "dlog_event_br_ascender_use", eventparams );
}

// Namespace br
// Params 2
// Checksum 0x8f6490d3, Offset: 0x1f76d
// Size: 0xa0
function function_e338bdbc069482d5( instance, player )
{
    foreach ( func in level.var_4a4bea82789b5312 )
    {
        var_7237854e3be197ca = [[ func ]]( instance, player );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    return 1;
}

// Namespace br
// Params 6
// Checksum 0xd4cb7d95, Offset: 0x1f816
// Size: 0x75
function function_787ff6af177fe7d( instance, player, edgeindex, isinverted, isvertical, ascendervec )
{
    if ( !( isdefined( player ) && isdefined( ascendervec ) ) )
    {
        return;
    }
    
    player thread function_a11e6b9c2c868fd5();
    player callback::callback( #"player_used_ascender" );
    
    if ( isvertical )
    {
        instance thread function_46947e65339e27f8( player, ascendervec, isinverted );
        return;
    }
}

// Namespace br
// Params 0
// Checksum 0x3dea6a30, Offset: 0x1f893
// Size: 0x51
function function_a11e6b9c2c868fd5()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_c0b53846b1bfb648 = 1;
    thread events::function_d1b23d540da7bff0();
    utility::waittill_any( "ascender_detached", "death_or_disconnect", "ascender_cancel", "ascender_solo_cancel" );
    self.var_c0b53846b1bfb648 = 0;
}

// Namespace br
// Params 3, eflags: 0x4
// Checksum 0x29e0061e, Offset: 0x1f8ec
// Size: 0x124
function private function_46947e65339e27f8( player, ascendervec, isinverted )
{
    player endon( #"death_or_disconnect" );
    
    if ( getdvarint( @"hash_85915b7dc4e50c15", 1 ) == 1 )
    {
        dir = ascendervec[ 2 ];
        
        if ( isinverted )
        {
            dir *= -1;
        }
        
        player thread function_6f2431a97c8bbcca( dir );
        
        if ( dir == -1 )
        {
            player utility::waittill_any( "ascender_detached", "ascender_cancel", "ascender_solo_cancel" );
            wait 0.5;
            contents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
            result = br_public::raytraceoffset( player.origin, 0, 0, 5, -20000, contents );
            
            if ( result[ "fraction" ] == 1 || result[ "position" ][ 2 ] < br_public::function_5d8b60a1b01b8249() )
            {
                var_c4f67cbfec32e081 = isnavmeshloaded() ? getclosestpointonnavmesh( player.origin ) : player.origin;
                player setorigin( var_c4f67cbfec32e081 );
            }
        }
    }
}

// Namespace br
// Params 1, eflags: 0x4
// Checksum 0xd9bd48e0, Offset: 0x1fa18
// Size: 0x112
function private function_6f2431a97c8bbcca( direction )
{
    if ( getdvarint( @"hash_e7831a169ec422bf", 1 ) == 0 )
    {
        return;
    }
    
    player = self;
    player endon( #"disconnect" );
    result = player utility::waittill_any_return( "ascender_detached", "ascender_cancel", "ascender_solo_cancel", "death" );
    
    if ( result != "ascender_detached" )
    {
        return;
    }
    
    player.falldamageprotection = 1;
    protectionms = direction == -1 ? 900 : 2000;
    deadline = gettime() + protectionms;
    
    while ( isdefined( player ) && player::isreallyalive( player ) && gettime() < deadline && !player isonground() && !player isvehicleactive() && !player isonladder() && !player isswimming() && !player ishanging() )
    {
        waitframe();
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.falldamageprotection = undefined;
}

// Namespace br
// Params 3, eflags: 0x4
// Checksum 0x3ed0146d, Offset: 0x1fb32
// Size: 0x1af
function private function_649f8f395e8f0b82( player, edgeindex, ascendervec = ( 0, 0, 1 ) )
{
    result = player utility::waittill_any_timeout( 1, "death_or_disconnect", "ascender_attached" );
    
    if ( result == "ascender_attached" && !isdefined( player.var_38b04819cbeb9ab6 ) )
    {
        player setclientomnvar( "ui_speedboost_overlay", 0 );
        var_ceb3800a5d335474 = vectortoangles( ascendervec );
        pos = player gettagorigin( "tag_accessory_left" );
        player.var_38b04819cbeb9ab6 = spawn( "script_model", pos );
        player.var_38b04819cbeb9ab6 setmodel( "misc_vm_zipline_device_top_01" );
        player.var_38b04819cbeb9ab6 linktoignorerotation( player, "tag_accessory_left", ( 0, 0, 0 ), var_ceb3800a5d335474 );
        player.var_38b04819cbeb9ab6 function_7207895b28c71c79( 1 );
        
        if ( !player getcamerathirdperson() )
        {
            player.var_38b04819cbeb9ab6 hidefromplayer( player );
        }
        
        player utility::waittill_any( "death_or_disconnect", "ascender_detached", "ascender_cancel", "ascender_solo_cancel" );
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( player::isreallyalive( player ) && ( !isdefined( player.deadsilenceuistate ) || player.deadsilenceuistate == -1 ) )
        {
            player setclientomnvar( "ui_speedboost_overlay", 2 );
        }
        
        player.var_38b04819cbeb9ab6 kill();
        player.var_38b04819cbeb9ab6 delete();
        player.var_38b04819cbeb9ab6 = undefined;
    }
}

// Namespace br
// Params 0
// Checksum 0xcbfb1e40, Offset: 0x1fce9
// Size: 0x3e
function function_61e2f390df19d678()
{
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_8946ce0ae9eb0955 ) )
    {
        return;
    }
    
    self.var_8946ce0ae9eb0955 = 1;
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    self.var_8946ce0ae9eb0955 = undefined;
}

// Namespace br
// Params 0
// Checksum 0xff950e4a, Offset: 0x1fd2f
// Size: 0x47b
function initapril()
{
    level.aprilevent = getdvarint( @"scr_br_april", 0 ) != 0;
    level.var_4e0d9044c82bf74a = getdvarint( @"hash_840ecb3adebe57f7", 1 ) != 0;
    level.var_318d8bf9cecea871 = getdvarint( @"hash_545b8c1ed10fbed0", 1 ) != 0;
    level.var_724d02c20b4150fb = getdvarint( @"hash_823c8ce2368209b2", 0 ) != 0;
    
    if ( !level.aprilevent )
    {
        return;
    }
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    if ( level.mapname == "mp_br_mechanics" )
    {
        structrainbow = spawnstruct();
        structrainbow.origin = ( 3956.32, -1963.43, 0 );
        structrainbow.angles = ( 0, -84.4941, 0 );
        structrainbow.script_noteworthy = "april_rainbow_1";
        utility::addstruct( structrainbow );
        structcache = spawnstruct();
        structcache.origin = ( 3906.32, -1963.43, 0 );
        structcache.angles = ( 0, 0, 0 );
        structcache.script_noteworthy = "april_cache_1_1";
        utility::addstruct( structcache );
        structcache = spawnstruct();
        structcache.origin = ( 4006.32, -1963.43, 0 );
        structcache.angles = ( 0, 0, 0 );
        structcache.script_noteworthy = "april_cache_1_2";
        utility::addstruct( structcache );
        structcache = spawnstruct();
        structcache.origin = ( 3956.32, -1963.43, 0 );
        structcache.angles = ( 0, 0, 0 );
        structcache.script_noteworthy = "april_cache_1_3";
        utility::addstruct( structcache );
    }
    
    var_3a8d53ba2998588d = 0;
    
    for ( i = 1;  ; i++ )
    {
        if ( !isdefined( utility::getstruct( "april_rainbow_" + i, "script_noteworthy" ) ) )
        {
            break;
        }
        
        var_3a8d53ba2998588d += 1;
    }
    
    if ( var_3a8d53ba2998588d == 0 )
    {
        return;
    }
    
    tospawn = randomint( var_3a8d53ba2998588d ) + 1;
    rainbowspawn = utility::getstruct( "april_rainbow_" + tospawn, "script_noteworthy" );
    rainbow = spawn( "script_model", rainbowspawn.origin );
    rainbow.angles = rainbowspawn.angles;
    rainbow setmodel( "br_april_rainbow" );
    rainbow setscriptablepartstate( "rainbow", "on" );
    
    if ( getdvarint( @"hash_4292bf6ab9d3b43c", 1 ) == 1 )
    {
        return;
    }
    
    caches = [];
    
    for ( j = 1;  ; j++ )
    {
        cachespawn = utility::getstruct( "april_cache_" + tospawn + "_" + j, "script_noteworthy" );
        
        if ( !isdefined( cachespawn ) )
        {
            break;
        }
        
        cache = spawnscriptable( "br_loot_cache_april", cachespawn.origin, cachespawn.angles );
        cache setscriptablepartstate( "body", "closed_usable" );
        caches[ caches.size ] = cache;
    }
    
    if ( caches.size > 0 )
    {
        foreach ( cache in caches )
        {
            cache.contents = getscriptablelootcachecontents( cache );
            cache.contents[ cache.contents.size ] = "brloot_plunder_cash_legendary_1";
        }
        
        snipercache = utility::array_random( caches );
        snipercache.contents[ snipercache.contents.size ] = "brloot_weapon_sn_alpha50_april";
    }
    
    for ( j = 1;  ; j++ )
    {
        cachespawn = utility::getstruct( "april_fake_cache_" + tospawn + "_" + j, "script_noteworthy" );
        
        if ( !isdefined( cachespawn ) )
        {
            break;
        }
        
        cache = spawnscriptable( "br_loot_cache_april", cachespawn.origin, cachespawn.angles );
    }
}

// Namespace br
// Params 2
// Checksum 0x85f45022, Offset: 0x201b2
// Size: 0xb7, Type: bool
function br_commonitemweaponcannotdropweapon( weapon, player )
{
    if ( flags::gameflagexists( "prematch_cleanup_done" ) && !flags::gameflag( "prematch_cleanup_done" ) )
    {
        return true;
    }
    
    if ( !weapons::isdroppableweapon( player, weapon ) )
    {
        return true;
    }
    
    if ( level.var_fe0e5f06ec7d82bf && !isalive( player ) )
    {
        return true;
    }
    
    basename = weapon::getweaponrootname( weapon.basename );
    
    if ( basename == "ks_use_crate_mp" )
    {
        return true;
    }
    
    if ( !isweapon( weapon ) )
    {
        return true;
    }
    
    if ( player br_extract_quest::extract_ismissionweapon( weapon ) )
    {
        return true;
    }
    
    if ( !player br_gulag::function_b31a927d9159eb86() )
    {
        return true;
    }
    
    return false;
}

// Namespace br
// Params 1
// Checksum 0x63aeb945, Offset: 0x20272
// Size: 0x5b, Type: bool
function function_17d84987a4050282( player )
{
    if ( flags::gameflagexists( "prematch_cleanup_done" ) && !flags::gameflag( "prematch_cleanup_done" ) )
    {
        return true;
    }
    
    if ( !player br_gulag::function_b31a927d9159eb86() )
    {
        return true;
    }
    
    if ( isdefined( level.droparmorondeath ) && !level.droparmorondeath )
    {
        return true;
    }
    
    return false;
}

// Namespace br
// Params 2
// Checksum 0x9053b8b7, Offset: 0x202d6
// Size: 0x3c
function function_779c052686ae8325( instance, player )
{
    if ( !isdefined( player.cachesopened ) )
    {
        player.cachesopened = 0;
    }
    
    player.cachesopened++;
}

// Namespace br
// Params 1
// Checksum 0x1705320a, Offset: 0x2031a
// Size: 0x51
function function_e45241986b39c3a8( team )
{
    uibotcount = 0;
    
    if ( isdefined( level.uibotmanager ) )
    {
        uibotcount = teams::getteamdata( team, "UIBotCount" );
        
        if ( uibotcount < 0 )
        {
            assertmsg( "<dev string:x4d7>" + team );
            uibotcount = 0;
        }
    }
    
    return uibotcount;
}

// Namespace br
// Params 0
// Checksum 0xefe92e99, Offset: 0x20374
// Size: 0x9f
function br_packclientmatchdata()
{
    missionvalue = self.brmissionscompleted ?? 0;
    
    if ( missionvalue > 15 )
    {
        missionvalue = 15;
    }
    
    if ( isdefined( self.teamplacement ) )
    {
        setclientmatchdata( "players", self.clientmatchdataid, "placement", self.teamplacement );
    }
    
    setclientmatchdata( "players", self.clientmatchdataid, "extrascore4", missionvalue );
    println( "<dev string:x4f6>" + self.name + "<dev string:x504>" + self.clientmatchdataid + "<dev string:x506>" + missionvalue );
}

// Namespace br
// Params 0
// Checksum 0xb20fadaa, Offset: 0x2041b
// Size: 0x98
function function_7e7b2e900be477ae()
{
    self.pers[ "extrascore0" ] = self.extrascore0;
    self.pers[ "extrascore1" ] = self.extrascore1;
    self.pers[ "extrascore2" ] = self.extrascore2;
    self.pers[ "extrascore3" ] = self.extrascore3;
    self.pers[ "extrascore4" ] = self.extrascore4;
    self.pers[ "extrascore5" ] = self.extrascore5;
}

// Namespace br
// Params 1
// Checksum 0x1fcc0888, Offset: 0x204bb
// Size: 0x260
function function_f5125ee6f75fbda9( params )
{
    cache = params.cacheinstance;
    
    if ( issubstr( cache.type, "lege" ) )
    {
        points::doscoreevent( #"br_cacheopen_epic" );
        self playsoundtoplayer( "uin_wz2_loot_container_open_epic", self );
    }
    else if ( issubstr( cache.type, "personal" ) )
    {
        foreach ( teammember in teams::getteamdata( self.team, "players" ) )
        {
            if ( isalive( teammember ) && distance2d( teammember.origin, self.origin ) <= 1000 )
            {
                teammember points::doscoreevent( #"br_cacheopen_personal" );
            }
        }
        
        self playsoundtoplayer( "uin_wz2_loot_container_open_epic", self );
    }
    else
    {
        points::doscoreevent( #"br_cacheOpen" );
        self playsoundtoplayer( "uin_wz2_loot_container_open_common", self );
    }
    
    activesupplysweeps = level.teamdata[ self.team ][ "activeSupplySweeps" ];
    
    if ( isdefined( activesupplysweeps ) )
    {
        foreach ( streakinfo in activesupplysweeps )
        {
            if ( isdefined( streakinfo ) && streakinfo.owner != self )
            {
                streakinfo.owner points::doscoreevent( #"br_supply_sweep_assist" );
            }
        }
    }
    
    if ( params.cacheinstance.type == "br_reusable_loot_cache" || params.cacheinstance.type == "br_reusable_loot_cache_bongo" )
    {
        params.cacheinstance thread function_82e85efa8a19633a();
    }
}

// Namespace br
// Params 0
// Checksum 0x1600dbf4, Offset: 0x20723
// Size: 0x120
function function_82e85efa8a19633a()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"closed" );
    var_b08cd83dafe2549f = getdvarint( @"hash_fd0c403fee9dc217", 90 );
    fxincrement = var_b08cd83dafe2549f / 3;
    self.var_fac9f8e0a78bc01c = 1;
    wait fxincrement;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setscriptablepartstate( "body", "fully_open_unusable_fx2" );
    wait fxincrement;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setscriptablepartstate( "body", "fully_open_unusable_fx3" );
    wait fxincrement;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.contents = undefined;
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( self.type );
    
    if ( isdefined( var_f67995529827f79.spawnlist ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        common_cache::function_a136b84fc5c0dfab( self, var_f67995529827f79.spawnlist, var_f67995529827f79.spawncount, 1 );
    }
    
    self.var_fac9f8e0a78bc01c = 0;
    self setscriptablepartstate( "body", "closing" );
    self notify( #"closed" );
}

// Namespace br
// Params 1
// Checksum 0x83755b6f, Offset: 0x2084b
// Size: 0xf0
function function_3675dbc7027a14f2( params )
{
    params.player.endmatchstats[ "cashSpent" ] = ( params.player.endmatchstats[ "cashSpent" ] ?? 0 ) + params.cost;
    params.player.endmatchstats[ "totalPurchases" ] = ( params.player.endmatchstats[ "totalPurchases" ] ?? 0 ) + 1;
    
    if ( !br_gametypes::isfeaturedisabled( #"kioskxp" ) || br_public::isanytutorialorbotpracticematch() )
    {
        params.player thread points::doscoreevent( #"br_kioskBuy", undefined, calculatepurchasexp( params.cost, params.itemdata.type ) );
    }
}

// Namespace br
// Params 3
// Checksum 0x9de86a49, Offset: 0x20943
// Size: 0x567
function function_9ba73c5ed781b998( victim, laststandattacker, shouldincrement )
{
    attacker = self;
    
    if ( !isdefined( attacker ) || !isbrgamemode() || !isplayer( victim ) || !level.gametypebundle.var_19c0e5cca9ced15d )
    {
        return [ -1, -1 ];
    }
    
    var_a05bf9ab3d2feb09 = level.gametypebundle.var_a05bf9ab3d2feb09;
    var_74f873f9b53fb32d = level.gametypebundle.var_74f873f9b53fb32d;
    var_3161155b8ba4172b = level.gametypebundle.var_3161155b8ba4172b;
    var_ef09ec183cd2d107 = level.gametypebundle.var_ef09ec183cd2d107;
    var_927940a823a04a1f = 0;
    
    if ( isplayer( attacker ) && attacker != victim )
    {
        if ( !isdefined( level.var_44e174fc1e9d0fde ) )
        {
            level.var_44e174fc1e9d0fde = [];
        }
        
        if ( !isdefined( level.var_44e174fc1e9d0fde[ attacker getentitynumber() ] ) )
        {
            level.var_44e174fc1e9d0fde[ attacker getentitynumber() ] = [];
        }
        
        if ( !isdefined( level.var_44e174fc1e9d0fde[ attacker getentitynumber() ][ victim getentitynumber() ] ) )
        {
            level.var_44e174fc1e9d0fde[ attacker getentitynumber() ][ victim getentitynumber() ] = 0;
        }
        
        if ( shouldincrement )
        {
            level.var_44e174fc1e9d0fde[ attacker getentitynumber() ][ victim getentitynumber() ]++;
        }
        
        if ( !isdefined( level.var_44e174fc1e9d0fde[ attacker.team ] ) )
        {
            level.var_44e174fc1e9d0fde[ attacker.team ] = [];
        }
        
        if ( !isdefined( level.var_44e174fc1e9d0fde[ attacker.team ][ victim.team ] ) )
        {
            level.var_44e174fc1e9d0fde[ attacker.team ][ victim.team ] = 0;
        }
        
        if ( shouldincrement )
        {
            level.var_44e174fc1e9d0fde[ attacker.team ][ victim.team ]++;
        }
        
        if ( level.var_44e174fc1e9d0fde[ attacker getentitynumber() ][ victim getentitynumber() ] > var_a05bf9ab3d2feb09 )
        {
            var_927940a823a04a1f += 1;
        }
        
        if ( level.var_44e174fc1e9d0fde[ attacker.team ][ victim.team ] > var_3161155b8ba4172b )
        {
            var_927940a823a04a1f += 2;
        }
    }
    
    var_dd8ce1a4501c862b = 0;
    
    if ( isplayer( laststandattacker ) && laststandattacker != victim )
    {
        if ( !isdefined( level.var_174dad32410d0195 ) )
        {
            level.var_174dad32410d0195 = [];
        }
        
        if ( !isdefined( level.var_174dad32410d0195[ laststandattacker getentitynumber() ] ) )
        {
            level.var_174dad32410d0195[ laststandattacker getentitynumber() ] = [];
        }
        
        if ( !isdefined( level.var_174dad32410d0195[ laststandattacker getentitynumber() ][ victim getentitynumber() ] ) )
        {
            level.var_174dad32410d0195[ laststandattacker getentitynumber() ][ victim getentitynumber() ] = 0;
        }
        
        if ( shouldincrement )
        {
            level.var_174dad32410d0195[ laststandattacker getentitynumber() ][ victim getentitynumber() ]++;
        }
        
        if ( !isdefined( level.var_174dad32410d0195[ laststandattacker.team ] ) )
        {
            level.var_174dad32410d0195[ laststandattacker.team ] = [];
        }
        
        if ( !isdefined( level.var_174dad32410d0195[ laststandattacker.team ][ victim.team ] ) )
        {
            level.var_174dad32410d0195[ laststandattacker.team ][ victim.team ] = 0;
        }
        
        if ( shouldincrement )
        {
            level.var_174dad32410d0195[ laststandattacker.team ][ victim.team ]++;
        }
        
        if ( level.var_174dad32410d0195[ laststandattacker getentitynumber() ][ victim getentitynumber() ] > var_74f873f9b53fb32d )
        {
            var_dd8ce1a4501c862b += 1;
        }
        
        if ( level.var_174dad32410d0195[ laststandattacker.team ][ victim.team ] > var_ef09ec183cd2d107 )
        {
            var_dd8ce1a4501c862b += 2;
        }
    }
    
    var_44e86cbf2253c357 = attacker ? level.var_44e174fc1e9d0fde[ attacker getentitynumber() ][ victim getentitynumber() ] : -1;
    var_1b1c258eb2ada57d = attacker ? level.var_44e174fc1e9d0fde[ attacker.team ][ victim.team ] : -1;
    var_1223b26e1e0eeb93 = laststandattacker ? level.var_174dad32410d0195[ laststandattacker getentitynumber() ][ victim getentitynumber() ] : -1;
    var_3798071fd3ea4431 = laststandattacker ? level.var_174dad32410d0195[ laststandattacker.team ][ victim.team ] : -1;
    
    if ( shouldincrement && ( var_44e86cbf2253c357 >= 2 || var_1b1c258eb2ada57d >= 2 || var_1223b26e1e0eeb93 >= 2 || var_3798071fd3ea4431 >= 2 ) )
    {
        attacker function_53f7d2003e1a64ad( victim, laststandattacker, var_927940a823a04a1f, var_dd8ce1a4501c862b, var_44e86cbf2253c357, var_1b1c258eb2ada57d, var_1223b26e1e0eeb93, var_3798071fd3ea4431 );
    }
    
    if ( level.var_309e3d9dac389de6 && ( var_927940a823a04a1f > 0 || var_dd8ce1a4501c862b > 0 ) )
    {
        if ( shouldincrement )
        {
            /#
                attacker hud_message::showerrormessage( %"hash_49ac25430a67be87" );
            #/
            
            attacker setclientomnvar( "ui_anti_teaming_detected", 1 );
        }
        
        return [ var_927940a823a04a1f, var_dd8ce1a4501c862b ];
    }
    
    return [ -1, -1 ];
}

// Namespace br
// Params 8
// Checksum 0x1a218429, Offset: 0x20eb3
// Size: 0x39f
function function_53f7d2003e1a64ad( victim, laststandattacker, var_927940a823a04a1f, var_dd8ce1a4501c862b, var_44e86cbf2253c357, var_1b1c258eb2ada57d, var_1223b26e1e0eeb93, var_3798071fd3ea4431 )
{
    attacker = self;
    eventparams = [];
    eventparams[ eventparams.size ] = "last_stand_attacker_uno_id";
    eventparams[ eventparams.size ] = isplayer( laststandattacker ) ? laststandattacker getplayerunoid() ?? "-1" : "-1";
    eventparams[ eventparams.size ] = "last_stand_attacker_team";
    eventparams[ eventparams.size ] = laststandattacker.team ?? "";
    eventparams[ eventparams.size ] = "victim_uno_id";
    eventparams[ eventparams.size ] = victim getplayerunoid() ?? "-1";
    eventparams[ eventparams.size ] = "victim_team_name";
    eventparams[ eventparams.size ] = victim.team ?? "";
    eventparams[ eventparams.size ] = "attacker_team_name";
    eventparams[ eventparams.size ] = attacker.team ?? "";
    eventparams[ eventparams.size ] = "attacker_x";
    eventparams[ eventparams.size ] = attacker.origin[ 0 ] ?? 0;
    eventparams[ eventparams.size ] = "attacker_y";
    eventparams[ eventparams.size ] = attacker.origin[ 1 ] ?? 0;
    eventparams[ eventparams.size ] = "attacker_z";
    eventparams[ eventparams.size ] = attacker.origin[ 2 ] ?? 0;
    eventparams[ eventparams.size ] = "victim_x";
    eventparams[ eventparams.size ] = victim.origin[ 0 ] ?? 0;
    eventparams[ eventparams.size ] = "victim_y";
    eventparams[ eventparams.size ] = victim.origin[ 1 ] ?? 0;
    eventparams[ eventparams.size ] = "victim_z";
    eventparams[ eventparams.size ] = victim.origin[ 2 ] ?? 0;
    eventparams[ eventparams.size ] = "last_stand_attacker_x";
    eventparams[ eventparams.size ] = laststandattacker.origin[ 0 ] ?? 0;
    eventparams[ eventparams.size ] = "last_stand_attacker_y";
    eventparams[ eventparams.size ] = laststandattacker.origin[ 1 ] ?? 0;
    eventparams[ eventparams.size ] = "last_stand_attacker_z";
    eventparams[ eventparams.size ] = laststandattacker.origin[ 2 ] ?? 0;
    eventparams[ eventparams.size ] = "suspicious_down_individual";
    eventparams[ eventparams.size ] = var_1223b26e1e0eeb93 ?? 0;
    eventparams[ eventparams.size ] = "suspicious_down_team";
    eventparams[ eventparams.size ] = var_3798071fd3ea4431 ?? 0;
    eventparams[ eventparams.size ] = "suspicious_down_index";
    eventparams[ eventparams.size ] = var_dd8ce1a4501c862b ?? 0;
    eventparams[ eventparams.size ] = "suspicious_kill_individual";
    eventparams[ eventparams.size ] = var_44e86cbf2253c357 ?? 0;
    eventparams[ eventparams.size ] = "suspicious_kill_team";
    eventparams[ eventparams.size ] = var_1b1c258eb2ada57d ?? 0;
    eventparams[ eventparams.size ] = "suspicious_kill_index";
    eventparams[ eventparams.size ] = var_927940a823a04a1f ?? 0;
    eventparams[ eventparams.size ] = "server_time";
    eventparams[ eventparams.size ] = int( gettime() / 1000 ) ?? 0;
    eventparams[ eventparams.size ] = "circle_index";
    circleindex = level.br_circle.circleindex ?? -1;
    eventparams[ eventparams.size ] = circleindex;
    eventparams[ eventparams.size ] = "map_name";
    eventparams[ eventparams.size ] = game_utility::getmapname() ?? "";
    eventparams[ eventparams.size ] = "playlist_id";
    eventparams[ eventparams.size ] = getplaylistid() ?? 0;
    attacker dlog_recordplayerevent( "dlog_event_br_anticheat_suspicious_enemy_killed", eventparams );
}

// Namespace br
// Params 1
// Checksum 0xf4ef7e1, Offset: 0x2125a
// Size: 0x3f
function function_7fafc240b32733fb( params )
{
    params.regenspeedmod *= level.adrenalinesettings.var_5639f33ce00d26f ?? 1;
}

// Namespace br
// Params 1
// Checksum 0x885139f2, Offset: 0x212a1
// Size: 0x68
function function_f4dd45d820b8f71d( params )
{
    if ( !callback::exists( #"hash_83a1950e73246811", &function_7fafc240b32733fb ) )
    {
        callback::add( #"hash_83a1950e73246811", &function_7fafc240b32733fb );
    }
    
    if ( level.gametypebundle.var_bebdb9b3b6bca6c0 )
    {
        self clearsoundsubmix( level.gametypebundle.var_bebdb9b3b6bca6c0 );
    }
}

// Namespace br
// Params 1
// Checksum 0xdb2f4524, Offset: 0x21311
// Size: 0x71
function function_2e8f5e082750dc17( params )
{
    if ( callback::exists( #"hash_83a1950e73246811", &function_7fafc240b32733fb ) )
    {
        callback::remove( #"hash_83a1950e73246811", &function_7fafc240b32733fb );
    }
    
    if ( gasmask::function_a062bf98847b605a( self ) )
    {
        if ( level.gametypebundle.var_bebdb9b3b6bca6c0 )
        {
            self setsoundsubmix( level.gametypebundle.var_bebdb9b3b6bca6c0 );
        }
    }
}

// Namespace br
// Params 0
// Checksum 0xc44b97ce, Offset: 0x2138a
// Size: 0xdf
function jumpmasterwatch()
{
    logstring( "jumpMasterWatch: " + self.name + ";\n" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        var_9586ea1d7c932dc8 = self function_ef8af48d79d46963();
        br_public::function_99cb14b2b9be7b27( var_9586ea1d7c932dc8 );
    }
    
    thread function_5375c1e1fbc42f0f();
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, value );
        
        if ( channel == "transfer_leader_ship" )
        {
            br_public::function_a0236cbb3d65af8e();
            continue;
        }
        
        if ( channel == "detach_from_group" )
        {
            if ( br_public::function_63526e8677d58de8( 1 ) )
            {
                thread hud_message::showsplash( "splash_br_unfollow_jump_leader" );
                
                if ( flags::gameflag( "prematch_done" ) )
                {
                    self setclientomnvar( "ui_jump_master_finished", 1 );
                }
            }
        }
    }
}

// Namespace br
// Params 0
// Checksum 0xb30820be, Offset: 0x21471
// Size: 0xa2
function function_5375c1e1fbc42f0f()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_done" );
    }
    
    if ( !br_public::function_e6445d548e426852() && !br_public::isplayerbrsquadleader() )
    {
        self setclientomnvar( "ui_jump_master_finished", 1 );
        return;
    }
    
    utility::waittill_any( "hold_teammates_complete", "stop_push" );
    br_public::function_63526e8677d58de8( 0 );
    self setclientomnvar( "ui_jump_master_finished", 1 );
    logstring( "watchPlayerFirstLandedOrDeath: " + self.name + ";\n" );
}

// Namespace br
// Params 1, eflags: 0x4
// Checksum 0xea6d1f34, Offset: 0x2151b
// Size: 0x89
function private function_606c40fc1dfe6f64( params )
{
    if ( vehicle_occupancy::is_driver_seat( params.vehicle, params.seatid ) )
    {
        if ( !level.var_f0eb3711b5eb893[ params.player.guid ] )
        {
            level.var_f0eb3711b5eb893[ params.player.guid ] = 1;
            challenges::function_37e945722d6497f3( params.player, "drive_once", 1 );
        }
    }
}

// Namespace br
// Params 4
// Checksum 0x7f8b9ed2, Offset: 0x215ac
// Size: 0x6f
function br_canitemfitinbackpack( lootid, lootname, quantity, maxcount )
{
    if ( namespace_5ab67a14d18bea3f::function_85f1b1e637ab489f( lootid ) )
    {
        for ( i = 0; i < common_inventory::function_9cd65c8312048802() ; i++ )
        {
            currentlootid = common_inventory::inventory_getlootidatbackpackindex( i );
            
            if ( currentlootid == 0 )
            {
                return 1;
            }
        }
        
        return 0;
    }
}

// Namespace br
// Params 0
// Checksum 0xf5a605a4, Offset: 0x21623
// Size: 0x68
function function_c83cb027f9f56818()
{
    newclassindex = self getplayerdata( level.var_6f9b00680ed002d8, "favoriteLoadoutIndex" );
    newclass = menus::getclasschoice( newclassindex );
    self.pers[ "class" ] = newclass;
    self.class = newclass;
    self takeallweapons();
    class::preloadandqueueclass( newclass, 1 );
    class::swaploadout();
}

// Namespace br
// Params 0
// Checksum 0x5333944f, Offset: 0x21693
// Size: 0x171
function function_5b5db9dfa00f69eb()
{
    player = self;
    contracts_completed_index = level.activitymanager.var_b073c6c9822b3544 ? player.sessionsquadid : player.sessionteam;
    is_prematch = gamelogic_mp::inprematch();
    player dlog_recordplayerevent( "dlog_event_br_player_match_end_supp", [ "contracts_completed", level.activitymanager.var_eadfe43e300095f8[ contracts_completed_index ] ?? 0, "loadouts_acquired", player.endmatchstats[ "loadoutsOpened" ] ?? 0, "gulag_wins", player.endmatchstats[ "gulagWinsThisMatch" ] ?? 0, "bought_back", player.endmatchstats[ "revivedFromKiosk" ] ?? 0, "bought_others_back", player.endmatchstats[ "kioskRevives" ] ?? 0, "cash_spent", player.endmatchstats[ "cashSpent" ] ?? 0, "survival_time", isdefined( level.starttime ) ? gettime() - level.starttime : 0, "is_prematch", is_prematch ] );
}

// Namespace br
// Params 3
// Checksum 0xf73f2c50, Offset: 0x2180d
// Size: 0xdf
function resetplayerinventory( keeploadout, keeparmor, playerkilled )
{
    if ( !br_gametypes::isfeaturedisabled( #"armor" ) )
    {
        if ( !keeparmor )
        {
            armor::breakarmor();
        }
        
        if ( self.insertingarmorplate )
        {
            armor::function_d1a93ae3582cc2da( "reset_player_inventory" );
        }
    }
    
    if ( !keeploadout )
    {
        iskingslayer = game_utility::getgametype() == "kingslayer";
        
        if ( !iskingslayer )
        {
            common_inventory::function_4b4cbbe1c5a19189();
        }
        
        common_inventory::function_eb484185711f8cc0();
        common_inventory::function_f49daeb7a25b5b21();
        common_inventory::function_38ff1a66cd956902();
        common_inventory::function_94daaff595cfaa7c();
        
        if ( getdvarint( @"hash_5fa994ad2e64b933", 0 ) )
        {
            common_inventory::inventory_dropweapons();
        }
        else
        {
            common_inventory::function_bcb3b52008443a44();
        }
        
        weapons::setlastdroppableweaponobj( level.defaultfist );
        
        if ( namespace_5ab67a14d18bea3f::function_43c57123ed24d409() )
        {
            namespace_5ab67a14d18bea3f::function_9477f4690296f31();
        }
    }
}

// Namespace br
// Params 2
// Checksum 0x28a3e8a9, Offset: 0x218f4
// Size: 0x137, Type: bool
function function_6ed043163481a439( itemname, iscustomweapon )
{
    if ( iscustomweapon )
    {
        itemname = weapon::getweaponrootname( itemname );
    }
    
    if ( !isdefined( itemname ) )
    {
        return false;
    }
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        if ( isdefined( level.forbiddencachespawns[ itemname ] ) )
        {
            return false;
        }
    }
    
    if ( itemname == "brloot_respawn_token" && utility::callsharedfunc( #"game", #"respawntokendisabled" ) )
    {
        return false;
    }
    
    if ( itemname == "brloot_gulag_token" && utility::callsharedfunc( #"game", #"hash_6b72f04a5e268f64" ) )
    {
        return false;
    }
    
    if ( ( itemname == "brloot_redeploy_token" || itemname == "brloot_gulag_token" ) && isgulagshutdown() )
    {
        return false;
    }
    
    if ( itemname == "brloot_bongo_redeploy_token" && utility::callsharedfunc( #"game", #"respawntokendisabled" ) )
    {
        return false;
    }
    
    issolos = level.maxteamsize == 1 || level.brgametype.issolos;
    
    if ( itemname == "brloot_super_reinforcement_flare" && issolos )
    {
        return false;
    }
    
    if ( itemname == "loot_multi_key_fortress" )
    {
        return false;
    }
    
    return true;
}

// Namespace br
// Params 0
// Checksum 0x515be25e, Offset: 0x21a34
// Size: 0xd5
function function_560399c2f487a786()
{
    totalalivecount = 0;
    totalplayers = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        totalalivecount += teams::getteamdata( entry, "aliveCount" );
        totalplayers += teams::getteamcount( entry );
    }
    
    setomnvar( "ui_allies_alive", 0 );
    setomnvar( "ui_axis_alive", totalalivecount );
    setomnvar( "ui_allies_team_size", 0 );
    setomnvar( "ui_axis_team_size", totalplayers );
}

/#

    // Namespace br
    // Params 0
    // Checksum 0x50e034d7, Offset: 0x21b11
    // Size: 0x63, Type: dev
    function function_7f8e68c8640a640e()
    {
        self clearsoundsubmix( "<dev string:x51a>", 1.5 );
        self setclientomnvar( "<dev string:x52b>", 1 );
        self setclientomnvar( "<dev string:x53f>", 1 );
        
        if ( player::isreallyalive( self ) )
        {
            if ( isdefined( level.parachuterestoreweaponscb ) )
            {
                self [[ level.parachuterestoreweaponscb ]]();
            }
            
            self skydive_setdeploymentstatus( 1 );
            self skydive_setbasejumpingstatus( 1 );
        }
    }

#/

// Namespace br
// Params 1
// Checksum 0xd1fc236a, Offset: 0x21b7c
// Size: 0x3e
function function_6637184afcde5ddf( vehicle )
{
    if ( !level.wztrain_info.train_names )
    {
        return 0;
    }
    
    return arraycontains( level.wztrain_info.train_names, vehicle );
}

// Namespace br
// Params 1, eflags: 0x4
// Checksum 0x1f49ac8c, Offset: 0x21bc3
// Size: 0x1f
function private refundkillstreak( streakname )
{
    killstreaks::awardkillstreak( streakname, "other", undefined, undefined, undefined, 1 );
}

// Namespace br
// Params 1
// Checksum 0x135ecc2a, Offset: 0x21bea
// Size: 0x4e
function function_cf35e8c4ba031051( params )
{
    var_c89e23d1e4dc52a3 = level.poi[ params.poi ][ "isHot" ] ?? 0;
    params.player setclientomnvar( "ui_callout_area_hot", var_c89e23d1e4dc52a3 );
}

// Namespace br
// Params 0
// Checksum 0xb2270614, Offset: 0x21c40
// Size: 0x180
function hotzonepois()
{
    hotzones = function_e2a061fcb85d84b5();
    
    if ( !hotzones.size )
    {
        return;
    }
    
    waittillframeend();
    
    if ( !poi::poi_issystemactive() )
    {
        return;
    }
    
    callback::add( #"player_enter_poi", &function_cf35e8c4ba031051 );
    var_d1bb9abd92cd38d9 = [];
    
    foreach ( zoneid in hotzones )
    {
        zoneinfo = function_4e52a812b6d1d965( zoneid );
        poiname = poi::poi_findpoioriginisin( zoneinfo.midpoint );
        var_d1bb9abd92cd38d9[ var_d1bb9abd92cd38d9.size ] = poi::function_db0e4b7793a08ae5( poiname );
    }
    
    foreach ( poiname, poi in level.poi )
    {
        if ( !isdefined( poi[ "calloutIndex" ] ) )
        {
            continue;
        }
        
        if ( arraycontains( var_d1bb9abd92cd38d9, poi[ "calloutIndex" ] ) )
        {
            level.poi[ poiname ][ "isHot" ] = 1;
        }
    }
}

// Namespace br
// Params 0
// Checksum 0xcad07a48, Offset: 0x21dc8
// Size: 0xab
function function_71f55559ba3d9403()
{
    var_d56c0ec9531ee611 = [];
    
    foreach ( poiname, poi in level.poi )
    {
        ishotzone = level.poi[ poiname ][ "isHot" ];
        
        if ( !ishotzone )
        {
            continue;
        }
        
        var_d56c0ec9531ee611[ var_d56c0ec9531ee611.size ] = poiname;
    }
    
    return var_d56c0ec9531ee611;
}

// Namespace br
// Params 1
// Checksum 0xeed1053f, Offset: 0x21e7c
// Size: 0x89
function function_9b69222366762863( params )
{
    if ( !isdefined( params.einflictor ) )
    {
        return;
    }
    
    if ( params.smeansofdeath == "MOD_TRIGGER_HURT" && params.einflictor.script_noteworthy == "fire_effect" )
    {
        if ( utility::issharedfuncdefined( #"weapons", #"hash_d4f96f0f31a2a165" ) )
        {
            self [[ utility::getsharedfunc( #"weapons", #"hash_d4f96f0f31a2a165" ) ]]( 1 );
        }
    }
}

// Namespace br
// Params 1
// Checksum 0xe8891060, Offset: 0x21f0d
// Size: 0x2b
function on_player_spawn_reset( params )
{
    if ( !self.var_2599217638092a45 )
    {
        self.var_2599217638092a45 = 1;
        self function_957a727ade8e2011( 0 );
    }
}

// Namespace br
// Params 1
// Checksum 0x62373a66, Offset: 0x21f40
// Size: 0x5f
function function_9e18e80c7af507fb( params )
{
    if ( params.player )
    {
        if ( !isdefined( params.player.lootcachesopened ) )
        {
            params.player.lootcachesopened = 0;
        }
        
        params.player.lootcachesopened++;
    }
}

// Namespace br
// Params 1
// Checksum 0x29b2d259, Offset: 0x21fa7
// Size: 0x8c
function function_675d16974324587b( player )
{
    foreach ( weapondata in player.var_1a87a9e7cf39ff69 )
    {
        weapondata.infilowner = player;
    }
}

// Namespace br
// Params 1
// Checksum 0x1bfa97ae, Offset: 0x2203b
// Size: 0x65
function function_c1eeb1b01a197122( delayindex )
{
    self endon( #"disconnect" );
    
    if ( delayindex > 0 )
    {
        for ( i = 0; i < delayindex ; i++ )
        {
            waitframe();
        }
    }
    
    if ( isdefined( self ) && isalive( self ) )
    {
        self.var_3fd757d47a3afc0d = 1;
        damage::_suicide( 0 );
        self.var_3fd757d47a3afc0d = undefined;
    }
}

// Namespace br
// Params 3
// Checksum 0xb787fdcb, Offset: 0x220a8
// Size: 0x75
function function_43162bdf743c98f2( attackers, victim, delayindex )
{
    level endon( #"game_ended" );
    
    if ( delayindex > 0 )
    {
        for ( i = 0; i < delayindex ; i++ )
        {
            waitframe();
        }
        
        waitframe();
    }
    
    level callback::callback( #"on_squad_wiped", { #victim:victim, #attackers:attackers } );
}

