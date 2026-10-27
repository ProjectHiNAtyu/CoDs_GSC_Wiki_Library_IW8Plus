// script_b33af2a8ff1f566  (hash_0b33af2a8ff1f566.gscc) (size: 14830 Bytes / 0x39ee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d28fb91 (1562966929)
// size ...... 14830 (0x39ee)
// includes .. 18  (offset: 0x34c6)
// strings ... 71  (offset: 0x3556)
// dev strs .. 0   (offset: 0x39ee)
// exports ... 50  (offset: 0x1eea)
// cseg ...... 0x861 + 0x1689 (0x1eea)
// imports ... 108 (offset: 0x26ba)
// animtree1 . 0   (offset: 0x39ee)
// animtree2 . 0   (offset: 0x39ee)
#using script_1369f66fa8958a74;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;

#namespace namespace_1d74227ab4ba1dee;

/#

    // Namespace namespace_1d74227ab4ba1dee
    // Params 0
    // Checksum 0x708312b0, Offset: 0x87f
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_1d74227ab4ba1dee
// Params 0, eflags: 0x5
// Checksum 0xfbb7dc6d, Offset: 0x88c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_227b1b67e1d09291", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0, eflags: 0x4
// Checksum 0xa3d705a2, Offset: 0x8b5
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_FACILITY_ESCAPE_2";
    activity_common::registeractivitytype( "OB_LEO_FACILITY_ESCAPE_2", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_ESCAPE_2", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_ESCAPE_2", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_ESCAPE_2", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_FACILITY_ESCAPE_2" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x21d1ed03, Offset: 0x92c
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_b8e87ef2531c038d();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x12095879, Offset: 0x991
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance thread function_f562370c7ae0ebe6();
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xedb4894f, Offset: 0x9d6
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 1
// Checksum 0xfe4e663a, Offset: 0x9fa
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

    // Namespace namespace_1d74227ab4ba1dee
    // Params 0
    // Checksum 0x3739b6a0, Offset: 0xab6
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_1d74227ab4ba1dee
// Params 1
// Checksum 0x54f64b66, Offset: 0xac3
// Size: 0x19
function player_setup( player )
{
    activity_instance = self;
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xb577426a, Offset: 0xae4
// Size: 0x43
function function_b8e87ef2531c038d()
{
    thread mp_sat_ob_leo_util::function_5bc972408ebad07a();
    thread mp_sat_ob_leo_util::function_81942b7272d9ec15();
    thread namespace_fc92da645acfbbdc::function_1b86168fadcfb49d();
    mp_sat_ob_leo_util::unlock_door( "central_to_lower_atrium_door" );
    mp_sat_ob_leo_util::turn_off_force_field( "presentation_ff", "targetname", 1 );
    level utility::flag_set( "flag_leo_cradle_cinematic_done" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xe095de75, Offset: 0xb2f
// Size: 0x19a
function function_f562370c7ae0ebe6()
{
    activity_instance = self;
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_facility_escape_2_weapon", "facility_to_jungle_complete", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_facility_escape_2_equipment", "facility_to_jungle_complete", 1 );
    utility::exploder( "facility_cradle_volumes" );
    hwconfiguratoraddasset( %"hw_sat_ob_fogheightmapfade_1" );
    level thread namespace_a350a26c6d662a6a::cradle_pocket_handler( "cradle_pocket", "facility_escape_2_complete" );
    thread function_3b70fe1733b8b404();
    level thread mp_sat_ob_leo_vo::function_5a618ffb1ca251c4();
    thread function_296f4c69c349b163();
    thread function_785898626665d28d();
    level thread function_2c486e2d2f272ea2();
    level thread leo_audio::function_a39a0388f4ec2164();
    
    foreach ( player in level.players )
    {
        player thread leo_audio::function_2d9c65b845cabe3f();
    }
    
    level thread leo_audio::function_b278cdf47d285895();
    struct = utility::getstruct( "facility_to_jungle_door_interact" );
    prompt = gameobjects::createhintobject( struct.origin, "HINT_BUTTON", undefined, &"mp_dmz_locks/unlock_door" );
    prompt waittill( #"trigger", var_9d64a5e2cee72c8f );
    prompt delete();
    activity_instance_common::endactivity( self, 1 );
    level utility::flag_set( "facility_escape_2_complete" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x783a0752, Offset: 0xcd1
// Size: 0x32
function function_3b70fe1733b8b404()
{
    mp_sat_ob_leo_util::unlock_door( "cradle_to_central_door" );
    mp_sat_ob_leo_util::unlock_door( "central_to_cradle_door" );
    mp_sat_ob_leo_util::unlock_door( "atrium_to_nic_door" );
    mp_sat_ob_leo_util::lock_door( "central_to_junction_door" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x10768706, Offset: 0xd0b
// Size: 0x6c
function function_296f4c69c349b163()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( %"hash_666156606a773abe" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "facility_to_jungle_door_interact", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level utility::flag_wait( "facility_escape_2_complete" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( "facility_to_jungle_door_interact" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x15934cb3, Offset: 0xd7f
// Size: 0x1f3
function function_785898626665d28d()
{
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 3, undefined, level.players, undefined, undefined, 1 );
    level utility::flag_set( "flag_central_escape_encounter_start" );
    mp_sat_ob_leo_util::open_door( "cradle_to_central_door" );
    mp_sat_ob_leo_util::close_door( "central_to_lower_atrium_door" );
    thread spawn_central_escape_enemies();
    facility_atrium_escape_encounter_start_trig = getent( "facility_atrium_escape_encounter_start_trig", #targetname );
    facility_atrium_escape_encounter_start_trig waittill( #"trigger" );
    level utility::flag_set( "flag_atrium_escape_encounter_start" );
    central_escape_enemies = ai_spawn_director::get_ai_group_ai( "central_escape" );
    utility::array_thread( central_escape_enemies, &cleanup_central_escape_enemies );
    
    foreach ( agent in level.var_a097d876fa75a3c0 )
    {
        agent utility::delaythread( 0.5, &agent_utils::despawnagent );
    }
    
    level.var_1e12fea40b4e667f = [];
    level.var_ee89b32a6f8a05ad = activity_ai_encounters::function_92b671064b0b1ce2( "encounter_facility_atrium_escape", 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.var_ee89b32a6f8a05ad, 1 );
    ai_spawn_director::add_spawned_callback( level.var_ee89b32a6f8a05ad, &function_3357cddf7a30c211 );
    ai_spawn_director::function_a49c35b72d6b6fea( level.var_ee89b32a6f8a05ad, &function_1ab65bcc251602db );
    facility_atrium_exit_encounter_start_trig = getent( "facility_atrium_exit_encounter_start_trig", #targetname );
    facility_atrium_exit_encounter_start_trig waittill( #"trigger" );
    level utility::flag_set( "flag_escape_2_player_near_nic_exit" );
    level notify( #"hash_d954a06bbae194" );
    level utility::flag_wait( "flag_escape_2_player_in_trippy_hall" );
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 3, undefined, level.players, undefined, undefined, 1 );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x21b87ded, Offset: 0xf7a
// Size: 0x98
function spawn_central_escape_enemies()
{
    level endon( #"flag_atrium_escape_encounter_start" );
    trig_escape_2_cradle_spawns = getnoentvolumearray( "trig_escape_2_cradle_spawns", "targetname" );
    
    foreach ( trigger in trig_escape_2_cradle_spawns )
    {
        trigger childthread function_7808ee1ba4ed5c8b();
    }
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xd6e5c330, Offset: 0x101a
// Size: 0x68
function function_7808ee1ba4ed5c8b()
{
    self waittill( #"trigger", player );
    
    if ( utility::flag( "flag_central_escape_enemies_spawned" ) )
    {
        level utility::flag_set( "flag_central_escape_enemies_spawned_2" );
    }
    
    level utility::flag_set( "flag_central_escape_enemies_spawned" );
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", 3, undefined, player, undefined, undefined, 1 );
    ai_spawn_director::spawn_targetname( self.target );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 3
// Checksum 0x805d6874, Offset: 0x108a
// Size: 0x2b
function function_2133fa661d07f825( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_cradle_escape_enemies_spawned" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 4
// Checksum 0xb42d97f3, Offset: 0x10bd
// Size: 0x35
function function_3eac3332e4bbe7cc( requestid, instance, agent, ai_data )
{
    agent waittill( #"death" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 3
// Checksum 0x207522cb, Offset: 0x10fa
// Size: 0x2b
function function_29a8630fbdc656eb( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_central_escape_enemies_spawned" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 4
// Checksum 0xf1e36091, Offset: 0x112d
// Size: 0x3e
function central_escape_spawn_func( requestid, instance, agent, ai_data )
{
    level.var_a097d876fa75a3c0[ level.var_a097d876fa75a3c0.size ] = agent;
}

// Namespace namespace_1d74227ab4ba1dee
// Params 3
// Checksum 0x2cb67864, Offset: 0x1173
// Size: 0x66
function function_bc2506402100f7c9( requestid, activity_instance, agent )
{
    if ( utility::flag( "flag_central_escape_wave_2_spawned" ) )
    {
        return;
    }
    
    level.var_a097d876fa75a3c0 = utility::array_removedead_or_dying( level.var_a097d876fa75a3c0 );
    
    if ( level.var_a097d876fa75a3c0.size < 4 )
    {
        iprintln( "enemies retreat to exit" );
        function_45b6bba3f9b64180();
    }
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xb47fb360, Offset: 0x11e1
// Size: 0x99
function function_45b6bba3f9b64180()
{
    exit_struct = utility::getstruct( "central_escape_exit" );
    
    foreach ( agent in level.var_a097d876fa75a3c0 )
    {
        agent setgoalpos( exit_struct.origin );
    }
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xfbe5afbc, Offset: 0x1282
// Size: 0x43
function cleanup_central_escape_enemies()
{
    if ( isalive( self ) )
    {
        self.nocorpse = 1;
        playfx( level._effect[ "menendez_disappear" ], self.origin );
        utility::delaythread( 0.5, &agent_utils::despawnagent );
    }
}

// Namespace namespace_1d74227ab4ba1dee
// Params 3
// Checksum 0x1915e30f, Offset: 0x12cd
// Size: 0x28
function function_29c3b5420de396c4( requestid, userdata, shutdowndata )
{
    iprintln( "central escape encounter complete!" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 4
// Checksum 0x86b82c78, Offset: 0x12fd
// Size: 0xa5
function function_3357cddf7a30c211( requestid, instance, agent, ai_data )
{
    level.var_1e12fea40b4e667f[ level.var_1e12fea40b4e667f.size ] = agent;
    agent.goalradius = 32;
    
    if ( isdefined( ai_data.script_noteworthy ) )
    {
        if ( issubstr( ai_data.script_noteworthy, "axis" ) )
        {
            agent.team = "team_hundred_ninety_four";
            thread function_e92c4aef9cd70707( agent );
        }
        else
        {
            thread function_d12fa5dffded4bd9( agent );
        }
    }
    
    self waittill( #"death" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 1
// Checksum 0x8f5e3fb6, Offset: 0x13aa
// Size: 0x33
function function_e92c4aef9cd70707( agent )
{
    agent endon( #"death" );
    
    while ( true )
    {
        wait randomintrange( 1, 90 );
        mp_sat_ob_leo_vo::function_115cf73d8205c888( agent );
    }
}

// Namespace namespace_1d74227ab4ba1dee
// Params 1
// Checksum 0x1f724cfe, Offset: 0x13e5
// Size: 0x33
function function_d12fa5dffded4bd9( agent )
{
    agent endon( #"death" );
    
    while ( true )
    {
        wait randomintrange( 1, 90 );
        mp_sat_ob_leo_vo::function_8532b0cfc0c248a( agent );
    }
}

// Namespace namespace_1d74227ab4ba1dee
// Params 3
// Checksum 0x7606ea3c, Offset: 0x1420
// Size: 0x28
function function_1ab65bcc251602db( requestid, userdata, shutdowndata )
{
    iprintln( "atrium escape encounter complete!" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 3
// Checksum 0xf5c73c42, Offset: 0x1450
// Size: 0x2b
function function_322fa8616d3dfa2c( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_exit_enemies_spawned" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x1fce6653, Offset: 0x1483
// Size: 0x128
function exit_glass_break()
{
    var_97167ef1b029e907 = utility::getstructarray( "facility_exit_glass_structs" );
    
    foreach ( struct in var_97167ef1b029e907 )
    {
        glassradiusdamage( struct.origin, 32, 100, 100 );
    }
    
    if ( level.players.size > 2 )
    {
        var_97167ef1b029e907 = utility::getstructarray( "facility_exit_glass_structs_large" );
        
        foreach ( struct in var_97167ef1b029e907 )
        {
            glassradiusdamage( struct.origin, 32, 100, 100 );
        }
    }
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x89010f0c, Offset: 0x15b3
// Size: 0x56
function function_2c486e2d2f272ea2()
{
    thread post_cradle_a();
    thread post_cradle_b();
    thread stairs_roll();
    thread front_balcony_death();
    thread back_exit_fight_guild_soldiers();
    thread front_kick_stairs();
    thread loop_fight();
    thread front_balcony_throw();
    thread front_desk_fight();
    thread post_cradle_c();
    thread back_knock_off();
    thread back_stairs_push();
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x685e6168, Offset: 0x1611
// Size: 0x50
function post_cradle_a()
{
    scene_struct = utility::getstruct( "scene_sat_cin_leo_post_cradle_a", "targetname" );
    scene_struct scene::add_spawn_function( &function_6ad912f40e2c66ad, "Types_Actor" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_leo_cradle_cinematic_done" );
    scene_struct scene::play();
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xafa98c82, Offset: 0x1669
// Size: 0x63
function post_cradle_b()
{
    scene_struct = utility::getstruct( "scene_sat_cin_leo_post_cradle_b", "targetname" );
    scene_struct scene::add_spawn_function( &function_6ad912f40e2c66ad, "Actor 1" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "Actor 2" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct scene::play();
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xa2381a48, Offset: 0x16d4
// Size: 0x69
function stairs_roll()
{
    scene_struct = utility::getstruct( "sat_ai_leo_post_cradle_01_stairs_roll", "targetname" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "guild_soldier_02" );
    scene_struct scene::add_spawn_function( &function_c832aa2460fc261c, "guild_soldier_02" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct scene::play( undefined, "intro" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x734147e4, Offset: 0x1745
// Size: 0x8f
function front_balcony_death()
{
    scene_struct = utility::getstruct( "sat_ai_leo_post_cradle_02_front_balcony_death", "targetname" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "guild_soldier_01" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct thread scene::play( undefined, "idle" );
    sat_ai_leo_post_cradle_02_front_balcony_death = getent( "sat_ai_leo_post_cradle_02_front_balcony_death", #targetname );
    sat_ai_leo_post_cradle_02_front_balcony_death waittill( #"trigger" );
    scene_struct scene::play( undefined, "intro" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x4e69fa90, Offset: 0x17dc
// Size: 0x63
function back_exit_fight_guild_soldiers()
{
    scene_struct = utility::getstruct( "sat_ai_leo_post_cradle_02_back_exit_fight_guild_soldiers", "targetname" );
    scene_struct scene::add_spawn_function( &function_6ad912f40e2c66ad, "guild_soldier_01" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "guild_soldier_02" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct scene::play();
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x59b5ca1c, Offset: 0x1847
// Size: 0xc1
function front_kick_stairs()
{
    scene_struct = utility::getstruct( "sat_ai_leo_post_cradle_02_front_kick_stairs", "targetname" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "guild_soldier_01" );
    scene_struct scene::add_spawn_function( &function_6ad912f40e2c66ad, "guild_soldier_03" );
    scene_struct scene::add_spawn_function( &function_c832aa2460fc261c, "guild_soldier_03" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct thread scene::play( undefined, "idle" );
    wait 1;
    guild_soldier_01 = scene_struct scene::get_entity( "guild_soldier_01" );
    guild_soldier_01 endon( #"death" );
    scene_struct scene::play( undefined, "intro" );
    scene_struct thread scene::play( guild_soldier_01, "loop" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xc1e1f464, Offset: 0x1910
// Size: 0x76
function loop_fight()
{
    scene_struct = utility::getstruct( "sat_ai_leo_post_cradle_02_loop_fight_guild_soldiers", "targetname" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "guild_soldier_01" );
    scene_struct scene::add_spawn_function( &function_6ad912f40e2c66ad, "guild_soldier_02" );
    scene_struct scene::add_spawn_function( &function_c832aa2460fc261c, "guild_soldier_02" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct scene::play();
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x734147dd, Offset: 0x198e
// Size: 0x92
function front_balcony_throw()
{
    scene_struct = utility::getstruct( "sat_ai_leo_post_cradle_02_front_balcony_throw", "targetname" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "guild_soldier_01" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct thread scene::play( undefined, "idle" );
    sat_ai_leo_post_cradle_02_front_balcony_throw = getent( "sat_ai_leo_post_cradle_02_front_balcony_death", #targetname );
    sat_ai_leo_post_cradle_02_front_balcony_throw waittill( #"trigger" );
    wait 2;
    scene_struct scene::play( undefined, "intro" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x56356e8f, Offset: 0x1a28
// Size: 0xb5
function front_desk_fight()
{
    scene_struct = utility::getstruct( "sat_ai_leo_post_cradle_02_front_desk_fight_guild_soldier", "targetname" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "guild_soldier_attacker_01" );
    scene_struct scene::add_spawn_function( &function_6ad912f40e2c66ad, "guild_soldier_victim_02" );
    scene_struct scene::add_spawn_function( &function_c832aa2460fc261c, "guild_soldier_victim_02" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct thread scene::play( undefined, "loop_idle" );
    sat_ai_leo_post_cradle_02_front_desk_fight_guild_soldier = getent( "sat_ai_leo_post_cradle_02_front_desk_fight_guild_soldier", #targetname );
    sat_ai_leo_post_cradle_02_front_desk_fight_guild_soldier waittill( #"trigger" );
    scene_struct thread scene::play( undefined, "desk_fight_event" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xafa98c82, Offset: 0x1ae5
// Size: 0x63
function post_cradle_c()
{
    scene_struct = utility::getstruct( "scene_sat_cin_leo_post_cradle_c", "targetname" );
    scene_struct scene::add_spawn_function( &function_6ad912f40e2c66ad, "Actor 1" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "Actor 2" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct scene::play();
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x315c010e, Offset: 0x1b50
// Size: 0xb5
function back_stairs_push()
{
    scene_struct = utility::getstruct( "sat_ai_leo_post_cradle_02_back_stairs_push", "targetname" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "guild_soldier_01" );
    scene_struct scene::add_spawn_function( &function_6ad912f40e2c66ad, "guild_soldier_02" );
    scene_struct scene::add_spawn_function( &function_c832aa2460fc261c, "guild_soldier_02" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct thread scene::play( undefined, "idle" );
    sat_ai_leo_post_cradle_02_back_stairs_push = getent( "sat_ai_leo_post_cradle_02_back_knock_off", #targetname );
    sat_ai_leo_post_cradle_02_back_stairs_push waittill( #"trigger" );
    scene_struct scene::play( undefined, "intro" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x9c3a39d1, Offset: 0x1c0d
// Size: 0xc8
function back_knock_off()
{
    scene_struct = utility::getstruct( "sat_ai_leo_post_cradle_02_back_knock_off", "targetname" );
    scene_struct scene::add_spawn_function( &function_d2960bc5eaeca563, "guild_soldier_01" );
    scene_struct scene::add_spawn_function( &function_6ad912f40e2c66ad, "guild_soldier_02" );
    scene_struct scene::add_spawn_function( &function_c832aa2460fc261c, "guild_soldier_01" );
    scene_struct scene::add_spawn_function( &function_c832aa2460fc261c, "guild_soldier_02" );
    scene_struct thread function_4c70ba7d6667dea7();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    scene_struct thread scene::play( undefined, "idle" );
    sat_ai_leo_post_cradle_02_back_knock_off = getent( "sat_ai_leo_post_cradle_02_back_knock_off", #targetname );
    sat_ai_leo_post_cradle_02_back_knock_off waittill( #"trigger" );
    scene_struct scene::play( undefined, "intro" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x2422308b, Offset: 0x1cdd
// Size: 0x69
function function_c832aa2460fc261c()
{
    utility::ent_flag_wait( "scene_active" );
    utility::ent_flag_waitopen_any( "scene_active" );
    enemies = getaiarray();
    var_84a51ca8ef81ff68 = sortbydistance( enemies, self.origin );
    
    if ( isdefined( var_84a51ca8ef81ff68[ 0 ] ) )
    {
        self kill( var_84a51ca8ef81ff68[ 0 ].origin, var_84a51ca8ef81ff68[ 0 ] );
        return;
    }
    
    self kill();
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xdc309821, Offset: 0x1d4e
// Size: 0xa4
function function_6ad912f40e2c66ad()
{
    self endon( #"death" );
    self.ignoreme = 1;
    self.team = "team_hundred_ninety";
    self.var_24954f14e27b448d = 0;
    self.var_4d3dee2aa67fa6a0 = 0;
    self.var_38a06ee92c60ee9e = 0;
    thread function_4615c478a16984c0();
    utility::ent_flag_wait( "scene_active" );
    var_bf1316595b384341 = self.health;
    self.health = 10;
    utility::ent_flag_waitopen_any( "scene_active" );
    self.health = var_bf1316595b384341;
    self.ignoreme = 0;
    self.var_24954f14e27b448d = 1;
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xda1ec9f5, Offset: 0x1dfa
// Size: 0xa4
function function_d2960bc5eaeca563()
{
    self endon( #"death" );
    self.ignoreme = 1;
    self.team = "team_hundred_ninety_four";
    self.var_24954f14e27b448d = 0;
    self.var_4d3dee2aa67fa6a0 = 0;
    self.var_38a06ee92c60ee9e = 0;
    thread function_4615c478a16984c0();
    utility::ent_flag_wait( "scene_active" );
    var_bf1316595b384341 = self.health;
    self.health = 10;
    utility::ent_flag_waitopen_any( "scene_active" );
    self.health = var_bf1316595b384341;
    self.ignoreme = 0;
    self.var_24954f14e27b448d = 1;
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xf807ce10, Offset: 0x1ea6
// Size: 0xf
function function_4615c478a16984c0()
{
    self waittill( #"death" );
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0x766048dd, Offset: 0x1ebd
// Size: 0xd
function function_ac11773f729aad5f()
{
    self.ignoreme = 1;
}

// Namespace namespace_1d74227ab4ba1dee
// Params 0
// Checksum 0xc4918e78, Offset: 0x1ed2
// Size: 0x18
function function_4c70ba7d6667dea7()
{
    level utility::flag_wait( "facility_escape_2_complete" );
    scene::cleanup( 1 );
}

