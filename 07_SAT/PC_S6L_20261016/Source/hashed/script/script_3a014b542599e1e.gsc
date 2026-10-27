// script_3a014b542599e1e  (hash_03a014b542599e1e.gscc) (size: 4778 Bytes / 0x12aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x171e0c71 (387845233)
// size ...... 4778 (0x12aa)
// includes .. 6   (offset: 0x11b6)
// strings ... 12  (offset: 0x11e6)
// dev strs .. 2   (offset: 0x1292)
// exports ... 14  (offset: 0xb6e)
// cseg ...... 0x151 + 0xa1d (0xb6e)
// imports ... 35  (offset: 0xd9e)
// animtree1 . 0   (offset: 0x12aa)
// animtree2 . 0   (offset: 0x12aa)
#using script_16ea1b94f0f381b3;
#using script_670486d63d6d8151;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_triton_ground_slam;

/#

    // Namespace zombie_triton_ground_slam
    // Params 0
    // Checksum 0xf9bcad95, Offset: 0x16f
    // Size: 0x1a, Type: dev
    function function_32e09d850510adf2()
    {
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_76552206ab39a95d", &function_437d8bbc33b212c7 );
    }

#/

// Namespace zombie_triton_ground_slam
// Params 0
// Checksum 0x37c13af2, Offset: 0x191
// Size: 0xb5
function init_zombie_triton_ground_slam()
{
    var_6ec7d4f24a952904 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5e054dd9efd39d4b / 100;
    
    if ( var_6ec7d4f24a952904 <= 6 )
    {
        var_a6e3ebf9ffc5ab08 = 2;
    }
    else
    {
        var_a6e3ebf9ffc5ab08 = 2 + var_6ec7d4f24a952904 - 6;
    }
    
    self function_786bb6aa1b76c7ee( "minDistToGroundSlam", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5e054dd9efd39d4b - var_a6e3ebf9ffc5ab08 * 100 );
    self function_786bb6aa1b76c7ee( "maxDistToGroundSlam", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5e054dd9efd39d4b );
    thread ground_slam_impact_listener();
}

// Namespace zombie_triton_ground_slam
// Params 1
// Checksum 0x59d9c1b2, Offset: 0x24e
// Size: 0x1d
function function_d8805e4a685f3f76( damage )
{
    if ( isdefined( damage ) )
    {
        self.var_778af70bfd34a9a3 = damage;
    }
}

// Namespace zombie_triton_ground_slam
// Params 2
// Checksum 0x175a2cbd, Offset: 0x273
// Size: 0x37
function set_ground_slam_damage_range( minrange, maxrange )
{
    if ( isdefined( minrange ) )
    {
        self.var_b6ac6a074fa88774 = minrange;
    }
    
    if ( isdefined( maxrange ) )
    {
        self.var_cfa45f94ebd0dffb = maxrange;
    }
}

// Namespace zombie_triton_ground_slam
// Params 3
// Checksum 0x3b95ef46, Offset: 0x2b2
// Size: 0x79
function set_ground_slam_range( var_426d22832725f995, var_d8b674018228133d, var_fe47762f88755d57 )
{
    self.var_2c4102e84c8e0a8d = var_426d22832725f995;
    
    if ( isdefined( var_d8b674018228133d ) )
    {
        self function_786bb6aa1b76c7ee( "minDistToGroundSlam", var_d8b674018228133d );
    }
    else
    {
        self function_786bb6aa1b76c7ee( "minDistToGroundSlam", 400 );
    }
    
    if ( isdefined( var_fe47762f88755d57 ) )
    {
        self function_786bb6aa1b76c7ee( "maxDistToGroundSlam", var_fe47762f88755d57 );
        return;
    }
    
    self function_786bb6aa1b76c7ee( "maxDistToGroundSlam", self.var_2c4102e84c8e0a8d );
}

// Namespace zombie_triton_ground_slam
// Params 1
// Checksum 0x6599a38d, Offset: 0x333
// Size: 0x17
function set_ground_slam_cooldown( timeinseconds )
{
    self.var_c244b0bc3f1e4031 = timeinseconds;
}

// Namespace zombie_triton_ground_slam
// Params 1
// Checksum 0x16ea6296, Offset: 0x352
// Size: 0x17
function function_cc1ec29ceaa56b0a( var_e066d2877802cb7a )
{
    self.var_5dd07c23088a0210 = var_e066d2877802cb7a;
}

// Namespace zombie_triton_ground_slam
// Params 1
// Checksum 0x78585d52, Offset: 0x371
// Size: 0x17
function function_7d2f4a95c32d09ce( var_5cffa383e0b526fc )
{
    self.var_add92a8db3fd2295 = var_5cffa383e0b526fc;
}

// Namespace zombie_triton_ground_slam
// Params 0, eflags: 0x4
// Checksum 0xc9d37678, Offset: 0x390
// Size: 0x341
function private ground_slam_impact_listener()
{
    self endon( #"death" );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
    self.var_2c4102e84c8e0a8d = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5e054dd9efd39d4b;
    self.var_778af70bfd34a9a3 = getdvarfloat( @"hash_2fec179994f441d3", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6c7733968d32e601 );
    self.var_c244b0bc3f1e4031 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c244b0bc3f1e4031;
    var_cf13477fe2b9fc7d = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4627906ae267ab2b;
    var_3f9fe6c6d730bba8 = getdvarfloat( @"hash_3b01ef6fdcd9f210", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_263a7646c3babfdb );
    self.var_cfa45f94ebd0dffb = getdvarfloat( @"hash_63d238fa766764a5", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_cfa45f94ebd0dffb );
    self.var_b6ac6a074fa88774 = getdvarfloat( @"hash_2e3354fba9764536", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b6ac6a074fa88774 );
    self.var_722925f7867c5729 = gettime() + randomfloatrange( 0, utility::function_4b74c15943231980( self.var_c244b0bc3f1e4031 ) );
    function_cc1ec29ceaa56b0a( getdvarfloat( @"hash_75b9cb80b06a267d", 0.2 ) );
    function_7d2f4a95c32d09ce( getdvarfloat( @"hash_93c305aa2f17b2f6", 0.18 ) );
    
    while ( true )
    {
        while ( self getaiblackboarddynamic( "in_ground_slam" ) )
        {
            waitframe();
        }
        
        self waittill( #"triton_ground_slam_start" );
        thread function_45ed64bc33554844();
        thread function_401012fa9e0fd2ff();
        self.var_722925f7867c5729 = gettime();
        asm::function_7256f5ba459c840b( "ground_slam_in" );
        self waittill( #"ground_slam_impact" );
        zombie_triton_impact::radius_ground_impact( "tag_hammer_top", var_cf13477fe2b9fc7d, var_3f9fe6c6d730bba8, "MOD_EXPLOSIVE", self.var_b6ac6a074fa88774, self.var_cfa45f94ebd0dffb, "triton_foot_stomp_ground_impact_fx", undefined, "triton_slam_impact_concussive_wave_fx", 60, undefined, undefined, undefined, 1, 2800, 0.34, 1.25 );
        var_8aad93bc07f31de7 = [];
        
        if ( self.var_d368de47f50cccdf.var_fd7d82e053f417e4.size > 0 )
        {
            foreach ( var_a9b4eadb5a36a91f in self.var_d368de47f50cccdf.var_fd7d82e053f417e4 )
            {
                var_8aad93bc07f31de7[ var_8aad93bc07f31de7.size ] = var_a9b4eadb5a36a91f.entity;
            }
        }
        
        zombie_triton_impact::line_ground_impact( "tag_hammer_top", self.var_2c4102e84c8e0a8d, self.var_778af70bfd34a9a3, self.var_5dd07c23088a0210, var_8aad93bc07f31de7 );
    }
}

// Namespace zombie_triton_ground_slam
// Params 0, eflags: 0x4
// Checksum 0x17500564, Offset: 0x6d9
// Size: 0x206
function private function_45ed64bc33554844()
{
    self endon( #"death" );
    self endon( #"ground_slam_impact" );
    self endon( #"hash_f42c288c3f4c9d38" );
    var_a8f2862d64c3099d = 10;
    var_ad61dc3e5798c055 = 0.05;
    var_b1418138ba443bd0 = getdvarfloat( @"hash_f4ad4c219a0d2714", 2 );
    var_6294660b4afe3f43 = getdvarfloat( @"hash_fd2836e45c5bb6ae", 50 );
    
    if ( !isdefined( self.var_add92a8db3fd2295 ) )
    {
        self.var_add92a8db3fd2295 = 0;
    }
    
    var_401531466078197f = 1;
    var_6e778d11bfe8da4d = 0;
    
    while ( isdefined( self.enemy ) )
    {
        var_ef202fe3806a19ed = vectornormalize2( self.enemy getentityvelocity() );
        var_a6dd90914576e763 = anglestoright( self.angles ) * var_b1418138ba443bd0;
        attackpos = self.enemy.origin + var_a6dd90914576e763 + var_ef202fe3806a19ed * var_6294660b4afe3f43;
        
        if ( navtrace( self.origin, attackpos ) )
        {
            attackpos = self.var_6cd898dbad55ddd8;
        }
        else
        {
            self.var_6cd898dbad55ddd8 = attackpos;
        }
        
        if ( attackpos )
        {
            if ( var_401531466078197f )
            {
                var_6e778d11bfe8da4d += var_ad61dc3e5798c055;
                
                if ( var_6e778d11bfe8da4d > 1 )
                {
                    var_401531466078197f = undefined;
                }
                else
                {
                    var_8d0a29473764c42a = anglelerpquatfrac( self.angles, vectortoangles( attackpos - self.origin ), var_6e778d11bfe8da4d );
                    yawdelta = absangleclamp180( self.angles[ 1 ] - vectortoyaw( attackpos - self.origin ) );
                    
                    if ( yawdelta < var_a8f2862d64c3099d )
                    {
                        var_401531466078197f = undefined;
                    }
                    else
                    {
                        self orientmode( "face angle", var_8d0a29473764c42a[ 1 ], 1 );
                    }
                }
            }
            else
            {
                wait self.var_add92a8db3fd2295;
                self orientmode( "face angle", vectortoyaw( attackpos - self.origin ), 1 );
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_triton_ground_slam
// Params 0, eflags: 0x4
// Checksum 0x755b2220, Offset: 0x8e7
// Size: 0x128
function private function_401012fa9e0fd2ff()
{
    self endon( #"death" );
    self endon( #"hash_f42c288c3f4c9d38" );
    var_f9263b500d2f17cb = 200;
    var_3d21eec29b566ffb = ( 0, 0, 1 );
    selfheight = self.origin[ 2 ];
    
    while ( true )
    {
        var_64010ecfaf3b88e = ( 201.396, 28.3552, 55.7826 );
        var_64010ecfaf3b88e = rotatepointaroundvector( var_3d21eec29b566ffb, var_64010ecfaf3b88e, self.angles[ 1 ] );
        var_64010ecfaf3b88e = self.origin + var_64010ecfaf3b88e;
        var_fce76671139699d8 = var_64010ecfaf3b88e + var_3d21eec29b566ffb * var_f9263b500d2f17cb;
        var_435031c0d74dddad = var_64010ecfaf3b88e + -1 * var_3d21eec29b566ffb * var_f9263b500d2f17cb;
        groundtrace = trace::ray_trace( var_fce76671139699d8, var_435031c0d74dddad, [ self ], trace::create_solid_ai_contents( 1 ) );
        
        if ( groundtrace[ "hittype" ] != "hittype_none" )
        {
            var_64010ecfaf3b88e = groundtrace[ "position" ];
        }
        
        var_c0959d1d6060ca36 = -1 * ( selfheight - var_64010ecfaf3b88e[ 2 ] );
        var_c0959d1d6060ca36 = clamp( var_c0959d1d6060ca36, -45, 45 );
        self function_a8fe8d86843b9cee( var_c0959d1d6060ca36 );
        waitframe();
    }
}

// Namespace zombie_triton_ground_slam
// Params 2
// Checksum 0xf0483428, Offset: 0xa17
// Size: 0xff
function function_a2831e8a933e0861( taskid, params )
{
    if ( self._blackboard.var_65f32caa86b87a2 || !self.enemy )
    {
        return anim.failure;
    }
    
    nav_trace_results = navtrace( self.origin, self.enemy.origin, undefined, 1 );
    
    if ( distancesquared( nav_trace_results[ "position" ], self.enemy.origin ) > 10000 )
    {
        return anim.failure;
    }
    
    self.var_6cd898dbad55ddd8 = self.enemy.origin;
    
    if ( isdefined( self.var_722925f7867c5729 ) && gettime() > self.var_722925f7867c5729 + utility::function_4b74c15943231980( self.var_c244b0bc3f1e4031 ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

/#

    // Namespace zombie_triton_ground_slam
    // Params 1
    // Checksum 0x3c9fb0e9, Offset: 0xb1f
    // Size: 0x4f, Type: dev
    function function_437d8bbc33b212c7( params )
    {
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x98>" );
        
        if ( isdefined( triton ) )
        {
            triton notify( #"triton_ground_slam_start" );
        }
    }

#/
