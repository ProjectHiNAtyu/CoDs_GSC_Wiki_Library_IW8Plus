// script_b0586c858a6797a  (hash_0b0586c858a6797a.gscc) (size: 17048 Bytes / 0x4298 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb972ded9 (3111313113)
// size ...... 17048 (0x4298)
// includes .. 27  (offset: 0x3cbc)
// strings ... 75  (offset: 0x3d94)
// dev strs .. 0   (offset: 0x4298)
// exports ... 37  (offset: 0x25f0)
// cseg ...... 0x8b5 + 0x1d3b (0x25f0)
// imports ... 133 (offset: 0x2bb8)
// animtree1 . 0   (offset: 0x4298)
// animtree2 . 0   (offset: 0x4298)
#using script_50ee493a72a5e95b;
#using script_5417edbf06e2d70b;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_spawn;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\systems\ob_humans;

#namespace namespace_1146e44035fa967c;

/#

    // Namespace namespace_1146e44035fa967c
    // Params 0
    // Checksum 0xf1c39922, Offset: 0x8d3
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_1146e44035fa967c
// Params 0, eflags: 0x5
// Checksum 0x24fd1cea, Offset: 0x8e0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3d43b4227ebd8ddd", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_1146e44035fa967c
// Params 0, eflags: 0x4
// Checksum 0x22978e30, Offset: 0x909
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_JUNGLE_VILLAGE";
    activity_common::registeractivitytype( "OB_LEO_JUNGLE_VILLAGE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_VILLAGE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_VILLAGE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_VILLAGE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_JUNGLE_VILLAGE" );
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0xde7aeed3, Offset: 0x980
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance jungle_village_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0xb3636c70, Offset: 0x9e5
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    level.request_ids = [];
    activity_instance thread jungle_village_main();
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0x6cf402dd, Offset: 0xa34
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_1146e44035fa967c
// Params 1
// Checksum 0xbe69b9f1, Offset: 0xa58
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

    // Namespace namespace_1146e44035fa967c
    // Params 0
    // Checksum 0xb6793d32, Offset: 0xb14
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_1146e44035fa967c
// Params 1
// Checksum 0x81c445c8, Offset: 0xb21
// Size: 0x1e
function player_setup( player )
{
    player thread ob_story_mission_utils::function_a1cd17816bae5f6();
    player thread ob_story_mission_utils::refill_super_mega_jump();
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0x547e6a6c, Offset: 0xb47
// Size: 0x51
function jungle_village_start()
{
    level thread mp_sat_ob_leo_util::function_46c7dd890b4e2bbb();
    level thread mp_sat_ob_leo_util::function_3c8a17513e90ef86();
    level utility::flag_set( "ob_leo_jungle_village_start" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_jungle_intro_weapon", "jungle_mansion_complete", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_jungle_intro_equipment", "jungle_mansion_complete", 1 );
    utility::exploder( "leo_nic_rocks_falling" );
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0xbc7200fd, Offset: 0xba0
// Size: 0x9e
function jungle_village_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread mp_sat_ob_leo_vo::function_d80456549097a669();
    thread function_565c0b37d6259925();
    thread mp_sat_ob_leo_vo::function_8cf7281eaa34cdc4();
    thread jungle_village_objectives();
    thread function_e7d8a9dc1fa2616e();
    thread function_a23061a8ab987f9e();
    thread function_f7752c67e633724c();
    level utility::flag_wait( "flag_jungle_village_center_approach_enc_retreat" );
    namespace_debc83c5256fe721::jungle_mansion_scene( 1 );
    level utility::flag_wait( "jungle_village_combat_done" );
    level utility::flag_wait( "mansion_courtyard_gate_interacted" );
    level utility::flag_set( "jungle_village_complete" );
    level notify( #"hash_5c9dae018fffee1f" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0x8e3fdd86, Offset: 0xc46
// Size: 0x34
function function_565c0b37d6259925()
{
    level utility::flag_wait( "flag_jungle_village_hill_top_enc_spawn" );
    thread mp_sat_ob_leo_vo::jungle_menendez_taunt( "jungle_menendez_taunt_2" );
    level utility::flag_wait( "flag_jungle_village_center_approach_enc_spawn" );
    thread mp_sat_ob_leo_vo::jungle_menendez_taunt( "jungle_menendez_taunt_3" );
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0xc7d41121, Offset: 0xc82
// Size: 0xa3
function function_e7d8a9dc1fa2616e()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    mp_sat_ob_leo_util::function_7ef23a62d6556750();
    level utility::flag_wait( "jungle_village_combat_done" );
    struct = utility::getstruct( "jungle_village_obj_marker_end", "targetname" );
    struct.interact = interaction::register_interact( struct.origin, 64, &function_446a5f9c8c509394, &"sat_ob_story_missions/leo_interact_open_gate", undefined, undefined, undefined, "HINT_BUTTON" );
    struct.interact.activity_instance = self;
    level utility::flag_wait( "mansion_courtyard_gate_interacted" );
}

// Namespace namespace_1146e44035fa967c
// Params 1
// Checksum 0x5315d0c9, Offset: 0xd2d
// Size: 0x40
function function_446a5f9c8c509394( player )
{
    level.var_a0fee1447220b47b = player;
    level utility::flag_set( "mansion_courtyard_gate_interacted" );
    self makeunusable();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
    
    level.var_a0fee1447220b47b = player;
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0xa03757b2, Offset: 0xd75
// Size: 0x119
function function_a23061a8ab987f9e()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    machete_target_scriptables = getentitylessscriptablearray( "machete_target", #targetname );
    
    if ( !isdefined( machete_target_scriptables ) || isdefined( machete_target_scriptables ) && machete_target_scriptables.size == 0 )
    {
        return;
    }
    
    level utility::flag_wait_any( "flag_jungle_village_hill_enc_retreat", "flag_jungle_village_start_first_machete_attack" );
    level utility::flag_set( "flag_nica_machete_nightmare_transition" );
    machete_target_scriptable = utility::function_30dbabe3200518b( "machete_target_tutorial", #targetname );
    ob_story_mission_machete_attack::function_bfee43bcb0dcc192( machete_target_scriptable );
    level thread leo_audio::function_e710af4789205a58( machete_target_scriptable );
    var_a958830ccdf2a447 = machete_target_scriptables;
    
    while ( !level utility::flag( "jungle_village_combat_done" ) )
    {
        machete_target = function_3d44eca67f67fabb( var_a958830ccdf2a447 );
        
        if ( isdefined( machete_target ) )
        {
            if ( !isdefined( self.second_machete ) )
            {
                self.second_machete = 1;
                utility::delaythread( 1, &utility::flag_set, "flag_jungle_village_second_machete_attack" );
            }
            
            ob_story_mission_machete_attack::function_bfee43bcb0dcc192( machete_target );
            var_a958830ccdf2a447 = arrayremove( var_a958830ccdf2a447, machete_target );
        }
        
        waitframe();
    }
}

// Namespace namespace_1146e44035fa967c
// Params 1
// Checksum 0xd7f8b6dc, Offset: 0xe96
// Size: 0x171
function function_3d44eca67f67fabb( machete_targets )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    min_dist = squared( 300 );
    the_target = undefined;
    
    while ( !level utility::flag( "jungle_village_combat_done" ) )
    {
        foreach ( player in level.players )
        {
            foreach ( machete_target in machete_targets )
            {
                dist = distancesquared( player.origin, machete_target.origin );
                
                if ( dist <= min_dist )
                {
                    the_target = machete_target;
                    break;
                }
            }
            
            if ( isdefined( the_target ) )
            {
                break;
            }
        }
        
        if ( isdefined( the_target ) )
        {
            break;
        }
        
        waitframe();
    }
    
    return the_target;
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0xc12e0b81, Offset: 0x1010
// Size: 0x6b4
function function_f7752c67e633724c()
{
    level utility::flag_wait( "flag_jungle_village_combat_start" );
    level.jungle_village_enemies = [];
    level.jungle_village_hill_top_enemies = [];
    level.jungle_village_center_approach_enemies = [];
    encounter_targetname = "leo_jungle_village_hill_enc";
    level.jungle_hill_enc = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.jungle_hill_enc, 1 );
    ai_spawn_director::add_spawned_callback( level.jungle_hill_enc, &function_91180689c832047b );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.jungle_hill_enc, &function_ab561aeae27b111b, self );
    level utility::flag_wait( "flag_jungle_hill_enemies_spawned" );
    level.audio.var_25e584ceb1945db6[ "jungle_hill" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "jungle_hill" ] thread leo_audio::combat_walla_oneshot( level.jungle_village_enemies, "jungle_hill", "dxx_leo_cradled_soldier_combat_ext", 3, 8, 4 );
    namespace_45ef22ffd1bf8e55::function_82d854bb84c20512( "hill_progress_tracker", level.jungle_village_enemies, &function_cddc1d7cb12c37d7 );
    level utility::flag_wait( "flag_player_crests_hill" );
    level.jungle_village_enemies = utility::array_removedead_or_dying( level.jungle_village_enemies );
    namespace_45ef22ffd1bf8e55::function_3ff7386bdfd71aca( "hill_progress_tracker" );
    encounter_targetname = "leo_jungle_village_hill_top_enc";
    level.jungle_hill_top_enc = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.jungle_hill_top_enc, 1 );
    ai_spawn_director::add_spawned_callback( level.jungle_hill_top_enc, &function_ae96dbc7ad269ed7 );
    ai_spawn_director::add_vehicle_spawned_callback( level.jungle_hill_top_enc, &function_9cdcafab0df8975d );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.jungle_hill_top_enc, &function_a8a15ad03b18aaaf, self );
    ai_spawn_director::function_5c8b22954b3bfa37( level.jungle_hill_top_enc, &function_9e98d10f418daaea );
    level utility::flag_wait( "flag_jungle_hill_top_enemies_spawned" );
    struct = utility::getstruct( "player_catchup_jungle_village", "targetname" );
    level.audio.var_25e584ceb1945db6[ "jungle_hill_top" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "jungle_hill_top" ] thread leo_audio::combat_walla_oneshot( level.jungle_village_hill_top_enemies, "jungle_hill_top", "dxx_leo_cradled_soldier_combat_ext", 2, 7, 3, undefined, 500 );
    thread function_e5f742c3bd17a3ee();
    level utility::flag_wait( "flag_jungle_village_center_approach_enc_spawn" );
    level.jungle_village_hill_top_enemies = utility::array_removedead_or_dying( level.jungle_village_hill_top_enemies );
    level.jungle_village_hill_top_enemies = arrayremoveduplicates( level.jungle_village_hill_top_enemies );
    utility::array_thread( level.jungle_village_hill_top_enemies, &ai_retreat, "jungle_village_center_approach_vol" );
    encounter_targetname = "leo_jungle_village_center_approach_enc";
    level.jungle_center_approach_enc = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.jungle_center_approach_enc, 1 );
    ai_spawn_director::add_spawned_callback( level.jungle_center_approach_enc, &function_ae96dbc7ad269ed7 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.jungle_center_approach_enc, &function_14f13e4f2fadfd94 );
    level utility::flag_wait( "flag_jungle_center_approach_enemies_spawned" );
    level.audio.var_25e584ceb1945db6[ "jungle_center_approach" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "jungle_center_approach" ] thread leo_audio::combat_walla_oneshot( level.jungle_village_enemies, "jungle_center_approach", "dxx_leo_cradled_soldier_combat_ext", 2, 7, 3, undefined, 400 );
    namespace_45ef22ffd1bf8e55::function_82d854bb84c20512( "center_approach_progress_tracker", level.jungle_village_enemies, &function_26dfc8cbb9d40e06 );
    level utility::flag_wait( "flag_jungle_village_center_enc_spawn" );
    level.jungle_village_center_approach_enemies = utility::array_removedead_or_dying( level.jungle_village_center_approach_enemies );
    level.jungle_village_center_approach_enemies = arrayremoveduplicates( level.jungle_village_center_approach_enemies );
    utility::array_thread( level.jungle_village_center_approach_enemies, &ai_retreat, "jungle_village_center_approach_vol" );
    encounter_targetname = "leo_jungle_village_center_enc";
    level.var_b1ff4395435f5576 = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.var_b1ff4395435f5576, 1 );
    ai_spawn_director::add_spawned_callback( level.var_b1ff4395435f5576, &function_ae96dbc7ad269ed7 );
    ai_spawn_director::add_vehicle_spawned_callback( level.var_b1ff4395435f5576, &function_9cdcafab0df8975d );
    ai_spawn_director::function_5c8b22954b3bfa37( level.var_b1ff4395435f5576, &function_efa4bff329d83144 );
    level thread function_630bc92a30242556();
    
    if ( !isstruct( level.audio.var_25e584ceb1945db6[ "jungle_center_approach" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "jungle_village_center" ] = spawnstruct();
        level.audio.var_25e584ceb1945db6[ "jungle_village_center" ] thread leo_audio::combat_walla_oneshot( level.jungle_village_enemies, "jungle_village_center", "dxx_leo_coordinated_ext", 2, 7, 3, undefined, 300 );
    }
    
    level utility::flag_wait( "flag_jungle_village_center_approach_enc_retreat" );
    level.jungle_village_enemies = utility::array_removedead_or_dying( level.jungle_village_enemies );
    utility::array_thread( level.jungle_village_enemies, &ai_retreat, "jungle_village_center_vol" );
    
    while ( level.jungle_village_enemies.size > 5 )
    {
        waitframe();
        level.jungle_village_enemies = utility::array_removedead_or_dying( level.jungle_village_enemies );
    }
    
    level.jungle_village_enemies = utility::array_removedead_or_dying( level.jungle_village_enemies );
    utility::array_thread( level.jungle_village_enemies, &ai_retreat, "jungle_village_center_vol_2" );
    
    while ( level.jungle_village_enemies.size > 3 )
    {
        waitframe();
        level.jungle_village_enemies = utility::array_removedead_or_dying( level.jungle_village_enemies );
    }
    
    level.var_fcdb3a8a83e67da8 = arraycombine( level.jungle_village_enemies, level.jungle_village_hill_top_enemies, level.jungle_village_center_approach_enemies );
    
    foreach ( agent in level.var_fcdb3a8a83e67da8 )
    {
        players = ob_story_mission_utils::get_playing_players();
        closest_player = function_47c86977a18df38b( players, agent.origin );
        
        if ( isdefined( closest_player ) )
        {
            if ( isdefined( agent ) )
            {
                agent notify( #"hash_7f736a7206eacbbc" );
                agent setgoalentity( closest_player );
                agent thread function_8fd8bfd2a5c6fff2();
            }
        }
    }
    
    while ( level.jungle_village_enemies.size > 0 )
    {
        waitframe();
        level.jungle_village_enemies = utility::array_removedead_or_dying( level.jungle_village_enemies );
    }
    
    level utility::flag_set( "jungle_village_combat_done" );
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0xfecc5d7c, Offset: 0x16cc
// Size: 0x6a
function function_8fd8bfd2a5c6fff2()
{
    self endon( #"death" );
    self endon( #"damage" );
    wait randomfloatrange( 10, 20 );
    
    if ( isalive( self ) )
    {
        self.nocorpse = 1;
        playfx( level._effect[ "menendez_disappear" ], self.origin );
        utility::delaythread( 0.5, &agent_utils::despawnagent );
    }
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0xbb9919f7, Offset: 0x173e
// Size: 0xe7
function function_630bc92a30242556()
{
    village_center_squad = ai_spawn_director::array_spawn_targetname( "village_center_squad" );
    tether_ai = [];
    
    foreach ( guy in village_center_squad )
    {
        level.jungle_village_enemies[ level.jungle_village_enemies.size ] = guy;
        
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
}

// Namespace namespace_1146e44035fa967c
// Params 3
// Checksum 0xb86855b0, Offset: 0x182d
// Size: 0x2b
function function_ab561aeae27b111b( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_jungle_hill_enemies_spawned" );
}

// Namespace namespace_1146e44035fa967c
// Params 3
// Checksum 0x60f63c6f, Offset: 0x1860
// Size: 0xb0
function function_cddc1d7cb12c37d7( requestid, activity_instance, agent )
{
    level.jungle_village_enemies = utility::array_removedead_or_dying( level.jungle_village_enemies );
    level.jungle_village_hill_top_enemies = utility::array_removedead_or_dying( level.jungle_village_hill_top_enemies );
    level.jungle_village_center_approach_enemies = utility::array_removedead_or_dying( level.jungle_village_center_approach_enemies );
    
    if ( !level utility::flag( "flag_jungle_village_first_kill" ) )
    {
        level utility::flag_set( "flag_jungle_village_first_kill" );
    }
    
    if ( level.jungle_village_enemies.size <= 5 )
    {
        if ( !level utility::flag( "flag_jungle_village_start_first_machete_attack" ) )
        {
            level utility::flag_set( "flag_jungle_village_start_first_machete_attack" );
        }
    }
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0xb8c00b28, Offset: 0x1918
// Size: 0xaa
function function_e5f742c3bd17a3ee()
{
    level endon( #"flag_jungle_village_center_approach_enc_retreat" );
    
    while ( true )
    {
        level.jungle_village_enemies = utility::array_removedead_or_dying( level.jungle_village_enemies );
        level.jungle_village_hill_top_enemies = utility::array_removedead_or_dying( level.jungle_village_hill_top_enemies );
        level.jungle_village_center_approach_enemies = utility::array_removedead_or_dying( level.jungle_village_center_approach_enemies );
        
        if ( level.jungle_village_enemies.size <= 3 )
        {
            if ( !level utility::flag( "flag_jungle_village_hill_top_reinforcements" ) )
            {
                level utility::flag_set( "flag_jungle_village_hill_top_reinforcements" );
                wait 0.5;
            }
            else
            {
                level utility::flag_set( "flag_jungle_village_center_approach_enc_spawn" );
                break;
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_1146e44035fa967c
// Params 3
// Checksum 0x4d0b582d, Offset: 0x19ca
// Size: 0x2b
function function_a8a15ad03b18aaaf( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_jungle_hill_top_enemies_spawned" );
}

// Namespace namespace_1146e44035fa967c
// Params 3
// Checksum 0xd100a1e, Offset: 0x19fd
// Size: 0xa3
function function_6b46f39761896593( requestid, activity_instance, agent )
{
    level.jungle_village_enemies = utility::array_removedead_or_dying( level.jungle_village_enemies );
    level.jungle_village_hill_top_enemies = utility::array_removedead_or_dying( level.jungle_village_hill_top_enemies );
    level.jungle_village_center_approach_enemies = utility::array_removedead_or_dying( level.jungle_village_center_approach_enemies );
    
    if ( level.jungle_village_enemies.size <= 3 )
    {
        if ( !level utility::flag( "flag_jungle_village_hill_top_reinforcements" ) )
        {
            level utility::flag_set( "flag_jungle_village_hill_top_reinforcements" );
            return;
        }
        
        level utility::flag_set( "flag_jungle_village_center_approach_enc_spawn" );
    }
}

// Namespace namespace_1146e44035fa967c
// Params 3
// Checksum 0x1146bbd6, Offset: 0x1aa8
// Size: 0x31, Type: bool
function function_9e98d10f418daaea( requestid, userdata, wavenumber )
{
    if ( level utility::flag( "flag_jungle_village_hill_top_reinforcements" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_1146e44035fa967c
// Params 3
// Checksum 0xd78103ae, Offset: 0x1ae2
// Size: 0x3e
function jungle_hill_top_shutdown( requestid, userdata, shutdowndata )
{
    requestdata = function_9b649316adcccbaa( requestid );
    requestdata namespace_45ef22ffd1bf8e55::function_3ff7386bdfd71aca( "hill_top_progress_tracker" );
}

// Namespace namespace_1146e44035fa967c
// Params 4
// Checksum 0xfee41dd, Offset: 0x1b28
// Size: 0xd3
function function_ae96dbc7ad269ed7( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    level.jungle_village_enemies[ level.jungle_village_enemies.size ] = agent;
    
    if ( requestid == level.jungle_hill_top_enc )
    {
        if ( !arraycontains( level.jungle_village_hill_top_enemies, agent ) )
        {
            level.jungle_village_hill_top_enemies[ level.jungle_village_hill_top_enemies.size ] = agent;
        }
    }
    
    if ( requestid == level.jungle_center_approach_enc )
    {
        if ( !arraycontains( level.jungle_village_center_approach_enemies, agent ) )
        {
            level.jungle_village_center_approach_enemies[ level.jungle_village_center_approach_enemies.size ] = agent;
        }
    }
    
    if ( utility::cointoss() )
    {
        agent.grenadeammo = 0;
    }
}

// Namespace namespace_1146e44035fa967c
// Params 3
// Checksum 0xc7ce9551, Offset: 0x1c03
// Size: 0xec
function function_9cdcafab0df8975d( requestid, userdata, vehicle )
{
    vehicle endon( #"death" );
    level childthread leo_audio::function_6a9b8b35cfb04c6e( vehicle );
    vehicle_occupancy::set_team( vehicle, "team_hundred_ninety" );
    vehicle_interact::allow_use( vehicle, 0 );
    vehicle utility::waittill_any_timeout( 8, "goal", "near_goal", "path_blocked" );
    vehicle function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( 0 ) );
    vehicle vehicle_setspeedimmediate( 0, 1, 1 );
    vehicle vehicle_cleardrivingstate();
    
    if ( vehicle hascomponent( "p2p" ) )
    {
        vehicle removecomponent( "p2p" );
    }
    
    if ( vehicle hascomponent( "path" ) )
    {
        vehicle removecomponent( "path" );
    }
    
    if ( vehicle hascomponent( "animator" ) )
    {
        vehicle removecomponent( "animator" );
    }
    
    vehicle vehphys_parkingbrake( 1 );
}

// Namespace namespace_1146e44035fa967c
// Params 4
// Checksum 0xcaaa34a2, Offset: 0x1cf7
// Size: 0x153
function function_91180689c832047b( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    level.jungle_village_hill_top_enemies[ level.jungle_village_hill_top_enemies.size ] = agent;
    level.jungle_village_enemies[ level.jungle_village_enemies.size ] = agent;
    players = ob_story_mission_utils::get_playing_players();
    closest_player = function_47c86977a18df38b( players, agent.origin );
    agent getenemyinfo( closest_player );
    agent forcethreatupdate();
    agent function_fa32376aaa88a7a2( closest_player.origin, 10000 );
    agent function_2ef9eb3349906d00( 5000 );
    
    if ( utility::cointoss() )
    {
        agent.grenadeammo = 0;
    }
    
    level utility::flag_wait( "flag_jungle_village_hill_enc_retreat" );
    wait 1;
    
    if ( isdefined( data.script_noteworthy ) )
    {
        if ( data.script_noteworthy == "jungle_hill_machete_tutorial_enemy" )
        {
            level utility::flag_wait( "flag_scene_menendez_sighting_02_start_exit" );
            
            if ( !level utility::flag( "flag_jungle_village_hill_top_reinforcements" ) )
            {
                agent thread ai_retreat( "jungle_village_hill_top_vol" );
            }
            else
            {
                agent thread ai_retreat( "jungle_village_hill_top_reinforcements_vol" );
            }
        }
        
        return;
    }
    
    agent thread ai_retreat( "jungle_village_hill_top_vol" );
}

// Namespace namespace_1146e44035fa967c
// Params 3
// Checksum 0x565930d, Offset: 0x1e52
// Size: 0x2b
function function_14f13e4f2fadfd94( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_jungle_center_approach_enemies_spawned" );
}

// Namespace namespace_1146e44035fa967c
// Params 3
// Checksum 0xf2f10854, Offset: 0x1e85
// Size: 0x53
function function_26dfc8cbb9d40e06( requestid, activity_instance, agent )
{
    level.jungle_village_enemies = utility::array_removedead_or_dying( level.jungle_village_enemies );
    
    if ( level.jungle_village_enemies.size < 4 )
    {
        level utility::flag_set( "flag_jungle_village_center_enc_spawn" );
    }
}

// Namespace namespace_1146e44035fa967c
// Params 3
// Checksum 0x30954523, Offset: 0x1ee0
// Size: 0x31, Type: bool
function function_efa4bff329d83144( requestid, userdata, wavenumber )
{
    if ( level utility::flag( "flag_jungle_village_center_approach_enc_retreat" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_1146e44035fa967c
// Params 1
// Checksum 0x9a558548, Offset: 0x1f1a
// Size: 0xdb
function ai_retreat( var_1d700db5b7348742 )
{
    self endon( #"death" );
    self endon( #"hash_7f736a7206eacbbc" );
    vol = getnoentvolumearray( var_1d700db5b7348742, #targetname )[ 0 ];
    
    if ( !isdefined( vol ) )
    {
        return;
    }
    
    wait randomfloatrange( 0.5, 1 );
    
    if ( utility::cointoss() )
    {
        val::set( "retreat", "ignoreall", 1 );
    }
    
    if ( utility::cointoss() )
    {
        self.sprint = 1;
        utility::demeanor_override( "sprint" );
    }
    
    self setgoalvolumeauto( vol );
    
    if ( val::get( "ignoreall" ) )
    {
        utility::waittill_notify_or_timeout( "goal", 5 );
        val::reset_all( "retreat" );
    }
    
    if ( isdefined( self.sprint ) )
    {
        utility::clear_demeanor_override();
    }
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0x8b6b80b, Offset: 0x1ffd
// Size: 0x22f
function jungle_village_vehicle_1()
{
    startnode = getvehiclenode( "jungle_village_vehicle_1_start", "targetname" );
    
    if ( !isdefined( startnode ) )
    {
        return;
    }
    
    spawndata = spawnstruct();
    spawndata.origin = startnode.origin;
    spawndata.angles = startnode.angles;
    spawndata.initai = 1;
    spawndata vehicle_spawn::prevent_respawn();
    vehicle = vehicle::spawn( %"hash_56311b5cc8c94835", spawndata );
    waitframe();
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle_occupancy::set_team( vehicle, "team_hundred_ninety" );
    vehicle_interact::allow_use( vehicle, 0 );
    vehicle vehicle_paths::function_53e592e2d38c05ca( 0, 1, 1, 1, 30 );
    endnode = getvehiclenode( "jungle_village_vehicle_1_end", "targetname" );
    
    if ( isdefined( endnode ) )
    {
        vehicle function_eb88c4e66edbc855( "p2p", "goalPoint", endnode.origin );
    }
    
    vehicle vehicle_paths::vehicle_init_path_radiant( 50 );
    vehicle thread vehicle::attach_vehicle_and_gopath( startnode );
    vehicle vehicle_turnengineon();
    agent_1 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_soldier_long", ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hundred_ninety" );
    
    if ( isdefined( agent_1 ) )
    {
        agent_1.script_startingposition = 0;
        vehicle thread vehicle_aianim::guy_enter( agent_1 );
        level.jungle_village_enemies[ level.jungle_village_enemies.size ] = agent_1;
    }
    
    vehicle endon( #"death" );
    vehicle utility::waittill_any_timeout( 8, "goal", "near_goal", "path_blocked" );
    vehicle function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( 0 ) );
    vehicle vehicle_setspeedimmediate( 0, 1, 1 );
    vehicle vehicle_cleardrivingstate();
    
    if ( vehicle hascomponent( "p2p" ) )
    {
        vehicle removecomponent( "p2p" );
    }
    
    if ( vehicle hascomponent( "path" ) )
    {
        vehicle removecomponent( "path" );
    }
    
    if ( vehicle hascomponent( "animator" ) )
    {
        vehicle removecomponent( "animator" );
    }
    
    vehicle vehphys_parkingbrake( 1 );
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0x750cc18b, Offset: 0x2234
// Size: 0x301
function jungle_village_vehicle_2()
{
    startnode = getvehiclenode( "jungle_village_vehicle_2_start", "targetname" );
    
    if ( !isdefined( startnode ) )
    {
        return;
    }
    
    spawndata = spawnstruct();
    spawndata.origin = startnode.origin;
    spawndata.angles = startnode.angles;
    spawndata.initai = 1;
    spawndata vehicle_spawn::prevent_respawn();
    vehicle = vehicle::spawn( %"hash_532658b12d3530d5", spawndata );
    waitframe();
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle_occupancy::set_team( vehicle, "team_hundred_ninety" );
    vehicle_interact::allow_use( vehicle, 0 );
    vehicle vehicle_paths::function_53e592e2d38c05ca( 0, 1, 1, 1, 30 );
    endnode = getvehiclenode( "jungle_village_vehicle_2_end", "targetname" );
    
    if ( isdefined( endnode ) )
    {
        vehicle function_eb88c4e66edbc855( "p2p", "goalPoint", endnode.origin );
    }
    
    vehicle vehicle_paths::vehicle_init_path_radiant( 50 );
    vehicle thread vehicle::attach_vehicle_and_gopath( startnode );
    vehicle vehicle_turnengineon();
    agent_1 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_soldier_long", ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hundred_ninety" );
    
    if ( isdefined( agent_1 ) )
    {
        agent_1.script_startingposition = 0;
        vehicle thread vehicle_aianim::guy_enter( agent_1 );
        level.jungle_village_enemies[ level.jungle_village_enemies.size ] = agent_1;
    }
    
    agent_2 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_soldier_long", ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hundred_ninety" );
    
    if ( isdefined( agent_2 ) )
    {
        agent_2.script_startingposition = 2;
        vehicle thread vehicle_aianim::guy_enter( agent_2 );
        level.jungle_village_enemies[ level.jungle_village_enemies.size ] = agent_2;
    }
    
    agent_3 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_soldier_long", ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hundred_ninety" );
    
    if ( isdefined( agent_3 ) )
    {
        agent_3.script_startingposition = 3;
        vehicle thread vehicle_aianim::guy_enter( agent_3 );
        level.jungle_village_enemies[ level.jungle_village_enemies.size ] = agent_3;
    }
    
    vehicle endon( #"death" );
    vehicle utility::waittill_any_timeout( 8, "goal", "near_goal", "path_blocked" );
    vehicle function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( 0 ) );
    vehicle vehicle_setspeedimmediate( 0, 1, 1 );
    vehicle vehicle_cleardrivingstate();
    
    if ( vehicle hascomponent( "p2p" ) )
    {
        vehicle removecomponent( "p2p" );
    }
    
    if ( vehicle hascomponent( "path" ) )
    {
        vehicle removecomponent( "path" );
    }
    
    if ( vehicle hascomponent( "animator" ) )
    {
        vehicle removecomponent( "animator" );
    }
    
    vehicle vehphys_parkingbrake( 1 );
}

// Namespace namespace_1146e44035fa967c
// Params 0
// Checksum 0xd40ec30f, Offset: 0x253d
// Size: 0xb3
function jungle_village_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( %"hash_4194f104fb0af16c" );
    level utility::flag_wait( "flag_jungle_hill_enemies_spawned" );
    ob_story_mission_utils::objective_text_show( %"hash_60a27c7d47197c69" );
    level utility::flag_wait( "jungle_village_combat_done" );
    ob_story_mission_utils::objective_text_show( %"hash_4194f104fb0af16c" );
    level utility::flag_wait( "jungle_village_combat_done" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "jungle_village_obj_marker_end", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level utility::flag_wait( "mansion_courtyard_gate_interacted" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( "jungle_village_obj_marker_end" );
}

