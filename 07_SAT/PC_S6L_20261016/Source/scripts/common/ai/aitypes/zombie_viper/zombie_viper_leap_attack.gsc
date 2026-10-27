// scripts\common\ai\aitypes\zombie_viper\zombie_viper_leap_attack.gsc  (hash_770bd05c6f9502a8.gscc) (size: 3683 Bytes / 0xe63 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b7d4b53 (998067027)
// size ...... 3683 (0xe63)
// includes .. 5   (offset: 0xd9b)
// strings ... 11  (offset: 0xdc3)
// dev strs .. 0   (offset: 0xe63)
// exports ... 8   (offset: 0x86b)
// cseg ...... 0xdc + 0x78f (0x86b)
// imports ... 34  (offset: 0x9ab)
// animtree1 . 0   (offset: 0xe63)
// animtree2 . 0   (offset: 0xe63)
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;

#namespace zombie_viper_leap_attack;

// Namespace zombie_viper_leap_attack
// Params 0
// Checksum 0x753d7712, Offset: 0xfa
// Size: 0x9
function init_global()
{
    zombie_leap_attack::init_zombie_leap_attack_global();
}

// Namespace zombie_viper_leap_attack
// Params 0
// Checksum 0x5d75f403, Offset: 0x10b
// Size: 0x17
function init()
{
    zombie_leap_attack::init_zombie_leap_attack();
    thread function_85140bf7907cff79();
    thread function_df19c57a27d37868();
}

// Namespace zombie_viper_leap_attack
// Params 2
// Checksum 0xe5db31ce, Offset: 0x12a
// Size: 0x40a, Type: bool
function function_442ca7a890390ccb( taskid, params )
{
    assert( self.enemy );
    
    foreach ( player in level.players )
    {
        if ( player vehicle::is_in_vehicle() )
        {
            if ( distancesquared( player.origin, self.enemy.origin ) < 4000000 )
            {
                return false;
            }
        }
    }
    
    var_f69827bbfb33eb2b = self.enemy getentityvelocity();
    gravity = getgravity();
    target_vel_flat = ( var_f69827bbfb33eb2b[ 0 ], var_f69827bbfb33eb2b[ 1 ], 0 );
    var_9b2074841dc5ff3f = self.enemy.origin + target_vel_flat * 1.167;
    var_4b2ce735265d99f8 = var_9b2074841dc5ff3f - self.origin;
    to_enemy_flat = ( var_4b2ce735265d99f8[ 0 ], var_4b2ce735265d99f8[ 1 ], 0 );
    var_68e2834572008705 = length( var_4b2ce735265d99f8 );
    clamped_dist = clamp( var_68e2834572008705, self._blackboard.var_7a0ed1d8a025653, self._blackboard.var_6dc50e9edbfedf79 );
    range = self._blackboard.var_6dc50e9edbfedf79 - self._blackboard.var_7a0ed1d8a025653;
    fraction = ( clamped_dist - self._blackboard.var_7a0ed1d8a025653 ) / range;
    leap_speed = math::lerp( self._blackboard.var_ed8e43492e9992f3, self._blackboard.var_93c0b68a5d2543c5, fraction );
    intersect_time = function_7c5e5df2de8967bf( to_enemy_flat, target_vel_flat, leap_speed );
    intersect_pos = var_9b2074841dc5ff3f + var_f69827bbfb33eb2b * intersect_time;
    nav_trace_result = navtrace( self.enemy.origin, intersect_pos, self, 1 );
    intersect_pos = nav_trace_result[ "position" ];
    angle = math::anglebetweenvectorsunit( vectornormalize2( self.origin - self.enemy.origin ), vectornormalize2( target_vel_flat ) );
    var_37fa6688249e2016 = math::remap( angle, 0, 180, 100, 200 );
    var_273d5beb82f57260 = intersect_pos - self.origin;
    var_51cc1f09d2a6f12c = length2d( var_273d5beb82f57260 );
    leap_dist = min( var_51cc1f09d2a6f12c - var_37fa6688249e2016, self._blackboard.var_6dc50e9edbfedf79 );
    backoff_dist = var_51cc1f09d2a6f12c - leap_dist;
    leap_pos = intersect_pos - vectornormalize2( var_273d5beb82f57260 ) * backoff_dist;
    var_7cc25b1fa79f682b = leap_pos - self.origin;
    
    if ( vectordot( var_7cc25b1fa79f682b, anglestoforward( self.angles ) ) <= 0 )
    {
        return false;
    }
    
    nav_trace_result = navtrace( intersect_pos, leap_pos, self, 1 );
    leap_pos = nav_trace_result[ "position" ];
    
    if ( nav_trace_result[ "fraction" ] < 1 )
    {
        var_de25f678797ad8a3 = distance2dsquared( leap_pos, intersect_pos );
        
        if ( var_de25f678797ad8a3 < var_37fa6688249e2016 * var_37fa6688249e2016 )
        {
            return false;
        }
    }
    
    vehicles = vehicle_getarrayinradius( leap_pos, 750, 500 );
    
    if ( vehicles.size > 0 )
    {
        return false;
    }
    
    leap_pos = self function_351cbae8705f818b( leap_pos, ( 0, 0, 0 ), 0 );
    
    if ( !isdefined( leap_pos ) || self function_115ace7999b27fd4( leap_pos ) )
    {
        return false;
    }
    
    self._blackboard.var_497e751941b50bed = leap_pos;
    return true;
}

// Namespace zombie_viper_leap_attack
// Params 3, eflags: 0x4
// Checksum 0x769a5463, Offset: 0x53d
// Size: 0x162
function private function_7c5e5df2de8967bf( rel_pos, var_f69827bbfb33eb2b, intercept_speed )
{
    rr = vectordot( rel_pos, rel_pos );
    rv = vectordot( rel_pos, var_f69827bbfb33eb2b );
    vv = vectordot( var_f69827bbfb33eb2b, var_f69827bbfb33eb2b );
    a = vv - intercept_speed * intercept_speed;
    b = 2 * rv;
    c = rr;
    
    if ( abs( a ) < 0.001 )
    {
        if ( abs( b ) < 0.001 )
        {
            return 0;
        }
        
        t = c * -1 / b;
        
        if ( t > 0.001 )
        {
            return t;
        }
        
        return 0;
    }
    
    d = b * b - 4 * a * c;
    
    if ( d < 0 )
    {
        return 0;
    }
    
    sqrt_d = sqrt( d );
    t1 = ( b * -1 - sqrt_d ) / 2 * a;
    t2 = ( b * -1 + sqrt_d ) / 2 * a;
    
    if ( t1 > 0.001 && t2 > 0.001 )
    {
        return min( t1, t2 );
    }
    else if ( t1 > 0.001 )
    {
        return t1;
    }
    else if ( t2 > 0.001 )
    {
        return t2;
    }
    
    return 0;
}

// Namespace zombie_viper_leap_attack
// Params 0, eflags: 0x4
// Checksum 0xaef1fe11, Offset: 0x6a8
// Size: 0xc3
function private function_85140bf7907cff79()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_attack_start" );
        
        if ( isplayer( self.enemy ) )
        {
            self.var_43acac8796301e81 = self.enemy;
        }
        
        self.var_542134bab16723fb = self.var_a13bed1ac47e1b2c;
        self.var_a13bed1ac47e1b2c = 1;
        val::set( "viper_leap_attack", "disallow_stun", 1 );
        val::set( "viper_leap_attack", "stunned", 0 );
        val::set( "viper_leap_attack", "pain", 0 );
        val::set( "viper_leap_attack", "special_pain", 0 );
        utility::function_32b24db3127bff40( "thruster", "on" );
        thread rocket_thruster_watcher();
    }
}

// Namespace zombie_viper_leap_attack
// Params 0, eflags: 0x4
// Checksum 0xb264f7d4, Offset: 0x773
// Size: 0x55
function private function_df19c57a27d37868()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_attack_end" );
        self.var_43acac8796301e81 = undefined;
        self.var_a13bed1ac47e1b2c = self.var_542134bab16723fb;
        self.var_542134bab16723fb = undefined;
        val::reset_all( "viper_leap_attack" );
    }
}

// Namespace zombie_viper_leap_attack
// Params 0, eflags: 0x4
// Checksum 0x939297bf, Offset: 0x7d0
// Size: 0x9b
function private rocket_thruster_watcher()
{
    self endon( #"death" );
    var_4d2f69921a511cef = self.origin[ 2 ];
    timeout = gettime() + 3000;
    
    while ( self.origin[ 2 ] >= var_4d2f69921a511cef && gettime() <= timeout )
    {
        var_4d2f69921a511cef = self.origin[ 2 ];
        wait 0.1;
    }
    
    utility::function_32b24db3127bff40( "thruster", "off" );
    self waittill( #"leap_landed" );
    utility::function_32b24db3127bff40( "thruster", "landed" );
}

