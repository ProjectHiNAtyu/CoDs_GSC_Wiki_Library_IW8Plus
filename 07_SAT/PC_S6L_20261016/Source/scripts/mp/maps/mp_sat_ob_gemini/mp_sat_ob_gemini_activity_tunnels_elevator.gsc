// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_tunnels_elevator.gsc  (hash_7ad899c689ee68a8.gscc) (size: 30165 Bytes / 0x75d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa49a922c (2761593388)
// size ...... 30165 (0x75d5)
// includes .. 25  (offset: 0x6ca9)
// strings ... 129 (offset: 0x6d71)
// dev strs .. 3   (offset: 0x75b1)
// exports ... 53  (offset: 0x471d)
// cseg ...... 0x1082 + 0x369b (0x471d)
// imports ... 230 (offset: 0x4f65)
// animtree1 . 0   (offset: 0x75d5)
// animtree2 . 0   (offset: 0x75d5)
#using script_16d8789bae43669e;
#using script_2399696a9d953451;
#using script_2cd07641bf71242a;
#using script_4c1e16e1162d066f;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_tunnels_mine;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_audio;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\objidpoolmanager;

#namespace namespace_51f35399a137ca44;

/#

    // Namespace namespace_51f35399a137ca44
    // Params 0
    // Checksum 0x650ec51a, Offset: 0x10a0
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_51f35399a137ca44
// Params 0, eflags: 0x5
// Checksum 0xa81a4ead, Offset: 0x10ad
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8d04ec3f17e6cf7a", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_51f35399a137ca44
// Params 0, eflags: 0x4
// Checksum 0xb65ad208, Offset: 0x10d6
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_TUNNELS_ELEVATOR";
    activity_common::registeractivitytype( "OB_GEMINI_TUNNELS_ELEVATOR", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_ELEVATOR", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_ELEVATOR", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_ELEVATOR", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_TUNNELS_ELEVATOR" );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xccd65367, Offset: 0x114d
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance tunnels_elevator_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0x6eccb0a4, Offset: 0x11ae
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance tunnels_elevator_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xf8395ee5, Offset: 0x11ef
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_51f35399a137ca44
// Params 1
// Checksum 0xe9eb1575, Offset: 0x1213
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread tunnels_elevator_player_setup( player );
    }
}

/#

    // Namespace namespace_51f35399a137ca44
    // Params 0
    // Checksum 0x22b4610a, Offset: 0x12cf
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0x16438cc, Offset: 0x12dc
// Size: 0x70
function tunnels_elevator_start()
{
    activity_instance = self;
    ob_story_mission_utils::function_6314f03dfe2adbc5();
    activity_instance thread ob_story_mission_utils::objective_marker_clear_all();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_tunnels_elevator_weapon", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_tunnels_elevator_equipment", undefined, 1 );
    level thread gemini_util::function_85abe3355f8a3cce();
    level ob_adz::function_86ebf122bc776db5();
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
    level thread function_944d4c5bc75e91b2();
    activity_instance thread gemini_util::function_e9681bbfa6c91f07();
}

// Namespace namespace_51f35399a137ca44
// Params 1
// Checksum 0x8725f67c, Offset: 0x1354
// Size: 0x3b
function tunnels_elevator_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
    }
    
    activity_instance thread function_de7840b0396c3b46( player );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xdf9628ec, Offset: 0x1397
// Size: 0xea
function tunnels_elevator_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    waitframe();
    
    /#
        activity_instance thread gemini_util::function_d6c199899ef5b468( "<dev string:x24>", "<dev string:x3f>", "<dev string:x5e>" );
    #/
    
    waitframe();
    level.var_d53163b0ef2a4488 = 1;
    activity_instance thread gemini_util::function_501b62568cd67932();
    activity_instance childthread gemini_vo::function_13b9746340f97f39();
    activity_instance childthread function_6bed4bbe5356b63e();
    activity_instance thread tunnels_elevator_screen_setup();
    level thread function_816d8aa43719bb15();
    level thread function_9f0b77c65bbda685();
    level thread function_8b0402e1f1633648();
    level thread function_1ee6a6f459caeeca();
    activity_instance thread function_5ca44e817f31f6c8();
    activity_instance thread gemini_util::function_a9376b156b863dd4( "trig_tunnels_elevator_vermin_vent", "flag_tunnels_elevator_complete" );
    activity_instance thread function_44594a959fd8647c();
    utility::flag_wait( "flag_trig_tunnels_elevator_exit" );
    ob_story_mission_utils::set_revive_spawns();
    utility::flag_set( "flag_tunnels_elevator_complete" );
    activity_instance gemini_util::function_97b700689f1e4cbd();
}

/#

    // Namespace namespace_51f35399a137ca44
    // Params 0
    // Checksum 0xd3b55ec6, Offset: 0x1489
    // Size: 0x5, Type: dev
    function function_904e7b132defb308()
    {
        
    }

#/

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xd3a9b78, Offset: 0x1496
// Size: 0x526
function function_44594a959fd8647c()
{
    level endon( #"game_ended" );
    activity_instance = self;
    level.tunnels_elevator = elevator_moving_init( "e_tunnels_elevator_moving", "flag_tunnels_pit_complete" );
    
    if ( !isdefined( level.tunnels_elevator ) )
    {
        return;
    }
    
    level.tunnels_elevator endon( #"death" );
    var_49a2c380119ba5e = utility::getstruct( "s_tunnels_elevator_moving_top", "targetname" );
    var_ca2f59b877fa6720 = utility::getstruct( "s_tunnels_elevator_moving_bottom", "targetname" );
    e_gate_top = function_177236bdf48d2aa1( "e_elevator_gate_top" );
    utility::flag_wait( "flag_tunnels_elevator_interact" );
    earthquake( 0.2, 0.2, var_49a2c380119ba5e.origin, 3072 );
    playrumbleonposition( "damage_light", var_49a2c380119ba5e.origin );
    level.tunnels_elevator thread elevator_moving_toggle_lights( "ascent" );
    var_37abe93f965fa96e = 60;
    var_cc8bd0455387cd81 = var_37abe93f965fa96e * 0.25;
    var_d8bd85457ff6592c = var_37abe93f965fa96e * 0.25;
    level.tunnels_elevator moveto( var_49a2c380119ba5e.origin, var_37abe93f965fa96e, var_cc8bd0455387cd81, var_cc8bd0455387cd81 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_ascend_progress_01", var_37abe93f965fa96e * 0.25 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_ascend_progress_02", var_37abe93f965fa96e * 0.5 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_ascend_progress_03", var_37abe93f965fa96e * 0.75 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_ascend_progress_04", var_37abe93f965fa96e * 0.9 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_ascend_progress_05", var_37abe93f965fa96e );
    level.tunnels_elevator thread function_ceccb3b611a81b6f( "flag_tunnels_elevator_ascend_progress_04" );
    level.tunnels_elevator thread gemini_audio::function_9adf1cb798d0abfa();
    wait var_37abe93f965fa96e;
    utility::flag_set( "flag_audio_tunnels_elevator_buzzer" );
    level.tunnels_elevator thread elevator_moving_toggle_lights( "ascent_end" );
    earthquake( 0.5, 0.5, level.tunnels_elevator.origin, 2048 );
    playrumbleonposition( "grenade_rumble", level.tunnels_elevator.origin );
    wait 1;
    utility::flag_set( "flag_tunnels_elevator_ascend_end" );
    e_gate_top elevator_gate_open( "flag_tunnels_elevator_gate_top_open" );
    level.tunnels_elevator function_319a23379572a316( "enter", 1, 1 );
    utility::flag_wait( "flag_trig_tunnels_elevator_enter" );
    activity_instance thread namespace_1f3f9eb1e9681da5::function_9dbeaf9ca833864( activity_instance, "player_catchup_tunnels_elevator", "flag_elevator_player_catchup_complete", 5, "flag_tunnels_elevator_pre_teleport" );
    utility::flag_wait( "flag_tunnels_elevator_pre_teleport" );
    utility::flag_set( "flag_tunnels_elevator_descend_start" );
    activity_instance thread function_1f165afea0ebacd7( "trig_tunnels_elevator_vermin_delete", "flag_tunnels_elevator_complete" );
    level.tunnels_elevator function_319a23379572a316( "enter", 0, 1 );
    var_7e7dc3f64e33360a = utility::getstructarray( "tunnels_elevator_override_respawn", "targetname" );
    
    if ( isdefined( var_7e7dc3f64e33360a ) )
    {
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
    
    utility::flag_wait( "flag_elevator_player_catchup_complete" );
    earthquake( 0.5, 0.5, level.tunnels_elevator.origin, 2048 );
    playrumbleonposition( "grenade_rumble", level.tunnels_elevator.origin );
    level.tunnels_elevator thread elevator_moving_toggle_lights( "descent" );
    level.tunnels_elevator thread function_c3ecbc8b0ffc210c();
    var_db61c5c35a8acd2e = 30;
    var_145ceea952a9eb41 = var_db61c5c35a8acd2e * 0.25;
    var_a30aa3b42216d4ec = var_db61c5c35a8acd2e * 0.25;
    level.tunnels_elevator moveto( var_ca2f59b877fa6720.origin, var_db61c5c35a8acd2e, var_145ceea952a9eb41, var_a30aa3b42216d4ec );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_descend_progress_01", var_db61c5c35a8acd2e * 0.2 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_descend_progress_02", var_db61c5c35a8acd2e * 0.35 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_descend_progress_03", var_db61c5c35a8acd2e * 0.5 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_descend_progress_04", var_db61c5c35a8acd2e * 0.65 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_descend_progress_05", var_db61c5c35a8acd2e * 0.8 );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_descend_progress_06", var_db61c5c35a8acd2e * 0.95 );
    level.tunnels_elevator thread function_ceccb3b611a81b6f( "flag_tunnels_elevator_descend_progress_06" );
    activity_instance thread function_ee0e6351ffb93f97();
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "s_tunnels_mine_cache" );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_tunnels_mine_weapon", "flag_tunnels_pit_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_tunnels_mine_equipment", "flag_tunnels_pit_complete", 1 );
    wait var_db61c5c35a8acd2e;
    utility::flag_set( "flag_tunnels_elevator_descend_end" );
    level.tunnels_elevator thread elevator_moving_toggle_lights( "descent_end" );
    earthquake( 0.5, 0.5, level.tunnels_elevator.origin, 2048 );
    playrumbleonposition( "grenade_rumble", level.tunnels_elevator.origin );
    wait 1;
    level.tunnels_elevator function_319a23379572a316( "exit", 1, 1 );
    level utility::flag_set( "flag_tunnels_elevator_gate_bottom_open" );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xe6a428b, Offset: 0x19c4
// Size: 0x12d
function function_c3ecbc8b0ffc210c()
{
    level endon( #"game_ended", #"flag_tunnels_elevator_descend_end" );
    
    while ( !utility::flag( "flag_tunnels_elevator_descend_end" ) )
    {
        var_35a76b9286aef10b = getaiarrayinradius( self.origin, 160 );
        
        if ( var_35a76b9286aef10b.size > 0 )
        {
            foreach ( var_7654d704b9415bab in var_35a76b9286aef10b )
            {
                if ( !isalive( var_7654d704b9415bab ) )
                {
                    continue;
                }
                
                if ( var_7654d704b9415bab.type != "zombie" )
                {
                    continue;
                }
                
                var_7654d704b9415bab.var_a13bed1ac47e1b2c = 1;
                var_7654d704b9415bab.allowdeath = 1;
                
                if ( var_7654d704b9415bab.subclass != "zombie_base" )
                {
                    var_7654d704b9415bab zombie_base_dismemberment::annihilate();
                }
                else
                {
                    var_7654d704b9415bab zombie_base_dismemberment::function_61b75f09c6601780();
                }
                
                var_7654d704b9415bab kill();
                waitframe();
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xfcd711d6, Offset: 0x1af9
// Size: 0x2e
function function_8b0402e1f1633648()
{
    level utility::flag_wait( "flag_tunnels_elevator_defend_start" );
    level thread gemini_util::function_6ba38d8e858007a9();
    playsoundatpos( ( 3917, -3209, -38 ), "evt_gem_cradle_stinger" );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0x4932bc41, Offset: 0x1b2f
// Size: 0x35
function function_944d4c5bc75e91b2()
{
    level utility::flag_wait( "scriptables_ready" );
    var_12dad7deb9f58051 = gemini_util::security_gate_init( "e_tunnels_anteroom_gate" );
    waitframe();
    var_12dad7deb9f58051 gemini_util::security_gate_open( "e_tunnels_anteroom_gate" );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xd430dbb9, Offset: 0x1b6c
// Size: 0x7d
function tunnels_elevator_screen_setup()
{
    level endon( #"game_ended" );
    activity_instance = self;
    a_screens = level gemini_util::function_401a0ddccdf00715( "tunnels_elevator_screen_02" );
    waitframe();
    activity_instance thread gemini_util::function_1a2dee7491815110( "flag_tunnels_elevator_screen_02_start", "sat_gemini_monitor_alex_1", "bink2", 1, "tunnels_elevator_screen_02", "flag_tunnels_elevator_screen_02_end", "flag_tunnels_elevator_screen_02_stop", "OB_GEMINI_TUNNELS_ELEVATOR_DEFEND", "OB_GEMINI_TUNNELS_ELEVATOR_TWISTED_SUCCUMB" );
    utility::array_thread( a_screens, &function_939fd07a8de101e3, "flag_tunnels_elevator_defend_start", "flag_tunnels_elevator_complete" );
}

// Namespace namespace_51f35399a137ca44
// Params 3
// Checksum 0x360fb714, Offset: 0x1bf1
// Size: 0xcb
function function_939fd07a8de101e3( wait_for_flag, var_68b32a8bafee7061, n_add_dist = 256 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( var_68b32a8bafee7061 ) )
    {
        if ( level utility::flag( var_68b32a8bafee7061 ) )
        {
            return;
        }
        
        level endon( var_68b32a8bafee7061 );
    }
    
    if ( isdefined( wait_for_flag ) )
    {
        level utility::flag_wait( wait_for_flag );
    }
    
    while ( true )
    {
        var_b6081b1b6ba5e8b5 = distance2d( self.origin, level.tunnels_mine_adz.origin );
        
        if ( var_b6081b1b6ba5e8b5 < level.tunnels_mine_adz.radius + n_add_dist )
        {
            break;
        }
        
        wait randomfloatrange( 1, 3 );
    }
    
    self scriptabledodamage( 100000 );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0x627cad96, Offset: 0x1cc4
// Size: 0x93
function function_816d8aa43719bb15()
{
    level endon( #"game_ended" );
    var_576b719878bde16f = gemini_util::get_scriptable( "e_tunnels_elevator_interact" );
    interaction::register_scriptable_interact( var_576b719878bde16f, &function_6adf398d9be1a9bc );
    var_576b719878bde16f thread gemini_util::function_48742f1029c7bf98();
    var_576b719878bde16f waittill( #"elevator_interact_complete" );
    level utility::flag_set( "flag_tunnels_elevator_interact" );
    level thread utility::flag_set_delayed( "flag_tunnels_elevator_screen_02_start", 3 );
    waitframe();
    level utility::flag_wait( "flag_tunnels_elevator_gate_top_open" );
    var_576b719878bde16f utility::function_7c10ea82c1e305b8( "base", "console_on" );
    var_576b719878bde16f thread gemini_util::function_5e8819aede1d0d5();
}

// Namespace namespace_51f35399a137ca44
// Params 1, eflags: 0x4
// Checksum 0x6563911e, Offset: 0x1d5f
// Size: 0x15
function private function_6adf398d9be1a9bc( player )
{
    thread tunnels_elevator_interact_used( player );
}

// Namespace namespace_51f35399a137ca44
// Params 1
// Checksum 0xe0a1d407, Offset: 0x1d7c
// Size: 0x42
function tunnels_elevator_interact_used( player )
{
    player gemini_util::function_bee9a4fd918f536d( self );
    utility::function_7c10ea82c1e305b8( "base", "console_waiting" );
    wait 0.5;
    self notify( #"elevator_interact_complete" );
    thread gemini_util::function_bfd9527bf6fdca81( 1 );
}

// Namespace namespace_51f35399a137ca44
// Params 1
// Checksum 0x270ebb24, Offset: 0x1dc6
// Size: 0xe4
function function_ceccb3b611a81b6f( flag_endon )
{
    level endon( #"game_ended", flag_endon );
    scalemax = 0.12;
    scalemid = 0.085;
    scalemin = 0.015;
    duration = 0.05;
    var_580574f0db8788d7 = 600;
    var_a11371b365e79f0b = 1200;
    var_7ce6f6496ccb5f95 = 2400;
    count = 0;
    interval = 30;
    
    while ( !level utility::flag( flag_endon ) )
    {
        earthquakeadvanced( scalemax, scalemid, scalemin, duration, self.origin, var_580574f0db8788d7, var_a11371b365e79f0b, var_7ce6f6496ccb5f95 );
        count++;
        
        if ( count >= interval )
        {
            playrumbleonposition( "damage_light", self.origin );
            count = 0;
        }
        
        wait 0.05;
    }
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xaf128fb2, Offset: 0x1eb2
// Size: 0x116
function function_1ee6a6f459caeeca()
{
    level endon( #"game_ended" );
    var_b2f8e5c576d3e25f = getnodearray( "nd_tunnels_elevator_enter_traversal", #script_noteworthy );
    
    if ( var_b2f8e5c576d3e25f.size == 0 )
    {
        return;
    }
    
    foreach ( node in var_b2f8e5c576d3e25f )
    {
        node disconnectnode();
    }
    
    level utility::flag_wait( "flag_tunnels_elevator_descend_progress_02" );
    
    foreach ( node in var_b2f8e5c576d3e25f )
    {
        node connectnode();
    }
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xd423c53a, Offset: 0x1fd0
// Size: 0x106
function function_9f0b77c65bbda685()
{
    level endon( #"game_ended" );
    level ob_adz::function_86ebf122bc776db5();
    level utility::flag_wait( "flag_tunnels_elevator_screen_02_stop" );
    
    if ( !isdefined( level.tunnels_mine_adz ) )
    {
        level.tunnels_mine_adz = ob_adz::function_47e86714392d46b4( "s_tunnels_mine_adz_01", 320 );
        level.tunnels_mine_adz thread ob_adz::function_f0f0de6800121e38( "flag_tunnels_pit_complete", level.tunnels_mine_adz.zone_id );
    }
    
    level utility::flag_wait( "flag_tunnels_elevator_defend_start" );
    level thread function_36baeb39b0246b09();
    level.tunnels_mine_adz thread ob_adz::function_f94c18166de9f51d( "s_tunnels_mine_adz_01", undefined, 1400, 105 );
    level utility::flag_wait( "flag_tunnels_elevator_descend_start" );
    transform_diff = 1400 - level.tunnels_mine_adz.radius;
    transform_duration = 60 - transform_diff * 0.01;
    level.tunnels_mine_adz thread ob_adz::function_f94c18166de9f51d( "s_tunnels_mine_adz_01", undefined, 3000, transform_duration );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xcf605aef, Offset: 0x20de
// Size: 0xe0
function function_36baeb39b0246b09()
{
    s_enc_scene = utility::getstruct( "scene_tunnels_elevator_zombie_01", "targetname" );
    wait 1;
    var_64250342fb4fe6a6 = utility::spawn_tag_origin();
    var_64250342fb4fe6a6.origin = s_enc_scene.origin;
    var_64250342fb4fe6a6.angles = s_enc_scene.angles;
    var_64250342fb4fe6a6 show();
    waitframe();
    playfxontag( utility::getfx( "vfx_cradle_burst" ), var_64250342fb4fe6a6, "tag_origin" );
    earthquake( 0.25, 1, s_enc_scene.origin, 1000 );
    playrumbleonposition( "artillery_rumble_light", s_enc_scene.origin );
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", 3, undefined, level.players );
    level utility::flag_wait( "flag_tunnels_elevator_complete" );
    var_64250342fb4fe6a6 delete();
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0x3b689ba3, Offset: 0x21c6
// Size: 0x466
function function_5ca44e817f31f6c8()
{
    activity_instance = self;
    level utility::flag_wait( "flag_tunnels_elevator_interact" );
    n_start_time = gettime();
    level utility::flag_wait( "flag_tunnels_elevator_defend_start" );
    wait 10;
    level utility::flag_set( "flag_tunnels_elevator_ambush_start" );
    n_remaining_time = 60 - utility::function_6f5d2e1f1ff70482( gettime() - n_start_time );
    s_enc_scene = utility::getstruct( "scene_tunnels_elevator_zombie_01", "targetname" );
    s_enc_scene gemini_util::function_7240d161be9ac7b4( activity_instance, "flag_tunnels_elevator_descend_start" );
    s_enc_scene scene::add_spawn_function( &function_49dac5068aeec5c9, "_object_all_" );
    s_enc_scene thread gemini_util::scene_zombie_cleanup( "flag_tunnels_elevator_descend_start" );
    level thread namespace_b109f7cb70e0649d::function_55b6201062a883e4( "scriptable_tunnels_hub_gate_01" );
    waitframe();
    s_enc_scene thread scene::play( undefined, "enter" );
    var_45f484b460853312 = activity_instance gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_zombie_flood_01", &function_4699858bc9b24c71, 1, "flag_tunnels_elevator_complete" );
    ai_spawn_director::function_c99d360d62c49a9c( var_45f484b460853312, &function_26331ee33c0f933c );
    ai_spawn_director::function_53289c032f506bb1( var_45f484b460853312, &function_f8004ca7e67c4daa );
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_count = 5;
        n_spawn_cadence = 2;
    }
    else
    {
        n_max_count = 8;
        n_spawn_cadence = 1;
    }
    
    function_bbd192652d1a9e18( var_45f484b460853312, n_max_count );
    function_a748fd0f51127844( var_45f484b460853312, n_spawn_cadence );
    wait clamp( n_remaining_time * 0.3, 8, 12 );
    level thread namespace_b109f7cb70e0649d::function_55b6201062a883e4( "scriptable_tunnels_hub_gate_02" );
    waitframe();
    var_45f483b4608530df = activity_instance gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_zombie_flood_02", &function_4699858bc9b24c71, 0, "flag_tunnels_elevator_complete" );
    ai_spawn_director::function_c99d360d62c49a9c( var_45f483b4608530df, &function_26331ee33c0f933c );
    ai_spawn_director::function_53289c032f506bb1( var_45f483b4608530df, &function_f8004ca7e67c4daa );
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_count = 3;
        var_750c21171a7d778e = 1;
        n_spawn_cadence = 2;
    }
    else
    {
        n_max_count = 5;
        var_750c21171a7d778e = 2;
        n_spawn_cadence = 1;
    }
    
    function_bbd192652d1a9e18( var_45f483b4608530df, n_max_count );
    function_a748fd0f51127844( var_45f483b4608530df, n_spawn_cadence );
    waitframe();
    var_b5331f7c92e475f9 = activity_instance gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_vermin_flood_01", &function_4699858bc9b24c71, 0, "flag_tunnels_elevator_complete" );
    ai_spawn_director::function_c99d360d62c49a9c( var_b5331f7c92e475f9, &function_26331ee33c0f933c );
    ai_spawn_director::function_53289c032f506bb1( var_b5331f7c92e475f9, &function_f8004ca7e67c4daa );
    function_bbd192652d1a9e18( var_b5331f7c92e475f9, var_750c21171a7d778e );
    function_a748fd0f51127844( var_b5331f7c92e475f9, n_spawn_cadence * 2 );
    waitframe();
    var_b5331c7c92e46f60 = activity_instance gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_vermin_flood_02", &function_4699858bc9b24c71, 0, "flag_tunnels_elevator_complete" );
    ai_spawn_director::function_c99d360d62c49a9c( var_b5331c7c92e46f60, &function_26331ee33c0f933c );
    ai_spawn_director::function_53289c032f506bb1( var_b5331c7c92e46f60, &function_f8004ca7e67c4daa );
    function_bbd192652d1a9e18( var_b5331c7c92e46f60, var_750c21171a7d778e );
    function_a748fd0f51127844( var_b5331c7c92e46f60, n_spawn_cadence * 2 );
    wait clamp( n_remaining_time * 0.4, 10, 15 );
    var_45f482b460852eac = activity_instance gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_zombie_flood_03", &function_4699858bc9b24c71, 1, "flag_tunnels_elevator_complete" );
    ai_spawn_director::function_c99d360d62c49a9c( var_45f482b460852eac, &function_26331ee33c0f933c );
    ai_spawn_director::function_53289c032f506bb1( var_45f482b460852eac, &function_f8004ca7e67c4daa );
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_count = 3;
        var_750c21171a7d778e = 1;
        n_spawn_cadence = 2;
    }
    else
    {
        n_max_count = 5;
        var_750c21171a7d778e = 2;
        n_spawn_cadence = 1;
    }
    
    function_bbd192652d1a9e18( var_45f482b460852eac, n_max_count );
    function_a748fd0f51127844( var_45f482b460852eac, n_spawn_cadence );
    waitframe();
    var_b5331d7c92e47193 = activity_instance gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_vermin_flood_03", &function_4699858bc9b24c71, 0, "flag_tunnels_elevator_complete" );
    ai_spawn_director::function_c99d360d62c49a9c( var_b5331d7c92e47193, &function_26331ee33c0f933c );
    ai_spawn_director::function_53289c032f506bb1( var_b5331d7c92e47193, &function_f8004ca7e67c4daa );
    function_bbd192652d1a9e18( var_b5331d7c92e47193, var_750c21171a7d778e );
    function_a748fd0f51127844( var_b5331d7c92e47193, n_spawn_cadence * 2 );
    utility::flag_wait( "flag_tunnels_elevator_ascend_end" );
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_count = 3;
        var_6e873e1a5c46fc8f = 1;
    }
    else
    {
        n_max_count = 5;
        var_6e873e1a5c46fc8f = 2;
    }
    
    function_bbd192652d1a9e18( var_b5331f7c92e475f9, var_6e873e1a5c46fc8f );
    function_bbd192652d1a9e18( var_45f484b460853312, n_max_count );
    function_bbd192652d1a9e18( var_45f482b460852eac, n_max_count );
    utility::flag_wait( "flag_trig_tunnels_elevator_enter" );
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_count = 2;
    }
    else
    {
        n_max_count = 3;
    }
    
    function_bbd192652d1a9e18( var_b5331c7c92e46f60, n_max_count );
    function_bbd192652d1a9e18( var_45f483b4608530df, n_max_count );
    function_bbd192652d1a9e18( var_b5331d7c92e47193, n_max_count );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xebfb61e3, Offset: 0x2634
// Size: 0x113
function function_49dac5068aeec5c9()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct gemini_util::function_d65cdd8f6bd452b( self );
    self.team = "team_two_hundred";
    
    if ( utility::percent_chance( 75 ) )
    {
        move_speed = "run";
    }
    else
    {
        move_speed = "walk";
    }
    
    val::set( "zombie_elevator", "allow_unreachable_attack", 0 );
    zombie_utils::function_a8ce00e0448cb6f0( move_speed, "elevator_defend", 25 );
    level utility::flag_wait( "flag_tunnels_elevator_descend_end" );
    trig = getnoentvolumearray( "trig_tunnels_elevator_ai_check", #targetname )[ 0 ];
    
    if ( utility::ent_flag( "adz_active" ) || isdefined( trig ) && self istouching( trig ) )
    {
        zombie_base_dismemberment::function_61b75f09c6601780();
        gemini_util::function_6db88e9571f4e393();
        return;
    }
    
    gemini_util::ai_nerf();
    thread gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_51f35399a137ca44
// Params 4
// Checksum 0x209e869f, Offset: 0x274f
// Size: 0x262
function function_4699858bc9b24c71( request_id, data, agent, ai_data )
{
    agent endon( #"death" );
    
    if ( !isdefined( data ) )
    {
        data = 0;
    }
    
    agent zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    agent gemini_util::function_54a189c04c75a149( 1, 2048 );
    player_target = gemini_util::function_1ff93f2b1149dd76( agent.origin, 1024, 0 );
    
    if ( isdefined( player_target ) )
    {
        agent zombie_utils::set_ai_target_priority( player_target );
    }
    
    if ( agent.subclass == "zombie_vermin" )
    {
        agent zombie_traverse_asm::function_85b354b1fada24eb();
        agent function_786bb6aa1b76c7ee( "can_ranged_attack", 0 );
        agent function_786bb6aa1b76c7ee( "wallCrawlRangedAttackRange", 1 );
        agent.var_720018aa0a425283 = 0;
        agent.var_61f7cb9d1effbf0a = 0;
        agent zombie_utils::function_a8ce00e0448cb6f0( "walk", "elevator_defend", 25 );
        level utility::flag_wait( "flag_tunnels_elevator_descend_progress_02" );
        s_attractor = utility::getstruct( "s_tunnels_elevator_exit_attractor", "targetname" );
        
        if ( !isdefined( s_attractor ) )
        {
            s_attractor = utility::getstruct( "s_obj_tunnels_elevator_exit", "targetname" );
        }
        
        agent zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_attractor, 3 );
        level utility::flag_wait( "flag_tunnels_elevator_descend_end" );
        agent zombie_attractor_manager::function_dcfb4c31f1d97cd2( s_attractor );
    }
    else if ( agent.subclass == "zombie_base_armored_heavy" )
    {
        agent val::set( "zombie_elevator", "allow_unreachable_attack", 0 );
        move_speed = "walk";
    }
    else
    {
        agent val::set( "zombie_elevator", "allow_unreachable_attack", 0 );
        
        if ( data && utility::percent_chance( 25 ) )
        {
            move_speed = "run";
        }
        else
        {
            move_speed = "walk";
        }
    }
    
    agent zombie_utils::function_a8ce00e0448cb6f0( move_speed, "elevator_defend", 25 );
    level utility::flag_wait( "flag_tunnels_elevator_descend_end" );
    trig = getnoentvolumearray( "trig_tunnels_elevator_ai_check", #targetname )[ 0 ];
    
    if ( agent utility::ent_flag( "adz_active" ) || isdefined( trig ) && agent istouching( trig ) )
    {
        wait randomfloatrange( 1, 3 );
        agent zombie_base_dismemberment::function_61b75f09c6601780();
        agent gemini_util::function_6db88e9571f4e393();
        return;
    }
    
    agent gemini_util::ai_nerf();
    agent thread gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_51f35399a137ca44
// Params 2
// Checksum 0x6f33b5c2, Offset: 0x29b9
// Size: 0x17, Type: bool
function function_26331ee33c0f933c( requestid, userdata )
{
    return true;
}

// Namespace namespace_51f35399a137ca44
// Params 2
// Checksum 0xe25d7f4, Offset: 0x29d9
// Size: 0x28, Type: bool
function function_f8004ca7e67c4daa( requestid, userdata )
{
    if ( level utility::flag( "flag_tunnels_elevator_descend_start" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0xf2c02ab4, Offset: 0x2a0a
// Size: 0x112
function function_ee0e6351ffb93f97()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level utility::flag_wait( "flag_tunnels_elevator_descend_progress_01" );
    var_53131558421e7435 = gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_zombie_01", &function_1f9300f2599dcd75, undefined, "flag_tunnels_elevator_complete" );
    level utility::flag_wait( "flag_tunnels_elevator_descend_progress_02" );
    utility::flag_set( "flag_tunnels_elevator_vermin_chase_begin" );
    var_53131258421e6d9c = gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_zombie_02", &function_1f9300f2599dcd75, undefined, "flag_tunnels_elevator_complete" );
    level utility::flag_wait( "flag_tunnels_elevator_descend_progress_03" );
    var_53131358421e6fcf = gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_zombie_03", &function_1f9300f2599dcd75, undefined, "flag_tunnels_elevator_complete" );
    level utility::flag_wait( "flag_tunnels_elevator_descend_progress_04" );
    var_53131058421e6936 = gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_zombie_04", &function_1f9300f2599dcd75, undefined, "flag_tunnels_elevator_complete" );
    level utility::flag_wait( "flag_tunnels_elevator_descend_progress_05" );
    var_53131158421e6b69 = gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_elevator_zombie_05", &function_1f9300f2599dcd75, undefined, "flag_tunnels_elevator_complete" );
}

// Namespace namespace_51f35399a137ca44
// Params 4
// Checksum 0xe82190ac, Offset: 0x2b24
// Size: 0x110
function function_1f9300f2599dcd75( request_id, data, agent, ai_data )
{
    agent endon( #"death" );
    agent thread function_1e0b38f5bf52a244();
    agent thread function_34758aa46cd808ec();
    agent zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    agent gemini_util::function_54a189c04c75a149( 1, 2048 );
    agent zombie_utils::function_a8ce00e0448cb6f0( "walk", "elevator_chase", 25 );
    level utility::flag_wait( "flag_tunnels_elevator_descend_end" );
    trig = getnoentvolumearray( "trig_tunnels_elevator_ai_check", #targetname )[ 0 ];
    
    if ( agent utility::ent_flag( "adz_active" ) || isdefined( trig ) && agent istouching( trig ) && utility::cointoss() )
    {
        wait randomfloatrange( 1, 3 );
        agent zombie_base_dismemberment::function_61b75f09c6601780();
        agent gemini_util::function_6db88e9571f4e393();
        return;
    }
    
    agent gemini_util::ai_nerf();
    agent thread gemini_util::ai_delete_when_out_of_sight( 768, 2048 );
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0x1f7d7c2f, Offset: 0x2c3c
// Size: 0xc4
function function_1e0b38f5bf52a244()
{
    self endon( #"death" );
    self.var_7f8ab9bb9f4957fc = &gemini_util::function_938edcc75e2bb90f;
    zombie_traverse_asm::function_f767340ef0691f12( randomintrange( 600, 800 ) );
    var_ca762e8e1af4044f = 6;
    a_players = ob_story_mission_utils::get_playing_players();
    
    if ( a_players.size > 2 )
    {
        var_ca762e8e1af4044f = 9;
    }
    
    zombie_traverse_asm::function_fba2da16d6f649b9( var_ca762e8e1af4044f );
    self._blackboard.var_d751dec818290f98 = 1;
    zombie_traverse_asm::function_85b354b1fada24eb();
    wait randomfloatrange( 1, 9 );
    
    if ( !level utility::flag( "flag_tunnels_elevator_descend_progress_05" ) )
    {
        zombie_traverse_asm::function_cb2386722e58be36();
        utility::waittill_any_ents( level, "flag_tunnels_elevator_descend_progress_05", self, "launch_grenade_start" );
        zombie_traverse_asm::function_85b354b1fada24eb();
    }
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0x9d1eb6d7, Offset: 0x2d08
// Size: 0x1af
function function_34758aa46cd808ec()
{
    self endon( #"death" );
    
    if ( isdefined( self.directorspawndata.target ) )
    {
        s_attractor = utility::getstruct( self.directorspawndata.target, "targetname" );
    }
    else
    {
        s_attractor = utility::getstruct( "s_tunnels_elevator_exit_attractor", "targetname" );
        
        if ( !isdefined( s_attractor ) )
        {
            s_attractor = utility::getstruct( "s_obj_tunnels_elevator_exit", "targetname" );
        }
    }
    
    zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_attractor, 3 );
    zombie_utils::function_a8ce00e0448cb6f0( "walk", "elevator_chase", 25 );
    var_a94f4e0bb0688cba = 0;
    var_1a9df1839526f3d8 = squared( 160 );
    var_b1ecfd964eadc9a3 = squared( 480 );
    
    while ( !level utility::flag( "flag_tunnels_elevator_descend_end" ) )
    {
        if ( !isdefined( level.tunnels_elevator ) )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( level.tunnels_elevator ) )
        {
            dist_sq = distancesquared( self.origin, level.tunnels_elevator.origin );
        }
        else
        {
            dist_sq = 0;
        }
        
        if ( dist_sq < var_1a9df1839526f3d8 )
        {
            zombie_stun::stun_ai( 1 );
        }
        else if ( var_a94f4e0bb0688cba && dist_sq <= var_b1ecfd964eadc9a3 )
        {
            zombie_utils::function_a8ce00e0448cb6f0( "walk", "elevator_chase", 25 );
            var_a94f4e0bb0688cba = 0;
        }
        else if ( !var_a94f4e0bb0688cba && dist_sq > var_b1ecfd964eadc9a3 )
        {
            zombie_utils::function_a8ce00e0448cb6f0( "run", "elevator_chase", 25 );
            var_a94f4e0bb0688cba = 1;
        }
        
        wait 1;
    }
    
    zombie_attractor_manager::function_dcfb4c31f1d97cd2( s_attractor );
    zombie_utils::function_a8ce00e0448cb6f0( "run", "elevator_chase", 25 );
}

// Namespace namespace_51f35399a137ca44
// Params 2
// Checksum 0x13e85429, Offset: 0x2ebf
// Size: 0xc9
function function_1f165afea0ebacd7( trig_targetname, flag_endon )
{
    activity_instance = self;
    
    if ( isdefined( flag_endon ) )
    {
        if ( level utility::flag( flag_endon ) )
        {
            return;
        }
    }
    
    a_trig_noent = getnoentvolumearray( trig_targetname, #targetname );
    
    if ( a_trig_noent.size == 0 )
    {
        return;
    }
    
    foreach ( trig in a_trig_noent )
    {
        activity_instance thread function_1e198acbc5d29f21( trig, flag_endon );
    }
}

// Namespace namespace_51f35399a137ca44
// Params 2, eflags: 0x4
// Checksum 0xffd5bf4f, Offset: 0x2f90
// Size: 0xac
function private function_1e198acbc5d29f21( trig, flag_endon )
{
    level endon( #"game_ended", flag_endon );
    
    if ( isdefined( flag_endon ) )
    {
        level endon( flag_endon );
    }
    
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    while ( true )
    {
        trig waittill( #"trigger", data );
        
        if ( isagent( data ) && data.type == "zombie" )
        {
            break;
        }
    }
    
    if ( isdefined( data ) )
    {
        data gemini_util::ai_delete_when_out_of_sight( 64, 512, 0.766, 0 );
    }
}

/#

    // Namespace namespace_51f35399a137ca44
    // Params 0
    // Checksum 0x31db7cb0, Offset: 0x3044
    // Size: 0x5, Type: dev
    function function_f396bb96c222c46a()
    {
        
    }

#/

// Namespace namespace_51f35399a137ca44
// Params 1
// Checksum 0x677e5574, Offset: 0x3051
// Size: 0x123
function function_177236bdf48d2aa1( gate_targetname )
{
    var_12dad7deb9f58051 = getent( gate_targetname, #targetname );
    a_e_gate[ 0 ] = var_12dad7deb9f58051;
    var_caa7aa2029afcc8b = var_12dad7deb9f58051 utility::get_linked_ents();
    var_12dad7deb9f58051.var_caa7aa2029afcc8b = var_caa7aa2029afcc8b;
    
    if ( var_12dad7deb9f58051.var_caa7aa2029afcc8b.size > 0 )
    {
        foreach ( e_linked in var_12dad7deb9f58051.var_caa7aa2029afcc8b )
        {
            if ( e_linked.targetname == "e_elevator_gate_top_clip_left" )
            {
                var_12dad7deb9f58051.sbm_left = e_linked;
            }
            else
            {
                var_12dad7deb9f58051.sbm_right = e_linked;
            }
            
            if ( e_linked.spawnflags == 1 )
            {
                e_linked disconnectpaths();
            }
        }
    }
    
    return var_12dad7deb9f58051;
}

// Namespace namespace_51f35399a137ca44
// Params 1
// Checksum 0x8be10630, Offset: 0x317d
// Size: 0xd4
function elevator_gate_open( flag_open )
{
    thread gemini_audio::function_e00d321a9acc907e();
    self setscriptablepartstate( "main", "open_fast" );
    thread function_701de1d1c6839fa0();
    wait 3;
    self notify( #"hash_b5a0a553e82a4f9b" );
    
    foreach ( e_linked in self.var_caa7aa2029afcc8b )
    {
        if ( e_linked.spawnflags == 1 )
        {
            e_linked connectpaths();
        }
    }
    
    if ( isdefined( flag_open ) )
    {
        level utility::flag_set( flag_open );
    }
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0x649d6e0e, Offset: 0x3259
// Size: 0x80
function function_701de1d1c6839fa0()
{
    level endon( #"game_ended" );
    self endon( #"hash_b5a0a553e82a4f9b" );
    
    while ( true )
    {
        doorl_tag_origin = self gettagorigin( "tag_doorL" );
        doorr_tag_origin = self gettagorigin( "tag_doorR" );
        self.sbm_left moveto( doorl_tag_origin, 0.05, 0, 0 );
        self.sbm_right moveto( doorr_tag_origin, 0.05, 0, 0 );
        wait 0.05;
    }
}

/#

    // Namespace namespace_51f35399a137ca44
    // Params 0
    // Checksum 0xa93d0ce6, Offset: 0x32e1
    // Size: 0x5, Type: dev
    function function_7bd8d0008eb849e8()
    {
        
    }

#/

// Namespace namespace_51f35399a137ca44
// Params 4
// Checksum 0xb47c8e6a, Offset: 0x32ee
// Size: 0x4b6
function elevator_moving_init( elevator_targetname, var_b60496d5b429ae0f, b_large, b_lights = 1 )
{
    var_710ca6e88772b224 = getent( elevator_targetname, #targetname );
    var_710ca6e88772b224 markkeyframedmover();
    var_710ca6e88772b224 forcenetfieldhighlod( 1 );
    var_710ca6e88772b224 setmoveroptimized( 1 );
    var_710ca6e88772b224 setmoverantilagged( 1 );
    var_710ca6e88772b224.a_linked = var_710ca6e88772b224 utility::get_linked_ents();
    var_710ca6e88772b224.var_cef075f2eb2cbbb3 = [];
    var_710ca6e88772b224.var_cef076f2eb2cbde6 = [];
    var_710ca6e88772b224.interior_light_01 = [];
    var_710ca6e88772b224.interior_light_02 = [];
    var_710ca6e88772b224.interior_light_03 = [];
    
    foreach ( ent in var_710ca6e88772b224.a_linked )
    {
        ent markkeyframedmover();
        ent forcenetfieldhighlod( 1 );
        ent setmoveroptimized( 1 );
        ent setmoverantilagged( 1 );
        ent linkto( var_710ca6e88772b224 );
        
        if ( isdefined( ent.script_noteworthy ) )
        {
            switch ( ent.script_noteworthy )
            {
                case #"hash_76acbbbc96561b2c":
                    var_710ca6e88772b224.enter_gate = ent;
                    break;
                case #"hash_80a1d711fe28f26a":
                    var_710ca6e88772b224.exit_gate = ent;
                    break;
                case #"hash_7ffc4525bd08707b":
                    var_710ca6e88772b224.var_25250e7bf49de491 = ent;
                    break;
                case #"hash_5e33df341577cafd":
                    var_710ca6e88772b224.enter_gate_clip = ent;
                    break;
                case #"hash_f60c21bc76c76f69":
                    var_710ca6e88772b224.exit_gate_clip = ent;
                    break;
                case #"hash_2278cbb46541d635":
                    var_710ca6e88772b224.var_cef075f2eb2cbbb3 = arraycombineunique( var_710ca6e88772b224.var_cef075f2eb2cbbb3, [ ent ] );
                    ent setmodel( %"lighting_fixtures_security_lamp_withcage_01_small_emissive_off" );
                    break;
                case #"hash_2278c8b46541d17c":
                    var_710ca6e88772b224.var_cef076f2eb2cbde6 = arraycombineunique( var_710ca6e88772b224.var_cef076f2eb2cbde6, [ ent ] );
                    ent setmodel( %"lighting_fixtures_security_lamp_withcage_01_small_emissive_off" );
                    break;
                case #"hash_f4a148d3fff493db":
                    var_710ca6e88772b224.interior_light_01 = arraycombineunique( var_710ca6e88772b224.interior_light_01, [ ent ] );
                    ent setmodel( %"lighting_fixtures_security_lamp_withcage_01_small_emissive_off" );
                    break;
                case #"hash_f4a149d3fff4956e":
                    var_710ca6e88772b224.interior_light_02 = arraycombineunique( var_710ca6e88772b224.interior_light_02, [ ent ] );
                    ent setmodel( %"lighting_fixtures_security_lamp_withcage_01_small_emissive_off" );
                    break;
                case #"hash_f4a14ad3fff49701":
                    var_710ca6e88772b224.interior_light_03 = arraycombineunique( var_710ca6e88772b224.interior_light_03, [ ent ] );
                    ent setmodel( %"lighting_fixtures_security_lamp_withcage_01_small_emissive_off" );
                    break;
                case #"hash_1cbdfe6b218268c8":
                    var_710ca6e88772b224.var_944282d27fd4c35d = ent;
                    break;
                case #"hash_6aae058f0504f57d":
                    var_710ca6e88772b224.nav_platform_clip = ent;
                    var_710ca6e88772b224.nav_platform_clip.moverdoesnotkill = 1;
                    var_710ca6e88772b224.nav_platform_clip.carriabletype = 1;
                    break;
                default:
                    break;
            }
        }
    }
    
    waitframe();
    var_710ca6e88772b224.a_lights = undefined;
    
    if ( b_lights )
    {
        a_elevator_lights = getentarray( "light_spot_elevator", #script_noteworthy );
        
        if ( a_elevator_lights.size > 0 )
        {
            foreach ( light in a_elevator_lights )
            {
                light linkto( var_710ca6e88772b224 );
                light.og_intensity = light getlightintensity();
                light setlightintensity( 0 );
            }
            
            var_710ca6e88772b224.a_lights = a_elevator_lights;
        }
    }
    
    waitframe();
    level thread ob_story_mission_utils::function_fe3c20270b6e910a( elevator_targetname );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        var_710ca6e88772b224 thread elevator_moving_cleanup( var_b60496d5b429ae0f );
    }
    
    return var_710ca6e88772b224;
}

// Namespace namespace_51f35399a137ca44
// Params 1
// Checksum 0x334492c8, Offset: 0x37ad
// Size: 0x179
function elevator_moving_cleanup( var_b60496d5b429ae0f )
{
    var_710ca6e88772b224 = self;
    var_710ca6e88772b224 endon( #"death" );
    level endon( #"game_ended" );
    level utility::flag_wait( var_b60496d5b429ae0f );
    
    if ( var_710ca6e88772b224.a_linked.size > 0 )
    {
        foreach ( ent in var_710ca6e88772b224.a_linked )
        {
            if ( ent islinked() )
            {
                ent unlink();
            }
            
            waitframe();
            ent delete();
            waitframe();
        }
    }
    
    waitframe();
    
    if ( var_710ca6e88772b224.a_lights.size > 0 )
    {
        foreach ( light in var_710ca6e88772b224.a_lights )
        {
            if ( light islinked() )
            {
                light unlink();
            }
            
            waitframe();
            light delete();
            waitframe();
        }
    }
    
    waitframe();
    var_710ca6e88772b224 delete();
}

// Namespace namespace_51f35399a137ca44
// Params 1
// Checksum 0xc2614962, Offset: 0x392e
// Size: 0x3c
function function_9d55074c7658e494( b_dock = 1 )
{
    if ( b_dock )
    {
        self.nav_platform_clip dockmovingplatform( undefined );
        return;
    }
    
    self.nav_platform_clip undockmovingplatform( 1 );
}

// Namespace namespace_51f35399a137ca44
// Params 1
// Checksum 0xc9f647a6, Offset: 0x3972
// Size: 0x4a4
function elevator_moving_toggle_lights( var_cc15b6ee7aab5324 )
{
    if ( isdefined( self.a_lights ) )
    {
        var_927c8d27ffb4d641 = [];
        a_off_lights = [];
        var_4db10c0519a9fdfa = [];
        var_cdcc8eee9d6c61ce = [];
        
        switch ( var_cc15b6ee7aab5324 )
        {
            case #"hash_da20441dfec451e7":
                var_927c8d27ffb4d641 = [ "light_elevator_ascent", "light_elevator_always_on" ];
                a_off_lights = [ "light_elevator_ascent_end", "light_elevator_descent", "light_elevator_descent_end", "light_elevator_descent_fill" ];
                var_4db10c0519a9fdfa = arraycombine( self.var_cef075f2eb2cbbb3, self.interior_light_02 );
                var_cdcc8eee9d6c61ce = arraycombine( self.var_cef076f2eb2cbde6, self.interior_light_01 );
                break;
            case #"hash_445fce3cb7727e6d":
                var_927c8d27ffb4d641 = [ "light_elevator_ascent_end", "light_elevator_descent_end" ];
                a_off_lights = [ "light_elevator_ascent", "light_elevator_descent", "light_elevator_descent_fill" ];
                var_4db10c0519a9fdfa = arraycombine( self.var_cef076f2eb2cbde6, self.interior_light_03 );
                var_cdcc8eee9d6c61ce = arraycombine( self.interior_light_01, self.var_cef075f2eb2cbbb3 );
                break;
            case #"hash_93f4f75f735ba015":
                var_927c8d27ffb4d641 = [ "light_elevator_descent", "light_elevator_ascent_end", "light_elevator_descent_fill" ];
                a_off_lights = [ "light_elevator_ascent", "light_elevator_descent_end" ];
                var_4db10c0519a9fdfa = arraycombine( self.var_cef076f2eb2cbde6, self.interior_light_03 );
                var_cdcc8eee9d6c61ce = arraycombine( self.interior_light_01, self.var_cef075f2eb2cbbb3 );
                break;
            case #"hash_8110b9bea9194a1b":
                var_927c8d27ffb4d641 = [ "light_elevator_descent", "light_elevator_descent_end", "light_elevator_descent_fill" ];
                a_off_lights = [ "light_elevator_ascent", "light_elevator_ascent_end" ];
                var_4db10c0519a9fdfa = self.var_cef076f2eb2cbde6;
                var_cdcc8eee9d6c61ce = arraycombine( self.interior_light_01, self.var_cef075f2eb2cbbb3, self.interior_light_03 );
                break;
            default:
                break;
        }
        
        foreach ( model in var_cdcc8eee9d6c61ce )
        {
            model setmodel( %"lighting_fixtures_security_lamp_withcage_01_small_emissive_off" );
        }
        
        foreach ( light in self.a_lights )
        {
            if ( arraycontains( a_off_lights, light.targetname ) )
            {
                if ( !isdefined( light.og_intensity ) && light getlightintensity() > 0 )
                {
                    light.og_intensity = light getlightintensity();
                }
                
                light setlightintensity( 0 );
            }
        }
        
        wait 1;
        
        foreach ( model in var_4db10c0519a9fdfa )
        {
            model setmodel( %"on_gemini::lighting_fixtures_security_lamp_withcage_01_small_emissive_warm" );
        }
        
        foreach ( light in self.a_lights )
        {
            if ( arraycontains( var_927c8d27ffb4d641, light.targetname ) )
            {
                if ( var_cc15b6ee7aab5324 == "descent" && light.targetname == "light_elevator_descent_fill" )
                {
                    thread function_b9ecb83dd5589ee2( light );
                    continue;
                }
                
                if ( isdefined( light.og_intensity ) )
                {
                    light setlightintensity( light.og_intensity );
                    continue;
                }
                
                light setlightintensity( 1 );
            }
        }
    }
}

// Namespace namespace_51f35399a137ca44
// Params 1
// Checksum 0x8556170b, Offset: 0x3e1e
// Size: 0x4f
function function_b9ecb83dd5589ee2( light )
{
    wait 5;
    
    if ( isdefined( light.og_intensity ) )
    {
        end_intensity = light.og_intensity;
    }
    else
    {
        end_intensity = 1;
    }
    
    light lighting::function_a6b7ccf4c5f2d94a( 5, end_intensity );
}

// Namespace namespace_51f35399a137ca44
// Params 3
// Checksum 0x1466effd, Offset: 0x3e75
// Size: 0x28e
function function_319a23379572a316( gate_name, var_ae740a76f0c8ef99 = 1, b_large = 1 )
{
    if ( gate_name == "enter" )
    {
        var_12dad7deb9f58051 = self.enter_gate;
        e_gate_top_clip = self.var_25250e7bf49de491;
        e_gate_clip = self.enter_gate_clip;
    }
    else
    {
        var_12dad7deb9f58051 = self.exit_gate;
        e_gate_clip = self.exit_gate_clip;
    }
    
    var_b6081b1b6ba5e8b5 = 52;
    
    if ( b_large )
    {
        var_b6081b1b6ba5e8b5 = 80;
    }
    
    if ( !isdefined( var_12dad7deb9f58051.trig ) )
    {
        var_12dad7deb9f58051.trig = getnoentvolumearray( "trig_tunnels_elevator_entrance_gate", #targetname )[ 0 ];
    }
    
    if ( isdefined( e_gate_clip ) && isdefined( var_12dad7deb9f58051 ) )
    {
        if ( var_ae740a76f0c8ef99 )
        {
            if ( !var_12dad7deb9f58051 utility::ent_flag( "elevator_gate_open" ) )
            {
                var_12dad7deb9f58051.var_e1adedc4a4a5146d = createnavbadplacebybounds( var_12dad7deb9f58051.trig.origin, ( 88, 36, 80 ), ( 0, 0, 0 ) );
                var_12dad7deb9f58051 unlink();
                waitframe();
                var_1d016b4edfbc212a = var_12dad7deb9f58051.origin + utility::flat_origin( anglestoforward( var_12dad7deb9f58051.angles ) * var_b6081b1b6ba5e8b5 );
                var_12dad7deb9f58051 moveto( var_1d016b4edfbc212a, 0.8, 0.2, 0.2 );
                var_12dad7deb9f58051 thread gemini_audio::function_3699c6ca13116af3();
                wait 1;
                var_12dad7deb9f58051 linkto( self );
                
                if ( e_gate_clip.spawnflags == 1 )
                {
                    e_gate_clip connectpaths();
                }
                
                e_gate_clip notsolid();
                
                if ( isdefined( e_gate_top_clip ) )
                {
                    e_gate_top_clip notsolid();
                }
                
                var_12dad7deb9f58051 utility::ent_flag_set( "elevator_gate_open" );
            }
            
            return;
        }
        
        if ( var_12dad7deb9f58051 utility::ent_flag( "elevator_gate_open" ) )
        {
            var_12dad7deb9f58051 unlink();
            var_12dad7deb9f58051 thread function_da6298fbb0c78a01();
            waitframe();
            var_1d016b4edfbc212a = var_12dad7deb9f58051.origin - utility::flat_origin( anglestoforward( var_12dad7deb9f58051.angles ) * var_b6081b1b6ba5e8b5 );
            var_12dad7deb9f58051 moveto( var_1d016b4edfbc212a, 0.8, 0.2, 0.2 );
            wait 1;
            var_12dad7deb9f58051 linkto( self );
            e_gate_clip solid();
            
            if ( isdefined( e_gate_top_clip ) )
            {
                e_gate_top_clip solid();
            }
            
            var_12dad7deb9f58051 notify( #"hash_804645592de53216" );
            
            if ( isdefined( var_12dad7deb9f58051.var_e1adedc4a4a5146d ) )
            {
                destroynavobstacle( var_12dad7deb9f58051.var_e1adedc4a4a5146d );
            }
            
            var_12dad7deb9f58051 utility::ent_flag_clear( "elevator_gate_open" );
        }
    }
}

// Namespace namespace_51f35399a137ca44
// Params 0
// Checksum 0x97fee407, Offset: 0x410b
// Size: 0x263
function function_da6298fbb0c78a01()
{
    level endon( #"game_ended" );
    self endon( #"hash_804645592de53216" );
    
    while ( true )
    {
        if ( isdefined( self.trig ) )
        {
            var_6f5c0bece5deb66e = getaiarray( "team_two_hundred", "team_hundred_ninety" );
            
            if ( var_6f5c0bece5deb66e.size > 0 )
            {
                var_6f5c0bece5deb66e = sortbydistancecullbyradius( var_6f5c0bece5deb66e, self.trig.origin, 96 );
            }
            
            if ( var_6f5c0bece5deb66e.size > 0 )
            {
                foreach ( enemy in var_6f5c0bece5deb66e )
                {
                    if ( !isalive( enemy ) )
                    {
                        continue;
                    }
                    
                    enemy.var_a13bed1ac47e1b2c = 1;
                    enemy.allowdeath = 1;
                    
                    if ( enemy.subclass != "zombie_base" )
                    {
                        enemy zombie_base_dismemberment::annihilate();
                    }
                    else
                    {
                        enemy zombie_base_dismemberment::function_61b75f09c6601780();
                    }
                    
                    enemy kill();
                    waitframe();
                }
            }
        }
        else
        {
            a_ents_near = getentarrayinradius( undefined, undefined, self.origin, 512 );
            a_ents_touching = self getistouchingentities( a_ents_near );
            
            if ( a_ents_touching.size > 0 )
            {
                foreach ( ent in a_ents_touching )
                {
                    if ( isplayer( ent ) )
                    {
                        continue;
                    }
                    
                    if ( !isagent( ent ) )
                    {
                        continue;
                    }
                    
                    if ( !isalive( ent ) )
                    {
                        continue;
                    }
                    
                    if ( ent.type != "zombie" )
                    {
                        continue;
                    }
                    
                    ent.var_a13bed1ac47e1b2c = 1;
                    ent.allowdeath = 1;
                    
                    if ( ent.subclass != "zombie_base" )
                    {
                        ent zombie_base_dismemberment::annihilate();
                    }
                    else
                    {
                        ent zombie_base_dismemberment::function_61b75f09c6601780();
                    }
                    
                    ent kill();
                }
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace namespace_51f35399a137ca44
    // Params 0
    // Checksum 0xa4c2a566, Offset: 0x4376
    // Size: 0x5, Type: dev
    function function_fa5c65e046ce02e2()
    {
        
    }

#/

// Namespace namespace_51f35399a137ca44
// Params 0, eflags: 0x4
// Checksum 0x15c1b005, Offset: 0x4383
// Size: 0x1b2
function private function_6bed4bbe5356b63e()
{
    activity_instance = self;
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_TUNNELS_ELEVATOR_CALL" );
    mission_ui::function_759924b87215156b( 0, 0, level.players );
    e_tunnels_elevator_interact = gemini_util::get_scriptable( "e_tunnels_elevator_interact" );
    activity_instance.obj_id = gemini_util::function_70fecc661764c00a( e_tunnels_elevator_interact.origin, undefined, 68, undefined, "sat_ob_objectivemarker_storymissionmain" );
    function_2b8e3d3ae2a6414a( activity_instance.obj_id, 0 );
    level utility::flag_wait( "flag_tunnels_elevator_interact" );
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_TUNNELS_ELEVATOR_DEFEND" );
    var_f5594f9951890a3d = utility::getstruct( "s_obj_tunnels_elevator_doors", "targetname" );
    objidpoolmanager::update_objective_position( activity_instance.obj_id, var_f5594f9951890a3d.origin + ( 0, 0, 48 ) );
    level utility::flag_wait( "flag_tunnels_elevator_gate_top_open" );
    ob_story_mission_utils::objective_text_clear();
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_TUNNELS_ELEVATOR_RIDE" );
    var_f5594f9951890a3d = utility::getstruct( "s_obj_tunnels_elevator_enter", "targetname" );
    objidpoolmanager::update_objective_position( activity_instance.obj_id, var_f5594f9951890a3d.origin + ( 0, 0, 48 ) );
    level utility::flag_wait( "flag_tunnels_elevator_descend_start" );
    level thread function_17dd3201e33c1a76( "flag_tunnels_elevator_gate_bottom_open" );
    ob_story_mission_utils::objective_marker_clear( activity_instance.obj_id );
    level utility::flag_wait( "flag_tunnels_elevator_gate_bottom_open" );
    activity_instance.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_tunnels_elevator_exit", undefined, undefined, "targetname", undefined, "active" );
    level utility::flag_wait( "flag_tunnels_elevator_complete" );
    ob_story_mission_utils::objective_marker_clear( activity_instance.obj_id );
}

// Namespace namespace_51f35399a137ca44
// Params 1, eflags: 0x4
// Checksum 0x7cf3dc74, Offset: 0x453d
// Size: 0x69
function private function_de7840b0396c3b46( player )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    utility::flag_wait( "flag_tunnels_elevator_defend_start" );
    wait 5;
    player utility::callsharedfunc( #"hint", #"add_simple", "hint_cradle_wall", &"sat_ob/hint_cradle_wall", 10 );
}

// Namespace namespace_51f35399a137ca44
// Params 1, eflags: 0x4
// Checksum 0x8ec6bff, Offset: 0x45ae
// Size: 0x16f
function private function_17dd3201e33c1a76( flag )
{
    playersdisabled = [];
    
    while ( !utility::flag( flag ) )
    {
        foreach ( player in level.players )
        {
            guid = player.guid;
            
            if ( !isdefined( playersdisabled[ guid ] ) )
            {
                playersdisabled[ guid ] = player getcamerathirdperson();
                player setcamerathirdperson( 0 );
                player val::set( "disable_third_person", "allow_toggle_third_person" );
            }
        }
        
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        guid = player.guid;
        
        if ( isdefined( playersdisabled[ guid ] ) )
        {
            player setcamerathirdperson( playersdisabled[ guid ] );
            player val::reset_all( "disable_third_person" );
        }
    }
}

