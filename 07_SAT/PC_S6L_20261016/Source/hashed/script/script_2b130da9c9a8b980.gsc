// script_2b130da9c9a8b980  (hash_2b130da9c9a8b980.gscc) (size: 12797 Bytes / 0x31fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd67d4327 (3598533415)
// size ...... 12797 (0x31fd)
// includes .. 24  (offset: 0x2cc9)
// strings ... 77  (offset: 0x2d89)
// dev strs .. 0   (offset: 0x31fd)
// exports ... 33  (offset: 0x1b79)
// cseg ...... 0x75a + 0x141f (0x1b79)
// imports ... 99  (offset: 0x20a1)
// animtree1 . 0   (offset: 0x31fd)
// animtree2 . 0   (offset: 0x31fd)
#using script_1369f66fa8958a74;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\hints;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\visibility_mode;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\coop;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\snd\snd_ob;

#namespace namespace_42f25eb087152c68;

/#

    // Namespace namespace_42f25eb087152c68
    // Params 0
    // Checksum 0x432c2336, Offset: 0x778
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_42f25eb087152c68
// Params 0, eflags: 0x5
// Checksum 0x2a7c42f3, Offset: 0x785
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_311ee3455186a70b", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_42f25eb087152c68
// Params 0, eflags: 0x4
// Checksum 0x90783424, Offset: 0x7ae
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_FACILITY_LABS";
    activity_common::registeractivitytype( "OB_LEO_FACILITY_LABS", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_LABS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_LABS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_LABS", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_FACILITY_LABS" );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0xa972b198, Offset: 0x825
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance facility_labs_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x2ec6597b, Offset: 0x88a
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance thread facility_labs_main();
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0xde1bb8c9, Offset: 0x8cf
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_42f25eb087152c68
// Params 1
// Checksum 0x9fd3cd3e, Offset: 0x8f3
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

    // Namespace namespace_42f25eb087152c68
    // Params 0
    // Checksum 0x4968726, Offset: 0x9af
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_42f25eb087152c68
// Params 1
// Checksum 0x67597ae0, Offset: 0x9bc
// Size: 0x19
function player_setup( player )
{
    activity_instance = self;
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x313c6dae, Offset: 0x9dd
// Size: 0x4f
function facility_labs_start()
{
    thread mp_sat_ob_leo_util::function_96b32ff9e4b0fc4c();
    thread mp_sat_ob_leo_util::function_d2eaefb295692571();
    thread namespace_fc92da645acfbbdc::function_1b86168fadcfb49d();
    level utility::flag_set( "facility_presentation_complete" );
    mp_sat_ob_leo_util::unlock_door( "central_to_lower_atrium_door" );
    mp_sat_ob_leo_util::unlock_door( "junction_to_central_door" );
    mp_sat_ob_leo_util::turn_off_force_field( "presentation_ff", "targetname", 1 );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0xa8ed8a7e, Offset: 0xa34
// Size: 0x84
function facility_labs_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_facility_labs_weapon", "facility_to_jungle_complete", 1 );
    level thread mp_sat_ob_leo_vo::facility_labs_vo();
    level thread mp_sat_ob_leo_util::turn_on_force_field( "quantum_security_ff" );
    level thread function_a1a034809cfe0f33();
    thread facility_labs_objectives();
    thread facility_labs_encounters();
    level thread facility_vignettes();
    level utility::flag_wait( "flag_leo_macguffin_igc_done" );
    level utility::flag_set( "facility_labs_complete" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0xa144c94f, Offset: 0xac0
// Size: 0x192
function function_a1a034809cfe0f33()
{
    a_turret_structs = utility::getstructarray( "lab1_turret", "targetname" );
    
    foreach ( var_555a947463e55350 in a_turret_structs )
    {
        turret = ob_soldier_util::ob_sentry_turret_spawn( var_555a947463e55350 );
        waitframe();
        level.sentrysettings[ "ai_sentry_turret" ].targetrange = 10000;
        level.sentrysettings[ "ai_sentry_turret" ].burstmin = 55;
        level.sentrysettings[ "ai_sentry_turret" ].burstmax = 60;
        level.sentrysettings[ "ai_sentry_turret" ].pausemin = 2;
        level.sentrysettings[ "ai_sentry_turret" ].pausemax = 4;
        level.sentrysettings[ "ai_sentry_turret" ].spinuptime = 2;
        turret.isactive = 1;
        turret.team = "team_hundred_ninety";
        visibility_mode::function_3afc3bc470c80e61( turret, turret.team );
        level notify( #"highvis_reload_outline", turret.team, [ turret ] );
    }
}

// Namespace namespace_42f25eb087152c68
// Params 0, eflags: 0x4
// Checksum 0xaad2fec9, Offset: 0xc5a
// Size: 0x7f
function private facility_labs_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( %"hash_45d1aab33743f656" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "facility_escape_1_obj_marker_start", undefined, "" );
    level utility::flag_wait( "flag_labs_security_ff_destroyed" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( "facility_escape_1_obj_marker_start" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "facility_macguffin_door_interact", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0xb97e6b55, Offset: 0xce1
// Size: 0x352
function facility_labs_encounters()
{
    facility_labs_metal_detectors = getent( "facility_labs_metal_detectors", #targetname );
    facility_labs_metal_detectors waittill( #"trigger" );
    level utility::flag_set( "flag_labs_forcefields_start" );
    
    foreach ( player in level.players )
    {
        player thread function_ac1698106032e7ce();
    }
    
    level thread mp_sat_ob_leo_util::function_df0396a50445e0c4( "labs_fire_alarms", "flag_leo_macguffin_igc_start" );
    level thread function_22b10d6ffa71dfec();
    force_fields = getentarray( "labs_security_ff", "targetname" );
    
    foreach ( ff in force_fields )
    {
        ff mp_sat_ob_libra_util::force_field_on();
    }
    
    facility_labs_encounter_start_trig = getent( "facility_labs_encounter_start_trig", #targetname );
    facility_labs_encounter_start_trig waittill( #"trigger" );
    level utility::flag_set( "flag_labs_encounter_start" );
    level.var_aa4a9819b5a7a591 = [];
    wait 0.5;
    thread macguffin_cinematic();
    labs1_wave1 = ai_spawn_director::array_spawn_targetname( "labs1_wave1" );
    level thread function_5dbaadbcdddf36ab();
    
    if ( level.players.size >= 3 )
    {
        labs1_wave1_3p = ai_spawn_director::array_spawn_targetname( "labs1_wave1_3p" );
        labs1_wave1 = arraycombine( labs1_wave1, labs1_wave1_3p );
    }
    
    tether_ai = [];
    
    foreach ( guy in labs1_wave1 )
    {
        if ( guy.script_noteworthy == "shield_squad_anchor" )
        {
            anchor_ai = guy;
        }
        
        if ( guy.script_noteworthy == "shield_squad_tether" )
        {
            tether_ai[ tether_ai.size ] = guy;
        }
    }
    
    ob_humans::function_6198eaa0deba2b53( anchor_ai, tether_ai );
    level thread leo_audio::facility_labs_walla( labs1_wave1 );
    level thread mp_sat_ob_leo_util::function_2463b23bc69b1a0a( labs1_wave1, labs1_wave1.size - 2, "flag_labs1_wave2" );
    utility::flag_wait( "flag_labs1_wave2" );
    level thread mp_sat_ob_leo_util::function_ac9de8895f3e4a23( labs1_wave1, "vol_labs1_ending" );
    labs1_wave2 = ai_spawn_director::array_spawn_targetname( "labs1_wave2" );
    struct = utility::getstruct( "labs_exit_2", "targetname" );
    level thread mp_sat_ob_leo_util::function_2463b23bc69b1a0a( labs1_wave2, labs1_wave2.size - 3, "flag_labs_ending" );
    utility::flag_wait( "flag_labs_ending" );
    allguys = ai_spawn_director::get_ai_group_ai( "ai_labs1" );
    level thread mp_sat_ob_leo_util::function_ac9de8895f3e4a23( allguys, "vol_labs1_ending" );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0xac3ff85a, Offset: 0x103b
// Size: 0x5a
function function_22b10d6ffa71dfec()
{
    var_68b32a8bafee7061 = "flag_leo_macguffin_igc_start";
    tick_name = "labs_alarm_tick";
    period = 1.5;
    level thread mp_sat_ob_leo_util::alarm_listener( "amb_emt_security_alarm_1", ( 15911, -907, -4656 ), tick_name, var_68b32a8bafee7061 );
    level thread mp_sat_ob_leo_util::function_eae6f210af41e04f( tick_name, period, var_68b32a8bafee7061 );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0xf68affd3, Offset: 0x109d
// Size: 0x35
function function_ac1698106032e7ce()
{
    self endon( #"death_or_disconnect" );
    level utility::flag_wait( "flag_guild_labs_player_entered_office" );
    wait 1;
    hints::hint_add_simple( "leo_ammo_cache_hint", &"sat_ob_story_missions/leo_ammo_cache_hint", 10 );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0xf7d9cb43, Offset: 0x10da
// Size: 0x29
function function_5dbaadbcdddf36ab()
{
    guy = ai_spawn_director::get_ai_group_ai( "labs_riot_guy" );
    guy[ 0 ].var_de04c2fb38eec74a = 1;
}

// Namespace namespace_42f25eb087152c68
// Params 3
// Checksum 0x6e007c85, Offset: 0x110b
// Size: 0x2b
function function_b454c1c1d9954524( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_labs_enemies_spawned" );
}

// Namespace namespace_42f25eb087152c68
// Params 4
// Checksum 0xd2211ade, Offset: 0x113e
// Size: 0x3e
function labs_spawn_func( requestid, instance, agent, ai_data )
{
    level.var_aa4a9819b5a7a591[ level.var_aa4a9819b5a7a591.size ] = agent;
}

// Namespace namespace_42f25eb087152c68
// Params 3
// Checksum 0xd182ab82, Offset: 0x1184
// Size: 0x45
function function_6ac92ddf0bd5714f( requestid, userdata, shutdowndata )
{
    level utility::flag_set( "flag_labs_encounter_done" );
    iprintln( "labs encounter complete!" );
    ai_spawn_director::cancel_spawn_request( level.enc_facility_labs );
}

// Namespace namespace_42f25eb087152c68
// Params 3
// Checksum 0x66ef19c, Offset: 0x11d1
// Size: 0x1a3
function function_c02c3bc3a04b3e80( requestid, activity_instance, agent )
{
    level.var_aa4a9819b5a7a591 = utility::array_removedead_or_dying( level.var_aa4a9819b5a7a591 );
    
    if ( level.var_aa4a9819b5a7a591.size < 3 )
    {
        iprintln( "enemies rush nearest player" );
        
        foreach ( agent in level.var_aa4a9819b5a7a591 )
        {
            players = ob_story_mission_utils::get_playing_players();
            closest_player = function_47c86977a18df38b( players, agent.origin );
            agent setgoalentity( closest_player );
            agent.goalradius = 32;
        }
        
        return;
    }
    
    if ( level.var_aa4a9819b5a7a591.size < 6 )
    {
        iprintln( "enemies retreat to exit" );
        exit_struct = utility::getstruct( "labs_exit" );
        
        foreach ( agent in level.var_aa4a9819b5a7a591 )
        {
            agent setgoalpos( exit_struct.origin );
        }
    }
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x824759e4, Offset: 0x137c
// Size: 0x12
function facility_vignettes()
{
    level thread labs_a();
    level thread labs_b();
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x326a21f6, Offset: 0x1396
// Size: 0xec
function labs_a()
{
    scene_struct = utility::getstruct( "scene_sat_cin_leo_labs_a", "targetname" );
    scene_struct scene::add_spawn_function( &mp_sat_ob_leo_util::function_964f0734bd246983, "Types_Actor" );
    scene_struct thread scene::pre_stream();
    scene_struct thread cleanup_labs_scenes();
    level utility::flag_wait( "facility_presentation_complete" );
    scene_struct thread scene::play( undefined, "idle" );
    facility_labs_door_opened = getent( "facility_labs_door_opened", #targetname );
    facility_labs_door_opened waittill( #"trigger" );
    level utility::flag_set( "flag_labs_start_vignettes" );
    scene_struct scene::play( undefined, "react" );
    scientist = scene_struct scene::get_entity( "scientist_01" );
    goal_node = getnode( "labs_a_node", "targetname" );
    
    if ( isalive( scientist ) && isdefined( goal_node ) )
    {
        scientist setgoalnode( goal_node );
    }
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x72a6e277, Offset: 0x148a
// Size: 0xa6
function labs_b()
{
    scene_struct = utility::getstruct( "scene_sat_cin_leo_labs_b", "targetname" );
    scene_struct scene::add_spawn_function( &mp_sat_ob_leo_util::function_964f0734bd246983, "Types_Actor" );
    scene_struct thread scene::pre_stream();
    scene_struct thread cleanup_labs_scenes();
    level utility::flag_wait( "flag_labs_start_vignettes" );
    scene_struct scene::play( undefined, "react" );
    scientist = scene_struct scene::get_entity( "scientist_02" );
    goal_node = getnode( "labs_b_node", "targetname" );
    
    if ( isalive( scientist ) && isdefined( goal_node ) )
    {
        scientist setgoalnode( goal_node );
    }
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0xbea343ae, Offset: 0x1538
// Size: 0x5c
function labs_c_1()
{
    scene_struct = utility::getstruct( "scene_sat_cin_leo_labs_c_1", "targetname" );
    scene_struct scene::add_spawn_function( &mp_sat_ob_leo_util::function_964f0734bd246983, "Types_Actor" );
    scene_struct thread cleanup_labs_scenes();
    level utility::flag_wait( "flag_labs_start_vignettes" );
    wait 0.5;
    scene_struct scene::play( undefined, "react" );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0xbea343ae, Offset: 0x159c
// Size: 0x5c
function labs_c_2()
{
    scene_struct = utility::getstruct( "scene_sat_cin_leo_labs_c_2", "targetname" );
    scene_struct scene::add_spawn_function( &mp_sat_ob_leo_util::function_964f0734bd246983, "Types_Actor" );
    scene_struct thread cleanup_labs_scenes();
    level utility::flag_wait( "flag_labs_start_vignettes" );
    wait 0.5;
    scene_struct scene::play( undefined, "react" );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x81a34399, Offset: 0x1600
// Size: 0x56
function labs_d_1()
{
    scene_struct = utility::getstruct( "scene_sat_cin_leo_labs_d_1", "targetname" );
    scene_struct scene::add_spawn_function( &mp_sat_ob_leo_util::function_964f0734bd246983, "Types_Actor" );
    scene_struct thread cleanup_labs_scenes();
    level utility::flag_wait( "flag_labs_start_vignettes" );
    scene_struct scene::play( undefined, "react" );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x81a34399, Offset: 0x165e
// Size: 0x56
function labs_d_2()
{
    scene_struct = utility::getstruct( "scene_sat_cin_leo_labs_d_2", "targetname" );
    scene_struct scene::add_spawn_function( &mp_sat_ob_leo_util::function_964f0734bd246983, "Types_Actor" );
    scene_struct thread cleanup_labs_scenes();
    level utility::flag_wait( "flag_labs_start_vignettes" );
    scene_struct scene::play( undefined, "react" );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x1f0c6642, Offset: 0x16bc
// Size: 0x18
function cleanup_labs_scenes()
{
    level utility::flag_wait( "flag_leo_cradle_cinematic_done" );
    scene::cleanup( 1 );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x1e02fda8, Offset: 0x16dc
// Size: 0x3e3
function macguffin_cinematic()
{
    scene_sat_cin_leo_quantum_room = utility::getstruct( "scene_sat_cin_leo_quantum_room", "targetname" );
    scene_sat_cin_leo_quantum_room scene::pre_stream();
    level utility::flag_wait( "flag_quantum_security_ff_destroyed" );
    activity_instance = self;
    struct = utility::getstruct( "facility_macguffin_door_interact" );
    prompt = gameobjects::createhintobject( struct.origin, "HINT_BUTTON", undefined, &"mp_dmz_locks/unlock_door" );
    prompt waittill( #"trigger", var_9d64a5e2cee72c8f );
    prompt delete();
    a_spawn_points = utility::getstructarray( "facility_macguffin_teleport" );
    ob_story_mission_utils::set_revive_spawns( a_spawn_points );
    coop::function_164d95b45992525( { #var_ba7c3b8fa9d3823:var_9d64a5e2cee72c8f } );
    level utility::flag_set( "flag_leo_macguffin_igc_start" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( "facility_macguffin_door_interact" );
    
    if ( !coop::should_play_igcs() )
    {
        macguffin_teleport();
        return;
    }
    
    mp_sat_ob_leo_util::function_f20a9fe6c594f5b3( 1 );
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 0.5, "black" );
    }
    
    wait 0.5;
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_in( 0.5, "black" );
    }
    
    thread function_1878a7f3405ced34();
    harper_ent = scene_sat_cin_leo_quantum_room scene::get_entity( "harper" );
    mason_ent = scene_sat_cin_leo_quantum_room scene::get_entity( "mason" );
    fiftyfifty_ent = scene_sat_cin_leo_quantum_room scene::get_entity( "fiftyfifty" );
    samuels_ent = scene_sat_cin_leo_quantum_room scene::get_entity( "samuels" );
    level notify( #"highvis_reload_outline", level.players[ 0 ].team, [ harper_ent, mason_ent, fiftyfifty_ent, samuels_ent ] );
    snd_ob::function_70013396bb42f6cc( level.players, "scene_sat_cin_leo_quantum_core" );
    scene_sat_cin_leo_quantum_room scene::play();
    snd_ob::function_52bc8194809997e8( level.players, "scene_sat_cin_leo_quantum_core" );
    macguffin_teleport();
    wait 0.5;
    function_aa3cd643ac2c86cc( 10, "WorldAndHud" );
    mp_sat_ob_leo_util::function_f20a9fe6c594f5b3( 0 );
    
    if ( !isdefined( level._ai_group[ self.script_aigroup ] ) )
    {
        return [];
    }
    
    allguys = ai_spawn_director::get_ai_group_ai( "ai_labs1" );
    
    foreach ( guy in allguys )
    {
        if ( isalive( guy ) )
        {
            guy.death_source = "despawn";
            guy.nocorpse = 1;
            guy.var_a13bed1ac47e1b2c = 1;
            guy.dropweapon = 0;
            guy.nodrop = 1;
            guy agent_utils::despawnagent();
        }
    }
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x351f269, Offset: 0x1ac7
// Size: 0x44
function function_1878a7f3405ced34()
{
    wait 1;
    mp_sat_ob_leo_util::function_69a8cda9aa00992e( "macguffin_to_junction_door" );
    wait 0.75;
    mp_sat_ob_leo_util::function_69a8cda9aa00992e( "junction_to_macguffin_door" );
    wait 2.25;
    mp_sat_ob_leo_util::lock_door( "junction_to_macguffin_door" );
    wait 1;
    mp_sat_ob_leo_util::lock_door( "macguffin_to_junction_door" );
}

// Namespace namespace_42f25eb087152c68
// Params 0
// Checksum 0x9ec9ce86, Offset: 0x1b13
// Size: 0x66
function macguffin_teleport()
{
    a_spawn_points = utility::getstructarray( "facility_macguffin_teleport" );
    a_spawn_points = arrayrandomize( a_spawn_points );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        coop::teleport_player( level.players[ i ], a_spawn_points[ i ] );
    }
    
    level utility::flag_set( "flag_leo_macguffin_igc_done" );
}

