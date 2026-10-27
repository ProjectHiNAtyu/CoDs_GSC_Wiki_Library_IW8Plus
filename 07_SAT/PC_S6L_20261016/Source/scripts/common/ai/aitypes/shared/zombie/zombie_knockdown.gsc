// scripts\common\ai\aitypes\shared\zombie\zombie_knockdown.gsc  (hash_1a6a1f7bdb57d7ff.gscc) (size: 4306 Bytes / 0x10d2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbfa543dc (3215279068)
// size ...... 4306 (0x10d2)
// includes .. 5   (offset: 0x106a)
// strings ... 5   (offset: 0x1092)
// dev strs .. 0   (offset: 0x10d2)
// exports ... 13  (offset: 0x996)
// cseg ...... 0xac + 0x8ea (0x996)
// imports ... 41  (offset: 0xb9e)
// animtree1 . 0   (offset: 0x10d2)
// animtree2 . 0   (offset: 0x10d2)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_liveragdoll;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_knockdown;

// Namespace zombie_knockdown
// Params 0, eflags: 0x5
// Checksum 0xb396cf48, Offset: 0xca
// Size: 0x3e
function private autoexec init()
{
    utility::registersharedfunc( #"zombie", #"knockdownzombie", &function_6fc167d4a3590991 );
    utility::registersharedfunc( #"zombie", #"iszombieinknockdown", &function_19d6107cb6bdff5c );
}

// Namespace zombie_knockdown
// Params 2
// Checksum 0x37c79566, Offset: 0x110
// Size: 0x4d
function function_a113e6ee43535d37( source_pos, intensity )
{
    var_e0f6a367c81790c8 = getdvarint( @"hash_84f09d47faf2262a", 0 );
    
    if ( var_e0f6a367c81790c8 == 1 )
    {
        if ( namespace_2b061fdb82f4aba::function_6273f9e3a020d096( source_pos, intensity ) )
        {
            return;
        }
    }
    
    function_6fc167d4a3590991( source_pos );
}

// Namespace zombie_knockdown
// Params 1
// Checksum 0x1ad31960, Offset: 0x165
// Size: 0x8a, Type: bool
function function_99b2020a564d9c7e( source_pos )
{
    if ( !isalive( self ) || !isscriptedai( self ) )
    {
        return false;
    }
    
    if ( self.disallow_knockdown )
    {
        return false;
    }
    
    if ( !isvector( source_pos ) )
    {
        return false;
    }
    
    if ( !function_605c20f278a1b5a8() )
    {
        return false;
    }
    
    var_caa67496e8434636 = self findoverridearchetype( "animscript" );
    
    if ( isdefined( var_caa67496e8434636 ) && var_caa67496e8434636 != self getbasearchetype() )
    {
        return false;
    }
    
    if ( zombie_traverse::is_traversing() )
    {
        return false;
    }
    
    if ( !function_2eb6752428726543() )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_knockdown
// Params 3
// Checksum 0x4508fdf6, Offset: 0x1f8
// Size: 0x12f
function function_6fc167d4a3590991( source_pos, var_b2eb78867e8a1555, var_1e734ef465fcd586 )
{
    if ( !function_99b2020a564d9c7e( source_pos ) )
    {
        return 0;
    }
    
    knockback_impact_vector = undefined;
    
    if ( isdefined( var_b2eb78867e8a1555 ) )
    {
        assert( isint( var_b2eb78867e8a1555 ) || isfloat( var_b2eb78867e8a1555 ) );
        
        if ( !isint( var_b2eb78867e8a1555 ) && !isfloat( var_b2eb78867e8a1555 ) )
        {
            return 0;
        }
        
        if ( !isdefined( var_1e734ef465fcd586 ) )
        {
            var_1e734ef465fcd586 = 45;
        }
        
        assert( isint( var_1e734ef465fcd586 ) || isfloat( var_1e734ef465fcd586 ) );
        
        if ( !isint( var_1e734ef465fcd586 ) && !isfloat( var_1e734ef465fcd586 ) )
        {
            return 0;
        }
        
        if ( var_1e734ef465fcd586 < 0 )
        {
            var_1e734ef465fcd586 = 0;
        }
        else if ( var_1e734ef465fcd586 > 65 )
        {
            var_1e734ef465fcd586 = 65;
        }
        
        var_ff64faf4dc87b59a = vectornormalize2( self.origin - source_pos );
        var_d9c6c56556205ccb = vectorcross( var_ff64faf4dc87b59a, anglestoup( self.angles ) );
        
        if ( lengthsquared( var_d9c6c56556205ccb ) > 0.001 )
        {
            knockback_impact_vector = rotatepointaroundvector( var_d9c6c56556205ccb, var_ff64faf4dc87b59a, var_1e734ef465fcd586 );
            knockback_impact_vector = var_b2eb78867e8a1555 * knockback_impact_vector;
        }
    }
    
    return knockdown_ai_internal( source_pos, knockback_impact_vector );
}

// Namespace zombie_knockdown
// Params 2
// Checksum 0x12b28907, Offset: 0x330
// Size: 0x76
function knockdown_ai_aerial( source_pos, var_b2eb78867e8a1555 )
{
    if ( !function_99b2020a564d9c7e( source_pos ) )
    {
        return 0;
    }
    
    assert( isint( var_b2eb78867e8a1555 ) || isfloat( var_b2eb78867e8a1555 ) );
    
    if ( !isint( var_b2eb78867e8a1555 ) && !isfloat( var_b2eb78867e8a1555 ) )
    {
        return 0;
    }
    
    knockback_impact_vector = vectornormalize( self getcentroid() - source_pos ) * var_b2eb78867e8a1555;
    return knockdown_ai_internal( source_pos, knockback_impact_vector );
}

// Namespace zombie_knockdown
// Params 2, eflags: 0x4
// Checksum 0xe69c1708, Offset: 0x3af
// Size: 0xd2, Type: bool
function private knockdown_ai_internal( source_pos, knockback_impact_vector )
{
    self._blackboard.var_cab12c69b6d910e3 = source_pos;
    self.var_d51ba58c54d7dfeb = gettime();
    
    if ( function_ced41211f9bc141e( knockback_impact_vector ) && knockback_impact_vector != ( 0, 0, 0 ) )
    {
        self._blackboard.var_c3e02ea4bff38502 = knockback_impact_vector;
        thread function_101e831de889aa17();
    }
    else
    {
        self._blackboard.var_c3e02ea4bff38502 = ( 0, 0, 0 );
        self._blackboard.zombieinknockdown = 1;
        asm::function_7256f5ba459c840b( "knockdown_in" );
        self._blackboard.zombieinknockdown = 1;
    }
    
    return true;
}

// Namespace zombie_knockdown
// Params 1, eflags: 0x4
// Checksum 0xbcf5f627, Offset: 0x48a
// Size: 0x4f, Type: bool
function private function_ced41211f9bc141e( value )
{
    if ( !isvector( value ) )
    {
        return false;
    }
    
    return value[ 0 ] * 0 == 0 && value[ 1 ] * 0 == 0 && value[ 2 ] * 0 == 0;
}

// Namespace zombie_knockdown
// Params 0
// Checksum 0x41bafe50, Offset: 0x4e2
// Size: 0x6d, Type: bool
function function_605c20f278a1b5a8()
{
    if ( self.var_d6894f01a36b4ff3.var_1fe24b1e0c3f9a11 )
    {
        current_time = gettime();
        
        if ( self.var_d51ba58c54d7dfeb )
        {
            var_6c47c0f8623e2b10 = ( current_time - self.var_d51ba58c54d7dfeb ) * 0.001;
            
            if ( var_6c47c0f8623e2b10 < self.var_d6894f01a36b4ff3.var_1fe24b1e0c3f9a11 )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace zombie_knockdown
// Params 0
// Checksum 0x9b8dada8, Offset: 0x558
// Size: 0x16, Type: bool
function function_19d6107cb6bdff5c()
{
    return istrue( self._blackboard.zombieinknockdown );
}

// Namespace zombie_knockdown
// Params 0
// Checksum 0xe543a896, Offset: 0x577
// Size: 0x15
function function_2eb6752428726543()
{
    return self asmhasstate( self.asmname, "knockdown_in" );
}

// Namespace zombie_knockdown
// Params 0, eflags: 0x4
// Checksum 0xcf99dd18, Offset: 0x595
// Size: 0x43
function private function_101e831de889aa17()
{
    self endon( #"death" );
    self endon( #"knockdown_end" );
    self waittill( #"hash_a825e4ab363e721d" );
    
    if ( self._blackboard.var_6f70aaf18083f64 )
    {
        self kill();
    }
}

// Namespace zombie_knockdown
// Params 3
// Checksum 0xbf1325be, Offset: 0x5e0
// Size: 0x3b6
function function_a0c03faf3694150c( var_efe02cc999d047db, var_45df969c4023bed5, var_7722e51ef9e05ec3 )
{
    self notify( #"hash_fdf42da5f61c2e04" );
    self endon( #"hash_fdf42da5f61c2e04" );
    self endon( #"death" );
    
    if ( !isdefined( var_45df969c4023bed5 ) )
    {
        var_45df969c4023bed5 = self.var_d6894f01a36b4ff3.speedthreshold_list;
    }
    
    if ( !isdefined( var_7722e51ef9e05ec3 ) )
    {
        var_7722e51ef9e05ec3 = self.var_d6894f01a36b4ff3.knockdowndata_list;
    }
    
    if ( var_45df969c4023bed5.size == 0 || var_7722e51ef9e05ec3.size == 0 )
    {
        return;
    }
    
    min_move_speed = undefined;
    
    for ( var_935e8ba391cf4146 = 0; var_935e8ba391cf4146 < var_7722e51ef9e05ec3.size ; var_935e8ba391cf4146++ )
    {
        for ( var_a706b51a8e894e8d = 0; var_a706b51a8e894e8d < var_45df969c4023bed5.size ; var_a706b51a8e894e8d++ )
        {
            if ( var_45df969c4023bed5[ var_a706b51a8e894e8d ].movetype == var_7722e51ef9e05ec3[ var_935e8ba391cf4146 ].movetype )
            {
                min_speed = var_45df969c4023bed5[ var_a706b51a8e894e8d ].speedthreshold * var_7722e51ef9e05ec3[ var_935e8ba391cf4146 ].minspeedmodifier;
                
                if ( !isdefined( min_move_speed ) || min_speed < min_move_speed )
                {
                    min_move_speed = min_speed;
                }
                
                break;
            }
        }
    }
    
    if ( !isdefined( min_move_speed ) )
    {
        return;
    }
    
    var_a250cce95a6f87b0 = squared( min_move_speed );
    
    while ( !isfunction( var_efe02cc999d047db ) || [[ var_efe02cc999d047db ]]() )
    {
        var_e7ebf067ba6b4142 = undefined;
        
        foreach ( entry in var_7722e51ef9e05ec3 )
        {
            if ( entry.movetype == self._blackboard.movetype )
            {
                var_e7ebf067ba6b4142 = entry;
                break;
            }
        }
        
        if ( isdefined( var_e7ebf067ba6b4142 ) )
        {
            velocity = self.velocity;
            speedsqr = lengthsquared( velocity );
            
            if ( speedsqr > var_a250cce95a6f87b0 )
            {
                curr_time = gettime();
                
                if ( !isdefined( min_speed_time ) )
                {
                    min_speed_time = curr_time;
                }
                
                if ( min_speed_time + var_e7ebf067ba6b4142.minspeeddelay * 1000 <= curr_time )
                {
                    var_45a9eba29d2f7ef7 = self.origin;
                    
                    if ( var_e7ebf067ba6b4142.velocityoffset > 0 )
                    {
                        var_4e09b54e3981b420 = vectornormalize( velocity );
                        var_45a9eba29d2f7ef7 += var_4e09b54e3981b420 * var_e7ebf067ba6b4142.velocityoffset;
                    }
                    
                    /#
                    #/
                    
                    potential_targets = getaiarrayinradius( var_45a9eba29d2f7ef7, var_e7ebf067ba6b4142.radius );
                    
                    foreach ( target in potential_targets )
                    {
                        if ( isalive( target ) && target != self && target.team == self.team && ( !isdefined( target.aicategory ) || target.aicategory == "normal" ) && !target function_19d6107cb6bdff5c() )
                        {
                            target function_6fc167d4a3590991( var_45a9eba29d2f7ef7 );
                            target thread val::set_for_time( 5, "abom_walk_through", "ignore_ai_collision", 1 );
                        }
                    }
                }
            }
            else
            {
                min_speed_time = undefined;
            }
        }
        
        wait var_e7ebf067ba6b4142.interval ?? 1;
    }
}

