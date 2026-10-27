// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_mq.gsc  (hash_733fd6f06f5f7c21.gscc) (size: 171331 Bytes / 0x29d43 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x61e86f1d (1642622749)
// size ...... 171331 (0x29d43)
// includes .. 47  (offset: 0x26477)
// strings ... 611 (offset: 0x265ef)
// dev strs .. 55  (offset: 0x29a63)
// exports ... 352 (offset: 0x1c3d7)
// cseg ...... 0x364a + 0x18d8d (0x1c3d7)
// imports ... 654 (offset: 0x1fad7)
// animtree1 . 1   (offset: 0x29d23)
// animtree2 . 1   (offset: 0x29d33)
#using script_16ea1b94f0f381b3;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_galileo\zombie_galileo;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\anim_scene;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\field_upgrades\field_upgrades_aether_shroud;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\playerlogic;
#using scripts\mp\weapons;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_boss_fight;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_galileo;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_telescope;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\weapons\zm_blackhole_bomb;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_fasttravel_core;
#using scripts\mp\zm\systems\zm_interaction;
#using scripts\mp\zm\systems\zm_keypad;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_ruby_quest_mq;

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x5
// Checksum 0x409fb757, Offset: 0x3668
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"ruby_mq", #"zm_quest", &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xd83af371, Offset: 0x3695
// Size: 0x24c
function private function_7cf8dacb278a2665()
{
    level utility::flag_wait( "zm_quest_initialized" );
    level.ruby_mq = zm_quest::get_quest( #"ruby_mq" );
    level thread function_edfb277847aaeb25();
    level thread function_df184ba7ba3683c();
    level thread turn_off_ladder();
    level thread watch_open_sesame();
    level thread function_228aa73041447bd4();
    
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) )
    {
        return;
    }
    
    zm_quest::register_quest_step( #"ruby_mq", #"hash_23376b7af434326e", &setup_step_1, &function_61e5b348e99af311 );
    zm_quest::register_quest_step( #"ruby_mq", #"hash_8ec59469a0e07d14", &setup_step_2, &function_61e5b048e99aec78 );
    zm_quest::register_quest_step( #"ruby_mq", #"find_bonesaw", &setup_step_3, &function_61e5b148e99aeeab );
    zm_quest::register_quest_step( #"ruby_mq", #"extract_brain", &function_7edad63abae50975, &function_61e5b648e99af9aa );
    zm_quest::register_quest_step( #"ruby_mq", #"reanimate_brain", &function_7edad53abae50742, &function_61e5b748e99afbdd );
    zm_quest::register_quest_step( #"ruby_mq", #"hash_35b90be15aed204e", &function_7edad43abae5050f, &cleanup_step_6 );
    zm_quest::register_quest_step( #"ruby_mq", #"hash_ef72ef5bed29052b", &function_7edad33abae502dc, &cleanup_step_7 );
    zm_quest::register_quest_step( #"ruby_mq", #"hash_746419595d7efc54", &function_7edada3abae51241, &cleanup_step_8 );
    zm_quest::register_quest_step( #"ruby_mq", #"orrery_puzzle", &function_7edad93abae5100e, &cleanup_step_9 );
    zm_quest::register_quest_step( #"ruby_mq", #"orrery_defend", &function_e0386a29059b33f2, &cleanup_step_10 );
    zm_quest::register_quest_step( #"ruby_mq", #"hash_41487e30c43486f1", &function_e0386b29059b3625, &cleanup_step_11 );
    zm_quest::register_quest_step( #"ruby_mq", #"hash_c5288a7bdc3b7e15", &function_e0386829059b2f8c, &cleanup_step_12 );
    zm_quest::register_quest_step( #"ruby_mq", #"hash_2ed297979aec57f8", &function_e0386929059b31bf, &cleanup_step_13 );
    zm_quest::register_quest_step( #"ruby_mq", #"boss_fight", &function_e0386629059b2b26, &cleanup_step_14 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xcfa77aa0, Offset: 0x38e9
// Size: 0x21c
function private postmain_init()
{
    level utility::flag_wait( "zm_sat_ruby_quest_mq_cs_completed" );
    
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) )
    {
        return;
    }
    
    level._effect[ "ruby_mq_voss_portal" ] = loadfxasset( "vfx_sat_ruby_portal_teleport_player" );
    level._effect[ "ruby_mq_cryo_idle_cushion" ] = loadfxasset( "vfx_sat_ruby_cyro_chamber_cushion_idle" );
    level._effect[ "ruby_mq_cryo_alarm" ] = loadfxasset( "vfx_sat_ruby_alarms" );
    level._effect[ "ruby_mq_defense_impact" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact_spark" );
    level._effect[ "zombie_impact" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact" );
    level._effect[ "zombie_impact_blood" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact_blood" );
    level._effect[ "trap_electric_player" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_screen_elec_shock_bot" );
    level val::group_register( "RUBY_MQ_PATH_TO_PORTAL", [ "usability", "weapon_switch", "supers", "gesture", "killstreaks", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "allow_movement", "allow_jump", "crouch", "prone", "damage", "fire", "show_hud", "melee" ] );
    init_path_to_portal_anims();
    level thread function_926c496c26c16590();
    level utility::flag_wait( "zm_init_done" );
    zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    level callback::add( "quest_item_used", &function_a1d5954d9e5b5897 );
    level thread init_defend_event_doors();
    level utility::flag_wait( "ruby_papq_complete" );
    level thread zm_quest::start_quest( #"ruby_mq" );
    level thread monitor_ruby_wwq_complete();
    
    /#
        level thread init_ruby_mq_debug();
        level thread debug_player_location();
    #/
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"open_mars", &function_46bf415b00c9ab42 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"start_ruby_mq", &debug_start_mq );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x8effde1, Offset: 0x3b0d
// Size: 0xc3
function function_926c496c26c16590()
{
    utility::flag_wait( "scriptables_ready" );
    level thread function_765684a8aa075fd3();
    level thread setup_nixie_tube_machine();
    level thread function_e10e743e0b592a72();
    level thread spawn_freezer();
    level thread function_6855a6c2563b91bb();
    level thread function_c86be96257788044();
    level thread spawn_perfusion_machine();
    level thread setup_perfusion_machine_orrey();
    level thread spawn_portal();
    level thread function_5d1a6be1bc01f78e();
    level thread spawn_mars();
    level thread function_b338595b35061a4a();
    level thread book_puzzle_clue();
    level thread setup_orrery_puzzle_clue();
    level thread function_49a1dfc2b068c429();
    level thread function_2047d26f7cbc6f8c();
    level thread function_48516040df55382a();
    level thread function_1d5c60addc0d67c6();
    level thread function_fc097748e2aee289();
    level thread function_27f5a5e1c5f3c46b();
    level.ruby_mq.var_79392d363e812265 = 0;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x2c5fc48b, Offset: 0x3bd8
// Size: 0x3e
function private monitor_ruby_wwq_complete()
{
    level utility::flag_wait_all( "wwq_oscar_gone", "ruby_wwq_complete" );
    waitframe();
    
    if ( !utility::flag( "ruby_mq_key_picked" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_mq_guidance", #"oscar_return" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0xff11cfd8, Offset: 0x3c1e
// Size: 0xe11
function function_4ef47d3c5c627fb6()
{
    if ( !utility::flag( "ruby_wwq_complete" ) || utility::flag( "ruby_boss_fight_complete" ) || !zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    if ( !utility::flag( "mq_directed_platform_clue_heard" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.galileo, 110 ] ], #"ruby_mq_guidance", #"hash_6a8af87f83df311e" );
    }
    else if ( !utility::flag( "ruby_mq_platform_moved" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.buttoninteract ] ], #"ruby_mq_guidance", #"oscar_code" );
    }
    else if ( !utility::flag( "ruby_mq_key_picked" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_4ac3037bff9477de ] ], #"ruby_mq_guidance", #"key" );
    }
    else if ( !utility::flag( "ruby_mq_freezer_opened" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.freezerinteract ] ], #"ruby_mq_guidance", #"cryo" );
    }
    else if ( !utility::flag( "ruby_mq_saw_picked" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.mdl_bonesaw.origin + ( 7, 0, 0 ) ] ], #"ruby_mq_guidance", #"saw" );
    }
    else if ( !utility::flag( "ruby_mq_brain_picked" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.surgeryinteract ] ], #"ruby_mq_guidance", #"hash_d7915ddc92c60e30" );
    }
    else if ( !utility::flag( "ruby_mq_brain_machine" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_3f0220d6402db113 ] ], #"ruby_mq_guidance", #"brain_carry" );
    }
    else if ( utility::flag( "ruby_mq_machine_cooldown" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_mq_guidance", #"cooldown_perf" );
    }
    else if ( !utility::flag( "ruby_mq_s2_defend_success" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_3f0220d6402db113 ] ], #"ruby_mq_guidance", #"perf_activate" );
    }
    else if ( !utility::flag( "ruby_mq_perfusion_orrey_placed" ) && !utility::flag( "ruby_mq_s3_portal_initiated" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_3f0220d6402db113 ], [ level.ruby_mq.var_54f3c94c69fc1696 ] ], #"ruby_mq_guidance", #"perf_carry" );
    }
    else if ( !utility::flag( "ruby_mq_s3_portal_initiated" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_54f3c94c69fc1696 ] ], #"ruby_mq_guidance", #"perf_connect" );
    }
    else if ( utility::flag( "ruby_mq_bookpuzzle_cooldown" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_mq_guidance", #"hash_e6c3b7a7290d271c" );
    }
    else if ( !utility::flag( "ruby_mq_directed_green_bust_active" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step3_statue_puzzle_marker", "targetname" ) ], [ level.ruby_mq.var_41b3fabaac6f2d46, 30 ] ], #"ruby_mq_guidance", #"bust_green" );
    }
    else if ( !utility::flag( "ruby_mq_directed_red_bust_active" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step3_statue_puzzle_marker", "targetname" ) ], [ level.ruby_mq.var_5f3072b81b818132, 30 ] ], #"ruby_mq_guidance", #"bust_red" );
    }
    else if ( !utility::flag( "ruby_mq_directed_blue_bust_active" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step3_statue_puzzle_marker", "targetname" ) ], [ level.ruby_mq.var_7ada84406efe743b, 30 ] ], #"ruby_mq_guidance", #"bust_blue" );
    }
    else if ( !utility::flag( "ruby_mq_book_puzzle_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step3_planet", "targetname" ) ] ], #"ruby_mq_guidance", #"neptune_get" );
    }
    else if ( !utility::flag( "ruby_mq_neptune_orrey_placed" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step3_orrey_neptune_orrery", "targetname" ), 0 ] ], #"ruby_mq_guidance", #"neptune_place" );
    }
    else if ( !utility::flag( "ruby_mq_orrey_all_planets_set" ) )
    {
        clue_locs = utility::getstructarray( "step3_orrey_clue_paper", "targetname" );
        thread zm_quest::update_guidance( [ [ clue_locs[ 0 ] ], [ clue_locs[ 1 ] ], [ clue_locs[ 2 ] ], [ utility::getstruct( "step3_portal_dmg_point", "targetname" ), 0, 400 ] ], #"ruby_mq_guidance", #"align" );
    }
    else if ( !utility::flag( "ruby_mq_s3_mars_coord_entered" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.coord_machine, 70 ], [ utility::getstruct( "telescope_interact", "targetname" ) ] ], #"ruby_mq_guidance", #"coords" );
    }
    else if ( utility::flag( "ruby_mq_orrey_defend_cooldown" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_mq_guidance", #"cooldown_portal" );
    }
    else if ( !utility::flag( "ruby_mq_s3_orrery_defend_success" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_54f3c94c69fc1696 ] ], #"ruby_mq_guidance", #"portal" );
    }
    else if ( !utility::flag( "ruby_mq_voss_mars_start_picked" ) && !utility::flag( "ruby_mq_perfusion_placed_mars" ) && !utility::flag( "ruby_mq_power_generator_initiated" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_b7a2a512051b1684.origin + ( 10, -5, 0 ) ] ], #"ruby_mq_guidance", #"thurston_get" );
    }
    else if ( !utility::flag( "ruby_mq_power_generator_initiated" ) && !utility::flag( "ruby_mq_perfusion_placed_mars" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_3150bc6e12cf8a52 ] ], #"ruby_mq_guidance", #"aegis" );
    }
    else if ( utility::flag( "ruby_mq_alien_cooldown" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_mq_guidance", #"cooldown_mars" );
    }
    else if ( !utility::flag( "ruby_mq_power_generator_initiated" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_3150bc6e12cf8a52 ] ], #"ruby_mq_guidance", #"perf_connect_mars", 1 );
    }
    else if ( !utility::flag( "ruby_mq_perfusion_placed_mars" ) && utility::flag( "ruby_mq_bells_reset" ) && !utility::flag( "ruby_mq_alien_spawned" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_3150bc6e12cf8a52 ] ], #"ruby_mq_guidance", #"aegis_final", 1 );
    }
    else if ( !utility::flag( "ruby_mq_alien_arena_center_first" ) )
    {
        for ( i = 0; i < level.ruby_mq.mdl_bells.size ; i++ )
        {
            if ( level.ruby_mq.mdl_bells[ i ].bshot == 0 )
            {
                next_bell = i;
                break;
            }
        }
        
        thread zm_quest::update_guidance( [ [ level.ruby_mq.mdl_bells[ next_bell ], 200 ] ], #"ruby_mq_guidance", #"lure" );
    }
    else if ( !utility::flag( "ruby_mq_alien_artifact_picked" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_6e70958170ad902f ] ], #"ruby_mq_guidance", #"eye_get" );
    }
    else if ( !utility::flag( "ruby_mq_artifact_mars_placed" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step4_alien_mars_interact", "targetname" ) ] ], #"ruby_mq_guidance", #"eye_install", 1 );
    }
    else if ( !utility::flag( "ruby_mq_all_5_melody_pillars_on" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step4_squadron_revolve_1", "targetname" ), 60 ], [ utility::getstruct( "step4_squadron_revolve_2", "targetname" ), 60 ], [ utility::getstruct( "step4_squadron_revolve_3", "targetname" ), 60 ], [ utility::getstruct( "step4_squadron_revolve_4", "targetname" ), 60 ], [ utility::getstruct( "step4_squadron_revolve_5", "targetname" ), 60 ] ], #"ruby_mq_guidance", #"columns_shoot" );
    }
    else if ( !utility::flag( "ruby_mq_melody_obtained" ) )
    {
        level.var_18cae6c63b0f0662 = 0;
        
        if ( !level callback::exists( "pristmatic_activated", &set_melody_flag ) )
        {
            level callback::add( "pristmatic_activated", &set_melody_flag );
        }
        
        thread zm_quest::update_guidance( [ [ level.power_station, 30 ] ], #"ruby_mq_guidance", #"get_melody" );
    }
    else if ( utility::flag( "ruby_mq_melody_cooldown" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_mq_guidance", #"cooldown_mars" );
    }
    else if ( !utility::flag( "ruby_mq_s4_code_1" ) && !utility::flag( "ruby_mq_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step4_pillar_" + level.ruby_mq.var_16120e7bf8d769e9[ 0 ], "targetname" ), 90 ] ], #"ruby_mq_guidance", #"columns_activate" );
    }
    else if ( !utility::flag( "ruby_mq_s4_code_2" ) && !utility::flag( "ruby_mq_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step4_pillar_" + level.ruby_mq.var_16120e7bf8d769e9[ 1 ], "targetname" ), 90 ] ], #"ruby_mq_guidance", #"columns_activate" );
    }
    else if ( !utility::flag( "ruby_mq_s4_code_3" ) && !utility::flag( "ruby_mq_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step4_pillar_" + level.ruby_mq.var_16120e7bf8d769e9[ 2 ], "targetname" ), 90 ] ], #"ruby_mq_guidance", #"columns_activate" );
    }
    else if ( !utility::flag( "ruby_mq_s4_code_4" ) && !utility::flag( "ruby_mq_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step4_pillar_" + level.ruby_mq.var_16120e7bf8d769e9[ 3 ], "targetname" ), 90 ] ], #"ruby_mq_guidance", #"columns_activate" );
    }
    else if ( !utility::flag( "ruby_mq_s4_code_5" ) && !utility::flag( "ruby_mq_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "step4_pillar_" + level.ruby_mq.var_16120e7bf8d769e9[ 4 ], "targetname" ), 90 ] ], #"ruby_mq_guidance", #"columns_activate" );
    }
    else
    {
        thread zm_quest::update_guidance( [ [ level.ruby_mq.var_3150bc6e12cf8a52 ] ], #"ruby_mq_guidance", #"aegis_final", 1 );
    }
    
    foreach ( player in level.players )
    {
        zm_sat_ruby::function_1b3de6ab79deb1b7( player );
    }
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x356eefd5, Offset: 0x4a37
    // Size: 0x5, Type: dev
    function private function_369d7d279c382380()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xab3751a5, Offset: 0x4a44
// Size: 0x38
function setup_step_1( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        return;
    }
    
    level thread function_93466d327616a655();
    level thread setup_dial_interact();
    level utility::flag_wait( "ruby_mq_key_picked" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xe332500f, Offset: 0x4a84
// Size: 0x149
function function_61e5b348e99af311( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_wait( "ruby_wwq_complete" );
        zm_quest::function_b57dfe9625966b0b( #"ruby_mq_misc", 0, #"key", 1 );
        level utility::flag_set( "ruby_mq_key_picked" );
        level utility::flag_set( "ruby_mq_platform_moved" );
        level utility::flag_set( "ruby_mq_platform_value_set" );
        level utility::flag_set( "mq_directed_platform_clue_heard" );
        level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_1", "num_1" );
        level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_2", "num_1" );
        level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_3", "num_5" );
        level thread function_2053966bb309008c();
        
        if ( isdefined( level.ruby_mq.buttoninteract ) )
        {
            level.ruby_mq.buttoninteract delete();
        }
        
        if ( isdefined( level.ruby_mq.buttoninteract ) )
        {
            level.ruby_mq.buttoninteract delete();
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0xa704b83, Offset: 0x4bd5
// Size: 0x131
function function_2053966bb309008c()
{
    level endon( #"game_ended" );
    wait 4;
    var_a6e5905583be59d = getent( "step1_lifting_platform", #targetname );
    var_a6e5905583be59d setscriptablepartstate( "audio", "platform_sound" );
    s_corpse = utility::getstruct( "step1_cultist", "targetname" );
    corpse = spawn( "script_model", s_corpse.origin );
    corpse.angles = s_corpse.angles;
    corpse setmodel( "c_sat_zmb_zombie_male_robed_corpse_2" );
    corpse linkto( var_a6e5905583be59d, "j_platform" );
    waitframe();
    var_a6e5905583be59d setscriptablepartstate( "anim", "move" );
    var_a6e5905583be59d setscriptablepartstate( "vfx_spark", "on_spark" );
    var_a6e5905583be59d setscriptablepartstate( "vfx_dust", "on_dust" );
    platform_floor = getent( "step1_platform_floor", #targetname );
    platform_floor show();
    platform_floor disconnectpaths();
    platform_floor solid();
    navlink_count = 4;
    var_4f8415de8a0aa650 = -10;
    level thread function_f689386ad72e05f9( navlink_count, var_4f8415de8a0aa650, platform_floor );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x35cda82d, Offset: 0x4d0e
// Size: 0xdb
function private function_765684a8aa075fd3()
{
    level utility::flag_wait( "ruby_papq_complete" );
    s_prismatic = utility::getstruct( "step1_perismatic", "targetname" );
    prismatic_interact = interaction::register_interact( s_prismatic.origin, 70, &function_6e9beef2a326956f );
    prismatic_interact sethintonobstruction( "show" );
    prismatic_interact interaction::set_interact_hint_callback( &prismatic_interact_hint );
    level.ruby_mq.var_c3c27fb4496f171 = 0;
    var_16120e7bf8d769e9 = [ 1, 2, 3, 4, 5 ];
    level.ruby_mq.var_16120e7bf8d769e9 = arrayrandomize( var_16120e7bf8d769e9 );
    level.ruby_mq.var_fe854866e33fb015 = randomintrange( 1, 6 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x51bb5dd4, Offset: 0x4df1
// Size: 0x1c4
function private function_6e9beef2a326956f( player )
{
    if ( !level.ruby_mq.var_c3c27fb4496f171 )
    {
        level callback::callback( "pristmatic_activated" );
        s_prismatic = utility::getstruct( "step1_perismatic", "targetname" );
        level.ruby_mq.var_c3c27fb4496f171 = 1;
        level.power_station setscriptablepartstate( "anim", "play" );
        basestring = "evt_mq_organ_note_0";
        
        foreach ( num in level.ruby_mq.var_16120e7bf8d769e9 )
        {
            newstring = basestring + num;
            playsoundatpos( s_prismatic.origin, newstring );
            
            if ( num != level.ruby_mq.var_fe854866e33fb015 )
            {
                str_num = get_screen_num( num );
                level.power_station setscriptablepartstate( "symbols", str_num );
            }
            else
            {
                level.power_station setscriptablepartstate( "symbols", "idle" );
            }
            
            wait 2;
        }
        
        level.power_station setscriptablepartstate( "anim", "off" );
        level.power_station setscriptablepartstate( "symbols", "idle" );
        level.ruby_mq.var_c3c27fb4496f171 = 0;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x5a00b46, Offset: 0x4fbd
// Size: 0x89
function private prismatic_interact_hint( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/play", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x944c403a, Offset: 0x504e
// Size: 0x51
function private set_melody_flag( params )
{
    level utility::flag_set( "ruby_mq_melody_obtained" );
    
    if ( level callback::exists( "pristmatic_activated", &set_melody_flag ) )
    {
        level callback::remove( "pristmatic_activated", &set_melody_flag );
    }
    
    level.var_18cae6c63b0f0662 = 1;
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x7508c1ea, Offset: 0x50a7
// Size: 0x70
function private get_screen_num( num )
{
    switch ( num )
    {
        case 1:
            return "num_1";
        case 2:
            return "num_2";
        case 3:
            return "num_3";
        case 4:
            return "num_4";
        case 5:
            return "num_5";
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x883ebc36, Offset: 0x511f
// Size: 0xeb
function private setup_nixie_tube_machine()
{
    utility::flag_wait( "scriptables_ready" );
    s_nixie = utility::getstruct( "step1_nixie_tube", "targetname" );
    level.ruby_mq.scr_nixie_tube = spawnscriptable( %"sat_zm_ruby_mq_nixie_tube", s_nixie.origin, s_nixie.angles );
    level.ruby_mq.scr_nixie_tube utility::function_7c10ea82c1e305b8( "nixie_fx", "off" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_1", "off" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_2", "off" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_3", "off" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x2ef9bf7c, Offset: 0x5212
// Size: 0x1b8
function private setup_dial_interact()
{
    var_52a46ab10c5fde2b = utility::getstruct( "step1_dial_1", "targetname" );
    level.mdl_dial = utility::spawn_model( %"sat_zm_nixie_tube_scaledisc", var_52a46ab10c5fde2b.origin, var_52a46ab10c5fde2b.angles );
    level.ruby_mq.buttoninteract = interaction::register_interact( level.mdl_dial.origin, 100, &function_c3262343613ae7c1 );
    level.ruby_mq.buttoninteract sethintonobstruction( "show" );
    level.ruby_mq.buttoninteract interaction::set_interact_hint_callback( &platform_interact_hint );
    level.ruby_mq.var_905dbcc8715a0e63 = 0;
    level.mdl_dial.var_8cb721201d46b96c = 0;
    level.ruby_mq.scr_nixie_tube utility::function_7c10ea82c1e305b8( "nixie_fx", "on" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_1", "num_0" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_2", "num_0" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_3", "num_0" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "all_off", "all_off" );
    ui::lui_registercallback( "ui_safe_selected_index_change", &function_3fbf42db4249f42b );
    level.ruby_mq.nixie_tube_num = 0;
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x8b1891a4, Offset: 0x53d2
// Size: 0x2a0
function private function_c3262343613ae7c1( player )
{
    if ( level utility::flag( "ruby_mq_nixie_cooldown" ) )
    {
        return;
    }
    
    if ( self.var_e763e623b92b45f || isdefined( level.var_720ac4c9a80008bc ) )
    {
        return;
    }
    
    level.var_720ac4c9a80008bc = player;
    self.var_e763e623b92b45f = 1;
    player callback::add( #"player_death", &function_63a08d18662fc8e7, self );
    level utility::flag_set( "ruby_mq_dial_in_use" );
    player function_814e28ebc00f977d();
    player val::set( "ruby_mq", "allow_movement", 0 );
    player val::set( "ruby_mq", "crouch", 0 );
    player val::set( "ruby_mq", "prone", 0 );
    player val::set( "ruby_mq", "melee", 0 );
    player val::set( "ruby_mq", "offhand_primary_weapons", 0 );
    player val::set( "ruby_mq", "offhand_secondary_weapons", 0 );
    player val::set( "ruby_mq", "damage", 0 );
    player val::set( "ruby_mq", "killstreaks", 0 );
    player val::set( "ruby_mq", "ignoreme", 1 );
    player val::set( "ruby_mq", "show_hud", 0 );
    player val::set( "ruby_mq", "freezecontrols", 1 );
    player val::set( "ruby_mq", "ads", 0 );
    player val::set( "ruby_mq", "weapon_switch", 0 );
    player val::set( "ruby_mq", "action_slot_weapon", 0 );
    player val::set( "ruby_mq", "armor", 0 );
    player val::set( "ruby_mq", "supers", 0 );
    player zm_quest::disable_specific_player_bgb( 1 );
    player setclientomnvar( "ui_safe_max_number", 9 );
    player setclientomnvar( "ui_safe_combination", level.ruby_mq.var_51d24fa4b956b91a );
    player thread function_e4cf99f2772f4642();
    player thread function_41a166a2a648a0fb();
    player thread function_3a33de05cee7f8d8( self );
    player thread timeout_watcher( self );
    player thread laststand_watcher( self );
    player thread disconnect_watcher( self );
    player notifyonplayercommand( "lock_combo", "+movedown" );
    player notifyonplayercommand( "lock_combo", "+stance" );
    player notifyonplayercommand( "rotate_left", "+smoke" );
    player notifyonplayercommand( "rotate_left_done", "-smoke" );
    player notifyonplayercommand( "rotate_right", "+frag" );
    player notifyonplayercommand( "rotate_right_done", "-frag" );
    self.var_e763e623b92b45f = 1;
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x1a6d0131, Offset: 0x567a
// Size: 0x68
function private function_63a08d18662fc8e7( params, vault_interact )
{
    self setclientomnvar( "ui_safe_combination", -1 );
    vault_interact.var_e763e623b92b45f = 0;
    level.var_720ac4c9a80008bc = undefined;
    utility::flag_clear( "ruby_mq_dial_in_use" );
    callback::remove( #"player_death", &function_63a08d18662fc8e7, vault_interact );
    level notify( #"hash_dafa5f729d2ed4fc" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xc9b04e22, Offset: 0x56ea
// Size: 0x5e
function private function_814e28ebc00f977d()
{
    if ( !self hasweapon( level.defaultfist ) )
    {
        inventory_utility::_giveweapon( level.defaultfist );
        self.var_992931d94b8d49ce = 1;
    }
    
    self.var_a0a6e62362222ecf = self getcurrentweapon();
    
    if ( self getcurrentweapon() != level.defaultfist )
    {
        self switchtoweapon( level.defaultfist );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x42495c65, Offset: 0x5750
// Size: 0x8e
function private function_b252f2d3fe074e9e()
{
    if ( self.var_992931d94b8d49ce )
    {
        inventory_utility::_takeweapon( level.defaultfist );
    }
    
    self.var_992931d94b8d49ce = undefined;
    
    if ( isdefined( self.var_a0a6e62362222ecf ) && self hasweapon( self.var_a0a6e62362222ecf ) )
    {
        if ( self.var_a0a6e62362222ecf != level.defaultfist )
        {
            self switchtoweapon( self.var_a0a6e62362222ecf );
        }
    }
    else if ( val::get( "weapon" ) )
    {
        inventory_utility::forcevalidweapon();
    }
    
    self.var_a0a6e62362222ecf = undefined;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x15086c56, Offset: 0x57e6
// Size: 0xbd
function private function_e4cf99f2772f4642()
{
    level endon( #"game_ended" );
    level endon( #"hash_dafa5f729d2ed4fc" );
    
    if ( self != level.var_720ac4c9a80008bc )
    {
        return;
    }
    
    s_destination = utility::getstruct( "step1_player_stand_pos", "targetname" );
    var_39ba2d0e5e19e1da = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self playerlinktodelta( var_39ba2d0e5e19e1da, "tag_origin", 0, 0, 0, 0, 0 );
    self.var_6e0e447abb442d13 = var_39ba2d0e5e19e1da;
    var_39ba2d0e5e19e1da rotateto( s_destination.angles, 0.1 );
    wait 0.1;
    var_39ba2d0e5e19e1da moveto( s_destination.origin, 0.1 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x4e5063b8, Offset: 0x58ab
// Size: 0x498
function private function_3a33de05cee7f8d8( interact )
{
    level endon( #"game_ended" );
    level endon( #"hash_dafa5f729d2ed4fc" );
    self endon( #"death" );
    self endon( #"disconnect" );
    interact endon( #"deleted" );
    interact endon( #"death" );
    
    if ( level utility::flag( "ruby_mq_platform_moved" ) )
    {
        return;
    }
    
    if ( self != level.var_720ac4c9a80008bc )
    {
        return;
    }
    
    self setclientomnvar( "ui_safe_combination", level.ruby_mq.var_51d24fa4b956b91a );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( message == "ui_safe_combination_input" )
        {
            if ( value == 0 )
            {
                self playsoundtoplayer( "evt_mq_safe_unlock_success", self );
                function_b12ba4cb375d2cf8();
                level thread platform_sequence();
                level thread function_4d49ec62a27c6515( self );
                interact thread function_4ebea3e8f82f1165();
            }
            else if ( value == 1 )
            {
                /#
                    iprintlnbold( "<dev string:x24>" );
                #/
                
                self playsoundtoplayer( "evt_mq_safe_wrong_code", self );
                function_b12ba4cb375d2cf8();
                level.ruby_mq.var_905dbcc8715a0e63++;
                level.ruby_mq.nixie_tube_num = 0;
                level.mdl_dial.var_8cb721201d46b96c = 0;
                level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_1", "num_0" );
                level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_2", "num_0" );
                level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_3", "num_0" );
                
                if ( level.ruby_mq.var_905dbcc8715a0e63 >= 2 )
                {
                    level utility::flag_set( "ruby_mq_nixie_cooldown" );
                    level.ruby_mq.var_333576f0495ad212 = zm_round_logic::get_rb_round_number() + 1;
                    level callback::add( "on_round_start", &function_9f0ceeb4bc5b0d3c );
                    level.ruby_mq.scr_nixie_tube utility::function_7c10ea82c1e305b8( "nixie_fx", "cooldown" );
                    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_1", "off" );
                    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_2", "off" );
                    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_3", "off" );
                    
                    if ( !level utility::flag( "vo_nixie_failed" ) )
                    {
                        var_aae24157ce145e00 = 1;
                    }
                    
                    zm_quest::function_5b5c737326035ea( 1 );
                }
            }
            else if ( value == 2 )
            {
                /#
                    iprintlnbold( "<dev string:x34>" );
                #/
                
                self playsoundtoplayer( "evt_mq_safe_wrong_code", self );
                function_b12ba4cb375d2cf8();
                level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_1", "num_0" );
                level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_2", "num_0" );
                level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_3", "num_0" );
                level.ruby_mq.nixie_tube_num = 0;
                level.mdl_dial.var_8cb721201d46b96c = 0;
                level.ruby_mq.var_905dbcc8715a0e63++;
                
                if ( level.ruby_mq.var_905dbcc8715a0e63 >= 2 )
                {
                    level utility::flag_set( "ruby_mq_nixie_cooldown" );
                    level.ruby_mq.var_333576f0495ad212 = zm_round_logic::get_rb_round_number() + 1;
                    level callback::add( "on_round_start", &function_9f0ceeb4bc5b0d3c );
                    level.ruby_mq.scr_nixie_tube utility::function_7c10ea82c1e305b8( "nixie_fx", "cooldown" );
                    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_1", "off" );
                    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_2", "off" );
                    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_3", "off" );
                    zm_quest::function_5b5c737326035ea( 1 );
                }
            }
            
            if ( isdefined( self ) )
            {
                interact exit_unlock_mode( self, var_aae24157ce145e00 );
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x24d50d31, Offset: 0x5d4b
// Size: 0x4b
function private function_4d49ec62a27c6515( player )
{
    var_db75d3de862ce072 = player_banter::play_banter_vo( #"hash_75480351c8bad742" );
    
    if ( var_db75d3de862ce072 == 1 )
    {
        return;
    }
    
    player thread zm_vo::function_8c1a12974bd11f01( #"hash_75480351c8bad742", #"bc_flavor_player_positive" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x6554c3d2, Offset: 0x5d9e
// Size: 0x93
function private function_b12ba4cb375d2cf8()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    s_des = utility::getstruct( "step1_player_step_back_pos", "targetname" );
    self.var_6e0e447abb442d13 rotateto( s_des.angles, 0.1 );
    self.var_6e0e447abb442d13 moveto( s_des.origin, 0.1 );
    self.var_6e0e447abb442d13 waittill( #"movedone" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x35c7d13b, Offset: 0x5e39
// Size: 0x1a
function private function_4ebea3e8f82f1165()
{
    level endon( #"game_ended" );
    wait 0.2;
    self delete();
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x2d6c0419, Offset: 0x5e5b
// Size: 0x2d6
function exit_unlock_mode( player, var_aae24157ce145e00 )
{
    level endon( #"game_ended" );
    level endon( #"hash_dafa5f729d2ed4fc" );
    
    if ( isdefined( player ) )
    {
        player endon( #"death" );
        player endon( #"disconnect" );
    }
    
    self endon( #"deleted" );
    self endon( #"death" );
    
    if ( isdefined( player ) )
    {
        level thread post_exit_unlock_mode( player );
    }
    
    level.var_720ac4c9a80008bc = undefined;
    
    if ( isdefined( self ) )
    {
        self.var_e763e623b92b45f = 0;
    }
    
    if ( isdefined( player ) )
    {
        player setclientomnvar( "ui_safe_combination", -1 );
        player val::reset( "ruby_mq", "allow_movement" );
        player val::reset( "ruby_mq", "crouch" );
        player val::reset( "ruby_mq", "prone" );
        player val::reset( "ruby_mq", "melee" );
        player val::reset( "ruby_mq", "offhand_primary_weapons" );
        player val::reset( "ruby_mq", "offhand_secondary_weapons" );
        player val::reset( "ruby_mq", "damage" );
        player val::reset( "ruby_mq", "show_hud" );
        player val::reset( "ruby_mq", "freezecontrols" );
        player val::reset( "ruby_mq", "ads" );
        player val::reset( "ruby_mq", "weapon_switch" );
        player val::reset( "ruby_mq", "action_slot_weapon" );
        player val::reset( "ruby_mq", "armor" );
        player val::reset( "ruby_mq", "supers" );
        player zm_quest::disable_specific_player_bgb( 0 );
        player function_b252f2d3fe074e9e();
        player thread function_979693a26bab228();
        
        if ( isdefined( player.var_fe00a2404ce26ba ) )
        {
            player.var_fe00a2404ce26ba delete();
        }
        
        if ( isdefined( player.var_f84f64efdacb6ad3 ) )
        {
            player.var_f84f64efdacb6ad3 destroy();
        }
        
        if ( isdefined( player.var_795151d34683e1e5 ) )
        {
            player.var_795151d34683e1e5 destroy();
        }
        
        if ( isdefined( player.var_79514dd34683d919 ) )
        {
            player.var_79514dd34683d919 destroy();
        }
        
        player unlink();
        
        if ( isdefined( player.var_6e0e447abb442d13 ) )
        {
            player.var_6e0e447abb442d13 delete();
        }
        
        player setstance( "stand" );
        player notifyonplayercommandremove( "lock_combo", "+movedown" );
        player notifyonplayercommandremove( "lock_combo", "+stance" );
        player callback::remove( #"player_death", &function_63a08d18662fc8e7, self );
        
        if ( var_aae24157ce145e00 )
        {
            player thread function_a0724c1168ef16de();
        }
    }
    
    utility::flag_clear( "ruby_mq_dial_in_use" );
    level notify( #"hash_dafa5f729d2ed4fc" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x9698e03c, Offset: 0x6139
// Size: 0x30
function function_a0724c1168ef16de()
{
    var_db75d3de862ce072 = battlechatter_mp::trysaylocalsound( self, #"bc_flavor_player_negative" );
    
    if ( var_db75d3de862ce072 )
    {
        level utility::flag_set( "vo_nixie_failed" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xeb11feb5, Offset: 0x6171
// Size: 0x2e
function private post_exit_unlock_mode( player )
{
    level endon( #"game_ended" );
    wait 1;
    player val::reset( "ruby_mq", "killstreaks" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x4f02411c, Offset: 0x61a7
// Size: 0x6a
function private timeout_watcher( interact )
{
    level endon( #"game_ended" );
    level endon( #"hash_dafa5f729d2ed4fc" );
    self endon( #"death" );
    self endon( #"disconnect" );
    interact endon( #"deleted" );
    interact endon( #"death" );
    wait 120;
    function_b12ba4cb375d2cf8();
    interact exit_unlock_mode( self );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x863fc69b, Offset: 0x6219
// Size: 0x36
function private function_979693a26bab228()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 5;
    
    if ( isalive( self ) )
    {
        val::reset( "ruby_mq", "ignoreme" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xa6d2cc07, Offset: 0x6257
// Size: 0x71
function private laststand_watcher( interact )
{
    level endon( #"game_ended" );
    level endon( #"hash_dafa5f729d2ed4fc" );
    self endon( #"death" );
    self endon( #"disconnect" );
    interact endon( #"deleted" );
    interact endon( #"death" );
    
    while ( !self.inlaststand )
    {
        waitframe();
    }
    
    interact exit_unlock_mode( self );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xdeebf94a, Offset: 0x62d0
// Size: 0xca
function private disconnect_watcher( interact )
{
    level endon( #"game_ended" );
    level endon( #"hash_dafa5f729d2ed4fc" );
    self waittill( #"disconnect" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_1", "num_0" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_2", "num_0" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_3", "num_0" );
    level.ruby_mq.nixie_tube_num = 0;
    level.mdl_dial.var_8cb721201d46b96c = 0;
    interact exit_unlock_mode();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x4af4b05, Offset: 0x63a2
// Size: 0x9b
function private function_41a166a2a648a0fb()
{
    level endon( #"game_ended" );
    level endon( #"hash_dafa5f729d2ed4fc" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( message == "ui_safe_dial_rotate" )
        {
            if ( value == 1 )
            {
                var_2fa2cc5f097dbff6 = 1;
                function_85858fd9760f836e( var_2fa2cc5f097dbff6 );
                continue;
            }
            
            if ( value == 0 )
            {
                var_2fa2cc5f097dbff6 = 0;
                function_85858fd9760f836e( var_2fa2cc5f097dbff6 );
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x4b9dff18, Offset: 0x6445
// Size: 0x1d4
function private function_85858fd9760f836e( var_3bebcac616237e4a )
{
    if ( var_3bebcac616237e4a )
    {
        level.mdl_dial.var_8cb721201d46b96c++;
        
        if ( level.mdl_dial.var_8cb721201d46b96c > 9 )
        {
            level.mdl_dial.var_8cb721201d46b96c = 0;
        }
        
        str_num = get_tube_value( level.mdl_dial.var_8cb721201d46b96c );
        level.ruby_mq.scr_nixie_tube setscriptablepartstate( level.ruby_mq.nixie_tube_name, str_num );
        
        /#
            iprintlnbold( level.mdl_dial.var_8cb721201d46b96c );
        #/
        
        level.mdl_dial rotateroll( 6, 0.01, 0, 0 );
        utility::play_sound_in_space( "evt_zm_safe_dial_turn", level.mdl_dial.origin );
        return;
    }
    
    level.mdl_dial.var_8cb721201d46b96c--;
    
    if ( level.mdl_dial.var_8cb721201d46b96c < 0 )
    {
        level.mdl_dial.var_8cb721201d46b96c = 9;
    }
    
    str_num = get_tube_value( level.mdl_dial.var_8cb721201d46b96c );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( level.ruby_mq.nixie_tube_name, str_num );
    
    /#
        iprintlnbold( level.mdl_dial.var_8cb721201d46b96c );
    #/
    
    level.mdl_dial rotateroll( -6, 0.01, 0, 0 );
    utility::play_sound_in_space( "evt_zm_safe_dial_turn", level.mdl_dial.origin );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xf269d250, Offset: 0x6621
// Size: 0xea
function private function_3fbf42db4249f42b( params )
{
    if ( level.ruby_mq.nixie_tube_num > 3 )
    {
        level.ruby_mq.nixie_tube_num = 0;
    }
    
    level.ruby_mq.nixie_tube_num++;
    
    if ( level.ruby_mq.nixie_tube_num == 1 )
    {
        level.ruby_mq.nixie_tube_name = "tube_1";
        return;
    }
    
    if ( level.ruby_mq.nixie_tube_num == 2 )
    {
        level.ruby_mq.nixie_tube_name = "tube_2";
        return;
    }
    
    if ( level.ruby_mq.nixie_tube_num == 3 )
    {
        level.ruby_mq.nixie_tube_name = "tube_3";
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x2c545e, Offset: 0x6713
// Size: 0xd8
function private get_tube_value( num )
{
    if ( num > 9 )
    {
        return "num_0";
    }
    
    switch ( num )
    {
        case 0:
            return "num_0";
        case 1:
            return "num_1";
        case 2:
            return "num_2";
        case 3:
            return "num_3";
        case 4:
            return "num_4";
        case 5:
            return "num_5";
        case 6:
            return "num_6";
        case 7:
            return "num_7";
        case 8:
            return "num_8";
        case 9:
            return "num_9";
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x23698f65, Offset: 0x67f3
// Size: 0x2b1
function private platform_sequence()
{
    level utility::flag_set( "ruby_mq_platform_moved" );
    var_a6e5905583be59d = getent( "step1_lifting_platform", #targetname );
    var_a6e5905583be59d setscriptablepartstate( "audio", "platform_sound" );
    earthquake( 0.2, 4, level.mdl_dial.origin, 600 );
    playrumbleonposition( "artillery_rumble_light", level.mdl_dial.origin );
    s_corpse = utility::getstruct( "step1_cultist", "targetname" );
    var_34304ed136650354 = utility::getstruct( "step1_cryo_key", "targetname" );
    corpse = spawn( "script_model", s_corpse.origin );
    corpse.angles = s_corpse.angles;
    corpse setmodel( "c_sat_zmb_zombie_male_robed_corpse_2" );
    level.ruby_mq.var_4ac3037bff9477de = utility::spawn_model( %"sat_zm_victorian_era_key", var_34304ed136650354.origin, var_34304ed136650354.angles );
    corpse linkto( var_a6e5905583be59d, "j_platform" );
    level.ruby_mq.var_4ac3037bff9477de linkto( var_a6e5905583be59d, "j_platform" );
    var_a6e5905583be59d setscriptablepartstate( "anim", "move" );
    var_a6e5905583be59d setscriptablepartstate( "vfx_spark", "on_spark" );
    var_a6e5905583be59d setscriptablepartstate( "vfx_dust", "on_dust" );
    platform_floor = getent( "step1_platform_floor", #targetname );
    platform_floor show();
    platform_floor disconnectpaths();
    platform_floor solid();
    level.ruby_mq.var_f9b2039db2b04b3b show();
    level.ruby_mq.var_f9b2039db2b04b3b connectpaths();
    level.ruby_mq.var_f9b2039db2b04b3b solid();
    navlink_count = 4;
    var_4f8415de8a0aa650 = -10;
    level thread function_f689386ad72e05f9( navlink_count, var_4f8415de8a0aa650, platform_floor );
    var_da51ece89a922a26 = utility::getstruct( "step1_cultist_moved", "targetname" );
    var_35d81fea94f71ee = utility::getstruct( "step1_cryo_key_moved", "targetname" );
    level utility::flag_set( "mq_directed_platform_clue_heard" );
    function_4ef47d3c5c627fb6();
    wait 4.5;
    var_b02bce41a2cb8fa9 = interaction::register_interact( var_35d81fea94f71ee.origin, 80, &cryo_key_interact );
    var_b02bce41a2cb8fa9 sethintonobstruction( "show" );
    var_b02bce41a2cb8fa9 interaction::set_interact_hint_callback( &function_58d87b3b2e916ba2 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x4b16d42e, Offset: 0x6aac
// Size: 0xa3
function private cryo_key_interact( player )
{
    if ( isdefined( level.ruby_mq.var_4ac3037bff9477de ) )
    {
        zm_quest::function_b57dfe9625966b0b( #"ruby_mq_misc", 0, #"key", 1 );
        player playsoundtoplayer( "evt_mq_cryo_chamber_key_pickup", player );
        zm_quest::show_splash_item_picked_up( #"ruby_mq_misc", #"key", 1, player );
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive" );
        waitframe();
        level.ruby_mq.var_4ac3037bff9477de delete();
        level utility::flag_set( "ruby_mq_key_picked" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x54e42adb, Offset: 0x6b57
// Size: 0xa1
function private function_58d87b3b2e916ba2( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled && isdefined( level.ruby_mq.var_4ac3037bff9477de ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/pick_up", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x3cfbf96c, Offset: 0x6c00
// Size: 0xa3
function private function_df184ba7ba3683c()
{
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    level.ruby_mq.var_f9b2039db2b04b3b = getent( "step1_platform_floor_ai", #targetname );
    
    if ( !isdefined( level.ruby_mq.var_f9b2039db2b04b3b ) )
    {
        return;
    }
    
    level.ruby_mq.var_f9b2039db2b04b3b disconnectpaths();
    level.ruby_mq.var_f9b2039db2b04b3b notsolid();
    level.ruby_mq.var_f9b2039db2b04b3b hide();
}

// Namespace zm_sat_ruby_quest_mq
// Params 3, eflags: 0x4
// Checksum 0xa41d22ae, Offset: 0x6cab
// Size: 0x74
function private function_f689386ad72e05f9( navlink_count, var_4f8415de8a0aa650, platform_floor )
{
    var_eda48cd0300b3466 = utility::getstruct( "step1_platform_navlink_bottom", "targetname" );
    var_edf023a4ef3e3e8 = utility::getstruct( "step1_platform_navlink_top", "targetname" );
    createnavlink( "platform_link", var_eda48cd0300b3466.origin, var_edf023a4ef3e3e8.origin );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x7d123216, Offset: 0x6d27
// Size: 0xa6
function private platform_interact_hint( interact, player )
{
    if ( isdefined( player ) && isdefined( interact ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled && !level utility::flag( "ruby_mq_nixie_cooldown" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/enter_code", #type:"HINT_BUTTON" };
        }
        
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xa2b732e4, Offset: 0x6dd5
// Size: 0x126
function private function_93466d327616a655()
{
    level.ruby_mq.var_483e904399b9c1eb = [];
    min_code = 1;
    max_code = 9;
    unique_codes = [];
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        unique_codes[ 0 ] = 5;
        unique_codes[ 1 ] = 2;
        unique_codes[ 2 ] = 7;
    }
    else
    {
        while ( unique_codes.size < 3 )
        {
            code = randomintrange( min_code, max_code );
            
            if ( !arraycontains( unique_codes, code ) )
            {
                unique_codes[ unique_codes.size ] = code;
            }
        }
    }
    
    level.ruby_mq.var_483e904399b9c1eb[ 0 ] = unique_codes[ 0 ];
    level.ruby_mq.var_483e904399b9c1eb[ 1 ] = unique_codes[ 1 ];
    level.ruby_mq.var_483e904399b9c1eb[ 2 ] = unique_codes[ 2 ];
    level.ruby_mq.var_51d24fa4b956b91a = unique_codes[ 0 ] * 10000 + unique_codes[ 1 ] * 100 + unique_codes[ 2 ];
    level utility::flag_wait_all( "wwq_step_2_complete", "wwq_step_3_complete", "wwq_step_7_complete" );
    level utility::flag_set( "ruby_mq_platform_value_set" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x9d5bf2af, Offset: 0x6f03
// Size: 0x106
function private function_9f0ceeb4bc5b0d3c( params )
{
    level callback::remove( "on_round_start", &function_9f0ceeb4bc5b0d3c );
    level.ruby_mq.var_333576f0495ad212 = undefined;
    level.ruby_mq.var_905dbcc8715a0e63 = 0;
    level.ruby_mq.nixie_tube_num = 0;
    level utility::flag_clear( "ruby_mq_nixie_cooldown" );
    level.ruby_mq.scr_nixie_tube utility::function_7c10ea82c1e305b8( "nixie_fx", "on" );
    level utility::flag_clear( "vo_nixie_failed" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_1", "num_0" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_2", "num_0" );
    level.ruby_mq.scr_nixie_tube setscriptablepartstate( "tube_3", "num_0" );
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x28c35624, Offset: 0x7011
// Size: 0x82
function private setup_stationary_note()
{
    s_note = utility::getstruct( "step1_note", "targetname" );
    mdl_note = utility::spawn_model( %"t10_int_signage_harrow_note_02", s_note.origin, s_note.angles );
    interact = interaction::register_interact( mdl_note, 64, &function_9688219aa346a71a );
    interact interaction::set_interact_hint_callback( &function_b2a22863a01c9120 );
    interact.noteid = 2;
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xf39aff28, Offset: 0x709b
// Size: 0x64
function private function_9688219aa346a71a( player )
{
    self disableplayeruse( player );
    thread function_d2ff91002c7769b2( player );
    thread function_316f23bb0b9c5a83( player );
    player setclientomnvar( "ui_immovable_note", self.noteid );
    player utility::delaycall( level.framedurationseconds, &setclientomnvar, "ui_immovable_note", 0 );
    player playsoundtoplayer( "evt_mq_pickup_document", player );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xd6f52b5, Offset: 0x7107
// Size: 0x40
function private function_b2a22863a01c9120( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"hash_53e619339ff74a44", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x25fc8c0f, Offset: 0x7150
// Size: 0x91
function private function_d2ff91002c7769b2( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    player endon( #"death_or_disconnect" );
    player endon( #"note_closed" );
    
    for ( ;; )
    {
        player waittill( #"luinotifyserver", message, value );
        
        if ( message == "exit_immovable_note" )
        {
            self enableplayeruse( player );
            player notify( #"note_closed" );
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x9cc92448, Offset: 0x71e9
// Size: 0x7d
function private function_316f23bb0b9c5a83( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"note_closed" );
    position = self.origin;
    
    for ( ;; )
    {
        if ( !isdefined( self ) || distance( position, player.origin ) >= 125 )
        {
            player setclientomnvar( "ui_immovable_note", -1 );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x5cce6ac6, Offset: 0x726e
// Size: 0x13e
function function_e10e743e0b592a72()
{
    level endon( #"game_ended" );
    platform_trigger = getent( "mq_tic_dmg", #targetname );
    platform_trigger.b_reset_time = 0;
    platform_trigger.var_3cd5bea2a8d3e74 = 0;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( platform_trigger ) )
            {
                platform_trigger.var_3cd5bea2a8d3e74++;
                
                if ( platform_trigger.var_3cd5bea2a8d3e74 >= 100 )
                {
                    player dodamage( 20, player.origin, platform_trigger, platform_trigger, "MOD_UNKNOWN", undefined, "none", undefined, 65536 );
                    player thread function_6a059e76eb0d6cce();
                    
                    if ( platform_trigger.b_reset_time == 0 )
                    {
                        platform_trigger.b_reset_time = 1;
                        platform_trigger thread function_4dbfbaebb5e1838f();
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0xa39cf21f, Offset: 0x73b4
// Size: 0x26
function function_4dbfbaebb5e1838f()
{
    level endon( #"game_ended" );
    wait 300;
    self.b_reset_time = 0;
    self.var_3cd5bea2a8d3e74 = 0;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x2c8356c5, Offset: 0x73e2
// Size: 0xea
function function_6a059e76eb0d6cce()
{
    self notify( #"hash_d50233f22bd4d61e" );
    self endon( #"hash_d50233f22bd4d61e" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !self.var_b4d756413b7103ef )
    {
        playfxontagforclients( level._effect[ "trap_electric_player" ], self, "j_head", self );
        self playsoundtoplayer( #"hash_79ef456929f3c3cc", self );
        self.electric_loop_sound = self playloopsound( #"hash_f2c677e2a71c39dd" );
        self.var_b4d756413b7103ef = 1;
    }
    
    val::set( "electric_trap", "move_speed_scale", 0.5 );
    wait 1;
    val::reset( "electric_trap", "move_speed_scale" );
    stopfxontagforclients( level._effect[ "trap_electric_player" ], self, "j_head", self );
    self stoploopsound( self.electric_loop_sound );
    self.var_b4d756413b7103ef = undefined;
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0xd29eee6a, Offset: 0x74d4
    // Size: 0x5, Type: dev
    function private function_dc9f04fbfe1af13f()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xffe3d89f, Offset: 0x74e1
// Size: 0x49
function setup_step_2( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "ruby_mq_key_picked" );
    setup_freezer_interact();
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_freezer_opened" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xdcf350c2, Offset: 0x7532
// Size: 0xb8
function function_61e5b048e99aec78( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "ruby_mq_freezer_opened" );
        mdl_cryo_chamber = getent( "step2_cryo_chamber", #targetname );
        waitframe();
        playfxontag( utility::getfx( "ruby_mq_cryo_idle_cushion" ), mdl_cryo_chamber, "tag_cushion" );
        mdl_cryo_chamber scene::play( undefined, undefined, "sat_zm_scene_cryochamber_open" );
        level.ruby_mq.var_18349d8b70ac1dbd = 10;
        
        if ( isdefined( level.ruby_mq.freezerinteract ) )
        {
            level.ruby_mq.freezerinteract delete();
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x8b7e7850, Offset: 0x75f2
// Size: 0x30
function private spawn_freezer()
{
    mdl_cryo_chamber = getent( "step2_cryo_chamber", #targetname );
    mdl_cryo_chamber scene::play( undefined, undefined, "sat_zm_scene_cryochamber_init" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xb5d23bc3, Offset: 0x762a
// Size: 0x86
function private setup_freezer_interact()
{
    var_e2859152839c2229 = utility::getstruct( "freezer_interact", "targetname" );
    level.ruby_mq.freezerinteract = interaction::register_interact( var_e2859152839c2229.origin, 100, &freezer_open_interact );
    level.ruby_mq.freezerinteract sethintonobstruction( "show" );
    level.ruby_mq.freezerinteract interaction::set_interact_hint_callback( &freezer_interact_hint );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xf32cca79, Offset: 0x76b8
// Size: 0xa8
function private freezer_open_interact( player )
{
    if ( level utility::flag( "mq_cryo_open_interact" ) )
    {
        return;
    }
    
    level utility::flag_set( "mq_cryo_open_interact" );
    mdl_cryo_chamber = getent( "step2_cryo_chamber", #targetname );
    level thread setup_voss_corpse( player );
    waitframe();
    playfxontag( utility::getfx( "ruby_mq_cryo_idle_cushion" ), mdl_cryo_chamber, "tag_cushion" );
    mdl_cryo_chamber scene::play( undefined, undefined, "sat_zm_scene_cryochamber_open" );
    
    if ( isdefined( level.ruby_mq.freezerinteract ) )
    {
        level.ruby_mq.freezerinteract delete();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x37caafb, Offset: 0x7768
// Size: 0x66
function private start_alarm()
{
    var_f328c0d815f9b15 = utility::getstruct( "step2_cryo_chamber_alarm", "targetname" );
    fx_alarm = spawnscriptable( %"sat_zm_ruby_mq_cryo_chamber_alarm", var_f328c0d815f9b15.origin );
    waitframe();
    fx_alarm setscriptablepartstate( "fx", "on" );
    wait 10;
    fx_alarm setscriptablepartstate( "fx", "off" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x3db3eb3c, Offset: 0x77d6
// Size: 0x36
function private setup_voss_corpse( player )
{
    wait 3;
    level teleport_galileo();
    level thread function_acaae95cef758a8f( player );
    level thread function_5bb75c348b67d2d9();
    level utility::flag_set( "ruby_mq_freezer_opened" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x60fc3d52, Offset: 0x7814
// Size: 0xa6
function private freezer_interact_hint( interact, player )
{
    if ( isdefined( player ) && isdefined( interact ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled && !level utility::flag( "mq_cryo_open_interact" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/fridge_button", #type:"HINT_BUTTON" };
        }
        
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xa74632b6, Offset: 0x78c2
// Size: 0x65
function private function_acaae95cef758a8f( player )
{
    wait 2.2;
    zm_quest::function_8934bb2a9028bdc5();
    level.ruby_mq.galileo dialogue::say( "dx_zm_rumn_2rtb_gali_rm2ga", undefined, undefined, undefined, 1 );
    zm_quest::function_8934bb2a9028bdc5();
    
    if ( isdefined( player ) )
    {
        player thread zm_vo::function_8c1a12974bd11f01( #"hash_72caf11be8f33d3f", #"hash_5212ed7ec42f115a" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x890d7eff, Offset: 0x792f
// Size: 0x8b
function private function_5bb75c348b67d2d9()
{
    zombie_type = function_b3988325430ce242( "zombie_base" );
    zone_spawners = zone_spawner::function_20c574a6ba7cc5c6( "zone_orrery_close_to_mainhall", zombie_type );
    zmb_spawner = utility::array_random( zone_spawners );
    round_number = zm_round_logic::get_rb_round_number();
    waitframe();
    spawn_count = function_549be6116eaf9f5c();
    
    for ( i = 0; i < spawn_count ; i++ )
    {
        level function_913540204bbab4ed( zombie_type, zmb_spawner, round_number );
        wait 0.75;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 3, eflags: 0x4
// Checksum 0x5af14661, Offset: 0x79c2
// Size: 0x1c1
function private function_913540204bbab4ed( zombie_type, spawner, n_difficulty_round )
{
    zombie = agent_manager::spawn_agent( zombie_type, spawner.origin, spawner.angles, "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        zombie.no_powerups = 1;
        zombie zombie_utils::set_zombie_round_difficulty( n_difficulty_round );
        zombie.b_cleanup_no_respawn = 1;
        zombie.var_825b17c932865df = 1;
        zombie.var_15598d8e493afe88 = 1;
        zombie.ignore_enemy_count = 1;
        zombie.b_disable_annihilate = 1;
        zombie.var_5a9c952260ab1cf = 1;
        zombie.var_f7fb30c6fe83c8e3 = 1;
        zombie.kiastring = #"zombie_kia_mission_kill";
        zombie thread agent_spawner::function_ce10e453e7f7bb8e( spawner );
        zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint", "default", 6 );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x1a4e0edf, Offset: 0x7b8b
// Size: 0x50
function private function_549be6116eaf9f5c()
{
    switch ( level.players.size )
    {
        case 1:
            return 10;
        case 2:
            return 15;
        case 3:
            return 20;
        case 4:
            return 25;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x625d645d, Offset: 0x7be3
// Size: 0x98
function private teleport_galileo()
{
    s_galileo = utility::getstruct( "step2_oscar_teleport", "targetname" );
    
    if ( isalive( level.ruby_mq.galileo ) )
    {
        level.ruby_mq.galileo zombie_galileo::function_84919f8f8db67077( s_galileo.origin );
        return;
    }
    
    galileo = zm_sat_ruby_galileo::respawn_galileo();
    wait 1;
    level.ruby_mq.galileo zombie_galileo::function_84919f8f8db67077( s_galileo.origin );
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x7d2d6849, Offset: 0x7c83
    // Size: 0x5, Type: dev
    function private function_a8117ceec47bbba5()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x9730f5a0, Offset: 0x7c90
// Size: 0x35
function setup_step_3( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_saw_picked" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xabd0d1c4, Offset: 0x7ccd
// Size: 0x49
function function_61e5b148e99aeeab( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        zm_quest::function_b57dfe9625966b0b( #"ruby_mq_misc", 0, #"saw", 1 );
        level utility::flag_set( "ruby_mq_saw_picked" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x53229ea7, Offset: 0x7d1e
// Size: 0x6b
function private function_6855a6c2563b91bb()
{
    level.ruby_mq endon( #"game_ended" );
    var_d6fde0495440204d = utility::getstruct( "step2_bonesaw", "targetname" );
    level.ruby_mq.mdl_bonesaw = utility::spawn_model( %"c_t10_gear_uk_bone_saw_01", var_d6fde0495440204d.origin, var_d6fde0495440204d.angles );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xfe1cb467, Offset: 0x7d91
// Size: 0x5a
function private set_bonesaw_interact()
{
    var_d6fde0495440204d = utility::getstruct( "step2_bonesaw", "targetname" );
    bonesaw_interact = interaction::register_interact( var_d6fde0495440204d.origin, 80, &bonesaw_interact );
    bonesaw_interact sethintonobstruction( "show" );
    bonesaw_interact interaction::set_interact_hint_callback( &bonesaw_interact_hint );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0xc
// Checksum 0xa8e1fe13, Offset: 0x7df3
// Size: 0xf7
function private function_c86be96257788044()
{
    self notify( #"hash_1f1f2b97c96c6072" );
    self endon( #"hash_1f1f2b97c96c6072" );
    
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    bonesaw_trigger = getent( "step2_bonesaw_damage", #targetname );
    a_glasses = getglassarray( "mq_bonesaw_damage_check" );
    
    while ( true )
    {
        if ( isdefined( a_glasses ) )
        {
            foreach ( glass in a_glasses )
            {
                if ( isglassdestroyed( glass ) )
                {
                    level set_bonesaw_interact();
                    return;
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x4059a8f2, Offset: 0x7ef2
// Size: 0xaa
function private bonesaw_interact( player )
{
    if ( isdefined( level.ruby_mq.mdl_bonesaw ) )
    {
        zm_quest::function_b57dfe9625966b0b( #"ruby_mq_misc", 0, #"saw", 1 );
        zm_quest::show_splash_item_picked_up( #"ruby_mq_misc", #"saw", 1, player );
        player playsoundtoplayer( "uin_zm_common_pickup_item_mechanical", player );
        player thread zm_vo::function_8c1a12974bd11f01( #"hash_60c0c921405fbbf0", #"bc_flavor_player_positive" );
        level.ruby_mq.mdl_bonesaw delete();
        level utility::flag_set( "ruby_mq_saw_picked" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xa243eeca, Offset: 0x7fa4
// Size: 0xa1
function private bonesaw_interact_hint( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled && isdefined( level.ruby_mq.mdl_bonesaw ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/pick_up", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x2c8eda19, Offset: 0x804d
    // Size: 0x5, Type: dev
    function private function_26e05def32bddb81()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xd544ce7d, Offset: 0x805a
// Size: 0x4a
function function_7edad63abae50975( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "ruby_mq_saw_picked" );
    level setup_surgery_interact();
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_brain_picked" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x1a69eca1, Offset: 0x80ac
// Size: 0x81
function function_61e5b648e99af9aa( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        zm_quest::function_b57dfe9625966b0b( #"hash_4484054831f14f3e", 0, #"brain", 1 );
        level utility::flag_set( "ruby_mq_brain_picked" );
        waitframe();
        level thread function_16efe14abcfdb7b2();
        
        if ( isdefined( level.ruby_mq.surgeryinteract ) )
        {
            level.ruby_mq.surgeryinteract delete();
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xacc83b0b, Offset: 0x8135
// Size: 0x86
function private setup_surgery_interact()
{
    var_9df06e29265cac5 = utility::getstruct( "voss_interact", "targetname" );
    level.ruby_mq.surgeryinteract = interaction::register_interact( var_9df06e29265cac5.origin, 58, &on_surgery );
    level.ruby_mq.surgeryinteract sethintonobstruction( "show" );
    level.ruby_mq.surgeryinteract interaction::set_interact_hint_callback( &surgery_interact_hint );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x809ce3e8, Offset: 0x81c3
// Size: 0x12f
function private on_surgery( player )
{
    if ( level utility::flag( "mq_surgery_interact" ) )
    {
        return;
    }
    
    level utility::flag_set( "mq_surgery_interact" );
    params = { #hud_description:&"zm_sat_ruby/mq_operating", #use_object:player, #hold_time:4.15, #craft_reason:#"ruby_mq" };
    result = player function_f52bebc90e098e11( params );
    
    if ( result )
    {
        wait 2.75;
        
        /#
            iprintlnbold( "<dev string:x4a>" );
        #/
        
        zm_quest::function_b57dfe9625966b0b( #"hash_4484054831f14f3e", 0, #"brain", 1 );
        zm_quest::show_splash_item_picked_up( #"hash_4484054831f14f3e", #"brain", 1, player );
        level utility::flag_set( "ruby_mq_brain_picked" );
        player thread zm_vo::function_8c1a12974bd11f01( #"hash_be2d89c13fc4d53b", #"bc_flavor_player_positive" );
        level thread function_16efe14abcfdb7b2();
        level.ruby_mq.surgeryinteract delete();
        return;
    }
    
    level utility::flag_clear( "mq_surgery_interact" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xa43c6bd7, Offset: 0x82fa
// Size: 0x47
function private function_16efe14abcfdb7b2()
{
    mdl_cryo_chamber = getent( "step2_cryo_chamber", #targetname );
    stopfxontag( utility::getfx( "ruby_mq_cryo_idle_cushion" ), mdl_cryo_chamber, "tag_cushion" );
    mdl_cryo_chamber scene::play( undefined, undefined, "sat_zm_scene_cryochamber_end" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x7811406d, Offset: 0x8349
// Size: 0x95
function private surgery_interact_hint( interact, player )
{
    if ( isdefined( player ) && isdefined( interact ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mq_operate", #type:"HINT_BUTTON" };
        }
        
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x807991ed, Offset: 0x83e6
// Size: 0x131, Type: bool
function private function_f52bebc90e098e11( params )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    s_scene = utility::getstruct( "step2_cryochamber_anim", "targetname" );
    thread function_eb3a5a6c3f4f3ba6( params, s_scene );
    zm_interaction::function_307c21197e0798d4( params.hud_description );
    result = zm_interaction::function_df340931f1a0fe6e( params.hold_time, params.use_object, params.radius, params.save_progress, params.saved_use_object );
    
    if ( isdefined( self.var_a0de55e36be21b7a ) )
    {
        zm_interaction::function_7c7ed762cd4d0333();
    }
    
    if ( result )
    {
        self setscriptablepartstate( "sndCrafting", "success", 0 );
        assert( isdefined( params.craft_reason ) );
    }
    else if ( result == 0 )
    {
        self setscriptablepartstate( "sndCrafting", "fail", 0 );
        thread function_b94186b3fb991490( params, s_scene );
    }
    else
    {
        self setscriptablepartstate( "sndCrafting", "fail", 0 );
        assert( isdefined( params.craft_reason ) );
    }
    
    return istrue( result );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x8e4f02b7, Offset: 0x8520
// Size: 0x33
function private function_eb3a5a6c3f4f3ba6( params, s_scene )
{
    assert( isdefined( params.craft_reason ) );
    s_scene scene::play( self );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x24b27e84, Offset: 0x855b
// Size: 0x32
function private function_b94186b3fb991490( params, s_scene )
{
    assert( isdefined( params.craft_reason ) );
    s_scene scene::stop();
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xcecf4784, Offset: 0x8595
// Size: 0x6b
function private setup_player_crafting( reason, allow_movement )
{
    val::set( reason, "allow_movement", istrue( allow_movement ) );
    val::set( reason, "killstreaks", 0 );
    val::set( reason, "melee", 0 );
    val::set( reason, "armor", 0 );
    val::set( reason, "usability", 0 );
    disable_specific_player_bgb( 1 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x33e2e04d, Offset: 0x8608
// Size: 0x27
function private release_player_crafting( reason )
{
    self.is_crafting = 0;
    val::reset_all( reason );
    disable_specific_player_bgb( 0 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xd5a49cff, Offset: 0x8637
// Size: 0x32
function private disable_specific_player_bgb( var_94d1ab5da995e573 )
{
    if ( var_94d1ab5da995e573 )
    {
        val::set( "disable_specific_player_bgb", "allow_scripted_bgb_use", 0 );
        return;
    }
    
    val::reset_all( "disable_specific_player_bgb" );
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x56a84f4, Offset: 0x8671
    // Size: 0x5, Type: dev
    function private function_46665dc33c8919a4()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xb103e865, Offset: 0x867e
// Size: 0x42
function function_7edad53abae50742( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "ruby_mq_brain_picked" );
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_s2_defend_success" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xa87f99c, Offset: 0x86c8
// Size: 0x150
function function_61e5b748e99afbdd( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "ruby_mq_s2_defend_success" );
        level utility::flag_set( "ruby_mq_brain_machine" );
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "idle", "on" );
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "monkey", "off" );
        
        if ( isdefined( level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain ) )
        {
            level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain delete();
        }
        
        var_1b06acd3f8bad6e1 = utility::getstruct( "step2_brain_inside_machine", "targetname" );
        level.ruby_mq.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", var_1b06acd3f8bad6e1.origin, var_1b06acd3f8bad6e1.angles );
        level.ruby_mq.mdl_brain linkto( level.ruby_mq.var_3f0220d6402db113, "tag_origin" );
    }
    
    level thread zm_quest::update_round_cap( 14 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x3e85882f, Offset: 0x8820
// Size: 0x442
function private spawn_perfusion_machine( override_spawn_pos )
{
    level.ruby_mq.var_62f90f25442a3708 = utility::getstruct( "step2_brain_machine", "targetname" );
    
    if ( isdefined( override_spawn_pos ) )
    {
        spawn_pos = override_spawn_pos;
        spawn_angles = ( 0, 0, 0 );
    }
    else
    {
        spawn_pos = level.ruby_mq.var_62f90f25442a3708.origin;
        spawn_angles = level.ruby_mq.var_62f90f25442a3708.angles;
    }
    
    level.ruby_mq.var_3f0220d6402db113 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", spawn_pos, spawn_angles );
    level.ruby_mq.var_3f0220d6402db113 solid();
    level.ruby_mq.var_3f0220d6402db113.hit = 0;
    level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "idle", "off" );
    
    if ( !isdefined( level.ruby_mq.var_bf091468cdda7a99 ) )
    {
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "monkey", "on" );
    }
    else if ( level.ruby_mq.var_bf091468cdda7a99 == 1 )
    {
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "idle", "on" );
        var_1b06acd3f8bad6e1 = utility::getstruct( "step2_brain_inside_machine", "targetname" );
        level.ruby_mq.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", var_1b06acd3f8bad6e1.origin, var_1b06acd3f8bad6e1.angles );
        level.ruby_mq.mdl_brain linkto( level.ruby_mq.var_3f0220d6402db113, "tag_origin" );
        level.ruby_mq.var_bf091468cdda7a99 = undefined;
    }
    
    if ( !level utility::flag( "ruby_mq_brain_machine" ) )
    {
        level thread spawn_monkey_brain( 1 );
    }
    
    level utility::flag_wait( "ruby_papq_complete" );
    
    if ( !isdefined( level.ruby_mq.var_5d0364d2c8899e4a ) )
    {
        level.ruby_mq.var_5d0364d2c8899e4a = interaction::register_interact( spawn_pos, 100, &perfusion_machine_interact );
        level.ruby_mq.var_5d0364d2c8899e4a sethintonobstruction( "show" );
        level.ruby_mq.var_5d0364d2c8899e4a interaction::set_interact_hint_callback( &perfusion_machine_interact_hint );
    }
    
    if ( isdefined( override_spawn_pos ) )
    {
        level.ruby_mq.var_3f0220d6402db113.drop_interact = interaction::register_interact( spawn_pos, 100, &function_7b27c9f3421f5d10 );
        level.ruby_mq.var_3f0220d6402db113.drop_interact sethintonobstruction( "show" );
        level.ruby_mq.var_3f0220d6402db113.drop_interact interaction::set_interact_hint_callback( &perfusion_machine_interact_hint );
        spawn_pos = level.ruby_mq.var_3f0220d6402db113 gettagorigin( "tag_container_brain" );
        spawn_angles = level.ruby_mq.var_3f0220d6402db113 gettagangles( "tag_container_brain" ) + ( 0, 90, 0 );
        level.ruby_mq.var_3f0220d6402db113.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", spawn_pos, spawn_angles );
        level.ruby_mq.var_3f0220d6402db113.mdl_brain linkto( level.ruby_mq.var_3f0220d6402db113, "tag_container_brain" );
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "monkey", "off" );
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "idle", "on" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x2e0a44a2, Offset: 0x8c6a
// Size: 0x268
function private spawn_monkey_brain( b_drop )
{
    level endon( #"game_ended" );
    level endon( #"hash_a968fb6fb6633f28" );
    s_monkey = utility::getstruct( "step2_monkey_brain", "targetname" );
    
    if ( b_drop )
    {
        spawn_pos = level.ruby_mq.var_3f0220d6402db113.origin + s_monkey.origin - level.ruby_mq.var_62f90f25442a3708.origin;
        spawn_angles = level.ruby_mq.var_3f0220d6402db113.angles + s_monkey.angles - level.ruby_mq.var_62f90f25442a3708.angles;
    }
    else
    {
        spawn_pos = s_monkey.origin;
        spawn_angles = s_monkey.angles;
    }
    
    level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain = utility::spawn_model( %"sat_zm_monkey_brain_fxanim", spawn_pos, spawn_angles );
    level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain linkto( level.ruby_mq.var_3f0220d6402db113, "tag_origin" );
    level utility::flag_wait( "ruby_mq_brain_machine" );
    
    if ( isdefined( level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain ) )
    {
        level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain delete();
    }
    
    var_4b459039c26d3834 = utility::getstruct( "step2_monkey_brain_dropped", "targetname" );
    payload = calcscriptablepayloadgravityarc( s_monkey.origin, var_4b459039c26d3834.origin );
    scr_monkeybrain = spawnscriptable( %"sat_zm_ruby_monkey_brain", var_4b459039c26d3834.origin + ( 0, 0, 13 ), var_4b459039c26d3834.angles, undefined, payload );
    scr_monkeybrain setscriptablepartstate( "monkey_brain", "dropped" );
    level callback::callback( #"ruby_monkey_brain_dropped", { #scriptable:scr_monkeybrain } );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x3a313ebe, Offset: 0x8eda
// Size: 0x6df
function private perfusion_machine_interact( player )
{
    if ( level utility::flag( "ruby_mq_s2_defend_success" ) )
    {
        if ( level utility::flag_exist( "mq_perfusion_dropped" ) && level utility::flag( "mq_perfusion_dropped" ) )
        {
            return;
        }
        
        if ( !utility::flag( "ruby_mq_perfusion_picked" ) )
        {
            if ( isdefined( level.ruby_mq.var_3f0220d6402db113 ) )
            {
                level.ruby_mq.var_3f0220d6402db113 delete();
            }
            
            if ( isdefined( level.ruby_mq.mdl_brain ) )
            {
                level.ruby_mq.mdl_brain delete();
            }
            
            if ( isdefined( level.ruby_mq.var_3f0220d6402db113.mdl_brain ) )
            {
                level.ruby_mq.var_3f0220d6402db113.mdl_brain delete();
            }
            
            level utility::flag_set( "ruby_mq_perfusion_picked" );
            player utility::ent_flag_set( "ruby_mq_player_with_perfusion" );
            player set_perfusion_on_player();
            player thread function_97457287a16a3f9a();
            
            foreach ( intel_player in level.players )
            {
                intel_player utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_ruby_artifact_3" );
            }
            
            player playsoundtoplayer( "evt_mq_perfusion_machine_pickup", player );
            level thread function_10807eb837ffac0e();
            
            if ( !player utility::ent_flag( "ruby_mq_slower" ) )
            {
                var_e58d7a4f046100e2 = -0.25;
                player weapons::addextramovespeed( "ruby_mq", var_e58d7a4f046100e2 );
                
                if ( !player common::function_8ff835bf23198a0( "ruby_mq" ) )
                {
                    player common::function_ac4bf3256b2545e3( "ruby_mq", var_e58d7a4f046100e2 );
                }
                
                player weapons::updatemovespeedscale();
                player_vals = [ "sprint", "remote_killstreaks", "crouch", "prone" ];
                player.var_ff2e0673e13ac2ee = 1;
                player val::set_array( "carrying_perfusion_machine", player_vals, 0 );
                player utility::ent_flag_set( "ruby_mq_slower" );
            }
        }
        else if ( player utility::ent_flag( "ruby_mq_player_with_perfusion" ) )
        {
            player utility::ent_flag_clear( "ruby_mq_player_with_perfusion" );
            level utility::flag_clear( "ruby_mq_perfusion_picked" );
            player notify( #"hash_a32b32af9724c297" );
            level notify( #"hash_cecfc276d70f737" );
            player function_ea846a83d774cd42();
            level.ruby_mq.var_3f0220d6402db113 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", level.ruby_mq.var_62f90f25442a3708.origin, level.ruby_mq.var_62f90f25442a3708.angles );
            level.ruby_mq.var_3f0220d6402db113 solid();
            var_1b06acd3f8bad6e1 = utility::getstruct( "step2_brain_inside_machine", "targetname" );
            level.ruby_mq.var_3f0220d6402db113.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", var_1b06acd3f8bad6e1.origin, var_1b06acd3f8bad6e1.angles );
            level.ruby_mq.var_3f0220d6402db113.mdl_brain linkto( level.ruby_mq.var_3f0220d6402db113, "tag_container_brain" );
            level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "idle", "on" );
            player playsoundtoplayer( "evt_mq_perfusion_machine_place", player );
            
            if ( player utility::ent_flag( "ruby_mq_slower" ) )
            {
                player weapons::removeextramovespeed( "ruby_mq" );
                
                if ( player common::function_8ff835bf23198a0( "ruby_mq" ) )
                {
                    player common::function_d85a92c557ea5a52( "ruby_mq" );
                }
                
                player weapons::updatemovespeedscale();
                player.var_ff2e0673e13ac2ee = 0;
                player val::reset_all( "carrying_perfusion_machine" );
                player utility::ent_flag_clear( "ruby_mq_slower" );
            }
        }
        
        return;
    }
    
    if ( level utility::flag( "ruby_mq_brain_picked" ) & !level utility::flag( "ruby_mq_brain_machine" ) )
    {
        /#
            iprintlnbold( "<dev string:x59>" );
        #/
        
        player playsoundtoplayer( "evt_mq_place_brain_perfusion_machine", player );
        var_1b06acd3f8bad6e1 = utility::getstruct( "step2_brain_inside_machine", "targetname" );
        level.ruby_mq.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", var_1b06acd3f8bad6e1.origin, var_1b06acd3f8bad6e1.angles );
        level.ruby_mq.mdl_brain linkto( level.ruby_mq.var_3f0220d6402db113, "tag_origin" );
        player thread zm_vo::function_8c1a12974bd11f01( #"hash_91265852a1b20f61", #"bc_flavor_player_positive" );
        level utility::flag_set( "ruby_mq_brain_machine" );
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "monkey", "off" );
        function_4ef47d3c5c627fb6();
        wait 0.25;
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "transition", "on" );
        return;
    }
    
    if ( level utility::flag( "ruby_mq_reboot_triggered" ) || level utility::flag( "ruby_mq_machine_cooldown" ) )
    {
        return;
    }
    
    if ( level utility::flag( "ruby_mq_brain_machine" ) )
    {
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "transition", "off" );
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "cooldown", "off" );
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "reactivate", "off" );
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "battle", "on" );
        level thread function_a434e6d69dd21dab();
        level.ruby_mq.var_3f0220d6402db113 function_7ba1fd130e34931a();
        level utility::flag_set( "ruby_mq_reboot_triggered" );
        return;
    }
    
    if ( !level utility::flag( "ruby_mq_brain_picked" ) && !level utility::flag( "ruby_mq_brain_machine" ) && !level utility::flag( "ruby_mq_reboot_triggered" ) )
    {
        playsoundatpos( self.origin, "evt_mq_perfusion_machine_monkey_noise" );
        
        /#
            iprintlnbold( "<dev string:x66>" );
        #/
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x9f55670e, Offset: 0x95c1
// Size: 0x53
function function_10807eb837ffac0e()
{
    level endon( #"hash_a968fb6fb6633f28" );
    level endon( #"ruby_mq_perfusion_placed_orrery" );
    level endon( #"hash_cecfc276d70f737" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_4fba03b08dc772d1" ] );
        wait 25;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x2d96dff, Offset: 0x961c
// Size: 0x20d
function private function_7b27c9f3421f5d10( player )
{
    if ( !utility::flag( "ruby_mq_perfusion_picked" ) )
    {
        if ( isdefined( level.ruby_mq.var_3f0220d6402db113 ) )
        {
            level.ruby_mq.var_3f0220d6402db113 delete();
        }
        
        if ( isdefined( level.ruby_mq.mdl_brain ) )
        {
            level.ruby_mq.mdl_brain delete();
        }
        
        if ( isdefined( level.ruby_mq.var_3f0220d6402db113.mdl_brain ) )
        {
            level.ruby_mq.var_3f0220d6402db113.mdl_brain delete();
        }
        
        if ( isdefined( level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain ) )
        {
            level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain delete();
        }
        
        level utility::flag_set( "ruby_mq_perfusion_picked" );
        player utility::ent_flag_set( "ruby_mq_player_with_perfusion" );
        player set_perfusion_on_player();
        player thread function_97457287a16a3f9a();
        player playsoundtoplayer( "evt_mq_perfusion_machine_pickup", player );
        level thread function_10807eb837ffac0e();
        
        if ( !player utility::ent_flag( "ruby_mq_slower" ) )
        {
            var_e58d7a4f046100e2 = -0.25;
            player weapons::addextramovespeed( "ruby_mq", var_e58d7a4f046100e2 );
            
            if ( !player common::function_8ff835bf23198a0( "ruby_mq" ) )
            {
                player common::function_ac4bf3256b2545e3( "ruby_mq", var_e58d7a4f046100e2 );
            }
            
            player weapons::updatemovespeedscale();
            player_vals = [ "sprint", "remote_killstreaks", "crouch", "prone" ];
            player.var_ff2e0673e13ac2ee = 1;
            player val::set_array( "carrying_perfusion_machine", player_vals, 0 );
            player utility::ent_flag_set( "ruby_mq_slower" );
        }
        
        level utility::flag_clear( "mq_perfusion_dropped" );
        self delete();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xc84d1610, Offset: 0x9831
// Size: 0x56
function private function_97457287a16a3f9a()
{
    level endon( #"game_ended" );
    self endon( #"hash_a32b32af9724c297" );
    message = utility::waittill_any_return( "disconnect", "last_stand_enter" );
    level thread drop_perfusion_machine( self.last_valid_position );
    cleanup_perfusion_machine_on_player( message != "last_stand_enter" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x94227a9e, Offset: 0x988f
// Size: 0x60
function private drop_perfusion_machine( drop_position )
{
    level notify( #"hash_a968fb6fb6633f28" );
    
    if ( level utility::flag( "ruby_mq_s3_orrery_defend_success" ) )
    {
        level thread function_20d823d5aa69a9a0( drop_position );
        return;
    }
    
    level utility::flag_clear( "ruby_mq_perfusion_picked" );
    level utility::flag_set( "mq_perfusion_dropped" );
    level thread spawn_perfusion_machine( drop_position );
    level thread function_ede697b0f5be81e2();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x9557e9ed, Offset: 0x98f7
// Size: 0x8e
function private cleanup_perfusion_machine_on_player( b_disconnect )
{
    self endon( #"disconnect" );
    function_ea846a83d774cd42();
    
    if ( b_disconnect )
    {
        return;
    }
    
    utility::ent_flag_clear( "ruby_mq_player_with_perfusion" );
    
    if ( utility::ent_flag( "ruby_mq_slower" ) )
    {
        weapons::removeextramovespeed( "ruby_mq" );
        
        if ( common::function_8ff835bf23198a0( "ruby_mq" ) )
        {
            common::function_d85a92c557ea5a52( "ruby_mq" );
        }
        
        weapons::updatemovespeedscale();
        self.var_ff2e0673e13ac2ee = 0;
        val::reset_all( "carrying_perfusion_machine" );
        utility::ent_flag_clear( "ruby_mq_slower" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x33b865e3, Offset: 0x998d
// Size: 0x24
function private function_ede697b0f5be81e2()
{
    level endon( #"game_ended" );
    level endon( #"ruby_mq_perfusion_picked" );
    wait 120;
    cleanup_perfusion_machine();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x6507f2a9, Offset: 0x99b9
// Size: 0x176
function private cleanup_perfusion_machine()
{
    if ( isdefined( level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain ) )
    {
        level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain unlink();
        level.ruby_mq.var_3f0220d6402db113.mdl_monkeybrain delete();
    }
    
    if ( isdefined( level.ruby_mq.var_3f0220d6402db113 ) )
    {
        level.ruby_mq.var_3f0220d6402db113 delete();
    }
    
    if ( isdefined( level.ruby_mq.mdl_brain ) )
    {
        level.ruby_mq.mdl_brain delete();
    }
    
    if ( isdefined( level.ruby_mq.var_3f0220d6402db113.mdl_brain ) )
    {
        level.ruby_mq.var_3f0220d6402db113.mdl_brain delete();
    }
    
    if ( isdefined( level.ruby_mq.var_3f0220d6402db113.drop_interact ) )
    {
        level.ruby_mq.var_3f0220d6402db113.drop_interact delete();
    }
    
    level.ruby_mq.var_bf091468cdda7a99 = 1;
    level utility::flag_clear( "mq_perfusion_dropped" );
    level thread spawn_perfusion_machine();
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x854dc43f, Offset: 0x9b37
// Size: 0x1a6
function perfusion_machine_interact_hint( interact, player )
{
    if ( isdefined( player ) && isdefined( interact ) && zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled && level utility::flag( "ruby_mq_brain_picked" ) )
    {
        if ( !level utility::flag( "ruby_mq_brain_machine" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mq_perfusion_2", #type:"HINT_BUTTON" };
        }
        else if ( !level utility::flag( "ruby_mq_s2_defend_success" ) && !level utility::flag( "ruby_mq_machine_cooldown" ) && !level utility::flag( "ruby_mq_reboot_triggered" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mq_perfusion_1", #type:"HINT_BUTTON" };
        }
        else if ( level utility::flag( "ruby_mq_s2_defend_success" ) && !level utility::flag( "ruby_mq_perfusion_orrey_placed" ) && !level utility::flag( "ruby_mq_perfusion_picked" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/pick_up", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
        }
        
        return;
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xce5fed69, Offset: 0x9ce5
// Size: 0x11c
function private function_a434e6d69dd21dab()
{
    level endon( #"game_ended" );
    level.ruby_mq endon( #"hash_6d74da07411313bb" );
    level.ruby_mq endon( #"ruby_mq_s2_defend_success" );
    zombie_type = function_b3988325430ce242( "zombie_base" );
    level thread function_9b0f850f2de0b073();
    round_number = zm_round_logic::get_rb_round_number();
    level.ruby_mq.var_1e43d10315af6ff7 = [];
    
    while ( true )
    {
        zone_spawners = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_planetarium_hallway_02", "zone_planetarium_hallway_01", "zone_planetarium_hallway_03" ], zombie_type );
        zmb_spawner = utility::array_random( zone_spawners );
        n_spawn_count = function_9d87b3589fb38c12();
        var_3074e369eda51ebc = function_3b302af0c257bcab();
        
        for ( i = 0; i < n_spawn_count ; i++ )
        {
            level function_2d2a8c4344b3b16c( zombie_type, zmb_spawner, round_number );
            wait 0.5;
        }
        
        if ( isdefined( var_3074e369eda51ebc ) )
        {
            wait var_3074e369eda51ebc;
            continue;
        }
        
        wait 1.25;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 3, eflags: 0x4
// Checksum 0x17d6b50b, Offset: 0x9e09
// Size: 0x201
function private function_2d2a8c4344b3b16c( zombie_type, spawner, n_difficulty_round )
{
    zombie = agent_manager::spawn_agent( zombie_type, spawner.origin, spawner.angles, "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        zombie.no_powerups = 1;
        zombie zombie_utils::set_zombie_round_difficulty( n_difficulty_round );
        zombie.b_cleanup_no_respawn = 1;
        zombie.var_825b17c932865df = 1;
        zombie.var_15598d8e493afe88 = 1;
        zombie.ignore_enemy_count = 1;
        zombie.b_disable_annihilate = 1;
        zombie.var_5a9c952260ab1cf = 1;
        zombie.var_f7fb30c6fe83c8e3 = 1;
        zombie.kiastring = #"zombie_kia_mission_kill";
        zombie val::set( "holdout_enemy", "ignore_cleanup", 1 );
        zombie thread agent_spawner::function_ce10e453e7f7bb8e( spawner );
        zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint", "default", 6 );
    }
    
    level.ruby_mq.var_1e43d10315af6ff7[ level.ruby_mq.var_1e43d10315af6ff7.size ] = zombie;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x8e456b45, Offset: 0xa012
// Size: 0x5c
function private function_3b302af0c257bcab()
{
    switch ( level.players.size )
    {
        case 1:
            return 1.25;
        case 2:
            return 1.25;
        case 3:
            return 1.25;
        case 4:
            return 1.25;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x5f376087, Offset: 0xa076
// Size: 0x50
function private function_9d87b3589fb38c12()
{
    switch ( level.players.size )
    {
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            return 3;
        case 4:
            return 4;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x9e73fc38, Offset: 0xa0ce
// Size: 0xb3
function private function_9b0f850f2de0b073()
{
    level utility::flag_wait_any( "ruby_mq_machine_cooldown", "ruby_mq_s2_defend_success" );
    
    foreach ( zombie in level.ruby_mq.var_1e43d10315af6ff7 )
    {
        if ( isalive( zombie ) )
        {
            zombie thread function_5bbd540197e3fd();
        }
    }
    
    level.ruby_mq.var_1e43d10315af6ff7 = undefined;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x546fa1dd, Offset: 0xa189
// Size: 0x1e9
function private function_7ba1fd130e34931a()
{
    level.ruby_mq.var_52f0cf341b599d3d = level.ruby_mq.var_3f0220d6402db113;
    level.ruby_mq.var_52f0cf341b599d3d setcandamage( 1 );
    level.ruby_mq.var_52f0cf341b599d3d.health = 10000;
    level.ruby_mq.var_52f0cf341b599d3d.progress = 50;
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"ruby_defend" );
    level.ruby_mq.var_52f0cf341b599d3d thread perfusion_machine_dmg_watcher();
    level.ruby_mq.var_52f0cf341b599d3d.attractor = zombie_attractor_manager::add_attractor( level.ruby_mq.var_52f0cf341b599d3d, 1, 800, 1, undefined, &defend_validator );
    level.ruby_mq.var_52f0cf341b599d3d.attractor.attractors_slots = [];
    level.ruby_mq.var_52f0cf341b599d3d.attractor.attractors_slots = utility::getstructarray( "step2_attractor_struct", "targetname" );
    zombie_attractor_manager::set_attractor_slots( level.ruby_mq.var_52f0cf341b599d3d.attractor, level.ruby_mq.var_52f0cf341b599d3d.attractor.attractors_slots );
    zombie_attractor_manager::function_4c34b0f066a9d9fe( level.ruby_mq.var_52f0cf341b599d3d.attractor, 360 );
    level.ruby_mq.var_52f0cf341b599d3d thread defend_timer_watcher();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0xc
// Checksum 0x72214f2c, Offset: 0xa37a
// Size: 0x37d
function private perfusion_machine_dmg_watcher()
{
    self notify( #"hash_7b614754895fe6fb" );
    self endon( #"hash_7b614754895fe6fb" );
    level.ruby_mq endon( #"game_ended" );
    level.ruby_mq endon( #"hash_6d74da07411313bb" );
    self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
    
    if ( !isplayer( eattacker ) )
    {
        var_e31a308c85034efa = utility::getstructarray( "step2_attractor_vfx", "targetname" );
        playsoundatpos( origin, "dst_mq_perfusion_machine_impact_zombie" );
        
        foreach ( slot in level.ruby_mq.var_52f0cf341b599d3d.attractor.attractors_slots )
        {
            if ( eattacker == slot.var_80be1da0fa595ce1 && slot.script_noteworthy )
            {
                foreach ( var_4e150d63f7211cdc in var_e31a308c85034efa )
                {
                    if ( slot.script_noteworthy == var_4e150d63f7211cdc.script_noteworthy )
                    {
                        playfx( utility::getfx( "ruby_mq_defense_impact" ), var_4e150d63f7211cdc.origin );
                    }
                }
            }
        }
        
        if ( isdefined( level.ruby_mq.var_3f0220d6402db113.hit ) )
        {
            level.ruby_mq.var_3f0220d6402db113.hit += 3;
        }
        
        self.progress = 50 - level.ruby_mq.var_3f0220d6402db113.hit;
        
        if ( self.progress <= 0 )
        {
            self.progress = 0;
            zm_quest::function_9f49b2a045ece8ae( self.progress, 1, #"ruby_mq", #"reanimate_brain" );
        }
        else
        {
            zm_quest::function_9f49b2a045ece8ae( self.progress, 1, #"ruby_mq", #"reanimate_brain" );
        }
        
        if ( self.progress <= 0 )
        {
            thread utility::stop_loop_sound_on_entity( "evt_mq_perfusion_machine_activate_lp" );
            level thread defend_failed();
            level.ruby_mq notify( #"hash_6d74da07411313bb" );
        }
    }
    
    thread perfusion_machine_dmg_watcher();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xc1dbd20, Offset: 0xa6ff
// Size: 0x19e
function private defend_timer_watcher()
{
    level endon( #"game_ended" );
    level.ruby_mq endon( #"hash_6d74da07411313bb" );
    var_4e8147706c9c5031 = 65000;
    zm_quest::function_fba942a1cfd85f5d( 1, 1, #"ruby_mq", #"reanimate_brain" );
    zm_quest::function_fb3af5600f6a9441( 1, 1, #"ruby_mq", #"reanimate_brain" );
    zm_quest::function_9f49b2a045ece8ae( 50, 1, #"ruby_mq", #"reanimate_brain" );
    playsoundatpos( self.origin, "evt_mq_perfusion_machine_activate" );
    thread utility::play_loop_sound_on_entity( "evt_mq_perfusion_machine_activate_lp" );
    n_time_start_ms = gettime();
    
    while ( true )
    {
        n_time_taken = gettime() - n_time_start_ms;
        n_time_left = var_4e8147706c9c5031 - n_time_taken;
        zm_quest::function_612a9ad0db22c29c( n_time_left, 1, #"ruby_mq", #"reanimate_brain" );
        
        if ( n_time_left <= 0 )
        {
            if ( self.progress >= 0 )
            {
                level utility::flag_set( "ruby_mq_s2_defend_success" );
                level thread defend_success();
                playsoundatpos( self.origin, "evt_mq_perfusion_machine_deactivate" );
                thread utility::stop_loop_sound_on_entity( "evt_mq_perfusion_machine_activate_lp" );
                level.ruby_mq notify( #"ruby_mq_s2_defend_success" );
                return;
            }
            
            playsoundatpos( self.origin, "evt_mq_perfusion_machine_deactivate" );
            thread utility::stop_loop_sound_on_entity( "evt_mq_perfusion_machine_activate_lp" );
            level thread defend_failed();
            self.progress = 0;
            level.ruby_mq notify( #"hash_6d74da07411313bb" );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xfb8ca015, Offset: 0xa8a5
// Size: 0xd7
function private function_e27bc0c71d742ae8()
{
    level endon( #"game_ended" );
    wait 2.75;
    chance = randomintrange( 1, 3 );
    
    if ( chance == 1 )
    {
        level zm_quest::function_d5ef98341fd6a057( [ #"hash_920eeec3865f537f" ] );
    }
    else
    {
        level zm_quest::function_d5ef98341fd6a057( [ #"hash_74215c35b2399856" ] );
    }
    
    zm_quest::function_8934bb2a9028bdc5();
    wait 0.4;
    var_1b45146ab4e364bc = utility::getstruct( "step2_brain_machine", "targetname" );
    a_players = getplayersinradius( var_1b45146ab4e364bc.origin, 800 );
    
    if ( a_players.size > 0 )
    {
        player = utility::array_random( a_players );
        player thread zm_vo::function_8c1a12974bd11f01( #"hash_5bc188f33d800bd6", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xecbade88, Offset: 0xa984
// Size: 0x1b
function private function_e975922ff88b4e9c()
{
    wait 2;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_15a7edc6b64c840f" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x1fd52021, Offset: 0xa9a7
// Size: 0x13a
function private defend_failed()
{
    wait 0.5;
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"ruby_defend" );
    level thread function_e975922ff88b4e9c();
    level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "battle", "off" );
    level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "cooldown", "on" );
    level zm_quest::function_fb3af5600f6a9441( 3, 1, #"ruby_mq", #"reanimate_brain" );
    level thread remove_attractor();
    level.ruby_mq.var_52f0cf341b599d3d = undefined;
    
    if ( isdefined( level.ruby_mq.var_3f0220d6402db113.hit ) )
    {
        level.ruby_mq.var_3f0220d6402db113.hit = 0;
    }
    
    level utility::flag_clear( "ruby_mq_reboot_triggered" );
    level utility::flag_set( "ruby_mq_machine_cooldown" );
    level.ruby_mq.var_201d925df4519b59 = zm_round_logic::get_rb_round_number() + 1;
    level callback::add( "on_round_start", &function_c4426cb9d6a92724 );
    wait 2;
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x2671e3c8, Offset: 0xaae9
// Size: 0x18f
function private defend_success()
{
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"ruby_defend" );
    level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "transition", "off" );
    level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "cooldown", "off" );
    level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "reactivate", "off" );
    level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "battle", "off" );
    level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "stable", "on" );
    level zm_quest::function_fb3af5600f6a9441( 4, 1, #"ruby_mq", #"reanimate_brain" );
    level thread remove_attractor();
    level thread function_e27bc0c71d742ae8();
    
    foreach ( player in level.players )
    {
        player thread function_c473ef2ca3032767( 0.5, 1 );
    }
    
    level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 1, 1, 1, undefined, 1, undefined, 1 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x245ddec0, Offset: 0xac80
// Size: 0xc2
function private function_c4426cb9d6a92724( params )
{
    if ( isdefined( level.ruby_mq.var_3f0220d6402db113 ) )
    {
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "transition", "off" );
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "cooldown", "off" );
        level.ruby_mq.var_3f0220d6402db113 setscriptablepartstate( "reactivate", "on" );
    }
    
    level callback::remove( "on_round_start", &function_c4426cb9d6a92724 );
    level.ruby_mq.var_201d925df4519b59 = undefined;
    level utility::flag_clear( "ruby_mq_machine_cooldown" );
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x8b6218ce, Offset: 0xad4a
// Size: 0x26
function private remove_attractor()
{
    zombie_attractor_manager::remove_attractor( level.ruby_mq.var_52f0cf341b599d3d.attractor );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xec76cb49, Offset: 0xad78
// Size: 0x86, Type: bool
function private defend_validator( attractor, zombie )
{
    if ( !isalive( zombie ) || !isdefined( attractor ) )
    {
        return false;
    }
    
    if ( zombie.basearchetype == "zombie_galileo" )
    {
        return false;
    }
    
    if ( zombie.basearchetype == "zombie_vermin" || zombie.basearchetype == "zombie_parasite" )
    {
        return false;
    }
    
    if ( zombie.team != level.var_ece703e3d116381c )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x5d542824, Offset: 0xae07
    // Size: 0x5, Type: dev
    function private function_d3b8fe0d5fc7058c()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x51f69fa3, Offset: 0xae14
// Size: 0x4a
function function_7edad43abae5050f( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level thread function_16beff906a0b5dba();
        return;
    }
    
    level utility::flag_wait( "ruby_mq_s2_defend_success" );
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_s3_portal_initiated" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xb43bdc57, Offset: 0xae66
// Size: 0x2e1
function cleanup_step_6( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "ruby_mq_s3_portal_initiated" );
        level.ruby_mq.var_54f3c94c69fc1696 = utility::getstruct( "step3_perfusion_orrery_interact", "targetname" );
        level.ruby_mq.var_2f58b2bc7556d331 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", level.ruby_mq.var_54f3c94c69fc1696.origin, level.ruby_mq.var_54f3c94c69fc1696.angles );
        level.ruby_mq.var_2f58b2bc7556d331 solid();
        level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "machine_states", "initiated" );
        level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "initialize", "on" );
        level.ruby_mq.var_2f58b2bc7556d331.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", level.ruby_mq.var_2f58b2bc7556d331.origin + ( 0, 0, 11 ), level.ruby_mq.var_2f58b2bc7556d331.angles + ( 0, 90, 0 ) );
        level.ruby_mq.var_2f58b2bc7556d331.mdl_brain linkto( level.ruby_mq.var_2f58b2bc7556d331, "tag_container_brain" );
        level.ruby_mq.var_2f58b2bc7556d331 setscriptablepartstate( "idle", "on" );
        
        if ( isdefined( level.ruby_mq.var_31ab07dce74045f5 ) )
        {
            level.ruby_mq.var_31ab07dce74045f5 delete();
        }
        
        var_90ce8e39ebce35ee = utility::getstruct( "step3_perfusion_connect_on", "targetname" );
        var_1ffc36adaa2633fc = utility::spawn_model( "sat_zm_perfusion_machine_wire_01", var_90ce8e39ebce35ee.origin, var_90ce8e39ebce35ee.angles );
        level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "anim", "on" );
        
        if ( isdefined( level.ruby_mq.var_3f0220d6402db113 ) )
        {
            level.ruby_mq.var_3f0220d6402db113 delete();
        }
        
        if ( isdefined( level.ruby_mq.mdl_brain ) )
        {
            level.ruby_mq.mdl_brain delete();
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x789e4c28, Offset: 0xb14f
// Size: 0xaa
function private setup_perfusion_machine_orrey()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "ruby_mq_perfusion_picked" );
    level.ruby_mq.var_54f3c94c69fc1696 = utility::getstruct( "step3_perfusion_orrery_interact", "targetname" );
    var_1a3f0ccb0ab8659b = interaction::register_interact( level.ruby_mq.var_54f3c94c69fc1696.origin, 100, &function_302bc927d30cc285 );
    var_1a3f0ccb0ab8659b sethintonobstruction( "show" );
    var_1a3f0ccb0ab8659b interaction::set_interact_hint_callback( &function_fe98c5597b7e1acc );
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_s3_portal_initiated" );
    var_1a3f0ccb0ab8659b delete();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xdec6f4f7, Offset: 0xb201
// Size: 0x457
function private function_302bc927d30cc285( player )
{
    if ( utility::flag( "ruby_mq_perfusion_picked" ) && player utility::ent_flag( "ruby_mq_player_with_perfusion" ) )
    {
        player utility::ent_flag_clear( "ruby_mq_player_with_perfusion" );
        player playsoundtoplayer( "evt_mq_perfusion_machine_place", player );
        
        /#
            iprintlnbold( "<dev string:x73>" );
        #/
        
        player function_ea846a83d774cd42();
        level.ruby_mq.var_2f58b2bc7556d331 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", level.ruby_mq.var_54f3c94c69fc1696.origin, level.ruby_mq.var_54f3c94c69fc1696.angles );
        level.ruby_mq.var_2f58b2bc7556d331 solid();
        level.ruby_mq.var_2f58b2bc7556d331.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", level.ruby_mq.var_2f58b2bc7556d331.origin + ( 0, 0, 11 ), level.ruby_mq.var_2f58b2bc7556d331.angles + ( 0, 90, 0 ) );
        level.ruby_mq.var_2f58b2bc7556d331.mdl_brain linkto( level.ruby_mq.var_2f58b2bc7556d331 );
        level.ruby_mq.var_2f58b2bc7556d331 setscriptablepartstate( "idle", "on" );
        
        if ( player utility::ent_flag( "ruby_mq_slower" ) )
        {
            player weapons::removeextramovespeed( "ruby_mq" );
            
            if ( player common::function_8ff835bf23198a0( "ruby_mq" ) )
            {
                player common::function_d85a92c557ea5a52( "ruby_mq" );
            }
            
            player weapons::updatemovespeedscale();
            player.var_ff2e0673e13ac2ee = 0;
            player val::reset_all( "carrying_perfusion_machine" );
            player utility::ent_flag_clear( "ruby_mq_slower" );
        }
        
        if ( isdefined( level.ruby_mq.var_5d0364d2c8899e4a ) )
        {
            level.ruby_mq.var_5d0364d2c8899e4a delete();
        }
        
        level notify( #"ruby_mq_perfusion_placed_orrery" );
        player notify( #"hash_a32b32af9724c297" );
        waitframe();
        level utility::flag_set( "ruby_mq_perfusion_orrey_placed" );
    }
    else if ( utility::flag( "ruby_mq_perfusion_orrey_placed" ) )
    {
        if ( level utility::flag( "mq_orrery_connect_interact" ) )
        {
            return;
        }
        
        level utility::flag_set( "mq_orrery_connect_interact" );
        params = { #hud_description:&"zm_sat_ruby/mq_connect_perfusion", #use_object:self, #hold_time:3, #craft_reason:#"ruby_mq" };
        result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
        
        if ( result )
        {
            level.ruby_mq.var_31ab07dce74045f5 delete();
            var_90ce8e39ebce35ee = utility::getstruct( "step3_perfusion_connect_on", "targetname" );
            var_1ffc36adaa2633fc = utility::spawn_model( "sat_zm_perfusion_machine_wire_01", var_90ce8e39ebce35ee.origin, var_90ce8e39ebce35ee.angles );
            
            /#
                iprintlnbold( "<dev string:x8f>" );
            #/
            
            earthquake( 0.4, 4, level.ruby_mq.var_54f3c94c69fc1696.origin, 600 );
            playrumbleonposition( "artillery_rumble_light", level.ruby_mq.var_54f3c94c69fc1696.origin );
            level thread function_2c9d148aeb5ddb97( player );
            level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "initialize", "on" );
            level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "machine_states", "initiated" );
            level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "anim", "on" );
            level thread function_16beff906a0b5dba();
            level utility::flag_set( "ruby_mq_s3_portal_initiated" );
        }
        else
        {
            level utility::flag_clear( "mq_orrery_connect_interact" );
        }
    }
    
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x87859a5a, Offset: 0xb660
// Size: 0x126
function private function_fe98c5597b7e1acc( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        if ( utility::flag( "ruby_mq_perfusion_picked" ) && player utility::ent_flag( "ruby_mq_player_with_perfusion" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mq_perfusion_place", #type:"HINT_BUTTON" };
        }
        else if ( level utility::flag( "ruby_mq_perfusion_orrey_placed" ) && !level utility::flag( "mq_orrery_connect_interact" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mar_perfusion_gen", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xad9123e7, Offset: 0xb78e
// Size: 0x88
function private function_2c9d148aeb5ddb97( player )
{
    level endon( #"game_ended" );
    wait 1.7;
    var_db75d3de862ce072 = player_banter::play_banter_vo( #"hash_7a78e7064f7d016c" );
    
    if ( var_db75d3de862ce072 == 1 )
    {
    }
    else if ( isdefined( player ) )
    {
        player thread zm_vo::function_8c1a12974bd11f01( #"hash_7a78e7064f7d016c", #"bc_flavor_player_positive" );
    }
    
    zm_quest::function_8934bb2a9028bdc5();
    wait 0.5;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_6fd3a11daa4c3ac0" ] );
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x47aa8a9, Offset: 0xb81e
    // Size: 0x5, Type: dev
    function private function_78696992017e00fc()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x6ba04579, Offset: 0xb82b
// Size: 0x2e
function function_7edad33abae502dc( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "ruby_mq_s3_portal_initiated" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x54690e8b, Offset: 0xb861
// Size: 0xd2
function cleanup_step_7( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"mars_coord" ) ) && zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"mars_coord" ) == 1 )
        {
            level utility::flag_set( "ruby_mq_s3_mars_coord_entered" );
            level.ruby_mq.coord_machine = getent( "step3_coord_machine", #targetname );
            level.ruby_mq.coord_machine setscriptablepartstate( "anim", "open" );
            level.ruby_mq.coord_machine setscriptablepartstate( "state", "ready" );
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xda627af1, Offset: 0xb93b
// Size: 0x151
function private function_5d1a6be1bc01f78e()
{
    level endon( #"game_ended" );
    level.ruby_mq.coord_machine = getent( "step3_coord_machine", #targetname );
    level.ruby_mq.coord_machine setscriptablepartstate( "anim", "close" );
    
    while ( !isdefined( level.ruby_mq.mars_coordinates ) )
    {
        waitframe();
    }
    
    level utility::flag_wait( "ruby_mq_s3_portal_initiated" );
    
    if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"mars_coord" ) ) && zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"mars_coord" ) == 1 )
    {
        return;
    }
    
    level.ruby_mq.coord_machine setscriptablepartstate( "anim", "open" );
    level.ruby_mq.coord_machine setscriptablepartstate( "state", "active" );
    wait 2;
    level thread zm_keypad::function_c4ebca8f7435b099( "step3_coordinate_interact", level.ruby_mq.mars_coordinates, &on_keypad_success, &function_198ca1e884bbf074, &function_3848847f43766265 );
    level thread define_keypad();
    level.ruby_mq.var_7134a3b1526c7505 = 0;
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xba9329d9, Offset: 0xba94
// Size: 0x86
function private on_keypad_success( keypad )
{
    /#
        iprintlnbold( "<dev string:xa0>" );
    #/
    
    level.ruby_mq.coord_machine setscriptablepartstate( "state", "ready" );
    level utility::flag_set( "ruby_mq_s3_mars_coord_entered" );
    zm_quest::function_4eefe6de31f5ddab( #"ruby_mq", #"mars_coord", 1 );
    function_4ef47d3c5c627fb6();
    wait 0.85;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_81d15ff5a92b7eba" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x2345eb85, Offset: 0xbb22
// Size: 0xda
function private function_198ca1e884bbf074( player )
{
    /#
        iprintlnbold( "<dev string:xad>" );
    #/
    
    level.ruby_mq.var_7134a3b1526c7505++;
    
    if ( level.ruby_mq.var_7134a3b1526c7505 >= 3 )
    {
        level utility::flag_set( "ruby_mq_coord_cooldown" );
        level.ruby_mq.coord_machine setscriptablepartstate( "state", "cooldown" );
        level.ruby_mq.var_30dd31289e47e3c6 = zm_round_logic::get_rb_round_number() + 1;
        level callback::add( "on_round_start", &function_dcd4356f4d2905b8 );
        level.ruby_mq.var_d92d5c684ca0d32d.var_94d1ab5da995e573 = 1;
        
        if ( utility::flag( "ruby_mq_orrey_all_planets_set" ) )
        {
            zm_quest::function_5b5c737326035ea( 0 );
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xddce3d7f, Offset: 0xbc04
// Size: 0xda
function private function_3848847f43766265( player )
{
    /#
        iprintlnbold( "<dev string:xbc>" );
    #/
    
    level.ruby_mq.var_7134a3b1526c7505++;
    
    if ( level.ruby_mq.var_7134a3b1526c7505 >= 3 )
    {
        level utility::flag_set( "ruby_mq_coord_cooldown" );
        level.ruby_mq.coord_machine setscriptablepartstate( "state", "cooldown" );
        level.ruby_mq.var_30dd31289e47e3c6 = zm_round_logic::get_rb_round_number() + 1;
        level callback::add( "on_round_start", &function_dcd4356f4d2905b8 );
        level.ruby_mq.var_d92d5c684ca0d32d.var_94d1ab5da995e573 = 1;
        
        if ( utility::flag( "ruby_mq_orrey_all_planets_set" ) )
        {
            zm_quest::function_5b5c737326035ea( 0 );
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xe9842c0d, Offset: 0xbce6
// Size: 0x69
function private define_keypad()
{
    level endon( #"game_ended" );
    keypadloc = utility::getstruct( "step3_coordinate_interact", "targetname" );
    
    while ( !isdefined( keypadloc.keypad ) )
    {
        waitframe();
    }
    
    utility::flag_wait( "scriptables_ready" );
    level.ruby_mq.var_d92d5c684ca0d32d = keypadloc.keypad;
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x567d5bec, Offset: 0xbd57
// Size: 0xcd
function private function_dcd4356f4d2905b8( params )
{
    level callback::remove( "on_round_start", &function_dcd4356f4d2905b8 );
    level.ruby_mq.var_d92d5c684ca0d32d setscriptablepartstate( level.ruby_mq.var_d92d5c684ca0d32d function_84ad2f70189ee7c3(), "on" );
    level.ruby_mq.var_d92d5c684ca0d32d.var_94d1ab5da995e573 = undefined;
    level.ruby_mq.var_30dd31289e47e3c6 = undefined;
    level.ruby_mq.var_7134a3b1526c7505 = 0;
    level.ruby_mq.coord_machine setscriptablepartstate( "state", "active" );
    level utility::flag_clear( "ruby_mq_coord_cooldown" );
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x603bc9b, Offset: 0xbe2c
// Size: 0x162
function private spawn_mars()
{
    level endon( #"game_ended" );
    level.ruby_mq.mdl_telescope_mars = utility::spawn_model( "sat_zm_pipe_organ_regurgirator_mars" );
    waitframe();
    level.ruby_mq.mdl_telescope_mars.info = "mars";
    level utility::flag_wait( "wwq_step_1_complete" );
    
    if ( isdefined( level.ruby_mq.mdl_telescope_mars ) )
    {
        s_mars = zm_sat_ruby_telescope::function_b095db21aed570fe( level.ruby_mq.mdl_telescope_mars, 0 );
        level.ruby_mq.mdl_telescope_mars.dec = int( s_mars.declination );
        level.ruby_mq.mdl_telescope_mars.dec_min = int( s_mars.declination_min );
        level.ruby_mq.mars_coordinates = [ s_mars.declination[ 0 ], s_mars.declination[ 1 ], s_mars.declination_min[ 0 ], s_mars.declination_min[ 1 ] ];
        level callback::add( "telescope_target_acquired", &mars_spotted );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x6b96799d, Offset: 0xbf96
// Size: 0x46
function private mars_spotted( params )
{
    if ( params.ent == level.ruby_mq.mdl_telescope_mars )
    {
        /#
            iprintlnbold( "<dev string:xd1>" );
        #/
        
        level.var_dfedda3c993ff77e = 1;
    }
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0xdcf4a237, Offset: 0xbfe4
    // Size: 0x5, Type: dev
    function private function_54977df56627615c()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x7e1fb724, Offset: 0xbff1
// Size: 0x35
function function_7edada3abae51241( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_s3_portal_initiated" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x9e80979a, Offset: 0xc02e
// Size: 0x257
function cleanup_step_8( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"place_planet" ) ) && zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"place_planet" ) == 1 )
        {
            level utility::flag_set( "ruby_mq_neptune_orrey_placed" );
            zm_quest::function_b57dfe9625966b0b( #"ruby_mq_misc", 0, #"planet", 1 );
            level utility::flag_set( "ruby_mq_book_puzzle_solved" );
            level utility::flag_set( "ruby_mq_book_puzzle_complete" );
            s_neptuneplanet = utility::getstruct( "step3_orrey_neptune_orrery", "targetname" );
            level.ruby_mq.var_ca2e88320264e8c = utility::spawn_model( "sat_zm_armillary_sphere_neptune", s_neptuneplanet.origin, s_neptuneplanet.angles );
            level.ruby_mq.var_ca2e88320264e8c linkto( level.ruby_mq.var_f038e1dbd59362bb );
            level.ruby_mq.var_ca2e88320264e8c solid();
            level.ruby_mq.var_ca2e88320264e8c setcandamage( 1 );
            level.ruby_mq.var_ca2e88320264e8c.health = 999999;
            level.ruby_mq.var_ca2e88320264e8c.triggerassigned = "";
            level.ruby_mq.var_ca2e88320264e8c.triggerassigned = level.ruby_mq.var_c3b8c0b85d909338[ 2 ];
            level.ruby_mq.var_ca2e88320264e8c.planetname = "Neptune";
            level.ruby_mq.var_ca2e88320264e8c thread function_a0fc16f9aeacf0f5();
            level thread function_e45c03420d69ee9f();
            
            /#
                iprintlnbold( "<dev string:xde>" );
            #/
            
            level utility::flag_set( "ruby_mq_directed_green_bust_active" );
            level utility::flag_set( "ruby_mq_directed_red_bust_active" );
            level utility::flag_set( "ruby_mq_directed_blue_bust_active" );
            waitframe();
            
            if ( !utility::flag( "ruby_mq_s3_orrery_defend_success" ) )
            {
                level thread function_3afdc6d3ab068d49();
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x32c37b6b, Offset: 0xc28d
// Size: 0x442
function private function_b338595b35061a4a()
{
    level endon( #"game_ended" );
    level thread setup_book_puzzle();
    level.ruby_mq.var_ffee0f8ab24454d2 = 0;
    level.ruby_mq.var_83cab92a659b007f = [];
    level.ruby_mq.var_66db8b257ee8badb = [];
    level.ruby_mq.var_58f99d55462c51ce = [];
    var_28e29a1b6319d775 = utility::getstructarray( "step3_book_blue", "targetname" );
    var_42fa6767d56981fa = utility::getstructarray( "step3_book_red", "targetname" );
    var_a633b98b0aa4816a = utility::getstructarray( "step3_book_green", "targetname" );
    
    foreach ( var_e69cdf73de21fdbd in var_28e29a1b6319d775 )
    {
        var_c98d428100fb4b03 = utility::spawn_model( var_e69cdf73de21fdbd.script_noteworthy, var_e69cdf73de21fdbd.origin, var_e69cdf73de21fdbd.angles );
        var_c98d428100fb4b03.interact = zm_quest::function_91f9590e98d57ff6( var_e69cdf73de21fdbd.origin, &function_3fdec03c2e21207b, &function_2b45cbe6ae436edd, "extrasmallnohint" );
        var_c98d428100fb4b03.interact.noteid = function_74eb926b536dd582( var_e69cdf73de21fdbd );
    }
    
    foreach ( var_e69cdf73de21fdbd in var_42fa6767d56981fa )
    {
        var_c98d428100fb4b03 = utility::spawn_model( var_e69cdf73de21fdbd.script_noteworthy, var_e69cdf73de21fdbd.origin, var_e69cdf73de21fdbd.angles );
        var_c98d428100fb4b03.interact = zm_quest::function_91f9590e98d57ff6( var_e69cdf73de21fdbd.origin, &function_3fdec03c2e21207b, &function_2b45cbe6ae436edd, "extrasmallnohint" );
        var_c98d428100fb4b03.interact.noteid = function_74eb926b536dd582( var_e69cdf73de21fdbd );
    }
    
    foreach ( var_e69cdf73de21fdbd in var_a633b98b0aa4816a )
    {
        var_c98d428100fb4b03 = utility::spawn_model( var_e69cdf73de21fdbd.script_noteworthy, var_e69cdf73de21fdbd.origin, var_e69cdf73de21fdbd.angles );
        var_c98d428100fb4b03.interact = zm_quest::function_91f9590e98d57ff6( var_e69cdf73de21fdbd.origin, &function_3fdec03c2e21207b, &function_2b45cbe6ae436edd, "extrasmallnohint" );
        var_c98d428100fb4b03.interact.noteid = function_74eb926b536dd582( var_e69cdf73de21fdbd );
    }
    
    s_blue_statue = utility::getstruct( "step3_statue_blue", "targetname" );
    s_green_statue = utility::getstruct( "step3_statue_green", "targetname" );
    s_red_statue = utility::getstruct( "step3_statue_red", "targetname" );
    level.ruby_mq.var_7ada84406efe743b = utility::spawn_model( "t10_decor_statuette_05", s_blue_statue.origin, s_blue_statue.angles );
    level.ruby_mq.var_41b3fabaac6f2d46 = utility::spawn_model( "t10_decor_statuette_06", s_green_statue.origin, s_green_statue.angles );
    level.ruby_mq.var_5f3072b81b818132 = utility::spawn_model( "t10_decor_statuette_06", s_red_statue.origin, s_red_statue.angles );
    level utility::flag_wait( "ruby_mq_s3_portal_initiated" );
    level thread function_66b60d2ba3f1c8d();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x3ec97159, Offset: 0xc6d7
// Size: 0xa6
function private function_74eb926b536dd582( parent_struct )
{
    switch ( parent_struct.script_noteworthy )
    {
        case #"hash_63d7cb97b4907ca0":
            return 9;
        case #"hash_63d7d997b49092aa":
            return 11;
        case #"hash_63d7da97b490943d":
            return 10;
        case #"hash_63d7ce97b4908159":
            return 6;
        case #"hash_63d7cc97b4907e33":
            return 8;
        case #"hash_63d7cd97b4907fc6":
            return 7;
        case #"hash_63d7d097b490847f":
            return 4;
        case #"hash_63d7d197b4908612":
            return 3;
        case #"hash_63d7cf97b49082ec":
            return 5;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x723a415d, Offset: 0xc785
// Size: 0x40
function private function_2b45cbe6ae436edd( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x614c0d3e, Offset: 0xc7ce
// Size: 0x64
function private function_3fdec03c2e21207b( player )
{
    self disableplayeruse( player );
    thread function_d2ff91002c7769b2( player );
    thread function_316f23bb0b9c5a83( player );
    player setclientomnvar( "ui_immovable_note", self.noteid );
    player utility::delaycall( level.framedurationseconds, &setclientomnvar, "ui_immovable_note", 0 );
    player playsoundtoplayer( "evt_mq_pickup_document", player );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xa49c8d0f, Offset: 0xc83a
// Size: 0x3ea
function private function_66b60d2ba3f1c8d()
{
    level.ruby_mq.var_7ada84406efe743b.identity = "blue";
    level.ruby_mq.var_7ada84406efe743b.interact = interaction::register_interact( level.ruby_mq.var_7ada84406efe743b.origin, 45, &function_a8f3e73b18ef35ba );
    level.ruby_mq.var_7ada84406efe743b.interact.statue = level.ruby_mq.var_7ada84406efe743b;
    level.ruby_mq.var_7ada84406efe743b.interact.var_653f17b61476daa1 = 0;
    level.ruby_mq.var_7ada84406efe743b.interact sethintonobstruction( "show" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level.ruby_mq.var_7ada84406efe743b.interact interaction::set_interact_hint_callback( &function_110169614ac1c1da );
    }
    else
    {
        level.ruby_mq.var_7ada84406efe743b.interact interaction::set_interact_hint_callback( &statue_interact_hint );
    }
    
    level.ruby_mq.var_41b3fabaac6f2d46.identity = "green";
    level.ruby_mq.var_41b3fabaac6f2d46.interact = interaction::register_interact( level.ruby_mq.var_41b3fabaac6f2d46, 45, &function_a8f3e73b18ef35ba );
    level.ruby_mq.var_41b3fabaac6f2d46.interact.statue = level.ruby_mq.var_41b3fabaac6f2d46;
    level.ruby_mq.var_41b3fabaac6f2d46.interact.var_653f17b61476daa1 = 0;
    level.ruby_mq.var_41b3fabaac6f2d46.interact sethintonobstruction( "show" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level.ruby_mq.var_41b3fabaac6f2d46.interact interaction::set_interact_hint_callback( &function_279e49ed93914017 );
    }
    else
    {
        level.ruby_mq.var_41b3fabaac6f2d46.interact interaction::set_interact_hint_callback( &statue_interact_hint );
    }
    
    level.ruby_mq.var_5f3072b81b818132.identity = "red";
    level.ruby_mq.var_5f3072b81b818132.interact = interaction::register_interact( level.ruby_mq.var_5f3072b81b818132, 45, &function_a8f3e73b18ef35ba );
    level.ruby_mq.var_5f3072b81b818132.interact.statue = level.ruby_mq.var_5f3072b81b818132;
    level.ruby_mq.var_5f3072b81b818132.interact.var_653f17b61476daa1 = 0;
    level.ruby_mq.var_5f3072b81b818132.interact sethintonobstruction( "show" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level.ruby_mq.var_5f3072b81b818132.interact interaction::set_interact_hint_callback( &function_dc4c934ec5ecc9c7 );
        return;
    }
    
    level.ruby_mq.var_5f3072b81b818132.interact interaction::set_interact_hint_callback( &statue_interact_hint );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x5ade8c87, Offset: 0xcc2c
// Size: 0xe3
function private setup_book_puzzle()
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level.ruby_mq.var_bf36b8b778fbad39 = 2;
        level.ruby_mq.var_cda233a53fa2c3e9 = 2;
        level.ruby_mq.var_23e333dbd46bed1e = 2;
    }
    else
    {
        level.ruby_mq.var_bf36b8b778fbad39 = randomintrange( 1, 3 );
        level.ruby_mq.var_cda233a53fa2c3e9 = randomintrange( 1, 3 );
        level.ruby_mq.var_23e333dbd46bed1e = randomintrange( 1, 3 );
    }
    
    level.ruby_mq.var_1db71d790e2f4e9e = 0;
    level.ruby_mq.var_ec289a3fb6bc1ce = 0;
    level.ruby_mq.var_517e00e3f02e6641 = 0;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x88677451, Offset: 0xcd17
// Size: 0x1c0
function private book_puzzle_clue()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "ruby_mq_s3_portal_initiated" );
    green_screens = [ "green_1", "green_2", "green_3" ];
    green_screens = arrayrandomize( green_screens );
    red_screens = [ "red_1", "red_2", "red_3" ];
    red_screens = arrayrandomize( red_screens );
    blue_screens = [ "blue_1", "blue_2", "blue_3" ];
    blue_screens = arrayrandomize( blue_screens );
    
    while ( true )
    {
        level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "clue_states", "list" );
        wait 4;
        
        for ( i = 0; i < level.ruby_mq.var_bf36b8b778fbad39 ; i++ )
        {
            level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "clue_states", green_screens[ i ] );
            wait 1.75;
        }
        
        for ( i = 0; i < level.ruby_mq.var_cda233a53fa2c3e9 ; i++ )
        {
            level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "clue_states", red_screens[ i ] );
            wait 1.75;
        }
        
        for ( i = 0; i < level.ruby_mq.var_23e333dbd46bed1e ; i++ )
        {
            level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "clue_states", blue_screens[ i ] );
            wait 1.75;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xc5c32028, Offset: 0xcedf
// Size: 0x1ab
function private function_a8f3e73b18ef35ba( player )
{
    if ( level utility::flag( "ruby_mq_bookpuzzle_cooldown" ) )
    {
        return;
    }
    
    if ( self.statue utility::ent_flag( "moving" ) )
    {
        return;
    }
    
    if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"place_planet" ) ) && zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"place_planet" ) == 1 )
    {
        return;
    }
    
    if ( self.var_653f17b61476daa1 >= 2 )
    {
        return;
    }
    
    if ( level.ruby_mq.var_ffee0f8ab24454d2 == 0 )
    {
        level thread function_47ec2a5000e620ae();
        level.ruby_mq.var_ffee0f8ab24454d2 = 1;
    }
    
    if ( self.var_653f17b61476daa1 != 2 )
    {
        self.statue utility::ent_flag_set( "moving" );
        self.statue thread function_336546f418f14ee6();
        self.var_653f17b61476daa1++;
        self.statue playsoundonmovingent( "evt_mq_library_statue_rotate" );
    }
    
    level thread function_b55bf7f238a6c419( self.statue, player );
    
    if ( self.var_653f17b61476daa1 >= 2 )
    {
        if ( self.statue.identity == "green" )
        {
            level utility::flag_set( "ruby_mq_directed_green_bust_active" );
        }
        
        if ( self.statue.identity == "red" )
        {
            level utility::flag_set( "ruby_mq_directed_red_bust_active" );
        }
        
        if ( self.statue.identity == "blue" )
        {
            level utility::flag_set( "ruby_mq_directed_blue_bust_active" );
        }
        
        function_4ef47d3c5c627fb6();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x48b0aac4, Offset: 0xd092
// Size: 0xd4
function private statue_interact_hint( interact, player )
{
    if ( level utility::flag( "ruby_mq_bookpuzzle_cooldown" ) || level utility::flag( "ruby_mq_book_puzzle_solved" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/book_push", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xfbd1cc8f, Offset: 0xd16e
// Size: 0xd4
function private function_279e49ed93914017( interact, player )
{
    if ( level utility::flag( "ruby_mq_bookpuzzle_cooldown" ) || level utility::flag( "ruby_mq_book_puzzle_solved" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby_post/mq_bust_interact_green", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xf49c0b81, Offset: 0xd24a
// Size: 0xd4
function private function_dc4c934ec5ecc9c7( interact, player )
{
    if ( level utility::flag( "ruby_mq_bookpuzzle_cooldown" ) || level utility::flag( "ruby_mq_book_puzzle_solved" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby_post/mq_bust_interact_red", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x30477daa, Offset: 0xd326
// Size: 0xd4
function private function_110169614ac1c1da( interact, player )
{
    if ( level utility::flag( "ruby_mq_bookpuzzle_cooldown" ) || level utility::flag( "ruby_mq_book_puzzle_solved" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby_post/mq_bust_interact_blue", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xae8e9821, Offset: 0xd402
// Size: 0x2a7
function private function_b55bf7f238a6c419( statue, player )
{
    level endon( #"game_ended" );
    level.ruby_mq.bookpuzzleplayer = player;
    
    if ( statue.identity == "green" )
    {
        level.ruby_mq.var_1db71d790e2f4e9e++;
    }
    else if ( statue.identity == "red" )
    {
        level.ruby_mq.var_ec289a3fb6bc1ce++;
    }
    else if ( statue.identity == "blue" )
    {
        level.ruby_mq.var_517e00e3f02e6641++;
    }
    
    if ( level.ruby_mq.var_1db71d790e2f4e9e == level.ruby_mq.var_bf36b8b778fbad39 && level.ruby_mq.var_ec289a3fb6bc1ce == level.ruby_mq.var_cda233a53fa2c3e9 && level.ruby_mq.var_517e00e3f02e6641 == level.ruby_mq.var_23e333dbd46bed1e )
    {
        /#
            iprintlnbold( "<dev string:xfa>" );
        #/
        
        level notify( #"ruby_mq_book_puzzle_success" );
        
        if ( isdefined( level.ruby_mq.mdl_hatch ) )
        {
            level.ruby_mq.mdl_hatch hide();
        }
        
        level utility::flag_set( "ruby_mq_book_puzzle_solved" );
        function_4ef47d3c5c627fb6();
        s_neptune = utility::getstruct( "step3_planet", "targetname" );
        var_dca2aaae10dbc706 = utility::spawn_model( "sat_zm_armillary_sphere_neptune", s_neptune.origin, s_neptune.angles );
        playsoundatpos( s_neptune.origin, "evt_mq_secret_chamber_open" );
        earthquake( 0.3, 3, statue.origin, 1000 );
        playrumbleonposition( "artillery_rumble_light", statue.origin );
        interact = interaction::register_interact( s_neptune.origin, 120, &collect_neptune );
        interact sethintonobstruction( "show" );
        interact interaction::set_interact_hint_callback( &function_e9298fc7fc5f2b4b );
        level thread ladder_watcher();
        level callback::add( #"player_connect", &function_7136422a42f38ae5 );
        level thread function_bacd799179fdce4c( player );
        level utility::flag_wait( "ruby_mq_book_puzzle_complete" );
        
        if ( isdefined( interact ) )
        {
            interact delete();
        }
        
        if ( isdefined( var_dca2aaae10dbc706 ) )
        {
            var_dca2aaae10dbc706 delete();
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0x8d69f52, Offset: 0xd6b1
// Size: 0x5a
function function_7136422a42f38ae5( params )
{
    level endon( #"game_ended" );
    self waittill( #"spawned_player" );
    self.var_923a577cbb254b44 = 0;
    
    if ( self usinggamepad() )
    {
        self notifyonplayercommand( "interacted", "+usereload" );
        return;
    }
    
    self notifyonplayercommand( "interacted", "+activate" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x92179609, Offset: 0xd713
// Size: 0x2e
function private function_bacd799179fdce4c( player )
{
    level endon( #"game_ended" );
    wait 1;
    level battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x7006d42e, Offset: 0xd749
// Size: 0x35
function private function_bef158157e9f6218()
{
    level endon( #"game_ended" );
    wait 1;
    level battlechatter_mp::trysaylocalsound( level.ruby_mq.bookpuzzleplayer, #"bc_flavor_player_negative" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x8a392540, Offset: 0xd786
// Size: 0x212
function private ladder_watcher()
{
    level endon( #"game_ended" );
    level endon( #"nep_collected" );
    ladder_trigger = getent( "step3_ladder_interact_check", #targetname );
    
    foreach ( player in level.players )
    {
        player.var_923a577cbb254b44 = 0;
        
        if ( player usinggamepad() )
        {
            player notifyonplayercommand( "interacted", "+usereload" );
            continue;
        }
        
        player notifyonplayercommand( "interacted", "+activate" );
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( ladder_trigger ) )
            {
                if ( player.var_923a577cbb254b44 == 0 )
                {
                    player.var_923a577cbb254b44 = 1;
                    player thread function_108e9a3781984aee();
                }
                
                continue;
            }
            
            player.var_923a577cbb254b44 = 0;
        }
        
        if ( level utility::flag( "ruby_mq_book_puzzle_complete" ) )
        {
            foreach ( player in level.players )
            {
                player.var_923a577cbb254b44 = undefined;
            }
            
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xda441696, Offset: 0xd9a0
// Size: 0xee
function private function_108e9a3781984aee()
{
    level endon( #"game_ended" );
    level endon( #"nep_collected" );
    
    while ( true )
    {
        if ( self.var_923a577cbb254b44 == 0 )
        {
            return;
        }
        
        self waittill( #"interacted" );
        
        if ( self.var_923a577cbb254b44 == 0 )
        {
            return;
        }
        
        zm_quest::function_b57dfe9625966b0b( #"ruby_mq_misc", 0, #"planet", 1 );
        zm_quest::show_splash_item_picked_up( #"ruby_mq_misc", #"planet", 1, self );
        self playsoundtoplayer( "uin_zm_common_pickup_item", self );
        thread zm_vo::function_8c1a12974bd11f01( #"hash_779719980b7209ba", #"bc_flavor_player_positive" );
        level utility::flag_set( "ruby_mq_book_puzzle_complete" );
        level callback::remove( #"player_connect", &function_7136422a42f38ae5 );
        
        /#
            iprintlnbold( "<dev string:x10a>" );
        #/
        
        function_4ef47d3c5c627fb6();
        level notify( #"nep_collected" );
        return;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xe982e346, Offset: 0xda96
// Size: 0x19a
function private turn_off_ladder()
{
    level.ruby_mq.ladder = getent( "attic_ladder", #targetname );
    level.ruby_mq.mdl_ladders = getentarray( "ladder_model", #targetname );
    level.ruby_mq.mdl_hatch = getent( "ruby_mq_attic_hatch", #targetname );
    
    if ( isdefined( level.ruby_mq.mdl_ladders ) && isdefined( level.ruby_mq.ladder ) && isdefined( level.ruby_mq.mdl_hatch ) )
    {
        foreach ( ladder in level.ruby_mq.mdl_ladders )
        {
            ladder show();
        }
        
        level.ruby_mq.ladder show();
        level.ruby_mq.mdl_hatch show();
        level.ruby_mq.ladder solid();
        level.ruby_mq.ladder disconnectpaths();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x97255bb4, Offset: 0xdc38
// Size: 0x81
function private collect_neptune( player )
{
    zm_quest::function_b57dfe9625966b0b( #"ruby_mq_misc", 0, #"planet", 1 );
    zm_quest::show_splash_item_picked_up( #"ruby_mq_misc", #"planet", 1, player );
    player playsoundtoplayer( "uin_zm_common_pickup_item", player );
    player thread zm_vo::function_8c1a12974bd11f01( #"hash_779719980b7209ba", #"bc_flavor_player_positive" );
    level utility::flag_set( "ruby_mq_book_puzzle_complete" );
    self delete();
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xf7384310, Offset: 0xdcc1
// Size: 0x79
function private function_e9298fc7fc5f2b4b( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/pick_up", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x4541d66b, Offset: 0xdd42
// Size: 0x3f
function private function_336546f418f14ee6()
{
    level endon( #"game_ended" );
    self rotateby( ( 0, 20, 0 ), 0.8 );
    self waittill( #"rotatedone" );
    utility::ent_flag_clear( "moving" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x6ca89db4, Offset: 0xdd89
// Size: 0x43
function private rotate_statue_back( y_angle )
{
    level endon( #"game_ended" );
    self rotateby( ( 0, y_angle * -1, 0 ), 0.7 );
    self playsoundonmovingent( "evt_mq_library_statue_rotate" );
    self waittill( #"rotatedone" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x96ebd901, Offset: 0xddd4
// Size: 0x69
function private function_47ec2a5000e620ae()
{
    level endon( #"ruby_mq_book_puzzle_success" );
    level endon( #"game_ended" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        var_f9073b9a68fe2fe = 99999;
    }
    else
    {
        var_f9073b9a68fe2fe = 18;
    }
    
    for ( i = 1; i < var_f9073b9a68fe2fe ; i++ )
    {
        /#
            iprintlnbold( i );
        #/
        
        wait 1;
    }
    
    level thread function_5db4f101d38b5b78();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x92a44c03, Offset: 0xde45
// Size: 0x295
function private function_5db4f101d38b5b78()
{
    level.ruby_mq.var_1db71d790e2f4e9e = 0;
    level.ruby_mq.var_ec289a3fb6bc1ce = 0;
    level.ruby_mq.var_517e00e3f02e6641 = 0;
    
    if ( level.ruby_mq.var_7ada84406efe743b.interact.var_653f17b61476daa1 > 0 )
    {
        rotate_angle = level.ruby_mq.var_7ada84406efe743b.interact.var_653f17b61476daa1 * 20;
        level.ruby_mq.var_7ada84406efe743b thread rotate_statue_back( rotate_angle );
    }
    
    if ( level.ruby_mq.var_5f3072b81b818132.interact.var_653f17b61476daa1 > 0 )
    {
        rotate_angle = level.ruby_mq.var_5f3072b81b818132.interact.var_653f17b61476daa1 * 20;
        level.ruby_mq.var_5f3072b81b818132 thread rotate_statue_back( rotate_angle );
    }
    
    if ( level.ruby_mq.var_41b3fabaac6f2d46.interact.var_653f17b61476daa1 > 0 )
    {
        rotate_angle = level.ruby_mq.var_41b3fabaac6f2d46.interact.var_653f17b61476daa1 * 20;
        level.ruby_mq.var_41b3fabaac6f2d46 thread rotate_statue_back( rotate_angle );
    }
    
    level.ruby_mq.var_7ada84406efe743b.interact.var_653f17b61476daa1 = 0;
    level.ruby_mq.var_41b3fabaac6f2d46.interact.var_653f17b61476daa1 = 0;
    level.ruby_mq.var_5f3072b81b818132.interact.var_653f17b61476daa1 = 0;
    level.ruby_mq.var_ffee0f8ab24454d2 = 0;
    level.ruby_mq.bookpuzzleplayer = undefined;
    level thread function_bef158157e9f6218();
    level utility::flag_set( "ruby_mq_bookpuzzle_cooldown" );
    level.ruby_mq.var_d2db6b972a2d813c = zm_round_logic::get_rb_round_number() + 1;
    level callback::add( "on_round_start", &function_d63979e776966a8 );
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x5f3f6eba, Offset: 0xe0e2
// Size: 0x45
function private function_d63979e776966a8( params )
{
    level callback::remove( "on_round_start", &function_d63979e776966a8 );
    level.ruby_mq.var_d2db6b972a2d813c = undefined;
    level utility::flag_clear( "ruby_mq_bookpuzzle_cooldown" );
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x694b6b4c, Offset: 0xe12f
// Size: 0x87
function private function_e1fd91a18a68411d()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "ruby_mq_book_puzzle_complete" );
    s_neptuneorrey = utility::getstruct( "step3_neptune_orrey_interact", "targetname" );
    var_8111856e6038a8e9 = interaction::register_interact( s_neptuneorrey.origin, 100, &function_76d1d21732851a43 );
    var_8111856e6038a8e9 sethintonobstruction( "show" );
    var_8111856e6038a8e9 interaction::set_interact_hint_callback( &neptune_orrey_interact_hint );
    level utility::flag_wait( "ruby_mq_neptune_orrey_placed" );
    var_8111856e6038a8e9 delete();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xf46e76b1, Offset: 0xe1be
// Size: 0x1ef
function private function_76d1d21732851a43( player )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "ruby_mq_book_puzzle_complete" ) && !utility::flag( "mq_neptune_interact" ) )
    {
        level utility::flag_set( "mq_neptune_interact" );
        player playsoundtoplayer( "evt_mq_neptune_placed_orrey", player );
        s_neptuneplanet = utility::getstruct( "step3_orrey_neptune_orrery", "targetname" );
        level.ruby_mq.var_ca2e88320264e8c = utility::spawn_model( "sat_zm_armillary_sphere_neptune", s_neptuneplanet.origin, s_neptuneplanet.angles );
        level.ruby_mq.var_ca2e88320264e8c linkto( level.ruby_mq.var_f038e1dbd59362bb );
        level.ruby_mq.var_ca2e88320264e8c solid();
        level.ruby_mq.var_ca2e88320264e8c setcandamage( 1 );
        level.ruby_mq.var_ca2e88320264e8c.health = 999999;
        level.ruby_mq.var_ca2e88320264e8c.triggerassigned = "";
        level.ruby_mq.var_ca2e88320264e8c.triggerassigned = level.ruby_mq.var_c3b8c0b85d909338[ 2 ];
        level.ruby_mq.var_ca2e88320264e8c.planetname = "Neptune";
        level thread function_331de2327e60b394( player );
        
        /#
            iprintlnbold( "<dev string:xde>" );
        #/
        
        wait 1;
        level thread function_3afdc6d3ab068d49();
        waitframe();
        level utility::flag_set( "ruby_mq_neptune_orrey_placed" );
        zm_quest::function_4eefe6de31f5ddab( #"ruby_mq", #"place_planet", 1 );
        function_4ef47d3c5c627fb6();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xb8331615, Offset: 0xe3b5
// Size: 0xa2
function private neptune_orrey_interact_hint( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled && !isdefined( level.ruby_mq.var_ca2e88320264e8c ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mq_neptune_pedastal", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0x45243ca5, Offset: 0xe45f
// Size: 0x63
function function_331de2327e60b394( player )
{
    level endon( #"game_ended" );
    wait 0.5;
    var_db75d3de862ce072 = player_banter::play_banter_vo( #"hash_881304a4b433041e" );
    
    if ( var_db75d3de862ce072 == 1 )
    {
        return;
    }
    
    if ( isdefined( player ) )
    {
        player thread zm_vo::function_8c1a12974bd11f01( #"hash_881304a4b433041e", #"bc_flavor_player_positive" );
    }
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x2c72bbb4, Offset: 0xe4ca
    // Size: 0x5, Type: dev
    function private function_3f328a1fea04aa6()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x6bb7c2e2, Offset: 0xe4d7
// Size: 0x3d
function function_7edad93abae5100e( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "ruby_mq_s3_portal_initiated" );
    level thread function_e1fd91a18a68411d();
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x36f55aa9, Offset: 0xe51c
// Size: 0x70
function cleanup_step_9( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"orrery_puzzle_complete" ) ) && zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"orrery_puzzle_complete" ) == 1 )
        {
            level utility::flag_set( "ruby_mq_orrey_all_planets_set" );
        }
        
        level thread function_e1fd91a18a68411d();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xebdcb36a, Offset: 0xe594
// Size: 0x3a4
function private setup_orrery_puzzle_clue()
{
    var_908228be755e9ea8 = utility::getstructarray( "step3_orrey_clue_paper", "targetname" );
    var_e09a72bba31978c5 = utility::getstructarray( "step3_orrey_clue_alpha_1", "targetname" );
    var_e09a6fbba319722c = utility::getstructarray( "step3_orrey_clue_alpha_2", "targetname" );
    var_908228be755e9ea8 = arrayrandomize( var_908228be755e9ea8 );
    
    foreach ( struct in var_908228be755e9ea8 )
    {
        foreach ( var_24d4e5eb0ddb2eb7 in var_e09a72bba31978c5 )
        {
            if ( struct.script_noteworthy == var_24d4e5eb0ddb2eb7.script_noteworthy )
            {
                struct.var_49c325d9d5110c08 = var_24d4e5eb0ddb2eb7;
            }
        }
        
        foreach ( var_24d4e6eb0ddb30ea in var_e09a6fbba319722c )
        {
            if ( struct.script_noteworthy == var_24d4e6eb0ddb30ea.script_noteworthy )
            {
                struct.var_49c328d9d51112a1 = var_24d4e6eb0ddb30ea;
            }
        }
    }
    
    level.ruby_mq.assign_trigger = [];
    level.ruby_mq.var_c3b8c0b85d909338 = [ "NE", "NW", "SE", "SW" ];
    level.ruby_mq.var_c3b8c0b85d909338 = arrayrandomize( level.ruby_mq.var_c3b8c0b85d909338 );
    marsdirection = level.ruby_mq.var_c3b8c0b85d909338[ 0 ];
    saturndirection = level.ruby_mq.var_c3b8c0b85d909338[ 1 ];
    neptunedirection = level.ruby_mq.var_c3b8c0b85d909338[ 2 ];
    var_a8896eedcdf19ebe = utility::spawn_model( "sat_zm_note_planet_sketches_mars_01", var_908228be755e9ea8[ 0 ].origin, var_908228be755e9ea8[ 0 ].angles );
    var_14097c1f3e0d2c6d = function_16c8ec8bf9eafbeb( marsdirection );
    function_48dd78d393a36e6b( var_908228be755e9ea8[ 0 ], var_14097c1f3e0d2c6d );
    var_f0ae506eb524ae9c = utility::spawn_model( "sat_zm_note_planet_sketches_saturn_01", var_908228be755e9ea8[ 1 ].origin, var_908228be755e9ea8[ 1 ].angles );
    var_3982bb698ed4070f = function_16c8ec8bf9eafbeb( saturndirection );
    function_48dd78d393a36e6b( var_908228be755e9ea8[ 1 ], var_3982bb698ed4070f );
    var_240bc64483694b9a = utility::spawn_model( "sat_zm_note_planet_sketches_neptune_01", var_908228be755e9ea8[ 2 ].origin, var_908228be755e9ea8[ 2 ].angles );
    var_cae14e9376618779 = function_16c8ec8bf9eafbeb( neptunedirection );
    function_48dd78d393a36e6b( var_908228be755e9ea8[ 2 ], var_cae14e9376618779 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x6785eeef, Offset: 0xe940
// Size: 0xaf
function private function_48dd78d393a36e6b( loc, a_string )
{
    basestring = "sat_zm_note_planet_alphabet_";
    newstring = basestring + a_string[ 0 ];
    mdl_num = utility::spawn_model( newstring, loc.var_49c325d9d5110c08.origin, loc.var_49c325d9d5110c08.angles );
    newstring = basestring + a_string[ 1 ];
    mdl_num = utility::spawn_model( newstring, loc.var_49c328d9d51112a1.origin, loc.var_49c328d9d51112a1.angles );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x7903d806, Offset: 0xe9f7
// Size: 0x96
function private function_16c8ec8bf9eafbeb( direction )
{
    switch ( direction )
    {
        case #"hash_fa92edf6bdb724dc":
            return [ "north", "east" ];
        case #"hash_fa92dff6bdb70ed2":
            return [ "north", "west" ];
        case #"hash_fab591f6bdd26a85":
            return [ "south", "east" ];
        case #"hash_fab59ff6bdd2808f":
            return [ "south", "west" ];
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xc75c524c, Offset: 0xea95
// Size: 0x54b
function private function_49a1dfc2b068c429()
{
    var_73a97a0894b41e16 = utility::getstruct( "step3_orrey_earth_arm", "targetname" );
    var_78a2f02d84ff2111 = utility::getstruct( "step3_orrey_jupiter_arm", "targetname" );
    var_d652199a7071500d = utility::getstruct( "step3_orrey_mercury_arm", "targetname" );
    var_524e8fc365408252 = utility::getstruct( "step3_orrey_uranus_arm", "targetname" );
    var_a5e9f0f0550ff885 = utility::getstruct( "step3_orrey_venus_arm", "targetname" );
    level.ruby_mq.var_1b408287bd9abd2c = utility::spawn_model( "sat_zm_armillary_sphere_earth_arm", var_73a97a0894b41e16.origin, var_73a97a0894b41e16.angles );
    level.ruby_mq.var_ca6b9abf1eb24463 = utility::spawn_model( "sat_zm_armillary_sphere_jupiter_arm", var_78a2f02d84ff2111.origin, var_78a2f02d84ff2111.angles );
    level.ruby_mq.var_98a48f5ca9a7f9cb = utility::spawn_model( "sat_zm_armillary_sphere_mercury_arm", var_d652199a7071500d.origin, var_d652199a7071500d.angles );
    level.ruby_mq.var_d59e209e01d3b084 = utility::spawn_model( "sat_zm_armillary_sphere_uranus_arm", var_524e8fc365408252.origin, var_524e8fc365408252.angles );
    level.ruby_mq.var_515b15d5da6e6c1b = utility::spawn_model( "sat_zm_armillary_sphere_venus_arm", var_a5e9f0f0550ff885.origin, var_a5e9f0f0550ff885.angles );
    var_caf89de59df467ae = utility::getstruct( "step3_orrey_earth_orrery", "targetname" );
    var_e592f3091924c2cf = utility::getstruct( "step3_orrey_jupiter_orrery", "targetname" );
    var_e49b23e40b72ab6b = utility::getstruct( "step3_orrey_mercury_orrery", "targetname" );
    var_66668115217033fa = utility::getstruct( "step3_orrey_uranus_orrery", "targetname" );
    var_e1e241fe161416a3 = utility::getstruct( "step3_orrey_venus_orrery", "targetname" );
    mdl_earth = utility::spawn_model( "sat_zm_armillary_sphere_earth", var_caf89de59df467ae.origin, var_caf89de59df467ae.angles );
    mdl_jupiter = utility::spawn_model( "sat_zm_armillary_sphere_jupiter", var_e592f3091924c2cf.origin, var_e592f3091924c2cf.angles );
    mdl_mercury = utility::spawn_model( "sat_zm_armillary_sphere_mercury", var_e49b23e40b72ab6b.origin, var_e49b23e40b72ab6b.angles );
    mdl_uranus = utility::spawn_model( "sat_zm_armillary_sphere_uranus", var_66668115217033fa.origin, var_66668115217033fa.angles );
    mdl_venus = utility::spawn_model( "sat_zm_armillary_sphere_venus", var_e1e241fe161416a3.origin, var_e1e241fe161416a3.angles );
    mdl_earth linkto( level.ruby_mq.var_1b408287bd9abd2c );
    mdl_jupiter linkto( level.ruby_mq.var_ca6b9abf1eb24463 );
    mdl_mercury linkto( level.ruby_mq.var_98a48f5ca9a7f9cb );
    mdl_uranus linkto( level.ruby_mq.var_d59e209e01d3b084 );
    mdl_venus linkto( level.ruby_mq.var_515b15d5da6e6c1b );
    s_neptunearm = utility::getstruct( "step3_orrey_neptune_arm", "targetname" );
    s_marsarm = utility::getstruct( "step3_orrey_mars_arm", "targetname" );
    var_8309997e3e027c3f = utility::getstruct( "step3_orrey_saturn_arm", "targetname" );
    s_marsplanet = utility::getstruct( "step3_orrey_mars_orrery", "targetname" );
    var_cfc8230383700ab9 = utility::getstruct( "step3_orrey_saturn_orrery", "targetname" );
    level.ruby_mq.var_f038e1dbd59362bb = utility::spawn_model( "sat_zm_armillary_sphere_neptune_arm", s_neptunearm.origin, s_neptunearm.angles );
    level.ruby_mq.var_e69964c573e29481 = utility::spawn_model( "sat_zm_armillary_sphere_saturn_arm", var_8309997e3e027c3f.origin, var_8309997e3e027c3f.angles );
    level.ruby_mq.var_c0ef494be860cf7 = utility::spawn_model( "sat_zm_armillary_sphere_mars_arm", s_marsarm.origin, s_marsarm.angles );
    level.ruby_mq.mdl_saturn = utility::spawn_model( "sat_zm_armillary_sphere_saturn", var_cfc8230383700ab9.origin, var_cfc8230383700ab9.angles );
    level.ruby_mq.mdl_mars = utility::spawn_model( "sat_zm_armillary_sphere_mars", s_marsplanet.origin, s_marsplanet.angles );
    level.ruby_mq.mdl_saturn linkto( level.ruby_mq.var_e69964c573e29481 );
    level.ruby_mq.mdl_mars linkto( level.ruby_mq.var_c0ef494be860cf7 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xef8c220f, Offset: 0xefe8
// Size: 0x1a6
function private function_4555ce932526ef5f()
{
    level.ruby_mq.mdl_mars solid();
    level.ruby_mq.mdl_mars setcandamage( 1 );
    level.ruby_mq.mdl_mars.health = 999999;
    level.ruby_mq.mdl_mars.triggerassigned = "";
    level.ruby_mq.mdl_mars.planetname = "Mars";
    level.ruby_mq.mdl_mars thread function_a0fc16f9aeacf0f5();
    level.ruby_mq.mdl_saturn solid();
    level.ruby_mq.mdl_saturn setcandamage( 1 );
    level.ruby_mq.mdl_saturn.health = 999999;
    level.ruby_mq.mdl_saturn.triggerassigned = "";
    level.ruby_mq.mdl_saturn.planetname = "Saturn";
    level.ruby_mq.mdl_saturn thread function_a0fc16f9aeacf0f5();
    level thread function_17255bd81237627f();
    level thread function_b402ba126f781f13();
    level thread function_803f2ed04cad8111();
    level.ruby_mq.var_ca2e88320264e8c thread function_a0fc16f9aeacf0f5();
    level thread function_e45c03420d69ee9f();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xdb84dd2f, Offset: 0xf196
// Size: 0x1a7
function private function_3afdc6d3ab068d49()
{
    level endon( #"game_ended" );
    
    if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"hash_28ff14d33eab4a66" ) ) && zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"hash_28ff14d33eab4a66" ) == 1 )
    {
    }
    else
    {
        level thread function_564c4f699246b12d();
    }
    
    s_neptunearm = utility::getstruct( "step3_orrey_neptune_arm_finalpos", "targetname" );
    s_marsarm = utility::getstruct( "step3_orrey_mars_arm_finalpos", "targetname" );
    var_8309997e3e027c3f = utility::getstruct( "step3_orrey_saturn_arm_finalpos", "targetname" );
    level.ruby_mq.var_f038e1dbd59362bb playsoundonmovingent( "evt_mq_orrery_reset" );
    level.ruby_mq.var_f038e1dbd59362bb rotateto( s_neptunearm.angles, 6, 1, 3.5 );
    level.ruby_mq.var_c0ef494be860cf7 rotateto( s_marsarm.angles, 6, 1, 3 );
    level.ruby_mq.var_e69964c573e29481 rotateto( var_8309997e3e027c3f.angles, 5, 1, 3.5 );
    level.ruby_mq.var_f038e1dbd59362bb waittill( #"rotatedone" );
    
    if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"hash_28ff14d33eab4a66" ) ) && zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"hash_28ff14d33eab4a66" ) == 1 )
    {
        return;
    }
    
    level thread function_4555ce932526ef5f();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xb118e2d1, Offset: 0xf345
// Size: 0x2e
function private function_564c4f699246b12d()
{
    level endon( #"game_ended" );
    wait 1;
    zm_quest::function_8934bb2a9028bdc5();
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_ab5756c0cd8e9db6" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x4d4b9f67, Offset: 0xf37b
// Size: 0x27c
function private function_e45c03420d69ee9f()
{
    level endon( #"game_ended" );
    level endon( #"hash_4ac23c0f5bfc5ba8" );
    
    while ( true )
    {
        level.ruby_mq.var_ca2e88320264e8c waittill( #"damage", idamage, eattacker, vhitdir, var_8bc0ee7f93665fd1, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isplayer( eattacker ) )
        {
            if ( isdefined( level.ruby_mq.var_ca2e88320264e8c ) )
            {
                level.ruby_mq.var_ca2e88320264e8c playsoundonmovingent( "evt_mq_planet_impact_hit" );
                player = eattacker;
                rotate_distance = 25;
                
                if ( objweapon.classname == "sniper" || objweapon.basename == "sat_ww_raygunmark2_mp" || objweapon.basename == "sat_ww_raygun_mp" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" )
                {
                    rotate_distance = 50;
                }
                else
                {
                    rotate_distance = 25;
                }
                
                neptune_forward = anglestoforward( level.ruby_mq.var_ca2e88320264e8c.angles );
                var_9d0c2cc3d2a2e43f = level.ruby_mq.var_ca2e88320264e8c.origin - player.origin;
                dot = vectordot( neptune_forward, var_9d0c2cc3d2a2e43f );
                
                if ( dot < 0 )
                {
                    level.ruby_mq.var_f038e1dbd59362bb rotateby( ( 0, rotate_distance, 0 ), 2, 0.25, 1.75 );
                }
                else
                {
                    level.ruby_mq.var_f038e1dbd59362bb rotateby( ( 0, rotate_distance * -1, 0 ), 2, 0.25, 1.75 );
                }
                
                level.ruby_mq.var_f038e1dbd59362bb waittill( #"rotatedone" );
                level.ruby_mq.var_ca2e88320264e8c thread function_a0fc16f9aeacf0f5();
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xcc96a0e4, Offset: 0xf5ff
// Size: 0x282
function private function_b402ba126f781f13()
{
    level endon( #"game_ended" );
    level endon( #"hash_4ac23c0f5bfc5ba8" );
    
    while ( true )
    {
        level.ruby_mq.mdl_mars waittill( #"damage", idamage, eattacker, vhitdir, var_8bc0ee7f93665fd1, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isplayer( eattacker ) )
        {
            if ( isdefined( level.ruby_mq.var_c0ef494be860cf7 ) )
            {
                level.ruby_mq.mdl_mars playsoundonmovingent( "evt_mq_planet_impact_hit" );
                player = eattacker;
                rotate_distance = 25;
                
                if ( objweapon.classname == "sniper" || objweapon.basename == "sat_ww_raygunmark2_mp" || objweapon.basename == "sat_ww_raygun_mp" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" )
                {
                    rotate_distance = 50;
                }
                else
                {
                    rotate_distance = 25;
                }
                
                mars_forward = anglestoforward( level.ruby_mq.mdl_mars.angles );
                var_b4df8a9f4c42718b = level.ruby_mq.mdl_mars.origin - player.origin;
                dot = vectordot( mars_forward, var_b4df8a9f4c42718b );
                
                if ( dot < 0 )
                {
                    level.ruby_mq.var_c0ef494be860cf7 rotateby( ( 0, rotate_distance, 0 ), 1.5, 0.25, 1.25 );
                }
                else
                {
                    level.ruby_mq.var_c0ef494be860cf7 rotateby( ( 0, rotate_distance * -1, 0 ), 1.5, 0.25, 1.25 );
                }
                
                level.ruby_mq.var_c0ef494be860cf7 waittill( #"rotatedone" );
                level.ruby_mq.mdl_mars thread function_a0fc16f9aeacf0f5();
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xc8d4b21f, Offset: 0xf889
// Size: 0x27c
function private function_803f2ed04cad8111()
{
    level endon( #"game_ended" );
    level endon( #"hash_4ac23c0f5bfc5ba8" );
    
    while ( true )
    {
        level.ruby_mq.mdl_saturn waittill( #"damage", idamage, eattacker, vhitdir, var_8bc0ee7f93665fd1, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isplayer( eattacker ) )
        {
            if ( isdefined( level.ruby_mq.var_e69964c573e29481 ) )
            {
                level.ruby_mq.var_e69964c573e29481 playsoundonmovingent( "evt_mq_planet_impact_hit" );
                player = eattacker;
                rotate_distance = 25;
                
                if ( objweapon.classname == "sniper" || objweapon.basename == "sat_ww_raygunmark2_mp" || objweapon.basename == "sat_ww_raygun_mp" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" )
                {
                    rotate_distance = 50;
                }
                else
                {
                    rotate_distance = 25;
                }
                
                saturn_forward = anglestoforward( level.ruby_mq.mdl_saturn.angles );
                var_ca4e63fe81fef625 = level.ruby_mq.mdl_saturn.origin - player.origin;
                dot = vectordot( saturn_forward, var_ca4e63fe81fef625 );
                
                if ( dot > 0 )
                {
                    level.ruby_mq.var_e69964c573e29481 rotateby( ( 0, rotate_distance, 0 ), 2, 0.25, 1.75 );
                }
                else
                {
                    level.ruby_mq.var_e69964c573e29481 rotateby( ( 0, rotate_distance * -1, 0 ), 2, 0.25, 1.75 );
                }
                
                level.ruby_mq.var_e69964c573e29481 waittill( #"rotatedone" );
                level.ruby_mq.mdl_saturn thread function_a0fc16f9aeacf0f5();
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x1dad37ac, Offset: 0xfb0d
// Size: 0xf1
function private function_17255bd81237627f()
{
    level.ruby_mq.trigger_ne = getent( "step3_northeast", "targetname" );
    level.ruby_mq.trigger_nw = getent( "step3_northwest", "targetname" );
    level.ruby_mq.trigger_sw = getent( "step3_southwest", "targetname" );
    level.ruby_mq.trigger_se = getent( "step3_southeast", "targetname" );
    level.ruby_mq.mdl_mars.triggerassigned = level.ruby_mq.var_c3b8c0b85d909338[ 0 ];
    level.ruby_mq.mdl_saturn.triggerassigned = level.ruby_mq.var_c3b8c0b85d909338[ 1 ];
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x19bc521d, Offset: 0xfc06
// Size: 0x1ca
function private function_a0fc16f9aeacf0f5()
{
    if ( self.triggerassigned == "NE" && isdefined( level.ruby_mq.trigger_ne ) )
    {
        if ( self istouching( level.ruby_mq.trigger_ne ) )
        {
            thread set_planet_flag();
        }
        else if ( !self istouching( level.ruby_mq.trigger_ne ) )
        {
            thread function_d91598c056527f79();
        }
    }
    
    if ( self.triggerassigned == "NW" && isdefined( level.ruby_mq.trigger_nw ) )
    {
        if ( self istouching( level.ruby_mq.trigger_nw ) )
        {
            thread set_planet_flag();
        }
        else if ( !self istouching( level.ruby_mq.trigger_nw ) )
        {
            thread function_d91598c056527f79();
        }
    }
    
    if ( self.triggerassigned == "SE" && isdefined( level.ruby_mq.trigger_se ) )
    {
        if ( self istouching( level.ruby_mq.trigger_se ) )
        {
            thread set_planet_flag();
        }
        else if ( !self istouching( level.ruby_mq.trigger_se ) )
        {
            thread function_d91598c056527f79();
        }
    }
    
    if ( self.triggerassigned == "SW" && isdefined( level.ruby_mq.trigger_sw ) )
    {
        if ( self istouching( level.ruby_mq.trigger_sw ) )
        {
            thread set_planet_flag();
            return;
        }
        
        if ( !self istouching( level.ruby_mq.trigger_sw ) )
        {
            thread function_d91598c056527f79();
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x6b4c7ee0, Offset: 0xfdd8
// Size: 0x10d
function private set_planet_flag()
{
    /#
        iprintlnbold( "<dev string:x11c>" );
    #/
    
    if ( !level utility::flag( "ruby_mq_orrey_neptune_set" ) && self.planetname == "Neptune" )
    {
        level utility::flag_set( "ruby_mq_orrey_neptune_set" );
    }
    
    if ( !level utility::flag( "ruby_mq_orrey_mars_set" ) && self.planetname == "Mars" )
    {
        level utility::flag_set( "ruby_mq_orrey_mars_set" );
    }
    
    if ( !level utility::flag( "ruby_mq_orrey_saturn_set" ) && self.planetname == "Saturn" )
    {
        level utility::flag_set( "ruby_mq_orrey_saturn_set" );
    }
    
    if ( level utility::flag( "ruby_mq_orrey_saturn_set" ) && level utility::flag( "ruby_mq_orrey_mars_set" ) && level utility::flag( "ruby_mq_orrey_neptune_set" ) )
    {
        if ( !level utility::flag( "ruby_mq_orrey_all_planets_set" ) )
        {
            level utility::flag_set( "ruby_mq_orrey_all_planets_set" );
            zm_quest::function_4eefe6de31f5ddab( #"ruby_mq", #"orrery_puzzle_complete", 1 );
            function_4ef47d3c5c627fb6();
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xa3fcea18, Offset: 0xfeed
// Size: 0x14e
function private function_d91598c056527f79()
{
    if ( level utility::flag( "ruby_mq_orrey_neptune_set" ) && self.planetname == "Neptune" )
    {
        level utility::flag_clear( "ruby_mq_orrey_neptune_set" );
        
        /#
            iprintlnbold( "<dev string:x131>" );
        #/
    }
    
    if ( level utility::flag( "ruby_mq_orrey_mars_set" ) && self.planetname == "Mars" )
    {
        level utility::flag_clear( "ruby_mq_orrey_mars_set" );
        
        /#
            iprintlnbold( "<dev string:x131>" );
        #/
    }
    
    if ( level utility::flag( "ruby_mq_orrey_saturn_set" ) && self.planetname == "Saturn" )
    {
        level utility::flag_clear( "ruby_mq_orrey_saturn_set" );
        
        /#
            iprintlnbold( "<dev string:x131>" );
        #/
    }
    
    if ( level utility::flag( "ruby_mq_orrey_saturn_set" ) && level utility::flag( "ruby_mq_orrey_mars_set" ) && level utility::flag( "ruby_mq_orrey_neptune_set" ) )
    {
        level utility::flag_set( "ruby_mq_orrey_all_planets_set" );
        zm_quest::function_4eefe6de31f5ddab( #"ruby_mq", #"orrery_puzzle_complete", 1 );
    }
    else if ( isdefined( level utility::flag( "ruby_mq_orrey_all_planets_set" ) ) )
    {
        level utility::flag_clear( "ruby_mq_orrey_all_planets_set" );
        zm_quest::function_4eefe6de31f5ddab( #"ruby_mq", #"orrery_puzzle_complete", 0 );
    }
    
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x78e3e579, Offset: 0x10043
// Size: 0x45
function private function_321b2d609c9e6819( dist )
{
    level.ruby_mq endon( #"hash_c2e89c89daea2436" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self rotateby( ( 0, dist, 0 ), 0.1 );
        waitframe();
    }
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x9650dcc2, Offset: 0x10090
    // Size: 0x5, Type: dev
    function private function_7f1ea76bb9c3cb3b()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x46c94fc9, Offset: 0x1009d
// Size: 0x35
function function_e0386a29059b33f2( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_s3_orrery_defend_success" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x16388b50, Offset: 0x100da
// Size: 0x215
function cleanup_step_10( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "ruby_mq_s3_mars_coord_entered" );
        level utility::flag_set( "ruby_mq_neptune_orrey_placed" );
        level utility::flag_set( "ruby_mq_orrey_all_planets_set" );
        level utility::flag_set( "ruby_mq_s3_orrery_defend_success" );
        level utility::flag_set( "open_mars_portal" );
        level utility::flag_set( "tp_players_complete" );
        level utility::flag_set( "enable_mars_zones" );
        level utility::flag_set( "ruby_mq_book_puzzle_solved" );
        level utility::flag_set( "ruby_mq_book_puzzle_complete" );
        level utility::flag_set( "ruby_mq_directed_green_bust_active" );
        level utility::flag_set( "ruby_mq_directed_red_bust_active" );
        level utility::flag_set( "ruby_mq_directed_blue_bust_active" );
        level thread function_9b19e51267e4afd4();
        level thread function_34adbf3e121b79a1();
        level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "machine_states", "ready" );
        level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "complete", "on" );
        activateworldevent( "we_lgt_teleporter_orrery" );
        level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "idle", "idle" );
        
        if ( isdefined( level.ruby_mq.var_2f58b2bc7556d331 ) )
        {
            level.ruby_mq.var_2f58b2bc7556d331.mdl_brain delete();
            level.ruby_mq.var_2f58b2bc7556d331 delete();
        }
        
        level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "energy", "fade" );
        waitframe();
        level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "energy", "off" );
        
        if ( level callback::exists( "zm_sat_exfil_vote_initiated", &set_portal_machine_cooldown ) )
        {
            level callback::remove( "zm_sat_exfil_vote_initiated", &set_portal_machine_cooldown );
        }
    }
    
    level thread zm_quest::update_round_cap( 15 );
    level.var_18cae6c63b0f0662 = 1;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x8c6ca0f7, Offset: 0x102f7
// Size: 0x143
function function_9b19e51267e4afd4()
{
    level endon( #"game_ended" );
    level.var_eafbf349af925860 solid();
    level.var_eafbf349af925860 connectpaths();
    level.var_eafbf349af925860 linkto( level.ruby_mq.mdl_portal_cap );
    level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "fail", "off" );
    level.ruby_mq.mdl_portal_cap.scr_fx utility::function_7c10ea82c1e305b8( "fail", "off" );
    level.ruby_mq.mdl_portal_cap moveto( level.ruby_mq.mdl_portal_cap.origin + ( 0, 0, 195 ), 3.5, 0.25, 0.25 );
    wait 0.5;
    level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "buildup", "buildup" );
    wait 3.1;
    level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "buildup", "off" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0xb47b62bd, Offset: 0x10442
// Size: 0x1ac
function spawn_portal()
{
    s_portal = utility::getstruct( "step3_portal_base", "targetname" );
    s_portal_cap = utility::getstruct( "step3_portal_cap", "targetname" );
    s_portal_energy = utility::getstruct( "step3_portal_dmg_point", "targetname" );
    level.ruby_mq.scr_portal = spawnscriptable( %"sat_zm_ruby_mq_portal", s_portal.origin, s_portal.angles );
    level.ruby_mq.scr_portal_energy = spawnscriptable( %"sat_zm_ruby_mq_portal_energy", s_portal_energy.origin, s_portal_energy.angles );
    level.ruby_mq.mdl_portal_cap = utility::spawn_model( %"sat_zm_teleporter_cap", s_portal_cap.origin, s_portal_cap.angles );
    level.ruby_mq.mdl_portal_cap.scr_fx = spawnscriptable( %"sat_zm_ruby_mq_portal_top", s_portal_cap.origin, s_portal_cap.angles );
    level.ruby_mq.mdl_portal_cap.scr_fx utility::scriptable_setparententity( level.ruby_mq.mdl_portal_cap );
    level.ruby_mq.mdl_portal_cap.orgloc = level.ruby_mq.mdl_portal_cap.origin;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x50828105, Offset: 0x105f6
// Size: 0x193
function function_4adf1ae09b36f207()
{
    level endon( #"game_ended" );
    level.var_eafbf349af925860 solid();
    level.var_eafbf349af925860 connectpaths();
    level.var_eafbf349af925860 linkto( level.ruby_mq.mdl_portal_cap );
    level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "fail", "off" );
    level.ruby_mq.mdl_portal_cap.scr_fx utility::function_7c10ea82c1e305b8( "fail", "off" );
    level.ruby_mq.mdl_portal_cap moveto( level.ruby_mq.mdl_portal_cap.origin + ( 0, 0, 195 ), 3.5, 0.25, 0.25 );
    wait 0.5;
    level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "buildup", "buildup" );
    wait 3.1;
    level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "buildup", "off" );
    level.ruby_mq.mdl_portal_cap.scr_fx setscriptablepartstate( "formation", "on" );
    level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "energy", "on" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x91fc6ac7, Offset: 0x10791
// Size: 0x19c
function function_78ffb6035d984ce2()
{
    level endon( #"game_ended" );
    playsoundatpos( level.ruby_mq.mdl_portal_cap.origin, "evt_mq_portal_despawn" );
    level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "energy", "fade" );
    level.ruby_mq.mdl_portal_cap.scr_fx setscriptablepartstate( "formation", "off" );
    level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "buildup", "buildup" );
    level.ruby_mq.mdl_portal_cap moveto( level.ruby_mq.mdl_portal_cap.orgloc, 2.5, 0.25, 0.25 );
    level.ruby_mq.mdl_portal_cap waittill( #"movedone" );
    level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "buildup", "off" );
    level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "fail", "on" );
    level.ruby_mq.mdl_portal_cap.scr_fx setscriptablepartstate( "fail", "on" );
    level.var_eafbf349af925860 notsolid();
    level.var_eafbf349af925860 connectpaths();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x3cdf3e95, Offset: 0x10935
// Size: 0x55
function function_34adbf3e121b79a1()
{
    level.ruby_mq endon( #"hash_c2e89c89daea2436" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level.ruby_mq.mdl_portal_cap rotateby( ( 0, 3, 0 ), 0.1 );
        waitframe();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xd4647003, Offset: 0x10992
// Size: 0xef
function private function_edfb277847aaeb25()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    level.ruby_mq.var_a86e452329d24960 = getentarray( "step3_lockdown_collision", #targetname );
    
    if ( !isdefined( level.ruby_mq.var_a86e452329d24960 ) )
    {
        return;
    }
    
    foreach ( col in level.ruby_mq.var_a86e452329d24960 )
    {
        col connectpaths();
        col notsolid();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x32a3b0f3, Offset: 0x10a89
// Size: 0x10f
function private function_2047d26f7cbc6f8c()
{
    level endon( #"game_ended" );
    var_e6463a9524897ae4 = utility::getstruct( "step3_portal_computer", "targetname" );
    level.ruby_mq.var_82968f365563f93c = spawnscriptable( %"sat_zm_ruby_mq_portal_machine", var_e6463a9524897ae4.origin, var_e6463a9524897ae4.angles );
    level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "model", "on" );
    level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "machine_states", "off" );
    var_4455616196599590 = utility::getstruct( "step3_perfusion_connect_off", "targetname" );
    level.ruby_mq.var_31ab07dce74045f5 = utility::spawn_model( "sat_zm_perfusion_machine_wire_01_unconnect", var_4455616196599590.origin, var_4455616196599590.angles );
    level utility::flag_wait( "ruby_mq_s3_portal_initiated" );
    level thread function_e1ebea7d6fa64883( var_e6463a9524897ae4 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xe6b8e149, Offset: 0x10ba0
// Size: 0xe4
function private function_e1ebea7d6fa64883( var_e6463a9524897ae4 )
{
    level endon( #"game_ended" );
    var_7f9862f72d648496 = interaction::register_interact( var_e6463a9524897ae4.origin, 100, &activate_portal_terminal );
    var_7f9862f72d648496 sethintonobstruction( "show" );
    var_7f9862f72d648496 interaction::set_interact_hint_callback( &function_aae081b7692adbf8 );
    level.ruby_mq.var_e36e6d8a8474d939 = 0;
    level.ruby_mq.var_13b373d6d3c7341e = 0;
    level.ruby_mq.var_97df3eb3ff3348d8 = [];
    level._effect[ "mars_spl_zombie" ] = loadfxasset( "vfx_t10_gameplay_zm_ai_zmb_elec_tornado" );
    level.ruby_mq.var_7aa904e1275e0970 = getent( "step3_portal_dmg_watcher", "targetname" );
    level utility::flag_wait( "ruby_mq_s3_orrery_defend_success" );
    var_7f9862f72d648496 delete();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x545cd0e7, Offset: 0x10c8c
// Size: 0x157
function private activate_portal_terminal( player )
{
    if ( level utility::flag( "ruby_mq_orrey_neptune_set" ) && level utility::flag( "ruby_mq_orrey_mars_set" ) && level utility::flag( "ruby_mq_orrey_saturn_set" ) && level utility::flag( "ruby_mq_s3_mars_coord_entered" ) && !level utility::flag( "ruby_mq_portal_rebooting" ) && !level utility::flag( "ruby_mq_orrey_defend_cooldown" ) )
    {
        level notify( #"hash_4ac23c0f5bfc5ba8" );
        level utility::flag_set( "ruby_mq_orrey_puzzle_complete" );
    }
    
    if ( level utility::flag( "ruby_mq_orrey_puzzle_complete" ) && !level utility::flag( "ruby_mq_portal_rebooting" ) && !level utility::flag( "ruby_mq_orrey_defend_cooldown" ) )
    {
        /#
            iprintlnbold( "<dev string:x147>" );
        #/
        
        level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "initialize", "off" );
        level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "rebooting", "on" );
        level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "machine_states", "reboot" );
        level thread function_89480629f6cd9bad( player );
        level utility::flag_set( "ruby_mq_portal_rebooting" );
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x158>" );
    #/
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x1ae344f2, Offset: 0x10deb
// Size: 0x119
function private function_aae081b7692adbf8( interact, player )
{
    if ( level utility::flag( "ruby_mq_s3_mars_coord_entered" ) && level utility::flag( "ruby_mq_orrey_neptune_set" ) && level utility::flag( "ruby_mq_orrey_mars_set" ) && level utility::flag( "ruby_mq_orrey_saturn_set" ) && !level utility::flag( "ruby_mq_portal_rebooting" ) && !level utility::flag( "ruby_mq_orrey_defend_cooldown" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mq_portal_pc_interact", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x4b573fef, Offset: 0x10f0c
// Size: 0x120
function private function_89480629f6cd9bad( player )
{
    level endon( #"game_ended" );
    
    if ( level callback::exists( "zm_sat_exfil_vote_initiated", &set_portal_machine_cooldown ) )
    {
        level callback::remove( "zm_sat_exfil_vote_initiated", &set_portal_machine_cooldown );
    }
    
    zm_quest::clear_all_guidance();
    level thread function_8878884517e2c350();
    level utility::flag_set( "mq_vo_galileo_lockdown" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"ruby_defend" );
    zm_blackhole_bomb::function_2a49f9fa9277a208( [ "zone_orrery_lower", "zone_orrery_upper_floor", "zone_orrery" ] );
    level thread zm_round_spawning::pause_round_spawning( 1, "ruby_mq_orrery_defend" );
    level thread function_4adf1ae09b36f207();
    level thread function_34adbf3e121b79a1();
    level thread function_afcee9af059b60a3();
    level function_2db0ec9aa92531e1( player );
    wait 5.85;
    level function_dd13ffa0a804b8b4();
    level thread setup_attractor( player );
    level thread function_3fa86b57111d7c08();
    level thread function_10bca5f2d3c53a12();
    level thread function_5b667d94d94e2d7();
    wait 5;
    level.ruby_mq.var_a1dbdfa1e6ea7979 = [];
    level thread galileo_drone_spawner();
    level thread function_fb7cfde8288de93e();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xf18bebd4, Offset: 0x11034
// Size: 0xe2
function private function_afcee9af059b60a3()
{
    level.ruby_mq.var_98a48f5ca9a7f9cb thread function_321b2d609c9e6819( 7 );
    level.ruby_mq.var_515b15d5da6e6c1b thread function_321b2d609c9e6819( 6 );
    level.ruby_mq.var_1b408287bd9abd2c thread function_321b2d609c9e6819( 5 );
    level.ruby_mq.var_c0ef494be860cf7 thread function_321b2d609c9e6819( 4 );
    level.ruby_mq.var_ca6b9abf1eb24463 thread function_321b2d609c9e6819( 3 );
    level.ruby_mq.var_e69964c573e29481 thread function_321b2d609c9e6819( 3 );
    level.ruby_mq.var_d59e209e01d3b084 thread function_321b2d609c9e6819( 2 );
    level.ruby_mq.var_f038e1dbd59362bb thread function_321b2d609c9e6819( 1 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x64893c2f, Offset: 0x1111e
// Size: 0x275
function private function_2db0ec9aa92531e1( player )
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( player isvehicleactive() )
        {
            data = { #exittype:"INVOLUNTARY", #allowairexit:1 };
            seatid = vehicle_occupancy::get_occupant_seat( level.wonder_veh, player );
            level thread vehicle_occupancy::exit( level.wonder_veh, seatid, player, data, 1 );
            wait 1;
        }
    }
    
    if ( level utility::flag( "sq_echoes_activated" ) )
    {
        level callback::callback( "end_echoes_sq" );
    }
    
    activated_player = player;
    a_teleport_players = arrayremove( level.players, activated_player );
    var_2b43aa5f72b09914 = utility::getstructarray( "step3_player_orrery_spawn", "targetname" );
    
    foreach ( player in a_teleport_players )
    {
        if ( isalive( player ) )
        {
            player_zone_name = zone_manager::function_90e5c3e2272b0130( player.origin );
            
            if ( isdefined( player_zone_name ) && ( player_zone_name.zone_name == "zone_orrery" || player_zone_name.zone_name == "zone_orrery_upper_floor_active" || player_zone_name.zone_name == "zone_orrery_upper_floor" || player_zone_name.zone_name == "zone_orrery_close_to_courtyard" || player_zone_name.zone_name == "zone_orrery_lower" ) )
            {
                a_teleport_players = arrayremove( a_teleport_players, player );
            }
        }
    }
    
    for ( i = 0; i < a_teleport_players.size ; i++ )
    {
        var_2b43aa5f72b09914[ i ].target = "step3_player_orrery_spawn";
        level thread zm_fasttravel::function_cbb08198e7c84adf( var_2b43aa5f72b09914[ i ], a_teleport_players[ i ] );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xe29fc047, Offset: 0x1139b
// Size: 0xeb
function private function_dd13ffa0a804b8b4()
{
    level endon( #"game_ended" );
    a_s_galileo = utility::getstructarray( "step3_oscar_teleport", "targetname" );
    s_galileo = utility::array_random( a_s_galileo );
    
    if ( isalive( level.ruby_mq.galileo ) )
    {
        level.ruby_mq.galileo zombie_galileo::function_84919f8f8db67077( s_galileo.origin );
    }
    else
    {
        galileo = zm_sat_ruby_galileo::respawn_galileo();
        wait 1;
        level.ruby_mq.galileo zombie_galileo::function_84919f8f8db67077( s_galileo.origin );
    }
    
    wait 3;
    
    if ( level.ruby_mq.galileo )
    {
        level.ruby_mq.galileo zombie_galileo::toggle_enraged( 1 );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x8cb79404, Offset: 0x1148e
// Size: 0x85
function private setup_attractor( player )
{
    level endon( #"game_ended" );
    
    if ( isalive( level.ruby_mq.galileo ) && isalive( player ) )
    {
        lockdown_attractor = zombie_attractor_manager::add_attractor( player, 1, 800, 1, undefined );
    }
    
    wait 3;
    
    if ( isdefined( lockdown_attractor ) && isalive( level.ruby_mq.galileo ) )
    {
        zombie_attractor_manager::remove_attractor( lockdown_attractor );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x8c8ba80d, Offset: 0x1151b
// Size: 0x122
function private function_3fa86b57111d7c08()
{
    level.ruby_mq endon( #"hash_c2e89c89daea2436" );
    level.ruby_mq endon( #"ruby_mq_s3_orrery_defend_success" );
    zombie_type = function_b3988325430ce242( "zombie_base" );
    round_number = zm_round_logic::get_rb_round_number();
    level thread function_bb00f314b8b02574();
    level.ruby_mq.var_7a2fbb0b704f234 = [];
    
    while ( true )
    {
        zone_spawners = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_orrery", "zone_orrery_upper_floor_active", "zone_orrery_upper_floor", "zone_orrery_close_to_courtyard", "zone_orrery_lower" ], zombie_type );
        zmb_spawner = utility::array_random( zone_spawners );
        n_spawn_count = function_b34fa5c9fc817c03();
        var_3074e369eda51ebc = function_baf73fb4dd36629c();
        
        for ( i = 0; i < n_spawn_count ; i++ )
        {
            level function_3ad48ee3c47dfe08( zombie_type, zmb_spawner, round_number );
            wait 0.5;
        }
        
        if ( isdefined( var_3074e369eda51ebc ) )
        {
            wait var_3074e369eda51ebc;
            continue;
        }
        
        wait 1.25;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 3, eflags: 0x4
// Checksum 0x9445227e, Offset: 0x11645
// Size: 0x1ec
function private function_3ad48ee3c47dfe08( zombie_type, spawner, n_difficulty_round )
{
    zombie = agent_manager::spawn_agent( zombie_type, spawner.origin, spawner.angles, "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        zombie.no_powerups = 1;
        zombie zombie_utils::set_zombie_round_difficulty( n_difficulty_round );
        zombie.b_cleanup_no_respawn = 1;
        zombie.var_825b17c932865df = 1;
        zombie.var_15598d8e493afe88 = 1;
        zombie.ignore_enemy_count = 1;
        zombie.b_disable_annihilate = 1;
        zombie.var_5a9c952260ab1cf = 1;
        zombie.var_f7fb30c6fe83c8e3 = 1;
        zombie.kiastring = #"zombie_kia_mission_kill";
        zombie thread agent_spawner::function_ce10e453e7f7bb8e( spawner );
        zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint", "default", 6 );
    }
    
    level.ruby_mq.var_7a2fbb0b704f234[ level.ruby_mq.var_7a2fbb0b704f234.size ] = zombie;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xfd7b836d, Offset: 0x11839
// Size: 0x56
function private function_baf73fb4dd36629c()
{
    switch ( level.players.size )
    {
        case 1:
            return 4;
        case 2:
            return 3;
        case 3:
            return 1.5;
        case 4:
            return 1.5;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xe01ad02f, Offset: 0x11897
// Size: 0x50
function private function_b34fa5c9fc817c03()
{
    switch ( level.players.size )
    {
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            return 3;
        case 4:
            return 3;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x39497a4b, Offset: 0x118ef
// Size: 0xbf
function private function_bb00f314b8b02574()
{
    level endon( #"game_ended" );
    level utility::flag_wait_any( "ruby_mq_orrey_defend_cooldown", "ruby_mq_s3_orrery_defend_success" );
    
    foreach ( zombie in level.ruby_mq.var_7a2fbb0b704f234 )
    {
        if ( isalive( zombie ) )
        {
            zombie thread function_5bbd540197e3fd();
        }
    }
    
    level.ruby_mq.var_7a2fbb0b704f234 = undefined;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0xc
// Checksum 0x3dc73cec, Offset: 0x119b6
// Size: 0xe5
function private function_10bca5f2d3c53a12()
{
    self notify( #"hash_94891b607b1c7df7" );
    self endon( #"hash_94891b607b1c7df7" );
    level.ruby_mq endon( #"game_ended" );
    level.ruby_mq endon( #"hash_c2e89c89daea2436" );
    level.ruby_mq endon( #"ruby_mq_s3_orrery_defend_success" );
    
    while ( true )
    {
        wait 1;
        level.ruby_mq.var_13b373d6d3c7341e++;
        
        if ( level.ruby_mq.var_13b373d6d3c7341e == 80 )
        {
            level thread orrery_defend_success();
            level utility::flag_set( "ruby_mq_s3_orrery_defend_success" );
            level.ruby_mq notify( #"ruby_mq_s3_orrery_defend_success" );
        }
        
        zm_quest::function_9f49b2a045ece8ae( level.ruby_mq.var_13b373d6d3c7341e, 1, #"ruby_mq", #"orrery_defend" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xf83f4e06, Offset: 0x11aa3
// Size: 0x152
function private function_5b667d94d94e2d7()
{
    level endon( #"game_ended" );
    level.ruby_mq endon( #"hash_c2e89c89daea2436" );
    level.ruby_mq endon( #"ruby_mq_s3_orrery_defend_success" );
    var_4e8147706c9c5031 = 120000;
    zm_quest::function_fba942a1cfd85f5d( 1, 1, #"ruby_mq", #"orrery_defend" );
    zm_quest::function_fb3af5600f6a9441( 1, 1, #"ruby_mq", #"orrery_defend" );
    zm_quest::function_9f49b2a045ece8ae( 0, 1, #"ruby_mq", #"orrery_defend" );
    n_time_start_ms = gettime();
    
    while ( true )
    {
        n_time_taken = gettime() - n_time_start_ms;
        n_time_left = var_4e8147706c9c5031 - n_time_taken;
        zm_quest::function_612a9ad0db22c29c( n_time_left, 1, #"ruby_mq", #"orrery_defend" );
        
        if ( n_time_left <= 0 )
        {
            if ( level.ruby_mq.var_13b373d6d3c7341e == 80 )
            {
                level thread orrery_defend_success();
                level utility::flag_set( "ruby_mq_s3_orrery_defend_success" );
                level utility::flag_set( "open_mars_portal" );
                waitframe();
                return;
            }
            
            level thread orrery_defend_failed();
            waitframe();
            level.ruby_mq notify( #"hash_c2e89c89daea2436" );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x2f62147e, Offset: 0x11bfd
// Size: 0xb8
function private function_16beff906a0b5dba()
{
    level endon( #"game_ended" );
    level.ruby_mq endon( #"ruby_mq_s3_orrery_defend_success" );
    
    while ( true )
    {
        if ( level utility::flag( "tp_players_complete" ) )
        {
            return;
        }
        
        if ( level utility::flag( "ruby_mq_orrey_neptune_set" ) && level utility::flag( "ruby_mq_orrey_mars_set" ) && level utility::flag( "ruby_mq_orrey_saturn_set" ) && level utility::flag( "ruby_mq_s3_mars_coord_entered" ) && !level utility::flag( "ruby_mq_orrey_defend_cooldown" ) )
        {
            if ( !level callback::exists( "zm_sat_exfil_vote_initiated", &set_portal_machine_cooldown ) )
            {
                level callback::add( "zm_sat_exfil_vote_initiated", &set_portal_machine_cooldown );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x4fda10ea, Offset: 0x11cbd
// Size: 0xc5
function private set_portal_machine_cooldown( params )
{
    level utility::flag_set( "ruby_mq_orrey_defend_cooldown" );
    level.ruby_mq.var_67253e31ec12284a = zm_round_logic::get_rb_round_number() + 1;
    
    if ( !level callback::exists( "on_round_start", &function_476eac46b139558 ) )
    {
        level callback::add( "on_round_start", &function_476eac46b139558 );
    }
    
    level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "rebooting", "off" );
    level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "cooldown", "on" );
    level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "machine_states", "cooldown" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xc5db83bd, Offset: 0x11d8a
// Size: 0x1b8
function private orrery_defend_failed()
{
    level endon( #"game_ended" );
    wait 1.5;
    level.ruby_mq.var_13b373d6d3c7341e = 0;
    level utility::flag_clear( "ruby_mq_portal_rebooting" );
    level utility::flag_clear( "mq_vo_galileo_lockdown" );
    level utility::flag_set( "ruby_mq_orrey_defend_cooldown" );
    level.ruby_mq.var_67253e31ec12284a = zm_round_logic::get_rb_round_number() + 1;
    level callback::add( "on_round_start", &function_476eac46b139558 );
    level zm_quest::function_fb3af5600f6a9441( 3, 1, #"ruby_mq", #"orrery_defend" );
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"ruby_defend" );
    level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "rebooting", "off" );
    level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "cooldown", "on" );
    level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "machine_states", "cooldown" );
    
    /#
        iprintlnbold( "<dev string:x16f>" );
    #/
    
    level thread function_78ffb6035d984ce2();
    level thread function_d937f21e8aea787();
    
    if ( isalive( level.ruby_mq.galileo ) )
    {
        level.ruby_mq.galileo zombie_galileo::toggle_enraged( 0 );
    }
    
    level thread zm_round_spawning::pause_round_spawning( 0, "ruby_mq_orrery_defend" );
    level thread function_431945df18b2a9f9();
    
    if ( !level callback::exists( "zm_sat_exfil_vote_initiated", &set_portal_machine_cooldown ) )
    {
        level callback::add( "zm_sat_exfil_vote_initiated", &set_portal_machine_cooldown );
    }
    
    wait 2;
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0xa7ba43f, Offset: 0x11f4a
// Size: 0x30
function function_431945df18b2a9f9()
{
    level endon( #"game_ended" );
    wait 2.5;
    level battlechatter_mp::trysaylocalsound( level.players[ 0 ], #"bc_flavor_player_negative" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x623325aa, Offset: 0x11f82
// Size: 0x5f8
function private orrery_defend_success()
{
    level endon( #"game_ended" );
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"ruby_defend" );
    level utility::flag_clear( "mq_vo_galileo_lockdown" );
    level zm_quest::function_fb3af5600f6a9441( 4, 1, #"ruby_mq", #"orrery_defend" );
    level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "machine_states", "cooldown" );
    var_a5b8c8851bdbc5d6 = utility::getstruct( "step3_perfusion_orrery_interact", "targetname" );
    level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "machine_states", "ready" );
    earthquake( 0.5, 7, var_a5b8c8851bdbc5d6.origin, 1000 );
    playrumbleonposition( "artillery_rumble_light", var_a5b8c8851bdbc5d6.origin );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ] val::set( #"ruby_mq", "round_spawning_ignore_player", 1 );
    }
    
    level thread function_e9c3fdbbb8df9b1b();
    
    /#
        iprintlnbold( "<dev string:x17d>" );
    #/
    
    level thread function_9448d8a7ec94c1b7();
    level.ruby_mq.mdl_portal_cap.scr_fx setscriptablepartstate( "intensify", "on" );
    wait 1;
    level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "grow", "on" );
    earthquake( 0.2, 8, var_a5b8c8851bdbc5d6.origin, 1000 );
    playrumbleonposition( "artillery_rumble_light", var_a5b8c8851bdbc5d6.origin );
    wait 4;
    var_c64a90ed71a1016b = utility::getstruct( "step3_portal_dmg_point", "targetname" );
    zombies = getaiarrayinradius( var_c64a90ed71a1016b.origin, 800 );
    
    if ( isdefined( zombies ) )
    {
        foreach ( zombie in zombies )
        {
            zombie thread function_5bbd540197e3fd();
        }
    }
    
    if ( isalive( level.ruby_mq.galileo ) )
    {
        level.ruby_mq.galileo zombie_galileo::toggle_enraged( 0 );
        level.ruby_mq.galileo zombie_stun::stun_ai( 100 );
    }
    
    wait 0.4;
    
    if ( isalive( level.ruby_mq.galileo ) )
    {
        level.ruby_mq.galileo kill();
    }
    
    level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "grow", "off" );
    level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "blast", "on" );
    earthquake( 0.8, 1.5, var_a5b8c8851bdbc5d6.origin, 1000 );
    playrumbleonposition( "artillery_rumble_light", var_a5b8c8851bdbc5d6.origin );
    wait 5.2;
    function_e0fb713d80fae962( level.ruby_mq.scr_portal_energy );
    level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "shrink", "on" );
    earthquake( 0.2, 7, var_a5b8c8851bdbc5d6.origin, 1000 );
    wait 1;
    level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "blast", "off" );
    wait 1.5;
    playrumbleonposition( "artillery_rumble_light", var_a5b8c8851bdbc5d6.origin );
    level thread function_c4f62b1b67032f3d();
    level thread function_d937f21e8aea787();
    zm_quest::function_d7216beb89a22329();
    
    if ( isdefined( level.ruby_mq.var_2f58b2bc7556d331 ) )
    {
        level.ruby_mq.var_2f58b2bc7556d331.mdl_brain delete();
        level.ruby_mq.var_2f58b2bc7556d331 delete();
    }
    
    level utility::flag_set( "tp_players_complete" );
    wait 1.5;
    activateworldevent( "we_lgt_teleporter_orrery" );
    level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "energy", "fade" );
    level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "energy", "off" );
    level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "rebooting", "off" );
    level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "complete", "on" );
    level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "shrink", "off" );
    level.ruby_mq.mdl_portal_cap.scr_fx setscriptablepartstate( "intensify", "off" );
    level.ruby_mq.scr_portal utility::function_7c10ea82c1e305b8( "idle", "idle" );
    zm_blackhole_bomb::function_bcfc2c555363a3b5();
    level utility::flag_set( "enable_mars_zones" );
    zm_quest::function_4eefe6de31f5ddab( #"ruby_mq", #"orrery_puzzle_complete", 1 );
    zm_quest::function_4eefe6de31f5ddab( #"ruby_mq", #"hash_28ff14d33eab4a66", 1 );
    level thread zm_round_spawning::pause_round_spawning( 0, "ruby_mq_orrery_defend" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x142d1776, Offset: 0x12582
// Size: 0xa5
function private function_e9c3fdbbb8df9b1b()
{
    level endon( #"game_ended" );
    level endon( #"hash_683517d0011a12cd" );
    wait 300;
    
    foreach ( player in level.players )
    {
        player val::reset( #"ruby_mq", "round_spawning_ignore_player" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x7e415d8f, Offset: 0x1262f
// Size: 0x2a
function private function_9448d8a7ec94c1b7()
{
    level endon( #"game_ended" );
    wait 8.75;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_9d8e5223ce3ad25c" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x20eda292, Offset: 0x12661
// Size: 0xca
function private function_e0fb713d80fae962( portal_energy )
{
    level endon( #"game_ended" );
    zm_quest::function_d7216beb89a22329();
    utility::callsharedfunc( #"mutant_injection", #"force_exit_mutant_injection", 1 );
    zm_fasttravel::function_8649f9a98d2d9ce3();
    
    foreach ( player in level.players )
    {
        if ( player && isalive( player ) )
        {
            player childthread function_3a7076f5c015e04b( portal_energy );
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x619fe72f, Offset: 0x12733
// Size: 0x17e
function private function_3a7076f5c015e04b( portal_energy )
{
    self endon( #"death_or_disconnect" );
    
    if ( utility::ent_flag( "field_upgrade_in_use" ) )
    {
        field_upgrades_aether_shroud::function_63c791098b816b7();
    }
    
    utility::ent_flag_set( "interrupt_dark_flare" );
    val::group_set( "RUBY_MQ_PATH_TO_PORTAL", 0 );
    self canceloffhands();
    self releaseoffhand();
    self stopanimscriptsceneevent();
    self stopgestureviewmodel();
    
    if ( self isviewmodelanimplaying() )
    {
        self stopviewmodelanim();
    }
    
    waitframe();
    utility::ent_flag_set( "fly_to_portal" );
    self.var_a0a7c59ebb4a786 = utility::spawn_tag_origin( self.origin, self getplayerangles() );
    childthread inventory_utility::givegunlessweapon();
    
    while ( inventory_utility::isanymonitoredweaponswitchinprogress() )
    {
        waitframe();
    }
    
    pbgpostfxbundlestart( self, "sat_zm_warp_buildup" );
    actor = anim_scene::anim_scene_create_actor( self, "player", 1, 0 );
    actor.angles = self.angles;
    create_player_rig( actor );
    childthread function_bb989d2829a59d38( actor );
    self playrumblelooponentity( "low_highfreq" );
    childthread path_to_portal( portal_energy, 2.75 );
    utility::ent_flag_waitopen_any( "fly_to_portal" );
    val::group_reset( "RUBY_MQ_PATH_TO_PORTAL" );
    thread inventory_utility::takegunlessweapon();
    self stoprumble( "low_highfreq" );
    utility::ent_flag_clear( "interrupt_dark_flare" );
    waitframe();
    pbgpostfxbundlekill( self, "sat_zm_warp_buildup" );
    self unlink( 1 );
    
    if ( self.var_a0a7c59ebb4a786 )
    {
        self.var_a0a7c59ebb4a786 delete();
        self.var_a0a7c59ebb4a786 = undefined;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xa18fa8bf, Offset: 0x128b9
// Size: 0x235
function private path_to_portal( portal_energy, pull_time )
{
    self endon( #"teleporting" );
    
    if ( !isvector( portal_energy.origin ) )
    {
        return;
    }
    
    var_bd05d7d9e27b5654 = gettime();
    t = 0;
    start_pos = self.origin;
    pull_loc = portal_energy.origin - ( 0, 0, 30 );
    var_932d61b99cf3af2e = pull_time * 0.55;
    
    do
    {
        pull_loc = function_8c636abfd16dedd5( pull_loc );
        var_a7a07fd68c40069f = utility::function_6f5d2e1f1ff70482( gettime() - var_bd05d7d9e27b5654 );
        
        if ( t <= var_932d61b99cf3af2e )
        {
            t = var_a7a07fd68c40069f / pull_time;
            op1 = pow( 1 - t, 2 );
            op2 = 2 * ( 1 - t ) * t;
            op3 = pow( t, 2 );
            var_2fb471fdf223d6f2 = vectornormalize( pull_loc - start_pos );
            halfway_pos = ( start_pos + pull_loc ) / 2;
            control_point = halfway_pos - var_2fb471fdf223d6f2 * 100;
            xdest = op1 * start_pos[ 0 ] + op2 * control_point[ 0 ] + op3 * pull_loc[ 0 ];
            ydest = op1 * start_pos[ 1 ] + op2 * control_point[ 1 ] + op3 * pull_loc[ 1 ];
            zdest = op1 * start_pos[ 2 ] + op2 * control_point[ 2 ] + op3 * pull_loc[ 2 ];
            var_3ae8592280b43fb6 = ( xdest, ydest, zdest );
            self.var_a0a7c59ebb4a786 moveto( var_3ae8592280b43fb6, t + 0.01 );
            self.var_a0a7c59ebb4a786 rotateto( vectortoangles( vectornormalize( pull_loc - self.var_a0a7c59ebb4a786.origin ) ), pull_time );
        }
        
        waitframe();
    }
    while ( self.var_a0a7c59ebb4a786 && var_a7a07fd68c40069f < var_932d61b99cf3af2e );
    
    var_349629e35e235ebc = pull_time - var_932d61b99cf3af2e;
    pull_loc = function_8c636abfd16dedd5( pull_loc );
    
    if ( self.var_a0a7c59ebb4a786 )
    {
        self.var_a0a7c59ebb4a786 moveto( pull_loc, var_349629e35e235ebc );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x649aad7a, Offset: 0x12af6
// Size: 0xee
function private function_8c636abfd16dedd5( target_pos )
{
    var_f06c3d8143b76949 = self geteye();
    chest_pos = ( self.origin + var_f06c3d8143b76949 ) * 0.5;
    foot_pos = self.origin;
    head_trace = trace::ray_trace( var_f06c3d8143b76949, target_pos, self );
    chest_trace = trace::ray_trace( chest_pos, target_pos, self );
    foot_trace = trace::ray_trace( foot_pos, target_pos, self );
    trace = head_trace;
    
    if ( chest_trace[ "fraction" ] < trace[ "fraction" ] )
    {
        trace = chest_trace;
    }
    
    if ( foot_trace[ "fraction" ] < trace[ "fraction" ] )
    {
        trace = foot_trace;
    }
    
    if ( trace[ "fraction" ] < 1 )
    {
        safe_pos = trace[ "position" ] + trace[ "normal" ] * -4;
        return safe_pos;
    }
    
    return target_pos;
}

#using_animtree( "zm_t10_ruby_scriptables" );

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0xf4602903, Offset: 0x12bed
// Size: 0x176
function create_player_rig( actor )
{
    if ( !utility::ent_flag_exist( "animating" ) )
    {
        utility::ent_flag_init( "animating" );
    }
    
    utility::ent_flag_set( "animating" );
    actor.player_rig = spawn( "script_arms", self.origin, 0, 0, self );
    actor.player_rig.animname = actor.animname;
    actor.player_rig useanimtree( #animtree );
    actor.player_rig.entity = self;
    actor.player_rig.updatedversion = 1;
    player_ang = self getplayerangles();
    self setplayerangles( ( 0, player_ang[ 1 ], player_ang[ 2 ] ) );
    actor.player_rig.angles = self getplayerangles();
    self.var_a0a7c59ebb4a786.angles = self getplayerangles();
    self setstance( actor.entity.anim_scene_stance_override ?? "stand" );
    self playerlinktoabsolute( actor.player_rig, "tag_player" );
    actor.player_rig linkto( self.var_a0a7c59ebb4a786 );
    actor.player_rig hide();
    thread function_630203ad8b2c6680( actor );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xbdf2a7d1, Offset: 0x12d6b
// Size: 0x5f
function private function_630203ad8b2c6680( actor )
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( actor.player_rig )
        {
            if ( self getcamerathirdperson() )
            {
                actor.player_rig hide();
            }
            else
            {
                actor.player_rig showonlytoplayer( self );
            }
        }
        else
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x5d20856f, Offset: 0x12dd2
// Size: 0x8c
function private function_bb989d2829a59d38( actor )
{
    self endon( #"death_or_disconnect" );
    self.var_a0a7c59ebb4a786 thread anim_scene::anim_scene_loop( [ actor ], "player_sucked_in", 0, 0, undefined );
    utility::ent_flag_waitopen_any( "fly_to_portal" );
    self.var_a0a7c59ebb4a786 anim_scene::anim_scene_stop();
    self stopanimscriptsceneevent();
    utility::ent_flag_clear( "animating" );
    val::reset_all( "anim_scene" );
    actor.player_rig delete();
    actor.player_rig = undefined;
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xc5df4e1, Offset: 0x12e66
// Size: 0x56
function private init_path_to_portal_anims()
{
    level.scr_animtree[ "player" ] = #animtree;
    level.scr_anim[ "player" ][ "player_sucked_in" ][ 0 ] = %sat_mp_strafe_fast_jump_air_8;
    level.scr_eventanim[ "player" ][ "player_sucked_in" ][ 0 ] = %"sat_mp_strafe_fast_jump_air_8";
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x6261215d, Offset: 0x12ec4
// Size: 0xaa
function private function_c4f62b1b67032f3d()
{
    var_2b43aa5f72b09914 = utility::getstructarray( "step4_player_mars_spawn", "targetname" );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ] playsoundtoplayer( "evt_mq_portal_teleport", level.players[ i ] );
        var_2b43aa5f72b09914[ i ].target = "step4_player_mars_spawn";
        level thread zm_fasttravel::function_cbb08198e7c84adf( var_2b43aa5f72b09914[ i ], level.players[ i ] );
        level.players[ i ] thread utility::ent_flag_clear_delayed( "fly_to_portal", 0.5 );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x69bb917d, Offset: 0x12f76
// Size: 0xdd
function init_defend_event_doors()
{
    a_doors = getentarray( "mq_defend_event_door", "targetname" );
    
    foreach ( door in a_doors )
    {
        door.v_close_ang = door.angles;
        door.var_c469cbb9729b47aa = utility::getstruct( door.target, "targetname" ).angles;
        door rotateto( door.var_c469cbb9729b47aa, 0.5 );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xe4233f87, Offset: 0x1305b
// Size: 0x168
function private function_8878884517e2c350()
{
    a_doors_telescope = getentarray( "doorbuy_door_orrery_to_telescope", "targetname" );
    a_doors_yard = getentarray( "doorbuy_door_orrery_to_yard", "targetname" );
    var_7cb2bc0432650d9f = getentarray( "mq_defend_event_door", "targetname" );
    level.var_5bc1b3a11e395b27 = arraycombine( a_doors_telescope, a_doors_yard, var_7cb2bc0432650d9f );
    
    foreach ( door in level.var_5bc1b3a11e395b27 )
    {
        door rotateto( door.v_close_ang, 0.5 );
    }
    
    foreach ( col in level.ruby_mq.var_a86e452329d24960 )
    {
        col disconnectpaths();
        col solid();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x8582a57a, Offset: 0x131cb
// Size: 0x11c
function private function_d937f21e8aea787()
{
    if ( isdefined( level.var_5bc1b3a11e395b27 ) )
    {
        foreach ( door in level.var_5bc1b3a11e395b27 )
        {
            door rotateto( door.var_c469cbb9729b47aa, 0.5 );
        }
    }
    
    foreach ( col in level.ruby_mq.var_a86e452329d24960 )
    {
        col connectpaths();
        col notsolid();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x74c8ced6, Offset: 0x132ef
// Size: 0x4c
function private galileo_drone_spawner()
{
    level endon( #"game_ended" );
    level.ruby_mq endon( #"hash_c2e89c89daea2436" );
    level.ruby_mq endon( #"ruby_mq_s3_orrery_defend_success" );
    
    while ( true )
    {
        level thread function_3e2591523879e95f();
        wait 6.5;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x792bdd8b, Offset: 0x13343
// Size: 0x12c
function private function_3e2591523879e95f()
{
    if ( isalive( level.ruby_mq.galileo ) )
    {
        var_ddf17f01750c5a57 = get_lockdown_drone_count();
        var_4e257c099de6f14f = level.ruby_mq.galileo zombie_galileo::spawn_portal_drones( var_ddf17f01750c5a57 );
        
        foreach ( galileodrone in var_4e257c099de6f14f )
        {
            level.ruby_mq.var_a1dbdfa1e6ea7979[ level.ruby_mq.var_a1dbdfa1e6ea7979.size ] = galileodrone;
            galileodrone solid();
            galileodrone setcandamage( 1 );
            galileodrone.health = 30;
            galileodrone.bisalive = 1;
            galileodrone thread function_e84de51987581857();
            galileodrone thread galileo_drone_dmg_watcher();
            galileodrone thread function_33b592a92ca30e7e();
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x387deb9a, Offset: 0x13477
// Size: 0x15c
function private function_fb7cfde8288de93e()
{
    level endon( #"game_ended" );
    level utility::flag_wait_any( "ruby_mq_s3_orrery_defend_success", "ruby_mq_orrey_defend_cooldown" );
    
    if ( isdefined( level.ruby_mq.var_a1dbdfa1e6ea7979 ) )
    {
        foreach ( drone in level.ruby_mq.var_a1dbdfa1e6ea7979 )
        {
            if ( isdefined( drone ) && drone.bisalive == 1 )
            {
                drone.var_7eeca3426600cbba.sc_fx setscriptablepartstate( "visual", "hidden" );
                drone.bisalive = 0;
                drone.var_7eeca3426600cbba.sc_drone setscriptablepartstate( "death", "death" );
                drone.var_7eeca3426600cbba.sc_drone setscriptablepartstate( "movement_audio", "off" );
                drone delete();
            }
        }
        
        level.ruby_mq.var_a1dbdfa1e6ea7979 = undefined;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xd54af891, Offset: 0x135db
// Size: 0x50
function private get_lockdown_drone_count()
{
    switch ( level.players.size )
    {
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            return 2;
        case 4:
            return 2;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xbe518262, Offset: 0x13633
// Size: 0x128
function private galileo_drone_dmg_watcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, vhitdir, var_8bc0ee7f93665fd1, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isplayer( eattacker ) )
        {
            if ( isdefined( self ) && self.health <= 0 )
            {
                self playsoundonmovingent( "evt_mq_oscar_drone_hit_impact" );
                self.bisalive = 0;
                self.var_7eeca3426600cbba.sc_fx setscriptablepartstate( "visual", "hidden" );
                self.var_7eeca3426600cbba.sc_drone setscriptablepartstate( "death", "death" );
                self.var_7eeca3426600cbba.sc_drone setscriptablepartstate( "movement_audio", "off" );
                self delete();
                return;
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x3516ce8f, Offset: 0x13763
// Size: 0x223
function private function_7168156cdc157381()
{
    v_org = self.origin;
    v_dest = level.ruby_mq.s_portal_dmg_point.origin;
    var_92b21ca8efb6aef2 = distance2dsquared( v_dest, v_org );
    self.var_7eeca3426600cbba = utility::spawn_model( "tag_origin", v_org );
    self.var_7eeca3426600cbba.sc_fx = spawnscriptable( %"ruby_mq_lockdown_galileo_drone_trail", self.var_7eeca3426600cbba.origin );
    self.var_7eeca3426600cbba.sc_drone = spawnscriptable( %"ruby_mq_lockdown_galileo_drone", self.var_7eeca3426600cbba.origin );
    waitframe();
    
    if ( isdefined( self.var_7eeca3426600cbba.sc_fx ) )
    {
        self.var_7eeca3426600cbba.sc_fx utility::scriptable_setparententity( self.var_7eeca3426600cbba );
        self.var_7eeca3426600cbba.sc_fx setscriptablepartstate( "visual", "energy_trail" );
    }
    
    self.var_7eeca3426600cbba.sc_drone utility::scriptable_setparententity( self.var_7eeca3426600cbba );
    self.var_7eeca3426600cbba.sc_drone setscriptablepartstate( "base", "base_on" );
    self.var_7eeca3426600cbba.sc_drone setscriptablepartstate( "movement_audio", "on" );
    thread function_bf918af364079cfe( self.var_7eeca3426600cbba.sc_fx );
    self.var_7eeca3426600cbba moveto( v_dest, 5 );
    self.var_7eeca3426600cbba waittill( #"movedone" );
    
    if ( isdefined( self.var_7eeca3426600cbba.sc_fx ) )
    {
        self.var_7eeca3426600cbba.sc_fx setscriptablepartstate( "impact", "collect" );
        self.var_7eeca3426600cbba.sc_fx freescriptable();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x5b9b9954, Offset: 0x1398e
// Size: 0x67
function private function_bf918af364079cfe( scr_trail )
{
    level.ruby_mq endon( #"hash_c2e89c89daea2436" );
    level.ruby_mq endon( #"ruby_mq_s3_orrery_defend_success" );
    
    while ( true )
    {
        if ( !isdefined( self ) && isdefined( scr_trail ) )
        {
            scr_trail setscriptablepartstate( "visual", "hidden" );
            scr_trail freescriptable();
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x6278cf4e, Offset: 0x139fd
// Size: 0x103
function private function_e84de51987581857()
{
    level.ruby_mq.s_portal_dmg_point = utility::getstruct( "step3_portal_dmg_point", "targetname" );
    
    if ( isdefined( self ) )
    {
        thread function_7168156cdc157381();
        self moveto( level.ruby_mq.s_portal_dmg_point.origin, 5 );
        self waittill( #"movedone" );
        
        if ( isdefined( self ) )
        {
            self.bisalive = 0;
            self.var_7eeca3426600cbba.sc_fx setscriptablepartstate( "visual", "hidden" );
            self.var_7eeca3426600cbba.sc_drone setscriptablepartstate( "death", "death" );
            self.var_7eeca3426600cbba.sc_drone setscriptablepartstate( "movement_audio", "off" );
            level.ruby_mq.scr_portal_energy utility::function_7c10ea82c1e305b8( "impact", "on" );
            self delete();
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xa5310428, Offset: 0x13b08
// Size: 0x101
function private function_33b592a92ca30e7e()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( isdefined( self ) && self istouching( level.ruby_mq.var_7aa904e1275e0970 ) )
        {
            level.ruby_mq.var_13b373d6d3c7341e -= 8;
            
            if ( level.ruby_mq.var_13b373d6d3c7341e <= 0 )
            {
                level.ruby_mq.var_13b373d6d3c7341e = 0;
                zm_quest::function_9f49b2a045ece8ae( level.ruby_mq.var_13b373d6d3c7341e, 1, #"ruby_mq", #"orrery_defend" );
            }
            else
            {
                zm_quest::function_9f49b2a045ece8ae( level.ruby_mq.var_13b373d6d3c7341e, 1, #"ruby_mq", #"orrery_defend" );
            }
            
            /#
                iprintlnbold( "<dev string:x19b>" );
            #/
            
            wait 2.5;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x23f145b9, Offset: 0x13c11
// Size: 0x8b
function private function_476eac46b139558( params )
{
    level.ruby_mq.var_82968f365563f93c setscriptablepartstate( "initialize", "on" );
    level.ruby_mq.var_82968f365563f93c utility::function_7c10ea82c1e305b8( "machine_states", "initiated" );
    level.ruby_mq.var_67253e31ec12284a = undefined;
    level utility::flag_clear( "ruby_mq_orrey_defend_cooldown" );
    level callback::remove( "on_round_start", &function_476eac46b139558 );
    function_4ef47d3c5c627fb6();
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x452e011, Offset: 0x13ca4
    // Size: 0x5, Type: dev
    function private function_df5b4a6dfc8eeab2()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x9e3b9def, Offset: 0x13cb1
// Size: 0x299
function function_e0386b29059b3625( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        var_96c44786820fcb47 = utility::getstruct( "step4_perfusion_mars_falling", "targetname" );
        playfx( utility::getfx( "ruby_mq_voss_portal" ), var_96c44786820fcb47.origin );
        playsoundatpos( var_96c44786820fcb47.origin, "evt_mq_perfusion_machine_spawn_mars" );
        wait 0.7;
        level.ruby_mq.var_105692e0b71dccca = utility::getstruct( "step4_perfusion_mars_starting", "targetname" );
        level.ruby_mq.var_b7a2a512051b1684 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", var_96c44786820fcb47.origin + ( 0, 0, 90 ), var_96c44786820fcb47.angles );
        level.ruby_mq.var_b7a2a512051b1684.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", level.ruby_mq.var_b7a2a512051b1684.origin + ( 11, -6, -1.75 ), level.ruby_mq.var_b7a2a512051b1684.angles + ( 3, 247, -98 ) );
        level.ruby_mq.var_b7a2a512051b1684.mdl_brain linkto( level.ruby_mq.var_b7a2a512051b1684 );
        level.ruby_mq.var_b7a2a512051b1684 setscriptablepartstate( "idle", "on" );
        level.ruby_mq.var_b7a2a512051b1684 moveto( level.ruby_mq.var_105692e0b71dccca.origin, 4, 0.05, 0.75 );
        level.ruby_mq.var_b7a2a512051b1684 waittill( #"movedone" );
        var_6cc7d814e583cd9b = interaction::register_interact( level.ruby_mq.var_105692e0b71dccca.origin, 100, &function_c1ad93b183bbbecd );
        var_6cc7d814e583cd9b sethintonobstruction( "show" );
        var_6cc7d814e583cd9b interaction::set_interact_hint_callback( &function_da18b8382b9d5723 );
        var_6cc7d814e583cd9b thread function_58a6ac7ea4079719();
        return;
    }
    
    level thread function_a59f13398a50fd4d();
    level thread setup_perfusion_machine_mars();
    level utility::flag_wait( "ruby_mq_s3_orrery_defend_success" );
    level utility::flag_wait( "ruby_mq_perfusion_placed_mars" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x14580940, Offset: 0x13f52
// Size: 0x204
function cleanup_step_11( b_skipped, b_save_restored )
{
    level thread zm_sat_ruby::function_620114dd2340ecc4();
    
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "ruby_mq_perfusion_placed_mars" );
        level utility::flag_set( "open_mars_to_observatory_portal" );
        level utility::flag_set( "open_mars_portal" );
        level utility::flag_set( "ruby_mq_bells_reset" );
        
        if ( isdefined( level.ruby_mq.var_b7a2a512051b1684 ) )
        {
            level.ruby_mq.var_b7a2a512051b1684.mdl_brain delete();
            level.ruby_mq.var_b7a2a512051b1684 delete();
        }
        
        level thread setup_perfusion_machine_mars();
        level.ruby_mq.var_6bcff70ff5ad2a57 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", level.ruby_mq.var_3150bc6e12cf8a52.origin, level.ruby_mq.var_3150bc6e12cf8a52.angles );
        level.ruby_mq.var_6bcff70ff5ad2a57 solid();
        level.ruby_mq.var_6bcff70ff5ad2a57.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", level.ruby_mq.var_6bcff70ff5ad2a57.origin + ( 0, 0, 11 ), level.ruby_mq.var_6bcff70ff5ad2a57.angles + ( 0, 90, 0 ) );
        level.ruby_mq.var_6bcff70ff5ad2a57.mdl_brain linkto( level.ruby_mq.var_6bcff70ff5ad2a57 );
        level.ruby_mq.var_6bcff70ff5ad2a57 setscriptablepartstate( "idle", "on" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xb9360e81, Offset: 0x1415e
// Size: 0x21
function private function_58a6ac7ea4079719()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "ruby_mq_perfusion_placed_mars" );
    self delete();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x7daeda22, Offset: 0x14187
// Size: 0x53
function private function_48516040df55382a()
{
    var_4455616196599590 = utility::getstruct( "step4_perfusion_connect_off", "targetname" );
    level.ruby_mq.var_199cdbe1095db27a = utility::spawn_model( "sat_zm_perfusion_machine_wire_02_unconnect", var_4455616196599590.origin, var_4455616196599590.angles );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x23327c75, Offset: 0x141e2
// Size: 0x29c
function private function_a59f13398a50fd4d()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "ruby_mq_s3_orrery_defend_success" );
    level utility::flag_wait( "tp_players_complete" );
    level thread function_4fffa5a2693892d3();
    wait 12;
    var_96c44786820fcb47 = utility::getstruct( "step4_perfusion_mars_falling", "targetname" );
    playfx( utility::getfx( "ruby_mq_voss_portal" ), var_96c44786820fcb47.origin );
    playsoundatpos( var_96c44786820fcb47.origin, "evt_mq_perfusion_machine_spawn_mars" );
    wait 0.7;
    level.ruby_mq.var_105692e0b71dccca = utility::getstruct( "step4_perfusion_mars_starting", "targetname" );
    level.ruby_mq.var_b7a2a512051b1684 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", var_96c44786820fcb47.origin + ( 0, 0, 90 ), var_96c44786820fcb47.angles );
    level.ruby_mq.var_b7a2a512051b1684.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", level.ruby_mq.var_b7a2a512051b1684.origin + ( 11, -6, -1.75 ), level.ruby_mq.var_b7a2a512051b1684.angles + ( 3, 247, -98 ) );
    level.ruby_mq.var_b7a2a512051b1684.mdl_brain linkto( level.ruby_mq.var_b7a2a512051b1684 );
    level.ruby_mq.var_b7a2a512051b1684 setscriptablepartstate( "idle", "on" );
    waitframe();
    level thread function_b1207fade679f4e3();
    level.ruby_mq.var_b7a2a512051b1684 moveto( level.ruby_mq.var_105692e0b71dccca.origin, 4, 0.05, 0.75 );
    level.ruby_mq.var_b7a2a512051b1684 waittill( #"movedone" );
    var_6cc7d814e583cd9b = interaction::register_interact( level.ruby_mq.var_105692e0b71dccca.origin, 100, &function_c1ad93b183bbbecd );
    var_6cc7d814e583cd9b sethintonobstruction( "show" );
    var_6cc7d814e583cd9b interaction::set_interact_hint_callback( &function_da18b8382b9d5723 );
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_perfusion_placed_mars" );
    var_6cc7d814e583cd9b delete();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0xd6b501ad, Offset: 0x14486
// Size: 0x252
function function_20d823d5aa69a9a0( spawn_position )
{
    level utility::flag_set( "ruby_mq_step_11_perfusion_machine_dropped" );
    level.ruby_mq.var_b7a2a512051b1684 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", spawn_position );
    level.ruby_mq.var_b7a2a512051b1684 setscriptablepartstate( "idle", "on" );
    spawn_pos = level.ruby_mq.var_b7a2a512051b1684 gettagorigin( "tag_container_brain" );
    spawn_angles = level.ruby_mq.var_b7a2a512051b1684 gettagangles( "tag_container_brain" ) + ( 0, 90, 0 );
    level.ruby_mq.var_b7a2a512051b1684.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", spawn_pos, spawn_angles );
    level.ruby_mq.var_b7a2a512051b1684.mdl_brain linkto( level.ruby_mq.var_b7a2a512051b1684, "tag_container_brain" );
    level utility::flag_clear( "ruby_mq_voss_mars_start_picked" );
    
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "ruby_mq_voss_mars_start_picked" ) )
        {
            player utility::ent_flag_clear( "ruby_mq_voss_mars_start_picked" );
        }
    }
    
    level.ruby_mq.var_b7a2a512051b1684.interact = interaction::register_interact( spawn_position + ( 0, 0, 10 ), 100, &function_1ed964f40e44b170 );
    level.ruby_mq.var_b7a2a512051b1684.interact sethintonobstruction( "show" );
    level.ruby_mq.var_b7a2a512051b1684.interact interaction::set_interact_hint_callback( &function_773abb17a029beba );
    level thread function_51f8ab8fdd978654();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x808e4b09, Offset: 0x146e0
// Size: 0x310
function function_51f8ab8fdd978654()
{
    level endon( #"ruby_mq_voss_mars_start_picked" );
    level endon( #"game_ended" );
    wait 120;
    
    if ( isdefined( level.ruby_mq.var_b7a2a512051b1684.mdl_brain ) )
    {
        level.ruby_mq.var_b7a2a512051b1684.mdl_brain unlink();
        level.ruby_mq.var_b7a2a512051b1684.mdl_brain delete();
    }
    
    if ( isdefined( level.ruby_mq.var_b7a2a512051b1684.interact ) )
    {
        level.ruby_mq.var_b7a2a512051b1684.interact delete();
    }
    
    if ( isdefined( level.ruby_mq.var_b7a2a512051b1684 ) )
    {
        level.ruby_mq.var_b7a2a512051b1684 delete();
    }
    
    var_96c44786820fcb47 = utility::getstruct( "step4_perfusion_mars_falling", "targetname" );
    playfx( utility::getfx( "ruby_mq_voss_portal" ), var_96c44786820fcb47.origin );
    playsoundatpos( var_96c44786820fcb47.origin, "evt_mq_perfusion_machine_spawn_mars" );
    wait 0.7;
    level.ruby_mq.var_105692e0b71dccca = utility::getstruct( "step4_perfusion_mars_starting", "targetname" );
    level.ruby_mq.var_b7a2a512051b1684 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", var_96c44786820fcb47.origin + ( 0, 0, 90 ), var_96c44786820fcb47.angles );
    level.ruby_mq.var_b7a2a512051b1684 setscriptablepartstate( "idle", "on" );
    level.ruby_mq.var_b7a2a512051b1684.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", level.ruby_mq.var_b7a2a512051b1684.origin + ( 11, -6, -1.75 ), level.ruby_mq.var_b7a2a512051b1684.angles + ( 3, 247, -98 ) );
    level.ruby_mq.var_b7a2a512051b1684.mdl_brain linkto( level.ruby_mq.var_b7a2a512051b1684 );
    level.ruby_mq.var_b7a2a512051b1684 moveto( level.ruby_mq.var_105692e0b71dccca.origin, 4, 0.05, 0.75 );
    level.ruby_mq.var_b7a2a512051b1684 waittill( #"movedone" );
    level.ruby_mq.var_b7a2a512051b1684 solid();
    level utility::flag_clear( "ruby_mq_step_11_perfusion_machine_dropped" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x437d1d13, Offset: 0x149f8
// Size: 0xde
function private function_4fffa5a2693892d3()
{
    level endon( #"game_ended" );
    wait 6.5;
    
    foreach ( player in level.players )
    {
        if ( player zm_vo::is_hero_operator() )
        {
            player thread zm_vo::function_8c1a12974bd11f01( #"hash_8f1417e304f5a2fa", #"bc_flavor_player_positive" );
            return;
        }
    }
    
    if ( isdefined( level.players[ 0 ] ) )
    {
        level.players[ 0 ] thread zm_vo::function_8c1a12974bd11f01( #"hash_8f1417e304f5a2fa", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xa55ac8b3, Offset: 0x14ade
// Size: 0x2a
function private function_b1207fade679f4e3()
{
    level endon( #"game_ended" );
    wait 0.3;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_c8948247415eacf0" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xd557d571, Offset: 0x14b10
// Size: 0x3ba
function private function_c1ad93b183bbbecd( player )
{
    if ( level utility::flag( "ruby_mq_step_11_perfusion_machine_dropped" ) )
    {
        return;
    }
    
    if ( level utility::flag( "ruby_mq_voss_mars_start_picked" ) && player utility::ent_flag( "ruby_mq_voss_mars_start_picked" ) )
    {
        player utility::ent_flag_clear( "ruby_mq_voss_mars_start_picked" );
        level utility::flag_clear( "ruby_mq_voss_mars_start_picked" );
        player playsoundtoplayer( "evt_mq_perfusion_machine_pickup", player );
        player notify( #"hash_a32b32af9724c297" );
        
        /#
            iprintlnbold( "<dev string:x1ae>" );
        #/
        
        player function_ea846a83d774cd42();
        level.ruby_mq.var_b7a2a512051b1684 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", level.ruby_mq.var_105692e0b71dccca.origin, level.ruby_mq.var_105692e0b71dccca.angles );
        level.ruby_mq.var_b7a2a512051b1684 solid();
        spawn_pos = level.ruby_mq.var_b7a2a512051b1684 gettagorigin( "tag_container_brain" );
        spawn_angles = level.ruby_mq.var_b7a2a512051b1684 gettagangles( "tag_container_brain" ) + ( 0, 90, 0 );
        level.ruby_mq.var_b7a2a512051b1684.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", spawn_pos, spawn_angles );
        level.ruby_mq.var_b7a2a512051b1684.mdl_brain linkto( level.ruby_mq.var_b7a2a512051b1684 );
        level.ruby_mq.var_b7a2a512051b1684 setscriptablepartstate( "idle", "on" );
        
        if ( player utility::ent_flag( "ruby_mq_slower" ) )
        {
            player weapons::removeextramovespeed( "ruby_mq" );
            
            if ( player common::function_8ff835bf23198a0( "ruby_mq" ) )
            {
                player common::function_d85a92c557ea5a52( "ruby_mq" );
            }
            
            player weapons::updatemovespeedscale();
            player.var_ff2e0673e13ac2ee = 0;
            player val::reset_all( "carrying_perfusion_machine" );
            player utility::ent_flag_clear( "ruby_mq_slower" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "ruby_mq_voss_mars_start_picked" ) && !player utility::ent_flag( "ruby_mq_voss_mars_start_picked" ) )
    {
        /#
            iprintlnbold( "<dev string:x1d0>" );
        #/
        
        player playsoundtoplayer( "evt_mq_perfusion_machine_pickup", player );
        player set_perfusion_on_player();
        level.ruby_mq.var_b7a2a512051b1684.mdl_brain delete();
        level.ruby_mq.var_b7a2a512051b1684 delete();
        level utility::flag_set( "ruby_mq_voss_mars_start_picked" );
        player utility::ent_flag_set( "ruby_mq_voss_mars_start_picked" );
        player thread function_97457287a16a3f9a();
        level thread function_ca26a1e4f862f4cf();
        function_4ef47d3c5c627fb6();
        
        if ( !player utility::ent_flag( "ruby_mq_slower" ) )
        {
            var_e58d7a4f046100e2 = -0.25;
            player weapons::addextramovespeed( "ruby_mq", var_e58d7a4f046100e2 );
            
            if ( !player common::function_8ff835bf23198a0( "ruby_mq" ) )
            {
                player common::function_ac4bf3256b2545e3( "ruby_mq", var_e58d7a4f046100e2 );
            }
            
            player weapons::updatemovespeedscale();
            player_vals = [ "sprint", "remote_killstreaks", "crouch", "prone" ];
            player.var_ff2e0673e13ac2ee = 1;
            player val::set_array( "carrying_perfusion_machine", player_vals, 0 );
            player utility::ent_flag_set( "ruby_mq_slower" );
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0xf2bf1cb1, Offset: 0x14ed2
// Size: 0x159
function function_1ed964f40e44b170( player )
{
    /#
        iprintlnbold( "<dev string:x1d0>" );
    #/
    
    player playsoundtoplayer( "evt_mq_perfusion_machine_pickup", player );
    player set_perfusion_on_player();
    level.ruby_mq.var_b7a2a512051b1684.mdl_brain delete();
    level.ruby_mq.var_b7a2a512051b1684 delete();
    level utility::flag_set( "ruby_mq_voss_mars_start_picked" );
    player utility::ent_flag_set( "ruby_mq_voss_mars_start_picked" );
    level utility::flag_clear( "ruby_mq_step_11_perfusion_machine_dropped" );
    player thread function_97457287a16a3f9a();
    
    if ( !player utility::ent_flag( "ruby_mq_slower" ) )
    {
        var_e58d7a4f046100e2 = -0.25;
        player weapons::addextramovespeed( "ruby_mq", var_e58d7a4f046100e2 );
        
        if ( !player common::function_8ff835bf23198a0( "ruby_mq" ) )
        {
            player common::function_ac4bf3256b2545e3( "ruby_mq", var_e58d7a4f046100e2 );
        }
        
        player weapons::updatemovespeedscale();
        player_vals = [ "sprint", "remote_killstreaks", "crouch", "prone" ];
        player.var_ff2e0673e13ac2ee = 1;
        player val::set_array( "carrying_perfusion_machine", player_vals, 0 );
        player utility::ent_flag_set( "ruby_mq_slower" );
    }
    
    self delete();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x95dc9952, Offset: 0x15033
// Size: 0x27
function private function_ca26a1e4f862f4cf()
{
    level endon( #"game_ended" );
    wait 1;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_dd6b688cacb8a8b7" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x7fa32be4, Offset: 0x15062
// Size: 0x40
function function_773abb17a029beba( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xbb69e38d, Offset: 0x150ab
// Size: 0x99
function private function_da18b8382b9d5723( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled && !utility::flag( "ruby_mq_voss_mars_start_picked" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/pick_up", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xecef17fa, Offset: 0x1514c
// Size: 0xb9
function private setup_perfusion_machine_mars()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "ruby_mq_s3_orrery_defend_success" );
    level.ruby_mq.var_3150bc6e12cf8a52 = utility::getstruct( "step4_perfusion_mars_interact", "targetname" );
    level.ruby_mq.perfusion_mars_interact = interaction::register_interact( level.ruby_mq.var_3150bc6e12cf8a52.origin, 100, &function_3d333ee1c5303c3b );
    level.ruby_mq.perfusion_mars_interact sethintonobstruction( "show" );
    level.ruby_mq.perfusion_mars_interact interaction::set_interact_hint_callback( &perfusion_mars_interact_hint );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x96bd2c7a, Offset: 0x1520d
// Size: 0x5c8
function private function_3d333ee1c5303c3b( player )
{
    if ( utility::flag( "ruby_mq_voss_mars_start_picked" ) && player utility::ent_flag( "ruby_mq_voss_mars_start_picked" ) )
    {
        player utility::ent_flag_clear( "ruby_mq_voss_mars_start_picked" );
        level utility::flag_clear( "ruby_mq_voss_mars_start_picked" );
        player playsoundtoplayer( "evt_mq_perfusion_machine_place", player );
        
        /#
            iprintlnbold( "<dev string:x1ef>" );
        #/
        
        level thread function_e14505e8a1836b19();
        player notify( #"hash_a32b32af9724c297" );
        player function_ea846a83d774cd42();
        level.ruby_mq.var_6bcff70ff5ad2a57 = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", level.ruby_mq.var_3150bc6e12cf8a52.origin, level.ruby_mq.var_3150bc6e12cf8a52.angles );
        level.ruby_mq.var_6bcff70ff5ad2a57 solid();
        level.ruby_mq.var_6bcff70ff5ad2a57.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", level.ruby_mq.var_6bcff70ff5ad2a57.origin + ( 0, 0, 11 ), level.ruby_mq.var_6bcff70ff5ad2a57.angles + ( 0, 90, 0 ) );
        level.ruby_mq.var_6bcff70ff5ad2a57.mdl_brain linkto( level.ruby_mq.var_6bcff70ff5ad2a57 );
        level.ruby_mq.var_6bcff70ff5ad2a57 setscriptablepartstate( "idle", "on" );
        
        if ( player utility::ent_flag( "ruby_mq_slower" ) )
        {
            player weapons::removeextramovespeed( "ruby_mq" );
            
            if ( player common::function_8ff835bf23198a0( "ruby_mq" ) )
            {
                player common::function_d85a92c557ea5a52( "ruby_mq" );
            }
            
            player weapons::updatemovespeedscale();
            player.var_ff2e0673e13ac2ee = 0;
            player val::reset_all( "carrying_perfusion_machine" );
            player utility::ent_flag_clear( "ruby_mq_slower" );
        }
        
        waitframe();
        level utility::flag_set( "ruby_mq_perfusion_placed_mars" );
        return;
    }
    
    if ( utility::flag( "ruby_mq_perfusion_placed_mars" ) )
    {
        if ( level utility::flag( "mq_mars_connect_interact" ) )
        {
            return;
        }
        
        level utility::flag_set( "mq_mars_connect_interact" );
        params = { #hud_description:&"zm_sat_ruby/mq_connect_perfusion", #use_object:self, #hold_time:3, #craft_reason:#"ruby_mq" };
        result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
        
        if ( result )
        {
            if ( isdefined( level.ruby_mq.var_199cdbe1095db27a ) )
            {
                level.ruby_mq.var_199cdbe1095db27a delete();
            }
            
            var_90ce8e39ebce35ee = utility::getstruct( "step4_perfusion_connect_on", "targetname" );
            var_1ffc36adaa2633fc = utility::spawn_model( "sat_zm_perfusion_machine_wire_02", var_90ce8e39ebce35ee.origin, var_90ce8e39ebce35ee.angles );
            level utility::flag_set( "ruby_mq_alien_spawned" );
            
            /#
                iprintlnbold( "<dev string:x206>" );
            #/
            
            var_21a4d0c3cdc24f54 = getent( "ruby_boss_uranus_panel_script_model", #targetname );
            var_21a4d0c3cdc24f54 utility::function_7c10ea82c1e305b8( "material", "on" );
            var_49526565ac23598e = getent( "mq_console_wall_01", "script_noteworthy" );
            var_49526465ac23575b = getent( "mq_console_wall_02", "script_noteworthy" );
            var_49526565ac23598e utility::function_7c10ea82c1e305b8( "material", "on" );
            var_49526465ac23575b utility::function_7c10ea82c1e305b8( "material", "on" );
            earthquake( 0.4, 4, level.ruby_mq.var_3150bc6e12cf8a52.origin, 600 );
            playrumbleonposition( "artillery_rumble_light", level.ruby_mq.var_3150bc6e12cf8a52.origin );
            level utility::flag_set( "ruby_mq_power_generator_initiated" );
            level utility::flag_set( "open_mars_to_observatory_portal" );
            level utility::flag_set( "open_mars_portal" );
            activateworldevent( "we_lgt_teleporter_mars" );
            zm_quest::clear_all_guidance();
            
            foreach ( player in level.players )
            {
                player val::reset( #"ruby_mq", "round_spawning_ignore_player" );
            }
            
            level notify( #"hash_683517d0011a12cd" );
            zm_quest::function_d04a18ed4295a8cd();
            level function_c7ad3f2629230a2b();
            level thread function_9edeba7468fdc724();
            level thread alien_spawn_timer();
            function_4ef47d3c5c627fb6();
            level utility::flag_clear( "ruby_mq_perfusion_placed_mars" );
        }
        else
        {
            level utility::flag_clear( "mq_mars_connect_interact" );
        }
        
        return;
    }
    
    if ( level utility::flag( "ruby_mq_bells_reset" ) && !level utility::flag( "ruby_mq_alien_cooldown" ) )
    {
        if ( !utility::flag( "ruby_mq_alien_spawned" ) )
        {
            level thread function_b2c650c59435e868();
            level thread function_9edeba7468fdc724();
            level thread alien_spawn_timer();
            playsoundatpos( level.ruby_mq.var_6bcff70ff5ad2a57.origin, "evt_mq_luring_echos" );
            level utility::flag_clear( "ruby_mq_bells_reset" );
            function_4ef47d3c5c627fb6();
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x8949fcdc, Offset: 0x157dd
// Size: 0x27
function private function_e14505e8a1836b19()
{
    level endon( #"game_ended" );
    wait 1;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_b044e44085cc9c98" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xc5c95142, Offset: 0x1580c
// Size: 0x54
function private function_c7ad3f2629230a2b()
{
    level endon( #"game_ended" );
    wait 1.5;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_d063cf7bc513080a" ] );
    wait 5;
    playsoundatpos( level.ruby_mq.var_6bcff70ff5ad2a57.origin, "evt_mq_luring_echos" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xd7c452ca, Offset: 0x15868
// Size: 0x38
function private function_b2c650c59435e868()
{
    level endon( #"game_ended" );
    wait 1;
    playsoundatpos( level.ruby_mq.var_6bcff70ff5ad2a57.origin, "evt_mq_luring_echos" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xf457cd89, Offset: 0x158a8
// Size: 0x174
function private perfusion_mars_interact_hint( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        if ( player utility::ent_flag( "ruby_mq_voss_mars_start_picked" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mq_perfusion_place", #type:"HINT_BUTTON" };
        }
        else if ( utility::flag( "ruby_mq_perfusion_placed_mars" ) && !utility::flag( "ruby_mq_power_generator_initiated" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mar_perfusion_gen", #type:"HINT_BUTTON" };
        }
        else if ( utility::flag( "ruby_mq_bells_reset" ) && !level utility::flag( "ruby_mq_alien_cooldown" ) && !level utility::flag( "ruby_mq_alien_spawned" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mars_sound_attractor", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xfd6a6823, Offset: 0x15a24
// Size: 0x72
function private alien_spawn_timer()
{
    level endon( #"hash_6833fd39a983beab" );
    level endon( #"game_ended" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        var_f9073b9a68fe2fe = 180;
    }
    else
    {
        var_f9073b9a68fe2fe = 35;
    }
    
    for ( i = 1; i < var_f9073b9a68fe2fe ; i++ )
    {
        /#
            iprintlnbold( i );
        #/
        
        wait 1;
    }
    
    level notify( #"hide_alien" );
    level thread function_69b489d0092bfd32();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x98d84e15, Offset: 0x15a9e
// Size: 0x79
function private function_d57d1aa930d780f1()
{
    level endon( #"hash_6833fd39a983beab" );
    level endon( #"hide_alien" );
    level endon( #"game_ended" );
    wait 11;
    level thread function_6c852297f4171eb6();
    
    while ( true )
    {
        if ( level.ruby_mq.var_6e70958170ad902f )
        {
            playsoundatpos( level.ruby_mq.var_6e70958170ad902f.origin, "evt_mq_alien_artifact_calling" );
        }
        
        wait 3;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x67a15814, Offset: 0x15b1f
// Size: 0x17a
function private function_69b489d0092bfd32()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
    {
        level.ruby_mq.var_6e70958170ad902f moveto( level.ruby_mq.var_37905f60a75abf14.origin, 2 );
        level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
        level.ruby_mq.var_6e70958170ad902f moveto( level.ruby_mq.var_2187c23bbdf26a10.origin, 1 );
        level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
        
        if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
        {
            level.ruby_mq.var_6e70958170ad902f delete();
        }
    }
    
    level utility::flag_clear( "ruby_mq_alien_arena_center_first" );
    level utility::flag_clear( "ruby_mq_alien_spawned" );
    level utility::flag_set( "ruby_mq_bells_reset" );
    
    if ( !level utility::flag( "ruby_mq_alien_cooldown" ) )
    {
        level utility::flag_set( "ruby_mq_alien_cooldown" );
        level.ruby_mq.var_fdec718b4523c728 = zm_round_logic::get_rb_round_number() + 1;
        level callback::add( "on_round_start", &function_158b7372d20535db );
    }
    
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xb1fc3d29, Offset: 0x15ca1
// Size: 0x52
function private function_158b7372d20535db( params )
{
    level callback::remove( "on_round_start", &function_158b7372d20535db );
    level.ruby_mq.var_fdec718b4523c728 = undefined;
    level utility::flag_clear( "ruby_mq_alien_spawned" );
    level utility::flag_clear( "ruby_mq_alien_cooldown" );
    function_4ef47d3c5c627fb6();
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0xaf9628fe, Offset: 0x15cfb
    // Size: 0x5, Type: dev
    function private function_7a46234f4ff1f26()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xbea9339c, Offset: 0x15d08
// Size: 0x42
function function_e0386829059b2f8c( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "ruby_mq_perfusion_placed_mars" );
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_alien_artifact_picked" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x7ea38cfb, Offset: 0x15d52
// Size: 0x108
function cleanup_step_12( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        zm_quest::function_b57dfe9625966b0b( #"ruby_mq_artifact", 0, #"alien", 1 );
        level utility::flag_set( "ruby_mq_alien_artifact_picked" );
        level utility::flag_set( "ruby_mq_power_generator_initiated" );
        level utility::flag_set( "ruby_mq_alien_arena_center_first" );
        
        if ( isdefined( level.ruby_mq.perfusion_mars_interact ) )
        {
            level.ruby_mq.perfusion_mars_interact delete();
        }
        
        if ( isdefined( level.ruby_mq.var_199cdbe1095db27a ) )
        {
            level.ruby_mq.var_199cdbe1095db27a delete();
        }
        
        var_90ce8e39ebce35ee = utility::getstruct( "step4_perfusion_connect_on", "targetname" );
        var_1ffc36adaa2633fc = utility::spawn_model( "sat_zm_perfusion_machine_wire_02", var_90ce8e39ebce35ee.origin, var_90ce8e39ebce35ee.angles );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x29efbf0c, Offset: 0x15e62
// Size: 0x202
function private function_fc097748e2aee289()
{
    var_918537836b81ee66 = [ "step4_bell_1", "step4_bell_2", "step4_bell_3", "step4_bell_4", "step4_bell_5" ];
    var_ae832503748ee77c = [ "step4_echo_pillar_1", "step4_echo_pillar_2", "step4_echo_pillar_3", "step4_echo_pillar_4" ];
    level.ruby_mq.mdl_bells = [];
    
    for ( i = 0; i < var_918537836b81ee66.size ; i++ )
    {
        s_bell = utility::getstruct( var_918537836b81ee66[ i ], "targetname" );
        level.ruby_mq.mdl_bells[ i ] = utility::spawn_model( "sat_zm_echo_cymbal_top", s_bell.origin, s_bell.angles );
        level.ruby_mq.mdl_bells[ i ] solid();
        level.ruby_mq.mdl_bells[ i ] setcandamage( 1 );
        level.ruby_mq.mdl_bells[ i ].health = 999999;
        level.ruby_mq.mdl_bells[ i ].id = i + 1;
        level.ruby_mq.mdl_bells[ i ].bshot = 0;
        level.ruby_mq.mdl_bells[ i ] thread bell_dmg_watcher();
    }
    
    for ( i = 0; i < var_ae832503748ee77c.size ; i++ )
    {
        s_pillar = utility::getstruct( var_ae832503748ee77c[ i ], "targetname" );
        mdl_pillar = utility::spawn_model( "sat_zm_echo_cymbal", s_pillar.origin, s_pillar.angles );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x28287cb5, Offset: 0x1606c
// Size: 0x7fa
function private bell_dmg_watcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, vhitdir, var_8bc0ee7f93665fd1, smeansofdeath, modelname );
        
        if ( isplayer( eattacker ) && isdefined( level.ruby_mq.var_6e70958170ad902f ) && !level utility::flag( "ruby_mq_alien_fly_back" ) )
        {
            /#
                iprintlnbold( "<dev string:x228>" );
            #/
            
            if ( self.id == 1 && level.ruby_mq.mdl_bells[ 0 ].bshot == 0 && !level.ruby_mq.var_6e70958170ad902f utility::ent_flag( "ruby_mq_alien_moving" ) )
            {
                level.ruby_mq.var_6e70958170ad902f utility::ent_flag_set( "ruby_mq_alien_moving" );
                level thread bells_timer();
                level.ruby_mq.mdl_bells[ 0 ].bshot = 1;
                level.ruby_mq.mdl_bells[ 0 ] setscriptablepartstate( "fx", "on" );
                playsoundatpos( level.ruby_mq.mdl_bells[ 0 ].origin, "evt_mq_pillar_cymbal_hit_01" );
                level notify( #"hash_6833fd39a983beab" );
                level.ruby_mq.var_6e70958170ad902f moveto( level.ruby_mq.var_fd6674d131081fb1.origin, 2 );
                level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
                
                if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
                {
                    level.ruby_mq.var_6e70958170ad902f utility::ent_flag_clear( "ruby_mq_alien_moving" );
                }
            }
            else if ( self.id == 2 && level.ruby_mq.mdl_bells[ 0 ].bshot == 1 && level.ruby_mq.mdl_bells[ 1 ].bshot == 0 && !level.ruby_mq.var_6e70958170ad902f utility::ent_flag( "ruby_mq_alien_moving" ) )
            {
                level.ruby_mq.var_6e70958170ad902f utility::ent_flag_set( "ruby_mq_alien_moving" );
                level.ruby_mq.mdl_bells[ 1 ].bshot = 1;
                level.ruby_mq.mdl_bells[ 1 ] setscriptablepartstate( "fx", "on" );
                playsoundatpos( level.ruby_mq.mdl_bells[ 1 ].origin, "evt_mq_pillar_cymbal_hit_02" );
                level.ruby_mq.var_6e70958170ad902f moveto( level.ruby_mq.var_fd6671d131081918.origin, 2 );
                level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
                
                if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
                {
                    level.ruby_mq.var_6e70958170ad902f utility::ent_flag_clear( "ruby_mq_alien_moving" );
                }
            }
            else if ( self.id == 3 && level.ruby_mq.mdl_bells[ 1 ].bshot == 1 && level.ruby_mq.mdl_bells[ 2 ].bshot == 0 && !level.ruby_mq.var_6e70958170ad902f utility::ent_flag( "ruby_mq_alien_moving" ) )
            {
                level.ruby_mq.var_6e70958170ad902f utility::ent_flag_set( "ruby_mq_alien_moving" );
                level.ruby_mq.mdl_bells[ 2 ].bshot = 1;
                level.ruby_mq.mdl_bells[ 2 ] setscriptablepartstate( "fx", "on" );
                playsoundatpos( level.ruby_mq.mdl_bells[ 2 ].origin, "evt_mq_pillar_cymbal_hit_03" );
                level.ruby_mq.var_6e70958170ad902f moveto( level.ruby_mq.var_fd6672d131081b4b.origin, 2 );
                level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
                
                if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
                {
                    level.ruby_mq.var_6e70958170ad902f utility::ent_flag_clear( "ruby_mq_alien_moving" );
                }
            }
            else if ( self.id == 4 && level.ruby_mq.mdl_bells[ 2 ].bshot == 1 && level.ruby_mq.mdl_bells[ 3 ].bshot == 0 && !level.ruby_mq.var_6e70958170ad902f utility::ent_flag( "ruby_mq_alien_moving" ) )
            {
                level.ruby_mq.var_6e70958170ad902f utility::ent_flag_set( "ruby_mq_alien_moving" );
                level.ruby_mq.mdl_bells[ 3 ].bshot = 1;
                level.ruby_mq.mdl_bells[ 3 ] setscriptablepartstate( "fx", "on" );
                playsoundatpos( level.ruby_mq.mdl_bells[ 3 ].origin, "evt_mq_pillar_cymbal_hit_04" );
                level.ruby_mq.var_6e70958170ad902f moveto( level.ruby_mq.var_fd6677d13108264a.origin, 2 );
                level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
                
                if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
                {
                    level.ruby_mq.var_6e70958170ad902f utility::ent_flag_clear( "ruby_mq_alien_moving" );
                }
            }
            else if ( self.id == 5 && level.ruby_mq.mdl_bells[ 3 ].bshot == 1 && !level.ruby_mq.var_6e70958170ad902f utility::ent_flag( "ruby_mq_alien_moving" ) )
            {
                level.ruby_mq.mdl_bells[ 4 ] setscriptablepartstate( "fx", "on" );
                playsoundatpos( level.ruby_mq.mdl_bells[ 3 ].origin, "evt_mq_pillar_cymbal_hit_05" );
                level thread function_fecc528c16803226();
                
                if ( !level utility::flag( "ruby_mq_alien_arena_center_first" ) )
                {
                    level thread function_b8a1f3af75493083();
                    level utility::flag_set( "ruby_mq_alien_arena_center_first" );
                    level notify( #"hash_f6202fdf7d15be7b" );
                }
                
                level thread function_ec501de9bc6cae19();
            }
            
            function_4ef47d3c5c627fb6();
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x4313ea71, Offset: 0x1686e
// Size: 0x72
function private bells_timer()
{
    level endon( #"hash_f6202fdf7d15be7b" );
    level endon( #"game_ended" );
    level endon( #"alien_was_shot" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        var_f9073b9a68fe2fe = 180;
    }
    else
    {
        var_f9073b9a68fe2fe = 25;
    }
    
    for ( i = 1; i < var_f9073b9a68fe2fe ; i++ )
    {
        /#
            iprintlnbold( i );
        #/
        
        wait 1;
    }
    
    level thread reset_bells();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0xc
// Checksum 0xf89bd095, Offset: 0x168e8
// Size: 0x8a
function private function_ec501de9bc6cae19()
{
    self notify( #"hash_81c0783fac3e616d" );
    self endon( #"hash_81c0783fac3e616d" );
    level endon( #"game_ended" );
    level endon( #"hash_accc0b0deb112b10" );
    level endon( #"alien_was_shot" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        var_f9073b9a68fe2fe = 180;
    }
    else
    {
        var_f9073b9a68fe2fe = 30;
    }
    
    for ( i = 1; i < var_f9073b9a68fe2fe ; i++ )
    {
        /#
            iprintlnbold( i );
        #/
        
        wait 1;
    }
    
    level thread reset_bells();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x9a29dd7b, Offset: 0x1697a
// Size: 0x58
function private function_fecc528c16803226()
{
    level endon( #"game_ended" );
    level.ruby_mq.mdl_bells[ 4 ] thread utility::stop_loop_sound_on_entity( "evt_mq_pillar_cymbal_hit_sing_lp" );
    wait 0.2;
    level.ruby_mq.mdl_bells[ 4 ] thread utility::play_loop_sound_on_entity( "evt_mq_pillar_cymbal_hit_sing_lp" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xf404e84d, Offset: 0x169da
// Size: 0x2d7
function private reset_bells()
{
    level endon( #"game_ended" );
    level.ruby_mq.mdl_bells[ 4 ] thread utility::stop_loop_sound_on_entity( "evt_mq_pillar_cymbal_hit_sing_lp" );
    level utility::flag_set( "ruby_mq_alien_fly_back" );
    
    if ( level.ruby_mq.var_6e70958170ad902f utility::ent_flag( "ruby_mq_alien_moving" ) )
    {
        level.ruby_mq.var_6e70958170ad902f utility::ent_flag_clear( "ruby_mq_alien_moving" );
    }
    
    level notify( #"ruby_mq_bells_reset" );
    
    for ( i = 0; i < level.ruby_mq.mdl_bells.size ; i++ )
    {
        level.ruby_mq.mdl_bells[ i ].bshot = 0;
    }
    
    if ( !level utility::flag( "ruby_mq_alien_cooldown" ) )
    {
        level utility::flag_set( "ruby_mq_alien_cooldown" );
        level.ruby_mq.var_fdec718b4523c728 = zm_round_logic::get_rb_round_number() + 1;
        level callback::add( "on_round_start", &function_158b7372d20535db );
    }
    
    level battlechatter_mp::trysaylocalsound( level.players[ 0 ], #"bc_flavor_player_negative" );
    function_4ef47d3c5c627fb6();
    
    if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
    {
        wait 0.5;
        
        if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
        {
            level.ruby_mq.var_6e70958170ad902f.sc_fx setscriptablepartstate( "vanish", "on" );
        }
        
        if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
        {
            level.ruby_mq.var_6e70958170ad902f moveto( level.ruby_mq.var_37905f60a75abf14.origin, 8 );
            level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
        }
        
        if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
        {
            level.ruby_mq.var_6e70958170ad902f moveto( level.ruby_mq.var_2187c23bbdf26a10.origin, 2 );
            level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
        }
        
        if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
        {
            level.ruby_mq.var_6e70958170ad902f delete();
        }
    }
    
    level utility::flag_clear( "ruby_mq_alien_arena_center_first" );
    level utility::flag_set( "ruby_mq_bells_reset" );
    level utility::flag_clear( "ruby_mq_alien_fly_back" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x39651f30, Offset: 0x16cb9
// Size: 0x122
function private function_1d5c60addc0d67c6()
{
    level.ruby_mq.var_2187c23bbdf26a10 = utility::getstruct( "step4_alien_mars_s1_1", "targetname" );
    level.ruby_mq.var_37905f60a75abf14 = utility::getstruct( "step4_alien_mars_s1_2", "targetname" );
    level.ruby_mq.var_8b283e1987128e44 = utility::getstruct( "step4_alien_mars_s1_3", "targetname" );
    level.ruby_mq.var_fd6674d131081fb1 = utility::getstruct( "step4_alien_bell_1", "targetname" );
    level.ruby_mq.var_fd6671d131081918 = utility::getstruct( "step4_alien_bell_2", "targetname" );
    level.ruby_mq.var_fd6672d131081b4b = utility::getstruct( "step4_alien_bell_3", "targetname" );
    level.ruby_mq.var_fd6677d13108264a = utility::getstruct( "step4_alien_bell_4", "targetname" );
    level.ruby_mq.var_95dbd2dfae17fd3f = utility::getstructarray( "step4_alien_energy", "targetname" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x8e4dc293, Offset: 0x16de3
// Size: 0x198
function private function_9edeba7468fdc724()
{
    level.ruby_mq.var_6e70958170ad902f = utility::spawn_model( "sat_zm_alien_artifact_fxanim", level.ruby_mq.var_2187c23bbdf26a10.origin, level.ruby_mq.var_2187c23bbdf26a10.angles );
    level.ruby_mq.var_6e70958170ad902f setscriptablepartstate( "anim", "fly" );
    level.ruby_mq.var_6e70958170ad902f setscriptablepartstate( "audio", "play_sound" );
    level.ruby_mq.var_6e70958170ad902f.sc_fx = spawnscriptable( %"sat_zm_ruby_alien_artifact_fx", level.ruby_mq.var_2187c23bbdf26a10.origin, level.ruby_mq.var_2187c23bbdf26a10.angles );
    waitframe();
    level.ruby_mq.var_6e70958170ad902f.sc_fx utility::scriptable_setparententity( level.ruby_mq.var_6e70958170ad902f );
    level.ruby_mq.var_6e70958170ad902f.sc_fx setscriptablepartstate( "trail", "on" );
    level utility::flag_set( "ruby_mq_alien_spawned" );
    level thread function_9be1c9db9ab6d9d7( level.ruby_mq.var_6e70958170ad902f );
    level thread function_77f3ea68bc22c89b();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x53ac978b, Offset: 0x16f83
// Size: 0x119
function private function_6c852297f4171eb6()
{
    level endon( #"game_ended" );
    wait 0.5;
    
    foreach ( player in level.players )
    {
        if ( player zm_vo::is_hero_operator() )
        {
            if ( !level utility::flag( "vo_alien_spotted" ) )
            {
                level utility::flag_set( "vo_alien_spotted" );
                player thread zm_vo::function_8c1a12974bd11f01( #"hash_c8dcb38ac98662fb", #"hash_5212ed7ec42f115a" );
                return;
            }
        }
    }
    
    if ( !level utility::flag( "vo_alien_spotted" ) )
    {
        level utility::flag_set( "vo_alien_spotted" );
        
        if ( isdefined( level.players[ 0 ] ) )
        {
            level.players[ 0 ] thread zm_vo::function_8c1a12974bd11f01( #"hash_c8dcb38ac98662fb", #"hash_5212ed7ec42f115a" );
            return;
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x11ae1d10, Offset: 0x170a4
// Size: 0x21f
function private function_77f3ea68bc22c89b()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"hash_f6202fdf7d15be7b" );
    level endon( #"ruby_mq_bells_reset" );
    level endon( #"alien_was_shot" );
    level endon( #"hash_accc0b0deb112b10" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player playerads() == 1 )
            {
                var_4bdae59d5f679b9f = anglestoforward( player getplayerangles() );
                var_a6d90bf6452f4038 = vectornormalize( level.ruby_mq.var_6e70958170ad902f.origin - player.origin );
                dot = vectordot( var_4bdae59d5f679b9f, var_a6d90bf6452f4038 );
                
                if ( dot < 0.99 )
                {
                    continue;
                }
                
                dist_sq = distancesquared( level.ruby_mq.var_6e70958170ad902f.origin, player.origin );
                
                if ( dist_sq > 225000000 )
                {
                    /#
                        iprintlnbold( "<dev string:x235>" );
                    #/
                    
                    continue;
                }
                
                trace = player player_viewangles_custom();
                
                if ( trace[ "entity" ] == level.ruby_mq.var_6e70958170ad902f )
                {
                    if ( trace[ "entity" ] == level.ruby_mq.var_6e70958170ad902f )
                    {
                        /#
                            iprintlnbold( "<dev string:x243>" );
                        #/
                        
                        wait 0.75;
                        
                        if ( !level utility::flag( "vo_alien_spotted_voss" ) )
                        {
                            level utility::flag_set( "vo_alien_spotted_voss" );
                            level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_29a15b1945deeb11" ] );
                            return;
                        }
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 4, eflags: 0x4
// Checksum 0x83d77cd6, Offset: 0x172cb
// Size: 0x52
function private player_viewangles_custom( collisioncontents, getsurfacetype, ignoreclutter, allowscriptables )
{
    assert( isplayer( self ) );
    return trace::ray_trace( self geteye(), self geteye() + anglestoforward( self getplayerangles() ) * 25000 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x72c147a9, Offset: 0x17326
// Size: 0xd4
function private function_9be1c9db9ab6d9d7( alien )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "ruby_mq_power_generator_initiated" );
    
    if ( isdefined( alien ) )
    {
        alien moveto( level.ruby_mq.var_37905f60a75abf14.origin, 3 );
        alien waittill( #"movedone" );
    }
    
    if ( isdefined( alien ) )
    {
        alien moveto( level.ruby_mq.var_8b283e1987128e44.origin, 3 );
        alien waittill( #"movedone" );
    }
    
    alien solid();
    alien setcandamage( 1 );
    alien.health = 999999;
    alien thread function_17ca220ee81736a();
    level thread function_d57d1aa930d780f1();
    alien thread function_e6c4a9de24e18320();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x6457d63f, Offset: 0x17402
// Size: 0x9f
function private function_17ca220ee81736a()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"hash_f6202fdf7d15be7b" );
    level endon( #"stop_bobbing" );
    level endon( #"hash_accc0b0deb112b10" );
    n_offset = 20;
    
    while ( true )
    {
        self movez( n_offset, 2.2, 0.7, 0.7 );
        self waittill( #"movedone" );
        self movez( n_offset * -1, 2.2, 0.7, 0.7 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x19921dfe, Offset: 0x174a9
// Size: 0xb1
function private function_e6c4a9de24e18320()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, vhitdir, var_8bc0ee7f93665fd1, smeansofdeath, modelname );
        
        if ( isplayer( eattacker ) )
        {
            level notify( #"alien_was_shot" );
            level.ruby_mq.var_6e70958170ad902f.sc_fx setscriptablepartstate( "hit", "on" );
            level thread reset_bells();
            return;
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xabfc2a84, Offset: 0x17562
// Size: 0x103
function private function_b8a1f3af75493083()
{
    level endon( #"game_ended" );
    var_5d82508f0ddc9531 = utility::getstruct( "step4_alien_mars_s2_1", "targetname" );
    level.ruby_mq.var_9b8e95d140450bab = utility::spawn_model( "tag_origin", var_5d82508f0ddc9531.origin, var_5d82508f0ddc9531.angles );
    level.ruby_mq.var_6e70958170ad902f utility::ent_flag_set( "ruby_mq_alien_moving" );
    level.ruby_mq.var_6e70958170ad902f moveto( level.ruby_mq.var_9b8e95d140450bab.origin, 5 );
    level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
    level.ruby_mq.var_6e70958170ad902f utility::ent_flag_clear( "ruby_mq_alien_moving" );
    level thread function_65e9169784718c41();
    level thread function_c05b25974f00ec80();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xb32a454c, Offset: 0x1766d
// Size: 0x27
function private function_65e9169784718c41()
{
    level endon( #"game_ended" );
    wait 2;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_604c035ba8fb6d24" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xe9a30381, Offset: 0x1769c
// Size: 0x25b
function private function_c05b25974f00ec80()
{
    level endon( #"game_ended" );
    level endon( #"ruby_mq_bells_reset" );
    level endon( #"alien_was_shot" );
    level endon( #"hash_accc0b0deb112b10" );
    var_1c772b6c5cc34857 = utility::getstructarray( "step4_alien_path_higher", "targetname" );
    var_3a12fd24a3788d49 = utility::getstructarray( "step4_alien_path_lower", "targetname" );
    
    while ( true )
    {
        if ( var_3a12fd24a3788d49.size == 0 )
        {
            var_3a12fd24a3788d49 = utility::getstructarray( "step4_alien_path_lower", "targetname" );
        }
        
        if ( var_1c772b6c5cc34857.size == 0 )
        {
            var_1c772b6c5cc34857 = utility::getstructarray( "step4_alien_path_higher", "targetname" );
        }
        
        higher_loop = randomintrange( 1, 4 );
        
        for ( i = 0; i < higher_loop ; i++ )
        {
            var_2bb4ff0406088342 = utility::array_random( var_1c772b6c5cc34857 );
            arrayremove( var_1c772b6c5cc34857, var_2bb4ff0406088342 );
            level.ruby_mq.var_6e70958170ad902f moveto( var_2bb4ff0406088342.origin, 3 );
            level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
            n_wait_duration = randomintrange( 2, 3 );
            wait n_wait_duration;
            level notify( #"stop_bobbing" );
        }
        
        lower_loop = randomintrange( 1, 4 );
        
        for ( i = 0; i < lower_loop ; i++ )
        {
            level thread vo_alien_moved_lower();
            var_f0831a2258f7c240 = utility::array_random( var_3a12fd24a3788d49 );
            arrayremove( var_3a12fd24a3788d49, var_f0831a2258f7c240 );
            level.ruby_mq.var_6e70958170ad902f moveto( var_f0831a2258f7c240.origin, 3 );
            level.ruby_mq.var_6e70958170ad902f waittill( #"movedone" );
            var_5ff50fc9b638dca7 = interaction::register_interact( var_f0831a2258f7c240.origin, 70, &function_c713d7d100821d6f );
            var_5ff50fc9b638dca7 sethintonobstruction( "show" );
            var_5ff50fc9b638dca7 setusefov( 360 );
            var_5ff50fc9b638dca7 interaction::set_interact_hint_callback( &function_52d69340e147c769 );
            level.ruby_mq.var_6e70958170ad902f thread function_17ca220ee81736a();
            n_wait_duration = randomintrange( 3, 5 );
            wait n_wait_duration;
            
            if ( isdefined( var_5ff50fc9b638dca7 ) )
            {
                var_5ff50fc9b638dca7 delete();
            }
            
            level notify( #"stop_bobbing" );
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x37b621fd, Offset: 0x178ff
// Size: 0x44
function private vo_alien_moved_lower()
{
    level endon( #"game_ended" );
    
    if ( !level utility::flag( "vo_alien_moved_lower" ) )
    {
        level utility::flag_set( "vo_alien_moved_lower" );
        wait 2;
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_2d1f69d54671f1cf" ] );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x1cf72c37, Offset: 0x1794b
// Size: 0x1f3
function private function_c713d7d100821d6f( player )
{
    level endon( #"game_ended" );
    zm_quest::function_b57dfe9625966b0b( #"ruby_mq_artifact", 0, #"alien", 1 );
    zm_quest::show_splash_item_picked_up( #"ruby_mq_artifact", #"alien", 1, player );
    
    foreach ( intel_player in level.players )
    {
        intel_player utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_ruby_artifact_4" );
    }
    
    level thread function_50986e952176e3d4( player );
    
    if ( isdefined( level.ruby_mq.var_6e70958170ad902f ) )
    {
        level.ruby_mq.var_6e70958170ad902f delete();
    }
    
    level utility::flag_set( "ruby_mq_alien_artifact_picked" );
    level notify( #"hash_accc0b0deb112b10" );
    
    foreach ( player in level.players )
    {
        player thread function_c473ef2ca3032767( 0.5, 1 );
    }
    
    level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 1, 1, 0, undefined, 1, undefined, 1 );
    wait 2;
    level.ruby_mq.mdl_bells[ 4 ] thread utility::stop_loop_sound_on_entity( "evt_mq_pillar_cymbal_hit_sing_lp" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x3568889f, Offset: 0x17b46
// Size: 0x89
function private function_52d69340e147c769( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mq_grab_alien", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x6dbf9083, Offset: 0x17bd7
// Size: 0x39
function private function_50986e952176e3d4( player )
{
    level endon( #"game_ended" );
    wait 1.7;
    player thread zm_vo::function_8c1a12974bd11f01( #"hash_63fcc64b923fec3b", #"bc_flavor_player_positive" );
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0xf2090d7d, Offset: 0x17c18
    // Size: 0x5, Type: dev
    function private function_5eba6bc11abcfd7b()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x803f8788, Offset: 0x17c25
// Size: 0x8e
function function_e0386929059b31bf( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( isdefined( level.ruby_mq.perfusion_mars_interact ) )
        {
            level.ruby_mq.perfusion_mars_interact delete();
        }
        
        return;
    }
    
    level utility::flag_wait( "ruby_mq_alien_artifact_picked" );
    level thread setup_voss_interact_final();
    level.ruby_mq.var_7755638ed8800403 = 0;
    function_4ef47d3c5c627fb6();
    level utility::flag_wait( "ruby_mq_complete" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x5dcf1f72, Offset: 0x17cbb
// Size: 0x50b
function cleanup_step_13( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "ruby_mq_complete" );
        level utility::flag_set( "ruby_mq_artifact_mars_placed" );
        level utility::flag_set( "ruby_mq_all_5_melody_pillars_on" );
        level utility::flag_set( "ruby_mq_melody_obtained" );
        level.ruby_mq.var_ffebe7a1a6ab9c8e = utility::getstruct( "step4_alien_mars_interact", "targetname" );
        var_b2ad9eb0e7f452b4 = utility::spawn_model( "sat_zm_alien_artifact_fxanim", level.ruby_mq.var_ffebe7a1a6ab9c8e.origin, level.ruby_mq.var_ffebe7a1a6ab9c8e.angles );
        var_b2ad9eb0e7f452b4 setscriptablepartstate( "anim", "idle" );
        level thread setup_voss_interact_final();
        a_trigger_names = [ "step4_trigger_num_1", "step4_trigger_num_2", "step4_trigger_num_3", "step4_trigger_num_4", "step4_trigger_num_5" ];
        var_3d0f6c333a30aa51 = [ "step4_pillar_num_1", "step4_pillar_num_2", "step4_pillar_num_3", "step4_pillar_num_4", "step4_pillar_num_5" ];
        var_dc0ffb582ecb84cf = [ "step4_pillar_1", "step4_pillar_2", "step4_pillar_3", "step4_pillar_4", "step4_pillar_5" ];
        level.ruby_mq.var_e2f32ef1fd6fc6d3 = [];
        level.ruby_mq.var_a978b7b0ed838c91 = [];
        level.ruby_mq.var_9b8a918ab0c5e115 = 0;
        
        for ( i = 0; i < a_trigger_names.size ; i++ )
        {
            level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ] = getent( a_trigger_names[ i ], #targetname );
            level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].id = i + 1;
            level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].structname = var_3d0f6c333a30aa51[ i ];
            level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].b_hit = 0;
            level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].var_4950659180be944b = 0;
            s_pillar = utility::getstruct( var_dc0ffb582ecb84cf[ i ], "targetname" );
            level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].sc_pillar_fx = spawnscriptable( %"sat_zm_ruby_mars_pillar_fx", s_pillar.origin );
        }
        
        foreach ( var_e1f63a86aaf6372b in level.ruby_mq.var_16120e7bf8d769e9 )
        {
            for ( i = 0; i < level.ruby_mq.var_e2f32ef1fd6fc6d3.size ; i++ )
            {
                if ( var_e1f63a86aaf6372b == level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].id )
                {
                    level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].num = var_e1f63a86aaf6372b;
                }
            }
        }
        
        waitframe();
        
        foreach ( trigger in level.ruby_mq.var_e2f32ef1fd6fc6d3 )
        {
            foreach ( code in level.ruby_mq.var_16120e7bf8d769e9 )
            {
                if ( code == trigger.num )
                {
                    fx_string = get_pillar_fx_string( trigger.id );
                    trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( fx_string, "on" );
                }
                
                waitframe();
            }
        }
    }
    
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x10ac748, Offset: 0x181ce
// Size: 0x76
function private function_27f5a5e1c5f3c46b()
{
    level.ruby_mq.var_ffebe7a1a6ab9c8e = utility::getstruct( "step4_alien_mars_interact", "targetname" );
    artifact_interact = interaction::register_interact( level.ruby_mq.var_ffebe7a1a6ab9c8e.origin, 100, &function_a2b4abff20b0db58 );
    artifact_interact sethintonobstruction( "show" );
    artifact_interact interaction::set_interact_hint_callback( &function_52d5667e57c2e739 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xfe4ab49b, Offset: 0x1824c
// Size: 0x466
function private function_a2b4abff20b0db58( player )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "ruby_mq_alien_artifact_picked" ) && !level utility::flag( "ruby_mq_artifact_mars_placed" ) )
    {
        playsoundatpos( level.ruby_mq.var_ffebe7a1a6ab9c8e.origin, "evt_mq_alien_artifact_place" );
        level utility::flag_set( "ruby_mq_artifact_mars_placed" );
        var_b2ad9eb0e7f452b4 = utility::spawn_model( "sat_zm_alien_artifact_fxanim", level.ruby_mq.var_ffebe7a1a6ab9c8e.origin, level.ruby_mq.var_ffebe7a1a6ab9c8e.angles );
        var_b2ad9eb0e7f452b4 setscriptablepartstate( "anim", "idle" );
        level.ruby_mq.var_b8ae8849bb629810 = spawnscriptable( %"sat_zm_ruby_alien_artifact_fx", var_b2ad9eb0e7f452b4.origin );
        level.ruby_mq.var_b8ae8849bb629810 utility::scriptable_setparententity( var_b2ad9eb0e7f452b4 );
        level.ruby_mq.var_b8ae8849bb629810 setscriptablepartstate( "correct", "off" );
        level thread function_7799f8f7d4cf9727( player );
        level thread function_5dee3087a7caaee1();
        a_structnames = [ "step4_antenna_1", "step4_antenna_2", "step4_antenna_3", "step4_antenna_4", "step4_antenna_5" ];
        var_9e040abc8b4e26b2 = [ "step4_squadron_revolve_1", "step4_squadron_revolve_2", "step4_squadron_revolve_3", "step4_squadron_revolve_4", "step4_squadron_revolve_5" ];
        var_3d0f6c333a30aa51 = [ "step4_pillar_num_1", "step4_pillar_num_2", "step4_pillar_num_3", "step4_pillar_num_4", "step4_pillar_num_5" ];
        level.ruby_mq.var_30ed590254b805a6 = [];
        level.ruby_mq.var_350eb2da74a0a693 = [];
        level.ruby_mq.var_6cbbfed678923fa7 = [];
        level.ruby_mq.var_8980d01adba9486a = [];
        level.ruby_mq.var_1b0bf2e4e133b453 = 0;
        level.ruby_mq.e_powermachine = getent( "step4_power_machine", "targetname" );
        
        for ( i = 0; i < a_structnames.size ; i++ )
        {
            s_antenna = utility::getstruct( a_structnames[ i ], "targetname" );
            mdl_antenna = utility::spawn_model( "sat_zm_antenna_pillars_antenna", s_antenna.origin, s_antenna.angles );
            mdl_antenna.id = i + 1;
            mdl_antenna thread function_47aebe50cce96969();
            level.ruby_mq.var_30ed590254b805a6[ level.ruby_mq.var_30ed590254b805a6.size ] = mdl_antenna;
            s_squadron = utility::getstruct( var_9e040abc8b4e26b2[ i ], "targetname" );
            mdl_squadron = utility::spawn_model( "tag_origin", s_squadron.origin, s_squadron.angles );
            mdl_squadron.id = i + 1;
            mdl_squadron.structname = var_3d0f6c333a30aa51[ i ];
            mdl_squadron.b_hit = 0;
            mdl_squadron.trigger = level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ];
            level.ruby_mq.var_6cbbfed678923fa7[ level.ruby_mq.var_6cbbfed678923fa7.size ] = mdl_squadron;
            
            if ( utility::issharedfuncdefined( #"ww_ruby", #"hash_eacf089357dac29a" ) )
            {
                utility::callsharedfunc( #"ww_ruby", #"hash_eacf089357dac29a", { #obj:mdl_squadron } );
            }
            
            waitframe();
            mdl_squadron callback::add( "ww_ruby_revolve_start", &power_up_antenna );
        }
        
        function_4ef47d3c5c627fb6();
        wait 1.25;
        playsoundatpos( level.ruby_mq.var_ffebe7a1a6ab9c8e.origin, "evt_mq_power_machine_on_fail" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xff8f6b1a, Offset: 0x186ba
// Size: 0x21
function private function_47aebe50cce96969()
{
    self moveto( self.origin + ( 0, 0, 67 ), 2 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x6348e8e8, Offset: 0x186e3
// Size: 0x1d4
function private power_up_antenna( params )
{
    if ( !self.b_hit )
    {
        zm_quest::function_5b5c737326035ea( self.id - 1 );
        level thread turn_on_power_machine();
        
        /#
            iprintlnbold( "<dev string:x25a>" );
        #/
        
        self.b_hit = 1;
        basestring = "sign_alphabet_letter_02_";
        newstring = basestring + self.id;
        s_num = utility::getstruct( self.structname, "targetname" );
        self.trigger setup_symbol_interacts( s_num );
        basestring = "evt_mq_pillar_symbol_0";
        newstring = basestring + self.trigger.num;
        playsoundatpos( self.origin, newstring );
        basestring = "step4_mdl_pillar_";
        newstring = basestring + self.id;
        mdl_pillar = getent( newstring, "targetname" );
        pillar_name = function_13fc8c3423c65324( self.id );
        var_7a4f1802e5ef3cd = "blue::";
        var_805e6e3dd2f790c8 = var_7a4f1802e5ef3cd + pillar_name;
        mdl_pillar setmodel( var_805e6e3dd2f790c8 );
        
        foreach ( var_bc006453d24e4625 in level.ruby_mq.var_30ed590254b805a6 )
        {
            if ( var_bc006453d24e4625.id == self.id )
            {
                var_bc006453d24e4625 thread rotate_antenna();
            }
        }
        
        return;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0x7fcb73f, Offset: 0x188bf
// Size: 0x70
function function_13fc8c3423c65324( id )
{
    switch ( id )
    {
        case 1:
            return "sat_zm_antenna_pillars_03";
        case 2:
            return "sat_zm_antenna_pillars_04";
        case 3:
            return "sat_zm_antenna_pillars_05";
        case 4:
            return "sat_zm_antenna_pillars_02";
        case 5:
            return "sat_zm_antenna_pillars_01";
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xd299659b, Offset: 0x18937
// Size: 0x59
function private function_7799f8f7d4cf9727( player )
{
    level endon( #"game_ended" );
    wait 1.7;
    player thread zm_vo::function_8c1a12974bd11f01( #"hash_4aed47cef363f81c", #"bc_flavor_player_positive" );
    zm_quest::function_8934bb2a9028bdc5();
    wait 1;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_a58e4b04020d82a4" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x97a29c2c, Offset: 0x18998
// Size: 0xd4
function private function_52d5667e57c2e739( interact, player )
{
    if ( level utility::flag( "ruby_mq_alien_artifact_picked" ) && !level utility::flag( "ruby_mq_artifact_mars_placed" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mq_artifact", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
        }
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x62e004f7, Offset: 0x18a75
// Size: 0x382
function private function_5dee3087a7caaee1()
{
    level callback::add( "mars_pillar_symbol_pressed", &function_5edf685aad4261b5 );
    a_trigger_names = [ "step4_trigger_num_1", "step4_trigger_num_2", "step4_trigger_num_3", "step4_trigger_num_4", "step4_trigger_num_5" ];
    var_3d0f6c333a30aa51 = [ "step4_pillar_num_1", "step4_pillar_num_2", "step4_pillar_num_3", "step4_pillar_num_4", "step4_pillar_num_5" ];
    var_dc0ffb582ecb84cf = [ "step4_pillar_1", "step4_pillar_2", "step4_pillar_3", "step4_pillar_4", "step4_pillar_5" ];
    level.ruby_mq.var_e2f32ef1fd6fc6d3 = [];
    level.ruby_mq.var_a978b7b0ed838c91 = [];
    level.ruby_mq.var_9b8a918ab0c5e115 = 0;
    
    for ( i = 0; i < a_trigger_names.size ; i++ )
    {
        level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ] = getent( a_trigger_names[ i ], #targetname );
        level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].id = i + 1;
        level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].structname = var_3d0f6c333a30aa51[ i ];
        level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].b_hit = 0;
        level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].var_4950659180be944b = 0;
        s_pillar = utility::getstruct( var_dc0ffb582ecb84cf[ i ], "targetname" );
        level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].sc_pillar_fx = spawnscriptable( %"sat_zm_ruby_mars_pillar_fx", s_pillar.origin );
    }
    
    foreach ( var_e1f63a86aaf6372b in level.ruby_mq.var_16120e7bf8d769e9 )
    {
        for ( i = 0; i < level.ruby_mq.var_e2f32ef1fd6fc6d3.size ; i++ )
        {
            if ( var_e1f63a86aaf6372b == level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].id )
            {
                level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].num = var_e1f63a86aaf6372b;
            }
        }
    }
    
    foreach ( trigger in level.ruby_mq.var_e2f32ef1fd6fc6d3 )
    {
        trigger thread function_d3084fb3c7466ba4();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xfa7bd3fb, Offset: 0x18dff
// Size: 0x3fd
function private function_d3084fb3c7466ba4()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( !self.b_hit && objweapon.basename == "sat_ww_ruby_zm" )
        {
            self.b_hit = 1;
            return;
        }
        else if ( !self.var_4950659180be944b )
        {
            foreach ( var_bc006453d24e4625 in level.ruby_mq.var_30ed590254b805a6 )
            {
                if ( var_bc006453d24e4625.id == self.id )
                {
                    self.var_4950659180be944b = 1;
                    arrayremove( level.ruby_mq.var_30ed590254b805a6, var_bc006453d24e4625 );
                    level.ruby_mq.var_350eb2da74a0a693[ level.ruby_mq.var_350eb2da74a0a693.size ] = var_bc006453d24e4625.id;
                    
                    if ( utility::issharedfuncdefined( #"ww_ruby", #"hash_2bb2c25b0c628369" ) )
                    {
                        utility::callsharedfunc( #"ww_ruby", #"hash_2bb2c25b0c628369", { #obj:var_bc006453d24e4625 } );
                    }
                    
                    var_bc006453d24e4625 moveto( var_bc006453d24e4625.origin + ( 0, 0, -67 ), 0.75 );
                    var_bc006453d24e4625 waittill( #"movedone" );
                    level battlechatter_mp::trysaylocalsound( eattacker, #"bc_flavor_player_negative" );
                    var_bc006453d24e4625 delete();
                    
                    if ( level.ruby_mq.var_1b0bf2e4e133b453 == 0 )
                    {
                        level.ruby_mq.var_1b0bf2e4e133b453 = 1;
                        level.ruby_mq.var_23a3e12d4d943174 = zm_round_logic::get_rb_round_number() + 1;
                        level callback::add( "on_round_start", &reset_antennas );
                    }
                }
            }
            
            foreach ( squadron in level.ruby_mq.var_6cbbfed678923fa7 )
            {
                if ( squadron.id == self.id )
                {
                    arrayremove( level.ruby_mq.var_6cbbfed678923fa7, squadron );
                    level.ruby_mq.var_8980d01adba9486a[ level.ruby_mq.var_8980d01adba9486a.size ] = squadron.id;
                    
                    if ( utility::issharedfuncdefined( #"ww_ruby", #"hash_2bb2c25b0c628369" ) )
                    {
                        utility::callsharedfunc( #"ww_ruby", #"hash_2bb2c25b0c628369", { #obj:squadron } );
                    }
                    
                    squadron callback::remove( "ww_ruby_revolve_start", &power_up_antenna );
                    squadron delete();
                }
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x2b82b7b1, Offset: 0x19204
// Size: 0x65
function private turn_on_power_machine()
{
    level.ruby_mq.var_79392d363e812265++;
    
    if ( level.ruby_mq.var_79392d363e812265 == 5 )
    {
        level utility::flag_set( "ruby_mq_all_5_melody_pillars_on" );
        level.ruby_mq.e_powermachine setscriptablepartstate( "anim", "on" );
        function_4ef47d3c5c627fb6();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xf769dd14, Offset: 0x19271
// Size: 0x3d
function private rotate_antenna()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( isdefined( self ) )
        {
            self rotateby( ( 0, 12, 0 ), 0.1 );
        }
        else
        {
            return;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x8096a1b, Offset: 0x192b6
// Size: 0x496
function private reset_antennas( params )
{
    level endon( #"game_ended" );
    
    foreach ( trigger in level.ruby_mq.var_e2f32ef1fd6fc6d3 )
    {
        if ( trigger.var_4950659180be944b == 1 )
        {
            trigger.var_4950659180be944b = 0;
        }
    }
    
    foreach ( id in level.ruby_mq.var_350eb2da74a0a693 )
    {
        basestring = "step4_antenna_";
        newstring = basestring + id;
        s_antenna = utility::getstruct( newstring, "targetname" );
        mdl_antenna = utility::spawn_model( "sat_zm_antenna_pillars_antenna", s_antenna.origin, s_antenna.angles );
        mdl_antenna.id = id;
        mdl_antenna moveto( mdl_antenna.origin + ( 0, 0, 67 ), 2 );
        mdl_antenna waittill( #"movedone" );
        level.ruby_mq.var_30ed590254b805a6[ level.ruby_mq.var_30ed590254b805a6.size ] = mdl_antenna;
    }
    
    foreach ( id in level.ruby_mq.var_8980d01adba9486a )
    {
        basestring = "step4_squadron_revolve_";
        newstring = basestring + id;
        var_28c2a13a2f193542 = "step4_pillar_num_";
        var_b8d8a3baec9a6b0d = var_28c2a13a2f193542 + id;
        s_squadron = utility::getstruct( newstring, "targetname" );
        mdl_squadron = utility::spawn_model( "tag_origin", s_squadron.origin, s_squadron.angles );
        mdl_squadron.id = id;
        mdl_squadron.structname = var_b8d8a3baec9a6b0d;
        mdl_squadron.b_hit = 0;
        
        foreach ( trigger in level.ruby_mq.var_e2f32ef1fd6fc6d3 )
        {
            if ( mdl_squadron.id == trigger.id )
            {
                mdl_squadron.trigger = trigger;
            }
        }
        
        level.ruby_mq.var_6cbbfed678923fa7[ level.ruby_mq.var_6cbbfed678923fa7.size ] = mdl_squadron;
        
        if ( utility::issharedfuncdefined( #"ww_ruby", #"hash_eacf089357dac29a" ) )
        {
            utility::callsharedfunc( #"ww_ruby", #"hash_eacf089357dac29a", { #obj:mdl_squadron } );
        }
        
        waitframe();
        mdl_squadron callback::add( "ww_ruby_revolve_start", &power_up_antenna );
    }
    
    level callback::remove( "on_round_start", &reset_antennas );
    level.ruby_mq.var_8980d01adba9486a = undefined;
    level.ruby_mq.var_8980d01adba9486a = [];
    level.ruby_mq.var_350eb2da74a0a693 = undefined;
    level.ruby_mq.var_350eb2da74a0a693 = [];
    level.ruby_mq.var_23a3e12d4d943174 = undefined;
    level.ruby_mq.var_1b0bf2e4e133b453 = 0;
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xc15dc594, Offset: 0x19754
// Size: 0x7f
function private setup_symbol_interacts( s_num )
{
    self.interact = interaction::register_interact( s_num.origin, 100, &function_8fa6dfc8b5d9d551 );
    self.interact sethintonobstruction( "show" );
    self.interact.b_touched = 0;
    self.interact interaction::set_interact_hint_callback( &function_eaa4915ed463427 );
    self.interact.trigger = self;
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xf9d15497, Offset: 0x197db
// Size: 0x8d
function private function_8fa6dfc8b5d9d551( player )
{
    if ( !utility::flag( "ruby_mq_all_5_melody_pillars_on" ) )
    {
        return;
    }
    
    if ( level utility::flag( "ruby_mq_melody_cooldown" ) || level utility::flag( "ruby_mq_complete" ) || self.b_touched == 1 )
    {
        return;
    }
    
    params = spawnstruct();
    params.trigger = self.trigger;
    params.player = player;
    callback::callback( "mars_pillar_symbol_pressed", params );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x8ab63e3, Offset: 0x19870
// Size: 0xf7
function private function_eaa4915ed463427( interact, player )
{
    if ( level utility::flag( "ruby_mq_melody_cooldown" ) || level utility::flag( "ruby_mq_complete" ) || !level utility::flag( "ruby_mq_all_5_melody_pillars_on" ) || interact.b_touched == 1 )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mq_mars_symbol", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x5ca027df, Offset: 0x1996f
// Size: 0xf9
function private function_986ee2b250185de5( var_5e2221840c5be55d )
{
    foreach ( player in level.players )
    {
        if ( player zm_vo::is_hero_operator() && !level utility::flag( "vo_melody_puzzle_first_interact" ) )
        {
            player thread zm_vo::function_8c1a12974bd11f01( #"hash_6859ec17426048fa", #"hash_5212ed7ec42f115a" );
            level utility::flag_set( "vo_melody_puzzle_first_interact" );
            return;
        }
    }
    
    if ( !level utility::flag( "vo_melody_puzzle_first_interact" ) )
    {
        var_5e2221840c5be55d thread zm_vo::function_8c1a12974bd11f01( #"hash_6859ec17426048fa", #"hash_5212ed7ec42f115a" );
        level utility::flag_set( "vo_melody_puzzle_first_interact" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x5fc22891, Offset: 0x19a70
// Size: 0x5a9
function private function_5edf685aad4261b5( params )
{
    level thread function_986ee2b250185de5( params.player );
    
    if ( level.ruby_mq.var_16120e7bf8d769e9[ 0 ] == params.trigger.num && !utility::flag( "ruby_mq_s4_code_1" ) )
    {
        level utility::flag_set( "ruby_mq_s4_code_1" );
        fx_string = get_pillar_fx_string( params.trigger.id );
        params.trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( fx_string, "on" );
        
        if ( level.ruby_mq.var_7755638ed8800403 == 0 )
        {
            level thread function_6fb582373f167489();
            level.ruby_mq.var_7755638ed8800403 = 1;
        }
        
        params.trigger.interact.b_touched = 1;
        level thread function_3d8856cd1a497d8f();
    }
    else if ( level.ruby_mq.var_16120e7bf8d769e9[ 1 ] == params.trigger.num && utility::flag( "ruby_mq_s4_code_1" ) )
    {
        level utility::flag_set( "ruby_mq_s4_code_2" );
        fx_string = get_pillar_fx_string( params.trigger.id );
        params.trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( fx_string, "on" );
        params.trigger.interact.b_touched = 1;
        level thread function_3d8856cd1a497d8f();
    }
    else if ( level.ruby_mq.var_16120e7bf8d769e9[ 2 ] == params.trigger.num && utility::flag( "ruby_mq_s4_code_2" ) )
    {
        level utility::flag_set( "ruby_mq_s4_code_3" );
        fx_string = get_pillar_fx_string( params.trigger.id );
        params.trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( fx_string, "on" );
        params.trigger.interact.b_touched = 1;
        level thread function_3d8856cd1a497d8f();
    }
    else if ( level.ruby_mq.var_16120e7bf8d769e9[ 3 ] == params.trigger.num && utility::flag( "ruby_mq_s4_code_3" ) )
    {
        level utility::flag_set( "ruby_mq_s4_code_4" );
        fx_string = get_pillar_fx_string( params.trigger.id );
        params.trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( fx_string, "on" );
        params.trigger.interact.b_touched = 1;
        level thread function_3d8856cd1a497d8f();
    }
    else if ( level.ruby_mq.var_16120e7bf8d769e9[ 4 ] == params.trigger.num && utility::flag( "ruby_mq_s4_code_4" ) )
    {
        level utility::flag_set( "ruby_mq_s4_code_5" );
        fx_string = get_pillar_fx_string( params.trigger.id );
        params.trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( fx_string, "on" );
        params.trigger.interact.b_touched = 1;
        level thread function_3d8856cd1a497d8f();
        
        /#
            iprintlnbold( "<dev string:x269>" );
        #/
        
        level utility::flag_set( "ruby_mq_melody_obtained" );
        
        foreach ( player in level.players )
        {
            player thread function_c473ef2ca3032767( 0.5, 1 );
        }
        
        level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 1, 1, 1, undefined, 1, undefined, 1 );
        level utility::flag_set( "ruby_mq_complete" );
        level notify( #"hash_26dde81d56f8ec5e" );
        
        foreach ( player in level.players )
        {
            player playsoundtoplayer( "evt_success_stinger", player );
        }
        
        level thread function_7ac592ac172d3bb();
    }
    else
    {
        /#
            iprintlnbold( "<dev string:x280>" );
        #/
        
        level thread function_b665a7cd2ddc82cf( params.trigger.id, params.trigger.sc_pillar_fx );
        level thread function_fa3ef6894a5badfa();
        level.ruby_mq.var_9b8a918ab0c5e115++;
        level thread function_b8c9587385a4859a();
    }
    
    function_4ef47d3c5c627fb6();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xc5f20b64, Offset: 0x1a021
// Size: 0x70
function private get_pillar_fx_string( num )
{
    switch ( num )
    {
        case 1:
            return "trigger_1";
        case 2:
            return "trigger_2";
        case 3:
            return "trigger_3";
        case 4:
            return "trigger_4";
        case 5:
            return "trigger_5";
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x6b521129, Offset: 0x1a099
// Size: 0x7e
function private function_7ac592ac172d3bb()
{
    level endon( #"game_ended" );
    playsoundatpos( level.ruby_mq.var_ffebe7a1a6ab9c8e.origin, "evt_mq_alien_artifact_calling" );
    wait 1.5;
    playsoundatpos( level.ruby_mq.var_ffebe7a1a6ab9c8e.origin, "evt_mq_alien_artifact_calling" );
    wait 1.75;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_d0a26c46bd0bb74e" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x95650f14, Offset: 0x1a11f
// Size: 0x99
function private function_3d8856cd1a497d8f()
{
    level endon( #"game_ended" );
    level.ruby_mq.e_powermachine setscriptablepartstate( "correct", "on" );
    level.ruby_mq.var_b8ae8849bb629810 setscriptablepartstate( "correct", "on" );
    wait 3;
    level.ruby_mq.e_powermachine setscriptablepartstate( "correct", "off" );
    level.ruby_mq.var_b8ae8849bb629810 setscriptablepartstate( "correct", "off" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xd9954db, Offset: 0x1a1c0
// Size: 0x59
function private function_b665a7cd2ddc82cf( pillar_id, scriptable )
{
    level endon( #"game_ended" );
    fx_string = get_pillar_fx_string( pillar_id );
    scriptable utility::function_7c10ea82c1e305b8( fx_string, "fail" );
    wait 1.75;
    scriptable utility::function_7c10ea82c1e305b8( fx_string, "off" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x72ace2b2, Offset: 0x1a221
// Size: 0xc0
function private function_fa3ef6894a5badfa()
{
    level endon( #"game_ended" );
    level.ruby_mq.e_powermachine setscriptablepartstate( "wrong", "on" );
    level.ruby_mq.var_b8ae8849bb629810 setscriptablepartstate( "wrong", "on" );
    playsoundatpos( level.ruby_mq.var_ffebe7a1a6ab9c8e.origin, "evt_mq_alien_artifact_calling" );
    wait 3;
    level.ruby_mq.e_powermachine setscriptablepartstate( "wrong", "off" );
    level.ruby_mq.var_b8ae8849bb629810 setscriptablepartstate( "wrong", "off" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x811b0b7c, Offset: 0x1a2e9
// Size: 0x2fd
function private function_b8c9587385a4859a()
{
    if ( level.ruby_mq.var_9b8a918ab0c5e115 == 3 || level utility::flag( "ruby_mq_melody_timer_out" ) )
    {
        foreach ( player in level.players )
        {
            player playsoundtoplayer( "evt_fail_stinger", player );
        }
        
        foreach ( trigger in level.ruby_mq.var_e2f32ef1fd6fc6d3 )
        {
            if ( isdefined( trigger.interact ) )
            {
                trigger.interact.b_touched = 0;
            }
            
            if ( isdefined( trigger.sc_pillar_fx ) )
            {
                trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_1", "off" );
                trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_2", "off" );
                trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_3", "off" );
                trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_4", "off" );
                trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_5", "off" );
            }
        }
        
        for ( i = 1; i < 6 ; i++ )
        {
            basestring = "step4_mdl_pillar_";
            newstring = basestring + i;
            mdl_pillar = getent( newstring, "targetname" );
            pillar_name = function_13fc8c3423c65324( i );
            var_7a4f1802e5ef3cd = "red::";
            var_805e6e3dd2f790c8 = var_7a4f1802e5ef3cd + pillar_name;
            mdl_pillar setmodel( var_805e6e3dd2f790c8 );
        }
        
        level notify( #"melody_puzzle_failed" );
        level utility::flag_clear( "ruby_mq_s4_code_1" );
        level utility::flag_clear( "ruby_mq_s4_code_2" );
        level utility::flag_clear( "ruby_mq_s4_code_3" );
        level utility::flag_clear( "ruby_mq_s4_code_4" );
        level utility::flag_clear( "ruby_mq_s4_code_5" );
        level thread function_ec61711ee7fd267c();
        level utility::flag_set( "ruby_mq_melody_cooldown" );
        level.ruby_mq.var_37d1dcd68690da69 = zm_round_logic::get_rb_round_number() + 1;
        level callback::add( "on_round_start", &function_955c3ed3a5527a0b );
        function_4ef47d3c5c627fb6();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x143cbbd1, Offset: 0x1a5ee
// Size: 0x44
function private function_ec61711ee7fd267c()
{
    level endon( #"game_ended" );
    
    if ( !level utility::flag( "vo_melody_puzzle_failed" ) )
    {
        level utility::flag_set( "vo_melody_puzzle_failed" );
        wait 2;
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_ddf888ae44a7da6e" ] );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x25e5d172, Offset: 0x1a63a
// Size: 0x101
function private function_955c3ed3a5527a0b( params )
{
    level callback::remove( "on_round_start", &function_955c3ed3a5527a0b );
    level.ruby_mq.var_37d1dcd68690da69 = undefined;
    level.ruby_mq.var_9b8a918ab0c5e115 = 0;
    level.ruby_mq.var_7755638ed8800403 = 0;
    level utility::flag_clear( "ruby_mq_melody_cooldown" );
    level utility::flag_clear( "ruby_mq_melody_timer_out" );
    function_4ef47d3c5c627fb6();
    
    for ( i = 1; i < 6 ; i++ )
    {
        basestring = "step4_mdl_pillar_";
        newstring = basestring + i;
        mdl_pillar = getent( newstring, "targetname" );
        pillar_name = function_13fc8c3423c65324( i );
        var_7a4f1802e5ef3cd = "blue::";
        var_805e6e3dd2f790c8 = var_7a4f1802e5ef3cd + pillar_name;
        mdl_pillar setmodel( var_805e6e3dd2f790c8 );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x9874fcd5, Offset: 0x1a743
// Size: 0x8c
function private function_6fb582373f167489()
{
    level endon( #"game_ended" );
    level endon( #"melody_puzzle_failed" );
    level endon( #"hash_26dde81d56f8ec5e" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        var_f9073b9a68fe2fe = 180;
    }
    else
    {
        var_f9073b9a68fe2fe = 35;
    }
    
    for ( i = 1; i < var_f9073b9a68fe2fe ; i++ )
    {
        /#
            iprintlnbold( i );
        #/
        
        wait 1;
    }
    
    /#
        iprintlnbold( "<dev string:x28f>" );
    #/
    
    level utility::flag_set( "ruby_mq_melody_timer_out" );
    level thread function_b8c9587385a4859a();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xde37ff1d, Offset: 0x1a7d7
// Size: 0xb6
function private setup_voss_interact_final()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "ruby_mq_complete" );
    
    if ( isdefined( level.ruby_mq.perfusion_mars_interact ) )
    {
        level.ruby_mq.perfusion_mars_interact delete();
    }
    
    var_3150bc6e12cf8a52 = utility::getstruct( "step4_perfusion_mars_boss_interact", "targetname" );
    perfusion_mars_interact = interaction::register_interact( var_3150bc6e12cf8a52.origin, 100, &function_c2b48cc6b98a7287 );
    perfusion_mars_interact sethintonobstruction( "show" );
    perfusion_mars_interact interaction::set_interact_hint_callback( &function_617e124737236bd1 );
    level utility::flag_wait( "ruby_boss_triggered" );
    perfusion_mars_interact delete();
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x46ef0ff5, Offset: 0x1a895
// Size: 0x116
function private function_c2b48cc6b98a7287( player )
{
    /#
        iprintlnbold( "<dev string:x2b6>" );
    #/
    
    if ( level utility::flag( "start_final_step_vote" ) )
    {
        return;
    }
    
    level utility::flag_set( "start_final_step_vote" );
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.init_message = &"hash_368ffead421750f5";
    var_3faf858e79cd17bb.description = &"zm_hud/start_final_encounter";
    b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb );
    
    if ( !b_passed )
    {
        level utility::flag_clear( "start_final_step_vote" );
        return;
    }
    
    level utility::flag_clear( "start_final_step_vote" );
    
    if ( b_passed )
    {
        level val::set( "boss_fight", "task_logic_activate", 0 );
        level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 1, 1, 1, undefined, 1, undefined, 1 );
        function_b42f4f75b6ab69c8();
        level thread vo_boss_intro( player );
        level thread zm_sat_ruby_boss_fight::start_boss_fight();
        
        /#
            iprintlnbold( "<dev string:x2cb>" );
        #/
        
        level thread function_2eb6d04a5117eb1c();
        level utility::flag_set( "ruby_boss_triggered" );
        zm_quest::clear_all_guidance();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x65606d05, Offset: 0x1a9b3
// Size: 0xd6
function private function_b42f4f75b6ab69c8()
{
    if ( level utility::flag( "sq_echoes_activated" ) )
    {
        level callback::callback( "end_echoes_sq" );
    }
    
    var_2b43aa5f72b09914 = utility::getstructarray( "boss_mars_spawn", "targetname" );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ].origin[ 1 ] > var_2b43aa5f72b09914[ 0 ].origin[ 1 ] )
        {
            level.players[ i ] playsoundtoplayer( "evt_mq_portal_teleport", level.players[ i ] );
            var_2b43aa5f72b09914[ i ].target = "boss_mars_spawn";
            level thread zm_fasttravel::function_cbb08198e7c84adf( var_2b43aa5f72b09914[ i ], level.players[ i ] );
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x4844ec6c, Offset: 0x1aa91
// Size: 0x307
function private function_2eb6d04a5117eb1c()
{
    level endon( #"game_ended" );
    var_21a4d0c3cdc24f54 = getent( "ruby_boss_uranus_panel_script_model", #targetname );
    var_646c703284cdb287 = utility::getstruct( "step4_perfusion_mars_interact", "targetname" );
    var_ffebe7a1a6ab9c8e = utility::getstruct( "step4_alien_mars_interact", "targetname" );
    level.ruby_mq.e_powermachine = getent( "step4_power_machine", "targetname" );
    level.ruby_mq.var_b8ae8849bb629810 = spawnscriptable( %"sat_zm_ruby_alien_artifact_fx", var_ffebe7a1a6ab9c8e.origin );
    waitframe();
    var_21a4d0c3cdc24f54 setscriptablepartstate( "anim", "off" );
    var_21a4d0c3cdc24f54 setscriptablepartstate( "gravity", "off" );
    waitframe();
    var_21a4d0c3cdc24f54 setscriptablepartstate( "gravity", "off" );
    var_21a4d0c3cdc24f54 setscriptablepartstate( "anim", "closed" );
    playsoundatpos( var_646c703284cdb287.origin + ( 0, 0, 50 ), "evt_low_grav_off" );
    wait 1.5;
    level.ruby_mq.e_powermachine setscriptablepartstate( "correct", "on" );
    level.ruby_mq.var_b8ae8849bb629810 setscriptablepartstate( "correct", "on" );
    playsoundatpos( var_ffebe7a1a6ab9c8e.origin, "evt_mq_alien_artifact_calling" );
    playsoundatpos( var_646c703284cdb287.origin + ( 0, 0, 50 ), "evt_low_grav_start" );
    var_21a4d0c3cdc24f54 setscriptablepartstate( "gravity", "on" );
    var_21a4d0c3cdc24f54 setscriptablepartstate( "anim", "open" );
    wait 2.5;
    
    for ( i = 0; i < 3 ; i++ )
    {
        level.ruby_mq.e_powermachine setscriptablepartstate( "correct", "off" );
        level.ruby_mq.var_b8ae8849bb629810 setscriptablepartstate( "correct", "off" );
        var_21a4d0c3cdc24f54 setscriptablepartstate( "gravity", "off" );
        var_21a4d0c3cdc24f54 setscriptablepartstate( "anim", "closed" );
        playsoundatpos( var_646c703284cdb287.origin + ( 0, 0, 50 ), "evt_low_grav_off" );
        wait 2;
        level.ruby_mq.e_powermachine setscriptablepartstate( "correct", "on" );
        level.ruby_mq.var_b8ae8849bb629810 setscriptablepartstate( "correct", "on" );
        playsoundatpos( var_ffebe7a1a6ab9c8e.origin, "evt_mq_alien_artifact_calling" );
        playsoundatpos( var_646c703284cdb287.origin + ( 0, 0, 50 ), "evt_low_grav_start" );
        var_21a4d0c3cdc24f54 setscriptablepartstate( "gravity", "on" );
        var_21a4d0c3cdc24f54 setscriptablepartstate( "anim", "open" );
        wait 3;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x16164595, Offset: 0x1ada0
// Size: 0x89
function private function_617e124737236bd1( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/mars_sound_attractor", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0xc4984d5, Offset: 0x1ae31
// Size: 0x57
function private vo_boss_intro( player )
{
    level endon( #"game_ended" );
    level thread function_3ea91f55380c20ef( player );
    wait 17;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_68cef5c02edec246" ] );
    wait 9.5;
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_4fcf3ac8e691d618" ] );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x43726128, Offset: 0x1ae90
// Size: 0x4b
function private function_3ea91f55380c20ef( var_5e2221840c5be55d )
{
    var_db75d3de862ce072 = player_banter::play_banter_vo( #"hash_4d7b3929af593f3b" );
    
    if ( var_db75d3de862ce072 == 1 )
    {
        return;
    }
    
    var_5e2221840c5be55d thread zm_vo::function_8c1a12974bd11f01( #"hash_4d7b3929af593f3b", #"hash_5212ed7ec42f115a" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x5600a755, Offset: 0x1aee3
// Size: 0x54
function function_cc977b5a019a1486()
{
    self notify( #"hash_27ee568127a76ac3" );
    self endon( #"hash_27ee568127a76ac3" );
    level endon( #"game_ended" );
    utility::flag_wait( "ruby_boss_fight_complete" );
    zm_quest::function_4eefe6de31f5ddab( #"ruby_mq", #"boss_fight_complete", 1 );
    function_72adf9bde86f7364();
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x26d0c49, Offset: 0x1af3f
// Size: 0x3a
function function_c02b6e874043212c()
{
    self endon( #"disconnect" );
    self.var_14955bc056bab547 = 1;
    thread playerlogic::spawnclient();
    self waittill( #"spawned_player" );
    thread hud_util::fade_out( 0, "white" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0x361a9fa4, Offset: 0x1af81
// Size: 0x5ba
function function_72adf9bde86f7364( b_debug_play = 0 )
{
    level endon( #"game_ended" );
    overlord::function_f2fedd3be0be82ef();
    
    foreach ( player in level.players )
    {
        b_player_respawned = 0;
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player thread function_c02b6e874043212c();
            b_player_respawned = 1;
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
        
        if ( !b_player_respawned )
        {
            player thread hud_util::fade_out( 0.3, "white" );
        }
    }
    
    level.ruby_mq.var_62f90f25442a3708 thread scene::pre_stream( undefined, undefined, 2.5, "sat_cin_zm_ruby_outro" );
    wait 2;
    level thread igc_fade_in();
    
    foreach ( ammo_cache_loc in level._ammo_cache_info.var_ea07e36d8fd28578 )
    {
        ammo_cache_loc.ammocache_trigger.var_a3338cc37b82b7b3 setscriptablepartstate( "base", "hidden" );
        ammo_cache_loc.ammocache_trigger.var_a3338cc37b82b7b3 setscriptablepartstate( "light", "hidden" );
    }
    
    startnoninteractivesequence();
    level thread zm_quest::function_2850bf8c7015dc92( [ "zone_temple_center", "zone_temple_right", "zone_temple_displays", "zone_temple_left" ] );
    removeallcorpses();
    
    if ( isdefined( level.ruby_mq.var_62f90f25442a3708 ) )
    {
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"ruby_outro" );
        level.ruby_mq.var_62f90f25442a3708 scene::play( undefined, undefined, "sat_cin_zm_ruby_outro" );
    }
    
    teleport_pos = utility::getstruct( "post_quest_teleports", "targetname" );
    
    foreach ( player in level.players )
    {
        player val::reset_all( "outro_igc_scene" );
        player function_e19ccf4da1a61ba7( teleport_pos.origin );
        player clearclienttriggeraudiozone();
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"ruby_outro" );
    stopcinematicforall( 1, 1 );
    
    foreach ( ammo_cache_loc in level._ammo_cache_info.var_ea07e36d8fd28578 )
    {
        ammo_cache_loc.ammocache_trigger.var_a3338cc37b82b7b3 setscriptablepartstate( "base", "static" );
        ammo_cache_loc.ammocache_trigger.var_a3338cc37b82b7b3 setscriptablepartstate( "light", "base" );
    }
    
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
    
    level val::reset( "boss_fight", "task_logic_activate" );
    
    if ( !level val::get( "task_logic_activate" ) )
    {
        level val::set( "task_mq", "task_logic_activate" );
    }
    
    function_4d2cf7ef166227();
    level utility::flag_set( "outro_igc_completed" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x1aa5fafa, Offset: 0x1b543
// Size: 0x97
function igc_fade_in()
{
    level endon( #"game_ended" );
    wait 0.5;
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_in( 0.3, "white" );
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0xff4c1467, Offset: 0x1b5e2
// Size: 0x58
function function_78f9d6116fa25d95( teleport_pos )
{
    level endon( #"game_ended" );
    wait 1;
    level thread zm_quest::function_2e003fa13e881f92( teleport_pos );
    zm_fasttravel_core::function_298f7e021b71004( "portal_temple_b", 0, 0 );
    level thread zm_sat_ruby::function_620114dd2340ecc4();
    wait 33;
    zm_round_spawning::pause_round_spawning( 0, "ruby_boss_fight_pause_spawning" );
    level utility::flag_set( "rbz_allow_exfil" );
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0xaa07c35e, Offset: 0x1b642
    // Size: 0x5, Type: dev
    function private function_b7b20c0e462a1de()
    {
        
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0xae1a1dc1, Offset: 0x1b64f
// Size: 0x181
function function_e0386629059b2b26( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "ruby_boss_fight_complete" );
        level utility::flag_set( "ruby_boss_triggered" );
        
        if ( isdefined( level.ruby_mq.var_e2f32ef1fd6fc6d3 ) )
        {
            foreach ( trigger in level.ruby_mq.var_e2f32ef1fd6fc6d3 )
            {
                if ( isdefined( trigger.sc_pillar_fx ) )
                {
                    trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_1", "off" );
                    trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_2", "off" );
                    trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_3", "off" );
                    trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_4", "off" );
                    trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_5", "off" );
                }
            }
        }
        
        return;
    }
    
    level utility::flag_wait( "ruby_mq_complete" );
    level utility::flag_wait( "ruby_boss_fight_complete" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 2
// Checksum 0x169ce9f5, Offset: 0x1b7d8
// Size: 0x1c8
function cleanup_step_14( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"boss_fight_complete" ) ) && zm_quest::function_73720cdf21c3cfd7( #"ruby_mq", #"boss_fight_complete" ) == 1 )
        {
            level utility::flag_set( "ruby_boss_triggered" );
            level val::reset( "boss_fight", "task_logic_activate" );
            
            if ( !level val::get( "task_logic_activate" ) )
            {
                level val::set( "task_mq", "task_logic_activate" );
            }
            
            if ( isdefined( level.ruby_mq.var_e2f32ef1fd6fc6d3 ) )
            {
                foreach ( trigger in level.ruby_mq.var_e2f32ef1fd6fc6d3 )
                {
                    if ( isdefined( trigger.sc_pillar_fx ) )
                    {
                        trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_1", "off" );
                        trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_2", "off" );
                        trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_3", "off" );
                        trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_4", "off" );
                        trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_5", "off" );
                    }
                }
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x2875c613, Offset: 0x1b9a8
// Size: 0x53
function private function_1e30a2f3096d5879( item, spawn_pos )
{
    waitframe();
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( spawn_pos );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.critical = 1;
    common_item::items_spawnitemfromscriptable( item, 1, spawnoptions );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0x38a8ebd, Offset: 0x1ba03
// Size: 0x29f
function function_a1d5954d9e5b5897( params )
{
    switch ( params.bundle.ref )
    {
        case #"hash_86138a366d14c0eb":
            zm_quest::function_b57dfe9625966b0b( #"ruby_mq_misc", 0, #"key", 1 );
            zm_quest::show_splash_item_picked_up( #"ruby_mq_misc", #"key", 1, params.player );
            params.player playsoundtoplayer( "evt_mq_cryo_chamber_key_pickup", params.player );
            level utility::flag_set( "ruby_mq_key_picked" );
            break;
        case #"hash_bb6a1e17157b70ff":
            zm_quest::function_b57dfe9625966b0b( #"hash_4484054831f14f3e", 0, #"brain", 1 );
            zm_quest::show_splash_item_picked_up( #"hash_4484054831f14f3e", #"brain", 1, params.player );
            params.player playsoundtoplayer( "evt_mq_brain_pickup", params.player );
            level utility::flag_set( "ruby_mq_brain_picked" );
            break;
        case #"hash_1eaaca223dbe9a6a":
            zm_quest::function_b57dfe9625966b0b( #"ruby_mq_misc", 0, #"saw", 1 );
            zm_quest::show_splash_item_picked_up( #"ruby_mq_misc", #"saw", 1, params.player );
            params.player playsoundtoplayer( "uin_zm_common_pickup_item_mechanical", params.player );
            level utility::flag_set( "ruby_mq_saw_picked" );
            break;
        case #"hash_cb03460369f2e80b":
            zm_quest::function_b57dfe9625966b0b( #"ruby_mq_artifact", 0, #"alien", 1 );
            zm_quest::show_splash_item_picked_up( #"ruby_mq_artifact", #"alien", 1, params.player );
            params.player playsoundtoplayer( "uin_zm_common_pickup_item", params.player );
            level utility::flag_set( "ruby_mq_alien_artifact_picked" );
            break;
        case #"hash_2d87bba53901704f":
            zm_quest::function_b57dfe9625966b0b( #"ruby_mq_misc", 0, #"planet", 1 );
            zm_quest::show_splash_item_picked_up( #"ruby_mq_misc", #"planet", 1, params.player );
            params.player playsoundtoplayer( "uin_zm_common_pickup_item", params.player );
            level utility::flag_set( "ruby_mq_book_puzzle_complete" );
            break;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 3, eflags: 0x4
// Checksum 0xb47863e3, Offset: 0x1bcaa
// Size: 0x4a
function private function_c473ef2ca3032767( fade_out_time, fade_in_time, var_280fc6a5f41ac78 = "white" )
{
    self playsoundtoplayer( "evt_mq_white_out", self );
    hud_util::fade_out( fade_out_time, var_280fc6a5f41ac78 );
    hud_util::fade_in( fade_in_time, var_280fc6a5f41ac78 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xb6b991d5, Offset: 0x1bcfc
// Size: 0x102
function private set_perfusion_on_player()
{
    self.mdl_voss = utility::spawn_model( %"sat_zm_perfusion_machine_container_fxanim", ( 0, 0, 0 ) );
    self.mdl_voss.mdl_brain = utility::spawn_model( %"c_sat_zmb_global_brain", self.mdl_voss.origin + ( 0, 0, 11 ), self.mdl_voss.angles + ( 0, 90, 0 ) );
    self.mdl_voss.mdl_brain linkto( self.mdl_voss );
    waitframe();
    self.mdl_voss setscriptablepartstate( "stable", "on" );
    self.mdl_voss notsolid();
    self.mdl_voss linkto( self, "j_spine4", ( -14, 13, 10 ), ( 1, 95, 120 ) );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x9037d37a, Offset: 0x1be06
// Size: 0x43
function private function_ea846a83d774cd42()
{
    if ( isdefined( self.mdl_voss ) )
    {
        self.mdl_voss unlink();
        self.mdl_voss.mdl_brain delete();
        self.mdl_voss delete();
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x552e03b, Offset: 0x1be51
// Size: 0x130
function private function_5bbd540197e3fd()
{
    if ( self.magic_bullet_shield || val::get( "damageshield" ) )
    {
        return;
    }
    
    self endon( #"death" );
    wait randomfloatrange( 1, 1.25 );
    self.nuked = 1;
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.full_gib = 1;
    self.var_65522105f3bdca37 = 1;
    zombie_stun::stun_ai( 100 );
    impact_fx = utility::getfx( "zombie_impact" );
    var_b0a812f37b404b6e = utility::getfx( "zombie_impact_blood" );
    
    if ( isdefined( impact_fx ) && isdefined( var_b0a812f37b404b6e ) )
    {
        if ( self tagexists( "j_spine4" ) )
        {
            self.pap_stun_fx = playfxontag( impact_fx, self, "j_spine4" );
        }
        
        wait randomfloatrange( 0.5, 1 );
        
        if ( isalive( self ) && self tagexists( "j_spine4" ) )
        {
            self.pap_stun_fx = stopfxontag( impact_fx, self, "j_spine4" );
            self.pap_death_fx = playfxontag( var_b0a812f37b404b6e, self, "j_spine4" );
        }
    }
    
    wait 0.25;
    
    if ( isalive( self ) )
    {
        self kill();
    }
}

/#

    // Namespace zm_sat_ruby_quest_mq
    // Params 0
    // Checksum 0x83ece925, Offset: 0x1bf89
    // Size: 0x99, Type: dev
    function init_ruby_mq_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x2f2>" );
        devgui::add_devgui_func( "<dev string:x30a>", "<dev string:x315>", &debug_oscar_code );
        devgui::add_devgui_func( "<dev string:x320>", "<dev string:x32a>", &function_741764d29e732c1d );
        devgui::add_devgui_func( "<dev string:x334>", "<dev string:x347>", &function_6616dd1d6568dea9 );
        devgui::add_devgui_func( "<dev string:x353>", "<dev string:x353>", &function_6a26a6e28133aae4 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x367>" );
        devgui::add_devgui_func( "<dev string:x383>", "<dev string:x392>", &function_2237271c68053f80 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_ruby_quest_mq
    // Params 0
    // Checksum 0x60f46d33, Offset: 0x1c02a
    // Size: 0x5f, Type: dev
    function debug_oscar_code()
    {
        iprintlnbold( "<dev string:x3a1>" + level.ruby_mq.var_483e904399b9c1eb[ 0 ] + "<dev string:x3ae>" + level.ruby_mq.var_483e904399b9c1eb[ 1 ] + "<dev string:x3ae>" + level.ruby_mq.var_483e904399b9c1eb[ 2 ] );
    }

    // Namespace zm_sat_ruby_quest_mq
    // Params 0
    // Checksum 0xf3830d20, Offset: 0x1c091
    // Size: 0x57, Type: dev
    function function_741764d29e732c1d()
    {
        iprintlnbold( "<dev string:x3b0>" + level.ruby_mq.var_cda233a53fa2c3e9 + "<dev string:x3ae>" + level.ruby_mq.var_bf36b8b778fbad39 + "<dev string:x3ae>" + level.ruby_mq.var_23e333dbd46bed1e );
    }

    // Namespace zm_sat_ruby_quest_mq
    // Params 1
    // Checksum 0x79758fd0, Offset: 0x1c0f0
    // Size: 0x9d, Type: dev
    function function_6616dd1d6568dea9( player )
    {
        iprintlnbold( level.ruby_mq.var_16120e7bf8d769e9[ 0 ] + "<dev string:x3bb>" + level.ruby_mq.var_16120e7bf8d769e9[ 1 ] + "<dev string:x3bb>" + level.ruby_mq.var_16120e7bf8d769e9[ 2 ] + "<dev string:x3bb>" + level.ruby_mq.var_16120e7bf8d769e9[ 3 ] + "<dev string:x3bb>" + level.ruby_mq.var_16120e7bf8d769e9[ 4 ] );
    }

    // Namespace zm_sat_ruby_quest_mq
    // Params 1
    // Checksum 0x989baa1, Offset: 0x1c195
    // Size: 0x50, Type: dev
    function function_6a26a6e28133aae4( player )
    {
        level utility::flag_set( "<dev string:x3bc>" );
        level utility::flag_set( "<dev string:x3d6>" );
        level utility::flag_set( "<dev string:x3ed>" );
        level utility::flag_set( "<dev string:x406>" );
        level utility::flag_set( "<dev string:x424>" );
    }

    // Namespace zm_sat_ruby_quest_mq
    // Params 0
    // Checksum 0xf21bbec4, Offset: 0x1c1ed
    // Size: 0x37, Type: dev
    function debug_player_location()
    {
        while ( true )
        {
            zone_name = zone_manager::function_90e5c3e2272b0130( level.players[ 0 ].origin );
            wait 1;
        }
    }

    // Namespace zm_sat_ruby_quest_mq
    // Params 1
    // Checksum 0xe88d8ec4, Offset: 0x1c22c
    // Size: 0x19, Type: dev
    function function_2237271c68053f80( params )
    {
        wait 1;
        function_72adf9bde86f7364();
    }

#/

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0x12335d77, Offset: 0x1c24d
// Size: 0x33
function function_46bf415b00c9ab42( params )
{
    level utility::flag_set( "open_mars_portal" );
    level utility::flag_set( "open_mars_to_observatory_portal" );
    level utility::flag_set( "enable_mars_zones" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 1
// Checksum 0x1c4e4622, Offset: 0x1c288
// Size: 0x33
function debug_start_mq( params )
{
    level utility::flag_set( "wwq_step_2_complete" );
    level utility::flag_set( "wwq_step_3_complete" );
    level utility::flag_set( "wwq_step_7_complete" );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x1ecbb63b, Offset: 0x1c2c3
// Size: 0x48
function function_228aa73041447bd4()
{
    if ( getdvarint( @"hash_ec516ae9c461b3b2", 0 ) )
    {
        level utility::flag_wait( "ruby_papq_complete" );
        level utility::flag_set( "open_mars_portal" );
        level utility::flag_set( "open_mars_to_observatory_portal" );
        level utility::flag_set( "enable_mars_zones" );
        return;
    }
}

// Namespace zm_sat_ruby_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x38063a4, Offset: 0x1c313
// Size: 0x70
function private watch_open_sesame()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "open_sesame" );
    wait 3;
    level utility::flag_set( "open_mars_portal" );
    level utility::flag_set( "open_mars_to_observatory_portal" );
    level utility::flag_set( "enable_mars_zones" );
    waitframe();
    
    if ( !utility::flag( "ruby_boss_fight_start" ) )
    {
        level thread zm_sat_ruby::function_620114dd2340ecc4();
        return;
    }
    
    zm_fasttravel_core::function_298f7e021b71004( "portal_temple_b", 1, 1 );
}

// Namespace zm_sat_ruby_quest_mq
// Params 0
// Checksum 0x3d059180, Offset: 0x1c38b
// Size: 0x4c
function function_c2c09816ceccdead()
{
    while ( true )
    {
        playergravity = level.players[ 0 ] getlocalgravity();
        
        if ( playergravity < 800 && level utility::flag( "l_g_active" ) )
        {
            /#
                iprintlnbold( "<dev string:x442>" );
            #/
        }
        
        waitframe();
    }
}

