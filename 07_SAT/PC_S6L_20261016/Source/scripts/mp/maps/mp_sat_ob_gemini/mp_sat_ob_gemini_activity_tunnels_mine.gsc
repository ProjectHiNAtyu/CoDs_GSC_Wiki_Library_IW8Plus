// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_tunnels_mine.gsc  (hash_14ba978e21849251.gscc) (size: 25639 Bytes / 0x6427 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2fe764f1 (803693809)
// size ...... 25639 (0x6427)
// includes .. 21  (offset: 0x5bc3)
// strings ... 114 (offset: 0x5c6b)
// dev strs .. 7   (offset: 0x63d3)
// exports ... 46  (offset: 0x3b67)
// cseg ...... 0xd8d + 0x2dda (0x3b67)
// imports ... 205 (offset: 0x4297)
// animtree1 . 0   (offset: 0x6427)
// animtree2 . 0   (offset: 0x6427)
#using script_2cd07641bf71242a;
#using script_4c1e16e1162d066f;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;

#namespace namespace_b109f7cb70e0649d;

/#

    // Namespace namespace_b109f7cb70e0649d
    // Params 0
    // Checksum 0xb4d96bc3, Offset: 0xdab
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_b109f7cb70e0649d
// Params 0, eflags: 0x5
// Checksum 0x9d323a4f, Offset: 0xdb8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_955f04b475578133", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_b109f7cb70e0649d
// Params 0, eflags: 0x4
// Checksum 0x678d7cd1, Offset: 0xde1
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_TUNNELS_MINE";
    activity_common::registeractivitytype( "OB_GEMINI_TUNNELS_MINE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_MINE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_MINE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_MINE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_TUNNELS_MINE" );
}

// Namespace namespace_b109f7cb70e0649d
// Params 0
// Checksum 0x95aa5a8b, Offset: 0xe58
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance tunnels_mine_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_b109f7cb70e0649d
// Params 0
// Checksum 0x7eeff07, Offset: 0xeb9
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance tunnels_mine_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_b109f7cb70e0649d
// Params 0
// Checksum 0x29eef03c, Offset: 0xefa
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_b109f7cb70e0649d
// Params 1
// Checksum 0xbddb2eb6, Offset: 0xf1e
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread tunnels_mine_player_setup( player );
    }
}

/#

    // Namespace namespace_b109f7cb70e0649d
    // Params 0
    // Checksum 0xf363cfd3, Offset: 0xfda
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_b109f7cb70e0649d
// Params 0
// Checksum 0x9aa8e16e, Offset: 0xfe7
// Size: 0x70
function tunnels_mine_start()
{
    activity_instance = self;
    ob_story_mission_utils::function_6314f03dfe2adbc5( 0 );
    activity_instance thread ob_story_mission_utils::objective_marker_clear_all();
    level thread gemini_util::function_85abe3355f8a3cce();
    gemini_util::function_34a3d0cff5de2d7d();
    level ob_adz::function_86ebf122bc776db5();
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "s_tunnels_mine_cache" );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_tunnels_mine_weapon", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_tunnels_mine_equipment", undefined, 1 );
    activity_instance thread gemini_util::function_501b62568cd67932();
}

// Namespace namespace_b109f7cb70e0649d
// Params 0
// Checksum 0x5b386bcd, Offset: 0x105f
// Size: 0x170
function tunnels_mine_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    waitframe();
    
    /#
        activity_instance thread gemini_util::function_d6c199899ef5b468( "<dev string:x24>", "<dev string:x3b>", "<dev string:x5b>" );
    #/
    
    waitframe();
    
    if ( !isdefined( level.var_3ce1f8d9700aaa07 ) )
    {
        level.var_3ce1f8d9700aaa07 = undefined;
    }
    
    if ( !level callback::exists( #"player_spawned", &function_20d579339e91eb4 ) )
    {
        level callback::add( #"player_spawned", &function_20d579339e91eb4 );
    }
    
    level.var_d53163b0ef2a4488 = 1;
    activity_instance childthread gemini_vo::function_11bda69327fdcf2();
    activity_instance thread function_b448f178b089d2ef();
    activity_instance thread function_f82925b9a769dc1b();
    activity_instance thread tunnels_mine_screen_setup();
    thread gemini_util::function_6ba38d8e858007a9();
    thread gemini_util::function_bad374b9f21345b( "e_tunnels_mine_gate_01", "flag_tunnels_mine_gate_01_open", "flag_tunnels_mine_gate_01_interact", "flag_tunnels_pit_complete" );
    thread gemini_util::function_bad374b9f21345b( "e_tunnels_mine_gate_02", "flag_tunnels_mine_gate_02_open", "flag_tunnels_mine_gate_02_interact", "flag_tunnels_pit_complete" );
    activity_instance thread function_cd5b4ae4bcba9728();
    
    /#
        if ( getdvarint( @"hash_977d6e69d9305776", 0 ) )
        {
            thread function_d283aee3d1244e6c( "<dev string:x76>" );
        }
    #/
    
    level utility::flag_wait( "flag_trig_tunnels_mine_gate_02_complete" );
    
    if ( level callback::exists( #"player_spawned", &function_20d579339e91eb4 ) )
    {
        level callback::remove( #"player_spawned", &function_20d579339e91eb4 );
    }
    
    level utility::flag_set( "flag_tunnels_mine_complete" );
}

// Namespace namespace_b109f7cb70e0649d
// Params 1
// Checksum 0x3327c51b, Offset: 0x11d7
// Size: 0x52
function tunnels_mine_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player thread gemini_util::player_cold_breath_toggle( "flag_tunnels_pit_complete" );
    }
    
    player thread function_77dfef6d795b0b87();
    activity_instance thread function_5868e9f25176a726( player );
}

// Namespace namespace_b109f7cb70e0649d
// Params 1
// Checksum 0xd8eae339, Offset: 0x1231
// Size: 0x137
function function_77dfef6d795b0b87( var_227d31dc9ac4ce27 = 0 )
{
    self notify( #"hash_6da7a26a5aa47075" );
    self endon( #"hash_6da7a26a5aa47075" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        return;
    }
    
    function_e78958fab12ed692();
    waitframe();
    thread gemini_util::function_b89408bec75f5c14( "flag_tunnels_pit_complete", 0, 0.5, 1 );
    
    if ( var_227d31dc9ac4ce27 )
    {
        wait 1;
        gemini_util::player_camera_sway_settings( 2 );
        thread function_3b197893d0fa89de();
    }
    else
    {
        utility::waittill_any_ents( level, "flag_tunnels_pit_complete", self, "flag_trig_tunnels_mine_progress_02" );
        
        if ( !level utility::flag( "flag_tunnels_pit_complete" ) )
        {
            gemini_util::player_camera_sway_settings( 1 );
            utility::waittill_any_ents( level, "flag_tunnels_pit_complete", self, "flag_trig_tunnels_mine_gate_02_begin" );
            
            if ( !level utility::flag( "flag_tunnels_pit_complete" ) )
            {
                gemini_util::player_camera_sway_settings( 1.5 );
                utility::waittill_any_ents( level, "flag_tunnels_pit_complete", self, "flag_trig_tunnels_mine_progress_09" );
                
                if ( !level utility::flag( "flag_tunnels_pit_complete" ) )
                {
                    gemini_util::player_camera_sway_settings( 2 );
                    thread function_3b197893d0fa89de();
                }
            }
        }
    }
    
    level utility::flag_wait( "flag_tunnels_pit_complete" );
    thread gemini_util::function_16357e04a0cbe73d();
}

// Namespace namespace_b109f7cb70e0649d
// Params 0
// Checksum 0x265848fc, Offset: 0x1370
// Size: 0x72
function function_e78958fab12ed692()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_550963bbb003c756 = ( 0, 0, 0 );
    
    if ( getdvarint( @"hash_ccecb2781660d0fc" ) == 1 )
    {
        var_550963bbb003c756 = ( -1, 0, 2 );
    }
    else
    {
        var_550963bbb003c756 = ( -3, 0, 6 );
    }
    
    self.var_550963bbb003c756 = var_550963bbb003c756;
}

// Namespace namespace_b109f7cb70e0649d
// Params 0
// Checksum 0x2c14402a, Offset: 0x13ea
// Size: 0x2d4
function function_3b197893d0fa89de()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_674ee0abdfa99fed = 240;
    var_62630218e3eda3a5 = 480;
    far_dist = 720;
    near_dist_sq = squared( var_674ee0abdfa99fed );
    med_dist_sq = squared( var_62630218e3eda3a5 );
    var_68683cd0fec692e1 = squared( far_dist );
    struct = utility::getstruct( "s_tunnels_mine_obj_interrogation", "targetname" );
    trig = getent( "trig_tunnels_mine_final_hallway", #targetname );
    n_fov_current = 0;
    n_fov_target = 0;
    b_scramble = 0;
    var_42b9921fc183978d = 0;
    shockfile = undefined;
    b_cradle = 0;
    var_a56bd6da3fede971 = 0;
    
    while ( !level utility::flag( "flag_tunnels_pit_complete" ) )
    {
        if ( isdefined( trig ) && !self istouching( trig ) )
        {
            b_scramble = 0;
            n_fov_target = 0;
            shockfile = undefined;
            b_cradle = 0;
        }
        else
        {
            player_dist_sq = distancesquared( self.origin, struct.origin );
            
            if ( player_dist_sq < near_dist_sq )
            {
                b_scramble = 1;
                n_fov_target = 60;
                shockfile = %"sound_veil_mp";
                b_cradle = 1;
            }
            else if ( player_dist_sq < med_dist_sq )
            {
                b_scramble = 1;
                n_fov_target = 40;
                shockfile = %"sound_veil_reduced_mp";
                b_cradle = 0;
            }
            else if ( player_dist_sq < var_68683cd0fec692e1 )
            {
                b_scramble = 0;
                n_fov_target = 20;
                shockfile = %"sound_veil_reduced_mp";
                b_cradle = 0;
            }
            else
            {
                b_scramble = 0;
                n_fov_target = 0;
                shockfile = undefined;
                b_cradle = 0;
            }
        }
        
        if ( n_fov_target != n_fov_current )
        {
            if ( n_fov_target == 0 )
            {
                gemini_util::player_fov_restore( 1 );
                n_fov_current = 0;
            }
            else if ( n_fov_current > n_fov_target )
            {
                gemini_util::function_1cdd28af12b71f9c( -5, 1 );
                n_fov_current -= 5;
            }
            else if ( n_fov_current < n_fov_target )
            {
                gemini_util::function_1cdd28af12b71f9c( 5, 1 );
                n_fov_current += 5;
            }
        }
        
        if ( b_scramble )
        {
            if ( !var_42b9921fc183978d )
            {
                emp_debuff::play_emp_scramble( 1 );
                var_42b9921fc183978d = 1;
            }
        }
        else if ( var_42b9921fc183978d )
        {
            emp_debuff::stop_emp_scramble( 1 );
        }
        
        if ( isdefined( shockfile ) )
        {
            shellshock_utility_cpmp::_shellshock( shockfile, #"stun", 1, 0 );
        }
        
        if ( b_cradle )
        {
            if ( !var_a56bd6da3fede971 )
            {
                level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", -1, "flag_tunnels_pit_complete", [ self ] );
                var_a56bd6da3fede971 = 1;
            }
        }
        else if ( var_a56bd6da3fede971 )
        {
            level thread namespace_a350a26c6d662a6a::function_10887bb6792fea1c( self, %"sat_mp_sat_lm_avalon_ob_cradle_md_01", undefined, "cradle_influence_vfx_light" );
        }
        
        wait 1;
    }
    
    waitframe();
    gemini_util::player_fov_restore();
    emp_debuff::clear_emp_scramble();
    
    if ( var_a56bd6da3fede971 )
    {
        level thread namespace_a350a26c6d662a6a::function_10887bb6792fea1c( self, %"sat_mp_sat_lm_avalon_ob_cradle_md_01", undefined, "cradle_influence_vfx_light" );
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 0
// Checksum 0x5d98210e, Offset: 0x16c6
// Size: 0x69
function tunnels_mine_screen_setup()
{
    level endon( #"game_ended" );
    activity_instance = self;
    level gemini_util::function_401a0ddccdf00715( "tunnels_mine_screen_03" );
    waitframe();
    activity_instance thread gemini_util::function_1a2dee7491815110( "flag_tunnels_mine_screen_03_start", "sat_gemini_monitor_alex_1", "bink3", 1, "tunnels_mine_screen_03", "flag_tunnels_mine_screen_03_end", "flag_tunnels_mine_screen_03_stop", "OB_GEMINI_TUNNELS_MINE_ESCAPE", "OB_GEMINI_TUNNELS_MINE_TWISTED_FORFEIT" );
    level utility::flag_set( "flag_tunnels_mine_screen_03_init" );
}

// Namespace namespace_b109f7cb70e0649d
// Params 0
// Checksum 0x77daf7e2, Offset: 0x1737
// Size: 0x18d
function function_b448f178b089d2ef()
{
    b_zombie_spawn = 0;
    level utility::flag_wait( "flag_trig_tunnels_mine_begin" );
    thread function_6d5c7a5d0e69d7d4( "flag_tunnels_mine_gate_01_open", "s_enc_tunnels_mine_ambush_01", "flag_trig_tunnels_mine_progress_04", 0, 10 );
    level utility::flag_wait( "flag_trig_tunnels_mine_gate_01_begin" );
    thread function_fd2ba38b24748a6d( "s_enc_vol_mine_zombie_01", "flag_trig_tunnels_mine_progress_05", "flag_tunnels_mine_complete", 10 );
    waitframe();
    thread function_c36fe1117e7f2fcf( "scene_tunnels_mine_horde_fall_01", [ "flag_tunnels_mine_gate_01_interact", "flag_trig_tunnels_mine_gate_01_horde_fall" ], "flag_trig_tunnels_mine_gate_02_begin" );
    level utility::flag_wait( "flag_tunnels_mine_gate_01_open" );
    wait randomfloatrange( 1, 3 );
    thread function_fd2ba38b24748a6d( "s_enc_vol_mine_zombie_gate_01", "flag_trig_tunnels_mine_progress_06", "flag_tunnels_mine_complete", 10 );
    level utility::flag_wait( "flag_trig_tunnels_mine_gate_01_complete" );
    thread function_ea6053ae19da11d1( "trig_tunnels_mine_ambush_02", "flag_tunnels_mine_ambush_02", "flag_trig_tunnels_mine_gate_02_detour", 1, 50 );
    level utility::flag_wait( "flag_trig_tunnels_mine_progress_03" );
    thread function_fd2ba38b24748a6d( "s_enc_vol_mine_vermin_02a", "flag_trig_tunnels_mine_progress_07" );
    wait randomfloatrange( 0.5, 1.5 );
    thread function_fd2ba38b24748a6d( "s_enc_vol_mine_vermin_02b", "flag_trig_tunnels_mine_progress_08" );
    level utility::flag_wait( "flag_trig_tunnels_mine_progress_05" );
    thread function_fd2ba38b24748a6d( "s_enc_vol_mine_zombie_02a", "flag_trig_tunnels_mine_gate_02_complete" );
    level utility::flag_wait( "flag_trig_tunnels_mine_progress_06" );
    thread function_fd2ba38b24748a6d( "s_enc_vol_mine_zombie_02b", "flag_trig_tunnels_mine_progress_09" );
    level utility::flag_wait( "flag_trig_tunnels_mine_progress_07" );
    thread function_fd2ba38b24748a6d( "s_enc_vol_mine_zombie_02c", "flag_trig_tunnels_mine_gate_03_begin" );
    waitframe();
    thread function_ea6053ae19da11d1( "trig_tunnels_mine_ambush_03", "flag_tunnels_mine_ambush_03", "flag_trig_tunnels_mine_gate_03_progress_02", 1, 50 );
}

// Namespace namespace_b109f7cb70e0649d
// Params 1
// Checksum 0xfdeded94, Offset: 0x18cc
// Size: 0x1b3
function function_f82925b9a769dc1b( b_skipto_pit = 0 )
{
    level endon( #"game_ended", #"flag_tunnels_pit_complete" );
    level utility::flag_wait( "flag_area_denial_zone_init_complete" );
    activity_instance = self;
    var_6658cb7944010e0 = 90;
    var_daf32af282c0f807 = 135;
    var_3a41143260317ca6 = 125;
    
    if ( b_skipto_pit )
    {
        level.tunnels_mine_adz = function_d62d31d1d17f98d8( "s_tunnels_mine_adz_01", 1, 6400 );
        wait 1;
        level.tunnels_mine_adz = function_d62d31d1d17f98d8( "s_tunnels_mine_adz_02", var_daf32af282c0f807 * 0.5, 4500, 6000 );
        wait 1;
    }
    else
    {
        level.tunnels_mine_adz = function_2d011945565c1d94( "s_tunnels_mine_adz_01", "flag_trig_tunnels_mine_begin", "flag_trig_tunnels_mine_gate_01_complete", var_6658cb7944010e0, 3000, 6400 );
        activity_instance thread function_35b776a88d52405d( "flag_trig_tunnels_mine_adz_02_begin", 1 );
        waitframe();
        level utility::flag_wait( "flag_trig_tunnels_mine_adz_02_begin" );
        wait 1;
        level.tunnels_mine_adz = function_2d011945565c1d94( "s_tunnels_mine_adz_02", "flag_trig_tunnels_mine_gate_01_complete", "flag_trig_tunnels_mine_progress_09", var_daf32af282c0f807, 512, 6000 );
        activity_instance thread function_35b776a88d52405d( "flag_trig_tunnels_mine_progress_08" );
    }
    
    level utility::flag_wait( "flag_trig_tunnels_mine_progress_08" );
    wait 1;
    level.tunnels_mine_adz = function_2d011945565c1d94( "s_tunnels_mine_adz_03", "flag_trig_tunnels_mine_gate_03_begin", "flag_tunnels_pit_complete", var_3a41143260317ca6, 512, 6000 );
    activity_instance utility::delaythread( 10, &function_35b776a88d52405d, "flag_tunnels_pit_complete" );
    activity_instance thread function_f9aebb84f0566280( level.tunnels_mine_adz, 2400, "flag_tunnels_mine_gate_03_stuck", "flag_tunnels_mine_gate_03_unstick" );
}

// Namespace namespace_b109f7cb70e0649d
// Params 6
// Checksum 0x621dcd04, Offset: 0x1a87
// Size: 0xc4
function function_2d011945565c1d94( zone_id, adz_flag_wait, adz_flag_endon, adz_time = 120, adz_min_radius = 512, adz_max_radius = 6400 )
{
    adz = ob_adz::function_a1b5ffd498b3f262( zone_id );
    
    if ( !isdefined( adz ) )
    {
        adz = ob_adz::function_47e86714392d46b4( zone_id, adz_min_radius );
        adz thread ob_adz::function_f0f0de6800121e38( "flag_tunnels_pit_complete", adz.zone_id );
    }
    
    if ( isdefined( adz_flag_wait ) )
    {
        level utility::flag_wait( adz_flag_wait );
    }
    
    adz thread function_f61f8e744cd7de63( zone_id, adz_flag_endon );
    adz thread ob_adz::function_f94c18166de9f51d( zone_id, undefined, adz_max_radius, adz_time );
    return adz;
}

// Namespace namespace_b109f7cb70e0649d
// Params 4
// Checksum 0x6b35197f, Offset: 0x1b54
// Size: 0x94
function function_d62d31d1d17f98d8( zone_id, adz_time = 1, adz_min_radius = 512, adz_max_radius )
{
    adz = ob_adz::function_a1b5ffd498b3f262( zone_id );
    
    if ( !isdefined( adz ) )
    {
        adz = ob_adz::function_47e86714392d46b4( zone_id, adz_min_radius );
        adz thread ob_adz::function_f0f0de6800121e38( "flag_tunnels_pit_complete", adz.zone_id );
    }
    
    if ( isdefined( adz_max_radius ) )
    {
        adz thread ob_adz::function_f94c18166de9f51d( zone_id, undefined, adz_max_radius, adz_time );
    }
    
    return adz;
}

// Namespace namespace_b109f7cb70e0649d
// Params 2
// Checksum 0xc643763b, Offset: 0x1bf1
// Size: 0xbc
function function_f61f8e744cd7de63( zone_id, adz_flag_endon )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( adz_flag_endon ) )
    {
        adz_flag_endon = "flag_tunnels_pit_complete";
    }
    
    if ( level utility::flag( adz_flag_endon ) )
    {
        return;
    }
    
    s_start = utility::getstruct( zone_id, "targetname" );
    
    while ( !level utility::flag( adz_flag_endon ) )
    {
        if ( !arraycontains( level.var_117f58399f256fb6.radiation_array, self ) )
        {
            return;
        }
        
        a_s_linked = s_start utility::get_linked_structs();
        
        if ( a_s_linked.size == 0 )
        {
            return;
        }
        
        var_7b97f011bb3a6659 = a_s_linked[ 0 ];
        function_9130fdb167689bb2( var_7b97f011bb3a6659, adz_flag_endon );
        s_start = var_7b97f011bb3a6659;
        wait 1;
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 2, eflags: 0x4
// Checksum 0x88f60e96, Offset: 0x1cb5
// Size: 0xfa
function private function_9130fdb167689bb2( var_7b97f011bb3a6659, adz_flag_endon )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( adz_flag_endon ) )
    {
        return;
    }
    
    while ( !level utility::flag( adz_flag_endon ) )
    {
        if ( !arraycontains( level.var_117f58399f256fb6.radiation_array, self ) )
        {
            return;
        }
        
        if ( distance2d( self.origin, var_7b97f011bb3a6659.origin ) < self.radius )
        {
            if ( isdefined( var_7b97f011bb3a6659.script_flag_wait ) )
            {
                if ( level utility::flag( var_7b97f011bb3a6659.script_flag_wait ) )
                {
                    break;
                }
            }
            else
            {
                break;
            }
        }
        
        wait 1;
    }
    
    a_s_respawn = utility::getstructarray( var_7b97f011bb3a6659.target, "targetname" );
    
    if ( a_s_respawn.size > 0 )
    {
        level.var_3ce1f8d9700aaa07 = var_7b97f011bb3a6659.targetname;
        ob_story_mission_utils::set_revive_spawns( a_s_respawn );
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 4
// Checksum 0xcdf15598, Offset: 0x1db7
// Size: 0x129
function function_f9aebb84f0566280( radiation_instance, var_bf6eed7dd3cd2714, flag_wait_stuck, var_1c571c27539b1ed )
{
    level endon( #"game_ended", #"flag_tunnels_pit_complete" );
    activity_instance = self;
    level utility::flag_wait( flag_wait_stuck );
    n_timeout = gettime() + utility::function_4b74c15943231980( 10 );
    
    while ( gettime() < n_timeout )
    {
        if ( radiation_instance.radius >= var_bf6eed7dd3cd2714 )
        {
            break;
        }
        
        players = ob_story_mission_utils::get_playing_players();
        
        foreach ( player in players )
        {
            if ( player player::isinlaststand() )
            {
                wait 1;
                break;
            }
        }
        
        wait 1;
    }
    
    level utility::flag_set( var_1c571c27539b1ed );
}

// Namespace namespace_b109f7cb70e0649d
// Params 2
// Checksum 0x43ac11eb, Offset: 0x1ee8
// Size: 0x153
function function_35b776a88d52405d( var_3a83720f18fce23e, var_85c0bc491434b853 = 0 )
{
    self notify( #"hash_d26f831deaed051d" );
    self endon( #"hash_d26f831deaed051d" );
    level endon( #"game_ended", var_3a83720f18fce23e );
    activity_instance = self;
    
    if ( isdefined( var_3a83720f18fce23e ) )
    {
        if ( level utility::flag( var_3a83720f18fce23e ) )
        {
            return;
        }
        
        level endon( var_3a83720f18fce23e );
    }
    
    if ( var_85c0bc491434b853 )
    {
        level utility::flag_wait( "flag_trig_tunnels_mine_progress_01" );
    }
    
    while ( isdefined( level.tunnels_mine_adz ) )
    {
        a_players = ob_story_mission_utils::get_playing_players();
        a_players_sorted = sortbydistancecullbyradius( a_players, level.tunnels_mine_adz.origin, level.tunnels_mine_adz.radius + 500 );
        
        if ( a_players_sorted.size > 0 )
        {
            foreach ( player in a_players_sorted )
            {
                player notify( #"hash_ac163aec924cd93b" );
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 3
// Checksum 0x6ff6ad27, Offset: 0x2043
// Size: 0xf4
function function_c36fe1117e7f2fcf( struct_targetname, flag_trigger, var_b60496d5b429ae0f )
{
    level endon( #"game_ended" );
    activity_instance = self;
    s_scene = utility::getstruct( struct_targetname, "targetname" );
    s_scene endon( #"hash_dd2833e68cb66f88" );
    s_scene.activity_instance = activity_instance;
    s_scene.var_b60496d5b429ae0f = var_b60496d5b429ae0f;
    s_scene gemini_util::function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    s_scene scene::add_spawn_function( &function_bcd53f98928f5c51, "_object_all_" );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        s_scene thread gemini_util::scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    if ( isarray( flag_trigger ) )
    {
        level utility::flag_wait_any_array( flag_trigger );
    }
    else
    {
        level utility::flag_wait( flag_trigger );
    }
    
    level thread function_55b6201062a883e4( s_scene.target );
    waitframe();
    s_scene thread scene::play();
}

// Namespace namespace_b109f7cb70e0649d
// Params 5
// Checksum 0x165f15bd, Offset: 0x213f
// Size: 0x113
function function_6d5c7a5d0e69d7d4( wait_for_flag, struct_noteworthy, var_b60496d5b429ae0f, n_add = 0, emergence_spawn_chance = 25 )
{
    level endon( #"game_ended", var_b60496d5b429ae0f );
    var_5fa90f1a51250bbf = utility::getstructarray( struct_noteworthy, "script_noteworthy" );
    var_5fa90f1a51250bbf = arrayrandomize( var_5fa90f1a51250bbf );
    
    if ( isdefined( wait_for_flag ) )
    {
        level utility::flag_wait( wait_for_flag );
    }
    
    players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( players.size < 3 || level.is_squad_size_small )
    {
        var_50c38e212b7faa01 = minint( 1 + n_add, var_5fa90f1a51250bbf.size );
    }
    else
    {
        var_50c38e212b7faa01 = minint( 3 + n_add, var_5fa90f1a51250bbf.size );
    }
    
    for ( i = 0; i < var_50c38e212b7faa01 ; i++ )
    {
        wait randomfloatrange( 0.5, 1.5 );
        thread function_fd2ba38b24748a6d( var_5fa90f1a51250bbf[ i ].targetname, var_b60496d5b429ae0f, "flag_tunnels_mine_complete", emergence_spawn_chance );
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 6
// Checksum 0xa258b0e9, Offset: 0x225a
// Size: 0x12d
function function_ea6053ae19da11d1( trig_targetname, flag_set, var_b60496d5b429ae0f, n_add = 0, emergence_spawn_chance = 25, var_66983e9b7f1e4f98 = 1 )
{
    level endon( #"game_ended", var_b60496d5b429ae0f );
    var_5cba3aa7cba1a93c = getentarray( trig_targetname, #targetname );
    
    if ( var_5cba3aa7cba1a93c.size == 0 )
    {
        var_5cba3aa7cba1a93c = getnoentvolumearray( trig_targetname, #targetname );
        
        if ( !isdefined( var_5cba3aa7cba1a93c[ 0 ] ) )
        {
            /#
                iprintlnbold( "<dev string:x8b>" + trig_targetname );
            #/
            
            return;
        }
    }
    
    var_5cba3aa7cba1a93c = arrayrandomize( var_5cba3aa7cba1a93c );
    players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( players.size < 3 || level.is_squad_size_small )
    {
        var_50c38e212b7faa01 = minint( 1 + n_add, var_5cba3aa7cba1a93c.size );
    }
    else
    {
        var_50c38e212b7faa01 = minint( 3 + n_add, var_5cba3aa7cba1a93c.size );
    }
    
    for ( i = 0; i < var_50c38e212b7faa01 ; i++ )
    {
        thread function_15bd1908b9123bda( var_5cba3aa7cba1a93c[ i ], flag_set, var_b60496d5b429ae0f, emergence_spawn_chance, var_66983e9b7f1e4f98 );
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 5
// Checksum 0x2f59740c, Offset: 0x238f
// Size: 0xf6
function function_15bd1908b9123bda( trig, flag_set, var_b60496d5b429ae0f, emergence_spawn_chance, var_66983e9b7f1e4f98 = 1 )
{
    level endon( #"game_ended", var_b60496d5b429ae0f );
    activity_instance = self;
    
    if ( level utility::flag( var_b60496d5b429ae0f ) )
    {
        return;
    }
    
    while ( true )
    {
        trig waittill( #"trigger", data );
        
        if ( var_66983e9b7f1e4f98 )
        {
            if ( isplayer( data ) && !isbot( data ) )
            {
                break;
            }
        }
        else if ( isplayer( data ) )
        {
            break;
        }
        
        waitframe();
    }
    
    /#
        iprintlnbold( "<dev string:xae>" + trig.targetname );
    #/
    
    level utility::flag_set( flag_set );
    struct_targetname = trig.target;
    thread function_fd2ba38b24748a6d( struct_targetname, var_b60496d5b429ae0f, "flag_tunnels_mine_complete", emergence_spawn_chance );
}

// Namespace namespace_b109f7cb70e0649d
// Params 5
// Checksum 0x3915db0f, Offset: 0x248d
// Size: 0x21a
function function_fd2ba38b24748a6d( struct_targetname, var_b60496d5b429ae0f, flag_cleanup_force = "flag_tunnels_mine_complete", emergence_spawn_chance = 25, n_delay )
{
    level endon( #"game_ended" );
    activity_instance = self;
    s_enc = utility::getstruct( struct_targetname, "targetname" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    s_add = utility::getstruct( struct_targetname + "_add", "targetname" );
    
    if ( isdefined( s_add ) )
    {
        n_delay = randomfloatrange( 1, 3 );
        activity_instance thread function_fd2ba38b24748a6d( struct_targetname + "_add", var_b60496d5b429ae0f, flag_cleanup_force, emergence_spawn_chance, n_delay );
    }
    
    s_enc.var_b60496d5b429ae0f = var_b60496d5b429ae0f;
    s_enc.emergence_spawn_chance = emergence_spawn_chance;
    enc_targetname = s_enc.target;
    request_id = activity_instance gemini_util::function_51e3aaef58423855( enc_targetname, &function_edbdc57799e15062, s_enc, flag_cleanup_force );
    waitframe();
    s_enc_dmg = utility::getstruct( struct_targetname + "_dmg", "targetname" );
    
    if ( isdefined( s_enc_dmg ) )
    {
        activity_instance thread function_d80f9c5a7d0e9f09( s_enc_dmg );
    }
    
    trig_targetname = "trig_" + enc_targetname;
    a_trig_noent = getnoentvolumearray( trig_targetname, #targetname );
    var_3d8b856d22dec3af = s_enc utility::get_linked_structs();
    
    if ( var_3d8b856d22dec3af.size > 0 )
    {
        s_enc_scene = utility::array_random( var_3d8b856d22dec3af );
        s_enc_scene.activity_instance = activity_instance;
        s_enc_scene.var_b60496d5b429ae0f = var_b60496d5b429ae0f;
        s_enc_scene gemini_util::function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
        s_enc_scene scene::add_spawn_function( &function_bcd53f98928f5c51, "_object_all_" );
        s_enc_scene thread gemini_util::scene_zombie_cleanup( var_b60496d5b429ae0f );
        level thread function_55b6201062a883e4( a_trig_noent[ 0 ].target );
        waitframe();
        s_enc_scene thread scene::play( undefined, "enter" );
        return;
    }
    
    if ( a_trig_noent.size > 0 )
    {
        activity_instance thread function_ffdc89ec22ce7b7f( a_trig_noent[ 0 ], var_b60496d5b429ae0f );
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 1
// Checksum 0x2599878f, Offset: 0x26af
// Size: 0x11d
function function_d80f9c5a7d0e9f09( s_enc_dmg )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance thread function_d83e736fd9000000( s_enc_dmg );
    
    if ( !isdefined( s_enc_dmg.angles ) )
    {
        s_enc_dmg.angles = ( 0, 0, 0 );
    }
    
    vfx = "vfx_cradle_vol_md";
    
    if ( s_enc_dmg.var_9c45b57050a48288 < 256 )
    {
        vfx = "vfx_cradle_vol_sm";
    }
    else if ( s_enc_dmg.radius > 320 )
    {
        vfx = "vfx_cradle_vol_lg";
    }
    
    var_64250342fb4fe6a6 = utility::spawn_tag_origin();
    var_64250342fb4fe6a6.origin = s_enc_dmg.origin;
    var_64250342fb4fe6a6.angles = s_enc_dmg.angles;
    var_64250342fb4fe6a6 show();
    waitframe();
    playfxontag( utility::getfx( vfx ), var_64250342fb4fe6a6, "tag_origin" );
    level utility::flag_wait( "flag_tunnels_pit_complete" );
    stopfxontag( utility::getfx( vfx ), var_64250342fb4fe6a6, "tag_origin" );
    waitframe();
    var_64250342fb4fe6a6 delete();
}

// Namespace namespace_b109f7cb70e0649d
// Params 1
// Checksum 0xcfd88edc, Offset: 0x27d4
// Size: 0xd0
function function_d83e736fd9000000( s_enc_dmg )
{
    level endon( #"game_ended", #"flag_tunnels_pit_complete" );
    trig_dmg = spawn( "noent_volume_trigger_radius", s_enc_dmg.origin, 0, s_enc_dmg.radius, 128 );
    s_enc_dmg.a_players = [];
    
    while ( true )
    {
        trig_dmg waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            waitframe();
            continue;
        }
        
        if ( arraycontains( s_enc_dmg.a_players, player ) )
        {
            waitframe();
            continue;
        }
        
        player thread function_c9c8d027fa1092f9( trig_dmg, s_enc_dmg );
        s_enc_dmg.a_players = arraycombineunique( s_enc_dmg.a_players, [ player ] );
        waitframe();
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 2
// Checksum 0x96f380a3, Offset: 0x28ac
// Size: 0x11f
function function_c9c8d027fa1092f9( trig_dmg, s_enc_dmg )
{
    self notify( #"hash_f50618494abe989c" );
    self endon( #"hash_f50618494abe989c" );
    level endon( #"game_ended" );
    self endon( #"death" );
    var_1f810dee808f553 = squared( s_enc_dmg.radius );
    b_cradled = 0;
    
    while ( !level utility::flag( "flag_tunnels_pit_complete" ) )
    {
        if ( !b_cradled )
        {
            namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", 6, undefined, [ self ] );
            b_cradled = 1;
        }
        
        var_92b21ca8efb6aef2 = distance2dsquared( self.origin, trig_dmg.origin );
        
        if ( var_92b21ca8efb6aef2 > var_1f810dee808f553 )
        {
            break;
        }
        
        self dodamage( 5, s_enc_dmg.origin, undefined, undefined, "MOD_TRIGGER_HURT" );
        wait 1;
    }
    
    namespace_a350a26c6d662a6a::function_10887bb6792fea1c( self, %"sat_mp_sat_lm_avalon_ob_cradle_md_02", undefined, "cradle_influence_vfx_medium" );
    s_enc_dmg.a_players = arrayremove( s_enc_dmg.a_players, self );
}

// Namespace namespace_b109f7cb70e0649d
// Params 2
// Checksum 0x8ec43ae6, Offset: 0x29d3
// Size: 0x9b
function function_ffdc89ec22ce7b7f( trig, var_b60496d5b429ae0f )
{
    level endon( #"game_ended", var_b60496d5b429ae0f );
    activity_instance = self;
    
    while ( true )
    {
        trig waittill( #"trigger", data );
        
        if ( isalive( data ) && isagent( data ) && data.type == "zombie" )
        {
            break;
        }
        
        waitframe();
    }
    
    scriptable_targetname = trig.target;
    level thread function_55b6201062a883e4( scriptable_targetname );
}

// Namespace namespace_b109f7cb70e0649d
// Params 1
// Checksum 0x7a6af5de, Offset: 0x2a76
// Size: 0x14b
function function_582deb273a84340e( trig )
{
    self endon( #"death" );
    
    if ( self.aicategory == "normal" )
    {
        if ( utility::cointoss() )
        {
            v_ground = utility::drop_to_ground( trig.origin, 0, 1024 );
            v_agent = self.origin;
            v_angles = vectortoangles( v_agent - v_ground );
            var_7fb813c2ac295924 = v_ground + anglestoforward( v_angles ) * 100;
            zombie_knockdown::function_a113e6ee43535d37( var_7fb813c2ac295924, int( self.health * 0.5 ) );
            return;
        }
        
        launch_destination = utility::drop_to_ground( trig.origin, 0, 1024 ) + ( 0, 0, 32 );
        launch_source = self.origin;
        launch_mag = 400 + randomintrange( -100, 100 );
        var_2501b9aef17e35f9 = launch_destination - launch_source;
        var_4dd9c210b998e030 = "default";
        
        if ( utility::cointoss() )
        {
            var_4dd9c210b998e030 = "roll_forward";
        }
        
        zombie_cannonball::cannonball_ai( var_2501b9aef17e35f9, launch_mag, zombie_cannonball::adv_settings( 0.8, 10, 0 ), var_4dd9c210b998e030 );
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 3
// Checksum 0x976ec2c9, Offset: 0x2bc9
// Size: 0x233
function function_55b6201062a883e4( scriptable_targetname, min_delay = 0.5, max_delay = 1.5 )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    a_barrier_ent = getscriptablearray( scriptable_targetname, #targetname );
    a_barrier_noent = getentitylessscriptablearray( scriptable_targetname, #targetname );
    a_barrier = arraycombine( a_barrier_ent, a_barrier_noent );
    
    if ( a_barrier.size == 0 )
    {
        return;
    }
    
    if ( isdefined( a_barrier[ 0 ].script_index ) )
    {
        a_barrier = utility::array_sort_by_script_index( a_barrier );
    }
    else
    {
        a_barrier = arrayrandomize( a_barrier );
    }
    
    for ( i = 0; i < a_barrier.size ; i++ )
    {
        if ( arraycontains( a_barrier[ i ] function_7c320131bd49bb18(), "main" ) )
        {
            if ( a_barrier[ i ] getscriptablepartstate( "main" ) != "dead" )
            {
                a_barrier[ i ] setscriptablepartstate( "main", "dead" );
            }
        }
        else if ( a_barrier[ i ] getscriptablepartstate( "tag_gemini_mines_breakwall_removed" ) != "dead" )
        {
            a_barrier[ i ] setscriptablepartstate( "tag_gemini_mines_breakwall_removed", "dead" );
        }
        
        earthquake( 0.2, 0.2, a_barrier[ i ].origin, 768 );
        playrumbleonposition( "grenade_rumble", a_barrier[ i ].origin );
        a_players = getplayersinradius( a_barrier[ i ].origin, 512 );
        
        if ( a_players.size > 0 )
        {
            foreach ( player in a_players )
            {
                player shellshock_utility_cpmp::_shellshock( %"frag_grenade_mp", #"explosion", 2 );
            }
        }
        
        wait randomfloatrange( min_delay, max_delay );
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 1
// Checksum 0xedf436b8, Offset: 0x2e04
// Size: 0xfb
function function_d283aee3d1244e6c( scriptable_noteworthy )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    a_barrier_ent = getscriptablearray( scriptable_noteworthy, #script_noteworthy );
    a_barrier_noent = getentitylessscriptablearray( scriptable_noteworthy, #script_noteworthy );
    a_barrier = arraycombine( a_barrier_ent, a_barrier_noent );
    
    if ( a_barrier.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < a_barrier.size ; i++ )
    {
        if ( arraycontains( a_barrier[ i ] function_7c320131bd49bb18(), "main" ) )
        {
            if ( a_barrier[ i ] getscriptablepartstate( "main" ) != "dead" )
            {
                a_barrier[ i ] setscriptablepartstate( "main", "dead" );
            }
        }
        else if ( a_barrier[ i ] getscriptablepartstate( "tag_gemini_mines_breakwall_removed" ) != "dead" )
        {
            a_barrier[ i ] setscriptablepartstate( "tag_gemini_mines_breakwall_removed", "dead" );
        }
        
        wait 1;
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 4
// Checksum 0xb3587cf1, Offset: 0x2f07
// Size: 0x21e
function function_edbdc57799e15062( request_id, data, agent, ai_data )
{
    agent endon( #"death" );
    agent.team = "team_two_hundred";
    agent gemini_util::function_54a189c04c75a149( 1, 2048 );
    agent zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    s_enc = data;
    b_slow = 0;
    var_ac504a0940937d79 = squared( 256 );
    
    if ( isdefined( s_enc ) && s_enc.script_noteworthy == "zombie_slow" )
    {
        b_slow = 1;
    }
    
    if ( isdefined( agent.subclass ) && issubstr( agent.subclass, "zombie_vermin" ) )
    {
        agent zombie_traverse_asm::function_85b354b1fada24eb();
        agent function_786bb6aa1b76c7ee( "wallCrawlRangedAttackRange", 1 );
        agent.var_720018aa0a425283 = 0;
        
        if ( b_slow )
        {
            move_speed = "run";
        }
        else
        {
            move_speed = "sprint";
        }
    }
    else if ( b_slow )
    {
        if ( utility::percent_chance( 75 ) )
        {
            move_speed = "walk";
        }
        else
        {
            move_speed = "run";
        }
    }
    else if ( utility::percent_chance( 75 ) )
    {
        move_speed = "run";
    }
    else
    {
        move_speed = "sprint";
    }
    
    if ( agent.subclass == "zombie_base" )
    {
        agent thread gemini_util::function_c8cbee5fb3b870c3();
    }
    
    agent zombie_utils::function_a8ce00e0448cb6f0( move_speed, "mine_zombie", 25 );
    
    if ( isdefined( s_enc ) && isdefined( s_enc.var_b60496d5b429ae0f ) )
    {
        level utility::flag_wait( s_enc.var_b60496d5b429ae0f );
        
        if ( utility::flag( "flag_tunnels_mine_complete" ) )
        {
            agent thread gemini_util::ai_delete_when_out_of_sight( 1024, 2048 );
        }
        else
        {
            agent thread gemini_util::ai_delete_when_out_of_sight( 2048, 4096 );
        }
        
        if ( move_speed == "run" )
        {
            agent zombie_utils::function_a8ce00e0448cb6f0( "walk", "mine_zombie", 25 );
            return;
        }
        
        if ( move_speed == "sprint" )
        {
            agent zombie_utils::function_a8ce00e0448cb6f0( "run", "mine_zombie", 25 );
        }
    }
}

/#

    // Namespace namespace_b109f7cb70e0649d
    // Params 0
    // Checksum 0x162abcaa, Offset: 0x312d
    // Size: 0x5, Type: dev
    function function_26a5bbc990f02536()
    {
        
    }

#/

// Namespace namespace_b109f7cb70e0649d
// Params 1
// Checksum 0x7d595935, Offset: 0x313a
// Size: 0x29b
function function_cd5b4ae4bcba9728( struct_targetname )
{
    level endon( #"game_ended", #"flag_tunnels_pit_complete" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( !isdefined( struct_targetname ) )
    {
        struct_targetname = "s_obj_tunnels_mine_01";
    }
    
    var_9f459f28678c13e0 = utility::getstruct( struct_targetname, "targetname" );
    requestid = activity_instance activity_ai_encounters::function_306a1676777f93e2( "enc_vol_mine_zombie_player_flood" );
    
    if ( !isdefined( requestid ) )
    {
        return;
    }
    
    var_9f459f28678c13e0.requestid = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "enc_vol_mine_zombie_player_flood", 0, 1, 1, 1 );
    activity_ai_encounters::function_52d1342183200a8f( var_9f459f28678c13e0.requestid, &function_abca723e2719e60 );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( var_9f459f28678c13e0.requestid, &function_ec1428e869bfc8a5, var_9f459f28678c13e0 );
    activity_ai_encounters::function_d33de057e760c97b( var_9f459f28678c13e0.requestid, &function_b30b746834333af7, var_9f459f28678c13e0 );
    level utility::flag_wait( "flag_trig_tunnels_mine_progress_01" );
    wait 3;
    activity_ai_encounters::function_48582991402cac50( var_9f459f28678c13e0.requestid, 1 );
    s_forward = utility::getstruct( "s_obj_tunnels_mine_02", "targetname" );
    activity_instance thread gemini_util::function_a8d4d78033f6456d( var_9f459f28678c13e0.requestid, s_forward.origin, "flag_trig_tunnels_mine_progress_02" );
    var_9f459f28678c13e0.a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( var_9f459f28678c13e0.a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_alive_count = 2;
    }
    else
    {
        n_max_alive_count = 3;
    }
    
    function_bbd192652d1a9e18( var_9f459f28678c13e0.requestid, n_max_alive_count );
    function_a748fd0f51127844( var_9f459f28678c13e0.requestid, 5 );
    level utility::flag_wait( "flag_trig_tunnels_mine_progress_02" );
    waitframe();
    s_forward = utility::getstruct( "s_obj_tunnels_mine_02_jumpdown", "targetname" );
    activity_instance thread gemini_util::function_a8d4d78033f6456d( var_9f459f28678c13e0.requestid, s_forward.origin, "flag_trig_tunnels_mine_gate_02_complete" );
    var_9f459f28678c13e0.a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( var_9f459f28678c13e0.a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_alive_count = 3;
    }
    else
    {
        n_max_alive_count = 5;
    }
    
    function_bbd192652d1a9e18( var_9f459f28678c13e0.requestid, n_max_alive_count );
    function_a748fd0f51127844( var_9f459f28678c13e0.requestid, 4 );
    level utility::flag_wait( "flag_trig_tunnels_mine_gate_02_complete" );
    
    if ( isdefined( var_9f459f28678c13e0.requestid ) )
    {
        ai_spawn_director::cancel_spawn_request( var_9f459f28678c13e0.requestid, 0, 1 );
    }
}

// Namespace namespace_b109f7cb70e0649d
// Params 2
// Checksum 0x9dffc634, Offset: 0x33dd
// Size: 0x28, Type: bool
function function_ec1428e869bfc8a5( requestid, userdata )
{
    if ( level utility::flag( "flag_trig_tunnels_mine_gate_02_complete" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_b109f7cb70e0649d
// Params 0
// Checksum 0x8e94c652, Offset: 0x340e
// Size: 0x108
function function_bcd53f98928f5c51()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct gemini_util::function_d65cdd8f6bd452b( self );
    self.team = "team_two_hundred";
    gemini_util::function_54a189c04c75a149( 1, 2048 );
    zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    
    if ( utility::percent_chance( 75 ) )
    {
        move_speed = "run";
    }
    else
    {
        move_speed = "sprint";
    }
    
    zombie_utils::function_a8ce00e0448cb6f0( move_speed, "mine_zombie", 25 );
    
    if ( isdefined( scene_struct ) && isdefined( scene_struct.var_b60496d5b429ae0f ) )
    {
        utility::flag_wait( scene_struct.var_b60496d5b429ae0f );
    }
    
    thread gemini_util::ai_delete_when_out_of_sight( 1024, 2048 );
    level utility::flag_wait( "flag_tunnels_pit_complete" );
    self notify( #"hash_fc42fb143ecc3617" );
    waitframe();
    thread gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_b109f7cb70e0649d
// Params 4
// Checksum 0xb2c2600, Offset: 0x351e
// Size: 0xda
function function_abca723e2719e60( requestid, userdata, agent, data )
{
    agent callback::callback( "on_mine_ai_spawned" );
    agent.team = "team_two_hundred";
    agent gemini_util::function_54a189c04c75a149( 1, 2048 );
    agent zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    
    if ( utility::percent_chance( 75 ) )
    {
        move_speed = "run";
    }
    else
    {
        move_speed = "sprint";
    }
    
    agent zombie_utils::function_a8ce00e0448cb6f0( move_speed, "mine_zombie", 25 );
    agent thread gemini_util::ai_delete_when_out_of_sight( 768, 1536 );
    level utility::flag_wait( "flag_tunnels_pit_complete" );
    agent notify( #"hash_fc42fb143ecc3617" );
    waitframe();
    agent thread gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_b109f7cb70e0649d
// Params 2
// Checksum 0xbe34df20, Offset: 0x3600
// Size: 0x35, Type: bool
function function_b30b746834333af7( requestid, userdata )
{
    if ( level utility::flag( "flag_trig_tunnels_mine_gate_02_complete" ) )
    {
        /#
            iprintlnbold( "<dev string:xc0>" );
        #/
        
        return true;
    }
    
    return false;
}

/#

    // Namespace namespace_b109f7cb70e0649d
    // Params 0
    // Checksum 0x8ab22523, Offset: 0x363e
    // Size: 0x5, Type: dev
    function function_d17e65506d4163c9()
    {
        
    }

#/

// Namespace namespace_b109f7cb70e0649d
// Params 1, eflags: 0x4
// Checksum 0x896a5172, Offset: 0x364b
// Size: 0x44f
function private function_5868e9f25176a726( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    player childthread gemini_util::function_57180a47f178d6d6( "trig_tunnels_mine_progress_03", "flag_trig_tunnels_mine_progress_03" );
    player childthread gemini_util::function_57180a47f178d6d6( "trig_tunnels_mine_gate_02_begin", "flag_trig_tunnels_mine_gate_02_begin" );
    
    foreach ( obj_id in activity_instance.a_obj_id )
    {
        objective_removeclientfrommask( obj_id, player );
    }
    
    if ( !player.player_objective )
    {
        player.player_objective = spawnstruct();
    }
    
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_TUNNELS_MINE_ESCAPE" );
    player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_tunnels_mine_01", player, 16, undefined, undefined, "active" );
    player utility::ent_flag_wait( "flag_ent_tunnels_mine_gate_01_reached" );
    ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
    waitframe();
    level utility::flag_wait_or_timeout( "flag_tunnels_mine_gate_01_interact", 10 );
    
    if ( !utility::flag( "flag_tunnels_mine_gate_01_interact" ) )
    {
        e_tunnels_mine_gate_01_interact = gemini_util::get_scriptable( "e_tunnels_mine_gate_01_interact", #targetname );
        player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( e_tunnels_mine_gate_01_interact.origin, player, 72, undefined, "sat_ob_objectivemarker_storymissionmain" );
        level utility::flag_wait( "flag_tunnels_mine_gate_01_interact" );
        ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
        waitframe();
    }
    
    player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_tunnels_mine_02", player, 16, undefined, undefined, "active" );
    player utility::ent_flag_wait( "flag_trig_tunnels_mine_progress_03" );
    ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
    waitframe();
    player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_tunnels_mine_03", player, 16, undefined, undefined, "active" );
    player utility::ent_flag_wait( "flag_trig_tunnels_mine_gate_02_begin" );
    ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
    waitframe();
    level utility::flag_wait( "flag_tunnels_mine_gate_02_walkway_vo_callout" );
    
    if ( !player utility::ent_flag( "flag_ent_tunnels_mine_gate_02_walkway" ) )
    {
        player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_tunnels_mine_04", player, 52, undefined, undefined, "active" );
        player utility::ent_flag_wait_any( "flag_ent_tunnels_mine_gate_02_walkway", "flag_ent_tunnels_mine_gate_02_complete" );
        ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
        waitframe();
    }
    
    if ( player utility::ent_flag( "flag_ent_tunnels_mine_gate_02_walkway" ) && !utility::flag( "flag_tunnels_mine_gate_02_interact" ) )
    {
        e_tunnels_mine_gate_02_interact = gemini_util::get_scriptable( "e_tunnels_mine_gate_02_interact", #targetname );
        player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( e_tunnels_mine_gate_02_interact.origin, player, 68, undefined, "sat_ob_objectivemarker_storymissionmain" );
        
        while ( !utility::flag( "flag_tunnels_mine_gate_02_interact" ) && !player utility::ent_flag( "flag_ent_tunnels_mine_gate_02_complete" ) )
        {
            waitframe();
        }
        
        if ( player.player_objective.obj_id )
        {
            ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
            waitframe();
        }
    }
    
    player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_tunnels_mine_05", player, 16, undefined, undefined, "active" );
    level utility::flag_wait( "flag_tunnels_mine_complete" );
    ob_story_mission_utils::objective_text_clear();
    ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
}

// Namespace namespace_b109f7cb70e0649d
// Params 1, eflags: 0x4
// Checksum 0x282e4ff5, Offset: 0x3aa2
// Size: 0xc5
function private function_20d579339e91eb4( params )
{
    player = self;
    
    if ( level.var_3ce1f8d9700aaa07 )
    {
        switch ( level.var_3ce1f8d9700aaa07 )
        {
            case #"hash_998da8664b8a5a0e":
                player utility::ent_flag_set( "flag_ent_tunnels_mine_gate_02_walkway" );
            case #"hash_998dab664b8a5ec7":
                player utility::ent_flag_set( "flag_trig_tunnels_mine_gate_02_begin" );
            case #"hash_998a8a664b87ec3d":
            case #"hash_998daa664b8a5d34":
            case #"hash_998dad664b8a61ed":
                player utility::ent_flag_set( "flag_trig_tunnels_mine_progress_03" );
            case #"hash_998a83664b87e138":
                player utility::ent_flag_set( "flag_ent_tunnels_mine_gate_01_reached" );
            default:
                break;
        }
    }
}

