// scripts\mp\gametypes\ob.gsc  (hash_0070c2478fc6d8ef.gscc) (size: 147304 Bytes / 0x23f68 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x22e41f80 (585375616)
// size ...... 147304 (0x23f68)
// includes .. 143 (offset: 0x20d00)
// strings ... 454 (offset: 0x21178)
// dev strs .. 375 (offset: 0x22cc4)
// exports ... 286 (offset: 0x1676c)
// cseg ...... 0x27c0 + 0x13fac (0x1676c)
// imports ... 896 (offset: 0x1941c)
// animtree1 . 0   (offset: 0x23f68)
// animtree2 . 0   (offset: 0x23f68)
#using script_14d95c611b71b01;
#using script_16ea1b94f0f381b3;
#using script_17aac58f7828f476;
#using script_2498b7c75f1dee2d;
#using script_26ccbfe3954cacf4;
#using script_30152080457bb762;
#using script_3cb3908b3094b567;
#using script_3edd59d0d3fc3262;
#using script_54da1af5927ef919;
#using script_636bd827a012af12;
#using script_7381472113d2aa0b;
#using script_7fc66d5bc7bbad87;
#using scripts\anim\battlechatter;
#using scripts\anim\shared;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ae_utility;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\stealth\event;
#using scripts\common\callbacks;
#using scripts\common\create_script_utility;
#using scripts\common\devgui;
#using scripts\common\dialogue_speaker;
#using scripts\common\math;
#using scripts\common\player_broadcasting;
#using scripts\common\save;
#using scripts\common\scriptable;
#using scripts\common\scripted_widgets;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\status_effects\status_effects;
#using scripts\common\string_messaging_util;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ammo_cache;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\ammopouch;
#using scripts\mp\armor;
#using scripts\mp\arsenal;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\cash;
#using scripts\mp\class;
#using scripts\mp\common\equipment\decoy_grenade;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\equipment\support_box;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\content_manager;
#using scripts\mp\coop;
#using scripts\mp\currency;
#using scripts\mp\damagefeedback;
#using scripts\mp\dev;
#using scripts\mp\emp_debuff;
#using scripts\mp\equipmentroundscaling;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\health_overcharge;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\mp_gameskill;
#using scripts\mp\ob\activities\ob_activity_starter;
#using scripts\mp\ob\activities\ob_objective_rewards;
#using scripts\mp\ob\ob_infils;
#using scripts\mp\ob\ob_infils_portal;
#using scripts\mp\ob\ob_skill_select;
#using scripts\mp\ob\ob_ui;
#using scripts\mp\ob\ob_upgrade_splash;
#using scripts\mp\ob\points;
#using scripts\mp\ob\systems\loot_drop;
#using scripts\mp\ob\systems\ob_achievements;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_analytics;
#using scripts\mp\ob\systems\ob_armor;
#using scripts\mp\ob\systems\ob_cheat_dvars;
#using scripts\mp\ob\systems\ob_content_manager;
#using scripts\mp\ob\systems\ob_difficulty_manager;
#using scripts\mp\ob\systems\ob_exfil;
#using scripts\mp\ob\systems\ob_exfil_trans;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\ob\systems\ob_intel;
#using scripts\mp\ob\systems\ob_item_currency;
#using scripts\mp\ob\systems\ob_laststand;
#using scripts\mp\ob\systems\ob_match_timer;
#using scripts\mp\ob\systems\ob_persist;
#using scripts\mp\ob\systems\ob_power_tier;
#using scripts\mp\ob\systems\ob_splashes;
#using scripts\mp\ob\systems\ob_stealth;
#using scripts\mp\ob\systems\ob_supply_drops;
#using scripts\mp\ob\systems\ob_tutorial_vo;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\ob\systems\weapons\ob_damage;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\outofbounds;
#using scripts\mp\overlord;
#using scripts\mp\pack_a_punch;
#using scripts\mp\parachute;
#using scripts\mp\playerlogic;
#using scripts\mp\purchasemenu;
#using scripts\mp\rank;
#using scripts\mp\scoreboard;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\mp\team_assimilation;
#using scripts\mp\telemetry_coop;
#using scripts\mp\wallbuy;
#using scripts\mp\weaponmetadata;
#using scripts\mp\weapons;

#namespace ob;

// Namespace ob
// Params 0, eflags: 0x1
// Checksum 0xb77ac4bf, Offset: 0x27de
// Size: 0x4a
function autoexec function_7cf8dacb278a2665()
{
    system::ignore( #"wallbuy" );
    
    if ( getdvarint( @"hash_457f677ce86242b1", 1 ) )
    {
        utility::registersharedfunc( #"create_script", #"correct_kvps", &function_47bf608e051b3a94 );
    }
    
    level init_afk_checks();
}

// Namespace ob
// Params 0
// Checksum 0xc83591f4, Offset: 0x2830
// Size: 0xcc7
function main()
{
    /#
        adddebugcommand( "<dev string:x24>" );
    #/
    
    get_ob_settings();
    function_43c82cf8640089c();
    setomnvar( "requires_scriptmover_ladder_checks", 1 );
    setdvarifuninitialized( @"scr_fr_strike", 1 );
    
    /#
        setdvarifuninitialized( @"hash_d9b0b583dfa242d5", -1 );
    #/
    
    setdvarifuninitialized( @"hash_efe61e5ef2327056", 0 );
    setdvarifuninitialized( @"hash_c507ccdd176eb91c", 250 );
    level.var_76e37dcc8fbd3461 = 0;
    level.var_2e19dce62d41e878 = 0;
    level.var_27a577c921d994b1 = 1;
    globallogic::init();
    globallogic::setupcallbacks();
    utility::registersharedfunc( #"vehiclespawn", #"shouldspawnvehicles", &function_5d9a305e97b31f41 );
    utility::registersharedfunc( #"player", #"hash_e67978577988fba", &function_2299ea8a7da91728 );
    utility::registersharedfunc( #"scene", #"can_skip", &function_77cc2e7dc69b921e );
    utility::registersharedfunc( #"scene", #"played", &function_39b9cb4bb7b86536 );
    utility::registersharedfunc( #"weapon", #"is_tertiary_weapon_override", &is_tertiary_weapon_override );
    utility::registersharedfunc( #"weapon", #"hash_d632d4a2fa14261c", &function_5ec16980330fc36f );
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    assert( !isdefined( level.ob ) );
    level.ob = spawnstruct();
    level.var_f7735c8a5a7ab2fe = 1;
    level.var_309f8f867be84cac = level.callbackplayerdamage;
    level.callbackplayerdamage = &callback_playerdamage;
    level.var_c998633bab11f3f8 = 1;
    level.bypassclasschoicefunc = &function_302d3d999a2ab368;
    level.modeallowmeleevehicledamage = &modeallowmeleevehicledamage;
    level.var_9cf78b20e77139e1 = getdvarint( @"hash_8bb2a144372e07d4", 0 );
    level.challengesallowed = level.playerxpenabled || getdvarint( @"force_challenges" );
    level.playerxpenabled = level.playerxpenabled && !getdvarint( @"hash_bb592538abf3a4" );
    level.weaponxpenabled = level.weaponxpenabled && !getdvarint( @"hash_bb592538abf3a4" );
    level.ondeadevent = &function_22f0ef363443df94;
    level.updategameevents = &function_4c3d35d28fd1c731;
    level.var_cfde89929188f64e = &function_f831c835efd0c8f;
    level.onarmorboxusedbyplayer = &function_6e1c0f9f9398767e;
    level.onplayerconnect = &onplayerconnect;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.onsquadeliminated = &onsquadeliminated;
    level.var_2a486bda36a2b6e1 = &squad_revive;
    level.init_item_ammo_override = &namespace_263eda46b6c7ce3f::init_ammopouch_item;
    
    if ( !getdvarint( @"hash_71f24507cb921036", 0 ) )
    {
        level.var_820a394c85bc5b35 = &ob_item_currency::init_item_currency;
    }
    
    level.dangerzoneskipequipment = 1;
    level.var_3d90777bfb7fc504 = [ "team_two_hundred" ];
    level.blockweapondrops = 1;
    level.var_76b3c0b7aff5a045 = 1;
    level.var_3e0ce9b4c749525f = 1;
    level.outbreakdata = "mp";
    zombie_boss_healthbar::init_zombie_boss_healthbar();
    level.var_e0b31e63f5a29e85 = &ob_overlord_ui_show;
    level.var_8b4ae0e9bea5384c = &function_c8e3878a15a2af2d;
    level.var_ec8e0db9b18cc122 = &function_8fde74820e858c23;
    level.var_50bffd5c74875fc0 = &is_in_dark_aether;
    level.var_87a21a3e41dc2e5d = &function_87a21a3e41dc2e5d;
    level.var_190a8d6a5539850d = &function_69dde66ec31e2d3c;
    level.var_6f6e0bbb01a6e290 = &function_404297677fd17a31;
    level.var_b60d1f50eaf8eb5 = 1;
    level.var_500bdbbdd7fd9c5e = "deaths_door_ob";
    level.var_bb767a3f16846f6a = [ "team_two_hundred", "team_hundred_ninety" ];
    level.var_bb767a3f16846f6a = arraycombineunique( level.var_bb767a3f16846f6a, level.teamnamelist );
    level.ontimelimit = &function_5f3f40175e5b2290;
    level.endgameontimelimit = level.var_bb86f77304f193c4.endgameontimelimit ?? 0;
    level.var_78b9080b72b6a9e9 = level.var_bb86f77304f193c4.var_78b9080b72b6a9e9 ?? 0;
    level.var_66836fa3819d74f5 = getdvarfloat( @"hash_6c0befc3b6955ffa", level.var_bb86f77304f193c4.var_66836fa3819d74f5 ?? 35 );
    level.var_9de2d66a20de512f = 1;
    level.var_b05cefe0c59dde7f = 1;
    
    if ( level.var_bb86f77304f193c4.var_f85e441eff15e5b9 )
    {
        level.var_2d9ba93014f6c7ac = level.var_bb86f77304f193c4.var_7027f7c71f225609;
    }
    
    if ( level.var_bb86f77304f193c4.customloadouts )
    {
        if ( isdefined( level.var_6488d1fb560a08fb ) )
        {
            level.loadout_classtable = level.var_47dbf341b5d1d5b5[ level.var_6488d1fb560a08fb ].classtable;
        }
        
        level.custom_giveloadout = &ob_story_mission_utils::function_d4b28732504a2a08;
    }
    
    level.register_battlechatter_custom_func = &function_455cb5d032a44e17;
    level.modeplayerskipdialog = &modeplayerskipdialog;
    level.throttle_dist_tracking = throttle::throttle_initialize( "dist_tracking", getdvarint( @"hash_a5863203bd890f51", 1 ) );
    level.throttle_log_starting_loadout = throttle::throttle_initialize( "log_starting_loadout", getdvarint( @"hash_7753e675e77cb21f", 1 ) );
    level.throttle_inc_rank_xp = throttle::throttle_initialize( "inc_rank_xp", getdvarint( @"hash_4261bac4ca06ff45", 1 ) );
    level.var_90854497526d85e2 = getdvarint( @"hash_38c2fc8b2e1387e8", 1 );
    
    /#
        level.var_3f907696327a5b83 = &function_2806f81fa2ea8071;
        level.var_8b324f76eefee199 = &function_2587d13c3df5255a;
        level.var_b6c6978dacab8f7b = &function_f8f455a78d742eb6;
    #/
    
    create_script_utility::initialize_create_script();
    level.outofboundstime = getdvarfloat( @"scr_outofboundstime" );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    
    if ( level.var_bb86f77304f193c4.regiondifficultyenabled )
    {
        level.var_bd706167fc97713c = &region_difficulty_manager::get_region_difficulty;
        level callback::add( "region_difficulties_registered", &function_200a0708fe5eb8c4 );
    }
    
    mp_gameskill::init_gameskill();
    level._effect[ "vfx_gameplay_tier2_helmet_pop" ] = loadfxasset( "vfx_iw9_gameplay_mp_tier2_helmet_pop" );
    level._effect[ "vfx_gameplay_tier3_helmet_pop" ] = loadfxasset( "vfx_iw9_gameplay_mp_tier3_helmet_pop" );
    level.getspawnpoint = &function_e48d80448b8e47b6;
    level.var_3aa9646314b3783c = &function_e48d80448b8e47b6;
    level.onstartgametype = &function_c0383f1863e317ec;
    level.var_4a6d258c51f26789 = 1;
    level.var_c0dd81d8b3b40fed = level.var_bb86f77304f193c4.var_c0dd81d8b3b40fed;
    level.ongrenadeused = &ongrenadeused;
    level.var_aa144e985816508e = &function_b1df1ea3cf62da44;
    level.assists_disabled = 1;
    level.var_6ecea52a1c8dd49c = [ "EXOTIC":6, "LEGENDARY":5, "EPIC":4, "RARE":3, "UNCOMMON":2, "COMMON":1, "NONE":0 ];
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    common::updatecommongametypedvars();
    function_27459deefbb3631d();
    level.var_f0d527566ff71ca9 = &ai_behavior::function_f0d527566ff71ca9;
    level thread init_ob_systems();
    callback::add( #"player_item_pickup", &on_item_pickup );
    callback::add( #"player_item_drop", &function_40d1ae0558dff795 );
    callback::add( #"hash_47152191e641a442", &function_6e36fb04b9107521 );
    callback::add( "player_region_difficulty_change", &function_5bced35dc60a673e );
    level callback::add( "smokeGrenade_playerGiveBlindeye", &function_680b224b3f0d6884 );
    level callback::add( "smokeGrenade_playerRemoveBlindeye", &function_473c5aba19ee9ce7 );
    level callback::add( "smoke_grenade_explode", &function_9ff471f79ecb7a0c );
    level callback::add( #"hash_fd05279c5637ddd8", &function_6b73b44ec7fbb517 );
    level callback::add( #"hash_6cd8138b7ddba849", &function_3721322b21535888 );
    level ui::lui_registercallback( "toggle_camera_view", &switch_camera_view );
    level ui::lui_registercallback( "rescue_token_choice", &lui_rescue_token_choice );
    setuplivingworld();
    common_instance_inventory::init();
    utility::registersharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", &ob_scriptable_set_minimap_floor );
    callback::add( #"player_spawned", &function_8f0941e4910c2d09 );
    utility::registersharedfunc( #"game", #"hash_9067d157d8b692fd", &function_c837736567972df );
    level thread function_42fdd6735ef5c60d();
    level thread ob_cheat_dvars::init();
    weapons::deregisterusedcallback( "decoy_grenade" );
    weapons::registerusedcallback( "decoy_grenade", &function_12d3e6293a73c2b );
    callback::add( "onEnterVehicle", &function_27a6341bb7cafb63 );
    level callback::callback( "ob_season_main" );
    setdvar( @"scr_ob_achievements", 0 );
    setdvar( @"bg_cinematicfullscreen", 0 );
    ob_ui::init_ob_ui();
    setdvarifuninitialized( @"scr_match_timer", 1 );
    setdvarifuninitialized( @"hash_963f5137f2da3632", 1 );
    utility::flag_wait( "dep_systems_init_complete" );
    level thread utility::callsharedfunc( #"dev", #"hash_8346b110c4eeaf2d" );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"change_suit", &function_cec07f622c5c280e );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"set_nightmare_loadout", &set_nightmare_loadout );
    ob_supply_drops::init();
    utility::flag_set( "power_on" );
    ob_cleanup();
    level callback::add( #"hash_dd3cc659d7255154", &function_cffd377194114f5a );
    level callback::add( #"player_connect", &ob_on_player_connect );
    level callback::add( #"player_disconnect", &ob_on_player_disconnect );
    level callback::add( #"grenade_fire", &ob_on_grenade_fire );
    level callback::add( #"player_aerial", &ob_on_player_aerial );
    level.var_d1e3e0e075671fee = &ob_teleport_player_in_bounds;
    
    if ( !level.var_bb86f77304f193c4.var_aab22481530ff9ff )
    {
        if ( !getdvarint( @"hash_7ec573c54effb570", 0 ) )
        {
            level ui::lui_registercallback( "scoreboard_open", &tacmap_hint_open );
            level ui::lui_registercallback( "scoreboard_close", &tacmap_hint_close );
            level callback::add( #"player_spawned", &show_tutorial );
        }
    }
    
    if ( get_forced_operators() )
    {
        utility::delaythread( level.framedurationseconds, &utility::registersharedfunc, #"instanceInventory", #"getActiveOperatorSkinLootID", &function_bd3eb5a6df1ba83c );
        utility::delaythread( level.framedurationseconds, &utility::registersharedfunc, #"instanceInventory", #"getActiveOperatorExecutionLootID", &function_858a16046dff3559 );
    }
    
    utility::registersharedfunc( #"hud", #"hash_30cfbd3bcf7e335b", &function_5999b072e034a785 );
    level utility::delaythread( level.framedurationseconds, &function_adb121e2595d57bb );
    level utility::delaythread( level.framedurationseconds, &function_3f278f1ba87e188b );
    level callback::add( #"hash_399a5fbd0e29ab64", &ob_story_mission_utils::function_f21cd61a6b760846 );
    level lui_game_event_aggregator::registeronluieventcallback( &onleavegamecallback );
    utility::registersharedfunc( #"gamemode", #"hash_c263cfe56b50336d", &function_f3ae338ffaddb320 );
    utility::registersharedfunc( #"kfe", #"get_in_radius", &function_b6a575d47f726f13 );
    utility::registersharedfunc( #"hash_707f1890c1954c56", #"get_in_radius", &function_f8de346a501c160c );
    utility::registersharedfunc( #"guild_drone", #"get_in_radius", &get_drones_in_radius );
    utility::registersharedfunc( #"ob", #"hash_cc4e2bcf7e45b223", &function_aae50a9de45f694a );
    utility::registersharedfunc( #"ob", #"get_rescue_token_balance", &get_rescue_token_balance );
    utility::registersharedfunc( #"skill", #"hash_51e6fd623b95a9a9", &function_ce69adb2648e06a8 );
    utility::create_func_ref( "anim_placeweaponon", &function_c9acc880e65f180c );
    
    if ( level.var_bb86f77304f193c4.supersdamagemultiplier )
    {
        level zombie_utils::function_dfae6a5bd222c586( &function_a6478a93b711a8f );
        level agent_utils::register_soldier_damage_callback( &function_a6478a93b711a8f );
    }
    
    if ( level.var_bb86f77304f193c4.var_47ec7221a07110ad )
    {
        level.var_fb6491c4ee5eaf0d = &function_bfe775be7afd0a53;
        level.var_8547e3f3b843ca02 = &function_f4d1a1d65c62c9bb;
    }
    
    level callback::add( #"hash_e6c52cbe24abf037", &on_vehicle_deleted );
}

// Namespace ob
// Params 3
// Checksum 0xac8a4bfb, Offset: 0x34ff
// Size: 0x5c
function function_c9acc880e65f180c( weapon, position, activeweapon )
{
    if ( isagent( self ) )
    {
        if ( position == "none" )
        {
            self.var_3ec51183ec8ac443 = self.weapon;
            self.weapon = nullweapon();
            return;
        }
        
        shared::placeweaponon( weapon, position, activeweapon );
    }
}

// Namespace ob
// Params 1
// Checksum 0xb8416514, Offset: 0x3563
// Size: 0x9e
function show_tutorial( params )
{
    self endon( #"death_or_disconnect" );
    thread show_skills_tutorial();
    utility::ent_flag_wait( "loading_done" );
    level utility::flag_wait( "ob_infil_completed" );
    
    while ( !function_6e4f382a54cdd6fe() )
    {
        waitframe();
    }
    
    val_tutorial( "zones_tutorial" );
    var_371d749e875ea931 = getdvarint( @"hash_7279874d4dd88d79", 0 );
    utility::callsharedfunc( #"hint", #"add_wait", "zones_tut_hint", 15, undefined, undefined, undefined, undefined, var_371d749e875ea931 );
    val::reset_all( "zones_tutorial" );
}

// Namespace ob
// Params 1
// Checksum 0x100856e0, Offset: 0x3609
// Size: 0x2b
function val_tutorial( label )
{
    val::set( label, "ignoreme", 1 );
    val::set( label, "damage", 0 );
}

// Namespace ob
// Params 0
// Checksum 0xa503e629, Offset: 0x363c
// Size: 0x40, Type: bool
function function_6e4f382a54cdd6fe()
{
    return ( self isonground() || self function_fbf06f80548d841d() ) && !self isswimunderwater() && !( level.var_bb86f77304f193c4.var_3d6368d667a0a3df && !self.var_4a59d674db96c66a );
}

// Namespace ob
// Params 0
// Checksum 0x693d7281, Offset: 0x3685
// Size: 0x23, Type: bool
function nightmare()
{
    var_bb86f77304f193c4 = get_ob_settings();
    return var_bb86f77304f193c4.nightmaremode ?? 0;
}

// Namespace ob
// Params 0
// Checksum 0xc6e686e8, Offset: 0x36b1
// Size: 0x12, Type: bool
function nightmare_shard()
{
    return getdvarint( @"hash_efe61e5ef2327056", 0 ) != 0;
}

// Namespace ob
// Params 0
// Checksum 0x218a4980, Offset: 0x36cc
// Size: 0x12, Type: bool
function nightmare_portal()
{
    return getdvarint( @"ob_nightmare_portal", 0 ) != 0;
}

// Namespace ob
// Params 0
// Checksum 0xa3214bba, Offset: 0x36e7
// Size: 0x47
function function_2b9dde49097a039e()
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !player.respawnitems )
    {
        respawnitems = player class::respawnitems_saveplayeritemstostruct();
        player class::respawnitems_assignrespawnitems( respawnitems );
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x1d784df0, Offset: 0x3736
// Size: 0x1c
function private function_3721322b21535888( params )
{
    if ( nightmare() )
    {
        thread ob_story_mission_utils::function_6fd9c77130917eb1();
    }
}

// Namespace ob
// Params 1, eflags: 0xc
// Checksum 0xc0e8eea2, Offset: 0x375a
// Size: 0xea
function private tacmap_hint_open( param )
{
    self notify( #"hash_ae3d918f2458f107" );
    self endon( #"hash_ae3d918f2458f107" );
    self endon( #"death_or_disconnect" );
    thread utility::callsharedfunc( #"hint", #"close", "zones_tut_hint" );
    var_371d749e875ea931 = 0;
    
    /#
        var_371d749e875ea931 = getdvarint( @"hash_7279874d4dd88d79", 0 );
    #/
    
    if ( utility::callsharedfunc( #"save", #"get_hint_seen", "hint_zones_tac_map" ) && !var_371d749e875ea931 )
    {
        return;
    }
    
    while ( !self istacmapactive() )
    {
        waitframe();
    }
    
    if ( !function_6e4f382a54cdd6fe() )
    {
        return;
    }
    
    val_tutorial( "tacmap_hint" );
    utility::callsharedfunc( #"hint", #"add_simple", "hint_zones_tac_map", &"sat_ob/hint_tac_map", undefined, undefined, undefined, undefined, undefined, var_371d749e875ea931, 1 );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xe0ac0c53, Offset: 0x384c
// Size: 0xa0
function private tacmap_hint_close( param )
{
    val::reset_all( "tacmap_hint" );
    var_371d749e875ea931 = 0;
    
    /#
        var_371d749e875ea931 = getdvarint( @"hash_7279874d4dd88d79", 0 );
    #/
    
    if ( utility::callsharedfunc( #"hint", #"get_current_hint_ref" ) != "hint_zones_tac_map" && ( !utility::callsharedfunc( #"save", #"get_hint_seen", "hint_zones_tac_map" ) || var_371d749e875ea931 ) )
    {
        return;
    }
    
    utility::callsharedfunc( #"hint", #"close", "hint_zones_tac_map" );
}

// Namespace ob
// Params 0
// Checksum 0x133b8113, Offset: 0x38f4
// Size: 0x77
function show_skills_tutorial()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"activated_ob_skill_select" );
    val_tutorial( "skills_tutorial" );
    var_371d749e875ea931 = getdvarint( @"hash_7279874d4dd88d79", 0 );
    utility::callsharedfunc( #"hint", #"add_wait", "skills_tut_hint", 15, undefined, "skills_tut_hint_complete", undefined, undefined, var_371d749e875ea931 );
    val::reset_all( "skills_tutorial" );
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x5701bb62, Offset: 0x3973
// Size: 0x247
function private function_3f278f1ba87e188b()
{
    max_count = 128;
    level.var_79b3a496addf34e1 = [];
    
    if ( level.gamemodebundle.var_760aade4663213de )
    {
        bundle = getscriptbundle( level.gamemodebundle.var_760aade4663213de );
        
        if ( bundle.cinematicslist )
        {
            foreach ( cinematic in bundle.cinematicslist )
            {
                bundle = getscriptbundle( cinematic.cinematic );
                
                if ( bundle.cinematicname )
                {
                    level.var_79b3a496addf34e1[ tolower( bundle.cinematicname ) ] = level.var_79b3a496addf34e1.size;
                }
            }
        }
    }
    
    if ( level.var_bb86f77304f193c4.var_feadb065738eedc9 )
    {
        var_94eca50ecbfc748b = max_count - 1;
        
        foreach ( ref in level.var_bb86f77304f193c4.var_feadb065738eedc9 )
        {
            if ( !isdefined( ref.hintref ) )
            {
                continue;
            }
            
            level.var_79b3a496addf34e1[ tolower( ref.hintref ) ] = var_94eca50ecbfc748b;
            var_94eca50ecbfc748b--;
        }
    }
    
    assert( level.var_79b3a496addf34e1.size < max_count );
    utility::registersharedfunc( #"cinematic", #"get_seen", &function_65b2157eb711327c );
    utility::registersharedfunc( #"cinematic", #"set_seen", &function_74584d38b8df92d0 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"reset_cinematics", &function_d936871d2ff088cb );
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xb0017a9c, Offset: 0x3bc2
// Size: 0x120
function private function_adb121e2595d57bb()
{
    if ( level.var_bb86f77304f193c4.hintrefs )
    {
        level.var_5847daec28125178 = [];
        
        foreach ( hintref in level.var_bb86f77304f193c4.hintrefs )
        {
            if ( !isdefined( hintref.hintref ) )
            {
                continue;
            }
            
            level.var_5847daec28125178[ hintref.hintref ] = level.var_5847daec28125178.size;
        }
    }
    
    utility::registersharedfunc( #"save", #"get_hint_seen", &function_aeb4e7dceebb2f7e );
    utility::registersharedfunc( #"save", #"set_hint_seen", &function_a5880170e841eeaa );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"reset_hints", &function_edcecad6b701177a );
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x3a9be350, Offset: 0x3cea
// Size: 0xbe
function private init_afk_checks()
{
    if ( game_utility_mp::matchmakinggame() || getdvarint( @"hash_14b345d46f1e9d77", 0 ) )
    {
        if ( !getdvarint( @"hash_71c6a68f6d4e36a7", 0 ) )
        {
            setdvar( @"hash_9b383028dfd6542d", 0 );
        }
        
        setdvar( @"hash_c437d843ba5aece9", 1 );
        var_d9176028b0927c0e = getdvarint( @"hash_a6a8cfe5f012e87a", int( level.gametypebundle.var_f21903a24e3d5816 ?? 0 ) );
        setdvar( @"hash_a6a8cfe5f012e87a", var_d9176028b0927c0e );
        level.var_6efaf96150acaafa = 1;
        level.var_5ab0498cf1ac995e = 1;
        level callback::add( #"hash_57a74c8771bf7e7", &dontconsiderafk );
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xab67da8b, Offset: 0x3db0
// Size: 0x16f, Type: bool
function private dontconsiderafk( params )
{
    if ( isplayer( self ) )
    {
        if ( getdvarint( @"hash_71c6a68f6d4e36a7", 0 ) || val::get( "cinematics_participant" ) && !val::get( "in_interactive_UI" ) || self iscontrolsfrozen() || !( self isconnected() && self.sessionstate == "playing" ) || self.var_da890394bac5ecb9 && self.var_da890394bac5ecb9 >= gettime() )
        {
            self.pers[ "distTrackingPassedOrResetTime" ] = mp_afk::function_a10af3f5e26c28da();
            return true;
        }
    }
    
    if ( getdvarint( @"hash_335a84b21fdcec64", 1 ) )
    {
        if ( self.pers[ "kills" ] - self.pers[ "killsSinceLastAFKCheck" ] > 0 || self.pers[ "assists" ] - self.pers[ "assistsSinceLastAFKCheck" ] > 0 )
        {
            self.pers[ "distTrackingPassedOrResetTime" ] = mp_afk::function_a10af3f5e26c28da();
            mp_afk::function_9592b6d120cfac02();
            return true;
        }
    }
    
    if ( getdvarint( @"hash_e824f683c231d5d", 1 ) )
    {
        if ( ( self iscommandinputstale() || self iscommandinputrepetitive() ) && self.sessionstate == "playing" && self isswimming() )
        {
            self.var_11fdb6c972ee0ba9 = self.origin;
        }
    }
    
    return false;
}

// Namespace ob
// Params 2, eflags: 0x4
// Checksum 0x333727a7, Offset: 0x3f28
// Size: 0x15a
function private function_f3ae338ffaddb320( origin, radius )
{
    all_killstreaks = level.activekillstreaks;
    all_vehicles = vehicle_tracking::function_5820a38c9873992e();
    all_equipment = [[ level.getactiveequipmentarray ]]();
    var_2d8c132b555d51f5 = getentarray( "misc_turret", #classname );
    all_mines = weapon::function_3aafcaf7ff6dea9e();
    all_targets = [];
    all_targets = arraycombineunique( all_targets, all_killstreaks, all_equipment, all_vehicles, var_2d8c132b555d51f5, all_mines );
    all_targets_in_radius = [];
    radius_squared = radius * radius;
    
    foreach ( target in all_targets )
    {
        if ( target.team == self.team )
        {
            continue;
        }
        
        dist = distancesquared( origin, target.origin );
        
        if ( dist <= radius_squared )
        {
            all_targets_in_radius[ all_targets_in_radius.size ] = target;
        }
    }
    
    return all_targets_in_radius;
}

// Namespace ob
// Params 3, eflags: 0x4
// Checksum 0x47fcf62, Offset: 0x408b
// Size: 0x12f
function private function_f8de346a501c160c( origin, radius, filter_options )
{
    if ( !level.ob.cysts )
    {
        return;
    }
    
    var_c478e0fa4a70aaaf = [];
    radius_squared = radius * radius;
    
    foreach ( cyst in level.ob.cysts )
    {
        if ( !cyst || !cyst.origin )
        {
            continue;
        }
        
        if ( filter_options.aliveonly && cyst.health <= 0 )
        {
            continue;
        }
        
        dist = distancesquared( origin, cyst.origin );
        
        if ( dist <= radius_squared )
        {
            var_c478e0fa4a70aaaf[ var_c478e0fa4a70aaaf.size ] = cyst;
        }
    }
    
    return var_c478e0fa4a70aaaf;
}

// Namespace ob
// Params 3, eflags: 0x4
// Checksum 0xbbfde6a5, Offset: 0x41c3
// Size: 0x102
function private get_drones_in_radius( origin, radius, filter_options )
{
    guild_drones = [];
    max_distance_squared = radius * radius;
    candidate_drones = [];
    candidate_drones = arraycombineunique( candidate_drones, level.ob.drones );
    candidate_drones = arraycombineunique( candidate_drones, level.huntdrones );
    
    foreach ( guild_drone in candidate_drones )
    {
        dist = distancesquared( origin, guild_drone.origin );
        
        if ( dist <= max_distance_squared )
        {
            guild_drones[ guild_drones.size ] = guild_drone;
        }
    }
    
    return guild_drones;
}

// Namespace ob
// Params 3, eflags: 0x4
// Checksum 0x7ea3ab01, Offset: 0x42ce
// Size: 0xf2
function private function_b6a575d47f726f13( origin, radius, filter_options )
{
    assert( filter_options.referenceentity, "<dev string:x37>" );
    candidates = filter_options.referenceentity function_f3ae338ffaddb320( origin, radius );
    
    if ( !filter_options.vehicles )
    {
        foreach ( candidate in candidates )
        {
            if ( candidate vehicle::is_vehicle() && !candidate.turrettype )
            {
                candidates = arrayremove( candidates, candidate );
            }
        }
    }
    
    return candidates;
}

// Namespace ob
// Params 0
// Checksum 0x87ad7cf4, Offset: 0x43c9
// Size: 0x83
function get_ob_settings()
{
    if ( !isdefined( level.var_bb86f77304f193c4 ) )
    {
        if ( !isdefined( level.gametypebundle ) )
        {
            level.gametypebundle = getgametypescriptbundle();
        }
        
        if ( level.gametypebundle.var_bb86f77304f193c4 )
        {
            level.var_bb86f77304f193c4 = getscriptbundle( level.gametypebundle.var_bb86f77304f193c4 );
        }
        else
        {
            level.var_bb86f77304f193c4 = getscriptbundle( %"hash_179cc1dca1a65126" );
        }
    }
    
    return level.var_bb86f77304f193c4;
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xcdae8c29, Offset: 0x4455
// Size: 0x222
function private ob_cleanup()
{
    restocklocations = getentarray( "ammo_restock_location", #targetname );
    
    foreach ( restocklocation in restocklocations )
    {
        restocklocation delete();
    }
    
    removeents = [ "gunship_interior_probe", "gunship_shadow_brush", "ks_gunship_light_only", "chopper_interior_probe" ];
    
    foreach ( removeent in removeents )
    {
        var_15893aa9c4af1935 = getentarray( removeent, #targetname );
        
        foreach ( enttoremove in var_15893aa9c4af1935 )
        {
            enttoremove delete();
        }
        
        var_15893aa9c4af1935 = getentarray( removeent, #script_noteworthy );
        
        foreach ( enttoremove in var_15893aa9c4af1935 )
        {
            enttoremove delete();
        }
    }
}

// Namespace ob
// Params 1
// Checksum 0x5967d824, Offset: 0x467f
// Size: 0x133
function function_12d3e6293a73c2b( grenade )
{
    grenade endon( #"death" );
    thread decoy_grenade::used( grenade );
    grenade waittill( #"hash_c860830af05fa677" );
    grenade.attractor = zombie_attractor_manager::add_attractor( grenade, 1, grenade.tableinfo.bundle.var_ca694ff612181976, 0, undefined, &function_a92d75a1117625fc, 0, undefined, 1 );
    grenade thread function_7de4ee6d3709aa7f();
    var_4bc2dcb755f719f6 = getaiarrayinradius( grenade.origin, grenade.tableinfo.bundle.var_ca694ff612181976 );
    
    foreach ( ai in var_4bc2dcb755f719f6 )
    {
        ai aieventlistenerevent( "decoy_grenade", grenade, grenade.origin );
    }
}

// Namespace ob
// Params 0
// Checksum 0x25abcfa6, Offset: 0x47ba
// Size: 0x2c
function function_7de4ee6d3709aa7f()
{
    self waittill( #"death" );
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
}

// Namespace ob
// Params 2
// Checksum 0x671896a1, Offset: 0x47ee
// Size: 0x26, Type: bool
function function_a92d75a1117625fc( attractor, ai )
{
    return ai.aicategory == "normal";
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x4a1387a3, Offset: 0x481d
// Size: 0xcf
function private function_42fdd6735ef5c60d()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        while ( !isdefined( level.players ) || level.players.size == 0 )
        {
            waitframe();
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_3e28e5148669b319", 0 ) == 1 )
            {
                break;
            }
            
            waitframe();
        }
        
        host = dev_mp::devfindhost();
        
        while ( true )
        {
            if ( isdefined( host ) )
            {
                host.radarmode = "fast_radar";
                host.radarshowenemydirection = 1;
                host.hasradar = 1;
                triggeroneoffradarsweep( host );
            }
            else
            {
                break;
            }
            
            if ( getdvarint( @"hash_3e28e5148669b319", 0 ) == 0 )
            {
                break;
            }
            
            wait 0.2;
        }
        
        waitframe();
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x961c5871, Offset: 0x48f4
// Size: 0x4b
function private function_69dde66ec31e2d3c( instances )
{
    spawnedinstances = instances;
    
    if ( isdefined( level.var_37ee95c5464d47be ) )
    {
        spawnedinstances = [[ level.var_37ee95c5464d47be ]]( "kiosk", instances, &common_kiosk::function_2282260e9dc07a4b );
        common_kiosk::setspawninstances( spawnedinstances );
    }
    
    return spawnedinstances;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xb7f1ac72, Offset: 0x4948
// Size: 0x11c
function private function_404297677fd17a31( instances )
{
    if ( isdefined( level.var_37ee95c5464d47be ) )
    {
        instances = [[ level.var_37ee95c5464d47be ]]( "ammo_restock", instances );
    }
    
    var_bb86f77304f193c4 = get_ob_settings();
    
    if ( isdefined( var_bb86f77304f193c4 ) && var_bb86f77304f193c4.var_49178f6e5c220274 )
    {
        scriptable::scriptable_addusedcallbackbypart( "military_ammo_restock_story", utility::getsharedfunc( #"gamemode", #"ammorestockused" ) );
        scriptables = getentitylessscriptablearray( undefined, undefined, undefined, undefined, #"military_ammo_restock_story" );
        
        foreach ( scriptable in scriptables )
        {
            function_9bebf79aee6c7add( scriptable );
            scriptable setscriptablepartstate( #"military_ammo_restock_story", #"hash_a73add30cc34d314" );
        }
    }
    
    return instances;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x4c8a8afb, Offset: 0x4a6d
// Size: 0x15
function private ob_overlord_ui_show( var_85f9b34a2668217c )
{
    dialogue_speaker::add_for_player( var_85f9b34a2668217c );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xb8c231f, Offset: 0x4a8a
// Size: 0x15
function private function_c8e3878a15a2af2d( var_8f504e21a91cd373 )
{
    dialogue_speaker::remove_for_player( var_8f504e21a91cd373 );
}

// Namespace ob
// Params 1
// Checksum 0x817826bf, Offset: 0x4aa7
// Size: 0x32
function on_item_pickup( params )
{
    if ( isdefined( params.item.var_464bcbfd685e06e0 ) )
    {
        level utility::flag_set( "act1_keycard" );
    }
}

// Namespace ob
// Params 1
// Checksum 0xfe00c493, Offset: 0x4ae1
// Size: 0xc
function function_40d1ae0558dff795( params )
{
    
}

// Namespace ob
// Params 1
// Checksum 0xbdc7f8d4, Offset: 0x4af5
// Size: 0x20
function function_5ec16980330fc36f( weaponobj )
{
    return issubstr( weaponobj.basename, "exotic" );
}

// Namespace ob
// Params 1
// Checksum 0xf4ef2773, Offset: 0x4b1e
// Size: 0x59, Type: bool
function function_6e36fb04b9107521( params )
{
    return function_5ec16980330fc36f( params.newweapon ) && function_5ec16980330fc36f( params.oldweapon ) && weapon::function_6b74ecd475e99b4( params.newweapon ) == weapon::function_6b74ecd475e99b4( params.oldweapon );
}

// Namespace ob
// Params 1
// Checksum 0x8471b03f, Offset: 0x4b80
// Size: 0x3f, Type: bool
function modeplayerskipdialog( dialog )
{
    if ( dialog == "offense_obj" || dialog == "mission_draw" || dialog == "mission_success" || dialog == "mission_failure" )
    {
        return true;
    }
    
    return false;
}

// Namespace ob
// Params 0
// Checksum 0x2c2ed5dc, Offset: 0x4bc8
// Size: 0x7b
function function_455cb5d032a44e17()
{
    level.var_97d7c13d242bcb15 = &function_8fe9049f28859154;
    level.var_2400b422ed778f5 = &function_369904628de4af46;
    callback::add( "on_zombie_ai_killed", &ob_battlechatter_ai_killed );
    callback::add( #"player_item_pickup", &ob_battlechatter_item_pickup );
    callback::add( "magicbox_purchase", &ob_battlechatter_magicbox_purchase );
    callback::add( "on_exfil_start", &ob_battlechatter_exfil_start );
    callback::add( #"player_vehicle_enter", &ob_battlechatter_vehicle_enter );
}

// Namespace ob
// Params 1
// Checksum 0x93d937b5, Offset: 0x4c4b
// Size: 0x70
function ob_battlechatter_vehicle_enter( params )
{
    if ( params.seatid == "driver" )
    {
        if ( params.vehicle vehicle::ishelicopter() || params.vehicle vehicle::can_fly() )
        {
            level thread battlechatter_mp::trysaylocalsound( self, #"hash_7f9cb44aa4541be7" );
            return;
        }
        
        level thread battlechatter_mp::trysaylocalsound( self, #"hash_6cf4b973d23bd8ba" );
    }
}

// Namespace ob
// Params 1
// Checksum 0xae547750, Offset: 0x4cc3
// Size: 0x3a
function ob_battlechatter_exfil_start( params )
{
    if ( isplayer( params.var_5a5626a7d4b2feb ) )
    {
        level thread battlechatter_mp::trysaylocalsound( params.var_5a5626a7d4b2feb, #"hash_b39b603ba5e4e6ef" );
    }
}

// Namespace ob
// Params 1
// Checksum 0x3eaa1fe4, Offset: 0x4d05
// Size: 0x54
function ob_battlechatter_magicbox_purchase( params )
{
    if ( ( utility::cointoss() || getdvarint( @"hash_554f88d64e501ed2", 0 ) ) && common_item::function_16e8c106491eeaca( params.itembundle ) == "killstreak" )
    {
        level thread battlechatter_mp::trysaylocalsound( self, #"hash_a30a3abc55466355" );
    }
}

// Namespace ob
// Params 1
// Checksum 0x89d2e209, Offset: 0x4d61
// Size: 0x54
function ob_battlechatter_item_pickup( params )
{
    if ( ( utility::cointoss() || getdvarint( @"hash_554f88d64e501ed2", 0 ) ) && common_item::function_16e8c106491eeaca( params.itembundle ) == "killstreak" )
    {
        level thread battlechatter_mp::trysaylocalsound( self, #"hash_a30a3abc55466355" );
    }
}

// Namespace ob
// Params 2
// Checksum 0x78b61630, Offset: 0x4dbd
// Size: 0x430
function function_8fe9049f28859154( var_25d80124122c8304, pingindex )
{
    if ( isdefined( var_25d80124122c8304 ) )
    {
        var_8f61757e9d1e9a0e = var_25d80124122c8304.type ?? var_25d80124122c8304.model;
    }
    
    var_6675b0888e2dbc2 = self function_689a4266a29aac13( pingindex );
    
    if ( function_4c1b7cae739d9840( var_6675b0888e2dbc2 ) )
    {
        /#
            iprintln( "<dev string:x78>" );
        #/
        
        itembundlename = common_item::function_33a2c00e46263d99( var_25d80124122c8304 );
        
        if ( isdefined( itembundlename ) )
        {
            if ( issubstr( var_8f61757e9d1e9a0e, "contract_starter" ) )
            {
                return %"ping_objective_spotted_generic";
            }
            
            itembundle = getscriptbundle( itembundlename );
            
            if ( isdefined( itembundle.pingvo ) )
            {
                return itembundle.pingvo;
            }
        }
        
        if ( var_8f61757e9d1e9a0e == "guild_ammo_restock_model" )
        {
            return %"ping_ammo_cache";
        }
        
        if ( var_8f61757e9d1e9a0e == "sat_ob_activity_vtol_boss_laptop_marker" || var_8f61757e9d1e9a0e == "sat_wc_poi_boss_objective_marker_scriptable" )
        {
            return %"hash_6bd05c32d9c01291";
        }
        
        if ( issubstr( var_8f61757e9d1e9a0e, "sat_ob_activity" ) || issubstr( var_8f61757e9d1e9a0e, "objective_marker" ) || var_8f61757e9d1e9a0e == "ob_cradle_vent" || var_8f61757e9d1e9a0e == "ob_safecrack_safe_hackable" || var_8f61757e9d1e9a0e == "sat_ob_prime_target_marker_scriptable" || var_8f61757e9d1e9a0e == "sat_ob_flight_school_portal" || var_8f61757e9d1e9a0e == "sat_ob_supply_drop_computer_station" )
        {
            return %"ping_objective_spotted_generic";
        }
        
        if ( issubstr( var_8f61757e9d1e9a0e, "jailbreak_machine" ) )
        {
            return %"ping_objective_spotted_generic";
        }
        
        if ( issubstr( var_8f61757e9d1e9a0e, "sat_ob_exfil_site" ) )
        {
            return %"ping_objective_spotted_generic";
        }
        
        if ( issubstr( var_8f61757e9d1e9a0e, "scriptable_juggerbot" ) )
        {
            if ( var_25d80124122c8304.entity.team != self.team )
            {
                return %"bc_killstreak_incoming_jugg";
            }
        }
        
        var_6b36812269920859 = function_402ca439bbef017b( var_6675b0888e2dbc2 );
        
        if ( var_6b36812269920859 )
        {
            return var_6b36812269920859;
        }
        else if ( issubstr( var_8f61757e9d1e9a0e, "redeploy_drone" ) )
        {
            return %"ping_loot_equipment_redeploydrone";
        }
        else if ( issubstr( var_8f61757e9d1e9a0e, "intel" ) )
        {
            return %"ping_intel";
        }
    }
    else if ( function_4095a4f8e53eb368( var_6675b0888e2dbc2 ) )
    {
        /#
            iprintln( "<dev string:xa0>" );
        #/
        
        if ( var_25d80124122c8304.subclass == "dawg" )
        {
            if ( var_25d80124122c8304.activity_instance.type == "REV_OB_ESCORT_DAWG" )
            {
                return %"ping_objective_spotted_generic";
            }
            
            if ( var_25d80124122c8304.team == self.team )
            {
                return #"hash_fe627f96d984fd11";
            }
            
            return %"bc_killstreak_incoming_dawg";
        }
        
        if ( issubstr( var_8f61757e9d1e9a0e, "sentry_turret_ob" ) )
        {
            if ( var_25d80124122c8304.team == self.team )
            {
                return #"hash_fe627f96d984fd11";
            }
            
            return %"bc_killstreak_incoming_sentry";
        }
        
        if ( issubstr( var_8f61757e9d1e9a0e, "vtol" ) )
        {
            if ( var_25d80124122c8304.targetname == "veh_sat_mil_vtol_ob_exfil" )
            {
                return %"ping_exfil_vtol";
            }
            
            if ( isdefined( var_25d80124122c8304.activityinstance.type ) )
            {
                switch ( var_25d80124122c8304.activityinstance.type )
                {
                    case #"hash_5ae5c8c9e5f0949e":
                    case #"hash_c787e75163d79f13":
                    case #"hash_d04841f4b6f4de1f":
                        return %"bc_killstreak_incoming_vtol_warship";
                    default:
                        break;
                }
            }
        }
    }
    
    var_252c12c7dd0debc9 = self calloutmarkerping_getgscobjectiveindex( pingindex );
    
    if ( isdefined( var_252c12c7dd0debc9 ) && var_252c12c7dd0debc9 != -1 )
    {
        objimage = objective_geticon( var_252c12c7dd0debc9 );
        
        if ( isdefined( objimage ) )
        {
            switch ( objimage )
            {
                case #"hash_bc7c8368320949a":
                case #"hash_99f2853347e1f624":
                case #"hash_cb5c7780d03d379a":
                case #"hash_cd3c20633235b051":
                case #"hash_d5c729eaa1ade458":
                case #"hash_deb3670b13c2c04a":
                    return %"ping_objective_spotted_generic";
                case #"hash_fc6ed4f92b07e09":
                case #"hash_1b92a43638211ed6":
                    return %"hash_6bd05c32d9c01291";
                default:
                    break;
            }
        }
    }
}

// Namespace ob
// Params 1
// Checksum 0xf1a83df0, Offset: 0x51f6
// Size: 0x64
function function_369904628de4af46( lootid )
{
    lootinfo = getlootiteminfofromid( lootid );
    itemsb = "calloutmarkerpingitem:" + lootinfo.itemref;
    calloutmarkerpingitem = getscriptbundle( itemsb );
    
    if ( isdefined( calloutmarkerpingitem.var_5eda534db5470a3a ) )
    {
        return calloutmarkerpingitem.var_5eda534db5470a3a;
    }
}

// Namespace ob
// Params 1
// Checksum 0x9b48e6d3, Offset: 0x5263
// Size: 0x133
function ob_battlechatter_ai_killed( params )
{
    playerattacker = params.eattacker;
    
    if ( isdefined( playerattacker ) && !isplayer( playerattacker ) && isplayer( playerattacker.owner ) )
    {
        playerattacker = playerattacker.owner;
    }
    
    if ( isplayer( playerattacker ) )
    {
        if ( isdefined( self.aicategory ) )
        {
            switch ( self.aicategory )
            {
                case #"hash_7b0e2f2ed84f34":
                case #"hash_4e47eb6c32f5b165":
                case #"hash_8c089e813083e510":
                    if ( utility::percent_chance( 25 ) || getdvarint( @"hash_554f88d64e501ed2", 0 ) )
                    {
                        level thread battlechatter_mp::trysaylocalsound( playerattacker, #"hash_f32d3ee94cbf425d" );
                    }
                    
                    break;
                case #"hash_7e8a002ed096276c":
                    level thread battlechatter_mp::trysaylocalsound( playerattacker, #"hash_f32d3ee94cbf425d" );
                    break;
                default:
                    if ( utility::percent_chance( 5 ) || getdvarint( @"hash_554f88d64e501ed2", 0 ) )
                    {
                        level thread battlechatter_mp::trysaylocalsound( playerattacker, #"bc_general_kill_zombie_generic" );
                    }
                    
                    break;
            }
        }
    }
}

// Namespace ob
// Params 0
// Checksum 0xb19e1455, Offset: 0x539e
// Size: 0xf0
function function_c45ecde154a303bb()
{
    var_a604a2ef0cc02f4e = [ "default" ];
    var_7a8f196a38b61ed3 = [ "mp_jup_bigmap", "mp_jup_st_a", "mp_jup_st_b", "mp_jup_st_c", "mp_jup_st_d", "mp_jup_st_e", "mp_jup_st_f", "mp_jup_st_g", "mp_jup_st_h", "mp_jup_st_i", "mp_jup_resort_gw", "mp_jup_gw_fallout", "mp_jup_st_c_gw" ];
    mapname = game_utility::getmapname();
    is_safe_map = arraycontains( var_7a8f196a38b61ed3, mapname );
    
    if ( is_safe_map )
    {
        var_a604a2ef0cc02f4e = [ "none", "default", "exterior", "partcover", "dyn_interior" ];
    }
    
    return var_a604a2ef0cc02f4e;
}

// Namespace ob
// Params 0
// Checksum 0xdbcfe675, Offset: 0x5497
// Size: 0x89
function init_ob_audio()
{
    wait 1;
    var_a604a2ef0cc02f4e = function_c45ecde154a303bb();
    
    foreach ( var_1d0e6a04f8bf5109 in var_a604a2ef0cc02f4e )
    {
        if ( var_1d0e6a04f8bf5109 != "none" )
        {
        }
    }
}

// Namespace ob
// Params 0
// Checksum 0x1bb8de01, Offset: 0x5528
// Size: 0x9c
function init_ob_match_timer()
{
    waitframe();
    flags::gameflagwait( "prematch_done" );
    
    if ( level.var_bb86f77304f193c4.var_3d6368d667a0a3df )
    {
        utility::flag_wait( "ob_infil_completed" );
        var_4ad262d95bf84e44 = gettime();
    }
    
    if ( level.var_bb86f77304f193c4.var_e5ecfe4bb09ccc28 > 0 )
    {
        wait level.var_bb86f77304f193c4.var_e5ecfe4bb09ccc28;
        var_4ad262d95bf84e44 = gettime();
    }
    
    if ( isdefined( var_4ad262d95bf84e44 ) )
    {
        level.starttime = var_4ad262d95bf84e44;
    }
    
    level function_dc06e1059093b7ea();
    level thread init_ob_match_timer_monitor();
    level thread function_da5d81773c9a0c63();
}

// Namespace ob
// Params 0, eflags: 0xc
// Checksum 0xa8bc5d64, Offset: 0x55cc
// Size: 0x238
function private init_ob_match_timer_monitor()
{
    self notify( #"hash_72456d7ff6f8067d" );
    self endon( #"hash_72456d7ff6f8067d" );
    level endon( #"game_ended" );
    ob_match_timer::function_911122e50c8bdf4d( 0 );
    
    if ( !level.timelimit )
    {
        level.timelimit = int( game_utility_mp::function_82e3606d184524fe() );
    }
    
    var_dd79395dbfbe4824 = 0;
    
    if ( level.ob_overtime_settings )
    {
        ob_overtime_time = level.ob_overtime_settings.overtime_time;
    }
    
    ob_overtime_time_ms = getdvarint( @"scr_ob_overtime_time", ob_overtime_time ?? 0 ) * 1000;
    
    while ( true )
    {
        var_912ac16dee9651d9 = getdvarint( @"scr_match_timer", 1 ) && level.timelimit > 0 && ( level.var_bb86f77304f193c4.var_a8d204ef2aca288b ?? 0 );
        match_duration_ms = int( level.timelimit ) * 1000;
        var_81be8b5a673cab1c = ( level.var_bb86f77304f193c4.var_a8d204ef2aca288b ?? 0 ) * 1000;
        level.var_aa651267740d4cb1 = level.starttime + match_duration_ms - ob_overtime_time_ms;
        remainingtimems = int( max( 0, level.var_aa651267740d4cb1 - gettime() ) );
        var_1fc364b674098b44 = var_912ac16dee9651d9 && remainingtimems <= var_81be8b5a673cab1c ? level.var_aa651267740d4cb1 : 0;
        
        if ( var_dd79395dbfbe4824 != var_1fc364b674098b44 && !ob_match_timer::function_77e7abcf06d7183b() )
        {
            ob_match_timer::function_911122e50c8bdf4d( var_1fc364b674098b44 );
            var_dd79395dbfbe4824 = var_1fc364b674098b44;
            setomnvar( "ui_pvp_countdown_state", 1 );
            level notify( #"set_br_circle_redflash_timer" );
            var_223d843cc0f931f8 = ( remainingtimems - 60000 ) / 1000;
            
            if ( var_223d843cc0f931f8 > 0 )
            {
                thread utility::delaythreadendon( var_223d843cc0f931f8, "set_br_circle_redflash_timer", &set_omnvar_thread, "ui_br_circle_state", 9 );
            }
            else
            {
                set_omnvar_thread( "ui_br_circle_state", 9 );
            }
        }
        
        waittime = max( level.framedurationseconds, ( remainingtimems - var_81be8b5a673cab1c ) / 1000 );
        level utility::waittill_any_timeout( waittime, "scr_devchangetimelimit" );
    }
}

// Namespace ob
// Params 2, eflags: 0x4
// Checksum 0xecd06765, Offset: 0x580c
// Size: 0x1d
function private set_omnvar_thread( omnvarname, value )
{
    setomnvar( omnvarname, value );
}

// Namespace ob
// Params 0, eflags: 0xc
// Checksum 0x9a447920, Offset: 0x5831
// Size: 0x21c
function private function_da5d81773c9a0c63()
{
    self notify( #"hash_5cdb9a29fea9394b" );
    self endon( #"hash_5cdb9a29fea9394b" );
    level endon( #"game_ended" );
    var_d1e1db238cd8639e = [];
    var_d8509ce0379e778c = 0;
    
    while ( level.endgameontimelimit )
    {
        var_b3263e84e5ab8645 = getdvarint( @"hash_963f5137f2da3632", 1 );
        
        if ( var_d8509ce0379e778c != level.var_aa651267740d4cb1 )
        {
            var_5ad2931b7eff3935 = ( level.var_aa651267740d4cb1 - gettime() ) / 1000;
            
            for ( i = 0; i < level.var_2d9ba93014f6c7ac.size ; i++ )
            {
                if ( var_5ad2931b7eff3935 > level.var_2d9ba93014f6c7ac[ i ].var_bc152547c76d56df )
                {
                    var_d1e1db238cd8639e[ i ] = undefined;
                    continue;
                }
                
                var_d1e1db238cd8639e[ i ] = 1;
            }
        }
        
        var_d8509ce0379e778c = level.var_aa651267740d4cb1;
        remainingtime = ( var_d8509ce0379e778c - gettime() ) / 1000;
        
        if ( level.endgameontimelimit && remainingtime <= 0 && level.timelimit > 0 )
        {
            ob_match_timer::function_911122e50c8bdf4d( 0 );
            level thread begin_overtime();
            break;
        }
        
        for ( ikey = level.var_2d9ba93014f6c7ac.size - 1; ikey >= 0 ; ikey-- )
        {
            var_c16c6e0c5ccc25d7 = level.var_2d9ba93014f6c7ac[ ikey ];
            
            if ( var_d1e1db238cd8639e[ ikey ] )
            {
                break;
            }
            
            if ( var_b3263e84e5ab8645 && remainingtime <= var_c16c6e0c5ccc25d7.var_bc152547c76d56df + 1 )
            {
                if ( var_c16c6e0c5ccc25d7.splashref )
                {
                    hud_util::showsplashtoall( var_c16c6e0c5ccc25d7.splashref );
                }
                
                if ( var_c16c6e0c5ccc25d7.var_2f2cce0aee532740 )
                {
                    overlord::playevent( var_c16c6e0c5ccc25d7.var_2f2cce0aee532740, level.players, undefined, undefined, 1 );
                }
                
                level callback::callback( var_c16c6e0c5ccc25d7.var_bc152547c76d56df + "_seconds_to_end" );
                var_d1e1db238cd8639e[ ikey ] = 1;
            }
        }
        
        if ( level.endgameontimelimit && remainingtime < 1 )
        {
            waitframe();
            continue;
        }
        
        wait 0.5;
    }
}

// Namespace ob
// Params 1
// Checksum 0xd495d46a, Offset: 0x5a55
// Size: 0xfa
function function_5bced35dc60a673e( params )
{
    if ( isdefined( params.player ) && level.mapname == "mp_sat_lm_avalon_ob" )
    {
        if ( isdefined( params.new_difficulty ) )
        {
            switch ( params.new_difficulty )
            {
                case #"hash_5343b465e56ec9a4":
                case #"hash_651f76c0ad6741ec":
                case #"hash_c0250ffc2e87f2ff":
                case #"hash_c02510fc2e87f492":
                    state = "cradle";
                    break;
                case #"hash_7bb2cd766703d463":
                case #"hash_af83e47edfa8900a":
                default:
                    state = "";
                    break;
            }
        }
        
        if ( state != "" )
        {
            function_89182a274183f293( state, state, params.player );
            return;
        }
        
        function_89182a274183f293( "cradle", state, params.player );
    }
}

// Namespace ob
// Params 0
// Checksum 0x8b40d524, Offset: 0x5b57
// Size: 0x404
function init_ob_systems()
{
    /#
        level thread function_f453e1a575874d6e();
    #/
    
    level.var_f567e74fce4a6b8a = 1;
    level thread ob_analytics::init_ob_analytics();
    level thread init_ob_audio();
    level.ammo_mods_in_use = 1;
    level.zombie_augments_in_use = 1;
    level.zombie_perks_in_use = 1;
    ammo_mod::init_ammo_mod();
    level.vending_machines_powered_on_at_start = 1;
    scriptable::scriptable_addusedcallback( &function_b9a6acd0d6a237e5 );
    
    if ( getdvarint( @"hash_71f24507cb921036", 0 ) )
    {
        currency::register_currency_type( #"cash", undefined, &set_plunder_count );
    }
    else
    {
        currency::register_currency_type( #"essence", &points::ob_get_points, &points::function_5ec07217e48081ca, &points::ob_add_points, &points::function_da2d936f7db411e1, "ui_zm_core_purchase_success", "ui_zm_core_purchase_deny" );
        currency::register_currency_type( #"power_shard", &points::ob_get_points, &points::function_5ec07217e48081ca, &points::ob_add_points, &points::function_da2d936f7db411e1, "ui_zm_core_purchase_success", "ui_zm_core_purchase_deny" );
    }
    
    currency::init_currency();
    points::init();
    purchasemenu::init();
    field_upgrades::init( 0 );
    
    if ( level.var_bb86f77304f193c4.var_4b02304772b4b6ef )
    {
        parachute::initparachutedvars();
    }
    
    namespace_775af9b7afedb6d1::init_scaling_health( 3 );
    namespace_ce77b5e0fc016a5a::init_scaling_damage();
    health_overcharge::init_health_overcharge();
    ob_laststand::init_ob_laststand();
    zombie_health_bar::init_zombie_health_bar( createentitytypemask( [ "etype_player", "etype_ai", "etype_vehicle", "etype_turret", "etype_scriptmover" ] ) );
    level._effect[ "vfx_sat_spawner_zombie_base_ob_harrow_spawn_in" ] = loadfxasset( "vfx_t10_levels_sp_interrogation_itn_mndstm_harrow_bamf_01" );
    level._effect[ "vfx_sat_spawner_zombie_base_ob_harrow_spawn_out" ] = loadfxasset( "vfx_t10_levels_sp_interrogation_itn_mndstm_harrow_bamf_02" );
    level._effect[ "vfx_sat_spawner_zombie_base_ob_harrow_death" ] = loadfxasset( "vfx_t10_levels_sp_interrogation_itn_mndstm_imp_med_glass_shard_fatal_01" );
    callback::add( "on_zombie_ai_spawned", &function_24bb5c2aa0708efb );
    callback::add( "on_zombie_ai_killed", &function_ef109129414097fb );
    level.armoronweaponswitchlongpress = 1;
    ob_armor::function_2d66dd9e5865a2ac();
    namespace_263eda46b6c7ce3f::function_9e771b5cabdaeaea();
    weaponmetadata::init_weaponmetadata();
    level.var_c42dd935c4b19dde = &function_f21ae3809399440;
    
    if ( level.var_bb86f77304f193c4.var_463b243f0fbd7481 )
    {
        assertmsg( "<dev string:xc4>" );
    }
    
    namespace_f2445a4de17ee25::init_ob_damage();
    namespace_35d7a88a59082733::function_40d09bcb6ac535a();
    events::function_b8b24a291af69f1d();
    init_ob_squads();
    init_ob_loadouts();
    init_ob_dvars();
    init_ob_omnvars();
    status_effects::function_36719164038cc9ce();
    init_vehicles();
    utility::registersharedfunc( #"ai", #"hash_28d452ebde67664b", &function_3262713c75e61f18 );
    function_1a70fdeabb0f7b6d();
    utility::registersharedfunc( #"ai", #"getpowertier", &get_ai_power_tier );
    utility::registersharedfunc( #"ai", #"hash_e2521119339c3814", &function_6b5ab24a78d837b8 );
    analytics::init();
    namespace_e20cdf6ea1d9f830::init();
    
    if ( !isdefined( level.is_quest_story_mission ) && !is_in_dark_aether() )
    {
        ob_tutorial_vo::init();
    }
    
    /#
        namespace_4e066437f254875b::init();
    #/
    
    callback::add( #"player_connect", &function_1c077eb1ecd1777e );
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( #"hash_cc06eb1d45f33a0c", &function_37904b06ac0bfaf1 );
    callback::add( #"player_disconnect", &on_disconnect );
    callback::add( #"hash_5e4592c44a328e44", &function_838f150fa7e375ad );
    level.onplayerkilled = &on_player_killed;
    
    if ( level.var_bb86f77304f193c4.regiondifficultyenabled )
    {
        utility::registersharedfunc( #"game", #"roundNumberDifficulty", &ob_round_number_difficulty );
    }
    
    utility::registersharedfunc( #"game", #"hash_9b0dc89d7217eab6", &game_utility::gettimepassed );
    utility::flag_set( "ob_systems_init_complete" );
    content_manager::init_content_manager();
    waitframe();
    function_ed3e11cc7f763ee4();
    utility::flag_set( "dep_systems_init_complete" );
}

// Namespace ob
// Params 0
// Checksum 0x668069fb, Offset: 0x5f63
// Size: 0x9c
function function_ed3e11cc7f763ee4()
{
    thread init_ai_director();
    init_ob_threatbias();
    thread namespace_6280c51a6036a58a::ob_humans_init();
    thread namespace_fa5f8e222758b3bb::init_ob_stealth();
    thread namespace_2745d12b842cc671::init();
    thread init_ob_match_timer();
    flags::gameflaginit( "br_ready_to_jump", 0 );
    namespace_60b91e84a69cf1cc::init_loot_drops();
    ob_activity_starter::init_activity_starter();
    namespace_f2445a4de17ee25::function_7ffefdc47a564d4c();
    level thread function_5c4abaa0d060e64c();
    
    if ( level.gametypebundle.var_879f04b0b8155388 ?? 1 )
    {
        arsenal::init_arsenal();
    }
    
    ammo_cache::init_ammo_cache( "ammocache:zm_ammo_cache" );
    
    if ( level.ob_snowball_init )
    {
        [[ level.ob_snowball_init ]]();
    }
}

// Namespace ob
// Params 0
// Checksum 0xbffbac7c, Offset: 0x6007
// Size: 0xb8
function init_ai_director()
{
    utility::flag_wait( "ai_spawn_director_initialized" );
    utility::flag_wait( "create_script_initialized" );
    waitframe();
    level.default_goalradius = 2048;
    level callback::add( "region_difficulties_registered", &function_da3837eda9123641 );
    function_da3837eda9123641();
    
    /#
        level thread function_19b5ec86c504956b();
    #/
    
    ai_spawn_director::process_create_script();
    ai_spawn_director::function_ce4d6b81417e3b34();
    thread ai_spawn_director::function_dee86930a11f3d9e();
    
    if ( level.var_bb86f77304f193c4.var_178ff8fb207ff859 )
    {
        ai_spawn_director::function_bb42c0a4dc530693( &function_b1cf36b00525f1ab );
        function_dba9fa2322a36bc4();
    }
    
    if ( !level.var_bb86f77304f193c4.var_49178f6e5c220274 )
    {
        function_a25acb62ddab20e2( "aftermath", 1 );
    }
    
    utility::flag_set( "ob_merc_ambients_initialized" );
}

// Namespace ob
// Params 0
// Checksum 0xe66196f8, Offset: 0x60c7
// Size: 0x146
function function_da3837eda9123641()
{
    if ( isdefined( level.var_bb131187d6741752 ) )
    {
        zones = function_439821f7c1510694();
        
        foreach ( zone in zones )
        {
            checkpoint = zone.midpoint + ( 0, 0, 100 );
            difficulty = [[ level.var_bb131187d6741752 ]]( checkpoint );
            
            if ( isdefined( difficulty ) && difficulty != "difficulty_undefined" )
            {
                function_2a814d41ec6b9609( zone.zoneindex, difficulty, 1 );
                
                if ( getdvarint( @"hash_3e3abf5eda87eba6", 0 ) == 1 )
                {
                    assert( isdefined( level.var_2f699c8203773173 ) );
                    region = [[ level.var_2f699c8203773173 ]]( checkpoint );
                    
                    if ( isdefined( region ) )
                    {
                        function_2a814d41ec6b9609( zone.zoneindex, region.name, 1 );
                    }
                }
            }
        }
    }
}

/#

    // Namespace ob
    // Params 0, eflags: 0x4
    // Checksum 0xfbd0c0d3, Offset: 0x6215
    // Size: 0x54, Type: dev
    function private function_19b5ec86c504956b()
    {
        var_a5b0e65e7b78ad29 = getdvarint( @"scr_region_difficulty", 0 );
        
        while ( true )
        {
            wait 2;
            var_858a207e9e859736 = getdvarint( @"scr_region_difficulty", 0 );
            
            if ( var_858a207e9e859736 != var_a5b0e65e7b78ad29 )
            {
                var_a5b0e65e7b78ad29 = var_858a207e9e859736;
                function_da3837eda9123641();
            }
        }
    }

#/

// Namespace ob
// Params 2
// Checksum 0xb40bb8cc, Offset: 0x6271
// Size: 0x1ca
function function_fef95c2d95cbeb8( zoneindex, subzones )
{
    if ( isdefined( level.var_bb131187d6741752 ) )
    {
        foreach ( subzone in subzones )
        {
            checkpoint = subzone.midpoint + ( 0, 0, 100 );
            difficulty = [[ level.var_bb131187d6741752 ]]( checkpoint );
            
            if ( isdefined( difficulty ) && difficulty != "difficulty_undefined" )
            {
                function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, difficulty, 1 );
            }
            
            b_ambient_zombie = 1;
            
            foreach ( region in level.var_1ce1e4cbc9d171f5 )
            {
                if ( ispointinvolume( checkpoint, region ) )
                {
                    b_ambient_zombie = 0;
                }
            }
            
            if ( b_ambient_zombie )
            {
                function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, "ob_zombie_ambient", 1 );
                function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, "ob_zombie_encounter_dense", 1 );
                continue;
            }
            
            function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, "ob_merc_ambient", 1 );
        }
    }
}

// Namespace ob
// Params 0
// Checksum 0x65e4ef5e, Offset: 0x6443
// Size: 0x3c7
function function_41864428efa58008()
{
    if ( getdvarint( @"hash_4ccbbd355da5f0d", 0 ) == 1 )
    {
        function_a25acb62ddab20e2( "ob_zombie_ambient_waves", 1 );
    }
    
    if ( getdvarint( @"hash_2f3e35c3ad3a0cf7", 0 ) == 0 )
    {
        function_a25acb62ddab20e2( "ob_zombie_encounter_dense", 1 );
        return;
    }
    
    tuningprefix = "ob_zombie_biome_";
    encounterprefix = "ob_zombie_encounter_";
    var_ddaffdfa5b623237 = utility::getstructarray( "ai_biome_struct", "targetname" );
    zones = function_439821f7c1510694();
    
    foreach ( var_b4805f22c7e43fda in var_ddaffdfa5b623237 )
    {
        if ( isdefined( var_b4805f22c7e43fda.radius ) && isdefined( var_b4805f22c7e43fda.script_noteworthy ) )
        {
            zones_in_radius = function_92feb781f39c229( var_b4805f22c7e43fda.origin, var_b4805f22c7e43fda.radius );
            
            foreach ( zone in zones_in_radius )
            {
                function_2a814d41ec6b9609( zone.zoneindex, tuningprefix + var_b4805f22c7e43fda.script_noteworthy, 1 );
            }
            
            var_9aefa2f0cf41c2ca = function_99a5f7bfb440cb49( var_b4805f22c7e43fda.origin, var_b4805f22c7e43fda.radius );
            
            foreach ( subzone in var_9aefa2f0cf41c2ca )
            {
                function_5866063fb64cf1a9( subzone.zoneindex, subzone.subzoneindex, encounterprefix + var_b4805f22c7e43fda.script_noteworthy, 1 );
            }
        }
    }
    
    foreach ( zone in zones )
    {
        if ( !function_e932f2aa37f3247d( zone.zoneindex, tuningprefix + "dense" ) )
        {
            function_2a814d41ec6b9609( zone.zoneindex, tuningprefix + "light", 1 );
        }
        
        var_6fc05153254295d2 = function_6978793539ff1cb4( zone.zoneindex );
        
        foreach ( subzone in var_6fc05153254295d2 )
        {
            if ( !function_3e3bdb7fe0cb3e8d( subzone.zoneindex, subzone.subzoneindex, encounterprefix + "dense" ) )
            {
                function_5866063fb64cf1a9( subzone.zoneindex, subzone.subzoneindex, encounterprefix + "light", 1 );
            }
        }
    }
}

// Namespace ob
// Params 2
// Checksum 0xc9b2ed7d, Offset: 0x6812
// Size: 0x201
function function_b1cf36b00525f1ab( zoneindex, subzones )
{
    if ( isdefined( level.var_bb131187d6741752 ) )
    {
        foreach ( subzone in subzones )
        {
            checkpoint = subzone.midpoint + ( 0, 0, 100 );
            difficulty = [[ level.var_bb131187d6741752 ]]( checkpoint );
            
            if ( isdefined( difficulty ) && difficulty != "difficulty_undefined" )
            {
                function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, difficulty, 1 );
            }
            
            if ( getdvarint( @"hash_466d098eed7d3d9f", 0 ) )
            {
                foreach ( subzone in subzones )
                {
                    if ( subzone.var_20d6d0656474ee79 )
                    {
                        function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, "ob_zombie_ambient", 0 );
                        function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, "ob_zombie_encounter_dense", 0 );
                        function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, "ob_merc_ambient", 1 );
                        continue;
                    }
                    
                    function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, "ob_zombie_ambient", 1 );
                    function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, "ob_zombie_encounter_dense", 1 );
                    function_5866063fb64cf1a9( zoneindex, subzone.subzoneindex, "ob_merc_ambient", 0 );
                }
            }
        }
    }
}

// Namespace ob
// Params 0
// Checksum 0x37cfc605, Offset: 0x6a1b
// Size: 0x280
function function_dba9fa2322a36bc4()
{
    zones = function_439821f7c1510694();
    
    foreach ( zone in zones )
    {
        if ( !getdvarint( @"hash_466d098eed7d3d9f", 0 ) )
        {
            if ( zone.var_20d6d0656474ee79 )
            {
                function_2a814d41ec6b9609( zone.zoneindex, "ob_zombie_ambient", 0 );
                function_2a814d41ec6b9609( zone.zoneindex, "ob_zombie_encounter_dense", 0 );
                function_2a814d41ec6b9609( zone.zoneindex, "ob_merc_ambient", 1 );
            }
            else
            {
                function_2a814d41ec6b9609( zone.zoneindex, "ob_zombie_ambient", 1 );
                function_2a814d41ec6b9609( zone.zoneindex, "ob_zombie_encounter_dense", 1 );
                function_2a814d41ec6b9609( zone.zoneindex, "ob_merc_ambient", 0 );
            }
            
            continue;
        }
        
        subzones = function_6978793539ff1cb4( zone.zoneindex );
        
        foreach ( subzone in subzones )
        {
            if ( subzone.var_20d6d0656474ee79 )
            {
                function_5866063fb64cf1a9( zone.zoneindex, subzone.subzoneindex, "ob_zombie_ambient", 0 );
                function_5866063fb64cf1a9( zone.zoneindex, subzone.subzoneindex, "ob_zombie_encounter_dense", 0 );
                function_5866063fb64cf1a9( zone.zoneindex, subzone.subzoneindex, "ob_merc_ambient", 1 );
                continue;
            }
            
            function_5866063fb64cf1a9( zone.zoneindex, subzone.subzoneindex, "ob_zombie_ambient", 1 );
            function_5866063fb64cf1a9( zone.zoneindex, subzone.subzoneindex, "ob_zombie_encounter_dense", 1 );
            function_5866063fb64cf1a9( zone.zoneindex, subzone.subzoneindex, "ob_merc_ambient", 0 );
        }
    }
}

// Namespace ob
// Params 0
// Checksum 0x2f162f76, Offset: 0x6ca3
// Size: 0x432
function function_ecb8a8d58a90a87()
{
    level endon( #"game_ended" );
    setdvar( @"ai_spawn_director_enable_ambient_player_deny_spawn", 0 );
    level.var_eaa997904ee44406 = [];
    level.var_eaa997904ee44406[ level.var_eaa997904ee44406.size ] = { #influenceratio:3, #radius:1000, #encounterbundles:[ %"hash_567e93fc2b07bc8", %"hash_caf7cc15deebeb8" ] };
    level.var_eaa997904ee44406[ level.var_eaa997904ee44406.size ] = { #influenceratio:2, #radius:850, #encounterbundles:[ %"hash_65d38e806627c4e4", %"hash_3ed975c9b20dbb54" ] };
    level.var_eaa997904ee44406[ level.var_eaa997904ee44406.size ] = { #influenceratio:-1, #radius:750, #encounterbundles:[ %"hash_1ea2aee0d80e00e4", %"hash_536903ab36c47754" ] };
    level.var_a946a9ef8bbf3cc8 = [ #"difficulty_easy", #"difficulty_normal", #"difficulty_hard" ];
    level.var_4152880985d1ce88 = [];
    
    /#
        level thread function_9e2234d4a6dcd50d();
    #/
    
    while ( true )
    {
        cooldownmin = getdvarint( @"hash_ae1de1052e51b9a9", 25 );
        cooldownmax = getdvarint( @"hash_adfad3052e2b5327", 35 );
        cooldowntime = randomintrange( cooldownmin, cooldownmax ) * 1000;
        var_5a5d8a8745694ca0 = cooldowntime * 0.25;
        
        foreach ( teamname, squadarray in level.squaddata )
        {
            foreach ( squad in squadarray )
            {
                if ( squad.players.size > 0 )
                {
                    if ( !isdefined( level.var_4152880985d1ce88[ teamname ] ) )
                    {
                        level.var_4152880985d1ce88[ teamname ] = [];
                    }
                    
                    if ( !isdefined( level.var_4152880985d1ce88[ teamname ][ squad.index ] ) )
                    {
                        var_4152880985d1ce88 = spawnstruct();
                        var_4152880985d1ce88.var_2d8041df79adb2db = gettime() + cooldowntime;
                        var_4152880985d1ce88.teamname = teamname;
                        var_4152880985d1ce88.squadindex = squad.index;
                        level.var_4152880985d1ce88[ teamname ][ squad.index ] = var_4152880985d1ce88;
                        
                        /#
                            function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x110>" );
                        #/
                    }
                    
                    var_4152880985d1ce88 = level.var_4152880985d1ce88[ teamname ][ squad.index ];
                    
                    if ( isdefined( var_4152880985d1ce88.requestid ) )
                    {
                        function_d437466ac51600a2( squad, var_4152880985d1ce88 );
                        
                        if ( !isdefined( var_4152880985d1ce88.requestid ) )
                        {
                            if ( var_4152880985d1ce88.shortcooldown )
                            {
                                var_4152880985d1ce88.var_2d8041df79adb2db = gettime() + var_5a5d8a8745694ca0;
                            }
                            else
                            {
                                var_4152880985d1ce88.var_2d8041df79adb2db = gettime() + cooldowntime;
                            }
                            
                            var_4152880985d1ce88.shortcooldown = undefined;
                        }
                        
                        continue;
                    }
                    
                    if ( gettime() >= var_4152880985d1ce88.var_2d8041df79adb2db )
                    {
                        function_289ee28fe719a67c( squad, var_4152880985d1ce88 );
                        
                        if ( !isdefined( var_4152880985d1ce88.requestid ) )
                        {
                            var_4152880985d1ce88.var_2d8041df79adb2db = gettime() + var_5a5d8a8745694ca0;
                        }
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ob
// Params 1
// Checksum 0x665b012b, Offset: 0x70dd
// Size: 0xc1
function function_131ba0d0b06f9ea4( squad )
{
    averagepower = 0;
    
    foreach ( player in squad.players )
    {
        averagepower += player.powertier ?? 1;
    }
    
    averagepower = float( averagepower ) / float( squad.players.size );
    averagepower = int( averagepower );
    return averagepower;
}

// Namespace ob
// Params 2
// Checksum 0x7fec59ff, Offset: 0x71a7
// Size: 0x70a
function function_289ee28fe719a67c( squad, var_4152880985d1ce88 )
{
    encounterrange = getdvarint( @"hash_c01cbdb6944be54e", 1500 );
    var_880b2b26b9114f94 = [];
    
    foreach ( player in squad.players )
    {
        if ( getdvarint( @"hash_d2dd881c73a7c6f9", 0 ) == 1 && !function_7ee822e93093763e( player.origin, "ob_merc_ambient" ) )
        {
            continue;
        }
        
        if ( !player::isaliveandnotinlaststand( player ) )
        {
            /#
                function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x123>" + player.name );
            #/
            
            continue;
        }
        
        if ( player isvehicleactive() )
        {
            /#
                function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x13f>" + player.name );
            #/
            
            continue;
        }
        
        placementstruct = spawnstruct();
        playerfacing = anglestoforward( player.angles );
        playerfacing = vectornormalize( ( playerfacing[ 0 ], playerfacing[ 1 ], 0 ) );
        placementstruct.midpoint = player.origin + playerfacing * encounterrange;
        halfsizelength = encounterrange * 0.66;
        placementstruct.halfsize = ( halfsizelength, halfsizelength, encounterrange );
        
        if ( isdefined( var_4152880985d1ce88.var_f69740879732f528 ) && isdefined( var_4152880985d1ce88.var_b349a444a8a3582d ) )
        {
            testhalfsize = placementstruct.halfsize + ( var_4152880985d1ce88.var_b349a444a8a3582d, var_4152880985d1ce88.var_b349a444a8a3582d, var_4152880985d1ce88.var_b349a444a8a3582d );
            
            if ( math::function_47d0ed373b25c699( var_4152880985d1ce88.var_f69740879732f528, placementstruct.midpoint - testhalfsize, placementstruct.midpoint + testhalfsize ) )
            {
                /#
                    function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x15c>" + player.name );
                #/
                
                continue;
            }
        }
        
        subzones = function_918216a34b974826( placementstruct.midpoint, placementstruct.halfsize );
        var_222683c6c7441756 = 0;
        
        foreach ( subzone in subzones )
        {
            if ( subzone.var_20d6d0656474ee79 )
            {
                var_222683c6c7441756 = 1;
                break;
            }
        }
        
        if ( var_222683c6c7441756 )
        {
            /#
                function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x189>" + player.name );
            #/
            
            continue;
        }
        
        if ( function_9bee3f0ef32b20f9( placementstruct.midpoint, placementstruct.halfsize ) )
        {
            /#
                function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x1b6>" + player.name );
            #/
            
            continue;
        }
        
        placementstruct.player = player;
        var_880b2b26b9114f94[ var_880b2b26b9114f94.size ] = placementstruct;
    }
    
    if ( var_880b2b26b9114f94.size == 0 )
    {
        return;
    }
    
    placementstruct = utility::array_random( var_880b2b26b9114f94 );
    var_36a319af0d8ffaa7 = getdvarint( @"hash_1adfe5d5dc66ced6", 2500 );
    
    if ( function_38f824c0718f4f15( placementstruct.midpoint, var_36a319af0d8ffaa7 ) )
    {
        /#
            function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x1e4>" );
        #/
        
        return;
    }
    
    encounterlocation = function_1ada91bd6e407f6f( placementstruct.midpoint, placementstruct.halfsize );
    
    if ( !isdefined( encounterlocation ) )
    {
        /#
            function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x217>" );
        #/
        
        return;
    }
    
    averagepower = function_131ba0d0b06f9ea4( squad );
    averagepower = int( clamp( averagepower - 1, 0, level.var_a946a9ef8bbf3cc8.size - 1 ) );
    difficultytag = level.var_a946a9ef8bbf3cc8[ averagepower ];
    influencesum = getplayerinfluenceatposition( encounterlocation, 1 );
    influencemax = getplayerinfluenceatposition( encounterlocation, 0 );
    
    if ( influencemax <= 0 || influencesum <= 0 )
    {
        return;
    }
    
    influenceratio = influencesum / influencemax;
    var_c290ab18bbfda620 = undefined;
    
    foreach ( encounterstruct in level.var_eaa997904ee44406 )
    {
        if ( influenceratio >= encounterstruct.influenceratio )
        {
            var_c290ab18bbfda620 = encounterstruct;
            break;
        }
    }
    
    assert( isdefined( var_c290ab18bbfda620 ) );
    var_26399b5eaf24923f = function_99a5f7bfb440cb49( encounterlocation, var_c290ab18bbfda620.radius );
    
    foreach ( var_966798b249ac64a9 in var_26399b5eaf24923f )
    {
        var_966798b249ac64a9 = function_28e6db29ed75c40f( encounterlocation );
        
        if ( isdefined( var_966798b249ac64a9.var_8cf9e0b76d8f0c36 ) )
        {
            var_9d4adc9837113ba6 = function_9b649316adcccbaa( var_966798b249ac64a9.var_8cf9e0b76d8f0c36 );
            
            if ( isdefined( var_9d4adc9837113ba6 ) )
            {
                if ( distancesquared( var_9d4adc9837113ba6.origin, encounterlocation ) < ( var_9d4adc9837113ba6.radius + var_c290ab18bbfda620.radius ) * ( var_9d4adc9837113ba6.radius + var_c290ab18bbfda620.radius ) )
                {
                    /#
                        function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x243>" );
                    #/
                    
                    return;
                }
            }
        }
    }
    
    encounterbundle = utility::array_random( var_c290ab18bbfda620.encounterbundles );
    requestid = ai_spawn_director::spawn_request( encounterbundle, encounterlocation, var_c290ab18bbfda620.radius, 1, 1, 1, 0 );
    
    if ( !isdefined( requestid ) )
    {
        return;
    }
    
    function_1a9d724a960fa19d( requestid, difficultytag, 1 );
    var_4152880985d1ce88.requestid = requestid;
    var_4152880985d1ce88.var_f69740879732f528 = encounterlocation;
    var_4152880985d1ce88.var_b349a444a8a3582d = var_c290ab18bbfda620.radius;
    
    /#
        function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x270>" + getxhashsourcename( encounterbundle ) + "<dev string:x28b>" + requestid + "<dev string:x298>" + getxhashsourcename( difficultytag ) );
    #/
    
    ai_spawn_director::function_5a08798970350207( requestid, &function_1605d2422ea624db, getclosestpointonnavmesh( placementstruct.player.origin ) );
}

// Namespace ob
// Params 2
// Checksum 0xeaa5e613, Offset: 0x78b9
// Size: 0xdc
function function_1605d2422ea624db( requestid, reinforcelocation )
{
    data = function_9b649316adcccbaa( requestid );
    
    if ( !isdefined( reinforcelocation ) )
    {
        reinforcelocation = data.origin;
    }
    
    foreach ( agent in data.ai )
    {
        agent setgoalpos( reinforcelocation, data.radius );
        
        if ( isdefined( self.fnsetstealthstate ) )
        {
            agent [[ self.fnsetstealthstate ]]( "combat" );
        }
    }
}

// Namespace ob
// Params 2
// Checksum 0x9c7f3b4d, Offset: 0x799d
// Size: 0x17e
function function_d437466ac51600a2( squad, var_4152880985d1ce88 )
{
    assert( isdefined( var_4152880985d1ce88.requestid ) );
    requestdata = function_9b649316adcccbaa( var_4152880985d1ce88.requestid );
    
    if ( !isdefined( requestdata ) )
    {
        /#
            function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x2a9>" );
        #/
        
        var_4152880985d1ce88.requestid = undefined;
        return;
    }
    
    if ( requestdata.status != 12 )
    {
        playerinrange = 0;
        var_36b42e69bc55fa48 = getdvarint( @"hash_9228ffb894c67123", 3500 );
        
        foreach ( player in squad.players )
        {
            if ( distancesquared( player.origin, requestdata.origin ) < var_36b42e69bc55fa48 * var_36b42e69bc55fa48 )
            {
                playerinrange = 1;
                break;
            }
        }
        
        if ( !playerinrange )
        {
            /#
                function_8121392d85850abf( var_4152880985d1ce88, "<dev string:x2ca>" );
            #/
            
            if ( !requestdata.alert )
            {
                var_4152880985d1ce88.shortcooldown = 1;
            }
            
            ai_spawn_director::cancel_spawn_request( var_4152880985d1ce88.requestid, 0 );
        }
    }
}

// Namespace ob
// Params 2
// Checksum 0xfa0a8a09, Offset: 0x7b23
// Size: 0x159, Type: bool
function function_38f824c0718f4f15( origin, radius )
{
    foreach ( teamname, squadarray in level.squaddata )
    {
        foreach ( squad in squadarray )
        {
            var_4152880985d1ce88 = level.var_4152880985d1ce88[ teamname ][ squad.index ];
            
            if ( isdefined( var_4152880985d1ce88.requestid ) )
            {
                requestdata = function_9b649316adcccbaa( var_4152880985d1ce88.requestid );
                
                if ( isdefined( requestdata ) )
                {
                    if ( distancesquared( requestdata.origin, origin ) < radius * radius )
                    {
                        return true;
                    }
                }
            }
        }
    }
    
    return false;
}

/#

    // Namespace ob
    // Params 0
    // Checksum 0x99ebf1bb, Offset: 0x7c85
    // Size: 0x1f4, Type: dev
    function function_9e2234d4a6dcd50d()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"ob_merc_ambient_debug_draw", 0 ) == 1 )
            {
                foreach ( teamname, squadarray in level.squaddata )
                {
                    foreach ( squad in squadarray )
                    {
                        var_4152880985d1ce88 = level.var_4152880985d1ce88[ teamname ][ squad.index ];
                        
                        if ( !isdefined( var_4152880985d1ce88 ) )
                        {
                            continue;
                        }
                        
                        debugstring = teamname + "<dev string:x304>" + squad.index + "<dev string:x306>";
                        
                        if ( squad.players.size > 0 )
                        {
                            debugstring += "<dev string:x309>" + function_131ba0d0b06f9ea4( squad ) + "<dev string:x317>";
                        }
                        
                        if ( isdefined( var_4152880985d1ce88.requestid ) )
                        {
                            debugstring += "<dev string:x319>" + var_4152880985d1ce88.requestid + "<dev string:x317>";
                        }
                        else
                        {
                            cooldowntime = ( var_4152880985d1ce88.var_2d8041df79adb2db - gettime() ) / 1000;
                            cooldowntime = int( max( 0, cooldowntime ) );
                            debugstring += "<dev string:x326>" + cooldowntime + "<dev string:x317>";
                        }
                        
                        function_eb8a9b1df0b00b2b( debugstring );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob
    // Params 2
    // Checksum 0x67e2e75f, Offset: 0x7e81
    // Size: 0x5d, Type: dev
    function function_8121392d85850abf( var_4152880985d1ce88, text )
    {
        if ( getdvarint( @"hash_524b898bc957e9b3", 0 ) == 1 )
        {
            println( "<dev string:x333>" + var_4152880985d1ce88.teamname + "<dev string:x304>" + var_4152880985d1ce88.squadindex + "<dev string:x306>" + text );
        }
    }

#/

// Namespace ob
// Params 0
// Checksum 0x9677ae09, Offset: 0x7ee6
// Size: 0x39
function function_5c4abaa0d060e64c()
{
    level endon( #"game_ended" );
    waitframe();
    waittime = getdvarint( @"hash_db5f1beff575d62c", 30 );
    wait waittime;
    callback::callback( "ob_content_process_create_script" );
}

// Namespace ob
// Params 1
// Checksum 0xd4619b6b, Offset: 0x7f27
// Size: 0xcd
function function_200a0708fe5eb8c4( params )
{
    if ( level.var_7626e61d0c3b9106 )
    {
        return;
    }
    
    level.var_7626e61d0c3b9106 = 1;
    ob_activity_manager::ob_activity_manager_init();
    ob_content_manager::ob_content_manager_init();
    namespace_34bb2a33b8502c64::init();
    level.var_9bc9a23f5202a8db = &namespace_34bb2a33b8502c64::function_36f1eac78c060f20;
    ob_difficulty_manager::function_4c3bd700506293e0();
    init_player_broadcasting();
    
    if ( level.var_27db84deef4475fd )
    {
    }
    
    utility::flag_wait( "content_manager_initialized" );
    function_99cb822c8459b546();
    
    if ( level.var_bb86f77304f193c4.exfilsenabled )
    {
        if ( isdefined( level.var_316fff387ea8d0c2 ) )
        {
            thread [[ level.var_316fff387ea8d0c2 ]]();
        }
        else
        {
            namespace_3a2a361a08f89b78::init_ob_exfil();
        }
    }
    
    level thread function_f700821c03e96ff2();
    namespace_9e2e014d1479d97c::init_ob_intel();
    activity_common::function_2dd4f07fa5c3e911( "ActivityEnd", &function_aab51b292333c1a5 );
}

// Namespace ob
// Params 1
// Checksum 0xddff811d, Offset: 0x7ffc
// Size: 0x2b
function set_plunder_count( plunder )
{
    self.currency[ #"cash" ] = plunder;
    cash::playersetplunderomnvar( plunder );
}

// Namespace ob
// Params 0
// Checksum 0xa0d20d13, Offset: 0x802f
// Size: 0x49
function function_1a70fdeabb0f7b6d()
{
    level.var_a6163894496fed14 = [];
    level.var_a6163894496fed14[ 0 ] = 50;
    level.var_a6163894496fed14[ 1 ] = 100;
    level.var_a6163894496fed14[ 2 ] = 400;
    level.var_a6163894496fed14[ 3 ] = 800;
}

// Namespace ob
// Params 4, eflags: 0x4
// Checksum 0x68be1206, Offset: 0x8080
// Size: 0x163
function private function_12d1fa486aca9990( var_31389415574c377f, var_39bc414888da0b04, damage_ratio, var_8f69c955fdeea3da )
{
    if ( var_31389415574c377f.var_b31ef781986c2f56 && !gas_grenade::function_aad3f9ba4ac6be30( var_39bc414888da0b04 ) )
    {
        return;
    }
    
    current_time = gettime();
    gas_grenade_damage_interval = var_39bc414888da0b04.var_e4bcca7ae7bbff3a ?? 1000;
    
    if ( damage_ratio > 0 && ( !isdefined( self.var_f1daab3ca831723 ) || self.var_f1daab3ca831723 + gas_grenade_damage_interval <= current_time ) )
    {
        if ( var_39bc414888da0b04.iscrossbow )
        {
            crossbowlevel = var_39bc414888da0b04.crossbowlevel ?? 0;
            gasgrenade_damage = level.var_a6163894496fed14[ crossbowlevel ];
        }
        else
        {
            gasgrenade_damage = self.maxhealth * damage_ratio;
        }
        
        if ( var_39bc414888da0b04.var_4a204f123199db39 )
        {
            gasgrenade_damage = var_39bc414888da0b04.var_4a204f123199db39;
        }
        
        self dodamage( gasgrenade_damage, self.origin, var_39bc414888da0b04.owner, var_39bc414888da0b04, "MOD_ELEMENTAL_TOXIC", var_31389415574c377f.useweapon );
        self.var_f1daab3ca831723 = current_time;
    }
    
    if ( var_8f69c955fdeea3da < 1 )
    {
        effect_slow::slow( "gasgrenade", var_8f69c955fdeea3da, 1, var_39bc414888da0b04.owner, undefined, undefined, "toxic" );
    }
}

// Namespace ob
// Params 2
// Checksum 0x893781d, Offset: 0x81eb
// Size: 0x166
function function_3262713c75e61f18( var_39bc414888da0b04, var_31389415574c377f )
{
    self endon( #"death" );
    
    if ( !isagent( self ) )
    {
        return;
    }
    
    damage_ratio = 0;
    var_8f69c955fdeea3da = 1;
    
    if ( self.type == "zombie" )
    {
        if ( isdefined( self.aicategory ) )
        {
            switch ( self.aicategory )
            {
                case #"hash_8c089e813083e510":
                    damage_ratio = 0.05;
                    var_8f69c955fdeea3da = 0.5;
                    break;
                case #"hash_7b0e2f2ed84f34":
                case #"hash_4e47eb6c32f5b165":
                    damage_ratio = 0.025;
                    var_8f69c955fdeea3da = 0.5;
                    break;
                default:
                    damage_ratio = 0.05;
                    var_8f69c955fdeea3da = 0.5;
                    break;
            }
        }
    }
    else if ( ai::is_warlord() )
    {
        damage_ratio = 0.025;
    }
    else if ( self.type == "human" )
    {
        var_8f69c955fdeea3da = 0.5;
        
        switch ( self.subclass )
        {
            case #"hash_91cd18ea8bf6d95":
                damage_ratio = 0.05;
                break;
            case #"hash_3c0ffb3dab1a9835":
                damage_ratio = 0.025;
                break;
            default:
                damage_ratio = 0.05;
                break;
        }
    }
    
    function_12d1fa486aca9990( var_31389415574c377f, var_39bc414888da0b04, damage_ratio, var_8f69c955fdeea3da );
}

// Namespace ob
// Params 1
// Checksum 0x23b43898, Offset: 0x8359
// Size: 0x44
function ob_round_number_difficulty( v_origin )
{
    assert( isdefined( v_origin ), "<dev string:x341>" );
    var_8de44035c62f2f4f = region_difficulty_manager::get_region_difficulty( v_origin );
    n_round = region_difficulty_manager::function_d33b93a54f11258d( var_8de44035c62f2f4f );
    return n_round;
}

// Namespace ob
// Params 0
// Checksum 0x156ca, Offset: 0x83a6
// Size: 0x2
function init_vehicles()
{
    
}

// Namespace ob
// Params 2
// Checksum 0x51b8e1d8, Offset: 0x83b0
// Size: 0x61
function interact_activity_instance( activity_instance_metadata, params )
{
    assert( isarray( params ) );
    params[ 0 ] thread function_74ea2c137bcaa403( activity_instance_metadata, params[ 1 ], params[ 2 ], params[ 3 ], params[ 4 ], params[ 5 ], params[ 6 ], params[ 7 ] );
    
    if ( isdefined( params[ 8 ] ) )
    {
        params[ 0 ] thread [[ params[ 8 ] ]]( params[ 6 ] );
    }
}

// Namespace ob
// Params 2
// Checksum 0x229717a1, Offset: 0x8419
// Size: 0x59
function function_f7f4d2abfb3b1fd6( activity_instance_metadata, params )
{
    assert( isarray( params ) );
    params[ 0 ] thread function_45021e00fc76b26b( activity_instance_metadata, params[ 1 ], params[ 2 ], params[ 3 ], params[ 4 ], params[ 5 ], params[ 6 ], params[ 7 ] );
    params[ 0 ] thread [[ params[ 8 ] ]]( params[ 6 ] );
}

// Namespace ob
// Params 0
// Checksum 0xa3bb3e25, Offset: 0x847a
// Size: 0x43
function function_99cb822c8459b546()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level callback::callback( "register_activities" );
    level callback::callback( "register_objectives" );
    level callback::callback( "register_features" );
    level callback::callback( "activities_registered" );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xc81b1336, Offset: 0x84c5
// Size: 0x9f
function private function_aab51b292333c1a5( relevant_info_struct )
{
    foreach ( player in relevant_info_struct.playerlist )
    {
        if ( isplayer( player ) && !isalive( player ) )
        {
            player notify( #"force_spawn" );
        }
    }
}

// Namespace ob
// Params 0
// Checksum 0x871caecb, Offset: 0x856c
// Size: 0x3d
function init_player_broadcasting()
{
    level.string_messaging_widget_ref = "scripted_widget_objective_text_sat_ob";
    level.string_messaging_widget_type = "scripted_widget_objective_group_sat_ob";
    player_broadcasting::function_7fc000126b792810();
    player_broadcasting::function_f5e10214f3edd9df( "TitleSplash", &function_af41b6fdce38201c );
    string_messaging_util::function_162973038bb20b3();
}

// Namespace ob
// Params 3
// Checksum 0x23af78aa, Offset: 0x85b1
// Size: 0x81
function function_af41b6fdce38201c( players, splash_broadcast, broadcast_command )
{
    data_objects = splash_broadcast player_broadcasting::function_d95fdf9867bbbdc3();
    
    if ( data_objects.size == 0 || splash_broadcast player_broadcasting::getbroadcasttype() != "TitleSplash" )
    {
        return;
    }
    
    for ( data_object_index = 0; data_object_index < data_objects.size ; data_object_index++ )
    {
        data_object = data_objects[ data_object_index ];
        namespace_8f542cd1b399b165::function_ad4e2822c5f9b8f9( players, splash_broadcast, data_object, broadcast_command );
    }
}

// Namespace ob
// Params 0
// Checksum 0xf52aace0, Offset: 0x863a
// Size: 0x162
function init_ob_threatbias()
{
    level.threatbias_teams = [ "team_two_hundred", "civilian", "team_hundred_ninety", "allies", "team_players", "ignored_by_zombies", "rushing_omega_agents" ];
    
    foreach ( threatbias_team in level.threatbias_teams )
    {
        if ( !threatbiasgroupexists( threatbias_team ) )
        {
            createthreatbiasgroup( threatbias_team );
        }
    }
    
    level callback::add( #"player_spawned", &function_13b44aa789560876 );
    level callback::add( "on_agent_spawned", &function_1fe0963c623edfc7 );
    level callback::add( "on_agent_spawned", &function_b03b2f19ffe98a6f );
    level callback::add( "on_agent_spawned", &function_a183870ba1341285 );
    setignoremegroup( "ignored_by_zombies", "team_two_hundred" );
    utility::registersharedfunc( #"player", #"hash_d1ade7b3c059cba9", &function_7852f419c0d0211c );
    level.var_83d22984577c2e1c = &function_a734b153a015ea9;
    setignoremegroup( "team_two_hundred", "rushing_omega_agents" );
}

// Namespace ob
// Params 1
// Checksum 0xbff1339f, Offset: 0x87a4
// Size: 0x1a
function function_a734b153a015ea9( var_760e9a17ea240f22 )
{
    function_7852f419c0d0211c( "aether_shroud", var_760e9a17ea240f22 );
}

// Namespace ob
// Params 2
// Checksum 0xe359baf8, Offset: 0x87c6
// Size: 0x86
function function_7852f419c0d0211c( source, var_1a52166ad44834e7 )
{
    assert( isplayer( self ) );
    assert( isstring( source ) );
    
    if ( !isdefined( self.a_ignored_by_zombies ) )
    {
        self.a_ignored_by_zombies = [];
    }
    
    self.a_ignored_by_zombies[ source ] = var_1a52166ad44834e7 ? 1 : undefined;
    
    if ( self.a_ignored_by_zombies.size > 0 )
    {
        self setthreatbiasgroup( "ignored_by_zombies" );
        return;
    }
    
    self setthreatbiasgroup( "team_players" );
}

// Namespace ob
// Params 1
// Checksum 0xe4af1429, Offset: 0x8854
// Size: 0x60
function function_c770a8f20cb08b5d( enable )
{
    if ( self.team != "team_hundred_ninety" )
    {
        assertmsg( "<dev string:x37f>" );
        return;
    }
    
    if ( enable )
    {
        assert( arraycontains( level.threatbias_teams, "<dev string:x3c5>" ) );
        self setthreatbiasgroup( "rushing_omega_agents" );
        return;
    }
    
    function_1fe0963c623edfc7();
}

// Namespace ob
// Params 1
// Checksum 0x3e441ec9, Offset: 0x88bc
// Size: 0x17
function function_13b44aa789560876( params )
{
    self setthreatbiasgroup( "team_players" );
}

// Namespace ob
// Params 1
// Checksum 0x8a7c3c34, Offset: 0x88db
// Size: 0x42
function function_1fe0963c623edfc7( params )
{
    if ( isdefined( self.team ) && arraycontains( level.threatbias_teams, self.team ) )
    {
        self setthreatbiasgroup( self.team );
    }
}

// Namespace ob
// Params 1
// Checksum 0xb74f04ba, Offset: 0x8925
// Size: 0x12e
function function_b03b2f19ffe98a6f( params )
{
    if ( isdefined( level.var_bb131187d6741752 ) )
    {
        difficulty = [[ level.var_bb131187d6741752 ]]( self.origin );
    }
    else
    {
        difficulty = "difficulty_easy";
    }
    
    if ( self.type == "zombie" )
    {
        switch ( difficulty )
        {
            case #"hash_7bb2cd766703d463":
                self.attackeraccuracy = getdvarfloat( @"hash_de6dc5f654aea557", 5 );
                break;
            case #"hash_af83e47edfa8900a":
                self.attackeraccuracy = getdvarfloat( @"hash_fa7ecf4ab69de0b4", 4 );
                break;
            case #"hash_5343b465e56ec9a4":
                self.attackeraccuracy = getdvarfloat( @"hash_f80c5b3399cc105a", 1 );
                break;
            case #"hash_651f76c0ad6741ec":
            case #"hash_c0250ffc2e87f2ff":
            case #"hash_c02510fc2e87f492":
                self.attackeraccuracy = getdvarfloat( @"hash_bab34333b64588f3", 1 );
                break;
            default:
                break;
        }
    }
}

// Namespace ob
// Params 1
// Checksum 0x66899243, Offset: 0x8a5b
// Size: 0xc1
function function_a183870ba1341285( params )
{
    if ( self.unittype == "soldier" && isdefined( self.subclass ) )
    {
        switch ( self.subclass )
        {
            case #"hash_91cd18ea8bf6d95":
            case #"hash_284b2545dbaa82f7":
                self.var_b89463f307cbc06a = 0;
                self.var_5107c41a503d61c9 = 1;
                break;
            case #"hash_e907579ab7e94379":
                self.var_b89463f307cbc06a = 0;
                self.var_5107c41a503d61c9 = 2;
                break;
            default:
                self.var_b89463f307cbc06a = 0;
                self.var_5107c41a503d61c9 = 3;
                break;
        }
    }
}

// Namespace ob
// Params 0
// Checksum 0x69f8c4a9, Offset: 0x8b24
// Size: 0x5f
function init_ob_squads()
{
    utility::registersharedfunc( #"squad_utility", #"hash_ca8a81a3ee73b2f6", &ob_get_squad_members );
    callback::add( #"squad_created", &on_squad_created );
    callback::add( #"hash_cc06eb1d45f33a0c", &function_96f4cdc101535ade );
    callback::add( #"player_leave_squad", &function_6e3ef1350639cb6a );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xc9240cd7, Offset: 0x8b8b
// Size: 0x3c
function private on_squad_created( params )
{
    logstring( "==OB SQUAD CREATED  Team: " + params.team + "; Squad Index: " + params.index );
    level thread function_eaacd66cbcfbe0de();
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xff374e8f, Offset: 0x8bcf
// Size: 0x5e
function private function_96f4cdc101535ade( params )
{
    logstring( "==OB SQUAD JOIN  Player: " + self.name + "; Team: " + params.team + "; Squad Index: " + params.index + "; Member Index: " + params.memberindex );
    level thread function_eaacd66cbcfbe0de();
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x7b9564fa, Offset: 0x8c35
// Size: 0x5e
function private function_6e3ef1350639cb6a( params )
{
    logstring( "==OB SQUAD LEAVE  Player: " + self.name + "; Team: " + params.team + "; Squad Index: " + params.index + "; Member Index: " + params.memberindex );
    level thread function_eaacd66cbcfbe0de();
}

// Namespace ob
// Params 2
// Checksum 0x417dabea, Offset: 0x8c9b
// Size: 0x2b7
function ob_get_squad_members( testteam, aliveonly )
{
    a_squad_members = [];
    team = testteam ?? self.team;
    
    if ( !isdefined( self ) )
    {
        assertmsg( "<dev string:x3da>" );
        return a_squad_members;
    }
    
    if ( !isdefined( team ) )
    {
        logstring( "==OB SQUAD GET SQUAD MEMBERS: " + self.name + " entnum " + self getentitynumber() + " doesn't have a defined team" );
    }
    
    if ( !isdefined( self.sessionsquadid ) )
    {
        logstring( "==OB SQUAD GET SQUAD MEMBERS: " + self.name + " entnum " + self getentitynumber() + " doesn't have a defined sessionsquadid" );
    }
    
    if ( !isdefined( self.sessionuimemberindex ) )
    {
        logstring( "==OB SQUAD GET SQUAD MEMBERS: " + self.name + " entnum " + self getentitynumber() + " doesn't have a defined sessionuimemberindex" );
    }
    
    if ( isdefined( team ) && isdefined( self.sessionsquadid ) && isdefined( level.squaddata[ team ][ self.sessionsquadid ] ) && isarray( level.squaddata[ team ][ self.sessionsquadid ].players ) )
    {
        foreach ( player in level.squaddata[ team ][ self.sessionsquadid ].players )
        {
            if ( !aliveonly || aliveonly && isalive( player ) && player.sessionstate == "playing" )
            {
                a_squad_members[ a_squad_members.size ] = player;
            }
        }
    }
    
    if ( !a_squad_members.size && isplayer( self ) )
    {
        if ( team == self.team && ( !aliveonly || aliveonly && isalive( self ) && self.sessionstate == "playing" ) )
        {
            a_squad_members[ a_squad_members.size ] = self;
            logstring( "==OB SQUAD GET SQUAD MEMBERS: Returning " + self.name + " entnum " + self getentitynumber() + " instead of empty squad. Squad ID somehow undefined?" );
        }
    }
    
    var_4ae65e852a5402d9 = utility::callsharedfunc( #"pvp_contract", #"hash_9d96968e4defe402", self.team, self.sessionsquadid );
    
    if ( isarray( var_4ae65e852a5402d9 ) && var_4ae65e852a5402d9.size > 0 )
    {
        a_squad_members = arraycombineunique( var_4ae65e852a5402d9, a_squad_members );
    }
    
    return a_squad_members;
}

// Namespace ob
// Params 0
// Checksum 0x14ae8afd, Offset: 0x8f5b
// Size: 0x17
function init_ob_loadouts()
{
    callback::add( #"player_spawned", &ob_loadout_player_spawned );
}

// Namespace ob
// Params 0
// Checksum 0x12fe49fb, Offset: 0x8f7a
// Size: 0x1a
function init_ob_dvars()
{
    setdvar( @"compassmaxrange", 5000 );
    thread function_93bc8b705618ea84();
}

// Namespace ob
// Params 0
// Checksum 0x49543ca9, Offset: 0x8f9c
// Size: 0x56
function init_ob_omnvars()
{
    mapinfo = getmapscriptbundle();
    range = mapinfo.bigmapminimap ? mapinfo.bigmapmaxrange : mapinfo.maxrange;
    
    if ( range > 0 )
    {
        setomnvar( "ui_br_minimap_radius", range );
    }
}

// Namespace ob
// Params 0
// Checksum 0x45f78d3d, Offset: 0x8ffa
// Size: 0xef
function function_93bc8b705618ea84()
{
    utility::flag_wait( "ai_spawn_director_initialized" );
    
    if ( getdvarint( @"ob_limit_zombie_abom", 1 ) == 1 )
    {
        function_a25acb62ddab20e2( "ob_limit_zombie_abom", 1 );
    }
    
    if ( getdvarint( @"ob_disable_zombie_base", 0 ) == 1 )
    {
        function_a25acb62ddab20e2( "ob_disable_zombie_base", 1 );
    }
    
    if ( getdvarint( @"ob_disable_zombie_disciple", 0 ) == 1 )
    {
        function_a25acb62ddab20e2( "ob_disable_zombie_disciple", 1 );
    }
    
    if ( getdvarint( @"ob_disable_zombie_hellhound", 0 ) == 1 )
    {
        function_a25acb62ddab20e2( "ob_disable_zombie_hellhound", 1 );
    }
    
    if ( getdvarint( @"ob_disable_zombie_mangler", 0 ) == 1 )
    {
        function_a25acb62ddab20e2( "ob_disable_zombie_mangler", 1 );
    }
    
    if ( getdvarint( @"ob_disable_zombie_mimic", 0 ) == 1 )
    {
        function_a25acb62ddab20e2( "ob_disable_zombie_mimic", 1 );
    }
    
    if ( getdvarint( @"ob_disable_zombie_abom", 0 ) == 1 )
    {
        function_a25acb62ddab20e2( "ob_disable_zombie_abom", 1 );
    }
}

// Namespace ob
// Params 0
// Checksum 0xd7f1fdd6, Offset: 0x90f1
// Size: 0x3d
function function_27459deefbb3631d()
{
    if ( level.gametypebundle.jipdisabled )
    {
        setnojipscore( 1 );
        setnojiptime( 1 );
        return;
    }
    
    setnojipscore( 0 );
    setnojiptime( 0 );
    level thread function_e14e64d38b355a1f();
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xd0e343be, Offset: 0x9136
// Size: 0x64
function private function_e14e64d38b355a1f()
{
    level endon( #"game_ended" );
    level waittill( #"matchstarttimer_done" );
    timeout = getdvarint( @"hash_67e537056ee477e0", -1 );
    
    /#
        if ( getdvarint( @"hash_176b2103002d5a24", 0 ) )
        {
            timeout = -1;
        }
    #/
    
    if ( timeout >= 0 )
    {
        wait timeout;
        setnojiptime( 1 );
        brmatchstarted();
    }
}

// Namespace ob
// Params 1
// Checksum 0x412850c5, Offset: 0x91a2
// Size: 0x148
function ob_loadout_player_spawned( params )
{
    if ( !self.var_b8cfeb206bb587fc )
    {
        self.var_b8cfeb206bb587fc = 1;
        weapons = self getweaponslistprimaries();
        
        foreach ( weapon in weapons )
        {
            self givemaxammo( weapon );
            self setweaponammoclip( weapon, weaponclipsize( weapon ) );
        }
    }
    
    if ( self.primaryweapons.size > 0 )
    {
        primaryweaponobj = self.primaryweapons[ 0 ];
        primaryweapon = getcompleteweaponname( primaryweaponobj );
        self.primaryweaponobj = primaryweaponobj;
        self.primaryweapon = primaryweapon;
    }
    
    if ( self.primaryweapons.size > 1 )
    {
        secondaryweaponobj = self.primaryweapons[ 1 ];
        secondaryweapon = getcompleteweaponname( secondaryweaponobj );
        self.secondaryweaponobj = secondaryweaponobj;
        self.secondaryweapon = secondaryweapon;
    }
}

// Namespace ob
// Params 0
// Checksum 0x1c0f9963, Offset: 0x92f2
// Size: 0xbc
function function_4eaee7dee55cd6c0()
{
    self endon( #"death_or_disconnect" );
    val::set( "spawn_wait_ignore", "ignoreme", 1 );
    
    if ( level.var_bb86f77304f193c4.var_3d6368d667a0a3df && !getdvarint( @"hash_2fe0283b419ff08a", 0 ) )
    {
        utility::flag_wait( "ob_infil_completed" );
    }
    
    var_a9dc6c55ba247349 = gettime();
    
    while ( gettime() - var_a9dc6c55ba247349 < 180000 )
    {
        if ( self.pers[ "totalDistTraveled" ] > 0 )
        {
            break;
        }
        else if ( self.pers[ "shotsFired" ] > 0 )
        {
            break;
        }
        
        wait 1;
    }
    
    val::reset_all( "spawn_wait_ignore" );
}

// Namespace ob
// Params 1
// Checksum 0xabfa7295, Offset: 0x93b6
// Size: 0x3f2
function on_player_spawned( params )
{
    self endon( #"disconnect" );
    
    if ( self.deaths > 0 )
    {
        self setclientomnvar( "ui_disable_scoreboard", 0 );
    }
    
    var_478cf6944312ff00 = getdvarint( @"scr_start_currency", 0 );
    
    if ( var_478cf6944312ff00 == 1 )
    {
        currency::add_currency_amount( #"essence", 400 );
    }
    else if ( var_478cf6944312ff00 > 0 )
    {
        currency::add_currency_amount( #"essence", var_478cf6944312ff00 );
    }
    
    var_fb22ef4a26be66dd = spawnstruct();
    var_fb22ef4a26be66dd.player = self;
    callback::callback( "infilled_with_super", var_fb22ef4a26be66dd );
    
    if ( self.var_fe6accc35e05dd3d )
    {
        if ( !game_utility_mp::isteamreviveenabled() )
        {
            common_inventory::function_1cc2d5027325dc95();
        }
        else if ( isdefined( self.var_a2fee6e691fd624c ) )
        {
            perkpackage::perkpackage_giveimmediate( self.var_a2fee6e691fd624c );
            self.var_a2fee6e691fd624c = undefined;
        }
        
        self.var_fe6accc35e05dd3d = undefined;
    }
    else if ( !common_instance_inventory::isenabled() )
    {
        common_inventory::function_1202b827227d4ad2();
        common_inventory::function_4e7fa885e76e773e( common_inventory::function_ddf98332913ae51() );
    }
    
    var_d45e8494aa475665 = getdvar( @"hash_1c51b6e011fc2b75", "none" );
    
    if ( var_d45e8494aa475665 != "none" )
    {
        var_d45e8494aa475665 = strtok( var_d45e8494aa475665, "," );
        
        foreach ( var_bf9e5aaaca2445ed in var_d45e8494aa475665 )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
            item = common_item::items_spawnitemfromscriptable( var_bf9e5aaaca2445ed, undefined, spawnoptions );
            common_item::function_96119bed8ab4c5d9( item, 0, 1 );
        }
    }
    
    set_initial_difficulty();
    thread function_4eaee7dee55cd6c0();
    force_power_level = getdvarint( @"hash_89f5285b9abcc3b2", -1 );
    
    if ( force_power_level != -1 )
    {
        ob_cheat_dvars::function_a609520d9907524c( self, force_power_level, 10 );
    }
    
    thread function_96a90b8fcc7c1d1d();
    
    if ( getdvarint( @"hash_98f8a446faaed6b5", "" ) )
    {
        if ( getdvar( @"hash_41e9406014a271b5", "" ) == self.operatorcustomization.skinref )
        {
            perkpackage::perkpackage_giveimmediate( "super_active_camo" );
        }
        else if ( getdvar( @"hash_ae4a322975a1557", "" ) == self.operatorcustomization.skinref )
        {
            perkpackage::perkpackage_giveimmediate( "super_rallying_cry" );
        }
        else if ( getdvar( @"hash_b744f86d6b83377e", "" ) == self.operatorcustomization.skinref )
        {
            perkpackage::perkpackage_giveimmediate( "super_vision_pulse" );
        }
    }
    
    if ( getdvarint( @"hash_c011b1842b233c88", 0 ) )
    {
        if ( self.loadoutfieldupgrade1 == "none" && self.loadoutfieldupgrade2 == "none" && !isdefined( self.overridefieldupgrade1 ) && !isdefined( self.overridefieldupgrade2 ) )
        {
            abilities = [ "super_active_camo", "super_rallying_cry", "super_vision_pulse" ];
            perkpackage::perkpackage_giveimmediate( utility::array_random( abilities ) );
        }
    }
    
    if ( !isdefined( self.assigned_difficulty ) )
    {
        thread function_86ef6f9996499233();
    }
    
    squad = teams::function_72b89edf6b47c40a( self );
    var_8c5067d0870248c8 = self.var_8c5067d0870248c8 ?? squad.var_8c5067d0870248c8 ?? undefined;
    
    if ( var_8c5067d0870248c8 )
    {
        ob_story_mission_utils::function_9d7c461c00f2f588( var_8c5067d0870248c8, 1 );
    }
    
    self.var_a6e870d8e686a116 = self.perkpackagedata.super;
    level thread function_eaacd66cbcfbe0de();
}

// Namespace ob
// Params 1
// Checksum 0x2ca8c3e1, Offset: 0x97b0
// Size: 0x1c
function function_37904b06ac0bfaf1( params )
{
    thread function_d3b1691153843cbd();
    function_aae50a9de45f694a( params );
}

// Namespace ob
// Params 0
// Checksum 0x2db15e16, Offset: 0x97d4
// Size: 0x2c, Type: bool
function function_3cc23382db426150()
{
    forcedoperators = get_forced_operators();
    return isarray( forcedoperators ) && isdefined( forcedoperators[ 0 ].operator );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x8a0c70b1, Offset: 0x9809
// Size: 0xd, Type: bool
function private function_858a16046dff3559( params )
{
    return false;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xe3d07a0a, Offset: 0x981f
// Size: 0xd, Type: bool
function private function_bd3eb5a6df1ba83c( params )
{
    return false;
}

// Namespace ob
// Params 0
// Checksum 0xd57a2fca, Offset: 0x9835
// Size: 0x33
function get_forced_operators()
{
    forcedoperators = level.forcedoperators;
    
    if ( !isdefined( forcedoperators ) )
    {
        forcedoperators = level.var_bb86f77304f193c4.forcedoperators;
    }
    
    return forcedoperators;
}

// Namespace ob
// Params 0
// Checksum 0x5c553065, Offset: 0x9871
// Size: 0x2fc
function function_bb87aa4b7a02a73b()
{
    assert( isplayer( self ) );
    player = self;
    forceoperatorskin = undefined;
    
    if ( getdvarint( @"hash_ea303cda79562854", "" ) )
    {
        operatorskindvar = hashcat( @"scr_sat_ob_", player.name, "_force_operator_skin" );
        forceoperatorskin = getdvar( operatorskindvar, "" );
    }
    else if ( function_3cc23382db426150() )
    {
        squad = teams::function_72b89edf6b47c40a( player );
        
        if ( !isdefined( squad ) )
        {
            return;
        }
        
        assignedslot = undefined;
        missiondata = save::mission_get_data();
        worldsquad = missiondata.squads[ squad.index ];
        forcedoperators = get_forced_operators();
        
        if ( !isdefined( worldsquad ) )
        {
            worldsquad = {};
            missiondata.squads[ squad.index ] = worldsquad;
        }
        
        available = [];
        
        foreach ( slot in forcedoperators )
        {
            available[ available.size ] = available.size;
        }
        
        foreach ( squadplayer in squad.players )
        {
            if ( !squadplayer isconnected() )
            {
                continue;
            }
            
            if ( squadplayer == player )
            {
                assignedslot = worldsquad.var_cb57883a946fccc8[ squadplayer.guid ];
                continue;
            }
            
            if ( isdefined( worldsquad.var_cb57883a946fccc8[ squadplayer.guid ] ) )
            {
                available = arrayremove( available, worldsquad.var_cb57883a946fccc8[ squadplayer.guid ] );
            }
        }
        
        if ( !isdefined( assignedslot ) || !arraycontains( available, assignedslot ) )
        {
            assignedslot = player function_74424269de0092f2();
            
            if ( !isdefined( assignedslot ) || !arraycontains( available, assignedslot ) )
            {
                assignedslot = available[ 0 ];
            }
            
            worldsquad.var_cb57883a946fccc8[ player.guid ] = assignedslot;
        }
        
        /#
            forcedslot = getdvarint( @"hash_d9b0b583dfa242d5", -1 );
            
            if ( forcedslot >= 0 && forcedslot <= 3 )
            {
                assignedslot = forcedslot;
            }
        #/
        
        if ( isdefined( assignedslot ) )
        {
            forceoperatorskin = forcedoperators[ assignedslot ].operator;
            player function_b102e77e27b689c6( assignedslot );
        }
    }
    
    return forceoperatorskin;
}

// Namespace ob
// Params 0
// Checksum 0xa88faea, Offset: 0x9b76
// Size: 0xe6, Type: bool
function function_d3b1691153843cbd()
{
    assert( isplayer( self ) );
    player = self;
    forceoperatorskin = player function_bb87aa4b7a02a73b();
    
    if ( forceoperatorskin )
    {
        squad = teams::function_72b89edf6b47c40a( player );
        logstring( "[FORCED OPERATOR] Squad " + squad.index + ": " + player.name + ":" + player getentitynumber() + " assigned " + forceoperatorskin );
        var_c8255ed7498c56a2 = operator::function_de170b6ef0100e22( forceoperatorskin );
        
        if ( isdefined( var_c8255ed7498c56a2 ) )
        {
            operatorref = operator::function_30f20ce375c4ee40( getxhashasset( var_c8255ed7498c56a2 ) );
            player operator::createoperatorcustomization( getxhashasset( operatorref ), var_c8255ed7498c56a2 );
            player player::_setsuit( player.operatorcustomization.suit, 1 );
            return true;
        }
    }
    
    return false;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x8a5d2f37, Offset: 0x9c65
// Size: 0x5d
function private function_b102e77e27b689c6( forcedOperatorIndex )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( level.onlinegame )
    {
        if ( !isdefined( forcedOperatorIndex ) )
        {
            forcedOperatorIndex = 0;
        }
        else
        {
            forcedOperatorIndex += 1;
        }
        
        player setplayerdata( level.var_6f9b00680ed002d8, "forcedOperatorIndex", forcedOperatorIndex );
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x9f36272e, Offset: 0x9cca
// Size: 0x5e
function private function_74424269de0092f2()
{
    assert( isplayer( self ) );
    player = self;
    
    if ( level.onlinegame )
    {
        forcedOperatorIndex = player getplayerdata( level.var_6f9b00680ed002d8, "forcedOperatorIndex" );
        
        if ( forcedOperatorIndex > 0 )
        {
            return ( forcedOperatorIndex - 1 );
        }
    }
    
    return player.sessionuimemberindex;
}

// Namespace ob
// Params 1
// Checksum 0x24b8f9d9, Offset: 0x9d31
// Size: 0x12d
function function_26fd7480f329bfda( operators )
{
    if ( isarray( operators ) )
    {
        level.forcedoperators = [];
        
        foreach ( operator in operators )
        {
            level.forcedoperators[ level.forcedoperators.size ] = { #operator:operator };
        }
    }
    else
    {
        level.forcedoperators = undefined;
    }
    
    foreach ( player in level.players )
    {
        player function_d3b1691153843cbd();
    }
}

// Namespace ob
// Params 0
// Checksum 0x941331b3, Offset: 0x9e66
// Size: 0x33
function function_1b5f2c79fff5a75e()
{
    result = 0;
    
    if ( level.onlinegame )
    {
        var_f9448fb7d63d23b7 = getonlinematchid();
        result = int( var_f9448fb7d63d23b7 );
    }
    
    return result;
}

// Namespace ob
// Params 1
// Checksum 0xd40a9a9d, Offset: 0x9ea2
// Size: 0x2d
function function_27a6341bb7cafb63( params )
{
    if ( isdefined( params.player ) )
    {
        params.player thread function_1de71dc8bd28c340();
    }
}

// Namespace ob
// Params 0
// Checksum 0xe92faadb, Offset: 0x9ed7
// Size: 0x3a8
function function_1de71dc8bd28c340()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"exit_vehicle" );
    println( "<dev string:x420>" );
    objweapon = makeweapon( "emp_pulse_mp" );
    
    if ( !isdefined( level.ob_ddos_throttle ) )
    {
        level.ob_ddos_throttle = throttle::throttle_initialize( "ddos", 1, level.framedurationseconds );
    }
    
    while ( true )
    {
        if ( vehicle_occupancy::function_3080323254ba6900( self ) )
        {
            throttle::throttle_wait_in_queue( level.ob_ddos_throttle, self );
            
            if ( isdefined( self.vehicle ) )
            {
                if ( getdvarint( @"hash_b808e932765b36b6", 1 ) == 0 )
                {
                    playedeffect = 0;
                    zombies = getaiarrayinradius( self.origin, getdvarint( @"hash_71eb35d288cf5376", 1300 ) );
                    contents = trace::create_contents( 0, 1, 1, 0, 0, 1, 0 );
                    specials = 0;
                    
                    foreach ( zombie in zombies )
                    {
                        if ( function_1aa5b91384ee1410( zombie ) )
                        {
                            specials++;
                            
                            if ( !self.vehicle.var_240fd1eb1d0416cc )
                            {
                                /#
                                    if ( getdvarint( @"hash_cedfd894822951d7", 0 ) == 1 )
                                    {
                                        println( "<dev string:x42d>" + zombie.aicategory );
                                        println( "<dev string:x442>" + zombie.origin );
                                        println( "<dev string:x453>" + self.vehicle.origin );
                                        println( "<dev string:x46a>" + distancesquared( zombie.origin, self.vehicle.origin ) );
                                    }
                                #/
                                
                                info = physics_raycast( zombie.origin, self.vehicle.origin + self.vehicle vehicle_getvelocity() * 0.75, contents, [ zombie, self.vehicle ], 0, "physicsquery_closest" );
                                
                                if ( !info.size || !isdefined( info[ 0 ][ "hittype" ] ) )
                                {
                                    if ( !playedeffect )
                                    {
                                        playsoundatpos( self.origin, "iw9_emp_blast" );
                                        playedeffect = 1;
                                    }
                                    
                                    self.vehicle thread function_7005512d3af9fa54( getdvarint( @"hash_d9b247c13aab9329", 10 ), zombie );
                                    data = damage_utility::packdamagedata( self, self.vehicle, 1, objweapon, "MOD_EXPLOSIVE", zombie, zombie.origin );
                                    emp_debuff::function_1fdeda386a85c7c7( data, getdvarint( @"hash_d9b247c13aab9329", 10 ), 0 );
                                    self.vehicle.ddosenemy = zombie;
                                }
                            }
                        }
                    }
                    
                    if ( zombies.size == 0 || specials == 0 )
                    {
                        self.vehicle emp_debuff::clear_emp();
                        self.vehicle vehphys_parkingbrake( 0 );
                        self.vehicle.ddosenemy = undefined;
                        self.vehicle.var_240fd1eb1d0416cc = 0;
                    }
                }
                else
                {
                    return;
                }
            }
        }
        else
        {
            println( "<dev string:x47d>" );
        }
        
        wait 0.1;
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x950dd9b8, Offset: 0xa287
// Size: 0xad, Type: bool
function private function_1aa5b91384ee1410( ai )
{
    if ( !isalive( ai ) )
    {
        return false;
    }
    
    if ( isdefined( ai.type ) && ai.type != "zombie" )
    {
        return false;
    }
    
    if ( issubstr( ai.subclass, "zombie_disciple" ) )
    {
        return false;
    }
    
    if ( isdefined( ai.aicategory ) )
    {
        switch ( ai.aicategory )
        {
            case #"hash_7b0e2f2ed84f34":
            case #"hash_4e47eb6c32f5b165":
            case #"hash_7e8a002ed096276c":
            case #"hash_8c089e813083e510":
                return true;
        }
    }
    
    return false;
}

// Namespace ob
// Params 2
// Checksum 0x6527e3cf, Offset: 0xa33d
// Size: 0xa6
function function_7005512d3af9fa54( duration, target )
{
    self endon( #"death" );
    target endon( #"death" );
    self.var_240fd1eb1d0416cc = 1;
    
    while ( duration > 0 )
    {
        duration -= 0.1;
        dist = getdvarint( @"hash_81fa3ca40de5904c", 150 );
        
        if ( distancesquared( self.origin, target.origin ) < dist * dist )
        {
            self vehphys_parkingbrake( 1 );
            wait duration;
            break;
        }
        
        wait 0.1;
    }
    
    self.var_240fd1eb1d0416cc = 0;
}

// Namespace ob
// Params 2
// Checksum 0xfaed11b, Offset: 0xa3eb
// Size: 0x77
function function_d77d6c8f2ed70000( duration, attacker )
{
    self endon( #"death" );
    objweapon = makeweapon( "emp_pulse_mp" );
    thread function_7005512d3af9fa54( duration, self );
    data = damage_utility::packdamagedata( attacker, self, 1, objweapon, "MOD_EXPLOSIVE", attacker, attacker.origin );
    emp_debuff::function_1fdeda386a85c7c7( data, duration, 0 );
    wait duration;
}

// Namespace ob
// Params 0
// Checksum 0x2ea14626, Offset: 0xa46a
// Size: 0x7f
function function_96a90b8fcc7c1d1d()
{
    self notify( #"hash_301af1e2fe72838b" );
    self endon( #"hash_301af1e2fe72838b" );
    self endon( #"disconnect" );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "tac_map_toggle", "togglemap" );
    }
    
    while ( true )
    {
        self waittill( #"tac_map_toggle" );
        params = spawnstruct();
        params.player = self;
        callback::callback( "player_tac_map_toggled", params );
    }
}

// Namespace ob
// Params 1
// Checksum 0x52b5fd76, Offset: 0xa4f1
// Size: 0x79
function function_680b224b3f0d6884( params )
{
    if ( params.time_left > 0 )
    {
        smoke_end_time = gettime() + utility::function_4b74c15943231980( params.time_left );
        
        if ( !isdefined( self.smoke_end_time ) )
        {
            self.smoke_end_time = smoke_end_time;
            thread function_2511c7a8aa02456e();
            return;
        }
        
        self.smoke_end_time = max( self.smoke_end_time, smoke_end_time );
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x540db083, Offset: 0xa572
// Size: 0x115
function private function_2511c7a8aa02456e()
{
    self endon( #"death" );
    
    while ( gettime() < self.smoke_end_time )
    {
        if ( !self.aether_shroud_active )
        {
            no_enemy_nearby = 1;
            ai_array = getaiarrayinradius( self.origin, 60 );
            
            foreach ( ai in ai_array )
            {
                if ( isdefined( ai.team ) && ai.team != self.team )
                {
                    no_enemy_nearby = 0;
                    break;
                }
            }
            
            val::set( "smokegrenade", "ignoreme", no_enemy_nearby );
        }
        
        waitframe();
    }
    
    val::reset_all( "smokegrenade" );
    self.smoke_end_time = undefined;
}

// Namespace ob
// Params 1
// Checksum 0xefa3782a, Offset: 0xa68f
// Size: 0x2a
function function_473c5aba19ee9ce7( params )
{
    if ( !isdefined( self.perks[ "specialty_blindeye" ] ) )
    {
        self.smoke_end_time = undefined;
    }
}

// Namespace ob
// Params 1
// Checksum 0x8f481fe2, Offset: 0xa6c1
// Size: 0x109
function function_9ff471f79ecb7a0c( params )
{
    level endon( #"game_ended" );
    
    if ( !( isdefined( params ) && isdefined( params.endtime ) ) )
    {
        return;
    }
    
    while ( gettime() < params.endtime )
    {
        if ( isdefined( params.position ) && isdefined( params.smokeradius ) )
        {
            agent_array = getaiarrayinradius( params.position, params.smokeradius );
            
            foreach ( agent in agent_array )
            {
                if ( isdefined( agent ) )
                {
                    agent.var_19d4f81159d7fb95 = gettime();
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ob
// Params 0
// Checksum 0x3df30201, Offset: 0xa7d2
// Size: 0x56
function set_initial_difficulty()
{
    difficulty = region_difficulty_manager::get_region_difficulty( self.origin );
    
    if ( isdefined( difficulty ) )
    {
        var_e7b67b42155f71ee = level.region_difficulty_manager.region_difficulty_to_int[ difficulty ];
        
        if ( isdefined( var_e7b67b42155f71ee ) )
        {
            self setclientomnvar( "ui_region_difficulty", var_e7b67b42155f71ee );
        }
    }
}

// Namespace ob
// Params 0
// Checksum 0xc60c8925, Offset: 0xa830
// Size: 0x57
function function_fd5be1e26f733f53()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    
    if ( self.primaryweapons.size > 2 && self hasweapon( level.defaultfist ) )
    {
        self takeweapon( level.defaultfist );
    }
}

// Namespace ob
// Params 1
// Checksum 0x180780cf, Offset: 0xa88f
// Size: 0x27
function reset_ui_disable_scoreboard( delay )
{
    self endon( #"disconnect" );
    wait delay;
    self setclientomnvar( "ui_disable_scoreboard", 0 );
}

// Namespace ob
// Params 10
// Checksum 0xb0831168, Offset: 0xa8be
// Size: 0xc7
function on_player_killed( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    self.var_fe6accc35e05dd3d = 1;
    
    if ( game_utility_mp::isteamreviveenabled() )
    {
        self.var_a2fee6e691fd624c = self.perkpackagedata.super;
        utility::callsharedfunc( #"pleaforhelp", #"callforhelp" );
    }
    
    self setclientomnvar( "ui_disable_scoreboard", 1 );
    thread reset_ui_disable_scoreboard( 0.1 );
    level thread function_eaacd66cbcfbe0de();
}

// Namespace ob
// Params 1
// Checksum 0x4b50ecaa, Offset: 0xa98d
// Size: 0xbb
function function_838f150fa7e375ad( params )
{
    foreach ( player in level.players )
    {
        if ( !squad_utility::function_6a77a8d0f8eb25b5( params.victim, player ) )
        {
            objidpoolmanager::objective_playermask_addshowplayer( params.victim.revive.objidnum, player );
        }
    }
}

// Namespace ob
// Params 0
// Checksum 0x91328a8d, Offset: 0xaa50
// Size: 0x77
function callback_playerconnect()
{
    self waittill( #"begin" );
    
    if ( !isdefined( level.player ) )
    {
        spawnpoints = getentarray( "mp_global_intermission", #classname );
        self spawn( spawnpoints[ 0 ].origin, spawnpoints[ 0 ].angles );
        self.maxhealth = 10000000;
        self.health = 10000000;
    }
}

// Namespace ob
// Params 18
// Checksum 0x8bd0ee1c, Offset: 0xaacf
// Size: 0x342
function callback_playerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, poisedamage, willknockdown, additionalparams )
{
    if ( isdefined( eattacker ) && eattacker vehicle::is_vehicle() )
    {
        if ( isarray( eattacker.occupants ) && eattacker.occupants.size == 0 && isarray( eattacker.riders ) && eattacker.riders.size == 0 && !isdefined( eattacker.driver ) && !eattacker.var_19a36b17776e8e85 && eattacker.team != "team_hundred_ninety" )
        {
            return;
        }
        else if ( isdefined( eattacker.veh_speed ) && eattacker.veh_speed < 25 && smeansofdeath == "MOD_IMPACT" )
        {
            return;
        }
    }
    
    if ( self.var_a10f7b74f982f0f0 == eattacker )
    {
        return;
    }
    
    if ( isplayer( eattacker ) && eattacker == self && zombie_perks::has_perk( "specialty_phd_flopper" ) )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"pvp_contract", #"pvpinvulnerable", self, eattacker, idamage, objweapon ) )
    {
        return;
    }
    
    ob_settings = get_ob_settings();
    
    if ( ob_settings.var_1b75777a39c05888 && eattacker.classname == "trigger_hurt" && smeansofdeath == "MOD_TRIGGER_HURT" && objweapon == nullweapon() )
    {
        utility::callsharedfunc( #"ob_infil", #"hash_516c884e13c5892d", self, self.origin, 1 );
        return;
    }
    
    if ( isai( eattacker ) && isdefined( eattacker.var_7f8ab9bb9f4957fc ) )
    {
        idamage = [[ eattacker.var_7f8ab9bb9f4957fc ]]( idamage, eattacker, objweapon );
    }
    
    foreach ( var_1617dd51250abbbc, hasbuff in self.var_bd752fd42b2e2193 )
    {
        if ( hasbuff && isdefined( level.zombie_augments[ var_1617dd51250abbbc ] ) )
        {
            mitigation_percent = level.zombie_augments[ var_1617dd51250abbbc ].var_c9c15e179d5eefad ?? 0.1;
            idamage = clampint( int( idamage * ( 1 - mitigation_percent ) ), 0, maxint( idamage, 1 ) );
        }
    }
    
    [[ level.var_309f8f867be84cac ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2 );
}

// Namespace ob
// Params 1
// Checksum 0xa682c785, Offset: 0xae19
// Size: 0x4d
function function_1c077eb1ecd1777e( params )
{
    self.gameskill = mp_gameskill::get_gameskill();
    mp_gameskill::apply_difficulty_settings( 1 );
    thread debug_zombie_cheat();
    thread watch_third_person();
    
    if ( !isdefined( self.pers[ "killsSinceLastAFKCheck" ] ) )
    {
        mp_afk::function_9592b6d120cfac02();
    }
}

// Namespace ob
// Params 1
// Checksum 0x24e038f3, Offset: 0xae6e
// Size: 0xc
function on_disconnect( params )
{
    
}

// Namespace ob
// Params 0
// Checksum 0xbafc86c5, Offset: 0xae82
// Size: 0x2e
function function_302d3d999a2ab368()
{
    if ( isbot( self ) )
    {
        return "callback";
    }
    
    if ( level.rankedmatch )
    {
        return "custom1";
    }
    
    return "class0";
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x4141997b, Offset: 0xaeb8
// Size: 0xe, Type: bool
function private modeallowmeleevehicledamage( data )
{
    return true;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x94997ae3, Offset: 0xaecf
// Size: 0x34
function private get_player_lives_safe( player )
{
    if ( isdefined( player.pers[ "lives" ] ) )
    {
        return player.pers[ "lives" ];
    }
    
    return 0;
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x50d6c55d, Offset: 0xaf0c
// Size: 0x19e
function private function_4c3d35d28fd1c731()
{
    totalplayers = 0;
    level.teamswithplayers = [];
    var_4db28074a8fd272 = [];
    
    foreach ( team in level.teamnamelist )
    {
        if ( team == "team_two_hundred" )
        {
            continue;
        }
        
        var_4db28074a8fd272[ var_4db28074a8fd272.size ] = team;
    }
    
    foreach ( team in var_4db28074a8fd272 )
    {
        teamcount = teams::getteamdata( team, "teamCount" );
        totalplayers += teamcount;
        
        if ( teamcount )
        {
            level.teamswithplayers[ level.teamswithplayers.size ] = team;
        }
    }
    
    if ( game_utility_mp::matchmakinggame() && !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( level.teamswithplayers.size == 1 && level.ob_debugsolotest )
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
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x3f274585, Offset: 0xb0b2
// Size: 0xb2
function private function_f831c835efd0c8f( weaponobj )
{
    var_2e08e94c9cb1747c = weapon::getweaponrootname( weaponobj );
    
    if ( isdefined( level.weaponmetadata[ var_2e08e94c9cb1747c ] ) )
    {
        var_e491cc4ce8526125 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_6c2dc03affad7ce0;
        var_e9ca9da4b737395 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_6ec5e9b28d8ba1f4;
        
        if ( isdefined( var_e491cc4ce8526125 ) && weaponobj hasattachment( var_e491cc4ce8526125 ) || isdefined( var_e9ca9da4b737395 ) && weaponobj hasattachment( var_e9ca9da4b737395 ) )
        {
            return weaponobj;
        }
        
        if ( isdefined( var_e491cc4ce8526125 ) && weaponobj canuseattachment( var_e491cc4ce8526125 ) )
        {
            weaponobj = weaponobj withattachment( var_e491cc4ce8526125 );
        }
    }
    
    return weaponobj;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x134cf5d2, Offset: 0xb16d
// Size: 0x147
function private function_39e352609a3a1c9( v_pos )
{
    if ( isdefined( level.var_bd706167fc97713c ) )
    {
        var_8de44035c62f2f4f = [[ level.var_bd706167fc97713c ]]( v_pos );
        
        switch ( var_8de44035c62f2f4f )
        {
            case #"hash_7bb2cd766703d463":
            default:
                s_pap_menu = purchasemenu::get_purchasemenu( #"pap_green" );
                
                if ( isdefined( s_pap_menu ) )
                {
                    s_pap_menu.str_region_color = "green";
                }
                
                break;
            case #"hash_af83e47edfa8900a":
                s_pap_menu = purchasemenu::get_purchasemenu( #"pap_yellow" );
                
                if ( isdefined( s_pap_menu ) )
                {
                    s_pap_menu.str_region_color = "yellow";
                }
                
                break;
            case #"hash_5343b465e56ec9a4":
                s_pap_menu = purchasemenu::get_purchasemenu( #"pap_orange_red" );
                
                if ( isdefined( s_pap_menu ) )
                {
                    s_pap_menu.str_region_color = "orange";
                }
                
                break;
            case #"hash_651f76c0ad6741ec":
                s_pap_menu = purchasemenu::get_purchasemenu( #"pap_orange_red" );
                
                if ( isdefined( s_pap_menu ) )
                {
                    s_pap_menu.str_region_color = "red";
                }
                
                break;
        }
    }
    
    if ( !isdefined( s_pap_menu ) )
    {
        s_pap_menu = purchasemenu::get_purchasemenu( #"pap_orange_red" );
    }
    
    return s_pap_menu;
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x52cff9a9, Offset: 0xb2bd
// Size: 0x18
function private function_7f3495b83a4c12c4()
{
    level endon( #"game_ended" );
    wait 10;
    gamelogic_mp::forceend();
}

// Namespace ob
// Params 3
// Checksum 0x9fb6851a, Offset: 0xb2dd
// Size: 0x726
function function_8ad966643eb205e0( playerextracted, var_205c30650c4c42de, var_7cde6f7cf60c3fea )
{
    if ( !isdefined( self ) || isdefined( self.disconnecting ) )
    {
        return;
    }
    
    if ( self.var_d58ee66c64228bb0 && isdefined( var_205c30650c4c42de ) && !var_205c30650c4c42de )
    {
        return;
    }
    
    playertelemetry = self.pers[ "telemetry" ];
    eliminations = playertelemetry.eliminations ?? 0;
    eliminationsxp = playertelemetry.eliminations_xp ?? 0;
    var_33b1d3c82b9b98c7 = playertelemetry.elite_eliminations ?? 0;
    var_9f7d77f1709816e7 = playertelemetry.elite_eliminations_xp ?? 0;
    contractscompleted = playertelemetry.var_7a078a035570e92b ?? 0;
    contractsxp = playertelemetry.contracts_completed_xp ?? 0;
    activitiescompleted = playertelemetry.activities_completed ?? 0;
    activitiesxp = playertelemetry.activities_completed_xp ?? 0;
    var_717c463e8aa62ae7 = playertelemetry.world_events_completed ?? 0;
    var_8113c83c6ba2707 = playertelemetry.var_71230fde1cb2cadd ?? 0;
    exfilxp = ( playerextracted ? rank::getscoreinfoxp( #"dmz_extraction_bonus" ) : 0 ) ?? 0;
    var_bb588d8494abfb33 = playertelemetry.special_eliminations ?? 0;
    var_b0d9433380c6fab3 = playertelemetry.special_eliminations_xp ?? 0;
    gained_power = playertelemetry.gained_power ?? 0;
    
    if ( var_7cde6f7cf60c3fea )
    {
        eliminations += self getplayerdata( level.outbreakdata, "DMZaarValue", 0 );
        eliminationsxp += self getplayerdata( level.outbreakdata, "DMZaarValue", 1 );
        var_33b1d3c82b9b98c7 += self getplayerdata( level.outbreakdata, "DMZaarValue", 2 );
        var_9f7d77f1709816e7 += self getplayerdata( level.outbreakdata, "DMZaarValue", 3 );
        contractscompleted += self getplayerdata( level.outbreakdata, "DMZaarValue", 4 );
        contractsxp += self getplayerdata( level.outbreakdata, "DMZaarValue", 5 );
        activitiescompleted += self getplayerdata( level.outbreakdata, "DMZaarValue", 6 );
        activitiesxp += self getplayerdata( level.outbreakdata, "DMZaarValue", 7 );
        var_717c463e8aa62ae7 += self getplayerdata( level.outbreakdata, "DMZaarValue", 8 );
        var_8113c83c6ba2707 += self getplayerdata( level.outbreakdata, "DMZaarValue", 9 );
        exfilxp += self getplayerdata( level.outbreakdata, "DMZaarValue", 10 );
        var_bb588d8494abfb33 += self getplayerdata( level.outbreakdata, "DMZaarValue", 11 );
        var_b0d9433380c6fab3 += self getplayerdata( level.outbreakdata, "DMZaarValue", 12 );
        gained_power += self getplayerdata( level.outbreakdata, "DMZaarValue", 13 );
    }
    
    var_eaa1e4853aa390e9 = 0;
    var_e045a890094e3bfc = 0;
    var_fbd4b2fd37c7ce47 = 0;
    
    if ( !playerextracted )
    {
        var_de385a6178156735 = getdvarint( @"hash_308563c9c75af8a3", level.var_858d230de58cc743.var_de385a6178156735 ?? 0 );
        var_eaa1e4853aa390e9 = clampint( var_de385a6178156735, 0, self.powertier - 1 );
        
        foreach ( skillref, skilllevel in self.activeskills )
        {
            skillcategory = level.skillbundles[ skillref ][ skilllevel ].skillcategory;
            
            if ( skillcategory == #"end_game" )
            {
                var_e045a890094e3bfc += skilllevel + 1;
                continue;
            }
            
            if ( skillcategory == #"nightmare" )
            {
                var_fbd4b2fd37c7ce47 += skilllevel + 1;
            }
        }
    }
    
    var_f95284e22aab40c7 = 0;
    squadmembers = squad_utility::getsquadmembers( undefined, 0 );
    
    foreach ( player in squadmembers )
    {
        if ( !player.var_6c2982c1a050d76a && player get_rescue_token_balance() )
        {
            var_f95284e22aab40c7 = 1;
            break;
        }
    }
    
    foreach ( player in squadmembers )
    {
        player setclientomnvar( "ui_ob_squad_has_rescue_tokens", var_f95284e22aab40c7 );
    }
    
    self setplayerdata( level.outbreakdata, "DMZaarValue", 0, eliminations );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 1, eliminationsxp );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 2, var_33b1d3c82b9b98c7 );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 3, var_9f7d77f1709816e7 );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 4, contractscompleted );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 5, contractsxp );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 6, activitiescompleted );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 7, activitiesxp );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 8, var_717c463e8aa62ae7 );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 9, var_8113c83c6ba2707 );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 10, exfilxp );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 11, var_bb588d8494abfb33 );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 12, var_b0d9433380c6fab3 );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 13, gained_power );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 14, var_eaa1e4853aa390e9 );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 15, var_e045a890094e3bfc );
    self setplayerdata( level.outbreakdata, "DMZaarValue", 16, var_fbd4b2fd37c7ce47 );
    self.var_d58ee66c64228bb0 = 1;
}

// Namespace ob
// Params 0
// Checksum 0x626b946d, Offset: 0xba0b
// Size: 0x409
function function_daeaf0f2a453b0fb()
{
    player = self;
    player endon( #"disconnect" );
    
    if ( !isdefined( player ) || player.var_b7437a2d0279e0ac || player.b_completed_exfil )
    {
        return;
    }
    
    player.var_b7437a2d0279e0ac = 1;
    
    if ( isdefined( level.var_bb86f77304f193c4.var_3ae91db174863832 ) )
    {
        overlord::playevent( level.var_bb86f77304f193c4.var_3ae91db174863832, [ player ], undefined, 1 );
    }
    
    stopspectateplayer( player getentitynumber(), 1, 0 );
    player function_8ad966643eb205e0( 0 );
    level thread game_utility::fadetoblackforplayer( player, 1, 0.25 );
    wait 0.25;
    
    if ( getdvarint( @"hash_9dac79d9771de8aa", 0 ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( player );
        spawnoptions.isdeathevent = 1;
        player common_inventory::function_71114c5adfb01f7b( spawnoptions );
        
        if ( getdvarint( @"hash_f54d1567cf2a90b6", 1 ) && isdefined( level._ammopouch_info.ammopouchitem ) )
        {
            itembundlename = hashcat( %"itemspawnentry:", level._ammopouch_info.ammopouchitem );
            common_item::function_61c2c0251e742ffd( itembundlename, undefined, common_item::items_initspawnoptions_spawnfromentity( player ) );
        }
    }
    
    if ( isalive( player ) && player.sessionstate == "playing" )
    {
        player playerlogic::removefromalivecount( 1 );
        teams::validatealivecount( "disconnect", player.team, player );
    }
    
    if ( common_instance_inventory::isenabled() && !player.inventoryfinalized )
    {
        powertierpenalty = getdvarint( @"hash_308563c9c75af8a3", level.var_858d230de58cc743.var_de385a6178156735 ?? 0 );
        self setclientomnvar( "ui_ob_power_tier", maxint( 0, ob_power_tier::function_6d4cdb24ee2c66c0() - powertierpenalty ) );
        waitframe();
        var_66ebe1680dda711e = getdvarint( @"hash_3dfc0391c5bca8fb", -1 );
        
        if ( var_66ebe1680dda711e > 0 && player function_28ce5f44a5393018() >= var_66ebe1680dda711e )
        {
            behavior = getdvarint( @"hash_21622ef31c2d15b4", 1 );
            logstring( "[OB_PERSIST] Finalized player " + ( player.name ?? "" ) + " with behavior " + behavior + " due to squad wiping while inactive." );
        }
        else if ( player get_rescue_token_balance() )
        {
            behavior = getdvarint( @"hash_b2d79cf2a7eccb03", 3 );
            logstring( "[OB_PERSIST] Finalized player " + ( player.name ?? "" ) + " with behavior " + behavior + " due to squad wiping with rescue tokens." );
        }
        else
        {
            behavior = getdvarint( @"hash_fefa40bd10088534", 0 );
            logstring( "[OB_PERSIST] Finalized player " + ( player.name ?? "" ) + "with behavior " + behavior + " due to squad wiping." );
        }
        
        ob_persist::finalize_player( player, behavior );
        waitframe();
    }
    
    function_82226ec4c6925388( player, 0 );
    gamelogic_mp::processlobbydataforclient( player );
    scoreboard::processcommonplayerdataforplayer( player );
    namespace_3a2a361a08f89b78::processlobbydata();
    level thread game_utility::fadetoblackforplayer( player, 0, 1 );
    
    if ( !player.b_completed_exfil )
    {
        player setclientomnvar( "ui_dmz_extract_successful", 0 );
    }
    
    player setclientomnvar( "ui_br_squad_eliminated_active", 1 );
    player setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "defeat" ] );
    player setclientomnvar( "ui_round_end_reason", game[ "end_reason" ][ "objective_failed" ] );
    
    if ( isdefined( player.matchbonus ) )
    {
        player setclientomnvar( "ui_round_end_match_bonus", player.matchbonus, 1 );
    }
    
    player setclientdvar( @"ui_opensummary", 1 );
    player setclientomnvar( "ui_play_again_disabled", 1 );
    wait 5.5;
    level thread game_utility::fadetoblackforplayer( player, 1, 0.5 );
    wait 0.5;
    level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
}

// Namespace ob
// Params 1
// Checksum 0xa2dbaa7f, Offset: 0xbe1c
// Size: 0x6b
function onplayerconnect( player )
{
    assert( isplayer( player ), "<dev string:x48c>" );
    ob_settings = get_ob_settings();
    
    if ( ob_settings.var_bc533c47307aeca8 )
    {
        thread function_1c6fa94687dab0f7( player );
    }
    
    if ( !team_assimilation::function_8fe74e094005f15d() || player function_d0c44a7c029750fc() )
    {
        player team_assimilation::function_aa6d43748d8cc8f4( player, "ob_permanent" );
    }
}

// Namespace ob
// Params 1
// Checksum 0xd6363426, Offset: 0xbe8f
// Size: 0x9f
function onplayerdisconnect( player )
{
    if ( level.laststand && !player.var_b7437a2d0279e0ac && !player.b_completed_exfil )
    {
        player thread ob_laststand::function_564f86a40e69f8d( 0 );
    }
    else
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
        
        if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
        {
            gamelogic_mp::function_a7f2ba55c82bfa95( player );
        }
        
        level thread function_648c6072830219c1();
    }
    
    level thread function_eaacd66cbcfbe0de();
    level thread function_cdcc7221533919f6( player );
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x27b39a8f, Offset: 0xbf36
// Size: 0x3b
function private function_648c6072830219c1()
{
    level endon( #"game_ended" );
    level endon( #"game_ended_aether_storm" );
    ob_end_game( { #final_check_func:&function_e54528d68de00641, #var_f60f0122ff7dcb19:1 } );
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xc8983686, Offset: 0xbf79
// Size: 0xe, Type: bool
function private function_e54528d68de00641()
{
    return level.players.size == 0;
}

// Namespace ob
// Params 0
// Checksum 0xd75ad9c4, Offset: 0xbf90
// Size: 0x91
function function_36bd9bf34f291abb()
{
    var_958151dbd0f282ec = 0;
    
    foreach ( player in level.players )
    {
        if ( ob_laststand::function_5461d55290ca1ab6( player ) )
        {
            var_958151dbd0f282ec = 1;
            break;
        }
    }
    
    return var_958151dbd0f282ec;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xa887ec63, Offset: 0xc02a
// Size: 0xfe
function private function_cdcc7221533919f6( player )
{
    playingcount = 0;
    squad = teams::function_72b89edf6b47c40a( player );
    
    if ( isarray( squad.players ) )
    {
        foreach ( squadplayer in squad.players )
        {
            if ( player == squadplayer )
            {
                continue;
            }
            
            if ( squadplayer.sessionstate == "playing" )
            {
                playingcount++;
            }
        }
        
        if ( playingcount == 0 )
        {
            any_player_alive = function_36bd9bf34f291abb();
            [[ level.onsquadeliminated ]]( squad.players, any_player_alive );
        }
    }
}

// Namespace ob
// Params 1
// Checksum 0xe5a5c5ea, Offset: 0xc130
// Size: 0x150
function function_8fde74820e858c23( player )
{
    level endon( #"game_ended_aether_storm" );
    
    if ( !isdefined( player ) || player.b_completed_exfil )
    {
        return;
    }
    
    player thread function_daeaf0f2a453b0fb();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
    
    if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
    {
        gamelogic_mp::function_a7f2ba55c82bfa95( player );
    }
    
    if ( isalive( player ) && player.sessionstate == "playing" )
    {
        player kill();
    }
    
    player.var_81c3ae54e6c166c2 = 1;
    squadmembers = player squad_utility::getsquadmembers();
    
    foreach ( member in squadmembers )
    {
        if ( !member.var_81c3ae54e6c166c2 )
        {
            return;
        }
    }
    
    level thread function_eaacd66cbcfbe0de();
    thread function_6cf6821e09e7f397( player.team, player );
}

// Namespace ob
// Params 2
// Checksum 0xfaec25ed, Offset: 0xc288
// Size: 0x75
function function_6cf6821e09e7f397( team, player )
{
    var_958151dbd0f282ec = function_36bd9bf34f291abb();
    
    if ( !var_958151dbd0f282ec && !level.gameended )
    {
        time_to_wait = isdefined( level.is_quest_story_mission ) ? 0 : undefined;
        ob_end_game( { #time_to_wait:time_to_wait, #var_f60f0122ff7dcb19:1 } );
    }
}

// Namespace ob
// Params 2
// Checksum 0x41665d69, Offset: 0xc305
// Size: 0x157
function onsquadeliminated( a_squad_players, var_958151dbd0f282ec )
{
    foreach ( player in a_squad_players )
    {
        if ( !isplayer( player ) || player.b_completed_exfil )
        {
            continue;
        }
        
        if ( player.sessionstate == "playing" )
        {
            player telemetry_coop::player_death_event( "was_killed" );
        }
        
        player telemetry_coop::player_death_event( "was_wiped" );
    }
    
    squad = teams::function_72b89edf6b47c40a( a_squad_players[ 0 ] );
    
    if ( squad.var_ce3d9b0b597c0927.var_24ecc90a66d9fd2a )
    {
        return;
    }
    
    switch ( level.var_bb86f77304f193c4.var_6708d7a570f5945b ?? "MissionFail" )
    {
        case #"hash_32f2f53dea36515":
            function_5885cf9cd9cd365f( a_squad_players, var_958151dbd0f282ec );
            break;
        case #"hash_b48db283fdbd24c1":
        default:
            function_745e9922e3232e53( a_squad_players, var_958151dbd0f282ec );
            break;
    }
}

// Namespace ob
// Params 2
// Checksum 0x9213d2fe, Offset: 0xc464
// Size: 0x250
function function_745e9922e3232e53( a_squad_players, var_958151dbd0f282ec )
{
    level endon( #"game_ended_aether_storm" );
    
    if ( !isdefined( level.is_quest_story_mission ) && var_958151dbd0f282ec )
    {
        foreach ( player in a_squad_players )
        {
            var_2db61d99668e52ca = utility::callsharedfunc( #"pleaforhelp", #"hash_348c1ada8ab9898f", player );
            
            if ( var_2db61d99668e52ca )
            {
                return;
            }
        }
    }
    
    level callback::callback( #"hash_513cfdee5f84f52d", { #a_squad_players:a_squad_players } );
    
    foreach ( player in a_squad_players )
    {
        if ( isdefined( player ) && !player.b_completed_exfil && !player.var_b7437a2d0279e0ac )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
            
            if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
            {
                gamelogic_mp::function_a7f2ba55c82bfa95( player );
            }
            
            player thread function_daeaf0f2a453b0fb();
            
            if ( isalive( player ) && player.sessionstate == "playing" )
            {
                player kill();
            }
        }
    }
    
    level thread function_eaacd66cbcfbe0de();
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( level.is_quest_story_mission ) )
    {
        if ( nightmare() )
        {
            ob_end_game( { #block_end_game:1 } );
        }
        else
        {
            ob_end_game( { #time_to_wait:0 } );
        }
        
        return;
    }
    
    if ( !var_958151dbd0f282ec )
    {
        ob_end_game( { #var_f60f0122ff7dcb19:1, #block_end_game:1 } );
    }
}

// Namespace ob
// Params 2
// Checksum 0xf6e24428, Offset: 0xc6bc
// Size: 0x52e
function function_5885cf9cd9cd365f( a_squad_players, var_958151dbd0f282ec )
{
    level endon( #"game_ended" );
    playingcount = 0;
    squad = teams::function_72b89edf6b47c40a( a_squad_players[ 0 ] );
    assert( isdefined( squad.players ) );
    
    foreach ( player in a_squad_players )
    {
        if ( ob_infils_portal::function_cf564904f7af50b3( player ) )
        {
            logstring( "==OB ON SQUAD ELIMINATED CEHCKPOINT RESPAWN Squad wiped while player still loading. Player[" + player.name + "] Team[" + player.team + "] Squad[" + player.sessionsquadid + "]" );
        }
    }
    
    respawnlocations = squad.respawnlocations ?? [];
    level callback::callback( #"hash_3c10b892d5a6a8cd", { #a_squad_players:a_squad_players, #respawnlocations:respawnlocations, #squad:squad } );
    spawnpoints = [];
    
    foreach ( index, player in squad.players )
    {
        if ( ob_infils_portal::function_cf564904f7af50b3( player ) )
        {
            continue;
        }
        
        var_b0cf1b4901d4b5fb = int( clamp( index, 0, max( 0, respawnlocations.size - 1 ) ) );
        spawnpoints[ index ] = respawnlocations[ var_b0cf1b4901d4b5fb ];
        player coop::function_eb6e09941acb48e9();
        origin = isstruct( spawnpoints[ index ] ) ? spawnpoints[ index ].origin : spawnpoints[ index ];
        
        if ( !isdefined( origin ) )
        {
            origin = ob_infils_portal::function_dffa38b3d22956d6( player );
        }
        
        if ( isdefined( origin ) )
        {
            player utility::player_prestream_camera( origin, 3 );
        }
        
        if ( player.sessionstate == "playing" )
        {
            playingcount++;
        }
    }
    
    squad.var_2c44544a01cc415e = 1;
    
    if ( playingcount > 0 )
    {
        wait 1;
    }
    
    foreach ( index, player in squad.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( ob_infils_portal::function_cf564904f7af50b3( player ) )
        {
            continue;
        }
        
        player thread coop::player_fade_with_shader( 1, playingcount > 0 ? 0.5 : 0 );
        player val::set( "checkpoint_respawn", "freezecontrols", 1 );
        player val::set( "checkpoint_respawn", "ignoreme", 1 );
        player val::set( "checkpoint_respawn", "damage", 0 );
        player val::set( "checkpoint_respawn_hud", "show_hud", 0 );
        player val::set( "checkpoint_respawn_hud", "show_crosshair", 0 );
    }
    
    if ( playingcount > 0 )
    {
        wait 0.75;
    }
    
    foreach ( index, player in squad.players )
    {
        if ( isalive( player ) && player.sessionstate == "playing" )
        {
            player kill();
        }
    }
    
    spawnpointsused = squad [[ level.var_2a486bda36a2b6e1 ]]( { #spawnpoints:spawnpoints } );
    level callback::callback( #"on_spawn_checkpoint_respawn", { #spawnpointsused:spawnpointsused, #squad:squad } );
    utility::players_stream_wait( squad.players, 6.25 );
    squad.var_2c44544a01cc415e = undefined;
    
    foreach ( index, player in squad.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( ob_infils_portal::function_cf564904f7af50b3( player ) )
        {
            continue;
        }
        
        player val::reset_all( "checkpoint_respawn" );
        player utility::delaythread( 0.4, &val::reset_all, "checkpoint_respawn_hud" );
        player thread coop::player_fade_with_shader( 0, 0.5 );
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x7339f587, Offset: 0xcbf2
// Size: 0x116
function private ob_end_game( params )
{
    if ( level.gameended )
    {
        return;
    }
    
    if ( !isdefined( params ) )
    {
        params = {};
    }
    
    block_end_game = params.block_end_game ?? 0;
    var_f60f0122ff7dcb19 = params.var_f60f0122ff7dcb19 ?? 0;
    time_to_wait = params.time_to_wait ?? level.var_66836fa3819d74f5 ?? 35;
    reason = params.reason ?? "mp_faction_eliminated";
    
    if ( block_end_game )
    {
        level.gameended = 1;
    }
    
    if ( var_f60f0122ff7dcb19 )
    {
        namespace_3a2a361a08f89b78::function_e7342b2976589225();
    }
    
    wait time_to_wait;
    
    if ( block_end_game )
    {
        level.gameended = 0;
    }
    else if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( params.final_check_func ) && ![[ params.final_check_func ]]() )
    {
        return;
    }
    
    save::clear_all();
    level thread gamelogic_mp::endgame( "none", game[ "end_reason" ][ reason ] );
}

// Namespace ob
// Params 1
// Checksum 0x40665719, Offset: 0xcd10
// Size: 0x472
function squad_revive( options )
{
    squad = self;
    assert( isdefined( squad.players ) );
    squad.reviving = 1;
    spawnpointsused = [];
    revivedcount = 0;
    var_2f690832ca1f3dc5 = arraycopy( squad.players );
    
    foreach ( index, player in squad.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player.var_f7b891d8cdeddf0 = undefined;
        player val::set( "squad_revive", "ignoreme", 1 );
        player val::set( "squad_revive", "damage", 0 );
        
        if ( player.sessionstate == "playing" && player player::isreallyalive() && !player.inlaststand )
        {
            var_2f690832ca1f3dc5 = arrayremove( var_2f690832ca1f3dc5, player );
            continue;
        }
        
        if ( options.var_9172157ef0919145 )
        {
            player val::set( "squad_revive", "freezecontrols", 1 );
            player thread coop::player_fade_with_shader( 1, 0, options.fadestartshader ?? "black" );
            player.var_f7b891d8cdeddf0 = 1;
        }
        
        if ( player.sessionstate == "playing" && player.inlaststand )
        {
            player laststand::exit( "last_stand_revived", player );
        }
        
        if ( playerlogic::function_f50f2e6bc47756b7( player.team, player ) )
        {
            player playerlogic::removefromalivecount();
        }
        
        spawnpoint = undefined;
        spawnangles = undefined;
        
        if ( isarray( options.spawnpoints ) )
        {
            spawnpoint = options.spawnpoints[ index ];
        }
        
        if ( !isdefined( spawnpoint ) )
        {
            spawnstruct = ob_infils_portal::function_d90cc6bf931664bd( player );
            spawnpoint = spawnstruct.position;
            spawnangles = spawnstruct.angles;
        }
        
        player thread ob_laststand::function_15ff9d8452ce550( spawnpoint, spawnangles );
        spawnpointsused[ spawnpointsused.size ] = spawnpoint;
        revivedcount++;
    }
    
    if ( options.waitrevived && revivedcount > 0 )
    {
        allrevived = 0;
        
        while ( !allrevived )
        {
            allrevived = 1;
            
            foreach ( index, player in squad.players )
            {
                if ( !isplayer( player ) )
                {
                    continue;
                }
                
                if ( player utility::ent_flag( "team_reviving" ) )
                {
                    allrevived = 0;
                    break;
                }
            }
            
            if ( !allrevived )
            {
                waitframe();
            }
        }
        
        if ( isdefined( var_2f690832ca1f3dc5[ 0 ] ) && options.var_fb469857fbd728c0 )
        {
            squad utility::players_stream_wait( var_2f690832ca1f3dc5 );
        }
    }
    
    foreach ( index, player in squad.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        var_9ad4b18d8bce6f93 = !( player.sessionstate == "playing" && player player::isreallyalive() && !player.inlaststand );
        
        if ( var_9ad4b18d8bce6f93 )
        {
            player playsoundtoplayer( "evt_ob_player_respawn_2d", player );
        }
        
        if ( options.var_fb469857fbd728c0 && player.var_f7b891d8cdeddf0 )
        {
            player thread coop::player_fade_with_shader( 0, 0.5, options.var_a8b863804bbef751 ?? "black" );
            player.var_f7b891d8cdeddf0 = undefined;
        }
        
        player val::reset_all( "squad_revive" );
    }
    
    squad.reviving = undefined;
    return spawnpointsused;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xec358134, Offset: 0xd18b
// Size: 0x85
function private function_22f0ef363443df94( team )
{
    alive_players_on_team = teams::getteamdata( team, "alivePlayers" );
    
    if ( level.laststand && isdefined( alive_players_on_team ) && alive_players_on_team.size > 0 )
    {
        alive_players_on_team[ 0 ] thread ob_laststand::function_564f86a40e69f8d( 0 );
        return;
    }
    
    if ( isdefined( team ) && team != "all" )
    {
        thread onsquadeliminated( teams::getteamdata( team, "players" ) );
        namespace_3a2a361a08f89b78::function_e7342b2976589225();
        gamelogic_mp::default_ondeadevent( team );
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xc4b2c244, Offset: 0xd218
// Size: 0x164
function private function_5f3f40175e5b2290()
{
    level endon( #"game_ended" );
    
    if ( game_utility_mp::function_82e3606d184524fe() == 0 || !level.endgameontimelimit || level.gameended )
    {
        return;
    }
    
    var_78b9080b72b6a9e9 = level.var_78b9080b72b6a9e9;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) || player.var_b7437a2d0279e0ac || player.b_completed_exfil )
        {
            continue;
        }
        
        if ( var_78b9080b72b6a9e9 )
        {
            player thread function_49cccaf6bd6d480d();
            continue;
        }
        
        player thread function_daeaf0f2a453b0fb();
        
        if ( isalive( player ) && player.sessionstate == "playing" )
        {
            player kill();
        }
    }
    
    reason = var_78b9080b72b6a9e9 ? "time_limit_reached" : "mp_faction_eliminated";
    ob_end_game( { #reason:reason, #var_f60f0122ff7dcb19:1, #block_end_game:1 } );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xd737b7c5, Offset: 0xd384
// Size: 0x9c
function private function_6b73b44ec7fbb517( params )
{
    players = params.players;
    
    foreach ( player in players )
    {
        if ( !player )
        {
            continue;
        }
        
        player thread function_49cccaf6bd6d480d();
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x27c0ab9a, Offset: 0xd428
// Size: 0x5c2
function private function_49cccaf6bd6d480d()
{
    player = self;
    player endon( #"death_or_disconnect" );
    
    if ( !isdefined( player ) || player.var_b7437a2d0279e0ac || player.b_completed_exfil )
    {
        return;
    }
    
    player.var_b7437a2d0279e0ac = 1;
    
    if ( !isdefined( player.s_exfil ) )
    {
        player.s_exfil = {};
    }
    
    player function_8ad966643eb205e0( 0 );
    level thread game_utility::fadetoblackforplayer( player, 1, 0.25 );
    wait 0.25;
    player val::set( "exfil", "breath_system", 0 );
    player val::set( "exfil", "cg_drawcrosshair", 0 );
    player val::set( "exfil", "crouch", 0 );
    player val::set( "exfil", "damage", 0 );
    player val::set( "exfil", "gesture", 0 );
    player val::set( "exfil", "allow_jump", 0 );
    player val::set( "exfil", "killstreaks", 0 );
    player val::set( "exfil", "melee", 0 );
    player val::set( "exfil", "offhand_weapons", 0 );
    player val::set( "exfil", "prone", 0 );
    player val::set( "exfil", "sprint", 0 );
    player val::set( "exfil", "supers", 0 );
    player val::set( "exfil", "usability", 0 );
    player val::set( "exfil", "weapon", 0 );
    player val::set( "exfil", "allow_movement", 0 );
    player val::set( "exfil", "fire", 0 );
    player val::set( "exfil", "weapon_switch", 0 );
    player val::set( "exfil", "ignoreme", 1 );
    player val::set( "exfil", "show_weapon_hud", 0 );
    player freezecontrols( 1 );
    player playerhide();
    player cleardamageindicators();
    
    if ( common_instance_inventory::isenabled() && !player.inventoryfinalized )
    {
        self setclientomnvar( "ui_ob_power_tier", ob_power_tier::function_6d4cdb24ee2c66c0() - getdvarint( @"hash_308563c9c75af8a3", level.var_858d230de58cc743.var_de385a6178156735 ?? 0 ) );
        waitframe();
        var_66ebe1680dda711e = getdvarint( @"hash_3dfc0391c5bca8fb", -1 );
        
        if ( var_66ebe1680dda711e > 0 && player function_28ce5f44a5393018() >= var_66ebe1680dda711e )
        {
            behavior = getdvarint( @"hash_9ec878725c4f5b17", 1 );
            logstring( "[OB_PERSIST] Finalized player " + ( player.name ?? "" ) + "with behavior " + behavior + " due to the time limit while inactive." );
        }
        else if ( player get_rescue_token_balance() )
        {
            behavior = getdvarint( @"hash_f0f9f8425f552dde", 3 );
            logstring( "[OB_PERSIST] Finalized player " + ( player.name ?? "" ) + "with behavior " + behavior + " due to the time limit with rescue tokens." );
        }
        else
        {
            behavior = getdvarint( @"hash_7c2feccf51851b39", 0 );
            logstring( "[OB_PERSIST] Finalized player " + ( player.name ?? "" ) + "with behavior " + behavior + " due to the time limit." );
        }
        
        ob_persist::finalize_player( player, behavior );
        waitframe();
    }
    
    if ( isalive( player ) && player.sessionstate == "playing" )
    {
        player playerlogic::removefromalivecount( 1 );
        teams::validatealivecount( "disconnect", player.team, player );
    }
    
    function_82226ec4c6925388( player, 0 );
    gamelogic_mp::processlobbydataforclient( player );
    scoreboard::processcommonplayerdataforplayer( player );
    namespace_3a2a361a08f89b78::processlobbydata();
    level thread game_utility::fadetoblackforplayer( player, 0, 1 );
    player setclientomnvar( "ui_dmz_extract_successful", level.var_bb86f77304f193c4.successontimelimit );
    player setclientomnvar( "ui_br_squad_eliminated_active", 1 );
    player setclientomnvar( "ui_round_end_title", game[ "round_end" ][ level.var_bb86f77304f193c4.successontimelimit ? "victory" : "defeat" ] );
    player setclientomnvar( "ui_round_end_reason", game[ "end_reason" ][ "time_limit_reached" ] );
    
    if ( isdefined( player.matchbonus ) )
    {
        player setclientomnvar( "ui_round_end_match_bonus", player.matchbonus, 1 );
    }
    
    player setclientdvar( @"ui_opensummary", 1 );
    groundposition = getgroundposition( player.origin, 5 );
    
    if ( isdefined( groundposition ) && isdefined( player.angles ) )
    {
        player playerlogic::spawnintermission( { #angles:player.angles, #origin:groundposition + ( 0, 0, 100 ) }, undefined, 0 );
    }
    else if ( isdefined( player.origin ) && isdefined( player.angles ) )
    {
        player playerlogic::spawnintermission( { #angles:player.angles, #origin:player.origin + ( 0, 0, 100 ) }, undefined, 0 );
    }
    else
    {
        player playerlogic::spawnintermission( undefined, undefined, 0 );
    }
    
    if ( !level.var_bb86f77304f193c4.var_aab22481530ff9ff )
    {
        wait 5.5;
        level thread game_utility::fadetoblackforplayer( player, 1, 0.5 );
        wait 0.5;
        level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
    }
}

// Namespace ob
// Params 0
// Checksum 0xb2832929, Offset: 0xd9f2
// Size: 0x46, Type: bool
function is_in_dark_aether()
{
    return getdvarint( @"ob_rift_run", 0 ) || getdvarint( @"hash_596076b5ab54d511", 0 ) || getdvarint( @"hash_c385fef4df4638cb", 0 ) || getdvarint( @"hash_3a4e983e54a9ae7e", 0 );
}

// Namespace ob
// Params 0
// Checksum 0x6cbd315, Offset: 0xda41
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

/#

    // Namespace ob
    // Params 0
    // Checksum 0x7d06d17e, Offset: 0xda52
    // Size: 0xe0, Type: dev
    function debug_draw_teams()
    {
        setdevdvarifuninitialized( @"hash_2ca79cccbf7ca293", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_2ca79cccbf7ca293", 0 ) == 1 )
            {
                enemies = getaiarray();
                
                if ( isdefined( enemies ) && enemies.size > 0 )
                {
                    foreach ( enemy in enemies )
                    {
                        print3d( enemy.origin + ( 0, 0, 60 ), enemy.team );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob
    // Params 0
    // Checksum 0xe86a294b, Offset: 0xdb3a
    // Size: 0xe0, Type: dev
    function debug_draw_aitype()
    {
        setdevdvarifuninitialized( @"hash_f228754ff84bd8d", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_f228754ff84bd8d", 0 ) == 1 )
            {
                enemies = getaiarray();
                
                if ( isdefined( enemies ) && enemies.size > 0 )
                {
                    foreach ( enemy in enemies )
                    {
                        print3d( enemy.origin + ( 0, 0, 60 ), enemy.agent_type );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob
    // Params 0
    // Checksum 0xab0a32bf, Offset: 0xdc22
    // Size: 0x179, Type: dev
    function function_da527c0afdad7853()
    {
        setdevdvarifuninitialized( @"hash_a7493d6bda4d686b", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_a7493d6bda4d686b", 0 ) == 1 )
            {
                enemies = getaiarray();
                
                if ( isdefined( enemies ) && enemies.size > 0 )
                {
                    foreach ( enemy in enemies )
                    {
                        maxarmor = enemy.maxarmorhealth ?? 0;
                        var_e249e05d356c3081 = enemy.maxhelmethealth ?? 0;
                        currentarmor = enemy.armorhealth ?? 0;
                        var_ae85996d361b6302 = enemy.helmethealth ?? 0;
                        print3d( enemy.origin + ( 0, 0, 60 ), "<dev string:x4b2>" + var_ae85996d361b6302 + "<dev string:x4c2>" + var_e249e05d356c3081 );
                        print3d( enemy.origin + ( 0, 0, 80 ), "<dev string:x4c4>" + currentarmor + "<dev string:x4c2>" + maxarmor );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob
    // Params 0
    // Checksum 0xf2a6f52e, Offset: 0xdda3
    // Size: 0x118, Type: dev
    function function_9c1814e69d43f392()
    {
        setdevdvarifuninitialized( @"hash_6411df3f4e8d0b8a", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_6411df3f4e8d0b8a", 0 ) == 1 )
            {
                ai_array = getaiarray();
                
                if ( isdefined( ai_array ) && ai_array.size > 0 )
                {
                    foreach ( enemy in ai_array )
                    {
                        maxhealth = enemy.maxhealth ?? 0;
                        currenthealth = enemy.health ?? 0;
                        print3d( enemy.origin + ( 0, 0, 60 ), "<dev string:x4d3>" + currenthealth + "<dev string:x4c2>" + maxhealth );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob
    // Params 1
    // Checksum 0xa20f5d6, Offset: 0xdec3
    // Size: 0xa7, Type: dev
    function function_9ac37da225e0a1b8( params )
    {
        ammomod = params[ 0 ];
        
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, ammomod );
        }
    }

    // Namespace ob
    // Params 0
    // Checksum 0xd419fed6, Offset: 0xdf72
    // Size: 0x80, Type: dev
    function function_f9cd8503680985ca()
    {
        foreach ( player in level.players )
        {
            player armor::function_164c824617d7e8d7( 1 );
        }
    }

    // Namespace ob
    // Params 0
    // Checksum 0x1c162ed1, Offset: 0xdffa
    // Size: 0x87, Type: dev
    function function_7a329848ee400209()
    {
        foreach ( player in level.players )
        {
            player armor::setarmorhealth( self.maxarmorhealth );
        }
    }

    // Namespace ob
    // Params 1
    // Checksum 0x54954631, Offset: 0xe089
    // Size: 0x890, Type: dev
    function function_77ca5956bfce0c3a( params )
    {
        var_58c716ea2bcfef26 = params[ 0 ];
        give_weapon = params[ 1 ];
        var_1ae6ccd39356a608 = params[ 2 ];
        ammo_mods = [ "<dev string:x4e3>", "<dev string:x4ec>", "<dev string:x4f5>", "<dev string:x501>", "<dev string:x50c>" ];
        perks = [ "<dev string:x519>", "<dev string:x52d>", "<dev string:x543>", "<dev string:x556>", "<dev string:x56a>", "<dev string:x582>", "<dev string:x59d>", "<dev string:x5b0>" ];
        supers = [ "<dev string:x5c4>", "<dev string:x5d8>", "<dev string:x5eb>", "<dev string:x5fd>", "<dev string:x60f>", "<dev string:x624>" ];
        var_8f24b34b8b14a6ed = "<dev string:x636>";
        raygun_weapon_ref = "<dev string:x647>";
        weapon_rarities = [];
        weapon_rarities[ "<dev string:x664>" ] = [];
        weapon_rarities[ "<dev string:x664>" ][ "<dev string:x667>" ] = "<dev string:x66c>";
        weapon_rarities[ "<dev string:x664>" ][ "<dev string:x68b>" ] = "<dev string:x691>";
        weapon_rarities[ "<dev string:x664>" ][ "<dev string:x6b6>" ] = "<dev string:x6bb>";
        weapon_rarities[ "<dev string:x664>" ][ "<dev string:x6df>" ] = "<dev string:x6e6>";
        weapon_rarities[ "<dev string:x664>" ][ "<dev string:x70c>" ] = "<dev string:x713>";
        weapon_rarities[ "<dev string:x739>" ] = [];
        weapon_rarities[ "<dev string:x739>" ][ "<dev string:x667>" ] = "<dev string:x741>";
        weapon_rarities[ "<dev string:x739>" ][ "<dev string:x68b>" ] = "<dev string:x762>";
        weapon_rarities[ "<dev string:x739>" ][ "<dev string:x6b6>" ] = "<dev string:x789>";
        weapon_rarities[ "<dev string:x739>" ][ "<dev string:x6df>" ] = "<dev string:x7af>";
        weapon_rarities[ "<dev string:x739>" ][ "<dev string:x70c>" ] = "<dev string:x7d7>";
        n_power_level = 0;
        
        switch ( var_58c716ea2bcfef26 )
        {
            case #"hash_bd22c9933c8ead48":
                n_power_level = 1;
                break;
            case #"hash_f484b092d351500e":
                n_power_level = 2;
                break;
            case #"hash_b76c1b30b726b92c":
                n_power_level = 3;
                break;
            case #"hash_40f74392d7695be8":
                n_power_level = 3;
                break;
            default:
                n_power_level = 0;
                break;
        }
        
        foreach ( player in level.players )
        {
            zombie_perks::function_37e0f84be7459e57( [ player.name ] );
            waitframe();
            
            if ( var_58c716ea2bcfef26 != "<dev string:x83a>" )
            {
                player armor::setarmorhealth( self.maxarmorhealth );
                waitframe();
                player armor::function_164c824617d7e8d7( 1 );
                waitframe();
                var_e1897080aa3a4026 = randomint( supers.size );
                player perkpackage::perkpackage_givedebug( supers[ var_e1897080aa3a4026 ] );
                waitframe();
                player currency::add_currency_amount( #"essence", 10000 );
                waitframe();
            }
            
            if ( give_weapon == "<dev string:x849>" )
            {
                weapon_name = weapon_rarities[ "<dev string:x664>" ][ "<dev string:x667>" ];
                
                if ( isdefined( var_1ae6ccd39356a608 ) )
                {
                    weapon_name = weapon_rarities[ "<dev string:x664>" ][ var_1ae6ccd39356a608 ];
                }
                
                fakeitem = spawnstruct();
                max_stock_ammo = 180;
                var_827e6c420604dd2 = weapon_name;
                item_bundle = getscriptbundle( "<dev string:x854>" + var_827e6c420604dd2 );
                fakeitem.count = common_item::function_598dd39282efb544( max_stock_ammo );
                player common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem );
                wait 2;
                currentweapon = player getcurrentweapon();
                player pack_a_punch::pap_weapon( currentweapon, int( max( n_power_level - 1, 0 ) ) );
                
                if ( n_power_level > 0 )
                {
                    waitframe();
                    rand_ammo_mod_index = randomint( ammo_mods.size );
                    player ammo_mod::add_ammo_mod_to_weapon( currentweapon, ammo_mods[ rand_ammo_mod_index ] );
                    waitframe();
                }
                
                wait 1.5;
                player inventory_utility::_switchtoweaponimmediate( player.primaryweapons[ 0 ] );
                wait 1.5;
                weapon_name = weapon_rarities[ "<dev string:x739>" ][ "<dev string:x667>" ];
                
                if ( isdefined( var_1ae6ccd39356a608 ) )
                {
                    weapon_name = weapon_rarities[ "<dev string:x739>" ][ var_1ae6ccd39356a608 ];
                }
                
                fakeitem = spawnstruct();
                max_stock_ammo = 180;
                var_827e6c420604dd2 = weapon_name;
                item_bundle = getscriptbundle( "<dev string:x854>" + var_827e6c420604dd2 );
                fakeitem.count = common_item::function_598dd39282efb544( max_stock_ammo );
                player common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem );
                wait 2;
                currentweapon = player getcurrentweapon();
                player pack_a_punch::pap_weapon( currentweapon, int( max( n_power_level - 1, 0 ) ) );
                wait 1.5;
                
                if ( n_power_level > 0 )
                {
                    waitframe();
                    rand_ammo_mod_index = randomint( ammo_mods.size );
                    player ammo_mod::add_ammo_mod_to_weapon( currentweapon, ammo_mods[ rand_ammo_mod_index ] );
                    waitframe();
                }
            }
            
            wait 0.5;
            
            switch ( var_58c716ea2bcfef26 )
            {
                case #"hash_bd22c9933c8ead48":
                    player zombie_perks::give_perk( perks[ 0 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 1 ], 0 );
                    break;
                case #"hash_f484b092d351500e":
                    player zombie_perks::give_perk( perks[ 0 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 1 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 2 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 3 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 4 ], 0 );
                    waitframe();
                    break;
                case #"hash_b76c1b30b726b92c":
                    player zombie_perks::give_perk( perks[ 0 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 1 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 2 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 3 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 4 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 5 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 6 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 7 ], 0 );
                    break;
                case #"hash_40f74392d7695be8":
                    if ( give_weapon == "<dev string:x849>" )
                    {
                        fakeitem = spawnstruct();
                        max_stock_ammo = weaponmaxammo( var_8f24b34b8b14a6ed );
                        item_bundle = getscriptbundle( "<dev string:x854>" + raygun_weapon_ref );
                        fakeitem.count = common_item::function_598dd39282efb544( max_stock_ammo );
                        player common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem );
                        wait 0.25;
                        currentweapon = player getcurrentweapon();
                        player pack_a_punch::pap_weapon( currentweapon, int( max( n_power_level - 1, 0 ) ) );
                        
                        if ( n_power_level > 0 )
                        {
                            waitframe();
                            rand_ammo_mod_index = randomint( ammo_mods.size );
                            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, ammo_mods[ rand_ammo_mod_index ] );
                            waitframe();
                        }
                        
                        wait 0.25;
                        weapon_name = weapon_rarities[ "<dev string:x664>" ][ "<dev string:x667>" ];
                        
                        if ( isdefined( var_1ae6ccd39356a608 ) )
                        {
                            weapon_name = weapon_rarities[ "<dev string:x664>" ][ var_1ae6ccd39356a608 ];
                        }
                        
                        fakeitem = spawnstruct();
                        max_stock_ammo = 180;
                        var_827e6c420604dd2 = weapon_name;
                        item_bundle = getscriptbundle( "<dev string:x854>" + var_827e6c420604dd2 );
                        fakeitem.count = common_item::function_598dd39282efb544( max_stock_ammo );
                        player common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem );
                        wait 0.25;
                        currentweapon = player getcurrentweapon();
                        player pack_a_punch::pap_weapon( currentweapon, int( max( n_power_level - 1, 0 ) ) );
                        
                        if ( n_power_level > 0 )
                        {
                            waitframe();
                            rand_ammo_mod_index = randomint( ammo_mods.size );
                            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, ammo_mods[ rand_ammo_mod_index ] );
                            waitframe();
                        }
                    }
                    
                    wait 0.5;
                    player zombie_perks::give_perk( perks[ 0 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 1 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 2 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 3 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 4 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 5 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 6 ], 0 );
                    wait 0.25;
                    player zombie_perks::give_perk( perks[ 7 ], 0 );
                    break;
                default:
                    if ( give_weapon == "<dev string:x849>" )
                    {
                        fakeitem = spawnstruct();
                        max_stock_ammo = 180;
                        var_827e6c420604dd2 = "<dev string:x864>";
                        item_bundle = getscriptbundle( "<dev string:x854>" + var_827e6c420604dd2 );
                        fakeitem.count = common_item::function_598dd39282efb544( max_stock_ammo );
                        player common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem );
                    }
                    
                    waitframe();
                    break;
            }
        }
    }

    // Namespace ob
    // Params 1
    // Checksum 0x4ae9295, Offset: 0xe921
    // Size: 0x96, Type: dev
    function function_c535ee5b3876f7d5( params )
    {
        value = params[ 0 ];
        
        foreach ( player in level.players )
        {
            player thread function_d5b20260a2b86286( value );
        }
    }

    // Namespace ob
    // Params 1
    // Checksum 0x8f50d366, Offset: 0xe9bf
    // Size: 0x136, Type: dev
    function function_d5b20260a2b86286( value )
    {
        self notify( #"hash_368269951d475425" );
        self endon( #"hash_368269951d475425" );
        self endon( #"disconnect" );
        self endon( #"hash_6bab4ba2a10f5c08" );
        level thread game_utility::fadetoblackforplayer( self, 1, 0.25 );
        wait 0.25;
        level thread game_utility::fadetoblackforplayer( self, 0, 1 );
        utility::hidehudenable();
        function_8ad966643eb205e0( value == "<dev string:x881>", 1 );
        self setclientomnvar( "<dev string:x889>", value == "<dev string:x881>" );
        self setclientomnvar( "<dev string:x8a3>", 1 );
        self setclientomnvar( "<dev string:x8c1>", game[ "<dev string:x8d4>" ][ value == "<dev string:x881>" ? "<dev string:x8de>" : "<dev string:x8e6>" ] );
        
        if ( value == "<dev string:x8ed>" )
        {
            self setclientomnvar( "<dev string:x8f5>", game[ "<dev string:x909>" ][ "<dev string:x914>" ] );
        }
        
        self setclientomnvar( "<dev string:x927>", 1 );
        
        if ( !level.var_bb86f77304f193c4.var_aab22481530ff9ff )
        {
            wait 5.5;
            level thread game_utility::fadetoblackforplayer( self, 1, 0.5 );
            wait 0.5;
            level thread game_utility::fadetoblackforplayer( self, 0, 0.5 );
        }
    }

    // Namespace ob
    // Params 0
    // Checksum 0xcf1922be, Offset: 0xeafd
    // Size: 0xa5, Type: dev
    function function_a2290f08583db867()
    {
        foreach ( player in level.players )
        {
            player notify( #"hash_6bab4ba2a10f5c08" );
            player utility::hidehuddisable();
            player setclientomnvar( "<dev string:x889>", 0 );
            player setclientomnvar( "<dev string:x8a3>", 0 );
        }
    }

    // Namespace ob
    // Params 0
    // Checksum 0x2db77c3a, Offset: 0xebaa
    // Size: 0x1dd, Type: dev
    function function_be7b57a610270cff()
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player.pers[ "<dev string:x93e>" ] ) )
            {
                player.pers[ "<dev string:x93e>" ] = {};
            }
            
            playertelemetry = player.pers[ "<dev string:x93e>" ];
            playertelemetry.eliminations = 2341;
            playertelemetry.eliminations_xp = playertelemetry.eliminations * rank::getscoreinfoxp( #"elimination_kill_normal" );
            playertelemetry.elite_eliminations = 41;
            playertelemetry.elite_eliminations_xp = playertelemetry.elite_eliminations * rank::getscoreinfoxp( #"elimination_kill_elite" );
            playertelemetry.var_7a078a035570e92b = 19;
            playertelemetry.contracts_completed_xp = playertelemetry.var_7a078a035570e92b * rank::getscoreinfoxp( #"hash_b0db9fe6943b84a7" );
            playertelemetry.activities_completed = 27;
            playertelemetry.activities_completed_xp = playertelemetry.activities_completed * rank::getscoreinfoxp( #"hash_901dd58f4f5fbef6" );
            playertelemetry.world_events_completed = 1;
            playertelemetry.var_71230fde1cb2cadd = 1000;
            playertelemetry.special_eliminations = 92;
            playertelemetry.special_eliminations_xp = playertelemetry.special_eliminations;
            playertelemetry.gained_power = 18395;
        }
    }

    // Namespace ob
    // Params 0
    // Checksum 0x1a6b6daf, Offset: 0xed8f
    // Size: 0xe0c, Type: dev
    function function_f453e1a575874d6e()
    {
        level thread debug_draw_teams();
        level thread debug_draw_aitype();
        level thread function_da527c0afdad7853();
        level thread function_9c1814e69d43f392();
        level thread agent_zombie_devgui::function_c007cc2059c63bd4();
        level thread ob_skill_select::init_ob_skill_select_devgui();
        level thread namespace_7d05876ef5beb3c6::init_ob_upgrade_splash_devgui();
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x948>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x956>", "<dev string:x964>", &function_9ac37da225e0a1b8, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x978>", "<dev string:x986>", &function_9ac37da225e0a1b8, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x99a>", "<dev string:x9ac>", &function_9ac37da225e0a1b8, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9c3>", "<dev string:x9d4>", &function_9ac37da225e0a1b8, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9ea>", "<dev string:x9fd>", &function_9ac37da225e0a1b8, 0 );
        devgui::function_77df7fe7dd273e10();
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:xa15>" );
        devgui::add_devgui_func( "<dev string:xa1f>", "<dev string:xa2a>", &function_7a329848ee400209, 0 );
        devgui::add_devgui_func( "<dev string:xa35>", "<dev string:xa46>", &function_f9cd8503680985ca, 0 );
        devgui::function_77df7fe7dd273e10();
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:xa57>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa8b>", "<dev string:xa97>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xac1>", "<dev string:xace>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xaf9>", "<dev string:xb05>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb2f>", "<dev string:xb3d>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb69>", "<dev string:xb77>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xba3>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xbcb>", "<dev string:xbde>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xc01>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa8b>", "<dev string:xc35>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xac1>", "<dev string:xc5e>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xaf9>", "<dev string:xc88>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb2f>", "<dev string:xcb1>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb69>", "<dev string:xcdc>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xd07>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xbcb>", "<dev string:xd2f>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xd51>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa8b>", "<dev string:xd85>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xac1>", "<dev string:xdae>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xaf9>", "<dev string:xdd8>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb2f>", "<dev string:xe01>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb69>", "<dev string:xe2c>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xe57>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xbcb>", "<dev string:xe7f>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xea1>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa8b>", "<dev string:xed5>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xac1>", "<dev string:xf00>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xaf9>", "<dev string:xf2c>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb2f>", "<dev string:xf57>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb69>", "<dev string:xf84>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xfb1>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xbcb>", "<dev string:xfd9>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xffd>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1022>", "<dev string:x102e>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xbcb>", "<dev string:x1053>", &function_77ca5956bfce0c3a, 0 );
        devgui::function_77df7fe7dd273e10();
        waitframe();
        
        if ( getdvarint( @"debug_common_item", 0 ) )
        {
            devgui::function_9082edeb5db93280( "<dev string:x1076>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x108d>", "<dev string:x1095>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x10b5>", "<dev string:x10bd>", &common_item::devgui_spawn_item );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x10e5>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x10f9>", "<dev string:x110c>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1129>", "<dev string:x1146>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x116d>", "<dev string:x1181>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x11b0>", "<dev string:x11c0>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x11ed>", "<dev string:x11fd>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x122a>", "<dev string:x123c>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x126b>", "<dev string:x1286>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x12b2>", "<dev string:x12cb>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x12f2>", "<dev string:x130a>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1330>", "<dev string:x1349>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1374>", "<dev string:x138c>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x13b6>", "<dev string:x13cc>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1407>", "<dev string:x1425>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1468>", "<dev string:x1481>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x14bf>", "<dev string:x14e0>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1526>", "<dev string:x153b>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1575>", "<dev string:x1592>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x15d4>", "<dev string:x15f0>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1631>", "<dev string:x1647>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1677>", "<dev string:x168e>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x16bf>", "<dev string:x16cc>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x16eb>", "<dev string:x16f8>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1717>", "<dev string:x1724>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1743>", "<dev string:x1750>", &common_item::devgui_spawn_item );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x176f>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1787>", "<dev string:x178f>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x17bb>", "<dev string:x17ca>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x17f3>", "<dev string:x1800>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1827>", "<dev string:x1831>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1855>", "<dev string:x1863>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x188b>", "<dev string:x189c>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x18c5>", "<dev string:x18d8>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1903>", "<dev string:x1914>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x193d>", "<dev string:x194e>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1977>", "<dev string:x198a>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x19b5>", "<dev string:x19c0>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x19e5>", "<dev string:x19ef>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1a13>", "<dev string:x1a23>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1a4c>", "<dev string:x1a5a>", &common_item::devgui_spawn_item );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x1a82>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1a9a>", "<dev string:x1aa2>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1ac5>", "<dev string:x1acd>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1af0>", "<dev string:x1afb>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1b21>", "<dev string:x1b2e>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1b54>", "<dev string:x1b60>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1b87>", "<dev string:x1b92>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1bb7>", "<dev string:x1bd0>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1bfd>", "<dev string:x1c0c>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1c2d>", "<dev string:x1c3d>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1c68>", "<dev string:x1c7e>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1cae>", "<dev string:x1cb8>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1cda>", "<dev string:x1cef>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1d1c>", "<dev string:x1d30>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1d5c>", "<dev string:x1d6b>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1d91>", "<dev string:x1d9e>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1dc6>", "<dev string:x1dd1>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1df7>", "<dev string:x1e00>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1e23>", "<dev string:x1e27>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1e46>", "<dev string:x1e57>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1e79>", "<dev string:x1e84>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1ea9>", "<dev string:x1ebe>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1eed>", "<dev string:x1efa>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1f21>", "<dev string:x1f2f>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1f58>", "<dev string:x1f5f>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1f81>", "<dev string:x1f8b>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1fb0>", "<dev string:x1fb8>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1fdb>", "<dev string:x1fe2>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x2004>", "<dev string:x2016>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x2035>", "<dev string:x2041>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x2068>", "<dev string:x207c>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x20a6>", "<dev string:x20b2>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x20d9>", "<dev string:x20e4>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x210a>", "<dev string:x2121>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x2140>", "<dev string:x2146>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x2167>", "<dev string:x2172>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x2192>", "<dev string:x219c>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x21c1>", "<dev string:x21ce>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x21f6>", "<dev string:x21fd>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x221f>", "<dev string:x222e>", &common_item::devgui_spawn_item );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x2254>" );
            var_ede8dc2bd98a820 = getscriptbundle( "<dev string:x226e>" + "<dev string:x227d>" );
            
            if ( isdefined( var_ede8dc2bd98a820 ) )
            {
                foreach ( itementry in var_ede8dc2bd98a820.itementries )
                {
                    if ( !isdefined( itementry.itemspawnentry ) )
                    {
                        continue;
                    }
                    
                    itembundle = getscriptbundle( itementry.itemspawnentry );
                    devgui::function_cd4e263c1f3018ae( itembundle.ref, "<dev string:x2295>" + itembundle.ref, &common_item::devgui_spawn_item );
                }
            }
            
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x22a1>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x22bd>", "<dev string:x22c5>", &common_item::devgui_spawn_item );
            devgui::function_cd4e263c1f3018ae( "<dev string:x22e9>", "<dev string:x22ed>", &common_item::devgui_spawn_item );
            devgui::function_77df7fe7dd273e10();
        }
        
        if ( isarray( level.var_2d9ba93014f6c7ac ) )
        {
            devgui::function_9082edeb5db93280( "<dev string:x230e>" );
            
            foreach ( var_c16c6e0c5ccc25d7 in level.var_2d9ba93014f6c7ac )
            {
                var_bc152547c76d56df = var_c16c6e0c5ccc25d7.var_bc152547c76d56df + 5;
                devgui::function_cd4e263c1f3018ae( var_bc152547c76d56df + "<dev string:x2321>", "<dev string:x232a>" + var_bc152547c76d56df, &function_70107e681e982a4a );
            }
            
            devgui::function_cd4e263c1f3018ae( 5 + "<dev string:x2321>", "<dev string:x2343>", &function_70107e681e982a4a );
            devgui::function_77df7fe7dd273e10();
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x235d>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2365>", "<dev string:x2375>", &function_c535ee5b3876f7d5, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x238a>", "<dev string:x239a>", &function_c535ee5b3876f7d5, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x23ac>", "<dev string:x23bc>", &function_c535ee5b3876f7d5, 0 );
        devgui::add_devgui_func( "<dev string:x23d1>", "<dev string:x23e1>", &function_be7b57a610270cff, 0 );
        devgui::add_devgui_func( "<dev string:x23f5>", "<dev string:x23ff>", &function_a2290f08583db867, 0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x2412>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x241b>", "<dev string:x242e>", &function_bc848d0b05d602fd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2449>", "<dev string:x2458>", &function_bc848d0b05d602fd, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob
    // Params 1, eflags: 0x4
    // Checksum 0xbcaab3ff, Offset: 0xfba3
    // Size: 0x72, Type: dev
    function private function_bc848d0b05d602fd( params )
    {
        switch ( params[ 0 ] )
        {
            case #"hash_685a66df2982bb5":
                InvalidOpCode( 0x44, 2 );
                // Unknown operator ( 0x44, t11, Black Ops 7 )
            case #"hash_96fb661fe80d2c73":
                missiondata = save::mission_get_data();
                missiondata.targetnames = level.struct_class_names[ "<dev string:x2485>" ];
                break;
        }
    }

    // Namespace ob
    // Params 1, eflags: 0x4
    // Checksum 0xf7aad07a, Offset: 0xfc1d
    // Size: 0x86, Type: dev
    function private function_70107e681e982a4a( params )
    {
        if ( level.ob_overtime_settings )
        {
            ob_overtime_time = level.ob_overtime_settings.overtime_time;
        }
        
        n_time_to_end = int( params[ 0 ] );
        ob_overtime_time_ms = getdvarint( @"scr_ob_overtime_time", ob_overtime_time ?? 0 ) * 1000;
        n_time_to_end += ob_overtime_time_ms / 1000;
        setdevdvar( @"scr_devchangetimelimit", n_time_to_end );
    }

#/

// Namespace ob
// Params 0
// Checksum 0xc9926699, Offset: 0xfcab
// Size: 0x5b
function debug_zombie_cheat()
{
    self endon( #"disconnect" );
    
    if ( getdvarint( @"zombie_cheat", 0 ) < 1 || getdvarint( @"zombie_cheat", 0 ) > 3 )
    {
        return;
    }
    
    waitframe();
    currency::add_currency_amount( #"essence", 100000 );
    
    /#
        adddebugcommand( "<dev string:x2490>" );
    #/
}

// Namespace ob
// Params 1
// Checksum 0xe4d29026, Offset: 0xfd0e
// Size: 0x96
function function_cec07f622c5c280e( params )
{
    foreach ( player in level.players )
    {
        player player::_setsuit( params[ 0 ] );
    }
    
    iprintlnbold( "Changing suit to: " + params[ 0 ] );
}

// Namespace ob
// Params 8
// Checksum 0x78ca21fa, Offset: 0xfdac
// Size: 0xc8
function function_45021e00fc76b26b( activity_instance_metadata, var_3f77d5fa92c1edbb, flg_enabled, var_689261288cfc8aba, func_to_run, var_a98d07f7a054ff29, activitytype, varianttag )
{
    utility::flag_init( flg_enabled );
    utility::flag_clear( flg_enabled );
    thread function_1ed3cd42afe47834( var_3f77d5fa92c1edbb, flg_enabled );
    self setscriptablepartstate( "cursor_hint", "usable" );
    self waittill( #"trigger" );
    
    if ( !utility::flag( flg_enabled ) )
    {
        utility::flag_set( flg_enabled );
    }
    
    activityinstance = activity_instance_common::createactivityinstance( activitytype, varianttag, undefined );
    
    if ( isdefined( func_to_run ) )
    {
        activityinstance [[ func_to_run ]]();
    }
    
    if ( isdefined( var_689261288cfc8aba ) )
    {
        iprintln( var_689261288cfc8aba );
    }
}

// Namespace ob
// Params 8
// Checksum 0x711b5b95, Offset: 0xfe7c
// Size: 0xb1
function function_74ea2c137bcaa403( activity_instance_metadata, var_3f77d5fa92c1edbb, flg_enabled, var_689261288cfc8aba, func_to_run, var_a98d07f7a054ff29, activitytype, varianttag )
{
    utility::flag_init( flg_enabled );
    utility::flag_set( flg_enabled );
    
    if ( !( self == level ) && self getscriptablehaspart( "cursor_hint" ) )
    {
        self setscriptablepartstate( "cursor_hint", "used" );
    }
    
    activityinstance = activity_instance_common::createactivityinstance( activitytype, varianttag, undefined );
    
    if ( isdefined( func_to_run ) )
    {
        activityinstance [[ func_to_run ]]();
    }
    
    if ( isdefined( var_689261288cfc8aba ) )
    {
        iprintln( var_689261288cfc8aba );
    }
}

// Namespace ob
// Params 2
// Checksum 0xc9565471, Offset: 0xff35
// Size: 0xa5
function function_1ed3cd42afe47834( var_ed466fad37317edc, var_d965d0d3bc6eec0b )
{
    level endon( #"game_ended" );
    level endon( var_d965d0d3bc6eec0b );
    player_rng = 200;
    
    while ( !utility::flag( var_d965d0d3bc6eec0b ) )
    {
        players = getentarrayinradius( "player", #classname, self.origin, player_rng );
        
        if ( isdefined( players ) && players.size > 0 )
        {
            /#
                print3d( self.origin, var_ed466fad37317edc, ( 1, 1, 1 ), 1, 0.2, 1, 1 );
            #/
        }
        
        waitframe();
    }
}

// Namespace ob
// Params 6
// Checksum 0x94fbd6df, Offset: 0xffe2
// Size: 0x94
function function_b9a6acd0d6a237e5( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance ) || !issubstr( instance.type, "fr_cursorhint" ) )
    {
        return;
    }
    
    if ( instance getscriptablehaspart( "cursor_hint" ) )
    {
        instance setscriptablepartstate( "cursor_hint", "used" );
        instance.user = player;
        instance notify( #"trigger" );
    }
}

// Namespace ob
// Params 1
// Checksum 0xd9e630f7, Offset: 0x1007e
// Size: 0x6c, Type: bool
function function_6e1c0f9f9398767e( player )
{
    platecount = player armor::function_22290101992e4874();
    platemax = player armor::function_db9ebf086f67fe92();
    var_1fd4f9927be13502 = platemax - platecount;
    player armor::function_164c824617d7e8d7( var_1fd4f9927be13502 );
    player damagefeedback::hudicontype( "br_armor" );
    support_box::supportbox_playusesound( player );
    player thread support_box::supportbox_onplayeruseanim();
    return true;
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xb05ba860, Offset: 0x100f3
// Size: 0xa6
function private function_4a14f82bfdcf6482()
{
    var_2cd5b04d98113417 = spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
    
    if ( var_2cd5b04d98113417.size == 0 )
    {
        return;
    }
    
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn_allies_start" );
    attackers = spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
    spawnlogic::registerspawnset( "start_attackers", attackers );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn" );
    spawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    spawnlogic::registerspawnset( "normal", spawns );
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xff3432a, Offset: 0x101a1
// Size: 0x24, Type: bool
function private function_71de78725e6aa3c0()
{
    return level.mapname == "mp_jup_bigmap" || level.mapname == "mp_sat_lm_avalon_ob";
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x4356629f, Offset: 0x101ce
// Size: 0x22c
function private function_e1e35dce0bfd83ce( player )
{
    if ( !isdefined( level.var_5ab633011dc6c590 ) )
    {
        function_a750eeb946ec62dd();
    }
    
    if ( !( isdefined( player ) && isdefined( player.sessionsquadid ) ) )
    {
        return;
    }
    
    if ( isdefined( player.starting_squad_spawn ) )
    {
        return player.starting_squad_spawn;
    }
    
    scriptnoteworthy = level.var_5ab633011dc6c590[ player.sessionsquadid ].script_noteworthy;
    spawngroup = level.var_20ee11961b580423[ scriptnoteworthy ];
    indextoremove = undefined;
    spawnpoint = undefined;
    
    foreach ( index, point in spawngroup )
    {
        indextoremove = index;
        spawnpoint = point;
        break;
    }
    
    if ( !( isdefined( spawnpoint ) && isdefined( indextoremove ) ) )
    {
        return;
    }
    
    player.starting_squad_spawn = spawnpoint;
    
    if ( getdvarint( @"hash_282f4faf2e902127", 1 ) )
    {
        level.var_20ee11961b580423[ scriptnoteworthy ][ indextoremove ] = undefined;
        
        if ( isint( indextoremove ) )
        {
            function_cdc669dbc8ea2101( level.var_20ee11961b580423[ scriptnoteworthy ] );
        }
        
        level.var_20ee11961b580423[ scriptnoteworthy ][ level.var_20ee11961b580423[ scriptnoteworthy ].size ] = spawnpoint;
    }
    else
    {
        level.var_20ee11961b580423[ scriptnoteworthy ][ indextoremove ] = undefined;
    }
    
    var_fe60d0f57ac5a498 = "==OB [PRESTREAM SPAWNS]" + player.name + " picked spawn point at: " + spawnpoint.origin;
    var_fe60d3f57ac5ab31 = "==OB [PRESTREAM SPAWNS]" + player.name + " has sessionsquadid of: " + player.sessionsquadid + ", member index of: " + player.sessionuimemberindex;
    
    /#
        println( var_fe60d0f57ac5a498 );
        println( var_fe60d3f57ac5ab31 );
    #/
    
    logstring( var_fe60d0f57ac5a498 );
    logstring( var_fe60d3f57ac5ab31 );
    return spawnpoint;
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x5f48c7fe, Offset: 0x10403
// Size: 0x386
function private function_a750eeb946ec62dd()
{
    if ( !function_71de78725e6aa3c0() )
    {
        return;
    }
    
    spawnpoints = [];
    
    if ( getdvarint( @"hash_15be61bf160724ef", 1 ) && !get_ob_settings().var_49178f6e5c220274 && !getdvarint( @"hash_2fe0283b419ff08a", 0 ) )
    {
        for ( script_noteworthy = 0; script_noteworthy < 32 ; script_noteworthy++ )
        {
            point = { #index:0, #script_noteworthy:script_noteworthy, #angles:( 0, 0, 0 ), #origin:( 56200, -68000, 18520 ) };
            spawnpoints[ spawnpoints.size ] = point;
            spawnpoints[ spawnpoints.size ] = point;
            spawnpoints[ spawnpoints.size ] = point;
            spawnpoints[ spawnpoints.size ] = point;
        }
    }
    else
    {
        var_8357d50f958d6ce3 = "mp/ob_spawnpoints.csv";
        rownum = tablelookupgetnumrows( "mp/ob_spawnpoints.csv" );
        
        for ( rowindex = 0; rowindex < rownum ; rowindex++ )
        {
            scriptnoteworthy = tablelookupbyrow( var_8357d50f958d6ce3, rowindex, 2 );
            
            if ( !isdefined( scriptnoteworthy ) || scriptnoteworthy == "" )
            {
                continue;
            }
            
            scriptnoteworthy = int( scriptnoteworthy );
            origin = tablelookupbyrow( var_8357d50f958d6ce3, rowindex, 0 );
            origin = strtok( origin, " " );
            origin = ( float( origin[ 0 ] ), float( origin[ 1 ] ), float( origin[ 2 ] ) );
            angles = tablelookupbyrow( var_8357d50f958d6ce3, rowindex, 1 );
            angles = strtok( angles, " " );
            angles = ( float( angles[ 0 ] ), float( angles[ 1 ] ), float( angles[ 2 ] ) );
            spawnpoints[ spawnpoints.size ] = { #index:0, #script_noteworthy:scriptnoteworthy, #angles:angles, #origin:origin };
        }
    }
    
    level.var_5ab633011dc6c590 = arrayrandomize( spawnpoints, function_f3a1c62774ecf8e7() & 65535 );
    spawngroups = [];
    
    if ( getdvarint( @"hash_1f0c801b878349e0", 1 ) )
    {
        foreach ( spawnpoint in spawnpoints )
        {
            if ( !isdefined( spawngroups[ spawnpoint.script_noteworthy ] ) )
            {
                spawngroups[ spawnpoint.script_noteworthy ] = [];
            }
            
            spawngroups[ spawnpoint.script_noteworthy ][ spawngroups[ spawnpoint.script_noteworthy ].size ] = spawnpoint;
        }
    }
    else
    {
        var_afd5a968e27dae5f = getspawnarray( "mp_ob_spawn_start" );
        
        foreach ( spawnpoint in var_afd5a968e27dae5f )
        {
            if ( !isdefined( spawnpoint.script_noteworthy ) )
            {
                continue;
            }
            
            index = int( spawnpoint.script_noteworthy );
            
            if ( !isdefined( spawngroups[ index ] ) )
            {
                spawngroups[ index ] = [];
            }
            
            spawngroups[ index ][ spawngroups[ index ].size ] = spawnpoint;
        }
    }
    
    level.var_20ee11961b580423 = spawngroups;
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xf0ce8902, Offset: 0x10791
// Size: 0x395
function private initspawns()
{
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2.14748e+09, -2.14748e+09, -2.14748e+09 );
    level.squadspawnpointsets = [];
    var_89dee3addf2bb947 = getdvar( @"hash_fbf20cf3ae039362", "" );
    var_19d86366cdf8254b = strtok( var_89dee3addf2bb947, "," );
    var_ef6ab45ad62abdfa = getdvar( @"hash_81ecb9cb95ca6315", "" );
    var_23e7d1f0fc32c4e = strtok( var_ef6ab45ad62abdfa, "," );
    var_afd5a968e27dae5f = getspawnarray( "mp_ob_spawn_start" );
    var_a9e9025a9b5787d7 = max( var_afd5a968e27dae5f.size, 32 );
    
    for ( i = 0; i < var_a9e9025a9b5787d7 ; i++ )
    {
        squadspawnpoints = [];
        
        foreach ( spawnpoint in var_afd5a968e27dae5f )
        {
            if ( var_19d86366cdf8254b.size && arraycontains( var_19d86366cdf8254b, spawnpoint.script_noteworthy ) )
            {
                continue;
            }
            
            if ( var_23e7d1f0fc32c4e.size && !arraycontains( var_23e7d1f0fc32c4e, spawnpoint.script_noteworthy ) )
            {
                continue;
            }
            
            v_ground = getgroundposition( spawnpoint.origin, 32, 100, 1000 );
            
            if ( spawnpoint.origin[ 2 ] < v_ground[ 2 ] )
            {
                spawnpoint.v_original_origin = spawnpoint.origin;
                spawnpoint.origin = v_ground;
            }
            else if ( !isdefined( v_ground ) || spawnpoint.origin[ 2 ] > v_ground[ 2 ] && spawnpoint.origin[ 2 ] - v_ground[ 2 ] >= 1000 )
            {
                continue;
            }
            
            if ( int( spawnpoint.script_noteworthy ) == i )
            {
                level.spawnmins = spawnlogic::expandmins( level.spawnmins, spawnpoint.origin );
                level.spawnmaxs = spawnlogic::expandmaxs( level.spawnmaxs, spawnpoint.origin );
                squadspawnpoints[ squadspawnpoints.size ] = spawnpoint;
            }
        }
        
        if ( squadspawnpoints.size > 0 )
        {
            assert( squadspawnpoints.size >= level.maxsquadsize, "<dev string:x2495>" + level.maxsquadsize + "<dev string:x24e2>" + squadspawnpoints.size + "<dev string:x24ec>" );
            level.squadspawnpointsets[ level.squadspawnpointsets.size ] = squadspawnpoints;
        }
    }
    
    if ( isdefined( level.squadspawnpointsets ) && level.squadspawnpointsets.size )
    {
        n_index = randomint( level.squadspawnpointsets.size );
        var_4c1d25fba26a6bde = [];
        
        for ( i = 0; i < level.squadspawnpointsets.size ; i++ )
        {
            var_4c1d25fba26a6bde[ i ] = level.squadspawnpointsets[ n_index ];
            n_index++;
            
            if ( n_index > level.squadspawnpointsets.size - 1 )
            {
                n_index -= level.squadspawnpointsets.size;
            }
        }
        
        level.squadspawnpointsets = var_4c1d25fba26a6bde;
    }
    
    level.obspawnarray = var_afd5a968e27dae5f;
    
    if ( level.var_9cf78b20e77139e1 )
    {
        function_4a14f82bfdcf6482();
    }
    
    spawnlogic::finalizemap();
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xcf4bae99, Offset: 0x10b2e
// Size: 0x12b
function private function_842e2b51b1a14fd5( player )
{
    if ( isdefined( player.starting_squad_spawn ) )
    {
        return player.starting_squad_spawn;
    }
    
    spawnpoint = undefined;
    
    if ( player.sessionsquadid < level.squadspawnpointsets.size )
    {
        squadspawnpoints = level.squadspawnpointsets[ player.sessionsquadid ];
        spawnpoint = squadspawnpoints[ player.sessionuimemberindex ];
    }
    
    if ( !isdefined( spawnpoint ) && level.squadspawnpointsets.size )
    {
        squadspawnpoints = level.squadspawnpointsets[ 0 ];
        spawnpoint = squadspawnpoints[ player.sessionuimemberindex ];
        
        if ( !isdefined( spawnpoint ) )
        {
            spawnpoint = squadspawnpoints[ 0 ];
        }
        
        if ( isdefined( spawnpoint ) )
        {
            println( "<dev string:x24ee>" + player.sessionsquadid + "<dev string:x252f>" + player.sessionuimemberindex + "<dev string:x2540>" );
            logstring( "==OB SPAWN Not enough spawn points in array found for Squad ID: " + player.sessionsquadid + ", Member Index: " + player.sessionuimemberindex + " so using index 0 in spawn array as a fallback" );
        }
    }
    
    player.starting_squad_spawn = spawnpoint;
    return spawnpoint;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x8fa695e9, Offset: 0x10c62
// Size: 0xb0
function private function_abf55ebc4bf1d404( player )
{
    a_squad_players = player squad_utility::getsquadmembers( undefined, 1 );
    a_alive_players = teams::getteamdata( player.team, "alivePlayers" );
    s_spawn_info = function_d6d6b6cb0f58c78b( a_squad_players ) ?? function_d6d6b6cb0f58c78b( a_alive_players );
    
    if ( isdefined( s_spawn_info ) )
    {
        return s_spawn_info;
    }
    
    if ( level.obspawnarray.size > 0 )
    {
        return level.obspawnarray[ randomint( level.obspawnarray.size ) ];
    }
    
    /#
        iprintlnbold( "<dev string:x256f>" + player.sessionsquadid + "<dev string:x25ab>" );
    #/
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x2221ce19, Offset: 0x10d1b
// Size: 0x14b
function private function_d6d6b6cb0f58c78b( a_players )
{
    a_players = arrayremove( a_players, self );
    a_players = arrayrandomize( a_players );
    s_spawn_info = spawnstruct();
    min = 75;
    max = 100;
    
    foreach ( other_player in a_players )
    {
        random_x = randomintrange( min, max ) * ( utility::cointoss() ? 1 : -1 );
        random_y = randomintrange( min, max ) * ( utility::cointoss() ? 1 : -1 );
        s_spawn_info.origin = getclosestpointonnavmesh( other_player.origin + ( random_x, random_y, 0 ) );
        
        if ( !isdefined( s_spawn_info.origin ) )
        {
            continue;
        }
        
        s_spawn_info.angles = other_player.angles;
        s_spawn_info.index = 0;
        return s_spawn_info;
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xdc9795a4, Offset: 0x10e6e
// Size: 0x6d
function private function_24bb5c2aa0708efb( params )
{
    if ( function_7a4b6c8d8f5f0853() )
    {
        emp_debuff::add_emp_ent( self );
        emp_debuff::set_apply_emp_callback( &function_fe1207aba7e5a04 );
    }
    
    if ( self.classname == "actor_sat_spawner_zombie_base_ob_harrow" )
    {
        playfx( utility::getfx( "vfx_sat_spawner_zombie_base_ob_harrow_spawn_in" ), self.origin + ( 0, 0, 32 ) );
        self.nocorpse = 1;
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x99429727, Offset: 0x10ee3
// Size: 0x11, Type: bool
function private function_7a4b6c8d8f5f0853()
{
    return self.aicategory == "normal";
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x1d21b98a, Offset: 0x10efd
// Size: 0x2f
function private function_fe1207aba7e5a04( params )
{
    utility::callsharedfunc( #"zombie", #"stunZombie", 1.5, "stunned_on" );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xa381851a, Offset: 0x10f34
// Size: 0xbb
function private function_ef109129414097fb( params )
{
    if ( self.classname == "actor_sat_spawner_zombie_base_ob_harrow" )
    {
        if ( isdefined( params.eattacker ) && params.eattacker.classname == "worldspawn" )
        {
            playfx( utility::getfx( "vfx_sat_spawner_zombie_base_ob_harrow_spawn_out" ), self.origin );
        }
        
        if ( params.objweapon.basename == "energy_mine" || params.objweapon.classname == "throwingknife" )
        {
            playfx( utility::getfx( "vfx_sat_spawner_zombie_base_ob_harrow_death" ), self.origin );
        }
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x242d28f7, Offset: 0x10ff7
// Size: 0x138
function private function_c0383f1863e317ec()
{
    setclientnamemode( "auto_change" );
    
    if ( isdefined( level.var_1885dec6f8399bd0 ) )
    {
        thread [[ level.var_1885dec6f8399bd0 ]]();
    }
    else
    {
        ob_infils::obinfil_init();
    }
    
    game_utility_mp::setobjectivetext( "allies", &"objectives/ob" );
    game_utility_mp::setobjectivescoretext( "allies", &"objectives/ob_score" );
    game_utility_mp::setobjectivehinttext( "allies", &"objectives/ob_hint" );
    
    if ( !isdefined( level.var_4ff066f519fa9449 ) || ![[ level.var_4ff066f519fa9449 ]]() )
    {
        initspawns();
    }
    
    if ( team_assimilation::function_8fe74e094005f15d() )
    {
        level.splashlistoverride = "splash_list_jup_ob";
        level thread team_assimilation::init();
        utility::registersharedfunc( #"hud", #"showbrdmzsplash", &br_gametype_dmz::showdmzsplash );
        
        if ( getdvarint( @"hash_231e75b4e3b83cb0", 0 ) )
        {
            utility::callsharedfunc( #"pleaforhelp", #"hash_4c2d49f7b099c110" );
        }
    }
    
    bradley_spawner::inittankspawns();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
    
    if ( var_32dbca3143d9c4a5 && self [[ var_32dbca3143d9c4a5 ]]() )
    {
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xab4cd976, Offset: 0x11137
// Size: 0x131
function private function_e48d80448b8e47b6()
{
    spawnpoint = undefined;
    
    if ( function_71de78725e6aa3c0() && getdvarint( @"hash_ea2511831ad6764e", 1 ) )
    {
        spawnpoint = function_e1e35dce0bfd83ce( self );
        
        if ( !isdefined( spawnpoint ) )
        {
            spawnpoint = function_842e2b51b1a14fd5( self );
        }
        
        if ( !isdefined( spawnpoint ) && level.var_9cf78b20e77139e1 )
        {
            spawnlogic::activatespawnset( "start_attackers", 1 );
            spawnpoint = spawnlogic::getspawnpoint( self, "allies", undefined, "start_attackers" );
        }
    }
    else if ( spawnlogic::shoulduseteamstartspawn() )
    {
        spawnpoint = function_842e2b51b1a14fd5( self );
        
        if ( !isdefined( spawnpoint ) && level.var_9cf78b20e77139e1 )
        {
            spawnlogic::activatespawnset( "start_attackers", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, "allies", undefined, "start_attackers" );
        }
    }
    else
    {
        spawnpoint = function_abf55ebc4bf1d404( self );
        
        if ( !isdefined( spawnpoint ) && level.var_9cf78b20e77139e1 )
        {
            spawnlogic::activatespawnset( "normal", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, "allies", undefined, "normal" );
        }
    }
    
    assert( isdefined( spawnpoint ), "<dev string:x25df>" + self.sessionsquadid + "<dev string:x2603>" + self.sessionuimemberindex );
    return spawnpoint;
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x27d42052, Offset: 0x11271
// Size: 0x296
function private function_f700821c03e96ff2()
{
    level endon( #"game_ended" );
    utility::flag_wait( "wallbuy_ready" );
    
    if ( isdefined( level.var_38f42d124c1fc599 ) )
    {
        var_8cca7b5a1f89eee4 = [];
        
        foreach ( var_a2d5c07a0ea12ae in level.var_38f42d124c1fc599 )
        {
            if ( isdefined( var_a2d5c07a0ea12ae.wallbuy_scriptable ) )
            {
                region = region_difficulty_manager::function_f9fbb630598afdc7( var_a2d5c07a0ea12ae.origin );
                
                if ( isdefined( region ) )
                {
                    if ( !isdefined( var_8cca7b5a1f89eee4[ region.index ] ) )
                    {
                        var_8cca7b5a1f89eee4[ region.index ] = [];
                        var_8cca7b5a1f89eee4[ region.index ][ "white" ] = 0;
                        var_8cca7b5a1f89eee4[ region.index ][ "green" ] = 0;
                        var_8cca7b5a1f89eee4[ region.index ][ "blue" ] = 0;
                        var_8cca7b5a1f89eee4[ region.index ][ "purple" ] = 0;
                        var_8cca7b5a1f89eee4[ region.index ][ "orange" ] = 0;
                        var_8cca7b5a1f89eee4[ region.index ][ "total" ] = 1;
                        continue;
                    }
                    
                    var_8cca7b5a1f89eee4[ region.index ][ "total" ]++;
                }
            }
        }
        
        wallbuykeys = arrayrandomize( getarraykeys( level.var_38f42d124c1fc599 ) );
        
        foreach ( key in wallbuykeys )
        {
            var_a2d5c07a0ea12ae = level.var_38f42d124c1fc599[ key ];
            
            if ( isdefined( var_a2d5c07a0ea12ae.wallbuy_scriptable ) )
            {
                region = region_difficulty_manager::function_f9fbb630598afdc7( var_a2d5c07a0ea12ae.origin );
                
                if ( isdefined( region ) )
                {
                    difficulty = region_difficulty_manager::get_region_difficulty( var_a2d5c07a0ea12ae.origin );
                    var_7c0d29caa7b948c6 = function_b133d479b74617ca( var_8cca7b5a1f89eee4, region, difficulty );
                    var_8cca7b5a1f89eee4[ region.index ][ var_7c0d29caa7b948c6 ]++;
                }
                else
                {
                    var_7c0d29caa7b948c6 = "green";
                }
                
                namespace_a2d5c07a0ea12ae::function_6ad7ea470d0872aa( var_a2d5c07a0ea12ae, var_7c0d29caa7b948c6 );
                waitframe();
            }
        }
    }
}

// Namespace ob
// Params 3
// Checksum 0x9cc181f, Offset: 0x1150f
// Size: 0x26c
function function_b133d479b74617ca( var_8cca7b5a1f89eee4, region, difficulty )
{
    var_43aa7486a8e3de18 = var_8cca7b5a1f89eee4[ region.index ][ "white" ];
    var_4f3c4a7addf06187 = var_8cca7b5a1f89eee4[ region.index ][ "green" ];
    var_eee9775b441c3881 = var_8cca7b5a1f89eee4[ region.index ][ "blue" ];
    var_b2ddf6fd16c3f84c = var_8cca7b5a1f89eee4[ region.index ][ "purple" ];
    var_63c123f5676b45ae = var_8cca7b5a1f89eee4[ region.index ][ "orange" ];
    var_4aa2be259b0c6791 = var_8cca7b5a1f89eee4[ region.index ][ "total" ];
    var_7c0d29caa7b948c6 = "white";
    
    switch ( difficulty )
    {
        case #"hash_7bb2cd766703d463":
        case #"hash_a1e09f51896088fb":
            var_7c0d29caa7b948c6 = "green";
            
            if ( var_43aa7486a8e3de18 < var_4aa2be259b0c6791 * 0 )
            {
                var_7c0d29caa7b948c6 = "white";
            }
            else if ( var_4f3c4a7addf06187 < var_4aa2be259b0c6791 * 0.7 )
            {
                var_7c0d29caa7b948c6 = "green";
            }
            else if ( var_eee9775b441c3881 < var_4aa2be259b0c6791 * 0.2 )
            {
                var_7c0d29caa7b948c6 = "blue";
            }
            else if ( var_b2ddf6fd16c3f84c < var_4aa2be259b0c6791 * 0.1 )
            {
                var_7c0d29caa7b948c6 = "purple";
            }
            
            break;
        case #"hash_af83e47edfa8900a":
            var_7c0d29caa7b948c6 = "blue";
            
            if ( var_4f3c4a7addf06187 < var_4aa2be259b0c6791 * 0.2 )
            {
                var_7c0d29caa7b948c6 = "green";
            }
            else if ( var_eee9775b441c3881 < var_4aa2be259b0c6791 * 0.55 )
            {
                var_7c0d29caa7b948c6 = "blue";
            }
            else if ( var_b2ddf6fd16c3f84c < var_4aa2be259b0c6791 * 0.25 )
            {
                var_7c0d29caa7b948c6 = "purple";
            }
            else if ( var_63c123f5676b45ae < var_4aa2be259b0c6791 * 0 )
            {
                var_7c0d29caa7b948c6 = "orange";
            }
            
            break;
        case #"hash_5343b465e56ec9a4":
            var_7c0d29caa7b948c6 = "purple";
            
            if ( var_eee9775b441c3881 < var_4aa2be259b0c6791 * 0 )
            {
                var_7c0d29caa7b948c6 = "blue";
            }
            else if ( var_b2ddf6fd16c3f84c < var_4aa2be259b0c6791 * 0.4 )
            {
                var_7c0d29caa7b948c6 = "purple";
            }
            else if ( var_63c123f5676b45ae < var_4aa2be259b0c6791 * 0.6 )
            {
                var_7c0d29caa7b948c6 = "orange";
            }
            
            break;
        case #"hash_651f76c0ad6741ec":
            var_7c0d29caa7b948c6 = "orange";
            
            if ( var_b2ddf6fd16c3f84c < var_4aa2be259b0c6791 * 0.4 )
            {
                var_7c0d29caa7b948c6 = "purple";
            }
            else if ( var_63c123f5676b45ae < var_4aa2be259b0c6791 * 0.6 )
            {
                var_7c0d29caa7b948c6 = "orange";
            }
            
            break;
    }
    
    return var_7c0d29caa7b948c6;
}

// Namespace ob
// Params 2
// Checksum 0x432322fa, Offset: 0x11784
// Size: 0x75
function ongrenadeused( weaponname, grenade )
{
    weapon = utility::function_64003742d8f5c781( weaponname );
    
    switch ( weapon.basenamehash )
    {
        case %"sat_aether_blade_ob":
            thread utility::callsharedfunc( #"aether_blade", #"hash_9f1b33881342c2c7", grenade );
            break;
        default:
            break;
    }
}

// Namespace ob
// Params 1
// Checksum 0x3cafa8e9, Offset: 0x11801
// Size: 0xd, Type: bool
function function_b1df1ea3cf62da44( sweapon )
{
    return false;
}

// Namespace ob
// Params 0
// Checksum 0xe8357159, Offset: 0x11817
// Size: 0x55
function setuplivingworld()
{
    if ( getdvarint( @"ob_living_world", 1 ) == 0 )
    {
        return;
    }
    
    level.vehiclealarmtime = 20;
    level.var_ceb922993e45aec6 = utility::function_4b74c15943231980( 120 );
    callback::add( "car_alarm_on", &car_alarm_on );
    callback::add( "car_alarm_off", &car_alarm_off );
}

// Namespace ob
// Params 2
// Checksum 0xc76a684c, Offset: 0x11874
// Size: 0x3c, Type: bool
function function_5bd8e4c660e9977a( attractor, zombie )
{
    if ( zombie.aicategory == "normal" )
    {
        return ( zombie.team == "team_two_hundred" );
    }
    
    return false;
}

// Namespace ob
// Params 1
// Checksum 0x8f1d8f7a, Offset: 0x118b9
// Size: 0xde
function car_alarm_on( params )
{
    if ( !isent( params.vehicle ) )
    {
        return;
    }
    
    params.vehicle thread car_alarm_death();
    level zombie_attractor_manager::function_7eb1aaa8bc7cc15( params.vehicle, undefined, 512, 1, &car_goal_location, &function_5bd8e4c660e9977a, undefined );
    params.vehicle endon( #"car_alarm_complete" );
    teams = [ "team_two_hundred", "team_hundred_ninety", "axis" ];
    
    while ( isdefined( params.vehicle ) )
    {
        event::event_broadcast_generic( "decoy_grenade", getclosestpointonnavmesh( params.vehicle.origin ), 1500, params.vehicle, teams );
        wait 1;
    }
}

// Namespace ob
// Params 0
// Checksum 0xf8e6273d, Offset: 0x1199f
// Size: 0x30
function car_alarm_death()
{
    self notify( #"car_alarm_complete" );
    self endon( #"car_alarm_complete" );
    self waittill( #"death" );
    level zombie_attractor_manager::function_dcfb4c31f1d97cd2( self );
}

// Namespace ob
// Params 1
// Checksum 0x9c2749fa, Offset: 0x119d7
// Size: 0x49
function car_alarm_off( params )
{
    params.vehicle notify( #"car_alarm_complete" );
    
    if ( !isent( params.vehicle ) )
    {
        return;
    }
    
    level zombie_attractor_manager::function_dcfb4c31f1d97cd2( params.vehicle );
}

// Namespace ob
// Params 2
// Checksum 0xccb86bee, Offset: 0x11a28
// Size: 0x72
function car_goal_location( attractor, zombie )
{
    var_6271e36734e22cd3 = level zombie_attractor_manager::get_attractor_obb( attractor );
    var_a4ec8f192ced84e2 = math::function_1243a6cc6a030f2a( zombie.origin, var_6271e36734e22cd3.origin, var_6271e36734e22cd3.half_size * 0.25, var_6271e36734e22cd3.angles );
    return getclosestpointonnavmesh( var_a4ec8f192ced84e2 );
}

// Namespace ob
// Params 0
// Checksum 0x54bdf5a9, Offset: 0x11aa3
// Size: 0x5e
function watch_third_person()
{
    if ( getdvarint( @"ob_third_person", 1 ) == 0 )
    {
        return;
    }
    
    thread function_8f0941e4910c2d09();
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "ob_down_press", "+actionslot 2" );
        self notifyonplayercommand( "ob_down_release", "-actionslot 2" );
        self notifyonplayercommand( "ob_down_toggle", "third_person_toggle" );
    }
    
    thread function_947ad0e23995cada();
}

// Namespace ob
// Params 0
// Checksum 0xdaa13147, Offset: 0x11b09
// Size: 0x11a
function function_947ad0e23995cada()
{
    self endon( #"disconnect" );
    var_3cb45f3e8fffbb05 = 0;
    hold_button_time = 500;
    var_2e7980c6e49ab862 = hold_button_time / 1000;
    var_d3081cc8b026a873 = 1000;
    value = undefined;
    
    while ( true )
    {
        if ( var_3cb45f3e8fffbb05 == 0 )
        {
            value = utility::waittill_any_return( "ob_down_press", "ob_down_release", "ob_down_toggle" );
        }
        else
        {
            value = utility::waittill_any_timeout( var_2e7980c6e49ab862, "ob_down_release" );
        }
        
        if ( !isalive( self ) || !isdefined( value ) )
        {
            continue;
        }
        
        if ( isdefined( self.var_6eec07112ad043b8 ) && gettime() < self.var_6eec07112ad043b8 + var_d3081cc8b026a873 )
        {
            var_3cb45f3e8fffbb05 = 0;
            continue;
        }
        
        var_f1a4fb89f4d20731 = 0;
        
        if ( value == "ob_down_release" )
        {
            var_3cb45f3e8fffbb05 = 0;
        }
        else if ( value == "timeout" || value == "ob_down_toggle" )
        {
            var_f1a4fb89f4d20731 = 1;
            var_3cb45f3e8fffbb05 = 0;
        }
        else if ( var_3cb45f3e8fffbb05 == 0 )
        {
            var_3cb45f3e8fffbb05 = gettime();
        }
        
        if ( var_f1a4fb89f4d20731 )
        {
            function_34c3c4b41d5d08ac();
        }
    }
}

// Namespace ob
// Params 1
// Checksum 0xf3804882, Offset: 0x11c2b
// Size: 0xf2
function function_34c3c4b41d5d08ac( override )
{
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x260c>" );
        return;
    }
    
    if ( self.disable_third_person_toggle )
    {
        return;
    }
    
    var_2a0ed06899021dec = getdvarint( @"hash_c507ccdd176eb91c", 0 );
    
    if ( var_2a0ed06899021dec && self.var_ca6ca955f2c4c8af && gettime() - self.var_ca6ca955f2c4c8af < var_2a0ed06899021dec )
    {
        return;
    }
    
    self.var_ca6ca955f2c4c8af = undefined;
    
    if ( isdefined( self.var_7efe9d6a267112b9 ) )
    {
        return;
    }
    
    if ( ob_should_disable_third_person_toggle( self ) )
    {
        return;
    }
    
    if ( isalive( self ) && !vehicle_occupancy::function_3080323254ba6900( self ) )
    {
        var_4e696c1264ef4e4a = self getcamerathirdperson();
        
        if ( isdefined( override ) )
        {
            var_4e696c1264ef4e4a = !override;
        }
        
        self setcamerathirdperson( !var_4e696c1264ef4e4a );
        self setclientomnvar( "ui_toggle_third_person", !var_4e696c1264ef4e4a );
        self setplayerdata( "common", "mpProgression", "thirdPerson", !var_4e696c1264ef4e4a );
    }
}

// Namespace ob
// Params 1
// Checksum 0x128409a9, Offset: 0x11d25
// Size: 0x13
function switch_camera_view( value )
{
    function_34c3c4b41d5d08ac();
}

// Namespace ob
// Params 1
// Checksum 0x1084411e, Offset: 0x11d40
// Size: 0x67
function function_8f0941e4910c2d09( params )
{
    self endon( #"disconnect" );
    level utility::flag_wait( "ob_infil_completed" );
    waitframe();
    var_2f074dacf1c6f38f = self getplayerdata( "common", "mpProgression", "thirdPerson" );
    
    if ( !isdefined( var_2f074dacf1c6f38f ) )
    {
        return;
    }
    
    if ( var_2f074dacf1c6f38f )
    {
        function_34c3c4b41d5d08ac( 1 );
        return;
    }
    
    function_34c3c4b41d5d08ac( 0 );
}

// Namespace ob
// Params 2
// Checksum 0x74b21322, Offset: 0x11daf
// Size: 0xeb
function function_87a21a3e41dc2e5d( kiosk, player )
{
    if ( isdefined( kiosk.regiondifficulty ) )
    {
        return;
    }
    
    var_8de44035c62f2f4f = region_difficulty_manager::get_region_difficulty( kiosk.origin );
    ref = undefined;
    
    switch ( var_8de44035c62f2f4f )
    {
        case #"hash_7bb2cd766703d463":
            ref = "_ob_green";
            break;
        case #"hash_af83e47edfa8900a":
            ref = "_ob_yellow";
            break;
        case #"hash_5343b465e56ec9a4":
            ref = "_ob_orange";
            break;
        case #"hash_651f76c0ad6741ec":
            ref = "_ob_red";
            break;
    }
    
    if ( isdefined( ref ) )
    {
        projectname = tolower( getprojectname() );
        kiosk.regiondifficulty = var_8de44035c62f2f4f;
        kiosk.overrideindex = common_kiosk::function_9d041619b6fccf18( projectname + ref );
    }
}

// Namespace ob
// Params 3
// Checksum 0x98895a88, Offset: 0x11ea2
// Size: 0x7e
function ob_scriptable_set_minimap_floor( scriptable, objectivepart, var_532aa5e9196e01c5 = 1 )
{
    if ( !( isent( scriptable ) && scriptable isscriptable() ) && !( !isent( scriptable ) && scriptable isscriptableinstance() ) )
    {
        return;
    }
    
    if ( !scriptable getscriptablehaspart( objectivepart ) )
    {
        return;
    }
    
    if ( var_532aa5e9196e01c5 )
    {
        scriptable setscriptablepartstate( objectivepart, "active" );
    }
    
    scriptable utility::ent_flag_set( "minimap_floor_setup_complete" );
}

// Namespace ob
// Params 1
// Checksum 0xfc236137, Offset: 0x11f28
// Size: 0x114
function function_c837736567972df( origin )
{
    region = region_difficulty_manager::function_f9fbb630598afdc7( origin );
    
    if ( isdefined( region ) )
    {
        difficulty = region_difficulty_manager::get_region_difficulty( origin );
        var_bb86f77304f193c4 = get_ob_settings();
        
        if ( difficulty == "difficulty_easy" )
        {
            return ( var_bb86f77304f193c4.var_49178f6e5c220274 ? %"hash_5e2e5febe270612e" : %"hash_62a62052c4641fb4" );
        }
        else if ( difficulty == "difficulty_normal" )
        {
            return ( var_bb86f77304f193c4.var_49178f6e5c220274 ? %"hash_5e2e5eebe2705f7b" : %"hash_62a62352c46424cd" );
        }
        else if ( difficulty == "difficulty_hard" )
        {
            return ( var_bb86f77304f193c4.var_49178f6e5c220274 ? %"hash_5e2e5debe2705dc8" : %"hash_62a62252c464231a" );
        }
        else if ( difficulty == "difficulty_darkaether" || difficulty == "difficulty5" || difficulty == "difficulty6" )
        {
            return %"hash_62a61d52c4641a9b";
        }
    }
    
    return %"hash_62a62052c4641fb4";
}

// Namespace ob
// Params 1
// Checksum 0x6da84088, Offset: 0x12045
// Size: 0x37, Type: bool
function function_7175a27043635515( ai )
{
    if ( ai.aicategory == "boss" )
    {
        return true;
    }
    
    if ( level.players.size < 3 )
    {
        return false;
    }
    
    return true;
}

// Namespace ob
// Params 1
// Checksum 0x56590422, Offset: 0x12085
// Size: 0x1c4
function function_1c6fa94687dab0f7( player )
{
    player callback::add( #"hash_1c82c96d0d334fcc", &function_30a99fc360b7ad21 );
    var_bb86f77304f193c4 = get_ob_settings();
    var_bc533c47307aeca8 = isdefined( var_bb86f77304f193c4 ) && istrue( var_bb86f77304f193c4.var_bc533c47307aeca8 );
    
    while ( isdefined( player ) )
    {
        player.wingsuitenabled = getdvarint( @"hash_7a55eeee7c09274d", 1 ) == 1 && var_bc533c47307aeca8;
        player waittill( #"skydive_deployparachute" );
        level callback::callback( #"wingsuit_begin", { #player:player } );
        
        if ( player.wingsuitenabled )
        {
            player attach( %"c_sat_gear_wingsuit_flaps_02_blackops" );
        }
        
        player thread parachute::infilparachutevfx( 1, 0, istrue( player.var_8b4dd1978732538 ) );
        var_7fc83b11ade25e3f = [ "skydive_end", "last_stand_enter", "death_or_disconnect" ];
        
        if ( getdvarint( @"hash_511a0b121e17b192", 1 ) == 1 )
        {
            var_7fc83b11ade25e3f[ var_7fc83b11ade25e3f.size ] = "skydive_touch";
        }
        
        player utility::waittill_any_in_array( var_7fc83b11ade25e3f );
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        level callback::callback( #"wingsuit_end", { #player:player } );
        
        if ( player.wingsuitenabled )
        {
            player detach( %"c_sat_gear_wingsuit_flaps_02_blackops" );
            
            if ( getdvarint( @"hash_7d59269051759e99", 1 ) )
            {
                player utility::callsharedfunc( #"hint", #"close", "hint_wingsuit_dive", 1 );
            }
        }
        
        player setshowcontrail( 0 );
        
        if ( player.inlaststand )
        {
            player skydive_interrupt();
        }
    }
}

// Namespace ob
// Params 1
// Checksum 0x63547fef, Offset: 0x12251
// Size: 0x88
function function_30a99fc360b7ad21( params )
{
    if ( isplayer( self ) && getdvarint( @"hash_7a55eeee7c09274d", 1 ) )
    {
        suit = "sat_wingsuit_ob";
        var_bb86f77304f193c4 = get_ob_settings();
        
        if ( isdefined( var_bb86f77304f193c4 ) && var_bb86f77304f193c4.var_49178f6e5c220274 )
        {
            suit = "sat_wingsuit_ob_am";
        }
        
        if ( var_bb86f77304f193c4.var_bc533c47307aeca8 )
        {
            self.operatorcustomization.suit = suit;
        }
    }
}

// Namespace ob
// Params 1
// Checksum 0x39023023, Offset: 0x122e1
// Size: 0x42
function function_cffd377194114f5a( params )
{
    equip = getdvar( @"hash_5dd31f84feaeab10" );
    
    if ( equip )
    {
        params.struct.loadoutequipmentsecondary = equip;
    }
}

// Namespace ob
// Params 1, eflags: 0xc
// Checksum 0xacbdf71, Offset: 0x1232b
// Size: 0x159
function private function_2881078fe4de8155( params )
{
    self notify( #"hash_b9fad3414d022ce7" );
    self endon( #"hash_b9fad3414d022ce7" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isarray( params.end ) )
    {
        foreach ( end in params.end )
        {
            self endon( end );
        }
    }
    else if ( isstring( params.end ) )
    {
        self endon( params.end );
    }
    
    timeout = gettime() + 5000;
    
    while ( isdefined( self ) && gettime() <= timeout )
    {
        wait 0.5;
        battlechatter::broadcastnotify( self.origin, 1000, "react_player", "react_in_air_above", { #var_8332568a86e033a2:300, #var_282bf9970a98e27e:self.team, #otherent:self } );
    }
}

// Namespace ob
// Params 0, eflags: 0xc
// Checksum 0x143e16b1, Offset: 0x1248c
// Size: 0xd6
function private monitor_weapon()
{
    self notify( #"hash_4214c733ab729ee1" );
    self endon( #"hash_4214c733ab729ee1" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"weapon_raise_code", weapon );
        
        if ( !isdefined( weapon.basename ) )
        {
            continue;
        }
        
        if ( issubstr( weapon.basename, "_ks_" ) || weapon.basename == "war_machine_sat_ob" )
        {
            battlechatter::broadcastnotify( self.origin, 1000, "react_player", "react_special_weapon", { #var_282bf9970a98e27e:self.team, #otherent:self } );
        }
        
        weapon::fixupplayerweapons( self, weapon );
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x2850aa73, Offset: 0x1256a
// Size: 0xd8
function private ob_on_grenade_fire( params )
{
    basename = params.grenade.weapon_object.basename;
    
    if ( isstring( basename ) )
    {
        switch ( basename )
        {
            case #"hash_2401b16bd3d7ed91":
            case #"hash_2d4c698a8ac977dd":
            case #"hash_3db80493b4c32477":
            case #"hash_5644b2746e600adb":
            case #"hash_8c8bafe3bfb473ee":
            case #"hash_982c1181bacf807d":
            case #"hash_b55fa15f5c89958d":
                battlechatter::broadcastnotify( self.origin, 1000, "react_player", "react_generic_tech", { #var_282bf9970a98e27e:self.team, #otherent:self } );
                break;
        }
    }
}

// Namespace ob
// Params 2, eflags: 0x4
// Checksum 0xe38f28d9, Offset: 0x1264a
// Size: 0xa3
function private onleavegamecallback( channel, val )
{
    if ( channel != "end_game" )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player setclientdvar( @"ui_opensummary", 1 );
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x9984f20, Offset: 0x126f5
// Size: 0x4c
function private ob_on_player_connect( params )
{
    thread monitor_weapon();
    
    if ( get_forced_operators() && !nightmare() )
    {
        self.pers[ "forceDefaultLoadouts" ] = 1;
    }
    
    if ( nightmare() )
    {
        function_1e14e3fe82ea2c1( "nm" );
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x8943f066, Offset: 0x12749
// Size: 0x2e
function private ob_on_player_disconnect( params )
{
    level thread ob_exfil_trans::function_de34b08af866fc29();
    
    if ( !nightmare() )
    {
        story_contract_util::function_f253e939765d2e39( self.consoleactivity );
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x357d39c0, Offset: 0x1277f
// Size: 0x15
function private ob_on_player_aerial( params )
{
    thread function_2881078fe4de8155( params );
}

// Namespace ob
// Params 0
// Checksum 0x9aa69868, Offset: 0x1279c
// Size: 0x3d4
function function_eaacd66cbcfbe0de()
{
    level notify( #"hash_db84346c557c2d34" );
    level endon( #"hash_db84346c557c2d34" );
    waittillframeend();
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_db84346c557c2d34" ) )
    {
        utility::callsharedfunc( #"gametype", #"hash_db84346c557c2d34" );
        return;
    }
    
    totalplayers = level.players.size;
    aliveplayercount = 0;
    activesquads = [];
    
    if ( getdvarint( @"hash_4be96532b2d09108", 0 ) )
    {
        for ( i = 0; i < totalplayers ; i++ )
        {
            player = level.players[ i ];
            
            if ( player manager::function_7f3b0449df3d77e() || player.team == "spectator" || player.team == "codcaster" )
            {
                continue;
            }
            
            if ( !player.var_81c3ae54e6c166c2 )
            {
                aliveplayercount++;
                activesquads[ player.sessionsquadid ] = 1;
            }
        }
    }
    else if ( isarray( level.squaddata ) )
    {
        foreach ( squaddata in level.squaddata )
        {
            currentplayercount = aliveplayercount;
            
            foreach ( squad in squaddata )
            {
                if ( !isdefined( squad.players ) || squad.players.size == 0 )
                {
                    continue;
                }
                
                foreach ( member in squad.players )
                {
                    if ( member manager::function_7f3b0449df3d77e() || member.team == "spectator" || member.team == "codcaster" )
                    {
                        continue;
                    }
                    
                    if ( !member.var_81c3ae54e6c166c2 )
                    {
                        aliveplayercount++;
                    }
                }
                
                if ( currentplayercount != aliveplayercount )
                {
                    activesquads[ activesquads.size ] = 1;
                }
            }
        }
    }
    
    foreach ( uibot in manager::function_cda6de7e2ba52066() )
    {
        aliveplayercount++;
        activesquads[ uibot.sessionsquadid ] = 1;
    }
    
    level.var_fc71e82557e9a9c2 = aliveplayercount;
    level.var_dc2950d536420066 = activesquads.size;
    
    /#
        var_2d13161b905894b7 = 255;
        assert( aliveplayercount <= var_2d13161b905894b7 );
        assert( activesquads.size <= var_2d13161b905894b7 );
    #/
    
    var_a187995f65a64fdb = ( activesquads.size << 8 ) + aliveplayercount;
    setomnvar( "ui_br_match_stats", var_a187995f65a64fdb );
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x4fc4889f, Offset: 0x12b78
// Size: 0x13e
function private get_ai_power_tier()
{
    if ( self.type == "zombie" )
    {
        if ( self.aicategory )
        {
            switch ( self.aicategory )
            {
                case #"hash_84fcf5e68d7230b2":
                    return 1;
                case #"hash_8c089e813083e510":
                    return 2;
                case #"hash_7b0e2f2ed84f34":
                case #"hash_4e47eb6c32f5b165":
                    return 3;
                case #"hash_7e8a002ed096276c":
                    return 4;
                default:
                    assertmsg( "<dev string:x2634>" + self.aicategory );
                    return;
            }
        }
        else
        {
            assertmsg( "<dev string:x264d>" + self.agent_type + "<dev string:x2666>" + self.origin );
        }
    }
    else if ( self.type == "human" )
    {
        assert( isdefined( self.powertier ), "<dev string:x266f>" + self.classname + "<dev string:x2666>" + self.origin + "<dev string:x26b2>" + self.agent_type );
        return self.powertier;
    }
    
    assertmsg( "<dev string:x26bf>" + self.type );
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x5e778f6, Offset: 0x12cbe
// Size: 0x72, Type: bool
function private function_6b5ab24a78d837b8()
{
    ob_gametype_settings = get_ob_settings();
    
    if ( !self isscriptable() || !isdefined( ob_gametype_settings ) || !ob_gametype_settings.var_dd074b974a9738d6 )
    {
        return false;
    }
    
    ai_tier = ai_utility::get_ai_tier();
    
    if ( ai_tier == 3 && !self.suppress_minimap_icon )
    {
        self setscriptablepartstate( "icon", "active", 0 );
        return true;
    }
    
    return false;
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x46f653b1, Offset: 0x12d39
// Size: 0x2f, Type: bool
function private function_5d9a305e97b31f41()
{
    var_bb86f77304f193c4 = get_ob_settings();
    
    if ( !isdefined( var_bb86f77304f193c4 ) || !var_bb86f77304f193c4.var_49178f6e5c220274 )
    {
        return false;
    }
    
    return true;
}

// Namespace ob
// Params 0
// Checksum 0x512692da, Offset: 0x12d71
// Size: 0x52
function function_1737d21aae7148d2()
{
    launcher_start_point = getdvar( @"start", "default" );
    
    if ( launcher_start_point != "default" && launcher_start_point != "no_game" )
    {
        return ob_story_mission_utils::validate_activity_name( launcher_start_point );
    }
    
    return getdvar( @"hash_364afa6c813448af", "default" );
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xc6ddc017, Offset: 0x12dcc
// Size: 0x1b5
function private function_43c82cf8640089c()
{
    level.var_47dbf341b5d1d5b5 = [];
    
    if ( !isdefined( level.gamemodebundle.var_d45aa868ba2a098f ) )
    {
        return;
    }
    
    missionlist = getscriptbundle( level.gamemodebundle.var_d45aa868ba2a098f );
    
    if ( !isdefined( missionlist.missions ) )
    {
        return;
    }
    
    skippowertier = 0;
    
    foreach ( index, missionentry in missionlist.missions )
    {
        if ( !isdefined( missionentry.bundle ) )
        {
            continue;
        }
        
        mission = getscriptbundle( missionentry.bundle );
        
        if ( isdefined( mission.var_37b63cc026bcd3a0 ) )
        {
            if ( isdefined( mission.var_e9c5e4620b383360 ) )
            {
                skippowertier = mission.var_e9c5e4620b383360;
            }
            
            struct = { #classtable:mission.var_5158d288dbe4dbe9, #index:index, #skippowertier:skippowertier, #hash:mission.var_a64305ba9e4c9692, #name:mission.var_37b63cc026bcd3a0 };
            level.var_47dbf341b5d1d5b5[ struct.name ] = struct;
        }
    }
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_346e2100fa4e4a03", &function_f8f455a78d742eb6 );
}

/#

    // Namespace ob
    // Params 0, eflags: 0x4
    // Checksum 0x1eb0505e, Offset: 0x12f89
    // Size: 0x1a9, Type: dev
    function private function_74a5d753c2addf3b()
    {
        var_185b7eee7f124221 = newhudelem();
        var_185b7eee7f124221.alignx = "<dev string:x26d0>";
        var_185b7eee7f124221.aligny = "<dev string:x26d5>";
        var_185b7eee7f124221.x = 80;
        var_185b7eee7f124221.y = 320;
        var_185b7eee7f124221.alpha = 0;
        var_185b7eee7f124221.foreground = 1;
        var_185b7eee7f124221.color = ( 1, 1, 1 );
        var_185b7eee7f124221.fontscale = 1.25;
        var_185b7eee7f124221 setdevtext( "<dev string:x26dc>" );
        var_185b7eee7f124221 fadeovertime( 0.5 );
        var_185b7eee7f124221.alpha = 1;
        level.var_b69c74a8c957053a.var_185b7eee7f124221 = var_185b7eee7f124221;
        var_7a46ef65d7b42021 = newhudelem();
        var_7a46ef65d7b42021.alignx = "<dev string:x26d0>";
        var_7a46ef65d7b42021.aligny = "<dev string:x26d5>";
        var_7a46ef65d7b42021.x = 80;
        var_7a46ef65d7b42021.y = 335;
        var_7a46ef65d7b42021.alpha = 0;
        var_7a46ef65d7b42021.foreground = 1;
        var_7a46ef65d7b42021.color = ( 1, 1, 1 );
        var_7a46ef65d7b42021.fontscale = 1.25;
        var_7a46ef65d7b42021 setdevtext( "<dev string:x2725>" );
        var_7a46ef65d7b42021 fadeovertime( 0.5 );
        var_7a46ef65d7b42021.alpha = 1;
        level.var_b69c74a8c957053a.var_7a46ef65d7b42021 = var_7a46ef65d7b42021;
    }

#/

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x4bd044a7, Offset: 0x1313a
// Size: 0x86
function private function_b728eac9eda48ad5()
{
    if ( isdefined( level.var_b69c74a8c957053a.var_185b7eee7f124221 ) )
    {
        level.var_b69c74a8c957053a.var_185b7eee7f124221 destroy();
        level.var_b69c74a8c957053a.var_185b7eee7f124221 = undefined;
    }
    
    if ( isdefined( level.var_b69c74a8c957053a.var_7a46ef65d7b42021 ) )
    {
        level.var_b69c74a8c957053a.var_7a46ef65d7b42021 destroy();
        level.var_b69c74a8c957053a.var_7a46ef65d7b42021 = undefined;
    }
}

// Namespace ob
// Params 3, eflags: 0x4
// Checksum 0xe3f261d7, Offset: 0x131c8
// Size: 0x61
function private function_df710e59a5c4e5a9( cmdnotify, var_81b3069083e30d73, buttondata )
{
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( #"hash_56f1edfb43a3f4f9" );
    
    while ( true )
    {
        player waittill( cmdnotify );
        buttondata.pressed = var_81b3069083e30d73;
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x511f65b0, Offset: 0x13231
// Size: 0x90
function private function_2587d13c3df5255a()
{
    activitynames = [];
    
    foreach ( missionentry in level.var_47dbf341b5d1d5b5 )
    {
        activitynames[ activitynames.size ] = missionentry.name;
    }
    
    return activitynames;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x188595d8, Offset: 0x132ca
// Size: 0x2b7
function private function_f8f455a78d742eb6( params )
{
    activityname = params[ 0 ] ?? "???";
    squad = undefined;
    players = level.players;
    
    if ( isplayer( self ) )
    {
        squad = teams::function_72b89edf6b47c40a( self );
        
        if ( isarray( squad.players ) )
        {
            players = squad.players;
        }
    }
    
    if ( level.onlinegame )
    {
        var_5292109424207d62 = getdvar( @"hash_5e7e9657295373d7", "" );
        
        if ( var_5292109424207d62 == "" || var_5292109424207d62 == "rvnqa" )
        {
            /#
                level thread function_e1170951b62312fc( players, activityname, "<dev string:x2776>" );
            #/
            
            return;
        }
    }
    
    if ( squad && activityname == "sag_stronghold_end" )
    {
        squad.sagjump = 1;
        activityname = "sag_stronghold";
    }
    
    if ( !isdefined( level.var_47dbf341b5d1d5b5[ activityname ] ) )
    {
        return;
    }
    
    if ( isdefined( squad ) )
    {
        squad.respawnlocations = undefined;
    }
    
    /#
        level thread function_e1170951b62312fc( players, activityname );
    #/
    
    story_contract_util::function_75999b5f1f828a61( [ players ] );
    
    foreach ( missionentry in level.var_47dbf341b5d1d5b5 )
    {
        if ( activityname != missionentry.name )
        {
            story_contract_util::function_816f0a4e9ae934d5( [ missionentry.hash, players ] );
            continue;
        }
        
        story_contract_util::function_4be2d88978819f75( [ missionentry.hash, players ] );
        setdvar( @"start", missionentry.name );
        break;
    }
    
    ob_infils_portal::function_e2631975ae393a9d();
    function_b2d4c209cff8d689( players, activityname );
    
    foreach ( player in players )
    {
        playerpos = ob_infils_portal::function_dffa38b3d22956d6( player );
        
        if ( isdefined( playerpos ) )
        {
            playerpos = ob_infils_portal::function_d7465d10fe54d67( playerpos );
            
            if ( player.sessionstate == "playing" )
            {
                player setorigin( playerpos );
            }
        }
    }
}

// Namespace ob
// Params 3
// Checksum 0xff397e64, Offset: 0x13589
// Size: 0x1c8
function function_b2d4c209cff8d689( players, activityname, noscreenfx = 1 )
{
    assert( isarray( players ) );
    
    if ( nightmare() )
    {
        return;
    }
    
    if ( !isdefined( activityname ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_47dbf341b5d1d5b5[ activityname ] ) )
    {
        return;
    }
    
    foreach ( missionentry in level.var_47dbf341b5d1d5b5 )
    {
        if ( activityname == missionentry.name && isdefined( missionentry.skippowertier ) )
        {
            foreach ( player in players )
            {
                if ( player.var_8c5067d0870248c8 != missionentry.skippowertier )
                {
                    player.var_8c5067d0870248c8 = missionentry.skippowertier;
                    player thread ob_story_mission_utils::function_9d7c461c00f2f588( missionentry.skippowertier, noscreenfx );
                }
                
                squad = teams::function_72b89edf6b47c40a( player );
                
                if ( isdefined( squad ) )
                {
                    squad.var_8c5067d0870248c8 = missionentry.skippowertier;
                }
            }
            
            return;
        }
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x14617952, Offset: 0x13759
// Size: 0x6de
function private function_2806f81fa2ea8071()
{
    iprintln( "DEV start points menu opened" );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_disable_scoreboard", 1 );
        player setclientomnvar( "ui_disable_wheel_widgets", 1 );
    }
    
    level.var_b69c74a8c957053a = spawnstruct();
    level.var_b69c74a8c957053a.var_f86cff22b86f0047 = spawnstruct();
    level.var_b69c74a8c957053a.var_7c80023d124dced6 = spawnstruct();
    level.var_b69c74a8c957053a.var_c44254d8e64ec9c8 = spawnstruct();
    level.var_b69c74a8c957053a.var_a552931437911c3e = spawnstruct();
    
    foreach ( player in level.players )
    {
        player val::set( "ob_sm_display_starts", "freezecontrols", 1 );
        player val::set( "ob_sm_display_starts", "damage", 0 );
        player scripted_widgets::create( "dev_start_menu_input", "scripted_widget_input_handler_sm_debug_starts" );
        player thread function_df710e59a5c4e5a9( "start_point_up_press", 1, level.var_b69c74a8c957053a.var_f86cff22b86f0047 );
        player thread function_df710e59a5c4e5a9( "start_point_up_release", 0, level.var_b69c74a8c957053a.var_f86cff22b86f0047 );
        player thread function_df710e59a5c4e5a9( "start_point_down_press", 1, level.var_b69c74a8c957053a.var_7c80023d124dced6 );
        player thread function_df710e59a5c4e5a9( "start_point_down_release", 0, level.var_b69c74a8c957053a.var_7c80023d124dced6 );
        player thread function_df710e59a5c4e5a9( "start_point_cancel_release", 1, level.var_b69c74a8c957053a.var_c44254d8e64ec9c8 );
        player thread function_df710e59a5c4e5a9( "start_point_confirm_release", 1, level.var_b69c74a8c957053a.var_a552931437911c3e );
    }
    
    /#
        function_74a5d753c2addf3b();
    #/
    
    elems = dev_mp::start_list_menu();
    title = dev_mp::create_start( "Selected Start:", -1 );
    title.color = ( 1, 1, 1 );
    strings = [];
    activitynames = [[ level.var_8b324f76eefee199 ]]();
    
    foreach ( actname in activitynames )
    {
        strings[ strings.size ] = "[" + actname + "]";
    }
    
    activitynames[ activitynames.size ] = "cancel";
    strings[ strings.size ] = "[cancel]";
    selected = activitynames.size - 1;
    up_pressed = 0;
    down_pressed = 0;
    found_current_start = 0;
    var_2a92ba1bab6cc7b4 = function_1737d21aae7148d2();
    
    while ( selected > 0 )
    {
        if ( activitynames[ selected ] == var_2a92ba1bab6cc7b4 )
        {
            found_current_start = 1;
            break;
        }
        
        selected--;
    }
    
    if ( !found_current_start )
    {
        selected = activitynames.size - 1;
    }
    
    dev_mp::start_list_settext( elems, strings, selected );
    old_selected = selected;
    last_presstime = 0;
    
    while ( true )
    {
        if ( old_selected != selected )
        {
            dev_mp::start_list_settext( elems, strings, selected );
            old_selected = selected;
        }
        
        if ( gettime() - last_presstime > 150 )
        {
            up_pressed = 0;
            down_pressed = 0;
        }
        
        if ( !up_pressed )
        {
            if ( level.var_b69c74a8c957053a.var_f86cff22b86f0047.pressed )
            {
                up_pressed = 1;
                last_presstime = gettime();
                selected--;
            }
        }
        else if ( !level.var_b69c74a8c957053a.var_f86cff22b86f0047.pressed )
        {
            up_pressed = 0;
        }
        
        if ( !down_pressed )
        {
            if ( level.var_b69c74a8c957053a.var_7c80023d124dced6.pressed )
            {
                down_pressed = 1;
                last_presstime = gettime();
                selected++;
            }
        }
        else if ( !level.var_b69c74a8c957053a.var_7c80023d124dced6.pressed )
        {
            down_pressed = 0;
        }
        
        if ( selected < 0 )
        {
            selected = activitynames.size - 1;
        }
        
        if ( selected >= activitynames.size )
        {
            selected = 0;
        }
        
        if ( level.var_b69c74a8c957053a.var_c44254d8e64ec9c8.pressed )
        {
            dev_mp::start_display_cleanup( elems, title );
            break;
        }
        
        if ( level.var_b69c74a8c957053a.var_a552931437911c3e.pressed )
        {
            activityname = activitynames[ selected ];
            
            if ( activityname == "cancel" )
            {
                dev_mp::start_display_cleanup( elems, title );
                break;
            }
            
            dev_mp::start_display_cleanup( elems, title );
            
            if ( isfunction( level.var_b6c6978dacab8f7b ) )
            {
                thread [[ level.var_b6c6978dacab8f7b ]]( [ activityname ] );
            }
            
            foreach ( player in level.players )
            {
                player setclientomnvar( "ui_disable_scoreboard", 0 );
                player setclientomnvar( "ui_disable_wheel_widgets", 0 );
            }
            
            break;
        }
        
        waitframe();
    }
    
    function_b728eac9eda48ad5();
    
    foreach ( player in level.players )
    {
        player scripted_widgets::destroy( "dev_start_menu_input" );
        player notify( #"hash_56f1edfb43a3f4f9" );
        player val::reset_all( "ob_sm_display_starts" );
        player setclientomnvar( "ui_disable_scoreboard", 0 );
        player setclientomnvar( "ui_disable_wheel_widgets", 0 );
    }
    
    level.var_b69c74a8c957053a = undefined;
}

/#

    // Namespace ob
    // Params 3
    // Checksum 0x20e7c164, Offset: 0x13e3f
    // Size: 0x1cc, Type: dev
    function function_e1170951b62312fc( players, activityname, text )
    {
        if ( !isdefined( text ) )
        {
            text = "<dev string:x2791>";
        }
        
        assert( isarray( players ) );
        
        if ( !isstring( activityname ) )
        {
            return;
        }
        
        cleanup = [];
        
        foreach ( player in players )
        {
            hudelem = newclienthudelem( player );
            hudelem.alignx = "<dev string:x279e>";
            hudelem.aligny = "<dev string:x26d5>";
            hudelem.x = 320;
            hudelem.y = 270;
            hudelem.foreground = 1;
            hudelem.color = ( 1, 0.5, 0.3 );
            hudelem.fontscale = 2;
            hudelem setdevtext( text + activityname + "<dev string:x27a5>" );
            cleanup[ cleanup.size ] = hudelem;
        }
        
        wait 4;
        
        foreach ( hudelem in cleanup )
        {
            if ( isdefined( hudelem ) )
            {
                hudelem destroy();
            }
        }
    }

#/

// Namespace ob
// Params 1
// Checksum 0xb2594bc9, Offset: 0x14013
// Size: 0x22
function function_47bf608e051b3a94( struct )
{
    struct.script_cs_flag = undefined;
    struct.groupid = undefined;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x3d535a52, Offset: 0x1403d
// Size: 0x54
function private function_aeb4e7dceebb2f7e( hint_ref )
{
    if ( !isdefined( level.var_5847daec28125178[ hint_ref ] ) )
    {
        assertmsg( "<dev string:x27a9>" + hint_ref + "<dev string:x27bd>" );
        return 0;
    }
    
    return self getplayerdata( level.var_6f9b00680ed002d8, "hintsSeen", level.var_5847daec28125178[ hint_ref ] );
}

// Namespace ob
// Params 2, eflags: 0xc
// Checksum 0x35b860ae, Offset: 0x1409a
// Size: 0x8b
function private function_a5880170e841eeaa( hint_ref, seen )
{
    self notify( #"hash_38655a615438a559" );
    self endon( #"hash_38655a615438a559" );
    self endon( #"disconnect" );
    
    if ( !isdefined( level.var_5847daec28125178[ hint_ref ] ) )
    {
        assertmsg( "<dev string:x27a9>" + hint_ref + "<dev string:x27bd>" );
        return;
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, "hintsSeen", level.var_5847daec28125178[ hint_ref ], seen );
    waitframe();
    self function_432458e83a394206( 3 );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x74ac85f7, Offset: 0x1412d
// Size: 0x8e
function private function_edcecad6b701177a( params )
{
    if ( isplayer( self ) )
    {
        foreach ( key, index in level.var_5847daec28125178 )
        {
            thread function_a5880170e841eeaa( key, 0 );
        }
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xf1b9e1aa, Offset: 0x141c3
// Size: 0x75
function private function_65b2157eb711327c( name )
{
    if ( !isplayer( self ) )
    {
        return 1;
    }
    
    if ( !getdvarint( @"hash_70e0b48e9ed1fb6f", 0 ) )
    {
        return 1;
    }
    
    if ( !isstring( name ) )
    {
        return 1;
    }
    
    index = level.var_79b3a496addf34e1[ tolower( name ) ];
    
    if ( !isdefined( index ) )
    {
        return 1;
    }
    
    return self getplayerdata( level.var_6f9b00680ed002d8, "cinematicSeen", index );
}

// Namespace ob
// Params 2, eflags: 0xc
// Checksum 0xf49f9d8c, Offset: 0x14241
// Size: 0x92
function private function_74584d38b8df92d0( name, seen )
{
    self notify( #"hash_9372d108386dad1" );
    self endon( #"hash_9372d108386dad1" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    
    if ( !isstring( name ) )
    {
        return;
    }
    
    index = level.var_79b3a496addf34e1[ tolower( name ) ];
    
    if ( !isdefined( index ) )
    {
        return;
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, "cinematicSeen", index, seen );
    waitframe();
    self function_432458e83a394206( 3 );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x754fa95e, Offset: 0x142db
// Size: 0x86
function private function_d936871d2ff088cb( params )
{
    foreach ( name, index in level.var_79b3a496addf34e1 )
    {
        thread function_74584d38b8df92d0( name, 0 );
    }
}

// Namespace ob
// Params 2, eflags: 0x4
// Checksum 0xbc3216c3, Offset: 0x14369
// Size: 0x21f, Type: bool
function private function_77cc2e7dc69b921e( sceneroot, sceneplay )
{
    if ( !sceneroot.scenedata.scenescriptbundle.bool_skippable )
    {
        return true;
    }
    
    if ( !sceneplay.hasplayers )
    {
        return true;
    }
    
    var_26c39e21f22efcb3 = getdvarint( @"hash_70e0b48e9ed1fb6f", 0 );
    
    if ( !var_26c39e21f22efcb3 )
    {
        return true;
    }
    
    skipname = sceneroot.script_scenescriptbundle;
    relevantcount = 0;
    seencount = 0;
    
    foreach ( sceneobject in sceneroot.scenedata.sceneobjectdata )
    {
        if ( isplayer( sceneobject.entity ) )
        {
            relevantcount++;
            
            if ( sceneobject.entity function_65b2157eb711327c( skipname ) )
            {
                seencount++;
            }
            
            continue;
        }
        
        if ( sceneobject.sceneobject.variant_type == "Types_XCam" )
        {
            relevantcount = 0;
            seencount = 0;
            
            foreach ( player in level.players )
            {
                if ( !isplayer( player ) )
                {
                    continue;
                }
                
                relevantcount++;
                
                if ( player function_65b2157eb711327c( skipname ) )
                {
                    seencount++;
                }
            }
            
            break;
        }
    }
    
    if ( var_26c39e21f22efcb3 == 1 && seencount == 0 || var_26c39e21f22efcb3 == 2 && seencount < relevantcount )
    {
        return false;
    }
    
    return true;
}

// Namespace ob
// Params 2, eflags: 0x4
// Checksum 0x91098aba, Offset: 0x14591
// Size: 0x1a0
function private function_39b9cb4bb7b86536( sceneroot, sceneplay )
{
    if ( !sceneroot.scenedata.scenescriptbundle.bool_skippable )
    {
        return;
    }
    
    if ( !sceneplay.hasplayers )
    {
        return;
    }
    
    skipname = sceneroot.script_scenescriptbundle;
    
    foreach ( sceneobject in sceneroot.scenedata.sceneobjectdata )
    {
        if ( isplayer( sceneobject.entity ) )
        {
            sceneobject.entity thread function_74584d38b8df92d0( skipname, 1 );
            continue;
        }
        
        if ( sceneobject.sceneobject.variant_type == "Types_XCam" )
        {
            foreach ( player in level.players )
            {
                player thread function_74584d38b8df92d0( skipname, 1 );
            }
            
            break;
        }
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xe41dc961, Offset: 0x14739
// Size: 0xb
function private function_5999b072e034a785()
{
    return %"hash_a0cd80b29aaf0a3";
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x78da68ea, Offset: 0x1474d
// Size: 0x24, Type: bool
function private ob_should_disable_third_person_toggle( player )
{
    if ( player && player.mutant_injection_start_time )
    {
        return true;
    }
    
    return false;
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xecb8d2b6, Offset: 0x1477a
// Size: 0x25d
function private function_2299ea8a7da91728()
{
    telemetry_data = [];
    forced_operators = get_forced_operators();
    
    if ( !forced_operators )
    {
        superability = supers_mp::getcurrentsuper().staticdata.ref ?? #"";
        minorability = supers_mp::getcurrentsuper( #"tactical" ).staticdata.ref ?? #"";
        selfrevives = laststand::function_7072b516e6cffb7c();
        combatrating = utility::callsharedfunc( #"ob_skill_tracks", #"hash_20f154cc7ce486fe" ) ?? #"";
        telemetry_data = [ "super_ability", superability, "minor_ability", minorability, "self_revives", selfrevives, "combat_rating", combatrating ];
        
        if ( isarray( self.activeskills ) )
        {
            if ( isdefined( self.activeskills[ #"health_upgrade" ] ) )
            {
                telemetry_data = arraycombine( telemetry_data, [ "skill_health_upgrade", self.activeskills[ #"health_upgrade" ] ] );
            }
            
            if ( isdefined( self.activeskills[ #"armor_upgrade" ] ) )
            {
                telemetry_data = arraycombine( telemetry_data, [ "skill_armor_upgrade", self.activeskills[ #"armor_upgrade" ] ] );
            }
            
            if ( isdefined( self.activeskills[ #"move_speed_upgrade" ] ) )
            {
                telemetry_data = arraycombine( telemetry_data, [ "skill_speed_upgrade", self.activeskills[ #"move_speed_upgrade" ] ] );
            }
            
            if ( isdefined( self.activeskills[ #"damage_upgrade" ] ) )
            {
                telemetry_data = arraycombine( telemetry_data, [ "skill_damage_upgrade", self.activeskills[ #"damage_upgrade" ] ] );
            }
            
            if ( isdefined( self.activeskills[ #"equipment_hound" ] ) )
            {
                telemetry_data = arraycombine( telemetry_data, [ "skill_equipment_hound", self.activeskills[ #"equipment_hound" ] ] );
            }
        }
    }
    
    return telemetry_data;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xd3cc9837, Offset: 0x149e0
// Size: 0x7d
function private function_b61c2868056fd497( player )
{
    result = {};
    result.var_27fd0d2a449557bf = player.var_27fd0d2a449557bf;
    result.var_755ed09478df002 = player.var_755ed09478df002;
    
    if ( player.vehicle && player.var_420a3b8802c6905e )
    {
        result.var_755ed09478df002 = player.var_420a3b8802c6905e;
    }
    
    return result;
}

// Namespace ob
// Params 2
// Checksum 0xf06f83c2, Offset: 0x14a66
// Size: 0x2ed
function ob_teleport_player_in_bounds( timeoutendnotify, clearnotify )
{
    destination = undefined;
    destinationfallback = undefined;
    squad = teams::function_72b89edf6b47c40a( self );
    
    if ( isarray( squad.players ) )
    {
        var_5a9a3ba4ce3deac = sortbydistance( squad.players, self.origin );
        
        foreach ( squadplayer in var_5a9a3ba4ce3deac )
        {
            if ( squadplayer.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( level.var_bb86f77304f193c4.var_96de51e7c7623219 && squadplayer != self )
            {
                var_92b35d9896c198c = region_difficulty_manager::get_region_difficulty( squadplayer.origin );
                
                if ( var_92b35d9896c198c != self.assigned_difficulty )
                {
                    continue;
                }
            }
            
            if ( squadplayer.var_27fd0d2a449557bf )
            {
                if ( !squadplayer.oob )
                {
                    destination = function_b61c2868056fd497( squadplayer );
                    break;
                }
                
                if ( !destinationfallback )
                {
                    destinationfallback = function_b61c2868056fd497( squadplayer );
                }
            }
        }
    }
    
    if ( destinationfallback && !destination )
    {
        destination = destinationfallback;
    }
    
    var_27fd0d2a449557bf = destination.var_27fd0d2a449557bf;
    var_755ed09478df002 = destination.var_755ed09478df002;
    
    if ( var_27fd0d2a449557bf )
    {
        var_27fd0d2a449557bf = ob_infils_portal::function_b2a877843ebea2a5( var_27fd0d2a449557bf, self );
        var_27fd0d2a449557bf = ob_infils_portal::function_d7465d10fe54d67( var_27fd0d2a449557bf );
        
        if ( !var_755ed09478df002 )
        {
            var_755ed09478df002 = ( 0, 0, 0 );
        }
        
        var_755ed09478df002 = vectornormalize( var_755ed09478df002 );
        var_ea72e06df273cb1d = ( var_755ed09478df002[ 0 ], var_755ed09478df002[ 1 ], 0 );
        waterheight = getwaterheightatlocation( var_27fd0d2a449557bf );
        
        if ( var_27fd0d2a449557bf[ 2 ] < waterheight )
        {
            var_27fd0d2a449557bf = ( var_27fd0d2a449557bf[ 0 ], var_27fd0d2a449557bf[ 1 ], waterheight );
        }
        
        thread teleport_player_in_bounds_stream_wait();
        angles = ( 0, vectortoangles( var_ea72e06df273cb1d * -1 )[ 1 ], 0 );
        coop::teleport_player( self, { #angles:angles, #origin:var_27fd0d2a449557bf }, 1 );
        outofbounds::clearoob( self, 0 );
        
        if ( self.ismutantinjection && self.micontext.miconfig )
        {
            if ( utility::issharedfuncdefined( #"mutant_injection", #"toggle_allows" ) )
            {
                self [[ utility::getsharedfunc( #"mutant_injection", #"toggle_allows" ) ]]( self.micontext.miconfig.allows, 0 );
            }
        }
        
        return;
    }
    
    self kill();
}

// Namespace ob
// Params 0, eflags: 0xc
// Checksum 0xea5370af, Offset: 0x14d5c
// Size: 0xaf
function private teleport_player_in_bounds_stream_wait()
{
    self notify( #"hash_cb7f12719b4dda18" );
    self endon( #"hash_cb7f12719b4dda18" );
    assert( isplayer( self ) );
    self endon( #"disconnect" );
    coop::player_fade_with_shader( 1, 0 );
    val::set( "teleport_player_in_bounds_stream_wait", "damage", 0 );
    val::set( "teleport_player_in_bounds_stream_wait", "ignoreme", 1 );
    val::set( "teleport_player_in_bounds_stream_wait", "freezecontrols", 1 );
    val::set( "teleport_player_in_bounds_stream_wait", "allow_movement", 0 );
    utility::players_stream_wait( [ self ], 1 );
    val::reset_all( "teleport_player_in_bounds_stream_wait" );
    coop::player_fade_with_shader( 0, 0.5 );
}

// Namespace ob
// Params 0
// Checksum 0x10b531fd, Offset: 0x14e13
// Size: 0xcd
function function_86ef6f9996499233()
{
    self notify( #"hash_68b42b186808df0a" );
    self endon( #"hash_68b42b186808df0a" );
    assert( isplayer( self ) );
    player = self;
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( player.sessionstate == "playing" && !player.oob && player isonground() && !isdefined( player getlinkedparent() ) && !player utility::ent_flag( "scene_active" ) )
        {
            player.var_27fd0d2a449557bf = player.origin;
            player.var_755ed09478df002 = player getvelocity();
        }
        
        wait randomfloatrange( 1, 2 );
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x7f439a0c, Offset: 0x14ee8
// Size: 0x2a4
function private function_dc06e1059093b7ea()
{
    if ( level.ob_overtime_settings )
    {
        return;
    }
    
    if ( level.var_bb86f77304f193c4 )
    {
        overtime_settings = level.var_bb86f77304f193c4.overtimesettings;
    }
    
    if ( !isdefined( overtime_settings ) )
    {
        overtime_settings = {};
    }
    
    overtime_settings.overtime_enabled = getdvarint( @"hash_a86b7a32fdb689d2", overtime_settings.overtimeenabled ?? 0 ) == 1;
    
    if ( !overtime_settings.overtime_enabled )
    {
        return;
    }
    
    level.ob_overtime_settings = {};
    ob_overtime_settings = level.ob_overtime_settings;
    ob_overtime_settings.overtime_time = getdvarint( @"scr_ob_overtime_time", overtime_settings.overtimetime ?? 30 );
    ob_overtime_settings.var_d12598e91b6083d = overtime_settings.damageenabled;
    ob_overtime_settings.cough_enabled = overtime_settings.coughenabled;
    ob_overtime_settings.var_9695602532b6330a = overtime_settings.effectsenabled;
    
    if ( ob_overtime_settings.var_d12598e91b6083d == 1 )
    {
        ob_overtime_settings.damage_start = getdvarint( @"hash_8e3b991e019407c5", overtime_settings.startdamage ?? 10 );
        ob_overtime_settings.damage_end = getdvarint( @"hash_49155b4b37ae9f4a", overtime_settings.enddamage ?? 10 );
        ob_overtime_settings.damage_ramp_time = getdvarfloat( @"hash_240a30725733299f", overtime_settings.ramptime ?? 20 );
        ob_overtime_settings.damage_tick_time = getdvarfloat( @"hash_fd8e570aa79d6e54", overtime_settings.ticktime ?? 1 );
    }
    
    if ( ob_overtime_settings.cough_enabled == 1 )
    {
        ob_overtime_settings.cough_chance = getdvarint( @"hash_2dd8ea53026ea806", overtime_settings.coughchance ?? 20 );
        ob_overtime_settings.cough_cooldown = getdvarfloat( @"hash_5737ecef82693f67", overtime_settings.coughcooldown ?? 5 );
    }
    
    if ( ob_overtime_settings.var_9695602532b6330a == 1 )
    {
        ob_overtime_settings.shellshock_ref = overtime_settings.shellshockref;
        ob_overtime_settings.var_9e69006fbbf21bdb = overtime_settings.shellshockduration ?? 7;
        ob_overtime_settings.var_15b46f12b1ddc60a = overtime_settings.var_4d10fe12a5ebb13a == 1;
        ob_overtime_settings.var_3fcd7a9ca9495e87 = overtime_settings.var_fe62232fe38abf95 == 1;
    }
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0xe7473613, Offset: 0x15194
// Size: 0x54
function private begin_overtime()
{
    if ( !level.ob_overtime_settings )
    {
        return;
    }
    
    level.ob_overtime_settings callback::add( "player_entered_overtime_damage", &function_fba8354609fecb7 );
    level.ob_overtime_settings callback::add( "player_exited_overtime_damage", &function_26dfac6b30060825 );
    level.ob_overtime_settings thread ob_overtime_monitor();
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x4b25781, Offset: 0x151f0
// Size: 0x12f
function private function_fba8354609fecb7( params )
{
    player = params.player;
    
    if ( self.shellshock_ref && self.var_9e69006fbbf21bdb && utility::issharedfuncdefined( #"player", #"shellshock" ) )
    {
        player [[ utility::getsharedfunc( #"player", #"shellshock" ) ]]( self.shellshock_ref, #"gas", self.var_9e69006fbbf21bdb );
    }
    
    if ( self.var_15b46f12b1ddc60a || self.var_3fcd7a9ca9495e87 )
    {
        var_9e6c61f06d68f6d9 = region_difficulty_manager::function_dc53171229eb2097( region_difficulty_manager::get_region_difficulty( player.origin ) );
        powered_difficulty = "difficulty5";
        region_params = { #new_difficulty:powered_difficulty, #var_705eae6dbfaf5fad:var_9e6c61f06d68f6d9, #player:player };
    }
    
    if ( self.var_15b46f12b1ddc60a )
    {
        thread region_difficulty_manager::function_aec1065e06c4336e( region_params );
    }
    
    if ( self.var_3fcd7a9ca9495e87 )
    {
        thread region_difficulty_manager::function_b1af95c2d8f522c7( region_params );
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x92088b84, Offset: 0x15327
// Size: 0x114
function private function_26dfac6b30060825( params )
{
    player = params.player;
    
    if ( self.shellshock_ref && self.var_9e69006fbbf21bdb && utility::issharedfuncdefined( #"player", #"shellshock" ) )
    {
        player [[ utility::getsharedfunc( #"player", #"stopshellshock" ) ]]();
    }
    
    if ( self.var_15b46f12b1ddc60a || self.var_3fcd7a9ca9495e87 )
    {
        var_9e6c61f06d68f6d9 = region_difficulty_manager::function_dc53171229eb2097( region_difficulty_manager::get_region_difficulty( player.origin ) );
        powered_difficulty = "difficulty5";
        region_params = { #new_difficulty:var_9e6c61f06d68f6d9, #var_705eae6dbfaf5fad:powered_difficulty, #player:player };
    }
    
    if ( self.var_15b46f12b1ddc60a )
    {
        thread region_difficulty_manager::function_aec1065e06c4336e( region_params );
    }
    
    if ( self.var_3fcd7a9ca9495e87 )
    {
        thread region_difficulty_manager::function_b1af95c2d8f522c7( region_params );
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xaefdc96f, Offset: 0x15443
// Size: 0x72
function private function_3f080e8eff225196( params )
{
    if ( !isdefined( params.player ) )
    {
        return 0;
    }
    
    player = params.player;
    
    if ( isdefined( level.var_b5c6c8dd795d5519 ) )
    {
        return [[ level.var_b5c6c8dd795d5519 ]]( params );
    }
    
    var_6406b411db6be5c4 = isalive( player ) && !player.var_b7437a2d0279e0ac;
    return var_6406b411db6be5c4;
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x39beac24, Offset: 0x154be
// Size: 0x25e
function private ob_overtime_monitor()
{
    level endon( #"game_ended" );
    current_damage = self.damage_start;
    tick_time = self.damage_tick_time;
    var_578d71b7c00fc4ba = min( self.damage_start, self.damage_end );
    var_6a02108301e17dc = max( self.damage_start, self.damage_end );
    
    if ( self.damage_ramp_time > 0 )
    {
        tick_ramp = ( self.damage_end - self.damage_start ) * tick_time / self.damage_ramp_time;
    }
    
    if ( !isdefined( tick_ramp ) )
    {
        tick_ramp = 0;
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            params = { #player:player };
            var_178caee86648dbab = function_3f080e8eff225196( params );
            player_entity_number = player getentitynumber();
            
            if ( var_178caee86648dbab )
            {
                if ( !self.var_a8910f13c700fd2f[ player_entity_number ] )
                {
                    self.var_a8910f13c700fd2f[ player_entity_number ] = 1;
                    callback::callback( "player_entered_overtime_damage", params );
                }
            }
            else
            {
                if ( self.var_a8910f13c700fd2f[ player_entity_number ] )
                {
                    self.var_a8910f13c700fd2f[ player_entity_number ] = 0;
                    callback::callback( "player_exited_overtime_damage", params );
                }
                
                continue;
            }
            
            if ( !isalive( player ) || player.plotarmor )
            {
                continue;
            }
            
            dflags = 4194304;
            player dodamage( int( current_damage ), player.origin, player, undefined, "MOD_TRIGGER_HURT", undefined, "none", undefined, dflags );
            player armor::damagearmor( int( current_damage ), undefined, player, "MOD_TRIGGER_HURT" );
            
            if ( randomint( 100 ) < self.cough_chance )
            {
                function_6104e81286096d0( player );
            }
        }
        
        current_damage = clamp( current_damage + tick_ramp, var_578d71b7c00fc4ba, var_6a02108301e17dc );
        wait tick_time;
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xfb87019c, Offset: 0x15724
// Size: 0xd9
function private function_6104e81286096d0( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !player player::isreallyalive() )
    {
        return;
    }
    
    if ( player.isjuggernaut )
    {
        return;
    }
    
    if ( gettime() < player.var_810cbb89b17399a4 )
    {
        return;
    }
    
    player.var_810cbb89b17399a4 = gettime() + self.cough_cooldown;
    
    if ( !isai( player ) )
    {
        player playsoundtoplayer( #"gas_player_cough", player, player );
    }
    
    var_553ba779c31e442 = player function_f0194b512d8d650c();
    var_8d27e0901584cdf7 = randomint( game[ "dialogue" ][ var_553ba779c31e442 ].size );
    coughsoundalias = game[ "dialogue" ][ var_553ba779c31e442 ][ var_8d27e0901584cdf7 ];
    player playsound( coughsoundalias, player, player );
}

// Namespace ob
// Params 0, eflags: 0x4
// Checksum 0x8c4a1f78, Offset: 0x15805
// Size: 0x67
function private function_f0194b512d8d650c()
{
    var_553ba779c31e442 = "allies_male_cough";
    defaultoperatorteam = operator::function_1e32019139bf7206();
    
    if ( defaultoperatorteam == "axis" )
    {
        if ( operator::isfemale() )
        {
            var_553ba779c31e442 = "axis_female_cough";
        }
        else
        {
            var_553ba779c31e442 = "axis_male_cough";
        }
    }
    else if ( operator::isfemale() )
    {
        var_553ba779c31e442 = "allies_female_cough";
    }
    else
    {
        var_553ba779c31e442 = "allies_male_cough";
    }
    
    return var_553ba779c31e442;
}

// Namespace ob
// Params 1
// Checksum 0x3595b3b5, Offset: 0x15875
// Size: 0x75
function function_8a0b0cc1f79811af( slot )
{
    superref = supers_mp::getcurrentsuperref( slot );
    self setclientomnvar( "ui_ob_upgrade_splash_type", 0 );
    self setclientomnvar( "ui_ob_upgrade_splash_asset_index", level.superglobals.staticsuperdata[ superref ].id + 1 );
    namespace_7d05876ef5beb3c6::open_ob_upgrade_splash();
    self waittill( #"upgradesplashhide" );
    namespace_7d05876ef5beb3c6::close_ob_upgrade_splash();
}

// Namespace ob
// Params 0
// Checksum 0xc96bd30d, Offset: 0x158f2
// Size: 0x12c
function function_7684428f2ac101cb()
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "kills" ] ) )
        {
            self.leaderboarddata[ "kills" ] = self.leaderboarddata[ "kills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "kills" ] ) )
        {
            [[ level.leaderboardfunc[ "kills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x2806>" );
        
        if ( isdefined( self.pers[ "kills" ] ) )
        {
            self.pers[ "kills" ] = self.pers[ "kills" ] + 1;
        }
    }
    
    self.kills = self.pers[ "kills" ];
    stats::setextrascore0( self.pers[ "telemetry" ].special_eliminations );
    stats::setextrascore1( self.pers[ "telemetry" ].elite_eliminations );
}

// Namespace ob
// Params 0
// Checksum 0x22f61a90, Offset: 0x15a26
// Size: 0x22
function function_3a18e9c58b507939()
{
    stats::setextrascore2( self.pers[ "telemetry" ].var_7a078a035570e92b );
}

// Namespace ob
// Params 0
// Checksum 0xed9c5b35, Offset: 0x15a50
// Size: 0x22
function function_bbbbcc328c957e78()
{
    stats::setextrascore3( self.pers[ "telemetry" ].activities_completed );
}

// Namespace ob
// Params 0
// Checksum 0x89b25787, Offset: 0x15a7a
// Size: 0x22
function function_2c2ba98432629961()
{
    stats::setextrascore4( self.pers[ "telemetry" ].gained_power );
}

// Namespace ob
// Params 0
// Checksum 0x1eee25b4, Offset: 0x15aa4
// Size: 0x29
function function_332da4f77cda494()
{
    stats::function_fe615555f60e88b9( ( utility::callsharedfunc( #"ob_skill_tracks", #"hash_20f154cc7ce486fe" ) ?? 1 ) - 1 );
}

// Namespace ob
// Params 2
// Checksum 0xe03f283b, Offset: 0x15ad5
// Size: 0xe8
function function_82226ec4c6925388( player, exfilled )
{
    var_9f8ead27d4440432 = player.pers[ "firstConnectTime" ] ?? 0;
    
    if ( var_9f8ead27d4440432 < game[ "startTimeFromMatchStart" ] )
    {
        var_9f8ead27d4440432 = game[ "startTimeFromMatchStart" ];
    }
    
    timeplayed = ( gettime() - var_9f8ead27d4440432 ) / 1000;
    timeplayed = min( timeplayed, getdvarint( @"hash_a7dfb8ddbbbe7b83", 3000 ) );
    playerscore = player gamelogic_mp::calculatematchbonus( exfilled ? #"win" : #"loss", timeplayed );
    player gamelogic_mp::givematchbonus( exfilled ? "win" : "loss", playerscore );
    player.matchbonus = playerscore;
    player gamelogic_mp::calculateweaponmatchbonus( timeplayed );
    player.matchbonusgranted = 1;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x9f32cb8, Offset: 0x15bc5
// Size: 0x1d, Type: bool
function private is_tertiary_weapon_override( weapon )
{
    return weapon.basename == "sat_me_ballisticknife_mp";
}

// Namespace ob
// Params 1
// Checksum 0xde5f0325, Offset: 0x15beb
// Size: 0x178
function set_nightmare_loadout( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    foreach ( skillbundles in level.skillbundles )
    {
        foreach ( bundle in skillbundles )
        {
            if ( isstruct( bundle ) )
            {
                utility::callsharedfunc( #"skills", #"removeskill", bundle.skillref );
            }
        }
    }
    
    self.var_1db23e0735771ec5 = 0;
    self.var_38cdb896b8360654 = 0;
    self.selectabletracks = undefined;
    
    if ( self.activeskills )
    {
        self.skilltracks = [];
    }
    else
    {
        self.var_9432219327bb75a3 = [];
    }
    
    ob_story_mission_utils::function_3b9c5aa009cba304( "classtable_sat_ob_nightmare_dev", int( params[ 0 ] ), 4, undefined, undefined, 1, 1, 1 );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xdb88e99a, Offset: 0x15d6b
// Size: 0x9e
function private function_f21ae3809399440( weapon )
{
    if ( weaponmetadata::function_8ebb73e054860e6f( weapon ) )
    {
        return 1;
    }
    
    switch ( weapon.basenamehash )
    {
        case %"hash_eaa160ab5a09620":
        case %"sat_me_shockbaton_mp":
        case %"sat_me_knife_mp":
        case %"sat_me_ballisticknife_mp":
        case %"sat_me_saiph_mp":
        case %"sat_me_maru_mp":
        case %"sat_me_castor_mp":
        case %"sat_me_nashira_mp":
            return 1;
        default:
            return 0;
    }
}

// Namespace ob
// Params 0
// Checksum 0x651f9859, Offset: 0x15e11
// Size: 0xa0
function get_rescue_token_balance()
{
    if ( self.var_77fecdad95537975 )
    {
        return 1;
    }
    
    if ( isdefined( self.rescueTokenBalance ) )
    {
        return self.rescueTokenBalance;
    }
    
    rescueTokenLootID = getscriptbundlefieldvalue( %"consumable:sat_ob_rescue_token", #"lootid" );
    var_cde1d02c5741d1ef = self getplayerdata( "common", "rescueTokenLootID" );
    
    if ( getdvarint( @"hash_9c89e9f794f09bf0", 1 ) && var_cde1d02c5741d1ef != rescueTokenLootID )
    {
        return 0;
    }
    
    self.rescueTokenBalance = self getplayerdata( "common", "rescueTokenBalance" );
    return self.rescueTokenBalance;
}

// Namespace ob
// Params 2, eflags: 0x4
// Checksum 0x6cf43779, Offset: 0x15eba
// Size: 0xbb, Type: bool
function private function_ce69adb2648e06a8( weapon, list )
{
    assert( list );
    assert( isweapon( weapon ) );
    weaponname = getweaponbasename( weapon );
    
    foreach ( ignoredweapon in list )
    {
        if ( weaponname == ignoredweapon.ignoredweapon )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob
// Params 1
// Checksum 0xa1aac255, Offset: 0x15f7e
// Size: 0x3a0
function lui_rescue_token_choice( used )
{
    if ( used )
    {
        self setclientomnvar( "ui_ob_power_tier", ob_power_tier::function_6d4cdb24ee2c66c0() );
        
        if ( self.var_77fecdad95537975 )
        {
            self setplayerdata( "common", "rescueTokenBalance", 0 );
            self.var_77fecdad95537975 = undefined;
            var_c453b6b761894b40 = 1;
        }
        else
        {
            rescueTokenLootID = getscriptbundlefieldvalue( %"consumable:sat_ob_rescue_token", #"lootid" );
            var_cde1d02c5741d1ef = self getplayerdata( "common", "rescueTokenLootID" );
            
            if ( var_cde1d02c5741d1ef != rescueTokenLootID )
            {
                logstring( "[OB_PERSIST] Player had an invalid rescue token loot ID in their player data. Expected: " + rescueTokenLootID + ", Actual: " + var_cde1d02c5741d1ef );
                
                if ( getdvarint( @"hash_9c89e9f794f09bf0", 1 ) )
                {
                    return 0;
                }
            }
            
            aeeventname = #"ob_rescue_token_used";
            aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
            eventparams = [];
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
            self function_2e45314624fdfdb8( aeeventid, eventparams );
            rescueTokenBalance = self getplayerdata( "common", "rescueTokenBalance" );
            self setplayerdata( "common", "rescueTokenLootID", 0 );
            self setplayerdata( "common", "rescueTokenBalance", max( rescueTokenBalance - 1, 0 ) );
            var_c453b6b761894b40 = 0;
        }
        
        self dlog_recordplayerevent( "dlog_event_ob_player_rescue_token_used", [ "matchtime_ms", gettime() ?? -1, "level", maxint( 255, self.powertier ?? 0 ), "balance", maxint( 255, get_rescue_token_balance() ?? 0 ), "ingame_loot", var_c453b6b761894b40 ? 1 : 0, "playlist_name", getplaylistname() ?? "" ] );
        behavior = getdvarint( @"hash_3ee416320843a945", 2 );
        logstring( "[OB_PERSIST] Finalized player " + ( self.name ?? "" ) + " with behavior " + behavior + " due to using a rescue token." );
        ob_persist::finalize_player( self, behavior );
    }
    else
    {
        behavior = getdvarint( @"hash_f3d1ed658ba197eb", 0 );
        logstring( "[OB_PERSIST] Finalized player " + ( self.name ?? "" ) + " with behavior " + behavior + " due to not using a rescue token." );
        ob_persist::finalize_player( self, behavior );
    }
    
    self.var_6c2982c1a050d76a = 1;
    var_25fb274a1071fb6e = 0;
    squadmembers = squad_utility::getsquadmembers( undefined, 0 );
    
    foreach ( player in squadmembers )
    {
        if ( !player.var_6c2982c1a050d76a && player get_rescue_token_balance() )
        {
            var_25fb274a1071fb6e = 1;
            break;
        }
    }
    
    foreach ( player in squadmembers )
    {
        player setclientomnvar( "ui_ob_squad_has_rescue_tokens", var_25fb274a1071fb6e );
    }
    
    return used;
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xf80aee7, Offset: 0x16327
// Size: 0xc4
function private function_a6478a93b711a8f( params )
{
    attacker = params.eattacker;
    
    if ( !isplayer( attacker ) && !isplayer( attacker.owner ) )
    {
        return params.idamage;
    }
    
    if ( !supers_mp::function_4ae7eb52b7c57b( params.objweapon ) && !params.einflictor.superref )
    {
        return params.idamage;
    }
    
    multiplier = level.var_bb86f77304f193c4.supersdamagemultiplier;
    
    if ( multiplier )
    {
        return ( params.idamage * multiplier );
    }
    
    return params.idamage;
}

// Namespace ob
// Params 1
// Checksum 0x4f4daf01, Offset: 0x163f4
// Size: 0x142
function function_aae50a9de45f694a( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self setclientomnvar( o"hash_f898b926f28a3acc", self.operatorprestige ?? 0 );
    squadmembers = squad_utility::getsquadmembers( undefined, 0 );
    
    foreach ( var_4a1f4484a4b2ade7 in squadmembers )
    {
        foreach ( member2 in squadmembers )
        {
            var_4a1f4484a4b2ade7 setclientomnvar( hashcat( o"hash_ac5331d18c6af71f", member2.sessionuimemberindex ), member2.operatorprestige ?? 0 );
        }
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x326827ed, Offset: 0x1653e
// Size: 0x32, Type: bool
function private function_48aff000e13c7d2c( streakinfo )
{
    return streakinfo.streakname == "rcxd" || streakinfo.streakname == "remote_robot";
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xd03215ba, Offset: 0x16579
// Size: 0x3c
function private function_bfe775be7afd0a53( streakinfo )
{
    if ( function_48aff000e13c7d2c( streakinfo ) )
    {
        val::set( "ob_killstreakDeploy", "ignoreme", 1 );
        val::set( "ob_killstreakDeploy", "damage", 0 );
    }
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0xd3b7cbe7, Offset: 0x165bd
// Size: 0x71
function private function_f4d1a1d65c62c9bb( streakinfo )
{
    if ( !function_48aff000e13c7d2c( streakinfo ) )
    {
        return;
    }
    
    self notify( #"hash_3daffa395f1c0ff2" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3daffa395f1c0ff2" );
    var_2a058c774d141673 = getdvarfloat( @"hash_ce87fe7875b267e3", 1 );
    
    if ( var_2a058c774d141673 > 0 )
    {
        wait var_2a058c774d141673;
    }
    
    val::reset_all( "ob_killstreakDeploy" );
}

// Namespace ob
// Params 1, eflags: 0x4
// Checksum 0x20f28324, Offset: 0x16636
// Size: 0x136
function private on_vehicle_deleted( params )
{
    attached_loot_array = [];
    
    foreach ( scriptable in self.linkedchildren )
    {
        if ( scriptable getscriptableisloot() )
        {
            attached_loot_array[ attached_loot_array.size ] = scriptable;
        }
    }
    
    foreach ( scriptable in attached_loot_array )
    {
        scriptable utility::scriptable_clearparententity();
        scriptable.origin = ( scriptable.origin[ 0 ], scriptable.origin[ 1 ], self.origin[ 2 ] + 30 );
    }
}

