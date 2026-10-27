// scripts\common\ai\aitypes\zombie_galileo\zombie_galileo_drone.gsc  (hash_6b0c0eaf8557077f.gscc) (size: 9506 Bytes / 0x2522 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x99ded148 (2581516616)
// size ...... 9506 (0x2522)
// includes .. 9   (offset: 0x23ca)
// strings ... 13  (offset: 0x2412)
// dev strs .. 4   (offset: 0x24f2)
// exports ... 20  (offset: 0x173a)
// cseg ...... 0x123 + 0x1617 (0x173a)
// imports ... 78  (offset: 0x1a5a)
// animtree1 . 0   (offset: 0x2522)
// animtree2 . 0   (offset: 0x2522)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_galileo_drone;

// Namespace zombie_galileo_drone
// Params 2
// Checksum 0x7a81b853, Offset: 0x141
// Size: 0x15
function precache( classname, aitypescriptbundle )
{
    
}

// Namespace zombie_galileo_drone
// Params 1, eflags: 0x4
// Checksum 0xc9943900, Offset: 0x15e
// Size: 0x79
function private function_cfbb84b3d7bc65b8( params )
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    callback::get_template( self.animsetname ) callback::add( #"on_ai_killed", &on_galileo_drone_killed );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    
    /#
        init_galileo_drone_devgui();
    #/
}

// Namespace zombie_galileo_drone
// Params 1
// Checksum 0x35b64c68, Offset: 0x1df
// Size: 0x46
function function_5926091c8773b3bc( params )
{
    if ( isexplosivedamagemod( params.smeansofdeath ) )
    {
        return ( params.idamage * ( 1 - ( self.explosion_damage_reduction ?? 0 ) ) );
    }
    
    return params.idamage;
}

// Namespace zombie_galileo_drone
// Params 1
// Checksum 0x5dac04b1, Offset: 0x22e
// Size: 0x11f
function function_9f018855976702df( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_cfbb84b3d7bc65b8 );
    zombie_utils::function_dfae6a5bd222c586( &function_5926091c8773b3bc );
    self.var_a13bed1ac47e1b2c = 1;
    self.disable_brain_rot = 1;
    self.var_f0ad3eb1431e0b9e = 1;
    self.b_cleanup_no_respawn = 1;
    self.var_825b17c932865df = 1;
    self.var_15598d8e493afe88 = 1;
    self.ignore_enemy_count = 1;
    self.b_disable_annihilate = 1;
    self.var_4ed7db6a0182ca99 = 1;
    self.var_5f1f874776178f2 = 1;
    val::set( "galileo_drone", "ignore_cleanup", 1 );
    val::set( "galileo_drone", "allow_give_point", 0 );
    self.var_eaa1f392a238b64 = 0;
    self.is_moving_on_navmesh = 0;
    self.var_7242c0bd48621253 = 1;
    thread initscriptable();
    thread update_fly();
    self.noragdoll = 1;
    return anim.success;
}

// Namespace zombie_galileo_drone
// Params 0
// Checksum 0x633c237f, Offset: 0x356
// Size: 0x44
function initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    self hide();
    waitframe();
    self show();
    
    if ( self isscriptable() )
    {
        utility::function_32b24db3127bff40( #"base", "base_spawn" );
    }
}

// Namespace zombie_galileo_drone
// Params 1
// Checksum 0xad85ee5b, Offset: 0x3a2
// Size: 0x1d6
function function_806b93de64c789c1( taskid )
{
    if ( self islinked() || !self.var_eaa1f392a238b64 || self.var_21bfaac3993bbd56 )
    {
        if ( self.var_21bfaac3993bbd56 )
        {
            self setbtgoalpos( 3, self.origin );
            return anim.failure;
        }
        
        return anim.success;
    }
    
    if ( isdefined( self.owner ) && isdefined( self.goal_pos ) )
    {
        self.is_moving_on_navmesh = 1;
        
        if ( distancesquared( self.goal_pos, self.owner.origin ) > 40000 )
        {
            goal_pos = get_goal_pos( 1 );
            
            if ( goal_pos )
            {
                self.goal_pos = goal_pos;
            }
        }
        
        adjusted_goal_pos = self.goal_pos;
        
        if ( !self isposreachable( self.goal_pos ) )
        {
            adjusted_goal_pos = self getclosestreachablepointonnavmesh( self.goal_pos );
        }
        
        var_cfe8a18a315c1efb = distance2dsquared( adjusted_goal_pos, self.origin );
        
        if ( var_cfe8a18a315c1efb > 900 )
        {
            /#
                if ( getdvarint( @"hash_f3a8a3e2d104335f", 0 ) )
                {
                    sphere( self.goal_pos, 10, ( 1, 0, 0 ) );
                    sphere( adjusted_goal_pos, 10, ( 1, 0.5, 0 ) );
                    sphere( self.origin, 15, ( 1, 1, 0 ) );
                }
            #/
            
            self setbtgoalpos( 3, adjusted_goal_pos );
            return anim.success;
        }
    }
    
    self setbtgoalpos( 3, self.origin );
    
    if ( self.is_moving_on_navmesh )
    {
        self.is_moving_on_navmesh = 0;
        thread function_76cd4774a9d6317a();
    }
    
    return anim.failure;
}

// Namespace zombie_galileo_drone
// Params 0, eflags: 0xc
// Checksum 0x3ea572e3, Offset: 0x581
// Size: 0x52
function private function_76cd4774a9d6317a()
{
    self notify( #"hash_38b722cd1e00b22f" );
    self endon( #"hash_38b722cd1e00b22f" );
    level endon( #"game_ended" );
    self endon( #"death" );
    function_4b411af10f83c124( get_random_float_height(), 1 );
    self.goal_pos = undefined;
    thread function_51be270b46ad8fc4();
}

// Namespace zombie_galileo_drone
// Params 0, eflags: 0xc
// Checksum 0xc0c3affd, Offset: 0x5db
// Size: 0x27b
function private update_fly()
{
    self notify( #"hash_50ba63c328348251" );
    self endon( #"hash_50ba63c328348251" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.is_moving_on_navmesh || self islinked() || !self.var_7242c0bd48621253 || self.var_21bfaac3993bbd56 )
        {
            waitframe();
            continue;
        }
        
        goal_pos = get_goal_pos();
        
        if ( !isdefined( goal_pos ) )
        {
            waitframe();
            continue;
        }
        
        additional_height = get_random_float_height();
        goal_height = goal_pos[ 2 ] + additional_height;
        goal_pos = ( goal_pos[ 0 ], goal_pos[ 1 ], goal_height );
        
        /#
            if ( getdvarint( @"hash_f3a8a3e2d104335f", 0 ) )
            {
                sphere( goal_pos, 10, ( 1, 1, 1 ), 0, 2 );
                sphere( self.origin, 15, ( 1, 1, 0 ), 0, 2 );
            }
        #/
        
        control_pos = calculate_control_pos( goal_pos );
        
        if ( !isdefined( control_pos ) )
        {
            control_pos = ( self.mover.origin + goal_pos ) * 0.5;
        }
        
        var_684c5e2fde2d8542 = function_2464bfac96338b02( self.origin, control_pos, goal_pos );
        
        if ( var_684c5e2fde2d8542 )
        {
            dis = ( distance( self.origin, control_pos ) + distance( control_pos, goal_pos ) ) * 0.65;
            time = dis / self.current_speed_setting.var_31c81b1ba1f4a2fc;
            
            if ( time >= self.current_speed_setting.sweepcooldown )
            {
                time = self.current_speed_setting.sweepcooldown - 0.1;
            }
            
            thread function_b9e26009847f6691( goal_pos, control_pos, time );
            
            /#
                if ( getdvarint( @"hash_f3a8a3e2d104335f", 0 ) )
                {
                    sphere( self.origin, 10, ( 1, 0, 0 ), 0, 100 );
                    sphere( control_pos, 10, ( 0, 1, 0 ), 0, 100 );
                    sphere( goal_pos, 10, ( 0, 0, 1 ), 0, 100 );
                }
            #/
        }
        else
        {
            thread function_4b411af10f83c124( 70 );
            self.goal_pos = ( goal_pos[ 0 ], goal_pos[ 1 ], self.owner.origin[ 2 ] );
        }
        
        waitframe();
    }
}

// Namespace zombie_galileo_drone
// Params 1, eflags: 0x4
// Checksum 0x39113366, Offset: 0x85e
// Size: 0x376
function private get_goal_pos( update )
{
    goal_pos = undefined;
    
    if ( isdefined( self.owner ) )
    {
        to_owner = self.owner.origin - self.origin;
        var_b74894b38cd388f8 = vectornormalize2( to_owner );
        owner_vel = self.owner getentityvelocity();
        owner_vel = ( owner_vel[ 0 ], owner_vel[ 1 ], 0 );
        var_7ba411e09dd83f1b = lengthsquared( owner_vel ) > 900;
        side_mult = undefined;
        
        if ( var_7ba411e09dd83f1b )
        {
            right_vec = vectorcross( var_b74894b38cd388f8, ( 0, 0, 1 ) );
            goal_right = self.owner.origin + right_vec * 100;
            goal_left = self.owner.origin - right_vec * 100;
            var_af4ff773ba1feac0 = math::function_3e18e1db2522ea75( self.origin, goal_right, self.owner.origin, self.owner.origin + owner_vel * 4 );
            
            if ( var_af4ff773ba1feac0 )
            {
                side_mult = 1;
            }
            else
            {
                var_af4ff773ba1feac0 = math::function_3e18e1db2522ea75( self.origin, goal_left, self.owner.origin, self.owner.origin + owner_vel * 4 );
                
                if ( var_af4ff773ba1feac0 )
                {
                    side_mult = -1;
                }
            }
        }
        
        if ( !side_mult && update && self.goal_pos )
        {
            var_b1da1c624757c6f = self.goal_pos - self.origin;
            perp_dot = var_b1da1c624757c6f[ 0 ] * to_owner[ 1 ] - var_b1da1c624757c6f[ 1 ] * to_owner[ 0 ];
            side_mult = perp_dot < 0 ? 1 : -1;
        }
        
        if ( !side_mult )
        {
            side_count = 0;
            
            foreach ( drone in self.owner.drones )
            {
                if ( drone != self )
                {
                    to_drone = drone.origin - self.origin;
                    perp_dot = to_drone[ 0 ] * to_owner[ 1 ] - to_drone[ 1 ] * to_owner[ 0 ];
                    side_count += perp_dot > 0 ? 1 : -1;
                }
            }
            
            if ( side_count == 0 )
            {
                side_mult = randomint( 2 ) == 0 ? 1 : -1;
            }
            else
            {
                side_mult = side_count > 0 ? 1 : -1;
            }
        }
        
        if ( var_7ba411e09dd83f1b && vectordot( var_b74894b38cd388f8, owner_vel ) > 0 )
        {
            var_85b5d6b91c21c28e = side_mult * 45;
        }
        else
        {
            var_85b5d6b91c21c28e = side_mult * randomfloatrange( 45, 90 );
        }
        
        rot_vec = rotatevector( var_b74894b38cd388f8, ( 0, var_85b5d6b91c21c28e, 0 ) );
        goal_pos = self.owner.origin + rot_vec * randomfloatrange( 50, 150 );
        goal_pos = getclosestpointonnavmesh( goal_pos, self );
    }
    
    return goal_pos;
}

// Namespace zombie_galileo_drone
// Params 3, eflags: 0xc
// Checksum 0x910ae33f, Offset: 0xbdd
// Size: 0x310
function private function_b9e26009847f6691( goal_pos, control_pos, time )
{
    self notify( #"hash_1967f6281f56ca82" );
    self endon( #"hash_1967f6281f56ca82" );
    self endon( #"death" );
    
    if ( !isdefined( self.mover ) )
    {
        mover = spawn( "script_model", self.origin );
        self motionwarpcancel();
        self linkto( mover );
        self.mover = mover;
        self function_786bb6aa1b76c7ee( "is_flying", 1 );
    }
    
    start_point = self.mover.origin;
    end_point = goal_pos;
    control_point = control_pos;
    fly_duration = time;
    
    while ( self.mover && fly_duration > 0 )
    {
        if ( self.owner )
        {
            dist_sqr = distance2dsquared( goal_pos, self.owner.origin );
            
            if ( dist_sqr < 900 || dist_sqr > 40000 )
            {
                break;
            }
        }
        
        anim_rate = asm::function_27be172b46a89235();
        
        /#
            prev_pos = self.mover.origin;
        #/
        
        t = 1 - fly_duration / time;
        op1 = pow( 1 - t, 2 );
        op2 = 2 * ( 1 - t ) * t;
        op3 = pow( t, 2 );
        x_dest = op1 * start_point[ 0 ] + op2 * control_point[ 0 ] + op3 * end_point[ 0 ];
        y_dest = op1 * start_point[ 1 ] + op2 * control_point[ 1 ] + op3 * end_point[ 1 ];
        z_dest = op1 * start_point[ 2 ] + op2 * control_point[ 2 ] + op3 * end_point[ 2 ];
        self.mover.origin = ( x_dest, y_dest, z_dest );
        fly_duration -= level.framedurationseconds * anim_rate;
        
        /#
            if ( getdvarint( @"hash_f3a8a3e2d104335f", 0 ) )
            {
                debug_color = vectorlerp( ( 1, 0, 0 ), ( 0, 1, 0 ), anim_rate );
                level thread utility::draw_line_for_time( self.mover.origin, prev_pos, debug_color[ 0 ], debug_color[ 1 ], debug_color[ 2 ], time * 10 );
            }
        #/
        
        waitframe();
    }
    
    if ( self.mover && fly_duration <= 0 )
    {
        self.mover.origin = goal_pos;
    }
    
    if ( self.mover )
    {
        self motionwarpcancel();
        self unlink();
        self.mover delete();
        self.mover = undefined;
    }
    
    self function_f2df0257c63f229( "is_flying" );
    thread function_51be270b46ad8fc4();
}

// Namespace zombie_galileo_drone
// Params 2, eflags: 0xc
// Checksum 0x30c5c7ae, Offset: 0xef5
// Size: 0x32e
function private function_4b411af10f83c124( height, var_c9daf51cca03bf7a )
{
    self notify( #"hash_58e58f12333fbb8c" );
    self endon( #"hash_58e58f12333fbb8c" );
    self endon( #"death" );
    
    if ( !isdefined( self.mover ) )
    {
        mover = spawn( "script_model", self.origin );
        self motionwarpcancel();
        self linkto( mover );
        self.mover = mover;
    }
    
    gound_point = ( self.mover.origin[ 0 ], self.mover.origin[ 1 ], self.owner.origin[ 2 ] );
    var_c01964b0c50d05b1 = getclosestpointonnavmesh( gound_point );
    
    if ( !isdefined( var_c01964b0c50d05b1 ) )
    {
        var_c01964b0c50d05b1 = gound_point;
    }
    
    traceresult = trace::ray_trace( self.mover.origin, var_c01964b0c50d05b1, self.owner.drones );
    hit = traceresult[ "fraction" ] < 0.95;
    hit_pos = traceresult[ "position" ];
    
    if ( hit && hit_pos )
    {
        var_c01964b0c50d05b1 = hit_pos + ( 0, 0, 5 );
    }
    
    var_ebf65eab28ee9c10 = ( var_c01964b0c50d05b1[ 0 ], var_c01964b0c50d05b1[ 1 ], var_c01964b0c50d05b1[ 2 ] + height );
    traceresult = trace::ray_trace( var_c01964b0c50d05b1, var_ebf65eab28ee9c10, self.owner.drones );
    hit = traceresult[ "fraction" ] < 0.95;
    hit_pos = traceresult[ "position" ];
    
    if ( hit && hit_pos )
    {
        var_ebf65eab28ee9c10 = hit_pos - ( 0, 0, 5 );
    }
    
    self.var_7242c0bd48621253 = 0;
    self.var_eaa1f392a238b64 = 0;
    fly_duration = 0.3;
    
    while ( self.mover && fly_duration > 0 )
    {
        anim_rate = asm::function_27be172b46a89235();
        
        if ( anim_rate <= 0 )
        {
            anim_rate = 0.01;
        }
        
        self.mover moveto( var_ebf65eab28ee9c10, fly_duration / anim_rate );
        fly_duration -= level.framedurationseconds * anim_rate;
        
        /#
            prev_pos = self.mover.origin;
        #/
        
        waitframe();
        
        /#
            if ( getdvarint( @"hash_f3a8a3e2d104335f", 0 ) )
            {
                debug_color = vectorlerp( ( 1, 0, 0 ), ( 0, 1, 0 ), anim_rate );
                level thread utility::draw_line_for_time( self.mover.origin, prev_pos, debug_color[ 0 ], debug_color[ 1 ], debug_color[ 2 ], 3 );
            }
        #/
    }
    
    if ( self.mover )
    {
        self motionwarpcancel();
        self unlink();
        self.mover delete();
        self.mover = undefined;
    }
    
    self function_f2df0257c63f229( "is_flying" );
    self.var_7242c0bd48621253 = var_c9daf51cca03bf7a;
    self.var_eaa1f392a238b64 = !self.var_7242c0bd48621253;
}

// Namespace zombie_galileo_drone
// Params 1, eflags: 0xc
// Checksum 0x7754ca84, Offset: 0x122b
// Size: 0x283
function private function_51be270b46ad8fc4( addition_time )
{
    self notify( #"hash_377d3762a0485dcc" );
    self endon( #"hash_377d3762a0485dcc" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_21bfaac3993bbd56 = 1;
    
    if ( !isdefined( self.mover ) )
    {
        mover = spawn( "script_model", self.origin );
        self motionwarpcancel();
        self linkto( mover );
        self.mover = mover;
        self function_786bb6aa1b76c7ee( "is_flying", 1 );
    }
    
    time = 0;
    speed = 1;
    idle_origin = self.origin;
    cooldown = max( 1, randomfloatrange( self.current_speed_setting.sweepcooldown - 0.5, self.current_speed_setting.sweepcooldown + 0.5 ) ) + ( addition_time ?? 0 );
    time_limit = gettime() + cooldown * 1000;
    
    while ( self.mover && time_limit > gettime() )
    {
        if ( self.owner )
        {
            to_owner = self.owner.origin - self.origin;
            owner_vel = self.owner getentityvelocity();
            owner_vel = ( owner_vel[ 0 ], owner_vel[ 1 ], 0 );
            
            if ( lengthsquared( owner_vel ) > 900 && vectordot( to_owner, owner_vel ) > 0 )
            {
                max_range = 40000;
            }
            else
            {
                max_range = 90000;
            }
            
            dist_sqr = length2dsquared( to_owner );
            
            if ( dist_sqr < 900 || dist_sqr > max_range )
            {
                break;
            }
        }
        
        curve_pos = math::function_8e0d0a2392b676f2( time, 8, 8, 4, 2, 3, 5 );
        time += level.framedurationseconds * speed;
        speed = min( 50, speed + 1 );
        self.mover.origin = idle_origin + curve_pos;
        waitframe();
    }
    
    if ( self.mover )
    {
        self motionwarpcancel();
        self unlink();
        self.mover delete();
        self.mover = undefined;
    }
    
    self function_f2df0257c63f229( "is_flying" );
    self.var_21bfaac3993bbd56 = 0;
}

// Namespace zombie_galileo_drone
// Params 0, eflags: 0x4
// Checksum 0xe6436149, Offset: 0x14b6
// Size: 0xa
function private get_random_float_height()
{
    return randomfloatrange( 70, 110 );
}

// Namespace zombie_galileo_drone
// Params 3, eflags: 0x4
// Checksum 0x82284699, Offset: 0x14c9
// Size: 0x98, Type: bool
function private function_2464bfac96338b02( start_pos, control_pos, end_pos )
{
    traceresult = trace::ray_trace( start_pos, control_pos, self );
    hit = traceresult[ "fraction" ] < 0.95;
    
    if ( hit )
    {
        return false;
    }
    
    traceresult = trace::ray_trace( start_pos, end_pos, self );
    hit = traceresult[ "fraction" ] < 0.95;
    
    if ( hit )
    {
        return false;
    }
    
    traceresult = trace::ray_trace( control_pos, end_pos, self );
    hit = traceresult[ "fraction" ] < 0.95;
    
    if ( hit )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_galileo_drone
// Params 1, eflags: 0x4
// Checksum 0xf3c9b498, Offset: 0x156a
// Size: 0xe4
function private calculate_control_pos( goal_pos )
{
    to_goal_self = goal_pos - self.origin;
    dist = length( to_goal_self );
    var_b1074c004b513429 = ( self.origin + goal_pos ) * 0.5;
    var_9cc615719f324d9a = vectornormalize2( var_b1074c004b513429 - self.owner.origin );
    control_pos = var_b1074c004b513429 + var_9cc615719f324d9a * min( 200, randomfloatrange( dist * 0.33, dist * 0.66 ) );
    traceresult = trace::ray_trace( var_b1074c004b513429, control_pos, self );
    hit = traceresult[ "fraction" ] < 0.95;
    
    if ( hit && isdefined( traceresult[ "position" ] ) )
    {
        control_pos = traceresult[ "position" ];
    }
    
    return control_pos;
}

// Namespace zombie_galileo_drone
// Params 1, eflags: 0x4
// Checksum 0xf6da39ca, Offset: 0x1657
// Size: 0x30
function private on_galileo_drone_killed( params )
{
    if ( self.mover )
    {
        self.mover delete();
        self.mover = undefined;
    }
}

// Namespace zombie_galileo_drone
// Params 1, eflags: 0x4
// Checksum 0x31de7c85, Offset: 0x168f
// Size: 0x53
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) )
    {
        body endon( #"corpse_deleted" );
        body utility::function_32b24db3127bff40( "death", "death" );
        wait 0.1;
        body delete();
    }
}

/#

    // Namespace zombie_galileo_drone
    // Params 0
    // Checksum 0xfd7df27e, Offset: 0x16ea
    // Size: 0x2e, Type: dev
    function init_galileo_drone_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3d>", "<dev string:x62>", &function_bd335da6f3a4f8f7 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_galileo_drone
    // Params 0, eflags: 0x4
    // Checksum 0xe482d36e, Offset: 0x1720
    // Size: 0x1a, Type: dev
    function private function_bd335da6f3a4f8f7()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x87>", @"hash_f3a8a3e2d104335f" );
    }

#/
