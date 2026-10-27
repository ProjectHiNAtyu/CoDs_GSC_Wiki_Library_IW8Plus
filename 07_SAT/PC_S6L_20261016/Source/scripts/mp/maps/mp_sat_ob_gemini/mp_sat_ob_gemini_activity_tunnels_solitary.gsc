// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_tunnels_solitary.gsc  (hash_17609dccae94edad.gscc) (size: 22768 Bytes / 0x58f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd3714eca (3547418314)
// size ...... 22768 (0x58f0)
// includes .. 24  (offset: 0x5124)
// strings ... 102 (offset: 0x51e4)
// dev strs .. 4   (offset: 0x58c0)
// exports ... 49  (offset: 0x3280)
// cseg ...... 0xba1 + 0x26df (0x3280)
// imports ... 188 (offset: 0x3a28)
// animtree1 . 0   (offset: 0x58f0)
// animtree2 . 0   (offset: 0x58f0)
#using script_3edd59d0d3fc3262;
#using script_4c1e16e1162d066f;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\chyron;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_tunnels_prison;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_audio;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\objective_marker_bundle_helper_mp;
#using scripts\mp\objidpoolmanager;

#namespace namespace_5c78ef15c79ef44d;

// Namespace namespace_5c78ef15c79ef44d
// Params 0, eflags: 0x5
// Checksum 0xd57f00d5, Offset: 0xbbf
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_792054be573dbf03", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0, eflags: 0x4
// Checksum 0xd0f3ec01, Offset: 0xbe8
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_TUNNELS_SOLITARY";
    activity_common::registeractivitytype( "OB_GEMINI_TUNNELS_SOLITARY", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_SOLITARY", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_SOLITARY", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_SOLITARY", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_TUNNELS_SOLITARY" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0x522640ee, Offset: 0xc5f
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance tunnels_solitary_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0xe6c30f0f, Offset: 0xcc4
// Size: 0x56
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    story_contract_util::mark_complete( level.players, #"gemini_launch" );
    activity_instance tunnels_solitary_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0x9e9060ec, Offset: 0xd22
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x486f54ee, Offset: 0xd46
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread tunnels_solitary_player_setup( player );
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0xa5864d1f, Offset: 0xe02
// Size: 0x16
function tunnels_solitary_start()
{
    activity_instance = self;
    ob_story_mission_utils::function_6314f03dfe2adbc5();
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0x5aa00a39, Offset: 0xe20
// Size: 0x120
function tunnels_solitary_main()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    setomnvar( "ui_hide_player_icons", 1 );
    level thread gemini_util::gemini_hide_minimap();
    level thread namespace_82ef26b728b2fd29::tunnels_prison_init();
    waitframe();
    
    /#
        activity_instance thread gemini_util::function_d6c199899ef5b468( "<dev string:x24>", "<dev string:x3f>", "<dev string:x69>" );
    #/
    
    waitframe();
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_tunnels_solitary_equipment", "flag_tunnels_prison_complete", 1 );
    
    if ( !isdefined( level.a_players_yel ) || !isdefined( level.a_players_grn ) )
    {
        level.a_players_yel = [];
        level.a_players_grn = [];
    }
    
    activity_instance thread function_9eedae0039850e0d( "grn_01", "grn" );
    activity_instance thread function_9eedae0039850e0d( "grn_02", "grn" );
    activity_instance thread function_9eedae0039850e0d( "yel_01", "yel" );
    activity_instance thread function_9eedae0039850e0d( "yel_02", "yel" );
    waitframe();
    activity_instance childthread gemini_vo::function_e0aa5fb9dfd7613e();
    activity_instance childthread function_be9b48510f60a333();
    level utility::flag_wait( "flag_tunnels_solitary_checkpoint_complete" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x533f4a29, Offset: 0xf48
// Size: 0xbf
function tunnels_solitary_player_setup( player )
{
    activity_instance = self;
    activity_instance notify( #"player_joined_activity" );
    player thread gemini_util::player_cold_breath_toggle( "flag_tunnels_pit_complete" );
    player thread gemini_util::function_22bc129d80ed2fc7( 2 );
    player thread gemini_util::function_eac36da555a7ceb4();
    player thread gemini_util::function_8f5ecb74b92331c( 5, "flag_trig_tunnels_solitary_begin" );
    player thread function_1cb7a30a0173035c();
    player utility::ent_flag_wait_or_timeout( "ob_sm_player_in_position", 5 );
    callback::callback( #"hash_131977a65232ba05", { #player:player } );
    player thread gemini_util::function_87124b79a77abfe2( "flag_tunnels_prison_complete" );
    player thread function_d554ed4594635b57();
    player armor::function_b359444c252374fc( 0 );
    player armor::setarmorhealth( 0, 1, 1 );
}

/#

    // Namespace namespace_5c78ef15c79ef44d
    // Params 0
    // Checksum 0xc54a1a64, Offset: 0x100f
    // Size: 0x5, Type: dev
    function function_3f9921ac2bcc8ab7()
    {
        
    }

#/

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0xd3740d15, Offset: 0x101c
// Size: 0x3b
function function_be9b48510f60a333()
{
    activity_instance = self;
    wait 1;
    activity_instance thread namespace_78b1c18caf50ee83::function_d41002779543c80e();
    utility::flag_wait_or_timeout( "flag_tunnels_solitary_intro_vo_complete", 30 );
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_TUNNELS_SOLITARY" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 2
// Checksum 0xaa8c186c, Offset: 0x105f
// Size: 0x2e5
function function_9eedae0039850e0d( str_direction, str_wing )
{
    level endon( #"game_ended", #"flag_tunnels_anteroom_doors_locked" );
    activity_instance = self;
    activity_instance thread function_fd4b2e7323df679d( str_direction, str_wing );
    level waittill( "tunnels_solitary_" + str_direction + "_spawn", player );
    player thread function_f4755946b0ce1fd2( str_direction );
    activity_instance thread function_b8cfc052185( str_direction, "door_tunnels_solitary_" + str_direction + "_begin", 1, 0, 1 );
    activity_instance thread function_ddbf1897ae4eadcd( str_direction, str_wing );
    activity_instance thread gemini_util::function_b2e3b9ccdce5ec87( "scene_tunnels_solitary_half_eaten_zmb_" + str_direction, undefined, undefined, undefined, "flag_tunnels_solitary_cell_cleanup_" + str_direction, 1 );
    thread function_31603421167db68c( str_direction );
    level utility::flag_wait( "flag_trig_tunnels_solitary_" + str_direction + "_begin" );
    level utility::flag_set( "flag_tunnels_solitary_" + str_wing + "_begin" );
    level utility::flag_set( "flag_tunnels_solitary_begin" );
    activity_instance thread function_b315fb5e480c87b3( str_direction, "s_tunnels_solitary_scene_" + str_direction, 0, undefined, "flag_tunnels_solitary_cell_cleanup_" + str_direction );
    level utility::flag_wait( "flag_trig_tunnels_solitary_" + str_direction + "_midpoint" );
    level utility::flag_set( "flag_tunnels_solitary_" + str_wing + "_midpoint" );
    level utility::flag_set( "flag_tunnels_solitary_midpoint" );
    
    if ( !level utility::flag( "flag_tunnels_solitary_checkpoint_" + str_wing + "_setup" ) )
    {
        level utility::flag_set( "flag_tunnels_solitary_checkpoint_" + str_wing + "_setup" );
        level thread ob_story_mission_utils::function_b0bc4cf3be6ad752( "trig_tunnels_solitary_fall_teleport", "flag_tunnels_anteroom_doors_locked" );
        activity_instance thread gemini_util::function_bad374b9f21345b( "e_tunnels_solitary_checkpoint_gate_" + str_wing, "flag_tunnels_solitary_checkpoint_gate_" + str_wing + "_open", "flag_tunnels_solitary_checkpoint_gate_" + str_wing + "_interact", "flag_tunnels_anteroom_doors_locked", "flag_tunnels_solitary_checkpoint_gate_" + str_wing + "_close" );
        activity_instance thread function_6bf0d9dea2dda840( "e_tunnels_solitary_checkpoint_gate_" + str_wing + "_interact", "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_begin", "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_gate", "flag_tunnels_solitary_checkpoint_gate_" + str_wing + "_interact" );
        activity_instance thread tunnels_solitary_screen_setup( str_wing );
        activity_instance thread function_751eaec22dd52a0f( str_wing );
        activity_instance thread function_4ebe0d3678aae66( str_wing );
        activity_instance thread function_86347a5f439c5e25( str_wing );
        level thread function_229a5c2fb17019d9( str_wing );
    }
    
    level utility::flag_wait( "flag_trig_tunnels_solitary_" + str_direction + "_complete" );
    level utility::flag_set( "flag_tunnels_solitary_" + str_wing + "_complete" );
    level utility::flag_set( "flag_tunnels_solitary_complete" );
    player thread gemini_audio::vortex_drone_audio( str_wing );
    level utility::flag_wait( "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_begin" );
    level utility::flag_set( "flag_tunnels_solitary_checkpoint_begin" );
    level utility::flag_wait( "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_midpoint" );
    level utility::flag_set( "flag_tunnels_solitary_checkpoint_midpoint" );
    level utility::flag_wait( "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_complete" );
    level utility::flag_set( "flag_tunnels_solitary_checkpoint_complete" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 2
// Checksum 0x58e550ad, Offset: 0x134c
// Size: 0x1e5
function function_fd4b2e7323df679d( str_direction, str_wing )
{
    level endon( #"game_ended", #"flag_tunnels_anteroom_doors_locked" );
    activity_instance = self;
    
    if ( level utility::flag( "flag_tunnels_anteroom_doors_locked" ) )
    {
        return;
    }
    
    trigger_targetname = "trig_tunnels_solitary_" + str_direction + "_spawn";
    a_trig_ent = getentarray( trigger_targetname, #targetname );
    a_trig_noent = getnoentvolumearray( trigger_targetname, #targetname );
    var_5cba3aa7cba1a93c = arraycombine( a_trig_ent, a_trig_noent );
    
    if ( var_5cba3aa7cba1a93c.size == 0 )
    {
        assertmsg( "<dev string:x85>" + trigger_targetname );
        return;
    }
    
    trig = var_5cba3aa7cba1a93c[ 0 ];
    a_trig_players = [];
    
    while ( true )
    {
        trig waittill( #"trigger", data );
        
        if ( isplayer( data ) && !arraycontains( a_trig_players, data ) )
        {
            player = data;
            a_trig_players = arraycombineunique( a_trig_players, [ player ] );
            
            if ( str_wing == "yel" )
            {
                level.a_players_yel = arraycombineunique( level.a_players_yel, [ player ] );
            }
            else
            {
                level.a_players_grn = arraycombineunique( level.a_players_grn, [ player ] );
            }
            
            player.var_a4e7c98c5f9cf831 = str_direction;
            activity_instance thread gemini_vo::function_8022702ab5ef4b4a( player, str_wing );
            player thread gemini_util::function_a91d3ea2a794cb12( "s_obj_start_tunnels_solitary_" + str_direction );
            player utility::ent_flag_set( "flag_trig_tunnels_solitary_" + str_wing + "_spawn" );
            level utility::flag_set( "flag_tunnels_solitary_" + str_direction + "_spawn" );
            level utility::flag_set( "flag_tunnels_solitary_spawn", player );
            level notify( "tunnels_solitary_" + str_direction + "_spawn", player );
        }
        
        waitframe();
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 4
// Checksum 0x33057a33, Offset: 0x1539
// Size: 0x27c
function function_6bf0d9dea2dda840( var_a215efb33367e147, flag_start_timer, flag_near_gate, flag_interact )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    var_8713485142ad4620 = gemini_util::get_scriptable( var_a215efb33367e147 );
    level utility::flag_wait( flag_start_timer );
    
    if ( utility::flag( "flag_tunnels_prison_complete" ) || getdvarint( @"hash_ba456a5b60ed68f8", 0 ) )
    {
        var_9cdb275ab462ba95 = 3;
        var_9cff115ab48b04eb = 1;
    }
    else
    {
        var_9cdb275ab462ba95 = 30;
        var_9cff115ab48b04eb = 10;
    }
    
    level utility::flag_wait_or_timeout( flag_near_gate, var_9cdb275ab462ba95 );
    wait var_9cff115ab48b04eb;
    
    if ( !utility::flag( flag_interact ) )
    {
        a_players = [];
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && player utility::ent_flag( flag_start_timer ) )
            {
                a_players = arraycombineunique( a_players, [ player ] );
            }
        }
        
        if ( a_players.size > 0 )
        {
            obj_id = objective_marker_bundle_helper_mp::mp_createobjectivemarkerfrombundlexhash( %"objectivemarker:sat_ob_objectivemarker_storymissionmain" );
            objidpoolmanager::objective_set_play_intro( obj_id, 0 );
            objidpoolmanager::objective_set_play_outro( obj_id, 0 );
            objidpoolmanager::update_objective_position( obj_id, var_8713485142ad4620.origin + ( 0, 0, 52 ) + ( 0, 0, 16 ) );
            objidpoolmanager::objective_playermask_hidefromallplayers( obj_id );
            function_2b8e3d3ae2a6414a( obj_id, 0 );
            ob_story_mission_utils::function_e7dea8423bedc2b6( obj_id, level.players );
            waitframe();
            
            foreach ( player in a_players )
            {
                if ( isalive( player ) )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( obj_id, player );
                }
            }
            
            utility::flag_wait( flag_interact );
            ob_story_mission_utils::function_6c52650cb36dd9d3( obj_id, a_players );
            
            if ( !objidpoolmanager::function_fb05d646a96ed99e( obj_id ) )
            {
                objidpoolmanager::returnobjectiveid( obj_id );
            }
        }
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x9fd8e41e, Offset: 0x17bd
// Size: 0x64
function tunnels_solitary_screen_setup( str_wing )
{
    level endon( #"game_ended" );
    activity_instance = self;
    level gemini_util::function_401a0ddccdf00715( "tunnels_solitary_screen_01_" + str_wing );
    activity_instance thread gemini_util::function_60475284edbb43a8( 1, "sat_gemini_monitor_alex_1", "bink1", 0, "tunnels_solitary_screen_01_" + str_wing, "flag_tunnels_solitary_checkpoint_gate_" + str_wing + "_interact" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x7ee3f0bd, Offset: 0x1829
// Size: 0x72
function function_4ebe0d3678aae66( str_wing )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance thread gemini_util::function_b04c2801b2760aff( "s_tunnels_solitary_mason_ghost_01_" + str_wing );
    level utility::flag_wait_any( "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_midpoint", "flag_tunnels_solitary_checkpoint_gate_" + str_wing + "_interact", "flag_tunnels_solitary_zombie_killed_" + str_wing );
    level utility::flag_set( "flag_tunnels_solitary_mason_ghost_move_" + str_wing );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 2
// Checksum 0xb51e99e, Offset: 0x18a3
// Size: 0x113
function function_ddbf1897ae4eadcd( str_direction, str_wing )
{
    activity_instance = self;
    struct_targetname = "scene_tunnels_solitary_prop_zmb_" + str_direction;
    var_b60496d5b429ae0f = "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_complete";
    trig_cleanup = getnoentvolumearray( "trig_tunnels_solitary_" + str_wing, #targetname )[ 0 ];
    var_704f37bf85217934 = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( var_704f37bf85217934.size > 0 )
    {
        var_704f37bf85217934 = utility::array_random_slice( var_704f37bf85217934, randomintrange( 1, 3 ) );
        
        foreach ( s_scene in var_704f37bf85217934 )
        {
            s_scene thread function_a2e5fa4d8972ed38( activity_instance, var_b60496d5b429ae0f, trig_cleanup );
            waitframe();
        }
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x3f2a13fb, Offset: 0x19be
// Size: 0xf8
function function_86347a5f439c5e25( str_wing )
{
    activity_instance = self;
    struct_targetname = "scene_tunnels_solitary_floating_zmb_" + str_wing;
    var_b60496d5b429ae0f = "flag_trig_tunnels_solitary_checkpoint_" + str_wing + "_complete";
    trig_cleanup = getnoentvolumearray( "trig_tunnels_solitary_" + str_wing, #targetname )[ 0 ];
    var_704f37bf85217934 = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( var_704f37bf85217934.size > 0 )
    {
        foreach ( s_scene in var_704f37bf85217934 )
        {
            s_scene thread function_a2e5fa4d8972ed38( activity_instance, var_b60496d5b429ae0f, trig_cleanup );
            waitframe();
        }
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 3
// Checksum 0x747be275, Offset: 0x1abe
// Size: 0xc6
function function_a2e5fa4d8972ed38( activity_instance, var_b60496d5b429ae0f, trig_cleanup )
{
    level endon( #"game_ended" );
    self endon( #"hash_dd2833e68cb66f88" );
    wait randomfloatrange( 0.1, 0.9 );
    
    if ( level utility::flag( var_b60496d5b429ae0f ) )
    {
        return;
    }
    
    level endon( var_b60496d5b429ae0f );
    thread function_2de8e0107c042c04( var_b60496d5b429ae0f, trig_cleanup );
    
    if ( self.script_scenescriptbundle == "sat_cin_ob_gemini_zombie_floating_prop" )
    {
        shot = utility::array_random( [ "looping_idle_b", "looping_idle_l", "looping_idle_r" ] );
    }
    else
    {
        shot = "looping_idle";
    }
    
    thread scene::play( undefined, [ shot ] );
    thread gemini_util::function_1f3f685c332568e2( "Prop 1" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 2
// Checksum 0xa9de8327, Offset: 0x1b8c
// Size: 0x6d
function function_2de8e0107c042c04( var_b60496d5b429ae0f, trig_cleanup )
{
    level endon( #"game_ended" );
    level utility::flag_wait_any( var_b60496d5b429ae0f, "flag_tunnels_anteroom_doors_locked" );
    
    while ( !utility::flag( "flag_tunnels_anteroom_doors_locked" ) )
    {
        if ( !trig_cleanup gemini_util::function_73bd7925ab7e8a36( 0 ) )
        {
            break;
        }
        
        wait 1;
    }
    
    scene::cleanup( 1 );
    self notify( #"hash_dd2833e68cb66f88" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0xce43ae4a, Offset: 0x1c01
// Size: 0x182
function function_f4755946b0ce1fd2( str_direction )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level utility::flag_wait( "scriptables_ready" );
    exit_door = gemini_util::get_scriptable( "security_door_solitary_exit_" + str_direction );
    var_5cba3aa7cba1a93c = getnoentvolumearray( "trig_tunnels_solitary_" + str_direction, #targetname );
    
    if ( var_5cba3aa7cba1a93c.size == 0 )
    {
        return;
    }
    
    trig = var_5cba3aa7cba1a93c[ 0 ];
    utility::ent_flag_wait( "flag_trig_tunnels_solitary_checkpoint_begin" );
    
    while ( true )
    {
        players = ob_story_mission_utils::get_playing_players();
        var_e318a553d1d911e0 = 0;
        
        if ( players.size > 0 )
        {
            foreach ( player in players )
            {
                if ( player istouching( trig ) )
                {
                    var_e318a553d1d911e0 = 1;
                }
            }
        }
        
        if ( !var_e318a553d1d911e0 )
        {
            break;
        }
        
        wait 0.5;
    }
    
    if ( !exit_door scriptabledoorisclosed() )
    {
        exit_door scriptabledoorclose();
        waitframe();
        
        while ( true )
        {
            if ( exit_door scriptabledoorisclosed() )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    waitframe();
    exit_door scriptabledoorlock();
    waitframe();
    exit_door scriptabledoorfreeze();
    level utility::flag_set( "flag_tunnels_solitary_cell_cleanup_" + str_direction );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0xca106578, Offset: 0x1d8b
// Size: 0x125
function function_229a5c2fb17019d9( str_wing )
{
    level endon( #"game_ended" );
    var_5cba3aa7cba1a93c = getnoentvolumearray( "trig_tunnels_solitary_" + str_wing, #targetname );
    
    if ( var_5cba3aa7cba1a93c.size == 0 )
    {
        return;
    }
    
    trig = var_5cba3aa7cba1a93c[ 0 ];
    level utility::flag_wait( "flag_trig_tunnels_prison_hilo_begin_" + str_wing );
    
    while ( true )
    {
        players = ob_story_mission_utils::get_playing_players();
        var_e318a553d1d911e0 = 0;
        
        if ( players.size > 0 )
        {
            foreach ( player in players )
            {
                if ( player istouching( trig ) )
                {
                    var_e318a553d1d911e0 = 1;
                }
            }
        }
        
        if ( !var_e318a553d1d911e0 )
        {
            break;
        }
        
        wait 0.5;
    }
    
    waitframe();
    level utility::flag_set( "flag_tunnels_solitary_checkpoint_gate_" + str_wing + "_close" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x173b472d, Offset: 0x1eb8
// Size: 0x154
function function_31603421167db68c( str_direction )
{
    level endon( #"game_ended", #"flag_tunnels_anteroom_doors_locked" );
    activity_instance = self;
    level utility::flag_wait( "scriptables_ready" );
    door_targetname = "security_door_solitary_closet_" + str_direction;
    a_doors = gemini_util::function_d5f3a036e837913( door_targetname );
    
    if ( a_doors.size == 0 )
    {
        return;
    }
    
    a_doors = arrayrandomize( a_doors );
    a_doors[ 0 ] gemini_util::scriptable_door_lock( 1 );
    light_closet = getent( "tunnels_solitary_closet_light_" + str_direction, #targetname );
    waitframe();
    creepy_door = a_doors[ 1 ];
    var_704f37bf85217934 = creepy_door utility::get_linked_structs();
    
    if ( var_704f37bf85217934.size > 0 )
    {
        var_6ee9ef0e4f1ea64b = utility::array_random( var_704f37bf85217934 );
        var_6ee9ef0e4f1ea64b thread scene::play();
        var_6ee9ef0e4f1ea64b thread gemini_util::function_1f3f685c332568e2();
        waitframe();
        s_ajar = utility::getstruct( var_6ee9ef0e4f1ea64b.target, "targetname" );
        creepy_door gemini_util::function_c961de572d334f4a( "away", 1, s_ajar.origin );
        function_ed7bcdbb61a7a166( str_direction );
        creepy_door function_7b2546fb062f24e1( light_closet );
        wait 1;
        var_6ee9ef0e4f1ea64b thread gemini_util::scene_zombie_cleanup( "flag_trig_tunnels_solitary_" + str_direction + "_midpoint" );
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x360289f2, Offset: 0x2014
// Size: 0xc7
function function_ed7bcdbb61a7a166( str_direction )
{
    level endon( #"game_ended", "flag_trig_tunnels_solitary_" + str_direction + "_midpoint" );
    trig = getnoentvolumearray( "trig_tunnels_solitary_" + str_direction + "_no_sprint", #targetname )[ 0 ];
    
    if ( isdefined( trig ) )
    {
        trig waittill( #"trigger", player );
        
        while ( true )
        {
            if ( utility::flag( "flag_trig_tunnels_solitary_" + str_direction + "_midpoint" ) )
            {
                break;
            }
            
            if ( isdefined( player ) && player istouching( trig ) && player issprinting() )
            {
                break;
            }
            
            waitframe();
        }
        
        return;
    }
    
    level utility::flag_wait( "flag_trig_tunnels_solitary_" + str_direction + "_midpoint" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x375dd718, Offset: 0x20e3
// Size: 0x123
function function_7b2546fb062f24e1( light_closet )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    
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
    
    players = getplayersinradius( self.origin, 800 );
    
    if ( players.size > 0 )
    {
        foreach ( player in players )
        {
            player thread gemini_util::function_9623f1811bc192b4();
        }
    }
    else
    {
        earthquake( 0.2, 0.2, self.origin, 800 );
        playrumbleonposition( "damage_light", self.origin );
    }
    
    waitframe();
    self scriptabledoorlock();
    
    if ( isdefined( light_closet ) )
    {
        light_closet setlightintensity( 0 );
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0xdb248501, Offset: 0x220e
// Size: 0x3f
function function_1508020ffff15f63( str_wing )
{
    adz_solitary = ob_adz::function_47e86714392d46b4( "s_tunnels_solitary_checkpoint_adz_" + str_wing );
    adz_solitary thread ob_adz::function_f0f0de6800121e38( "flag_tunnels_prison_complete", adz_solitary.zone_id );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x253bea32, Offset: 0x2255
// Size: 0x62
function function_5934fb64e7bae25d( str_wing )
{
    activity_instance = self;
    s_scene = utility::getstruct( "s_scene_tunnels_solitary_checkpoint_zombie_" + str_wing, "targetname" );
    s_scene.flag_set_death = "flag_tunnels_solitary_zombie_killed_" + str_wing;
    s_scene thread gemini_util::function_b2756775cf47c934( activity_instance, "flag_tunnels_solitary_checkpoint_" + str_wing + "_complete" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0xbfc996a8, Offset: 0x22bf
// Size: 0x9b
function function_751eaec22dd52a0f( str_wing )
{
    activity_instance = self;
    s_scene = utility::getstruct( "s_scene_tunnels_solitary_checkpoint_zombie_alt_" + str_wing, "targetname" );
    s_scene.flag_set_death = "flag_tunnels_solitary_zombie_killed_" + str_wing;
    s_scene scene::add_spawn_function( &function_d9468e538e3fa257, "_object_all_" );
    s_scene thread gemini_util::function_dc1fe98b2ae81f42( activity_instance, "flag_tunnels_solitary_checkpoint_" + str_wing + "_complete", "flag_tunnels_solitary_checkpoint_" + str_wing + "_inmates_alerted", "flag_tunnels_solitary_checkpoint_" + str_wing + "_inmates_dead" );
    activity_instance thread function_f593640d02c716c6( s_scene );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0xc8acac06, Offset: 0x2362
// Size: 0x6a
function function_d9468e538e3fa257()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    if ( self.sceneobjectdata.sceneobject.variant_object.name == "Actor 3" )
    {
        self.skipbloodpool = 1;
    }
    
    level utility::flag_wait( "flag_tunnels_prison_cellblock_a_begin" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 5
// Checksum 0xb04fc5c0, Offset: 0x23d4
// Size: 0x4d2
function function_b315fb5e480c87b3( str_direction, struct_noteworthy, b_begin, var_6761390ea63cd7c0, var_b60496d5b429ae0f )
{
    activity_instance = self;
    var_5fa90f1a51250bbf = utility::getstructarray( struct_noteworthy, "script_noteworthy" );
    
    if ( var_5fa90f1a51250bbf.size == 0 )
    {
        return;
    }
    
    var_5fa90f1a51250bbf = arrayrandomize( var_5fa90f1a51250bbf );
    
    if ( getdvarint( @"hash_72d2792673f49b64", 0 ) == 1 || !isdefined( var_6761390ea63cd7c0 ) )
    {
        var_6761390ea63cd7c0 = var_5fa90f1a51250bbf.size;
    }
    else
    {
        var_6761390ea63cd7c0 = maxint( var_5fa90f1a51250bbf.size, var_6761390ea63cd7c0 );
    }
    
    var_25973b759fe8ba45 = [];
    var_d613767111ff6f28 = [];
    
    for ( i = 0; i < var_5fa90f1a51250bbf.size ; i++ )
    {
        struct = var_5fa90f1a51250bbf[ i ];
        
        if ( isdefined( struct.script_linkto ) && var_6761390ea63cd7c0 > 0 )
        {
            if ( getdvarint( @"hash_72d2792673f49b64", 0 ) == 1 )
            {
                var_704f37bf85217934 = struct utility::get_linked_structs();
                
                for ( j = 0; j < var_704f37bf85217934.size ; j++ )
                {
                    s_scene = var_704f37bf85217934[ j ];
                    var_d613767111ff6f28[ var_d613767111ff6f28.size ] = s_scene;
                    
                    switch ( s_scene.script_scenescriptbundle )
                    {
                        case #"hash_f0025066efacaf32":
                            s_scene scene::add_spawn_function( &function_f35fc1442ae2a06e, "_object_all_" );
                            s_scene thread gemini_util::function_cdd368c95024c04f( activity_instance, "flag_tunnels_solitary_zmb_attack_" + str_direction, "flag_tunnels_solitary_zmb_attack_" + str_direction, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ), i * randomfloatrange( 0.5, 1.5 ) );
                            break;
                        case #"hash_92ffeaad2bba0bf8":
                        case #"hash_a83f766dcc79c9bb":
                        case #"hash_e7d99fba56c9fa3a":
                            s_scene thread gemini_util::function_cdd368c95024c04f( activity_instance, undefined, undefined, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ) );
                            break;
                        case #"hash_4a0e0b29fcf166d6":
                            s_scene thread gemini_util::function_b2756775cf47c934( activity_instance, undefined, undefined, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ) );
                            break;
                        case #"hash_cfe3cfa8e6a1626a":
                            s_scene thread gemini_util::function_cb83c9da238555e9( activity_instance, undefined, undefined, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ) );
                            break;
                        case #"hash_9476279e94ab8baf":
                            s_scene thread gemini_util::function_4848ed56c271729e( activity_instance, undefined, undefined, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ) );
                            break;
                        case #"hash_a5d60201596c9592":
                            s_scene thread gemini_util::function_f7cc57005c8a6db9( activity_instance, undefined, undefined, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ) );
                            break;
                        default:
                            break;
                    }
                    
                    waitframe();
                }
            }
            else
            {
                s_scene = struct function_6e060983f1c39a57( var_25973b759fe8ba45 );
                
                if ( isdefined( s_scene ) )
                {
                    var_d613767111ff6f28[ var_d613767111ff6f28.size ] = s_scene;
                    
                    switch ( s_scene.script_scenescriptbundle )
                    {
                        case #"hash_f0025066efacaf32":
                            s_scene scene::add_spawn_function( &function_f35fc1442ae2a06e, "_object_all_" );
                            s_scene thread gemini_util::function_cdd368c95024c04f( activity_instance, "flag_tunnels_solitary_zmb_attack_" + str_direction, "flag_tunnels_solitary_zmb_attack_" + str_direction, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ), i * randomfloatrange( 0.5, 1.5 ) );
                            break;
                        case #"hash_92ffeaad2bba0bf8":
                        case #"hash_a83f766dcc79c9bb":
                        case #"hash_e7d99fba56c9fa3a":
                            s_scene thread gemini_util::function_cdd368c95024c04f( activity_instance, undefined, undefined, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ) );
                            break;
                        case #"hash_4a0e0b29fcf166d6":
                            s_scene thread gemini_util::function_b2756775cf47c934( activity_instance, undefined, undefined, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ) );
                            break;
                        case #"hash_cfe3cfa8e6a1626a":
                            s_scene thread gemini_util::function_cb83c9da238555e9( activity_instance, undefined, undefined, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ) );
                            break;
                        case #"hash_9476279e94ab8baf":
                            s_scene thread gemini_util::function_4848ed56c271729e( activity_instance, undefined, undefined, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ) );
                            break;
                        case #"hash_a5d60201596c9592":
                            s_scene thread gemini_util::function_f7cc57005c8a6db9( activity_instance, undefined, undefined, undefined, var_b60496d5b429ae0f, randomfloatrange( 0.5, 1.5 ) );
                            break;
                        default:
                            break;
                    }
                    
                    var_6761390ea63cd7c0--;
                    
                    if ( s_scene.script_noteworthy != "scene_zombie_no_action" )
                    {
                        var_25973b759fe8ba45[ var_25973b759fe8ba45.size ] = s_scene.script_scenescriptbundle;
                    }
                }
            }
        }
        
        waitframe();
    }
    
    foreach ( s_scene in var_d613767111ff6f28 )
    {
        activity_instance thread function_f593640d02c716c6( s_scene );
        waitframe();
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0xf4d32d42, Offset: 0x28ae
// Size: 0xd1
function function_f593640d02c716c6( s_scene )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "flag_tunnels_prison_cellblock_a_begin" );
    
    if ( level.is_squad_size_small && level.players.size == 1 )
    {
        s_scene notify( #"scene_force_cleanup" );
        return;
    }
    
    fov = cos( 45 );
    
    while ( !utility::flag( "flag_tunnels_anteroom_doors_locked" ) )
    {
        a_players = getplayersinradius( s_scene.origin, 2048 );
        
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

// Namespace namespace_5c78ef15c79ef44d
// Params 5
// Checksum 0x5a0fd1f1, Offset: 0x2987
// Size: 0x162
function function_b8cfc052185( str_direction, door_targetname, b_begin = 1, var_6761390ea63cd7c0, var_d8baec258df27736 = 1 )
{
    a_doors = gemini_util::function_d5f3a036e837913( door_targetname );
    
    if ( a_doors.size == 0 )
    {
        return;
    }
    
    if ( b_begin )
    {
        a_doors = arraysort( a_doors, undefined, &function_5440bf71cab0e564 );
        begin_door = a_doors[ 0 ];
        a_doors = arrayremove( a_doors, a_doors[ 0 ] );
        a_doors = arrayrandomize( a_doors );
        a_doors = arraycombine( [ begin_door ], a_doors );
    }
    else
    {
        a_doors = arrayrandomize( a_doors );
    }
    
    for ( i = 0; i < a_doors.size ; i++ )
    {
        door = a_doors[ i ];
        
        if ( b_begin && i == 0 )
        {
            door function_24eab5a6e061f8e0();
        }
        else if ( utility::cointoss() && var_d8baec258df27736 > 0 )
        {
            door thread function_e2d7031d14914a7b( 1 );
            var_d8baec258df27736--;
        }
        else
        {
            n_rand = randomfloat( 100 );
            
            if ( n_rand > 75 )
            {
                door function_24eab5a6e061f8e0();
                
                if ( utility::cointoss() && var_d8baec258df27736 > 0 )
                {
                    door thread function_e2d7031d14914a7b( 0 );
                    var_d8baec258df27736--;
                }
            }
            else if ( n_rand > 25 )
            {
                door thread cell_door_lock();
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0x8c47f5ac, Offset: 0x2af1
// Size: 0x37
function function_f35fc1442ae2a06e()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    utility::ent_flag_wait( "zombie_scene_action" );
    thread gemini_util::function_ed27c47ead3f108a( 2 );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x2e96e99, Offset: 0x2b30
// Size: 0x99
function function_6e060983f1c39a57( var_25973b759fe8ba45 )
{
    var_704f37bf85217934 = utility::get_linked_structs();
    s_scene = undefined;
    
    if ( var_704f37bf85217934.size > 0 )
    {
        var_704f37bf85217934 = arraysort( var_704f37bf85217934, undefined, &function_d2a12aa3eb24a30e );
        
        for ( i = 0; i < var_704f37bf85217934.size ; i++ )
        {
            s_scene = var_704f37bf85217934[ i ];
            
            if ( isdefined( s_scene.script_scenescriptbundle ) )
            {
                if ( var_25973b759fe8ba45.size < randomintrange( 4, 6 ) )
                {
                    return s_scene;
                }
                
                if ( s_scene.script_noteworthy == "scene_zombie_no_action" )
                {
                    return s_scene;
                }
            }
        }
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 2, eflags: 0x4
// Checksum 0x8fade1b5, Offset: 0x2bd1
// Size: 0x54, Type: bool
function private function_d2a12aa3eb24a30e( a, b )
{
    if ( !isdefined( b.script_priority ) )
    {
        return true;
    }
    else if ( !isdefined( a.script_priority ) )
    {
        return false;
    }
    
    return a.script_priority >= b.script_priority;
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0xb488ee3d, Offset: 0x2c2e
// Size: 0x77
function function_e2d7031d14914a7b( var_ae740a76f0c8ef99 = 1 )
{
    while ( true )
    {
        n_radius = randomfloatrange( 192, 384 );
        var_147f36b70a2f8293 = getplayersinradius( self.origin, n_radius );
        
        if ( var_147f36b70a2f8293.size > 0 )
        {
            break;
        }
        
        wait 1;
    }
    
    if ( var_ae740a76f0c8ef99 )
    {
        function_24eab5a6e061f8e0();
        return;
    }
    
    thread cell_door_lock();
}

// Namespace namespace_5c78ef15c79ef44d
// Params 2
// Checksum 0xd13ce442, Offset: 0x2cad
// Size: 0x53, Type: bool
function function_5440bf71cab0e564( a, b )
{
    if ( a.script_noteworthy == "door_tunnels_solitary_cell_player" )
    {
        return true;
    }
    
    if ( isdefined( b.script_noteworthy ) && b.script_noteworthy != "door_tunnels_solitary_cell_player" )
    {
        return false;
    }
    
    return false;
}

/#

    // Namespace namespace_5c78ef15c79ef44d
    // Params 0
    // Checksum 0x1ba23593, Offset: 0x2d09
    // Size: 0x5, Type: dev
    function function_c1cefe5fcc723fc9()
    {
        
    }

#/

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0x3ece0605, Offset: 0x2d16
// Size: 0x82
function function_1cb7a30a0173035c()
{
    self endon( #"death_or_disconnect" );
    player::_freezecontrols( 1 );
    player::_freezelookcontrols( 1 );
    level utility::flag_wait_or_timeout( "story_mission_party_check_complete", 15 );
    wait 0.1;
    
    if ( self getclientomnvar( "ui_world_fade" ) > 0 )
    {
        game_utility::fadetoblackforplayerkeepui( self, 0, 1.5 );
    }
    
    if ( self getclientomnvar( "ui_total_fade" ) > 0 )
    {
        game_utility::fadetoblackforplayer( self, 0, 1.5 );
    }
    
    player::_freezecontrols( 0 );
    player::_freezelookcontrols( 0 );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0x629d7042, Offset: 0x2da0
// Size: 0x12e
function function_d554ed4594635b57()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level endon( #"flag_tunnels_prison_complete" );
    thread gemini_util::function_b89408bec75f5c14( "flag_tunnels_prison_complete", 1, 3, 1, "low", 0.6 );
    val::set( "solitary_intro", "sprint", 0 );
    waitframe();
    thread function_499f80b02ecb0122();
    thread function_7d5f73d34c82d683();
    utility::ent_flag_wait_or_timeout( "flag_trig_tunnels_solitary_begin", 10 );
    self notify( #"cancel_shellshock" );
    
    if ( !utility::ent_flag( "flag_trig_tunnels_solitary_begin" ) )
    {
        gemini_util::player_camera_sway_settings( 2 );
    }
    
    utility::ent_flag_wait( "flag_trig_tunnels_solitary_begin" );
    gemini_util::player_camera_sway_settings( 1.5 );
    self notify( #"cancel_change_speed" );
    thread gemini_util::player_change_speed( 0.75, 3 );
    val::set( "solitary_intro", "sprint", 1 );
    utility::ent_flag_wait( "flag_trig_tunnels_solitary_midpoint" );
    gemini_util::player_camera_sway_settings( 1 );
    self notify( #"cancel_change_speed" );
    thread gemini_util::player_change_speed( 0.85, 3 );
    utility::ent_flag_wait( "flag_trig_tunnels_solitary_checkpoint_begin" );
    thread gemini_util::function_16357e04a0cbe73d();
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0xf5cddc55, Offset: 0x2ed6
// Size: 0xdf
function function_499f80b02ecb0122()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    utility::ent_flag_wait_any( "flag_trig_tunnels_solitary_grn_spawn", "flag_trig_tunnels_solitary_yel_spawn" );
    var_550963bbb003c756 = ( 0, 0, 0 );
    
    if ( getdvarint( @"hash_ccecb2781660d0fc" ) == 1 )
    {
        if ( utility::ent_flag( "flag_trig_tunnels_solitary_grn_spawn" ) )
        {
            var_550963bbb003c756 = ( 0, 0, -4 );
        }
        else if ( utility::ent_flag( "flag_trig_tunnels_solitary_yel_spawn" ) )
        {
            var_550963bbb003c756 = ( 0, 0, 4 );
        }
    }
    else if ( utility::ent_flag( "flag_trig_tunnels_solitary_grn_spawn" ) )
    {
        var_550963bbb003c756 = ( 0, 0, -8 );
    }
    else if ( utility::ent_flag( "flag_trig_tunnels_solitary_yel_spawn" ) )
    {
        var_550963bbb003c756 = ( 0, 0, 8 );
    }
    
    self.var_550963bbb003c756 = var_550963bbb003c756;
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0x55797f99, Offset: 0x2fbd
// Size: 0x14f
function function_7d5f73d34c82d683()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", 6, undefined, [ self ] );
    player_utility::function_99d180c3f0ca93b8( self, "player_soundveil_shake_reduced_mp", 2 );
    var_1d38d06d1b0dc98 = 5;
    emp_debuff::play_emp_scramble( var_1d38d06d1b0dc98 );
    earthquake( 0.2, 3, self.origin, 512 );
    gemini_util::function_1cdd28af12b71f9c( -15, 0 );
    utility::ent_flag_wait_or_timeout( "flag_trig_tunnels_solitary_begin", 3 );
    
    if ( utility::ent_flag( "flag_trig_tunnels_solitary_begin" ) )
    {
        wait 1;
    }
    
    player_utility::function_c14762bb6e0b4edb( self );
    emp_debuff::stop_emp_scramble( var_1d38d06d1b0dc98 );
    waitframe();
    var_1d38d06d1b0dc98 = 3;
    emp_debuff::play_emp_scramble( var_1d38d06d1b0dc98 );
    earthquake( 0.1, 2, self.origin, 512 );
    gemini_util::player_fov_restore( 6 );
    utility::ent_flag_wait_or_timeout( "flag_trig_tunnels_solitary_begin", 3 );
    
    if ( utility::ent_flag( "flag_trig_tunnels_solitary_begin" ) )
    {
        wait 1;
    }
    
    emp_debuff::stop_emp_scramble( var_1d38d06d1b0dc98 );
    waitframe();
    var_1d38d06d1b0dc98 = 1;
    emp_debuff::play_emp_scramble( var_1d38d06d1b0dc98 );
    utility::ent_flag_wait_or_timeout( "flag_trig_tunnels_solitary_begin", 3 );
    player_utility::function_c14762bb6e0b4edb( self );
    emp_debuff::stop_emp_scramble( var_1d38d06d1b0dc98 );
    waitframe();
    emp_debuff::clear_emp_scramble();
}

/#

    // Namespace namespace_5c78ef15c79ef44d
    // Params 0
    // Checksum 0x7d59f4f7, Offset: 0x3114
    // Size: 0x5, Type: dev
    function function_699a1289ad7f47c5()
    {
        
    }

#/

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0x12c9fa7b, Offset: 0x3121
// Size: 0x20
function cell_door_open()
{
    level utility::flag_wait( "scriptables_ready" );
    utility::function_7c10ea82c1e305b8( "prison_door", "open" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x3d26d502, Offset: 0x3149
// Size: 0x61
function cell_door_close( b_immediate = 0 )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !b_immediate && !utility::function_9f2c41c1dcc8c94( "prison_door", "closed" ) )
    {
        utility::function_9f2c41c1dcc8c94( "prison_door", "closing" );
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "prison_door", "closed" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 1
// Checksum 0x7cf513e7, Offset: 0x31b2
// Size: 0x7e
function cell_door_lock( b_freeze = 1 )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !utility::function_9f2c41c1dcc8c94( "prison_door", "closed" ) )
    {
        cell_door_close();
        waitframe();
        
        while ( !utility::function_9f2c41c1dcc8c94( "prison_door", "closed" ) )
        {
            waitframe();
        }
    }
    
    utility::function_7c10ea82c1e305b8( "prison_door", "locked" );
    
    if ( b_freeze )
    {
        waitframe();
        utility::function_7c10ea82c1e305b8( "prison_door", "frozen" );
    }
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0xe4370881, Offset: 0x3238
// Size: 0x20
function cell_door_unlock()
{
    level utility::flag_wait( "scriptables_ready" );
    utility::function_7c10ea82c1e305b8( "prison_door", "unlocked" );
}

// Namespace namespace_5c78ef15c79ef44d
// Params 0
// Checksum 0x12c9fa7b, Offset: 0x3260
// Size: 0x20
function function_24eab5a6e061f8e0()
{
    level utility::flag_wait( "scriptables_ready" );
    utility::function_7c10ea82c1e305b8( "prison_door", "ajar" );
}

