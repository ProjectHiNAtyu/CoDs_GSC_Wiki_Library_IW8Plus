// scripts\mp\zm\systems\zm_powerups.gsc  (hash_7f65cb103884da72.gscc) (size: 8240 Bytes / 0x2030 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c90fa11 (2358311441)
// size ...... 8240 (0x2030)
// includes .. 11  (offset: 0x1ee8)
// strings ... 13  (offset: 0x1f40)
// dev strs .. 3   (offset: 0x200c)
// exports ... 19  (offset: 0x140c)
// cseg ...... 0x187 + 0x1285 (0x140c)
// imports ... 67  (offset: 0x1704)
// animtree1 . 0   (offset: 0x2030)
// animtree2 . 0   (offset: 0x2030)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\powerups\nuke;
#using scripts\mp\common\powerups\powerups;
#using scripts\mp\zm\points;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_powerups;

// Namespace zm_powerups
// Params 0
// Checksum 0x5d3e1f85, Offset: 0x1a5
// Size: 0x15f
function init_zm_powerups()
{
    utility::flag_wait( "system_preinit_complete" );
    powerups_cpmp::init( &points::zm_give_points, &points::set_point_scalar );
    level callback::add( "on_round_ai_spawn_started", &on_round_ai_spawn_started );
    level callback::add( "on_round_last_ai_killed", &on_round_last_ai_killed );
    nuke::function_da3f6806a9d04f42( &function_1dee1a08fb35468 );
    powerups::register_powerup_dropped_callback( &function_ac8b95bb5965f259 );
    root = powerups::get_powerups_root();
    root.var_702fcdb304535fd8 = &function_b47aa97d79fac275;
    root.var_fda058ab47aeb2c0 = &function_61afae3fc98be476;
    root.var_7e48fc8856716bef = &get_player_team_members;
    init_powerups_var();
    bundle = powerups::get_bundle_list();
    level.powerups_root.powerup_droprate = bundle.var_3a8d076dd0f5523c;
    level.powerups_root.falloff_start = bundle.var_1751d29d964aeb90;
    level.powerups_root.falloff_rate = bundle.var_bf2f6ec9827a6fe2;
    level.powerups_root.drop_chance_min = bundle.var_196a3232e1846400;
    level.powerups_root.var_eb0306fb78be6de2 = bundle.var_eb0306fb78be6de2;
    level utility::flag_set( "zm_powerups_init_done" );
}

// Namespace zm_powerups
// Params 0, eflags: 0x4
// Checksum 0xb1637b1d, Offset: 0x30c
// Size: 0x1e
function private init_powerups_var()
{
    powerups::set_powerup_var( "powerup_drop_max_per_round", powerups::get_bundle_list().drop_max_per_round );
}

// Namespace zm_powerups
// Params 1, eflags: 0x4
// Checksum 0x15a49d7f, Offset: 0x332
// Size: 0xce
function private on_round_ai_spawn_started( params )
{
    if ( isdefined( params.roundendrewardlist ) )
    {
        foreach ( rer in params.roundendrewardlist )
        {
            switch ( rer.rewardtype )
            {
                case #"hash_f2ed8a54cbe19f9b":
                    powerups::function_b3ef1ccbc3c4bbbb( 0 );
                    break;
                default:
                    break;
            }
        }
    }
    
    set_current_round_drop_count( 0 );
}

// Namespace zm_powerups
// Params 1, eflags: 0x4
// Checksum 0x5e4079d3, Offset: 0x408
// Size: 0x10b
function private on_round_last_ai_killed( params )
{
    if ( !isdefined( params.roundendrewardlist ) || level.zm_mode_modifiers.var_a56fc07f056a7549 )
    {
        return;
    }
    
    foreach ( rer in params.roundendrewardlist )
    {
        switch ( rer.rewardtype )
        {
            case #"hash_f2ed8a54cbe19f9b":
                level thread function_ca94ff5e7e47739( rer.rewardref, params.ai, params.attacker, params.var_664fc2b93d674b62 );
                break;
            default:
                break;
        }
    }
}

// Namespace zm_powerups
// Params 4, eflags: 0x4
// Checksum 0xdb50511f, Offset: 0x51b
// Size: 0x506
function private function_ca94ff5e7e47739( powerup_ref, last_ai, attacker, var_f54a75d1f8e8c15c )
{
    level endon( #"game_ended" );
    var_21c3b67f1a74cd8e = var_f54a75d1f8e8c15c ?? undefined;
    ai_ground_origin = last_ai.var_5e0be30a5816a64d;
    
    if ( !isdefined( var_21c3b67f1a74cd8e ) )
    {
        if ( last_ai._blackboard.var_397bfb4ed7256a7a )
        {
            var_1cd42b467bcdb140 = 600;
            var_288fe9115b5c78a3 = 0.99;
            tracestartpoint = ai_ground_origin;
            upvec = anglestoup( last_ai.angles );
            var_f644e34742f74a80 = ( 0, 0, -1 );
            
            if ( vectordot( upvec, var_f644e34742f74a80 ) <= var_288fe9115b5c78a3 )
            {
                var_431cdd75f367342b = 25;
                tracestartpoint += var_431cdd75f367342b * upvec;
            }
            
            traceendpoint = tracestartpoint + var_1cd42b467bcdb140 * var_f644e34742f74a80;
            var_ea45101bd908ef3d = physics_raycast( tracestartpoint, traceendpoint, trace::create_world_contents(), [], 0, "physicsquery_closest" );
            
            if ( isdefined( var_ea45101bd908ef3d[ 0 ][ "position" ] ) )
            {
                var_21c3b67f1a74cd8e = var_ea45101bd908ef3d[ 0 ][ "position" ];
            }
            
            if ( !isdefined( var_21c3b67f1a74cd8e ) )
            {
                var_acaf412df6146f78 = 80;
                var_308e3f214dd03bad = anglestoforward( attacker.angles );
                nav_trace_start = getclosestpointonnavmesh( attacker.origin );
                nav_trace_end = nav_trace_start + var_308e3f214dd03bad * var_acaf412df6146f78;
                nav_trace_result = navtrace( nav_trace_start, nav_trace_end, last_ai, 1 );
                var_21c3b67f1a74cd8e = nav_trace_result[ "position" ];
            }
        }
        else if ( isdefined( last_ai ) )
        {
            foreach ( zone_struct in level.zone_manager.inited_defs )
            {
                navmesh_zone = zone_manager::function_ac62281be3d43322( ai_ground_origin );
                
                if ( navmesh_zone == zone_struct.zone_name )
                {
                    var_21c3b67f1a74cd8e = ai_ground_origin;
                    break;
                }
            }
            
            killedbyplayer = isdefined( attacker.origin ) && attacker.origin != ( 0, 0, 0 );
            
            if ( !isdefined( var_21c3b67f1a74cd8e ) )
            {
                var_28343eb233cd40f = last_ai getpath();
                
                if ( !isdefined( var_28343eb233cd40f ) && killedbyplayer )
                {
                    var_62ba1c66e7827a78 = getclosestpointonnavmesh( ai_ground_origin );
                    var_28343eb233cd40f = last_ai findpath( var_62ba1c66e7827a78, attacker.origin );
                }
                
                if ( isdefined( var_28343eb233cd40f ) )
                {
                    foreach ( point in var_28343eb233cd40f )
                    {
                        foreach ( zone_struct in level.zone_manager.inited_defs )
                        {
                            navmesh_zone = zone_manager::function_ac62281be3d43322( point );
                            
                            if ( navmesh_zone == zone_struct.zone_name )
                            {
                                var_21c3b67f1a74cd8e = point;
                                break;
                            }
                        }
                        
                        if ( isdefined( var_21c3b67f1a74cd8e ) )
                        {
                            break;
                        }
                    }
                }
            }
            
            if ( !isdefined( var_21c3b67f1a74cd8e ) )
            {
                if ( killedbyplayer )
                {
                    var_21c3b67f1a74cd8e = getclosestpointonnavmesh( ai_ground_origin );
                }
                else if ( isdefined( level.players[ 0 ] ) )
                {
                    level.players[ 0 ] function_c387dec4aca29a14();
                    var_27317a5528a81d9b = 100;
                    
                    if ( isdefined( level.players[ 0 ] ) )
                    {
                        var_21c3b67f1a74cd8e = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * var_27317a5528a81d9b;
                    }
                }
            }
        }
    }
    
    if ( isdefined( var_21c3b67f1a74cd8e ) )
    {
        if ( isdefined( last_ai ) && last_ai zombie_vehicle_attack::is_in_vehicle_attack() )
        {
            var_57b6925b3b3843bc = squared( 150 );
            var_df6fa663feac5e3f = 80;
            var_21c3b67f1a74cd8e += anglestoforward( last_ai.angles ) * -1 * var_df6fa663feac5e3f;
        }
        else
        {
            var_57b6925b3b3843bc = squared( 75 );
        }
        
        ground_origin = utility::drop_to_ground( var_21c3b67f1a74cd8e, 30, -200 );
        
        if ( distancesquared( ground_origin, var_21c3b67f1a74cd8e ) >= var_57b6925b3b3843bc )
        {
            var_21c3b67f1a74cd8e = ground_origin;
        }
        
        powerups::force_powerup_drop( powerup_ref, var_21c3b67f1a74cd8e, "drop" );
        waitframe();
        powerups::function_b3ef1ccbc3c4bbbb( 1 );
    }
}

// Namespace zm_powerups
// Params 0
// Checksum 0xef93ea04, Offset: 0xa29
// Size: 0x49
function function_c387dec4aca29a14()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        zone_name = zone_manager::function_ac62281be3d43322( self.origin );
        
        if ( isdefined( zone_name ) )
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace zm_powerups
// Params 1, eflags: 0x4
// Checksum 0xfc6fa237, Offset: 0xa7a
// Size: 0x39
function private function_1dee1a08fb35468( is_nuke_on )
{
    if ( is_nuke_on && nuke::function_793f52c28e9c0afd() )
    {
        zm_round_spawning::pause_round_spawning( 1, "powerup_nuke_pause_spawning" );
        return;
    }
    
    zm_round_spawning::pause_round_spawning( 0, "powerup_nuke_pause_spawning" );
}

// Namespace zm_powerups
// Params 0, eflags: 0x4
// Checksum 0x1915a4b4, Offset: 0xabb
// Size: 0xf4
function private get_player_team_members()
{
    var_f12d271fff81f3c5 = [];
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) && self.team == player.team )
        {
            can_affect = 1;
            
            if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
            {
                can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
            }
            
            if ( can_affect )
            {
                var_f12d271fff81f3c5[ var_f12d271fff81f3c5.size ] = player;
            }
        }
    }
    
    return var_f12d271fff81f3c5;
}

// Namespace zm_powerups
// Params 1, eflags: 0x4
// Checksum 0x5dcad8d1, Offset: 0xbb8
// Size: 0x32
function private function_ac8b95bb5965f259( powerup )
{
    current_drop_count = get_current_round_drop_count();
    
    if ( !isdefined( current_drop_count ) )
    {
        return;
    }
    
    set_current_round_drop_count( current_drop_count + 1 );
}

// Namespace zm_powerups
// Params 1
// Checksum 0xede57255, Offset: 0xbf2
// Size: 0x2c
function set_current_round_drop_count( n_count )
{
    root = powerups::get_powerups_root();
    root.n_round_drop_count = n_count;
}

// Namespace zm_powerups
// Params 0, eflags: 0x4
// Checksum 0xba933519, Offset: 0xc26
// Size: 0x30
function private get_current_round_drop_count()
{
    root = powerups::get_powerups_root();
    
    if ( !isdefined( root.n_round_drop_count ) )
    {
        return;
    }
    
    return root.n_round_drop_count;
}

// Namespace zm_powerups
// Params 1, eflags: 0x4
// Checksum 0x2a672b47, Offset: 0xc5f
// Size: 0x33d
function private function_b47aa97d79fac275( params )
{
    assert( self == level );
    var_1c003c2d27a6ca98 = function_50fe6394383606f0( params );
    
    if ( !powerups_cpmp::can_drop_powerup( params ) )
    {
        return 0;
    }
    
    if ( level.zm_mode_modifiers.var_a56fc07f056a7549 )
    {
        return var_1c003c2d27a6ca98;
    }
    
    if ( isdefined( get_current_round_drop_count() ) && get_current_round_drop_count() >= powerups::get_powerup_var( "powerup_drop_max_per_round" ) && !var_1c003c2d27a6ca98 && !var_1c003c2d27a6ca98 )
    {
        return 0;
    }
    
    player = params.eattacker;
    
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    if ( level.powerups_root.var_eb0306fb78be6de2 )
    {
        var_a13bed1ac47e1b2c = params.var_ff1fcfacc6a3651d.var_a13bed1ac47e1b2c;
        droprate = level.powerups_root.powerup_droprate;
        currentround = zm_round_logic::get_rb_round_number();
        
        if ( currentround > level.powerups_root.falloff_start )
        {
            var_a264a50e7f695684 = currentround - level.powerups_root.falloff_start;
            var_8401141f3d2fc36f = var_a264a50e7f695684 * level.powerups_root.falloff_rate;
            droprate = max( droprate - var_8401141f3d2fc36f, level.powerups_root.drop_chance_min );
        }
        
        f_random = randomfloat( 1 );
        var_6b823e4600bbbedf = droprate >= f_random;
        
        if ( !var_6b823e4600bbbedf && !var_a13bed1ac47e1b2c && var_1c003c2d27a6ca98 )
        {
            return 1;
        }
        
        if ( !isdefined( level.powerups_root.var_75b2a0f7a5e43011 ) )
        {
            level.powerups_root.var_75b2a0f7a5e43011 = 0;
        }
        
        if ( var_6b823e4600bbbedf && level.powerups_root.var_75b2a0f7a5e43011 + utility::function_4b74c15943231980( 2 ) < gettime() )
        {
            level.powerups_root.var_75b2a0f7a5e43011 = gettime();
            return var_6b823e4600bbbedf;
        }
        
        return var_6b823e4600bbbedf;
    }
    
    root = powerups::get_powerups_root();
    players = player get_player_team_members();
    
    if ( !isdefined( root.var_cf6a4eb637767dc8 ) )
    {
        root.var_cf6a4eb637767dc8 = 0;
        root.var_9b8b6b7f3726d294 = player function_9bb0ae36d394784b( players.size );
    }
    
    root.var_cf6a4eb637767dc8++;
    var_6b823e4600bbbedf = isdefined( level.var_3dcd842934704d44 ) && !params.etarget.var_a13bed1ac47e1b2c || root.var_cf6a4eb637767dc8 >= root.var_9b8b6b7f3726d294;
    
    if ( var_6b823e4600bbbedf )
    {
        if ( root.var_cf6a4eb637767dc8 >= root.var_9b8b6b7f3726d294 )
        {
            function_8d76196d518e9db7();
            root.var_cf6a4eb637767dc8 = 0;
            root.var_9b8b6b7f3726d294 = player function_9bb0ae36d394784b( players.size );
        }
    }
    else if ( !params.etarget.var_a13bed1ac47e1b2c && var_1c003c2d27a6ca98 )
    {
        return 1;
    }
    
    return var_6b823e4600bbbedf;
}

// Namespace zm_powerups
// Params 1
// Checksum 0x1ddde7d5, Offset: 0xfa4
// Size: 0x3f
function function_fb99058524336897( var_ebda770a8165cfce )
{
    if ( !isdefined( level.var_1db3142b2dbcd1a9 ) )
    {
        level.var_1db3142b2dbcd1a9 = [];
    }
    
    level.var_1db3142b2dbcd1a9 = arraycombineunique( level.var_1db3142b2dbcd1a9, [ var_ebda770a8165cfce ] );
}

// Namespace zm_powerups
// Params 1, eflags: 0x4
// Checksum 0xa8365b9e, Offset: 0xfeb
// Size: 0xb3
function private function_50fe6394383606f0( params )
{
    if ( isplayer( params.eattacker ) && isdefined( level.var_1db3142b2dbcd1a9 ) )
    {
        foreach ( func in level.var_1db3142b2dbcd1a9 )
        {
            var_d5bf8c681388b1f4 = [[ func ]]( params );
            
            if ( var_d5bf8c681388b1f4 )
            {
                return var_d5bf8c681388b1f4;
            }
        }
    }
}

// Namespace zm_powerups
// Params 1, eflags: 0x4
// Checksum 0xe93c1f21, Offset: 0x10a7
// Size: 0x3f, Type: bool
function private function_61afae3fc98be476( params )
{
    if ( isai( self ) && ( self.var_48960fedb514aedd || self.var_a13bed1ac47e1b2c || self.b_in_spawn_closet ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_powerups
// Params 0, eflags: 0x4
// Checksum 0x7a4440d6, Offset: 0x10ef
// Size: 0xfa
function private function_8d76196d518e9db7()
{
    var_6e5c5ae3070308ea = 990;
    var_9ce0657461521a0c = 999;
    drop_event_ranges = powerups::get_powerup_var( "drop_event_ranges" );
    
    foreach ( var_11569b3c8558cea9 in drop_event_ranges )
    {
        var_11569b3c8558cea9.n_min = min( var_6e5c5ae3070308ea, var_11569b3c8558cea9.n_min + var_11569b3c8558cea9.var_45162660329a9117 );
        var_11569b3c8558cea9.n_max = min( var_9ce0657461521a0c, var_11569b3c8558cea9.n_max + var_11569b3c8558cea9.var_45162660329a9117 );
    }
    
    powerups::set_powerup_var( "drop_event_ranges", drop_event_ranges );
}

// Namespace zm_powerups
// Params 1, eflags: 0x4
// Checksum 0xd57914b, Offset: 0x11f1
// Size: 0xa0
function private function_9bb0ae36d394784b( n_players )
{
    range = function_c53c229a55131535( n_players );
    var_9b8b6b7f3726d294 = undefined;
    
    if ( range[ "max" ] != 0 || range[ "min" ] != 0 )
    {
        if ( range[ "max" ] > range[ "min" ] )
        {
            var_9b8b6b7f3726d294 = powerups::get_random_number( range[ "min" ], range[ "max" ] );
        }
        else
        {
            root = powerups::get_powerups_root();
            assertmsg( "<dev string:x24>" + root.str_powerup_list_name + "<dev string:x6c>" );
        }
    }
    
    return var_9b8b6b7f3726d294;
}

// Namespace zm_powerups
// Params 1, eflags: 0x4
// Checksum 0x9f92a85f, Offset: 0x129a
// Size: 0x171
function private function_c53c229a55131535( n_players )
{
    drop_event_ranges = powerups::get_powerup_var( "drop_event_ranges" );
    assert( isarray( drop_event_ranges ) && drop_event_ranges.size > 0, "<dev string:x84>" );
    incremental_number = powerups::get_powerup_var( "drop_event_incremental_number_per_player" ) ?? 0;
    closest_player_diff = 999;
    var_ce8f7a9fb0155a1a = 990;
    var_aab995099c6bc79c = 999;
    
    foreach ( var_11569b3c8558cea9 in drop_event_ranges )
    {
        var_67b7ee11dc76cc8f = abs( var_11569b3c8558cea9.n_players - n_players );
        
        if ( var_67b7ee11dc76cc8f < closest_player_diff )
        {
            var_a8bc9f3576bd578 = ( n_players - var_11569b3c8558cea9.n_players ) * incremental_number;
            var_ce8f7a9fb0155a1a = var_11569b3c8558cea9.n_min + var_a8bc9f3576bd578;
            var_aab995099c6bc79c = var_11569b3c8558cea9.n_max + var_a8bc9f3576bd578;
            closest_player_diff = var_67b7ee11dc76cc8f;
        }
    }
    
    range = [];
    range[ "min" ] = int( var_ce8f7a9fb0155a1a );
    range[ "max" ] = int( var_aab995099c6bc79c );
    return range;
}

