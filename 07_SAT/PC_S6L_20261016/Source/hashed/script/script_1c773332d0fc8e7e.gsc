// script_1c773332d0fc8e7e  (hash_1c773332d0fc8e7e.gscc) (size: 7814 Bytes / 0x1e86 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x902f8152 (2419032402)
// size ...... 7814 (0x1e86)
// includes .. 15  (offset: 0x1ac6)
// strings ... 56  (offset: 0x1b3e)
// dev strs .. 3   (offset: 0x1e5e)
// exports ... 18  (offset: 0x10b6)
// cseg ...... 0x567 + 0xb4f (0x10b6)
// imports ... 59  (offset: 0x1386)
// animtree1 . 0   (offset: 0x1e86)
// animtree2 . 0   (offset: 0x1e86)
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\chyron;
#using scripts\common\hints;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\overlord;

#namespace namespace_5eb68bf3d7c068d3;

/#

    // Namespace namespace_5eb68bf3d7c068d3
    // Params 0
    // Checksum 0x13f9678d, Offset: 0x585
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_5eb68bf3d7c068d3
// Params 0, eflags: 0x5
// Checksum 0x4913c857, Offset: 0x592
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_aee47a8563febd08", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0, eflags: 0x4
// Checksum 0x1f498ea, Offset: 0x5bb
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_FREEWAY_INTRO";
    activity_common::registeractivitytype( "OB_VIRGO_FREEWAY_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_INTRO", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0xdb016ca9, Offset: 0x61c
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance freeway_intro_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0x11cd92a6, Offset: 0x681
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance thread freeway_intro_main();
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0x8ecefc72, Offset: 0x6bb
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace namespace_5eb68bf3d7c068d3
    // Params 0
    // Checksum 0x5443c39d, Offset: 0x6df
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0x72869045, Offset: 0x6ec
// Size: 0x2
function freeway_intro_start()
{
    
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0xe781a59, Offset: 0x6f6
// Size: 0x19b
function freeway_intro_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    activity_instance = self;
    bm_cradle_portal_clip_01 = getent( "bm_cradle_portal_clip_01", "targetname" );
    bm_cradle_portal_clip_01 hide();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_la_intro", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_equip_la_intro", undefined, 1 );
    level thread ob_virgo_util::function_4ec71c3da6905745();
    activity_instance ob_virgo_util::setup_ui_widget( "OB_VIRGO_FREEWAY_INTRO" );
    level.objective_waypoint = "int_memory_jump_01";
    activity_instance thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "int_memory_jump_01", undefined, "obj_waypoint_freeway_intro_done", undefined, undefined, undefined, undefined, 0 );
    level thread utility::exploder( "fx_freeway_intro" );
    level thread virgo_vo::function_1f6c509486d76288();
    activity_instance thread function_21882b4d08a9280f();
    level utility::flag_wait( "flag_virgo_freeway_intro_done" );
    activity_instance waypoint_objective_handler::waypoint_objective_handler_cancel( level.objective_waypoint );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "heavy_1s" );
    }
    
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "medium" );
    level thread utility::kill_exploder( "fx_freeway_intro" );
    story_contract_util::mark_complete( level.players, #"virgo_launch" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0xfa87fe92, Offset: 0x899
// Size: 0x37f
function function_21882b4d08a9280f()
{
    activity_instance = self;
    
    /#
        if ( getdvarint( @"hash_e9ddfc4a4eeb6eb2", 0 ) )
        {
            scene_struct = utility::getstruct( "<dev string:x24>", "<dev string:x38>" );
            
            if ( isdefined( scene_struct ) )
            {
                scene_struct thread scene::pre_stream( [ level.players[ 0 ] ], undefined, -1 );
                wait 5;
                scene_struct scene::play( [ level.players[ 0 ] ] );
            }
        }
        
        if ( getdvarint( @"hash_13c49d347969cc35", 0 ) )
        {
            var_124f5bb3fc36fc15 = utility::getstruct( "<dev string:x43>", "<dev string:x38>" );
            
            if ( isdefined( var_124f5bb3fc36fc15 ) )
            {
                var_124f5bb3fc36fc15 thread ob_virgo_util::function_29164af2d4d89658();
                var_124f5bb3fc36fc15 thread scene::pre_stream( [ level.players[ 0 ] ], undefined, -1 );
                wait 5;
                var_124f5bb3fc36fc15 scene::play( [ level.players[ 0 ] ] );
            }
        }
    #/
    
    level utility::flag_set( "flag_intro_igc_done" );
    namespace_78b1c18caf50ee83::function_d41002779543c80e();
    level thread function_3355f9bd48ae9ff4();
    level thread function_6424a88156901f02();
    level thread function_460eae228b3813f3();
    level thread function_fdc40965ffe7e8f2();
    level utility::flag_wait( "flag_spawn_bo2_hover_jet" );
    assets = [];
    distances = [];
    assets[ assets.size ] = "sat_wc_cradle_warp_01_vfx";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "sat_wc_cradle_warp_02_vfx";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "sat_wc_cradle_warp_02a_vfx";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "sat_wc_cradle_warp_02b_vfx";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "sat_wc_cradle_warp_02c_vfx";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "sat_wc_cradle_warp_03_vfx";
    distances[ distances.size ] = 128;
    
    foreach ( player in level.players )
    {
        player thread utility::player_prestream_assets( "virgo_freeway_intro", "model", assets, distances, -1 );
    }
    
    scene_samuels_intro_echo = utility::getstruct( "scene_samuels_intro_echo", "targetname" );
    scene_samuels_intro_echo thread ob_virgo_util::function_29164af2d4d89658();
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_spawn_memory_jump_01", "flag_spawn_memory_jump_01" );
    level utility::flag_wait( "flag_spawn_memory_jump_01" );
    level utility::flag_set( "intro_samuels_pres_vo" );
    level thread function_2e0b21a528532f51();
    scene_samuels_intro_echo thread scene::play( undefined, "Echo" );
    var_6dcd6d1e9b245b9d = scene_samuels_intro_echo scene::function_b3c7b792a7a154fa( 0 );
    level thread ob_virgo_util::function_f8c90a6db244c560( scene_samuels_intro_echo, "Echo_Samuels" );
    wait var_6dcd6d1e9b245b9d;
    level thread function_3ab6bc1e8d597385();
    level ob_virgo_util::echo_fragment_transition( activity_instance, "OB_VIRGO_FREEWAY_INVERTED", "int_memory_jump_01", "flag_virgo_memory_jump_01_done", "flag_intro_to_inverted_bink_done", 0, 256 );
    level utility::flag_set( "flag_virgo_freeway_intro_done" );
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "medium" );
    
    foreach ( player in level.players )
    {
        player utility::player_prestream_clear( "virgo_freeway_intro" );
    }
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0xc1bf2f25, Offset: 0xc20
// Size: 0xa4
function display_teleport_hint()
{
    level utility::flag_wait( "flag_spawn_bo2_civs_flee" );
    hint_line = &"sat_ob_story_missions/virgo_flicker_hint";
    
    foreach ( player in level.players )
    {
        player thread hints::hint_add_simple( "teleport_hint", hint_line, 4 );
    }
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0xf56fe405, Offset: 0xccc
// Size: 0x8b
function function_3ab6bc1e8d597385()
{
    level utility::flag_wait( "int_memory_jump_01" );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "heavy_3s" );
    }
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0xa5c185c8, Offset: 0xd5f
// Size: 0xd8
function function_2e0b21a528532f51()
{
    wait 2;
    bm_cradle_portal_clip_01 = getent( "bm_cradle_portal_clip_01", "targetname" );
    bm_cradle_portal_clip_01 show();
    activateworldevent( "lgt_portal_1" );
    level utility::exploder( "fx_warp_01" );
    bm_cradle_portal_clip_01 virgo_audio::inverted_portal_open( "flag_intro_to_inverted_bink_done" );
    wait 1.8;
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light" );
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0xf4d8d641, Offset: 0xe3f
// Size: 0x52
function function_fdc40965ffe7e8f2()
{
    scene_intro_bo2_truck_jump = utility::getstruct( "scene_intro_bo2_truck_jump", "targetname" );
    scene_intro_bo2_truck_jump thread ob_virgo_util::function_29164af2d4d89658();
    scene_intro_bo2_truck_jump thread scene::play( undefined, "loop" );
    level utility::flag_wait( "flag_spawn_bo2_hover_jet" );
    scene_intro_bo2_truck_jump thread scene::play( undefined, "enter" );
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0xa6f3749b, Offset: 0xe99
// Size: 0xf1
function function_460eae228b3813f3()
{
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_spawn_bo2_hover_jet", "flag_spawn_bo2_hover_jet" );
    level utility::flag_wait( "flag_spawn_bo2_hover_jet" );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light" );
    scene_intro_bo2_jet_hover = utility::getstruct( "scene_intro_bo2_jet_hover", "targetname" );
    scene_intro_bo2_jet_hover thread ob_virgo_util::function_29164af2d4d89658();
    scene_intro_bo2_jet_hover thread virgo_audio::function_45d0930e6846da7e( "hover_jet" );
    scene_intro_bo2_jet_hover scene::play();
    level utility::flag_set( "flag_hover_jet_scene_complete" );
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0xf94ae9c8, Offset: 0xf92
// Size: 0xd0
function function_3355f9bd48ae9ff4()
{
    scene_intro_bo2_crashsite_crawl = utility::getstruct( "scene_intro_bo2_crashsite_crawl", "targetname" );
    scene_intro_bo2_crashsite_crawl thread scene::play( undefined, "Init" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_spawn_bo2_civs_flee_01", "flag_spawn_bo2_civs_flee_01" );
    level utility::flag_wait( "flag_spawn_bo2_civs_flee_01" );
    overlord::function_e155a19c69aed191( level.players );
    level utility::flag_set( "flag_play_civs_fleeing_vo" );
    scene_intro_bo2_civs_flee = utility::getstruct( "scene_intro_bo2_civs_flee", "targetname" );
    scene_intro_bo2_civs_flee thread scene::play( undefined, "Location1" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_spawn_bo2_crawlout", "flag_spawn_bo2_crawlout" );
    level utility::flag_wait( "flag_spawn_bo2_crawlout" );
    scene_intro_bo2_crashsite_crawl thread ob_virgo_util::function_29164af2d4d89658();
    scene_intro_bo2_crashsite_crawl scene::play();
    level utility::flag_set( "flag_crawl_out_complete" );
}

// Namespace namespace_5eb68bf3d7c068d3
// Params 0
// Checksum 0xe69bb1af, Offset: 0x106a
// Size: 0x4c
function function_6424a88156901f02()
{
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_spawn_bo2_civs_flee", "flag_spawn_bo2_civs_flee" );
    level utility::flag_wait( "flag_spawn_bo2_civs_flee" );
    scene_intro_bo2_civs_flee = utility::getstruct( "scene_intro_bo2_civs_flee", "targetname" );
    scene_intro_bo2_civs_flee thread scene::play( undefined, "Location2" );
}

