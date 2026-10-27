// scripts\common\math.gsc  (hash_48e70d90836f507c.gscc) (size: 20671 Bytes / 0x50bf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd4a5a30 (222976560)
// size ...... 20671 (0x50bf)
// includes .. 1   (offset: 0x4fff)
// strings ... 4   (offset: 0x5007)
// dev strs .. 10  (offset: 0x5047)
// exports ... 98  (offset: 0x346f)
// cseg ...... 0x7a + 0x33f5 (0x346f)
// imports ... 82  (offset: 0x43bf)
// animtree1 . 0   (offset: 0x50bf)
// animtree2 . 0   (offset: 0x50bf)
#using scripts\common\utility;

#namespace math;

// Namespace math
// Params 2
// Checksum 0xc9771c75, Offset: 0x98
// Size: 0x36
function anglebetweenvectors( vector1, vector2 )
{
    return acos( clamp( vectordot( vector1, vector2 ) / length( vector1 ) * length( vector2 ), -1, 1 ) );
}

// Namespace math
// Params 2
// Checksum 0xe40d083f, Offset: 0xd7
// Size: 0x28
function anglebetweenvectorsunit( v1, v2 )
{
    return acos( clamp( vectordot( v1, v2 ), -1, 1 ) );
}

// Namespace math
// Params 3
// Checksum 0xf1107cd2, Offset: 0x108
// Size: 0x83
function anglebetweenvectorssigned( vector1, vector2, reference_norm )
{
    vec1 = vectornormalize( vector1 );
    vec2 = vectornormalize( vector2 );
    angle = acos( clamp( vectordot( vec1, vec2 ), -1, 1 ) );
    cross = vectorcross( vec1, vec2 );
    
    if ( vectordot( cross, reference_norm ) < 0 )
    {
        angle *= -1;
    }
    
    return angle;
}

// Namespace math
// Params 3
// Checksum 0x4eb99f41, Offset: 0x194
// Size: 0x27
function lerp( from, to, frac )
{
    return from + ( to - from ) * frac;
}

// Namespace math
// Params 3
// Checksum 0x5040f00c, Offset: 0x1c4
// Size: 0x27
function lerp_fraction( from, to, n )
{
    return ( n - from ) / ( to - from );
}

// Namespace math
// Params 3
// Checksum 0x14c1a5bd, Offset: 0x1f4
// Size: 0x44
function smoothstep( start, end, frac )
{
    frac = clamp( frac, 0, 1 );
    return lerp( start, end, frac * frac * ( 3 - 2 * frac ) );
}

// Namespace math
// Params 3
// Checksum 0x53a2ac84, Offset: 0x241
// Size: 0x4d
function fake_slerp( from, to, fraction )
{
    return ( angle_lerp( from[ 0 ], to[ 0 ], fraction ), angle_lerp( from[ 1 ], to[ 1 ], fraction ), angle_lerp( from[ 2 ], to[ 2 ], fraction ) );
}

// Namespace math
// Params 3
// Checksum 0xc5858cb2, Offset: 0x297
// Size: 0x30
function angle_lerp( from, to, fraction )
{
    return angleclamp( from + angleclamp180( to - from ) * fraction );
}

// Namespace math
// Params 3
// Checksum 0xb5e35b20, Offset: 0x2d0
// Size: 0x55
function get_dot( start_origin, start_angles, end_origin )
{
    normal = vectornormalize( end_origin - start_origin );
    forward = anglestoforward( start_angles );
    dot = vectordot( forward, normal );
    return dot;
}

// Namespace math
// Params 2
// Checksum 0x88de605c, Offset: 0x32e
// Size: 0x2a
function vector_project_onto_plane( vector, normal )
{
    normal = vectornormalize( normal );
    return vector - vectordot( normal, vector ) * normal;
}

// Namespace math
// Params 3
// Checksum 0xbc9a23ec, Offset: 0x361
// Size: 0x67
function vector_project_endpoint( origin, angles, len )
{
    assert( isdefined( origin ) );
    assert( isdefined( angles ) );
    assert( isdefined( len ) );
    dir = anglestoforward( angles );
    dir *= len;
    end = origin + dir;
    return end;
}

// Namespace math
// Params 2
// Checksum 0xfe200b18, Offset: 0x3d1
// Size: 0x28
function vector_reflect( vector, normal )
{
    return vectornormalize( 2 * vector_project_onto_plane( vector, normal ) - vector );
}

// Namespace math
// Params 3
// Checksum 0x72ddd7ba, Offset: 0x402
// Size: 0x74
function vector_area_parallelogram( v, a, b )
{
    assert( isdefined( v ) );
    assert( isdefined( a ) );
    assert( isdefined( b ) );
    return a[ 0 ] * b[ 1 ] - a[ 1 ] * b[ 0 ] + b[ 0 ] * v[ 1 ] - v[ 0 ] * b[ 1 ] + v[ 0 ] * a[ 1 ] - a[ 0 ] * v[ 1 ];
}

// Namespace math
// Params 2
// Checksum 0x51ab2dd, Offset: 0x47f
// Size: 0x21
function scalar_projection( veca, vecb )
{
    return vectordot( vectornormalize( veca ), vecb );
}

// Namespace math
// Params 4
// Checksum 0x2f3515e7, Offset: 0x4a9
// Size: 0x86
function get_point_on_parabola( start, end, height, t )
{
    parabolic_t = t * 2 - 1;
    direction = end - start;
    up = ( 0, 0, 1 );
    result = start + t * direction;
    result += ( parabolic_t * parabolic_t * -1 + 1 ) * height * up;
    return result;
}

// Namespace math
// Params 2
// Checksum 0xc0c8bcee, Offset: 0x538
// Size: 0x1f
function get_mid_point( point_1, point_2 )
{
    return ( point_1 + point_2 ) * 0.5;
}

// Namespace math
// Params 3
// Checksum 0x2eb8dd9, Offset: 0x560
// Size: 0xe3
function round_float( value, precision, down )
{
    assert( isdefined( value ), "<dev string:x24>" );
    assert( isdefined( precision ), "<dev string:x3b>" );
    assert( precision == int( precision ), "<dev string:x56>" );
    precision = int( precision );
    
    if ( precision < 0 || precision > 4 )
    {
        assertmsg( "<dev string:x74>" + precision );
        return value;
    }
    
    decimal_offset = 1;
    
    for ( i = 1; i <= precision ; i++ )
    {
        decimal_offset *= 10;
    }
    
    value_clipped = value * decimal_offset;
    
    if ( !isdefined( down ) || down )
    {
        value_clipped = floor( value_clipped );
    }
    else
    {
        value_clipped = ceil( value_clipped );
    }
    
    value = value_clipped / decimal_offset;
    return value;
}

// Namespace math
// Params 3
// Checksum 0xd7e23635, Offset: 0x64c
// Size: 0x4a
function round_millisec_on_sec( value, precision, down )
{
    value_seconds = value / 1000;
    value_seconds = round_float( value_seconds, precision, down );
    value = value_seconds * 1000;
    return int( value );
}

// Namespace math
// Params 5
// Checksum 0x182aab95, Offset: 0x69f
// Size: 0x40
function remap( value, min1, max1, min2, max2 )
{
    return min2 + ( value - min1 ) * ( max2 - min2 ) / ( max1 - min1 );
}

// Namespace math
// Params 3
// Checksum 0x87e60e2, Offset: 0x6e8
// Size: 0x8a
function normalize_value( clamp_a, clamp_b, var_be1bef06e8004725 )
{
    if ( clamp_a > clamp_b )
    {
        upper = clamp_a;
        clamp_a = clamp_b;
        clamp_b = upper;
    }
    
    if ( var_be1bef06e8004725 > clamp_b )
    {
        return 1;
    }
    else if ( var_be1bef06e8004725 < clamp_a )
    {
        return 0;
    }
    else if ( clamp_a == clamp_b )
    {
        assertmsg( "<dev string:xc3>" + clamp_a + "<dev string:xcd>" + clamp_b + "<dev string:xd5>" );
    }
    
    return ( var_be1bef06e8004725 - clamp_a ) / ( clamp_b - clamp_a );
}

// Namespace math
// Params 3
// Checksum 0xc5be099f, Offset: 0x77b
// Size: 0x2c
function normalized_to_growth_clamps( min, max, value )
{
    return ( max - min ) * squared( value ) + min;
}

// Namespace math
// Params 3
// Checksum 0xd2ad0a6a, Offset: 0x7b0
// Size: 0x2c
function normalized_to_decay_clamps( min, max, value )
{
    return normalized_to_growth_clamps( min, max, 1 - value );
}

// Namespace math
// Params 1
// Checksum 0x7de9f06f, Offset: 0x7e5
// Size: 0x1e
function normalized_parabola( x )
{
    return -1 * squared( 2 * x - 1 ) + 1;
}

// Namespace math
// Params 1
// Checksum 0x9f99e71d, Offset: 0x80c
// Size: 0x42
function normalized_sin_wave( x )
{
    y = x * 2 * 3.14159 - 1.5708;
    y = ( sin( radians_to_degrees( y ) ) + 1 ) * 0.5;
    return y;
}

// Namespace math
// Params 1
// Checksum 0x2909959a, Offset: 0x857
// Size: 0x3c
function normalized_cos_wave( x )
{
    y = x * 2 * 3.14159;
    y = ( cos( radians_to_degrees( y ) ) + 1 ) * 0.5;
    return y;
}

// Namespace math
// Params 2
// Checksum 0x2bc7b5a5, Offset: 0x89c
// Size: 0x3a
function normalized_offset( value, offsetamount )
{
    value += offsetamount;
    
    if ( value > 1 )
    {
        value -= 1;
    }
    
    if ( value < 0 )
    {
        value += 1;
    }
    
    return value;
}

// Namespace math
// Params 1
// Checksum 0x9fef10b2, Offset: 0x8df
// Size: 0x14
function radians_to_degrees( radians )
{
    return radians * 57.2958;
}

// Namespace math
// Params 1
// Checksum 0x44328e77, Offset: 0x8fc
// Size: 0x14
function degrees_to_radians( degrees )
{
    return degrees * 0.0174533;
}

// Namespace math
// Params 3
// Checksum 0xf9a16ff3, Offset: 0x919
// Size: 0x2b
function factor_value( min_val, max_val, factor_val )
{
    return max_val * factor_val + min_val * ( 1 - factor_val );
}

// Namespace math
// Params 1
// Checksum 0x132bf46c, Offset: 0x94d
// Size: 0x5e
function normalized_float_smooth_in_out( num )
{
    if ( num < 0.5 )
    {
        num *= 2;
        num = normalized_float_smooth_in( num );
        num *= 0.5;
    }
    else
    {
        num = ( num - 0.5 ) * 2;
        num = normalized_float_smooth_out( num );
        num = num * 0.5 + 0.5;
    }
    
    return num;
}

// Namespace math
// Params 1
// Checksum 0xbcc976cb, Offset: 0x9b4
// Size: 0x10
function normalized_float_smooth_in( num )
{
    return num * num;
}

// Namespace math
// Params 1
// Checksum 0xf678f012, Offset: 0x9cd
// Size: 0x22
function normalized_float_smooth_out( num )
{
    num = 1 - num;
    num *= num;
    num = 1 - num;
    return num;
}

// Namespace math
// Params 4
// Checksum 0x3d42116b, Offset: 0x9f8
// Size: 0x8a
function line_to_plane_intersection( var_d4a14c1c2935f5ca, var_d4a14b1c2935f397, plane_point, plane_normal )
{
    d = vectordot( plane_normal, plane_point );
    ray = var_d4a14b1c2935f397 - var_d4a14c1c2935f5ca;
    var_fb8c52976cbf82f6 = vectordot( plane_normal, ray );
    
    if ( var_fb8c52976cbf82f6 == 0 )
    {
        return;
    }
    
    t = ( d - vectordot( plane_normal, var_d4a14c1c2935f5ca ) ) / var_fb8c52976cbf82f6;
    intersection_point = var_d4a14c1c2935f5ca + ray * t;
    return intersection_point;
}

// Namespace math
// Params 3
// Checksum 0x9031a0da, Offset: 0xa8b
// Size: 0x64, Type: bool
function function_47d0ed373b25c699( point, aabb_min, aabb_max )
{
    return point[ 0 ] <= aabb_max[ 0 ] && point[ 0 ] >= aabb_min[ 0 ] && point[ 1 ] <= aabb_max[ 1 ] && point[ 1 ] >= aabb_min[ 1 ] && point[ 2 ] <= aabb_max[ 2 ] && point[ 2 ] >= aabb_min[ 2 ];
}

// Namespace math
// Params 4
// Checksum 0x9db7e704, Offset: 0xaf8
// Size: 0x2a0, Type: bool
function function_7c2aa9ec56a8d304( start, end, aabb_min, aabb_max )
{
    if ( function_47d0ed373b25c699( start, aabb_min, aabb_max ) )
    {
        return true;
    }
    
    if ( function_47d0ed373b25c699( end, aabb_min, aabb_max ) )
    {
        return true;
    }
    
    dir = end - start;
    
    if ( dir[ 0 ] != 0 )
    {
        t = ( aabb_min[ 0 ] - start[ 0 ] ) / dir[ 0 ];
        
        if ( t >= 0 && t <= 1 )
        {
            hit = start + dir * t;
            
            if ( hit[ 1 ] >= aabb_min[ 1 ] && hit[ 1 ] <= aabb_max[ 1 ] && hit[ 2 ] >= aabb_min[ 2 ] && hit[ 2 ] <= aabb_max[ 2 ] )
            {
                return true;
            }
        }
        
        t = ( aabb_max[ 0 ] - start[ 0 ] ) / dir[ 0 ];
        
        if ( t >= 0 && t <= 1 )
        {
            hit = start + dir * t;
            
            if ( hit[ 1 ] >= aabb_min[ 1 ] && hit[ 1 ] <= aabb_max[ 1 ] && hit[ 2 ] >= aabb_min[ 2 ] && hit[ 2 ] <= aabb_max[ 2 ] )
            {
                return true;
            }
        }
    }
    
    if ( dir[ 1 ] != 0 )
    {
        t = ( aabb_min[ 1 ] - start[ 1 ] ) / dir[ 1 ];
        
        if ( t >= 0 && t <= 1 )
        {
            hit = start + dir * t;
            
            if ( hit[ 0 ] >= aabb_min[ 0 ] && hit[ 0 ] <= aabb_max[ 0 ] && hit[ 2 ] >= aabb_min[ 2 ] && hit[ 2 ] <= aabb_max[ 2 ] )
            {
                return true;
            }
        }
        
        t = ( aabb_max[ 1 ] - start[ 1 ] ) / dir[ 1 ];
        
        if ( t >= 0 && t <= 1 )
        {
            hit = start + dir * t;
            
            if ( hit[ 0 ] >= aabb_min[ 0 ] && hit[ 0 ] <= aabb_max[ 0 ] && hit[ 2 ] >= aabb_min[ 2 ] && hit[ 2 ] <= aabb_max[ 2 ] )
            {
                return true;
            }
        }
    }
    
    if ( dir[ 2 ] != 0 )
    {
        t = ( aabb_min[ 2 ] - start[ 2 ] ) / dir[ 2 ];
        
        if ( t >= 0 && t <= 1 )
        {
            hit = start + dir * t;
            
            if ( hit[ 0 ] >= aabb_min[ 0 ] && hit[ 0 ] <= aabb_max[ 0 ] && hit[ 1 ] >= aabb_min[ 1 ] && hit[ 1 ] <= aabb_max[ 1 ] )
            {
                return true;
            }
        }
        
        t = ( aabb_max[ 2 ] - start[ 2 ] ) / dir[ 2 ];
        
        if ( t >= 0 && t <= 1 )
        {
            hit = start + dir * t;
            
            if ( hit[ 0 ] >= aabb_min[ 0 ] && hit[ 0 ] <= aabb_max[ 0 ] && hit[ 1 ] >= aabb_min[ 1 ] && hit[ 1 ] <= aabb_max[ 1 ] )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace math
// Params 3
// Checksum 0x328f8200, Offset: 0xda1
// Size: 0x4a, Type: bool
function function_e90e382ba35d39ac( point, aabb_min, aabb_max )
{
    return point[ 0 ] <= aabb_max[ 0 ] && point[ 0 ] >= aabb_min[ 0 ] && point[ 1 ] <= aabb_max[ 1 ] && point[ 1 ] >= aabb_min[ 1 ];
}

// Namespace math
// Params 4
// Checksum 0xd767b67a, Offset: 0xdf4
// Size: 0x17b, Type: bool
function function_8e5a8180bbb2077( start, end, aabb_min, aabb_max )
{
    if ( function_e90e382ba35d39ac( start, aabb_min, aabb_max ) )
    {
        return true;
    }
    
    if ( function_e90e382ba35d39ac( end, aabb_min, aabb_max ) )
    {
        return true;
    }
    
    dir = end - start;
    
    if ( dir[ 0 ] != 0 )
    {
        t = ( aabb_min[ 0 ] - start[ 0 ] ) / dir[ 0 ];
        
        if ( t >= 0 && t <= 1 )
        {
            hit = start + dir * t;
            
            if ( hit[ 1 ] >= aabb_min[ 1 ] && hit[ 1 ] <= aabb_max[ 1 ] )
            {
                return true;
            }
        }
        
        t = ( aabb_max[ 0 ] - start[ 0 ] ) / dir[ 0 ];
        
        if ( t >= 0 && t <= 1 )
        {
            hit = start + dir * t;
            
            if ( hit[ 1 ] >= aabb_min[ 1 ] && hit[ 1 ] <= aabb_max[ 1 ] )
            {
                return true;
            }
        }
    }
    
    if ( dir[ 1 ] != 0 )
    {
        t = ( aabb_min[ 1 ] - start[ 1 ] ) / dir[ 1 ];
        
        if ( t >= 0 && t <= 1 )
        {
            hit = start + dir * t;
            
            if ( hit[ 0 ] >= aabb_min[ 0 ] && hit[ 0 ] <= aabb_max[ 0 ] )
            {
                return true;
            }
        }
        
        t = ( aabb_max[ 1 ] - start[ 1 ] ) / dir[ 1 ];
        
        if ( t >= 0 && t <= 1 )
        {
            hit = start + dir * t;
            
            if ( hit[ 0 ] >= aabb_min[ 0 ] && hit[ 0 ] <= aabb_max[ 0 ] )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace math
// Params 4
// Checksum 0xfe3fb9b7, Offset: 0xf78
// Size: 0x9b, Type: bool
function function_4cf4185ddbaca596( point, yaw, obb_center, obb_half_size )
{
    var_ce7447cbebe28d4c = anglestoaxis( ( 0, yaw, 0 ) );
    v = point - obb_center;
    return abs( vectordot( v, var_ce7447cbebe28d4c[ "forward" ] ) ) <= obb_half_size[ 0 ] && abs( vectordot( v, var_ce7447cbebe28d4c[ "right" ] ) ) <= obb_half_size[ 1 ] && abs( vectordot( v, var_ce7447cbebe28d4c[ "up" ] ) ) <= obb_half_size[ 2 ];
}

// Namespace math
// Params 4
// Checksum 0xaec7ea6a, Offset: 0x101c
// Size: 0x38
function ray_to_plane_intersection_distance( rayorigin, raydirection, var_349301d833e3afa9, planenormal )
{
    return vectordot( var_349301d833e3afa9 - rayorigin, planenormal ) / vectordot( raydirection, planenormal );
}

// Namespace math
// Params 3
// Checksum 0xb2ae05b7, Offset: 0x105d
// Size: 0x8c
function function_f0bb04c1592d3497( point_a, point_b, location )
{
    if ( distancesquared( point_a, point_b ) < 0.1 )
    {
        return distancesquared( point_a, location );
    }
    
    var_d897dee97b062905 = location - point_a;
    a_to_b = point_b - point_a;
    a_to_b_scalar = clamp( vectordot( var_d897dee97b062905, a_to_b ) / vectordot( a_to_b, a_to_b ), 0, 1 );
    closest_point = point_a + a_to_b * a_to_b_scalar;
    return lengthsquared( location - closest_point );
}

// Namespace math
// Params 3
// Checksum 0x4a783656, Offset: 0x10f2
// Size: 0x92, Type: bool
function function_5f3cda415a9be47c( point, start, end )
{
    point2d = ( point[ 0 ], point[ 1 ], 0 );
    start2d = ( start[ 0 ], start[ 1 ], 0 );
    end2d = ( end[ 0 ], end[ 1 ], 0 );
    topoint = vectornormalize( point2d - start2d );
    forward = vectornormalize( end2d - start2d );
    dot = vectordot( topoint, forward );
    return dot > 0;
}

// Namespace math
// Params 4
// Checksum 0x82fc115a, Offset: 0x118d
// Size: 0x1ed
function function_14a305b0209b352c( start, end, circlecenter, circleradius )
{
    x1 = start[ 0 ] - circlecenter[ 0 ];
    y1 = start[ 1 ] - circlecenter[ 1 ];
    x2 = end[ 0 ] - circlecenter[ 0 ];
    y2 = end[ 1 ] - circlecenter[ 1 ];
    r = float( circleradius );
    dx = x2 - x1;
    dy = y2 - y1;
    dr = dx * dx + dy * dy;
    d = x1 * y2 - x2 * y1;
    dis = r * r * dr - d * d;
    
    if ( dis < 0 )
    {
        return;
    }
    
    if ( dis == 0 )
    {
        pointx = d * dy / dr + circlecenter[ 0 ];
        pointy = -1 * d * dx / dr + circlecenter[ 1 ];
        return [ ( pointx, pointy, 0 ) ];
    }
    
    sqrtdis = sqrt( dis );
    xa = d * dy;
    xb = utility::sign( dy ) * dx * sqrtdis;
    point1x = ( xa + xb ) / dr + circlecenter[ 0 ];
    point2x = ( xa - xb ) / dr + circlecenter[ 0 ];
    ya = -1 * d * dx;
    yb = abs( dy ) * sqrtdis;
    point1y = ( ya + yb ) / dr + circlecenter[ 1 ];
    point2y = ( ya - yb ) / dr + circlecenter[ 1 ];
    return [ ( point1x, point1y, 0 ), ( point2x, point2y, 0 ) ];
}

// Namespace math
// Params 4
// Checksum 0x5dcd2f5f, Offset: 0x1382
// Size: 0xf1
function function_58dd1731345885d3( center1, radius1, center2, radius2 )
{
    distance = distance2d( center1, center2 );
    
    if ( distance >= radius1 + radius2 )
    {
        return;
    }
    
    if ( distance <= abs( radius1 - radius2 ) )
    {
        if ( radius1 < radius2 )
        {
            return { #var_f93905958736347f:1, #radius:radius1, #center:center1 };
        }
        else
        {
            return { #var_f93905958736347f:1, #radius:radius2, #center:center2 };
        }
    }
    
    maxradius = ( radius1 + radius2 - distance ) / 2;
    direction = ( center2 - center1 ) / distance;
    var_491917f3daa85d4e = center1 + direction * ( radius1 - maxradius );
    return { #radius:maxradius, #center:var_491917f3daa85d4e };
}

// Namespace math
// Params 4
// Checksum 0xdae5fafb, Offset: 0x147c
// Size: 0x107
function function_d7775bc5c201ec83( start, end, circleorigin, circleradius )
{
    result = function_14a305b0209b352c( start, end, circleorigin, circleradius );
    
    if ( !isdefined( result ) )
    {
        return;
    }
    
    if ( result.size == 1 )
    {
        if ( function_5f3cda415a9be47c( result[ 0 ], start, end ) )
        {
            return result;
        }
        
        return;
    }
    
    pt1valid = function_5f3cda415a9be47c( result[ 0 ], start, end );
    pt2valid = function_5f3cda415a9be47c( result[ 1 ], start, end );
    
    if ( !pt1valid && !pt2valid )
    {
        return;
    }
    
    if ( pt1valid && !pt2valid )
    {
        return result[ 0 ];
    }
    
    if ( pt2valid && !pt1valid )
    {
        return result[ 1 ];
    }
    
    distsq1 = distance2dsquared( start, result[ 0 ] );
    distsq2 = distance2dsquared( start, result[ 1 ] );
    
    if ( distsq1 < distsq2 )
    {
        return result[ 0 ];
    }
    
    return result[ 1 ];
}

// Namespace math
// Params 3
// Checksum 0xde2ac224, Offset: 0x158b
// Size: 0x65
function function_13baf942c4a29776( point, firstsegment, secondsegment )
{
    closestpointa = pointonsegmentnearesttopoint( firstsegment[ 0 ], firstsegment[ 1 ], point );
    closestpointb = pointonsegmentnearesttopoint( secondsegment[ 0 ], secondsegment[ 1 ], point );
    
    if ( distance2dsquared( point, closestpointa ) > distance2dsquared( point, closestpointb ) )
    {
        return closestpointa;
    }
    
    return closestpointb;
}

// Namespace math
// Params 4
// Checksum 0xa872a2ed, Offset: 0x15f9
// Size: 0x8b, Type: bool
function segmentvssphere( pointa, pointb, spherecenter, sphereradius )
{
    if ( pointa == pointb )
    {
        return false;
    }
    
    var_d643e9ac5916e2a5 = spherecenter - pointa;
    atob = pointb - pointa;
    atobscalar = clamp( vectordot( var_d643e9ac5916e2a5, atob ) / vectordot( atob, atob ), 0, 1 );
    closestpoint = pointa + atob * atobscalar;
    return lengthsquared( spherecenter - closestpoint ) <= sphereradius * sphereradius;
}

// Namespace math
// Params 8
// Checksum 0x5ed6f57c, Offset: 0x168d
// Size: 0xb6, Type: bool
function pointvscone( point, coneorigin, coneforward, coneup, conelen, conelenoffset, coneang, conehalfheight )
{
    starttopoint = point - coneorigin;
    starttopointforward = vectordot( starttopoint, coneforward );
    starttopointup = vectordot( starttopoint, coneup );
    
    if ( starttopointforward > conelen )
    {
        return false;
    }
    
    if ( starttopointforward < conelenoffset )
    {
        return false;
    }
    
    if ( isdefined( conehalfheight ) )
    {
        if ( abs( starttopointup ) > conehalfheight )
        {
            return false;
        }
    }
    
    if ( anglebetweenvectors( coneforward, starttopoint ) > coneang )
    {
        return false;
    }
    
    return true;
}

// Namespace math
// Params 4
// Checksum 0xc9251148, Offset: 0x174c
// Size: 0xd0, Type: bool
function function_8c26090d0302cda6( sphere_center, sphere_radius, box_min, box_max )
{
    closest_x = clamp( sphere_center[ 0 ], box_min[ 0 ], box_max[ 0 ] );
    closest_y = clamp( sphere_center[ 1 ], box_min[ 1 ], box_max[ 1 ] );
    closest_z = clamp( sphere_center[ 2 ], box_min[ 2 ], box_max[ 2 ] );
    dx = sphere_center[ 0 ] - closest_x;
    dy = sphere_center[ 1 ] - closest_y;
    dz = sphere_center[ 2 ] - closest_z;
    dist_sq = dx * dx + dy * dy + dz * dz;
    radius_sq = sphere_radius * sphere_radius;
    return dist_sq <= radius_sq;
}

// Namespace math
// Params 5
// Checksum 0x796c8f4e, Offset: 0x1825
// Size: 0x85, Type: bool
function pointvscylinder( point, radiussqr, height, origin, up )
{
    btwn = point - origin;
    vmag = vectordot( btwn, up );
    
    if ( vmag < 0 || vmag > height )
    {
        return false;
    }
    
    btwn -= vmag * up;
    var_bcd73deb9a8030ed = lengthsquared( btwn );
    
    if ( var_bcd73deb9a8030ed > radiussqr )
    {
        return false;
    }
    
    return true;
}

// Namespace math
// Params 4
// Checksum 0x16c2d08a, Offset: 0x18b3
// Size: 0x89, Type: bool
function function_3e18e1db2522ea75( a, b, c, d )
{
    oa = signed_area( c, d, a );
    ob = signed_area( c, d, b );
    oc = signed_area( a, b, c );
    od = signed_area( a, b, d );
    return oa * ob < 0 && oc * od < 0;
}

// Namespace math
// Params 3, eflags: 0x4
// Checksum 0xf940cf93, Offset: 0x1945
// Size: 0x2c
function private signed_area( a, b, c )
{
    return perp_dot( b - a, c - a );
}

// Namespace math
// Params 2
// Checksum 0xfb774422, Offset: 0x197a
// Size: 0x26
function perp_dot( vec_a, vec_b )
{
    return vec_a[ 0 ] * vec_b[ 1 ] - vec_a[ 1 ] * vec_b[ 0 ];
}

// Namespace math
// Params 7
// Checksum 0x66876315, Offset: 0x19a9
// Size: 0x88
function function_8e0d0a2392b676f2( time, scale_x, scale_y, scale_z, freq_a, freq_b, freq_c )
{
    x = scale_x * sin( freq_a * time );
    y = scale_y * sin( freq_b * time );
    z = scale_z * sin( freq_c * time );
    return ( x, y, z );
}

// Namespace math
// Params 3
// Checksum 0xdde94b79, Offset: 0x1a3a
// Size: 0x4a
function point_side_of_line2d( v, a, b )
{
    area = vector_area_parallelogram( v, a, b );
    
    if ( area > 0 )
    {
        return "left";
    }
    
    return "right";
}

// Namespace math
// Params 3
// Checksum 0xa83c9c6c, Offset: 0x1a8d
// Size: 0x56
function wrap( min, max, value )
{
    range_size = max - min + 1;
    
    if ( value < min )
    {
        value += range_size * int( ( min - value ) / range_size + 1 );
    }
    
    return min + ( value - min ) % range_size;
}

// Namespace math
// Params 3
// Checksum 0xf85057a9, Offset: 0x1aec
// Size: 0x76
function point_in_fov( origin, fov, checkpitch )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( !isdefined( fov ) )
    {
        fov = 0.766;
    }
    
    if ( isent( self ) && isplayer( self ) )
    {
        angles = self getplayerangles( !checkpitch );
    }
    else
    {
        angles = self.angles;
    }
    
    return withinfov( self.origin, angles, origin, fov );
}

// Namespace math
// Params 4
// Checksum 0xc612a1cd, Offset: 0x1b6b
// Size: 0x31
function within_fov_2d( start_origin, start_angles, end_origin, fov )
{
    return withinfov2d( start_origin, start_angles, end_origin, fov );
}

// Namespace math
// Params 1
// Checksum 0x5989ea0f, Offset: 0x1ba5
// Size: 0x87, Type: bool
function is_point_in_front( point )
{
    dot = 0;
    
    if ( isent( self ) && isplayer( self ) )
    {
        to_point = point - self getorigin();
        forward = anglestoforward( self getplayerangles( 1 ) );
        dot = vectordot( to_point, forward );
    }
    else
    {
        to_point = point - self.origin;
        forward = anglestoforward( self.angles );
        dot = vectordot( to_point, forward );
    }
    
    return dot > 0;
}

// Namespace math
// Params 1
// Checksum 0xb570e7e8, Offset: 0x1c35
// Size: 0x7e, Type: bool
function is_point_on_right( point )
{
    dot = 0;
    
    if ( isplayer( self ) )
    {
        to_point = point - self getorigin();
        right = anglestoright( self getplayerangles( 1 ) );
        dot = vectordot( to_point, right );
    }
    else
    {
        to_point = point - self.origin;
        right = anglestoright( self.angles );
        dot = vectordot( to_point, right );
    }
    
    return dot > 0;
}

// Namespace math
// Params 3
// Checksum 0x58e6b57f, Offset: 0x1cbc
// Size: 0x5a, Type: bool
function function_84e592007021cc09( dir, forward_vec, up_vec = ( 0, 0, 1 ) )
{
    cross = vectorcross( forward_vec, up_vec );
    dot = vectordot( cross, dir );
    return dot > 0;
}

// Namespace math
// Params 4
// Checksum 0x458a5ac0, Offset: 0x1d1f
// Size: 0xca
function function_1243a6cc6a030f2a( point, center, half_size, forward_angles )
{
    dir_to_point = point - center;
    result = center;
    axis_array = anglestoaxis( forward_angles );
    axis_vecs = [ axis_array[ "forward" ], axis_array[ "right" ], axis_array[ "up" ] ];
    
    for ( i = 0; i <= 2 ; i++ )
    {
        dist = vectordot( axis_vecs[ i ], dir_to_point );
        dist = clamp( dist, -1 * half_size[ i ], half_size[ i ] );
        result += dist * axis_vecs[ i ];
    }
    
    return result;
}

// Namespace math
// Params 3
// Checksum 0x21cbde39, Offset: 0x1df2
// Size: 0x26
function function_2e0e9b10b9c74d9e( point, segment_start, segment_end )
{
    return pointonsegmentnearesttopoint( segment_start, segment_end, point );
}

// Namespace math
// Params 3
// Checksum 0xc9ae780e, Offset: 0x1e21
// Size: 0x59
function closest_point_on_line( point, line_start, line_direction )
{
    line_direction = vectornormalize( line_direction );
    vector = point - line_start;
    projection = vectordot( vector, line_direction );
    closest_point = line_start + line_direction * projection;
    return closest_point;
}

// Namespace math
// Params 0
// Checksum 0x93d87dd9, Offset: 0x1e83
// Size: 0x27
function random_vector_2d()
{
    var_4d9b73147ea83832 = randomfloat( 360 );
    return ( cos( var_4d9b73147ea83832 ), sin( var_4d9b73147ea83832 ), 0 );
}

// Namespace math
// Params 1
// Checksum 0x59848b72, Offset: 0x1eb3
// Size: 0x58
function set_matrix_from_up( new_up )
{
    current_foward = anglestoforward( self.angles );
    new_right = vectorcross( current_foward, new_up );
    new_forward = vectorcross( new_up, new_right );
    self.angles = axistoangles( new_forward, new_right, new_up );
}

// Namespace math
// Params 2
// Checksum 0x4f454129, Offset: 0x1f13
// Size: 0x37
function set_matrix_from_up_and_angles( new_up, var_6212749e8a0bfd6e = self.angles )
{
    self.angles = build_matrix_from_up_and_angles( new_up, var_6212749e8a0bfd6e );
}

// Namespace math
// Params 2
// Checksum 0xfe2eb36e, Offset: 0x1f52
// Size: 0x6c
function build_matrix_from_up_and_angles( new_up, var_6212749e8a0bfd6e )
{
    var_4457dd7dff80535a = acos( -1 * vectordot( anglestoforward( var_6212749e8a0bfd6e ), new_up ) );
    new_forward = anglestoup( var_6212749e8a0bfd6e + ( var_4457dd7dff80535a, 0, 0 ) );
    new_right = vectorcross( new_forward, new_up );
    new_forward = vectorcross( new_up, new_right );
    return axistoangles( new_forward, new_right, new_up );
}

// Namespace math
// Params 3
// Checksum 0xff483714, Offset: 0x1fc7
// Size: 0x29
function critically_damped_move_to( target_pos, spring_factor, start_speed )
{
    thread critically_damped_move_to_thread( target_pos, spring_factor, start_speed );
}

// Namespace math
// Params 3
// Checksum 0xa051830d, Offset: 0x1ff8
// Size: 0xb8
function critically_damped_move_to_thread( target_pos, spring_factor, start_speed )
{
    self endon( #"death" );
    self endon( #"stop_spring" );
    
    if ( !isdefined( start_speed ) )
    {
        start_speed = 1;
    }
    
    spring_index = spring_make_critically_damped( spring_factor, self.origin, anglestoforward( self.angles ) * start_speed );
    
    while ( distancesquared( self.origin, target_pos ) > squared( 0.1 ) )
    {
        self.origin = spring_update( spring_index, target_pos );
        wait 0.05;
    }
    
    self notify( #"movedone" );
    spring_delete( spring_index );
}

// Namespace math
// Params 3
// Checksum 0xd9aff198, Offset: 0x20b8
// Size: 0x29
function critically_damped_move_and_rotate_to( target_pos, spring_factor, start_speed )
{
    thread critically_damped_move_and_rotate_to_thread( target_pos, spring_factor, start_speed );
}

// Namespace math
// Params 3
// Checksum 0x9d5ae19c, Offset: 0x20e9
// Size: 0xcd
function critically_damped_move_and_rotate_to_thread( target_pos, spring_factor, start_speed )
{
    self endon( #"death" );
    self endon( #"stop_spring" );
    
    if ( !isdefined( start_speed ) )
    {
        start_speed = 1;
    }
    
    spring_index = spring_make_critically_damped( spring_factor, self.origin, anglestoforward( self.angles ) * start_speed );
    
    while ( distancesquared( self.origin, target_pos ) > squared( 0.1 ) )
    {
        self.origin = spring_update( spring_index, target_pos );
        self.angles = vectortoangles( spring_get_vel( spring_index ) );
        wait 0.05;
    }
    
    self notify( #"movedone" );
    spring_delete( spring_index );
}

// Namespace math
// Params 4
// Checksum 0x5cfe3045, Offset: 0x21be
// Size: 0x8d
function function_5cf1e88395e33eba( start_point, target_point, yaw_limit, start_yaw )
{
    yaw = start_yaw;
    target_yaw = vectortoyaw( target_point - start_point );
    diff = angleclamp180( target_yaw - yaw );
    new_yaw = undefined;
    
    if ( abs( diff ) < yaw_limit )
    {
        new_yaw = target_yaw;
    }
    else
    {
        new_yaw = yaw + utility::sign( diff ) * yaw_limit;
    }
    
    return int( new_yaw );
}

// Namespace math
// Params 3
// Checksum 0xa2bc91d3, Offset: 0x2254
// Size: 0x62
function function_27800ff2fd4867c6( start_angle, target_angle, limit )
{
    diff = angleclamp180( target_angle - start_angle );
    new_angle = undefined;
    
    if ( abs( diff ) < limit )
    {
        new_angle = target_angle;
    }
    else
    {
        new_angle = start_angle + utility::sign( diff ) * limit;
    }
    
    return new_angle;
}

// Namespace math
// Params 3
// Checksum 0x91e6a188, Offset: 0x22bf
// Size: 0x6a
function function_235fe1fdb403e4b2( vector, pitch, up_vector = ( 0, 0, 1 ) )
{
    assert( vector != up_vector, "<dev string:xf0>" );
    right_vec = vectorcross( vector, up_vector );
    new_vector = rotatepointaroundvector( right_vec, vector, pitch );
    return new_vector;
}

// Namespace math
// Params 3
// Checksum 0x94d9ce06, Offset: 0x2332
// Size: 0x5e
function function_b77296185c2d6c26( start_value, target_value, limit )
{
    diff = target_value - start_value;
    new_value = undefined;
    
    if ( abs( diff ) < limit )
    {
        new_value = target_value;
    }
    else
    {
        new_value = start_value + utility::sign( diff ) * limit;
    }
    
    return new_value;
}

// Namespace math
// Params 3
// Checksum 0x7b827620, Offset: 0x2399
// Size: 0x5c
function function_b642fd3e37ae7eb4( start_vector, target_vector, limit )
{
    diff = target_vector - start_vector;
    new_vector = undefined;
    
    if ( length( diff ) < limit )
    {
        new_vector = target_vector;
    }
    else
    {
        new_vector = start_vector + vectornormalize( diff ) * limit;
    }
    
    return new_vector;
}

// Namespace math
// Params 5
// Checksum 0xabb6829b, Offset: 0x23fe
// Size: 0xb3
function function_562709d61af16bd4( center, outer_radius, inner_radius, begin_yaw, end_yaw )
{
    ratio = 0;
    
    if ( isdefined( inner_radius ) )
    {
        ratio = clamp( inner_radius / outer_radius, 0, 1 );
    }
    
    if ( !isdefined( begin_yaw ) )
    {
        begin_yaw = 0;
    }
    
    if ( !isdefined( end_yaw ) )
    {
        end_yaw = 360;
    }
    
    radius = outer_radius * sqrt( randomfloatrange( ratio * ratio, 1 ) );
    theta = randomfloatrange( begin_yaw, end_yaw );
    offset = ( cos( theta ) * radius, sin( theta ) * radius, 0 );
    return center + offset;
}

// Namespace math
// Params 4
// Checksum 0x7bcdac63, Offset: 0x24ba
// Size: 0x34
function over_damped_move_to( target_pos, spring_factor, spring_drag, start_speed )
{
    thread over_damped_move_to_thread( target_pos, spring_factor, spring_drag, start_speed );
}

// Namespace math
// Params 4
// Checksum 0x83115b9f, Offset: 0x24f6
// Size: 0xc2
function over_damped_move_to_thread( target_pos, spring_factor, spring_drag, start_speed )
{
    self endon( #"death" );
    self endon( #"stop_spring" );
    
    if ( !isdefined( start_speed ) )
    {
        start_speed = 1;
    }
    
    spring_index = spring_make_over_damped( spring_factor, spring_drag, self.origin, anglestoforward( self.angles ) * start_speed );
    
    while ( distancesquared( self.origin, target_pos ) > squared( 0.1 ) )
    {
        self.origin = spring_update( spring_index, target_pos );
        wait 0.05;
    }
    
    self notify( #"movedone" );
    spring_delete( spring_index );
}

// Namespace math
// Params 4
// Checksum 0x63c4afae, Offset: 0x25c0
// Size: 0x34
function under_damped_move_to( target_pos, freq, damp, start_speed )
{
    thread under_damped_move_to_thread( target_pos, freq, damp, start_speed );
}

// Namespace math
// Params 4
// Checksum 0x3ca41a8, Offset: 0x25fc
// Size: 0xdc
function under_damped_move_to_thread( target_pos, freq, damp, start_speed )
{
    self endon( #"death" );
    self endon( #"stop_spring" );
    
    if ( !isdefined( start_speed ) )
    {
        start_speed = 1;
    }
    
    spring_index = spring_make_under_damped( freq, damp, self.origin, anglestoforward( self.angles ) * start_speed );
    
    while ( distancesquared( self.origin, target_pos ) > squared( 0.1 ) || length( spring_get_vel( spring_index ) ) < squared( 0.1 ) )
    {
        self.origin = spring_update( spring_index, target_pos );
        wait 0.05;
    }
    
    self notify( #"movedone" );
    spring_delete( spring_index );
}

// Namespace math
// Params 3
// Checksum 0xebdd31b0, Offset: 0x26e0
// Size: 0xea
function spring_make_critically_damped( spring_factor, start_pos, start_vel )
{
    spring_index = spring_add( start_pos, start_vel );
    k = spring_factor * level.framedurationseconds;
    e = exp( -1 * k );
    level.springs[ spring_index ].c0 = ( k + 1 ) * e;
    level.springs[ spring_index ].c1 = e;
    level.springs[ spring_index ].c2 = -1 * k * k * e;
    level.springs[ spring_index ].c3 = ( 1 - k ) * e;
    spring_set_pos( spring_index, start_pos );
    spring_set_vel( spring_index, start_vel );
    return spring_index;
}

// Namespace math
// Params 4
// Checksum 0x34939186, Offset: 0x27d3
// Size: 0x1b4
function spring_make_over_damped( spring_factor, spring_drag, start_pos, start_vel )
{
    assert( spring_drag > 0 );
    spring_index = spring_add( start_pos, start_vel );
    k = spring_factor * spring_factor;
    c = -1 * sqrt( spring_drag * spring_drag + 4 * k );
    r1 = 0.5 * ( c + spring_drag );
    r2 = 0.5 * ( c - spring_drag );
    dr = r2 - r1;
    rdr = 1 / dr;
    e1 = exp( r1 * level.framedurationseconds );
    e2 = exp( r2 * level.framedurationseconds );
    de = e2 - e1;
    level.springs[ spring_index ].c1 = de * rdr;
    level.springs[ spring_index ].c0 = e1 - r1 * level.springs[ spring_index ].c1;
    level.springs[ spring_index ].c3 = ( r2 * e2 - r1 * e1 ) * rdr;
    level.springs[ spring_index ].c2 = r1 * ( e1 - level.springs[ spring_index ].c3 );
    spring_set_pos( spring_index, start_pos );
    spring_set_vel( spring_index, start_vel );
    return spring_index;
}

// Namespace math
// Params 4
// Checksum 0xd832ff1f, Offset: 0x2990
// Size: 0x16d
function spring_make_under_damped( freq, damp, start_pos, start_vel )
{
    assert( freq > 0 );
    spring_index = spring_add( start_pos, start_vel );
    h = -0.5 * damp;
    w = freq;
    e = exp( h * level.framedurationseconds ) / w;
    angle = angleclamp( w * level.framedurationseconds );
    s = sin( angle );
    c = cos( angle );
    wc = w * c;
    hs = h * s;
    level.springs[ spring_index ].c0 = e * ( wc - hs );
    level.springs[ spring_index ].c1 = e * s;
    level.springs[ spring_index ].c2 = e * -1 * s * ( h * h + w * w );
    level.springs[ spring_index ].c3 = e * ( wc + hs );
    spring_set_pos( spring_index, start_pos );
    spring_set_vel( spring_index, start_vel );
    return spring_index;
}

// Namespace math
// Params 4
// Checksum 0xdf1029b1, Offset: 0x2b06
// Size: 0x157
function spring_update( spring_index, target_pos, overwrite_pos, overwrite_vel )
{
    if ( isdefined( overwrite_pos ) )
    {
        spring_set_pos( spring_index, overwrite_pos );
    }
    
    if ( isdefined( overwrite_vel ) )
    {
        spring_set_vel( spring_index, overwrite_vel );
    }
    
    adjusted_pos = level.springs[ spring_index ].pos - target_pos;
    new_pos = level.springs[ spring_index ].c0 * adjusted_pos + level.springs[ spring_index ].c1 * level.springs[ spring_index ].vel;
    new_vel = level.springs[ spring_index ].c2 * adjusted_pos + level.springs[ spring_index ].c3 * level.springs[ spring_index ].vel;
    level.springs[ spring_index ].pos = new_pos + target_pos;
    level.springs[ spring_index ].vel = new_vel;
    return level.springs[ spring_index ].pos;
}

// Namespace math
// Params 1
// Checksum 0x3c7246d0, Offset: 0x2c66
// Size: 0x18
function spring_delete( spring_index )
{
    level.springs[ spring_index ] = undefined;
}

// Namespace math
// Params 1
// Checksum 0x98da9366, Offset: 0x2c86
// Size: 0x22
function spring_get_pos( spring_index )
{
    return level.springs[ spring_index ].pos;
}

// Namespace math
// Params 1
// Checksum 0x98da9366, Offset: 0x2cb1
// Size: 0x22
function spring_get_vel( spring_index )
{
    return level.springs[ spring_index ].vel;
}

// Namespace math
// Params 0
// Checksum 0x3dff9d26, Offset: 0x2cdc
// Size: 0x24
function spring_init()
{
    if ( !isdefined( level.springs ) )
    {
        level.springs = [];
        level.spring_count = 0;
    }
}

// Namespace math
// Params 2
// Checksum 0x8bf7cfec, Offset: 0x2d08
// Size: 0xde
function spring_add( start_pos, start_vel )
{
    spring_init();
    new_spring_index = level.spring_count;
    level.spring_count++;
    level.springs[ new_spring_index ] = spawnstruct();
    level.springs[ new_spring_index ].pos = start_pos;
    level.springs[ new_spring_index ].vel = start_vel;
    level.springs[ new_spring_index ].c0 = 0;
    level.springs[ new_spring_index ].c1 = 0;
    level.springs[ new_spring_index ].c2 = 0;
    level.springs[ new_spring_index ].c3 = 0;
    return new_spring_index;
}

// Namespace math
// Params 2
// Checksum 0xb4b2bae, Offset: 0x2def
// Size: 0x2d
function spring_set_pos( spring_index, pos )
{
    level.springs[ spring_index ].pos = pos;
}

// Namespace math
// Params 2
// Checksum 0xb4b2bae, Offset: 0x2e24
// Size: 0x2d
function spring_set_vel( spring_index, vel )
{
    level.springs[ spring_index ].vel = vel;
}

// Namespace math
// Params 4
// Checksum 0xb8c79d5d, Offset: 0x2e59
// Size: 0xcd
function random_normal_distribution( mean, std_deviation, lower_bound, upper_bound )
{
    x1 = 0;
    x2 = 0;
    w = 1;
    y1 = 0;
    
    while ( w >= 1 )
    {
        x1 = 2 * randomfloatrange( 0, 1 ) - 1;
        x2 = 2 * randomfloatrange( 0, 1 ) - 1;
        w = x1 * x1 + x2 * x2;
    }
    
    w = sqrt( -2 * log( w ) / w );
    y1 = x1 * w;
    number = mean + y1 * std_deviation;
    
    if ( number < lower_bound )
    {
        number = lower_bound;
    }
    
    if ( number > upper_bound )
    {
        number = upper_bound;
    }
    
    return number;
}

// Namespace math
// Params 2
// Checksum 0x4e46d2b1, Offset: 0x2f2f
// Size: 0x8e
function function_78a5b128a3e32460( origin, radius )
{
    assert( origin, "<dev string:x134>" );
    assert( radius > 0, "<dev string:x14b>" );
    r = sqrt( radius );
    theta = randomfloat( 360 );
    offset = ( r * cos( theta ), r * sin( theta ), 0 );
    randompoint = origin + offset;
    randompoint = getclosestpointonnavmesh( randompoint );
    return randompoint;
}

// Namespace math
// Params 4
// Checksum 0xd491cae7, Offset: 0x2fc6
// Size: 0x19d
function function_ad1b3fbc486397da( var_e2607b109a0b1419, var_56c01eedcd65f5ee, n_delta_theta, n_delta_time )
{
    var_56c01eedcd65f5ee = vectornormalize( var_56c01eedcd65f5ee );
    var_1999be4f1fd880b2 = ( cos( n_delta_theta ) + squared( var_56c01eedcd65f5ee[ 0 ] ) * ( 1 - cos( n_delta_theta ) ), var_56c01eedcd65f5ee[ 0 ] * var_56c01eedcd65f5ee[ 1 ] * ( 1 - cos( n_delta_theta ) ) - var_56c01eedcd65f5ee[ 2 ] * sin( n_delta_theta ), var_56c01eedcd65f5ee[ 0 ] * var_56c01eedcd65f5ee[ 2 ] * ( 1 - cos( n_delta_theta ) ) + var_56c01eedcd65f5ee[ 1 ] * sin( n_delta_theta ) );
    var_1999bf4f1fd882e5 = ( var_56c01eedcd65f5ee[ 1 ] * var_56c01eedcd65f5ee[ 0 ] * ( 1 - cos( n_delta_theta ) ) + var_56c01eedcd65f5ee[ 2 ] * sin( n_delta_theta ), cos( n_delta_theta ) + squared( var_56c01eedcd65f5ee[ 1 ] ) * ( 1 - cos( n_delta_theta ) ), var_56c01eedcd65f5ee[ 1 ] * var_56c01eedcd65f5ee[ 2 ] * ( 1 - cos( n_delta_theta ) - var_56c01eedcd65f5ee[ 0 ] * sin( n_delta_theta ) ) );
    var_1999bc4f1fd87c4c = ( var_56c01eedcd65f5ee[ 2 ] * var_56c01eedcd65f5ee[ 0 ] * ( 1 - cos( n_delta_theta ) ) - var_56c01eedcd65f5ee[ 1 ] * sin( n_delta_theta ), var_56c01eedcd65f5ee[ 2 ] * var_56c01eedcd65f5ee[ 1 ] * ( 1 - cos( n_delta_theta ) + var_56c01eedcd65f5ee[ 0 ] * sin( n_delta_theta ) ), cos( n_delta_theta ) + squared( var_56c01eedcd65f5ee[ 2 ] ) * ( 1 - cos( n_delta_theta ) ) );
    var_c703ee67dccce7f3 = self.origin - var_e2607b109a0b1419;
    var_3461ff8bd4ac79b9 = ( vectordot( var_1999be4f1fd880b2, var_c703ee67dccce7f3 ), vectordot( var_1999bf4f1fd882e5, var_c703ee67dccce7f3 ), vectordot( var_1999bc4f1fd87c4c, var_c703ee67dccce7f3 ) );
    v_move_to = var_e2607b109a0b1419 + var_3461ff8bd4ac79b9;
    self moveto( v_move_to, n_delta_time );
}

// Namespace math
// Params 9, eflags: 0x40 variadic
// Checksum 0xda7d0c57, Offset: 0x316b
// Size: 0x1f1
function function_2f40252ef1a28501( center, radius, num_points = 8, starting_yaw = 0, draw_debug = 0, alternate_direction = 0, valid_point_func, ... )
{
    center_x = center[ 0 ];
    center_y = center[ 1 ];
    center_z = center[ 2 ];
    yawfrac = 360 / num_points;
    
    if ( !isdefined( valid_point_func ) )
    {
        points = [];
    }
    
    /#
        if ( draw_debug )
        {
            sphere( center, 20, ( 0, 0, 0 ), 0, 50 );
        }
    #/
    
    for ( i = 0; i < num_points ; i++ )
    {
        yaw = yawfrac * i;
        
        if ( alternate_direction && i % 2 == 1 )
        {
            yaw *= -1;
        }
        
        yaw += starting_yaw;
        xadd = cos( yaw ) * radius;
        yadd = sin( yaw ) * radius;
        point = ( center_x + xadd, center_y + yadd, center_z );
        
        if ( isdefined( valid_point_func ) )
        {
            is_valid_point = [[ valid_point_func ]]( point, flat_args( vararg, varargcount ) );
            
            if ( is_valid_point )
            {
                /#
                    if ( draw_debug )
                    {
                        sphere( point, 20, ( 0, 1, 0 ), 0, 50 );
                    }
                #/
                
                return point;
            }
            
            /#
                if ( draw_debug )
                {
                    sphere( point, 20, ( 1, 0, 0 ), 0, 50 );
                }
            #/
            
            continue;
        }
        
        /#
            if ( draw_debug )
            {
                sphere( point, 20, ( 0, 0, 1 ), 0, 50 );
            }
        #/
        
        points[ points.size ] = point;
    }
    
    return points;
}

// Namespace math
// Params 2
// Checksum 0x63a29ca3, Offset: 0x3365
// Size: 0x109, Type: bool
function function_21b36082282377af( ent_a, ent_b )
{
    mid_a = ent_a getboundsmidpoint();
    half_a = ent_a getboundshalfsize();
    mid_b = ent_b getboundsmidpoint();
    half_b = ent_b getboundshalfsize();
    dist_x = abs( mid_a[ 0 ] - mid_b[ 0 ] );
    dist_y = abs( mid_a[ 1 ] - mid_b[ 1 ] );
    dist_z = abs( mid_a[ 2 ] - mid_b[ 2 ] );
    sum_x = half_a[ 0 ] + half_b[ 0 ];
    sum_y = half_a[ 1 ] + half_b[ 1 ];
    sum_z = half_a[ 2 ] + half_b[ 2 ];
    overlap_x = dist_x <= sum_x;
    overlap_y = dist_y <= sum_y;
    overlap_z = dist_z <= sum_z;
    return overlap_x && overlap_y && overlap_z;
}

