// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_move.gsc  (hash_6f66d4820ddf84f2.gscc) (size: 6705 Bytes / 0x1a31 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x81de2a (8511018)
// size ...... 6705 (0x1a31)
// includes .. 6   (offset: 0x195d)
// strings ... 7   (offset: 0x198d)
// dev strs .. 4   (offset: 0x19fd)
// exports ... 15  (offset: 0x1031)
// cseg ...... 0xb7 + 0xf7a (0x1031)
// imports ... 54  (offset: 0x1289)
// animtree1 . 0   (offset: 0x1a31)
// animtree2 . 0   (offset: 0x1a31)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\debug;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_phobos_move;

// Namespace zombie_phobos_move
// Params 0
// Checksum 0x419190e9, Offset: 0xd5
// Size: 0x2
function function_d09624bb6e4f4dc1()
{
    
}

// Namespace zombie_phobos_move
// Params 0
// Checksum 0x60b90d7f, Offset: 0xdf
// Size: 0x17
function init_zombie_phobos_move()
{
    self function_6e8526b0ec373745( 0.01 );
    self.var_20fe9732aaa214e7 = 0;
}

// Namespace zombie_phobos_move
// Params 2
// Checksum 0xf463041e, Offset: 0xfe
// Size: 0x2b4
function function_c2c4bced26d97b81( taskid, params )
{
    ent = self.enemy;
    
    if ( !isdefined( ent ) )
    {
        return anim.failure;
    }
    
    if ( self getaiblackboarddynamic( "in_turning" ) == 1 )
    {
        function_d5c151b49d95b388( self );
        return anim.success;
    }
    
    if ( self getaiblackboarddynamic( "in_exit" ) == 1 )
    {
        function_d5c151b49d95b388( self );
        return anim.success;
    }
    
    closest_point = getclosestpointonnavmesh( ent.origin, self, 1, 1, 1 );
    in_moving_melee = utility::ent_flag( "in_melee" ) && length( self getvelocity() ) > 50;
    is_locked = gettime() < self.var_78b6211d7b7bb6dd;
    
    if ( !isdefined( closest_point ) || is_locked )
    {
        /#
            if ( debug_move() )
            {
                print3d( self.origin + ( 0, 0, 200 ), "<dev string:x24>" + is_locked, ( 1, 0, 0 ) );
            }
        #/
        
        patrol_pos = function_c6861d04ef1fe32c();
        
        if ( patrol_pos )
        {
            zombie_utils::update_bt_goal( patrol_pos );
            self.var_2888d9b4e47619e8 = 0;
            return anim.success;
        }
        
        if ( self.var_c78b2c94679211a5 && closest_point )
        {
            function_c88616ad077175ae( closest_point );
        }
        
        return anim.success;
    }
    
    goal_pos = closest_point;
    is_moving_to_target = 1;
    var_d92579af7406e9d0 = 1;
    
    if ( self pathdisttogoal() <= 0 )
    {
        /#
            if ( debug_move() )
            {
                print3d( closest_point + ( 0, 0, 200 ), "<dev string:x54>", ( 1, 0, 0 ) );
            }
        #/
        
        patrol_pos = function_c6861d04ef1fe32c();
        
        if ( patrol_pos )
        {
            zombie_utils::update_bt_goal( patrol_pos );
            self.var_2888d9b4e47619e8 = 0;
            self.var_78b6211d7b7bb6dd = gettime() + getdvarfloat( @"hash_678c0d52eff7bc57", 4000 );
            return anim.success;
        }
        
        if ( self.var_c78b2c94679211a5 )
        {
            function_c88616ad077175ae( closest_point );
        }
        
        return anim.success;
    }
    
    var_fa862a030a664309 = gettime() - ( self.var_20fe9732aaa214e7 ?? 0 );
    var_e589b76473e747d = var_fa862a030a664309 > 0 && var_fa862a030a664309 <= utility::function_4b74c15943231980( level.framedurationseconds );
    
    if ( is_moving_to_target )
    {
        function_d5c151b49d95b388( self );
    }
    
    if ( var_e589b76473e747d )
    {
        zombie_utils::update_bt_goal( goal_pos );
        self.var_2888d9b4e47619e8 = is_moving_to_target;
    }
    
    return anim.success;
}

// Namespace zombie_phobos_move
// Params 2
// Checksum 0x858519cb, Offset: 0x3bb
// Size: 0xb5
function function_a57981c69bfa759( taskid, params )
{
    if ( getdvarfloat( @"hash_e74f909185bbd81", 0 ) > 0 )
    {
        return anim.success;
    }
    
    if ( self getaiblackboarddynamic( "in_turning" ) == 1 )
    {
        function_d5c151b49d95b388( self );
        return anim.success;
    }
    
    if ( self getaiblackboarddynamic( "in_exit" ) == 1 )
    {
        function_d5c151b49d95b388( self );
        return anim.success;
    }
    
    patrol_pos = function_c6861d04ef1fe32c();
    
    if ( !isdefined( patrol_pos ) )
    {
        return anim.success;
    }
    
    zombie_utils::update_bt_goal( patrol_pos );
    self.var_2888d9b4e47619e8 = 0;
    return anim.success;
}

// Namespace zombie_phobos_move
// Params 2
// Checksum 0x543fa465, Offset: 0x479
// Size: 0xc5
function function_ddfde6bc631d822f( taskid, params )
{
    if ( has_space_to_die() )
    {
        utility::delaycall( level.framedurationseconds, &kill );
        return anim.success;
    }
    
    patrol_pos = function_c6861d04ef1fe32c();
    
    if ( !isdefined( patrol_pos ) )
    {
        if ( self.var_c78b2c94679211a5 )
        {
            fallback_pos = function_73b7589923db3b15();
            
            if ( fallback_pos )
            {
                if ( self getgoalpos( 3 ) != fallback_pos )
                {
                    self clearpath();
                }
                
                zombie_utils::update_bt_goal( fallback_pos, 2 );
                self.var_2888d9b4e47619e8 = 0;
            }
        }
        
        return anim.running;
    }
    
    zombie_utils::update_bt_goal( patrol_pos, 2 );
    self.var_2888d9b4e47619e8 = 0;
    return anim.running;
}

// Namespace zombie_phobos_move
// Params 1, eflags: 0x4
// Checksum 0xeb1d19b, Offset: 0x547
// Size: 0x28
function private function_c88616ad077175ae( goal_pos )
{
    function_d5c151b49d95b388( self );
    zombie_utils::update_bt_goal( goal_pos );
    self.var_2888d9b4e47619e8 = 1;
}

// Namespace zombie_phobos_move
// Params 0, eflags: 0x4
// Checksum 0x76bcd3e8, Offset: 0x577
// Size: 0x79
function private function_73b7589923db3b15()
{
    var_9c62c0d8300515ca = 150;
    var_190843641fc38b2a = squared( 32 );
    fallback_origin = self.origin - anglestoforward( self.angles ) * var_9c62c0d8300515ca;
    fallback_pos = getclosestpointonnavmesh( fallback_origin, self, 0, 1, 1 );
    
    if ( !fallback_pos || distancesquared( fallback_pos, self.origin ) <= var_190843641fc38b2a )
    {
        return;
    }
    
    return fallback_pos;
}

// Namespace zombie_phobos_move
// Params 0, eflags: 0x4
// Checksum 0xef9f9e42, Offset: 0x5f9
// Size: 0x3b3, Type: bool
function private has_space_to_die()
{
    if ( zombie_leap_attack::is_in_leap_attack() )
    {
        return false;
    }
    
    forward_dist = 525;
    ground_center = self.origin + anglestoforward( self.angles ) * forward_dist;
    nav_trace = navtrace( self.origin, ground_center, undefined, 1 );
    hit_wall = nav_trace[ "fraction" ] < 1;
    
    /#
        if ( debug_move() )
        {
            col = hit_wall ? ( 1, 0, 0 ) : ( 0, 1, 0 );
            line( self.origin, nav_trace[ "<dev string:x76>" ], col, 1, 1 );
            sphere( ground_center, 10, col, 1 );
        }
    #/
    
    if ( hit_wall )
    {
        return false;
    }
    
    sign = -1;
    
    while ( sign < 2 )
    {
        var_8af5d7ba4e668781 = anglestoright( self.angles ) * sign * 75;
        nav_trace = navtrace( self.origin, ground_center + var_8af5d7ba4e668781, undefined, 1 );
        hit_wall = nav_trace[ "fraction" ] < 1;
        
        /#
            if ( debug_move() )
            {
                col = hit_wall ? ( 1, 0, 0 ) : ( 0, 1, 0 );
                line( self.origin, nav_trace[ "<dev string:x76>" ], col, 1, 1 );
                sphere( ground_center, 10, col, 1 );
            }
        #/
        
        if ( hit_wall )
        {
            return false;
        }
        
        sign += 2;
    }
    
    centroid = self getcentroid();
    trace_width = 200;
    var_218c45f7e69d3dae = ( ground_center[ 0 ], ground_center[ 1 ], centroid[ 2 ] ) - anglestoright( self.angles ) * trace_width;
    trace_end = var_218c45f7e69d3dae + anglestoright( self.angles ) * trace_width * 2;
    trace = trace::ray_trace( var_218c45f7e69d3dae, trace_end, self );
    var_e3413ffc094b80d9 = trace[ "fraction" ] < 1;
    
    /#
        if ( debug_move() )
        {
            col = var_e3413ffc094b80d9 ? ( 1, 0, 0 ) : ( 0, 1, 0 );
            line( var_218c45f7e69d3dae, trace_end, col, 1, 1 );
        }
    #/
    
    if ( var_e3413ffc094b80d9 )
    {
        return false;
    }
    
    back_offset = anglestoforward( self.angles ) * -0.5 * forward_dist;
    try_i = 1;
    
    while ( try_i <= 1 )
    {
        var_218c45f7e69d3dae += back_offset;
        trace_end += back_offset;
        trace = trace::ray_trace( var_218c45f7e69d3dae, trace_end, self );
        var_e3413ffc094b80d9 = trace[ "fraction" ] < 1;
        
        /#
            if ( debug_move() )
            {
                col = var_e3413ffc094b80d9 ? ( 1, 0, 0 ) : ( 0, 1, 0 );
                line( var_218c45f7e69d3dae, trace_end, col, 1, 1 );
            }
        #/
        
        if ( var_e3413ffc094b80d9 )
        {
            return false;
        }
        
        try_i += 1;
    }
    
    if ( self.var_2700f357dda9c693 )
    {
        params = {};
        params.ground_center = ground_center;
        
        foreach ( override_func in self.var_2700f357dda9c693 )
        {
            if ( ![[ override_func ]]( params ) )
            {
                return false;
            }
        }
    }
    
    utility::ent_flag_set( "space_to_die" );
    return true;
}

// Namespace zombie_phobos_move
// Params 1, eflags: 0x4
// Checksum 0x8ebee2da, Offset: 0x9b5
// Size: 0x15
function private cleanup_obstacle( obstacle )
{
    waitframe();
    waitframe();
    destroynavobstacle( obstacle );
}

// Namespace zombie_phobos_move
// Params 1, eflags: 0x4
// Checksum 0xd36deb79, Offset: 0x9d2
// Size: 0x168
function private function_d5c151b49d95b388( phobos )
{
    if ( function_1f629770169d9422( phobos ) )
    {
        back_dist = getdvarfloat( @"hash_37bb049231a702d4", 150 );
        
        if ( isdefined( phobos.var_f9a759bcc48cca8f ) && gettime() - phobos.var_f9a759bcc48cca8f < 1000 || phobos pathdisttogoal() <= 0 && !utility::time_has_passed( phobos.var_20fe9732aaa214e7, 1 ) )
        {
            back_dist *= 6;
        }
        
        obstacle_angles = phobos.angles;
        path = phobos getpath();
        
        if ( phobos pathdisttogoal() > 0 )
        {
            obstacle_angles = phobos.angles;
            phobos.var_20fe9732aaa214e7 = gettime();
        }
        
        obstacle_midpoint = phobos.origin - anglestoforward( phobos.angles ) * back_dist;
        obstacle_halfsize = ( 5, getdvarfloat( @"hash_fe264d701219989a", 200 ), 300 );
        obstacle = function_c7ae01968233ffce( "zombie_xlarge_wide", obstacle_midpoint, obstacle_halfsize, obstacle_angles );
        thread cleanup_obstacle( obstacle );
        
        /#
            if ( debug_move() )
            {
                debug::function_76204bee46fa39fd( obstacle_midpoint, obstacle_halfsize, obstacle_angles, level.framedurationseconds * 2, ( 1, 0, 0.2 ) );
            }
        #/
    }
}

// Namespace zombie_phobos_move
// Params 1, eflags: 0x4
// Checksum 0xbdd81163, Offset: 0xb42
// Size: 0x20, Type: bool
function private function_1f629770169d9422( phobos )
{
    return true;
}

// Namespace zombie_phobos_move
// Params 0, eflags: 0x4
// Checksum 0xde79c1a9, Offset: 0xc20
// Size: 0xa3
function private function_c6861d04ef1fe32c()
{
    self.var_c78b2c94679211a5 = 0;
    goal_pos = self getgoalpos();
    recalculate_dist = asm_bb::bb_movetyperequested( "walk" ) ? 300 : 600;
    recalculate_dist = getdvarfloat( @"hash_b69abc5c1d5c1ef0", recalculate_dist );
    
    if ( isdefined( goal_pos ) && self pathdisttogoal() > recalculate_dist && !self.var_2888d9b4e47619e8 )
    {
        return;
    }
    
    goal_pos = function_290f8c14dbc57398( self );
    
    if ( goal_pos == self.origin )
    {
        self.var_f9a759bcc48cca8f = gettime();
        self.var_c78b2c94679211a5 = 1;
        return;
    }
    
    return goal_pos;
}

// Namespace zombie_phobos_move
// Params 2
// Checksum 0x3c6a07d2, Offset: 0xccc
// Size: 0x346
function function_290f8c14dbc57398( ai_entity, var_cfb5dc6e8df2500f = asm_bb::bb_movetyperequested( "walk" ) ? 600 : 800 )
{
    var_cfb5dc6e8df2500f = getdvarfloat( @"hash_7c49b759744546f1", var_cfb5dc6e8df2500f );
    top_x = getdvarfloat( @"hash_e5622d9e52d8a458", 5 );
    max_bounces = getdvarfloat( @"hash_d54ca0a72c4fd9ed", 1 );
    var_e6ef1231966449aa = ai_entity.origin;
    base_angles = ai_entity.angles;
    forward_dir = anglestoforward( base_angles );
    
    for ( b = 0; b < max_bounces ; b++ )
    {
        trace_results = [];
        
        for ( i = 0; i < 8 ; i++ )
        {
            if ( i == 3 || i == 5 )
            {
                trace_results[ i ] = [ var_e6ef1231966449aa, -999999, -999999 ];
                continue;
            }
            
            test_yaw = base_angles[ 1 ] + i * 45;
            test_angles = ( base_angles[ 0 ], test_yaw, base_angles[ 2 ] );
            check_dir = anglestoforward( test_angles );
            check_end = var_e6ef1231966449aa + check_dir * var_cfb5dc6e8df2500f;
            nav_end = getclosestpointonnavmesh( check_end, ai_entity, 1, 1, 0, 0 );
            
            if ( !isdefined( nav_end ) || distance( nav_end, var_e6ef1231966449aa ) < 200 )
            {
                trace_results[ i ] = [ var_e6ef1231966449aa, -999999, -999999 ];
                continue;
            }
            
            distance_val = distance( var_e6ef1231966449aa, nav_end );
            dot_val = vectordot( forward_dir, check_dir );
            
            /#
                if ( debug_move() )
                {
                    line( var_e6ef1231966449aa, nav_end, ( 0.9, 0.1, 0 ) );
                }
            #/
            
            trace_results[ i ] = [ nav_end, distance_val, dot_val ];
        }
        
        for ( j = 0; j < trace_results.size ; j++ )
        {
            for ( k = j + 1; k < trace_results.size ; k++ )
            {
                if ( trace_results[ k ][ 1 ] > trace_results[ j ][ 1 ] )
                {
                    temp = trace_results[ j ];
                    trace_results[ j ] = trace_results[ k ];
                    trace_results[ k ] = temp;
                }
            }
        }
        
        best_position = var_e6ef1231966449aa;
        found_valid = 0;
        max_candidates = min( top_x, trace_results.size );
        
        while ( !found_valid )
        {
            var_e3eab751eefd3bd0 = -999999;
            best_dot_index = -1;
            
            for ( m = 0; m < max_candidates ; m++ )
            {
                dot_val = trace_results[ m ][ 2 ];
                
                if ( dot_val > var_e3eab751eefd3bd0 )
                {
                    var_e3eab751eefd3bd0 = dot_val;
                    best_dot_index = m;
                }
            }
            
            if ( best_dot_index <= -1 )
            {
                break;
            }
            
            var_35b8f54c259f8b32 = trace_results[ best_dot_index ][ 0 ];
            best_position = var_35b8f54c259f8b32;
            found_valid = 1;
        }
        
        if ( !found_valid || best_position == var_e6ef1231966449aa )
        {
            break;
        }
        
        var_e6ef1231966449aa = best_position;
    }
    
    /#
        sphere( var_e6ef1231966449aa, 10, ( 0, 1, 0 ) );
    #/
    
    return var_e6ef1231966449aa;
}

/#

    // Namespace zombie_phobos_move
    // Params 0, eflags: 0x4
    // Checksum 0x31915ab1, Offset: 0x101b
    // Size: 0x16, Type: dev
    function private debug_move()
    {
        return getdvarint( @"hash_682b6127a16b673", 0 ) > 0;
    }

#/
