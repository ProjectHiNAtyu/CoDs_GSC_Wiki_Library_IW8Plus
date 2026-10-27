// scripts\mp\zm\zm.gsc  (hash_1ce525b1c9956c2b.gscc) (size: 66253 Bytes / 0x102cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc0846d74 (3229904244)
// size ...... 66253 (0x102cd)
// includes .. 91  (offset: 0xedad)
// strings ... 298 (offset: 0xf085)
// dev strs .. 42  (offset: 0x100c5)
// exports ... 154 (offset: 0x9ac1)
// cseg ...... 0x1f4a + 0x7b77 (0x9ac1)
// imports ... 472 (offset: 0xb2d1)
// animtree1 . 0   (offset: 0x102cd)
// animtree2 . 0   (offset: 0x102cd)
#using script_16ea1b94f0f381b3;
#using script_17aac58f7828f476;
#using script_2498b7c75f1dee2d;
#using script_4bf223434bdc0646;
#using script_54da1af5927ef919;
#using script_7381472113d2aa0b;
#using script_aa3bac81ad4fc8e;
#using scripts\asm\asm;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\player_broadcasting;
#using scripts\common\scene;
#using scripts\common\status_effects\status_effects;
#using scripts\common\throttle;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\visibility_mode;
#using scripts\common\weapon;
#using scripts\mp\ai_behavior;
#using scripts\mp\ammo_cache;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\arsenal;
#using scripts\mp\common\equipment\decoy_grenade;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\compass;
#using scripts\mp\content_manager;
#using scripts\mp\crafting_table;
#using scripts\mp\currency;
#using scripts\mp\doorbuy;
#using scripts\mp\electric_power_switch;
#using scripts\mp\equipment;
#using scripts\mp\equipmentroundscaling;
#using scripts\mp\events;
#using scripts\mp\gameobjects;
#using scripts\mp\health_overcharge;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\loot_crystal;
#using scripts\mp\loot_roulette;
#using scripts\mp\magicbox;
#using scripts\mp\mp_gameskill;
#using scripts\mp\pack_a_punch;
#using scripts\mp\playerlogic;
#using scripts\mp\purchasemenu;
#using scripts\mp\weaponmetadata;
#using scripts\mp\weapons;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\points;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\procedural_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\items\zm_item;
#using scripts\mp\zm\systems\loot_drops;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_ascender;
#using scripts\mp\zm\systems\zm_catchup;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_equipment_oob;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_lighting_visionset;
#using scripts\mp\zm\systems\zm_live_spectate;
#using scripts\mp\zm\systems\zm_milestones;
#using scripts\mp\zm\systems\zm_powerups;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_telemetry;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\traps\traps;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_ui;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\zm_vehicle_ai_interact;

#namespace zm;

// Namespace zm
// Params 0
// Checksum 0xab7b43ba, Offset: 0x1f68
// Size: 0xb
function init()
{
    profilestart();
    function_46c56b307b8e7488();
    profilestop();
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0x9b7139bb, Offset: 0x1f7b
// Size: 0xab9
function private function_46c56b307b8e7488()
{
    println( "<dev string:x24>" );
    level.var_4276627efc461310 = 1;
    level.disableforfeit = 1;
    level.var_c998633bab11f3f8 = 1;
    level.allowfauxdeath = 0;
    level.var_3d48adb3865dfbe9 = 1;
    level thread gameobjects::main( [ game_utility::getgametype() ] );
    level lui_game_event_aggregator::registeronluieventcallback( &luinotifylistener );
    ui::lui_registercallback( "bink_complete", &function_db9be41dd86505c2 );
    
    if ( !isdefined( level.var_cc5333971c918a27 ) )
    {
        level.var_cc5333971c918a27 = [];
    }
    
    level.var_59b27686ba033588 = &gamelogic_zm::endgame;
    level.var_d5a94b280b9c9c35 = &gamelogic_zm::forceend;
    
    if ( !isdefined( level.bypassclasschoicefunc ) )
    {
        level.bypassclasschoicefunc = &zm_class_choice;
    }
    
    level.var_a190593393675f2f = &pre_spawn_intermission;
    setdvar( @"hash_be73a4d94209c1e6", 1 );
    setdvar( @"hash_330e06df155c6425", 1 );
    level callback::add( #"start_game_ended", &on_start_game_end );
    level.ai_badPathHandler = &ai_behavior::ai_badPathHandler;
    activity_common::function_3abef4d1ee430ea4();
    init_player_broadcasting();
    
    /#
        level thread agent_zombie_devgui::function_c007cc2059c63bd4();
    #/
    
    if ( getdvarint( @"hash_7140e37dd1c137c4", 0 ) )
    {
        level callback::add( #"player_spawned", &function_bb6410e521a32fce );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zombie_health_bar" ][ #"init" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]();
    }
    
    level.ammo_mods_in_use = 1;
    level.zombie_augments_in_use = 1;
    level.zombie_perks_in_use = 1;
    ammo_mod::init_ammo_mod();
    mp_gameskill::init_gameskill();
    namespace_af5a2e4a7277c1d::init_player();
    interaction::init_interaction();
    currency::init_currency();
    purchasemenu::init();
    events::function_b8b24a291af69f1d();
    field_upgrades::init();
    zm_item::init_items();
    content_manager::init_content_manager();
    zone_manager::init_zone_manager();
    zm_cleanup_manager::init_zm_cleanup_mgr();
    level thread namespace_c0d2b08434f47155::init_zm_powerups();
    namespace_775af9b7afedb6d1::init_scaling_health();
    namespace_ce77b5e0fc016a5a::init_scaling_damage();
    health_overcharge::init_health_overcharge();
    agent_spawner::init_agent_spawner();
    procedural_spawner::init_procedural_spawner();
    agent_spawner::function_da6c989ec2c8c5fa( "procedural" );
    weaponmetadata::init_weaponmetadata();
    zm_damage::init_zm_damage();
    function_f3ae3c143cc88a3a();
    
    if ( !( level.gametypebundle.disableammocaches ?? 0 ) )
    {
        ammocachebundle = level.gametypebundle.var_e65cc233843a50c6 ?? level.gamemodebundle.ammocachebundle ?? "ammocache:zm_ammo_cache";
        ammo_cache::init_ammo_cache( "ammocache:" + ammocachebundle );
    }
    
    level.var_787f52d8df79647f = &function_4559429a1ca8e627;
    utility::registersharedfunc( #"doorbuy", #"hash_1388194a849c420b", &function_285e210835704584 );
    doorbuy::function_3a9ed49a80b0af77();
    level thread function_c7b8ae0344379472();
    magicbox::function_bfabc0b272ff94ad();
    pack_a_punch::function_1df7c43f96254346();
    
    if ( level.gametypebundle.var_879f04b0b8155388 ?? 1 )
    {
        arsenal::init_arsenal();
    }
    
    level.var_cfde89929188f64e = &function_6206247d3b634534;
    electric_power_switch::init_electric_power_switch();
    
    if ( level.gametypebundle.craftingtableenabled ?? 1 )
    {
        crafting_table::init_crafting_table();
    }
    
    loot_drops::init_loot_drops();
    namespace_35d7a88a59082733::function_40d09bcb6ac535a();
    status_effects::function_36719164038cc9ce();
    loot_crystal::init_loot_crystal();
    level thread function_309ae33b63d236f3();
    zm_milestones::function_5b060a8b1988fdfa();
    thread namespace_c7157c2cd884c5d5::build_ai_spawn_list();
    zm_ui::init_zm_ui();
    
    if ( level.gametypebundle.var_1054418b8e6f91fd )
    {
        zm_exfil::init_zm_exfil();
    }
    
    zm_ascender::init_zm_ascender();
    zm_live_spectate::function_fbde45a76358209f();
    level thread traps::pre_init();
    level thread zm_lighting_visionset::init_zm_visionset();
    zm_fasttravel::pre_init();
    level.issp = 0;
    currency::register_currency_type( #"essence", &points::zm_get_points, &points::function_40dc4b206b63ac2e, &points::zm_add_points, &points::function_b660af7031bca4bd, "ui_zm_core_purchase_success", "ui_zm_core_purchase_deny" );
    currency::register_currency_type( #"salvage", undefined, undefined, undefined, undefined, "ui_zm_core_purchase_success", "ui_zm_core_purchase_deny" );
    currency::register_currency_type( #"rare_salvage", undefined, undefined, undefined, undefined, "ui_zm_core_purchase_success", "ui_zm_core_purchase_deny" );
    utility::registersharedfunc( #"game", #"roundNumberDifficulty", &get_shared_round_number );
    utility::registersharedfunc( #"ai", #"get_aitype_default_spawn_team_SharedFunc", &zm_utility::get_zombie_team );
    utility::registersharedfunc( #"objective", #"hash_10d5e3bb8a551724", &objective_set_minimap_floor );
    utility::registersharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", &scriptable_set_minimap_floor );
    level.set_minimap_floor_throttle = throttle::throttle_initialize( "set_minimap_floor" );
    
    /#
        level thread function_ac84867b8fbf687c();
    #/
    
    callback::add( #"player_connect", &function_1c077eb1ecd1777e );
    callback::add( #"hash_cc06eb1d45f33a0c", &function_5757e9ad7c6a6a28 );
    callback::add( #"player_spawned", &function_66e8eb1686ec4a3c );
    callback::add( "pre_gesture_weapon_fired", &pre_gesture_weapon_fired );
    callback::add( "on_gesture_weapon_fired", &on_gesture_weapon_fired );
    callback::add( "on_gesture_weapon_fire_failed", &on_gesture_weapon_fire_failed );
    callback::add( "setup_traversal", &function_f3a23f01973d6b07 );
    level callback::add( "smokeGrenade_playerGiveBlindeye", &function_680b224b3f0d6884 );
    level callback::add( "smokeGrenade_playerRemoveBlindeye", &function_473c5aba19ee9ce7 );
    level.allowclasschoicefunc = &function_36c0c0cbba48456c;
    level.var_5297cc84d8e87d08 = 1;
    level.dangerzoneskipequipment = 1;
    level.var_3d90777bfb7fc504 = [ zm_utility::get_zombie_team() ];
    level.wildcard_perkstreak_unavailable = 1;
    level thread function_834dd4def52c71f7();
    level.var_ccae9ce6e34ea885 = 1;
    zm_vehicle_ai_interact::init();
    level thread init_destructible_vehicles();
    level.ongrenadeused = &ongrenadeused;
    zm_equipment_oob::init();
    utility::registersharedfunc( #"zombie", #"is_active_zombie", &zm_utility::is_active_zombie );
    utility::registersharedfunc( #"zombie", #"hash_c6adec4328433098", &zm_utility::function_92275a9d3969d91d );
    utility::registersharedfunc( #"zombie", #"save_loadout", &zm_utility::function_d47920bb0d5fa327 );
    utility::registersharedfunc( #"zombie", #"restore_loadout", &zm_utility::function_663d59490abc834f );
    compass::init_minimap_triggers();
    weapons::deregisterusedcallback( "decoy_grenade" );
    weapons::registerusedcallback( "decoy_grenade", &function_12d3e6293a73c2b );
    level._effect[ "oob_teleport_splash" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_zmb" );
    level.var_d1e3e0e075671fee = &function_7e41c227f323cc59;
    analytics::init();
    level thread utility::callsharedfunc( #"dev", #"hash_8346b110c4eeaf2d" );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"kill_all", &function_1c370c8f9963bfe2 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_22c0d4cf18b74683", &function_2a1cb60a3ca2e928 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_sniper", &function_7e3e7ac4507e9b8b );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_4e397e83a8606489", &function_a2ba7e26ec23c3b2 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_f45b1b565a5c0fc4", &function_d8d1e27ae617c238 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_9bc2318ce9da1c72", &function_b021d4c5c5fa9093 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_launcher", &function_4fd7b2d2e2f5598e );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_92fe8ea3588c5712", &function_da3e53fbe52502eb );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_mustang_and_sally", &function_af70f57600e93468 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_c6b4372088791021", &function_db3f6071558ccb35 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_2b6b1d39b325b60c", &function_2df65d1dfd301b8c );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_3095048566c06452", &function_a5e2cade5d168680 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_ar", &function_32168a598547df5f );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_c2aa5d55a1bc4c08", &function_d25b56d985861f79 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_9197b4d6eaf0a215", &function_88c3e2d1f1b5a040 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_ff977cf713f83204", &function_688331259da6db7 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_4e09bb61efca237a", &function_b9f114d16ddfab9 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_c1edf7b9dae29898", &function_427cca46a6c07fe1 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_42446634f805d3e", &function_10286ffefd8b17da );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_2819395223d2abf5", &function_b13f30f59462e5ab );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_665fff3b69b28cbf", &function_65b5ed11b8ad4a41 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_b48628f8509c29e", &function_f55fe9dd8591c4f6 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_b23431d9d4855891", &function_1de25903e09fcd33 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_bc15158c51d2ecf6", &function_9c3fc3550398e550 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_1ead7bcd0e0f0025", &function_7f922b3445957602 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_5dec65733c945039", &function_d1fba3f1fb1aafd5 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_32323eb231fdb24e", &function_1128eb35dd4dfaba );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_68ebd4d1a93f55ef", &function_e3891ec2c6811d19 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_84b72bf483733511", &function_cb4db3a730e8257 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_wonder_weapon", &function_a51fa2105e0f353d );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_weapon_upgrades", &function_33dedaa75a02eb95 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_gobble_gum", &function_e32479f3aa4d3982 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_625d13cea1814cbf", &function_5641171d0af273f7 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_393830f4a276b894", &function_2d3253c1e36508ff );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"set_perks", &function_60168d75ab67ca5d );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_9a87edbaef818bc3", &function_36119ade864b82b7 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"open_sesame", &debug_open_sesame );
    utility::registersharedfunc( #"game", #"gettracecontents", &gettracecontents );
    utility::registersharedfunc( #"weapon", #"hash_d69e4c0c46754e0e", &function_d8f1ec0f93a731df );
    utility::registersharedfunc( #"weapon", #"is_tertiary_weapon_override", &is_tertiary_weapon_override );
    level thread function_ff28d7d30eef0baf();
    scene::function_85b13b837056bc8b( &clear_deaths_door );
    level utility::flag_set( "zm_init_done" );
    
    /#
        devgui_init_zm();
        function_e574cdc082845869();
    #/
    
    if ( getdvarint( @"hash_ead72691a7d4475", 0 ) )
    {
        zm_utility::function_9b91e8ba219b49ba();
    }
    
    scene::function_85b13b837056bc8b( &function_6a09203192cdbb7c );
    scene::function_53de0775d8452750( &function_582eb77351bda75b );
    scene::function_85b13b837056bc8b( &function_39366566e65edae9 );
    scene::function_53de0775d8452750( &function_337caccb9bec2ca0 );
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0x53e439bb, Offset: 0x2a3c
// Size: 0x29
function private function_39366566e65edae9()
{
    if ( !self.isskipping )
    {
        logstring( "====ZM IGCs: Enabling DOF dvar r_isScriptedSequence for scripted sequence====" );
        setdvar( @"r_isscriptedsequence", 1 );
    }
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0xc8db51ba, Offset: 0x2a6d
// Size: 0x1b
function private function_337caccb9bec2ca0()
{
    logstring( "====ZM IGCs: Disabling DOF dvar r_isScriptedSequence for scripted sequence====" );
    setdvar( @"r_isscriptedsequence", 0 );
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0xe094a38, Offset: 0x2a90
// Size: 0xa7
function private function_6a09203192cdbb7c()
{
    if ( level utility::flag( "playing_game_over_scene" ) )
    {
        return;
    }
    
    a_players = scene::function_5fe163f439457bd0();
    
    foreach ( player in a_players )
    {
        player.var_b9a43612c09a3d01 = 1;
        player.var_3d090afcb6aae884 = 1;
    }
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0x9f74d48e, Offset: 0x2b3f
// Size: 0x91
function private function_582eb77351bda75b()
{
    a_players = scene::function_5fe163f439457bd0();
    
    foreach ( player in a_players )
    {
        player.var_b9a43612c09a3d01 = undefined;
        player.var_3d090afcb6aae884 = undefined;
    }
}

// Namespace zm
// Params 0
// Checksum 0x5468321, Offset: 0x2bd8
// Size: 0x96
function clear_deaths_door()
{
    players = scene::function_5fe163f439457bd0();
    
    foreach ( player in players )
    {
        player utility::callsharedfunc( #"damage_effects", #"hash_7ff5e70e05a98fb0" );
    }
}

// Namespace zm
// Params 0
// Checksum 0x17c7a970, Offset: 0x2c76
// Size: 0x26
function zm_class_choice()
{
    if ( level.matchmakingmatch )
    {
        return "custom1";
    }
    
    return "default" + randomintrange( 1, 11 );
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0x548de1af, Offset: 0x2ca4
// Size: 0x6f
function private function_ff28d7d30eef0baf()
{
    level endon( #"game_ended" );
    level waittill( #"hash_d35633fbf2414299" );
    grace_period_end_time = getsystemtime() + getdvarint( @"hash_3d871d4cd062eb1c", 7200 );
    
    while ( true )
    {
        if ( getsystemtime() >= grace_period_end_time )
        {
            break;
        }
        
        wait 150;
    }
    
    zm_telemetry::function_765b8058cc2bd0a4();
    
    if ( !zm_save::is_save_load_enabled() )
    {
        level thread gamelogic_zm::forceend( 78 );
    }
}

// Namespace zm
// Params 1
// Checksum 0xa1d42c37, Offset: 0x2d1b
// Size: 0xfc
function function_12d3e6293a73c2b( grenade )
{
    grenade endon( #"death" );
    thread decoy_grenade::used( grenade );
    grenade waittill( #"hash_c860830af05fa677" );
    ground_pos = utility::groundpos( grenade.origin + 20 * ( grenade.stucknormal ?? ( 0, 0, 0 ) ) );
    grenade.closest_navmesh_point = getclosestpointonnavmesh( ground_pos );
    
    if ( !grenade zm_equipment_oob::is_equipment_in_bounds( ground_pos, 1 ) )
    {
        grenade decoy_grenade::_destroy();
        return;
    }
    
    grenade.attractor = zombie_attractor_manager::add_attractor( grenade, 1, grenade.tableinfo.bundle.var_ca694ff612181976, 0, &function_cd096832971d4e85, &function_a92d75a1117625fc, 0, undefined, 1 );
    grenade.attractor.var_9bc09bc79f28a18e = 1;
    grenade thread function_7de4ee6d3709aa7f();
}

// Namespace zm
// Params 0
// Checksum 0x9fa394ac, Offset: 0x2e1f
// Size: 0xb4
function function_7de4ee6d3709aa7f()
{
    /#
        if ( getdvarint( @"hash_f12f6f51a952373d", 0 ) && self.attractor.source )
        {
            debug_print = 1;
            var_49701458407d4208 = self.attractor.source getentitynumber();
            println( "<dev string:x63>" + var_49701458407d4208 + "<dev string:x99>" );
        }
    #/
    
    self waittill( #"death" );
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
    
    /#
        if ( debug_print )
        {
            println( "<dev string:x9b>" + var_49701458407d4208 + "<dev string:x99>" );
        }
    #/
}

// Namespace zm
// Params 2
// Checksum 0x9651752c, Offset: 0x2edb
// Size: 0x2a
function function_cd096832971d4e85( attractor, ai )
{
    return attractor.source.closest_navmesh_point;
}

// Namespace zm
// Params 2
// Checksum 0x5177cca0, Offset: 0x2f0e
// Size: 0x46, Type: bool
function function_a92d75a1117625fc( attractor, ai )
{
    return ai.aicategory == "normal" && !ai.var_840153567385cc6b && !ai.ignore_decoy;
}

// Namespace zm
// Params 2
// Checksum 0x2b908ce1, Offset: 0x2f5d
// Size: 0x53
function objective_set_minimap_floor( objectiveindex, var_93507dbfb9d9835b )
{
    objective_location = isent( var_93507dbfb9d9835b ) ? var_93507dbfb9d9835b.origin : var_93507dbfb9d9835b;
    throttle_struct = spawnstruct();
    throttle_struct thread function_3065692a1ee04e24( objectiveindex, objective_location );
}

// Namespace zm
// Params 2, eflags: 0x4
// Checksum 0x8ebe88da, Offset: 0x2fb8
// Size: 0xab
function private function_3065692a1ee04e24( objectiveindex, var_580f6130186c0aa )
{
    throttle::throttle_wait_in_queue( level.set_minimap_floor_throttle, self );
    
    if ( !objective_isvalid( objectiveindex ) )
    {
        return;
    }
    
    minimap_floor = undefined;
    zone_struct = zone_manager::function_90e5c3e2272b0130( var_580f6130186c0aa );
    
    if ( isdefined( zone_struct ) )
    {
        if ( !isdefined( zone_struct.cached_minimap_floor ) )
        {
            zone_struct.cached_minimap_floor = compass::get_minimap_floor_at_location( zone_struct.origin );
        }
        
        minimap_floor = zone_struct.cached_minimap_floor;
    }
    
    if ( !isdefined( minimap_floor ) )
    {
        minimap_floor = compass::get_minimap_floor_at_location( var_580f6130186c0aa );
    }
    
    if ( isdefined( minimap_floor ) )
    {
        function_4d5329cea2eab731( objectiveindex, minimap_floor );
    }
}

// Namespace zm
// Params 3
// Checksum 0x4c9576c3, Offset: 0x306b
// Size: 0x7b
function scriptable_set_minimap_floor( scriptable, objectivepart, var_532aa5e9196e01c5 = 1 )
{
    if ( !( isent( scriptable ) && scriptable isscriptable() ) && !( !isent( scriptable ) && scriptable isscriptableinstance() ) )
    {
        return;
    }
    
    if ( !scriptable getscriptablehaspart( objectivepart ) )
    {
        return;
    }
    
    throttle_struct = spawnstruct();
    throttle_struct thread function_bffdb4afc349ae70( scriptable, objectivepart, var_532aa5e9196e01c5 );
}

// Namespace zm
// Params 3, eflags: 0x4
// Checksum 0xc4ec1f1, Offset: 0x30ee
// Size: 0x1b0
function private function_bffdb4afc349ae70( scriptable, objectivepart, var_532aa5e9196e01c5 = 1 )
{
    if ( scriptable utility::ent_flag( "minimap_floor_setup_init" ) )
    {
        return;
    }
    
    scriptable utility::ent_flag_clear( "minimap_floor_setup_complete" );
    scriptable utility::ent_flag_set( "minimap_floor_setup_init" );
    throttle::throttle_wait_in_queue( level.set_minimap_floor_throttle, self );
    
    if ( !isdefined( scriptable ) )
    {
        return;
    }
    
    minimap_floor = undefined;
    zone_struct = zone_manager::function_90e5c3e2272b0130( scriptable.origin );
    
    if ( isdefined( zone_struct ) )
    {
        if ( !isdefined( zone_struct.cached_minimap_floor ) )
        {
            zone_struct.cached_minimap_floor = compass::get_minimap_floor_at_location( zone_struct.origin );
        }
        
        minimap_floor = zone_struct.cached_minimap_floor;
    }
    
    if ( !isdefined( minimap_floor ) )
    {
        minimap_floor = compass::get_minimap_floor_at_location( scriptable.origin );
    }
    
    if ( isdefined( minimap_floor ) )
    {
        scriptable function_d5cf89aeedbf41b( objectivepart, minimap_floor );
    }
    
    if ( var_532aa5e9196e01c5 )
    {
        assert( scriptable getscriptableparthasstate( objectivepart, "<dev string:xd6>" ), "<dev string:xdd>" + objectivepart + "<dev string:xf9>" );
        scriptable setscriptablepartstate( objectivepart, "active" );
    }
    
    /#
        scriptable_index = scriptable getscriptableindex();
        
        if ( scriptable_index > 0 )
        {
            level.var_ac84867b8fbf687c[ scriptable_index ] = { #zone_name:zone_struct.zone_name, #minimap_floor:minimap_floor, #var_30c419a777fc68f5:scriptable.origin, #scriptable:scriptable };
        }
    #/
    
    scriptable utility::ent_flag_set( "minimap_floor_setup_complete" );
    scriptable utility::ent_flag_clear( "minimap_floor_setup_init" );
}

/#

    // Namespace zm
    // Params 0, eflags: 0x4
    // Checksum 0xca08a41c, Offset: 0x32a6
    // Size: 0x1cc, Type: dev
    function private function_ac84867b8fbf687c()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_6e718638876b3599" ) )
            {
                if ( level.players[ 0 ] )
                {
                    distance_squared = squared( getdvarint( @"hash_7f4c99591432f419", 1000 ) );
                    
                    foreach ( scriptable_index, debug_data in level.var_ac84867b8fbf687c )
                    {
                        if ( !isdefined( debug_data.scriptable ) )
                        {
                            level.var_ac84867b8fbf687c[ scriptable_index ] = undefined;
                            continue;
                        }
                        
                        if ( distancesquared( level.players[ 0 ].origin, debug_data.scriptable.origin ) <= distance_squared )
                        {
                            floor_info = debug_data.minimap_floor + "<dev string:x10f>" + ( debug_data.zone_name ?? "<dev string:x112>" ) + "<dev string:x11a>";
                            debugstar( debug_data.var_30c419a777fc68f5, ( 0, 1, 1 ), 31, floor_info );
                            
                            if ( debug_data.scriptable.origin != debug_data.var_30c419a777fc68f5 )
                            {
                                line( debug_data.scriptable.origin, debug_data.var_30c419a777fc68f5, ( 0, 1, 1 ), 1, 0, 31 );
                            }
                        }
                    }
                }
            }
            
            wait 1;
        }
    }

#/

// Namespace zm
// Params 1
// Checksum 0x2b861d37, Offset: 0x347a
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

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0x75749f9, Offset: 0x34fb
// Size: 0x257
function private function_2511c7a8aa02456e()
{
    self endon( #"disconnect" );
    self.var_7bf6812e0ef8bdc9 = 0;
    var_df61301d7023216f = self.var_964cdfd67779cbcb >= 3;
    
    if ( var_df61301d7023216f )
    {
        ai_array = getaiarray();
        boss_exists = 0;
        
        foreach ( ai in ai_array )
        {
            if ( ai && ai.aicategory === "boss" )
            {
                boss_exists = 1;
            }
        }
        
        if ( !boss_exists )
        {
            var_df61301d7023216f = 0;
            self.var_964cdfd67779cbcb = undefined;
        }
    }
    
    while ( isalive( self ) && isdefined( self.smoke_end_time ) && gettime() < self.smoke_end_time && self.var_7bf6812e0ef8bdc9 < 1 && !var_df61301d7023216f )
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
    
    if ( self.var_7bf6812e0ef8bdc9 >= 1 )
    {
        if ( !isdefined( self.var_964cdfd67779cbcb ) )
        {
            self.var_964cdfd67779cbcb = 0;
        }
        
        self.var_964cdfd67779cbcb += 1;
    }
    
    self.var_7bf6812e0ef8bdc9 = undefined;
    self.smoke_kills = 0;
    val::reset_all( "smokegrenade" );
    self.smoke_end_time = undefined;
}

// Namespace zm
// Params 1
// Checksum 0x319a63ee, Offset: 0x375a
// Size: 0x2a
function function_473c5aba19ee9ce7( params )
{
    if ( !isdefined( self.perks[ "specialty_blindeye" ] ) )
    {
        self.smoke_end_time = undefined;
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xb27dc9d0, Offset: 0x378c
// Size: 0x12
function private get_shared_round_number( v_origin )
{
    return zm_utility::get_round_number();
}

// Namespace zm
// Params 1
// Checksum 0x499416f5, Offset: 0x37a7
// Size: 0xf5
function function_1c077eb1ecd1777e( params )
{
    thread function_227815b59ea09688();
    
    if ( !level utility::flag( "initial_player_connected" ) )
    {
        level utility::flag_set( "initial_player_connected" );
    }
    
    self setclientomnvar( "ui_match_start_hud_intro_animation", 0 );
    self setclientomnvar( "ui_hud_intro_widgets_visible", 0 );
    self.var_7326969d4218b720 = 0;
    self.gameskill = mp_gameskill::get_gameskill();
    mp_gameskill::apply_difficulty_settings( 1 );
    self.entity_number = self getentitynumber();
    namespace_af5a2e4a7277c1d::function_1c077eb1ecd1777e( params );
    on_player_connect_jip( params );
    thread debug_zombie_cheat();
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( "purchase_trap", &function_ade6654fd796e429 );
    callback::add( "equipped_super", &on_equipped_super );
    callback::add( #"player_weapon_change", &on_weapon_change );
    ui::lui_registercallback( "field_upgrade_edit", &on_field_upgrade_edit_notify );
    thread compass::function_a7fe4d42da59fc1b();
}

// Namespace zm
// Params 1
// Checksum 0xacf09f28, Offset: 0x38a4
// Size: 0xd3
function function_5757e9ad7c6a6a28( params )
{
    starting_essence = currency::get_start_currency_amount( #"essence" ) ?? 500;
    starting_salvage = currency::get_start_currency_amount( #"salvage" ) ?? 0;
    starting_rare_salvage = currency::get_start_currency_amount( #"rare_salvage" ) ?? 0;
    
    /#
        starting_essence = getdvarint( @"hash_fa72e80a5f2b2405", starting_essence );
        starting_salvage = getdvarint( @"hash_444223dae39edb2", starting_salvage );
        starting_rare_salvage = getdvarint( @"hash_56a6051a07a094f7", starting_rare_salvage );
    #/
    
    currency::init_player_currency( #"essence", starting_essence );
    currency::init_player_currency( #"salvage", starting_salvage );
    currency::init_player_currency( #"rare_salvage", starting_rare_salvage );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xa8b90401, Offset: 0x397f
// Size: 0xf2
function private on_field_upgrade_edit_notify( superid )
{
    if ( !val::get( "super_switching" ) )
    {
        return;
    }
    
    while ( isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::removeperk( "specialty_overcharge_field_upgrade" );
    }
    
    superref = perkpackage::function_74d21cbb27f74e78( superid );
    self.var_f20215e1fa71682a = superref;
    self.var_225bc3d2a79af41f = 0;
    self setclientomnvar( "ui_super_charge_num", 0 );
    
    if ( self isspectatingplayer() )
    {
        thread function_cd2a69ae6811a20d( superref );
    }
    else
    {
        perkpackage::perkpackage_giveimmediate( superref );
        perkpackage::perkpackage_reset();
        superinfo = self.super;
        
        if ( isdefined( superinfo ) && isdefined( superinfo.staticdata ) )
        {
            superinfo.staticdata.var_5afeac4251aa48da = &field_upgrades::function_547d8d27c323ad0;
        }
    }
    
    callback::callback( "field_upgrade_edit_notify", { #superref:superref } );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x8d9c7b21, Offset: 0x3a79
// Size: 0x5d
function private on_equipped_super( params )
{
    superinfo = params.player.super;
    
    if ( isdefined( superinfo ) && isdefined( superinfo.staticdata ) )
    {
        superinfo.staticdata.var_5afeac4251aa48da = &field_upgrades::function_547d8d27c323ad0;
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xc3c48ffd, Offset: 0x3ade
// Size: 0x7a
function private function_cd2a69ae6811a20d( superref )
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    perkpackage::perkpackage_giveimmediate( superref );
    perkpackage::perkpackage_reset();
    superinfo = self.super;
    
    if ( isdefined( superinfo ) && isdefined( superinfo.staticdata ) )
    {
        superinfo.staticdata.var_5afeac4251aa48da = &field_upgrades::function_547d8d27c323ad0;
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xc3faaa84, Offset: 0x3b60
// Size: 0x13
function private function_dabf9dc50fe937c0( params )
{
    asm::setup_level_ents_procedural();
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x67a1b323, Offset: 0x3b7b
// Size: 0x15
function private function_f3a23f01973d6b07( params )
{
    asm::function_222bc7369d339dc0( params );
}

// Namespace zm
// Params 0
// Checksum 0x7101d640, Offset: 0x3b98
// Size: 0x9
function init_player_broadcasting()
{
    player_broadcasting::function_7fc000126b792810();
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xe6f79277, Offset: 0x3ba9
// Size: 0x1e1
function private function_6206247d3b634534( weaponobj )
{
    var_2e08e94c9cb1747c = weaponobj.var_1616e6fbba9a722d;
    
    if ( isdefined( level.weaponmetadata[ var_2e08e94c9cb1747c ] ) )
    {
        var_e491cc4ce8526125 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_6c2dc03affad7ce0;
        var_e9ca9da4b737395 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_6ec5e9b28d8ba1f4;
        var_8416de761caf3df = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_c5e9a849426045ca;
        
        if ( isdefined( var_e491cc4ce8526125 ) && weaponobj hasattachment( var_e491cc4ce8526125 ) || isdefined( var_e9ca9da4b737395 ) && weaponobj hasattachment( var_e9ca9da4b737395 ) || isdefined( var_8416de761caf3df ) && weaponobj hasattachment( var_8416de761caf3df ) )
        {
            return weaponobj;
        }
        
        var_730c764888e73db3 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_a0f67da9669fe547;
        
        if ( var_730c764888e73db3 )
        {
            foreach ( override in var_730c764888e73db3 )
            {
                if ( override.var_26bf283b8c9a61c2 && weaponobj hasattachment( override.var_26bf283b8c9a61c2 ) || override.var_8187f1380726e98f && weaponobj hasattachment( override.var_8187f1380726e98f ) || override.var_d89ee8f086c17999 && weaponobj hasattachment( override.var_d89ee8f086c17999 ) )
                {
                    return weaponobj;
                }
            }
        }
        
        if ( isdefined( var_e491cc4ce8526125 ) && weaponobj canuseattachment( var_e491cc4ce8526125 ) )
        {
            weaponobj = weaponobj withattachment( var_e491cc4ce8526125 );
        }
    }
    
    return weaponobj;
}

// Namespace zm
// Params 0
// Checksum 0xf65918fa, Offset: 0x3d93
// Size: 0xd
function function_36c0c0cbba48456c()
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        return 0;
    }
}

// Namespace zm
// Params 1
// Checksum 0x389c90d2, Offset: 0x3da9
// Size: 0x46
function function_824ea4febe3f5318( params )
{
    str_team = getdvar( @"scr_force_team", "allies" );
    
    if ( self.sessionteam != str_team )
    {
        self.sessionteam = str_team;
    }
    
    return str_team;
}

// Namespace zm
// Params 1
// Checksum 0x65227333, Offset: 0x3df8
// Size: 0x7e
function on_player_connect_jip( params )
{
    /#
        if ( getdvarint( @"hash_7a75f04e0597089f", 0 ) > 0 )
        {
            return;
        }
    #/
    
    if ( utility::flag( "begin_round_logic" ) && level.gametypebundle.var_dc9908e56ab8c95d && zm_utility::get_round_number() > 1 )
    {
        if ( zm_save::function_fcccc3d2a616b1c7() )
        {
            var_6787895101874fb4 = zm_save::get_saved_player_index();
            
            if ( isdefined( var_6787895101874fb4 ) )
            {
                return;
            }
        }
        
        thread player_jip();
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x4cf2298d, Offset: 0x3e7e
// Size: 0x2da
function private on_player_spawned( params )
{
    self endon( #"disconnect" );
    visibility_mode::visibilitymode_unpackvalue();
    
    if ( self.var_7326969d4218b720 )
    {
        self setclientomnvar( "ui_hud_intro_widgets_visible", 1 );
        self setclientomnvar( "ui_match_start_hud_intro_animation", 0 );
    }
    else
    {
        self setclientomnvar( "ui_hud_intro_widgets_visible", 0 );
        self setclientomnvar( "ui_match_start_hud_intro_animation", 0 );
        childthread function_94084f883d9c1dd3();
        utility::flag_wait( "begin_round_logic" );
        self.var_7326969d4218b720 = 1;
        self setclientomnvar( "ui_match_start_hud_intro_animation", 1 );
    }
    
    if ( !level utility::flag( "initial_player_spawned" ) )
    {
        level utility::flag_set( "initial_player_spawned" );
    }
    
    self.var_fd68d41f12eb9022 = undefined;
    
    foreach ( player in level.players )
    {
        player notify( #"refresh_revives" );
        player armor::function_92490792e5aee06e( 1 );
    }
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    if ( self.var_ab2d3d86a080c80a )
    {
        while ( !self.var_282313ba8fafa8c6 )
        {
            waitframe();
        }
    }
    
    foreach ( weapon in self.primaryinventory )
    {
        if ( !item_weapon::function_42dc19da11258ab1( weapon ) )
        {
            continue;
        }
        
        if ( level.gamemodebundle.var_1976506fada1193b )
        {
            maxammo = utility::get_max_stock_ammo( weapon, 0 );
            self setweaponammostock( weapon, maxammo );
        }
        else
        {
            self givemaxammo( weapon );
        }
        
        self setweaponammoclip( weapon, weaponclipsize( weapon ) );
        
        if ( weapon.hasalternate )
        {
            var_b6f3bc7f628fdf40 = weapon getaltweapon();
            
            if ( level.gamemodebundle.var_1976506fada1193b )
            {
                maxammo = utility::get_max_stock_ammo( weapon, 0 );
                self setweaponammostock( weapon, maxammo );
            }
            else
            {
                self givemaxammo( var_b6f3bc7f628fdf40 );
            }
            
            var_83e55048826dcd05 = self getweaponammoclip( var_b6f3bc7f628fdf40 );
            var_b11feea92c35d08e = weaponclipsize( var_b6f3bc7f628fdf40 );
            
            if ( var_83e55048826dcd05 < var_b11feea92c35d08e )
            {
                self setweaponammoclip( var_b6f3bc7f628fdf40, var_b11feea92c35d08e );
            }
        }
    }
    
    if ( isbot( self ) )
    {
        self allowmelee( 0 );
        self [[ level.bot_funcs[ "bot_set_difficulty" ] ]]( "veteran" );
        thread function_8c7cf78fb5a864f8();
    }
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0xd4b4137c, Offset: 0x4160
// Size: 0x115
function private function_94084f883d9c1dd3()
{
    utility::flag_wait( "loading_screen_fade_out_begin" );
    var_15eb1687efb47b29 = gettime();
    
    if ( getdvarint( @"hash_d2c9de3016c60680", 0 ) )
    {
        logstring( "[ZM START FADE] TO black start time: " + var_15eb1687efb47b29 );
    }
    
    utility::fadetoblackforplayer( self, 1, 0.5 );
    utility::flag_wait_or_timeout( "begin_round_logic", level.var_a4cfd83be97ed632 ?? 10 );
    var_8ed7aabeb15ae611 = gettime() - var_15eb1687efb47b29;
    var_5ee623b1b84df56f = int( utility::function_4b74c15943231980( 0.5 ) );
    
    if ( getdvarint( @"hash_d2c9de3016c60680", 0 ) )
    {
        logstring( "[ZM START FADE] Wait time since fade-to-black start: " + var_8ed7aabeb15ae611 + " when the min expected time is: " + var_5ee623b1b84df56f );
    }
    
    if ( var_5ee623b1b84df56f > 0 && var_8ed7aabeb15ae611 < var_5ee623b1b84df56f )
    {
        if ( getdvarint( @"hash_d2c9de3016c60680", 0 ) )
        {
            logstring( "[ZM START FADE] waiting extra time: " + var_5ee623b1b84df56f - var_8ed7aabeb15ae611 );
        }
        
        wait utility::function_6f5d2e1f1ff70482( var_5ee623b1b84df56f - var_8ed7aabeb15ae611 );
    }
    
    wait getdvarfloat( @"hash_c98adec3e0248fc9" );
    utility::flag_set( "zm_fade_from_black_start" );
    utility::fadetoblackforplayer( self, 0, 2 );
}

// Namespace zm
// Params 0
// Checksum 0x9e335875, Offset: 0x427d
// Size: 0x2b2
function player_jip()
{
    self endon( #"disconnect" );
    self.var_ab2d3d86a080c80a = 1;
    self.var_ecd137896e764b1f = 1;
    val::set( "zm_jip", "damage", 0 );
    val::set( "zm_jip", "ignoreme", 1 );
    msg = utility::waittill_any_return( "loadout_class_selected", "spawned_player" );
    
    if ( msg == "loadout_class_selected" )
    {
        self waittill( #"spawned_player" );
    }
    
    if ( level.var_a2ec909b9c4522c9 )
    {
        waitframe();
        
        if ( !self.var_237c284740b6615a )
        {
            self.var_ab2d3d86a080c80a = 0;
            self.var_282313ba8fafa8c6 = 1;
            self.var_ecd137896e764b1f = undefined;
            params = spawnstruct();
            params.n_round_connect = zm_utility::get_round_number();
            callback::add( "on_player_hotjoin_spawn", &zm_catchup::on_player_spawned );
            callback::callback( "on_player_hotjoin_spawn", params );
            callback::remove( "on_player_hotjoin_spawn", &zm_catchup::on_player_spawned );
            
            foreach ( player in level.players )
            {
                player notify( #"refresh_revives" );
                player armor::function_92490792e5aee06e( 1 );
            }
            
            val::reset_all( "zm_jip" );
            return;
        }
    }
    
    self playerhide();
    self.var_ab2d3d86a080c80a = 0;
    self.var_282313ba8fafa8c6 = 1;
    playerlogic::removefromalivecount( 0, "hotjoin" );
    thread playerlogic::spawnspectator();
    lower_message::setlowermessageomnvar( "spawn_next_round" );
    self playershow();
    self.health = 0;
    val::reset_all( "zm_jip" );
    thread function_38f3a72a07f88ef3();
    self waittill( #"spawned_player" );
    self.var_ecd137896e764b1f = undefined;
    params = spawnstruct();
    params.n_round_connect = zm_utility::get_round_number();
    callback::callback( "on_player_hotjoin_spawn", params );
    
    foreach ( player in level.players )
    {
        player notify( #"refresh_revives" );
        player armor::function_92490792e5aee06e( 1 );
    }
}

// Namespace zm
// Params 0
// Checksum 0x3d806c33, Offset: 0x4537
// Size: 0x33
function function_38f3a72a07f88ef3()
{
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    
    while ( !self isspectatinganyone() )
    {
        waitframe();
    }
    
    callback::callback( "on_player_hotjoin_spectate" );
}

// Namespace zm
// Params 0
// Checksum 0xd76522c6, Offset: 0x4572
// Size: 0x293
function function_834dd4def52c71f7()
{
    level endon( #"game_ended" );
    
    if ( !level.gametypebundle.var_dc9908e56ab8c95d )
    {
        return;
    }
    
    if ( game_utility_mp::privatematch() )
    {
        return;
    }
    
    var_6f66525402a2b755 = undefined;
    
    while ( true )
    {
        var_c73a9983196b473a = 1;
        var_1603f86c9b25eae0 = 1;
        var_951e0055d00cd8e2 = level.gametypebundle.var_711588fc55a2c263 ?? 5;
        n_round = zm_utility::get_round_number();
        
        if ( n_round > var_951e0055d00cd8e2 )
        {
            var_1603f86c9b25eae0 = 0;
        }
        
        var_d4784b26827633db = level.gametypebundle.var_2f9c535d8f37c369 ?? 10;
        is_pap_quest_completed = zm_quest::is_pap_quest_complete();
        var_26a386771c9d759d = isdefined( level.var_6a439dd1670b61e3 ) && [[ level.var_6a439dd1670b61e3 ]]();
        
        if ( n_round >= var_d4784b26827633db || is_pap_quest_completed || var_26a386771c9d759d || level.var_fe9e4f6f7a5b0965 )
        {
            setnojipscore( 1, 1 );
            setnojiptime( 1, 1 );
            level.nojip = 1;
            level thread utility::callsharedfunc( #"zm", #"hash_23531ae6b4a96397" );
            return;
        }
        
        if ( var_1603f86c9b25eae0 )
        {
            var_c73a9983196b473a = 1;
        }
        else
        {
            players = level.players;
            alive_players = [];
            
            foreach ( player in players )
            {
                if ( isalive( player ) )
                {
                    alive_players[ alive_players.size ] = player;
                }
            }
            
            min_players = level.gametypebundle.var_d8902fd4fc094ac4 ?? 0;
            min_alive_players = level.gametypebundle.var_cbbb2b11e6f8dc77 ?? 0;
            
            if ( players.size >= min_players && alive_players.size >= min_alive_players )
            {
                var_c73a9983196b473a = 1;
            }
            else
            {
                var_c73a9983196b473a = 0;
            }
        }
        
        if ( var_c73a9983196b473a != var_6f66525402a2b755 )
        {
            setnojipscore( !var_c73a9983196b473a, !var_c73a9983196b473a );
            setnojiptime( !var_c73a9983196b473a, !var_c73a9983196b473a );
            level.nojip = !var_c73a9983196b473a;
            var_6f66525402a2b755 = var_c73a9983196b473a;
            level thread utility::callsharedfunc( #"zm", #"hash_23531ae6b4a96397" );
        }
        
        wait 0.5;
    }
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0xcff111de, Offset: 0x480d
// Size: 0x110
function private function_4559429a1ca8e627()
{
    self.interact endon( #"death" );
    utility::flag_wait( "begin_round_logic" );
    var_78682ee82f98ddcc = 750;
    var_f8eae4305d7cf3d4 = 250;
    var_41c826fabce9e09d = self.script_cost;
    
    while ( true )
    {
        utility::flag_wait( "solo_game" );
        
        if ( self.script_cost >= var_78682ee82f98ddcc )
        {
            self.script_cost -= var_f8eae4305d7cf3d4;
        }
        
        if ( isent( self.interact ) && self.interact isusable() )
        {
            self.interact sethintstringparams( self.script_cost );
        }
        
        utility::flag_waitopen( "solo_game" );
        self.script_cost = var_41c826fabce9e09d;
        
        if ( isent( self.interact ) && self.interact isusable() )
        {
            self.interact sethintstringparams( self.script_cost );
        }
        
        waitframe();
    }
}

// Namespace zm
// Params 2, eflags: 0x4
// Checksum 0x81fd57bb, Offset: 0x4925
// Size: 0x539
function private function_285e210835704584( player, half_paid )
{
    level endon( #"game_ended" );
    var_77898ab40e53d0ae = player zone_manager::get_current_zone( 1, 1 );
    player_current_origin = player.origin;
    doors = self.doors;
    var_598a0a58388cb375 = self.script_label;
    
    if ( isstring( self.s_doorbuy.script_string ) )
    {
        target_zone_id = self.s_doorbuy.script_string;
    }
    
    if ( !isstring( target_zone_id ) && isdefined( self.s_doorbuy.script_flag_set ) )
    {
        var_94f8c1d1d1291cd0 = strtok( self.s_doorbuy.script_flag_set, " " );
        var_b3eb00bce5e6b29d = strtok( self.s_doorbuy.script_flag_set, "," );
        var_54196d8915743f8c = arraycombineunique( var_94f8c1d1d1291cd0, var_b3eb00bce5e6b29d );
        
        if ( isdefined( var_77898ab40e53d0ae ) )
        {
            foreach ( var_baef2bba3edf69ae in var_54196d8915743f8c )
            {
                target_zone_id = function_65c4987207c15757( var_77898ab40e53d0ae, var_baef2bba3edf69ae );
                
                if ( isstring( target_zone_id ) )
                {
                    break;
                }
                
                waitframe();
            }
        }
    }
    
    if ( !isstring( target_zone_id ) && isdefined( var_77898ab40e53d0ae ) )
    {
        target_zones = [];
        var_c96b1c3cfbbd6aac = var_77898ab40e53d0ae.var_c96b1c3cfbbd6aac ?? [];
        
        foreach ( adjacent_id, var_82733f6af6e5f6d7 in var_c96b1c3cfbbd6aac )
        {
            foreach ( var_46f1327fcd04fb1e in var_54196d8915743f8c ?? [] )
            {
                if ( var_77898ab40e53d0ae.zone_name != adjacent_id && var_82733f6af6e5f6d7.var_46f1327fcd04fb1e == var_46f1327fcd04fb1e )
                {
                    target_zones = arraycombineunique( target_zones, [ adjacent_id ] );
                }
            }
        }
        
        if ( target_zones.size > 0 )
        {
            target_zone_id = target_zones[ 0 ];
        }
        else
        {
            waitframe();
            target_zone_id = function_4d6d5b82fa329c46( doors, player_current_origin );
            
            if ( !isstring( target_zone_id ) )
            {
                waitframe();
                target_zone_id = function_4c070c69f27f5e42( var_54196d8915743f8c );
            }
        }
    }
    
    if ( isstring( target_zone_id ) )
    {
        zone_struct = zone_manager::get_zone_struct( target_zone_id );
        
        if ( isdefined( zone_struct ) && isstring( zone_struct.display_name ) )
        {
            area_id = level.calloutglobals.areaidmap[ zone_struct.display_name ];
            
            if ( isnumber( area_id ) )
            {
                splash_name = "zm_doorbuy";
                
                switch ( var_598a0a58388cb375 ?? "" )
                {
                    case #"hash_1654e7123b279f86":
                        splash_name += "_zipline";
                        break;
                    case #"hash_cad497cc5b985285":
                        splash_name += "_barrier";
                        break;
                    default:
                        splash_name += "_default";
                        break;
                }
                
                splash_name += "_contributed";
                
                if ( half_paid )
                {
                    splash_name += "_half";
                }
                
                foreach ( l_player in level.players )
                {
                    l_player thread hud_message::showsplash( splash_name, area_id, player );
                }
            }
        }
        
        return;
    }
    
    if ( getdvarint( @"hash_dcc93261118b82e3", 0 ) == 1 )
    {
        player utility::callsharedfunc( #"hud", #"showerrormessage", %"hash_63f66465ee75ced3" );
    }
    
    /#
        if ( isstring( self.target2 ) )
        {
            doorbuy_name = self.target2;
        }
        else if ( isstring( self.target ) )
        {
            doorbuy_name = self.target;
        }
        else if ( isstring( self.script_flag_set ) )
        {
            doorbuy_name = self.script_flag_set;
        }
        else
        {
            doorbuy_name = "<dev string:x11c>";
        }
        
        println( "<dev string:x131>" + doorbuy_name + "<dev string:x169>" );
    #/
}

// Namespace zm
// Params 2, eflags: 0x4
// Checksum 0x754d7183, Offset: 0x4e66
// Size: 0x150
function private function_65c4987207c15757( var_77898ab40e53d0ae, var_baef2bba3edf69ae )
{
    if ( isstring( var_baef2bba3edf69ae ) )
    {
        inited_zones = zone_manager::get_inited_zones();
        target_zones = [];
        
        foreach ( inited_zone in inited_zones )
        {
            foreach ( zone_id_name, adjacent_zone_info in inited_zone.var_c96b1c3cfbbd6aac )
            {
                if ( adjacent_zone_info.var_46f1327fcd04fb1e == var_baef2bba3edf69ae )
                {
                    if ( zone_id_name != var_77898ab40e53d0ae.zone_name )
                    {
                        target_zones = arraycombineunique( target_zones, [ zone_id_name ] );
                    }
                }
            }
        }
        
        if ( target_zones.size == 1 )
        {
            return target_zones[ 0 ];
        }
    }
}

// Namespace zm
// Params 2, eflags: 0x4
// Checksum 0xe145ec7b, Offset: 0x4fbf
// Size: 0x138
function private function_4d6d5b82fa329c46( doors, player_current_origin )
{
    target_zone_id = undefined;
    var_864969385056fc98 = undefined;
    
    foreach ( door in doors )
    {
        if ( isvector( door.v_open_pos ) )
        {
            door_dist_sq = distance2dsquared( player_current_origin, door.v_open_pos );
            
            if ( !isdefined( var_864969385056fc98 ) || var_864969385056fc98 < door_dist_sq )
            {
                var_864969385056fc98 = door_dist_sq;
                var_6d6d7f6e5fd4b7cf = door.v_open_pos;
            }
        }
    }
    
    if ( isvector( var_6d6d7f6e5fd4b7cf ) )
    {
        point_on_navmesh = getclosestpointonnavmesh( var_6d6d7f6e5fd4b7cf );
        
        if ( isdefined( point_on_navmesh ) )
        {
            result_zone = zone_manager::function_90e5c3e2272b0130( point_on_navmesh );
            
            if ( isdefined( result_zone.zone_name ) )
            {
                target_zone_id = result_zone.zone_name;
            }
        }
    }
    
    return target_zone_id;
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x713aa194, Offset: 0x5100
// Size: 0x18d
function private function_4c070c69f27f5e42( var_54196d8915743f8c )
{
    foreach ( var_baef2bba3edf69ae in var_54196d8915743f8c )
    {
        if ( isstring( var_baef2bba3edf69ae ) )
        {
            inited_zones = zone_manager::get_inited_zones();
            target_zones = [];
            
            foreach ( inited_zone in inited_zones )
            {
                foreach ( adjacent_zone_info in inited_zone.var_c96b1c3cfbbd6aac )
                {
                    if ( adjacent_zone_info.var_46f1327fcd04fb1e === var_baef2bba3edf69ae )
                    {
                        return inited_zone.zone_name;
                    }
                }
            }
        }
    }
}

// Namespace zm
// Params 0
// Checksum 0x9323d884, Offset: 0x5296
// Size: 0xbf
function debug_zombie_cheat()
{
    if ( getdvarint( @"zombie_cheat", 0 ) < 1 || getdvarint( @"zombie_cheat", 0 ) > 3 )
    {
        return;
    }
    
    waitframe();
    currency::add_currency_amount( #"essence", 100000 );
    currency::add_currency_amount( #"salvage", 25000 );
    currency::add_currency_amount( #"rare_salvage", 25000 );
    utility::flag_wait( "begin_round_logic" );
    
    if ( getdvarint( @"zombie_cheat", 0 ) == 3 )
    {
        zm_utility::open_sesame();
    }
    
    /#
        if ( !isbot( self ) )
        {
            adddebugcommand( "<dev string:x1c4>" );
            adddebugcommand( "<dev string:x1c9>" );
        }
    #/
    
    setdvar( @"hash_cfcdb945d0507870", 1 );
}

// Namespace zm
// Params 2
// Checksum 0x3053ac69, Offset: 0x535d
// Size: 0xb3
function ongrenadeused( weaponname, grenade )
{
    weapon = utility::function_64003742d8f5c781( weaponname );
    
    switch ( weapon.basenamehash )
    {
        case %"cer_monkey_bomb_zm":
        case %"hash_b814fcfdc44ae39":
        case %"monkey_bomb_mp":
        case %"sat_monkey_bomb_zm":
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"monkey_bomb" ][ #"used" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self thread [[ var_32dbca3143d9c4a5 ]]( grenade );
            }
            
            break;
        default:
            break;
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x2cca9de7, Offset: 0x5418
// Size: 0x1bf
function private function_66e8eb1686ec4a3c( params )
{
    if ( level.gametype != "zm_rb" )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death" );
    var_b8e4e0e1d352e2c8 = [];
    radius = 1000;
    
    while ( true )
    {
        in_range_players = get_in_range_players( radius );
        
        foreach ( p in var_b8e4e0e1d352e2c8 )
        {
            if ( visibility_mode::function_7037e2a45b50f307() )
            {
                continue;
            }
            
            if ( !isdefined( p ) || arraycontains( in_range_players, p ) )
            {
                continue;
            }
            
            p hudoutlinedisableforclient( self );
            self hudoutlinedisableforclient( p );
            var_b8e4e0e1d352e2c8 = arrayremove( var_b8e4e0e1d352e2c8, p );
        }
        
        var_b8e4e0e1d352e2c8 = function_5713d46873b29625( var_b8e4e0e1d352e2c8 );
        
        foreach ( p in in_range_players )
        {
            if ( isdefined( p ) && !arraycontains( var_b8e4e0e1d352e2c8, p ) && !self.var_b9a43612c09a3d01 )
            {
                p hudoutlineenableforclients( [ self ], "friendly_player" );
                self hudoutlineenableforclients( [ p ], "friendly_player" );
                var_b8e4e0e1d352e2c8[ var_b8e4e0e1d352e2c8.size ] = p;
            }
        }
        
        waitframe();
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x2ac31414, Offset: 0x55df
// Size: 0x11b
function private get_in_range_players( radius )
{
    in_range_players = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.team != self.team )
        {
            continue;
        }
        
        if ( player.var_b9a43612c09a3d01 || getdvarint( @"hash_d174eb86cb9725af", 0 ) || player.var_3d090afcb6aae884 )
        {
            continue;
        }
        
        if ( player vehicle::is_in_vehicle() )
        {
            continue;
        }
        
        if ( distancesquared( player.origin, self.origin ) > squared( radius ) )
        {
            continue;
        }
        
        in_range_players[ in_range_players.size ] = player;
    }
    
    return in_range_players;
}

// Namespace zm
// Params 2
// Checksum 0xf73447a5, Offset: 0x5703
// Size: 0x2c
function luinotifylistener( notification, value )
{
    if ( notification === "versus_done" )
    {
        utility::flag_set( "loading_screen_over" );
    }
}

// Namespace zm
// Params 1
// Checksum 0xb20113b9, Offset: 0x5737
// Size: 0x18
function function_db9be41dd86505c2( params )
{
    utility::flag_set( "loading_screen_fade_out_begin" );
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0x657ad1a0, Offset: 0x5757
// Size: 0x53
function private function_227815b59ea09688()
{
    level endon( #"game_ended" );
    
    if ( utility::flag( "loading_screen_over" ) )
    {
        return;
    }
    
    max_wait_time_s = getdvarint( @"hash_976d1ac4cb52adfe", 15 );
    level utility::flag_wait_or_timeout( "loading_screen_over", max_wait_time_s );
    utility::flag_set( "loading_screen_over" );
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0x3a54267b, Offset: 0x57b2
// Size: 0xe
function private function_70d79ec7071084b1()
{
    level notify( #"hash_d35633fbf2414299" );
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0x27d483c4, Offset: 0x57c8
// Size: 0xa1
function private init_destructible_vehicles()
{
    level utility::flag_wait( "rockable_cars_init" );
    
    foreach ( car in level.rockablecars.cars )
    {
        if ( !isdefined( car ) )
        {
            continue;
        }
        
        car.var_680baa076be6d8b = 1;
    }
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0x15a0cda0, Offset: 0x5871
// Size: 0x40
function private function_e9847738b15473bc()
{
    var_130021f567c253d5 = [];
    
    if ( level.var_e35ab30242703f86.size )
    {
        var_130021f567c253d5 = level.var_e35ab30242703f86;
    }
    else
    {
        var_130021f567c253d5 = getentarray( "mp_global_intermission", #classname );
    }
    
    return var_130021f567c253d5;
}

/#

    // Namespace zm
    // Params 0, eflags: 0x4
    // Checksum 0xc9eed6ce, Offset: 0x58ba
    // Size: 0xd0, Type: dev
    function private devgui_init_zm()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1d3>" );
        devgui::add_devgui_func( "<dev string:x1d7>", "<dev string:x1e3>", &devgui_open_sesame );
        devgui::add_devgui_func( "<dev string:x1ef>", "<dev string:x204>", &devgui_infinite_ammo );
        devgui::add_devgui_func( "<dev string:x219>", "<dev string:x22d>", &function_886e4bcec5d3a0cb );
        devgui::add_devgui_func( "<dev string:x248>", "<dev string:x248>", &function_9897ce48adf767c1 );
        devgui::add_devgui_func( "<dev string:x260>", "<dev string:x260>", &function_bcd04333fd9c3d80 );
        devgui::add_devgui_func( "<dev string:x275>", "<dev string:x290>", &function_d4167cae5a020a98 );
        devgui::add_devgui_func( "<dev string:x2ab>", "<dev string:x2cb>", &function_235cb2f6ed75fb83 );
        devgui::add_devgui_func( "<dev string:x2eb>", "<dev string:x30a>", &function_70d79ec7071084b1 );
        devgui::function_77df7fe7dd273e10();
        level thread function_664699efe9c8686a();
    }

    // Namespace zm
    // Params 0, eflags: 0x4
    // Checksum 0x597d04dc, Offset: 0x5992
    // Size: 0x101, Type: dev
    function private function_664699efe9c8686a()
    {
        if ( utility::issharedfuncdefined( #"zm", #"wait_begin_round_logic" ) )
        {
            level [[ utility::getsharedfunc( #"zm", #"wait_begin_round_logic" ) ]]();
        }
        else if ( utility::flag_exist( "<dev string:x329>" ) )
        {
            utility::flag_wait( "<dev string:x329>" );
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x33b>" );
        var_130021f567c253d5 = function_e9847738b15473bc();
        
        foreach ( index, intermission_camera in var_130021f567c253d5 )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x354>" + index, "<dev string:x369>" + index, &function_6af751df11165c90 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm
    // Params 1, eflags: 0x4
    // Checksum 0xaa95aeb9, Offset: 0x5a9b
    // Size: 0x1e8, Type: dev
    function private function_6af751df11165c90( params )
    {
        var_130021f567c253d5 = function_e9847738b15473bc();
        
        foreach ( index, intermission_camera in var_130021f567c253d5 )
        {
            if ( index == int( params[ 0 ] ) )
            {
                if ( isent( intermission_camera ) )
                {
                    camera_ent = intermission_camera;
                }
                else
                {
                    if ( !isdefined( intermission_camera.camera_ent ) )
                    {
                        intermission_camera.camera_ent = utility::spawn_tag_origin( intermission_camera.origin, intermission_camera.angles );
                        intermission_camera.camera_ent.var_4226a37fed37a2df = 1;
                    }
                    
                    camera_ent = intermission_camera.var_c8692c885ac9b10d;
                }
                
                if ( level.players[ 0 ].var_1d281b9d06a583b9 == camera_ent )
                {
                    b_disabled_camera = 1;
                }
                
                if ( isdefined( level.players[ 0 ].var_1d281b9d06a583b9 ) )
                {
                    level.players[ 0 ] cameraunlink();
                    
                    if ( level.players[ 0 ].var_1d281b9d06a583b9.var_4226a37fed37a2df )
                    {
                        level.players[ 0 ].var_1d281b9d06a583b9 delete();
                    }
                }
                
                if ( b_disabled_camera )
                {
                    level.players[ 0 ].var_1d281b9d06a583b9 = undefined;
                    return;
                }
                
                level.players[ 0 ] cameralinkto( camera_ent, #"tag_origin", 0, 1 );
                level.players[ 0 ].var_1d281b9d06a583b9 = camera_ent;
                return;
            }
        }
    }

    // Namespace zm
    // Params 0, eflags: 0x4
    // Checksum 0xcc3ac148, Offset: 0x5c8b
    // Size: 0xc, Type: dev
    function private devgui_open_sesame()
    {
        zm_utility::open_sesame();
    }

    // Namespace zm
    // Params 0, eflags: 0x4
    // Checksum 0x8a495cac, Offset: 0x5c9f
    // Size: 0x54, Type: dev
    function private devgui_infinite_ammo()
    {
        value = getdvarint( @"player_sustainammo", 0 );
        
        if ( value == 0 )
        {
            announcement( "<dev string:x383>" );
            value = 1;
        }
        else
        {
            announcement( "<dev string:x396>" );
            value = 0;
        }
        
        setdvar( @"player_sustainammo", value );
    }

    // Namespace zm
    // Params 0, eflags: 0x4
    // Checksum 0x78ac4f7, Offset: 0x5cfb
    // Size: 0x28, Type: dev
    function private function_e574cdc082845869()
    {
        if ( getdvarint( @"zombie_cheat", 0 ) == 2 )
        {
            setdvar( @"zm_round_spawning_enabled", 0 );
        }
    }

    // Namespace zm
    // Params 1, eflags: 0x4
    // Checksum 0x8c84bf3f, Offset: 0x5d2b
    // Size: 0x93, Type: dev
    function private function_886e4bcec5d3a0cb( params )
    {
        player = function_a8d27574578f1f31( params[ 0 ] );
        
        foreach ( player in level.players )
        {
            player thread function_bb6410e521a32fce();
        }
    }

    // Namespace zm
    // Params 0, eflags: 0x4
    // Checksum 0xc8a5e252, Offset: 0x5dc6
    // Size: 0x8c, Type: dev
    function private function_9897ce48adf767c1()
    {
        foreach ( player in level.players )
        {
            player currency::add_currency_amount( #"essence", 100000 );
        }
    }

    // Namespace zm
    // Params 0, eflags: 0x4
    // Checksum 0xf6102cc, Offset: 0x5e5a
    // Size: 0xb0, Type: dev
    function private function_bcd04333fd9c3d80()
    {
        foreach ( player in level.players )
        {
            player_currency = player currency::get_currency_amount( #"essence" );
            success = player currency::attempt_purchase( #"essence", player_currency - 1 );
        }
    }

    // Namespace zm
    // Params 0, eflags: 0x4
    // Checksum 0xdb9f7b69, Offset: 0x5f12
    // Size: 0x4b, Type: dev
    function private function_d4167cae5a020a98()
    {
        var_df00f5fbf4a6d195 = getdvarint( @"hash_72e4d6b8f8afa03", 0 );
        var_df00f5fbf4a6d195 = !var_df00f5fbf4a6d195;
        setdvar( @"hash_72e4d6b8f8afa03", var_df00f5fbf4a6d195 );
        iprintlnbold( var_df00f5fbf4a6d195 ? "<dev string:x3aa>" : "<dev string:x3c6>" );
    }

    // Namespace zm
    // Params 0, eflags: 0x4
    // Checksum 0xdd27bb38, Offset: 0x5f65
    // Size: 0x36, Type: dev
    function private function_235cb2f6ed75fb83()
    {
        level.var_4a4831f495f1cbfd = !level.var_4a4831f495f1cbfd;
        iprintlnbold( level.var_4a4831f495f1cbfd ? "<dev string:x3e1>" : "<dev string:x3fa>" );
    }

#/

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x804b1d70, Offset: 0x5fa3
// Size: 0x13
function private debug_open_sesame( params )
{
    zm_utility::open_sesame();
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x2b91f193, Offset: 0x5fbe
// Size: 0xe1
function private function_a8d27574578f1f31( specified_player )
{
    player = undefined;
    
    if ( specified_player == "random" )
    {
        player = utility::array_random( level.players );
    }
    else
    {
        if ( specified_player == "me" )
        {
            specified_player = getdvar( @"cheat_player" );
        }
        
        foreach ( var_5e2221840c5be55d in level.players )
        {
            if ( issubstr( tolower( var_5e2221840c5be55d.name ), tolower( specified_player ) ) )
            {
                return var_5e2221840c5be55d;
            }
        }
    }
    
    return player;
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xb6abccd8, Offset: 0x60a8
// Size: 0xbe
function private function_e9035d5d64c6a4f4( params )
{
    players = level.players;
    
    foreach ( param in params )
    {
        param_delimited = strtok( param, ":" );
        
        if ( isstartstr( param, "player:" ) )
        {
            players = [ function_a8d27574578f1f31( param_delimited[ 1 ] ) ];
        }
    }
    
    return players;
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x43e1d46d, Offset: 0x616f
// Size: 0x150
function private function_33dedaa75a02eb95( params )
{
    player = undefined;
    
    if ( isdefined( params ) )
    {
        foreach ( param in params )
        {
            param_delimited = strtok( param, ":" );
            
            if ( isstartstr( param, "player:" ) )
            {
                player = function_a8d27574578f1f31( param_delimited[ 1 ] );
            }
        }
    }
    
    if ( !isdefined( player ) )
    {
        if ( isdefined( params[ 0 ] ) )
        {
            player = function_a8d27574578f1f31( params[ 0 ] );
        }
    }
    
    if ( !isdefined( player ) )
    {
        foreach ( player in level.players )
        {
            player give_player_weapon_upgrades();
        }
        
        return;
    }
    
    player give_player_weapon_upgrades();
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0xda25e5bc, Offset: 0x62c7
// Size: 0x362
function private give_player_weapon_upgrades()
{
    item_upgrades = [ %"itemspawnentry:zm_t10_item_aether_crystal", %"itemspawnentry:zm_t10_item_aether_crystal_2", %"itemspawnentry:zm_t10_item_aether_crystal_3", %"hash_4c599d18f654328c", %"itemspawnentry:zm_t10_item_aether_tool", %"itemspawnentry:zm_t10_item_aether_tool_2", %"itemspawnentry:zm_t10_item_aether_tool_3", %"itemspawnentry:zm_t10_item_aether_tool_4", %"hash_7a0163ba7eb3481" ];
    i = int( item_upgrades.size * -1 / 2 );
    
    foreach ( item_upgrade in item_upgrades )
    {
        itembundle = getscriptbundle( item_upgrade );
        
        if ( itembundle )
        {
            origin = self.origin + anglestoforward( self.angles ) * 100 + anglestoright( self.angles ) * 30 * i;
            spawnoptions = common_item::function_bc5ff2958b71a708( origin );
            item = common_item::function_61c2c0251e742ffd( itembundle, common_item::function_ea3b3088d82fd357( itembundle, spawnoptions ) ?? 1, spawnoptions );
            i++;
        }
    }
    
    use_sat = isdefined( getscriptbundle( %"itemspawnentry:zm_t10_item_ammomod_brainrot" ) );
    item_prefix = use_sat ? %"hash_17b4362c2379998b" : %"hash_3488eacd282fa292";
    item_upgrades = [ "ammomod_brainrot", "ammomod_cryofreeze", "ammomod_deadwire", "ammomod_napalmburst", "ammomod_shadowvortex", "ammomod_shatterblast", "ammomod_fw" ];
    i = int( item_upgrades.size * -1 / 2 );
    
    foreach ( item_upgrade in item_upgrades )
    {
        item_upgrade = hashcat( item_prefix, item_upgrade );
        itembundle = getscriptbundle( item_upgrade );
        
        if ( !itembundle )
        {
            continue;
        }
        
        origin = self.origin + anglestoforward( self.angles ) * 200 + anglestoright( self.angles ) * 30 * i;
        spawnoptions = common_item::function_bc5ff2958b71a708( origin );
        item = common_item::function_61c2c0251e742ffd( itembundle, common_item::function_ea3b3088d82fd357( itembundle, spawnoptions ) ?? 1, spawnoptions );
        i++;
    }
    
    for ( s_weapon_bundle = undefined; !isdefined( s_weapon_bundle ) ; s_weapon_bundle = getscriptbundle( random_weapon_entry ) )
    {
        random_weapon_entry = utility::array_random( level.weaponmetadata ).itementry;
        
        if ( random_weapon_entry )
        {
        }
    }
    
    if ( s_weapon_bundle )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin + anglestoforward( self.angles ) * 10 );
        var_8a61d4195b4b6e64 = item_weapon::function_b960bc85ea91de14( s_weapon_bundle, spawnoptions );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x9412d512, Offset: 0x6631
// Size: 0x15c
function private function_e32479f3aa4d3982( params )
{
    player = undefined;
    gobble_gum_str = undefined;
    
    if ( isdefined( params ) )
    {
        gobble_gum_str = params[ 0 ];
        
        foreach ( param in params )
        {
            param_delimited = strtok( param, ":" );
            
            if ( isstartstr( param, "player:" ) )
            {
                player = function_a8d27574578f1f31( param_delimited[ 1 ] );
            }
        }
    }
    
    if ( isdefined( gobble_gum_str ) )
    {
        if ( !isdefined( player ) )
        {
            iprintlnbold( "Giving all players' gobblegum of  " + gobble_gum_str );
            
            foreach ( player in level.players )
            {
                player give_gobble_gum( gobble_gum_str );
            }
            
            return;
        }
        
        player give_gobble_gum( gobble_gum_str );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xf39885cf, Offset: 0x6795
// Size: 0x15
function private give_gobble_gum( gobble_gum_str )
{
    bgb::function_c068e36660508e7c( gobble_gum_str );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xeefca8eb, Offset: 0x67b2
// Size: 0x184
function private function_5641171d0af273f7( params )
{
    player = undefined;
    
    if ( isdefined( params ) )
    {
        player = params[ 0 ];
        
        foreach ( param in params )
        {
            param_delimited = strtok( param, ":" );
            
            if ( isstartstr( param, "player:" ) )
            {
                player = function_a8d27574578f1f31( param_delimited[ 1 ] );
            }
        }
    }
    else if ( isplayer( self ) )
    {
        player = self;
    }
    
    if ( !isdefined( player ) )
    {
        iprintlnbold( "Removing all players' gobblegums" );
        
        foreach ( player in level.players )
        {
            player bgb::take( 1 );
            player bgb::take( 2 );
            player bgb::take( 3 );
        }
        
        return;
    }
    
    player bgb::take( 1 );
    player bgb::take( 2 );
    player bgb::take( 3 );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xb68d63a8, Offset: 0x693e
// Size: 0x15c
function private function_60168d75ab67ca5d( params )
{
    player = undefined;
    perk_layout = undefined;
    
    if ( isdefined( params ) )
    {
        perk_layout = params[ 0 ];
        
        foreach ( param in params )
        {
            param_delimited = strtok( param, ":" );
            
            if ( isstartstr( param, "player:" ) )
            {
                player = function_a8d27574578f1f31( param_delimited[ 1 ] );
            }
        }
    }
    
    if ( isdefined( perk_layout ) )
    {
        if ( !isdefined( player ) )
        {
            iprintlnbold( "Setting all players' perk layouts to " + perk_layout );
            
            foreach ( player in level.players )
            {
                player function_a02470e428fd330c( perk_layout );
            }
            
            return;
        }
        
        player function_a02470e428fd330c( perk_layout );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x5d18ef64, Offset: 0x6aa2
// Size: 0xf9
function private function_a02470e428fd330c( perk_layout )
{
    if ( perk_layout === "none" )
    {
        zombie_perks::take_all_perks();
        return;
    }
    
    if ( perk_layout === "all" )
    {
        zombie_perks::function_a0329bb1c47eda09();
        return;
    }
    
    if ( perk_layout === "core" )
    {
        zombie_perks::take_all_perks();
        zombie_perks::give_perk( "specialty_juggernog" );
        zombie_perks::give_perk( "specialty_quickrevive" );
        zombie_perks::give_perk( "specialty_speedcola" );
        zombie_perks::give_perk( "specialty_staminup" );
        return;
    }
    
    if ( perk_layout === "launch" )
    {
        zombie_perks::take_all_perks();
        zombie_perks::give_perk( "specialty_juggernog" );
        zombie_perks::give_perk( "specialty_quickrevive" );
        zombie_perks::give_perk( "specialty_speedcola" );
        zombie_perks::give_perk( "specialty_staminup" );
        zombie_perks::give_perk( "specialty_elemental_pop" );
        zombie_perks::give_perk( "specialty_phd_flopper" );
        zombie_perks::give_perk( "specialty_death_perception" );
        zombie_perks::give_perk( "specialty_deadshot" );
        zombie_perks::give_perk( "specialty_m_mod" );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x23aaca04, Offset: 0x6ba3
// Size: 0x168
function private function_36119ade864b82b7( params )
{
    player = undefined;
    
    if ( isdefined( params ) )
    {
        armor_level = int( params[ 0 ] );
        
        foreach ( param in params )
        {
            param_delimited = strtok( param, ":" );
            
            if ( isstartstr( param, "player:" ) )
            {
                player = function_a8d27574578f1f31( param_delimited[ 1 ] );
            }
        }
    }
    
    if ( !isdefined( player ) )
    {
        foreach ( player in level.players )
        {
            player armor::function_b359444c252374fc( armor::function_db9ebf086f67fe92() );
            player namespace_74c85f0ddf2d285f::function_fdbe2cad6d8bb7e7( armor_level );
        }
        
        return;
    }
    
    player armor::function_b359444c252374fc( armor::function_db9ebf086f67fe92() );
    player namespace_74c85f0ddf2d285f::function_fdbe2cad6d8bb7e7( armor_level );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xe26d95bd, Offset: 0x6d13
// Size: 0x188
function private function_a51fa2105e0f353d( params )
{
    weapon = undefined;
    pap_level = undefined;
    player = undefined;
    
    if ( isdefined( params ) )
    {
        weapon = params[ 0 ];
        
        foreach ( param in params )
        {
            param_delimited = strtok( param, ":" );
            
            if ( isstartstr( param, "player:" ) )
            {
                player = function_a8d27574578f1f31( param_delimited[ 1 ] );
                continue;
            }
            
            if ( isstartstr( param, "pap:" ) )
            {
                pap_level = int( param_delimited[ 1 ] );
                continue;
            }
            
            if ( isstartstr( param, "weapon:" ) )
            {
                weapon = param_delimited[ 1 ];
            }
        }
    }
    
    if ( !isdefined( player ) )
    {
        foreach ( player in level.players )
        {
            player function_1693f9e934b707ea( weapon, pap_level );
        }
        
        return;
    }
    
    player function_1693f9e934b707ea( weapon, pap_level );
}

// Namespace zm
// Params 2
// Checksum 0x1dfa8c03, Offset: 0x6ea3
// Size: 0x277
function function_1693f9e934b707ea( weapon, pap_level )
{
    var_3e578008983f0cb7 = undefined;
    wonder_weapon_structs = [];
    map_name_delimited = strtok( level.mapname, "_" );
    
    if ( !isdefined( weapon ) )
    {
        weapon = map_name_delimited[ map_name_delimited.size - 1 ];
    }
    
    foreach ( var_b87c8459d148bf6a in level.weaponmetadata )
    {
        if ( var_b87c8459d148bf6a.iswonderweapon )
        {
            if ( isdefined( level.var_c5111f0d24e5789a ) )
            {
                foreach ( magic_box_item_entry in level.var_c5111f0d24e5789a )
                {
                    if ( var_b87c8459d148bf6a.itementry === magic_box_item_entry )
                    {
                        wonder_weapon_structs[ var_b87c8459d148bf6a.weapon ] = var_b87c8459d148bf6a;
                        break;
                    }
                }
            }
            
            if ( issubstr( var_b87c8459d148bf6a.weapon, map_name_delimited[ map_name_delimited.size - 1 ] ) )
            {
                wonder_weapon_structs[ var_b87c8459d148bf6a.weapon ] = var_b87c8459d148bf6a;
                continue;
            }
            
            if ( issubstr( var_b87c8459d148bf6a.weapon, weapon ) )
            {
                var_3e578008983f0cb7 = var_b87c8459d148bf6a.itementry;
            }
        }
    }
    
    if ( !isdefined( var_3e578008983f0cb7 ) )
    {
        var_3e578008983f0cb7 = utility::array_random( wonder_weapon_structs ).itementry;
    }
    
    if ( !isdefined( var_3e578008983f0cb7 ) )
    {
        /#
            iprintlnbold( "<dev string:x415>" );
        #/
        
        return;
    }
    
    s_weapon_bundle = getscriptbundle( var_3e578008983f0cb7 );
    
    if ( !isdefined( level.weaponmetadata[ getxhashasset( s_weapon_bundle.ref ) ].var_6ec5e9b28d8ba1f4 ) )
    {
        pap_level = 0;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin + anglestoforward( self.angles ) * 50 );
    spawnoptions.overridepaplvl = pap_level;
    item = common_item::function_61c2c0251e742ffd( s_weapon_bundle, undefined, spawnoptions );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xb0daf708, Offset: 0x7122
// Size: 0x90
function private function_2a1cb60a3ca2e928( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_bb6410e521a32fce();
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x25a0f325, Offset: 0x71ba
// Size: 0x91
function private function_7e3e7ac4507e9b8b( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_76df503bca498ac5( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x5a7a7723, Offset: 0x7253
// Size: 0x91
function private function_a2ba7e26ec23c3b2( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_96f0772aadbaf24( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x4c9acf8, Offset: 0x72ec
// Size: 0x91
function private function_d8d1e27ae617c238( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_3aecae5b0150ce40( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x711b66c0, Offset: 0x7385
// Size: 0x91
function private function_b021d4c5c5fa9093( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_cc76d4f2768fccfb( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x35b319e4, Offset: 0x741e
// Size: 0x91
function private function_4fd7b2d2e2f5598e( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_e3310c6bc5f0cc52( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xe3e41631, Offset: 0x74b7
// Size: 0x91
function private function_da3e53fbe52502eb( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_6977b98ba2ebeed9( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x920ab9d6, Offset: 0x7550
// Size: 0x91
function private function_88c3e2d1f1b5a040( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_53cd25a30a3920a( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x22bc2e10, Offset: 0x75e9
// Size: 0x91
function private function_688331259da6db7( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_42d384ca3c76eee3( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x39bc1e0d, Offset: 0x7682
// Size: 0x91
function private function_b9f114d16ddfab9( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_13013f80cf2fb2f9( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x82b0a7ec, Offset: 0x771b
// Size: 0x91
function private function_427cca46a6c07fe1( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_ac57ca8aaf8e8179( params );
    }
}

// Namespace zm
// Params 1
// Checksum 0x9d89ddd7, Offset: 0x77b4
// Size: 0x3e
function function_10286ffefd8b17da( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_lm_zeus_orange" ], is_maxed, [ "sat_stock_akimbo_lm_zeus" ] );
}

// Namespace zm
// Params 1
// Checksum 0xac6e9967, Offset: 0x77fa
// Size: 0x74
function function_b13f30f59462e5ab( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_sh_corso_orange" ], is_maxed, [ "sat_microreflex01_sh", "sat_bar_range_sh_corso", "sat_laser_focuslaser_sh_corso", "sat_firemod_pump_sh_corso", "sat_muzzle_suppressor_sh_corso", "sat_stock_movespeed_sh_corso", "sat_underbarrel_mixunder_sh_corso" ] );
}

// Namespace zm
// Params 1
// Checksum 0x82b95b0f, Offset: 0x7876
// Size: 0x62
function function_65b5ed11b8ad4a41( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_pi_atlas_orange" ], is_maxed, [ "sat_mag_extmag2_pi_atlas", "sat_bar_range_pi_atlas", "sat_stock_akimbo_pi_atlas", "sat_firemod_springs_pi_atlas", "sat_muzzle_suppressor_pi_atlas" ] );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x2850ee9a, Offset: 0x78e0
// Size: 0x47
function private function_1de25903e09fcd33( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_sn_baltic_orange" ], is_maxed, [ "sat_ub_crossbar_sn_baltic", "sat_ironsights_sn_baltic_minigun" ] );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x115245ab, Offset: 0x792f
// Size: 0x47
function private function_9c3fc3550398e550( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_ar_vulture_orange" ], is_maxed, [ "sat_underbarrel_dual_fire_ar_vulture_pap", "sat_underbarrel_dual_fire_ar_vulture" ] );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x707c280c, Offset: 0x797e
// Size: 0x34
function private function_1128eb35dd4dfaba( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_dm_tasman_ultra" ], is_maxed );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xc586751b, Offset: 0x79ba
// Size: 0x34
function private function_d1fba3f1fb1aafd5( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_sh_terrier_ultra" ], is_maxed );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x8732647e, Offset: 0x79f6
// Size: 0x34
function private function_e3891ec2c6811d19( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_sm_mammoth_ultra" ], is_maxed );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x4d1468c, Offset: 0x7a32
// Size: 0x34
function private function_cb4db3a730e8257( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_sm_stoat_ultra" ], is_maxed );
}

// Namespace zm
// Params 1
// Checksum 0xd241f422, Offset: 0x7a6e
// Size: 0x7d
function function_f55fe9dd8591c4f6( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_dm_kara_orange" ], is_maxed, [ "sat_mag_extmag_dm_kara", "sat_microreflex03_dmr", "sat_muzzle_suppressor_dm_kara", "sat_bar_highcal_dm_kara", "sat_stock_adsmove_dm_kara", "sat_firemod_boltcarrier_dm_kara", "sat_laser_focuslaser_dm_kara", "sat_underbarrel_mixunder_dm_kara" ] );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x89c6e38b, Offset: 0x7af3
// Size: 0x91
function private function_32168a598547df5f( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_ac3d92a4bc86ac2d( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xfb96c38c, Offset: 0x7b8c
// Size: 0x91
function private function_d25b56d985861f79( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_48270aa76a6c671f( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xbdf7c7d8, Offset: 0x7c25
// Size: 0x91
function private function_af70f57600e93468( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_45dc39b49054520b( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xf04adb07, Offset: 0x7cbe
// Size: 0x91
function private function_db3f6071558ccb35( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_53b7f32d9beb3c88( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xac65225, Offset: 0x7d57
// Size: 0x91
function private function_2df65d1dfd301b8c( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_cafca0d7f0551fef( params );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x8d56e432, Offset: 0x7df0
// Size: 0x91
function private function_a5e2cade5d168680( params )
{
    players = function_e9035d5d64c6a4f4( params );
    
    foreach ( player in players )
    {
        player thread function_9f76eeda3e5677e3( params );
    }
}

// Namespace zm
// Params 1
// Checksum 0x86fce5bd, Offset: 0x7e89
// Size: 0x170
function function_bb6410e521a32fce( params )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    currency::add_currency_amount( #"essence", 50000 );
    currency::add_currency_amount( #"rare_salvage", 50000 );
    currency::add_currency_amount( #"salvage", 50000 );
    zombie_perks::take_all_perks();
    zombie_perks::function_a0329bb1c47eda09();
    var_8d8f914fe8f2913f = [ "equip_cluster_grenade" ];
    equipment_mp::giveequipment( utility::array_random( var_8d8f914fe8f2913f ), "primary" );
    equipment_mp::giveequipment( "equip_decoy", "secondary" );
    function_5641171d0af273f7();
    bgb::function_c068e36660508e7c( "perkaholic" );
    bgb::function_c068e36660508e7c( "free_fire" );
    bgb::function_c068e36660508e7c( "idle_eyes" );
    killstreaks = [ "dawg" ];
    killstreaks::awardkillstreak( utility::array_random( killstreaks ), "other", undefined, undefined, undefined, 1 );
    namespace_74c85f0ddf2d285f::function_fdbe2cad6d8bb7e7( 3 );
    super_power = utility::array_random( [ "super_healing_aura", "super_frenzied_guard", "super_energy_mine", "super_aether_shroud", "super_dark_flare", "super_tesla_storm", "super_frost_blast", "super_wiley_fox" ] );
    thread perkpackage::perkpackage_givedebug( super_power );
    function_f1fa974d7683ac26();
}

// Namespace zm
// Params 1
// Checksum 0x77961dd9, Offset: 0x8001
// Size: 0x62
function function_96f0772aadbaf24( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_t10_item_weapon_sh_p25_uncle12_orange" ], is_maxed, [ "t10_muzzles_choke2_sh_uncle12", "t10_bar_highcal_sh_uncle12", "t10_mags_extclip2_sh_uncle12", "t10_stocks_hipfiremove_sh_uncle12", "t10_lasers_hipaccuracy_sh_uncle12" ] );
}

// Namespace zm
// Params 1
// Checksum 0x19f54da6, Offset: 0x806b
// Size: 0x74
function function_3aecae5b0150ce40( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_t10_item_weapon_sh_p27_jhavana_orange" ], is_maxed, [ "t10_muzzles_suppressor_sh_jhavana", "t10_underbarrel_mixunder2_sh_jhavana", "t10_mags_extclip2_sh_jhavana", "t10_grips_mixgrip_sh_jhavana", "t10_stocks_hipfiremove_sh_jhavana", "t10_ammo_12g_db_sh_jhavana", "t10_lasers_focuslaser_sh_jhavana" ] );
}

// Namespace zm
// Params 1
// Checksum 0x9fc9b55e, Offset: 0x80e7
// Size: 0x8f
function function_cc76d4f2768fccfb( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_sh_akita_orange" ], is_maxed, [ "sat_ammo_12g_short_db_sh_akita", "sat_bar_range_sh_akita", "sat_grip_sh_akita", "sat_ironsights_sh_akita", "sat_laser_hipaccuracy_sh_akita", "sat_mag_extmag2_sh_akita", "sat_muzzle_mono_suppressor_sh_akita", "sat_rec_sh_akita", "sat_stock_sh_akita", "sat_underbarrel_recoil_sh_akita" ] );
}

// Namespace zm
// Params 1
// Checksum 0xa7ef260e, Offset: 0x817e
// Size: 0x34
function function_e3310c6bc5f0cc52( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_la_fang_orange" ], is_maxed );
}

// Namespace zm
// Params 1
// Checksum 0x2fccf254, Offset: 0x81ba
// Size: 0x47
function function_6977b98ba2ebeed9( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_pi_timir_orange" ], is_maxed, [ "sat_bar_highcal_pi_timir", "sat_stock_akimbo_pi_timir" ] );
}

// Namespace zm
// Params 1
// Checksum 0x957ff9fd, Offset: 0x8209
// Size: 0x7d
function function_ac3d92a4bc86ac2d( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_t10_item_weapon_ar_p06_asvalor_orange" ], is_maxed, [ "t10_microreflex01_ar", "t10_ub_gl_smoke_ar_asvalor", "t10_stocks_mixstock2_ar_asvalor", "t10_bar_ar_p06", "t10_mags_extclip3_ar_asvalor", "t10_grips_quickdraw_ar_asvalor", "t10_lasers_strelok_ar_asvalor", "t10_firemod_boltcarrier_ar_asvalor" ] );
}

// Namespace zm
// Params 1
// Checksum 0x1b6ff8f8, Offset: 0x828e
// Size: 0x7d
function function_53cd25a30a3920a( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_ar_vulture_orange" ], is_maxed, [ "sat_microreflex01_ar", "sat_muzzle_mono_suppressor_ar_vulture", "sat_bar_range_ar_vulture", "sat_grip_quickdraw_ar_vulture", "sat_mag_extmag2_ar_vulture", "sat_stock_hipfiremove_ar_vulture", "sat_underbarrel_recoil_ar_vulture", "sat_firemod_springs_ar_vulture" ] );
}

// Namespace zm
// Params 1
// Checksum 0xdd980fac, Offset: 0x8313
// Size: 0x7d
function function_42d384ca3c76eee3( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_ar_heron_orange" ], is_maxed, [ "sat_microreflex01_ar", "sat_muzzle_mono_suppressor_ar_heron", "sat_bar_range_ar_heron", "sat_grip_quickdraw_ar_heron", "sat_mag_extmag2_ar_heron", "sat_laser_strelok_ar_heron", "sat_underbarrel_recoil_ar_heron", "sat_firemod_springs_ar_heron" ] );
}

// Namespace zm
// Params 1
// Checksum 0x572f47de, Offset: 0x8398
// Size: 0x47
function function_13013f80cf2fb2f9( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_sl_crossbow_orange" ], is_maxed, [ "sat_mag_tribolt_sl_crossbow", "sat_ammo_crossbow_bolt_explode" ] );
}

// Namespace zm
// Params 1
// Checksum 0xcf2952ed, Offset: 0x83e7
// Size: 0x3e
function function_ac57ca8aaf8e8179( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_lm_hades_orange" ], is_maxed, [ "sat_mag_extmag2_lm_hades" ] );
}

// Namespace zm
// Params 1
// Checksum 0x122efebd, Offset: 0x842d
// Size: 0x3e
function function_8bcaae76cd9d0ca5( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_lm_zeus_orange" ], is_maxed, [ "sat_stock_akimbo_lm_zeus" ] );
}

// Namespace zm
// Params 1
// Checksum 0x570018c0, Offset: 0x8473
// Size: 0x74
function function_38963ca6e38777be( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_sh_corso_orange" ], is_maxed, [ "sat_microreflex01_sh", "sat_bar_range_sh_corso", "sat_laser_focuslaser_sh_corso", "sat_firemod_pump_sh_corso", "sat_muzzle_suppressor_sh_corso", "sat_stock_movespeed_sh_corso", "sat_underbarrel_mixunder_sh_corso" ] );
}

// Namespace zm
// Params 1
// Checksum 0x3e44eed, Offset: 0x84ef
// Size: 0x47
function function_f1fa974d7683ac26( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_sn_baltic_orange" ], is_maxed, [ "sat_ub_crossbar_sn_baltic", "sat_ironsights_sn_baltic_minigun" ] );
}

// Namespace zm
// Params 1
// Checksum 0x8afeb538, Offset: 0x853e
// Size: 0x62
function function_84a58c1f69437814( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_pi_atlas_orange" ], is_maxed, [ "sat_mag_extmag2_pi_atlas", "sat_bar_range_pi_atlas", "sat_stock_akimbo_pi_atlas", "sat_firemod_springs_pi_atlas", "sat_muzzle_suppressor_pi_atlas" ] );
}

// Namespace zm
// Params 1
// Checksum 0x4ddb6b7e, Offset: 0x85a8
// Size: 0x7d
function function_a0f3dbdf8009cf91( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_dm_kara_orange" ], is_maxed, [ "sat_mag_extmag_dm_kara", "sat_microreflex03_dmr", "sat_muzzle_suppressor_dm_kara", "sat_bar_highcal_dm_kara", "sat_stock_adsmove_dm_kara", "sat_firemod_boltcarrier_dm_kara", "sat_laser_focuslaser_dm_kara", "sat_underbarrel_mixunder_dm_kara" ] );
}

// Namespace zm
// Params 1
// Checksum 0x5cb4d422, Offset: 0x862d
// Size: 0x7d
function function_48270aa76a6c671f( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_t10_item_weapon_ar_p47_gilroy_orange" ], is_maxed, [ "t10_muzzles_suppressor_ar_gilroy", "t10_bar_highcal_ar_gilroy", "t10_underbarrel_gl_dc_ar_gilroy", "t10_mags_10rd_ar_gilroy", "t10_grips_mixgrip_ar_gilroy", "t10_stocks_adsmove_ar_gilroy", "t10_lasers_hipaccuracy_ar_gilroy", "t10_firemod_springs_ar_gilroy" ] );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xef4abb66, Offset: 0x86b2
// Size: 0xa4
function private function_76df503bca498ac5( params )
{
    is_maxed = params[ 0 ] != "0";
    is_shotgun = params[ 1 ] != "0";
    
    if ( is_shotgun )
    {
        function_73e9d8333305c222( [ "zm_t10_item_weapon_sn_p09_droger_orange" ], is_maxed, [ "t10_firemod_trigger_sn_droger", "t10_mags_extclip2_sn_droger" ] );
        return;
    }
    
    function_73e9d8333305c222( [ "zm_t10_item_weapon_sn_p08_ultiger_orange" ], is_maxed, [ "t10_mags_extclip2_sn_ultiger", "t10_bar_highcal_sn_ultiger", "t10_stocks_hipfiremove_sn_ultiger", "t10_lasers_mixlaser_sn_ultiger", "t10_firemod_bolt_sn_ultiger" ] );
}

// Namespace zm
// Params 1
// Checksum 0xdc793a4, Offset: 0x875e
// Size: 0x50
function function_53b7f32d9beb3c88( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_pi_alcor_orange" ], is_maxed, [ "sat_laser_hipaccuracy_pi_alcor", "sat_mag_extmag2_pi_alcor", "sat_stock_akimbo_pi_alcor" ] );
}

// Namespace zm
// Params 1
// Checksum 0xc6fc3161, Offset: 0x87b6
// Size: 0x50
function function_45dc39b49054520b( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_t10_item_weapon_pi_p13_usugar9_orange" ], is_maxed, [ "t10_akimbo_usugar9", "t10_mags_extclip2_pi_usugar45", "t10_firemod_trigger_pi_usugar45" ] );
}

// Namespace zm
// Params 1
// Checksum 0x2f116e1c, Offset: 0x880e
// Size: 0x62
function function_cafca0d7f0551fef( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_t10_item_weapon_pi_p14_stiger_orange" ], is_maxed, [ "t10_akimbo_stiger", "t10_mags_extclip3_pi_stiger", "t10_muzzles_suppressor_pi_stiger", "t10_bar_range_pi_stiger", "t10_lasers_hipaccuracy_pi_stiger" ] );
}

// Namespace zm
// Params 1
// Checksum 0xed7b6159, Offset: 0x8878
// Size: 0x50
function function_9f76eeda3e5677e3( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_t10_item_weapon_pi_p12_paris30_orange" ], is_maxed, [ "t10_akimbo_paris30", "t10_mag_burst_pi_paris30", "t10_selectburst_pi_paris30" ] );
}

// Namespace zm
// Params 1
// Checksum 0x2df911eb, Offset: 0x88d0
// Size: 0x34
function function_7f922b3445957602( params )
{
    is_maxed = params[ 0 ] != "0";
    function_73e9d8333305c222( [ "zm_sat_item_weapon_ww_firefly" ], is_maxed );
}

// Namespace zm
// Params 3
// Checksum 0xbe6e842f, Offset: 0x890c
// Size: 0x234
function function_73e9d8333305c222( var_f5014f8d49ac38, is_maxed = 1, attachments )
{
    weaponslist = var_f5014f8d49ac38;
    var_c052fa2749fb7aae = utility::array_random( weaponslist );
    
    if ( !is_maxed )
    {
        var_c052fa2749fb7aae = utility::string_replace( var_c052fa2749fb7aae, "_orange", "" );
    }
    else if ( !issubstr( var_c052fa2749fb7aae, "_orange" ) )
    {
        var_c052fa2749fb7aae += "_orange";
    }
    
    var_35a0d33d42f16f6d = getscriptbundle( "itemspawnentry:" + var_c052fa2749fb7aae );
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    weaponobj = item_weapon::function_477bf1207c6672a5( var_35a0d33d42f16f6d );
    spawnoptions.weapon = weaponobj;
    
    if ( isdefined( attachments ) )
    {
        foreach ( attachment in attachments )
        {
            new_weapon = weapons::addattachmenttoweapon( spawnoptions.weapon, attachment );
            
            if ( isdefined( new_weapon ) )
            {
                spawnoptions.weapon = new_weapon;
            }
        }
    }
    
    weaponitem = common_item::function_61c2c0251e742ffd( var_35a0d33d42f16f6d, undefined, spawnoptions );
    
    if ( is_maxed )
    {
        weaponitem.var_951c89546ec50477 = 3;
        ammomodlist = [ "brainrot", "deadwire", "napalmburst", "cryofreeze", "shadowvortex", "shatterblast", "lightray" ];
        ammomodname = utility::array_random( ammomodlist );
        var_ace202d0c6b9306a = 0;
        
        while ( !isdefined( level.ammo_mods[ ammomodname ] ) )
        {
            ammomodname = utility::array_random( ammomodlist );
            var_ace202d0c6b9306a++;
            
            if ( var_ace202d0c6b9306a > 10 )
            {
                ammomodname = undefined;
            }
        }
        
        weaponitem.ammomod_name = ammomodname;
    }
    
    common_item::function_2b5e2ff57d5f392( weaponitem );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xa8002c06, Offset: 0x8b48
// Size: 0x1bb
function private function_2d3253c1e36508ff( params )
{
    player = undefined;
    
    if ( isdefined( params ) )
    {
        player = function_a8d27574578f1f31( params[ 0 ] );
        
        foreach ( param in params )
        {
            param_delimited = strtok( param, ":" );
            
            if ( isstartstr( param, "player:" ) )
            {
                player = function_a8d27574578f1f31( param_delimited[ 1 ] );
            }
        }
    }
    
    if ( !isdefined( player ) )
    {
        level.zm_infinite_self_revives = !level.zm_infinite_self_revives;
        
        foreach ( player in level.players )
        {
            if ( level.zm_infinite_self_revives )
            {
                iprintlnbold( "Giving infinite self revives to all players" );
                player laststand::function_39844c1e879cc048( 9999 );
                continue;
            }
            
            iprintlnbold( "Removing self revives from all players" );
            player laststand::function_39844c1e879cc048( 0 );
        }
        
        return;
    }
    
    player.zm_infinite_self_revives = !player.zm_infinite_self_revives;
    
    if ( player.zm_infinite_self_revives )
    {
        player laststand::function_39844c1e879cc048( 9999 );
        return;
    }
    
    player laststand::function_39844c1e879cc048( 0 );
}

// Namespace zm
// Params 2, eflags: 0x4
// Checksum 0xadf5682a, Offset: 0x8d0b
// Size: 0x22d
function private function_7e41c227f323cc59( timeoutendnotify, clearnotify )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    spawn_point = undefined;
    valid_teammates = [];
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.cached_zone_info ) )
    {
        zone_manager::function_ce45b62d4566c1e4( self.cached_zone_info.zone_struct, self, 0 );
    }
    
    if ( self isvehicleactive() && isdefined( self.vehicle ) && self.vehicle vehicle::is_boat() )
    {
        self leavevehicle( 0 );
        
        while ( isdefined( self.vehicle ) )
        {
            waitframe();
        }
    }
    
    if ( isdefined( level.override_player_spawn_point ) )
    {
        profilestart();
        spawnpoint = level [[ level.override_player_spawn_point ]]( self );
        profilestop();
    }
    else
    {
        spawnpoint = namespace_af5a2e4a7277c1d::function_4edc86bda6052f6e();
    }
    
    if ( !isdefined( spawnpoint ) )
    {
        if ( isdefined( self.var_c713f483656fb3dd ) )
        {
            var_8a87eb49936b3ae2 = self.var_c713f483656fb3dd.var_6f9c4e415e80942f;
            spawnpoint = namespace_af5a2e4a7277c1d::function_c107082b3aabba7d( var_8a87eb49936b3ae2 );
        }
    }
    
    if ( !isdefined( spawnpoint ) )
    {
        spawnpoint = self [[ level.getspawnpoint ]]();
    }
    
    assert( isdefined( spawnpoint ), "<dev string:x436>" + self.name );
    
    if ( isdefined( spawnpoint ) )
    {
        should_teleport = self.ismutantinjection || self.mutantinjectiontransformed ? 0 : 1;
        game_utility::fadetoblackforplayerkeepui( self, 1, 0.25 );
        
        if ( !player::isinlaststand( self ) )
        {
            self dodamage( self.health + 100, self.origin, self );
            waitframe();
        }
        
        if ( isalive( self ) && !self isspectatingplayer() )
        {
            self setvelocity( ( 0, 0, 0 ) );
            self setorigin( spawnpoint.origin, should_teleport );
            self setplayerangles( spawnpoint.angles );
            waitframe();
            playfx( level._effect[ "oob_teleport_splash" ], self.origin );
        }
        
        level thread game_utility::fadetoblackforplayerkeepui( self, 0, 0.25 );
    }
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0x89d53a60, Offset: 0x8f40
// Size: 0xab
function private function_c7b8ae0344379472()
{
    level endon( #"game_ended" );
    utility::flag_wait( "begin_round_logic" );
    
    foreach ( doorbuy in level.a_s_doorbuys )
    {
        if ( isdefined( doorbuy.interact ) )
        {
            doorbuy.interact interaction::function_e4a4753e6eac02d7();
        }
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xb19ee54a, Offset: 0x8ff3
// Size: 0x8a
function private function_1c370c8f9963bfe2( params )
{
    all_ai = getaiarray();
    
    foreach ( ai in all_ai )
    {
        ai kill();
    }
}

// Namespace zm
// Params 0, eflags: 0x4
// Checksum 0xc4f7ae76, Offset: 0x9085
// Size: 0x39
function private function_309ae33b63d236f3()
{
    level endon( #"game_ended" );
    utility::flag_wait_any( "loot_roulette_initialized", "loot_roulette_disabled" );
    
    if ( utility::flag( "loot_roulette_initialized" ) )
    {
        loot_roulette::function_4f3a09596afa4f87( &function_6682f1ce8afec332 );
    }
}

// Namespace zm
// Params 6, eflags: 0x4
// Checksum 0x7259310, Offset: 0x90c6
// Size: 0xa3
function private function_6682f1ce8afec332( subclass, position, angles, var_e22515fa4eb37b17, aidrop_disabled, index )
{
    if ( isdefined( subclass ) )
    {
        subclass = getscriptbundle( subclass );
        var_6c190092cbb9bb14 = { #drop_disabled:aidrop_disabled, #var_82fb01db4c58032:angles, #spawn_pos:position, #zombie_type:subclass.name };
        zm_utility::function_5f46b6e741572ed0( var_e22515fa4eb37b17, [ "normal" ], &function_7aaf7eeff3c77f6a, var_6c190092cbb9bb14 );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x47b37d98, Offset: 0x9171
// Size: 0xae
function private function_7aaf7eeff3c77f6a( sparams )
{
    zombie = agent_manager::spawn_agent( sparams.zombie_type, sparams.spawn_pos, sparams.var_82fb01db4c58032, "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie agent_spawner::function_ce10e453e7f7bb8e( sparams.spawner );
        zombie.no_powerups = 1;
        
        if ( sparams.drop_disabled )
        {
            zombie.var_a13bed1ac47e1b2c = 1;
        }
        
        zombie val::group_set( "roulette_ai_spawn", 0 );
        wait 0.25;
        zombie val::group_reset( "roulette_ai_spawn" );
        return zombie;
    }
}

// Namespace zm
// Params 0
// Checksum 0x4a848cde, Offset: 0x9227
// Size: 0x46
function function_f3ae3c143cc88a3a()
{
    function_f1a8355f3b3f3da( "samtrial", "script_noteworthy" );
    function_f1a8355f3b3f3da( "samtrial_killzone", "script_noteworthy" );
    function_f1a8355f3b3f3da( "samtrial_holdzone", "script_noteworthy" );
    function_f1a8355f3b3f3da( "samtrial_holdzone_and_killzone", "script_noteworthy" );
}

// Namespace zm
// Params 2
// Checksum 0xea72c069, Offset: 0x9275
// Size: 0x11a
function function_f1a8355f3b3f3da( name, type )
{
    var_62638af37653ded7 = utility::getstructarray( name, type );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        a_cols = function_e5fd24c8ee2b91cb( destination.script_location );
        
        foreach ( col in a_cols )
        {
            col notsolid();
        }
    }
}

// Namespace zm
// Params 1
// Checksum 0x92bd0e24, Offset: 0x9397
// Size: 0xbc
function function_e5fd24c8ee2b91cb( script_loc )
{
    a_cols = [];
    var_609b50508c1ded90 = getentarray( "trial_col", #targetname );
    
    if ( isdefined( var_609b50508c1ded90 ) )
    {
        foreach ( trial_col in var_609b50508c1ded90 )
        {
            if ( trial_col.script_location == script_loc )
            {
                a_cols[ a_cols.size ] = trial_col;
            }
        }
    }
    
    return a_cols;
}

// Namespace zm
// Params 1
// Checksum 0xe098a6ad, Offset: 0x945c
// Size: 0x9b
function gettracecontents( contentsfor = "default" )
{
    switch ( contentsfor )
    {
        case #"toma_strike":
            return [ "physicscontents_water", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy" ];
        case #"hash_7038dec66d8275be":
        default:
            return [ "physicscontents_water", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle" ];
    }
}

// Namespace zm
// Params 0, eflags: 0xc
// Checksum 0x5c2e4b50, Offset: 0x94ff
// Size: 0xcd
function private function_8c7cf78fb5a864f8()
{
    self notify( #"hash_360683a4c87be6eb" );
    self endon( #"hash_360683a4c87be6eb" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"reload_ammo_added" );
        weapons = self getweaponslistprimaries();
        
        foreach ( weapon in weapons )
        {
            self setweaponammostock( weapon, weaponmaxammo( weapon ) );
        }
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x2cb2c9be, Offset: 0x95d4
// Size: 0xc5
function private function_ade6654fd796e429( params )
{
    activator = params.activator;
    trap_name = params.trap_name;
    splash_name = "splash_" + trap_name;
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( splash_name, undefined, activator );
    }
}

// Namespace zm
// Params 2, eflags: 0x4
// Checksum 0x9197b3f5, Offset: 0x96a1
// Size: 0xac
function private function_d8f1ec0f93a731df( weapon, teammate )
{
    if ( self.team != teammate.team )
    {
        return;
    }
    
    can_affect = 1;
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
    {
        can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, teammate );
    }
    
    if ( !can_affect )
    {
        return;
    }
    
    if ( weapon.var_727203abf46db6d1 && !player::isinlaststand( self ) )
    {
        if ( player::isinlaststand( teammate ) )
        {
            thread function_988ffebc67841664( teammate );
        }
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x525fd071, Offset: 0x9755
// Size: 0xa1
function private function_988ffebc67841664( teammate )
{
    level endon( #"game_ended" );
    val::set( "WEAPON_REVIVE_TAMMATE_FLAG_ZM", "toggle_remote_revive", 1 );
    
    if ( !teammate.beingrevived && teammate.laststandreviveent )
    {
        teammate.beingremoterevived = 1;
        reviveent = teammate.laststandreviveent;
        reviveent notify( #"trigger", self );
    }
    
    teammate utility::waittill_notify_or_timeout( "laststand_revived", 10 );
    
    if ( self )
    {
        val::reset( "WEAPON_REVIVE_TAMMATE_FLAG_ZM", "toggle_remote_revive" );
    }
}

// Namespace zm
// Params 1
// Checksum 0x821959c2, Offset: 0x97fe
// Size: 0x77
function pre_spawn_intermission( spawnpoint )
{
    self endon( #"disconnect" );
    self function_eceef703be8d89c3( spawnpoint.origin );
    
    if ( self getclientomnvar( "ui_br_squad_eliminated_active" ) == 0 )
    {
        b_faded = 1;
        utility::fadetoblackforplayer( self, 1, 0, 1, 1, "fadeToBlackIntermission" );
    }
    
    wait 1;
    
    if ( b_faded )
    {
        level thread utility::fadetoblackforplayer( self, 0, 1, 1, 1, "fadeToBlackIntermission" );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xd7ca377c, Offset: 0x987d
// Size: 0x1d, Type: bool
function private is_tertiary_weapon_override( weapon )
{
    return weapon.basename == "sat_me_ballisticknife_mp";
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x61ff83e2, Offset: 0x98a3
// Size: 0x47
function private on_weapon_change( params )
{
    var_7068c97ad157148 = weapon::getweaponrootname( params.weapon );
    
    if ( var_7068c97ad157148 == "sat_me_nashira" || var_7068c97ad157148 == "sat_me_elnath" )
    {
        thread function_abbbf012be970db8();
    }
}

// Namespace zm
// Params 0, eflags: 0xc
// Checksum 0xdae471ea, Offset: 0x98f2
// Size: 0xaf
function private function_abbbf012be970db8()
{
    self notify( #"hash_a5a1cf96a261962b" );
    self endon( #"hash_a5a1cf96a261962b" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.var_fd68d41f12eb9022 = undefined;
    
    while ( true )
    {
        result = utility::waittill_any_return( "heavy_melee_in", "weapon_change" );
        
        if ( result == "weapon_change" )
        {
            return;
        }
        
        self.var_fd68d41f12eb9022 = 1;
        result = utility::waittill_any_return( "heavy_melee_start", "melee_fired", "weapon_change", "mantle_start", "offhand_end" );
        self.var_fd68d41f12eb9022 = undefined;
        
        if ( result == "weapon_change" )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xffd2002d, Offset: 0x99a9
// Size: 0x1b
function private on_start_game_end( params )
{
    setdvar( @"hash_330e06df155c6425", 0 );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x683c40c4, Offset: 0x99cc
// Size: 0x30
function private pre_gesture_weapon_fired( params )
{
    val::set( "zm_gestures", "interactions", 0 );
    val::set( "zm_gestures", "weapon_pickup", 0 );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xef5d82ef, Offset: 0x9a04
// Size: 0x2c
function private on_gesture_weapon_fired( params )
{
    gesture = params.gesture;
    thread gesture_blocking( gesture );
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0xb6c8dc40, Offset: 0x9a38
// Size: 0x36
function private on_gesture_weapon_fire_failed( params )
{
    if ( isplayer( self ) )
    {
        val::reset( "zm_gestures", "interactions" );
        val::reset( "zm_gestures", "weapon_pickup" );
    }
}

// Namespace zm
// Params 1, eflags: 0x4
// Checksum 0x72d2df59, Offset: 0x9a76
// Size: 0x4b
function private gesture_blocking( gesture )
{
    while ( isplayer( self ) && self function_a6d700f2335edc93() )
    {
        waitframe();
    }
    
    if ( isplayer( self ) )
    {
        val::reset( "zm_gestures", "interactions" );
        val::reset( "zm_gestures", "weapon_pickup" );
    }
}

