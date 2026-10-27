// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_tunnels_prison.gsc  (hash_04d274cc4ff5bdb5.gscc) (size: 39709 Bytes / 0x9b1d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a513758 (2589013848)
// size ...... 39709 (0x9b1d)
// includes .. 21  (offset: 0x8e95)
// strings ... 173 (offset: 0x8f3d)
// dev strs .. 24  (offset: 0x99f9)
// exports ... 76  (offset: 0x6345)
// cseg ...... 0x177d + 0x4bc8 (0x6345)
// imports ... 248 (offset: 0x6f25)
// animtree1 . 0   (offset: 0x9b1d)
// animtree2 . 0   (offset: 0x9b1d)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\ai\stealth\enemy;
#using scripts\common\ai\stealth\utility;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\common\equipment\decoy_grenade;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;

#namespace namespace_82ef26b728b2fd29;

/#

    // Namespace namespace_82ef26b728b2fd29
    // Params 0
    // Checksum 0xec8bf277, Offset: 0x179b
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x5
// Checksum 0xac15ec9, Offset: 0x17a8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3556b3b99366a3b", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x4
// Checksum 0x3fdfe565, Offset: 0x17d1
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_TUNNELS_PRISON";
    activity_common::registeractivitytype( "OB_GEMINI_TUNNELS_PRISON", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_PRISON", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_PRISON", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_PRISON", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_TUNNELS_PRISON" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xcdc0491e, Offset: 0x1848
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance tunnels_prison_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x5d87d47e, Offset: 0x18a9
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance tunnels_prison_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x71bc6988, Offset: 0x18ea
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 1
// Checksum 0x3f7a478, Offset: 0x190e
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread tunnels_prison_player_setup( player );
    }
}

/#

    // Namespace namespace_82ef26b728b2fd29
    // Params 0
    // Checksum 0xab315667, Offset: 0x19ca
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xbf930b3b, Offset: 0x19d7
// Size: 0x2d
function tunnels_prison_start()
{
    ob_story_mission_utils::function_6314f03dfe2adbc5();
    level thread gemini_util::gemini_hide_minimap();
    level thread ob_story_mission_utils::objective_marker_clear_all();
    level thread gemini_util::function_85abe3355f8a3cce();
    setomnvar( "ui_hide_player_icons", 1 );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x484bae60, Offset: 0x1a0c
// Size: 0x36
function tunnels_prison_init()
{
    if ( level utility::flag( "flag_tunnels_prison_init" ) )
    {
        return;
    }
    
    level thread gemini_util::function_85abe3355f8a3cce();
    function_8172c74beae5912c();
    level thread gemini_util::trigger_stealth_shadow_setup();
    level utility::flag_set( "flag_tunnels_prison_init" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 1
// Checksum 0xebb2203b, Offset: 0x1a4a
// Size: 0x90
function tunnels_prison_player_setup( player )
{
    activity_instance = self;
    player sethidenameplate( 1 );
    player thread function_5abcb33daadc2e59( activity_instance );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player thread gemini_util::function_22bc129d80ed2fc7( 2 );
        player thread gemini_util::player_cold_breath_toggle( "flag_tunnels_pit_complete" );
        wait 0.1;
        player armor::function_b359444c252374fc( 0 );
        player thread gemini_util::function_87124b79a77abfe2( "flag_tunnels_prison_complete" );
        player thread function_e4f46cd7e6fd5f6d();
        
        /#
            player thread function_4a30bf2095cfad52();
        #/
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xde4f6cb2, Offset: 0x1ae2
// Size: 0x3ad
function tunnels_prison_main()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level thread tunnels_prison_init();
    waitframe();
    
    /#
        activity_instance thread gemini_util::function_d6c199899ef5b468( "<dev string:x24>", "<dev string:x3d>", "<dev string:x5a>" );
    #/
    
    waitframe();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_tunnels_prison_weapon", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_tunnels_prison_equipment", undefined, 1 );
    level thread function_cf5097243a97cde9( "tunnels_prison_radio_hilo_office", "flag_tunnels_anteroom_doors_locked" );
    level thread function_cf5097243a97cde9( "tunnels_prison_radio_cellblock_office", "flag_tunnels_anteroom_doors_locked" );
    level thread shower_valve_setup( "tunnels_prison_shower_valve_cellblock", "flag_tunnels_anteroom_doors_locked" );
    
    if ( !isdefined( level.a_players_yel ) || !isdefined( level.a_players_grn ) )
    {
        level.a_players_yel = [];
        level.a_players_grn = [];
    }
    
    activity_instance thread function_f47948610c3415cf( "trig_tunnels_prison_yel_spawn", "yel" );
    activity_instance thread function_f47948610c3415cf( "trig_tunnels_prison_grn_spawn", "grn" );
    waitframe();
    activity_instance thread tunnels_prison_hallway_screen_setup();
    activity_instance childthread gemini_vo::function_44f91cd311bcd45e();
    activity_instance thread function_771375e4f6523cca();
    activity_instance thread function_e70824f60677942b();
    level thread function_e48beaf2f9486f1a();
    thread gemini_util::function_bad374b9f21345b( "e_tunnels_prison_stairwell_office_gate", "flag_tunnels_prison_stairwell_office_gate_open", "flag_tunnels_prison_stairwell_office_gate_interact", "flag_tunnels_anteroom_doors_locked" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_monitors_grn", "flag_trig_tunnels_prison_monitors_yel" );
    level utility::flag_set( "flag_tunnels_prison_monitors" );
    level gemini_util::function_401a0ddccdf00715( "tunnels_prison_screen_bunkhouse_grn" );
    activity_instance thread function_81c7523742e60858( "enc_vol_tunnels_prison_hilo_zombie_grn", "zombie_low", "flag_trig_tunnels_prison_monitors_grn", "flag_tunnels_prison_cellblock_b_begin", "flag_trig_tunnels_prison_cellblock_b_midpoint_grn", "flag_tunnels_prison_cellblock_c_begin" );
    waitframe();
    activity_instance thread function_81c7523742e60858( "enc_vol_tunnels_prison_hilo_zombie_yel", "zombie_high", "flag_trig_tunnels_prison_monitors_yel", "flag_tunnels_prison_cellblock_b_begin", "flag_trig_tunnels_prison_cellblock_b_midpoint_yel", "flag_tunnels_prison_cellblock_c_begin" );
    activity_instance thread function_72a58d3cf57fa0d4( "scene_tunnels_prison_hilo_headbang_zmb", "flag_tunnels_prison_cellblock_a_complete" );
    activity_instance thread gemini_util::function_b2e3b9ccdce5ec87( "scene_tunnels_prison_hilo_zmb", undefined, undefined, undefined, "flag_tunnels_prison_cellblock_a_complete" );
    activity_instance thread function_f3b17a55a6f2c8d4();
    activity_instance thread function_c7c2f582a308c1a();
    activity_instance thread function_c6dbb7f7f516badd();
    level utility::flag_wait( "flag_tunnels_prison_cellblock_a_begin" );
    activity_instance thread function_81c7523742e60858( "enc_vol_tunnels_prison_cellblock_a_zombie_yel", "zombie_low", "flag_trig_tunnels_prison_cellblock_a_begin_yel", "flag_tunnels_prison_cellblock_c_midpoint", "flag_trig_tunnels_prison_cellblock_c_complete_yel", "flag_tunnels_prison_transition_begin" );
    waitframe();
    activity_instance thread function_81c7523742e60858( "enc_vol_tunnels_prison_cellblock_a_zombie_grn", "zombie_high", "flag_trig_tunnels_prison_cellblock_a_begin_grn", "flag_tunnels_prison_cellblock_c_midpoint", "flag_trig_tunnels_prison_cellblock_c_complete_grn", "flag_tunnels_prison_transition_begin" );
    activity_instance thread gemini_util::function_bad374b9f21345b( "e_tunnels_prison_cellblock_armory_gate", "flag_tunnels_prison_cellblock_armory_gate_open", "flag_tunnels_prison_cellblock_armory_gate_interact", "flag_tunnels_anteroom_doors_locked" );
    activity_instance thread function_1c69072ac9eeed84();
    level utility::flag_wait( "flag_tunnels_prison_cellblock_b_begin" );
    activity_instance thread function_d60046f76eb96ef3();
    activity_instance thread function_81c7523742e60858( "enc_vol_tunnels_prison_cellblock_b_zombie_yel", "zombie_low", "flag_trig_tunnels_prison_cellblock_b_begin_yel", "flag_tunnels_prison_transition_begin", "flag_trig_tunnels_prison_transition_midpoint_yel", "flag_tunnels_prison_transition_complete" );
    waitframe();
    activity_instance thread function_81c7523742e60858( "enc_vol_tunnels_prison_cellblock_b_zombie_grn", "zombie_high", "flag_trig_tunnels_prison_cellblock_b_begin_grn", "flag_tunnels_prison_transition_begin", "flag_trig_tunnels_prison_transition_midpoint_grn", "flag_tunnels_prison_transition_complete" );
    activity_instance thread function_6e60e6f0f96fd65b();
    level utility::flag_wait( "flag_tunnels_prison_cellblock_c_begin" );
    activity_instance thread function_81c7523742e60858( "enc_vol_tunnels_prison_cellblock_c_zombie_yel", "zombie_low", "flag_trig_tunnels_prison_cellblock_c_begin_yel", "flag_tunnels_prison_transition_midpoint", "flag_trig_tunnels_prison_transition_complete_yel", "flag_tunnels_anteroom_doors_locked" );
    waitframe();
    activity_instance thread function_81c7523742e60858( "enc_vol_tunnels_prison_cellblock_c_zombie_grn", "zombie_high", "flag_trig_tunnels_prison_cellblock_c_begin_grn", "flag_tunnels_prison_transition_midpoint", "flag_trig_tunnels_prison_transition_complete_grn", "flag_tunnels_anteroom_doors_locked" );
    activity_instance thread function_cd9b5758610e2ebb();
    level utility::flag_wait( "flag_tunnels_prison_transition_midpoint" );
    activity_instance thread gemini_util::function_b04c2801b2760aff( "s_tunnels_anteroom_mason_ghost_01", "flag_tunnels_anteroom_complete" );
    level utility::flag_wait( "flag_tunnels_prison_transition_complete" );
    activity_instance thread function_d66dea4b9ec8cda9();
    level utility::flag_set( "flag_tunnels_prison_complete" );
    activity_instance gemini_util::function_97b700689f1e4cbd();
}

/#

    // Namespace namespace_82ef26b728b2fd29
    // Params 0
    // Checksum 0xf38cef16, Offset: 0x1e97
    // Size: 0x5, Type: dev
    function function_70f1d65a8bdb0e0b()
    {
        
    }

#/

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xf0edde3a, Offset: 0x1ea4
// Size: 0x16b
function function_f3b17a55a6f2c8d4()
{
    level endon( #"game_ended" );
    activity_instance = self;
    var_704f37bf85217934 = utility::getstructarray( "scene_tunnels_prison_hilo_zmb", "targetname" );
    level utility::flag_wait( "flag_tunnels_prison_hilo_complete" );
    
    if ( var_704f37bf85217934.size > 0 )
    {
        foreach ( s_scene in var_704f37bf85217934 )
        {
            if ( s_scene.script_scenescriptbundle == "sat_cin_ob_gemini_zombie_multi_eating_corpse" || s_scene.script_scenescriptbundle == "sat_cin_ob_gemini_zombie_banging_head_01" )
            {
                activity_instance thread _scene_force_cleanup_monitor( s_scene );
                var_704f37bf85217934 = arrayremove( var_704f37bf85217934, s_scene );
            }
        }
    }
    
    level utility::flag_wait( "flag_tunnels_prison_cellblock_a_begin" );
    
    if ( var_704f37bf85217934.size > 0 )
    {
        foreach ( s_scene in var_704f37bf85217934 )
        {
            activity_instance thread _scene_force_cleanup_monitor( s_scene );
        }
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 1, eflags: 0x4
// Checksum 0xa649ce47, Offset: 0x2017
// Size: 0xc4
function private _scene_force_cleanup_monitor( s_scene )
{
    level endon( #"game_ended" );
    
    if ( level.is_squad_size_small && level.players.size == 1 )
    {
        s_scene notify( #"scene_force_cleanup" );
        return;
    }
    
    fov = cos( 45 );
    
    while ( !utility::flag( "flag_tunnels_anteroom_doors_locked" ) )
    {
        a_players = getplayersinradius( s_scene.origin, 512 );
        
        if ( a_players.size == 0 )
        {
            b_within_fov = gemini_util::within_fov_of_players( s_scene.origin, fov );
            
            if ( !b_within_fov )
            {
                break;
            }
        }
        
        wait 1;
    }
    
    s_scene notify( #"scene_force_cleanup" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x625b3f0e, Offset: 0x20e3
// Size: 0x78
function function_c7c2f582a308c1a()
{
    level endon( #"game_ended" );
    activity_instance = self;
    level utility::flag_wait_any( "flag_trig_tunnels_prison_hilo_begin_grn", "flag_trig_tunnels_prison_hilo_begin_yel" );
    level utility::flag_set( "flag_tunnels_prison_hilo_begin" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_hilo_midpoint_grn", "flag_trig_tunnels_prison_hilo_midpoint_yel" );
    level utility::flag_set( "flag_tunnels_prison_hilo_midpoint" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_hilo_complete_grn", "flag_trig_tunnels_prison_hilo_complete_yel" );
    level utility::flag_set( "flag_tunnels_prison_hilo_complete" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x6841687, Offset: 0x2163
// Size: 0x78
function function_c6dbb7f7f516badd()
{
    level endon( #"game_ended" );
    activity_instance = self;
    level utility::flag_wait_any( "flag_trig_tunnels_prison_cellblock_a_begin_grn", "flag_trig_tunnels_prison_cellblock_a_begin_yel" );
    level utility::flag_set( "flag_tunnels_prison_cellblock_a_begin" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_cellblock_a_midpoint_grn", "flag_trig_tunnels_prison_cellblock_a_midpoint_yel" );
    level utility::flag_set( "flag_tunnels_prison_cellblock_a_midpoint" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_cellblock_a_complete_grn", "flag_trig_tunnels_prison_cellblock_a_complete_yel" );
    level utility::flag_set( "flag_tunnels_prison_cellblock_a_complete" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x64f6579e, Offset: 0x21e3
// Size: 0x78
function function_1c69072ac9eeed84()
{
    level endon( #"game_ended" );
    activity_instance = self;
    level utility::flag_wait_any( "flag_trig_tunnels_prison_cellblock_b_begin_grn", "flag_trig_tunnels_prison_cellblock_b_begin_yel" );
    level utility::flag_set( "flag_tunnels_prison_cellblock_b_begin" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_cellblock_b_midpoint_grn", "flag_trig_tunnels_prison_cellblock_b_midpoint_yel" );
    level utility::flag_set( "flag_tunnels_prison_cellblock_b_midpoint" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_cellblock_b_complete_grn", "flag_trig_tunnels_prison_cellblock_b_complete_yel" );
    level utility::flag_set( "flag_tunnels_prison_cellblock_b_complete" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x45279769, Offset: 0x2263
// Size: 0x78
function function_6e60e6f0f96fd65b()
{
    level endon( #"game_ended" );
    activity_instance = self;
    level utility::flag_wait_any( "flag_trig_tunnels_prison_cellblock_c_begin_grn", "flag_trig_tunnels_prison_cellblock_c_begin_yel" );
    level utility::flag_set( "flag_tunnels_prison_cellblock_c_begin" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_cellblock_c_midpoint_grn", "flag_trig_tunnels_prison_cellblock_c_midpoint_yel" );
    level utility::flag_set( "flag_tunnels_prison_cellblock_c_midpoint" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_cellblock_c_complete_grn", "flag_trig_tunnels_prison_cellblock_c_complete_yel" );
    level utility::flag_set( "flag_tunnels_prison_cellblock_c_complete" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x3c14641c, Offset: 0x22e3
// Size: 0x78
function function_cd9b5758610e2ebb()
{
    level endon( #"game_ended" );
    activity_instance = self;
    level utility::flag_wait_any( "flag_trig_tunnels_prison_transition_begin_grn", "flag_trig_tunnels_prison_transition_begin_yel" );
    level utility::flag_set( "flag_tunnels_prison_transition_begin" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_transition_midpoint_grn", "flag_trig_tunnels_prison_transition_midpoint_yel" );
    level utility::flag_set( "flag_tunnels_prison_transition_midpoint" );
    level utility::flag_wait_any( "flag_trig_tunnels_prison_transition_complete_grn", "flag_trig_tunnels_prison_transition_complete_yel" );
    level utility::flag_set( "flag_tunnels_prison_transition_complete" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 2
// Checksum 0x798b797a, Offset: 0x2363
// Size: 0x165
function function_f47948610c3415cf( trig_targetname, str_wing )
{
    level endon( #"game_ended", #"flag_tunnels_prison_complete" );
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( level utility::flag( "flag_tunnels_prison_complete" ) )
    {
        return;
    }
    
    a_trig_ent = getentarray( trig_targetname, #targetname );
    a_trig_noent = getnoentvolumearray( trig_targetname, #targetname );
    var_5cba3aa7cba1a93c = arraycombine( a_trig_ent, a_trig_noent );
    
    if ( var_5cba3aa7cba1a93c.size == 0 )
    {
        return;
    }
    
    var_f8178163be04ed2 = spawnstruct();
    trig = var_5cba3aa7cba1a93c[ 0 ];
    trig childthread gemini_util::function_86f26ea0ba29b10( var_f8178163be04ed2 );
    
    while ( true )
    {
        var_f8178163be04ed2 waittill( #"player_trigger", player );
        
        if ( isdefined( player ) )
        {
            if ( !player utility::ent_flag_exist( "flag_trig_tunnels_solitary_" + str_wing + "_spawn" ) )
            {
                player utility::ent_flag_set( "flag_trig_tunnels_solitary_" + str_wing + "_spawn" );
            }
            
            if ( str_wing == "yel" )
            {
                level.a_players_yel = arraycombineunique( level.a_players_yel, [ player ] );
            }
            else
            {
                level.a_players_grn = arraycombineunique( level.a_players_grn, [ player ] );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 2
// Checksum 0x3ac8c6fb, Offset: 0x24d0
// Size: 0xdd
function function_72a58d3cf57fa0d4( struct_targetname, var_b60496d5b429ae0f )
{
    level endon( #"game_ended" );
    activity_instance = self;
    var_704f37bf85217934 = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( var_704f37bf85217934.size == 0 )
    {
        return;
    }
    
    foreach ( s_scene in var_704f37bf85217934 )
    {
        s_scene thread scene::play();
        s_scene thread gemini_util::function_1f3f685c332568e2( "Prop 1" );
        
        if ( isdefined( var_b60496d5b429ae0f ) )
        {
            s_scene thread gemini_util::scene_zombie_cleanup( var_b60496d5b429ae0f );
        }
        
        waitframe();
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x89220718, Offset: 0x25b5
// Size: 0xc1
function tunnels_prison_hallway_screen_setup()
{
    level endon( #"game_ended" );
    activity_instance = self;
    
    if ( level utility::flag( "flag_tunnels_prison_hallway_screen_setup" ) )
    {
        return;
    }
    
    level utility::flag_set( "flag_tunnels_prison_hallway_screen_setup" );
    level gemini_util::function_401a0ddccdf00715( "tunnels_prison_screen_01_yel" );
    level gemini_util::function_401a0ddccdf00715( "tunnels_prison_screen_01_grn" );
    waitframe();
    activity_instance thread gemini_util::function_216caa29c9603d8e( "trig_tunnels_prison_screen_01_yel", "sat_gemini_monitor_alex_1", "bink1", 0, "tunnels_prison_screen_01_yel", "flag_tunnels_prison_screen_01_yel_start", "flag_tunnels_prison_screen_01_yel_end", "flag_tunnels_prison_screen_01_yel_stop", "OB_GEMINI_TUNNELS_PRISON", "OB_GEMINI_TUNNELS_PRISON_TWISTED_RETURN" );
    activity_instance thread gemini_util::function_216caa29c9603d8e( "trig_tunnels_prison_screen_01_grn", "sat_gemini_monitor_alex_1", "bink1", 0, "tunnels_prison_screen_01_grn", "flag_tunnels_prison_screen_01_grn_start", "flag_tunnels_prison_screen_01_grn_end", "flag_tunnels_prison_screen_01_grn_stop", "OB_GEMINI_TUNNELS_PRISON", "OB_GEMINI_TUNNELS_PRISON_TWISTED_RETURN" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xd0bf7740, Offset: 0x267e
// Size: 0x136
function function_d60046f76eb96ef3()
{
    level endon( #"game_ended" );
    activity_instance = self;
    level gemini_util::function_401a0ddccdf00715( "tunnels_prison_screen_cafeteria_yel_01" );
    level gemini_util::function_401a0ddccdf00715( "tunnels_prison_screen_cafeteria_yel_02" );
    level gemini_util::function_401a0ddccdf00715( "tunnels_prison_screen_cafeteria_yel_03" );
    level gemini_util::function_401a0ddccdf00715( "tunnels_prison_screen_cafeteria_grn_01" );
    level gemini_util::function_401a0ddccdf00715( "tunnels_prison_screen_cafeteria_grn_02" );
    waitframe();
    activity_instance thread gemini_util::function_60475284edbb43a8( 7.5, "sat_gemini_monitor_alex_1", "bink1", 0, "tunnels_prison_screen_cafeteria_yel_01", "flag_tunnels_prison_cellblock_b_alex_taunt_yel", "OB_GEMINI_TUNNELS_PRISON", "OB_GEMINI_TUNNELS_PRISON_TWISTED_ORDERS" );
    activity_instance thread gemini_util::function_60475284edbb43a8( 7.5, "sat_gemini_monitor_alex_1", "bink1", 0, "tunnels_prison_screen_cafeteria_grn_01", "flag_tunnels_prison_cellblock_b_alex_taunt_grn", "OB_GEMINI_TUNNELS_PRISON", "OB_GEMINI_TUNNELS_PRISON_TWISTED_ORDERS" );
    level gemini_util::function_401a0ddccdf00715( "tunnels_prison_screen_cafeteria_yel_02" );
    level gemini_util::function_401a0ddccdf00715( "tunnels_prison_screen_cafeteria_grn_02" );
    waitframe();
    activity_instance thread gemini_util::function_60475284edbb43a8( 6, "sat_gemini_monitor_alex_1", "bink1", 0, "tunnels_prison_screen_cafeteria_yel_03", "flag_trig_tunnels_prison_cellblock_c_alex_taunt_yel", "OB_GEMINI_TUNNELS_PRISON", "OB_GEMINI_TUNNELS_PRISON_TWISTED_ACCEPT", "flag_trig_tunnels_prison_transition_midpoint_yel" );
    activity_instance thread gemini_util::function_60475284edbb43a8( 6, "sat_gemini_monitor_alex_1", "bink1", 0, "tunnels_prison_screen_cafeteria_grn_02", "flag_trig_tunnels_prison_cellblock_c_alex_taunt_grn", "OB_GEMINI_TUNNELS_PRISON", "OB_GEMINI_TUNNELS_PRISON_TWISTED_ACCEPT", "flag_trig_tunnels_prison_transition_midpoint_grn" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xe2b691d2, Offset: 0x27bc
// Size: 0x11d
function function_e70824f60677942b()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    a_doors = gemini_util::get_scriptable_array( "door_tunnels_prison_bathroom" );
    
    if ( a_doors.size == 0 )
    {
        return;
    }
    
    var_f7555be24ed5dc3b = randomintrange( 1, 3 );
    n_locked_doors = randomintrange( 0, 2 );
    a_doors = arrayrandomize( a_doors );
    
    for ( i = 0; i < a_doors.size ; i++ )
    {
        door = a_doors[ i ];
        
        if ( var_f7555be24ed5dc3b > 0 && utility::cointoss() )
        {
            away_org = door.origin + anglestoleft( door.angles ) * 64;
            door gemini_util::function_c961de572d334f4a( "away", utility::cointoss(), away_org );
            var_f7555be24ed5dc3b -= 1;
        }
        else if ( door.script_noteworthy != "door_always_unlocked" && n_locked_doors > 0 && utility::cointoss() )
        {
            door gemini_util::scriptable_door_lock();
            n_locked_doors -= 1;
        }
        
        waitframe();
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x78069333, Offset: 0x28e1
// Size: 0xc0
function function_1e4f6480f034a4c3()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    a_doors = gemini_util::get_scriptable_array( "security_door_cellblock_exit" );
    var_227b6976122d0b6f = gemini_util::get_scriptable_array( "security_door_cellblock_trans_02" );
    a_doors = arraycombineunique( a_doors, var_227b6976122d0b6f );
    utility::array_thread( a_doors, &function_cc6d4878bd57fc39, var_227b6976122d0b6f );
    level utility::flag_wait( "flag_tunnels_prison_complete" );
    var_2c96e1d642c52563 = getnoentvolumearray( "trig_tunnels_prison_player_check", #script_noteworthy );
    
    while ( true )
    {
        var_fb1aa1bedd227974 = gemini_util::function_e28ab256acac0688( var_2c96e1d642c52563, 0 );
        
        if ( !var_fb1aa1bedd227974 )
        {
            break;
        }
        
        wait 1;
    }
    
    level utility::flag_set( "flag_tunnels_prison_cellblock_close_doors" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 1, eflags: 0x4
// Checksum 0x97f57a17, Offset: 0x29a9
// Size: 0xa7
function private function_cc6d4878bd57fc39( var_227b6976122d0b6f )
{
    if ( !arraycontains( var_227b6976122d0b6f, self ) )
    {
        var_e5219d2ee296bbb0 = utility::getstruct( self.target, "targetname" );
        
        if ( isdefined( var_e5219d2ee296bbb0 ) )
        {
            self scriptabledooropen( "away", var_e5219d2ee296bbb0.origin );
        }
        else
        {
            self scriptabledooropen();
        }
        
        wait 10;
        self scriptabledoorfreeze();
    }
    
    level utility::flag_wait( "flag_tunnels_prison_cellblock_close_doors" );
    
    if ( !self scriptabledoorisclosed() )
    {
        self scriptabledoorclose();
        waitframe();
        
        while ( true )
        {
            if ( self scriptabledoorisclosed() )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    waitframe();
    self scriptabledoorlock();
    waitframe();
    self scriptabledoorfreeze();
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xb2157430, Offset: 0x2a58
// Size: 0x171
function function_e48beaf2f9486f1a()
{
    level endon( #"game_ended" );
    level endon( #"flag_tunnels_anteroom_complete" );
    var_37cd24e5ea069a9 = getnoentvolumearray( "trig_tunnels_anteroom_entrance", #targetname )[ 0 ];
    
    if ( !var_37cd24e5ea069a9 )
    {
        return;
    }
    
    var_37cd24e5ea069a9 waittill( #"trigger", player );
    level thread gemini_vo::function_1eee999d337c6282();
    
    if ( level.players.size < 2 )
    {
        level.var_d552cd536f03e258 = [ player ];
        level utility::flag_set( "flag_tunnels_anteroom_regroup_complete" );
        return;
    }
    
    struct = spawnstruct();
    struct.var_5d1ee9c337aef6d7 = 0;
    
    if ( !isdefined( level.var_d552cd536f03e258 ) )
    {
        level.var_d552cd536f03e258 = [];
    }
    
    foreach ( player in level.players )
    {
        player thread function_47153559f5f68a49( struct );
    }
    
    while ( struct.var_5d1ee9c337aef6d7 < level.players.size )
    {
        if ( level utility::flag( "flag_tunnels_anteroom_doors_locked" ) )
        {
            break;
        }
        
        wait 0.5;
    }
    
    level utility::flag_set( "flag_tunnels_anteroom_regroup_complete" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 1
// Checksum 0x85c81365, Offset: 0x2bd1
// Size: 0x70
function function_47153559f5f68a49( struct )
{
    level endon( #"flag_tunnels_anteroom_regroup_complete" );
    level endon( #"game_ended" );
    player = self;
    player utility::ent_flag_wait( "flag_ent_tunnels_anteroom_player_entered" );
    waitframe();
    
    /#
        iprintln( "<dev string:x74>" );
    #/
    
    level.var_d552cd536f03e258[ level.var_d552cd536f03e258.size ] = player;
    struct.var_5d1ee9c337aef6d7++;
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xda16de8e, Offset: 0x2c49
// Size: 0x11d
function function_771375e4f6523cca()
{
    level endon( #"game_ended" );
    var_cb93bceb2124e020 = getentarray( "e_anteroom_entrance_door_clip", #targetname );
    
    if ( var_cb93bceb2124e020.size == 0 )
    {
        return;
    }
    
    foreach ( var_aa51443487c71c68 in var_cb93bceb2124e020 )
    {
        var_aa51443487c71c68 disconnectpaths();
    }
    
    level utility::flag_wait( "flag_tunnels_prison_complete" );
    
    foreach ( var_aa51443487c71c68 in var_cb93bceb2124e020 )
    {
        var_aa51443487c71c68 connectpaths();
        var_aa51443487c71c68 delete();
    }
}

/#

    // Namespace namespace_82ef26b728b2fd29
    // Params 0
    // Checksum 0xc8932b8, Offset: 0x2d6e
    // Size: 0x5, Type: dev
    function function_1a28d8af09bb6df1()
    {
        
    }

#/

// Namespace namespace_82ef26b728b2fd29
// Params 1
// Checksum 0x859e5948, Offset: 0x2d7b
// Size: 0xe7
function function_5abcb33daadc2e59( activity_instance )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    activity_instance namespace_b451b5202140ccde::function_dac15947c2d451e9( [ self ] );
    waitframe();
    activity_instance namespace_b451b5202140ccde::function_d3aa02fc5d62637d( "OB_GEMINI_TUNNELS_PRISON", [ self ] );
    trig_yel = getnoentvolumearray( "trig_tunnels_solitary_checkpoint_yel_complete", #targetname )[ 0 ];
    trig_grn = getnoentvolumearray( "trig_tunnels_solitary_checkpoint_grn_complete", #targetname )[ 0 ];
    str_wing = undefined;
    
    while ( !isdefined( str_wing ) )
    {
        if ( self istouching( trig_yel ) )
        {
            str_wing = "yel";
            break;
        }
        else if ( self istouching( trig_grn ) )
        {
            str_wing = "grn";
            break;
        }
        
        wait 1;
    }
    
    activity_instance thread gemini_vo::function_aca588d4a2bd2096( self, str_wing );
    thread gemini_util::function_a91d3ea2a794cb12( "s_obj_start_tunnels_prison_" + str_wing );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xf331df85, Offset: 0x2e6a
// Size: 0xbc
function function_4a30bf2095cfad52()
{
    level endon( #"game_ended", #"flag_tunnels_prison_complete" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon );
        bcansee = undefined;
        
        if ( isai( attacker ) )
        {
            bcansee = attacker cansee( self );
        }
        
        waitframe();
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xc00c0268, Offset: 0x2f2e
// Size: 0x43
function function_e4f46cd7e6fd5f6d()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        return;
    }
    
    function_7b857ee9d18ef1ce();
    waitframe();
    thread gemini_util::player_camera_sway_setup( 1, "flag_tunnels_prison_complete", 1 );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0xd58da039, Offset: 0x2f79
// Size: 0x138
function function_7b857ee9d18ef1ce()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    trig_yel = getnoentvolumearray( "trig_tunnels_solitary_checkpoint_yel_complete", #targetname )[ 0 ];
    trig_grn = getnoentvolumearray( "trig_tunnels_solitary_checkpoint_grn_complete", #targetname )[ 0 ];
    player_yel = undefined;
    player_grn = undefined;
    
    while ( true )
    {
        if ( self istouching( trig_yel ) )
        {
            player_yel = 1;
            break;
        }
        else if ( self istouching( trig_grn ) )
        {
            player_grn = 1;
            break;
        }
        
        wait 1;
    }
    
    var_550963bbb003c756 = ( 0, 0, 0 );
    
    if ( player_yel )
    {
        if ( getdvarint( @"hash_ccecb2781660d0fc" ) == 1 )
        {
            var_550963bbb003c756 = ( 0, 0, 4 );
        }
        else
        {
            var_550963bbb003c756 = ( 0, 0, 8 );
        }
    }
    else if ( player_grn )
    {
        if ( getdvarint( @"hash_ccecb2781660d0fc" ) == 1 )
        {
            var_550963bbb003c756 = ( 0, 0, -4 );
        }
        else
        {
            var_550963bbb003c756 = ( 0, 0, -8 );
        }
    }
    
    self.var_550963bbb003c756 = var_550963bbb003c756;
}

/#

    // Namespace namespace_82ef26b728b2fd29
    // Params 0
    // Checksum 0x1ba2eb0e, Offset: 0x30b9
    // Size: 0x5, Type: dev
    function function_8004c8cb39c40cc2()
    {
        
    }

#/

// Namespace namespace_82ef26b728b2fd29
// Params 6
// Checksum 0x41a5c691, Offset: 0x30c6
// Size: 0x26c
function function_81c7523742e60858( enc_targetname, bucket_tag, flag_reinforce, flag_cleanup_zone, flag_cleanup_path, flag_cleanup_force )
{
    activity_instance = self;
    request_id = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( enc_targetname, 0, 1, 1, 2 );
    var_9573911a6f37ae5d = spawnstruct();
    var_9573911a6f37ae5d.enc_targetname = enc_targetname;
    var_9573911a6f37ae5d.flag_cleanup_force = flag_cleanup_force;
    var_9573911a6f37ae5d.var_d53946789954d80d = flag_reinforce;
    var_9573911a6f37ae5d.var_6851b792b9766c5 = flag_cleanup_zone;
    activity_instance activity_ai_encounters::function_52d1342183200a8f( request_id, &function_9dbb32d321d0aa42, var_9573911a6f37ae5d );
    activity_instance activity_ai_encounters::function_16b0131751c4fb39( request_id, &function_831665a9e5810aa6, var_9573911a6f37ae5d );
    
    if ( level.is_squad_size_small && level.players.size == 1 )
    {
        maxcount = 35;
    }
    else
    {
        maxcount = 30;
    }
    
    aicount = getaicount();
    
    if ( aicount > maxcount )
    {
        /#
            iprintln( "<dev string:x8d>" + enc_targetname );
        #/
        
        bucket_tag += "_alt";
    }
    
    function_1a9d724a960fa19d( request_id, bucket_tag, 1 );
    activity_instance activity_ai_encounters::function_48582991402cac50( request_id, 1 );
    
    if ( activity_instance.var_9c4a0b2cae577c1b )
    {
        activity_instance.var_9c4a0b2cae577c1b[ request_id ].cleanuptype = 2;
    }
    
    activity_instance thread function_fb1ddf192b13f37c( enc_targetname, request_id, flag_cleanup_zone, flag_cleanup_path, flag_cleanup_force );
    waitframe();
    zombie = activity_instance function_8a765248cd71da02( request_id, var_9573911a6f37ae5d, enc_targetname, flag_cleanup_path, flag_cleanup_force );
    
    if ( level utility::flag( flag_cleanup_force ) || level utility::flag( "flag_tunnels_prison_complete" ) )
    {
        return;
    }
    
    if ( isdefined( zombie ) && isplayer( zombie.enemy ) )
    {
        request_id_beehive = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( enc_targetname + "_beehive", 0, 1, 1, 2 );
        
        if ( !isdefined( request_id_beehive ) )
        {
            return;
        }
        
        var_9573911a6f37ae5d.player = zombie.enemy;
        activity_instance activity_ai_encounters::function_52d1342183200a8f( request_id_beehive, &function_9dbb32d321d0aa42, var_9573911a6f37ae5d );
        function_1a9d724a960fa19d( request_id_beehive, bucket_tag + "_beehive", 1 );
        activity_instance activity_ai_encounters::function_48582991402cac50( request_id_beehive, 1 );
        
        if ( activity_instance.var_9c4a0b2cae577c1b )
        {
            activity_instance.var_9c4a0b2cae577c1b[ request_id_beehive ].cleanuptype = 2;
        }
        
        activity_instance thread function_fb1ddf192b13f37c( enc_targetname, request_id_beehive, flag_cleanup_zone, flag_cleanup_path, flag_cleanup_force, 1 );
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 5
// Checksum 0xa08b232c, Offset: 0x333a
// Size: 0x15f
function function_8a765248cd71da02( request_id, var_9573911a6f37ae5d, enc_targetname, flag_cleanup_path, flag_cleanup_force )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( flag_cleanup_path, flag_cleanup_force, #"game_ended" );
    
    while ( true )
    {
        enc_data = function_9b649316adcccbaa( request_id );
        
        if ( !isdefined( enc_data.ai ) || enc_data.ai.size == 0 )
        {
            wait 1;
            continue;
        }
        
        var_9573911a6f37ae5d waittill( #"zombie_stealth_combat", zombie );
        
        if ( !isplayer( zombie.enemy ) )
        {
            wait 1;
            continue;
        }
        
        if ( level.is_squad_size_small && level.players.size == 1 )
        {
            maxcount = 35;
        }
        else if ( !level.is_squad_size_small || level.players.size > 2 )
        {
            maxcount = 25;
        }
        else
        {
            maxcount = 30;
        }
        
        aicount = getaicount();
        
        if ( aicount > maxcount )
        {
            wait 1;
            continue;
        }
        
        /#
            iprintln( "<dev string:xa0>" + enc_targetname );
        #/
        
        return zombie;
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 6
// Checksum 0x11c923f7, Offset: 0x34a1
// Size: 0x16e
function function_fb1ddf192b13f37c( enc_targetname, request_id, flag_cleanup_zone, flag_cleanup_path, flag_cleanup_force, b_beehive = 0 )
{
    activity_instance = self;
    msg = level utility::flag_wait_any_return( flag_cleanup_zone, flag_cleanup_path, flag_cleanup_force );
    
    while ( true )
    {
        if ( b_beehive )
        {
            if ( utility::flag( flag_cleanup_force ) || level.is_squad_size_small && level.players.size == 1 )
            {
                maxcount = 25;
            }
            else
            {
                maxcount = 30;
            }
        }
        else if ( utility::flag( flag_cleanup_force ) && level.is_squad_size_small && level.players.size == 1 )
        {
            maxcount = 30;
        }
        else
        {
            maxcount = 35;
        }
        
        aicount = getaicount();
        
        if ( aicount > maxcount || utility::flag( "flag_tunnels_anteroom_doors_locked" ) )
        {
            break;
        }
        
        wait 1;
    }
    
    waitframe();
    
    if ( isdefined( self.var_9c4a0b2cae577c1b[ request_id ] ) )
    {
        /#
            if ( b_beehive )
            {
                iprintln( "<dev string:xb8>" + enc_targetname + "<dev string:xcf>" );
            }
            else
            {
                iprintln( "<dev string:xb8>" + enc_targetname );
            }
        #/
        
        if ( utility::flag( flag_cleanup_force ) )
        {
            activity_ai_encounters::function_46dadc3aca2ffac0( request_id, 1 );
            return;
        }
        
        gemini_util::cleanup_activity_encounter( request_id );
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 3
// Checksum 0xd096f525, Offset: 0x3617
// Size: 0xd4, Type: bool
function function_831665a9e5810aa6( request_id, user_data, var_62a6b384c0358219 )
{
    var_9573911a6f37ae5d = user_data;
    var_d53946789954d80d = var_9573911a6f37ae5d.var_d53946789954d80d;
    var_6851b792b9766c5 = var_9573911a6f37ae5d.var_6851b792b9766c5;
    
    if ( level.is_squad_size_small && level.players.size == 1 )
    {
        maxcount = 35;
    }
    else
    {
        maxcount = 30;
    }
    
    aicount = getaicount();
    
    if ( aicount > maxcount )
    {
        return false;
    }
    
    if ( level utility::flag( var_d53946789954d80d ) && !level utility::flag( var_6851b792b9766c5 ) )
    {
        /#
            iprintln( "<dev string:xd8>" + var_9573911a6f37ae5d.enc_targetname );
        #/
        
        return true;
    }
    
    return false;
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x458e83dc, Offset: 0x36f4
// Size: 0x85
function function_8172c74beae5912c()
{
    function_dcc61aa9f2384af0( 400 );
    stealthsettimetolosetargetatlkp( 6000 );
    stealthsettimetolosetargetnotatlkp( 3000 );
    setstealthdetectrange( "hidden", "shadow_crouch", 0.65 );
    setstealthdetectrange( "hidden", "shadow_prone", 0.35 );
    setstealthdetectrange( "hidden", "shadow_stand", 0.85 );
    setstealthdetectrange( "spotted", "shadow", 0.75 );
    level.var_5a646ea8e8b153df = getentarray( "trig_tunnels_prison_blind_zombie", #script_noteworthy );
}

// Namespace namespace_82ef26b728b2fd29
// Params 1
// Checksum 0x6b75325b, Offset: 0x3781
// Size: 0x79
function function_12d3e6293a73c2b( grenade )
{
    grenade endon( #"death" );
    thread decoy_grenade::used( grenade );
    grenade waittill( #"hash_c860830af05fa677" );
    grenade.attractor = zombie_attractor_manager::add_attractor( grenade, 1, grenade.tableinfo.bundle.var_ca694ff612181976, 0, undefined, &function_a92d75a1117625fc, 0, undefined, 1 );
    grenade thread function_7de4ee6d3709aa7f();
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x4955f80c, Offset: 0x3802
// Size: 0x2c
function function_7de4ee6d3709aa7f()
{
    self waittill( #"death" );
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 2
// Checksum 0x4592b78b, Offset: 0x3836
// Size: 0x9e, Type: bool
function function_a92d75a1117625fc( attractor, ai )
{
    if ( !isalive( ai ) || !isdefined( attractor ) )
    {
        return false;
    }
    
    if ( ai utility::ent_flag( "scene_active" ) )
    {
        return false;
    }
    
    if ( isdefined( level.var_5a646ea8e8b153df ) )
    {
        var_2f17175b25d497ef = gemini_util::function_45725eed211aafdf( attractor.source.origin );
        
        if ( isdefined( var_2f17175b25d497ef ) && !ispointinvolume( ai.origin, var_2f17175b25d497ef ) )
        {
            return false;
        }
    }
    
    return ai.aicategory == "normal";
}

// Namespace namespace_82ef26b728b2fd29
// Params 0
// Checksum 0x95f8a1d1, Offset: 0x38dd
// Size: 0x91
function function_d66dea4b9ec8cda9()
{
    level utility::flag_wait( "flag_tunnels_anteroom_doors_locked" );
    
    foreach ( trig in level.var_5a646ea8e8b153df )
    {
        trig delete();
    }
    
    waitframe();
    level.var_5a646ea8e8b153df = undefined;
}

// Namespace namespace_82ef26b728b2fd29
// Params 4
// Checksum 0x2945e477, Offset: 0x3976
// Size: 0x20a
function function_9dbb32d321d0aa42( request_id, data, agent, ai_data )
{
    agent endon( #"death" );
    agent zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    flag_endon = "flag_tunnels_anteroom_doors_locked";
    
    if ( isdefined( agent.directorspawndata.spawnfilter ) && ( agent.directorspawndata.spawnfilter == #"zombie_high_reinforce" || agent.directorspawndata.spawnfilter == #"zombie_low_reinforce" ) )
    {
        agent childthread function_73334fc6fd12a7ea( data );
    }
    
    agent childthread gemini_util::function_6bcecbb730bbec68();
    
    if ( isdefined( agent.directorspawndata ) && agent.directorspawndata.script_noteworthy == "zombie_no_wander" )
    {
        agent zombie_wander::function_19c231bdb6f3a83a();
        
        /#
            if ( getdvarint( @"hash_56492ba9f5ce57c4", 0 ) )
            {
                level thread utility::function_95445a6684f51c52( "<dev string:xeb>", agent.origin + ( 0, 0, 80 ), ( 0.5, 0.5, 0.5 ), 0.5, 1, 30 );
            }
        #/
    }
    else if ( isdefined( agent.directorspawndata ) && isdefined( agent.directorspawndata.target ) )
    {
        agent thread function_6df5eabfd00b4143( flag_endon );
    }
    else
    {
        agent thread function_343fa2cbff9d3fe9( flag_endon );
    }
    
    agent thread function_8aaef09338c99320();
    agent thread function_e836e21f366679fe( data, flag_endon );
    
    if ( isstruct( data ) && isdefined( data.player ) )
    {
        agent function_fa32376aaa88a7a2( data.player.origin, 512 );
        agent zombie_utils::set_ai_target_priority( data.player );
    }
    
    level utility::flag_wait( flag_endon );
    agent notify( #"hash_c284a0154a1399b2" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 1, eflags: 0x4
// Checksum 0xa749e06b, Offset: 0x3b88
// Size: 0x131
function private function_73334fc6fd12a7ea( data )
{
    if ( isdefined( data.var_6851b792b9766c5 ) )
    {
        flag_cleanup_force = data.var_6851b792b9766c5;
    }
    else
    {
        assert( isdefined( data.flag_cleanup_force ) && isdefined( "<dev string:xfc>" ) );
        flag_cleanup_force = data.flag_cleanup_force;
    }
    
    while ( true )
    {
        if ( utility::flag( flag_cleanup_force ) )
        {
            if ( level.is_squad_size_small && level.players.size == 1 )
            {
                maxcount = 20;
            }
            else if ( !level.is_squad_size_small || level.players.size > 2 )
            {
                maxcount = 30;
            }
            else
            {
                maxcount = 25;
            }
        }
        else if ( !level.is_squad_size_small || level.players.size > 2 )
        {
            maxcount = 35;
        }
        else
        {
            maxcount = 30;
        }
        
        aicount = getaicount();
        
        if ( aicount > maxcount || utility::flag( "flag_tunnels_anteroom_doors_locked" ) )
        {
            break;
        }
        
        wait 1;
    }
    
    thread gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x4
// Checksum 0xb7dc29bb, Offset: 0x3cc1
// Size: 0x25
function private function_8aaef09338c99320()
{
    utility::flag_wait( "stealth_enabled" );
    self thread [[ level.stealth.fninitenemygame ]]();
}

// Namespace namespace_82ef26b728b2fd29
// Params 2, eflags: 0x4
// Checksum 0x266da43, Offset: 0x3cee
// Size: 0x30b
function private function_e836e21f366679fe( data, flag_endon )
{
    self endon( #"death", #"hash_723d11d2b5cc9543" );
    
    if ( level utility::flag( flag_endon ) )
    {
        return;
    }
    
    utility::ent_flag_wait( "ai_init_complete" );
    utility::ent_flag_init( "zombie_stealth_combat" );
    val::set( "zombie_blind", "toggle_eye_glow", 0 );
    self enabletraversals( 0 );
    var_a313f69c47737869 = self.stealth_bsmstate;
    waitframe();
    
    while ( !level utility::flag( flag_endon ) )
    {
        if ( !isdefined( self.stealth ) )
        {
            wait 0.5;
            continue;
        }
        
        if ( self.stealth_bsmstate != var_a313f69c47737869 )
        {
            if ( self.stealth_bsmstate == 3 )
            {
                zombie_speed = "sprint";
                
                if ( self.subclass == "zombie_base_armored_heavy" )
                {
                    zombie_speed = "run";
                }
                
                val::set( "zombie_blind", "toggle_eye_glow", 1 );
                self enabletraversals( 1 );
                
                if ( isdefined( data ) )
                {
                    thread function_be46390ba870947( data, flag_endon );
                }
                
                zombie_utils::function_a8ce00e0448cb6f0( zombie_speed, "blind_zombie_speed", 25 );
                utility::ent_flag_set( "zombie_stealth_combat" );
            }
            else if ( self.stealth_bsmstate == 1 || self.stealth_bsmstate == 2 )
            {
                if ( self.stealth_bsmstate == 2 )
                {
                    zombie_speed = "run";
                }
                else
                {
                    zombie_speed = "walk";
                }
                
                val::set( "zombie_blind", "toggle_eye_glow", 1 );
                zombie_utils::function_a8ce00e0448cb6f0( zombie_speed, "blind_zombie_speed", 25 );
                utility::ent_flag_clear( "zombie_stealth_combat" );
            }
            else
            {
                val::set( "zombie_blind", "toggle_eye_glow", 0 );
                self enabletraversals( 0 );
                zombie_utils::function_a8ce00e0448cb6f0( "walk", "blind_zombie_speed", 25 );
                utility::ent_flag_clear( "zombie_stealth_combat" );
            }
            
            var_a313f69c47737869 = self.stealth_bsmstate;
        }
        
        wait 0.1;
    }
    
    while ( self.stealth_bsmstate == 3 || isdefined( self.enemy ) )
    {
        wait 0.1;
    }
    
    self setsightstate( "idle" );
    enemy::bt_set_stealth_state( "idle" );
    zombie_utils::function_a8ce00e0448cb6f0( "walk", "blind_zombie_speed", 25 );
    utility::ent_flag_clear( "zombie_stealth_combat" );
    
    if ( isdefined( self.var_7f6c9dbe5a8d22ea ) )
    {
        self._blackboard.var_b213ded5043dfa2b = self.var_7f6c9dbe5a8d22ea;
    }
    
    if ( isdefined( self.var_480f2c7fa3bfd7aa ) && self._blackboard.var_8d11b98561e1eb81 != self.var_480f2c7fa3bfd7aa )
    {
        self._blackboard.var_8d11b98561e1eb81 = self.var_480f2c7fa3bfd7aa;
    }
    
    if ( isdefined( self.var_4832367fa3e63560 ) && self._blackboard.var_8d34ab856208146f != self.var_4832367fa3e63560 )
    {
        self._blackboard.var_8d34ab856208146f = self.var_4832367fa3e63560;
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 2, eflags: 0x4
// Checksum 0x4f079934, Offset: 0x4001
// Size: 0x51
function private function_be46390ba870947( data, flag_endon )
{
    level endon( flag_endon, #"game_ended" );
    self endon( #"death" );
    wait 3;
    
    if ( utility::ent_flag( "zombie_stealth_combat" ) )
    {
        data notify( #"zombie_stealth_combat", self );
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 3, eflags: 0x4
// Checksum 0xa2bf1b1c, Offset: 0x405a
// Size: 0x403
function private function_2159e4a05e0981b7( flag_endon, var_16638b753b1ada7b = 400, var_242a6668faa1e80a = 64 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( level utility::flag( flag_endon ) )
    {
        return;
    }
    
    sight = 0;
    visible = 0;
    combat = 0;
    var_584547698236b56d = undefined;
    rate = 0.05;
    self.var_16638b753b1ada7b = var_16638b753b1ada7b;
    self.var_3022c4a1f1710667 = squared( var_16638b753b1ada7b * 0.5 );
    self.var_a4fe867439faaa81 = squared( var_16638b753b1ada7b * 0.2 );
    self.var_242a6668faa1e80a = var_242a6668faa1e80a;
    self.dummyevent = spawnstruct();
    self.dummyevent.player_target = undefined;
    self.last_player_target = undefined;
    
    while ( !level utility::flag( flag_endon ) )
    {
        if ( self.stealth_bsmstate == 3 )
        {
            wait 0.5;
            continue;
        }
        
        if ( isdefined( self.target_attractor ) && self.target_attractor != self.patrol_attractor )
        {
            visible = 0;
            combat = 0;
            var_584547698236b56d = undefined;
        }
        else
        {
            function_6d3badf4e7793fed();
        }
        
        if ( isdefined( self.dummyevent.player_target ) )
        {
            if ( self.last_player_target != self.dummyevent.player_target )
            {
                self.last_player_target = self.dummyevent.player_target;
            }
            
            sight += rate * level.framedurationseconds;
            visible = 1;
            self.dummyevent.origin = self.dummyevent.player_target.origin;
            self.dummyevent.investigate_point = self.dummyevent.player_target.origin;
            self.dummyevent.investigate_pos = self.dummyevent.player_target.origin;
            
            if ( self.dummyevent.severity == "combat" )
            {
                self.dummyevent.type = "combat";
                self.dummyevent.typeorig = "attack";
                waitframe();
                utility::function_227c1c2c6c7ebd6a( "combat" );
            }
            else
            {
                self.dummyevent.type = "investigate";
                self.dummyevent.typeorig = "found_corpse";
                enemy::bt_event_investigate( self.dummyevent );
            }
            
            /#
                if ( getdvarint( @"hash_56492ba9f5ce57c4", 0 ) )
                {
                    iprintlnbold( "<dev string:x12e>" + self.dummyevent.player_target.origin + "<dev string:x154>" );
                }
            #/
        }
        else
        {
            visible = 0;
            combat = 0;
            
            if ( sight > 0 )
            {
                sight -= rate * level.framedurationseconds * 2;
            }
        }
        
        sight = clamp( sight, 0, 1 );
        
        if ( isdefined( self.threat_sight_data ) )
        {
            if ( sight > 0.9 || self.dummyevent.severity == "combat" )
            {
                combat = 1;
            }
            else
            {
                combat = 0;
            }
            
            var_584547698236b56d = self.dummyevent.player_target;
            
            if ( isdefined( self.last_player_target ) && !isdefined( var_584547698236b56d ) )
            {
                var_584547698236b56d = self.last_player_target;
                self.last_player_target = undefined;
            }
            
            if ( isdefined( var_584547698236b56d ) )
            {
                self setthreatsight( var_584547698236b56d, sight );
            }
        }
        
        wait 0.5;
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x4
// Checksum 0x31a6df22, Offset: 0x4465
// Size: 0x2a6
function private function_6d3badf4e7793fed()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.dummyevent.player_target = undefined;
    playing_players = ob_story_mission_utils::get_playing_players();
    var_147f36b70a2f8293 = sortbydistancecullbyradius( playing_players, self.origin, self.var_16638b753b1ada7b );
    
    if ( var_147f36b70a2f8293.size > 0 )
    {
        for ( i = 0; i < var_147f36b70a2f8293.size ; i++ )
        {
            self.dummyevent.severity = undefined;
            player = var_147f36b70a2f8293[ i ];
            
            if ( abs( player.origin[ 2 ] - self.origin[ 2 ] ) > self.var_242a6668faa1e80a )
            {
                continue;
            }
            
            if ( isdefined( self.var_2f17175b25d497ef ) && !ispointinvolume( player.origin, self.var_2f17175b25d497ef ) )
            {
                continue;
            }
            
            if ( player::isinlaststand( player ) )
            {
                continue;
            }
            
            if ( player utility::ent_flag( "stealth_in_shadow" ) )
            {
                continue;
            }
            
            if ( player issprinting() || player issprintsliding() )
            {
                self.dummyevent.player_target = player;
                self.dummyevent.severity = "combat";
                return;
            }
            
            trace_player = function_ce9b7f1894a38b32( player );
            var_9c9f604f49279920 = 0;
            var_76514223f693a0f1 = 0;
            
            if ( isdefined( trace_player ) )
            {
                zombie_fwd = anglestoforward( self.angles );
                zombie_to_player = vectornormalize( player.origin - self.origin );
                
                if ( vectordot( zombie_fwd, zombie_to_player ) < 0 )
                {
                    var_76514223f693a0f1 = 1;
                }
                
                player_distance = distance2dsquared( self.origin, player.origin );
                
                if ( var_76514223f693a0f1 )
                {
                    player_distance *= 10;
                }
                
                if ( length( self getvelocity() ) < 25 )
                {
                    player_distance *= 2;
                }
                
                if ( player_distance < self.var_a4fe867439faaa81 )
                {
                    if ( player getstance() == "stand" )
                    {
                        self.dummyevent.severity = "combat";
                    }
                    
                    var_9c9f604f49279920 = 1;
                }
                else if ( player_distance < self.var_3022c4a1f1710667 && player getstance() == "stand" )
                {
                    var_9c9f604f49279920 = 1;
                }
            }
            
            if ( var_9c9f604f49279920 && isdefined( trace_player ) )
            {
                self.dummyevent.player_target = player;
                return;
            }
        }
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 2, eflags: 0x4
// Checksum 0x56bd05db, Offset: 0x4713
// Size: 0xd9
function private function_ce9b7f1894a38b32( player, latency = 0 )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    player endon( #"death" );
    currenttime = gettime();
    
    if ( isdefined( self.var_5b4f4fca2e865007 ) && isdefined( self.var_2d57e68db77b2456 ) && self.var_2d57e68db77b2456 + latency >= currenttime )
    {
        assert( isdefined( self.var_5b4f4fca2e865007 ) );
        return self.var_5b4f4fca2e865007;
    }
    
    self.var_2d57e68db77b2456 = currenttime;
    self.var_5b4f4fca2e865007 = undefined;
    
    if ( sighttracepassed( player geteye(), self getapproxeyepos(), 1, player, self ) )
    {
        self.var_5b4f4fca2e865007 = player;
    }
    
    return self.var_5b4f4fca2e865007;
}

// Namespace namespace_82ef26b728b2fd29
// Params 2
// Checksum 0x66847cf9, Offset: 0x47f5
// Size: 0x376
function function_6df5eabfd00b4143( flag_endon, b_attractor = 1 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( level utility::flag( flag_endon ) )
    {
        return;
    }
    
    waitframe();
    self.var_7f6c9dbe5a8d22ea = self._blackboard.var_b213ded5043dfa2b;
    self.var_4832367fa3e63560 = self._blackboard.var_8d34ab856208146f;
    self.var_480f2c7fa3bfd7aa = self._blackboard.var_8d11b98561e1eb81;
    s_patrol_goal = utility::getstruct( self.directorspawndata.target, "targetname" );
    self.patrol_attractor = undefined;
    
    if ( isdefined( b_attractor ) )
    {
        s_patrol_attractor = spawnstruct();
        s_patrol_attractor.origin = self._blackboard.var_b213ded5043dfa2b;
    }
    
    player_team = gemini_util::player_get_team();
    
    while ( !level utility::flag( flag_endon ) )
    {
        if ( self.stealth_bsmstate != 0 )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( self.target_attractor ) && self.target_attractor != self.patrol_attractor )
        {
            wait 1;
            continue;
        }
        
        if ( b_attractor )
        {
            s_patrol_attractor.origin = s_patrol_goal.origin;
            self.patrol_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_patrol_attractor, 0, undefined, undefined, undefined, undefined, undefined, player_team );
        }
        
        self._blackboard.var_b213ded5043dfa2b = s_patrol_goal.origin;
        
        if ( isdefined( s_patrol_goal.radius ) )
        {
            self._blackboard.var_8d11b98561e1eb81 = s_patrol_goal.radius * 0.5;
            self._blackboard.var_8d34ab856208146f = s_patrol_goal.radius;
        }
        
        waitframe();
        function_b6da68bdee9f8f75( flag_endon );
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( s_patrol_attractor );
        n_delay = undefined;
        
        if ( isdefined( s_patrol_goal.script_delay ) || isdefined( s_patrol_goal.script_delay_min ) || isdefined( s_patrol_goal.script_delay_max ) )
        {
            if ( isdefined( s_patrol_goal.script_delay ) )
            {
                n_delay = s_patrol_goal.script_delay;
            }
            else if ( isdefined( s_patrol_goal.script_delay_max ) )
            {
                if ( isdefined( s_patrol_goal.script_delay_min ) )
                {
                    n_delay = randomfloatrange( s_patrol_goal.script_delay_min, s_patrol_goal.script_delay_max );
                }
                else
                {
                    n_delay = randomfloat( s_patrol_goal.script_delay_max );
                }
            }
        }
        
        function_c8209a7100fbd71b( flag_endon, n_delay );
        
        if ( isdefined( s_patrol_goal.target ) )
        {
            s_patrol_goal = utility::getstruct( s_patrol_goal.target, "targetname" );
        }
        else
        {
            level utility::flag_wait( flag_endon );
            break;
        }
        
        wait 1;
    }
    
    wait 1;
    
    if ( b_attractor )
    {
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( s_patrol_attractor );
    }
    
    self._blackboard.var_b213ded5043dfa2b = self.var_7f6c9dbe5a8d22ea;
    self._blackboard.var_8d34ab856208146f = self.var_4832367fa3e63560;
    self._blackboard.var_8d11b98561e1eb81 = self.var_480f2c7fa3bfd7aa;
}

// Namespace namespace_82ef26b728b2fd29
// Params 2
// Checksum 0x4dee3911, Offset: 0x4b73
// Size: 0x269
function function_b6da68bdee9f8f75( flag_endon, n_timeout = 30 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( level utility::flag( flag_endon ) )
    {
        return;
    }
    
    waitframe();
    n_radius = self._blackboard.var_8d11b98561e1eb81;
    var_7ae605d773736268 = squared( n_radius );
    v_patrol_goal = self._blackboard.var_b213ded5043dfa2b;
    start_time = gettime();
    
    while ( !level utility::flag( flag_endon ) )
    {
        if ( self.stealth_bsmstate != 0 )
        {
            start_time = gettime();
            wait 1;
            break;
        }
        
        if ( isdefined( self.target_attractor ) && self.target_attractor != self.patrol_attractor )
        {
            start_time = gettime();
            wait 1;
            break;
        }
        
        if ( distance2dsquared( self.origin, v_patrol_goal ) <= var_7ae605d773736268 )
        {
            /#
                if ( getdvarint( @"hash_56492ba9f5ce57c4", 0 ) )
                {
                    level thread utility::function_95445a6684f51c52( "<dev string:x159>", self.origin + ( 0, 0, 120 ), ( 0.5, 0.5, 0.5 ), 0.5, 1, 3 );
                }
            #/
            
            break;
        }
        
        if ( gettime() - start_time > utility::function_4b74c15943231980( n_timeout ) )
        {
            /#
                if ( getdvarint( @"hash_56492ba9f5ce57c4", 0 ) )
                {
                    level thread utility::function_95445a6684f51c52( "<dev string:x171>", self.origin + ( 0, 0, 120 ), ( 0.5, 0.5, 0.5 ), 0.5, 1, 3 );
                }
            #/
            
            break;
        }
        
        /#
            if ( getdvarint( @"hash_56492ba9f5ce57c4", 0 ) )
            {
                level thread utility::function_95445a6684f51c52( "<dev string:x189>", self.origin + ( 0, 0, 80 ), ( 0.5, 0.5, 0.5 ), 0.5, 0.5, 1 );
                level thread utility::draw_line_for_time( self.origin, v_patrol_goal, 0, 0, 0, 1 );
                level thread utility::draw_circle( v_patrol_goal, n_radius, ( 0, 0, 0 ), 1, 0, 60 );
            }
        #/
        
        wait 1;
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 2
// Checksum 0x6a063631, Offset: 0x4de4
// Size: 0x121
function function_c8209a7100fbd71b( flag_endon, n_delay )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( level utility::flag( flag_endon ) )
    {
        return;
    }
    
    waitframe();
    start_time = gettime();
    
    while ( !level utility::flag( flag_endon ) )
    {
        if ( self.stealth_bsmstate != 0 )
        {
            start_time = gettime();
            wait 1;
            continue;
        }
        
        if ( isdefined( self.target_attractor ) && self.target_attractor != self.patrol_attractor )
        {
            start_time = gettime();
            wait 1;
            continue;
        }
        
        if ( isdefined( n_delay ) )
        {
            if ( gettime() - start_time > utility::function_4b74c15943231980( n_delay ) )
            {
                break;
            }
        }
        
        /#
            if ( getdvarint( @"hash_56492ba9f5ce57c4", 0 ) )
            {
                level thread utility::function_95445a6684f51c52( "<dev string:x1a8>", self.origin + ( 0, 0, 80 ), ( 0.5, 0.5, 0.5 ), 0.5, 0.5, 1 );
            }
        #/
        
        wait 1;
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 1
// Checksum 0x7d4dc73c, Offset: 0x4f0d
// Size: 0x52e
function function_343fa2cbff9d3fe9( flag_endon )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( level utility::flag( flag_endon ) )
    {
        return;
    }
    
    waitframe();
    self.var_7f6c9dbe5a8d22ea = self._blackboard.var_b213ded5043dfa2b;
    self.var_4832367fa3e63560 = self._blackboard.var_8d34ab856208146f;
    self.var_480f2c7fa3bfd7aa = self._blackboard.var_8d11b98561e1eb81;
    self.var_78d1e7b45c97771f = 0;
    
    if ( utility::cointoss() )
    {
        self.var_78d1e7b45c97771f = 1;
    }
    
    while ( !level utility::flag( flag_endon ) )
    {
        if ( self.stealth_bsmstate != 0 )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( self.target_attractor ) && self.target_attractor != self.patrol_attractor )
        {
            wait 1;
            continue;
        }
        
        if ( self.var_78d1e7b45c97771f )
        {
            self._blackboard.var_b213ded5043dfa2b = self.var_7f6c9dbe5a8d22ea;
        }
        
        var_2f7b2a68faac28db = getplayersinradius( self.origin, 384 );
        
        if ( var_2f7b2a68faac28db.size > 0 )
        {
            self_z = self.origin[ 2 ];
            
            foreach ( player in var_2f7b2a68faac28db )
            {
                player_z = player.origin[ 2 ];
                
                if ( abs( player_z - self_z ) > 64 )
                {
                    var_2f7b2a68faac28db = arrayremove( var_2f7b2a68faac28db, player );
                }
            }
        }
        
        if ( var_2f7b2a68faac28db.size == 0 )
        {
            wait 1;
            continue;
        }
        
        var_1454decc673539de = var_2f7b2a68faac28db[ 0 ];
        var_a4bee390da0c51ca = !self.var_78d1e7b45c97771f;
        
        if ( isbot( var_1454decc673539de ) )
        {
            var_a4bee390da0c51ca = 1;
        }
        else if ( var_a4bee390da0c51ca == 1 )
        {
            if ( isdefined( var_1454decc673539de.var_c00cf995c303f2f5 ) && gettime() - var_1454decc673539de.var_c00cf995c303f2f5 < 10000 )
            {
                var_a4bee390da0c51ca = 0;
            }
            else
            {
                var_a4bee390da0c51ca = utility::cointoss();
            }
        }
        
        if ( var_a4bee390da0c51ca )
        {
            away_ang = vectortoangles( self.origin - var_1454decc673539de.origin );
            away_pos = self.origin + anglestoforward( away_ang ) * randomfloatrange( 64, 192 );
            away_origin = self getclosestreachablepointonnavmesh( away_pos );
            
            if ( isdefined( away_origin ) )
            {
                if ( self._blackboard.var_8d11b98561e1eb81 == self.var_480f2c7fa3bfd7aa && self._blackboard.var_8d34ab856208146f == self.var_4832367fa3e63560 )
                {
                    self._blackboard.var_8d11b98561e1eb81 *= 0.5;
                    self._blackboard.var_8d34ab856208146f *= 0.5;
                }
                
                self._blackboard.var_b213ded5043dfa2b = away_origin;
                self.var_78d1e7b45c97771f = 1;
                var_1454decc673539de.var_c00cf995c303f2f5 = gettime();
                n_delay = randomfloatrange( 1, 9 );
                
                /#
                    if ( getdvarint( @"hash_56492ba9f5ce57c4", 0 ) )
                    {
                        level thread utility::function_95445a6684f51c52( "<dev string:x1c0>", self.origin + ( 0, 0, 80 ), ( 0.5, 0.5, 0.5 ), 0.5, 0.5, n_delay );
                        level thread utility::draw_line_for_time( self.origin, away_origin, 0, 0, 0, n_delay );
                    }
                #/
                
                wait n_delay;
            }
            else
            {
                self.var_78d1e7b45c97771f = 0;
            }
        }
        else
        {
            self.var_78d1e7b45c97771f = 0;
        }
        
        wait randomfloatrange( 5, 15 );
        
        if ( self._blackboard.var_8d11b98561e1eb81 != self.var_480f2c7fa3bfd7aa || self._blackboard.var_8d34ab856208146f != self.var_4832367fa3e63560 )
        {
            self._blackboard.var_8d11b98561e1eb81 = self.var_480f2c7fa3bfd7aa;
            self._blackboard.var_8d34ab856208146f = self.var_4832367fa3e63560;
        }
    }
    
    wait 1;
    self._blackboard.var_b213ded5043dfa2b = self.var_7f6c9dbe5a8d22ea;
    self._blackboard.var_8d34ab856208146f = self.var_4832367fa3e63560;
    self._blackboard.var_8d11b98561e1eb81 = self.var_480f2c7fa3bfd7aa;
}

/#

    // Namespace namespace_82ef26b728b2fd29
    // Params 0
    // Checksum 0x4f2b5028, Offset: 0x5443
    // Size: 0x5, Type: dev
    function function_bd292ef3e322678b()
    {
        
    }

#/

// Namespace namespace_82ef26b728b2fd29
// Params 2
// Checksum 0xe002e437, Offset: 0x5450
// Size: 0x1be
function function_cf5097243a97cde9( scriptable_targetname, var_b60496d5b429ae0f )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "flag_" + scriptable_targetname ) )
    {
        return;
    }
    
    level utility::flag_set( "flag_" + scriptable_targetname );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
    }
    
    radio_interact = gemini_util::get_scriptable( scriptable_targetname );
    radio_interact.radio_on = 0;
    s_speaker = utility::getstruct( radio_interact.target, "targetname" );
    var_7fca846984049a1f = utility::spawn_script_origin( s_speaker.origin, ( 0, 0, 0 ) );
    var_7fca846984049a1f.s_attractor = s_speaker;
    var_7fca846984049a1f.interact = radio_interact;
    radio_interact.var_7fca846984049a1f = var_7fca846984049a1f;
    radio_light = undefined;
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        radio_interact.var_b60496d5b429ae0f = var_b60496d5b429ae0f;
    }
    
    if ( isdefined( radio_interact.script_linkto ) )
    {
        radio_light = radio_interact utility::function_e1bb0bf82dab729e()[ 0 ];
        
        if ( isdefined( radio_light ) )
        {
            radio_light thread function_6ffc12f1d17cb27c( var_7fca846984049a1f );
        }
    }
    
    waitframe();
    var_7fca846984049a1f function_4531f831ada1a95( 0, 0 );
    interaction::register_scriptable_interact( radio_interact, &function_61c3debda4f1736b );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        level utility::flag_wait( var_b60496d5b429ae0f );
        var_7fca846984049a1f function_4531f831ada1a95( 0, 0 );
        waitframe();
        radio_interact.var_d8e3b07237845727 = [];
        radio_interact.var_ac8ffcf4a10f3e6d = [];
        radio_interact.var_9718e0be9c5d54dd = [];
        level.interacts = arrayremove( level.interacts, radio_interact );
        var_7fca846984049a1f notify( #"delete_distraction" );
        waitframe();
        var_7fca846984049a1f delete();
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 1, eflags: 0x4
// Checksum 0xb77de94c, Offset: 0x5616
// Size: 0x77
function private function_6ffc12f1d17cb27c( var_7fca846984049a1f )
{
    self endon( #"death" );
    var_7fca846984049a1f endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        utility::function_7c10ea82c1e305b8( "base", "light_off" );
        var_7fca846984049a1f waittill( #"hash_4d062f13286ecc66" );
        utility::function_7c10ea82c1e305b8( "base", "light_on" );
        var_7fca846984049a1f waittill( #"hash_50692d8db45bbd48" );
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 1, eflags: 0x4
// Checksum 0x13713525, Offset: 0x5695
// Size: 0x13
function private function_61c3debda4f1736b( player )
{
    thread _radio_interact_used();
}

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x4
// Checksum 0x998ba3df, Offset: 0x56b0
// Size: 0x103
function private _radio_interact_used()
{
    if ( !self.radio_on )
    {
        utility::function_7c10ea82c1e305b8( "base", "radio_turning_on" );
        self notify( #"radio_on" );
        wait 1;
        
        if ( isdefined( self.script_flag_set ) )
        {
            level utility::flag_set( self.script_flag_set );
        }
        
        waitframe();
        self.var_7fca846984049a1f function_4531f831ada1a95( 1 );
        self.radio_on = 1;
        thread function_952df823dceb598c();
        
        /#
            iprintlnbold( "<dev string:x1d6>" + self.targetname );
        #/
        
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "base", "radio_turning_off" );
    self notify( #"radio_off" );
    wait 1;
    
    if ( isdefined( self.script_flag_set ) )
    {
        level utility::flag_clear( self.script_flag_set );
    }
    
    waitframe();
    self.var_7fca846984049a1f function_4531f831ada1a95( 0 );
    self.radio_on = 0;
    
    /#
        iprintlnbold( "<dev string:x1ed>" + self.targetname );
    #/
}

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x4
// Checksum 0xd315b3ae, Offset: 0x57bb
// Size: 0x9b
function private function_952df823dceb598c()
{
    self endon( #"death", #"radio_off" );
    self waittill( #"hash_bb5aec48baa340a5" );
    
    if ( !isdefined( self ) || !self.radio_on )
    {
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "base", "radio_turning_off" );
    
    if ( isdefined( self.script_flag_set ) )
    {
        level utility::flag_clear( self.script_flag_set );
    }
    
    waitframe();
    self.var_7fca846984049a1f function_4531f831ada1a95( 0 );
    self.radio_on = 0;
    
    /#
        iprintlnbold( "<dev string:x205>" + self.targetname );
    #/
}

// Namespace namespace_82ef26b728b2fd29
// Params 3, eflags: 0x4
// Checksum 0x64c9e6cd, Offset: 0x585e
// Size: 0x1b6
function private function_4531f831ada1a95( var_762f5d19a53f7c0, attractor_radius = 800, var_5a9b96e9891bfe34 )
{
    self endon( #"death", #"delete_distraction" );
    
    if ( isdefined( self.s_attractor.radius ) )
    {
        attractor_radius = self.s_attractor.radius;
    }
    
    if ( !isdefined( var_5a9b96e9891bfe34 ) )
    {
        validator_fn = &function_739452571c202832;
    }
    
    if ( var_762f5d19a53f7c0 )
    {
        player_team = gemini_util::player_get_team();
        self.var_183d02c9ee4eaa73 = zombie_attractor_manager::add_attractor( self.s_attractor, 3, attractor_radius, undefined, undefined, validator_fn, undefined, player_team, 1 );
        var_fc48cc6608c8d82c = utility::getstructarray( self.s_attractor.target, "targetname" );
        var_fc48cc6608c8d82c = arrayrandomize( var_fc48cc6608c8d82c );
        zombie_attractor_manager::set_attractor_slots( self.var_183d02c9ee4eaa73, var_fc48cc6608c8d82c );
        zombie_attractor_manager::set_attractor_cooldown_time( self.var_183d02c9ee4eaa73, 9000 );
        childthread function_856bd859adb412e7();
        wait 0.1;
        self notify( #"hash_4d062f13286ecc66" );
        self.var_711e3c9a288e87ff = 1;
        return;
    }
    
    self.var_711e3c9a288e87ff = 0;
    wait 0.1;
    
    if ( isdefined( self.var_183d02c9ee4eaa73 ) )
    {
        zombie_attractor_manager::remove_attractor( self.var_183d02c9ee4eaa73 );
    }
    
    if ( isdefined( self.mus_ent ) )
    {
        self.mus_ent stopsounds();
        self.mus_ent playsound( "mus_diegetic_prison_pa_stop_ccap" );
        self.mus_ent utility::delaycall( 0.5, &delete );
    }
    
    self notify( #"hash_50692d8db45bbd48" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x4
// Checksum 0x54eb4443, Offset: 0x5a1c
// Size: 0xbe
function private function_856bd859adb412e7()
{
    self endon( #"hash_50692d8db45bbd48" );
    
    if ( !isdefined( self.mus_ent ) )
    {
        self.mus_ent = spawn( "script_origin", self.s_attractor.origin );
        waitframe();
        self.mus_ent stopsounds();
    }
    
    self.mus_ent playsound( "mus_diegetic_prison_pa", undefined, self.mus_ent );
    var_92777c38b4ad0d31 = lookupsoundlength( "mus_diegetic_prison_pa" );
    wait utility::function_6f5d2e1f1ff70482( var_92777c38b4ad0d31 );
    self.mus_ent playsound( "mus_diegetic_prison_pa_stop_ccap" );
    self notify( #"hash_bb5aec48baa340a5" );
    self.interact notify( #"hash_bb5aec48baa340a5" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 2, eflags: 0x4
// Checksum 0x72ac02c4, Offset: 0x5ae2
// Size: 0xa5, Type: bool
function private function_739452571c202832( attractor, zombie )
{
    if ( !isalive( zombie ) || !isdefined( attractor ) )
    {
        return false;
    }
    
    if ( zombie utility::ent_flag( "scene_active" ) )
    {
        return false;
    }
    
    if ( zombie.stealth_bsmstate == 3 )
    {
        return false;
    }
    
    var_2f17175b25d497ef = undefined;
    
    if ( isdefined( level.var_5a646ea8e8b153df ) )
    {
        var_2f17175b25d497ef = gemini_util::function_45725eed211aafdf( attractor.source.origin );
        
        if ( isdefined( var_2f17175b25d497ef ) && !ispointinvolume( zombie.origin, var_2f17175b25d497ef ) )
        {
            return false;
        }
    }
    
    return true;
}

/#

    // Namespace namespace_82ef26b728b2fd29
    // Params 0
    // Checksum 0x8b53432d, Offset: 0x5b90
    // Size: 0x5, Type: dev
    function function_3cb447f505c14bff()
    {
        
    }

#/

// Namespace namespace_82ef26b728b2fd29
// Params 2
// Checksum 0x377ec71, Offset: 0x5b9d
// Size: 0x192
function shower_valve_setup( scriptable_targetname, var_b60496d5b429ae0f )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    
    if ( level utility::flag( "flag_" + scriptable_targetname ) )
    {
        return;
    }
    
    level utility::flag_set( "flag_" + scriptable_targetname );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
    }
    
    shower_valve_interact = gemini_util::get_scriptable( scriptable_targetname );
    shower_valve_interact.shower_on = 0;
    var_10edfd0e93fbe1c5 = utility::getstruct( shower_valve_interact.target, "targetname" );
    var_6d969104d66ee8b = utility::spawn_script_origin( var_10edfd0e93fbe1c5.origin, ( 0, 0, 0 ) );
    var_6d969104d66ee8b.s_attractor = var_10edfd0e93fbe1c5;
    var_6d969104d66ee8b.a_showers = shower_valve_interact function_5a2ff6736970b952();
    var_6d969104d66ee8b.interact = shower_valve_interact;
    shower_valve_interact.var_6d969104d66ee8b = var_6d969104d66ee8b;
    waitframe();
    var_6d969104d66ee8b function_63c4099068ed5da5( 0, 0 );
    interact = interaction::register_scriptable_interact( shower_valve_interact, &function_89c45ed7ea9581a5 );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        level utility::flag_wait( var_b60496d5b429ae0f );
        var_6d969104d66ee8b function_63c4099068ed5da5( 0, 0 );
        waitframe();
        shower_valve_interact.var_d8e3b07237845727 = [];
        shower_valve_interact.var_ac8ffcf4a10f3e6d = [];
        shower_valve_interact.var_9718e0be9c5d54dd = [];
        level.interacts = arrayremove( level.interacts, shower_valve_interact );
        var_6d969104d66ee8b thread function_9d7874e719633313();
    }
}

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x4
// Checksum 0x1d582c33, Offset: 0x5d37
// Size: 0xea
function private function_9d7874e719633313()
{
    self endon( #"death" );
    self.var_711e3c9a288e87ff = 0;
    wait 0.1;
    
    if ( isdefined( self.a_showers ) )
    {
        foreach ( shower in self.a_showers )
        {
            shower utility::function_7c10ea82c1e305b8( "base", "stop_use" );
        }
    }
    
    if ( isdefined( self.var_183d02c9ee4eaa73 ) )
    {
        zombie_attractor_manager::remove_attractor( self.var_183d02c9ee4eaa73 );
    }
    
    self notify( #"shower_valve_off" );
    self notify( #"delete_distraction" );
    waitframe();
    self delete();
}

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x4
// Checksum 0x81bbdb25, Offset: 0x5e29
// Size: 0x1f
function private function_5a2ff6736970b952()
{
    scriptables = gemini_util::get_scriptable_array( self.script_noteworthy );
    return scriptables;
}

// Namespace namespace_82ef26b728b2fd29
// Params 1, eflags: 0x4
// Checksum 0x622efe74, Offset: 0x5e51
// Size: 0x13
function private function_89c45ed7ea9581a5( player )
{
    thread function_fbbcf81be568795();
}

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x4
// Checksum 0xae9f8055, Offset: 0x5e6c
// Size: 0x103
function private function_fbbcf81be568795()
{
    if ( !self.shower_on )
    {
        utility::function_7c10ea82c1e305b8( "base", "opening" );
        self notify( #"shower_on" );
        wait 1;
        
        if ( isdefined( self.script_flag_set ) )
        {
            level utility::flag_set( self.script_flag_set );
        }
        
        waitframe();
        self.var_6d969104d66ee8b function_63c4099068ed5da5( 1 );
        self.shower_on = 1;
        thread function_b861e60377c4c1c3();
        
        /#
            iprintlnbold( "<dev string:x228>" + self.targetname );
        #/
        
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "base", "closing" );
    self notify( #"shower_off" );
    wait 1;
    
    if ( isdefined( self.script_flag_set ) )
    {
        level utility::flag_clear( self.script_flag_set );
    }
    
    waitframe();
    self.var_6d969104d66ee8b function_63c4099068ed5da5( 0 );
    self.shower_on = 0;
    
    /#
        iprintlnbold( "<dev string:x240>" + self.targetname );
    #/
}

// Namespace namespace_82ef26b728b2fd29
// Params 0, eflags: 0x4
// Checksum 0xa9caf10a, Offset: 0x5f77
// Size: 0x94
function private function_b861e60377c4c1c3()
{
    self endon( #"death", #"shower_off" );
    wait 60;
    
    if ( !isdefined( self ) || !self.shower_on )
    {
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "base", "closing" );
    
    if ( isdefined( self.script_flag_set ) )
    {
        level utility::flag_clear( self.script_flag_set );
    }
    
    waitframe();
    self.var_6d969104d66ee8b function_63c4099068ed5da5( 0 );
    self.shower_on = 0;
    
    /#
        iprintlnbold( "<dev string:x259>" + self.targetname );
    #/
}

// Namespace namespace_82ef26b728b2fd29
// Params 3, eflags: 0x4
// Checksum 0xa933eceb, Offset: 0x6013
// Size: 0x284
function private function_63c4099068ed5da5( var_762f5d19a53f7c0, attractor_radius = 1200, var_5a9b96e9891bfe34 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"death", #"delete_distraction" );
    
    if ( isdefined( self.s_attractor.radius ) )
    {
        attractor_radius = self.s_attractor.radius;
    }
    
    if ( !isdefined( var_5a9b96e9891bfe34 ) )
    {
        validator_fn = &function_5646ba5fd88204a2;
    }
    
    if ( var_762f5d19a53f7c0 )
    {
        if ( isdefined( self.a_showers ) )
        {
            foreach ( shower in self.a_showers )
            {
                shower utility::function_7c10ea82c1e305b8( "base", "in_use" );
            }
        }
        
        player_team = gemini_util::player_get_team();
        self.var_183d02c9ee4eaa73 = zombie_attractor_manager::add_attractor( self.s_attractor, 3, attractor_radius, undefined, undefined, validator_fn, undefined, player_team, 1 );
        var_fc48cc6608c8d82c = utility::getstructarray( self.s_attractor.target, "targetname" );
        var_fc48cc6608c8d82c = arrayrandomize( var_fc48cc6608c8d82c );
        zombie_attractor_manager::set_attractor_slots( self.var_183d02c9ee4eaa73, var_fc48cc6608c8d82c );
        zombie_attractor_manager::set_attractor_cooldown_time( self.var_183d02c9ee4eaa73, 9000 );
        wait 0.1;
        self notify( #"shower_valve_on" );
        self.var_711e3c9a288e87ff = 1;
        return;
    }
    
    self.var_711e3c9a288e87ff = 0;
    wait 0.1;
    
    if ( isdefined( self.a_showers ) )
    {
        foreach ( shower in self.a_showers )
        {
            shower utility::function_7c10ea82c1e305b8( "base", "stop_use" );
        }
    }
    
    if ( isdefined( self.var_183d02c9ee4eaa73 ) )
    {
        zombie_attractor_manager::remove_attractor( self.var_183d02c9ee4eaa73 );
    }
    
    self notify( #"shower_valve_off" );
}

// Namespace namespace_82ef26b728b2fd29
// Params 2, eflags: 0x4
// Checksum 0x3d2b23b5, Offset: 0x629f
// Size: 0xa5, Type: bool
function private function_5646ba5fd88204a2( attractor, zombie )
{
    if ( !isalive( zombie ) || !isdefined( attractor ) )
    {
        return false;
    }
    
    if ( zombie utility::ent_flag( "scene_active" ) )
    {
        return false;
    }
    
    if ( zombie.stealth_bsmstate == 3 )
    {
        return false;
    }
    
    var_2f17175b25d497ef = undefined;
    
    if ( isdefined( level.var_5a646ea8e8b153df ) )
    {
        var_2f17175b25d497ef = gemini_util::function_45725eed211aafdf( attractor.source.origin );
        
        if ( isdefined( var_2f17175b25d497ef ) && !ispointinvolume( zombie.origin, var_2f17175b25d497ef ) )
        {
            return false;
        }
    }
    
    return true;
}

