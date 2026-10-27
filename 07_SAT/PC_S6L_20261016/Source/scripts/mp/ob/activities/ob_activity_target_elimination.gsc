// scripts\mp\ob\activities\ob_activity_target_elimination.gsc  (hash_0ae8e3adee2ac61d.gscc) (size: 6956 Bytes / 0x1b2c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x94ccf1b9 (2496459193)
// size ...... 6956 (0x1b2c)
// includes .. 16  (offset: 0x1a10)
// strings ... 11  (offset: 0x1a90)
// dev strs .. 0   (offset: 0x1b2c)
// exports ... 23  (offset: 0xe74)
// cseg ...... 0x1c2 + 0xcb2 (0xe74)
// imports ... 71  (offset: 0x120c)
// animtree1 . 0   (offset: 0x1b2c)
// animtree2 . 0   (offset: 0x1b2c)
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_target_elimination;

// Namespace ob_activity_target_elimination
// Params 0, eflags: 0x5
// Checksum 0xac19f972, Offset: 0x1e0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_target_elimination", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_target_elimination
// Params 0, eflags: 0x4
// Checksum 0xb989383d, Offset: 0x209
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_TARGET_ELIMINATION", &activity_type_init );
}

// Namespace ob_activity_target_elimination
// Params 0
// Checksum 0x82ede878, Offset: 0x224
// Size: 0x9b
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_TARGET_ELIMINATION", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_TARGET_ELIMINATION", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_TARGET_ELIMINATION", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_TARGET_ELIMINATION", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_TARGET_ELIMINATION" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_TARGET_ELIMINATION" );
    namespace_9085ae059032a84f::function_74af1ab4059e3c06( "sat_ob_activitydef_target_elimination", "activity_target_elimination" );
    scriptable::scriptable_addusedcallbackbypart( "drone_wreckage_interaction", &function_82418bfaf1fb9bd0 );
}

// Namespace ob_activity_target_elimination
// Params 0
// Checksum 0x613be3d, Offset: 0x2c7
// Size: 0x1f6
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    extra_spawn_data = activity_instance_common::function_a45920af4495e9f( activity_instance );
    assert( extra_spawn_data.participants );
    assert( extra_spawn_data.startorigin );
    assert( extra_spawn_data.startangles );
    extra_spawn_data.participants = function_5713d46873b29625( extra_spawn_data.participants );
    drone_wreckage = activity_instance ob_resource_manager::activity_spawn_entity( "script_model", extra_spawn_data.startorigin );
    drone_wreckage.angles = extra_spawn_data.startangles;
    drone_wreckage setmodel( %"veh_sat_mil_air_drone_dart_leader_guild_wreckage" );
    drone_wreckage setscriptablepartstate( #"hash_582358aca69bc1db", #"on" );
    drone_wreckage setscriptablepartstate( #"drone_wreckage_interaction", #"scan_ready" );
    drone_wreckage.is_drone_hunt_wreckage = 1;
    drone_wreckage.original_participants = extra_spawn_data.participants;
    drone_wreckage.activity_instance = activity_instance;
    var_85378483ba2a135e = drone_wreckage getlinkedscriptableinstance();
    
    if ( var_85378483ba2a135e.index )
    {
        foreach ( var_c31894e7ad5a341e in extra_spawn_data.participants )
        {
            var_c31894e7ad5a341e calloutmarkerping::function_920a63c06abdefe8( var_85378483ba2a135e.index );
        }
    }
    
    activity_instance.drone_wreckage = drone_wreckage;
    activity_instance thread function_e3bda3c419f2d5e8();
}

// Namespace ob_activity_target_elimination
// Params 0, eflags: 0x4
// Checksum 0xd5c76be2, Offset: 0x4c5
// Size: 0xaa
function private function_e3bda3c419f2d5e8()
{
    activity_instance = self;
    activity_instance endon( #"activity_started" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"hash_cca35cfdfc8dc9fd" );
    time_out_duration = 60;
    wait time_out_duration;
    
    if ( activity_instance.drone_wreckage )
    {
        activity_instance.drone_wreckage setscriptablepartstate( #"drone_wreckage_interaction", #"off" );
        activity_instance.drone_wreckage setscriptablepartstate( #"exit", #"final_explode" );
        wait 0.75;
    }
    
    level thread activity_instance_common::function_9aeeabe50fc9cc3e( activity_instance );
}

// Namespace ob_activity_target_elimination
// Params 0, eflags: 0x4
// Checksum 0x7383894a, Offset: 0x577
// Size: 0x41
function private function_b75f055c28a79513()
{
    activity_instance = self;
    
    if ( activity_instance.drone_wreckage )
    {
        activity_instance ob_resource_manager::function_360d7e0860217cf4( activity_instance.drone_wreckage );
        activity_instance.drone_wreckage delete();
    }
}

// Namespace ob_activity_target_elimination
// Params 6, eflags: 0x4
// Checksum 0x8a7ea5f6, Offset: 0x5c0
// Size: 0xcf
function private function_82418bfaf1fb9bd0( scriptable, part, state, player, bautouse, usestring )
{
    drone_wreckage = scriptable.entity;
    
    if ( !drone_wreckage.is_drone_hunt_wreckage || !arraycontains( drone_wreckage.original_participants, player ) )
    {
        return;
    }
    
    var_9d5ed185ab6bf99a = isplayer( player ) && isalive( player ) && !player.inlaststand && !player isreloading() && ( !player isgestureplaying() || player isswimming() );
    
    if ( var_9d5ed185ab6bf99a )
    {
        scriptable thread function_78b512ef6c612117( player );
    }
}

// Namespace ob_activity_target_elimination
// Params 1, eflags: 0x4
// Checksum 0xf4cdea1b, Offset: 0x697
// Size: 0x10d
function private function_78b512ef6c612117( player )
{
    scriptable = self;
    drone_wreckage = scriptable.entity;
    
    if ( !player || !drone_wreckage )
    {
        return;
    }
    
    player endon( #"disconnect" );
    scriptable disablescriptableplayeruse( player );
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 3, undefined, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( var_fab006cdb4f6e516 )
    {
        if ( drone_wreckage.activity_instance )
        {
            drone_wreckage.activity_instance notify( #"hash_cca35cfdfc8dc9fd" );
            drone_wreckage.activity_instance thread function_e98c6dfc711ebbe5();
            
            if ( false )
            {
                drone_wreckage.activity_instance.spawn_reinforcements_origin = player.origin + vectornormalize2( anglestoforward( player.angles ) ) * 3000;
            }
            
            activity_instance_common::function_46135a69bddfec2c( drone_wreckage.activity_instance );
        }
        
        return;
    }
    
    scriptable enablescriptableplayeruse( player );
}

// Namespace ob_activity_target_elimination
// Params 0, eflags: 0xc
// Checksum 0xcf028c93, Offset: 0x7ac
// Size: 0x7a
function private function_e98c6dfc711ebbe5()
{
    self notify( #"hash_64589ec5aa9525e4" );
    self endon( #"hash_64589ec5aa9525e4" );
    activity_instance = self;
    activity_instance.drone_wreckage setscriptablepartstate( #"exit", #"final_explode" );
    activity_instance.drone_wreckage setscriptablepartstate( #"drone_wreckage_interaction", #"off" );
    wait 0.75;
    activity_instance function_b75f055c28a79513();
}

// Namespace ob_activity_target_elimination
// Params 0
// Checksum 0xa694e9d3, Offset: 0x82e
// Size: 0x154
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    extra_spawn_data = activity_instance_common::function_a45920af4495e9f( activity_instance );
    assert( extra_spawn_data.participants );
    extra_spawn_data.participants = function_5713d46873b29625( extra_spawn_data.participants );
    activity_participation::function_fb0ec90aaf6d4c61( activity_instance, extra_spawn_data.participants );
    custom_properties = namespace_9085ae059032a84f::function_9129cd8075c85c09( activity_instance );
    targets_encounter_bundle = hashcat( %"ai_encounter:", custom_properties.aiencounter );
    targets_encounter_origin = activity_instance.spawn_reinforcements_origin ? activity_instance.spawn_reinforcements_origin : activity_instance_common::function_776ee11e7acc64a5( activity_instance );
    targets_encounter_radius = 2000;
    activity_instance.var_fe16d208e45470d6 = activity_ai_encounters::function_eb8506829193f5eb( targets_encounter_bundle, targets_encounter_origin, targets_encounter_radius, 1, 0, 0, 0 );
    activity_instance.enemies = [];
    activity_instance.var_6e8150083c0db71d = 1;
    ai_spawn_director::add_spawned_callback( activity_instance.var_fe16d208e45470d6, &function_6e7a030d284aa46f, activity_instance );
    ai_spawn_director::function_5a08798970350207( activity_instance.var_fe16d208e45470d6, &on_finished_spawning, activity_instance );
}

// Namespace ob_activity_target_elimination
// Params 4, eflags: 0x4
// Checksum 0x7382a9a4, Offset: 0x98a
// Size: 0x3f
function private function_6e7a030d284aa46f( requestid, userdata, agent, data )
{
    activity_instance = userdata;
    agent thread manage_target_enemy( activity_instance );
}

// Namespace ob_activity_target_elimination
// Params 2, eflags: 0x4
// Checksum 0xa50e5862, Offset: 0x9d1
// Size: 0x74
function private on_finished_spawning( requestid, userdata )
{
    activity_instance = userdata;
    var_41f9287c4987add7 = function_9b649316adcccbaa( requestid );
    activity_instance.var_ce5b81a0c4d220ff = var_41f9287c4987add7.var_f05db2e05804484d;
    activity_instance namespace_4a69edc3725e741::function_f23bdcfc447427ae( activity_instance.playerparticipants, 0, activity_instance.enemies.size );
    activity_instance thread encounter_watcher();
}

// Namespace ob_activity_target_elimination
// Params 1, eflags: 0x4
// Checksum 0xecf1430c, Offset: 0xa4d
// Size: 0xb2
function private manage_target_enemy( activity_instance )
{
    agent = self;
    activity_instance.enemies[ activity_instance.enemies.size ] = agent;
    target_marker_id = activity_instance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_target_elimination", 0, 0 );
    objective_removeallfrommask( target_marker_id );
    namespace_d7fa4530141146a5::function_7c5730b9151d91( activity_instance.playerparticipants, target_marker_id );
    objidpoolmanager::update_objective_onentity( target_marker_id, agent );
    objidpoolmanager::update_objective_description( target_marker_id, &"sat_ob_activities/objective_target_elimination" );
    agent callback::add( #"on_ai_killed", &on_target_killed, { #target_marker_id:target_marker_id, #activity_instance:activity_instance } );
}

// Namespace ob_activity_target_elimination
// Params 2, eflags: 0x4
// Checksum 0x4b751527, Offset: 0xb07
// Size: 0xc8
function private on_target_killed( params, var_c1fa5c1e922e62d6 )
{
    agent = self;
    activity_instance = var_c1fa5c1e922e62d6.activity_instance;
    
    if ( agent.death_source == "despawn" )
    {
        activity_instance.var_6e8150083c0db71d = 0;
    }
    
    activity_instance thread namespace_d7fa4530141146a5::function_501e44ea1cb9219d( var_c1fa5c1e922e62d6.target_marker_id );
    
    if ( activity_instance.enemies.size == 1 && activity_instance.enemies[ 0 ] == agent && activity_instance.var_6e8150083c0db71d )
    {
        agent function_398a4aa1ed16f280( activity_instance );
    }
    
    activity_instance.enemies = arrayremove( activity_instance.enemies, agent );
}

// Namespace ob_activity_target_elimination
// Params 1, eflags: 0x4
// Checksum 0x4afcef99, Offset: 0xbd7
// Size: 0xc8
function private function_398a4aa1ed16f280( activity_instance )
{
    agent = self;
    var_a376fd5283f69590 = 0;
    
    switch ( activity_instance.difficulty_region )
    {
        case #"hash_7bb2cd766703d463":
            var_a376fd5283f69590 = 1;
            break;
        case #"hash_af83e47edfa8900a":
            var_a376fd5283f69590 = 2;
            break;
        case #"hash_5343b465e56ec9a4":
            var_a376fd5283f69590 = 3;
            break;
        case #"hash_651f76c0ad6741ec":
        default:
            var_a376fd5283f69590 = 4;
            break;
    }
    
    loot_spawn_list = hashcat( %"hash_2778497b79ce2a03", var_a376fd5283f69590 );
    spawn_options = common_item::items_initspawnoptions_spawnfromentity( agent );
    level common_item::function_38cde6a6acb68ea6( loot_spawn_list, 1, spawn_options );
}

// Namespace ob_activity_target_elimination
// Params 0, eflags: 0x4
// Checksum 0x9eed72df, Offset: 0xca7
// Size: 0xdc
function private encounter_watcher()
{
    activity_instance = self;
    level endon( #"game_ended" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    cached_enemy_count = activity_instance.var_ce5b81a0c4d220ff;
    
    while ( true )
    {
        if ( cached_enemy_count != activity_instance.enemies.size )
        {
            namespace_9085ae059032a84f::updateprogress( activity_instance.var_ce5b81a0c4d220ff - activity_instance.enemies.size, activity_instance, activity_instance.var_ce5b81a0c4d220ff );
            cached_enemy_count = activity_instance.enemies.size;
        }
        
        if ( activity_instance.enemies.size == 0 && activity_instance.playerparticipants.size > 0 )
        {
            waitframe();
            activity_instance_common::endactivity( activity_instance, activity_instance.var_6e8150083c0db71d );
        }
        
        wait 0.5;
    }
}

// Namespace ob_activity_target_elimination
// Params 1
// Checksum 0x41d833e0, Offset: 0xd8b
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace ob_activity_target_elimination
// Params 0
// Checksum 0xb9d1491e, Offset: 0xdb9
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance function_b75f055c28a79513();
}

// Namespace ob_activity_target_elimination
// Params 0
// Checksum 0x962dc0a1, Offset: 0xde6
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace ob_activity_target_elimination
// Params 1
// Checksum 0xda00d0b, Offset: 0xdfe
// Size: 0x4e
function function_470b4f0cecef4cf4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace ob_activity_target_elimination
// Params 1
// Checksum 0x6c609c05, Offset: 0xe54
// Size: 0xc
function player_joined_activity( relevant_info_struct )
{
    
}

// Namespace ob_activity_target_elimination
// Params 1
// Checksum 0x95b4d541, Offset: 0xe68
// Size: 0xc
function player_left_activity( relevant_info_struct )
{
    
}

