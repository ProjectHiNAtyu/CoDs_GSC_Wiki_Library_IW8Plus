// script_32fa79d079aea5f0  (hash_32fa79d079aea5f0.gscc) (size: 717 Bytes / 0x2cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8ab269a (3098224282)
// size ...... 717 (0x2cd)
// includes .. 1   (offset: 0x2a1)
// strings ... 3   (offset: 0x2a9)
// dev strs .. 0   (offset: 0x2cd)
// exports ... 2   (offset: 0x1c5)
// cseg ...... 0x7f + 0x146 (0x1c5)
// imports ... 5   (offset: 0x215)
// animtree1 . 0   (offset: 0x2cd)
// animtree2 . 0   (offset: 0x2cd)
#using scripts\common\trace;

#namespace namespace_50b495c8d5e1c636;

// Namespace namespace_50b495c8d5e1c636
// Params 0
// Checksum 0xba62883, Offset: 0x9d
// Size: 0x128
function function_23b19f0f52f2a61e()
{
    self endon( #"death" );
    self endon( #"foot_stomp_end" );
    var_f9263b500d2f17cb = 200;
    var_3d21eec29b566ffb = ( 0, 0, 1 );
    selfheight = self.origin[ 2 ];
    
    while ( true )
    {
        var_64010ecfaf3b88e = ( 68.3456, 1.86572, 0 );
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

