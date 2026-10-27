// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_mq.gsc  (hash_29f1dd8318cea141.gscc) (size: 125803 Bytes / 0x1eb6b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc107074e (3238463310)
// size ...... 125803 (0x1eb6b)
// includes .. 43  (offset: 0x1c21f)
// strings ... 471 (offset: 0x1c377)
// dev strs .. 62  (offset: 0x1e803)
// exports ... 239 (offset: 0x1407b)
// cseg ...... 0x2c65 + 0x11416 (0x1407b)
// imports ... 615 (offset: 0x165d3)
// animtree1 . 0   (offset: 0x1eb6b)
// animtree2 . 0   (offset: 0x1eb6b)
#using script_4382611bb6bbf2a0;
#using script_5cdea9fec9d024f8;
#using script_6da29e3ae241e21;
#using scripts\anim\dialogue;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\ammomods\brainrot;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\movers;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_boss_fight;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\time_travel_timewarps;
#using scripts\mp\zm\systems\zm_fasttravel_core;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\weapons\zm_sat_ww_mantis;
#using scripts\mp\zm\zm_player;

#namespace zm_sat_mantis_quest_mq;

// Namespace zm_sat_mantis_quest_mq
// Params 0, eflags: 0x5
// Checksum 0x4afea2b9, Offset: 0x2c83
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"mantis_mq", #"zm_quest", &pre_init, &init );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x7f2cd765, Offset: 0x2cb0
// Size: 0x422
function pre_init()
{
    setdvarifuninitialized( @"enable_mantis_mq", 0 );
    scene::add_scene_func( "sat_cin_zm_mantis_outro", &function_d94c34da496fb651, "callback_play" );
    scene::add_scene_func( "sat_cin_zm_mantis_outro", &function_795457ad2c6f9467, "callback_done" );
    scene::add_scene_func( "sat_cin_zm_vig_mantis_sisters_swing_02", &function_630160cd2e04c758, "swing" );
    scene::add_scene_func( "sat_cin_zm_vig_mantis_sisters_swing_02", &delete_swing_seat, "intro" );
    
    if ( !getdvarint( @"enable_mantis_mq", 0 ) )
    {
        return;
    }
    
    zm_quest::function_3c363613c60958f5( "progressing_mini_games" );
    zm_quest::function_3c363613c60958f5( "progressing_soul_charging" );
    zm_quest::register_quest_step( #"mantis_mq", #"open_garage", &setup_open_garage, &cleanup_open_garage );
    zm_quest::register_quest_step( #"mantis_mq", #"collect_chalk", &setup_collect_chalk, &cleanup_collect_chalk );
    zm_quest::register_quest_step( #"mantis_mq", #"repair_seat", &setup_repair_seat, &cleanup_repair_seat );
    zm_quest::register_quest_step( #"mantis_mq", #"return_chalk", &setup_return_chalk, &cleanup_return_chalk );
    zm_quest::register_quest_step( #"mantis_mq", #"play_games", &setup_play_games, &cleanup_play_games );
    zm_quest::register_quest_step( #"mantis_mq", #"play_hopscotch", &setup_play_hopscotch, &cleanup_play_hopscotch );
    zm_quest::register_quest_step( #"mantis_mq", #"get_irradiated_seed", &setup_get_irradiated_seed, &cleanup_get_irradiated_seed );
    zm_quest::register_quest_step( #"mantis_mq", #"plant_irradiated_seed", &setup_plant_irradiated_seed, &cleanup_plant_irradiated_seed );
    zm_quest::register_quest_step( #"mantis_mq", #"hash_7079d8fdffd55404", &function_5df3d0c824a31e0d, &function_c68c8b2a2634c176 );
    zm_quest::register_quest_step( #"mantis_mq", #"hash_f03d18a564573443", &function_1315aff4cb444bdc, &function_aff48a419de6fbe5 );
    zm_quest::register_quest_step( #"mantis_mq", #"play_hopscotch_game", &setup_play_hopscotch_game, &cleanup_play_hopscotch_game );
    zm_quest::register_quest_step( #"mantis_mq", #"deliver_music_box", &setup_deliver_music_box, &cleanup_deliver_music_box );
    zm_quest::register_quest_step( #"mantis_mq", #"play_foursquare", &setup_play_foursquare, &cleanup_play_foursquare );
    zm_quest::register_quest_step( #"mantis_mq", #"return_toys", &setup_return_toys, &cleanup_return_toys );
    zm_quest::register_quest_step( #"mantis_mq", #"guide_ball", &setup_guide_ball, &cleanup_guide_ball );
    zm_quest::register_quest_step( #"mantis_mq", #"play_foursquare_game", &setup_play_foursquare_game, &cleanup_play_foursquare_game );
    zm_quest::register_quest_step( #"mantis_mq", #"deliver_cymbals", &setup_deliver_cymbals, &cleanup_deliver_cymbals );
    zm_quest::register_quest_step( #"mantis_mq", #"play_jacks", &setup_play_jacks, &cleanup_play_jacks );
    zm_quest::register_quest_step( #"mantis_mq", #"find_key", &setup_find_key, &cleanup_find_key );
    zm_quest::register_quest_step( #"mantis_mq", #"hash_55a0cf1444faaaa3", &function_f6ae1443906b989c, &function_75a72dc86a89e67d );
    zm_quest::register_quest_step( #"mantis_mq", #"play_music", &setup_play_music, &cleanup_play_music );
    zm_quest::register_quest_step( #"mantis_mq", #"hash_e6cfb931cb2b8e3e", &function_a68464437eaa8a15, &function_edd5e6fdfc302c14 );
    zm_quest::register_quest_step( #"mantis_mq", #"play_jacks_game", &setup_play_jacks_game, &cleanup_play_jacks_game );
    zm_quest::register_quest_step( #"mantis_mq", #"deliver_sheet_music", &setup_deliver_sheet_music, &cleanup_deliver_sheet_music );
    zm_quest::register_quest_step( #"mantis_mq", #"prepare_final_fight", &setup_prepare_final_fight, &cleanup_prepare_final_fight );
    zm_quest::register_quest_step( #"mantis_mq", #"start_boss_fight", &setup_start_boss_fight, &cleanup_start_boss_fight );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xf344fd8d, Offset: 0x30da
// Size: 0x5d5
function init()
{
    level utility::flag_wait( "scriptables_ready" );
    s_piano_past = utility::getstruct( "past_piano_pos" );
    s_piano_past.sbl = spawnscriptable( s_piano_past.script_noteworthy, s_piano_past.origin, s_piano_past.angles );
    s_piano_future = utility::getstruct( "future_piano_pos" );
    s_piano_future.sbl = spawnscriptable( s_piano_future.script_noteworthy, s_piano_future.origin, s_piano_future.angles );
    e_swing_seat = getent( "twins_swing_seat_future", #targetname );
    e_swing_seat hidepart( "j_wood_le" );
    s_past_swing_seat = utility::getstruct( "twins_swing_seat_past", "targetname" );
    s_past_swing_seat scene::init();
    growth_tree_clip = utility::getent_or_struct( "growth_tree_clip", "targetname" );
    
    if ( isdefined( growth_tree_clip ) )
    {
        growth_tree_clip connectpaths();
        growth_tree_clip hide();
    }
    
    hide_model_clip( "sapling_tree_clip" );
    hide_model_clip( "swing_clip_future" );
    hide_model_clip( "future_toy_box_clip" );
    zone_spawner::function_2ce7db1d59b307d8( "zone_street_5_f_garage" );
    
    if ( !getdvarint( @"enable_mantis_mq", 0 ) )
    {
        toy_box_clip = utility::getent_or_struct( "toy_box_clip", "targetname" );
        
        if ( isdefined( toy_box_clip ) )
        {
            toy_box_clip connectpaths();
            toy_box_clip hide();
        }
        
        return;
    }
    
    level._effect[ "new_zombie_soul_trail" ] = loadfxasset( "vfx_sat_mantis_loot_cyst_trail" );
    level._effect[ "fireplace_ambient" ] = loadfxasset( "vfx_sat_levels_zm_mantis_hopscotch_fireplace_fire_green" );
    level._effect[ "music_box_ambient" ] = loadfxasset( "vfx_sat_levels_zm_mantis_musical_ambient" );
    level._effect[ "zombie_game_spawn" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_zmb_despawn_torso" );
    level._effect[ "zombiejacks_ball_disappear" ] = loadfxasset( "vfx_t10_gameplay_zm_magic_box_bunny_rarity_white_disappear" );
    level._effect[ "zombie_ball_bounce" ] = loadfxasset( "vfx_sat_levels_zm_mantis_music_sheet_play_ball" );
    level._effect[ "hopscotch_success" ] = loadfxasset( "vfx_sat_levels_zm_mantis_hopscotch_course_complete" );
    level._effect[ "hopscotch_bad_cell" ] = loadfxasset( "vfx_sat_signage_graphic_chalk_drawing_shadow" );
    level._effect[ "music_note_ball_drop" ] = loadfxasset( "vfx_sat_levels_zm_mantis_music_sheet_ball_drop_impact" );
    level._effect[ "zombiejack_despawn" ] = loadfxasset( "vfx_sat_levels_zm_mantis_music_sheet_zombie_despawn" );
    level._effect[ "irradiated_seed" ] = loadfxasset( "vfx_sat_levels_zm_mantis_pack_seeds_green" );
    level._effect[ "magic_tree_full_grown" ] = loadfxasset( "vfx_sat_mantis_luminous_lone_cypress_mist_full_grown" );
    level._effect[ "two_sister_scene_ambient" ] = loadfxasset( "vfx_sat_levels_zm_mantis_twins_location_amb" );
    level._effect[ "two_sister_scene_energy_ball_spawn" ] = loadfxasset( "vfx_sat_levels_zm_mantis_twins_energy_ball_spawn" );
    level._effect[ "two_sister_scene_energy_ball_despawn" ] = loadfxasset( "vfx_sat_levels_zm_mantis_twins_energy_ball_despawn" );
    level._effect[ "two_sister_scene_energy_ball_trial" ] = loadfxasset( "vfx_sat_levels_zm_mantis_mq_step5b_guide_player_spirit" );
    level._effect[ "seed_into_ground" ] = loadfxasset( "vfx_sat_mantis_luminous_lone_cypress_seed_into_ground" );
    level._effect[ "goggles_pickup" ] = loadfxasset( "vfx_sat_levels_zm_mantis_goggles_pickup" );
    level._effect[ "foursquare_success" ] = loadfxasset( "vfx_sat_levels_zm_mantis_foursquare_course_complete" );
    level._effect[ "zombiejacks_success" ] = loadfxasset( "vfx_sat_levels_zm_mantis_music_sheet_chalk_circle_complete" );
    level._effect[ "musical_item_spawn" ] = loadfxasset( "vfx_sat_levels_zm_mantis_musical_ground_portal" );
    level._effect[ "musical_item_soul_impact" ] = loadfxasset( "vfx_sat_levels_zm_mantis_musical_soul_impact" );
    level._effect[ "musical_item_despawn" ] = loadfxasset( "vfx_sat_levels_zm_mantis_musical_pulse" );
    level._effect[ "music_note_interact_vfx" ] = loadfxasset( "vfx_sat_levels_zm_mantis_music_sheet_order_confirm" );
    level._effect[ "chalk_stick_ambient" ] = loadfxasset( "vfx_sat_levels_mantis_chalk_stick_energy" );
    level._effect[ "zombie_soul_trasition" ] = loadfxasset( "vfx_sat_gameplay_zm_ww_mantis2_soul_transition" );
    level._effect[ "zombie_soul_trasition_dog" ] = loadfxasset( "vfx_sat_gameplay_zm_ww_mantis2_soul_transition_dog" );
    level._effect[ "zombie_soul_trasition_mimic" ] = loadfxasset( "vfx_sat_gameplay_zm_ww_mantis2_soul_transition_mimic" );
    level._effect[ "sapling_soul_impact" ] = loadfxasset( "vfx_sat_mantis_luminous_lone_cypress_souls_hit" );
    level._effect[ "molotov_impact" ] = loadfxasset( "vfx_sat_zm_strange_firewood_molotov_impact" );
    level._effect[ "lost_soul_orb" ] = loadfxasset( "vfx_sat_levels_zm_mantis_mq_step5b_guide_player_spirit" );
    init_mq_models();
    visibility_mode::function_ceeb7b4ab2524022( "body_c_sat_zmb_dlc2_npc_sister_skeletal" );
    visibility_mode::function_ceeb7b4ab2524022( "body_c_sat_zmb_dlc2_npc_sister_spectral" );
    visibility_mode::function_ceeb7b4ab2524022( "head_c_sat_zmb_dlc2_npc_sister_skeletal" );
    visibility_mode::function_ceeb7b4ab2524022( "head_c_sat_zmb_dlc2_npc_sister_spectral" );
    level callback::add( "quest_item_used", &on_quest_item_pickup );
    
    if ( !zm_quest::function_b0a5181ebe7bb905() )
    {
        level callback::add( "special_round_start", &on_special_round_end );
    }
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level utility::flag_wait( "zm_save_level_restore_complete" );
    }
    
    level thread zm_quest::start_quest( #"mantis_mq" );
    level.s_mantis_mq = zm_quest::get_quest( #"mantis_mq" );
    level thread function_a42f003924c36a70();
    
    if ( !threatbiasgroupexists( "zm_mantis_zombie_regular_threat" ) )
    {
        createthreatbiasgroup( "zm_mantis_zombie_regular_threat" );
    }
    
    if ( !threatbiasgroupexists( "zm_mantis_player_threat" ) )
    {
        createthreatbiasgroup( "zm_mantis_player_threat" );
    }
    
    if ( !threatbiasgroupexists( "zm_mantis_progressing_minigame_threat" ) )
    {
        createthreatbiasgroup( "zm_mantis_progressing_minigame_threat" );
    }
    
    if ( !threatbiasgroupexists( "zm_mantis_quest_zombie_threat" ) )
    {
        createthreatbiasgroup( "zm_mantis_quest_zombie_threat" );
    }
    
    if ( !callback::exists( "on_zombie_ai_spawned", &function_c5bb4457f9b74f92 ) )
    {
        level callback::add( "on_zombie_ai_spawned", &function_c5bb4457f9b74f92 );
    }
    
    setignoremegroup( "zm_mantis_progressing_minigame_threat", "zm_mantis_zombie_regular_threat" );
    
    /#
        init_mq_devgui();
    #/
}

// Namespace zm_sat_mantis_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xf4a44fc5, Offset: 0x36b7
// Size: 0x29
function private function_a42f003924c36a70()
{
    level utility::flag_wait( "wwu_weapon_retrieved" );
    level callback::add( "pre_timetravel_done", &on_timetravel );
    waitframe();
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x2ea2de4f, Offset: 0x36e8
// Size: 0x161b
function function_4ef47d3c5c627fb6()
{
    if ( !utility::flag( "wwu_weapon_retrieved" ) || utility::flag( "start_boss_fight" ) || !zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level.next_obj_data = undefined;
    
    if ( !isdefined( level.s_rcxd_controller.mdl ) && !utility::flag( "rcxd_used" ) )
    {
        level.next_obj_step = #"next_round";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "rcxd_used" ) )
    {
        level.next_obj_data = [ [ level.s_rcxd_controller.mdl ] ];
        level.next_obj_step = #"remote";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "rcxd_wayp_1" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "rcw0" ) ] ];
        level.next_obj_step = #"rc_course";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "rcxd_wayp_2" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "rcw1" ) ] ];
        level.next_obj_step = #"rc_course";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "rcxd_wayp_3" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "rcw2" ) ] ];
        level.next_obj_step = #"rc_course";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "garage_door_opened" ) )
    {
        level.next_obj_data = [ [ utility::getent_or_struct( "flammable_in_garage", "targetname" ).origin ] ];
        level.next_obj_step = #"rc_course";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "burned_husk_dissolved" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "s_gh_cd_in_ge", "targetname" ), 50 ] ];
        level.next_obj_step = #"garage";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "chalk_picked_up" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "s_item_chalk", "targetname" ) ] ];
        level.next_obj_step = #"chalk_get";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "drop_past_swing_seat" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "past_swing_seat", "targetname" ) ] ];
        level.next_obj_step = #"swing_break";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "swing_seat_picked_up" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "past_seat_item_pos", "targetname" ), 10 ] ];
        level.next_obj_step = #"swing_get";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "placed_swing_seat" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "future_ghost_child", "targetname" ), -15 ] ];
        level.next_obj_step = #"swing_fix";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "returned_chalk" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "future_ghost_child", "targetname" ), -15 ] ];
        level.next_obj_step = #"chalk_give";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "pickup_magic_seed" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "future_toolbox", "targetname" ) ] ];
        level.next_obj_step = #"seeds_get";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "planted_tree" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "past_magic_tree_pos", "targetname" ) ] ];
        level.next_obj_step = #"seeds_plant";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "tree_charged" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "past_magic_tree_pos", "targetname" ) ], [ utility::getstruct( "past_magic_tree_pos", "targetname" ), 0, 500 ] ];
        level.next_obj_step = #"sapling_feed";
        level.next_obj_timeline = "past";
        zm_quest::function_cd1f2fee4749fb0a( 1, #"mantis_mq_guidance", #"sapling_feed" );
        zm_quest::function_c2af37f835cd840b( 30, 1, #"mantis_mq_guidance", #"sapling_feed" );
    }
    else if ( !utility::flag( "all_strange_firewood_collected" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "future_magic_tree_pos", "targetname" ) ] ];
        level.next_obj_step = #"tree_harvest";
        level.next_obj_timeline = "future";
        level zm_quest::function_9f49b2a045ece8ae( zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"hash_a0bc753abd1bbc2a" ) ?? 0, 1, #"mantis_mq_guidance", #"tree_harvest" );
    }
    else if ( !utility::flag( "all_firewood_placed" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "fireplace_interaction", "targetname" ) ] ];
        level.next_obj_step = #"place_lumber";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "fireplace_light_on" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "fireplace_interaction", "targetname" ) ] ];
        level.next_obj_step = #"light_fire";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "can_start_hopscotch_game" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "hopscotch_x_pos_future", "targetname" ) ] ];
        level.next_obj_step = #"mb_x";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "hopscotch_ready" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "hopscotch_center", "targetname" ) ] ];
        level.next_obj_step = #"mb_x_return";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "progressing_mini_games" ) && !utility::flag( "hopscotch_success" ) && utility::flag( "mini_game_cooldown" ) )
    {
        level.next_obj_step = #"wait_mb";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "progressing_mini_games" ) && !utility::flag( "hopscotch_success" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "hopscotch_start_pos", "targetname" ) ] ];
        level.next_obj_step = #"play_game";
        level.next_obj_timeline = "past";
    }
    else if ( utility::flag( "progressing_mini_games" ) && !utility::flag( "hopscotch_success" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "hopscotch_center", "targetname" ) ] ];
        level.next_obj_step = #"hopscotch";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "music_box_delivered" ) )
    {
        level.next_obj_data = [ [ level.s_music_box.mdl ] ];
        level.next_obj_step = #"mb_guide";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "toy_box_opened" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "toy_box", "targetname" ) ] ];
        level.next_obj_step = #"box_open";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "goggles_fell" ) )
    {
        level.next_obj_data = [ [ level.s_maxis_goggles.mdl ] ];
        level.next_obj_step = #"goggles_fall";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "pickup_maxis_goggles" ) )
    {
        level.next_obj_data = [ [ level.s_maxis_goggles.mdl ?? level.var_91c2adbfffbfede5 ], [ utility::getstruct( "zm_sat_mantis_perk_machine_choice_instance", "target" ), 110 ] ];
        level.next_obj_step = #"goggles_wisp";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "pickup_maxis_headset" ) )
    {
        level.next_obj_data = [ [ level.var_21835960007b87e4.parent_struct ], [ utility::getstruct( "zm_sat_mantis_perk_machine_choice_instance", "target" ), 110 ] ];
        level.next_obj_step = #"hash_e3af7b91ad003101";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "placed_maxis_goggles" ) || !utility::flag( "placed_maxis_headset" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "toy_box", "targetname" ) ] ];
        level.next_obj_step = #"box_place";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "ball_set" ) )
    {
        level.next_obj_data = [ [ level.start_pos.var_6fdd2f80be44e1bf ], [ utility::getstruct( "foursquare_x_pos_future", "targetname" ) ] ];
        level.next_obj_step = #"ball";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "foursquare_ready" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "foursquare_center", "targetname" ) ] ];
        level.next_obj_step = #"hash_37805b2cbf98d82";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "progressing_mini_games" ) && !utility::flag( "foursquare_success" ) && utility::flag( "mini_game_cooldown" ) )
    {
        level.next_obj_step = #"hash_9b8e3d090c5983ec";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "progressing_mini_games" ) && !utility::flag( "foursquare_success" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "foursquare_start_pos", "targetname" ) ] ];
        level.next_obj_step = #"play_game";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "monkey_cymbals_delivered" ) )
    {
        level.next_obj_data = [ [ level.s_cymbals.mdl ] ];
        level.next_obj_step = #"hash_c817593a44b801ef";
        level.next_obj_timeline = "past";
    }
    else if ( ( !isalive( level.piano_teacher ) || level.piano_teacher.subclass != "zombie_piano_teacher" ) && !utility::flag( "piano_opened" ) )
    {
        level.next_obj_data = [ [ ( 54920, -29770, -65 ), 0, 400 ] ];
        level.next_obj_step = #"teacher_wait";
        level.next_obj_timeline = "future";
    }
    else if ( isalive( level.piano_teacher ) && !level.piano_teacher.var_923fd785fff9159b && !utility::flag( "piano_opened" ) )
    {
        level.next_obj_data = [ [ level.piano_teacher, 90 ] ];
        level.next_obj_step = #"teacher_rot";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "piano_teacher_teleport_to_past" ) )
    {
        level.next_obj_data = [ [ level.timewarps.instances[ 1 ], 110 ] ];
        level.next_obj_step = #"teacher_jump";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "teacher_done" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "past_piano_pos" ), 70 ] ];
        level.next_obj_step = #"teacher_return";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "music_notes_puzzle_completed" ) && utility::flag( "notes_cooldown" ) )
    {
        level.next_obj_step = #"wait_sm";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "music_notes_puzzle_completed" ) )
    {
        level.next_obj_data = [ [ level.music_note.a_notes[ level.music_note.used_notes.size ?? 0 ] ] ];
        level.next_obj_step = #"notes_find";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "start_lost_soul_collection" ) && utility::flag( "piano_cooldown" ) )
    {
        level.next_obj_step = #"wait_sm";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "start_lost_soul_collection" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "past_piano_pos" ), 40 ] ];
        level.next_obj_step = #"notes_play";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "all_lost_soul_balls_arrived" ) )
    {
        level.next_obj_step = #"tortured";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "zombiejacks_ready" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "zombiejacks_center" ) ] ];
        level.next_obj_step = #"hash_5808e8d409ef5b5d";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "progressing_mini_games" ) && !utility::flag( "zombiejacks_success" ) && utility::flag( "mini_game_cooldown" ) )
    {
        level.next_obj_step = #"wait_sm";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "progressing_mini_games" ) && !utility::flag( "zombiejacks_success" ) )
    {
        level.next_obj_data = [ [ utility::getstruct( "zombiejacks_start_pos" ) ] ];
        level.next_obj_step = #"play_game";
        level.next_obj_timeline = "past";
    }
    else if ( utility::flag( "progressing_mini_games" ) && !utility::flag( "zombiejacks_success" ) )
    {
        level.next_obj_step = #"jacks";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "sheet_music_delivered" ) )
    {
        level.next_obj_data = [ [ level.s_sheet_music.mdl ] ];
        level.next_obj_step = #"sm_guide";
        level.next_obj_timeline = "past";
    }
    else if ( !utility::flag( "has_set_clock_time_for_mq" ) )
    {
        level.next_obj_data = [ [ level.var_1afbd4d6fe9ef1fe.var_5dc0cb5a45082cad[ 0 ] ] ];
        level.next_obj_step = #"clock";
        level.next_obj_timeline = "future";
    }
    else if ( !utility::flag( "final_twins_scenes_complete" ) )
    {
        level.next_obj_data = [ [ level.vfx_proxy ] ];
        level.next_obj_step = #"twins";
        level.next_obj_timeline = "past";
    }
    else
    {
        level.next_obj_data = [ [ utility::getstruct( "boss_fight_start" ) ] ];
        level.next_obj_step = #"boss_prepare";
        level.next_obj_timeline = "past";
    }
    
    if ( time_travel::get_current_timeline().name == "past" && level.next_obj_timeline != "past" )
    {
        if ( !utility::flag( "returned_chalk" ) )
        {
            level.next_obj_data = [ [ level.timewarps.instances[ 0 ], 110 ] ];
            level.next_obj_step = #"hash_9556a3cace7b3f05";
        }
        else if ( !utility::flag( "music_box_delivered" ) )
        {
            level.next_obj_data = [ [ level.timewarps.instances[ 0 ], 110 ] ];
            level.next_obj_step = #"hash_9556a0cace7b39ec";
        }
        else if ( !utility::flag( "monkey_cymbals_delivered" ) )
        {
            level.next_obj_data = [ [ level.timewarps.instances[ 0 ], 110 ] ];
            level.next_obj_step = #"hash_9556a1cace7b3b9f";
        }
        else if ( !utility::flag( "sheet_music_delivered" ) )
        {
            level.next_obj_data = [ [ level.timewarps.instances[ 0 ], 110 ] ];
            level.next_obj_step = #"hash_95569ecace7b3686";
        }
        else
        {
            level.next_obj_data = [ [ level.timewarps.instances[ 0 ], 110 ] ];
            level.next_obj_step = #"hash_95569fcace7b3839";
        }
    }
    else if ( time_travel::get_current_timeline().name == "future" && level.next_obj_timeline != "future" )
    {
        if ( !utility::flag( "returned_chalk" ) )
        {
            level.next_obj_data = [ [ level.timewarps.instances[ 1 ], 110 ] ];
            level.next_obj_step = #"hash_13b514a7a5cc8e04";
        }
        else if ( !utility::flag( "music_box_delivered" ) )
        {
            level.next_obj_data = [ [ level.timewarps.instances[ 1 ], 110 ] ];
            level.next_obj_step = #"hash_13b517a7a5cc931d";
        }
        else if ( !utility::flag( "monkey_cymbals_delivered" ) )
        {
            level.next_obj_data = [ [ level.timewarps.instances[ 1 ], 110 ] ];
            level.next_obj_step = #"hash_13b516a7a5cc916a";
        }
        else if ( !utility::flag( "sheet_music_delivered" ) )
        {
            level.next_obj_data = [ [ level.timewarps.instances[ 1 ], 110 ] ];
            level.next_obj_step = #"hash_13b511a7a5cc88eb";
        }
        else
        {
            level.next_obj_data = [ [ level.timewarps.instances[ 1 ], 110 ] ];
            level.next_obj_step = #"hash_13b510a7a5cc8738";
        }
    }
    
    thread zm_quest::update_guidance( level.next_obj_data, #"mantis_mq_guidance", level.next_obj_step );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x9c0cc7ce, Offset: 0x4d0b
// Size: 0x1a
function function_c4348e073a6dd322()
{
    if ( !utility::flag( "wwu_weapon_retrieved" ) )
    {
        return;
    }
    
    level zm_quest::clear_all_guidance();
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x4b0ec82e, Offset: 0x4d2d
// Size: 0x27
function on_timetravel( params )
{
    function_c4348e073a6dd322();
    level waittill( #"timetravel_done" );
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x617e4772, Offset: 0x4d5c
// Size: 0x33
function function_c5bb4457f9b74f92( params )
{
    self endon( #"death" );
    wait 1;
    
    if ( self.var_9ee436be1a5adf9c )
    {
        return;
    }
    
    self setthreatbiasgroup( "zm_mantis_zombie_regular_threat" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x4d26a1f8, Offset: 0x4d97
// Size: 0x40
function on_special_round_end( params )
{
    level utility::flag_set( "gonna_timetravel_after_special_round" );
    level utility::flag_wait( "timetravel_ongoing" );
    level utility::flag_waitopen( "timetravel_ongoing" );
    level utility::flag_clear( "gonna_timetravel_after_special_round" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x8567eb40, Offset: 0x4ddf
// Size: 0x1c8
function init_mq_models()
{
    a_mq_models = utility::getstructarray( "mq_models", "targetname" );
    
    foreach ( s_model in a_mq_models )
    {
        s_model.sbl = spawnscriptable( "sat_zm_sat_scriptable_mantis_mq_model_proxy", s_model.origin, s_model.angles );
        s_model.sbl setscriptablepartstate( "base", s_model.script_noteworthy );
    }
    
    past_swing_seat = utility::getstruct( "past_swing_seat", "targetname" );
    past_swing_seat.mdl = utility::spawn_model( past_swing_seat.script_noteworthy, past_swing_seat.origin, past_swing_seat.angles );
    s_seed_box = utility::getstruct( "future_toolbox", "targetname" );
    s_seed_box.sbl = spawnscriptable( s_seed_box.script_noteworthy, s_seed_box.origin, s_seed_box.angles );
    function_97fc663d165aa881( "plant_tree_pos" );
    function_97fc663d165aa881( "past_plant_tree_pos" );
    s_toy_box = utility::getstruct( "toy_box" );
    s_toy_box.sbl = utility::spawn_model( s_toy_box.script_noteworthy, s_toy_box.origin, s_toy_box.angles );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x57bd1705, Offset: 0x4faf
// Size: 0x2a1
function on_quest_item_pickup( params )
{
    itembundle = params.bundle;
    item = params.scriptable;
    player = params.player;
    
    switch ( itembundle.ref )
    {
        case #"hash_5654ac66c391da29":
            level utility::flag_set( "swing_seat_picked_up" );
            zm_quest::show_splash_item_picked_up( #"twins", #"swing", 1, player );
            player utility::delaythread( 1.5, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"pick_up_swing_seat", #"hash_5212ed7ec42f115a" );
            playsoundatpos( item.origin, #"hash_418bfcf2bfd8256d" );
            function_4ef47d3c5c627fb6();
            break;
        case #"hash_62091767a1823c7c":
            zm_quest::show_splash_item_picked_up( #"music_box", #"firewood", 1, player );
            
            if ( !utility::flag( "picked_up_firewood_vo_played" ) )
            {
                level utility::flag_set( "picked_up_firewood_vo_played" );
                level utility::delaythread( 1.5, &battlechatter_mp::trysaylocalsound, player, #"bc_flavor_player_positive" );
            }
            
            level notify( #"hash_894b243c2f8a62a6" );
            break;
        case #"hash_1f82b2c79dadb3b6":
            level utility::flag_set( "pickup_maxis_goggles" );
            zm_quest::function_b57dfe9625966b0b( #"child_cymbals", 0, #"maxis_goggles", 1, 1 );
            zm_quest::function_4eefe6de31f5ddab( #"mantis_mq", #"picked_up_maxis_goggles", 1 );
            zm_quest::show_splash_item_picked_up( #"child_cymbals", #"maxis_goggles", 1, player );
            playfx( level._effect[ "goggles_pickup" ], item.origin );
            
            foreach ( other_player in level.players )
            {
                other_player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_mantis_artifact_5" );
            }
            
            utility::delaythread( 1.5, &zm_quest::function_d5ef98341fd6a057, [ #"hash_a6f5cdb601fcaf13", #"hash_a6f5ceb601fcb0c6" ] );
            function_4ef47d3c5c627fb6();
            break;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x4a150c83, Offset: 0x5258
// Size: 0x5c
function setup_open_garage( b_skipped, b_restored )
{
    if ( b_restored )
    {
        level utility::flag_wait( "scriptables_ready" );
    }
    
    level thread setup_swing_seat();
    
    if ( b_skipped )
    {
        return;
    }
    
    level thread init_rcxd_controller();
    level callback::add( "rcxd_exploded", &function_b0694091c8b4452f );
    level utility::flag_wait( "garage_door_opened" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x132f5375, Offset: 0x52bc
// Size: 0x172
function light_twins()
{
    lights = getentarray( "light_twins", #targetname );
    
    if ( !isdefined( lights ) )
    {
        return;
    }
    
    level utility::flag_wait( "begin_round_logic" );
    
    foreach ( light in lights )
    {
        light function_fcf6b815538e1f54( 1 );
    }
    
    while ( true )
    {
        if ( zm_quest::function_33e20bfbb976c774( "zone_street_5_f_garage" ) )
        {
            break;
        }
        
        waitframe();
    }
    
    activateworldevent( "we_lgt_twins" );
    
    foreach ( light in lights )
    {
        light function_fcf6b815538e1f54( 0 );
    }
    
    function_cb97fa0cd1866090( 1 );
    wait 6;
    level utility::flag_set( "burned_husk_dissolved" );
    function_c4348e073a6dd322();
    wait 6;
    deactivateworldevent( "we_lgt_twins" );
    function_cb97fa0cd1866090( 0 );
    level utility::flag_set( "twins_lights_movie_end" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xc614ebdd, Offset: 0x5436
// Size: 0x2eb
function setup_swing_seat()
{
    level endon( #"game_ended" );
    s_past_swing_seat = utility::getstruct( "twins_swing_seat_past", "targetname" );
    model = s_past_swing_seat scene::get_entity( "Prop 1" );
    model setcandamage( 1 );
    model thread past_swing_seat_damage_check();
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"swing_seat_picked_up" ) )
    {
        level utility::flag_set( "drop_past_swing_seat" );
    }
    
    level utility::flag_wait( "drop_past_swing_seat" );
    model hidepart( "j_wood_le" );
    s_past_swing_seat thread scene::play();
    past_swing_seat = utility::getstruct( "past_swing_seat", "targetname" );
    var_c26fac8c30b1315f = utility::getstruct( "past_seat_item_pos", "targetname" );
    
    if ( !zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"swing_seat_picked_up" ) )
    {
        level thread zm_quest::drop_quest_item( past_swing_seat.origin, var_c26fac8c30b1315f.origin, %"hash_5f013d3fefc7915e" );
    }
    
    if ( isdefined( past_swing_seat.mdl ) )
    {
        past_swing_seat.mdl unlink();
        past_swing_seat.mdl delete();
    }
    
    hide_model_clip( "swing_clip_past" );
    function_4ef47d3c5c627fb6();
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"swing_seat_picked_up" ) )
    {
        level utility::flag_set( "swing_seat_picked_up" );
    }
    
    level utility::flag_wait( "swing_seat_picked_up" );
    zm_quest::function_b57dfe9625966b0b( #"twins", 0, #"swing", 1, 1 );
    zm_quest::function_4eefe6de31f5ddab( #"mantis_mq", #"swing_seat_picked_up", 1 );
    var_c4b0f532aeab00ba = utility::getstruct( "future_ghost_child", "targetname" );
    var_c4b0f532aeab00ba.interaction = zm_quest::function_91f9590e98d57ff6( var_c4b0f532aeab00ba.origin, &function_bb6baf8aea3e404e, &function_1f185b3adfec07aa );
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"placed_swing_seat" ) )
    {
        level utility::flag_set( "placed_swing_seat" );
    }
    
    level utility::flag_wait( "placed_swing_seat" );
    
    if ( !zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"placed_swing_seat" ) )
    {
        level thread zm_quest::play_vo_events( [ #"hash_90e87ce4145b5ee3", #"hash_9ab977a28ab11c9b" ] );
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"mantis_mq", #"placed_swing_seat", 1 );
    e_swing_seat = getent( "twins_swing_seat_future", #targetname );
    
    if ( isdefined( e_swing_seat ) )
    {
        e_swing_seat showpart( "j_wood_le" );
        e_swing_seat utility::playsoundontag( #"hash_c75a91ada275d94b", "j_wood_le" );
    }
    
    var_c4b0f532aeab00ba.interaction zm_quest::function_9170db4686f796e2();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x8b6c97b5, Offset: 0x5729
// Size: 0x23a
function init_rcxd_controller()
{
    level endon( #"game_ended" );
    level.s_rcxd_controller = utility::getstruct( "rcxd_controller" );
    level.s_rcxd_controller.var_38b77197c6ee907c = utility::getstructarray( level.s_rcxd_controller.target );
    level.s_rcxd_controller.var_38b77197c6ee907c = arrayrandomize( level.s_rcxd_controller.var_38b77197c6ee907c );
    index = 0;
    
    while ( !utility::flag( "garage_door_opened" ) )
    {
        level waittill( #"on_round_end" );
        
        if ( utility::issharedfuncdefined( #"zm_quest", #"hash_9b839bc2ba7777ff" ) )
        {
            var_a81841bc137db5cd = utility::callsharedfunc( #"zm_quest", #"hash_9b839bc2ba7777ff" );
        }
        
        if ( !var_a81841bc137db5cd )
        {
            continue;
        }
        
        if ( isdefined( level.s_rcxd_controller.mdl ) )
        {
            continue;
        }
        
        var_6a359d5e434a35d6 = level.s_rcxd_controller.var_38b77197c6ee907c[ index ];
        level.s_rcxd_controller.mdl = utility::spawn_model( var_6a359d5e434a35d6.script_noteworthy, var_6a359d5e434a35d6.origin, var_6a359d5e434a35d6.angles );
        level.s_rcxd_controller.interaction = zm_quest::function_91f9590e98d57ff6( var_6a359d5e434a35d6.origin, &on_use_rcxd_controller, &hint_rcxd_controller, "small_unusablewhenobstructed" );
        function_4ef47d3c5c627fb6();
        level waittill( #"rcxd_controller_used", player );
        level.s_rcxd_controller.mdl delete();
        level.s_rcxd_controller.interaction zm_quest::function_9170db4686f796e2();
        player function_70e46aeb1d4397aa();
        index++;
        
        if ( index >= level.s_rcxd_controller.var_38b77197c6ee907c.size )
        {
            index = 0;
        }
        
        level utility::waittill_any( "quest_rcxd_exploded", "garage_door_opened", "failed_spawn_quest_rcxd" );
        
        if ( isdefined( player ) )
        {
            player thread set_player_ignoreme( 0, "mantis_rc_step" );
        }
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x3aef4d01, Offset: 0x596b
// Size: 0x88
function hint_rcxd_controller( instance, player )
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) || !zm_quest::function_b0a5181ebe7bb905() || player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/activate", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xbb2fc36a, Offset: 0x59fc
// Size: 0x65
function on_use_rcxd_controller( player )
{
    if ( !zm_quest::function_f98968f17772726c( zm_quest::function_b0a5181ebe7bb905() ) || utility::flag( "gonna_timetravel_after_special_round" ) )
    {
        return;
    }
    
    if ( player isdiving() )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        return;
    }
    
    level notify( #"rcxd_controller_used", player );
    level utility::flag_set( "rcxd_used" );
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xa239f142, Offset: 0x5a69
// Size: 0xf7
function function_70e46aeb1d4397aa()
{
    level endon( #"game_ended" );
    self playsoundtoplayer( #"hash_ed2a8163d0d38b59", self );
    level thread game_utility::fadetoblackforplayer( self, 1, 0.3 );
    s_rcxd_start_pos = utility::getstruct( "rcxd_start_pos" );
    streakinfo = killstreak_utility::createstreakinfo( "rcxd", self );
    streakinfo.debug_state = "begin_use";
    rcxd_params = { #uniquespawnpos:s_rcxd_start_pos.origin, #var_697ba588b4258b14:&function_f412d105abc0a104 };
    level.var_6619e75ea5ba9238 = 1;
    b_success = rcxd_shared::function_bdbc99e904937454( streakinfo, rcxd_params );
    
    if ( !b_success )
    {
        /#
            iprintlnbold( "<dev string:x62>" );
        #/
        
        level notify( #"failed_spawn_quest_rcxd" );
    }
    else
    {
        thread set_player_ignoreme( 1, "mantis_rc_step" );
    }
    
    waitframe();
    level thread game_utility::fadetoblackforplayer( self, 0, 0.3 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x492c009d, Offset: 0x5b68
// Size: 0xf6
function function_f412d105abc0a104( rcxd )
{
    s_rcxd_start_pos = utility::getstruct( "rcxd_start_pos" );
    rcxd.aether_attach = utility::spawn_model( %"veh_sat_mil_drone_rcxd_aether_attach", rcxd gettagorigin( "tag_body_animate" ), rcxd gettagangles( "tag_body_animate" ) );
    rcxd.aether_attach linkto( rcxd, "tag_body_animate" );
    rcxd.var_12acb9ede51e6bc8 = 1;
    rcxd.var_24715590a2643 = 1;
    leftvector = vectornormalize( anglestoleft( s_rcxd_start_pos.angles ) );
    backvector = vectornormalize( -1 * anglestoforward( s_rcxd_start_pos.angles ) );
    rcxd vehicle_teleport( s_rcxd_start_pos.origin + 40 * leftvector + 30 * backvector, s_rcxd_start_pos.angles );
    rcxd thread function_c48e80340c50d644();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x67c695b5, Offset: 0x5c66
// Size: 0xce
function function_c48e80340c50d644()
{
    level endon( #"game_ended" );
    level endon( #"quest_rcxd_exploded" );
    level endon( #"garage_door_opened" );
    var_98442ec862dc96b = 0;
    n_waypoints = utility::getstructarray( "rc_wayp", "script_noteworthy" ).size;
    v_waypoints = [];
    
    for ( i = 0; i < n_waypoints ; i++ )
    {
        v_waypoints[ i ] = utility::getstruct( "rcw" + i ).origin;
    }
    
    while ( var_98442ec862dc96b < n_waypoints )
    {
        if ( distance( v_waypoints[ var_98442ec862dc96b ], self.origin ) < 50 )
        {
            var_98442ec862dc96b++;
            utility::flag_set( "rcxd_wayp_" + var_98442ec862dc96b );
            function_4ef47d3c5c627fb6();
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xc0d6a5a2, Offset: 0x5d3c
// Size: 0x12b
function function_b0694091c8b4452f( params )
{
    if ( !params.rcxd.var_12acb9ede51e6bc8 )
    {
        return;
    }
    
    if ( isdefined( params.rcxd.aether_attach ) )
    {
        params.rcxd.aether_attach unlink();
        params.rcxd.aether_attach delete();
    }
    
    level notify( #"quest_rcxd_exploded" );
    var_ed8bab9657750de2 = params.rcxd.origin;
    s_garage_door_damage_pos = utility::getent_or_struct( "flammable_in_garage", "targetname" );
    
    if ( distancesquared( var_ed8bab9657750de2, s_garage_door_damage_pos.origin ) > squared( 250 ) )
    {
        level utility::flag_clear( "rcxd_used" );
        level utility::flag_clear( "rcxd_wayp_1" );
        level utility::flag_clear( "rcxd_wayp_2" );
        level utility::flag_clear( "rcxd_wayp_3" );
        function_4ef47d3c5c627fb6();
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x87>" );
    #/
    
    level utility::flag_set( "garage_door_opened" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xeadf4d07, Offset: 0x5e6f
// Size: 0x17e
function cleanup_open_garage( b_skipped, b_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "garage_door_opened" );
        level utility::flag_set( "rcxd_used" );
    }
    
    level utility::flag_set( "rcxd_wayp_1" );
    level utility::flag_set( "rcxd_wayp_2" );
    level utility::flag_set( "rcxd_wayp_3" );
    zone_spawner::function_8a020f24a3b73c79( "zone_street_5_f_garage" );
    level callback::remove( "rcxd_exploded", &function_b0694091c8b4452f );
    s_garage_door = utility::getstruct( "garage_door", "targetname" );
    
    if ( isdefined( s_garage_door.sbl ) )
    {
        activateworldevent( "we_lgt_mantis_explode_garage_door" );
        s_garage_door.sbl utility::function_7c10ea82c1e305b8( "base", "expo" );
        utility::delaythread( 2, &function_6306e4b53a7a8db7 );
    }
    
    s_garage_door_damage_pos = utility::getent_or_struct( "flammable_in_garage", "targetname" );
    s_garage_door_damage_pos delete();
    clip_garage_door = getent( "clip_garage_door", #targetname );
    
    if ( isdefined( clip_garage_door ) )
    {
        clip_garage_door connectpaths();
        clip_garage_door delete();
    }
    
    s_rcxd_controller = utility::getstruct( "rcxd_controller" );
    
    if ( isdefined( s_rcxd_controller.mdl ) )
    {
        s_rcxd_controller.mdl delete();
    }
    
    if ( isdefined( s_rcxd_controller.interaction ) )
    {
        s_rcxd_controller.interaction zm_quest::function_9170db4686f796e2();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x73941c34, Offset: 0x5ff5
// Size: 0x55
function function_6306e4b53a7a8db7()
{
    s_shatter = utility::getstruct( "garage_door_wood_shatter" );
    sbl_shatter = spawnscriptable( "sat_zm_sat_scriptable_mantis_mq_model_proxy", s_shatter.origin, s_shatter.angles );
    sbl_shatter utility::function_7c10ea82c1e305b8( "base", "sat_zm_garage_door_wood_shatter" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x841b6a9c, Offset: 0x6052
// Size: 0x283
function setup_collect_chalk( b_skipped, b_restored )
{
    if ( b_skipped )
    {
    }
    
    function_4ef47d3c5c627fb6();
    s_child = utility::getstruct( "s_gh_cd_in_ge", "targetname" );
    s_child thread light_twins();
    var_da2f77eaa8b40312 = utility::getstruct( "s_item_chalk", "targetname" );
    s_child.mdl = spawnscriptable( s_child.script_noteworthy, s_child.origin, s_child.angles );
    scriptable_clip = spawnscriptable( "sat_zm_sat_scriptable_mantis_twins_clip", s_child.origin, s_child.angles );
    level utility::flag_wait( "burned_husk_dissolved" );
    s_child.mdl utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
    wait 2.5;
    scriptable_clip freescriptable();
    s_child.mdl freescriptable();
    wait 0.25;
    level thread dialogue::say( "dx_zm_ffet_esdt_dtwn_ffesdtsgn" );
    level utility::flag_wait( "twins_lights_movie_end" );
    function_4ef47d3c5c627fb6();
    activateworldevent( "we_lgt_husk" );
    var_da2f77eaa8b40312 = utility::getstruct( "s_item_chalk", "targetname" );
    var_da2f77eaa8b40312.mdl = utility::spawn_model( var_da2f77eaa8b40312.script_noteworthy, var_da2f77eaa8b40312.origin, var_da2f77eaa8b40312.angles );
    var_da2f77eaa8b40312 function_fafaf224bad8c988( "chalk" );
    playfxontag( level._effect[ "chalk_stick_ambient" ], var_da2f77eaa8b40312.mdl, "tag_origin" );
    playsoundatpos( var_da2f77eaa8b40312.origin, #"hash_bcbed56d1f9cab47" );
    var_da2f77eaa8b40312.mdl function_616378d7e5b22efb( anglestoup( var_da2f77eaa8b40312.angles ), 0.5, 3, 3 );
    var_6277aadcd3eff4b1 = utility::getstruct( var_da2f77eaa8b40312.target, "targetname" );
    var_e2fbbf369b8fed00 = zm_quest::function_91f9590e98d57ff6( var_6277aadcd3eff4b1.origin, &on_collect_chalk, &hint_pickup );
    level utility::flag_wait( "chalk_picked_up" );
    playsoundatpos( var_da2f77eaa8b40312.origin, #"hash_f06255d0df66b9fe" );
    var_da2f77eaa8b40312.mdl delete();
    var_da2f77eaa8b40312 function_8ba297827d67c95c();
    var_e2fbbf369b8fed00 zm_quest::function_9170db4686f796e2();
    
    /#
        iprintlnbold( "<dev string:xa5>" );
    #/
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x25036f51, Offset: 0x62dd
// Size: 0x40
function function_999e7efb043caee( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xa3a742e8, Offset: 0x6326
// Size: 0x130
function on_collect_chalk( player )
{
    zm_quest::function_b57dfe9625966b0b( #"twins", 0, #"chalk", 1, 1 );
    zm_quest::show_splash_item_picked_up( #"twins", #"chalk", 1, player );
    player utility::delaythread( 0.5, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"pick_up_chalk", #"hash_5212ed7ec42f115a" );
    
    foreach ( other_player in level.players )
    {
        other_player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_mantis_artifact_1" );
    }
    
    level utility::flag_set( "chalk_picked_up" );
    player thread set_player_ignoreme( 1, "mantis_chalk_picked_up" );
    player thread utility::delaythreadendon( 3, undefined, &set_player_ignoreme, 0, "mantis_chalk_picked_up" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xf331df9, Offset: 0x645e
// Size: 0xcc
function cleanup_collect_chalk( b_skipped, b_restored )
{
    if ( b_skipped || b_restored )
    {
        var_da2f77eaa8b40312 = utility::getstruct( "s_item_chalk", "targetname" );
        
        if ( isdefined( var_da2f77eaa8b40312.item ) )
        {
            var_da2f77eaa8b40312.item freescriptable();
        }
        
        s_model = utility::getstruct( "s_gh_cd_in_ge", "targetname" );
        
        if ( isdefined( s_model.mdl ) )
        {
            s_model.mdl freescriptable();
        }
        
        level utility::flag_set( "burned_husk_dissolved" );
        level utility::flag_set( "chalk_picked_up" );
        zm_quest::function_b57dfe9625966b0b( #"twins", 0, #"chalk", 1, 1 );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x5d6cdd10, Offset: 0x6532
// Size: 0x2f
function setup_repair_seat( b_skipped, b_restored )
{
    if ( b_skipped )
    {
        return;
    }
    
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "placed_swing_seat" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x9c9340a2, Offset: 0x6569
// Size: 0xbf
function past_swing_seat_damage_check()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( objweapon == attacker getcurrentweapon() )
        {
            /#
                iprintlnbold( "<dev string:xc2>" );
            #/
            
            break;
        }
    }
    
    level utility::flag_set( "drop_past_swing_seat" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x54e5aca4, Offset: 0x6630
// Size: 0xc5
function cleanup_repair_seat( b_skipped, b_restored )
{
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "placed_swing_seat" );
        past_swing_seat = utility::getstruct( "past_swing_seat", "targetname" );
        
        if ( isdefined( past_swing_seat.mdl ) )
        {
            past_swing_seat.mdl unlink();
            past_swing_seat.mdl delete();
        }
    }
    
    if ( b_skipped )
    {
        level utility::flag_set( "drop_past_swing_seat" );
        wait 2;
        level utility::flag_set( "swing_seat_picked_up" );
        level utility::flag_set( "placed_swing_seat" );
        zm_quest::function_b57dfe9625966b0b( #"twins", 0, #"swing", 1, 1 );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x8ff9636d, Offset: 0x66fd
// Size: 0x217
function setup_return_chalk( b_skipped, b_restored )
{
    if ( b_skipped )
    {
        return;
    }
    
    function_4ef47d3c5c627fb6();
    s_child = utility::getstruct( "future_ghost_child", "targetname" );
    waitframe();
    s_child.interaction = zm_quest::function_91f9590e98d57ff6( s_child.origin, &on_return_chalk, &hint_return_chalk );
    level utility::flag_wait( "returned_chalk" );
    level thread zm_round_spawning::pause_round_spawning( 1, "quest_return_chalk" );
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"disable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"disable" );
    }
    
    s_child.interaction zm_quest::function_9170db4686f796e2();
    mdl_chalk = utility::spawn_model( s_child.script_noteworthy, s_child.origin, s_child.angles );
    mdl_chalk function_616378d7e5b22efb( anglestoup( mdl_chalk.angles ), 0.5, 3, 3 );
    playfxontag( level._effect[ "chalk_stick_ambient" ], mdl_chalk, "tag_origin" );
    playsoundatpos( mdl_chalk.origin, #"hash_bcbed56d1f9cab47" );
    wait 3;
    playfx( level._effect[ "two_sister_scene_energy_ball_despawn" ], mdl_chalk.origin );
    waitframe();
    mdl_chalk delete();
    wait 2;
    level thread zm_quest::cleanup_zombies_manually( 0, undefined, undefined, undefined, 0, 0, 1 );
    show_model_clip( "swing_clip_future" );
    level thread function_9c82acc06745d81a( "swing_clip_future", "swing_safe_point_future" );
    wait 1;
    s_swing_vig = utility::getstruct( "twins_swing_vig" );
    s_swing_vig thread scene::play();
    level utility::flag_wait( "twins_swing_vig_finished" );
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"enable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"enable" );
    }
    
    level thread zm_round_spawning::pause_round_spawning( 0, "quest_return_chalk" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xb0f50a84, Offset: 0x691c
// Size: 0x14b
function function_9c82acc06745d81a( clip_name, var_d6151594e6b55da4 )
{
    level endon( #"game_ended" );
    a_safe_point = utility::getstructarray( var_d6151594e6b55da4, "targetname" );
    clip = getent( clip_name, #targetname );
    
    if ( !clip || !a_safe_point )
    {
        return;
    }
    
    wait 1;
    
    foreach ( player in level.players )
    {
        if ( player istouching( clip ) )
        {
            closest_point = sortbydistance( a_safe_point, player.origin )[ 0 ];
            player dontinterpolate();
            player setorigin( closest_point.origin );
            
            if ( !isdefined( closest_point.angles ) )
            {
                closest_point.angles = ( 0, 0, 0 );
            }
            
            player setplayerangles( closest_point.angles );
        }
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x47f49231, Offset: 0x6a6f
// Size: 0x138
function delete_swing_seat()
{
    e_swing_seat = getent( "twins_swing_seat_future", #targetname );
    
    if ( isdefined( e_swing_seat ) )
    {
        e_swing_seat delete();
    }
    
    self.var_2a345ab3ef50328c = scene::get_entities();
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
        {
            model utility::function_7c10ea82c1e305b8( "reveal", "invisible" );
            model dontcastshadows();
            
            if ( issubstr( model.model, "spectral" ) )
            {
                model.scriptable_clip = spawnscriptable( "sat_zm_sat_scriptable_mantis_twins_clip", model.origin, model.angles );
                model.scriptable_clip thread function_59da914cbdb4429f( model );
            }
        }
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x9c40d7b3, Offset: 0x6baf
// Size: 0x264
function function_9260e769f742ff45()
{
    var_e59706fe1b81873f = getdvar( @"scr_force_team", "allies" );
    
    foreach ( sceneobjectdata in self.scenedata.sceneobjectdata )
    {
        if ( sceneobjectdata.entity.animname == "sister_skeletal" || sceneobjectdata.entity.animname == "sister_spectral" )
        {
            sceneobjectdata.entity val::set( "peck_scenes", "ignoreme", 1 );
            sceneobjectdata.entity val::set( "peck_scenes", "ignoreall", 1 );
            sceneobjectdata.entity val::set( "peck_scenes", "death", 0 );
            sceneobjectdata.entity val::set( "peck_scenes", "damage", 0 );
            sceneobjectdata.entity val::set( "peck_scenes", "ignore_cleanup", 1 );
            sceneobjectdata.entity.ignore_enemy_count = 1;
            sceneobjectdata.entity.team = var_e59706fe1b81873f;
            sceneobjectdata.entity.agentteam = var_e59706fe1b81873f;
            sceneobjectdata.entity function_66dc8b6ae969f66d( 1 );
            sceneobjectdata.entity setcanusecover( 0 );
        }
        
        if ( sceneobjectdata.entity.animname == "sister_skeletal" )
        {
            level.ai_sister_skeletal = sceneobjectdata.entity;
            continue;
        }
        
        if ( sceneobjectdata.entity.animname == "sister_spectral" )
        {
            level.ai_sister_spectral = sceneobjectdata.entity;
        }
    }
    
    level notify( #"highvis_reload_outline", var_e59706fe1b81873f, [ level.ai_sister_skeletal, level.ai_sister_spectral ] );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xaaa01bc1, Offset: 0x6e1b
// Size: 0x1d0
function function_630160cd2e04c758()
{
    /#
        iprintlnbold( "<dev string:xe6>" );
    #/
    
    level endon( #"game_ended" );
    waittime = scene::function_b3c7b792a7a154fa( "swing" );
    wait 1.5;
    
    /#
        iprintlnbold( "<dev string:xfd>" );
    #/
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
        {
            model castshadows();
            model utility::function_7c10ea82c1e305b8( "reveal", "reveal_in" );
        }
    }
    
    wait waittime - 3 - 1.5;
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
        {
            model utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
            model dontcastshadows();
        }
    }
    
    wait 3;
    thread scene::play( undefined, "outro" );
    waittime = scene::function_b3c7b792a7a154fa( "outro" );
    utility::delaythread( waittime, &scene::stop );
    wait 3;
    level utility::flag_set( "twins_swing_vig_finished" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x311b8fda, Offset: 0x6ff3
// Size: 0x66
function function_6c91f658dc5e28d9()
{
    level.ai_sister_skeletal dialogue::say( #"hash_f8a7f13df383aada" );
    level.ai_sister_spectral dialogue::say( #"hash_e42e59df651b0e04" );
    level.ai_sister_spectral dialogue::say( #"hash_e42e5adf651b0fb7" );
    level.ai_sister_skeletal dialogue::say( #"hash_f8a7ee3df383a5c1" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x375576ea, Offset: 0x7061
// Size: 0x89
function function_1f185b3adfec07aa( instance, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/repair_swing_seat", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x8f2fecdc, Offset: 0x70f2
// Size: 0x19
function function_bb6baf8aea3e404e( player )
{
    level utility::flag_set( "placed_swing_seat" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x8e6c4a5c, Offset: 0x7113
// Size: 0x89
function hint_return_chalk( instance, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/return_chalk", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xb86c691c, Offset: 0x71a4
// Size: 0x2d
function on_return_chalk( player )
{
    level utility::flag_set( "returned_chalk" );
    callback::callback( "returned_chalk", {} );
    function_c4348e073a6dd322();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x5c2ab849, Offset: 0x71d9
// Size: 0x3e
function cleanup_return_chalk( b_skipped, b_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "returned_chalk" );
        callback::callback( "returned_chalk", {} );
    }
    
    level zm_quest::update_round_cap( 9 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x25071568, Offset: 0x721f
// Size: 0x1a
function setup_play_games( b_skipped, b_restored )
{
    if ( b_skipped )
    {
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xce586ff3, Offset: 0x7241
// Size: 0x1a
function cleanup_play_games( b_skipped, b_restored )
{
    if ( b_skipped )
    {
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x3945b6f5, Offset: 0x7263
// Size: 0x1a
function setup_play_hopscotch( b_skipped, b_restored )
{
    if ( b_skipped )
    {
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xe7f311b7, Offset: 0x7285
// Size: 0x113
function setup_get_irradiated_seed( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    function_4ef47d3c5c627fb6();
    future_toolbox = utility::getstruct( "future_toolbox", "targetname" );
    interaction = zm_quest::function_91f9590e98d57ff6( future_toolbox.origin, &on_open_toolbox, &hint_open_toolbox, "small_unusablewhenobstructed" );
    level utility::flag_wait( "opened_toolbox" );
    future_toolbox.sbl setscriptablepartstate( "anim", "open" );
    future_toolbox function_fafaf224bad8c988( "irradiated_seed" );
    interaction zm_quest::function_9170db4686f796e2();
    seed_interaction = zm_quest::function_91f9590e98d57ff6( future_toolbox.origin, &on_pickup_magic_seed, &hint_pickup, "small_unusablewhenobstructed" );
    level utility::flag_wait( "pickup_magic_seed" );
    future_toolbox function_8ba297827d67c95c();
    future_toolbox.sbl setscriptablepartstate( "base", "hide_seed" );
    seed_interaction zm_quest::function_9170db4686f796e2();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x4576cdd5, Offset: 0x73a0
// Size: 0x89
function hint_pickup( instance, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/pick_up", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x9f20e07f, Offset: 0x7431
// Size: 0x71
function on_pickup_magic_seed( player )
{
    level utility::flag_set( "pickup_magic_seed" );
    level utility::delaythread( 0.5, &battlechatter_mp::trysaylocalsound, player, #"bc_flavor_player_positive" );
    zm_quest::function_b57dfe9625966b0b( #"music_box", 0, #"seed", 1, 1 );
    zm_quest::show_splash_item_picked_up( #"music_box", #"seed", 1, player );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x43894c83, Offset: 0x74aa
// Size: 0x9f
function cleanup_get_irradiated_seed( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "pickup_magic_seed" );
        zm_quest::function_b57dfe9625966b0b( #"music_box", 0, #"seed", 1, 1 );
    }
    
    future_toolbox = utility::getstruct( "future_toolbox", "targetname" );
    
    if ( isdefined( future_toolbox.sbl ) )
    {
        future_toolbox.sbl setscriptablepartstate( "anim", "open" );
    }
    
    function_c54964758ba89b36();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x58b6f6b3, Offset: 0x7551
// Size: 0x89
function hint_open_toolbox( instance, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/future_toolbox_btn", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x5f7fc595, Offset: 0x75e2
// Size: 0x19
function on_open_toolbox( player )
{
    level utility::flag_set( "opened_toolbox" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xf7c8e87d, Offset: 0x7603
// Size: 0x100
function setup_plant_irradiated_seed( b_skipped, b_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    function_4ef47d3c5c627fb6();
    plant_tree_pos = utility::getstruct( "past_magic_tree_pos", "targetname" );
    interaction = zm_quest::function_91f9590e98d57ff6( plant_tree_pos.origin, &function_301f6bb916ceb36a, &function_8403b785ae915286 );
    interaction.parent_struct = plant_tree_pos;
    level utility::flag_wait( "planted_tree" );
    function_4ef47d3c5c627fb6();
    interaction zm_quest::function_9170db4686f796e2();
    show_model_clip( "sapling_tree_clip" );
    playsoundatpos( plant_tree_pos.origin, #"hash_7560bf6e1dbeefb9" );
    playfx( level._effect[ "seed_into_ground" ], plant_tree_pos.origin + ( 0, 0, 20 ) );
    wait 2;
    start_charge_magic_tree();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x1a1a7c1b, Offset: 0x770b
// Size: 0xe3
function cleanup_plant_irradiated_seed( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    level thread zm_music::function_e9fd14ede793ef0d( "sapling_defend" );
    
    if ( b_skipped || b_restored )
    {
        var_7d7970908cd0b46c = utility::getstruct( "past_magic_tree_pos", "targetname" );
        var_7d7970908cd0b46c.sbl = spawnscriptable( var_7d7970908cd0b46c.script_noteworthy, var_7d7970908cd0b46c.origin, var_7d7970908cd0b46c.angles );
        var_7d7970908cd0b46c.sbl setscriptablepartstate( "base", "small" );
        var_7d7970908cd0b46c.sbl setscriptablepartstate( "fx", "finish" );
        show_model_clip( "sapling_tree_clip" );
        level utility::flag_set( "planted_tree" );
        level utility::flag_set( "tree_charged" );
    }
    
    function_c54964758ba89b36();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x2ac5d981, Offset: 0x77f6
// Size: 0x95
function function_8403b785ae915286( instance, player )
{
    if ( !zm_quest::function_b0a5181ebe7bb905() || !zm_quest::function_f98968f17772726c() || player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( utility::flag( "gonna_timetravel_after_special_round" ) )
    {
        return;
    }
    
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/past_derbris_des", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x4d2dacde, Offset: 0x7894
// Size: 0x49
function function_301f6bb916ceb36a( player )
{
    if ( !zm_quest::function_f98968f17772726c() )
    {
        return;
    }
    
    if ( utility::flag( "gonna_timetravel_after_special_round" ) )
    {
        return;
    }
    
    level utility::flag_set( "planted_tree" );
    self.parent_struct.activator = player;
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x8dcf57c5, Offset: 0x78e5
// Size: 0x1c7
function start_charge_magic_tree( b_skipped, b_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped )
    {
        return;
    }
    
    var_f637f10828dd8eda = [ "zone_street_7_p", "zone_street_5_p", "zone_street_6_p", "zone_street_4_p", "zone_street_3_p", "zone_street_2_p", "zone_street_1_p" ];
    level thread zm_quest::cleanup_zombies_manually( 0, var_f637f10828dd8eda, undefined, undefined, 1 );
    level thread zm_music::start_zone_music_watcher( "sapling_defend", var_f637f10828dd8eda, #"sapling_defend" );
    var_7d7970908cd0b46c = utility::getstruct( "past_magic_tree_pos", "targetname" );
    playsoundatpos( var_7d7970908cd0b46c.origin, #"hash_43c8425d22e2fb1f" );
    level utility::flag_clear( "rbz_allow_exfil" );
    wait 1;
    var_7d7970908cd0b46c.sbl = spawnscriptable( var_7d7970908cd0b46c.script_noteworthy, var_7d7970908cd0b46c.origin, var_7d7970908cd0b46c.angles );
    waitframe();
    var_7d7970908cd0b46c.sbl setscriptablepartstate( "base", "small" );
    var_7d7970908cd0b46c function_543c34973b1fe755( "charge_magic_tree", 30, 500, "soul_charged", 20, 15, 1, zm_round_logic::get_rb_round_number() + 2 + level.players.size, 0, 1, "sapling_soul_impact" );
    var_7d7970908cd0b46c.sbl setscriptablepartstate( "fx", "finish" );
    level thread zm_music::function_e9fd14ede793ef0d( "sapling_defend" );
    level thread zm_quest::cleanup_zombies_manually( 0, var_f637f10828dd8eda, undefined, undefined, 1 );
    function_fc6586658f88be77( var_7d7970908cd0b46c.origin, 1 );
    level utility::flag_set( "rbz_allow_exfil" );
    level utility::flag_set( "tree_charged" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xbe337abf, Offset: 0x7ab4
// Size: 0x273
function function_5df3d0c824a31e0d( b_skipped, b_restored )
{
    level endon( #"game_ended" );
    var_52fe21160421c = utility::getstruct( "future_magic_tree_pos", "targetname" );
    var_52fe21160421c.mdl = utility::spawn_model( var_52fe21160421c.script_noteworthy, var_52fe21160421c.origin, var_52fe21160421c.angles );
    activateworldevent( "we_lgt_tree" );
    growth_tree_clip = utility::getent_or_struct( "growth_tree_clip", "targetname" );
    
    if ( isdefined( growth_tree_clip ) )
    {
        growth_tree_clip show();
        growth_tree_clip disconnectpaths();
    }
    
    var_52fe21160421c.vfx = function_5cb04c35b2faa393( "magic_tree_full_grown", var_52fe21160421c.mdl );
    
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        spawnoptions = common_item::function_bc5ff2958b71a708( utility::getstruct( "dm_axe" ).origin, utility::getstruct( "dm_axe" ).angles );
        common_item::function_57b88e025e5fb03e( "itemspawnentry:zm_sat_item_combataxe", 1, spawnoptions );
        function_4ef47d3c5c627fb6();
    }
    
    /#
        iprintln( "<dev string:x10c>" );
    #/
    
    var_52fe21160421c.mdl setcandamage( 1 );
    var_52fe21160421c.mdl thread function_375bea17479eff41();
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"hash_a0bc753abd1bbc2a" ) )
    {
        var_6dc5fe9101608d04 = zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"hash_a0bc753abd1bbc2a" );
        zm_quest::function_b57dfe9625966b0b( #"music_box", 0, #"firewood", var_6dc5fe9101608d04, 1 );
    }
    
    if ( !isdefined( var_6dc5fe9101608d04 ) )
    {
        var_6dc5fe9101608d04 = 0;
    }
    
    while ( var_6dc5fe9101608d04 < 3 )
    {
        level waittill( #"hash_894b243c2f8a62a6" );
        var_6dc5fe9101608d04++;
        zm_quest::function_b57dfe9625966b0b( #"music_box", 0, #"firewood", var_6dc5fe9101608d04, 1 );
        zm_quest::function_4eefe6de31f5ddab( #"mantis_mq", #"hash_a0bc753abd1bbc2a", var_6dc5fe9101608d04 );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level zm_quest::function_9f49b2a045ece8ae( var_6dc5fe9101608d04, 1, #"mantis_mq_guidance", #"tree_harvest" );
        }
    }
    
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_10fd76e4c40c0520", #"hash_10fd79e4c40c0a39" ] );
    level utility::flag_set( "all_strange_firewood_collected" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x743ee1c9, Offset: 0x7d2f
// Size: 0x95
function function_c68c8b2a2634c176( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "all_strange_firewood_collected" );
        zm_quest::function_b57dfe9625966b0b( #"music_box", 0, #"firewood", 3, 1 );
    }
    
    var_52fe21160421c = utility::getstruct( "future_magic_tree_pos", "targetname" );
    
    if ( isdefined( var_52fe21160421c.vfx ) )
    {
        var_52fe21160421c.vfx freescriptable();
    }
    
    function_c54964758ba89b36();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x682f824e, Offset: 0x7dcc
// Size: 0x193
function function_375bea17479eff41()
{
    level endon( #"game_ended" );
    n_damage_count = 0;
    var_6bb97b57a2b109a1 = [ -30, 0, 30 ];
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isdefined( objweapon ) && objweapon.basename && issubstr( objweapon.basename, "combataxe" ) )
        {
            playsoundatpos( point, #"hash_e08a4893a446e73d" );
            
            while ( true )
            {
                drop_pos = function_c13617e349224404( point, attacker.origin, 60, 80, var_6bb97b57a2b109a1[ n_damage_count ] );
                
                if ( isdefined( drop_pos ) )
                {
                    break;
                }
                
                waitframe();
            }
            
            item = zm_quest::drop_quest_item( point, drop_pos, %"hash_275598440727b8d1" );
            
            if ( isdefined( item ) )
            {
                n_damage_count++;
            }
            
            if ( n_damage_count >= 3 )
            {
                break;
            }
        }
        
        wait 0.5;
    }
    
    var_52fe21160421c = utility::getstruct( "future_magic_tree_pos", "targetname" );
    
    if ( isdefined( var_52fe21160421c.vfx ) )
    {
        var_52fe21160421c.vfx freescriptable();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 5
// Checksum 0xa2597809, Offset: 0x7f67
// Size: 0xc6
function function_c13617e349224404( origin, attacker_origin, min_radius, max_radius, var_6bb97b57a2b109a1 = 0 )
{
    var_b6edabc4e1de4617 = vectornormalize2( attacker_origin - origin );
    var_b6edabc4e1de4617 = vectortoangles( var_b6edabc4e1de4617 ) + ( 0, var_6bb97b57a2b109a1, 0 );
    var_b6edabc4e1de4617 = anglestoforward( var_b6edabc4e1de4617 );
    
    /#
        line( origin, origin + var_b6edabc4e1de4617 * 30, ( 1, 0, 0 ), 1, 1, 500 );
    #/
    
    var_b32a27eb085bbeef = randomintrange( min_radius, max_radius );
    drop_pos = self.origin + var_b6edabc4e1de4617 * var_b32a27eb085bbeef;
    return getgroundposition( drop_pos, 50 ) + ( 0, 0, 5 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x84d119f4, Offset: 0x8036
// Size: 0x264
function function_1315aff4cb444bdc( b_skipped, b_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        spawnoptions = common_item::function_bc5ff2958b71a708( utility::getstruct( "dm_mol" ).origin, utility::getstruct( "dm_mol" ).angles );
        common_item::function_57b88e025e5fb03e( "itemspawnentry:zm_sat_item_molotov", 1, spawnoptions );
        function_4ef47d3c5c627fb6();
    }
    
    var_94bb4505ca428717 = utility::getstruct( "fireplace_interaction", "targetname" );
    interaction = zm_quest::function_91f9590e98d57ff6( var_94bb4505ca428717.origin, &function_b14560ac50603215, &function_1800b9db83d2f2d1, "small_unusablewhenobstructed" );
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"all_firewood_placed" ) )
    {
        level utility::flag_set( "all_firewood_placed" );
    }
    
    level utility::flag_wait( "all_firewood_placed" );
    zm_quest::function_4eefe6de31f5ddab( #"mantis_mq", #"all_firewood_placed", 1 );
    function_4ef47d3c5c627fb6();
    interaction zm_quest::function_9170db4686f796e2();
    var_94bb4505ca428717 function_fafaf224bad8c988( "strange_wood_complete" );
    function_97fc663d165aa881( "fireplace_ambient" );
    var_94bb4505ca428717.fireplace_damage_proxy = utility::spawn_model( var_94bb4505ca428717.script_noteworthy, var_94bb4505ca428717.origin );
    var_94bb4505ca428717.fireplace_damage_proxy setcandamage( 1 );
    playsoundatpos( var_94bb4505ca428717.origin, #"hash_17f0cf0546a6b8e3" );
    var_94bb4505ca428717.fireplace_damage_proxy thread fireplace_damage_check();
    level utility::flag_wait( "fireplace_light_on" );
    s_fireplace_ambient = utility::getstruct( "fireplace_ambient", "targetname" );
    function_5cb04c35b2faa393( "green_fire", s_fireplace_ambient );
    playsoundatpos( s_fireplace_ambient.origin, #"hash_d9478c1bc5c7b3d0" );
    p_fireplace_ambient = utility::getstruct( "fireplace_ambient_furture", "targetname" );
    function_5cb04c35b2faa393( "green_fire", p_fireplace_ambient );
    var_94bb4505ca428717.fireplace_damage_proxy delete();
    activateworldevent( "we_lgt_fireplace_future" );
    activateworldevent( "we_lgt_fireplace_past" );
    wait 3.5;
    activateworldevent( "we_lgt_fireplace_past_green" );
    activateworldevent( "we_lgt_fireplace_future_green" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x17d82595, Offset: 0x82a2
// Size: 0x118
function function_aff48a419de6fbe5( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    var_94bb4505ca428717 = utility::getstruct( "fireplace_interaction", "targetname" );
    
    if ( b_skipped || b_restored )
    {
        var_94bb4505ca428717 function_fafaf224bad8c988( "strange_wood_complete" );
        function_97fc663d165aa881( "fireplace_ambient" );
        
        if ( isdefined( var_94bb4505ca428717.fireplace_damage_proxy ) )
        {
            var_94bb4505ca428717.fireplace_damage_proxy notify( #"end_damage_check" );
            var_94bb4505ca428717.fireplace_damage_proxy delete();
        }
        
        s_fireplace_ambient = utility::getstruct( "fireplace_ambient", "targetname" );
        function_5cb04c35b2faa393( "green_fire", s_fireplace_ambient );
        p_fireplace_ambient = utility::getstruct( "fireplace_ambient_furture", "targetname" );
        function_5cb04c35b2faa393( "green_fire", p_fireplace_ambient );
        activateworldevent( "we_lgt_fireplace_past_green" );
        activateworldevent( "we_lgt_fireplace_future_green" );
        level utility::flag_set( "all_firewood_placed" );
        level utility::flag_set( "fireplace_light_on" );
    }
    
    function_c54964758ba89b36();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xfad2fcce, Offset: 0x83c2
// Size: 0x89
function function_1800b9db83d2f2d1( instance, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/fireplace_btn", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xca4b9942, Offset: 0x8453
// Size: 0x19
function function_b14560ac50603215( player )
{
    level utility::flag_set( "all_firewood_placed" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x44fcec22, Offset: 0x8474
// Size: 0x1c7
function fireplace_damage_check()
{
    level endon( #"game_ended" );
    self endon( #"end_damage_check" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isdefined( objweapon ) && isdefined( inflictor ) && objweapon.basename && ( issubstr( objweapon.basename, "molotov" ) || issubstr( objweapon.basename, "thermobaric_grenade" ) ) && smeansofdeath == "MOD_IMPACT" || utility::isbulletdamage( smeansofdeath ) && attacker ammo_mod::function_ba9b2ecd18bdbdd8( objweapon, "napalmburst" ) )
        {
            if ( isvalidmissile( inflictor ) )
            {
                inflictor.exploding = 1;
                inflictor utility::function_7c10ea82c1e305b8( "effects", "explode" );
                inflictor missilehidetrail();
                inflictor.prevent_knockdown = 1;
                inflictor notify( #"death" );
                inflictor delete();
            }
            
            /#
                iprintlnbold( "<dev string:x12b>" );
            #/
            
            level utility::flag_set( "fireplace_light_on" );
            attacker utility::delaythread( 3, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"light_on_fireplace", #"bc_flavor_player_positive" );
            break;
        }
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x302b3229, Offset: 0x8643
// Size: 0x15b
function setup_play_hopscotch_game( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    function_4ef47d3c5c627fb6();
    
    if ( !zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"hopscotch_activated" ) )
    {
        var_6d913c68631c68f2 = utility::getstruct( "hopscotch_x_pos_future", "targetname" );
        var_6d913c68631c68f2.mdl = spawnscriptable( "sat_zm_sat_scriptable_chalk_drawing", var_6d913c68631c68f2.origin, var_6d913c68631c68f2.angles );
        var_6d913c68631c68f2.mdl utility::function_7c10ea82c1e305b8( "base", var_6d913c68631c68f2.script_noteworthy );
        var_6d913c68631c68f2.mdl utility::function_7c10ea82c1e305b8( "fade", "fade_in" );
        var_6d913c68631c68f2 thread function_28018450d66dae88();
        var_6d913c68631c68f2 function_f473ae00ed8872ee();
        level thread function_22372cf1c0fb1272();
    }
    
    level utility::flag_set( "can_start_hopscotch_game" );
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"hopscotch_activated" ) )
    {
        function_4ef47d3c5c627fb6();
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"mantis_mq", #"hopscotch_activated", 1 );
    s_hopscotch_center = utility::getstruct( "hopscotch_center", "targetname" );
    s_hopscotch_center function_3ac40564c8d4a11b( "hopscotch", 1 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x4863f94a, Offset: 0x87a6
// Size: 0x5d
function function_22372cf1c0fb1272()
{
    level endon( #"game_ended" );
    var_6d913c68631c68f2 = utility::getstruct( "hopscotch_x_pos_future", "targetname" );
    level notify( #"hash_288f771c7bd85c02" );
    level utility::flag_waitopen( "timetravel_ongoing" );
    function_4ef47d3c5c627fb6();
    wait 3;
    var_6d913c68631c68f2.mdl freescriptable();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x392073e8, Offset: 0x880b
// Size: 0x190
function function_28018450d66dae88()
{
    level endon( #"game_ended" );
    level endon( #"hash_288f771c7bd85c02" );
    
    while ( true )
    {
        var_c1907c050ca26d59 = 0;
        
        foreach ( player in level.players )
        {
            if ( distancesquared( player.origin, self.origin ) < squared( 50 ) )
            {
                var_c1907c050ca26d59 = 1;
                break;
            }
        }
        
        if ( var_c1907c050ca26d59 )
        {
            start_time = gettime();
            self.mdl utility::function_7c10ea82c1e305b8( "fx", "glow" );
            
            if ( !level utility::flag( "can_start_hopscotch_game" ) )
            {
                level utility::flag_set( "can_start_hopscotch_game" );
                function_4ef47d3c5c627fb6();
            }
        }
        else
        {
            var_892642c01944f9a7 = ( zm_quest::function_b0a5181ebe7bb905() ? 9999 : 30 ) * 1000;
            
            if ( isdefined( start_time ) && gettime() - start_time >= var_892642c01944f9a7 )
            {
                self.mdl utility::function_7c10ea82c1e305b8( "fx", "off" );
                
                if ( level utility::flag( "can_start_hopscotch_game" ) )
                {
                    level utility::flag_clear( "can_start_hopscotch_game" );
                    function_4ef47d3c5c627fb6();
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x88949194, Offset: 0x89a3
// Size: 0x19
function delete_entity( ent )
{
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xdfdf2de0, Offset: 0x89c4
// Size: 0x39
function function_f473ae00ed8872ee()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level utility::flag( "timetravel_ongoing" ) && level utility::flag( "can_start_hopscotch_game" ) )
        {
            return;
        }
        
        wait 1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x1135ecc1, Offset: 0x8a05
// Size: 0x106
function cleanup_play_hopscotch_game( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "can_start_hopscotch_game" );
        level utility::flag_set( "hopscotch_ready" );
        level utility::flag_set( "hopscotch_success" );
        s_hopscotch_center = utility::getstruct( "hopscotch_center", "targetname" );
        s_hopscotch_center thread function_38fbefe3cbd41ad7( "hopscotch", 0, 0 );
    }
    
    if ( isdefined( level.s_hopscotch_game ) && isdefined( level.s_hopscotch_game.var_fa795a9c34416db2 ) )
    {
        var_b3f4db17a9ce9aab = utility::getstruct( level.s_hopscotch_game.var_fa795a9c34416db2.target, "targetname" );
        playfx( level._effect[ "hopscotch_success" ], var_b3f4db17a9ce9aab.origin, anglestoforward( var_b3f4db17a9ce9aab.angles ) );
    }
    
    function_c54964758ba89b36();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xd461f8dc, Offset: 0x8b13
// Size: 0x8c
function setup_deliver_music_box( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    level thread zm_music::start_zone_music_watcher( "deliver_box", level.var_59f211cd543ad7ea, #"hash_a25feafc46ce156a" );
    level.s_music_box = utility::getstruct( "music_box_start_pos", "targetname" );
    level.s_music_box function_aab344b8fc8e34e( "music_box" );
    level thread zm_music::function_e9fd14ede793ef0d( "deliver_box" );
    level utility::flag_set( "music_box_delivered" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xc5168ada, Offset: 0x8ba7
// Size: 0x343
function function_aab344b8fc8e34e( item_name )
{
    level endon( #"game_ended" );
    level utility::flag_set( "progressing_deliver_musical_items" );
    namespace_24edb5d87524aa7f::activate();
    self.mdl = utility::spawn_model( self.script_noteworthy, self.origin, self.angles );
    self.mdl utility::function_7c10ea82c1e305b8( "material", "ghost" );
    playfx( level._effect[ "musical_item_spawn" ], self.origin );
    playsoundatpos( self.origin, #"hash_465019cf3d9c2911" );
    waitframe();
    self.mdl utility::function_7c10ea82c1e305b8( "sound", "glow" );
    self.mdl utility::function_7c10ea82c1e305b8( "fx", "ambient" );
    function_4ef47d3c5c627fb6();
    
    switch ( item_name )
    {
        case #"hash_bcb317cd9dc102be":
            if ( isdefined( level.s_hopscotch_game ) && isdefined( level.s_hopscotch_game.activator ) )
            {
                level.s_hopscotch_game.activator utility::delaythread( 3, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"complete_hopscotch", #"bc_flavor_player_positive" );
            }
            
            break;
        case #"hash_939bc4136a94a244":
            if ( isdefined( level.s_foursquare_game ) && isdefined( level.s_foursquare_game.activator ) )
            {
                level.s_foursquare_game.activator utility::delaythread( 3, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"complete_foursquare", #"bc_flavor_player_positive" );
            }
            
            break;
        case #"hash_3fdfe334265cf2a4":
            if ( isdefined( level.s_zombiejacks_game ) && isdefined( level.s_zombiejacks_game.activator ) )
            {
                level.s_zombiejacks_game.activator utility::delaythread( 3, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"complete_zombiejacks", #"bc_flavor_player_positive" );
            }
            
            break;
        default:
            break;
    }
    
    thread function_e376d7fb1528e429( item_name, 7, item_name + "_charged" );
    self waittill( item_name + "_charge_movement_done" );
    wait 2;
    self.mdl utility::function_7c10ea82c1e305b8( "sound", "off" );
    waitframe();
    level thread zm_quest::cleanup_zombies_manually( 0, undefined, undefined, undefined, undefined, 0, 1 );
    s_reward_pos = utility::getstruct( item_name + "_reward_pos", "targetname" );
    reward_pos = s_reward_pos.origin ?? self.mdl.origin;
    function_fc6586658f88be77( reward_pos );
    
    if ( item_name == "music_box" )
    {
        playsoundatpos( self.mdl.origin, #"hash_dcfe6a0796164c69" );
    }
    
    playfx( level._effect[ "musical_item_despawn" ], self.mdl.origin );
    waitframe();
    self.mdl delete();
    level utility::flag_clear( "progressing_deliver_musical_items" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x60ee81f9, Offset: 0x8ef2
// Size: 0xcd
function function_bc5cfdf34bdb9324( event_name )
{
    level endon( #"game_ended" );
    level endon( event_name + "_charge_movement_done" );
    level endon( #"hash_49ebe81e4505b503" );
    
    while ( true )
    {
        level utility::flag_wait( "timetravel_ongoing" );
        wait 1;
        level utility::flag_waitopen( "timetravel_ongoing" );
        current_timeline = time_travel::get_current_timeline();
        
        if ( current_timeline.name == "past" )
        {
            level thread zm_round_spawning::pause_round_spawning( 1, event_name );
            level thread zm_quest::function_9414c909ca3295c4( event_name, 5, zm_round_logic::get_rb_round_number() + 2 * ( level.players.size - 1 ), 1, undefined, undefined, undefined, undefined, undefined, 1 );
            continue;
        }
        
        level thread zm_round_spawning::pause_round_spawning( 0, event_name );
        level thread zm_quest::stop_wave_spawner( event_name, 1, 0 );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x1498d77a, Offset: 0x8fc7
// Size: 0x21c
function cleanup_deliver_music_box( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    level zm_quest::update_round_cap( 12 );
    
    if ( b_skipped )
    {
        level utility::flag_set( "music_box_delivered" );
    }
    
    function_4ef47d3c5c627fb6();
    function_c54964758ba89b36();
    s_music_box_final_pos = utility::getstruct( "music_box_final_pos", "targetname" );
    s_music_box_final_pos.sbl = spawnscriptable( s_music_box_final_pos.script_noteworthy, s_music_box_final_pos.origin, s_music_box_final_pos.angles );
    var_528f168fd7af4b34 = utility::getstruct( "future_music_box", "targetname" );
    var_528f168fd7af4b34.sbl = spawnscriptable( var_528f168fd7af4b34.script_noteworthy, var_528f168fd7af4b34.origin, var_528f168fd7af4b34.angles );
    wait 1;
    s_music_box_final_pos.sbl utility::function_7c10ea82c1e305b8( "anim", "open" );
    var_528f168fd7af4b34.sbl utility::function_7c10ea82c1e305b8( "anim", "open" );
    
    if ( !b_restored && !b_skipped )
    {
        utility::delaythread( 1.5, &zm_quest::function_d5ef98341fd6a057, [ #"hash_c94e50a10644e3fc", #"hash_c94e53a10644e915" ] );
    }
    
    wait 3;
    s_music_box_final_pos.sbl utility::function_7c10ea82c1e305b8( "anim", "loop" );
    var_528f168fd7af4b34.sbl utility::function_7c10ea82c1e305b8( "anim", "loop" );
    
    foreach ( other_player in level.players )
    {
        other_player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_mantis_artifact_3" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x9947bd, Offset: 0x91eb
// Size: 0x1a
function cleanup_play_hopscotch( b_skipped, b_restored )
{
    if ( b_skipped )
    {
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x2d528029, Offset: 0x920d
// Size: 0x1a
function setup_play_foursquare( b_skipped, b_restored )
{
    if ( b_skipped )
    {
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x556c957a, Offset: 0x922f
// Size: 0x1a
function cleanup_play_foursquare( b_skipped, b_restored )
{
    if ( b_skipped )
    {
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x31ae0eba, Offset: 0x9251
// Size: 0x20e
function setup_return_toys( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    if ( !zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"picked_up_maxis_goggles" ) )
    {
        level.s_maxis_goggles = utility::getstruct( "maxis_goggles", "targetname" );
        level.s_maxis_goggles thread function_41ff23a3d6a442b9();
    }
    else
    {
        level utility::flag_set( "goggles_fell" );
        level utility::flag_set( "pickup_maxis_goggles" );
        zm_quest::function_b57dfe9625966b0b( #"child_cymbals", 0, #"maxis_goggles", 1, 1 );
    }
    
    if ( !zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"picked_up_maxis_headset" ) )
    {
        level thread init_maxis_headset();
    }
    else
    {
        level utility::flag_set( "pickup_maxis_headset" );
        zm_quest::function_b57dfe9625966b0b( #"child_cymbals", 0, #"maxis_headset", 1, 1 );
    }
    
    s_toy_box = utility::getstruct( "toy_box", "targetname" );
    interaction = zm_quest::function_91f9590e98d57ff6( s_toy_box.origin, &function_863c512f500750b9, &hint_open_toy_box );
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"toy_box_opened" ) )
    {
        level utility::flag_set( "toy_box_opened" );
    }
    
    level utility::flag_wait( "toy_box_opened" );
    zm_quest::function_4eefe6de31f5ddab( #"mantis_mq", #"toy_box_opened", 1 );
    s_toy_box.sbl setscriptablepartstate( "anim", "open" );
    interaction zm_quest::function_9170db4686f796e2();
    interaction = zm_quest::function_91f9590e98d57ff6( s_toy_box.origin, &function_3abac75e648edd57, &function_23da4dae800b79cb );
    function_4ef47d3c5c627fb6();
    level utility::flag_wait_all( "placed_maxis_goggles", "placed_maxis_headset" );
    interaction zm_quest::function_9170db4686f796e2();
    s_toy_box.sbl setscriptablepartstate( "fx", "on" );
    activateworldevent( "we_lgt_toy_box_past" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x26768dbf, Offset: 0x9467
// Size: 0x20d
function init_maxis_headset()
{
    var_a81c6f2763506cd = utility::getstructarray( "maxis_headset", "targetname" );
    var_a42b9828c1c73adf = utility::array_random( var_a81c6f2763506cd );
    var_a42b9828c1c73adf.mdl = utility::spawn_model( var_a42b9828c1c73adf.script_noteworthy, var_a42b9828c1c73adf.origin, var_a42b9828c1c73adf.angles );
    var_a42b9828c1c73adf.mdl hide();
    var_a42b9828c1c73adf thread function_d5332f458e11f915();
    level.var_21835960007b87e4 = zm_quest::function_91f9590e98d57ff6( var_a42b9828c1c73adf.origin, &on_pickup_maxis_headset, &hint_pickup_maxis_headset );
    level.var_21835960007b87e4.parent_struct = var_a42b9828c1c73adf;
    level utility::flag_wait( "pickup_maxis_headset" );
    zm_quest::function_b57dfe9625966b0b( #"child_cymbals", 0, #"maxis_headset", 1, 1 );
    zm_quest::function_4eefe6de31f5ddab( #"mantis_mq", #"picked_up_maxis_headset", 1 );
    
    foreach ( player in level.players )
    {
        player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_mantis_artifact_4" );
        
        if ( player utility::ent_flag( "playing_headset_rumble" ) )
        {
            player utility::ent_flag_clear( "playing_headset_rumble" );
        }
    }
    
    playsoundatpos( var_a42b9828c1c73adf.origin, #"hash_e8c33093c724c82d" );
    utility::delaythread( 1.5, &zm_quest::function_d5ef98341fd6a057, [ #"hash_28ea67d831d7ec09", #"hash_28ea64d831d7e6f0" ] );
    level.var_21835960007b87e4 zm_quest::function_9170db4686f796e2();
    var_a42b9828c1c73adf.mdl delete();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xee2c7551, Offset: 0x967c
// Size: 0x274
function function_d5332f458e11f915()
{
    level endon( #"game_ended" );
    self.mdl endon( #"death" );
    self.a_players_show_to = [];
    
    if ( isdefined( self.target ) )
    {
        s_check_pos = utility::getstruct( self.target, "targetname" );
        check_pos = s_check_pos.origin;
    }
    
    if ( !isdefined( check_pos ) )
    {
        check_pos = self.origin;
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player zombie_perks::has_perk( "specialty_death_perception" ) && namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
            {
                if ( distancesquared( player.origin, check_pos ) < squared( 48 ) && abs( player.origin[ 2 ] - check_pos[ 2 ] ) < 20 )
                {
                    if ( !arraycontains( self.a_players_show_to, player ) )
                    {
                        self.a_players_show_to = arraycombineunique( self.a_players_show_to, [ player ] );
                        self.mdl showtoplayer( player );
                        self.mdl hudoutlineenableforclient( player, "death_perception_mantis_mq" );
                        function_fafaf224bad8c988( "headphones" );
                    }
                }
                else if ( arraycontains( self.a_players_show_to, player ) )
                {
                    self.a_players_show_to = arrayremove( self.a_players_show_to, player );
                    self.mdl hudoutlinedisableforclient( player );
                    self.mdl hidefromplayer( player );
                    function_8ba297827d67c95c();
                }
                
                if ( distancesquared( player.origin, self.origin ) < squared( 96 ) )
                {
                    level thread function_a34a67eaa2d4950d( player, "damage_heavy", 0.5 );
                    continue;
                }
                
                if ( distancesquared( player.origin, self.origin ) < squared( 256 ) )
                {
                    level thread function_a34a67eaa2d4950d( player, "damage_light", 1.5 );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 3
// Checksum 0x5554361b, Offset: 0x98f8
// Size: 0x65
function function_a34a67eaa2d4950d( player, var_4152865202c85ac0, delay = 1.5 )
{
    if ( !player utility::ent_flag( "playing_headset_rumble" ) )
    {
        player utility::ent_flag_set( "playing_headset_rumble" );
        player playrumbleonentity( var_4152865202c85ac0 );
        player utility::delaythread( delay, &utility::ent_flag_clear, "playing_headset_rumble" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x4ec01cb0, Offset: 0x9965
// Size: 0xa8
function hint_pickup_maxis_headset( instance, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled && arraycontains( instance.parent_struct.a_players_show_to, player ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/pick_up", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x31f6955, Offset: 0x9a15
// Size: 0x6a
function on_pickup_maxis_headset( player )
{
    if ( !isdefined( self.parent_struct ) || !arraycontains( self.parent_struct.a_players_show_to, player ) )
    {
        return;
    }
    
    level utility::flag_set( "pickup_maxis_headset" );
    zm_quest::show_splash_item_picked_up( #"child_cymbals", #"maxis_headset", 1, player );
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xc63c047e, Offset: 0x9a87
// Size: 0x89
function hint_open_toy_box( instance, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/toy_box_open_des", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x8950f4f3, Offset: 0x9b18
// Size: 0x36
function function_863c512f500750b9( player )
{
    level utility::flag_set( "toy_box_opened" );
    level utility::delaythread( 1.5, &battlechatter_mp::trysaylocalsound, player, #"hash_5212ed7ec42f115a" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x48be5054, Offset: 0x9b56
// Size: 0xcc
function function_23da4dae800b79cb( instance, player )
{
    if ( !level utility::flag( "pickup_maxis_goggles" ) && !level utility::flag( "pickup_maxis_headset" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/toy_box_place_btn", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x1cd720aa, Offset: 0x9c2a
// Size: 0x1a4
function function_3abac75e648edd57( player )
{
    if ( level utility::flag( "pickup_maxis_goggles" ) && !level utility::flag( "placed_maxis_goggles" ) )
    {
        level utility::flag_set( "placed_maxis_goggles" );
        s_maxis_goggles_in_box = utility::getstruct( "maxis_goggles_in_box", "targetname" );
        s_maxis_goggles_in_box.mdl = utility::spawn_model( s_maxis_goggles_in_box.script_noteworthy, s_maxis_goggles_in_box.origin, s_maxis_goggles_in_box.angles );
        s_maxis_goggles_in_box.mdl thread start_bobbing( 5, 5 );
        playsoundatpos( s_maxis_goggles_in_box.origin, #"hash_4ef69a11e49fb62e" );
    }
    
    if ( level utility::flag( "pickup_maxis_headset" ) && !level utility::flag( "placed_maxis_headset" ) )
    {
        level utility::flag_set( "placed_maxis_headset" );
        s_maxis_headphone_in_box = utility::getstruct( "maxis_headphone_in_box", "targetname" );
        s_maxis_headphone_in_box.mdl = utility::spawn_model( s_maxis_headphone_in_box.script_noteworthy, s_maxis_headphone_in_box.origin, s_maxis_headphone_in_box.angles );
        s_maxis_headphone_in_box.mdl thread start_bobbing( 5, 5, 1 );
        playsoundatpos( s_maxis_headphone_in_box.origin, #"hash_910e905dbe56f3c4" );
    }
    
    if ( utility::flag( "placed_maxis_headset" ) && utility::flag( "placed_maxis_goggles" ) )
    {
        player utility::delaythread( 1.5, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"hash_e38a753c8ae0bbc8", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x4984283a, Offset: 0x9dd6
// Size: 0x204
function function_41ff23a3d6a442b9()
{
    level endon( #"game_ended" );
    self.mdl = utility::spawn_model( self.script_noteworthy, self.origin, self.angles );
    s_damage_proxy = utility::getstruct( self.target, "targetname" );
    mdl_damage_proxy = utility::spawn_model( s_damage_proxy.script_noteworthy, s_damage_proxy.origin, s_damage_proxy.angles );
    mdl_damage_proxy setcandamage( 1 );
    
    while ( true )
    {
        mdl_damage_proxy waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isplayer( attacker ) )
        {
            break;
        }
    }
    
    mdl_damage_proxy delete();
    s_drop_pos = utility::getstruct( "maxis_goggles_drop_pos", "targetname" );
    playfxontag( level._effect[ "new_zombie_soul_trail" ], self.mdl, "tag_origin" );
    self.mdl moveto( s_drop_pos.origin, 2, 2, 0 );
    self.mdl rotateto( s_drop_pos.angles, 1, 1, 0 );
    self.mdl waittill( #"movedone" );
    stopfxontag( level._effect[ "new_zombie_soul_trail" ], self.mdl, "tag_origin" );
    playsoundatpos( s_drop_pos.origin, #"hash_4ef69a11e49fb62e" );
    level utility::flag_set( "goggles_fell" );
    function_4ef47d3c5c627fb6();
    thread function_cdbc82c989c13800( s_drop_pos );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xe8147306, Offset: 0x9fe2
// Size: 0x17a
function function_cdbc82c989c13800( s_drop_pos )
{
    level endon( #"game_ended" );
    level endon( #"hash_9a3b0d53b5aab134" );
    level endon( #"hash_4dcc4e6028fe8160" );
    dist2 = 62500;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !player zombie_perks::has_perk( "specialty_w_mod" ) )
            {
                continue;
            }
            
            if ( distancesquared( player.origin, s_drop_pos.origin ) < dist2 && isdefined( player.var_4fd5ac47a9bd8c18 ) && isdefined( player.var_4fd5ac47a9bd8c18.e_mover ) )
            {
                wisp_player = player;
                wisp_player utility::callsharedfunc( #"w_mod", #"hash_f5a9afab08f0dcea", self.mdl );
                wisp_player.var_4fd5ac47a9bd8c18.var_21c148796dcc185f = 0;
                thread function_87f99ca525b1fd0( wisp_player );
                break;
            }
        }
        
        if ( isdefined( wisp_player ) )
        {
            break;
        }
        
        wait 1;
    }
    
    thread function_acdd1010a3aed2c5( wisp_player );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xb9348f16, Offset: 0xa164
// Size: 0x89
function function_87f99ca525b1fd0( wisp_player )
{
    level endon( #"game_ended" );
    level endon( #"hash_9a3b0d53b5aab134" );
    
    while ( wisp_player.var_4fd5ac47a9bd8c18 && wisp_player.var_4fd5ac47a9bd8c18.e_mover )
    {
        waitframe();
    }
    
    s_drop_pos = utility::getstruct( "maxis_goggles_drop_pos", "targetname" );
    level notify( #"hash_4dcc4e6028fe8160" );
    level.s_maxis_goggles thread function_cdbc82c989c13800( s_drop_pos );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x8b83464f, Offset: 0xa1f5
// Size: 0x113
function function_acdd1010a3aed2c5( wisp_player )
{
    level endon( #"game_ended" );
    level endon( #"hash_9a3b0d53b5aab134" );
    
    while ( wisp_player.var_4fd5ac47a9bd8c18 && wisp_player.var_4fd5ac47a9bd8c18.e_mover )
    {
        if ( distancesquared( wisp_player.var_4fd5ac47a9bd8c18.e_mover.origin, self.mdl.origin ) < 25 )
        {
            self.mdl linkto( wisp_player.var_4fd5ac47a9bd8c18.e_mover );
            playsoundatpos( self.mdl.origin, #"hash_164a5e9a32521527" );
            wisp_player.var_4fd5ac47a9bd8c18.var_21c148796dcc185f = 1;
            wisp_player utility::callsharedfunc( #"w_mod", #"hash_f55a11e321b0a83d" );
            thread function_360f3ce9554d976a( wisp_player );
            break;
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xab9a6f7, Offset: 0xa310
// Size: 0x19d
function function_360f3ce9554d976a( wisp_player )
{
    level endon( #"game_ended" );
    
    while ( isdefined( wisp_player.var_4fd5ac47a9bd8c18 ) && isdefined( wisp_player.var_4fd5ac47a9bd8c18.e_mover ) )
    {
        if ( !isdefined( self.mdl ) || !isdefined( self.mdl.origin ) )
        {
            wait 0.1;
            continue;
        }
        
        zone_struct = zone_manager::function_90e5c3e2272b0130( self.mdl.origin );
        
        if ( isdefined( zone_struct ) && isdefined( zone_struct.zone_name ) )
        {
            wait 2;
            zone_struct = zone_manager::function_90e5c3e2272b0130( self.mdl.origin );
            
            if ( isdefined( zone_struct ) && isdefined( zone_struct.zone_name ) )
            {
                break;
            }
        }
        
        wait 0.1;
    }
    
    drop_pos = getrandomnavpoint( wisp_player.origin, 10 );
    
    if ( !isdefined( drop_pos ) )
    {
        drop_pos = wisp_player.origin;
    }
    
    item_goggles = zm_quest::drop_quest_item( self.mdl.origin, drop_pos + ( 0, 0, 15 ), %"hash_48e6e1f630396901" );
    playsoundatpos( self.mdl.origin, #"hash_4ef69a11e49fb62e" );
    utility::delaythread( 1, &function_47af575f3c8d2ff7, item_goggles );
    self.mdl delete();
    level notify( #"hash_9a3b0d53b5aab134" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x491a8e12, Offset: 0xa4b5
// Size: 0x145
function function_47af575f3c8d2ff7( item_goggles )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( item_goggles ) )
    {
        return;
    }
    
    if ( !isdefined( item_goggles.angles ) )
    {
        item_goggles.angles = ( 0, 0, 0 );
    }
    
    level.var_91c2adbfffbfede5 = utility::spawn_model( "tag_origin", item_goggles.origin, ( 0, 0, 0 ) );
    localangles = combineangles( invertangles( level.var_91c2adbfffbfede5.angles ), item_goggles.angles );
    localorigin = rotatevectorinverted( item_goggles.origin - level.var_91c2adbfffbfede5.origin, level.var_91c2adbfffbfede5.origin );
    item_goggles scriptablesetparententity( level.var_91c2adbfffbfede5, localorigin, localangles );
    level.var_91c2adbfffbfede5 function_616378d7e5b22efb( anglestoup( level.var_91c2adbfffbfede5.angles ), 3, 5, 5 );
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "pickup_maxis_goggles" );
    level.var_91c2adbfffbfede5 delete();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xbc266ff5, Offset: 0xa602
// Size: 0x2b2
function cleanup_return_toys( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        s_maxis_goggles_in_box = utility::getstruct( "maxis_goggles_in_box", "targetname" );
        
        if ( !isdefined( s_maxis_goggles_in_box.mdl ) )
        {
            s_maxis_goggles_in_box.mdl = utility::spawn_model( s_maxis_goggles_in_box.script_noteworthy, s_maxis_goggles_in_box.origin, s_maxis_goggles_in_box.angles );
            s_maxis_goggles_in_box.mdl function_616378d7e5b22efb( anglestoup( s_maxis_goggles_in_box.mdl.angles ), 3, 5, 5 );
        }
        
        s_maxis_headphone_in_box = utility::getstruct( "maxis_headphone_in_box", "targetname" );
        
        if ( !isdefined( s_maxis_headphone_in_box.mdl ) )
        {
            s_maxis_headphone_in_box.mdl = utility::spawn_model( s_maxis_headphone_in_box.script_noteworthy, s_maxis_headphone_in_box.origin, s_maxis_headphone_in_box.angles );
            s_maxis_headphone_in_box.mdl function_616378d7e5b22efb( anglestoup( s_maxis_headphone_in_box.mdl.angles ), 3, 5, 5 );
        }
        
        s_toy_box = utility::getstruct( "toy_box", "targetname" );
        s_toy_box.sbl setscriptablepartstate( "anim", "open" );
        s_toy_box.sbl setscriptablepartstate( "fx", "on" );
        zm_quest::function_b57dfe9625966b0b( #"child_cymbals", 0, #"maxis_goggles", 1, 1 );
        zm_quest::function_b57dfe9625966b0b( #"child_cymbals", 0, #"maxis_headset", 1, 1 );
        level utility::flag_set( "toy_box_opened" );
        level utility::flag_set( "goggles_fell" );
        level utility::flag_set( "pickup_maxis_goggles" );
        level utility::flag_set( "pickup_maxis_headset" );
        level utility::flag_set( "placed_maxis_goggles" );
        level utility::flag_set( "placed_maxis_headset" );
    }
    
    function_c54964758ba89b36();
    s_future_toy_box = utility::getstruct( "future_toy_box", "targetname" );
    s_future_toy_box.sbl = utility::spawn_model( s_future_toy_box.script_noteworthy, s_future_toy_box.origin, s_future_toy_box.angles );
    s_future_toy_box.sbl utility::function_7c10ea82c1e305b8( "anim", "open" );
    s_future_toy_box.sbl utility::function_7c10ea82c1e305b8( "fx", "on" );
    show_model_clip( "future_toy_box_clip" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xd2c42914, Offset: 0xa8bc
// Size: 0xbf
function setup_guide_ball( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    var_b399577791a5fae4 = utility::getstruct( "foursquare_x_pos_future", "targetname" );
    var_b399577791a5fae4.mdl = spawnscriptable( "sat_zm_sat_scriptable_chalk_drawing", var_b399577791a5fae4.origin, var_b399577791a5fae4.angles );
    var_b399577791a5fae4.mdl utility::function_7c10ea82c1e305b8( "base", var_b399577791a5fae4.script_noteworthy );
    var_b399577791a5fae4.mdl utility::function_7c10ea82c1e305b8( "fade", "fade_in" );
    level thread function_50eb91766c602466();
    level utility::flag_wait( "start_foursquare_game" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x98bce672, Offset: 0xa983
// Size: 0x49
function cleanup_guide_ball( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "mantis_mq_ball_set" );
        level utility::flag_set( "ball_set" );
    }
    
    function_c54964758ba89b36();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xf0a6d793, Offset: 0xa9d4
// Size: 0x68
function setup_play_foursquare_game( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    if ( !level utility::flag( "timetravel_ongoing" ) )
    {
        function_4ef47d3c5c627fb6();
    }
    
    s_foursquare_center = utility::getstruct( "foursquare_center", "targetname" );
    s_foursquare_center function_3ac40564c8d4a11b( "foursquare", 1 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x5c224f76, Offset: 0xaa44
// Size: 0xeb
function cleanup_play_foursquare_game( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "foursquare_ready" );
        level utility::flag_set( "foursquare_success" );
        s_foursquare_center = utility::getstruct( "foursquare_center", "targetname" );
        s_foursquare_center thread function_38fbefe3cbd41ad7( "foursquare", 0, 0 );
    }
    
    function_c54964758ba89b36();
    
    if ( isdefined( level.s_foursquare_game ) && isdefined( level.s_foursquare_game.var_fa795a9c34416db2 ) )
    {
        playfx( level._effect[ "foursquare_success" ], level.s_foursquare_game.var_fa795a9c34416db2.origin, anglestoforward( level.s_foursquare_game.var_fa795a9c34416db2.angles ) );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x53603a04, Offset: 0xab37
// Size: 0x8c
function setup_deliver_cymbals( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    level thread zm_music::start_zone_music_watcher( "deliver_cymbals", level.var_59f211cd543ad7ea, #"hash_a25feafc46ce156a" );
    level.s_cymbals = utility::getstruct( "monkey_cymbals_start_pos", "targetname" );
    level.s_cymbals function_aab344b8fc8e34e( "monkey_cymbals" );
    level thread zm_music::function_e9fd14ede793ef0d( "deliver_cymbals" );
    level utility::flag_set( "monkey_cymbals_delivered" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x5847327d, Offset: 0xabcb
// Size: 0x273
function cleanup_deliver_cymbals( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    level zm_quest::update_round_cap( 15 );
    
    if ( b_skipped )
    {
        level utility::flag_set( "monkey_cymbals_delivered" );
    }
    
    function_4ef47d3c5c627fb6();
    function_c54964758ba89b36();
    var_e801abc2334822bd = utility::getstruct( "monkey_cymbals_in_box" );
    var_e801abc2334822bd.mdl = utility::spawn_model( var_e801abc2334822bd.script_noteworthy, var_e801abc2334822bd.origin, var_e801abc2334822bd.angles );
    var_e801abc2334822bd.mdl utility::function_7c10ea82c1e305b8( "material", "remove" );
    s_toy_box = utility::getstruct( "toy_box" );
    s_toy_box.vfx_sbl = function_5cb04c35b2faa393( "toybox_complete", s_toy_box );
    s_future_toy_box = utility::getstruct( "future_toy_box", "targetname" );
    s_future_toy_box.vfx_sbl = function_5cb04c35b2faa393( "toybox_complete", s_future_toy_box );
    var_177f4904b7d9bed = utility::getstruct( "future_monkey_cymbals_in_box" );
    var_177f4904b7d9bed.mdl = utility::spawn_model( var_177f4904b7d9bed.script_noteworthy, var_177f4904b7d9bed.origin, var_177f4904b7d9bed.angles );
    var_177f4904b7d9bed.mdl utility::function_7c10ea82c1e305b8( "material", "remove" );
    var_3fef63e1d71c19c8 = utility::getstruct( "future_maxis_goggles_in_box" );
    var_3fef63e1d71c19c8.mdl = utility::spawn_model( var_3fef63e1d71c19c8.script_noteworthy, var_3fef63e1d71c19c8.origin, var_3fef63e1d71c19c8.angles );
    var_3fef63e1d71c19c8.mdl thread start_bobbing( 5, 5 );
    var_446c83597103a7de = utility::getstruct( "future_maxis_headphone_in_box" );
    var_446c83597103a7de.mdl = utility::spawn_model( var_446c83597103a7de.script_noteworthy, var_446c83597103a7de.origin, var_446c83597103a7de.angles );
    var_446c83597103a7de.mdl thread start_bobbing( 5, 5, 1 );
    activateworldevent( "we_lgt_toy_box_future" );
    
    if ( !b_restored && !b_skipped )
    {
        utility::delaythread( 1.5, &zm_quest::function_d5ef98341fd6a057, [ #"hash_68d1c13883afa163", #"hash_68d1c23883afa316" ] );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x498ad15d, Offset: 0xae46
// Size: 0x1a
function setup_play_jacks( b_skipped, b_restored )
{
    if ( b_skipped )
    {
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xa2d5abc6, Offset: 0xae68
// Size: 0x1a
function cleanup_play_jacks( b_skipped, b_restored )
{
    if ( b_skipped )
    {
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x3956a1eb, Offset: 0xae8a
// Size: 0x3a
function setup_find_key( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    level thread function_eaa9d53e20c74cdf();
    level utility::flag_wait( "piano_teacher_teleport_to_past" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xb5b6a39c, Offset: 0xaecc
// Size: 0x339
function function_eaa9d53e20c74cdf()
{
    level endon( #"game_ended" );
    level endon( #"piano_teacher_teleport_to_past" );
    s_piano_teacher = utility::getstruct( "piano_teacher", "targetname" );
    
    while ( true )
    {
        wait 1;
        current_timeline = time_travel::get_current_timeline();
        
        if ( isdefined( s_piano_teacher.teacher_zombie ) )
        {
            s_piano_teacher.spawn_start_time = undefined;
            continue;
        }
        
        if ( current_timeline.name == "past" )
        {
            s_piano_teacher.spawn_start_time = undefined;
            continue;
        }
        
        if ( zm_round_spawning::is_special_round( zm_round_logic::get_rb_round_number() ) )
        {
            s_piano_teacher.spawn_start_time = undefined;
            continue;
        }
        
        var_c1907c050ca26d59 = zm_quest::function_33e20bfbb976c774( [ "zone_backyard1_a_f", "zone_backyard1_b_f" ] );
        
        if ( var_c1907c050ca26d59 )
        {
            if ( !isdefined( s_piano_teacher.spawn_start_time ) )
            {
                s_piano_teacher.spawn_start_time = gettime();
            }
            
            if ( gettime() - s_piano_teacher.spawn_start_time < utility::function_4b74c15943231980( 60 ) )
            {
                continue;
            }
        }
        else
        {
            s_piano_teacher.spawn_start_time = undefined;
            continue;
        }
        
        /#
            iprintlnbold( "<dev string:x14b>" );
        #/
        
        s_piano_teacher.teacher_zombie = zm_quest::spawn_zombies_at_location( "sat_spawner_zombie_base_zm_mantis_piano_teacher", s_piano_teacher.origin, 1, 0, undefined, 1, undefined, 1 )[ 0 ];
        
        if ( !isdefined( s_piano_teacher.teacher_zombie ) )
        {
            continue;
        }
        
        level.piano_teacher = s_piano_teacher.teacher_zombie;
        function_4ef47d3c5c627fb6();
        s_piano_teacher.teacher_zombie utility::callsharedfunc( #"w_mod", #"wisp_ignore", "teacher_zombie" );
        s_piano_teacher.teacher_zombie.var_825b17c932865df = 1;
        s_piano_teacher.teacher_zombie.b_ignore_cleanup = 1;
        s_piano_teacher.teacher_zombie.b_cleanup_no_respawn = 1;
        s_piano_teacher.teacher_zombie.var_a13bed1ac47e1b2c = 1;
        s_piano_teacher.teacher_zombie.no_powerups = 1;
        s_piano_teacher.teacher_zombie.var_15598d8e493afe88 = 1;
        s_piano_teacher.teacher_zombie.ignore_enemy_count = 1;
        s_piano_teacher.teacher_zombie.var_7ee152b43c7188e1 = 1;
        s_piano_teacher.teacher_zombie.b_ignore_frenzied_guard = 1;
        s_piano_teacher.teacher_zombie zombie_utils::function_a8ce00e0448cb6f0( "wander", "zm_quest", 20 );
        s_piano_teacher.teacher_zombie thread function_41c3cbfc31ff8cdd( s_piano_teacher );
        s_piano_teacher.teacher_zombie utility::delaythread( 180, &despawn_piano_teacher );
        s_piano_teacher.teacher_zombie callback::add( "on_turned", &function_f10f36181253d02c );
        s_piano_teacher.teacher_zombie callback::add( "on_zombie_ai_damaged", &brainrot_on_damaged );
        s_piano_teacher thread function_4d511020fc12109e();
        s_piano_teacher function_c1e4a3383e70e556();
        s_piano_teacher.spawn_start_time = undefined;
        level waittill( #"on_round_start" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x2804970f, Offset: 0xb20d
// Size: 0x71
function brainrot_on_damaged( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    if ( params.eattacker ammo_mod::get_ammo_mod_name( params.sweapon ) != "brainrot" )
    {
        return;
    }
    
    brainrot::function_a8dd3ca93248e895( params.eattacker, undefined, 1 );
    val::set( #"hash_c6bf777fefc9e7ec", "damage", 0 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xba41ae25, Offset: 0xb286
// Size: 0xd5
function function_4d511020fc12109e()
{
    level endon( #"game_ended" );
    self.teacher_zombie endon( #"death" );
    future_piano_pos = utility::getstruct( "future_piano_pos_teacher", "targetname" );
    
    while ( true )
    {
        if ( isdefined( self.teacher_zombie ) && distancesquared( self.teacher_zombie.origin, future_piano_pos.origin ) < squared( 50 ) )
        {
            level waittill( #"pre_timetravel_done", next_timeline );
            
            if ( isdefined( self.teacher_zombie ) )
            {
                self.teacher_zombie thread time_travel::function_b981ae62bbb5502f( next_timeline.name );
                level utility::flag_set( "piano_teacher_teleport_to_past" );
                break;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xf5b0a820, Offset: 0xb363
// Size: 0x34
function function_c1e4a3383e70e556()
{
    level endon( #"game_ended" );
    self.teacher_zombie waittill( #"death" );
    self.teacher_zombie = undefined;
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x57fca141, Offset: 0xb39f
// Size: 0x39e
function function_f10f36181253d02c( params )
{
    self notify( #"force_end_current_goal" );
    self.var_923fd785fff9159b = 1;
    self.var_7ee152b43c7188e1 = 1;
    
    if ( isdefined( self._blackboard ) )
    {
        self._blackboard.var_ea5eb773cb969ee1 = 0;
        self._blackboard.brainrotowner = undefined;
    }
    
    foreach ( effects in self.status_effects )
    {
        foreach ( effect in effects )
        {
            effect.end_time = gettime();
        }
    }
    
    self.b_cleanup_no_respawn = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.no_powerups = 1;
    self.var_15598d8e493afe88 = 1;
    self.var_825b17c932865df = 1;
    self function_54d3d4ceb3d0bc90();
    val::set( #"hash_c6bf777fefc9e7ec", "show_healthbar", 0 );
    val::set( #"hash_c6bf777fefc9e7ec", "ignoreall", 1 );
    val::set( #"hash_c6bf777fefc9e7ec", "ignore_ai_collision", 1 );
    val::set( #"hash_c6bf777fefc9e7ec", "disallow_knockdown", 1 );
    val::set( #"hash_c6bf777fefc9e7ec", "disallow_stun", 1 );
    val::set( #"hash_c6bf777fefc9e7ec", "disallow_slow", 1 );
    val::set( #"hash_c6bf777fefc9e7ec", "damage", 0 );
    val::set( #"hash_c6bf777fefc9e7ec", "death", 0 );
    val::set( #"hash_c6bf777fefc9e7ec", "collide_with_ai_allies", 0 );
    val::set( #"hash_c6bf777fefc9e7ec", "script_pushable_by_ai", 0 );
    val::set( #"hash_c6bf777fefc9e7ec", "script_pushable", 0 );
    val::set( #"hash_c6bf777fefc9e7ec", "ignore_cleanup", 1 );
    self function_7f8988ce63c1623d( 0 );
    
    if ( isdefined( self.active_attractors ) )
    {
        foreach ( attractor in self.active_attractors )
        {
            zombie_attractor_manager::function_dcfb4c31f1d97cd2( attractor );
        }
    }
    
    wait 1;
    piano_pos = utility::getstruct( "future_piano_pos_teacher", "targetname" );
    
    if ( isdefined( piano_pos ) )
    {
        piano_pos.team = level.players[ 0 ].team == "allies" ? "axis" : "allies";
        zombie_attractor_manager::function_7eb1aaa8bc7cc15( piano_pos, 3, undefined, undefined, undefined, undefined, undefined, piano_pos.team );
    }
    
    thread function_978fb0445f7db3d( piano_pos );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x695b7506, Offset: 0xb745
// Size: 0xa5
function function_978fb0445f7db3d( piano_pos )
{
    level endon( #"game_ended" );
    level endon( #"piano_teacher_teleport_to_past" );
    self endon( #"death" );
    function_c4348e073a6dd322();
    var_216d73198c8bb722 = undefined;
    
    while ( true )
    {
        if ( distancesquared( self.origin, piano_pos.origin ) < squared( 50 ) )
        {
            if ( !isdefined( var_216d73198c8bb722 ) )
            {
                function_4ef47d3c5c627fb6();
            }
            
            if ( !isdefined( var_216d73198c8bb722 ) )
            {
                var_216d73198c8bb722 = gettime();
            }
            
            if ( gettime() - var_216d73198c8bb722 > 30000 )
            {
                childthread despawn_piano_teacher();
                break;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x6846e632, Offset: 0xb7f2
// Size: 0x8d
function despawn_piano_teacher()
{
    level endon( #"game_ended" );
    
    if ( isdefined( self ) )
    {
        self notify( #"stop_delay_thread" );
        utility::function_7c10ea82c1e305b8( "base", "base_off" );
        utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_out" );
        playfx( level._effect[ "piano_teacher_despawn" ], self gettagorigin( "j_spine4" ) );
        wait 0.6;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.nocorpse = 1;
        val::reset_all( #"hash_c6bf777fefc9e7ec" );
        self kill();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x80d47eda, Offset: 0xb887
// Size: 0x9d
function function_41c3cbfc31ff8cdd( parent_struct )
{
    self endon( #"death" );
    self endon( #"force_end_current_goal" );
    var_3e766b44deee9016 = utility::getstructarray( parent_struct.target, "targetname" );
    
    if ( !isdefined( current_move_target ) )
    {
        current_move_target = utility::array_random( var_3e766b44deee9016 );
    }
    
    next_target = undefined;
    zm_quest::force_zombie_goal( current_move_target );
    
    while ( true )
    {
        next_target = utility::array_random( var_3e766b44deee9016 );
        
        if ( next_target != current_move_target )
        {
            current_move_target = next_target;
            zm_quest::force_zombie_goal( current_move_target );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xd5943ad5, Offset: 0xb92c
// Size: 0x49
function cleanup_find_key( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "piano_teacher_teleport_to_past" );
    }
    
    function_c54964758ba89b36();
    level utility::flag_set( "piano_opened" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xb851d274, Offset: 0xb97d
// Size: 0xcc
function function_f6ae1443906b989c( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    s_piano_teacher = utility::getstruct( "piano_teacher", "targetname" );
    var_53d0241d7a62a442 = utility::getstruct( "zombie_open_piano" );
    
    if ( isdefined( s_piano_teacher.teacher_zombie ) )
    {
        s_piano_teacher.teacher_zombie waittill( #"timetravel_entity_done" );
        var_53d0241d7a62a442 scene::add_scene_func( var_53d0241d7a62a442, &function_8480d33544a5cf8d, "shot_010" );
        var_53d0241d7a62a442 scene::play( s_piano_teacher.teacher_zombie );
        var_53d0241d7a62a442 thread function_9c1a4956d22f2915();
        s_piano_teacher.teacher_zombie thread despawn_piano_teacher();
        level utility::flag_set( "teacher_done" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xc94c4615, Offset: 0xba51
// Size: 0x40
function function_9c1a4956d22f2915()
{
    level endon( #"game_ended" );
    wait 1;
    closest_player = utility::get_closest_player();
    level utility::delaythread( 0.5, &battlechatter_mp::trysaylocalsound, closest_player, #"hash_5212ed7ec42f115a" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x9f48a06a, Offset: 0xba99
// Size: 0xb2
function function_8480d33544a5cf8d()
{
    level endon( #"game_ended" );
    level waittill( #"zombie_open_piano" );
    s_piano_past = utility::getstruct( "past_piano_pos", "targetname" );
    s_piano_past.sbl utility::function_7c10ea82c1e305b8( "anim", "open" );
    s_piano_future = utility::getstruct( "future_piano_pos", "targetname" );
    s_piano_future.sbl utility::function_7c10ea82c1e305b8( "anim", "open" );
    wait 1;
    s_piano_past.sbl utility::function_7c10ea82c1e305b8( "fx", "on" );
    activateworldevent( "we_lgt_piano" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x4e09b3d2, Offset: 0xbb53
// Size: 0x89
function function_e31c6644bb642fec( instance, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/future_piano_btn", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x30a61ea4, Offset: 0xbbe4
// Size: 0x19
function function_8a015819338bc408( player )
{
    level utility::flag_set( "returned_missing_piano_keys" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xdbebccb0, Offset: 0xbc05
// Size: 0xd3
function function_75a72dc86a89e67d( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "teacher_done" );
        s_piano_past = utility::getstruct( "past_piano_pos", "targetname" );
        s_piano_past.sbl utility::function_7c10ea82c1e305b8( "anim", "open" );
        s_piano_future = utility::getstruct( "future_piano_pos", "targetname" );
        s_piano_future.sbl utility::function_7c10ea82c1e305b8( "anim", "open" );
        wait 1;
        s_piano_past.sbl utility::function_7c10ea82c1e305b8( "fx", "on" );
        activateworldevent( "we_lgt_piano" );
    }
    
    function_c54964758ba89b36();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x4e7dcfc3, Offset: 0xbce0
// Size: 0x341
function setup_play_music( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    level thread function_a105f6c337f9450();
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", #"music_notes_puzzle_completed" ) )
    {
        level utility::flag_set( "music_notes_puzzle_completed" );
    }
    
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "music_notes_puzzle_completed" );
    zm_quest::function_4eefe6de31f5ddab( #"mantis_mq", #"music_notes_puzzle_completed", 1 );
    
    foreach ( s_note in level.music_note.a_notes )
    {
        s_note.interaction zm_quest::function_9170db4686f796e2();
        s_note.sbl freescriptable();
    }
    
    var_9902bc90a6febf32 = utility::getstruct( "past_piano_pos" );
    
    if ( isdefined( var_9902bc90a6febf32.sbl ) )
    {
        var_9902bc90a6febf32.sbl utility::function_7c10ea82c1e305b8( "key_ambient", "dim" );
    }
    
    s_music_low_note = utility::getstruct( "music_low_note", "targetname" );
    function_5cb04c35b2faa393( "music_low_note", s_music_low_note );
    var_304daba24914ef24 = utility::getstructarray( "music_note_signs" );
    
    foreach ( s_note in var_304daba24914ef24 )
    {
        if ( !isdefined( s_note.var_e4bb29bf15ad4c3 ) )
        {
            s_note.var_e4bb29bf15ad4c3 = spawnscriptable( %"sat_zm_sat_scriptable_music_note", s_note.origin, s_note.angles );
            s_note.var_e4bb29bf15ad4c3 setscriptablepartstate( "base", string( s_note.script_noteworthy ) );
            activateworldevent( "we_lgt_music_note" + string( s_note.script_noteworthy ) );
        }
    }
    
    level thread function_8be474f24a4a1bf1( [ 8, 6, 7, 5, 6, 5, 3, 5 ] );
    var_9902bc90a6febf32.interaction = zm_quest::function_91f9590e98d57ff6( var_9902bc90a6febf32.origin, &function_25aa2b39a5a33950, &function_34d7879b4db0338c, "small_unusablewhenobstructed" );
    level waittill( #"hash_819126740120ca8b" );
    playsoundatpos( var_9902bc90a6febf32.origin, #"hash_dc22852594e2f1e0" );
    var_9902bc90a6febf32.interaction zm_quest::function_9170db4686f796e2();
    
    if ( isdefined( var_9902bc90a6febf32.sbl ) )
    {
        var_9902bc90a6febf32.sbl utility::function_7c10ea82c1e305b8( "key_ambient", "glow" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xee6fea1a, Offset: 0xc029
// Size: 0x47
function function_8be474f24a4a1bf1( a_password )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_aaa29ee5b0d966bb ) )
    {
        level.var_aaa29ee5b0d966bb = spawnstruct();
    }
    
    level.var_aaa29ee5b0d966bb.a_password = a_password;
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xe82a6e8a, Offset: 0xc078
// Size: 0x5c
function function_25aa2b39a5a33950( player )
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    if ( utility::flag( "gonna_timetravel_after_special_round" ) )
    {
        return;
    }
    
    if ( self.b_in_cooldown )
    {
        return;
    }
    
    if ( utility::flag_exist( "mq_piano_is_busy" ) && utility::flag( "mq_piano_is_busy" ) )
    {
        return;
    }
    
    thread function_22da22005e2b11af( player );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x16cd5722, Offset: 0xc0dc
// Size: 0x97
function function_34d7879b4db0338c( instance, player )
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) || !zm_quest::function_b0a5181ebe7bb905() || player.interactions_disabled || instance.b_in_cooldown )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/maintis_minigame_btn", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x38509a79, Offset: 0xc17c
// Size: 0xed
function function_22da22005e2b11af( player )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_aaa29ee5b0d966bb ) )
    {
        level.var_aaa29ee5b0d966bb = spawnstruct();
    }
    
    level.var_aaa29ee5b0d966bb.var_5e78435f8f0387fe = [];
    player.var_3a82de286e645d6e = 1;
    utility::flag_set( "mq_piano_is_busy" );
    player setsoundsubmix( "sat_zm_mantis_play_piano" );
    player thread function_cbdccce38bb68171();
    player thread function_241a5e17a7cda0e6();
    player thread function_63a57cf9f1f37cb7( self );
    player thread function_c18887309a21328e();
    level waittill( #"hash_8892174d5dd2be7f", var_6b7ddb30cb82d43, var_9f36c32043f72735 );
    utility::flag_clear( "mq_piano_is_busy" );
    
    if ( player )
    {
        player.var_3a82de286e645d6e = undefined;
        player thread function_7a242d6c4c3e8663( var_6b7ddb30cb82d43 );
    }
    
    if ( var_6b7ddb30cb82d43 )
    {
        return;
    }
    
    level thread function_ab56db1a923c5801( var_9f36c32043f72735 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xc8009d56, Offset: 0xc271
// Size: 0x10e
function function_ab56db1a923c5801( var_9f36c32043f72735 )
{
    level endon( #"game_ended" );
    level endon( #"hash_819126740120ca8b" );
    s_piano_past = utility::getstruct( "past_piano_pos", "targetname" );
    
    if ( !var_9f36c32043f72735 )
    {
        s_piano_past.sbl utility::function_7c10ea82c1e305b8( "fx", "off" );
        s_piano_past.sbl utility::function_7c10ea82c1e305b8( "key_ambient", "off" );
        s_piano_past.interaction.b_in_cooldown = 1;
        utility::flag_set( "piano_cooldown" );
        function_4ef47d3c5c627fb6();
        wait 60;
        utility::flag_clear( "piano_cooldown" );
        s_piano_past.interaction.b_in_cooldown = 0;
    }
    
    s_piano_past.sbl utility::function_7c10ea82c1e305b8( "fx", "on" );
    s_piano_past.sbl utility::function_7c10ea82c1e305b8( "key_ambient", "dim" );
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xad65ab3f, Offset: 0xc387
// Size: 0x44
function function_241a5e17a7cda0e6()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level endon( #"hash_8892174d5dd2be7f" );
    wait 60;
    
    if ( isdefined( self ) )
    {
        thread function_7a242d6c4c3e8663();
        level notify( #"hash_8892174d5dd2be7f", 0, 1 );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xe7586c42, Offset: 0xc3d3
// Size: 0x74
function function_63a57cf9f1f37cb7( var_c083c525b3af0017 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level endon( #"hash_8892174d5dd2be7f" );
    level endon( #"hash_9e8d9fc2115cc662" );
    
    while ( self && distance2dsquared( self.origin, var_c083c525b3af0017.origin ) < squared( 150 ) )
    {
        wait 1;
    }
    
    if ( self )
    {
        thread function_7a242d6c4c3e8663();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x39754486, Offset: 0xc44f
// Size: 0x7e
function function_c18887309a21328e()
{
    level endon( #"game_ended" );
    level endon( #"hash_8892174d5dd2be7f" );
    level endon( #"hash_9e8d9fc2115cc662" );
    self waittill( #"death_or_disconnect" );
    
    if ( self )
    {
        thread function_7a242d6c4c3e8663();
        return;
    }
    
    level notify( #"hash_8892174d5dd2be7f", 0, 1 );
    var_9902bc90a6febf32 = utility::getstruct( "past_piano_pos" );
    var_9902bc90a6febf32.interaction.b_in_cooldown = 0;
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x881f3ca6, Offset: 0xc4d5
// Size: 0x92
function set_player_ignoreme( var_f1fbc291f2430b1e, id )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mantis_set_player_ignoreme" );
    
    if ( var_f1fbc291f2430b1e )
    {
        val::set( id, "ignoreme", var_f1fbc291f2430b1e );
        thread utility::delaythreadendon( getdvarfloat( @"hash_8c2b55836076c17", 300 ), "mantis_set_player_ignoreme", &set_player_ignoreme, 0, id );
        self notify( #"mantis_set_player_ignoreme" );
        return;
    }
    
    wait 2;
    val::reset( id, "ignoreme" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xba8cff2b, Offset: 0xc56f
// Size: 0x256
function function_a105f6c337f9450()
{
    level.music_note = utility::getstruct( "music_notes", "targetname" );
    a_music_notes = utility::getstructarray( level.music_note.target, "targetname" );
    a_music_notes = arrayrandomize( a_music_notes );
    var_304daba24914ef24 = utility::getstructarray( "music_note_signs" );
    
    foreach ( index, s_note in a_music_notes )
    {
        s_note.sbl = spawnscriptable( s_note.script_noteworthy, s_note.origin, s_note.angles );
        s_note.index = index + 1;
        s_note.var_8fa2da1f88557039 = function_d629465dc8648c8c( s_note.index, var_304daba24914ef24 );
        s_note.sbl setscriptablepartstate( "base", string( s_note.index ) );
        s_interact_loc = utility::getstruct( s_note.target, "targetname" );
        s_note.interaction = zm_quest::function_91f9590e98d57ff6( s_interact_loc.origin, &function_1dbe77dd37b90267, &function_8e95284d39a3424b, "small_unusablewhenobstructed" );
        s_note.interaction.s_note = s_note;
        s_note.interaction.var_f1fbc291f2430b1e = 1;
        
        if ( !isdefined( level.music_note.a_notes ) )
        {
            level.music_note.a_notes = [];
        }
        
        level.music_note.a_notes[ level.music_note.a_notes.size ] = s_note;
        
        /#
            print3d( s_note.origin, string( s_note.index ), ( 0, 1, 0 ), 1, 1, 5000 );
        #/
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x88a096e5, Offset: 0xc7cd
// Size: 0xa2
function function_d629465dc8648c8c( n_index, var_304daba24914ef24 )
{
    level endon( #"game_ended" );
    
    foreach ( s_note in var_304daba24914ef24 )
    {
        if ( s_note.script_noteworthy == string( n_index ) )
        {
            return s_note;
        }
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x9085a98a, Offset: 0xc878
// Size: 0x99
function function_8e95284d39a3424b( instance, player )
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) || !zm_quest::function_b0a5181ebe7bb905() || player.interactions_disabled || instance.var_f1fbc291f2430b1e == 0 )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/activate", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xdefaba7b, Offset: 0xc91a
// Size: 0x44
function function_1dbe77dd37b90267( player )
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    if ( !self.var_f1fbc291f2430b1e )
    {
        return;
    }
    
    self.var_f1fbc291f2430b1e = 0;
    level thread function_8e26b2a0bf802991( self.s_note, player );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x11bed771, Offset: 0xc966
// Size: 0x269
function function_8e26b2a0bf802991( s_note, player )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.music_note.used_notes ) )
    {
        level.music_note.used_notes = [];
    }
    
    level.music_note.used_notes = arraycombineunique( level.music_note.used_notes, [ s_note ] );
    
    if ( s_note == level.music_note.a_notes[ level.music_note.used_notes.size - 1 ] )
    {
        s_note.sbl setscriptablepartstate( "base", "off" );
        playsoundatpos( s_note.origin, "evt_mq_piano_note_collect_" + s_note.index );
        playfx( level._effect[ "music_note_interact_vfx" ], s_note.origin );
        
        if ( level.music_note.used_notes.size == level.music_note.a_notes.size )
        {
            level utility::flag_set( "music_notes_puzzle_completed" );
            level utility::delaythread( 0.5, &battlechatter_mp::trysaylocalsound, player, #"bc_flavor_player_positive" );
        }
        
        if ( isdefined( s_note.var_8fa2da1f88557039 ) )
        {
            s_note.var_e4bb29bf15ad4c3 = spawnscriptable( %"sat_zm_sat_scriptable_music_note", s_note.var_8fa2da1f88557039.origin, s_note.var_8fa2da1f88557039.angles );
            s_note.var_e4bb29bf15ad4c3 setscriptablepartstate( "base", string( s_note.var_8fa2da1f88557039.script_noteworthy ) );
            activateworldevent( "we_lgt_music_note" + string( s_note.var_8fa2da1f88557039.script_noteworthy ) );
        }
    }
    else
    {
        playsoundatpos( s_note.origin, #"hash_c27b48417950257e" );
        
        if ( !player utility::ent_flag( "played_wrong_music_note" ) )
        {
            player utility::ent_flag_set( "played_wrong_music_note" );
            level utility::delaythread( 0.5, &battlechatter_mp::trysaylocalsound, player, #"bc_flavor_player_negative" );
        }
        
        function_783d642c40c66c80();
    }
    
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xd2ad7f90, Offset: 0xcbd7
// Size: 0x229
function function_783d642c40c66c80()
{
    level endon( #"game_ended" );
    
    foreach ( s_note in level.music_note.a_notes )
    {
        s_note.sbl setscriptablepartstate( "base", "off" );
        playfx( level._effect[ "music_note_interact_vfx" ], s_note.origin );
        
        if ( isdefined( s_note.interaction ) )
        {
            s_note.interaction.var_f1fbc291f2430b1e = 0;
        }
        
        if ( isdefined( s_note.var_e4bb29bf15ad4c3 ) )
        {
            s_note.var_e4bb29bf15ad4c3 freescriptable();
            s_note.var_e4bb29bf15ad4c3 = undefined;
            deactivateworldevent( "we_lgt_music_note" + string( s_note.var_8fa2da1f88557039.script_noteworthy ) );
        }
    }
    
    level.music_note.used_notes = [];
    level utility::flag_set( "notes_cooldown" );
    function_4ef47d3c5c627fb6();
    wait 60;
    level utility::flag_clear( "notes_cooldown" );
    
    foreach ( s_note in level.music_note.a_notes )
    {
        s_note.sbl setscriptablepartstate( "base", string( s_note.index ) );
        
        if ( isdefined( s_note.interaction ) )
        {
            s_note.interaction.var_f1fbc291f2430b1e = 1;
        }
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xbdcd5629, Offset: 0xce08
// Size: 0x1f0
function cleanup_play_music( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        var_9902bc90a6febf32 = utility::getstruct( "past_piano_pos" );
        
        if ( isdefined( var_9902bc90a6febf32.sbl ) )
        {
            var_9902bc90a6febf32.sbl utility::function_7c10ea82c1e305b8( "key_ambient", "glow" );
        }
        
        s_music_low_note = utility::getstruct( "music_low_note", "targetname" );
        function_5cb04c35b2faa393( "music_low_note", s_music_low_note );
        var_304daba24914ef24 = utility::getstructarray( "music_note_signs" );
        
        foreach ( s_note in var_304daba24914ef24 )
        {
            s_note.var_e4bb29bf15ad4c3 = spawnscriptable( %"sat_zm_sat_scriptable_music_note", s_note.origin, s_note.angles );
            s_note.var_e4bb29bf15ad4c3 setscriptablepartstate( "base", string( s_note.script_noteworthy ) );
            activateworldevent( "we_lgt_music_note" + string( s_note.script_noteworthy ) );
        }
    }
    
    function_c54964758ba89b36();
    s_piano_future = utility::getstruct( "future_piano_pos", "targetname" );
    
    if ( isdefined( s_piano_future.sbl ) )
    {
        s_piano_future.sbl utility::function_7c10ea82c1e305b8( "key_ambient", "glow" );
        s_piano_future.sbl utility::function_7c10ea82c1e305b8( "fx", "on" );
    }
    
    level utility::flag_set( "music_notes_puzzle_completed" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x4c2f34df, Offset: 0xd000
// Size: 0xde
function function_a68464437eaa8a15( b_skipped, b_restored )
{
    level utility::flag_set( "start_lost_soul_collection" );
    
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    function_4ef47d3c5c627fb6();
    var_2cfa0923a420e109 = utility::getstruct( "zombiejacks_x_pos_future", "targetname" );
    var_2cfa0923a420e109.mdl = spawnscriptable( "sat_zm_sat_scriptable_chalk_drawing", var_2cfa0923a420e109.origin, var_2cfa0923a420e109.angles );
    var_2cfa0923a420e109.mdl utility::function_7c10ea82c1e305b8( "base", var_2cfa0923a420e109.script_noteworthy );
    var_2cfa0923a420e109.mdl utility::function_7c10ea82c1e305b8( "fade", "fade_in" );
    var_2cfa0923a420e109 function_ccff9a47c3e958fd();
    var_2cfa0923a420e109.mdl thread utility::delaycall( 6, &freescriptable );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x42d9e361, Offset: 0xd0e6
// Size: 0x49
function function_edd5e6fdfc302c14( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "has_hit_all_lost_soul_balls" );
        level utility::flag_set( "all_lost_soul_balls_arrived" );
    }
    
    function_c54964758ba89b36();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x5f719ab1, Offset: 0xd137
// Size: 0x51
function setup_play_jacks_game( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    s_zombiejacks_center = utility::getstruct( "zombiejacks_center", "targetname" );
    s_zombiejacks_center function_3ac40564c8d4a11b( "zombiejacks", 1 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 3
// Checksum 0x3749ce38, Offset: 0xd190
// Size: 0x308
function function_c442449c28833212( var_3cfaf2c1ea620bf7, var_9a33e33d8e25ce67, var_206dde349aa84405 )
{
    level endon( #"game_ended" );
    a_spawn_pos = utility::getstructarray( self.target, "targetname" );
    current_pos = utility::array_random( a_spawn_pos );
    husk_zombie_type = subclass_to_aitype_map::function_427ae77ce1056e01( "zombie_base", [ "stam_zm_sat_mantis_fem_husk" ] );
    self.spawned_zombie = [];
    
    if ( !isdefined( var_3cfaf2c1ea620bf7 ) )
    {
        var_3cfaf2c1ea620bf7 = 10;
    }
    
    if ( !isdefined( var_9a33e33d8e25ce67 ) )
    {
        var_9a33e33d8e25ce67 = 10;
    }
    
    if ( !isdefined( var_206dde349aa84405 ) )
    {
        var_206dde349aa84405 = 15;
    }
    
    while ( true )
    {
        current_timeline = time_travel::get_current_timeline();
        
        if ( current_timeline.name == "past" )
        {
            wait 1;
            continue;
        }
        
        self.spawned_zombie = function_5713d46873b29625( self.spawned_zombie );
        self.spawned_zombie = function_46f9072493651dc9( self.spawned_zombie );
        
        if ( self.spawned_zombie.size >= var_3cfaf2c1ea620bf7 )
        {
            wait 1;
            continue;
        }
        
        var_f370b69d0d8846ba = utility::array_random( a_spawn_pos );
        
        if ( current_pos != var_f370b69d0d8846ba )
        {
            zombie = zm_quest::spawn_zombies_at_location( husk_zombie_type ?? "zombie_base", var_f370b69d0d8846ba, 1, 0, undefined, 1, 99, 1 )[ 0 ];
            
            if ( isalive( zombie ) )
            {
                zombie utility::function_7c10ea82c1e305b8( "base", "base_off" );
                zombie utility::function_7c10ea82c1e305b8( "simple_dissolve", "hide_immediately" );
                zombie utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_in_long" );
                zombie zombie_utils::function_a8ce00e0448cb6f0( "wander", "zm_quest", 20 );
                zombie utility::callsharedfunc( #"w_mod", #"wisp_ignore", "teacher_zombie" );
                zombie val::set( #"lost_soul_zombie", "show_healthbar", 0 );
                zombie val::set( #"lost_soul_zombie", "allow_brot", 0 );
                zombie val::set( #"lost_soul_zombie", "ignoreme", 1 );
                zombie.nodamagenumbers = 1;
                zombie function_66dc8b6ae969f66d( 1 );
                zombie.b_cleanup_no_respawn = 1;
                zombie.var_a13bed1ac47e1b2c = 1;
                zombie.no_powerups = 1;
                zombie.var_15598d8e493afe88 = 1;
                zombie.var_825b17c932865df = 1;
                zombie callback::add( "on_zombie_ai_damaged", &floating_zombie_damaged );
                zombie.nocorpse = 1;
                zombie.parent_struct = self;
                zombie utility::delaythread( 30, &despawn_lost_soul_zombie, self );
                
                if ( utility::flag( "start_lost_soul_collection" ) && !level utility::flag( "has_hit_all_lost_soul_balls" ) )
                {
                    zombie thread float_lost_soul_zombie();
                }
                else
                {
                    zombie thread function_41c3cbfc31ff8cdd( self );
                }
                
                current_pos = var_f370b69d0d8846ba;
                self.spawned_zombie[ self.spawned_zombie.size ] = zombie;
            }
        }
        
        wait randomintrange( var_9a33e33d8e25ce67, var_206dde349aa84405 );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x6d4dee57, Offset: 0xd4a0
// Size: 0x122
function despawn_lost_soul_zombie( parent_struct )
{
    level endon( #"game_ended" );
    
    if ( isdefined( parent_struct ) )
    {
        parent_struct.spawned_zombie = function_5713d46873b29625( parent_struct.spawned_zombie );
        parent_struct.spawned_zombie = function_46f9072493651dc9( parent_struct.spawned_zombie );
        parent_struct.spawned_zombie = arrayremove( parent_struct.spawned_zombie, self );
    }
    
    val::set( #"lost_soul_zombie", "damage", 0 );
    utility::function_7c10ea82c1e305b8( "base", "base_off" );
    
    if ( self.var_9acd9f766ba0edef )
    {
        utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_out" );
        playfx( level._effect[ "piano_teacher_despawn" ], self gettagorigin( "j_spine4" ) );
    }
    else
    {
        utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_out_long" );
    }
    
    if ( self.var_9acd9f766ba0edef )
    {
        wait 0.6;
    }
    else
    {
        wait 2;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    val::nuke( "damageshield" );
    self.nocorpse = 1;
    self kill();
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x5089ae78, Offset: 0xd5ca
// Size: 0x42
function floating_zombie_damaged( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        despawn_lost_soul_zombie( self.parent_struct );
        return;
    }
    
    thread lost_soul_zombie_hit( params.eattacker );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x58979a66, Offset: 0xd614
// Size: 0xa7
function private float_lost_soul_zombie()
{
    self motionwarpcancel();
    
    if ( !isdefined( self.floatparent ) )
    {
        floatparent = utility::spawn_model( "tag_origin", self.origin );
        floatparent.floating_zombie = self;
        self.floatparent = floatparent;
    }
    
    if ( !self islinked() )
    {
        self.floatparent.origin = self.origin;
        self.floatparent.angles = self.angles;
        self linkto( self.floatparent );
    }
    
    thread function_67e100ddf3b88f28();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x398b92e8, Offset: 0xd6c3
// Size: 0x1a0
function function_67e100ddf3b88f28()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_4dd9c210b998e030 = "floatinplace_base_1";
    var_f32b2e445d0d23b6 = randomint( 2 );
    
    switch ( var_f32b2e445d0d23b6 )
    {
        case 0:
            var_4dd9c210b998e030 = "floatinplace_base_1";
            break;
        case 1:
            var_4dd9c210b998e030 = "floatinplace_base_2";
            break;
    }
    
    self function_695b8e1b655c2796( "floatinplacetype", var_4dd9c210b998e030 );
    
    if ( self asmhasstate( self.asmname, "float_in_place_in" ) )
    {
        asm::function_7256f5ba459c840b( "float_in_place_in" );
    }
    
    z_offset = randomintrange( 100, 150 );
    self.floatparent moveto( self.origin + ( 0, 0, z_offset ), 10, 5, 5 );
    self.floatparent waittill( #"movedone" );
    floating_time = randomintrange( 3, 5 );
    level utility::flag_wait_or_timeout( "has_hit_all_lost_soul_balls", floating_time );
    
    if ( !isdefined( self.floatparent ) )
    {
        return;
    }
    
    self.floatparent moveto( self.origin - ( 0, 0, z_offset ), 10, 5, 5 );
    self.floatparent waittill( #"movedone" );
    asm::asm_fireevent( self.asmname, "float_in_place_end" );
    self unlink();
    utility::delaythread( 1, &delete_entity, self.floatparent );
    thread function_41c3cbfc31ff8cdd( self.parent_struct );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xd7b9aba2, Offset: 0xd86b
// Size: 0xf5
function lost_soul_zombie_hit( attacker )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.var_9acd9f766ba0edef )
    {
        return;
    }
    
    self.var_9acd9f766ba0edef = 1;
    
    if ( self getlinkedparent() )
    {
        self unlink();
    }
    
    if ( isdefined( self ) )
    {
        if ( !attacker utility::ent_flag( "played_hit_lost_soul_zombie" ) )
        {
            attacker utility::ent_flag_set( "played_hit_lost_soul_zombie" );
            level utility::delaythread( 0.5, &battlechatter_mp::trysaylocalsound, attacker, #"bc_flavor_player_positive" );
        }
        
        if ( level utility::flag( "start_lost_soul_collection" ) && !level utility::flag( "has_hit_all_lost_soul_balls" ) && isdefined( self.floatparent ) )
        {
            level thread function_773e6cd13ecc2b49( self.origin );
        }
        
        if ( isdefined( self.floatparent ) )
        {
            self.floatparent delete();
        }
        
        despawn_lost_soul_zombie( self.parent_struct );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x68279b4f, Offset: 0xd968
// Size: 0x128
function function_773e6cd13ecc2b49( source_origin )
{
    level endon( #"game_ended" );
    var_ecd903937e8b4aba = utility::spawn_model( "tag_origin", source_origin );
    playfxontag( level._effect[ "lost_soul_orb" ], var_ecd903937e8b4aba, "tag_origin" );
    level notify( #"hit_lost_soul_zombie", var_ecd903937e8b4aba );
    var_2cfa0923a420e109 = utility::getstruct( "zombiejacks_x_pos_future", "targetname" );
    
    if ( !isdefined( var_2cfa0923a420e109.var_9b9e609dc553ae20 ) )
    {
        var_2cfa0923a420e109.var_9b9e609dc553ae20 = 0;
    }
    
    var_2cfa0923a420e109.var_9b9e609dc553ae20++;
    target_pos = var_2cfa0923a420e109.origin + anglestoforward( ( 0, 120 * var_2cfa0923a420e109.var_9b9e609dc553ae20, 0 ) ) * 50 + ( 0, 0, 50 );
    var_ecd903937e8b4aba utility::function_8001268940441423( var_ecd903937e8b4aba.origin, target_pos, averagepoint( [ var_ecd903937e8b4aba.origin, target_pos ] ) + ( 0, 0, 700 ), 10, 0, 1 );
    var_ecd903937e8b4aba utility::ent_flag_set( "soul_ball_finish_move" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xf7b9002b, Offset: 0xda98
// Size: 0x359
function function_ccff9a47c3e958fd()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.var_f29a1a3a4b49f9c5 ) )
    {
        self.var_f29a1a3a4b49f9c5 = [];
    }
    
    while ( self.var_f29a1a3a4b49f9c5.size < 3 )
    {
        level waittill( #"hit_lost_soul_zombie", var_ecd903937e8b4aba );
        self.var_f29a1a3a4b49f9c5 = arraycombineunique( self.var_f29a1a3a4b49f9c5, [ var_ecd903937e8b4aba ] );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level zm_quest::function_9f49b2a045ece8ae( self.var_f29a1a3a4b49f9c5.size, 1, #"mantis_mq_guidance", #"tortured" );
        }
    }
    
    level utility::flag_set( "has_hit_all_lost_soul_balls" );
    
    while ( true )
    {
        var_14cceeafed2138d = 1;
        
        foreach ( var_ecd903937e8b4aba in self.var_f29a1a3a4b49f9c5 )
        {
            if ( !var_ecd903937e8b4aba utility::ent_flag( "soul_ball_finish_move" ) )
            {
                var_14cceeafed2138d = 0;
                break;
            }
        }
        
        if ( var_14cceeafed2138d )
        {
            level utility::flag_set( "all_lost_soul_balls_arrived" );
            function_4ef47d3c5c627fb6();
            self.mdl utility::function_7c10ea82c1e305b8( "fx", "glow" );
            level waittill( #"pre_timetravel_done", next_timeline );
            
            foreach ( var_ecd903937e8b4aba in self.var_f29a1a3a4b49f9c5 )
            {
                var_ecd903937e8b4aba thread time_travel::function_b981ae62bbb5502f( next_timeline.name );
            }
            
            self.var_f29a1a3a4b49f9c5[ 0 ] waittill( #"timetravel_entity_done" );
            wait 3;
            
            foreach ( var_ecd903937e8b4aba in self.var_f29a1a3a4b49f9c5 )
            {
                v_ground_pos = getgroundposition( var_ecd903937e8b4aba.origin, 10 );
                var_ecd903937e8b4aba moveto( ( var_ecd903937e8b4aba.origin[ 0 ], var_ecd903937e8b4aba.origin[ 1 ], v_ground_pos[ 2 ] ), 2, 2, 0 );
            }
            
            wait 2;
            
            foreach ( var_ecd903937e8b4aba in self.var_f29a1a3a4b49f9c5 )
            {
                playfx( level._effect[ "music_note_ball_drop" ], var_ecd903937e8b4aba.origin );
                var_ecd903937e8b4aba delete();
                waitframe();
            }
            
            return;
        }
        
        wait 1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xdf1b2038, Offset: 0xddf9
// Size: 0xeb
function cleanup_play_jacks_game( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "zombiejacks_ready" );
        level utility::flag_set( "zombiejacks_success" );
        s_zombiejacks_center = utility::getstruct( "zombiejacks_center", "targetname" );
        s_zombiejacks_center thread function_38fbefe3cbd41ad7( "zombiejacks", 0, 0 );
    }
    
    function_c54964758ba89b36();
    
    if ( isdefined( level.s_zombiejacks_game ) && isdefined( level.s_zombiejacks_game.var_fa795a9c34416db2 ) )
    {
        playfx( level._effect[ "zombiejacks_success" ], level.s_zombiejacks_game.var_fa795a9c34416db2.origin, anglestoforward( level.s_zombiejacks_game.var_fa795a9c34416db2.angles ) );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x171890f2, Offset: 0xdeec
// Size: 0x8c
function setup_deliver_sheet_music( b_skipped, b_restored )
{
    if ( b_skipped || function_e47978231f7567bf() )
    {
        return;
    }
    
    level thread zm_music::start_zone_music_watcher( "deliver_sheet", level.var_59f211cd543ad7ea, #"hash_a25feafc46ce156a" );
    level.s_sheet_music = utility::getstruct( "sheet_music_start_pos", "targetname" );
    level.s_sheet_music function_aab344b8fc8e34e( "sheet_music" );
    level thread zm_music::function_e9fd14ede793ef0d( "deliver_sheet" );
    level utility::flag_set( "sheet_music_delivered" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xb1c391c, Offset: 0xdf80
// Size: 0xcf
function cleanup_deliver_sheet_music( b_skipped, b_restored )
{
    b_restored = function_e47978231f7567bf();
    
    if ( b_skipped )
    {
        level utility::flag_set( "sheet_music_delivered" );
    }
    
    function_c54964758ba89b36();
    function_97fc663d165aa881( "sheet_music_final_pos" );
    function_97fc663d165aa881( "future_sheet_music" );
    s_piano_past = utility::getstruct( "past_piano_pos", "targetname" );
    
    if ( isdefined( s_piano_past.sbl ) )
    {
        s_piano_past.sbl utility::function_7c10ea82c1e305b8( "fx", "off" );
    }
    
    if ( !b_restored && !b_skipped )
    {
        level utility::delaythread( 2.5, &zm_quest::function_d5ef98341fd6a057, [ #"hash_9a51e826242e22be", #"hash_9a51e726242e210b" ] );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x5da18c5e, Offset: 0xe057
// Size: 0x43
function setup_prepare_final_fight( b_skipped, b_restored )
{
    if ( b_skipped )
    {
        return;
    }
    
    function_4ef47d3c5c627fb6();
    level thread function_32d659f05c8c7af5();
    zm_sat_mantis::register_clock_time_notify( "0:1", "has_set_clock_time_for_mq", 0 );
    function_d54ed84a70808738();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x3976b255, Offset: 0xe0a2
// Size: 0xa1
function function_32d659f05c8c7af5()
{
    level endon( #"game_ended" );
    level endon( #"has_started_pre_boss_two_sister_scenes" );
    zm_sat_mantis::register_clock_time_notify( "11:1", "has_set_clock_time_for_mq_sound_tell_0", 0, 1 );
    zm_sat_mantis::register_clock_time_notify( "0:0", "has_set_clock_time_for_mq_sound_tell_1", 0, 1 );
    
    while ( true )
    {
        utility::waittill_any( "has_set_clock_time_for_mq_sound_tell_0", "has_set_clock_time_for_mq_sound_tell_1" );
        playsoundatpos( level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292.origin, #"hash_8f1a6ad73cbb6359" );
        waitframe();
        level utility::flag_clear( "has_set_clock_time_for_mq_sound_tell_0" );
        level utility::flag_clear( "has_set_clock_time_for_mq_sound_tell_1" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x9075f4b2, Offset: 0xe14b
// Size: 0x9f
function function_2e1b2d4837b10adc( timeline_name )
{
    level endon( #"game_ended" );
    var_e9770fd6f37dec3 = timeline_name == "past" ? "twins_vignette_cloud" : "dark_heart";
    
    while ( true )
    {
        level waittill( #"pre_timetravel_done", target_timeline );
        
        if ( target_timeline.name == timeline_name )
        {
            s_cloud_vfx = utility::getstruct( var_e9770fd6f37dec3, "targetname" );
            s_cloud_vfx.vfx = function_5cb04c35b2faa393( "aether_cloud", s_cloud_vfx );
            break;
        }
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x8feecdcf, Offset: 0xe1f2
// Size: 0x2c, Type: bool
function function_8f757ac7f5b852a9( a, b )
{
    return a.script_int < b.script_int;
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xeb45d86c, Offset: 0xe227
// Size: 0x586
function function_d54ed84a70808738( var_2f385dafed4699c8 )
{
    level endon( #"game_ended" );
    scene_nodes = utility::getstructarray( "final_sister_scene", "targetname" );
    scene_nodes = arraysort( scene_nodes, undefined, &function_8f757ac7f5b852a9 );
    level.vfx_proxy = utility::spawn_model( "tag_origin" );
    
    if ( var_2f385dafed4699c8 )
    {
        s_twins_vignette_cloud = utility::getstruct( "twins_vignette_cloud", "targetname" );
        level.players[ 0 ] setorigin( getgroundposition( s_twins_vignette_cloud.origin, 16 ) );
    }
    else
    {
        level utility::flag_wait( "has_set_clock_time_for_mq" );
    }
    
    level utility::flag_set( "has_started_pre_boss_two_sister_scenes" );
    function_c4348e073a6dd322();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_preamble" );
    s_twins_vignette_cloud = utility::getstruct( "twins_vignette_cloud", "targetname" );
    level utility::flag_waitopen( "timetravel_ongoing" );
    utility::callsharedfunc( #"sat_timetravel", #"disable" );
    level.vfx_proxy.origin = s_twins_vignette_cloud.origin + ( 0, 0, -5 );
    playfx( level._effect[ "two_sister_scene_energy_ball_spawn" ], level.vfx_proxy.origin + ( 0, 0, -30 ) );
    waitframe();
    playfxontag( level._effect[ "two_sister_scene_energy_ball_trial" ], level.vfx_proxy, "tag_origin" );
    s_twins_vignette_cloud zm_quest::function_86087eb932daecb9( s_twins_vignette_cloud.radius );
    wait 1;
    function_4ef47d3c5c627fb6();
    s_landing_pos = utility::getstruct( s_twins_vignette_cloud.target, "targetname" );
    level.vfx_proxy moveto( s_landing_pos.origin + ( 0, 0, 30 ), 7, 3.5, 3.5 );
    wait 7.5;
    level.vfx_proxy.origin = s_landing_pos.origin;
    level.vfx_proxy function_820bc9251a7e97b0( scene_nodes[ 0 ].origin, 100 );
    wait 1;
    stopfxontag( level._effect[ "two_sister_scene_energy_ball_trial" ], level.vfx_proxy, "tag_origin" );
    waitframe();
    playfx( level._effect[ "two_sister_scene_energy_ball_despawn" ], level.vfx_proxy.origin );
    
    for ( i = 0; i < scene_nodes.size ; i++ )
    {
        level.vfx_proxy.origin = scene_nodes[ i ].origin;
        wait 0.1;
        playfxontag( level._effect[ "two_sister_scene_ambient" ], level.vfx_proxy, "tag_origin" );
        scene_nodes[ i ] zm_quest::player_distance_and_look_at_looping_check( 300, 1 );
        scene_nodes[ i ] function_6c35d300b51c9262();
        scene_nodes[ i ].var_db75d3de862ce072 = 1;
        
        if ( isdefined( scene_nodes[ i + 1 ] ) )
        {
            stopfxontag( level._effect[ "two_sister_scene_ambient" ], level.vfx_proxy, "tag_origin" );
            wait 0.5;
            
            if ( isdefined( scene_nodes[ i ].final_scene_end_pos ) )
            {
                level.vfx_proxy.origin = scene_nodes[ i ].final_scene_end_pos;
            }
            
            playfx( level._effect[ "two_sister_scene_energy_ball_spawn" ], level.vfx_proxy.origin );
            waitframe();
            playfxontag( level._effect[ "two_sister_scene_energy_ball_trial" ], level.vfx_proxy, "tag_origin" );
            level.vfx_proxy function_820bc9251a7e97b0( scene_nodes[ i + 1 ].origin, 100 );
            wait 0.5;
            stopfxontag( level._effect[ "two_sister_scene_energy_ball_trial" ], level.vfx_proxy, "tag_origin" );
            waitframe();
            playfx( level._effect[ "two_sister_scene_energy_ball_despawn" ], level.vfx_proxy.origin );
            continue;
        }
        
        if ( isdefined( scene_nodes[ i ].final_scene_end_pos ) )
        {
            level.vfx_proxy.origin = scene_nodes[ i ].final_scene_end_pos;
        }
        
        stopfxontag( level._effect[ "two_sister_scene_ambient" ], level.vfx_proxy, "tag_origin" );
        wait 1;
        playfx( level._effect[ "two_sister_scene_energy_ball_spawn" ], level.vfx_proxy.origin );
        s_final_destination = utility::getstruct( "boss_fight_start", "targetname" );
        waitframe();
        playfxontag( level._effect[ "two_sister_scene_energy_ball_trial" ], level.vfx_proxy, "tag_origin" );
        level.vfx_proxy function_820bc9251a7e97b0( s_final_destination.origin, 100 );
        wait 1;
        stopfxontag( level._effect[ "two_sister_scene_energy_ball_trial" ], level.vfx_proxy, "tag_origin" );
        waitframe();
        playfx( level._effect[ "two_sister_scene_energy_ball_despawn" ], level.vfx_proxy.origin );
        level.vfx_proxy thread utility::delete_after_delay( 10 );
        return;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x3486b369, Offset: 0xe7b5
// Size: 0x73
function function_d533eaae7d691f25( death_sister, alive_sister )
{
    level endon( #"game_ended" );
    level utility::flag_set( "played_first_meet_scene" );
    alive_sister dialogue::say( "dx_zm_mamn_3otp_lvtw_mm3twvg2ln1" );
    death_sister dialogue::say( "dx_zm_mamn_3otp_detw_mm3twvg2ln2" );
    death_sister dialogue::say( "dx_zm_mamn_3otp_detw_mm3twvg2ln3" );
    alive_sister dialogue::say( "dx_zm_mamn_3otp_lvtw_mm3twvg2ln4" );
    level utility::flag_set( "first_meet_sisters_vo_done" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xfc3db710, Offset: 0xe830
// Size: 0x80
function function_823c282842d2ad3e( death_sister, alive_sister )
{
    self notify( #"hash_442870b2bed407cf" );
    self endon( #"hash_442870b2bed407cf" );
    wait 2;
    function_c841b94609aaccd( undefined, death_sister, alive_sister );
    
    if ( utility::cointoss() )
    {
        alive_sister thread dialogue::say( "dx_zm_mamn_1stw_lvtw_mm1shdfd" );
    }
    else
    {
        death_sister thread dialogue::say( "dx_zm_mamn_1stw_detw_mm1shdfd" );
    }
    
    level utility::flag_set( "meet_sisters_generic_vo_done" );
    wait 2;
    level utility::flag_clear( "meet_sisters_generic_vo_done" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x778df863, Offset: 0xe8b8
// Size: 0x281
function function_820bc9251a7e97b0( target_position, move_speed = 50 )
{
    level endon( #"game_ended" );
    smoothness = 0.5;
    path_accuracy = 0.5;
    var_360d3f0890420a2 = 1;
    b_draw_path = 0;
    total_dist = 0;
    a_paths = findpathcustom( self.origin, target_position, 1, 1 );
    point_i = 1;
    
    while ( point_i < a_paths.size )
    {
        total_dist += distance( a_paths[ point_i - 1 ], a_paths[ point_i ] );
        point_i += 1;
    }
    
    self.total_time = total_dist / move_speed;
    times = [];
    point_i = 1;
    
    while ( point_i < a_paths.size )
    {
        times[ times.size ] = distance( a_paths[ point_i - 1 ], a_paths[ point_i ] ) / total_dist * self.total_time;
        point_i += 1;
    }
    
    times[ times.size ] = level.framedurationseconds;
    tension = clamp( 1 - smoothness, 0.01, 1 );
    alpha = clamp( path_accuracy, 0, 1 );
    splineid = function_53253e8ea222ed60( a_paths, times, 0, tension, alpha, 1 );
    total_dist = function_176ae9ba12543764( splineid );
    var_c6b13c5ef8b9d064 = total_dist / self.total_time * level.framedurationseconds;
    thread function_8f5da7eab375e74a( splineid );
    
    if ( b_draw_path )
    {
        childthread utility::function_9f777c9a7fffb9fc( splineid, self.total_time, "stop_curve" );
    }
    
    self.current_time = 0;
    
    while ( self.current_time < self.total_time )
    {
        if ( self.current_time >= self.total_time )
        {
            self.current_time = self.total_time;
            break;
        }
        
        self.origin = function_2bf2352736fc6ac8( splineid, self.current_time ) + ( 0, 0, 30 );
        
        if ( !var_360d3f0890420a2 )
        {
            delta = function_b9f720559b798d98( splineid, self.current_time, var_c6b13c5ef8b9d064 );
            self.current_time += delta;
        }
        else
        {
            self.current_time += level.framedurationseconds;
        }
        
        waitframe();
    }
    
    self notify( #"stop_curve" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x9e23e38e, Offset: 0xeb41
// Size: 0xb0
function function_6c35d300b51c9262()
{
    level endon( #"game_ended" );
    function_cb97fa0cd1866090( 1 );
    scene::add_scene_func( self, &sister_scene_played, self.script_noteworthy );
    scene::add_scene_func( self, &function_5f09f614edac1a35, "hold_idle_01" );
    thread scene::play( undefined, "hold_idle_01" );
    level thread zm_round_spawning::pause_round_spawning( 1, "final_twins_vigettes" );
    
    if ( !utility::flag( "first_meet_sisters_vo_done" ) )
    {
        level utility::flag_wait( "first_meet_sisters_vo_done" );
    }
    else
    {
        level utility::flag_wait_or_timeout( "meet_sisters_generic_vo_done", 10 );
    }
    
    scene::play( undefined, self.script_noteworthy );
    function_cb97fa0cd1866090( 0 );
    level thread zm_round_spawning::pause_round_spawning( 0, "final_twins_vigettes" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xe55f66e1, Offset: 0xebf9
// Size: 0x1ab
function function_cb97fa0cd1866090( var_f1fbc291f2430b1e )
{
    scene_zone = zone_manager::function_90e5c3e2272b0130( self.origin );
    
    if ( var_f1fbc291f2430b1e )
    {
        if ( !level callback::exists( "on_zombie_ai_damaged", &cleanup_player_ignore_me ) )
        {
            level callback::add( "on_zombie_ai_damaged", &cleanup_player_ignore_me );
        }
        
        foreach ( player in level.players )
        {
            player thread function_9b5a5fd486708507( scene_zone.script_zone_name );
        }
        
        zone_spawner::function_2ce7db1d59b307d8( scene_zone.script_zone_name );
        return;
    }
    
    wait 1;
    
    foreach ( player in level.players )
    {
        player notify( #"hash_2f4e0eb9125e97ce" );
        player val::reset( "mq_ignore_check", "ignoreme" );
    }
    
    if ( level callback::exists( "on_zombie_ai_damaged", &cleanup_player_ignore_me ) )
    {
        level callback::remove( "on_zombie_ai_damaged", &cleanup_player_ignore_me );
    }
    
    zone_spawner::function_8a020f24a3b73c79( scene_zone.script_zone_name );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x8f7410be, Offset: 0xedac
// Size: 0x150
function function_9b5a5fd486708507( str_zone_name )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_2f4e0eb9125e97ce" );
    
    while ( true )
    {
        zone = zone_manager::get_current_zone();
        
        if ( isdefined( zone ) )
        {
            break;
        }
        
        wait 1;
    }
    
    if ( zone.zone_name == str_zone_name )
    {
        val::set( "mq_ignore_check", "ignoreme", 1 );
        
        while ( true )
        {
            zone = zone_manager::get_current_zone();
            
            if ( !isdefined( zone ) )
            {
                wait 0.1;
                continue;
            }
            
            if ( zone.zone_name != str_zone_name )
            {
                val::reset( "mq_ignore_check", "ignoreme" );
                break;
            }
            
            wait 0.1;
        }
        
        return;
    }
    
    while ( true )
    {
        zone = zone_manager::get_current_zone();
        
        if ( !isdefined( zone ) )
        {
            wait 0.1;
            continue;
        }
        
        if ( zone.zone_name == str_zone_name )
        {
            val::set( "mq_ignore_check", "ignoreme", 1 );
            break;
        }
        
        wait 0.1;
    }
    
    while ( true )
    {
        zone = zone_manager::get_current_zone();
        
        if ( zone.zone_name != str_zone_name )
        {
            val::reset( "mq_ignore_check", "ignoreme" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x98b4c7be, Offset: 0xef04
// Size: 0x4b
function cleanup_player_ignore_me( params )
{
    player = params.eattacker;
    self notify( #"hash_2f4e0eb9125e97ce" );
    
    if ( isplayer( player ) )
    {
        player val::reset( "mq_ignore_check", "ignoreme" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x65ce0d80, Offset: 0xef57
// Size: 0x102
function function_56b43ef476942965()
{
    self.var_2a345ab3ef50328c = scene::get_entities();
    
    if ( !isdefined( self.final_scene_end_pos ) )
    {
        self.final_scene_end_pos = ( 0, 0, 0 );
    }
    
    var_da07b511b8312f1b = 0;
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
        {
            self.final_scene_end_pos += model.origin;
            var_da07b511b8312f1b++;
        }
    }
    
    self.final_scene_end_pos /= var_da07b511b8312f1b;
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x9b4f60c5, Offset: 0xf061
// Size: 0x1d9
function function_5f09f614edac1a35()
{
    self.var_2a345ab3ef50328c = scene::get_entities();
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
        {
            model dontcastshadows();
            model utility::function_7c10ea82c1e305b8( "reveal", "invisible" );
            model.scriptable_clip = spawnscriptable( "sat_zm_sat_scriptable_mantis_twins_clip", model.origin, model.angles );
            model.scriptable_clip thread function_59da914cbdb4429f( model );
            
            if ( issubstr( model.model, "skeletal" ) )
            {
                death_sister = model;
                continue;
            }
            
            alive_sister = model;
        }
    }
    
    wait 1;
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        model castshadows();
        model utility::function_7c10ea82c1e305b8( "reveal", "reveal_in" );
    }
    
    wait 1;
    
    if ( !level utility::flag( "played_first_meet_scene" ) )
    {
        level thread function_d533eaae7d691f25( death_sister, alive_sister );
        return;
    }
    
    level thread function_823c282842d2ad3e( death_sister, alive_sister );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x39b0fd23, Offset: 0xf242
// Size: 0x50
function function_59da914cbdb4429f( model )
{
    level endon( #"game_ended" );
    
    while ( isdefined( model ) )
    {
        self.origin = model.origin;
        self.angles = model.angles;
        waitframe();
    }
    
    self freescriptable();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x770af469, Offset: 0xf29a
// Size: 0xd3
function sister_scene_played()
{
    waittime = scene::function_b3c7b792a7a154fa( self.script_noteworthy ) - 3;
    waittime = clamp( waittime, 0.1, waittime );
    wait waittime;
    self.var_2a345ab3ef50328c = scene::get_entities();
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        model utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
        model dontcastshadows();
    }
    
    wait 3;
    function_56b43ef476942965();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xd8af0091, Offset: 0xf375
// Size: 0x33f
function init_boss_fight_interaction()
{
    var_7aff5953fd7753db = utility::getstruct( "start_boss_sister_scene", "targetname" );
    scene::add_scene_func( var_7aff5953fd7753db, &function_f23c806e7808e30e, "callback_play" );
    var_7aff5953fd7753db thread scene::play( undefined, "idle_01" );
    var_246eddca74f72c57 = utility::getstruct( "boss_fight_start", "targetname" );
    sbl_vfx = function_5cb04c35b2faa393( "music_box_ambient", var_246eddca74f72c57 );
    show_model_clip( "swing_clip_past" );
    level thread function_9c82acc06745d81a( "swing_clip_past", "swing_safe_point_past" );
    level utility::flag_wait( "twins_warning_vo_done" );
    var_246eddca74f72c57.interaction = zm_quest::function_91f9590e98d57ff6( var_246eddca74f72c57.origin, &on_start_boss_fight, &hint_start_boss_fight );
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "start_boss_fight" );
    var_246eddca74f72c57.interaction zm_quest::function_9170db4686f796e2();
    sbl_vfx freescriptable();
    function_c4348e073a6dd322();
    s_future_toy_box = utility::getstruct( "future_toy_box", "targetname" );
    
    if ( isdefined( s_future_toy_box.sbl ) )
    {
        s_future_toy_box.sbl delete();
    }
    
    if ( isdefined( s_future_toy_box.vfx_sbl ) )
    {
        s_future_toy_box.vfx_sbl freescriptable();
    }
    
    var_177f4904b7d9bed = utility::getstruct( "future_monkey_cymbals_in_box" );
    
    if ( isdefined( var_177f4904b7d9bed.mdl ) )
    {
        var_177f4904b7d9bed.mdl delete();
    }
    
    hide_model_clip( "future_toy_box_clip" );
    var_177f4904b7d9bed = utility::getstruct( "future_monkey_cymbals_in_box" );
    
    if ( isdefined( var_177f4904b7d9bed.mdl ) )
    {
        var_177f4904b7d9bed.mdl delete();
    }
    
    var_3fef63e1d71c19c8 = utility::getstruct( "future_maxis_goggles_in_box" );
    
    if ( isdefined( var_3fef63e1d71c19c8.mdl ) )
    {
        var_3fef63e1d71c19c8.mdl delete();
    }
    
    var_446c83597103a7de = utility::getstruct( "future_maxis_headphone_in_box" );
    
    if ( isdefined( var_446c83597103a7de.mdl ) )
    {
        var_446c83597103a7de.mdl delete();
    }
    
    deactivateworldevent( "we_lgt_toy_box_future" );
    s_final_teleport_pos = utility::getstruct( "final_teleport_pos", "targetname" );
    
    foreach ( player in level.players )
    {
        level thread zm_fasttravel_core::function_cbb08198e7c84adf( s_final_teleport_pos, player, undefined, undefined, 0.25, 0.25 );
    }
    
    wait 1;
    s_cloud_vfx = utility::getstruct( "twins_vignette_cloud", "targetname" );
    
    if ( isdefined( s_cloud_vfx.vfx ) )
    {
        s_cloud_vfx.vfx freescriptable();
    }
    
    hide_model_clip( "swing_clip_past" );
    level thread zm_sat_mantis_boss_fight::start_boss_fight();
    level.players[ 0 ] waittill( #"fasttravel_finished" );
    wait 1;
    var_7aff5953fd7753db scene::stop();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x5fd3530f, Offset: 0xf6bc
// Size: 0x2ac
function function_f23c806e7808e30e()
{
    self.var_2a345ab3ef50328c = scene::get_entities();
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
        {
            model dontcastshadows();
            model utility::function_7c10ea82c1e305b8( "reveal", "invisible" );
        }
        
        if ( issubstr( model.model, "skeletal" ) )
        {
            death_sister = model;
            continue;
        }
        
        alive_sister = model;
    }
    
    wait 1;
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        model castshadows();
        model utility::function_7c10ea82c1e305b8( "reveal", "reveal_in" );
    }
    
    zm_quest::player_distance_and_look_at_looping_check( 200 );
    
    foreach ( player in level.players )
    {
        player val::set( "final_twins_vo", "allow_battlechatter_vo", 0 );
    }
    
    function_cb97fa0cd1866090( 1 );
    alive_sister dialogue::say( "dx_zm_mamn_3otp_lvtw_mm3bfwrnl1" );
    death_sister dialogue::say( "dx_zm_mamn_3otp_detw_mm3bfwrnl2" );
    level utility::flag_set( "twins_warning_vo_done" );
    
    foreach ( player in level.players )
    {
        player val::reset( "final_twins_vo", "allow_battlechatter_vo" );
    }
    
    function_cb97fa0cd1866090( 0 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x56e249ee, Offset: 0xf970
// Size: 0x8a
function hint_start_boss_fight( interact, player )
{
    if ( !zm_quest::function_f98968f17772726c() || utility::flag( "gonna_timetravel_after_special_round" ) || interact.disable )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_mantis/start_final_encounter", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x4dc23456, Offset: 0xfa03
// Size: 0x141
function on_start_boss_fight( player )
{
    if ( !zm_quest::function_f98968f17772726c() )
    {
        return;
    }
    
    if ( utility::flag( "gonna_timetravel_after_special_round" ) )
    {
        return;
    }
    
    if ( self.disable )
    {
        return;
    }
    
    self.disable = 1;
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"disable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"disable" );
    }
    
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.init_message = &"hash_368ffead421750f5";
    var_3faf858e79cd17bb.description = &"zm_hud/start_final_encounter";
    b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb );
    
    if ( b_passed )
    {
        level val::set( "mantis_boss_fight", "task_logic_activate", 0 );
        player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"boss_fight_vote", #"bc_flavor_player_positive" );
        wait 1;
        level utility::flag_set( "start_boss_fight" );
        return;
    }
    
    self.disable = 0;
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"enable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"enable" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x530f2e28, Offset: 0xfb4c
// Size: 0x61
function cleanup_prepare_final_fight( b_skipped, b_restored )
{
    level utility::flag_set( "final_twins_scenes_complete" );
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "has_set_clock_time_for_mq" );
    }
    
    function_c4348e073a6dd322();
    utility::callsharedfunc( #"sat_timetravel", #"enable" );
    namespace_24edb5d87524aa7f::activate();
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x803becab, Offset: 0xfbb5
// Size: 0xd0
function function_342fb29a371150ec( script_label )
{
    models = [];
    a_mq_models = utility::getstructarray( "mq_models", "targetname" );
    
    foreach ( s_model in a_mq_models )
    {
        if ( isdefined( s_model.script_label ) && getxhash( s_model.script_label ) == script_label )
        {
            models = arraycombineunique( models, [ s_model ] );
        }
    }
    
    return models;
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x43d3858a, Offset: 0xfc8e
// Size: 0xe6
function function_97fc663d165aa881( targetname )
{
    a_s_model = utility::getstructarray( targetname, "targetname" );
    
    foreach ( s_model in a_s_model )
    {
        s_model.sbl = spawnscriptable( "sat_zm_sat_scriptable_mantis_mq_model_proxy", s_model.origin, s_model.angles );
        s_model.sbl setscriptablepartstate( "base", s_model.script_noteworthy );
    }
    
    if ( a_s_model.size == 1 )
    {
        return a_s_model[ 0 ];
    }
    
    return a_s_model;
}

// Namespace zm_sat_mantis_quest_mq
// Params 11
// Checksum 0x85b1b64d, Offset: 0xfd7d
// Size: 0x454
function function_543c34973b1fe755( event_name, var_a2e61118462245b9, n_radius, var_966908610d169ffa, z_offset, target_z_offset, var_ee4ab17964b27fdc, override_difficulty_round, b_pause_round_spawning, var_dcec2de39056bd18, var_d491d990bbe18f9b )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( var_dcec2de39056bd18 ) )
    {
        var_dcec2de39056bd18 = 1;
    }
    
    if ( !isdefined( level.var_d6f60091fc18cf8b ) )
    {
        level.var_d6f60091fc18cf8b = [];
    }
    
    if ( !isdefined( level.var_d6f60091fc18cf8b[ event_name ] ) )
    {
        level.var_d6f60091fc18cf8b[ event_name ] = self;
    }
    
    level.var_d6f60091fc18cf8b[ event_name ].var_a2e61118462245b9 = var_a2e61118462245b9;
    level.var_d6f60091fc18cf8b[ event_name ].n_radius = n_radius;
    level.var_d6f60091fc18cf8b[ event_name ].var_966908610d169ffa = var_966908610d169ffa;
    level.var_d6f60091fc18cf8b[ event_name ].z_offset = z_offset;
    level.var_d6f60091fc18cf8b[ event_name ].target_z_offset = target_z_offset;
    level.var_d6f60091fc18cf8b[ event_name ].var_dcec2de39056bd18 = var_dcec2de39056bd18;
    level.var_d6f60091fc18cf8b[ event_name ].var_d491d990bbe18f9b = var_d491d990bbe18f9b;
    level utility::flag_set( "progressing_soul_charging" );
    
    if ( !level callback::exists( "on_zombie_ai_killed", &function_a2e7acab7c5062d1, event_name ) )
    {
        level callback::add( "on_zombie_ai_killed", &function_a2e7acab7c5062d1, event_name );
    }
    
    if ( utility::issharedfuncdefined( #"ww_mantis", #"hash_b3e97e9465134b1b" ) )
    {
        foreach ( player in level.players )
        {
            utility::callsharedfunc( #"ww_mantis", #"hash_b3e97e9465134b1b", player, 1 );
        }
    }
    
    if ( b_pause_round_spawning )
    {
        level thread zm_round_spawning::pause_round_spawning( 1, event_name );
    }
    
    while ( level.var_d6f60091fc18cf8b[ event_name ].var_a2e61118462245b9 > 0 )
    {
        self waittill( level.var_d6f60091fc18cf8b[ event_name ].var_966908610d169ffa );
        
        if ( !self.var_c9007b3961e45062 )
        {
            self.var_c9007b3961e45062 = 1;
            activator = self.activator ?? level.players[ 0 ];
            activator utility::delaythread( 1.5, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"plant_magic_seed", #"hash_5212ed7ec42f115a" );
        }
        
        level.var_d6f60091fc18cf8b[ event_name ].var_a2e61118462245b9--;
        zm_quest::function_9f49b2a045ece8ae( 30 - level.var_d6f60091fc18cf8b[ event_name ].var_a2e61118462245b9, 1, #"mantis_mq_guidance", #"sapling_feed" );
    }
    
    level notify( #"hash_49ebe81e4505b503" );
    
    if ( level callback::exists( "on_zombie_ai_spawned", &function_4fdde1d058dfa952, event_name ) )
    {
        level callback::remove( "on_zombie_ai_spawned", &function_4fdde1d058dfa952, event_name );
    }
    
    if ( level callback::exists( "on_zombie_ai_killed", &function_a2e7acab7c5062d1, event_name ) )
    {
        level callback::remove( "on_zombie_ai_killed", &function_a2e7acab7c5062d1, event_name );
    }
    
    if ( utility::issharedfuncdefined( #"ww_mantis", #"hash_b3e97e9465134b1b" ) )
    {
        foreach ( player in level.players )
        {
            utility::callsharedfunc( #"ww_mantis", #"hash_b3e97e9465134b1b", player, 0 );
        }
    }
    
    level.var_d6f60091fc18cf8b = function_a5c1175d3ea3c25a( level.var_d6f60091fc18cf8b, level.var_d6f60091fc18cf8b[ event_name ] );
    level utility::flag_clear( "progressing_soul_charging" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xcc640053, Offset: 0x101d9
// Size: 0x64
function function_4fdde1d058dfa952( params, event_name )
{
    if ( !isdefined( event_name ) || !isdefined( level.var_d6f60091fc18cf8b[ event_name ] ) )
    {
        return;
    }
    
    if ( self.var_9ee436be1a5adf9c )
    {
        if ( randomintrange( 0, 100 ) < 80 )
        {
            utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
            self.var_18e6b5a5503b6d20 = 1;
        }
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x2d526d9f, Offset: 0x10245
// Size: 0x12f
function function_a2e7acab7c5062d1( params, event_name )
{
    if ( !isplayer( params.eattacker ) || !isdefined( event_name ) || !isdefined( level.var_d6f60091fc18cf8b ) || self.var_89125e347adf8723 )
    {
        return;
    }
    
    if ( !isdefined( level.var_d6f60091fc18cf8b[ event_name ] ) || !isdefined( level.var_d6f60091fc18cf8b[ event_name ].var_a2e61118462245b9 ) || level.var_d6f60091fc18cf8b[ event_name ].var_a2e61118462245b9 <= 0 )
    {
        return;
    }
    
    if ( level.var_d6f60091fc18cf8b[ event_name ].var_dcec2de39056bd18 && !function_a5a51281116197be( params.objweapon ) )
    {
        return;
    }
    
    if ( distancesquared( self.origin, level.var_d6f60091fc18cf8b[ event_name ].origin ) < squared( level.var_d6f60091fc18cf8b[ event_name ].n_radius ) )
    {
        self.var_89125e347adf8723 = 1;
        level thread function_2739a81fb812849c( self.origin, event_name, self.subclass );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 3
// Checksum 0x8730dec8, Offset: 0x1037c
// Size: 0x165
function function_2739a81fb812849c( original_pos, event_name, var_c60105d2445aa45f )
{
    level endon( #"game_ended" );
    target_pos = level.var_d6f60091fc18cf8b[ event_name ].origin;
    override_z_offset = level.var_d6f60091fc18cf8b[ event_name ].z_offset;
    str_notify = level.var_d6f60091fc18cf8b[ event_name ].var_966908610d169ffa;
    target_z_offset = level.var_d6f60091fc18cf8b[ event_name ].target_z_offset ?? 0;
    fx_proxy = utility::spawn_model( "tag_origin", original_pos + ( 0, 0, override_z_offset ) );
    fx_proxy function_6358f47b17a2238a( fx_proxy.origin, target_pos + ( 0, 0, target_z_offset ), 0.1, 30, 0, var_c60105d2445aa45f );
    waitframe();
    
    if ( isdefined( level.var_d6f60091fc18cf8b[ event_name ].var_d491d990bbe18f9b ) )
    {
        playfx( level._effect[ level.var_d6f60091fc18cf8b[ event_name ].var_d491d990bbe18f9b ], target_pos + ( 0, 0, target_z_offset ) );
    }
    
    waitframe();
    
    if ( isdefined( str_notify ) && isdefined( level.var_d6f60091fc18cf8b[ event_name ] ) )
    {
        level.var_d6f60091fc18cf8b[ event_name ] notify( str_notify );
    }
    
    fx_proxy delete();
}

// Namespace zm_sat_mantis_quest_mq
// Params 3
// Checksum 0xc9e10160, Offset: 0x104e9
// Size: 0xb7
function function_e376d7fb1528e429( event_name, var_3a02867df0104858, var_966908610d169ffa )
{
    level endon( #"game_ended" );
    self.var_d00b944707343dc9 = function_62a1e2a01bb2b285();
    self.start_point = utility::getstruct( self.target, "targetname" );
    thread start_loop_rotate();
    self.mdl moveto( self.start_point.origin, 3 );
    self.mdl waittill( #"movedone" );
    thread function_447000806dcbdae( event_name, var_3a02867df0104858, var_966908610d169ffa );
    thread function_1c5e502cd6d8b0c0( event_name, 0, 1, 0.5, 0.5, 0 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 3
// Checksum 0xfd8c491a, Offset: 0x105a8
// Size: 0x36f
function function_447000806dcbdae( event_name, var_3a02867df0104858, var_966908610d169ffa )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_f30684042758e7ab ) )
    {
        level.var_f30684042758e7ab = [];
    }
    
    if ( !isdefined( level.var_f30684042758e7ab[ event_name ] ) )
    {
        level.var_f30684042758e7ab[ event_name ] = self;
    }
    
    level.var_f30684042758e7ab[ event_name ].var_3a02867df0104858 = var_3a02867df0104858;
    level.var_f30684042758e7ab[ event_name ].n_radius = 500;
    level.var_f30684042758e7ab[ event_name ].var_966908610d169ffa = var_966908610d169ffa;
    
    if ( !isdefined( level.var_f30684042758e7ab[ event_name ].charged_time ) )
    {
        level.var_f30684042758e7ab[ event_name ].charged_time = 0;
    }
    
    if ( !level callback::exists( "on_zombie_ai_killed", &function_2231a0cb42173871, event_name ) )
    {
        level callback::add( "on_zombie_ai_killed", &function_2231a0cb42173871, event_name );
    }
    
    if ( utility::issharedfuncdefined( #"ww_mantis", #"hash_b3e97e9465134b1b" ) )
    {
        foreach ( player in level.players )
        {
            utility::callsharedfunc( #"ww_mantis", #"hash_b3e97e9465134b1b", player, 1 );
        }
    }
    
    while ( true )
    {
        if ( !isdefined( self.total_time ) || !isdefined( self.current_time ) )
        {
            wait 0.1;
            continue;
        }
        
        if ( self.total_time <= self.current_time )
        {
            break;
        }
        
        message = utility::waittill_any_return( level.var_f30684042758e7ab[ event_name ].var_966908610d169ffa, event_name + "_charge_movement_done" );
        
        if ( message == event_name + "_charge_movement_done" )
        {
            break;
        }
        
        level.var_f30684042758e7ab[ event_name ].charged_time += level.var_f30684042758e7ab[ event_name ].var_3a02867df0104858;
        level.var_f30684042758e7ab[ event_name ].charged_time = clamp( level.var_f30684042758e7ab[ event_name ].charged_time, 0, 12 );
    }
    
    if ( level callback::exists( "on_zombie_ai_killed", &function_2231a0cb42173871, event_name ) )
    {
        level callback::remove( "on_zombie_ai_killed", &function_2231a0cb42173871, event_name );
    }
    
    if ( utility::issharedfuncdefined( #"ww_mantis", #"hash_b3e97e9465134b1b" ) )
    {
        foreach ( player in level.players )
        {
            utility::callsharedfunc( #"ww_mantis", #"hash_b3e97e9465134b1b", player, 0 );
        }
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x73c53c87, Offset: 0x1091f
// Size: 0xfc
function function_2231a0cb42173871( params, event_name )
{
    if ( !isdefined( level.var_f30684042758e7ab[ event_name ] ) || !isdefined( level.var_f30684042758e7ab ) || !isdefined( event_name ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_f30684042758e7ab[ event_name ].mdl ) )
    {
        return;
    }
    
    if ( !function_a5a51281116197be( params.objweapon, 1 ) )
    {
        return;
    }
    
    if ( self.var_8a70691493cf1e58 )
    {
        return;
    }
    
    if ( distancesquared( self.origin, level.var_f30684042758e7ab[ event_name ].mdl.origin ) < squared( level.var_f30684042758e7ab[ event_name ].n_radius ) )
    {
        self.var_8a70691493cf1e58 = 1;
        level thread energy_fly( self.origin, event_name, params.eattacker, self.subclass );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xb253cae3, Offset: 0x10a23
// Size: 0x6e
function start_loop_rotate( event_name )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_402653d154a75a2 = vectortoangles( ( 0, 1, 0 ) );
    
    while ( true )
    {
        if ( isdefined( self.mdl ) )
        {
            self.mdl rotateby( var_402653d154a75a2, 2, 0, 0 );
            wait 2;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xcc775cc8, Offset: 0x10a99
// Size: 0xea
function function_62a1e2a01bb2b285()
{
    var_d00b944707343dc9 = [];
    start_point = utility::getstruct( self.target, "targetname" );
    var_d00b944707343dc9 = arraycombineunique( var_d00b944707343dc9, [ start_point.origin ] );
    previous_point = start_point;
    
    while ( true )
    {
        next_point = utility::getstruct( previous_point.target, "targetname" );
        
        if ( next_point.script_noteworthy == "end" )
        {
            self.var_53ee1d63dbf83a50 = distance( previous_point.origin, next_point.origin );
            var_d00b944707343dc9 = arraycombineunique( var_d00b944707343dc9, [ next_point.origin ] );
            break;
        }
        
        var_d00b944707343dc9 = arraycombineunique( var_d00b944707343dc9, [ next_point.origin ] );
        previous_point = next_point;
        waitframe();
    }
    
    return var_d00b944707343dc9;
}

// Namespace zm_sat_mantis_quest_mq
// Params 6
// Checksum 0xc50403d6, Offset: 0x10b8c
// Size: 0x300
function function_1c5e502cd6d8b0c0( event_name, b_update_angles, var_360d3f0890420a2, smoothness = 0.5, path_accuracy = 0.5, b_draw_path = 0 )
{
    level endon( #"game_ended" );
    total_dist = 0;
    point_i = 1;
    
    while ( point_i < self.var_d00b944707343dc9.size )
    {
        total_dist += distance( self.var_d00b944707343dc9[ point_i - 1 ], self.var_d00b944707343dc9[ point_i ] );
        point_i += 1;
    }
    
    self.total_time = total_dist / 50;
    times = [];
    point_i = 1;
    
    while ( point_i < self.var_d00b944707343dc9.size )
    {
        times[ times.size ] = distance( self.var_d00b944707343dc9[ point_i - 1 ], self.var_d00b944707343dc9[ point_i ] ) / total_dist * self.total_time;
        point_i += 1;
    }
    
    times[ times.size ] = level.framedurationseconds;
    tension = clamp( 1 - smoothness, 0.01, 1 );
    alpha = clamp( path_accuracy, 0, 1 );
    splineid = function_53253e8ea222ed60( self.var_d00b944707343dc9, times, 0, tension, alpha, 1 );
    total_dist = function_176ae9ba12543764( splineid );
    var_c6b13c5ef8b9d064 = total_dist / self.total_time * level.framedurationseconds;
    thread function_8f5da7eab375e74a( splineid );
    
    if ( b_draw_path )
    {
        childthread utility::function_9f777c9a7fffb9fc( splineid, self.total_time, "stop_curve" );
    }
    
    self.current_time = 0;
    
    while ( self.current_time < self.total_time )
    {
        if ( level.var_f30684042758e7ab[ event_name ].charged_time <= 0 )
        {
            wait 1;
            continue;
        }
        
        self.mdl.origin = function_2bf2352736fc6ac8( splineid, self.current_time );
        
        if ( b_update_angles )
        {
            self.mdl.angles = function_7062a9ae37ef4c8b( splineid, self.current_time );
        }
        
        if ( !var_360d3f0890420a2 )
        {
            delta = function_b9f720559b798d98( splineid, self.current_time, var_c6b13c5ef8b9d064 );
            self.current_time += delta;
        }
        else
        {
            self.current_time += level.framedurationseconds;
            level.var_f30684042758e7ab[ event_name ].charged_time -= level.framedurationseconds;
        }
        
        waitframe();
    }
    
    self notify( event_name + "_charge_movement_done" );
    self notify( #"stop_curve" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x309e32b4, Offset: 0x10e94
// Size: 0x24
function private function_8f5da7eab375e74a( splineid )
{
    utility::waittill_any( "stop_curve", "death" );
    spline_destroy( splineid );
}

// Namespace zm_sat_mantis_quest_mq
// Params 4
// Checksum 0x73e6d497, Offset: 0x10ec0
// Size: 0x183
function energy_fly( original_position, event_name, attacker, var_c60105d2445aa45f )
{
    level endon( #"game_ended" );
    fx_proxy = utility::spawn_model( "tag_origin", original_position + ( 0, 0, 20 ) );
    fx_proxy function_6358f47b17a2238a( fx_proxy.origin, level.var_f30684042758e7ab[ event_name ].mdl, 0.1, 5, 0, var_c60105d2445aa45f );
    
    if ( isdefined( level.var_f30684042758e7ab[ event_name ].var_966908610d169ffa ) )
    {
        level.var_f30684042758e7ab[ event_name ] notify( level.var_f30684042758e7ab[ event_name ].var_966908610d169ffa );
    }
    
    if ( isdefined( level.var_f30684042758e7ab[ event_name ] ) && !level.var_f30684042758e7ab[ event_name ].var_607b835f1055949c )
    {
        level.var_f30684042758e7ab[ event_name ].var_607b835f1055949c = 1;
        level utility::delaythread( 1.5, &battlechatter_mp::trysaylocalsound, attacker, #"bc_flavor_player_positive" );
    }
    
    if ( isdefined( level.var_f30684042758e7ab[ event_name ].mdl ) )
    {
        playfx( level._effect[ "musical_item_soul_impact" ], level.var_f30684042758e7ab[ event_name ].mdl.origin );
    }
    
    waitframe();
    fx_proxy delete();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xb88e93e8, Offset: 0x1104b
// Size: 0x242
function function_3ac40564c8d4a11b( game_name, var_51fc71a7fc018be )
{
    level endon( #"game_ended" );
    zm_quest::player_distance_and_look_at_looping_check( 400, 1 );
    level zm_round_spawning::pause_round_spawning( 1, game_name );
    s_chalk_scene = utility::getstruct( game_name + "_chalk_scene", "targetname" );
    
    if ( isdefined( s_chalk_scene ) )
    {
        function_c4348e073a6dd322();
        scene::add_scene_func( s_chalk_scene, &function_ba183a9a6cc7c51b, s_chalk_scene.script_noteworthy );
        s_chalk_scene thread scene::play( undefined, s_chalk_scene.script_noteworthy );
        thread function_38fbefe3cbd41ad7( game_name, 3 );
        s_chalk_scene waittill( #"hash_727f747c3195bc81" );
    }
    
    level utility::delaythread( 5, &zm_round_spawning::pause_round_spawning, 0, game_name );
    wait 1;
    level utility::flag_set( game_name + "_ready" );
    
    while ( true )
    {
        function_4ef47d3c5c627fb6();
        
        switch ( game_name )
        {
            case #"hash_e0a842eb40779b86":
                level thread namespace_3424894d82205bda::init_foursquare_game();
                break;
            case #"hash_185cfa0d529104c6":
                level thread namespace_6f62bde560f47748::init_hopscotch_game();
                break;
            case #"hash_fe40b12b6ecedf49":
                level thread namespace_6f8905547d0e74ed::init_zombiejacks_game();
                break;
            default:
                break;
        }
        
        level waittill( game_name + "_game_completed", var_6b7ddb30cb82d43 );
        level utility::flag_clear( "progressing_mini_games" );
        
        /#
            iprintlnbold( "<dev string:x169>" + game_name + "<dev string:x173>" + ( var_6b7ddb30cb82d43 ? "<dev string:x18c>" : "<dev string:x194>" ) );
        #/
        
        if ( var_6b7ddb30cb82d43 )
        {
            playsoundatpos( self.origin, #"evt_mq_game_success" );
            level utility::flag_set( game_name + "_success" );
            return;
        }
        
        level utility::flag_set( "mini_game_cooldown" );
        function_4ef47d3c5c627fb6();
        function_4610a92c80703056( game_name );
        
        switch ( game_name )
        {
            case #"hash_e0a842eb40779b86":
                waittime = 60;
                break;
            case #"hash_185cfa0d529104c6":
                waittime = 30;
                break;
            case #"hash_fe40b12b6ecedf49":
                waittime = 60;
                break;
            default:
                waittime = 60;
                break;
        }
        
        wait waittime;
        level utility::flag_clear( "mini_game_cooldown" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 3
// Checksum 0xf0c4310e, Offset: 0x11295
// Size: 0x240
function function_38fbefe3cbd41ad7( game_name, wait_duration = 0, b_play_vfx = 1 )
{
    level endon( #"game_ended" );
    wait wait_duration;
    
    switch ( game_name )
    {
        case #"hash_e0a842eb40779b86":
            if ( !isdefined( self.mdl_chalk ) )
            {
                self.mdl_chalk = spawnscriptable( "sat_zm_sat_scriptable_chalk_drawing", self.origin, self.angles );
                self.mdl_chalk utility::function_7c10ea82c1e305b8( "base", self.script_noteworthy );
                self.mdl_chalk utility::function_7c10ea82c1e305b8( "fade", "fade_in" );
            }
            
            if ( b_play_vfx )
            {
                sbl = function_5cb04c35b2faa393( "foursquare_course_spawn", self );
            }
            
            break;
        case #"hash_185cfa0d529104c6":
            if ( !isdefined( self.mdl_chalk ) )
            {
                var_b3f4db17a9ce9aab = utility::getstruct( self.target, "targetname" );
                self.mdl_chalk = spawnscriptable( "sat_zm_sat_scriptable_chalk_drawing", var_b3f4db17a9ce9aab.origin, var_b3f4db17a9ce9aab.angles );
                self.mdl_chalk utility::function_7c10ea82c1e305b8( "base", var_b3f4db17a9ce9aab.script_noteworthy );
                self.mdl_chalk utility::function_7c10ea82c1e305b8( "fade", "fade_in" );
            }
            
            if ( b_play_vfx )
            {
                sbl = function_5cb04c35b2faa393( "hopscotch_course_spawn", var_b3f4db17a9ce9aab );
            }
            
            break;
        case #"hash_fe40b12b6ecedf49":
            if ( !isdefined( self.mdl_chalk ) )
            {
                self.mdl_chalk = spawnscriptable( "sat_zm_sat_scriptable_chalk_drawing", self.origin, self.angles );
                self.mdl_chalk utility::function_7c10ea82c1e305b8( "base", self.script_noteworthy );
                self.mdl_chalk utility::function_7c10ea82c1e305b8( "fade", "fade_in" );
            }
            
            if ( b_play_vfx )
            {
                sbl = function_5cb04c35b2faa393( "zombiejacks_course_spawn", self );
            }
            
            break;
        default:
            break;
    }
    
    wait 10;
    
    if ( isdefined( sbl ) && b_play_vfx )
    {
        sbl freescriptable();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xdb36981a, Offset: 0x114dd
// Size: 0xd8
function function_4610a92c80703056( game_name )
{
    level endon( #"game_ended" );
    playsoundatpos( self.origin, #"evt_mq_game_failure" );
    
    switch ( game_name )
    {
        case #"hash_e0a842eb40779b86":
            sbl = function_5cb04c35b2faa393( "foursquare_course_spawn_red", self );
            break;
        case #"hash_185cfa0d529104c6":
            var_b3f4db17a9ce9aab = utility::getstruct( self.target, "targetname" );
            sbl = function_5cb04c35b2faa393( "hopscotch_course_spawn_red", var_b3f4db17a9ce9aab );
            break;
        case #"hash_fe40b12b6ecedf49":
            sbl = function_5cb04c35b2faa393( "zombiejack_course_spawn_red", self );
            break;
        default:
            break;
    }
    
    wait 10;
    
    if ( isdefined( sbl ) )
    {
        sbl freescriptable();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x7894dc6b, Offset: 0x115bd
// Size: 0x305
function function_ba183a9a6cc7c51b()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player setsoundsubmix( "sat_zm_mantis_sister_appear" );
    }
    
    self.var_2a345ab3ef50328c = scene::get_entities();
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
        {
            model utility::function_7c10ea82c1e305b8( "reveal", "invisible" );
            model dontcastshadows();
        }
        else
        {
            model hide();
        }
        
        if ( issubstr( model.model, "skeletal" ) )
        {
            death_sister = model;
            continue;
        }
        
        alive_sister = model;
    }
    
    wait 1;
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
        {
            model castshadows();
            model utility::function_7c10ea82c1e305b8( "reveal", "reveal_in" );
            continue;
        }
        
        model show();
    }
    
    level utility::delaythread( 2.5, &function_c841b94609aaccd, self.script_label, death_sister, alive_sister );
    wait 13;
    
    foreach ( model in self.var_2a345ab3ef50328c )
    {
        if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
        {
            model utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
            model dontcastshadows();
            continue;
        }
        
        model hide();
    }
    
    wait 3;
    self notify( #"hash_727f747c3195bc81" );
    scene::stop();
}

// Namespace zm_sat_mantis_quest_mq
// Params 3
// Checksum 0xeec2ed6, Offset: 0x118ca
// Size: 0x199
function function_c841b94609aaccd( str_vo_name, var_7c1f7a1b3a7f5edb, var_832cc7d439929822 )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_9e0c181122f7e04d ) )
    {
        level.var_9e0c181122f7e04d = [ "dx_zm_mamn_2acm_lvtw_mm2ambdrplspa1", "dx_zm_mamn_2acm_detw_mm2ambdrplspa2", "dx_zm_mamn_2acm_lvtw_mm2ambdrplspa3ln1", "dx_zm_mamn_2acm_detw_mm2ambdrplspa4ln1", "dx_zm_mamn_2acm_lvtw_mm2ambdrplspa5", "dx_zm_mamn_2acm_detw_mm2ambdrplspa6" ];
    }
    
    alias_vo = utility::array_random( level.var_9e0c181122f7e04d );
    level.var_9e0c181122f7e04d = arrayremove( level.var_9e0c181122f7e04d, alias_vo );
    
    if ( !isdefined( alias_vo ) )
    {
        /#
            iprintlnbold( "<dev string:x19c>" );
        #/
        
        return;
    }
    
    if ( alias_vo == "dx_zm_mamn_2acm_lvtw_mm2ambdrplspa3ln1" )
    {
        alias_vo = [ "dx_zm_mamn_2acm_lvtw_mm2ambdrplspa3ln1", "dx_zm_mamn_2acm_detw_mm2ambdrplspa3ln2" ];
    }
    else if ( alias_vo == "dx_zm_mamn_2acm_detw_mm2ambdrplspa4ln1" )
    {
        alias_vo = [ "dx_zm_mamn_2acm_detw_mm2ambdrplspa4ln1", "dx_zm_mamn_2acm_lvtw_mm2ambdrplspa4ln2" ];
    }
    else
    {
        alias_vo = [ alias_vo ];
    }
    
    foreach ( str_vo in alias_vo )
    {
        if ( issubstr( str_vo, "lvtw" ) )
        {
            var_832cc7d439929822 dialogue::say( str_vo );
            continue;
        }
        
        var_7c1f7a1b3a7f5edb dialogue::say( str_vo );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x73d95184, Offset: 0x11a6b
// Size: 0x40
function function_f42c289863cba909( instance, player )
{
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xd72d7780, Offset: 0x11ab4
// Size: 0xe3
function function_50eb91766c602466()
{
    level endon( #"game_ended" );
    var_e7f23b81e59eab4c = utility::getstructarray( "ball_start_pos", "targetname" );
    level.start_pos = utility::array_random( var_e7f23b81e59eab4c );
    level.start_pos function_213295a3b3e2376c();
    level.start_pos thread function_1509fb0128dff87();
    level.start_pos thread function_9cdc28db98be4364();
    level utility::flag_wait( "start_foursquare_game" );
    wait 6;
    var_b399577791a5fae4 = utility::getstruct( "foursquare_x_pos_future", "targetname" );
    
    if ( isdefined( var_b399577791a5fae4.mdl ) )
    {
        var_b399577791a5fae4.mdl freescriptable();
    }
    
    if ( isdefined( level.start_pos.var_6fdd2f80be44e1bf ) )
    {
        level.start_pos.var_6fdd2f80be44e1bf delete();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x3b6c930d, Offset: 0x11b9f
// Size: 0x79
function function_1509fb0128dff87()
{
    self.var_6fdd2f80be44e1bf = utility::spawn_model( %"sat_zm_game_ball", self.origin, ( 0, 0, 0 ) );
    playfx( level._effect[ "goggles_pickup" ], self.origin );
    self.var_6fdd2f80be44e1bf setcandamage( 1 );
    thread bounced_listener();
    thread function_ba830cab5c2b4126();
    thread function_eb8a91896fc2383b();
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x1aa00ab0, Offset: 0x11c20
// Size: 0x72
function function_9cdc28db98be4364()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level utility::flag_wait( "timetravel_ongoing" );
        
        if ( !isdefined( self.var_6fdd2f80be44e1bf ) )
        {
            wait 1;
            continue;
        }
        
        if ( utility::flag( "mantis_mq_ball_set" ) )
        {
            level utility::flag_set( "start_foursquare_game" );
            return;
        }
        
        if ( utility::flag( "ball_set" ) )
        {
            level utility::flag_set( "start_foursquare_game" );
            return;
        }
        
        wait 1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x54d4a00d, Offset: 0x11c9a
// Size: 0x160
function function_eb8a91896fc2383b()
{
    level endon( #"game_ended" );
    level endon( #"start_foursquare_game" );
    self endon( #"ball_reached_destination" );
    self.var_b7143d458483c18a = gettime();
    
    while ( true )
    {
        remain_time = 120000 - gettime() - self.var_b7143d458483c18a;
        
        if ( remain_time < 0 )
        {
            self notify( #"ball_time_out" );
            playfx( level._effect[ "goggles_pickup" ], self.var_6fdd2f80be44e1bf.origin );
            self.var_6fdd2f80be44e1bf delete();
            utility::delaythread( 1, &function_1509fb0128dff87 );
            return;
        }
        
        current_zone = zone_manager::function_90e5c3e2272b0130( self.var_6fdd2f80be44e1bf.origin );
        
        if ( !isdefined( current_zone.script_zone_name ) )
        {
            if ( gettime() - self.var_e536ee4fdfbb50f6 > 10000 )
            {
                self notify( #"ball_time_out" );
                playfx( level._effect[ "goggles_pickup" ], self.var_6fdd2f80be44e1bf.origin );
                self.var_6fdd2f80be44e1bf delete();
                utility::delaythread( 1, &function_1509fb0128dff87 );
                return;
            }
        }
        else
        {
            self.var_e536ee4fdfbb50f6 = gettime();
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x1d2b5ccb, Offset: 0x11e02
// Size: 0xc2
function function_213295a3b3e2376c()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.var_d00b944707343dc9 ) )
    {
        self.var_d00b944707343dc9 = [];
    }
    
    self.var_d00b944707343dc9[ self.var_d00b944707343dc9.size ] = self;
    index = 0;
    self.index = index;
    
    while ( true )
    {
        if ( !isdefined( var_f370b69d0d8846ba ) )
        {
            var_f370b69d0d8846ba = self;
        }
        
        if ( !isdefined( var_f370b69d0d8846ba.target ) )
        {
            break;
        }
        
        var_f370b69d0d8846ba = utility::getstruct( var_f370b69d0d8846ba.target, "targetname" );
        index += 1;
        var_f370b69d0d8846ba.index = index;
        self.var_d00b944707343dc9[ self.var_d00b944707343dc9.size ] = var_f370b69d0d8846ba;
        waitframe();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xb56f8e2a, Offset: 0x11ecc
// Size: 0x226
function function_ba830cab5c2b4126()
{
    level endon( #"game_ended" );
    self endon( #"ball_time_out" );
    self endon( #"ball_reached_destination" );
    level endon( #"start_foursquare_game" );
    
    while ( true )
    {
        self.var_6fdd2f80be44e1bf waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( !self.var_6fdd2f80be44e1bf.physicsactivated )
        {
            self.var_6fdd2f80be44e1bf physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
            self.var_6fdd2f80be44e1bf physics_registerforcollisioncallback();
            self.var_6fdd2f80be44e1bf.physicsactivated = 1;
        }
        
        self.auto_pilot_times = 10;
        forward_dir = anglestoup( vectortoangles( self.var_6fdd2f80be44e1bf.origin - attacker.origin ) + ( 30, 0, 0 ) );
        self.var_6fdd2f80be44e1bf physics_applyimpulse( self.var_6fdd2f80be44e1bf.origin, forward_dir * 300 );
        self.var_6fdd2f80be44e1bf utility::function_7c10ea82c1e305b8( "sound", "impact" );
        
        /#
            line( self.var_6fdd2f80be44e1bf.origin, self.var_6fdd2f80be44e1bf.origin + forward_dir * 30, ( 1, 0, 0 ), 1, 1, 500 );
        #/
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x44368ee2, Offset: 0x120fa
// Size: 0x31f
function bounced_listener()
{
    level endon( #"game_ended" );
    self endon( #"ball_time_out" );
    level endon( #"start_foursquare_game" );
    self.auto_pilot_times = 0;
    var_b399577791a5fae4 = utility::getstruct( "foursquare_x_pos_future", "targetname" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( !self.var_6fdd2f80be44e1bf.physicsactivated )
        {
            continue;
        }
        
        target_origin = self.var_d00b944707343dc9[ self.var_d00b944707343dc9.size - 1 ].origin;
        
        if ( distance( self.var_6fdd2f80be44e1bf.origin, target_origin ) < 80 )
        {
            self.var_6fdd2f80be44e1bf setcandamage( 0 );
            self.var_6fdd2f80be44e1bf utility::function_7c10ea82c1e305b8( "fx", "glow" );
            
            /#
                iprintlnbold( "<dev string:x1c2>" );
            #/
            
            if ( isdefined( var_b399577791a5fae4.mdl ) )
            {
                var_b399577791a5fae4.mdl utility::function_7c10ea82c1e305b8( "fx", "glow" );
            }
            
            if ( distance( self.var_6fdd2f80be44e1bf.origin, target_origin ) >= 15 )
            {
                self.var_5e2372975ec6cf70 = undefined;
                path_forward_dir = vectornormalize2( target_origin - self.var_6fdd2f80be44e1bf.origin );
                self.var_6fdd2f80be44e1bf physics_applyimpulse( self.var_6fdd2f80be44e1bf.origin, path_forward_dir * 30 );
            }
            else
            {
                if ( !isdefined( self.var_5e2372975ec6cf70 ) )
                {
                    self.var_5e2372975ec6cf70 = gettime();
                }
                
                if ( gettime() - self.var_5e2372975ec6cf70 >= 5000 )
                {
                    self notify( #"ball_reached_destination" );
                    level utility::flag_set( "mantis_mq_ball_set" );
                    level utility::flag_set( "ball_set" );
                    function_4ef47d3c5c627fb6();
                    self.var_6fdd2f80be44e1bf physicsstopserver();
                    return;
                }
            }
            
            continue;
        }
        
        if ( isdefined( var_b399577791a5fae4.mdl ) )
        {
            var_b399577791a5fae4.mdl utility::function_7c10ea82c1e305b8( "fx", "off" );
        }
        
        if ( self.auto_pilot_times <= 0 )
        {
            self.var_6fdd2f80be44e1bf utility::function_7c10ea82c1e305b8( "fx", "off" );
            continue;
        }
        
        self.var_b7143d458483c18a = gettime();
        self.var_5e2372975ec6cf70 = undefined;
        paths = findpathcustom( self.var_6fdd2f80be44e1bf.origin, target_origin, 1, 1 );
        
        if ( !isdefined( paths ) || paths.size < 2 )
        {
            continue;
        }
        
        path_forward_dir = vectornormalize2( paths[ 1 ] - self.var_6fdd2f80be44e1bf.origin );
        self.var_6fdd2f80be44e1bf physics_applyimpulse( self.var_6fdd2f80be44e1bf.origin, path_forward_dir * 15 );
        
        /#
            iprintlnbold( "<dev string:x1db>" );
        #/
        
        self.var_6fdd2f80be44e1bf utility::function_7c10ea82c1e305b8( "fx", "glow" );
        self.auto_pilot_times--;
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xd2317c1a, Offset: 0x12421
// Size: 0xaa
function function_cbdccce38bb68171()
{
    if ( self.var_79cd0e3ed91687b9 )
    {
        return;
    }
    
    position = { #vertical_anchor:1, #horizontal_anchor:1, #top:0, #left:0 };
    widget_struct = { #position:position };
    ui::lui_registercallback( "zm_piano_puzzle_pressed", &function_33247e9064cc31cf );
    ui::lui_registercallback( "zm_piano_puzzle_close", &function_2536b5ae92e975b );
    set_player_ignoreme( 1, "mantis_piano_step" );
    scripted_widgets::create( "piano_puzzle", "scripted_widget_piano_puzzle_zm", widget_struct );
    self.var_79cd0e3ed91687b9 = 1;
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x5018a59, Offset: 0x124d3
// Size: 0x1fb
function function_33247e9064cc31cf( value )
{
    if ( isplayer( self ) )
    {
        self playrumbleonentity( "damage_heavy" );
    }
    
    switch ( value )
    {
        case #"hash_31100fbc01bd387c":
            self playsound( "evt_mantis_piano_a_low" );
            break;
        case #"hash_311012bc01bd3d35":
            self playsound( "evt_mantis_piano_b" );
            break;
        case #"hash_311011bc01bd3ba2":
            self playsound( "evt_mantis_piano_c" );
            break;
        case #"hash_31100cbc01bd33c3":
            self playsound( "evt_mantis_piano_d" );
            break;
        case #"hash_31100bbc01bd3230":
            self playsound( "evt_mantis_piano_e" );
            break;
        case #"hash_31100ebc01bd36e9":
            self playsound( "evt_mantis_piano_f" );
            break;
        case #"hash_31100dbc01bd3556":
            self playsound( "evt_mantis_piano_g" );
            break;
        case #"hash_311018bc01bd46a7":
            self playsound( "evt_mantis_piano_a_high" );
            break;
        default:
            break;
    }
    
    if ( isdefined( level.var_aaa29ee5b0d966bb ) )
    {
        level.var_aaa29ee5b0d966bb.var_5e78435f8f0387fe[ level.var_aaa29ee5b0d966bb.var_5e78435f8f0387fe.size ] = value;
        
        if ( level.var_aaa29ee5b0d966bb.a_password.size == level.var_aaa29ee5b0d966bb.var_5e78435f8f0387fe.size )
        {
            if ( arraycompare( level.var_aaa29ee5b0d966bb.a_password, level.var_aaa29ee5b0d966bb.var_5e78435f8f0387fe ) )
            {
                level notify( #"hash_8892174d5dd2be7f", 1, 0 );
                level notify( #"hash_819126740120ca8b" );
                utility::delaythread( 1.5, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"hash_de022110823db3a9", #"bc_flavor_player_positive" );
                return;
            }
            
            level notify( #"hash_8892174d5dd2be7f", 0, 0 );
            level.var_aaa29ee5b0d966bb.var_5e78435f8f0387fe = [];
        }
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xeeff1495, Offset: 0x126d6
// Size: 0x49
function function_2536b5ae92e975b( value )
{
    level notify( #"hash_8892174d5dd2be7f", 0, 1 );
    var_9902bc90a6febf32 = utility::getstruct( "past_piano_pos" );
    var_9902bc90a6febf32.interaction.b_in_cooldown = 0;
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x617c88b0, Offset: 0x12727
// Size: 0x8d
function function_7a242d6c4c3e8663( var_6b7ddb30cb82d43 )
{
    ui::function_c2505ff7b7fc55a4( "zm_piano_puzzle_pressed", &function_33247e9064cc31cf );
    ui::function_c2505ff7b7fc55a4( "zm_piano_puzzle_closed", &function_2536b5ae92e975b );
    self clearsoundsubmix( "sat_zm_mantis_play_piano" );
    
    if ( var_6b7ddb30cb82d43 )
    {
        thread utility::delaythreadendon( 21, undefined, &set_player_ignoreme, 0, "mantis_piano_step" );
    }
    else
    {
        thread utility::delaythreadendon( 3, undefined, &set_player_ignoreme, 0, "mantis_piano_step" );
    }
    
    scripted_widgets::destroy( "piano_puzzle" );
    self.var_79cd0e3ed91687b9 = undefined;
    self notify( #"hash_9e8d9fc2115cc662" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 3
// Checksum 0x490cf8b9, Offset: 0x127bc
// Size: 0x8f
function function_5cb04c35b2faa393( fx_name, var_674764efc550b2a4, angles )
{
    if ( !isvector( var_674764efc550b2a4 ) )
    {
        origin = var_674764efc550b2a4.origin;
        angles = var_674764efc550b2a4.angles;
    }
    else
    {
        origin = var_674764efc550b2a4;
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
    }
    
    sbl_vfx = spawnscriptable( "sat_zm_sat_scriptable_vfx_proxy", origin, angles );
    sbl_vfx utility::function_7c10ea82c1e305b8( "base", fx_name );
    return sbl_vfx;
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x83c1ca5e, Offset: 0x12854
// Size: 0x560
function setup_start_boss_fight( b_skipped, b_restored )
{
    if ( b_skipped )
    {
        return;
    }
    
    level thread init_boss_fight_interaction();
    level utility::flag_wait( "boss_fight_done" );
    level val::reset( "mantis_boss_fight", "task_logic_activate" );
    
    if ( !level val::get( "task_logic_activate" ) )
    {
        level val::set( "task_mq", "task_logic_activate" );
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"endigc" );
    var_9b0d439715f9b77c = utility::getstruct( "mantis_mq_outro", "targetname" );
    var_9b0d439715f9b77c scene::play();
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"endigc" );
    utility::array_thread( level.players, &val::set, "final_vote", "ignoreme", 1 );
    s_final_teleport_pos = utility::getstruct( "final_teleport_pos_past", "targetname" );
    var_f8e901bebcdb4c05 = zm_quest::function_3477750f338de598( s_final_teleport_pos, &"zm_sat_mantis/mission_complete_exfil", undefined, 0 );
    utility::array_thread( level.players, &val::reset, "final_vote", "ignoreme" );
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"enable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"enable" );
    }
    
    if ( !var_f8e901bebcdb4c05 )
    {
        foreach ( player in level.players )
        {
            level thread zm_fasttravel_core::function_cbb08198e7c84adf( s_final_teleport_pos, player );
        }
    }
    
    s_future_toy_box = utility::getstruct( "future_toy_box", "targetname" );
    s_future_toy_box.sbl = utility::spawn_model( s_future_toy_box.script_noteworthy, s_future_toy_box.origin, s_future_toy_box.angles );
    s_future_toy_box.sbl utility::function_7c10ea82c1e305b8( "anim", "open" );
    s_future_toy_box.sbl utility::function_7c10ea82c1e305b8( "fx", "on" );
    s_future_toy_box.vfx_sbl = function_5cb04c35b2faa393( "toybox_complete", s_future_toy_box );
    show_model_clip( "future_toy_box_clip" );
    var_177f4904b7d9bed = utility::getstruct( "future_monkey_cymbals_in_box" );
    var_177f4904b7d9bed.mdl = utility::spawn_model( var_177f4904b7d9bed.script_noteworthy, var_177f4904b7d9bed.origin, var_177f4904b7d9bed.angles );
    var_177f4904b7d9bed.mdl utility::function_7c10ea82c1e305b8( "material", "remove" );
    var_3fef63e1d71c19c8 = utility::getstruct( "future_maxis_goggles_in_box" );
    var_3fef63e1d71c19c8.mdl = utility::spawn_model( var_3fef63e1d71c19c8.script_noteworthy, var_3fef63e1d71c19c8.origin, var_3fef63e1d71c19c8.angles );
    var_3fef63e1d71c19c8.mdl thread start_bobbing( 5, 5 );
    var_446c83597103a7de = utility::getstruct( "future_maxis_headphone_in_box" );
    var_446c83597103a7de.mdl = utility::spawn_model( var_446c83597103a7de.script_noteworthy, var_446c83597103a7de.origin, var_446c83597103a7de.angles );
    var_446c83597103a7de.mdl thread start_bobbing( 5, 5, 1 );
    activateworldevent( "we_lgt_toy_box_future" );
    
    if ( level.timetravel )
    {
        foreach ( s_timeline in level.timetravel.timelines )
        {
            if ( s_timeline.name == "past" )
            {
                level.timetravel.timeline = s_timeline;
                break;
            }
        }
    }
    
    namespace_24edb5d87524aa7f::function_a2c1c84be2b355cb( "past" );
    zm_sat_mantis::function_a15e37d395e34804();
    zm_sat_mantis_boss_fight::function_8b15006049502df0( 0 );
    zm_sat_mantis::function_97f071991b379f23( 1 );
    
    if ( !var_f8e901bebcdb4c05 )
    {
        all_players_warped = 0;
        
        while ( !all_players_warped )
        {
            all_players_warped = 1;
            
            foreach ( player in level.players )
            {
                if ( player utility::flag( "is_in_fasttravel" ) )
                {
                    all_players_warped = 0;
                }
            }
            
            wait 1;
        }
        
        s_reward_spawn_pos = utility::getstruct( "reward_spawn_pos", "targetname" );
        zm_quest::function_2e003fa13e881f92( s_reward_spawn_pos );
    }
    
    wait 10;
    level thread zm_round_spawning::pause_round_spawning( 0, "mantis_boss_fight" );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xa7233f58, Offset: 0x12dbc
// Size: 0x37
function function_d94c34da496fb651()
{
    if ( !utility::flag( "start_boss_fight" ) && !self.isskipping )
    {
        zm_sat_mantis_boss_fight::function_8b15006049502df0( 1 );
        zm_sat_mantis::function_ae0561e420148611();
        zm_sat_mantis::function_97f071991b379f23( 0 );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x9070a638, Offset: 0x12dfb
// Size: 0x22
function function_795457ad2c6f9467()
{
    if ( !utility::flag( "start_boss_fight" ) )
    {
        zm_sat_mantis_boss_fight::function_8b15006049502df0( 0 );
        zm_sat_mantis::function_97f071991b379f23( 1 );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0x893a05, Offset: 0x12e25
// Size: 0x1c
function cleanup_start_boss_fight( b_skipped, b_restored )
{
    namespace_24edb5d87524aa7f::activate();
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xf51e4ecd, Offset: 0x12e49
// Size: 0x64, Type: bool
function function_a5a51281116197be( objweapon, var_ae8d14938d476e16 = 0 )
{
    if ( !( isdefined( objweapon ) && isdefined( objweapon.basename ) ) || !issubstr( objweapon.basename, "sat_ww_mantis_zm" ) )
    {
        return false;
    }
    
    if ( var_ae8d14938d476e16 && !weap_ww_mantis::is_sundergat( objweapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_mantis_quest_mq
// Params 3
// Checksum 0xefe0746c, Offset: 0x12eb6
// Size: 0xe3
function start_bobbing( n_offset, time, b_down )
{
    level endon( #"game_ended" );
    self endon( #"stop_bobbing" );
    self endon( #"death" );
    
    if ( !isdefined( b_down ) )
    {
        b_down = 0;
    }
    
    if ( isdefined( n_offset ) )
    {
        offset = n_offset;
    }
    else
    {
        offset = 8;
    }
    
    if ( b_down )
    {
        self.origin += ( 0, 0, offset );
        offset *= -1;
    }
    
    if ( !isdefined( time ) )
    {
        time = 10;
    }
    
    wait 0.5;
    
    while ( true )
    {
        self movez( offset, time, time / 2, time / 2 );
        self waittill( #"movedone" );
        self movez( offset * -1, time, time / 2, time / 2 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 2
// Checksum 0xef66cee5, Offset: 0x12fa1
// Size: 0x80
function function_fc6586658f88be77( var_65382c542eb6f6d2, var_b0b3b10c65a30023 = 0 )
{
    if ( !var_65382c542eb6f6d2 )
    {
        return;
    }
    
    max_ammo_spawn_pos = var_65382c542eb6f6d2;
    
    if ( var_b0b3b10c65a30023 )
    {
        max_ammo_spawn_pos = utility::function_8ae0ea62537eafc5( var_65382c542eb6f6d2, 100 );
    }
    
    if ( max_ammo_spawn_pos )
    {
        max_ammo_spawn_pos = getrandomnavpoint( max_ammo_spawn_pos, 50 );
    }
    
    if ( !max_ammo_spawn_pos )
    {
        return;
    }
    
    if ( isvector( max_ammo_spawn_pos ) )
    {
        powerups::powerup_drop( "full_ammo", max_ammo_spawn_pos + ( 0, 0, 15 ), undefined, undefined );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 8
// Checksum 0xf1a08584, Offset: 0x13029
// Size: 0x1c1
function function_e7869eb42f086a53( var_af7f4f3591726f3c, a_zones_disabled, end_wait_flag, activator, var_d001dfcce661070e, var_20edd4b5d319c149, round_difficulty_override, zombie_spawn_interval )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( var_20edd4b5d319c149 ) )
    {
        var_20edd4b5d319c149 = 5;
    }
    
    if ( !isdefined( var_d001dfcce661070e ) )
    {
        var_d001dfcce661070e = 5;
    }
    
    if ( !isdefined( round_difficulty_override ) )
    {
        round_difficulty_override = zm_round_logic::get_rb_round_number();
    }
    
    if ( !isdefined( zombie_spawn_interval ) )
    {
        zombie_spawn_interval = 3;
    }
    
    activator setthreatbiasgroup( "zm_mantis_progressing_minigame_threat" );
    zm_quest::function_f3521e80c38a757e( var_af7f4f3591726f3c, 1, var_d001dfcce661070e, var_20edd4b5d319c149, "zombie_base" );
    
    foreach ( zone in a_zones_disabled )
    {
        zone_spawner::function_2ce7db1d59b307d8( zone );
    }
    
    zm_quest::function_86c8e7751b4764f0( var_af7f4f3591726f3c, var_af7f4f3591726f3c + "_spawner", 0 );
    level thread zm_quest::function_9414c909ca3295c4( var_af7f4f3591726f3c, zombie_spawn_interval, round_difficulty_override, 0, undefined, undefined, undefined, undefined, undefined, 1 );
    level waittill( end_wait_flag );
    zm_quest::stop_wave_spawner( var_af7f4f3591726f3c, 1 );
    
    foreach ( zone in a_zones_disabled )
    {
        zone_spawner::function_8a020f24a3b73c79( zone );
    }
    
    if ( isdefined( activator ) )
    {
        activator setthreatbiasgroup( "zm_mantis_player_threat" );
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 6
// Checksum 0x3992bc8c, Offset: 0x131f2
// Size: 0x32f
function function_6358f47b17a2238a( original_pos, targetpos, slow_time, override_distance, var_f071a0344c75277a, var_c60105d2445aa45f )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"delete" );
    var_c3cd355859f2710e = [ "evt_mantis_soul_charge_spawn", "evt_mantis_soul_charge_lp", "evt_mantis_soul_charge_impact" ];
    self.angles = vectortoangles( ( 0, 0, 1 ) );
    waitframe();
    
    if ( issubstr( var_c60105d2445aa45f, "zombie_base" ) )
    {
        playfxontag( level._effect[ "zombie_soul_trasition" ], self, "tag_origin" );
    }
    else if ( issubstr( var_c60105d2445aa45f, "zombie_methone" ) )
    {
        playfxontag( level._effect[ "zombie_soul_trasition_dog" ], self, "tag_origin" );
    }
    else if ( issubstr( var_c60105d2445aa45f, "zombie_mimic" ) )
    {
        playfxontag( level._effect[ "zombie_soul_trasition_mimic" ], self, "tag_origin" );
    }
    else
    {
        playfxontag( level._effect[ "zombie_soul_trasition" ], self, "tag_origin" );
    }
    
    if ( isdefined( var_c3cd355859f2710e ) && var_c3cd355859f2710e.size >= 2 )
    {
        self playsound( var_c3cd355859f2710e[ 0 ] );
        waitframe();
        self playloopsound( var_c3cd355859f2710e[ 1 ] );
    }
    
    max_fly_speed = 10;
    
    if ( !isdefined( var_403a2c563d4f6df1 ) )
    {
        var_403a2c563d4f6df1 = 0.05;
    }
    
    if ( !isdefined( angles_blend_speed ) )
    {
        angles_blend_speed = 0.05;
    }
    
    fly_speed = max_fly_speed;
    angles_blend = 0;
    start_time = gettime();
    
    if ( !isdefined( slow_time ) )
    {
        slow_time = 0.1;
    }
    
    self movez( 30, 2 );
    wait 2;
    
    while ( isdefined( targetpos ) )
    {
        if ( isent( targetpos ) )
        {
            v_destination = targetpos.origin;
        }
        else
        {
            v_destination = targetpos;
        }
        
        if ( gettime() - start_time <= slow_time )
        {
            fly_speed = max_fly_speed * 0.1;
            angles_blend_speed = var_403a2c563d4f6df1 * 0.5;
        }
        else
        {
            fly_speed = max_fly_speed;
            angles_blend_speed = var_403a2c563d4f6df1;
        }
        
        face_angles = vectortoangles( v_destination - self.origin );
        new_angles = anglelerpquatfrac( self.angles, face_angles, angles_blend );
        self.angles = new_angles;
        self.origin = anglestoforward( self.angles ) * fly_speed + self.origin;
        
        if ( angles_blend <= 1 )
        {
            angles_blend += angles_blend_speed;
            angles_blend = clamp( angles_blend, 0, 1 );
        }
        
        dis = distancesquared( v_destination, self.origin );
        
        if ( isdefined( override_distance ) )
        {
            if ( dis <= squared( override_distance ) )
            {
                break;
            }
        }
        else if ( dis <= squared( 100 ) )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"curve_done" );
    
    if ( isdefined( var_c3cd355859f2710e ) && var_c3cd355859f2710e.size >= 3 )
    {
        self playsound( var_c3cd355859f2710e[ 2 ] );
        waitframe();
        self stoploopsound();
    }
    
    waitframe();
    
    if ( !isdefined( var_f071a0344c75277a ) )
    {
        var_f071a0344c75277a = 1;
    }
    
    if ( isdefined( self ) && var_f071a0344c75277a )
    {
        self delete();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0xcf476fa8, Offset: 0x13529
// Size: 0x5e
function function_fafaf224bad8c988( part_name )
{
    if ( !isdefined( self.ping_scriptable ) )
    {
        self.ping_scriptable = spawnscriptable( "sat_zm_sat_scriptable_mantis_mq_ping", self.origin, self.angles );
        self.ping_scriptable utility::function_7c10ea82c1e305b8( "base", part_name );
    }
    
    return self.ping_scriptable;
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x5ed72645, Offset: 0x13590
// Size: 0x1d
function function_8ba297827d67c95c()
{
    if ( isdefined( self.ping_scriptable ) )
    {
        self.ping_scriptable freescriptable();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x8f917353, Offset: 0x135b5
// Size: 0x58
function hide_model_clip( targetname )
{
    clip = utility::getent_or_struct( targetname, "targetname" );
    
    if ( isdefined( clip ) )
    {
        if ( !isdefined( clip.unresolved_collision_func ) )
        {
            clip.unresolved_collision_func = &movers::unresolved_collision_void;
        }
        
        clip connectpaths();
        clip hide();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 1
// Checksum 0x5884f055, Offset: 0x13615
// Size: 0x58
function show_model_clip( targetname )
{
    clip = utility::getent_or_struct( targetname, "targetname" );
    
    if ( isdefined( clip ) )
    {
        if ( !isdefined( clip.unresolved_collision_func ) )
        {
            clip.unresolved_collision_func = &movers::unresolved_collision_void;
        }
        
        clip show();
        clip disconnectpaths();
    }
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0x394429c3, Offset: 0x13675
// Size: 0x60, Type: bool
function function_e47978231f7567bf()
{
    if ( !zm_save::function_1dda3554974a999e() )
    {
        return false;
    }
    
    step_index = function_56381860c96a8dd9();
    saved_index = zm_quest::function_73720cdf21c3cfd7( #"mantis_mq", self.var_d502348c16c8d691.ref );
    
    if ( !isdefined( saved_index ) )
    {
        return false;
    }
    
    if ( step_index < saved_index )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xb1618cff, Offset: 0x136de
// Size: 0x46
function function_c54964758ba89b36()
{
    if ( function_e47978231f7567bf() )
    {
        return;
    }
    
    step_index = function_56381860c96a8dd9();
    zm_quest::function_4eefe6de31f5ddab( #"mantis_mq", self.var_d502348c16c8d691.ref, step_index + 1 );
}

// Namespace zm_sat_mantis_quest_mq
// Params 0
// Checksum 0xd1942d2c, Offset: 0x1372c
// Size: 0xbb
function function_56381860c96a8dd9()
{
    if ( isdefined( self.var_d502348c16c8d691 ) && isdefined( self.var_d502348c16c8d691.steps ) )
    {
        foreach ( index, var_ca114aa12dee1e8e in self.var_d502348c16c8d691.steps )
        {
            if ( self.ref == var_ca114aa12dee1e8e.ref )
            {
                return index;
            }
        }
    }
}

/#

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x8b40d6b1, Offset: 0x137ef
    // Size: 0x1d0, Type: dev
    function init_mq_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1e6>" );
        devgui::add_devgui_func( "<dev string:x1f3>", "<dev string:x1f3>", &test_inventory );
        devgui::add_devgui_func( "<dev string:x202>", "<dev string:x21a>", &play_fireplace_ambient );
        devgui::add_devgui_func( "<dev string:x231>", "<dev string:x231>", &start_foursquare_game );
        devgui::add_devgui_func( "<dev string:x247>", "<dev string:x247>", &init_foursquare_game );
        devgui::add_devgui_func( "<dev string:x25c>", "<dev string:x25c>", &start_zombiejacks_game );
        devgui::add_devgui_func( "<dev string:x273>", "<dev string:x273>", &init_zombiejacks_game );
        devgui::add_devgui_func( "<dev string:x289>", "<dev string:x289>", &init_hopscotch_game );
        devgui::add_devgui_func( "<dev string:x29d>", "<dev string:x29d>", &play_mantis_mq_outro );
        devgui::add_devgui_func( "<dev string:x2b2>", "<dev string:x2b2>", &function_edd9b58321724feb );
        devgui::add_devgui_func( "<dev string:x2c7>", "<dev string:x2c7>", &function_50eb91766c602466 );
        devgui::add_devgui_func( "<dev string:x2dd>", "<dev string:x2dd>", &function_267fdee9425e40d4 );
        devgui::add_devgui_func( "<dev string:x2f7>", "<dev string:x2f7>", &function_5843a564711cfe6f );
        devgui::add_devgui_func( "<dev string:x302>", "<dev string:x302>", &function_648d32df89e6e737 );
        devgui::add_devgui_func( "<dev string:x314>", "<dev string:x314>", &spawn_music_notes );
        devgui::add_devgui_func( "<dev string:x326>", "<dev string:x326>", &debug_play_music );
        devgui::add_devgui_func( "<dev string:x337>", "<dev string:x337>", &function_6fb49a657024a2bf );
        devgui::add_devgui_func( "<dev string:x34d>", "<dev string:x34d>", &function_dc15634d267182c5 );
        devgui::add_devgui_func( "<dev string:x35d>", "<dev string:x35d>", &function_ad188abd2a941074 );
        devgui::add_devgui_func( "<dev string:x36d>", "<dev string:x36d>", &function_23d85123df976902 );
        devgui::add_devgui_func( "<dev string:x382>", "<dev string:x382>", &function_5a5b3f4378306087 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x482aa7b5, Offset: 0x139c7
    // Size: 0x45, Type: dev
    function function_23d85123df976902()
    {
        level thread zm_quest::play_vo_events( [ #"hash_90e87ce4145b5ee3", #"hash_9ab977a28ab11c9b" ] );
        level utility::flag_set( "<dev string:x3a2>" );
        wait 2;
        level utility::flag_set( "<dev string:x3b7>" );
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0xb3f3c05b, Offset: 0x13a14
    // Size: 0x18, Type: dev
    function function_5a5b3f4378306087()
    {
        function_d54ed84a70808738( 1 );
        iprintlnbold( "<dev string:x3cc>" );
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x4d5cf67b, Offset: 0x13a34
    // Size: 0x29, Type: dev
    function function_ad188abd2a941074()
    {
        level.players[ 0 ] thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"pick_up_chalk", #"hash_5212ed7ec42f115a" );
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x2ba8e279, Offset: 0x13a65
    // Size: 0xc, Type: dev
    function function_dc15634d267182c5()
    {
        zm_sat_mantis::function_288672b38940d8b1();
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0xa15136c8, Offset: 0x13a79
    // Size: 0x1f, Type: dev
    function debug_play_music()
    {
        level utility::flag_set( "<dev string:x402>" );
        level utility::flag_set( "<dev string:x421>" );
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x4b078b33, Offset: 0x13aa0
    // Size: 0x1a, Type: dev
    function function_6fb49a657024a2bf()
    {
        level utility::flag_set( "<dev string:x421>" );
        level thread spawn_music_notes();
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x957d6bab, Offset: 0x13ac2
    // Size: 0xf0, Type: dev
    function spawn_music_notes()
    {
        var_304daba24914ef24 = utility::getstructarray( "<dev string:x43e>" );
        
        foreach ( s_note in var_304daba24914ef24 )
        {
            s_note.sbl = spawnscriptable( %"sat_zm_sat_scriptable_music_note", s_note.origin, s_note.angles );
            s_note.sbl setscriptablepartstate( "<dev string:x44f>", string( s_note.script_noteworthy ) );
            activateworldevent( "<dev string:x454>" + string( s_note.script_noteworthy ) );
        }
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x245d6b6b, Offset: 0x13bba
    // Size: 0x40, Type: dev
    function function_648d32df89e6e737()
    {
        s_swing_vig = utility::getstruct( "<dev string:x466>" );
        level.players[ 0 ] setorigin( s_swing_vig.origin );
        s_swing_vig thread scene::play();
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x54f885b5, Offset: 0x13c02
    // Size: 0x17, Type: dev
    function function_5843a564711cfe6f()
    {
        level.players[ 0 ] thread function_70e46aeb1d4397aa();
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x9c872212, Offset: 0x13c21
    // Size: 0x58, Type: dev
    function function_267fdee9425e40d4()
    {
        var_b3f4db17a9ce9aab = utility::getstruct( level.s_hopscotch_game.var_fa795a9c34416db2.target, "<dev string:x476>" );
        playfx( level._effect[ "<dev string:x481>" ], var_b3f4db17a9ce9aab.origin );
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0xb9acd573, Offset: 0x13c81
    // Size: 0x68, Type: dev
    function function_edd9b58321724feb()
    {
        item_goggles = zm_quest::drop_quest_item( level.players[ 0 ].origin, level.players[ 0 ].origin + ( 0, 0, 15 ), %"hash_48e6e1f630396901" );
        utility::delaythread( 1, &function_47af575f3c8d2ff7, item_goggles );
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x600b4a06, Offset: 0x13cf1
    // Size: 0x80, Type: dev
    function play_mantis_mq_outro()
    {
        var_9b0d439715f9b77c = utility::getstruct( "<dev string:x493>", "<dev string:x476>" );
        
        if ( isdefined( var_9b0d439715f9b77c ) )
        {
            zm_sat_mantis_boss_fight::function_a1ec0ac5f4056638();
            zm_sat_mantis::function_ae0561e420148611();
            level musicbank_utility::function_5aca66c390aa347d( level.players, #"endigc" );
            var_9b0d439715f9b77c scene::play();
            level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"endigc" );
            zm_sat_mantis::function_a15e37d395e34804();
            zm_sat_mantis_boss_fight::function_8c47fd1ce0207927();
        }
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0xd8d664b0, Offset: 0x13d79
    // Size: 0x44, Type: dev
    function init_hopscotch_game()
    {
        s_hopscotch_center = utility::getstruct( "<dev string:x4a3>", "<dev string:x476>" );
        s_hopscotch_center thread function_38fbefe3cbd41ad7( "<dev string:x4b4>" );
        level utility::flag_clear( "<dev string:x4be>" );
        level thread namespace_6f62bde560f47748::init_hopscotch_game();
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x24544fae, Offset: 0x13dc5
    // Size: 0x23, Type: dev
    function test_inventory()
    {
        zm_quest::function_b57dfe9625966b0b( #"music_box", 0, #"firewood", 1, 1 );
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0xc5415717, Offset: 0x13df0
    // Size: 0x43, Type: dev
    function init_foursquare_game()
    {
        s_foursquare_center = utility::getstruct( "<dev string:x4d5>", "<dev string:x476>" );
        s_foursquare_center thread function_38fbefe3cbd41ad7( "<dev string:x4e7>" );
        level utility::flag_clear( "<dev string:x4be>" );
        namespace_3424894d82205bda::init_foursquare_game();
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x314b4257, Offset: 0x13e3b
    // Size: 0x2f, Type: dev
    function play_fireplace_ambient()
    {
        s_fireplace_ambient = utility::getstruct( "<dev string:x4f2>", "<dev string:x476>" );
        function_5cb04c35b2faa393( "<dev string:x504>", s_fireplace_ambient );
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x1f26202c, Offset: 0x13e72
    // Size: 0x172, Type: dev
    function start_foursquare_game()
    {
        if ( !isdefined( level.s_foursquare_game ) )
        {
            level.s_foursquare_game = spawnstruct();
        }
        
        if ( !isdefined( level.s_foursquare_game.var_fa795a9c34416db2 ) )
        {
            level.s_foursquare_game.var_fa795a9c34416db2 = utility::getstruct( "<dev string:x4d5>", "<dev string:x476>" );
        }
        
        if ( !isdefined( level.s_foursquare_game.var_d7471cf7f600bf44 ) )
        {
            level.s_foursquare_game.var_d7471cf7f600bf44 = utility::getstruct( "<dev string:x50f>", "<dev string:x476>" );
        }
        
        var_d7471cf7f600bf44 = utility::getstruct( "<dev string:x50f>", "<dev string:x476>" );
        level.s_foursquare_game.var_6fdd2f80be44e1bf = utility::spawn_model( var_d7471cf7f600bf44.script_noteworthy, var_d7471cf7f600bf44.origin, var_d7471cf7f600bf44.angles );
        level.s_foursquare_game.var_6fdd2f80be44e1bf notsolid();
        damage_proxy = utility::spawn_model( "<dev string:x524>", var_d7471cf7f600bf44.origin, var_d7471cf7f600bf44.angles );
        damage_proxy linkto( level.s_foursquare_game.var_6fdd2f80be44e1bf );
        damage_proxy setcandamage( 1 );
        damage_proxy thread namespace_3424894d82205bda::damage_check();
        level.s_foursquare_game.var_6fdd2f80be44e1bf thread namespace_3424894d82205bda::function_ebbb44d244ca0531();
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x40f77f23, Offset: 0x13fec
    // Size: 0x43, Type: dev
    function init_zombiejacks_game()
    {
        s_zombiejacks_center = utility::getstruct( "<dev string:x541>", "<dev string:x476>" );
        s_zombiejacks_center thread function_38fbefe3cbd41ad7( "<dev string:x554>" );
        level utility::flag_clear( "<dev string:x4be>" );
        namespace_6f8905547d0e74ed::init_zombiejacks_game();
    }

    // Namespace zm_sat_mantis_quest_mq
    // Params 0
    // Checksum 0x543f8f5c, Offset: 0x14037
    // Size: 0x44, Type: dev
    function start_zombiejacks_game()
    {
        namespace_6f8905547d0e74ed::start_zombiejacks_game( level.players[ 0 ] );
        level.players[ 0 ] setorigin( level.s_zombiejacks_game.var_fa795a9c34416db2.origin );
    }

#/
