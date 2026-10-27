// script_19e592ef07c83684  (hash_19e592ef07c83684.gscc) (size: 7995 Bytes / 0x1f3b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1c18c1e (4055993374)
// size ...... 7995 (0x1f3b)
// includes .. 15  (offset: 0x1b93)
// strings ... 60  (offset: 0x1c0b)
// dev strs .. 0   (offset: 0x1f3b)
// exports ... 20  (offset: 0x10af)
// cseg ...... 0x645 + 0xa6a (0x10af)
// imports ... 64  (offset: 0x13cf)
// animtree1 . 0   (offset: 0x1f3b)
// animtree2 . 0   (offset: 0x1f3b)
#using script_636bd827a012af12;
#using scripts\anim\dialogue;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\overlord;

#namespace namespace_3d679384f387ce89;

/#

    // Namespace namespace_3d679384f387ce89
    // Params 0
    // Checksum 0x37bec1d7, Offset: 0x663
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_3d679384f387ce89
// Params 0, eflags: 0x5
// Checksum 0xdd516151, Offset: 0x670
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_1f65b407ca8df042", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_3d679384f387ce89
// Params 0, eflags: 0x4
// Checksum 0x132ec114, Offset: 0x699
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_FREEWAY_CRASHSITE";
    activity_common::registeractivitytype( "OB_VIRGO_FREEWAY_CRASHSITE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_CRASHSITE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_CRASHSITE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_CRASHSITE", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0x754ed3e, Offset: 0x6fa
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance freeway_crashsite_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0x4601b5aa, Offset: 0x75f
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance freeway_crashsite_main();
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0xaa895a28, Offset: 0x799
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace namespace_3d679384f387ce89
    // Params 0
    // Checksum 0x700465c7, Offset: 0x7bd
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0x315425c, Offset: 0x7ca
// Size: 0x17
function freeway_crashsite_start()
{
    level utility::exploder( "fx_freeway_crashsite_bc" );
    level thread ob_virgo_util::function_4ec71c3da6905745();
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0xafc8d10d, Offset: 0x7e9
// Size: 0xd5
function function_a9ec46ea302a22b7()
{
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_start_drone_crash", "flag_start_drone_crash" );
    level utility::flag_wait( "flag_spawn_crash_path_guild" );
    level thread function_4cd53c437f174fc();
    scene_crashpath_drone_intro = utility::getstruct( "scene_crashpath_drone_intro", "targetname" );
    scene_crashpath_drone_intro scene::play();
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "heavy_3s" );
    }
    
    level utility::flag_set( "flag_play_drone_crashed_vo" );
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0x8c4ea706, Offset: 0x8c6
// Size: 0xa2
function function_4cd53c437f174fc()
{
    wait 0.25;
    
    foreach ( player in level.players )
    {
        player earthquakeforplayer( 0.2, 0.5, player.origin, 200 );
        player playrumbleonentity( "heavy_1s" );
    }
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0x57a45031, Offset: 0x970
// Size: 0x4e0
function freeway_crashsite_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level thread utility::kill_exploder( "fx_warp_02" );
    level thread ob_virgo_util::function_a3d301fb23f69fa2();
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "struct_cache_drone" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_la_drone", undefined, 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_la_drone", undefined, 1 );
    level thread virgo_vo::freeway_crashsite();
    ob_virgo_util::setup_ui_widget( "OB_VIRGO_FREEWAY_CRASHSITE" );
    level.objective_waypoint = "main_drone_interact";
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, level.objective_waypoint, undefined, "obj_waypoint_freeway_crashsite_done", undefined, undefined, undefined, undefined, 0 );
    level thread utility::exploder( "fx_freeway_crashsite" );
    level thread function_a9ec46ea302a22b7();
    level.var_7725eff553b27408 = [];
    level.var_b10f88da15525763 = [];
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_spawn_initial_crashsite_guild", "flag_spawn_crash_path_guild" );
    level utility::flag_wait( "flag_spawn_crash_path_guild" );
    scene_drone_hack = utility::getstruct( "scene_drone_hack", "targetname" );
    scene_drone_hack thread scene::play( undefined, "Pre-Hack" );
    scene_drone_hack scene::set_notify_note( level, "drone_hack_rumble", "Types_Prop", 1 );
    level thread virgo_audio::freeway_drone_hack_lp();
    s_main_drone_interact = utility::getstruct( "main_drone_interact", "targetname" );
    level utility::flag_set( "flag_player_at_crashsite_start" );
    utility::flag_wait( "flag_toDrone_wave1" );
    toDrone_wave1 = ai_spawn_director::array_spawn_targetname( "toDrone_wave1" );
    
    foreach ( var_115026f4978d19a2 in toDrone_wave1 )
    {
        var_115026f4978d19a2 thread function_bd35554bdafcb929();
    }
    
    if ( level.players.size >= 3 )
    {
        toDrone_wave1_3p = ai_spawn_director::array_spawn_targetname( "toDrone_wave1_3p" );
        toDrone_wave1 = arraycombine( toDrone_wave1, toDrone_wave1_3p );
    }
    
    level thread virgo_audio::crashsite_combat_walla();
    utility::array_thread( toDrone_wave1, &function_642b6f3c9d00728 );
    level thread ob_virgo_util::function_2463b23bc69b1a0a( toDrone_wave1, toDrone_wave1.size - 1, "flag_toDrone_wave2" );
    utility::flag_wait( "flag_toDrone_wave2" );
    level thread ob_virgo_util::function_ac9de8895f3e4a23( toDrone_wave1, "vol_toDrone_wave3" );
    toDrone_wave2 = ai_spawn_director::array_spawn_targetname( "toDrone_wave2" );
    
    foreach ( var_cd6f7fd2a7d58dbb in toDrone_wave2 )
    {
        var_cd6f7fd2a7d58dbb thread function_319e15b842d1aa45();
    }
    
    level thread drone_crash();
    
    if ( level.players.size >= 3 )
    {
        toDrone_wave2_3p = ai_spawn_director::array_spawn_targetname( "toDrone_wave2_3p" );
        toDrone_wave2 = arraycombine( toDrone_wave2, toDrone_wave2_3p );
    }
    
    utility::array_thread( toDrone_wave2, &function_642b6f3c9d00728 );
    level thread ob_virgo_util::function_2463b23bc69b1a0a( toDrone_wave2, toDrone_wave2.size - 1, "flag_toDrone_wave3" );
    utility::flag_wait( "flag_toDrone_wave3" );
    level thread ob_virgo_util::function_ac9de8895f3e4a23( toDrone_wave2, "vol_toDrone_wave3" );
    toDrone_wave3 = ai_spawn_director::array_spawn_targetname( "toDrone_wave3" );
    
    foreach ( var_30ce45563db2b1ec in toDrone_wave3 )
    {
        var_30ce45563db2b1ec thread function_d9537be98eeb8c7a();
    }
    
    if ( level.players.size >= 3 )
    {
        toDrone_wave3_3p = ai_spawn_director::array_spawn_targetname( "toDrone_wave3_3p" );
        toDrone_wave3 = arraycombine( toDrone_wave3, toDrone_wave3_3p );
    }
    
    utility::array_thread( toDrone_wave3, &function_642b6f3c9d00728 );
    nm_vols = getnoentvolumearray( "dronesite_push_vol", "targetname" );
    nm_struct = utility::getstruct( "br_circle_position_02", "targetname" );
    ai_dawg_crashsite_back = ob_virgo_util::spawn_dawgs( "dawg_crashsite_back" );
    ai_dawg_crashsite_back thread function_642b6f3c9d00728();
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_player_at_crashsite", "flag_player_at_crashsite" );
    level utility::flag_wait( "flag_player_at_crashsite" );
    level utility::flag_set( "flag_crashed_drone_start_hack_obj" );
    level thread function_93792815fcb7f1e4();
    thread ob_virgo_util::function_c344e89174400419( "main_drone_interact", "flag_crashed_drone_interacted", "flag_drone_hack_done", &"sat_ob_story_missions/interact_disable", scene_drone_hack, "Hack" );
    level utility::flag_wait( "flag_drone_hack_done" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( level.objective_waypoint );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0x224a846b, Offset: 0xe58
// Size: 0x39
function function_93792815fcb7f1e4()
{
    level endon( #"flag_crashed_drone_interacted" );
    level utility::flag_wait( "flag_start_drone_nags" );
    wait 8;
    overlord::function_be2d6dc71f97faa6( "event_la_freeway_hack_callout_01" );
    wait 8;
    overlord::function_be2d6dc71f97faa6( "event_la_freeway_hack_callout_02" );
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0xaefb37aa, Offset: 0xe99
// Size: 0x63
function function_bd35554bdafcb929()
{
    agent = self;
    agent endon( #"death" );
    
    while ( true )
    {
        if ( !utility::flag( "flag_dont_reach_drone_vo_played" ) && utility::flag( "flag_play_drone_crashed_vo_done" ) )
        {
            level utility::flag_set( "flag_dont_reach_drone_vo_played" );
            agent dialogue::say( "dx_wc_irgo_vlaf_guia_dontletthemreachthed" );
        }
        
        wait 0.05;
    }
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0xbfd42f31, Offset: 0xf04
// Size: 0x46
function function_319e15b842d1aa45()
{
    agent = self;
    agent endon( #"death" );
    
    if ( !utility::flag( "flag_keep_away_drone_vo_played" ) )
    {
        level utility::flag_set( "flag_keep_away_drone_vo_played" );
        agent dialogue::say( "dx_wc_irgo_vlaf_guie_pushthembackkeepthem" );
    }
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0xc9bcd58b, Offset: 0xf52
// Size: 0x46
function function_d9537be98eeb8c7a()
{
    agent = self;
    agent endon( #"death" );
    
    if ( !utility::flag( "flag_protect_drone_vo_played" ) )
    {
        level utility::flag_set( "flag_protect_drone_vo_played" );
        agent dialogue::say( "dx_wc_irgo_vlaf_guif_protectthedroneatall" );
    }
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0xe4443efa, Offset: 0xfa0
// Size: 0x23
function function_9c956930422320d3()
{
    level utility::flag_wait( "flag_toDrone_wave2_l" );
    level.toDrone_wave2_l = ai_spawn_director::array_spawn_targetname( "toDrone_wave2_l" );
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0xe4443efa, Offset: 0xfcb
// Size: 0x23
function function_9c958730422362cd()
{
    level utility::flag_wait( "flag_toDrone_wave2_r" );
    level.toDrone_wave2_r = ai_spawn_director::array_spawn_targetname( "toDrone_wave2_r" );
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0xaa0204c4, Offset: 0xff6
// Size: 0x41
function drone_crash()
{
    utility::flag_wait_any( "flag_toDrone_wave2_l", "flag_toDrone_wave2_r" );
    scene_broken_freeway_jets = utility::getstruct( "scene_broken_freeway_jets", "targetname" );
    scene_broken_freeway_jets thread ob_virgo_util::function_29164af2d4d89658();
    scene_broken_freeway_jets thread scene::play();
}

// Namespace namespace_3d679384f387ce89
// Params 0
// Checksum 0x92d97776, Offset: 0x103f
// Size: 0x70
function function_642b6f3c9d00728()
{
    if ( level.players.size >= 3 )
    {
        level utility::flag_wait( "all_drone_juggers_dead" );
    }
    else
    {
        level utility::flag_wait( "jugger_01_dead" );
    }
    
    wait 1.5;
    wait randomfloatrange( 0.1, 0.3 );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

