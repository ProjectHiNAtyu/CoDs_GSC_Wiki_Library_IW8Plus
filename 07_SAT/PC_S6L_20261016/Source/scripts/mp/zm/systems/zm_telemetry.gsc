// scripts\mp\zm\systems\zm_telemetry.gsc  (hash_29829d299dc85d8c.gscc) (size: 123291 Bytes / 0x1e19b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcf52fbd2 (3478322130)
// size ...... 123291 (0x1e19b)
// includes .. 33  (offset: 0x1ac73)
// strings ... 645 (offset: 0x1ad7b)
// dev strs .. 81  (offset: 0x1dd77)
// exports ... 188 (offset: 0x15ab3)
// cseg ...... 0x3638 + 0x1247b (0x15ab3)
// imports ... 368 (offset: 0x17813)
// animtree1 . 0   (offset: 0x1e19b)
// animtree2 . 0   (offset: 0x1e19b)
#using script_16ea1b94f0f381b3;
#using script_7cab86232cdd30ba;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\progression_utility;
#using scripts\common\script;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\telemetry;
#using scripts\common\telemetry_utils;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vortex;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\augments\zombie_augments;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\matchdata;
#using scripts\mp\telemetry_mp;
#using scripts\mp\zm\points;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_telemetry;

// Namespace zm_telemetry
// Params 0, eflags: 0x5
// Checksum 0x9191b452, Offset: 0x3656
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_telemetry", undefined, &init, undefined );
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0x89ef301d, Offset: 0x3677
// Size: 0x638
function private init()
{
    telemetry_utils::function_5995f9c2ef729dbd( "callback_match_start", &on_match_start );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_first_connect", &on_player_connect );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_disconnect", &on_player_disconnect );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_spawned", &on_player_spawned );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_update_weapon_stats", &update_weapon_stats );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_operator_vo", &function_5b217bffe8d1fa92 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_player_score_event", &function_9c6fe018641ab71 );
    callback::add( "on_round_end", &on_round_end );
    callback::add( "on_round_start", &on_round_start );
    callback::add( "on_gobblegum_used", &function_766c4069ad4a29c7 );
    callback::add( "on_gobblegum_consumed", &function_c18475e82ab32c64 );
    callback::add( "on_gobblegum_purchased", &function_6ccba15d54db4f13 );
    callback::add( "gobble_gum_on_round_end", &gobble_gum_on_round_end );
    callback::add( "gobblegum_changed", &gobble_gum_changed );
    callback::add( "zm_perk_purchased", &on_perk_purchased );
    callback::add( "zm_perk_obtained", &on_give_perk );
    callback::add( "zm_perk_lost", &function_de55ca564792d31f );
    callback::add( "perk_stats_track", &perk_stats_track );
    callback::add( "zm_perk_elemental_pop_proc", &perk_elemental_pop_proc );
    callback::add( "ammomod_proc", &on_ammomod_proc );
    callback::add( "ammo_mod_equipped", &function_3f5e17f12740964a );
    callback::add( "ammo_mod_removed", &function_4561441f2d1cb2a5 );
    callback::add( #"player_weapon_change", &ammo_mod_on_weapon_change );
    callback::add( "ammomod_stats_track", &ammomod_stats_track );
    callback::add( "napalmburst_proc", &on_napalmburst_proc );
    callback::add( "on_enemy_cryofreeze", &on_enemy_cryofreeze );
    callback::add( "deadwire_stunned", &on_deadwire_stunned );
    callback::add( "shadowvortex_kill", &on_shadowvortex_kill );
    callback::add( "shatterblast_explosion", &on_shatterblast_explosion );
    callback::add( "on_turned", &on_brainrotted );
    callback::add( "lightray_healing", &on_lightray_healing );
    callback::add( "field_upgrade_used", &on_field_upgrade_used );
    callback::add( "field_upgrade_ended", &on_field_upgrade_ended );
    callback::add( "on_field_upgrade_kill_track", &field_upgrade_stats_track );
    callback::add( "field_upgrade_stats_track", &field_upgrade_stats_track );
    callback::add( "energy_mine_subtype_landed", &energy_mine_subtype_landed );
    callback::add( "energy_mine_delay_ended", &on_energy_mine_delay_ended );
    callback::add( "energy_mine_carousel_ended", &energy_mine_carousel_ended );
    callback::add( "energy_mine_scatter_started", &energy_mine_scatter_started );
    callback::add( "on_crafting_item_success", &on_crafting_item_success );
    callback::add( "arsenal_craft_weapon_tier", &on_weapon_upgrade );
    callback::add( "arsenal_craft_ammo_mod", &on_weapon_upgrade );
    callback::add( "on_pap_machine_purchase", &on_weapon_upgrade );
    callback::add( "wallbuy_armor_purchased", &on_armor_upgrade );
    callback::add( "wallbuy_purchase", &on_wallbuy_purchase );
    callback::add( #"player_item_pickup", &on_item_pickup );
    callback::add( "player_match_end", &on_player_match_end );
    callback::add( "zm_exfil_success", &on_player_exfil_success );
    callback::add( "zm_exfil_started", &on_exfil_started );
    callback::add( #"on_ai_killed", &function_7e4e1c6c39fc475d );
    callback::add( "on_zombie_ai_damaged", &function_b5178a27f638123b );
    callback::add( #"zm_mq_quest_complete", &on_main_quest_complete );
    callback::add( "zm_mq_final_fight_start", &zm_mq_final_fight_start );
    callback::add( "doorbuy_contributed", &on_doorbuy_contributed );
    callback::add( "doorbuy_bought", &on_doorbuy_bought );
    callback::add( "magicbox_purchase", &on_magicbox_purchase );
    callback::add( "zm_packed_weapon", &on_pack_a_punch_weapon );
    callback::add( "purchase_trap", &on_trap_purchase );
    callback::add( #"hash_476fcd5501956e2c", &function_7dab4f86803b3e25 );
    callback::add( "on_agent_spawned", &on_agent_spawned );
    callback::add( "agent_fake_defeat_health", &agent_fake_defeat_health );
    callback::add( #"player_damaged", &on_player_damaged );
    callback::add( #"player_laststand_revived", &function_b0f8cce4da821455 );
    callback::add( "gobblegum_selected_pack_changed", &on_gobblegum_selected_pack_changed );
    callback::add( "on_rapid_kill_counted", &function_66e4331d67455370 );
    callback::add( "on_rapid_kill_end", &function_b5108f2aac060a9f );
    callback::add( #"player_laststand", &function_b1a70274e9508a18 );
    callback::add( #"killstreak_begin_use", &function_21396bf10feb0abc );
    callback::add( "on_player_augment_given", &function_f7a043c6404dcadb );
    callback::add( #"player_death", &on_player_death );
    callback::add( "currency_add", &on_player_currency_add );
    callback::add( "currency_sub", &on_player_currency_sub );
    callback::add( #"hash_5d197f6c9b862419", &function_359b8f55dd2e8186 );
    callback::add( #"zm_mq_step_complete", &zm_mq_step_complete );
    callback::add( #"hash_8d01d5b76b0739a3", &function_9a0dd10580b95432 );
    callback::add( #"hash_2aa5b4d8cc07dff0", &function_3f7664e7bf3c0c45 );
    callback::add( "samtrial_used", &function_37cf06ba687c5dbe );
    callback::add( "sam_trial_end", &function_49030e451e16fb37 );
    callback::add( "teddtask_used", &function_37cf06ba687c5dbe );
    callback::add( "tedd_task_end", &function_49030e451e16fb37 );
    callback::add( #"player_powerup", &on_player_powerup );
    callback::add( #"grenade_fire", &on_grenade_fire );
    callback::add( #"vehicle_spawn", &function_a35bac0965cd088e );
    callback::add( "on_essence_gained", &on_essence_gained );
    callback::add( #"hash_15f7f10acc723bdf", &function_f31dcfe65053dc25 );
    callback::add( #"hash_e0046e014f9385eb", &function_f8823b43af695910 );
    setdvarifuninitialized( @"hash_817f686503ccdecf", 5 );
    setdvarifuninitialized( @"hash_e742008972155619", 1 );
    level.zm_ai_stats_event_throttle = throttle::throttle_initialize( "zm_ai_stats_event_throttle" );
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0x5b6fa752, Offset: 0x3cb7
// Size: 0x15b
function private zm_telemetry_info_struct()
{
    game_type = game_utility::getgametype();
    game_type = function_a203d120e5593df5( game_type );
    map_name = game_utility::getmapname();
    playlist_id = 0;
    playlist_name = "";
    
    if ( game_utility_mp::matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    if ( isdefined( level.zm_get_round_number_override ) )
    {
        round_number = [[ level.zm_get_round_number_override ]]();
    }
    else
    {
        round_number = level.var_6781718da4f78d1c.roundnumber ?? 0;
    }
    
    time = matchdata::gettimefrommatchstart( gettime() );
    time = int( clamp( time, 0, 2147483647 ) );
    is_ranked = 0;
    
    if ( level.leagueplaymatch || level.var_309e3d9dac389de6 )
    {
        is_ranked = 1;
    }
    
    season = getdvarint( @"current_season", -1 );
    return { #season:season, #is_ranked:is_ranked, #time:time, #round_number:round_number, #playlist_name:playlist_name, #playlist_id:playlist_id, #map_name:map_name, #game_type:game_type };
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xc1ce3db5, Offset: 0x3e1b
// Size: 0x29
function private function_a203d120e5593df5( game_type )
{
    if ( getmatchrulesdata( "zmData", "useModeRulesZombieSnacks" ) )
    {
        game_type += "_snacks";
    }
    
    return game_type;
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0x30a47be6, Offset: 0x3e4d
// Size: 0x25
function private get_prestige()
{
    if ( game_utility_mp::rankingenabled() )
    {
        prestige = player_progression_achievements::getprestige();
    }
    else
    {
        prestige = 0;
    }
    
    return prestige;
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0xa64e37af, Offset: 0x3e7b
// Size: 0x31
function private on_match_start()
{
    telemetry_mp::on_match_start();
    function_348dfb9fc1e31f61();
    
    if ( isdefined( game[ "telemetry" ] ) )
    {
        game[ "telemetry" ].start_time_ms = gettime();
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xccbb967e, Offset: 0x3eb4
// Size: 0xae2
function private on_player_connect( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( isdefined( player.pers[ "telemetry" ].connected ) )
    {
        return;
    }
    
    player thread record_favorite_loadout();
    player thread watch_give_loadout();
    
    if ( !isdefined( player.pers[ "telemetry" ] ) )
    {
        player.pers[ "telemetry" ] = {};
    }
    
    telemetry = player.pers[ "telemetry" ];
    
    if ( isdefined( game[ "telemetry" ].total_player_connections ) )
    {
        telemetry.connect_index = game[ "telemetry" ].total_player_connections;
        game[ "telemetry" ].total_player_connections++;
    }
    else
    {
        println( "<dev string:x24>" );
        return;
    }
    
    if ( isdefined( game[ "telemetry" ].total_bot_count ) && isbot( player ) )
    {
        game[ "telemetry" ].total_bot_count++;
    }
    
    if ( isdefined( game[ "telemetry" ].player_ids ) && !isbot( player ) )
    {
        game[ "telemetry" ].player_ids = arraycombineunique( game[ "telemetry" ].player_ids, [ player.guid ] );
    }
    
    telemetry.utc_connect_time_s = getsystemtime();
    telemetry.connected = 1;
    
    if ( player game_utility_mp::rankingenabled() )
    {
        telemetry.prestige_at_start = player player_progression_achievements::getprestige();
    }
    else
    {
        telemetry.prestige_at_start = 0;
    }
    
    telemetry.progression_verified = 0;
    info_struct = zm_telemetry_info_struct();
    lobby_id = getlobbyid() ?? "";
    is_controller = function_ce16447ef1f1b7ff( player );
    client_ip_address_array = player getplayerip();
    client_ip_address = client_ip_address_array[ 0 ] + "." + client_ip_address_array[ 1 ] + "." + client_ip_address_array[ 2 ] + "." + client_ip_address_array[ 3 ];
    
    if ( utility::issharedfuncdefined( #"bgb", #"hash_115aa98d3b2427aa" ) && player hasplayerdata() )
    {
        var_37dc0376726efd20 = player utility::callsharedfunc( #"bgb", #"hash_115aa98d3b2427aa" );
    }
    else
    {
        var_37dc0376726efd20 = [ #"", #"", #"", #"", #"" ];
    }
    
    prestige_level = telemetry.prestige_at_start;
    
    if ( !isdefined( telemetry.reached_match_end ) )
    {
        telemetry.reached_match_end = 0;
    }
    
    if ( !isdefined( telemetry.eliminations ) )
    {
        telemetry.eliminations = 0;
    }
    
    if ( !isdefined( telemetry.kills ) )
    {
        telemetry.kills = 0;
    }
    
    if ( !isdefined( telemetry.assists ) )
    {
        telemetry.assists = 0;
    }
    
    if ( !isdefined( telemetry.normal_eliminations ) )
    {
        telemetry.normal_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.elite_eliminations ) )
    {
        telemetry.elite_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.special_eliminations ) )
    {
        telemetry.special_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.boss_eliminations ) )
    {
        telemetry.boss_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.critical_kills ) )
    {
        telemetry.critical_kills = 0;
    }
    
    if ( !isdefined( telemetry.non_critical_kills ) )
    {
        telemetry.non_critical_kills = 0;
    }
    
    if ( !isdefined( telemetry.pap_weapon_elims ) )
    {
        telemetry.pap_weapon_elims = 0;
    }
    
    if ( !isdefined( telemetry.legendary_weapon_elims ) )
    {
        telemetry.legendary_weapon_elims = 0;
    }
    
    if ( !isdefined( telemetry.one_shot_kills ) )
    {
        telemetry.one_shot_kills = 0;
    }
    
    if ( !isdefined( telemetry.base_zombie_kills ) )
    {
        telemetry.base_zombie_kills = 0;
    }
    
    if ( !isdefined( telemetry.base_zombie_eliminations ) )
    {
        telemetry.base_zombie_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.light_armor_zombie_kills ) )
    {
        telemetry.light_armor_zombie_kills = 0;
    }
    
    if ( !isdefined( telemetry.light_armor_zombie_eliminations ) )
    {
        telemetry.light_armor_zombie_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.heavy_armor_zombie_kills ) )
    {
        telemetry.heavy_armor_zombie_kills = 0;
    }
    
    if ( !isdefined( telemetry.heavy_armor_zombie_eliminations ) )
    {
        telemetry.heavy_armor_zombie_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.vermin_kills ) )
    {
        telemetry.vermin_kills = 0;
    }
    
    if ( !isdefined( telemetry.vermin_eliminations ) )
    {
        telemetry.vermin_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.abomination_kills ) )
    {
        telemetry.abomination_kills = 0;
    }
    
    if ( !isdefined( telemetry.abomination_eliminations ) )
    {
        telemetry.abomination_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.mangler_kills ) )
    {
        telemetry.mangler_kills = 0;
    }
    
    if ( !isdefined( telemetry.mangler_eliminations ) )
    {
        telemetry.mangler_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.parasite_kills ) )
    {
        telemetry.parasite_kills = 0;
    }
    
    if ( !isdefined( telemetry.parasite_eliminations ) )
    {
        telemetry.parasite_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.amalgam_kills ) )
    {
        telemetry.amalgam_kills = 0;
    }
    
    if ( !isdefined( telemetry.amalgam_eliminations ) )
    {
        telemetry.amalgam_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.ghoul_kills ) )
    {
        telemetry.ghoul_kills = 0;
    }
    
    if ( !isdefined( telemetry.ghoul_eliminations ) )
    {
        telemetry.ghoul_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.mimic_kills ) )
    {
        telemetry.mimic_kills = 0;
    }
    
    if ( !isdefined( telemetry.mimic_eliminations ) )
    {
        telemetry.mimic_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.disciple_kills ) )
    {
        telemetry.disciple_kills = 0;
    }
    
    if ( !isdefined( telemetry.disciple_eliminations ) )
    {
        telemetry.disciple_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.boss_kala_kills ) )
    {
        telemetry.boss_kala_kills = 0;
    }
    
    if ( !isdefined( telemetry.boss_kala_eliminations ) )
    {
        telemetry.boss_kala_eliminations = 0;
    }
    
    if ( !isdefined( telemetry.var_6ac2c6490dd67adc ) )
    {
        telemetry.var_6ac2c6490dd67adc = 0;
    }
    
    if ( !isdefined( telemetry.mq_completed ) )
    {
        telemetry.mq_completed = 0;
    }
    
    if ( !isdefined( telemetry.player_weapon_stats_count ) )
    {
        telemetry.player_weapon_stats_count = 0;
    }
    
    if ( !isdefined( telemetry.player_equipment_stats_count ) )
    {
        telemetry.player_equipment_stats_count = 0;
    }
    
    telemetry.join_round_number = info_struct.round_number;
    
    if ( !isdefined( telemetry.var_d6e5bf2becd1494e ) )
    {
        telemetry.var_d6e5bf2becd1494e = 0;
    }
    
    if ( !isdefined( telemetry.player_killstreak_stats_count ) )
    {
        telemetry.player_killstreak_stats_count = 0;
    }
    
    if ( !isdefined( telemetry.player_field_upgrade_stats_count ) )
    {
        telemetry.player_field_upgrade_stats_count = 0;
    }
    
    if ( !isdefined( telemetry.player_perk_stats_count ) )
    {
        telemetry.player_perk_stats_count = 0;
    }
    
    if ( !isdefined( telemetry.player_ammo_mod_stats_count ) )
    {
        telemetry.player_ammo_mod_stats_count = 0;
    }
    
    if ( !isdefined( telemetry.player_augment_stats_count ) )
    {
        telemetry.player_augment_stats_count = 0;
    }
    
    telemetry.var_efd960f3c3cf6f19 = {};
    telemetry.field_upgrade_stats = [];
    telemetry.var_a46ebf03a8e6779a = [];
    telemetry.ammomod_stats = [];
    telemetry.augment_stats = [];
    telemetry.round_start_info = [ "round_time":info_struct.time ];
    player.pers[ "weaponStats" ] = [];
    waitframe();
    telemetry.match_start_xp = player.pers[ "rankxp" ];
    telemetry.match_start_rank = player progression_utility::getrank();
    
    while ( !player.team )
    {
        waitframe();
    }
    
    telemetry.party_id = player getpartyid();
    survival_poi_hash = #"";
    
    if ( utility::issharedfuncdefined( #"zm_survival", #"get_survival_poi_name" ) )
    {
        survival_poi_name = utility::callsharedfunc( #"zm_survival", #"get_survival_poi_name" );
        survival_poi_hash = getxhash( survival_poi_name );
    }
    
    is_using_vcon = player function_837cf56ce8e59b00();
    player dlog_recordplayerevent( "dlog_event_zm_player_match_start", [ "utc_connect_time_s", telemetry.utc_connect_time_s, "map", info_struct.map_name, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "game_type", info_struct.game_type, "lobby_id", lobby_id, "is_ranked", info_struct.is_ranked, "current_season", info_struct.season, "prestige_level", prestige_level, "is_controller", is_controller, "client_ip_address", client_ip_address, "gobblegum_loadout_1", var_37dc0376726efd20[ 0 ], "gobblegum_loadout_2", var_37dc0376726efd20[ 1 ], "gobblegum_loadout_3", var_37dc0376726efd20[ 2 ], "gobblegum_loadout_4", var_37dc0376726efd20[ 3 ], "gobblegum_loadout_5", var_37dc0376726efd20[ 4 ], "join_round_number", info_struct.round_number, "team", player.team, "party_id", telemetry.party_id, "survival_poi", survival_poi_hash, "is_using_vcon", is_using_vcon ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x3dbe097b, Offset: 0x499e
// Size: 0x33
function private function_ce16447ef1f1b7ff( player )
{
    return isbot( player ) || istestclient( player ) || isai( player ) ? 0 : player usinggamepad();
}

// Namespace zm_telemetry
// Params 1
// Checksum 0xce383b63, Offset: 0x49da
// Size: 0xf4
function on_player_spawned( player )
{
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ] ) )
    {
        player.pers[ "telemetry" ] = {};
    }
    
    if ( !isdefined( game[ "telemetry" ].life_count ) )
    {
        game[ "telemetry" ].life_count = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].life ) )
    {
        player.pers[ "telemetry" ].life = {};
    }
    
    player.pers[ "telemetry" ].life.life_index = game[ "telemetry" ].life_count;
    game[ "telemetry" ].life_count++;
    player thread function_f98058533d9911cf();
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0x367ca85f, Offset: 0x4ad6
// Size: 0xc
function private function_348dfb9fc1e31f61()
{
    level.zm_gobble_gum_used = [];
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x2c140909, Offset: 0x4aea
// Size: 0x67
function private function_766c4069ad4a29c7( params )
{
    if ( !isdefined( params.name ) )
    {
        return;
    }
    
    gobble_gum = params.name;
    level.zm_gobble_gum_used[ gobble_gum ] = level.zm_gobble_gum_used[ gobble_gum ] ?? 0;
    level.zm_gobble_gum_used[ gobble_gum ]++;
    function_214f92eb5902b858( gobble_gum );
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0xd883eb5e, Offset: 0x4b59
// Size: 0x15f
function private function_41722f8aca3979cd()
{
    if ( !isdefined( level.zm_gobble_gum_used ) || !level.zm_gobble_gum_used.size )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    
    foreach ( gobble_gum, quantity in level.zm_gobble_gum_used )
    {
        gobble_gum_hash = gobble_gum;
        
        if ( !isxhash( gobble_gum ) )
        {
            gobble_gum_hash = getxhash( gobble_gum );
        }
        
        dlog_recordevent( "dlog_event_zm_gobble_gum_used_total", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "matchtime_ms", info_struct.time, "gobblegum_name_s", gobble_gum_hash, "quantity", quantity ] );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xf46a51f6, Offset: 0x4cc0
// Size: 0x107
function private function_214f92eb5902b858( gobble_gum )
{
    info_struct = zm_telemetry_info_struct();
    
    if ( !isxhash( gobble_gum ) )
    {
        gobble_gum = getxhash( gobble_gum );
    }
    
    client_uno_id = self getplayerunoid();
    dlog_recordevent( "dlog_event_zm_gobble_gum_used", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "gobblegum_name_s", gobble_gum, "quantity", 1, "client_uno_id", client_uno_id ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x99200fd7, Offset: 0x4dcf
// Size: 0x1fc
function private on_gobblegum_selected_pack_changed( params )
{
    var_ad51538d36de61f4 = params.var_ad51538d36de61f4;
    
    if ( utility::issharedfuncdefined( #"bgb", #"hash_906f42b697e67e35" ) )
    {
        var_37dc0376726efd20 = utility::callsharedfunc( #"bgb", #"hash_906f42b697e67e35", var_ad51538d36de61f4 );
    }
    else
    {
        var_37dc0376726efd20 = [ #"", #"", #"", #"", #"" ];
    }
    
    earn_timer_remaining = 2147483647;
    
    if ( utility::issharedfuncdefined( #"bgb_token", #"hash_ced75e023f3c8a20" ) )
    {
        earn_timer_remaining = utility::callsharedfunc( #"bgb_token", #"hash_ced75e023f3c8a20" );
    }
    
    info_struct = zm_telemetry_info_struct();
    self dlog_recordplayerevent( "dlog_event_zm_player_gobble_gum_loadout", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "gobblegum_loadout_1", var_37dc0376726efd20[ 0 ], "gobblegum_loadout_2", var_37dc0376726efd20[ 1 ], "gobblegum_loadout_3", var_37dc0376726efd20[ 2 ], "gobblegum_loadout_4", var_37dc0376726efd20[ 3 ], "gobblegum_loadout_5", var_37dc0376726efd20[ 4 ], "earn_timer_remaining", earn_timer_remaining ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xa87ee8f6, Offset: 0x4fd3
// Size: 0x263
function private function_c18475e82ab32c64( params )
{
    level endon( #"game_ended" );
    gobble_gum = params.name;
    
    if ( !isxhash( gobble_gum ) )
    {
        gobble_gum = getxhash( gobble_gum );
    }
    
    earn_timer_remaining = 2147483647;
    
    if ( utility::issharedfuncdefined( #"bgb_token", #"hash_ced75e023f3c8a20" ) )
    {
        earn_timer_remaining = utility::callsharedfunc( #"bgb_token", #"hash_ced75e023f3c8a20" );
    }
    
    pos = self.origin;
    
    if ( isdefined( level.zm_get_current_zone_override ) )
    {
        zone_name = [[ level.zm_get_current_zone_override ]]();
    }
    else
    {
        current_zone = zone_manager::get_current_zone();
        zone_name = current_zone.script_zone_name ?? #"";
        
        if ( !isxhash( zone_name ) )
        {
            zone_name = getxhash( zone_name );
        }
    }
    
    info_struct = zm_telemetry_info_struct();
    convert_essence_reward = 0;
    
    if ( params.var_46993e9f6a989d94 )
    {
        result = utility::waittill_any_return_params_or_timeout( 1, "player_convert_gobblegum_essence_reward", "disconnect" );
        
        if ( result[ "message" ] == "player_convert_gobblegum_essence_reward" && result[ 0 ] )
        {
            convert_essence_reward = result[ 0 ];
        }
    }
    
    self dlog_recordplayerevent( "dlog_event_zm_player_gobble_gum_consume", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "gobblegum_name_s", gobble_gum, "earn_timer_remaining", earn_timer_remaining, "pos_x", pos[ 0 ], "pos_y", pos[ 1 ], "pos_z", pos[ 2 ], "map_location_name", zone_name, "convert_essence_reward", convert_essence_reward ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x8164d587, Offset: 0x523e
// Size: 0x4c
function private on_essence_gained( params )
{
    if ( params.points > 0 && params.eventinfo.var_46993e9f6a989d94 )
    {
        self notify( #"player_convert_gobblegum_essence_reward", params.points );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x84b39c7e, Offset: 0x5292
// Size: 0x1e7
function private function_6ccba15d54db4f13( params )
{
    info_struct = zm_telemetry_info_struct();
    gobble_gum = params.name;
    
    if ( !isxhash( gobble_gum ) )
    {
        gobble_gum = getxhash( gobble_gum );
    }
    
    client_uno_id = self getplayerunoid();
    pos = self.origin;
    cost = params.cost ?? 0;
    self notify( #"temeletry_gobblegum_purchased" );
    waitframe();
    
    if ( !self )
    {
        return;
    }
    
    result = utility::waittill_any_ents_or_timeout_return( 10, self, "user_grabbed_bgb", self, "temeletry_gobblegum_purchased", self, "disconnect", level, "game_ended" );
    gumball_taken = result == "user_grabbed_bgb";
    dlog_recordevent( "dlog_event_zm_gobble_gum_purchased", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "client_uno_id", client_uno_id, "gobblegum_name_s", gobble_gum, "quantity", 1, "cost", cost, "pos_x", pos[ 0 ], "pos_y", pos[ 1 ], "pos_z", pos[ 2 ], "gumball_taken", gumball_taken ] );
}

// Namespace zm_telemetry
// Params 0
// Checksum 0x54883ba, Offset: 0x5481
// Size: 0xb
function function_a35a6fc963c6bcd5()
{
    thread function_1ca81a53e0cc5ac( 1 );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xd948a750, Offset: 0x5494
// Size: 0x16
function private gobble_gum_on_round_end( params )
{
    thread gobble_gum_round_end_summary( 0, params );
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0x743d55df, Offset: 0x54b2
// Size: 0xe4
function private gobble_gum_summary( var_6cd423f71748c668, params, var_91392d3e84e5a76f )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    earn_timer_remaining = 2147483647;
    
    if ( utility::issharedfuncdefined( #"bgb_token", #"hash_ced75e023f3c8a20" ) )
    {
        earn_timer_remaining = utility::callsharedfunc( #"bgb_token", #"hash_ced75e023f3c8a20" );
    }
    
    info_struct = zm_telemetry_info_struct();
    self.var_3c234268ba458c77 = { #earn_timer_remaining:earn_timer_remaining, #matchtime_ms:info_struct.time, #round:info_struct.round_number };
    self.var_690b889cd594025f = [];
    
    if ( level.onlinegame )
    {
        wait var_91392d3e84e5a76f;
    }
    
    update_gobble_gum_milestone_data( var_6cd423f71748c668 );
    function_dc5e9a38d8b1fd1e();
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x88b7ed81, Offset: 0x559e
// Size: 0x21
function private function_1ca81a53e0cc5ac( var_6cd423f71748c668, params )
{
    gobble_gum_summary( var_6cd423f71748c668, params, 5 );
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x31be6803, Offset: 0x55c7
// Size: 0x39
function private gobble_gum_round_end_summary( var_6cd423f71748c668, params )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    gobble_gum_summary( var_6cd423f71748c668, params, 5 );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x3fb8953b, Offset: 0x5608
// Size: 0x2c, Type: bool
function private function_6b71084f09b3fd18( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( !isdefined( player.var_3c234268ba458c77 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0xc8ea6551, Offset: 0x563d
// Size: 0x7b, Type: bool
function private function_c4a02a906105b45c( var_f3c596c023842c74, function_name )
{
    if ( var_f3c596c023842c74 >= 6 )
    {
        /#
            println( "<dev string:x8e>" + function_name + "<dev string:x9b>" + self.var_690b889cd594025f.size + "<dev string:xb6>" + 6 + "<dev string:xc8>" );
            assertmsg( "<dev string:x8e>" + function_name + "<dev string:x9b>" + self.var_690b889cd594025f.size + "<dev string:xb6>" + 6 );
        #/
        
        return true;
    }
    
    return false;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x10b54936, Offset: 0x56c1
// Size: 0x17c
function private update_gobble_gum_milestone_data( var_abc8e35a871d8870 )
{
    if ( !function_6b71084f09b3fd18( self ) )
    {
        return;
    }
    
    if ( self.var_690b889cd594025f.size > 0 )
    {
        var_6f9b00680ed002d8 = level.var_6f9b00680ed002d8;
        milestone_reached = self getplayerdata( var_6f9b00680ed002d8, "gobblegumMilestoneReached" );
        isLastGobblegumRewardMatchReward = var_abc8e35a871d8870 ?? 0;
        id = 0;
        
        foreach ( gum in self.var_690b889cd594025f )
        {
            if ( function_c4a02a906105b45c( id, "update_gobble_gum_milestone_omnvars" ) )
            {
                break;
            }
            
            self setplayerdata( var_6f9b00680ed002d8, "milestoneAcquiredGums", milestone_reached, "milestoneAcquiredGumsData", id, "lootID", gum.loot_id );
            self setplayerdata( var_6f9b00680ed002d8, "milestoneAcquiredGums", milestone_reached, "milestoneAcquiredGumsData", id, "amount", gum.count );
            id++;
        }
        
        self setplayerdata( var_6f9b00680ed002d8, "milestoneAcquiredGums", milestone_reached, "milestoneDifferentGumsAmount", self.var_690b889cd594025f.size );
        self setplayerdata( var_6f9b00680ed002d8, "gobblegumMilestoneReached", milestone_reached + 1 );
        self setplayerdata( var_6f9b00680ed002d8, "isLastGobblegumRewardMatchReward", isLastGobblegumRewardMatchReward );
    }
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0xc65cd987, Offset: 0x5845
// Size: 0x414
function private function_dc5e9a38d8b1fd1e()
{
    if ( !function_6b71084f09b3fd18( self ) )
    {
        return;
    }
    
    gobblegum_gained = [ #"", #"", #"", #"", #"", #"" ];
    gobblegum_count = [ 0, 0, 0, 0, 0, 0 ];
    gobblegum_loot_id = [ 0, 0, 0, 0, 0, 0 ];
    
    if ( self.var_690b889cd594025f.size )
    {
        id = 0;
        
        foreach ( gobblegum, gum in self.var_690b889cd594025f )
        {
            if ( function_c4a02a906105b45c( id, "gobble_gum_round_end_summary" ) )
            {
                break;
            }
            
            gobblegum_gained[ id ] = gobblegum;
            gobblegum_count[ id ] = gum.count;
            gobblegum_loot_id[ id ] = gum.loot_id;
            id++;
        }
    }
    
    self.var_690b889cd594025f = undefined;
    info_struct = zm_telemetry_info_struct();
    self dlog_recordplayerevent( "dlog_event_zm_player_gobble_gum_round_summary", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", self.var_3c234268ba458c77.round, "matchtime_ms", self.var_3c234268ba458c77.matchtime_ms, "earn_timer_remaining", self.var_3c234268ba458c77.earn_timer_remaining, "gobblegum_earned_1", gobblegum_gained[ 0 ] ?? #"", "gobblegum_earned_1_count", gobblegum_count[ 0 ] ?? 0, "gobblegum_earned_1_loot_id", gobblegum_loot_id[ 0 ] ?? 0, "gobblegum_earned_2", gobblegum_gained[ 1 ] ?? #"", "gobblegum_earned_2_count", gobblegum_count[ 1 ] ?? 0, "gobblegum_earned_2_loot_id", gobblegum_loot_id[ 1 ] ?? 0, "gobblegum_earned_3", gobblegum_gained[ 2 ] ?? #"", "gobblegum_earned_3_count", gobblegum_count[ 2 ] ?? 0, "gobblegum_earned_3_loot_id", gobblegum_loot_id[ 2 ] ?? 0, "gobblegum_earned_4", gobblegum_gained[ 3 ] ?? #"", "gobblegum_earned_4_count", gobblegum_count[ 3 ] ?? 0, "gobblegum_earned_4_loot_id", gobblegum_loot_id[ 3 ] ?? 0, "gobblegum_earned_5", gobblegum_gained[ 4 ] ?? #"", "gobblegum_earned_5_count", gobblegum_count[ 4 ] ?? 0, "gobblegum_earned_5_loot_id", gobblegum_loot_id[ 4 ] ?? 0, "gobblegum_earned_6", gobblegum_gained[ 5 ] ?? #"", "gobblegum_earned_6_count", gobblegum_count[ 5 ] ?? 0, "gobblegum_earned_6_loot_id", gobblegum_loot_id[ 5 ] ?? 0 ] );
    self.var_3c234268ba458c77 = undefined;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x20fb2437, Offset: 0x5c61
// Size: 0x461
function private gobble_gum_changed( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.gobblegum ) )
    {
        println( "<dev string:x11b>" );
        return;
    }
    
    gobble_gum = params.gobblegum;
    lootid = params.item_id ?? level.gobblegums[ gobble_gum ].lootid ?? 0;
    count = params.count ?? 1;
    source = #"gameplay";
    pos = self.origin;
    
    if ( count > 0 )
    {
        if ( isdefined( self.var_690b889cd594025f ) )
        {
            if ( !isdefined( self.var_690b889cd594025f[ gobble_gum ] ) )
            {
                self.var_690b889cd594025f[ gobble_gum ] = { #count:0, #loot_id:lootid };
            }
            
            self.var_690b889cd594025f[ gobble_gum ].count += count;
        }
    }
    
    if ( !isxhash( gobble_gum ) )
    {
        gobble_gum = getxhash( gobble_gum );
    }
    
    earn_timer_remaining = 2147483647;
    
    if ( utility::issharedfuncdefined( #"bgb_token", #"hash_ced75e023f3c8a20" ) )
    {
        earn_timer_remaining = utility::callsharedfunc( #"bgb_token", #"hash_ced75e023f3c8a20" );
    }
    
    zone_name = #"";
    
    if ( level.zone_manager )
    {
        current_zone = zone_manager::get_current_zone();
        zone_name = current_zone.script_zone_name ?? #"";
    }
    
    if ( !isxhash( zone_name ) )
    {
        zone_name = getxhash( zone_name );
    }
    
    info_struct = zm_telemetry_info_struct();
    earn_rate_multiplier = getdvarfloat( @"hash_a4bd3657b64a4479", 1 );
    
    if ( count > 0 )
    {
        self dlog_recordplayerevent( "dlog_event_zm_player_gobble_gum_gain", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "gobblegum_name_s", gobble_gum, "gobblegum_loot_id", lootid, "earn_timer_remaining", earn_timer_remaining, "source", source, "pos_x", pos[ 0 ], "pos_y", pos[ 1 ], "pos_z", pos[ 2 ], "map_location_name", zone_name, "count", count, "earn_rate_multiplier", earn_rate_multiplier ] );
    }
    
    consumed = count < 0 ? 1 : 0;
    inventory_count = params.inventory_count ?? 0;
    
    if ( consumed )
    {
        count *= -1;
    }
    
    self dlog_recordplayerevent( "zm_gobble_gum_player_inventory_snapshot", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "gobblegum_name", gobble_gum, "consumed", consumed, "count", count, "inventory_count", inventory_count ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x87c8231b, Offset: 0x60ca
// Size: 0x208
function private on_crafting_item_success( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.item.itemref ) )
    {
        println( "<dev string:x15d>" );
        return;
    }
    
    item_ref = params.item.itemref;
    
    if ( !isxhash( item_ref ) )
    {
        item_ref = getxhash( item_ref );
    }
    
    info_struct = zm_telemetry_info_struct();
    client_uno_id = self getplayerunoid();
    cost = params.item.cost ?? 0;
    currency = function_5500181132dcbc51( params.item.currency );
    dlog_recordevent( "dlog_event_zm_crafting_item", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "crafting_item_s", item_ref, "quantity", 1, "client_uno_id", client_uno_id, "purchase_cost", cost, "currency", currency, "pos_x", self.origin[ 0 ], "pos_y", self.origin[ 1 ], "pos_z", self.origin[ 2 ] ] );
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0x9453479d, Offset: 0x62da
// Size: 0x211
function private update_highest_round()
{
    round_number = level.var_6781718da4f78d1c.roundnumber ?? 0;
    
    if ( level.var_f7889be36863fb43 == round_number )
    {
        return;
    }
    
    level.var_f7889be36863fb43 = round_number;
    map_name = game_utility::getmapname();
    map_name_xhash = getxhashasset( map_name );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player game_utility_mp::rankingenabled() || !player hasplayerdata() )
        {
            println( "<dev string:x19e>" );
            continue;
        }
        
        if ( player is_join_later_rounds() )
        {
            println( "<dev string:x1d0>" + player.name + "<dev string:x1da>" );
            continue;
        }
        
        map_highest_round = int( player getplayerdata( level.var_6f9b00680ed002d8, "mapsHighestRound", map_name_xhash ) ?? 0 );
        
        if ( round_number > map_highest_round )
        {
            println( "<dev string:x221>" + player.name + "<dev string:x239>" + map_highest_round + "<dev string:x25a>" + round_number );
            player setplayerdata( level.var_6f9b00680ed002d8, "mapsHighestRound", map_name_xhash, round_number );
            map_highest_round = round_number;
        }
        
        var_b4f557ec285dc5f1 = int( player getplayerdata( level.var_6f9b00680ed002d8, "highestRound" ) ?? 0 );
        
        if ( map_highest_round > var_b4f557ec285dc5f1 )
        {
            println( "<dev string:x221>" + player.name + "<dev string:x25f>" + var_b4f557ec285dc5f1 + "<dev string:x25a>" + round_number );
            player setplayerdata( level.var_6f9b00680ed002d8, "highestRound", map_highest_round );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x8a39f06c, Offset: 0x64f3
// Size: 0x2aa
function private zm_match_end( endreason )
{
    function_cd15bd922e271ec6( endreason );
    record_boss_fight( undefined, undefined, endreason );
    info_struct = zm_telemetry_info_struct();
    is_ranked = 0;
    
    if ( level.leagueplaymatch || level.var_309e3d9dac389de6 )
    {
        is_ranked = 1;
    }
    
    utc_start_time_s = game[ "telemetry" ].utc_start_time_s ?? 0;
    utc_end_time_s = getsystemtime();
    total_player_connections = game[ "telemetry" ].total_player_connections ?? 0;
    is_save_reload = level.zm_save_info.var_cccdb0a426251ee0 ?? 0;
    life_count = game[ "telemetry" ].life_count ?? 0;
    is_solo_match = isdedicatedserver() ? zm_save::is_save_load_enabled() : 0;
    solo_paused_time_ms = function_e3cd85eead6e1fc7();
    is_one_party_playlist = function_7a3d4348b3110c54();
    pause_timer_expired = game[ "telemetry" ].var_dfe2eb9a94da993c ?? 0;
    save_and_end_game_for_pause_expired = game[ "telemetry" ].save_and_end_game_for_pause_expired ?? 0;
    dlog_recordevent( "dlog_event_zm_server_match_end", [ "utc_start_time_s", utc_start_time_s, "utc_end_time_s", utc_end_time_s, "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "matchtime_ms", info_struct.time, "is_ranked", is_ranked, "round_number", info_struct.round_number, "end_reason", endreason, "total_player_connections", total_player_connections, "is_save_reload", is_save_reload, "life_count", life_count, "is_solo_match", is_solo_match, "solo_paused_time_ms", solo_paused_time_ms, "pause_timer_expired", pause_timer_expired, "save_and_end_game_for_pause_expired", save_and_end_game_for_pause_expired, "is_one_party_playlist", is_one_party_playlist ] );
}

// Namespace zm_telemetry
// Params 0
// Checksum 0x936b39d0, Offset: 0x67a5
// Size: 0x1fb
function function_765b8058cc2bd0a4()
{
    info_struct = zm_telemetry_info_struct();
    is_save_reload = level.zm_save_info.var_cccdb0a426251ee0 ?? 0;
    is_solo_match = isdedicatedserver() ? zm_save::is_save_load_enabled() : 0;
    is_one_party_playlist = function_7a3d4348b3110c54();
    var_1563f28588e5b73b = 0;
    is_godmode_detected = 0;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player val::get( "damage" ) )
        {
            is_godmode_detected = 1;
        }
        
        if ( player val::get( "ignoreme" ) )
        {
            var_1563f28588e5b73b = 1;
        }
    }
    
    dlog_recordevent( "dlog_event_zm_server_time_limit_reached", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "matchtime_ms", info_struct.time, "round_number", info_struct.round_number, "is_save_reload", is_save_reload, "is_solo_match", is_solo_match, "is_notarget_detected", var_1563f28588e5b73b, "is_godmode_detected", is_godmode_detected, "is_one_party_playlist", is_one_party_playlist ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x41fd7854, Offset: 0x69a8
// Size: 0x219
function private on_perk_purchased( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    perk_ref = params.perkref;
    
    if ( !isdefined( perk_ref ) )
    {
        println( "<dev string:x284>" );
        return;
    }
    
    if ( !isxhash( perk_ref ) )
    {
        perk_ref = getxhash( perk_ref );
    }
    
    info_struct = zm_telemetry_info_struct();
    client_uno_id = self getplayerunoid();
    cost = params.cost ?? 0;
    currency = function_5500181132dcbc51( params.currency );
    source = params.source ? getxhash( params.source ) : #"unknown";
    dlog_recordevent( "dlog_event_zm_perk_purchased", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "perk_name_s", perk_ref, "quantity", 1, "client_uno_id", client_uno_id, "purchase_cost", cost, "currency", currency, "source", source, "pos_x", self.origin[ 0 ], "pos_y", self.origin[ 1 ], "pos_z", self.origin[ 2 ] ] );
}

// Namespace zm_telemetry
// Params 1
// Checksum 0xcff0e253, Offset: 0x6bc9
// Size: 0x1a
function on_round_start( params )
{
    update_highest_round();
    function_47e6a28fd2e41e7();
}

// Namespace zm_telemetry
// Params 1
// Checksum 0xa95bd018, Offset: 0x6beb
// Size: 0x27
function on_round_end( params )
{
    function_918d05a240510f66();
    function_6f017376470f06e2();
    wait 0.1;
    update_highest_round();
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xfa129bb8, Offset: 0x6c1a
// Size: 0xed
function private function_b1a70274e9508a18( params )
{
    self.var_35e9ae50a0fb2492 = 1;
    
    if ( isent( self.attacker ) && isagent( self.attacker ) )
    {
        subclass = self.attacker.subclass ?? "unknown";
        weapon_name = params.objweapon.basename ?? self.attacker.weapon.basename ?? "none";
        telemetry = self.pers[ "telemetry" ];
        telemetry.var_e550ff4c99e1b348 = { #weapon_name:weapon_name, #subclass:subclass };
        record_player_death( 1, 0, 0 );
    }
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0x311594ca, Offset: 0x6d0f
// Size: 0x7b
function private function_918d05a240510f66()
{
    foreach ( player in level.players )
    {
        function_31af6ca7b959eeec( player );
    }
}

// Namespace zm_telemetry
// Params 1
// Checksum 0x83365615, Offset: 0x6d92
// Size: 0xd0
function function_31af6ca7b959eeec( player )
{
    if ( !isdefined( player.pers[ "telemetry" ].life.life_index ) )
    {
        return;
    }
    
    round_number = level.var_6781718da4f78d1c.roundnumber ?? 0;
    
    if ( player.pers[ "telemetry" ].var_6b2273b21d7d8bb7 >= round_number )
    {
        return;
    }
    
    if ( !player.var_35e9ae50a0fb2492 )
    {
        player.pers[ "telemetry" ].var_d6e5bf2becd1494e++;
    }
    
    player.pers[ "telemetry" ].var_6b2273b21d7d8bb7 = round_number;
    player.var_35e9ae50a0fb2492 = undefined;
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0x6b6d2b9b, Offset: 0x6e6a
// Size: 0x714
function private function_47e6a28fd2e41e7()
{
    info_struct = zm_telemetry_info_struct();
    
    foreach ( player in level.players )
    {
        telemetry = player.pers[ "telemetry" ];
        summary = player.pers[ "summary" ];
        round_start_info = [];
        round_start_info[ "door_buys" ] = player.doorbuycount ?? 0;
        round_start_info[ "revives" ] = player.revivecount ?? 0;
        round_start_info[ "eliminations" ] = telemetry.eliminations;
        round_start_info[ "normal_eliminations" ] = telemetry.normal_eliminations;
        round_start_info[ "elite_eliminations" ] = telemetry.elite_eliminations;
        round_start_info[ "special_eliminations" ] = telemetry.special_eliminations;
        round_start_info[ "boss_eliminations" ] = telemetry.boss_eliminations;
        round_start_info[ "critical_kills" ] = telemetry.critical_kills;
        round_start_info[ "non_critical_kills" ] = telemetry.non_critical_kills;
        round_start_info[ "pap_weapon_elims" ] = telemetry.pap_weapon_elims;
        round_start_info[ "legendary_weapon_elims" ] = telemetry.legendary_weapon_elims;
        round_start_info[ "one_shot_kills" ] = telemetry.one_shot_kills;
        round_start_info[ "base_zombie_kills" ] = telemetry.base_zombie_kills;
        round_start_info[ "base_zombie_eliminations" ] = telemetry.base_zombie_eliminations;
        round_start_info[ "light_armor_zombie_kills" ] = telemetry.light_armor_zombie_kills;
        round_start_info[ "light_armor_zombie_eliminations" ] = telemetry.light_armor_zombie_eliminations;
        round_start_info[ "heavy_armor_zombie_kills" ] = telemetry.heavy_armor_zombie_kills;
        round_start_info[ "heavy_armor_zombie_eliminations" ] = telemetry.heavy_armor_zombie_eliminations;
        round_start_info[ "vermin_kills" ] = telemetry.vermin_kills;
        round_start_info[ "vermin_eliminations" ] = telemetry.vermin_eliminations;
        round_start_info[ "abomination_kills" ] = telemetry.abomination_kills;
        round_start_info[ "abomination_eliminations" ] = telemetry.abomination_eliminations;
        round_start_info[ "mangler_kills" ] = telemetry.mangler_kills;
        round_start_info[ "mangler_eliminations" ] = telemetry.mangler_eliminations;
        round_start_info[ "parasite_kills" ] = telemetry.parasite_kills;
        round_start_info[ "parasite_eliminations" ] = telemetry.parasite_eliminations;
        round_start_info[ "amalgam_kills" ] = telemetry.amalgam_kills;
        round_start_info[ "amalgam_eliminations" ] = telemetry.amalgam_eliminations;
        round_start_info[ "gh_kills" ] = telemetry.ghoul_kills;
        round_start_info[ "gh_eliminations" ] = telemetry.ghoul_eliminations;
        round_start_info[ "mi_kills" ] = telemetry.mimic_kills;
        round_start_info[ "mi_eliminations" ] = telemetry.mimic_eliminations;
        round_start_info[ "di_kills" ] = telemetry.disciple_kills;
        round_start_info[ "di_eliminations" ] = telemetry.disciple_eliminations;
        round_start_info[ "boss_kala_kills" ] = telemetry.boss_kala_kills;
        round_start_info[ "boss_kala_eliminations" ] = telemetry.boss_kala_eliminations;
        round_start_info[ "weapon_stats_count" ] = telemetry.player_weapon_stats_count;
        round_start_info[ "equipment_stats_count" ] = telemetry.player_equipment_stats_count;
        round_start_info[ "killstreak_stats_count" ] = telemetry.player_killstreak_stats_count;
        round_start_info[ "field_upgrade_stats_count" ] = telemetry.player_field_upgrade_stats_count;
        round_start_info[ "perk_stats_count" ] = telemetry.player_perk_stats_count;
        round_start_info[ "ammo_mod_stats_count" ] = telemetry.player_ammo_mod_stats_count;
        round_start_info[ "augment_stats_count" ] = telemetry.player_augment_stats_count;
        round_start_info[ "rankxp" ] = player utility::callsharedfunc( #"stats", #"getpersstat", "rankxp" ) ?? 0;
        round_start_info[ "rank" ] = player progression_utility::getrank() ?? 0;
        round_start_info[ "total_xp" ] = player.pers[ "rankXpEarnedThisMatch" ] ?? 0;
        round_start_info[ "score_xp" ] = summary[ "score" ] ?? 0;
        round_start_info[ "challenge_xp" ] = summary[ "challenge" ] ?? 0;
        round_start_info[ "match_xp" ] = summary[ "match" ] ?? 0;
        round_start_info[ "medal_xp" ] = summary[ "medal" ] ?? 0;
        round_start_info[ "bonus_xp" ] = summary[ "bonusXP" ] ?? 0;
        round_start_info[ "misc_xp" ] = summary[ "misc" ] ?? 0;
        round_start_info[ "accolade_xp" ] = summary[ "accolade" ] ?? 0;
        round_start_info[ "weapon_xp" ] = summary[ "weaponXP" ] ?? 0;
        round_start_info[ "operator_xp" ] = summary[ "operatorXP" ] ?? 0;
        round_start_info[ "clan_xp" ] = summary[ "clanXP" ] ?? 0;
        round_start_info[ "battlepass_xp" ] = summary[ "battlepassXP" ] ?? 0;
        round_start_info[ "essence_acquired" ] = summary[ "essence_acquired" ] ?? 0;
        round_start_info[ "essence_spent" ] = summary[ "essence_spent" ] ?? 0;
        round_start_info[ "salvage_acquired" ] = summary[ "salvage_acquired" ] ?? 0;
        round_start_info[ "salvage_spent" ] = summary[ "salvage_spent" ] ?? 0;
        round_start_info[ "round_time" ] = info_struct.time;
        telemetry.round_start_info = round_start_info;
        round_dup_times = telemetry.round_dup_times ?? 0;
        
        if ( telemetry.last_round_number == info_struct.round_number )
        {
            round_dup_times++;
            telemetry.round_dup_times = round_dup_times;
        }
        else
        {
            telemetry.round_dup_times = 0;
            round_dup_times = 0;
        }
        
        telemetry.last_round_number = info_struct.round_number;
        round_start_info[ "round_dup_times" ] = round_dup_times;
        var_df2ad4e0f57c34eb = [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round_number", info_struct.round_number ];
        
        foreach ( k, v in round_start_info )
        {
            var_df2ad4e0f57c34eb[ var_df2ad4e0f57c34eb.size ] = k;
            var_df2ad4e0f57c34eb[ var_df2ad4e0f57c34eb.size ] = v;
        }
        
        player dlog_recordplayerevent( "dlog_event_zm_player_round_start", var_df2ad4e0f57c34eb );
    }
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0x38159940, Offset: 0x7586
// Size: 0x7b
function private function_6f017376470f06e2()
{
    foreach ( player in level.players )
    {
        function_694e0e4840da1b95( player );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x2fdd2c55, Offset: 0x7609
// Size: 0x6c8
function private function_694e0e4840da1b95( player )
{
    info_struct = zm_telemetry_info_struct();
    telemetry = player.pers[ "telemetry" ];
    summary = player.pers[ "summary" ];
    round_end_info = [];
    round_end_info[ "door_buys" ] = player.doorbuycount ?? 0;
    round_end_info[ "revives" ] = player.revivecount ?? 0;
    round_end_info[ "eliminations" ] = telemetry.eliminations;
    round_end_info[ "normal_eliminations" ] = telemetry.normal_eliminations;
    round_end_info[ "elite_eliminations" ] = telemetry.elite_eliminations;
    round_end_info[ "special_eliminations" ] = telemetry.special_eliminations;
    round_end_info[ "boss_eliminations" ] = telemetry.boss_eliminations;
    round_end_info[ "critical_kills" ] = telemetry.critical_kills;
    round_end_info[ "non_critical_kills" ] = telemetry.non_critical_kills;
    round_end_info[ "pap_weapon_elims" ] = telemetry.pap_weapon_elims;
    round_end_info[ "legendary_weapon_elims" ] = telemetry.legendary_weapon_elims;
    round_end_info[ "one_shot_kills" ] = telemetry.one_shot_kills;
    round_end_info[ "base_zombie_kills" ] = telemetry.base_zombie_kills;
    round_end_info[ "base_zombie_eliminations" ] = telemetry.base_zombie_eliminations;
    round_end_info[ "light_armor_zombie_kills" ] = telemetry.light_armor_zombie_kills;
    round_end_info[ "light_armor_zombie_eliminations" ] = telemetry.light_armor_zombie_eliminations;
    round_end_info[ "heavy_armor_zombie_kills" ] = telemetry.heavy_armor_zombie_kills;
    round_end_info[ "heavy_armor_zombie_eliminations" ] = telemetry.heavy_armor_zombie_eliminations;
    round_end_info[ "vermin_kills" ] = telemetry.vermin_kills;
    round_end_info[ "vermin_eliminations" ] = telemetry.vermin_eliminations;
    round_end_info[ "abomination_kills" ] = telemetry.abomination_kills;
    round_end_info[ "abomination_eliminations" ] = telemetry.abomination_eliminations;
    round_end_info[ "mangler_kills" ] = telemetry.mangler_kills;
    round_end_info[ "mangler_eliminations" ] = telemetry.mangler_eliminations;
    round_end_info[ "parasite_kills" ] = telemetry.parasite_kills;
    round_end_info[ "parasite_eliminations" ] = telemetry.parasite_eliminations;
    round_end_info[ "amalgam_kills" ] = telemetry.amalgam_kills;
    round_end_info[ "amalgam_eliminations" ] = telemetry.amalgam_eliminations;
    round_end_info[ "gh_kills" ] = telemetry.ghoul_kills;
    round_end_info[ "gh_eliminations" ] = telemetry.ghoul_eliminations;
    round_end_info[ "mi_kills" ] = telemetry.mimic_kills;
    round_end_info[ "mi_eliminations" ] = telemetry.mimic_eliminations;
    round_end_info[ "di_kills" ] = telemetry.disciple_kills;
    round_end_info[ "di_eliminations" ] = telemetry.disciple_eliminations;
    round_end_info[ "boss_kala_kills" ] = telemetry.boss_kala_kills;
    round_end_info[ "boss_kala_eliminations" ] = telemetry.boss_kala_eliminations;
    round_end_info[ "weapon_stats_count" ] = telemetry.player_weapon_stats_count;
    round_end_info[ "equipment_stats_count" ] = telemetry.player_equipment_stats_count;
    round_end_info[ "killstreak_stats_count" ] = telemetry.player_killstreak_stats_count;
    round_end_info[ "field_upgrade_stats_count" ] = telemetry.player_field_upgrade_stats_count;
    round_end_info[ "perk_stats_count" ] = telemetry.player_perk_stats_count;
    round_end_info[ "ammo_mod_stats_count" ] = telemetry.player_ammo_mod_stats_count;
    round_end_info[ "augment_stats_count" ] = telemetry.player_augment_stats_count;
    round_end_info[ "rankxp" ] = player utility::callsharedfunc( #"stats", #"getpersstat", "rankxp" ) ?? 0;
    round_end_info[ "rank" ] = player progression_utility::getrank() ?? 0;
    round_end_info[ "total_xp" ] = player.pers[ "rankXpEarnedThisMatch" ] ?? 0;
    round_end_info[ "score_xp" ] = summary[ "score" ] ?? 0;
    round_end_info[ "challenge_xp" ] = summary[ "challenge" ] ?? 0;
    round_end_info[ "match_xp" ] = summary[ "match" ] ?? 0;
    round_end_info[ "medal_xp" ] = summary[ "medal" ] ?? 0;
    round_end_info[ "bonus_xp" ] = summary[ "bonusXP" ] ?? 0;
    round_end_info[ "misc_xp" ] = summary[ "misc" ] ?? 0;
    round_end_info[ "accolade_xp" ] = summary[ "accolade" ] ?? 0;
    round_end_info[ "weapon_xp" ] = summary[ "weaponXP" ] ?? 0;
    round_end_info[ "operator_xp" ] = summary[ "operatorXP" ] ?? 0;
    round_end_info[ "clan_xp" ] = summary[ "clanXP" ] ?? 0;
    round_end_info[ "battlepass_xp" ] = summary[ "battlepassXP" ] ?? 0;
    round_end_info[ "essence_acquired" ] = summary[ "essence_acquired" ] ?? 0;
    round_end_info[ "essence_spent" ] = summary[ "essence_spent" ] ?? 0;
    round_end_info[ "salvage_acquired" ] = summary[ "salvage_acquired" ] ?? 0;
    round_end_info[ "salvage_spent" ] = summary[ "salvage_spent" ] ?? 0;
    round_end_info[ "round_time" ] = info_struct.time;
    var_91018d7427dd8ab9 = [];
    
    foreach ( k, v in round_end_info )
    {
        var_91018d7427dd8ab9[ k ] = v - ( telemetry.round_start_info[ k ] ?? 0 );
    }
    
    var_df2ad4e0f57c34eb = [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round_number", info_struct.round_number ];
    round_dup_times = telemetry.round_dup_times ?? 0;
    var_91018d7427dd8ab9[ "round_dup_times" ] = round_dup_times;
    
    foreach ( k, v in var_91018d7427dd8ab9 )
    {
        var_df2ad4e0f57c34eb[ var_df2ad4e0f57c34eb.size ] = k;
        var_df2ad4e0f57c34eb[ var_df2ad4e0f57c34eb.size ] = v;
    }
    
    player dlog_recordplayerevent( "dlog_event_zm_player_round_end", var_df2ad4e0f57c34eb );
}

// Namespace zm_telemetry
// Params 1
// Checksum 0xdc88b5cd, Offset: 0x7cd9
// Size: 0x3d
function zm_telemetry_match_end( endreason )
{
    data = { #endreason:endreason };
    telemetry_mp::on_match_end( data );
    zm_match_end( endreason );
    function_41722f8aca3979cd();
}

// Namespace zm_telemetry
// Params 1
// Checksum 0x4b3cd4ed, Offset: 0x7d1e
// Size: 0x271
function on_weapon_upgrade( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    weapon = isweapon( params.weapon ) ? params.weapon : self getcurrentweapon();
    weapon_name = weapon::getweaponrootname( weapon );
    weapon_hash = weapon_name != "" ? getxhash( weapon_name ) : #"";
    rarity = 0;
    pap_level = 0;
    ammo_mod = #"";
    upgrade_type = undefined;
    
    if ( isdefined( params.rarity ) )
    {
        upgrade_type = 1;
        rarity = params.rarity;
    }
    else if ( isdefined( params.var_951c89546ec50477 ) )
    {
        upgrade_type = 2;
        pap_level = params.var_951c89546ec50477;
    }
    else if ( isdefined( params.item ) )
    {
        upgrade_type = 0;
        ammo_mod = getxhash( params.item );
    }
    
    cost = params.cost ?? 0;
    currency = function_5500181132dcbc51( params.currency );
    assert( isdefined( upgrade_type ) );
    self dlog_recordplayerevent( "dlog_event_zm_player_weapon_upgrade", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "weapon", weapon_hash, "upgrade_type", upgrade_type, "ammo_mod", ammo_mod, "rarity", rarity, "pap_level", pap_level, "purchase_cost", cost, "currency", currency ] );
}

// Namespace zm_telemetry
// Params 1
// Checksum 0x3a6c6cbb, Offset: 0x7f97
// Size: 0x15f
function on_armor_upgrade( params )
{
    if ( !isdefined( params.armor_level ) )
    {
        println( "<dev string:x2be>" );
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    client_uno_id = self getplayerunoid();
    cost = params.cost ?? 0;
    currency = function_5500181132dcbc51( params.currency );
    dlog_recordevent( "dlog_event_zm_armor_upgrade", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "armor_level", params.armor_level, "client_uno_id", client_uno_id, "purchase_cost", cost, "currency", currency ] );
}

// Namespace zm_telemetry
// Params 1
// Checksum 0x78a3ad48, Offset: 0x80fe
// Size: 0x43
function on_wallbuy_purchase( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isweapon( params.objweapon ) )
    {
        weapon_acquire( params.objweapon );
        wallbuy_purchase( params );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x5d01e36f, Offset: 0x8149
// Size: 0x1bf
function private wallbuy_purchase( params )
{
    info_struct = zm_telemetry_info_struct();
    weapon_root_name = weapon::getweaponrootname( params.objweapon );
    weapon_hash = weapon_root_name != "" ? getxhash( weapon_root_name ) : #"";
    client_uno_id = self getplayerunoid();
    cost = params.cost ?? 0;
    currency = function_5500181132dcbc51( params.currency );
    origin = self.origin;
    dlog_recordevent( "dlog_event_zm_wall_buy_purchased", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "client_uno_id", client_uno_id, "weapon", weapon_hash, "purchase_cost", cost, "currency", currency, "pos_x", origin[ 0 ], "pos_y", origin[ 1 ], "pos_z", origin[ 2 ] ] );
}

// Namespace zm_telemetry
// Params 1
// Checksum 0xcbb81f50, Offset: 0x8310
// Size: 0x4e
function on_item_pickup( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isweapon( params.item.weaponobj ) )
    {
        weapon_acquire( params.item.weaponobj );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xab20de51, Offset: 0x8366
// Size: 0x78
function private weapon_acquire( weapon )
{
    if ( isnullweapon( weapon ) )
    {
        return;
    }
    
    if ( weapon.isalternate )
    {
        weapon = weapon getnoaltweapon();
    }
    
    if ( weapon::iskillstreakweapon( weapon ) )
    {
        return;
    }
    
    if ( weapon_utility::isgrenadeweapon( weapon ) || weapon_utility::isoffhandweapon( weapon ) )
    {
        return;
    }
    
    if ( weapon::isunderwaterweapon( weapon ) || weapon::isclimbweapon( weapon ) )
    {
        return;
    }
    
    record_weapon_acquire( weapon );
    gameplay_telemetry::function_3e91d2222fa2419f();
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0xc269ff0b, Offset: 0x83e6
// Size: 0x61
function private watch_give_loadout()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"giveloadout" );
    
    if ( isdefined( self.primaryweaponobj ) )
    {
        record_weapon_acquire( self.primaryweaponobj );
    }
    
    if ( isdefined( self.secondaryweaponobj ) )
    {
        record_weapon_acquire( self.secondaryweaponobj );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x40bb51a0, Offset: 0x844f
// Size: 0x102
function private record_weapon_acquire( weapon )
{
    info_struct = zm_telemetry_info_struct();
    weapon_root_name = weapon::getweaponrootname( weapon );
    weapon_hash = weapon_root_name != "" ? getxhash( weapon_root_name ) : #"";
    self dlog_recordplayerevent( "dlog_event_zm_player_weapon_acquire", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "weapon", weapon_hash ] );
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0xeb8ff4dd, Offset: 0x8559
// Size: 0x81d
function private record_favorite_loadout()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"giveloadout" );
    favoriteloadout = class::savefavoriteloadout();
    info_struct = zm_telemetry_info_struct();
    
    if ( !isdefined( favoriteloadout ) )
    {
        return;
    }
    
    self dlog_recordplayerevent( "dlog_event_zm_player_favorite_loadout", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "is_copied_class", favoriteloadout.iscopiedclass ?? 0, "accessory_data", getxhash( favoriteloadout.loadoutaccessorydata ?? "none" ), "accessory_weapon", getxhash( favoriteloadout.loadoutaccessoryweapon ?? "none" ), "archetype", getxhash( favoriteloadout.loadoutarchetype ?? "none" ), "climb_weapon", getxhash( favoriteloadout.loadoutclimbweapon ?? "none" ), "swim_weapon", getxhash( favoriteloadout.loadoutswimweapon ?? "none" ), "equipment_primary", getxhash( favoriteloadout.loadoutequipmentprimary ?? "none" ), "equipment_primary_variant_id", favoriteloadout.var_a1191d5606e653f0 ?? 0, "is_extra_equipment_primary", favoriteloadout.loadoutextraequipmentprimary ?? 0, "equipment_secondary", getxhash( favoriteloadout.loadoutequipmentsecondary ?? "none" ), "equipment_secondary_variant_id", favoriteloadout.var_9481e959139fe88 ?? 0, "is_extra_equipment_secondary", favoriteloadout.loadoutextraequipmentsecondary ?? 0, "fieldupgrade1", getxhash( favoriteloadout.loadoutfieldupgrade1 ?? "none" ), "fieldupgrade1_blueprintindex", favoriteloadout.var_6b08217cbc33ea5c ?? 0, "fieldupgrade2", getxhash( favoriteloadout.loadoutfieldupgrade2 ?? "none" ), "fieldupgrade2_blueprintindex", favoriteloadout.var_5e73e76f67b0afed ?? 0, "super", getxhash( favoriteloadout.loadoutsuper ?? "none" ), "gesture", getxhash( favoriteloadout.loadoutgesture ?? "none" ), "killstreak1", getxhash( favoriteloadout.loadoutkillstreak1 ?? "none" ), "killstreak1_blueprintindex", favoriteloadout.loadoutKillstreak1BlueprintIndex ?? 0, "killstreak2", getxhash( favoriteloadout.loadoutkillstreak2 ?? "none" ), "killstreak2_blueprintindex", favoriteloadout.loadoutKillstreak2BlueprintIndex ?? 0, "killstreak3", getxhash( favoriteloadout.loadoutkillstreak3 ?? "none" ), "killstreak3_blueprintindex", favoriteloadout.loadoutKillstreak3BlueprintIndex ?? 0, "melee_slot", getxhash( favoriteloadout.loadoutmeleeslot ?? "none" ), "rigtrait", getxhash( favoriteloadout.loadoutrigtrait ?? "none" ), "is_perks_from_gamemode", favoriteloadout.loadoutperksfromgamemode ?? 0, "perks", function_80ad82484296e583( favoriteloadout.loadoutperks ), "extra_perks", function_80ad82484296e583( favoriteloadout.loadoutextraperks ), "standard_perks", function_80ad82484296e583( favoriteloadout.loadoutstandardperks ), "weapon_primary_fullname", favoriteloadout.loadoutprimaryfullname ?? "", "weapon_primary_camo", getxhash( favoriteloadout.loadoutprimarycamo ?? "none" ), "weapon_primary_chroma", favoriteloadout.var_69ae546f481034e2 ?? #"", "weapon_primary_cosmetic", getxhash( favoriteloadout.loadoutprimarycosmeticattachment ?? "none" ), "weapon_primary_reticle", getxhash( favoriteloadout.loadoutprimaryreticle ?? "none" ), "weapon_primary_stickers", function_80ad82484296e583( favoriteloadout.loadoutprimarystickers ), "weapon_primary_loot_id", favoriteloadout.loadoutprimarylootitemid ?? 0, "weapon_primary_variant_id", favoriteloadout.loadoutprimaryvariantid ?? 0, "weapon_secondary_fullname", favoriteloadout.loadoutsecondaryfullname ?? "", "weapon_secondary_camo", getxhash( favoriteloadout.loadoutsecondarycamo ?? "none" ), "weapon_secondary_chroma", favoriteloadout.var_2bab3f4f3d38584a ?? #"", "weapon_secondary_cosmetic", getxhash( favoriteloadout.loadoutsecondarycosmeticattachment ?? "none" ), "weapon_secondary_reticle", getxhash( favoriteloadout.loadoutsecondaryreticle ?? "none" ), "weapon_secondary_stickers", function_80ad82484296e583( favoriteloadout.loadoutsecondarystickers ), "weapon_secondary_loot_id", favoriteloadout.loadoutsecondarylootitemid ?? 0, "weapon_secondary_variant_id", favoriteloadout.loadoutsecondaryvariantid ?? 0, "weapon_tertiary_fullname", favoriteloadout.var_441e64c50e9d846a ?? "", "weapon_tertiary_camo", getxhash( favoriteloadout.loadouttertiarycamo ?? "none" ), "weapon_tertiary_chroma", favoriteloadout.var_de6bc6d1e7c111ea ?? #"", "weapon_tertiary_cosmetic", getxhash( favoriteloadout.loadoutTertiaryCosmeticAttachment ?? "none" ), "weapon_tertiary_reticle", getxhash( favoriteloadout.loadouttertiaryreticle ?? "none" ), "weapon_tertiary_stickers", function_80ad82484296e583( favoriteloadout.loadoutTertiaryStickers ), "weapon_tertiary_loot_id", favoriteloadout.loadoutTertiaryLootItemID ?? 0, "weapon_tertiary_variant_id", favoriteloadout.loadouttertiaryvariantid ?? 0, "is_streaks_filled", favoriteloadout.loadoutstreaksfilled ?? 0, "streak_type", getxhash( favoriteloadout.loadoutstreaktype ?? "none" ), "is_using_specialist", favoriteloadout.loadoutusingspecialist ?? 0, "wildcard", getxhash( favoriteloadout.loadoutwildcard ?? "none" ) ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xdef28f9, Offset: 0x8d7e
// Size: 0x39
function private function_80ad82484296e583( array )
{
    if ( !array || array.size == 0 )
    {
        return "";
    }
    
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    return function_5d044133536d0766( ",", array );
}

// Namespace zm_telemetry
// Params 1
// Checksum 0xb91f429e, Offset: 0x8dc0
// Size: 0x1969
function on_player_match_end( data )
{
    player = data.player;
    
    if ( isdefined( player.pers[ "telemetry" ].var_fa7df34e464eabdf ) )
    {
        return;
    }
    
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( player.var_5a792f9fdacf9283 && !level.gameended )
    {
        return;
    }
    
    function_31af6ca7b959eeec( player );
    function_694e0e4840da1b95( player );
    function_abf3fae8f87a753f( player );
    function_bd9a8673e8cdd22d( player );
    function_9729f4a9b1d8e2c4( player );
    function_fde6233651fb779b( player );
    
    if ( isdefined( self.var_3c234268ba458c77 ) )
    {
        function_dc5e9a38d8b1fd1e();
    }
    
    function_d72ad5241bab766b( player );
    function_a9ed7700ad7180b8( player );
    function_7aab4ba517a6671a( player );
    function_d81132e4ca605e4e( player );
    telemetry = player.pers[ "telemetry" ];
    summary = player.pers[ "summary" ];
    utc_connect_time = telemetry.utc_connect_time_s ?? 0;
    var_5526b256c7c41ec5 = getsystemtime();
    time_played = var_5526b256c7c41ec5 - utc_connect_time;
    disconnect_reason = data.disconnectreason ?? #"";
    is_ranked = 0;
    
    if ( level.leagueplaymatch || level.var_309e3d9dac389de6 )
    {
        is_ranked = 1;
    }
    
    reached_match_end = telemetry.reached_match_end ?? 0;
    exfil_success = telemetry.exfil_success ?? 0;
    exfil_failure = game[ "telemetry" ].exfil_started || telemetry.exfil_started ? !exfil_success : 0;
    exfil_forced_ending = istrue( game[ "telemetry" ].exfil_forced_ending );
    reached_match_end |= exfil_success;
    essence = player.total_score_earned ?? 0;
    salvage = summary[ "salvage_acquired" ] ?? 0;
    door_buys = player.doorbuycount ?? 0;
    revives = player.revivecount ?? 0;
    is_save_reload = level.zm_save_info.var_cccdb0a426251ee0 ?? 0;
    match_id = getonlinematchid();
    mq_complete_time_ms = telemetry.mq_complete_time_ms ?? 0;
    
    if ( is_save_reload )
    {
        var_efd960f3c3cf6f19 = telemetry.var_efd960f3c3cf6f19;
        essence -= var_efd960f3c3cf6f19.essence ?? 0;
        door_buys -= var_efd960f3c3cf6f19.door_buys ?? 0;
        revives -= var_efd960f3c3cf6f19.revives ?? 0;
        
        if ( var_efd960f3c3cf6f19.mq_completed )
        {
            mq_complete_time_ms = 0;
        }
        
        if ( isdefined( var_efd960f3c3cf6f19.match_id ) )
        {
            match_id = var_efd960f3c3cf6f19.match_id;
        }
    }
    
    eliminations = telemetry.eliminations ?? 0;
    normal_eliminations = telemetry.normal_eliminations ?? 0;
    elite_eliminations = telemetry.elite_eliminations ?? 0;
    special_eliminations = telemetry.special_eliminations ?? 0;
    boss_eliminations = telemetry.boss_eliminations ?? 0;
    critical_kills = telemetry.critical_kills ?? 0;
    non_critical_kills = telemetry.non_critical_kills ?? 0;
    pap_weapon_elims = telemetry.pap_weapon_elims ?? 0;
    legendary_weapon_elims = telemetry.legendary_weapon_elims ?? 0;
    one_shot_kills = telemetry.one_shot_kills ?? 0;
    base_zombie_kills = telemetry.base_zombie_kills ?? 0;
    base_zombie_eliminations = telemetry.base_zombie_eliminations ?? 0;
    light_armor_zombie_kills = telemetry.light_armor_zombie_kills ?? 0;
    light_armor_zombie_eliminations = telemetry.light_armor_zombie_eliminations ?? 0;
    heavy_armor_zombie_kills = telemetry.heavy_armor_zombie_kills ?? 0;
    heavy_armor_zombie_eliminations = telemetry.heavy_armor_zombie_eliminations ?? 0;
    vermin_kills = telemetry.vermin_kills ?? 0;
    vermin_eliminations = telemetry.vermin_eliminations ?? 0;
    abomination_kills = telemetry.abomination_kills ?? 0;
    abomination_eliminations = telemetry.abomination_eliminations ?? 0;
    mangler_kills = telemetry.mangler_kills ?? 0;
    mangler_eliminations = telemetry.mangler_eliminations ?? 0;
    parasite_kills = telemetry.parasite_kills ?? 0;
    parasite_eliminations = telemetry.parasite_eliminations ?? 0;
    amalgam_kills = telemetry.amalgam_kills ?? 0;
    amalgam_eliminations = telemetry.amalgam_eliminations ?? 0;
    ghoul_kills = telemetry.ghoul_kills ?? 0;
    ghoul_eliminations = telemetry.ghoul_eliminations ?? 0;
    mimic_kills = telemetry.mimic_kills ?? 0;
    mimic_eliminations = telemetry.mimic_eliminations ?? 0;
    disciple_kills = telemetry.disciple_kills ?? 0;
    disciple_eliminations = telemetry.disciple_eliminations ?? 0;
    boss_kala_kills = telemetry.boss_kala_kills ?? 0;
    boss_kala_eliminations = telemetry.boss_kala_eliminations ?? 0;
    prestige_at_start = telemetry.prestige_at_start;
    player_weapon_stats_count = telemetry.player_weapon_stats_count ?? 0;
    player_equipment_stats_count = telemetry.player_equipment_stats_count ?? 0;
    player_killstreak_stats_count = telemetry.player_killstreak_stats_count ?? 0;
    player_field_upgrade_stats_count = telemetry.player_field_upgrade_stats_count ?? 0;
    prestige_at_end = player get_prestige();
    is_solo_match = isdedicatedserver() ? zm_save::is_save_load_enabled() : 0;
    join_later_rounds = player is_join_later_rounds();
    var_1e27e95550df1c60 = player.pers[ "rankxp" ];
    current_rank = player progression_utility::getrank();
    player_xp_scale = game_utility::function_c6e89e9bd38dba2c();
    weapon_xp_scale = game_utility::function_52f600c9a675164c();
    battlepass_xp_scale = game_utility::function_846dc4e6907bc44b();
    operator_xp_scale = game_utility::function_de67813d104116b6();
    clan_xp_scale = game_utility::function_9780a6a356d5aa72();
    is_mq_complete = zm_quest::is_main_quest_complete() || telemetry.mq_completed;
    is_papq_complete = zm_quest::is_pap_quest_complete();
    is_wwq_complete = zm_quest::is_ww_quest_complete();
    wwuq_complete_name = zm_quest::function_fce1c478766746db() ?? "";
    wwuq_complete_name = getxhash( wwuq_complete_name );
    boss_subclass = game[ "telemetry" ].boss_subclass ?? #"";
    is_sqs_complete = [];
    sqs_name = [];
    side_quests = zm_quest::get_all_side_quests();
    sd_id = 0;
    
    foreach ( sq in side_quests )
    {
        is_sqs_complete[ sd_id ] = sq.completed;
        sqs_name[ sd_id ] = sq.ref;
        sd_id++;
        
        if ( sd_id == 13 )
        {
            break;
        }
    }
    
    for ( i = sd_id; i < 13 ; i++ )
    {
        is_sqs_complete[ i ] = 0;
        sqs_name[ i ] = #"";
    }
    
    deadliest_info = get_player_deadliest_weapon( player );
    solo_paused_time_ms = function_e3cd85eead6e1fc7();
    pause_timer_expired = game[ "telemetry" ].var_dfe2eb9a94da993c ?? 0;
    save_and_end_game_for_pause_expired = game[ "telemetry" ].save_and_end_game_for_pause_expired ?? 0;
    save_and_end_game = data.endreason == game[ "end_reason" ][ "save_and_end_game" ];
    info_struct = zm_telemetry_info_struct();
    assert( side_quests.size <= 13, "<dev string:x2fa>" + 13 + "<dev string:x30a>" + info_struct.map_name + "<dev string:x36b>" + side_quests.size + "<dev string:x371>" );
    match_start_xp = telemetry.progression_verified ? telemetry.xp_at_start : telemetry.match_start_xp;
    match_start_rank = telemetry.progression_verified ? telemetry.rank_at_start : telemetry.match_start_rank;
    lobby_id = getlobbyid() ?? "";
    is_one_party_playlist = function_7a3d4348b3110c54();
    blackcell_loyalty = telemetry.blackcell_loyalty ?? 0;
    won_grief_game = info_struct.game_type == "zm_grief" && data.winner == player.team;
    player dlog_recordplayerevent( "dlog_event_zm_player_match_end", [ "utc_connect_time_s", utc_connect_time, "utc_disconnect_time_s", var_5526b256c7c41ec5, "disconnect_reason", disconnect_reason, "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "player_quit_round_number", info_struct.round_number, "matchtime_ms", info_struct.time, "is_ranked", is_ranked, "reached_match_end", reached_match_end, "exfil_success", exfil_success, "exfil_failure", exfil_failure, "exfil_forced_ending", exfil_forced_ending, "essence", essence, "salvage", salvage, "eliminations", eliminations, "normal_eliminations", normal_eliminations, "elite_eliminations", elite_eliminations, "special_eliminations", special_eliminations, "boss_eliminations", boss_eliminations, "critical_kills", critical_kills, "non_critical_kills", non_critical_kills, "pap_weapon_elims", pap_weapon_elims, "legendary_weapon_elims", legendary_weapon_elims, "one_shot_kills", one_shot_kills, "mq_complete_time_ms", mq_complete_time_ms, "current_season", info_struct.season, "prestige_at_start", prestige_at_start, "prestige_at_end", prestige_at_end, "base_zombie_kills", base_zombie_kills, "base_zombie_eliminations", base_zombie_eliminations, "light_armor_zombie_kills", light_armor_zombie_kills, "light_armor_zombie_eliminations", light_armor_zombie_eliminations, "heavy_armor_zombie_kills", heavy_armor_zombie_kills, "heavy_armor_zombie_eliminations", heavy_armor_zombie_eliminations, "vermin_kills", vermin_kills, "vermin_eliminations", vermin_eliminations, "abomination_kills", abomination_kills, "abomination_eliminations", abomination_eliminations, "mangler_kills", mangler_kills, "mangler_eliminations", mangler_eliminations, "parasite_kills", parasite_kills, "parasite_eliminations", parasite_eliminations, "amalgam_kills", amalgam_kills, "amalgam_eliminations", amalgam_eliminations, "gh_kills", ghoul_kills, "gh_eliminations", ghoul_eliminations, "mi_kills", mimic_kills, "mi_eliminations", mimic_eliminations, "di_kills", disciple_kills, "di_eliminations", disciple_eliminations, "boss_kala_kills", boss_kala_kills, "boss_kala_eliminations", boss_kala_eliminations, "door_buys", door_buys, "revives", revives, "is_save_reload", is_save_reload, "time_played", time_played, "player_weapon_stats_count", player_weapon_stats_count, "is_solo_match", is_solo_match, "player_equipment_stats_count", player_equipment_stats_count, "join_later_rounds", join_later_rounds, "player_killstreak_stats_count", player_killstreak_stats_count, "player_field_upgrade_stats_count", player_field_upgrade_stats_count, "player_perk_stats_count", telemetry.player_perk_stats_count ?? 0, "player_ammo_mod_stats_count", telemetry.player_ammo_mod_stats_count ?? 0, "player_augment_stats_count", telemetry.player_augment_stats_count ?? 0, "rank_at_start", match_start_rank ?? 0, "rank_at_end", current_rank ?? 0, "xp_at_start", match_start_xp ?? 0, "xp_at_end", var_1e27e95550df1c60 ?? 0, "total_xp", player.pers[ "rankXpEarnedThisMatch" ] ?? 0, "score_xp", summary[ "score" ] ?? 0, "challenge_xp", summary[ "challenge" ] ?? 0, "match_xp", summary[ "match" ] ?? 0, "medal_xp", summary[ "medal" ] ?? 0, "bonus_xp", summary[ "bonusXP" ] ?? 0, "misc_xp", summary[ "misc" ] ?? 0, "accolade_xp", summary[ "accolade" ] ?? 0, "player_xp_scale", player_xp_scale, "weapon_xp", summary[ "weaponXP" ] ?? 0, "weapon_xp_scale", weapon_xp_scale, "operator_xp", summary[ "operatorXP" ] ?? 0, "operator_xp_scale", operator_xp_scale, "clan_xp", summary[ "clanXP" ] ?? 0, "clan_xp_scale", clan_xp_scale, "battlepass_xp", summary[ "battlepassXP" ] ?? 0, "battlepass_xp_scale", battlepass_xp_scale, "initial_match_id", match_id, "is_mq_complete", is_mq_complete, "is_papq_complete", is_papq_complete, "is_wwq_complete", is_wwq_complete, "is_sq1_complete", is_sqs_complete[ 0 ], "sq1_name", sqs_name[ 0 ], "is_sq2_complete", is_sqs_complete[ 1 ], "sq2_name", sqs_name[ 1 ], "deadliest_weapon", deadliest_info.deadliest_weapon, "deadliest_weapon_paplvl", deadliest_info.deadliest_weapon_paplvl, "deadliest_weapon_elims", deadliest_info.deadliest_weapon_elims, "deadliest_weapon_elims_pap", deadliest_info.deadliest_weapon_elims_pap, "deadliest_weapon_critcal_kills", deadliest_info.deadliest_weapon_critcal_kills, "deadliest_weapon_rarity", deadliest_info.deadliest_weapon_rarity, "is_sq3_complete", is_sqs_complete[ 2 ], "sq3_name", sqs_name[ 2 ], "is_sq4_complete", is_sqs_complete[ 3 ], "sq4_name", sqs_name[ 3 ], "is_sq5_complete", is_sqs_complete[ 4 ], "sq5_name", sqs_name[ 4 ], "progression_verified", telemetry.progression_verified, "solo_paused_time_ms", solo_paused_time_ms, "lobby_id", lobby_id, "pause_timer_expired", pause_timer_expired, "save_and_end_game_for_pause_expired", save_and_end_game_for_pause_expired, "save_and_end_game", save_and_end_game, "is_one_party_playlist", is_one_party_playlist, "blackcell_loyalty", blackcell_loyalty, "team", player.team ?? "allies", "won_grief_game", won_grief_game, "minor_augments_unlocked", telemetry.minor_augments_unlocked ?? 0, "major_augments_unlocked", telemetry.major_augments_unlocked ?? 0, "wwuq_complete_name", wwuq_complete_name, "boss_subclass", boss_subclass, "party_id", telemetry.party_id ?? "", "is_sq6_complete", is_sqs_complete[ 5 ], "sq6_name", sqs_name[ 5 ], "is_sq7_complete", is_sqs_complete[ 6 ], "sq7_name", sqs_name[ 6 ], "is_sq8_complete", is_sqs_complete[ 7 ], "sq8_name", sqs_name[ 7 ], "is_sq9_complete", is_sqs_complete[ 8 ], "sq9_name", sqs_name[ 8 ], "is_sq10_complete", is_sqs_complete[ 9 ], "sq10_name", sqs_name[ 9 ], "is_sq11_complete", is_sqs_complete[ 10 ], "sq11_name", sqs_name[ 10 ], "is_sq12_complete", is_sqs_complete[ 11 ], "sq12_name", sqs_name[ 11 ], "is_sq13_complete", is_sqs_complete[ 12 ], "sq13_name", sqs_name[ 12 ] ] );
    
    if ( is_save_reload && data.endreason != game[ "end_reason" ][ "save_and_end_game" ] )
    {
        var_efd960f3c3cf6f19 = telemetry.var_efd960f3c3cf6f19;
        essence = player.total_score_earned ?? 0;
        salvage += var_efd960f3c3cf6f19.salvage ?? 0;
        eliminations += var_efd960f3c3cf6f19.eliminations ?? 0;
        special_eliminations += var_efd960f3c3cf6f19.special_eliminations ?? 0;
        elite_eliminations += var_efd960f3c3cf6f19.elite_eliminations ?? 0;
        boss_eliminations += var_efd960f3c3cf6f19.boss_eliminations ?? 0;
        critical_kills += var_efd960f3c3cf6f19.critical_kills ?? 0;
        pap_weapon_elims += var_efd960f3c3cf6f19.pap_weapon_elims ?? 0;
        legendary_weapon_elims += var_efd960f3c3cf6f19.legendary_weapon_elims ?? 0;
        one_shot_kills += var_efd960f3c3cf6f19.one_shot_kills ?? 0;
        time_played += var_efd960f3c3cf6f19.prev_time_played ?? 0;
        door_buys = player.doorbuycount ?? 0;
        revives = player.revivecount ?? 0;
        mq_complete_time_ms = telemetry.mq_complete_time_ms ?? 0;
        solo_paused_time_ms += var_efd960f3c3cf6f19.solo_paused_time_ms ?? 0;
        player dlog_recordplayerevent( "dlog_event_zm_player_match_end_aggregated", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "essence", essence, "salvage", salvage, "eliminations", eliminations, "elite_eliminations", elite_eliminations, "special_eliminations", special_eliminations, "boss_eliminations", boss_eliminations, "critical_kills", critical_kills, "pap_weapon_elims", pap_weapon_elims, "legendary_weapon_elims", legendary_weapon_elims, "one_shot_kills", one_shot_kills, "mq_complete_time_ms", mq_complete_time_ms, "time_played", time_played, "door_buys", door_buys, "revives", revives, "initial_match_id", match_id, "is_mq_complete", is_mq_complete, "is_papq_complete", is_papq_complete, "is_wwq_complete", is_wwq_complete, "is_sq1_complete", is_sqs_complete[ 0 ], "sq1_name", sqs_name[ 0 ], "is_sq2_complete", is_sqs_complete[ 1 ], "sq2_name", sqs_name[ 1 ], "is_sq3_complete", is_sqs_complete[ 2 ], "sq3_name", sqs_name[ 2 ], "is_sq4_complete", is_sqs_complete[ 3 ], "sq4_name", sqs_name[ 3 ], "is_sq5_complete", is_sqs_complete[ 4 ], "sq5_name", sqs_name[ 4 ], "solo_paused_time_ms", solo_paused_time_ms, "wwuq_complete_name", wwuq_complete_name, "boss_subclass", boss_subclass, "is_sq6_complete", is_sqs_complete[ 5 ], "sq6_name", sqs_name[ 5 ], "is_sq7_complete", is_sqs_complete[ 6 ], "sq7_name", sqs_name[ 6 ], "is_sq8_complete", is_sqs_complete[ 7 ], "sq8_name", sqs_name[ 7 ], "is_sq9_complete", is_sqs_complete[ 8 ], "sq9_name", sqs_name[ 8 ], "is_sq10_complete", is_sqs_complete[ 9 ], "sq10_name", sqs_name[ 9 ], "is_sq11_complete", is_sqs_complete[ 10 ], "sq11_name", sqs_name[ 10 ], "is_sq12_complete", is_sqs_complete[ 11 ], "sq12_name", sqs_name[ 11 ], "is_sq13_complete", is_sqs_complete[ 12 ], "sq13_name", sqs_name[ 12 ] ] );
    }
    
    telemetry.var_fa7df34e464eabdf = 1;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x81af28f8, Offset: 0xa731
// Size: 0x1ed
function private get_player_deadliest_weapon( player )
{
    deadliest_weapon = #"none";
    deadliest_weapon_paplvl = 0;
    deadliest_weapon_elims = 0;
    deadliest_weapon_elims_pap = 0;
    deadliest_weapon_critcal_kills = 0;
    deadliest_weapon_rarity = 0;
    var_992769da1fcb6f42 = player.pers[ #"deadliest_weapon_tracking" ].weaponstats;
    
    if ( isdefined( var_992769da1fcb6f42 ) )
    {
        foreach ( weaponname, weaponstats in var_992769da1fcb6f42 )
        {
            if ( !( isdefined( weaponstats.elims ) && isdefined( weaponstats.var_ef4475d810a1ca18 ) ) )
            {
                continue;
            }
            
            if ( !isdefined( deadliest_weapon ) || weaponstats.elims > deadliest_weapon_elims || weaponstats.elims == deadliest_weapon_elims && deadliest_weapon_critcal_kills < weaponstats.var_ef4475d810a1ca18 )
            {
                deadliest_weapon = getxhash( weaponname );
                deadliest_weapon_paplvl = weaponstats.var_c126ac2e6a22d987 ?? 0;
                deadliest_weapon_elims = weaponstats.elims ?? 0;
                deadliest_weapon_elims_pap = weaponstats.elimspap ?? 0;
                deadliest_weapon_critcal_kills = weaponstats.var_ef4475d810a1ca18 ?? 0;
                deadliest_weapon_rarity = weaponstats.rarity ?? 0;
            }
        }
    }
    
    return { #deadliest_weapon_rarity:deadliest_weapon_rarity, #deadliest_weapon_critcal_kills:deadliest_weapon_critcal_kills, #deadliest_weapon_elims_pap:deadliest_weapon_elims_pap, #deadliest_weapon_elims:deadliest_weapon_elims, #deadliest_weapon_paplvl:deadliest_weapon_paplvl, #deadliest_weapon:deadliest_weapon };
}

// Namespace zm_telemetry
// Params 0
// Checksum 0xf8ee18d1, Offset: 0xa927
// Size: 0x1e, Type: bool
function is_join_later_rounds()
{
    return self.pers[ "telemetry" ].join_round_number >= 10;
}

// Namespace zm_telemetry
// Params 1
// Checksum 0xf68eaede, Offset: 0xa94e
// Size: 0x3f
function on_player_disconnect( data )
{
    if ( data.player.hasseenendgamesplash )
    {
        telemetry_utils::function_c54601d44e7b8e8a( data.player );
    }
    
    on_player_match_end( data );
}

// Namespace zm_telemetry
// Params 1
// Checksum 0xec3a9d33, Offset: 0xa995
// Size: 0xc1
function on_player_exfil_success( params )
{
    a_exfil_players = params.a_exfil_players ?? level.players;
    
    foreach ( player in a_exfil_players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player.pers[ "telemetry" ].exfil_success = 1;
    }
}

// Namespace zm_telemetry
// Params 1
// Checksum 0x5c98e022, Offset: 0xaa5e
// Size: 0xda
function on_exfil_started( params )
{
    if ( isdefined( params.a_exfil_players ) )
    {
        foreach ( player in params.a_exfil_players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            player.pers[ "telemetry" ].exfil_started = 1;
        }
        
        return;
    }
    
    if ( isdefined( game[ "telemetry" ] ) )
    {
        game[ "telemetry" ].exfil_started = 1;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xe3307ce5, Offset: 0xab40
// Size: 0x4f
function private on_agent_spawned( params )
{
    agent = params.agent;
    
    if ( !isagent( agent ) )
    {
        return;
    }
    
    agent.zm_ai_stats = { #player_inflictors:[], #damage_dealt:0 };
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x2c459079, Offset: 0xab97
// Size: 0x342
function private function_b5178a27f638123b( sparams )
{
    if ( !isdefined( self.var_27e019fe6697c4a2 ) )
    {
        self.var_27e019fe6697c4a2 = [];
    }
    
    if ( isplayer( sparams.eattacker ) && isdefined( sparams.sweapon ) && !isnullweapon( sparams.sweapon ) )
    {
        weapon = sparams.sweapon;
        playerid = sparams.eattacker getentitynumber();
        
        if ( !isdefined( self.var_27e019fe6697c4a2[ playerid ] ) )
        {
            self.var_27e019fe6697c4a2[ playerid ] = [];
        }
        
        if ( isweapon( sparams.einflictor.glgrenadeparent ) )
        {
            weapon = sparams.einflictor.glgrenadeparent;
        }
        
        weapon_root_name = weapon::getweaponrootname( weapon );
        found = 0;
        
        foreach ( i, weaponobj in self.var_27e019fe6697c4a2[ playerid ] )
        {
            var_701f659dbd27e3e2 = weapon::getweaponrootname( weapon );
            
            if ( weapon_root_name == var_701f659dbd27e3e2 )
            {
                self.var_27e019fe6697c4a2[ playerid ][ i ] = weapon;
                found = 1;
                break;
            }
        }
        
        if ( !found )
        {
            self.var_27e019fe6697c4a2[ playerid ][ self.var_27e019fe6697c4a2[ playerid ].size ] = weapon;
        }
        
        if ( getdvarint( @"hash_e742008972155619", 0 ) )
        {
            weapon_root_name = weapon.basename;
        }
        
        if ( sparams.var_ac6da6d4896af068 )
        {
            sparams.eattacker callback::callback( "perk_stats_track", { #highest_critical_damage:sparams.idamage, #var_ffc1674def575bfa:"specialty_deadshot" } );
        }
        
        function_1229570834a73bba( sparams );
    }
    
    if ( challenges::challengesenabled() )
    {
        return;
    }
    
    if ( !isent( self ) || !isagent( self ) )
    {
        return;
    }
    
    if ( isdefined( self.health ) && isdefined( self.maxhealth ) && self.health >= self.maxhealth )
    {
        self.var_d3a7b3f093df2ff1 = gettime();
    }
    
    if ( sparams.idamage > 0 && isdefined( self.zm_ai_stats ) )
    {
        if ( !isdefined( self.zm_ai_stats.var_56d69f6ef35661b0 ) )
        {
            self.zm_ai_stats.var_56d69f6ef35661b0 = gettime();
        }
        
        if ( isplayer( sparams.eattacker ) )
        {
            entity_number = sparams.eattacker getentitynumber();
            
            if ( !arraycontains( self.zm_ai_stats.player_inflictors, entity_number ) )
            {
                self.zm_ai_stats.player_inflictors[ self.zm_ai_stats.player_inflictors.size ] = entity_number;
            }
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xe1114d1e, Offset: 0xaee1
// Size: 0x2fb
function private function_7a5163f949747413( ai )
{
    if ( !isdefined( ai.zm_ai_stats ) || ai.var_48960fedb514aedd )
    {
        return;
    }
    
    should_send = 0;
    
    if ( isdefined( ai.aicategory ) )
    {
        switch ( ai.aicategory )
        {
            case #"hash_7b0e2f2ed84f34":
            case #"hash_4e47eb6c32f5b165":
            case #"hash_7e8a002ed096276c":
                should_send = 1;
                break;
            case #"hash_8c089e813083e510":
                should_send = randomfloat( 100 ) < 10;
                break;
            case #"hash_84fcf5e68d7230b2":
                should_send = randomfloat( 100 ) < 1;
                break;
        }
    }
    
    /#
        if ( getdvarint( @"hash_f31ea109eb616f10", 0 ) )
        {
            should_send = 1;
        }
    #/
    
    if ( should_send )
    {
        info_struct = zm_telemetry_info_struct();
        agent_type = isdefined( ai.agent_type ) ? getxhash( ai.agent_type ) : #"";
        subclass = isdefined( ai.subclass ) ? getxhash( ai.subclass ) : #"";
        ai_category = isdefined( ai.aicategory ) ? getxhash( ai.aicategory ) : #"";
        survival_time_while_damaged = isdefined( ai.zm_ai_stats.var_56d69f6ef35661b0 ) ? gettime() - ai.zm_ai_stats.var_56d69f6ef35661b0 : 0;
        damage_dealt_during_lifespan = ai.zm_ai_stats.damage_dealt;
        number_of_player_inflictors = ai.zm_ai_stats.player_inflictors.size;
        throttle::throttle_wait_in_queue( level.zm_ai_stats_event_throttle, ai.zm_ai_stats );
        dlog_recordevent( "dlog_event_zm_ai_stats", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "agent_type", agent_type, "subclass", subclass, "ai_category", ai_category, "survival_time_while_damaged", survival_time_while_damaged, "damage_dealt_during_lifespan", damage_dealt_during_lifespan, "number_of_player_inflictors", number_of_player_inflictors ] );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x4615065e, Offset: 0xb1e4
// Size: 0x44
function private agent_fake_defeat_health( params )
{
    if ( !isagent( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( params.health_percentage > 0 )
    {
        self.var_62e68eab9778709e = params.health_percentage;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x464b34e9, Offset: 0xb230
// Size: 0xd9
function private function_1229570834a73bba( sparams )
{
    if ( !isplayer( sparams.eattacker ) || !sparams.sweapon || isnullweapon( sparams.sweapon ) || sparams.idamage == 0 )
    {
        return;
    }
    
    if ( !isalive( self ) || self.var_d100d4b0abe9c628 )
    {
        return;
    }
    
    if ( self.var_62e68eab9778709e > 0 && self.maxhealth > 0 )
    {
        health_percentage = ( self.health - sparams.idamage ) / self.maxhealth * 100;
        
        if ( health_percentage <= self.var_62e68eab9778709e )
        {
            function_7e4e1c6c39fc475d( sparams );
            self.var_d100d4b0abe9c628 = 1;
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x26f78f02, Offset: 0xb311
// Size: 0xd19
function private function_7e4e1c6c39fc475d( sparams )
{
    if ( !isagent( self ) )
    {
        return;
    }
    
    if ( self.var_5f1f874776178f2 )
    {
        return;
    }
    
    if ( self.var_d100d4b0abe9c628 )
    {
        return;
    }
    
    thread function_7a5163f949747413( self );
    attacker = sparams.eattacker;
    var_8a5436f40ecec352 = isplayer( sparams.eattacker );
    is_brainrotted_kill = 0;
    var_3cfad46c36210201 = 0;
    var_b0584ef866f9e82 = 0;
    
    if ( !var_8a5436f40ecec352 && isagent( attacker ) )
    {
        if ( attacker zombie_utils::function_bf1464d09f4e4b40() )
        {
            if ( isplayer( attacker.var_bd22ba6c600a23a3 ) || isplayer( attacker.var_fb2e0070ae6f04e4 ) )
            {
                is_brainrotted_kill = isplayer( attacker.var_bd22ba6c600a23a3 );
                var_3cfad46c36210201 = isplayer( attacker.var_fb2e0070ae6f04e4 );
                var_b0584ef866f9e82 = is_brainrotted_kill | var_3cfad46c36210201;
                attacker = attacker.var_bd22ba6c600a23a3 ?? attacker.var_fb2e0070ae6f04e4;
                var_8a5436f40ecec352 = 1;
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_105995ad023048a", 0 ) )
        {
            category = self.aicategory ?? "<dev string:x37e>";
            subclass = self.subclass ?? "<dev string:x37e>";
            ent_num = self getentitynumber();
            
            if ( var_8a5436f40ecec352 )
            {
                println( "<dev string:x383>" + ent_num + "<dev string:x3ab>" + category + "<dev string:x3b9>" + subclass + "<dev string:x3c7>" + attacker.name + "<dev string:x3d5>" );
            }
            else
            {
                println( "<dev string:x383>" + ent_num + "<dev string:x3ab>" + category + "<dev string:x3b9>" + subclass + "<dev string:x3d7>" );
            }
        }
    #/
    
    if ( !var_8a5436f40ecec352 )
    {
        return;
    }
    
    is_elite_enemy = 0;
    is_special_enemy = 0;
    is_boss_enemy = 0;
    is_normal_enemy = 0;
    
    if ( isdefined( self.aicategory ) )
    {
        switch ( self.aicategory )
        {
            case #"hash_7b0e2f2ed84f34":
            case #"hash_4e47eb6c32f5b165":
                is_elite_enemy = 1;
                break;
            case #"hash_8c089e813083e510":
                is_special_enemy = 1;
                break;
            case #"hash_7e8a002ed096276c":
                if ( utility::issharedfuncdefined( #"zombie", #"get_boss_entity" ) )
                {
                    boss = utility::callsharedfunc( #"zombie", #"get_boss_entity" );
                    
                    if ( boss != self )
                    {
                        /#
                            if ( getdvarint( @"hash_105995ad023048a", 0 ) )
                            {
                                ent_num = self getentitynumber();
                                println( "<dev string:x40a>" + ent_num + "<dev string:x42b>" );
                            }
                        #/
                        
                        return;
                    }
                }
                
                is_boss_enemy = 1;
                break;
            default:
                is_normal_enemy = 1;
                break;
        }
    }
    
    if ( !isdefined( self.a_n_player_damage ) )
    {
        self.a_n_player_damage = [];
    }
    
    if ( !isdefined( self.var_27e019fe6697c4a2 ) )
    {
        self.var_27e019fe6697c4a2 = [];
    }
    
    if ( isweapon( sparams.einflictor.glgrenadeparent ) )
    {
        sparams.sweapon = sparams.einflictor.glgrenadeparent;
    }
    
    is_hellhound_molotov_kill = isdefined( sparams.einflictor ) && sparams.einflictor.weapon_name == "hellhound_molotov";
    
    if ( var_8a5436f40ecec352 && !arraycontains( self.a_n_player_damage, attacker ) )
    {
        a_n_player_damage = arraycopy( self.a_n_player_damage );
        a_n_player_damage[ a_n_player_damage.size ] = attacker;
        
        if ( isdefined( sparams.sweapon ) && !isnullweapon( sparams.sweapon ) && !var_b0584ef866f9e82 && !is_hellhound_molotov_kill )
        {
            playerid = attacker getentitynumber();
            var_27e019fe6697c4a2 = arraycopy( self.var_27e019fe6697c4a2 );
            var_27e019fe6697c4a2[ playerid ] = [];
            var_27e019fe6697c4a2[ playerid ][ var_27e019fe6697c4a2[ playerid ].size ] = sparams.sweapon;
        }
    }
    else
    {
        a_n_player_damage = self.a_n_player_damage;
        var_27e019fe6697c4a2 = self.var_27e019fe6697c4a2;
    }
    
    foreach ( player in a_n_player_damage )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        telemetry = player.pers[ "telemetry" ];
        telemetry.eliminations++;
        telemetry.elite_eliminations += is_elite_enemy ? 1 : 0;
        telemetry.special_eliminations += is_special_enemy ? 1 : 0;
        telemetry.boss_eliminations += is_boss_enemy ? 1 : 0;
        telemetry.normal_eliminations += is_normal_enemy ? 1 : 0;
        isattacker = attacker === ( player ?? 0 );
        function_f5573694c8f7151e( player, isattacker );
        
        if ( !isattacker )
        {
            player function_66391f59b8a839e8( self );
        }
        
        playerid = player getentitynumber();
        
        if ( !is_hellhound_molotov_kill && isdefined( var_27e019fe6697c4a2[ playerid ] ) && var_27e019fe6697c4a2[ playerid ].size )
        {
            foreach ( weapon in var_27e019fe6697c4a2[ playerid ] )
            {
                if ( !isnullweapon( weapon ) )
                {
                    player function_834838e020f72470( weapon, 0, is_special_enemy );
                    is_pap_weapon = player is_pap_weapon( weapon );
                    var_93c23a92e9c63625 = player is_weapon_rarity( weapon, 4 );
                    telemetry.pap_weapon_elims += is_pap_weapon ? 1 : 0;
                    telemetry.legendary_weapon_elims += var_93c23a92e9c63625 ? 1 : 0;
                    telemetry_data = get_weapon_telemetry_data( weapon );
                    telemetry::function_6367d060fde50007( telemetry_data, "agent_eliminations", 1 );
                    var_fd561439a0bb840d = 0;
                    
                    if ( function_119afdf13342bcae( weapon ) )
                    {
                        var_fd561439a0bb840d = 3;
                    }
                    else if ( isdefined( telemetry_data.group ) )
                    {
                        switch ( telemetry_data.group )
                        {
                            case #"hash_bef5ec0b3e197ae":
                            case #"hash_16cf6289ab06bd30":
                            case #"hash_34340d457a63e7f1":
                            case #"hash_47368bc0d2ef1565":
                            case #"hash_8af0086b038622b5":
                            case #"hash_ab10f9c080fe4faf":
                            case #"hash_c095d67337b1f5a1":
                            case #"hash_cd7f87dc1cdeaa54":
                                var_fd561439a0bb840d = 3;
                                break;
                            case #"hash_9d18adab1b65a661":
                                var_fd561439a0bb840d = 1;
                                break;
                            case #"hash_2535634d8bb5c955":
                                var_fd561439a0bb840d = 29;
                                break;
                            default:
                                break;
                        }
                    }
                    
                    if ( is_pap_weapon && var_fd561439a0bb840d & 1 )
                    {
                        telemetry::function_6367d060fde50007( telemetry_data, "pap_eliminations", 1 );
                    }
                    
                    if ( var_93c23a92e9c63625 && var_fd561439a0bb840d & 2 )
                    {
                        telemetry::function_6367d060fde50007( telemetry_data, "legendary_eliminations", 1 );
                    }
                    
                    if ( is_special_enemy && var_fd561439a0bb840d & 4 )
                    {
                        telemetry::function_6367d060fde50007( telemetry_data, "special_eliminations", 1 );
                    }
                    
                    if ( is_elite_enemy && var_fd561439a0bb840d & 8 )
                    {
                        telemetry::function_6367d060fde50007( telemetry_data, "elite_eliminations", 1 );
                    }
                    
                    if ( is_boss_enemy && var_fd561439a0bb840d & 16 )
                    {
                        telemetry::function_6367d060fde50007( telemetry_data, "boss_eliminations", 1 );
                    }
                    
                    if ( isdefined( telemetry_data.statupdates ) && telemetry_data.statupdates.size )
                    {
                        player update_weapon_stats( telemetry_data );
                    }
                }
            }
        }
    }
    
    attacker function_43abe65717792893( self, sparams, is_brainrotted_kill );
    
    if ( var_b0584ef866f9e82 )
    {
        if ( var_3cfad46c36210201 )
        {
            function_c7fef6c6e1d8efe9( { #inflictor:sparams.einflictor, #attacker:attacker, #victim:self } );
        }
        
        return;
    }
    
    is_critical_kill = 0;
    
    if ( isdefined( self.last_dmg_struct ) )
    {
        if ( self.last_dmg_struct.biscritical || self.var_1480bf6f03b7e0be.biscritical )
        {
            attacker.pers[ "telemetry" ].critical_kills++;
            is_critical_kill = 1;
            
            if ( !is_hellhound_molotov_kill && isdefined( sparams.sweapon ) && !isnullweapon( sparams.sweapon ) )
            {
                attacker function_834838e020f72470( sparams.sweapon, 1 );
            }
            
            if ( self.last_dmg_struct.var_ac6da6d4896af068 )
            {
                attacker callback::callback( "perk_stats_track", { #highest_critical_damage:self.last_dmg_struct.idamage, #stats:"critical_kills", #var_ffc1674def575bfa:"specialty_deadshot" } );
            }
        }
        else
        {
            attacker.pers[ "telemetry" ].non_critical_kills++;
        }
    }
    
    if ( sparams.smeansofdeath == "MOD_MELEE" )
    {
        attacker function_ff7549c2f477fdec( self );
    }
    
    attacker function_84059f6fafa8103e( sparams );
    attacker function_8db5dd88389306f1();
    attacker function_8838716c2c847527( sparams );
    attacker function_930c80156fab6f8( sparams );
    
    if ( isdefined( sparams.sweapon ) && !isnullweapon( sparams.sweapon ) )
    {
        if ( is_hellhound_molotov_kill )
        {
            return;
        }
        
        function_31c8a2ca329ed197( { #weapon:sparams.sweapon, #attacker:attacker, #victim:self } );
        weapon = sparams.sweapon;
        weapongroup = weapon::getweapongroup( weapon );
        victimstruct = spawnstruct();
        victimstruct.var_d3a7b3f093df2ff1 = self.var_d3a7b3f093df2ff1;
        victimstruct.var_e26538d32bf084ea = gettime();
        
        if ( function_75bc0d7afac9c681( victimstruct, weapon, sparams.smeansofdeath, gettime(), weapongroup ) )
        {
            attacker.pers[ "telemetry" ].one_shot_kills++;
        }
        
        telemetry_data = get_weapon_telemetry_data( weapon );
        var_fd561439a0bb840d = 32;
        
        if ( !function_119afdf13342bcae( weapon ) && isdefined( weapongroup ) )
        {
            switch ( weapongroup )
            {
                case #"hash_bef5ec0b3e197ae":
                case #"hash_16cf6289ab06bd30":
                case #"hash_34340d457a63e7f1":
                case #"hash_47368bc0d2ef1565":
                case #"hash_8af0086b038622b5":
                case #"hash_ab10f9c080fe4faf":
                case #"hash_c095d67337b1f5a1":
                case #"hash_cd7f87dc1cdeaa54":
                    var_fd561439a0bb840d |= 64;
                    break;
                case #"hash_9d18adab1b65a661":
                    var_fd561439a0bb840d |= 1024;
                    break;
                case #"hash_86b11ac21f992552":
                case #"hash_a1f27f97be15d620":
                    var_fd561439a0bb840d |= 896;
                    break;
                case #"hash_2535634d8bb5c955":
                    var_fd561439a0bb840d |= 1024;
                    break;
                default:
                    break;
            }
        }
        
        if ( var_fd561439a0bb840d & 32 )
        {
            telemetry::function_6367d060fde50007( telemetry_data, "kills", 1 );
        }
        
        if ( is_critical_kill && var_fd561439a0bb840d & 64 )
        {
            telemetry::function_6367d060fde50007( telemetry_data, "critical_kills", 1 );
        }
        
        if ( self.var_ff03aca8518f1161 && var_fd561439a0bb840d & 1024 )
        {
            telemetry::function_6367d060fde50007( telemetry_data, "gibs", 1 );
        }
        
        if ( is_special_enemy && var_fd561439a0bb840d & 128 )
        {
            telemetry::function_6367d060fde50007( telemetry_data, "special_kills", 1 );
        }
        
        if ( is_elite_enemy && var_fd561439a0bb840d & 256 )
        {
            telemetry::function_6367d060fde50007( telemetry_data, "elite_kills", 1 );
        }
        
        if ( is_boss_enemy && var_fd561439a0bb840d & 512 )
        {
            telemetry::function_6367d060fde50007( telemetry_data, "boss_kills", 1 );
        }
        
        function_ecb08689b89b3df5( { #inflictor:sparams.einflictor, #telemetry_data:telemetry_data, #weapon:weapon, #attacker:attacker, #victim:self } );
        
        if ( isdefined( telemetry_data.statupdates ) && telemetry_data.statupdates.size )
        {
            attacker update_weapon_stats( telemetry_data );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xbbdc6526, Offset: 0xc032
// Size: 0x87
function private get_weapon_telemetry_data( weapon )
{
    telemetry_data = {};
    telemetry_data.weaponname = weapon::getweaponrootname( weapon );
    telemetry_data.fullweaponname = getcompleteweaponname( weapon );
    telemetry_data.variantid = getweaponvariantindex( weapon );
    telemetry_data.weaponobj = weapon;
    weapongroup = weapon::getweapongroup( weapon );
    
    if ( isdefined( weapongroup ) )
    {
        telemetry_data.group = weapongroup;
    }
    
    return telemetry_data;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xea72fb39, Offset: 0xc0c2
// Size: 0x40, Type: bool
function private function_119afdf13342bcae( weapon )
{
    weaponrootname = weapon::getweaponrootname( weapon );
    return weaponrootname == "t10_sn_p08_ultiger" || weaponrootname == "t10_pi_p14_mable" || weaponrootname == "t10_pi_p13_usugar9";
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xb670ea78, Offset: 0xc10b
// Size: 0x46, Type: bool
function private is_pap_weapon( weapon )
{
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) )
    {
        var_951c89546ec50477 = namespace_9d8e359c3b1041e5::function_1d4087075103b248( weapon );
        
        if ( var_951c89546ec50477 > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x19f31c1b, Offset: 0xc15a
// Size: 0x2d, Type: bool
function private is_weapon_rarity( weapon, var_1ae6ccd39356a608 )
{
    rarity = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( weapon );
    return rarity == var_1ae6ccd39356a608;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x62473a6d, Offset: 0xc190
// Size: 0xda
function private function_66e4331d67455370( params )
{
    player = params.player;
    rapidkill_type = params.rapidkill_type;
    rapidkill_count = params.rapidkill_count;
    weapon = params.weapon;
    
    if ( !( isdefined( player ) && isdefined( weapon ) ) || params.rapidkill_count != 5 )
    {
        return;
    }
    
    if ( isstring( weapon ) && weapon == "none" )
    {
        return;
    }
    
    if ( isnullweapon( weapon ) )
    {
        return;
    }
    
    if ( function_683c99957f26b33f( rapidkill_type, weapon ) )
    {
        telemetry_data = get_weapon_telemetry_data( weapon );
        telemetry::function_6367d060fde50007( telemetry_data, "multi_kills", 1 );
        player update_weapon_stats( telemetry_data );
    }
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x2971bbfb, Offset: 0xc272
// Size: 0x52
function private function_683c99957f26b33f( rapidkill_type, weapon )
{
    record_multi_kills = 0;
    
    if ( !weapon::isweaponequipment( weapon ) )
    {
        if ( rapidkill_type != "primary" )
        {
            return;
        }
        
        record_multi_kills = 1;
    }
    else if ( rapidkill_type == "combataxe_single_throw" )
    {
        record_multi_kills = 1;
    }
    
    return record_multi_kills;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x4b15254b, Offset: 0xc2cd
// Size: 0x16e
function private function_b5108f2aac060a9f( params )
{
    player = params.player;
    rapidkill_type = params.rapidkill_type;
    rapidkill_count = params.rapidkill_count;
    weapon = params.rapidkill_weapon;
    
    if ( !isdefined( player.pers[ "weaponStats" ] ) )
    {
        return;
    }
    
    if ( !( isdefined( player ) && isdefined( weapon ) ) || rapidkill_count < 5 )
    {
        return;
    }
    
    if ( isstring( weapon ) && weapon == "none" )
    {
        return;
    }
    
    if ( isnullweapon( weapon ) )
    {
        return;
    }
    
    if ( !function_683c99957f26b33f( rapidkill_type, weapon ) )
    {
        return;
    }
    
    if ( weapon::iskillstreakweapon( weapon ) || vehicle::isvehicleweapon( weapon ) || weapon::isfistsonly( weapon ) )
    {
        return;
    }
    
    weaponname = weapon::getweaponrootname( weapon );
    
    if ( !isdefined( player.pers[ "weaponStats" ][ weaponname ] ) )
    {
        return;
    }
    
    weaponstats = player.pers[ "weaponStats" ][ weaponname ];
    
    if ( !isdefined( weaponstats.stats[ "highest_multi_kills" ] ) || weaponstats.stats[ "highest_multi_kills" ] < rapidkill_count )
    {
        weaponstats.stats[ "highest_multi_kills" ] = rapidkill_count;
    }
}

// Namespace zm_telemetry
// Params 5
// Checksum 0xa50b46cf, Offset: 0xc443
// Size: 0xb3, Type: bool
function function_75bc0d7afac9c681( victimstruct, objweapon, meansofdeath, curtime, weapongroup )
{
    if ( weapongroup == "other" || weapongroup == "weapon_projectile" )
    {
        return false;
    }
    
    if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_EXPLOSIVE" )
    {
        return false;
    }
    
    if ( isdefined( victimstruct.var_d3a7b3f093df2ff1 ) && isdefined( victimstruct.var_e26538d32bf084ea ) )
    {
        timediff = abs( victimstruct.var_d3a7b3f093df2ff1 - victimstruct.var_e26538d32bf084ea );
        
        if ( timediff <= 25 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0xd9f9f17b, Offset: 0xc4ff
// Size: 0x2f0
function private function_f5573694c8f7151e( player, isattacker )
{
    telemetry = player.pers[ "telemetry" ];
    
    if ( isattacker )
    {
        telemetry.kills++;
    }
    else
    {
        telemetry.assists++;
    }
    
    if ( !isdefined( self.subclass ) )
    {
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_base_armored_light" ) )
    {
        telemetry.light_armor_zombie_eliminations++;
        
        if ( isattacker )
        {
            telemetry.light_armor_zombie_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_base_armored_heavy" ) )
    {
        telemetry.heavy_armor_zombie_eliminations++;
        
        if ( isattacker )
        {
            telemetry.heavy_armor_zombie_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_base" ) || issubstr( self.subclass, "zombie_groundskeeper" ) )
    {
        telemetry.base_zombie_eliminations++;
        
        if ( isattacker )
        {
            telemetry.base_zombie_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_vermin" ) )
    {
        telemetry.vermin_eliminations++;
        
        if ( isattacker )
        {
            telemetry.vermin_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_abom" ) )
    {
        telemetry.abomination_eliminations++;
        
        if ( isattacker )
        {
            telemetry.abomination_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_mangler" ) )
    {
        telemetry.mangler_eliminations++;
        
        if ( isattacker )
        {
            telemetry.mangler_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_parasite" ) )
    {
        telemetry.parasite_eliminations++;
        
        if ( isattacker )
        {
            telemetry.parasite_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_amalgam" ) )
    {
        telemetry.amalgam_eliminations++;
        
        if ( isattacker )
        {
            telemetry.amalgam_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_ghoul" ) )
    {
        telemetry.ghoul_eliminations++;
        
        if ( isattacker )
        {
            telemetry.ghoul_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_mimic" ) )
    {
        telemetry.mimic_eliminations++;
        
        if ( isattacker )
        {
            telemetry.mimic_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_disciple" ) )
    {
        telemetry.disciple_eliminations++;
        
        if ( isattacker )
        {
            telemetry.disciple_kills++;
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_boss_kala" ) )
    {
        telemetry.boss_kala_eliminations++;
        
        if ( isattacker )
        {
            telemetry.boss_kala_kills++;
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xb56d5774, Offset: 0xc7f7
// Size: 0x167
function private on_main_quest_complete( params )
{
    complete_time_ms = params.timestamp ?? gettime();
    start_time_ms = game[ "telemetry" ].start_time_ms ?? 0;
    quest_complete_time_ms = complete_time_ms - start_time_ms;
    a_players = params.var_be82617e5e8087bd ?? level.players;
    
    foreach ( player in a_players )
    {
        if ( !isplayer( player ) )
        {
            return;
        }
        
        mq_progress_time_ms = player.pers[ "telemetry" ].var_efd960f3c3cf6f19.mq_progress_time_ms ?? 0;
        player.pers[ "telemetry" ].mq_complete_time_ms = quest_complete_time_ms + mq_progress_time_ms;
        player.pers[ "telemetry" ].mq_completed = 1;
    }
    
    level record_boss_fight( 1, complete_time_ms );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xa41307fb, Offset: 0xc966
// Size: 0x93
function private zm_mq_final_fight_start( params )
{
    if ( isdefined( game[ "telemetry" ] ) )
    {
        info_struct = zm_telemetry_info_struct();
        game[ "telemetry" ].var_c39fae9beec212b5 = params.timestamp ?? gettime();
        game[ "telemetry" ].var_d58b4a901671e4c = info_struct.round_number;
        game[ "telemetry" ].boss_subclass = getxhash( params.boss_subclass ?? "" );
    }
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0x750f3513, Offset: 0xca01
// Size: 0x1be
function private record_boss_fight( succeeded, complete_time_ms, end_reason )
{
    if ( !isdefined( game[ "telemetry" ].var_c39fae9beec212b5 ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    
    if ( end_reason == game[ "end_reason" ][ "mp_faction_eliminated" ] )
    {
        boss_fight_result = 3;
    }
    else
    {
        boss_fight_result = succeeded ? 1 : 2;
    }
    
    complete_time = complete_time_ms ?? gettime();
    duration = complete_time - game[ "telemetry" ].var_c39fae9beec212b5;
    dlog_recordevent( "dlog_event_zm_boss_fight", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "start_time_ms", game[ "telemetry" ].var_c39fae9beec212b5, "round_number", game[ "telemetry" ].var_d58b4a901671e4c ?? 1, "boss_fight_result", boss_fight_result, "boss_fight_duration_ms", duration, "boss_subclass", game[ "telemetry" ].boss_subclass ?? #"" ] );
    game[ "telemetry" ].var_c39fae9beec212b5 = undefined;
    game[ "telemetry" ].var_d58b4a901671e4c = undefined;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x698fc739, Offset: 0xcbc7
// Size: 0x4e
function private function_5500181132dcbc51( currency )
{
    if ( !isstring( currency ) )
    {
        return 0;
    }
    
    switch ( currency )
    {
        case #"essence":
            return 1;
        case #"salvage":
            return 2;
        default:
            return 0;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x3f4cde1c, Offset: 0xcc1d
// Size: 0x16
function private on_doorbuy_contributed( params )
{
    purchase_doorbuy( params, 0 );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x655e3913, Offset: 0xcc3b
// Size: 0x17
function private on_doorbuy_bought( params )
{
    purchase_doorbuy( params, 1 );
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0xcb83d053, Offset: 0xcc5a
// Size: 0x1a2
function private purchase_doorbuy( params, purchase_type )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    client_uno_id = self getplayerunoid();
    cost = params.cost ?? 0;
    currency = function_5500181132dcbc51( params.currency );
    doorbuy_origin = params.doorbuy_origin ?? ( 0, 0, 0 );
    dlog_recordevent( "dlog_event_zm_door_buy_purchased", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "client_uno_id", client_uno_id, "purchase_cost", cost, "currency", currency, "pos_x", doorbuy_origin[ 0 ], "pos_y", doorbuy_origin[ 1 ], "pos_z", doorbuy_origin[ 2 ], "purchase_type", purchase_type ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xb1fb1fba, Offset: 0xce04
// Size: 0x73
function private on_player_damaged( params )
{
    attacker = params.eattacker;
    
    if ( isagent( attacker ) && isdefined( attacker.zm_ai_stats ) )
    {
        attacker.zm_ai_stats.damage_dealt += params.idamage;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x432c490f, Offset: 0xce7f
// Size: 0x160
function private function_b0f8cce4da821455( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    reason = params.reason ?? #"";
    self_revive = params.selfrevive ?? 0;
    super_revive = params.superrevive ?? 0;
    
    if ( !isxhash( reason ) )
    {
        reason = getxhash( reason );
    }
    
    dlog_recordevent( "dlog_event_zm_player_revived", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "reason", reason, "self_revive", self_revive, "super_revive", super_revive ] );
    record_player_death( 0, 0, 1 );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x359d30dc, Offset: 0xcfe7
// Size: 0x250
function private on_magicbox_purchase( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    client_uno_id = self getplayerunoid();
    is_score_streak = params.var_4e0aa9a7c35d4dce == 1;
    item_name = isdefined( params.itembundle.ref ) ? getxhash( params.itembundle.ref ) : #"";
    item_id = params.lootid ?? 0;
    rarity = params.itembundle.rarity ?? 0;
    cost = params.cost ?? 0;
    currency = function_5500181132dcbc51( params.currency );
    origin = self.origin;
    dlog_recordevent( "dlog_event_zm_magic_box_purchased", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "client_uno_id", client_uno_id, "is_score_streak", is_score_streak, "item_name", item_name, "item_id", item_id, "rarity", rarity, "purchase_cost", cost, "currency", currency, "pos_x", origin[ 0 ], "pos_y", origin[ 1 ], "pos_z", origin[ 2 ] ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xeae86038, Offset: 0xd23f
// Size: 0x266
function private on_pack_a_punch_weapon( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    client_uno_id = self getplayerunoid();
    pap_level = params.var_951c89546ec50477 ?? 0;
    cost = params.cost ?? 0;
    currency = function_5500181132dcbc51( params.currency );
    origin = self.origin;
    weapon_name = #"";
    alt_weapon = #"";
    
    if ( isdefined( params.var_101633ed971732ba ) )
    {
        weapon_name = weapon::getweaponrootname( params.var_101633ed971732ba );
        weapon_name = weapon_name != "" ? getxhash( weapon_name ) : #"";
    }
    
    if ( isdefined( params.w_new_alt ) )
    {
        alt_weapon = weapon::getweaponrootname( params.w_new_alt );
        alt_weapon = alt_weapon != "" ? getxhash( alt_weapon ) : #"";
    }
    
    dlog_recordevent( "dlog_event_zm_pack_a_punch", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "client_uno_id", client_uno_id, "weapon", weapon_name, "alt_weapon", alt_weapon, "pap_level", pap_level, "purchase_cost", cost, "currency", currency, "pos_x", origin[ 0 ], "pos_y", origin[ 1 ], "pos_z", origin[ 2 ] ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xd6b70a72, Offset: 0xd4ad
// Size: 0x1bd
function private on_trap_purchase( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    client_uno_id = self getplayerunoid();
    trap_name = isdefined( params.trap_name ) ? getxhash( params.trap_name ) : #"";
    cost = params.cost ?? 0;
    currency = function_5500181132dcbc51( params.currency );
    origin = params.position;
    dlog_recordevent( "dlog_event_zm_trap_purchased", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "client_uno_id", client_uno_id, "trap_name", trap_name, "purchase_cost", cost, "currency", currency, "pos_x", origin[ 0 ], "pos_y", origin[ 1 ], "pos_z", origin[ 2 ] ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xe0d5f828, Offset: 0xd672
// Size: 0x9c
function private function_7dab4f86803b3e25( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_4c952907fca5f153 = utility::getsharedfunc( #"intel", #"hash_ae79a668b3bc0aeb" );
    
    if ( !var_4c952907fca5f153 )
    {
        script::demoforcesre( "No shared function defined for sending 'collected Zombie Intel' dlog, this event will be dropped!" );
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    [[ var_4c952907fca5f153 ]]( self, params, info_struct.map_name, info_struct.game_type, info_struct.playlist_id, info_struct.playlist_name, info_struct.time );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x2ecfce28, Offset: 0xd716
// Size: 0x312
function private update_weapon_stats( data )
{
    if ( isdefined( data.statname ) && isdefined( data.incvalue ) )
    {
        assertmsg( "<dev string:x45a>" );
        telemetry::function_6367d060fde50007( data, data.statname, data.incvalue );
    }
    
    currenttime = telemetry_utils::get_time_from_match_start( data.stattime ?? gettime() );
    
    if ( isnullweapon( data.weaponobj ) )
    {
        assertmsg( "<dev string:x4bf>" );
        return;
    }
    
    if ( currenttime <= 0 && ( !isdefined( self.loadoutindex ) || self.loadoutindex == -1 ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "weaponStats" ] ) )
    {
        return;
    }
    
    if ( weapon::iskillstreakweapon( data.weaponobj ?? data.weaponname ) || vehicle::isvehicleweapon( data.weaponobj ?? data.weaponname ) || weapon::isfistsonly( data.weaponobj ?? data.weaponname ) )
    {
        return;
    }
    
    if ( isdefined( data.weaponobj ) )
    {
        var_a836626b3eb16832 = weapon::getweaponrootname( data.weaponobj );
    }
    else
    {
        var_a836626b3eb16832 = weapon::getweaponrootname( data.weaponname );
    }
    
    weaponstats = self.pers[ "weaponStats" ];
    
    if ( !isdefined( weaponstats[ var_a836626b3eb16832 ] ) )
    {
        var_e6f236e7660502a6 = getdvarint( @"hash_817f686503ccdecf", 5 );
        
        if ( weaponstats.size >= var_e6f236e7660502a6 )
        {
            record_count = function_abf3fae8f87a753f( self );
            
            if ( record_count == weaponstats.size )
            {
                self.pers[ "weaponStats" ] = [];
            }
            
            foreach ( key, datastruct in self.pers[ "weaponStats" ] )
            {
                if ( datastruct.var_4facc5510da9cbee )
                {
                    self.pers[ "weaponStats" ][ key ] = undefined;
                }
            }
        }
        
        createweaponstats( var_a836626b3eb16832, data );
        weaponstats = self.pers[ "weaponStats" ];
    }
    else if ( isdefined( data.weaponobj ) && ( !isdefined( weaponstats[ var_a836626b3eb16832 ].weaponobj ) || data.weaponobj != weaponstats[ var_a836626b3eb16832 ].weaponobj ) )
    {
        weaponstats[ var_a836626b3eb16832 ].weaponobj = data.weaponobj;
    }
    
    weaponstatscontainer = weaponstats[ var_a836626b3eb16832 ];
    telemetry::function_25f6c2a46443f597( data, weaponstatscontainer );
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0xfb2e6de9, Offset: 0xda30
// Size: 0x217
function private createweaponstats( var_a836626b3eb16832, data )
{
    var_9499c7cbd4b3f5d1 = self isdualwielding() == 1;
    
    if ( isdefined( data.weaponobj ) )
    {
        var_9499c7cbd4b3f5d1 = self function_1ea59633649ae3dd( data.weaponobj );
    }
    else if ( isdefined( data.fullweaponname ) )
    {
        var_9499c7cbd4b3f5d1 = self function_1ea59633649ae3dd( data.fullweaponname );
    }
    
    weaponobj = data.weaponobj;
    isequipment = data.isequipment;
    
    if ( !isdefined( isequipment ) )
    {
        if ( isdefined( weaponobj ) )
        {
            isequipment = weapon::isweaponequipment( weaponobj );
        }
        else
        {
            weaponname = strtok( data.fullweaponname, "+" )[ 0 ];
            ref = equipment_mp::function_fdc4a655fbde0dec( weaponname );
            isequipment = isdefined( ref );
            
            if ( isequipment )
            {
                weaponobj = equipment_mp::getweaponfromequipmentref( ref );
            }
        }
    }
    
    var_298ce6d21dbc7049 = telemetry_utils::is_valid_client( self ) ? isdefined( weaponobj ) ? weapon::ispickedupweapon( weaponobj ) : 0 : 0;
    newloadoutindex = isdefined( self.loadoutindex ) && !var_298ce6d21dbc7049 ? self.loadoutindex : -1;
    self.pers[ "weaponStats" ][ var_a836626b3eb16832 ] = { #isequipment:isequipment, #fullweaponname:data.fullweaponname, #isdualwielding:var_9499c7cbd4b3f5d1, #variantid:data.variantid ?? -1, #weaponobj:weaponobj, #ispickedup:var_298ce6d21dbc7049, #loadoutindex:newloadoutindex, #weapon:var_a836626b3eb16832, #stats:[] };
    
    if ( isdefined( weaponobj ) )
    {
        weapongroup = weapon::getweapongroup( weaponobj );
        
        if ( isdefined( weapongroup ) )
        {
            self.pers[ "weaponStats" ][ var_a836626b3eb16832 ].group = weapongroup;
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x697bd04f, Offset: 0xdc4f
// Size: 0x142
function private function_abf3fae8f87a753f( player )
{
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return 0;
    }
    
    if ( isbot( player ) || istestclient( player ) || isai( player ) )
    {
        return 0;
    }
    
    weaponstats = player.pers[ "weaponStats" ];
    record_count = 0;
    
    foreach ( datastruct in weaponstats )
    {
        var_4facc5510da9cbee = function_5a6d4232d59c729a( player, datastruct );
        var_4facc5510da9cbee |= function_ef8941386866e7c8( player, datastruct );
        
        if ( var_4facc5510da9cbee )
        {
            record_count++;
            datastruct.var_4facc5510da9cbee = var_4facc5510da9cbee;
        }
        
        if ( var_4facc5510da9cbee && isdefined( player.pers[ "telemetry" ].var_6ac2c6490dd67adc ) )
        {
            player.pers[ "telemetry" ].var_6ac2c6490dd67adc++;
        }
    }
    
    return record_count;
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x7daef362, Offset: 0xdd9a
// Size: 0x47b, Type: bool
function private function_5a6d4232d59c729a( player, datastruct )
{
    if ( datastruct.isequipment )
    {
        return false;
    }
    
    info_struct = zm_telemetry_info_struct();
    weapon_root_name = datastruct.weapon;
    weapon_hash = weapon_root_name != "" ? getxhash( weapon_root_name ) : #"";
    agent_eliminations = datastruct.stats[ "agent_eliminations" ] ?? 0;
    prestige_level = player get_prestige();
    
    if ( agent_eliminations == 0 )
    {
        return true;
    }
    
    weapon_group = isdefined( datastruct.group ) ? getxhash( datastruct.group ) : #"";
    pap_eliminations = datastruct.stats[ "pap_eliminations" ] ?? 0;
    legendary_eliminations = datastruct.stats[ "legendary_eliminations" ] ?? 0;
    special_eliminations = datastruct.stats[ "special_eliminations" ] ?? 0;
    elite_eliminations = datastruct.stats[ "elite_eliminations" ] ?? 0;
    boss_eliminations = datastruct.stats[ "boss_eliminations" ] ?? 0;
    kills = datastruct.stats[ "kills" ] ?? 0;
    critical_kills = datastruct.stats[ "critical_kills" ] ?? 0;
    multi_kills = datastruct.stats[ "multi_kills" ] ?? 0;
    special_kills = datastruct.stats[ "special_kills" ] ?? 0;
    elite_kills = datastruct.stats[ "elite_kills" ] ?? 0;
    boss_kills = datastruct.stats[ "boss_kills" ] ?? 0;
    gibs = datastruct.stats[ "gibs" ] ?? 0;
    highest_multi_kills = datastruct.stats[ "highest_multi_kills" ] ?? 0;
    var_da6175121f0769cb = player dlog_recordplayerevent( "dlog_event_zm_player_weapon_stats", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "weapon", weapon_hash, "weapon_group", weapon_group, "eliminations", agent_eliminations, "pap_eliminations", pap_eliminations, "legendary_eliminations", legendary_eliminations, "special_eliminations", special_eliminations, "elite_eliminations", elite_eliminations, "boss_eliminations", boss_eliminations, "kills", kills, "critical_kills", critical_kills, "multi_kills", multi_kills, "special_kills", special_kills, "elite_kills", elite_kills, "boss_kills", boss_kills, "gibs", gibs, "is_ranked", info_struct.is_ranked, "season", info_struct.season, "prestige_level", prestige_level, "weapon_base", weapon_hash, "is_a_weapon", 1, "highest_multi_kills", highest_multi_kills ] );
    
    if ( isdefined( player.pers[ "telemetry" ].player_weapon_stats_count ) && var_da6175121f0769cb )
    {
        player.pers[ "telemetry" ].player_weapon_stats_count++;
    }
    
    return true;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x85144148, Offset: 0xe21e
// Size: 0x54
function private function_ecb08689b89b3df5( data )
{
    function_4e50b50cdbf5746d( data );
    function_fc2facc692b7f938( data );
    function_ca2ec5a3d59ddc7d( data );
    function_15c2f75612e8679( data );
    function_d2b8cb41bc78ed03( data );
    function_bea4261e169abc62( data );
    function_ae93b82eaed571ce( data );
    function_1f212ccf5d7d594d( data );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xb8707dcd, Offset: 0xe27a
// Size: 0x2d9
function private function_4e50b50cdbf5746d( data )
{
    if ( !data.victim.ishaywire || !isdefined( data.victim.var_81b406cea4293e1d ) )
    {
        return;
    }
    
    victim = data.victim;
    attacker = data.attacker;
    weapon = data.weapon;
    var_81b406cea4293e1d = data.victim.var_81b406cea4293e1d;
    shockstick_assists = [];
    
    foreach ( shockstick in var_81b406cea4293e1d )
    {
        if ( !shockstick.isequipment || shockstick.equipmentref != "equip_shockstick" )
        {
            continue;
        }
        
        if ( shockstick.owner === attacker )
        {
            stats_added = 0;
            
            if ( isdefined( weapon ) && weapon::isweaponequipment( weapon ) )
            {
                equipmentref = weapon.equipmentref ?? equipment_mp::getequipmentreffromweapon( weapon );
                
                if ( equipmentref == "equip_shockstick" )
                {
                    telemetry::function_6367d060fde50007( data.telemetry_data, "electrocuted_kills", 1 );
                    stats_added = 1;
                }
            }
            
            if ( !stats_added && isdefined( shockstick.weapon_name ) )
            {
                telemetry_data = get_equipment_telemetry_data( shockstick.weapon_name, shockstick.weapon_object );
                telemetry::function_6367d060fde50007( telemetry_data, "electrocuted_kills", 1 );
                attacker update_weapon_stats( telemetry_data );
            }
            
            continue;
        }
        
        if ( isplayer( shockstick.owner ) && isdefined( shockstick.weapon_name ) )
        {
            shockstick_assists[ shockstick_assists.size ] = shockstick;
        }
    }
    
    if ( shockstick_assists.size )
    {
        foreach ( shockstick in shockstick_assists )
        {
            telemetry_data = get_equipment_telemetry_data( shockstick.weapon_name, shockstick.weapon_object );
            telemetry::function_6367d060fde50007( telemetry_data, "electrocuted_assists", 1 );
            shockstick.owner update_weapon_stats( telemetry_data );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x6e1509d4, Offset: 0xe55b
// Size: 0x85
function private function_fc2facc692b7f938( data )
{
    if ( !isdefined( data.attacker.smoke_end_time ) )
    {
        return;
    }
    
    attacker = data.attacker;
    weapon = equipment_mp::getweaponfromequipmentref( "equip_smoke" );
    
    if ( isdefined( weapon ) )
    {
        telemetry_data = get_weapon_telemetry_data( weapon );
        telemetry::function_6367d060fde50007( telemetry_data, "smoke_kills", 1 );
        attacker update_weapon_stats( telemetry_data );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x52d404f0, Offset: 0xe5e8
// Size: 0x221
function private function_ca2ec5a3d59ddc7d( data )
{
    /#
        debug_print = getdvarint( @"hash_f12f6f51a952373d", 0 );
    #/
    
    if ( !isdefined( data.victim.target_attractor.source ) )
    {
        /#
            if ( debug_print )
            {
                println( "<dev string:x531>" );
            }
        #/
        
        return;
    }
    
    source = data.victim.target_attractor.source;
    
    /#
        if ( debug_print )
        {
            var_49701458407d4208 = source getentitynumber();
            message = "<dev string:x574>" + var_49701458407d4208 + "<dev string:x3d5>";
        }
    #/
    
    if ( source.equipmentref === "equip_decoy" && isplayer( source.owner ) )
    {
        var_58339bdc70cf38fa = source.owner === data.attacker ? "distracted_kills" : "distracted_assists";
        weapon = undefined;
        
        /#
            if ( debug_print )
            {
                println( message + "<dev string:x5aa>" + var_58339bdc70cf38fa );
            }
        #/
        
        if ( isdefined( source.weapon_object ) )
        {
            weapon = source.weapon_object;
        }
        else
        {
            weapon = equipment_mp::getweaponfromequipmentref( "equip_decoy" );
        }
        
        if ( isdefined( weapon ) )
        {
            telemetry_data = get_weapon_telemetry_data( weapon );
            telemetry::function_6367d060fde50007( telemetry_data, var_58339bdc70cf38fa, 1 );
            source.owner update_weapon_stats( telemetry_data );
        }
        else
        {
            /#
                if ( debug_print )
                {
                    println( message + "<dev string:x5b6>" );
                }
            #/
        }
        
        return;
    }
    
    /#
        if ( debug_print )
        {
            if ( source.equipmentref == "<dev string:x5d2>" )
            {
                msg = "<dev string:x5de>";
                
                if ( !source.owner )
                {
                    msg = "<dev string:x5ea>";
                }
                else if ( !isplayer( source.owner ) )
                {
                    msg = "<dev string:x5f7>";
                }
                
                println( message + "<dev string:x607>" + msg );
            }
        }
    #/
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xfded70ac, Offset: 0xe811
// Size: 0x16c
function private function_15c2f75612e8679( data )
{
    victim = data.victim;
    
    if ( !isdefined( victim.var_1c715bf5ac0aa638 ) || !victim status_effects::has_status_effect_type( "stun" ) )
    {
        return;
    }
    
    weapon_name = points::function_2f5082d7ee39b1dc( "equip_concussion" );
    weapon = equipment_mp::getweaponfromequipmentref( "equip_concussion" );
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "stun" ] )
    {
        if ( var_c6321cb8cd32b6a0.unique_id === weapon_name && isplayer( var_c6321cb8cd32b6a0.var_1e4624a03ea41715 ) )
        {
            var_58339bdc70cf38fa = var_c6321cb8cd32b6a0.var_1e4624a03ea41715 === data.attacker ? "stunned_kills" : "stunned_assists";
            telemetry_data = get_equipment_telemetry_data( weapon_name, weapon );
            telemetry::function_6367d060fde50007( telemetry_data, var_58339bdc70cf38fa, 1 );
            var_c6321cb8cd32b6a0.var_1e4624a03ea41715 update_weapon_stats( telemetry_data );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xa0bc6d43, Offset: 0xe985
// Size: 0x8f
function private function_d2b8cb41bc78ed03( data )
{
    if ( !data.attacker.adrenalinepoweractive )
    {
        return;
    }
    
    weapon_name = points::function_2f5082d7ee39b1dc( "equip_adrenaline" );
    weapon = equipment_mp::getweaponfromequipmentref( "equip_adrenaline" );
    
    if ( isdefined( weapon_name ) )
    {
        telemetry_data = get_equipment_telemetry_data( weapon_name, weapon );
        telemetry::function_6367d060fde50007( telemetry_data, "stimshot_kills", 1 );
        data.attacker update_weapon_stats( telemetry_data );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x87ac0cea, Offset: 0xea1c
// Size: 0x106
function private function_bea4261e169abc62( data )
{
    if ( !isdefined( data.victim.target_attractor.source ) )
    {
        return;
    }
    
    source = data.victim.target_attractor.source;
    
    if ( source.equipmentref === "equip_monkey_bomb" && isplayer( source.owner ) && !( data.attacker === source.owner ) )
    {
        weapon_name = points::function_2f5082d7ee39b1dc( "equip_monkey_bomb" );
        weapon = equipment_mp::getweaponfromequipmentref( "equip_monkey_bomb" );
        
        if ( isdefined( weapon_name ) )
        {
            telemetry_data = get_equipment_telemetry_data( weapon_name, weapon );
            telemetry::function_6367d060fde50007( telemetry_data, "cm_distracted_assists", 1 );
            source.owner update_weapon_stats( telemetry_data );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x23f11796, Offset: 0xeb2a
// Size: 0xdc
function private function_ae93b82eaed571ce( data )
{
    if ( isdefined( data.victim ) && data.victim vortex::is_pulled() )
    {
        victim = data.victim;
        
        if ( isplayer( victim.vortex_pull_owner ) && !( data.attacker === victim.vortex_pull_owner ) )
        {
            weapon_name = points::function_2f5082d7ee39b1dc( "equip_blackhole_bomb" );
            weapon = equipment_mp::getweaponfromequipmentref( "equip_blackhole_bomb" );
            
            if ( isdefined( weapon_name ) )
            {
                telemetry_data = get_equipment_telemetry_data( weapon_name, weapon );
                telemetry::function_6367d060fde50007( telemetry_data, "pull_assists", 1 );
                victim.vortex_pull_owner update_weapon_stats( telemetry_data );
            }
        }
    }
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0xd5365f35, Offset: 0xec0e
// Size: 0x88
function private get_equipment_telemetry_data( weapon_name, weapon )
{
    telemetry_data = {};
    telemetry_data.weaponname = weapon::getweaponrootname( weapon_name );
    telemetry_data.fullweaponname = weapon_name;
    telemetry_data.weaponobj = weapon;
    telemetry_data.isequipment = 1;
    weapongroup = weapon::getweapongroup( weapon );
    
    if ( isdefined( weapongroup ) )
    {
        telemetry_data.group = weapongroup;
    }
    
    return telemetry_data;
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0xdfb1dad0, Offset: 0xec9f
// Size: 0x504, Type: bool
function private function_ef8941386866e7c8( player, datastruct )
{
    if ( isdefined( datastruct.weapon ) && weapon::issuperweapon( datastruct.weapon ) )
    {
        return false;
    }
    
    if ( !datastruct.isequipment )
    {
        return false;
    }
    
    weaponref = equipment_mp::getequipmentreffromweapon( datastruct.weaponobj );
    
    if ( equipment_mp::function_e4d1f5399e3d9e7a( weaponref ) )
    {
        return false;
    }
    
    if ( !datastruct.weaponobj && datastruct.fullweaponname )
    {
        basename = strtok( datastruct.fullweaponname, "+" )[ 0 ];
        ref = equipment_mp::function_fdc4a655fbde0dec( basename );
        
        if ( ref )
        {
            datastruct.weaponobj = equipment_mp::getweaponfromequipmentref( ref );
        }
    }
    
    if ( !datastruct.weaponobj )
    {
        return false;
    }
    
    if ( points::is_field_upgrade_weapons( datastruct.weaponobj ) )
    {
        return false;
    }
    
    if ( datastruct.stats[ "processing_one_shot_kills" ] > 0 )
    {
        return false;
    }
    
    weapon_name = telemetry_mp::function_730ff856cab87e50( datastruct.weaponobj, 0 );
    
    if ( weapon_name == "invalid_unified_weapon_name" )
    {
        return false;
    }
    
    equipment_name = getxhash( weapon_name );
    kills = datastruct.stats[ "kills" ] ?? 0;
    shots = datastruct.stats[ "shots" ] ?? 0;
    multi_kills = datastruct.stats[ "multi_kills" ] ?? 0;
    electrocuted_kills = datastruct.stats[ "electrocuted_kills" ] ?? 0;
    electrocuted_assists = datastruct.stats[ "electrocuted_assists" ] ?? 0;
    smoke_kills = datastruct.stats[ "smoke_kills" ] ?? 0;
    distracted_kills = datastruct.stats[ "distracted_kills" ] ?? 0;
    distracted_assists = datastruct.stats[ "distracted_assists" ] ?? 0;
    stunned_kills = datastruct.stats[ "stunned_kills" ] ?? 0;
    stunned_assists = datastruct.stats[ "stunned_assists" ] ?? 0;
    stimshot_kills = datastruct.stats[ "stimshot_kills" ] ?? 0;
    cm_distracted_assists = datastruct.stats[ "cm_distracted_assists" ] ?? 0;
    pull_assists = datastruct.stats[ "pull_assists" ] ?? 0;
    prestige_level = player get_prestige();
    highest_kills_per_use = datastruct.stats[ "highest_kills_per_use" ] ?? 0;
    info_struct = zm_telemetry_info_struct();
    var_da6175121f0769cb = player dlog_recordplayerevent( "dlog_event_zm_player_equipment_stats", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "equipment_name", equipment_name, "kills", kills, "shots", shots, "multi_kills", multi_kills, "electrocuted_kills", electrocuted_kills, "electrocuted_assists", electrocuted_assists, "smoke_kills", smoke_kills, "distracted_kills", distracted_kills, "distracted_assists", distracted_assists, "stunned_kills", stunned_kills, "stunned_assists", stunned_assists, "stimshot_kills", stimshot_kills, "cm_distracted_assists", cm_distracted_assists, "pull_assists", pull_assists, "is_ranked", info_struct.is_ranked, "season", info_struct.season, "prestige_level", prestige_level, "highest_kills_per_use", highest_kills_per_use ] );
    
    if ( isdefined( player.pers[ "telemetry" ].player_equipment_stats_count ) && var_da6175121f0769cb )
    {
        player.pers[ "telemetry" ].player_equipment_stats_count++;
    }
    
    return true;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x27d71d51, Offset: 0xf1ac
// Size: 0xaf
function private function_a35bac0965cd088e( params )
{
    if ( !isplayer( self.owner ) )
    {
        return;
    }
    
    if ( !self.weapon_object )
    {
        return;
    }
    
    weaponobj = self.weapon_object;
    weaponrootname = getweaponrootstring( weaponobj );
    
    if ( weaponrootname != "mini_sentry" )
    {
        return;
    }
    
    weaponname = weapon::getweaponrootname( weaponobj );
    life_time = self.bundle.mini_sentry_lifetime ?? 45;
    self.owner thread function_7d8c01fcb0cb0434( params.vehicle, weaponname, life_time );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x3999af3a, Offset: 0xf263
// Size: 0x132
function private on_grenade_fire( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.grenade.weapon_object ) )
    {
        return;
    }
    
    weaponobj = params.grenade.weapon_object;
    weaponname = weapon::getweaponrootname( weaponobj );
    weaponrootname = getweaponrootstring( weaponobj );
    
    if ( weaponname == "none" )
    {
        return;
    }
    
    telemetry_data = get_weapon_telemetry_data( weaponobj );
    telemetry::function_6367d060fde50007( telemetry_data, "processing_one_shot_kills", 1 );
    update_weapon_stats( telemetry_data );
    
    switch ( weaponrootname )
    {
        case #"hash_c9a436974fe60919":
            thread function_3868d5e09e12afb5( params.grenade, weaponname, 10 );
            break;
        case #"hash_e83e513b51626f93":
            thread function_3868d5e09e12afb5( params.grenade, weaponname, 20 );
            break;
        case #"hash_1cd346c1ee356308":
            break;
        default:
            thread watch_grenade_explode( params.grenade, weaponname, weaponrootname );
            break;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xdf209470, Offset: 0xf39d
// Size: 0x7c
function private function_e56966149cd49575( weaponname )
{
    if ( isdefined( self.pers[ "weaponStats" ][ weaponname ].stats[ "processing_one_shot_kills" ] ) )
    {
        if ( self.pers[ "weaponStats" ][ weaponname ].stats[ "processing_one_shot_kills" ] > 0 )
        {
            self.pers[ "weaponStats" ][ weaponname ].stats[ "processing_one_shot_kills" ]--;
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x68c21af6, Offset: 0xf421
// Size: 0x14e
function private function_1f212ccf5d7d594d( params )
{
    if ( !( isdefined( params.weapon ) && isdefined( params.inflictor ) && isdefined( params.attacker ) ) )
    {
        return;
    }
    
    if ( !( weapon::isweaponequipment( params.weapon ) || params.inflictor.isequipment ) )
    {
        return;
    }
    
    if ( !isent( params.inflictor ) || params.inflictor.classname == "worldspawn" )
    {
        return;
    }
    
    player = params.attacker;
    weaponname = weapon::getweaponrootname( params.weapon );
    entnum = params.inflictor getentitynumber();
    telemetry = player.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.equipment_one_shot_kills ) )
    {
        telemetry.equipment_one_shot_kills = [];
    }
    
    if ( !isdefined( telemetry.equipment_one_shot_kills[ entnum ] ) )
    {
        telemetry.equipment_one_shot_kills[ entnum ] = 0;
    }
    
    telemetry.equipment_one_shot_kills[ entnum ]++;
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0x5b9fbd51, Offset: 0xf577
// Size: 0x169
function private function_3868d5e09e12afb5( grenade, weaponname, timeout )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    msg = grenade utility::waittill_any_timeout( 10, "death", "missile_stuck", "missile_water_impact" );
    
    if ( msg != "missile_stuck" )
    {
        function_e56966149cd49575( weaponname );
        return;
    }
    
    entnum = grenade getentitynumber();
    telemetry = self.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.equipment_one_shot_kills ) )
    {
        telemetry.equipment_one_shot_kills = [];
    }
    
    telemetry.equipment_one_shot_kills[ entnum ] = 0;
    grenade utility::waittill_notify_or_timeout( "entitydeleted", timeout );
    weaponstats = self.pers[ "weaponStats" ][ weaponname ];
    one_shot_kills = telemetry.equipment_one_shot_kills[ entnum ];
    
    if ( one_shot_kills > 0 && ( !isdefined( weaponstats.stats[ "highest_kills_per_use" ] ) || weaponstats.stats[ "highest_kills_per_use" ] < one_shot_kills ) )
    {
        weaponstats.stats[ "highest_kills_per_use" ] = one_shot_kills;
    }
    
    telemetry.equipment_one_shot_kills[ entnum ] = undefined;
    function_e56966149cd49575( weaponname );
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0xb474c284, Offset: 0xf6e8
// Size: 0x14e
function private function_7d8c01fcb0cb0434( vehicle, weaponname, timeout )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    entnum = vehicle getentitynumber();
    telemetry = self.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.equipment_one_shot_kills ) )
    {
        telemetry.equipment_one_shot_kills = [];
    }
    
    telemetry.equipment_one_shot_kills[ entnum ] = 0;
    vehicle utility::waittill_notify_or_timeout( "entitydeleted", timeout );
    weaponstats = self.pers[ "weaponStats" ][ weaponname ];
    
    if ( !weaponstats )
    {
        assertmsg( "<dev string:x60f>" + weaponname + "<dev string:x62c>" );
        return;
    }
    
    one_shot_kills = telemetry.equipment_one_shot_kills[ entnum ];
    
    if ( one_shot_kills > 0 && ( !isdefined( weaponstats.stats[ "highest_kills_per_use" ] ) || weaponstats.stats[ "highest_kills_per_use" ] < one_shot_kills ) )
    {
        weaponstats.stats[ "highest_kills_per_use" ] = one_shot_kills;
    }
    
    telemetry.equipment_one_shot_kills[ entnum ] = undefined;
    function_e56966149cd49575( weaponname );
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0x30c0479d, Offset: 0xf83e
// Size: 0x2e4
function private watch_grenade_explode( grenade, weaponname, weaponrootname )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    prev_kills = undefined;
    weaponstats = self.pers[ "weaponStats" ][ weaponname ];
    telemetry = self.pers[ "telemetry" ];
    entnum = grenade getentitynumber();
    var_6c775fd85b144546 = 1;
    use_one_shot_kills = 0;
    
    if ( weaponrootname == "c4" )
    {
        prev_kills = weaponstats.stats[ "kills" ] ?? 0;
        var_6c775fd85b144546 = 0;
        msg = grenade utility::waittill_any_return( "death", "explode", "detonateExplosive", "equipment_pickup", "pre_detonate" );
        delay = 0.5;
    }
    else
    {
        msg = grenade utility::waittill_any_timeout( 10, "death", "explode", "detonateExplosive", "equipment_pickup" );
        delay = 0.2;
        
        switch ( weaponrootname )
        {
            case #"hash_2d5c96c5718a6446":
            case #"hash_4714926c2f3e2d15":
                use_one_shot_kills = 1;
                break;
            case #"hash_606cb2a6a1a3bd0a":
                delay = 3;
                break;
        }
    }
    
    if ( msg == "timeout" || msg == "equipment_pickup" )
    {
        function_e56966149cd49575( weaponname );
        return;
    }
    
    if ( !isdefined( weaponstats ) )
    {
        weaponstats = self.pers[ "weaponStats" ][ weaponname ];
    }
    
    if ( !isdefined( prev_kills ) )
    {
        prev_kills = weaponstats.stats[ "kills" ] ?? 0;
    }
    
    wait delay;
    
    if ( !isdefined( self.pers[ "weaponStats" ][ weaponname ] ) )
    {
        function_e56966149cd49575( weaponname );
        return;
    }
    
    if ( !isdefined( weaponstats ) )
    {
        weaponstats = self.pers[ "weaponStats" ][ weaponname ];
    }
    
    if ( !isdefined( weaponstats.stats ) )
    {
        weaponstats.stats = [];
    }
    
    current_kills = weaponstats.stats[ "kills" ] ?? 0;
    kills = current_kills - prev_kills;
    
    if ( var_6c775fd85b144546 )
    {
        one_shot_kills = telemetry.equipment_one_shot_kills[ entnum ] ?? 0;
        
        if ( use_one_shot_kills )
        {
            kills = one_shot_kills;
        }
        else
        {
            kills += one_shot_kills;
        }
    }
    
    if ( isdefined( telemetry.equipment_one_shot_kills[ entnum ] ) )
    {
        telemetry.equipment_one_shot_kills[ entnum ] = undefined;
    }
    
    if ( kills > 0 )
    {
        if ( !isdefined( weaponstats.stats[ "highest_kills_per_use" ] ) || weaponstats.stats[ "highest_kills_per_use" ] < kills )
        {
            weaponstats.stats[ "highest_kills_per_use" ] = kills;
        }
    }
    
    function_e56966149cd49575( weaponname );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xf9356d4f, Offset: 0xfb2a
// Size: 0x6a
function private function_c7fef6c6e1d8efe9( params )
{
    weapon = equipment_mp::getweaponfromequipmentref( "equip_gas_grenade" );
    
    if ( isdefined( weapon ) )
    {
        attacker = params.attacker;
        telemetry_data = get_weapon_telemetry_data( weapon );
        telemetry::function_6367d060fde50007( telemetry_data, "kills", 1 );
        attacker update_weapon_stats( telemetry_data );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x2dfc4044, Offset: 0xfb9c
// Size: 0x126
function private function_21396bf10feb0abc( params )
{
    if ( !isdefined( params.streakinfo.owner ) )
    {
        return;
    }
    
    player = params.streakinfo.owner;
    streakname = params.streakinfo.streakname;
    telemetry = player.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.killstreak_stats ) )
    {
        telemetry.killstreak_stats = [];
    }
    
    if ( !isdefined( telemetry.killstreak_stats[ streakname ] ) )
    {
        telemetry.killstreak_stats[ streakname ] = {};
    }
    
    if ( !isdefined( telemetry.killstreak_stats[ streakname ].uses ) )
    {
        telemetry.killstreak_stats[ streakname ].uses = 0;
    }
    
    telemetry.killstreak_stats[ streakname ].uses++;
    telemetry.killstreak_stats[ streakname ].kills_per_use = 0;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xf4a3f7b2, Offset: 0xfcca
// Size: 0x1ff
function private function_31c8a2ca329ed197( data )
{
    if ( !isdefined( data.weapon ) || !weapon::iskillstreakweapon( data.weapon ) )
    {
        return;
    }
    
    weaponname = weapon::getweaponname( data.weapon );
    streakname = level.killstreakweaponmap[ weaponname ];
    attacker = data.attacker;
    telemetry = attacker.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.killstreak_stats[ streakname ] ) )
    {
        println( "<dev string:x65e>" + weaponname + "<dev string:x6ab>" + streakname + "<dev string:x6e6>" );
        return;
    }
    
    if ( !isdefined( telemetry.killstreak_stats[ streakname ].kills ) )
    {
        telemetry.killstreak_stats[ streakname ].kills = 0;
    }
    
    telemetry.killstreak_stats[ streakname ].kills++;
    
    if ( !isdefined( telemetry.killstreak_stats[ streakname ].kills_per_use ) )
    {
        telemetry.killstreak_stats[ streakname ].kills_per_use = 0;
    }
    
    telemetry.killstreak_stats[ streakname ].kills_per_use++;
    
    if ( !isdefined( telemetry.killstreak_stats[ streakname ].highest_kills_per_use ) )
    {
        telemetry.killstreak_stats[ streakname ].highest_kills_per_use = 0;
    }
    
    if ( telemetry.killstreak_stats[ streakname ].kills_per_use >= telemetry.killstreak_stats[ streakname ].highest_kills_per_use )
    {
        telemetry.killstreak_stats[ streakname ].highest_kills_per_use = telemetry.killstreak_stats[ streakname ].kills_per_use;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xc8a51ff0, Offset: 0xfed1
// Size: 0x234
function private function_bd9a8673e8cdd22d( player )
{
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( isbot( player ) || istestclient( player ) || isai( player ) )
    {
        return;
    }
    
    telemetry = player.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.killstreak_stats ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    prestige_level = player get_prestige();
    
    foreach ( streakname, stats in telemetry.killstreak_stats )
    {
        var_da6175121f0769cb = player dlog_recordplayerevent( "dlog_event_zm_player_killstreak_stats", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "killstreak_name", getxhash( streakname ), "kills", stats.kills ?? 0, "uses", stats.uses ?? 0, "is_ranked", info_struct.is_ranked, "season", info_struct.season, "prestige_level", prestige_level, "highest_kills_per_use", stats.highest_kills_per_use ?? 0 ] );
        
        if ( isdefined( telemetry.player_killstreak_stats_count ) && var_da6175121f0769cb )
        {
            telemetry.player_killstreak_stats_count++;
        }
    }
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0x5a5ee87c, Offset: 0x1010d
// Size: 0xb5
function private function_834838e020f72470( weapon, critical, is_special_enemy )
{
    self endon( #"disconnect" );
    
    if ( !getdvarint( @"hash_e742008972155619", 0 ) )
    {
        return;
    }
    
    if ( !isdefined( critical ) )
    {
        critical = 0;
    }
    
    weapon_stat_name = critical ? "weap_critical_kills" : "weap_kills";
    weapon_name = weapon.basename;
    gameplay_telemetry::function_3b8d40426c725ea0( weapon_stat_name, weapon_name, 4 );
    
    if ( is_special_enemy )
    {
        gameplay_telemetry::function_3b8d40426c725ea0( "weap_special_kills", weapon_name, 4 );
    }
    
    if ( critical )
    {
        gameplay_telemetry::function_383cde919fd850c4( "critical_kills", 4 );
    }
    
    function_25149c1488817598( weapon_name );
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0xf5d9aba9, Offset: 0x101ca
// Size: 0xd2
function private function_1c14eaa277714138( sparams, weapon_root_name )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( sparams.eattacker ) )
    {
        return;
    }
    
    sparams.eattacker endon( #"disconnect" );
    sparams.eattacker gameplay_telemetry::function_3b8d40426c725ea0( "weap_damagedealt", weapon_root_name, 4, sparams.idamage );
    
    if ( !isdefined( sparams.eattacker.lasthittime ) )
    {
        sparams.eattacker.lasthittime = [];
    }
    
    if ( !isdefined( sparams.eattacker.lasthittime[ weapon_root_name ] ) )
    {
        sparams.eattacker.lasthittime[ weapon_root_name ] = 0;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xbff9a190, Offset: 0x102a4
// Size: 0x79
function private function_25149c1488817598( weapon_name )
{
    var_32e7e408b8fe5978 = self.pers[ "weap_critical_kills" ][ weapon_name ] ?? 0;
    var_33e35f65f75a1c33 = self.pers[ "weap_kills" ][ weapon_name ] ?? 0;
    critical_accuracy = var_32e7e408b8fe5978 / max( var_33e35f65f75a1c33, 1 ) * 100;
    gameplay_telemetry::function_83a6a8db9fcbb065( "weap_critical_accuracy", weapon_name, 4, critical_accuracy, 0 );
}

// Namespace zm_telemetry
// Params 0, eflags: 0xc
// Checksum 0x12ce9735, Offset: 0x10325
// Size: 0x14b
function private function_f98058533d9911cf()
{
    self notify( #"hash_4dbd09939ec310a2" );
    self endon( #"hash_4dbd09939ec310a2" );
    self endon( #"death_or_disconnect" );
    var_141a8092a5da2647 = 0;
    
    while ( true )
    {
        currentweapon = self getcurrentweapon();
        weapon_root_name = currentweapon.basename;
        
        if ( self ismeleeing() && !var_141a8092a5da2647 )
        {
            if ( !isdefined( self.pers[ "weap_shotFired" ][ weapon_root_name ] ) )
            {
                self.pers[ "weap_shotFired" ][ weapon_root_name ] = 0;
            }
            
            self.pers[ "weap_shotFired" ][ weapon_root_name ]++;
            
            if ( !isdefined( self.pers[ "weap_shotHit" ][ weapon_root_name ] ) )
            {
                self.pers[ "weap_shotHit" ][ weapon_root_name ] = 0;
            }
            
            var_3970848492533df4 = self.pers[ "weap_shotHit" ][ weapon_root_name ] / max( self.pers[ "weap_shotFired" ][ weapon_root_name ], 1 ) * 100;
            self.pers[ "weap_accuracy" ][ weapon_root_name ] = var_3970848492533df4;
            thread gameplay_telemetry::function_83a6a8db9fcbb065( "weap_accuracy", weapon_root_name, 4, var_3970848492533df4 );
            var_141a8092a5da2647 = 1;
        }
        else if ( !self ismeleeing() && var_141a8092a5da2647 )
        {
            var_141a8092a5da2647 = 0;
        }
        
        waitframe();
    }
}

// Namespace zm_telemetry
// Params 1
// Checksum 0x42f2d813, Offset: 0x10478
// Size: 0x238
function function_5b217bffe8d1fa92( data )
{
    speaker_name = "";
    speaker_voice = "";
    speaker_sessionstate = "";
    speaker_origin_x = -1;
    speaker_origin_y = -1;
    speaker_origin_z = -1;
    
    if ( isdefined( data.speaker ) )
    {
        speaker = data.speaker;
        speaker_name = speaker.suit;
        speaker_sessionstate = speaker.sessionstate;
        speaker_origin_x = speaker.origin[ 0 ];
        speaker_origin_y = speaker.origin[ 1 ];
        speaker_origin_z = speaker.origin[ 2 ];
        
        if ( isdefined( speaker.operatorcustomization ) )
        {
            speaker_voice = speaker.operatorcustomization.voice;
        }
    }
    
    info_struct = zm_telemetry_info_struct();
    dlog_recordevent( "dlog_event_zm_operator_vo", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "sound_type", data.sound_type ?? "", "sound_event", data.sound_event, "speaker_name", speaker_name, "speaker_voice", speaker_voice, "speaker_origin_x", speaker_origin_x, "speaker_origin_y", speaker_origin_y, "speaker_origin_z", speaker_origin_z, "speaker_sessionstate", speaker_sessionstate ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xe1152baf, Offset: 0x106b8
// Size: 0x13d
function private on_field_upgrade_used( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.ref ) )
    {
        println( "<dev string:x6f0>" );
        return;
    }
    
    field_upgrade = params.ref;
    weapon_name = params.weaponname;
    info_struct = zm_telemetry_info_struct();
    
    if ( field_upgrade != "super_energy_mine" )
    {
        self.pers[ "telemetry" ].field_upgrade_stats[ field_upgrade ] = { #weapon_name:weapon_name, #stats:[], #time:info_struct.time, #round_number:info_struct.round_number };
    }
    else
    {
        self.pers[ "telemetry" ].field_upgrade_stats[ field_upgrade ] = { #weapon_name:weapon_name, #stats_array:[] };
    }
    
    function_d351fe7d177ce831( field_upgrade, 1 );
    println( "<dev string:x729>" + self.name + "<dev string:x741>" + field_upgrade + "<dev string:x75d>" );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xeb09ef03, Offset: 0x107fd
// Size: 0xb3
function private on_field_upgrade_ended( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.ref ) )
    {
        println( "<dev string:x760>" );
        return;
    }
    
    field_upgrade = params.ref;
    telemetry = self.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.field_upgrade_stats[ field_upgrade ] ) )
    {
        println( "<dev string:x729>" + self.name + "<dev string:x79a>" + field_upgrade + "<dev string:x6e6>" );
        return;
    }
    
    function_d351fe7d177ce831( field_upgrade, 0 );
    function_cd1171e1f8e07ffb( field_upgrade, 1 );
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x811acd2a, Offset: 0x108b8
// Size: 0xb7
function private function_d351fe7d177ce831( field_upgrade, is_active )
{
    equip_augments = zombie_augments::function_43a77f7693248e26( field_upgrade );
    
    if ( isdefined( equip_augments ) && isdefined( equip_augments.major ) )
    {
        majorname = getscriptbundlefieldvalue( equip_augments.major, #"augmentname" );
        
        if ( isdefined( majorname ) )
        {
            set_augment_active( majorname, is_active );
        }
    }
    
    if ( isdefined( equip_augments ) && isdefined( equip_augments.minor ) )
    {
        minorname = getscriptbundlefieldvalue( equip_augments.minor, #"augmentname" );
        
        if ( isdefined( minorname ) )
        {
            set_augment_active( minorname, is_active );
        }
    }
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x56b5eb48, Offset: 0x10977
// Size: 0x1a1
function private function_cd1171e1f8e07ffb( field_upgrade, var_943a5fe64f8a6430 )
{
    telemetry = self.pers[ "telemetry" ];
    field_upgrade_data = telemetry.field_upgrade_stats[ field_upgrade ];
    
    if ( isdefined( field_upgrade_data.stats_array ) )
    {
        if ( field_upgrade_data.stats_array.size )
        {
            var_73b7213f18ccec32 = 0;
            var_a40e016333beb294 = 0;
            
            foreach ( key, data in field_upgrade_data.stats_array )
            {
                if ( field_upgrade == "super_energy_mine" )
                {
                    if ( data.subtype == "scatter" )
                    {
                        var_73b7213f18ccec32 = 1;
                        continue;
                    }
                    
                    if ( data.subtype == "carousel" )
                    {
                        var_a40e016333beb294 = 1;
                        continue;
                    }
                }
                
                data.weapon_name = field_upgrade_data.weapon_name;
                function_3f9e7f68775f6a22( field_upgrade, data );
                
                if ( var_943a5fe64f8a6430 )
                {
                    field_upgrade_data.stats_array[ key ] = undefined;
                }
            }
            
            if ( var_73b7213f18ccec32 )
            {
                function_1e014c09ffbb194f( field_upgrade, field_upgrade_data, var_943a5fe64f8a6430 );
            }
            
            if ( var_a40e016333beb294 )
            {
                function_458bc02e3b37e443( field_upgrade, field_upgrade_data, var_943a5fe64f8a6430 );
            }
        }
        
        return;
    }
    
    function_3f9e7f68775f6a22( field_upgrade, field_upgrade_data );
    
    if ( var_943a5fe64f8a6430 )
    {
        telemetry.field_upgrade_stats[ field_upgrade ] = undefined;
    }
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0x2902ea8f, Offset: 0x10b20
// Size: 0x1fc
function private function_1e014c09ffbb194f( field_upgrade, field_upgrade_data, var_943a5fe64f8a6430 )
{
    var_618af1e80ccdc68a = 4000;
    var_4c61994cb7b1e6ba = undefined;
    var_d4a690ac2f790c7b = undefined;
    
    foreach ( key, data in field_upgrade_data.stats_array )
    {
        if ( field_upgrade == "super_energy_mine" && data.subtype == "scatter" )
        {
            if ( !isdefined( var_4c61994cb7b1e6ba ) )
            {
                var_4c61994cb7b1e6ba = data;
                
                if ( !isdefined( var_4c61994cb7b1e6ba.stats[ "kills" ] ) )
                {
                    var_4c61994cb7b1e6ba.stats[ "kills" ] = 0;
                }
                
                var_d4a690ac2f790c7b = data.time;
            }
            else if ( data.time < var_d4a690ac2f790c7b + var_618af1e80ccdc68a )
            {
                var_4c61994cb7b1e6ba.stats[ "kills" ] = var_4c61994cb7b1e6ba.stats[ "kills" ] + ( data.stats[ "kills" ] ?? 0 );
                
                if ( data.need_highest_multi_kills )
                {
                    var_4c61994cb7b1e6ba.need_highest_multi_kills = 1;
                }
            }
            else
            {
                var_4c61994cb7b1e6ba.weapon_name = field_upgrade_data.weapon_name;
                function_3f9e7f68775f6a22( field_upgrade, var_4c61994cb7b1e6ba );
                var_4c61994cb7b1e6ba = data;
                
                if ( !isdefined( var_4c61994cb7b1e6ba.stats[ "kills" ] ) )
                {
                    var_4c61994cb7b1e6ba.stats[ "kills" ] = 0;
                }
                
                var_d4a690ac2f790c7b = data.time;
            }
            
            if ( var_943a5fe64f8a6430 )
            {
                field_upgrade_data.stats_array[ key ] = undefined;
            }
        }
    }
    
    if ( isdefined( var_4c61994cb7b1e6ba ) )
    {
        function_3f9e7f68775f6a22( field_upgrade, var_4c61994cb7b1e6ba );
    }
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0x350e6c28, Offset: 0x10d24
// Size: 0x17f
function private function_458bc02e3b37e443( field_upgrade, field_upgrade_data, var_943a5fe64f8a6430 )
{
    var_c0deca7fb18d553c = undefined;
    
    foreach ( key, data in field_upgrade_data.stats_array )
    {
        if ( field_upgrade == "super_energy_mine" && data.subtype == "carousel" )
        {
            if ( !isdefined( var_c0deca7fb18d553c ) )
            {
                var_c0deca7fb18d553c = data;
                
                if ( !isdefined( var_c0deca7fb18d553c.stats[ "kills" ] ) )
                {
                    var_c0deca7fb18d553c.stats[ "kills" ] = 0;
                }
            }
            else
            {
                var_c0deca7fb18d553c.stats[ "kills" ] = var_c0deca7fb18d553c.stats[ "kills" ] + ( data.stats[ "kills" ] ?? 0 );
                
                if ( data.need_highest_multi_kills )
                {
                    var_c0deca7fb18d553c.need_highest_multi_kills = 1;
                }
            }
            
            if ( var_943a5fe64f8a6430 )
            {
                field_upgrade_data.stats_array[ key ] = undefined;
            }
        }
    }
    
    if ( isdefined( var_c0deca7fb18d553c ) )
    {
        var_c0deca7fb18d553c.weapon_name = field_upgrade_data.weapon_name;
        function_3f9e7f68775f6a22( field_upgrade, var_c0deca7fb18d553c );
    }
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0xf7e8f40, Offset: 0x10eab
// Size: 0x36a
function private function_3f9e7f68775f6a22( field_upgrade, field_upgrade_data )
{
    telemetry = self.pers[ "telemetry" ];
    weaponobj = makeweapon( field_upgrade_data.weapon_name );
    field_upgrade_hash = getxhash( telemetry_mp::function_730ff856cab87e50( weaponobj ) );
    client_uno_id = self getplayerunoid();
    prestige_level = get_prestige();
    info_struct = zm_telemetry_info_struct();
    
    if ( field_upgrade_data.need_highest_multi_kills )
    {
        if ( field_upgrade_data.stats[ "kills" ] >= 5 )
        {
            field_upgrade_data.stats[ "highest_multi_kills" ] = field_upgrade_data.stats[ "kills" ];
        }
    }
    
    var_da6175121f0769cb = dlog_recordevent( "dlog_event_zm_field_upgrade_used", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", field_upgrade_data.round_number, "matchtime_ms", field_upgrade_data.time, "field_upgrade_s", field_upgrade_hash, "quantity", 1, "client_uno_id", client_uno_id, "kills", field_upgrade_data.stats[ "kills" ] ?? 0, "revives", field_upgrade_data.stats[ "revives" ] ?? 0, "kills_while_active", field_upgrade_data.stats[ "kills_while_active" ] ?? 0, "revives_while_shrouded", field_upgrade_data.stats[ "revives_while_shrouded" ] ?? 0, "uses", 1, "highest_multi_kills", field_upgrade_data.stats[ "highest_multi_kills" ] ?? 0, "taunts", field_upgrade_data.stats[ "taunts" ] ?? 0, "enemies_frozen", field_upgrade_data.stats[ "enemies_frozen" ] ?? 0, "highest_electrocutions", field_upgrade_data.stats[ "electrocutions" ] ?? 0, "is_ranked", info_struct.is_ranked, "season", info_struct.season, "prestige_level", prestige_level, "kills_while_slowed", field_upgrade_data.stats[ "kills_while_slowed" ] ?? 0, "slow_assist", field_upgrade_data.stats[ "slow_assist" ] ?? 0 ] );
    
    if ( isdefined( telemetry.player_field_upgrade_stats_count ) && var_da6175121f0769cb )
    {
        telemetry.player_field_upgrade_stats_count++;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x69f048f3, Offset: 0x1121d
// Size: 0xb8
function private function_9729f4a9b1d8e2c4( player )
{
    if ( player.pers[ "telemetry" ].field_upgrade_stats.size )
    {
        foreach ( field_upgrade, data in player.pers[ "telemetry" ].field_upgrade_stats )
        {
            player function_cd1171e1f8e07ffb( field_upgrade, 0 );
        }
    }
}

// Namespace zm_telemetry
// Params 4, eflags: 0x4
// Checksum 0x9a4437b5, Offset: 0x112dd
// Size: 0x19a
function private get_field_upgrade_data( field_upgrade, inflictor, need_remove, ent_number )
{
    telemetry = self.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.field_upgrade_stats[ field_upgrade ] ) )
    {
        println( "<dev string:x7c8>" + self.name + "<dev string:x79a>" + field_upgrade + "<dev string:x6e6>" );
        return;
    }
    
    field_upgrade_data = telemetry.field_upgrade_stats[ field_upgrade ];
    weapon_name = telemetry.field_upgrade_stats[ field_upgrade ].weapon_name;
    
    if ( isdefined( field_upgrade_data.stats_array ) )
    {
        data_found = 0;
        
        if ( !isdefined( ent_number ) )
        {
            ent_number = -1;
        }
        
        if ( field_upgrade_data.stats_array.size )
        {
            if ( ent_number == -1 && isent( inflictor ) )
            {
                ent_number = inflictor getentitynumber();
            }
            
            if ( isdefined( field_upgrade_data.stats_array[ ent_number ] ) )
            {
                data = field_upgrade_data.stats_array[ ent_number ];
                data_found = 1;
                
                if ( need_remove )
                {
                    field_upgrade_data.stats_array[ ent_number ] = undefined;
                }
                
                field_upgrade_data = data;
                field_upgrade_data.weapon_name = weapon_name;
            }
        }
        
        if ( !data_found )
        {
            println( "<dev string:x7f7>" + self.name + "<dev string:x827>" + ent_number + "<dev string:x6e6>" );
            return;
        }
    }
    else if ( need_remove )
    {
        telemetry.field_upgrade_stats[ field_upgrade ] = undefined;
    }
    
    return field_upgrade_data;
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0xd73196bc, Offset: 0x11480
// Size: 0x2e
function private function_72e8422dd3369547( field_upgrade, ent_number )
{
    field_upgrade_data = get_field_upgrade_data( field_upgrade, undefined, 1, ent_number );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xafd43315, Offset: 0x114b6
// Size: 0xf1
function private field_upgrade_stats_track( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.ref ) )
    {
        println( "<dev string:x85e>" );
        return;
    }
    
    field_upgrade_data = get_field_upgrade_data( params.ref, params.inflictor, 0 );
    
    if ( !isdefined( field_upgrade_data ) )
    {
        return;
    }
    
    stats = params.stats;
    count = params.count ?? 1;
    
    if ( !isdefined( field_upgrade_data.stats[ stats ] ) )
    {
        field_upgrade_data.stats[ stats ] = 0;
    }
    
    field_upgrade_data.stats[ stats ] += count;
    
    if ( params.highest_multi_kills )
    {
        field_upgrade_data.need_highest_multi_kills = 1;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x6de22d49, Offset: 0x115af
// Size: 0x199
function private energy_mine_subtype_landed( params )
{
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    if ( !isdefined( params.ref ) )
    {
        println( "<dev string:x89b>" );
        return;
    }
    
    field_upgrade = params.ref;
    player = params.player;
    telemetry = player.pers[ "telemetry" ];
    ent_number = self getentitynumber();
    info_struct = zm_telemetry_info_struct();
    subtype = params.subtype ?? "base";
    println( "<dev string:x8d9>" + ent_number + "<dev string:x921>" + subtype + "<dev string:x3d5>" );
    
    if ( !isdefined( telemetry.field_upgrade_stats[ field_upgrade ] ) )
    {
        telemetry.field_upgrade_stats[ field_upgrade ] = { #stats_array:[] };
    }
    
    telemetry.field_upgrade_stats[ field_upgrade ].stats_array[ ent_number ] = { #subtype:subtype, #stats:[], #time:info_struct.time, #round_number:info_struct.round_number };
    
    if ( isplayer( params.player ) && subtype == "scatter" )
    {
        params.player notify( #"energy_mine_scatter_landed", self );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xd209214d, Offset: 0x11750
// Size: 0x102
function private on_energy_mine_delay_ended( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.ref ) )
    {
        println( "<dev string:x92d>" );
        return;
    }
    
    field_upgrade = params.ref;
    remove_record = !params.delay_time;
    field_upgrade_data = get_field_upgrade_data( field_upgrade, params.energy_mine_ent, remove_record );
    
    if ( isdefined( field_upgrade_data ) )
    {
        if ( isdefined( params.delay_time ) )
        {
            utility::delaythread( params.delay_time, &function_3f9e7f68775f6a22, field_upgrade, field_upgrade_data );
            
            if ( isdefined( params.energy_mine_ent ) )
            {
                ent_number = params.energy_mine_ent getentitynumber();
            }
            
            utility::delaythread( params.delay_time, &function_72e8422dd3369547, field_upgrade, ent_number );
            return;
        }
        
        function_3f9e7f68775f6a22( "super_energy_mine", field_upgrade_data );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xbb6c1cba, Offset: 0x1185a
// Size: 0x1a
function private energy_mine_carousel_ended( params )
{
    function_1d13cb76dfc367de( params, "carousel" );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xcdedf71d, Offset: 0x1187c
// Size: 0xe7
function private energy_mine_scatter_started( params )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    var_ae233b834ebfd607 = 4;
    scatter_mines = [];
    ent_numbers = [];
    endtime = gettime() + int( var_ae233b834ebfd607 * 1000 );
    
    while ( gettime() < endtime )
    {
        msg = utility::function_22939e0bc589604e( var_ae233b834ebfd607, self, "energy_mine_scatter_landed" );
        
        if ( msg[ "message" ] == "energy_mine_scatter_landed" )
        {
            mine = msg[ 0 ];
            
            if ( isdefined( mine ) )
            {
                scatter_mines[ scatter_mines.size ] = mine;
                ent_numbers[ ent_numbers.size ] = mine getentitynumber();
            }
        }
    }
    
    while ( true )
    {
        scatter_mines = function_5713d46873b29625( scatter_mines );
        
        if ( !scatter_mines.size )
        {
            break;
        }
        
        waitframe();
    }
    
    function_1d13cb76dfc367de( params, "scatter", ent_numbers );
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0x4ddfadfa, Offset: 0x1196b
// Size: 0x1b7
function private function_1d13cb76dfc367de( params, subtype, ent_numbers )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.ref ) )
    {
        println( "<dev string:x96b>" );
        return;
    }
    
    field_upgrade = params.ref;
    struct = function_e7f217ed9f42a54c( field_upgrade, subtype, ent_numbers, 1 );
    data_array = struct.data_array;
    weapon_name = struct.weapon_name;
    
    if ( data_array.size )
    {
        accumulated_data = undefined;
        
        foreach ( data in data_array )
        {
            if ( !isdefined( accumulated_data ) )
            {
                accumulated_data = data;
                
                if ( !isdefined( accumulated_data.stats[ "kills" ] ) )
                {
                    accumulated_data.stats[ "kills" ] = 0;
                }
                
                continue;
            }
            
            accumulated_data.stats[ "kills" ] = accumulated_data.stats[ "kills" ] + ( data.stats[ "kills" ] ?? 0 );
            
            if ( data.need_highest_multi_kills )
            {
                accumulated_data.need_highest_multi_kills = 1;
            }
        }
        
        accumulated_data.weapon_name = weapon_name;
        function_3f9e7f68775f6a22( field_upgrade, accumulated_data );
    }
}

// Namespace zm_telemetry
// Params 4, eflags: 0x4
// Checksum 0x409cf039, Offset: 0x11b2a
// Size: 0x188
function private function_e7f217ed9f42a54c( field_upgrade, subtype, ent_numbers, need_remove )
{
    telemetry = self.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.field_upgrade_stats[ field_upgrade ] ) )
    {
        println( "<dev string:x9a8>" + self.name + "<dev string:x79a>" + field_upgrade + "<dev string:x6e6>" );
        return;
    }
    
    field_upgrade_data = telemetry.field_upgrade_stats[ field_upgrade ];
    data_array = [];
    
    if ( isdefined( field_upgrade_data.stats_array ) )
    {
        foreach ( ent_number, data in field_upgrade_data.stats_array )
        {
            if ( data.subtype == subtype )
            {
                if ( isdefined( ent_numbers ) )
                {
                    if ( !arraycontains( ent_numbers, ent_number ) )
                    {
                        continue;
                    }
                }
                
                data_array[ ent_number ] = data;
                
                if ( need_remove )
                {
                    field_upgrade_data.stats_array[ ent_number ] = undefined;
                }
            }
        }
    }
    
    weapon_name = field_upgrade_data.weapon_name;
    return { #weapon_name:weapon_name, #data_array:data_array };
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xde5cab48, Offset: 0x11cbb
// Size: 0xa2
function private on_give_perk( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.var_ffc1674def575bfa ) )
    {
        println( "<dev string:x9ea>" );
        return;
    }
    
    perk_ref = params.var_ffc1674def575bfa;
    info_struct = zm_telemetry_info_struct();
    self.pers[ "telemetry" ].var_a46ebf03a8e6779a[ perk_ref ] = { #stats:[], #start_time:info_struct.time };
    function_46fa1fb527f6ea7a( perk_ref, 1 );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x7e28528c, Offset: 0x11d65
// Size: 0xb8
function private function_de55ca564792d31f( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.var_ffc1674def575bfa ) )
    {
        println( "<dev string:xa24>" );
        return;
    }
    
    perk_ref = params.var_ffc1674def575bfa;
    
    if ( !isdefined( self.pers[ "telemetry" ].var_a46ebf03a8e6779a[ perk_ref ] ) )
    {
        return;
    }
    
    function_46fa1fb527f6ea7a( perk_ref, 0 );
    function_f3d50c5a806592ee( perk_ref, self.pers[ "telemetry" ].var_a46ebf03a8e6779a[ perk_ref ] );
    self.pers[ "telemetry" ].var_a46ebf03a8e6779a[ perk_ref ] = undefined;
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x54d5a865, Offset: 0x11e25
// Size: 0xc3
function private function_46fa1fb527f6ea7a( perk_ref, is_active )
{
    if ( perk_ref == "specialty_choice" )
    {
        return;
    }
    
    perk_augments = zombie_augments::function_47bee6c8496154b3( perk_ref );
    
    if ( isdefined( perk_augments ) && isdefined( perk_augments.major ) )
    {
        majorname = getscriptbundlefieldvalue( perk_augments.major, #"augmentname" );
        
        if ( isdefined( majorname ) )
        {
            set_augment_active( majorname, is_active );
        }
    }
    
    if ( isdefined( perk_augments ) && isdefined( perk_augments.minor ) )
    {
        minorname = getscriptbundlefieldvalue( perk_augments.minor, #"augmentname" );
        
        if ( isdefined( minorname ) )
        {
            set_augment_active( minorname, is_active );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x281d7f09, Offset: 0x11ef0
// Size: 0x162
function private perk_stats_track( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.var_ffc1674def575bfa ) )
    {
        println( "<dev string:xa5f>" );
        return;
    }
    
    perk_ref = params.var_ffc1674def575bfa;
    
    if ( !isdefined( self.pers[ "telemetry" ].var_a46ebf03a8e6779a[ perk_ref ] ) )
    {
        return;
    }
    
    var_a46ebf03a8e6779a = self.pers[ "telemetry" ].var_a46ebf03a8e6779a[ perk_ref ];
    
    if ( isdefined( params.stats ) )
    {
        stats = params.stats;
        count = params.count ?? 1;
        
        if ( !isdefined( var_a46ebf03a8e6779a.stats[ stats ] ) )
        {
            var_a46ebf03a8e6779a.stats[ stats ] = 0;
        }
        
        var_a46ebf03a8e6779a.stats[ stats ] += count;
    }
    
    if ( isdefined( params.highest_critical_damage ) )
    {
        if ( !isdefined( var_a46ebf03a8e6779a.highest_critical_damage ) )
        {
            var_a46ebf03a8e6779a.highest_critical_damage = 0;
        }
        
        var_a46ebf03a8e6779a.highest_critical_damage = max( var_a46ebf03a8e6779a.highest_critical_damage, params.highest_critical_damage );
    }
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x98b75ba1, Offset: 0x1205a
// Size: 0x2ee
function private function_f3d50c5a806592ee( perk_ref, var_a46ebf03a8e6779a )
{
    info_struct = zm_telemetry_info_struct();
    time_active = info_struct.time - var_a46ebf03a8e6779a.start_time;
    prestige_level = get_prestige();
    var_da6175121f0769cb = self dlog_recordplayerevent( "dlog_event_zm_player_perk_stats", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "perk_name", getxhash( perk_ref ), "time_active", time_active, "revives", var_a46ebf03a8e6779a.stats[ "revives" ] ?? 0, "kills", var_a46ebf03a8e6779a.stats[ "kills" ] ?? 0, "multi_kills", var_a46ebf03a8e6779a.stats[ "multi_kills" ] ?? 0, "critical_kills", var_a46ebf03a8e6779a.stats[ "critical_kills" ] ?? 0, "highest_critical_damage", int( var_a46ebf03a8e6779a.highest_critical_damage ?? 0 ), "melee_kills", var_a46ebf03a8e6779a.stats[ "melee_kills" ] ?? 0, "special_zombie_kills", var_a46ebf03a8e6779a.stats[ "special_zombie_kills" ] ?? 0, "elite_zombie_kills", var_a46ebf03a8e6779a.stats[ "elite_zombie_kills" ] ?? 0, "is_ranked", info_struct.is_ranked, "season", info_struct.season, "prestige_level", prestige_level, "uses", 1, "wmod_kills", var_a46ebf03a8e6779a.stats[ "wmod_kills" ] ?? 0, "kills_while_active", var_a46ebf03a8e6779a.stats[ "kills_while_active" ] ?? 0, "third_primary_weapons_kills", var_a46ebf03a8e6779a.stats[ "third_primary_weapons_kills" ] ?? 0 ] );
    
    if ( isdefined( self.pers[ "telemetry" ].player_perk_stats_count ) && var_da6175121f0769cb )
    {
        self.pers[ "telemetry" ].player_perk_stats_count++;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xb7b3b7fd, Offset: 0x12350
// Size: 0xb8
function private function_fde6233651fb779b( player )
{
    if ( player.pers[ "telemetry" ].var_a46ebf03a8e6779a.size )
    {
        foreach ( perk_ref, stats in player.pers[ "telemetry" ].var_a46ebf03a8e6779a )
        {
            player function_f3d50c5a806592ee( perk_ref, stats );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x2a3706a2, Offset: 0x12410
// Size: 0x45, Type: bool
function private function_d1223236eb5bd4e6( perk_ref )
{
    return utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) && self [[ utility::getsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) ]]( perk_ref );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x3cc057f0, Offset: 0x1245e
// Size: 0xd5
function private function_ff7549c2f477fdec( victim )
{
    if ( function_d1223236eb5bd4e6( "specialty_m_mod" ) )
    {
        callback::callback( "perk_stats_track", { #stats:"melee_kills", #var_ffc1674def575bfa:"specialty_m_mod" } );
        
        if ( victim.aicategory == "special" )
        {
            callback::callback( "perk_stats_track", { #stats:"special_zombie_kills", #var_ffc1674def575bfa:"specialty_m_mod" } );
            return;
        }
        
        if ( victim.aicategory == "elite" || victim.aicategory == "hvt" )
        {
            callback::callback( "perk_stats_track", { #stats:"elite_zombie_kills", #var_ffc1674def575bfa:"specialty_m_mod" } );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x9f0c3c11, Offset: 0x1253b
// Size: 0x5b
function private function_84059f6fafa8103e( sparams )
{
    if ( function_d1223236eb5bd4e6( "specialty_w_mod" ) )
    {
        if ( sparams.victim.var_dd22e69947766504 )
        {
            callback::callback( "perk_stats_track", { #stats:"wmod_kills", #var_ffc1674def575bfa:"specialty_w_mod" } );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x23f0edb7, Offset: 0x1259e
// Size: 0x57
function private function_930c80156fab6f8( sparams )
{
    if ( function_d1223236eb5bd4e6( "specialty_vulture_aid" ) )
    {
        if ( sparams.smeansofdeath == "MOD_MELEE" )
        {
            callback::callback( "perk_stats_track", { #stats:"melee_kills", #var_ffc1674def575bfa:"specialty_vulture_aid" } );
        }
    }
}

// Namespace zm_telemetry
// Params 0, eflags: 0x4
// Checksum 0x11842c58, Offset: 0x125fd
// Size: 0x39
function private function_8db5dd88389306f1()
{
    if ( function_d1223236eb5bd4e6( "specialty_d_mod" ) )
    {
        callback::callback( "perk_stats_track", { #stats:"kills_while_active", #var_ffc1674def575bfa:"specialty_d_mod" } );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x98d1824e, Offset: 0x1263e
// Size: 0x5b
function private function_8838716c2c847527( sparams )
{
    if ( function_d1223236eb5bd4e6( "specialty_z_mod" ) )
    {
        if ( sparams.sweapon == self.var_3bf72dcd2775aa78 )
        {
            callback::callback( "perk_stats_track", { #stats:"third_primary_weapons_kills", #var_ffc1674def575bfa:"specialty_z_mod" } );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x2521df42, Offset: 0x126a1
// Size: 0x5c
function private perk_elemental_pop_proc( params )
{
    telemetry = self.pers[ "telemetry" ];
    
    if ( isdefined( telemetry.var_a46ebf03a8e6779a[ "specialty_elemental_pop" ] ) )
    {
        telemetry.var_a46ebf03a8e6779a[ "specialty_elemental_pop" ].var_ed3de5bf0b51882b = gettime();
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xff4d9af3, Offset: 0x12705
// Size: 0x1ca
function private on_ammomod_proc( params )
{
    if ( !isdefined( params.ammomod_name ) )
    {
        println( "<dev string:xa9d>" );
        return;
    }
    
    telemetry = self.pers[ "telemetry" ];
    ammomod_name = params.ammomod_name;
    telemetry.last_ammomod_name = ammomod_name;
    
    if ( isdefined( telemetry.var_a46ebf03a8e6779a[ "specialty_elemental_pop" ] ) && telemetry.var_a46ebf03a8e6779a[ "specialty_elemental_pop" ].var_ed3de5bf0b51882b == gettime() )
    {
        var_a46ebf03a8e6779a = telemetry.var_a46ebf03a8e6779a[ "specialty_elemental_pop" ];
        
        /#
            if ( getdvarint( @"zm_debug_telemetry", 0 ) )
            {
                println( "<dev string:xad9>" + ammomod_name + "<dev string:x3d5>" );
            }
        #/
        
        var_a46ebf03a8e6779a.var_195467f6f37a1265 = ammomod_name;
        var_a46ebf03a8e6779a.ammomod_kills = 0;
        var_a46ebf03a8e6779a.last_shot_time = 0;
        
        if ( isent( params.victim ) && isagent( params.victim ) )
        {
            var_a46ebf03a8e6779a.victim = params.victim;
        }
    }
    
    if ( isdefined( telemetry.ammomod_stats[ ammomod_name ] ) )
    {
        ammomod_stats = telemetry.ammomod_stats[ ammomod_name ];
        ammomod_stats.var_c023dcd573054011 = gettime();
        ammomod_stats.ammomod_kills = 0;
        
        if ( isent( params.victim ) && isagent( params.victim ) )
        {
            ammomod_stats.victim = params.victim;
        }
    }
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0x7d6c8a8d, Offset: 0x128d7
// Size: 0x547
function private function_43abe65717792893( victim, sparams, is_brainrotted_kill )
{
    telemetry = self.pers[ "telemetry" ];
    ammomod_name = telemetry.last_ammomod_name;
    
    if ( !isdefined( ammomod_name ) )
    {
        return;
    }
    
    b_kills = 0;
    b_multi_kills = 0;
    b_highest_multi_kills = 0;
    var_2c02a7cb28759083 = 0;
    
    switch ( ammomod_name )
    {
        case #"hash_ac0effad69e31045":
            if ( victim.shadow_vortex_killed || sparams.smeansofdeath == "MOD_ELEMENTAL_DARK" )
            {
                b_kills = 1;
                b_multi_kills = 1;
            }
            
            break;
        case #"hash_853faa00a9ff1020":
            if ( is_brainrotted_kill )
            {
                b_kills = 1;
                var_2c02a7cb28759083 = 1;
            }
            
            break;
        case #"hash_fe0fd5228eda0f07":
            if ( victim utility::ent_flag( "cryofreeze_active" ) )
            {
                b_kills = 1;
            }
            
            break;
        case #"hash_afaaf053b2461f8a":
            if ( victim utility::ent_flag( "deadwire_stunned" ) )
            {
                b_kills = 1;
                b_multi_kills = 1;
            }
            
            break;
        case #"hash_646d6f8aee3339b1":
            if ( sparams.smeansofdeath == "MOD_ELEMENTAL_LIGHT" )
            {
                b_kills = 1;
            }
            
            break;
        case #"hash_4f5cd54aaf7f106":
            if ( victim status_effects::function_fa35fc2723e956eb( "burn", "napalmburst" ) )
            {
                b_kills = 1;
            }
            
            break;
        case #"hash_41d942d30dd3f804":
            if ( victim utility::ent_flag( "is_shatterblast_target" ) || victim.killed_by_shatterblast && victim utility::ent_flag( "shatterblast_damage" ) )
            {
                b_kills = 1;
                b_multi_kills = 1;
                b_highest_multi_kills = 1;
            }
            
            break;
        case #"hash_181a8e483a8ecc93":
            if ( victim utility::ent_flag( "fw_damage" ) )
            {
                b_kills = 1;
                b_multi_kills = 1;
            }
            
            break;
        default:
            break;
    }
    
    if ( ammomod_name == telemetry.var_a46ebf03a8e6779a[ "specialty_elemental_pop" ].var_195467f6f37a1265 )
    {
        var_a46ebf03a8e6779a = telemetry.var_a46ebf03a8e6779a[ "specialty_elemental_pop" ];
        
        /#
            zm_debug_telemetry = getdvarint( @"zm_debug_telemetry", 0 );
        #/
        
        if ( var_a46ebf03a8e6779a.last_shot_time > 0 && gettime() - var_a46ebf03a8e6779a.last_shot_time > 2000 )
        {
            var_a46ebf03a8e6779a.ammomod_kills = 0;
            
            /#
                if ( zm_debug_telemetry )
                {
                    println( "<dev string:xb1a>" + ammomod_name + "<dev string:x3d5>" );
                }
            #/
        }
        
        var_a46ebf03a8e6779a.last_shot_time = gettime();
        callback::callback( "perk_stats_track", { #stats:"kills", #var_ffc1674def575bfa:"specialty_elemental_pop" } );
        
        /#
            if ( zm_debug_telemetry )
            {
                println( "<dev string:xb66>" + ammomod_name + "<dev string:x3d5>" );
            }
        #/
        
        var_a46ebf03a8e6779a.ammomod_kills++;
        
        if ( var_a46ebf03a8e6779a.ammomod_kills == 5 )
        {
            callback::callback( "perk_stats_track", { #stats:"multi_kills", #var_ffc1674def575bfa:"specialty_elemental_pop" } );
            
            /#
                if ( zm_debug_telemetry )
                {
                    println( "<dev string:xbb0>" + ammomod_name + "<dev string:x3d5>" );
                }
            #/
        }
    }
    
    if ( !isdefined( telemetry.ammomod_stats[ ammomod_name ] ) )
    {
        return;
    }
    
    ammomod_stats = telemetry.ammomod_stats[ ammomod_name ];
    
    if ( victim.aicategory == "special" )
    {
        callback::callback( "ammomod_stats_track", { #stats:"special_zombie_kills", #ammo_mod_name:ammomod_name } );
    }
    else if ( victim.aicategory == "elite" || victim.aicategory == "hvt" )
    {
        callback::callback( "ammomod_stats_track", { #stats:"elite_zombie_kills", #ammo_mod_name:ammomod_name } );
    }
    
    if ( b_kills )
    {
        callback::callback( "ammomod_stats_track", { #stats:"kills", #ammo_mod_name:ammomod_name } );
    }
    
    if ( b_multi_kills )
    {
        ammomod_stats.ammomod_kills++;
        multi_kills_count = 5;
        
        if ( ammomod_name == "shatterblast" )
        {
            multi_kills_count = 2;
        }
        else if ( ammomod_name == "fw_ammomod" )
        {
            multi_kills_count = 2;
        }
        
        if ( ammomod_stats.ammomod_kills == multi_kills_count )
        {
            callback::callback( "ammomod_stats_track", { #stats:"multi_kills", #ammo_mod_name:ammomod_name } );
        }
        
        if ( b_highest_multi_kills )
        {
            if ( ammomod_stats.ammomod_kills >= 5 )
            {
                if ( !isdefined( ammomod_stats.highest_multi_kills ) )
                {
                    ammomod_stats.highest_multi_kills = 5;
                }
                
                ammomod_stats.highest_multi_kills = int( max( ammomod_stats.highest_multi_kills, ammomod_stats.ammomod_kills ) );
            }
        }
    }
    
    if ( var_2c02a7cb28759083 )
    {
        ammomod_stats.ammomod_kills++;
        ammomod_stats.var_628943444abd02a4 = int( max( ammomod_stats.var_628943444abd02a4, ammomod_stats.ammomod_kills ) );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x1b9fd0b6, Offset: 0x12e26
// Size: 0xea
function private function_66391f59b8a839e8( victim )
{
    if ( victim status_effects::function_fa35fc2723e956eb( "burn", "napalmburst" ) )
    {
        foreach ( var_c6321cb8cd32b6a0 in victim.status_effects[ "burn" ] )
        {
            if ( var_c6321cb8cd32b6a0.unique_id == "napalmburst" && var_c6321cb8cd32b6a0.attacker == self )
            {
                callback::callback( "ammomod_stats_track", { #stats:"assists", #ammo_mod_name:"napalmburst" } );
                break;
            }
        }
    }
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x90c5ccb, Offset: 0x12f18
// Size: 0xb7
function private function_cd23d4716776897e( ammomod_ref, is_active )
{
    ammomod_augments = zombie_augments::function_63dfe50717ac9ecf( ammomod_ref );
    
    if ( isdefined( ammomod_augments ) && isdefined( ammomod_augments.major ) )
    {
        majorname = getscriptbundlefieldvalue( ammomod_augments.major, #"augmentname" );
        
        if ( isdefined( majorname ) )
        {
            set_augment_active( majorname, is_active );
        }
    }
    
    if ( isdefined( ammomod_augments ) && isdefined( ammomod_augments.minor ) )
    {
        minorname = getscriptbundlefieldvalue( ammomod_augments.minor, #"augmentname" );
        
        if ( isdefined( minorname ) )
        {
            set_augment_active( minorname, is_active );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x9b84f065, Offset: 0x12fd7
// Size: 0x102
function private function_3f5e17f12740964a( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.ammo_mod_name ) )
    {
        println( "<dev string:xc00>" );
        return;
    }
    
    ammomod_ref = params.ammo_mod_name;
    info_struct = zm_telemetry_info_struct();
    
    if ( !isdefined( self.pers[ "telemetry" ].ammomod_stats[ ammomod_ref ] ) )
    {
        self.pers[ "telemetry" ].ammomod_stats[ ammomod_ref ] = { #time_active:0, #stats:[], #start_time:info_struct.time };
    }
    else
    {
        self.pers[ "telemetry" ].ammomod_stats[ ammomod_ref ].start_time = info_struct.time;
    }
    
    function_cd23d4716776897e( ammomod_ref, 1 );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xa730bc73, Offset: 0x130e1
// Size: 0x11c
function private function_4561441f2d1cb2a5( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.ammo_mod_name ) )
    {
        println( "<dev string:xc41>" );
        return;
    }
    
    ammomod_ref = params.ammo_mod_name;
    telemetry = self.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.ammomod_stats[ ammomod_ref ] ) )
    {
        return;
    }
    
    function_cd23d4716776897e( ammomod_ref, 0 );
    info_struct = zm_telemetry_info_struct();
    ammomod_stats = telemetry.ammomod_stats[ ammomod_ref ];
    time_active = isdefined( ammomod_stats.start_time ) ? max( info_struct.time - ammomod_stats.start_time, level.frameduration ) : level.frameduration;
    ammomod_stats.time_active += int( time_active );
    ammomod_stats.start_time = undefined;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x987a000d, Offset: 0x13205
// Size: 0xa6
function private ammo_mod_on_weapon_change( params )
{
    lastweapon = params.lastweapon;
    weapon = params.weapon;
    
    if ( ammo_mod::has_ammo_mod( lastweapon ) )
    {
        ammo_mod_name = ammo_mod::get_ammo_mod_name( lastweapon );
        
        if ( ammo_mod_name != "" )
        {
            function_4561441f2d1cb2a5( { #ammo_mod_name:ammo_mod_name } );
        }
    }
    
    if ( ammo_mod::has_ammo_mod( weapon ) )
    {
        ammo_mod_name = ammo_mod::get_ammo_mod_name( weapon );
        
        if ( ammo_mod_name != "" )
        {
            function_3f5e17f12740964a( { #ammo_mod_name:ammo_mod_name } );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xd5ca96cc, Offset: 0x132b3
// Size: 0x112
function private ammomod_stats_track( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.ammo_mod_name ) )
    {
        println( "<dev string:xc81>" );
        return;
    }
    
    ammomod_ref = params.ammo_mod_name;
    
    if ( !isdefined( self.pers[ "telemetry" ].ammomod_stats[ ammomod_ref ] ) )
    {
        return;
    }
    
    ammomod_stats = self.pers[ "telemetry" ].ammomod_stats[ ammomod_ref ];
    
    if ( isdefined( params.stats ) )
    {
        stats = params.stats;
        count = params.count ?? 1;
        
        if ( !isdefined( ammomod_stats.stats[ stats ] ) )
        {
            ammomod_stats.stats[ stats ] = 0;
        }
        
        ammomod_stats.stats[ stats ] += count;
    }
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x15e8cd43, Offset: 0x133cd
// Size: 0x37b
function private function_ca4776ce7f4cc1ee( ammomod_ref, ammomod_stats )
{
    info_struct = zm_telemetry_info_struct();
    time_active = ammomod_stats.time_active ?? 0;
    prestige_level = get_prestige();
    
    if ( isdefined( ammomod_stats.start_time ) )
    {
        last_time_active = max( info_struct.time - ammomod_stats.start_time, level.frameduration );
        time_active += int( last_time_active );
    }
    
    var_da6175121f0769cb = self dlog_recordplayerevent( "dlog_event_zm_player_ammo_mod_stats", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "ammo_mod_name", getxhash( ammomod_ref ), "time_active", time_active, "kills", ammomod_stats.stats[ "kills" ] ?? 0, "zombies_ignited", ammomod_stats.stats[ "zombies_ignited" ] ?? 0, "assists", ammomod_stats.stats[ "assists" ] ?? 0, "zombies_frozen", ammomod_stats.stats[ "zombies_frozen" ] ?? 0, "special_zombies_frozen", ammomod_stats.stats[ "special_zombies_frozen" ] ?? 0, "zombies_electrocuted", ammomod_stats.stats[ "zombies_electrocuted" ] ?? 0, "multi_kills", ammomod_stats.stats[ "multi_kills" ] ?? 0, "gibs", ammomod_stats.stats[ "gibs" ] ?? 0, "highest_multi_kills", ammomod_stats.highest_multi_kills ?? 0, "highest_kills_by_zombie_brain_rotted", ammomod_stats.var_628943444abd02a4 ?? 0, "zombies_brain_rotted", ammomod_stats.stats[ "zombies_brain_rotted" ] ?? 0, "is_ranked", info_struct.is_ranked, "season", info_struct.season, "prestige_level", prestige_level, "elite_zombie_kills", ammomod_stats.stats[ "elite_zombie_kills" ] ?? 0, "special_zombie_kills", ammomod_stats.stats[ "special_zombie_kills" ] ?? 0, "health_healed", ammomod_stats.stats[ "health_healed" ] ?? 0 ] );
    
    if ( isdefined( self.pers[ "telemetry" ].player_ammo_mod_stats_count ) && var_da6175121f0769cb )
    {
        self.pers[ "telemetry" ].player_ammo_mod_stats_count++;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x7e477a4b, Offset: 0x13750
// Size: 0xb8
function private function_d72ad5241bab766b( player )
{
    if ( player.pers[ "telemetry" ].ammomod_stats.size )
    {
        foreach ( ammomod_ref, stats in player.pers[ "telemetry" ].ammomod_stats )
        {
            player function_ca4776ce7f4cc1ee( ammomod_ref, stats );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x2d1dcd5e, Offset: 0x13810
// Size: 0x52
function private on_napalmburst_proc( params )
{
    if ( isplayer( params.attacker ) )
    {
        params.attacker callback::callback( "ammomod_stats_track", { #stats:"zombies_ignited", #ammo_mod_name:"napalmburst" } );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x4ceab935, Offset: 0x1386a
// Size: 0x98
function private on_enemy_cryofreeze( params )
{
    if ( isplayer( params.attacker ) )
    {
        params.attacker callback::callback( "ammomod_stats_track", { #stats:"zombies_frozen", #ammo_mod_name:"cryofreeze" } );
        
        if ( self.aicategory == "special" )
        {
            params.attacker callback::callback( "ammomod_stats_track", { #stats:"special_zombies_frozen", #ammo_mod_name:"cryofreeze" } );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x97abcc96, Offset: 0x1390a
// Size: 0x52
function private on_deadwire_stunned( params )
{
    if ( isplayer( params.attacker ) )
    {
        params.attacker callback::callback( "ammomod_stats_track", { #stats:"zombies_electrocuted", #ammo_mod_name:"deadwire" } );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xcc614fca, Offset: 0x13964
// Size: 0x6b
function private on_shadowvortex_kill( params )
{
    if ( isplayer( params.attacker ) && params.zombie.forceannihilate )
    {
        params.attacker callback::callback( "ammomod_stats_track", { #stats:"gibs", #ammo_mod_name:"shadowvortex" } );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x5c40d667, Offset: 0x139d7
// Size: 0x87
function private on_shatterblast_explosion( params )
{
    if ( isplayer( params.attacker ) )
    {
        player = params.attacker;
        
        if ( isdefined( player.pers[ "telemetry" ].ammomod_stats[ "shatterblast" ] ) )
        {
            player.pers[ "telemetry" ].ammomod_stats[ "shatterblast" ].ammomod_kills = 0;
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xdc8f0fc3, Offset: 0x13a66
// Size: 0xd8
function private on_brainrotted( params )
{
    if ( isplayer( params.attacker ) )
    {
        player = params.attacker;
        player callback::callback( "ammomod_stats_track", { #stats:"zombies_brain_rotted", #ammo_mod_name:"brainrot" } );
        
        if ( isdefined( player.pers[ "telemetry" ].ammomod_stats[ "brainrot" ] ) )
        {
            ammomod_stats = player.pers[ "telemetry" ].ammomod_stats[ "brainrot" ];
            ammomod_stats.ammomod_kills = 0;
            
            if ( !isdefined( ammomod_stats.var_628943444abd02a4 ) )
            {
                ammomod_stats.var_628943444abd02a4 = 0;
            }
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x77448a18, Offset: 0x13b46
// Size: 0x51
function private on_lightray_healing( params )
{
    if ( isplayer( self ) )
    {
        callback::callback( "ammomod_stats_track", { #count:params.count, #stats:"health_healed", #ammo_mod_name:"lightray" } );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xb6c91a38, Offset: 0x13b9f
// Size: 0x80
function private function_9c6fe018641ab71( params )
{
    if ( isdefined( self.pers[ "summary" ][ "essence_acquired" ] ) )
    {
        self.pers[ "summary" ][ "essence_acquired" ] = self.pers[ "summary" ][ "essence_acquired" ] + params.points;
        return;
    }
    
    self.pers[ "summary" ][ "essence_acquired" ] = params.points;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x6c35d8d1, Offset: 0x13c27
// Size: 0x10b
function private on_player_currency_add( params )
{
    if ( params.currencytype == #"salvage" )
    {
        if ( !isdefined( self.pers[ "summary" ][ "salvage_acquired" ] ) )
        {
            self.pers[ "summary" ][ "salvage_acquired" ] = 0;
        }
        
        self.pers[ "summary" ][ "salvage_acquired" ] = self.pers[ "summary" ][ "salvage_acquired" ] + params.amount;
        return;
    }
    
    if ( params.currencytype == #"essence" )
    {
        if ( !isdefined( self.pers[ "summary" ][ "essence_acquired" ] ) )
        {
            self.pers[ "summary" ][ "essence_acquired" ] = 0;
        }
        
        self.pers[ "summary" ][ "essence_acquired" ] = self.pers[ "summary" ][ "essence_acquired" ] + params.amount;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x2edd8bec, Offset: 0x13d3a
// Size: 0x150
function private on_player_currency_sub( params )
{
    if ( params.currencytype == #"salvage" )
    {
        if ( !isdefined( self.pers[ "summary" ][ "salvage_spent" ] ) )
        {
            self.pers[ "summary" ][ "salvage_spent" ] = 0;
        }
        
        self.pers[ "summary" ][ "salvage_spent" ] = self.pers[ "summary" ][ "salvage_spent" ] + params.amount;
    }
    else if ( params.currencytype == #"essence" )
    {
        if ( !isdefined( self.pers[ "summary" ][ "essence_spent" ] ) )
        {
            self.pers[ "summary" ][ "essence_spent" ] = 0;
        }
        
        self.pers[ "summary" ][ "essence_spent" ] = self.pers[ "summary" ][ "essence_spent" ] + params.amount;
    }
    
    if ( params.reason == #"fast_travel" )
    {
        function_ce4d11576d624ee5( params );
        return;
    }
    
    if ( params.reason == #"ammo_cache" )
    {
        function_9f239038e3f63ae5( params );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x9b89cc8, Offset: 0x13e92
// Size: 0xde
function private function_f7a043c6404dcadb( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.augmentname ) )
    {
        println( "<dev string:xcc2>" );
        return;
    }
    
    augmentname = params.augmentname;
    info_struct = zm_telemetry_info_struct();
    
    if ( !isdefined( self.pers[ "telemetry" ].augment_stats[ augmentname ] ) )
    {
        self.pers[ "telemetry" ].augment_stats[ augmentname ] = { #reason:params.reason, #ismajor:params.ismajor, #augmenttype:params.augmenttype, #time_active:0 };
    }
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x5fcc1bad, Offset: 0x13f78
// Size: 0x12d
function private set_augment_active( augmentname, is_active )
{
    if ( !( isdefined( augmentname ) && isdefined( self.pers[ "telemetry" ].augment_stats[ augmentname ] ) ) )
    {
        return;
    }
    
    stats = self.pers[ "telemetry" ].augment_stats[ augmentname ];
    
    if ( is_active )
    {
        if ( !isdefined( stats.last_start_time ) )
        {
            info_struct = zm_telemetry_info_struct();
            stats.last_start_time = info_struct.time;
        }
        
        return;
    }
    
    if ( isdefined( stats.last_start_time ) )
    {
        info_struct = zm_telemetry_info_struct();
        time_active = int( max( info_struct.time - stats.last_start_time, level.frameduration ) );
        
        if ( !isdefined( stats.time_active ) )
        {
            stats.time_active = 0;
        }
        
        stats.time_active += time_active;
        stats.last_start_time = undefined;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x13bfc2d4, Offset: 0x140ad
// Size: 0xb8
function private function_a9ed7700ad7180b8( player )
{
    if ( player.pers[ "telemetry" ].augment_stats.size )
    {
        foreach ( augmentname, stats in player.pers[ "telemetry" ].augment_stats )
        {
            player function_a7b4a2b4efecbdbf( augmentname, stats );
        }
    }
}

// Namespace zm_telemetry
// Params 2, eflags: 0x4
// Checksum 0x5c04bb14, Offset: 0x1416d
// Size: 0x1f6
function private function_a7b4a2b4efecbdbf( augmentname, stats )
{
    info_struct = zm_telemetry_info_struct();
    time_active = stats.time_active;
    prestige_level = get_prestige();
    
    if ( isdefined( stats.last_start_time ) )
    {
        time_active += info_struct.time - stats.last_start_time;
    }
    
    if ( time_active == 0 )
    {
        return;
    }
    
    var_da6175121f0769cb = self dlog_recordplayerevent( "dlog_event_zm_player_augment_stats", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "augment_name", getxhash( augmentname ), "time_active", time_active, "augment_type", getxhash( stats.augmenttype ), "is_major", stats.ismajor == 1 ? 1 : 0, "is_ranked", info_struct.is_ranked, "season", info_struct.season, "prestige_level", prestige_level, "augment_loadout_type", stats.reason ?? #"unknown" ] );
    
    if ( isdefined( self.pers[ "telemetry" ].player_augment_stats_count ) && var_da6175121f0769cb )
    {
        self.pers[ "telemetry" ].player_augment_stats_count++;
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x434133cb, Offset: 0x1436b
// Size: 0x18e
function private function_359b8f55dd2e8186( params )
{
    if ( !isdefined( params.var_544dc6c47711ac4a ) )
    {
        println( "<dev string:xd04>" );
        return;
    }
    
    if ( !isdefined( params.var_10b9a2bce841a5f2 ) )
    {
        println( "<dev string:xd3f>" );
        return;
    }
    
    utility::flag_wait( "onStartGameTypeFinished" );
    
    if ( !game[ "telemetry" ].mq_step_stats )
    {
        game[ "telemetry" ].mq_step_stats = { #steps:[], #var_544dc6c47711ac4a:params.var_544dc6c47711ac4a };
    }
    
    info_struct = zm_telemetry_info_struct();
    
    if ( isdefined( game[ "telemetry" ].mq_step_stats.steps[ params.var_10b9a2bce841a5f2 ] ) )
    {
        stats = game[ "telemetry" ].mq_step_stats.steps[ params.var_10b9a2bce841a5f2 ];
        stats.start_time = info_struct.time;
        stats.start_round = info_struct.round_number;
        return;
    }
    
    stats = { #start_round:info_struct.round_number, #start_time:info_struct.time };
    game[ "telemetry" ].mq_step_stats.steps[ params.var_10b9a2bce841a5f2 ] = stats;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x1c961038, Offset: 0x14501
// Size: 0x15b
function private zm_mq_step_complete( params )
{
    if ( !isdefined( params.var_544dc6c47711ac4a ) )
    {
        println( "<dev string:xd79>" );
        return;
    }
    
    if ( !isdefined( params.var_10b9a2bce841a5f2 ) )
    {
        println( "<dev string:xdb7>" );
        return;
    }
    
    if ( !game[ "telemetry" ].mq_step_stats )
    {
        println( "<dev string:xdf4>" );
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    var_10b9a2bce841a5f2 = params.var_10b9a2bce841a5f2;
    
    if ( isdefined( game[ "telemetry" ].mq_step_stats.steps[ var_10b9a2bce841a5f2 ] ) )
    {
        stats = game[ "telemetry" ].mq_step_stats.steps[ var_10b9a2bce841a5f2 ];
        stats.end_time = info_struct.time;
        stats.end_round = info_struct.round_number;
        stats.end_result = 1;
        function_a9666c01ce6659fd( game[ "telemetry" ].mq_step_stats.var_544dc6c47711ac4a, var_10b9a2bce841a5f2, stats );
        game[ "telemetry" ].mq_step_stats.steps[ var_10b9a2bce841a5f2 ] = undefined;
    }
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0x16f87b15, Offset: 0x14664
// Size: 0x1be
function private function_a9666c01ce6659fd( var_544dc6c47711ac4a, var_10b9a2bce841a5f2, stats )
{
    info_struct = zm_telemetry_info_struct();
    is_solo_match = isdedicatedserver() ? zm_save::is_save_load_enabled() : 0;
    is_save_reload = level.zm_save_info.var_cccdb0a426251ee0 ?? 0;
    is_one_party_playlist = function_7a3d4348b3110c54();
    dlog_recordevent( "dlog_event_zm_mq_tracking", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "mq_name", getxhash( var_544dc6c47711ac4a ), "quest_step_name", getxhash( var_10b9a2bce841a5f2 ), "quest_step_start_time", stats.start_time, "quest_step_start_round", stats.start_round, "quest_step_end_time", stats.end_time ?? -1, "quest_step_end_round", stats.end_round ?? -1, "quest_step_end_result", stats.end_result ?? 0, "is_solo_match", is_solo_match, "is_save_reload", is_save_reload, "is_one_party_playlist", is_one_party_playlist ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xb91410a9, Offset: 0x1482a
// Size: 0xf4
function private function_cd15bd922e271ec6( endreason )
{
    if ( !game[ "telemetry" ].mq_step_stats )
    {
        return;
    }
    
    override_end_result = endreason == 6 ? 3 : undefined;
    
    foreach ( var_10b9a2bce841a5f2, stats in game[ "telemetry" ].mq_step_stats.steps )
    {
        if ( override_end_result )
        {
            stats.end_result = override_end_result;
        }
        
        function_a9666c01ce6659fd( game[ "telemetry" ].mq_step_stats.var_544dc6c47711ac4a, var_10b9a2bce841a5f2, stats );
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x8a65b7bf, Offset: 0x14926
// Size: 0x39
function private on_player_death( params )
{
    if ( level.b_zm_game_over && params.meansofdeath == "MOD_SUICIDE" )
    {
        return;
    }
    
    record_player_death( 0, 1, 0 );
}

// Namespace zm_telemetry
// Params 3, eflags: 0x4
// Checksum 0xecd8b935, Offset: 0x14967
// Size: 0x1dd
function private record_player_death( was_knocked, was_killed, was_revived )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    var_6cc17c32c1d9442b = self.pers[ "telemetry" ].var_e550ff4c99e1b348.subclass ?? "unknown";
    weapon_name = self.pers[ "telemetry" ].var_e550ff4c99e1b348.weapon_name ?? "none";
    self dlog_recordplayerevent( "dlog_event_zm_player_death", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "was_knocked", was_knocked, "was_killed", was_killed, "was_revived", was_revived, "location_x", self.origin[ 0 ], "location_y", self.origin[ 1 ], "location_z", self.origin[ 2 ], "attacker", getxhash( var_6cc17c32c1d9442b ), "weapon_name", getxhash( weapon_name ) ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xbb2efc15, Offset: 0x14b4c
// Size: 0x160
function private function_ce4d11576d624ee5( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    cost = params.amount ?? 0;
    currency = function_5500181132dcbc51( params.currencytype );
    self dlog_recordplayerevent( "dlog_event_zm_player_fast_travel", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "cost", cost, "currency", currency, "pos_x", self.origin[ 0 ], "pos_y", self.origin[ 1 ], "pos_z", self.origin[ 2 ] ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x63b2e272, Offset: 0x14cb4
// Size: 0x160
function private function_9f239038e3f63ae5( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    cost = params.amount ?? 0;
    currency = function_5500181132dcbc51( params.currencytype );
    self dlog_recordplayerevent( "dlog_event_zm_player_ammo_cache", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "cost", cost, "currency", currency, "pos_x", self.origin[ 0 ], "pos_y", self.origin[ 1 ], "pos_z", self.origin[ 2 ] ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x499066d4, Offset: 0x14e1c
// Size: 0x72
function private function_9a0dd10580b95432( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    self.pers[ "telemetry" ].rampage_inducer_start_time = info_struct.time;
    self.pers[ "telemetry" ].rampage_inducer_start_round = info_struct.round_number;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xad859648, Offset: 0x14e96
// Size: 0x199
function private function_3f7664e7bf3c0c45( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].rampage_inducer_start_time ) )
    {
        println( "<dev string:xe35>" );
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    duration = info_struct.time - self.pers[ "telemetry" ].rampage_inducer_start_time;
    self dlog_recordplayerevent( "dlog_event_zm_player_rampage_inducer", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "start_time", self.pers[ "telemetry" ].rampage_inducer_start_time, "start_round", self.pers[ "telemetry" ].rampage_inducer_start_round ?? 1, "duration", duration, "end_round", info_struct.round_number ] );
    self.pers[ "telemetry" ].rampage_inducer_start_time = undefined;
    self.pers[ "telemetry" ].rampage_inducer_start_round = undefined;
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xf6556f70, Offset: 0x15037
// Size: 0x37
function private function_7aab4ba517a6671a( player )
{
    if ( !isdefined( player.pers[ "telemetry" ].rampage_inducer_start_time ) )
    {
        return;
    }
    
    player function_3f7664e7bf3c0c45( {} );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xa64ec01b, Offset: 0x15076
// Size: 0x16d
function private on_player_powerup( params )
{
    powerup = params.powerup;
    player = params.player;
    
    if ( !isplayer( player ) || !isdefined( powerup.str_powerup ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    player dlog_recordplayerevent( "dlog_event_zm_player_power_up_collect", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "power_up", getxhash( powerup.str_powerup ), "pos_x", player.origin[ 0 ], "pos_y", player.origin[ 1 ], "pos_z", player.origin[ 2 ] ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x6b1013da, Offset: 0x151eb
// Size: 0x24b
function private function_37cf06ba687c5dbe( params )
{
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    player = params.player;
    trial_name = params.var_c2afe1a671205584;
    trial_list_id = params.var_19cd9b8d08f8a7c9;
    trial_struct_id = params.var_7c00f823b7c297d4;
    currency = isdefined( params.currency ) ? function_5500181132dcbc51( params.currency ) : 0;
    cost = params.cost ?? 0;
    round_scaler = params.round_scaler ?? 1;
    client_uno_id = player getplayerunoid();
    info_struct = zm_telemetry_info_struct();
    dlog_recordevent( "dlog_event_zm_sam_trial_triggered", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "trial_name", trial_name, "trial_list_id", trial_list_id, "trial_struct_id", trial_struct_id, "client_uno_id", client_uno_id, "currency", currency, "cost", cost, "pos_x", player.origin[ 0 ], "pos_y", player.origin[ 1 ], "pos_z", player.origin[ 2 ], "round_scaler", round_scaler ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x598cc721, Offset: 0x1543e
// Size: 0x16
function private function_49030e451e16fb37( params )
{
    level thread function_e48e19097e5f7506( params );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0xbeb5c895, Offset: 0x1545c
// Size: 0x1d6
function private function_e48e19097e5f7506( params )
{
    level endon( #"game_ended" );
    trial_name = params.var_c2afe1a671205584;
    trial_list_id = params.var_19cd9b8d08f8a7c9;
    trial_struct_id = params.var_7c00f823b7c297d4;
    trial_result = 0;
    round_scaler = params.round_scaler ?? 1;
    mastery_achieved = params.mastery_achieved ? 1 : 0;
    info_struct = zm_telemetry_info_struct();
    result = level utility::waittill_any_return_params_or_timeout( 5, "trial_result" );
    
    if ( result[ "message" ] != "timeout" && isdefined( result[ 0 ] ) )
    {
        trial_result = result[ 0 ];
    }
    
    dlog_recordevent( "dlog_event_zm_sam_trial_ended", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "round", info_struct.round_number, "matchtime_ms", info_struct.time, "trial_name", trial_name, "trial_list_id", trial_list_id, "trial_struct_id", trial_struct_id, "result", trial_result, "round_scaler", round_scaler, "mastery_achieved", mastery_achieved ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x9d8ff83f, Offset: 0x1563a
// Size: 0x23e
function private function_d81132e4ca605e4e( player )
{
    if ( !level.active_relics.size || !level.zm_relics.size )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    prestige_level = player get_prestige();
    
    foreach ( relic_name in level.active_relics )
    {
        if ( relic_name && level.zm_relics[ relic_name ] )
        {
            lootid = level.zm_relics[ relic_name ].lootid;
            relic_ref = loot::function_f54ecb89dfab8e8c( lootid );
            relic_tier = level.zm_relics[ relic_name ].tier;
            
            if ( !isdefined( relic_ref ) )
            {
                println( "<dev string:xe8d>" + lootid + "<dev string:xece>" + getxhashsourcename( relic_name ) );
                continue;
            }
            
            relic_hash = getxhash( relic_ref );
            player dlog_recordplayerevent( "dlog_event_zm_player_relic_stats", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "playlist_name", info_struct.playlist_name, "is_ranked", info_struct.is_ranked, "season", info_struct.season, "prestige_level", prestige_level, "match_relic_tier", level.zm_relic_tier ?? 0, "relic_name", relic_hash, "relic_tier", relic_tier ] );
        }
    }
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x802aabaa, Offset: 0x15880
// Size: 0x130
function private function_f31dcfe65053dc25( params )
{
    if ( !level.zm_relics.size > 0 )
    {
        return;
    }
    
    player = params.player ?? self;
    party_leader = params.party_leader ?? player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    relic_tier = params.relic_tier ?? 0;
    player_uid = player getxuid() ?? 0;
    party_leader_uid = party_leader getxuid() ?? 0;
    player dlog_recordplayerevent( "dlog_event_zm_player_connected_relics_info", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "relic_tier", relic_tier, "player_xuid", player_uid, "partyleader_xuid", party_leader_uid ] );
}

// Namespace zm_telemetry
// Params 1, eflags: 0x4
// Checksum 0x3be21a10, Offset: 0x159b8
// Size: 0xfb
function private function_f8823b43af695910( params )
{
    if ( !level.zm_relics.size > 0 )
    {
        return;
    }
    
    player = params.player ?? self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    info_struct = zm_telemetry_info_struct();
    relic_tier = params.relic_tier ?? 0;
    player_uid = player getxuid() ?? 0;
    player dlog_recordplayerevent( "dlog_event_zm_player_host_relics_chosen", [ "map", info_struct.map_name, "game_type", info_struct.game_type, "playlist_id", info_struct.playlist_id, "relic_tier", relic_tier ?? 0, "player_xuid", player_uid ?? 0 ] );
}

