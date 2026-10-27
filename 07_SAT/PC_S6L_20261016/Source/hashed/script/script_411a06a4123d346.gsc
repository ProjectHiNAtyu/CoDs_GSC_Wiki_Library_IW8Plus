// script_411a06a4123d346  (hash_0411a06a4123d346.gscc) (size: 32995 Bytes / 0x80e3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc2a30e75 (3265465973)
// size ...... 32995 (0x80e3)
// includes .. 20  (offset: 0x76bf)
// strings ... 128 (offset: 0x775f)
// dev strs .. 6   (offset: 0x809b)
// exports ... 65  (offset: 0x51af)
// cseg ...... 0xd5e + 0x4451 (0x51af)
// imports ... 200 (offset: 0x5bd7)
// animtree1 . 0   (offset: 0x80e3)
// animtree2 . 0   (offset: 0x80e3)
#using script_2399696a9d953451;
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\snd\snd;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;

#namespace namespace_f6592da7cc080d6f;

/#

    // Namespace namespace_f6592da7cc080d6f
    // Params 0
    // Checksum 0x8310231, Offset: 0xd7c
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_f6592da7cc080d6f
// Params 0, eflags: 0x5
// Checksum 0x995344f4, Offset: 0xd89
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d65c6c5a18adf450", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0, eflags: 0x4
// Checksum 0xdb651523, Offset: 0xdb2
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_NM_2";
    activity_common::registeractivitytype( "OB_GEMINI_NM_2", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_2", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_2", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_2", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_NM_2" );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x601d6f65, Offset: 0xe29
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance nightmare_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x12561750, Offset: 0xe8e
// Size: 0x5f
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    level.request_ids = [];
    
    if ( !ob::nightmare() )
    {
        activity_instance waittill( #"hash_1e9bc5e84aa89155" );
    }
    
    activity_instance thread nightmare_main();
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x950699ce, Offset: 0xef5
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0x405c3802, Offset: 0xf19
// Size: 0x9f
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_f6592da7cc080d6f
    // Params 0
    // Checksum 0x4f8ba621, Offset: 0xfc0
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0x4cc2a9a6, Offset: 0xfcd
// Size: 0x30
function player_setup( player )
{
    if ( isdefined( level.var_3f03988b3b665431 ) )
    {
        player thread ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_nm_oscar", level.var_3f03988b3b665431 );
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x794133ce, Offset: 0x1005
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0xdc4bd9c7, Offset: 0x100f
// Size: 0x1d4
function nightmare_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_GEMINI_NM_2";
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_medkit_surface", "flag_nm_surface_complete", 1 );
    level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    level._effect[ "sag_boss_sniper_laser" ] = loadfxasset( "vfx_sat_ob_sag_prya_red_laser_beam" );
    level._effect[ "sag_boss_sniper_trail" ] = loadfxasset( "vfx_sat_ob_sag_prya_tracer_largebolt_w" );
    level._effect[ "sag_boss_sniper_glint" ] = loadfxasset( "vfx_sat_sag_boss_sniper_glint" );
    level._effect[ "laser_spawn_vfx" ] = loadfxasset( "vfx_sat_levels_wc_cradle_site_laser" );
    level._effect[ "generator_beam" ] = loadfxasset( "vfx_sat_saw_avalon_cradle_warp_portal_sky_beam" );
    level._effect[ "generator_death" ] = loadfxasset( "vfx_sat_levels_wc_cradle_site_clean_blast" );
    struct = utility::getstruct( "struct_gemini_nm_surface", "targetname" );
    ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_shadow_break", "super_bubble_shield", #"default" );
    level thread setup_tower_defense_walls();
    level thread defend_fail_spawn();
    utility::add_fx( "spawn_smoke", "vfx_sat_mp_ob_gem_cradle_tornado_rot_1" );
    ob_nm_mode::function_1f2648b3b22d9816( undefined, "nm_overlord_glich_start" );
    tower_defense();
    ob_nm_mode::nightmare_prepare();
    level utility::flag_set( "flag_tower_defense_done" );
    oscar_fight();
    ob_nm_mode::nightmare_teleport( "OB_GEMINI_NM_3" );
    level thread ob_nm_mode::function_5dd43e7cb0682d57( "struct_gemini_nm_surface_br", "OB_GEMINI_NM_3" );
    level utility::flag_set( "flag_nm_surface_complete" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x5c84500a, Offset: 0x11eb
// Size: 0x1be
function surface_circle()
{
    var_9a7b20e173174021 = 4096;
    radius = 800;
    var_cf306bbdec90ce = 5;
    struct = utility::getstruct( "struct_gemini_nm_surface_br", "targetname" );
    var_17c94bd4556610bb = struct.origin;
    circle = ob_nm_mode::function_21689e5c8bddd87c( var_17c94bd4556610bb, var_9a7b20e173174021 );
    circle brcirclemoveto( var_17c94bd4556610bb[ 0 ], var_17c94bd4556610bb[ 1 ], radius, var_cf306bbdec90ce );
    level thread ob_nm_mode::update_minimap_circle( circle, var_17c94bd4556610bb, var_17c94bd4556610bb, var_9a7b20e173174021, radius, var_cf306bbdec90ce );
    level utility::flag_wait( "flag_tower_defense_done" );
    circle endon( #"hash_13f6e13328c0a077" );
    waitframe();
    var_9a7b20e173174021 = 800;
    radius = 1000;
    var_cf306bbdec90ce = 5;
    circle brcirclemoveto( var_17c94bd4556610bb[ 0 ], var_17c94bd4556610bb[ 1 ], radius, var_cf306bbdec90ce );
    level thread ob_nm_mode::update_minimap_circle( circle, var_17c94bd4556610bb, var_17c94bd4556610bb, var_9a7b20e173174021, radius, var_cf306bbdec90ce );
    level utility::flag_wait( "oscar_phase_01" );
    
    if ( isdefined( level.var_3f03988b3b665431 ) )
    {
        var_9a7b20e173174021 = 1000;
        radius = 800;
        var_cf306bbdec90ce = 5;
        circle brcirclemoveto( var_17c94bd4556610bb[ 0 ], var_17c94bd4556610bb[ 1 ], radius, var_cf306bbdec90ce );
        level thread ob_nm_mode::update_minimap_circle( circle, var_17c94bd4556610bb, var_17c94bd4556610bb, var_9a7b20e173174021, radius, var_cf306bbdec90ce );
        level utility::flag_wait_any( "flag_sniper_boss_done", "flag_oscar_boss_done" );
    }
    
    level utility::flag_wait( "oscar_phase_02" );
    
    if ( isdefined( level.var_3f03988b3b665431 ) )
    {
        var_9a7b20e173174021 = 800;
        radius = 500;
        var_cf306bbdec90ce = 5;
        circle brcirclemoveto( var_17c94bd4556610bb[ 0 ], var_17c94bd4556610bb[ 1 ], radius, var_cf306bbdec90ce );
        level thread ob_nm_mode::update_minimap_circle( circle, var_17c94bd4556610bb, var_17c94bd4556610bb, var_9a7b20e173174021, radius, var_cf306bbdec90ce );
        level utility::flag_wait_any( "flag_sniper_boss_done", "flag_oscar_boss_done" );
    }
    
    level notify( #"stop_circle" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x1ee8b6f, Offset: 0x13b1
// Size: 0x12
function defend_fail_spawn()
{
    level thread defend_fail();
    level thread function_dbdfa4ab004f4b67();
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x15ec2f72, Offset: 0x13cb
// Size: 0x7b
function function_dbdfa4ab004f4b67()
{
    level utility::flag_wait( "flag_defense_goal_destroyed_2" );
    
    if ( !level utility::flag( "flag_tower_defense_done" ) )
    {
        struct = utility::getstruct( "struct_nm_defend_goal_attractor_2", "targetname" );
        extra_ai = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_mimic_hvt_ob", struct.origin, ( 0, 0, 0 ), "team_two_hundred" );
        extra_ai thread ob_nm_mode::individual_vanish( "flag_tower_defense_done" );
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0xd010480b, Offset: 0x144e
// Size: 0x7b
function defend_fail()
{
    level utility::flag_wait( "flag_defense_goal_destroyed" );
    
    if ( !level utility::flag( "flag_tower_defense_done" ) )
    {
        struct = utility::getstruct( "struct_nm_defend_goal_attractor", "targetname" );
        extra_ai = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_mimic_hvt_ob", struct.origin, ( 0, 0, 0 ), "team_two_hundred" );
        extra_ai thread ob_nm_mode::individual_vanish( "flag_tower_defense_done" );
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x9acff6f, Offset: 0x14d1
// Size: 0x1bb
function tower_defense()
{
    level utility::flag_set( "flag_tower_defense" );
    level.enemy_count_array = [ 12, 16, 20, 24 ];
    level.cadence_override = 0.5;
    level.minion_kill_obj = level.players.size * 72;
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_br_start", "nm_wave_threat_start" );
    ob_story_mission_utils::objective_text_show( %"hash_21b2ae1c009d406e" );
    level utility::flag_set( "flag_killcount_event" );
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    time_modifier = 600;
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    level.minions_killed = 0;
    level thread surface_circle();
    wait 5;
    
    if ( level.minion_kill_obj <= 100 )
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( level.minions_killed, level.minion_kill_obj );
    }
    else
    {
        fraction = level.minions_killed / level.minion_kill_obj;
        percent = int( fraction * 100 );
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( percent, 100 );
    }
    
    thread function_7f67b328bb3a2b60();
    
    while ( level.minions_killed < level.minion_kill_obj )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_stop_beam" );
    level utility::flag_clear( "flag_killcount_event" );
    level utility::flag_set( "flag_tower_defense_done" );
    level utility::flag_clear( "flag_tower_defense" );
    level notify( #"hash_aefc5c470125baf8" );
    waitframe();
    wait 3;
    ob_nm_mode::end_of_round_fanfare( undefined, "nm_wave_threat_end" );
    function_a25acb62ddab20e2( "nm_minion_zombie", 0 );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0xa3ccc00f, Offset: 0x1694
// Size: 0x2f3
function function_7f67b328bb3a2b60()
{
    level endon( #"hash_aefc5c470125baf8" );
    level thread ob_nm_mode::play_spawn_smoke( "struct_nm_surface_spawn_1", "flag_stop_wave_1" );
    level thread function_69fd7cd14ea350cf( "struct_nm_surface_spawn_1", "flag_stop_wave_1" );
    level thread ob_nm_mode::play_spawn_smoke( "struct_nm_surface_spawn_1", "flag_stop_wave_1", "laser_spawn_vfx" );
    thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_surface_activity", "flag_stop_wave_1" );
    
    while ( level.minions_killed < level.minion_kill_obj * 0.25 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_stop_wave_1" );
    level notify( #"hash_f8318a5d48451de5" );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    wait 3;
    level thread ob_nm_mode::play_spawn_smoke( "struct_nm_surface_spawn_2", "flag_stop_wave_2" );
    level thread function_69fd7cd14ea350cf( "struct_nm_surface_spawn_2", "flag_stop_wave_2" );
    level thread ob_nm_mode::play_spawn_smoke( "struct_nm_surface_spawn_2", "flag_stop_wave_2", "laser_spawn_vfx" );
    thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_surface_activity_2", "flag_stop_wave_2" );
    struct = utility::getstruct( "struct_nm_surface_spawn_2", "targetname" );
    extra_ai = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_mangler_ob", struct.origin, struct.angles, "team_two_hundred" );
    extra_ai thread ob_nm_mode::individual_vanish( "flag_tower_defense_done" );
    
    while ( level.minions_killed < level.minion_kill_obj * 0.5 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_stop_wave_2" );
    level thread ob_nm_mode::play_spawn_smoke( "struct_nm_surface_spawn_3", "flag_stop_wave_3" );
    level thread function_69fd7cd14ea350cf( "struct_nm_surface_spawn_3", "flag_stop_wave_3" );
    level thread ob_nm_mode::play_spawn_smoke( "struct_nm_surface_spawn_3", "flag_stop_wave_3", "laser_spawn_vfx" );
    level notify( #"hash_f8318a5d48451de5" );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    wait 3;
    thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_surface_activity_3", "flag_stop_wave_3" );
    
    while ( level.minions_killed < level.minion_kill_obj * 0.75 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_stop_wave_3" );
    level thread ob_nm_mode::play_spawn_smoke( "struct_nm_surface_spawn_4a", "flag_tower_defense_done" );
    level thread function_69fd7cd14ea350cf( "struct_nm_surface_spawn_4a", "flag_tower_defense_done" );
    level thread ob_nm_mode::play_spawn_smoke( "struct_nm_surface_spawn_4a", "flag_tower_defense_done", "laser_spawn_vfx" );
    level thread ob_nm_mode::play_spawn_smoke( "struct_nm_surface_spawn_4b", "flag_tower_defense_done" );
    level thread function_69fd7cd14ea350cf( "struct_nm_surface_spawn_4b", "flag_tower_defense_done" );
    level thread ob_nm_mode::play_spawn_smoke( "struct_nm_surface_spawn_4b", "flag_tower_defense_done", "laser_spawn_vfx" );
    level notify( #"hash_f8318a5d48451de5" );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    wait 3;
    thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_surface_activity_4", "flag_tower_defense_done" );
    struct = utility::getstruct( "struct_nm_surface_spawn_4a", "targetname" );
    extra_ai = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_mangler_ob", struct.origin, struct.angles, "team_two_hundred" );
    extra_ai thread ob_nm_mode::individual_vanish( "flag_tower_defense_done" );
}

// Namespace namespace_f6592da7cc080d6f
// Params 2
// Checksum 0xd4585258, Offset: 0x198f
// Size: 0x77
function function_69fd7cd14ea350cf( var_dc6a4b4b351da087, flag_to_end )
{
    var_ad0e9d3a09d4bfb7 = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    
    if ( !isdefined( var_ad0e9d3a09d4bfb7 ) )
    {
        return;
    }
    
    loop_sound = snd::play( "evt_gemini_spawn_beam_lp", var_ad0e9d3a09d4bfb7.origin + ( 0, 0, 100 ) );
    level utility::flag_wait( flag_to_end );
    snd::stop( loop_sound );
}

// Namespace namespace_f6592da7cc080d6f
// Params 2
// Checksum 0x8aa03d47, Offset: 0x1a0e
// Size: 0x31
function function_dd0ca23209211df7( base_origin, z_offset = 128 )
{
    snd::play( "evt_nm_defend_canister_transition", base_origin + ( 0, 0, z_offset ) );
}

// Namespace namespace_f6592da7cc080d6f
// Params 3
// Checksum 0x9c729f0d, Offset: 0x1a47
// Size: 0x5e
function function_e13d49e1c3ca50e9( ent, z_offset = 128, delay = 0 )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    snd::play( "evt_nm_defend_canister_transition", ent.origin + ( 0, 0, z_offset ) );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x90115461, Offset: 0x1aad
// Size: 0x309
function setup_tower_defense_walls()
{
    move_time = 10;
    var_522a0d096cf619db = getent( "struct_nm_defend_goal_model", "targetname" );
    goal_model_2 = getent( "struct_nm_defend_goal_model_2", "targetname" );
    
    if ( isdefined( var_522a0d096cf619db ) )
    {
        level thread function_e13d49e1c3ca50e9( var_522a0d096cf619db, 128, 8 );
    }
    
    if ( isdefined( goal_model_2 ) )
    {
        level thread function_e13d49e1c3ca50e9( goal_model_2, 128, 8 );
    }
    
    defense_pieces = getentarray( "nm_defend_goal", "script_noteworthy" );
    
    foreach ( piece in defense_pieces )
    {
        if ( issubstr( piece.targetname, "clip" ) )
        {
            piece.origin += ( 0, 0, 1024 );
            continue;
        }
        
        piece movez( 1024, move_time );
    }
    
    waitframe();
    
    foreach ( piece in defense_pieces )
    {
        if ( issubstr( piece.targetname, "clip" ) )
        {
            piece disconnectpaths();
        }
    }
    
    defense_pieces = getentarray( "nm_defend_goal_2", "script_noteworthy" );
    
    foreach ( piece in defense_pieces )
    {
        if ( issubstr( piece.targetname, "clip" ) )
        {
            piece.origin += ( 0, 0, 1024 );
            continue;
        }
        
        piece movez( 1024, move_time );
    }
    
    waitframe();
    
    foreach ( piece in defense_pieces )
    {
        if ( issubstr( piece.targetname, "clip" ) )
        {
            piece disconnectpaths();
        }
    }
    
    wait move_time;
    level thread function_403b979712702f40( "goal_1", 1 );
    level thread function_403b979712702f40( "goal_2", 2 );
}

// Namespace namespace_f6592da7cc080d6f
// Params 2
// Checksum 0xa46fabee, Offset: 0x1dbe
// Size: 0x424
function function_403b979712702f40( goal, sub_objective_index )
{
    if ( goal == "goal_1" )
    {
        goal_struct_name = "struct_nm_defend_goal";
        var_146b85126df38821 = "struct_nm_defend_goal_attackpoint";
        attractor_name = "struct_nm_defend_goal_attractor";
        model_name = "struct_nm_defend_goal_model";
        var_cdb665c03b873a33 = "flag_defense_goal_destroyed";
        clip_name = "nm_defend_goal";
    }
    else
    {
        goal_struct_name = "struct_nm_defend_goal_2";
        var_146b85126df38821 = "struct_nm_defend_goal_attackpoint_2";
        attractor_name = "struct_nm_defend_goal_attractor_2";
        model_name = "struct_nm_defend_goal_model_2";
        var_cdb665c03b873a33 = "flag_defense_goal_destroyed_2";
        clip_name = "nm_defend_goal_2";
    }
    
    var_73b8002ea49e30f = utility::getstruct( goal_struct_name, "targetname" );
    attackpoints = utility::getstructarray( var_146b85126df38821, "targetname" );
    attractor = utility::getstruct( attractor_name, "targetname" );
    var_73b8002ea49e30f.model = getent( model_name, "targetname" );
    var_73b8002ea49e30f.model hudoutlineenable( "outline_nodepth_cyan" );
    var_73b8002ea49e30f.model setcandamage( 1 );
    var_73b8002ea49e30f.model.health = 60000;
    
    if ( level.players.size == 1 )
    {
        var_73b8002ea49e30f.model.health = 80000;
    }
    
    player_team = level.players[ 0 ].team;
    var_73b8002ea49e30f.attractor = zombie_attractor_manager::add_attractor( attractor, 2, 15000, 1, undefined, &function_c3feb48178878d07, undefined, player_team );
    zombie_attractor_manager::set_attractor_slots( var_73b8002ea49e30f.attractor, attackpoints );
    zombie_attractor_manager::function_e8b05e26d8b2ede( var_73b8002ea49e30f.attractor, var_73b8002ea49e30f.model );
    var_73b8002ea49e30f childthread function_72a328ee4b48a09f( var_73b8002ea49e30f.attractor, attackpoints, 0, var_cdb665c03b873a33, clip_name, sub_objective_index );
    level utility::flag_wait_any( var_cdb665c03b873a33, "flag_tower_defense_done" );
    level notify( var_cdb665c03b873a33 );
    zombie_attractor_manager::remove_attractor( attractor );
    
    if ( isdefined( var_73b8002ea49e30f.model ) )
    {
        var_73b8002ea49e30f.model hudoutlinedisable();
    }
    
    objidpoolmanager::objective_show_progress( var_73b8002ea49e30f.defend_obj_id, 0 );
    level.nm_activity_instance ob_story_mission_utils::mission_objective_marker_clear( var_73b8002ea49e30f.defend_obj_id );
    
    if ( level utility::flag( "flag_tower_defense_done" ) && isdefined( var_73b8002ea49e30f.model ) )
    {
        var_73b8002ea49e30f.model hudoutlinedisable();
        function_dd0ca23209211df7( var_73b8002ea49e30f.model.origin, 128 );
        var_73b8002ea49e30f.model movez( -1024, 10 );
        wait 5;
        defense_pieces = getentarray( clip_name, "script_noteworthy" );
        
        foreach ( piece in defense_pieces )
        {
            if ( issubstr( piece.targetname, "clip" ) )
            {
                piece connectpaths();
                waitframe();
                piece delete();
            }
        }
        
        return;
    }
    
    if ( isdefined( var_73b8002ea49e30f.model ) )
    {
        var_73b8002ea49e30f.model delete();
    }
    
    defense_pieces = getentarray( clip_name, "script_noteworthy" );
    
    foreach ( piece in defense_pieces )
    {
        if ( issubstr( piece.targetname, "clip" ) )
        {
            piece connectpaths();
            waitframe();
            piece delete();
        }
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 2
// Checksum 0x8d7dc1a, Offset: 0x21ea
// Size: 0x102
function function_c3feb48178878d07( attractor, zombie )
{
    low_classname = tolower( zombie.classname );
    
    if ( !issubstr( low_classname, "zombie_base" ) )
    {
        return 0;
    }
    
    if ( level utility::flag( "flag_tower_defense_done" ) )
    {
        return 0;
    }
    
    if ( isdefined( level.players ) )
    {
        player = function_47c86977a18df38b( level.players, zombie.origin, 3500 );
        buffer_dist = 100;
        
        if ( isdefined( player ) && distance2dsquared( zombie.origin, player.origin ) + buffer_dist < distance2dsquared( zombie.origin, attractor.source.origin ) )
        {
            return 0;
        }
    }
    
    if ( isdefined( zombie.var_bd22ba6c600a23a3 ) )
    {
        return 0;
    }
    
    if ( isalive( zombie ) && isdefined( attractor ) )
    {
        return 1;
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 6
// Checksum 0xdb771b75, Offset: 0x22f4
// Size: 0x2a9
function function_72a328ee4b48a09f( attractor, attackpoints, var_6af945c8e95c7e11, var_cdb665c03b873a33, clip_name, sub_objective_index )
{
    self.model endon( #"destroyed" );
    level endon( var_cdb665c03b873a33 );
    max_health = self.model.health;
    self.defend_obj_id = level.nm_activity_instance ob_story_mission_utils::function_b9cb179f9577f32a( self.model.origin, 160, undefined, "sat_ob_objectivemarker_location" );
    objidpoolmanager::objective_show_progress( self.defend_obj_id, 1 );
    objidpoolmanager::objective_set_progress( self.defend_obj_id, 1 );
    level.nm_activity_instance mission_ui::function_d84701041f6f95c2( sub_objective_index, 100, 100 );
    
    while ( true )
    {
        self.model waittill( #"damage", amount, attacker, direction, point, damage_type, modelname, tagname, partname, idflags, objweapon );
        
        if ( isplayer( attacker ) )
        {
            continue;
        }
        
        self.model.health -= amount;
        
        if ( self.model.health <= 0 )
        {
            break;
        }
        
        ratio = self.model.health / max_health;
        percent = clamp( ratio * 100, 0, 100 );
        level.nm_activity_instance mission_ui::function_d84701041f6f95c2( sub_objective_index, int( percent ), 100 );
        objidpoolmanager::objective_set_progress( self.defend_obj_id, ratio );
        
        /#
            iprintln( "<dev string:x24>" + string( self.model.health ) );
        #/
        
        self.model notify( #"damage_modify" );
    }
    
    level.nm_activity_instance mission_ui::function_d84701041f6f95c2( sub_objective_index, 0, 100 );
    self.wall_destr = 1;
    playfx( level._effect[ "generator_death" ], self.model.origin );
    level utility::flag_set( "flag_stop_beam" );
    level utility::flag_set( var_cdb665c03b873a33 );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x62bbaaa6, Offset: 0x25a5
// Size: 0x19b
function function_cb6dbc1d33ee48fa()
{
    self show();
    
    if ( !isdefined( self.var_740415965a2eb2ba ) )
    {
        self.var_740415965a2eb2ba = utility::function_1808878d1c511ce8( self.origin, self.angles );
        self.var_740415965a2eb2ba linkto( self );
    }
    
    if ( isdefined( self.var_3cc0f79e91e77927 ) )
    {
        snd::stop( self.var_3cc0f79e91e77927, 0.1 );
        self.var_3cc0f79e91e77927 = undefined;
    }
    
    self.var_3cc0f79e91e77927 = snd::play( "evt_nm_ufo_lp", level.var_e9826a04dfff266a );
    s_ufo_spawn_in = utility::getstruct( "s_ufo_spawn_in", "targetname" );
    self moveto( s_ufo_spawn_in.origin, 2 );
    self waittill( #"movedone" );
    s_ufo_spawn_low = utility::getstruct( "s_ufo_spawn_low", "targetname" );
    self moveto( s_ufo_spawn_low.origin, 1 );
    self waittill( #"movedone" );
    thread function_eea0ce21e1489174();
    wait 2;
    level utility::flag_set( "flag_oscar_spawn_start" );
    level utility::flag_wait( "flag_oscar_spawn_done" );
    s_ufo_spawn_exit = utility::getstruct( "s_ufo_spawn_exit", "targetname" );
    self moveto( s_ufo_spawn_exit.origin, 1 );
    self waittill( #"movedone" );
    
    if ( isdefined( self.var_3cc0f79e91e77927 ) )
    {
        snd::stop( self.var_3cc0f79e91e77927, 0.15 );
        self.var_3cc0f79e91e77927 = undefined;
    }
    
    self stopsounds();
    self hide();
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x768ceb94, Offset: 0x2748
// Size: 0x126
function function_eea0ce21e1489174()
{
    var_8bccb506331c9fb7 = undefined;
    var_eaada132213b266d = undefined;
    playfxontag( level._effect[ "generator_beam" ], level.var_e9826a04dfff266a, "tag_origin" );
    snd::play( "evt_nm_ufo_blue_beam_start", level.var_e9826a04dfff266a );
    blue_beam_start = level.var_e9826a04dfff266a.origin;
    blue_beam_end = physicstrace( blue_beam_start, blue_beam_start + ( 0, 0, -2500 ) );
    var_45ee8847de0206c3 = blue_beam_end + ( 0, 0, 24 );
    var_eaada132213b266d = utility::function_1808878d1c511ce8( var_45ee8847de0206c3 );
    snd::play( "evt_nm_ufo_blue_beam_start", var_eaada132213b266d );
    var_8bccb506331c9fb7 = snd::play( "evt_nm_ufo_blue_beam_lp", var_eaada132213b266d );
    level utility::flag_wait( "flag_oscar_spawn_done" );
    stopfxontag( level._effect[ "generator_beam" ], level.var_e9826a04dfff266a, "tag_origin" );
    
    if ( isdefined( var_8bccb506331c9fb7 ) )
    {
        snd::stop( var_8bccb506331c9fb7, 0.1 );
    }
    
    if ( isdefined( var_eaada132213b266d ) )
    {
        var_eaada132213b266d stopsounds();
        var_eaada132213b266d delete();
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x90e04cb2, Offset: 0x2876
// Size: 0xb0
function function_e084c690ff5aeaf()
{
    ai_oscar = self;
    var_bf1316595b384341 = ai_oscar.health;
    num_phases = 5;
    level.var_abbebdb114e4f57f = 1;
    
    while ( isalive( ai_oscar ) )
    {
        ai_oscar waittill( #"damage" );
        
        while ( level.var_abbebdb114e4f57f < num_phases + 1 )
        {
            health_threshold = var_bf1316595b384341 - var_bf1316595b384341 / num_phases * level.var_abbebdb114e4f57f;
            
            while ( ai_oscar.health > health_threshold )
            {
                waitframe();
            }
            
            ai_oscar notify( #"hash_6cd38ca88a606a31" );
            level.var_abbebdb114e4f57f++;
        }
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x1f2a78ee, Offset: 0x292e
// Size: 0xd0
function function_f5237780dd76c517()
{
    level.var_3f03988b3b665431 endon( #"death" );
    level thread function_5009c4789c0cec7e();
    max_health = level.var_3f03988b3b665431.maxhealth;
    thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_surface_boss", "oscar_phase_01" );
    
    while ( level.var_3f03988b3b665431.health > max_health * 0.66 )
    {
        waitframe();
    }
    
    level utility::flag_set( "oscar_phase_01" );
    thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_surface_boss_2", "oscar_phase_02" );
    
    while ( level.var_3f03988b3b665431.health > max_health * 0.33 )
    {
        waitframe();
    }
    
    level utility::flag_set( "oscar_phase_02" );
    thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_surface_boss_3", "flag_oscar_boss_done" );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x3ced49d1, Offset: 0x2a06
// Size: 0xaa
function function_5009c4789c0cec7e()
{
    level.var_3f03988b3b665431 endon( #"death" );
    max_health = level.var_3f03988b3b665431.maxhealth;
    level thread shock_stick_threshold( 0.9 );
    level thread shock_stick_threshold( 0.8 );
    level thread shock_stick_threshold( 0.7 );
    level thread shock_stick_threshold( 0.6 );
    level thread shock_stick_threshold( 0.5 );
    level thread shock_stick_threshold( 0.4 );
    level thread shock_stick_threshold( 0.3 );
    level thread shock_stick_threshold( 0.2 );
    level thread shock_stick_threshold( 0.1 );
}

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0xa664173d, Offset: 0x2ab8
// Size: 0x6f
function shock_stick_threshold( value )
{
    level.var_3f03988b3b665431 endon( #"death" );
    max_health = level.var_3f03988b3b665431.maxhealth;
    
    while ( level.var_3f03988b3b665431.health > max_health * value )
    {
        waitframe();
    }
    
    level thread ob_nm_mode::function_3b33d641fd3a8730( level.var_3f03988b3b665431 );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x61273158, Offset: 0x2b2f
// Size: 0x96
function function_93b119c7db94b888()
{
    m_oscar_ufo = getent( "m_oscar_ufo", "targetname" );
    m_oscar_ufo notify( #"hash_8ca490ff1d96b5c8" );
    function_f75032908020663e( m_oscar_ufo );
    function_c2345841dbc9163b( m_oscar_ufo );
    struct_nm_ufo_attack_start = utility::getstruct( "struct_nm_ufo_attack_start", "targetname" );
    s_ufo_spawn_exit = utility::getstruct( "s_ufo_spawn_exit", "targetname" );
    var_e52843286f269826 = utility::getstructarray( "struct_nm_ufo_attack_pos", "targetname" );
    m_oscar_ufo function_282e7e6d7e2ae3fa( struct_nm_ufo_attack_start, var_e52843286f269826, s_ufo_spawn_exit );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x7bfaacb, Offset: 0x2bcd
// Size: 0x190
function function_93b11cc7db94bf21()
{
    m_oscar_ufo = getent( "m_oscar_ufo", "targetname" );
    m_oscar_ufo show();
    struct_nm_ufo_attack_start = utility::getstruct( "struct_nm_ufo_attack_start", "targetname" );
    s_ufo_spawn_exit = utility::getstruct( "s_ufo_spawn_exit", "targetname" );
    var_e52843286f269826 = utility::getstructarray( "struct_nm_ufo_attack_pos", "targetname" );
    s_ufo_spawn_low = utility::getstruct( "s_ufo_spawn_low", "targetname" );
    m_oscar_ufo moveto( s_ufo_spawn_low.origin, 0.5 );
    m_oscar_ufo waittill( #"movedone" );
    playfxontag( level._effect[ "laser_spawn_vfx" ], level.var_e9826a04dfff266a, "tag_origin" );
    playfxontag( level._effect[ "spawn_smoke" ], level.var_e9826a04dfff266a, "tag_origin" );
    m_oscar_ufo thread boss_missile_attack();
    level utility::flag_wait( "flag_oscar_boss_done" );
    stopfxontag( level._effect[ "laser_spawn_vfx" ], level.var_e9826a04dfff266a, "tag_origin" );
    stopfxontag( level._effect[ "spawn_smoke" ], level.var_e9826a04dfff266a, "tag_origin" );
    s_ufo_spawn_exit = utility::getstruct( "s_ufo_spawn_exit", "targetname" );
    m_oscar_ufo moveto( s_ufo_spawn_exit.origin, 1 );
    m_oscar_ufo waittill( #"movedone" );
    m_oscar_ufo stopsounds();
    m_oscar_ufo delete();
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0xb2ef4fa6, Offset: 0x2d65
// Size: 0x442
function oscar_fight()
{
    m_oscar_ufo = getent( "m_oscar_ufo", "targetname" );
    struct_nm_oscar_beam_vfx = utility::getstruct( "struct_nm_oscar_beam_vfx", "targetname" );
    level.var_e9826a04dfff266a = utility::function_1808878d1c511ce8( struct_nm_oscar_beam_vfx.origin, struct_nm_oscar_beam_vfx.angles );
    level.var_e9826a04dfff266a linkto( m_oscar_ufo );
    struct_nm_ufo_rocket_pods = utility::getstructarray( "struct_nm_ufo_rocket_pods", "targetname" );
    level.var_945112bc416d81df = [];
    
    foreach ( rocket_pod in struct_nm_ufo_rocket_pods )
    {
        var_3ce452c1f4db236a = utility::function_1808878d1c511ce8( rocket_pod.origin, rocket_pod.angles );
        var_3ce452c1f4db236a linkto( m_oscar_ufo );
        level.var_945112bc416d81df[ level.var_945112bc416d81df.size ] = var_3ce452c1f4db236a;
    }
    
    m_oscar_ufo thread function_685ff04ddf67bd8f();
    level utility::flag_wait( "flag_oscar_spawn_start" );
    var_ad30c944bbd232d7 = 1.5;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
    struct = utility::getstruct( "struct_nm_oscar_spawn", "targetname" );
    var_50f07c225d6f9cfc = utility::function_1808878d1c511ce8( struct.origin, struct.angles );
    level.var_3f03988b3b665431 = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_galileo_hvt_ob_nm", struct.origin, struct.angles, "team_two_hundred" );
    level.var_3f03988b3b665431.ignoreall = 1;
    level.var_3f03988b3b665431.ignoreme = 1;
    level.var_3f03988b3b665431 setcandamage( 0 );
    level.var_3f03988b3b665431 linkto( var_50f07c225d6f9cfc );
    s_spawn_end_pos = utility::getstruct( "s_ufo_spawn_beam", "targetname" );
    n_speed = 1.2;
    var_50f07c225d6f9cfc moveto( s_spawn_end_pos.origin, n_speed );
    var_50f07c225d6f9cfc waittill( #"movedone" );
    level.var_3f03988b3b665431 unlink();
    var_50f07c225d6f9cfc delete();
    level.var_3f03988b3b665431 enabletraversals( 0 );
    level.var_3f03988b3b665431.ignoreall = 0;
    level.var_3f03988b3b665431.ignoreme = 0;
    level.var_3f03988b3b665431 setcandamage( 1 );
    level.nm_activity_instance.var_9be376218db54aba = "sat_ob_objectivemarker_nm_big_boss";
    level.nm_activity_instance thread ob_nm_mode::miniboss_objective( level.var_3f03988b3b665431 );
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_boss_start", "nm_miniboss_start" );
    ob_story_mission_utils::objective_text_show( %"hash_21b2b11c009d4587" );
    ob_story_mission_utils::objective_timer_update( 360 );
    level thread ob_nm_mode::wave_fail_timer( 360 );
    level.enemy_count_array = [ 6, 12, 18, 24 ];
    level.cadence_override = 1.5;
    level.var_3f03988b3b665431 set_oscar_health( 0.4 );
    level.var_3f03988b3b665431 thread ob_nm_mode::setup_boss_healthbar( level.var_3f03988b3b665431.health, level.var_3f03988b3b665431.maxhealth, "ob_boss_nm_oscar" );
    level utility::flag_set( "flag_oscar_spawn_done" );
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    thread function_f5237780dd76c517();
    level.var_3f03988b3b665431 waittill( #"death" );
    function_a25acb62ddab20e2( "nm_minion_zombie", 0 );
    level utility::flag_set( "oscar_phase_02" );
    level utility::flag_set( "flag_oscar_boss_done" );
    level notify( #"hash_aefc5c470125baf8" );
    wait 3;
    ob_nm_mode::end_of_round_fanfare( "nm_overlord_boss_dead", "nm_miniboss_defeated" );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0xd8eb9c2a, Offset: 0x31af
// Size: 0x55
function function_685ff04ddf67bd8f()
{
    s_ufo_spawn_low = utility::getstruct( "s_ufo_spawn_low", "targetname" );
    self moveto( s_ufo_spawn_low.origin, 1 );
    self waittill( #"movedone" );
    thread function_eea0ce21e1489174();
    wait 2;
    level utility::flag_set( "flag_oscar_spawn_start" );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0xdc3da9d3, Offset: 0x320c
// Size: 0x81
function boss_missile_attack()
{
    level.var_3f03988b3b665431 endon( #"death" );
    
    while ( true )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( isalive( level.players[ i ] ) && !active_camo_is_active( level.players[ i ] ) )
            {
                function_fd9564152eca84c1( level.players[ i ] );
            }
        }
        
        wait 3;
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 2
// Checksum 0x6f4b84e9, Offset: 0x3295
// Size: 0x9c
function function_fd9564152eca84c1( player, var_bbf0fa162edd3ce6 = 4 )
{
    self endon( #"death" );
    
    for ( i = 0; i < var_bbf0fa162edd3ce6 ; i++ )
    {
        start = level.var_e9826a04dfff266a.origin + ( 0, 600, 0 );
        end = self.origin;
        childthread individual_missile( start, end, player );
        wait randomfloatrange( 0.5, 0.75 );
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 3
// Checksum 0x997de0d, Offset: 0x3339
// Size: 0x99
function individual_missile( start, end, player )
{
    if ( isalive( player ) && !active_camo_is_active( player ) )
    {
        missile = magicbullet( "sat_la_ztron_fireball_virgo_nm", start, end, level.var_3f03988b3b665431 );
        missile endon( #"death" );
        wait randomfloatrange( 0.5, 0.75 );
        
        if ( isalive( player ) && !active_camo_is_active( player ) )
        {
            missile missile_settargetpos( player.origin );
        }
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0xba96831c, Offset: 0x33da
// Size: 0x24, Type: bool
function active_camo_is_active( player )
{
    return player supers_mp::getcurrentsuperref() == "super_active_camo" && supers_mp::issuperinuse();
}

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0x78c7fe03, Offset: 0x3407
// Size: 0x51
function set_oscar_health( scalar )
{
    if ( isdefined( self ) )
    {
        minibosshealth = self.health;
        new_health = minibosshealth * level.players.size * scalar;
        new_health = int( new_health );
        mp_agent::set_agent_health( new_health );
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 3
// Checksum 0xec61a058, Offset: 0x3460
// Size: 0x1c8
function function_282e7e6d7e2ae3fa( start_struct, var_66ac51655007d64f, exit_struct )
{
    self endon( #"hash_8ca490ff1d96b5c8" );
    function_b82615428ce16544( self );
    self show();
    
    if ( !isdefined( self.var_740415965a2eb2ba ) )
    {
        self.var_740415965a2eb2ba = utility::function_1808878d1c511ce8( self.origin, self.angles );
        self.var_740415965a2eb2ba linkto( self );
    }
    
    if ( isdefined( self.var_3cc0f79e91e77927 ) )
    {
        snd::stop( self.var_3cc0f79e91e77927, 0.1 );
        self.var_3cc0f79e91e77927 = undefined;
    }
    
    self.var_3cc0f79e91e77927 = snd::play( "evt_nm_ufo_lp", level.var_e9826a04dfff266a );
    s_ufo_spawn_in = utility::getstruct( "s_ufo_spawn_in", "targetname" );
    self moveto( s_ufo_spawn_in.origin, 2 );
    self waittill( #"movedone" );
    level utility::flag_clear( "ufo_laser_stop" );
    wait 0.5;
    ob_nm_mode::nightmare_splash( "nm_incoming_strike" );
    thread function_5b1064885ad02abf();
    waitframe();
    self notify( #"hash_33ebfc75fad65141" );
    wait 3;
    thread ufo_patrol( var_66ac51655007d64f, exit_struct );
    level waittill( #"hash_7e2f8063fb81122d" );
    s_ufo_spawn_exit = utility::getstruct( "s_ufo_spawn_exit", "targetname" );
    self moveto( s_ufo_spawn_exit.origin, 1 );
    self waittill( #"movedone" );
    function_c2345841dbc9163b( self );
    
    if ( isdefined( self.var_3cc0f79e91e77927 ) )
    {
        snd::stop( self.var_3cc0f79e91e77927, 0.15 );
        self.var_3cc0f79e91e77927 = undefined;
    }
    
    self stopsounds();
    self hide();
}

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0x967a1896, Offset: 0x3630
// Size: 0xee
function function_28ed0fcd4ac3e40e( ufo )
{
    if ( !isdefined( ufo ) )
    {
        return;
    }
    
    ufo notify( #"hash_d5084aed53ce0a20" );
    function_b82615428ce16544( ufo );
    snd::play( "evt_nm_ufo_blue_beam_start", level.var_e9826a04dfff266a );
    blue_beam_start = level.var_e9826a04dfff266a.origin;
    blue_beam_end = physicstrace( blue_beam_start, blue_beam_start + ( 0, 0, -2500 ) );
    var_45ee8847de0206c3 = blue_beam_end + ( 0, 0, 24 );
    ufo.var_ba0da72cc20e3f75 = utility::function_1808878d1c511ce8( var_45ee8847de0206c3 );
    snd::play( "evt_nm_ufo_blue_beam_start", ufo.var_ba0da72cc20e3f75 );
    ufo.var_264b310903334b7f = snd::play( "evt_nm_ufo_blue_beam_lp", ufo.var_ba0da72cc20e3f75 );
    ufo thread function_d3fdf93bcd31a8d7();
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x705aa148, Offset: 0x3726
// Size: 0x9f
function function_d3fdf93bcd31a8d7()
{
    self endon( #"hash_6e277aa456708b79" );
    self endon( #"hash_d5084aed53ce0a20" );
    self endon( #"hash_8ca490ff1d96b5c8" );
    
    while ( isdefined( self.var_ba0da72cc20e3f75 ) )
    {
        blue_beam_start = level.var_e9826a04dfff266a.origin;
        blue_beam_end = physicstrace( blue_beam_start, blue_beam_start + ( 0, 0, -2500 ) );
        self.var_ba0da72cc20e3f75.origin = blue_beam_end + ( 0, 0, 24 );
        wait 0.05;
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0x5b5a165a, Offset: 0x37cd
// Size: 0x37
function function_38782fc92ff4ef16( ufo )
{
    playfxontag( level._effect[ "generator_beam" ], level.var_e9826a04dfff266a, "tag_origin" );
    function_28ed0fcd4ac3e40e( ufo );
}

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0x491c394f, Offset: 0x380c
// Size: 0x8c
function function_b82615428ce16544( ufo )
{
    if ( !isdefined( ufo ) )
    {
        return;
    }
    
    ufo notify( #"hash_6e277aa456708b79" );
    
    if ( isdefined( ufo.var_264b310903334b7f ) )
    {
        snd::stop( ufo.var_264b310903334b7f, 0.1 );
        ufo.var_264b310903334b7f = undefined;
    }
    
    if ( isdefined( ufo.var_ba0da72cc20e3f75 ) )
    {
        ufo.var_ba0da72cc20e3f75 stopsounds();
        ufo.var_ba0da72cc20e3f75 delete();
        ufo.var_ba0da72cc20e3f75 = undefined;
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0x2ed08456, Offset: 0x38a0
// Size: 0x37
function function_f75032908020663e( ufo )
{
    stopfxontag( level._effect[ "generator_beam" ], level.var_e9826a04dfff266a, "tag_origin" );
    function_b82615428ce16544( ufo );
}

// Namespace namespace_f6592da7cc080d6f
// Params 2
// Checksum 0xfaabae8f, Offset: 0x38df
// Size: 0x14a
function ufo_patrol( var_66ac51655007d64f, exit_struct )
{
    self endon( #"hash_8ca490ff1d96b5c8" );
    n_visited = 0;
    n_max_visits = 8;
    n_last_index = -1;
    n_min_distance = 500;
    
    while ( n_visited < n_max_visits )
    {
        n_new_index = -1;
        var_5a59e4113644766b = 0;
        
        while ( var_5a59e4113644766b < 20 )
        {
            candidate = randomint( var_66ac51655007d64f.size );
            
            if ( candidate == n_last_index )
            {
                var_5a59e4113644766b++;
                continue;
            }
            
            dist = distance( self.origin, var_66ac51655007d64f[ candidate ].origin );
            
            if ( dist < n_min_distance )
            {
                var_5a59e4113644766b++;
                continue;
            }
            
            n_new_index = candidate;
            break;
        }
        
        if ( n_new_index == -1 )
        {
            n_new_index = randomint( var_66ac51655007d64f.size );
        }
        
        n_last_index = n_new_index;
        var_5990ce3727e634d1 = var_66ac51655007d64f[ n_new_index ];
        self moveto( var_5990ce3727e634d1.origin, 0.75 );
        self waittill( #"movedone" );
        self notify( #"hash_33ebfc75fad65141" );
        wait 3;
        n_visited++;
    }
    
    level utility::flag_set( "ufo_laser_stop" );
    level notify( #"hash_7e2f8063fb81122d" );
}

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0x17648659, Offset: 0x3a31
// Size: 0x114
function function_c2345841dbc9163b( ufo )
{
    if ( !isdefined( ufo ) )
    {
        return;
    }
    
    if ( isdefined( ufo.var_203f30309ea7bd4e ) )
    {
        snd::stop( ufo.var_203f30309ea7bd4e, 0.1 );
        ufo.var_203f30309ea7bd4e = undefined;
    }
    
    if ( isdefined( ufo.var_aaeae32366513bb3 ) )
    {
        snd::stop( ufo.var_aaeae32366513bb3, 0.1 );
        ufo.var_aaeae32366513bb3 = undefined;
    }
    
    if ( isdefined( ufo.var_73d6352faeb5830e ) )
    {
        ufo.var_73d6352faeb5830e stopsounds();
        ufo.var_73d6352faeb5830e delete();
        ufo.var_73d6352faeb5830e = undefined;
    }
    
    if ( isdefined( ufo.var_20a878fd253749f ) )
    {
        ufo.var_20a878fd253749f stopsounds();
        ufo.var_20a878fd253749f delete();
        ufo.var_20a878fd253749f = undefined;
    }
    
    if ( isdefined( ufo.var_64ac4123362dd865 ) )
    {
        ufo.var_64ac4123362dd865 delete();
        ufo.var_64ac4123362dd865 = undefined;
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0xfe847f5f, Offset: 0x3b4d
// Size: 0x287
function function_5b1064885ad02abf()
{
    level utility::flag_set( "flag_ufo_phase_active" );
    self endon( #"hash_8ca490ff1d96b5c8" );
    function_c2345841dbc9163b( self );
    level utility::flag_clear( "ufo_laser_stop" );
    beam_start = level.var_e9826a04dfff266a.origin;
    beam_end = physicstrace( beam_start, beam_start + ( 0, 0, -1300 ) );
    var_d9a758a09e091af1 = ( beam_start[ 0 ] + ( beam_end[ 0 ] - beam_start[ 0 ] ) * 0.85, beam_start[ 1 ] + ( beam_end[ 1 ] - beam_start[ 1 ] ) * 0.85, beam_start[ 2 ] + ( beam_end[ 2 ] - beam_start[ 2 ] ) * 0.85 + 24 );
    sound_beam_end = beam_end + ( 0, 0, 24 );
    var_82f96f6f834b149d = spawn( "script_model", beam_start );
    var_42768da3e0724269 = utility::function_1808878d1c511ce8( sound_beam_end );
    var_5b140caae38fe09c = utility::function_1808878d1c511ce8( var_d9a758a09e091af1 );
    self.var_64ac4123362dd865 = var_82f96f6f834b149d;
    self.var_20a878fd253749f = var_42768da3e0724269;
    self.var_73d6352faeb5830e = var_5b140caae38fe09c;
    playfxontag( level._effect[ "laser_spawn_vfx" ], level.var_e9826a04dfff266a, "tag_origin" );
    snd::play( "evt_nm_ufo_laser_start", sound_beam_end );
    var_d72792867bb49fd4 = snd::play( "evt_nm_ufo_laser_impact_lp", var_42768da3e0724269 );
    var_2c88e81e1181a5dd = snd::play( "evt_nm_ufo_laser_path_lp", var_5b140caae38fe09c );
    self.var_203f30309ea7bd4e = var_d72792867bb49fd4;
    self.var_aaeae32366513bb3 = var_2c88e81e1181a5dd;
    thread function_c024dc1aa910f2c9();
    
    while ( !level utility::flag( "ufo_laser_stop" ) )
    {
        beam_start = level.var_e9826a04dfff266a.origin;
        beam_end = physicstrace( beam_start, beam_start + ( 0, 0, -2000 ) );
        var_d9a758a09e091af1 = ( beam_start[ 0 ] + ( beam_end[ 0 ] - beam_start[ 0 ] ) * 0.85, beam_start[ 1 ] + ( beam_end[ 1 ] - beam_start[ 1 ] ) * 0.85, beam_start[ 2 ] + ( beam_end[ 2 ] - beam_start[ 2 ] ) * 0.85 + 24 );
        sound_beam_end = beam_end + ( 0, 0, 24 );
        var_82f96f6f834b149d.origin = beam_start;
        var_42768da3e0724269.origin = sound_beam_end;
        var_5b140caae38fe09c.origin = var_d9a758a09e091af1;
        wait 0.05;
    }
    
    self notify( #"hash_828471d2bca1dd71" );
    function_c2345841dbc9163b( self );
    level utility::flag_clear( "flag_ufo_phase_active" );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x6c3e4b41, Offset: 0x3ddc
// Size: 0x187
function function_c024dc1aa910f2c9()
{
    self endon( #"hash_828471d2bca1dd71" );
    self endon( #"hash_8ca490ff1d96b5c8" );
    
    while ( !level utility::flag( "ufo_laser_stop" ) )
    {
        self waittill( #"hash_33ebfc75fad65141" );
        
        if ( !isdefined( level.var_945112bc416d81df ) )
        {
            continue;
        }
        
        var_4db4e7ff27839e54 = level.var_e9826a04dfff266a.origin;
        
        if ( level.var_945112bc416d81df.size > 0 )
        {
            var_4db4e7ff27839e54 = level.var_945112bc416d81df[ 0 ].origin;
        }
        
        snd::play( "evt_ufo_rocket_launch", var_4db4e7ff27839e54 );
        
        foreach ( rocket_pod in level.var_945112bc416d81df )
        {
            v_start = rocket_pod.origin;
            v_end = physicstrace( v_start, v_start + ( 0, 0, -2500 ) );
            missile = magicbullet( "sat_la_ztron_fireball_virgo_nm", v_start, v_end );
            
            if ( isdefined( missile ) )
            {
                missile thread function_ae2ca362cc90dad6();
                continue;
            }
            
            snd::play( "evt_ufo_rocket_explode", v_end );
        }
        
        wait 3;
    }
    
    level utility::flag_clear( "flag_ufo_phase_active" );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x57a7bbfc, Offset: 0x3f6b
// Size: 0x53
function function_ae2ca362cc90dad6()
{
    self waittill( #"death", attacker, cause, objweapon, meansofdeath );
    
    if ( isdefined( self ) )
    {
        snd::play( "evt_ufo_rocket_explode", self.origin );
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x7be9019, Offset: 0x3fc6
// Size: 0xe6
function function_b022c3951ac239b1()
{
    self endon( #"delete" );
    
    while ( self.var_a54b77f7c1adbf3e )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            
            if ( !isplayer( player ) || !isalive( player ) )
            {
                continue;
            }
            
            if ( player istouching( self ) )
            {
                player dodamage( 50, player.origin, player, undefined, "MOD_FIRE" );
                player playrumbleonentity( "damage_heavy" );
                
                if ( !player utility::ent_flag( "nm_ufo_laser_damage_sfx_cd" ) )
                {
                    player playsoundtoplayer( "evt_nm_ufo_laser_damage", player );
                    player utility::ent_flag_set( "nm_ufo_laser_damage_sfx_cd" );
                    player thread utility::ent_flag_clear_delayed( "nm_ufo_laser_damage_sfx_cd", 0.5 );
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0xc8d6a26d, Offset: 0x40b4
// Size: 0x15c
function priya_fight()
{
    level.var_d6597fe0dae6ab36 = utility::getstructarray( "surface_nm_sniper_perch", "targetname" );
    level.var_57bb3cd853745536 = utility::getstructarray( "struct_gemini_nm_surface_boss", "targetname" );
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_boss_start", "nm_miniboss_start" );
    ob_story_mission_utils::objective_text_show( %"hash_21b2b11c009d4587" );
    time_modifier = ob_nm_mode::function_3fc7f1f10018b737( 240 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    level.enemy_count_array = [ 6, 12, 18, 24 ];
    level.cadence_override = 1.5;
    boss = mp_agent::spawnnewagentaitype( "sat_sag_boss_sniper_nm", level.var_57bb3cd853745536[ 0 ].origin, level.var_57bb3cd853745536[ 0 ].angles, "team_two_hundred" );
    boss thread priya_setup();
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_surface_boss", "flag_sniper_boss_done" );
    boss waittill( #"death" );
    level utility::flag_set( "flag_sniper_boss_done" );
    level notify( #"hash_aefc5c470125baf8" );
    wait 3;
    ob_nm_mode::end_of_round_fanfare( "nm_overlord_boss_dead", "nm_miniboss_defeated" );
    function_a25acb62ddab20e2( "nm_minion_zombie", 0 );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x285468c1, Offset: 0x4218
// Size: 0xf7
function priya_setup()
{
    boss = self;
    health = 1 + level.players.size * 0.25;
    boss ob_nm_mode::set_boss_health( health );
    boss.anchor = spawn( "script_model", boss.origin );
    boss.anchor setmodel( "tag_origin" );
    boss thread utility::delete_on_death( boss.anchor );
    boss.fake_laser = spawn( "script_model", boss getmuzzlepos() );
    boss.fake_laser setmodel( "tag_laser" );
    boss.fake_laser setmoverlaserweapon( boss.weapon );
    boss.fake_laser setotherent( boss );
    boss thread function_7fea582263ba4d3e();
    level.nm_activity_instance thread ob_nm_mode::miniboss_objective( boss );
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0xb32347ac, Offset: 0x4317
// Size: 0x8a
function function_7fea582263ba4d3e()
{
    self endon( #"death" );
    var_7309620d495b6017 = self.maxhealth;
    thread snipe_combat();
    
    while ( self.health > var_7309620d495b6017 * 0.75 )
    {
        waitframe();
    }
    
    thread snipe_combat();
    
    while ( self.health > var_7309620d495b6017 * 0.5 )
    {
        waitframe();
    }
    
    thread snipe_combat();
    
    while ( self.health > var_7309620d495b6017 * 0.25 )
    {
        waitframe();
    }
    
    thread snipe_combat();
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x6565f05c, Offset: 0x43a9
// Size: 0x1aa
function ground_combat()
{
    boss = self;
    weapon = weapon::buildweapon( "sat_pi_timir_mp" );
    boss.weapon = weapon;
    boss giveweapon( weapon );
    boss setspawnweapon( weapon );
    boss.primaryweapon = weapon;
    boss.cannotmelee = 0;
    boss.disablebulletwhizbyreaction = 1;
    boss.runngunenabled = 1;
    boss.disabledodge = 0;
    boss.aggressivemode = 1;
    boss.var_63f1ffef1eafa4e4 = 0;
    boss.allowlongdeath = 0;
    boss.agentdamagefeedback = 1;
    boss.var_85723cc4de5b8147 = int( 4000 );
    boss.paincooldown = int( 5000 );
    boss.allowpain = 0;
    boss.var_a3c852607ea89f1c = 1;
    boss.maxsightdistsqrd = squared( 512 );
    boss setsightconfigtemplateoverride( "default_extremerange" );
    boss.dontevershoot = 1;
    boss.meleechargedist = 1024;
    boss.meleetryhard = 1;
    level.var_57bb3cd853745536 = arrayrandomize( level.var_57bb3cd853745536 );
    spot = level.var_57bb3cd853745536[ 0 ];
    thread teleportboss( self, spot.origin, spot.angles );
    wait 0.1;
    boss notify( #"hash_8badeffa9766b47d" );
    boss unlink();
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x406cc662, Offset: 0x455b
// Size: 0x22d
function snipe_combat()
{
    boss = self;
    weapon = weapon::buildweapon( "sat_sn_caspian_blank_ob_boss_mp" );
    boss.weapon = weapon;
    boss giveweapon( weapon );
    boss setspawnweapon( weapon );
    boss.primaryweapon = weapon;
    boss.cannotmelee = 1;
    boss.disablebulletwhizbyreaction = 1;
    boss.runngunenabled = 0;
    boss.disabledodge = 1;
    boss.aggressivemode = 0;
    boss.var_63f1ffef1eafa4e4 = 1;
    boss.allowlongdeath = 0;
    boss.agentdamagefeedback = 1;
    boss.var_85723cc4de5b8147 = int( 4000 );
    boss.paincooldown = int( 5000 );
    boss.meleechargedist = 16;
    boss.meleetryhard = 0;
    boss.dontevershoot = 0;
    boss.allowpain = 0;
    boss.var_a3c852607ea89f1c = 1;
    boss.maxsightdistsqrd = squared( 8000 );
    boss setsightconfigtemplateoverride( "default_extremerange" );
    boss notify( #"hash_522352b21578fe" );
    boss thread target_player_logic();
    
    /#
        iprintln( "<dev string:x33>" );
    #/
    
    level thread smoke_players();
    level thread ob_nm_mode::function_e68ea7f6b97ccd83( boss );
    spot = utility::array_random( level.var_d6597fe0dae6ab36 );
    level thread teleportboss( boss, spot.origin, spot.angles );
    
    if ( level.players.size > 2 )
    {
        a_structs = utility::getstructarray( "struct_gemini_nm_surface_boss", "targetname" );
        struct = utility::array_random( a_structs );
        var_28395da4a12c057 = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_mangler_hvt_ob", struct.origin, struct.angles, "team_two_hundred" );
        var_28395da4a12c057 thread ob_nm_mode::individual_vanish( "flag_sniper_boss_done" );
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x42306162, Offset: 0x4790
// Size: 0xb0
function smoke_players()
{
    foreach ( player in level.players )
    {
        grenade = magicgrenademanual( "sat_smoke_grenade_ob", player.origin + ( 0, 0, 96 ), ( 0, 0, 0 ), 0.05 );
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0xf0ffea28, Offset: 0x4848
// Size: 0xde
function target_player_logic()
{
    boss_agent = self;
    boss_agent endon( #"death" );
    boss_agent endon( #"hash_1466dc16c6fac9d9" );
    boss_agent endon( #"hash_522352b21578fe" );
    boss_agent function_2ef9eb3349906d00( 15000 );
    var_64bb57aa2d6e8b35 = level.players;
    
    while ( true )
    {
        find_target_max_distance = 256000000;
        childthread findtarget( boss_agent, var_64bb57aa2d6e8b35, 0, -1, find_target_max_distance );
        boss_agent waittill( #"target_found", target_player, var_abbe13756ecd0b92 );
        
        if ( target_player )
        {
            var_a84bf2f015aa45b6 = chargeshot( boss_agent, target_player, var_64bb57aa2d6e8b35, 0 );
            
            if ( var_a84bf2f015aa45b6 == 0 )
            {
                level function_8b051bbcd7ef3883( boss_agent, target_player, var_64bb57aa2d6e8b35 );
            }
            
            if ( target_player )
            {
                target_player notify( #"hash_8a9e4270792352a8" );
            }
            
            wait 2;
        }
        
        waitframe();
    }
}

// Namespace namespace_f6592da7cc080d6f
// Params 5
// Checksum 0x8720f7d5, Offset: 0x492e
// Size: 0x1ed
function findtarget( boss_agent, var_64bb57aa2d6e8b35, var_426e58ed5fef146f, max_time, var_75954ceb198e0261 )
{
    target_player = undefined;
    timeout_timer = max_time;
    use_timeout = timeout_timer != -1;
    
    while ( !target_player )
    {
        waitframe();
        potentialtargets = [];
        prioritytargets = [];
        var_abbe13756ecd0b92 = 1;
        
        foreach ( player in level.players )
        {
            if ( player::isreallyalive( player ) && !player::isinlaststand( player ) )
            {
                var_abbe13756ecd0b92 = 0;
                cantrace = trace::ray_trace_passed( boss_agent geteye(), player geteye(), [ boss_agent, player ] );
                distance_to_player = distance2dsquared( player.origin, boss_agent.origin );
                
                if ( ( boss_agent cansee( player ) || cantrace ) && distance_to_player <= var_75954ceb198e0261 )
                {
                    potentialtargets[ potentialtargets.size ] = player;
                }
            }
        }
        
        if ( use_timeout )
        {
            timeout_timer -= level.framedurationseconds;
            
            /#
                iprintln( "<dev string:x45>" + timeout_timer );
            #/
        }
        
        if ( prioritytargets.size )
        {
            target_player = utility::array_random( prioritytargets );
        }
        else if ( potentialtargets.size )
        {
            target_player = utility::array_random( potentialtargets );
        }
        
        if ( use_timeout && timeout_timer <= 0 )
        {
            break;
        }
        
        if ( target_player || var_abbe13756ecd0b92 )
        {
            break;
        }
    }
    
    boss_agent notify( #"target_found", target_player, var_abbe13756ecd0b92 );
}

// Namespace namespace_f6592da7cc080d6f
// Params 4
// Checksum 0x7dca0d7b, Offset: 0x4b23
// Size: 0x286
function chargeshot( boss_agent, target_player, var_64bb57aa2d6e8b35, var_426e58ed5fef146f )
{
    boss_agent endon( #"death" );
    var_a84bf2f015aa45b6 = 0;
    boss_agent.favoriteenemy = target_player;
    boss_agent.shootpos = target_player geteye();
    var_1bff30f286863bc8 = 1.5 + 1.5 * boss_agent.health / boss_agent.maxhealth;
    
    if ( boss_agent.var_61448bc4bce6b00e )
    {
        while ( boss_agent.var_61448bc4bce6b00e )
        {
            waitframe();
        }
        
        wait 0.1;
    }
    
    if ( !target_player || !target_player isconnected() )
    {
        var_a84bf2f015aa45b6 = 4;
    }
    else
    {
        boss_agent function_9a0c3e295b99df0b( 1 );
        
        while ( true )
        {
            var_1bff30f286863bc8 -= level.framedurationseconds;
            boss_agent setaimangles( vectortoangles( boss_agent getmuzzlepos() - target_player geteye() ) );
            
            if ( var_1bff30f286863bc8 <= 0 )
            {
                break;
            }
            
            foreach ( player in level.players )
            {
                var_c3722bfbc8e96eec = 422500;
                
                if ( player.vehicle && distancesquared( player.vehicle.origin, boss_agent.origin ) <= var_c3722bfbc8e96eec )
                {
                    var_a84bf2f015aa45b6 = 2;
                    break;
                }
                
                if ( distancesquared( player.origin, boss_agent.origin ) <= var_c3722bfbc8e96eec )
                {
                    var_a84bf2f015aa45b6 = 2;
                    break;
                }
            }
            
            if ( boss_agent.pain_taken )
            {
                var_a84bf2f015aa45b6 = 1;
                boss_agent.pain_taken = 0;
            }
            
            if ( var_a84bf2f015aa45b6 != 0 )
            {
                break;
            }
            
            /#
                iprintln( "<dev string:x63>" + var_1bff30f286863bc8 );
            #/
            
            waitframe();
            
            if ( !target_player || !target_player isconnected() || !player::isreallyalive( target_player ) || player::isinlaststand( target_player ) )
            {
                var_a84bf2f015aa45b6 = 4;
                break;
            }
        }
        
        if ( target_player && target_player isconnected() )
        {
            target_player notify( #"hash_8a9e4270792352a8" );
        }
        
        boss_agent function_9a0c3e295b99df0b( 0 );
    }
    
    return var_a84bf2f015aa45b6;
}

// Namespace namespace_f6592da7cc080d6f
// Params 3
// Checksum 0xd74e9cdc, Offset: 0x4db2
// Size: 0x134
function function_8b051bbcd7ef3883( boss_agent, target_player, var_64bb57aa2d6e8b35 )
{
    boss_agent.accuracy = 1;
    boss_agent setaimangles( vectortoangles( boss_agent geteye() - target_player geteye() ) );
    cantrace = trace::ray_trace_passed( boss_agent geteye(), target_player geteye(), [ boss_agent, target_player ] );
    
    if ( boss_agent cansee( target_player ) && cantrace )
    {
        boss_agent shoot( 1, target_player );
        boss_agent notify( #"boss_shooting" );
        
        /#
            iprintlnbold( "<dev string:x7f>" );
        #/
        
        boss_agent.accuracy = 1;
        var_f093a4b11d98e45a = 0.75;
        var_6972fe32e211091f = 1;
        damage = target_player.armorhealth * var_6972fe32e211091f + target_player.maxhealth * var_f093a4b11d98e45a;
        
        if ( !target_player dodamage( damage, boss_agent.origin, boss_agent, undefined, "MOD_RIFLE_BULLET", boss_agent.weapon, undefined, undefined, 65536 ) )
        {
            /#
                iprintlnbold( "<dev string:x8f>" );
            #/
        }
    }
    
    wait 1;
}

// Namespace namespace_f6592da7cc080d6f
// Params 1
// Checksum 0xb1ece651, Offset: 0x4eee
// Size: 0xc8
function function_9a0c3e295b99df0b( state )
{
    if ( state )
    {
        if ( self.sniper_fx_on )
        {
            return;
        }
        
        if ( self.fake_laser )
        {
            self.fake_laser laseron();
            self.fake_laser laserforceon();
        }
        
        playfxontag( level._effect[ "sag_boss_sniper_glint" ], self, "tag_eye" );
        self.sniper_fx_on = 1;
        return;
    }
    
    if ( !self.sniper_fx_on )
    {
        return;
    }
    
    if ( self.fake_laser )
    {
        self.fake_laser laseroff();
        self.fake_laser laserforceoff();
    }
    
    stopfxontag( level._effect[ "sag_boss_sniper_glint" ], self, "tag_eye" );
    self.sniper_fx_on = 0;
}

// Namespace namespace_f6592da7cc080d6f
// Params 3
// Checksum 0xb57b9b7d, Offset: 0x4fbe
// Size: 0x134
function teleportboss( boss_agent, origin, angles )
{
    boss_agent.var_f3055f8314397ec0 = undefined;
    magicgrenademanual( "sat_smoke_grenade_ob", boss_agent.origin + ( 0, 0, 96 ), ( 0, 0, 0 ), 0.05 );
    magicgrenademanual( "sat_smoke_grenade_ob", origin + ( 0, 0, 96 ), ( 0, 0, 0 ), 0.05 );
    boss_agent notify( #"hash_8badeffa9766b47d" );
    boss_agent motionwarpcancel();
    boss_agent unlink();
    boss_agent.anchor.angles = ( 0, 0, 0 );
    boss_agent.anchor.origin = origin;
    boss_agent forceteleport( origin, ( 0, 0, 0 ), 100000 );
    boss_agent linkto( boss_agent.anchor, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    boss_agent thread function_fa91de401dfce56c();
}

// Namespace namespace_f6592da7cc080d6f
// Params 0
// Checksum 0x3e957aa6, Offset: 0x50fa
// Size: 0xb5
function function_fa91de401dfce56c()
{
    self endon( #"death" );
    self endon( #"hash_8badeffa9766b47d" );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"sag_boss_show", 0 ) > 0 )
            {
                self.anchor utility::draw_ent_axis();
            }
        #/
        
        if ( !isdefined( self.favoriteenemy ) )
        {
            waitframe();
            continue;
        }
        
        desireddir = vectortoangles( self.favoriteenemy geteye() - self getmuzzlepos() );
        additionalangles = getdvarint( @"hash_f4e89618a6e34e44", 10 );
        self.anchor.angles = ( 0, desireddir[ 1 ] + additionalangles, 0 );
        waitframe();
    }
}

