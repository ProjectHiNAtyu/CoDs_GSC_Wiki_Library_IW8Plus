// script_15a3dbf9669de0c3  (hash_15a3dbf9669de0c3.gscc) (size: 8344 Bytes / 0x2098 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9fc23243 (2680304195)
// size ...... 8344 (0x2098)
// includes .. 14  (offset: 0x1d40)
// strings ... 51  (offset: 0x1db0)
// dev strs .. 0   (offset: 0x2098)
// exports ... 22  (offset: 0x1244)
// cseg ...... 0x561 + 0xce3 (0x1244)
// imports ... 62  (offset: 0x15b4)
// animtree1 . 0   (offset: 0x2098)
// animtree2 . 0   (offset: 0x2098)
#using script_1369f66fa8958a74;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;

#namespace namespace_1d74217ab4ba1bbb;

/#

    // Namespace namespace_1d74217ab4ba1bbb
    // Params 0
    // Checksum 0x708314e5, Offset: 0x57f
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_1d74217ab4ba1bbb
// Params 0, eflags: 0x5
// Checksum 0x62be946b, Offset: 0x58c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_227b1867e1d08d78", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 0, eflags: 0x4
// Checksum 0xa3d703f7, Offset: 0x5b5
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_FACILITY_ESCAPE_1";
    activity_common::registeractivitytype( "OB_LEO_FACILITY_ESCAPE_1", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_ESCAPE_1", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_ESCAPE_1", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_ESCAPE_1", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_FACILITY_ESCAPE_1" );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 0
// Checksum 0x8930a071, Offset: 0x62c
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_a86e1c32c2e9a2cc();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 0
// Checksum 0xd947d38, Offset: 0x691
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance thread function_298be00667b2161d();
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 0
// Checksum 0xedb48f1a, Offset: 0x6d6
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 1
// Checksum 0x674731d5, Offset: 0x6fa
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

    // Namespace namespace_1d74217ab4ba1bbb
    // Params 0
    // Checksum 0x3739b0f5, Offset: 0x7b6
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_1d74217ab4ba1bbb
// Params 1
// Checksum 0x54f64d33, Offset: 0x7c3
// Size: 0x19
function player_setup( player )
{
    activity_instance = self;
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 0
// Checksum 0x80044df2, Offset: 0x7e4
// Size: 0x79
function function_a86e1c32c2e9a2cc()
{
    thread mp_sat_ob_leo_util::function_96b32ff9e4b0fc4c();
    thread mp_sat_ob_leo_util::function_d2eaefb295692571();
    thread namespace_fc92da645acfbbdc::function_1b86168fadcfb49d();
    mp_sat_ob_leo_util::unlock_door( "central_to_lower_atrium_door" );
    mp_sat_ob_leo_util::unlock_door( "central_to_junction_door" );
    mp_sat_ob_leo_util::function_69a8cda9aa00992e( "junction_to_central_door" );
    mp_sat_ob_leo_util::unlock_door( "junction_to_macguffin_door" );
    mp_sat_ob_leo_util::unlock_door( "macguffin_to_junction_door" );
    mp_sat_ob_leo_util::turn_off_force_field( "presentation_ff", "targetname", 1 );
    mp_sat_ob_leo_util::turn_off_force_field( "quantum_computer_ff", "targetname", 1 );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 0
// Checksum 0x6498c131, Offset: 0x865
// Size: 0xad
function function_298be00667b2161d()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread function_fb56477afb1c3089();
    thread mp_sat_ob_leo_vo::function_94fcafe7f38c8407();
    thread function_5337ed88dfc77e90();
    thread facility_escape_encounters();
    struct = utility::getstruct( "facility_cradle_interact" );
    prompt = gameobjects::createhintobject( struct.origin, "HINT_BUTTON", undefined, &"mp_dmz_locks/unlock_door" );
    prompt waittill( #"trigger", var_9d64a5e2cee72c8f );
    prompt delete();
    level utility::flag_set( "facility_escape_1_complete" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 0
// Checksum 0xc13036fe, Offset: 0x91a
// Size: 0x110
function function_fb56477afb1c3089()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level utility::flag_wait( "scriptables_ready" );
    mp_sat_ob_leo_util::function_69a8cda9aa00992e( "labs_hall_side_door_1" );
    mp_sat_ob_leo_util::function_69a8cda9aa00992e( "labs_hall_side_door_2" );
    escape_1_door_1_trig = getent( "facilty_escape_1_door_1_trig", #targetname );
    escape_1_door_1_trig waittill( #"trigger" );
    mp_sat_ob_leo_util::lock_door( "junction_to_central_door" );
    wait 1.2;
    mp_sat_ob_leo_util::function_69a8cda9aa00992e( "labs_to_dead_end_door" );
    level utility::flag_set( "flag_escape_1_door_1_closed" );
    escape_1_door_2_trig = getent( "facilty_escape_1_door_2_trig", #targetname );
    escape_1_door_2_trig waittill( #"trigger" );
    level utility::flag_set( "flag_escape_1_door_2_opened" );
    escape_1_door_3_trig = getent( "facilty_escape_1_door_3_trig", #targetname );
    escape_1_door_3_trig waittill( #"trigger" );
    mp_sat_ob_leo_util::lock_door( "labs_to_dead_end_door" );
    level utility::flag_set( "flag_escape_1_door_3_closed" );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 0, eflags: 0x4
// Checksum 0x8cdfeb11, Offset: 0xa32
// Size: 0x6c
function private function_5337ed88dfc77e90()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( %"hash_666155606a77390b" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "facility_cradle_interact", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level utility::flag_wait( "facility_escape_1_complete" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( "facility_cradle_interact" );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 0
// Checksum 0xf813c601, Offset: 0xaa6
// Size: 0x308
function facility_escape_encounters()
{
    facility_labs_escape_encounter_start_trig = getent( "facility_labs_escape_encounter_start_trig", #targetname );
    facility_labs_escape_encounter_start_trig waittill( #"trigger" );
    level utility::flag_set( "flag_labs_escape_encounter_start" );
    var_e3c6ac9cb551f846 = utility::getstructarray( "labs2_wave1", "targetname" );
    var_3fe5c3a2c344bdc5 = utility::getstructarray( "labs2_wave2", "targetname" );
    var_e3bdc09cb5480594 = utility::getstructarray( "labs2_wave1_3p", "targetname" );
    allspawners = arraycombine( var_e3c6ac9cb551f846, var_3fe5c3a2c344bdc5, var_e3bdc09cb5480594 );
    
    foreach ( spawner in allspawners )
    {
        if ( spawner.script_aitype == "sat_ob_enemy_hvt_heavytactician" )
        {
            spawner.script_aitype = "sat_ob_enemy_specialist_heavytactician";
        }
    }
    
    labs2_wave1 = ai_spawn_director::array_spawn_targetname( "labs2_wave1" );
    
    if ( level.players.size >= 3 )
    {
        labs2_wave1_3p = ai_spawn_director::array_spawn_targetname( "labs2_wave1_3p" );
        labs2_wave1 = arraycombine( labs2_wave1, labs2_wave1_3p );
    }
    
    level.audio.var_25e584ceb1945db6[ "labs2_wave1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "labs2_wave1" ] thread leo_audio::combat_walla_oneshot( labs2_wave1, "labs2_wave1", "dxx_leo_coordinated_int", 2, 7, 5, "labs2_wave_2_started" );
    level thread mp_sat_ob_leo_util::function_2463b23bc69b1a0a( labs2_wave1, labs2_wave1.size - 2, "flag_labs2_wave2" );
    utility::flag_wait( "flag_labs2_wave2" );
    level thread mp_sat_ob_leo_util::function_ac9de8895f3e4a23( labs2_wave1, "vol_labs2_ending" );
    labs2_wave2 = ai_spawn_director::array_spawn_targetname( "labs2_wave2" );
    level thread mp_sat_ob_leo_util::function_2463b23bc69b1a0a( labs2_wave2, labs2_wave2.size - 1, "flag_labs2_ending" );
    utility::flag_wait( "flag_labs2_ending" );
    allguys = ai_spawn_director::get_ai_group_ai( "ai_labs2" );
    level thread mp_sat_ob_leo_util::function_ac9de8895f3e4a23( allguys, "vol_labs2_ending" );
    level thread function_e199f9c82dd872e3( allguys );
    utility::flag_wait( "flag_labs2_bots" );
    labs2_wave3_bots = ai_spawn_director::array_spawn_targetname( "labs2_wave3_bots" );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "labs2_wave2" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "labs2_wave2" ] notify( #"hash_a5678ff036607053" );
    }
    
    level.audio.var_25e584ceb1945db6[ "labs2_wave3" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "labs2_wave3" ] thread leo_audio::combat_walla_oneshot( labs2_wave3_bots, "labs2_wave3", "dxx_leo_mech_bot_combat", 2, 7, 3 );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 1
// Checksum 0x183ed507, Offset: 0xdb6
// Size: 0xa7
function function_e199f9c82dd872e3( allguys )
{
    waypoint_objective_handler::waypoint_objective_handler_cancel( "facility_cradle_interact" );
    ob_story_mission_utils::objective_text_show( %"hash_60a27c7d47197c69" );
    level thread mp_sat_ob_leo_util::function_2463b23bc69b1a0a( allguys, allguys.size, "flag_labs2_cleared" );
    level thread function_611d572198c27e97( allguys );
    utility::flag_wait( "flag_labs2_cleared" );
    utility::flag_set( "flag_labs2_bots" );
    wait 1.3;
    mp_sat_ob_leo_util::function_69a8cda9aa00992e( "junction_to_labs_door" );
    ob_story_mission_utils::objective_text_show( %"hash_666155606a77390b" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "facility_cradle_interact", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 1
// Checksum 0x760f5749, Offset: 0xe65
// Size: 0x9b
function function_611d572198c27e97( guys )
{
    while ( guys.size > 2 )
    {
        waitframe();
        guys = utility::array_removedead_or_dying( guys );
    }
    
    foreach ( agent in guys )
    {
        if ( isdefined( agent ) )
        {
            agent thread function_391d0e46745dc968();
        }
    }
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 0
// Checksum 0x1be6ef32, Offset: 0xf08
// Size: 0x2b
function function_391d0e46745dc968()
{
    self endon( #"death" );
    self endon( #"damage" );
    wait 35;
    
    if ( isalive( self ) )
    {
        self kill();
    }
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 3
// Checksum 0x6cfd2b1c, Offset: 0xf3b
// Size: 0x2b
function function_8f45e9d511ae88e6( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_labs_escape_enemies_spawned" );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 4
// Checksum 0x8ba47dde, Offset: 0xf6e
// Size: 0x3e
function function_2e968b1908a3e987( requestid, instance, agent, ai_data )
{
    level.var_4e74d3ee2e0016d[ level.var_4e74d3ee2e0016d.size ] = agent;
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 3
// Checksum 0xb1934df5, Offset: 0xfb4
// Size: 0x51
function function_114e219c01849e05( requestid, userdata, shutdowndata )
{
    level utility::flag_set( "flag_labs_escape_encounter_done" );
    iprintln( "labs escape encounter complete!" );
    ai_spawn_director::cancel_spawn_request( level.var_63afe464f32bdecf );
    mp_sat_ob_leo_util::unlock_door( "junction_to_macguffin_door" );
}

// Namespace namespace_1d74217ab4ba1bbb
// Params 3
// Checksum 0xb5f89b85, Offset: 0x100d
// Size: 0x237
function function_eafbff3b17ef8a36( requestid, activity_instance, agent )
{
    level.var_4e74d3ee2e0016d = utility::array_removedead_or_dying( level.var_4e74d3ee2e0016d );
    
    if ( level.var_4e74d3ee2e0016d.size < 3 )
    {
        iprintln( "enemies rush nearest player" );
        
        foreach ( agent in level.var_4e74d3ee2e0016d )
        {
            players = ob_story_mission_utils::get_playing_players();
            closest_player = function_47c86977a18df38b( players, agent.origin );
            agent setgoalentity( closest_player );
        }
        
        return;
    }
    
    if ( level.var_4e74d3ee2e0016d.size < 6 )
    {
        iprintln( "enemies retreat to exit" );
        exit_struct = utility::getstruct( "labs_escape_exit" );
        
        foreach ( agent in level.var_4e74d3ee2e0016d )
        {
            agent setgoalpos( exit_struct.origin );
        }
        
        return;
    }
    
    if ( level.var_4e74d3ee2e0016d.size < 11 )
    {
        iprintln( "enemies retreat" );
        exit_struct = utility::getstruct( "labs_escape_back" );
        
        foreach ( agent in level.var_4e74d3ee2e0016d )
        {
            agent setgoalpos( exit_struct.origin );
        }
    }
}

