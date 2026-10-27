// script_23025963c20625a5  (hash_23025963c20625a5.gscc) (size: 18971 Bytes / 0x4a1b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xffa4c748 (4288989000)
// size ...... 18971 (0x4a1b)
// includes .. 19  (offset: 0x437f)
// strings ... 98  (offset: 0x4417)
// dev strs .. 3   (offset: 0x49f7)
// exports ... 44  (offset: 0x2ab3)
// cseg ...... 0x9db + 0x20d8 (0x2ab3)
// imports ... 146 (offset: 0x3193)
// animtree1 . 0   (offset: 0x4a1b)
// animtree2 . 0   (offset: 0x4a1b)
#using script_2399696a9d953451;
#using script_34b50456e3922412;
#using script_50ee493a72a5e95b;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\snd\snd;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_f6592ca7cc080b3c;

/#

    // Namespace namespace_f6592ca7cc080b3c
    // Params 0
    // Checksum 0x8310462, Offset: 0x9f9
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_f6592ca7cc080b3c
// Params 0, eflags: 0x5
// Checksum 0xee547062, Offset: 0xa06
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d65c6d5a18adf603", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0, eflags: 0x4
// Checksum 0xdb651370, Offset: 0xa2f
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_NM_3";
    activity_common::registeractivitytype( "OB_GEMINI_NM_3", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_3", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_3", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_3", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_NM_3" );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x171a59a0, Offset: 0xaa6
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

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x65512195, Offset: 0xb0b
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

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x95069f9d, Offset: 0xb72
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0x375b0ec7, Offset: 0xb96
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

    // Namespace namespace_f6592ca7cc080b3c
    // Params 0
    // Checksum 0x4f8ba072, Offset: 0xc3d
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0xe15a0bee, Offset: 0xc4a
// Size: 0x30
function player_setup( player )
{
    if ( isdefined( level.callisto ) )
    {
        player thread ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_nm_callisto", level.callisto );
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x7941359d, Offset: 0xc82
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0xeb83432, Offset: 0xc8c
// Size: 0x54a
function nightmare_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_GEMINI_NM_3";
    level.var_6ac65a56e9e60396 = "OB_GEMINI_NM_REWARD";
    level thread ob_story_mission_utils::function_b0bc4cf3be6ad752( "OutOfBounds" );
    utility::exploder( "vfx_cabin_chimney_fire" );
    table = getent( "cabin_medical_table", "targetname" );
    
    if ( isdefined( table ) )
    {
        table delete();
    }
    
    scriptables = getentitylessscriptablearray( "gemini_jailbreak", "script_noteworthy" );
    
    foreach ( thing in scriptables )
    {
        thing setscriptablepartstate( "body", "invisible" );
    }
    
    jailbreak_clip = getent( "cabin_jailbreak_clip", "targetname" );
    
    if ( isdefined( jailbreak_clip ) )
    {
        jailbreak_clip delete();
    }
    
    var_2a345ab3ef50328c = getentarray( "nm_fun", "targetname" );
    
    foreach ( piece in var_2a345ab3ef50328c )
    {
        piece.origin += ( 0, 0, 512 );
    }
    
    level._effect[ "beehive_vfx" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_callisto_projectile" );
    level._effect[ "laser_spawn_vfx" ] = loadfxasset( "vfx_sat_levels_wc_cradle_site_laser" );
    level._effect[ "spawn_smoke" ] = loadfxasset( "vfx_sat_mp_ob_gem_cradle_tornado_rot_1" );
    level._effect[ "healing_wave" ] = loadfxasset( "vfx_sat_zm_ui_heal_aura_os_red_ztron" );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_medkit_cabin", "flag_nm_cabin_complete", 1 );
    level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    struct = utility::getstruct( "struct_gemini_nm_cabin", "targetname" );
    ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_shadow_break", "super_bubble_shield", #"default" );
    a_structs = utility::getstructarray( "struct_nm_cabin_capture_zone", "targetname" );
    
    foreach ( zone_struct in a_structs )
    {
        level thread setup_capture_button( zone_struct );
    }
    
    waitframe();
    capture_clip = getentarray( "nm_capture_clip", "targetname" );
    
    foreach ( piece in capture_clip )
    {
        piece.origin += ( 0, 0, 1024 );
    }
    
    cabin_clips = getentarray( "nm_cabin_clip", "targetname" );
    
    foreach ( clip in cabin_clips )
    {
        clip.origin += ( 0, 0, 1024 );
        clip disconnectpaths();
    }
    
    level notify( #"hash_88c2b75df7fdf1aa" );
    ob_nm_mode::function_1f2648b3b22d9816( undefined, "nm_overlord_glich_start" );
    level utility::flag_set( "flag_remove_container_circle" );
    level.enemy_count_array = [ 12, 16, 20, 24 ];
    level.cadence_override = 0.7;
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    function_9f3699075fe11785();
    function_a25acb62ddab20e2( "nm_minion_zombie", 0 );
    ob_nm_mode::nightmare_prepare();
    ob_gametype_story_mission::function_b69ee4ccc5e7a2ae( "OB_GEMINI_NM_REWARD" );
    zursa_fight( "struct_gemini_nm_cabin", "struct_gemini_nm_cabin_boss", undefined, "sat_spawner_zombie_callisto_hvt_nm" );
    level utility::flag_set( "flag_nm_cabin_complete" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x6669e220, Offset: 0x11de
// Size: 0xf7
function cabin_br_circle()
{
    struct = utility::getstruct( "struct_gemini_nm_cabin_start_br", "targetname" );
    
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    big_radius = 4096;
    radius = 500;
    var_cf306bbdec90ce = 2;
    var_17c94bd4556610bb = struct.origin;
    circle = ob_nm_mode::function_21689e5c8bddd87c( var_17c94bd4556610bb, big_radius );
    circle brcirclemoveto( var_17c94bd4556610bb[ 0 ], var_17c94bd4556610bb[ 1 ], radius, var_cf306bbdec90ce );
    level thread ob_nm_mode::update_minimap_circle( circle, var_17c94bd4556610bb, var_17c94bd4556610bb, big_radius, radius, var_cf306bbdec90ce );
    level utility::flag_wait( "flag_remove_container_circle" );
    circle brcirclemoveto( var_17c94bd4556610bb[ 0 ], var_17c94bd4556610bb[ 1 ], big_radius, var_cf306bbdec90ce );
    level thread ob_nm_mode::update_minimap_circle( circle, var_17c94bd4556610bb, var_17c94bd4556610bb, radius, big_radius, var_cf306bbdec90ce );
    wait var_cf306bbdec90ce;
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

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0xde2b410c, Offset: 0x12dd
// Size: 0x28b
function function_9f3699075fe11785()
{
    level utility::flag_set( "flag_multi_capture_event" );
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_capture_start", undefined, undefined );
    obj = %"hash_21b2b01c009d43d4";
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = ob_nm_mode::function_3fc7f1f10018b737( 360 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    waitframe();
    zones_captured = 0;
    level.capture_scalar = 30;
    ob_story_mission_utils::function_315d79883d962ba7( zones_captured, 3 );
    level.nm_activity_instance mission_ui::function_d84701041f6f95c2( 1, 0, 100 );
    level utility::flag_clear( "flag_capture_zone_event_complete" );
    level utility::flag_set( "nightmare_encouter_active" );
    a_structs = utility::getstructarray( "struct_nm_cabin_capture_zone", "targetname" );
    level notify( #"hash_8388ea7c64070130" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( i == 2 )
        {
            level utility::flag_set( "flag_enable_super_sprint" );
        }
        
        level thread ob_nm_mode::function_70467d6be224da52( "nm_overlord_capture_next" );
        level thread ob_nm_mode::nightmare_splash( "nm_capture_select" );
        level utility::flag_wait( "flag_zone_picked" );
        struct = level.var_19aecb756e2b7826;
        ob_nm_mode::nightmare_splash( "nm_capture_single" );
        capture_struct = ob_nm_mode::function_b484cb1cc50eab74( struct, "nightmare_capture_zone_" + i );
        waitframe();
        level notify( #"hash_88c2b75df7fdf1aa" );
        level thread function_24d54c0593e21c21( "struct_capture_spawn_", i );
        thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_cabin_activity_" + i, "flag_capture_complete" + i );
        level.nm_activity_instance mission_ui::function_d84701041f6f95c2( 1, 0, 100 );
        ob_nm_mode::capture_zone_segment( capture_struct, "flag_capture_complete" + i, 1, 128 );
        level.nm_activity_instance mission_ui::function_d84701041f6f95c2( 1, 100, 100 );
        zones_captured++;
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( zones_captured, 3 );
        level utility::flag_clear( "flag_zone_picked" );
        
        if ( zones_captured == 3 )
        {
            continue;
        }
        
        ob_nm_mode::nightmare_splash( "nm_capture_zone_end", "uin_sat_nightmare_capture_success" );
        wait 3.5;
        level notify( #"hash_8388ea7c64070130" );
    }
    
    wait 2;
    level utility::flag_clear( "flag_enable_super_sprint" );
    level utility::flag_clear( "flag_multi_capture_event" );
    level notify( #"hash_aefc5c470125baf8" );
    level notify( #"cleanup_minions" );
    level utility::flag_set( "flag_capture_zone_event_complete" );
    level utility::flag_clear( "nightmare_encouter_active" );
    ob_nm_mode::end_of_round_fanfare( "nm_overlord_capture_end", "nm_capture_zone_complete" );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 2
// Checksum 0x24b697b2, Offset: 0x1570
// Size: 0x1e6
function function_24d54c0593e21c21( struct_base_name, i )
{
    struct = utility::getstruct( struct_base_name + i, "targetname" );
    
    if ( isdefined( struct ) )
    {
        snd::play( "evt_rozar_spawn_beam", struct.origin + ( 0, 0, 100 ) );
    }
    
    level thread function_69fd7cd14ea350cf( struct_base_name + i, "flag_capture_complete" + i );
    level thread function_69fd7cd14ea350cf( struct_base_name + i, "flag_capture_complete" + i, "evt_gemini_spawn_beam_lp" );
    level thread ob_nm_mode::play_spawn_smoke( struct_base_name + i, "flag_capture_complete" + i );
    level thread ob_nm_mode::play_spawn_smoke( struct_base_name + i, "flag_capture_complete" + i, "laser_spawn_vfx" );
    waitframe();
    struct = utility::getstruct( struct_base_name + i + "b", "targetname" );
    
    if ( isdefined( struct ) )
    {
        snd::play( "evt_rozar_spawn_beam", struct.origin + ( 0, 0, 100 ) );
    }
    
    level thread function_69fd7cd14ea350cf( struct_base_name + i + "b", "flag_capture_complete" + i );
    level thread function_69fd7cd14ea350cf( struct_base_name + i + "b", "flag_capture_complete" + i, "evt_gemini_spawn_beam_lp" );
    level thread ob_nm_mode::play_spawn_smoke( struct_base_name + i + "b", "flag_capture_complete" + i );
    level thread ob_nm_mode::play_spawn_smoke( struct_base_name + i + "b", "flag_capture_complete" + i, "laser_spawn_vfx" );
    
    if ( i > 0 )
    {
        struct = utility::getstruct( struct_base_name + i, "targetname" );
        spawn_pos = getclosestpointonnavmesh( struct.origin + ( randomfloatrange( -128, 128 ), randomfloatrange( -128, 128 ), 0 ) );
        extra_dude = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_mangler_ob", spawn_pos, struct.angles, "team_two_hundred" );
        extra_dude thread ob_nm_mode::individual_vanish( "flag_capture_complete" + i );
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 3
// Checksum 0x9922aeca, Offset: 0x175e
// Size: 0x89
function function_69fd7cd14ea350cf( var_dc6a4b4b351da087, flag_to_end, loop_alias = "amb_cradle_tornado_rotation" )
{
    wave_smoke = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    
    if ( !isdefined( wave_smoke ) )
    {
        return;
    }
    
    loop_sound = snd::play( loop_alias, wave_smoke.origin + ( 0, 0, 100 ) );
    level utility::flag_wait( flag_to_end );
    snd::stop( loop_sound );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0xf9d69a4d, Offset: 0x17ef
// Size: 0x27
function pick_capture_zone( a_structs )
{
    level waittill( #"zone_picked", struct );
    return struct;
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0x2a0cd66a, Offset: 0x181f
// Size: 0x152
function setup_capture_button( struct )
{
    console_struct = utility::getstruct( struct.target, "targetname" );
    offset = 8 * anglestoforward( vectortoangles( struct.origin - console_struct.origin ) );
    interact = interaction::register_interact( console_struct.origin + offset + ( 0, 0, 48 ), 40, &zone_interact, &"hash_5924f7ca28f43f1b", undefined, undefined, undefined, "HINT_BUTTON" );
    interact setuseholdduration( 0 );
    interact.prop_model = spawn( "script_model", console_struct.origin );
    interact.prop_model setmodel( "t10_zm_inclinator_gate_console" );
    interact.prop_model.angles = console_struct.angles;
    interact.prop_model hudoutlineenable( "outline_nodepth_yellow" );
    interact thread toggle_states();
    interact interact_wait();
    interact makeunusable();
    interact.prop_model hudoutlinedisable();
    level.var_19aecb756e2b7826 = struct;
    level utility::flag_set( "flag_zone_picked" );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x30e3eb7f, Offset: 0x1979
// Size: 0x1b
function interact_wait()
{
    level endon( #"hash_aefc5c470125baf8" );
    self waittill( #"zone_pressed" );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0x6f0e6e2a, Offset: 0x199c
// Size: 0x2b
function zone_interact( var_9d64a5e2cee72c8f )
{
    self notify( #"zone_pressed" );
    playsoundatpos( self.origin, "evt_gem_elevator_start_buzzer" );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x43390483, Offset: 0x19cf
// Size: 0x8c
function toggle_states()
{
    level endon( #"hash_aefc5c470125baf8" );
    self endon( #"zone_pressed" );
    
    while ( true )
    {
        level waittill( #"hash_88c2b75df7fdf1aa" );
        self makeunusable();
        self.prop_model hudoutlinedisable();
        level waittill( #"hash_8388ea7c64070130" );
        waitframe();
        self makeusable();
        self setcursorhint( "HINT_BUTTON" );
        self setuserange( 40 );
        self sethintstring( &"hash_5924f7ca28f43f1b" );
        self.prop_model hudoutlineenable( "outline_nodepth_yellow" );
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 4
// Checksum 0xfcaa1036, Offset: 0x1a63
// Size: 0x319
function zursa_fight( var_fcb964ac6f23a112, var_e04c0425c57a325, radius, main_boss = "sat_spawner_zombie_mimic_ob" )
{
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_boss_start", "nm_boss_start" );
    self.var_9be376218db54aba = "sat_ob_objectivemarker_nm_big_boss";
    var_fcb964ac6f23a112 = utility::getstruct( var_fcb964ac6f23a112, "targetname" );
    var_e04c0425c57a325 = utility::getstructarray( var_e04c0425c57a325, "targetname" );
    var_e04c0425c57a325 = arrayrandomize( var_e04c0425c57a325 );
    level utility::flag_clear( "nightmare_encouter_done" );
    ob_story_mission_utils::objective_text_show( %"hash_1d6c1f3ae5d084d5" );
    level thread zursa_br_circle();
    num_bosses = 1;
    level.nm_bosses = num_bosses;
    level.var_ff552d2355510bb7 = 0;
    wait 1;
    level.zursa_total_time = 480;
    ob_story_mission_utils::objective_timer_update( level.zursa_total_time );
    level.zursa_start_time = gettime();
    level thread ob_nm_mode::wave_fail_timer( level.zursa_total_time );
    level.enemy_count_array = [ 8, 12, 16, 20 ];
    level.cadence_override = 0.5;
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    playfx( level._effect[ "enemy_vfx" ], var_e04c0425c57a325[ 0 ].origin );
    boss = mp_agent::spawnnewagentaitype( main_boss, var_e04c0425c57a325[ 0 ].origin, var_e04c0425c57a325[ 0 ].angles, "team_two_hundred" );
    level utility::flag_set( "nightmare_encouter_active" );
    level.callisto = boss;
    level.callisto.disallow_knockdown = 1;
    level.callisto.var_24954f14e27b448d = 0;
    level.callisto zombie_utils::function_dfae6a5bd222c586( &function_394894348fc20fa1 );
    health = 0.5 + level.players.size * 0.25;
    level.callisto ob_nm_mode::set_boss_health( health );
    level.callisto thread function_b3ba17bb26657bb5();
    level.callisto thread ob_nm_mode::setup_boss_healthbar( level.callisto.health, level.callisto.maxhealth, "ob_boss_nm_callisto" );
    level.zursa_obj_id = ob_story_mission_utils::function_804834359f20ef5a( level.callisto );
    function_2b8e3d3ae2a6414a( level.zursa_obj_id, 0 );
    boss waittill( #"death" );
    
    if ( isdefined( level.zursa_obj_id ) )
    {
        ob_story_mission_utils::objective_marker_clear( level.zursa_obj_id );
    }
    
    level utility::flag_set( "flag_zursa_dead" );
    level thread ob_nm_mode::function_70467d6be224da52( "nm_overlord_boss_dead" );
    level notify( #"cleanup_minions" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level notify( #"hash_aefc5c470125baf8" );
    self.var_9be376218db54aba = undefined;
    ob_nm_mode::end_of_round_fanfare( "nm_overlord_boss_dead", "nm_boss_end" );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0xa440dfc8, Offset: 0x1d84
// Size: 0x1c
function function_394894348fc20fa1( params )
{
    if ( self.boss_immune )
    {
        return 0;
    }
    
    return -1;
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x5bca39f5, Offset: 0x1da9
// Size: 0xbf
function zursa_br_circle()
{
    var_9a7b20e173174021 = 4096;
    radius = 1600;
    var_cf306bbdec90ce = 5;
    struct = utility::getstruct( "struct_gemini_nm_cabin_circle", "targetname" );
    var_17c94bd4556610bb = struct.origin;
    circle = ob_nm_mode::function_21689e5c8bddd87c( var_17c94bd4556610bb, var_9a7b20e173174021 );
    circle brcirclemoveto( var_17c94bd4556610bb[ 0 ], var_17c94bd4556610bb[ 1 ], radius, var_cf306bbdec90ce );
    level thread ob_nm_mode::update_minimap_circle( circle, var_17c94bd4556610bb, var_17c94bd4556610bb, var_9a7b20e173174021, radius, var_cf306bbdec90ce );
    level utility::flag_wait( "flag_zursa_dead" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x2364a747, Offset: 0x1e70
// Size: 0x11f
function function_b3ba17bb26657bb5()
{
    self endon( #"death" );
    max_health = self.health;
    a_structs = utility::getstructarray( "struct_nm_beehive", "targetname" );
    a_structs = arrayrandomize( a_structs );
    level.nm_activity_instance thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_cabin_boss_1", "zursa_wave_1_done" );
    
    while ( self.health > max_health * 0.66 )
    {
        waitframe();
    }
    
    level utility::flag_set( "zursa_wave_1_done" );
    beehive_objective( "struct_nm_beehive_1" );
    level notify( #"hash_7b07f949e74d7916" );
    level.nm_activity_instance thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_cabin_boss_2", "zursa_wave_2_done" );
    
    while ( self.health > max_health * 0.33 )
    {
        waitframe();
    }
    
    level utility::flag_set( "zursa_wave_2_done" );
    beehive_objective( "struct_nm_beehive_2" );
    level thread function_65164625139195b1();
    level notify( #"hash_7b07f949e74d7916" );
    level thread function_d27693573d5e0f7f();
    level.nm_activity_instance thread ob_nm_mode::minion_encounter( "encounter_gemini_nm_cabin_boss_3", "flag_zursa_dead" );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0xa82ff37, Offset: 0x1f97
// Size: 0x2ba
function beehive_objective( struct_array_name )
{
    self endon( #"death" );
    ob_nm_mode::nightmare_splash( "nm_beehives" );
    self.boss_immune = 1;
    level.nm_activity_instance ob_story_mission_utils::objective_text_show( %"hash_4cbeedecd4e6bdd0" );
    count = function_cf3f23bdc0b81c51();
    level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( 0, count );
    current_time = gettime();
    duration = abs( current_time - level.zursa_start_time );
    var_31688a0f3073df86 = int( duration / 1000 );
    time_remaining = abs( level.zursa_total_time - var_31688a0f3073df86 );
    level.nm_activity_instance ob_story_mission_utils::objective_timer_update( time_remaining );
    
    if ( isdefined( level.zursa_obj_id ) )
    {
        level.nm_activity_instance ob_story_mission_utils::objective_marker_clear( level.zursa_obj_id );
    }
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_immune();
    }
    
    a_structs = utility::getstructarray( struct_array_name, "targetname" );
    function_1a580cc14d69e5d1( a_structs );
    ob_nm_mode::nightmare_splash( "nm_beehives_end" );
    self.boss_immune = 0;
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_show();
    }
    
    level.nm_activity_instance ob_story_mission_utils::objective_text_show( %"hash_1d6c1f3ae5d084d5" );
    level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( 0, 0 );
    current_time = gettime();
    duration = abs( current_time - level.zursa_start_time );
    var_31688a0f3073df86 = int( duration / 1000 );
    time_remaining = abs( level.zursa_total_time - var_31688a0f3073df86 );
    level.nm_activity_instance ob_story_mission_utils::objective_timer_update( time_remaining );
    level.zursa_obj_id = level.nm_activity_instance ob_story_mission_utils::function_804834359f20ef5a( level.callisto );
    function_2b8e3d3ae2a6414a( level.zursa_obj_id, 0 );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x3d3e28f, Offset: 0x2259
// Size: 0x55
function function_33b2a585df9a7a09()
{
    machete_target = self;
    prop_model = spawn( "script_model", machete_target.origin );
    prop_model setmodel( "lm_offhand_wm_at_mine" );
    prop_model hudoutlineenable( "outline_nodepth_red" );
    function_aa2386338119aeea( machete_target );
    prop_model delete();
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0xd6db7ec3, Offset: 0x22b6
// Size: 0x71
function function_aa2386338119aeea( machete_target )
{
    trigger = spawn( "trigger_radius", self.origin, 0, 16, 16 );
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            /#
                iprintln( "<dev string:x24>" );
            #/
            
            break;
        }
    }
    
    ob_story_mission_machete_attack::function_bfee43bcb0dcc192( machete_target );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x946fd918, Offset: 0x232f
// Size: 0x61
function function_d27693573d5e0f7f()
{
    machete_target_scriptables = getentitylessscriptablearray( "cabin_machete_attack", #targetname );
    machete_target_scriptables = arrayrandomize( machete_target_scriptables );
    
    for ( i = 0; i < machete_target_scriptables.size ; i++ )
    {
        if ( !level utility::flag( "flag_zursa_dead" ) )
        {
            ob_story_mission_machete_attack::function_bfee43bcb0dcc192( machete_target_scriptables[ i ], 1 );
        }
        
        wait 7;
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0xc17b94e, Offset: 0x2398
// Size: 0x18
function function_3c8a17513e90ef86()
{
    level callback::add( #"player_damaged", &onplayerdamaged );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0x958c8964, Offset: 0x23b8
// Size: 0x5e
function onplayerdamaged( params )
{
    attacker = params.eattacker;
    
    if ( isdefined( attacker.model ) && issubstr( attacker.model, "machete" ) )
    {
        thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 3, undefined, self, undefined, undefined, 1 );
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x1b48ef25, Offset: 0x241e
// Size: 0x9f
function machete_attack_traps()
{
    function_3c8a17513e90ef86();
    machete_target_scriptables = getentitylessscriptablearray( "cabin_machete_attack", #targetname );
    machete_target_scriptables = arrayrandomize( machete_target_scriptables );
    
    foreach ( machete_target in machete_target_scriptables )
    {
        machete_target thread function_33b2a585df9a7a09();
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0x6b603e63, Offset: 0x24c5
// Size: 0xb3
function function_1a580cc14d69e5d1( a_structs )
{
    if ( isdefined( level.callisto ) )
    {
        function_8fa9b34b8eab6add( level.callisto );
        level.callisto thread function_da0f47d09bf1fea();
    }
    
    level.callisto thread function_e527fa962f4696f5();
    level.var_201dc34ee1e0fb1d = 0;
    a_structs = arrayrandomize( a_structs );
    count = function_cf3f23bdc0b81c51();
    
    for ( i = 0; i < count ; i++ )
    {
        a_structs[ i ] thread setup_hive();
    }
    
    while ( level.var_201dc34ee1e0fb1d < count )
    {
        waitframe();
    }
    
    function_438df5b82622ef34( level.callisto );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0x633f606b, Offset: 0x2580
// Size: 0x5b
function function_8fa9b34b8eab6add( boss )
{
    if ( !isdefined( boss ) )
    {
        return;
    }
    
    snd::play( "uin_sat_nightmare_health_regen_start", boss.origin + ( 0, 0, 80 ) );
    function_438df5b82622ef34( boss );
    boss.var_ffe8160a9d53ca8a = snd::play( "uin_sat_nightmare_health_regen_lp", boss );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0x739f06f6, Offset: 0x25e3
// Size: 0x45
function function_438df5b82622ef34( boss )
{
    if ( !isdefined( boss ) )
    {
        return;
    }
    
    if ( isdefined( boss.var_ffe8160a9d53ca8a ) )
    {
        snd::stop( boss.var_ffe8160a9d53ca8a, 0.1 );
        boss.var_ffe8160a9d53ca8a = undefined;
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x21257a84, Offset: 0x2630
// Size: 0x17
function function_da0f47d09bf1fea()
{
    self waittill( #"death" );
    function_438df5b82622ef34( self );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x16626dda, Offset: 0x264f
// Size: 0x4e
function function_cf3f23bdc0b81c51()
{
    count = 7;
    
    if ( level.players.size == 1 )
    {
        count = 2;
    }
    
    if ( level.players.size == 2 )
    {
        count = 4;
    }
    
    if ( level.players.size == 3 )
    {
        count = 6;
    }
    
    return count;
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x7fc24728, Offset: 0x26a6
// Size: 0x5c
function function_e527fa962f4696f5()
{
    boss = self;
    boss endon( #"death" );
    level endon( #"hash_7b07f949e74d7916" );
    
    while ( true )
    {
        boss ob_nm_mode::heal_boss( 0.02 );
        playfxontag( level._effect[ "healing_wave" ], boss, "tag_origin" );
        wait 2;
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x3718654c, Offset: 0x270a
// Size: 0x135
function setup_hive()
{
    var_10ceb6b70c29c3b9 = self;
    prop_model = spawn( "script_model", var_10ceb6b70c29c3b9.origin );
    prop_model setmodel( "decor_bee_hive_round_01" );
    prop_model setcandamage( 1 );
    prop_model hudoutlineenable( "outline_nodepth_red" );
    playfxontag( level._effect[ "beehive_vfx" ], prop_model, "tag_origin" );
    obj_id = level.nm_activity_instance ob_story_mission_utils::function_804834359f20ef5a( prop_model, 24 );
    prop_model thread function_12e978d9a205068a();
    prop_model beehive_damage_monitor();
    playfx( level._effect[ "enemy_vfx" ], self.origin );
    level thread spawn_parasite( self );
    stopfxontag( level._effect[ "beehive_vfx" ], prop_model, "tag_origin" );
    waitframe();
    prop_model notify( #"hash_f95ac2d606147a38" );
    prop_model delete();
    level.var_201dc34ee1e0fb1d++;
    level.nm_activity_instance ob_story_mission_utils::objective_marker_clear( obj_id );
    count = function_cf3f23bdc0b81c51();
    level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( level.var_201dc34ee1e0fb1d, count );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x3535d85c, Offset: 0x2847
// Size: 0x56
function function_f4b17c2ca35b417b()
{
    self endon( #"hash_f95ac2d606147a38" );
    self endon( #"death" );
    
    while ( true )
    {
        ob_nm_mode::function_72282522248ae734( self.origin, level.callisto.origin + ( 0, 0, 64 ) );
        wait 5;
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0xd93e83d, Offset: 0x28a5
// Size: 0x124
function beehive_damage_monitor()
{
    hive = self;
    self.health = 200;
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time );
        
        if ( isplayer( attacker ) )
        {
            attacker damagefeedback::updatedamagefeedback( "hitequip", self.health <= 0, 0, undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined );
            
            if ( self.health < amount )
            {
                self notify( #"darkops_beehive" );
                break;
            }
            
            self.health -= amount;
        }
    }
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0xe17c51a0, Offset: 0x29d1
// Size: 0x43
function function_65164625139195b1()
{
    if ( level utility::flag( "flag_darkops_beehive_fail" ) )
    {
        return;
    }
    
    /#
        iprintln( "<dev string:x32>" );
    #/
    
    level callback::callback( #"hash_669cc12736b86353", { #players:level.players } );
}

// Namespace namespace_f6592ca7cc080b3c
// Params 0
// Checksum 0x6302e40a, Offset: 0x2a1c
// Size: 0x43
function function_12e978d9a205068a()
{
    self notify( #"hash_f95ac2d606147a38" );
    self endon( #"deleted" );
    self endon( #"darkops_beehive" );
    wait 20;
    level utility::flag_set( "flag_darkops_beehive_fail" );
    
    /#
        iprintln( "<dev string:x4b>" );
    #/
}

// Namespace namespace_f6592ca7cc080b3c
// Params 1
// Checksum 0x277f9ec7, Offset: 0x2a67
// Size: 0x4c
function spawn_parasite( struct )
{
    parasite = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_parasite_ob", struct.origin, struct.angles, "team_two_hundred" );
    parasite thread ob_nm_mode::individual_vanish( "nightmare_encouter_done" );
}

