// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo.gsc  (hash_331ef457bc246ab7.gscc) (size: 20688 Bytes / 0x50d0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53196753 (1394173779)
// size ...... 20688 (0x50d0)
// includes .. 6   (offset: 0x4828)
// strings ... 165 (offset: 0x4858)
// dev strs .. 0   (offset: 0x50d0)
// exports ... 76  (offset: 0x3130)
// cseg ...... 0x17c0 + 0x1970 (0x3130)
// imports ... 76  (offset: 0x3d10)
// animtree1 . 0   (offset: 0x50d0)
// animtree2 . 0   (offset: 0x50d0)
#using scripts\anim\dialogue;
#using scripts\common\save;
#using scripts\common\utility;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_audio;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\overlord;

#namespace aries_vo;

/#

    // Namespace aries_vo
    // Params 0
    // Checksum 0x86efbae2, Offset: 0x17de
    // Size: 0x5, Type: dev
    function function_ad4ff05b329205f()
    {
        
    }

    // Namespace aries_vo
    // Params 0
    // Checksum 0xfdfe80e6, Offset: 0x17eb
    // Size: 0x5, Type: dev
    function function_45eef806df21f9b7()
    {
        
    }

#/

// Namespace aries_vo
// Params 2
// Checksum 0xd85b40d, Offset: 0x17f8
// Size: 0x3b
function function_5e829dfcff31a187( var_222727ae51abda5a, vo_alias )
{
    wait var_222727ae51abda5a;
    ai_soldier_closest = aries_util::function_41bc1c00b63773ec();
    
    if ( isdefined( ai_soldier_closest ) )
    {
        ai_soldier_closest dialogue::say_self( vo_alias, 0 );
    }
}

/#

    // Namespace aries_vo
    // Params 0
    // Checksum 0x77877df1, Offset: 0x183b
    // Size: 0x5, Type: dev
    function function_69c717f78309d99e()
    {
        
    }

#/

// Namespace aries_vo
// Params 0
// Checksum 0xe1371c9d, Offset: 0x1848
// Size: 0xba
function function_5708884067303551()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player thread function_392d72bdb96ee4f();
    }
    
    level endon( #"flag_end_objective_secure_area_1_jungle", #"flag_river_minefield_progress_02" );
    wait 1.5;
    level childthread function_b256f77516c7f83();
    level thread function_b09a1af15dc0134e();
    level childthread function_3c47ce81d1dde6e9();
}

// Namespace aries_vo
// Params 0
// Checksum 0x5672ed5a, Offset: 0x190a
// Size: 0x3a
function function_b256f77516c7f83()
{
    wait 1;
    overlord::function_be2d6dc71f97faa6( "river_jungle_we_still_at_the_docks" );
    overlord::function_be2d6dc71f97faa6( "river_jungle_franks_the_key_somehow" );
    level utility::flag_set( "flag_jungle_vo_find_woods_complete" );
    level thread aries_audio::function_b0501522ce363884();
    level thread function_df4cf9b665a95e0();
}

// Namespace aries_vo
// Params 0
// Checksum 0x1b6d9df1, Offset: 0x194c
// Size: 0x41
function function_df4cf9b665a95e0()
{
    level endon( #"flag_jungle_trg_grapple_first_cliffs" );
    level utility::flag_wait( "flag_trg_soldier_bodies_vo" );
    overlord::function_be2d6dc71f97faa6( "river_jungle_us_bodies" );
    wait 0.2;
    overlord::function_be2d6dc71f97faa6( "river_jungle_his_unit_never_left_angola" );
    level thread function_46c89a23f67ebdf7();
}

// Namespace aries_vo
// Params 0
// Checksum 0x69efa541, Offset: 0x1995
// Size: 0x94
function function_46c89a23f67ebdf7()
{
    level endon( #"flag_jungle_trg_grapple_first_cliffs" );
    level utility::flag_wait( "flag_grapple_hook_vo" );
    
    foreach ( player in level.players )
    {
        player thread grapple_nag();
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0x61f5a349, Offset: 0x1a31
// Size: 0x7a
function grapple_nag()
{
    player = self;
    player endon( #"death_or_disconnect" );
    level utility::flag_wait( "flag_grapple_hook_vo_start" );
    wait 1;
    
    if ( !player utility::ent_flag( "ent_flag_trg_grapple_first_cliffs" ) )
    {
        overlord::playevent( "river_jungle_got_our_climb_covered", [ player ] );
    }
    
    wait 15;
    
    if ( !player utility::ent_flag( "ent_flag_trg_grapple_first_cliffs" ) )
    {
        overlord::playevent( "river_jungle_grapple_nag", [ player ] );
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0x3324e52a, Offset: 0x1ab3
// Size: 0x64
function function_b09a1af15dc0134e()
{
    level endon( #"flag_waterfall_vo_entered" );
    level utility::flag_wait( "flag_jungle_trg_grapple_first_cliffs" );
    
    if ( !utility::flag( "river_jungle_vtol_liftoff_scene" ) )
    {
        overlord::function_be2d6dc71f97faa6( "river_jungle_grapple_this_things_got_serious_pull" );
    }
    
    wait 4;
    level utility::flag_set( "flag_jungle_audio_ambient_gunfire_stop" );
    overlord::playconversation( "river_jungle_woods_angola_context" );
    
    if ( !utility::flag( "flag_trg_encounter_1_area_entered" ) )
    {
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0x9fa52381, Offset: 0x1b1f
// Size: 0x78
function function_3c47ce81d1dde6e9()
{
    level endon( #"flg_jungle_clearing_soldiers_killed" );
    level utility::flag_wait( "river_jungle_vtol_liftoff_scene" );
    level utility::flag_wait_any( "flag_trg_encounter_1_area_entered", "flag_waterfall_vo_entered" );
    wait 1;
    overlord::playconversation( "river_jungle_guild_vtol_engage" );
    wait 2;
    
    if ( isdefined( level.var_1346376b067787f6 ) && level.var_1346376b067787f6.size > 0 && !utility::flag( "flg_jungle_clearing_soldiers_killed" ) )
    {
        overlord::function_be2d6dc71f97faa6( "river_jungle_hostiles_cliff" );
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0xd3c971e9, Offset: 0x1b9f
// Size: 0xa4
function function_392d72bdb96ee4f()
{
    player = self;
    player endon( #"death_or_disconnect" );
    level utility::flag_wait( "flg_jungle_clearing_soldiers_killed" );
    player utility::ent_flag_clear( "ent_flag_end_objective_secure_area_1_jungle" );
    wait 2.5;
    
    if ( !player utility::ent_flag( "ent_flag_end_objective_secure_area_1_jungle" ) )
    {
        overlord::playevent( "river_waterfall_lets_push_ahead", [ player ] );
    }
    
    wait 4.5;
    
    if ( !player utility::ent_flag( "ent_flag_end_objective_secure_area_1_jungle" ) )
    {
        overlord::playevent( "river_waterfall_memories_getting_mixed_up", [ player ] );
        wait 0.5;
        overlord::playevent( "river_waterfall_just_need_to_find_frank", [ player ] );
    }
}

/#

    // Namespace aries_vo
    // Params 0
    // Checksum 0x2de941d6, Offset: 0x1c4b
    // Size: 0x5, Type: dev
    function function_77b1d16aea76fbf8()
    {
        
    }

#/

// Namespace aries_vo
// Params 0
// Checksum 0x2032d1ff, Offset: 0x1c58
// Size: 0x22
function function_619b2bdb7e7d965c()
{
    level endon( #"game_ended" );
    level endon( #"flag_river_barge_activity_begin" );
    level childthread function_7f7432c4a3f425fc();
}

// Namespace aries_vo
// Params 0
// Checksum 0x9dca2dcd, Offset: 0x1c82
// Size: 0x3c
function function_7f7432c4a3f425fc()
{
    level utility::flag_wait( "flag_river_minefield_progress_01" );
    wait 2;
    overlord::playconversation( "river_trail_this_is_my_fight" );
    level utility::flag_wait( "flag_river_trail_ambush" );
    function_5e829dfcff31a187( 0.5, "dx_wc_arie_arjn_guie_dontletempastus" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xa97511d9, Offset: 0x1cc6
// Size: 0xaf
function function_1bb29a8bea831567()
{
    level endon( #"game_ended" );
    level endon( #"flag_river_barge_activity_begin" );
    level utility::flag_wait( "flag_river_trail_drones_defeated" );
    wait 2;
    overlord::function_be2d6dc71f97faa6( "river_trail_clear" );
    
    foreach ( player in level.players )
    {
        player childthread function_21b955da4a7910df();
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0x90e330e1, Offset: 0x1d7d
// Size: 0x43
function function_21b955da4a7910df()
{
    player = self;
    player endon( #"death_or_disconnect" );
    wait 5;
    
    if ( !player utility::ent_flag( "ent_flg_jungle_minefield_complete" ) )
    {
        overlord::playevent( "river_trail_nag_lets_catch_up_with_woods", [ player ] );
    }
}

/#

    // Namespace aries_vo
    // Params 0
    // Checksum 0x702ec076, Offset: 0x1dc8
    // Size: 0x5, Type: dev
    function function_80c04bfa7b32f534()
    {
        
    }

#/

// Namespace aries_vo
// Params 0
// Checksum 0xb7de08c4, Offset: 0x1dd5
// Size: 0xf2
function function_7a2e7db9891062df()
{
    level endon( #"game_ended", #"flag_river_base_barge_opened", #"aries_river_base_complete", #"OB_ARIES_NIGHTMARE_INTRO" );
    level.a_weakpoints = [];
    
    for ( i = 1; i < 4 ; i++ )
    {
        weakpoint = getscriptablearray( "e_jungle_root_" + i, #targetname )[ 0 ];
        level.a_weakpoints[ level.a_weakpoints.size ] = weakpoint;
    }
    
    if ( isarray( save::mission_get_data().var_e38d71218638a518 ) && save::mission_get_data().var_e38d71218638a518.size == 0 )
    {
        level childthread function_32dc1262150e2a9b();
        level childthread function_ff2b9a436b561ae1();
    }
    
    level childthread function_bc812ec11be1346e();
    level childthread function_db2c9e7f7ed941fc();
    level childthread function_c28426a083c414ff();
    level utility::flag_wait( "flag_barge_vines_cleared" );
    level thread function_f9cba5f144892cdf();
}

// Namespace aries_vo
// Params 0
// Checksum 0x74130e12, Offset: 0x1ecf
// Size: 0xb4
function function_32dc1262150e2a9b()
{
    level endon( #"flag_barge_vines_cleared" );
    level endon( #"flag_golden_path_vo_barge_active" );
    level utility::flag_wait( "flg_jungle_village_start_obj" );
    overlord::playconversation( "river_barge_intro" );
    
    foreach ( player in level.players )
    {
        player thread function_de187952b76e0686();
    }
    
    level thread function_7a211eba0bab9a26();
}

// Namespace aries_vo
// Params 0
// Checksum 0x312a8d2b, Offset: 0x1f8b
// Size: 0x5b
function function_de187952b76e0686()
{
    level endon( #"flag_cargo_inspect_intro" );
    level endon( #"FLAG_BARGE_VO_THESE_VINES_ARE_GONNA_BE_A_PROBLEM" );
    player = self;
    player endon( #"death_or_disconnect" );
    wait 7;
    
    if ( !player utility::ent_flag( "ent_flag_player_on_barge_touching" ) )
    {
        overlord::playevent( "river_barge_lets_get_it_open_move_in", [ player ] );
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0xdcb3074a, Offset: 0x1fee
// Size: 0xa3
function function_7a211eba0bab9a26()
{
    level utility::flag_wait_or_timeout( "flag_cargo_inspect_intro", 10 );
    level utility::flag_set( "FLAG_BARGE_VO_THESE_VINES_ARE_GONNA_BE_A_PROBLEM" );
    overlord::playconversation( "river_barge_vines_around_cargo" );
    
    foreach ( player in level.players )
    {
        player thread function_65c7e91946f8d32b();
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0x7e403777, Offset: 0x2099
// Size: 0x50
function function_65c7e91946f8d32b()
{
    player = self;
    player endon( #"death_or_disconnect" );
    wait 8;
    
    if ( !player utility::ent_flag( "flag_ent_trg_weakpoint_set_touching" ) )
    {
        overlord::playevent( "river_barge_we_should_see_where_those_vines_lead", [ player ] );
    }
    
    level utility::flag_set( "FLAG_BARGE_VO_FOLLOW_VINES" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xf4e7cce4, Offset: 0x20f1
// Size: 0x6d
function function_ff2b9a436b561ae1()
{
    level endon( #"flag_barge_vines_cleared" );
    level utility::waittill_any( "flag_trg_weakpoint_location_1", "flag_trg_weakpoint_location_2", "flag_trg_weakpoint_location_3" );
    level utility::flag_set( "flag_barge_first_growth_found" );
    level utility::flag_set( "flag_golden_path_vo_barge_active" );
    overlord::playconversation( "river_barge_first_growth_found" );
    level utility::flag_set( "flag_that_flower_doesnt_look_right_vo" );
    level utility::flag_clear( "flag_golden_path_vo_barge_active" );
    level childthread function_818b56ca87014df3();
}

// Namespace aries_vo
// Params 0
// Checksum 0x93e3feb6, Offset: 0x2166
// Size: 0x3d
function function_bc812ec11be1346e()
{
    level utility::flag_wait_any( "flg_jungle_root_1_dest", "flg_jungle_root_2_dest", "flg_jungle_root_3_dest" );
    level utility::flag_set( "flag_golden_path_vo_barge_active" );
    wait 5;
    overlord::playconversation( "river_barge_the_vines_are_dying" );
    level thread function_38f36fea08fa1e3d();
}

// Namespace aries_vo
// Params 0
// Checksum 0xa51cfcdb, Offset: 0x21ab
// Size: 0x56
function function_38f36fea08fa1e3d()
{
    level endon( #"flag_barge_vines_cleared" );
    level utility::waittill_any( "flag_trg_weakpoint_location_1", "flag_trg_weakpoint_location_2", "flag_trg_weakpoint_location_3" );
    level utility::flag_set( "flag_golden_path_vo_barge_active" );
    overlord::function_be2d6dc71f97faa6( "river_barge_second_growth_found" );
    level utility::flag_clear( "flag_golden_path_vo_barge_active" );
    wait 5;
    level thread function_9b1e872da476cb1a();
}

// Namespace aries_vo
// Params 0
// Checksum 0xc37c52b1, Offset: 0x2209
// Size: 0x4b
function function_9b1e872da476cb1a()
{
    level endon( #"flag_barge_vines_cleared" );
    level utility::waittill_any( "flag_trg_weakpoint_location_1", "flag_trg_weakpoint_location_2", "flag_trg_weakpoint_location_3" );
    level utility::flag_set( "flag_golden_path_vo_barge_active" );
    overlord::function_be2d6dc71f97faa6( "river_barge_third_growth_found" );
    level utility::flag_clear( "flag_golden_path_vo_barge_active" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xf79b69d, Offset: 0x225c
// Size: 0x3c
function function_818b56ca87014df3()
{
    level endon( #"flag_barge_vines_cleared" );
    wait 7;
    
    while ( level utility::flag( "flag_golden_path_vo_barge_active" ) || aries_util::function_3cbf328d51b124cc( level.a_weakpoints ) )
    {
        wait 0.1;
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0xf5649ba5, Offset: 0x22a0
// Size: 0x41
function function_db2c9e7f7ed941fc()
{
    level endon( #"flag_barge_vines_cleared" );
    
    while ( !isdefined( level.var_e769d589cbe6b0a7 ) || level.var_e769d589cbe6b0a7 < 2 )
    {
        wait 0.1;
    }
    
    overlord::function_be2d6dc71f97faa6( "river_barge_one_vine_left" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xe6bfa47a, Offset: 0x22e9
// Size: 0x4f
function function_c28426a083c414ff()
{
    level endon( #"flag_river_village_finalwave_defeated", #"flag_river_base_barge_opened" );
    level utility::flag_wait_all( "flg_jungle_root_1_dest", "flg_jungle_root_2_dest", "flg_jungle_root_3_dest" );
    level utility::flag_wait( "flag_barge_vines_cleared" );
    overlord::function_be2d6dc71f97faa6( "river_barge_vines_are_gone" );
    level childthread function_4c233abe72eb0318();
}

// Namespace aries_vo
// Params 0
// Checksum 0x32a2d3fe, Offset: 0x2340
// Size: 0x2e
function function_4c233abe72eb0318()
{
    level endon( #"flag_river_village_finalwave_defeated", #"flag_river_base_barge_opened" );
    wait 5;
    overlord::playconversation( "river_barge_they_dont_want_us_on_that_barge" );
    level thread function_fced8d63611ba43c();
}

// Namespace aries_vo
// Params 0
// Checksum 0xd2f6b6b3, Offset: 0x2376
// Size: 0x26
function function_fced8d63611ba43c()
{
    level endon( #"flag_player_on_barge_touching", #"flag_barge_vines_cleared" );
    wait 9;
    overlord::function_be2d6dc71f97faa6( "river_barge_attack_the_barge" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xe5b50989, Offset: 0x23a4
// Size: 0x36
function function_f9cba5f144892cdf()
{
    level endon( #"OB_ARIES_NIGHTMARE_INTRO" );
    level endon( #"flag_river_base_barge_opened" );
    level endon( #"game_ended" );
    level childthread function_d611c50277c0e52d();
    level childthread function_c2202ab8e25eca4b();
}

// Namespace aries_vo
// Params 0
// Checksum 0x33e061ee, Offset: 0x23e2
// Size: 0x3e
function function_d611c50277c0e52d()
{
    level endon( #"flag_river_barge_dawg_killed" );
    level utility::flag_wait_all( "flag_barge_final_dawg_spawned", "flag_player_on_barge_touching" );
    wait 3;
    
    if ( !utility::flag( "flag_river_barge_dawg_killed" ) )
    {
        overlord::playconversation( "river_barge_pup_dawg" );
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0x1da0f463, Offset: 0x2428
// Size: 0x4c
function function_c2202ab8e25eca4b()
{
    level endon( #"OB_ARIES_NIGHTMARE_INTRO" );
    level utility::flag_wait_all( "flag_player_on_barge_touching", "flag_barge_vines_cleared" );
    level utility::flag_set( "flag_vo_player_on_barge" );
    level utility::flag_wait( "flag_river_village_finalwave_defeated" );
    wait 3.5;
    overlord::playconversation( "river_barge_get_container_open" );
}

/#

    // Namespace aries_vo
    // Params 0
    // Checksum 0x2cacc1bb, Offset: 0x247c
    // Size: 0x5, Type: dev
    function function_a31df1d4ee8d627e()
    {
        
    }

#/

// Namespace aries_vo
// Params 0
// Checksum 0x7aff1d8f, Offset: 0x2489
// Size: 0x3b
function function_6cad3ca9d99ddd23()
{
    level endon( #"game_ended" );
    level endon( #"OB_ARIES_NIGHTMARE_CONTAINERTOWER", #"flag_aries_nightmare_narr_arena_complete" );
    level childthread function_52dfb05323a76e39();
    level childthread function_c6605ca8fffe0367();
    level childthread function_52159848565d0021();
}

// Namespace aries_vo
// Params 0
// Checksum 0x2c645356, Offset: 0x24cc
// Size: 0x69
function function_52dfb05323a76e39()
{
    level endon( #"hash_1303df00f55bb349", #"flag_aries_nightmare_maze_intro_combat_complete" );
    wait 3.5;
    overlord::function_be2d6dc71f97faa6( "nightmare_maze_damage_ability" );
    level utility::flag_wait_or_timeout( "flag_trg_intro_maze_vo", 7 );
    overlord::playconversation( "nightmare_maze_start" );
    level utility::flag_wait( "flag_end_find_woods_maze_objective" );
    level endon( #"flag_aries_nightmare_maze_intro_combat_spawned" );
    overlord::playconversation( "nightmare_corridor_is_that_woods" );
}

// Namespace aries_vo
// Params 0
// Checksum 0x62a9cc43, Offset: 0x253d
// Size: 0x36
function function_c6605ca8fffe0367()
{
    level endon( #"hash_1303df00f55bb349", #"flag_aries_nightmare_maze_intro_combat_complete" );
    level utility::flag_wait( "flag_aries_nightmare_maze_intro_combat_spawned" );
    wait 1.8;
    overlord::playconversation( "nightmare_maze_incoming_hell_are_these_things" );
}

// Namespace aries_vo
// Params 0
// Checksum 0x939f1514, Offset: 0x257b
// Size: 0x75
function function_52159848565d0021()
{
    level utility::flag_wait( "flag_aries_nightmare_maze_intro_combat_complete" );
    overlord::playconversation( "nightmare_pre_memory_1" );
    level utility::flag_wait( "flg_nmr_woods_memory_1_starting" );
    level utility::flag_set( "flag_nm_maze_woods_memory_01_narration_start" );
    wait 1;
    overlord::playconversation( "nightmare_maze_woods_memory_1" );
    level utility::flag_set_delayed( "flag_nm_maze_woods_memory_01_narration_complete", 1 );
    wait 1.5;
    overlord::playconversation( "nightmare_maze_woods_memory_1_reaction" );
    level utility::flag_set( "FLAG_NM_MAZE_WOODS_MEMORY_01_REACTION" );
}

/#

    // Namespace aries_vo
    // Params 0
    // Checksum 0x3b299db5, Offset: 0x25f8
    // Size: 0x5, Type: dev
    function function_cfe876bbc7220613()
    {
        
    }

#/

// Namespace aries_vo
// Params 0
// Checksum 0x292bbf7a, Offset: 0x2605
// Size: 0x34
function function_3ecb014591099be8()
{
    level endon( #"game_ended" );
    level endon( #"OB_ARIES_NIGHTMARE_CONTAINERTOWER" );
    level.var_3b46797533852f1e = 0;
    level thread function_bd0827091d9a376a();
    level thread nightmare_maze_weakpoint_destroyed();
}

// Namespace aries_vo
// Params 0
// Checksum 0x5ce2b25c, Offset: 0x2641
// Size: 0x46
function function_effe77bd5c8d9a71()
{
    level endon( #"flag_aries_nightmare_tower_entered" );
    
    if ( level.var_3b46797533852f1e == 0 )
    {
        level.var_3b46797533852f1e = 1;
        wait 1.5;
        overlord::playconversation( "nightmare_maze_get_out_of_here_david" );
        level utility::flag_set( "FLAG_NM_MAZE_VO_WOODS_DAVID_END" );
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0x70205654, Offset: 0x268f
// Size: 0xe
function function_3e89eb44c5ef466e()
{
    overlord::function_be2d6dc71f97faa6( "nightmare_maze_nag_one_wrong_turn" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xc739f3cf, Offset: 0x26a5
// Size: 0x3b
function function_bd0827091d9a376a()
{
    level endon( #"flag_maze_room_weakpoint_obj_destroyed" );
    level endon( #"flag_aries_nightmare_tower_entered" );
    level utility::flag_wait_any( "flag_aries_nightmare_maze_tomb_left_entered", "flag_aries_nightmare_maze_tomb_right_entered" );
    wait 2;
    overlord::playconversation( "nightmare_maze_like_fucking_parasites" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xf1a8937f, Offset: 0x26e8
// Size: 0x1d
function function_46272aed8c75dda7()
{
    level endon( #"flag_maze_room_weakpoint_obj_destroyed" );
    wait 3;
    overlord::function_be2d6dc71f97faa6( "nightmare_maze_weakpoint_nag" );
}

// Namespace aries_vo
// Params 0
// Checksum 0x3f86244d, Offset: 0x270d
// Size: 0x2a
function nightmare_maze_weakpoint_destroyed()
{
    level endon( #"flag_aries_nightmare_tower_entered" );
    level utility::flag_wait( "flag_maze_room_weakpoint_obj_destroyed" );
    wait 4;
    overlord::playconversation( "nightmare_maze_this_place_is_messed_up" );
}

/#

    // Namespace aries_vo
    // Params 0
    // Checksum 0xc03bf6e2, Offset: 0x273f
    // Size: 0x5, Type: dev
    function function_e7b06c42560858ad()
    {
        
    }

#/

// Namespace aries_vo
// Params 0
// Checksum 0x582afb, Offset: 0x274c
// Size: 0x3e
function function_e47d4dd40b082759()
{
    level endon( #"game_ended" );
    level thread function_9a346b9612a176ae();
    level thread function_a002b2c873061135();
    level thread function_63af1d8d35c19512();
    level thread function_fb90f01870c5104d();
    level thread function_9a30723d61b6f0();
    level thread function_3e836d5e48b6e0b4();
}

// Namespace aries_vo
// Params 0
// Checksum 0x2a7d83ba, Offset: 0x2792
// Size: 0x71
function function_9a346b9612a176ae()
{
    if ( isdefined( level.var_8fb6fb776504865c ) )
    {
        return;
    }
    
    var_a3204f30e38fd4d3 = utility::getstruct( "str_wp_final_container", "targetname" );
    level.var_8fb6fb776504865c = utility::spawn_tag_origin();
    level.var_8fb6fb776504865c.origin = var_a3204f30e38fd4d3.origin;
    level utility::flag_wait( "flag_aries_nightmare_crashsite_complete" );
    level.var_8fb6fb776504865c = undefined;
}

// Namespace aries_vo
// Params 0
// Checksum 0xe686cbd6, Offset: 0x280b
// Size: 0x27
function function_a002b2c873061135()
{
    level endon( #"flag_nm_tower_woods_memory_02_narration_start" );
    level utility::flag_wait( "flag_aries_nightmare_tower_entered" );
    overlord::playconversation( "nightmare_containertower_its_the_barge" );
}

// Namespace aries_vo
// Params 0
// Checksum 0x879814c8, Offset: 0x283a
// Size: 0x3a
function function_63af1d8d35c19512()
{
    level utility::flag_wait( "flg_nmr_woods_memory_2_starting" );
    level utility::flag_set( "flag_nm_tower_woods_memory_02_narration_start" );
    overlord::playconversation( "nightmare_containertower_memory_2" );
    level utility::flag_set_delayed( "flag_nm_tower_woods_memory_02_narration_complete", 1 );
}

// Namespace aries_vo
// Params 0
// Checksum 0x766a7e6, Offset: 0x287c
// Size: 0x45
function function_fb90f01870c5104d()
{
    level utility::flag_wait( "flag_nm_tower_woods_memory_02_narration_complete" );
    wait 2;
    overlord::playconversation( "nightmare_containertower_memory_2_reaction" );
    wait 5;
    overlord::playconversation( "nightmare_containertower_you_did_what_you_thought_was_right", level.players );
    wait 12;
    overlord::playconversation( "nightmare_containertower_whats_waiting_for_us_up_there" );
}

// Namespace aries_vo
// Params 0
// Checksum 0x323c5138, Offset: 0x28c9
// Size: 0x62
function function_9a30723d61b6f0()
{
    level endon( #"flag_nm_tower_weakpoints_set_a_complete" );
    utility::flag_wait( "flag_aries_nightmare_tower_water_level_90" );
    overlord::playconversation( "nightmare_containertower_weakpoints_active" );
    wait 25;
    
    if ( !utility::flag( "flag_nm_tower_weakpoints_set_a_complete" ) )
    {
        overlord::function_be2d6dc71f97faa6( "nightmare_maze_weakpoint_nag_2" );
    }
    
    wait 25;
    
    if ( !utility::flag( "flag_nm_tower_weakpoints_set_a_complete" ) )
    {
        overlord::function_be2d6dc71f97faa6( "nightmare_maze_weakpoint_nag_3" );
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0xcd6ea99f, Offset: 0x2933
// Size: 0x20
function function_3e836d5e48b6e0b4()
{
    utility::flag_wait( "flag_nm_tower_weakpoints_set_a_complete" );
    wait 1.5;
    overlord::function_be2d6dc71f97faa6( "nightmare_containertower_weakpoints_destroyed" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xd8bd413b, Offset: 0x295b
// Size: 0x64
function function_c3bb957cf92cb470()
{
    level utility::flag_wait_all( "flag_aries_nightmare_tower_complete", "flag_trg_containertower_exit_obj" );
    wait 3;
    overlord::playconversation( "nightmare_containertower_container_looks_like_the_one_in_avalon" );
    level.var_8fb6fb776504865c dialogue::say_self( "dx_wc_arie_anct_wood_itoldyoutostayawayha", 0.1 );
    
    if ( isdefined( level.var_8fb6fb776504865c ) )
    {
        level.var_8fb6fb776504865c dialogue::say_self( "dx_wc_arie_anct_wood_whatwasfuckingtearin", 0.1 );
    }
}

/#

    // Namespace aries_vo
    // Params 0
    // Checksum 0x8c65c9a8, Offset: 0x29c7
    // Size: 0x5, Type: dev
    function function_5e8206ee0ea2f1cd()
    {
        
    }

#/

// Namespace aries_vo
// Params 0
// Checksum 0xadaedb11, Offset: 0x29d4
// Size: 0x5c
function function_1f42bde6804fa376()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance childthread function_959f4353fc667e75();
    function_2872f9364c561780();
    level utility::flag_wait( "flag_mars_intro_vo_complete" );
    activity_instance childthread function_470eff5b029c2392();
    activity_instance thread function_cd08a42075a83696();
    activity_instance childthread function_69785e88c42d9fa0();
    activity_instance childthread function_a9c410ec302b590d();
}

// Namespace aries_vo
// Params 0
// Checksum 0x234fca5a, Offset: 0x2a38
// Size: 0x36
function function_1ffcad08f896e065()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance childthread function_959f4353fc667e75();
    activity_instance childthread function_69785e88c42d9fa0();
    activity_instance childthread function_5a59ef56ca423992();
}

// Namespace aries_vo
// Params 0
// Checksum 0xdb9650f0, Offset: 0x2a76
// Size: 0x2d
function function_7ef59c243046d603()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance childthread function_959f4353fc667e75();
    activity_instance thread function_827aca795834b00b();
}

// Namespace aries_vo
// Params 0
// Checksum 0x22a307cf, Offset: 0x2aab
// Size: 0x85
function function_959f4353fc667e75()
{
    self notify( #"hash_629f8bc9b56ded3d" );
    self endon( #"hash_629f8bc9b56ded3d" );
    
    while ( !isdefined( level.mars_ai ) )
    {
        waitframe();
    }
    
    level.var_27837ff2d1335b4b = utility::spawn_tag_origin();
    level.var_27837ff2d1335b4b.origin = level.mars_ai.var_39226c238ed4b176.origin;
    level.var_27837ff2d1335b4b.team = "axis";
}

// Namespace aries_vo
// Params 0
// Checksum 0x96d3a25a, Offset: 0x2b38
// Size: 0xb3
function function_2872f9364c561780()
{
    level endon( #"aries_boss_phasetwo_complete" );
    wait 1.5;
    
    if ( isdefined( level.var_27837ff2d1335b4b ) )
    {
        overlord::function_be2d6dc71f97faa6( "boss_intro_david_woods?!" );
    }
    
    wait 2;
    
    if ( isdefined( level.var_27837ff2d1335b4b ) )
    {
        level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_abin_wood_iwarnedyoutoldyoutos", 0 );
    }
    
    level utility::flag_set( "flag_mars_intro_vo_complete" );
    
    if ( !level utility::flag( "flag_mars_players_shoot_immune_heads" ) )
    {
        overlord::function_be2d6dc71f97faa6( "boss_intro_harper_the_fuck!?" );
    }
    
    wait 7;
    
    if ( !level utility::flag( "flag_mars_players_shoot_immune_heads" ) )
    {
        if ( isdefined( level.var_27837ff2d1335b4b ) )
        {
            level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_anct_wood_itsgettinghungryagai", 3 );
        }
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0xc4bf641f, Offset: 0x2bf3
// Size: 0x70
function function_470eff5b029c2392()
{
    level endon( #"aries_boss_phaseone_complete" );
    level endon( #"aries_boss_phasetwo_complete" );
    level utility::flag_wait_or_timeout( "flag_mars_players_shoot_immune_heads", 13 );
    overlord::playconversation( "boss_growths_were_not_even_scratchin_it" );
    overlord::playconversation( "boss_growths_it_has_growths_on_it" );
    wait 5;
    level utility::flag_set( "flag_mars_hint_growths" );
    wait 15;
    
    if ( !level utility::flag( "flag_mars_weak_point_destroyed" ) )
    {
        overlord::playconversation( "boss_fucking_a_its_got_friends" );
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0x7f18488c, Offset: 0x2c6b
// Size: 0x68
function function_cd08a42075a83696()
{
    level endon( #"game_ended" );
    level endon( #"aries_boss_phaseone_complete" );
    level endon( #"aries_boss_phasetwo_complete" );
    utility::flag_wait( "flag_mars_weak_point_destroyed" );
    wait 3;
    
    if ( isdefined( level.var_27837ff2d1335b4b ) )
    {
        level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_abin_wood_thatfuckinghurt", 2 );
    }
    
    wait 3;
    overlord::function_be2d6dc71f97faa6( "boss_growths_its_weakening_keep_hitting_it" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xfb824658, Offset: 0x2cdb
// Size: 0x3a
function function_69785e88c42d9fa0()
{
    level utility::flag_wait( "FLAG_MARS_HEADS_STUNNED" );
    wait 2;
    
    if ( !utility::flag( "FLAG_MARS_HEADS_STUNNED_VO" ) )
    {
        overlord::playconversation( "boss_head_is_stunned" );
    }
    
    level utility::flag_set( "FLAG_MARS_HEADS_STUNNED_VO" );
}

// Namespace aries_vo
// Params 0
// Checksum 0x346f3679, Offset: 0x2d1d
// Size: 0x4f
function function_a9c410ec302b590d()
{
    level endon( #"game_ended" );
    level endon( #"aries_boss_phasetwo_complete" );
    level utility::flag_wait( "aries_boss_phase_1_5_started" );
    overlord::playconversation( "boss_add_phase_theyre_protecting_it" );
    level utility::flag_wait( "aries_boss_phase_1_5_complete" );
    wait 4;
    overlord::function_be2d6dc71f97faa6( "boss_keep_going_its_getting_weaker" );
}

// Namespace aries_vo
// Params 0
// Checksum 0x6df62c8, Offset: 0x2d74
// Size: 0x7d
function function_5a59ef56ca423992()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.var_27837ff2d1335b4b ) )
    {
        level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_abin_wood_icantfightitanymored", 0.5 );
    }
    
    wait 2;
    overlord::function_be2d6dc71f97faa6( "boss_growths_target_the_open_growths_david" );
    wait 60;
    
    if ( isdefined( level.var_27837ff2d1335b4b ) )
    {
        level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_abin_wood_dontletittakeyoudont", 0.2 );
    }
    
    wait 10;
    overlord::playconversation( "boss_this_hallucination_gonna_let_up" );
}

// Namespace aries_vo
// Params 0
// Checksum 0x77aec8ea, Offset: 0x2df9
// Size: 0x7e
function function_e9d6588d6b0c34f5()
{
    childthread function_959f4353fc667e75();
    level endon( #"FLAG_MARS_HEADS_ACTIVE_VO" );
    wait 3;
    overlord::function_be2d6dc71f97faa6( "boss_growths_are_gone" );
    wait 3;
    overlord::function_be2d6dc71f97faa6( "boss_goddamn_its_still_too_strong" );
    wait 3;
    
    if ( isdefined( level.var_27837ff2d1335b4b ) )
    {
        level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_abin_wood_youcantescape", 2 );
    }
    
    if ( isdefined( level.var_27837ff2d1335b4b ) )
    {
        level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_abin_wood_itfeedsoffyoulikeago", 2 );
    }
}

// Namespace aries_vo
// Params 0
// Checksum 0xb8c6a0b, Offset: 0x2e7f
// Size: 0xb5
function function_827aca795834b00b()
{
    level endon( #"FLAG_MARS_DYING" );
    mars_instance = level.mars_ai;
    mars_instance waittill( #"mars_phasethree_start" );
    level utility::flag_set( "FLAG_MARS_HEADS_ACTIVE_VO" );
    wait 2;
    
    if ( !utility::flag( "FLAG_MARS_FIRST_HEAD_DESTROYED_VO" ) )
    {
        overlord::function_be2d6dc71f97faa6( "boss_its_getting_weak_shoot_the_heads" );
    }
    
    level utility::flag_set( "flag_mars_hint_head" );
    wait 10;
    level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_abin_wood_thejunglealwayswinsc", 0.5 );
    wait 2;
    level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_abin_wood_saveyourselfdavid", 0.2 );
    wait 1.5;
    overlord::function_be2d6dc71f97faa6( "boss_not_gonna_let_you_rot_inside_this_monster" );
}

// Namespace aries_vo
// Params 0
// Checksum 0x92014b0b, Offset: 0x2f3c
// Size: 0x54
function function_84686b7424cd7ef1()
{
    level endon( #"flag_mars_one_head_remaining" );
    level utility::flag_set( "FLAG_MARS_FIRST_HEAD_DESTROYED_VO" );
    wait 2;
    
    if ( isdefined( level.var_27837ff2d1335b4b ) )
    {
        level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_abin_wood_gahhh", 2 );
    }
    
    wait 1;
    overlord::function_be2d6dc71f97faa6( "boss_one_head_down" );
}

// Namespace aries_vo
// Params 0
// Checksum 0x68af6e04, Offset: 0x2f98
// Size: 0xa3
function function_2b9466f9d7f3c3eb()
{
    level utility::flag_wait( "flag_mars_one_head_remaining" );
    utility::flag_wait_or_timeout( "FLAG_MARS_DYING", 2 );
    
    if ( isdefined( level.var_27837ff2d1335b4b ) && !utility::flag( "FLAG_MARS_DYING" ) )
    {
        level.var_27837ff2d1335b4b dialogue::say_self( "dx_wc_arie_abin_wood_exhaustedefforts", 2 );
    }
    
    if ( !utility::flag( "FLAG_MARS_DYING" ) )
    {
        overlord::function_be2d6dc71f97faa6( "boss_the_final_head!" );
    }
    
    if ( !utility::flag( "FLAG_MARS_DYING" ) )
    {
        overlord::function_be2d6dc71f97faa6( "boss_weve_got_it" );
    }
    
    level utility::flag_wait( "FLAG_MARS_DYING" );
    overlord::function_be2d6dc71f97faa6( "boss_fuck_that_thing" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xf1fbf51, Offset: 0x3043
// Size: 0x5a
function growth_flags()
{
    level utility::flag_wait_any( "flg_jungle_root_1_dest", "flg_jungle_root_2_dest", "flg_jungle_root_3_dest" );
    level utility::flag_set( "first_growth_destroyed" );
    
    while ( !isdefined( level.var_e769d589cbe6b0a7 ) || level.var_e769d589cbe6b0a7 < 2 )
    {
        wait 0.1;
    }
    
    level utility::flag_set( "second_growth_destroyed" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xd3f57f06, Offset: 0x30a5
// Size: 0x21
function function_e941331e8502edc5()
{
    level utility::flag_wait_any( "flag_aries_nightmare_maze_tomb_left_entered", "flag_aries_nightmare_maze_tomb_right_entered" );
    level utility::flag_set( "spiders_attack_flag" );
}

// Namespace aries_vo
// Params 0
// Checksum 0xdfa93cf9, Offset: 0x30ce
// Size: 0x2d
function function_8ce9c98a3e988538()
{
    level utility::flag_wait( "flg_nmr_woods_memory_1_starting" );
    overlord::playconversation( "conv_aries_nm_woods_memory_1_starting" );
    level utility::flag_set_delayed( "flag_nm_maze_woods_memory_01_narration_complete", 1 );
}

// Namespace aries_vo
// Params 0
// Checksum 0x7f6be042, Offset: 0x3103
// Size: 0x2d
function function_2a86cda8d1c308e1()
{
    level utility::flag_wait( "flg_nmr_woods_memory_2_starting" );
    overlord::playconversation( "conv_aries_nm_woods_memory_2_starting" );
    level utility::flag_set_delayed( "flag_nm_tower_woods_memory_02_narration_complete", 1 );
}

