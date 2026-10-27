// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_mq.gsc  (hash_54685c8e4161bad6.gscc) (size: 250570 Bytes / 0x3d2ca / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc6a85ecc (3332923084)
// size ...... 250570 (0x3d2ca)
// includes .. 61  (offset: 0x38956)
// strings ... 778 (offset: 0x38b3e)
// dev strs .. 98  (offset: 0x3cdda)
// exports ... 363 (offset: 0x2b70a)
// cseg ...... 0x3b06 + 0x27c04 (0x2b70a)
// imports ... 895 (offset: 0x2efc2)
// animtree1 . 0   (offset: 0x3d2ca)
// animtree2 . 0   (offset: 0x3d2ca)
#using script_16ea1b94f0f381b3;
#using script_61b40095fd0502f0;
#using script_ac28d65e8605696;
#using scripts\anim\dialogue;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\equipment\mini_sentry;
#using scripts\mp\common\equipment\smart_seeker;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\perks\zombie\perk_w_mod;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_equipment;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_boss_fight;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_garage;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\weapons\zm_blackhole_bomb;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_laststand;
#using scripts\mp\zm\systems\zm_livingworld;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zombie_intel;

#namespace zm_sat_firefly_script_mq;

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x5
// Checksum 0x58826f0f, Offset: 0x3b24
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"firefly_mq", undefined, undefined, &init );
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xba2a99ed, Offset: 0x3b45
// Size: 0x399
function init()
{
    if ( !getdvarint( @"enable_firefly_mq", 0 ) )
    {
        return;
    }
    
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "scriptables_ready" );
    level.var_43b55da90a0f5550 = 0;
    level._effect[ "wonder_tme_cascade" ] = loadfxasset( "vfx_sat_levels_zm_firefly_vehicle_tme" );
    level._effect[ "wonder_tme_impact" ] = loadfxasset( "vfx_sat_zm_firefly_mq_tme_impact_energy_flow" );
    level._effect[ #"mq_zombie_killed" ] = loadfxasset( "vfx_sat_firefly_mq_soul_charge_spawn" );
    level._effect[ #"mq_zombie_trail" ] = loadfxasset( "vfx_sat_firefly_mq_soul_charge_trail" );
    level._effect[ #"mq_zombie_impact" ] = loadfxasset( "vfx_sat_firefly_mq_soul_charge_impact" );
    level._effect[ #"hash_db0d31f13e310e89" ] = loadfxasset( "vfx_sat_firefly_mq_step4_energy_ball_hit_zmb_amb_red" );
    level._effect[ #"hash_d996e9d98fc2f639" ] = loadfxasset( "vfx_sat_firefly_mq_step4_energy_ball_hit_zmb_amb_yellow" );
    level._effect[ #"hash_3007ebff4fd3bba5" ] = loadfxasset( "vfx_sat_firefly_mq_step4_energy_ball_hit_zmb_amb_purple" );
    level._effect[ #"hash_2010770aae6fae9a" ] = loadfxasset( "vfx_sat_firefly_mq_clock_tower_amb" );
    level._effect[ #"rog_smoke" ] = loadfxasset( "vfx_sat_firefly_mq_film_canister_spawn" );
    level._effect[ #"clock_m_fx" ] = loadfxasset( "vfx_sat_firefly_mq_clock_tower_minute_hand" );
    level._effect[ #"hash_701a58b956f014c9" ] = loadfxasset( "vfx_sat_firefly_mq_clock_tower_hour_hand" );
    level._effect[ #"waitress_tme" ] = loadfxasset( "vfx_sat_firefly_mq_step4_energy_ball_purple" );
    level._effect[ #"trucker_tme" ] = loadfxasset( "vfx_sat_firefly_mq_step4_energy_ball_red" );
    level._effect[ #"mechanic_tme" ] = loadfxasset( "vfx_sat_firefly_mq_step4_energy_ball_yellow" );
    level._effect[ #"body_splash" ] = loadfxasset( "vfx_sat_zm_barn_corpse_blood_splash_ch" );
    level.firefly_main_quest = zm_quest::get_quest( #"firefly_mq" );
    level.var_cb3e9b3259348f7b = zm_quest::get_quest( #"sat_zm_quest_firefly_ui" );
    level.var_cef21da19561e27d = zm_quest::get_quest_relaxed( #"firefly_mq_guidance" );
    level function_d8c0e7a66df3b01e();
    level callback::add( #"on_ai_killed", &function_c75abda0166d9fb6 );
    utility::registersharedfunc( #"zm_barnacle", #"hash_78226dc4738cf984", &function_482c4b414e61ac0d );
    level callback::add( "quest_item_used", &quest_item_used );
    scene::add_scene_func( "sat_cin_zm_fly_mid", &function_1fe986547a94d74b, "callback_play" );
    scene::add_scene_func( "sat_cin_zm_fly_mid", &function_3000fc7fba7d2d2f, "callback_skipped" );
    scene::add_scene_func( "sat_cin_zm_fly_outro", &function_4e3e29730a919174, "callback_play" );
    scene::add_scene_func( "sat_cin_zm_fly_outro", &function_f9d1c4fa910f3012, "callback_skipped" );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"play_mid_igc", &function_e887612c6448b280 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"play_end_igc", &function_75a4dbd4ca1223b1 );
    level.ingredients_added = [];
    level.firefly_main_quest.correct_ingredients = [];
    level.firefly_main_quest.var_f728ac4d2490fb1c = [];
    zm_quest::function_3c363613c60958f5( "progressing_mq_special_event" );
    zm_quest::function_3c363613c60958f5( "start_final_step_vote" );
    level utility::flag_wait( "quest_guidance_default_on_checked" );
    function_54aa93a060ca40a5();
    
    /#
        level thread init_mq_debug();
    #/
    
    function_4538a76986ae6c9e();
    function_a12788a5d7bb54d8();
    w_mod_force_target();
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xaa76766f, Offset: 0x3ee6
// Size: 0x300
function function_d8c0e7a66df3b01e()
{
    zm_quest::register_quest_step( #"firefly_mq", #"hash_538a8384c86ac974", &jar_pickup, &jar_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"grow_mushrooms", &function_611701ff48bce945, &spore_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_538a8684c86ace8d", &function_e3bbab30079a9c0b, &mirror_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_538a8584c86accda", &setup_burnbody, &function_df0d2d9e8ad4a4f9 );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_538a8084c86ac45b", &barnacle_setup, &barnacle_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_538a7f84c86ac2a8", &eye_setup, &eye_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_538a8284c86ac7c1", &tentacle_setup, &tentacle_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_8e15f8805ec569f2", &serum_setup, &serum_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"serum_trial", &function_c423ec878b8fcdd1, &serum_trial_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_ff159ae12616b58", &function_1f4dc49f3eab262d, &function_d13abee79adac4cc );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_ff15cae12617071", &function_3209fcf4f31c5af8, &function_6a6f60c6ec15b281 );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_ff15bae12616ebe", &function_f198d05300e33fdb, &function_bc14ca2f37907a9e );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_6862143d688fc459", &function_c8bd0c6defb6468c, &function_7701206bc1c2001d );
    zm_quest::register_quest_step( #"firefly_mq", #"complete_rituals", &complete_rituals_setup, &complete_rituals_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_dbc50456c0a63765", &function_201d089e46387d58, &function_f7b69f547a581ee1 );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_4c25b1fbd9b6e496", &function_c5932954de2b5cf7, &function_dd99a71e4a101282 );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_42ce0ef6b3f2cf17", undefined, &function_7a1543589492469e );
    zm_quest::register_quest_step( #"firefly_mq", #"shoot_antennas", &function_35b389162ffda45c, &function_485887b4007e47ad );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_2af4ef56ae3ec77a", &function_90af5b0ee9979fb1, &function_195835814d3f5928 );
    zm_quest::register_quest_step( #"firefly_mq", #"hash_fdfd900907cdfa82", &rog_setup, &rog_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"tme_collection", &tme_collection_setup, &tme_collection_cleanup );
    zm_quest::register_quest_step( #"firefly_mq", #"quest_complete", &quest_complete_setup, &quest_complete_cleanup );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xed5534e7, Offset: 0x41ee
// Size: 0x36
function private function_4538a76986ae6c9e()
{
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"firefly_mq" );
    level utility::flag_wait( "firefly_ww_quest_items_inited" );
    level utility::delaythread( 2, &function_51f12524c830dd09 );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xa7107d62, Offset: 0x422c
// Size: 0x1c7f
function private function_54aa93a060ca40a5()
{
    level endon( #"game_ended" );
    level._effect[ "jump_scare" ] = loadfxasset( "vfx_sat_levels_zm_firefly_jump_scare_camera" );
    level val::group_register( "fmq_last_step", [ "vehicle_use", "vehicle_lean_out", "vehicle_seat_switch", "vehicle_exit", "allow_scripted_bgb_use", "gesture", "killstreaks", "allow_movement", "show_hud", "ignoreme", "damage" ] );
    [ level.firefly_main_quest.vol_head ] = getnoentvolumearray( "fh_trigger", #targetname );
    [ level.firefly_main_quest.vol_clock ] = getnoentvolumearray( "exit_trigger", #targetname );
    level.firefly_main_quest.var_392c3ce0059fd032 = utility::getstruct( "h_m", "targetname" );
    level.firefly_main_quest.s_m_jar = utility::getstruct( "m_j", "targetname" );
    level.firefly_main_quest.chem_beaker = getentitylessscriptablearray( "sn_cf", "script_noteworthy" )[ 0 ];
    var_b709ae6422bb0468 = level zm_sat_firefly::function_24006873400b7a8() ? "ping" : "off";
    level.firefly_main_quest.chem_beaker setscriptablepartstate( "ping", var_b709ae6422bb0468 );
    level.firefly_main_quest.chem_reaction = utility::getstruct( "c_v", "targetname" );
    level.s_smoke = utility::getstruct( "fog_org", "targetname" );
    level.smoke_sbl = spawnscriptable( %"sat_zm_firefly_mq_serum_smoke", level.s_smoke.origin, level.s_smoke.angles );
    level.firefly_main_quest.s_mirror_forgotten = utility::getstruct( "s_mm", "targetname" );
    level.firefly_main_quest.var_e956823444b5d959 = utility::getstruct( "s_i_p", "targetname" );
    level.firefly_main_quest.var_e956823444b5d959.group_number = 1;
    level.firefly_main_quest.var_96459405e9c48efe = utility::getstruct( "s_i_b", "targetname" );
    level.firefly_main_quest.var_96459405e9c48efe.group_number = 2;
    level.firefly_main_quest.var_c4295853d4e96d62 = utility::getstruct( "s_i_s", "targetname" );
    level.firefly_main_quest.var_c4295853d4e96d62.group_number = 3;
    level.firefly_main_quest.var_edf8c0a089c490a = utility::getstruct( "s_i_m", "targetname" );
    level.firefly_main_quest.var_edf8c0a089c490a.group_number = 4;
    level.firefly_main_quest.var_c71b94d062f0f1c5 = utility::getstruct( "s_i_e", "targetname" );
    level.firefly_main_quest.var_c71b94d062f0f1c5.group_number = 5;
    level.firefly_main_quest.var_773fef53052846e = utility::getstruct( "s_i_t", "targetname" );
    level.firefly_main_quest.var_773fef53052846e.group_number = 6;
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        var_49b7463c492b97e6 = utility::getstructarray( "dop_s", "targetname" );
        level.var_e0e8d3ab378dbd31 = [];
        
        foreach ( index, struct in var_49b7463c492b97e6 )
        {
            level.var_2a087706ef762745[ index ] = spawnscriptable( "zm_sat_quest_firefly_mq_skulls", struct.origin, struct.angles );
            level.var_e0e8d3ab378dbd31[ level.var_e0e8d3ab378dbd31.size ] = level.var_2a087706ef762745[ index ];
        }
        
        level scriptable::scriptable_adddamagedcallback( &skulls_hit );
        level.var_a68cf60101f6a416 = [];
    }
    
    level.var_8154c2dac95df4a4 = [ level.firefly_main_quest.var_e956823444b5d959, level.firefly_main_quest.var_96459405e9c48efe, level.firefly_main_quest.var_c4295853d4e96d62, level.firefly_main_quest.var_edf8c0a089c490a, level.firefly_main_quest.var_c71b94d062f0f1c5, level.firefly_main_quest.var_773fef53052846e ];
    level.firefly_main_quest.var_c2f7dd8f78271a53 = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_edf8c0a089c490a.origin, level.firefly_main_quest.var_edf8c0a089c490a.angles );
    level.firefly_main_quest.var_e86add5779f1c9a7 = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_773fef53052846e.origin, level.firefly_main_quest.var_773fef53052846e.angles );
    level.firefly_main_quest.var_d237f33508ae28a0 = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_c71b94d062f0f1c5.origin, level.firefly_main_quest.var_c71b94d062f0f1c5.angles );
    level.firefly_main_quest.var_a168dcd3281dfa3 = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_c4295853d4e96d62.origin, level.firefly_main_quest.var_c4295853d4e96d62.angles );
    level.firefly_main_quest.var_213ecf0609a7a87b = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_96459405e9c48efe.origin, level.firefly_main_quest.var_96459405e9c48efe.angles );
    level.firefly_main_quest.var_dbe4e393f3780b94 = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_e956823444b5d959.origin, level.firefly_main_quest.var_e956823444b5d959.angles );
    level.firefly_main_quest.var_91224a5f16bb3ae3 = utility::getstruct( "f_he", "targetname" );
    level.var_209ed49971299121 = utility::getstruct( "e_b", "targetname" );
    level.firefly_main_quest.var_ad5af114c1477c08 = getentitylessscriptablearray( "s_sc", "script_noteworthy" )[ 0 ];
    level.firefly_main_quest.var_ad5af114c1477c08 setscriptablepartstate( "anim", "closed" );
    level.s_rm_register = utility::getstruct( "rm_r", "targetname" );
    level.var_a3bc59cde59aca90 = utility::getstruct( "exit_ch_1", "targetname" );
    level.var_a3bc5ccde59ad129 = utility::getstruct( "exit_ch_2", "targetname" );
    level.var_78e35765e675008 = utility::getstruct( "exit_c_1", "targetname" );
    level.var_78e38765e6756a1 = utility::getstruct( "exit_c_2", "targetname" );
    level.firefly_main_quest.var_9569ed39e1646d45 = utility::spawn_model( %"c_sat_zmb_corpse_vandorn_skull_fxanim", level.firefly_main_quest.var_91224a5f16bb3ae3.origin, level.firefly_main_quest.var_91224a5f16bb3ae3.angles );
    level.var_b906ace19dc3790e = utility::getstruct( "s_bd", "targetname" );
    s_table_center_farm = utility::getstruct( "table_center_farm", "targetname" );
    level.firefly_main_quest.var_898dc8ebeafff41c = s_table_center_farm.origin;
    level.firefly_main_quest.var_813b6deca0effcd2 = s_table_center_farm.angles;
    level.firefly_main_quest.var_77bb8e15d0471db0 = utility::getstruct( "s_rt_loc_1", "targetname" );
    level.firefly_main_quest.var_77bb9115d0472449 = utility::getstruct( "s_rt_loc_2", "targetname" );
    level.firefly_main_quest.var_77bb9015d0472216 = utility::getstruct( "s_rt_loc_3", "targetname" );
    level.firefly_main_quest.var_77bb9315d04728af = utility::getstruct( "s_rt_loc_4", "targetname" );
    level.firefly_main_quest.var_de842018558c1466 = utility::getstruct( "s_rt_r_loc_1", "targetname" );
    level.firefly_main_quest.var_de841f18558c1233 = utility::getstruct( "s_rt_r_loc_2", "targetname" );
    level.firefly_main_quest.var_de841e18558c1000 = utility::getstruct( "s_rt_r_loc_3", "targetname" );
    level.firefly_main_quest.var_de842518558c1f65 = utility::getstruct( "s_rt_r_loc_4", "targetname" );
    level.firefly_main_quest.var_8ea62fe2d1fa6b96 = utility::getstruct( "fc_12_s", "targetname" );
    level.firefly_main_quest.var_8ea62fe2d1fa6b96.sbl = spawnscriptable( "sat_zm_firefly_mq_farm_numerals", level.firefly_main_quest.var_8ea62fe2d1fa6b96.origin, level.firefly_main_quest.var_8ea62fe2d1fa6b96.angles );
    level.firefly_main_quest.var_87fb79466d80bdb8 = utility::getstruct( "fc_9_s", "targetname" );
    level.firefly_main_quest.var_87fb79466d80bdb8.sbl = spawnscriptable( "sat_zm_firefly_mq_farm_numerals", level.firefly_main_quest.var_87fb79466d80bdb8.origin, level.firefly_main_quest.var_87fb79466d80bdb8.angles );
    level.firefly_main_quest.var_87fb79466d80bdb8.sbl setscriptablepartstate( "time", "nine" );
    level.firefly_main_quest.var_87fb73466d80b086 = utility::getstruct( "fc_3_s", "targetname" );
    level.firefly_main_quest.var_87fb73466d80b086.sbl = spawnscriptable( "sat_zm_firefly_mq_farm_numerals", level.firefly_main_quest.var_87fb73466d80b086.origin, level.firefly_main_quest.var_87fb73466d80b086.angles );
    level.firefly_main_quest.var_87fb73466d80b086.sbl setscriptablepartstate( "time", "three" );
    level.firefly_main_quest.var_53f5aa5e19ca282e = utility::getstruct( "mq_rm_trucker", "script_noteworthy" );
    level.firefly_main_quest.var_282fdcfedaebd2c8 = utility::getstruct( "mq_rm_mechanic", "script_noteworthy" );
    level.firefly_main_quest.var_a35c0e09a86a04ec = utility::getstruct( "mq_rm_waitress", "script_noteworthy" );
    level.firefly_main_quest.var_a35c0e09a86a04ec callback::add( "sat_cin_zm_living_world_slumped_over_firefly_waitress_idle", &function_e7d384d24c7e626b );
    level.firefly_main_quest.var_a35c0e09a86a04ec callback::add( "sat_cin_zm_living_world_slumped_over_firefly_waitress_post_play", &function_e7d384d24c7e626b, level._effect[ #"hash_3007ebff4fd3bba5" ] );
    level.firefly_main_quest.var_282fdcfedaebd2c8 callback::add( "sat_cin_zm_living_world_slumped_over_firefly_mechanic_idle", &function_e7d384d24c7e626b );
    level.firefly_main_quest.var_282fdcfedaebd2c8 callback::add( "sat_cin_zm_living_world_slumped_over_firefly_mechanic_post_play", &function_e7d384d24c7e626b, level._effect[ #"hash_d996e9d98fc2f639" ] );
    level.firefly_main_quest.var_53f5aa5e19ca282e callback::add( "sat_cin_zm_living_world_slumped_over_firefly_trucker_idle", &function_e7d384d24c7e626b );
    level.firefly_main_quest.var_53f5aa5e19ca282e callback::add( "sat_cin_zm_living_world_slumped_over_firefly_trucker_post_play", &function_e7d384d24c7e626b, level._effect[ #"hash_db0d31f13e310e89" ] );
    [ level.firefly_main_quest.vol_projector ] = getnoentvolumearray( "fmq_p_trigger", #targetname );
    var_55cde62fd4d69429 = utility::getstruct( "lf_p", "targetname" );
    s_projection = utility::getstruct( "fmq_p", "targetname" );
    s_projection.sbl = spawnscriptable( %"sat_zm_firefly_mq_projections_reactive", s_projection.origin, s_projection.angles );
    s_projection.projection_order = arrayrandomize( [ 1, 2, 3, 4 ] );
    level.firefly_main_quest.s_projection = s_projection;
    var_1d4bf0e83d76a347 = getentitylessscriptablearray( "fmq_pr", #targetname );
    level.firefly_main_quest.var_1d4bf0e83d76a347 = [];
    
    for ( order_index = 0; order_index < level.firefly_main_quest.s_projection.projection_order.size ; order_index++ )
    {
        for ( var_90d8b1e817301bff = 0; var_90d8b1e817301bff < var_1d4bf0e83d76a347.size ; var_90d8b1e817301bff++ )
        {
            var_ae09d76a4daa0b7a = var_1d4bf0e83d76a347[ var_90d8b1e817301bff ];
            
            if ( int( var_ae09d76a4daa0b7a.script_noteworthy ) != level.firefly_main_quest.s_projection.projection_order[ order_index ] )
            {
                continue;
            }
            
            var_ae09d76a4daa0b7a.sbl = var_ae09d76a4daa0b7a;
            
            if ( int( var_ae09d76a4daa0b7a.script_noteworthy ) == 1 )
            {
                var_ae09d76a4daa0b7a.trig = getnoentvolumearray( "fmq_reel1_trigger", #targetname )[ 0 ];
            }
            
            level.firefly_main_quest.var_1d4bf0e83d76a347[ level.firefly_main_quest.var_1d4bf0e83d76a347.size ] = var_ae09d76a4daa0b7a;
            break;
        }
    }
    
    level.firefly_main_quest.var_766a71b8f84c0a8c = utility::getstruct( "tag_align_europa_retrievable", "targetname" );
    level.firefly_main_quest.var_766a71b8f84c0a8c thread scene::play( undefined, "open", "sat_cin_zm_death_whistle_box" );
    whistle = level.firefly_main_quest.var_766a71b8f84c0a8c scene::get_entity( "Prop 2" );
    whistle hide();
    level.firefly_main_quest.var_766a71b8f84c0a8c.var_249bac45f5f72d5 = whistle.origin;
    level.firefly_main_quest.var_766a71b8f84c0a8c.var_a9bfdc3a96f3557 = whistle.angles;
    waitframe();
    level.firefly_main_quest.var_766a71b8f84c0a8c thread scene::play( undefined, "closed" );
    level.firefly_main_quest.var_7e11f868ba59df86 = utility::getstruct( "fmq_e_t", "targetname" );
    level.firefly_main_quest.var_7e11f868ba59df86.interact = zm_quest::function_91f9590e98d57ff6( level.firefly_main_quest.var_7e11f868ba59df86.origin + ( 0, 0, 45 ), &function_7c5fcba23816ef10, &tme_collection_europa_hint );
    level.firefly_main_quest.var_7e11f868ba59df86.interact.myparent = level.firefly_main_quest.var_7e11f868ba59df86;
    level scriptable::scriptable_addnotifycallback( "tme_collected", &function_9532d621d831bd5b );
    var_7e01db039fe66e7c = utility::getstruct( "fmq_v_s_finale", "targetname" );
    level.firefly_main_quest.var_d5e159ea1469e1e2 = [];
    s_veh_spline = var_7e01db039fe66e7c;
    
    for ( ;; )
    {
        if ( !s_veh_spline.target )
        {
            break;
        }
        
        s_veh_spline = utility::getstruct( s_veh_spline.target, "targetname" );
        level.firefly_main_quest.var_d5e159ea1469e1e2[ level.firefly_main_quest.var_d5e159ea1469e1e2.size ] = s_veh_spline;
    }
    
    level.firefly_main_quest.mirror_forgotten = spawnscriptable( %"zm_sat_firefly_mq_mirror", level.firefly_main_quest.s_mirror_forgotten.origin, level.firefly_main_quest.s_mirror_forgotten.angles );
    level.firefly_main_quest.m_jar = spawnscriptable( %"zm_sat_firefly_mq_jar", level.firefly_main_quest.s_m_jar.origin, level.firefly_main_quest.s_m_jar.angles );
    jar_ping_state = level zm_sat_firefly::function_24006873400b7a8() ? "jar_ping" : "jar";
    level.firefly_main_quest.m_jar setscriptablepartstate( "model", jar_ping_state );
    level.firefly_main_quest.horse_growth = spawnscriptable( %"zm_sat_firefly_mushroom_growing", level.firefly_main_quest.var_392c3ce0059fd032.origin, level.firefly_main_quest.var_392c3ce0059fd032.angles );
    level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "model", "unbroken" );
    level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "vfx", "unaffected" );
    level.firefly_main_quest.var_8274c2ac910347cb = spawnscriptable( %"zm_sat_firefly_mq_register", level.s_rm_register.origin, level.s_rm_register.angles );
    level.firefly_main_quest.var_8274c2ac910347cb setscriptablepartstate( "exit_register_model", "closed" );
    level.firefly_main_quest.rm_register = utility::spawn_model( %"sat_zm_cash_register", level.s_rm_register.origin, level.s_rm_register.angles );
    var_c54b6f5cfd8f4c46 = level zm_sat_firefly::function_24006873400b7a8() ? "ping" : "off";
    level.firefly_main_quest.var_38e00b8a244cfd9e = spawnscriptable( %"zm_sat_firefly_mq_clock", level.var_78e35765e675008.origin, level.var_78e35765e675008.angles );
    level.firefly_main_quest.var_38e00b8a244cfd9e setscriptablepartstate( "model", "on" );
    level.firefly_main_quest.var_38e00b8a244cfd9e setscriptablepartstate( "ping", var_c54b6f5cfd8f4c46 );
    level.firefly_main_quest.var_38e00a8a244cfb6b = spawnscriptable( %"zm_sat_firefly_mq_clock", level.var_78e38765e6756a1.origin, level.var_78e38765e6756a1.angles );
    level.firefly_main_quest.var_38e00a8a244cfb6b setscriptablepartstate( "model", "on" );
    level.firefly_main_quest.var_38e00a8a244cfb6b setscriptablepartstate( "ping", var_c54b6f5cfd8f4c46 );
    level.projector_mdl = spawnscriptable( %"sat_zm_firefly_mq_projector_mdl", var_55cde62fd4d69429.origin, var_55cde62fd4d69429.angles );
    var_8b4efa586e69595 = level zm_sat_firefly::function_24006873400b7a8() ? "ping" : "off";
    level.projector_mdl setscriptablepartstate( "ping", var_8b4efa586e69595 );
    level.firefly_main_quest.a_antennas = [];
    a_s_antenna = utility::getstructarray( "m_a_q", "targetname" );
    
    foreach ( index, struct in a_s_antenna )
    {
        var_bc006453d24e4625 = spawnscriptable( %"zm_sat_firefly_mq_at", struct.origin, struct.angles );
        var_46a927aabd533f7c = level zm_sat_firefly::function_24006873400b7a8() ? "default_ping" : "default";
        var_bc006453d24e4625 setscriptablepartstate( "body", var_46a927aabd533f7c );
        var_bc006453d24e4625.bullet_clip = getent( "ant_clip_" + struct.script_noteworthy, #targetname );
        level.firefly_main_quest.a_antennas[ int( struct.script_noteworthy ) ] = var_bc006453d24e4625;
        var_bc006453d24e4625.index_num = int( struct.script_noteworthy );
    }
    
    s_rocket = utility::getstruct( "grom_r", "targetname" );
    level.firefly_main_quest.sbl_rocket = spawnscriptable( %"zm_sat_firefly_mq_ro", s_rocket.origin, s_rocket.angles );
    s_rocket_clamp_left = utility::getstruct( "ro_cl_le", "targetname" );
    level.firefly_main_quest.var_6d8315922e18d6ea = spawnscriptable( %"zm_sat_firefly_mq_clamp_left", s_rocket_clamp_left.origin, s_rocket_clamp_left.angles );
    s_rocket_clamp_right = utility::getstruct( "ro_cl_ri", "targetname" );
    level.firefly_main_quest.var_495811384d1534d7 = spawnscriptable( %"zm_sat_firefly_mq_clamp_right", s_rocket_clamp_right.origin, s_rocket_clamp_right.angles );
    var_4d2c976ed9934707 = level zm_sat_firefly::function_24006873400b7a8() ? "ping" : "off";
    level.firefly_main_quest.var_3df89a9ad0d870d9 = [];
    var_dc7eaad691c8d97f = utility::getstructarray( "rob_mon_y", "targetname" );
    
    foreach ( struct in var_dc7eaad691c8d97f )
    {
        n_place = int( struct.script_noteworthy );
        level.firefly_main_quest.var_3df89a9ad0d870d9[ n_place ] = spawnscriptable( %"zm_sat_firefly_mq_rob_mon", struct.origin, struct.angles );
        level.firefly_main_quest.var_3df89a9ad0d870d9[ n_place ] setscriptablepartstate( "ping", var_4d2c976ed9934707 );
    }
    
    level.firefly_main_quest.var_bbf63f26705e4e9 = [];
    level.firefly_main_quest.var_3a88947d03fceef9 = [];
    a_s_monitors = utility::getstructarray( "rob_mon", "targetname" );
    
    foreach ( struct in a_s_monitors )
    {
        monitor_num = int( struct.script_noteworthy );
        level.firefly_main_quest.var_bbf63f26705e4e9[ monitor_num ] = spawnscriptable( %"zm_sat_firefly_mq_rob_mon", struct.origin, struct.angles );
        level.firefly_main_quest.var_bbf63f26705e4e9[ monitor_num ] setscriptablepartstate( "ping", var_4d2c976ed9934707 );
        temp = utility::spawn_model( %"sat_zm_possible_code_monitor_fxanim", struct.origin, struct.angles );
        waitframe();
        level.firefly_main_quest.var_3a88947d03fceef9[ monitor_num ] = spawnscriptable( %"zm_sat_firefly_mq_rob_circle", temp gettagorigin( "tag_button" ), temp gettagangles( "tag_button" ) );
        temp delete();
    }
    
    level.var_848b75f3ddd1cdd2 = utility::spawn_model( %"sat_zm_decor_clock_pointer_minute", level.var_a3bc59cde59aca90.origin, level.var_a3bc59cde59aca90.angles );
    level.var_848b74f3ddd1cb9f = utility::spawn_model( %"sat_zm_decor_clock_pointer_minute", level.var_a3bc5ccde59ad129.origin, level.var_a3bc5ccde59ad129.angles );
    level.firefly_main_quest.serum_clip = getent( "lt_c", #targetname );
    
    if ( isdefined( level.firefly_main_quest.serum_clip ) )
    {
        level.firefly_main_quest.serum_clip connectpaths();
        level.firefly_main_quest.serum_clip notsolid();
    }
    
    level.firefly_main_quest.box_clip = getent( "eb_c", #targetname );
    
    if ( isdefined( level.firefly_main_quest.box_clip ) )
    {
        level.firefly_main_quest.box_clip connectpaths();
        level.firefly_main_quest.box_clip notsolid();
    }
    
    level thread function_5d29179388ed50ca();
    level thread function_352a34fb85a0e198();
    level.ingredients_collected = [];
    setup_molotov();
    level utility::flag_set( "mq_asset_setup_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x7ad7a876, Offset: 0x5eb3
// Size: 0xac
function private function_5d29179388ed50ca()
{
    level utility::flag_wait( "begin_round_logic" );
    
    foreach ( perk_machine in level.a_s_perk_machines )
    {
        if ( perk_machine.script_noteworthy == "specialty_w_mod" )
        {
            level.firefly_main_quest.perk_machine = perk_machine;
            break;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x2d3f4137, Offset: 0x5f67
// Size: 0x95
function private function_18683c611198a2c8( link_spawn_pos = ( 0, 0, 0 ), link_spawn_ang = ( 0, 0, 0 ) )
{
    var_2e45e938bae052b6 = utility::spawn_model( "tag_origin", link_spawn_pos, link_spawn_ang );
    self.tme_sbl = spawnscriptable( %"sat_zm_firefly_mq_veh_tme", var_2e45e938bae052b6.origin, var_2e45e938bae052b6.angles );
    self.tme_sbl utility::scriptable_setparententity( var_2e45e938bae052b6 );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x13a382b5, Offset: 0x6004
// Size: 0x23
function private function_3c32fca6ecb44c2f( var_8582cc5f29b6732c )
{
    if ( level utility::flag( "MQ_STEP_1_SUBPART_M1" ) )
    {
        level thread function_bdad6e9285b3fc1d();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x76dd9351, Offset: 0x602f
// Size: 0x278
function private quest_item_used( params )
{
    itembundle = params.bundle;
    item = params.scriptable;
    player = params.player;
    
    switch ( item.type )
    {
        case #"hash_409f080e29389020":
            item thread function_f87bc8cc60b9a111( player );
            level.ingredients_collected[ level.ingredients_collected.size ] = item;
            break;
        case #"hash_3b498bd7bb196bc3":
            item thread function_b68825dab16677a( player );
            level.ingredients_collected[ level.ingredients_collected.size ] = item;
            break;
        case #"hash_3681311644776d55":
            item thread function_7a65c9f84c8b398e( player );
            level.ingredients_collected[ level.ingredients_collected.size ] = item;
            break;
        case #"hash_fd89a35b8def1910":
            item thread function_5851d5b6d04b2099( player );
            level.ingredients_collected[ level.ingredients_collected.size ] = item;
            break;
        case #"hash_fc31bd1cbe985a1":
            item thread function_32389e6e5a3bfe0d( player );
            level.ingredients_collected[ level.ingredients_collected.size ] = item;
            break;
        case #"hash_5e02d08425ff347c":
            item thread function_232bed5e748ff73d( player );
            level.ingredients_collected[ level.ingredients_collected.size ] = item;
            break;
        case #"hash_9cdbafae6cb53df3":
            level thread function_68498104ae35531c( player );
            break;
        case #"hash_9cdbb0ae6cb53f86":
            level thread function_c29a993db8cb8975( player );
            break;
        case #"hash_9cdbb1ae6cb54119":
            level thread function_1dbbcfc24a1187ca( player );
            break;
        case #"hash_f94751773b0aa5e6":
            item thread function_a7c97c1f5482a147( player );
            break;
        case #"hash_f94750773b0aa453":
            item thread function_834050021a3b54a2( player );
            break;
        case #"hash_f9474f773b0aa2c0":
            item thread function_cd839ef2d57e8d2d( player );
            break;
        case #"hash_f94756773b0aadc5":
            item thread function_41350fde921f6048( player );
            break;
    }
    
    if ( level.ingredients_collected.size == 6 && !level utility::flag( "ind_vo_played" ) )
    {
        player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"final_ingredient", #"bc_flavor_player_positive" );
        level utility::flag_set( "ind_vo_played" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xa912ade0, Offset: 0x62af
// Size: 0x4d7
function private function_a12788a5d7bb54d8()
{
    level.firefly_main_quest.farm_clock_save = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"fc_save" ) ?? 0;
    s_farm_clock = utility::getstruct( "f_c", "targetname" );
    a_s_farm_clock = utility::getstructarray( "fc_trigger", "targetname" );
    
    if ( level.firefly_main_quest.farm_clock_save > 0 )
    {
        for ( i = 0; i < 3 ; i++ )
        {
            farm_clock_state = utility::get_bit_flag( level.firefly_main_quest.farm_clock_save, i + 1 );
            
            if ( farm_clock_state )
            {
                switch ( i )
                {
                    case 0:
                        level.farm_clock_trigger = utility::getstruct( "12_ct", "script_noteworthy" );
                        farm_clock_hand = spawnscriptable( %"sat_zm_firefly_mq_farm_clock", s_farm_clock.origin, s_farm_clock.angles );
                        farm_clock_hand setscriptablepartstate( "time", "twelve" );
                        level.var_1a21ca402bc88876 = ( 0, 17, 0 );
                        return;
                    case 1:
                        level.farm_clock_trigger = utility::getstruct( "3_ct", "script_noteworthy" );
                        farm_clock_hand = spawnscriptable( %"sat_zm_firefly_mq_farm_clock", s_farm_clock.origin, s_farm_clock.angles );
                        farm_clock_hand setscriptablepartstate( "time", "three" );
                        level.var_1a21ca402bc88876 = ( 0, 6, 0 );
                        return;
                    case 2:
                        level.farm_clock_trigger = utility::getstruct( "9_ct", "script_noteworthy" );
                        farm_clock_hand = spawnscriptable( %"sat_zm_firefly_mq_farm_clock", s_farm_clock.origin, s_farm_clock.angles );
                        farm_clock_hand setscriptablepartstate( "time", "nine" );
                        level.var_1a21ca402bc88876 = ( 0, -6, 0 );
                        return;
                }
            }
        }
    }
    
    a_s_farm_clock = arrayrandomize( a_s_farm_clock );
    level.farm_clock_trigger = a_s_farm_clock[ 0 ];
    
    switch ( level.farm_clock_trigger.script_noteworthy )
    {
        case #"hash_642ff52d85f7f2d0":
            farm_clock_hand = spawnscriptable( %"sat_zm_firefly_mq_farm_clock", s_farm_clock.origin, s_farm_clock.angles );
            farm_clock_hand setscriptablepartstate( "time", "twelve" );
            level.var_1a21ca402bc88876 = ( 0, 17, 0 );
            level.firefly_main_quest.farm_clock_save = utility::set_bit_flag( level.firefly_main_quest.farm_clock_save, 1 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"fc_save", level.firefly_main_quest.farm_clock_save );
            break;
        case #"hash_4922b803af5a0308":
            farm_clock_hand = spawnscriptable( %"sat_zm_firefly_mq_farm_clock", s_farm_clock.origin, s_farm_clock.angles );
            farm_clock_hand setscriptablepartstate( "time", "three" );
            level.var_1a21ca402bc88876 = ( 0, 6, 0 );
            level.firefly_main_quest.farm_clock_save = utility::set_bit_flag( level.firefly_main_quest.farm_clock_save, 2 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"fc_save", level.firefly_main_quest.farm_clock_save );
            break;
        case #"hash_dfec6c27fd386926":
            farm_clock_hand = spawnscriptable( %"sat_zm_firefly_mq_farm_clock", s_farm_clock.origin, s_farm_clock.angles );
            farm_clock_hand setscriptablepartstate( "time", "nine" );
            level.var_1a21ca402bc88876 = ( 0, -6, 0 );
            level.firefly_main_quest.farm_clock_save = utility::set_bit_flag( level.firefly_main_quest.farm_clock_save, 3 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"fc_save", level.firefly_main_quest.farm_clock_save );
            break;
        default:
            break;
    }
    
    ping_state = level zm_sat_firefly::function_24006873400b7a8() ? "ping" : "off";
    farm_clock_hand setscriptablepartstate( "ping", ping_state );
    level.firefly_main_quest.farm_clock = farm_clock_hand;
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x54c1c126, Offset: 0x678e
// Size: 0x5a
function setup_molotov()
{
    level utility::flag_wait( "begin_round_logic" );
    s_loc_molotov = utility::getstruct( "g_molotov", "targetname" );
    molotov = zm_quest::spawn_quest_item( s_loc_molotov.origin, s_loc_molotov.angles, %"itemspawnentry:zm_sat_item_molotov" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x2048b5fc, Offset: 0x67f0
// Size: 0x3b3
function private function_e3bbab30079a9c0b( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "MQ_STEP_1_SUBPART_R1" );
        level utility::flag_set( "MQ_STEP_1_SUBPART_R2" );
        
        if ( level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_85406ac6c81c5f3c" ) == 1 )
        {
            level utility::flag_set( "p_added_serum" );
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "p_added" );
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_beaker", "white" );
            level thread function_991aa7091b8e1fae();
            level thread function_ca68bd64abad6fc3();
            return;
        }
    }
    
    level.firefly_main_quest.mirror_trigger_volume = getent( "m_t", "targetname" );
    
    if ( level zm_sat_firefly::function_24006873400b7a8() )
    {
        if ( !callback::exists( "w_mod_spawned", &function_246a92a331765064 ) )
        {
            level callback::add( "w_mod_spawned", &function_246a92a331765064 );
        }
        
        if ( !callback::exists( "w_mod_despawned", &wisp_death ) )
        {
            level callback::add( "w_mod_despawned", &wisp_death );
        }
        
        level.wisps_active = 0;
    }
    
    level.var_5210abf80e6182b = [];
    
    if ( isdefined( level.firefly_main_quest.mirror_trigger_volume ) )
    {
        level.firefly_main_quest.mirror_trigger_volume thread function_809c851f00d3bdf7( self );
    }
    
    level.firefly_main_quest.var_ca72b603e1c12fc1 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_ingr" ) ?? 0;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level.m_reflect = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 12 );
        level.m_broken = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 13 );
        
        if ( level.m_reflect )
        {
            level utility::flag_set( "MQ_STEP_1_SUBPART_R1" );
            level.var_43b55da90a0f5550 = 1;
            level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "vfx", "glass_appear" );
            level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "model", "unbroken" );
            level scriptable::scriptable_adddamagedcallback( &mirror_broke );
            wait 2;
            
            if ( isdefined( level.firefly_main_quest.mirror_trigger_volume ) )
            {
                level.firefly_main_quest.mirror_trigger_volume delete();
            }
        }
        
        if ( level.m_broken )
        {
            level utility::flag_set( "MQ_STEP_1_SUBPART_R2" );
            level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "model", "dead" );
            level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "vfx", "off" );
            level.firefly_main_quest.Powder = zm_quest::spawn_quest_item( level.firefly_main_quest.s_mirror_forgotten.origin + ( 10, 40, 0 ), level.firefly_main_quest.s_mirror_forgotten.angles, %"hash_47e5b4fef1665c" );
            level.firefly_main_quest.Powder.disable_dragged = 1;
            level utility::delaythread( 2, &function_51f12524c830dd09 );
            level scriptable::function_dc174fecebb79952( &mirror_broke );
        }
    }
    
    level utility::flag_wait( "p_lab_spawned" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xa7be0581, Offset: 0x6bab
// Size: 0x9f
function private function_809c851f00d3bdf7( instance )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        is_player = isplayer( ent );
        
        if ( is_player )
        {
            player = ent;
            
            if ( !isalive( player ) )
            {
                continue;
            }
            else if ( !arraycontains( level.var_5210abf80e6182b, player ) )
            {
                level.var_5210abf80e6182b[ level.var_5210abf80e6182b.size ] = player;
                player thread function_a1a5f3be894d50bf( self );
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x4d03962d, Offset: 0x6c52
// Size: 0x72
function private function_a1a5f3be894d50bf( trigger )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self istouching( trigger ) && !level utility::flag( "MQ_STEP_1_SUBPART_R1" ) )
        {
            self dodamage( 1, self.origin, self, undefined, "MOD_TRIGGER_HURT" );
            wait 1;
        }
        else
        {
            level.var_5210abf80e6182b = arrayremove( level.var_5210abf80e6182b, self );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0xff2530f7, Offset: 0x6ccc
// Size: 0x58
function function_246a92a331765064( params )
{
    player = params.owner;
    wisp = params.wisp;
    player.wisp_active = 1;
    level.wisps_active++;
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x56c561bc, Offset: 0x6d2c
// Size: 0xc0
function wisp_death( params )
{
    player = params.owner;
    
    if ( isplayer( player ) )
    {
        player.wisp_active = 0;
        level.wisps_active--;
    }
    
    foreach ( player in level.players )
    {
        if ( player.wisp_active )
        {
            return;
        }
    }
    
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xaa3f45bd, Offset: 0x6df4
// Size: 0x2da
function private w_mod_force_target()
{
    level endon( #"game_ended" );
    
    if ( !level utility::flag( "MQ_STEP_1_SUBPART_R1" ) )
    {
        var_ed92d3edd3eded9 = utility::getstruct( "s_mm", "targetname" );
        var_ed92d3edd3eded9.origin += ( 0, 10, 40 );
        level.firefly_main_quest.player_has_w_mod = 0;
        
        while ( var_ed92d3edd3eded9 )
        {
            players = getplayersinradius( var_ed92d3edd3eded9.origin, 400 );
            
            foreach ( player in players )
            {
                if ( isplayer( player ) )
                {
                    if ( player.var_4fd5ac47a9bd8c18 )
                    {
                        player.var_4302849bdb60a0ea = 1;
                    }
                }
            }
            
            player_has_w_mod = 0;
            
            foreach ( player in level.players )
            {
                if ( isplayer( player ) )
                {
                    if ( player zombie_perks::has_perk( "specialty_w_mod" ) )
                    {
                        player_has_w_mod = 1;
                    }
                }
            }
            
            if ( level zm_sat_firefly::function_24006873400b7a8() && level.firefly_main_quest.player_has_w_mod != player_has_w_mod )
            {
                level.firefly_main_quest.player_has_w_mod = player_has_w_mod;
                level thread function_51f12524c830dd09();
            }
            
            level.firefly_main_quest.player_has_w_mod = player_has_w_mod;
            
            if ( level utility::flag( "doorbuy_sunken_shops_bought" ) )
            {
                foreach ( player in level.players )
                {
                    if ( isplayer( player ) )
                    {
                        if ( player.var_4302849bdb60a0ea && level.var_43b55da90a0f5550 == 0 )
                        {
                            player utility::callsharedfunc( #"w_mod", #"hash_f5a9afab08f0dcea", var_ed92d3edd3eded9 );
                            level.var_43b55da90a0f5550 = 1;
                            function_6a9305a34d1e9512( player, var_ed92d3edd3eded9 );
                        }
                    }
                }
            }
            
            wait 1;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xd138947e, Offset: 0x70d6
// Size: 0x1e8
function private function_6a9305a34d1e9512( player, var_ed92d3edd3eded9 )
{
    if ( isdefined( player.var_4fd5ac47a9bd8c18 ) )
    {
        player.var_4fd5ac47a9bd8c18.var_21c148796dcc185f = 0;
        playsoundatpos( level.firefly_main_quest.mirror_forgotten.origin, "evt_mq_stp1_mirror_reform_leadup" );
        wait 2;
        playsoundatpos( level.firefly_main_quest.mirror_forgotten.origin, "evt_mq_stp1_mirror_reform" );
        level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "vfx", "wisp_spawn" );
        
        if ( player.var_4fd5ac47a9bd8c18 )
        {
            player.var_4fd5ac47a9bd8c18 perk_w_mod::delete_wisp( player );
        }
        
        level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "vfx", "glass_appear" );
        level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "model", "unbroken" );
        level utility::flag_set( "MQ_STEP_1_SUBPART_R1" );
        level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 12 );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
        level thread function_51f12524c830dd09();
        level scriptable::scriptable_adddamagedcallback( &mirror_broke );
        wait 2;
        
        if ( isdefined( level.firefly_main_quest.mirror_trigger_volume ) )
        {
            level.firefly_main_quest.mirror_trigger_volume delete();
        }
        
        level callback::remove( "w_mod_spawned", &function_246a92a331765064 );
        level callback::remove( "w_mod_despawned", &wisp_death );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 11, eflags: 0x4
// Checksum 0x4e1e0f90, Offset: 0x72c6
// Size: 0x287
function private mirror_broke( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "zm_sat_firefly_mq_mirror" )
    {
        return;
    }
    
    if ( instance.type == "zm_sat_firefly_mq_mirror" )
    {
        if ( isplayer( eattacker ) && objweapon.basename == "sat_ww_firefly_zm" )
        {
            if ( isdefined( level.firefly_main_quest.mirror_forgotten ) && !level utility::flag( "MQ_STEP_1_SUBPART_R2" ) )
            {
                player = eattacker;
                level utility::flag_set( "MQ_STEP_1_SUBPART_R2" );
                level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 13 );
                level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
                level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "vfx", "broken" );
                player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"break_mirror", #"bc_flavor_player_positive" );
                wait 1;
                level.firefly_main_quest.Powder = common_item::function_47324f290423b2d1( %"hash_47e5b4fef1665c", level.firefly_main_quest.mirror_forgotten.origin + ( 0, 40, 35 ), level.firefly_main_quest.mirror_forgotten.origin + ( 10, 40, 0 ), undefined, 1 );
                level.firefly_main_quest.Powder.disable_dragged = 1;
                level thread function_51f12524c830dd09();
                wait 2;
                level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "model", "dead" );
                level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "vfx", "off" );
                level scriptable::function_dc174fecebb79952( &mirror_broke );
            }
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xeba06972, Offset: 0x7555
// Size: 0xcf
function private mirror_cleanup( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "p_lab_spawned" );
        level utility::flag_set( "MQ_STEP_1_SUBPART_R1" );
        level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "model", "dead" );
        level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "vfx", "broken" );
        
        if ( isdefined( level.firefly_main_quest.mirror_trigger_volume ) )
        {
            level.firefly_main_quest.mirror_trigger_volume delete();
        }
        
        level scriptable::function_dc174fecebb79952( &mirror_broke );
        function_b68825dab16677a();
        return;
    }
    
    level utility::flag_wait( "p_lab_spawned" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0xfc9fb259, Offset: 0x762c
// Size: 0x1cf
function barnacle_setup( b_skipped, b_save_restored )
{
    level.firefly_main_quest.var_ca72b603e1c12fc1 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_ingr" ) ?? 0;
    
    if ( b_skipped || b_save_restored )
    {
        shell_grabbed = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 7 );
        
        if ( shell_grabbed )
        {
            level.firefly_main_quest.lab_shell = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_c4295853d4e96d62.origin, level.firefly_main_quest.var_c4295853d4e96d62.angles );
            level.firefly_main_quest.lab_shell setscriptablepartstate( "ingredients", "shell" );
            level.firefly_main_quest.lab_shell.code = "1";
            zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_s", 1 );
            level utility::flag_set( "s_lab_spawned" );
            level thread function_edfe1e42d13cda3d( level.firefly_main_quest.lab_shell.code );
        }
        
        utility::registersharedfunc( #"zm_barnacle", #"hash_78226dc4738cf984", undefined );
        level utility::flag_set( "s_complete" );
        return;
    }
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level thread function_f15611e6c4001511();
    }
    
    utility::registersharedfunc( #"zm_barnacle", #"hash_78226dc4738cf984", &function_482c4b414e61ac0d );
    level utility::flag_wait( "s_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xcbbd852b, Offset: 0x7803
// Size: 0xb3
function private function_f15611e6c4001511()
{
    level endon( #"game_ended" );
    step = zm_quest::get_quest_step( #"firefly_mq", #"hash_538a8084c86ac45b" );
    step endon( #"hash_2c4eefaf7e2b24b6" );
    level utility::flag_wait( "mq_asset_setup_complete" );
    level utility::flag_wait( "zm_barnacle_init_complete" );
    
    if ( level.var_bb5b506ca2aa7e9c > 8 )
    {
        level utility::registersharedfunc( #"zm_barnacle", #"hash_78226dc4738cf984", undefined );
        function_5851d5b6d04b2099();
        level.ingredients_collected[ level.ingredients_collected.size ] = level.firefly_main_quest.shell_ingr;
        return;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xbe109d70, Offset: 0x78be
// Size: 0x37
function function_482c4b414e61ac0d()
{
    if ( !level callback::exists( "spawn_barnacle_grown_loot", &function_a48f3721a2791fb0 ) )
    {
        level callback::add( "spawn_barnacle_grown_loot", &function_a48f3721a2791fb0 );
    }
    
    return [ %"hash_35f23685b7adb6dd" ];
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x7fe52f24, Offset: 0x78fe
// Size: 0x1e2
function private function_a48f3721a2791fb0( sparams )
{
    waitframe();
    
    if ( !sparams.itemsspawned || sparams.itemsspawned.size < 1 )
    {
        return;
    }
    
    shell_ingr = undefined;
    
    foreach ( item in sparams.itemsspawned )
    {
        if ( isarray( item ) || item.type != "zmloot_quest_firefly_shell" )
        {
            continue;
        }
        
        shell_ingr = item;
        shell_ingr thread quest_item_cleanup( "shell_cleanup" );
        break;
    }
    
    if ( !shell_ingr )
    {
        return;
    }
    
    level.firefly_main_quest.shell_ingr = shell_ingr;
    level utility::delaythread( 2, &function_51f12524c830dd09 );
    level.firefly_main_quest.shell_ingr waittill( #"death" );
    
    if ( level.firefly_main_quest.shell_ingr.pickedup )
    {
        level utility::registersharedfunc( #"zm_barnacle", #"hash_78226dc4738cf984", undefined );
        return;
    }
    else if ( level.var_bb5b506ca2aa7e9c > 8 )
    {
        level utility::registersharedfunc( #"zm_barnacle", #"hash_78226dc4738cf984", undefined );
        function_5851d5b6d04b2099();
        level.ingredients_collected[ level.ingredients_collected.size ] = level.firefly_main_quest.shell_ingr;
        return;
    }
    
    level.firefly_main_quest.shell_ingr = undefined;
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xaacf2f59, Offset: 0x7ae8
// Size: 0x55
function private barnacle_cleanup( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        utility::registersharedfunc( #"zm_barnacle", #"hash_78226dc4738cf984", undefined );
        level utility::flag_set( "s_complete" );
        return;
    }
    
    level utility::flag_wait( "s_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x77f430ed, Offset: 0x7b45
// Size: 0x209
function private setup_burnbody( b_skipped, b_save_restored )
{
    s_barn_body = utility::getstruct( "bb_hang", "targetname" );
    mdl_burnbody = utility::spawn_model( %"sat_zm_firefly_farm_barn_body_hanging_01_c_fxsim", s_barn_body.origin, s_barn_body.angles );
    mdl_burnbody scriptmodelplayanim( "sat_zm_firefly_farm_barn_body_hanging_01_c_fxsim", undefined, 0 );
    mdl_burnbody playloopsound( #"hash_4e5badfc2af392d4" );
    level.var_b7eb11317e933e5c = utility::spawn_model( "c_sat_zmb_corpse_charred_male_foot", s_barn_body.origin, s_barn_body.origin );
    level.var_b7eb11317e933e5c linkto( mdl_burnbody, "tag_foot_ri", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    wait 1;
    level.var_b7eb11317e933e5c thread burn_body_watcher( mdl_burnbody );
    
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "b_complete" );
        return;
    }
    
    level.firefly_main_quest.var_ca72b603e1c12fc1 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_ingr" ) ?? 0;
    bone_burned = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 14 );
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        if ( bone_burned )
        {
            if ( level.var_b7eb11317e933e5c )
            {
                level.var_b7eb11317e933e5c delete();
            }
            
            spawnoptions = common_item::function_bc5ff2958b71a708( level.var_b906ace19dc3790e.origin, level.var_b906ace19dc3790e.angles );
            spawnoptions.var_fd47e835523b473f = 1;
            spawnoptions.critical = 1;
            level.firefly_main_quest.bone = common_item::function_61c2c0251e742ffd( %"hash_2d7a2814706e5570", undefined, spawnoptions );
            return;
        }
    }
    
    level utility::flag_wait( "b_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xdd148ad6, Offset: 0x7d56
// Size: 0x223
function private burn_body_watcher( mdl_burnbody )
{
    val::set( "burn_body", "damage", 1 );
    self.health = 9999;
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid );
        
        if ( isplayer( eattacker ) && einflictor.weapon_name == "sat_combataxe_zm" && !level utility::flag( "MQ_STEP_1_SUBPART_L1" ) )
        {
            player = eattacker;
            s_burn_body_top = utility::getstruct( "s_bd_t", "targetname" );
            var_785acaa0fd74c8f = utility::getstruct( "s_bd_m", "targetname" );
            self unlink();
            playfxontag( level._effect[ #"body_splash" ], mdl_burnbody, "tag_foot_ri" );
            utility::function_8001268940441423( s_burn_body_top.origin, level.var_b906ace19dc3790e.origin, var_785acaa0fd74c8f.origin, 0.75, undefined, 1 );
            self delete();
            level.burn_foot = spawnscriptable( "sat_zm_firefly_foot", level.var_b906ace19dc3790e.origin, level.var_b906ace19dc3790e.angles );
            player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"break_leg", #"bc_flavor_player_positive" );
            level scriptable::scriptable_adddamagedcallback( &function_5ac4691f98a1e240 );
            level utility::flag_set( "MQ_STEP_1_SUBPART_L1" );
            level thread function_51f12524c830dd09();
            waitframe();
            break;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 11, eflags: 0x4
// Checksum 0xd4194271, Offset: 0x7f81
// Size: 0x1d8
function private function_5ac4691f98a1e240( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "sat_zm_firefly_foot" )
    {
        return;
    }
    
    if ( isplayer( eattacker ) && einflictor.weapon_name == "sat_molotov_zm" )
    {
        scriptable::function_dc174fecebb79952( &function_5ac4691f98a1e240 );
        level.burn_foot setscriptablepartstate( "material", "burned" );
        wait 2;
        
        if ( level.burn_foot )
        {
            level.burn_foot freescriptable();
            spawnoptions = common_item::function_bc5ff2958b71a708( level.var_b906ace19dc3790e.origin, level.var_b906ace19dc3790e.angles );
            spawnoptions.var_fd47e835523b473f = 1;
            spawnoptions.critical = 1;
            level.firefly_main_quest.bone = common_item::function_61c2c0251e742ffd( %"hash_2d7a2814706e5570", undefined, spawnoptions );
            level.firefly_main_quest.bone.disable_dragged = 1;
            level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 14 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
            level thread function_51f12524c830dd09();
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x2e7a1c4f, Offset: 0x8161
// Size: 0x1a0
function private function_df0d2d9e8ad4a4f9( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.firefly_main_quest.var_ca72b603e1c12fc1 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_ingr" ) ?? 0;
        bone_grabbed = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 8 );
        
        if ( bone_grabbed )
        {
            level.firefly_main_quest.lab_bone = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_96459405e9c48efe.origin, level.firefly_main_quest.var_96459405e9c48efe.angles );
            level.firefly_main_quest.lab_bone setscriptablepartstate( "ingredients", "bones" );
            level.firefly_main_quest.lab_bone.code = "5";
            zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_b", 1 );
            
            if ( level.var_b7eb11317e933e5c )
            {
                level.var_b7eb11317e933e5c delete();
            }
            
            level utility::flag_set( "b_lab_spawned" );
            level thread function_edfe1e42d13cda3d( level.firefly_main_quest.lab_bone.code );
        }
        
        level utility::flag_set( "b_complete" );
        return;
    }
    
    level utility::flag_wait( "b_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x3b77bb60, Offset: 0x8309
// Size: 0x196
function private jar_pickup( b_skipped, b_save_restored )
{
    level.firefly_main_quest.var_ca72b603e1c12fc1 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_ingr" ) ?? 0;
    level.jar_collected = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 1 );
    
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "MQ_STEP_1_SUBPART_M2" );
        return;
    }
    
    level.firefly_main_quest.var_ca72b603e1c12fc1 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_ingr" ) ?? 0;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level.jar_collected = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 1 );
        
        if ( level.jar_collected )
        {
            zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_m", 1 );
            waitframe();
            
            if ( isdefined( level.firefly_main_quest.m_jar ) )
            {
                level.firefly_main_quest.m_jar freescriptable();
            }
            
            level utility::flag_set( "MQ_STEP_1_SUBPART_M2" );
            return;
        }
    }
    
    level.firefly_main_quest.var_c867e8cb15921f6b = zm_quest::function_91f9590e98d57ff6( level.firefly_main_quest.m_jar.origin, &jar_pickedup, undefined, "extrasmallnohint" );
    level utility::flag_wait( "MQ_STEP_1_SUBPART_M2" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xd5acbef, Offset: 0x84a7
// Size: 0x12e
function private jar_pickedup( player )
{
    level utility::flag_set( "MQ_STEP_1_SUBPART_M2" );
    playsoundatpos( level.firefly_main_quest.m_jar.origin, #"hash_d22b44905f8d08d1" );
    level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive" );
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_m", 1 );
    zm_quest::show_splash_item_picked_up( #"ingred", #"ingredient_m", 1, player );
    level.firefly_main_quest.m_jar setscriptablepartstate( "model", "invisible" );
    level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 1 );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
    level.firefly_main_quest.var_c867e8cb15921f6b freescriptable();
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x39564246, Offset: 0x85dd
// Size: 0xc0
function private jar_cleanup( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( level.jar_collected )
        {
            zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_m", 1 );
            
            if ( isdefined( level.firefly_main_quest.m_jar ) )
            {
                level.firefly_main_quest.m_jar freescriptable();
            }
        }
        
        if ( level.firefly_main_quest.var_c867e8cb15921f6b )
        {
            level.firefly_main_quest.var_c867e8cb15921f6b freescriptable();
        }
        
        level utility::flag_set( "MQ_STEP_1_SUBPART_M2" );
        return;
    }
    
    level utility::flag_wait( "MQ_STEP_1_SUBPART_M2" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xaacd53a6, Offset: 0x86a5
// Size: 0x67c
function private function_611701ff48bce945( b_skipped, b_save_restored )
{
    level.firefly_main_quest.var_ca72b603e1c12fc1 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_ingr" ) ?? 0;
    
    if ( b_skipped || b_save_restored )
    {
        if ( b_skipped && !b_save_restored )
        {
            level thread function_cde7c93464ef1421();
            return;
        }
        
        mush_grabbed = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 6 );
        
        if ( mush_grabbed )
        {
            level.firefly_main_quest.lab_mushroom = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_edf8c0a089c490a.origin, level.firefly_main_quest.var_edf8c0a089c490a.angles );
            level.firefly_main_quest.lab_mushroom setscriptablepartstate( "ingredients", "mushroom" );
            level.firefly_main_quest.lab_mushroom.code = "2";
            zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_m", 2 );
            level utility::flag_set( "m_lab_spawned" );
            level utility::flag_set( "m_complete" );
            
            if ( isdefined( level.firefly_main_quest.horse_growth ) )
            {
                level.firefly_main_quest.horse_growth setscriptablepartstate( "growth", "off" );
            }
            
            level thread function_edfe1e42d13cda3d( level.firefly_main_quest.lab_mushroom.code );
            level callback::remove( "on_round_end", &function_3c32fca6ecb44c2f );
            return;
        }
    }
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level utility::flag_set( "MQ_STEP_1_SUBPART_M2" );
        mush_particle = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 2 );
        mush_sml = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 3 );
        mush_med = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 4 );
        mush_lrg = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 5 );
        
        if ( mush_lrg )
        {
            if ( isdefined( level.firefly_main_quest.horse_growth ) )
            {
                level utility::flag_set( "MQ_STEP_1_SUBPART_M1" );
                level.firefly_main_quest.horse_growth setscriptablepartstate( "vfx", "g_interval_lrg" );
                level.firefly_main_quest.horse_growth setscriptablepartstate( "growth", "stage_3" );
                item_bundle = getscriptbundle( %"hash_40ddc97d7537866b" );
                spawnoptions = common_item::function_bc5ff2958b71a708( level.firefly_main_quest.var_392c3ce0059fd032.origin + ( 0, 0, -2 ) );
                spawnoptions.var_fd47e835523b473f = 1;
                spawnoptions.critical = 1;
                level.firefly_main_quest.mushroom_ingredient = common_item::function_61c2c0251e742ffd( item_bundle, undefined, spawnoptions );
                level.firefly_main_quest.mushroom_ingredient.disable_dragged = 1;
                level utility::flag_set( "m_ready" );
                level thread function_51f12524c830dd09();
                level callback::remove( "on_round_end", &function_3c32fca6ecb44c2f );
                
                if ( isdefined( level.firefly_main_quest.horse_growth ) )
                {
                    level.firefly_main_quest.horse_growth freescriptable();
                }
            }
            
            level utility::flag_set( "m_complete" );
            return;
        }
        
        if ( mush_med )
        {
            if ( isdefined( level.firefly_main_quest.horse_growth ) )
            {
                level utility::flag_set( "MQ_STEP_1_SUBPART_M1" );
                level.firefly_main_quest.horse_growth setscriptablepartstate( "vfx", "g_interval_med" );
                level.firefly_main_quest.horse_growth setscriptablepartstate( "growth", "stage_2" );
                level.growth_interval = 2;
                level callback::add( "on_round_end", &function_3c32fca6ecb44c2f );
            }
            
            return;
        }
        
        if ( mush_sml )
        {
            if ( isdefined( level.firefly_main_quest.horse_growth ) )
            {
                level utility::flag_set( "MQ_STEP_1_SUBPART_M1" );
                level.firefly_main_quest.horse_growth setscriptablepartstate( "vfx", "g_interval_sml" );
                level.firefly_main_quest.horse_growth setscriptablepartstate( "growth", "stage_1" );
                level.growth_interval = 1;
                level callback::add( "on_round_end", &function_3c32fca6ecb44c2f );
            }
            
            return;
        }
        
        if ( mush_particle )
        {
            if ( isdefined( level.firefly_main_quest.horse_growth ) )
            {
                level utility::flag_set( "MQ_STEP_1_SUBPART_M1" );
                level.firefly_main_quest.horse_growth setscriptablepartstate( "vfx", "g_interval_sml" );
                level.firefly_main_quest.horse_growth setscriptablepartstate( "growth", "stage_0" );
                level.growth_interval = 0;
                level callback::add( "on_round_end", &function_3c32fca6ecb44c2f );
            }
            
            return;
        }
    }
    
    if ( level utility::flag( "MQ_STEP_1_SUBPART_M2" ) )
    {
        level.firefly_main_quest.var_392c3ce0059fd032.interaction = spawnscriptable( %"zm_sat_firefly_h_interact", level.firefly_main_quest.var_392c3ce0059fd032.origin, level.firefly_main_quest.var_392c3ce0059fd032.angles );
        level.firefly_main_quest.var_392c3ce0059fd032.interaction setscriptablepartstate( "h_g_interact", "on_hidden" );
        level.firefly_main_quest.var_392c3ce0059fd032.interaction scriptable::scriptable_addusedcallbackbypart( "h_g_interact", &spore_dropoff );
    }
    
    level utility::flag_wait( "m_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 6, eflags: 0x4
// Checksum 0xdff62859, Offset: 0x8d29
// Size: 0x15f
function private spore_dropoff( instance, part, state, user, bautouse, usestring )
{
    level.firefly_main_quest.var_392c3ce0059fd032.interaction setscriptablepartstate( "h_g_interact", "off" );
    level utility::flag_set( "MQ_STEP_1_SUBPART_M1" );
    
    if ( level.firefly_main_quest.horse_growth )
    {
        level.firefly_main_quest.horse_growth setscriptablepartstate( "vfx", "g_interval_sml" );
        level.firefly_main_quest.horse_growth setscriptablepartstate( "growth", "stage_0" );
    }
    
    level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 2 );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
    level.growth_interval = 0;
    level thread battlechatter_mp::trysaylocalsound( user, #"bc_flavor_player_positive" );
    level thread function_51f12524c830dd09();
    level callback::add( "on_round_end", &function_3c32fca6ecb44c2f );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x43e02309, Offset: 0x8e90
// Size: 0x339
function private function_bdad6e9285b3fc1d()
{
    level endon( #"game_ended" );
    level.growth_interval++;
    
    if ( isdefined( level.firefly_main_quest.horse_growth ) )
    {
        if ( level.growth_interval == 1 )
        {
            level.firefly_main_quest.horse_growth setscriptablepartstate( "vfx", "g_interval_sml" );
            level.firefly_main_quest.horse_growth setscriptablepartstate( "growth", "stage_1" );
            level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 3 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
            return;
        }
        
        if ( level.growth_interval == 2 )
        {
            level.firefly_main_quest.horse_growth setscriptablepartstate( "vfx", "g_interval_med" );
            level.firefly_main_quest.horse_growth setscriptablepartstate( "growth", "stage_2" );
            level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 4 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
            return;
        }
        
        if ( level.growth_interval == 3 )
        {
            level.firefly_main_quest.horse_growth setscriptablepartstate( "vfx", "g_interval_lrg" );
            level.firefly_main_quest.horse_growth setscriptablepartstate( "growth", "stage_3" );
            level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 5 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
            item_bundle = getscriptbundle( %"hash_40ddc97d7537866b" );
            spawnoptions = common_item::function_bc5ff2958b71a708( level.firefly_main_quest.var_392c3ce0059fd032.origin + ( 0, 0, -2 ) );
            spawnoptions.var_fd47e835523b473f = 1;
            spawnoptions.critical = 1;
            spawnoptions.disable_dragged = 1;
            level.firefly_main_quest.mushroom_ingredient = common_item::function_61c2c0251e742ffd( item_bundle, undefined, spawnoptions );
            level utility::flag_set( "m_ready" );
            level thread function_51f12524c830dd09();
            level callback::remove( "on_round_end", &function_3c32fca6ecb44c2f );
            
            if ( isdefined( level.firefly_main_quest.horse_growth ) )
            {
                level.firefly_main_quest.horse_growth freescriptable();
            }
            
            return;
        }
        
        return;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x474a23a6, Offset: 0x91d1
// Size: 0x34
function private spore_cleanup( b_skipped, b_save_restored )
{
    level utility::flag_wait( "m_complete" );
    level callback::remove( "on_round_end", &function_3c32fca6ecb44c2f );
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0xb1472fd5, Offset: 0x920d
// Size: 0x186
function eye_setup( b_skipped, b_save_restored )
{
    level.firefly_main_quest.var_ca72b603e1c12fc1 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_ingr" ) ?? 0;
    
    if ( b_skipped || b_save_restored )
    {
        eye_grabbed = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 9 );
        
        if ( eye_grabbed )
        {
            level.firefly_main_quest.lab_eye = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_c71b94d062f0f1c5.origin, level.firefly_main_quest.var_c71b94d062f0f1c5.angles );
            level.firefly_main_quest.lab_eye setscriptablepartstate( "ingredients", "eyes" );
            level.firefly_main_quest.lab_eye.code = "4";
            zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_e", 1 );
            level utility::flag_set( "e_lab_spawned" );
            level thread function_edfe1e42d13cda3d( level.firefly_main_quest.lab_eye.code );
        }
        
        level utility::flag_set( "e_complete" );
        return;
    }
    
    level utility::flag_wait( "e_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0x7c5b6f8b, Offset: 0x939b
// Size: 0x249
function tentacle_setup( b_skipped, b_save_restored )
{
    level.firefly_main_quest.var_ca72b603e1c12fc1 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_ingr" ) ?? 0;
    
    if ( b_skipped || b_save_restored )
    {
        tentacle_grabbed = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 10 );
        skulls_hit = utility::get_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 11 );
        
        if ( tentacle_grabbed )
        {
            level.firefly_main_quest.lab_tentacle = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_773fef53052846e.origin, level.firefly_main_quest.var_773fef53052846e.angles );
            level.firefly_main_quest.lab_tentacle setscriptablepartstate( "ingredients", "tentacle" );
            level.firefly_main_quest.lab_tentacle.code = "3";
            zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_t", 1 );
            level scriptable::function_dc174fecebb79952( &skulls_hit );
            level utility::flag_set( "t_lab_spawned" );
            level thread function_edfe1e42d13cda3d( level.firefly_main_quest.lab_tentacle.code );
        }
        
        if ( skulls_hit )
        {
            foreach ( skull in level.var_e0e8d3ab378dbd31 )
            {
                skull setscriptablepartstate( "skull", "on" );
            }
            
            level scriptable::function_dc174fecebb79952( &skulls_hit );
        }
        
        level utility::flag_set( "t_complete" );
        return;
    }
    
    level utility::flag_wait( "t_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 11
// Checksum 0x36f1a915, Offset: 0x95ec
// Size: 0x17b
function skulls_hit( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance getscriptablehaspart( "skull" ) )
    {
        if ( isplayer( eattacker ) && objweapon.basename == "sat_ww_firefly_zm" && !level utility::flag( "MQ_STEP_1_SUBPART_T1" ) && !level utility::flag( "serum_brewed" ) )
        {
            instance setscriptablepartstate( "skull", "on" );
            
            if ( !arraycontains( level.var_a68cf60101f6a416, instance ) )
            {
                level.var_a68cf60101f6a416[ level.var_a68cf60101f6a416.size ] = instance;
            }
            
            level thread function_51f12524c830dd09();
            
            if ( level.var_a68cf60101f6a416.size == 3 )
            {
                level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 11 );
                level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
                level scriptable::function_dc174fecebb79952( &skulls_hit );
                spawn_zursa();
            }
        }
        
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xa03a2b87, Offset: 0x976f
// Size: 0x139
function spawn_zursa()
{
    var_5b7c9a25ad4eff00 = utility::getstructarray( "zone_launchpad_underground", "target" );
    zursa_spawner = var_5b7c9a25ad4eff00[ 1 ];
    round_number = zm_round_logic::get_rb_round_number() + 2;
    
    if ( !level utility::flag( "zursa_spawned" ) )
    {
        level utility::flag_set( "zursa_spawned" );
        zursa = agent_manager::spawn_agent( "zombie_callisto", zursa_spawner.origin, ( 0, 0, 0 ), "team_two_hundred" );
        waitframe();
        
        if ( isdefined( zursa ) )
        {
            zursa utility::function_7c10ea82c1e305b8( "base", "base_purple_eye" );
            zursa.var_16f6f3f5b489a0a2 = 1;
            level.firefly_main_quest.zursa = zursa;
            level thread function_51f12524c830dd09();
            zursa.no_powerups = 1;
            zursa zombie_utils::set_zombie_round_difficulty( round_number );
            zursa.ignore_enemy_count = 1;
            zursa.var_a13bed1ac47e1b2c = 1;
            zursa.disable_brain_rot = 1;
            
            if ( isdefined( zursa_spawner.script_animation ) )
            {
                zursa thread zone_spawner::function_ce10e453e7f7bb8e( zursa_spawner.zone );
            }
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x861e0766, Offset: 0x98b0
// Size: 0x16f
function private function_c75abda0166d9fb6( params )
{
    level endon( #"game_ended" );
    eattacker = params.eattacker;
    smeansofdeath = params.smeansofdeath;
    einflictor = params.einflictor;
    var_bd2c4ac1948d79c6 = params.victim;
    v_drop = self.origin;
    
    if ( isstartstr( self.subclass, "zombie_shade" ) && !level utility::flag( "MQ_STEP_1_SUBPART_S1" ) && !level utility::flag( "e_lab_spawned" ) )
    {
        if ( einflictor.var_fcda7168a743663a == %"saw_blade_trap_switch" )
        {
            thread function_2acfd38b48985c4d( v_drop );
        }
    }
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        if ( isstartstr( self.subclass, "zombie_callisto" ) && !level utility::flag( "MQ_STEP_1_SUBPART_T1" ) && !level utility::flag( "t_lab_spawned" ) )
        {
            if ( eattacker.vehicle.vehiclename == "veh_sat_firefly_pluto" )
            {
                if ( smeansofdeath == "MOD_ELEMENTAL_ELEC" || var_bd2c4ac1948d79c6.var_efc8dd6782b7f37e )
                {
                    level.firefly_main_quest.zursa = undefined;
                    thread function_bddaa527d939e464( v_drop );
                }
            }
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xc0f51486, Offset: 0x9a27
// Size: 0xf0
function private function_2acfd38b48985c4d( position )
{
    level utility::flag_set( "MQ_STEP_1_SUBPART_S1" );
    ground_pos = utility::drop_to_ground( position, 50, 3 );
    level.firefly_main_quest.shade_eye = common_item::function_47324f290423b2d1( %"hash_1e40a8b8a8ad16ae", position, ground_pos, undefined, 1 );
    level.firefly_main_quest.shade_eye thread quest_item_cleanup( "MQ_STEP_1_SUBPART_S1" );
    level utility::delaythread( 2, &function_51f12524c830dd09 );
    level.firefly_main_quest.shade_eye waittill( #"death" );
    
    if ( level.firefly_main_quest.shade_eye.pickedup )
    {
        return;
    }
    
    level.firefly_main_quest.shade_eye = undefined;
    level utility::flag_clear( "MQ_STEP_1_SUBPART_S1" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x7fb6ec90, Offset: 0x9b1f
// Size: 0x48
function private quest_item_cleanup( flag )
{
    level endon( #"e_lab_spawned" );
    level endon( #"t_lab_spawned" );
    level endon( #"s_lab_spawned" );
    wait 60;
    level utility::flag_clear( flag );
    
    if ( isdefined( self ) )
    {
        self freescriptable();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xa2156967, Offset: 0x9b6f
// Size: 0x106
function private function_bddaa527d939e464( position )
{
    level utility::flag_set( "MQ_STEP_1_SUBPART_T1" );
    ground_pos = utility::drop_to_ground( position, 50, 3 );
    level.firefly_main_quest.doppleghast_tentacle = common_item::function_47324f290423b2d1( %"hash_bc2f428d34840bf", position, ground_pos, undefined, 1 );
    level.firefly_main_quest.doppleghast_tentacle thread quest_item_cleanup( "MQ_STEP_1_SUBPART_T1" );
    level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_113b6790782c25b4", 1 );
    level.firefly_main_quest.doppleghast_tentacle waittill( #"death" );
    
    if ( level.firefly_main_quest.doppleghast_tentacle.pickedup )
    {
        return;
    }
    
    level.firefly_main_quest.doppleghast_tentacle = undefined;
    level utility::flag_clear( "MQ_STEP_1_SUBPART_T1" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x203eac78, Offset: 0x9c7d
// Size: 0x3b
function private eye_cleanup( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "e_complete" );
        return;
    }
    
    level utility::flag_wait( "e_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x7a223e04, Offset: 0x9cc0
// Size: 0x3b
function private tentacle_cleanup( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "t_complete" );
        return;
    }
    
    level utility::flag_wait( "t_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x55132357, Offset: 0x9d03
// Size: 0x8b
function private function_edfe1e42d13cda3d( ingredient_code )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "mq_serum_recipe_setup_done" );
    
    if ( level.firefly_main_quest.var_f728ac4d2490fb1c && arraycontains( level.firefly_main_quest.var_f728ac4d2490fb1c, ingredient_code ) )
    {
        level.firefly_main_quest.correct_ingredients[ level.firefly_main_quest.correct_ingredients.size ] = ingredient_code;
        level thread function_51f12524c830dd09();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x379ddd67, Offset: 0x9d96
// Size: 0x3fd
function function_cde7c93464ef1421()
{
    level.firefly_main_quest.lab_mushroom = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_edf8c0a089c490a.origin, level.firefly_main_quest.var_edf8c0a089c490a.angles );
    level.firefly_main_quest.lab_mushroom setscriptablepartstate( "ingredients", "mushroom" );
    level.firefly_main_quest.lab_mushroom.code = "2";
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_m", 2 );
    level utility::flag_set( "m_lab_spawned" );
    level.firefly_main_quest.lab_tentacle = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_773fef53052846e.origin, level.firefly_main_quest.var_773fef53052846e.angles );
    level.firefly_main_quest.lab_tentacle setscriptablepartstate( "ingredients", "tentacle" );
    level.firefly_main_quest.lab_tentacle.code = "3";
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_t", 1 );
    level utility::flag_set( "t_lab_spawned" );
    level.firefly_main_quest.lab_eye = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_c71b94d062f0f1c5.origin, level.firefly_main_quest.var_c71b94d062f0f1c5.angles );
    level.firefly_main_quest.lab_eye setscriptablepartstate( "ingredients", "eyes" );
    level.firefly_main_quest.lab_eye.code = "4";
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_e", 1 );
    level utility::flag_set( "e_lab_spawned" );
    level.firefly_main_quest.lab_bone = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_96459405e9c48efe.origin, level.firefly_main_quest.var_96459405e9c48efe.angles );
    level.firefly_main_quest.lab_bone setscriptablepartstate( "ingredients", "bones" );
    level.firefly_main_quest.lab_bone.code = "5";
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_b", 1 );
    level utility::flag_set( "b_lab_spawned" );
    level.var_b7eb11317e933e5c delete();
    level.firefly_main_quest.lab_shell = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_c4295853d4e96d62.origin, level.firefly_main_quest.var_c4295853d4e96d62.angles );
    level.firefly_main_quest.lab_shell setscriptablepartstate( "ingredients", "shell" );
    level.firefly_main_quest.lab_shell.code = "1";
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_s", 1 );
    level utility::flag_set( "s_lab_spawned" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x48c1e127, Offset: 0xa19b
// Size: 0x146
function private function_949e038e56c0d3f7()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "mq_asset_setup_complete" );
    var_1d889a48d1b26017 = randomint( 10 );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        var_45434e59cfa0dfdb = [ "1" ];
    }
    else
    {
        var_45434e59cfa0dfdb = [ "1", "3" ];
        var_45434e59cfa0dfdb = arrayrandomize( var_45434e59cfa0dfdb, var_1d889a48d1b26017 );
    }
    
    var_f728ac4d2490fb1c = [ "2", "4", "5" ];
    var_f728ac4d2490fb1c = arrayrandomize( var_f728ac4d2490fb1c, var_1d889a48d1b26017 );
    
    for ( var_81b5950436ec2e70 = 0; var_81b5950436ec2e70 < 2 ; var_81b5950436ec2e70++ )
    {
        pp_symbol[ var_81b5950436ec2e70 ] = var_f728ac4d2490fb1c[ var_81b5950436ec2e70 ];
        level.firefly_main_quest.var_f728ac4d2490fb1c[ level.firefly_main_quest.var_f728ac4d2490fb1c.size ] = pp_symbol[ var_81b5950436ec2e70 ];
    }
    
    for ( var_81b5950436ec2e70 = 0; var_81b5950436ec2e70 < 1 ; var_81b5950436ec2e70++ )
    {
        pp_symbol[ var_81b5950436ec2e70 ] = var_45434e59cfa0dfdb[ var_81b5950436ec2e70 ];
        level.firefly_main_quest.var_f728ac4d2490fb1c[ level.firefly_main_quest.var_f728ac4d2490fb1c.size ] = pp_symbol[ var_81b5950436ec2e70 ];
    }
    
    level utility::flag_set( "mq_serum_recipe_setup_done" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x2426b725, Offset: 0xa2e9
// Size: 0x108
function private function_352a34fb85a0e198()
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        if ( level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_85406ac6c81c5f3c" ) == 2 )
        {
            level thread function_510b4d744c82df86();
            level utility::flag_set( "p_added_serum" );
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "serum_fail" );
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_beaker", "black" );
            level thread function_991aa7091b8e1fae();
            level.failed_round = zm_round_logic::get_rb_round_number() - 1;
            level callback::add( "on_round_end", &serum_reset );
            level utility::flag_set( "fmq_serum_cooldown" );
            level thread function_51f12524c830dd09();
            return;
        }
        
        if ( level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_85406ac6c81c5f3c" ) == 1 )
        {
            return;
        }
        
        if ( !level utility::flag( "serum_brewed" ) )
        {
            level thread function_949e038e56c0d3f7();
        }
        
        return;
    }
    
    level thread function_949e038e56c0d3f7();
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0xb4d88123, Offset: 0xa3f9
// Size: 0xb1
function serum_setup( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level thread function_991aa7091b8e1fae();
        
        if ( level.firefly_main_quest.chem_reaction.interact )
        {
            level.firefly_main_quest.chem_reaction.interact freescriptable();
        }
        
        if ( level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_85406ac6c81c5f3c" ) == 3 )
        {
            level utility::flag_set( "p_added_serum" );
            level utility::flag_set( "serum_brewed" );
            return;
        }
    }
    
    level utility::flag_wait( "serum_brewed" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x4c4327d9, Offset: 0xa4b2
// Size: 0x44f
function private function_991aa7091b8e1fae()
{
    level.var_742bd7779adb2b90 = [];
    var_9fc968fd7f780d1a = utility::getstructarray( "s_r", "targetname" );
    model_1 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_code_1" );
    model_2 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_code_2" );
    model_3 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"s_code_3" );
    
    if ( model_1 )
    {
        code_1 = spawnscriptable( "sat_zm_firefly_code", var_9fc968fd7f780d1a[ 0 ].origin, var_9fc968fd7f780d1a[ 0 ].angles );
        code_1 setscriptablepartstate( "model", string( model_1 ) );
        code_1 setscriptablepartstate( "reactive", "on" );
        level.firefly_main_quest.var_f728ac4d2490fb1c[ level.firefly_main_quest.var_f728ac4d2490fb1c.size ] = string( model_1 );
        level.var_742bd7779adb2b90[ level.var_742bd7779adb2b90.size ] = string( model_1 );
        
        if ( model_2 )
        {
            code_2 = spawnscriptable( "sat_zm_firefly_code", var_9fc968fd7f780d1a[ 1 ].origin, var_9fc968fd7f780d1a[ 1 ].angles );
            code_2 setscriptablepartstate( "model", string( model_2 ) );
            code_2 setscriptablepartstate( "reactive", "on" );
            level.firefly_main_quest.var_f728ac4d2490fb1c[ level.firefly_main_quest.var_f728ac4d2490fb1c.size ] = string( model_2 );
            level.var_742bd7779adb2b90[ level.var_742bd7779adb2b90.size ] = string( model_2 );
        }
        
        if ( model_3 )
        {
            code_3 = spawnscriptable( "sat_zm_firefly_code", var_9fc968fd7f780d1a[ 2 ].origin, var_9fc968fd7f780d1a[ 2 ].angles );
            code_3 setscriptablepartstate( "model", string( model_3 ) );
            code_3 setscriptablepartstate( "reactive", "on" );
            level.firefly_main_quest.var_f728ac4d2490fb1c[ level.firefly_main_quest.var_f728ac4d2490fb1c.size ] = string( model_3 );
            level.var_742bd7779adb2b90[ level.var_742bd7779adb2b90.size ] = string( model_3 );
        }
        
        level utility::flag_set( "mq_serum_recipe_setup_done" );
        level thread function_51f12524c830dd09();
        return;
    }
    
    var_1d889a48d1b26017 = randomint( 10 );
    level.firefly_main_quest.var_f728ac4d2490fb1c = arrayrandomize( level.firefly_main_quest.var_f728ac4d2490fb1c, var_1d889a48d1b26017 );
    
    for ( i = 0; i < level.firefly_main_quest.var_f728ac4d2490fb1c.size ; i++ )
    {
        var_11a9cf407be98f21 = var_9fc968fd7f780d1a[ i ];
        var_a8b870c44549360b = level.firefly_main_quest.var_f728ac4d2490fb1c[ i ];
        
        /#
            logstring( "<dev string:x24>" + var_a8b870c44549360b );
            iprintlnbold( "<dev string:x24>" + var_a8b870c44549360b );
        #/
        
        var_11a9cf407be98f21.sbl = spawnscriptable( "sat_zm_firefly_code", var_11a9cf407be98f21.origin, var_11a9cf407be98f21.angles );
        var_11a9cf407be98f21.sbl setscriptablepartstate( "model", var_a8b870c44549360b );
        var_11a9cf407be98f21.sbl setscriptablepartstate( "reactive", "on" );
        level.var_742bd7779adb2b90[ level.var_742bd7779adb2b90.size ] = var_a8b870c44549360b;
    }
    
    if ( level.var_742bd7779adb2b90.size > 0 )
    {
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_code_1", int( level.var_742bd7779adb2b90[ 0 ] ) );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_code_2", int( level.var_742bd7779adb2b90[ 1 ] ) );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_code_3", int( level.var_742bd7779adb2b90[ 2 ] ) );
    }
    
    level utility::flag_set( "mq_serum_recipe_setup_done" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x61b12779, Offset: 0xa909
// Size: 0x43
function private function_510b4d744c82df86()
{
    level utility::flag_set( "b_added_serum" );
    level utility::flag_set( "e_added_serum" );
    level utility::flag_set( "t_added_serum" );
    level utility::flag_set( "s_added_serum" );
    level utility::flag_set( "m_added_serum" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x213493e, Offset: 0xa954
// Size: 0x166
function private function_120b16c5b8c77045( player )
{
    if ( level.ingredients_added.size != level.var_742bd7779adb2b90.size )
    {
        return;
    }
    
    for ( i = 0; i < level.ingredients_added.size ; i++ )
    {
        if ( level.ingredients_added[ i ] == level.var_742bd7779adb2b90[ i ] )
        {
            level utility::flag_set( "ingredient_success" );
            continue;
        }
        
        level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "serum_fail" );
        level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_beaker", "black" );
        level utility::flag_clear( "ingredient_success" );
        serum_failure( player );
        break;
    }
    
    if ( level utility::flag( "ingredient_success" ) )
    {
        level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "bt_start" );
        level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_beaker", "red" );
        level utility::flag_set( "serum_brewed" );
        level thread function_e7409c9d4f1b5143();
        player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_55f0c40cf1c9153a", #"bc_flavor_player_positive" );
        level utility::delaythread( 2, &function_51f12524c830dd09 );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xab11b1ae, Offset: 0xaac2
// Size: 0x91
function private serum_failure( player )
{
    level.failed_round = zm_round_logic::get_rb_round_number() - 1;
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_85406ac6c81c5f3c", 2 );
    player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"serum_fail", #"bc_flavor_player_negative" );
    
    if ( !level callback::exists( "on_round_end", &serum_reset ) )
    {
        level callback::add( "on_round_end", &serum_reset );
    }
    
    level utility::flag_set( "fmq_serum_cooldown" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xb9d89a1f, Offset: 0xab5b
// Size: 0x102
function private serum_reset( params )
{
    level endon( #"game_ended" );
    current_round = zm_round_logic::get_rb_round_number();
    
    if ( current_round >= 999 || level zm_quest::function_b0a5181ebe7bb905() || level.failed_round < current_round )
    {
        level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "failure_end" );
        level.ingredients_added = [];
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_85406ac6c81c5f3c", 1 );
        level utility::flag_clear( "b_added_serum" );
        level utility::flag_clear( "e_added_serum" );
        level utility::flag_clear( "t_added_serum" );
        level utility::flag_clear( "s_added_serum" );
        level utility::flag_clear( "m_added_serum" );
        level callback::remove( "on_round_end", &serum_reset );
        level utility::flag_clear( "fmq_serum_cooldown" );
        level thread function_51f12524c830dd09();
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x3b0feeb9, Offset: 0xac65
// Size: 0x17e
function function_e7409c9d4f1b5143()
{
    if ( level.burn_foot )
    {
        level scriptable::function_dc174fecebb79952( &function_5ac4691f98a1e240 );
        level.burn_foot freescriptable();
    }
    
    if ( level.firefly_main_quest.horse_growth )
    {
        level.firefly_main_quest.horse_growth freescriptable();
    }
    
    if ( level.firefly_main_quest.var_c867e8cb15921f6b )
    {
        level callback::remove( "on_round_end", &function_3c32fca6ecb44c2f );
        level.firefly_main_quest.var_c867e8cb15921f6b freescriptable();
    }
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        level scriptable::function_dc174fecebb79952( &skulls_hit );
        
        foreach ( skull in level.var_e0e8d3ab378dbd31 )
        {
            skull setscriptablepartstate( "skull", "off" );
        }
    }
    
    level utility::flag_set( "MQ_STEP_1_SUBPART_M2" );
    level utility::flag_set( "m_complete" );
    level utility::flag_set( "b_complete" );
    level utility::flag_set( "s_complete" );
    level utility::flag_set( "e_complete" );
    level utility::flag_set( "t_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x7d7ece52, Offset: 0xadeb
// Size: 0x10b
function private serum_cleanup( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "serum_brewed" );
        level callback::remove( #"on_ai_killed", &function_c75abda0166d9fb6 );
        
        if ( isdefined( level.firefly_main_quest.chem_beaker ) )
        {
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "bt_start" );
        }
        else if ( !isdefined( level.firefly_main_quest.chem_beaker ) )
        {
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "bt_start" );
        }
        
        level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_beaker", "red" );
        
        if ( b_save_restored )
        {
            function_e7409c9d4f1b5143();
        }
        
        return;
    }
    
    level utility::flag_wait( "serum_brewed" );
    level callback::remove( #"on_ai_killed", &function_c75abda0166d9fb6 );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x29cb18b4, Offset: 0xaefe
// Size: 0x23e
function private function_f87bc8cc60b9a111( player )
{
    level utility::flag_set( "m_lab_spawned" );
    level utility::flag_set( "m_complete" );
    level.firefly_main_quest.lab_mushroom = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_edf8c0a089c490a.origin, level.firefly_main_quest.var_edf8c0a089c490a.angles );
    level.firefly_main_quest.lab_mushroom setscriptablepartstate( "ingredients", "mushroom" );
    level.firefly_main_quest.lab_mushroom.code = "2";
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_m", 2 );
    zm_quest::show_splash_item_picked_up( #"ingred", #"ingredient_m", 2, player );
    level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 6 );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
    
    if ( isdefined( level.firefly_main_quest.horse_growth ) )
    {
        level.firefly_main_quest.horse_growth setscriptablepartstate( "growth", "off" );
    }
    
    if ( level.firefly_main_quest.var_f728ac4d2490fb1c && arraycontains( level.firefly_main_quest.var_f728ac4d2490fb1c, level.firefly_main_quest.lab_mushroom.code ) )
    {
        level.firefly_main_quest.correct_ingredients[ level.firefly_main_quest.correct_ingredients.size ] = level.firefly_main_quest.lab_mushroom.code;
        level utility::delaythread( 1.5, &function_51f12524c830dd09 );
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x49761d7c, Offset: 0xb144
// Size: 0x218
function private function_232bed5e748ff73d( player )
{
    level utility::flag_set( "t_lab_spawned" );
    level utility::flag_set( "t_complete" );
    level.firefly_main_quest.lab_tentacle = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_773fef53052846e.origin, level.firefly_main_quest.var_773fef53052846e.angles );
    level.firefly_main_quest.lab_tentacle setscriptablepartstate( "ingredients", "tentacle" );
    level.firefly_main_quest.lab_tentacle.code = "3";
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_t", 1 );
    level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 10 );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
    level scriptable::function_dc174fecebb79952( &skulls_hit );
    
    if ( isdefined( player ) )
    {
        zm_quest::show_splash_item_picked_up( #"ingred", #"ingredient_t", 1, player );
    }
    
    if ( level.firefly_main_quest.var_f728ac4d2490fb1c && arraycontains( level.firefly_main_quest.var_f728ac4d2490fb1c, level.firefly_main_quest.lab_tentacle.code ) )
    {
        level.firefly_main_quest.correct_ingredients[ level.firefly_main_quest.correct_ingredients.size ] = level.firefly_main_quest.lab_tentacle.code;
        level utility::delaythread( 1.5, &function_51f12524c830dd09 );
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x444ee22b, Offset: 0xb364
// Size: 0x225
function private function_5851d5b6d04b2099( player )
{
    utility::registersharedfunc( #"zm_barnacle", #"hash_78226dc4738cf984", undefined );
    level utility::flag_set( "s_lab_spawned" );
    level utility::flag_set( "s_complete" );
    level.firefly_main_quest.lab_shell = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_c4295853d4e96d62.origin, level.firefly_main_quest.var_c4295853d4e96d62.angles );
    level.firefly_main_quest.lab_shell setscriptablepartstate( "ingredients", "shell" );
    level.firefly_main_quest.lab_shell.code = "1";
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_s", 1 );
    level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 7 );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
    
    if ( isdefined( player ) )
    {
        zm_quest::show_splash_item_picked_up( #"ingred", #"ingredient_s", 1, player );
    }
    
    if ( level.firefly_main_quest.var_f728ac4d2490fb1c && arraycontains( level.firefly_main_quest.var_f728ac4d2490fb1c, level.firefly_main_quest.lab_shell.code ) )
    {
        level.firefly_main_quest.correct_ingredients[ level.firefly_main_quest.correct_ingredients.size ] = level.firefly_main_quest.lab_shell.code;
        level utility::delaythread( 1.5, &function_51f12524c830dd09 );
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x79831d37, Offset: 0xb591
// Size: 0x220
function private function_b68825dab16677a( player )
{
    level utility::flag_set( "pause_tessie_task_mq" );
    
    if ( isdefined( level.var_8cff5e93e7f5e8 ) && ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"ol_tessie_race" || level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"hash_118650abf6b05f4f" ) )
    {
        level val::set( "task_mq", "task_logic_activate", 0 );
    }
    
    level utility::flag_set( "p_lab_spawned" );
    
    if ( isdefined( player ) )
    {
        player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"pick_up_powder", #"hash_5212ed7ec42f115a" );
        zm_quest::show_splash_item_picked_up( #"ingred", #"ingredient_p", 1, player );
    }
    
    foreach ( other_player in level.players )
    {
        other_player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_firefly_artifact_2" );
    }
    
    level.firefly_main_quest.lab_powder = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_e956823444b5d959.origin, level.firefly_main_quest.var_e956823444b5d959.angles );
    level.firefly_main_quest.lab_powder setscriptablepartstate( "ingredients", "powder" );
    level.firefly_main_quest.mirror_forgotten setscriptablepartstate( "vfx", "off" );
    level thread function_51f12524c830dd09();
    function_ca68bd64abad6fc3();
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_p", 1 );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xc8a3d7ca, Offset: 0xb7b9
// Size: 0x20b
function private function_7a65c9f84c8b398e( player )
{
    level utility::flag_set( "e_lab_spawned" );
    level utility::flag_set( "e_complete" );
    level.firefly_main_quest.lab_eye = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_c71b94d062f0f1c5.origin, level.firefly_main_quest.var_c71b94d062f0f1c5.angles );
    level.firefly_main_quest.lab_eye setscriptablepartstate( "ingredients", "eyes" );
    level.firefly_main_quest.lab_eye.code = "4";
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_e", 1 );
    level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 9 );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
    
    if ( isdefined( player ) )
    {
        zm_quest::show_splash_item_picked_up( #"ingred", #"ingredient_e", 1, player );
    }
    
    if ( level.firefly_main_quest.var_f728ac4d2490fb1c && arraycontains( level.firefly_main_quest.var_f728ac4d2490fb1c, level.firefly_main_quest.lab_eye.code ) )
    {
        level.firefly_main_quest.correct_ingredients[ level.firefly_main_quest.correct_ingredients.size ] = level.firefly_main_quest.lab_eye.code;
        level utility::delaythread( 1.5, &function_51f12524c830dd09 );
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x8c123b66, Offset: 0xb9cc
// Size: 0x20b
function private function_32389e6e5a3bfe0d( player )
{
    level utility::flag_set( "b_lab_spawned" );
    level utility::flag_set( "b_complete" );
    level.firefly_main_quest.lab_bone = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.var_96459405e9c48efe.origin, level.firefly_main_quest.var_96459405e9c48efe.angles );
    level.firefly_main_quest.lab_bone setscriptablepartstate( "ingredients", "bones" );
    level.firefly_main_quest.lab_bone.code = "5";
    zm_quest::function_b57dfe9625966b0b( #"ingred", 0, #"ingredient_b", 1 );
    level.firefly_main_quest.var_ca72b603e1c12fc1 = utility::set_bit_flag( level.firefly_main_quest.var_ca72b603e1c12fc1, 8 );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"s_ingr", level.firefly_main_quest.var_ca72b603e1c12fc1 );
    
    if ( isdefined( player ) )
    {
        zm_quest::show_splash_item_picked_up( #"ingred", #"ingredient_b", 1, player );
    }
    
    if ( level.firefly_main_quest.var_f728ac4d2490fb1c && arraycontains( level.firefly_main_quest.var_f728ac4d2490fb1c, level.firefly_main_quest.lab_bone.code ) )
    {
        level.firefly_main_quest.correct_ingredients[ level.firefly_main_quest.correct_ingredients.size ] = level.firefly_main_quest.lab_bone.code;
        level utility::delaythread( 1.5, &function_51f12524c830dd09 );
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x69c0c64b, Offset: 0xbbdf
// Size: 0x91
function function_ca68bd64abad6fc3()
{
    var_9391e33986a40d4d = anglestoforward( level.firefly_main_quest.chem_reaction.angles );
    var_caab51e0887b0963 = level.firefly_main_quest.chem_reaction.origin + var_9391e33986a40d4d * 10;
    level.firefly_main_quest.chem_reaction.interact = zm_quest::function_91f9590e98d57ff6( var_caab51e0887b0963, &function_f49c4ea9dd53db20, &function_dd29c34a6a5b8888, "medium_anyanglefov" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x4d079bbd, Offset: 0xbc78
// Size: 0x800
function function_f49c4ea9dd53db20( player )
{
    var_30736d696a032221 = cos( 20 );
    playerangles = player getplayerangles();
    playerlookdir = anglestoforward( playerangles );
    player_view = player gettagorigin( "j_head" );
    
    if ( isplayer( player ) && player getcamerathirdperson() )
    {
        player_view = player getcamerathirdpersonorigin();
        var_30736d696a032221 = cos( 80 );
    }
    
    var_391d5698adb08e8f = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_e956823444b5d959.origin - player_view ) );
    var_bf8d12c8712ee14d = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_96459405e9c48efe.origin - player_view ) );
    var_2abe985c549a93d9 = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_c4295853d4e96d62.origin - player_view ) );
    var_50c66d7ae2c3f39d = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_edf8c0a089c490a.origin - player_view ) );
    var_40dec4be6afcf1d = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_773fef53052846e.origin - player_view ) );
    var_9f4beb5769aa4332 = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_c71b94d062f0f1c5.origin - player_view ) );
    
    if ( !level utility::flag( "p_added_serum" ) )
    {
        level.var_8c3ee4a8015df21b = [ var_391d5698adb08e8f, var_bf8d12c8712ee14d, var_2abe985c549a93d9, var_50c66d7ae2c3f39d, var_40dec4be6afcf1d, var_9f4beb5769aa4332 ];
    }
    
    if ( level utility::flag( "p_added_serum" ) )
    {
        level.var_8c3ee4a8015df21b = [ var_bf8d12c8712ee14d, var_2abe985c549a93d9, var_50c66d7ae2c3f39d, var_40dec4be6afcf1d, var_9f4beb5769aa4332 ];
    }
    
    [ var_81ccc78b471bf8f ] = arraysort( level.var_8c3ee4a8015df21b, undefined, &function_b2a78e2ee069be42 );
    
    if ( !level utility::flag( "p_added_serum" ) && var_391d5698adb08e8f > var_30736d696a032221 && var_391d5698adb08e8f >= var_81ccc78b471bf8f )
    {
        level utility::flag_set( "p_added_serum" );
        level.firefly_main_quest.lab_powder setscriptablepartstate( "vfx", "interacted" );
        level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "p_added" );
        level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_beaker", "white" );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_85406ac6c81c5f3c", 1 );
        wait 1.5;
        function_991aa7091b8e1fae();
        player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"place_powder", #"hash_5212ed7ec42f115a" );
    }
    
    if ( level utility::flag( "p_added_serum" ) && level utility::flag( "b_lab_spawned" ) && !level utility::flag( "b_added_serum" ) && var_bf8d12c8712ee14d > var_30736d696a032221 && var_bf8d12c8712ee14d >= var_81ccc78b471bf8f )
    {
        level utility::flag_set( "b_added_serum" );
        level.firefly_main_quest.lab_bone setscriptablepartstate( "vfx", "interacted" );
        level.ingredients_added[ level.ingredients_added.size ] = level.firefly_main_quest.lab_bone.code;
        level utility::delaythread( 1.5, &function_51f12524c830dd09 );
        
        if ( level.ingredients_added.size == 3 )
        {
            function_510b4d744c82df86();
            function_120b16c5b8c77045( player );
        }
        else
        {
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "audio", "add_ingredient" );
        }
    }
    
    if ( level utility::flag( "p_added_serum" ) && level utility::flag( "s_lab_spawned" ) && !level utility::flag( "s_added_serum" ) && var_2abe985c549a93d9 > var_30736d696a032221 && var_2abe985c549a93d9 >= var_81ccc78b471bf8f )
    {
        level utility::flag_set( "s_added_serum" );
        level.firefly_main_quest.lab_shell setscriptablepartstate( "vfx", "interacted" );
        level.ingredients_added[ level.ingredients_added.size ] = level.firefly_main_quest.lab_shell.code;
        level utility::delaythread( 1.5, &function_51f12524c830dd09 );
        
        if ( level.ingredients_added.size == 3 )
        {
            function_510b4d744c82df86();
            function_120b16c5b8c77045( player );
        }
        else
        {
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "audio", "add_ingredient" );
        }
    }
    
    if ( level utility::flag( "p_added_serum" ) && level utility::flag( "m_lab_spawned" ) && !level utility::flag( "m_added_serum" ) && var_50c66d7ae2c3f39d > var_30736d696a032221 && var_50c66d7ae2c3f39d >= var_81ccc78b471bf8f )
    {
        level utility::flag_set( "m_added_serum" );
        level.firefly_main_quest.lab_mushroom setscriptablepartstate( "vfx", "interacted" );
        level.ingredients_added[ level.ingredients_added.size ] = level.firefly_main_quest.lab_mushroom.code;
        level utility::delaythread( 1.5, &function_51f12524c830dd09 );
        
        if ( level.ingredients_added.size == 3 )
        {
            function_510b4d744c82df86();
            function_120b16c5b8c77045( player );
        }
        else
        {
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "audio", "add_ingredient" );
        }
    }
    
    if ( level utility::flag( "p_added_serum" ) && level utility::flag( "e_lab_spawned" ) && !level utility::flag( "e_added_serum" ) && var_9f4beb5769aa4332 > var_30736d696a032221 && var_9f4beb5769aa4332 >= var_81ccc78b471bf8f )
    {
        level utility::flag_set( "e_added_serum" );
        level.firefly_main_quest.lab_eye setscriptablepartstate( "vfx", "interacted" );
        level.ingredients_added[ level.ingredients_added.size ] = level.firefly_main_quest.lab_eye.code;
        level utility::delaythread( 1.5, &function_51f12524c830dd09 );
        
        if ( level.ingredients_added.size == 3 )
        {
            function_510b4d744c82df86();
            function_120b16c5b8c77045( player );
        }
        else
        {
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "audio", "add_ingredient" );
        }
    }
    
    if ( level utility::flag( "p_added_serum" ) && level utility::flag( "t_lab_spawned" ) && !level utility::flag( "t_added_serum" ) && var_40dec4be6afcf1d > var_30736d696a032221 && var_40dec4be6afcf1d >= var_81ccc78b471bf8f )
    {
        level utility::flag_set( "t_added_serum" );
        level.firefly_main_quest.lab_tentacle setscriptablepartstate( "vfx", "interacted" );
        level.ingredients_added[ level.ingredients_added.size ] = level.firefly_main_quest.lab_tentacle.code;
        level utility::delaythread( 1.5, &function_51f12524c830dd09 );
        
        if ( level.ingredients_added.size == 3 )
        {
            function_510b4d744c82df86();
            function_120b16c5b8c77045( player );
        }
        else
        {
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "audio", "add_ingredient" );
        }
        
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0x6b9367da, Offset: 0xc480
// Size: 0x642
function function_dd29c34a6a5b8888( interact, player )
{
    if ( player.interactions_disabled || !level zm_sat_firefly::function_24006873400b7a8() )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    var_30736d696a032221 = cos( 20 );
    playerangles = player getplayerangles();
    playerlookdir = anglestoforward( playerangles );
    player_view = player gettagorigin( "j_head" );
    
    if ( isplayer( player ) && player getcamerathirdperson() )
    {
        player_view = player getcamerathirdpersonorigin();
        var_30736d696a032221 = cos( 80 );
    }
    
    var_391d5698adb08e8f = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_e956823444b5d959.origin - player_view ) );
    
    /#
        sphere( level.firefly_main_quest.var_e956823444b5d959.origin, 5, ( 1, 0, 0 ), 1, 1 );
    #/
    
    var_bf8d12c8712ee14d = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_96459405e9c48efe.origin - player_view ) );
    
    /#
        sphere( level.firefly_main_quest.var_96459405e9c48efe.origin, 5, ( 1, 0, 0 ), 1, 1 );
    #/
    
    var_2abe985c549a93d9 = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_c4295853d4e96d62.origin - player_view ) );
    
    /#
        sphere( level.firefly_main_quest.var_c4295853d4e96d62.origin, 5, ( 1, 0, 0 ), 1, 1 );
    #/
    
    var_50c66d7ae2c3f39d = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_edf8c0a089c490a.origin - player_view ) );
    
    /#
        sphere( level.firefly_main_quest.var_edf8c0a089c490a.origin, 5, ( 1, 0, 0 ), 1, 1 );
    #/
    
    var_40dec4be6afcf1d = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_773fef53052846e.origin - player_view ) );
    
    /#
        sphere( level.firefly_main_quest.var_773fef53052846e.origin, 5, ( 1, 0, 0 ), 1, 1 );
    #/
    
    var_9f4beb5769aa4332 = vectordot( playerlookdir, vectornormalize( level.firefly_main_quest.var_c71b94d062f0f1c5.origin - player_view ) );
    
    /#
        sphere( level.firefly_main_quest.var_c71b94d062f0f1c5.origin, 5, ( 1, 0, 0 ), 1, 1 );
    #/
    
    if ( !level utility::flag( "p_added_serum" ) )
    {
        level.var_8c3ee4a8015df21b = [ var_391d5698adb08e8f, var_bf8d12c8712ee14d, var_2abe985c549a93d9, var_50c66d7ae2c3f39d, var_40dec4be6afcf1d, var_9f4beb5769aa4332 ];
    }
    
    if ( level utility::flag( "p_added_serum" ) )
    {
        level.var_8c3ee4a8015df21b = [ var_bf8d12c8712ee14d, var_2abe985c549a93d9, var_50c66d7ae2c3f39d, var_40dec4be6afcf1d, var_9f4beb5769aa4332 ];
    }
    
    [ var_81ccc78b471bf8f ] = arraysort( level.var_8c3ee4a8015df21b, undefined, &function_b2a78e2ee069be42 );
    
    if ( !level utility::flag( "p_added_serum" ) && var_391d5698adb08e8f > var_30736d696a032221 && var_391d5698adb08e8f >= var_81ccc78b471bf8f )
    {
        return { #string:&"zm_sat_firefly/b_p_interact", #type:"HINT_NOICON" };
    }
    
    if ( level utility::flag( "p_added_serum" ) && level utility::flag( "b_lab_spawned" ) && !level utility::flag( "b_added_serum" ) && var_bf8d12c8712ee14d > var_30736d696a032221 && var_bf8d12c8712ee14d >= var_81ccc78b471bf8f )
    {
        return { #string:&"zm_sat_firefly/b_b_interact", #type:"HINT_NOICON" };
    }
    
    if ( level utility::flag( "p_added_serum" ) && level utility::flag( "s_lab_spawned" ) && !level utility::flag( "s_added_serum" ) && var_2abe985c549a93d9 > var_30736d696a032221 && var_2abe985c549a93d9 >= var_81ccc78b471bf8f )
    {
        return { #string:&"zm_sat_firefly/b_s_interact", #type:"HINT_NOICON" };
    }
    
    if ( level utility::flag( "p_added_serum" ) && level utility::flag( "m_lab_spawned" ) && !level utility::flag( "m_added_serum" ) && var_50c66d7ae2c3f39d > var_30736d696a032221 && var_50c66d7ae2c3f39d >= var_81ccc78b471bf8f )
    {
        return { #string:&"zm_sat_firefly/b_m_interact", #type:"HINT_NOICON" };
    }
    
    if ( level utility::flag( "p_added_serum" ) && level utility::flag( "e_lab_spawned" ) && !level utility::flag( "e_added_serum" ) && var_9f4beb5769aa4332 > var_30736d696a032221 && var_9f4beb5769aa4332 >= var_81ccc78b471bf8f )
    {
        return { #string:&"zm_sat_firefly/b_e_interact", #type:"HINT_NOICON" };
    }
    
    if ( level utility::flag( "p_added_serum" ) && level utility::flag( "t_lab_spawned" ) && !level utility::flag( "t_added_serum" ) && var_40dec4be6afcf1d > var_30736d696a032221 && var_40dec4be6afcf1d >= var_81ccc78b471bf8f )
    {
        return { #string:&"zm_sat_firefly/b_t_interact", #type:"HINT_NOICON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xb37cb6ce, Offset: 0xcaca
// Size: 0x19, Type: bool
function private function_b2a78e2ee069be42( var_b449a6cf38e90cd1, var_59f2c12b6b615667 )
{
    return var_b449a6cf38e90cd1 >= var_59f2c12b6b615667;
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x1dc2155c, Offset: 0xcaec
// Size: 0x23f
function private function_c423ec878b8fcdd1( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( level.firefly_main_quest.chem_reaction.interact )
        {
            level.firefly_main_quest.chem_reaction.interact freescriptable();
        }
        
        level utility::flag_set( "serum_t_complete" );
        return;
    }
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        if ( level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_85406ac6c81c5f3c" ) == 4 )
        {
            level utility::flag_set( "lt_failed" );
            level utility::flag_set( "p_added_serum" );
            
            if ( !level callback::exists( "on_round_end", &function_f5697c72ddc52e99 ) )
            {
                level callback::add( "on_round_end", &function_f5697c72ddc52e99 );
            }
            
            return;
        }
    }
    
    if ( level utility::flag( "serum_brewed" ) )
    {
        level.lab_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( level.firefly_main_quest.chem_reaction.origin ) );
        zm_quest::function_fe2a9a31ab8fbcab( [ "zone_launchpad_maintenance" ] );
        zm_blackhole_bomb::function_2a49f9fa9277a208( [ "zone_launchpad_maintenance" ] );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_85406ac6c81c5f3c", 3 );
        level utility::flag_set( "mq_waiting_to_commence" );
        level.firefly_main_quest.var_767305fbc94bf06b = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.chem_reaction.origin + ( -5, -5, 2 ), level.firefly_main_quest.chem_reaction.angles );
        level.firefly_main_quest.var_767305fbc94bf06b setscriptablepartstate( "interact_final", "on_visible_final" );
        level.firefly_main_quest.var_767305fbc94bf06b.interaction = interaction::register_scriptable_interact( level.firefly_main_quest.var_767305fbc94bf06b, &serum_cinematic, undefined, undefined, &function_fded4221e8164248 );
    }
    
    level utility::flag_wait( "serum_t_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x4e9f552e, Offset: 0xcd33
// Size: 0x50
function function_7a94fcec2a51c86e()
{
    switch ( level.players.size )
    {
        case 1:
            return 40;
        case 2:
            return 60;
        case 3:
            return 95;
        case 4:
            return 95;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x15ee90f0, Offset: 0xcd8b
// Size: 0x52
function function_b98c2845fd69209e()
{
    switch ( level.players.size )
    {
        case 1:
            return 30;
        case 2:
            return 50;
        case 3:
            return 75;
        case 4:
            return 75;
    }
    
    return 30;
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0xbfb5a38, Offset: 0xcde6
// Size: 0x25c
function killstreaks_off( player )
{
    killstreaks = player killstreak_utility::get_using_killstreaks();
    equipment_in_level = level.activekillstreaks;
    
    foreach ( equipment in equipment_in_level )
    {
        if ( equipment.equipmentref == "equip_mini_sentry" )
        {
            equipment thread mini_sentry::on_destruction();
            continue;
        }
        
        if ( equipment.streakname == "dawg" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment thread dawg::dawg_self_destruct();
            continue;
        }
        
        if ( equipment.streakname == "remote_turret" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment notify( #"kill_turret", 1, 1, 0, 1 );
            continue;
        }
        
        if ( equipment.streakname == "rcxd" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment thread rcxd_shared::rcxd_explode();
            continue;
        }
        
        if ( equipment.equipmentref == "equip_smart_seeker" )
        {
            equipment thread smart_seeker::function_16e1c3f278107106();
        }
    }
    
    foreach ( player in level.players )
    {
        if ( player isconnected() && player.sessionstate == "playing" )
        {
            if ( player.ismutantinjection )
            {
                player thread utility::callsharedfunc( #"mutant_injection", #"hash_a5f95a84b4e1bbaf", 1 );
            }
        }
        
        player notify( #"killstreak_cancel" );
        player notify( #"equip_deploy_cancel" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x944caf99, Offset: 0xd04a
// Size: 0xaa
function private function_fded4221e8164248( interact, player )
{
    if ( player && player.interactions_disabled || !player val::get( "interactions" ) )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( !function_634606a54374b25f() )
    {
        return { #string:&"zm_sat_firefly/b_m_cooldown", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"zm_sat_firefly/b_m_final", #type:"HINT_NOICON" };
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0xda0b76f5, Offset: 0xd0fd
// Size: 0x50f
function serum_cinematic( user )
{
    level endon( #"game_ended" );
    
    if ( !user val::get( "interactions" ) )
    {
        return;
    }
    
    if ( !function_634606a54374b25f() )
    {
        return;
    }
    
    level val::set( "serum_trial", "task_logic_activate", 0 );
    
    if ( level.europa.europa.owner )
    {
        level.europa.europa.owner utility::callsharedfunc( #"europa", #"hash_461d60a67b99be95" );
        params = { #var_1e16f21a93bcbe7f:1 };
        level.europa utility::callsharedfunc( #"europa", #"hash_128edca9c946949c", params );
    }
    
    level thread killstreaks_off( user );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_85406ac6c81c5f3c", 4 );
    level utility::flag_set( "progressing_mq_special_event" );
    level thread function_51f12524c830dd09();
    level.firefly_main_quest utility::ent_flag_set( "player_give_blood" );
    level.firefly_main_quest.var_767305fbc94bf06b setscriptablepartstate( "interact_final", "off" );
    level utility::delaythread( 2, &function_51f12524c830dd09 );
    player = user;
    level thread function_fd8ac58196d5256b( player );
    level.firefly_main_quest.serum_clip = getent( "lt_c", #targetname );
    level.firefly_main_quest.serum_clip disconnectpaths();
    level.firefly_main_quest.serum_clip solid();
    zm_round_spawning::pause_round_spawning( 1, "main_quest_pause_spawning" );
    level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 0, 1, undefined, 1, undefined, 0.2 );
    
    if ( isplayer( user ) )
    {
        level thread function_e498d85c50eb65cf( user );
        player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"add_blood", #"hash_5212ed7ec42f115a" );
    }
    
    level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "serum_success" );
    level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "serum_s_loop" );
    level thread function_acbb4445441c06bc( player );
    level zone_spawner::function_2ce7db1d59b307d8( level.lab_zone.zone_name );
    var_9f6979548cc4c8e7 = zone_manager::get_zone_occupants( level.lab_zone.zone_name );
    
    foreach ( player in var_9f6979548cc4c8e7 )
    {
        player val::set( "LT_EVENT", "round_spawning_ignore_player", 1 );
        player val::set( "mq_trial_active", "killstreaks", 0 );
    }
    
    level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_beaker", "purple" );
    activateworldevent( "we_lgt_yuri_lab", 1 );
    level.lab_doors = utility::getstructarray( "gd_lab", "targetname" );
    
    foreach ( door in level.lab_doors )
    {
        door.fx = spawnscriptable( "sat_zm_gd_fx", door.origin, door.angles );
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_cca7446f54ae8cb2" );
    
    if ( var_9f6979548cc4c8e7.size == 1 )
    {
        wait 5;
    }
    else
    {
        wait 2;
    }
    
    if ( level.smoke_sbl )
    {
        level.smoke_sbl setscriptablepartstate( "trial_fog", "low" );
    }
    
    function_fd2e82cacd542262();
    warp_players = arrayremove( level.players, player );
    a_players = arrayrandomize( warp_players );
    
    foreach ( player in a_players )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"add_blood_response" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x8bdd15bd, Offset: 0xd614
// Size: 0x34, Type: bool
function private function_634606a54374b25f()
{
    if ( level utility::flag( "progressing_bear_attack_quest" ) )
    {
        return false;
    }
    
    if ( level utility::flag( "progressing_dmps_ee" ) )
    {
        return false;
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x719b7731, Offset: 0xd651
// Size: 0xbd
function function_fd8ac58196d5256b( player )
{
    level utility::delaythread( 0.5, &function_eb9437e8c03d6ff5 );
    warp_players = arrayremove( level.players, player );
    s_warp_locations = utility::getstruct( "s_warp_loc", "targetname" );
    
    foreach ( player in warp_players )
    {
        level thread zm_fasttravel::function_cbb08198e7c84adf( s_warp_locations, player );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x8f61a01c, Offset: 0xd716
// Size: 0x3f
function private function_eb9437e8c03d6ff5()
{
    if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_ee3a6dc51896d3d8" ) )
    {
        level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_ee3a6dc51896d3d8" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0xbe6de946, Offset: 0xd75d
// Size: 0xae
function function_e498d85c50eb65cf( player )
{
    player endon( #"death" );
    s_cin_knife = utility::getstruct( "cin_knife" );
    cin_knife = utility::spawn_model( "sat_vm_me_knife_rec", s_cin_knife.origin, s_cin_knife.angles );
    cin_knife.animname = "knife";
    s_scene = utility::getstruct( "tag_align_chemistry_bench_equipment" );
    
    if ( isdefined( s_scene ) )
    {
        s_scene scene::play( [ player, cin_knife ], "shot_010", "sat_cin_zm_vig_bleed" );
    }
    
    cin_knife delete();
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x3713db5, Offset: 0xd813
// Size: 0x30a
function function_fd2e82cacd542262()
{
    level.a_s_zombie_spawned = [];
    level.var_deadcacf8f58a5d2 = 0;
    spawn_pos_serum_trial = utility::getstructarray( "zone_launchpad_maintenance", "target" );
    shade_spawn = spawn_pos_serum_trial[ 0 ];
    base_zombie_spawn = arrayremove( spawn_pos_serum_trial, shade_spawn );
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        round_number = zm_round_logic::get_rb_round_number() + 2;
        var_215e83170a169367 = [ "zombie_base", "zombie_shade", "zombie_base_armored_light" ];
    }
    else
    {
        round_number = zm_round_logic::get_rb_round_number();
        var_215e83170a169367 = [ "zombie_base", "zombie_base_armored_light" ];
    }
    
    level callback::add( "on_zombie_ai_killed", &serum_zombie_killed, level.firefly_main_quest.chem_reaction.origin );
    level callback::add( #"player_laststand", &serum_player_downed );
    spawn_count = function_7a94fcec2a51c86e();
    i = 0;
    
    while ( i < spawn_count )
    {
        if ( !level utility::flag( "serum_t_finished" ) && !level utility::flag( "lt_failed" ) )
        {
            if ( zm_utility::get_active_zombies_count() >= 40 )
            {
                wait 1;
                continue;
            }
            
            zombie_type = utility::array_random( var_215e83170a169367 );
            
            if ( zombie_type == "zombie_base" || zombie_type == "zombie_base_armored_light" )
            {
                spawn_pos = utility::array_random( base_zombie_spawn );
                zombie = agent_manager::spawn_agent( zombie_type, spawn_pos.origin, spawn_pos.angles, "team_two_hundred" );
            }
            else if ( zombie_type == "zombie_shade" )
            {
                spawn_pos = shade_spawn;
                zombie = agent_manager::spawn_agent( zombie_type, spawn_pos.origin, spawn_pos.angles, "team_two_hundred" );
            }
            
            if ( isdefined( zombie ) )
            {
                zombie.kiastring = #"zombie_kia_mission_kill";
                zombie.no_powerups = 1;
                zombie zombie_utils::set_zombie_round_difficulty( round_number );
                zombie.ignore_enemy_count = 1;
                zombie.var_a13bed1ac47e1b2c = 1;
                zombie.disable_brain_rot = 1;
                zombie.var_7ee152b43c7188e1 = 1;
                zombie.serum_trial_zombie = 1;
                zombie.b_ignore_cleanup = 1;
                level.a_s_zombie_spawned[ level.a_s_zombie_spawned.size ] = zombie;
                
                if ( isdefined( spawn_pos.script_animation ) )
                {
                    zombie thread zone_spawner::function_ce10e453e7f7bb8e( spawn_pos );
                }
                
                if ( isdefined( zombie ) && ( zombie_type == "zombie_base" || zombie_type == "zombie_base_armored_light" ) )
                {
                    zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
                }
                else if ( isdefined( zombie ) && zombie_type == "zombie_shade" )
                {
                    zombie setscriptablepartstate( "eyes", "base_purple_eyes" );
                }
                
                i++;
            }
        }
        else
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0xb5b29f4e, Offset: 0xdb25
// Size: 0x67
function function_acbb4445441c06bc( player )
{
    if ( isdefined( player ) )
    {
        player.health = 75;
        player.serum_damaged = 1;
        player val::set( "serum_health", "health_regen", 0 );
        player utility::ent_flag_set( "disable_player_heal_items" );
        player callback::add( #"hash_11343ded26b4d165", &function_dde1f777defff9c );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x936333a6, Offset: 0xdb94
// Size: 0x57
function private function_dde1f777defff9c( params )
{
    if ( params.source_string == level.fireflyww_basename )
    {
        return;
    }
    
    self dodamage( params.overcharge_amount, self.origin, self, self, "MOD_UNKNOWN", level.weaponnone, "none" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x97575cf8, Offset: 0xdbf3
// Size: 0xb1
function serum_player_downed( params )
{
    if ( isdefined( self.serum_damaged ) )
    {
        if ( self.serum_damaged == 1 )
        {
            level thread serum_trial_failed();
            utility::ent_flag_clear( "disable_player_heal_items" );
            val::reset( "serum_health", "health_regen" );
            self.serum_damaged = 0;
            callback::remove( #"hash_11343ded26b4d165", &function_dde1f777defff9c );
            level callback::remove( "on_zombie_ai_killed", &serum_zombie_killed, level.firefly_main_quest.chem_reaction.origin );
            level callback::remove( #"player_laststand", &serum_player_downed );
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0xf67700bf, Offset: 0xdcac
// Size: 0xba
function serum_zombie_killed( params, struct )
{
    if ( isplayer( params.eattacker ) || isplayer( params.eattacker.owner ) )
    {
        if ( self.serum_trial_zombie && !level utility::flag( "serum_t_finished" ) )
        {
            if ( self && self tagexists( "j_spineupper" ) )
            {
                playfxontag( level._effect[ #"mq_zombie_killed" ], self, "j_spineupper" );
            }
            
            level.var_deadcacf8f58a5d2++;
            level thread function_51f12524c830dd09();
            level thread function_ae24da73387b8f98( self getcentroid(), struct );
            level thread serum_success_check();
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0x2ed7d70d, Offset: 0xdd6e
// Size: 0x109
function function_ae24da73387b8f98( v_start, v_end )
{
    e_s_fx = utility::spawn_model( "tag_origin", v_start );
    e_e_fx = utility::spawn_model( "tag_origin", v_end );
    playfxontag( level._effect[ #"mq_zombie_trail" ], e_s_fx, "tag_origin" );
    playsoundatpos( e_s_fx.origin, #"hash_4f6ac5170171a88c" );
    e_s_fx playloopsound( #"hash_34bdae4d9fd25ab5" );
    n_time = distance2d( v_start, v_end ) / 200;
    e_s_fx utility::function_8001268940441423( v_start, v_end, v_start + ( 0, 0, 48 ), n_time, 0, 1 );
    wait n_time;
    playfxontag( level._effect[ #"mq_zombie_impact" ], e_e_fx, "tag_origin" );
    playsoundatpos( e_e_fx.origin, #"hash_451a39e679b1d41d" );
    e_s_fx delete();
    e_e_fx delete();
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x7dd5c5d3, Offset: 0xde7f
// Size: 0x38f
function serum_trial_failed()
{
    level val::reset( "serum_trial", "task_logic_activate" );
    level.var_deadcacf8f58a5d2 = 0;
    deactivateworldevent( "we_lgt_yuri_lab", 1 );
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"hash_cca7446f54ae8cb2" );
    level utility::flag_set( "lt_failed" );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_85406ac6c81c5f3c", 4 );
    level utility::flag_clear( "progressing_mq_special_event" );
    level utility::flag_clear( "mq_waiting_to_commence" );
    wait 1;
    
    foreach ( zombie in level.a_s_zombie_spawned )
    {
        if ( isalive( zombie ) )
        {
            if ( zombie.magic_bullet_shield || zombie.damageshield )
            {
                zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
            }
            
            zombie kill();
        }
        
        waitframe();
    }
    
    foreach ( door in level.lab_doors )
    {
        door.fx setscriptablepartstate( "vfx", "off" );
    }
    
    level.firefly_main_quest utility::ent_flag_clear( "player_give_blood" );
    level.smoke_sbl setscriptablepartstate( "trial_fog", "low_end_fast" );
    level thread function_51f12524c830dd09();
    zm_round_spawning::pause_round_spawning( 0, "main_quest_pause_spawning" );
    wait 1;
    level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "trial_failure" );
    level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_beaker", "red" );
    level.firefly_main_quest.serum_clip = getent( "lt_c", #targetname );
    level.firefly_main_quest.serum_clip connectpaths();
    level.firefly_main_quest.serum_clip notsolid();
    
    if ( !level callback::exists( "on_round_end", &function_f5697c72ddc52e99 ) )
    {
        level callback::add( "on_round_end", &function_f5697c72ddc52e99 );
    }
    
    foreach ( player in level.players )
    {
        player val::reset( "LT_EVENT", "round_spawning_ignore_player" );
        player val::reset( "mq_trial_active", "killstreaks" );
    }
    
    level zone_spawner::function_8a020f24a3b73c79( level.lab_zone.zone_name );
    level zm_quest::function_765655c7699f9fb7();
    zm_blackhole_bomb::function_bcfc2c555363a3b5();
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x565fdc17, Offset: 0xe216
// Size: 0x1b3
function function_f5697c72ddc52e99( params )
{
    level utility::flag_clear( "lt_failed" );
    level callback::remove( "on_round_end", &function_f5697c72ddc52e99 );
    
    if ( level.lab_zone )
    {
        level.lab_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( level.firefly_main_quest.chem_reaction.origin ) );
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_85406ac6c81c5f3c", 3 );
    zm_quest::function_fe2a9a31ab8fbcab( [ "zone_launchpad_maintenance" ] );
    zm_blackhole_bomb::function_2a49f9fa9277a208( [ "zone_launchpad_maintenance" ] );
    
    if ( !level.firefly_main_quest.var_767305fbc94bf06b )
    {
        level.firefly_main_quest.var_767305fbc94bf06b = spawnscriptable( %"zm_sat_firefly_bench_ingredients", level.firefly_main_quest.chem_reaction.origin + ( -5, -5, 2 ), level.firefly_main_quest.chem_reaction.angles );
    }
    
    level.firefly_main_quest.var_767305fbc94bf06b setscriptablepartstate( "interact_final", "on_visible_final" );
    
    if ( !level.firefly_main_quest.var_767305fbc94bf06b.interaction )
    {
        level.firefly_main_quest.var_767305fbc94bf06b.interaction = interaction::register_scriptable_interact( level.firefly_main_quest.var_767305fbc94bf06b, &serum_cinematic, undefined, undefined, &function_fded4221e8164248 );
    }
    
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x45d25921, Offset: 0xe3d1
// Size: 0x6e3
function serum_success_check()
{
    if ( level.var_deadcacf8f58a5d2 >= function_b98c2845fd69209e() )
    {
        level val::reset( "serum_trial", "task_logic_activate" );
        level notify( #"st_success" );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_85406ac6c81c5f3c", 3 );
        level.smoke_sbl setscriptablepartstate( "vfx", "on" );
        level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"hash_cca7446f54ae8cb2" );
        level utility::flag_set( "serum_t_finished" );
        level thread function_32c809be8844353c();
        
        foreach ( zombie in level.a_s_zombie_spawned )
        {
            if ( isalive( zombie ) )
            {
                if ( zombie.magic_bullet_shield || zombie.damageshield )
                {
                    zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
                }
                
                zombie kill();
            }
            
            waitframe();
        }
        
        level thread function_975f6bb7d2fc4443();
        var_709ba58ea300af4a = utility::getstruct( "s_psma" );
        var_709ba58ea300af4a.powerup = powerups::powerup_drop( "full_ammo", var_709ba58ea300af4a.origin, 60, undefined, "quest" );
        wait 3;
        
        foreach ( player in level.players )
        {
            pbgpostfxbundlestart( player, %"sat_zm_firefly_distortion_hallucination" );
            player playlocalsound( #"hash_92ef19c79583b10d" );
            curweapon = player getcurrentweapon();
            gestureref = "t10_ges_coughing_from_gas";
            
            if ( isdefined( curweapon ) && curweapon != level.weaponnone && !player isgestureplaying( gestureref ) )
            {
                player forceplaygestureviewmodel( gestureref, undefined, 0.15, 0, 1, 1 );
            }
            
            player allowreload( 0 );
            player disableweaponswitch();
        }
        
        wait 8;
        
        foreach ( player in level.players )
        {
            pbgpostfxbundleend( player, %"sat_zm_firefly_distortion_hallucination" );
            player allowreload( 1 );
            player enableweaponswitch();
            player val::reset( "mq_trial_active", "killstreaks" );
        }
        
        if ( level.smoke_sbl )
        {
            level.smoke_sbl setscriptablepartstate( "vfx", "disappear" );
            level.smoke_sbl setscriptablepartstate( "trial_fog", "low_end" );
        }
        
        level callback::remove( "on_zombie_ai_killed", &serum_zombie_killed, level.firefly_main_quest.chem_reaction.origin );
        level callback::remove( #"player_laststand", &serum_player_downed );
        deactivateworldevent( "we_lgt_yuri_lab", 1 );
        level utility::flag_set( "serum_t_complete" );
        
        foreach ( door in level.lab_doors )
        {
            door.fx setscriptablepartstate( "vfx", "off" );
            door.fx freescriptable();
        }
        
        zm_round_spawning::pause_round_spawning( 0, "main_quest_pause_spawning" );
        wait 1;
        
        if ( level.firefly_main_quest.chem_beaker )
        {
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "serum_complete" );
        }
        
        if ( isdefined( level.firefly_main_quest.serum_clip ) )
        {
            level.firefly_main_quest.serum_clip = getent( "lt_c", #targetname );
            level.firefly_main_quest.serum_clip connectpaths();
            level.firefly_main_quest.serum_clip notsolid();
        }
        
        if ( level.lab_zone.zone_name )
        {
            level zone_spawner::function_8a020f24a3b73c79( level.lab_zone.zone_name );
        }
        
        level zm_quest::function_765655c7699f9fb7();
        zm_blackhole_bomb::function_bcfc2c555363a3b5();
        level thread function_51f12524c830dd09();
        overlord::playevent( #"hash_fe767250e6b0c102", level.players, 5 );
        wait 5;
        
        if ( level.firefly_main_quest.chem_beaker )
        {
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "off" );
        }
        
        level utility::flag_clear( "progressing_mq_special_event" );
        level utility::flag_clear( "mq_waiting_to_commence" );
        wait 3;
        level thread function_51f12524c830dd09();
        
        foreach ( player in level.players )
        {
            var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_d81d74c738643cdf" );
            
            if ( var_db75d3de862ce072 )
            {
                return;
            }
        }
        
        foreach ( player in level.players )
        {
            var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_d81d74c738643cdf", #"hash_5212ed7ec42f115a" );
            
            if ( var_db75d3de862ce072 )
            {
                return;
            }
        }
        
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x795d652c, Offset: 0xeabc
// Size: 0x107
function function_32c809be8844353c()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.serum_damaged ) )
        {
            if ( player.serum_damaged == 1 )
            {
                player.health = player.maxhealth;
                player utility::ent_flag_clear( "disable_player_heal_items" );
                player callback::remove( #"hash_11343ded26b4d165", &function_dde1f777defff9c );
                player val::reset( "serum_health", "health_regen" );
                player.serum_damaged = 0;
            }
        }
        else
        {
            continue;
        }
        
        player val::reset( "LT_EVENT", "round_spawning_ignore_player" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x8187aa7b, Offset: 0xebcb
// Size: 0x9e
function private serum_trial_cleanup( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "serum_t_complete" );
        
        if ( isdefined( level.firefly_main_quest.chem_beaker ) )
        {
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_react", "off" );
            level.firefly_main_quest.chem_beaker setscriptablepartstate( "chem_beaker", "purple" );
        }
        
        level thread function_975f6bb7d2fc4443();
        return;
    }
    
    level utility::flag_wait( "serum_t_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x91281f31, Offset: 0xec71
// Size: 0x28
function private function_1f4dc49f3eab262d( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level function_a579706bcb3222d8( "zmloot_quest_firefly_k_1" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xe20e3e58, Offset: 0xeca1
// Size: 0x28
function private function_d13abee79adac4cc( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        function_261233f59a2ac264( "zmloot_quest_firefly_k_1", b_skipped );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x39c95416, Offset: 0xecd1
// Size: 0x28
function private function_3209fcf4f31c5af8( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level function_a579706bcb3222d8( "zmloot_quest_firefly_k_2" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x428a5327, Offset: 0xed01
// Size: 0x28
function private function_6a6f60c6ec15b281( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        function_261233f59a2ac264( "zmloot_quest_firefly_k_2", b_skipped );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xe8b96f34, Offset: 0xed31
// Size: 0x28
function private function_f198d05300e33fdb( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level function_a579706bcb3222d8( "zmloot_quest_firefly_k_3" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x22f677f2, Offset: 0xed61
// Size: 0x28
function private function_bc14ca2f37907a9e( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        function_261233f59a2ac264( "zmloot_quest_firefly_k_3", b_skipped );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xa8d5c040, Offset: 0xed91
// Size: 0x23
function private function_c8bd0c6defb6468c( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread function_51f12524c830dd09();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x475e1f1a, Offset: 0xedbc
// Size: 0x51
function private function_7701206bc1c2001d( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        if ( zm_quest::function_73720cdf21c3cfd7( level.pluto_upgrade_quest.key, #"picked_up_mg_part" ) )
        {
            level thread function_9523bdb86ead5360();
        }
    }
    
    level thread zm_quest::update_round_cap( 15 );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x816d4e43, Offset: 0xee15
// Size: 0x4c
function private function_9523bdb86ead5360()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "MQ_STEP_10_COMPLETE" );
    
    if ( level.firefly_main_quest.var_d5a2309951a61519 )
    {
        level thread common_item::function_869d7676e359a627( level.firefly_main_quest.var_d5a2309951a61519 );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xc6251e4, Offset: 0xee69
// Size: 0xdb
function private function_975f6bb7d2fc4443()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_sat_firefly_script_mq_create_script_completed" );
    level function_ae8648a02e488754();
    level function_74a5f4f7efc4e675();
    level function_5e73d78699f5ca06();
    level function_a0f80f5f77902345();
    level function_f901e1d9d88d74c3();
    level function_4f2b66733229d156();
    level function_5656b81fbea84944();
    var_7ea2925f82ff9e87 = utility::getstruct( "firefly_audiolog_3" );
    var_881839e21951901 = intel::spawn_intel_at_location( undefined, undefined, var_7ea2925f82ff9e87.origin, var_7ea2925f82ff9e87.angles, "zmintel_sat_firefly_audiolog_3", undefined );
    var_7ea28f5f82ff97ee = utility::getstruct( "firefly_audiolog_4" );
    var_881809e21951268 = intel::spawn_intel_at_location( undefined, undefined, var_7ea28f5f82ff97ee.origin, var_7ea28f5f82ff97ee.angles, "zmintel_sat_firefly_audiolog_4", undefined );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x99d7821, Offset: 0xef4c
// Size: 0x37f
function private function_5e73d78699f5ca06()
{
    s_clock_tower = utility::getstruct( "s_c_t", "targetname" );
    level.firefly_main_quest.clock_tower = spawnscriptable( %"zm_sat_firefly_mq_b_clock", s_clock_tower.origin, s_clock_tower.angles );
    minimap_state = level zm_sat_firefly::function_24006873400b7a8() ? "clock_minimap" : "clock";
    level.firefly_main_quest.clock_tower setscriptablepartstate( "bc_model", minimap_state );
    var_9f6a015b37148a15 = utility::getstruct( "bc_mh_f" );
    var_4885313ff4d0696 = utility::getstruct( "bc_hh_f" );
    var_4fd34ed7ab066671 = utility::getstruct( "bc_mh_r" );
    var_f5b16ff0b34cbeca = utility::getstruct( "bc_hh_r" );
    var_9712b6330d54e27f = utility::getstruct( "bc_mh_l" );
    var_eccd64c888f25214 = utility::getstruct( "bc_hh_l" );
    var_1de417b17922fe1 = utility::getstruct( "bc_mh_b" );
    var_7a69cb8575553fa = utility::getstruct( "bc_hh_b" );
    level.firefly_main_quest.var_75876c9ff261103b = utility::spawn_model( "sat_zm_clock_tower_minute_hand", var_9f6a015b37148a15.origin, var_9f6a015b37148a15.angles );
    level.firefly_main_quest.ct_hhf = utility::spawn_model( "sat_zm_clock_tower_hour_hand", var_4885313ff4d0696.origin, var_4885313ff4d0696.angles );
    level.firefly_main_quest.var_7587609ff260f5d7 = utility::spawn_model( "sat_zm_clock_tower_minute_hand", var_4fd34ed7ab066671.origin, var_4fd34ed7ab066671.angles );
    level.firefly_main_quest.var_2cfa799fbd30ef80 = utility::spawn_model( "sat_zm_clock_tower_hour_hand", var_f5b16ff0b34cbeca.origin, var_f5b16ff0b34cbeca.angles );
    level.firefly_main_quest.var_7587669ff2610309 = utility::spawn_model( "sat_zm_clock_tower_minute_hand", var_9712b6330d54e27f.origin, var_9712b6330d54e27f.angles );
    level.firefly_main_quest.var_2cfa979fbd31317a = utility::spawn_model( "sat_zm_clock_tower_hour_hand", var_eccd64c888f25214.origin, var_eccd64c888f25214.angles );
    level.firefly_main_quest.var_7587709ff2611907 = utility::spawn_model( "sat_zm_clock_tower_minute_hand", var_1de417b17922fe1.origin, var_1de417b17922fe1.angles );
    level.firefly_main_quest.var_2cfa899fbd3112b0 = utility::spawn_model( "sat_zm_clock_tower_hour_hand", var_7a69cb8575553fa.origin, var_7a69cb8575553fa.angles );
    
    foreach ( player in level.players )
    {
        player playlocalsound( "amb_mq_clocktower_spawn_2d" );
    }
    
    level thread function_4294d38c433ce8c8();
    level thread function_3e15fa2daf5f4b29();
    level thread function_937dbd1392300a7e();
    level thread function_ec8d5a7ebbfc9a0c();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x9093b01b, Offset: 0xf2d3
// Size: 0x9f
function private function_4294d38c433ce8c8()
{
    level.firefly_main_quest.var_75876c9ff261103b endon( #"death" );
    
    while ( !level utility::flag( "front_clock_paused" ) && level.firefly_main_quest.var_75876c9ff261103b )
    {
        level.firefly_main_quest.var_75876c9ff261103b rotateby( ( 0, 0, -25 ), 0.5 );
        level.firefly_main_quest.ct_hhf rotateby( ( 0, 0, 25 ), 0.5 );
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xe53a6faa, Offset: 0xf37a
// Size: 0x9f
function private function_ec8d5a7ebbfc9a0c()
{
    level.firefly_main_quest.var_7587709ff2611907 endon( #"death" );
    
    while ( !level utility::flag( "back_clock_paused" ) && level.firefly_main_quest.var_7587709ff2611907 )
    {
        level.firefly_main_quest.var_7587709ff2611907 rotateby( ( 0, 0, -25 ), 0.5 );
        level.firefly_main_quest.var_2cfa899fbd3112b0 rotateby( ( 0, 0, 25 ), 0.5 );
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xe9dd6e56, Offset: 0xf421
// Size: 0x9f
function private function_937dbd1392300a7e()
{
    level.firefly_main_quest.var_7587669ff2610309 endon( #"death" );
    
    while ( !level utility::flag( "left_clock_paused" ) && level.firefly_main_quest.var_7587669ff2610309 )
    {
        level.firefly_main_quest.var_7587669ff2610309 rotateby( ( 0, 0, -25 ), 0.5 );
        level.firefly_main_quest.var_2cfa979fbd31317a rotateby( ( 0, 0, 25 ), 0.5 );
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xfa7c9b16, Offset: 0xf4c8
// Size: 0x9f
function private function_3e15fa2daf5f4b29()
{
    level.firefly_main_quest.var_7587609ff260f5d7 endon( #"death" );
    
    while ( !level utility::flag( "right_clock_paused" ) && level.firefly_main_quest.var_7587609ff260f5d7 )
    {
        level.firefly_main_quest.var_7587609ff260f5d7 rotateby( ( 0, 0, -25 ), 0.5 );
        level.firefly_main_quest.var_2cfa799fbd30ef80 rotateby( ( 0, 0, 25 ), 0.5 );
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xe06c440d, Offset: 0xf56f
// Size: 0x15b
function private function_ae8648a02e488754()
{
    level.firefly_main_quest.var_17cf20b23559c948 = [];
    level.firefly_main_quest.var_c05225eadb335d26 = [];
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        function_f07f0f5b70f4ec35();
    }
    else
    {
        function_7cf201d59855050();
    }
    
    foreach ( key in level.firefly_main_quest.var_c05225eadb335d26 )
    {
        key function_5ab8b11d6b3614f9();
    }
    
    level.firefly_main_quest.var_7a5aedd799c9d22b = utility::spawn_script_origin();
    level.firefly_main_quest.var_7a5aedd799c9d22b.var_a7339c2c551e2788 = 1;
    
    if ( level._fasttravel[ "override_jumppad_watchEnter" ] )
    {
        level.firefly_main_quest.var_fdd3d0c6333d2bfe = level._fasttravel[ "override_jumppad_watchEnter" ];
    }
    
    level._fasttravel[ "override_jumppad_watchEnter" ] = &function_307dfe07d2d4973;
    level utility::flag_set( "MQ_STEP_10_INITIALIZED" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x44552010, Offset: 0xf6d2
// Size: 0x171
function private function_f07f0f5b70f4ec35()
{
    var_17cf20b23559c948 = utility::getstructarray( "m_ik_directed", "targetname" );
    
    foreach ( var_ba39b89925cb2697 in var_17cf20b23559c948 )
    {
        key_number = int( var_ba39b89925cb2697.script_label );
        spawnoptions = function_8e56b994cfba74dc( var_ba39b89925cb2697 );
        
        switch ( key_number )
        {
            case 1:
                sbl_type = "zmloot_quest_firefly_k_1";
                break;
            case 2:
                sbl_type = "zmloot_quest_firefly_k_2";
                break;
            case 3:
                sbl_type = "zmloot_quest_firefly_k_3";
                break;
            default:
                assertmsg( "<dev string:x57>" );
                break;
        }
        
        item_bundle = function_553573b18e2f6b49( sbl_type );
        level.firefly_main_quest.var_17cf20b23559c948[ sbl_type ] = var_ba39b89925cb2697;
        level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] = common_item::function_61c2c0251e742ffd( getscriptbundle( item_bundle ), 1, spawnoptions );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x8603cae, Offset: 0xf84b
// Size: 0x394
function private function_7cf201d59855050()
{
    var_17cf20b23559c948 = utility::getstructarray( "m_ik", "targetname" );
    var_17cf20b23559c948 = arrayrandomize( var_17cf20b23559c948 );
    var_16ebac066b121953 = zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_f04f47ded313ef48" );
    
    if ( zm_save::function_1dda3554974a999e() && var_16ebac066b121953 )
    {
        foreach ( var_ba39b89925cb2697 in var_17cf20b23559c948 )
        {
            if ( var_16ebac066b121953 == int( var_ba39b89925cb2697.script_noteworthy ) )
            {
                sbl_type = "zmloot_quest_firefly_k_1";
            }
            else if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_f6df26d4ade782e1" ) == int( var_ba39b89925cb2697.script_noteworthy ) )
            {
                sbl_type = "zmloot_quest_firefly_k_2";
            }
            else if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_a856caabc3628286" ) == int( var_ba39b89925cb2697.script_noteworthy ) )
            {
                sbl_type = "zmloot_quest_firefly_k_3";
            }
            else
            {
                sbl_type = undefined;
            }
            
            if ( isdefined( sbl_type ) )
            {
                item_bundle = function_553573b18e2f6b49( sbl_type );
                spawnoptions = function_8e56b994cfba74dc( var_ba39b89925cb2697 );
                level.firefly_main_quest.var_17cf20b23559c948[ sbl_type ] = var_ba39b89925cb2697;
                level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] = common_item::function_61c2c0251e742ffd( getscriptbundle( item_bundle ), 1, spawnoptions );
            }
        }
        
        return;
    }
    
    for ( i = 1; i <= 3 ; i++ )
    {
        key_number = i;
        
        foreach ( var_ba39b89925cb2697 in var_17cf20b23559c948 )
        {
            if ( key_number != int( var_ba39b89925cb2697.script_label ) )
            {
                continue;
            }
            
            spawnoptions = function_8e56b994cfba74dc( var_ba39b89925cb2697 );
            
            switch ( key_number )
            {
                case 1:
                    sbl_type = "zmloot_quest_firefly_k_1";
                    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_f04f47ded313ef48", int( var_ba39b89925cb2697.script_noteworthy ) );
                    break;
                case 2:
                    sbl_type = "zmloot_quest_firefly_k_2";
                    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_f6df26d4ade782e1", int( var_ba39b89925cb2697.script_noteworthy ) );
                    break;
                case 3:
                    sbl_type = "zmloot_quest_firefly_k_3";
                    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_a856caabc3628286", int( var_ba39b89925cb2697.script_noteworthy ) );
                    break;
                default:
                    assertmsg( "<dev string:x57>" );
                    break;
            }
            
            item_bundle = function_553573b18e2f6b49( sbl_type );
            level.firefly_main_quest.var_17cf20b23559c948[ sbl_type ] = var_ba39b89925cb2697;
            level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] = common_item::function_61c2c0251e742ffd( getscriptbundle( item_bundle ), 1, spawnoptions );
            break;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x5059779e, Offset: 0xfbe7
// Size: 0x9a
function private function_307dfe07d2d4973( s_jumppad, player )
{
    if ( !isalive( player ) || !isplayer( player ) )
    {
        return;
    }
    
    if ( player.var_57e070f1c0cc4a5f )
    {
        player function_cecc199610ab0976();
        player function_5d8a4281ec235ebe( "zmloot_quest_firefly_k_1" );
    }
    
    if ( player.var_57e071f1c0cc4c92 )
    {
        player function_8b0bb4dc5fa5b999();
        player function_5d8a4281ec235ebe( "zmloot_quest_firefly_k_2" );
    }
    
    if ( player.var_57e072f1c0cc4ec5 )
    {
        player function_debeb29cf24f75d4();
        player function_5d8a4281ec235ebe( "zmloot_quest_firefly_k_3" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xa592529d, Offset: 0xfc89
// Size: 0x60
function private function_a579706bcb3222d8( sbl_type )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "MQ_STEP_10_INITIALIZED" );
    
    if ( level.firefly_main_quest.var_17cf20b23559c948[ sbl_type ] )
    {
        level.firefly_main_quest.var_17cf20b23559c948[ sbl_type ] utility::ent_flag_wait( "MQ_STEP_10_SUBPART_COMPLETE" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x5e9b9f1a, Offset: 0xfcf1
// Size: 0x132, Type: bool
function private function_f1ac3844a976a89a( sbl_type )
{
    switch ( sbl_type )
    {
        case #"hash_9cdbafae6cb53df3":
            var_96b9ad8d374e9468 = 1;
            break;
        case #"hash_9cdbb0ae6cb53f86":
            var_96b9ad8d374e9468 = 2;
            break;
        case #"hash_9cdbb1ae6cb54119":
            var_96b9ad8d374e9468 = 3;
            break;
    }
    
    foreach ( player in level.players )
    {
        switch ( var_96b9ad8d374e9468 )
        {
            case 1:
                if ( player.var_57e070f1c0cc4a5f )
                {
                    return true;
                }
                
                break;
            case 2:
                if ( player.var_57e071f1c0cc4c92 )
                {
                    return true;
                }
                
                break;
            case 3:
                if ( player.var_57e072f1c0cc4ec5 )
                {
                    return true;
                }
                
                break;
        }
    }
    
    return false;
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x5934e1ae, Offset: 0xfe2c
// Size: 0x5f
function private function_5ab8b11d6b3614f9()
{
    key = self;
    key setscriptablepartstate( key.type, "unusable" );
    level.var_76c45cae2094c966[ level.var_76c45cae2094c966.size ] = key;
    key.ground_offset = ( 0, 0, 2 );
    key thread function_f9efe139e20ee1f8();
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xb993c489, Offset: 0xfe93
// Size: 0x137
function private function_261233f59a2ac264( sbl_type, b_skipped )
{
    level endon( #"game_ended" );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        if ( !level utility::flag( "found_entity_box" ) )
        {
            level utility::flag_set( "found_entity_box" );
        }
        
        if ( !level utility::flag( "observed_serum_changes_in_ashwood" ) )
        {
            level utility::flag_set( "observed_serum_changes_in_ashwood" );
        }
    }
    
    level utility::flag_wait( "MQ_STEP_10_INITIALIZED" );
    level.firefly_main_quest.var_17cf20b23559c948[ sbl_type ] utility::ent_flag_set( "MQ_STEP_10_SUBPART_COMPLETE" );
    
    if ( isdefined( level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] ) )
    {
        level common_item::function_869d7676e359a627( level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] );
    }
    
    level.firefly_main_quest.entity_box.a_chains[ sbl_type ] utility::function_32b24db3127bff40( "material", "off" );
    level.firefly_main_quest.entity_box.a_chains[ sbl_type ] utility::function_32b24db3127bff40( "model", "broken" );
    function_193bc4cab35c87b9( b_skipped );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x74d86a44, Offset: 0xffd2
// Size: 0x100
function private function_f9efe139e20ee1f8()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level.firefly_main_quest.var_17cf20b23559c948[ self.type ] endon( #"MQ_STEP_10_SUBPART_COMPLETE" );
    utility::ent_flag_wait( "fireflyww_is_retrieved" );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        if ( !level utility::flag( "found_entity_box" ) )
        {
            level utility::flag_set( "found_entity_box" );
        }
        
        if ( !level utility::flag( "observed_serum_changes_in_ashwood" ) )
        {
            level utility::flag_set( "observed_serum_changes_in_ashwood" );
        }
    }
    
    level thread function_51f12524c830dd09();
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        thread function_4d310fbc480aeb87( self.type );
    }
    
    self setscriptablepartstate( self.type, "visible" );
    self.angles = ( 0, 0, self.angles[ 2 ] );
    wait 60;
    self notify( #"hash_3c618e3bf9af25ed" );
    level thread function_14a3a9705dd671cb( self.type );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0xc
// Checksum 0x9d99b198, Offset: 0x100da
// Size: 0x97
function private function_4d310fbc480aeb87( type )
{
    self notify( #"hash_31b38dce8fd887fa" );
    self endon( #"hash_31b38dce8fd887fa" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_3c618e3bf9af25ed" );
    level.firefly_main_quest.var_17cf20b23559c948[ type ] endon( #"MQ_STEP_10_SUBPART_COMPLETE" );
    utility::ent_flag_waitopen_any( "fireflyww_is_retrieved" );
    
    while ( true )
    {
        utility::ent_flag_wait( "fireflyww_is_retrieved" );
        level thread function_51f12524c830dd09();
        wait 0.75;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x7d60ddf8, Offset: 0x10179
// Size: 0x52
function private function_14a3a9705dd671cb( sbl_type )
{
    var_1e4139ca72a33905 = level.firefly_main_quest.var_17cf20b23559c948[ sbl_type ];
    key = function_59e087ed91183be9( var_1e4139ca72a33905, sbl_type );
    key function_5ab8b11d6b3614f9();
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x9cc819bb, Offset: 0x101d3
// Size: 0xc7
function private function_59e087ed91183be9( s_spawn, sbl_type )
{
    if ( isdefined( level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] ) )
    {
        level thread common_item::function_869d7676e359a627( level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] );
    }
    
    level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] = undefined;
    spawnoptions = function_8e56b994cfba74dc( s_spawn );
    item_bundle = function_553573b18e2f6b49( sbl_type );
    key = common_item::function_61c2c0251e742ffd( getscriptbundle( item_bundle ), 1, spawnoptions );
    level.firefly_main_quest.var_c05225eadb335d26[ key.type ] = key;
    return key;
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x4facadd4, Offset: 0x102a3
// Size: 0x82
function private function_553573b18e2f6b49( sbl_type )
{
    item_bundle = undefined;
    
    switch ( sbl_type )
    {
        case #"hash_9cdbafae6cb53df3":
            item_bundle = %"hash_6179ed4f60060afc";
            break;
        case #"hash_9cdbb0ae6cb53f86":
            item_bundle = %"hash_6179f04f60061015";
            break;
        case #"hash_9cdbb1ae6cb54119":
            item_bundle = %"hash_6179ef4f60060e62";
            break;
        default:
            break;
    }
    
    return item_bundle;
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x2e58794b, Offset: 0x1032e
// Size: 0x138
function private function_5d8a4281ec235ebe( sbl_type )
{
    level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] = undefined;
    
    if ( isalive( self ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        spawnoptions.var_fd47e835523b473f = 1;
        spawnoptions.var_9161cf0784b6951d = undefined;
        spawnoptions.critical = 1;
        item_bundle = function_553573b18e2f6b49( sbl_type );
        key = common_item::function_61c2c0251e742ffd( getscriptbundle( item_bundle ), 1, spawnoptions );
        level.firefly_main_quest.var_c05225eadb335d26[ key.type ] = key;
        key thread function_f965214455f44bc5();
    }
    else if ( self.last_valid_position )
    {
        s_spawn = spawnstruct();
        s_spawn.origin = utility::drop_to_ground( self.last_valid_position, 2 );
        key = function_59e087ed91183be9( s_spawn, sbl_type );
        key thread function_f965214455f44bc5();
    }
    else
    {
        level thread function_14a3a9705dd671cb( sbl_type );
    }
    
    level thread function_51f12524c830dd09();
    
    if ( level zm_quest::function_b0a5181ebe7bb905() && key )
    {
        key thread function_4d310fbc480aeb87( sbl_type );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x7478dd63, Offset: 0x1046e
// Size: 0x56
function private function_f965214455f44bc5()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level.firefly_main_quest.var_17cf20b23559c948[ self.type ] endon( #"MQ_STEP_10_SUBPART_COMPLETE" );
    wait 60;
    level thread function_14a3a9705dd671cb( self.type );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x3659e894, Offset: 0x104cc
// Size: 0xb2
function private function_68498104ae35531c( player )
{
    if ( player.var_57e070f1c0cc4a5f )
    {
        return;
    }
    
    level endon( #"game_ended" );
    assert( level.firefly_main_quest.var_17cf20b23559c948.size > 0, "<dev string:x7c>" );
    level.firefly_main_quest.var_17cf20b23559c948[ "zmloot_quest_firefly_k_1" ] endon( #"MQ_STEP_10_SUBPART_COMPLETE" );
    player function_b03d757fa8187f83();
    level thread function_51f12524c830dd09();
    player utility::waittill_any( "last_stand_enter", "death_or_disconnect" );
    
    if ( isalive( player ) )
    {
        player function_cecc199610ab0976();
    }
    
    player function_5d8a4281ec235ebe( "zmloot_quest_firefly_k_1" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x2687947, Offset: 0x10586
// Size: 0x144
function private function_b03d757fa8187f83()
{
    self.var_57e070f1c0cc4a5f = 1;
    zm_quest::function_b57dfe9625966b0b( #"misc", 0, #"key_1", 1, undefined, self );
    zm_quest::show_splash_item_picked_up( #"misc", #"key_1", 1, self );
    n_damage = ( self.maxhealth * 0.25 - self.health ) * -1;
    
    if ( n_damage > 0 )
    {
        self dodamage( n_damage, self.origin, self, self, "MOD_UNKNOWN", level.weaponnone, "none", undefined, 65536 );
    }
    
    callback::add( #"hash_11343ded26b4d165", &function_2c611904bcff4e9c );
    self setscriptablepartstate( "key_effect_fx_1", "key_fx_on", 0 );
    val::set( "mq_key_1", "killstreaks", 0 );
    val::set( "mq_key_1", "health_regen", 0 );
    val::set( "mq_key_1", "weapon_pickup", 0 );
    val::set( "mq_key_1", "disallow_weapon_wallbuy", 1 );
    val::set( "mq_key_1", "disallow_magicbox", 1 );
    thread function_5fcabfa7d8149c5d();
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"key_health", #"hash_5212ed7ec42f115a" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xed4ffc6c, Offset: 0x106d2
// Size: 0x67
function private function_cecc199610ab0976()
{
    self.var_57e070f1c0cc4a5f = 0;
    zm_quest::function_b57dfe9625966b0b( #"misc", 0, #"key_1", 0, undefined, self );
    self setscriptablepartstate( "key_effect_fx_1", "key_fx_off", 0 );
    val::reset_all( "mq_key_1" );
    callback::remove( #"hash_11343ded26b4d165", &function_2c611904bcff4e9c );
    self notify( #"hash_e9f8276fdda0c2cb" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xe7af04fd, Offset: 0x10741
// Size: 0x43
function private function_2c611904bcff4e9c( params )
{
    if ( params.source_string == level.fireflyww_basename && self.var_57e070f1c0cc4a5f )
    {
        self.var_a04128eb351415aa = self.health;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xd00e2467, Offset: 0x1078c
// Size: 0x1fc
function private function_5fcabfa7d8149c5d()
{
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"hash_e9f8276fdda0c2cb" );
    level.firefly_main_quest.var_17cf20b23559c948[ "zmloot_quest_firefly_k_1" ] endon( #"MQ_STEP_10_SUBPART_COMPLETE" );
    self.n_last_health = self.health;
    
    while ( true )
    {
        waitframe();
        
        if ( isdefined( self.var_a04128eb351415aa ) )
        {
            if ( self.health == self.var_a04128eb351415aa )
            {
                continue;
            }
            
            if ( self.health > self.var_a04128eb351415aa )
            {
                n_damage = self.health - self.var_a04128eb351415aa;
                self dodamage( n_damage, self.origin, level.firefly_main_quest.var_7a5aedd799c9d22b, self, "MOD_UNKNOWN", level.weaponnone, "none", undefined, 2 );
                continue;
            }
            
            if ( self.health < self.var_a04128eb351415aa && self.health > self.maxhealth * 0.25 )
            {
                self.var_a04128eb351415aa = self.health;
                continue;
            }
            
            if ( self.health < self.maxhealth * 0.25 )
            {
                self.var_a04128eb351415aa = undefined;
                self.n_last_health = self.health;
                continue;
            }
            
            continue;
        }
        
        if ( self.health > self.n_last_health )
        {
            n_damage = self.health - self.n_last_health;
            self dodamage( n_damage, self.origin, level.firefly_main_quest.var_7a5aedd799c9d22b, self, "MOD_UNKNOWN", level.weaponnone, "none", undefined, 2 );
        }
        
        self.n_last_health = self.health;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xcc6c92f4, Offset: 0x10990
// Size: 0x100
function private function_c29a993db8cb8975( player )
{
    if ( player.var_57e071f1c0cc4c92 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    assert( level.firefly_main_quest.var_17cf20b23559c948.size > 0, "<dev string:x7c>" );
    player function_3737085209210d04();
    level thread function_51f12524c830dd09();
    level.var_6be95cc530ecabed = level.var_449c32a0f392eed7;
    level.var_449c32a0f392eed7 = &function_ae0c89834822bbd0;
    player thread function_2257104c19efadbd();
    player utility::waittill_any( "last_stand_enter", "death_or_disconnect", "key_2_removed" );
    level.var_449c32a0f392eed7 = level.var_6be95cc530ecabed;
    level.var_6be95cc530ecabed = undefined;
    
    if ( !level.firefly_main_quest.var_17cf20b23559c948[ "zmloot_quest_firefly_k_2" ] utility::ent_flag( "MQ_STEP_10_SUBPART_COMPLETE" ) )
    {
        if ( isalive( player ) )
        {
            player function_8b0bb4dc5fa5b999();
        }
        
        player function_5d8a4281ec235ebe( "zmloot_quest_firefly_k_2" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x77786fcf, Offset: 0x10a98
// Size: 0x1b
function private function_ae0c89834822bbd0()
{
    if ( self.var_57e071f1c0cc4c92 )
    {
        zm_utility::function_663d59490abc834f();
    }
    
    return zm_laststand::function_3f7c6ebe141d8f06();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x1a357e87, Offset: 0x10abc
// Size: 0x15a
function private function_3737085209210d04()
{
    self.var_57e071f1c0cc4c92 = 1;
    zm_quest::function_b57dfe9625966b0b( #"misc", 0, #"key_2", 1, undefined, self );
    zm_quest::show_splash_item_picked_up( #"misc", #"key_2", 1, self );
    thread zm_utility::function_d47920bb0d5fa327( "firefly_mq_setkey2vals" );
    thread zm_utility::function_92275a9d3969d91d( undefined, undefined, 1, 1, 1 );
    supers_mp::clearsuper( 1 );
    self switchtoweapon( self.var_cc1262e66dbb1c79 );
    val::set( "mq_key_2", "supers", 0 );
    val::set( "mq_key_2", "killstreaks", 0 );
    val::set( "mq_key_2", "armor", 0 );
    val::set( "mq_key_2", "supers", 0 );
    val::set( "mq_key_2", "weapon_switch", 0 );
    val::set( "mq_key_2", "script_weapon_switch", 0 );
    val::set( "mq_key_2", "weapon_pickup", 0 );
    val::set( "mq_key_2", "allow_zm_perks", 0 );
    val::set( "mq_key_2", "disallow_weapon_wallbuy", 1 );
    val::set( "mq_key_2", "disallow_magicbox", 1 );
    self setscriptablepartstate( "key_effect_fx_2", "key_fx_on", 0 );
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"key_equipment", #"hash_5212ed7ec42f115a" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xdaf8db35, Offset: 0x10c1e
// Size: 0x66
function private function_8b0bb4dc5fa5b999()
{
    self.var_57e071f1c0cc4c92 = undefined;
    zm_quest::function_b57dfe9625966b0b( #"misc", 0, #"key_2", 0, undefined, self );
    
    if ( !self.inlaststand )
    {
        zm_utility::function_663d59490abc834f();
    }
    
    val::reset_all( "mq_key_2" );
    self setscriptablepartstate( "key_effect_fx_2", "key_fx_off", 0 );
    self notify( #"key_2_removed" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xe469a205, Offset: 0x10c8c
// Size: 0x179
function private function_2257104c19efadbd()
{
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"key_2_removed" );
    level.firefly_main_quest.var_17cf20b23559c948[ "zmloot_quest_firefly_k_2" ] endon( #"MQ_STEP_10_SUBPART_COMPLETE" );
    
    while ( true )
    {
        wait 30;
        primary_equip = item_equipment::function_ba3a484954eaadec( "primary" );
        
        if ( isdefined( primary_equip ) )
        {
            primary_item = getscriptbundle( primary_equip.name );
            var_dd68d4bea6f94a06 = equipment_mp::getequipmentmaxammo( primary_item.ref );
            primary_ammo = equipment_mp::getequipmentammo( primary_item.ref );
            
            if ( primary_ammo < var_dd68d4bea6f94a06 )
            {
                equipment_mp::setequipmentammo( primary_item.ref, primary_equip.count + 1 );
            }
        }
        
        secondary_equip = item_equipment::function_ba3a484954eaadec( "secondary" );
        
        if ( isdefined( secondary_equip ) )
        {
            secondary_item = getscriptbundle( secondary_equip.name );
            secondary_ammo_max = equipment_mp::getequipmentmaxammo( secondary_item.ref );
            secondary_ammo = equipment_mp::getequipmentammo( secondary_item.ref );
            
            if ( secondary_ammo < secondary_ammo_max )
            {
                equipment_mp::setequipmentammo( secondary_item.ref, secondary_equip.count + 1 );
            }
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x803b3079, Offset: 0x10e0d
// Size: 0xb2
function private function_1dbbcfc24a1187ca( player )
{
    if ( player.var_57e072f1c0cc4ec5 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    assert( level.firefly_main_quest.var_17cf20b23559c948.size > 0, "<dev string:x7c>" );
    level.firefly_main_quest.var_17cf20b23559c948[ "zmloot_quest_firefly_k_3" ] endon( #"MQ_STEP_10_SUBPART_COMPLETE" );
    player function_53918acfe30e0409();
    level thread function_51f12524c830dd09();
    player utility::waittill_any( "last_stand_enter", "death_or_disconnect" );
    
    if ( isalive( player ) )
    {
        player function_debeb29cf24f75d4();
    }
    
    player function_5d8a4281ec235ebe( "zmloot_quest_firefly_k_3" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x6c04a6a6, Offset: 0x10ec7
// Size: 0xbd
function private function_53918acfe30e0409()
{
    self.var_57e072f1c0cc4ec5 = 1;
    zm_quest::function_b57dfe9625966b0b( #"misc", 0, #"key_3", 1, undefined, self );
    zm_quest::show_splash_item_picked_up( #"misc", #"key_3", 1, self );
    val::set( "mq_key_3", "move_speed_scale", 0.5 );
    val::set( "mq_key_3", "cap_turn_rate", [ 100, 100 ] );
    val::set( "mq_key_3", "killstreaks", 0 );
    thread function_510f7a2c10b40900();
    self setscriptablepartstate( "key_effect_fx_3", "key_fx_on" );
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"key_slow", #"hash_5212ed7ec42f115a" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x38868a5c, Offset: 0x10f8c
// Size: 0x45
function private function_510f7a2c10b40900()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_a7990c2518e49751" );
    
    while ( true )
    {
        val::set( "mq_key_3", "move_speed_scale", 0.5 );
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xa43a8bf, Offset: 0x10fd9
// Size: 0x51
function private function_debeb29cf24f75d4()
{
    self.var_57e072f1c0cc4ec5 = undefined;
    zm_quest::function_b57dfe9625966b0b( #"misc", 0, #"key_3", 0, undefined, self );
    val::reset_all( "mq_key_3" );
    self setscriptablepartstate( "key_effect_fx_3", "key_fx_off" );
    self notify( #"hash_a7990c2518e49751" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x47b648, Offset: 0x11032
// Size: 0x2df
function private function_74a5f4f7efc4e675()
{
    level.firefly_main_quest.entity_box = spawnscriptable( "zm_sat_firefly_mq_box", level.var_209ed49971299121.origin, level.var_209ed49971299121.angles );
    minimap_state = level zm_sat_firefly::function_24006873400b7a8() ? "usable_minimap" : "usable";
    level.firefly_main_quest.entity_box setscriptablepartstate( "model", minimap_state );
    level.firefly_main_quest.entity_box.interact = interaction::register_scriptable_interact( level.firefly_main_quest.entity_box, &function_c7b79b18836624e, undefined, undefined, &function_dd772d0e085b334c );
    level.firefly_main_quest.entity_box.a_chains = [];
    a_s_chains = utility::getstructarray( "eb_c", "targetname" );
    
    foreach ( s_chain in a_s_chains )
    {
        chain = spawnscriptable( %"zm_sat_firefly_mq_box_chain", s_chain.origin, s_chain.angles );
        chain setscriptablepartstate( "model", "chain_" + s_chain.script_noteworthy );
        
        switch ( int( s_chain.script_noteworthy ) )
        {
            case 1:
                level.firefly_main_quest.entity_box.a_chains[ "zmloot_quest_firefly_k_1" ] = chain;
                break;
            case 2:
                level.firefly_main_quest.entity_box.a_chains[ "zmloot_quest_firefly_k_2" ] = chain;
                break;
            case 3:
                level.firefly_main_quest.entity_box.a_chains[ "zmloot_quest_firefly_k_3" ] = chain;
                break;
            default:
                break;
        }
    }
    
    if ( isdefined( level.firefly_main_quest.box_clip ) )
    {
        level.firefly_main_quest.box_clip disconnectpaths();
        level.firefly_main_quest.box_clip solid();
    }
    
    level utility::flag_set( "MQ_STEP_13_INITIALIZED" );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread function_cdcc7005abdac764();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x139b8302, Offset: 0x11319
// Size: 0xf7
function private function_cdcc7005abdac764()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "MQ_STEP_13_INITIALIZED" );
    
    while ( true )
    {
        if ( utility::flag( "observed_serum_changes_in_ashwood" ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, level.firefly_main_quest.entity_box.origin + ( -100, -1300, 0 ) ) < squared( 1400 ) )
            {
                utility::delaythread( 10, &function_6e299688e483faef );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xed3bbe2d, Offset: 0x11418
// Size: 0x1f
function private function_6e299688e483faef()
{
    level thread function_44485fe59fa069a1();
    level utility::flag_set( "observed_serum_changes_in_ashwood" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x6ab0dee8, Offset: 0x1143f
// Size: 0x118
function private function_44485fe59fa069a1()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "MQ_STEP_13_INITIALIZED" );
    
    while ( true )
    {
        if ( level utility::flag( "found_entity_box" ) )
        {
            return;
        }
        
        if ( !level.firefly_main_quest.entity_box )
        {
            level utility::flag_set( "found_entity_box" );
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( distancesquared( player.origin, level.firefly_main_quest.entity_box.origin ) < squared( 200 ) )
            {
                level utility::flag_set( "found_entity_box" );
                level thread function_51f12524c830dd09( 2 );
                return;
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x4fc933e4, Offset: 0x1155f
// Size: 0x106
function private function_dd772d0e085b334c( interact, player )
{
    if ( player.interactions_disabled || !level zm_sat_firefly::function_24006873400b7a8() || !zm_quest::function_f98968f17772726c( 1 ) || interact.b_in_use || level utility::flag( "opening_mq_entity_box" ) || level utility::flag( "MQ_STEP_10_COMPLETE" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( player.var_57e070f1c0cc4a5f || player.var_57e071f1c0cc4c92 || player.var_57e072f1c0cc4ec5 )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_firefly_post/mq_step_2_square", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xc21a45b3, Offset: 0x1166e
// Size: 0x27c
function private function_c7b79b18836624e( player )
{
    level endon( #"game_ended" );
    
    if ( self.b_in_use || level utility::flag( "opening_mq_entity_box" ) )
    {
        return;
    }
    
    self.b_in_use = 1;
    
    if ( player.var_57e070f1c0cc4a5f )
    {
        var_616bd8a7a7138618 = 1;
        level.firefly_main_quest.var_17cf20b23559c948[ "zmloot_quest_firefly_k_1" ] utility::ent_flag_set( "MQ_STEP_10_SUBPART_COMPLETE" );
        player function_cecc199610ab0976();
    }
    
    if ( player.var_57e071f1c0cc4c92 )
    {
        var_616bdba7a7138cb1 = 1;
        level.firefly_main_quest.var_17cf20b23559c948[ "zmloot_quest_firefly_k_2" ] utility::ent_flag_set( "MQ_STEP_10_SUBPART_COMPLETE" );
        player function_8b0bb4dc5fa5b999();
    }
    
    if ( player.var_57e072f1c0cc4ec5 )
    {
        var_616bdaa7a7138a7e = 1;
        level.firefly_main_quest.var_17cf20b23559c948[ "zmloot_quest_firefly_k_3" ] utility::ent_flag_set( "MQ_STEP_10_SUBPART_COMPLETE" );
        player function_debeb29cf24f75d4();
    }
    
    if ( var_616bd8a7a7138618 )
    {
        level.firefly_main_quest.entity_box.a_chains[ "zmloot_quest_firefly_k_1" ] function_3d9f052ca777da35( 1 );
    }
    
    if ( var_616bdba7a7138cb1 )
    {
        level.firefly_main_quest.entity_box.a_chains[ "zmloot_quest_firefly_k_2" ] function_3d9f052ca777da35( 2 );
    }
    
    if ( var_616bdaa7a7138a7e )
    {
        level.firefly_main_quest.entity_box.a_chains[ "zmloot_quest_firefly_k_3" ] function_3d9f052ca777da35( 3 );
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        var_cdb3da760ac24962 = 1;
        
        foreach ( var_ba39b89925cb2697 in level.firefly_main_quest.var_17cf20b23559c948 )
        {
            if ( !var_ba39b89925cb2697 utility::ent_flag( "MQ_STEP_10_SUBPART_COMPLETE" ) )
            {
                var_cdb3da760ac24962 = 0;
            }
        }
        
        if ( !var_cdb3da760ac24962 )
        {
            level thread function_51f12524c830dd09();
        }
    }
    
    level utility::flag_set( "mq_waiting_to_commence" );
    level function_193bc4cab35c87b9();
    self.b_in_use = 0;
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x674477f4, Offset: 0x118f2
// Size: 0x75
function private function_3d9f052ca777da35( chain_num )
{
    level endon( #"game_ended" );
    level utility::flag_waitopen( "entity_chain_break_in_progress" );
    level utility::flag_set( "entity_chain_break_in_progress" );
    self setscriptablepartstate( "material", "off" );
    self setscriptablepartstate( "vfx", "chain_" + chain_num );
    wait 1;
    self setscriptablepartstate( "model", "broken" );
    level utility::flag_clear( "entity_chain_break_in_progress" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x7621c09a, Offset: 0x1196f
// Size: 0xbf
function private function_193bc4cab35c87b9( b_skipped )
{
    if ( level utility::flag( "mid_igc_started" ) )
    {
        return;
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    foreach ( var_ba39b89925cb2697 in level.firefly_main_quest.var_17cf20b23559c948 )
    {
        if ( !var_ba39b89925cb2697 utility::ent_flag( "MQ_STEP_10_SUBPART_COMPLETE" ) )
        {
            return;
        }
    }
    
    level thread function_74386f8970bda9b( b_skipped );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x546b1811, Offset: 0x11a36
// Size: 0x3b8
function private function_74386f8970bda9b( b_skipped )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "MQ_STEP_10_COMPLETE" ) || level utility::flag( "opening_mq_entity_box" ) )
    {
        return;
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level utility::flag_set( "mq_guidance_delay_update_active" );
    }
    
    level utility::flag_set( "opening_mq_entity_box" );
    level utility::flag_set( "mid_igc_started" );
    level utility::flag_wait( "MQ_STEP_13_INITIALIZED" );
    wait 1;
    
    if ( !b_skipped )
    {
        function_e887612c6448b280();
        level utility::flag_wait( "mid_igc_completed" );
    }
    
    foreach ( player in level.players )
    {
        player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_firefly_artifact_4" );
    }
    
    if ( !b_skipped )
    {
        wait 1;
    }
    
    if ( b_skipped && level.firefly_main_quest.entity_box )
    {
        level.firefly_main_quest.entity_box freescriptable();
    }
    
    spawnoptions = common_item::function_bc5ff2958b71a708( level.var_209ed49971299121.origin );
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    level.firefly_main_quest.var_d5a2309951a61519 = common_item::function_61c2c0251e742ffd( %"hash_4cd553126f3209b7", 1, spawnoptions );
    level.firefly_main_quest.var_d5a2309951a61519.disable_dragged = 1;
    level.firefly_main_quest.var_d5a2309951a61519.origin = level.var_209ed49971299121.origin + ( 0, 0, 35 );
    level.firefly_main_quest.var_d5a2309951a61519 setscriptablepartstate( "zmloot_quest_firefly_pluto_mg_part", "bobbing" );
    level.firefly_main_quest.var_249df699cacaa6d3 = createnavobstaclebybounds( level.firefly_main_quest.var_d5a2309951a61519.origin, ( 20, 20, 75 ), level.firefly_main_quest.var_d5a2309951a61519.angles );
    level utility::flag_set( "MQ_STEP_10_COMPLETE" );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        utility::delaythread( 4, &utility::flag_clear, "mq_guidance_delay_update_active" );
        utility::delaythread( 4, &function_51f12524c830dd09 );
    }
    
    if ( level zm_sat_firefly::function_24006873400b7a8() )
    {
        level thread function_5b807a420708df84();
    }
    
    if ( isdefined( level.firefly_main_quest.var_7a5aedd799c9d22b ) )
    {
        level.firefly_main_quest.var_7a5aedd799c9d22b delete();
    }
    
    if ( isdefined( level.firefly_main_quest.box_clip ) )
    {
        level.firefly_main_quest.box_clip connectpaths();
        level.firefly_main_quest.box_clip notsolid();
    }
    
    level._fasttravel[ "override_jumppad_watchEnter" ] = level.firefly_main_quest.var_fdd3d0c6333d2bfe;
    level utility::flag_clear( "opening_mq_entity_box" );
    level thread function_e936285cbdeaaac9();
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x438452ae, Offset: 0x11df6
// Size: 0x1d2
function function_e887612c6448b280( params )
{
    zm_round_spawning::pause_round_spawning( 1, "main_quest_pause_spawning" );
    level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 1 );
    level thread zm_exfil::disable_zm_exfil( 1 );
    level musicbank_utility::function_4f253fd35ec68cbc( level.players );
    zm_quest::clear_all_guidance();
    var_fa751e910eae1648 = [ "zone_sunken_brothel_exterior" ];
    zm_quest::function_fe2a9a31ab8fbcab( var_fa751e910eae1648 );
    zm_blackhole_bomb::function_2a49f9fa9277a208( var_fa751e910eae1648 );
    utility::callsharedfunc( #"aether_shroud", #"hash_1273deb22f1e3ca2", var_fa751e910eae1648 );
    
    foreach ( player in level.players )
    {
        player utility::hidehudenable();
    }
    
    level thread common_item::cleanup_all_items();
    removeallcorpses();
    function_bd04c7a7423d895();
    
    foreach ( player in level.players )
    {
        if ( player.hidehudenabled == 1 )
        {
            player utility::hidehuddisable();
        }
    }
    
    level thread zm_exfil::disable_zm_exfil( 0 );
    zm_quest::function_765655c7699f9fb7();
    zm_blackhole_bomb::function_bcfc2c555363a3b5();
    utility::callsharedfunc( #"aether_shroud", #"hash_e34f2d0d3f7de38f", var_fa751e910eae1648 );
    level thread function_4340f0a56ae30f25();
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xe7038ecb, Offset: 0x11fd0
// Size: 0x530
function function_bd04c7a7423d895()
{
    level endon( #"game_ended" );
    level utility::flag_set( "progressing_mq_special_event" );
    level function_e4ec6c7611abdf7d();
    level.var_209ed49971299121 scene::pre_stream( undefined, undefined, undefined, "sat_cin_zm_fly_mid" );
    
    foreach ( player in level.players )
    {
        level thread game_utility::fadetoblackforplayer( player, 1, 0.5 );
    }
    
    wait 1;
    
    if ( level.firefly_main_quest.entity_box )
    {
        level.firefly_main_quest.entity_box freescriptable();
    }
    
    if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_ee3a6dc51896d3d8" ) )
    {
        level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_ee3a6dc51896d3d8" );
    }
    
    zm_sat_firefly_script_garage::function_d696b1e2e8b90e1d();
    level val::set( "trial_entity_igc", "task_logic_activate", 0 );
    overlord::function_f2fedd3be0be82ef();
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player thread function_411dee18c9cff509();
        }
        else if ( player.inlaststand )
        {
            player thread laststand::exit( "last_stand_self_revive" );
        }
        
        player setclienttriggeraudiozone( "zm_sat_firefly_igc" );
        player val::set( "mid_igc_scene", "killstreaks", 0 );
        player val::set( "mid_igc_scene", "damage", 0 );
        player val::set( "mid_igc_scene", "freezecontrols", 1 );
        player val::set( "mid_igc_scene", "allow_movement", 0 );
        player val::set( "mid_igc_scene", "ignoreme", 1 );
        player val::set( "mid_igc_scene", "ignore_afk", 1 );
        battlechatter_mp::disablebattlechatter( player );
    }
    
    a_igc_warp_loc = utility::getstruct( "igc_warp_loc_c" );
    
    foreach ( player in level.players )
    {
        level thread zm_fasttravel::function_cbb08198e7c84adf( a_igc_warp_loc, player, undefined, 0 );
    }
    
    start_load_time = gettime();
    
    while ( !function_cb3f113c9a5d56f7( "mp_infil_zm_sat_firefly_igc_tr" ) )
    {
        waitframe();
    }
    
    elapsed_time = ( gettime() - start_load_time ) * 0.001;
    time_to_wait = 2 - elapsed_time;
    playcinematicforall( "sat_cin_zm_fly_mid", 1 );
    
    if ( time_to_wait > 0 )
    {
        wait time_to_wait;
    }
    
    startnoninteractivesequence();
    
    foreach ( player in level.players )
    {
        utility::delaythread( 1, &game_utility::fadetoblackforplayer, player, 0, 0.5 );
    }
    
    if ( isdefined( level.var_209ed49971299121 ) )
    {
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"mid_igc" );
        level.var_209ed49971299121.var_685ee97bdd7a6dda = 1;
        level.var_209ed49971299121 scene::play( undefined, undefined, "sat_cin_zm_fly_mid" );
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"mid_igc" );
    
    foreach ( player in level.players )
    {
        player val::reset_all( "mid_igc_scene" );
        battlechatter_mp::enablebattlechatter( player );
        player clearclienttriggeraudiozone();
    }
    
    stopcinematicforall( 1, 1 );
    level val::reset( "trial_entity_igc", "task_logic_activate" );
    function_4d2cf7ef166227();
    level thread function_cfa603ae5c0c86a6();
    level utility::flag_set( "mid_igc_completed" );
    level utility::flag_clear( "progressing_mq_special_event" );
    level utility::flag_clear( "mq_waiting_to_commence" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x18d8432f, Offset: 0x12508
// Size: 0x18
function function_e4ec6c7611abdf7d()
{
    level notify( #"hash_52deb545a992b8d8" );
    loadinfiltransient( "mp_infil_zm_sat_firefly_igc_tr" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x481dd32, Offset: 0x12528
// Size: 0x25
function prestream_igc( prestream_time )
{
    level.var_209ed49971299121 scene::pre_stream( undefined, undefined, prestream_time, "sat_cin_zm_fly_outro" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xf6f7cc5a, Offset: 0x12555
// Size: 0x2a
function private function_cfa603ae5c0c86a6()
{
    level endon( #"game_ended" );
    level endon( #"hash_52deb545a992b8d8" );
    wait 12;
    unloadinfiltransient( "mp_infil_zm_sat_firefly_igc_tr" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x1d05fd3e, Offset: 0x12587
// Size: 0x109
function function_1fe986547a94d74b()
{
    foreach ( sceneobjectdata in self.scenedata.sceneobjectdata )
    {
        if ( sceneobjectdata.entity.animname == "entity" || sceneobjectdata.entity.animname == "entity_rear" )
        {
            sceneobjectdata.entity.team = "allies";
            sceneobjectdata.entity.var_2fc3a5fb762afb6e = 1;
            level notify( #"highvis_reload_outline", undefined, [ sceneobjectdata.entity ] );
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x940abf9d, Offset: 0x12698
// Size: 0x2
function function_3000fc7fba7d2d2f()
{
    
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x29042eee, Offset: 0x126a2
// Size: 0x2e
function function_411dee18c9cff509()
{
    self endon( #"disconnect" );
    self.var_14955bc056bab547 = 1;
    thread playerlogic::spawnclient();
    self waittill( #"spawned_player" );
    waittillframeend();
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xeeb124b1, Offset: 0x126d8
// Size: 0x3b
function function_4340f0a56ae30f25()
{
    level endon( #"game_ended" );
    wait 10;
    
    if ( level.var_a009ab14ee0d3223.isspecialround )
    {
        zm_round_logic::function_895fdc21ab019efe();
    }
    
    zm_round_spawning::pause_round_spawning( 0, "main_quest_pause_spawning" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x2b774c31, Offset: 0x1271b
// Size: 0x23
function private function_5b807a420708df84()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "mg_part_picked_up" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xd89fdc21, Offset: 0x12746
// Size: 0x83
function private function_e936285cbdeaaac9()
{
    level utility::flag_wait( "upgraded_pluto_to_stage_" + 4 );
    level thread function_51f12524c830dd09();
    
    if ( !level callback::exists( "mq_time_grabbed", &function_e3c24efa220d05ec ) )
    {
        level callback::add( "mq_time_grabbed", &function_e3c24efa220d05ec );
    }
    
    level.var_48cc97a1f94b97f4 = [];
    level.var_36d719ae538f565d = utility::getstructarray( "s_te_ct", "targetname" );
    level.time_collected = 0;
    level scriptable::scriptable_adddamagedcallback( &function_79097dca553af077 );
    level thread function_ded22ec0ce7772c2();
}

// Namespace zm_sat_firefly_script_mq
// Params 11, eflags: 0x4
// Checksum 0xf4b36c74, Offset: 0x127d1
// Size: 0x4ff
function private function_79097dca553af077( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type == "zm_sat_firefly_mq_b_clock" )
    {
        if ( objweapon.basename == "sat_pluto_dg2" )
        {
            if ( !level utility::flag( "time_grabbed" ) )
            {
                level.firefly_main_quest.time_save_state = utility::set_bit_flag( level.firefly_main_quest.time_save_state, 1 );
                level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"time_save", level.firefly_main_quest.time_save_state );
                level.firefly_main_quest.clock_tower setscriptablepartstate( "bc_vfx", "on" );
                level.firefly_main_quest.clock_tower setscriptablepartstate( "audio", "time_paused" );
                
                if ( !level utility::flag( "time_paused_1st_time" ) )
                {
                    level musicbank_utility::function_5aca66c390aa347d( level.players, #"stoptime" );
                    level utility::flag_set( "time_paused_1st_time" );
                }
                
                level utility::flag_set( "front_clock_paused" );
                level utility::flag_set( "back_clock_paused" );
                level utility::flag_set( "left_clock_paused" );
                level utility::flag_set( "right_clock_paused" );
                
                foreach ( struct in level.var_36d719ae538f565d )
                {
                    face = struct.script_label;
                    level.clock_vfx[ face ] = spawnscriptable( %"zm_sat_firefly_mq_t_essence", struct.origin, struct.angles );
                    level.clock_vfx[ face ].string = struct.script_label;
                    level.var_48cc97a1f94b97f4[ level.var_48cc97a1f94b97f4.size ] = level.clock_vfx[ face ];
                    level.clock_vfx[ face ] setscriptablepartstate( "bc_time", "vfx" );
                    level.clock_vfx[ face ] thread function_c117567b9ca92eff();
                    level.var_76c45cae2094c966[ level.var_76c45cae2094c966.size ] = level.clock_vfx[ face ];
                }
                
                playfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_75876c9ff261103b, "tag_origin" );
                playfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.ct_hhf, "tag_origin" );
                playfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587669ff2610309, "tag_origin" );
                playfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa979fbd31317a, "tag_origin" );
                playfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587609ff260f5d7, "tag_origin" );
                playfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa799fbd30ef80, "tag_origin" );
                playfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587709ff2611907, "tag_origin" );
                playfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa899fbd3112b0, "tag_origin" );
                level utility::flag_set( "time_grabbed" );
                level thread function_51f12524c830dd09();
                level.firefly_main_quest.time_grabbed_round = zm_round_logic::get_rb_round_number();
                
                if ( !level callback::exists( "on_round_end", &time_clear ) )
                {
                    level callback::add( "on_round_end", &time_clear );
                }
                
                level thread tedd_time_vo();
            }
            
            return;
        }
        
        if ( objweapon.basename == "sat_ww_firefly_zm" && !level utility::flag( "grace_shot" ) )
        {
            level thread function_5d68017a61bd7d32();
            return;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xd7149006, Offset: 0x12cd8
// Size: 0x1f
function function_5d68017a61bd7d32()
{
    level utility::flag_set( "grace_shot" );
    wait 5;
    level utility::flag_clear( "grace_shot" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xbf5ad358, Offset: 0x12cff
// Size: 0x88
function tedd_time_vo()
{
    self notify( #"hash_b6720cc00fb57e4d" );
    self endon( #"hash_b6720cc00fb57e4d" );
    
    if ( !level.wonder_veh.tedd.var_a60e28ae4bb8812c )
    {
        level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_4e00086db5cc3948", 1 );
        level.wonder_veh.tedd.var_a60e28ae4bb8812c = 1;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x3ca510e8, Offset: 0x12d8f
// Size: 0x61e
function private time_clear( params )
{
    level endon( #"game_ended" );
    level callback::remove( "on_round_end", &time_clear );
    
    if ( level utility::flag( "grace_shot" ) )
    {
        wait 6;
    }
    
    if ( !level utility::flag( "no_time_left" ) )
    {
        if ( isdefined( level.firefly_main_quest.clock_tower ) )
        {
            level.firefly_main_quest.clock_tower setscriptablepartstate( "bc_vfx", "off" );
            level.firefly_main_quest.clock_tower setscriptablepartstate( "audio", "time_paused_end" );
        }
        
        if ( isdefined( level.clock_vfx[ "back" ] ) )
        {
            level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "back" ] );
            level.clock_vfx[ "back" ] freescriptable();
        }
        
        if ( isdefined( level.clock_vfx[ "front" ] ) )
        {
            level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "front" ] );
            level.clock_vfx[ "front" ] freescriptable();
        }
        
        if ( isdefined( level.clock_vfx[ "right" ] ) )
        {
            level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "right" ] );
            level.clock_vfx[ "right" ] freescriptable();
        }
        
        if ( isdefined( level.clock_vfx[ "left" ] ) )
        {
            level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "left" ] );
            level.clock_vfx[ "left" ] freescriptable();
        }
        
        if ( level.firefly_main_quest.var_75876c9ff261103b )
        {
            stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_75876c9ff261103b, "tag_origin" );
        }
        
        if ( level.firefly_main_quest.ct_hhf )
        {
            stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.ct_hhf, "tag_origin" );
        }
        
        if ( level.firefly_main_quest.var_7587709ff2611907 )
        {
            stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587709ff2611907, "tag_origin" );
        }
        
        if ( level.firefly_main_quest.var_2cfa899fbd3112b0 )
        {
            stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa899fbd3112b0, "tag_origin" );
        }
        
        if ( level.firefly_main_quest.var_7587669ff2610309 )
        {
            stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587669ff2610309, "tag_origin" );
        }
        
        if ( level.firefly_main_quest.var_2cfa979fbd31317a )
        {
            stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa979fbd31317a, "tag_origin" );
        }
        
        if ( level.firefly_main_quest.var_7587609ff260f5d7 )
        {
            stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587609ff260f5d7, "tag_origin" );
        }
        
        if ( level.firefly_main_quest.var_2cfa799fbd30ef80 )
        {
            stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa799fbd30ef80, "tag_origin" );
        }
        
        if ( level utility::flag( "front_clock_paused" ) )
        {
            level utility::flag_clear( "front_clock_paused" );
            level thread function_4294d38c433ce8c8();
        }
        
        if ( level utility::flag( "back_clock_paused" ) )
        {
            level utility::flag_clear( "back_clock_paused" );
            level thread function_ec8d5a7ebbfc9a0c();
        }
        
        if ( level utility::flag( "left_clock_paused" ) )
        {
            level utility::flag_clear( "left_clock_paused" );
            level thread function_937dbd1392300a7e();
        }
        
        if ( level utility::flag( "right_clock_paused" ) )
        {
            level utility::flag_clear( "right_clock_paused" );
            level thread function_3e15fa2daf5f4b29();
        }
        
        level.var_48cc97a1f94b97f4 = [];
    }
    
    level utility::flag_clear( "time_grabbed" );
    level utility::flag_clear( "no_time_left" );
    level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 1 );
    level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 2 );
    level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 3 );
    level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 4 );
    level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 5 );
    level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 6 );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"time_save", level.firefly_main_quest.time_save_state );
    level.time_collected = 0;
    level.var_48cc97a1f94b97f4 = [];
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xc97b7602, Offset: 0x133b5
// Size: 0x42
function private function_c117567b9ca92eff()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::ent_flag_wait( "fireflyww_is_retrieved" );
    self setscriptablepartstate( "bc_time", "off" );
    level notify( #"mq_time_grabbed" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xca7e9f67, Offset: 0x133ff
// Size: 0x7c2
function private function_e3c24efa220d05ec( params )
{
    scriptable = params.object;
    player = params.player;
    
    if ( scriptable.type == "zm_sat_firefly_mq_t_essence" )
    {
        switch ( scriptable.string )
        {
            case #"hash_4b8799075d3a89b8":
                level.clock_vfx[ "front" ] setscriptablepartstate( "bc_time", "off" );
                stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_75876c9ff261103b, "tag_origin" );
                stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.ct_hhf, "tag_origin" );
                level utility::flag_clear( "front_clock_paused" );
                level thread function_4294d38c433ce8c8();
                level.time_collected++;
                level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "front" ] );
                level.firefly_main_quest.time_save_state = utility::set_bit_flag( level.firefly_main_quest.time_save_state, 2 );
                level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"time_save", level.firefly_main_quest.time_save_state );
                break;
            case #"hash_96815ce4f2a3dbc5":
                level.clock_vfx[ "right" ] setscriptablepartstate( "bc_time", "off" );
                stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587609ff260f5d7, "tag_origin" );
                stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa799fbd30ef80, "tag_origin" );
                level utility::flag_clear( "right_clock_paused" );
                level thread function_3e15fa2daf5f4b29();
                level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "right" ] );
                level.firefly_main_quest.time_save_state = utility::set_bit_flag( level.firefly_main_quest.time_save_state, 3 );
                level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"time_save", level.firefly_main_quest.time_save_state );
                level.time_collected++;
                break;
            case #"hash_c9b3133a17a3b2d0":
                level.clock_vfx[ "left" ] setscriptablepartstate( "bc_time", "off" );
                stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587669ff2610309, "tag_origin" );
                stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa979fbd31317a, "tag_origin" );
                level utility::flag_clear( "left_clock_paused" );
                level thread function_937dbd1392300a7e();
                level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "left" ] );
                level.firefly_main_quest.time_save_state = utility::set_bit_flag( level.firefly_main_quest.time_save_state, 4 );
                level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"time_save", level.firefly_main_quest.time_save_state );
                level.time_collected++;
                break;
            case #"hash_5163a22eb8c03302":
                level.clock_vfx[ "back" ] setscriptablepartstate( "bc_time", "off" );
                stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587709ff2611907, "tag_origin" );
                stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa899fbd3112b0, "tag_origin" );
                level utility::flag_clear( "back_clock_paused" );
                level thread function_ec8d5a7ebbfc9a0c();
                level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "back" ] );
                level.firefly_main_quest.time_save_state = utility::set_bit_flag( level.firefly_main_quest.time_save_state, 5 );
                level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"time_save", level.firefly_main_quest.time_save_state );
                level.time_collected++;
                break;
        }
        
        if ( level.time_collected == 4 )
        {
            level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 1 );
            level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 2 );
            level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 3 );
            level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 4 );
            level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 5 );
            level.firefly_main_quest.time_save_state = utility::set_bit_flag( level.firefly_main_quest.time_save_state, 6 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"time_save", level.firefly_main_quest.time_save_state );
            level.firefly_main_quest.clock_tower setscriptablepartstate( "bc_vfx", "off" );
            level.firefly_main_quest.clock_tower setscriptablepartstate( "audio", "time_paused_end" );
            level utility::flag_set( "no_time_left" );
        }
        
        player setscriptablepartstate( "time_essence_fx", "time_fx_on", 0 );
        player.time_carrier = 1;
        
        if ( !level zm_quest::function_b0a5181ebe7bb905() )
        {
            player thread function_6bec0b63f79e2d71();
        }
        
        if ( !player callback::exists( "ww_missle_fired", &time_release ) )
        {
            player callback::add( "ww_missle_fired", &time_release );
        }
        
        if ( !player callback::exists( #"player_item_drop", &drop_time ) )
        {
            player callback::add( #"player_item_drop", &drop_time );
        }
        
        if ( !level utility::flag( "time_vo" ) )
        {
            player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"collect_time", #"bc_flavor_player_positive" );
            level utility::flag_set( "time_vo" );
        }
        
        if ( isdefined( player ) && !level utility::flag( "rt_head_rotation_complete" ) && !level utility::flag( "rt_complete" ) )
        {
            player thread function_28037398e39c4d1c( level.farm_clock_trigger );
        }
        
        level thread function_51f12524c830dd09();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x61965fee, Offset: 0x13bc9
// Size: 0x18a
function private time_release( params )
{
    player = params.player;
    end_direction = params.projectile.origin + anglestoforward( params.projectile.angles ) * 1000;
    ee_weapon = makeweapon( utility::get_scripted_weapon_name( #"hash_1e765889611cc1d3" ) );
    player.projectile = weapon_utility::_magicbullet( ee_weapon, params.projectile.origin, end_direction, player );
    player.projectile thread function_81da43d0a5ac6407();
    params.projectile delete();
    new_params = spawnstruct();
    new_params = { #player:params.player, #projectile:level.projectile };
    callback::callback( "ww_magic_missile_fired", new_params );
    
    if ( player.time_carrier == 1 )
    {
        player setscriptablepartstate( "time_essence_fx", "time_fx_deactivate", 0 );
        player.projectile.time_charged = 1;
        player callback::remove( "ww_missle_fired", &time_release );
        level notify( #"time_released" );
        waitframe();
        player.time_carrier = 0;
    }
    
    level utility::delaythread( 1.5, &function_51f12524c830dd09 );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x3b5fa99b, Offset: 0x13d5b
// Size: 0x96
function private drop_time( params )
{
    waitframe();
    
    if ( !( isdefined( params ) && isdefined( params.item.weaponobj ) ) )
    {
        return;
    }
    
    if ( params.weaponobj.basename != "sat_ww_firefly_zm" )
    {
        return;
    }
    
    callback::remove( #"player_item_drop", &drop_time );
    self setscriptablepartstate( "time_essence_fx", "time_fx_deactivate", 0 );
    callback::remove( "ww_missle_fired", &time_release );
    self.time_carrier = 0;
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x2a7366f1, Offset: 0x13df9
// Size: 0x117
function private function_81da43d0a5ac6407()
{
    level endon( #"game_ended" );
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    fx_model = spawn( "script_model", self.origin );
    fx_model.angles = self.angles;
    fx_model linkto( self );
    fx_model setmodel( %"wpn_sat_wm_ww_firefly_spike" );
    fx_model setscriptablepartstate( "vfx", "trail_time" );
    self waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    fx_model delete();
    var_d8c7a0fac844e6b = spawnscriptable( %"scriptable_ww_firefly_impact", position, vectortoangles( normal ) );
    var_d8c7a0fac844e6b utility::function_7c10ea82c1e305b8( "impact", "impact_time" );
    utility::delaythread( 0.1, &destroy_projectile, var_d8c7a0fac844e6b );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xb48ab00, Offset: 0x13f18
// Size: 0x2a
function private delay_endon( string )
{
    level endon( #"game_ended" );
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x9cb809f6, Offset: 0x13f4a
// Size: 0x22
function private destroy_projectile( var_d8c7a0fac844e6b )
{
    if ( self )
    {
        self delete();
    }
    
    if ( var_d8c7a0fac844e6b )
    {
        var_d8c7a0fac844e6b freescriptable();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x85f8cf9b, Offset: 0x13f74
// Size: 0x5d
function function_6bec0b63f79e2d71()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"time_released" );
    wait 90;
    self setscriptablepartstate( "time_essence_fx", "time_fx_deactivate", 0 );
    callback::remove( "ww_missle_fired", &time_release );
    self.time_carrier = 0;
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x8bd390bf, Offset: 0x13fd9
// Size: 0x2ad
function private complete_rituals_setup( b_skipped, b_save_restored )
{
    level.var_a1ec83b385e3b000 = [];
    level.var_212b532b587fd4cd = level.firefly_main_quest.var_9569ed39e1646d45.angles;
    level.firefly_main_quest.rituals_complete = 0;
    
    if ( !level callback::exists( "zone_changed", &function_725b491b402ab242 ) )
    {
        level callback::add( "zone_changed", &function_725b491b402ab242 );
    }
    
    if ( !level callback::exists( #"player_death", &function_15a8e8376444928e ) )
    {
        level callback::add( #"player_death", &function_15a8e8376444928e );
    }
    
    if ( !level callback::exists( #"player_disconnect", &function_15a8e8376444928e ) )
    {
        level callback::add( #"player_disconnect", &function_15a8e8376444928e );
    }
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        level scriptable::scriptable_adddamagedcallback( &storm_lamp );
        level.var_32aa4f629e3bd2b9 = [];
        level.var_df04f7aec829e67a = utility::getstructarray( "e_lp_spawn", "targetname" );
        level.a_lamps = [];
        level.var_749849e3d61e0cca = spawnscriptable( "sat_zm_firefly_mq_lp_vfx", level.var_df04f7aec829e67a[ 0 ].origin, level.var_df04f7aec829e67a[ 0 ].angles );
        level.a_lamps[ level.a_lamps.size ] = level.var_749849e3d61e0cca;
        level.var_749848e3d61e0a97 = spawnscriptable( "sat_zm_firefly_mq_lp_vfx", level.var_df04f7aec829e67a[ 1 ].origin, level.var_df04f7aec829e67a[ 1 ].angles );
        level.a_lamps[ level.a_lamps.size ] = level.var_749848e3d61e0a97;
        level.var_749847e3d61e0864 = spawnscriptable( "sat_zm_firefly_mq_lp_vfx", level.var_df04f7aec829e67a[ 2 ].origin, level.var_df04f7aec829e67a[ 2 ].angles );
        level.a_lamps[ level.a_lamps.size ] = level.var_749847e3d61e0864;
        level.var_bbbc25946f465a87 = level.a_lamps;
        level.lamp_on = utility::array_random( level.var_bbbc25946f465a87 );
        level.lamp_on setscriptablepartstate( "sparks", "sparks" );
        level.lamp_on.active = 1;
        level.var_bbbc25946f465a87 = arrayremove( level.var_bbbc25946f465a87, level.lamp_on );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xf85179ef, Offset: 0x1428e
// Size: 0x15
function private complete_rituals_cleanup( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x7fd5aafe, Offset: 0x142ab
// Size: 0x92b
function function_ded22ec0ce7772c2()
{
    level.firefly_main_quest.time_save_state = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"time_save" ) ?? 0;
    time_paused = utility::get_bit_flag( level.firefly_main_quest.time_save_state, 1 );
    front_face = utility::get_bit_flag( level.firefly_main_quest.time_save_state, 2 );
    right_face = utility::get_bit_flag( level.firefly_main_quest.time_save_state, 3 );
    left_face = utility::get_bit_flag( level.firefly_main_quest.time_save_state, 4 );
    back_face = utility::get_bit_flag( level.firefly_main_quest.time_save_state, 5 );
    time_locked = utility::get_bit_flag( level.firefly_main_quest.time_save_state, 6 );
    
    if ( time_locked )
    {
        level callback::add( "on_round_end", &time_clear );
        level.firefly_main_quest.time_grabbed_round = zm_round_logic::get_rb_round_number();
        level utility::flag_set( "time_grabbed" );
        level utility::flag_set( "no_time_left" );
        level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 1 );
        level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 2 );
        level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 3 );
        level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 4 );
        level.firefly_main_quest.time_save_state = utility::function_911d2d3c6d773726( level.firefly_main_quest.time_save_state, 5 );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"time_save", level.firefly_main_quest.time_save_state );
        return;
    }
    
    if ( time_paused )
    {
        level.firefly_main_quest.clock_tower setscriptablepartstate( "bc_vfx", "on" );
        level.firefly_main_quest.clock_tower setscriptablepartstate( "audio", "time_paused" );
        level utility::flag_set( "front_clock_paused" );
        level utility::flag_set( "back_clock_paused" );
        level utility::flag_set( "left_clock_paused" );
        level utility::flag_set( "right_clock_paused" );
        
        foreach ( struct in level.var_36d719ae538f565d )
        {
            face = struct.script_label;
            level.clock_vfx[ face ] = spawnscriptable( %"zm_sat_firefly_mq_t_essence", struct.origin, struct.angles );
            level.clock_vfx[ face ].string = struct.script_label;
            level.var_48cc97a1f94b97f4[ level.var_48cc97a1f94b97f4.size ] = level.clock_vfx[ face ];
            level.clock_vfx[ face ] setscriptablepartstate( "bc_time", "vfx" );
            level.clock_vfx[ face ] thread function_c117567b9ca92eff();
            level.var_76c45cae2094c966[ level.var_76c45cae2094c966.size ] = level.clock_vfx[ face ];
        }
        
        playfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_75876c9ff261103b, "tag_origin" );
        playfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.ct_hhf, "tag_origin" );
        playfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587669ff2610309, "tag_origin" );
        playfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa979fbd31317a, "tag_origin" );
        playfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587609ff260f5d7, "tag_origin" );
        playfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa799fbd30ef80, "tag_origin" );
        playfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587709ff2611907, "tag_origin" );
        playfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa899fbd3112b0, "tag_origin" );
        level thread function_51f12524c830dd09();
        level utility::flag_set( "time_grabbed" );
        level.firefly_main_quest.time_grabbed_round = zm_round_logic::get_rb_round_number();
        
        if ( !level callback::exists( "on_round_end", &time_clear ) )
        {
            level callback::add( "on_round_end", &time_clear );
        }
    }
    
    if ( front_face )
    {
        level.clock_vfx[ "front" ] setscriptablepartstate( "bc_time", "off" );
        stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_75876c9ff261103b, "tag_origin" );
        stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.ct_hhf, "tag_origin" );
        level utility::flag_clear( "front_clock_paused" );
        level thread function_4294d38c433ce8c8();
        level.time_collected++;
        level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "front" ] );
    }
    
    if ( right_face )
    {
        level.clock_vfx[ "right" ] setscriptablepartstate( "bc_time", "off" );
        stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587609ff260f5d7, "tag_origin" );
        stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa799fbd30ef80, "tag_origin" );
        level utility::flag_clear( "right_clock_paused" );
        level thread function_3e15fa2daf5f4b29();
        level.time_collected++;
        level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "right" ] );
    }
    
    if ( left_face )
    {
        level.clock_vfx[ "left" ] setscriptablepartstate( "bc_time", "off" );
        stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587669ff2610309, "tag_origin" );
        stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa979fbd31317a, "tag_origin" );
        level utility::flag_clear( "left_clock_paused" );
        level thread function_937dbd1392300a7e();
        level.time_collected++;
        level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "left" ] );
    }
    
    if ( back_face )
    {
        level.clock_vfx[ "back" ] setscriptablepartstate( "bc_time", "off" );
        stopfxontag( level._effect[ #"clock_m_fx" ], level.firefly_main_quest.var_7587709ff2611907, "tag_origin" );
        stopfxontag( level._effect[ #"hash_701a58b956f014c9" ], level.firefly_main_quest.var_2cfa899fbd3112b0, "tag_origin" );
        level utility::flag_clear( "back_clock_paused" );
        level thread function_ec8d5a7ebbfc9a0c();
        level.time_collected++;
        level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.clock_vfx[ "back" ] );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xd8e70c94, Offset: 0x14bde
// Size: 0x68
function function_4350df6f8255caf6()
{
    if ( level.firefly_main_quest.rituals_complete == 1 )
    {
        level thread overlord::playevent( #"hash_fde6764903be6c9c", level.players );
    }
    
    if ( level.firefly_main_quest.rituals_complete == 4 )
    {
        level thread overlord::playevent( #"hash_63e2cd853e7be086", level.players );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x4f1f9788, Offset: 0x14c4e
// Size: 0x1f5
function function_725b491b402ab242( params )
{
    foreach ( player in level.players )
    {
        player.var_77898ab40e53d0ae = player zone_manager::get_current_zone();
        
        if ( player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115_close_to_launchpad" || player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115_close_to_sunken" )
        {
            if ( !level utility::flag( "exit_react" ) )
            {
                level utility::flag_set( "exit_react" );
                function_1007da3875deb276( player, "Exit_react", "Exit_react_response", 0, undefined, 100, 2 );
                break;
            }
        }
        
        if ( player.var_77898ab40e53d0ae.script_zone_name == "zone_launchpad_control_room" )
        {
            if ( !level utility::flag( "launchpad_react" ) )
            {
                level utility::flag_set( "launchpad_react" );
                function_1007da3875deb276( player, "launch_react", "launch_react_response", 0, undefined, 100, 2 );
                break;
            }
        }
        
        if ( player.var_77898ab40e53d0ae.script_zone_name == "zone_farm_house" )
        {
            if ( !level utility::flag( "farm_react" ) )
            {
                level utility::flag_set( "farm_react" );
                level thread function_1007da3875deb276( self, "farm_family", "farm_family_response", 0, undefined, 100, 2 );
                break;
            }
        }
    }
    
    if ( level utility::flag( "launchpad_react" ) && level utility::flag( "exit_react" ) && level utility::flag( "farm_react" ) )
    {
        level callback::remove( "zone_changed", &function_725b491b402ab242 );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 7, eflags: 0x4
// Checksum 0xd151acfb, Offset: 0x14e4b
// Size: 0x2d4
function private function_1007da3875deb276( player, var_d9a98ad3b14f016a, banter_alt, wait_time, flag, response_percent_chance = 100, var_4f2bf94274a798ed = 5 )
{
    if ( !isdefined( flag ) || !level utility::flag( flag ) )
    {
        primary_player = player;
        vo_radius = getplayersinradius( player.origin, 500 );
        var_db75d3de862ce072 = primary_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_d9a98ad3b14f016a + "_1" );
        
        if ( var_db75d3de862ce072 )
        {
            wait var_4f2bf94274a798ed;
            
            if ( utility::percent_chance( response_percent_chance ) )
            {
                foreach ( player in vo_radius )
                {
                    br_played = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( banter_alt + "_1" );
                    
                    if ( br_played )
                    {
                        break;
                    }
                }
            }
            
            if ( flag )
            {
                level utility::flag_set( flag );
                wait wait_time;
                level utility::flag_clear( flag );
            }
            
            return;
        }
        
        var_db75d3de862ce072 = primary_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_d9a98ad3b14f016a + "_2" );
        
        if ( var_db75d3de862ce072 )
        {
            wait var_4f2bf94274a798ed;
            
            if ( utility::percent_chance( response_percent_chance ) )
            {
                foreach ( player in vo_radius )
                {
                    br_played = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( banter_alt + "_2" );
                    
                    if ( br_played )
                    {
                        break;
                    }
                }
            }
            
            if ( flag )
            {
                level utility::flag_set( flag );
                wait wait_time;
                level utility::flag_clear( flag );
            }
            
            return;
        }
        
        var_db75d3de862ce072 = primary_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_d9a98ad3b14f016a + "_3" );
        
        if ( var_db75d3de862ce072 )
        {
            wait var_4f2bf94274a798ed;
            
            if ( utility::percent_chance( response_percent_chance ) )
            {
                foreach ( player in vo_radius )
                {
                    br_played = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( banter_alt + "_3" );
                    
                    if ( br_played )
                    {
                        break;
                    }
                }
            }
            
            if ( flag )
            {
                level utility::flag_set( flag );
                wait wait_time;
                level utility::flag_clear( flag );
            }
            
            return;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x36e036c5, Offset: 0x15128
// Size: 0x1e6
function private function_f901e1d9d88d74c3()
{
    level utility::flag_wait( "mq_asset_setup_complete" );
    var_d2739718bc8585c2 = utility::getstructarray( "rot_tme_start", "targetname" );
    var_3f705b3aed7a7111 = [ level.firefly_main_quest.var_77bb8e15d0471db0, level.firefly_main_quest.var_77bb9115d0472449, level.firefly_main_quest.var_77bb9015d0472216, level.firefly_main_quest.var_77bb9315d04728af ];
    
    for ( i = 0; i < var_d2739718bc8585c2.size ; i++ )
    {
        var_9f317e2cacb9bffe = var_d2739718bc8585c2[ i ];
        s_rt_item = var_3f705b3aed7a7111[ i ];
        s_rt_item function_18683c611198a2c8( var_9f317e2cacb9bffe.origin, var_9f317e2cacb9bffe.angles );
        var_1594b9fd2eb465fd = s_rt_item.tme_sbl;
        var_1594b9fd2eb465fd.path_array = [ var_9f317e2cacb9bffe.origin ];
        var_9f317e2cacb9bffe.targetname += i;
        s_rt_item.target = var_9f317e2cacb9bffe.targetname;
        var_ed92d3edd3eded9 = var_9f317e2cacb9bffe;
        
        for ( ;; )
        {
            if ( !var_ed92d3edd3eded9.target )
            {
                break;
            }
            
            var_ed92d3edd3eded9 = utility::getstruct( var_ed92d3edd3eded9.target, "targetname" );
            var_1594b9fd2eb465fd.path_array[ var_1594b9fd2eb465fd.path_array.size ] = var_ed92d3edd3eded9.origin;
        }
        
        var_1594b9fd2eb465fd.path_array[ var_1594b9fd2eb465fd.path_array.size ] = var_9f317e2cacb9bffe.origin;
        s_rt_item thread function_4c537fac1c57d014( "MQ_STEP_16_SUBPART_1_PART_2_COMPLETE", 5 );
    }
    
    level utility::flag_set( "rt_tme_sbls_spawned" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x94f8b8ce, Offset: 0x15316
// Size: 0x6c1
function private function_201d089e46387d58( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "rt_complete" );
        level thread farm_intel();
        return;
    }
    
    level.firefly_main_quest.var_76aaaf4d5507ab79 = spawnscriptable( "zm_sat_firefly_mq_farm_torture_audio", level.firefly_main_quest.var_9569ed39e1646d45.origin );
    level.var_db53d39d8f26eea6 = [];
    level.var_29cf8c224f0a42fa = [];
    level.a_ritual_items = [];
    level.firefly_main_quest.rot_save_state = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_100cd5e55825b63b" ) ?? 0;
    level.head_knocked = utility::get_bit_flag( level.firefly_main_quest.rot_save_state, 1 );
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level.var_df2a8da022fc5734 = utility::get_bit_flag( level.firefly_main_quest.rot_save_state, 2 );
        level.var_e313801fe8f146af = utility::get_bit_flag( level.firefly_main_quest.rot_save_state, 3 );
        level.var_4255117970ca664a = utility::get_bit_flag( level.firefly_main_quest.rot_save_state, 4 );
        level.var_48456d449e950b2d = utility::get_bit_flag( level.firefly_main_quest.rot_save_state, 5 );
        
        if ( level.var_df2a8da022fc5734 )
        {
            level.firefly_main_quest.var_de842018558c1466.sbl = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de842018558c1466.origin, level.firefly_main_quest.var_de842018558c1466.angles );
            level.firefly_main_quest.var_4e5b08d3ee427851 = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de842018558c1466.origin + ( 0, 0, 50 ), level.firefly_main_quest.var_de842018558c1466.angles );
            zm_quest::function_b57dfe9625966b0b( #"Ritual", 0, #"ritual_1", 1 );
            level.firefly_main_quest utility::ent_flag_set( "rt_item_1_collected" );
            function_a7117b7813b261b0( level.firefly_main_quest.var_4e5b08d3ee427851, "interact_rc_1" );
        }
        
        if ( level.var_e313801fe8f146af )
        {
            level.firefly_main_quest.var_de841f18558c1233.sbl = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de841f18558c1233.origin, level.firefly_main_quest.var_de841f18558c1233.angles );
            level.firefly_main_quest.var_f05f94c5e1dfa1c4 = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de841f18558c1233.origin + ( 0, 0, 50 ), level.firefly_main_quest.var_de841f18558c1233.angles );
            zm_quest::function_b57dfe9625966b0b( #"Ritual", 0, #"ritual_2", 1 );
            level.firefly_main_quest utility::ent_flag_set( "rt_item_2_collected" );
            function_a7117b7813b261b0( level.firefly_main_quest.var_f05f94c5e1dfa1c4, "interact_rc_2" );
        }
        
        if ( level.var_4255117970ca664a )
        {
            level.firefly_main_quest.var_de841e18558c1000.sbl = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de841e18558c1000.origin, level.firefly_main_quest.var_de841e18558c1000.angles );
            level.firefly_main_quest.var_ded52789b883e433 = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de841e18558c1000.origin + ( 0, 0, 50 ), level.firefly_main_quest.var_de841e18558c1000.angles );
            zm_quest::function_b57dfe9625966b0b( #"Ritual", 0, #"ritual_3", 1 );
            level.firefly_main_quest utility::ent_flag_set( "rt_item_3_collected" );
            function_a7117b7813b261b0( level.firefly_main_quest.var_ded52789b883e433, "interact_rc_3" );
        }
        
        if ( level.var_48456d449e950b2d )
        {
            level.firefly_main_quest.var_de842518558c1f65.sbl = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de842518558c1f65.origin, level.firefly_main_quest.var_de842518558c1f65.angles );
            level.firefly_main_quest.var_938dbd62de96e0d6 = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de842518558c1f65.origin + ( 0, 0, 50 ), level.firefly_main_quest.var_de842518558c1f65.angles );
            zm_quest::function_b57dfe9625966b0b( #"Ritual", 0, #"ritual_4", 1 );
            level.firefly_main_quest utility::ent_flag_set( "rt_item_4_collected" );
            function_a7117b7813b261b0( level.firefly_main_quest.var_938dbd62de96e0d6, "interact_rc_4" );
        }
        
        if ( level.head_knocked )
        {
            level utility::flag_set( "rt_head_rotation_complete" );
            level.firefly_main_quest utility::ent_flag_set( "knock_head" );
            level utility::flag_set( "no_tme" );
            level.firefly_main_quest.var_9569ed39e1646d45 setscriptablepartstate( "vfx", "on" );
            level callback::remove( #"player_death", &function_15a8e8376444928e );
            level callback::remove( #"player_disconnect", &function_15a8e8376444928e );
            function_63e3ed862924333b();
        }
    }
    
    level utility::flag_wait( "rt_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xc4948807, Offset: 0x159df
// Size: 0x54
function farm_intel()
{
    level utility::flag_wait( "begin_round_logic" );
    var_7ea2915f82ff9c54 = utility::getstruct( "firefly_audiolog_2" );
    vandorn_family_intel = intel::spawn_intel_at_location( undefined, undefined, var_7ea2915f82ff9c54.origin, var_7ea2915f82ff9c54.angles, "zmintel_sat_firefly_audiolog_2", undefined );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xda2c617b, Offset: 0x15a3b
// Size: 0x40f
function private function_28037398e39c4d1c( trigger )
{
    self endon( #"time_released" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    rt_starting_time = utility::function_6f5d2e1f1ff70482( gettime() );
    progress = 0;
    level.var_a1ec83b385e3b000 = function_5713d46873b29625( level.var_a1ec83b385e3b000 );
    level.var_f73f3bdb090ed79 = 0;
    
    if ( !level.var_a1ec83b385e3b000 )
    {
        return;
    }
    
    while ( isalive( self ) && self.time_carrier == 1 && !level utility::flag( "rt_head_rotation_complete" ) )
    {
        wait 1;
        
        if ( progress >= 10 )
        {
            level.firefly_main_quest.var_9569ed39e1646d45 setscriptablepartstate( "vfx", "on" );
            level.firefly_main_quest.var_9569ed39e1646d45 stoploopsound();
            level.firefly_main_quest.var_9569ed39e1646d45 playsound( #"hash_995ca21a47acf974" );
            level utility::flag_set( "rt_head_rotation_complete" );
            level thread function_51f12524c830dd09();
            break;
        }
        
        a_players_in_radius = getplayersinradius( trigger.origin, 25 );
        
        if ( arraycontains( a_players_in_radius, self ) && !arraycontains( level.var_a1ec83b385e3b000, self ) )
        {
            level.var_a1ec83b385e3b000[ level.var_a1ec83b385e3b000.size ] = self;
        }
        else if ( isdefined( level.var_a1ec83b385e3b000 ) && !arraycontains( a_players_in_radius, self ) && arraycontains( level.var_a1ec83b385e3b000, self ) )
        {
            level.var_a1ec83b385e3b000 = arrayremove( level.var_a1ec83b385e3b000, self );
            continue;
        }
        
        if ( level.var_a1ec83b385e3b000.size >= 1 )
        {
            level.firefly_main_quest.var_9569ed39e1646d45 rotateby( level.var_1a21ca402bc88876, 1 );
            progress += 1;
            level thread function_51f12524c830dd09();
            
            if ( !level.var_f73f3bdb090ed79 )
            {
                level.var_f73f3bdb090ed79 = 1;
                level.firefly_main_quest.var_9569ed39e1646d45 playsound( #"hash_d9a31263267d146d" );
                level.firefly_main_quest.var_9569ed39e1646d45 playloopsound( #"hash_41ee57821edd6333" );
            }
            
            continue;
        }
        
        if ( !level utility::flag( "rt_head_rotation_complete" ) && level.var_a1ec83b385e3b000.size == 0 && level.var_212b532b587fd4cd != level.firefly_main_quest.var_9569ed39e1646d45.angles )
        {
            level.firefly_main_quest.var_9569ed39e1646d45 rotateto( level.var_212b532b587fd4cd, 0.1 );
            
            if ( progress > 0 )
            {
                progress = 0;
            }
            
            level thread function_51f12524c830dd09();
            
            if ( level.var_f73f3bdb090ed79 )
            {
                level.var_f73f3bdb090ed79 = 0;
                level.firefly_main_quest.var_9569ed39e1646d45 stoploopsound();
                level.firefly_main_quest.var_9569ed39e1646d45 playsound( #"hash_38701b9cf37e8b93" );
            }
            
            continue;
        }
        
        continue;
    }
    
    if ( level utility::flag( "rt_head_rotation_complete" ) )
    {
        if ( !level callback::exists( "ww_magic_missile_fired", &function_65ce0f744e1a2f3f ) )
        {
            level callback::add( "ww_magic_missile_fired", &function_65ce0f744e1a2f3f );
        }
        
        return;
    }
    
    level.firefly_main_quest.var_9569ed39e1646d45 rotateto( level.var_212b532b587fd4cd, 0.1 );
    progress = 0;
    level.var_a1ec83b385e3b000 = arrayremove( level.var_a1ec83b385e3b000, self );
    level.var_a1ec83b385e3b000 = function_5713d46873b29625( level.var_a1ec83b385e3b000 );
    level.var_f73f3bdb090ed79 = 0;
    level.firefly_main_quest.var_9569ed39e1646d45 stoploopsound();
    level.firefly_main_quest.var_9569ed39e1646d45 playsound( #"hash_38701b9cf37e8b93" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x2939876a, Offset: 0x15e52
// Size: 0x1ac
function private function_65ce0f744e1a2f3f( sparams )
{
    projectile = sparams.projectile;
    player = sparams.player;
    
    if ( !isalive( player ) || !player.time_carrier || level.firefly_main_quest utility::ent_flag( "knock_head" ) )
    {
        return;
    }
    
    level.firefly_main_quest notify( #"hash_3c5da4f990b4beaa" );
    level.firefly_main_quest endon( #"hash_3c5da4f990b4beaa" );
    player.projectile endon( #"hash_fbf7ba582ad61604" );
    player.projectile endon( #"delay_death" );
    player.projectile endon( #"death" );
    player endon( #"death_or_disconnect" );
    player.projectile waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( !ispointinvolume( player.projectile.origin, level.firefly_main_quest.vol_head, 1 ) )
    {
        return;
    }
    
    level.firefly_main_quest utility::ent_flag_set( "knock_head" );
    level utility::flag_set( "MQ_STEP_16_SUBPART_1_PART_2_COMPLETE" );
    level thread function_51f12524c830dd09();
    level thread function_63e3ed862924333b( player );
    player.projectile delete();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x9efcbf5a, Offset: 0x16006
// Size: 0x3be
function private function_63e3ed862924333b( player )
{
    level.firefly_main_quest.var_9569ed39e1646d45 rotateto( level.firefly_main_quest.var_9569ed39e1646d45.angles - ( 0, 0, 60 ), 0.1 );
    level.firefly_main_quest.var_9569ed39e1646d45 setscriptablepartstate( "vfx_react", "on" );
    playsoundatpos( level.firefly_main_quest.var_9569ed39e1646d45.origin, #"hash_4dfff0c703c0cad7" );
    
    if ( isdefined( level.firefly_main_quest.var_76aaaf4d5507ab79 ) )
    {
        level.firefly_main_quest.var_76aaaf4d5507ab79 setscriptablepartstate( "audio", "skull_vfx" );
    }
    
    level callback::remove( "ww_missle_fired", &function_65ce0f744e1a2f3f );
    level callback::remove( #"player_death", &function_15a8e8376444928e );
    level callback::remove( #"player_disconnect", &function_15a8e8376444928e );
    level thread farm_intel();
    level.firefly_main_quest.var_77bb8e15d0471db0 thread function_25bd9f7ae6026d2( %"hash_7d2704e9eeaef57b", level.firefly_main_quest utility::ent_flag( "rt_item_1_collected" ) );
    level.firefly_main_quest.var_77bb9115d0472449 utility::delaythread( 0.5, &function_25bd9f7ae6026d2, %"hash_7d2705e9eeaef72e", level.firefly_main_quest utility::ent_flag( "rt_item_2_collected" ) );
    level.firefly_main_quest.var_77bb9015d0472216 utility::delaythread( 1, &function_25bd9f7ae6026d2, %"hash_7d2706e9eeaef8e1", level.firefly_main_quest utility::ent_flag( "rt_item_3_collected" ) );
    level.firefly_main_quest.var_77bb9315d04728af utility::delaythread( 1.5, &function_25bd9f7ae6026d2, %"hash_7d2707e9eeaefa94", level.firefly_main_quest utility::ent_flag( "rt_item_4_collected" ) );
    
    if ( !level.head_knock )
    {
        if ( isdefined( player ) )
        {
            player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"shoot_head", #"hash_5212ed7ec42f115a" );
        }
        
        level.firefly_main_quest.rot_save_state = utility::set_bit_flag( level.firefly_main_quest.rot_save_state, 1 );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_100cd5e55825b63b", level.firefly_main_quest.rot_save_state );
        wait 4;
        a_players = arrayrandomize( level.players );
        
        foreach ( player in a_players )
        {
            var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_9f015df2aa505095" );
            
            if ( var_db75d3de862ce072 )
            {
                return;
            }
        }
        
        foreach ( player in a_players )
        {
            var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_9f015df2aa505095", #"hash_5212ed7ec42f115a" );
            
            if ( var_db75d3de862ce072 )
            {
                return;
            }
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x30dfe743, Offset: 0x163cc
// Size: 0x108
function function_15a8e8376444928e( sparams )
{
    player = sparams.victim ?? self;
    
    if ( arraycontains( level.var_a1ec83b385e3b000, player ) )
    {
        level.var_a1ec83b385e3b000 = arrayremove( level.var_a1ec83b385e3b000, player );
    }
    
    if ( level.var_a1ec83b385e3b000.size == 0 && level.var_212b532b587fd4cd != level.firefly_main_quest.var_9569ed39e1646d45.angles )
    {
        level.firefly_main_quest.var_9569ed39e1646d45 rotateto( level.var_212b532b587fd4cd, 0.1 );
        level thread function_51f12524c830dd09();
        
        if ( level.var_f73f3bdb090ed79 )
        {
            level.var_f73f3bdb090ed79 = 0;
            level.firefly_main_quest.var_9569ed39e1646d45 stoploopsound();
            level.firefly_main_quest.var_9569ed39e1646d45 playsound( #"hash_38701b9cf37e8b93" );
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x1297f378, Offset: 0x164dc
// Size: 0x300
function private function_25bd9f7ae6026d2( item, flag )
{
    if ( flag )
    {
        level utility::flag_wait( "rt_tme_sbls_spawned" );
        self.tme_sbl.linkedparent notify( #"stop_curve" );
        self.tme_sbl.linkedparent notify( #"stop_pathing" );
        self.tme_sbl utility::function_32b24db3127bff40( "body", "hide" );
        return;
    }
    
    if ( !self.sbl && self.tme_sbl.linkedparent && !level utility::flag( "no_tme" ) )
    {
        level utility::flag_wait( "rt_tme_sbls_spawned" );
        self.tme_sbl.linkedparent notify( #"stop_curve" );
        self.tme_sbl.linkedparent notify( #"off_bezier_curve" );
        self.tme_sbl utility::function_32b24db3127bff40( "body", "pathing" );
        self.tme_sbl.linkedparent moveto( level.firefly_main_quest.var_898dc8ebeafff41c, 1, 1 );
        wait 1.025;
        self.tme_sbl.linkedparent utility::follow_spiral( 15, 45, ( 0, 0, 1 ), 45, 3, level.firefly_main_quest.var_898dc8ebeafff41c, 3 );
        path_array = [ self.tme_sbl.linkedparent.origin, self.origin ];
        self.tme_sbl.linkedparent utility::function_2159dd4196ff4b81( path_array, 1.5, 1, 1, 1, 1, 0.2 );
        self.tme_sbl utility::function_32b24db3127bff40( "body", "hide" );
    }
    
    if ( !flag )
    {
        level utility::flag_wait( "rt_tme_sbls_spawned" );
        self.tme_sbl.linkedparent notify( #"stop_curve" );
        self.tme_sbl.linkedparent notify( #"stop_pathing" );
        self.tme_sbl utility::function_32b24db3127bff40( "body", "hide" );
        s_collectable = self;
        spawnoptions = common_item::function_bc5ff2958b71a708( s_collectable.origin, s_collectable.angles );
        spawnoptions.var_fd47e835523b473f = 1;
        spawnoptions.dropradiusscale = 0;
        spawnoptions.critical = 1;
        self.sbl = common_item::function_61c2c0251e742ffd( item, 1, spawnoptions );
        self.sbl.disable_dragged = 1;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x60e2e4b, Offset: 0x167e4
// Size: 0x26a
function private function_a7c97c1f5482a147( player )
{
    if ( !level.firefly_main_quest utility::ent_flag( "rt_item_1_collected" ) )
    {
        level.firefly_main_quest utility::ent_flag_set( "rt_item_1_collected" );
        level.firefly_main_quest.var_de842018558c1466.sbl = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de842018558c1466.origin, level.firefly_main_quest.var_de842018558c1466.angles );
        level.firefly_main_quest.var_de842018558c1466.sbl setscriptablepartstate( "rc_b", "visible" );
        level.firefly_main_quest.var_de842018558c1466.sbl setscriptablepartstate( "audio", "default" );
        var_7ea8519f47a09d18 = level zm_sat_firefly::function_24006873400b7a8() ? "rc_b_ping" : "off";
        level.firefly_main_quest.var_de842018558c1466.sbl setscriptablepartstate( "ping", var_7ea8519f47a09d18 );
        zm_quest::function_b57dfe9625966b0b( #"Ritual", 0, #"ritual_1", 1 );
        zm_quest::show_splash_item_picked_up( #"Ritual", #"ritual_1", 1, player );
        thread function_1007da3875deb276( player, "pick_up_head", "pick_up_head_response", 30, "rt_item" );
        level.firefly_main_quest.var_4e5b08d3ee427851 = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de842018558c1466.origin + ( 0, 0, 50 ), level.firefly_main_quest.var_de842018558c1466.angles );
        var_87976ac560cb18e6 = level zm_sat_firefly::function_24006873400b7a8() ? "on_visable_rt_1" : "st_visable_rt_1";
        level.firefly_main_quest.var_4e5b08d3ee427851 setscriptablepartstate( "interact_rc_1", var_87976ac560cb18e6 );
        level.firefly_main_quest.var_4e5b08d3ee427851 scriptable::scriptable_addusedcallbackbypart( "interact_rc_1", &function_a7117b7813b261b0 );
        level thread function_51f12524c830dd09();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x82eb1087, Offset: 0x16a56
// Size: 0x26a
function private function_834050021a3b54a2( player )
{
    if ( !level.firefly_main_quest utility::ent_flag( "rt_item_2_collected" ) )
    {
        level.firefly_main_quest utility::ent_flag_set( "rt_item_2_collected" );
        level.firefly_main_quest.var_de841f18558c1233.sbl = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de841f18558c1233.origin, level.firefly_main_quest.var_de841f18558c1233.angles );
        level.firefly_main_quest.var_de841f18558c1233.sbl setscriptablepartstate( "rc_m", "visible" );
        level.firefly_main_quest.var_de841f18558c1233.sbl setscriptablepartstate( "audio", "default" );
        var_7ea8519f47a09d18 = level zm_sat_firefly::function_24006873400b7a8() ? "rc_m_ping" : "off";
        level.firefly_main_quest.var_de841f18558c1233.sbl setscriptablepartstate( "ping", var_7ea8519f47a09d18 );
        zm_quest::function_b57dfe9625966b0b( #"Ritual", 0, #"ritual_2", 1 );
        zm_quest::show_splash_item_picked_up( #"Ritual", #"ritual_2", 1, player );
        thread function_1007da3875deb276( player, "pick_up_mask", "pick_up_mask_response", 30, "rt_item" );
        level.firefly_main_quest.var_f05f94c5e1dfa1c4 = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de841f18558c1233.origin + ( 0, 0, 50 ), level.firefly_main_quest.var_de841f18558c1233.angles );
        var_5096a5df4a62a4d1 = level zm_sat_firefly::function_24006873400b7a8() ? "on_visable_rt_2" : "st_visable_rt_2";
        level.firefly_main_quest.var_f05f94c5e1dfa1c4 setscriptablepartstate( "interact_rc_2", var_5096a5df4a62a4d1 );
        level.firefly_main_quest.var_f05f94c5e1dfa1c4 scriptable::scriptable_addusedcallbackbypart( "interact_rc_2", &function_a7117b7813b261b0 );
        level thread function_51f12524c830dd09();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x9f09a801, Offset: 0x16cc8
// Size: 0x26a
function private function_cd839ef2d57e8d2d( player )
{
    if ( !level.firefly_main_quest utility::ent_flag( "rt_item_3_collected" ) )
    {
        level.firefly_main_quest utility::ent_flag_set( "rt_item_3_collected" );
        level.firefly_main_quest.var_de841e18558c1000.sbl = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de841e18558c1000.origin, level.firefly_main_quest.var_de841e18558c1000.angles );
        level.firefly_main_quest.var_de841e18558c1000.sbl setscriptablepartstate( "rc_w", "visible" );
        level.firefly_main_quest.var_de841e18558c1000.sbl setscriptablepartstate( "audio", "default" );
        var_7ea8519f47a09d18 = level zm_sat_firefly::function_24006873400b7a8() ? "rc_w_ping" : "off";
        level.firefly_main_quest.var_de841e18558c1000.sbl setscriptablepartstate( "ping", var_7ea8519f47a09d18 );
        zm_quest::function_b57dfe9625966b0b( #"Ritual", 0, #"ritual_3", 1 );
        zm_quest::show_splash_item_picked_up( #"Ritual", #"ritual_3", 1, player );
        thread function_1007da3875deb276( player, "pick_up_goblet", "pick_up_goblet_response", 30, "rt_item" );
        level.firefly_main_quest.var_ded52789b883e433 = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de841e18558c1000.origin + ( 0, 0, 50 ), level.firefly_main_quest.var_de841e18558c1000.angles );
        var_8492870c3b841184 = level zm_sat_firefly::function_24006873400b7a8() ? "on_visable_rt_3" : "st_visable_rt_3";
        level.firefly_main_quest.var_ded52789b883e433 setscriptablepartstate( "interact_rc_3", var_8492870c3b841184 );
        level.firefly_main_quest.var_ded52789b883e433 scriptable::scriptable_addusedcallbackbypart( "interact_rc_3", &function_a7117b7813b261b0 );
        level thread function_51f12524c830dd09();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xc8b2417e, Offset: 0x16f3a
// Size: 0x26a
function private function_41350fde921f6048( player )
{
    if ( !level.firefly_main_quest utility::ent_flag( "rt_item_4_collected" ) )
    {
        level.firefly_main_quest utility::ent_flag_set( "rt_item_4_collected" );
        level.firefly_main_quest.var_de842518558c1f65.sbl = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de842518558c1f65.origin, level.firefly_main_quest.var_de842518558c1f65.angles );
        level.firefly_main_quest.var_de842518558c1f65.sbl setscriptablepartstate( "rc_r", "visible" );
        level.firefly_main_quest.var_de842518558c1f65.sbl setscriptablepartstate( "audio", "default" );
        var_7ea8519f47a09d18 = level zm_sat_firefly::function_24006873400b7a8() ? "rc_r_ping" : "off";
        level.firefly_main_quest.var_de842518558c1f65.sbl setscriptablepartstate( "ping", var_7ea8519f47a09d18 );
        zm_quest::function_b57dfe9625966b0b( #"Ritual", 0, #"ritual_4", 1 );
        zm_quest::show_splash_item_picked_up( #"Ritual", #"ritual_4", 1, player );
        thread function_1007da3875deb276( player, "pick_up_razor", "pick_up_razor_response", 30, "rt_item" );
        level.firefly_main_quest.var_938dbd62de96e0d6 = spawnscriptable( %"zm_sat_firefly_mq_rc", level.firefly_main_quest.var_de842518558c1f65.origin + ( 0, 0, 50 ), level.firefly_main_quest.var_de842518558c1f65.angles );
        var_672e0a8c431b48c7 = level zm_sat_firefly::function_24006873400b7a8() ? "on_visable_rt_4" : "st_visable_rt_4";
        level.firefly_main_quest.var_938dbd62de96e0d6 setscriptablepartstate( "interact_rc_4", var_672e0a8c431b48c7 );
        level.firefly_main_quest.var_938dbd62de96e0d6 scriptable::scriptable_addusedcallbackbypart( "interact_rc_4", &function_a7117b7813b261b0 );
        level thread function_51f12524c830dd09();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 6, eflags: 0x4
// Checksum 0xc309d8a3, Offset: 0x171ac
// Size: 0x951
function private function_a7117b7813b261b0( instance, part, state, user, bautouse, usestring )
{
    instance setscriptablepartstate( part, "off" );
    level.var_db53d39d8f26eea6[ level.var_db53d39d8f26eea6.size ] = instance;
    level thread function_51f12524c830dd09();
    
    switch ( part )
    {
        case #"hash_bbfa264dc4ecdc3c":
            s_rr = utility::getstruct( "s_rt_i_loc_4", "targetname" );
            level.ritual_razor = spawnscriptable( %"sat_zm_firefly_mq_r_r", s_rr.origin, s_rr.angles );
            level.ritual_razor setscriptablepartstate( "anim", "intro_pose" );
            level.ritual_razor setscriptablepartstate( "vfx", "on" );
            level.firefly_main_quest.var_de842518558c1f65.sbl setscriptablepartstate( "rc_r", "active" );
            level.var_f5c5a92c500e3a8 = utility::spawn_model( "tag_origin", level.ritual_razor.origin, level.ritual_razor.angles );
            waitframe();
            level.ritual_razor utility::scriptable_setparententity( level.var_f5c5a92c500e3a8 );
            level.ritual_razor.starting_position = s_rr.origin;
            level.ritual_razor.starting_angles = s_rr.angles;
            level.firefly_main_quest.var_de842518558c1f65.sbl setscriptablepartstate( "audio", "item_placed" );
            level.a_ritual_items[ level.a_ritual_items.size ] = level.ritual_razor;
            level.firefly_main_quest.rot_save_state = utility::set_bit_flag( level.firefly_main_quest.rot_save_state, 5 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_100cd5e55825b63b", level.firefly_main_quest.rot_save_state );
            break;
        case #"hash_bbfa254dc4ecdaa9":
            s_rg = utility::getstruct( "s_rt_i_loc_3", "targetname" );
            level.ritual_goblet = spawnscriptable( %"sat_zm_firefly_mq_r_g", s_rg.origin, s_rg.angles );
            level.ritual_goblet setscriptablepartstate( "anim", "intro_pose" );
            level.ritual_goblet setscriptablepartstate( "vfx", "on" );
            level.firefly_main_quest.var_de841e18558c1000.sbl setscriptablepartstate( "rc_w", "active" );
            level.var_32df94767768d511 = utility::spawn_model( "tag_origin", level.ritual_goblet.origin, level.ritual_goblet.angles );
            waitframe();
            level.ritual_goblet utility::scriptable_setparententity( level.var_32df94767768d511 );
            level.ritual_goblet.starting_position = s_rg.origin;
            level.ritual_goblet.starting_angles = s_rg.angles;
            level.firefly_main_quest.var_de841e18558c1000.sbl setscriptablepartstate( "audio", "item_placed" );
            level.a_ritual_items[ level.a_ritual_items.size ] = level.ritual_goblet;
            level.firefly_main_quest.rot_save_state = utility::set_bit_flag( level.firefly_main_quest.rot_save_state, 4 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_100cd5e55825b63b", level.firefly_main_quest.rot_save_state );
            break;
        case #"hash_bbfa244dc4ecd916":
            s_rm = utility::getstruct( "s_rt_i_loc_2", "targetname" );
            level.ritual_mask = spawnscriptable( %"sat_zm_firefly_mq_r_m", s_rm.origin, s_rm.angles );
            level.ritual_mask setscriptablepartstate( "anim", "intro_pose" );
            level.ritual_mask setscriptablepartstate( "vfx", "on" );
            level.firefly_main_quest.var_de841f18558c1233.sbl setscriptablepartstate( "rc_m", "active" );
            level.var_ba11de82dd667d10 = utility::spawn_model( "tag_origin", level.ritual_mask.origin, level.ritual_mask.angles );
            waitframe();
            level.ritual_mask utility::scriptable_setparententity( level.var_ba11de82dd667d10 );
            level.ritual_mask.starting_position = s_rm.origin;
            level.ritual_mask.starting_angles = s_rm.angles;
            level.firefly_main_quest.var_de841f18558c1233.sbl setscriptablepartstate( "audio", "item_placed" );
            level.a_ritual_items[ level.a_ritual_items.size ] = level.ritual_mask;
            level.firefly_main_quest.rot_save_state = utility::set_bit_flag( level.firefly_main_quest.rot_save_state, 3 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_100cd5e55825b63b", level.firefly_main_quest.rot_save_state );
            break;
        case #"hash_bbfa234dc4ecd783":
            s_rb = utility::getstruct( "s_rt_i_loc_1", "targetname" );
            level.ritual_bear = spawnscriptable( "sat_zm_firefly_mq_r_b", s_rb.origin, s_rb.angles );
            level.ritual_bear setscriptablepartstate( "anim", "intro_pose" );
            level.ritual_bear setscriptablepartstate( "vfx", "on" );
            level.firefly_main_quest.var_de842018558c1466.sbl setscriptablepartstate( "rc_b", "active" );
            level.var_2a618cd6835f0f46 = utility::spawn_model( "tag_origin", level.ritual_bear.origin, level.ritual_bear.angles );
            waitframe();
            level.ritual_bear utility::scriptable_setparententity( level.var_2a618cd6835f0f46 );
            level.ritual_bear.starting_position = s_rb.origin;
            level.ritual_bear.starting_angles = s_rb.angles;
            level.firefly_main_quest.var_de842018558c1466.sbl setscriptablepartstate( "audio", "item_placed" );
            level.a_ritual_items[ level.a_ritual_items.size ] = level.ritual_bear;
            level.firefly_main_quest.rot_save_state = utility::set_bit_flag( level.firefly_main_quest.rot_save_state, 2 );
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_100cd5e55825b63b", level.firefly_main_quest.rot_save_state );
            break;
    }
    
    if ( level.a_ritual_items.size == 4 )
    {
        foreach ( item in level.a_ritual_items )
        {
            item setscriptablepartstate( "anim", "intro" );
        }
        
        level.firefly_main_quest.var_d6b80ced7b65f870 = spawnscriptable( %"zm_sat_firefly_mq_rc", instance.origin + ( 0, 0, 25 ), instance.angles );
        var_58a4bebd7e076b37 = level zm_sat_firefly::function_24006873400b7a8() ? "on_visable_rt_trial" : "st_visable_rt_trial";
        level.firefly_main_quest.var_d6b80ced7b65f870 setscriptablepartstate( "interact_rt_trial", var_58a4bebd7e076b37 );
        level.firefly_main_quest.var_d6b80ced7b65f870 scriptable::scriptable_addusedcallbackbypart( "interact_rt_trial", &function_9d7f338bea4a1634 );
        level thread function_51f12524c830dd09();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 6, eflags: 0x4
// Checksum 0x12b1cd9a, Offset: 0x17b05
// Size: 0x318
function private function_9d7f338bea4a1634( instance, part, state, user, bautouse, usestring )
{
    instance setscriptablepartstate( part, "off" );
    
    foreach ( player in level.players )
    {
        zonename = player zone_manager::get_current_zone();
        
        if ( arraycontains( [ "zone_farm", "zone_farm_house", "zone_farm_barn", "zone_farm_garage", "zone_farm_cellar", "zone_farm_road", "zone_farm_gate", "zone_farm_rear", "zone_farm_close_to_sunken", "zone_farm_close_to_tower" ], zonename.script_zone_name ) )
        {
            player playlocalsound( #"hash_2125bffc03127285" );
            level musicbank_utility::function_5aca66c390aa347d( player, #"hash_649d3177969ffc6" );
        }
    }
    
    level thread function_76edbb488fd7c887();
    level thread function_63738c201e7386e6();
    level thread defend_timer();
    level thread function_cc06ffe65806d316();
    level utility::flag_set( "rt_trial_started" );
    level notify( #"rt_trial_started" );
    level.firefly_main_quest.var_d6b80ced7b65f870 scriptable::function_369a834929711390( "interact_rt_trial", &function_9d7f338bea4a1634 );
    quest_ref = function_dc6a8903cbb1d35a() ? #"firefly_mq_guidance" : #"sat_zm_quest_firefly_ui";
    
    if ( quest_ref == #"sat_zm_quest_firefly_ui" )
    {
        if ( level.firefly_main_quest.var_f2b547d6a287fbb6 )
        {
            level thread function_bfbfce5dc21fb78d();
        }
        else
        {
            level.firefly_main_quest.var_f2b547d6a287fbb6 = #"hash_50883e8403ecf4a7";
            level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"sat_zm_quest_firefly_ui", #"hash_50883e8403ecf4a7" );
            level zm_quest::function_fb3af5600f6a9441( 2, 1, #"sat_zm_quest_firefly_ui", #"hash_50883e8403ecf4a7" );
        }
    }
    
    level thread function_51f12524c830dd09();
    
    if ( function_dc6a8903cbb1d35a() && zm_quest::get_quest_step( #"firefly_mq", #"hash_4c25b1fbd9b6e496" ).completed && zm_quest::get_quest_step( #"firefly_mq", #"hash_42ce0ef6b3f2cf17" ).completed || level.firefly_main_quest.var_f2b547d6a287fbb6 == #"hash_50883e8403ecf4a7" )
    {
        wait 1;
        level zm_quest::function_9f49b2a045ece8ae( 30, 1, quest_ref, #"hash_50883e8403ecf4a7" );
        level zm_quest::function_612a9ad0db22c29c( 75000, 1, quest_ref, #"hash_50883e8403ecf4a7" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xd590d853, Offset: 0x17e25
// Size: 0xef
function private function_bfbfce5dc21fb78d()
{
    level endon( #"game_ended" );
    level endon( #"rt_encounter_failure" );
    level endon( #"hash_2e9f51d6eed522e5" );
    
    while ( level.firefly_main_quest.var_f2b547d6a287fbb6 )
    {
        wait 1;
    }
    
    wait 1;
    level.firefly_main_quest.var_f2b547d6a287fbb6 = #"hash_50883e8403ecf4a7";
    level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"sat_zm_quest_firefly_ui", #"hash_50883e8403ecf4a7" );
    level zm_quest::function_fb3af5600f6a9441( 2, 1, #"sat_zm_quest_firefly_ui", #"hash_50883e8403ecf4a7" );
    level zm_quest::function_9f49b2a045ece8ae( 30, 1, #"sat_zm_quest_firefly_ui", #"hash_50883e8403ecf4a7" );
    level zm_quest::function_612a9ad0db22c29c( level.firefly_main_quest.var_5c68d2161d372b58 * 1000, 1, #"sat_zm_quest_firefly_ui", #"hash_50883e8403ecf4a7" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x9df764f7, Offset: 0x17f1c
// Size: 0x48
function function_cc06ffe65806d316()
{
    if ( !level.firefly_main_quest.var_4b25e80f6ee62b44 )
    {
        level.firefly_main_quest.var_4b25e80f6ee62b44 = 1;
        overlord::playevent( #"hash_5a4955666e4ba96e", level.players );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x308afcfd, Offset: 0x17f6c
// Size: 0x1d8
function private defend_timer()
{
    level endon( #"rt_encounter_failure" );
    level endon( #"hash_2e9f51d6eed522e5" );
    var_c9ae47efdea43238 = 75;
    var_427b3d2c2f8fb546 = utility::function_6f5d2e1f1ff70482( gettime() );
    
    do
    {
        wait 1;
        time_passed = utility::function_6f5d2e1f1ff70482( gettime() ) - var_427b3d2c2f8fb546;
        level.firefly_main_quest.var_5c68d2161d372b58 = var_c9ae47efdea43238 - time_passed;
    }
    while ( time_passed < var_c9ae47efdea43238 );
    
    if ( level utility::flag( "rt_encounter_failure" ) )
    {
        return;
    }
    
    level utility::flag_set( "rt_complete" );
    level utility::flag_set( "rt_ui_complete" );
    
    foreach ( player in level.players )
    {
        zonename = player zone_manager::get_current_zone();
        
        if ( arraycontains( [ "zone_farm", "zone_farm_house", "zone_farm_barn", "zone_farm_garage", "zone_farm_cellar", "zone_farm_road", "zone_farm_gate", "zone_farm_rear", "zone_farm_close_to_sunken", "zone_farm_close_to_tower" ], zonename.script_zone_name ) )
        {
            player playlocalsound( #"hash_666b64e7557da10c" );
            level musicbank_utility::function_5aca66c390aa347d( player, #"hash_404cb80acbd9291b" );
            continue;
        }
        
        level musicbank_utility::function_4f253fd35ec68cbc( player, #"hash_649d3177969ffc6" );
    }
    
    cleanup_rt_encounter();
    level notify( #"hash_2e9f51d6eed522e5" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x395793d1, Offset: 0x1814c
// Size: 0x9e6
function private function_76edbb488fd7c887()
{
    level.firefly_main_quest.ritual_item_health = 30;
    level.ritual_razor.linkedparent.attractor = zombie_attractor_manager::add_attractor( level.ritual_razor.linkedparent, 1, 1000, 1, undefined, &function_99fb0b5303877adf );
    zombie_attractor_manager::function_1497469a46932be2( level.ritual_razor.linkedparent.attractor, level.ritual_razor.origin, level.ritual_razor.angles, 75, 4 );
    zombie_attractor_manager::function_4c34b0f066a9d9fe( level.ritual_razor.linkedparent.attractor, 360 );
    zombie_attractor_manager::function_a2aab3762aaa055f( level.ritual_razor.linkedparent.attractor, level.ritual_razor.origin + ( 0, 0, 25 ), ( 40, 40, 75 ), level.ritual_razor.angles );
    level.ritual_razor.linkedparent.health_point = 0;
    level.ritual_razor.linkedparent setcandamage( 1 );
    level.ritual_razor.linkedparent thread function_e178b741508bf2f0();
    level.var_ce3bf6f569913dd2 = createnavobstaclebybounds( level.ritual_razor.origin, ( 35, 35, 35 ), level.ritual_razor.angles );
    level.ritual_razor.linkedparent moveto( level.ritual_razor.origin + ( 0, 0, 75 ), 45 );
    level.ritual_razor setscriptablepartstate( "anim", "loop" );
    level.ritual_razor.ritual_circle = level.firefly_main_quest.var_de842518558c1f65.sbl;
    level.ritual_razor.ritual_circle.part = "rc_r";
    level.ritual_razor.ritual_circle setscriptablepartstate( "audio", "ritual_start" );
    level.ritual_bear.linkedparent.attractor = zombie_attractor_manager::add_attractor( level.ritual_bear.linkedparent, 1, 1000, 1, undefined, &function_99fb0b5303877adf );
    zombie_attractor_manager::function_1497469a46932be2( level.ritual_bear.linkedparent.attractor, level.ritual_bear.origin, level.ritual_bear.angles, 75, 4 );
    zombie_attractor_manager::function_4c34b0f066a9d9fe( level.ritual_bear.linkedparent.attractor, 360 );
    zombie_attractor_manager::function_a2aab3762aaa055f( level.ritual_bear.linkedparent.attractor, level.ritual_bear.origin + ( 0, 0, 25 ), ( 40, 40, 75 ), level.ritual_bear.angles );
    level.ritual_bear.linkedparent.health_point = 0;
    level.ritual_bear.linkedparent thread function_e178b741508bf2f0();
    level.var_1e19cd77076ce240 = createnavobstaclebybounds( level.ritual_bear.origin, ( 35, 35, 35 ), level.ritual_bear.angles );
    level.ritual_bear.linkedparent moveto( level.ritual_bear.origin + ( 0, 0, 75 ), 45 );
    level.ritual_bear setscriptablepartstate( "anim", "loop" );
    level.ritual_bear.ritual_circle = level.firefly_main_quest.var_de842018558c1466.sbl;
    level.ritual_bear.ritual_circle.part = "rc_b";
    level.ritual_bear.ritual_circle setscriptablepartstate( "audio", "ritual_start" );
    level.ritual_goblet.linkedparent.attractor = zombie_attractor_manager::add_attractor( level.ritual_goblet.linkedparent, 1, 1000, 1, undefined, &function_99fb0b5303877adf );
    zombie_attractor_manager::function_1497469a46932be2( level.ritual_goblet.linkedparent.attractor, level.ritual_goblet.origin, level.ritual_goblet.angles, 75, 4 );
    zombie_attractor_manager::function_4c34b0f066a9d9fe( level.ritual_goblet.linkedparent.attractor, 360 );
    zombie_attractor_manager::function_a2aab3762aaa055f( level.ritual_goblet.linkedparent.attractor, level.ritual_goblet.origin + ( 0, 0, 25 ), ( 40, 40, 75 ), level.ritual_goblet.angles );
    level.ritual_goblet.linkedparent.health_point = 0;
    level.ritual_goblet.linkedparent setcandamage( 1 );
    level.ritual_goblet.linkedparent thread function_e178b741508bf2f0();
    level.var_205095285d61180d = createnavobstaclebybounds( level.ritual_goblet.origin, ( 35, 35, 35 ), level.ritual_goblet.angles );
    level.ritual_goblet.linkedparent moveto( level.ritual_goblet.origin + ( 0, 0, 75 ), 45 );
    level.ritual_goblet setscriptablepartstate( "anim", "loop" );
    level.ritual_goblet.ritual_circle = level.firefly_main_quest.var_de841e18558c1000.sbl;
    level.ritual_goblet.ritual_circle.part = "rc_w";
    level.ritual_goblet.ritual_circle setscriptablepartstate( "audio", "ritual_start" );
    level.ritual_mask.linkedparent.attractor = zombie_attractor_manager::add_attractor( level.ritual_mask.linkedparent, 1, 1000, 1, undefined, &function_99fb0b5303877adf );
    zombie_attractor_manager::function_1497469a46932be2( level.ritual_mask.linkedparent.attractor, level.ritual_mask.origin, level.ritual_mask.angles, 75, 4 );
    zombie_attractor_manager::function_4c34b0f066a9d9fe( level.ritual_mask.linkedparent.attractor, 360 );
    zombie_attractor_manager::function_a2aab3762aaa055f( level.ritual_mask.linkedparent.attractor, level.ritual_mask.origin + ( 0, 0, 25 ), ( 40, 40, 75 ), level.ritual_mask.angles );
    level.ritual_mask.linkedparent.health_point = 0;
    level.ritual_mask.linkedparent setcandamage( 1 );
    level.ritual_mask.linkedparent thread function_e178b741508bf2f0();
    level.var_e5ba184f1c45deca = createnavobstaclebybounds( level.ritual_mask.origin, ( 35, 35, 35 ), level.ritual_mask.angles );
    level.ritual_mask.linkedparent moveto( level.ritual_mask.origin + ( 0, 0, 75 ), 45 );
    level.ritual_mask setscriptablepartstate( "anim", "loop" );
    level.ritual_mask.ritual_circle = level.firefly_main_quest.var_de841f18558c1233.sbl;
    level.ritual_mask.ritual_circle.part = "rc_m";
    level.ritual_mask.ritual_circle setscriptablepartstate( "audio", "ritual_start" );
}

// Namespace zm_sat_firefly_script_mq
// Params 11, eflags: 0x4
// Checksum 0xab4bc546, Offset: 0x18b3a
// Size: 0x37f
function private function_e178b741508bf2f0( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    level endon( #"rt_encounter_failure" );
    level endon( #"hash_2e9f51d6eed522e5" );
    level.firefly_main_quest.var_f3f92c86a947d7b8 = 0;
    
    while ( isdefined( self.attractor ) )
    {
        self waittill( #"damage", damage, attacker );
        
        if ( isplayer( attacker ) )
        {
            continue;
        }
        
        if ( self.health_point < 30 )
        {
            self.health_point++;
            level.firefly_main_quest.ritual_item_health = self.health_point;
            var_50c4e18722712d3e = 30 - level.firefly_main_quest.ritual_item_health;
            var_50c4e18722712d3e = clamp( var_50c4e18722712d3e, 0, 30 );
            
            if ( function_dc6a8903cbb1d35a() || level.firefly_main_quest.var_f2b547d6a287fbb6 == #"hash_50883e8403ecf4a7" )
            {
                if ( self.health_point > level.firefly_main_quest.var_f3f92c86a947d7b8 )
                {
                    level.firefly_main_quest.var_f3f92c86a947d7b8 = self.health_point;
                    quest_ref = level zm_sat_firefly::function_24006873400b7a8() && level.var_cef21da19561e27d ? #"firefly_mq_guidance" : #"sat_zm_quest_firefly_ui";
                    level zm_quest::function_9f49b2a045ece8ae( var_50c4e18722712d3e, 1, quest_ref, #"hash_50883e8403ecf4a7" );
                }
            }
        }
        
        if ( self.health_point >= 30 )
        {
            level thread cleanup_rt_encounter();
            self.linkedchildren[ 0 ].ritual_circle setscriptablepartstate( self.linkedchildren[ 0 ].ritual_circle.part, "failed" );
            function_ddb4f2afd5c01d25( self );
            
            foreach ( player in level.players )
            {
                zonename = player zone_manager::get_current_zone();
                
                if ( zonename && arraycontains( [ "zone_farm", "zone_farm_house", "zone_farm_barn", "zone_farm_garage", "zone_farm_cellar", "zone_farm_road", "zone_farm_gate", "zone_farm_rear", "zone_farm_close_to_sunken", "zone_farm_close_to_tower" ], zonename.script_zone_name ) )
                {
                    player playlocalsound( #"hash_62ce73c759a0c3bd" );
                    level musicbank_utility::function_5aca66c390aa347d( player, #"hash_563ad6b7af631b26" );
                    continue;
                }
                
                level musicbank_utility::function_4f253fd35ec68cbc( player, #"hash_649d3177969ffc6" );
            }
            
            level notify( #"rt_encounter_failure" );
            break;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x4423598f, Offset: 0x18ec1
// Size: 0xfb, Type: bool
function private function_99fb0b5303877adf( attractor, zombie )
{
    level endon( #"rt_encounter_failure" );
    level endon( #"hash_2e9f51d6eed522e5" );
    
    if ( level utility::flag( "rt_encounter_failure" ) )
    {
        return false;
    }
    
    if ( zombie.subclass == "zombie_callisto" || zombie.subclass == "zombie_callisto_hvt" )
    {
        return false;
    }
    
    if ( !isdefined( level.ritual_mask.linkedparent.attractor ) )
    {
        return false;
    }
    
    if ( !isdefined( level.ritual_bear.linkedparent.attractor ) )
    {
        return false;
    }
    
    if ( !isdefined( level.ritual_razor.linkedparent.attractor ) )
    {
        return false;
    }
    
    if ( !isdefined( level.ritual_goblet.linkedparent.attractor ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xf8e3251b, Offset: 0x18fc5
// Size: 0x153
function private function_63738c201e7386e6()
{
    level endon( #"game_ended" );
    level endon( #"rt_encounter_failure" );
    level endon( #"hash_2e9f51d6eed522e5" );
    var_215e83170a169367 = [ "zombie_base", "zombie_base_armored_light", "zombie_base_armored_heavy" ];
    a_spawn_locs = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_farm", "zone_farm_house", "zone_farm_barn", "zone_farm_garage", "zone_farm_gate", "zone_farm_rear" ], "zombie_base" );
    zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 0 );
    wait 2;
    var_ca27f2becbe427c1 = function_f6e067c3dad131c6();
    var_1023ddb615d1328c = [];
    var_8f241604573c83fa = function_2ccddfbfda5c0f96();
    counter = 0;
    
    while ( counter < var_8f241604573c83fa )
    {
        var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ], var_1023ddb615d1328c );
        
        if ( var_d7b3a1f33b95bf77 )
        {
            ai_type = utility::array_random( var_215e83170a169367 );
            ai_spawn_loc = utility::array_random( a_spawn_locs );
            zombie = spawn_encounter_zombie( ai_type, ai_spawn_loc );
            counter += 1;
        }
        else
        {
            wait 1;
        }
        
        wait var_ca27f2becbe427c1;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xff85216f, Offset: 0x19120
// Size: 0x50
function function_2ccddfbfda5c0f96()
{
    switch ( level.players.size )
    {
        case 1:
            return 25;
        case 2:
            return 35;
        case 3:
            return 45;
        case 4:
            return 55;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x81883295, Offset: 0x19178
// Size: 0x56
function function_f6e067c3dad131c6()
{
    switch ( level.players.size )
    {
        case 1:
            return 1.5;
        case 2:
            return 1.25;
        case 3:
            return 1;
        case 4:
            return 1;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xc5ed6512, Offset: 0x191d6
// Size: 0x185
function private spawn_encounter_zombie( zombie_type, spawner )
{
    level endon( #"rt_encounter_failure" );
    level endon( #"hash_2e9f51d6eed522e5" );
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        round_number = zm_round_logic::get_rb_round_number() + 2;
    }
    else
    {
        round_number = zm_round_logic::get_rb_round_number();
    }
    
    zombie = agent_manager::spawn_agent( zombie_type, spawner.origin, ( 0, 0, 0 ), "team_two_hundred" );
    
    if ( isdefined( zombie ) && !level utility::flag( "rt_trial_failed" ) )
    {
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        zombie.kiastring = #"zombie_kia_mission_kill";
        zombie.no_powerups = 1;
        zombie zombie_utils::set_zombie_round_difficulty( round_number );
        zombie.ignore_enemy_count = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie.is_attractor_zmb = 1;
        zombie val::set( "firefly_rt_encounter", "ignore_cleanup", 1 );
        zombie.disable_brain_rot = 1;
        zombie.var_43b5041135e7c790 = 1;
        zombie.nocorpse = 1;
        zombie.forceannihilate = 1;
        level.var_29cf8c224f0a42fa[ level.var_29cf8c224f0a42fa.size ] = zombie;
        
        if ( isdefined( spawner.script_animation ) )
        {
            zombie thread zone_spawner::function_ce10e453e7f7bb8e( spawner );
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xa17078d3, Offset: 0x19363
// Size: 0x81c
function private cleanup_rt_encounter()
{
    level utility::flag_clear( "rt_trial_started" );
    quest_ref = level zm_sat_firefly::function_24006873400b7a8() && level.var_cef21da19561e27d ? #"firefly_mq_guidance" : #"sat_zm_quest_firefly_ui";
    
    if ( function_dc6a8903cbb1d35a() || level.firefly_main_quest.var_f2b547d6a287fbb6 == #"hash_50883e8403ecf4a7" )
    {
        level zm_quest::function_9f49b2a045ece8ae( 0, 1, quest_ref, #"hash_50883e8403ecf4a7" );
    }
    
    zombie_attractor_manager::remove_attractor( level.ritual_mask.linkedparent.attractor );
    level.ritual_mask.linkedparent.attractor = undefined;
    destroynavobstacle( level.var_e5ba184f1c45deca );
    zombie_attractor_manager::remove_attractor( level.ritual_bear.linkedparent.attractor );
    level.ritual_bear.linkedparent.attractor = undefined;
    destroynavobstacle( level.var_1e19cd77076ce240 );
    zombie_attractor_manager::remove_attractor( level.ritual_goblet.linkedparent.attractor );
    level.ritual_goblet.linkedparent.attractor = undefined;
    destroynavobstacle( level.var_205095285d61180d );
    zombie_attractor_manager::remove_attractor( level.ritual_razor.linkedparent.attractor );
    level.ritual_razor.linkedparent.attractor = undefined;
    destroynavobstacle( level.var_ce3bf6f569913dd2 );
    
    foreach ( item in level.a_ritual_items )
    {
        if ( !level utility::flag( "rt_complete" ) )
        {
            item setscriptablepartstate( "anim", "drop" );
            item.linkedparent moveto( item.starting_position, 1 );
            level utility::flag_clear( "rt_interact_triggered" );
            level utility::flag_set( "rt_trial_failed" );
            
            if ( function_dc6a8903cbb1d35a() || level.firefly_main_quest.var_f2b547d6a287fbb6 == #"hash_50883e8403ecf4a7" )
            {
                level zm_quest::function_fb3af5600f6a9441( 3, 1, quest_ref, #"hash_50883e8403ecf4a7" );
                
                if ( level.firefly_main_quest.var_f2b547d6a287fbb6 == #"hash_50883e8403ecf4a7" )
                {
                    level.firefly_main_quest.var_f2b547d6a287fbb6 = undefined;
                }
            }
            
            level.firefly_main_quest.var_de842018558c1466.sbl setscriptablepartstate( "audio", "item_placed" );
            level.firefly_main_quest.var_de841f18558c1233.sbl setscriptablepartstate( "audio", "item_placed" );
            level.firefly_main_quest.var_de841e18558c1000.sbl setscriptablepartstate( "audio", "item_placed" );
            level.firefly_main_quest.var_de842518558c1f65.sbl setscriptablepartstate( "audio", "item_placed" );
        }
    }
    
    level utility::delaythread( 2.5, &function_51f12524c830dd09 );
    
    if ( level utility::flag( "rt_complete" ) )
    {
        if ( function_dc6a8903cbb1d35a() || level.firefly_main_quest.var_f2b547d6a287fbb6 == #"hash_50883e8403ecf4a7" )
        {
            level zm_quest::function_fb3af5600f6a9441( 4, 1, quest_ref, #"hash_50883e8403ecf4a7" );
            
            if ( level.firefly_main_quest.var_f2b547d6a287fbb6 == #"hash_50883e8403ecf4a7" )
            {
                level.firefly_main_quest.var_f2b547d6a287fbb6 = undefined;
            }
        }
        
        level.firefly_main_quest.var_77bb8e15d0471db0 thread function_9eeb8920fdd8157d( level.firefly_main_quest.var_de842018558c1466.origin );
        level.firefly_main_quest.var_77bb9115d0472449 thread function_9eeb8920fdd8157d( level.firefly_main_quest.var_de841f18558c1233.origin );
        level.firefly_main_quest.var_77bb9015d0472216 thread function_9eeb8920fdd8157d( level.firefly_main_quest.var_de841e18558c1000.origin );
        level.firefly_main_quest.var_77bb9315d04728af thread function_9eeb8920fdd8157d( level.firefly_main_quest.var_de842518558c1f65.origin );
        level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 0, 0, 1 );
        
        if ( level zm_quest::function_b0a5181ebe7bb905() )
        {
            zm_round_spawning::pause_round_spawning( 1, "main_quest_pause_spawning" );
        }
        
        level.ritual_razor setscriptablepartstate( "model", "off" );
        level.ritual_bear setscriptablepartstate( "model", "off" );
        level.ritual_goblet setscriptablepartstate( "model", "off" );
        level.ritual_mask setscriptablepartstate( "model", "off" );
        level.ritual_razor setscriptablepartstate( "vfx", "off" );
        level.ritual_bear setscriptablepartstate( "vfx", "off" );
        level.ritual_goblet setscriptablepartstate( "vfx", "off" );
        level.ritual_mask setscriptablepartstate( "vfx", "off" );
        level.firefly_main_quest.var_de842018558c1466.sbl setscriptablepartstate( "rc_b", "off_state" );
        level.firefly_main_quest.var_de842018558c1466.sbl setscriptablepartstate( "audio", "off" );
        level.firefly_main_quest.var_de841f18558c1233.sbl setscriptablepartstate( "rc_m", "off_state" );
        level.firefly_main_quest.var_de841f18558c1233.sbl setscriptablepartstate( "audio", "off" );
        level.firefly_main_quest.var_de841e18558c1000.sbl setscriptablepartstate( "rc_w", "off_state" );
        level.firefly_main_quest.var_de841e18558c1000.sbl setscriptablepartstate( "audio", "off" );
        level.firefly_main_quest.var_de842518558c1f65.sbl setscriptablepartstate( "rc_r", "off_state" );
        level.firefly_main_quest.var_de842518558c1f65.sbl setscriptablepartstate( "audio", "off" );
        level.firefly_main_quest.rituals_complete++;
        
        foreach ( player in level.players )
        {
            var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_bda77eba6ad6db5e", #"bc_flavor_player_positive" );
            
            if ( var_db75d3de862ce072 )
            {
                break;
            }
        }
        
        level thread function_4350df6f8255caf6();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x668a49a6, Offset: 0x19b87
// Size: 0x5f
function function_9eeb8920fdd8157d( tme_location )
{
    self.tme_sbl.linkedparent.origin = tme_location;
    wait 0.5;
    self.tme_sbl utility::function_32b24db3127bff40( "body", "ready_nohealth_white" );
    wait 13;
    self.tme_sbl thread function_51e889cea6b518fe();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x6c2cd2e1, Offset: 0x19bee
// Size: 0xfd
function private function_ddb4f2afd5c01d25( item )
{
    if ( !isdefined( level.failed_item ) )
    {
        level.failed_item = item.linkedchildren[ 0 ];
        level.failed_item setscriptablepartstate( "vfx", "failed" );
    }
    
    level utility::flag_clear( "recharge_in_progress" );
    level utility::flag_clear( "rt_ui_complete" );
    level.firefly_main_quest.var_697a9dca9b09b003 = spawnscriptable( %"zm_sat_firefly_mq_rc", level.failed_item.starting_position + ( 0, 0, 25 ), level.failed_item.starting_angles );
    level.firefly_main_quest.var_697a9dca9b09b003 setscriptablepartstate( "recharge_event", "on_visable_recharge" );
    level.firefly_main_quest.var_697a9dca9b09b003 scriptable::scriptable_addusedcallbackbypart( "recharge_event", &rt_recharge_event );
}

// Namespace zm_sat_firefly_script_mq
// Params 6
// Checksum 0x3023cdd8, Offset: 0x19cf3
// Size: 0x1be
function rt_recharge_event( instance, part, state, user, bautouse, usestring )
{
    level utility::flag_clear( "rt_recharge_failure" );
    
    if ( isdefined( level.failed_item ) )
    {
        level.failed_item.ritual_circle setscriptablepartstate( level.failed_item.ritual_circle.part, "failed" );
    }
    
    level utility::flag_clear( "recharge_complete" );
    level utility::flag_set( "recharge_in_progress" );
    level utility::flag_set( "rt_ui_complete" );
    instance setscriptablepartstate( part, "off" );
    level.ritual_goblet setscriptablepartstate( "anim", "drop_pose" );
    level.ritual_mask setscriptablepartstate( "anim", "drop_pose" );
    level.ritual_bear setscriptablepartstate( "anim", "drop_pose" );
    level.ritual_razor setscriptablepartstate( "anim", "drop_pose" );
    instance scriptable::function_369a834929711390( "recharge_event", &rt_recharge_event );
    level callback::remove( "on_zombie_ai_killed", &function_26b92c76dbe253b9, level.failed_item.origin );
    level callback::add( "on_zombie_ai_killed", &function_26b92c76dbe253b9, level.failed_item.origin );
    level.var_632caaab045ae359 = 0;
    level thread function_51f12524c830dd09();
    
    if ( function_dc6a8903cbb1d35a() )
    {
        level zm_quest::function_9f49b2a045ece8ae( level.var_632caaab045ae359, 1, #"firefly_mq_guidance", #"hash_b99e08150dccf6aa" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0xc37e01c5, Offset: 0x19eb9
// Size: 0x1c5
function function_26b92c76dbe253b9( params, struct )
{
    level endon( #"recharge_complete" );
    level endon( #"rt_recharge_failure" );
    is_valid_attacker = isplayer( params.eattacker ) || isdefined( level.europa ) && level.europa europa::is_activated() && isplayer( level.europa.europa.owner );
    
    if ( is_valid_attacker && !level utility::flag( "recharge_complete" ) )
    {
        level.var_632caaab045ae359++;
        
        if ( function_dc6a8903cbb1d35a() )
        {
            level zm_quest::function_9f49b2a045ece8ae( level.var_632caaab045ae359, 1, #"firefly_mq_guidance", #"hash_b99e08150dccf6aa" );
        }
        
        var_251f4e1af05f5cd3 = zone_manager::get_current_zone();
        
        if ( isdefined( self ) && isdefined( var_251f4e1af05f5cd3.zone_name ) && arraycontains( [ "zone_farm", "zone_farm_house", "zone_farm_barn", "zone_farm_garage", "zone_farm_gate", "zone_farm_rear" ], var_251f4e1af05f5cd3.zone_name ) )
        {
            if ( self.subclass == "zombie_callisto" || self.subclass == "zombie_callisto_hvt" )
            {
                playfxontag( level._effect[ #"mq_zombie_killed" ], self, "j_Spine1" );
            }
            else
            {
                playfxontag( level._effect[ #"mq_zombie_killed" ], self, "j_spineupper" );
            }
            
            level thread function_53c7e7fee27e1b88( self getcentroid(), struct );
        }
        
        level thread function_2c010d1391e0367();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0x8688bb37, Offset: 0x1a086
// Size: 0xc1
function function_53c7e7fee27e1b88( v_start, v_end )
{
    e_fx = utility::spawn_model( "tag_origin", v_start );
    e_fx playsound( #"hash_4f6ac5170171a88c" );
    e_fx playloopsound( #"hash_34bdae4d9fd25ab5" );
    playfxontag( level._effect[ #"mq_zombie_trail" ], e_fx, "tag_origin" );
    n_time = distance2d( v_start, v_end ) / 400;
    e_fx utility::function_8001268940441423( v_start, v_end, v_start + ( 0, 0, 48 ), n_time, 0, 1 );
    playsoundatpos( e_fx.origin, #"hash_451a39e679b1d41d" );
    e_fx delete();
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xb3cf86dc, Offset: 0x1a14f
// Size: 0x1e2
function function_2c010d1391e0367()
{
    if ( level.var_632caaab045ae359 == 30 )
    {
        level notify( #"hash_6337c4174075843d" );
        level callback::remove( "on_zombie_ai_killed", &function_26b92c76dbe253b9, level.failed_item.origin );
        level utility::flag_set( "recharge_complete" );
        level utility::flag_clear( "rt_trial_failed" );
        
        if ( function_dc6a8903cbb1d35a() )
        {
            level zm_quest::function_fb3af5600f6a9441( 4, 1, #"firefly_mq_guidance", #"hash_b99e08150dccf6aa" );
        }
        
        level.failed_item.ritual_circle setscriptablepartstate( level.failed_item.ritual_circle.part, "active" );
        level.failed_item setscriptablepartstate( "vfx", "on" );
        level.ritual_goblet setscriptablepartstate( "anim", "intro" );
        level.ritual_mask setscriptablepartstate( "anim", "intro" );
        level.ritual_bear setscriptablepartstate( "anim", "intro" );
        level.ritual_razor setscriptablepartstate( "anim", "intro" );
        level.firefly_main_quest.var_d6b80ced7b65f870 = spawnscriptable( %"zm_sat_firefly_mq_rc", level.failed_item.starting_position + ( 0, 0, 25 ), level.failed_item.starting_angles );
        level.firefly_main_quest.var_d6b80ced7b65f870 setscriptablepartstate( "interact_rt_trial", "st_visable_rt_trial" );
        level.firefly_main_quest.var_d6b80ced7b65f870 scriptable::scriptable_addusedcallbackbypart( "interact_rt_trial", &function_9d7f338bea4a1634 );
        level thread function_51f12524c830dd09();
        level.failed_item = undefined;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x53d70d75, Offset: 0x1a339
// Size: 0x290
function private function_f7b69f547a581ee1( b_skipped, b_save_restored )
{
    if ( isdefined( level.firefly_main_quest.var_76aaaf4d5507ab79 ) )
    {
        level.firefly_main_quest.var_76aaaf4d5507ab79 freescriptable();
        level.firefly_main_quest.var_76aaaf4d5507ab79 = undefined;
    }
    
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_wait( "rt_tme_sbls_spawned" );
        level.firefly_main_quest.var_77bb8e15d0471db0.tme_sbl thread function_51e889cea6b518fe( undefined, 1 );
        level.firefly_main_quest.var_77bb9115d0472449.tme_sbl thread function_51e889cea6b518fe( undefined, 1 );
        level.firefly_main_quest.var_77bb9015d0472216.tme_sbl thread function_51e889cea6b518fe( undefined, 1 );
        level.firefly_main_quest.var_77bb9315d04728af.tme_sbl thread function_51e889cea6b518fe( undefined, 1 );
        level utility::flag_set( "rt_head_rotation_complete" );
        level.firefly_main_quest utility::ent_flag_set( "knock_head" );
        level utility::flag_set( "no_tme" );
        level.firefly_main_quest.var_9569ed39e1646d45 setscriptablepartstate( "vfx", "on" );
        level.firefly_main_quest.var_9569ed39e1646d45 setscriptablepartstate( "vfx_react", "on" );
        level.firefly_main_quest.var_9569ed39e1646d45 rotateto( level.firefly_main_quest.var_9569ed39e1646d45.angles - ( 0, 0, 60 ), 0.1 );
        level utility::flag_set( "rt_complete" );
        return;
    }
    
    level utility::flag_wait( "rt_complete" );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::clear_all_guidance();
        level utility::flag_set( "mq_guidance_delay_update_active" );
        level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"firefly_mq_guidance", #"hash_50883e8403ecf4a7" );
        level zm_quest::function_fb3af5600f6a9441( 4, 1, #"firefly_mq_guidance", #"hash_50883e8403ecf4a7" );
        level utility::delaythread( 15, &utility::flag_clear, "mq_guidance_delay_update_active" );
        level thread function_51f12524c830dd09();
        zm_round_spawning::pause_round_spawning( 0, "main_quest_pause_spawning" );
    }
    
    level callback::remove( #"player_death", &function_15a8e8376444928e );
    level callback::remove( #"player_disconnect", &function_15a8e8376444928e );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x952a15d1, Offset: 0x1a5d1
// Size: 0x9e
function private function_4f2b66733229d156()
{
    level.firefly_main_quest.var_282fdcfedaebd2c8 function_18683c611198a2c8( level.a_s_lightning[ 0 ].origin );
    level.firefly_main_quest.var_53f5aa5e19ca282e function_18683c611198a2c8( level.a_s_lightning[ 1 ].origin );
    level.firefly_main_quest.var_a35c0e09a86a04ec function_18683c611198a2c8( level.a_s_lightning[ 1 ].origin );
    level utility::flag_set( "rm_tme_sbls_spawned" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x5e2c3142, Offset: 0x1a677
// Size: 0x1cb
function private function_c5932954de2b5cf7( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "rm_complete" );
        return;
    }
    
    level utility::flag_wait( "MQ_STEP_10_COMPLETE" );
    level.var_b95267eb2a4bc6f1 = [ "waitress_trapped", "trucker_trapped", "mechanic_trapped" ];
    level.a_exit_killed = [];
    level.ents_stuck = [];
    level.firefly_main_quest.var_c1c90274a32137ba = utility::getstructarray( "st_sp", "targetname" );
    level.a_s_lightning = utility::getstructarray( "light_l", "targetname" );
    level.firefly_main_quest.storm_cloud = spawnscriptable( %"zm_sat_firefly_mq_rm_storm", level.firefly_main_quest.var_c1c90274a32137ba[ 0 ].origin, level.firefly_main_quest.var_c1c90274a32137ba[ 0 ].angles );
    
    if ( !level callback::exists( #"europa_activated", &function_d5f365891568f2e3 ) )
    {
        level callback::add( #"europa_activated", &function_d5f365891568f2e3 );
    }
    
    if ( !level callback::exists( #"europa_return_to_chair", &function_eb72bd0fbdf08bba ) )
    {
        level callback::add( #"europa_return_to_chair", &function_eb72bd0fbdf08bba );
    }
    
    if ( !level callback::exists( "zone_changed", &cleanup_exit_zombies ) )
    {
        level callback::add( "zone_changed", &cleanup_exit_zombies );
    }
    
    if ( !level callback::exists( "on_round_start", &function_9341edf52a130859 ) )
    {
        level callback::add( "on_round_start", &function_9341edf52a130859 );
    }
    
    level thread function_4c18626961fedcc0();
    level utility::flag_wait( "rm_complete" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x9858c3d0, Offset: 0x1a84a
// Size: 0x315
function private function_4c18626961fedcc0()
{
    level utility::flag_wait_all( "mq_asset_setup_complete", "init_level_living_world_bundles", "rm_tme_sbls_spawned" );
    
    if ( !level.a_exit_killed )
    {
        level.a_exit_killed = [];
    }
    
    if ( !level.ents_stuck )
    {
        level.ents_stuck = [];
    }
    
    storage_int = zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_7df80fbfdd3e3d9c" ) ?? 0;
    var_9e56f820941676b9 = [ level.firefly_main_quest.var_282fdcfedaebd2c8, level.firefly_main_quest.var_53f5aa5e19ca282e, level.firefly_main_quest.var_a35c0e09a86a04ec ];
    var_81bd08a38f1e9aa4 = [ "mechanic_killed", "trucker_killed", "waitress_killed" ];
    
    if ( storage_int > 0 )
    {
        for ( i = 0; i < 3 ; i++ )
        {
            var_c9556342507f4b3f = utility::get_bit_flag( storage_int, i + 1 );
            
            if ( var_c9556342507f4b3f )
            {
                level utility::flag_set( var_81bd08a38f1e9aa4[ i ] );
                level notify( var_9e56f820941676b9[ i ].var_3920f827ef511acd[ 0 ] );
                var_9e56f820941676b9[ i ].tme_sbl thread function_51e889cea6b518fe( undefined, 1 );
                
                switch ( i )
                {
                    case 0:
                        tme_truck = getscriptablearray( "tme_t", "targetname" );
                        tme_truck[ 0 ] utility::function_7c10ea82c1e305b8( "splash_listener", "dead" );
                        level.ents_stuck[ level.ents_stuck.size ] = "mechanic_trapped";
                        level.a_exit_killed[ level.a_exit_killed.size ] = level.firefly_main_quest.var_282fdcfedaebd2c8;
                        level utility::flag_set( "trunk_opened" );
                        break;
                    case 1:
                        level utility::flag_set( "trucker_register_vo" );
                        level function_26fe0f89b1588c69( level.wonder_veh, undefined, level.firefly_main_quest.var_ad5af114c1477c08 );
                        level.ents_stuck[ level.ents_stuck.size ] = "trucker_trapped";
                        level.a_exit_killed[ level.a_exit_killed.size ] = level.firefly_main_quest.var_53f5aa5e19ca282e;
                        level utility::flag_set( "s_opened" );
                        break;
                    case 2:
                        level utility::flag_set( "waitress_register_vo" );
                        level rm_register_hit( undefined, level.players[ 0 ], level.firefly_main_quest.var_8274c2ac910347cb, undefined, undefined, "MOD_MELEE" );
                        level.ents_stuck[ level.ents_stuck.size ] = "waitress_trapped";
                        level.a_exit_killed[ level.a_exit_killed.size ] = level.firefly_main_quest.var_a35c0e09a86a04ec;
                        level utility::flag_set( "register_open" );
                        break;
                }
            }
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 11
// Checksum 0xb2df3aa4, Offset: 0x1ab67
// Size: 0x398
function storm_lamp( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type == "zm_sat_firefly_mq_lp" && objweapon.basename == "sat_pluto_dg2" && !utility::flag( "storm_round_active" ) )
    {
        if ( instance.targetname == "exit_lp_3" && !level utility::flag( "1_l_set" ) && level.var_749847e3d61e0864.active )
        {
            level utility::flag_set( "1_l_set" );
            level.var_749847e3d61e0864 setscriptablepartstate( "sparks", "amb" );
            level.var_32aa4f629e3bd2b9[ level.var_32aa4f629e3bd2b9.size ] = instance;
            
            if ( level.var_bbbc25946f465a87.size > 0 )
            {
                level.lamp_on = utility::array_random( level.var_bbbc25946f465a87 );
                level.lamp_on setscriptablepartstate( "sparks", "sparks" );
                level.lamp_on.active = 1;
                level.var_bbbc25946f465a87 = arrayremove( level.var_bbbc25946f465a87, level.lamp_on );
            }
        }
        
        if ( instance.targetname == "exit_lp_2" && !level utility::flag( "2_l_set" ) && level.var_749849e3d61e0cca.active )
        {
            level utility::flag_set( "2_l_set" );
            level.var_749849e3d61e0cca setscriptablepartstate( "sparks", "amb" );
            level.var_32aa4f629e3bd2b9[ level.var_32aa4f629e3bd2b9.size ] = instance;
            
            if ( level.var_bbbc25946f465a87.size > 0 )
            {
                level.lamp_on = utility::array_random( level.var_bbbc25946f465a87 );
                level.lamp_on setscriptablepartstate( "sparks", "sparks" );
                level.lamp_on.active = 1;
                level.var_bbbc25946f465a87 = arrayremove( level.var_bbbc25946f465a87, level.lamp_on );
            }
        }
        
        if ( instance.targetname == "exit_lp_1" && !level utility::flag( "3_l_set" ) && level.var_749848e3d61e0a97.active )
        {
            level utility::flag_set( "3_l_set" );
            level.var_749848e3d61e0a97 setscriptablepartstate( "sparks", "amb" );
            level.var_32aa4f629e3bd2b9[ level.var_32aa4f629e3bd2b9.size ] = instance;
            
            if ( level.var_bbbc25946f465a87.size > 0 )
            {
                level.lamp_on = utility::array_random( level.var_bbbc25946f465a87 );
                level.lamp_on setscriptablepartstate( "sparks", "sparks" );
                level.lamp_on.active = 1;
                level.var_bbbc25946f465a87 = arrayremove( level.var_bbbc25946f465a87, level.lamp_on );
            }
        }
        
        if ( level.var_32aa4f629e3bd2b9.size == 3 && !level utility::flag( "storm_round_active" ) )
        {
            level utility::flag_set( "force_storm_activated" );
            force_storm_spawn();
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xe6ff8ad1, Offset: 0x1af07
// Size: 0x14
function private function_d5f365891568f2e3( sparams )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x3bf8fa1f, Offset: 0x1af23
// Size: 0x14
function private function_eb72bd0fbdf08bba( sparams )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x43648db3, Offset: 0x1af3f
// Size: 0x395
function private function_9341edf52a130859( params )
{
    current_round = zm_round_logic::get_rb_round_number();
    percent = randomintrange( 1, 100 );
    
    if ( !isdefined( level.storm_round ) )
    {
        level.storm_round = current_round;
    }
    
    if ( ( level zm_quest::function_b0a5181ebe7bb905() || current_round >= 999 || level.storm_round + 1 != current_round && ( percent <= 75 || level.storm_round + 3 == current_round ) ) && !utility::flag( "storm_round_active" ) )
    {
        foreach ( player in level.players )
        {
            player playlocalsound( #"hash_5363767acfb6d407" );
        }
        
        level.var_d1944e9cdd528a27 = spawnscriptable( "zm_sat_firefly_mq_lightning", level.a_s_lightning[ 0 ].origin, level.a_s_lightning[ 0 ].angles );
        level.var_d1944f9cdd528c5a = spawnscriptable( "zm_sat_firefly_mq_lightning", level.a_s_lightning[ 1 ].origin, level.a_s_lightning[ 1 ].angles );
        level.var_d194509cdd528e8d = spawnscriptable( "zm_sat_firefly_mq_lightning", level.a_s_lightning[ 2 ].origin, level.a_s_lightning[ 2 ].angles );
        level.firefly_main_quest.storm_cloud setscriptablepartstate( "visual", "active" );
        
        if ( !level utility::flag( "waitress_killed" ) )
        {
            level.var_d1944e9cdd528a27 setscriptablepartstate( "lightning", "purple_amb" );
        }
        
        if ( !level utility::flag( "trucker_killed" ) )
        {
            level.var_d194509cdd528e8d setscriptablepartstate( "lightning", "red_amb" );
        }
        
        if ( !level utility::flag( "mechanic_killed" ) )
        {
            level.var_d1944f9cdd528c5a setscriptablepartstate( "lightning", "yellow_amb" );
        }
        
        level.firefly_main_quest.storm_cloud setscriptablepartstate( "audio", "active" );
        level.storm_round = zm_round_logic::get_rb_round_number();
        level utility::flag_set( "storm_round_active" );
        level thread function_51f12524c830dd09();
        
        if ( !level callback::exists( "ww_magic_missile_fired", &function_da229b62a7811c8a ) )
        {
            level callback::add( "ww_magic_missile_fired", &function_da229b62a7811c8a );
        }
        
        if ( !level callback::exists( "on_round_end", &reset_storm_check ) )
        {
            level callback::add( "on_round_end", &reset_storm_check );
        }
        
        if ( !level zm_quest::function_b0a5181ebe7bb905() )
        {
            foreach ( lamp in level.a_lamps )
            {
                lamp setscriptablepartstate( "sparks", "off" );
                lamp.active = 0;
            }
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x74d77f81, Offset: 0x1b2dc
// Size: 0x277
function force_storm_spawn()
{
    if ( !utility::flag( "storm_round_active" ) )
    {
        foreach ( player in level.players )
        {
            player playlocalsound( #"hash_5363767acfb6d407" );
        }
        
        level.var_d1944e9cdd528a27 = spawnscriptable( "zm_sat_firefly_mq_lightning", level.a_s_lightning[ 0 ].origin, level.a_s_lightning[ 0 ].angles );
        level.var_d1944f9cdd528c5a = spawnscriptable( "zm_sat_firefly_mq_lightning", level.a_s_lightning[ 1 ].origin, level.a_s_lightning[ 1 ].angles );
        level.var_d194509cdd528e8d = spawnscriptable( "zm_sat_firefly_mq_lightning", level.a_s_lightning[ 2 ].origin, level.a_s_lightning[ 2 ].angles );
        level.firefly_main_quest.storm_cloud setscriptablepartstate( "visual", "active" );
        
        if ( !level utility::flag( "waitress_killed" ) )
        {
            level.var_d1944e9cdd528a27 setscriptablepartstate( "lightning", "purple_amb" );
        }
        
        if ( !level utility::flag( "trucker_killed" ) )
        {
            level.var_d194509cdd528e8d setscriptablepartstate( "lightning", "red_amb" );
        }
        
        if ( !level utility::flag( "mechanic_killed" ) )
        {
            level.var_d1944f9cdd528c5a setscriptablepartstate( "lightning", "yellow_amb" );
        }
        
        level.firefly_main_quest.storm_cloud setscriptablepartstate( "audio", "active" );
        level.storm_round = zm_round_logic::get_rb_round_number();
        level utility::flag_set( "storm_round_active" );
        level thread function_51f12524c830dd09();
        
        if ( !level callback::exists( "ww_magic_missile_fired", &function_da229b62a7811c8a ) )
        {
            level callback::add( "ww_magic_missile_fired", &function_da229b62a7811c8a );
        }
        
        if ( !level callback::exists( "on_round_end", &reset_storm_check ) )
        {
            level callback::add( "on_round_end", &reset_storm_check );
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xb2753c41, Offset: 0x1b55b
// Size: 0x22b
function private function_da229b62a7811c8a( sparams )
{
    projectile = sparams.projectile;
    player = sparams.player;
    
    if ( !isalive( player ) || !player.time_carrier || level.firefly_main_quest utility::ent_flag( "exit_clock_triggered" ) )
    {
        return;
    }
    
    level.firefly_main_quest notify( #"hash_618b7425201ce371" );
    level.firefly_main_quest endon( #"hash_618b7425201ce371" );
    player.projectile endon( #"exit_freed" );
    player.projectile endon( #"delay_death" );
    player.projectile endon( #"death" );
    player endon( #"death_or_disconnect" );
    player.projectile waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( !ispointinvolume( position, level.firefly_main_quest.vol_clock, 1 ) )
    {
        return;
    }
    
    playsoundatpos( level.firefly_main_quest.vol_clock.origin, #"hash_ac883a6d9d26702d" );
    level thread zm_music::start_zone_music_watcher( "rom_music", [ "zone_exit115", "zone_exit115_close_to_sunken", "zone_exit115_close_to_launchpad", "zone_exit115_gas", "zone_exit115_diner", "zone_exit115_diner_roof", "zone_exit115_pump_roof", "zone_exit115_diner_parking", "zone_exit115_gas_roof" ], #"rom_event" );
    level.firefly_main_quest utility::ent_flag_set( "exit_clock_triggered" );
    level.firefly_main_quest.var_6142146ce55b97c6 = player;
    level thread function_6bf285fb2855f625();
    player.projectile delete();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x6c1795ea, Offset: 0x1b78e
// Size: 0x3f9
function private reset_storm_check( params )
{
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        level utility::flag_clear( "1_l_set" );
        level utility::flag_clear( "2_l_set" );
        level utility::flag_clear( "3_l_set" );
        level.var_32aa4f629e3bd2b9 = [];
        level.var_bbbc25946f465a87 = [];
        
        foreach ( lamp in level.a_lamps )
        {
            lamp setscriptablepartstate( "sparks", "off" );
            lamp.active = 0;
        }
        
        level.var_bbbc25946f465a87 = level.a_lamps;
        level.lamp_on = utility::array_random( level.var_bbbc25946f465a87 );
        level.lamp_on setscriptablepartstate( "sparks", "sparks" );
        level.lamp_on.active = 1;
        level.var_bbbc25946f465a87 = arrayremove( level.var_bbbc25946f465a87, level.lamp_on );
        level utility::flag_clear( "force_storm_activated" );
    }
    
    if ( level utility::flag( "storm_round_active" ) && !level utility::flag( "storm_triggered" ) )
    {
        level callback::remove( "ww_magic_missile_fired", &function_da229b62a7811c8a );
        level utility::flag_clear( "storm_round_active" );
        level thread function_51f12524c830dd09();
        
        foreach ( player in level.players )
        {
            player playlocalsound( #"hash_c4d2fe608ba4f4b8" );
        }
        
        scriptable::function_dc174fecebb79952( &rm_register_hit );
        scriptable::function_dc174fecebb79952( &function_26fe0f89b1588c69 );
        level callback::remove( "on_round_end", &reset_storm_check );
        level.firefly_main_quest utility::ent_flag_clear( "exit_clock_triggered" );
        level thread zm_music::function_e9fd14ede793ef0d( "rom_music" );
        level.firefly_main_quest.var_8274c2ac910347cb setscriptablepartstate( "audio", "off" );
        level.firefly_main_quest.var_ad5af114c1477c08 setscriptablepartstate( "audio", "off" );
        level.firefly_main_quest.storm_cloud setscriptablepartstate( "visual", "off" );
        level.firefly_main_quest.storm_cloud setscriptablepartstate( "audio", "off" );
        level.var_d1944e9cdd528a27 setscriptablepartstate( "lightning", "off" );
        level.var_d1944f9cdd528c5a setscriptablepartstate( "lightning", "off" );
        level.var_d194509cdd528e8d setscriptablepartstate( "lightning", "off" );
        
        if ( isdefined( level.var_d1944e9cdd528a27 ) )
        {
            level.var_d1944e9cdd528a27 freescriptable();
        }
        
        if ( isdefined( level.var_d1944f9cdd528c5a ) )
        {
            level.var_d1944f9cdd528c5a freescriptable();
        }
        
        if ( isdefined( level.var_d194509cdd528e8d ) )
        {
            level.var_d194509cdd528e8d freescriptable();
        }
        
        if ( isdefined( level.var_e636110aaea58ffb ) )
        {
            level.var_e636110aaea58ffb freescriptable();
        }
        
        if ( isdefined( level.var_3382104fdce0bb2e ) )
        {
            level.var_3382104fdce0bb2e freescriptable();
        }
        
        if ( isdefined( level.var_538c24d6eb05abc5 ) )
        {
            level.var_538c24d6eb05abc5 freescriptable();
        }
        
        level val::reset( "task_firefly_lightning", "task_logic_activate" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x9ce9c710, Offset: 0x1bb8f
// Size: 0x7a
function private function_d18c88307e2dd370()
{
    level.tme_truck = getscriptablearray( "tme_t", "targetname" );
    mechanic_car = level.tme_truck[ 0 ] getlinkedscriptableinstance();
    
    if ( !level utility::flag( "trigger_mq_rm_mechanic" ) )
    {
        level.europa utility::callsharedfunc( #"europa", #"hash_28df9ffe0637327e", "firefly_mq_mechanic_car", mechanic_car, undefined, 150, undefined, 1, 0, undefined, &function_72ccc92207d5f022 );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 11, eflags: 0x4
// Checksum 0x22b39120, Offset: 0x1bc11
// Size: 0x227
function private rm_register_hit( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    player = eattacker;
    
    if ( instance getscriptablehaspart( "exit_register_model" ) && isplayer( eattacker ) && smeansofdeath == "MOD_MELEE" && !level utility::flag( "register_open" ) )
    {
        level.firefly_main_quest.var_8274c2ac910347cb setscriptablepartstate( "exit_register_model", "open" );
        level utility::flag_set( "register_open" );
        level thread function_51f12524c830dd09();
        reg_s = utility::getstruct( "wait_s", "targetname" );
        reg_m = utility::getstruct( "wait_m", "targetname" );
        reg_f = utility::getstruct( "wait_f", "targetname" );
        var_64eeee9b79f446a1 = utility::spawn_model( "tag_origin", reg_s.origin, reg_s.angles );
        var_64eeee9b79f446a1 playsound( #"hash_54c66bbedaf2d9b5" );
        playfxontag( level._effect[ #"waitress_tme" ], var_64eeee9b79f446a1, "tag_origin" );
        var_64eeee9b79f446a1 utility::function_8001268940441423( reg_s.origin, reg_f.origin, reg_m.origin, 2, 0, 0, 1 );
        stopfxontag( level._effect[ #"waitress_tme" ], var_64eeee9b79f446a1, "tag_origin" );
        var_64eeee9b79f446a1 delete();
        
        if ( player && !level utility::flag( "waitress_register_vo" ) )
        {
            level thread function_1007da3875deb276( player, "waitress_react", "waitress_react_response", 15, "exit_tme_released" );
        }
        
        scriptable::function_ecfda6e42bbe0ddc( &rm_register_hit );
        level thread function_31fc71ceccca860a();
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 11, eflags: 0x4
// Checksum 0xb4716f02, Offset: 0x1be40
// Size: 0x23b
function private function_26fe0f89b1588c69( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( einflictor.owner )
    {
        player = einflictor.owner;
    }
    
    if ( instance getscriptablehaspart( "model_s" ) )
    {
        if ( einflictor.vehiclename == "veh_sat_firefly_pluto" )
        {
            if ( !level utility::flag( "s_opened" ) )
            {
                level.firefly_main_quest.var_ad5af114c1477c08 setscriptablepartstate( "anim", "open" );
                level utility::flag_set( "s_opened" );
                level thread function_51f12524c830dd09();
                truck_s = utility::getstruct( "truck_s", "targetname" );
                truck_m = utility::getstruct( "truck_m", "targetname" );
                truck_f = utility::getstruct( "truck_f", "targetname" );
                var_1251896c87095f53 = utility::spawn_model( "tag_origin", truck_s.origin, truck_s.angles );
                playfxontag( level._effect[ #"trucker_tme" ], var_1251896c87095f53, "tag_origin" );
                var_1251896c87095f53 playsound( #"hash_54c66bbedaf2d9b5" );
                var_1251896c87095f53 utility::function_8001268940441423( truck_s.origin, truck_f.origin, truck_m.origin, 2, 0, 0, 1 );
                stopfxontag( level._effect[ #"trucker_tme" ], var_1251896c87095f53, "tag_origin" );
                var_1251896c87095f53 delete();
                
                if ( player && !level utility::flag( "trucker_register_vo" ) )
                {
                    level thread function_1007da3875deb276( player, "trucker_react", "trucker_react_response", 15, "exit_tme_released" );
                }
                
                scriptable::function_ecfda6e42bbe0ddc( &function_26fe0f89b1588c69 );
                level thread function_7e0607615a661c38();
            }
        }
        
        return;
    }
    
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x2df9fdbe, Offset: 0x1c083
// Size: 0x344
function private function_6bf285fb2855f625()
{
    level val::set( "task_firefly_lightning", "task_logic_activate", 0 );
    level.firefly_main_quest.storm_cloud setscriptablepartstate( "visual", "frozen" );
    
    if ( !level utility::flag( "register_open" ) )
    {
        level.firefly_main_quest.var_8274c2ac910347cb setscriptablepartstate( "audio", "rattling" );
        scriptable::scriptable_adddamagedcallback( &rm_register_hit );
    }
    
    if ( !level utility::flag( "s_opened" ) )
    {
        level.firefly_main_quest.var_ad5af114c1477c08 setscriptablepartstate( "audio", "rattling" );
        scriptable::scriptable_adddamagedcallback( &function_26fe0f89b1588c69 );
    }
    
    if ( !level utility::flag( "truck_opened" ) )
    {
        function_d18c88307e2dd370();
        level.tme_truck[ 0 ] setscriptablepartstate( "audio", "rattling" );
    }
    
    level.firefly_main_quest.var_38e00b8a244cfd9e setscriptablepartstate( "clock_fx", "time_on" );
    level.firefly_main_quest.var_38e00a8a244cfb6b setscriptablepartstate( "clock_fx", "time_on" );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level.firefly_main_quest.storm_time = 120;
    }
    else
    {
        level.firefly_main_quest.storm_time = 60;
    }
    
    level thread function_e4c1117efcea5b35();
    level utility::flag_set( "storm_triggered" );
    level thread storm_timer();
    level thread function_1d0c96ca6658ea03();
    level thread function_bf0c3d536c57f12e();
    
    if ( !level utility::flag( "waitress_killed" ) && level.var_d1944e9cdd528a27 )
    {
        level.var_d1944e9cdd528a27 setscriptablepartstate( "lightning", "purple_l" );
        level.var_e636110aaea58ffb = spawnscriptable( %"zm_sat_firefly_mq_lightning_audio", level.a_s_lightning[ 0 ].origin );
    }
    
    if ( !level utility::flag( "trucker_killed" ) && level.var_d194509cdd528e8d )
    {
        level.var_d194509cdd528e8d setscriptablepartstate( "lightning", "red_l" );
        level.var_538c24d6eb05abc5 = spawnscriptable( %"zm_sat_firefly_mq_lightning_audio", level.a_s_lightning[ 2 ].origin );
    }
    
    if ( !level utility::flag( "mechanic_killed" ) && level.var_d1944f9cdd528c5a )
    {
        level.var_d1944f9cdd528c5a setscriptablepartstate( "lightning", "yellow_l" );
        level.var_3382104fdce0bb2e = spawnscriptable( %"zm_sat_firefly_mq_lightning_audio", level.a_s_lightning[ 1 ].origin );
    }
    
    level thread function_e612981ba979c7cd();
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        foreach ( scriptable in level.a_lamps )
        {
            scriptable setscriptablepartstate( "sparks", "off" );
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xbf40383f, Offset: 0x1c3cf
// Size: 0xd0
function function_e4c1117efcea5b35()
{
    level.var_848b75f3ddd1cdd2 rotateby( ( -360, 0, 0 ), level.firefly_main_quest.storm_time );
    level.var_848b74f3ddd1cb9f rotateby( ( 360, 0, 0 ), level.firefly_main_quest.storm_time );
    level waittill( #"hash_ccc3c78d9782a9cc" );
    
    if ( level.firefly_main_quest.storm_time > 2 )
    {
        level.var_848b75f3ddd1cdd2 rotateto( level.var_a3bc59cde59aca90.angles, 0.1 );
        level.var_848b74f3ddd1cb9f rotateto( level.var_a3bc5ccde59ad129.angles, 0.1 );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x852817e2, Offset: 0x1c4a7
// Size: 0x1b8
function storm_timer()
{
    level endon( #"hash_ccc3c78d9782a9cc" );
    
    if ( !function_dc6a8903cbb1d35a() )
    {
        if ( level.firefly_main_quest.var_f2b547d6a287fbb6 )
        {
            level thread function_3c88ec2c924c8868();
        }
        else
        {
            level.firefly_main_quest.var_f2b547d6a287fbb6 = #"hash_a9ec022910499c23";
            level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"sat_zm_quest_firefly_ui", #"hash_a9ec022910499c23" );
            level zm_quest::function_fb3af5600f6a9441( 2, 1, #"sat_zm_quest_firefly_ui", #"hash_a9ec022910499c23" );
            level zm_quest::function_612a9ad0db22c29c( 60000, 1, #"sat_zm_quest_firefly_ui", #"hash_a9ec022910499c23" );
        }
    }
    
    level.firefly_main_quest.storm_time_remaining = level.firefly_main_quest.storm_time;
    level thread function_51f12524c830dd09();
    var_427b3d2c2f8fb546 = utility::function_6f5d2e1f1ff70482( gettime() );
    
    do
    {
        wait 1;
        time_passed = utility::function_6f5d2e1f1ff70482( gettime() ) - var_427b3d2c2f8fb546;
        level.firefly_main_quest.storm_time_remaining = level.firefly_main_quest.storm_time - time_passed;
    }
    while ( level.firefly_main_quest.storm_time_remaining > 0 );
    
    if ( !function_dc6a8903cbb1d35a() && level.firefly_main_quest.var_f2b547d6a287fbb6 == #"hash_a9ec022910499c23" )
    {
        wait 2;
        level zm_quest::function_fb3af5600f6a9441( 0, 1, #"sat_zm_quest_firefly_ui", #"hash_a9ec022910499c23" );
        level.firefly_main_quest.var_f2b547d6a287fbb6 = undefined;
    }
    
    level thread end_storm();
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xd08056d0, Offset: 0x1c667
// Size: 0xa8
function function_1d0c96ca6658ea03()
{
    level endon( #"hash_ccc3c78d9782a9cc" );
    
    if ( level.ents_stuck.size < 3 )
    {
        level utility::waittill_any_in_array( level.var_b95267eb2a4bc6f1 );
        level thread function_bd615ac08dc7bb75();
        return;
    }
    
    if ( level.ents_stuck.size == 3 && level.firefly_main_quest.storm_time_remaining > 8 )
    {
        wait 3;
        level zm_quest::function_fb3af5600f6a9441( 0, 1, #"sat_zm_quest_firefly_ui", #"hash_a9ec022910499c23" );
        level zm_quest::function_612a9ad0db22c29c( 0, 1, #"sat_zm_quest_firefly_ui", #"hash_a9ec022910499c23" );
        level thread end_storm();
        return;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x3a56f064, Offset: 0x1c717
// Size: 0x110
function function_bd615ac08dc7bb75()
{
    if ( level utility::flag( "waitress_trapped" ) && !arraycontains( level.ents_stuck, "waitress_trapped" ) )
    {
        flags = arrayremove( level.var_b95267eb2a4bc6f1, "waitress_trapped" );
        level.ents_stuck[ level.ents_stuck.size ] = "waitress_trapped";
    }
    
    if ( level utility::flag( "trucker_trapped" ) && !arraycontains( level.ents_stuck, "trucker_trapped" ) )
    {
        flags = arrayremove( level.var_b95267eb2a4bc6f1, "trucker_trapped" );
        level.ents_stuck[ level.ents_stuck.size ] = "trucker_trapped";
    }
    
    if ( level utility::flag( "mechanic_trapped" ) && !arraycontains( level.ents_stuck, "mechanic_trapped" ) )
    {
        flags = arrayremove( level.var_b95267eb2a4bc6f1, "mechanic_trapped" );
        level.ents_stuck[ level.ents_stuck.size ] = "mechanic_trapped";
    }
    
    level thread function_1d0c96ca6658ea03();
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xbbbb5997, Offset: 0x1c82f
// Size: 0x601
function end_storm()
{
    var_f01826e32ccd3a13 = level.firefly_main_quest.var_a35c0e09a86a04ec.scene_ents[ "actors" ][ 0 ];
    var_f01827e32ccd3c46 = level.firefly_main_quest.var_53f5aa5e19ca282e.scene_ents[ "actors" ][ 0 ];
    ent_3 = level.firefly_main_quest.var_282fdcfedaebd2c8.scene_ents[ "actors" ][ 0 ];
    
    if ( utility::flag( "waitress_trapped" ) )
    {
        level thread kill_waitress( var_f01826e32ccd3a13 );
    }
    
    if ( utility::flag( "trucker_trapped" ) )
    {
        level thread kill_trucker( var_f01827e32ccd3c46 );
    }
    
    if ( utility::flag( "mechanic_trapped" ) )
    {
        level thread kill_mechanic( ent_3 );
    }
    
    if ( level utility::flag( "storm_round_active" ) )
    {
        level utility::flag_clear( "storm_round_active" );
        level utility::flag_clear( "storm_triggered" );
        level callback::remove( "ww_magic_missile_fired", &function_da229b62a7811c8a );
        
        foreach ( player in level.players )
        {
            player playlocalsound( #"hash_c4d2fe608ba4f4b8" );
        }
        
        level.firefly_main_quest.var_38e00b8a244cfd9e setscriptablepartstate( "clock_fx", "off" );
        level.firefly_main_quest.var_38e00a8a244cfb6b setscriptablepartstate( "clock_fx", "off" );
        scriptable::function_dc174fecebb79952( &rm_register_hit );
        scriptable::function_dc174fecebb79952( &function_26fe0f89b1588c69 );
        level.firefly_main_quest utility::ent_flag_clear( "exit_clock_triggered" );
        level thread function_51f12524c830dd09();
        level.firefly_main_quest.var_8274c2ac910347cb setscriptablepartstate( "audio", "off" );
        level.firefly_main_quest.var_ad5af114c1477c08 setscriptablepartstate( "audio", "off" );
        level thread zm_music::function_e9fd14ede793ef0d( "rom_music" );
        level.var_4b5e3dd6a4212168 = undefined;
        level.var_4b5e3ed6a421239b = undefined;
        level.var_4b5e3fd6a42125ce = undefined;
        
        if ( !level utility::flag( "waitress_killed" ) )
        {
            level.var_d1944e9cdd528a27 setscriptablepartstate( "lightning", "off" );
            level.var_d1944e9cdd528a27 setscriptablepartstate( "impact", "purple_impact" );
            playsoundatpos( level.var_e636110aaea58ffb.origin, #"hash_798938cd22121ec1" );
        }
        
        if ( !level utility::flag( "trucker_killed" ) )
        {
            level.var_d194509cdd528e8d setscriptablepartstate( "lightning", "off" );
            level.var_d194509cdd528e8d setscriptablepartstate( "impact", "red_impact" );
            playsoundatpos( level.var_538c24d6eb05abc5.origin, #"hash_798938cd22121ec1" );
        }
        
        if ( !level utility::flag( "mechanic_killed" ) )
        {
            level.var_d1944f9cdd528c5a setscriptablepartstate( "lightning", "off" );
            level.var_d1944f9cdd528c5a setscriptablepartstate( "impact", "yellow_impact" );
            playsoundatpos( level.var_3382104fdce0bb2e.origin, #"hash_798938cd22121ec1" );
        }
        
        level.firefly_main_quest.storm_cloud setscriptablepartstate( "visual", "off" );
        level.firefly_main_quest.storm_cloud setscriptablepartstate( "audio", "off" );
        level val::reset( "task_firefly_lightning", "task_logic_activate" );
        wait 4;
        
        if ( !level utility::flag( "waitress_killed" ) )
        {
            level.var_d1944e9cdd528a27 freescriptable();
            level.var_e636110aaea58ffb freescriptable();
        }
        
        if ( !level utility::flag( "trucker_killed" ) )
        {
            level.var_d194509cdd528e8d freescriptable();
            level.var_538c24d6eb05abc5 freescriptable();
        }
        
        if ( !level utility::flag( "mechanic_killed" ) )
        {
            level.var_d1944f9cdd528c5a freescriptable();
            level.var_3382104fdce0bb2e freescriptable();
        }
    }
    
    level notify( #"hash_ccc3c78d9782a9cc" );
    level utility::flag_clear( "storm_round_active" );
    wait 5;
    
    if ( !level utility::flag( "rm_finished" ) && !level zm_quest::function_b0a5181ebe7bb905() && !level utility::flag( "force_storm_activated" ) )
    {
        level utility::flag_clear( "1_l_set" );
        level utility::flag_clear( "2_l_set" );
        level utility::flag_clear( "3_l_set" );
        level.var_32aa4f629e3bd2b9 = [];
        level.var_bbbc25946f465a87 = [];
        
        foreach ( lamp in level.a_lamps )
        {
            lamp setscriptablepartstate( "sparks", "off" );
            lamp.active = 0;
        }
        
        level.var_bbbc25946f465a87 = level.a_lamps;
        level.lamp_on = utility::array_random( level.var_bbbc25946f465a87 );
        level.lamp_on setscriptablepartstate( "sparks", "sparks" );
        level.lamp_on.active = 1;
        level.var_bbbc25946f465a87 = arrayremove( level.var_bbbc25946f465a87, level.lamp_on );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xa7b26068, Offset: 0x1ce38
// Size: 0xb1
function private function_3c88ec2c924c8868()
{
    level endon( #"game_ended" );
    level endon( #"hash_ccc3c78d9782a9cc" );
    
    while ( level.firefly_main_quest.var_f2b547d6a287fbb6 )
    {
        wait 1;
    }
    
    wait 1;
    level.firefly_main_quest.var_f2b547d6a287fbb6 = #"hash_a9ec022910499c23";
    level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"sat_zm_quest_firefly_ui", #"hash_a9ec022910499c23" );
    level zm_quest::function_fb3af5600f6a9441( 2, 1, #"sat_zm_quest_firefly_ui", #"hash_a9ec022910499c23" );
    level zm_quest::function_612a9ad0db22c29c( 60000, 1, #"sat_zm_quest_firefly_ui", #"hash_a9ec022910499c23" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x6cb66dab, Offset: 0x1cef1
// Size: 0x2cf
function function_bf0c3d536c57f12e()
{
    var_dd40cf6520d59892 = gettime() + utility::function_4b74c15943231980( level.firefly_main_quest.storm_time );
    f_rate = 0;
    var_b29ee84ff1629531 = 1 / level.firefly_main_quest.storm_time;
    exit_zone = utility::getstruct( "slow_zone" );
    
    while ( gettime() < var_dd40cf6520d59892 )
    {
        var_f01826e32ccd3a13 = level.firefly_main_quest.var_a35c0e09a86a04ec.scene_ents[ "actors" ][ 0 ];
        var_f01827e32ccd3c46 = level.firefly_main_quest.var_53f5aa5e19ca282e.scene_ents[ "actors" ][ 0 ];
        ent_3 = level.firefly_main_quest.var_282fdcfedaebd2c8.scene_ents[ "actors" ][ 0 ];
        f_rate += var_b29ee84ff1629531;
        var_27d11395809a8019 = min( 1, max( f_rate, 0.1 ) );
        function_d8b75b0a6f35296d( var_27d11395809a8019 );
        function_8480c01544182a46( var_27d11395809a8019 );
        physics_setgravityragdollscalar( var_27d11395809a8019 );
        function_61bb4aaaa2e5a524( var_27d11395809a8019 );
        a_ai = getaiarrayinradius( exit_zone.origin, 2000, zm_utility::get_zombie_team() );
        a_ai = arrayremove( a_ai, var_f01826e32ccd3a13 );
        a_ai = arrayremove( a_ai, var_f01827e32ccd3c46 );
        a_ai = arrayremove( a_ai, ent_3 );
        
        foreach ( ai in a_ai )
        {
            if ( isalive( ai ) )
            {
                ai asm::function_d82cb83c9c260d49( 0.5 );
                ai asm::function_24133a663bba593c();
            }
        }
        
        if ( !level utility::flag( "storm_triggered" ) )
        {
            break;
        }
        
        wait 1;
    }
    
    a_ai = getaiarrayinradius( exit_zone.origin, 2000, zm_utility::get_zombie_team() );
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) )
        {
            ai asm::function_d82cb83c9c260d49( 1 );
            ai asm::function_24133a663bba593c();
        }
    }
    
    function_d8b75b0a6f35296d( 1 );
    function_8480c01544182a46( 1 );
    physics_setgravityragdollscalar( 1 );
    function_61bb4aaaa2e5a524( 1 );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x7f3c9ad3, Offset: 0x1d1c8
// Size: 0xab
function private function_31fc71ceccca860a()
{
    ent = level.firefly_main_quest.var_a35c0e09a86a04ec.scene_ents[ "actors" ][ 0 ];
    level utility::flag_set( "trigger_mq_rm_waitress" );
    
    if ( isdefined( ent ) )
    {
        if ( ent && isalive( ent ) && ent tagexists( "j_spineupper" ) )
        {
            level thread delay_play_fx_on_tag( 0.5, level._effect[ #"hash_3007ebff4fd3bba5" ], ent, "j_spineupper" );
        }
        
        playsoundatpos( ent.origin, #"hash_798942ec8d76db17" );
        function_e612981ba979c7cd();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x1ce12a5e, Offset: 0x1d27b
// Size: 0xa3
function private function_7e0607615a661c38()
{
    ent = level.firefly_main_quest.var_53f5aa5e19ca282e.scene_ents[ "actors" ][ 0 ];
    level utility::flag_set( "trigger_mq_rm_trucker" );
    
    if ( isdefined( ent ) )
    {
        if ( ent && isalive( ent ) && ent tagexists( "j_spineupper" ) )
        {
            playfxontag( level._effect[ #"hash_db0d31f13e310e89" ], ent, "j_spineupper" );
        }
        
        playsoundatpos( ent.origin, #"hash_798942ec8d76db17" );
        function_e612981ba979c7cd();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x6351ce9c, Offset: 0x1d326
// Size: 0x25a
function private function_72ccc92207d5f022( sparams )
{
    if ( level.firefly_main_quest utility::ent_flag( "exit_clock_triggered" ) )
    {
        level.tme_truck[ 0 ] setscriptablepartstate( "splash_listener", "dead" );
        ent = level.firefly_main_quest.var_282fdcfedaebd2c8.scene_ents[ "actors" ][ 0 ];
        level.europa utility::callsharedfunc( #"europa", #"hash_3ac6bb166921f4af", "firefly_mq_mechanic_car" );
        level utility::flag_set( "trigger_mq_rm_mechanic" );
        
        if ( isdefined( ent ) )
        {
            mech_s = utility::getstruct( "mech_s", "targetname" );
            mech_m = utility::getstruct( "mech_m", "targetname" );
            mech_f = utility::getstruct( "mech_f", "targetname" );
            var_b372554cd7c5fcc9 = utility::spawn_model( "tag_origin", mech_s.origin, mech_s.angles );
            playfxontag( level._effect[ #"mechanic_tme" ], var_b372554cd7c5fcc9, "tag_origin" );
            var_b372554cd7c5fcc9 playsound( #"hash_54c66bbedaf2d9b5" );
            var_b372554cd7c5fcc9 utility::function_8001268940441423( mech_s.origin, mech_f.origin, mech_m.origin, 2, 0, 0, 1 );
            stopfxontag( level._effect[ #"mechanic_tme" ], var_b372554cd7c5fcc9, "tag_origin" );
            var_b372554cd7c5fcc9 delete();
            player = level.europa.europa.owner;
            level thread function_1007da3875deb276( player, "mechanic_react", "mechanic_react_response", 15, "exit_tme_released" );
            
            if ( ent && isalive( ent ) && ent tagexists( "j_spineupper" ) )
            {
                playfxontag( level._effect[ #"hash_d996e9d98fc2f639" ], ent, "j_spineupper" );
            }
            
            playsoundatpos( ent.origin, #"hash_798942ec8d76db17" );
            level utility::flag_set( "trunk_opened" );
            level thread function_51f12524c830dd09();
            function_e612981ba979c7cd();
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x89e12b62, Offset: 0x1d588
// Size: 0x14c
function function_e612981ba979c7cd()
{
    if ( level utility::flag( "trigger_mq_rm_mechanic" ) && !isdefined( level.var_4b5e3ed6a421239b ) && !level utility::flag( "mechanic_complete" ) )
    {
        level.var_4b5e3ed6a421239b = level.var_d1944f9cdd528c5a;
        level.var_4b5e3ed6a421239b thread function_ff4489a842d4411d( "mechanic_trapped", "mechanic_complete", level.firefly_main_quest.var_282fdcfedaebd2c8 );
    }
    
    if ( level utility::flag( "trigger_mq_rm_trucker" ) && !isdefined( level.var_4b5e3fd6a42125ce ) && !level utility::flag( "trucker_complete" ) )
    {
        level.var_4b5e3fd6a42125ce = level.var_d194509cdd528e8d;
        level.var_4b5e3fd6a42125ce thread function_9129e7ac6194d0c5( "trucker_trapped", "trucker_complete", level.firefly_main_quest.var_53f5aa5e19ca282e );
    }
    
    if ( level utility::flag( "trigger_mq_rm_waitress" ) && !isdefined( level.var_4b5e3dd6a4212168 ) && !level utility::flag( "waitress_complete" ) )
    {
        level.var_4b5e3dd6a4212168 = level.var_d1944e9cdd528a27;
        level.var_4b5e3dd6a4212168 thread function_299d04cb5a32b749( "waitress_trapped", "waitress_complete", level.firefly_main_quest.var_a35c0e09a86a04ec );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 3
// Checksum 0x50126540, Offset: 0x1d6dc
// Size: 0x109
function function_299d04cb5a32b749( flag, flag_endon, tme )
{
    level endon( flag_endon );
    
    while ( isdefined( level.var_4b5e3dd6a4212168 ) && !level utility::flag( flag ) )
    {
        ent = level.firefly_main_quest.var_a35c0e09a86a04ec.scene_ents[ "actors" ][ 0 ];
        a_ai_in_radius = getaiarrayinradius( self.origin, 75, zm_utility::get_zombie_team() );
        
        if ( ent && arraycontains( a_ai_in_radius, ent ) )
        {
            level utility::flag_set( flag );
            level thread function_51f12524c830dd09();
            ent val::set( "mq_exit_lw", "death", 0 );
            ent val::set( "mq_exit_lw", "damage", 0 );
            ent effect_stun::stun( "deadwire", level.firefly_main_quest.storm_time, undefined, "shocked_on", undefined, "electrical" );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0xacfd57aa, Offset: 0x1d7ed
// Size: 0x1ec
function kill_waitress( ent )
{
    if ( isdefined( ent ) )
    {
        var_b75d6f03e04d06f3 = getaiarrayinradius( level.var_d1944e9cdd528a27.origin, 75 );
        arrayremove( var_b75d6f03e04d06f3, ent );
        level thread function_95c8ebe554568145( var_b75d6f03e04d06f3 );
        playsoundatpos( level.var_e636110aaea58ffb.origin, #"hash_798938cd22121ec1" );
        playsoundatpos( level.var_e636110aaea58ffb.origin, #"hash_8b31c6e03bfdb8bc" );
        level.var_d1944e9cdd528a27 setscriptablepartstate( "lightning", "off" );
        level.var_d1944e9cdd528a27 setscriptablepartstate( "impact", "purple_impact" );
        level.var_e636110aaea58ffb freescriptable();
        ent.var_48960fedb514aedd = 1;
        level utility::flag_set( "waitress_killed" );
        storage_int = zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_7df80fbfdd3e3d9c" ) ?? 0;
        storage_int = utility::set_bit_flag( storage_int, 3 );
        zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_7df80fbfdd3e3d9c", storage_int );
        wait 0.25;
        ent kill();
        level.firefly_main_quest.var_a35c0e09a86a04ec thread function_74801da6071cccb4( ent.origin );
        level.a_exit_killed[ level.a_exit_killed.size ] = ent;
        
        if ( level.a_exit_killed.size == 3 )
        {
            level utility::flag_set( "rm_finished" );
            overlord::playevent( #"last_lightning_strike", level.players );
            function_e237bf348825a45();
            level.firefly_main_quest.rituals_complete++;
            level thread function_4350df6f8255caf6();
        }
        
        level utility::flag_clear( "waitress_trapped" );
        level notify( #"waitress_complete" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 3
// Checksum 0xec6608ef, Offset: 0x1d9e1
// Size: 0x109
function function_9129e7ac6194d0c5( flag, flag_endon, tme )
{
    level endon( flag_endon );
    
    while ( isdefined( level.var_4b5e3fd6a42125ce ) && !level utility::flag( flag ) )
    {
        ent = level.firefly_main_quest.var_53f5aa5e19ca282e.scene_ents[ "actors" ][ 0 ];
        a_ai_in_radius = getaiarrayinradius( self.origin, 75, zm_utility::get_zombie_team() );
        
        if ( ent && arraycontains( a_ai_in_radius, ent ) )
        {
            level utility::flag_set( flag );
            level thread function_51f12524c830dd09();
            ent val::set( "mq_exit_lw", "death", 0 );
            ent val::set( "mq_exit_lw", "damage", 0 );
            ent effect_stun::stun( "deadwire", level.firefly_main_quest.storm_time, undefined, "shocked_on", undefined, "electrical" );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0xefa2fcff, Offset: 0x1daf2
// Size: 0x1ec
function kill_trucker( ent )
{
    if ( isdefined( ent ) )
    {
        var_b75d6f03e04d06f3 = getaiarrayinradius( level.var_d194509cdd528e8d.origin, 75 );
        arrayremove( var_b75d6f03e04d06f3, ent );
        level thread function_95c8ebe554568145( var_b75d6f03e04d06f3 );
        playsoundatpos( level.var_538c24d6eb05abc5.origin, #"hash_798938cd22121ec1" );
        playsoundatpos( level.var_538c24d6eb05abc5.origin, #"hash_8b31c6e03bfdb8bc" );
        level.var_d194509cdd528e8d setscriptablepartstate( "lightning", "off" );
        level.var_d194509cdd528e8d setscriptablepartstate( "impact", "red_impact" );
        level.var_538c24d6eb05abc5 freescriptable();
        level utility::flag_set( "trucker_killed" );
        ent.var_48960fedb514aedd = 1;
        storage_int = zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_7df80fbfdd3e3d9c" ) ?? 0;
        storage_int = utility::set_bit_flag( storage_int, 2 );
        zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_7df80fbfdd3e3d9c", storage_int );
        wait 0.25;
        ent kill();
        level.firefly_main_quest.var_53f5aa5e19ca282e thread function_74801da6071cccb4( ent.origin );
        level.a_exit_killed[ level.a_exit_killed.size ] = ent;
        
        if ( level.a_exit_killed.size == 3 )
        {
            level utility::flag_set( "rm_finished" );
            overlord::playevent( #"last_lightning_strike", level.players );
            function_e237bf348825a45();
            level.firefly_main_quest.rituals_complete++;
            level thread function_4350df6f8255caf6();
        }
        
        level utility::flag_clear( "trucker_trapped" );
        level notify( #"trucker_complete" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 3
// Checksum 0x271555d6, Offset: 0x1dce6
// Size: 0x109
function function_ff4489a842d4411d( flag, flag_endon, tme )
{
    level endon( flag_endon );
    
    while ( isdefined( level.var_4b5e3ed6a421239b ) && !level utility::flag( flag ) )
    {
        ent = level.firefly_main_quest.var_282fdcfedaebd2c8.scene_ents[ "actors" ][ 0 ];
        a_ai_in_radius = getaiarrayinradius( self.origin, 75, zm_utility::get_zombie_team() );
        
        if ( ent && arraycontains( a_ai_in_radius, ent ) )
        {
            level utility::flag_set( flag );
            level thread function_51f12524c830dd09();
            ent val::set( "mq_exit_lw", "death", 0 );
            ent val::set( "mq_exit_lw", "damage", 0 );
            ent effect_stun::stun( "deadwire", level.firefly_main_quest.storm_time, undefined, "shocked_on", undefined, "electrical" );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0xb9c8f675, Offset: 0x1ddf7
// Size: 0x1ec
function kill_mechanic( ent )
{
    if ( isdefined( ent ) )
    {
        var_b75d6f03e04d06f3 = getaiarrayinradius( level.var_d1944f9cdd528c5a.origin, 75 );
        arrayremove( var_b75d6f03e04d06f3, ent );
        level thread function_95c8ebe554568145( var_b75d6f03e04d06f3 );
        playsoundatpos( level.var_3382104fdce0bb2e.origin, #"hash_798938cd22121ec1" );
        playsoundatpos( level.var_3382104fdce0bb2e.origin, #"hash_8b31c6e03bfdb8bc" );
        level.var_d1944f9cdd528c5a setscriptablepartstate( "lightning", "off" );
        level.var_d1944f9cdd528c5a setscriptablepartstate( "impact", "yellow_impact" );
        level.var_3382104fdce0bb2e freescriptable();
        level utility::flag_set( "mechanic_killed" );
        ent.var_48960fedb514aedd = 1;
        wait 0.25;
        ent kill();
        storage_int = zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_7df80fbfdd3e3d9c" ) ?? 0;
        storage_int = utility::set_bit_flag( storage_int, 1 );
        zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_7df80fbfdd3e3d9c", storage_int );
        level.firefly_main_quest.var_282fdcfedaebd2c8 thread function_74801da6071cccb4( ent.origin );
        level.a_exit_killed[ level.a_exit_killed.size ] = ent;
        
        if ( level.a_exit_killed.size == 3 )
        {
            level utility::flag_set( "rm_finished" );
            overlord::playevent( #"last_lightning_strike", level.players );
            function_e237bf348825a45();
            level.firefly_main_quest.rituals_complete++;
            level thread function_4350df6f8255caf6();
        }
        
        level utility::flag_clear( "mechanic_trapped" );
        level notify( #"mechanic_complete" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x26c2e1b2, Offset: 0x1dfeb
// Size: 0xca
function function_95c8ebe554568145( radius )
{
    if ( level.europa )
    {
        radius = arrayremove( radius, level.europa );
    }
    
    foreach ( ai in radius )
    {
        if ( isalive( ai ) )
        {
            ai effect_stun::stun( "deadwire", 8, undefined, "shocked_on", undefined, "electrical" );
            wait 8;
            
            if ( isalive( ai ) )
            {
                ai kill();
            }
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x747bcad0, Offset: 0x1e0bd
// Size: 0x139
function rm_on_ai_killed( params )
{
    if ( !self.is_living_world_ai )
    {
        return;
    }
    
    if ( self.var_f2bc035a31b7e81b.script_noteworthy != "mq_rm_waitress" && self.var_f2bc035a31b7e81b.script_noteworthy != "mq_rm_trucker" && self.var_f2bc035a31b7e81b.script_noteworthy != "mq_rm_mechanic" )
    {
        return;
    }
    
    a_corpses_w = function_955f614470e71cb2( level.firefly_main_quest.var_a35c0e09a86a04ec.origin, 250 );
    a_corpses_t = function_955f614470e71cb2( level.firefly_main_quest.var_53f5aa5e19ca282e.origin, 250 );
    a_corpses_m = function_955f614470e71cb2( level.firefly_main_quest.var_282fdcfedaebd2c8.origin, 250 );
    var_847d084dec62c9ef = arraycombineunique( a_corpses_w, a_corpses_t, a_corpses_m );
    level utility::array_delete( var_847d084dec62c9ef );
    spawn_origin = self.var_f2bc035a31b7e81b;
    utility::delaythread( 5, &function_ae030cf9fd7a4d00, spawn_origin );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x89bc8ed8, Offset: 0x1e1fe
// Size: 0x11e
function private function_ae030cf9fd7a4d00( livingworldstruct )
{
    level zm_utility::function_157b74f7b9e1ef04( livingworldstruct.origin );
    
    if ( !level utility::flag( "waitress_killed" ) && !isdefined( level.firefly_main_quest.var_a35c0e09a86a04ec.scene_ents[ "actors" ][ 0 ] ) )
    {
        level.firefly_main_quest.var_a35c0e09a86a04ec thread zm_livingworld::livingworld_spawn_encounter();
    }
    
    if ( !level utility::flag( "trucker_killed" ) && !isdefined( level.firefly_main_quest.var_53f5aa5e19ca282e.scene_ents[ "actors" ][ 0 ] ) )
    {
        level.firefly_main_quest.var_53f5aa5e19ca282e thread zm_livingworld::livingworld_spawn_encounter();
    }
    
    if ( !level utility::flag( "mechanic_killed" ) && !isdefined( level.firefly_main_quest.var_282fdcfedaebd2c8.scene_ents[ "actors" ][ 0 ] ) )
    {
        level.firefly_main_quest.var_282fdcfedaebd2c8 thread zm_livingworld::livingworld_spawn_encounter();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x59a620bd, Offset: 0x1e324
// Size: 0x182
function function_e237bf348825a45()
{
    level thread function_7d2d8b432a8b5b8d();
    level callback::remove( "ww_magic_missile_fired", &function_da229b62a7811c8a );
    
    foreach ( player in level.players )
    {
        player playlocalsound( #"hash_c4d2fe608ba4f4b8" );
        player playlocalsound( #"hash_18dd9f0b3955e925" );
    }
    
    level.firefly_main_quest.storm_cloud setscriptablepartstate( "visual", "off" );
    level.firefly_main_quest.storm_cloud setscriptablepartstate( "audio", "off" );
    level thread zm_music::function_e9fd14ede793ef0d( "rom_music" );
    scriptable::function_dc174fecebb79952( &rm_register_hit );
    scriptable::function_dc174fecebb79952( &function_26fe0f89b1588c69 );
    level callback::remove( "on_round_end", &reset_storm_check );
    level callback::remove( "on_round_start", &function_9341edf52a130859 );
    level.firefly_main_quest utility::ent_flag_clear( "exit_clock_triggered" );
    level utility::flag_clear( "storm_round_active" );
    level utility::flag_set( "rm_complete" );
    level val::reset( "task_firefly_lightning", "task_logic_activate" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x4ba6433b, Offset: 0x1e4ae
// Size: 0x124
function function_7d2d8b432a8b5b8d()
{
    a_players = arrayrandomize( level.players );
    
    foreach ( player in a_players )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"last_lightning_strike_response" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
    
    foreach ( player in a_players )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"last_lightning_strike_response", #"bc_flavor_player_positive" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0xeaa39348, Offset: 0x1e5da
// Size: 0x2f7
function cleanup_exit_zombies( params )
{
    foreach ( player in level.players )
    {
        player.var_77898ab40e53d0ae = player zone_manager::get_current_zone();
        
        if ( isalive( player ) && ( player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115_pump_roof" || player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115_gas_roof" || player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115_gas" || player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115_close_to_launchpad" || player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115" || player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115_close_to_sunken" || player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115_diner" || player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115_diner_roof" || player.var_77898ab40e53d0ae.script_zone_name == "zone_exit115_diner_parking" ) )
        {
            return;
        }
    }
    
    var_c24810cb2a758563 = [ level.firefly_main_quest.var_a35c0e09a86a04ec, level.firefly_main_quest.var_53f5aa5e19ca282e, level.firefly_main_quest.var_282fdcfedaebd2c8 ];
    
    foreach ( var_d233e16c76a2f417 in var_c24810cb2a758563 )
    {
        if ( !var_d233e16c76a2f417.isplaying )
        {
            continue;
        }
        
        lw_ent = var_d233e16c76a2f417.scene_ents[ "actors" ][ 0 ];
        
        if ( !isalive( lw_ent ) )
        {
            continue;
        }
        
        lw_ent utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_out" );
        wait 0.25;
        
        if ( isalive( lw_ent ) )
        {
            lw_ent.var_48960fedb514aedd = 1;
            lw_ent.nocorpse = 1;
            lw_ent.var_a13bed1ac47e1b2c = 1;
            lw_ent kill();
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x5dd67984, Offset: 0x1e8d9
// Size: 0x6f
function function_74801da6071cccb4( tme_location )
{
    self.tme_sbl.linkedparent.origin = tme_location + ( 0, 0, 24 );
    wait 0.5;
    self.tme_sbl utility::function_32b24db3127bff40( "body", "ready_nohealth_white" );
    wait 10;
    self.tme_sbl thread function_51e889cea6b518fe( 20 );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xb56eb7e0, Offset: 0x1e950
// Size: 0x2bf
function private function_e7d384d24c7e626b( params, effect_id )
{
    [ ent ] = self.scene_ents[ "actors" ];
    
    if ( !ent )
    {
        return;
    }
    
    if ( !ent callback::exists( #"on_ai_killed", &rm_on_ai_killed ) )
    {
        ent callback::add( #"on_ai_killed", &rm_on_ai_killed );
    }
    
    ent val::set( "mq_exit_lw", "ignoreme", 1 );
    ent val::set( "mq_exit_lw", "ammomod_immune", 1 );
    ent val::set( "mq_exit_lw", "disallow_knockdown", 1 );
    ent.health = 5000;
    ent.var_7ee152b43c7188e1 = 1;
    ent.nocorpse = 1;
    ent.no_powerups = 1;
    ent.b_ignore_death_perception = 1;
    ent.b_cleanup_no_respawn = 1;
    ent.var_825b17c932865df = 1;
    ent.var_15598d8e493afe88 = 1;
    ent.var_a13bed1ac47e1b2c = 1;
    ent.ignore_nuke_fx = 1;
    ent.var_5927d2279779cec0 = 0;
    ent.ignore_enemy_count = 1;
    ent.var_eb92c31552620100 = 1;
    ent.klaus_target = 0;
    ent.var_19238dbcc969affa = 0;
    ent.var_3807d4363cfee498 = 1;
    ent.forceannihilate = 1;
    ent.var_be5ccf6d16f6b59e = 1;
    ent.mq_zombie = 1;
    ent val::set( "mq_exit_lw", "ignore_cleanup", 1 );
    ent val::set( "mq_exit_lw", "allow_secondary_attack_damage", 1 );
    ent val::set( "mq_exit_lw", "allow_brot", 0 );
    ent val::set( "mq_exit_lw", "death", 0 );
    ent val::set( "mq_exit_lw", "damage", 0 );
    
    if ( self.isplaying )
    {
        ent val::set( "mq_exit_lw", "death", 1 );
        ent val::set( "mq_exit_lw", "damage", 1 );
        
        if ( ent && ent tagexists( "j_spineupper" ) )
        {
            level thread delay_play_fx_on_tag( 0.5, effect_id, ent, "j_spineupper" );
        }
        
        ent.isanimating = 1;
        ent.kiastring = #"zombie_kia_mission_kill";
        ent utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        level thread function_51f12524c830dd09();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 4, eflags: 0x4
// Checksum 0x64fc7a07, Offset: 0x1ec17
// Size: 0x51
function private delay_play_fx_on_tag( delay, effectid, entity, tag )
{
    level endon( #"game_ended" );
    entity endon( #"death" );
    wait delay;
    
    if ( entity )
    {
        playfxontag( effectid, entity, tag );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x720b017b, Offset: 0x1ec70
// Size: 0x211
function private function_dd99a71e4a101282( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( b_skipped )
        {
            storage_int = utility::set_bit_flag( 0, 1 );
            storage_int = utility::set_bit_flag( storage_int, 2 );
            storage_int = utility::set_bit_flag( storage_int, 3 );
            zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_7df80fbfdd3e3d9c", storage_int );
        }
        
        level thread function_4c18626961fedcc0();
        level utility::flag_set( "rm_complete" );
        
        if ( !level zm_quest::function_b0a5181ebe7bb905() )
        {
            level scriptable::function_dc174fecebb79952( &storm_lamp );
            
            if ( level.a_lamps )
            {
                foreach ( lamp in level.a_lamps )
                {
                    lamp setscriptablepartstate( "sparks", "off" );
                    lamp.active = 0;
                }
            }
        }
    }
    
    level utility::flag_wait( "rm_complete" );
    level scriptable::function_dc174fecebb79952( &storm_lamp );
    
    if ( !function_dc6a8903cbb1d35a() && level.firefly_main_quest.var_f2b547d6a287fbb6 == #"hash_a9ec022910499c23" )
    {
        level zm_quest::function_fb3af5600f6a9441( 0, 1, #"sat_zm_quest_firefly_ui", #"hash_a9ec022910499c23" );
        level.firefly_main_quest.var_f2b547d6a287fbb6 = undefined;
    }
    
    level callback::remove( "on_round_end", &reset_storm_check );
    level callback::remove( "on_round_start", &function_9341edf52a130859 );
    level callback::remove( #"europa_activated", &function_d5f365891568f2e3 );
    level callback::remove( #"europa_return_to_chair", &function_eb72bd0fbdf08bba );
    level callback::remove( "zone_changed", &cleanup_exit_zombies );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x6116267a, Offset: 0x1ee89
// Size: 0x1d
function private function_7a1543589492469e( b_skipped, b_save_restored )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x5269226b, Offset: 0x1eeae
// Size: 0x2f
function private function_35b389162ffda45c( b_skipped, b_save_restored )
{
    level utility::flag_wait( "MQ_STEP_18_SUBPART_1_PART_1_COMPLETE" );
    level utility::flag_wait( "MQ_STEP_18_SUBPART_1_PART_2_COMPLETE" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x7034237, Offset: 0x1eee5
// Size: 0xa4
function private function_485887b4007e47ad( b_skipped, b_save_restored )
{
    if ( b_skipped && !b_save_restored )
    {
        foreach ( var_bc006453d24e4625 in level.firefly_main_quest.a_antennas )
        {
            var_bc006453d24e4625 function_5c05657b7f838097();
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xa364dcea, Offset: 0x1ef91
// Size: 0x46
function private function_90af5b0ee9979fb1( b_skipped, b_save_restored )
{
    if ( !level utility::flag( "MQ_STEP_18_SUBPART_2_SETUP_COMPLETE" ) )
    {
        function_6eb922f384db03c2();
    }
    
    if ( !b_skipped )
    {
        function_3123f4b0d810d110();
        level utility::flag_wait( "MQ_STEP_18_COMPLETE" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x665baf7e, Offset: 0x1efdf
// Size: 0x2b
function private function_195835814d3f5928( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        function_9967f2afb4e83953( b_save_restored );
        level thread function_75dc7be36c68240b();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xfaedc400, Offset: 0x1f012
// Size: 0x123
function private function_a0f80f5f77902345()
{
    level.firefly_main_quest.var_34d7fcb669434dc4 = utility::getstructarray( "rob_t_start", "targetname" );
    
    foreach ( struct in level.firefly_main_quest.var_34d7fcb669434dc4 )
    {
        struct function_18683c611198a2c8( struct.origin, struct.angles );
        struct.tme_sbl setscriptablepartstate( "body", "ready_nohealth" );
    }
    
    level.firefly_main_quest.var_c1b4af25d38a0549 = utility::getstructarray( "rob_tme_scramble", "targetname" );
    level function_ba700cbf48f78c97();
    
    if ( level zm_save::function_1dda3554974a999e() )
    {
        function_8e46b9f293d2d49c();
    }
    
    level utility::flag_set( "mq_rob_assets_init" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x1de6bc8d, Offset: 0x1f13d
// Size: 0x126
function private function_8e46b9f293d2d49c()
{
    level endon( #"game_ended" );
    antenna_val = zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"harnessed_antenna" );
    
    if ( antenna_val )
    {
        switch ( antenna_val )
        {
            case 1:
                level.firefly_main_quest.a_antennas[ 1 ] function_5c05657b7f838097();
                break;
            case 2:
                level.firefly_main_quest.a_antennas[ 2 ] function_5c05657b7f838097();
                break;
            case 3:
                level.firefly_main_quest.a_antennas[ 1 ] function_5c05657b7f838097();
                level.firefly_main_quest.a_antennas[ 2 ] function_5c05657b7f838097();
                break;
            default:
                assertmsg( "<dev string:xe4>" );
                break;
        }
        
        return;
    }
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"launch_code", 0 );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xa77cd45d, Offset: 0x1f26b
// Size: 0x12b
function private function_75dc7be36c68240b()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "mq_rob_assets_init" );
    level utility::flag_wait( "mq_asset_setup_complete" );
    var_6571e60aa4dd38e9 = function_c64ef284017f7618();
    
    if ( !isdefined( var_6571e60aa4dd38e9 ) )
    {
        function_833068d37e562839();
        var_6571e60aa4dd38e9 = function_c64ef284017f7618();
    }
    
    foreach ( computer_num, computer_btn in level.firefly_main_quest.var_3a88947d03fceef9 )
    {
        string_start_index = computer_num * 2;
        var_cb55da3209786166 = getsubstr( var_6571e60aa4dd38e9, string_start_index, string_start_index + 1 );
        var_3c5d0152c915b228 = getsubstr( var_6571e60aa4dd38e9, string_start_index + 1, string_start_index + 2 );
        level.firefly_main_quest.var_bbf63f26705e4e9[ computer_num ] setscriptablepartstate( "code", var_cb55da3209786166 + var_3c5d0152c915b228 );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x3fa3cf1e, Offset: 0x1f39e
// Size: 0x108
function private function_ba700cbf48f78c97()
{
    level utility::flag_clear( "MQ_STEP_18_SUBPART_1_PART_1_COMPLETE" );
    level utility::flag_clear( "MQ_STEP_18_SUBPART_1_PART_2_COMPLETE" );
    level thread function_51f12524c830dd09();
    
    foreach ( index, var_bc006453d24e4625 in level.firefly_main_quest.a_antennas )
    {
        var_bc006453d24e4625 thread function_146462c5814ca781( index );
        var_bc006453d24e4625.bullet_clip setcandamage( 1 );
        var_bc006453d24e4625.bullet_clip.health = 99999;
        var_bc006453d24e4625 thread function_6be987315176fe18();
        var_bc006453d24e4625 setscriptablepartstate( "time_vfx", "off" );
        var_bc006453d24e4625 setscriptablepartstate( "audio", "amb_fast" );
    }
    
    level thread function_e0b1bf200165ffca();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x32ca84be, Offset: 0x1f4ae
// Size: 0xf6
function private function_6be987315176fe18()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"time_harnessed" );
    
    while ( true )
    {
        self.bullet_clip waittill( #"damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon );
        player = attacker;
        
        if ( isplayer( player ) && objweapon.basename == "sat_ww_firefly_ee_zm" && player.projectile.time_charged )
        {
            function_5c05657b7f838097( attacker );
            return;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0xc
// Checksum 0x236172c7, Offset: 0x1f5ac
// Size: 0x125
function private function_146462c5814ca781( index )
{
    self notify( #"hash_e94b3da243fe58c8" );
    self endon( #"hash_e94b3da243fe58c8" );
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::ent_flag_clear( "time_harnessed" );
    self endon( #"time_harnessed" );
    
    if ( index == 0 )
    {
        wait 1;
    }
    
    if ( !self.var_4c1cb74fbd599725 )
    {
        var_4c1cb74fbd599725 = utility::spawn_tag_origin( self.origin, self.angles );
        utility::scriptable_setparententity( var_4c1cb74fbd599725 );
        self.bullet_clip linkto( var_4c1cb74fbd599725 );
        self.var_4c1cb74fbd599725 = var_4c1cb74fbd599725;
    }
    
    while ( true )
    {
        self.var_4c1cb74fbd599725 rotateby( ( 0, 180, 0 ), 0.5 );
        self.var_4c1cb74fbd599725 waittill( #"rotatedone" );
        self.var_4c1cb74fbd599725 rotateby( ( 0, 180, 0 ), 0.5 );
        self.var_4c1cb74fbd599725 waittill( #"rotatedone" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0xc
// Checksum 0x2dd539d1, Offset: 0x1f6d9
// Size: 0xff
function private function_44c4e8c77dc5f1c3()
{
    self notify( #"hash_22a104113e3dcd6" );
    self endon( #"hash_22a104113e3dcd6" );
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"rob_fail" );
    
    if ( !self.var_4c1cb74fbd599725 )
    {
        var_4c1cb74fbd599725 = utility::spawn_tag_origin( self.origin, self.angles );
        utility::scriptable_setparententity( var_4c1cb74fbd599725 );
        self.bullet_clip linkto( var_4c1cb74fbd599725 );
        self.var_4c1cb74fbd599725 = var_4c1cb74fbd599725;
    }
    
    while ( true )
    {
        self.var_4c1cb74fbd599725 rotateby( ( 0, 180, 0 ), 2 );
        self.var_4c1cb74fbd599725 waittill( #"rotatedone" );
        self.var_4c1cb74fbd599725 rotateby( ( 0, 180, 0 ), 2 );
        self.var_4c1cb74fbd599725 waittill( #"rotatedone" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x1ffe3fe, Offset: 0x1f7e0
// Size: 0xfc
function private function_5c05657b7f838097( player )
{
    if ( isdefined( player ) )
    {
        player damagefeedback::updatehitmarker( "standard", 0, 0, 0, undefined );
    }
    
    self setscriptablepartstate( "time_vfx", "time_effected" );
    self setscriptablepartstate( "audio", "amb_slow" );
    thread function_44c4e8c77dc5f1c3();
    zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"harnessed_antenna", self.index_num );
    
    if ( !utility::flag( "MQ_STEP_18_SUBPART_1_PART_1_COMPLETE" ) )
    {
        level utility::flag_set( "MQ_STEP_18_SUBPART_1_PART_1_COMPLETE" );
        
        if ( player )
        {
            level thread battlechatter_mp::trysaylocalsound( player, #"hash_5212ed7ec42f115a", 1 );
        }
    }
    else
    {
        level utility::flag_set( "MQ_STEP_18_SUBPART_1_PART_2_COMPLETE" );
        zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"harnessed_antenna", 3 );
        
        if ( player )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_f6f76c8a28c0d57c", #"bc_flavor_player_positive", 1 );
        }
    }
    
    utility::ent_flag_set( "time_harnessed" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x22ba111a, Offset: 0x1f8e4
// Size: 0x10f
function private function_3123f4b0d810d110()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "mq_asset_setup_complete" );
    level utility::flag_wait( "mq_rob_assets_init" );
    level val::set( "task_firefly_rocket_launch", "task_logic_activate", 0 );
    scriptable::scriptable_adddamagedcallback( &function_42a952e37e04b8fa );
    level thread function_8d90a438c3e65014();
    
    if ( !zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"launch_code" ) )
    {
        level function_833068d37e562839();
    }
    
    level thread function_9d00e12088190ee5();
    
    foreach ( computer_num, computer_btn in level.firefly_main_quest.var_3a88947d03fceef9 )
    {
        computer_btn thread function_28214c1e92ca8833( computer_num );
    }
    
    level thread function_51f12524c830dd09();
    level thread function_4939e613a3d41df0();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x6d73cd30, Offset: 0x1f9fb
// Size: 0x8a
function private function_e0b1bf200165ffca()
{
    foreach ( struct in level.firefly_main_quest.var_34d7fcb669434dc4 )
    {
        struct thread function_4c537fac1c57d014( "MQ_STEP_18_SUBPART_1_PART_2_COMPLETE" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x9bf178b6, Offset: 0x1fa8d
// Size: 0x159
function private function_4c537fac1c57d014( var_68b32a8bafee7061, var_135404d5ea44612a = 4 )
{
    level endon( #"game_ended" );
    self.tme_sbl.linkedparent endon( #"stop_pathing" );
    level endon( var_68b32a8bafee7061 );
    wait randomfloatrange( 0.5, var_135404d5ea44612a );
    self.tme_sbl setscriptablepartstate( "body", "pathing" );
    a_structs = self.tme_sbl.path_array;
    
    if ( !a_structs )
    {
        a_structs = [];
        a_structs[ a_structs.size ] = self.origin;
        var_ed92d3edd3eded9 = utility::getstruct( self.target, "targetname" );
        
        if ( isdefined( var_ed92d3edd3eded9 ) )
        {
            a_structs[ a_structs.size ] = var_ed92d3edd3eded9.origin;
            
            while ( isdefined( var_ed92d3edd3eded9.target ) )
            {
                var_ed92d3edd3eded9 = utility::getstruct( var_ed92d3edd3eded9.target, "targetname" );
                a_structs[ a_structs.size ] = var_ed92d3edd3eded9.origin;
            }
        }
        
        a_structs[ a_structs.size ] = self.origin;
    }
    
    while ( true )
    {
        self.tme_sbl.linkedparent utility::function_2159dd4196ff4b81( a_structs, var_135404d5ea44612a, 1, 1, 1, 1, 0.2 );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xe0728010, Offset: 0x1fbee
// Size: 0x85
function private function_8d90a438c3e65014()
{
    foreach ( struct in level.firefly_main_quest.var_34d7fcb669434dc4 )
    {
        struct thread function_e8e5721a3b8d9f8a();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x24c5d109, Offset: 0x1fc7b
// Size: 0xab
function private function_e8e5721a3b8d9f8a()
{
    level endon( #"game_ended" );
    self.tme_sbl.linkedparent notify( #"stop_curve" );
    self.tme_sbl.linkedparent notify( #"off_bezier_curve" );
    waitframe();
    var_bdd5725ddde1a788 = utility::getstruct( self.script_noteworthy, "targetname" );
    self.tme_sbl.linkedparent moveto( var_bdd5725ddde1a788.origin, 2 );
    wait 2;
    self.tme_sbl setscriptablepartstate( "body", "ready_nohealth_small" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x6e709782, Offset: 0x1fd2e
// Size: 0x90
function private function_19af7fff2800627e( b_save_restored )
{
    foreach ( struct in level.firefly_main_quest.var_34d7fcb669434dc4 )
    {
        struct thread function_e7bac44a0a1817b3( b_save_restored );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xc35b39fd, Offset: 0x1fdc6
// Size: 0xe7
function private function_e7bac44a0a1817b3( b_save_restored )
{
    level endon( #"game_ended" );
    self.tme_sbl setscriptablepartstate( "body", "ready_nohealth_white" );
    wait 5;
    self.tme_sbl utility::function_32b24db3127bff40( "body", "pathing_white" );
    s_seat = utility::getstruct( self.script_noteworthy, "targetname" );
    var_363a9bdf772ac53 = utility::getstruct( s_seat.target, "targetname" );
    self.tme_sbl.linkedparent moveto( var_363a9bdf772ac53.origin, 0.75 );
    self.tme_sbl.linkedparent waittill( #"movedone" );
    self.tme_sbl function_51e889cea6b518fe( undefined, b_save_restored );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x59183f29, Offset: 0x1feb5
// Size: 0x205
function private function_51e889cea6b518fe( var_df7ddbdfac54c14c = 10, var_5659d238633982c6 )
{
    level endon( #"game_ended" );
    self endon( #"stop_orbit" );
    
    if ( self.var_fbe467ccf23756e9 )
    {
        return;
    }
    
    self.var_fbe467ccf23756e9 = 1;
    self.linkedparent notify( #"stop_curve" );
    self.linkedparent notify( #"off_bezier_curve" );
    self.linkedparent notify( #"stop_pathing" );
    waitframe();
    utility::function_32b24db3127bff40( "body", "pathing_white_pyramid" );
    wait 1.25;
    s_pyramid = utility::getstruct( "fmq_tme_p_s_l", "targetname" );
    
    if ( !self.linkedparent )
    {
        assertmsg( "<dev string:x110>" );
        return;
    }
    
    if ( var_5659d238633982c6 )
    {
        wait randomfloatrange( 0, 4 );
    }
    else
    {
        self.linkedparent utility::function_2159dd4196ff4b81( [ self.origin, s_pyramid.origin ], var_df7ddbdfac54c14c, 1, 1, 1, 1, 0.5 );
    }
    
    if ( !isdefined( level.firefly_main_quest.var_bf0258f4b25a417d ) )
    {
        level.firefly_main_quest.var_bf0258f4b25a417d = [];
    }
    
    level.firefly_main_quest.var_bf0258f4b25a417d[ level.firefly_main_quest.var_bf0258f4b25a417d.size ] = self;
    
    if ( level.firefly_main_quest.var_bf0258f4b25a417d.size == 12 )
    {
        level.firefly_main_quest utility::ent_flag_set( "is_all_tmes_orbiting" );
    }
    
    orbit_axis = function_a4d0d29cca6913e0();
    
    while ( self.linkedparent )
    {
        self.linkedparent thread utility::follow_circle( 1465, 4, s_pyramid.origin, 1, orbit_axis, undefined, undefined, 0 );
        waitframe();
        self.linkedparent waittill( #"off_circle_move" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xbd58a96, Offset: 0x200c2
// Size: 0x137
function private function_a4d0d29cca6913e0()
{
    angle = level.firefly_main_quest.var_bf0258f4b25a417d.size * 16.363;
    
    switch ( level.firefly_main_quest.var_bf0258f4b25a417d.size + 1 )
    {
        case 1:
            return ( angle, 0, 0 );
        case 2:
            return ( angle, 30, 0 );
        case 3:
            return ( angle, 150, 0 );
        case 4:
            return ( angle, 60, 0 );
        case 5:
            return ( angle, 180, 0 );
        case 6:
            return ( angle, 90, 0 );
        case 7:
            return ( angle, 120, 0 );
        case 8:
            return ( angle, 30, 0 );
        case 9:
            return ( angle, 180, 0 );
        case 10:
            return ( angle, 150, 0 );
        case 11:
            return ( angle, 60, 0 );
        case 12:
            return ( angle, 0, 30 );
        default:
            return;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xc4849adf, Offset: 0x20201
// Size: 0x48
function private function_6eb922f384db03c2()
{
    level.firefly_main_quest.var_56c393dc73005358 = [ "110020130207", "171402100419", "041306081304", "220400151413" ];
    level utility::flag_set( "MQ_STEP_18_SUBPART_2_SETUP_COMPLETE" );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x98d8fa90, Offset: 0x20251
// Size: 0x2f
function private function_833068d37e562839()
{
    var_bcd61fd5ba205348 = randomint( 4 );
    zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"launch_code", var_bcd61fd5ba205348 );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xde06ccd7, Offset: 0x20288
// Size: 0x3c
function private function_c64ef284017f7618()
{
    var_bcd61fd5ba205348 = zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"launch_code" );
    return level.firefly_main_quest.var_56c393dc73005358[ var_bcd61fd5ba205348 ];
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x612e78a3, Offset: 0x202cd
// Size: 0x117
function private function_9d00e12088190ee5( var_bcd61fd5ba205348 )
{
    level endon( #"game_ended" );
    level endon( #"MQ_STEP_18_COMPLETE" );
    level endon( #"rob_fail" );
    var_6571e60aa4dd38e9 = function_c64ef284017f7618();
    
    while ( true )
    {
        i = 0;
        
        while ( i < var_6571e60aa4dd38e9.size )
        {
            var_cb55da3209786166 = getsubstr( var_6571e60aa4dd38e9, i, i + 1 );
            var_3c5d0152c915b228 = getsubstr( var_6571e60aa4dd38e9, i + 1, i + 2 );
            var_e2d472ed836651cd = getsubstr( var_6571e60aa4dd38e9, i + 2, i + 3 );
            fourth_digit = getsubstr( var_6571e60aa4dd38e9, i + 3, i + 4 );
            level.firefly_main_quest.var_3df89a9ad0d870d9[ 1 ] setscriptablepartstate( "symbol", var_cb55da3209786166 + var_3c5d0152c915b228 );
            level.firefly_main_quest.var_3df89a9ad0d870d9[ 2 ] setscriptablepartstate( "symbol", var_e2d472ed836651cd + fourth_digit );
            wait 2;
            i += 4;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xc518f8e8, Offset: 0x203ec
// Size: 0xfc
function private function_28214c1e92ca8833( computer_num )
{
    level endon( #"game_ended" );
    level endon( #"MQ_STEP_18_COMPLETE" );
    utility::ent_flag_clear( "button_shot" );
    self endon( #"button_shot" );
    level endon( #"rob_fail" );
    wait randomfloatrange( 0, 2 );
    string_start_index = computer_num * 2;
    
    while ( true )
    {
        for ( i = 0; i < 4 ; i++ )
        {
            number_string = level.firefly_main_quest.var_56c393dc73005358[ i ];
            var_cb55da3209786166 = getsubstr( number_string, string_start_index, string_start_index + 1 );
            var_3c5d0152c915b228 = getsubstr( number_string, string_start_index + 1, string_start_index + 2 );
            level.firefly_main_quest.var_bbf63f26705e4e9[ computer_num ] setscriptablepartstate( "code", var_cb55da3209786166 + var_3c5d0152c915b228 );
            wait 0.75;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 11, eflags: 0x4
// Checksum 0xf99ed78, Offset: 0x204f0
// Size: 0x135
function private function_42a952e37e04b8fa( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"zm_sat_firefly_mq_rob_circle" )
    {
        return;
    }
    
    if ( instance utility::ent_flag( "button_shot" ) )
    {
        return;
    }
    
    instance utility::ent_flag_set( "button_shot" );
    playsoundatpos( instance.origin, #"hash_aad611355c024e78" );
    
    if ( isplayer( eattacker ) )
    {
        level.firefly_main_quest.var_1f67860f50883a5a = eattacker;
        eattacker damagefeedback::updatehitmarker( "standard", 0, 0, 0, undefined );
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() && !instance function_14cb2495ac1427e8() )
    {
        level thread function_c0377aeb32ffe142();
        return;
    }
    
    level thread function_51f12524c830dd09();
    
    if ( !level utility::flag( "MQ_STEP_18_SUBPART_2_IN_PROGRESS" ) )
    {
        level utility::flag_set( "MQ_STEP_18_SUBPART_2_IN_PROGRESS" );
        level thread function_25adfff052a3a6ec();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x6aaaa2b6, Offset: 0x2062d
// Size: 0xed, Type: bool
function private function_14cb2495ac1427e8()
{
    monitor_num = 0;
    
    for ( i = 0; i < level.firefly_main_quest.var_3a88947d03fceef9.size ; i++ )
    {
        button = level.firefly_main_quest.var_3a88947d03fceef9[ i ];
        
        if ( self == button )
        {
            monitor_num = i;
            break;
        }
    }
    
    entered_code = level.firefly_main_quest.var_bbf63f26705e4e9[ monitor_num ] getscriptablepartstate( "code" );
    var_4ee7607ad46bd62d = function_c64ef284017f7618();
    string_start_index = monitor_num * 2;
    var_cb55da3209786166 = getsubstr( var_4ee7607ad46bd62d, string_start_index, string_start_index + 1 );
    var_3c5d0152c915b228 = getsubstr( var_4ee7607ad46bd62d, string_start_index + 1, string_start_index + 2 );
    
    if ( entered_code == var_cb55da3209786166 + var_3c5d0152c915b228 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0xc
// Checksum 0x4e1e393c, Offset: 0x20723
// Size: 0x71
function private function_25adfff052a3a6ec()
{
    self notify( #"hash_c950fafdaea23725" );
    self endon( #"hash_c950fafdaea23725" );
    level endon( #"game_ended" );
    level endon( #"MQ_STEP_18_COMPLETE" );
    level endon( #"rob_fail" );
    zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"harnessed_antenna", 0 );
    wait 300;
    level utility::flag_clear( "MQ_STEP_18_SUBPART_2_IN_PROGRESS" );
    level thread function_c0377aeb32ffe142();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x7d7987a8, Offset: 0x2079c
// Size: 0x42
function private function_4939e613a3d41df0()
{
    level endon( #"game_ended" );
    level endon( #"rob_fail" );
    level utility::array_wait( level.firefly_main_quest.var_3a88947d03fceef9, "button_shot" );
    level function_4aa0dfb4467145c9();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x3e28b2d2, Offset: 0x207e6
// Size: 0x98
function private function_4aa0dfb4467145c9()
{
    var_326b5d27a0c73e29 = "";
    
    for ( i = 0; i < level.firefly_main_quest.var_bbf63f26705e4e9.size ; i++ )
    {
        var_82e30c4150fe2cf4 = level.firefly_main_quest.var_bbf63f26705e4e9[ i ];
        code_string = var_82e30c4150fe2cf4 getscriptablepartstate( "code" );
        var_326b5d27a0c73e29 += code_string;
    }
    
    if ( var_326b5d27a0c73e29 == function_c64ef284017f7618() )
    {
        level thread function_9967f2afb4e83953();
        return;
    }
    
    level thread function_c0377aeb32ffe142();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xd83f2a58, Offset: 0x20886
// Size: 0x166
function private function_9967f2afb4e83953( b_save_restored = 0 )
{
    zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"harnessed_antenna", 3 );
    
    if ( !b_save_restored )
    {
        level thread function_6c6e6127c7bb2be1();
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::clear_all_guidance();
        level utility::flag_set( "mq_guidance_delay_update_active" );
        level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"firefly_mq_guidance", #"hash_af8dd385a89e6f86" );
        level zm_quest::function_fb3af5600f6a9441( 4, 1, #"firefly_mq_guidance", #"hash_af8dd385a89e6f86" );
        level utility::delaythread( 24.25, &utility::flag_clear, "mq_guidance_delay_update_active" );
    }
    
    level thread function_51f12524c830dd09();
    level utility::flag_set( "MQ_STEP_18_COMPLETE" );
    scriptable::function_dc174fecebb79952( &function_42a952e37e04b8fa );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"rocket_launch" );
    level thread function_218caf1aecacc4b2( b_save_restored );
    level thread function_19af7fff2800627e( b_save_restored );
    level.firefly_main_quest.var_3df89a9ad0d870d9[ 1 ] setscriptablepartstate( "symbol", "off" );
    level.firefly_main_quest.var_3df89a9ad0d870d9[ 2 ] setscriptablepartstate( "symbol", "off" );
    level val::reset( "task_firefly_rocket_launch", "task_logic_activate" );
    
    /#
        iprintln( "<dev string:x16d>" );
    #/
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x6f727efb, Offset: 0x209f4
// Size: 0x1b2
function private function_c0377aeb32ffe142( b_save_restored = 0 )
{
    level endon( #"game_ended" );
    level notify( #"rob_fail" );
    zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_c406b8b62698fbdf", 1 );
    level val::reset( "task_firefly_rocket_launch", "task_logic_activate" );
    println( "<dev string:x181>" );
    
    foreach ( var_82e30c4150fe2cf4 in level.firefly_main_quest.var_bbf63f26705e4e9 )
    {
        var_82e30c4150fe2cf4 setscriptablepartstate( "code", "off" );
    }
    
    level.firefly_main_quest.var_3df89a9ad0d870d9[ 1 ] setscriptablepartstate( "symbol", "off" );
    level.firefly_main_quest.var_3df89a9ad0d870d9[ 2 ] setscriptablepartstate( "symbol", "off" );
    level thread function_3bc6b66dd1405335();
    level function_ba700cbf48f78c97();
    
    if ( !b_save_restored )
    {
        zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"harnessed_antenna", 0 );
    }
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"launch_code", 0 );
    }
    
    level utility::flag_wait( "MQ_STEP_18_SUBPART_1_PART_1_COMPLETE" );
    level utility::flag_wait( "MQ_STEP_18_SUBPART_1_PART_2_COMPLETE" );
    level function_3123f4b0d810d110();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xec2ae9c7, Offset: 0x20bae
// Size: 0x286
function private function_218caf1aecacc4b2( b_save_restored = 0 )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "launched_rocket" ) )
    {
        return;
    }
    
    level utility::flag_set( "launched_rocket" );
    
    if ( b_save_restored )
    {
        level.firefly_main_quest.var_6d8315922e18d6ea setscriptablepartstate( "body", "rocket_launch_skip" );
        level.firefly_main_quest.var_495811384d1534d7 setscriptablepartstate( "body", "rocket_launch_skip" );
        level.firefly_main_quest.sbl_rocket freescriptable();
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread zm_utility::white_screen_flash( 1, 0.3, 1 );
        player val::set( "mq_rob", "round_spawning_ignore_player", 1 );
    }
    
    zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 0, undefined, undefined, undefined, undefined, undefined, 1 );
    level waittill( #"hash_7ec73666dfbf33a7" );
    level thread function_194fef29413ba8e6();
    level thread function_b2a020affcca9bf6();
    level.firefly_main_quest.sbl_rocket setscriptablepartstate( "body", "rocket_launch" );
    level.firefly_main_quest.var_6d8315922e18d6ea setscriptablepartstate( "body", "rocket_launch" );
    level.firefly_main_quest.var_495811384d1534d7 setscriptablepartstate( "body", "rocket_launch" );
    wait 24.25;
    level.firefly_main_quest.sbl_rocket freescriptable();
    level notify( #"delete_rocket" );
    level.firefly_main_quest.rituals_complete++;
    level thread function_4350df6f8255caf6();
    
    foreach ( player in level.players )
    {
        player val::reset_all( "mq_rob" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xd343d11f, Offset: 0x20e3c
// Size: 0x161
function private function_b2a020affcca9bf6()
{
    level endon( #"game_ended" );
    level endon( #"delete_rocket" );
    s_launch_center = utility::getstruct( "grom_r", "targetname" );
    wait 4.5;
    time = 0;
    
    while ( true )
    {
        if ( time >= 10 )
        {
            return;
        }
        
        var_f43eb6e734c44585 = getplayersinradius( s_launch_center.origin, 10000, 10000 );
        
        if ( time >= 7 )
        {
            rumble_str = "low_highfreq";
            earthquake_scale = 0.1;
        }
        else if ( time >= 4 )
        {
            rumble_str = "artillery_rumble_light";
            earthquake_scale = 0.2;
        }
        else
        {
            rumble_str = "damage_heavy";
            earthquake_scale = 0.3;
        }
        
        foreach ( player in var_f43eb6e734c44585 )
        {
            player playrumbleonentity( rumble_str );
            player earthquakeforplayer( earthquake_scale, 0.1, s_launch_center.origin, 10000 );
        }
        
        time += 0.1;
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xfa260a80, Offset: 0x20fa5
// Size: 0x151
function private function_194fef29413ba8e6()
{
    level endon( #"game_ended" );
    wait 5;
    s_center = utility::getstruct( "grom_r_center", "targetname" );
    attacker_ent = utility::spawn_script_origin( s_center.origin );
    attacker_ent.team = "team_hundred_ninety";
    timer = 0;
    
    while ( true )
    {
        if ( timer >= 4 )
        {
            attacker_ent delete();
            return;
        }
        
        a_players = getplayersinradius( s_center.origin, 205, 500 );
        
        foreach ( player in a_players )
        {
            player dodamage( player.maxhealth * 0.25, s_center.origin, level.firefly_main_quest.sbl_rocket, attacker_ent, "MOD_FIRE" );
        }
        
        wait 0.5;
        timer += 0.5;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x2b52dd4d, Offset: 0x210fe
// Size: 0x2df
function private function_5656b81fbea84944()
{
    var_22a109586adae5b6 = utility::getstruct( "fmq_vic_tme", "targetname" );
    var_22a109586adae5b6 function_18683c611198a2c8( var_22a109586adae5b6.origin, var_22a109586adae5b6.angles );
    level.firefly_main_quest.var_dee451882263a43c = var_22a109586adae5b6.tme_sbl;
    level.firefly_main_quest.var_dee451882263a43c.interact = zm_quest::function_91f9590e98d57ff6( var_22a109586adae5b6.origin, &function_a05610f92cc35d62, &function_60d20da83619570c );
    level.firefly_main_quest.var_dee451882263a43c.interact.myparent = level.firefly_main_quest.var_dee451882263a43c;
    var_473cc4eb7726e3b4 = utility::getstruct( "fmq_eve_tme", "targetname" );
    var_473cc4eb7726e3b4.origin += ( 0, 0, -16 );
    var_473cc4eb7726e3b4 function_18683c611198a2c8( var_473cc4eb7726e3b4.origin, var_473cc4eb7726e3b4.angles );
    level.firefly_main_quest.var_3e348e3ca4cd9dba = var_473cc4eb7726e3b4.tme_sbl;
    
    foreach ( rog_tme in [ var_22a109586adae5b6, var_473cc4eb7726e3b4 ] )
    {
        rog_tme.tme_sbl.path_array = [ rog_tme.origin ];
        var_ed92d3edd3eded9 = rog_tme;
        
        for ( ;; )
        {
            if ( !var_ed92d3edd3eded9.target )
            {
                break;
            }
            
            var_ed92d3edd3eded9 = utility::getstruct( var_ed92d3edd3eded9.target, "targetname" );
            rog_tme.tme_sbl.path_array[ rog_tme.tme_sbl.path_array.size ] = var_ed92d3edd3eded9.origin;
        }
    }
    
    level utility::delaythreadendon( randomfloatrange( 0.5, 4 ), [ "game_ended", "stop_victor_pathing" ], &function_7422505ad6afa4b, level.firefly_main_quest.var_dee451882263a43c );
    level utility::delaythreadendon( randomfloatrange( 0.5, 4 ), [ "game_ended", "stop_evelyn_pathing" ], &function_7422505ad6afa4b, level.firefly_main_quest.var_3e348e3ca4cd9dba );
    level utility::flag_set( "rg_tme_sbls_spawned" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xa56a8033, Offset: 0x213e5
// Size: 0x409
function private rog_setup( b_skipped, b_save_restored )
{
    if ( b_save_restored || b_skipped )
    {
        level thread function_fa364c3ce66ab7da();
        return;
    }
    
    level utility::flag_wait( "rg_tme_sbls_spawned" );
    level.firefly_main_quest.var_9fb5453968c8518c = level zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"fmq_save" ) ?? 0;
    victor_collected = utility::get_bit_flag( level.firefly_main_quest.var_9fb5453968c8518c, 1 );
    reels_collected = utility::get_bit_flag( level.firefly_main_quest.var_9fb5453968c8518c, 2 );
    
    foreach ( player in level.players )
    {
        player utility::player_prestream_assets( "firefly_moviescreen", "model", [ "sat_zm_firefly_moviescreen_01" ], [ 500 ], -1 );
    }
    
    level callback::remove( #"player_spawned", &function_72e1aba0d44ce004 );
    level callback::add( #"player_spawned", &function_72e1aba0d44ce004 );
    
    if ( victor_collected )
    {
        level notify( #"stop_victor_pathing" );
        level.firefly_main_quest.var_dee451882263a43c thread function_51e889cea6b518fe( undefined, 1 );
        level.firefly_main_quest utility::ent_flag_set( "fmq_interact_vic" );
    }
    else
    {
        level.firefly_main_quest.var_dee451882263a43c utility::function_32b24db3127bff40( "body", "ready_nohealth" );
        level.firefly_main_quest utility::ent_flag_wait( "fmq_interact_vic" );
    }
    
    level.firefly_main_quest.var_9fb5453968c8518c = utility::set_bit_flag( level.firefly_main_quest.var_9fb5453968c8518c, 1 );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"fmq_save", level.firefly_main_quest.var_9fb5453968c8518c );
    
    if ( isdefined( level.projector_mdl ) )
    {
        playsoundatpos( level.projector_mdl.origin, #"hash_fa58ad77bf3a4eee" );
    }
    
    level thread function_51f12524c830dd09();
    
    if ( reels_collected )
    {
        level notify( #"stop_evelyn_pathing" );
        level.firefly_main_quest.var_3e348e3ca4cd9dba.linkedparent.origin = level.firefly_main_quest.var_3e348e3ca4cd9dba.path_array[ 0 ];
        level.firefly_main_quest utility::ent_flag_set( "fmq_reels_collected" );
        level thread function_fa364c3ce66ab7da();
    }
    else
    {
        level thread rog_projections();
        level callback::add( "ww_magic_missile_fired", &function_3793facd02bf9221 );
        level callback::add( "ww_missle_fired", &function_6b40368c86254203 );
        level scriptable::scriptable_adddamagedcallback( &function_b051dba289496384 );
        level.firefly_main_quest utility::ent_flag_wait( "fmq_reels_collected" );
    }
    
    level.firefly_main_quest.var_9fb5453968c8518c = utility::set_bit_flag( level.firefly_main_quest.var_9fb5453968c8518c, 2 );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"fmq_save", level.firefly_main_quest.var_9fb5453968c8518c );
    level.firefly_main_quest.s_projection.sbl utility::function_32b24db3127bff40( "model", "hidden" );
    level thread function_51f12524c830dd09();
    level.firefly_main_quest.var_3e348e3ca4cd9dba utility::function_32b24db3127bff40( "body", "ready_nohealth" );
    level function_7caf5224324fdf07();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x516a7ae8, Offset: 0x217f6
// Size: 0x2a
function private function_72e1aba0d44ce004( spawndata )
{
    utility::player_prestream_assets( "firefly_moviescreen", "model", [ "sat_zm_firefly_moviescreen_01" ], undefined, -1 );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xcf4f591a, Offset: 0x21828
// Size: 0x11b
function private function_7422505ad6afa4b( sbl_tme )
{
    sbl_tme.linkedparent endon( #"stop_pathing" );
    sbl_tme utility::function_32b24db3127bff40( "body", "pathing" );
    
    while ( level.firefly_main_quest.var_7be076c9078045aa < 5 )
    {
        sbl_tme.linkedparent utility::function_2159dd4196ff4b81( sbl_tme.path_array, 4, 1, 1, 1, 0.5, 1 );
    }
    
    sbl_tme.linkedparent notify( #"stop_curve" );
    sbl_tme.linkedparent notify( #"off_bezier_curve" );
    waitframe();
    sbl_tme.linkedparent moveto( sbl_tme.path_array[ 0 ], 2 );
    wait 3;
    state = level.firefly_main_quest.var_3e348e3ca4cd9dba == sbl_tme ? "hide" : "ready_nohealth";
    
    if ( sbl_tme )
    {
        sbl_tme utility::function_32b24db3127bff40( "body", state );
    }
    
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xb9e6c16b, Offset: 0x2194b
// Size: 0x1c9
function private function_a05610f92cc35d62( player )
{
    if ( !isdefined( player ) || player.interactions_disabled || level.firefly_main_quest utility::ent_flag( "fmq_interact_vic" ) )
    {
        return;
    }
    
    if ( !self.myparent utility::function_9f2c41c1dcc8c94( "body", "ready_nohealth" ) )
    {
        return;
    }
    
    level.firefly_main_quest utility::ent_flag_set( "fmq_interact_vic" );
    
    /#
        iprintlnbold( "<dev string:x194>" );
    #/
    
    level.firefly_main_quest.var_dee451882263a43c utility::function_32b24db3127bff40( "body", "ready_nohealth_white" );
    level.firefly_main_quest.var_dee451882263a43c utility::delaythread( 8, &function_51e889cea6b518fe );
    
    if ( player namespace_c0b4f2882c9d100f::is_maya() )
    {
        react_banter = #"hash_59bba2317fab1491";
        var_677488369eba3eea = #"hash_898d876fa88cb45";
    }
    else if ( player namespace_c0b4f2882c9d100f::is_grey() )
    {
        react_banter = #"hash_59bb9f317fab0f78";
        var_677488369eba3eea = #"hash_898d576fa88c62c";
    }
    else if ( player namespace_c0b4f2882c9d100f::is_carver() )
    {
        react_banter = #"hash_59bba0317fab112b";
        var_677488369eba3eea = #"hash_898d676fa88c7df";
    }
    else
    {
        return;
    }
    
    b_played_banter = level player_banter::play_banter_vo( react_banter, [ player ] );
    
    if ( b_played_banter )
    {
        if ( player.origin )
        {
            nearby_players_origin = player.origin;
        }
        else
        {
            nearby_players_origin = self.origin;
        }
        
        a_players = getplayersinradius( nearby_players_origin, 1000 );
        
        if ( arraycontains( a_players, player ) )
        {
            a_players = arrayremove( a_players, player );
        }
        
        var_822e0221debe40e5 = level player_banter::play_banter_vo( var_677488369eba3eea, a_players );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x57a1b650, Offset: 0x21b1c
// Size: 0x1bd
function private function_7caf5224324fdf07()
{
    level endon( #"game_ended" );
    var_3e348e3ca4cd9dba = level.firefly_main_quest.var_3e348e3ca4cd9dba;
    playsoundatpos( var_3e348e3ca4cd9dba.origin, #"hash_33f12ba6a1c00405" );
    
    /#
        iprintlnbold( "<dev string:x1ac>" );
    #/
    
    var_3e348e3ca4cd9dba utility::function_32b24db3127bff40( "body", "ready_nohealth" );
    trigger = spawn( "noent_volume_trigger_radius", var_3e348e3ca4cd9dba.origin + ( 0, 0, -45 ), 0, 86, 32 );
    var_8a129ef1e3c8fc67 = trigger.origin;
    
    do
    {
        trigger waittill( #"trigger", triggeredent );
        is_evelyn_triggered = isplayer( triggeredent );
    }
    while ( !is_evelyn_triggered );
    
    trigger delete();
    
    /#
        iprintlnbold( "<dev string:x1c1>" );
    #/
    
    var_73c24546e4a40763 = utility::getstruct( "fmq_tme_p_s_l", "targetname" );
    a_players = getplayersinradius( var_8a129ef1e3c8fc67, 250 );
    level overlord::playevent( #"hash_7e5df96fd4e68c76", a_players );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"rog_complete" );
    var_3e348e3ca4cd9dba utility::function_32b24db3127bff40( "body", "ready_nohealth_white" );
    var_3e348e3ca4cd9dba utility::delaythread( 8, &function_51e889cea6b518fe );
    wait 3;
    
    /#
        iprintlnbold( "<dev string:x1e0>" );
    #/
    
    level.firefly_main_quest.var_766a71b8f84c0a8c thread scene::play( undefined, "open" );
    level.firefly_main_quest.rituals_complete++;
    level thread function_4350df6f8255caf6();
    function_13aa4b97f0bc74aa();
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x36004e73, Offset: 0x21ce1
// Size: 0xf0
function private function_60d20da83619570c( interact, player )
{
    var_3110435dbe98fbce = zm_quest::get_quest_step( #"firefly_mq", #"hash_fdfd900907cdfa82" );
    
    if ( !level zm_sat_firefly::function_24006873400b7a8() || level.firefly_main_quest utility::ent_flag( "fmq_interact_vic" ) || !var_3110435dbe98fbce.started )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( !interact.myparent utility::function_9f2c41c1dcc8c94( "body", "ready_nohealth" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"SHARED_HINTSTRINGS/HINT_ACTIVATE", #type:"HINT_NOICON" };
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0xc
// Checksum 0x478ecadb, Offset: 0x21dda
// Size: 0x410
function private rog_projections( b_show_slow = 0 )
{
    self notify( #"hash_21f6a63662846385" );
    self endon( #"hash_21f6a63662846385" );
    level endon( #"game_ended" );
    level.firefly_main_quest utility::ent_flag_set( "fmq_flash_projections" );
    level.projector_mdl setscriptablepartstate( "vfx", "time_on" );
    
    if ( b_show_slow )
    {
        if ( !level.firefly_main_quest.is_first_time_projector_shot )
        {
            level.firefly_main_quest.is_first_time_projector_shot = 1;
            
            foreach ( var_ae09d76a4daa0b7a in level.firefly_main_quest.var_1d4bf0e83d76a347 )
            {
                var_ae09d76a4daa0b7a.sbl utility::function_32b24db3127bff40( "model", "spawn" );
                var_e5cfb10c3b51186d = level zm_sat_firefly::function_24006873400b7a8() ? "ping" : "off";
                var_ae09d76a4daa0b7a.sbl setscriptablepartstate( "ping", var_e5cfb10c3b51186d );
                var_ae09d76a4daa0b7a.fx_tag = utility::spawn_model( "tag_origin", var_ae09d76a4daa0b7a.sbl.origin, vectortoangles( ( 0, 0, 1 ) ) );
            }
            
            level.firefly_main_quest utility::delaythreadendon( 1.5, "fmq_reel_shot", &function_51f12524c830dd09 );
        }
        
        foreach ( player in level.players )
        {
            player utility::player_prestream_assets( "firefly_moviescreen", "model", [ "sat_zm_firefly_moviescreen_01" ], [ 500 ], 6 );
        }
        
        level.firefly_main_quest.s_projection.sbl utility::function_32b24db3127bff40( "reactive", "frame_" + level.firefly_main_quest.s_projection.projection_order[ 0 ] );
        level.firefly_main_quest.s_projection.sbl utility::function_32b24db3127bff40( "model", "slowed" );
        wait 1;
        
        foreach ( projection in level.firefly_main_quest.s_projection.projection_order )
        {
            level.projector_mdl setscriptablepartstate( "slide_change_audio", "on" );
            wait 0.2;
            projection_state = "frame_" + projection;
            level.firefly_main_quest.s_projection.sbl utility::function_7c10ea82c1e305b8( "reactive", projection_state );
            wait 2;
        }
    }
    
    level.firefly_main_quest.s_projection.sbl utility::function_32b24db3127bff40( "model", "blurred" );
    level.projector_mdl setscriptablepartstate( "vfx", "off" );
    level.firefly_main_quest utility::ent_flag_clear( "fmq_flash_projections" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x3f9faec6, Offset: 0x221f2
// Size: 0x20d
function private function_6b40368c86254203( sparams )
{
    projectile = sparams.projectile;
    player = sparams.player;
    var_48f771d857f96884 = undefined;
    
    foreach ( var_ae09d76a4daa0b7a in level.firefly_main_quest.var_1d4bf0e83d76a347 )
    {
        if ( var_ae09d76a4daa0b7a.trig )
        {
            var_48f771d857f96884 = var_ae09d76a4daa0b7a;
            break;
        }
    }
    
    if ( !isalive( player ) || level.firefly_main_quest utility::ent_flag( "fmq_reels_shoot_cooldown" ) || !var_48f771d857f96884.trig || var_48f771d857f96884 utility::ent_flag( "was_shot" ) )
    {
        return;
    }
    
    level.firefly_main_quest notify( #"hash_d274d0ef06a89394" );
    level.firefly_main_quest endon( #"hash_d274d0ef06a89394" );
    projectile endon( #"fmq_reels_collected" );
    projectile endon( #"delay_death" );
    projectile endon( #"death" );
    player endon( #"death_or_disconnect" );
    projectile waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( !ispointinvolume( position, var_48f771d857f96884.trig, 1 ) || var_48f771d857f96884 utility::ent_flag( "was_shot" ) )
    {
        return;
    }
    
    var_48f771d857f96884 thread function_b051dba289496384( undefined, player, var_48f771d857f96884, undefined, undefined, "MOD_IMPACT", { #basename:"sat_ww_firefly_zm" } );
    projectile delete();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xfaca9477, Offset: 0x22407
// Size: 0x17c
function private function_3793facd02bf9221( sparams )
{
    projectile = sparams.projectile;
    player = sparams.player;
    
    if ( !isalive( player ) || !player.time_carrier || level.firefly_main_quest utility::ent_flag( "fmq_flash_projections" ) )
    {
        return;
    }
    
    level.firefly_main_quest notify( #"hash_15b61ce3653e5e30" );
    level.firefly_main_quest endon( #"hash_15b61ce3653e5e30" );
    player.projectile endon( #"fmq_reels_collected" );
    player.projectile endon( #"delay_death" );
    player.projectile endon( #"death" );
    player endon( #"death_or_disconnect" );
    player.projectile waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( !ispointinvolume( position, level.firefly_main_quest.vol_projector, 1 ) )
    {
        return;
    }
    
    level utility::flag_set( "projector_shot" );
    level thread rog_projections( 1 );
    player.projectile delete();
}

// Namespace zm_sat_firefly_script_mq
// Params 11, eflags: 0x4
// Checksum 0xc1293221, Offset: 0x2258b
// Size: 0x529
function private function_b051dba289496384( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "zm_sat_firefly_mq_projector_reel" )
    {
        return;
    }
    
    level.firefly_main_quest endon( #"fmq_reels_collected" );
    
    if ( !isdefined( level.firefly_main_quest.var_173f2bc430883e9a ) )
    {
        level.firefly_main_quest.var_173f2bc430883e9a = 0;
    }
    
    level.firefly_main_quest.var_7dae430f8145e423 = [];
    
    if ( smeansofdeath != "MOD_IMPACT" || objweapon.basename != "sat_ww_firefly_zm" || level.firefly_main_quest utility::ent_flag( "fmq_reels_shoot_cooldown" ) )
    {
        return;
    }
    
    level.firefly_main_quest notify( #"fmq_reel_shot" );
    level.firefly_main_quest.var_7dae430f8145e423 = arraycombineunique( level.firefly_main_quest.var_7dae430f8145e423, [ eattacker ] );
    var_dea49845d15cfd9f = level.firefly_main_quest.var_1d4bf0e83d76a347[ level.firefly_main_quest.var_173f2bc430883e9a ];
    
    if ( var_dea49845d15cfd9f != instance )
    {
        level.firefly_main_quest utility::ent_flag_set( "fmq_reels_shoot_cooldown" );
        level thread function_51f12524c830dd09();
        level.firefly_main_quest.var_173f2bc430883e9a = 0;
        
        /#
            iprintlnbold( "<dev string:x1f9>" );
        #/
        
        b_played_banter = 0;
        
        foreach ( var_5d19d9a92cae702 in level.firefly_main_quest.var_7dae430f8145e423 )
        {
            if ( isalive( var_5d19d9a92cae702 ) )
            {
                var_5d19d9a92cae702 val::set( "mq_jumpscare", "show_hud", 0 );
                var_5d19d9a92cae702 playlocalsound( #"hash_3940b62aa7f7aee4" );
                playfxontagforclients( level._effect[ "jump_scare" ], var_5d19d9a92cae702, "j_head", var_5d19d9a92cae702 );
                var_5d19d9a92cae702 thread utility::delaythread( 1.8, &val::set, "mq_jumpscare", "show_hud", 1 );
                
                if ( !isdefined( var_5d19d9a92cae702.shockname ) )
                {
                    var_5d19d9a92cae702 thread utility::delaythread( 1, &shellshock_utility_cpmp::_shellshock, %"concussion_grenade_mp", #"stun", 2, 1 );
                }
                
                damage = var_5d19d9a92cae702.health - 10;
                var_5d19d9a92cae702 dodamage( damage, var_5d19d9a92cae702.origin, instance, instance, "MOD_UNKNOWN" );
                
                if ( !b_played_banter && !var_5d19d9a92cae702.var_865506b1370069bb )
                {
                    b_played_banter = level player_banter::play_banter_vo( "jump_scare_react", [ var_5d19d9a92cae702 ] );
                    var_5d19d9a92cae702.var_865506b1370069bb = b_played_banter;
                }
            }
        }
        
        var_4cf0254c1a6537f2 = utility::array_random( level.firefly_main_quest.var_7dae430f8145e423 );
        
        if ( !b_played_banter && isplayer( var_4cf0254c1a6537f2 ) )
        {
            level thread battlechatter_mp::trysaylocalsound( var_4cf0254c1a6537f2, #"bc_flavor_player_negative" );
        }
        
        level.firefly_main_quest.var_7dae430f8145e423 = [];
        level utility::thread_on_notify( "on_round_end", &utility::ent_flag_clear, level.firefly_main_quest, level, "game_ended", "fmq_reels_shoot_cooldown" );
        level utility::thread_on_notify( "on_round_end", &function_51f12524c830dd09, level.firefly_main_quest, level, "game_ended", 0.5 );
        level utility::array_thread( level.firefly_main_quest.var_1d4bf0e83d76a347, &utility::ent_flag_clear, "was_shot" );
        return;
    }
    
    instance utility::ent_flag_set( "was_shot" );
    level.firefly_main_quest.var_173f2bc430883e9a++;
    level thread function_51f12524c830dd09();
    playsoundatpos( instance.origin, #"hash_10e3a9dfda20014b" );
    
    /#
        iprintlnbold( "<dev string:x21a>" );
    #/
    
    if ( instance.fx_tag )
    {
        playfxontag( level._effect[ #"rog_smoke" ], instance.fx_tag, "tag_origin" );
    }
    
    if ( level.firefly_main_quest.var_173f2bc430883e9a >= level.firefly_main_quest.var_1d4bf0e83d76a347.size )
    {
        if ( !level.firefly_main_quest utility::ent_flag( "fmq_reels_collected" ) )
        {
            level thread function_fa364c3ce66ab7da();
            level scriptable::function_dc174fecebb79952( &function_b051dba289496384 );
            level.firefly_main_quest utility::ent_flag_set( "fmq_reels_collected" );
            level.firefly_main_quest notify( #"fmq_reels_collected" );
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x25a1e12d, Offset: 0x22abc
// Size: 0x11d
function function_fa364c3ce66ab7da()
{
    level utility::flag_wait( "begin_round_logic" );
    var_7f2f2a0d183329d4 = utility::getstruct( "firefly_audiolog_11" );
    var_208662613acb405d = intel::spawn_intel_at_location( undefined, undefined, var_7f2f2a0d183329d4.origin, var_7f2f2a0d183329d4.angles, "zmintel_sat_firefly_audiolog_11", undefined );
    var_7f2f2d0d1833306d = utility::getstruct( "firefly_audiolog_12" );
    var_f44dd88206798a4c = intel::spawn_intel_at_location( undefined, undefined, var_7f2f2d0d1833306d.origin, var_7f2f2d0d1833306d.angles, "zmintel_sat_firefly_audiolog_12", undefined );
    var_7f2f2c0d18332e3a = utility::getstruct( "firefly_audiolog_13" );
    var_3409f6bbf7e1d73f = intel::spawn_intel_at_location( undefined, undefined, var_7f2f2c0d18332e3a.origin, var_7f2f2c0d18332e3a.angles, "zmintel_sat_firefly_audiolog_13", undefined );
    var_7f2f270d1833233b = utility::getstruct( "firefly_audiolog_14" );
    var_bcfb9594cd86d7e6 = intel::spawn_intel_at_location( undefined, undefined, var_7f2f270d1833233b.origin, var_7f2f270d1833233b.angles, "zmintel_sat_firefly_audiolog_14", undefined );
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xa936e6c7, Offset: 0x22be1
// Size: 0x216
function private function_13aa4b97f0bc74aa()
{
    if ( !level.firefly_main_quest.var_766a71b8f84c0a8c.sbl )
    {
        whistle = level.firefly_main_quest.var_766a71b8f84c0a8c scene::get_entity( "Prop 2" );
        whistle hide();
        item_bundle = getscriptbundle( %"hash_6d0c3b5492fa9e89" );
        spawnoptions = common_item::function_bc5ff2958b71a708( level.firefly_main_quest.var_766a71b8f84c0a8c.origin, level.firefly_main_quest.var_766a71b8f84c0a8c.angles );
        spawnoptions.var_fd47e835523b473f = 1;
        spawnoptions.dropradiusscale = 0;
        spawnoptions.critical = 1;
        positioningdata = common_item::function_b4bee4333994e45a( level.firefly_main_quest.var_766a71b8f84c0a8c.var_249bac45f5f72d5, level.firefly_main_quest.var_766a71b8f84c0a8c.var_a9bfdc3a96f3557 );
        level.firefly_main_quest.var_766a71b8f84c0a8c.sbl = common_item::function_2352d25db9e97696( item_bundle, 1, positioningdata, spawnoptions );
        level.firefly_main_quest.var_766a71b8f84c0a8c.sbl function_7653c765b6c7b815();
        level.firefly_main_quest.var_766a71b8f84c0a8c.sbl.disable_dragged = 1;
        level.firefly_main_quest utility::ent_flag_set( "fmq_d_w_spawned" );
        level utility::flag_set( "mq_waiting_to_commence" );
        level.firefly_main_quest.var_766a71b8f84c0a8c.sbl.interact = zm_quest::function_91f9590e98d57ff6( level.firefly_main_quest.var_766a71b8f84c0a8c.origin, &function_e06617e1b739fab9, &function_621a2e27d1f1d2df );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x997cd109, Offset: 0x22dff
// Size: 0x7b
function private function_e06617e1b739fab9( player )
{
    if ( !isalive( player ) || player.interactions_disabled || player.var_4dd755ed5fd56bbe )
    {
        return;
    }
    
    b_played_banter = level player_banter::play_banter_vo( "death_whistle_interact", [ player ] );
    
    if ( !b_played_banter )
    {
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_negative" );
    }
    
    player.var_4dd755ed5fd56bbe = 1;
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x956edab1, Offset: 0x22e82
// Size: 0x36
function private function_621a2e27d1f1d2df( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0x13d92c43, Offset: 0x22ec1
// Size: 0xa3
function private rog_cleanup( b_skipped, b_save_restored )
{
    if ( b_save_restored || b_skipped )
    {
        level utility::flag_wait( "rg_tme_sbls_spawned" );
        level notify( #"stop_victor_pathing" );
        level.firefly_main_quest.var_dee451882263a43c thread function_51e889cea6b518fe( undefined, 1 );
        level notify( #"stop_evelyn_pathing" );
        level.firefly_main_quest.var_3e348e3ca4cd9dba thread function_51e889cea6b518fe( undefined, 1 );
    }
    
    level callback::remove( "ww_magic_missile_fired", &function_3793facd02bf9221 );
    level callback::remove( "ww_missle_fired", &function_6b40368c86254203 );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xe05792ce, Offset: 0x22f6c
// Size: 0xc3b
function private tme_collection_setup( b_skipped, b_save_restored )
{
    if ( b_save_restored || b_skipped )
    {
        level.firefly_main_quest.var_be82617e5e8087bd = level.players;
        level utility::flag_clear( "pause_tessie_task_mq" );
        
        if ( !level val::get( "task_logic_activate" ) )
        {
            level val::set( "task_mq", "task_logic_activate" );
        }
        
        return;
    }
    
    level utility::flag_wait( "initial_player_spawned" );
    
    while ( !level.europa )
    {
        waitframe();
    }
    
    if ( !level callback::exists( #"europa_activated", &function_ec5cd6201700e7ce ) )
    {
        level callback::add( #"europa_activated", &function_ec5cd6201700e7ce );
    }
    
    if ( !level callback::exists( #"europa_return_to_chair", &function_ffa7fe56e1e0b59f ) )
    {
        level callback::add( #"europa_return_to_chair", &function_ffa7fe56e1e0b59f );
    }
    
    var_b83dc7ad03fc2ae7 = level zm_quest::get_quest_step( #"firefly_mq", #"hash_fdfd900907cdfa82" );
    
    if ( var_b83dc7ad03fc2ae7.b_skipped || zm_save::function_fcccc3d2a616b1c7() )
    {
        level.firefly_main_quest.var_766a71b8f84c0a8c thread scene::play( undefined, "open" );
        function_13aa4b97f0bc74aa();
    }
    
    level thread function_51f12524c830dd09();
    level.firefly_main_quest utility::ent_flag_wait( "fmq_d_w_spawned" );
    tag_align_europa_retrievable = utility::getstruct( "tag_align_europa_retrievable", "targetname" );
    position = tag_align_europa_retrievable.origin + anglestoforward( tag_align_europa_retrievable.angles ) * 3.5;
    opparams = { #failcallback:&function_907ea1ac2be9bebb, #successcallback:&function_4c0ad5d5e5a64246, #begincallback:&function_502e82b4eeebc48c, #var_8ef7781f0cbd54b9:1, #operatetype:2, #angles:tag_align_europa_retrievable.angles, #radius:64, #position:position, #target:level.firefly_main_quest.var_766a71b8f84c0a8c.sbl, #name:"fmq_d_w_pu" };
    level.europa utility::callsharedfunc( #"europa", #"hash_28df9ffe0637327e", opparams );
    level thread function_51f12524c830dd09();
    level.firefly_main_quest utility::ent_flag_wait( "fmq_d_w_pu" );
    
    foreach ( other_player in level.players )
    {
        other_player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_firefly_artifact_6" );
    }
    
    level.firefly_main_quest.var_766a71b8f84c0a8c.sbl freescriptable();
    level.europa.no_revive = 1;
    
    while ( isdefined( level.europa ) && !level.europa europa::is_activated() && !level.firefly_main_quest utility::ent_flag( "fmq_skip_final" ) )
    {
        waitframe();
    }
    
    if ( !level.firefly_main_quest utility::ent_flag( "fmq_skip_final" ) )
    {
        level.europa europa::function_cdec0e301075f132();
        
        if ( !level callback::exists( #"hash_79d24ca84454391d", &function_35c19c098aa9c9d0 ) )
        {
            level callback::add( #"hash_79d24ca84454391d", &function_35c19c098aa9c9d0 );
        }
        
        moveparams = { #forcewalk:1, #var_8ef7781f0cbd54b9:1, #angles:level.firefly_main_quest.var_7e11f868ba59df86.angles, #pos:level.firefly_main_quest.var_7e11f868ba59df86.origin, #owner:level.europa europa::get_owner() ?? level.players[ 0 ] };
        level.europa utility::callsharedfunc( #"europa", #"hash_a81108c3938eece5", moveparams );
        level thread function_51f12524c830dd09();
        level.firefly_main_quest utility::ent_flag_wait( "europa_reach_dest" );
        level thread function_51f12524c830dd09();
    }
    
    level.firefly_main_quest utility::ent_flag_wait( "is_all_tmes_orbiting" );
    level.firefly_main_quest.var_af7565197778973a = arraycopy( level.firefly_main_quest.var_bf0258f4b25a417d );
    var_ae3e24dfe43ddbb2 = utility::getstructarray( "fmq_tmes", "targetname" );
    
    for ( tme_index = 0; tme_index < level.firefly_main_quest.var_af7565197778973a.size ; tme_index++ )
    {
        var_fa80ffd30d85cba2 = int( var_ae3e24dfe43ddbb2[ tme_index ].script_noteworthy );
        
        if ( !isdefined( level.firefly_main_quest.var_ae3e24dfe43ddbb2[ var_fa80ffd30d85cba2 ] ) )
        {
            level.firefly_main_quest.var_ae3e24dfe43ddbb2[ var_fa80ffd30d85cba2 ] = [];
        }
        
        level.firefly_main_quest.var_ae3e24dfe43ddbb2[ var_fa80ffd30d85cba2 ][ level.firefly_main_quest.var_ae3e24dfe43ddbb2[ var_fa80ffd30d85cba2 ].size ] = var_ae3e24dfe43ddbb2[ tme_index ];
        var_ae3e24dfe43ddbb2[ tme_index ].var_5e29f7a2306a2b69 = [];
        var_ae3e24dfe43ddbb2[ tme_index ].var_5e29f7a2306a2b69[ "restart_start" ] = var_ae3e24dfe43ddbb2[ tme_index ].origin + ( 0, 0, 650 );
        var_ae3e24dfe43ddbb2[ tme_index ].var_5e29f7a2306a2b69[ "end" ] = var_ae3e24dfe43ddbb2[ tme_index ].origin;
    }
    
    var_4083c5ee3f4b653c = 0;
    
    while ( true )
    {
        level.firefly_main_quest utility::ent_flag_wait_all_array( [ "is_step_5_active", "is_all_tmes_orbiting" ] );
        level utility::flag_set( "progressing_mq_special_event" );
        
        /#
            iprintlnbold( "<dev string:x22d>" );
        #/
        
        level thread function_e1a721c21e59893c();
        
        if ( isdefined( level.europa ) && level.europa europa::is_activated() )
        {
            level.europa utility::callsharedfunc( #"europa", #"hash_eabd008e66cba461" );
            
            foreach ( player in level.players )
            {
                player playlocalsound( #"hash_44948eca0484badd" );
            }
            
            level.europa utility::waittill_notify_or_timeout( "europa_blow_whistle_end", 12 );
        }
        
        level.firefly_main_quest utility::ent_flag_set( "europa_blown_whistle" );
        
        if ( !level.firefly_main_quest.var_4eb5b7006685e0f1 )
        {
            level.firefly_main_quest.var_4eb5b7006685e0f1 = level player_banter::play_banter_vo( "death_whistle_react" );
        }
        
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"tme_collection" );
        playsoundatpos( ( 13735, 4300, 1247 ), #"hash_3af83f2c328ba750" );
        
        /#
            iprintlnbold( "<dev string:x24f>" );
        #/
        
        self.var_ae3e24dfe43ddbb2 = arraycopy( level.firefly_main_quest.var_ae3e24dfe43ddbb2 );
        self.var_2e9f351b04e87b7 = 0;
        self.var_92ace9f986e8d3e5 = 1;
        function_fcc4ccef22024514( var_4083c5ee3f4b653c );
        level thread zm_round_spawning::pause_round_spawning( 0, "fmq_watch_blow_dw" );
        function_bc5f6cc759608282();
        level.firefly_main_quest notify( #"hash_af378652bc1a73ce" );
        level.firefly_main_quest utility::ent_flag_clear( "is_step_5_active" );
        level utility::flag_clear( "progressing_mq_special_event" );
        level utility::flag_clear( "mq_waiting_to_commence" );
        level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"tme_collection" );
        
        if ( self.completed )
        {
            return;
        }
        
        if ( !level.firefly_main_quest utility::ent_flag( "is_step_5_complete" ) )
        {
            if ( !level.wonder_veh.tedd.var_2ac9d6e8d1c0897 )
            {
                level.wonder_veh.tedd.var_2ac9d6e8d1c0897 = 1;
                level thread function_85cacedfae0a8ed5();
            }
            
            level.firefly_main_quest.var_7e11f868ba59df86 utility::ent_flag_set( "is_on_cooldown" );
            level thread function_51f12524c830dd09();
            
            if ( self.effect )
            {
                self.effect = undefined;
                stopfxontag( self.effect, level.wonder_veh, "tag_aether_cannister" );
            }
            
            foreach ( player in level.players )
            {
                if ( zm_player::function_f37cfdf04b932a03( player ) )
                {
                    player playsoundtoplayer( "evt_mq_stp7_step_fail", player );
                }
            }
            
            level utility::array_thread( level.firefly_main_quest.var_af7565197778973a, &utility::ent_flag_clear, "is_collected" );
            function_fcc4ccef22024514( 2 );
            level waittill( #"on_round_end" );
            level.firefly_main_quest.var_7e11f868ba59df86 utility::ent_flag_clear( "is_on_cooldown" );
            level.firefly_main_quest utility::ent_flag_clear( "europa_blown_whistle" );
            level thread function_51f12524c830dd09();
            var_4083c5ee3f4b653c = 1;
            continue;
        }
        
        break;
    }
    
    var_4c293309f6c3860a = { #angles:level.firefly_main_quest.var_7e11f868ba59df86.angles, #pos:level.firefly_main_quest.var_7e11f868ba59df86.origin, #owner:level.europa europa::get_owner() ?? level.players[ 0 ] };
    level.europa utility::callsharedfunc( #"europa", #"hash_a81108c3938eece5", var_4c293309f6c3860a );
    level.europa utility::callsharedfunc( #"europa", #"hash_c3e2334e7794ce1a", 1 );
    level.europa utility::callsharedfunc( #"europa", #"hash_f611d6f3acf4e752", 0 );
    level.europa utility::callsharedfunc( #"europa", #"hash_5f5fd94d52a75c86" );
    level.europa utility::callsharedfunc( #"europa", #"hash_128edca9c946949c" );
    level.europa.no_revive = 0;
    
    if ( level.firefly_main_quest.var_7e11f868ba59df86.interact )
    {
        level.firefly_main_quest.var_7e11f868ba59df86.interact freescriptable();
    }
    
    level.firefly_main_quest.var_be82617e5e8087bd = level.players;
    b_played_banter = player_banter::play_banter_vo( "drive_success" );
    
    if ( !b_played_banter )
    {
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x39dc86c3, Offset: 0x23baf
// Size: 0x14
function private function_ec5cd6201700e7ce( sparams )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x4aba19c4, Offset: 0x23bcb
// Size: 0x14
function private function_ffa7fe56e1e0b59f( sparams )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x406ce186, Offset: 0x23be7
// Size: 0x143
function private function_85cacedfae0a8ed5()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player.bcdisabled = 1;
        level notify( "kill_queued_bc_sound_" + player.name );
    }
    
    level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_b00761a0f47cc437", 1 );
    wait 3;
    
    foreach ( player in level.players )
    {
        player.bcdisabled = 0;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x68a9544, Offset: 0x23d32
// Size: 0x208
function private function_bc5f6cc759608282()
{
    level endon( #"game_ended" );
    level.firefly_main_quest endon( #"hash_75778e23c219d770" );
    self endon( #"hash_2c4eefaf7e2b24b6" );
    var_188c41a6dcc9ad4d = gettime();
    
    while ( level.firefly_main_quest utility::ent_flag( "is_step_5_active" ) && !utility::time_has_passed( var_188c41a6dcc9ad4d, 300 ) )
    {
        corner_a = level.wonder_veh.origin + vectornormalize( anglestoforward( level.wonder_veh.angles ) ) * 160 + vectornormalize( anglestoright( level.wonder_veh.angles ) ) * 64;
        corner_b = level.wonder_veh.origin + vectornormalize( anglestoforward( level.wonder_veh.angles ) ) * 160 - vectornormalize( anglestoright( level.wonder_veh.angles ) ) * 64;
        corner_c = level.wonder_veh.origin - vectornormalize( anglestoforward( level.wonder_veh.angles ) ) * 128 - vectornormalize( anglestoright( level.wonder_veh.angles ) ) * 64;
        corner_d = level.wonder_veh.origin - vectornormalize( anglestoforward( level.wonder_veh.angles ) ) * 128 + vectornormalize( anglestoright( level.wonder_veh.angles ) ) * 64;
        
        /#
        #/
        
        var_d7df4edf6aab651d = function_8442723ed4b0bfc7( corner_a, corner_b, corner_c, corner_d );
        
        if ( var_d7df4edf6aab651d )
        {
            level thread function_9532d621d831bd5b( var_d7df4edf6aab651d, undefined, undefined, level.wonder_veh );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 4, eflags: 0x4
// Checksum 0xf4150e00, Offset: 0x23f42
// Size: 0x143
function private function_8442723ed4b0bfc7( corner_a, corner_b, corner_c, corner_d )
{
    foreach ( tme_sbl in level.firefly_main_quest.var_af7565197778973a )
    {
        if ( !tme_sbl || tme_sbl utility::ent_flag( "is_collected" ) || distancesquared( tme_sbl.origin, level.wonder_veh.origin ) > squared( 400 ) )
        {
            continue;
        }
        
        var_819f9e1c4127d91e = utility::function_3fa3de7c5aef7907( tme_sbl.origin, corner_a, corner_b, corner_c, corner_d );
        
        if ( var_819f9e1c4127d91e )
        {
            /#
                level thread debug::drawsphere( tme_sbl.origin, 8, level.framedurationseconds * 30, ( 1, 1, 1 ) );
            #/
            
            return tme_sbl;
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x47b52a1f, Offset: 0x2408e
// Size: 0x179
function private function_502e82b4eeebc48c( sparams )
{
    if ( sparams.target )
    {
        sparams.target setscriptablepartstate( sparams.target.type, "hidden" );
    }
    
    level.europa utility::callsharedfunc( #"europa", #"hash_c3e2334e7794ce1a", 0 );
    level.europa utility::callsharedfunc( #"europa", #"hash_f611d6f3acf4e752", 1 );
    
    if ( level.europa.europa.owner )
    {
        level.europa.europa.owner utility::callsharedfunc( #"europa", #"hash_461d60a67b99be95" );
    }
    
    if ( level.firefly_main_quest.var_766a71b8f84c0a8c.sbl.interact )
    {
        level.firefly_main_quest.var_766a71b8f84c0a8c.sbl.interact freescriptable();
        level.firefly_main_quest.var_766a71b8f84c0a8c.sbl.interact = undefined;
    }
    
    level.europa thread dialogue::say( #"hash_4640d2555c228f22", 1 );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x92a01a63, Offset: 0x2420f
// Size: 0x57
function private function_4c0ad5d5e5a64246( sparams )
{
    playsoundatpos( self.origin, #"hash_4295918e8e0523f3" );
    level.firefly_main_quest utility::ent_flag_set( "fmq_d_w_pu" );
    level utility::callsharedfunc( #"europa", #"hash_3ac6bb166921f4af", "fmq_d_w_pu" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xb24f9679, Offset: 0x2426e
// Size: 0x17a
function private function_907ea1ac2be9bebb( sparams )
{
    if ( !level.firefly_main_quest.var_766a71b8f84c0a8c.sbl.interact )
    {
        level.firefly_main_quest.var_766a71b8f84c0a8c.sbl.interact = zm_quest::function_91f9590e98d57ff6( level.firefly_main_quest.var_766a71b8f84c0a8c.origin, &function_e06617e1b739fab9, &function_621a2e27d1f1d2df );
    }
    
    if ( sparams.target )
    {
        sparams.target setscriptablepartstate( sparams.target.type, "visible" );
    }
    
    var_ed2e4415196b4d1c = level.europa;
    
    if ( var_ed2e4415196b4d1c && var_ed2e4415196b4d1c europa::is_activated() && !var_ed2e4415196b4d1c europa::can_think() )
    {
        var_ed2e4415196b4d1c utility::callsharedfunc( #"europa", #"hash_c3e2334e7794ce1a", 1 );
        var_ed2e4415196b4d1c utility::callsharedfunc( #"europa", #"hash_f611d6f3acf4e752", 0 );
        
        if ( var_ed2e4415196b4d1c europa::get_owner() )
        {
            var_ed2e4415196b4d1c europa::get_owner() utility::callsharedfunc( #"europa", #"hash_c7ca27e86991f1a7" );
            return;
        }
        
        var_ed2e4415196b4d1c utility::callsharedfunc( #"europa", #"hash_128edca9c946949c" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x24824855, Offset: 0x243f0
// Size: 0x19b
function private function_35c19c098aa9c9d0( sparams )
{
    level endon( #"game_ended" );
    var_ed2e4415196b4d1c = sparams.europa;
    targetpos = sparams.targetpos;
    result = sparams.result;
    var_c31ea0b4562fb886 = distancesquared( var_ed2e4415196b4d1c.origin, level.firefly_main_quest.var_7e11f868ba59df86.origin ) < 10000;
    
    if ( !result || !var_c31ea0b4562fb886 )
    {
        wait 1;
        
        /#
            iprintlnbold( "<dev string:x25c>" );
        #/
        
        player = var_ed2e4415196b4d1c europa::get_owner() ?? level.players[ 0 ];
        calloutorigin = level.firefly_main_quest.var_7e11f868ba59df86.origin;
        
        if ( !var_ed2e4415196b4d1c europa::has_command( #"hash_a81108c3938eece5" ) )
        {
            var_ed2e4415196b4d1c utility::callsharedfunc( #"europa", #"hash_a81108c3938eece5", { #pos:calloutorigin, #owner:player } );
        }
        
        return;
    }
    
    level.firefly_main_quest utility::ent_flag_set( "europa_reach_dest" );
    level callback::remove( #"hash_79d24ca84454391d", &function_35c19c098aa9c9d0 );
    
    /#
        iprintlnbold( "<dev string:x284>" );
    #/
    
    var_ed2e4415196b4d1c utility::callsharedfunc( #"europa", #"hash_6b1dc50e85b392ca" );
    var_ed2e4415196b4d1c thread function_7bfd192a693a1af2();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0xc
// Checksum 0x85029fd, Offset: 0x24593
// Size: 0x199
function private function_7bfd192a693a1af2()
{
    self notify( #"hash_37b045134969f0ff" );
    self endon( #"hash_37b045134969f0ff" );
    level endon( #"game_ended" );
    self endon( #"europa_deactivated" );
    targetangles = level.firefly_main_quest.var_7e11f868ba59df86.angles;
    fwd = anglestoforward( targetangles );
    radius = 32;
    var_5e0352b977dff8bf = 10;
    var_6c4c1759d5e9d274 = 100;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            vec = player.origin - self.origin;
            dis = length( vec );
            
            if ( dis < radius )
            {
                pushforce = max( radius - dis, var_5e0352b977dff8bf );
                
                if ( dis > 0 )
                {
                    dir = vectornormalize( vec );
                    
                    if ( vectordot( dir, fwd ) < 0 )
                    {
                        dir = fwd;
                        pushforce = var_6c4c1759d5e9d274;
                    }
                }
                else
                {
                    dir = fwd;
                }
                
                force = dir * pushforce;
                player thread europa::push_player_thread( force );
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xcd3a7e39, Offset: 0x24734
// Size: 0x29a
function private function_7c5fcba23816ef10( player, b_force_blow = 0 )
{
    level endon( #"game_ended" );
    
    if ( b_force_blow )
    {
        level.var_9075568a1189c7c9 = 1;
        level.firefly_main_quest utility::ent_flag_set( "is_step_5_active" );
        level.firefly_main_quest notify( #"is_step_5_active" );
        return;
    }
    
    if ( !level.firefly_main_quest utility::ent_flag( "europa_reach_dest" ) || level.firefly_main_quest utility::ent_flag( "is_step_5_active" ) || self.myparent utility::ent_flag( "is_on_cooldown" ) || level utility::flag( "start_final_step_vote" ) )
    {
        return;
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    level utility::flag_set( "start_final_step_vote" );
    level.var_9075568a1189c7c9 = 1;
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.init_message = &"hash_368ffead421750f5";
    var_3faf858e79cd17bb.description = &"zm_hud/start_final_encounter";
    b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb );
    
    if ( b_passed )
    {
        level thread zm_round_spawning::pause_round_spawning( 1, "fmq_watch_blow_dw" );
        level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 0, 0, 1, undefined, undefined, 0.2 );
        wait 2;
        
        if ( isplayer( player ) )
        {
            level.firefly_main_quest.var_7002a144b4b849f2 = player calloutmarkerping::function_81aa43aad6e47820( level.wonder_veh getentitynumber() );
            level.wonder_veh thread calloutmarkerping::function_3c501da3379eca0a( player, level.firefly_main_quest.var_7002a144b4b849f2, [ "complete_TME" ], undefined, 30 );
            level.firefly_main_quest.var_a5c9e2e7db282696 = player;
            
            if ( !level.firefly_main_quest.var_3f3c4c4ce0952d46 )
            {
                b_played_banter = level player_banter::play_banter_vo( "klaus_interact", [ player ] );
                
                if ( !b_played_banter )
                {
                    level thread battlechatter_mp::trysaylocalsound( player, #"hash_5212ed7ec42f115a" );
                }
                
                wait 2;
                level.europa thread dialogue::say( #"hash_36ff381158e6efda", 1 );
                level.firefly_main_quest.var_3f3c4c4ce0952d46 = 1;
            }
        }
        
        level.firefly_main_quest utility::ent_flag_set( "is_step_5_active" );
        level.firefly_main_quest notify( #"is_step_5_active" );
    }
    else
    {
        level.var_9075568a1189c7c9 = 0;
    }
    
    level utility::flag_clear( "start_final_step_vote" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xb331b3b0, Offset: 0x249d6
// Size: 0xe7
function private tme_collection_europa_hint( interact, player )
{
    if ( interact.myparent utility::ent_flag( "is_on_cooldown" ) )
    {
        return { #string:&"SHARED_HINTSTRINGS/TRAP_COOLDOWN_HINT", #type:"HINT_NOBUTTON" };
    }
    
    if ( !level zm_sat_firefly::function_24006873400b7a8() || !level.firefly_main_quest utility::ent_flag( "europa_reach_dest" ) || level.firefly_main_quest utility::ent_flag( "is_step_5_active" ) || level.firefly_main_quest utility::ent_flag( "is_step_5_complete" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"SHARED_HINTSTRINGS/HINT_ACTIVATE", #type:"HINT_NOICON" };
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x5abe8682, Offset: 0x24ac6
// Size: 0x1e1
function private function_e1a721c21e59893c()
{
    level endon( #"game_ended" );
    
    while ( !level.wonder_veh.tedd.var_dac3db85ab646dfa )
    {
        wait 1;
        a_players = getplayersinradius( level.wonder_veh.tedd.origin, 200 );
        
        if ( a_players.size > 0 && !level.wonder_veh.tedd.var_dac3db85ab646dfa )
        {
            foreach ( player in level.players )
            {
                player.bcdisabled = 1;
                level notify( "kill_queued_bc_sound_" + player.name );
            }
            
            level.wonder_veh thread utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_b01152a0f484ff3f", 1 );
            level.wonder_veh.tedd.var_dac3db85ab646dfa = 1;
        }
    }
    
    wait 3;
    
    foreach ( player in level.players )
    {
        player.bcdisabled = 0;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0xa33943fd, Offset: 0x24caf
// Size: 0x473
function private function_fcc4ccef22024514( var_705728f8241d8020 = 0 )
{
    level endon( #"game_ended" );
    is_guidance_updated = 0;
    
    for ( var_fa80ffd30d85cba2 = 1; var_fa80ffd30d85cba2 < level.firefly_main_quest.var_ae3e24dfe43ddbb2.size + 1 ; var_fa80ffd30d85cba2++ )
    {
        var_ae3e24dfe43ddbb2 = level.firefly_main_quest.var_ae3e24dfe43ddbb2[ var_fa80ffd30d85cba2 ];
        
        for ( var_128dc8dfaab81e8 = 0; var_128dc8dfaab81e8 < var_ae3e24dfe43ddbb2.size ; var_128dc8dfaab81e8++ )
        {
            var_efde2a3377644e09 = var_ae3e24dfe43ddbb2[ var_128dc8dfaab81e8 ];
            
            if ( !isdefined( var_efde2a3377644e09.tme_sbl ) )
            {
                var_efde2a3377644e09.tme_sbl = function_5d6e2127b19ad9dd( var_fa80ffd30d85cba2 );
            }
            
            var_efde2a3377644e09.tme_sbl.var_efde2a3377644e09 = var_efde2a3377644e09;
            tme_sbl = var_efde2a3377644e09.tme_sbl;
            restart_start = var_efde2a3377644e09.var_5e29f7a2306a2b69[ "restart_start" ];
            end = var_efde2a3377644e09.var_5e29f7a2306a2b69[ "end" ];
            
            if ( var_705728f8241d8020 == 0 )
            {
                var_d351bfdc03bee94a = distance( tme_sbl.linkedparent.origin, end );
                move_time = math::remap( var_d351bfdc03bee94a, 0, 15000, 5, 8 );
                move_time = clamp( move_time, 5, 8 );
            }
            
            if ( !isdefined( move_time ) )
            {
                move_time = 3.5;
            }
            
            b_draw_path = level.firefly_main_quest.s_debug.var_fe85b8b24c101f9c ?? 0;
            
            switch ( var_705728f8241d8020 )
            {
                case 0:
                    tme_sbl notify( #"stop_orbit" );
                    tme_sbl.linkedparent notify( #"interrupt_circle_move" );
                    midpoint_pos = averagepoint( [ tme_sbl.linkedparent.origin, end ] );
                    dist_midpoint = distance( tme_sbl.linkedparent.origin, midpoint_pos );
                    var_9ff7b1b7dd1448a1 = ( midpoint_pos[ 0 ], midpoint_pos[ 1 ], dist_midpoint );
                    tme_sbl utility::function_32b24db3127bff40( "body", "pathing_white" );
                    tme_sbl.linkedparent thread utility::function_8001268940441423( tme_sbl.linkedparent.origin, end, var_9ff7b1b7dd1448a1, move_time, b_draw_path );
                    tme_sbl thread utility::delaythread( move_time + 0.5, &utility::function_32b24db3127bff40, "body", "ready" );
                    break;
                case 1:
                    tme_sbl.linkedparent.origin = restart_start;
                    waitframe();
                    tme_sbl utility::function_32b24db3127bff40( "body", "pathing_white" );
                    tme_sbl.linkedparent thread utility::function_2159dd4196ff4b81( [ restart_start, end ], move_time, 1, 1, 1, 1, 0.5, b_draw_path );
                    tme_sbl thread utility::delaythread( move_time + 0.5, &utility::function_32b24db3127bff40, "body", "ready" );
                    break;
                case 2:
                    tme_sbl.linkedparent.origin = end;
                    waitframe();
                    
                    if ( !tme_sbl utility::function_9f2c41c1dcc8c94( "body", "hide" ) )
                    {
                        tme_sbl utility::function_32b24db3127bff40( "body", "pathing_white" );
                    }
                    
                    tme_sbl.linkedparent thread utility::function_2159dd4196ff4b81( [ end, restart_start ], move_time, 1, 1, 1, 1, 0.5, b_draw_path );
                    tme_sbl thread utility::delaythread( move_time + 0.5, &utility::function_32b24db3127bff40, "body", "hide" );
                    break;
                default:
                    break;
            }
        }
        
        if ( !is_guidance_updated )
        {
            is_guidance_updated = 1;
            level thread utility::delaythread( move_time + 0.5, &function_51f12524c830dd09 );
        }
        
        if ( var_705728f8241d8020 != 2 )
        {
            wait 4;
        }
    }
    
    thread_delay = move_time + 1;
    
    if ( var_705728f8241d8020 == 0 || var_705728f8241d8020 == 1 )
    {
        level.firefly_main_quest thread utility::delaythread( thread_delay, &utility::ent_flag_set, "TMEs_deployed" );
        return;
    }
    
    level.firefly_main_quest thread utility::delaythread( thread_delay, &utility::ent_flag_clear, "TMEs_deployed" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x3a9396db, Offset: 0x2512a
// Size: 0xed
function private function_5d6e2127b19ad9dd( var_fa80ffd30d85cba2 )
{
    foreach ( tme_sbl in level.firefly_main_quest.var_bf0258f4b25a417d )
    {
        if ( !isdefined( tme_sbl.var_fa80ffd30d85cba2 ) )
        {
            tme_sbl.var_fa80ffd30d85cba2 = var_fa80ffd30d85cba2;
        }
        
        if ( !tme_sbl || tme_sbl.var_fa80ffd30d85cba2 != var_fa80ffd30d85cba2 )
        {
            continue;
        }
        
        level.firefly_main_quest.var_bf0258f4b25a417d = arrayremove( level.firefly_main_quest.var_bf0258f4b25a417d, tme_sbl );
        return tme_sbl;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 5, eflags: 0x4
// Checksum 0xac8afcdd, Offset: 0x25220
// Size: 0x6e6
function private function_9532d621d831bd5b( instance, note, param, var_64ffacba090c91be, var_6ae8eee558ce035d = 0 )
{
    level endon( #"game_ended" );
    
    if ( var_64ffacba090c91be != level.wonder_veh )
    {
        return;
    }
    
    if ( instance utility::ent_flag( "is_collected" ) )
    {
        return;
    }
    
    instance utility::function_32b24db3127bff40( "body", "collected" );
    instance utility::ent_flag_set( "is_collected" );
    var_efde2a3377644e09 = instance.var_efde2a3377644e09;
    var_fa80ffd30d85cba2 = int( var_efde2a3377644e09.script_noteworthy );
    tme_num = int( var_efde2a3377644e09.script_parameters );
    tme_collection_step = level zm_quest::get_quest_step( #"firefly_mq", #"tme_collection" );
    level.wonder_veh playsound( #"hash_c49f667699f5393d" );
    
    if ( tme_collection_step.var_92ace9f986e8d3e5 != var_fa80ffd30d85cba2 )
    {
        level.firefly_main_quest utility::ent_flag_clear( "is_step_5_active" );
        return;
    }
    
    tme_collection_step.var_ae3e24dfe43ddbb2[ var_fa80ffd30d85cba2 ] = arrayremove( tme_collection_step.var_ae3e24dfe43ddbb2[ var_fa80ffd30d85cba2 ], var_efde2a3377644e09 );
    
    if ( tme_num == 12 && tme_collection_step.var_ae3e24dfe43ddbb2[ 4 ].size != 0 )
    {
        level.firefly_main_quest utility::ent_flag_clear( "is_step_5_active" );
        return;
    }
    
    if ( tme_collection_step.var_ae3e24dfe43ddbb2[ var_fa80ffd30d85cba2 ].size == 0 )
    {
        tme_collection_step.var_92ace9f986e8d3e5++;
    }
    
    tme_collection_step.var_2e9f351b04e87b7++;
    level thread function_51f12524c830dd09();
    playfxontag( level._effect[ "wonder_tme_impact" ], level.wonder_veh, "tag_origin" );
    
    if ( !level.wonder_veh.tedd.var_cc65388a7f50390e )
    {
        level.wonder_veh thread utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_b04073a0f4aca814", 1 );
        level utility::delaythread( 3, &player_banter::play_banter_vo, "wisp_run_response" );
        level.wonder_veh.tedd.var_cc65388a7f50390e = 1;
    }
    
    foreach ( _group_num, var_d19aa157ebb5b6b3 in tme_collection_step.var_ae3e24dfe43ddbb2 )
    {
        logstring( "TME Collection Info: Group " + _group_num + " has " + var_d19aa157ebb5b6b3.size + " TMEs remaining" );
        
        /#
            iprintlnbold( "<dev string:x2a7>" + _group_num + "<dev string:x2c3>" + var_d19aa157ebb5b6b3.size + "<dev string:x2c9>" );
        #/
    }
    
    logstring( "TME Collection Info: TME number " + tme_num + " collected from group " + var_fa80ffd30d85cba2 );
    
    /#
        iprintlnbold( "<dev string:x2d9>" + tme_num + "<dev string:x2fa>" + var_fa80ffd30d85cba2 );
    #/
    
    logstring( "TME Collection Info: Number of TMEs collected: " + tme_collection_step.var_2e9f351b04e87b7 );
    
    /#
        iprintlnbold( "<dev string:x311>" + tme_collection_step.var_2e9f351b04e87b7 );
    #/
    
    if ( tme_collection_step.var_92ace9f986e8d3e5 >= 5 )
    {
        level.firefly_main_quest utility::ent_flag_set( "is_step_5_complete" );
        level.firefly_main_quest utility::ent_flag_clear( "is_step_5_active" );
        level scriptable::function_65c9f35ffd4310f8( "tme_collected", &function_9532d621d831bd5b );
        playfxontag( level._effect[ "wonder_tme_cascade" ], level.wonder_veh, "tag_aether_cannister" );
        level.wonder_veh playsound( #"hash_ce22d6d9323ddb33" );
        
        foreach ( player in level.players )
        {
            player utility::hidehudenable();
            player thread zm_utility::white_screen_flash( 0.75, 0.25 );
        }
        
        return;
    }
    
    instance calloutmarkerping::function_608710c894185549();
    instance utility::function_32b24db3127bff40( "body", "pathing_white" );
    instance utility::ent_flag_set( "is_energy_flying" );
    var_e886712156d88f1f = 8;
    movetime = undefined;
    b_initial_arc = 0;
    var_427b3d2c2f8fb546 = utility::function_6f5d2e1f1ff70482( gettime() );
    
    while ( !var_6ae8eee558ce035d )
    {
        var_cb0209b713fe3e13 = utility::function_6f5d2e1f1ff70482( gettime() ) - var_427b3d2c2f8fb546;
        
        if ( var_cb0209b713fe3e13 > var_e886712156d88f1f )
        {
            targetpos = level.wonder_veh gettagorigin( "tag_aether_cannister" );
            instance.linkedparent moveto( targetpos, 0.03 );
            wait 0.03;
            break;
        }
        
        if ( !b_initial_arc )
        {
            b_initial_arc = 1;
            start = instance.linkedparent.origin;
            wait 0.5;
            targetpos = level.wonder_veh.origin + ( 0, 0, 64 );
            midpointpos = ( start + targetpos ) / 2;
            handle = ( midpointpos[ 0 ], midpointpos[ 1 ], midpointpos[ 2 ] + 164 );
            instance.linkedparent thread utility::function_8001268940441423( start, targetpos, handle, 0.5 );
        }
        else
        {
            targetpos = level.wonder_veh.origin + ( 0, 0, 64 );
            movetime = !movetime ? 0.5 : movetime / 1.25;
            movetime = clamp( movetime, 0.03, 0.5 );
            instance.linkedparent moveto( targetpos, movetime );
            wait movetime;
        }
        
        targetpos = level.wonder_veh.origin + ( 0, 0, 64 );
        distance_to_targetpos = distancesquared( targetpos, instance.linkedparent.origin );
        
        if ( distance_to_targetpos <= 250 )
        {
            break;
        }
    }
    
    level.wonder_veh playsound( #"hash_ce22d6d9323ddb33" );
    playfxontag( level._effect[ "wonder_tme_cascade" ], level.wonder_veh, "tag_aether_cannister" );
    instance utility::function_32b24db3127bff40( "body", "cascade_energy" );
    instance utility::ent_flag_clear( "is_energy_flying" );
}

// Namespace zm_sat_firefly_script_mq
// Params 2, eflags: 0x4
// Checksum 0xabd0d4f6, Offset: 0x2590e
// Size: 0x15
function private tme_collection_cleanup( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0xd4c70467, Offset: 0x2592b
// Size: 0x48a
function quest_complete_setup( b_skipped, b_save_restored )
{
    level thread zm_exfil::disable_zm_exfil( 1 );
    
    if ( level.var_a009ab14ee0d3223.isspecialround )
    {
        zm_round_logic::function_895fdc21ab019efe();
    }
    
    level utility::flag_clear( "rbz_allow_exfil" );
    level thread zm_utility::util_kill_all_zombies();
    level zm_quest::clear_all_guidance();
    
    if ( isdefined( level.firefly_main_quest.var_7002a144b4b849f2 ) && isdefined( level.firefly_main_quest.var_a5c9e2e7db282696 ) )
    {
        level.firefly_main_quest.var_a5c9e2e7db282696 calloutmarkerping::function_7c0ee9d4b604e6d6( level.firefly_main_quest.var_7002a144b4b849f2 );
    }
    
    level.wonder_veh notify( #"complete_TME" );
    level.wonder_veh vehicle_setspeed( 0, 0, 500 );
    level.firefly_main_quest.var_a7e6b7111b41fa4a = [];
    level.firefly_main_quest.var_a7e6b7111b41fa4a = arraycopy( level.wonder_veh.occupants );
    function_cdc669dbc8ea2101( level.firefly_main_quest.var_a7e6b7111b41fa4a );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isalive( player ) && arraycontains( level.firefly_main_quest.var_a7e6b7111b41fa4a, player ) )
        {
            player val::set( "fmq_last_step", "ignore_playable_area_check", 1 );
            player val::group_set( "fmq_last_step", 0 );
        }
    }
    
    wait 0.75;
    level utility::flag_waitopen( "garage_player_teleport_in_use" );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isalive( player ) && arraycontains( level.firefly_main_quest.var_a7e6b7111b41fa4a, player ) )
        {
            data = { #exittype:"INVOLUNTARY", #allowairexit:1 };
            player.var_941ebfa7d3fd44b6 = vehicle_occupancy::get_occupant_seat( level.wonder_veh, player );
            level thread vehicle_occupancy::exit( level.wonder_veh, player.var_941ebfa7d3fd44b6, player, data, 1 );
        }
    }
    
    foreach ( player in level.players )
    {
        if ( player.hidehudenabled == 1 )
        {
            player utility::hidehuddisable();
        }
        
        player val::group_reset( "fmq_last_step" );
    }
    
    foreach ( tme_sbl in level.firefly_main_quest.var_af7565197778973a )
    {
        if ( tme_sbl )
        {
            tme_sbl freescriptable();
        }
    }
    
    level zm_sat_firefly_boss_fight::start_boss_fight( 1 );
    
    foreach ( player in level.players )
    {
        player utility::hidehudenable();
    }
    
    function_47c67d976be20925();
    
    foreach ( player in level.players )
    {
        if ( player.hidehudenabled == 1 )
        {
            player utility::hidehuddisable();
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 2
// Checksum 0x9884f578, Offset: 0x25dbd
// Size: 0xbe
function quest_complete_cleanup( b_skipped, b_save_restored )
{
    completion_round = zm_utility::get_round_number();
    
    if ( completion_round >= 60 && !level.var_dd5a72f42d9c38e && !level.var_ae96560687cb440 )
    {
        level.var_dd5a72f42d9c38e = 1;
    }
    else if ( !level.var_dd5a72f42d9c38e && !level.var_ae96560687cb440 )
    {
        level.var_ae96560687cb440 = 1;
    }
    
    level callback::remove( "mq_time_grabbed", &function_e3c24efa220d05ec );
    level scriptable::function_dc174fecebb79952( &function_79097dca553af077 );
    level thread function_4294d38c433ce8c8();
    level thread function_3e15fa2daf5f4b29();
    level thread function_937dbd1392300a7e();
    level thread function_ec8d5a7ebbfc9a0c();
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x20c6db07, Offset: 0x25e83
// Size: 0x4a4
function function_47c67d976be20925( b_debug_play = 0 )
{
    level endon( #"game_ended" );
    level val::set( "outro_igc", "task_logic_activate", 0 );
    overlord::function_f2fedd3be0be82ef();
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player thread function_411dee18c9cff509();
        }
        else if ( player.inlaststand )
        {
            player thread laststand::exit( "last_stand_self_revive" );
        }
        
        player setclienttriggeraudiozone( "zm_sat_firefly_igc" );
        player val::set( "outro_igc_scene", "killstreaks", 0 );
        player val::set( "outro_igc_scene", "damage", 0 );
        player val::set( "outro_igc_scene", "freezecontrols", 1 );
        player val::set( "outro_igc_scene", "allow_movement", 0 );
        player val::set( "outro_igc_scene", "ignoreme", 1 );
        player val::set( "outro_igc_scene", "ignore_afk", 1 );
        battlechatter_mp::disablebattlechatter( player );
    }
    
    while ( !function_cb3f113c9a5d56f7( "mp_infil_zm_sat_firefly_igc_tr" ) )
    {
        waitframe();
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"end_igc" );
    playcinematicforall( "sat_cin_zm_fly_outro", 1 );
    startnoninteractivesequence();
    
    if ( isdefined( level.var_209ed49971299121 ) )
    {
        level.var_209ed49971299121.var_685ee97bdd7a6dda = 1;
        level.var_209ed49971299121 scene::play( undefined, undefined, "sat_cin_zm_fly_outro" );
    }
    
    teleport_pos = utility::getstruct( "ft_loc", "targetname" );
    
    foreach ( player in level.players )
    {
        battlechatter_mp::enablebattlechatter( player );
        player val::reset_all( "outro_igc_scene" );
        player function_e19ccf4da1a61ba7( teleport_pos.origin );
        player clearclienttriggeraudiozone();
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"end_igc" );
    stopcinematicforall( 1, 1 );
    
    if ( !b_debug_play )
    {
        utility::array_thread( level.players, &val::set, "final_vote", "ignoreme", 1 );
        var_f8e901bebcdb4c05 = zm_quest::function_3477750f338de598( teleport_pos, &"zm_sat_firefly/mission_complete_exfil", undefined, 0 );
        utility::array_thread( level.players, &val::reset, "final_vote", "ignoreme" );
    }
    
    if ( !var_f8e901bebcdb4c05 )
    {
        foreach ( player in level.players )
        {
            player function_eceef703be8d89c3( teleport_pos.origin );
        }
        
        level thread function_78f9d6116fa25d95( teleport_pos );
    }
    
    zone_manager::set_zone_enabled( "zone_boss_arena", 0 );
    level val::reset( "outro_igc", "task_logic_activate" );
    level utility::flag_clear( "pause_tessie_task_mq" );
    
    if ( !level val::get( "task_logic_activate" ) )
    {
        level val::set( "task_mq", "task_logic_activate" );
    }
    
    zm_sat_firefly_script_garage::function_d696b1e2e8b90e1d();
    function_4d2cf7ef166227();
    level thread function_cfa603ae5c0c86a6();
    level utility::flag_set( "outro_igc_completed" );
    
    foreach ( player in level.players )
    {
        if ( player.hidehudenabled == 1 )
        {
            player utility::hidehuddisable();
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0x1e3a0878, Offset: 0x2632f
// Size: 0x2
function function_4e3e29730a919174()
{
    
}

// Namespace zm_sat_firefly_script_mq
// Params 0
// Checksum 0xa9e3c375, Offset: 0x26339
// Size: 0x2
function function_f9d1c4fa910f3012()
{
    
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0xef80b424, Offset: 0x26343
// Size: 0x36
function function_78f9d6116fa25d95( teleport_pos )
{
    wait 1;
    level thread zm_quest::function_2e003fa13e881f92( teleport_pos );
    wait 33;
    zm_round_spawning::pause_round_spawning( 0, "final_scene" );
    level utility::flag_set( "rbz_allow_exfil" );
}

// Namespace zm_sat_firefly_script_mq
// Params 1
// Checksum 0x9df43fcf, Offset: 0x26381
// Size: 0x3a9
function function_51f12524c830dd09( delay )
{
    self notify( #"hash_778dd37121336354" );
    self endon( #"hash_778dd37121336354" );
    level endon( #"game_ended" );
    
    if ( level.firefly_main_quest )
    {
        level.firefly_main_quest endon( #"zm_quest_completed" );
    }
    
    var_38f42c598f72843e = level zm_quest::get_quest_step( #"firefly_pluto_upgrade", #"hash_173b92792d6221e1" );
    
    while ( !var_38f42c598f72843e.completed )
    {
        waitframe();
    }
    
    level.firefly_ww_quest utility::ent_flag_wait( "wwq_guidance_finished" );
    
    if ( delay )
    {
        wait delay;
    }
    
    quest_step = level.firefly_main_quest.steps[ level.firefly_main_quest.var_7be076c9078045aa ];
    
    if ( !level zm_sat_firefly::function_24006873400b7a8() || !level.var_cef21da19561e27d )
    {
        return;
    }
    
    level utility::flag_waitopen( "mq_guidance_delay_update_active" );
    
    if ( quest_step.ref == #"gather_ingredients" || quest_step.ref == #"hash_8e15f8805ec569f2" || quest_step.ref == #"serum_trial" )
    {
        function_791a74f050911743();
        return;
    }
    
    if ( quest_step.ref == #"hash_6862143d688fc459" )
    {
        function_a4adb7ee2a335b02();
        return;
    }
    
    if ( quest_step.ref == #"complete_rituals" )
    {
        if ( !level utility::flag( "mg_part_picked_up" ) )
        {
            utility::delaythread( 1, &zm_quest::update_guidance, [ [ level.firefly_main_quest.var_d5a2309951a61519, 45, undefined, undefined, undefined, level.firefly_main_quest.var_d5a2309951a61519 ] ], #"firefly_mq_guidance", #"hash_590a6965b5f304a9" );
            return;
        }
        else if ( !level utility::flag( "upgraded_pluto_to_stage_" + 4 ) && level utility::flag( "mg_part_picked_up" ) )
        {
            level thread zm_quest::update_guidance( [ [ level.s_garage.upgrade_station_sbl, 55, undefined, undefined, undefined, level.s_garage.upgrade_station_sbl ] ], #"firefly_mq_guidance", #"hash_ae459b6890284a0d" );
            return;
        }
        
        if ( !zm_quest::get_quest_step( #"firefly_mq", #"hash_dbc50456c0a63765" ).completed )
        {
            function_ce520b33d30de8d7();
            return;
        }
        else if ( !zm_quest::get_quest_step( #"firefly_mq", #"hash_4c25b1fbd9b6e496" ).completed )
        {
            function_c348901be13d0416();
            return;
        }
        else if ( !zm_quest::get_quest_step( #"firefly_mq", #"hash_42ce0ef6b3f2cf17" ).completed )
        {
            function_21221da02810a25();
            return;
        }
    }
    
    if ( quest_step.ref == #"hash_fdfd900907cdfa82" && !zm_quest::get_quest_step( #"firefly_mq", #"hash_fdfd900907cdfa82" ).completed )
    {
        function_1db52bce84bf07f4();
        return;
    }
    
    if ( quest_step.ref == #"tme_collection" && !zm_quest::get_quest_step( #"firefly_mq", #"tme_collection" ).completed )
    {
        function_3961c3ae0b892ad2();
        return;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xc5b1643f, Offset: 0x26732
// Size: 0x14a6
function private function_791a74f050911743()
{
    if ( !level.firefly_main_quest.player_has_w_mod && !level utility::flag( "MQ_STEP_1_SUBPART_R1" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.perk_machine.mdl_perk_machine, 124, undefined, undefined, undefined, level.firefly_main_quest.perk_machine.mdl_perk_machine ] ], #"firefly_mq_guidance", #"hash_e8765a6ac138c761" );
        return;
    }
    
    if ( level.wisps_active < 1 && !level utility::flag( "MQ_STEP_1_SUBPART_R1" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"firefly_mq_guidance", #"hash_e5e8835567232cc9" );
        return;
    }
    
    if ( level.wisps_active >= 1 && !level utility::flag( "MQ_STEP_1_SUBPART_R1" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.mirror_forgotten, 55, undefined, undefined, undefined, level.firefly_main_quest.mirror_forgotten ] ], #"firefly_mq_guidance", #"hash_91fdfbf12aa705bb" );
        return;
    }
    
    if ( !level utility::flag( "MQ_STEP_1_SUBPART_R2" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.mirror_forgotten, 55, undefined, undefined, undefined, level.firefly_main_quest.mirror_forgotten ] ], #"firefly_mq_guidance", #"hash_b146c8582b18ece8" );
        return;
    }
    
    if ( !level utility::flag( "p_lab_spawned" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.Powder, 16, undefined, undefined, undefined, level.firefly_main_quest.Powder ] ], #"firefly_mq_guidance", #"hash_3d1f44ad70efda0d" );
        return;
    }
    
    if ( !level utility::flag( "p_added_serum" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.chem_beaker, 8, undefined, undefined, undefined, level.firefly_main_quest.chem_beaker ] ], #"firefly_mq_guidance", #"hash_3df92cfcc0befaea" );
        
        if ( !level.firefly_main_quest utility::ent_flag( "player_saw_ch_bkr" ) )
        {
            level.firefly_main_quest.chem_beaker thread utility::delay_notify( 60, "cancel_player_distance_and_look_at_looping_check" );
            level.firefly_main_quest.chem_beaker zm_quest::player_distance_and_look_at_looping_check( 200, 1 );
            level.firefly_main_quest utility::ent_flag_set( "player_saw_ch_bkr" );
        }
        
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.var_e956823444b5d959.origin, 8 ] ], #"firefly_mq_guidance", #"hash_160d9f601284c92" );
        return;
    }
    
    if ( !level.firefly_main_quest utility::ent_flag( "player_saw_ingr" ) )
    {
        if ( zm_save::function_1dda3554974a999e() )
        {
            level.firefly_main_quest utility::ent_flag_set( "player_saw_ingr" );
            level thread function_51f12524c830dd09();
            return;
        }
        
        var_9fc968fd7f780d1a = utility::getstructarray( "s_r", "targetname" );
        level thread zm_quest::update_guidance( [ [ var_9fc968fd7f780d1a[ 1 ].origin, 8 ] ], #"firefly_mq_guidance", #"hash_3eb3edc87a5943e9" );
        level zm_quest::function_9f49b2a045ece8ae( 0, 1, #"firefly_mq_guidance", #"hash_3eb3edc87a5943e9" );
        
        if ( !level.firefly_main_quest utility::ent_flag( "player_saw_ingr" ) )
        {
            wait 4;
            var_9fc968fd7f780d1a[ 1 ] thread utility::delay_notify( 10, "cancel_player_distance_and_look_at_for_duration_looping_check" );
            var_9fc968fd7f780d1a[ 1 ] zm_quest::player_distance_and_look_at_for_duration_looping_check( 300, 1, 3 );
            level.firefly_main_quest utility::ent_flag_set( "player_saw_ingr" );
        }
        
        level thread function_51f12524c830dd09();
        return;
    }
    
    if ( level.firefly_main_quest.correct_ingredients.size != level.firefly_main_quest.var_f728ac4d2490fb1c.size )
    {
        ingredient_code = undefined;
        
        for ( i = 0; i < level.firefly_main_quest.var_f728ac4d2490fb1c.size ; i++ )
        {
            ingredient_code = level.var_742bd7779adb2b90[ i ];
            
            if ( isdefined( ingredient_code ) && arraycontains( level.firefly_main_quest.correct_ingredients, ingredient_code ) )
            {
                continue;
            }
            
            break;
        }
        
        if ( !isdefined( ingredient_code ) )
        {
            return;
        }
        
        switch ( ingredient_code )
        {
            case #"hash_31100fbc01bd387c":
                if ( level utility::flag( "s_lab_spawned" ) )
                {
                    step_ref = #"hash_b6cd99456e09fe30";
                    break;
                }
                
                while ( !level.firefly_main_quest.shell_ingr && !level utility::flag( "s_lab_spawned" ) )
                {
                    hud_data = [];
                    
                    foreach ( og_struct in level.var_58811afe83422174 )
                    {
                        foreach ( var_e66db791ea75a85d in og_struct.var_395649a1ecde9e39 )
                        {
                            if ( var_e66db791ea75a85d.sbl utility::function_9f2c41c1dcc8c94( "body", "dead" ) || var_e66db791ea75a85d.sbl.var_628c20d6dce0f )
                            {
                                continue;
                            }
                            
                            hud_data[ hud_data.size ] = [ var_e66db791ea75a85d.sbl, 55, undefined, undefined, undefined, var_e66db791ea75a85d.sbl ];
                        }
                    }
                    
                    step_ref = #"hash_61ad1823c71daf54";
                    level thread zm_quest::update_guidance( hud_data, #"firefly_mq_guidance", step_ref );
                    level zm_quest::function_9f49b2a045ece8ae( level.firefly_main_quest.correct_ingredients.size, 1, #"firefly_mq_guidance", step_ref );
                    wait 2;
                }
                
                if ( !level utility::flag( "s_lab_spawned" ) )
                {
                    step_ref = #"hash_b6cd99456e09fe30";
                    level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.shell_ingr, 8, undefined, undefined, undefined, level.firefly_main_quest.shell_ingr ] ], #"firefly_mq_guidance", step_ref );
                    level zm_quest::function_9f49b2a045ece8ae( level.firefly_main_quest.correct_ingredients.size, 1, #"firefly_mq_guidance", step_ref );
                    level utility::flag_wait( "s_lab_spawned" );
                }
                
                break;
            case #"hash_311012bc01bd3d35":
                if ( level utility::flag( "m_lab_spawned" ) )
                {
                    step_ref = #"hash_7e41fb8ba608849a";
                    break;
                }
                
                if ( !level utility::flag( "MQ_STEP_1_SUBPART_M2" ) )
                {
                    step_ref = #"hash_b21a54c22373c4d1";
                    level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.m_jar, 8, undefined, undefined, undefined, level.firefly_main_quest.m_jar ] ], #"firefly_mq_guidance", step_ref );
                }
                else if ( !level utility::flag( "MQ_STEP_1_SUBPART_M1" ) )
                {
                    step_ref = #"hash_bbf7a7e8035b15a";
                    level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.horse_growth, 16, undefined, undefined, undefined, level.firefly_main_quest.horse_growth ] ], #"firefly_mq_guidance", step_ref );
                }
                else if ( !level utility::flag( "m_ready" ) )
                {
                    step_ref = #"hash_cd6634fbc59ab8df";
                    level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.horse_growth, 16, undefined, undefined, undefined, level.firefly_main_quest.horse_growth ] ], #"firefly_mq_guidance", step_ref );
                }
                else if ( !level utility::flag( "m_lab_spawned" ) )
                {
                    step_ref = #"hash_7e41fb8ba608849a";
                    level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.mushroom_ingredient, 16, undefined, undefined, undefined, level.firefly_main_quest.mushroom_ingredient ] ], #"firefly_mq_guidance", step_ref );
                    level zm_quest::function_9f49b2a045ece8ae( level.firefly_main_quest.correct_ingredients.size, 1, #"firefly_mq_guidance", step_ref );
                    level utility::flag_wait( "m_lab_spawned" );
                }
                
                break;
            case #"hash_31100cbc01bd33c3":
                if ( level utility::flag( "e_lab_spawned" ) )
                {
                    step_ref = #"hash_e48692b8ee08d206";
                    break;
                }
                
                if ( !level utility::flag( "MQ_STEP_1_SUBPART_S1" ) )
                {
                    saw_blade_traps = utility::getstructarray( "saw_blade_trap_switch", "targetname" );
                    hud_data = [];
                    
                    foreach ( trap in saw_blade_traps )
                    {
                        foreach ( trap_switch in trap.a_switch_pos )
                        {
                            hud_data[ hud_data.size ] = [ trap_switch.switch_scriptable, 8, undefined, undefined, undefined, trap_switch.switch_scriptable ];
                        }
                    }
                    
                    step_ref = #"hash_976ac48ef88ca2ce";
                    level thread zm_quest::update_guidance( hud_data, #"firefly_mq_guidance", step_ref );
                }
                else if ( !level utility::flag( "e_lab_spawned" ) )
                {
                    step_ref = #"hash_e48692b8ee08d206";
                    level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.shade_eye, 8, undefined, undefined, undefined, level.firefly_main_quest.shade_eye ] ], #"firefly_mq_guidance", step_ref );
                    level zm_quest::function_9f49b2a045ece8ae( level.firefly_main_quest.correct_ingredients.size, 1, #"firefly_mq_guidance", step_ref );
                    level utility::flag_wait( "e_lab_spawned" );
                }
                
                break;
            case #"hash_31100bbc01bd3230":
                if ( level utility::flag( "b_lab_spawned" ) )
                {
                    step_ref = #"hash_7359652c3ecdf223";
                    break;
                }
                
                if ( !level.burn_foot && !level.firefly_main_quest.bone )
                {
                    step_ref = #"hash_b8c0e592bca3ee5b";
                    s_barn_body = utility::getstruct( "bb_hang", "targetname" );
                    level thread zm_quest::update_guidance( [ [ s_barn_body.origin, -56 ] ], #"firefly_mq_guidance", step_ref );
                }
                else if ( !level.firefly_main_quest.bone )
                {
                    step_ref = #"hash_525bd29de454184e";
                    level thread zm_quest::update_guidance( [ [ level.burn_foot, 8, undefined, undefined, undefined, level.burn_foot ] ], #"firefly_mq_guidance", step_ref );
                }
                else if ( !level utility::flag( "b_lab_spawned" ) )
                {
                    step_ref = #"hash_7359652c3ecdf223";
                    level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.bone, 8, undefined, undefined, undefined, level.firefly_main_quest.bone ] ], #"firefly_mq_guidance", step_ref );
                    level zm_quest::function_9f49b2a045ece8ae( level.firefly_main_quest.correct_ingredients.size, 1, #"firefly_mq_guidance", step_ref );
                    level utility::flag_wait( "b_lab_spawned" );
                }
                
                break;
            default:
                break;
        }
        
        if ( step_ref )
        {
            level zm_quest::function_9f49b2a045ece8ae( level.firefly_main_quest.correct_ingredients.size, 1, #"firefly_mq_guidance", step_ref );
        }
        
        return;
    }
    
    if ( level utility::flag( "fmq_serum_cooldown" ) || level utility::flag( "lt_failed" ) )
    {
        step_ref = level utility::flag( "fmq_serum_cooldown" ) ? #"hash_89ba593065cdd2b8" : #"hash_b09ab7ffdf622c66";
        level zm_quest::function_fb3af5600f6a9441( 3, 1, #"firefly_mq_guidance", step_ref );
        level utility::delaythread( 2, &zm_quest::update_guidance, [ [ level.firefly_main_quest.chem_beaker, 8, undefined, undefined, undefined, level.firefly_main_quest.chem_beaker ] ], #"firefly_mq_guidance", #"hash_8d5be3b8fb4d54e6" );
        return;
    }
    
    if ( !level utility::flag( "serum_brewed" ) )
    {
        var_9fc968fd7f780d1a = utility::getstructarray( "s_r", "targetname" );
        
        if ( !level.firefly_main_quest utility::ent_flag( "player_give_ser_attempt" ) )
        {
            level thread zm_quest::update_guidance( [ [ var_9fc968fd7f780d1a[ 1 ].origin ] ], #"firefly_mq_guidance", #"hash_89ba593065cdd2b8" );
            level zm_quest::function_9f49b2a045ece8ae( level.ingredients_added.size, 1, #"firefly_mq_guidance", #"hash_89ba593065cdd2b8" );
            level.firefly_main_quest.chem_beaker zm_quest::player_distance_and_look_at_looping_check( 200, 1 );
            
            if ( !isdefined( level.firefly_main_quest.player_give_ser_attempt_time ) )
            {
                level.firefly_main_quest.player_give_ser_attempt_time = 45;
            }
            
            while ( level.firefly_main_quest.player_give_ser_attempt_time > 0 )
            {
                wait 1;
                level.firefly_main_quest.player_give_ser_attempt_time--;
            }
            
            level.firefly_main_quest utility::ent_flag_set( "player_give_ser_attempt" );
        }
        
        ingredient_code = undefined;
        
        for ( i = 0; i < level.var_742bd7779adb2b90.size ; i++ )
        {
            ingredient_code = level.var_742bd7779adb2b90[ i ];
            
            if ( level.ingredients_added[ i ] == ingredient_code )
            {
                continue;
            }
            
            break;
        }
        
        if ( !isdefined( ingredient_code ) )
        {
            return;
        }
        
        hud_data = [];
        
        switch ( ingredient_code )
        {
            case #"hash_31100fbc01bd387c":
                hud_data[ hud_data.size ] = [ level.firefly_main_quest.lab_shell, 8, undefined, undefined, undefined, level.firefly_main_quest.lab_shell ];
                break;
            case #"hash_311012bc01bd3d35":
                hud_data[ hud_data.size ] = [ level.firefly_main_quest.lab_mushroom, 8, undefined, undefined, undefined, level.firefly_main_quest.lab_mushroom ];
                break;
            case #"hash_311011bc01bd3ba2":
                hud_data[ hud_data.size ] = [ level.firefly_main_quest.lab_tentacle, 8, undefined, undefined, undefined, level.firefly_main_quest.lab_tentacle ];
                break;
            case #"hash_31100cbc01bd33c3":
                hud_data[ hud_data.size ] = [ level.firefly_main_quest.lab_eye, 8, undefined, undefined, undefined, level.firefly_main_quest.lab_eye ];
                break;
            case #"hash_31100bbc01bd3230":
                hud_data[ hud_data.size ] = [ level.firefly_main_quest.lab_bone, 8, undefined, undefined, undefined, level.firefly_main_quest.lab_bone ];
                break;
            default:
                hud_data[ hud_data.size ] = [ level.firefly_main_quest.chem_beaker, 8, undefined, undefined, undefined, level.firefly_main_quest.chem_beaker ];
                break;
        }
        
        level thread zm_quest::update_guidance( hud_data, #"firefly_mq_guidance", #"hash_89ba593065cdd2b8" );
        level zm_quest::function_9f49b2a045ece8ae( level.ingredients_added.size, 1, #"firefly_mq_guidance", #"hash_89ba593065cdd2b8" );
        return;
    }
    
    if ( !level.firefly_main_quest utility::ent_flag( "player_give_blood" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.chem_beaker, 8, undefined, undefined, undefined, level.firefly_main_quest.chem_beaker ] ], #"firefly_mq_guidance", #"hash_be5ef4333758542c" );
        level.firefly_main_quest utility::ent_flag_wait( "player_give_blood" );
        return;
    }
    
    if ( !level utility::flag( "serum_t_complete" ) )
    {
        var_eb0bc8edbe24edfb = function_b98c2845fd69209e();
        
        if ( level.var_deadcacf8f58a5d2 == var_eb0bc8edbe24edfb )
        {
            level zm_quest::function_fb3af5600f6a9441( 4, 1, #"firefly_mq_guidance", #"hash_b09ab7ffdf622c66" );
            level zm_quest::function_b5d75b34f712db9a();
            return;
        }
        
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.chem_beaker, 8, undefined, undefined, undefined, level.firefly_main_quest.chem_beaker ] ], #"firefly_mq_guidance", #"hash_b09ab7ffdf622c66" );
        num_killed = level.var_deadcacf8f58a5d2 ?? 0;
        
        if ( var_eb0bc8edbe24edfb )
        {
            progress = num_killed / var_eb0bc8edbe24edfb * 100;
        }
        
        level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"firefly_mq_guidance", #"hash_b09ab7ffdf622c66" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xd1064775, Offset: 0x27be0
// Size: 0x1cc
function private function_a4adb7ee2a335b02()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "MQ_STEP_10_INITIALIZED" );
    level utility::flag_wait( "MQ_STEP_13_INITIALIZED" );
    
    if ( !level utility::flag( "observed_serum_changes_in_ashwood" ) && !level utility::flag( "found_entity_box" ) && level.firefly_main_quest.entity_box )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.entity_box.origin + ( -100, -1300, 0 ), 250 ], [ level.firefly_main_quest.entity_box.origin + ( -100, -1300, 0 ), undefined, 1400 ] ], #"firefly_mq_guidance", #"hash_1b9aca16185ac4f8" );
        return;
    }
    
    if ( !level utility::flag( "found_entity_box" ) && level.firefly_main_quest.entity_box )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.entity_box, 55, undefined, undefined, undefined, level.firefly_main_quest.entity_box ] ], #"firefly_mq_guidance", #"hash_1ad960e9b2cb4980" );
        return;
    }
    
    if ( !level utility::flag( "MQ_STEP_10_COMPLETE" ) )
    {
        b_success = function_100a16008cb8bf2f( "zmloot_quest_firefly_k_3" );
        
        if ( !isdefined( b_success ) )
        {
            b_success = function_100a16008cb8bf2f( "zmloot_quest_firefly_k_2" );
        }
        
        if ( !isdefined( b_success ) )
        {
            b_success = function_100a16008cb8bf2f( "zmloot_quest_firefly_k_1" );
        }
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 3, eflags: 0x4
// Checksum 0x1865d945, Offset: 0x27db4
// Size: 0xce, Type: bool
function private function_7c15639ab6d0e803( var_f4790684f1cd3da2, var_eb4cfd1207256b2, var_3cfd3b385aca460b )
{
    if ( !function_3c5e0dd66dd7487f() && level.time_collected == 4 )
    {
        level thread zm_quest::update_guidance( undefined, #"firefly_mq_guidance", var_3cfd3b385aca460b );
        return true;
    }
    else if ( !level utility::flag( "time_grabbed" ) && !function_3c5e0dd66dd7487f() && !level.time_collected )
    {
        level thread zm_quest::update_guidance( function_28d09d3428eb3710(), #"firefly_mq_guidance", var_f4790684f1cd3da2 );
        return true;
    }
    else if ( level.clock_vfx && !function_3c5e0dd66dd7487f() )
    {
        level thread zm_quest::update_guidance( function_28d09d3428eb3710(), #"firefly_mq_guidance", var_eb4cfd1207256b2 );
        return true;
    }
    
    return false;
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x4ee6e936, Offset: 0x27e8b
// Size: 0x9f3
function private function_ce520b33d30de8d7()
{
    if ( !level.firefly_main_quest utility::ent_flag( "knock_head" ) )
    {
        if ( !function_3c5e0dd66dd7487f() && function_7c15639ab6d0e803( #"hash_5e3e5583a87ad20f", #"hash_9618352a169e3b2b", #"hash_c7320ef1ded8d812" ) )
        {
            return;
        }
        else if ( function_3c5e0dd66dd7487f() )
        {
            farm_clock = utility::getstruct( "f_c", "targetname" );
            
            if ( !level.firefly_main_quest utility::ent_flag( "player_saw_f_c" ) && !zm_save::function_1dda3554974a999e() )
            {
                level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.farm_clock, undefined, undefined, undefined, undefined, level.firefly_main_quest.farm_clock ] ], #"firefly_mq_guidance", #"hash_6354a137ebb829ed" );
                farm_clock zm_quest::player_distance_and_look_at_looping_check( 300, 1 );
                farm_clock thread utility::delay_notify( 45, "cancel_player_distance_and_look_at_looping_check" );
                farm_clock zm_quest::player_distance_and_look_at_looping_check( 130, 1 );
                level.firefly_main_quest utility::ent_flag_set( "player_saw_f_c" );
                level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.var_898dc8ebeafff41c, 0, 250 ], [ level.firefly_main_quest.var_898dc8ebeafff41c ] ], #"firefly_mq_guidance", #"hash_13336f755b3f5925" );
                wait 45;
            }
            
            if ( level.var_a1ec83b385e3b000.size == 0 )
            {
                level thread zm_quest::update_guidance( [ [ level.farm_clock_trigger.origin ] ], #"firefly_mq_guidance", #"hash_13336f755b3f5925" );
            }
            
            if ( level.var_a1ec83b385e3b000.size > 0 && !level utility::flag( "rt_head_rotation_complete" ) )
            {
                level thread zm_quest::update_guidance( [ [ level.farm_clock_trigger.origin ] ], #"firefly_mq_guidance", #"hash_dd3d8fbbffe38303" );
            }
            else if ( level utility::flag( "rt_head_rotation_complete" ) && !level utility::flag( "knock_head" ) )
            {
                level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.var_9569ed39e1646d45.origin ] ], #"firefly_mq_guidance", #"hash_a6001ddf00422611" );
            }
        }
        
        return;
    }
    
    if ( !level.firefly_main_quest utility::ent_flag( "rt_item_1_collected" ) || !level.firefly_main_quest utility::ent_flag( "rt_item_2_collected" ) || !level.firefly_main_quest utility::ent_flag( "rt_item_3_collected" ) || !level.firefly_main_quest utility::ent_flag( "rt_item_4_collected" ) )
    {
        if ( !level.firefly_main_quest utility::ent_flag( "rt_clear_hud_objects_for_spiral" ) )
        {
            level.firefly_main_quest utility::ent_flag_set( "rt_clear_hud_objects_for_spiral" );
            level thread zm_quest::update_guidance( undefined, #"firefly_mq_guidance", #"hash_f187490f12e85cb7" );
            wait 8;
        }
        
        rt_items = [ level.firefly_main_quest.var_77bb8e15d0471db0, level.firefly_main_quest.var_77bb9115d0472449, level.firefly_main_quest.var_77bb9015d0472216, level.firefly_main_quest.var_77bb9315d04728af ];
        var_f0247958e0d3cb75 = [ "rt_item_1_collected", "rt_item_2_collected", "rt_item_3_collected", "rt_item_4_collected" ];
        
        if ( !level.firefly_main_quest utility::ent_flag( "rt_delay_set_show_ritual_items" ) )
        {
            level.firefly_main_quest utility::ent_flag_set( "rt_delay_set_show_ritual_items" );
            level.firefly_main_quest utility::delaythread( 60, &utility::ent_flag_set, "rt_show_ritual_items" );
        }
        
        if ( !level.firefly_main_quest utility::ent_flag( "rt_show_ritual_items" ) )
        {
            hud_data = [];
            
            for ( i = 0; i < rt_items.size ; i++ )
            {
                if ( level.firefly_main_quest utility::ent_flag( var_f0247958e0d3cb75[ i ] ) )
                {
                    continue;
                }
                
                rt_item = rt_items[ i ];
                general_loc_struct = utility::getstruct( rt_item.target2, "targetname" );
                data = [ general_loc_struct.origin, undefined ];
                hud_data[ hud_data.size ] = data;
                data = [ general_loc_struct.origin, undefined, 450 ];
                hud_data[ hud_data.size ] = data;
            }
            
            level thread zm_quest::update_guidance( hud_data, #"firefly_mq_guidance", #"hash_f187490f12e85cb7" );
            progress = 4 - hud_data.size / 2;
            level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"firefly_mq_guidance", #"hash_f187490f12e85cb7" );
            level.firefly_main_quest utility::ent_flag_wait( "rt_show_ritual_items" );
        }
        
        hud_data = [];
        
        foreach ( idx, s_rt_item in rt_items )
        {
            if ( level.firefly_main_quest utility::ent_flag( var_f0247958e0d3cb75[ idx ] ) )
            {
                continue;
            }
            
            data = [ s_rt_item.sbl, 16, undefined, undefined, undefined, s_rt_item.sbl ];
            hud_data[ hud_data.size ] = data;
        }
        
        level thread zm_quest::update_guidance( hud_data, #"firefly_mq_guidance", #"hash_f187490f12e85cb7" );
        progress = 4 - hud_data.size;
        level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"firefly_mq_guidance", #"hash_f187490f12e85cb7" );
        return;
    }
    
    if ( level.var_db53d39d8f26eea6.size != 4 )
    {
        hud_data = [];
        var_857ec0e7633edaf7 = [ level.firefly_main_quest.var_4e5b08d3ee427851, level.firefly_main_quest.var_f05f94c5e1dfa1c4, level.firefly_main_quest.var_ded52789b883e433, level.firefly_main_quest.var_938dbd62de96e0d6 ];
        
        foreach ( var_ad37dc1bc8c70ab5 in var_857ec0e7633edaf7 )
        {
            if ( !arraycontains( level.var_db53d39d8f26eea6, var_ad37dc1bc8c70ab5 ) )
            {
                hud_data[ hud_data.size ] = [ var_ad37dc1bc8c70ab5, -45 ];
            }
        }
        
        level thread zm_quest::update_guidance( hud_data, #"firefly_mq_guidance", #"hash_273aeea74fab3db2" );
        progress = 4 - hud_data.size;
        level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"firefly_mq_guidance", #"hash_273aeea74fab3db2" );
        return;
    }
    
    if ( level utility::flag( "rt_trial_failed" ) )
    {
        if ( !level utility::flag( "recharge_in_progress" ) )
        {
            level thread zm_quest::update_guidance( [ [ level.failed_item.linkedparent ] ], #"firefly_mq_guidance", #"hash_8313f6df6562d305" );
        }
        else if ( !level utility::flag( "rt_recharge_failure" ) )
        {
            level thread zm_quest::update_guidance( [ [ level.failed_item.linkedparent ] ], #"firefly_mq_guidance", #"hash_b99e08150dccf6aa" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "rt_trial_started" ) && level utility::flag( "recharge_complete" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.var_d6b80ced7b65f870, 20, undefined, undefined, undefined, level.firefly_main_quest.var_d6b80ced7b65f870 ] ], #"firefly_mq_guidance", #"hash_12d4c910376c5071" );
        return;
    }
    
    if ( !level utility::flag( "rt_trial_started" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.var_d6b80ced7b65f870, -40, undefined, undefined, undefined, level.firefly_main_quest.var_d6b80ced7b65f870 ] ], #"firefly_mq_guidance", #"hash_12d4c910376c5071" );
        return;
    }
    
    if ( level utility::flag( "rt_trial_started" ) )
    {
        hud_data = [];
        
        foreach ( var_ad37dc1bc8c70ab5 in level.a_ritual_items )
        {
            hud_data[ hud_data.size ] = [ var_ad37dc1bc8c70ab5.linkedparent ];
        }
        
        level thread zm_quest::update_guidance( hud_data, #"firefly_mq_guidance", #"hash_50883e8403ecf4a7" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xce6dc9bf, Offset: 0x28886
// Size: 0x7d9
function private function_c348901be13d0416()
{
    if ( !level.firefly_main_quest utility::ent_flag( "exit_clock_triggered" ) )
    {
        if ( !level utility::flag( "storm_round_active" ) && !level utility::flag( "rm_complete" ) )
        {
            level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.storm_cloud.origin + ( 0, 0, 164 ) ] ], #"firefly_mq_guidance", #"hash_865bc83aedbdcfb9" );
        }
        else if ( !function_3c5e0dd66dd7487f() && function_7c15639ab6d0e803( #"hash_5a803bb75b9dbdec", #"hash_1d4d21e59abda864", #"hash_316bf7314904a125" ) )
        {
            return;
        }
        else if ( function_3c5e0dd66dd7487f() )
        {
            level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.var_38e00b8a244cfd9e, undefined, undefined, undefined, undefined, level.firefly_main_quest.var_38e00b8a244cfd9e ] ], #"firefly_mq_guidance", #"hash_1844a378a5dd98cb" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "trunk_opened" ) )
    {
        if ( isdefined( level.europa ) && isdefined( level.firefly_main_quest.var_282fdcfedaebd2c8.origin ) && !level.europa europa::is_activated() )
        {
            level utility::flag_wait( "europa_assets_ready" );
            closest_device = function_47c86977a18df38b( level.europa_unlock_ee.summon_devices, level.firefly_main_quest.var_282fdcfedaebd2c8.origin );
            var_8cd165ed55735a6d = [ [ closest_device, 25, undefined, undefined, undefined, closest_device ] ];
            var_cf6e560b1bb30f75 = #"hash_4bb6b090de4211f1";
        }
        else
        {
            var_8cd165ed55735a6d = [];
            hud_data = [ level.tme_truck[ 0 ] getlinkedscriptableinstance(), 45, 150 ];
            var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = hud_data;
            hud_data = [ level.tme_truck[ 0 ] getlinkedscriptableinstance(), 45 ];
            var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = hud_data;
            var_cf6e560b1bb30f75 = #"hash_3f5caaaaff25dbf6";
        }
    }
    else if ( !level utility::flag( "mechanic_killed" ) && !level.firefly_main_quest.var_282fdcfedaebd2c8.isplaying )
    {
        var_8cd165ed55735a6d = [ [ level.firefly_main_quest.var_282fdcfedaebd2c8.scene_ents[ "actors" ][ 0 ] ] ];
        var_cf6e560b1bb30f75 = #"hash_972495a44cf8c39d";
    }
    else if ( !level utility::flag( "mechanic_trapped" ) && !level utility::flag( "mechanic_killed" ) )
    {
        var_8cd165ed55735a6d = [];
        hud_data = [ level.a_s_lightning[ 1 ].origin, 24 ];
        var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = hud_data;
        mechanic = level.firefly_main_quest.var_282fdcfedaebd2c8.scene_ents[ "actors" ][ 0 ];
        hud_data = [ mechanic, 90, undefined, undefined, undefined, mechanic ];
        var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = hud_data;
        var_cf6e560b1bb30f75 = #"hash_ece8123f7cc756f8";
    }
    else if ( !level utility::flag( "s_opened" ) )
    {
        ping_player = level.firefly_main_quest.var_6142146ce55b97c6;
        
        if ( isdefined( level.wonder_veh ) && isplayer( ping_player ) )
        {
            level.firefly_main_quest.var_7002a144b4b849f2 = ping_player calloutmarkerping::function_81aa43aad6e47820( level.wonder_veh getentitynumber() );
            level.wonder_veh thread calloutmarkerping::function_3c501da3379eca0a( ping_player, level.firefly_main_quest.var_7002a144b4b849f2, [ "remove_trckr_step_ping" ], undefined, 30 );
        }
        
        var_8cd165ed55735a6d = [ [ level.firefly_main_quest.var_ad5af114c1477c08.origin, 24 ] ];
        var_cf6e560b1bb30f75 = #"hash_dc0e184e3e65f6d0";
    }
    else if ( !level utility::flag( "trucker_killed" ) && !level.firefly_main_quest.var_53f5aa5e19ca282e.isplaying )
    {
        if ( isdefined( level.firefly_main_quest.var_7002a144b4b849f2 ) && isdefined( level.wonder_veh ) )
        {
            level.wonder_veh calloutmarkerping::function_7c0ee9d4b604e6d6( level.firefly_main_quest.var_7002a144b4b849f2 );
            level.wonder_veh notify( #"remove_c_taxi_ping" );
        }
        
        var_8cd165ed55735a6d = [ [ level.firefly_main_quest.var_53f5aa5e19ca282e.scene_ents[ "actors" ][ 0 ].origin, 24 ] ];
        var_cf6e560b1bb30f75 = #"hash_97249ca44cf8cf82";
    }
    else if ( !level utility::flag( "trucker_trapped" ) && !level utility::flag( "trucker_killed" ) )
    {
        var_8cd165ed55735a6d = [];
        hud_data = [ level.a_s_lightning[ 2 ].origin, 24 ];
        var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = hud_data;
        trucker = level.firefly_main_quest.var_53f5aa5e19ca282e.scene_ents[ "actors" ][ 0 ];
        hud_data = [ trucker, 90, undefined, undefined, undefined, trucker ];
        var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = hud_data;
        var_cf6e560b1bb30f75 = #"hash_ece81b3f7cc76643";
    }
    else if ( !level utility::flag( "register_open" ) )
    {
        var_8cd165ed55735a6d = [ [ level.firefly_main_quest.var_8274c2ac910347cb.origin ] ];
        var_cf6e560b1bb30f75 = #"hash_59270f59bd34a04d";
    }
    else if ( !level utility::flag( "waitress_killed" ) && !level.firefly_main_quest.var_a35c0e09a86a04ec.isplaying )
    {
        var_8cd165ed55735a6d = [ [ level.firefly_main_quest.var_a35c0e09a86a04ec.scene_ents[ "actors" ][ 0 ].origin ] ];
        var_cf6e560b1bb30f75 = #"hash_97249ba44cf8cdcf";
    }
    else if ( !level utility::flag( "waitress_trapped" ) && !level utility::flag( "waitress_killed" ) )
    {
        var_8cd165ed55735a6d = [];
        hud_data = [ level.a_s_lightning[ 0 ].origin, 24 ];
        var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = hud_data;
        waitress = level.firefly_main_quest.var_a35c0e09a86a04ec.scene_ents[ "actors" ][ 0 ];
        hud_data = [ waitress, 90, undefined, undefined, undefined, waitress ];
        var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = hud_data;
        var_cf6e560b1bb30f75 = #"hash_ece81c3f7cc767f6";
    }
    
    if ( isdefined( var_cf6e560b1bb30f75 ) && level utility::flag( "storm_triggered" ) )
    {
        level thread zm_quest::update_guidance( var_8cd165ed55735a6d, #"firefly_mq_guidance", var_cf6e560b1bb30f75 );
        level zm_quest::function_612a9ad0db22c29c( level.firefly_main_quest.storm_time_remaining * 1000, 1, #"firefly_mq_guidance", var_cf6e560b1bb30f75 );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x6a2ade69, Offset: 0x29067
// Size: 0x3ac
function private function_21221da02810a25()
{
    if ( !level utility::flag( "MQ_STEP_18_SUBPART_1_PART_1_COMPLETE" ) || !level utility::flag( "MQ_STEP_18_SUBPART_1_PART_2_COMPLETE" ) )
    {
        if ( !function_3c5e0dd66dd7487f() && function_7c15639ab6d0e803( #"hash_5d057ea6d1ff2081", #"hash_23be4eb81ea83ead", #"hash_6fc8add89654aad0" ) )
        {
            return;
        }
        else if ( function_3c5e0dd66dd7487f() )
        {
            var_8cd165ed55735a6d = [];
            
            foreach ( var_bc006453d24e4625 in level.firefly_main_quest.a_antennas )
            {
                if ( !var_bc006453d24e4625 utility::ent_flag( "time_harnessed" ) )
                {
                    array = [];
                    array[ 0 ] = var_bc006453d24e4625;
                    array[ 1 ] = 175;
                    array[ 5 ] = var_bc006453d24e4625;
                    var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = array;
                }
            }
            
            level thread zm_quest::update_guidance( var_8cd165ed55735a6d, #"firefly_mq_guidance", #"hash_37b084a4a0c6408c" );
        }
        
        return;
    }
    
    if ( !zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"hash_c406b8b62698fbdf" ) )
    {
        var_8cd165ed55735a6d = [];
        
        foreach ( var_82e30c4150fe2cf4 in level.firefly_main_quest.var_3df89a9ad0d870d9 )
        {
            marker = [ var_82e30c4150fe2cf4.origin + ( -10, -2, 0 ), 50 ];
            var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = marker;
        }
        
        level thread zm_quest::update_guidance( var_8cd165ed55735a6d, #"firefly_mq_guidance", #"hash_2615fc67ad8ecce8" );
        level thread rob_code_grace_period();
        return;
    }
    else
    {
        var_bcd61fd5ba205348 = zm_quest::function_73720cdf21c3cfd7( #"firefly_mq", #"launch_code" );
        
        switch ( var_bcd61fd5ba205348 )
        {
            case 0:
                var_cf6e560b1bb30f75 = #"hash_6f0a5657b3945323";
                break;
            case 1:
                var_cf6e560b1bb30f75 = #"hash_6f0a5757b39454d6";
                break;
            case 2:
                var_cf6e560b1bb30f75 = #"hash_6f0a5857b3945689";
                break;
            case 3:
                var_cf6e560b1bb30f75 = #"hash_6f0a5957b394583c";
                break;
            default:
                assertmsg( "<dev string:x341>" );
                break;
        }
    }
    
    var_8cd165ed55735a6d = [];
    
    for ( i = 0; i < level.firefly_main_quest.var_3a88947d03fceef9.size ; i++ )
    {
        button = level.firefly_main_quest.var_3a88947d03fceef9[ i ];
        var_82e30c4150fe2cf4 = level.firefly_main_quest.var_bbf63f26705e4e9[ i ];
        
        if ( !button utility::ent_flag( "button_shot" ) )
        {
            button_array = [];
            button_array[ 0 ] = button.origin + ( -15, 0, 18 );
            button_array[ 5 ] = var_82e30c4150fe2cf4;
            var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = button_array;
            break;
        }
    }
    
    level thread zm_quest::update_guidance( var_8cd165ed55735a6d, #"firefly_mq_guidance", var_cf6e560b1bb30f75 );
    return;
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xb6c7b1b, Offset: 0x2941b
// Size: 0x2bc
function private function_1db52bce84bf07f4()
{
    if ( !level.firefly_main_quest utility::ent_flag( "fmq_interact_vic" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.var_dee451882263a43c, undefined, undefined, undefined, undefined, level.firefly_main_quest.var_dee451882263a43c ] ], #"firefly_mq_guidance", #"hash_6969e704fe6e92d0" );
        return;
    }
    
    if ( !level utility::flag( "projector_shot" ) )
    {
        if ( !function_3c5e0dd66dd7487f() && function_7c15639ab6d0e803( #"hash_2a3554392a61d263", #"hash_7c2312c2e42f14a7", #"hash_7045c211e8b1874d" ) )
        {
            return;
        }
        else if ( function_3c5e0dd66dd7487f() )
        {
            level thread zm_quest::update_guidance( [ [ level.projector_mdl, 16, undefined, undefined, undefined, level.projector_mdl ] ], #"firefly_mq_guidance", #"hash_a99102e1e3aa5213" );
        }
        
        return;
    }
    
    if ( !level.firefly_main_quest utility::ent_flag( "fmq_reels_collected" ) )
    {
        if ( !level.firefly_main_quest utility::ent_flag( "fmq_reels_shoot_cooldown" ) )
        {
            var_dea49845d15cfd9f = level.firefly_main_quest.var_1d4bf0e83d76a347[ level.firefly_main_quest.var_173f2bc430883e9a ?? 0 ];
            level zm_quest::function_9f49b2a045ece8ae( level.firefly_main_quest.var_173f2bc430883e9a, 1, #"firefly_mq_guidance", #"hash_17bcf2e7199259bc" );
            level thread zm_quest::update_guidance( [ [ var_dea49845d15cfd9f.sbl, undefined, undefined, undefined, undefined, var_dea49845d15cfd9f.sbl ] ], #"firefly_mq_guidance", #"hash_17bcf2e7199259bc" );
        }
        else
        {
            level zm_quest::function_9f49b2a045ece8ae( 0, 1, #"firefly_mq_guidance", #"hash_17bcf2e7199259bc" );
            level thread zm_quest::update_guidance( undefined, #"firefly_mq_guidance", #"hash_3c0fd626ad2d56d4" );
        }
        
        return;
    }
    
    if ( level.firefly_main_quest utility::ent_flag( "fmq_reels_collected" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.var_3e348e3ca4cd9dba, undefined, undefined, undefined, undefined, level.firefly_main_quest.var_3e348e3ca4cd9dba ] ], #"firefly_mq_guidance", #"hash_9b9fd319913fa2ba" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xe3744f5, Offset: 0x296df
// Size: 0x501
function private function_3961c3ae0b892ad2()
{
    if ( !level.firefly_main_quest utility::ent_flag( "fmq_d_w_pu" ) )
    {
        whistle = level.firefly_main_quest.var_766a71b8f84c0a8c scene::get_entity( "Prop 2" );
        hud_data = [ [ level.firefly_main_quest.var_766a71b8f84c0a8c.sbl, 15, undefined, undefined, undefined, level.firefly_main_quest.var_766a71b8f84c0a8c.sbl ] ];
        var_cf6e560b1bb30f75 = #"hash_5297b48e2c93c943";
        
        if ( isdefined( level.europa ) && isdefined( level.firefly_main_quest.var_766a71b8f84c0a8c.origin ) && !level.europa europa::is_activated() )
        {
            level utility::flag_wait( "europa_assets_ready" );
            closest_device = function_47c86977a18df38b( level.europa_unlock_ee.summon_devices, level.firefly_main_quest.var_766a71b8f84c0a8c.origin );
            hud_data = [ [ closest_device, 25, undefined, undefined, undefined, closest_device ] ];
            var_cf6e560b1bb30f75 = #"hash_70e041263589298e";
        }
        
        level thread zm_quest::update_guidance( hud_data, #"firefly_mq_guidance", var_cf6e560b1bb30f75 );
        return;
    }
    
    if ( level.firefly_main_quest utility::ent_flag( "fmq_d_w_pu" ) && !level.firefly_main_quest utility::ent_flag( "europa_reach_dest" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.europa, 90, undefined, undefined, undefined, level.europa ] ], #"firefly_mq_guidance", #"hash_a1a3eda5a611b4b4" );
        return;
    }
    
    if ( level.firefly_main_quest.var_7e11f868ba59df86 utility::ent_flag( "is_on_cooldown" ) )
    {
        level zm_quest::function_fb3af5600f6a9441( 3, 1, #"firefly_mq_guidance", #"hash_9af3a3b5fa350d65" );
        level zm_quest::function_9f49b2a045ece8ae( 0, 1, #"firefly_mq_guidance", #"hash_9af3a3b5fa350d65" );
        level utility::delaythread( 2.5, &zm_quest::update_guidance, [ [ level.europa, 90, undefined, undefined, undefined, level.europa ] ], #"firefly_mq_guidance", #"hash_814fbee6570bc393" );
        return;
    }
    
    if ( level.firefly_main_quest utility::ent_flag( "europa_reach_dest" ) && !level.firefly_main_quest utility::ent_flag( "is_step_5_active" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.europa, 90, undefined, undefined, undefined, level.europa ] ], #"firefly_mq_guidance", #"hash_feb5064aaca2a339" );
        return;
    }
    
    if ( level.firefly_main_quest utility::ent_flag( "europa_blown_whistle" ) )
    {
        tme_collection_step = level zm_quest::get_quest_step( #"firefly_mq", #"tme_collection" );
        var_ae3e24dfe43ddbb2 = tme_collection_step.var_ae3e24dfe43ddbb2[ tme_collection_step.var_92ace9f986e8d3e5 ];
        
        if ( tme_collection_step.var_92ace9f986e8d3e5 >= 5 )
        {
            level utility::delaythread( 1, &zm_quest::clear_all_guidance );
        }
        
        var_8cd165ed55735a6d = [];
        
        foreach ( var_efde2a3377644e09 in var_ae3e24dfe43ddbb2 )
        {
            tme_num = int( var_efde2a3377644e09.script_parameters );
            
            if ( tme_num == 12 && tme_collection_step.var_ae3e24dfe43ddbb2[ 4 ].size > 1 )
            {
                continue;
            }
            
            data = [ var_efde2a3377644e09.tme_sbl, undefined, undefined, undefined, undefined, var_efde2a3377644e09.tme_sbl ];
            var_8cd165ed55735a6d[ var_8cd165ed55735a6d.size ] = data;
        }
        
        level thread zm_quest::update_guidance( var_8cd165ed55735a6d, #"firefly_mq_guidance", #"hash_9af3a3b5fa350d65" );
        level zm_quest::function_9f49b2a045ece8ae( tme_collection_step.var_2e9f351b04e87b7, 1, #"firefly_mq_guidance", #"hash_9af3a3b5fa350d65" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xf1268799, Offset: 0x29be8
// Size: 0x51
function private rob_code_grace_period()
{
    if ( level utility::flag( "doing_rob_code_grace_period" ) )
    {
        return;
    }
    
    level utility::flag_set( "doing_rob_code_grace_period" );
    level endon( #"game_ended" );
    wait 45;
    zm_quest::function_4eefe6de31f5ddab( #"firefly_mq", #"hash_c406b8b62698fbdf", 1 );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xdb422248, Offset: 0x29c41
// Size: 0x16, Type: bool
function private function_dc6a8903cbb1d35a()
{
    return level zm_sat_firefly::function_24006873400b7a8() && level.var_cef21da19561e27d;
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x5893c720, Offset: 0x29c60
// Size: 0x84, Type: bool
function private function_3c5e0dd66dd7487f()
{
    foreach ( player in level.players )
    {
        if ( player.time_carrier )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xdcaff10d, Offset: 0x29ced
// Size: 0x187
function private function_28d09d3428eb3710()
{
    var_36d719ae538f565d = utility::getstructarray( "s_te_ct", "targetname" );
    var_d772d62f2d0d2323 = utility::function_54fdde0a73217354( var_36d719ae538f565d, 1, 1 );
    
    if ( !level.clock_vfx || level.clock_vfx.size < 1 )
    {
        return [ [ var_d772d62f2d0d2323, 200, undefined, undefined, undefined, level.firefly_main_quest.clock_tower ] ];
    }
    
    hud_data = [];
    
    foreach ( clock_vfx in level.clock_vfx )
    {
        if ( arraycontains( level.var_76c45cae2094c966, clock_vfx ) )
        {
            return [ [ clock_vfx, 65, undefined, undefined, undefined, level.firefly_main_quest.clock_tower ] ];
        }
    }
    
    return [ [ var_d772d62f2d0d2323, 200, undefined, undefined, undefined, level.firefly_main_quest.clock_tower ] ];
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x4bcc3bac, Offset: 0x29e7d
// Size: 0x25a
function private function_100a16008cb8bf2f( sbl_type )
{
    if ( !level.firefly_main_quest.var_17cf20b23559c948[ sbl_type ] utility::ent_flag( "MQ_STEP_10_SUBPART_COMPLETE" ) )
    {
        switch ( sbl_type )
        {
            case #"hash_9cdbafae6cb53df3":
                var_d73db6c2e5fab9c = #"hash_5b13957ee04f9c77";
                var_1537dd135032bc07 = #"hash_e4a5b7e559d80532";
                break;
            case #"hash_9cdbb0ae6cb53f86":
                var_d73db6c2e5fab9c = #"hash_5b13967ee04f9e2a";
                var_1537dd135032bc07 = #"hash_e4a5b6e559d8037f";
                break;
            case #"hash_9cdbb1ae6cb54119":
                var_d73db6c2e5fab9c = #"hash_5b13977ee04f9fdd";
                var_1537dd135032bc07 = #"hash_e4a5b5e559d801cc";
                break;
            default:
                break;
        }
        
        if ( function_f1ac3844a976a89a( sbl_type ) )
        {
            level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.entity_box, 55, undefined, undefined, undefined, level.firefly_main_quest.entity_box ] ], #"firefly_mq_guidance", #"hash_b73a69039bbbddc9" );
            return 1;
        }
        
        if ( distance2dsquared( level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ].origin, level.firefly_main_quest.var_17cf20b23559c948[ sbl_type ].origin ) < squared( 10 ) )
        {
            level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ], 25, undefined, undefined, undefined, level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] ] ], #"firefly_mq_guidance", var_d73db6c2e5fab9c );
            return 1;
        }
        
        level thread zm_quest::update_guidance( [ [ level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ], 25, undefined, undefined, undefined, level.firefly_main_quest.var_c05225eadb335d26[ sbl_type ] ] ], #"firefly_mq_guidance", var_1537dd135032bc07 );
        return 1;
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x7de8dc3d, Offset: 0x2a0e0
// Size: 0x86
function private function_8e56b994cfba74dc( var_3bdd455166e4e8ee )
{
    if ( !isdefined( var_3bdd455166e4e8ee.angles ) )
    {
        var_3bdd455166e4e8ee.angles = ( 0, 0, 0 );
    }
    
    spawnoptions = common_item::function_bc5ff2958b71a708( var_3bdd455166e4e8ee.origin, var_3bdd455166e4e8ee.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    return spawnoptions;
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0xdfca05a2, Offset: 0x2a16f
// Size: 0xa4
function private function_3bc6b66dd1405335()
{
    if ( isplayer( level.firefly_main_quest.var_1f67860f50883a5a ) )
    {
        level thread battlechatter_mp::trysaylocalsound( level.firefly_main_quest.var_1f67860f50883a5a, #"bc_flavor_player_negative" );
        return;
    }
    
    a_players = getplayersinradius( level.firefly_main_quest.var_3df89a9ad0d870d9[ 1 ].origin, 400 );
    player = utility::array_random( a_players );
    
    if ( isplayer( player ) )
    {
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_negative" );
    }
}

// Namespace zm_sat_firefly_script_mq
// Params 0, eflags: 0x4
// Checksum 0x9a67dd47, Offset: 0x2a21b
// Size: 0x2f0
function private function_6c6e6127c7bb2be1()
{
    level endon( #"game_ended" );
    s_rocket = utility::getstruct( "grom_r", "targetname" );
    wait 4;
    rocket_speaker_ent = utility::spawn_tag_origin( s_rocket.origin, s_rocket.angles );
    rocket_speaker_ent dialogue::say( #"hash_cbd10aeebce10d86" );
    wait 0.75;
    var_29aea06549213709 = [];
    launchpad_control_room_zone = zone_manager::get_zone_struct( "zone_launchpad_control_room" );
    var_29aea06549213709 = arraycombineunique( var_29aea06549213709, zone_manager::get_zone_occupants( launchpad_control_room_zone.script_zone_name ) );
    var_a92294849cacd30c = launchpad_control_room_zone zone_manager::get_adjacent_zones();
    
    foreach ( adj in var_a92294849cacd30c )
    {
        var_29aea06549213709 = arraycombineunique( var_29aea06549213709, zone_manager::get_zone_occupants( adj.script_zone_name ) );
    }
    
    foreach ( player in var_29aea06549213709 )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_73656e488b72167f", undefined );
        
        if ( var_db75d3de862ce072 )
        {
            break;
        }
    }
    
    if ( !var_db75d3de862ce072 && var_29aea06549213709.size > 0 )
    {
        player = utility::array_random( var_29aea06549213709 );
        
        if ( player )
        {
            player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_73656e488b72167f", #"bc_flavor_player_positive", 2 );
        }
    }
    
    level notify( #"hash_7ec73666dfbf33a7" );
    rocket_speaker_ent dialogue::say( #"hash_18bc4d200a4b5718" );
    wait 0.5;
    rocket_speaker_ent dialogue::say( #"hash_18bc50200a4b5c31" );
    rocket_speaker_ent delete();
    wait 8;
    overlord::playevent( #"hash_af4cb22a955cb828", level.players );
    zm_quest::function_8934bb2a9028bdc5();
    var_6346151e8ded0c8 = getplayersinradius( s_rocket.origin, 4750 );
    
    foreach ( player in var_6346151e8ded0c8 )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_c66fde86fc9aab4" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
}

/#

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0x12f61273, Offset: 0x2a513
    // Size: 0x2f9, Type: dev
    function private init_mq_debug()
    {
        level.firefly_main_quest.s_debug = spawnstruct();
        
        if ( !isdefined( level.firefly_main_quest.s_debug.var_fe85b8b24c101f9c ) )
        {
            level.firefly_main_quest.s_debug.var_fe85b8b24c101f9c = 0;
        }
        
        zm_quest::function_1b5b11caffa04d9a( #"firefly_mq", #"hash_8e15f8805ec569f2" );
        devgui::add_devgui_func( "<dev string:x359>", "<dev string:x37a>", &function_571d9b5396a629af );
        devgui::add_devgui_func( "<dev string:x386>", "<dev string:x3b0>", &function_e30ad185bc784128 );
        zm_quest::function_394bdba74beda0aa();
        zm_quest::function_1b5b11caffa04d9a( #"firefly_mq", #"hash_6862143d688fc459" );
        devgui::add_devgui_func( "<dev string:x3c1>", "<dev string:x3de>", &function_cb99f9aed705316c );
        devgui::add_devgui_func( "<dev string:x3f1>", "<dev string:x40e>", &function_2de93bba78d207c5 );
        devgui::add_devgui_func( "<dev string:x421>", "<dev string:x43e>", &function_76afd0676803cc02 );
        devgui::add_devgui_func( "<dev string:x451>", "<dev string:x478>", &function_3187d5a886ba28ca );
        devgui::add_devgui_func( "<dev string:x492>", "<dev string:x4b9>", &function_fa9513c268373436 );
        zm_quest::function_394bdba74beda0aa();
        devgui::function_9082edeb5db93280( "<dev string:x4cc>" );
        devgui::add_devgui_func( "<dev string:x4e2>", "<dev string:x4ec>", &debug_spawn_time );
        devgui::add_devgui_func( "<dev string:x500>", "<dev string:x512>", &function_e7d371d1dea8f550 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x521>" );
        devgui::add_devgui_func( "<dev string:x53b>", "<dev string:x54b>", &function_719ad2caeb0f814a );
        devgui::add_devgui_func( "<dev string:x55b>", "<dev string:x56c>", &function_e6dbd042f2f2ef3c );
        devgui::add_devgui_func( "<dev string:x57d>", "<dev string:x58e>", &function_1dc0045e9bd50592 );
        devgui::add_devgui_func( "<dev string:x59f>", "<dev string:x5b1>", &function_42728010b5a23c24 );
        devgui::add_devgui_func( "<dev string:x5c3>", "<dev string:x5b1>", &function_f5d0bb32cfbbed3b );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x4cc>" );
        devgui::add_devgui_func( "<dev string:x5da>", "<dev string:x5e7>", &function_e887612c6448b280 );
        devgui::add_devgui_func( "<dev string:x5f4>", "<dev string:x601>", &function_75a4dbd4ca1223b1 );
        devgui::function_77df7fe7dd273e10();
        zm_quest::function_1b5b11caffa04d9a( #"firefly_mq", #"hash_dbc50456c0a63765" );
        devgui::add_devgui_func( "<dev string:x60e>", "<dev string:x621>", &function_744155b584927852 );
        devgui::add_devgui_func( "<dev string:x638>", "<dev string:x64d>", &function_e6ff34c9d066ea27 );
        zm_quest::function_394bdba74beda0aa();
        zm_quest::function_1b5b11caffa04d9a( #"firefly_mq", #"tme_collection" );
        devgui::add_devgui_func( "<dev string:x663>", "<dev string:x679>", &function_43e9d32cd20f7f3a );
        devgui::add_devgui_func( "<dev string:x68f>", "<dev string:x6a8>", &function_b94aaebbb12a7556 );
        devgui::add_devgui_func( "<dev string:x6c1>", "<dev string:x6e6>", &early_exit_tme_collection );
        devgui::add_devgui_func( "<dev string:x700>", "<dev string:x718>", &function_af02ac73829237f8 );
        zm_quest::function_394bdba74beda0aa();
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0
    // Checksum 0x30e88103, Offset: 0x2a814
    // Size: 0x1d, Type: dev
    function function_719ad2caeb0f814a()
    {
        level.smoke_sbl setscriptablepartstate( "<dev string:x72e>", "<dev string:x732>" );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0
    // Checksum 0x6263308f, Offset: 0x2a839
    // Size: 0x1d, Type: dev
    function function_e6dbd042f2f2ef3c()
    {
        level.smoke_sbl setscriptablepartstate( "<dev string:x72e>", "<dev string:x735>" );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0
    // Checksum 0x2e56a0d0, Offset: 0x2a85e
    // Size: 0x1d, Type: dev
    function function_1dc0045e9bd50592()
    {
        level.smoke_sbl setscriptablepartstate( "<dev string:x73f>", "<dev string:x749>" );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0
    // Checksum 0x7da70dc0, Offset: 0x2a883
    // Size: 0x1d, Type: dev
    function function_42728010b5a23c24()
    {
        level.smoke_sbl setscriptablepartstate( "<dev string:x73f>", "<dev string:x74d>" );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0
    // Checksum 0x79f1b818, Offset: 0x2a8a8
    // Size: 0x1d, Type: dev
    function function_f5d0bb32cfbbed3b()
    {
        level.smoke_sbl setscriptablepartstate( "<dev string:x73f>", "<dev string:x755>" );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0x5d008fa, Offset: 0x2a8cd
    // Size: 0x17, Type: dev
    function private function_571d9b5396a629af()
    {
        function_b68825dab16677a( level.players[ 0 ] );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0x4d7f7ab2, Offset: 0x2a8ec
    // Size: 0x76, Type: dev
    function private function_e30ad185bc784128()
    {
        if ( isdefined( level.firefly_main_quest.var_f728ac4d2490fb1c ) )
        {
            function_5851d5b6d04b2099( level.players[ 0 ] );
            function_232bed5e748ff73d( level.players[ 0 ] );
            function_f87bc8cc60b9a111( level.players[ 0 ] );
            function_32389e6e5a3bfe0d( level.players[ 0 ] );
            function_7a65c9f84c8b398e( level.players[ 0 ] );
        }
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0x4f3d9e88, Offset: 0x2a96a
    // Size: 0x62, Type: dev
    function private function_cb99f9aed705316c()
    {
        println( "<dev string:x762>" );
        
        if ( isdefined( level.firefly_main_quest.var_c05225eadb335d26[ "<dev string:x781>" ] ) )
        {
            level thread common_item::function_869d7676e359a627( level.firefly_main_quest.var_c05225eadb335d26[ "<dev string:x781>" ] );
        }
        
        function_68498104ae35531c( level.players[ 0 ] );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0xef52c44c, Offset: 0x2a9d4
    // Size: 0x62, Type: dev
    function private function_2de93bba78d207c5()
    {
        println( "<dev string:x79a>" );
        
        if ( isdefined( level.firefly_main_quest.var_c05225eadb335d26[ "<dev string:x7b9>" ] ) )
        {
            level thread common_item::function_869d7676e359a627( level.firefly_main_quest.var_c05225eadb335d26[ "<dev string:x7b9>" ] );
        }
        
        function_c29a993db8cb8975( level.players[ 0 ] );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0x39a70fcf, Offset: 0x2aa3e
    // Size: 0x62, Type: dev
    function private function_76afd0676803cc02()
    {
        println( "<dev string:x7d2>" );
        
        if ( isdefined( level.firefly_main_quest.var_c05225eadb335d26[ "<dev string:x7f1>" ] ) )
        {
            level thread common_item::function_869d7676e359a627( level.firefly_main_quest.var_c05225eadb335d26[ "<dev string:x7f1>" ] );
        }
        
        function_1dbbcfc24a1187ca( level.players[ 0 ] );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0xacefab9f, Offset: 0x2aaa8
    // Size: 0xb5, Type: dev
    function private function_3187d5a886ba28ca()
    {
        if ( !level utility::flag( "<dev string:x80a>" ) )
        {
            level utility::flag_set( "<dev string:x80a>" );
            
            foreach ( key in level.firefly_main_quest.var_c05225eadb335d26 )
            {
                key thread debug_draw_key();
            }
            
            return;
        }
        
        level utility::flag_clear( "<dev string:x80a>" );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0xc
    // Checksum 0x900dfd37, Offset: 0x2ab65
    // Size: 0x70, Type: dev
    function private debug_draw_key()
    {
        self notify( #"hash_16646dc905138005" );
        self endon( #"hash_16646dc905138005" );
        self endon( #"death" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( level utility::flag( "<dev string:x80a>" ) )
            {
                utility::draw_circle( self.origin, 15, ( 1, 0, 0 ), undefined, undefined, 5 );
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0xc
    // Checksum 0x30e2edc8, Offset: 0x2abdd
    // Size: 0x170, Type: dev
    function private function_fa9513c268373436()
    {
        self notify( #"hash_e36e92e8f0c49b43" );
        self endon( #"hash_e36e92e8f0c49b43" );
        var_17cf20b23559c948 = utility::getstructarray( "<dev string:x817>", "<dev string:x81c>" );
        
        foreach ( var_ba39b89925cb2697 in var_17cf20b23559c948 )
        {
            key_number = int( var_ba39b89925cb2697.script_label );
            
            switch ( key_number )
            {
                case 1:
                    sbl_type = "<dev string:x781>";
                    break;
                case 2:
                    sbl_type = "<dev string:x7b9>";
                    break;
                case 3:
                    sbl_type = "<dev string:x7f1>";
                    break;
                default:
                    assertmsg( "<dev string:x57>" );
                    break;
            }
            
            item_bundle = function_553573b18e2f6b49( sbl_type );
            spawnoptions = function_8e56b994cfba74dc( var_ba39b89925cb2697 );
            key = common_item::function_61c2c0251e742ffd( getscriptbundle( item_bundle ), 1, spawnoptions );
            key thread debug_draw_key();
        }
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0xe1cd33b4, Offset: 0x2ad55
    // Size: 0xa5, Type: dev
    function private debug_spawn_time()
    {
        player = level.players[ 0 ];
        player setscriptablepartstate( "<dev string:x827>", "<dev string:x837>", 0 );
        player.time_carrier = 1;
        level thread function_51f12524c830dd09();
        
        if ( !utility::flag( "<dev string:x842>" ) && !level utility::flag( "<dev string:x85c>" ) )
        {
            player thread function_28037398e39c4d1c( level.farm_clock_trigger );
        }
        
        player thread function_6bec0b63f79e2d71();
        player callback::remove( "<dev string:x868>", &time_release );
        player callback::add( "<dev string:x868>", &time_release );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0x7e56466a, Offset: 0x2ae02
    // Size: 0xc, Type: dev
    function private function_744155b584927852()
    {
        function_63e3ed862924333b();
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0xa82cb636, Offset: 0x2ae16
    // Size: 0xe5, Type: dev
    function private function_e6ff34c9d066ea27()
    {
        foreach ( player in level.players )
        {
            level.firefly_main_quest.var_77bb8e15d0471db0 thread function_a7c97c1f5482a147( player );
            level.firefly_main_quest.var_77bb9115d0472449 thread function_834050021a3b54a2( player );
            level.firefly_main_quest.var_77bb9015d0472216 thread function_cd839ef2d57e8d2d( player );
            level.firefly_main_quest.var_77bb9315d04728af thread function_41350fde921f6048( player );
        }
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 1, eflags: 0x4
    // Checksum 0x341e69cd, Offset: 0x2af03
    // Size: 0x12f, Type: dev
    function private function_43e9d32cd20f7f3a( parameters )
    {
        level.firefly_main_quest utility::ent_flag_set( "<dev string:x878>" );
        level.firefly_main_quest utility::ent_flag_set( "<dev string:x883>" );
        level thread function_7c5fcba23816ef10( level.players[ 0 ], 1 );
        level.firefly_main_quest utility::ent_flag_wait( "<dev string:x892>" );
        
        for ( var_fa80ffd30d85cba2 = 0; var_fa80ffd30d85cba2 < level.firefly_main_quest.var_ae3e24dfe43ddbb2.size ; var_fa80ffd30d85cba2++ )
        {
            adjusted_group_num = var_fa80ffd30d85cba2 + 1;
            var_ae3e24dfe43ddbb2 = level.firefly_main_quest.var_ae3e24dfe43ddbb2[ adjusted_group_num ];
            
            for ( tme_index = 0; tme_index < var_ae3e24dfe43ddbb2.size ; tme_index++ )
            {
                var_efde2a3377644e09 = var_ae3e24dfe43ddbb2[ tme_index ];
                tme_num = int( var_efde2a3377644e09.script_parameters );
                
                if ( tme_num == 12 )
                {
                    continue;
                }
                
                level thread function_9532d621d831bd5b( var_efde2a3377644e09.tme_sbl, undefined, undefined, undefined, 1 );
            }
        }
        
        /#
            iprintlnbold( "<dev string:x8a0>" );
        #/
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 1, eflags: 0x4
    // Checksum 0x9593ba44, Offset: 0x2b03a
    // Size: 0x4e, Type: dev
    function private function_b94aaebbb12a7556( parameters )
    {
        level.firefly_main_quest utility::ent_flag_set( "<dev string:x878>" );
        level.firefly_main_quest utility::ent_flag_set( "<dev string:x883>" );
        level thread function_7c5fcba23816ef10( level.players[ 0 ], 1 );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 1, eflags: 0x4
    // Checksum 0x847b1a51, Offset: 0x2b090
    // Size: 0x23, Type: dev
    function private early_exit_tme_collection( parameters )
    {
        level.firefly_main_quest notify( #"hash_75778e23c219d770" );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 1, eflags: 0x4
    // Checksum 0x3f922b06, Offset: 0x2b0bb
    // Size: 0x194, Type: dev
    function private function_af02ac73829237f8( params )
    {
        level.firefly_main_quest.s_debug.var_fe85b8b24c101f9c = !level.firefly_main_quest.s_debug.var_fe85b8b24c101f9c;
        
        /#
            iprintlnbold( "<dev string:x8c8>" + level.firefly_main_quest.s_debug.var_fe85b8b24c101f9c );
        #/
        
        level.firefly_ww_quest notify( #"hash_b9f533ebda152539" );
        level.firefly_ww_quest endon( #"hash_b9f533ebda152539" );
        
        while ( level.firefly_main_quest.s_debug.var_fe85b8b24c101f9c )
        {
            for ( var_fa80ffd30d85cba2 = 0; var_fa80ffd30d85cba2 < level.firefly_main_quest.var_ae3e24dfe43ddbb2.size ; var_fa80ffd30d85cba2++ )
            {
                adjusted_group_num = var_fa80ffd30d85cba2 + 1;
                var_ae3e24dfe43ddbb2 = level.firefly_main_quest.var_ae3e24dfe43ddbb2[ adjusted_group_num ];
                
                for ( tme_index = 0; tme_index < var_ae3e24dfe43ddbb2.size ; tme_index++ )
                {
                    s_tme = var_ae3e24dfe43ddbb2[ tme_index ];
                    
                    if ( s_tme.tme_sbl.linkedparent )
                    {
                        sphere( s_tme.tme_sbl.linkedparent.origin, 30, ( 1, 0, 0 ), 1, 1 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0x653834dd, Offset: 0x2b257
    // Size: 0x17, Type: dev
    function private function_a1bc14bae0ec080c()
    {
        function_b68825dab16677a( level.players[ 0 ] );
    }

    // Namespace zm_sat_firefly_script_mq
    // Params 0, eflags: 0x4
    // Checksum 0x82f3ca6b, Offset: 0x2b276
    // Size: 0xab, Type: dev
    function private function_e7d371d1dea8f550()
    {
        for ( i = 0; i < 12 ; i++ )
        {
            tme = spawnscriptable( %"sat_zm_firefly_mq_veh_tme", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            tme setscriptablepartstate( "<dev string:x8db>", "<dev string:x8e0>" );
            ent = utility::spawn_model( "<dev string:x8ee>", tme.origin, tme.angles );
            tme utility::scriptable_setparententity( ent );
            tme thread function_51e889cea6b518fe();
            wait randomfloatrange( 0, 2.1 );
        }
    }

#/

// Namespace zm_sat_firefly_script_mq
// Params 1, eflags: 0x4
// Checksum 0x75fed9f9, Offset: 0x2b329
// Size: 0x3e1
function private function_75a4dbd4ca1223b1( params )
{
    level endon( #"game_ended" );
    level function_e4ec6c7611abdf7d();
    level thread zm_exfil::disable_zm_exfil( 1 );
    
    if ( level.var_a009ab14ee0d3223.isspecialround )
    {
        zm_round_logic::function_895fdc21ab019efe();
    }
    
    level utility::flag_clear( "rbz_allow_exfil" );
    level zm_utility::util_kill_all_zombies();
    
    foreach ( player in level.players )
    {
        player utility::hidehudenable();
        level thread game_utility::fadetoblackforplayer( player, 1, 0.5 );
    }
    
    level val::set( "outro_igc", "task_logic_activate", 0 );
    overlord::function_f2fedd3be0be82ef();
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player thread function_411dee18c9cff509();
        }
        else if ( player.inlaststand )
        {
            player thread laststand::exit( "last_stand_self_revive" );
        }
        
        player setclienttriggeraudiozone( "zm_sat_firefly_igc" );
        player val::set( "outro_igc_scene", "killstreaks", 0 );
        player val::set( "outro_igc_scene", "damage", 0 );
        player val::set( "outro_igc_scene", "freezecontrols", 1 );
        player val::set( "outro_igc_scene", "allow_movement", 0 );
    }
    
    while ( !function_cb3f113c9a5d56f7( "mp_infil_zm_sat_firefly_igc_tr" ) )
    {
        waitframe();
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"end_igc" );
    playcinematicforall( "sat_cin_zm_fly_outro", 1 );
    wait 2;
    startnoninteractivesequence();
    
    foreach ( player in level.players )
    {
        utility::delaythread( 1, &game_utility::fadetoblackforplayer, player, 0, 0.5 );
    }
    
    if ( isdefined( level.var_209ed49971299121 ) )
    {
        level.var_209ed49971299121.var_685ee97bdd7a6dda = 1;
        level.var_209ed49971299121 scene::play( undefined, undefined, "sat_cin_zm_fly_outro" );
    }
    
    foreach ( player in level.players )
    {
        if ( player.hidehudenabled == 1 )
        {
            player utility::hidehuddisable();
        }
        
        player val::reset_all( "outro_igc_scene" );
        player clearclienttriggeraudiozone();
    }
    
    stopcinematicforall( 1, 1 );
    level val::reset( "outro_igc", "task_logic_activate" );
    function_4d2cf7ef166227();
    level thread function_cfa603ae5c0c86a6();
    level utility::flag_set( "outro_igc_completed" );
    level thread zm_exfil::disable_zm_exfil( 0 );
    zm_quest::function_765655c7699f9fb7();
    level thread function_4340f0a56ae30f25();
}

