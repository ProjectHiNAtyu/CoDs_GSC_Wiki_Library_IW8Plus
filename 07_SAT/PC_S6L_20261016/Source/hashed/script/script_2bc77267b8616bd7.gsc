// script_2bc77267b8616bd7  (hash_2bc77267b8616bd7.gscc) (size: 3103 Bytes / 0xc1f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc9b027f1 (3383764977)
// size ...... 3103 (0xc1f)
// includes .. 4   (offset: 0xb7f)
// strings ... 4   (offset: 0xb9f)
// dev strs .. 5   (offset: 0xbdf)
// exports ... 6   (offset: 0x743)
// cseg ...... 0x7f + 0x6c4 (0x743)
// imports ... 26  (offset: 0x833)
// animtree1 . 0   (offset: 0xc1f)
// animtree2 . 0   (offset: 0xc1f)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_enraged;
#using scripts\common\math;
#using scripts\common\utility;

#namespace zombie_phobos_move;

// Namespace zombie_phobos_move
// Params 0
// Checksum 0x419190e9, Offset: 0x9d
// Size: 0x2
function function_d09624bb6e4f4dc1()
{
    
}

// Namespace zombie_phobos_move
// Params 0
// Checksum 0xd4200b7c, Offset: 0xa7
// Size: 0x28
function init_zombie_phobos_move()
{
    self.var_a91bd029284b1261 = getdvarint( @"hash_98f841d5f0c962f1", 1 );
    thread update_speed();
    thread update_turnrate();
}

// Namespace zombie_phobos_move
// Params 0, eflags: 0x4
// Checksum 0x5bed43cf, Offset: 0xd7
// Size: 0x367
function private update_speed()
{
    self endon( #"death" );
    self.norm_speed = 0;
    
    while ( true )
    {
        var_316149904859a0e = getdvarfloat( @"phobos_speed", -1 );
        
        if ( var_316149904859a0e > 0 )
        {
            self aisetdesiredspeed( var_316149904859a0e );
            self aisettargetspeed( var_316149904859a0e );
            waitframe();
            continue;
        }
        
        if ( utility::ent_flag( "in_melee" ) )
        {
            waitframe();
            continue;
        }
        
        speed_range = undefined;
        
        if ( asm_bb::bb_movetyperequested( "run" ) )
        {
            speed_range = [ 260, getdvarfloat( @"hash_9b9a497a6eaf6ffc", 350 ) ];
        }
        else if ( asm_bb::bb_movetyperequested( "walk" ) )
        {
            speed_range = [ 150, getdvarfloat( @"hash_a7794709e6e60ad0", 210 ) ];
        }
        
        if ( !isdefined( speed_range ) )
        {
            waitframe();
            continue;
        }
        
        var_73907523da8accb4 = getdvarfloat( @"hash_1ed5a241a1f39c50", 1 );
        var_4d395e738e5475e0 = getdvarfloat( @"hash_545645cc06c862c2", 2 );
        
        if ( self._blackboard.var_606bf8ea1f70975d == 0 && zombie_phobos_enraged::is_enraged() )
        {
            var_73907523da8accb4 = getdvarfloat( @"hash_1e76e799df9f15ef", 4 );
        }
        
        var_f94281509c5def5 = getdvarfloat( @"hash_ba4e63ceb0d3249f", 250 );
        var_5950ad72c654d5c1 = level.framedurationseconds / var_73907523da8accb4;
        var_7d1a27a574d80981 = level.framedurationseconds / var_4d395e738e5475e0;
        is_recently_damaged = isdefined( self.last_dmg_struct.timehit ) && gettime() - self.last_dmg_struct.timehit < var_f94281509c5def5;
        var_1e709a6c59e3ec5d = 0;
        var_bfd9a1b518cc6aa6 = self.health / self.maxhealth;
        
        if ( var_bfd9a1b518cc6aa6 > 0.5 && var_bfd9a1b518cc6aa6 < 0.75 || var_bfd9a1b518cc6aa6 < 0.25 )
        {
            var_1e709a6c59e3ec5d = 0.5;
        }
        
        var_12232b932fba82de = var_1e709a6c59e3ec5d;
        
        if ( is_recently_damaged )
        {
            var_12232b932fba82de = 1;
        }
        else if ( isdefined( self.enemy ) )
        {
            var_68e2834572008705 = distance( self.enemy.origin, self.origin );
            max_dist = 1000;
            
            if ( var_68e2834572008705 < max_dist )
            {
                var_12232b932fba82de = 1 - math::remap( var_68e2834572008705, 300, max_dist, var_1e709a6c59e3ec5d, 1 );
            }
        }
        
        if ( var_12232b932fba82de > self.norm_speed )
        {
            self.norm_speed = min( self.norm_speed + var_5950ad72c654d5c1, var_12232b932fba82de );
        }
        else if ( var_12232b932fba82de < self.norm_speed )
        {
            self.norm_speed = max( self.norm_speed - var_7d1a27a574d80981, var_12232b932fba82de );
        }
        
        new_speed = math::remap( self.norm_speed, 0, 1, speed_range[ 0 ], speed_range[ 1 ] );
        self aisetdesiredspeed( new_speed );
        self aisettargetspeed( new_speed );
        
        /#
            if ( debug_move() )
            {
                print3d( self.origin + ( 0, 0, 200 ), "<dev string:x24>" + self.norm_speed + "<dev string:x37>" + new_speed, ( 0.5, 0.7, 0.5 ), 1, 1.2 );
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_phobos_move
// Params 0, eflags: 0x4
// Checksum 0x48143d13, Offset: 0x446
// Size: 0x2df
function private update_turnrate()
{
    self endon( #"death" );
    target_turnrate = 0.001;
    
    while ( true )
    {
        turnrate_acceleration = getdvarfloat( @"hash_b8a18afd3897c249", 0.025 ) * level.framedurationseconds;
        
        if ( !asm_bb::bb_movetyperequested( "walk" ) || utility::ent_flag( "in_melee" ) )
        {
            turnrate_acceleration *= 2;
        }
        
        turnrate_acceleration *= math::remap( self.norm_speed, 0, 1, 1, 1.5 );
        open_fraction = 1;
        navtrace_lookahead_dist = getdvarfloat( @"hash_abd60994bd80f185", 300 );
        navtrace_results = navtrace( self.origin, self.origin + anglestoforward( self.angles ) * navtrace_lookahead_dist, self, 1 );
        
        if ( isdefined( navtrace_results ) )
        {
            open_fraction = navtrace_results[ "fraction" ];
            
            /#
                sphere( navtrace_results[ "<dev string:x43>" ], 10, ( 1, 0, 0 ), 1 );
                print3d( navtrace_results[ "<dev string:x43>" ], "<dev string:x4c>" + navtrace_results[ "<dev string:x53>" ], ( 1, 0, 0 ) );
            #/
        }
        
        path = self getpath();
        
        if ( isdefined( path ) )
        {
            first_path_point = path[ 0 ];
            yaw_to_point = utility::getyawtospot( first_path_point );
            min_turn_rate = getdvarfloat( @"phobos_turn_rate", 1e-05 );
            
            if ( !asm_bb::bb_movetyperequested( "walk" ) || utility::ent_flag( "in_melee" ) )
            {
                min_turn_rate = getdvarfloat( @"hash_b267286e10997f35", 0.1 );
            }
            
            max_turn_rate = getdvarfloat( @"hash_e44d57c2f1a897f5", 0.28 );
            turnrate_acceleration *= math::remap( open_fraction, 0, 1, getdvarfloat( @"hash_6f751f27967e61c0", 5 ), 1 );
            var_e8b2156faf10e60 = getdvarfloat( @"hash_18e6600ae0355c84", 15 );
            mapped_turnrate = clamp( math::remap( abs( yaw_to_point ), var_e8b2156faf10e60, getdvarfloat( @"hash_953327139a6da46a", 90 ), min_turn_rate, max_turn_rate ), 0, max_turn_rate );
            target_turnrate = mapped_turnrate;
            
            if ( abs( yaw_to_point ) < var_e8b2156faf10e60 )
            {
                target_turnrate = min_turn_rate;
            }
            
            self.turnrate = min( self.turnrate, target_turnrate );
            
            if ( abs( self.turnrate - target_turnrate ) > turnrate_acceleration )
            {
                self.turnrate += utility::sign( target_turnrate - self.turnrate ) * turnrate_acceleration;
            }
            else
            {
                self.turnrate = target_turnrate;
            }
        }
        else
        {
            self.turnrate = getdvarfloat( @"phobos_turn_rate", 0.02 );
        }
        
        waitframe();
    }
}

/#

    // Namespace zombie_phobos_move
    // Params 0, eflags: 0x4
    // Checksum 0x31915ab1, Offset: 0x72d
    // Size: 0x16, Type: dev
    function private debug_move()
    {
        return getdvarint( @"hash_682b6127a16b673", 0 ) > 0;
    }

#/
