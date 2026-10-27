// script_ac32c5a74321662  (hash_0ac32c5a74321662.gscc) (size: 2326 Bytes / 0x916)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x42a085fe (1117816318)
// size ...... 2326 (0x916)
// includes .. 0   (offset: 0x8fa)
// strings ... 1   (offset: 0x8fa)
// dev strs .. 1   (offset: 0x90a)
// exports ... 5   (offset: 0x636)
// cseg ...... 0x69 + 0x5cd (0x636)
// imports ... 17  (offset: 0x6fe)
// animtree1 . 0   (offset: 0x916)
// animtree2 . 0   (offset: 0x916)
#namespace namespace_7143065cf1b062e3;

// Namespace namespace_7143065cf1b062e3
// Params 3
// Checksum 0xaa21134, Offset: 0x87
// Size: 0x3dc
function function_ddfffdeccc8dd817( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"float_move_loop_end" );
    self.var_472f812340c3c96e = undefined;
    self.var_449e521c47cbd09f = gettime();
    
    while ( true )
    {
        waitframe();
        
        if ( !isdefined( self.float_move_info ) || self.float_move_info.current_index >= self.float_move_info.points.size - 1 )
        {
            clear_float_move();
            continue;
        }
        
        speed = self.float_move_info.speed;
        current_index = self.float_move_info.current_index;
        start_point = self.float_move_info.points[ current_index ];
        next_point = self.float_move_info.points[ current_index + 1 ];
        delta_z = next_point[ 2 ] - start_point[ 2 ];
        total_length = length( next_point - start_point );
        var_151be7f4c6cf0ab8 = length2d( next_point - start_point );
        to_next_point = next_point - self.origin;
        var_ff0ffec35a64ec92 = length( to_next_point );
        
        if ( var_151be7f4c6cf0ab8 > 0 && var_ff0ffec35a64ec92 > self.float_move_info.speed )
        {
            percentage = 1 - var_ff0ffec35a64ec92 / total_length;
            
            if ( self.float_move_info.var_d62459e3ae307610 )
            {
                var_f9ab8e29999142a = 1;
                
                if ( percentage < 0.5 )
                {
                    var_f9ab8e29999142a = 0.7 + easesine( percentage / 0.5, 1, 0 ) * 0.3;
                }
                else
                {
                    var_f9ab8e29999142a = max( 1 - easesine( ( percentage - 0.5 ) / 0.5, 1, 0 ), 0.2 );
                }
                
                speed *= var_f9ab8e29999142a;
            }
            
            var_63bdabe9640c1301 = length2d( to_next_point );
            var_18fa167463e4f315 = 1 - var_63bdabe9640c1301 / var_151be7f4c6cf0ab8;
            var_13288e71444f2183 = ( to_next_point[ 0 ], to_next_point[ 1 ], 0 );
            new_origin = self.origin + vectornormalize( var_13288e71444f2183 ) * speed;
            
            if ( delta_z < var_151be7f4c6cf0ab8 )
            {
                var_c0e8573dda284e1d = easesine( var_18fa167463e4f315, 1, 1 );
            }
            else
            {
                var_c0e8573dda284e1d = easepower( var_18fa167463e4f315, 2, 0, 1 );
            }
            
            new_origin = ( new_origin[ 0 ], new_origin[ 1 ], start_point[ 2 ] + delta_z * var_c0e8573dda284e1d );
        }
        else
        {
            new_origin = next_point;
            self.float_move_info.current_index = current_index + 1;
        }
        
        if ( isdefined( self.var_472f812340c3c96e ) )
        {
            real_move_dir = vectornormalize2( self.origin - self.var_472f812340c3c96e );
            real_move_dist = distance2dsquared( self.origin, self.var_472f812340c3c96e );
            need_move_dir = vectornormalize2( new_origin - self.origin );
            original_move_dir = vectornormalize2( next_point - start_point );
            dot_product_epsilon = 0.1;
            
            if ( vectordot( original_move_dir, need_move_dir ) <= dot_product_epsilon || real_move_dist > 0 && ( vectordot( need_move_dir, real_move_dir ) <= dot_product_epsilon || real_move_dist < 256 * squared( level.framedurationseconds ) ) )
            {
                self.float_move_info.current_index = self.float_move_info.points.size;
            }
        }
        
        self forceteleport( new_origin );
        self.var_449e521c47cbd09f = gettime();
        self.var_472f812340c3c96e = new_origin;
    }
}

// Namespace namespace_7143065cf1b062e3
// Params 3
// Checksum 0xa4b36e94, Offset: 0x46b
// Size: 0xc1
function function_dce35a336383305c( goal, speed, var_d62459e3ae307610 )
{
    if ( !isdefined( self.float_move_info ) )
    {
        self.float_move_info = spawnstruct();
    }
    
    self.float_move_info.points = [ self.origin, goal ];
    self.float_move_info.current_index = 0;
    self.float_move_info.speed = speed ?? 6;
    self.float_move_info.var_d62459e3ae307610 = var_d62459e3ae307610 ?? 1;
    self function_786bb6aa1b76c7ee( "in_float_move", 1 );
    self.var_472f812340c3c96e = undefined;
}

// Namespace namespace_7143065cf1b062e3
// Params 0
// Checksum 0x145821e7, Offset: 0x534
// Size: 0x37
function clear_float_move()
{
    self.float_move_info = undefined;
    self.var_449e521c47cbd09f = undefined;
    self.var_472f812340c3c96e = undefined;
    self function_f2df0257c63f229( "in_float_move" );
    self notify( #"clear_float_move" );
}

// Namespace namespace_7143065cf1b062e3
// Params 3
// Checksum 0x8b894f27, Offset: 0x573
// Size: 0xc3
function function_66c462b9c6c443c0( goal, speed, var_d62459e3ae307610 )
{
    assert( isdefined( self.float_move_info ), "<dev string:x24>" );
    self.float_move_info.points = [ self.origin, goal ];
    self.float_move_info.current_index = 0;
    self.float_move_info.speed = speed ?? self.float_move_info.speed;
    self.float_move_info.var_d62459e3ae307610 = var_d62459e3ae307610 ?? 1;
    self.var_472f812340c3c96e = undefined;
}

