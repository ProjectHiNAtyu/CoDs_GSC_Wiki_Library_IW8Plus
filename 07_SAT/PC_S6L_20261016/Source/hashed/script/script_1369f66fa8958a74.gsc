// script_1369f66fa8958a74  (hash_1369f66fa8958a74.gscc) (size: 19893 Bytes / 0x4db5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43ba1821 (1136269345)
// size ...... 19893 (0x4db5)
// includes .. 21  (offset: 0x46d9)
// strings ... 108 (offset: 0x4781)
// dev strs .. 0   (offset: 0x4db5)
// exports ... 45  (offset: 0x2e75)
// cseg ...... 0xb19 + 0x235c (0x2e75)
// imports ... 138 (offset: 0x357d)
// animtree1 . 0   (offset: 0x4db5)
// animtree2 . 0   (offset: 0x4db5)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\hints;
#using scripts\common\progress_tracker;
#using scripts\common\puzzles\connection_puzzle;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\objidpoolmanager;

#namespace namespace_fc92da645acfbbdc;

/#

    // Namespace namespace_fc92da645acfbbdc
    // Params 0
    // Checksum 0x9ef6b482, Offset: 0xb37
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_fc92da645acfbbdc
// Params 0, eflags: 0x5
// Checksum 0xc5c09b69, Offset: 0xb44
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_378abc1c151be4cb", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0, eflags: 0x4
// Checksum 0x4da2a390, Offset: 0xb6d
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_FACILITY_PRESENTATION";
    activity_common::registeractivitytype( "OB_LEO_FACILITY_PRESENTATION", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_PRESENTATION", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_PRESENTATION", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_PRESENTATION", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_FACILITY_PRESENTATION" );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0xc02ecfc8, Offset: 0xbe4
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance facility_presentation_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x2ffc6e9d, Offset: 0xc49
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance thread facility_presentation_main();
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x3c12f7d, Offset: 0xc8e
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_fc92da645acfbbdc
// Params 1
// Checksum 0x34f25764, Offset: 0xcb2
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_fc92da645acfbbdc
    // Params 0
    // Checksum 0xd94c1092, Offset: 0xd6e
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_fc92da645acfbbdc
// Params 1
// Checksum 0xba83ed54, Offset: 0xd7b
// Size: 0x19
function player_setup( player )
{
    activity_instance = self;
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0xebb6823c, Offset: 0xd9c
// Size: 0x67
function facility_presentation_start()
{
    thread mp_sat_ob_leo_util::function_96b32ff9e4b0fc4c();
    thread mp_sat_ob_leo_util::function_d2eaefb295692571();
    thread ob_story_mission_utils::item_spawn_weapon( "s_facility_intro_weapon", "facility_to_jungle_complete", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_facility_intro_equipment", "facility_to_jungle_complete", 1 );
    level thread presentation_puzzle();
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "presentation_puzzle_interact", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0xbe0efaeb, Offset: 0xe0b
// Size: 0x96
function facility_presentation_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_facility_presentation_weapon", "facility_to_jungle_complete", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_facility_presentation_equipment", "facility_to_jungle_complete", 1 );
    level thread mp_sat_ob_leo_util::function_cfe31985b0b4a074();
    level thread mp_sat_ob_leo_vo::facility_presentation_vo();
    thread facility_presentation_objectives();
    thread facility_presentation_encounters();
    thread function_b001694e68ab1ade();
    level utility::flag_wait( "flag_central_guild_bots_dead" );
    level utility::flag_wait( "flag_presentation_ff_destroyed" );
    level utility::flag_set( "facility_presentation_complete" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0, eflags: 0x4
// Checksum 0x71acf2, Offset: 0xea9
// Size: 0x190
function private facility_presentation_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( %"hash_45d1aab33743f656" );
    level utility::flag_wait( "flag_presentation_puzzle_solved" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( "presentation_puzzle_interact" );
    ob_story_mission_utils::objective_marker_hide( self.var_8029d4363972e15 );
    level utility::flag_wait( "flag_central_guild_bots_spawn" );
    wait 2;
    ob_story_mission_utils::objective_text_show( %"hash_60a27c7d47197c69" );
    level utility::flag_wait( "flag_central_guild_bots_dead" );
    ob_story_mission_utils::objective_text_show( %"hash_45d1aab33743f656" );
    struct = utility::getstruct( "facility_intro_obj_marker_mid_2", "targetname" );
    profilestart();
    self.var_8029d4363972e15 = ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin, undefined, undefined, "sat_ob_objectivemarker_storymissionmain" );
    profilestop();
    ob_story_mission_utils::objective_marker_show( self.var_8029d4363972e15 );
    level utility::flag_wait( "flag_presentation_ff_nag_said" );
    
    foreach ( player in level.players )
    {
        player thread function_2281ce2df15f6c68();
    }
    
    struct = utility::getstruct( "ff_obj_marker", "targetname" );
    objidpoolmanager::update_objective_position( self.var_8029d4363972e15, struct.origin );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x7f3e4f19, Offset: 0x1041
// Size: 0x25
function function_2281ce2df15f6c68()
{
    self endon( #"death_or_disconnect" );
    hints::hint_add_simple( "leo_forcefield_hint", &"sat_ob_story_missions/leo_forcefield_hint", 10 );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x14d47788, Offset: 0x106e
// Size: 0x50
function function_3cc1e6f1b42a5b01()
{
    level endon( #"flag_central_nodes_destroyed" );
    
    while ( true )
    {
        level waittill( #"hash_942b8b2b6072ff9d" );
        ob_story_mission_utils::objective_marker_show( self.var_8029d4363972e15 );
        level waittill( #"hash_3a2008ab06cab956" );
        ob_story_mission_utils::objective_marker_hide( self.var_8029d4363972e15 );
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0xe7cf02ff, Offset: 0x10c6
// Size: 0x10f
function facility_presentation_encounters()
{
    level.var_fb351999dc1811f6 = [];
    level.var_547b7dd56facf5dd = [];
    facility_central_encounter_start_trig = getent( "facility_central_encounter_start_trig", #targetname );
    facility_central_encounter_start_trig waittill( #"trigger" );
    level utility::flag_set( "flag_central_encounter_start" );
    level thread function_ced975519d352b9e();
    var_22903d1955588fd2 = getent( "facility_intro_obj_marker_mid_trig", #targetname );
    var_22903d1955588fd2 waittill( #"trigger" );
    level utility::flag_set( "flag_central_player_entered_space" );
    level utility::flag_wait( "flag_central_guild_bots_dead" );
    trig_presentation_security_bot_spawns = getnoentvolumearray( "trig_presentation_security_bot_spawns", "targetname" );
    trig_presentation_security_bot_spawns[ 0 ] waittill( #"trigger" );
    level utility::flag_set( "flag_central_player_exiting" );
    mp_sat_ob_leo_util::function_69a8cda9aa00992e( "central_to_junction_door" );
    mp_sat_ob_leo_util::unlock_door( "junction_to_central_door" );
    playsoundatpos( ( 15924, -328, -4715 ), #"evt_leo_security_nodes_door_open" );
    level utility::flag_wait( "flag_presentation_ff_destroyed" );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0xb482e65e, Offset: 0x11dd
// Size: 0x1c5
function presentation_puzzle()
{
    consoles = getscriptablearray( "atrium_console", "targetname" );
    
    foreach ( var_190f59357d8260f7 in consoles )
    {
        var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
    }
    
    var_490060d47d9e122a = "leo_atrium_1";
    mp_sat_ob_leo_util::connection_puzzle_init( var_490060d47d9e122a, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    struct = utility::getstruct( "presentation_puzzle_interact" );
    
    if ( isdefined( struct ) )
    {
        struct.interact = interaction::register_interact( struct.origin, 64, &on_presentation_puzzle_interact, &"mp_dmz_locks/unlock_door", undefined, undefined, undefined, "HINT_BUTTON" );
        struct.interact.var_490060d47d9e122a = var_490060d47d9e122a;
        struct.interact thread ob_story_mission_utils::function_e89ed2a08ce38bbf( "atrium_console", level.connection_puzzle_asset );
    }
    
    level utility::flag_wait( "flag_connection_puzzle_vo_said" );
    
    foreach ( player in level.players )
    {
        player thread function_85b5fdec18c182c2();
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 1
// Checksum 0xa8ae1e45, Offset: 0x13aa
// Size: 0x3fc
function on_presentation_puzzle_interact( player )
{
    if ( !val::get( "allow_connection_puzzle" ) )
    {
        return;
    }
    
    self makeunusable();
    player thread mp_sat_ob_libra_util::start_interact_scene( "presentation_puzzle_scene" );
    
    if ( player connection_puzzle::open( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
    {
        level utility::flag_set( "flag_presentation_puzzle_opened" );
        consoles = getscriptablearray( "atrium_console", "targetname" );
        
        foreach ( var_190f59357d8260f7 in consoles )
        {
            var_190f59357d8260f7 setscriptablepartstate( #"base", #"hash_cacbbd1f76200a42" );
        }
        
        foreach ( spectator in level.players )
        {
            if ( spectator != player )
            {
                spectator thread connection_puzzle::open( level.connection_puzzle_asset, self.var_490060d47d9e122a, 1 );
            }
        }
        
        finished = player utility::waittill_any_return( "ConnectionPuzzleClosed", "ConnectionPuzzleCompleted", "death_or_disconnect" );
        
        if ( isplayer( player ) )
        {
            player mp_sat_ob_libra_util::function_d68eec31414afe2e( "presentation_puzzle_scene" );
            player connection_puzzle::close();
        }
        
        foreach ( p in level.players )
        {
            if ( p != player )
            {
                p connection_puzzle::close_spectator( level.connection_puzzle_asset, self.var_490060d47d9e122a );
            }
        }
        
        if ( finished == "ConnectionPuzzleCompleted" || connection_puzzle::is_instance_complete( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
        {
            mp_sat_ob_leo_util::function_69a8cda9aa00992e( "central_to_lower_atrium_door" );
            level utility::flag_set( "flag_presentation_puzzle_solved" );
            consoles = getscriptablearray( "atrium_console", "targetname" );
            
            foreach ( var_190f59357d8260f7 in consoles )
            {
                var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_operational" );
            }
            
            if ( isdefined( self ) )
            {
                self delete();
            }
        }
        else
        {
            waitframe();
            self makeusable();
            interaction::set_interact_hint_string( &"mp_dmz_locks/unlock_door" );
            consoles = getscriptablearray( "atrium_console", "targetname" );
            
            foreach ( var_190f59357d8260f7 in consoles )
            {
                var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
            }
        }
        
        return;
    }
    
    if ( isplayer( player ) )
    {
        player mp_sat_ob_libra_util::function_d68eec31414afe2e( "presentation_puzzle_scene" );
    }
    
    self makeusable();
    interaction::set_interact_hint_string( &"mp_dmz_locks/unlock_door" );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x8143bbb7, Offset: 0x17ae
// Size: 0x25
function function_85b5fdec18c182c2()
{
    self endon( #"death_or_disconnect" );
    hints::hint_add_simple( "leo_connection_puzzle_hint", &"sat_ob_story_missions/leo_connection_puzzle_hint", 10 );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x3dd8f720, Offset: 0x17db
// Size: 0x174
function function_ced975519d352b9e()
{
    thread function_8bbc4031de1577e7();
    scene_struct = utility::getstruct( "sat_ai_leo_stage_elevator", "targetname" );
    scene_struct scene::add_spawn_function( &function_c3a293e9b9f5b0c8, "Types_Actor" );
    scene_struct thread scene::play( undefined, "lowered_idle" );
    level utility::flag_wait( "flag_central_player_entered_space" );
    level utility::flag_wait( "flag_central_initial_vo_done" );
    wait 1;
    thread leo_audio::function_cb1bfffef55c52be();
    panel = getent( "presentation_stage_panel", "targetname" );
    panel moveto( panel.origin + ( 0, 0, -4 ), 1, 0.5, 0.5 );
    wait 1;
    panel moveto( panel.origin + ( 48, 48, 0 ), 2, 1, 1 );
    wait 2;
    scene_struct scene::play( undefined, "stage_raise" );
    scene_struct thread scene::play( undefined, "raised_idle" );
    level utility::flag_wait( "flag_stage_bots_vo_done" );
    wait 1;
    scene_struct thread scene::play( undefined, "activate" );
    level utility::flag_set( "flag_stage_bots_activated" );
    thread leo_audio::function_8bba7d7d4edfd9f1();
    level thread mp_sat_ob_leo_util::function_df0396a50445e0c4( "central_fire_alarms", "flag_central_guild_bots_dead" );
    level thread function_649cba10e20f8a33();
    level utility::flag_set( "flag_central_guild_bots_spawn" );
    level utility::flag_wait( "flag_central_guild_bots_dead" );
    level utility::flag_clear( "flag_central_guild_bots_spawn" );
    thread function_244023980429f132();
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x3c23dde1, Offset: 0x1957
// Size: 0x77
function function_649cba10e20f8a33()
{
    var_68b32a8bafee7061 = "flag_central_guild_bots_dead";
    tick_name = "central_alarm_tick";
    period = 1.5;
    level thread mp_sat_ob_leo_util::alarm_listener( "amb_emt_security_alarm_1", ( 15416, 385, -4852 ), tick_name, var_68b32a8bafee7061 );
    level thread mp_sat_ob_leo_util::alarm_listener( "amb_emt_security_alarm_2", ( 14876, 841, -4852 ), tick_name, var_68b32a8bafee7061 );
    level thread mp_sat_ob_leo_util::function_eae6f210af41e04f( tick_name, period, var_68b32a8bafee7061 );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x6f0ed0ae, Offset: 0x19d6
// Size: 0x1be
function function_8bbc4031de1577e7()
{
    var_bf05c3168959c2db = utility::getstructarray( "diorama_bots" );
    
    if ( level.players.size > 2 )
    {
        scene_structs_extra = utility::getstructarray( "diorama_bots_extra" );
        var_bf05c3168959c2db = arraycombine( var_bf05c3168959c2db, scene_structs_extra );
    }
    
    foreach ( scene_struct in var_bf05c3168959c2db )
    {
        scene_struct scene::add_spawn_function( &function_c3a293e9b9f5b0c8, "Types_Actor" );
        
        if ( scene_struct.script_noteworthy == "patrol" )
        {
            scene_struct thread scene::play( undefined, "patrol_idle" );
            continue;
        }
        
        scene_struct thread scene::play( undefined, "idle_0" + scene_struct.script_noteworthy );
    }
    
    level utility::flag_wait( "flag_central_guild_bots_spawn" );
    wait 5;
    
    foreach ( scene_struct in var_bf05c3168959c2db )
    {
        wait randomfloatrange( 0.5, 1 );
        
        if ( scene_struct.script_noteworthy == "patrol" )
        {
            scene_struct thread scene::play( undefined, "patrol_to_combat" );
            continue;
        }
        
        scene_struct thread scene::play( undefined, "exit_0" + scene_struct.script_noteworthy );
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x960d9ab, Offset: 0x1b9c
// Size: 0x1a2
function function_244023980429f132()
{
    var_bf05c3168959c2db = utility::getstructarray( "security_bots" );
    
    foreach ( scene_struct in var_bf05c3168959c2db )
    {
        scene_struct scene::add_spawn_function( &function_c3a293e9b9f5b0c8, "Types_Actor" );
        scene_struct thread scene::play( undefined, "idle" );
    }
    
    level utility::flag_wait( "flag_central_player_exiting" );
    level utility::flag_set( "flag_central_guild_bots_spawn" );
    
    foreach ( scene_struct in var_bf05c3168959c2db )
    {
        if ( scene_struct.script_noteworthy == "1" )
        {
            delay_time = 0;
        }
        
        if ( scene_struct.script_noteworthy == "2" )
        {
            delay_time = 0.5;
        }
        
        if ( scene_struct.script_noteworthy == "3" )
        {
            delay_time = 1;
        }
        
        if ( scene_struct.script_noteworthy == "4" )
        {
            delay_time = 1.5;
        }
        
        scene_struct utility::delaythread( delay_time, &function_1c32f32cc988634a, scene_struct.script_noteworthy );
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 1
// Checksum 0xeb9dda62, Offset: 0x1d46
// Size: 0x1c
function function_1c32f32cc988634a( exit_num )
{
    thread scene::play( undefined, "exit_0" + exit_num );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x529bac03, Offset: 0x1d6a
// Size: 0x10c
function function_c3a293e9b9f5b0c8()
{
    level.var_547b7dd56facf5dd[ level.var_547b7dd56facf5dd.size ] = self;
    self.team = "team_hundred_ninety";
    self.ignoreall = 1;
    mp_sat_ob_libra_util::function_90c440460dba0ba2( 0 );
    self.var_24954f14e27b448d = 0;
    val::set( "presentation_guild_bot_spawn", "ignoreme", 1 );
    self.var_2fc3a5fb762afb6e = 1;
    level notify( #"highvis_reload_outline", undefined, [ self ] );
    level utility::flag_wait( "flag_central_guild_bots_spawn" );
    utility::ent_flag_waitopen_any( "scene_active" );
    self.var_2fc3a5fb762afb6e = 0;
    level notify( #"highvis_reload_outline", undefined, [ self ] );
    self.var_24954f14e27b448d = 1;
    self.ignoreall = 0;
    val::reset( "presentation_guild_bot_spawn", "ignoreme" );
    waitframe();
    nearesttacpoint = self getnearesttacpoint();
    
    if ( nearesttacpoint )
    {
        self setgoalpos( nearesttacpoint.origin );
    }
    
    self waittill( #"death" );
    function_87c9dc12f3244d2d();
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x25a08b47, Offset: 0x1e7e
// Size: 0x37
function function_87c9dc12f3244d2d()
{
    level.var_547b7dd56facf5dd = utility::array_removedead_or_dying( level.var_547b7dd56facf5dd );
    
    if ( level.var_547b7dd56facf5dd.size < 1 )
    {
        level utility::flag_set( "flag_central_guild_bots_dead" );
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 3
// Checksum 0xab297db8, Offset: 0x1ebd
// Size: 0x2b
function function_eb0c548850e91bb7( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_central_enemies_spawned" );
}

// Namespace namespace_fc92da645acfbbdc
// Params 4
// Checksum 0x89fab32f, Offset: 0x1ef0
// Size: 0x5e
function central_spawn_func( requestid, instance, agent, ai_data )
{
    level.var_fb351999dc1811f6[ level.var_fb351999dc1811f6.size ] = agent;
    var_95b86e61b2c6a7 = utility::array_random( ob_story_mission_utils::get_playing_players() );
    agent setgoalentity( var_95b86e61b2c6a7 );
}

// Namespace namespace_fc92da645acfbbdc
// Params 3
// Checksum 0x521fe67e, Offset: 0x1f56
// Size: 0x45
function function_6b0e569e41d294e0( requestid, userdata, shutdowndata )
{
    level utility::flag_set( "flag_central_encounter_done" );
    iprintln( "central encounter complete!" );
    ai_spawn_director::cancel_spawn_request( level.var_f768d95f7c3bd2a8 );
}

// Namespace namespace_fc92da645acfbbdc
// Params 3
// Checksum 0x75491f26, Offset: 0x1fa3
// Size: 0x1b0
function function_c4b6c70081ab04c5( requestid, activity_instance, agent )
{
    level.var_fb351999dc1811f6 = utility::array_removedead_or_dying( level.var_fb351999dc1811f6 );
    
    if ( level.var_fb351999dc1811f6.size < 3 )
    {
        iprintln( "enemies rush nearest player" );
        
        foreach ( agent in level.var_fb351999dc1811f6 )
        {
            players = ob_story_mission_utils::get_playing_players();
            closest_player = function_47c86977a18df38b( players, agent.origin );
            agent setgoalentity( closest_player );
            agent.goalradius = 32;
        }
        
        return;
    }
    
    if ( level.var_fb351999dc1811f6.size < 11 )
    {
        level utility::flag_set( "flag_central_encounter_retreating" );
        iprintln( "enemies retreat" );
        exit_struct = utility::getstruct( "central_exit" );
        
        foreach ( agent in level.var_fb351999dc1811f6 )
        {
            agent setgoalpos( exit_struct.origin );
        }
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x8b2ebf27, Offset: 0x215b
// Size: 0x4d
function function_2d79e369625d0455()
{
    struct = utility::getstruct( "facility_central_exit_door_interact" );
    struct.interact = interaction::register_interact( struct.origin, 64, &function_93f2dff4d2dd1591, &"mp_dmz_locks/unlock_door" );
    thread function_ed6e5d86a9bb0144();
}

// Namespace namespace_fc92da645acfbbdc
// Params 1
// Checksum 0xdc13cea9, Offset: 0x21b0
// Size: 0x88
function function_93f2dff4d2dd1591( player )
{
    self makeunusable();
    level utility::flag_set( "flag_central_destroy_nodes_start" );
    playsoundatpos( self.origin + ( 65, 0, 20 ), #"evt_leo_security_nodes_door_lock" );
    struct = utility::getstruct( "facility_central_nodes_interact" );
    struct.interact = interaction::register_interact( struct.origin, 64, &function_f64c6cfe6ce075a3, &"mp_sat_ob_core_features/activity_button_use" );
}

// Namespace namespace_fc92da645acfbbdc
// Params 1
// Checksum 0xb609e925, Offset: 0x2240
// Size: 0x37
function function_f64c6cfe6ce075a3( player )
{
    self makeunusable();
    level utility::flag_set( "flag_central_nodes_interact_used" );
    self playsoundtoplayer( #"hash_5e0daf648b3bcf13", player );
    thread function_49d69de5ddc4d7f1();
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x418c5dd6, Offset: 0x227f
// Size: 0x375
function function_49d69de5ddc4d7f1()
{
    level notify( #"start_escape_timer" );
    level notify( #"hash_3a2008ab06cab956" );
    
    foreach ( node in level.central_nodes )
    {
        playfxontag( level._effect[ "blinking_red_light" ], node, "tag_origin" );
        node thread leo_audio::function_78bb15b768618217();
        node thread node_beep();
    }
    
    nodes_glass = getentarray( "facility_central_nodes_glass", "targetname" );
    
    foreach ( glass in nodes_glass )
    {
        glass moveto( glass.origin + ( 0, 0, 32 ), 2, 1, 1 );
        sound_org = leo_audio::get_offset_origin( glass.origin, glass.angles, 10, "right" );
        playsoundatpos( sound_org, #"hash_97bd15dfc60b3e42" );
    }
    
    iprintlnbold( "TEMPORARY SECURITY NODE OVERRIDE INITIATED" );
    level waittill( #"countdown_end" );
    
    foreach ( node in level.central_nodes )
    {
        killfxontag( level._effect[ "blinking_red_light" ], node, "tag_origin" );
    }
    
    nodes_glass = getentarray( "facility_central_nodes_glass", "targetname" );
    
    foreach ( glass in nodes_glass )
    {
        glass moveto( glass.origin + ( 0, 0, -32 ), 2, 1, 1 );
        sound_org = leo_audio::get_offset_origin( glass.origin, glass.angles, 10, "right" );
        playsoundatpos( sound_org + ( 0, 0, -32 ), #"hash_c032fc6ad1b64766" );
    }
    
    wait 2;
    
    if ( !utility::flag( "flag_central_nodes_destroyed" ) )
    {
        struct = utility::getstruct( "facility_central_nodes_interact" );
        struct.interact = interaction::register_interact( struct.origin, 64, &function_f64c6cfe6ce075a3, &"mp_sat_ob_core_features/activity_button_use" );
        level notify( #"hash_942b8b2b6072ff9d" );
        level notify( #"hash_446bd2704ac8667d" );
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x3cc25721, Offset: 0x25fc
// Size: 0xc3
function function_ed6e5d86a9bb0144()
{
    level.central_nodes = getentarray( "facility_central_nodes", "targetname" );
    level utility::flag_wait( "flag_central_nodes_interact_used" );
    
    foreach ( node in level.central_nodes )
    {
        node thread function_2aeebfdf21baeefb();
        node.interact = interaction::register_interact( node, 64, &function_3651b12131b1f52b, &"mp_sat_ob_core_features/activity_button_use" );
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0xc2a2ffb6, Offset: 0x26c7
// Size: 0x7e
function function_61c437136da6a003()
{
    thread function_5ee3b2ddc4512c5( "central_node_1_bots", "facility_central_node_1", "central_node_1_grate", ( 0, 66, 0 ) );
    thread function_5ee3b2ddc4512c5( "central_node_2_bots", "facility_central_node_2", "central_node_2_grate", ( -66, 0, 0 ) );
    thread function_5ee3b2ddc4512c5( "central_node_3_bots", "facility_central_node_3", "central_node_3_grate", ( 66, 0, 0 ) );
    utility::flag_wait( "flag_central_nodes_destroyed" );
    function_1b86168fadcfb49d();
}

// Namespace namespace_fc92da645acfbbdc
// Params 4
// Checksum 0xa47d3e35, Offset: 0x274d
// Size: 0x265
function function_5ee3b2ddc4512c5( scene_targetname, notification, grate_targetname, offset )
{
    var_bf05c3168959c2db = utility::getstructarray( scene_targetname );
    
    foreach ( scene_struct in var_bf05c3168959c2db )
    {
        scene_struct scene::add_spawn_function( &function_a4f442f2830e9d61, "Types_Actor" );
        scene_struct thread scene::play( undefined, "idle" );
    }
    
    level waittill( notification );
    var_bc75e58ce6441121 = getent( grate_targetname, "targetname" );
    var_bc75e58ce6441121 moveto( var_bc75e58ce6441121.origin + offset, 0.5, 0.25, 0.25 );
    wait 0.5;
    
    foreach ( scene_struct in var_bf05c3168959c2db )
    {
        bots = scene_struct scene::get_entities();
        
        foreach ( bot in bots )
        {
            bot notify( #"hash_992479d4601226ab" );
        }
    }
    
    foreach ( scene_struct in var_bf05c3168959c2db )
    {
        scene_struct thread scene::play( undefined, "exit_0" + randomintrange( 1, 5 ) );
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0xa34102bb, Offset: 0x29ba
// Size: 0x63
function function_1b86168fadcfb49d()
{
    var_bc75e58ce6441121 = getent( "central_node_1_grate", "targetname" );
    
    if ( isdefined( var_bc75e58ce6441121 ) )
    {
        var_bc75e58ce6441121 delete();
    }
    
    var_bc75e58ce6441121 = getent( "central_node_2_grate", "targetname" );
    
    if ( isdefined( var_bc75e58ce6441121 ) )
    {
        var_bc75e58ce6441121 delete();
    }
    
    var_bc75e58ce6441121 = getent( "central_node_3_grate", "targetname" );
    
    if ( isdefined( var_bc75e58ce6441121 ) )
    {
        var_bc75e58ce6441121 delete();
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x2de733fa, Offset: 0x2a25
// Size: 0x87
function function_a4f442f2830e9d61()
{
    self.team = "team_hundred_ninety";
    self function_e8726d980fa12944();
    mp_sat_ob_libra_util::function_90c440460dba0ba2( 0 );
    self.var_24954f14e27b448d = 0;
    self.var_2fc3a5fb762afb6e = 1;
    level notify( #"highvis_reload_outline", undefined, [ self ] );
    self waittill( #"hash_992479d4601226ab" );
    self visiblesolid();
    wait 0.5;
    self.var_24954f14e27b448d = 1;
    self.var_2fc3a5fb762afb6e = 0;
    level notify( #"highvis_reload_outline", undefined, [ self ] );
}

// Namespace namespace_fc92da645acfbbdc
// Params 1
// Checksum 0xd47eeb3f, Offset: 0x2ab4
// Size: 0x1e
function function_3651b12131b1f52b( player )
{
    self makeunusable();
    self notify( #"turned_off" );
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x9e453d43, Offset: 0x2ada
// Size: 0x163
function function_2aeebfdf21baeefb()
{
    self setcandamage( 1 );
    utility::waittill_any( "damage", "turned_off" );
    self notify( #"node_damaged" );
    sound_org = leo_audio::get_offset_origin( self.origin, self.angles, 10, "right" );
    playsoundatpos( sound_org, #"hash_9b51f6effeee42d0" );
    
    if ( self.script_noteworthy == "facility_central_node_3" )
    {
        level utility::flag_set( "flag_guild_presentation_player_near_stage" );
    }
    
    level notify( self.script_noteworthy );
    level.central_nodes = arrayremove( level.central_nodes, self );
    iprintln( "node damaged!" );
    self setmodel( "equipment_router_side_off" );
    killfxontag( level._effect[ "blinking_red_light" ], self, "tag_origin" );
    
    if ( !isdefined( level.var_e036dbcb93387076 ) )
    {
        level.var_e036dbcb93387076 = 1;
    }
    else
    {
        level.var_e036dbcb93387076++;
    }
    
    if ( level.var_e036dbcb93387076 == 1 )
    {
        level utility::flag_set( "flag_central_node_damaged" );
    }
    
    if ( level.var_e036dbcb93387076 == 2 )
    {
        level utility::flag_set( "flag_central_spawn_reinforcements" );
    }
    
    level notify( #"hash_776055e089a464e7" );
    
    if ( level.var_e036dbcb93387076 > 2 )
    {
        iprintlnbold( "THAT'S ALL OF THEM!" );
        level utility::flag_set( "flag_central_nodes_destroyed" );
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x70bb8580, Offset: 0x2c45
// Size: 0xee
function node_beep()
{
    self endon( #"node_damaged" );
    level endon( #"countdown_end" );
    sound_org = leo_audio::get_offset_origin( self.origin, self.angles, 10, "right" );
    
    while ( true )
    {
        wait_time = 1;
        players = ob_story_mission_utils::get_playing_players();
        closest_player = function_47c86977a18df38b( players, self.origin );
        dist_squared = distancesquared( closest_player.origin, self.origin );
        
        if ( dist_squared < 1000000 )
        {
            dist = sqrt( dist_squared );
            wait_time = dist * 0.005;
            
            if ( wait_time < 0.8 )
            {
                wait_time = 0.8;
            }
        }
        
        wait wait_time;
        playsoundatpos( sound_org, #"hash_283c74a755bcbdd8" );
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 0
// Checksum 0x1441c699, Offset: 0x2d3b
// Size: 0xe6
function function_b001694e68ab1ade()
{
    level endon( #"flag_central_nodes_destroyed" );
    player_count = level.players.size;
    
    switch ( player_count )
    {
        case 1:
            time = 30;
            break;
        case 2:
            time = 25;
            break;
        case 3:
            time = 20;
            break;
        case 4:
            time = 15;
            break;
    }
    
    while ( true )
    {
        level waittill( #"start_escape_timer" );
        wait 2;
        thread activity_progress_tracking::function_61568a80767f1652( "escape_timer", time, &timer_elapsed );
        thread function_c68934b2c39b0be( time );
        thread leo_audio::function_bb9eac8dbe531558();
        self waittill( #"countdown_finished" );
        level notify( #"countdown_end" );
        thread function_c68934b2c39b0be( 0 );
        activity_progress_tracking::function_a349dbc284b26b2f();
        waitframe();
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 1
// Checksum 0x288f14e, Offset: 0x2e29
// Size: 0x2f
function timer_elapsed( progress_tracker )
{
    level endon( #"flag_central_nodes_destroyed" );
    
    if ( progress_tracker progress_tracker::iscomplete() )
    {
        self notify( #"countdown_finished" );
    }
}

// Namespace namespace_fc92da645acfbbdc
// Params 1, eflags: 0x4
// Checksum 0xba0b119f, Offset: 0x2e60
// Size: 0x15
function private function_c68934b2c39b0be( var_77be3669189a4fe3 )
{
    namespace_b451b5202140ccde::function_2ee97780d0898a9b( var_77be3669189a4fe3 );
}

