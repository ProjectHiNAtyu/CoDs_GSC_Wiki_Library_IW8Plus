// script_28f8e299bbcf2c00  (hash_28f8e299bbcf2c00.gscc) (size: 12577 Bytes / 0x3121 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd7a6a9e5 (3618023909)
// size ...... 12577 (0x3121)
// includes .. 12  (offset: 0x2d79)
// strings ... 27  (offset: 0x2dd9)
// dev strs .. 28  (offset: 0x2fa9)
// exports ... 27  (offset: 0x2091)
// cseg ...... 0x21c + 0x1e75 (0x2091)
// imports ... 72  (offset: 0x24c9)
// animtree1 . 0   (offset: 0x3121)
// animtree2 . 0   (offset: 0x3121)
#using script_16ea1b94f0f381b3;
#using script_2de83d6261680959;
#using script_4fb7a9021a570c8a;
#using script_6d4c5bf7d72d6d4a;
#using script_79edb4ed1f52fb62;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_diana_move;

/#

    // Namespace zombie_diana_move
    // Params 0
    // Checksum 0xebf5ecc2, Offset: 0x23a
    // Size: 0xd, Type: dev
    function function_68c6c5770986c491()
    {
        level thread move_devgui();
    }

#/

// Namespace zombie_diana_move
// Params 0
// Checksum 0xc8129eca, Offset: 0x24f
// Size: 0x6e
function init_zombie_diana_move()
{
    self.vantagepoint = "south";
    self.var_3c6d3b81b669f09a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3c6d3b81b669f09a;
    self.flyovercooldown = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.flyovercooldown;
    self.var_811a1d3d27b1c649 = 3;
    thread function_ef981ded6246e2de();
}

// Namespace zombie_diana_move
// Params 4
// Checksum 0xe9b8b397, Offset: 0x2c5
// Size: 0x79
function set_vantage_points( var_1100670fcdac8a7b, var_a726d52b0c649611, var_9c57ff34f26d4dc1, var_820c1890e6000d43 )
{
    self.vantagepoints = [];
    self.vantagepoints[ "south" ] = var_1100670fcdac8a7b;
    self.vantagepoints[ "west" ] = var_a726d52b0c649611;
    self.vantagepoints[ "north" ] = var_9c57ff34f26d4dc1;
    self.vantagepoints[ "east" ] = var_820c1890e6000d43;
}

// Namespace zombie_diana_move
// Params 0
// Checksum 0x866a7f5d, Offset: 0x346
// Size: 0x18
function function_4a1cbc8699d71a69()
{
    self.vantagepoint = undefined;
    self notify( #"hash_705715d52635e990" );
}

// Namespace zombie_diana_move
// Params 2
// Checksum 0xed8c3ea0, Offset: 0x366
// Size: 0x35
function function_9e1aff0dd982c8dc( tetherpoint, tetherradius )
{
    self.var_d7c8b7472cb3ba0e = { #tetherradius:tetherradius, #tetherpoint:tetherpoint };
}

// Namespace zombie_diana_move
// Params 1
// Checksum 0xd6b842d2, Offset: 0x3a3
// Size: 0x17
function function_9bd74d854992fd6c( phase )
{
    self.var_811a1d3d27b1c649 = phase;
}

// Namespace zombie_diana_move
// Params 0, eflags: 0xc
// Checksum 0x48867d38, Offset: 0x3c2
// Size: 0x442
function private function_ef981ded6246e2de()
{
    self notify( #"hash_c5c1b30ba5a8e4f7" );
    self endon( #"hash_c5c1b30ba5a8e4f7" );
    self endon( #"death" );
    self endon( #"hash_705715d52635e990" );
    var_d938ff4d7f6235da = 300;
    var_3f304b11c044ec0e = 1;
    
    while ( true )
    {
        movemsg = utility::waittill_any_return( "move_right_start", "move_left_start", "move_fly_over" );
        self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 1 );
        waitmsg = utility::waittill_any_in_array_or_timeout( [ "armor_break_start", "hibernation_start", "idle_loop_end" ], 2 );
        
        if ( waitmsg == "idle_loop_end" )
        {
            self.var_fbd2b9707b5bd16f = 1;
            
            switch ( movemsg )
            {
                case #"hash_aaeaba9170006d5a":
                    self.var_7bd8c0a747b9f670 = "right";
                    function_a265cb2399b739ab( self.var_7bd8c0a747b9f670 );
                    break;
                case #"hash_55999c09b768f5db":
                    self.var_7bd8c0a747b9f670 = "left";
                    function_a265cb2399b739ab( self.var_7bd8c0a747b9f670 );
                    break;
                case #"hash_ecf2d71cb3d1a4e9":
                    self.var_7bd8c0a747b9f670 = "opposite";
                    self.inflyover = 1;
                    function_a265cb2399b739ab( self.var_7bd8c0a747b9f670, 1 );
                    var_5e3f37d759772fd1 = self.bossfightphase >= self.var_811a1d3d27b1c649;
                    
                    if ( !var_5e3f37d759772fd1 )
                    {
                        var_ccb08dfa08540bad = zombie_diana_necrotic_projectile::get_necrotic_projectile_velocity();
                        thread function_e5ec995acbf9b215();
                    }
                    else
                    {
                        thread zombie_diana_necrotic_beam::function_e17d8c0df80cd369();
                    }
                    
                    thread function_fd87253eccd082bd();
                    break;
            }
            
            asm::function_7256f5ba459c840b( "move_in" );
            self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
            utility::waittill_notify_or_timeout( "diana_move_end", 25 );
            
            if ( movemsg == "move_fly_over" && self.var_880d535ffe6db36f )
            {
                if ( !var_5e3f37d759772fd1 )
                {
                    zombie_diana_necrotic_projectile::set_necrotic_projectile_velocity( var_ccb08dfa08540bad );
                }
                
                wait var_3f304b11c044ec0e;
                entrystartpoint = anglestoforward( self.var_880d535ffe6db36f.angles ) * -2000;
                entrystartpoint = self.var_880d535ffe6db36f.origin + entrystartpoint + ( 0, 0, -2000 );
                self forceteleport( entrystartpoint, self.var_880d535ffe6db36f.angles, 40000 );
                function_eb8ac6f0093f942f( self.var_880d535ffe6db36f.origin, self.var_880d535ffe6db36f.angles );
                thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "intro_finish", "intro_finish", entrystartpoint, self.var_880d535ffe6db36f.angles, "spawn_animating" );
                utility::waittill_notify_or_timeout( "intro_finished", 4.5 );
                self notify( #"move_fly_over_complete" );
            }
            
            self.inflyover = undefined;
            self.var_fbd2b9707b5bd16f = undefined;
            
            if ( self.var_880d535ffe6db36f )
            {
                self forceteleport( self.var_880d535ffe6db36f.origin, self.var_880d535ffe6db36f.angles, var_d938ff4d7f6235da );
                self.var_880d535ffe6db36f = undefined;
            }
            
            if ( self.var_7bd8c0a747b9f670 == "opposite" )
            {
                if ( self.var_f9e48b7ff2c39654.size + 1 > 6 )
                {
                    self.var_f9e48b7ff2c39654[ self.var_f9e48b7ff2c39654.size - 1 ] = undefined;
                }
                
                self.var_f9e48b7ff2c39654 = arraycombine( [ "move_fly_over" ], self.var_f9e48b7ff2c39654 );
                self.var_fc5df94b84690417 = gettime();
            }
            else if ( self.var_7bd8c0a747b9f670 == "left" || self.var_7bd8c0a747b9f670 == "right" )
            {
                self.var_8fad37f51430ed9d = gettime();
                
                if ( self.var_f9e48b7ff2c39654.size + 1 > 6 )
                {
                    self.var_f9e48b7ff2c39654[ self.var_f9e48b7ff2c39654.size - 1 ] = undefined;
                }
                
                self.var_f9e48b7ff2c39654 = arraycombine( [ "move_left_or_right" ], self.var_f9e48b7ff2c39654 );
            }
            
            self.var_7bd8c0a747b9f670 = undefined;
            continue;
        }
        
        self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
    }
}

// Namespace zombie_diana_move
// Params 2, eflags: 0x4
// Checksum 0x34e55b9b, Offset: 0x80c
// Size: 0x344
function private function_a265cb2399b739ab( direction, isflyover )
{
    params = { #var_315c3f93aa18970f:self.vantagepoint };
    
    switch ( self.vantagepoint )
    {
        case #"hash_fbd39e4f5634905a":
            switch ( direction )
            {
                case #"hash_96815ce4f2a3dbc5":
                    self.vantagepoint = "east";
                    break;
                case #"hash_c9b3133a17a3b2d0":
                    self.vantagepoint = "west";
                    break;
                case #"hash_5e8d04fc8bad0698":
                    self.vantagepoint = "north";
                    break;
            }
            
            break;
        case #"hash_a1e9b77432f55b0e":
            switch ( direction )
            {
                case #"hash_96815ce4f2a3dbc5":
                    self.vantagepoint = "south";
                    break;
                case #"hash_c9b3133a17a3b2d0":
                    self.vantagepoint = "north";
                    break;
                case #"hash_5e8d04fc8bad0698":
                    self.vantagepoint = "east";
                    break;
            }
            
            break;
        case #"hash_b9ff0a9f617355e4":
            switch ( direction )
            {
                case #"hash_96815ce4f2a3dbc5":
                    self.vantagepoint = "west";
                    break;
                case #"hash_c9b3133a17a3b2d0":
                    self.vantagepoint = "east";
                    break;
                case #"hash_5e8d04fc8bad0698":
                    self.vantagepoint = "south";
                    break;
            }
            
            break;
        case #"hash_22ce3b03c1e51a9c":
            switch ( direction )
            {
                case #"hash_96815ce4f2a3dbc5":
                    self.vantagepoint = "north";
                    break;
                case #"hash_c9b3133a17a3b2d0":
                    self.vantagepoint = "south";
                    break;
                case #"hash_5e8d04fc8bad0698":
                    self.vantagepoint = "west";
                    break;
            }
            
            break;
    }
    
    if ( isflyover )
    {
        var_f8a9c64333a5d723 = zombie_diana_targeting::function_f84be701d1a07953();
        
        if ( var_f8a9c64333a5d723 )
        {
            var_ad783f494bb96041 = self.vantagepoint;
            
            foreach ( var_315c3f93aa18970f in getarraykeys( self.vantagepoints ) )
            {
                if ( distance2dsquared( var_f8a9c64333a5d723.origin, self.vantagepoints[ var_315c3f93aa18970f ].origin ) < distance2dsquared( var_f8a9c64333a5d723.origin, self.vantagepoints[ var_ad783f494bb96041 ].origin ) )
                {
                    var_ad783f494bb96041 = var_315c3f93aa18970f;
                }
            }
            
            self.vantagepoint = var_ad783f494bb96041;
        }
    }
    
    params.var_dc86ce9c653750f0 = self.vantagepoint;
    
    if ( !params.var_dc86ce9c653750f0 )
    {
        params.var_dc86ce9c653750f0 = "north";
    }
    
    callback::callback( "on_vantage_point_changed", params );
}

// Namespace zombie_diana_move
// Params 2, eflags: 0x4
// Checksum 0x2f6a8314, Offset: 0xb58
// Size: 0xb1
function private function_eb8ac6f0093f942f( var_df857b4fa05c54d7, var_76728da757005237 )
{
    traversalattributes = {};
    traversalattributes.startpos = self.origin;
    traversalattributes.endpos = var_df857b4fa05c54d7;
    traversalattributes.angles = var_76728da757005237;
    
    if ( traversalattributes.startpos && traversalattributes.endpos && traversalattributes.angles )
    {
        self settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, traversalattributes.endpos );
    }
}

// Namespace zombie_diana_move
// Params 0, eflags: 0xc
// Checksum 0x55229b2d, Offset: 0xc11
// Size: 0xf6
function private function_e5ec995acbf9b215()
{
    self notify( #"hash_253f8fa1b3db6e44" );
    self endon( #"hash_253f8fa1b3db6e44" );
    self endon( #"death" );
    self endon( #"hash_b26f77ed4233043" );
    zombie_diana_necrotic_projectile::set_necrotic_projectile_velocity( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_421df2ceee70ef75 );
    
    while ( true )
    {
        self waittill( #"hash_7637960e2edabf26" );
        targets = function_51fa5f90bc674f51();
        
        foreach ( target in targets )
        {
            thread zombie_diana_necrotic_projectile::launch_necrotic_projectile( target, 0, 1 );
            wait 0.2;
        }
    }
}

// Namespace zombie_diana_move
// Params 0, eflags: 0xc
// Checksum 0x225ddc89, Offset: 0xd0f
// Size: 0x68
function private function_fd87253eccd082bd()
{
    self notify( #"hash_b4b001e1a1c5dcc0" );
    self endon( #"hash_b4b001e1a1c5dcc0" );
    self endon( #"death" );
    self endon( #"hash_b26f77ed4233043" );
    zombie_diana_metabones::function_258cc64099d507fc( arrayrandomize( [ "lower_torso_left", "upper_torso_right" ] ) );
    utility::waittill_notify_or_timeout( "move_fly_over_complete", 30.5 );
    zombie_diana_metabones::function_7be0540f93d9f77f();
}

// Namespace zombie_diana_move
// Params 0, eflags: 0x4
// Checksum 0x2d7a419a, Offset: 0xd7f
// Size: 0x1ec
function private function_51fa5f90bc674f51()
{
    var_37978fcff137b2fb = 7;
    target_count = 3;
    potentialtargets = self.var_8f07f1045f74e12e ?? level.players;
    potentialtargets = function_5713d46873b29625( potentialtargets );
    targets = [];
    
    for ( i = 0; i < target_count ; i++ )
    {
        if ( potentialtargets.size > 0 )
        {
            player = utility::array_random( potentialtargets );
            
            if ( player )
            {
                player.var_9a779dfaf473e1ef = undefined;
                targets[ targets.size ] = player;
                potentialtargets = arrayremove( potentialtargets, player );
            }
            
            continue;
        }
        
        player = utility::array_random( self.var_c15224f047a275e5 ?? level.players );
        
        if ( player )
        {
            player.var_9a779dfaf473e1ef = 1;
            targets[ targets.size ] = player;
        }
    }
    
    for ( i = 0; i < target_count ; i++ )
    {
        if ( !self.var_6e49f7b694f29bf1 || self.var_6e49f7b694f29bf1.size == 0 || targets[ i ].var_9a779dfaf473e1ef || !arraycontains( self.var_6e49f7b694f29bf1, targets[ i ] ) )
        {
            player = targets[ i ];
            
            if ( !player )
            {
                continue;
            }
            
            for ( attempt = 0; attempt < var_37978fcff137b2fb ; attempt++ )
            {
                randomoffset = utility::getrandompointincircle( player.origin, 500 );
                navpoint = getclosestpointonnavmesh( randomoffset );
                
                if ( !navpoint )
                {
                    continue;
                }
                
                if ( self.var_d7c8b7472cb3ba0e && distance2dsquared( navpoint, self.var_d7c8b7472cb3ba0e.tetherpoint ) > squared( self.var_d7c8b7472cb3ba0e.tetherradius ) )
                {
                    continue;
                }
                
                break;
            }
            
            if ( navpoint )
            {
                targets[ i ] = { #origin:navpoint };
            }
        }
    }
    
    return targets;
}

// Namespace zombie_diana_move
// Params 2
// Checksum 0xb681b56, Offset: 0xf74
// Size: 0x1b9
function function_6b33e7f9e69db05c( taskid, params )
{
    if ( !self.vantagepoint || !self.vantagepoints )
    {
        return anim.failure;
    }
    
    switch ( self.vantagepoint )
    {
        case #"hash_fbd39e4f5634905a":
            var_648f6574737ff60 = "west";
            var_4cfe232b6e6f37a1 = "east";
            break;
        case #"hash_a1e9b77432f55b0e":
            var_648f6574737ff60 = "north";
            var_4cfe232b6e6f37a1 = "south";
            break;
        case #"hash_b9ff0a9f617355e4":
            var_648f6574737ff60 = "east";
            var_4cfe232b6e6f37a1 = "west";
            break;
        case #"hash_22ce3b03c1e51a9c":
            var_648f6574737ff60 = "south";
            var_4cfe232b6e6f37a1 = "north";
            break;
        default:
            return anim.failure;
    }
    
    var_da60a8c3675aae43 = self.vantagepoints[ var_648f6574737ff60 ];
    var_b674d9c6fd1ae2ec = self.vantagepoints[ var_4cfe232b6e6f37a1 ];
    
    if ( !var_da60a8c3675aae43 || !var_b674d9c6fd1ae2ec )
    {
        return anim.failure;
    }
    
    var_a9264de239b9bf2e = function_ca2c5a2c060a42fb( var_da60a8c3675aae43.origin );
    var_1a8cf3438dec4d9d = function_ca2c5a2c060a42fb( var_b674d9c6fd1ae2ec.origin );
    
    if ( var_a9264de239b9bf2e > var_1a8cf3438dec4d9d )
    {
        self notify( #"move_left_start" );
    }
    else if ( var_1a8cf3438dec4d9d > var_a9264de239b9bf2e )
    {
        self notify( #"move_right_start" );
    }
    else if ( randomint( 2 ) )
    {
        self notify( #"move_left_start" );
    }
    else
    {
        self notify( #"move_right_start" );
    }
    
    return anim.success;
}

// Namespace zombie_diana_move
// Params 1, eflags: 0x4
// Checksum 0xb2044a39, Offset: 0x1136
// Size: 0x141
function private function_ca2c5a2c060a42fb( traceorigin )
{
    loscount = 0;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.ignoreme && !player.var_f468cf5c9e75db1 || player.notarget || player.aether_shroud_active || player getthreatbiasgroup() == "ignored_by_zombies" || player.inlaststand || player.sessionstate != "playing" )
        {
            continue;
        }
        
        result = trace::ray_trace( traceorigin, player geteye(), [ self, player ], trace::create_world_contents() );
        
        if ( result[ "fraction" ] == 1 )
        {
            loscount++;
        }
    }
    
    return loscount;
}

// Namespace zombie_diana_move
// Params 2
// Checksum 0x10d22146, Offset: 0x1280
// Size: 0x81
function function_9a8a210f3bc285e9( taskid, params )
{
    if ( !self.var_6e49f7b694f29bf1 || self.var_6e49f7b694f29bf1.size == 0 )
    {
        return 1;
    }
    
    var_c1969725dc7e6086 = gettime() - ( self.var_8fad37f51430ed9d ?? 0 );
    cooldownscore = clamp( math::remap( var_c1969725dc7e6086, 0, utility::function_4b74c15943231980( self.var_3c6d3b81b669f09a ), 0, 1 ), 0, 1 );
    return cooldownscore;
}

// Namespace zombie_diana_move
// Params 2
// Checksum 0x5dede5b6, Offset: 0x130a
// Size: 0xbf
function function_45950a19ede544a3( taskid, params )
{
    var_4634c2e718a565a1 = 0;
    
    foreach ( var_2bdea747682d42f1 in self.var_f9e48b7ff2c39654 )
    {
        if ( var_2bdea747682d42f1 == "move_left_or_right" )
        {
            var_4634c2e718a565a1++;
        }
    }
    
    var_9a48b1aac439ed1d = clamp( math::remap( var_4634c2e718a565a1, 3, 0, 0, 1 ), 0, 1 );
    return var_9a48b1aac439ed1d;
}

// Namespace zombie_diana_move
// Params 2
// Checksum 0x44aaefe0, Offset: 0x13d2
// Size: 0x21, Type: bool
function function_83e525487564462d( taskid, params )
{
    return self.bossfightphase >= 2;
}

// Namespace zombie_diana_move
// Params 2
// Checksum 0xb00efc74, Offset: 0x13fc
// Size: 0x9f
function function_f9e38c6ac25d9e73( taskid, params )
{
    if ( !self.var_6e49f7b694f29bf1 || self.var_6e49f7b694f29bf1.size == 0 || !self.var_8f07f1045f74e12e || self.var_8f07f1045f74e12e.size == 0 )
    {
        return 1;
    }
    
    var_4a5ac6b64aada926 = gettime() - ( self.var_fc5df94b84690417 ?? 0 );
    cooldownscore = clamp( math::remap( var_4a5ac6b64aada926, 0, utility::function_4b74c15943231980( self.flyovercooldown ), 0, 1 ), 0, 1 );
    return cooldownscore;
}

// Namespace zombie_diana_move
// Params 2
// Checksum 0xec264ed0, Offset: 0x14a4
// Size: 0x131
function function_db31e403339a5e63( taskid, params )
{
    if ( self.var_f9e48b7ff2c39654.size > 0 && self.bossfightphase >= self.var_811a1d3d27b1c649 && ( self.var_f9e48b7ff2c39654[ 0 ] == "move_fly_over" || self.var_f9e48b7ff2c39654[ 0 ] == "move_left_or_right" ) )
    {
        return 0;
    }
    
    if ( !self.var_6e49f7b694f29bf1 || self.var_6e49f7b694f29bf1.size == 0 )
    {
        return 1;
    }
    
    var_56a310a82f469905 = 0;
    
    foreach ( var_2bdea747682d42f1 in self.var_f9e48b7ff2c39654 )
    {
        if ( var_2bdea747682d42f1 == "move_fly_over" )
        {
            var_56a310a82f469905++;
        }
    }
    
    var_9a48b1aac439ed1d = clamp( math::remap( var_56a310a82f469905, 3, 0, 0, 1 ), 0, 1 );
    return var_9a48b1aac439ed1d;
}

/#

    // Namespace zombie_diana_move
    // Params 0
    // Checksum 0xe1b6c0d, Offset: 0x15de
    // Size: 0x78, Type: dev
    function move_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3b>", "<dev string:x46>", &function_633c8fcd4c945272 );
        devgui::add_devgui_func( "<dev string:x51>", "<dev string:x5b>", &function_cfb0e70447e90291 );
        devgui::add_devgui_func( "<dev string:x65>", "<dev string:x73>", &move_fly_over );
        devgui::add_devgui_func( "<dev string:x81>", "<dev string:x98>", &function_e44c58276749cdc9 );
        devgui::function_77df7fe7dd273e10();
        level thread function_701471ce41d07f01();
    }

    // Namespace zombie_diana_move
    // Params 1
    // Checksum 0xd0d404ae, Offset: 0x165e
    // Size: 0x4f, Type: dev
    function function_633c8fcd4c945272( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xaf>" );
        
        if ( isdefined( diana ) )
        {
            diana notify( #"move_right_start" );
        }
    }

    // Namespace zombie_diana_move
    // Params 1
    // Checksum 0xc74b0a6e, Offset: 0x16b5
    // Size: 0x4f, Type: dev
    function function_cfb0e70447e90291( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xaf>" );
        
        if ( isdefined( diana ) )
        {
            diana notify( #"move_left_start" );
        }
    }

    // Namespace zombie_diana_move
    // Params 1
    // Checksum 0x2f03b583, Offset: 0x170c
    // Size: 0x4f, Type: dev
    function move_fly_over( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xaf>" );
        
        if ( isdefined( diana ) )
        {
            diana notify( #"move_fly_over" );
        }
    }

    // Namespace zombie_diana_move
    // Params 0
    // Checksum 0x57dd93f4, Offset: 0x1763
    // Size: 0x38, Type: dev
    function function_e44c58276749cdc9()
    {
        currentval = getdvarint( @"hash_dff3a02d642f27fe", 0 );
        setdvar( @"hash_dff3a02d642f27fe", currentval ? 0 : 1 );
    }

    // Namespace zombie_diana_move
    // Params 0, eflags: 0x4
    // Checksum 0x9a3faa1f, Offset: 0x17a3
    // Size: 0xb2, Type: dev
    function private function_701471ce41d07f01()
    {
        level endon( #"game_ended" );
        var_e3b5c8d2f4cbbc28 = 1.2;
        var_c27d33ae5293d45a = 14;
        var_32e00b421795abcb = 12;
        var_8d37acee5be34522 = 10;
        
        while ( true )
        {
            if ( getdvarint( @"hash_dff3a02d642f27fe", 0 ) )
            {
                diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xaf>" );
                
                if ( isalive( diana ) && isdefined( diana.vantagepoints ) )
                {
                    function_283456128ac5cba5( diana, var_e3b5c8d2f4cbbc28, var_c27d33ae5293d45a, var_32e00b421795abcb, var_8d37acee5be34522 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace zombie_diana_move
    // Params 5, eflags: 0x4
    // Checksum 0x247a94dd, Offset: 0x185d
    // Size: 0x834, Type: dev
    function private function_283456128ac5cba5( diana, textscale, lineheight, var_2bf41e41fa2d8af5, var_8fed0e6d9097d850 )
    {
        var_ac7b26748b29c172 = [];
        var_ac7b26748b29c172[ "<dev string:xbc>" ] = ( 1, 0.2, 0.2 );
        var_ac7b26748b29c172[ "<dev string:xc2>" ] = ( 0.2, 0.6, 1 );
        var_ac7b26748b29c172[ "<dev string:xc7>" ] = ( 0.2, 1, 0.2 );
        var_ac7b26748b29c172[ "<dev string:xcd>" ] = ( 1, 1, 0.2 );
        var_4633f12bce24cde9 = diana.vantagepoint ?? "<dev string:xd2>";
        var_ac0c71745a00708 = diana.var_7bd8c0a747b9f670 ?? "<dev string:xd2>";
        
        foreach ( var_1531ffa2b6aa373f, var_fc1766b62054b18c in diana.vantagepoints )
        {
            if ( !isdefined( var_fc1766b62054b18c ) || !isdefined( var_fc1766b62054b18c.origin ) )
            {
                continue;
            }
            
            var_a960c5da5611f64b = var_ac7b26748b29c172[ var_1531ffa2b6aa373f ] ?? ( 1, 1, 1 );
            var_d1616aa6922db16e = var_fc1766b62054b18c.origin;
            iscurrent = var_1531ffa2b6aa373f == var_4633f12bce24cde9;
            starsize = iscurrent ? var_2bf41e41fa2d8af5 * 2 : var_2bf41e41fa2d8af5;
            debugstar( var_d1616aa6922db16e, var_a960c5da5611f64b, 1, undefined, starsize );
            labelsuffix = "<dev string:xd7>";
            
            if ( iscurrent )
            {
                labelsuffix = "<dev string:xd8>";
            }
            
            print3d( var_d1616aa6922db16e + ( 0, 0, 40 ), var_1531ffa2b6aa373f + labelsuffix, var_a960c5da5611f64b, 1, textscale, 1 );
            
            if ( iscurrent )
            {
                line( diana.origin + ( 0, 0, 36 ), var_d1616aa6922db16e, var_a960c5da5611f64b, 0, 1 );
            }
            
            if ( isdefined( var_fc1766b62054b18c.angles ) )
            {
                fwd = anglestoforward( var_fc1766b62054b18c.angles );
                fwdend = var_d1616aa6922db16e + fwd * 150;
                line( var_d1616aa6922db16e, fwdend, var_a960c5da5611f64b, 0, 1 );
            }
        }
        
        if ( var_ac0c71745a00708 != "<dev string:xd2>" && isdefined( diana.vantagepoint ) && isdefined( diana.vantagepoints[ diana.vantagepoint ] ) )
        {
            var_7e701796fa606dc0 = diana.vantagepoints[ diana.vantagepoint ];
            destorigin = var_7e701796fa606dc0.origin;
            destcolor = var_ac7b26748b29c172[ diana.vantagepoint ] ?? ( 1, 0, 1 );
            line( diana.origin + ( 0, 0, 50 ), destorigin + ( 0, 0, 20 ), destcolor, 0, 1 );
            var_7dbc146468480c50 = vectornormalize2( destorigin - diana.origin );
            var_5eaec2dab3afcc6a = destorigin - var_7dbc146468480c50 * 80 + ( 0, 0, 20 );
            rightvec = vectorcross( var_7dbc146468480c50, ( 0, 0, 1 ) );
            arrowleft = var_5eaec2dab3afcc6a + rightvec * 40;
            arrowright = var_5eaec2dab3afcc6a - rightvec * 40;
            line( destorigin + ( 0, 0, 20 ), arrowleft, destcolor, 0, 1 );
            line( destorigin + ( 0, 0, 20 ), arrowright, destcolor, 0, 1 );
            print3d( diana.origin + ( 0, 0, 80 ), "<dev string:xe3>" + var_ac0c71745a00708 + "<dev string:xec>" + diana.vantagepoint, destcolor, 1, textscale, 1 );
        }
        
        ringorder = [];
        ringorder[ 0 ] = "<dev string:xbc>";
        ringorder[ 1 ] = "<dev string:xc2>";
        ringorder[ 2 ] = "<dev string:xc7>";
        ringorder[ 3 ] = "<dev string:xcd>";
        
        for ( i = 0; i < ringorder.size ; i++ )
        {
            var_ce5b60579efa91fe = ( i + 1 ) % ringorder.size;
            vpa = diana.vantagepoints[ ringorder[ i ] ];
            vpb = diana.vantagepoints[ ringorder[ var_ce5b60579efa91fe ] ];
            
            if ( isdefined( vpa ) && isdefined( vpa.origin ) && isdefined( vpb ) && isdefined( vpb.origin ) )
            {
                line( vpa.origin + ( 0, 0, 5 ), vpb.origin + ( 0, 0, 5 ), ( 0.4, 0.4, 0.4 ), 0, 1 );
            }
        }
        
        var_afc210217e9c6a38 = diana.origin + ( 0, 0, 120 );
        linenum = 0;
        debugstar( diana.origin + ( 0, 0, 36 ), ( 1, 0, 1 ), 1, undefined, var_8fed0e6d9097d850 );
        print3d( var_afc210217e9c6a38 - ( 0, 0, lineheight * linenum ), "<dev string:xf1>", ( 1, 0, 1 ), 1, textscale, 1 );
        linenum++;
        var_a960c5da5611f64b = var_ac7b26748b29c172[ var_4633f12bce24cde9 ] ?? ( 1, 1, 1 );
        print3d( var_afc210217e9c6a38 - ( 0, 0, lineheight * linenum ), "<dev string:x104>" + var_4633f12bce24cde9, var_a960c5da5611f64b, 1, textscale, 1 );
        linenum++;
        print3d( var_afc210217e9c6a38 - ( 0, 0, lineheight * linenum ), "<dev string:x114>" + var_ac0c71745a00708, ( 1, 1, 1 ), 1, textscale, 1 );
        linenum++;
        var_f1c9ef6abe1003b1 = gettime() - ( diana.var_8fad37f51430ed9d ?? 0 );
        var_3d9ab87aa5b135b1 = utility::function_4b74c15943231980( diana.var_3c6d3b81b669f09a ?? 0 );
        lrremaining = var_3d9ab87aa5b135b1 - var_f1c9ef6abe1003b1;
        
        if ( lrremaining > 0 )
        {
            print3d( var_afc210217e9c6a38 - ( 0, 0, lineheight * linenum ), "<dev string:x125>" + int( lrremaining / 1000 ) + "<dev string:x133>", ( 1, 0.5, 0 ), 1, textscale, 1 );
        }
        else
        {
            print3d( var_afc210217e9c6a38 - ( 0, 0, lineheight * linenum ), "<dev string:x135>", ( 0, 1, 0 ), 1, textscale, 1 );
        }
        
        linenum++;
        var_f1e4da6abe2e318c = gettime() - ( diana.var_fc5df94b84690417 ?? 0 );
        var_afcc8e1c9ab8d18 = utility::function_4b74c15943231980( diana.flyovercooldown ?? 0 );
        foremaining = var_afcc8e1c9ab8d18 - var_f1e4da6abe2e318c;
        
        if ( foremaining > 0 )
        {
            print3d( var_afc210217e9c6a38 - ( 0, 0, lineheight * linenum ), "<dev string:x148>" + int( foremaining / 1000 ) + "<dev string:x133>", ( 1, 0.5, 0 ), 1, textscale, 1 );
        }
        else
        {
            print3d( var_afc210217e9c6a38 - ( 0, 0, lineheight * linenum ), "<dev string:x15b>", ( 0, 1, 0 ), 1, textscale, 1 );
        }
        
        linenum++;
        
        if ( isdefined( diana.var_880d535ffe6db36f ) )
        {
            var_db1c9457af766b13 = diana.var_880d535ffe6db36f.origin;
            print3d( var_afc210217e9c6a38 - ( 0, 0, lineheight * linenum ), "<dev string:x173>" + var_db1c9457af766b13, ( 0.5, 1, 1 ), 1, textscale, 1 );
            linenum++;
            debugstar( var_db1c9457af766b13 + ( 0, 0, 20 ), ( 0.5, 1, 1 ), 1 );
            line( diana.origin + ( 0, 0, 36 ), var_db1c9457af766b13 + ( 0, 0, 20 ), ( 0.5, 1, 1 ), 0, 1 );
        }
    }

#/
