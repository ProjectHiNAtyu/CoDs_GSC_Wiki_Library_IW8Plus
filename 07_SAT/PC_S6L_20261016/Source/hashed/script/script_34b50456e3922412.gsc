// script_34b50456e3922412  (hash_34b50456e3922412.gscc) (size: 123583 Bytes / 0x1e2bf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72516cf9 (1917938937)
// size ...... 123583 (0x1e2bf)
// includes .. 61  (offset: 0x1c533)
// strings ... 395 (offset: 0x1c71b)
// dev strs .. 30  (offset: 0x1e14b)
// exports ... 264 (offset: 0x145f3)
// cseg ...... 0x23d0 + 0x12223 (0x145f3)
// imports ... 611 (offset: 0x16f33)
// animtree1 . 0   (offset: 0x1e2bf)
// animtree2 . 0   (offset: 0x1e2bf)
#using script_16ea1b94f0f381b3;
#using script_2399696a9d953451;
#using script_3016732d4c7eef02;
#using script_3455b106458253e7;
#using script_3ec57c71b0b61f00;
#using script_61b40095fd0502f0;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using script_6e05fdc2c6f5fa06;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\gasmask;
#using scripts\common\hud_util;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\snd\snd;
#using scripts\common\trace;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\visibility_mode;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\common\equipment\mini_sentry;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\killstreaks\hellstorm_missile;
#using scripts\mp\common\killstreaks\remote_robot;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\common\killstreaks\vtol_warship;
#using scripts\mp\common\supers\drone_launcher;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\coop;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\juggernaut;
#using scripts\mp\laststand;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_weakpoint;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\activities\ob_activity_gunship_heli;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_cradle_gas_circle;
#using scripts\mp\ob\systems\weapons\ob_damage;
#using scripts\mp\overlord;
#using scripts\mp\supers;

#namespace ob_nm_mode;

// Namespace ob_nm_mode
// Params 7
// Checksum 0x795c013e, Offset: 0x23ee
// Size: 0x3c1
function function_44bcd5233c8a155d( var_15991fe2fe594f5b, circle_struct_array, encounter_array, var_a0f4370f0aa57f19, radius = 400, random_faction = 0, objective_asset )
{
    start_of_round_fanfare( "nm_overlord_br_start", "nm_wave_start" );
    var_fcb964ac6f23a112 = utility::getstruct( var_15991fe2fe594f5b, "targetname" );
    obj = objective_asset ?? %"hash_534dd2659adb451b";
    ob_story_mission_utils::objective_text_show( obj );
    start_circle_move_time = 10;
    level utility::flag_set( "flag_killcount_event" );
    var_9a7b20e173174021 = 4096;
    circle = function_21689e5c8bddd87c( var_fcb964ac6f23a112.origin, var_9a7b20e173174021 );
    circle brcirclemoveto( var_fcb964ac6f23a112.origin[ 0 ], var_fcb964ac6f23a112.origin[ 1 ], radius, start_circle_move_time );
    level thread update_minimap_circle( circle, var_fcb964ac6f23a112.origin, var_fcb964ac6f23a112.origin, var_9a7b20e173174021, radius, start_circle_move_time );
    wait start_circle_move_time;
    current_struct = var_fcb964ac6f23a112;
    time_modifier = function_3fc7f1f10018b737( 360 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread wave_fail_timer( time_modifier );
    level.minions_killed = 0;
    level.var_9a7facf0cbad27fd = &function_51ac155be471a4fb;
    
    for ( i = 0; i < circle_struct_array.size ; i++ )
    {
        if ( i != 0 )
        {
            nightmare_splash( "nm_circle_moving" );
        }
        
        level thread function_70467d6be224da52( "nm_overlord_br_moving" );
        next_struct = utility::getstruct( circle_struct_array[ i ], "targetname" );
        level.nm_respawn_struct = next_struct;
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( next_struct.origin, 96 );
        wait 5;
        circle brcirclemoveto( next_struct.origin[ 0 ], next_struct.origin[ 1 ], radius, var_a0f4370f0aa57f19[ i ] );
        level thread update_minimap_circle( circle, current_struct.origin, next_struct.origin, radius, radius, var_a0f4370f0aa57f19[ i ] );
        wait var_a0f4370f0aa57f19[ i ];
        current_struct = next_struct;
        thread minion_encounter( encounter_array[ i ], "flag_circle_event_done_" + i, random_faction, 3 );
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( level.minions_killed, level.minion_kill_obj );
        chunk = level.minion_kill_obj / circle_struct_array.size;
        
        while ( level.minions_killed < ( i + 1 ) * chunk )
        {
            waitframe();
        }
        
        level notify( #"hash_f8318a5d48451de5" );
        level utility::flag_set( "flag_circle_event_done_" + i );
        ob_story_mission_utils::mission_objective_marker_clear( obj_id );
        
        if ( isdefined( level.cadence_override ) )
        {
            level.cadence_override -= 0.5;
            level.cadence_override = clamp( level.cadence_override, 0.5, 4 );
            
            if ( isdefined( level.var_c48036a3bf28dd4f ) )
            {
                function_a748fd0f51127844( level.var_c48036a3bf28dd4f, level.cadence_override );
            }
        }
        
        wait 0.5;
    }
    
    level notify( #"hash_aefc5c470125baf8" );
    level utility::flag_clear( "flag_killcount_event" );
    level.minions_killed = 0;
    level thread function_70467d6be224da52( "nm_overlord_br_complete" );
    level notify( #"stop_circle" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
    
    level.nm_respawn_struct = circle_struct_array[ 0 ];
    end_of_round_fanfare( undefined, "nm_wave_complete" );
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x1ef3b885, Offset: 0x27b7
// Size: 0xb0
function function_51ac155be471a4fb( spectatedplayer, locationoverride )
{
    if ( !isdefined( level.nm_respawn_struct ) )
    {
        location = level.nm_activity_name;
        struct = ob_story_mission_utils::get_activity_starts( location )[ 0 ];
        return struct;
    }
    
    var_f0bb93d443737388 = utility::randomvectorrange( 32, 64 );
    struct = spawnstruct();
    struct.origin = getclosestpointonnavmesh( level.nm_respawn_struct.origin + var_f0bb93d443737388 );
    struct.angles = level.nm_respawn_struct.angles;
    return struct;
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x43ae9fa9, Offset: 0x2870
// Size: 0x194
function function_853f99319605fdf8( encounter_name, objective_asset, random_faction )
{
    start_of_round_fanfare( "nm_overlord_br_start", "nm_wave_threat_start" );
    obj = objective_asset ?? %"hash_534dd2659adb451b";
    ob_story_mission_utils::objective_text_show( obj );
    level utility::flag_set( "flag_killcount_event" );
    level utility::flag_clear( "flag_killcount_event_done" );
    time_modifier = function_3fc7f1f10018b737( 360 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread wave_fail_timer( time_modifier );
    level.minions_killed = 0;
    thread minion_encounter( encounter_name, "flag_killcount_event_done", random_faction );
    
    if ( level.minion_kill_obj <= 100 )
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( level.minions_killed, level.minion_kill_obj );
    }
    else
    {
        fraction = level.minions_killed / level.minion_kill_obj;
        percent = int( fraction * 100 );
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( percent, 100 );
    }
    
    while ( level.minions_killed < level.minion_kill_obj )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_killcount_event_done" );
    level notify( #"hash_aefc5c470125baf8" );
    level utility::flag_clear( "flag_killcount_event" );
    level.minions_killed = 0;
    level thread function_70467d6be224da52( "nm_overlord_br_complete" );
    level notify( #"stop_circle" );
    end_of_round_fanfare( undefined, "nm_wave_threat_end" );
}

// Namespace ob_nm_mode
// Params 5
// Checksum 0x29cc761e, Offset: 0x2a0c
// Size: 0x27c
function function_cec6aa1de224526d( var_15991fe2fe594f5b, encounter_array, carepackage_array, timer_array, random_faction = 0 )
{
    start_of_round_fanfare( undefined, "nm_wave_start" );
    level utility::flag_set( "flag_killcount_event" );
    level utility::flag_clear( "flag_defend_done" );
    level.var_39dbf9e22fa482f4 = 0;
    level.minions_killed = 0;
    radius = 1200;
    start_circle_move_time = 30;
    var_9a7b20e173174021 = 4096;
    var_fcb964ac6f23a112 = utility::getstruct( var_15991fe2fe594f5b, "targetname" );
    circle = function_21689e5c8bddd87c( var_fcb964ac6f23a112.origin, var_9a7b20e173174021 );
    circle brcirclemoveto( var_fcb964ac6f23a112.origin[ 0 ], var_fcb964ac6f23a112.origin[ 1 ], radius, start_circle_move_time );
    level thread update_minimap_circle( circle, var_fcb964ac6f23a112.origin, var_fcb964ac6f23a112.origin, var_9a7b20e173174021, radius, start_circle_move_time );
    ob_story_mission_utils::objective_text_show( %"hash_534dd2659adb451b" );
    time_modifier = function_3fc7f1f10018b737( 360 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    
    for ( i = 0; i < encounter_array.size ; i++ )
    {
        level.var_39dbf9e22fa482f4++;
        function_dcb13f1f16265933( carepackage_array[ i ] );
        wait 3;
        level utility::flag_set( "flag_defend_event_start_" + i );
        thread minion_encounter( encounter_array[ i ], "flag_defend_event_done_" + i, random_faction );
        wave_killcount = level.minion_kill_obj / encounter_array.size;
        var_ed71689621a5bcd2 = ( i + 1 ) * wave_killcount;
        level thread defend_toma_strikes( wave_killcount, var_ed71689621a5bcd2 );
        
        while ( level.minions_killed < var_ed71689621a5bcd2 )
        {
            waitframe();
        }
        
        level notify( #"hash_f8318a5d48451de5" );
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 3, undefined, level.players, undefined, undefined, 1 );
        level utility::flag_set( "flag_defend_event_done_" + i );
    }
    
    level notify( #"stop_circle" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
    
    level utility::flag_clear( "flag_killcount_event" );
    level.minions_killed = 0;
    level utility::flag_set( "flag_defend_done" );
    end_of_round_fanfare( undefined, "nm_wave_complete" );
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x7745fee6, Offset: 0x2c90
// Size: 0x181
function function_dcb13f1f16265933( var_dc6a4b4b351da087, spawn_items = [ %"hash_483c1904e1e455b" ] )
{
    if ( level.var_39dbf9e22fa482f4 == 1 )
    {
        spawn_items = [ %"hash_35298bd2d2aff71f" ];
    }
    else if ( level.var_39dbf9e22fa482f4 == 2 )
    {
        spawn_items = [ %"itemspawnentry:ob_sat_item_semtex" ];
    }
    else if ( level.var_39dbf9e22fa482f4 == 3 )
    {
        spawn_items = [ %"hash_483c1904e1e455b" ];
    }
    
    struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    player = level.players[ 0 ];
    spawn_point = struct.origin + ( 0, 0, 1000 );
    crate = ob_story_mission_utils::function_53ca684fc4aa8af3( player, spawn_point, spawn_items, 1, 0, 1 );
    crate hudoutlineenable( "outline_depth_purple" );
    
    foreach ( player in level.players )
    {
        level thread utility::play_sound_in_space( "mp_arms_new_objective", player.origin );
    }
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0xd5718ee6, Offset: 0x2e19
// Size: 0x47
function defend_toma_strikes( wave_killcount, var_ed71689621a5bcd2 )
{
    var_45bb2f08f1b91e7f = var_ed71689621a5bcd2 - 0.5 * wave_killcount;
    
    while ( level.minions_killed < var_45bb2f08f1b91e7f )
    {
        waitframe();
    }
    
    level thread function_e68ea7f6b97ccd83();
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xd655f4f9, Offset: 0x2e68
// Size: 0x55
function init_lasers()
{
    utility::add_fx( "laser", "vfx_sat_strk_dawg_turret_laser" );
    var_d05dd0d284363b58 = utility::getstructarray( "struct_laser_trap", "targetname" );
    
    for ( i = 0; i < var_d05dd0d284363b58.size ; i++ )
    {
        level thread laser_trap( var_d05dd0d284363b58[ i ] );
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xfd3b678d, Offset: 0x2ec5
// Size: 0xbb
function laser_trap( start_struct )
{
    var_fe41cd39c047e1b9 = utility::getstruct( start_struct.target, "targetname" );
    angles = vectortoangles( var_fe41cd39c047e1b9.origin - start_struct.origin );
    tag = utility::function_1808878d1c511ce8( start_struct.origin, angles );
    playfxontag( level._effect[ "laser" ], tag, "tag_origin" );
    level waittill( #"stop_lasers" );
    stopfxontag( level._effect[ "laser" ], tag, "tag_origin" );
    waitframe();
    tag delete();
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0x52063b2f, Offset: 0x2f88
// Size: 0x218
function function_332a6bdf2c77969f( var_1b8989732c9773af, encounter_name, random_faction = 0, objective_asset )
{
    start_of_round_fanfare( "nm_overlord_shard_start", "nm_shard_start" );
    obj = objective_asset ?? %"hash_1249e3216f40d87d";
    ob_story_mission_utils::objective_text_show( obj );
    waitframe();
    ob_story_mission_utils::objective_timer_update( 300 );
    level thread wave_fail_timer( 300 );
    utility::add_fx( "shard_vfx", "vfx_sat_wc_gameplay_nightmare_shards_01" );
    utility::add_fx( "score_vfx", "vfx_sat_zm_weapons_fireworks_burst_ch_yellow" );
    utility::add_fx( "deposit_zone", "vfx_sat_zm_weapons_fireworks_fire_wheel_yellow" );
    utility::add_fx( "deposit_beam", "vfx_sat_saw_avalon_cradle_warp_portal_sky_beam" );
    level.shard_event = 1;
    level.var_2e07a4798d97c706 = 0;
    level.shard_objective_count = 8 * level.players.size;
    level.var_99f5df355fd6eae7 = 0;
    level.shards_collected = 0;
    level utility::flag_set( "flag_shard_round" );
    thread dropoff_locations( var_1b8989732c9773af[ 0 ], var_1b8989732c9773af[ 1 ] );
    thread minion_encounter( encounter_name, "flag_shard_event_done", random_faction );
    ob_story_mission_utils::function_315d79883d962ba7( level.shards_collected, level.shard_objective_count );
    
    while ( level.shards_collected < level.shard_objective_count )
    {
        waitframe();
    }
    
    level notify( #"hash_aefc5c470125baf8" );
    level utility::flag_clear( "flag_shard_round" );
    level utility::flag_set( "flag_shard_event_done" );
    level notify( #"shard_event_done" );
    
    foreach ( player in level.players )
    {
        player notify( #"stop_shard_hint" );
    }
    
    end_of_round_fanfare( "nm_overlord_shard_end", "nm_shard_collected" );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x324a8090, Offset: 0x31a8
// Size: 0x1bf
function function_b0b090d62ab61c29( var_fcb964ac6f23a112 )
{
    while ( level.shards_collected < level.shard_objective_count * 0.5 )
    {
        waitframe();
    }
    
    structs = utility::getstructarray( "taurus_boss_01", "targetname" );
    spot = utility::array_random( structs );
    spawn_pos = getclosestpointonnavmesh( spot.origin );
    playfx( level._effect[ "enemy_vfx" ], spawn_pos );
    extra_dude = mp_agent::spawnnewagentaitype( "sat_ob_enemy_cradle_hvt_jugg_minigun", spawn_pos, spot.angles, "team_hundred_ninety" );
    extra_dude thread individual_vanish( "flag_shard_event_done" );
    
    while ( level.shards_collected < level.shard_objective_count * 0.75 )
    {
        waitframe();
    }
    
    radius = 1200;
    start_circle_move_time = 15;
    var_9a7b20e173174021 = 4096;
    center_struct = utility::getstruct( var_fcb964ac6f23a112, "targetname" );
    circle = function_21689e5c8bddd87c( center_struct.origin, var_9a7b20e173174021 );
    circle brcirclemoveto( center_struct.origin[ 0 ], center_struct.origin[ 1 ], radius, start_circle_move_time );
    level thread update_minimap_circle( circle, center_struct.origin, center_struct.origin, var_9a7b20e173174021, radius, start_circle_move_time );
    level utility::flag_wait( "flag_shard_event_done" );
    level notify( #"stop_circle" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xde13ebcf, Offset: 0x336f
// Size: 0xc7
function spawn_shard( origin )
{
    var_4b6319d4eaeb0942 = spawn( "script_model", origin + ( 0, 0, 32 ) );
    var_4b6319d4eaeb0942 endon( #"cleanup" );
    var_4b6319d4eaeb0942 setmodel( "tag_origin" );
    playfxontag( level._effect[ "shard_vfx" ], var_4b6319d4eaeb0942, "tag_origin" );
    var_4b6319d4eaeb0942.trigger = spawn( "trigger_radius", origin, 0, 64, 64 );
    level.var_2e07a4798d97c706++;
    var_4b6319d4eaeb0942.trigger function_ec05cf19fb86e1e5();
    
    if ( !isdefined( var_4b6319d4eaeb0942 ) )
    {
        return;
    }
    
    stopfxontag( level._effect[ "shard_vfx" ], var_4b6319d4eaeb0942, "tag_origin" );
    var_4b6319d4eaeb0942 delete();
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xcf7d4ba4, Offset: 0x343e
// Size: 0x5f, Type: bool
function should_spawn_shard( enemy )
{
    if ( level.var_2e07a4798d97c706 >= 20 )
    {
        return false;
    }
    
    type = "sniper";
    
    if ( isdefined( level.shard_spawner_type ) )
    {
        type = level.shard_spawner_type;
    }
    
    if ( !issubstr( enemy.classname, type ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0xee3e4b1c, Offset: 0x34a6
// Size: 0xa3
function dropoff_locations( var_953b22bfef7479fb, var_953b23bfef747c2e )
{
    thread player_dropoff( var_953b22bfef7479fb, "stop_dropoff_1" );
    
    while ( level.shards_collected < level.shard_objective_count )
    {
        waitframe();
    }
    
    level notify( #"stop_dropoff_1" );
    
    if ( isarray( level.var_3da29412e8cac16a ) )
    {
        for ( i = 0; i < level.var_3da29412e8cac16a.size ; i++ )
        {
            level.var_3da29412e8cac16a[ i ] setscriptablepartstate( "chevron", "off" );
        }
    }
    
    level notify( #"stop_all_dropoffs" );
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x9c6fda64, Offset: 0x3551
// Size: 0x2e6
function function_30533bd3780661e4( struct_location, end_notify = "stop_all_dropoffs" )
{
    level endon( end_notify );
    level.var_ecbb0be4b63f5774 = utility::getstruct( struct_location, "targetname" );
    
    foreach ( player in level.players )
    {
        if ( player.has_shard )
        {
            level.var_bd2748e149a8024b thread function_d73e018ec2d04bf3( player );
        }
    }
    
    level endon( #"shard_event_done" );
    radius = 128;
    struct = utility::getstruct( struct_location, "targetname" );
    trigger = spawn( "trigger_radius", struct.origin, 0, radius, radius );
    level.var_3da29412e8cac16a = [];
    num_chevrons = 16;
    segment_degrees = 360 / num_chevrons;
    level thread deposit_zone_fx( struct );
    level thread deposit_zone_beam( struct );
    
    for ( i = 0; i < num_chevrons ; i++ )
    {
        local_offset = anglestoforward( ( 0, segment_degrees * i, 0 ) ) * radius;
        
        if ( !isdefined( struct.angles ) )
        {
            struct.angles = ( 0, 0, 0 );
        }
        
        chevron_org = coordtransform( local_offset, struct.origin, struct.angles );
        chevron_ang = vectortoangles( chevron_org - struct.origin );
        level.var_3da29412e8cac16a[ i ] = spawnscriptable( "ob_sat_capture_zone_chevron_contestable", chevron_org, chevron_ang );
        level.var_3da29412e8cac16a[ i ] setscriptablepartstate( "chevron", "active_contested" );
    }
    
    while ( !level utility::flag( "flag_shard_event_done" ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            if ( ent.has_shard )
            {
                ent notify( #"stop_shard_hint" );
                ent.has_shard = 0;
                level.shards_collected++;
                level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 1, undefined, ent, undefined, undefined, 1 );
                level.var_bd2748e149a8024b ob_story_mission_utils::function_315d79883d962ba7( level.shards_collected, level.shard_objective_count );
                level thread utility::play_sound_in_space( "uin_sat_nightmare_shard_deposit", struct.origin );
                ent playrumbleonentity( "damage_heavy" );
            }
        }
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xe952fc5, Offset: 0x383f
// Size: 0x37
function weaken_boss()
{
    level notify( #"weaken_boss" );
    level endon( #"weaken_boss" );
    level utility::flag_set( "flag_weaken_boss" );
    wait 15;
    level utility::flag_clear( "flag_weaken_boss" );
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x3845275b, Offset: 0x387e
// Size: 0x2e6
function player_dropoff( struct_location, end_notify = "stop_all_dropoffs" )
{
    level endon( end_notify );
    level.var_ecbb0be4b63f5774 = utility::getstruct( struct_location, "targetname" );
    
    foreach ( player in level.players )
    {
        if ( player.has_shard )
        {
            level.var_bd2748e149a8024b thread function_d73e018ec2d04bf3( player );
        }
    }
    
    level endon( #"shard_event_done" );
    radius = 128;
    struct = utility::getstruct( struct_location, "targetname" );
    trigger = spawn( "trigger_radius", struct.origin, 0, radius, radius );
    level.var_3da29412e8cac16a = [];
    num_chevrons = 16;
    segment_degrees = 360 / num_chevrons;
    level thread deposit_zone_fx( struct );
    level thread deposit_zone_beam( struct );
    
    for ( i = 0; i < num_chevrons ; i++ )
    {
        local_offset = anglestoforward( ( 0, segment_degrees * i, 0 ) ) * radius;
        
        if ( !isdefined( struct.angles ) )
        {
            struct.angles = ( 0, 0, 0 );
        }
        
        chevron_org = coordtransform( local_offset, struct.origin, struct.angles );
        chevron_ang = vectortoangles( chevron_org - struct.origin );
        level.var_3da29412e8cac16a[ i ] = spawnscriptable( "ob_sat_capture_zone_chevron_contestable", chevron_org, chevron_ang );
        level.var_3da29412e8cac16a[ i ] setscriptablepartstate( "chevron", "active_contested" );
    }
    
    while ( !level utility::flag( "flag_shard_event_done" ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            if ( ent.has_shard )
            {
                ent notify( #"stop_shard_hint" );
                ent.has_shard = 0;
                level.shards_collected++;
                level.var_bd2748e149a8024b ob_story_mission_utils::function_315d79883d962ba7( level.shards_collected, level.shard_objective_count );
                level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 1, undefined, ent, undefined, undefined, 1 );
                level thread utility::play_sound_in_space( "uin_sat_nightmare_shard_deposit", struct.origin );
                ent playrumbleonentity( "damage_heavy" );
            }
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x92ec8675, Offset: 0x3b6c
// Size: 0x91
function deposit_zone_fx( struct )
{
    offset = ( 0, 0, 0 );
    tag_origin = utility::function_1808878d1c511ce8( struct.origin + offset, struct.angles );
    playfxontag( level._effect[ "deposit_zone" ], tag_origin, "tag_origin" );
    level utility::flag_wait( "flag_shard_event_done" );
    stopfxontag( level._effect[ "deposit_zone" ], tag_origin, "tag_origin" );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x601f965a, Offset: 0x3c05
// Size: 0x9d
function deposit_zone_beam( struct )
{
    offset = ( 0, 0, -40 );
    angle = ( -90, 0, 0 );
    tag_origin = utility::function_1808878d1c511ce8( struct.origin + offset );
    playfxontag( level._effect[ "deposit_beam" ], tag_origin, "tag_origin" );
    level utility::flag_wait( "flag_shard_event_done" );
    stopfxontag( level._effect[ "deposit_beam" ], tag_origin, "tag_origin" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x34083057, Offset: 0x3caa
// Size: 0xca
function function_ec05cf19fb86e1e5()
{
    level endon( #"shard_event_done" );
    
    while ( !level utility::flag( "flag_shard_event_done" ) )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            if ( !ent.has_shard )
            {
                level.var_2e07a4798d97c706--;
                ent.has_shard = 1;
                ent utility::callsharedfunc( #"hint", #"add_simple", "hint_aries_nightmare_growth", &"sat_ob/hint_nm_shard", 0, undefined, "stop_shard_hint" );
                level.var_bd2748e149a8024b thread function_d73e018ec2d04bf3( ent );
                thread nightmare_splash( "nm_shard_deposit", undefined, ent );
                ent playrumbleonentity( "damage_heavy" );
                break;
            }
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x6bb76409, Offset: 0x3d7c
// Size: 0x4c
function function_d73e018ec2d04bf3( player )
{
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( level.var_ecbb0be4b63f5774.origin, 96, [ player ] );
    function_4acfb3ee90cb87a4( player );
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x6eaa5d0b, Offset: 0x3dd0
// Size: 0x3b
function function_4acfb3ee90cb87a4( player )
{
    level endon( #"hash_c7f7c92782384c02" );
    
    while ( !level utility::flag( "flag_shard_event_done" ) && player.has_shard )
    {
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x8074e85d, Offset: 0x3e13
// Size: 0x4, Type: bool
function should_hint()
{
    return true;
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0xa1493348, Offset: 0x3e20
// Size: 0x1da
function function_ed2fc0a561e47f( minion_encounter_name, crate_targetname, random_faction = 0, objective_asset )
{
    start_of_round_fanfare( "nm_overlord_crate_start", "nm_wave_start" );
    obj = objective_asset ?? %"hash_2e5e769ec4a03bbd";
    ob_story_mission_utils::objective_text_show( obj );
    waitframe();
    level.var_bc30025255a14f35 = 0;
    level.num_crates = 1;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_bc30025255a14f35, level.num_crates );
    utility::add_fx( "crate_vfx", "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    timer = 180;
    ob_story_mission_utils::objective_timer_update( timer );
    level utility::flag_set( "nightmare_encouter_active" );
    thread minion_encounter( minion_encounter_name, "flag_shutdown_event_done", random_faction, undefined, undefined, 0 );
    level.scene_jungle_rhino_crate = utility::getstruct( "scene_jungle_rhino_crate", "targetname" );
    
    if ( level.scene_jungle_rhino_crate )
    {
        level.scene_jungle_rhino_crate thread scene::play( undefined, "Pre-Hack" );
        level.scene_jungle_rhino_crate scene::set_notify_note( level, "drone_hack_rumble", "Types_Prop", 1 );
        level.scene_jungle_rhino_crate thread function_f2ae6c65ec4484cd();
    }
    
    interact_struct = utility::getstruct( "struct_jungle_rhino_crate_interact", "targetname" );
    
    for ( i = 0; i < level.num_crates ; i++ )
    {
        if ( interact_struct )
        {
            thread vent_button( interact_struct, "flag_vent_" + i + "_closed" );
        }
    }
    
    level utility::flag_wait( "flag_all_crates_interacted_with" );
    level notify( #"cleanup_minions" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "flag_shutdown_event_done" );
    end_of_round_fanfare( "nm_overlord_crate_end", "nm_wave_complete" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xc42a9924, Offset: 0x4002
// Size: 0x7e
function setup_rhino_crates()
{
    for ( i = 1; i <= level.players.size ; i++ )
    {
        scene_struct = utility::getstruct( "scene_jungle_rhino_crate_" + i, "targetname" );
        interact_struct = utility::getstruct( "scene_jungle_rhino_crate_interact_" + i, "targetname" );
        
        if ( scene_struct && interact_struct )
        {
            scene_struct thread function_f2ae6c65ec4484cd();
            interact_struct thread rhino_crate_interact( scene_struct );
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x43a5de67, Offset: 0x4088
// Size: 0xad
function rhino_crate_interact( scene_struct )
{
    model = spawn( "script_model", self.origin );
    model.angles = self.angles;
    model setmodel( %"eqp_sat_wm_tablet" );
    interact = interaction::register_interact( self.origin + ( 0, 0, 2 ), 32, &function_765f8a9a7c3f30ca, &"sat_ob_story_missions/rhino_crate_interact", undefined, undefined, undefined, "HINT_BUTTON" );
    interact setuseholdduration( 0 );
    interact function_2e7823efdf3dfc69();
    interact makeunusable();
    model delete();
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x92adb2ed, Offset: 0x413d
// Size: 0x1b
function function_2e7823efdf3dfc69()
{
    self endon( #"rhino_used" );
    level utility::flag_wait( "flag_disable_rhino_crates" );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x223827ec, Offset: 0x4160
// Size: 0x21
function function_765f8a9a7c3f30ca( var_9d64a5e2cee72c8f )
{
    self notify( #"rhino_used" );
    var_9d64a5e2cee72c8f thread start_remote_robot();
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x4bd1d04d, Offset: 0x4189
// Size: 0x41
function function_f2ae6c65ec4484cd()
{
    level utility::flag_wait( "flag_killcount_event" );
    ents = scene::get_entities();
    
    if ( ents[ 0 ] )
    {
        level thread utility::play_loopsound_in_space( "emt_sat_nightmare_crate_hum", ents[ 0 ].origin );
    }
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0xc45a5a55, Offset: 0x41d2
// Size: 0x16e
function vent_button( struct, flag_name )
{
    offset = ( 0, 0, 0 );
    button = struct;
    interact = interaction::register_interact( button.origin + offset, 64, &zone_interact, &"sat_ob_story_missions/should_shutdown" );
    interact.flag_interact = flag_name;
    interact setcursorhint( "HINT_BUTTON" );
    interact setuseholdduration( 0 );
    
    if ( !isdefined( self.var_8029d4363972e15 ) )
    {
        self.var_8029d4363972e15 = [];
    }
    
    var_7755c399b0e4de3c = self.var_8029d4363972e15.size;
    self.var_8029d4363972e15[ var_7755c399b0e4de3c ] = ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin, 24 );
    function_2b8e3d3ae2a6414a( self.var_8029d4363972e15[ var_7755c399b0e4de3c ], 0 );
    level utility::flag_wait( flag_name );
    snd::play( "cin_sat_virgo_cradle_wormhole_open", struct.origin );
    ob_story_mission_utils::objective_marker_clear( self.var_8029d4363972e15[ var_7755c399b0e4de3c ] );
    level.var_bc30025255a14f35++;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_bc30025255a14f35, level.num_crates );
    
    if ( level.var_bc30025255a14f35 >= level.num_crates )
    {
        utility::flag_set( "flag_all_crates_interacted_with" );
        return;
    }
    
    function_70467d6be224da52( "nm_overlord_crate_next" );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xe81c8254, Offset: 0x4348
// Size: 0x141
function spawn_turret( team = "team_hundred_ninety" )
{
    self.maxhealth = 1250;
    turret = ob_soldier_util::ob_sentry_turret_spawn( self );
    waitframe();
    level.sentrysettings[ "ai_sentry_turret" ].targetrange = 10000;
    level.sentrysettings[ "ai_sentry_turret" ].burstmin = 55;
    level.sentrysettings[ "ai_sentry_turret" ].burstmax = 60;
    level.sentrysettings[ "ai_sentry_turret" ].pausemin = 0.2;
    level.sentrysettings[ "ai_sentry_turret" ].pausemax = 0.4;
    level.sentrysettings[ "ai_sentry_turret" ].spinuptime = 0.2;
    turret.isactive = 1;
    turret.team = team;
    visibility_mode::function_3afc3bc470c80e61( turret, turret.team );
    level notify( #"highvis_reload_outline", turret.team, [ turret ] );
    turret thread cleanup_turret();
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x57b3fbc9, Offset: 0x4491
// Size: 0x191
function function_bd6063946e66442c( player, timer = undefined )
{
    self.maxhealth = 1250;
    turret = ob_soldier_util::ob_sentry_turret_spawn( self );
    waitframe();
    level.sentrysettings[ "ai_sentry_turret" ].targetrange = 10000;
    level.sentrysettings[ "ai_sentry_turret" ].burstmin = 100;
    level.sentrysettings[ "ai_sentry_turret" ].burstmax = 105;
    level.sentrysettings[ "ai_sentry_turret" ].pausemin = 0.1;
    level.sentrysettings[ "ai_sentry_turret" ].pausemax = 0.2;
    level.sentrysettings[ "ai_sentry_turret" ].spinuptime = 0.1;
    turret.isactive = 1;
    turret.team = player.team;
    turret.var_3761ee502c4a6baa = 100000;
    turret hudoutlineenable( "outline_nodepth_cyan" );
    visibility_mode::function_3afc3bc470c80e61( turret, turret.team );
    level notify( #"highvis_reload_outline", turret.team, [ turret ] );
    
    if ( isdefined( timer ) )
    {
        turret thread function_e19e78c8e1c7475b( timer );
    }
    
    turret thread cleanup_turret();
    turret.var_24954f14e27b448d = 0;
    turret setcandamage( 0 );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x7cf901f, Offset: 0x462a
// Size: 0x3f
function function_e19e78c8e1c7475b( timer )
{
    self endon( #"death" );
    level endon( #"hash_23dc72c206f93882" );
    wait timer;
    self notify( #"timer_hit" );
    self notify( #"kill_turret" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x5465aeff, Offset: 0x4671
// Size: 0x33
function cleanup_turret()
{
    self endon( #"death" );
    self endon( #"timer_hit" );
    level waittill( #"hash_23dc72c206f93882" );
    self notify( #"kill_turret" );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x2f7e5d86, Offset: 0x46ac
// Size: 0x86
function spawn_dawg( usage_mode )
{
    dawg = mp_agent::spawnnewagentaitype( "sat_dawg_ob", self.origin, self.angles, "axis" );
    var_345458a731640cf2 = utility::spawn_tag_origin( self.origin, self.angles );
    var_345458a731640cf2.team = "axis";
    waitframe();
    dawg dawg::dawgpostinit( var_345458a731640cf2 );
    dawg.mode = usage_mode;
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x6d386aea, Offset: 0x473a
// Size: 0x28
function function_d9ecb2d6f0703793( objective_info )
{
    level utility::flag_wait( "flag_crate_fail" );
    self delete();
    ob_story_mission_utils::objective_marker_clear( objective_info );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x6a9b71fd, Offset: 0x476a
// Size: 0x4b
function zone_interact( var_9d64a5e2cee72c8f )
{
    self makeunusable();
    level utility::play_sound_in_space( "equip_suitcase_defuse_button", self.origin );
    
    if ( level.scene_jungle_rhino_crate )
    {
        level.scene_jungle_rhino_crate scene::play( var_9d64a5e2cee72c8f, "Hack" );
    }
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x1b758a7e, Offset: 0x47bd
// Size: 0x1d2
function function_5457286dafa242e4( minion_encounter_name, objective_asset )
{
    start_of_round_fanfare( "nm_overlord_flower_start", "nm_flower_start" );
    obj = objective_asset ?? %"hash_9a794525687e8e4";
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = function_3fc7f1f10018b737( 120 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread wave_fail_timer( time_modifier );
    waitframe();
    level utility::flag_set( "nightmare_encouter_active" );
    thread minion_encounter( minion_encounter_name, "flag_flowers_killed" );
    flowers = [];
    flowers[ flowers.size ] = "macguffin_flower_a";
    flowers[ flowers.size ] = "macguffin_flower_b";
    flowers[ flowers.size ] = "macguffin_flower_c";
    flowers[ flowers.size ] = "macguffin_flower_d";
    flowers[ flowers.size ] = "macguffin_flower_e";
    flowers[ flowers.size ] = "macguffin_flower_f";
    flowers[ flowers.size ] = "macguffin_flower_g";
    flowers[ flowers.size ] = "macguffin_flower_h";
    flowers[ flowers.size ] = "macguffin_flower_i";
    flowers[ flowers.size ] = "macguffin_flower_j";
    flowers[ flowers.size ] = "macguffin_flower_k";
    flowers[ flowers.size ] = "macguffin_flower_l";
    level.var_6d9a23107f9757f4 = 0;
    level.var_3bc8f455e56fda5 = 10;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_6d9a23107f9757f4, level.var_3bc8f455e56fda5 );
    
    for ( i = 0; i < flowers.size ; i++ )
    {
        thread flower_logic( flowers[ i ] );
    }
    
    while ( level.var_6d9a23107f9757f4 < 10 )
    {
        wait 0.5;
    }
    
    level notify( #"cleanup_minions" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "flag_flowers_killed" );
    level notify( #"hash_aefc5c470125baf8" );
    level notify( #"stop_circle" );
    end_of_round_fanfare( "nm_overlord_flower_end", "nm_flower_complete" );
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x8b102ee3, Offset: 0x4997
// Size: 0x2b4
function flower_logic( targetname, outline_color = "outline_depth_red", team = "team_hundred_ninety" )
{
    /#
        iprintlnbold( targetname );
    #/
    
    flower = weak_point::cluster_setup( targetname, "closed", 500 );
    spawn_struct = utility::getstruct( targetname, "script_noteworthy" );
    
    if ( isdefined( spawn_struct ) )
    {
        playfx( level._effect[ "enemy_vfx" ], spawn_struct.origin );
    }
    
    flower.arr_weak_point[ 0 ] hudoutlineenable( outline_color );
    
    if ( !isdefined( flower ) )
    {
        return;
    }
    
    wait 1;
    flower weak_point::cluster_set_state( "opening" );
    
    if ( !isdefined( level.ob.cysts ) )
    {
        level.ob.cysts = [];
    }
    
    level.ob.cysts[ level.ob.cysts.size ] = flower.arr_weak_point[ 0 ];
    flower function_c369d41857a6d522();
    level utility::flag_set( targetname );
    level.var_6d9a23107f9757f4++;
    flower weak_point::cluster_set_state( "dead" );
    
    if ( level.var_6d9a23107f9757f4 <= 10 )
    {
        ob_story_mission_utils::function_315d79883d962ba7( level.var_6d9a23107f9757f4, level.var_3bc8f455e56fda5 );
        
        if ( isdefined( spawn_struct ) )
        {
            angles = spawn_struct.angles;
            origin = spawn_struct.origin;
        }
        else
        {
            angles = ( 0, 0, 0 );
            origin = flower.arr_weak_point[ 0 ].origin;
        }
        
        if ( level.var_6d9a23107f9757f4 <= 9 )
        {
            playfx( level._effect[ "enemy_vfx" ], origin );
            parasite = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_parasite_ob", origin, angles, team );
            parasite thread individual_vanish( "flag_flowers_killed" );
            health = parasite.health;
            new_health = health * 3;
            new_health = int( new_health );
            parasite mp_agent::set_agent_health( new_health );
            wait 1;
            playfx( level._effect[ "enemy_vfx" ], origin );
            parasite = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_parasite_ob", origin, angles, team );
            parasite thread individual_vanish( "flag_flowers_killed" );
            health = parasite.health;
            new_health = health * 3;
            new_health = int( new_health );
            parasite mp_agent::set_agent_health( new_health );
        }
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xeb734906, Offset: 0x4c53
// Size: 0x1b
function function_c369d41857a6d522()
{
    self endon( #"weak_point_destroyed" );
    level utility::flag_wait( "flag_flowers_killed" );
}

// Namespace ob_nm_mode
// Params 9
// Checksum 0xc13005a7, Offset: 0x4c76
// Size: 0x351
function nightmare_disciple_fight( var_fcb964ac6f23a112, var_e04c0425c57a325, radius = 1500, main_boss, static_circle = undefined, minion_encounter_name, big_boss, spawn_minions, objective_asset )
{
    start_of_round_fanfare( "nm_overlord_boss_start", "nm_miniboss_start" );
    var_fcb964ac6f23a112 = utility::getstruct( var_fcb964ac6f23a112, "targetname" );
    var_e04c0425c57a325 = utility::getstructarray( var_e04c0425c57a325, "targetname" );
    var_e04c0425c57a325 = arrayrandomize( var_e04c0425c57a325 );
    level utility::flag_clear( "nightmare_encouter_done" );
    obj = objective_asset ?? %"hash_58ceb76ce380e3be";
    ob_story_mission_utils::objective_text_show( obj );
    waitframe();
    num_bosses = level.players.size;
    level.nm_bosses = num_bosses;
    level.var_ff552d2355510bb7 = 0;
    ob_story_mission_utils::function_315d79883d962ba7( 0, 1 );
    wait 1;
    
    if ( isdefined( static_circle ) )
    {
        circle_move_time = 20;
        var_9a7b20e173174021 = 6000;
        circle = function_21689e5c8bddd87c( var_fcb964ac6f23a112.origin, var_9a7b20e173174021 );
        circle brcirclemoveto( var_fcb964ac6f23a112.origin[ 0 ], var_fcb964ac6f23a112.origin[ 1 ], radius, circle_move_time );
        level thread update_minimap_circle( circle, var_fcb964ac6f23a112.origin, var_fcb964ac6f23a112.origin, var_9a7b20e173174021, radius, circle_move_time );
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( var_fcb964ac6f23a112.origin, 24 );
        wait circle_move_time;
        ob_story_mission_utils::mission_objective_marker_clear( obj_id );
        
        if ( level utility::flag( "flag_disciple_circle" ) )
        {
            level thread function_3a869839c1e8160( circle );
        }
    }
    
    time_modifier = function_3fc7f1f10018b737( 360 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread wave_fail_timer( time_modifier );
    spawn_pos = getclosestpointonnavmesh( var_e04c0425c57a325[ 0 ].origin );
    playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
    level.disciple_boss = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_disciple_skoll_hvt", spawn_pos, var_e04c0425c57a325[ 0 ].angles, "team_two_hundred" );
    level.disciple_boss.var_be5ccf6d16f6b59e = 1;
    level.disciple_boss thread miniboss_setup( "sat_spawner_zombie_disciple_skoll_hvt", self );
    thread miniboss_objective( level.disciple_boss );
    level utility::flag_set( "nightmare_encouter_active" );
    thread minion_encounter( minion_encounter_name, "nightmare_encouter_done" );
    level utility::delaycall( 5, &utility::flag_set, "disciple_phase_01" );
    level.disciple_boss waittill( #"death" );
    level notify( #"cleanup_minions" );
    level notify( #"hash_aefc5c470125baf8" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level notify( #"stop_circle" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
    
    self.var_9be376218db54aba = undefined;
    end_of_round_fanfare( "nm_overlord_boss_dead" );
}

// Namespace ob_nm_mode
// Params 9
// Checksum 0x5a9bbfc8, Offset: 0x4fcf
// Size: 0x3e8
function function_7610ada426867407( var_fcb964ac6f23a112, var_e04c0425c57a325, radius = 1500, main_boss = "sat_spawner_zombie_mimic_ob", static_circle = undefined, minion_encounter_name, big_boss = 0, spawn_minions = 1, objective_asset )
{
    start_of_round_fanfare( "nm_overlord_boss_start", "nm_miniboss_start" );
    var_fcb964ac6f23a112 = utility::getstruct( var_fcb964ac6f23a112, "targetname" );
    var_e04c0425c57a325 = utility::getstructarray( var_e04c0425c57a325, "targetname" );
    var_e04c0425c57a325 = arrayrandomize( var_e04c0425c57a325 );
    level utility::flag_clear( "nightmare_encouter_done" );
    obj = objective_asset ?? %"hash_58ceb76ce380e3be";
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = function_3fc7f1f10018b737( 360 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread wave_fail_timer( time_modifier );
    waitframe();
    num_bosses = level.players.size;
    level.nm_bosses = num_bosses;
    level.var_ff552d2355510bb7 = 0;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_ff552d2355510bb7, level.nm_bosses );
    wait 1;
    
    if ( isdefined( static_circle ) )
    {
        circle_move_time = 20;
        var_9a7b20e173174021 = 6000;
        circle = function_21689e5c8bddd87c( var_fcb964ac6f23a112.origin, var_9a7b20e173174021 );
        circle brcirclemoveto( var_fcb964ac6f23a112.origin[ 0 ], var_fcb964ac6f23a112.origin[ 1 ], radius, circle_move_time );
        level thread update_minimap_circle( circle, var_fcb964ac6f23a112.origin, var_fcb964ac6f23a112.origin, var_9a7b20e173174021, radius, circle_move_time );
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( var_fcb964ac6f23a112.origin, 24 );
        wait circle_move_time;
        ob_story_mission_utils::mission_objective_marker_clear( obj_id );
        
        if ( level utility::flag( "flag_disciple_circle" ) )
        {
            level thread function_3a869839c1e8160( circle );
        }
    }
    
    level.var_8dc544962712d2ff = [];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( isarray( main_boss ) )
        {
            enemy_type = main_boss[ i ];
        }
        else
        {
            enemy_type = main_boss;
        }
        
        if ( issubstr( enemy_type, "zom" ) )
        {
            team = "team_two_hundred";
        }
        else
        {
            team = "team_hundred_ninety";
        }
        
        spawn_pos = getclosestpointonnavmesh( var_e04c0425c57a325[ i ].origin );
        playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
        level.var_8dc544962712d2ff[ i ] = mp_agent::spawnnewagentaitype( enemy_type, spawn_pos, var_e04c0425c57a325[ i ].angles, team );
        level.var_8dc544962712d2ff[ i ] thread miniboss_setup( enemy_type, self );
        
        if ( !big_boss )
        {
            thread miniboss_objective( level.var_8dc544962712d2ff[ i ] );
        }
        
        waitframe();
    }
    
    level utility::flag_set( "nightmare_encouter_active" );
    
    if ( spawn_minions )
    {
        thread minion_encounter( minion_encounter_name, "nightmare_encouter_done" );
    }
    
    while ( level.var_8dc544962712d2ff.size )
    {
        level.var_8dc544962712d2ff = utility::array_removedead_or_dying( level.var_8dc544962712d2ff );
        wait 0.5;
    }
    
    level notify( #"cleanup_minions" );
    level notify( #"hash_aefc5c470125baf8" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level notify( #"stop_circle" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
    
    self.var_9be376218db54aba = undefined;
    end_of_round_fanfare( "nm_overlord_boss_dead" );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x71cad868, Offset: 0x53bf
// Size: 0x14e
function function_3a869839c1e8160( circle )
{
    level utility::flag_wait( "disciple_phase_01" );
    circle_move_time = 1;
    current_radius = 1500;
    radius = 1200;
    nm_church_interior = utility::getstruct( "nm_church_interior", "targetname" );
    circle brcirclemoveto( nm_church_interior.origin[ 0 ], nm_church_interior.origin[ 1 ], radius, circle_move_time );
    level thread update_minimap_circle( circle, nm_church_interior.origin, nm_church_interior.origin, current_radius, radius, circle_move_time );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( nm_church_interior.origin, 24 );
    wait circle_move_time;
    ob_story_mission_utils::mission_objective_marker_clear( obj_id );
    level utility::flag_wait( "disciple_phase_04" );
    current_radius = 900;
    radius = 500;
    circle brcirclemoveto( nm_church_interior.origin[ 0 ], nm_church_interior.origin[ 1 ], radius, circle_move_time );
    level thread update_minimap_circle( circle, nm_church_interior.origin, nm_church_interior.origin, current_radius, radius, circle_move_time );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( nm_church_interior.origin, 24 );
    wait circle_move_time;
    ob_story_mission_utils::mission_objective_marker_clear( obj_id );
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x212d367c, Offset: 0x5515
// Size: 0x15a
function miniboss_setup( enemy_type, activity_instance )
{
    switch ( enemy_type )
    {
        case #"hash_7f17897ddebdb20b":
            set_boss_health( 0.35 );
            break;
        case #"hash_1725650eddbaac48":
            set_boss_health( 0.5 );
            break;
        case #"hash_5c8766ad02e29c79":
            self setmodel( "c_sat_ava_opforce_shocktroop_guild_body_1_b" );
            
            if ( isdefined( self.headmodel ) )
            {
                self detach( self.headmodel );
            }
            
            self attach( "c_sat_ava_opforce_shocktroop_guild_head_1_b" );
            self.headmodel = "c_sat_ava_opforce_shocktroop_guild_head_1_b";
            set_boss_health( 2 );
            break;
        case #"hash_c47491593874be01":
            thread function_a60cd6315c37bac1();
            set_boss_health( 1.5 );
            break;
        case #"hash_e01cc337296e937":
            set_boss_health( 0.75 );
            break;
        case #"hash_fa16cbd09529412a":
            function_f2f3e02b9264fb20( 0.2 );
            thread function_f9938e7cc8cb67f0( activity_instance );
            break;
        case #"hash_206eb6dd893d4121":
            health = 2 + level.players.size * 0.5;
            set_boss_health( health );
            thread function_fd105ccf5977ab37( activity_instance );
        default:
            break;
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xcb345649, Offset: 0x5677
// Size: 0x6c
function function_f2f3e02b9264fb20( scalar )
{
    if ( isdefined( level.ai_disciple ) )
    {
        minibosshealth = level.ai_disciple.health;
        new_health = minibosshealth * level.players.size * scalar;
        new_health = int( new_health );
        level.ai_disciple mp_agent::set_agent_health( new_health );
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xca2d49f1, Offset: 0x56eb
// Size: 0x40
function set_boss_health( scalar )
{
    bosshealth = self.health;
    new_health = bosshealth * scalar;
    new_health = int( new_health );
    mp_agent::set_agent_health( new_health );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xcef5b25a, Offset: 0x5733
// Size: 0x4f
function function_f9938e7cc8cb67f0( activity_instance )
{
    level.ai_disciple = self;
    level._effect[ "harper_slam" ] = loadfxasset( "vfx_sat_wc_vgo_boss_hand_aoe_ring_01" );
    level.ai_disciple thread function_757b5d0d38b05c58();
    level.ai_disciple thread function_35b59581023acd87();
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xc9b106ba, Offset: 0x578a
// Size: 0x11b
function function_35b59581023acd87()
{
    while ( isalive( level.ai_disciple ) )
    {
        level.ai_disciple waittill( #"hash_f7c1c0c22149ff40" );
        
        /#
            iprintlnbold( level.var_abbebdb114e4f57f );
        #/
        
        switch ( level.var_abbebdb114e4f57f )
        {
            case 1:
                break;
            case 2:
                /#
                    iprintlnbold( "<dev string:x24>" );
                #/
                
                level utility::flag_set( "disciple_phase_01" );
                function_987f9468628946a0();
                break;
            case 3:
                /#
                    iprintlnbold( "<dev string:x36>" );
                #/
                
                level utility::flag_set( "disciple_phase_02" );
                function_987f9468628946a0();
                break;
            case 4:
                level utility::flag_set( "disciple_phase_03" );
                
                /#
                    iprintlnbold( "<dev string:x48>" );
                #/
                
                function_987f9468628946a0();
                break;
            case 5:
                /#
                    iprintlnbold( "<dev string:x5a>" );
                #/
                
                level utility::flag_set( "disciple_phase_04" );
                function_987f9468628946a0();
                break;
        }
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xa0cd8494, Offset: 0x58ad
// Size: 0x315
function function_12b9914c7e9a2d60()
{
    level.ai_disciple endon( #"death" );
    level.ai_disciple.ignoreme = 1;
    level.ai_disciple.ignoreall = 1;
    level.ai_disciple thread function_fa2a4a74d04185e( level.ai_disciple.origin );
    agents = getaiarray();
    
    foreach ( var_9413a6189a45c7de in agents )
    {
        if ( issubstr( var_9413a6189a45c7de.classname, "disciple" ) || issubstr( var_9413a6189a45c7de.classname, "mangler" ) )
        {
            continue;
        }
        
        playfx( level._effect[ "enemy_vfx" ], var_9413a6189a45c7de.origin );
        var_9413a6189a45c7de kill();
    }
    
    wait 2;
    playfx( level._effect[ "enemy_vfx" ], level.ai_disciple.origin );
    nm_miniboss_teleport = utility::getstruct( "nm_miniboss_teleport", "targetname" );
    anchor_tag = level utility::function_1808878d1c511ce8( level.ai_disciple.origin, level.ai_disciple.angles );
    level.ai_disciple linkto( anchor_tag );
    playfxontag( level._effect[ "disciple_trail_vfx" ], level.ai_disciple, "tag_origin" );
    n_speed = 1.2;
    anchor_tag moveto( nm_miniboss_teleport.origin, n_speed );
    anchor_tag waittill( #"movedone" );
    wait 2;
    level.ai_disciple thread function_fa2a4a74d04185e( level.ai_disciple.origin );
    nightmare_splash( "nm_incoming_strike" );
    snd::play( "CHURCH_SIREN_SFX_ALIAS", ( 4907, -3447, 5389 ) );
    level thread function_e68ea7f6b97ccd83();
    wait 5;
    nm_miniboss_teleport_end = utility::getstruct( "nm_miniboss_teleport_end", "targetname" );
    anchor_tag moveto( nm_miniboss_teleport_end.origin, n_speed );
    anchor_tag waittill( #"movedone" );
    level.ai_disciple unlink();
    level.ai_disciple.ignoreme = 0;
    level.ai_disciple.ignoreall = 0;
    level.ai_disciple setcandamage( 1 );
    anchor_tag delete();
    stopfxontag( level._effect[ "disciple_trail_vfx" ], level.ai_disciple, "tag_origin" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x27b2b661, Offset: 0x5bca
// Size: 0x311
function function_987f9468628946a0()
{
    level.ai_disciple endon( #"death" );
    level.ai_disciple.ignoreme = 1;
    level.ai_disciple.ignoreall = 1;
    level.ai_disciple thread function_fa2a4a74d04185e( level.ai_disciple.origin );
    agents = getaiarray();
    
    foreach ( var_9413a6189a45c7de in agents )
    {
        if ( issubstr( var_9413a6189a45c7de.classname, "disciple" ) || issubstr( var_9413a6189a45c7de.classname, "mangler" ) )
        {
            continue;
        }
        
        playfx( level._effect[ "enemy_vfx" ], var_9413a6189a45c7de.origin );
        var_9413a6189a45c7de kill();
    }
    
    wait 2;
    playfx( level._effect[ "enemy_vfx" ], level.ai_disciple.origin );
    nm_miniboss_teleport = utility::getstruct( "nm_miniboss_teleport", "targetname" );
    
    if ( isdefined( nm_miniboss_teleport ) )
    {
        anchor_tag = level utility::function_1808878d1c511ce8( level.ai_disciple.origin, level.ai_disciple.angles );
        level.ai_disciple linkto( anchor_tag );
    }
    
    playfxontag( level._effect[ "disciple_trail_vfx" ], level.ai_disciple, "tag_origin" );
    n_speed = 1.2;
    anchor_tag moveto( nm_miniboss_teleport.origin, n_speed );
    anchor_tag waittill( #"movedone" );
    wait 2;
    level.ai_disciple thread function_fa2a4a74d04185e( level.ai_disciple.origin );
    nightmare_splash( "nm_incoming_strike" );
    snd::play( "evt_aries_nightmare_barge_airstrike_siren", ( 4907, -3447, 5389 ) );
    level thread function_3e4a1b748b1f57aa();
    wait 7;
    nm_miniboss_teleport_end = utility::getstruct( "nm_miniboss_teleport_end", "targetname" );
    
    if ( isdefined( nm_miniboss_teleport_end ) )
    {
        anchor_tag moveto( nm_miniboss_teleport_end.origin, n_speed );
        anchor_tag waittill( #"movedone" );
    }
    
    level.ai_disciple unlink();
    level.ai_disciple.ignoreme = 0;
    level.ai_disciple.ignoreall = 0;
    anchor_tag delete();
    stopfxontag( level._effect[ "disciple_trail_vfx" ], level.ai_disciple, "tag_origin" );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x3e36c924, Offset: 0x5ee3
// Size: 0x4c0
function function_3e4a1b748b1f57aa( owner )
{
    utility::flag_wait( "toma_strike_initialized" );
    utility::add_fx( "toma_strike_target", "vfx_sat_wc_vgo_boss_attack_target_01" );
    var_28ed962522598df3 = toma_strike::function_2828cb52fc7c81ef();
    toma_strike::init_toma_strike_params( var_28ed962522598df3 );
    level.toma_weapon_name = "toma_proj_sat_ob_virgo";
    level.var_d2057eb693bfdb83 = "ks_toma_strike_cluster_sat_ob_virgo";
    num_shots = 4;
    
    if ( !isdefined( owner ) )
    {
        owner = level.ai_disciple;
    }
    
    nm_church_toma_pos_01 = utility::getstructarray( "nm_church_toma_pos_01", "targetname" );
    nm_church_toma_pos_02 = utility::getstructarray( "nm_church_toma_pos_02", "targetname" );
    nm_church_toma_pos_03 = utility::getstructarray( "nm_church_toma_pos_03", "targetname" );
    nm_church_toma_pos_04 = utility::getstructarray( "nm_church_toma_pos_04", "targetname" );
    level.ai_disciple thread function_fa2a4a74d04185e( level.ai_disciple.origin );
    
    foreach ( toma_pos in nm_church_toma_pos_01 )
    {
        var_710f1e0baf1c29ff = level utility::function_1808878d1c511ce8( toma_pos.origin, toma_pos.origin );
        level thread utility::play_sound_in_space( "evt_plr_incoming_cradle_attack_01", var_710f1e0baf1c29ff.origin + ( 0, 0, 600 ) );
        level thread utility::play_sound_in_space( "maaws_reticle_locked", var_710f1e0baf1c29ff.origin );
        level thread function_22126bf9e438ead6( owner, var_710f1e0baf1c29ff, num_shots, 64, 256 );
    }
    
    wait 2;
    level.ai_disciple thread function_fa2a4a74d04185e( level.ai_disciple.origin );
    
    foreach ( toma_pos in nm_church_toma_pos_02 )
    {
        var_710f1e0baf1c29ff = level utility::function_1808878d1c511ce8( toma_pos.origin, toma_pos.origin );
        level thread utility::play_sound_in_space( "evt_plr_incoming_cradle_attack_01", var_710f1e0baf1c29ff.origin + ( 0, 0, 600 ) );
        level thread utility::play_sound_in_space( "maaws_reticle_locked", var_710f1e0baf1c29ff.origin );
        level thread function_22126bf9e438ead6( owner, var_710f1e0baf1c29ff, num_shots, 64, 256 );
    }
    
    wait 2;
    level.ai_disciple thread function_fa2a4a74d04185e( level.ai_disciple.origin );
    
    foreach ( toma_pos in nm_church_toma_pos_03 )
    {
        var_710f1e0baf1c29ff = level utility::function_1808878d1c511ce8( toma_pos.origin, toma_pos.origin );
        level thread utility::play_sound_in_space( "evt_plr_incoming_cradle_attack_01", var_710f1e0baf1c29ff.origin + ( 0, 0, 600 ) );
        level thread utility::play_sound_in_space( "maaws_reticle_locked", var_710f1e0baf1c29ff.origin );
        level thread function_22126bf9e438ead6( owner, var_710f1e0baf1c29ff, num_shots, 64, 256 );
    }
    
    wait 2;
    level.ai_disciple thread function_fa2a4a74d04185e( level.ai_disciple.origin );
    
    foreach ( toma_pos in nm_church_toma_pos_04 )
    {
        var_710f1e0baf1c29ff = level utility::function_1808878d1c511ce8( toma_pos.origin, toma_pos.origin );
        level thread utility::play_sound_in_space( "evt_plr_incoming_cradle_attack_01", var_710f1e0baf1c29ff.origin + ( 0, 0, 600 ) );
        level thread utility::play_sound_in_space( "maaws_reticle_locked", var_710f1e0baf1c29ff.origin );
        level thread function_22126bf9e438ead6( owner, var_710f1e0baf1c29ff, num_shots, 64, 256 );
    }
    
    wait 5;
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x1ffe902c, Offset: 0x63ab
// Size: 0xb0
function function_757b5d0d38b05c58()
{
    ai_disciple = self;
    var_bf1316595b384341 = ai_disciple.health;
    num_phases = 5;
    level.var_abbebdb114e4f57f = 1;
    
    while ( isalive( ai_disciple ) )
    {
        ai_disciple waittill( #"damage" );
        
        while ( level.var_abbebdb114e4f57f < num_phases + 1 )
        {
            health_threshold = var_bf1316595b384341 - var_bf1316595b384341 / num_phases * level.var_abbebdb114e4f57f;
            
            while ( ai_disciple.health > health_threshold )
            {
                waitframe();
            }
            
            ai_disciple notify( #"hash_f7c1c0c22149ff40" );
            level.var_abbebdb114e4f57f++;
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x12d0c54, Offset: 0x6463
// Size: 0x1c6
function function_fd105ccf5977ab37( activity_instance )
{
    big_dawg = self;
    big_dawg.mode = "attack";
    big_dawg hudoutlineenable( "outline_nodepth_red" );
    big_dawg.turret hudoutlineenable( "outline_nodepth_red" );
    big_dawg.dawgaisettings.var_d28e878d2a0e2811 = 0.25;
    big_dawg.dawgaisettings.var_88ee7431f26db99a = 0.25;
    big_dawg.dawgaisettings.var_661ea1fdb3b0e70d = 1;
    big_dawg.dawgaisettings.var_eba7e927c5c2c8df = 0.375;
    big_dawg.dawgaisettings.missilecooldown = 7.5;
    big_dawg.dawgaisettings.var_93d81c17f963b491 = 0.75;
    big_dawg.dawgaisettings.var_5d8f188f4860eb1e = 175;
    big_dawg.dawgaisettings.var_10444dd5203a45b0 = 1;
    big_dawg.dawgaisettings.dawglifetime = -1;
    big_dawg.dawgaisettings.walkanimrate = 2;
    big_dawg thread big_dawg_vfx();
    big_dawg thread function_50e6dab9cb1cae8d();
    
    while ( isalive( big_dawg ) )
    {
        big_dawg waittill( #"hash_734fd6daea877688" );
        
        if ( big_dawg.mode == "attack" )
        {
            big_dawg.mode = "sentry";
            big_dawg thread function_116da08143fd1219( activity_instance );
            continue;
        }
        
        big_dawg.mode = "attack";
        big_dawg.ignoreme = 0;
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x93fbc9f7, Offset: 0x6631
// Size: 0x6c
function big_dawg_vfx()
{
    big_dawg = self;
    utility::add_fx( "dawg_vfx", "vfx_sat_wc_gameplay_nightmare_shards_01" );
    utility::add_fx( "dawg_grenade_vfx", "vfx_sat_core_smktrail_st_grenade" );
    utility::add_fx( "adds_vfx", "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    
    while ( isalive( big_dawg ) )
    {
        playfxontag( level._effect[ "dawg_vfx" ], big_dawg, "tag_origin" );
        wait 10;
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x28f9d4ee, Offset: 0x66a5
// Size: 0x8d
function function_50e6dab9cb1cae8d()
{
    big_dawg = self;
    var_bf1316595b384341 = big_dawg.health;
    num_phases = 5;
    var_abbebdb114e4f57f = 1;
    
    while ( isalive( big_dawg ) )
    {
        while ( var_abbebdb114e4f57f < num_phases + 1 )
        {
            health_threshold = var_bf1316595b384341 - var_bf1316595b384341 / num_phases * var_abbebdb114e4f57f;
            
            while ( big_dawg.health > health_threshold )
            {
                waitframe();
            }
            
            big_dawg notify( #"hash_734fd6daea877688" );
            var_abbebdb114e4f57f++;
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xd8041dc9, Offset: 0x673a
// Size: 0x11d
function function_116da08143fd1219( activity_instance )
{
    big_dawg = self;
    big_dawg endon( #"death" );
    bubble_shield_spawn_pos = big_dawg.origin;
    bubble_shield_model = utility::spawn_model( "eqp_sat_wm_bubble_shield_razor", bubble_shield_spawn_pos, big_dawg.angles );
    bubble_shield_model setscriptablepartstate( #"visibility", #"show" );
    bubble_shield_model setscriptablepartstate( #"active", #"active" );
    big_dawg childthread utility::delete_on_death( bubble_shield_model );
    activity_instance thread bubble_shield( bubble_shield_model, big_dawg );
    activity_instance thread function_208f70a257f47dcb( big_dawg );
    big_dawg childthread function_9ed864247ce8fd9c();
    big_dawg childthread function_3575580a91f5392f();
    level utility::flag_set( "flag_dawg_shield" );
    level waittill( #"hash_e95ced04f8eba21a" );
    level utility::flag_clear( "flag_dawg_shield" );
    
    if ( big_dawg.mode == "sentry" || big_dawg.mode == "inactive" )
    {
        big_dawg notify( #"hash_734fd6daea877688" );
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x9c61d91b, Offset: 0x685f
// Size: 0x21e
function function_9ed864247ce8fd9c()
{
    level endon( #"hash_e95ced04f8eba21a" );
    big_dawg = self;
    var_5e943102167d6e16 = 10000;
    
    while ( true )
    {
        wait randomfloatrange( 3, 5 );
        [ closest_player ] = sortbydistance( level.players, big_dawg.origin );
        
        if ( closest_player )
        {
            distance_squared = distancesquared( closest_player.origin, big_dawg.origin );
            sqrt_distance = sqrt( distance_squared );
            
            if ( distance_squared < var_5e943102167d6e16 * var_5e943102167d6e16 )
            {
                level thread utility::play_sound_in_space( "weap_mortar_fire_dist_aries", big_dawg.origin );
                var_464f09d1ca1324d6 = vectornormalize( closest_player.origin - big_dawg.origin );
                vector_upwards = vectornormalize( big_dawg.origin + ( 0, 0, 32 ) - big_dawg.origin );
                normalized_velocity = var_464f09d1ca1324d6 + vector_upwards;
                velocity = normalized_velocity * ( sqrt_distance * 0.4 + 200 );
                grenade = magicgrenademanual( "sat_cluster_grenade_ob", big_dawg.origin + ( 0, 0, 48 ), velocity, 2, big_dawg );
                
                foreach ( player in level.players )
                {
                    player thread function_de19cd86440d720c();
                }
                
                playfxontag( level._effect[ "dawg_vfx" ], grenade, "tag_origin" );
                playfxontag( level._effect[ "dawg_grenade_vfx" ], grenade, "tag_origin" );
            }
        }
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xf7dcf70b, Offset: 0x6a85
// Size: 0x7f
function function_de19cd86440d720c()
{
    self notify( #"hash_fce8b161b387ecc" );
    self endon( #"hash_fce8b161b387ecc" );
    level endon( #"hash_e95ced04f8eba21a" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, objweapon, tickpercent, originalowner );
        grenade.originalowner = originalowner;
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xd7566a93, Offset: 0x6b0c
// Size: 0xc1
function function_3575580a91f5392f()
{
    level endon( #"hash_e95ced04f8eba21a" );
    big_dawg = self;
    no_target_distance = 125;
    
    while ( true )
    {
        [ closest_player ] = sortbydistance( level.players, big_dawg.origin );
        
        if ( distancesquared( closest_player.origin, big_dawg.origin ) < no_target_distance * no_target_distance )
        {
            big_dawg.mode = "sentry";
            big_dawg.ignoreme = 0;
        }
        else
        {
            big_dawg.mode = "inactive";
            big_dawg.ignoreme = 1;
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x6f657dc8, Offset: 0x6bd5
// Size: 0xe1
function function_466b5596b86398f5()
{
    big_dawg = self;
    var_a75df5d59bae0829 = 160;
    enemy_offsets = [ ( 0, var_a75df5d59bae0829, 0 ), ( var_a75df5d59bae0829, 0, 0 ), ( 0, var_a75df5d59bae0829 * -1, 0 ), ( var_a75df5d59bae0829 * -1, 0, 0 ) ];
    wait 1;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        spawn_pos = getclosestpointonnavmesh( big_dawg.origin + enemy_offsets[ i ] );
        playfx( level._effect[ "adds_vfx" ], spawn_pos + ( 0, 0, 32 ) );
        bot = mp_agent::spawnnewagentaitype( "sat_ob_enemy_guild_bot", spawn_pos, undefined, "team_hundred_ninety" );
        bot thread individual_vanish( "aries_big_dawg_killed" );
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xee91e6f4, Offset: 0x6cbe
// Size: 0x58
function function_208f70a257f47dcb( big_dawg )
{
    var_8be60dae09e4903d = self;
    big_dawg waittill( #"hash_734fd6daea877688" );
    bubbleshield = var_8be60dae09e4903d.shield;
    
    if ( arraycontains( level.var_a0dcc921bb9a5edb, bubbleshield ) )
    {
        var_8be60dae09e4903d bubble_shield_end( bubbleshield );
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xe0712280, Offset: 0x6d1e
// Size: 0x7d
function miniboss_objective( boss )
{
    obj_id = ob_story_mission_utils::function_804834359f20ef5a( boss, 96 );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    boss waittill( #"death" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
    nightmare_splash( "nm_miniboss_defeated" );
    
    if ( isdefined( level.var_ff552d2355510bb7 ) )
    {
        level.var_ff552d2355510bb7++;
        ob_story_mission_utils::function_315d79883d962ba7( level.var_ff552d2355510bb7, level.nm_bosses );
    }
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0x3da48641, Offset: 0x6da3
// Size: 0x154
function killstreak_frenzy( var_db648a65d028f89c, killstreak_name, encounter_name, objective_asset )
{
    frenzy_time = 420;
    level utility::flag_set( "flag_killcount_event" );
    obj = objective_asset ?? %"hash_3cff3470e9aafa2b";
    ob_story_mission_utils::objective_text_show( obj );
    ob_story_mission_utils::objective_timer_update( frenzy_time );
    level thread wave_fail_timer( frenzy_time );
    
    if ( !isdefined( level.minions_killed ) )
    {
        level.minions_killed = 0;
    }
    
    if ( level.minion_kill_obj > 100 )
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( 0, 100 );
    }
    else
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( 0, level.minion_kill_obj );
    }
    
    function_7051cb86bab546da();
    
    if ( level.minion_kill_obj > 100 )
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( 100, 100 );
    }
    else
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( level.minion_kill_obj, level.minion_kill_obj );
    }
    
    wait 0.5;
    level utility::flag_set( "flag_killstreak_frenzy_complete" );
    level utility::flag_clear( "flag_killcount_event" );
    level notify( #"hash_aefc5c470125baf8" );
    end_of_round_fanfare( undefined, "nm_wave_complete" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xc31cbac2, Offset: 0x6eff
// Size: 0x22c
function function_7051cb86bab546da()
{
    nightmare_splash( "nm_wave_threat_start" );
    level thread play_spawn_smoke( "first_wave_smoke", "flag_killcount_round_1_done" );
    round = 1;
    thread minion_encounter( "encounter_nm_jungle_activity_first_wave", "flag_killcount_round_1_done", undefined, 3 );
    
    while ( level.minions_killed < level.minion_kill_obj / 3 )
    {
        waitframe();
    }
    
    level notify( #"hash_f8318a5d48451de5" );
    waitframe();
    level utility::flag_set( "flag_killcount_round_1_done" );
    var_ad30c944bbd232d7 = 1.5;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
    nightmare_splash( "nm_wave_threat_end" );
    wait 8;
    level utility::flag_set( "flag_killcount_event" );
    waitframe();
    level utility::flag_set( "flag_enable_super_sprint" );
    nightmare_splash( "nm_wave_threat_start" );
    level thread play_spawn_smoke( "second_wave_smoke", "flag_killcount_round_2_done" );
    round = 2;
    thread minion_encounter( "encounter_nm_jungle_activity_second_wave", "flag_killcount_round_2_done", undefined, 3 );
    
    while ( level.minions_killed < 0.666667 * level.minion_kill_obj )
    {
        waitframe();
    }
    
    level notify( #"hash_f8318a5d48451de5" );
    waitframe();
    level utility::flag_clear( "flag_enable_super_sprint" );
    level utility::flag_set( "flag_killcount_round_2_done" );
    var_ad30c944bbd232d7 = 1.5;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
    nightmare_splash( "nm_wave_threat_end" );
    wait 8;
    level utility::flag_set( "flag_killcount_event" );
    nightmare_splash( "nm_wave_threat_start" );
    level thread play_spawn_smoke( "first_wave_smoke", "flag_killcount_round_3_done" );
    level thread play_spawn_smoke( "second_wave_smoke", "flag_killcount_round_3_done" );
    level thread function_584503c73da6c757( "first_wave_smoke", "sat_spawner_zombie_mangler_ob" );
    level thread function_584503c73da6c757( "second_wave_smoke", "sat_spawner_zombie_mangler_ob" );
    round = 3;
    thread minion_encounter( "encounter_nm_jungle_activity_final_wave", "flag_killcount_round_3_done", undefined, 3 );
    
    while ( level.minions_killed < level.minion_kill_obj )
    {
        waitframe();
    }
    
    level notify( #"hash_f8318a5d48451de5" );
    waitframe();
    level utility::flag_set( "flag_killcount_round_3_done" );
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x48f24a85, Offset: 0x7133
// Size: 0xca
function play_spawn_smoke( struct, flag_to_end, vfx_name = "spawn_smoke" )
{
    offset = ( 0, 0, 0 );
    wave_smoke = utility::getstruct( struct, "targetname" );
    
    if ( !isdefined( wave_smoke ) )
    {
        return;
    }
    
    tag = utility::function_1808878d1c511ce8( wave_smoke.origin + offset, wave_smoke.angles );
    playfxontag( level._effect[ vfx_name ], tag, "tag_origin" );
    level utility::flag_wait( flag_to_end );
    stopfxontag( level._effect[ vfx_name ], tag, "tag_origin" );
    tag delete();
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x8c5ae7bc, Offset: 0x7205
// Size: 0x6a
function function_c840b1ed9fc15180( ent, flag_to_end, vfx_name = "spawn_smoke" )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    playfxontag( level._effect[ vfx_name ], ent, "tag_origin" );
    level utility::flag_wait( flag_to_end );
    stopfxontag( level._effect[ vfx_name ], ent, "tag_origin" );
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x627c0dfc, Offset: 0x7277
// Size: 0xab
function function_584503c73da6c757( var_dc6a4b4b351da087, spawner, delay = 3 )
{
    struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    wait delay;
    mauler = mp_agent::spawnnewagentaitype( spawner, struct.origin, struct.angles, "team_two_hundred" );
    playfx( level._effect[ "enemy_vfx" ], struct.origin + ( 0, 0, 32 ) );
    mauler thread individual_vanish( "flag_killcount_round_3_done" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xda3e6570, Offset: 0x732a
// Size: 0x75
function start_remote_robot()
{
    player = self;
    player val::set( "remote_robot", "damage", 0 );
    player utility::delaythread( 5, &val::reset, "remote_robot", "damage" );
    streakinfo = killstreak_utility::createstreakinfo( "remote_robot", player );
    player remote_robot::function_f71b4ae9d3d63954( streakinfo );
    player.is_in_remote_robot = 1;
    player thread post_remote_robot_invulnerability();
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xdd74099b, Offset: 0x73a7
// Size: 0xcf
function end_remote_robot( wait_time )
{
    wait 10;
    
    foreach ( player in level.players )
    {
        var_ad30c944bbd232d7 = 1.5;
        
        if ( player.is_in_remote_robot )
        {
            level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
            player thread juggernaut::jugg_removejuggernaut();
            player.is_in_remote_robot = 0;
        }
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x6258d81, Offset: 0x747e
// Size: 0x11
function stop_stream()
{
    wait 20;
    level notify( #"hash_88a5c9221727633d" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x261cb455, Offset: 0x7497
// Size: 0x80
function start_hellstorm()
{
    player = self;
    player thread individual_stream( player.origin );
    player val::set( "hellstorm_missile", "damage", 0 );
    player utility::delaythread( 15, &val::reset_all, "hellstorm_missile" );
    streakinfo = killstreak_utility::createstreakinfo( "hellstorm_missile", player );
    player hellstorm_missile::function_1562fb0708734323( streakinfo, player.origin );
    level thread stop_stream();
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xa76229f6, Offset: 0x751f
// Size: 0x75
function start_vtol_warship()
{
    player = self;
    player thread individual_stream( player.origin );
    player val::set( "vtol_warship", "damage", 0 );
    player utility::delaythread( 5, &val::reset_all, "vtol_warship" );
    streakinfo = killstreak_utility::createstreakinfo( "vtol_warship", player );
    player vtol_warship::function_f912c4bac1ef4021( streakinfo );
    level thread stop_stream();
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x9cb82b96, Offset: 0x759c
// Size: 0x46
function post_remote_robot_invulnerability()
{
    player = self;
    player waittill( #"remote_robot_ended" );
    player val::set( "post_remote_robot", "damage", 0 );
    player utility::delaythread( 5, &val::reset_all, "post_remote_robot" );
}

// Namespace ob_nm_mode
// Params 7
// Checksum 0x5f4c30e4, Offset: 0x75ea
// Size: 0x548
function function_bad3def5cf63c2b9( var_fcb964ac6f23a112, var_e04c0425c57a325, radius = 1500, main_boss = "sat_spawner_zombie_mimic_ob", static_circle = undefined, team = "team_two_hundred", fast_circle = 0 )
{
    start_of_round_fanfare( "nm_overlord_boss_start", "nm_boss_start" );
    self.var_9be376218db54aba = "sat_ob_objectivemarker_nm_big_boss";
    var_fcb964ac6f23a112 = utility::getstruct( var_fcb964ac6f23a112, "targetname" );
    var_e04c0425c57a325 = utility::getstructarray( var_e04c0425c57a325, "targetname" );
    var_e04c0425c57a325 = arrayrandomize( var_e04c0425c57a325 );
    level utility::flag_clear( "nightmare_encouter_done" );
    ob_story_mission_utils::objective_text_show( %"hash_1d6c1f3ae5d084d5" );
    num_bosses = 1;
    level.nm_bosses = num_bosses;
    level.var_ff552d2355510bb7 = 0;
    wait 1;
    
    if ( isdefined( static_circle ) )
    {
        if ( fast_circle == 1 )
        {
            circle_move_time = 8;
        }
        else
        {
            circle_move_time = 20;
        }
        
        var_9a7b20e173174021 = 6000;
        circle = function_21689e5c8bddd87c( var_fcb964ac6f23a112.origin, var_9a7b20e173174021 );
        circle brcirclemoveto( var_fcb964ac6f23a112.origin[ 0 ], var_fcb964ac6f23a112.origin[ 1 ], radius, circle_move_time );
        level thread update_minimap_circle( circle, var_fcb964ac6f23a112.origin, var_fcb964ac6f23a112.origin, var_9a7b20e173174021, radius, circle_move_time );
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( var_fcb964ac6f23a112.origin, 24 );
        wait circle_move_time;
        ob_story_mission_utils::mission_objective_marker_clear( obj_id );
    }
    
    time_modifier = function_3fc7f1f10018b737( 300 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread wave_fail_timer( time_modifier );
    playfx( level._effect[ "enemy_vfx" ], var_e04c0425c57a325[ 0 ].origin );
    boss = mp_agent::spawnnewagentaitype( main_boss, var_e04c0425c57a325[ 0 ].origin, var_e04c0425c57a325[ 0 ].angles, team );
    level utility::flag_set( "nightmare_encouter_active" );
    
    switch ( main_boss )
    {
        case #"hash_bc3f46237cb7be49":
            level.zrex = boss;
            level.zrex setscriptablepartstate( "spawn_reveal", "spawn_reveal" );
            level thread function_7765b4716ee79fd7();
            level.zrex thread function_56c531401028d79a();
            level.zrex thread function_f27116fc277b79b6();
            level.zrex.var_4da43c6a7a1311e9 = &function_3ebc912a6dd3ee42;
            wait 1;
            level.zrex.phobos_trigger_origin makeunusable();
            break;
        case #"hash_70ba65ee4a5aafc7":
            level.razor = boss;
            level.razor allowvehiclepredictiveragdoll( 0 );
            level.razor.var_2e7cd1e5b6deabc7 = 0;
            level.razor.var_be5ccf6d16f6b59e = 1;
            level function_53d442c8454b9844();
            utility::add_fx( "war_machine_warning_startup", "vfx_sat_light_razors_warmachine_charge_up_flash" );
            utility::add_fx( "war_machine_warning_loop", "vfx_sat_light_razors_warmachine_charge_up" );
            level._effect[ "harper_slam" ] = loadfxasset( "vfx_sat_wc_vgo_boss_hand_aoe_ring_01" );
            level.razor thread function_a37dc7b93aef05bf();
            level.boss_zombie_group = ai_spawn_director::function_e19f6a00c4bb7490( "boss_zombie_spawn", 0, 1, 0, 0, 3 );
            ai_spawn_director::function_35aa3b1d92cd8207( "OnSpawned", level.boss_zombie_group, &function_b019dda3a8e747fe );
            level thread setup_healthbar( level.razor.health, level.razor.maxhealth );
            obj_id = ob_story_mission_utils::function_804834359f20ef5a( boss );
            function_2b8e3d3ae2a6414a( obj_id, 0 );
            level thread phase_tracker();
            level thread function_4874c9860b48338a();
            break;
        case #"hash_aa812e6404613b2c":
            level.callisto = boss;
            level.callisto.var_24954f14e27b448d = 0;
            level.callisto thread setup_boss_healthbar( level.callisto.health, level.callisto.maxhealth, "ob_boss_nm_callisto" );
            obj_id = ob_story_mission_utils::function_804834359f20ef5a( boss );
            function_2b8e3d3ae2a6414a( obj_id, 0 );
            break;
        default:
            break;
    }
    
    boss waittill( #"death" );
    
    if ( isdefined( obj_id ) )
    {
        ob_story_mission_utils::objective_marker_clear( obj_id );
    }
    
    level thread function_70467d6be224da52( "nm_overlord_boss_dead" );
    level notify( #"cleanup_minions" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level notify( #"hash_aefc5c470125baf8" );
    level notify( #"stop_circle" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
    
    self.var_9be376218db54aba = undefined;
    
    if ( utility::flag( "rozar_dead" ) )
    {
        utility::flag_wait( "rozar_death_done" );
    }
    
    end_of_round_fanfare( undefined, "nm_boss_end" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x49bf2bad, Offset: 0x7b3a
// Size: 0x55
function function_7aaf721ebedc051c()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage" );
        level callback::callback( "on_boss_progress_updated", { #maxhealth:self.maxhealth, #health:self.health } );
    }
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xedaa0995, Offset: 0x7b97
// Size: 0xa1
function function_21689e5c8bddd87c( v_origin, radius = 1024, var_af20df805aa22681 = 9 )
{
    level.var_f7af54e3a4e17c28 = spawnbrcircle( v_origin[ 0 ], v_origin[ 1 ], radius );
    level.var_f7af54e3a4e17c28 show();
    level.var_f7af54e3a4e17c28 game_utility::questcircle_create( "testCircle_cyan", v_origin, radius );
    level.var_f7af54e3a4e17c28 game_utility::questcircle_showtoall();
    level.ob_circle_damage_tick = var_af20df805aa22681;
    level.var_f7af54e3a4e17c28 thread circle_damage_tick();
    return level.var_f7af54e3a4e17c28;
}

// Namespace ob_nm_mode
// Params 6
// Checksum 0x86530634, Offset: 0x7c41
// Size: 0x82
function function_b8e678b7fa8c71da( circle, current_circle_struct, new_circle_struct, var_9a7b20e173174021, radius, duration )
{
    circle brcirclemoveto( new_circle_struct.origin[ 0 ], new_circle_struct.origin[ 1 ], radius, duration );
    level thread update_minimap_circle( circle, current_circle_struct.origin, new_circle_struct.origin, var_9a7b20e173174021, radius, duration );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xc8828983, Offset: 0x7ccb
// Size: 0x2b8
function circle_damage_tick()
{
    level endon( #"game_ended" );
    level endon( #"hash_4c3ae759ed22e567" );
    var_16fa12dd34d85976 = br_circle::function_60fec44444cbd5d2();
    
    while ( true )
    {
        if ( isdefined( level.var_f7af54e3a4e17c28 ) )
        {
            damagetick = level.ob_circle_damage_tick;
            
            if ( isdefined( level.circledamagemultiplier ) )
            {
                damagetick = int( damagetick * level.circledamagemultiplier );
            }
            
            if ( damagetick > 0 )
            {
                dangercircleorigin = level.var_f7af54e3a4e17c28.origin;
                dangercircleradius = level.var_f7af54e3a4e17c28.origin[ 2 ];
                
                foreach ( player in level.players )
                {
                    if ( !( isdefined( player ) && isdefined( player.origin ) ) )
                    {
                        continue;
                    }
                    
                    if ( distance2dsquared( dangercircleorigin, player.origin ) > dangercircleradius * dangercircleradius )
                    {
                        if ( isalive( player ) )
                        {
                            player notify( #"hash_5454b33220509c33" );
                            
                            if ( !isdefined( player.var_2f8b6417bc00b4a0 ) )
                            {
                                player.var_2f8b6417bc00b4a0 = gettime();
                            }
                            
                            modifieddamagetick = player br_circle::function_eaac348121cbeb8c( var_16fa12dd34d85976, damagetick );
                            
                            if ( gasmask::hasgasmask( player ) )
                            {
                                if ( gasmask::function_e949a578c3db30d( player ) )
                                {
                                    if ( !player.gasmaskequipped )
                                    {
                                        player br_circle::function_b591cdbc3dcd9112( modifieddamagetick );
                                    }
                                    
                                    player gasmask::processdamage( modifieddamagetick );
                                }
                                else if ( player.gasmaskhealth <= 0 )
                                {
                                    player playsoundtoplayer( "br_gas_mask_break_plr", player );
                                    player br_pickups::function_5375ae93bfe708df();
                                    player br_pickups::function_219547e563ff9527();
                                }
                                else
                                {
                                    if ( isdefined( level.var_548004405d16dcf8 ) )
                                    {
                                        player [[ level.var_548004405d16dcf8 ]]( "aether_gas" );
                                    }
                                    
                                    player gasmask::processdamage( modifieddamagetick );
                                }
                            }
                            else
                            {
                                player br_circle::function_b591cdbc3dcd9112( modifieddamagetick );
                            }
                        }
                        else
                        {
                            player.var_2f8b6417bc00b4a0 = undefined;
                        }
                        
                        continue;
                    }
                    
                    player.var_2f8b6417bc00b4a0 = undefined;
                    
                    if ( gasmask::hasgasmask( player ) )
                    {
                        if ( gasmask::function_e949a578c3db30d( player ) )
                        {
                            continue;
                        }
                        
                        if ( player.gasmaskhealth <= 0 )
                        {
                            player playsoundtoplayer( "br_gas_mask_break_plr", player );
                            player br_pickups::function_5375ae93bfe708df();
                            continue;
                        }
                        
                        player br_pickups::gasmaskoff( "br_circle" );
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ob_nm_mode
// Params 6
// Checksum 0xd9c0a522, Offset: 0x7f8b
// Size: 0x139
function update_minimap_circle( circle, start_pos, end_pos, var_9a7b20e173174021, var_86491b20c248f26, duration )
{
    assert( isdefined( circle.mapcircle ), "<dev string:x6c>" );
    assert( var_86491b20c248f26 > 0, "<dev string:xb9>" );
    assert( var_9a7b20e173174021 > 0, "<dev string:xb9>" );
    circle.mapcircle endon( #"death" );
    circle endon( #"death" );
    circle endon( #"hash_13f6e13328c0a077" );
    start_time = gettime();
    end_time = gettime() + duration * 1000;
    
    while ( gettime() < end_time )
    {
        frac = math::lerp_fraction( start_time, end_time, gettime() );
        radius = math::lerp( var_9a7b20e173174021, var_86491b20c248f26, frac );
        
        if ( isdefined( start_pos ) && isdefined( end_pos ) )
        {
            pos = vectorlerp( start_pos, end_pos, frac );
            circle game_utility::questcircle_move( pos );
        }
        
        circle game_utility::function_d46d8731ed9d281( radius );
        wait 0.05;
    }
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0xf9f8e9e8, Offset: 0x80cc
// Size: 0x246
function circle_loop( current_struct, radius, circle_move_time = 10, circle_hold_time = 10 )
{
    level endon( #"stop_circle" );
    level endon( #"stop_meander" );
    var_897ead34f1758f70 = utility::getstruct( current_struct.target, "targetname" );
    var_c5e9b188b4b8af3e = utility::getstruct( var_897ead34f1758f70.target, "targetname" );
    circle = self;
    circle_location = var_897ead34f1758f70;
    wait circle_hold_time;
    
    while ( true )
    {
        if ( !level utility::flag( var_c5e9b188b4b8af3e.script_noteworthy ) && circle_location != var_c5e9b188b4b8af3e )
        {
            nightmare_splash( "nm_circle_moving" );
            
            if ( isdefined( level.circle_obj_id ) )
            {
                level.nm_activity_instance ob_story_mission_utils::objective_marker_clear( level.circle_obj_id );
            }
            
            wait 5;
            circle brcirclemoveto( var_c5e9b188b4b8af3e.origin[ 0 ], var_c5e9b188b4b8af3e.origin[ 1 ], radius, circle_move_time );
            level thread update_minimap_circle( circle, circle_location.origin, var_c5e9b188b4b8af3e.origin, radius, radius, circle_move_time );
            level.circle_obj_id = level.nm_activity_instance ob_story_mission_utils::function_b9cb179f9577f32a( var_c5e9b188b4b8af3e.origin );
            wait circle_move_time + circle_hold_time;
            circle_location = var_c5e9b188b4b8af3e;
        }
        
        if ( !level utility::flag( var_897ead34f1758f70.script_noteworthy ) && circle_location != var_897ead34f1758f70 )
        {
            nightmare_splash( "nm_circle_moving" );
            
            if ( isdefined( level.circle_obj_id ) )
            {
                level.nm_activity_instance ob_story_mission_utils::objective_marker_clear( level.circle_obj_id );
            }
            
            wait 5;
            circle brcirclemoveto( var_897ead34f1758f70.origin[ 0 ], var_897ead34f1758f70.origin[ 1 ], radius, circle_move_time );
            level thread update_minimap_circle( circle, circle_location.origin, var_897ead34f1758f70.origin, radius, radius, circle_move_time );
            level.circle_obj_id = level.nm_activity_instance ob_story_mission_utils::function_b9cb179f9577f32a( var_897ead34f1758f70.origin );
            wait circle_move_time + circle_hold_time;
            circle_location = var_897ead34f1758f70;
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 5
// Checksum 0x82c8aacf, Offset: 0x831a
// Size: 0x6f
function nightmare_transition( flag_name, index, do_transition, var_ad30c944bbd232d7 = 1, delay )
{
    if ( isdefined( flag_name ) )
    {
        level utility::flag_wait( flag_name );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xd2b5d3a9, Offset: 0x8391
// Size: 0x29
function nightmare_transition_off( flag_name )
{
    if ( isdefined( flag_name ) )
    {
        level utility::flag_wait( flag_name );
    }
    
    level thread ob_story_mission_utils::function_ecbb860d6714e9f3( 0, 1, 1 );
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0xfcaf73b5, Offset: 0x83c2
// Size: 0x330
function nightmare_teleport( location, ref )
{
    level thread transition_stream( ob_story_mission_utils::get_activity_starts( location )[ 0 ].origin );
    ob_gametype_story_mission::function_b69ee4ccc5e7a2ae( location );
    
    foreach ( player in level.players )
    {
        player ob::function_2b9dde49097a039e();
    }
    
    wait 5;
    
    if ( isdefined( ref ) )
    {
        function_70467d6be224da52( ref );
    }
    
    nightmare_splash( "nm_sector_end" );
    ob_story_mission_utils::objective_text_show( %"hash_6ccba38da51dc48a" );
    wait 10;
    var_ad30c944bbd232d7 = 1.5;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
    
    foreach ( player in level.players )
    {
        player notify( #"teleport_finished" );
        player val::set( "nightmare_teleport", "allow_movement", 0 );
        player val::set( "nightmare_teleport", "allow_teleport", 0 );
        player val::set( "nightmare_teleport", "allow_gadgets", 0 );
        player utility::delaythread( 3, &val::reset_all, "nightmare_teleport" );
    }
    
    wait var_ad30c944bbd232d7;
    level thread function_b2df4178a4626376();
    waitframe();
    level notify( #"hash_f72ef04e6918916a" );
    structs = ob_story_mission_utils::get_activity_starts( location );
    level coop::play_cinematic( "sat_nm_wormhole", { #timeout:1, #teleportdelay:1, #fadeendshader:"white", #fadestartshader:"none", #fadestartnone:1, #countdown:0, #skip:0, #structs:structs } );
    
    foreach ( player in level.players )
    {
        player lerpfovbypreset( "default_200ms" );
        player clearpredictedstreampos();
        pbgpostfxbundlestart( player, %"sat_ob_cradle_portal_out" );
    }
    
    ob_story_mission_utils::function_94bd9141862a4ba6( level.players );
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
    level notify( #"hash_88a5c9221727633d" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x5cdbef17, Offset: 0x86fa
// Size: 0xad
function function_b2df4178a4626376()
{
    foreach ( player in level.players )
    {
        if ( player vehicle::is_in_vehicle() )
        {
            vehicle = player vehicle::get_vehicle();
            seat = vehicle_occupancy::get_occupant_seat( vehicle, player );
            vehicle_occupancy::exit( vehicle, seat, player );
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x8c1db38d, Offset: 0x87af
// Size: 0xb1
function transition_stream( origin )
{
    self notify( #"hash_90f2f8645e51e10c" );
    self endon( #"hash_90f2f8645e51e10c" );
    level endon( #"hash_88a5c9221727633d" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            player predictstreamposuntilcleared( origin );
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x8ea7aab, Offset: 0x8868
// Size: 0x35
function individual_stream( origin )
{
    self endon( #"death" );
    level endon( #"hash_88a5c9221727633d" );
    
    while ( true )
    {
        self predictstreamposuntilcleared( origin );
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x4eba86d, Offset: 0x88a5
// Size: 0xd9
function reward_objective( alias )
{
    agents = getaiarray();
    
    foreach ( var_9413a6189a45c7de in agents )
    {
        var_9413a6189a45c7de kill();
    }
    
    function_70467d6be224da52( "nm_overlord_glitch_end_1" );
    ob_story_mission_utils::objective_text_show( %"hash_74b4e6a072e34d04" );
    wait 5;
    nightmare_splash( "nm_reward_area" );
    wait 5;
    ui::lui_registercallback( "splash_hidden", &function_710bf270533aeaae );
    
    if ( isdefined( alias ) )
    {
        level thread overlord::playconversation( alias );
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x137ea3ed, Offset: 0x8986
// Size: 0x84
function nightmare_score_event()
{
    foreach ( player in level.players )
    {
        player points::doscoreevent( #"wc_nightmare_step_complete" );
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xfc023270, Offset: 0x8a12
// Size: 0x2a
function private function_710bf270533aeaae( param )
{
    level thread ob_story_mission_utils::function_c49b55e09c319e01( level.players, level.chest_time_remaining ?? 0 );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x296e42a, Offset: 0x8a44
// Size: 0x3e
function nightmare_prepare( timer = 10 )
{
    ob_story_mission_utils::objective_text_show( %"hash_5d225874b0380a76" );
    wait timer;
    ob_story_mission_utils::function_94bd9141862a4ba6( level.players );
    wait 0.5;
}

// Namespace ob_nm_mode
// Params 5
// Checksum 0xb1d5aad8, Offset: 0x8a8a
// Size: 0x300
function capture_zone_event( struct_array_name, minion_encounter_name, random_faction = 0, special_enemies = [], objective_asset )
{
    start_of_round_fanfare( "nm_overlord_capture_start", undefined, undefined );
    obj = objective_asset ?? %"hash_3cff3470e9aafa2b";
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = function_3fc7f1f10018b737( 300 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread wave_fail_timer( time_modifier );
    waitframe();
    zones_captured = 0;
    ob_story_mission_utils::function_315d79883d962ba7( zones_captured, 3 );
    level utility::flag_clear( "flag_capture_zone_event_complete" );
    level utility::flag_set( "nightmare_encouter_active" );
    a_structs = utility::getstructarray( struct_array_name, "targetname" );
    a_structs = arrayrandomize( a_structs );
    a_structs = function_628bac9faa9d1e86( a_structs, a_structs[ 0 ].origin );
    a_cap_points = [ a_structs[ 0 ], a_structs[ 4 ], a_structs[ 2 ] ];
    thread minion_encounter( minion_encounter_name, "flag_capture_zone_event_complete", random_faction );
    
    for ( i = 0; i < 3 ; i++ )
    {
        function_70467d6be224da52( "nm_overlord_capture_next" );
        nightmare_splash( "nm_capture_zone_start" );
        capture_struct = function_b484cb1cc50eab74( a_cap_points[ i ], "nightmare_capture_zone_" + i );
        
        if ( isarray( special_enemies ) )
        {
            if ( isdefined( special_enemies[ i ] ) )
            {
                spawn_pos = getclosestpointonnavmesh( capture_struct.origin );
                playfx( level._effect[ "enemy_vfx" ], spawn_pos );
                extra_dude = mp_agent::spawnnewagentaitype( special_enemies[ i ], spawn_pos, capture_struct.angles, "team_hundred_ninety" );
                extra_dude thread individual_vanish( "flag_capture_zone_event_complete" );
            }
        }
        
        level.nm_activity_instance mission_ui::function_d84701041f6f95c2( 1, 0, 100 );
        capture_zone_segment( capture_struct, "flag_capture_complete" + i, 1 );
        level.nm_activity_instance mission_ui::function_d84701041f6f95c2( 1, 100, 100 );
        zones_captured++;
        ob_story_mission_utils::function_315d79883d962ba7( zones_captured, 3 );
        
        if ( isdefined( level.cadence_override ) )
        {
            level.cadence_override -= 0.5;
            level.cadence_override = clamp( level.cadence_override, 0.5, 4 );
            
            if ( isdefined( level.var_c48036a3bf28dd4f ) )
            {
                function_a748fd0f51127844( level.var_c48036a3bf28dd4f, level.cadence_override );
            }
        }
        
        if ( zones_captured == 3 )
        {
            continue;
        }
        
        nightmare_splash( "nm_capture_zone_end" );
        wait 5;
    }
    
    wait 2;
    level notify( #"hash_aefc5c470125baf8" );
    level notify( #"cleanup_minions" );
    level utility::flag_set( "flag_capture_zone_event_complete" );
    level utility::flag_clear( "nightmare_encouter_active" );
    end_of_round_fanfare( "nm_overlord_capture_end", "nm_capture_zone_complete" );
}

// Namespace ob_nm_mode
// Params 6
// Checksum 0x48c995c9, Offset: 0x8d92
// Size: 0x381
function function_3c06bea68f7652a6( center_circle, struct_array_name, var_f7c77935af8470ec, special_enemy_array, random_faction = 0, objective_asset )
{
    start_of_round_fanfare( "nm_overlord_capture_start", undefined, undefined );
    obj = objective_asset ?? %"hash_3cff3470e9aafa2b";
    level utility::flag_set( "flag_multi_capture_event" );
    level utility::flag_set( "nightmare_encouter_active" );
    var_55fb678e1d94c474 = utility::getstruct( struct_array_name[ 0 ], "targetname" );
    var_55fb688e1d94c6a7 = utility::getstruct( struct_array_name[ 1 ], "targetname" );
    a_structs = [ var_55fb678e1d94c474, var_55fb688e1d94c6a7 ];
    level.zones_captured = 0;
    struct = utility::getstruct( center_circle );
    
    if ( isdefined( struct ) )
    {
        var_9a7b20e173174021 = 4000;
        radius = 2000;
        circle = function_21689e5c8bddd87c( struct.origin, var_9a7b20e173174021 );
        circle brcirclemoveto( struct.origin[ 0 ], struct.origin[ 1 ], radius, 5 );
        level thread update_minimap_circle( circle, struct.origin, struct.origin, var_9a7b20e173174021, radius, 5 );
    }
    
    wait 5;
    thread minion_encounter( var_f7c77935af8470ec[ 0 ], a_structs[ 0 ].script_noteworthy, random_faction );
    thread minion_encounter( var_f7c77935af8470ec[ 1 ], a_structs[ 1 ].script_noteworthy, random_faction );
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = function_3fc7f1f10018b737( 300 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread wave_fail_timer( time_modifier );
    zones_captured = 0;
    ob_story_mission_utils::function_315d79883d962ba7( zones_captured, 2 );
    
    if ( isdefined( special_enemy_array ) )
    {
        for ( i = 0; i < a_structs.size ; i++ )
        {
            if ( isdefined( special_enemy_array[ i ] ) )
            {
                spawn_pos = getclosestpointonnavmesh( a_structs[ i ].origin + ( randomfloatrange( -128, 128 ), randomfloatrange( -128, 128 ), 0 ) );
                playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
                extra_dude = mp_agent::spawnnewagentaitype( special_enemy_array[ i ], spawn_pos, a_structs[ i ].angles, "team_hundred_ninety" );
                extra_dude thread individual_vanish( "flag_capture_zone_event_complete" );
            }
        }
    }
    
    nightmare_splash( "nm_capture_zone_start" );
    level thread function_74ec1163b0a276ce( a_structs[ 0 ], a_structs[ 1 ] );
    
    for ( i = 0; i < a_structs.size ; i++ )
    {
        thread capture_zone_instance( a_structs[ i ], i + 1 );
    }
    
    while ( level.zones_captured < 2 )
    {
        waitframe();
    }
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
    
    nightmare_splash( "nm_capture_zone_end" );
    level.zones_captured = 0;
    level notify( #"hash_aefc5c470125baf8" );
    level notify( #"cleanup_minions" );
    level notify( #"stop_circle" );
    level utility::flag_set( "flag_capture_zone_event_complete" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_clear( "flag_multi_capture_event" );
    end_of_round_fanfare( "nm_overlord_capture_end", "nm_capture_zone_complete" );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xed2c0994, Offset: 0x911b
// Size: 0x103
function function_e8685503a125727a( var_e2e1e646166d2536 )
{
    start_circle_move_time = 5;
    radius = 1200;
    var_9a7b20e173174021 = 4096;
    circle = function_21689e5c8bddd87c( var_e2e1e646166d2536.origin, var_9a7b20e173174021 );
    circle brcirclemoveto( var_e2e1e646166d2536.origin[ 0 ], var_e2e1e646166d2536.origin[ 1 ], radius, start_circle_move_time );
    level thread update_minimap_circle( circle, var_e2e1e646166d2536.origin, var_e2e1e646166d2536.origin, var_9a7b20e173174021, radius, start_circle_move_time );
    wait start_circle_move_time;
    current_struct = var_e2e1e646166d2536;
    circle thread circle_loop( current_struct, radius, 15, 10 );
    level utility::flag_wait( "flag_capture_zone_event_complete" );
    level.nm_activity_instance ob_story_mission_utils::objective_marker_clear( level.circle_obj_id );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xcb55a7c9, Offset: 0x9226
// Size: 0x105
function capture_zone_instance( point, sub_objective_index, obj_marker_name )
{
    capture_struct = function_b484cb1cc50eab74( point, point.script_noteworthy );
    capture_zone_segment( capture_struct, point.script_noteworthy, sub_objective_index );
    
    if ( isdefined( level.zones_captured ) )
    {
        level.zones_captured++;
        
        if ( level.zones_captured < 2 )
        {
            nightmare_splash( "nm_capture_zone_end" );
        }
        
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( level.zones_captured, 2 );
    }
    else if ( level utility::flag( "flag_killcount_event" ) )
    {
        if ( !isdefined( level.ks_earned_count ) )
        {
            level.ks_earned_count = 0;
        }
        
        level.ks_earned_count++;
        
        if ( !level utility::flag( "flag_killstreak_frenzy_complete" ) )
        {
            waitframe();
            nightmare_splash( "nm_ks_earned" );
        }
    }
    
    level.nm_activity_instance mission_ui::function_d84701041f6f95c2( sub_objective_index, 100, 100 );
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xbbad8066, Offset: 0x9333
// Size: 0x127
function function_74ec1163b0a276ce( var_55fb688e1d94c6a7, struct_2, enemy_type = "sat_ob_enemy_cradle_hvt_jugg_minigun" )
{
    level utility::flag_wait_any( var_55fb688e1d94c6a7.script_noteworthy, struct_2.script_noteworthy );
    
    if ( !level utility::flag( var_55fb688e1d94c6a7.script_noteworthy ) )
    {
        spawn_pos = var_55fb688e1d94c6a7.origin;
        playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
        extra_dude = mp_agent::spawnnewagentaitype( enemy_type, spawn_pos, var_55fb688e1d94c6a7.angles, "team_hundred_ninety" );
        extra_dude thread individual_vanish( "flag_capture_zone_event_complete" );
        return;
    }
    
    spawn_pos = struct_2.origin;
    playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
    extra_dude = mp_agent::spawnnewagentaitype( enemy_type, spawn_pos, struct_2.angles, "team_hundred_ninety" );
    extra_dude thread individual_vanish( "flag_capture_zone_event_complete" );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x494d9236, Offset: 0x9462
// Size: 0x104
function wave_fail_timer( timer )
{
    level endon( #"hash_aefc5c470125baf8" );
    wait timer - 90;
    thread nightmare_splash( "nm_end_90_seconds" );
    thread function_70467d6be224da52( "nm_overlord_timer_90" );
    wait 30;
    thread nightmare_splash( "nm_end_60_seconds" );
    thread function_70467d6be224da52( "nm_overlord_timer_60" );
    wait 30;
    thread nightmare_splash( "nm_end_30_seconds" );
    thread function_70467d6be224da52( "nm_overlord_timer_30" );
    wait 30;
    function_70467d6be224da52( "nm_overlord_timer_done" );
    
    if ( getdvarint( @"hash_e84ea0d344a80ce3", 0 ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player kill();
    }
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x27dd7e57, Offset: 0x956e
// Size: 0xaf
function function_b484cb1cc50eab74( struct, capture_name )
{
    capture_struct = spawnstruct();
    capture_struct.struct = struct;
    vols = getnoentvolumearray( struct.target, "targetname" );
    
    if ( isdefined( vols ) )
    {
        capture_struct.vol = vols[ 0 ];
    }
    
    capture_struct.origin = struct.origin;
    capture_struct.angles = ( 0, 0, 0 );
    capture_struct.targetname = capture_name;
    utility::addstruct( capture_struct );
    return capture_struct;
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0xb99c2450, Offset: 0x9626
// Size: 0x162
function capture_zone_segment( capture_struct, flag_name, var_62499c7b56d89a2c = 1, radius )
{
    level.nightmare_minions = utility::array_removedead_or_dying( level.nightmare_minions );
    
    foreach ( minion in level.nightmare_minions )
    {
        if ( isdefined( capture_struct.vol ) && function_8b22711cacde4bb5( minion ) )
        {
            minion setgoalvolumeauto( capture_struct.vol );
            continue;
        }
        
        minion setgoalpos( capture_struct.origin, 512 );
    }
    
    if ( radius )
    {
        capture_struct.radius = radius;
    }
    
    cap_zone = thread function_9b6adf1cce23cc19( capture_struct, flag_name, var_62499c7b56d89a2c );
    snd::play( "uin_sat_nightmare_capture_spawn", capture_struct.origin );
    level utility::flag_wait_any( flag_name, "flag_stop_all_capture_zones" );
    
    if ( level utility::flag( "flag_stop_all_capture_zones" ) )
    {
        cap_zone ob_capture_zone::capture_zone_complete();
    }
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x114cf150, Offset: 0x9790
// Size: 0x161
function function_9b6adf1cce23cc19( ent, flag, var_62499c7b56d89a2c = 1 )
{
    ent.complete_flag = flag;
    radius = ent.radius ?? 196;
    additional_data = spawnstruct();
    additional_data.var_fc86768f71aa63d1 = 2048;
    additional_data.var_8f04646f7f1bd1da = "none";
    scalar = level.capture_scalar ?? 15;
    var_c61a2284c5526ca0 = 30 + level.players.size * scalar;
    capture_zone = ob_capture_zone::function_40df18d63bc4331a( ent.targetname, self, undefined, var_c61a2284c5526ca0, 1.33, 1.66, 2, 0, undefined, additional_data );
    capture_zone.obj_id = capture_zone.activity_instance ob_story_mission_utils::function_b9cb179f9577f32a( ent.origin, 72 );
    capture_zone ob_capture_zone::function_732739bf2b9ef79f( "CALLBACK_CAPTURE_ZONE_COMPLETE", &zoneonuse );
    level.current_capture_zone = ent;
    function_2b8e3d3ae2a6414a( capture_zone.obj_id, 0 );
    thread ob_capture_zone::function_7d67c057ae88b5a0( capture_zone, radius, 1 );
    
    if ( level utility::flag( "flag_multi_capture_event" ) )
    {
        thread function_fd75703329846a16( capture_zone, var_62499c7b56d89a2c, flag );
    }
    
    return capture_zone;
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x6156e528, Offset: 0x98fa
// Size: 0x54
function function_fd75703329846a16( capture_zone, sub_objective_index, end_flag )
{
    capture_zone.var_62e46f7d044c1a4f = 0;
    level.nm_activity_instance mission_ui::function_d84701041f6f95c2( sub_objective_index, 0, 100 );
    level.nm_activity_instance thread function_ffbab50a1d2b128f( capture_zone, sub_objective_index, end_flag );
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xc30bc325, Offset: 0x9956
// Size: 0x81
function function_ffbab50a1d2b128f( capture_zone, sub_objective_index, end_flag )
{
    while ( !level utility::flag( end_flag ) )
    {
        if ( isdefined( capture_zone.var_62e46f7d044c1a4f ) )
        {
            cur_progress = int( floor( capture_zone.var_62e46f7d044c1a4f * 100 ) );
            
            /#
                iprintln( cur_progress );
            #/
            
            level.nm_activity_instance mission_ui::function_d84701041f6f95c2( sub_objective_index, cur_progress, 100 );
        }
        
        wait 1;
    }
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0x7b89869f, Offset: 0x99df
// Size: 0x39
function private zoneenter( capture_zone, ent )
{
    capture_zone.activity_instance ob_story_mission_utils::mission_objective_marker_show( capture_zone.obj_id, [ ent ] );
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0x96dc667, Offset: 0x9a20
// Size: 0x39
function private zoneexit( capture_zone, ent )
{
    capture_zone.activity_instance ob_story_mission_utils::mission_objective_marker_hide( capture_zone.obj_id, [ ent ] );
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x8e4e9e4e, Offset: 0x9a61
// Size: 0xb6
function private zoneonuse( capture_zone )
{
    level notify( #"hash_c843da3ea08b0512" );
    level notify( #"zone_captured" );
    level utility::flag_set( self.complete_flag );
    
    foreach ( chevron in self.zone_chevrons )
    {
        chevron setscriptablepartstate( "chevron", "off" );
    }
}

// Namespace ob_nm_mode
// Params 6
// Checksum 0x81dae2ea, Offset: 0x9b1f
// Size: 0x1f8
function minion_encounter( encounter_targetname, flag_to_end, random_faction = 0, cadence = 1.75, var_4ce2be89357100be, track_progress = 1 )
{
    if ( random_faction )
    {
        var_6d73ad8f5f595d84 = [];
        var_6d73ad8f5f595d84[ var_6d73ad8f5f595d84.size ] = "nm_minion_cradle";
        var_6d73ad8f5f595d84[ var_6d73ad8f5f595d84.size ] = "nm_minion_zombie";
        var_6d73ad8f5f595d84[ var_6d73ad8f5f595d84.size ] = "nm_minion_guild";
        encounter_flag = utility::array_random( var_6d73ad8f5f595d84 );
        
        /#
            iprintlnbold( encounter_flag );
        #/
        
        function_a25acb62ddab20e2( encounter_flag, 1 );
    }
    
    var_fb14724f5fad775f = level.enemy_count_array ?? [ 8, 12, 16, 20 ];
    count = set_enemy_count( var_fb14724f5fad775f );
    level.nightmare_minions = [];
    level utility::flag_clear( "flag_minion_bucket_spawned" );
    level.var_d943d51220b7e510 = count;
    respawn_cadence = level.cadence_override ?? cadence;
    request_id = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    level.var_c48036a3bf28dd4f = request_id;
    function_bbd192652d1a9e18( request_id, count );
    function_a748fd0f51127844( request_id, respawn_cadence );
    ai_spawn_director::add_spawned_callback( request_id, &minion_vanish, flag_to_end );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( request_id, &should_refill, count );
    activity_ai_encounters::function_d33de057e760c97b( request_id, &function_ac2c0e91632a8300, flag_to_end );
    activity_ai_encounters::function_6bf4ff2fbde584ee( request_id, &minion_bucket_spawned, self );
    function_ef57f478f96b050c( request_id, 1 );
    level utility::flag_wait( "flag_minion_bucket_spawned" );
    
    if ( track_progress )
    {
        activity_progress_tracking::function_82d854bb84c20512( encounter_targetname, level.nightmare_minions, &function_6dd7e1ab5af8dfca );
    }
    
    level utility::flag_wait( flag_to_end );
    function_17ee483eb76a9759( request_id );
    level.current_capture_zone = undefined;
    
    if ( isdefined( encounter_flag ) )
    {
        function_a25acb62ddab20e2( encounter_flag, 0 );
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xd0ed155f, Offset: 0x9d1f
// Size: 0x65
function update_ai_count( var_58a43cb986e93fd1 )
{
    var_fb14724f5fad775f = level.enemy_count_array ?? [ 8, 12, 16, 20 ];
    count = set_enemy_count( var_fb14724f5fad775f );
    count += var_58a43cb986e93fd1;
    function_bbd192652d1a9e18( level.var_c48036a3bf28dd4f, count );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x11e3a26c, Offset: 0x9d8c
// Size: 0xb0
function minion_counter()
{
    level endon( #"hash_f8318a5d48451de5" );
    self waittill( #"death" );
    level.minions_killed++;
    
    /#
        iprintln( level.minions_killed );
    #/
    
    if ( level.minion_kill_obj <= 100 )
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( level.minions_killed, level.minion_kill_obj );
        return;
    }
    
    fraction = level.minions_killed / level.minion_kill_obj;
    percent = int( fraction * 100 );
    level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( percent, 100 );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x88064b44, Offset: 0x9e44
// Size: 0x90
function set_enemy_count( var_fb14724f5fad775f )
{
    switch ( level.players.size )
    {
        case 1:
            count = var_fb14724f5fad775f[ 0 ];
            break;
        case 2:
            count = var_fb14724f5fad775f[ 1 ];
            break;
        case 3:
            count = var_fb14724f5fad775f[ 2 ];
            break;
        case 4:
            count = var_fb14724f5fad775f[ 3 ];
            break;
        default:
            count = 20;
            break;
    }
    
    return count;
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xf89149cf, Offset: 0x9edd
// Size: 0x2b
function minion_bucket_spawned( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_minion_bucket_spawned" );
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xb33d6eae, Offset: 0x9f10
// Size: 0x36
function function_6dd7e1ab5af8dfca( requestid, activity_instance, agent )
{
    level.nightmare_minions = utility::array_removedead_or_dying( level.nightmare_minions );
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0xe9e81970, Offset: 0x9f4e
// Size: 0x2a4
function minion_vanish( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    level.nightmare_minions[ level.nightmare_minions.size ] = agent;
    agent function_fa32376aaa88a7a2( agent.origin, 10000 );
    
    if ( level utility::flag( "flag_remote_robot_event" ) )
    {
        agent thread minion_damage_multiplier();
    }
    
    if ( level utility::flag( "flag_turret_round" ) )
    {
        agent thread turret_damage_multiplier();
    }
    
    if ( level utility::flag( "flag_killstreak_event" ) )
    {
        agent thread function_1ea42ea2bfd570eb();
    }
    
    if ( level utility::flag( "flag_killcount_event" ) )
    {
        agent thread minion_counter();
    }
    
    if ( level utility::flag( "power_hunt_event" ) )
    {
        agent function_90c440460dba0ba2( 0 );
    }
    
    if ( isdefined( level.minion_volume ) )
    {
        if ( function_8b22711cacde4bb5( agent ) )
        {
            agent setgoalvolumeauto( level.minion_volume );
        }
    }
    
    if ( level utility::flag( "flag_zombify_the_dead" ) )
    {
        if ( !issubstr( agent.classname, "zom" ) && !issubstr( agent.classname, "bot" ) )
        {
            agent thread spawn_zombie_on_death( userdata );
        }
    }
    
    if ( isdefined( level.current_capture_zone ) )
    {
        if ( isdefined( level.current_capture_zone.vol ) && function_8b22711cacde4bb5( agent ) )
        {
            agent setgoalvolumeauto( level.current_capture_zone.vol );
        }
    }
    
    if ( level utility::flag( "flag_enable_super_sprint" ) )
    {
        if ( issubstr( agent.classname, "zom" ) )
        {
            agent zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "super_sprint_fight", 99 );
        }
    }
    
    if ( isdefined( level.br_circle_struct ) )
    {
        if ( issubstr( agent.classname, "bot" ) )
        {
            vols = getnoentvolumearray( "nm_jungle_center_vol", "targetname" );
            
            if ( isdefined( vols ) )
            {
                vols.vol = vols[ 0 ];
            }
            
            agent setgoalvolumeauto( vols.vol );
        }
    }
    
    if ( level utility::flag( "flag_shard_round" ) )
    {
        agent thread shard_logic();
    }
    
    if ( level utility::flag( "flag_soul_event" ) )
    {
        agent thread function_5d8b6d15b5f5cda9();
    }
    
    level utility::flag_wait( userdata );
    wait randomfloatrange( 0.1, 0.3 );
    playfx( level._effect[ "enemy_vfx" ], agent.origin );
    agent kill();
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x585fd1dc, Offset: 0xa1fa
// Size: 0x9f
function spawn_zombie_on_death( var_fb271790770b79a9 )
{
    self.nocorpse = 1;
    self waittill( #"death" );
    
    if ( !level utility::flag( var_fb271790770b79a9 ) )
    {
        playfx( level._effect[ "enemy_vfx" ], self.origin );
        var_3532be4ec31fe98b = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_base_ob", self.origin, ( 0, 0, 0 ), "team_hundred_ninety" );
        var_3532be4ec31fe98b thread individual_vanish( var_fb271790770b79a9 );
        var_3532be4ec31fe98b zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "super_sprint_fight", 99 );
    }
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0xdb2e1c22, Offset: 0xa2a1
// Size: 0x96
function individual_vanish( flag_name, origin )
{
    self endon( #"death" );
    self function_fa32376aaa88a7a2( self.origin, 10000 );
    
    if ( isdefined( origin ) )
    {
        self setgoalpos( origin, 256 );
    }
    
    if ( level utility::flag( "flag_killcount_event" ) )
    {
        thread minion_counter();
    }
    
    level utility::flag_wait( flag_name );
    wait randomfloatrange( 0.1, 0.3 );
    playfx( level._effect[ "enemy_vfx" ], self.origin );
    self kill();
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x345b1810, Offset: 0xa33f
// Size: 0xf2
function minion_damage_multiplier()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon );
        
        if ( isdefined( weapon ) && weapon.basename == "sat_remote_robot_arm_gun_mp" )
        {
            damage_scalar = 20;
            scaled_damage = damage * damage_scalar;
            
            if ( self.health - scaled_damage > 0 )
            {
                self.health -= scaled_damage;
                continue;
            }
            
            self.health = 1;
        }
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xf6aa0fbf, Offset: 0xa439
// Size: 0xad
function turret_damage_multiplier()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon );
        
        if ( isdefined( weapon ) && issubstr( weapon.basename, "turret" ) )
        {
            self kill();
        }
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x5b742602, Offset: 0xa4ee
// Size: 0x128
function function_1ea42ea2bfd570eb()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon );
        
        if ( isdefined( weapon ) && is_killstreak( weapon.basename ) )
        {
            if ( weapon.basename == "sat_remote_robot_arm_gun_mp" )
            {
                damage_scalar = 20;
                scaled_damage = damage * damage_scalar;
                
                if ( self.health - scaled_damage > 0 )
                {
                    self.health -= scaled_damage;
                }
                else
                {
                    self.health = 1;
                }
                
                continue;
            }
            
            self dodamage( self.health + 100, attacker.origin, attacker );
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x4677d903, Offset: 0xa61e
// Size: 0x6f, Type: bool
function is_killstreak( weapon_name )
{
    ks_list = [];
    ks_list[ ks_list.size ] = "robot";
    ks_list[ ks_list.size ] = "storm";
    ks_list[ ks_list.size ] = "vtol";
    ks_list[ ks_list.size ] = "turret";
    
    for ( i = 0; i < ks_list.size ; i++ )
    {
        if ( issubstr( weapon_name, ks_list[ i ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x33c8aa59, Offset: 0xa696
// Size: 0x4c
function shard_logic()
{
    level endon( #"shard_event_done" );
    
    if ( should_spawn_shard( self ) )
    {
        self hudoutlineenable( "outline_nodepth_yellow" );
        thread stop_outline();
    }
    else
    {
        return;
    }
    
    self waittill( #"death" );
    level thread spawn_shard( self.origin );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xf38a4754, Offset: 0xa6ea
// Size: 0x21
function stop_outline()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_shard_event_done" );
    self hudoutlinedisable();
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0xf7137cf2, Offset: 0xa713
// Size: 0x25, Type: bool
function function_ac2c0e91632a8300( request_id, userdata )
{
    if ( level utility::flag( userdata ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x13ffafc1, Offset: 0xa741
// Size: 0x17, Type: bool
function should_refill( request_id, userdata )
{
    return true;
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x30b9cf27, Offset: 0xa761
// Size: 0x2d3
function function_3ebc912a6dd3ee42( boss, all_spawn_points )
{
    all_spawn_points = arrayrandomize( all_spawn_points );
    num_nearby_players = self.nearbyplayers.size;
    num_to_spawn = 4 * num_nearby_players;
    
    switch ( level.players.size )
    {
        case 1:
            var_dd1ec8f49d4a4046 = 12;
            break;
        case 2:
            var_dd1ec8f49d4a4046 = 16;
            break;
        case 3:
            var_dd1ec8f49d4a4046 = 20;
            break;
        case 4:
            var_dd1ec8f49d4a4046 = 24;
            break;
        default:
            var_dd1ec8f49d4a4046 = 24;
            break;
    }
    
    aitype = function_b3988325430ce242( "zombie_base" );
    
    if ( isdefined( self.var_183395a55b9ebcf4 ) )
    {
        aitype = [[ self.var_183395a55b9ebcf4 ]]();
    }
    
    while ( num_to_spawn > 0 )
    {
        foreach ( spawn_point in all_spawn_points )
        {
            if ( num_to_spawn <= 0 )
            {
                break;
            }
            
            self.phobos_spawned_zombies = function_46f9072493651dc9( self.phobos_spawned_zombies );
            
            if ( self.phobos_spawned_zombies.size < var_dd1ec8f49d4a4046 )
            {
                zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, spawn_point, ( 0, 0, 0 ), self.team );
                
                if ( isdefined( zombie ) )
                {
                    zombie thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn", "spawn_end", undefined, undefined, "spawn_animating" );
                    zombie zombie_utils::set_zombie_round_difficulty( zombie_utils::get_zombie_round_difficulty(), 1, 1 );
                    zombie utility::ent_flag_set( "phobos_spawn" );
                    
                    if ( isdefined( self.var_7b6457a80abc9e9c ) )
                    {
                        zombie.var_50c96a5c56dab386 = self.var_7b6457a80abc9e9c;
                    }
                    
                    zombie.no_powerups = 1;
                    speed = utility::cointoss() ? "run" : "walk";
                    
                    if ( isdefined( self.adds_get_speed ) )
                    {
                        speed = zombie [[ self.adds_get_speed ]]();
                    }
                    
                    zombie zombie_utils::function_a8ce00e0448cb6f0( speed, "phobos_base", 6 );
                    
                    if ( !isdefined( self.phobos_spawned_zombies ) )
                    {
                        self.phobos_spawned_zombies = [];
                    }
                    
                    self.phobos_spawned_zombies[ self.phobos_spawned_zombies.size ] = zombie;
                    params = spawnstruct();
                    params.zombie = zombie;
                    zombie callback::callback( "on_zombie_phobos_spawn_roared", params );
                    num_to_spawn--;
                }
            }
            
            wait 0.1;
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x7e128618, Offset: 0xaa3c
// Size: 0x1d8
function function_7765b4716ee79fd7()
{
    if ( isdefined( level.zrex ) )
    {
        bosshealth = level.zrex.health;
        
        switch ( level.players.size )
        {
            case 1:
                new_health = bosshealth * 0.125;
                break;
            case 2:
                new_health = bosshealth * 0.24;
                break;
            case 3:
                new_health = bosshealth * 0.3;
                break;
            case 4:
                new_health = bosshealth * 0.375;
                break;
            default:
                new_health = bosshealth * 0.15;
                break;
        }
        
        new_health = int( new_health );
        level.zrex mp_agent::set_agent_health( new_health );
    }
    
    if ( isdefined( level.razor ) )
    {
        bosshealth = level.razor.health;
        
        switch ( level.players.size )
        {
            case 1:
                new_health = 200000;
                break;
            case 2:
                new_health = 250000;
                break;
            case 3:
                new_health = 360000;
                break;
            case 4:
                new_health = 500000;
                break;
            default:
                new_health = 200000;
                break;
        }
        
        new_health = int( new_health );
        level.razor.maxhealth = new_health;
        level.razor.health = level.razor.maxhealth;
        level.razor mp_agent::set_agent_health( new_health );
    }
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x3ba688ac, Offset: 0xac1c
// Size: 0x62
function function_1f2648b3b22d9816( timer = 20, ref )
{
    if ( isdefined( ref ) )
    {
        function_70467d6be224da52( ref );
    }
    
    nightmare_splash( "nm_sector_start" );
    ob_story_mission_utils::objective_text_show( %"hash_5d225874b0380a76" );
    wait timer;
    ob_story_mission_utils::function_94bd9141862a4ba6( level.players );
    wait 0.5;
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x22249032, Offset: 0xac86
// Size: 0x72, Type: bool
function function_8b22711cacde4bb5( ai )
{
    if ( issubstr( ai.classname, "bot" ) )
    {
        return false;
    }
    
    if ( issubstr( ai.classname, "zom" ) )
    {
        return false;
    }
    
    if ( issubstr( ai.classname, "shield" ) )
    {
        return false;
    }
    
    if ( issubstr( ai.classname, "jugg" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x6af1be7e, Offset: 0xad01
// Size: 0x87
function function_f27116fc277b79b6()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait 2;
    zrex_circle_struct = utility::getstruct( "struct_zrex_circle_static", "targetname" );
    z_height_check = zrex_circle_struct.origin[ 2 ] - 300;
    
    while ( true )
    {
        if ( self.origin[ 2 ] < z_height_check )
        {
            /#
                iprintlnbold( "<dev string:xec>" );
            #/
            
            childthread function_c6e9e5579176321b();
            wait 1;
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0xc7076354, Offset: 0xad90
// Size: 0xc3
function private function_56c531401028d79a()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        utility::ent_flag_wait( "in_phobos_leap" );
        
        /#
            if ( getdvarint( @"hash_e85fb5e2398920eb", 0 ) )
            {
                if ( self._blackboard.var_497e751941b50bed )
                {
                    sphere( self._blackboard.var_497e751941b50bed, 2, ( 1, 0, 1 ), 0, 300 );
                }
                
                sphere( self.origin, 2, ( 0, 0.5, 0.5 ), 0, 300 );
            }
        #/
        
        utility::ent_flag_waitopen_or_timeout( "in_phobos_leap", 10 );
        self.var_c3c26fd223625df0 = 0;
        childthread function_c6e9e5579176321b();
    }
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0x84431519, Offset: 0xae5b
// Size: 0x38
function private function_349ed2fdf856e361()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait getdvarfloat( @"hash_7c989361609e524b", 0.2 );
    self.var_c3c26fd223625df0 = 1;
}

// Namespace ob_nm_mode
// Params 0, eflags: 0xc
// Checksum 0x198ace22, Offset: 0xae9b
// Size: 0x238
function private function_c6e9e5579176321b()
{
    self notify( #"hash_a6a41cb57a210aa6" );
    self endon( #"hash_a6a41cb57a210aa6" );
    self endon( #"in_phobos_leap" );
    secondsduration = 0;
    var_cabfa898bbf55d6a = getdvarfloat( @"hash_b94469c2aff41023", 0.5 );
    var_44fc5698bbfcebd2 = getdvarfloat( @"hash_8396c7a077a22223", 8 );
    var_6c0f9495799d7de8 = getdvarint( @"hash_50d961bc0af2ede1", 100 );
    var_f520a021c6d440a5 = getdvarint( @"hash_42d55a2b8a0a670f", 30 );
    
    while ( secondsduration <= var_44fc5698bbfcebd2 )
    {
        var_7d7836ec3b55ab23 = self.origin + ( 0, 0, var_6c0f9495799d7de8 );
        groundpos = getgroundposition( var_7d7836ec3b55ab23, var_f520a021c6d440a5 );
        
        /#
            if ( getdvarint( @"hash_e85fb5e2398920eb", 0 ) )
            {
                sphere( self.origin, 1, ( 0, 0.5, 0.5 ), 0, 300 );
                sphere( groundpos, 1, ( 1, 1, 1 ), 0, 300 );
                sphere( var_7d7836ec3b55ab23, 1, ( 0, 0, 0 ), 0, 300 );
                cylinder( self.origin, groundpos, var_f520a021c6d440a5, ( 1, 1, 1 ), 0, 300 );
            }
        #/
        
        if ( self.origin[ 2 ] < groundpos[ 2 ] && abs( self.origin[ 2 ] - groundpos[ 2 ] ) > 0.1 )
        {
            teleportpos = getclosestpointonnavmesh( groundpos, self );
            
            if ( !teleportpos )
            {
                var_97858203822f35e7 = getdvarint( @"hash_fc57dbff717e1c2a", 20 );
                newz = groundpos[ 2 ] + var_97858203822f35e7;
                teleportpos = ( self.origin[ 0 ], self.origin[ 1 ], newz );
            }
            
            /#
                iprintlnbold( "<dev string:x113>" );
                
                if ( getdvarint( @"hash_e85fb5e2398920eb", 0 ) )
                {
                    sphere( teleportpos, 3, ( 1, 0, 0 ), 0, 300 );
                }
            #/
            
            self setorigin( teleportpos, 1 );
            return;
        }
        
        secondsduration += var_cabfa898bbf55d6a;
        wait var_cabfa898bbf55d6a;
    }
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xf1a56131, Offset: 0xb0db
// Size: 0x4b
function nightmare_splash( var_930bd298a1235e7d, audio_ref, player )
{
    if ( isdefined( audio_ref ) )
    {
        level thread snd::play( audio_ref );
    }
    
    if ( !isdefined( player ) )
    {
        hud_util::showsplashtoall( var_930bd298a1235e7d );
        return;
    }
    
    player hud_message::showsplash( var_930bd298a1235e7d );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x692241e1, Offset: 0xb12e
// Size: 0x13f
function function_e68ea7f6b97ccd83( owner )
{
    utility::flag_wait( "toma_strike_initialized" );
    utility::add_fx( "toma_strike_target", "vfx_sat_wc_vgo_boss_attack_target_01" );
    var_28ed962522598df3 = toma_strike::function_2828cb52fc7c81ef();
    toma_strike::init_toma_strike_params( var_28ed962522598df3 );
    level.toma_weapon_name = "toma_proj_sat_ob_virgo";
    level.var_d2057eb693bfdb83 = "ks_toma_strike_cluster_sat_ob_virgo";
    num_shots = 4;
    
    if ( !isdefined( owner ) )
    {
        owner = getaiarray()[ 0 ];
    }
    
    foreach ( player in level.players )
    {
        level thread utility::play_sound_in_space( "evt_plr_incoming_cradle_attack_01", player.origin + ( 0, 0, 600 ) );
        level thread utility::play_sound_in_space( "maaws_reticle_locked", player.origin );
        
        if ( !isdefined( owner ) )
        {
            owner = player;
        }
        
        level thread scriptedtomastrike( owner, player, num_shots, 64, 256 );
    }
}

// Namespace ob_nm_mode
// Params 5
// Checksum 0xb15b439f, Offset: 0xb275
// Size: 0x185
function scriptedtomastrike( owner, player, var_5b98b9c4e91a8ec0 = 1, var_e04b8226e0fedca3 = 0, var_b5342819efc54845 = 64 )
{
    owner endon( #"death" );
    streakname = "toma_strike";
    striketype = 1;
    streakinfo = killstreak_utility::createstreakinfo( streakname, owner );
    var_147ece74855f6277 = ( 0, 0, 0 );
    ownerforward = ( 0, 0, 0 );
    ownerright = ( 0, 0, 0 );
    origin = player.origin;
    
    if ( var_e04b8226e0fedca3 )
    {
        origin = player.origin + ( randomfloatrange( -1 * var_e04b8226e0fedca3, var_e04b8226e0fedca3 ), randomfloatrange( -1 * var_e04b8226e0fedca3, var_e04b8226e0fedca3 ), 0 );
    }
    
    killstreak_utility::killstreak_dangernotifyplayersinrange( owner, "team_hundred_ninety", 1024, streakname, origin );
    
    for ( j = 0; j < var_5b98b9c4e91a8ec0 ; j++ )
    {
        var_4d99e8552caf305a = owner toma_strike::findunobstructedfiringinfo( origin, var_b5342819efc54845, var_147ece74855f6277, ownerforward, ownerright );
        
        /#
            iprintln( var_4d99e8552caf305a.sourcepos );
        #/
        
        owner thread toma_strike::tomastrike_firestrike( striketype, var_4d99e8552caf305a, streakinfo );
        wait randomfloatrange( 0.25, 0.5 );
    }
}

// Namespace ob_nm_mode
// Params 5
// Checksum 0x69d0e785, Offset: 0xb402
// Size: 0x1b1
function function_22126bf9e438ead6( owner, target_ent, var_5b98b9c4e91a8ec0 = 1, var_e04b8226e0fedca3 = 0, var_b5342819efc54845 = 64 )
{
    if ( !isdefined( level.ai_disciple ) )
    {
        return;
    }
    
    level.ai_disciple endon( #"death" );
    streakname = "toma_strike";
    striketype = 1;
    streakinfo = killstreak_utility::createstreakinfo( streakname, owner );
    var_147ece74855f6277 = ( 0, 0, 0 );
    ownerforward = ( 0, 0, 0 );
    ownerright = ( 0, 0, 0 );
    origin = target_ent.origin;
    
    if ( var_e04b8226e0fedca3 )
    {
        origin = target_ent.origin + ( randomfloatrange( -1 * var_e04b8226e0fedca3, var_e04b8226e0fedca3 ), randomfloatrange( -1 * var_e04b8226e0fedca3, var_e04b8226e0fedca3 ), 0 );
    }
    
    killstreak_utility::killstreak_dangernotifyplayersinrange( level.ai_disciple, "team_hundred_ninety", 1024, streakname, origin );
    
    for ( j = 0; j < var_5b98b9c4e91a8ec0 ; j++ )
    {
        var_4d99e8552caf305a = level.ai_disciple toma_strike::findunobstructedfiringinfo( origin, var_b5342819efc54845, var_147ece74855f6277, ownerforward, ownerright );
        
        /#
            iprintln( var_4d99e8552caf305a.sourcepos );
        #/
        
        level.ai_disciple thread toma_strike::tomastrike_firestrike( striketype, var_4d99e8552caf305a, streakinfo );
        wait randomfloatrange( 0.25, 0.5 );
    }
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x9bbe0706, Offset: 0xb5bb
// Size: 0x75
function spawn_vfx( origin, angles, duration )
{
    tag = level utility::function_1808878d1c511ce8( origin, angles );
    waitframe();
    playfxontag( level._effect[ "toma_strike_target" ], tag, "tag_origin" );
    wait duration;
    stopfxontag( level._effect[ "toma_strike_target" ], tag, "tag_origin" );
    tag delete();
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x6c55b862, Offset: 0xb638
// Size: 0x87
function function_a60cd6315c37bac1()
{
    val::set( "bot", "prone", 0 );
    val::set( "bot", "pain", 0 );
    self.disablebulletwhizbyreaction = 1;
    self.disabledodge = 1;
    self.var_85723cc4de5b8147 = int( 4000 );
    self.paincooldown = int( 5000 );
    self.grenadeawareness = 0;
    self.disablegrenaderesponse = 1;
    self.var_b73c033f1d73bd80 = 1;
    self.var_2f7b28254901f8d6 = 1;
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x6a7d81f7, Offset: 0xb6c7
// Size: 0x161
function setup_healthbar( health, maxhealth )
{
    level.razor hudoutlineenable( "outline_nodepth_red" );
    health_struct = spawnstruct();
    health_struct.health = health;
    health_struct.maxhealth = maxhealth;
    
    foreach ( player in level.players )
    {
        player thread ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_aries_nm_rozar", health_struct );
    }
    
    level.health_struct = health_struct;
    level.razor waittill( #"death" );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xc97eae3c, Offset: 0xb830
// Size: 0xbd
function private update_healthbar( damage )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( level.health_struct ) )
    {
        level.health_struct.health = max( self.health, 0 );
        
        foreach ( player in level.players )
        {
            player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xcf69aa69, Offset: 0xb8f5
// Size: 0x2bc
function function_a37dc7b93aef05bf( params )
{
    thread init_teleport_threshold();
    level.razor.teleport_count = 0;
    level.razor.grenade_on_teleport = 0;
    level.razor.bubble_shield_drone_launcher = 0;
    level.razor.grenade_on_mega_jump = 0;
    level.razor callback::add( #"on_ai_damaged", &razor_on_damage );
    level.razor callback::add( #"on_ai_killed", &razor_on_death );
    level.razor callback::add( #"razor_should_teleport", &razor_should_teleport );
    level.razor callback::add( #"hash_77581cf1ebaf5f7b", &function_f77df7086f745d85 );
    level.razor callback::add( #"razor_teleport_start", &function_f5b65e4858a43e07 );
    level.razor callback::add( #"razor_teleport_success", &function_966a7f10cd110958 );
    level.razor callback::add( #"hash_d1496b2ebd724dcb", &function_eddd5be5346bbc04 );
    level.razor callback::add( #"hash_c6a9aa40faded202", &function_1bbbbfdbf5ac4ebf );
    level.razor callback::add( #"hash_f095f31175704c94", &function_95002684b6906b85 );
    level.razor callback::add( #"hash_e77d2088d2c8e47b", &function_d2b05b641beec7b2 );
    level.razor val::set( "razor", "prone", 0 );
    level.razor val::set( "razor", "pain", 0 );
    level.razor.disablebulletwhizbyreaction = 1;
    level.razor.disabledodge = 1;
    level.razor.var_85723cc4de5b8147 = int( 4000 );
    level.razor.paincooldown = int( 5000 );
    level.razor.battlechatterallowed = 0;
    level.razor.grenadeawareness = 0;
    level.razor.disablegrenaderesponse = 1;
    level.razor.var_b73c033f1d73bd80 = 1;
    level.razor.var_2f7b28254901f8d6 = 1;
    level.razor.var_a3533d900f6c3499 = 0;
    level.razor thread function_ef10c51c4520d828();
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x3a53d1dc, Offset: 0xbbb9
// Size: 0x9b
function init_teleport_threshold()
{
    switch ( level.players.size )
    {
        case 1:
            level.teleport_threshold = 4000;
            break;
        case 2:
            level.teleport_threshold = 10000;
            break;
        case 3:
            level.teleport_threshold = 18000;
            break;
        case 4:
            level.teleport_threshold = 28000;
            break;
        default:
            level.teleport_threshold = 4000;
            break;
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x45b162f8, Offset: 0xbc5c
// Size: 0x126
function private razor_on_damage( params )
{
    razor = self;
    level thread bubble_shield_check();
    
    if ( !isdefined( razor.phase_floor ) )
    {
        razor update_healthbar();
        return;
    }
    
    if ( razor.health < razor.phase_floor )
    {
        razor.health = razor.phase_floor;
    }
    
    if ( razor.health <= razor.phase_floor && !razor.phase_advancing )
    {
        razor.phase_advancing = 1;
        razor val::set( "razor_phase_delay", "damage", 0 );
        razor.health = razor.phase_floor;
        razor thread function_1e7eccac82575c2e( razor.phase_delay );
    }
    
    razor update_healthbar();
    logstring( "[TAURUS_BOSS_FIGHT] - Squad " + self.activity_instance.playerparticipants[ 0 ].sessionsquadid + " - new boss health: " + self.health );
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xe9da60e5, Offset: 0xbd8a
// Size: 0x21b
function private razor_on_death( params )
{
    razor = self;
    level utility::flag_set( "rozar_dead" );
    
    if ( razor.drone_launcher || razor.drone_launcher_drones && razor.drone_launcher_drones.size > 0 )
    {
        razor callback::callback( #"super_cancel" );
    }
    
    level.var_bceb4defa877a28b = 0;
    time = 1;
    
    if ( level utility::flag( "flag_skip_rozar_death" ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread function_8458da9e14bace5b( time );
    }
    
    function_f20a9fe6c594f5b3( 1 );
    wait time;
    animnode = spawnstruct();
    animnode.origin = ( -18404, 22636, 2198 );
    animnode.angles = ( 0, 270, 0 );
    animnode scene::set_scriptbundle( "scene_sat_nm_s3_rozar_death" );
    animnode thread scene::play( undefined, [ "shot_010", "shot_020", "shot_030" ], "scene_sat_nm_s3_rozar_death" );
    wait 9.5;
    
    foreach ( player in level.players )
    {
        player thread function_8458da9e14bace5b( time );
    }
    
    wait time;
    function_f20a9fe6c594f5b3( 0 );
    wait time;
    level utility::flag_set( "rozar_death_done" );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xd7328b56, Offset: 0xbfad
// Size: 0x4a
function function_8458da9e14bace5b( time = 0.5 )
{
    namespace_a350a26c6d662a6a::function_10887bb6792fea1c( self, "heavy", 0, "cradle_influence_vfx_heavy" );
    hud_util::fade_out( time, "white" );
    wait time;
    hud_util::fade_in( time, "white" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xb278789e, Offset: 0xbfff
// Size: 0x10c
function bubble_shield_check()
{
    activity_instance = self;
    
    if ( level.var_bceb4defa877a28b == 1 )
    {
        shield_scriptable = activity_instance.shield;
        shield_radius = activity_instance.shield.radius;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && isdefined( shield_scriptable ) && isdefined( shield_radius ) )
            {
                player_in_bubble = utility::playerwithindistance( player, shield_scriptable.origin, shield_radius );
                
                if ( player_in_bubble )
                {
                    activity_instance.shield notify( #"bubble_shield_end" );
                }
            }
        }
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x5d997d47, Offset: 0xc113
// Size: 0x13a, Type: bool
function private razor_should_teleport( params )
{
    razor = self;
    var_78b9f658d7f1e5fc = params.var_78b9f658d7f1e5fc;
    
    if ( razor utility::ent_flag( "teleport_disable" ) )
    {
        return false;
    }
    
    if ( razor utility::ent_flag( "force_teleport_pending" ) )
    {
        assert( isdefined( razor.force_teleport_location ) );
        return true;
    }
    
    if ( gettime() < var_78b9f658d7f1e5fc + 2000 )
    {
        return false;
    }
    
    if ( razor.var_b5a766d4bfae0926 && gettime() < razor.var_b5a766d4bfae0926 )
    {
        return false;
    }
    
    if ( isdefined( level.razor.marker ) )
    {
        min_dist = squared( 400 );
        
        if ( distancesquared( razor.origin, level.razor.marker.origin ) < min_dist )
        {
            return true;
        }
    }
    
    var_e16400de2dc108b7 = razor.var_e16400de2dc108b7 ?? razor.maxhealth;
    
    if ( var_e16400de2dc108b7 - razor.health > level.teleport_threshold )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xb31ced5b, Offset: 0xc256
// Size: 0x22c, Type: bool
function private function_f77df7086f745d85( params )
{
    razor = self;
    target_loc = params.var_43718e5d70973abe;
    
    if ( razor utility::ent_flag( "force_teleport_pending" ) )
    {
        assert( isdefined( razor.force_teleport_location ) );
        params.var_75279a674dedfdeb = razor.force_teleport_location;
        params.var_4b02ab0c40324c03 = razor.var_85e153619e5f94cd;
        
        /#
            if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
            {
                sphere( params.var_75279a674dedfdeb, 3, ( 1, 1, 0 ), 0, 400 );
                line( razor.origin, params.var_75279a674dedfdeb, ( 1, 1, 0 ), 1, 0, 400 );
                print3d( params.var_75279a674dedfdeb, "<dev string:x141>", ( 1, 1, 0 ), 1, 0.75, 400, 0 );
            }
        #/
        
        return true;
    }
    
    if ( utility::percent_chance( 25 ) || !target_loc || utility::playerwithindistance( razor, target_loc, 256 ) )
    {
        teleport_struct = level choose_teleport_struct( level.boss_teleport_structs );
        params.var_75279a674dedfdeb = teleport_struct.origin;
        
        if ( teleport_struct.script_noteworthy == "boss_teleport_structs" )
        {
            params.var_4b02ab0c40324c03 = 1;
        }
        
        /#
            if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
            {
                sphere( params.var_75279a674dedfdeb, 3, ( 1, 1, 0 ), 0, 400 );
                line( razor.origin, params.var_75279a674dedfdeb, ( 1, 1, 0 ), 1, 0, 400 );
                print3d( params.var_75279a674dedfdeb, "<dev string:x150>", ( 1, 1, 0 ), 1, 0.75, 400, 0 );
            }
        #/
        
        return true;
    }
    
    return false;
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x456c62bc, Offset: 0xc48b
// Size: 0x1bd
function choose_teleport_struct( struct_array )
{
    teleport_struct = utility::array_random( struct_array );
    var_617399512183e890 = [];
    min_dist = squared( 256 );
    
    foreach ( teleport_struct in struct_array )
    {
        foreach ( player in level.players )
        {
            if ( distancesquared( teleport_struct.origin, player.origin ) > min_dist && !utility::playerwithindistance( level.razor, teleport_struct.origin, 256 ) )
            {
                var_617399512183e890[ var_617399512183e890.size ] = teleport_struct;
            }
        }
    }
    
    teleport_struct = utility::array_random( var_617399512183e890 );
    
    if ( isdefined( level.last_teleport_struct ) )
    {
        if ( level.last_teleport_struct == teleport_struct )
        {
            arrayremove( var_617399512183e890, level.last_teleport_struct );
            teleport_struct = utility::array_random( var_617399512183e890 );
        }
    }
    
    if ( !isdefined( teleport_struct ) )
    {
        /#
            iprintlnbold( "<dev string:x162>" );
        #/
        
        teleport_struct = utility::array_random( struct_array );
    }
    
    level.last_teleport_struct = teleport_struct;
    return teleport_struct;
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x7f182539, Offset: 0xc651
// Size: 0x3e
function private function_d5e895388c0cdf13( var_b5a766d4bfae0926 )
{
    razor = self;
    razor.var_e16400de2dc108b7 = razor.health;
    razor.var_b5a766d4bfae0926 = var_b5a766d4bfae0926;
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xe76016f7, Offset: 0xc697
// Size: 0x111
function private function_f5b65e4858a43e07( params )
{
    razor = self;
    razor notify( #"razor_teleport" );
    
    if ( razor.grenade_on_teleport )
    {
        var_5e943102167d6e16 = 180;
        
        foreach ( player in level.players )
        {
            if ( distancesquared( player.origin, razor.origin ) < var_5e943102167d6e16 * var_5e943102167d6e16 )
            {
                razor function_b3c3716e2fedee4b( razor.origin + ( 0, 0, 5 ), razor.origin + ( 0, 0, 64 ), 2 );
                break;
            }
        }
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xa201024d, Offset: 0xc7b0
// Size: 0xd3
function private function_966a7f10cd110958( params )
{
    razor = self;
    razor function_d5e895388c0cdf13();
    razor.teleport_count++;
    var_799263dc920c5ca0 = 1;
    
    if ( razor utility::ent_flag( "force_teleport_pending" ) )
    {
        razor utility::ent_flag_clear( "force_teleport_pending" );
        razor.force_teleport_location = undefined;
        var_799263dc920c5ca0 = istrue( razor.var_36cd0b35247165ee );
        
        if ( isdefined( razor.var_9f3d4a54fa18cfcf ) )
        {
            razor notify( razor.var_9f3d4a54fa18cfcf );
        }
        
        if ( isdefined( razor.force_teleport_end_flag ) )
        {
            razor thread function_2c7a806fe75f1e7( razor.force_teleport_end_flag );
        }
    }
    
    if ( var_799263dc920c5ca0 && !getdvarint( @"hash_27845278616984bc", 0 ) )
    {
        razor thread function_e8b15e54fea6e08f();
    }
}

// Namespace ob_nm_mode
// Params 0, eflags: 0xc
// Checksum 0xef17073e, Offset: 0xc88b
// Size: 0x216
function private function_e8b15e54fea6e08f()
{
    self notify( #"hash_d144e8268cee52af" );
    self endon( #"hash_d144e8268cee52af" );
    razor = self;
    razor endon( #"death", #"razor_teleport" );
    razor thread function_850514b11463cb87();
    stay_start = gettime();
    stay_end = stay_start + randomfloatrange( 1500, 3000 );
    
    if ( razor.var_ace4896b0731607.var_4b02ab0c40324c03 )
    {
        /#
            if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
            {
                print3d( razor.origin, "<dev string:x187>", ( 1, 1, 0 ), 1, 1, 400 );
            }
        #/
        
        stay_end = stay_start + randomintrange( 5000, 8000 );
    }
    
    while ( true )
    {
        var_1326515b7bd5e5ff = 1;
        
        if ( gettime() > stay_end )
        {
            /#
                if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
                {
                    print3d( razor geteye(), "<dev string:x198>", ( 1, 0.3, 0.3 ), 1, 1, 400 );
                }
            #/
            
            var_1326515b7bd5e5ff = 0;
        }
        else
        {
            var_b027474e52c87c20 = gettime() - stay_start;
            var_e64a264226a86b16 = razor._blackboard.shootparams_lastshoottime ?? 0;
            var_e64a264226a86b16 = max( var_e64a264226a86b16, stay_start );
            var_b883f5691d00fb67 = gettime() - var_e64a264226a86b16;
            
            if ( var_b883f5691d00fb67 > 3000 )
            {
                /#
                    if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
                    {
                        print3d( razor geteye(), "<dev string:x1af>", ( 1, 0.3, 0.3 ), 1, 1, 400 );
                    }
                #/
                
                var_1326515b7bd5e5ff = 0;
            }
        }
        
        if ( var_1326515b7bd5e5ff )
        {
            razor setgoalpos( razor.origin, 8 );
            wait 0.1;
            continue;
        }
        
        break;
    }
    
    razor setgoalpos( razor.origin, 800 );
    razor notify( #"razor_post_teleport_release" );
}

// Namespace ob_nm_mode
// Params 0, eflags: 0xc
// Checksum 0x716f8435, Offset: 0xcaa9
// Size: 0xa0
function private function_850514b11463cb87()
{
    self notify( #"hash_346cef43cdc4d484" );
    self endon( #"hash_346cef43cdc4d484" );
    razor = self;
    razor endon( #"death" );
    razor notify( #"hash_27b56bded285a50a" );
    razor utility::waittill_any( "razor_post_teleport_release", "razor_teleport" );
    
    /#
        if ( getdvarint( @"hash_e9b0e88454e8bf21", 0 ) )
        {
            print3d( razor geteye() + ( 0, 0, -15 ), "<dev string:x1da>", ( 1, 0.3, 0.3 ), 1, 1, 400 );
        }
    #/
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x371dfb35, Offset: 0xcb51
// Size: 0x4c
function private function_2c7a806fe75f1e7( flag )
{
    razor = self;
    razor endon( #"death" );
    razor utility::ent_flag_set( "teleport_disable" );
    razor utility::ent_flag_waitopen_any( flag );
    razor utility::ent_flag_clear( "teleport_disable" );
}

// Namespace ob_nm_mode
// Params 4, eflags: 0x4
// Checksum 0xab02a699, Offset: 0xcba5
// Size: 0xc7
function private function_b13fbfca816682f8( var_52c4f551e99d04c0, var_814491e062de715c, var_84a7c8af08c0afa5, var_118c57a17951a6d4 )
{
    razor = self;
    
    if ( isvector( var_52c4f551e99d04c0 ) )
    {
        razor.force_teleport_location = var_52c4f551e99d04c0;
        razor.var_85e153619e5f94cd = 0;
    }
    else
    {
        razor.force_teleport_location = var_52c4f551e99d04c0.origin;
        razor.var_85e153619e5f94cd = var_52c4f551e99d04c0.script_noteworthy == "boss_teleport_structs";
    }
    
    razor.var_9f3d4a54fa18cfcf = var_814491e062de715c;
    razor.force_teleport_end_flag = var_84a7c8af08c0afa5;
    razor.var_36cd0b35247165ee = var_118c57a17951a6d4;
    razor utility::ent_flag_set( "force_teleport_pending" );
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0x127cdacb, Offset: 0xcc74
// Size: 0xc7
function private function_ef10c51c4520d828()
{
    razor = self;
    razor endon( #"death" );
    boss_arena_radius = 2500;
    var_dc6a4b4b351da087 = level.razor_teleport_struct_name ?? "nightmare_aries_razor_boss_struct";
    struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    
    while ( true )
    {
        if ( isdefined( level.boss_teleport_structs ) )
        {
            max_distance = squared( boss_arena_radius );
            
            if ( distancesquared( razor.origin, struct.origin ) > max_distance )
            {
                teleport_struct = level choose_teleport_struct( level.boss_teleport_structs );
                razor function_b13fbfca816682f8( teleport_struct );
            }
        }
        
        wait 1;
    }
}

// Namespace ob_nm_mode
// Params 14
// Checksum 0xa99c0824, Offset: 0xcd43
// Size: 0x83
function on_damage_callback( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    return idamage;
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x964fd6bf, Offset: 0xcdcf
// Size: 0x3d
function cap_damage( damage )
{
    if ( damage > 350 )
    {
        if ( self.activity_instance.playerparticipants.size < 2 )
        {
            damage = 250;
        }
        else
        {
            damage = 350;
        }
    }
    
    return damage;
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xcf616cdc, Offset: 0xce15
// Size: 0x13
function function_7ed0005c355c6869()
{
    cap = 10000;
    return cap;
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x9b95e607, Offset: 0xce31
// Size: 0xed
function function_440d2a7bd500801b( var_fcb964ac6f23a112, radius, circle_move_time )
{
    radius = 3000;
    last_radius = radius;
    level waittill( #"boss_phase_2" );
    radius -= 1000;
    self brcirclemoveto( var_fcb964ac6f23a112.origin[ 0 ], var_fcb964ac6f23a112.origin[ 1 ], radius, circle_move_time );
    level thread update_minimap_circle( self, var_fcb964ac6f23a112.origin, var_fcb964ac6f23a112.origin, last_radius, radius, circle_move_time );
    last_radius = radius;
    level waittill( #"boss_phase_3" );
    radius -= 700;
    self brcirclemoveto( var_fcb964ac6f23a112.origin[ 0 ], var_fcb964ac6f23a112.origin[ 1 ], radius, circle_move_time );
    level thread update_minimap_circle( self, var_fcb964ac6f23a112.origin, var_fcb964ac6f23a112.origin, last_radius, radius, circle_move_time );
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0xcc3550e6, Offset: 0xcf26
// Size: 0x113
function private function_4874c9860b48338a()
{
    assert( isdefined( level.razor ) );
    level.razor endon( #"death" );
    
    if ( !isdefined( level.bubble_shield_teleport_structs ) || isdefined( level.bubble_shield_teleport_structs ) && level.bubble_shield_teleport_structs.size == 0 )
    {
        return;
    }
    
    var_ecc516716509b577 = 20;
    var_6c1e68f1b60bece1 = level.health_threshold_1;
    level function_9acb3bd7e71bfd47( var_6c1e68f1b60bece1, var_ecc516716509b577 );
    
    /#
        iprintlnbold( "<dev string:x1ee>" );
    #/
    
    logstring( "[TAURUS_BOSS_FIGHT] PHASE 2 START for squad: " + level.playerparticipants[ 0 ].sessionsquadid );
    level function_9acb3cd7e71bff7a( level.health_threshold_3 );
    
    /#
        iprintlnbold( "<dev string:x1fc>" );
    #/
    
    logstring( "[TAURUS_BOSS_FIGHT] PHASE 3 START for squad: " + level.playerparticipants[ 0 ].sessionsquadid );
    level.razor.grenade_on_teleport = 1;
    level function_9acb3dd7e71c01ad( level.health_threshold_4 );
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0x3a6c4d9, Offset: 0xd041
// Size: 0xa8
function private function_9acb3bd7e71bfd47( var_c9b1bbb785d009e7, maxteleports )
{
    activity_instance = self;
    assert( isdefined( level.razor ) );
    level.razor endon( #"death" );
    activity_instance notify( #"boss_phase_1" );
    
    while ( level.razor.health > var_c9b1bbb785d009e7 )
    {
        if ( level.razor.health <= var_c9b1bbb785d009e7 || level.razor.teleport_count > maxteleports )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xa92375b9, Offset: 0xd0f1
// Size: 0x91
function private function_9acb3cd7e71bff7a( var_c9b1bbb785d009e7 )
{
    assert( isdefined( level.razor ) );
    level.razor endon( #"death" );
    level notify( #"boss_phase_2" );
    
    while ( true )
    {
        level mega_jump_attack();
        var_1f4357b0ee25cdcb = gettime() + randomintrange( 8000, 10000 );
        
        while ( gettime() < var_1f4357b0ee25cdcb )
        {
            if ( level.razor.health <= var_c9b1bbb785d009e7 )
            {
                return;
            }
            
            waitframe();
        }
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xbc29fddd, Offset: 0xd18a
// Size: 0x139
function private function_9acb3dd7e71c01ad( var_c9b1bbb785d009e7 )
{
    activity_instance = self;
    assert( isdefined( level.razor ) );
    level.razor endon( #"death" );
    activity_instance notify( #"boss_phase_3" );
    special_attacks = [ 0, 1 ];
    special_attack_weights = [ 50, 50 ];
    
    while ( level.razor.health > 0 )
    {
        var_f1cac850679fe7c = utility::random_weighted( special_attacks, special_attack_weights );
        cooldown_time = randomfloatrange( 8, 10 );
        
        if ( level.razor.health <= var_c9b1bbb785d009e7 )
        {
            cooldown_time = randomfloatrange( 7, 8 );
        }
        
        switch ( var_f1cac850679fe7c )
        {
            case 0:
                activity_instance mega_jump_attack();
                break;
            case 1:
                activity_instance bubble_shield_teleport( 0 );
                break;
            default:
                assertmsg( "<dev string:x20a>" + var_f1cac850679fe7c );
                break;
        }
        
        wait cooldown_time;
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xbea42a60, Offset: 0xd2cb
// Size: 0x35d
function private function_9acb36d7e71bf248( var_c9b1bbb785d009e7 )
{
    activity_instance = self;
    assert( isdefined( level.razor ) );
    level.razor endon( #"death" );
    activity_instance notify( #"boss_phase_4" );
    count = 0;
    max_time = 600;
    special_attacks = [ 0, 1 ];
    special_attack_weights = [ 30, 70 ];
    
    while ( level.razor.health > var_c9b1bbb785d009e7 || count < max_time )
    {
        var_f1cac850679fe7c = utility::random_weighted( special_attacks, special_attack_weights );
        cooldown_time = randomfloatrange( 4, 8 );
        
        switch ( var_f1cac850679fe7c )
        {
            case 0:
                activity_instance mega_jump_attack();
                break;
            case 1:
                activity_instance bubble_shield_teleport( var_c9b1bbb785d009e7 );
                break;
            default:
                assertmsg( "<dev string:x20a>" + var_f1cac850679fe7c );
                break;
        }
        
        if ( level.razor.health <= var_c9b1bbb785d009e7 )
        {
            cooldown_time = 1;
        }
        
        wait cooldown_time;
        count++;
        waitframe();
    }
    
    teleport_struct = utility::array_random( level.bubble_shield_teleport_structs );
    var_617399512183e890 = [];
    min_dist = squared( 256 );
    
    foreach ( teleport_struct in level.bubble_shield_teleport_structs )
    {
        foreach ( player in self.playerparticipants )
        {
            if ( distancesquared( teleport_struct.origin, player.origin ) > min_dist )
            {
                var_617399512183e890[ var_617399512183e890.size ] = teleport_struct;
            }
        }
    }
    
    teleport_struct = utility::array_random( var_617399512183e890 );
    
    if ( !isdefined( teleport_struct ) )
    {
        /#
            iprintlnbold( "<dev string:x230>" );
        #/
        
        teleport_struct = utility::array_random( level.bubble_shield_teleport_structs );
    }
    
    teleport_struct.radius = 32;
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
        player ob_story_mission_utils::player_boss_healthbar_show();
    }
    
    level.razor utility::ent_flag_clear( "big_boss_hide" );
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0xfc9fe33f, Offset: 0xd630
// Size: 0x220
function private function_9acb37d7e71bf47b()
{
    activity_instance = self;
    assert( isdefined( level.razor ) );
    level.razor endon( #"death" );
    wait 1;
    wait 5;
    activity_instance.var_a1b05901ea89932e = 1;
    activity_instance notify( #"boss_phase_5" );
    special_attacks = [ 0, 1, 2 ];
    mega_jump_chance = 50;
    bubble_shield_chance = 20;
    drone_launcher_chance = 30;
    var_bcaa8cd0b4bcecf6 = [ mega_jump_chance, bubble_shield_chance, drone_launcher_chance ];
    special_attack_weights = arraycopy( var_bcaa8cd0b4bcecf6 );
    
    while ( true )
    {
        var_f1cac850679fe7c = utility::random_weighted( special_attacks, special_attack_weights );
        
        foreach ( attack_id, attack_chance in special_attack_weights )
        {
            if ( attack_id == var_f1cac850679fe7c )
            {
                reduced_chance = int( special_attack_weights[ attack_id ] * 0.5 );
                special_attack_weights[ attack_id ] = max( reduced_chance, 5 );
                continue;
            }
            
            special_attack_weights[ attack_id ] = var_bcaa8cd0b4bcecf6[ attack_id ];
        }
        
        cooldown_time = randomfloatrange( 2, 5 );
        
        switch ( var_f1cac850679fe7c )
        {
            case 0:
                activity_instance mega_jump_attack();
                break;
            case 1:
                activity_instance bubble_shield_teleport( 0 );
                break;
            case 2:
                success = activity_instance drone_launcher_attack();
                
                if ( !success )
                {
                    cooldown_time = 0.5;
                }
                
                break;
            default:
                assertmsg( "<dev string:x267>" + var_f1cac850679fe7c );
                break;
        }
        
        wait cooldown_time;
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x11031e2a, Offset: 0xd858
// Size: 0x55
function private function_76a669a782c346f0( shield_center )
{
    razor = self;
    razor endon( #"death", #"end_stay_in_shield" );
    
    while ( true )
    {
        razor setgoalpos( shield_center, 32 );
        razor.fixednode = 1;
        wait 0.5;
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xec0cd074, Offset: 0xd8b5
// Size: 0x88
function private function_1d6ce4c5b4240b9d( minhealth )
{
    activity_instance = self;
    shield = activity_instance.shield;
    assert( shield );
    level.razor endon( #"death" );
    shield endon( #"death" );
    
    while ( true )
    {
        if ( level.razor.health <= minhealth )
        {
            activity_instance notify( #"razor_bubble_shield_interrupt" );
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0x507004a6, Offset: 0xd945
// Size: 0x85
function private function_5628fd1cdf4748eb()
{
    razor = self;
    razor endon( #"death" );
    razor waittill( #"end_stay_in_shield" );
    newweapon = weapon_utility::function_d2c8356dc369d9ce( razor.var_8f92cbd3ff8d3175.basename );
    razor.weapon = newweapon;
    razor utility::initweapon( newweapon );
    razor giveweapon( newweapon );
    razor setspawnweapon( newweapon );
    razor.primaryweapon = newweapon;
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0x9918747, Offset: 0xd9d2
// Size: 0x153
function private function_e16e83f7e46ed269( shield, initial_fire_delay )
{
    razor = self;
    razor endon( #"death", #"end_stay_in_shield" );
    
    if ( shield )
    {
        shield endon( #"death" );
    }
    
    var_92e857b04f5111db = 2.5;
    initial_delay = initial_fire_delay - var_92e857b04f5111db;
    
    if ( initial_delay > 0 )
    {
        wait initial_delay;
    }
    
    warning_on = 0;
    var_7998f87f299c14df = 0;
    
    while ( true )
    {
        delaytime = razor function_fa51b1f4b7a829fe();
        
        if ( delaytime == 0 )
        {
            if ( warning_on )
            {
                killfxontag( utility::getfx( "war_machine_warning_startup" ), razor, "tag_weapon_right" );
                warning_on = 0;
            }
            
            if ( !var_7998f87f299c14df )
            {
                playfxontag( utility::getfx( "war_machine_warning_loop" ), razor, "tag_weapon_right" );
                var_7998f87f299c14df = 1;
            }
        }
        else if ( delaytime <= var_92e857b04f5111db )
        {
            if ( !warning_on )
            {
                playfxontag( utility::getfx( "war_machine_warning_startup" ), razor, "tag_weapon_right" );
                warning_on = 1;
            }
        }
        else
        {
            if ( warning_on )
            {
                killfxontag( utility::getfx( "war_machine_warning_startup" ), razor, "tag_weapon_right" );
                warning_on = 0;
            }
            
            if ( var_7998f87f299c14df )
            {
                killfxontag( utility::getfx( "war_machine_warning_loop" ), razor, "tag_weapon_right" );
                var_7998f87f299c14df = 0;
            }
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0x8c448897, Offset: 0xdb2d
// Size: 0x64
function private function_264e3dda5056dca7( shield, initial_fire_delay )
{
    razor = self;
    razor function_e16e83f7e46ed269( shield, initial_fire_delay );
    
    if ( isalive( razor ) )
    {
        killfxontag( utility::getfx( "war_machine_warning_startup" ), razor, "tag_weapon_right" );
        killfxontag( utility::getfx( "war_machine_warning_loop" ), razor, "tag_weapon_right" );
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x20926ca, Offset: 0xdb99
// Size: 0xc8
function private function_2c4a011b9a84f664( shield )
{
    razor = self;
    razor endon( #"death", #"end_stay_in_shield" );
    shield endon( #"death" );
    razor.var_8f92cbd3ff8d3175 = razor.primaryweapon;
    newweapon = weapon_utility::function_d2c8356dc369d9ce( "war_machine_razor_sat_ob" );
    razor.weapon = newweapon;
    razor utility::initweapon( newweapon );
    razor giveweapon( newweapon );
    razor setspawnweapon( newweapon );
    razor.primaryweapon = newweapon;
    initial_fire_delay = 2;
    razor thread function_22d00184f533125f( initial_fire_delay );
    razor thread function_264e3dda5056dca7( shield, initial_fire_delay );
    razor thread function_5628fd1cdf4748eb();
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x4bc72c7, Offset: 0xdc69
// Size: 0x4e4
function bubble_shield_teleport( minhealth )
{
    activity_instance = self;
    level.razor endon( #"death" );
    level.razor utility::ent_flag_set( "big_boss_attack" );
    teleport_struct = utility::array_random( level.bubble_shield_teleport_structs );
    var_617399512183e890 = [];
    min_dist = squared( 256 );
    
    foreach ( teleport_struct in level.bubble_shield_teleport_structs )
    {
        foreach ( player in level.players )
        {
            if ( distancesquared( teleport_struct.origin, player.origin ) > min_dist )
            {
                var_617399512183e890[ var_617399512183e890.size ] = teleport_struct;
            }
        }
    }
    
    teleport_struct = utility::array_random( var_617399512183e890 );
    
    if ( isdefined( activity_instance.var_dbe8004bae378861 ) )
    {
        if ( activity_instance.var_dbe8004bae378861 == teleport_struct )
        {
            arrayremove( var_617399512183e890, activity_instance.var_dbe8004bae378861 );
            teleport_struct = utility::array_random( var_617399512183e890 );
        }
    }
    
    if ( !isdefined( teleport_struct ) )
    {
        /#
            iprintlnbold( "<dev string:x230>" );
        #/
        
        teleport_struct = utility::array_random( level.bubble_shield_teleport_structs );
    }
    
    activity_instance.var_dbe8004bae378861 = teleport_struct;
    teleport_struct.radius = 32;
    level.razor function_b13fbfca816682f8( teleport_struct, "bubble_shield_teleport", "big_boss_attack" );
    level.razor waittill( #"bubble_shield_teleport" );
    var_a0e4dc67a15b6ee = teleport_struct.origin;
    var_549d3e66dbad96c9 = utility::spawn_model( "eqp_sat_wm_bubble_shield_razor", var_a0e4dc67a15b6ee, teleport_struct.angles );
    var_549d3e66dbad96c9 setscriptablepartstate( #"visibility", #"show" );
    var_549d3e66dbad96c9 setscriptablepartstate( #"active", #"active" );
    level.razor thread utility::delete_on_death( var_549d3e66dbad96c9 );
    level.razor notify( #"hash_27b56bded285a50a" );
    level.razor thread function_76a669a782c346f0( teleport_struct.origin );
    activity_instance bubble_shield( var_549d3e66dbad96c9, level.razor );
    activity_instance thread function_7e7a59c6146f57c8();
    activity_instance thread function_1d6ce4c5b4240b9d( minhealth );
    level.var_bceb4defa877a28b = 1;
    level thread function_537886403edffca();
    
    if ( level.razor.bubble_shield_drone_launcher )
    {
        level.razor thread function_1cb0df0e704933c();
    }
    
    level.razor thread function_2c4a011b9a84f664( activity_instance.shield );
    result = utility::waittill_any_ents_return( activity_instance.shield, "bubble_shield_end", activity_instance.shield, "bubble_shield_broken", activity_instance.shield, "bubble_shield_overridden", activity_instance, "razor_bubble_shield_interrupt" );
    level.razor notify( #"end_stay_in_shield" );
    
    if ( isdefined( result ) )
    {
        if ( result == "razor_bubble_shield_interrupt" )
        {
            activity_instance.shield notify( #"bubble_shield_end" );
        }
    }
    
    var_549d3e66dbad96c9 setscriptablepartstate( #"destroy", #"active" );
    level.razor.fixednode = 0;
    level.razor setgoalentity( var_549d3e66dbad96c9 );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_show();
    }
    
    level.var_bceb4defa877a28b = 0;
    wait 1;
    level.razor cleargoalentity();
    var_549d3e66dbad96c9 delete();
    teleport_struct = level choose_teleport_struct( level.boss_teleport_structs );
    level.razor function_b13fbfca816682f8( teleport_struct, "teleport_after_big_boss_attack", "big_boss_attack", 1 );
    level.razor utility::ent_flag_clear( "big_boss_attack" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xb687c64e, Offset: 0xe155
// Size: 0x59
function function_537886403edffca()
{
    level.razor endon( #"death" );
    nightmare_splash( "nm_incoming_strike" );
    
    while ( level.var_bceb4defa877a28b == 1 )
    {
        level thread function_e68ea7f6b97ccd83();
        cooldown_time = randomfloatrange( 7, 8 );
        wait cooldown_time;
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xaee2302e, Offset: 0xe1b6
// Size: 0x48
function private function_22d00184f533125f( var_9f3bc39e1f4b516d )
{
    razor = self;
    razor.dontevershoot = 1;
    razor utility::waittill_any_timeout( var_9f3bc39e1f4b516d, "death", "end_stay_in_shield" );
    razor.dontevershoot = 0;
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0xa95e0c7d, Offset: 0xe206
// Size: 0x320
function bubble_shield( var_549d3e66dbad96c9, team_member )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    level.var_d5ae8d9ff7d863e2 = 100000;
    bundle.bubbleshieldhealth = 100000;
    bundle.var_3080e759a26cd844 = 33000;
    bundle.var_6ed782b00e2247f = 66000;
    
    if ( team_member.agent_type == "actor_sat_dawg_ob_nm" )
    {
        level.var_d5ae8d9ff7d863e2 = 100000;
        bundle.bubbleshieldhealth = 100000;
        bundle.var_3080e759a26cd844 = 33000;
        bundle.var_6ed782b00e2247f = 66000;
    }
    else if ( level utility::flag( "flag_klaus_fight" ) )
    {
        base = 150000;
        level.var_d5ae8d9ff7d863e2 = level.players.size * base;
        bundle.bubbleshieldhealth = level.var_d5ae8d9ff7d863e2;
        bundle.var_3080e759a26cd844 = 100000;
        bundle.var_6ed782b00e2247f = 200000;
    }
    else if ( level utility::flag( "flag_rhino_la_fight" ) )
    {
        base = 150000;
        level.var_d5ae8d9ff7d863e2 = level.players.size * base;
        bundle.bubbleshieldhealth = level.var_d5ae8d9ff7d863e2;
        bundle.var_3080e759a26cd844 = level.var_d5ae8d9ff7d863e2 * 0.6;
        bundle.var_6ed782b00e2247f = level.var_d5ae8d9ff7d863e2 * 0.3;
    }
    
    assert( isdefined( bundle ), "<dev string:x28d>" );
    
    if ( bundle.var_1bff71f32e38282c )
    {
        players = getplayersinradius( var_549d3e66dbad96c9.origin, 500 );
        
        foreach ( player in players )
        {
            player prestreamasset( "model", bundle.var_1bff71f32e38282c, 500 );
            player thread function_c3ce29ab93cae117( bundle.var_1bff71f32e38282c, var_549d3e66dbad96c9 );
        }
    }
    
    if ( isdefined( level.razor ) )
    {
        level.var_d5ae8d9ff7d863e2 = level.players.size * 30000;
    }
    
    init_data();
    shield = spawn_shield( var_549d3e66dbad96c9, team_member );
    self.shield = shield;
    thread function_a9b73497aea883d8( shield, team_member );
    
    if ( team_member.agent_type == "actor_sat_dawg_ob_nm" )
    {
        shield thread delete_grenade( var_549d3e66dbad96c9 );
        return;
    }
    
    if ( level utility::flag( "flag_klaus_fight" ) )
    {
        shield thread delete_grenade( var_549d3e66dbad96c9 );
        return;
    }
    
    if ( level utility::flag( "flag_rhino_la_fight" ) )
    {
        shield thread delete_grenade( var_549d3e66dbad96c9 );
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x660889a2, Offset: 0xe52e
// Size: 0x25
function delete_grenade( grenade )
{
    self waittill( #"hash_e95ced04f8eba21a" );
    
    if ( grenade )
    {
        grenade delete();
    }
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0x7fa5c4ec, Offset: 0xe55b
// Size: 0x1f0
function private function_7e7a59c6146f57c8()
{
    activity_instance = self;
    shield_scriptable = activity_instance.shield;
    shield_radius = activity_instance.shield.radius;
    level.razor endon( #"death", #"end_stay_in_shield" );
    var_8a8336bd0bc966b3 = 2000;
    var_3c271829d1a03dbd = gettime();
    var_eb9705697b0d091 = [];
    
    while ( isdefined( shield_scriptable ) )
    {
        activity_instance.var_bceb4defa877a28b = utility::playerwithindistance( level.razor, shield_scriptable.origin, shield_radius );
        
        if ( activity_instance.var_bceb4defa877a28b )
        {
            var_3c271829d1a03dbd = gettime();
        }
        else
        {
            time_outside = gettime() - var_3c271829d1a03dbd;
            
            if ( time_outside > var_8a8336bd0bc966b3 )
            {
                activity_instance notify( #"razor_bubble_shield_interrupt" );
                break;
            }
        }
        
        foreach ( player in level.players )
        {
            player_in_bubble = utility::playerwithindistance( player, shield_scriptable.origin, shield_radius );
            var_44d33f520d75a4ee = activity_instance.var_bceb4defa877a28b && !player_in_bubble;
            
            if ( !isdefined( var_eb9705697b0d091[ player.guid ] ) || var_eb9705697b0d091[ player.guid ] != var_44d33f520d75a4ee )
            {
                if ( var_44d33f520d75a4ee )
                {
                    player ob_story_mission_utils::player_boss_healthbar_immune();
                }
                else
                {
                    player ob_story_mission_utils::player_boss_healthbar_show();
                }
            }
            
            var_eb9705697b0d091[ player.guid ] = var_44d33f520d75a4ee;
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0xfc594686, Offset: 0xe753
// Size: 0x1a4
function private init_data()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    data = {};
    data.var_7ff2b15d178975ed = bundle.var_24f0532b0a0098f8 ?? 0;
    data.health = level.var_d5ae8d9ff7d863e2;
    data.lifetime = supers_mp::function_b302d192481449e7( level.superglobals.staticsuperdata[ "super_bubble_shield" ] );
    data.var_3080e759a26cd844 = bundle.var_446db2ad6d1ca831;
    data.var_6ed782b00e2247f = bundle.var_b8ef4ce26234af32;
    data.var_48afd0d39aecdecc = bundle.var_b9092e554648f288 ?? 1;
    data.var_69fccb1b1188f88c = bundle.var_82b0075c1a3056fd ?? 10;
    data.var_130a5cdc70c98749 = bundle.var_74e2daa5af97f986;
    data.xmodel = bundle.var_1bff71f32e38282c;
    data.var_f7f3c29a983ac216 = bundle.var_f7f3c29a983ac216 ?? 1000;
    data.var_c272397339d03bc2 = bundle.var_ef38ec7471ff4caf;
    data.var_7466ff13ec4679d4 = bundle.var_9416a2eea30b924b;
    data.submixkey = bundle.var_8b579fc538551ca0;
    data.var_366598a7478a3ab5 = bundle.var_7c7b182f000fd78;
    data.var_130a5cdc70c98749 = 0;
    self.var_76d21985b86ceb6d = data;
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0xe38c9979, Offset: 0xe8ff
// Size: 0x2ba
function private spawn_shield( grenade, team_member )
{
    assert( grenade, "<dev string:x2ea>" );
    data = self.var_76d21985b86ceb6d;
    assert( isdefined( data.xmodel ), "<dev string:x311>" );
    var_7c170ceae0649b57 = [ #"teamselect", team_member.team ];
    scriptable::scriptable_adddamagedcallback( &function_4f4873403a781676 );
    shield = spawnscriptable( "super_bubble_shield_enemy", grenade.origin, ( 0, 0, 0 ), undefined, var_7c170ceae0649b57 );
    shield.connectedplayer = self;
    shield.var_3080e759a26cd844 = data.var_3080e759a26cd844;
    shield.var_6ed782b00e2247f = data.var_6ed782b00e2247f;
    shield.maxhealth = max( data.health, 1 );
    shield.health = data.health;
    shield.radius = function_decb653c5689e4ca( data.xmodel )[ 1 ];
    shield.var_c272397339d03bc2 = data.var_c272397339d03bc2;
    shield.var_7466ff13ec4679d4 = data.var_7466ff13ec4679d4;
    shield.submixkey = data.submixkey;
    shield.var_cd361b3d06fd5f62 = data.var_366598a7478a3ab5 ? shield.radius * data.var_366598a7478a3ab5 : shield.radius;
    shield.var_f7f3c29a983ac216 = data.var_f7f3c29a983ac216;
    
    if ( data.var_130a5cdc70c98749 )
    {
        shield.badplaceid = function_8bf6c5fe849106c4( grenade.origin, shield.angles, 8, 1.5 * shield.radius, shield.radius );
        
        if ( grenade getlinkedparent() )
        {
            grenade thread function_17bb190e2627faed( shield );
        }
    }
    
    if ( !isdefined( level.var_a0dcc921bb9a5edb ) )
    {
        level.var_a0dcc921bb9a5edb = [];
    }
    
    level.var_a0dcc921bb9a5edb[ level.var_a0dcc921bb9a5edb.size ] = shield;
    
    if ( !isdefined( self.bubbleshields ) )
    {
        self.bubbleshields = [];
    }
    
    self.bubbleshields[ self.bubbleshields.size ] = shield;
    shield.shieldscriptable = shield;
    shield.var_a16ffdbb5f30f3c3 = 0;
    return shield;
}

// Namespace ob_nm_mode
// Params 11
// Checksum 0x6861977a, Offset: 0xebc2
// Size: 0x392
function function_4f4873403a781676( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !( isdefined( instance ) && isdefined( instance.type ) ) || instance.type != "super_bubble_shield_enemy" )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && objweapon.basename == "sat_remote_robot_arm_gun_mp" )
    {
        damage_scalar = 20;
        idamage *= damage_scalar;
    }
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        if ( !instance.var_6708353a02eb3e88 || !isagent( eattacker ) )
        {
            return;
        }
    }
    
    if ( level utility::flag( "flag_dawg_shield" ) )
    {
        if ( isweapon( objweapon ) && objweapon.basename == "sat_cluster_grenade_ob" )
        {
            if ( einflictor.threwback && isdefined( einflictor.originalowner ) && issubstr( einflictor.originalowner.classname, "dawg" ) )
            {
                idamage *= 10000;
                hitters = [ eattacker ];
                
                /#
                    iprintln( "<dev string:x32a>" );
                #/
                
                level callback::callback( #"hash_968ba3fff62b366c", { #players:hitters } );
            }
        }
    }
    
    if ( !utility::playerwithindistance( eattacker, instance.origin, instance.radius ) )
    {
        instance.health -= idamage;
        eattacker damagefeedback::updatedamagefeedback( "hitequip", instance.health <= 0, 0, undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined );
        
        if ( isplayer( instance.connectedplayer ) && utility::issharedfuncdefined( #"challenges", #"hash_331a82c13105b9dd" ) )
        {
            bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
            instance.connectedplayer [[ utility::getsharedfunc( #"challenges", #"hash_331a82c13105b9dd" ) ]]( { #lootid:bundle.lootid, #idamage:idamage } );
        }
    }
    
    healthpercent = instance.health / instance.maxhealth;
    
    if ( instance.health <= 0 )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
        eattacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_afb5519f3a738c44 );
        instance notify( #"bubble_shield_broken" );
    }
    else if ( healthpercent <= instance.var_6ed782b00e2247f )
    {
        instance function_4c933c70377b9554( "shield_heavy_damaged" );
    }
    else if ( healthpercent <= instance.var_3080e759a26cd844 )
    {
        instance function_4c933c70377b9554( "shield_light_damaged" );
    }
    
    if ( !instance.var_de268bc611446f83 && instance.maxhealth - instance.health >= instance.var_f7f3c29a983ac216 )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
        instance.connectedplayer namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_fe8c837b55f4d149 );
        instance.var_de268bc611446f83 = 1;
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xe473ad16, Offset: 0xef5c
// Size: 0x7f
function private function_17bb190e2627faed( shield )
{
    while ( true )
    {
        if ( shield.badplaceid )
        {
            destroynavobstacle( shield.badplaceid );
        }
        
        if ( self )
        {
            shield.badplaceid = function_8bf6c5fe849106c4( shield.origin, shield.angles, 8, 1.5 * shield.radius, shield.radius );
        }
        else
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x1cca8280, Offset: 0xefe3
// Size: 0x27
function private function_5c8bd21a54425f4b( lifetime )
{
    self endon( #"hash_e95ced04f8eba21a" );
    wait lifetime;
    self notify( #"bubble_shield_end" );
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xd7c4a98b, Offset: 0xf012
// Size: 0x27
function private function_17e3d2b7a35618a7( time )
{
    self endon( #"hash_e95ced04f8eba21a" );
    wait time;
    function_4c933c70377b9554( "shield_heavy_damaged" );
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0x9a259efe, Offset: 0xf041
// Size: 0x5f
function private function_a9b73497aea883d8( bubbleshield, team_member )
{
    bubbleshield endon( #"death" );
    result = utility::waittill_any_ents_return( bubbleshield, "bubble_shield_end", bubbleshield, "bubble_shield_broken", bubbleshield, "bubble_shield_overridden", team_member, "death", level, "stop_scripted_shield" );
    bubble_shield_end( bubbleshield );
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0xc39cb1c7, Offset: 0xf0a8
// Size: 0x139
function private bubble_shield_end( bubbleshield, skipstatechange = 0 )
{
    if ( !skipstatechange )
    {
        bubbleshield.shieldscriptable setscriptablepartstate( "shield_base", "shield_destroyed" );
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_bubble_shield" );
    bubbleshield notify( #"hash_e95ced04f8eba21a" );
    level notify( #"hash_e95ced04f8eba21a" );
    
    if ( isdefined( bubbleshield.badplaceid ) )
    {
        destroynavobstacle( bubbleshield.badplaceid );
        bubbleshield.badplaceid = undefined;
    }
    
    assert( arraycontains( level.var_a0dcc921bb9a5edb, bubbleshield ), "<dev string:x339>" );
    level.var_a0dcc921bb9a5edb = arrayremove( level.var_a0dcc921bb9a5edb, bubbleshield );
    
    if ( bubbleshield.connectedplayer )
    {
        bubbleshield.connectedplayer.bubbleshields = arrayremove( bubbleshield.connectedplayer.bubbleshields, bubbleshield );
    }
    
    bubbleshield.var_de268bc611446f83 = undefined;
    
    if ( !skipstatechange )
    {
        wait 1;
    }
    
    bubbleshield.shieldscriptable freescriptable();
    bubbleshield.shieldscriptable = undefined;
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0x30e7ef23, Offset: 0xf1e9
// Size: 0x3f
function private function_c3ce29ab93cae117( var_2c8bae8aeb289cc1, grenade )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 2;
    self prestreamasset( "model", var_2c8bae8aeb289cc1, -1 );
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x260935e9, Offset: 0xf230
// Size: 0x36
function private function_4c933c70377b9554( new_state )
{
    var_87705ec7eac1724b = self getscriptablepartstate( "shield_base" );
    
    if ( var_87705ec7eac1724b != new_state )
    {
        self setscriptablepartstate( "shield_base", new_state );
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x9bc5bef2, Offset: 0xf26e
// Size: 0x61, Type: bool
function private function_eddd5be5346bbc04( params )
{
    razor = self;
    
    if ( razor utility::ent_flag( "razor_scripted_mega_jumps" ) )
    {
        if ( razor.var_436d85c3fa135df6 )
        {
            return ( gettime() > params.var_3b0e88701692e2de + 100 );
        }
        
        return ( gettime() > params.var_3b0e88701692e2de + 2000 );
    }
    
    return false;
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x2ec89e7d, Offset: 0xf2d8
// Size: 0x81, Type: bool
function private function_1bbbbfdbf5ac4ebf( params )
{
    razor = self;
    
    if ( razor.var_436d85c3fa135df6 )
    {
        params.var_eb4fa5ef492fcbeb = 0;
        params.var_c32f1dabd0a40652 = razor.var_436d85c3fa135df6[ 0 ];
        params.var_61eb9e7b72b14237 = razor.var_436d85c3fa135df6[ 1 ];
        razor.var_436d85c3fa135df6 = undefined;
    }
    else
    {
        level function_d4485ee4aeb0e70f( params );
    }
    
    return true;
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xbc155b40, Offset: 0xf362
// Size: 0x1ed
function private function_95002684b6906b85( params )
{
    razor = self;
    razor endon( #"death" );
    razor notify( #"razor_teleport" );
    
    if ( razor.grenade_on_mega_jump )
    {
        wait 1.5;
        var_80d912b322c791b9 = anglestoforward( ( 0, razor.angles[ 1 ], 0 ) );
        var_9dd41c98183c3514 = 16384;
        var_7c4df563cb5625b6 = 25000000;
        var_6bd24b5908983b7e = 60;
        var_6f277c6717c1733d = cos( var_6bd24b5908983b7e );
        playerscopy = arraycopy( level.players );
        
        foreach ( player in playerscopy )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            var_432605291f2cb6e9 = distancesquared( player.origin, params.jump_end );
            
            if ( var_432605291f2cb6e9 <= var_9dd41c98183c3514 )
            {
                continue;
            }
            
            var_23e55f91a5a9f5ee = distancesquared( player.origin, razor.origin );
            
            if ( var_23e55f91a5a9f5ee > var_7c4df563cb5625b6 )
            {
                continue;
            }
            
            var_eb6684aa34a63d0f = vectornormalize2( player.origin - razor.origin );
            var_685dcddaa76d6f32 = vectordot( var_80d912b322c791b9, var_eb6684aa34a63d0f );
            
            if ( var_685dcddaa76d6f32 < var_6f277c6717c1733d )
            {
                continue;
            }
            
            razor function_b3c3716e2fedee4b( razor.origin, player.origin, 3 );
            wait 0.1;
        }
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xee3201fd, Offset: 0xf557
// Size: 0x26
function private function_d2b05b641beec7b2( params )
{
    razor = self;
    razor notify( #"mega_jump_done" );
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0x8773529d, Offset: 0xf585
// Size: 0x50, Type: bool
function private function_5cfd84c20e94e1b2( starting_point, target_point )
{
    var_9b29474c307e8c9c = 16384;
    var_eef34eebe53b91da = 3240000;
    var_c04454b446a533d3 = distance2dsquared( starting_point, target_point );
    return var_c04454b446a533d3 > var_9b29474c307e8c9c && var_c04454b446a533d3 < var_eef34eebe53b91da;
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x6f46474b, Offset: 0xf5de
// Size: 0x15a
function private get_mega_jump_player_targets( activity_instance )
{
    razor = self;
    target_candidates = [];
    
    foreach ( player in level.players )
    {
        potential_target = getclosestpointonnavmesh( player.origin );
        var_acb388f4a19b0818 = level.var_815693d31ba0184a ?? 650;
        var_b647018b2d624684 = potential_target + ( 0, 0, var_acb388f4a19b0818 );
        var_de1ccfa13154a3fd = potential_target + ( 0, 0, -100 );
        trace_result = razor trace::ai_trace( var_b647018b2d624684, var_de1ccfa13154a3fd, undefined, [ player, razor ] );
        
        if ( trace_result[ "fraction" ] > 0.95 )
        {
            continue;
        }
        
        landing_pos = trace_result[ "shape_position" ];
        
        if ( landing_pos[ 2 ] - player.origin[ 2 ] > 100 )
        {
            continue;
        }
        
        target_candidates[ target_candidates.size ] = landing_pos;
    }
    
    return target_candidates;
}

// Namespace ob_nm_mode
// Params 3, eflags: 0x4
// Checksum 0xf6911d78, Offset: 0xf741
// Size: 0x1aa, Type: bool
function private is_landing_path_blocked( starting_pos, landing_pos, activity_instance )
{
    /#
        debug_draw_time = 60;
    #/
    
    trace_radius = 20;
    approx_offset = trace_radius * 2;
    var_f0b9ebb3a03994e4 = starting_pos - landing_pos;
    
    if ( length2d( var_f0b9ebb3a03994e4 ) > 0 )
    {
        var_b747624055b1917 = vectornormalize2( var_f0b9ebb3a03994e4 );
        var_d5eac5e9e21c4e0e = landing_pos + var_b747624055b1917 * approx_offset;
        secondary_trace_start = var_d5eac5e9e21c4e0e + ( 0, 0, 650 );
        secondary_trace_end = var_d5eac5e9e21c4e0e + ( 0, 0, -100 );
        trace_result = trace::sphere_trace( secondary_trace_start, secondary_trace_end, trace_radius, activity_instance.playerparticipants );
        
        /#
            if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
            {
                line( secondary_trace_start, secondary_trace_end, ( 1, 1, 1 ), 1, 0, debug_draw_time );
            }
        #/
        
        secondary_trace_pos = trace_result[ "position" ];
        
        if ( abs( secondary_trace_pos[ 2 ] - landing_pos[ 2 ] ) > 5 )
        {
            /#
                if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
                {
                    cylinder( secondary_trace_pos, secondary_trace_pos + ( 0, 0, 32 ), trace_radius, ( 1, 0, 0 ), 0, debug_draw_time );
                }
            #/
            
            return true;
        }
        else
        {
            /#
                if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
                {
                    cylinder( secondary_trace_pos, secondary_trace_pos + ( 0, 0, 32 ), trace_radius, ( 0, 1, 0 ), 0, debug_draw_time );
                }
            #/
        }
    }
    
    return false;
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x7041c4df, Offset: 0xf8f4
// Size: 0x122
function private is_launch_path_blocked( landingpos )
{
    razor = self;
    gravity_normal = ( 0, 0, -1 );
    gravity = getgravity();
    move_time = 2.5;
    delta = landingpos - razor.origin;
    drop = 0.5 * gravity * squared( move_time );
    drop *= gravity_normal;
    launch_velocity = ( delta - drop ) / move_time;
    var_654bd66f947de151 = 400;
    trace_start = razor.origin + vectornormalize( launch_velocity ) * 5;
    trace_end = razor.origin + vectornormalize( launch_velocity ) * var_654bd66f947de151;
    trace_content = trace::create_solid_ai_contents( 1 );
    trace_result = razor trace::ai_trace( trace_start, trace_end, undefined, razor, trace_content );
    
    if ( trace_result[ "fraction" ] < 0.95 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0xb53d635, Offset: 0xfa1e
// Size: 0x280
function private function_81f29517d4ea81d4( activity_instance, player_proximity_locations )
{
    razor = self;
    jump_target = player_proximity_locations[ 0 ];
    roof_height = 1700;
    
    foreach ( prox_location in player_proximity_locations )
    {
        if ( prox_location[ 2 ] >= roof_height )
        {
            jump_target = prox_location;
            break;
        }
    }
    
    if ( function_5cfd84c20e94e1b2( razor.origin, jump_target ) && !razor is_landing_path_blocked( razor.origin, jump_target ) && !razor is_launch_path_blocked( jump_target ) )
    {
        /#
            if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
            {
                iprintlnbold( "<dev string:x364>" );
            }
        #/
        
        return [ razor.origin, jump_target ];
    }
    
    jump_start_structs = arrayrandomize( level.boss_mega_jump_structs );
    jump_target_structs = arrayrandomize( level.boss_mega_jump_structs );
    
    foreach ( start_struct in jump_start_structs )
    {
        foreach ( var_fe41cd39c047e1b9 in jump_target_structs )
        {
            if ( function_5cfd84c20e94e1b2( start_struct.origin, var_fe41cd39c047e1b9.origin ) )
            {
                /#
                    if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
                    {
                        iprintlnbold( "<dev string:x385>" );
                    }
                #/
                
                return [ start_struct.origin, var_fe41cd39c047e1b9.origin ];
            }
        }
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xb07bf46b, Offset: 0xfca6
// Size: 0x256
function private function_105c2a18996320ad( activity_instance )
{
    razor = self;
    var_342ea920f91c7dc9 = 0;
    closest_start = razor.origin;
    sky_trace_result = razor trace::ai_trace( razor.origin + ( 0, 0, 5 ), razor.origin + ( 0, 0, 650 ), undefined, [ razor ] );
    
    if ( sky_trace_result[ "fraction" ] < 1 )
    {
        min_dist = 9999;
        
        foreach ( tele_struct in level.boss_mega_jump_structs )
        {
            curr_dist = distance( razor.origin, tele_struct.origin );
            
            if ( curr_dist < min_dist )
            {
                var_342ea920f91c7dc9 = 1;
                closest_start = tele_struct.origin;
                min_dist = curr_dist;
            }
        }
    }
    
    trace_budget = 5;
    var_e67d2b409143afde = arrayrandomize( level.boss_mega_jump_structs );
    
    foreach ( var_ed92d3edd3eded9 in var_e67d2b409143afde )
    {
        if ( function_5cfd84c20e94e1b2( closest_start, var_ed92d3edd3eded9.origin ) )
        {
            if ( !var_342ea920f91c7dc9 && !razor is_launch_path_blocked( var_ed92d3edd3eded9.origin ) )
            {
                trace_budget--;
                
                if ( trace_budget <= 0 )
                {
                    break;
                }
                else
                {
                    continue;
                }
            }
            
            /#
                if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
                {
                    iprintlnbold( "<dev string:x3a8>" );
                }
            #/
            
            return [ closest_start, var_ed92d3edd3eded9.origin ];
        }
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xd9fdd693, Offset: 0xff04
// Size: 0x276
function private function_d4485ee4aeb0e70f( params )
{
    activity_instance = self;
    params.var_eb4fa5ef492fcbeb = 0;
    
    if ( !params.player_proximity_locations )
    {
        player_proximity_locations = level.razor get_mega_jump_player_targets( activity_instance );
        params.player_proximity_locations = arrayrandomize( player_proximity_locations );
        params.var_eb4fa5ef492fcbeb = 1;
        return;
    }
    
    player_proximity_locations = params.player_proximity_locations;
    
    if ( player_proximity_locations.size > 0 )
    {
        current_location_index = params.player_location_index ?? 0;
        
        if ( current_location_index < player_proximity_locations.size )
        {
            var_942cd634ae969b3a = player_proximity_locations[ current_location_index ];
            var_2c24a20606b60e40 = 3;
            jump_structs = arrayrandomize( level.boss_mega_jump_structs );
            
            foreach ( current_struct in jump_structs )
            {
                if ( !function_5cfd84c20e94e1b2( current_struct.origin, var_942cd634ae969b3a ) )
                {
                    continue;
                }
                
                if ( level.razor is_landing_path_blocked( current_struct.origin, var_942cd634ae969b3a, activity_instance ) )
                {
                    var_2c24a20606b60e40--;
                    
                    if ( var_2c24a20606b60e40 <= 0 )
                    {
                        break;
                    }
                    
                    continue;
                }
                
                /#
                    if ( getdvarint( @"hash_fe1c45c378010b9d", 0 ) )
                    {
                        iprintlnbold( "<dev string:x3c7>" );
                    }
                #/
                
                params.var_c32f1dabd0a40652 = current_struct.origin;
                params.var_61eb9e7b72b14237 = var_942cd634ae969b3a;
                return;
            }
            
            params.player_location_index = current_location_index + 1;
            params.var_eb4fa5ef492fcbeb = 1;
            return;
        }
        else
        {
            fallback_route = level.razor function_81f29517d4ea81d4( activity_instance, player_proximity_locations );
            
            if ( isdefined( fallback_route ) )
            {
                params.var_c32f1dabd0a40652 = fallback_route[ 0 ];
                params.var_61eb9e7b72b14237 = fallback_route[ 1 ];
            }
            
            return;
        }
        
        return;
    }
    
    default_route = level.razor function_105c2a18996320ad( activity_instance );
    
    if ( isdefined( default_route ) )
    {
        params.var_c32f1dabd0a40652 = default_route[ 0 ];
        params.var_61eb9e7b72b14237 = default_route[ 1 ];
    }
    
    return;
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x3bdbf4fd, Offset: 0x10182
// Size: 0x3a6, Type: bool
function private mega_jump_attack( jumpcount )
{
    level.razor endon( #"death" );
    level.razor utility::ent_flag_set( "big_boss_attack" );
    num_jumps = jumpcount ?? 1;
    
    for ( current_jump = 0; current_jump < num_jumps ; current_jump++ )
    {
        if ( current_jump > 0 )
        {
            jump_start = level.razor.origin;
            jump_end = undefined;
            player_proximity_locations = level.razor get_mega_jump_player_targets( level );
            
            if ( player_proximity_locations.size > 0 )
            {
                player_proximity_locations = arrayrandomize( player_proximity_locations );
                
                foreach ( location in player_proximity_locations )
                {
                    if ( function_5cfd84c20e94e1b2( jump_start, location ) )
                    {
                        jump_end = location;
                        break;
                    }
                }
            }
            
            if ( !isdefined( jump_end ) )
            {
                var_e67d2b409143afde = arrayrandomize( level.boss_mega_jump_structs );
                
                foreach ( var_ed92d3edd3eded9 in var_e67d2b409143afde )
                {
                    if ( function_5cfd84c20e94e1b2( jump_start, var_ed92d3edd3eded9.origin ) )
                    {
                        jump_end = var_ed92d3edd3eded9.origin;
                        break;
                    }
                }
            }
            
            if ( !isdefined( jump_end ) )
            {
                roof_structs = arrayrandomize( level.boss_mega_jump_structs );
                
                foreach ( var_ed92d3edd3eded9 in roof_structs )
                {
                    if ( function_5cfd84c20e94e1b2( jump_start, var_ed92d3edd3eded9.origin ) )
                    {
                        jump_end = var_ed92d3edd3eded9.origin;
                        break;
                    }
                }
            }
            
            if ( !isdefined( jump_end ) )
            {
                break;
            }
            else
            {
                level.razor.var_436d85c3fa135df6 = [ jump_start, jump_end ];
            }
        }
        
        level.razor utility::ent_flag_set( "razor_scripted_mega_jumps" );
        result = level.razor utility::waittill_any_timeout( 10, "mega_jump_done" );
        level.razor utility::ent_flag_clear( "razor_scripted_mega_jumps" );
        
        if ( result != "mega_jump_done" )
        {
            logstring( "[RAZOR] mega_jump_attack timed out waiting for mega_jump_done" );
            level.razor motionwarpcancel();
            level.razor utility::ent_flag_clear( "big_boss_attack" );
            return false;
        }
        else
        {
            level.razor thread function_fa2a4a74d04185e( level.razor.origin );
            thread function_e9df31530b2163f9();
        }
        
        level.razor function_d5e895388c0cdf13( gettime() + randomintrange( 550, 800 ) );
        level.razor thread function_4f1235c57b026135();
    }
    
    level.razor utility::ent_flag_clear( "big_boss_attack" );
    return true;
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x7242ff9b, Offset: 0x10531
// Size: 0x8e
function function_e9df31530b2163f9()
{
    gas_circle_struct = spawnstruct();
    gas_circle_struct.origin = level.razor.origin;
    gas_circle_struct.angles = ( 0, 0, 0 );
    level ob_cradle_gas_circle::function_715467b4b7feb05a( gas_circle_struct, 1 );
    thread function_5971865d50338f18( gas_circle_struct.origin, gas_circle_struct.angles, level.players.size, "sat_spawner_zombie_base_ob" );
    wait 5;
    ob_cradle_gas_circle::function_ad1c37731b23fb82( gas_circle_struct );
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0x6876aec4, Offset: 0x105c7
// Size: 0x61
function function_b019dda3a8e747fe( request_id, data, agent, ai_data )
{
    agent endon( #"death" );
    
    if ( !isdefined( level.gas_zombies ) )
    {
        level.gas_zombies = [];
    }
    
    level.gas_zombies[ level.gas_zombies.size ] = agent;
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0x4ab75504, Offset: 0x10630
// Size: 0x188
function function_5971865d50338f18( origin, angles, count = 1, zombieaitype = "sat_spawner_zombie_base_ob" )
{
    if ( !isdefined( level.gas_zombies ) )
    {
        level.gas_zombies = [];
    }
    
    if ( !isdefined( level.boss_zombie_group ) )
    {
        level.boss_zombie_group = ai_spawn_director::function_e19f6a00c4bb7490( "boss_zombie_spawn", 0, 1, 1, 0, 3 );
        ai_spawn_director::function_35aa3b1d92cd8207( "OnSpawned", level.boss_zombie_group, &function_b019dda3a8e747fe );
    }
    
    max_alive = level.enemy_count_array ?? [ 6, 8, 10, 12 ];
    cap = set_enemy_count( max_alive );
    wait 1;
    level.gas_zombies = utility::array_removedead_or_dying( level.gas_zombies );
    remaining = cap - level.gas_zombies.size;
    
    if ( remaining <= 0 )
    {
        return;
    }
    
    if ( count > remaining )
    {
        count = remaining;
    }
    
    for ( i = 0; i < count ; i++ )
    {
        spawn_pos = getclosestpointonnavmesh( origin );
        playfx( level._effect[ "enemy_vfx" ], spawn_pos );
        ai_spawn_director::function_9893a28f1d682a28( level.boss_zombie_group, zombieaitype, spawn_pos, angles, 1, 0, 1, level.razor.team );
    }
}

// Namespace ob_nm_mode
// Params 0, eflags: 0xc
// Checksum 0x3fce8ca7, Offset: 0x107c0
// Size: 0x68
function private function_4f1235c57b026135()
{
    self notify( #"hash_8c5ba7281f054f9a" );
    self endon( #"hash_8c5ba7281f054f9a" );
    razor = self;
    razor endon( #"death", #"razor_teleport" );
    wait 5;
    teleport_struct = level choose_teleport_struct( level.boss_teleport_structs );
    razor function_b13fbfca816682f8( teleport_struct, undefined, undefined, 1 );
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0x969026a6, Offset: 0x10830
// Size: 0x201, Type: bool
function private function_1cb0df0e704933c( launchorigin, var_139ce90b9e096f2c )
{
    razor = self;
    razor endon( #"death" );
    var_a98cb6d17a72550d = 5000;
    var_8c33d36d010ba0f4 = razor.var_e394d1e674023dd1 ?? 0;
    
    if ( gettime() < var_8c33d36d010ba0f4 + var_a98cb6d17a72550d )
    {
        return false;
    }
    
    if ( razor.drone_launcher_drones && razor.drone_launcher_drones.size > 0 )
    {
        foreach ( drone in razor.drone_launcher_drones )
        {
            if ( drone )
            {
                drone drone_launcher::detonate_drone();
            }
        }
        
        wait 0.1;
        razor callback::callback( #"super_cancel" );
    }
    
    var_ee7873751a1ab517 = razor drone_launcher::begin_use();
    
    if ( !var_ee7873751a1ab517 )
    {
        return false;
    }
    
    if ( !isdefined( razor.plantedsuperequip ) )
    {
        razor.plantedsuperequip = [];
    }
    
    launch_origin = launchorigin ?? razor.origin + ( 0, 0, 32 );
    launch_vel = var_139ce90b9e096f2c ?? anglestoforward( razor.angles ) * 64;
    launcher = magicgrenademanual( "sat_drone_launcher_ob", launch_origin, launch_vel, 0, razor );
    razor.var_e394d1e674023dd1 = gettime();
    launcher.drone_launcher_overrides = { #drone_inner_damage:200, #drone_outer_damage:100, #drone_model:"veh_sat_mil_air_drone_launcher_quad_razor" };
    launcher waittill( #"death" );
    return true;
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0x7c45e14d, Offset: 0x10a3a
// Size: 0xc8
function private drone_launcher_attack()
{
    level.razor endon( #"death" );
    level.razor utility::ent_flag_set( "big_boss_attack" );
    teleport_struct = utility::array_random( level.bubble_shield_teleport_structs );
    level.razor function_b13fbfca816682f8( teleport_struct, "drone_launcher_teleport_done" );
    var_a698e366dc8d1cc4 = 1;
    
    if ( var_a698e366dc8d1cc4 )
    {
        level.razo waittill( #"drone_launcher_teleport_done" );
    }
    
    success = level.razor function_1cb0df0e704933c();
    level.razor utility::ent_flag_waitopen_any( "force_teleport_pending" );
    level.razor utility::ent_flag_clear( "big_boss_attack" );
    return success;
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x9cacb620, Offset: 0x10b0b
// Size: 0x91
function function_9e4534d6e265cf5b()
{
    level.razor waittill( #"razor_teleport" );
    
    if ( !isdefined( level.last_teleport_struct ) )
    {
        return;
    }
    
    if ( level.aisentryturrets.spawnedturrets.size > level.players.size )
    {
        return;
    }
    
    if ( !isdefined( level.aisentryturrets ) )
    {
        level.aisentryturrets = [];
    }
    
    if ( level.aisentryturrets.spawnedturrets.size < level.players.size )
    {
        level.last_teleport_struct thread spawn_turret();
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x58c28ee9, Offset: 0x10ba4
// Size: 0x15
function function_70467d6be224da52( ref )
{
    overlord::function_be2d6dc71f97faa6( ref );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xb0367df, Offset: 0x10bc1
// Size: 0x76
function function_53d442c8454b9844()
{
    level thread function_7765b4716ee79fd7();
    level thread function_dbbf34eef382d5c8();
    level.boss_teleport_structs = utility::getstructarray( "boss_teleport_structs", "script_noteworthy" );
    level.bubble_shield_teleport_structs = utility::getstructarray( "bubble_shield_teleport_structs", "script_noteworthy" );
    level.boss_mega_jump_structs = utility::getstructarray( "boss_mega_jump_structs", "script_noteworthy" );
    level.boss_block_traversal_structs = utility::getstructarray( "boss_block_traversal_structs", "script_noteworthy" );
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x77d937f4, Offset: 0x10c3f
// Size: 0x5b
function function_dbbf34eef382d5c8()
{
    level utility::flag_set( "razor_scene_start" );
    scene_struct = utility::getstruct( "razor_scene_struct", "targetname" );
    waitframe();
    
    if ( isdefined( scene_struct ) )
    {
        scene_struct scene::play( level.razor, "spawn_jelly_01", "sat_ai_spawn_air" );
        level utility::flag_set( "razor_scene_end" );
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x436c67e3, Offset: 0x10ca2
// Size: 0xfd
function phase_tracker()
{
    level.health_threshold = int( level.razor.maxhealth / 5 );
    level.health_threshold_1 = int( level.razor.maxhealth - level.health_threshold );
    level.health_threshold_2 = int( level.health_threshold_1 - level.health_threshold );
    level.health_threshold_3 = int( level.health_threshold_2 - level.health_threshold );
    level.health_threshold_4 = int( level.health_threshold_3 - level.health_threshold );
    level.health_threshold_5 = int( level.health_threshold_4 - level.health_threshold / 2 );
    level.health_threshold_6 = int( level.health_threshold_5 - level.health_threshold / 2 );
    waitframe();
    thread function_223ae88cb05609f();
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x588e3e88, Offset: 0x10da7
// Size: 0x75
function function_223ae88cb05609f()
{
    assert( isdefined( level.razor ) );
    level.razor.var_1e562e6847201882 = 1;
    level.razor.phase_floor = level.health_threshold_1;
    level.razor.phase_delay = 1;
    level.razor.phase_advancing = 0;
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x4f50023b, Offset: 0x10e24
// Size: 0x12e
function private function_1e7eccac82575c2e( delay )
{
    razor = self;
    razor endon( #"death" );
    razor.health = razor.phase_floor;
    razor update_healthbar();
    wait delay;
    razor.var_1e562e6847201882++;
    
    if ( razor.var_1e562e6847201882 == 2 )
    {
        razor.phase_floor = level.health_threshold_2;
    }
    
    if ( razor.var_1e562e6847201882 == 3 )
    {
        razor.phase_floor = level.health_threshold_3;
    }
    
    if ( razor.var_1e562e6847201882 == 4 )
    {
        razor.phase_floor = level.health_threshold_4;
    }
    
    if ( razor.var_1e562e6847201882 == 5 )
    {
        razor.phase_floor = level.health_threshold_5;
    }
    
    if ( razor.var_1e562e6847201882 >= 6 )
    {
        razor.phase_floor = level.health_threshold_6;
    }
    
    razor val::reset_all( "razor_phase_delay" );
    razor.phase_advancing = 0;
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x431f2c, Offset: 0x10f5a
// Size: 0x302
function function_fa2a4a74d04185e( originpoint )
{
    current_radius = 0;
    earthquake( 0.7, 0.3, originpoint, 6000 );
    playfx( level._effect[ "harper_slam" ], originpoint );
    playsoundatpos( originpoint, #"hash_6209a92ec21468be" );
    thread function_619612726bb47e08( originpoint, 6000, 1800 );
    level thread destroy_turrets( originpoint );
    
    while ( true )
    {
        max_radius = 6000;
        
        /#
            max_radius = getdvarfloat( @"hash_eb0728328b9612a0", 6000 );
        #/
        
        var_ccf9a72ba0ac0132 = 1800;
        
        /#
            var_ccf9a72ba0ac0132 = getdvarfloat( @"hash_9ae12f01fd46d8a0", 1800 );
        #/
        
        prev_radius = current_radius;
        current_radius += var_ccf9a72ba0ac0132 * level.framedurationseconds;
        
        /#
            if ( getdvarint( @"hash_82adc06924887d53", 0 ) )
            {
                cylinder( originpoint, originpoint + ( 0, 0, 10 ), current_radius, ( 1, 1, 0 ), 1, 1 );
            }
        #/
        
        player_radius = 16;
        
        /#
            player_radius = getdvarfloat( @"hash_bb65ec1ec6eb3ceb", 16 );
        #/
        
        radius_max = current_radius;
        radius_min = prev_radius;
        
        foreach ( player in level.players )
        {
            if ( player::isreallyalive( player ) && player.sessionstate == "playing" )
            {
                if ( !player function_dd48b56c28acb2e3( player_radius, originpoint, prev_radius, current_radius ) )
                {
                    continue;
                }
                
                if ( player.isstunned )
                {
                    continue;
                }
                
                if ( player is_above_shockwave( originpoint ) )
                {
                    continue;
                }
                
                if ( player is_below_shockwave( originpoint ) )
                {
                    continue;
                }
                
                if ( player isonground() )
                {
                    /#
                        if ( getdvarint( @"hash_82adc06924887d53", 0 ) )
                        {
                            cylinder( player.origin, player.origin + ( 0, 0, 2 ), player_radius, ( 1, 0, 0 ), 0, 400 );
                            var_ac26e3818b7168a8 = vectornormalize2( player.origin - originpoint );
                            var_d791d1e26b912fad = ( originpoint[ 0 ], originpoint[ 1 ], player.origin[ 2 ] );
                            var_4d5d4e179e2ae0ad = var_d791d1e26b912fad + var_ac26e3818b7168a8 * prev_radius;
                            var_3055b5bbc6767dbe = var_d791d1e26b912fad + var_ac26e3818b7168a8 * current_radius;
                            line( var_4d5d4e179e2ae0ad, var_3055b5bbc6767dbe, ( 1, 0, 0 ), 1, 0, 400 );
                        }
                    #/
                    
                    player thread function_ce258bccf32cf64b( originpoint );
                }
            }
        }
        
        if ( current_radius > max_radius )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x6edc8a26, Offset: 0x11264
// Size: 0x144
function function_ce258bccf32cf64b( originpoint )
{
    player = self;
    stun_duration = 1;
    player utility::setplayerstunned();
    
    /#
        iprintlnbold( "<dev string:x3e3>" );
    #/
    
    if ( player.nostun == 1 )
    {
        player.nostun = 0;
    }
    
    if ( level utility::flag( "flag_lethal_slam" ) )
    {
        player dodamage( 50, originpoint, player );
        var_40b66f58ae925367 = player.maxarmorhealth ?? 200;
        player armor::damagearmor( var_40b66f58ae925367 );
        player thread weapon_utility::cleanupconcussionstun( stun_duration );
        player thread shellshock_utility_cpmp::_shellshock( %"sat_ob_virgo_harper_slam", #"stun", stun_duration, 1, 500 );
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", 1, undefined, player, undefined, undefined, 0 );
        player playrumbleonentity( "damage_heavy" );
        return;
    }
    
    player dodamage( 30, originpoint, player );
    player thread weapon_utility::cleanupconcussionstun( stun_duration );
    player thread shellshock_utility_cpmp::_shellshock( %"sat_ob_virgo_harper_slam", #"stun", stun_duration, 1, 500 );
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", 1, undefined, player, undefined, undefined, 0 );
    player playrumbleonentity( "damage_heavy" );
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x15e1347a, Offset: 0x113b0
// Size: 0x5d, Type: bool
function private is_above_shockwave( originpoint )
{
    player = self;
    
    if ( !isdefined( originpoint ) )
    {
        return false;
    }
    
    if ( !isdefined( player.origin ) )
    {
        return false;
    }
    
    z_dist = player.origin[ 2 ] - originpoint[ 2 ];
    
    if ( z_dist > 32 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x72c65174, Offset: 0x11416
// Size: 0x6e, Type: bool
function private is_below_shockwave( originpoint )
{
    player = self;
    
    if ( level utility::flag( "flag_skip_slam_below_check" ) )
    {
        return false;
    }
    
    if ( !isdefined( originpoint ) )
    {
        return false;
    }
    
    if ( !isdefined( player.origin ) )
    {
        return false;
    }
    
    z_dist = originpoint[ 2 ] - player.origin[ 2 ];
    
    if ( z_dist > 32 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_nm_mode
// Params 4, eflags: 0x4
// Checksum 0xcb583b98, Offset: 0x1148d
// Size: 0x78, Type: bool
function private function_dd48b56c28acb2e3( ent_radius, wave_center, var_ea37701f14081978, var_aa226a6b39c78a6a )
{
    ent = self;
    var_b3f50ca949e18afc = distance2d( ent.origin, wave_center );
    ent_dist_min = var_b3f50ca949e18afc - ent_radius;
    ent_dist_max = var_b3f50ca949e18afc + ent_radius;
    return !( var_aa226a6b39c78a6a < ent_dist_min || var_ea37701f14081978 > ent_dist_max );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xdb9b35eb, Offset: 0x1150e
// Size: 0xa7
function destroy_turrets( originpoint )
{
    var_563c84cd7c4fb595 = getentarray( "veh_sat_mini_sentry", "targetname" );
    
    foreach ( turret in var_563c84cd7c4fb595 )
    {
        if ( turret utility::ent_flag( "mini_sentry_deployed" ) )
        {
            turret thread function_93221f8e48fc3c75( originpoint );
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x872e9fd2, Offset: 0x115bd
// Size: 0x51
function function_93221f8e48fc3c75( originpoint )
{
    self endon( #"death" );
    dist = distance( self.origin, originpoint );
    scalar_wait = 3 * dist / 6000;
    wait scalar_wait;
    thread mini_sentry::on_destruction( undefined );
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xa4df00da, Offset: 0x11616
// Size: 0x181
function function_619612726bb47e08( originpoint, max_radius, max_speed )
{
    /#
        max_radius = getdvarfloat( @"hash_eb0728328b9612a0", max_radius );
    #/
    
    var_ccf9a72ba0ac0132 = max_speed;
    
    /#
        var_ccf9a72ba0ac0132 = getdvarfloat( @"hash_9ae12f01fd46d8a0", max_speed );
    #/
    
    foreach ( player in level.players )
    {
        if ( player::isreallyalive( player ) && player.sessionstate == "playing" )
        {
            player_distance = distance( originpoint, player.origin );
            dir_to_player = vectornormalize( player.origin - originpoint );
            sound_ent = spawn( "script_model", originpoint );
            sound_ent setmodel( "tag_origin" );
            player playsoundtoplayer( "evt_rozar_shockwave", player, sound_ent );
            end_point = originpoint + dir_to_player * max_radius;
            travel_time = max_radius / var_ccf9a72ba0ac0132;
            sound_ent moveto( end_point, travel_time );
            sound_ent thread delete_after_move( travel_time + 0.5 );
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xfc6d2723, Offset: 0x1179f
// Size: 0x21
function delete_after_move( time )
{
    self endon( #"death" );
    wait time;
    self delete();
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xd87585f, Offset: 0x117c8
// Size: 0x6a
function end_of_round_fanfare( overlord_ref, splash, sound )
{
    level thread revive_squad();
    level thread nightmare_score_event();
    ob_story_mission_utils::function_94bd9141862a4ba6( level.players );
    
    if ( isdefined( splash ) )
    {
        nightmare_splash( splash, sound );
    }
    
    nightmare_transition_off();
    wait 1.5;
    
    if ( isdefined( overlord_ref ) )
    {
        function_70467d6be224da52( overlord_ref );
    }
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xaa30c6e8, Offset: 0x1183a
// Size: 0x62
function start_of_round_fanfare( overlord_ref, splash, sound )
{
    var_ad30c944bbd232d7 = 1;
    
    if ( isdefined( splash ) )
    {
        nightmare_splash( splash, sound );
    }
    
    nightmare_transition( undefined, 3, 1, var_ad30c944bbd232d7 );
    wait var_ad30c944bbd232d7 + 0.5;
    
    if ( isdefined( overlord_ref ) )
    {
        function_70467d6be224da52( overlord_ref );
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x242c8db9, Offset: 0x118a4
// Size: 0x98
function revive_squad()
{
    foreach ( player in level.players )
    {
        if ( player.inlaststand )
        {
            player ob::function_2b9dde49097a039e();
            player laststand::function_75e6bc3d39e1f2bb( player, "last_stand_revived" );
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x6a27d081, Offset: 0x11944
// Size: 0x6c
function function_3fc7f1f10018b737( value )
{
    if ( level.players.size == 1 )
    {
        return ( value * 2.5 );
    }
    
    if ( level.players.size == 2 )
    {
        return ( value * 1.5 );
    }
    
    if ( level.players.size == 3 )
    {
        return ( value * 1 );
    }
    
    if ( level.players.size == 4 )
    {
        return ( value * 1 );
    }
    
    return value;
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xa264ba1e, Offset: 0x119b9
// Size: 0x1b7
function vtol_boss_event( var_dc6a4b4b351da087, encounter_name, var_fcb964ac6f23a112 )
{
    start_of_round_fanfare( "nm_overlord_boss_start", "nm_boss_start" );
    self.var_9be376218db54aba = "sat_ob_objectivemarker_boss";
    
    if ( isdefined( var_fcb964ac6f23a112 ) )
    {
        var_fcb964ac6f23a112 = utility::getstruct( var_fcb964ac6f23a112, "targetname" );
    }
    
    level utility::flag_clear( "nightmare_encouter_done" );
    ob_story_mission_utils::objective_text_show( %"hash_1d6c1f3ae5d084d5" );
    time_modifier = function_3fc7f1f10018b737( 300 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread wave_fail_timer( time_modifier );
    level.var_a51e7c76bc4bf6e3 = spawn_vtol_boss( var_dc6a4b4b351da087 );
    level.var_a51e7c76bc4bf6e3 thread function_b103014f8ff76a0b();
    thread minion_encounter( encounter_name, "flag_vtol_boss_dead", 1, 3, 1 );
    level.var_a51e7c76bc4bf6e3 waittill( #"death" );
    level utility::flag_set( "flag_vtol_boss_dead" );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_hide();
    }
    
    level thread function_70467d6be224da52( "nm_overlord_boss_dead" );
    level notify( #"cleanup_minions" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level notify( #"hash_aefc5c470125baf8" );
    level notify( #"stop_circle" );
    end_of_round_fanfare();
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x3258598c, Offset: 0x11b78
// Size: 0x322
function spawn_vtol_boss( var_dc6a4b4b351da087 )
{
    namespace_f2445a4de17ee25::function_316cb76449f3acf7( "vtol", &function_d158eacdf2995e22 );
    ob_activity_gunship_heli::chopper_init();
    function_b4e57201bf2904e3();
    gunship_start = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    gunship_path_start = gunship_start namespace_be3150865da9d2f1::get_linked_struct();
    gunship_instance = spawnstruct();
    gunship_instance.var_b2596b0f06a9e7a1 = [];
    gunship_instance.bossname = "chopper";
    gunship_instance.var_cb5c81589a3b29d2 = "veh_sat_mil_vtol_ob_gunship_capricorn";
    gunship_instance.spawned = 0;
    gunship_instance.activity = self;
    gunship_instance.var_8c78435105a9f582 = 1;
    gunship_instance.spawnloc = gunship_start.origin;
    gunship_instance.patrolpath = gunship_path_start;
    gunship_instance ob_activity_gunship_heli::chopper_spawn();
    waitframe();
    gunship_instance.boss healthbar_setup();
    gunship_instance.chopper setturningability( 1 );
    gunship_instance.chopper setyawspeed( 250, 100, 50, 0.1 );
    gunship_instance.chopper.spawndata = gunship_instance;
    vehicle_occupancy::register_instance( gunship_instance.chopper );
    gunship_instance.chopper.damagecallback = &function_cf93665547ce031d;
    gunship_instance.chopper.flaresreservecount = 0;
    gunship_instance.chopper function_dd1f33638eed1c98( 0 );
    gunship_instance.chopper.var_9bd743060e96497e = 1;
    gunship_instance.boss.var_39ecac29b0a5f2b = 1;
    gunship_instance.boss.var_eb1bfd65428b7b41 = 1;
    gunship_instance.boss.var_359ce29c63efe084 = [ 0.7, 0.05, 0.02 ];
    gunship_instance.boss.minheight = gunship_start.origin[ 2 ];
    gunship_instance.boss.var_19a36b17776e8e85 = 1;
    gunship_instance.boss.attackcounter = 0;
    gunship_instance.boss.originalspeed = 100;
    gunship_instance.boss.originalaccel = 50;
    gunship_instance.boss vehicle_setspeed( gunship_instance.boss.originalspeed, gunship_instance.boss.originalaccel );
    gunship_instance.chopper.missileweapon = makeweapon( "sat_la_ztron_fireball_virgo" );
    gunship_instance.boss utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "veh_sat_mil_vtol_ob_gunship_capricorn" );
    return gunship_instance.boss;
}

// Namespace ob_nm_mode
// Params 11, eflags: 0x4
// Checksum 0x7b3fc7de, Offset: 0x11ea3
// Size: 0x68
function private function_d158eacdf2995e22( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    return idamage;
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0xa670a6bb, Offset: 0x11f14
// Size: 0x166
function private function_b4e57201bf2904e3()
{
    minplayersize = level.players.size > 0 ? level.players.size : 1;
    level.var_adaaa86b7b5a18b6 = 100000 * minplayersize;
    level.var_db391e86c6c1bbc2 = 250;
    level.var_c582f0f1f598788e = 2;
    level.var_da9d0112ff45d16b = 6;
    level.var_1c413c0f520b77a1 = 1000;
    level.var_ef819189ba3c6250 = 15000;
    level.var_1b807c86f79fc8d6 = 32;
    level.var_c15d0d0ad1e767fb = 18;
    level.var_3375c4f7793b4ccb = 8;
    level.var_be17f6f2696e1d1a = 2500;
    level.var_1be27c807e9e9d09 = 5.75;
    level.var_679b2cb4aec6cf81 = 0.7;
    level.var_9275920438b54a87 = 4;
    level.var_9298800438db6aa9 = 4;
    level.var_99790c03689d056 = 1.75;
    level.var_146d94309e2e75bb = 2;
    level.var_c915f7191eab3985 = 155;
    level.var_c915f4191eab32ec = 75;
    level.var_c915f5191eab351f = 10;
    level.var_e05429687d6711be = 1;
    level.var_9b32f3255542d1f7 = 12000;
    level.var_89ef72f6589587f0 = 0;
    level.var_99cc0ae0a9c90f54 = 1;
    level.var_a9f499aba9fe4113 = 0;
    level.var_59e1d7f72751378 = 1;
    level.var_6f9c69487979a715 = 1;
    level.var_ac384fdf4664f6cc = 1;
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x14c5c714, Offset: 0x12082
// Size: 0x8c
function healthbar_setup()
{
    foreach ( player in level.players )
    {
        player thread ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_advanced_guild_vtol", self );
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace ob_nm_mode
// Params 14, eflags: 0x4
// Checksum 0x3e313dba, Offset: 0x12116
// Size: 0xdf
function private function_cf93665547ce031d( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    if ( namespace_7161222aac9ca916::function_bcc82514dd1dd6ff() )
    {
        if ( level.var_9fe4187b1b7cd52e )
        {
            attacker damagefeedback::updatedamagefeedback( "hitimmune", 0, 0 );
        }
        
        return;
    }
    
    if ( attacker == self )
    {
        return;
    }
    
    damage *= 20;
    [[ level.vehicles.damagecallback ]]( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x6a6c1160, Offset: 0x121fd
// Size: 0x9f
function function_dd1f33638eed1c98( value )
{
    namespace_cf9a4f547edbca10::function_495220db898177a0( value );
    
    foreach ( player in level.players )
    {
        if ( value )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
            continue;
        }
        
        player ob_story_mission_utils::player_boss_healthbar_show();
    }
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0xe52763aa, Offset: 0x122a4
// Size: 0xc3
function function_b103014f8ff76a0b( var_22ef1bb6bef5ba13, var_22ef1cb6bef5bc46, rocket_hint_health )
{
    level endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, point, type, modelname, attachtagname, partname, dflags, objweapon );
        healthbar_update( amount, self.max_health );
    }
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x5c9bdb15, Offset: 0x1236f
// Size: 0xce
function healthbar_update( damage, max_health )
{
    health_frac = self.health / self.maxhealth;
    
    foreach ( player in level.players )
    {
        if ( self.health > 0 )
        {
            player ob_story_mission_utils::function_e231206f1628d4c6( 1, health_frac * 100, 100 );
            continue;
        }
        
        player ob_story_mission_utils::player_boss_healthbar_hide();
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x32c3bb2, Offset: 0x12445
// Size: 0x8e
function init_teleport_triggers()
{
    structs = utility::getstructarray( "teleport_struct", "targetname" );
    
    foreach ( teleport_point in structs )
    {
        teleport_point thread function_1487104cac424c2a();
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x88c2f733, Offset: 0x124db
// Size: 0xd4
function function_1487104cac424c2a()
{
    teleport_start = self;
    teleport_end = utility::getstruct( teleport_start.target, "targetname" );
    trigger = spawn( "trigger_radius", teleport_start.origin, 0, 64, 64 );
    portal = spawn( "script_model", teleport_start.origin + ( 0, 0, 40 ) );
    portal.angles = teleport_start.angles;
    portal setmodel( "sat_destruction_sim_wc_portal_05" );
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            cradle_teleport( ent, teleport_end );
        }
    }
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0x585f20a5, Offset: 0x125b7
// Size: 0x98
function cradle_teleport( player, s_teleport_ref )
{
    playfx( level._effect[ "enemy_vfx" ], player.origin );
    wait_time = 0.25;
    player hud_util::fade_out( wait_time, "white" );
    player freezecontrols( 1 );
    coop::teleport_player( player, s_teleport_ref );
    playfx( level._effect[ "enemy_vfx" ], s_teleport_ref.origin );
    wait wait_time;
    player hud_util::fade_in( wait_time, "white" );
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x4e22e8ab, Offset: 0x12657
// Size: 0xef
function setup_minefield( minefield_array, var_6a02108301e17dc = 250, offset )
{
    setdvarifuninitialized( @"hash_b6f86ed8c140d85", var_6a02108301e17dc );
    owner = spawn( "script_origin", minefield_array[ 0 ].origin );
    
    foreach ( struct in minefield_array )
    {
        mine = ob_soldier_util::ob_mine_spawn( struct.origin + offset, undefined, owner, undefined, struct.angles, 1 );
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xf0137a96, Offset: 0x1274e
// Size: 0x2de
function function_f20a9fe6c594f5b3( var_5310aea068a35a30 )
{
    if ( var_5310aea068a35a30 )
    {
        foreach ( player in level.players )
        {
            foreach ( player in level.players )
            {
                player val::set( "cinematic", "hide", 1 );
                player val::set( "cinematic", "hide_viewmodel", 1 );
                player val::set( "cinematic", "allow_jump", 0 );
                player val::set( "cinematic", "allow_movement", 0 );
                player val::set( "cinematic", "crouch", 0 );
                player val::set( "cinematic", "prone", 0 );
                player val::set( "cinematic", "melee", 0 );
                player val::set( "cinematic", "offhand_primary_weapons", 0 );
                player val::set( "cinematic", "offhand_secondary_weapons", 0 );
                player val::set( "cinematic", "weapon", 0 );
                player val::set( "cinematic", "damage", 0 );
                player val::set( "cinematic", "killstreaks", 0 );
                player val::set( "cinematic", "ignoreme", 1 );
                player val::set( "cinematic", "freezecontrols", 1 );
                player val::set( "cinematic", "ads", 0 );
                player val::set( "cinematic", "weapon_switch", 0 );
                player val::set( "cinematic", "action_slot_weapon", 0 );
                player val::set( "cinematic", "armor", 0 );
                player val::set( "cinematic", "supers", 0 );
            }
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player val::reset_all( "cinematic" );
    }
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x51103871, Offset: 0x12a34
// Size: 0x15f
function setup_boss_healthbar( health, maxhealth, health_bar_asset )
{
    callback::add( #"on_ai_damaged", &boss_on_damage );
    health_struct = spawnstruct();
    health_struct.health = health;
    health_struct.maxhealth = maxhealth;
    
    foreach ( player in level.players )
    {
        player thread ob_story_mission_utils::function_16e0adef86e5d052( health_bar_asset, health_struct );
    }
    
    level.health_struct = health_struct;
    self waittill( #"death" );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x450f87a7, Offset: 0x12b9b
// Size: 0x89
function heal_boss( frac )
{
    boss = self;
    boss endon( #"death" );
    amount = int( boss.maxhealth * frac );
    heal_attempt = int( boss.health + amount );
    boss.health = clamp( heal_attempt, 0, int( boss.maxhealth ) );
    boss update_healthbar();
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0x4347f265, Offset: 0x12c2c
// Size: 0x22
function private boss_on_damage( params )
{
    boss = self;
    boss update_healthbar();
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0xf07ff581, Offset: 0x12c56
// Size: 0x120
function function_7e4765db24e0ee73( state = "off", force_field_name, key = #targetname, remove_power_supply )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !level.var_ad5a2bd25598da74 )
    {
        scriptable::scriptable_addnotifycallback( "force_field_death", &force_field_power_supply_death );
        level.var_ad5a2bd25598da74 = 1;
    }
    
    force_fields = getentarray( force_field_name, key );
    
    foreach ( ff in force_fields )
    {
        ff force_field_setup();
        
        if ( state == "off" )
        {
            ff force_field_off( 1, remove_power_supply );
            continue;
        }
        
        ff force_field_on();
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x6ba024f, Offset: 0x12d7e
// Size: 0x4af
function force_field_setup()
{
    ff = self;
    ff hide( 1 );
    ff notsolid();
    
    if ( ff.inited )
    {
        return;
    }
    
    ff.targetscriptables = getscriptablearray( ff.target, #targetname );
    isdestroyed = 0;
    
    if ( isdefined( ff.targetscriptables ) )
    {
        foreach ( scriptable in ff.targetscriptables )
        {
            if ( scriptable.script_noteworthy == "power_supply" )
            {
                ff.power_supply = scriptable;
                
                if ( !isdefined( scriptable.ff ) )
                {
                    scriptable.ff = [];
                }
                
                isdestroyed = scriptable getscriptablepartstate( "force_field_power_supply", 1 ) == "destroyed";
                scriptable.ff[ scriptable.ff.size ] = ff;
            }
        }
    }
    
    if ( isdefined( ff.script_linkto ) )
    {
        ff.var_7c4a63493e09272c = ff utility::function_e1bb0bf82dab729e();
        
        if ( isdefined( ff.var_7c4a63493e09272c[ 0 ] ) )
        {
            ff.ff_scriptable = ff.var_7c4a63493e09272c[ 0 ];
        }
    }
    
    ff.targetents = getentarray( ff.target, "targetname" );
    
    if ( isdefined( ff.targetents ) )
    {
        foreach ( ent in ff.targetents )
        {
            if ( ent.script_noteworthy == "power_cable" )
            {
                ff.power_cable = ent;
                
                if ( !isdefined( ff.power_supply.power_cable ) )
                {
                    tokens = strtok( ent.model, "::" );
                    
                    if ( isdefined( tokens[ 1 ] ) )
                    {
                        ent.base_model_name = tokens[ 1 ];
                    }
                    
                    ff.power_supply.power_cable = ent;
                }
            }
        }
    }
    
    if ( isdestroyed )
    {
        ff.inited = 1;
        ff force_field_off();
        return;
    }
    
    ff.targetstructs = utility::getstructarray( ff.target, "targetname" );
    
    if ( isdefined( ff.targetstructs ) )
    {
        foreach ( struct in ff.targetstructs )
        {
            if ( struct.script_noteworthy == "interact" )
            {
                ff.interact_struct = struct;
                
                if ( !isdefined( struct.ff ) )
                {
                    struct.ff = [];
                }
                
                struct.ff[ struct.ff.size ] = ff;
                
                if ( !isdefined( struct.interact ) )
                {
                    struct.interact = interaction::register_interact( struct.origin, 32, &function_fb4826422bc54835, &"sat_ob_story_missions/interact_toggle", undefined, undefined, undefined, "HINT_BUTTON" );
                    struct.interact sethintdisplayrange( 100 );
                }
                
                if ( !isdefined( struct.interact.ff ) )
                {
                    struct.interact.ff = [];
                }
                
                struct.interact.ff[ struct.interact.ff.size ] = ff;
                ff.interact = struct.interact;
            }
        }
    }
    
    ff.inited = 1;
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0xa6e13979, Offset: 0x13235
// Size: 0x241
function force_field_on()
{
    ff = self;
    
    if ( isdefined( ff.on ) )
    {
        return;
    }
    
    if ( isdefined( ff.targetscriptables ) )
    {
        foreach ( scriptable in ff.targetscriptables )
        {
            if ( scriptable.script_noteworthy == "power_supply" )
            {
                if ( scriptable getscriptablepartstate( "force_field_power_supply", 1 ) == "destroyed" )
                {
                    return;
                }
            }
        }
    }
    
    ff show();
    ff solid();
    
    if ( isdefined( ff.power_supply.power_cable ) )
    {
        ff.power_supply.power_cable function_4fdecaa2fa5ed383( 1 );
    }
    
    ff.ff_scriptable setscriptablepartstate( "main", "startup" );
    nav_ent = getent( ff.script_parameters, #script_noteworthy );
    
    if ( nav_ent )
    {
        ff.var_12aadf5d8bbfdafd = function_aafd9c2a00b86dba( nav_ent, "custom_default_on" );
    }
    else
    {
        ff.var_12aadf5d8bbfdafd = function_aafd9c2a00b86dba( ff, "custom_default_on" );
    }
    
    if ( isdefined( ff.script_fxid ) )
    {
        utility::exploder( ff.script_fxid );
    }
    
    if ( !isdefined( ff.audio_loop ) )
    {
        ff.audio_loop = snd::play( "amb_force_field_lp", ff.origin );
        snd::play( "amb_force_field_switch_on", ff.origin );
    }
    
    if ( isdefined( ff.interact ) )
    {
        snd::play( "uin_force_field_switch_on", ff.interact.origin );
        ff.interact sethintstring( &"sat_ob_story_missions/interact_toggle" );
    }
    
    ff.on = 1;
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0xae2567c9, Offset: 0x1347e
// Size: 0x1ca
function force_field_off( scripted_off, remove_power_supply = 0 )
{
    ff = self;
    
    if ( isdefined( ff.power_supply.power_cable ) )
    {
        ff.power_supply.power_cable function_4fdecaa2fa5ed383( 0 );
    }
    
    if ( remove_power_supply )
    {
        ff.power_supply setscriptablepartstate( "force_field_power_supply", "off" );
    }
    
    ff notsolid();
    ff hide( 1 );
    
    if ( scripted_off )
    {
        ff.ff_scriptable setscriptablepartstate( "main", "off" );
    }
    else
    {
        ff.ff_scriptable setscriptablepartstate( "main", "shut down" );
    }
    
    if ( isdefined( ff.var_12aadf5d8bbfdafd ) )
    {
        destroynavobstacle( ff.var_12aadf5d8bbfdafd );
    }
    
    if ( isdefined( ff.script_fxid ) )
    {
        utility::stop_exploder( ff.script_fxid );
    }
    
    if ( isdefined( ff.audio_loop ) )
    {
        snd::stop( ff.audio_loop );
        ff.audio_loop = undefined;
        snd::play( "amb_force_field_switch_off", ff.origin );
    }
    
    if ( isdefined( ff.interact ) )
    {
        snd::play( "uin_force_field_switch_off", ff.interact.origin );
        ff.interact sethintstring( &"sat_ob_story_missions/interact_toggle" );
    }
    
    if ( !scripted_off )
    {
        if ( isdefined( ff.script_flag_set ) )
        {
            level utility::flag_set( ff.script_flag_set );
        }
    }
    
    ff.on = undefined;
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x85a7faab, Offset: 0x13650
// Size: 0x1f
function function_90c440460dba0ba2( var_ab4b4c27b2c67244 )
{
    if ( isdefined( var_ab4b4c27b2c67244 ) )
    {
        self function_78a8bbd6805e6296( "custom_default_on", var_ab4b4c27b2c67244 );
    }
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0x1639a7e4, Offset: 0x13677
// Size: 0xe4
function force_field_power_supply_death( instance, note, param, var_64ffacba090c91be )
{
    if ( isdefined( instance.entity.ff ) )
    {
        foreach ( ff in instance.entity.ff )
        {
            if ( isdefined( ff.interact ) )
            {
                ff.interact delete();
            }
            
            ff force_field_off();
        }
    }
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xd9185ffc, Offset: 0x13763
// Size: 0x50
function function_4fdecaa2fa5ed383( var_e619071b03ea2479 )
{
    if ( var_e619071b03ea2479 )
    {
        variant = "on::";
        self setmodel( variant + self.base_model_name );
        return;
    }
    
    variant = "base::";
    self setmodel( variant + self.base_model_name );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xefda0927, Offset: 0x137bb
// Size: 0xb8
function function_fb4826422bc54835( player )
{
    self endon( #"death" );
    
    if ( isdefined( self.ff ) )
    {
        foreach ( ff in self.ff )
        {
            if ( ff.on )
            {
                ff force_field_off();
                continue;
            }
            
            ff force_field_on();
        }
    }
}

// Namespace ob_nm_mode
// Params 4
// Checksum 0x7d9b01c0, Offset: 0x1387b
// Size: 0xab
function kill_obj_count( one_player = 60, two_player = 90, three_player = 120, four_player = 150 )
{
    count = 100;
    
    if ( level.players.size == 1 )
    {
        count = one_player;
    }
    
    if ( level.players.size == 2 )
    {
        count = two_player;
    }
    
    if ( level.players.size == 3 )
    {
        count = three_player;
    }
    
    if ( level.players.size == 4 )
    {
        count = four_player;
    }
    
    return count;
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x8221f7ae, Offset: 0x1392f
// Size: 0xa8
function watch_solo_player()
{
    self notify( #"hash_a6cb5393bc0809f2" );
    self endon( #"hash_a6cb5393bc0809f2" );
    level endon( #"game_ended" );
    level.var_49940117feb022ef = 1;
    
    while ( true )
    {
        if ( level.players.size > 0 )
        {
            if ( !isdefined( solo_guid ) )
            {
                solo_guid = level.players[ 0 ].guid;
            }
            
            if ( level.players.size > 1 || level.players[ 0 ].guid != solo_guid )
            {
                level.var_49940117feb022ef = undefined;
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace ob_nm_mode
// Params 0
// Checksum 0x13eaeaa8, Offset: 0x139df
// Size: 0x93
function function_5d8b6d15b5f5cda9()
{
    thread function_e3e378a5bfd0e84c();
    result = utility::waittill_any_return( "death", "soul_vfx_abort" );
    
    if ( result == "soul_vfx_abort" )
    {
        return;
    }
    
    var_46063ece3767f60b = self.origin + ( 0, 0, 32 );
    endpos = level.endpos;
    
    if ( !isdefined( endpos ) )
    {
        endpos = var_46063ece3767f60b + ( 0, 0, 200 );
        level.endpos = endpos;
    }
    
    function_72282522248ae734( var_46063ece3767f60b, endpos );
}

// Namespace ob_nm_mode
// Params 0, eflags: 0x4
// Checksum 0x4b9b6a8e, Offset: 0x13a7a
// Size: 0x60
function private function_e3e378a5bfd0e84c()
{
    self endon( #"death" );
    self endon( #"soul_vfx_abort" );
    
    if ( level utility::flag( "nightmare_encouter_done" ) || !level utility::flag( "nightmare_encouter_active" ) )
    {
        self notify( #"soul_vfx_abort" );
        return;
    }
    
    level waittill( #"hash_f8318a5d48451de5" );
    self notify( #"soul_vfx_abort" );
}

// Namespace ob_nm_mode
// Params 2
// Checksum 0xba3440ab, Offset: 0x13ae2
// Size: 0x60
function function_72282522248ae734( startpos, endpos )
{
    path_info = function_fdee9f19da89757d( startpos, endpos );
    function_2bcff8b80bc30d8( startpos, endpos, path_info.bezier_end_pos, path_info.bezier_control_pos, path_info.random_radius, path_info.spiral_height );
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0x200b8669, Offset: 0x13b4a
// Size: 0x114
function private function_fdee9f19da89757d( startpos, endpos )
{
    random_radius = randomintrange( 50, 151 );
    var_be45aa444243dd60 = randomintrange( -50, 51 );
    var_724163bd4b3d2439 = randomintrange( 30, 91 );
    var_473a4a2e7060cbdd = vectortoangles( endpos - startpos );
    var_c7f1904230e9da61 = int( var_473a4a2e7060cbdd[ 1 ] - var_724163bd4b3d2439 );
    bezier_end_pos = endpos + ( random_radius * cos( var_c7f1904230e9da61 ), random_radius * sin( var_c7f1904230e9da61 ), 0 ) + ( 0, 0, var_be45aa444243dd60 );
    var_16b36c997f81e1e = var_c7f1904230e9da61 + 90;
    bezier_control_pos = bezier_end_pos + anglestoforward( ( 0, var_16b36c997f81e1e, 0 ) ) * -0.5 * distance( startpos, endpos ) + ( 0, 0, var_be45aa444243dd60 );
    spiral_height = bezier_end_pos[ 2 ] - endpos[ 2 ];
    return { #spiral_height:spiral_height, #random_radius:random_radius, #bezier_control_pos:bezier_control_pos, #bezier_end_pos:bezier_end_pos };
}

// Namespace ob_nm_mode
// Params 6, eflags: 0x4
// Checksum 0xf166957b, Offset: 0x13c67
// Size: 0x1de
function private function_2bcff8b80bc30d8( startpos, endpos, bezier_end, bezier_control_point, radius, spiral_height )
{
    var_b304159877816eb9 = distancesquared( startpos, bezier_end );
    var_58c89811f3b06a50 = mapfloat( 0, 360000, 0.35, 0.65, var_b304159877816eb9 );
    var_324fd5ce37eb5bfa = max( 1, 3.14159 * radius / 500 );
    level.spiral_time = var_324fd5ce37eb5bfa;
    
    if ( !isdefined( self.var_8b45b0401d2cc8a3 ) )
    {
        self.var_8b45b0401d2cc8a3 = 0;
    }
    
    if ( self.var_8b45b0401d2cc8a3 >= 15 || distance2d( startpos, endpos ) >= 2000 )
    {
        wait var_58c89811f3b06a50 + 2 + 0.2;
        return;
    }
    
    self.var_8b45b0401d2cc8a3++;
    mover = utility::spawn_model( "tag_origin", startpos, ( 0, 0, 0 ) );
    var_40b6ca8a4b46d231 = 0;
    
    /#
        if ( getdvarint( @"hash_b1ab1359416a2026", 0 ) )
        {
            var_40b6ca8a4b46d231 = 1;
            thread function_4e1052cf54a5a800( startpos, endpos, bezier_end, bezier_control_point, radius, spiral_height, mover, var_324fd5ce37eb5bfa );
        }
    #/
    
    scriptable = spawnscriptable( %"sat_ob_red_flood_cradle_collect_fx", startpos );
    scriptable utility::scriptable_setparententity( mover );
    mover utility::function_8001268940441423( startpos, bezier_end, bezier_control_point, var_58c89811f3b06a50, var_40b6ca8a4b46d231, 1 );
    mover utility::follow_spiral( radius, 0, ( 0, 0, 1 ), spiral_height * -1, var_324fd5ce37eb5bfa, endpos, 1, 0 );
    
    /#
        if ( var_40b6ca8a4b46d231 )
        {
            mover.var_e2fd305459d7c640 = 1;
        }
    #/
    
    scriptable setscriptablepartstate( #"body", #"impact" );
    wait 0.2;
    scriptable freescriptable();
    mover delete();
    self.var_8b45b0401d2cc8a3--;
}

/#

    // Namespace ob_nm_mode
    // Params 8, eflags: 0x4
    // Checksum 0x64c69de, Offset: 0x13e4d
    // Size: 0x191, Type: dev
    function private function_4e1052cf54a5a800( startpos, endpos, bezier_end, bezier_control_point, radius, spiral_height, mover, var_324fd5ce37eb5bfa )
    {
        level endon( #"game_ended" );
        mover endon( #"death" );
        sphere( startpos, 5, ( 0, 1, 0 ), 0, int( 10 / level.framedurationseconds ) );
        sphere( endpos, 5, ( 0, 1, 0 ), 0, int( 10 / level.framedurationseconds ) );
        sphere( bezier_end, 5, ( 1, 0, 0 ), 0, int( 10 / level.framedurationseconds ) );
        sphere( bezier_control_point, 5, ( 0, 0, 1 ), 0, int( 10 / level.framedurationseconds ) );
        line( bezier_end, bezier_control_point, ( 1, 1, 1 ), 1, 0, int( 10 / level.framedurationseconds ) );
        mover waittill( #"hash_63c37028d5d0eecc" );
        
        for ( oldpos = mover.origin; !mover.var_e2fd305459d7c640 ; oldpos = mover.origin )
        {
            waitframe();
            mover thread utility::draw_line_for_time( mover.origin, oldpos, 1, 1, 1, var_324fd5ce37eb5bfa * 10 );
        }
    }

#/

// Namespace ob_nm_mode
// Params 3
// Checksum 0xcfdf9a64, Offset: 0x13fe6
// Size: 0xd3
function function_5dd43e7cb0682d57( var_dc6a4b4b351da087, location, offset = ( 0, 0, 48 ) )
{
    level.catchup_location = ob_story_mission_utils::get_activity_starts( location );
    utility::add_fx( "teleport_point", "vfx_sat_wc_gameplay_nightmare_gateway_loop" );
    wait 1;
    button = utility::getstructarray( var_dc6a4b4b351da087, "targetname" )[ 0 ];
    playfx( level._effect[ "teleport_point" ], button.origin );
    interact = interaction::register_interact( button.origin + offset, 80, &teleport_interact, &"sat_ob_story_missions/interact_activate" );
    interact setcursorhint( "HINT_BUTTON" );
    interact setuseholdduration( 0 );
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0x1a0a94a2, Offset: 0x140c1
// Size: 0xda
function teleport_interact( player )
{
    player val::set( "nightmare_teleport", "allow_movement", 0 );
    player val::set( "nightmare_teleport", "allow_teleport", 0 );
    player val::set( "nightmare_teleport", "allow_gadgets", 0 );
    player utility::delaythread( 2, &val::reset_all, "nightmare_teleport" );
    player ob::function_2b9dde49097a039e();
    structs = level.catchup_location;
    squad = [ player ];
    level coop::teleport_player( player, structs[ 0 ] );
    player lerpfovbypreset( "default_200ms" );
    player clearpredictedstreampos();
    pbgpostfxbundlestart( player, %"sat_ob_cradle_portal_out" );
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 1.5, undefined, [ player ], undefined, undefined, 1 );
}

// Namespace ob_nm_mode
// Params 3
// Checksum 0x864c81dc, Offset: 0x141a3
// Size: 0x147
function function_3b33d641fd3a8730( ent, number = 1, max = 3 )
{
    if ( !isdefined( ent.var_2db42cf2b39085c1 ) )
    {
        ent.var_2db42cf2b39085c1 = 0;
    }
    
    var_8b0c4e78c85d9963 = randomfloat( 360 );
    
    for ( i = 0; i < number ; i++ )
    {
        if ( ent.var_2db42cf2b39085c1 >= max )
        {
            break;
        }
        
        var_374b2994374fef27 = randomintrange( 350, 700 );
        var_a3031508254beebf = randomintrange( 75, 150 );
        frontvector = vectornormalize( anglestoforward( ( 0, function_63a2ef74ebcc6413( var_8b0c4e78c85d9963 + 120 * i ), 0 ) ) );
        shockstick = magicgrenademanual( "shock_stick_mp", ent.origin + frontvector * 30 + ( 0, 0, 128 ), frontvector * var_374b2994374fef27 + ( 0, 0, var_a3031508254beebf ) );
        shockstick setscriptablepartstate( "electric", "active", 0 );
        shockstick setscriptablepartstate( "detonate", "detonate", 0 );
        ent.var_2db42cf2b39085c1++;
        shockstick thread function_394f12a68648f1f5( ent );
    }
}

// Namespace ob_nm_mode
// Params 1, eflags: 0x4
// Checksum 0xe77c6e03, Offset: 0x142f2
// Size: 0x128
function private function_394f12a68648f1f5( ent )
{
    self endon( #"death" );
    victim_array = [];
    var_99734d34b9b3181c = 0;
    lifespan = level.var_234e5722481abc4c ?? 50;
    
    while ( var_99734d34b9b3181c <= lifespan )
    {
        var_fc34ba2af1bf33a4 = getplayersinradius( self.origin, 128 );
        
        foreach ( player in var_fc34ba2af1bf33a4 )
        {
            if ( arraycontains( victim_array, player ) || player isvehicleactive() )
            {
                continue;
            }
            
            thread lightning_strike_onplayer( player );
            victim_array[ victim_array.size ] = player;
        }
        
        wait 0.1;
        var_99734d34b9b3181c++;
    }
    
    if ( ent )
    {
        if ( ent.var_2db42cf2b39085c1 )
        {
            ent.var_2db42cf2b39085c1--;
        }
    }
    
    shock_stick::shockstick_destroy();
}

// Namespace ob_nm_mode
// Params 1
// Checksum 0xd297e2ae, Offset: 0x14422
// Size: 0x5c
function lightning_strike_onplayer( victim )
{
    if ( isplayer( victim ) )
    {
        gestureref = "vm_ges_shockstick_react";
        curweapon = victim getcurrentweapon();
        
        if ( weapon::isfistweapon( curweapon ) )
        {
            gestureref = "vm_ges_shockstick_react_fists";
        }
    }
    
    function_587b716c0017a582( victim, gestureref );
    function_31824bd75805628( victim, gestureref );
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0xf1aed385, Offset: 0x14486
// Size: 0xf1
function private function_587b716c0017a582( victim, gestureref )
{
    if ( !player::isreallyalive( victim ) )
    {
        return;
    }
    
    victim endon( #"death_or_disconnect" );
    victim utility::ent_flag_set( "flag_fail_shock_challenge" );
    victim shock_stick::function_904e61c3aefb61c2( 1 );
    
    if ( victim.revivingteammate )
    {
        victim.var_45ab03788f1a0a4d = 1;
    }
    
    victim setscriptablepartstate( "shockStickVfx", "vfx_start", 0 );
    victim setscriptablepartstate( "harvesterOrbSfx", "sfx_start", 0 );
    currentweapon = victim getcurrentweapon();
    
    if ( gestureref && currentweapon && !isnullweapon( currentweapon ) )
    {
        while ( !victim isgestureplaying( gestureref ) )
        {
            victim forceplaygestureviewmodel( gestureref );
            waitframe();
        }
    }
    
    victim startforcedfire();
    victim shock_stick::function_ef03efbecb279b8a( 1 );
    victim setmovespeedscale( 0.8 );
    victim setempjammed( 1 );
    wait 4;
}

// Namespace ob_nm_mode
// Params 2, eflags: 0x4
// Checksum 0xbba6521c, Offset: 0x1457f
// Size: 0x74
function private function_31824bd75805628( victim, gestureref )
{
    if ( !victim )
    {
        return;
    }
    
    victim shock_stick::function_904e61c3aefb61c2( 0 );
    victim stopgestureviewmodel( gestureref );
    victim stopforcedfire();
    victim setscriptablepartstate( "shockStickVfx", "off", 0 );
    victim setscriptablepartstate( "harvesterOrbSfx", "sfx_done", 0 );
    victim shock_stick::function_ef03efbecb279b8a( 0 );
    victim setmovespeedscale( 1 );
    victim setempjammed( 0 );
}

