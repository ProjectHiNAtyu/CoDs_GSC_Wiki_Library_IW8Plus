// scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio.gsc  (hash_3464887eb0720108.gscc) (size: 23621 Bytes / 0x5c45 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2f96525b (798380635)
// size ...... 23621 (0x5c45)
// includes .. 8   (offset: 0x5501)
// strings ... 110 (offset: 0x5541)
// dev strs .. 18  (offset: 0x5b11)
// exports ... 77  (offset: 0x3b1d)
// cseg ...... 0xf2d + 0x2bf0 (0x3b1d)
// imports ... 101 (offset: 0x4725)
// animtree1 . 0   (offset: 0x5c45)
// animtree2 . 0   (offset: 0x5c45)
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_draw;
#using scripts\common\snd\snd_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gametypes\ob;
#using scripts\mp\snd\snd_ob;

#namespace leo_audio;

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xebf07a39, Offset: 0xf4b
    // Size: 0xf, Type: dev
    function private function_b840cf6bb7f160dc( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0xc0ae0dd4, Offset: 0xf62
// Size: 0xa
function main()
{
    level thread _audio_init();
}

// Namespace leo_audio
// Params 0
// Checksum 0xe71b4a57, Offset: 0xf74
// Size: 0x1c
function _audio_init()
{
    snd::start_init( &_start );
    snd::wait_init();
    function_ffd9703f7faa0b76();
}

// Namespace leo_audio
// Params 1
// Checksum 0xb358c8ed, Offset: 0xf98
// Size: 0x1d8
function _start( start_point )
{
    assert( start_point == level.current_activity.dataobjects[ "<dev string:x24>" ].value, "<dev string:x35>" );
    level thread music( start_point );
    
    switch ( start_point )
    {
        case #"hash_51672506f611ca4a":
            break;
        case #"hash_467334473970d984":
            thread facility_intro();
            break;
        case #"hash_a1d886628b9c1c1e":
            thread facility_presentation();
            break;
        case #"hash_96fa93e80a5130d6":
            thread facility_labs();
            break;
        case #"hash_e5e2b903463c96aa":
            thread facility_macguffin();
            break;
        case #"hash_e5bfefc620da38f4":
            thread facility_macguffin_core();
            break;
        case #"hash_4cf5504eabd79645":
            thread facility_escape_1();
            break;
        case #"hash_f9795bae90c39839":
            thread facility_cradle();
            break;
        case #"hash_4cf54d4eabd7918c":
            thread facility_escape_2();
            break;
        case #"hash_ce11eeaafec14929":
            thread facility_to_jungle();
            break;
        case #"hash_dc0662e0d214f970":
            thread jungle_intro();
            break;
        case #"hash_4b5db5e5db98495a":
            thread jungle_village();
            break;
        case #"hash_76ac1ef9e822114f":
            thread jungle_mansion();
            break;
        case #"hash_5c82e121ec679214":
            thread jungle_mansion_defend();
            break;
        case #"hash_c2c6bde4feae3fa9":
            thread jungle_mansion_escape();
            break;
        case #"hash_3dd1b0578ff495b1":
            break;
        case #"hash_6d961012822f635":
        default:
            /#
                snd::function_7a77574e2157fbce( "<dev string:x67>" + start_point + "<dev string:x86>" );
            #/
            
            break;
    }
}

// Namespace leo_audio
// Params 0
// Checksum 0x6afbc62d, Offset: 0x1178
// Size: 0x17
function function_ffd9703f7faa0b76()
{
    level.var_dde95b8965b386f9 = undefined;
    level.musicenabled = 1;
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xcd8878a7, Offset: 0x1197
    // Size: 0xf, Type: dev
    function private function_2f8bab071e3e576a( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace leo_audio
    // Params 3
    // Checksum 0xe8207cf2, Offset: 0x11ae
    // Size: 0x111, Type: dev
    function function_27b85a4356035eaf( soundalias, position, duration_sec )
    {
        if ( !isdefined( duration_sec ) )
        {
            duration_sec = soundexists( soundalias ) ? lookupsoundlength( soundalias ) * 0.001 : 3;
        }
        
        var_79e9f9d2dae26ef = int( duration_sec * 1000 );
        radius = 60;
        depthtest = 0;
        
        while ( var_79e9f9d2dae26ef >= 0 )
        {
            color = ( randomfloatrange( 0.5, 1 ), randomfloatrange( 0.5, 1 ), randomfloatrange( 0.5, 1 ) );
            alpha = var_79e9f9d2dae26ef * 0.001 / duration_sec;
            
            /#
                snd::print3dplus( soundalias, position, -1, "<dev string:x88>", color, alpha );
                snd::debugcrosshair( position, radius, ( 0, 0, 0 ), color, alpha, depthtest );
                snd::linesphere( position, radius, color, alpha, depthtest );
            #/
            
            var_79e9f9d2dae26ef -= 50;
            waitframe();
        }
    }

#/

// Namespace leo_audio
// Params 2
// Checksum 0xf504a556, Offset: 0x12c7
// Size: 0x63
function function_8298dcb33227b392( soundalias, position )
{
    var_fec5f8989584192c = getdvarint( @"hash_a33fc260b488106f", 1 );
    
    if ( var_fec5f8989584192c )
    {
        playsoundatpos( position, soundalias );
        
        /#
            if ( snd::function_542b9fda0c23d8f4() > 0 )
            {
                level thread function_27b85a4356035eaf( soundalias, position );
            }
        #/
        
        return;
    }
    
    snd::play( soundalias, position );
}

// Namespace leo_audio
// Params 4
// Checksum 0x5ab1381b, Offset: 0x1332
// Size: 0xfa
function get_offset_origin( base_origin, base_angles, distance, direction )
{
    direction_vector = ( 0, 0, 0 );
    
    switch ( direction )
    {
        case #"hash_87171c4dee93dfa":
            direction_vector = anglestoforward( base_angles );
            break;
        case #"hash_38d3fa95564c8924":
            direction_vector = anglestoforward( base_angles ) * -1;
            break;
        case #"hash_fa3db8f6bd73eb80":
            direction_vector = anglestoup( base_angles );
            break;
        case #"hash_f91b350a054b6175":
            direction_vector = anglestoup( base_angles ) * -1;
            break;
        case #"hash_96815ce4f2a3dbc5":
            direction_vector = anglestoright( base_angles );
            break;
        case #"hash_c9b3133a17a3b2d0":
            direction_vector = anglestoright( base_angles ) * -1;
            break;
        default:
            direction_vector = anglestoforward( base_angles );
            break;
    }
    
    return base_origin + direction_vector * distance;
}

// Namespace leo_audio
// Params 1
// Checksum 0xfa324557, Offset: 0x1435
// Size: 0x6a
function function_dee2acc8b25628c8( targetname )
{
    assert( isstring( targetname ) );
    struct = utility::getstruct( targetname, "targetname" );
    
    while ( !isdefined( struct.interact ) )
    {
        waitframe();
    }
    
    struct.interact waittill( #"trigger", ent );
    return ent;
}

// Namespace leo_audio
// Params 2, eflags: 0x4
// Checksum 0x30bab6a3, Offset: 0x14a8
// Size: 0x94
function private function_d3634107b1060946( state, squad )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
            snd_ob::squad_music_with_boost( squad, "mx_leo_stealth_party_lp", 2, 115, 2, 8, 24 );
            break;
        case #"hash_9e02cd4a0f3ca981":
            snd_ob::squad_music_with_boost( squad, "mx_leo_welcome_party_lp", 4, 115, 2, 8, 24 );
            break;
        case #"hash_3015d6b4c9f55525":
        case #"hash_7b6614415d1b2e48":
        default:
            break;
    }
}

// Namespace leo_audio
// Params 1
// Checksum 0x13fb15dc, Offset: 0x1544
// Size: 0x488
function music( start )
{
    level endon( #"game_ended" );
    
    if ( snd::did_once( "leo_audio::music" ) )
    {
        return;
    }
    
    current_activity = snd_ob::get_active_current_activity();
    activity_players = snd::function_7a86238ee2359651( current_activity );
    squad = teams::function_72b89edf6b47c40a( activity_players[ 0 ] );
    start = current_activity.type;
    assert( isplayer( activity_players[ 0 ] ) );
    assert( snd::issquad( squad ) );
    
    if ( ob::nightmare() )
    {
        wait 2;
        snd_ob::squad_music_with_boost( squad, "mx_leo_escape_lp", 5, 130, 4, 32, 40 );
        return;
    }
    
    switch ( start )
    {
        default:
            /#
                snd::function_7a77574e2157fbce( "<dev string:x8f>" + start + "<dev string:x86>" );
            #/
        case #"hash_467334473970d984":
        case #"hash_51672506f611ca4a":
            utility::flag_wait( "flag_intro_encounter_start" );
            snd_ob::squad_combat_state( squad, &function_d3634107b1060946 );
            utility::flag_wait( "facility_intro_complete" );
            snd_ob::squad_combat_state_stop( squad );
            snd_ob::squad_music_stop( squad );
        case #"hash_a1d886628b9c1c1e":
            snd_ob::squad_music( squad, "mx_leo_stealth_party_lp" );
            utility::flag_wait( "flag_presentation_puzzle_solved" );
            wait 1.04348;
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_central_guild_bots_spawn" );
            wait 0.5;
            snd_ob::squad_music( squad, "mx_leo_war_machines_stinger" );
            wait 2.08696;
            snd_ob::squad_combat_state( squad, &function_d3634107b1060946 );
            utility::flag_wait( "flag_central_player_exiting" );
            snd_ob::squad_combat_state_stop( squad );
        case #"hash_96fa93e80a5130d6":
            snd_ob::squad_music( squad, "mx_leo_stealth_party_lp" );
            utility::flag_wait( "flag_labs_start_vignettes" );
            wait 3;
            snd_ob::squad_music( squad, "mx_leo_welcome_party_lp" );
            utility::flag_wait( "flag_leo_macguffin_igc_start" );
        case #"hash_e5e2b903463c96aa":
            snd_ob::squad_music( squad, "mx_leo_welcome_party_lp" );
            utility::flag_wait( "flag_leo_macguffin_igc_start" );
            wait 0.5;
            snd_ob::squad_igc_music( squad, "mx_leo_entering_the_core" );
            utility::flag_wait( "flag_leo_macguffin_igc_done" );
            wait 0.545455;
            snd_ob::squad_music( squad, "mx_leo_stealth_party_lp" );
            utility::flag_wait( "button_puzzle_complete" );
            wait 1.04348;
            snd_ob::squad_music_stop( squad );
        case #"hash_e5bfefc620da38f4":
            utility::flag_wait( "facility_macguffin_core_interacted_with" );
            wait 4;
            snd_ob::squad_music( squad, "mx_leo_take_quantum_drive" );
            utility::flag_wait( "facility_macguffin_core_item_acquired" );
            wait 2;
        case #"hash_4cf5504eabd79645":
        case #"hash_f9795bae90c39839":
            snd_ob::squad_music_with_boost( squad, "mx_leo_scrap_em_lp", 4, 120, 2, 8, 24 );
            utility::flag_wait( "flag_leo_cradle_cinematic_start" );
            snd_ob::squad_music_stop( squad );
            snd_ob::squad_music_cut( squad, -3, 120, 8, 0, 4 );
            utility::flag_wait( "flag_leo_cradle_cinematic_done" );
            utility::flag_wait( "facility_cradle_complete" );
        case #"hash_4cf54d4eabd7918c":
        case #"hash_ce11eeaafec14929":
            wait 2;
            snd_ob::squad_music_with_boost( squad, "mx_leo_escape_lp", 5, 130, 4, 32, 40 );
            utility::flag_wait( "flag_leo_transition_igc_start" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_leo_transition_igc_done" );
            utility::flag_wait( "facility_to_jungle_complete" );
        case #"hash_4b5db5e5db98495a":
        case #"hash_dc0662e0d214f970":
            utility::flag_wait( "flag_jungle_hill_enemies_spawned" );
            wait 1.03448;
            snd_ob::squad_music_with_boost( squad, "mx_leo_raining_machetes_lp", 6, 116, 4, 8, 24 );
            utility::flag_wait( "jungle_village_combat_done" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_jungle_center_approach_enemies_spawned" );
        case #"hash_76ac1ef9e822114f":
            function_dee2acc8b25628c8( "jungle_village_obj_marker_end" );
            snd_ob::squad_igc_music( squad, "mx_leo_ghost" );
            utility::flag_wait( "jungle_mansion_complete" );
        case #"hash_5c82e121ec679214":
            snd_ob::squad_music_with_boost( squad, "mx_leo_nino_diablo_lp", 4, 113, 8, 8, 24 );
            utility::flag_wait( "flag_jungle_mansion_defend_complete" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_menendez_boss_outro_play" );
            snd_ob::squad_igc_music( squad, "mx_leo_menendez_boss_outro" );
        case #"hash_6d961012822f635":
        case #"hash_3dd1b0578ff495b1":
        case #"hash_c2c6bde4feae3fa9":
            break;
    }
}

// Namespace leo_audio
// Params 8
// Checksum 0x9e9487fe, Offset: 0x19d4
// Size: 0x250
function combat_walla_oneshot( ai_array, area, alias, delay_min, delay_max, var_a0c6c922d00f038d, stop_notify, group_distance )
{
    self endon( #"shutdown" );
    assert( isdefined( ai_array ), "<dev string:xad>" );
    assert( isdefined( alias ), "<dev string:xcf>" );
    
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

// Namespace leo_audio
// Params 6
// Checksum 0xe2c96883, Offset: 0x1c2c
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

// Namespace leo_audio
// Params 3
// Checksum 0xb8760093, Offset: 0x1eae
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

// Namespace leo_audio
// Params 1
// Checksum 0x5d965b0b, Offset: 0x21d3
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

    // Namespace leo_audio
    // Params 7
    // Checksum 0xf753d726, Offset: 0x22ab
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
            snd::function_2e8132539dbcad93( "<dev string:xee>", 0, 900, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x106>", 0, 924, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x11c>", 0, 948, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x132>", 0, 972, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x148>", 0, 996, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x15e>", 0, 1020, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x174>", 0, 1044, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x18a>", 0, 1068, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1a0>" + area, 0, 900, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1a0>" + alias, 0, 924, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1a0>" + delay_min, 0, 948, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1a0>" + delay_max, 0, 972, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1a0>" + current_enemy_count, 0, 996, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1a0>" + var_a0c6c922d00f038d, 0, 1020, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1a0>" + group_distance, 0, 1044, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1a0>" + group_count, 0, 1068, 1.5, "<dev string:x104>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            waitframe();
        }
    }

#/

// Namespace leo_audio
// Params 2
// Checksum 0xe3e860a, Offset: 0x2931
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

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xb586ec8e, Offset: 0x29b3
    // Size: 0xf, Type: dev
    function private function_820d11ac924d40b6( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0x212db5ab, Offset: 0x29ca
// Size: 0x28
function facility_intro()
{
    level utility::flag_wait( "flag_intro_encounter_start" );
    snd::play( "dxx_leo_labs_intro_aftermath_walla", ( 14118, 3122, -4854 ) );
}

// Namespace leo_audio
// Params 1
// Checksum 0x6a0aa8f0, Offset: 0x29fa
// Size: 0xb0
function facility_office_combat_walla( ai_array )
{
    idle_emt = snd::emitter( "dxx_leo_idle_oneshot_int", ( 12997, 2185, -4805 ), [ 3, 9 ], [ 10, 50 ] );
    level waittill( #"flag_atrium1_stealth_broke" );
    snd::stop( idle_emt );
    level.audio.var_25e584ceb1945db6[ "facility_office_combat" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "facility_office_combat" ] thread combat_walla_oneshot( ai_array, "facility_office", "dxx_leo_coordinated_int", 3, 8, 3 );
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x2a5e2127, Offset: 0x2ab2
    // Size: 0xf, Type: dev
    function private function_216fbe2cd9cf634( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0x42d26be0, Offset: 0x2ac9
// Size: 0x2
function facility_presentation()
{
    
}

// Namespace leo_audio
// Params 0
// Checksum 0x4e2baa06, Offset: 0x2ad3
// Size: 0x6b
function function_78bb15b768618217()
{
    sound_org = get_offset_origin( self.origin, self.angles, 10, "right" );
    node_lp = snd::play( "evt_leo_security_nodes_node_lp", sound_org );
    utility::waittill_any_ents_return( self, "damage", self, "turned_off", level, "countdown_end" );
    snd::stop( node_lp, 0.25 );
}

// Namespace leo_audio
// Params 0
// Checksum 0x79dbabcd, Offset: 0x2b46
// Size: 0x8a
function function_bb9eac8dbe531558()
{
    level endon( #"flag_central_nodes_destroyed" );
    level endon( #"countdown_end" );
    timer_origins = [ ( 15039, -61, -4647 ), ( 14183, 930, -4624 ), ( 15878, 831, -4622 ) ];
    timer_alias = "evt_leo_security_nodes_timer";
    thread function_5734d400ede2a54a( timer_origins );
    
    while ( true )
    {
        snd::play( timer_alias, timer_origins );
        wait 1;
    }
}

// Namespace leo_audio
// Params 1
// Checksum 0x253a4df0, Offset: 0x2bd8
// Size: 0x33
function function_5734d400ede2a54a( timer_origins )
{
    level endon( #"flag_central_nodes_destroyed" );
    level waittill( #"countdown_end" );
    snd::play( "evt_leo_security_nodes_timer_end", timer_origins );
}

// Namespace leo_audio
// Params 0
// Checksum 0x85c45858, Offset: 0x2c13
// Size: 0x50
function function_cb1bfffef55c52be()
{
    function_8298dcb33227b392( "evt_leo_presentation_stage_rise", ( 15226, 567, -4969 ) );
    wait 9;
    function_8298dcb33227b392( "evt_leo_presentation_bot_bootup", ( 15189, 606, -4962 ) );
    function_8298dcb33227b392( "evt_leo_presentation_bot_bootup", ( 15272, 510, -4955 ) );
}

// Namespace leo_audio
// Params 0
// Checksum 0x1c39cdf2, Offset: 0x2c6b
// Size: 0x94
function function_17dd2a88a8a7c3d2()
{
    wait 5;
    function_8298dcb33227b392( "evt_leo_presentation_biome_lights_on", ( 14252, 420, -4845 ) );
    wait 0.375;
    function_8298dcb33227b392( "evt_leo_presentation_biome_lights_on", ( 14556, -106, -4845 ) );
    wait 0.375;
    function_8298dcb33227b392( "evt_leo_presentation_biome_lights_on", ( 15119, -363, -4850 ) );
    wait 4.2;
    function_8298dcb33227b392( "evt_leo_presentation_lights_on_01", ( 14615, 934, -4787 ) );
    function_8298dcb33227b392( "evt_leo_presentation_lights_on_02", ( 15367, 161, -4762 ) );
}

// Namespace leo_audio
// Params 0
// Checksum 0x6fd76b08, Offset: 0x2d07
// Size: 0x1b
function function_f098c4894a2adcfa()
{
    function_8298dcb33227b392( "evt_leo_presentation_guild_jingle", ( 15198, 528, -4703 ) );
}

// Namespace leo_audio
// Params 0
// Checksum 0xa05c5d52, Offset: 0x2d2a
// Size: 0x34
function function_8bba7d7d4edfd9f1()
{
    function_8298dcb33227b392( "fly_guildbot_alert_standing", ( 15189, 606, -4962 ) );
    function_8298dcb33227b392( "fly_guildbot_alert_standing", ( 15272, 510, -4955 ) );
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x367b7233, Offset: 0x2d66
    // Size: 0xf, Type: dev
    function private function_4343dcb8d8bfc2a0( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0xf5e89e34, Offset: 0x2d7d
// Size: 0x43
function facility_labs()
{
    utility::flag_wait( "flag_labs_start_vignettes" );
    wait 1;
    function_8298dcb33227b392( "dxx_leo_labs_soldiers_catwalk_charge", ( 15088, -1483, -4570 ) );
    function_8298dcb33227b392( "fly_leo_labs_soldiers_charge_catwalk_running", ( 14928, -1624, -4558 ) );
}

// Namespace leo_audio
// Params 1
// Checksum 0x4fdd7c50, Offset: 0x2dc8
// Size: 0x11b
function facility_labs_walla( labs1_wave1 )
{
    level.audio.var_25e584ceb1945db6[ "labs1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "labs1" ] thread combat_walla_oneshot( labs1_wave1, "labs1", "dxx_leo_coordinated_int", 2, 7, 3, "labs_wave_2_started", 300 );
    utility::flag_wait( "flag_labs1_wave2" );
    wait 3;
    var_4ec0c1ddf3f8f3a5 = getaiarray();
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "labs1" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "labs1" ] notify( #"labs_wave_2_started" );
    }
    
    level.audio.var_25e584ceb1945db6[ "labs1_wave2" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "labs1_wave2" ] thread combat_walla_oneshot( var_4ec0c1ddf3f8f3a5, "labs1_wave2", "dxx_leo_coordinated_int", 2, 7, 3, undefined, 300 );
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x1a7abb5e, Offset: 0x2eeb
    // Size: 0xf, Type: dev
    function private function_161c165f6fbfc944( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0xf7ae8d2a, Offset: 0x2f02
// Size: 0x2
function facility_macguffin()
{
    
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x2ca48d00, Offset: 0x2f0c
    // Size: 0xf, Type: dev
    function private function_7b84d47cf5cbf0ca( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0x6d8cb4b1, Offset: 0x2f23
// Size: 0x2
function facility_macguffin_core()
{
    
}

// Namespace leo_audio
// Params 0
// Checksum 0xeb0a87ed, Offset: 0x2f2d
// Size: 0x1b
function snd_leo_quantum_computer_access_denied()
{
    function_8298dcb33227b392( "evt_leo_quantum_button_press_deny", ( 14831, -4334, -4669 ) );
}

// Namespace leo_audio
// Params 0
// Checksum 0x3908193, Offset: 0x2f50
// Size: 0x9f
function snd_leo_quantum_computer_loop()
{
    if ( snd::did_once( "leo_audio::snd_leo_quantum_computer_loop" ) )
    {
        return;
    }
    
    level waittill( #"quantum_computer_lp_start" );
    var_ec334fb161ec9bf8 = snd::play( "amb_emt_leo_quantum_main_computer_lp", ( 14832, -4313, -4610 ) );
    var_466fb4035c6a43ca = snd::play( "emt_leo_quantum_computer_mech_lp", ( 14831, -4332, -4660 ) );
    level waittill( #"hash_89e4bddcaa814cd8" );
    wait 1.5;
    
    if ( isdefined( var_ec334fb161ec9bf8 ) )
    {
        snd::stop( var_ec334fb161ec9bf8, 2 );
        snd::stop( var_466fb4035c6a43ca, 2 );
        var_ec334fb161ec9bf8 = undefined;
        var_466fb4035c6a43ca = undefined;
    }
}

// Namespace leo_audio
// Params 0
// Checksum 0xd2e5abed, Offset: 0x2ff7
// Size: 0x89
function function_e0e6a157fbbbfcea()
{
    level waittill( #"quantum_intro_mix_start" );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_leo_quantum_intro", 0.2 );
    wait 1.7;
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_leo_quantum_intro", 0.2 );
    wait 3.1;
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_leo_quantum_intro", 0.2 );
    wait 1.3;
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_leo_quantum_intro", 0.2 );
}

// Namespace leo_audio
// Params 0
// Checksum 0xf0e446d0, Offset: 0x3088
// Size: 0x27
function function_52eae48a78348120()
{
    level notify( #"hash_89e4bddcaa814cd8" );
    snd::play( "evt_quantum_chamber_shutdown", ( 14834, -4327, -4517 ) );
}

// Namespace leo_audio
// Params 2
// Checksum 0x3a879245, Offset: 0x30b7
// Size: 0x4a
function function_9f2ae7bd84918dfd( bot_door_l, bot_door_r )
{
    snd::play( "evt_leo_quantum_robot_bay_door_main", ( 14832, -4798, -4657 ) );
    snd::play( "evt_leo_quantum_robot_bay_door_left", bot_door_l );
    snd::play( "evt_leo_quantum_robot_bay_door_right", bot_door_r );
}

// Namespace leo_audio
// Params 0
// Checksum 0x3ea0c7b1, Offset: 0x3109
// Size: 0x43
function function_24c0f8ec1f7e2162()
{
    function_8298dcb33227b392( "fly_guildbot_alert_compact", ( 14990, -4881, -4707 ) );
    wait randomfloatrange( 0.2, 0.3 );
    function_8298dcb33227b392( "fly_guildbot_alert_compact", ( 14676, -4882, -4707 ) );
}

// Namespace leo_audio
// Params 0
// Checksum 0xa7a99609, Offset: 0x3154
// Size: 0x43
function function_24c0f7ec1f7e1f2f()
{
    function_8298dcb33227b392( "fly_guildbot_alert_compact", ( 14925, -4888, -4707 ) );
    wait randomfloatrange( 0.2, 0.3 );
    function_8298dcb33227b392( "fly_guildbot_alert_compact", ( 14737, -4883, -4707 ) );
}

// Namespace leo_audio
// Params 0
// Checksum 0xd0aea689, Offset: 0x319f
// Size: 0x43
function function_24c0f6ec1f7e1cfc()
{
    function_8298dcb33227b392( "fly_guildbot_alert_compact", ( 14799, -4890, -4707 ) );
    wait randomfloatrange( 0.2, 0.3 );
    function_8298dcb33227b392( "fly_guildbot_alert_compact", ( 14863, -4887, -4707 ) );
}

// Namespace leo_audio
// Params 0
// Checksum 0xc9c5b2ab, Offset: 0x31ea
// Size: 0x4d
function function_5e92f369f16985e0()
{
    spawn_closet_origins = [ ( 15422, -4690, -4430 ), ( 14279, -4685, -4545 ) ];
    snd::play( "dxx_leo_quantum_spawn_closet_int", spawn_closet_origins );
    snd::play( "evt_leo_quantum_spawn_closet_alarm", spawn_closet_origins );
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x3933a19e, Offset: 0x323f
    // Size: 0xf, Type: dev
    function private function_4940f79028b4bff3( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0x1a628ef3, Offset: 0x3256
// Size: 0x2
function facility_escape_1()
{
    
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xfd972e8b, Offset: 0x3260
    // Size: 0xf, Type: dev
    function private function_3a2426b6f9f7e463( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0x26747de7, Offset: 0x3277
// Size: 0x2
function facility_cradle()
{
    
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x7e93db4e, Offset: 0x3281
    // Size: 0xf, Type: dev
    function private function_1400c439735ba016( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0x836bdf49, Offset: 0x3298
// Size: 0x2
function facility_escape_2()
{
    
}

// Namespace leo_audio
// Params 0
// Checksum 0x95dc1f77, Offset: 0x32a2
// Size: 0x59
function function_b278cdf47d285895()
{
    wait 1;
    utility::exploder( "snd_escape_alarms" );
    utility::exploder( "snd_escape_vent_walla" );
    utility::exploder( "snd_escape_tree_fire" );
    utility::flag_wait( "flag_leo_transition_igc_start" );
    utility::stop_exploder( "snd_escape_alarms" );
    utility::stop_exploder( "snd_escape_vent_walla" );
    utility::stop_exploder( "snd_escape_tree_fire" );
}

// Namespace leo_audio
// Params 0
// Checksum 0x1804b287, Offset: 0x3303
// Size: 0x3b
function function_3f45abf1c1a57a72()
{
    escape_tree_fire_lp = snd::play( "amb_emt_leo_escape_tree_fire_lp", ( 12985, 3130, -4826 ) );
    utility::flag_wait( "flag_leo_transition_igc_start" );
    snd::stop( escape_tree_fire_lp );
}

// Namespace leo_audio
// Params 0
// Checksum 0xbacdeacb, Offset: 0x3346
// Size: 0xf8
function function_a39a0388f4ec2164()
{
    snd::play( "dxx_leo_guild_scientist_cradle_start", ( 12985, 3130, -4800 ) );
    thread function_ea9da185141ff52();
    wait 2;
    level.audio.room_walla = snd::play( "dxx_leo_guild_scientist_room_lp", ( 12985, 3130, -4800 ) );
    level.audio.plr_walla = snd::play( "evt_leo_escape_walla_lp_lr", ( 12985, 3130, -4800 ) );
    level waittill( #"hash_d954a06bbae194" );
    snd::stop( level.audio.room_walla );
    snd::stop( level.audio.plr_walla );
    chant_lp = snd::play( "evt_leo_escape_hallucination_chant_lp", ( 12985, 3130, -4800 ) );
    level utility::flag_wait( "flag_leo_transition_igc_start" );
    snd::stop( chant_lp );
}

// Namespace leo_audio
// Params 0
// Checksum 0x1a7a662c, Offset: 0x3446
// Size: 0x62
function function_ea9da185141ff52()
{
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    level.audio.whisper_lp = snd::play( "evt_leo_escape_hallucination_whisper_lp_lr", ( 12985, 3130, -4800 ) );
    level utility::flag_wait( "flag_leo_transition_igc_start" );
    snd::stop( level.audio.whisper_lp );
}

// Namespace leo_audio
// Params 1
// Checksum 0xc54a91bf, Offset: 0x34b0
// Size: 0x11e
function function_c3d7419126fe7ed2( var_af522e94e37bb3cb )
{
    switch ( var_af522e94e37bb3cb )
    {
        case #"hash_d582c3286e5c390f":
            return ( isstring( level.audio.var_afd89f2efad592c0 ) ? level.audio.var_afd89f2efad592c0 : "amb_cradled_start_light" );
        case #"hash_c71b112fe04823d6":
            return ( isstring( level.audio.var_b54ae4dd0190953 ) ? level.audio.var_b54ae4dd0190953 : "amb_cradled_start_medium" );
        case #"hash_2453c9ffec9f5c20":
            return ( isstring( level.audio.var_54f6e9544c22dc3 ) ? level.audio.var_54f6e9544c22dc3 : "amb_cradled_start_heavy" );
        default:
            return ( isstring( level.audio.var_4083c1bf8eff0e8b ) ? level.audio.var_4083c1bf8eff0e8b : "amb_cradled_start_medium" );
    }
}

// Namespace leo_audio
// Params 0
// Checksum 0xdea6e848, Offset: 0x35d6
// Size: 0x10f
function function_2d9c65b845cabe3f()
{
    self endon( #"disconnect" );
    level endon( #"hash_e9f85cf1a2dc8e0d" );
    function_48e242a6a8722ac6();
    
    while ( true )
    {
        thread cradle_timeout_handler( 20 );
        utility::waittill_any( "cradle_dosed", "cradle_timeout" );
        self notify( #"stop_cradle_timeout" );
        
        if ( isdefined( self.audio ) && self.audio.var_84f0b79924837ecb == "dosed" )
        {
            function_48e242a6a8722ac6();
            continue;
        }
        
        if ( isdefined( self.audio ) && self.audio.var_84f0b79924837ecb == "timeout" )
        {
            if ( !isdefined( level.audio ) )
            {
                level.audio = spawnstruct();
            }
            
            if ( !isdefined( level.audio.var_32d44f1835b6a82a ) )
            {
                level.audio.var_32d44f1835b6a82a = 0;
            }
            
            level.audio.var_32d44f1835b6a82a++;
            function_48e242a6a8722ac6();
        }
    }
}

// Namespace leo_audio
// Params 1
// Checksum 0x1e457750, Offset: 0x36ed
// Size: 0x65
function cradle_timeout_handler( var_8be444144e4c068e )
{
    self endon( #"stop_cradle_timeout" );
    self endon( #"disconnect" );
    wait var_8be444144e4c068e;
    
    if ( !isdefined( self.audio ) )
    {
        self.audio = spawnstruct();
    }
    
    self.audio.var_84f0b79924837ecb = "timeout";
    self notify( #"cradle_timeout" );
}

// Namespace leo_audio
// Params 0
// Checksum 0x5b83bd9d, Offset: 0x375a
// Size: 0x135
function function_48e242a6a8722ac6()
{
    if ( !isdefined( level.audio ) )
    {
        return;
    }
    
    infection_level = level.audio.var_32d44f1835b6a82a;
    med_threshold = 2;
    fast_threshold = 5;
    veryfast_threshold = 10;
    var_a9f4152166eafa70 = "";
    
    if ( infection_level >= veryfast_threshold )
    {
        var_a9f4152166eafa70 = "evt_leo_escape_heartbeat_lp_veryfast";
    }
    else if ( infection_level >= fast_threshold )
    {
        var_a9f4152166eafa70 = "evt_leo_escape_heartbeat_lp_fast";
    }
    else if ( infection_level >= med_threshold )
    {
        var_a9f4152166eafa70 = "evt_leo_escape_heartbeat_lp_med";
    }
    else
    {
        var_a9f4152166eafa70 = "evt_leo_escape_heartbeat_lp_slow";
    }
    
    if ( level.audio.var_49508e60e7233898 != var_a9f4152166eafa70 )
    {
        if ( isdefined( level.audio.var_49508e60e7233898 ) )
        {
            snd::stop( level.audio.escape_heartbeat );
        }
        
        level.audio.var_49508e60e7233898 = var_a9f4152166eafa70;
        level.audio.escape_heartbeat = snd::play( var_a9f4152166eafa70, ( 12985, 3130, -4800 ) );
        level notify( #"hash_a457298f6de08c4a", var_a9f4152166eafa70, infection_level );
    }
}

// Namespace leo_audio
// Params 0
// Checksum 0xd70c47cb, Offset: 0x3897
// Size: 0x52
function function_92b919d7fcfede0f()
{
    level notify( #"hash_4b4046d6cc03862" );
    
    if ( isdefined( level.audio.var_49508e60e7233898 ) )
    {
        snd::stop( level.audio.escape_heartbeat );
        level.audio.var_49508e60e7233898 = undefined;
    }
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xc344a96d, Offset: 0x38f1
    // Size: 0xf, Type: dev
    function private function_e386791cf5a4fb9b( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0x1fc9d8df, Offset: 0x3908
// Size: 0x2
function facility_to_jungle()
{
    
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xb7007f6e, Offset: 0x3912
    // Size: 0xf, Type: dev
    function private function_d40b6693382ff22e( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0xb1f87d33, Offset: 0x3929
// Size: 0x2
function jungle_intro()
{
    
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x5f801354, Offset: 0x3933
    // Size: 0xf, Type: dev
    function private function_a796160cc6ae6bc( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0x8f09271b, Offset: 0x394a
// Size: 0x40
function jungle_village()
{
    utility::flag_wait( "flag_jungle_hill_enemies_spawned" );
    snd::play( "evt_leo_jungle_hilltop_cradle_spawn", ( -2149, 3697, -64 ) );
    snd::play( "dxx_leo_jungle_hilltop_enemy_spawn_walla", ( -2149, 3697, -64 ) );
}

// Namespace leo_audio
// Params 1
// Checksum 0x6784931e, Offset: 0x3992
// Size: 0x7c
function function_e710af4789205a58( machete_target_scriptable )
{
    self endon( #"walla_played" );
    
    if ( isdefined( machete_target_scriptable ) )
    {
        while ( true )
        {
            machete_target_scriptable_state = machete_target_scriptable getscriptablepartstate( "impact", 1 );
            
            if ( machete_target_scriptable_state == "show" )
            {
                break;
            }
            
            wait 0.1;
        }
        
        function_8298dcb33227b392( "dxx_leo_jungle_intro_machete_death", ( -2190, 3688, -88 ) );
        self notify( #"walla_played" );
        return;
    }
    
    return;
}

// Namespace leo_audio
// Params 1
// Checksum 0x33daf4a2, Offset: 0x3a16
// Size: 0x1a
function function_6a9b8b35cfb04c6e( vehicle )
{
    snd::play( "evt_leo_jungle_vehicle_entry", vehicle );
}

// Namespace leo_audio
// Params 0
// Checksum 0xba996113, Offset: 0x3a38
// Size: 0x82
function menendez_gate_attract_lp()
{
    if ( snd::did_once( "leo_audio::menendez_gate_attract_lp" ) )
    {
        return;
    }
    
    attract_lp = snd::play( "evt_leo_menendez_gate_attract_lp", ( -1331, -1562, 219 ) );
    gate_attract = snd::emitter( "evt_leo_menendez_gate_attract", ( -1450, -1665, 240 ), [ 6, 12 ] );
    function_dee2acc8b25628c8( "jungle_village_obj_marker_end" );
    snd::stop( attract_lp );
    snd::stop( gate_attract );
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xe281e635, Offset: 0x3ac2
    // Size: 0xf, Type: dev
    function private function_97f9b7a1f9332eb9( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0xb723a5af, Offset: 0x3ad9
// Size: 0x2
function jungle_mansion()
{
    
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0xd67244cc, Offset: 0x3ae3
    // Size: 0xf, Type: dev
    function private function_73914e43e099ee9e( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0x5de5a5aa, Offset: 0x3afa
// Size: 0x2
function jungle_mansion_defend()
{
    
}

/#

    // Namespace leo_audio
    // Params 1, eflags: 0x4
    // Checksum 0x5e797425, Offset: 0x3b04
    // Size: 0xf, Type: dev
    function private function_308d5d7719d6a875( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace leo_audio
// Params 0
// Checksum 0xea88438a, Offset: 0x3b1b
// Size: 0x2
function jungle_mansion_escape()
{
    
}

