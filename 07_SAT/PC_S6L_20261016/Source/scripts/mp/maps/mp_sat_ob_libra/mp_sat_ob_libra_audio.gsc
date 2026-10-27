// scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio.gsc  (hash_5d30a758244a430c.gscc) (size: 42797 Bytes / 0xa72d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6c4c22a8 (1816928936)
// size ...... 42797 (0xa72d)
// includes .. 8   (offset: 0x9975)
// strings ... 225 (offset: 0x99b5)
// dev strs .. 20  (offset: 0xa5e1)
// exports ... 116 (offset: 0x71c9)
// cseg ...... 0x1dea + 0x53df (0x71c9)
// imports ... 148 (offset: 0x83e9)
// animtree1 . 0   (offset: 0xa72d)
// animtree2 . 0   (offset: 0xa72d)
#using script_66878054d141dbc0;
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_draw;
#using scripts\common\snd\snd_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\snd\snd_ob;

#namespace libra_audio;

/#

    // Namespace libra_audio
    // Params 1, eflags: 0x4
    // Checksum 0x917f2b6f, Offset: 0x1e08
    // Size: 0xf, Type: dev
    function private function_b840cf6bb7f160dc( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace libra_audio
// Params 0
// Checksum 0xae104a78, Offset: 0x1e1f
// Size: 0xa
function main()
{
    level thread _audio_init();
}

// Namespace libra_audio
// Params 0
// Checksum 0x40d088f5, Offset: 0x1e31
// Size: 0x15
function _audio_init()
{
    snd::start_init( &_start );
    snd::wait_init();
}

// Namespace libra_audio
// Params 1
// Checksum 0x2e82119c, Offset: 0x1e4e
// Size: 0x216
function _start( start_point )
{
    assert( start_point == level.current_activity.dataobjects[ "<dev string:x24>" ].value, "<dev string:x35>" );
    level thread music( start_point );
    
    switch ( start_point )
    {
        case #"hash_dbd99654e329169e":
            break;
        case #"hash_7555eda58d5fc60":
        case #"hash_266a2dcc18346e30":
        case #"hash_4d25cac9c61bed6b":
        case #"hash_e3d7df7ed03c196e":
            level thread infil();
            break;
        case #"hash_fd0edf528cdd02a3":
            level thread igc_answers();
            break;
        case #"hash_422290f8014d24ef":
        case #"hash_9b293513631236aa":
            level thread ambush();
            break;
        case #"hash_215d7983f6759f9c":
        case #"hash_5014ed4caeb735db":
        case #"hash_705f5535126edd40":
        case #"hash_830bc48b60b596db":
        case #"hash_942aa66648343ad8":
        case #"hash_c9df48e12b379797":
        case #"hash_d2f2c5a0e42efe1c":
            break;
        case #"hash_dda44f983ac1237b":
            level thread OB_LIBRA_BOSS_1();
            break;
        case #"hash_dda450983ac1250e":
            level thread OB_LIBRA_BOSS_2();
            break;
        case #"hash_dda451983ac126a1":
            level thread OB_LIBRA_BOSS_3();
            break;
        case #"hash_b6c30c76d3ea549":
            break;
        case #"hash_b574885db2acbf49":
            level thread ob_libra_escape();
            break;
        case #"hash_3dd1b0578ff495b1":
            break;
        case #"hash_6684272dc57f0457":
        case #"hash_e345c3f4ca13f5e3":
        case #"hash_e345c4f4ca13f776":
        case #"hash_e345c5f4ca13f909":
            level thread OB_LIBRA_BOSS_1();
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

    // Namespace libra_audio
    // Params 1, eflags: 0x4
    // Checksum 0xb70729f1, Offset: 0x206c
    // Size: 0xf, Type: dev
    function private function_2f8bab071e3e576a( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace libra_audio
// Params 2, eflags: 0x4
// Checksum 0x56a4d671, Offset: 0x2083
// Size: 0x91
function private function_269826bfc5146f8f( state, squad )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
            snd_ob::squad_music( squad, "mx_libra_targets_idle_lp" );
            break;
        case #"hash_9e02cd4a0f3ca981":
            snd_ob::squad_music_with_boost( squad, "mx_libra_targets_ahead_lp", 4, 120, 2, 16, 16 );
            thread function_79fa01f8afcd6d65();
            break;
        case #"hash_3015d6b4c9f55525":
        case #"hash_7b6614415d1b2e48":
        default:
            break;
    }
}

// Namespace libra_audio
// Params 1
// Checksum 0x6bdad998, Offset: 0x211c
// Size: 0x4c9
function music( start )
{
    level endon( #"game_ended" );
    
    if ( snd::did_once( "libra_audio::music" ) )
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
        case #"hash_dbd99654e329169e":
            utility::flag_wait( "flat_sat_libra_offshore_approach_done" );
        case #"hash_7555eda58d5fc60":
        case #"hash_266a2dcc18346e30":
        case #"hash_4d25cac9c61bed6b":
        case #"hash_e3d7df7ed03c196e":
            wait 1;
            snd_ob::squad_music_with_boost( squad, "mx_libra_targets_idle_lp", 6, 120, 0, 16, 16 );
            wait 1;
            snd_ob::squad_combat_state( squad, &function_269826bfc5146f8f );
            utility::flag_wait( "flag_infil_packing_done" );
            snd_ob::squad_combat_state_stop( squad );
            snd_ob::squad_music_stop( squad );
        case #"hash_fd0edf528cdd02a3":
            snd_ob::squad_igc_music( squad, "mx_libra_answers", 3, 125, 4, 16, 16 );
            utility::flag_wait( "flag_igc_answers_done" );
        case #"hash_9b293513631236aa":
            utility::flag_wait( "flag_activate_ambush_gas" );
            wait 1;
        case #"hash_422290f8014d24ef":
        case #"hash_705f5535126edd40":
            snd_ob::squad_music_with_boost( squad, "mx_libra_need_an_exit_lp", 6, 125, 0, 32, 32 );
            utility::flag_wait( "flag_pre_processing_dead" );
        case #"hash_830bc48b60b596db":
            utility::flag_wait( "start_processing" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_igc_processing_start" );
            snd_ob::squad_igc_music( squad, "mx_libra_bioreactor", 1, 120, 0, 4, 4 );
            utility::flag_wait( "flag_igc_processing_done" );
        case #"hash_5014ed4caeb735db":
        case #"hash_942aa66648343ad8":
        case #"hash_c9df48e12b379797":
            wait 1.17647;
            snd_ob::squad_music_with_boost( squad, "mx_libra_bioreactor_combat_lp", 4, 146, 4, 16, 32 );
            utility::flag_wait_all( "pump_a_done", "pump_b_done" );
            snd_ob::squad_music_stop( squad );
            wait 0.410959;
        case #"hash_d2f2c5a0e42efe1c":
            snd_ob::squad_music_with_boost( squad, "mx_libra_pressure_maxed_out_lp", 4, 146, 4, 16, 16 );
            utility::flag_wait( "flag_backtrack_done" );
            snd_ob::squad_music_stop( squad );
        case #"hash_215d7983f6759f9c":
            utility::flag_wait( "flag_igc_boss_intro_start" );
            utility::flag_wait( "flag_igc_boss_intro_done" );
        case #"hash_dda44f983ac1237b":
            snd_ob::squad_music_with_boost( squad, "mx_libra_boss_fight_lp", 4, 176, 0, 32, 32 );
            level waittill( #"finished_mech" );
            snd_ob::squad_music_with_boost( squad, "mx_libra_finishing_blow_1", 1, 176, 0, 8, 8 );
            utility::flag_wait( "stage1_done" );
        case #"hash_dda450983ac1250e":
            snd_ob::squad_music_with_boost( squad, "mx_libra_boss_fight_lp", 4, 176, 0, 32, 32 );
            level waittill( #"finished_mech" );
            snd_ob::squad_music_with_boost( squad, "mx_libra_finishing_blow_2", 1, 176, 0, 8, 8 );
            utility::flag_wait( "stage2_done" );
        case #"hash_dda451983ac126a1":
            snd_ob::squad_music_with_boost( squad, "mx_libra_boss_fight_lp", 4, 176, 0, 32, 32 );
            level waittill( #"finished_mech" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "stage3_done" );
        case #"hash_b6c30c76d3ea549":
            utility::flag_wait( "flag_igc_boss_outro_start" );
            utility::flag_wait( "flag_igc_boss_outro_end" );
        case #"hash_b574885db2acbf49":
            snd_ob::squad_music_with_boost( squad, "mx_libra_final_flight_lp", 4, 176, 2, 32, 32 );
            squad thread function_7346541e446151ab();
            utility::flag_wait( "flag_escape_done" );
            snd_ob::squad_music_boost( squad, 8, 176, 4, 24, 8 );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_escape_done_fade_out" );
            utility::flag_wait( "flag_escape_really_done" );
        case #"hash_6684272dc57f0457":
        case #"hash_e345c3f4ca13f5e3":
        case #"hash_e345c4f4ca13f776":
        case #"hash_e345c5f4ca13f909":
            snd_ob::squad_music_with_boost( squad, "mx_libra_final_flight_lp", 4, 176, 2, 32, 32 );
            break;
        case #"hash_6d961012822f635":
        case #"hash_3dd1b0578ff495b1":
            break;
    }
}

/#

    // Namespace libra_audio
    // Params 2, eflags: 0x4
    // Checksum 0x3e588fbd, Offset: 0x25ed
    // Size: 0x9e, Type: dev
    function private function_2c5d77dfa4257082( radius, height )
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( snd::function_542b9fda0c23d8f4() > 1 )
            {
                end = self.origin + ( 0, 0, height );
                color = ( randomfloatrange( 0.5, 1 ), randomfloatrange( 0.5, 1 ), randomfloatrange( 0.5, 1 ) );
                cylinder( self.origin, end, radius, color, 0, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace libra_audio
// Params 3, eflags: 0x4
// Checksum 0xf944be43, Offset: 0x2693
// Size: 0xf7
function private function_99191b48f1871cd3( db, elevation_min, elevation_max )
{
    self endon( #"disconnect" );
    self endon( #"hash_e4bee99316aa549c" );
    scale = 0;
    
    while ( isplayer( self ) )
    {
        player_elevation = self.origin[ 2 ];
        elevation_scale = snd::scalerp( player_elevation, 3800, 7600, 0, 0.65 );
        elevation_scale = int( ( elevation_scale * 100 + 2.5 ) * 0.2 ) * 5 * 0.01;
        
        if ( scale != elevation_scale )
        {
            scale = elevation_scale;
            self setsoundsubmix( "boost_music", 0.1, elevation_scale );
            
            /#
                if ( snd::function_542b9fda0c23d8f4() > 0 )
                {
                    snd::function_7a77574e2157fbce( "<dev string:xa6>" + player_elevation + "<dev string:xb1>" + scale * 10 + "<dev string:xb8>" + elevation_scale );
                }
            #/
        }
        
        wait 0.1;
    }
}

// Namespace libra_audio
// Params 1, eflags: 0x4
// Checksum 0x6ebffdf0, Offset: 0x2792
// Size: 0x7d
function private function_e5e2697143a6746c( trigger )
{
    self endon( #"disconnect" );
    self endon( #"hash_e4bee99316aa549c" );
    assert( isent( trigger ) );
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && ent == self )
        {
            thread function_99191b48f1871cd3( 8, 3800, 7600 );
            break;
        }
        
        continue;
    }
}

// Namespace libra_audio
// Params 0, eflags: 0x4
// Checksum 0x88ba5512, Offset: 0x2817
// Size: 0x14f
function private function_7346541e446151ab()
{
    level endon( #"game_ended" );
    trigger = spawn( "trigger_radius", ( -2000, 7600, 3800 ), 0, 1500, 3800 );
    
    /#
        trigger thread function_2c5d77dfa4257082( 1500, 3800 );
    #/
    
    foreach ( player in self.players )
    {
        if ( isplayer( player ) )
        {
            player thread function_e5e2697143a6746c( trigger );
        }
    }
    
    utility::flag_wait( "flag_escape_done" );
    
    foreach ( player in self.players )
    {
        self notify( #"hash_e4bee99316aa549c" );
    }
    
    trigger delete();
}

// Namespace libra_audio
// Params 8
// Checksum 0x4aaec883, Offset: 0x296e
// Size: 0x250
function combat_walla_oneshot( ai_array, area, alias, delay_min, delay_max, var_a0c6c922d00f038d, stop_notify, group_distance )
{
    self endon( #"shutdown" );
    assert( isdefined( ai_array ), "<dev string:xc2>" );
    assert( isdefined( alias ), "<dev string:xe4>" );
    
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

// Namespace libra_audio
// Params 6
// Checksum 0x36f327fe, Offset: 0x2bc6
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

// Namespace libra_audio
// Params 3
// Checksum 0xc2f951c5, Offset: 0x2e48
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

// Namespace libra_audio
// Params 1
// Checksum 0x27190a5d, Offset: 0x316d
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

    // Namespace libra_audio
    // Params 7
    // Checksum 0x8ddc8670, Offset: 0x3245
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
            snd::function_2e8132539dbcad93( "<dev string:x103>", 0, 900, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x11b>", 0, 924, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x131>", 0, 948, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x147>", 0, 972, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x15d>", 0, 996, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x173>", 0, 1020, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x189>", 0, 1044, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x19f>", 0, 1068, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1b5>" + area, 0, 900, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1b5>" + alias, 0, 924, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1b5>" + delay_min, 0, 948, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1b5>" + delay_max, 0, 972, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1b5>" + current_enemy_count, 0, 996, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1b5>" + var_a0c6c922d00f038d, 0, 1020, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1b5>" + group_distance, 0, 1044, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            snd::function_2e8132539dbcad93( "<dev string:x1b5>" + group_count, 0, 1068, 1.5, "<dev string:x119>", ( 0.937255, 0.937255, 0.937255 ), 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            waitframe();
        }
    }

#/

// Namespace libra_audio
// Params 2
// Checksum 0x6080c1a6, Offset: 0x38cb
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

// Namespace libra_audio
// Params 0
// Checksum 0x2c4d7ca2, Offset: 0x394d
// Size: 0x60
function function_5e72d150e2e9dc1e()
{
    start_pos = ( 5350, -1572, 1440 );
    end_pos = ( 5350, -1100, 1440 );
    alias = "tst_coco_1000hz_lp_copy";
    
    while ( true )
    {
        function_d1161a541268e089( start_pos, end_pos, 5, alias );
        wait 3;
    }
}

// Namespace libra_audio
// Params 4
// Checksum 0xe073ebd4, Offset: 0x39b5
// Size: 0xb6
function function_d1161a541268e089( start_pos, end_pos, move_time, alias )
{
    sound_ent = spawn( "script_model", start_pos );
    sound_ent setmodel( "tag_origin" );
    sound_obj = undefined;
    
    if ( isdefined( sound_ent ) )
    {
        sound_obj = snd::play( alias, sound_ent );
        sound_ent thread function_93fd062dc6811fde( move_time, sound_obj );
        sound_ent moveto( end_pos, move_time );
        wait move_time * 0.5;
        
        if ( isdefined( sound_obj ) )
        {
            sound_ent.sound_stopped = 1;
            snd::stop( sound_obj );
        }
        
        wait move_time * 0.2;
        
        if ( isdefined( sound_ent ) )
        {
            sound_ent delete();
        }
    }
}

// Namespace libra_audio
// Params 2
// Checksum 0x43039be6, Offset: 0x3a73
// Size: 0xae
function function_93fd062dc6811fde( total_time, sound_obj )
{
    self endon( #"death" );
    self.sound_stopped = 0;
    
    while ( isdefined( self ) )
    {
        text_color = ( 0, 1, 0 );
        
        if ( self.sound_stopped )
        {
            text = "STOPPED";
            text_color = ( 1, 0, 0 );
        }
        else
        {
            text = "PLAYING";
        }
        
        /#
            print3d( self.origin + ( 0, 0, 15 ), text, text_color, 1, 1.5, 1, 1 );
        #/
        
        waitframe();
    }
}

/#

    // Namespace libra_audio
    // Params 1, eflags: 0x4
    // Checksum 0x7d44e900, Offset: 0x3b29
    // Size: 0xf, Type: dev
    function private function_d2b66ccfae167420( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace libra_audio
// Params 0
// Checksum 0x40333ecb, Offset: 0x3b40
// Size: 0x2
function infil()
{
    
}

// Namespace libra_audio
// Params 0
// Checksum 0xee806e4, Offset: 0x3b4a
// Size: 0x3a
function function_79fa01f8afcd6d65()
{
    wait 0.75;
    snd::play( "dxx_libra_infil_analysis_spotted_l", ( 3239, -1594, 1502 ) );
    snd::play( "dxx_libra_infil_analysis_spotted_r", ( 4045, -753, 1533 ) );
}

// Namespace libra_audio
// Params 0
// Checksum 0x30ef6aa, Offset: 0x3b8c
// Size: 0x1b
function function_a489203dbfc6a70c()
{
    snd::play( "dxx_libra_retreat_int", ( 2653, -1346, 1411 ) );
}

// Namespace libra_audio
// Params 0
// Checksum 0x5c6f41a0, Offset: 0x3baf
// Size: 0x3e
function storage_amb()
{
    quad_lp = snd::play( "amb_quad_3d_libra_storage_lr", ( 852, -1927, 1528 ) );
    utility::flag_wait( "robotic_lines_disabled" );
    snd::stop( quad_lp );
    quad_lp = undefined;
}

// Namespace libra_audio
// Params 0
// Checksum 0xb3d3862d, Offset: 0x3bf5
// Size: 0x56
function function_63b025f5c9945ee7()
{
    level endon( #"flag_igc_answers_start" );
    
    while ( true )
    {
        utility::flag_wait( "in_pre_vista_hallway" );
        level thread function_a584048f49334b82();
        level thread function_5fce124a297e8aeb();
        utility::flag_waitopen( "in_pre_vista_hallway" );
        level notify( #"hash_996f91380784f121" );
        level notify( #"hash_6f1012bfae7bc085" );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xa2b4ad6c, Offset: 0x3c53
// Size: 0x7d
function function_a584048f49334b82()
{
    level endon( #"hash_538823b5e8d69c33" );
    level endon( #"hash_996f91380784f121" );
    vista_entrance_door = getent( "vista_tube_entrance_door", #script_noteworthy );
    
    if ( isdefined( vista_entrance_door ) )
    {
        vista_submix = snd::play( "evt_libra_pre_vista_submix", vista_entrance_door.origin );
    }
    
    level waittill( #"hash_996f91380784f121" );
    
    if ( isdefined( vista_submix ) )
    {
        snd::stop( vista_submix );
        vista_submix = undefined;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x3dfd194d, Offset: 0x3cd8
// Size: 0x179
function function_5fce124a297e8aeb()
{
    level endon( #"hash_538823b5e8d69c33" );
    level endon( #"hash_6f1012bfae7bc085" );
    var_6cabbbcae234a150 = getent( "vista_chamber", "targetname" );
    
    if ( !isdefined( var_6cabbbcae234a150 ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player.enter_sound_played = 0;
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( var_6cabbbcae234a150 ) && isalive( player ) )
            {
                if ( !player.enter_sound_played )
                {
                    player playsoundtoplayer( #"hash_a37922472830e24d", player );
                    player.enter_sound_played = 1;
                }
                
                continue;
            }
            
            player.enter_sound_played = 0;
        }
        
        waitframe();
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x5caa30ac, Offset: 0x3e59
// Size: 0x42
function function_e4c47ab5254bf37c()
{
    level endon( #"flag_igc_answers_start" );
    
    while ( true )
    {
        utility::flag_wait( "vista_chamber" );
        level thread function_baf1e6cf72b8bf0d();
        utility::flag_waitopen( "vista_chamber" );
        level notify( #"hash_538823b5e8d69c33" );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xcbb87f1a, Offset: 0x3ea3
// Size: 0x126
function function_baf1e6cf72b8bf0d()
{
    level endon( #"hash_538823b5e8d69c33" );
    var_6cabbbcae234a150 = getent( "vista_chamber", "targetname" );
    
    if ( !isdefined( var_6cabbbcae234a150 ) )
    {
        return;
    }
    
    while ( true )
    {
        var_a4ffd32ecd0df562 = [];
        
        foreach ( player in level.players )
        {
            if ( player istouching( var_6cabbbcae234a150 ) && isalive( player ) )
            {
                var_a4ffd32ecd0df562[ var_a4ffd32ecd0df562.size ] = player;
            }
        }
        
        if ( var_a4ffd32ecd0df562.size > 0 )
        {
            wait 5;
            sphere_orgs = [ ( -2899, -2775, 1746 ), ( -2800, -3310, 1814 ), ( -2707, -3835, 1724 ) ];
            snd::play( "evt_libra_vista_gong_hit", sphere_orgs );
        }
        
        wait 20;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xc59ed1ce, Offset: 0x3fd1
// Size: 0x1b
function function_ddf1397edd228987()
{
    snd::play( "dxx_libra_retreat_int", ( 736, -4453, 1379 ) );
}

// Namespace libra_audio
// Params 0
// Checksum 0xda7f7db9, Offset: 0x3ff4
// Size: 0x1b
function function_c0de1a36e5c5791()
{
    snd::play( "dxx_libra_retreat_int", ( 1742, -5031, 1040 ) );
}

// Namespace libra_audio
// Params 1
// Checksum 0x2e204bb7, Offset: 0x4017
// Size: 0x9d
function function_65ced7f0b3eaf0d6( group_number )
{
    switch ( group_number )
    {
        case #"hash_84f1d2b9067b5f6c":
            snd::play( "evt_cradle_packer_group_destroy", ( 2078, -5153, 1227 ) );
            break;
        case #"hash_84f1d5b9067b6425":
            snd::play( "evt_cradle_packer_group_destroy", ( 1846, -5012, 996 ) );
            break;
        case #"hash_84f1d4b9067b6292":
            snd::play( "evt_cradle_packer_group_destroy", ( 2413, -5011, 996 ) );
            break;
        default:
            break;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xad830e34, Offset: 0x40bc
// Size: 0x75
function igc_answers()
{
    level waittill( #"libra_igc_answers_start" );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_libra_igc_reduce_amb" );
    wait 6;
    monitor_sfx = snd::play( "sat_ob_libra_igc_answers_amb_monitor", ( 3096, -5055, 1055 ) );
    utility::flag_wait( "flag_igc_answers_done" );
    snd::stop( monitor_sfx );
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_libra_igc_reduce_amb" );
}

// Namespace libra_audio
// Params 0
// Checksum 0xe19281b6, Offset: 0x4139
// Size: 0x17
function ambush()
{
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_libra_igc_reduce_amb" );
}

// Namespace libra_audio
// Params 0
// Checksum 0x3a224537, Offset: 0x4158
// Size: 0x5d
function ambush_intro_walla()
{
    var_7716ccc8e9d439bc = [ ( 4857, -5189, 1315 ), ( 3658, -4501, 1384 ), ( 4355, -4686, 1314 ) ];
    thread function_7b7c6f535f20fd81();
    wait 1.5;
    snd::play( "dxx_libra_spotted_int", var_7716ccc8e9d439bc );
}

// Namespace libra_audio
// Params 0
// Checksum 0xf46b333d, Offset: 0x41bd
// Size: 0x76
function function_7b7c6f535f20fd81()
{
    level utility::flag_wait( "flag_ambush_first_ff_disabled" );
    wait 2;
    wave1_enemies = getaiarray();
    level.audio.var_25e584ceb1945db6[ "ambush_wave1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "ambush_wave1" ] thread combat_walla_oneshot( wave1_enemies, "ambush_wave1", "dxx_libra_mech_bot_combat", 3, 6, 3, undefined, 800 );
}

// Namespace libra_audio
// Params 1
// Checksum 0xbbdd19ee, Offset: 0x423b
// Size: 0x7b
function function_8965bc616d65aa2e( ender )
{
    level endon( ender );
    
    while ( true )
    {
        utility::ent_flag_wait( "flag_inside_ambush_exit_hallucination" );
        level.snd.underwateroverride = "mp_sat_ob_ambush_underwater";
        thread function_4a027c1a9d404288();
        utility::ent_flag_waitopen_any( "flag_inside_ambush_exit_hallucination" );
        self notify( #"hallucination_exited" );
        level.snd.underwateroverride = undefined;
        self playlocalsound( "evt_libra_vista_water_exit" );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x1356c64a, Offset: 0x42be
// Size: 0x6a
function function_4a027c1a9d404288()
{
    self endon( #"hallucination_exited" );
    
    while ( true )
    {
        self waittill( #"hash_d6c47bd2cde09578" );
        self playlocalsound( "evt_swim_plunge" );
        self setentitysoundcontext( "atmosphere", "underwater" );
        utility::waittill_any( "jup_swim_surface", "jup_swim_none" );
        self playlocalsound( "evt_swim_surface" );
        self setentitysoundcontext( "atmosphere", "default" );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xea8a2fb8, Offset: 0x4330
// Size: 0x47
function ambush_exit_swim_door_exit()
{
    ambush_exit_swim_door = getent( "ambush_exit_swim_door", #script_noteworthy );
    ambush_exit_swim_door waittill( #"opening" );
    utility::ent_flag_waitopen_any( "flag_inside_ambush_exit_hallucination" );
    snd::play( "evt_ambush_exit_lighting_change", self );
}

// Namespace libra_audio
// Params 0
// Checksum 0x4b070179, Offset: 0x437f
// Size: 0x21
function function_365b0bd51dacb480()
{
    snd::play( "uin_armory_mech_console_activate", level.mech_activation_button.origin );
}

// Namespace libra_audio
// Params 0
// Checksum 0xdc8eb378, Offset: 0x43a8
// Size: 0x17
function mech_hum_start()
{
    snd::play( "evt_armory_mech_activate_hum_start", self.origin );
}

// Namespace libra_audio
// Params 1
// Checksum 0xcfa626bb, Offset: 0x43c7
// Size: 0x69
function mech_activate( mech_number )
{
    if ( mech_number == 0 )
    {
        snd::play( "evt_armory_mech_awake_01", self );
    }
    else
    {
        snd::play( "evt_armory_mech_awake_02", self );
    }
    
    hum_lp = snd::play( "evt_armory_mech_activate_hum_lp", self.origin );
    level waittill( #"hash_f88cba1ff7a2dd9b" );
    snd::stop( hum_lp );
    hum_lp = undefined;
}

// Namespace libra_audio
// Params 0
// Checksum 0xf3ab089f, Offset: 0x4438
// Size: 0x52
function function_6ed49f8c46d36378()
{
    self endon( #"death" );
    
    while ( true )
    {
        utility::ent_flag_wait( "flag_mech_torso_moving" );
        move_lp = snd::play( "veh_roomba_move_lp", self );
        utility::ent_flag_waitopen_any( "flag_mech_torso_moving" );
        snd::stop( move_lp );
        move_lp = undefined;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x122782f7, Offset: 0x4492
// Size: 0x74
function function_b75198a735b395e5()
{
    snd::play( "wpn_mech_rocket_shot", self.origin );
    passby = snd::play( "wpn_mech_rocket_passby", self );
    self waittill( #"death" );
    org = self.origin;
    snd::stop( passby );
    snd::play( "exp_mech_rocket", org );
    snd::play( "exp_mech_rocket_debris", org );
}

// Namespace libra_audio
// Params 1
// Checksum 0x667b3407, Offset: 0x450e
// Size: 0x1a
function metal_door_hit( org )
{
    snd::play( "evt_metal_door_break", org );
}

// Namespace libra_audio
// Params 0
// Checksum 0x8c2fa98f, Offset: 0x4530
// Size: 0x63
function OB_LIBRA_BOSS_1()
{
    thread function_90320f1e5f34319();
    level.audio.var_d9593992833a6187 = 0;
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_libra_mechboss_phase_1", 0.1, 1 );
    utility::flag_wait( "stage1_done" );
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_libra_mechboss_phase_1", 0.5 );
}

// Namespace libra_audio
// Params 0
// Checksum 0xabbdb20, Offset: 0x459b
// Size: 0x64
function OB_LIBRA_BOSS_2()
{
    thread function_9031df1e5f33c80();
    level.audio.var_d9593992833a6187 = 1;
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_libra_mechboss_phase_2", 0.1, 1 );
    utility::flag_wait( "stage2_done" );
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_libra_mechboss_phase_2", 0.5 );
}

// Namespace libra_audio
// Params 0
// Checksum 0xbaeabd7b, Offset: 0x4607
// Size: 0x5d
function OB_LIBRA_BOSS_3()
{
    level.audio.var_d9593992833a6187 = 1;
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_libra_mechboss_phase_3", 0.1, 1 );
    utility::flag_wait( "stage3_done" );
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_libra_mechboss_phase_3", 0.5 );
}

// Namespace libra_audio
// Params 0
// Checksum 0x6ac6029e, Offset: 0x466c
// Size: 0x26
function function_90320f1e5f34319()
{
    level waittill( #"missile_explosion_01" );
    playsoundatpos( ( 10459, 7094, 846 ), "sat_ob_libra_igc_bossfight_ph1_missile_exp" );
}

// Namespace libra_audio
// Params 0
// Checksum 0x4e053e27, Offset: 0x469a
// Size: 0x26
function function_9031df1e5f33c80()
{
    level waittill( #"missile_explosion_02" );
    playsoundatpos( ( 10459, 7094, 846 ), "sat_ob_libra_igc_bossfight_ph2_missile_exp" );
}

// Namespace libra_audio
// Params 0
// Checksum 0xbef76c, Offset: 0x46c8
// Size: 0x17
function mech_init()
{
    thread mech_hitmarker();
    thread mech_beam();
    thread mech_mortar();
}

// Namespace libra_audio
// Params 0
// Checksum 0x48438fa1, Offset: 0x46e7
// Size: 0x74
function mech_hitmarker()
{
    self notify( #"hash_bcffa5df5b0f9e1f" );
    self endon( #"hash_bcffa5df5b0f9e1f" );
    mech = self;
    mech endon( #"death" );
    
    while ( true )
    {
        mech waittill( #"took_explosive_damage" );
        snd::play( "evt_mech_boss_damaged_trans", mech.origin );
        mech function_6bfb8a977e41777e( "evt_mech_boss_cradled_hurt", 0.8 );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xcfcec596, Offset: 0x4763
// Size: 0x39
function mech_disabled()
{
    mech = self;
    snd::play( "evt_mech_boss_disable", mech.origin );
    mech function_6bfb8a977e41777e( "evt_mech_boss_cradled_voice_long", 0.8 );
}

// Namespace libra_audio
// Params 0
// Checksum 0x12f61579, Offset: 0x47a4
// Size: 0xe9
function function_a6c278e91eb2eac()
{
    mech = self;
    mech waittill( #"jump_edge_start" );
    snd::play( "evt_mech_boss_superjump", mech );
    mech.var_63859b990234d13c = snd::play( "evt_mech_boss_flying_trail", mech );
    mech waittill( #"jump_edge_end" );
    wait 0.6;
    snd::stop( mech.var_63859b990234d13c, 0.2 );
    mech.var_63859b990234d13c = undefined;
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_libra_bossfight_general", 0, 0.5 );
    wait 0.08;
    land = snd::play( "evt_mech_boss_superland", mech );
    mech function_6bfb8a977e41777e( "evt_mech_boss_cradled_voice_med", 0.8 );
    wait 0.5;
    snd::stop( land );
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_libra_bossfight_general" );
}

// Namespace libra_audio
// Params 0
// Checksum 0x2f65383a, Offset: 0x4895
// Size: 0x12e
function function_4b819102971da534()
{
    mech = self;
    
    if ( !isdefined( mech.var_b93a3466c2b63148 ) )
    {
        mech function_6bfb8a977e41777e( "evt_mech_boss_cradled_voice_med", 0 );
        mech.var_63859b990234d13c = snd::play( "evt_mech_boss_incoming", mech );
        mech.var_b93a3466c2b63148 = 1;
    }
    else
    {
        mech waittill( #"jump_center_start" );
        snd::play( "evt_mech_boss_superjump", mech );
        mech.var_63859b990234d13c = snd::play( "evt_mech_boss_flying_trail", mech );
    }
    
    mech waittill( #"jump_center_end" );
    wait 0.6;
    snd::stop( mech.var_63859b990234d13c, 0.1 );
    mech.var_63859b990234d13c = undefined;
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_libra_bossfight_general", 0, 0.5 );
    wait 0.04;
    snd::play( "evt_mech_boss_superland", mech );
    snd::play( "evt_mech_boss_superand_debris_lr", mech );
    mech function_6bfb8a977e41777e( "evt_mech_boss_cradled_voice_short", 0.8 );
    wait 0.4;
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_libra_bossfight_general" );
}

// Namespace libra_audio
// Params 0
// Checksum 0x125a653a, Offset: 0x49cb
// Size: 0x109
function mech_beam()
{
    mech = self;
    mech endon( #"death" );
    mech endon( #"beam_attack_loop_finished" );
    mech thread mech_beam_watcher();
    mech childthread mech_beam_angry();
    mech.beam_sound_alias = snd::play( "evt_mech_boss_beam_lp_body", mech.origin );
    mech.var_1eadeea17173545b = snd::play( "evt_mech_boss_beam_lp_hum", mech );
    snd::play( "evt_mech_boss_beam_start", mech );
    mech function_6bfb8a977e41777e( "evt_mech_boss_cradled_voice_med", 0 );
    offset = 500;
    
    while ( true )
    {
        direction = vectornormalize( mech.beam_ent.origin - mech.origin );
        final = mech.origin + direction * offset;
        mech.beam_sound_alias moveto( final, 0.1 );
        waitframe();
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x1bb9269c, Offset: 0x4adc
// Size: 0x4e
function mech_beam_watcher()
{
    mech = self;
    mech endon( #"death" );
    mech waittill( #"beam_attack_loop_finished" );
    snd::stop( mech.beam_sound_alias );
    snd::stop( mech.var_1eadeea17173545b );
}

// Namespace libra_audio
// Params 0
// Checksum 0xf84b211a, Offset: 0x4b32
// Size: 0x3e
function mech_beam_angry()
{
    mech = self;
    
    while ( true )
    {
        mech waittill( #"focus_target_found" );
        mech function_6bfb8a977e41777e( "evt_mech_boss_cradled_voice_med", 0.2 );
        wait 0.5;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xfae7c9c7, Offset: 0x4b78
// Size: 0x46
function mech_mortar()
{
    self notify( #"hash_a7b1cc79a145c85e" );
    self endon( #"hash_a7b1cc79a145c85e" );
    mech = self;
    mech endon( #"death" );
    mech childthread function_d11bac27b8a67a80();
    mech childthread function_9d8acad3fce4e9ae();
}

// Namespace libra_audio
// Params 0
// Checksum 0xa98b98d4, Offset: 0x4bc6
// Size: 0x57
function function_d11bac27b8a67a80()
{
    mech = self;
    
    while ( true )
    {
        mech waittill( #"marker_placed" );
        marker = snd::play( "ui_alert_mortar", mech.var_e8196b1de7e7b7dd );
        wait 3;
        snd::stop( marker );
        marker = undefined;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xd75d8826, Offset: 0x4c25
// Size: 0x52
function function_9d8acad3fce4e9ae()
{
    mech = self;
    
    while ( true )
    {
        self waittill( #"mortar_launch" );
        missile = mech.grenades[ mech.grenades.size - 1 ];
        missile thread function_8f304fd19b830a76();
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x524a131c, Offset: 0x4c7f
// Size: 0x8e
function function_8f304fd19b830a76()
{
    missile = self;
    missile.var_f73a47a8339e8d9b = snd::play( "evt_mech_boss_mortar_trail", missile );
    missile waittill( #"exploded" );
    var_cbc01698b215f895 = missile.var_f73a47a8339e8d9b.origin;
    snd::stop( missile.var_f73a47a8339e8d9b );
    missile.var_f73a47a8339e8d9b = undefined;
    snd::play( "exp_mech_boss_mortar", var_cbc01698b215f895 );
    snd::play( "evt_mech_boss_mortar_debris_lr", var_cbc01698b215f895 );
}

// Namespace libra_audio
// Params 2
// Checksum 0x154273ab, Offset: 0x4d15
// Size: 0x55
function function_6bfb8a977e41777e( alias, start_delay )
{
    if ( !level.audio.var_d9593992833a6187 )
    {
        return;
    }
    
    mech = self;
    snd::play( [ start_delay, alias, 0 ], mech );
}

// Namespace libra_audio
// Params 0
// Checksum 0x6661c437, Offset: 0x4d72
// Size: 0x79
function function_3560b6b6768232bb()
{
    snd::waitforplayers();
    assert( isplayer( level.players[ 0 ] ) );
    squad = snd::function_c0c0d18177bbad02( level.players[ 0 ] );
    assert( snd::issquad( squad ) );
    level.audio.var_25e584ceb1945db6[ "armory" ] = spawnstruct();
    snd_ob::squad_combat_state( squad, &function_2e89d1fe07e471e6 );
}

// Namespace libra_audio
// Params 2, eflags: 0x4
// Checksum 0xfdb473bd, Offset: 0x4df3
// Size: 0x1b7
function private function_2e89d1fe07e471e6( state, squad )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
            if ( isdefined( level.audio.var_25e584ceb1945db6[ "armory" ] ) && isstruct( level.audio.var_25e584ceb1945db6[ "armory" ] ) )
            {
                level.audio.var_25e584ceb1945db6[ "armory" ] notify( #"squad_idling" );
                level.audio.var_25e584ceb1945db6[ "armory" ] thread combat_walla_oneshot( level.var_43dab29e2279f72b, "armory", "dxx_libra_idle_oneshot_int", 3, 8, 3, "squad_in_combat" );
                thread function_da81985ea2e5438a();
            }
            
            break;
        case #"hash_9e02cd4a0f3ca981":
            if ( isdefined( level.audio.var_25e584ceb1945db6[ "armory" ] ) && isstruct( level.audio.var_25e584ceb1945db6[ "armory" ] ) )
            {
                level.audio.var_25e584ceb1945db6[ "armory" ] notify( #"squad_in_combat" );
                level.audio.var_25e584ceb1945db6[ "armory" ] thread combat_walla_oneshot( level.var_43dab29e2279f72b, "armory", "dxx_libra_coordinated_int", 3, 8, 3, "squad_idling" );
            }
            
            self notify( #"hash_c9884d3ddb818442" );
            break;
        case #"hash_3015d6b4c9f55525":
        case #"hash_7b6614415d1b2e48":
        default:
            break;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xd7621af9, Offset: 0x4fb2
// Size: 0x79
function function_da81985ea2e5438a()
{
    convo_lp = snd::play( "dxx_libra_pre_processing_idle_lp", ( 7728, -7102, 842 ) );
    thread function_a795d57eaefda125( convo_lp, ( 7702, -7401, 842 ), 5 );
    
    if ( isdefined( convo_lp ) )
    {
        utility::delaythread( 5, &function_a795d57eaefda125, convo_lp, ( 6897, -8022, 842 ), 15 );
    }
    
    self waittill( #"hash_c9884d3ddb818442" );
    snd::stop( convo_lp );
}

// Namespace libra_audio
// Params 3
// Checksum 0x1566d7a0, Offset: 0x5033
// Size: 0x2d
function function_a795d57eaefda125( convo_lp, position, time )
{
    if ( isdefined( convo_lp ) )
    {
        convo_lp moveto( position, time );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x59ea33e7, Offset: 0x5068
// Size: 0x2b
function function_fb418899097f8fb7()
{
    if ( !isdefined( level.cradle_sphere_lp ) )
    {
        level.cradle_sphere_lp = snd::play( "amb_emt_reactor_start_synth_state_lp", level.cradle_sphere );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x983344d1, Offset: 0x509b
// Size: 0xf
function function_3e6395b6451a1a8d()
{
    snd::play( "vfx_reactor_explo_enemy_enter_start_01", self );
}

// Namespace libra_audio
// Params 5
// Checksum 0xa68c1eca, Offset: 0x50b2
// Size: 0x2a8
function function_17b69484dae782e8( var_dc6a4b4b351da087, var_d67f4e21ff0a661b, finished_flag, time_left, door )
{
    console_pos = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    door_servo = snd::play( "fly_reactor_pool_open_hatch_attached_servo_lp_01", door );
    snd::play( "evt_plr_activate_reactor_pseudo_hit", ( 3735, -7414, 1400 ) );
    snd::play( "amb_evt_reactor_pool_open_hatch_main_start_01", [ ( 3822, -8113, 1233 ), ( 3834, -6707, 1233 ) ] );
    snd::play( "fly_plr_activate_reactor_comp", console_pos.origin );
    snd::play( "fly_reactor_pool_open_hatch_main_start_01", door.origin + ( 0, 0, 100 ) );
    snd::play( "fly_reactor_pool_open_hatch_main_start_mech_01", door.origin + ( 0, 0, 100 ) );
    snd::play( "amb_reactor_pool_open_alarm_01", ( 3751, -7435, 1002 ) );
    
    if ( level.var_1f6deb184845f55b == 0 )
    {
        level.audio_room_lp = snd::play( "amb_reactor_pool_open_hatch_main_room_fill_lp_01", ( 3751, -7435, 1002 ) );
        level.var_f1fb950902accf15 = snd::play( [ 0, "amb_evt_reactor_pool_open_activated_massive_stress_lp_01", 1 ], ( 4714, -7420, 1460 ) );
        level.var_f1fb920902acc87c = snd::play( [ 0, "amb_evt_reactor_pool_open_activated_massive_stress_lp_01", 1 ], ( 3065, -7393, 1460 ) );
    }
    
    utility::flag_wait_any( var_d67f4e21ff0a661b, finished_flag );
    
    if ( level.var_1f6deb184845f55b == 0 )
    {
        snd::stop( level.audio_door_lp );
        level.audio_door_lp = undefined;
        snd::stop( level.audio_room_lp );
        level.audio_room_lp = undefined;
        snd::stop( level.var_f1fb950902accf15 );
        level.var_f1fb950902accf15 = undefined;
        snd::stop( level.var_f1fb920902acc87c );
        level.var_f1fb920902acc87c = undefined;
        snd::stop( level.var_7787b3ed940e3f5f );
        level.var_7787b3ed940e3f5f = undefined;
        snd::stop( level.var_7787b4ed940e4192 );
        level.var_7787b4ed940e4192 = undefined;
    }
    
    snd::stop( door_servo, 0.5 );
    door_servo = undefined;
    
    if ( utility::flag( finished_flag ) )
    {
        snd::play( "fly_reactor_pool_open_hatch_main_off_01", door.origin );
    }
}

// Namespace libra_audio
// Params 1
// Checksum 0x3fcb9f3c, Offset: 0x5362
// Size: 0x55
function function_88dfdf8869b920e9( var_dc6a4b4b351da087 )
{
    console_pos = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    snd::play( "fly_reactor_pool_door_comp_interrupt_01", console_pos.origin );
    snd::play( "fly_reactor_pool_open_hatch_main_off_01", ( 3743, -7420, 831 ) );
}

// Namespace libra_audio
// Params 0
// Checksum 0x567f2afa, Offset: 0x53bf
// Size: 0x1b
function function_300975db3e742073()
{
    snd::play( "fly_reactor_pool_door_open_success_end_01", ( 3751, -7435, 1002 ) );
}

// Namespace libra_audio
// Params 0
// Checksum 0xfc8ca04d, Offset: 0x53e2
// Size: 0x89
function function_7a23717c3f03bc75()
{
    var_6a6c476f2970be0a = snd::play( "amb_reactor_pool_lift_comp_attract_lp_01", ( 3499, -7410, 1151 ) );
    utility::flag_wait( "start_sphere_raise" );
    snd::stop( var_6a6c476f2970be0a );
    var_6a6c476f2970be0a = undefined;
    snd::play( "fly_plr_activate_reactor_comp", ( 3499, -7410, 1151 ) );
    snd::play( "fly_reactor_pool_lift_first_raise_top_01", ( 3731, -7407, 1450 ) );
    snd::play( "fly_reactor_pool_lift_first_raise_bottom_01", ( 3731, -7407, 920 ) );
}

// Namespace libra_audio
// Params 1
// Checksum 0x1521b883, Offset: 0x5473
// Size: 0x11d
function function_aa9fb818aed27570( end_time )
{
    level endon( #"hash_8b4a703fe980c27e" );
    
    if ( !isdefined( level.var_bc0351a68c53356e ) )
    {
        snd::play( "fly_reactor_lift_reactor_switch_direction_01", level.cradle_sphere );
        level.var_bc0351a68c53356e = snd::play( "fly_reactor_lift_upward_mech_bottom_lp", level.cradle_sphere );
        level.var_bc0350a68c53333b = snd::play( "fly_reactor_lift_upward_mech_top_lp", ( 3734, -7408, 1682 ) );
    }
    
    level notify( #"hash_91df1e33a3b24bcb" );
    
    if ( isdefined( level.var_10d694bd157a8dfc ) )
    {
        snd::stop( level.var_10d694bd157a8dfc );
        level.var_10d694bd157a8dfc = undefined;
    }
    
    thread function_ada546a75619b00c( end_time );
    
    while ( !utility::flag( "lift_complete" ) && level.cranks_active != 0 )
    {
        wait_time = randomfloatrange( 1, 4 );
        wait wait_time;
        snd::play( "amb_reactor_lift_descend_metal_mvmt", level.cradle_sphere );
        snd::play( "amb_reactor_lift_descend_dumpster_metal_mvmt", level.cradle_sphere );
    }
}

// Namespace libra_audio
// Params 1
// Checksum 0x87cce39, Offset: 0x5598
// Size: 0x68
function function_ada546a75619b00c( end_time )
{
    level endon( #"crank_change" );
    wait end_time;
    level notify( #"hash_8b4a703fe980c27e" );
    
    if ( isdefined( level.var_bc0351a68c53356e ) )
    {
        snd::stop( level.var_bc0351a68c53356e );
        level.var_bc0351a68c53356e = undefined;
        snd::stop( level.var_bc0350a68c53333b );
        level.var_bc0350a68c53333b = undefined;
    }
}

// Namespace libra_audio
// Params 1
// Checksum 0xc932ed57, Offset: 0x5608
// Size: 0x12f
function function_64906a1170a7a844( end_time )
{
    level endon( #"hash_611892dc46ae5e36" );
    
    if ( !isdefined( level.var_10d694bd157a8dfc ) )
    {
        snd::play( "fly_reactor_lift_reactor_switch_direction_01", level.cradle_sphere );
        level.var_10d694bd157a8dfc = snd::play( "fly_reactor_lift_downward_mech_lp", level.cradle_sphere );
    }
    
    if ( isdefined( level.var_bc0351a68c53356e ) )
    {
        snd::stop( level.var_bc0351a68c53356e );
        level.var_bc0351a68c53356e = undefined;
        snd::stop( level.var_bc0350a68c53333b );
        level.var_bc0350a68c53333b = undefined;
    }
    
    thread function_1163926ad1b88d98( end_time );
    
    while ( !utility::flag( "lift_complete" ) && !utility::flag( "lift_bottom" ) && level.cranks_active == 0 )
    {
        wait_time = randomfloatrange( 1, 4 );
        wait wait_time;
        snd::play( "amb_reactor_lift_descend_metal_mvmt", level.cradle_sphere );
        snd::play( "amb_reactor_lift_descend_air_release", level.cradle_sphere );
        snd::play( "amb_reactor_lift_descend_dumpster_metal_mvmt", level.cradle_sphere );
    }
}

// Namespace libra_audio
// Params 1
// Checksum 0x94b65d9c, Offset: 0x573f
// Size: 0x63
function function_1163926ad1b88d98( end_time )
{
    level endon( #"crank_change" );
    wait end_time;
    level notify( #"hash_611892dc46ae5e36" );
    snd::play( "fly_reactor_lift_downward_impact_bottom_01", level.cradle_sphere );
    
    if ( isdefined( level.var_10d694bd157a8dfc ) )
    {
        snd::stop( level.var_10d694bd157a8dfc );
        level.var_10d694bd157a8dfc = undefined;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x4a6a44c3, Offset: 0x57aa
// Size: 0xeb
function function_5d1b09ee49fe7578()
{
    snd::play( "fly_reactor_pool_lift_raise_success_01", ( 3751, -7435, 1500 ) );
    snd::play( [ 2.5, "amb_reactor_pool_lift_raise_success_puzzle_hvac_start_01", 0 ], ( 2736, -7414, 1208 ) );
    level.var_260a7a9e84ab5d9b = snd::play( [ 2.5, "amb_reactor_pool_lift_raise_success_puzzle_hvac_lp", 0 ], ( 2736, -7414, 1208 ) );
    
    if ( isdefined( level.var_bc0351a68c53356e ) )
    {
        snd::stop( level.var_bc0351a68c53356e );
        level.var_bc0351a68c53356e = undefined;
        snd::stop( level.var_bc0350a68c53333b );
        level.var_bc0350a68c53333b = undefined;
    }
    
    if ( isdefined( self.var_d3760acf7c6db823 ) )
    {
        snd::stop( self.var_d3760acf7c6db823 );
        self.var_d3760acf7c6db823 = undefined;
    }
}

// Namespace libra_audio
// Params 1
// Checksum 0x628a76ad, Offset: 0x589d
// Size: 0x3c
function function_e209a231f05103a1( var_dc6a4b4b351da087 )
{
    console_pos = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    snd::play( "fly_plr_activate_reactor_comp", console_pos.origin );
}

// Namespace libra_audio
// Params 0
// Checksum 0x1ab83c57, Offset: 0x58e1
// Size: 0x32
function function_2a58c67eb62af6ef()
{
    snd::play( [ 1.5, "evt_ui_reactor_comp_lockout_hack_01", 0 ], ( 2773, -7405, 1056 ) );
}

// Namespace libra_audio
// Params 0
// Checksum 0x7a3506b4, Offset: 0x591b
// Size: 0x44
function function_d014452496a2e975()
{
    self endon( #"death_or_disconnect" );
    self setsoundsubmix( "mp_sat_ob_libra_pipe_puzz_interact", 0.75 );
    utility::waittill_any_return( "death", "ConnectionPuzzleClosed", "ConnectionPuzzleCompleted" );
    self clearsoundsubmix( "mp_sat_ob_libra_pipe_puzz_interact", 0.75 );
}

// Namespace libra_audio
// Params 0
// Checksum 0x9b0c9d40, Offset: 0x5967
// Size: 0x83
function audio_puzzle_complete()
{
    level.var_24ca31e9d3576e5b = 1;
    
    while ( true )
    {
        level waittill( #"ConnectionPuzzleCompleted" );
        
        switch ( level.var_24ca31e9d3576e5b )
        {
            case 1:
                level thread puzzle_first_interact();
                level notify( #"hash_50d3f1c15e4e5198", "oh_no_not_good" );
                break;
            case 2:
                level thread function_20c2c264ae709736();
                level notify( #"hash_50d3f1c15e4e5198", "nuclear_meltdown_vibes" );
                break;
        }
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x2522d319, Offset: 0x59f2
// Size: 0x86
function puzzle_first_interact()
{
    level.var_24ca31e9d3576e5b = 2;
    snd::play( "fly_reactor_puzzle_first_solve_shutdown_01", ( 3740, -7405, 1522 ) );
    level.audio.var_38c387cfe83f8ad9 = snd::play( "amb_reactor_computer_alarm_lp_01", ( 2773, -7405, 1056 ) );
    level thread function_9f5ac14c9e3500e4();
    
    if ( isdefined( level.var_260a7a9e84ab5d9b ) )
    {
        snd::stop( level.var_260a7a9e84ab5d9b, 0.5 );
        level.var_260a7a9e84ab5d9b = undefined;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xd7422f9, Offset: 0x5a80
// Size: 0x1b
function function_9f5ac14c9e3500e4()
{
    snd::play( "fly_reactor_internal_pressure_raise_oneshot_01", ( 3740, -7405, 1522 ) );
}

// Namespace libra_audio
// Params 0
// Checksum 0x4460a3b8, Offset: 0x5aa3
// Size: 0x47
function function_20c2c264ae709736()
{
    level.var_24ca31e9d3576e5b = 3;
    snd::play( "fly_plr_activate_reactor_comp", ( 2773, -7405, 1056 ) );
    snd::play( "fly_reactor_puzzle_first_solve_shutdown_01", ( 3740, -7405, 1522 ) );
    level thread function_9f5ac44c9e35077d();
}

// Namespace libra_audio
// Params 0
// Checksum 0xd7422f9, Offset: 0x5af2
// Size: 0x1b
function function_9f5ac44c9e35077d()
{
    snd::play( "fly_reactor_internal_pressure_raise_oneshot_02", ( 3740, -7405, 1522 ) );
}

// Namespace libra_audio
// Params 0
// Checksum 0xa9ede950, Offset: 0x5b15
// Size: 0x3da
function function_1de68d9f3cdb878d()
{
    if ( isdefined( level.var_e04c0425c57a325.health ) )
    {
        function_398bc9ee922d91fd( "BossPressure", level.var_e04c0425c57a325.health );
        
        switch ( level.var_e04c0425c57a325.health )
        {
            case 5:
                level.var_ea109ab25d1576a5 = 0;
                level.var_d810c642b64bf1e3 = 0;
                level.var_d810c842b64bf649 = 0;
                level.var_d80c4b42b646ed8b = 0;
                level.var_d803da42b63e095a = 0;
                level.var_d803d842b63e04f4 = 0;
                level.var_56cf2b5f3fed9cfb = 0;
                level.var_473d88f54bb2e65d = 0;
                break;
            case 9:
                if ( !istrue( level.var_ea109ab25d1576a5 ) )
                {
                    level.var_ea109ab25d1576a5 = 1;
                    snd::play( "evt_reactor_pressure_build_stress_01", level.cradle_sphere.origin + ( 0, 0, 110 ) );
                    level.var_ca81ca9e0e483ef8 = snd::play( [ 0, "evt_reactor_breath_pressure_lp_01", 2 ], level.cradle_sphere.origin + ( 0, 0, 70 ) );
                }
                
                break;
            case 25:
                if ( !istrue( level.var_d810c642b64bf1e3 ) )
                {
                    utility::flag_wait( "pump_interact_b_restarted" );
                    level.var_d810c642b64bf1e3 = 1;
                    snd::play( [ 0, "evt_reactor_pseudo_explo_01", 0 ], level.cradle_sphere.origin + ( 0, 0, 110 ) );
                }
            case 27:
                if ( !istrue( level.var_d810c842b64bf649 ) )
                {
                    level.var_d810c842b64bf649 = 1;
                    snd::play( "evt_reactor_pressure_build_stress_02", level.cradle_sphere.origin + ( 0, 0, 110 ) );
                    snd::play( [ 0.75, "evt_reactor_pain_screaming_02", 0 ], level.cradle_sphere.origin + ( 0, 0, 110 ) );
                }
                
                break;
            case 50:
                function_5ef27a0d28403d72();
                function_584005243e042da7();
                break;
            case 58:
                if ( !istrue( level.var_d80c4b42b646ed8b ) )
                {
                    level.var_d80c4b42b646ed8b = 1;
                    snd::play( "evt_reactor_pressure_build_stress_03", level.cradle_sphere.origin + ( 0, 0, 110 ) );
                }
                
                break;
            case 75:
                if ( !istrue( level.var_d803da42b63e095a ) )
                {
                    utility::flag_wait( "pump_interact_a_restarted" );
                    level.var_d803da42b63e095a = 1;
                    snd::play( [ 0, "evt_reactor_pseudo_explo_02", 0 ], level.cradle_sphere.origin + ( 0, 0, 110 ) );
                    snd::play( "evt_reactor_pain_screaming_04", level.cradle_sphere.origin + ( 0, 0, 110 ) );
                }
                
                break;
            case 77:
                if ( !istrue( level.var_d803d842b63e04f4 ) )
                {
                    level.var_d803d842b63e04f4 = 1;
                    snd::play( "evt_reactor_pressure_build_stress_04", level.cradle_sphere.origin + ( 0, 0, 110 ) );
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xfc09961b, Offset: 0x5ef7
// Size: 0x73
function function_5ef27a0d28403d72()
{
    if ( !level.var_56cf2b5f3fed9cfb )
    {
        level.var_56cf2b5f3fed9cfb = 1;
        snd::play( [ 0, "evt_reactor_pressure_build_light_change_01", 0 ], level.cradle_sphere.origin + ( 0, 0, 110 ) );
        snd::stop( level.cradle_sphere_lp, 2 );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x376bc3b5, Offset: 0x5f72
// Size: 0x8a
function function_584005243e042da7()
{
    if ( !level.var_473d88f54bb2e65d )
    {
        level.var_32d93d3d9c35a9cb = snd::play( [ 0, "evt_reactor_pool_open_activated_massive_stress_lp_01", 2 ], ( 5091, -7413, 1684 ) );
        level.var_32d93e3d9c35abfe = snd::play( [ 0, "evt_reactor_pool_open_activated_massive_stress_lp_01", 2 ], ( 3136, -7413, 1684 ) );
        level.var_473d88f54bb2e65d = 1;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x6a115e86, Offset: 0x6004
// Size: 0x15c
function function_61181979347a98f2()
{
    snd::play( [ 0.25, "evt_reactor_pseudo_explo_03", 0 ], ( 3740, -7405, 1522 ) );
    snd::play( [ 0.75, "evt_reactor_pain_screaming_05", 0 ], ( 3740, -7405, 1522 ) );
    
    if ( !isdefined( level.var_ca81ca9e0e483ef8 ) )
    {
        level.var_ca81ca9e0e483ef8 = snd::play( [ 0, "evt_reactor_breath_pressure_lp_01", 1 ], ( 3740, -7405, 1522 ) );
        level.var_f1fb950902accf15 = snd::play( [ 0, "amb_evt_reactor_pool_open_activated_massive_stress_lp_01", 1 ], ( 4714, -7420, 1460 ) );
        level.var_f1fb920902acc87c = snd::play( [ 0, "amb_evt_reactor_pool_open_activated_massive_stress_lp_01", 1 ], ( 3065, -7393, 1460 ) );
    }
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "processing_pump_enemies_wave2" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "processing_pump_enemies_wave2" ] notify( #"processing_backtrack_started" );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x83b50834, Offset: 0x6168
// Size: 0x151
function function_e8b498a5e90c78af()
{
    if ( !isdefined( self.var_babe2252c9ac2cdc ) )
    {
        self.var_babe2252c9ac2cdc = [];
    }
    
    var_babe6452c9acbe02 = play_alarm( "amb_libra_alarm_01", 2, ( 3707, -7414, 1935 ), "stop_pressure_alarm_1" );
    self.var_babe2252c9ac2cdc[ self.var_babe2252c9ac2cdc.size ] = var_babe6452c9acbe02;
    level waittill( #"hash_b6ddec61831339a3" );
    var_babe6352c9acbbcf = play_alarm( "amb_libra_alarm_02", 1.6, ( 5067, -7414, 1141 ), "stop_pressure_alarm_2" );
    self.var_babe2252c9ac2cdc[ self.var_babe2252c9ac2cdc.size ] = var_babe6352c9acbbcf;
    level waittill( #"hash_da7d2c131250d9fa" );
    var_babe6252c9acb99c = play_alarm( "amb_libra_alarm_03", 1.3, ( 6191, -7414, 913 ), "stop_pressure_alarm_3" );
    self.var_babe2252c9ac2cdc[ self.var_babe2252c9ac2cdc.size ] = var_babe6252c9acb99c;
    var_babe6152c9acb769 = play_alarm( "amb_libra_alarm_01", 1.3, ( 7956, -7699, 1004 ), "stop_pressure_alarm_4" );
    self.var_babe2252c9ac2cdc[ self.var_babe2252c9ac2cdc.size ] = var_babe6152c9acb769;
    level waittill( #"stop_alarms" );
    stop_all_alarms();
}

// Namespace libra_audio
// Params 0
// Checksum 0xbabf5d33, Offset: 0x62c1
// Size: 0x158
function function_8a1846a4c3c224f8()
{
    if ( isdefined( level.audio.var_38c387cfe83f8ad9 ) )
    {
        snd::stop( level.audio.reactor_lp );
        snd::stop( level.audio.var_4279ea2cb133c7cf );
        snd::stop( level.audio.var_38c387cfe83f8ad9 );
        level.audio.reactor_lp = undefined;
        level.audio.var_4279ea2cb133c7cf = undefined;
        level.audio.var_38c387cfe83f8ad9 = undefined;
    }
    
    if ( isdefined( level.var_ca81ca9e0e483ef8 ) )
    {
        snd::stop( level.var_ca81ca9e0e483ef8 );
        snd::stop( level.var_32d93d3d9c35a9cb );
        snd::stop( level.var_32d93e3d9c35abfe );
        level.var_ca81ca9e0e483ef8 = undefined;
        level.var_32d93d3d9c35a9cb = undefined;
        level.var_32d93e3d9c35abfe = undefined;
    }
    
    if ( isdefined( level.var_ea109ab25d1576a5 ) )
    {
        level.var_ea109ab25d1576a5 = undefined;
        level.var_d810c642b64bf1e3 = undefined;
        level.var_d810c842b64bf649 = undefined;
        level.var_d80c4b42b646ed8b = undefined;
        level.var_d803da42b63e095a = undefined;
        level.var_d803d842b63e04f4 = undefined;
        level.var_56cf2b5f3fed9cfb = undefined;
        level.var_473d88f54bb2e65d = undefined;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xe73d904a, Offset: 0x6421
// Size: 0x11d
function function_e5927efd9f56b920()
{
    wait 3;
    var_50fb8db73d6cb953 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "processing_doors_wave1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "processing_doors_wave1" ] thread combat_walla_oneshot( var_50fb8db73d6cb953, "processing_doors_wave1", "dxx_libra_coordinated_int", 2, 8, 3, "processing_doors_wave2_spawned", 500 );
    wait 17;
    var_50fb8db73d6cb953 = undefined;
    var_50fb8eb73d6cbb86 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "processing_doors_wave2" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "processing_doors_wave2" ] thread combat_walla_oneshot( var_50fb8eb73d6cbb86, "processing_doors_wave2", "dxx_libra_coordinated_int", 2, 8, 3, "processing_lift_wave1_spawned", 500 );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "processing_doors_wave1" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "processing_doors_wave1" ] notify( #"processing_doors_wave2_spawned" );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x19ccf931, Offset: 0x6546
// Size: 0xb1
function function_84d61cc73e4c68c4()
{
    wait 6;
    var_7ed573e139906c0f = getaiarray();
    level.audio.var_25e584ceb1945db6[ "processing_lift_wave1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "processing_lift_wave1" ] thread combat_walla_oneshot( var_7ed573e139906c0f, "processing_lift_wave1", "dxx_libra_coordinated_int", 2, 8, 3, "processing_pump_wave1_spawned", 500 );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "processing_doors_wave2" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "processing_doors_wave2" ] notify( #"processing_lift_wave1_spawned" );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x6f11c3aa, Offset: 0x65ff
// Size: 0x16e
function function_d5a3f261295838b1()
{
    wait 6;
    processing_pump_enemies_wave1 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "processing_pump_enemies_wave1" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "processing_pump_enemies_wave1" ] thread combat_walla_oneshot( processing_pump_enemies_wave1, "processing_pump_enemies_wave1", "dxx_libra_coordinated_int", 2, 6, 3, "processing_pump_wave2_spawned", 500 );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "processing_lift_wave1" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "processing_lift_wave1" ] notify( #"processing_pump_wave1_spawned" );
    }
    
    level waittill( #"hash_2a0dcc7eeca909ad" );
    wait 6;
    processing_pump_enemies_wave1 = undefined;
    processing_pump_enemies_wave2 = getaiarray();
    level.audio.var_25e584ceb1945db6[ "processing_pump_enemies_wave2" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "processing_pump_enemies_wave2" ] thread combat_walla_oneshot( processing_pump_enemies_wave2, "processing_pump_enemies_wave2", "dxx_libra_coordinated_int", 2, 6, 3, "processing_backtrack_started", 500 );
    
    if ( isstruct( level.audio.var_25e584ceb1945db6[ "processing_pump_enemies_wave1" ] ) )
    {
        level.audio.var_25e584ceb1945db6[ "processing_pump_enemies_wave1" ] notify( #"processing_pump_wave2_spawned" );
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xf55786cd, Offset: 0x6775
// Size: 0x21
function function_71b8a97ce2054d2d()
{
    wait 0.5;
    snd::play( "dxx_libra_processing_door_breach", ( 5192, -7414, 859 ) );
}

// Namespace libra_audio
// Params 0
// Checksum 0x755ece76, Offset: 0x679e
// Size: 0x62
function function_9b68dd8c571716b0()
{
    wait 1;
    var_949b203c0170a3c4 = [ ( 5146, -7406, 1294 ), ( 5154, -6767, 1048 ), ( 5168, -8060, 1041 ) ];
    snd::play( "dxx_libra_charge_int", var_949b203c0170a3c4 );
    wait 6;
    utility::flag_set( "audio_processing_lift_started" );
}

// Namespace libra_audio
// Params 2
// Checksum 0x93b62f62, Offset: 0x6808
// Size: 0x1f
function function_beeb82f7235e4f98( alias, shake_origin )
{
    snd::play( alias, shake_origin );
}

// Namespace libra_audio
// Params 0
// Checksum 0x1bada844, Offset: 0x682f
// Size: 0x28d
function ob_libra_escape()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
    
    level.audio.var_afd89f2efad592c0 = "amb_cradled_esc_start_light";
    level.audio.var_b54ae4dd0190953 = "amb_cradled_esc_start_medium";
    level.audio.var_54f6e9544c22dc3 = "amb_cradled_esc_start_heavy";
    level.audio.var_28e1d8d614115774 = "amb_cradled_esc_start_alt_light";
    level.audio.var_a038f5ff6339051f = "amb_cradled_esc_start_alt_medium";
    level.audio.var_29e693dac13da06f = "amb_cradled_esc_start_alt_heavy";
    level.audio.var_5e0449b3fdbff9a8 = "cradle_light_alt";
    level.audio.var_3e9f43df51bb7033 = "cradle_medium_alt";
    level.audio.var_b5beef1704e53383 = "cradle_heavy_alt";
    level.audio.var_8af083e7838b625c = "cradle_light";
    level.audio.var_e505b827fc3bc597 = "cradle_medium";
    level.audio.var_e06681f0753bde67 = "cradle_heavy";
    level.audio.var_38be5817df870224 = "amb_cradled_esc_disorientation_light";
    level.audio.var_f57232e5d6c8a5af = "amb_cradled_esc_disorientation_medium";
    level.audio.var_991f4d40c39291ff = "amb_cradled_esc_disorientation_heavy";
    level.audio.var_da19411ab0035170 = "amb_cradled_disorientation_alt_light";
    level.audio.var_6d8958d6252b262b = "amb_cradled_disorientation_alt_medium";
    level.audio.var_bddca696a16a3dfb = "amb_cradled_disorientation_alt_heavy";
    level utility::flag_wait( "flag_escape_gauntlet_solo_door_burst" );
    level thread namespace_a350a26c6d662a6a::function_e86e3be9023f00c9();
    audio_utility::function_63bf1584c79c055( level.players, "evt_libra_boss_escape_water_hit_plr" );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_libra_player_escape_swim" );
    setglobalsoundcontext( "atmosphere", "underwater" );
    snd::play( "amb_emt_libra_underwater_bubbles_lp", ( -1375, 9012, 2730 ) );
    snd::play( "amb_emt_libra_underwater_bubbles_lp", ( -2067, 7499, 3775 ) );
    utility::flag_wait( "flag_escape_done" );
    setglobalsoundcontext( "atmosphere", "default" );
    audio_utility::function_63bf1584c79c055( level.players, "evt_libra_boss_escape_water_surface" );
}

// Namespace libra_audio
// Params 1
// Checksum 0x11c9c0b1, Offset: 0x6ac4
// Size: 0x25
function function_ab96b19a993a95db( ent )
{
    metal_lp = snd::play( "amb_emt_libra_rotator_lp", ent );
}

// Namespace libra_audio
// Params 1
// Checksum 0x76e39f09, Offset: 0x6af1
// Size: 0x1a
function function_9efda6347b7516e6( cat_origin )
{
    snd::play( "fly_evt_libra_boss_escape_platforms_break", cat_origin );
}

// Namespace libra_audio
// Params 2
// Checksum 0x1bda17c, Offset: 0x6b13
// Size: 0x16f
function function_c0661bf35792b445( entity, var_afc9435033accb48 )
{
    if ( !isdefined( entity ) || !isdefined( var_afc9435033accb48 ) )
    {
        return;
    }
    
    entity endon( #"death" );
    entity endon( #"hash_563d277eb589a1a8" );
    level endon( #"game_ended" );
    entity.is_above_water = undefined;
    entity.var_afc9435033accb48 = var_afc9435033accb48;
    utility::flag_wait( "start_sphere_raise" );
    
    while ( isdefined( entity ) )
    {
        var_6a6e2707cf0b119b = entity.origin[ 2 ];
        var_e71cb9100f2b935e = var_6a6e2707cf0b119b > var_afc9435033accb48;
        
        if ( entity.is_above_water != var_e71cb9100f2b935e )
        {
            entity notify( #"elevation_state_changed" );
            
            if ( var_e71cb9100f2b935e )
            {
                entity thread function_8d5cb27d015f26b2();
            }
            else
            {
                entity thread function_4bcb5cc6bf6fc506();
            }
            
            entity.is_above_water = var_e71cb9100f2b935e;
        }
        
        if ( utility::flag( "lift_complete" ) )
        {
            snd::stop( self.var_d3760acf7c6db823 );
            self.var_d3760acf7c6db823 = undefined;
            entity notify( #"hash_563d277eb589a1a8" );
        }
        else if ( utility::flag( "lift_bottom" ) )
        {
            snd::stop( self.var_7e7ba85123d2e2c7 );
            self.var_7e7ba85123d2e2c7 = undefined;
            level waittill( #"hash_91df1e33a3b24bcb" );
            self.var_7e7ba85123d2e2c7 = snd::play( "amb_reactor_submerged_water_lp", self );
        }
        
        wait 1;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x5f5cade, Offset: 0x6c8a
// Size: 0x75
function function_8d5cb27d015f26b2()
{
    self endon( #"death" );
    self endon( #"elevation_state_changed" );
    self endon( #"hash_563d277eb589a1a8" );
    level endon( #"game_ended" );
    function_3f8fe4248b1601f();
    snd::play( "amb_reactor_emerge_water_start_01", self );
    self.var_d3760acf7c6db823 = snd::play( "amb_reactor_emerge_water_lp", ( 3767, -7399, 730 ) );
    
    while ( true )
    {
        wait 0.2;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0xd0d1ce60, Offset: 0x6d07
// Size: 0x69
function function_4bcb5cc6bf6fc506()
{
    self endon( #"death" );
    self endon( #"elevation_state_changed" );
    self endon( #"hash_563d277eb589a1a8" );
    level endon( #"game_ended" );
    function_3f8fe4248b1601f();
    snd::play( "amb_reactor_submerged_water_start_01", self );
    self.var_7e7ba85123d2e2c7 = snd::play( "amb_reactor_submerged_water_lp", self );
    
    while ( true )
    {
        wait 0.2;
    }
}

// Namespace libra_audio
// Params 0
// Checksum 0x1c93215, Offset: 0x6d78
// Size: 0x76
function function_3f8fe4248b1601f()
{
    if ( isdefined( self.var_d3760acf7c6db823 ) && snd::is_sound_object( self.var_d3760acf7c6db823 ) )
    {
        snd::stop( self.var_d3760acf7c6db823 );
        self.var_d3760acf7c6db823 = undefined;
    }
    
    if ( isdefined( self.var_7e7ba85123d2e2c7 ) && snd::is_sound_object( self.var_7e7ba85123d2e2c7 ) )
    {
        snd::stop( self.var_7e7ba85123d2e2c7 );
        self.var_7e7ba85123d2e2c7 = undefined;
    }
}

// Namespace libra_audio
// Params 1
// Checksum 0x6a333b4d, Offset: 0x6df6
// Size: 0x3e
function function_13be8af648b36ac7( entity )
{
    if ( isdefined( entity ) )
    {
        entity notify( #"hash_563d277eb589a1a8" );
        entity function_3f8fe4248b1601f();
        entity.is_above_water = undefined;
        entity.var_afc9435033accb48 = undefined;
    }
}

// Namespace libra_audio
// Params 2
// Checksum 0x4005dad7, Offset: 0x6e3c
// Size: 0x36
function function_249f993fca6018ef( entity, var_afc9435033accb48 )
{
    if ( !isdefined( entity ) || !isdefined( var_afc9435033accb48 ) )
    {
        return;
    }
    
    return entity.origin[ 2 ] > var_afc9435033accb48;
}

// Namespace libra_audio
// Params 1
// Checksum 0x7e077f63, Offset: 0x6e7b
// Size: 0x22
function function_62b52dd1ba94cc46( entity )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    return entity.origin[ 2 ];
}

// Namespace libra_audio
// Params 4
// Checksum 0xef1a1eb1, Offset: 0x6ea6
// Size: 0xb2
function play_alarm( soundalias, interval, origin, notifyname )
{
    if ( !isdefined( soundalias ) || !isdefined( interval ) || !isdefined( origin ) || !isdefined( notifyname ) )
    {
        return;
    }
    
    alarm = spawnstruct();
    alarm.soundalias = soundalias;
    alarm.interval = interval;
    alarm.origin = origin;
    alarm.notifyname = notifyname;
    alarm.isplaying = 1;
    thread function_e4f9ad0087c2288e( alarm, origin );
    thread monitor_alarm_stop( alarm );
    return alarm;
}

// Namespace libra_audio
// Params 2
// Checksum 0x841eab09, Offset: 0x6f61
// Size: 0x66
function function_e4f9ad0087c2288e( alarm, origin )
{
    self endon( #"disconnect" );
    self endon( "stop_alarm_" + alarm.notifyname );
    
    while ( alarm.isplaying )
    {
        snd::play( alarm.soundalias, origin );
        wait alarm.interval;
    }
}

// Namespace libra_audio
// Params 1
// Checksum 0x3e623ade, Offset: 0x6fcf
// Size: 0x9f
function monitor_alarm_stop( alarm )
{
    self endon( #"disconnect" );
    self waittill( alarm.notifyname );
    alarm.isplaying = 0;
    self notify( "stop_alarm_" + alarm.notifyname );
    
    if ( isdefined( self.var_babe2252c9ac2cdc ) )
    {
        for ( i = 0; i < self.var_babe2252c9ac2cdc.size ; i++ )
        {
            if ( self.var_babe2252c9ac2cdc[ i ] == alarm )
            {
                array_remove_index( self.var_babe2252c9ac2cdc, i );
                break;
            }
        }
    }
}

// Namespace libra_audio
// Params 1
// Checksum 0x82caa419, Offset: 0x7076
// Size: 0x40, Type: bool
function stop_alarm( alarm )
{
    if ( isdefined( alarm ) && isdefined( alarm.notifyname ) )
    {
        alarm.isplaying = 0;
        self notify( alarm.notifyname );
        return true;
    }
    
    return false;
}

// Namespace libra_audio
// Params 0
// Checksum 0x951deb3b, Offset: 0x70bf
// Size: 0x8e
function stop_all_alarms()
{
    if ( !isdefined( self.var_babe2252c9ac2cdc ) || self.var_babe2252c9ac2cdc.size == 0 )
    {
        return;
    }
    
    alarms_copy = [];
    
    for ( i = 0; i < self.var_babe2252c9ac2cdc.size ; i++ )
    {
        alarms_copy[ i ] = self.var_babe2252c9ac2cdc[ i ];
    }
    
    for ( i = 0; i < alarms_copy.size ; i++ )
    {
        if ( isdefined( alarms_copy[ i ] ) )
        {
            stop_alarm( alarms_copy[ i ] );
        }
    }
    
    self.var_babe2252c9ac2cdc = [];
}

// Namespace libra_audio
// Params 2
// Checksum 0xec6d6f42, Offset: 0x7155
// Size: 0x73
function array_remove_index( array, index )
{
    for ( i = index; i < array.size - 1 ; i++ )
    {
        array[ i ] = array[ i + 1 ];
    }
    
    array[ array.size - 1 ] = undefined;
    newarray = [];
    
    for ( i = 0; i < array.size - 1 ; i++ )
    {
        newarray[ i ] = array[ i ];
    }
    
    return newarray;
}

