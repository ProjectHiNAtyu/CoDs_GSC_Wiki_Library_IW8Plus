// scripts\mp\ftue\utility\ftue_movement.gsc  (hash_2f981f68661d5e1a.gscc) (size: 3181 Bytes / 0xc6d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43623f36 (1130512182)
// size ...... 3181 (0xc6d)
// includes .. 1   (offset: 0xc65)
// strings ... 0   (offset: 0xc6d)
// dev strs .. 0   (offset: 0xc6d)
// exports ... 16  (offset: 0x789)
// cseg ...... 0x58 + 0x731 (0x789)
// imports ... 14  (offset: 0xa09)
// animtree1 . 0   (offset: 0xc6d)
// animtree2 . 0   (offset: 0xc6d)
#using scripts\common\math;

#namespace ftue_movement;

// Namespace ftue_movement
// Params 0
// Checksum 0xbed3f8e2, Offset: 0x76
// Size: 0x3e
function function_18c7b96a7a2afacd()
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    self.hassprinted = 0;
    
    while ( !self issprinting() )
    {
        waitframe();
    }
    
    self.hassprinted = 1;
}

// Namespace ftue_movement
// Params 0
// Checksum 0x87c7e965, Offset: 0xbc
// Size: 0x3e
function function_9563a8eb6d150b80()
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    self.var_b9594d38e4979266 = 0;
    
    while ( !self issupersprinting() )
    {
        waitframe();
    }
    
    self.var_b9594d38e4979266 = 1;
}

// Namespace ftue_movement
// Params 0
// Checksum 0xd37d19a1, Offset: 0x102
// Size: 0x3e
function function_716b247f4427a04e()
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    self.var_4e9dc625fe912108 = 0;
    
    while ( !self isautosprinting() )
    {
        waitframe();
    }
    
    self.var_4e9dc625fe912108 = 1;
}

// Namespace ftue_movement
// Params 3
// Checksum 0xd8df8331, Offset: 0x148
// Size: 0x80
function function_3d0087e7aee586e0( var_ec862c3a81422c05, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    inittime = gettime();
    var_ec862c3a81422c05 *= 1000;
    
    while ( !self.hassprinted )
    {
        if ( gettime() - inittime >= var_ec862c3a81422c05 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace ftue_movement
// Params 3
// Checksum 0xb4a8ea52, Offset: 0x1d0
// Size: 0x80
function function_9d2bda1b7767ca1( var_ec862c3a81422c05, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    inittime = gettime();
    var_ec862c3a81422c05 *= 1000;
    
    while ( !self.var_b9594d38e4979266 )
    {
        if ( gettime() - inittime >= var_ec862c3a81422c05 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace ftue_movement
// Params 3
// Checksum 0xbf3eee86, Offset: 0x258
// Size: 0x80
function function_dbcf1c53667ddeef( var_ec862c3a81422c05, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    inittime = gettime();
    var_ec862c3a81422c05 *= 1000;
    
    while ( !self.var_4e9dc625fe912108 )
    {
        if ( gettime() - inittime >= var_ec862c3a81422c05 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace ftue_movement
// Params 1
// Checksum 0x5e78fa2f, Offset: 0x2e0
// Size: 0x85
function function_4aa68cd6002c229( targetdistance )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    self.haswalked = 0;
    self.init_pos = self.origin;
    dist = 0;
    
    while ( dist < targetdistance * 10 )
    {
        dist = distance( self.origin, self.init_pos );
        wait 0.5;
    }
    
    self.haswalked = 1;
}

// Namespace ftue_movement
// Params 2
// Checksum 0x4f3b2226, Offset: 0x36d
// Size: 0x76
function function_57c6a95a77bf7734( targetlocation, targetdistance )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    self.hasmovedto = 0;
    dist = targetdistance * 10;
    
    while ( dist > targetdistance )
    {
        dist = distance( self.origin, targetlocation );
        wait 0.2;
    }
    
    self.hasmovedto = 1;
}

// Namespace ftue_movement
// Params 1
// Checksum 0x531bd2dc, Offset: 0x3ec
// Size: 0x9b
function function_a5f2a55c67641492( anglediff )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    self.var_ccb312234042a0d6 = 0;
    init_angles = anglestoforward( self getplayerangles( 0 ) );
    init_angles = vectornormalize( init_angles );
    
    while ( true )
    {
        current_angles = anglestoforward( self getplayerangles( 0 ) );
        current_angles = vectornormalize( current_angles );
        dist_angles = math::anglebetweenvectors( current_angles, init_angles );
        
        if ( dist_angles >= anglediff )
        {
            self.var_ccb312234042a0d6 = 1;
            break;
        }
        
        waitframe();
    }
}

// Namespace ftue_movement
// Params 2
// Checksum 0x2535986e, Offset: 0x490
// Size: 0x43
function function_7277ffd13b9163be( targetdistance, anglediff )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    self.var_54d19a841bad173a = 0;
    function_377c8296e1e51739( targetdistance, anglediff );
}

// Namespace ftue_movement
// Params 2
// Checksum 0xb5d68a78, Offset: 0x4dc
// Size: 0xf4
function function_377c8296e1e51739( targetdistance, anglediff )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    self endon( #"currentContextualTipCompleted" );
    self endon( #"currentContextualTipAborted" );
    self.var_54d19a841bad173a = 0;
    init_pos = self.origin;
    init_angles = anglestoforward( self getplayerangles( 0 ) );
    
    while ( true )
    {
        dist_pos = distance( self.origin, init_pos );
        current_angles = anglestoforward( self getplayerangles( 0 ) );
        
        if ( current_angles != init_angles )
        {
            dist_angles = math::anglebetweenvectorsunit( current_angles, init_angles );
            
            if ( isdefined( dist_angles ) && isdefined( dist_pos ) && dist_angles >= anglediff && dist_pos > targetdistance )
            {
                self.var_54d19a841bad173a = 1;
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace ftue_movement
// Params 3
// Checksum 0x8521a027, Offset: 0x5d8
// Size: 0x80
function function_33e1f59dca0ce78c( var_ec862c3a81422c05, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    inittime = gettime();
    var_ec862c3a81422c05 *= 1000;
    
    while ( !self.haswalked )
    {
        if ( gettime() - inittime >= var_ec862c3a81422c05 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace ftue_movement
// Params 3
// Checksum 0x29a54e35, Offset: 0x660
// Size: 0x80
function function_6fe8b7f4243724ac( var_ec862c3a81422c05, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    inittime = gettime();
    var_ec862c3a81422c05 *= 1000;
    
    while ( !self.var_ccb312234042a0d6 )
    {
        if ( gettime() - inittime >= var_ec862c3a81422c05 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace ftue_movement
// Params 3
// Checksum 0xbda49d1d, Offset: 0x6e8
// Size: 0x80
function function_f7f64787506e2978( var_ec862c3a81422c05, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( #"disconnect" );
    inittime = gettime();
    var_ec862c3a81422c05 *= 1000;
    
    while ( !self.var_54d19a841bad173a )
    {
        if ( gettime() - inittime >= var_ec862c3a81422c05 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace ftue_movement
// Params 0
// Checksum 0xa62d396a, Offset: 0x770
// Size: 0x18
function function_b637614feabc055f()
{
    result = self isonground();
    return self isonground();
}

