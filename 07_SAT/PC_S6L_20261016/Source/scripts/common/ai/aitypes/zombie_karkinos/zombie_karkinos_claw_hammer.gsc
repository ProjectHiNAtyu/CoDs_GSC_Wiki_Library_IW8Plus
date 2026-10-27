// scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_claw_hammer.gsc  (hash_6710c984c2db5429.gscc) (size: 7232 Bytes / 0x1c40 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x99ff97dc (2583664604)
// size ...... 7232 (0x1c40)
// includes .. 10  (offset: 0x1aa4)
// strings ... 21  (offset: 0x1af4)
// dev strs .. 1   (offset: 0x1c34)
// exports ... 18  (offset: 0x10b4)
// cseg ...... 0x1c7 + 0xeed (0x10b4)
// imports ... 59  (offset: 0x1384)
// animtree1 . 0   (offset: 0x1c40)
// animtree2 . 0   (offset: 0x1c40)
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;

#namespace zombie_karkinos_claw_hammer;

// Namespace zombie_karkinos_claw_hammer
// Params 0
// Checksum 0xb29cc607, Offset: 0x1e5
// Size: 0x9
function init_global()
{
    zombie_leap_attack::init_zombie_leap_attack_global();
}

// Namespace zombie_karkinos_claw_hammer
// Params 0
// Checksum 0x520a6c73, Offset: 0x1f6
// Size: 0x1d0
function init_karkinos_claw_hammer()
{
    zombie_leap_attack::init_zombie_leap_attack( 0, 1 );
    self.claw_hammer_range = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.clawhammerrange;
    self.claw_hammer_charge_timeout = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4dd65b02fee4da1a ) );
    self.var_2547fab6df8cb903 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ddd7eedc3f01aad1;
    self.var_d73300b744e0e6e4 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1d687ebd10e04afd;
    self.var_d95a0929ec789409 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1ef712fef2921332;
    self.var_dca0d319083278e3 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_da846e93741e370e;
    self.var_689df72dad48a0ca = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f4fd4d939fb2534d;
    self.var_e9a9e59262866f80 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_2c719ea973c1ab89;
    self.claw_hammer_cooldown = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.clawhammercooldown ) );
    self.var_9ff4774a2a6cdce8 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_196b0266867b2a23;
    self function_786bb6aa1b76c7ee( "claw_hammer_range", self.claw_hammer_range );
    assert( self.var_dca0d319083278e3 > self.var_689df72dad48a0ca, "<dev string:x24>" );
}

// Namespace zombie_karkinos_claw_hammer
// Params 1
// Checksum 0x4ce4d4d6, Offset: 0x3ce
// Size: 0xc5
function function_3ee07a76214c50cd( taskid )
{
    ai::set_blackboard_cooldown( "claw_hammer_cooldown", self.claw_hammer_cooldown );
    
    if ( !isalive( self.enemy ) )
    {
        cleanup_claw_hammer();
        return anim.failure;
    }
    
    self.var_b7a70401b1065e32 = 0;
    self.var_ce9d26fd37050dda = self.enemy;
    self function_f2fdf8ef124744e8( 3, self.var_ce9d26fd37050dda );
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "karkinos_claw_hammer_charge", 33 );
    self function_786bb6aa1b76c7ee( "in_claw_hammer_intro", 1 );
    self function_786bb6aa1b76c7ee( "in_claw_hammer", 1 );
    
    if ( getdvarint( @"hash_a633af809be097a1", 1 ) )
    {
        zombie_karkinos::disable_claw_shield( 0, "claw_hammer" );
    }
    
    return anim.success;
}

// Namespace zombie_karkinos_claw_hammer
// Params 1
// Checksum 0x8a4452e9, Offset: 0x49c
// Size: 0x27e
function function_407b38652b5c7cbe( params )
{
    if ( !isalive( self.var_ce9d26fd37050dda ) )
    {
        return anim.failure;
    }
    
    if ( self.var_ce9d26fd37050dda.ignoreme )
    {
        return anim.failure;
    }
    
    if ( zombie_stun::is_stunned() )
    {
        return anim.failure;
    }
    
    if ( self getaiblackboarddynamic( "in_claw_hammer" ) != 1 )
    {
        return anim.failure;
    }
    
    assert( isdefined( self.var_b7a70401b1065e32 ) );
    
    if ( self.var_b7a70401b1065e32 == 0 )
    {
        if ( self getaiblackboarddynamic( "in_claw_hammer_intro" ) != 1 )
        {
            self.var_b7a70401b1065e32 = 1;
            
            if ( getdvarint( @"hash_3de153bc9559505f", 1 ) > 0 )
            {
                if ( distancesquared( self.var_ce9d26fd37050dda.origin, self.origin ) < 1000000 )
                {
                    self.var_ce9d26fd37050dda playrumblelooponentity( "damage_light" );
                    thread function_f5119b3f19298023( self.var_ce9d26fd37050dda );
                    thread out_of_rumble_range_watcher( self.var_ce9d26fd37050dda );
                }
            }
            else
            {
                self.var_ce9d26fd37050dda playrumblelooponentity( "damage_light" );
                thread function_f5119b3f19298023( self.var_ce9d26fd37050dda );
            }
            
            thread function_d73ec0905bcf6a4a();
            self.var_f696659c28bf9366 = gettime() + self.claw_hammer_charge_timeout;
        }
    }
    
    if ( self.var_b7a70401b1065e32 == 1 )
    {
        if ( self.var_f696659c28bf9366 <= gettime() )
        {
            return anim.failure;
        }
        
        if ( distancesquared( self.origin, self.var_ce9d26fd37050dda.origin ) < squared( self.var_e9a9e59262866f80 ) )
        {
            if ( !function_dd1faccb1a5a45dc() )
            {
                self.var_b7a70401b1065e32 = 2;
                return anim.running;
            }
            
            if ( isplayer( self.var_ce9d26fd37050dda ) )
            {
                self.var_43acac8796301e81 = self.var_ce9d26fd37050dda;
            }
            
            thread ground_slam();
            return anim.success;
        }
    }
    
    if ( self.var_b7a70401b1065e32 == 2 )
    {
        if ( self.var_f696659c28bf9366 <= gettime() )
        {
            return anim.failure;
        }
        
        if ( distancesquared( self.origin, self.var_ce9d26fd37050dda.origin ) < squared( self.claw_melee_range ) )
        {
            return anim.failure;
        }
    }
    
    return anim.running;
}

// Namespace zombie_karkinos_claw_hammer
// Params 1
// Checksum 0x71f7b9e7, Offset: 0x723
// Size: 0x13
function function_9a6ac45a8b9cdb96( taskid )
{
    cleanup_claw_hammer();
}

// Namespace zombie_karkinos_claw_hammer
// Params 0, eflags: 0x4
// Checksum 0xa72a6013, Offset: 0x73e
// Size: 0x178
function private function_d73ec0905bcf6a4a()
{
    self endon( #"death" );
    self endon( #"leap_attack_start" );
    self endon( #"claw_hammer_cleaned_up" );
    
    while ( true )
    {
        var_e634391cd94f5e81 = 0.2;
        move_vector = self.velocity * var_e634391cd94f5e81;
        predicted_pos = self getcentroid() + move_vector;
        a_zombies = getaiarrayinradius( predicted_pos, 64 );
        
        foreach ( zombie in a_zombies )
        {
            if ( !isalive( zombie ) || zombie == self )
            {
                continue;
            }
            
            if ( zombie.type == "zombie" && ( !isdefined( zombie.aicategory ) || zombie.aicategory == "normal" ) )
            {
                if ( !math::is_point_in_front( zombie.origin ) )
                {
                    continue;
                }
                
                if ( !zombie._blackboard.zombieinknockdown )
                {
                    zombie zombie_knockdown::function_6fc167d4a3590991( self.origin );
                }
            }
        }
        
        wait 0.2;
    }
}

// Namespace zombie_karkinos_claw_hammer
// Params 0
// Checksum 0x98db24f8, Offset: 0x8be
// Size: 0x213, Type: bool
function function_dd1faccb1a5a45dc()
{
    assert( self.var_ce9d26fd37050dda );
    
    foreach ( player in level.players )
    {
        if ( player vehicle::is_in_vehicle() )
        {
            if ( distancesquared( player.origin, self.var_ce9d26fd37050dda.origin ) < 4000000 )
            {
                return false;
            }
        }
    }
    
    intersect_pos = self.var_ce9d26fd37050dda.origin;
    var_273d5beb82f57260 = intersect_pos - self.origin;
    var_51cc1f09d2a6f12c = length2d( var_273d5beb82f57260 );
    leap_dist = min( var_51cc1f09d2a6f12c - self.var_9ff4774a2a6cdce8, self._blackboard.var_6dc50e9edbfedf79 );
    backoff_dist = var_51cc1f09d2a6f12c - leap_dist;
    leap_pos = intersect_pos - vectornormalize2( var_273d5beb82f57260 ) * backoff_dist;
    var_7cc25b1fa79f682b = leap_pos - self.origin;
    
    if ( vectordot( var_7cc25b1fa79f682b, anglestoforward( self.angles ) ) <= 0 )
    {
        return false;
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
    
    /#
        if ( getdvarint( @"hash_848d7b1aabe8fa00", 0 ) == 1 )
        {
            circle( leap_pos, 15, undefined, ( 0, 1, 1 ), 0, 200 );
        }
    #/
    
    self._blackboard.var_497e751941b50bed = leap_pos;
    return true;
}

// Namespace zombie_karkinos_claw_hammer
// Params 0, eflags: 0xc
// Checksum 0xeff1757e, Offset: 0xada
// Size: 0x1b3
function private ground_slam()
{
    self notify( #"hash_ac5350e0acefd25e" );
    self endon( #"hash_ac5350e0acefd25e" );
    self endon( #"death" );
    self waittill( #"leap_landed" );
    
    /#
        function_c5e4131dda8eba2();
    #/
    
    ent_array = getplayersandaiarrayinradius( self.origin, self.var_d73300b744e0e6e4 );
    
    foreach ( ent in ent_array )
    {
        if ( !isalive( ent ) || ent == self )
        {
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            damage = self.var_dca0d319083278e3 - self.var_689df72dad48a0ca;
            ent dodamage( damage, self.origin, self, self, "MOD_CRUSH", undefined, undefined, undefined );
            ent playrumbleonentity( "ground_pound_land" );
            ent earthquakeforplayer( 0.75, 0.75, self.origin, self.var_d73300b744e0e6e4 );
            continue;
        }
        
        if ( ent.type == "zombie" && ( !isdefined( ent.aicategory ) || ent.aicategory == "normal" ) )
        {
            if ( !ent._blackboard.zombieinknockdown )
            {
                ent zombie_knockdown::function_6fc167d4a3590991( self.origin );
            }
        }
    }
}

// Namespace zombie_karkinos_claw_hammer
// Params 0
// Checksum 0xb711c9c, Offset: 0xc95
// Size: 0xa2
function cleanup_claw_hammer()
{
    self endon( #"death" );
    was_melee_charge = self.var_b7a70401b1065e32 == 2;
    self.var_ce9d26fd37050dda = undefined;
    self.var_b7a70401b1065e32 = undefined;
    self function_f2df0257c63f229( "in_claw_hammer_intro" );
    self function_f2df0257c63f229( "in_claw_hammer" );
    self clearbtgoal( 3 );
    zombie_utils::function_a8ce00e0448cb6f0( undefined, "karkinos_claw_hammer_charge", 33 );
    self notify( #"claw_hammer_cleaned_up" );
    
    if ( getdvarint( @"hash_a633af809be097a1", 1 ) )
    {
        if ( was_melee_charge )
        {
            thread function_7e11c9b61c1aa349( 3 );
            return;
        }
        
        zombie_karkinos::function_5d9dd6b1a00c39bd( "claw_hammer" );
    }
}

// Namespace zombie_karkinos_claw_hammer
// Params 1, eflags: 0x4
// Checksum 0x59dfb1ba, Offset: 0xd3f
// Size: 0x27
function private function_7e11c9b61c1aa349( delay_seconds )
{
    self endon( #"death" );
    wait delay_seconds;
    zombie_karkinos::function_5d9dd6b1a00c39bd( "claw_hammer" );
}

// Namespace zombie_karkinos_claw_hammer
// Params 1
// Checksum 0xcc4d385a, Offset: 0xd6e
// Size: 0x7d
function function_9a8c9bc3cb591e9b( taskid )
{
    val::set( "karkinos_ground_slam", "disallow_stun", 1 );
    val::set( "karkinos_ground_slam", "stunned", 0 );
    val::set( "karkinos_ground_slam", "pain", 0 );
    val::set( "karkinos_ground_slam", "special_pain", 0 );
    
    if ( getdvarint( @"hash_a633af809be097a1", 1 ) )
    {
        zombie_karkinos::disable_claw_shield( 0, "claw_hammer_leap" );
    }
    
    return anim.success;
}

// Namespace zombie_karkinos_claw_hammer
// Params 1
// Checksum 0x4bbfa0c6, Offset: 0xdf4
// Size: 0x36
function function_66dae5fbbf6ebe9c( taskid )
{
    val::reset_all( "karkinos_ground_slam" );
    
    if ( getdvarint( @"hash_a633af809be097a1", 1 ) )
    {
        zombie_karkinos::function_5d9dd6b1a00c39bd( "claw_hammer_leap" );
    }
}

// Namespace zombie_karkinos_claw_hammer
// Params 1, eflags: 0xc
// Checksum 0xbc1e6b91, Offset: 0xe32
// Size: 0x4b
function private function_f5119b3f19298023( rumble_target )
{
    self notify( #"hash_8a87c7c00e109a73" );
    self endon( #"hash_8a87c7c00e109a73" );
    utility::waittill_any( "death", "claw_hammer_cleaned_up", "out_of_rumble_range" );
    
    if ( rumble_target )
    {
        rumble_target stoprumble( "damage_light" );
    }
}

// Namespace zombie_karkinos_claw_hammer
// Params 1, eflags: 0x4
// Checksum 0x2f1d63ac, Offset: 0xe85
// Size: 0xbf
function private out_of_rumble_range_watcher( rumble_target )
{
    self endon( #"death" );
    self endon( #"claw_hammer_cleaned_up" );
    rumble_target endon( #"death" );
    rumble_playing = 1;
    
    while ( true )
    {
        in_range = distancesquared( self.origin, rumble_target.origin ) < 1000000;
        
        if ( !in_range && rumble_playing )
        {
            self notify( #"out_of_rumble_range" );
            rumble_playing = 0;
        }
        else if ( in_range && !rumble_playing )
        {
            rumble_target playrumblelooponentity( "damage_light" );
            thread function_f5119b3f19298023( self.var_ce9d26fd37050dda );
            rumble_playing = 1;
        }
        
        wait 0.5;
    }
}

/#

    // Namespace zombie_karkinos_claw_hammer
    // Params 0, eflags: 0x4
    // Checksum 0x38a2345d, Offset: 0xf4c
    // Size: 0x69, Type: dev
    function private function_c5e4131dda8eba2()
    {
        if ( getdvarint( @"hash_848d7b1aabe8fa00", 0 ) == 1 )
        {
            circle( self.origin, self.var_d73300b744e0e6e4, undefined, ( 1, 0, 0 ), 0, 10 );
            circle( self.origin, self.var_d95a0929ec789409, undefined, ( 1, 1, 0 ), 0, 10 );
        }
    }

    // Namespace zombie_karkinos_claw_hammer
    // Params 2, eflags: 0x4
    // Checksum 0x6f67397f, Offset: 0xfbd
    // Size: 0x63, Type: dev
    function private function_561fee8688d973c( var_f370b69d0d8846ba, target_pos )
    {
        if ( getdvarint( @"hash_848d7b1aabe8fa00", 0 ) == 1 )
        {
            sphere( var_f370b69d0d8846ba, 5, ( 1, 0, 0 ), 0 );
            line( self.origin, target_pos, ( 1, 1, 0 ), 1, 0 );
        }
    }

    // Namespace zombie_karkinos_claw_hammer
    // Params 3, eflags: 0x4
    // Checksum 0x7a61519c, Offset: 0x1028
    // Size: 0x8c, Type: dev
    function private function_aba67782214c7aa8( enemy_pos, target_pos, wait_time_in_s )
    {
        if ( getdvarint( @"hash_848d7b1aabe8fa00", 0 ) == 1 )
        {
            duration = utility::function_329f35afae907694( wait_time_in_s );
            circle( target_pos, 5, ( 0, 0, 1 ), ( 1, 1, 1 ), 0, duration );
            line( enemy_pos, target_pos, ( 1, 1, 1 ), 1, 0, duration );
        }
    }

#/
