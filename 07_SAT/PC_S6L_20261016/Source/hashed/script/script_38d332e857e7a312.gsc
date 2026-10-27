// script_38d332e857e7a312  (hash_38d332e857e7a312.gscc) (size: 28614 Bytes / 0x6fc6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x88334466 (2285061222)
// size ...... 28614 (0x6fc6)
// includes .. 23  (offset: 0x64ce)
// strings ... 167 (offset: 0x6586)
// dev strs .. 0   (offset: 0x6fc6)
// exports ... 55  (offset: 0x4512)
// cseg ...... 0x100f + 0x3503 (0x4512)
// imports ... 176 (offset: 0x4daa)
// animtree1 . 0   (offset: 0x6fc6)
// animtree2 . 0   (offset: 0x6fc6)
#using script_53651341190c5aab;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_lighting;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_e9f5d4f831b290e0;

/#

    // Namespace namespace_e9f5d4f831b290e0
    // Params 0
    // Checksum 0xf58b9fbe, Offset: 0x102d
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_e9f5d4f831b290e0
// Params 0, eflags: 0x5
// Checksum 0x7f3d1a61, Offset: 0x103a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a18d30adea0d2b8b", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0, eflags: 0x4
// Checksum 0xca8f4e48, Offset: 0x1063
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_INFIL_STORAGE";
    activity_common::registeractivitytype( "OB_LIBRA_INFIL_STORAGE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL_STORAGE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL_STORAGE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL_STORAGE", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x5ee38505, Offset: 0x10c4
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x5d1052c5, Offset: 0x1129
// Size: 0x48
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance function_498662910ed15ade();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x68bc0441, Offset: 0x1179
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xc2d78e6d, Offset: 0x119d
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "ob_libra_infil_storage_investigate" );
}

/#

    // Namespace namespace_e9f5d4f831b290e0
    // Params 0
    // Checksum 0xb2313bae, Offset: 0x11b3
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x800d6aaf, Offset: 0x11c0
// Size: 0x28
function start()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    level thread function_5975003871527458();
    level thread mp_sat_ob_libra_lighting::function_b7ceeb7cacd224c8();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x70f90f10, Offset: 0x11f0
// Size: 0xf8
function function_498662910ed15ade()
{
    thread function_65f90b699d11599();
    clip = getent( "storage_sight_clip", "targetname" );
    clip connectpaths();
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( "ob_libra_infil_analysis_investigate" );
    mp_sat_ob_libra_util::function_4003e4e7ea24dd2b( "storage_off" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_libra_storage", "flag_igc_answers_done", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_storage", "flag_igc_answers_done", 1 );
    case_struct = utility::getstruct( "ability_struct_storage", "targetname" );
    
    if ( isdefined( case_struct ) )
    {
        thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_drone_launcher", "super_vision_pulse", #"default" );
    }
    
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "storage_central_waypoint_org", undefined, "storage_waypoint_done", undefined, undefined, 1 );
    level thread function_43b3df9f8d922932();
    thread storage_intro_encounter();
    level utility::flag_wait( "flag_infil_storage_done" );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0, eflags: 0x4
// Checksum 0x6d4c2748, Offset: 0x12f0
// Size: 0x21
function private facility_intro_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    setup_ui_widget();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x5d2d7c56, Offset: 0x1319
// Size: 0x147
function function_43b3df9f8d922932()
{
    volumes = getentarray( "bad_place_vol", "targetname" );
    
    foreach ( vol in volumes )
    {
        vol.bad_place = createnavbadplacebyent( vol, "omega" );
    }
    
    level utility::flag_wait( "flag_storage_entered" );
    level utility::flag_wait_or_timeout( "flag_remove_badplaces", 30 );
    utility::flag_set( "flag_remove_badplaces" );
    
    foreach ( vol in volumes )
    {
        if ( isdefined( vol.bad_place ) )
        {
            destroynavobstacle( vol.bad_place );
            vol delete();
        }
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xddca9b8e, Offset: 0x1468
// Size: 0x34e
function storage_intro_encounter()
{
    level utility::flag_wait( "story_mission_party_check_complete" );
    level utility::flag_set( "flag_infil_storage_start" );
    
    if ( getdvarint( @"hash_1137593fe1f25b68", 0 ) )
    {
        vista_sphere_gl_start = utility::getstruct( "vista_sphere_gl_start" );
        
        if ( isdefined( vista_sphere_gl_start ) )
        {
            wait 0.1;
            level thread coop::teleport_player( level.player, vista_sphere_gl_start );
        }
        
        level thread vista_hallucination();
        return;
    }
    
    level utility::flag_wait( "flag_storage_entered" );
    thread function_a8a5021af4501af4();
    level.var_1853c54b5d106256 = [];
    level.enc_storage = activity_ai_encounters::function_92b671064b0b1ce2( "encounter_libra_storage", 1, 1, 1, 2 );
    function_ef57f478f96b050c( level.enc_storage, 1 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.enc_storage, &function_9976258fc26d4e93 );
    ai_spawn_director::add_spawned_callback( level.enc_storage, &storage_spawn_func );
    ai_spawn_director::function_a49c35b72d6b6fea( level.enc_storage, &function_12c7a935c2ae88cc );
    ai_spawn_director::function_5c8b22954b3bfa37( level.enc_storage, &function_e7a037d75c40b5a7, 1 );
    clip = getent( "storage_sight_clip", "targetname" );
    clip notsolid();
    clip connectpaths();
    clip delete();
    function_8bce9b0cec549dd0();
    level.var_3eaa730b1783ea8f = utility::array_removedead_or_dying( level.var_3eaa730b1783ea8f );
    
    if ( isdefined( level.var_3eaa730b1783ea8f ) )
    {
        level.var_1853c54b5d106256 = arraycombine( level.var_3eaa730b1783ea8f, level.var_1853c54b5d106256 );
    }
    
    activity_progress_tracking::function_82d854bb84c20512( "storage_kill_progress_tracker", level.var_1853c54b5d106256, &storage_kill_progress_tracker );
    thread function_c8858839d1522ce8();
    level thread function_9787f08d635d9f54();
    level utility::flag_wait( "storage_door_opened" );
    level.audio.var_25e584ceb1945db6[ "storage" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "storage" ] thread libra_audio::combat_walla_oneshot( level.var_1853c54b5d106256, "storage", "dxx_libra_coordinated_int", 2, 6, 3, undefined, 400 );
    level mp_sat_ob_libra_vo::storage_intro();
    level thread storage_intro_enemy_vo();
    level utility::flag_wait_all( "flag_storage_combat_done", "console_01_pressed", "console_02_pressed", "flag_storage_combat_clear_done", "flag_storage_all_lines_disabled_done" );
    ob_story_mission_utils::objective_text_clear();
    level mp_sat_ob_libra_vo::storage_exit();
    waitframe();
    ob_story_mission_utils::objective_text_show( "ob_libra_infil_analysis_investigate" );
    storage_door_interact = utility::getstruct( "storage_door_interact", "script_noteworthy" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "storage_door_interact_waypoint_org", undefined, "storage_door_interact_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_storage_exit_door_interacted", "storage_door_interact_waypoint_org" );
    trigger = getent( "storage_exit_door", "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        level thread mp_sat_ob_libra_util::handle_console_unlock( trigger, storage_door_interact );
        trigger waittill( #"door_opened" );
        level utility::flag_set( "flag_storage_exit_door_interacted" );
    }
    
    snd::play( "fly_hyd_hatch_open_button", storage_door_interact.origin );
    level thread vista_hallucination();
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "storage_end_waypoint_org", undefined, "storage_end_waypoint_org_waypoint_done", undefined, undefined, 1 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_infil_storage_done", "storage_end_waypoint_org" );
    level thread mp_sat_ob_libra_vo::storage_end_karma_update();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x32ffb87b, Offset: 0x17be
// Size: 0x3d
function function_65f90b699d11599()
{
    trigger = getent( "storage_door_trig", "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"opening" );
    }
    
    level utility::flag_set( "storage_door_opened" );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x1dff36b7, Offset: 0x1803
// Size: 0x43
function vista_hallucination()
{
    activateworldevent( "VFX_Libra_Stor-Pak_Vista_Ambient" );
    level thread function_cd469b4087e3a8d4();
    level thread mp_sat_ob_libra_util::function_4f33c858a708f9d4( "vista_sphere", undefined, undefined, undefined, undefined, undefined, "flag_igc_answers_start" );
    level thread function_f9317930b466a0b9();
    level thread function_17e6eebd95b689b6();
    level thread libra_audio::function_e4c47ab5254bf37c();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xdde78dc5, Offset: 0x184e
// Size: 0x15b
function function_cd469b4087e3a8d4()
{
    level endon( #"flag_igc_answers_start" );
    tag_align_stor_pack_vista = utility::getstruct( "tag_align_stor_pack_vista" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( isdefined( player.hallucination_scene_struct ) )
            {
                continue;
            }
            
            player.hallucination_scene_struct = spawnstruct();
            player.hallucination_scene_struct.origin = tag_align_stor_pack_vista.origin;
            player.hallucination_scene_struct.angles = tag_align_stor_pack_vista.angles;
            player.hallucination_scene_struct scene::function_b95eab90f9ebc981( [ player ] );
            player.hallucination_scene_struct thread scene::play( undefined, "init", "scene_sat_cin_libra_stor_pack_hal" );
            player thread mp_sat_ob_libra_util::function_d253e2f28e08ec19( "flag_igc_answers_start" );
        }
        
        waitframe();
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xcb902b44, Offset: 0x19b1
// Size: 0x6e
function function_17e6eebd95b689b6()
{
    vista_tube_entrance_door = getent( "vista_tube_entrance_door", #script_noteworthy );
    
    if ( isdefined( vista_tube_entrance_door ) )
    {
        vista_tube_entrance_door thread function_ef19296326fd54bd( "libra_vistaroom_door_bubbles_vfx", "flag_igc_answers_start" );
    }
    
    vista_tube_exit_door = getent( "vista_tube_exit_door", #script_noteworthy );
    
    if ( isdefined( vista_tube_exit_door ) )
    {
        vista_tube_exit_door thread function_ef19296326fd54bd( "libra_vistaroom_exit_door_bubbles_vfx", "flag_igc_answers_start" );
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 2
// Checksum 0x66182a95, Offset: 0x1a27
// Size: 0x40
function function_ef19296326fd54bd( exploder, ender )
{
    level endon( ender );
    
    while ( true )
    {
        self waittill( #"opening" );
        utility::exploder( exploder );
        level thread mp_sat_ob_libra_vo::storage_end_hallucination();
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xc147139d, Offset: 0x1a6f
// Size: 0x45
function function_f9317930b466a0b9()
{
    scene_root = utility::getstruct( "scene_root_sat_cin_libra_stor_pack_float_dead" );
    
    if ( isdefined( scene_root ) )
    {
        scene_root thread scene::play( undefined, undefined, "scene_sat_cin_libra_stor_pack_float_dead" );
        level utility::flag_wait( "flag_igc_answers_start" );
        scene_root thread scene::stop();
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xd4bd6b8b, Offset: 0x1abc
// Size: 0x380
function function_c8858839d1522ce8()
{
    level utility::flag_wait( "flag_storage_intro_done" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( "storage_central_waypoint_org" );
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_INFIL_STORAGE" );
    ob_story_mission_utils::function_315d79883d962ba7( 0, 2 );
    thread mp_sat_ob_libra_util::function_c58a10af89e58f3f( "storage_console_struct_01", "console_01_pressed", &"sat_ob_story_missions/interact_disable" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "storage_console_struct_01", undefined, "storage_console_01_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "console_01_pressed", "storage_console_struct_01" );
    thread mp_sat_ob_libra_util::function_c58a10af89e58f3f( "storage_console_struct_02", "console_02_pressed", &"sat_ob_story_missions/interact_disable" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "storage_console_struct_02", undefined, "storage_console_02_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "console_02_pressed", "storage_console_struct_02" );
    level utility::flag_wait_any( "console_01_pressed", "console_02_pressed" );
    thread function_deab9df2cb498633();
    var_13e791a3cfb97e07 = utility::getstruct( "storage_console_struct_01", "targetname" );
    utility::play_sound_in_space( "fly_assembly_line_console_interact", var_13e791a3cfb97e07.origin );
    utility::play_sound_in_space( "evt_assembly_line_shutdown_console", level.var_e36f5908956e8c87 );
    level thread mp_sat_ob_libra_vo::storage_one_line_disabled();
    level.current_activity ob_story_mission_utils::function_315d79883d962ba7( 1, 2 );
    activateworldevent( "LGT_storage_yellow_line_off" );
    utility::flag_set( "left_scene_stopped" );
    level.var_75dacee2337798ec scene::pause( 1 );
    
    foreach ( crate in level.var_f4b7c43a8ef36331 )
    {
        crate function_8c9c2e71727d1653();
    }
    
    level utility::flag_wait_all( "console_01_pressed", "console_02_pressed" );
    thread function_deab9df2cb498633();
    
    if ( isdefined( level.enc_storage ) )
    {
        ai_spawn_director::cancel_spawn_request( level.enc_storage );
    }
    
    if ( isdefined( level.var_440c1fdcc053480e ) )
    {
        ai_spawn_director::cancel_spawn_request( level.var_440c1fdcc053480e );
    }
    
    var_ec2a721027b3abb4 = utility::getstruct( "storage_console_struct_02", "targetname" );
    utility::play_sound_in_space( "fly_assembly_line_console_interact", var_ec2a721027b3abb4.origin );
    utility::play_sound_in_space( "evt_assembly_line_shutdown_console", level.var_e36f5908956e8c87 );
    activateworldevent( "LGT_storage_white_line_off" );
    utility::flag_set( "right_scene_stopped" );
    level.current_activity ob_story_mission_utils::function_315d79883d962ba7( 2, 2 );
    level thread mp_sat_ob_libra_vo::storage_all_lines_disabled();
    level.var_af192118978d72d9 scene::pause( 1 );
    
    foreach ( crate in level.var_e01b6e2b8d3c6e92 )
    {
        crate function_8c9c2e71727d1653();
    }
    
    level utility::flag_set( "robotic_lines_disabled" );
    
    if ( !level utility::flag( "flag_storage_combat_done" ) )
    {
        wait 1;
        level thread mp_sat_ob_libra_vo::storage_combat_mop_them_up();
        ob_story_mission_utils::objective_text_show( "ob_libra_infil_storage_clean_up" );
        thread function_88d51aea31873166();
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x2abc2394, Offset: 0x1e44
// Size: 0xf9
function function_88d51aea31873166()
{
    array = utility::array_removedead_or_dying( level.var_1853c54b5d106256 );
    
    foreach ( agent in array )
    {
        agent function_fa32376aaa88a7a2( agent.origin, 2000 );
        players = ob_story_mission_utils::get_playing_players();
        closest_player = function_47c86977a18df38b( players, agent.origin );
        
        if ( isalive( closest_player ) )
        {
            agent cleargoalvolume();
            agent setgoalentity( closest_player );
            agent.goalradius = 32;
            agent getenemyinfo( closest_player );
            agent forcethreatupdate();
        }
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 4
// Checksum 0x1fb7db46, Offset: 0x1f45
// Size: 0x83
function storage_spawn_func( requestid, instance, agent, ai_data )
{
    level.var_1853c54b5d106256[ level.var_1853c54b5d106256.size ] = agent;
    agent val::set( "storage", "ignoreall", 1 );
    waittime = randomfloatrange( 5, 8 );
    utility::flag_wait_or_timeout( "flag_remove_badplaces", waittime );
    agent val::reset_all( "storage" );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xb45f308, Offset: 0x1fd0
// Size: 0x104
function storage_intro_enemy_vo()
{
    utility::flag_wait_or_timeout( "flag_remove_badplaces", 3 );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && isdefined( player.origin ) )
        {
            sort_org = player.origin;
            break;
        }
    }
    
    if ( isdefined( sort_org ) )
    {
        var_bf004336cf9a5b48 = sortbydistance( level.var_1853c54b5d106256, sort_org );
    }
    else
    {
        var_bf004336cf9a5b48 = level.var_1853c54b5d106256;
    }
    
    if ( var_bf004336cf9a5b48.size >= 2 )
    {
        level.var_ad944ad4f49676f4 = var_bf004336cf9a5b48[ 0 ];
        level.var_ad944dd4f4967d8d = var_bf004336cf9a5b48[ 1 ];
        thread mp_sat_ob_libra_vo::function_1ace583b05093a83();
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 3
// Checksum 0xd686f4ee, Offset: 0x20dc
// Size: 0x78
function function_12c7a935c2ae88cc( requestid, userdata, shutdowndata )
{
    level thread mp_sat_ob_libra_util::function_d8b65cd09b5a50bb( level.var_1853c54b5d106256, "flag_storage_combat_done", 1 );
    
    if ( isdefined( level.enc_storage ) )
    {
        iprintln( "storage encounter complete!" );
        ai_spawn_director::cancel_spawn_request( level.enc_storage );
    }
    
    if ( !utility::flag( "flag_packing_enemies_spawned" ) )
    {
        level notify( #"hash_decdb9ca26e79f98" );
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xc9e7fb25, Offset: 0x215c
// Size: 0x56
function function_9787f08d635d9f54()
{
    level utility::flag_wait( "flag_storage_combat_done" );
    level mp_sat_ob_libra_vo::storage_combat_clear();
    
    if ( utility::flag( "robotic_lines_disabled" ) )
    {
        return;
    }
    
    if ( utility::flag( "console_01_pressed" ) || utility::flag( "console_02_pressed" ) )
    {
        level thread mp_sat_ob_libra_vo::storage_one_more_left();
        return;
    }
    
    level thread mp_sat_ob_libra_vo::storage_shut_down_robotic_lines();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 3
// Checksum 0x80c6b633, Offset: 0x21ba
// Size: 0x2b
function function_9976258fc26d4e93( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_storage_enemies_spawned" );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 3
// Checksum 0x23732432, Offset: 0x21ed
// Size: 0x50, Type: bool
function function_e7a037d75c40b5a7( requestid, userdata, wavenumber )
{
    if ( !utility::flag( "flag_remove_badplaces" ) )
    {
        return false;
    }
    
    if ( utility::flag( "left_scene_stopped" ) && utility::flag( "right_scene_stopped" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_e9f5d4f831b290e0
// Params 3
// Checksum 0xa1686547, Offset: 0x2246
// Size: 0x157
function storage_kill_progress_tracker( requestid, activity_instance, agent )
{
    level.var_1853c54b5d106256 = utility::array_removedead_or_dying( level.var_1853c54b5d106256 );
    
    if ( level.var_1853c54b5d106256.size <= 5 && utility::flag( "robotic_lines_disabled" ) )
    {
        iprintln( "enemies retreat / rush player" );
        
        foreach ( guy in level.var_1853c54b5d106256 )
        {
            guy function_fa32376aaa88a7a2( guy.origin, 2000 );
            a_players = ob_story_mission_utils::get_playing_players();
            a_players = sortbydistance( a_players, guy.origin );
            
            if ( a_players.size > 0 )
            {
                guy cleargoalvolume();
                guy cleargoalentity();
                guy setgoalentity( a_players[ 0 ] );
                guy getenemyinfo( a_players[ 0 ] );
                guy forcethreatupdate();
            }
            
            guy mp_sat_ob_libra_util::ai_nerf();
        }
        
        return;
    }
    
    if ( level.var_1853c54b5d106256.size == 1 )
    {
        clearmusicstate();
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xfbb43289, Offset: 0x23a5
// Size: 0x35
function function_8bce9b0cec549dd0()
{
    level.var_33eaab6779079cf8 = ai_spawn_director::array_spawn_targetname( "storage_side_enemies" );
    level.var_1853c54b5d106256 = arraycombine( level.var_33eaab6779079cf8, level.var_1853c54b5d106256 );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 3
// Checksum 0x5ea8591, Offset: 0x23e2
// Size: 0x2b
function function_b13bcea077186c6f( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_storage_side_spawned" );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 3
// Checksum 0xeea33844, Offset: 0x2415
// Size: 0x2b
function function_7bb86c4042d69a18( requestid, userdata, shutdowndata )
{
    level utility::flag_set( "flag_storage_side_combat_done" );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 4
// Checksum 0x37fa9033, Offset: 0x2448
// Size: 0x125
function function_6ce469a1ac9f295e( requestid, instance, agent, ai_data )
{
    if ( isdefined( ai_data.script_noteworthy ) )
    {
        switch ( ai_data.script_noteworthy )
        {
            case #"hash_e3fdc2325e964a16":
                agent.var_88af750d8cd349c1 = 1;
                agent.forcenewenemyreaction = 1;
                interaction_common::function_c75f85a96a10a251( ai_data.interaction_id, &mp_sat_ob_libra_util::function_8b236fd87f53b446 );
                agent thread mp_sat_ob_libra_util::function_afa9097075953144( "storage_mainfloor" );
                level.var_fe4a5a26c092d595 = agent;
                break;
            case #"hash_e3fdc1325e964883":
                agent.var_88af750d8cd349c1 = 1;
                agent.forcenewenemyreaction = 1;
                interaction_common::function_c75f85a96a10a251( ai_data.interaction_id, &mp_sat_ob_libra_util::function_8b236fd87f53b446 );
                agent thread mp_sat_ob_libra_util::function_afa9097075953144( "storage_mainfloor" );
                level.var_fe4a5726c092cefc = agent;
                break;
            default:
                break;
        }
    }
    
    level.var_33eaab6779079cf8[ level.var_33eaab6779079cf8.size ] = agent;
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x9a505f44, Offset: 0x2575
// Size: 0x10
function function_a8a5021af4501af4()
{
    thread function_1e77c8b35e682285();
    thread function_e3b6d0d1548c70c8();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x36d2fb30, Offset: 0x258d
// Size: 0x4c9
function function_1e77c8b35e682285()
{
    level.scene_struct_lift_1 = utility::getstruct( "scene_struct_lift_1", "targetname" );
    level.scene_struct_lift_2 = utility::getstruct( "scene_struct_lift_2", "targetname" );
    level.scene_struct_lift_3 = utility::getstruct( "scene_struct_lift_3", "targetname" );
    level.scene_struct_lift_4 = utility::getstruct( "scene_struct_lift_4", "targetname" );
    level.scene_struct_lift_1 thread scene::init( undefined, "shot_010", "scene_sat_cin_libra_storage_lift_grp1" );
    level.scene_struct_lift_2 thread scene::init( undefined, "shot_010", "scene_sat_cin_libra_storage_lift_grp2" );
    level.scene_struct_lift_3 thread scene::init( undefined, "shot_010", "scene_sat_cin_libra_storage_lift_grp3" );
    level.scene_struct_lift_4 thread scene::init( undefined, "shot_010", "scene_sat_cin_libra_storage_lift_grp4" );
    lift_crate1 = level.scene_struct_lift_1 scene::get_entity( "lift_crate1" );
    lift_crate2 = level.scene_struct_lift_2 scene::get_entity( "lift_crate2" );
    lift_crate3 = level.scene_struct_lift_3 scene::get_entity( "lift_crate3" );
    lift_crate4 = level.scene_struct_lift_4 scene::get_entity( "lift_crate4" );
    lift1 = level.scene_struct_lift_1 scene::get_entity( "lift1" );
    lift2 = level.scene_struct_lift_2 scene::get_entity( "lift2" );
    lift3 = level.scene_struct_lift_3 scene::get_entity( "lift3" );
    lift4 = level.scene_struct_lift_4 scene::get_entity( "lift4" );
    lift_array = [ lift1, lift2, lift3, lift4, lift_crate1, lift_crate2, lift_crate3, lift_crate4 ];
    lift_crate1_clip = getent( "lift_crate1_clip", "targetname" );
    lift_crate2_clip = getent( "lift_crate2_clip", "targetname" );
    lift_crate3_clip = getent( "lift_crate3_clip", "targetname" );
    lift_crate4_clip = getent( "lift_crate4_clip", "targetname" );
    lift1_clip = getent( "lift1_clip", "targetname" );
    lift2_clip = getent( "lift2_clip", "targetname" );
    lift3_clip = getent( "lift3_clip", "targetname" );
    lift4_clip = getent( "lift4_clip", "targetname" );
    lift_clips = [ lift1_clip, lift2_clip, lift3_clip, lift4_clip ];
    lift_crate_clips = [ lift_crate1_clip, lift_crate2_clip, lift_crate3_clip, lift_crate4_clip ];
    level.var_2e0766b4bf1f8763 = [ lift1_clip, lift2_clip, lift3_clip, lift4_clip, lift_crate1_clip, lift_crate2_clip, lift_crate3_clip, lift_crate4_clip ];
    waitframe();
    
    for ( i = 0; i < lift_array.size ; i++ )
    {
        if ( isdefined( lift_array[ i ] ) )
        {
            level.var_2e0766b4bf1f8763[ i ] linkto( lift_array[ i ] );
        }
    }
    
    wait 0.5;
    
    if ( isdefined( level.var_2e0766b4bf1f8763 ) )
    {
        foreach ( clip in level.var_2e0766b4bf1f8763 )
        {
            clip connectpaths();
        }
    }
    
    level.scene_struct_lift_1 thread function_44739b8962bc0524( "scene_sat_cin_libra_storage_lift_grp1", lift1 );
    level.scene_struct_lift_2 thread function_44739b8962bc0524( "scene_sat_cin_libra_storage_lift_grp2", lift2 );
    level.scene_struct_lift_3 thread function_44739b8962bc0524( "scene_sat_cin_libra_storage_lift_grp3", lift3 );
    level.scene_struct_lift_4 thread function_44739b8962bc0524( "scene_sat_cin_libra_storage_lift_grp4", lift4 );
    wait 7;
    
    if ( isdefined( lift_clips ) )
    {
        foreach ( clip in lift_clips )
        {
            clip disconnectpaths();
        }
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 2
// Checksum 0xaf774d96, Offset: 0x2a5e
// Size: 0x52
function function_44739b8962bc0524( scene_name, lift_ent )
{
    scene::play( undefined, "shot_010", scene_name );
    ent = getent( "test_model", "targetname" );
    lift_ent scriptmodelclearanim();
    waitframe();
    lift_ent setmodel( "red::sat_storage_lift_bot_01_anim" );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xc17c0242, Offset: 0x2ab8
// Size: 0x6a3
function function_e3b6d0d1548c70c8()
{
    level.var_75dacee2337798ec = utility::getstruct( "scene_storage_left_struct", "targetname" );
    level.var_af192118978d72d9 = utility::getstruct( "scene_storage_right_struct", "targetname" );
    level.var_75dacee2337798ec thread scene::init( undefined, "loop", "scene_sat_cin_libra_storage_assembly_line_left" );
    level.var_af192118978d72d9 thread scene::init( undefined, "loop", "scene_sat_cin_libra_storage_assembly_line_right" );
    waitframe();
    crate1 = level.var_75dacee2337798ec scene::get_entity( "crate1" );
    crate2 = level.var_75dacee2337798ec scene::get_entity( "crate2" );
    crate3 = level.var_75dacee2337798ec scene::get_entity( "crate3" );
    crate4 = level.var_75dacee2337798ec scene::get_entity( "crate4" );
    crate5 = level.var_af192118978d72d9 scene::get_entity( "crate5" );
    crate6 = level.var_af192118978d72d9 scene::get_entity( "crate6" );
    crate7 = level.var_af192118978d72d9 scene::get_entity( "crate7" );
    crate8 = level.var_af192118978d72d9 scene::get_entity( "crate8" );
    crate_array = [ crate1, crate2, crate3, crate4, crate5, crate6, crate7, crate8 ];
    level.var_f4b7c43a8ef36331 = [ crate1, crate2, crate3, crate4 ];
    level.var_e01b6e2b8d3c6e92 = [ crate5, crate6, crate7, crate8 ];
    crate1_clip = getent( "crate1_clip", "targetname" );
    crate2_clip = getent( "crate2_clip", "targetname" );
    crate3_clip = getent( "crate3_clip", "targetname" );
    crate4_clip = getent( "crate4_clip", "targetname" );
    crate5_clip = getent( "crate5_clip", "targetname" );
    crate6_clip = getent( "crate6_clip", "targetname" );
    crate7_clip = getent( "crate7_clip", "targetname" );
    crate8_clip = getent( "crate8_clip", "targetname" );
    roomba_crate_clips_left = getentarray( "roomba_crate_clips_left", "script_noteworthy" );
    roomba_crate_clips_right = getentarray( "roomba_crate_clips_right", "script_noteworthy" );
    waitframe();
    level.crate_clips = [ crate1_clip, crate2_clip, crate3_clip, crate4_clip, crate5_clip, crate6_clip, crate7_clip, crate8_clip ];
    
    for ( i = 0; i < crate_array.size ; i++ )
    {
        if ( isdefined( crate_array[ i ] ) )
        {
            level.crate_clips[ i ] linkto( crate_array[ i ] );
        }
    }
    
    if ( isdefined( crate_array ) )
    {
        foreach ( crate in crate_array )
        {
            crate.movement_loop = snd::play( "veh_roomba_move_lp", crate );
            crate.loop_playing = 1;
        }
    }
    
    if ( isdefined( roomba_crate_clips_left ) )
    {
        foreach ( clip in roomba_crate_clips_left )
        {
            clip thread function_18d673daa0385f11( "flag_stop_crates_left", "left_scene_stopped" );
        }
    }
    
    if ( isdefined( roomba_crate_clips_right ) )
    {
        foreach ( clip in roomba_crate_clips_right )
        {
            clip thread function_18d673daa0385f11( "flag_stop_crates_right", "right_scene_stopped" );
        }
    }
    
    waitframe();
    level.var_75dacee2337798ec thread scene::play( level.var_f4b7c43a8ef36331, "loop", "scene_sat_cin_libra_storage_assembly_line_left" );
    level.var_af192118978d72d9 thread scene::play( level.var_e01b6e2b8d3c6e92, "loop", "scene_sat_cin_libra_storage_assembly_line_right" );
    
    foreach ( crate in crate_array )
    {
        crate function_49a2b2cb749ba96f();
    }
    
    thread handle_hatches();
    thread function_2235fb17a3270b53();
    thread function_782e4edc523f8934( level.var_75dacee2337798ec, level.var_f4b7c43a8ef36331, "flag_stop_crates_left", "left_scene_stopped" );
    thread function_782e4edc523f8934( level.var_af192118978d72d9, level.var_e01b6e2b8d3c6e92, "flag_stop_crates_right", "right_scene_stopped" );
    utility::flag_wait( "robotic_lines_disabled" );
    
    foreach ( crate in crate_array )
    {
        crate function_8c9c2e71727d1653();
        
        if ( isdefined( crate.loop_playing ) && crate.loop_playing )
        {
            if ( isdefined( crate.movement_loop ) )
            {
                snd::stop( crate.movement_loop );
                crate.movement_loop = undefined;
            }
            
            crate.loop_playing = 0;
        }
    }
    
    level notify( #"hash_b596e79aaad2f4cb" );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 4
// Checksum 0x7ec6afb2, Offset: 0x3163
// Size: 0x161
function function_782e4edc523f8934( scene, crates, flag, final_flag )
{
    while ( !level utility::flag( "robotic_lines_disabled" ) )
    {
        if ( utility::flag( flag ) )
        {
            scene scene::pause( 1 );
            level notify( #"hash_9b8238c91d4f937d" );
            
            foreach ( crate in crates )
            {
                crate function_8c9c2e71727d1653();
            }
            
            while ( utility::flag( flag ) )
            {
                wait 0.1;
            }
            
            if ( !utility::flag( final_flag ) )
            {
                scene scene::pause( 0 );
                
                foreach ( crate in crates )
                {
                    crate function_49a2b2cb749ba96f();
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xfcab93b6, Offset: 0x32cc
// Size: 0x4a
function function_49a2b2cb749ba96f()
{
    crate = self;
    crate setmodel( %"green_on::xcomp_sat_storage_lift_bot_platform_crate" );
    playfxontag( utility::getfx( "vfx_sat_storage_lift_bot_platform" ), crate, "tag_origin" );
    crate mp_sat_ob_libra_util::function_889f3afecd07ea9e();
    crate thread handle_crate_audio( 1 );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xbcfdd469, Offset: 0x331e
// Size: 0x49
function function_8c9c2e71727d1653()
{
    crate = self;
    crate setmodel( %"red_on::xcomp_sat_storage_lift_bot_platform_crate" );
    killfxontag( utility::getfx( "vfx_sat_storage_lift_bot_platform" ), crate, "tag_origin" );
    crate mp_sat_ob_libra_util::cradle_crate_spawn_nodes();
    crate thread handle_crate_audio( 0 );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 1
// Checksum 0x240ada73, Offset: 0x336f
// Size: 0xad
function handle_crate_audio( moving )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( moving )
    {
        if ( !self.loop_playing )
        {
            self.movement_loop = snd::play( "veh_roomba_move_lp", self );
            snd::play( "veh_roomba_start", self );
            self.loop_playing = 1;
        }
        
        return;
    }
    
    if ( isdefined( self.loop_playing ) && self.loop_playing )
    {
        if ( isdefined( self.movement_loop ) )
        {
            snd::stop( self.movement_loop );
            self.movement_loop = undefined;
        }
        
        snd::play( "veh_roomba_stop", self );
        self.loop_playing = 0;
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x1e9057c2, Offset: 0x3424
// Size: 0xa8
function function_2235fb17a3270b53()
{
    level endon( #"hash_b596e79aaad2f4cb" );
    level.var_e36f5908956e8c87 = ( 724, -2085, 1873 );
    
    if ( utility::flag( "flag_stop_crates" ) )
    {
        utility::flag_waitopen( "flag_stop_crates" );
        snd::play( "evt_assembly_line_start", level.var_e36f5908956e8c87 );
    }
    
    while ( !level utility::flag( "robotic_lines_disabled" ) )
    {
        utility::flag_wait( "flag_stop_crates" );
        snd::play( "evt_assembly_line_shutdown", level.var_e36f5908956e8c87 );
        utility::flag_waitopen( "flag_stop_crates" );
        snd::play( "evt_assembly_line_start", level.var_e36f5908956e8c87 );
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 2
// Checksum 0x901e26dc, Offset: 0x34d4
// Size: 0x75
function function_18d673daa0385f11( flag, flag2 )
{
    crate = getent( self.target, "targetname" );
    
    while ( !level utility::flag( flag2 ) )
    {
        if ( utility::flag( flag ) )
        {
            self disconnectpaths();
            
            while ( utility::flag( flag ) )
            {
                wait 0.1;
            }
            
            self connectpaths();
        }
        
        waitframe();
    }
    
    self disconnectpaths();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x459b301c, Offset: 0x3551
// Size: 0x376
function handle_hatches()
{
    waitframe();
    hatch01_top = level.var_75dacee2337798ec scene::get_entity( "hatch01_top" );
    hatch01_bottom = level.var_75dacee2337798ec scene::get_entity( "hatch01_bottom" );
    hatch02_top = level.var_75dacee2337798ec scene::get_entity( "hatch02_top" );
    hatch02_bottom = level.var_75dacee2337798ec scene::get_entity( "hatch02_bottom" );
    hatch05_top = level.var_af192118978d72d9 scene::get_entity( "hatch05_top" );
    hatch05_bottom = level.var_af192118978d72d9 scene::get_entity( "hatch05_bottom" );
    hatch06_top = level.var_af192118978d72d9 scene::get_entity( "hatch06_top" );
    hatch06_bottom = level.var_af192118978d72d9 scene::get_entity( "hatch06_bottom" );
    hatches = [ hatch01_top, hatch01_bottom, hatch02_top, hatch02_bottom, hatch05_top, hatch05_bottom, hatch06_top, hatch06_bottom ];
    hatches_right = [ hatch01_top, hatch01_bottom, hatch06_top, hatch06_bottom ];
    var_4e75eb8c5788cd49 = [ hatch01_bottom, hatch06_bottom ];
    var_635a9da9e0fb1f49 = [ hatch01_top, hatch06_top ];
    hatches_left = [ hatch02_top, hatch02_bottom, hatch05_top, hatch05_bottom ];
    var_1e03790815f2471c = [ hatch02_bottom, hatch05_bottom ];
    var_507477130d18ad1c = [ hatch02_top, hatch05_top ];
    hatch01_top_clip = getent( "hatch01_top_clip", "targetname" );
    hatch01_bottom_clip = getent( "hatch01_bottom_clip", "targetname" );
    hatch02_top_clip = getent( "hatch02_top_clip", "targetname" );
    hatch02_bottom_clip = getent( "hatch02_bottom_clip", "targetname" );
    hatch05_top_clip = getent( "hatch05_top_clip", "targetname" );
    hatch05_bottom_clip = getent( "hatch05_bottom_clip", "targetname" );
    hatch06_top_clip = getent( "hatch06_top_clip", "targetname" );
    hatch06_bottom_clip = getent( "hatch06_bottom_clip", "targetname" );
    var_312fe3020f3dbc11 = [ hatch01_top_clip, hatch01_bottom_clip, hatch06_top_clip, hatch06_bottom_clip ];
    var_11d7583ea71cf44 = [ hatch02_top_clip, hatch02_bottom_clip, hatch05_top_clip, hatch05_bottom_clip ];
    clips = [ hatch01_top_clip, hatch01_bottom_clip, hatch02_top_clip, hatch02_bottom_clip, hatch05_top_clip, hatch05_bottom_clip, hatch06_top_clip, hatch06_bottom_clip ];
    
    for ( i = 0; i < hatches.size ; i++ )
    {
        if ( isdefined( hatches[ i ] ) )
        {
            clips[ i ] linkto( hatches[ i ] );
        }
    }
    
    thread hatch_buttons( "right01", "right_hatch_open", hatches_right, var_312fe3020f3dbc11, var_4e75eb8c5788cd49, var_635a9da9e0fb1f49 );
    thread hatch_buttons( "left01", "left_hatch_open", hatches_left, var_11d7583ea71cf44, var_1e03790815f2471c, var_507477130d18ad1c );
    thread function_51d804edf163a4();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x3dc57d4b, Offset: 0x38cf
// Size: 0x115
function function_51d804edf163a4()
{
    hatch01_top = level.var_75dacee2337798ec scene::get_entity( "hatch01_top" );
    hatch02_top = level.var_75dacee2337798ec scene::get_entity( "hatch02_top" );
    hatch05_top = level.var_af192118978d72d9 scene::get_entity( "hatch05_top" );
    hatch06_top = level.var_af192118978d72d9 scene::get_entity( "hatch06_top" );
    top_hatches = [ hatch01_top, hatch02_top, hatch05_top, hatch06_top ];
    
    foreach ( var_6cf54908cd066dfc in top_hatches )
    {
        if ( isdefined( var_6cf54908cd066dfc ) )
        {
            var_6cf54908cd066dfc thread hatch_audio_loop();
        }
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0xb2e3d48e, Offset: 0x39ec
// Size: 0x98
function hatch_audio_loop()
{
    self endon( #"death" );
    level endon( #"robotic_lines_disabled" );
    var_6cf54908cd066dfc = self;
    var_6cf54908cd066dfc.hatch_moving = 0;
    var_6cf54908cd066dfc.movement_loop = undefined;
    
    while ( !level utility::flag( "robotic_lines_disabled" ) )
    {
        var_6cf54908cd066dfc waittill( #"hatch_open_start" );
        
        if ( !utility::flag( "flag_stop_crates" ) )
        {
            var_6cf54908cd066dfc thread function_36119d5b1f59ee3a();
        }
        
        var_6cf54908cd066dfc waittill( #"hatch_open_stop" );
        var_6cf54908cd066dfc thread function_547fee40ce2b1fe2();
    }
    
    var_6cf54908cd066dfc thread function_547fee40ce2b1fe2();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x472e4b54, Offset: 0x3a8c
// Size: 0x5c
function function_36119d5b1f59ee3a()
{
    var_6cf54908cd066dfc = self;
    
    if ( var_6cf54908cd066dfc.hatch_moving )
    {
        return;
    }
    
    snd::play( "evt_hatch_door_start", var_6cf54908cd066dfc );
    var_6cf54908cd066dfc.movement_loop = snd::play( "evt_hatch_door_move_lp", var_6cf54908cd066dfc );
    var_6cf54908cd066dfc.hatch_moving = 1;
    var_6cf54908cd066dfc thread function_a7154593106a69f4();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x343feec5, Offset: 0x3af0
// Size: 0x74
function function_547fee40ce2b1fe2()
{
    var_6cf54908cd066dfc = self;
    var_6cf54908cd066dfc.stop_monitoring = 1;
    
    if ( !var_6cf54908cd066dfc.hatch_moving )
    {
        return;
    }
    
    if ( isdefined( var_6cf54908cd066dfc.movement_loop ) )
    {
        snd::stop( var_6cf54908cd066dfc.movement_loop );
        var_6cf54908cd066dfc.movement_loop = undefined;
    }
    
    snd::play( "evt_hatch_door_stop", var_6cf54908cd066dfc );
    var_6cf54908cd066dfc.hatch_moving = 0;
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x44e876ea, Offset: 0x3b6c
// Size: 0x146
function function_a7154593106a69f4()
{
    var_6cf54908cd066dfc = self;
    var_6cf54908cd066dfc endon( #"death" );
    level endon( #"robotic_lines_disabled" );
    var_6cf54908cd066dfc.stop_monitoring = 0;
    
    while ( !var_6cf54908cd066dfc.stop_monitoring && var_6cf54908cd066dfc.hatch_moving )
    {
        utility::flag_wait( "flag_stop_crates" );
        
        if ( var_6cf54908cd066dfc.stop_monitoring || !var_6cf54908cd066dfc.hatch_moving )
        {
            break;
        }
        
        if ( isdefined( var_6cf54908cd066dfc.movement_loop ) )
        {
            snd::stop( var_6cf54908cd066dfc.movement_loop );
            var_6cf54908cd066dfc.movement_loop = undefined;
        }
        
        snd::play( "evt_hatch_door_stop", var_6cf54908cd066dfc );
        var_6cf54908cd066dfc.hatch_moving = 0;
        utility::flag_waitopen( "flag_stop_crates" );
        
        if ( !var_6cf54908cd066dfc.stop_monitoring )
        {
            snd::play( "evt_hatch_door_start", var_6cf54908cd066dfc );
            var_6cf54908cd066dfc.movement_loop = snd::play( "evt_hatch_door_move_lp", var_6cf54908cd066dfc );
            var_6cf54908cd066dfc.hatch_moving = 1;
        }
    }
    
    if ( isdefined( var_6cf54908cd066dfc.movement_loop ) )
    {
        snd::stop( var_6cf54908cd066dfc.movement_loop );
        var_6cf54908cd066dfc.movement_loop = undefined;
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 2
// Checksum 0x32caf4ad, Offset: 0x3cba
// Size: 0x59
function function_c550d9f54817ac5b( hatchpos, time )
{
    if ( isdefined( hatchpos && time ) )
    {
        snd::play( "evt_hatch_door_start", hatchpos );
        
        if ( time > 0.5 )
        {
            snd::play( "evt_hatch_door_button_move_lp", hatchpos );
        }
        
        wait time;
        snd::play( "evt_hatch_door_stop", hatchpos );
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 6
// Checksum 0xac47a22c, Offset: 0x3d1b
// Size: 0x311
function hatch_buttons( struct, flag, hatch_array, var_f804b7f816dd7586, bottom_array, top_array )
{
    hatch_speed = 38;
    bottom_z = 1098;
    top_z = 1174;
    function_95f04ed1142be1f5( struct, flag, &"sat_ob_story_missions/interact_open" );
    utility::flag_wait( flag );
    
    foreach ( var_6cf54908cd066dfc in hatch_array )
    {
        if ( isdefined( var_6cf54908cd066dfc ) )
        {
            origin = var_6cf54908cd066dfc.origin;
            angles = var_6cf54908cd066dfc.angles;
            var_6cf54908cd066dfc stopanimscripted();
            var_6cf54908cd066dfc moveto( origin, 1 );
            var_6cf54908cd066dfc rotateto( angles, 1 );
        }
    }
    
    foreach ( var_6cf54908cd066dfc in bottom_array )
    {
        if ( isdefined( var_6cf54908cd066dfc ) )
        {
            hatchpos = var_6cf54908cd066dfc.origin;
            distance = abs( var_6cf54908cd066dfc.origin[ 2 ] - bottom_z );
            time = distance / hatch_speed;
            var_6cf54908cd066dfc moveto( ( hatchpos[ 0 ], hatchpos[ 1 ], bottom_z ), time );
        }
    }
    
    foreach ( var_6cf54908cd066dfc in top_array )
    {
        if ( isdefined( var_6cf54908cd066dfc ) )
        {
            hatchpos = var_6cf54908cd066dfc.origin;
            distance = abs( var_6cf54908cd066dfc.origin[ 2 ] - top_z );
            time = distance / hatch_speed;
            thread function_c550d9f54817ac5b( hatchpos, time );
            var_6cf54908cd066dfc moveto( ( hatchpos[ 0 ], hatchpos[ 1 ], top_z ), time );
        }
    }
    
    wait 1;
    
    foreach ( clip in var_f804b7f816dd7586 )
    {
        if ( isdefined( clip ) )
        {
            clip connectpaths();
            clip delete();
        }
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 7
// Checksum 0x85db50bb, Offset: 0x4034
// Size: 0x2ae
function function_95f04ed1142be1f5( t_name, flag_name, var_81916649a7b1af22 = &"sat_ob_story_missions/interact_open", radius = 64, displayrange = 128, displayfov = 360, usefov = 45 )
{
    button = utility::getstruct( t_name, "targetname" );
    button2 = utility::getstruct( button.target, "targetname" );
    button.scriptable = getentitylessscriptablearray( button.target, "targetname" );
    button2.scriptable = getentitylessscriptablearray( button2.target, "targetname" );
    button.interact = interaction::register_interact( button.origin, radius, &line_button_interact, var_81916649a7b1af22, undefined, undefined, undefined, "HINT_BUTTON" );
    button.interact.flag_name = flag_name;
    button.interact.obj_root = self;
    button.interact.other_button = button2;
    button.interact sethintdisplayrange( displayrange );
    button.interact sethintdisplayfov( displayfov );
    button.interact setusefov( usefov );
    
    if ( isdefined( button.scriptable[ 0 ] ) )
    {
        button.interact.scriptable = button.scriptable[ 0 ];
    }
    
    button2.interact = interaction::register_interact( button2.origin, radius, &line_button_interact, var_81916649a7b1af22, undefined, undefined, undefined, "HINT_BUTTON" );
    button2.interact.flag_name = flag_name;
    button2.interact.obj_root = self;
    button2.interact.other_button = button;
    button2.interact sethintdisplayrange( displayrange );
    button2.interact sethintdisplayfov( displayfov );
    button2.interact setusefov( usefov );
    
    if ( isdefined( button2.scriptable[ 0 ] ) )
    {
        button2.interact.scriptable = button2.scriptable[ 0 ];
    }
}

// Namespace namespace_e9f5d4f831b290e0
// Params 1
// Checksum 0xc936b28d, Offset: 0x42ea
// Size: 0xdd
function line_button_interact( player )
{
    if ( isdefined( self.flag_name ) )
    {
        utility::flag_set( self.flag_name );
    }
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable setscriptablepartstate( "door_lock", "locked" );
    }
    
    if ( isdefined( self.other_button ) && isdefined( self.other_button.interact ) )
    {
        self.other_button.interact makeunusable();
        
        if ( isdefined( self.other_button.interact.scriptable ) )
        {
            self.other_button.interact.scriptable setscriptablepartstate( "door_lock", "locked" );
        }
    }
    
    self makeunusable();
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x8f22f983, Offset: 0x43cf
// Size: 0x10c
function function_deab9df2cb498633()
{
    if ( utility::flag( "console_01_pressed" ) )
    {
        utility::flag_set( "left_hatch_open" );
    }
    
    if ( utility::flag( "console_02_pressed" ) )
    {
        utility::flag_set( "right_hatch_open" );
    }
    
    consoles = getentarray( "storage_console", "targetname" );
    
    if ( consoles.size < 1 )
    {
        return;
    }
    
    structname = "storage_console_struct_01";
    
    if ( !isdefined( level.last_storage_console ) && utility::flag( "console_02_pressed" ) || level.last_storage_console == "storage_console_struct_01" )
    {
        structname = "storage_console_struct_02";
    }
    
    level.last_storage_console = structname;
    console_button = utility::getstruct( structname, "targetname" );
    consoles = sortbydistance( consoles, console_button.origin );
    used_console = consoles[ 0 ];
    mp_sat_ob_libra_util::function_bd1845bf5896dd1b( used_console, "storage_off", "sat_libra_electronics_server_console_standing_01b" );
    utility::delaythread( 0.2, &mp_sat_ob_libra_util::function_4003e4e7ea24dd2b, "storage_off", 0 );
}

// Namespace namespace_e9f5d4f831b290e0
// Params 0
// Checksum 0x945a07d8, Offset: 0x44e3
// Size: 0x2f
function function_5975003871527458()
{
    analysis_to_storage_door = getent( "analysis_to_storage_door", #script_noteworthy );
    
    if ( isdefined( analysis_to_storage_door ) )
    {
        analysis_to_storage_door thread scriptable_door_utility::simple_lock_door();
    }
}

