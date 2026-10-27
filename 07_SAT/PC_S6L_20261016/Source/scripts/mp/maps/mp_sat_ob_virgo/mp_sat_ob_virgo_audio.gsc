// scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio.gsc  (hash_0f0be5b62d694678.gscc) (size: 27088 Bytes / 0x69d0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1bfd705a (469594202)
// size ...... 27088 (0x69d0)
// includes .. 11  (offset: 0x5fac)
// strings ... 145 (offset: 0x6004)
// dev strs .. 19  (offset: 0x6890)
// exports ... 62  (offset: 0x489c)
// cseg ...... 0x1220 + 0x367c (0x489c)
// imports ... 92  (offset: 0x524c)
// animtree1 . 0   (offset: 0x69d0)
// animtree2 . 0   (offset: 0x69d0)
#using script_66878054d141dbc0;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_draw;
#using scripts\common\snd\snd_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\snd\snd_ob;

#namespace virgo_audio;

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x8cfe9bfa, Offset: 0x123e
    // Size: 0xf, Type: dev
    function private function_b840cf6bb7f160dc( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 0
// Checksum 0x376c60c1, Offset: 0x1255
// Size: 0xa
function main()
{
    level thread _audio_init();
}

// Namespace virgo_audio
// Params 0
// Checksum 0x8015ab94, Offset: 0x1267
// Size: 0x1c
function _audio_init()
{
    snd::start_init( &_start );
    snd::wait_init();
    function_ffd9703f7faa0b76();
}

// Namespace virgo_audio
// Params 0
// Checksum 0x1b21649c, Offset: 0x128b
// Size: 0x829
function function_ffd9703f7faa0b76()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
    
    level.audio.radio_data = [];
    level.audio.radio_data[ 0 ] = spawnstruct();
    level.audio.radio_data[ 0 ].position = ( -15307, 3517, -3027 );
    level.audio.radio_data[ 0 ].name = "CIV_RADIO_1";
    level.audio.radio_data[ 0 ].color = ( 1, 0.2, 0.2 );
    level.audio.radio_data[ 0 ].sounds = [];
    level.audio.radio_data[ 0 ].sounds[ 0 ] = [ 0, "dx_wc_irgo_vbch_anc2_weareonceagainnotify" ];
    level.audio.radio_data[ 0 ].sounds[ 1 ] = [ 12.5, "dx_wc_irgo_vbch_anc2_pleasestayinyourhome" ];
    level.audio.radio_data[ 0 ].sounds[ 2 ] = [ 20, "dx_wc_irgo_vbch_anc2_donotattempttoengage" ];
    level.audio.radio_data[ 0 ].sounds[ 3 ] = [ 28, "dx_wc_irgo_vbch_anc2_emergencycrewsareswe" ];
    level.audio.radio_data[ 1 ] = spawnstruct();
    level.audio.radio_data[ 1 ].position = ( -16873, 4477, -3003 );
    level.audio.radio_data[ 1 ].name = "CIV_RADIO_2";
    level.audio.radio_data[ 1 ].color = ( 0.2, 0.8, 1 );
    level.audio.radio_data[ 1 ].sounds = [];
    level.audio.radio_data[ 1 ].sounds[ 0 ] = [ 0, "dx_wc_irgo_vbch_anc2_emergencyserviceshav" ];
    level.audio.radio_data[ 1 ].sounds[ 1 ] = [ 11.5, "dx_wc_irgo_vbch_anc2_wevereceivedwordthat" ];
    level.audio.radio_data[ 1 ].sounds[ 2 ] = [ 22, "dx_wc_irgo_vbch_anc1_incaseyourejustjoini" ];
    level.audio.radio_data[ 1 ].sounds[ 3 ] = [ 31.5, "dx_wc_irgo_vbch_anc1_themilitaryisheroica" ];
    level.audio.radio_data[ 2 ] = spawnstruct();
    level.audio.radio_data[ 2 ].position = ( -23337, -13758, 1030 );
    level.audio.radio_data[ 2 ].name = "POLICE_RADIO_1";
    level.audio.radio_data[ 2 ].color = ( 1, 0.6, 0 );
    level.audio.radio_data[ 2 ].sounds = [];
    level.audio.radio_data[ 2 ].sounds[ 0 ] = [ 0, "dx_wc_irgo_vbch_cop1_mygodhediditthatfuck" ];
    level.audio.radio_data[ 2 ].sounds[ 1 ] = [ 5.5, "dx_wc_irgo_vbch_cop1_imatsouthalamedaands" ];
    level.audio.radio_data[ 2 ].sounds[ 2 ] = [ 11.5, "dx_wc_irgo_vbch_cop1_ifthereareanyambulan" ];
    level.audio.radio_data[ 2 ].sounds[ 3 ] = [ 14.5, "dx_wc_irgo_vbch_cop1_downtownisashitshow" ];
    level.audio.radio_data[ 3 ] = spawnstruct();
    level.audio.radio_data[ 3 ].position = ( -11405, -13086, 194 );
    level.audio.radio_data[ 3 ].name = "POLICE_RADIO_2";
    level.audio.radio_data[ 3 ].color = ( 0.8, 0.2, 1 );
    level.audio.radio_data[ 3 ].sounds = [];
    level.audio.radio_data[ 3 ].sounds[ 0 ] = [ 0, "dx_wc_irgo_vbch_cop3_imtryingtoclearstude" ];
    level.audio.radio_data[ 3 ].sounds[ 1 ] = [ 7.5, "dx_wc_irgo_vbch_cop3_wevegotmultiplewound" ];
    level.audio.radio_data[ 3 ].sounds[ 2 ] = [ 12.75, "dx_wc_irgo_vbch_cop3_wherethehellisthearm" ];
    level.audio.radio_data[ 3 ].sounds[ 3 ] = [ 16.5, "dx_wc_irgo_vbch_cop3_callinthenationalgua" ];
    level.audio.radio_data[ 4 ] = spawnstruct();
    level.audio.radio_data[ 4 ].position = ( -16019, -13739, 491 );
    level.audio.radio_data[ 4 ].name = "POLICE_RADIO_3";
    level.audio.radio_data[ 4 ].color = ( 0.2, 1, 0.4 );
    level.audio.radio_data[ 4 ].sounds = [];
    level.audio.radio_data[ 4 ].sounds[ 0 ] = [ 0, "dx_wc_irgo_vbch_cop2_wevegotbuildingscoll" ];
    level.audio.radio_data[ 4 ].sounds[ 1 ] = [ 3.5, "dx_wc_irgo_vbch_cop2_weneedrescuecrewstod" ];
    level.audio.radio_data[ 4 ].sounds[ 2 ] = [ 6.75, "dx_wc_irgo_vbch_cop2_jesusisanyoneatdispa" ];
    level.audio.radio_data[ 4 ].sounds[ 3 ] = [ 11, "dx_wc_irgo_vbch_cop2_ivegotcivilianshunke" ];
}

// Namespace virgo_audio
// Params 1
// Checksum 0xeb2b246c, Offset: 0x1abc
// Size: 0x1df
function _start( start_point )
{
    assert( start_point == level.current_activity.dataobjects[ "<dev string:x24>" ].value, "<dev string:x35>" );
    level thread music( start_point );
    
    switch ( start_point )
    {
        case #"hash_10903da23dd32bb":
            level thread freeway_intro();
            break;
        case #"hash_b51b9caea6dc7bfe":
            level thread freeway_inverted();
            break;
        case #"hash_2976e97972b32226":
            level thread freeway_broken();
            break;
        case #"hash_5e5406cadfa84c4b":
            level thread freeway_parkour();
            break;
        case #"hash_218b5f67abd323e1":
            level thread freeway_crashsite();
            break;
        case #"hash_96a2719bc6e0df33":
            level thread freeway_drone();
            break;
        case #"hash_45eb8afefb4240a6":
            level thread japan_intro();
            break;
        case #"hash_efa7a0bf276b3722":
            level thread japan_fight();
            break;
        case #"hash_3ff6ca525005bd72":
            level thread carrier_intro();
            break;
        case #"hash_2cf7c9861bdf9fa6":
            level thread carrier_2();
            break;
        case #"hash_2cf7ca861bdfa139":
            level thread carrier_3();
            break;
        case #"hash_3dd1b0578ff495b1":
            break;
        case #"hash_93e81566e67e8897":
            break;
        case #"hash_93e81666e67e8a2a":
            break;
        case #"hash_315dced068d2e73f":
        case #"hash_352ec4ded987cbda":
        case #"hash_4e371a30356f0f3b":
            level thread namespace_a350a26c6d662a6a::function_be0e9dd8c09bbe32();
            break;
        case #"hash_6d961012822f635":
        default:
            /#
                snd::function_7a77574e2157fbce( "<dev string:x67>" + start_point + "<dev string:x86>" );
            #/
            
            break;
    }
}

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xaa869964, Offset: 0x1ca3
    // Size: 0xf, Type: dev
    function private function_2f8bab071e3e576a( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 1
// Checksum 0x7b91ee98, Offset: 0x1cba
// Size: 0x3f9
function music( start )
{
    level endon( #"game_ended" );
    
    if ( snd::did_once( "virgo_audio::music" ) )
    {
        return;
    }
    
    current_activity = snd_ob::get_active_current_activity();
    activity_players = snd::function_7a86238ee2359651( current_activity );
    squad = teams::function_72b89edf6b47c40a( activity_players[ 0 ] );
    start = current_activity.type;
    assert( isplayer( activity_players[ 0 ] ) );
    assert( snd::issquad( squad ) );
    
    switch ( start )
    {
        default:
            /#
                snd::function_7a77574e2157fbce( "<dev string:x88>" + start + "<dev string:x86>" );
            #/
        case #"hash_10903da23dd32bb":
            snd_ob::squad_music_with_boost( squad, "mx_virgo_back_here_lp", 3, 79, 4, 16, 16 );
            utility::flag_wait( "flag_virgo_memory_jump_01_done" );
            snd_ob::squad_music_stop( squad );
        case #"hash_b51b9caea6dc7bfe":
            utility::flag_wait( "flag_spawn_hill_enemies" );
        case #"hash_2976e97972b32226":
            snd_ob::squad_music_with_boost( squad, "mx_virgo_unflappable_110_lp", 4, 110, 4, 16, 16 );
            utility::flag_wait( "flag_freeway_broken_done" );
        case #"hash_5e5406cadfa84c4b":
            snd_ob::squad_music_with_boost( squad, "mx_virgo_climbing_lp", 4, 110, 4, 16, 16 );
            utility::flag_wait( "flag_virgo_memory_jump_02_done" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_frogger_to_crashsite_bink_done" );
        case #"hash_218b5f67abd323e1":
            snd_ob::squad_music_with_boost( squad, "mx_virgo_unflappable_110_lp", 4, 110, 4, 16, 16 );
            utility::flag_wait( "flag_crashed_drone_interacted" );
            snd_ob::squad_music_stop( squad );
            wait 6.7;
        case #"hash_96a2719bc6e0df33":
            snd_ob::squad_music_with_boost( squad, "mx_avalon_combat_e_lp", 10, 155, 15, 28, 224 );
            utility::flag_wait_any( "play_single_titan_dead_vo", "all_drone_juggers_dead" );
            snd_ob::squad_music_boost( squad, 6, 155, 10, 14, 14 );
            wait 1.16129;
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_void_1_bink_done" );
        case #"hash_45eb8afefb4240a6":
            snd_ob::squad_music_with_boost( squad, "mx_virgo_back_here_lp", 3, 79, 4, 16, 16 );
            utility::flag_wait( "flag_warehouse_interact" );
            snd_ob::squad_music_stop( squad );
            wait 6.65;
            wait 3.85;
            snd_ob::squad_music_with_boost( squad, "mx_virgo_too_late", 4, 164, 4, 32, 48 );
            wait 16;
            snd_ob::squad_music_with_boost( squad, "mx_virgo_roji_combat_lp", 1, 164, 4, 32, 48 );
            utility::flag_wait( "flag_japan_interior_clear" );
            snd_ob::squad_music_stop( squad );
        case #"hash_efa7a0bf276b3722":
            utility::flag_wait( "flag_japan_fight_combat_start" );
            wait 4.39024;
            snd_ob::squad_music_with_boost( squad, "mx_virgo_roji_combat_lp", 4, 164, 4, 32, 48 );
            utility::flag_wait( "flag_japan_tanks_defeated" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_virgo_japan_fight_done" );
            utility::flag_wait_or_timeout( "flag_void_2_bink_done", 180 );
        case #"hash_2cf7c9861bdf9fa6":
        case #"hash_2cf7ca861bdfa139":
        case #"hash_3ff6ca525005bd72":
            snd_ob::squad_music_with_boost( squad, "mx_virgo_giant_harper_lp", 6, 140, 0, 16, 48 );
            utility::flag_wait( "flag_virgo_harper_boss_3" );
            level waittill( #"hash_2e3ff762df82a737" );
            snd_ob::squad_music_with_boost( squad, "mx_virgo_collapse", 6, 140, 4, 52, 52 );
        case #"hash_3dd1b0578ff495b1":
            break;
        case #"hash_93e81566e67e8897":
        case #"hash_93e81666e67e8a2a":
            break;
        case #"hash_315dced068d2e73f":
        case #"hash_352ec4ded987cbda":
        case #"hash_4e371a30356f0f3b":
            snd_ob::squad_music_with_boost( squad, "mx_avalon_combat_e_lp", 10, 155, 15, 28, 224 );
            break;
        case #"hash_6d961012822f635":
            break;
    }
}

// Namespace virgo_audio
// Params 8
// Checksum 0x6956eaeb, Offset: 0x20bb
// Size: 0x250
function combat_walla_oneshot( ai_array, area, alias, delay_min, delay_max, var_a0c6c922d00f038d, stop_notify, group_distance )
{
    self endon( #"shutdown" );
    assert( isdefined( ai_array ), "<dev string:xa6>" );
    assert( isdefined( alias ), "<dev string:xc8>" );
    
    if ( !isdefined( delay_min ) )
    {
        delay_min = 4;
    }
    
    if ( !isdefined( delay_max ) )
    {
        delay_max = 12;
    }
    
    if ( !isdefined( var_a0c6c922d00f038d ) )
    {
        var_a0c6c922d00f038d = 3;
    }
    
    if ( !isdefined( stop_notify ) )
    {
        stop_notify = "kill_walla";
    }
    
    if ( !isdefined( group_distance ) )
    {
        group_distance = 600;
    }
    
    self.walla_groups = [];
    var_7b7ba6fb6492d9f0 = 0;
    
    while ( true )
    {
        current_enemy_count = 0;
        
        if ( isarray( ai_array ) )
        {
            foreach ( enemy in ai_array )
            {
                if ( isalive( enemy ) )
                {
                    current_enemy_count++;
                }
            }
        }
        
        if ( current_enemy_count >= var_a0c6c922d00f038d && !var_7b7ba6fb6492d9f0 )
        {
            var_7b7ba6fb6492d9f0 = 1;
            thread function_5cd8a51ddf1846fe( ai_array, alias, delay_min, delay_max, var_a0c6c922d00f038d, group_distance );
            thread function_b4849f7d17ba4282( stop_notify, area );
            
            /#
                if ( snd::function_5584988e43b61242() && snd::function_542b9fda0c23d8f4() > 1 )
                {
                    thread function_7791e4eb60691fd4( ai_array, area, alias, delay_min, delay_max, var_a0c6c922d00f038d, group_distance );
                }
            #/
        }
        else if ( current_enemy_count < var_a0c6c922d00f038d )
        {
            if ( isdefined( self.walla_groups ) )
            {
                foreach ( var_9b967df2cd92fd7d in self.walla_groups )
                {
                    if ( isdefined( var_9b967df2cd92fd7d ) )
                    {
                        snd::stop( var_9b967df2cd92fd7d );
                    }
                }
                
                self.walla_groups = [];
            }
            
            self notify( #"shutdown" );
        }
        
        wait 2;
    }
}

// Namespace virgo_audio
// Params 6
// Checksum 0x150b0596, Offset: 0x2313
// Size: 0x27a
function function_5cd8a51ddf1846fe( ai_array, alias, delay_min, delay_max, var_a0c6c922d00f038d, group_distance )
{
    self endon( #"shutdown" );
    
    while ( true )
    {
        var_4181133b64550dd7 = [];
        
        foreach ( enemy in ai_array )
        {
            if ( isalive( enemy ) )
            {
                var_4181133b64550dd7[ var_4181133b64550dd7.size ] = enemy;
            }
        }
        
        if ( var_4181133b64550dd7.size > 0 )
        {
            var_de4982670a15467b = function_31f6bde986d776dc( var_4181133b64550dd7, group_distance, var_a0c6c922d00f038d );
            
            if ( isdefined( self.walla_groups ) )
            {
                foreach ( var_9b967df2cd92fd7d in self.walla_groups )
                {
                    if ( isdefined( var_9b967df2cd92fd7d ) )
                    {
                        snd::stop( var_9b967df2cd92fd7d );
                    }
                }
            }
            
            self.walla_groups = [];
            
            foreach ( group in var_de4982670a15467b )
            {
                if ( group.size >= var_a0c6c922d00f038d )
                {
                    function_398bc9ee922d91fd( "aliveEnemies", group.size );
                    origin = average_origin_enemies( group );
                    var_9b967df2cd92fd7d = snd::play( alias, origin + ( 0, 0, 40 ) );
                    
                    if ( isdefined( var_9b967df2cd92fd7d ) )
                    {
                        var_9b967df2cd92fd7d function_70576dbab4f88e19( "minAliveEnemies", var_a0c6c922d00f038d );
                        maximum_enemies = var_a0c6c922d00f038d + 5;
                        var_9b967df2cd92fd7d function_70576dbab4f88e19( "maxAliveEnemies", maximum_enemies );
                        self.walla_groups[ self.walla_groups.size ] = var_9b967df2cd92fd7d;
                    }
                }
            }
        }
        
        wait randomfloatrange( delay_min, delay_max );
    }
}

// Namespace virgo_audio
// Params 3
// Checksum 0xdf78e150, Offset: 0x2595
// Size: 0x31c
function function_31f6bde986d776dc( enemies, group_distance, minimum_group_size )
{
    if ( !isarray( enemies ) || enemies.size == 0 )
    {
        return [];
    }
    
    groups = [];
    used_enemies = [];
    
    foreach ( enemy in enemies )
    {
        if ( !isalive( enemy ) )
        {
            continue;
        }
        
        is_used = 0;
        
        foreach ( used_enemy in used_enemies )
        {
            if ( enemy == used_enemy )
            {
                is_used = 1;
                break;
            }
        }
        
        if ( is_used )
        {
            continue;
        }
        
        var_e1d261ae901c8dab = [];
        var_e1d261ae901c8dab[ var_e1d261ae901c8dab.size ] = enemy;
        used_enemies[ used_enemies.size ] = enemy;
        group_expanded = 1;
        
        while ( group_expanded )
        {
            group_expanded = 0;
            
            foreach ( other_enemy in enemies )
            {
                if ( !isalive( other_enemy ) )
                {
                    continue;
                }
                
                is_used = 0;
                
                foreach ( used_enemy in used_enemies )
                {
                    if ( other_enemy == used_enemy )
                    {
                        is_used = 1;
                        break;
                    }
                }
                
                if ( is_used )
                {
                    continue;
                }
                
                foreach ( var_86e606242c029736 in var_e1d261ae901c8dab )
                {
                    distance = distance( other_enemy.origin, var_86e606242c029736.origin );
                    
                    if ( distance <= group_distance )
                    {
                        var_e1d261ae901c8dab[ var_e1d261ae901c8dab.size ] = other_enemy;
                        used_enemies[ used_enemies.size ] = other_enemy;
                        group_expanded = 1;
                        break;
                    }
                }
            }
        }
        
        if ( var_e1d261ae901c8dab.size >= minimum_group_size )
        {
            groups[ groups.size ] = var_e1d261ae901c8dab;
        }
    }
    
    return groups;
}

// Namespace virgo_audio
// Params 1
// Checksum 0x3a98bac8, Offset: 0x28ba
// Size: 0xcf
function average_origin_enemies( enemies )
{
    var_8b9e8ec00f7e6374 = ( 0, 0, 0 );
    
    if ( isarray( enemies ) && enemies.size > 0 )
    {
        enemy_origins = [];
        
        foreach ( enemy in enemies )
        {
            if ( isalive( enemy ) )
            {
                enemy_origins[ enemy_origins.size ] = enemy.origin;
            }
        }
        
        var_8b9e8ec00f7e6374 = snd::vectoraverage( enemy_origins );
    }
    
    return var_8b9e8ec00f7e6374;
}

/#

    // Namespace virgo_audio
    // Params 7
    // Checksum 0x905d36e5, Offset: 0x2992
    // Size: 0x67e, Type: dev
    function function_7791e4eb60691fd4( ai_array, area, alias, delay_min, delay_max, var_a0c6c922d00f038d, group_distance )
    {
        self notify( #"new_debug" );
        self endon( #"new_debug" );
        self endon( #"shutdown_notify" );
        
        while ( true )
        {
            current_enemy_count = 0;
            
            if ( isarray( ai_array ) )
            {
                foreach ( enemy in ai_array )
                {
                    if ( isalive( enemy ) )
                    {
                        current_enemy_count++;
                    }
                }
            }
            
            var_4181133b64550dd7 = [];
            
            foreach ( enemy in ai_array )
            {
                if ( isalive( enemy ) )
                {
                    var_4181133b64550dd7[ var_4181133b64550dd7.size ] = enemy;
                }
            }
            
            var_de4982670a15467b = function_31f6bde986d776dc( var_4181133b64550dd7, group_distance, var_a0c6c922d00f038d );
            group_count = var_de4982670a15467b.size;
            snd::function_2e8132539dbcad93( "<dev string:xe7>", 0, 900, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:xff>", 0, 924, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x115>", 0, 948, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x12b>", 0, 972, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x141>", 0, 996, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x157>", 0, 1020, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x16d>", 0, 1044, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x183>", 0, 1068, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x199>" + area, 0, 900, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x199>" + alias, 0, 924, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x199>" + delay_min, 0, 948, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x199>" + delay_max, 0, 972, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x199>" + current_enemy_count, 0, 996, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x199>" + var_a0c6c922d00f038d, 0, 1020, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x199>" + group_distance, 0, 1044, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x199>" + group_count, 0, 1068, 1.5, "<dev string:xfd>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            waitframe();
        }
    }

#/

// Namespace virgo_audio
// Params 2
// Checksum 0xf9fceb1f, Offset: 0x3018
// Size: 0x7a
function function_b4849f7d17ba4282( stop_notify, area )
{
    self endon( #"shutdown_notify" );
    utility::waittill_any( stop_notify, "kill_walla", "shutdown" );
    
    if ( isdefined( area ) && isstruct( level.audio.var_25e584ceb1945db6[ area ] ) )
    {
        level.audio.var_25e584ceb1945db6[ area ] = undefined;
    }
    
    self notify( #"shutdown_notify" );
}

// Namespace virgo_audio
// Params 1
// Checksum 0x6e1e2c53, Offset: 0x309a
// Size: 0x84
function function_45d0930e6846da7e( scene_type )
{
    if ( !isdefined( scene_type ) || scene_type == "" )
    {
        return;
    }
    
    wait 1;
    
    switch ( scene_type )
    {
        case #"hash_bf2f9adbd2b41d5":
            jet_ent = scene::get_entity( "echo_jet" );
            
            if ( isdefined( jet_ent ) )
            {
                snd::play( "evt_echo_start_jet", [ jet_ent, "tag_body" ] );
            }
            
            break;
        default:
            break;
    }
}

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xb02f973, Offset: 0x3126
    // Size: 0xf, Type: dev
    function private function_e672ac13277823fe( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 0
// Checksum 0xb54088f9, Offset: 0x313d
// Size: 0xa
function freeway_intro()
{
    level thread function_795913aa9be6a99b();
}

// Namespace virgo_audio
// Params 0
// Checksum 0x90aa7153, Offset: 0x314f
// Size: 0x4a
function function_795913aa9be6a99b()
{
    level utility::flag_wait( "flag_intro_igc_done" );
    level thread monitor_radio( level.audio.radio_data[ 0 ] );
    level thread monitor_radio( level.audio.radio_data[ 1 ] );
}

// Namespace virgo_audio
// Params 1
// Checksum 0x2be500fd, Offset: 0x31a1
// Size: 0x53
function inverted_portal_open( flagcomplete )
{
    snd::play( "cin_sat_virgo_cradle_wormhole_open", self.origin );
    loop = snd::play( "cin_sat_virgo_cradle_wormhole_lp", self.origin );
    utility::flag_wait( flagcomplete );
    snd::stop( loop );
}

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xe185c731, Offset: 0x31fc
    // Size: 0xf, Type: dev
    function private function_e657c439ef212ed1( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 0
// Checksum 0x7601c70b, Offset: 0x3213
// Size: 0x57
function freeway_inverted()
{
    waitframe();
    level thread function_67a3f30bc8488c46();
    loop = snd::play( "amb_emt_highway_surreal_lp", ( -12088, -13214, 931 ) );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_player_inverted_freeway", "flag_player_at_inverted_ambush" );
    level utility::flag_wait( "flag_player_at_inverted_ambush" );
    snd::stop( loop );
}

// Namespace virgo_audio
// Params 0
// Checksum 0xcdbc5795, Offset: 0x3272
// Size: 0x3e
function function_67a3f30bc8488c46()
{
    level thread monitor_radio( level.audio.radio_data[ 3 ] );
    level thread monitor_radio( level.audio.radio_data[ 4 ] );
}

// Namespace virgo_audio
// Params 0
// Checksum 0x912afb39, Offset: 0x32b8
// Size: 0x2e6
function freeway_inverted_combat_walla()
{
    level utility::flag_wait( "flag_spawn_intro_upside_down" );
    level.audio.var_25e584ceb1945db6[ "intro_ambush" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "intro_ambush" ] thread combat_walla_oneshot( level.var_aa9beb68d0bc45f3, "intro_ambush", "dxx_virgo_cradled_soldier_combat_ext", 2, 7, 3, "ambush_bots_spawned" );
    level utility::flag_wait( "flag_initial_ambush_fallback" );
    wait 5;
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "intro_ambush" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "intro_ambush" ] notify( #"ambush_bots_spawned" );
    }
    
    sandwich_array = getaiarray();
    level.audio.var_25e584ceb1945db6[ "intro_ambush_bots" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "intro_ambush_bots" ] thread combat_walla_oneshot( sandwich_array, "intro_ambush_bots", "dxx_virgo_mech_bot_combat_ext", 2, 7, 3, "fallback_initiated" );
    level utility::flag_wait( "flag_sandwich_fallback" );
    wait 3;
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "intro_ambush_bots" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "intro_ambush_bots" ] notify( #"fallback_initiated" );
    }
    
    sandwich_fallback_array = getaiarray();
    level.audio.var_25e584ceb1945db6[ "sandwich_fallback" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "sandwich_fallback" ] thread combat_walla_oneshot( sandwich_fallback_array, "sandwich_fallback", "dxx_virgo_mech_bot_combat_ext", 3, 7, 3, "squad_at_canyon_end" );
    level utility::flag_wait( "flag_start_canyon_flippers" );
    wait 4;
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "sandwich_fallback" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "sandwich_fallback" ] notify( #"squad_at_canyon_end" );
    }
    
    broken_canyon_bots = getaiarray();
    level.audio.var_25e584ceb1945db6[ "broken_canyon" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "broken_canyon" ] thread combat_walla_oneshot( broken_canyon_bots, "broken_canyon", "dxx_virgo_mech_bot_combat_ext", 3, 7, 3, "parkour_started" );
    level utility::flag_wait( "flag_freeway_broken_done" );
    wait 5;
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "broken_canyon" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "broken_canyon" ] notify( #"parkour_started" );
    }
}

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x7fe312b, Offset: 0x35a6
    // Size: 0xf, Type: dev
    function private function_f08b76b0d0482ca1( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 0
// Checksum 0xec32e681, Offset: 0x35bd
// Size: 0x2
function freeway_broken()
{
    
}

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xada7bce3, Offset: 0x35c7
    // Size: 0xf, Type: dev
    function private function_7a9777560746fe52( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 0
// Checksum 0xf1c4455f, Offset: 0x35de
// Size: 0xa
function freeway_parkour()
{
    level thread function_caf7c5b16de8a56f();
}

// Namespace virgo_audio
// Params 0
// Checksum 0xc8806acb, Offset: 0x35f0
// Size: 0x20
function function_caf7c5b16de8a56f()
{
    level thread monitor_radio( level.audio.radio_data[ 2 ] );
}

// Namespace virgo_audio
// Params 0
// Checksum 0x305a8314, Offset: 0x3618
// Size: 0x15
function function_7aa4f6f25beab23b()
{
    wait 2.4;
    snd::play( "evt_emt_fake_platform_trigger_shake", self );
}

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x41637589, Offset: 0x3635
    // Size: 0xf, Type: dev
    function private function_e0ca6b4a74be3ac4( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 0
// Checksum 0x27bc2963, Offset: 0x364c
// Size: 0x2
function freeway_crashsite()
{
    
}

// Namespace virgo_audio
// Params 0
// Checksum 0x8198507, Offset: 0x3656
// Size: 0x11a
function drone_ambience()
{
    drone_origins = [];
    drone_aliases = [];
    drone_origins[ "intro" ] = ( -19012, 5981, -1181 );
    drone_origins[ "crashsite" ] = ( -42753, 4081, 2547 );
    drone_origins[ "parkour" ] = ( -27914, -10907, 1230 );
    drone_aliases[ "intro" ] = "amb_emt_drones_intro_lp";
    drone_aliases[ "crashsite" ] = "amb_emt_drones_crashsite_lp";
    drone_aliases[ "parkour" ] = "amb_emt_drones_parkour_lp";
    
    if ( isdefined( level.var_e4f1efa912604b1b ) )
    {
        snd::stop( level.var_e4f1efa912604b1b );
    }
    
    level.var_e4f1efa912604b1b = [];
    level.var_e4f1efa912604b1b[ "intro" ] = snd::play( drone_aliases[ "intro" ], drone_origins[ "intro" ] );
    level.var_e4f1efa912604b1b[ "crashsite" ] = snd::play( drone_aliases[ "crashsite" ], drone_origins[ "crashsite" ] );
    level.var_e4f1efa912604b1b[ "parkour" ] = snd::play( drone_aliases[ "parkour" ], drone_origins[ "parkour" ] );
    thread function_dcd5d3f72d917943();
}

// Namespace virgo_audio
// Params 0
// Checksum 0x166ca593, Offset: 0x3778
// Size: 0x68
function function_dcd5d3f72d917943()
{
    level utility::flag_wait( "flag_void_1_bink_done" );
    
    if ( isdefined( level.var_e4f1efa912604b1b ) )
    {
        snd::stop( level.var_e4f1efa912604b1b[ "intro" ] );
        snd::stop( level.var_e4f1efa912604b1b[ "crashsite" ] );
        snd::stop( level.var_e4f1efa912604b1b[ "parkour" ] );
        level.var_e4f1efa912604b1b = undefined;
    }
}

// Namespace virgo_audio
// Params 0
// Checksum 0x66869473, Offset: 0x37e8
// Size: 0x5b
function stop_all_drones()
{
    if ( isdefined( level.var_e4f1efa912604b1b ) )
    {
        snd::stop( level.var_e4f1efa912604b1b[ "intro" ] );
        snd::stop( level.var_e4f1efa912604b1b[ "crashsite" ] );
        snd::stop( level.var_e4f1efa912604b1b[ "parkour" ] );
        level.var_e4f1efa912604b1b = undefined;
    }
}

// Namespace virgo_audio
// Params 0
// Checksum 0xa12cad78, Offset: 0x384b
// Size: 0x1ce
function crashsite_combat_walla()
{
    var_3ee68c60aa47ad01 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "drone_wave_1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "drone_wave_1" ] thread combat_walla_oneshot( var_3ee68c60aa47ad01, "drone_wave_1", "dxx_virgo_coordinated_ext", 3, 7, 3, "wave_2_started" );
    utility::flag_wait( "flag_toDrone_wave2" );
    wait 3;
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "drone_wave_1" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "drone_wave_1" ] notify( #"wave_2_started" );
    }
    
    var_9e37f53d04a0e778 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "drone_wave_2" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "drone_wave_2" ] thread combat_walla_oneshot( var_9e37f53d04a0e778, "drone_wave_2", "dxx_virgo_coordinated_ext", 3, 7, 3, "wave_3_started" );
    utility::flag_wait( "flag_toDrone_wave3" );
    wait 3;
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "drone_wave_2" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "drone_wave_2" ] notify( #"wave_3_started" );
    }
    
    var_a7e7e9012f0b22fb = getaiarray();
    level.audio.var_25e584ceb1945db6[ "drone_wave_3" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "drone_wave_3" ] thread combat_walla_oneshot( var_a7e7e9012f0b22fb, "drone_wave_3", "dxx_virgo_coordinated_ext", 3, 7, 3 );
}

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x8a242835, Offset: 0x3a21
    // Size: 0xf, Type: dev
    function private function_e99ecfd46fd7961e( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 0
// Checksum 0x3376c8fe, Offset: 0x3a38
// Size: 0x2
function freeway_drone()
{
    
}

// Namespace virgo_audio
// Params 0
// Checksum 0x89e67372, Offset: 0x3a42
// Size: 0x49
function freeway_drone_hack_lp()
{
    level utility::flag_wait( "flag_drone_hack_done" );
    hack_lp = snd::play( "evt_drone_hack_lp", ( -42217, 1597, -3648 ) );
    level utility::flag_wait( "flag_drone_hacked" );
    snd::stop( hack_lp );
}

// Namespace virgo_audio
// Params 0
// Checksum 0xfb3e3e19, Offset: 0x3a93
// Size: 0x1d7
function function_24dd5d8313d8c9f9()
{
    level utility::flag_wait( "flag_hack_wave_01_spawned" );
    var_3ee68c60aa47ad01 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "hack_wave_1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "hack_wave_1" ] thread combat_walla_oneshot( var_3ee68c60aa47ad01, "hack_wave_1", "dxx_virgo_cradled_soldier_combat_ext", 3, 7, 3, "wave_2_started" );
    level utility::flag_wait( "flag_hack_wave_02_spawned" );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "hack_wave_1" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "hack_wave_1" ] notify( #"wave_2_started" );
    }
    
    var_9e37f53d04a0e778 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "hack_wave_2" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "hack_wave_2" ] thread combat_walla_oneshot( var_9e37f53d04a0e778, "hack_wave_2", "dxx_virgo_cradled_soldier_combat_ext", 3, 7, 3, "wave_3_started" );
    level utility::flag_wait( "flag_hack_wave_03_spawned" );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "hack_wave_2" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "hack_wave_2" ] notify( #"wave_3_started" );
    }
    
    var_a7e7e9012f0b22fb = getaiarray();
    level.audio.var_25e584ceb1945db6[ "hack_wave_3" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "hack_wave_3" ] thread combat_walla_oneshot( var_a7e7e9012f0b22fb, "hack_wave_3", "dxx_virgo_cradled_soldier_combat_ext", 3, 7, 3 );
}

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x2889ad9, Offset: 0x3c72
    // Size: 0xf, Type: dev
    function private function_7f23d8301ea5708f( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 0
// Checksum 0x99676a09, Offset: 0x3c89
// Size: 0x2
function japan_intro()
{
    
}

// Namespace virgo_audio
// Params 0
// Checksum 0xb133078e, Offset: 0x3c93
// Size: 0x127
function japan_intro_combat_walla()
{
    level utility::flag_wait( "flag_japan_alley_1" );
    alley_enemies = getaiarray();
    level.audio.var_25e584ceb1945db6[ "japan_intro_alley" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "japan_intro_alley" ] thread combat_walla_oneshot( alley_enemies, "japan_intro_alley", "dxx_virgo_coordinated_ext", 2, 8, 2, "japan_intro_1_started", 400 );
    level utility::flag_wait( "flag_japan_intro_enemies_spawned" );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "japan_intro_alley" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "japan_intro_alley" ] notify( #"japan_intro_1_started" );
    }
    
    level.audio.var_25e584ceb1945db6[ "japan_intro_1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "japan_intro_1" ] thread combat_walla_oneshot( level.japan_intro_enemies, "japan_intro_1", "dxx_virgo_coordinated_ext", 2, 8, 2, "japan_intro_2_started", 400 );
}

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x34bf5d2c, Offset: 0x3dc2
    // Size: 0xf, Type: dev
    function private function_cae1e457be661433( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 0
// Checksum 0xa2c8eb7f, Offset: 0x3dd9
// Size: 0x2
function japan_fight()
{
    
}

// Namespace virgo_audio
// Params 1
// Checksum 0xcd38d60, Offset: 0x3de3
// Size: 0x78
function function_82a021be57ae5af1( flag_name )
{
    origin = self.origin;
    robot_lp = snd::play( "fly_robot_frozen_lp", origin + ( 0, 0, 50 ) );
    function_dfa407d3b2f0037d( flag_name );
    waitframe();
    snd::play( "fly_plr_kill_robot", origin + ( 0, 0, 50 ) );
    snd::stop( robot_lp );
    robot_lp = undefined;
}

// Namespace virgo_audio
// Params 1
// Checksum 0xbd46eeff, Offset: 0x3e63
// Size: 0x2e
function function_dfa407d3b2f0037d( flag_name )
{
    self endon( #"damage" );
    self endon( #"death" );
    level utility::flag_wait( flag_name );
}

// Namespace virgo_audio
// Params 0
// Checksum 0xa0956e30, Offset: 0x3e99
// Size: 0x29c
function japan_fight_combat_walla()
{
    level utility::flag_wait( "flag_japan_fight_combat_start" );
    var_2ddaa60f5e88c507 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "japan_fight_wave_1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "japan_fight_wave_1" ] thread combat_walla_oneshot( var_2ddaa60f5e88c507, "japan_fight_wave_1", "dxx_virgo_mech_bot_combat_ext", 2, 8, 2, "japan_fight_wave_2_started", 400 );
    level utility::flag_wait( "flag_garden_wave_1_cleared" );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "japan_fight_wave_1" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "japan_fight_wave_1" ] notify( #"japan_fight_wave_2_started" );
    }
    
    var_af4142f0d9533a = getaiarray();
    level.audio.var_25e584ceb1945db6[ "japan_fight_wave_2" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "japan_fight_wave_2" ] thread combat_walla_oneshot( var_af4142f0d9533a, "japan_fight_wave_2", "dxx_virgo_mech_bot_combat_ext", 2, 8, 2, "japan_fight_wave_3_started", 400 );
    level utility::flag_wait( "flag_garden_wave_2_cleared" );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "japan_fight_wave_2" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "japan_fight_wave_2" ] notify( #"japan_fight_wave_3_started" );
    }
    
    var_714538edd17cc91 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "japan_fight_wave_3" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "japan_fight_wave_3" ] thread combat_walla_oneshot( var_714538edd17cc91, "japan_fight_wave_3", "dxx_virgo_mech_bot_combat_ext", 2, 8, 2, "japan_fight_wave_4_started", 400 );
    level utility::flag_wait( "flag_garden_wave_3_cleared" );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "japan_fight_wave_3" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "japan_fight_wave_3" ] notify( #"japan_fight_wave_4_started" );
    }
    
    var_3530f283839764b4 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "japan_fight_wave_4" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "japan_fight_wave_4" ] thread combat_walla_oneshot( var_3530f283839764b4, "japan_fight_wave_4", "dxx_virgo_mech_bot_combat_ext", 2, 8, 2, "flag_garden_wave_4_done", 400 );
}

/#

    // Namespace virgo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x82998f3b, Offset: 0x413d
    // Size: 0xf, Type: dev
    function private function_23334a56d7bd9da7( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace virgo_audio
// Params 0
// Checksum 0xadea84ab, Offset: 0x4154
// Size: 0x12
function carrier_intro()
{
    level thread namespace_a350a26c6d662a6a::function_e86e3be9023f00c9();
    level thread carrier_giant_boss_submix();
}

// Namespace virgo_audio
// Params 0
// Checksum 0x5c81e07e, Offset: 0x416e
// Size: 0x12
function carrier_2()
{
    level thread namespace_a350a26c6d662a6a::function_e86e3be9023f00c9();
    level thread carrier_giant_boss_submix();
}

// Namespace virgo_audio
// Params 0
// Checksum 0x2b86d0e8, Offset: 0x4188
// Size: 0x12
function carrier_3()
{
    level thread namespace_a350a26c6d662a6a::function_e86e3be9023f00c9();
    level thread carrier_giant_boss_submix();
}

// Namespace virgo_audio
// Params 0
// Checksum 0x3bd59501, Offset: 0x41a2
// Size: 0x56
function carrier_giant_boss_submix()
{
    if ( snd::did_once( "virgo_audio::carrier_giant_boss_submix" ) )
    {
        return;
    }
    
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_virgo_giant_boss", 0.1, 1 );
    utility::flag_wait( "flag_virgo_harper_boss_3" );
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_virgo_giant_boss", 1 );
}

// Namespace virgo_audio
// Params 0
// Checksum 0xcb1e93d6, Offset: 0x4200
// Size: 0xd
function function_658f02408d1a0c7c()
{
    self playloopsound( "prj_harper_giant_energy_ball_lp" );
}

// Namespace virgo_audio
// Params 1
// Checksum 0x9a56c2f0, Offset: 0x4215
// Size: 0x44
function function_b62b97edcae5f766( stun_duration )
{
    var_92b8a27a98e022b2 = stun_duration / 2;
    self setclienttriggeraudiozone( "mp_sat_ob_virgo_carrier_scripted_boss_stunned", 0.25 );
    self playsoundtoplayer( "evt_plr_2d_shockwave_ring_hit_01", self );
    wait var_92b8a27a98e022b2;
    self clearclienttriggeraudiozone( var_92b8a27a98e022b2 );
}

// Namespace virgo_audio
// Params 3
// Checksum 0x22ae19, Offset: 0x4261
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
            player playsoundtoplayer( "evt_harper_giant_hand_deck_smash_shockwave_wall", player, sound_ent );
            end_point = originpoint + dir_to_player * max_radius;
            travel_time = max_radius / var_ccf9a72ba0ac0132;
            sound_ent moveto( end_point, travel_time );
            sound_ent thread delete_after_move( travel_time + 0.5 );
        }
    }
}

// Namespace virgo_audio
// Params 1
// Checksum 0x99a70139, Offset: 0x43ea
// Size: 0x21
function delete_after_move( time )
{
    self endon( #"death" );
    wait time;
    self delete();
}

// Namespace virgo_audio
// Params 0
// Checksum 0x680ffd9a, Offset: 0x4413
// Size: 0x66
function function_930721c6d3c319f9()
{
    snd::play( "amb_harper_giant_hit_boat_water_metal_slosh", ( 42880, 27478, -187 ) );
    snd::play( "amb_harper_giant_hit_boat_water_metal_slosh", ( 39998, 25537, -187 ) );
    snd::play( "amb_harper_giant_hit_boat_water_metal_slosh", ( 43539, 33261, 187 ) );
    snd::play( "amb_harper_giant_hit_boat_water_metal_slosh", ( 38994, 31273, -187 ) );
}

// Namespace virgo_audio
// Params 3
// Checksum 0xb37798ac, Offset: 0x4481
// Size: 0xdd
function function_1f7a248ebb88b236( var_dc6a4b4b351da087, var_3a83720f18fce23e, point )
{
    button_pos = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    button_lp = snd::play( "evt_carrier_hack_radar_lp_01", button_pos );
    audio_utility::function_63bf1584c79c055( level.players, "evt_carrier_hack_radar_start_01" );
    var_132db6bf9462bd94 = snd::play( "evt_carrier_hack_circle_field_lp_01", point.origin + ( 0, 0, 40 ) );
    audio_utility::function_63bf1584c79c055( level.players, "evt_carrier_hack_radar_start_ui_01" );
    level utility::flag_wait( var_3a83720f18fce23e );
    snd::stop( button_lp );
    button_lp = undefined;
    snd::stop( var_132db6bf9462bd94 );
    var_132db6bf9462bd94 = undefined;
    audio_utility::function_63bf1584c79c055( level.players, "evt_carrier_hack_radar_ui_complete_01" );
}

// Namespace virgo_audio
// Params 0
// Checksum 0xdfc58655, Offset: 0x4566
// Size: 0x34
function function_b704c972d05c20db()
{
    if ( isdefined( self ) )
    {
        wait 0.1;
        snd::play( "evt_carrier_hack_radar_complete_rockets_launch_01", self );
        self waittill( #"death" );
        snd::play( "evt_carrier_hack_radar_complete_rockets_explo_dist_01", self );
    }
}

// Namespace virgo_audio
// Params 1
// Checksum 0x3beb3d1a, Offset: 0x45a2
// Size: 0x147
function monitor_radio( radio_info )
{
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player::isreallyalive( player ) && player.sessionstate == "playing" )
            {
                if ( distance( player.origin, radio_info.position ) < 1000 )
                {
                    /#
                        if ( snd::function_542b9fda0c23d8f4() > 2 )
                        {
                            level thread function_4482cd30668c5dd1( radio_info.position, radio_info.name, radio_info.color );
                        }
                    #/
                    
                    for ( j = 0; j < radio_info.sounds.size ; j++ )
                    {
                        snd::play( radio_info.sounds[ j ], radio_info.position );
                    }
                    
                    return;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace virgo_audio
// Params 3
// Checksum 0xa9f6d4e2, Offset: 0x46f1
// Size: 0x80
function function_4482cd30668c5dd1( position, radio_name, color )
{
    while ( true )
    {
        /#
            print3d( position + ( 0, 0, 64 ), radio_name + "<dev string:x1af>", color, 1, 1, 1, 1 );
            print3d( position + ( 0, 0, 32 ), "<dev string:x1b7>" + position, color * 0.5, 1, 0.6, 1, 1 );
        #/
        
        waitframe();
    }
}

// Namespace virgo_audio
// Params 0
// Checksum 0xd744a9b, Offset: 0x4779
// Size: 0x123
function boss_lull_combat_walla()
{
    level utility::flag_wait( "flag_carrier_1_spawned" );
    var_813ff14d2f458e3 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "boss_fight_lull_1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "boss_fight_lull_1" ] thread combat_walla_oneshot( var_813ff14d2f458e3, "boss_fight_lull_1", "dxx_virgo_cradled_soldier_combat_ext", 2, 8, 3, "boss_lull_2" );
    level utility::flag_wait( "flag_carrier_2_spawned" );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "boss_fight_lull_1" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "boss_fight_lull_1" ] notify( #"boss_lull_2" );
    }
    
    var_ec61d2566af40956 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "boss_fight_lull_2" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "boss_fight_lull_2" ] thread combat_walla_oneshot( var_ec61d2566af40956, "boss_fight_lull_2", "dxx_virgo_cradled_soldier_combat_ext", 2, 8, 3 );
}

