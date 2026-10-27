// script_55d2fbc7e8258580  (hash_55d2fbc7e8258580.gscc) (size: 1897 Bytes / 0x769 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xff30679b (4281362331)
// size ...... 1897 (0x769)
// includes .. 3   (offset: 0x6f1)
// strings ... 3   (offset: 0x709)
// dev strs .. 4   (offset: 0x731)
// exports ... 6   (offset: 0x3a9)
// cseg ...... 0x79 + 0x330 (0x3a9)
// imports ... 21  (offset: 0x499)
// animtree1 . 0   (offset: 0x769)
// animtree2 . 0   (offset: 0x769)
#using scripts\asm\asm;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_2200c30b7f7a871d;

// Namespace namespace_2200c30b7f7a871d
// Params 1
// Checksum 0x9a76d67f, Offset: 0x97
// Size: 0x25
function register_melee_state( state_name )
{
    assert( isstring( state_name ) );
    self.var_878a729dd9083870 = state_name;
}

// Namespace namespace_2200c30b7f7a871d
// Params 0
// Checksum 0x2b0fcb4f, Offset: 0xc4
// Size: 0x1a
function request_melee_asm_state()
{
    asm::function_7256f5ba459c840b( self.var_878a729dd9083870 ?? "melee_in" );
}

// Namespace namespace_2200c30b7f7a871d
// Params 0
// Checksum 0xb3c4352b, Offset: 0xe6
// Size: 0x30, Type: bool
function is_in_melee_state()
{
    if ( isalive( self ) && isai( self ) && asm::asm_getcurrentstatename( self.asmname ) == "melee" )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2200c30b7f7a871d
// Params 4
// Checksum 0x7e87b1e0, Offset: 0x11f
// Size: 0x26b, Type: bool
function function_de4c8768a775f004( asmname, statename, tostatename, params )
{
    target = self._blackboard.meleerequestedtarget;
    
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    to_yaw = utility::getyawtospot( target.origin );
    
    if ( abs( to_yaw ) > getdvarfloat( @"hash_d7755c2c7d8a589f", 20 ) )
    {
        return false;
    }
    
    dist_to_target = distance( target.origin, self.origin );
    to_target_norm = vectornormalize2( target.origin - self.origin );
    wall_dist_check = getdvarfloat( @"hash_daafdc2cc01168f1", 50 );
    wall_nav_trace_results = navtrace( target.origin, target.origin + to_target_norm * wall_dist_check, undefined, 1 );
    
    /#
        if ( debug_melee() )
        {
            if ( isdefined( wall_nav_trace_results[ "<dev string:x24>" ] ) )
            {
                line( target.origin, wall_nav_trace_results[ "<dev string:x24>" ], ( 1, 0, 0 ) );
                print3d( wall_nav_trace_results[ "<dev string:x24>" ], "<dev string:x2d>" + wall_nav_trace_results[ "<dev string:x39>" ] + "<dev string:x42>" + dist_to_target, ( 1, 0.2, 0 ) );
            }
        }
    #/
    
    if ( gettime() - ( self.var_5e54a22a92a6b4f ?? 0 ) < 10000 )
    {
        return false;
    }
    
    if ( wall_nav_trace_results[ "fraction" ] >= 1 )
    {
        return false;
    }
    
    centroid = self getcentroid();
    trace_width = 200;
    var_218c45f7e69d3dae = centroid;
    trace_end = var_218c45f7e69d3dae + anglestoforward( self.angles ) * 500;
    trace = trace::ray_trace( var_218c45f7e69d3dae, trace_end, self );
    var_e3413ffc094b80d9 = trace[ "fraction" ] < 1;
    
    /#
        if ( debug_melee() )
        {
            col = var_e3413ffc094b80d9 ? ( 1, 0, 0 ) : ( 0, 1, 0 );
            line( var_218c45f7e69d3dae, trace_end, col, 1, 1 );
        }
    #/
    
    if ( var_e3413ffc094b80d9 )
    {
        return false;
    }
    
    self.var_5e54a22a92a6b4f = gettime();
    return true;
}

/#

    // Namespace namespace_2200c30b7f7a871d
    // Params 0, eflags: 0x4
    // Checksum 0x918ab203, Offset: 0x393
    // Size: 0x16, Type: dev
    function private debug_melee()
    {
        return getdvarint( @"hash_580d9102a16ab90a", 0 ) > 0;
    }

#/
