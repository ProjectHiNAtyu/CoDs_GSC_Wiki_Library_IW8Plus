// script_7c98336d01c2aba2  (hash_7c98336d01c2aba2.gscc) (size: 8006 Bytes / 0x1f46 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53cd061f (1405945375)
// size ...... 8006 (0x1f46)
// includes .. 2   (offset: 0x1ec6)
// strings ... 2   (offset: 0x1ed6)
// dev strs .. 7   (offset: 0x1ef2)
// exports ... 33  (offset: 0x13a6)
// cseg ...... 0x70 + 0x1336 (0x13a6)
// imports ... 52  (offset: 0x18ce)
// animtree1 . 0   (offset: 0x1f46)
// animtree2 . 0   (offset: 0x1f46)
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_f4242316def354f7;

// Namespace namespace_f4242316def354f7
// Params 6
// Checksum 0xd10a091d, Offset: 0x8e
// Size: 0x48
function findnearbyspawnpointguaranteed( original_position, search_radius, var_d694302ae71dbd1f, score_amount_settings, var_20dd47a443f5a68f, var_76ef3e81fbf7cf60 )
{
    thread function_eb09e516ad9f9306( original_position, search_radius, var_d694302ae71dbd1f, score_amount_settings, var_20dd47a443f5a68f, var_76ef3e81fbf7cf60 );
}

// Namespace namespace_f4242316def354f7
// Params 6
// Checksum 0x8cc736c8, Offset: 0xde
// Size: 0x48
function findnearbyspawnpoint( original_position, search_radius, var_d694302ae71dbd1f, score_amount_settings, var_20dd47a443f5a68f, var_76ef3e81fbf7cf60 )
{
    thread function_5fdf84eaae9df65b( original_position, search_radius, var_d694302ae71dbd1f, score_amount_settings, var_20dd47a443f5a68f, var_76ef3e81fbf7cf60 );
}

// Namespace namespace_f4242316def354f7
// Params 3
// Checksum 0x8c9d41eb, Offset: 0x12e
// Size: 0x45
function function_de717c4405ea13b5( var_4656eeff72ef4b53, var_32508f58046be2d7, player )
{
    return function_eba1cac9e953fe77( var_4656eeff72ef4b53, var_32508f58046be2d7, 0.5, player.origin, player getplayerangles(), cos( 60 ), 16 );
}

// Namespace namespace_f4242316def354f7
// Params 0
// Checksum 0x14e20ffe, Offset: 0x17c
// Size: 0x1a
function function_819b627a62584c41()
{
    return createstruct_scoreamountsettings( 20, 10, -1, 9, 0, 1, 0, 0, -1, 0, -1 );
}

// Namespace namespace_f4242316def354f7
// Params 0
// Checksum 0x35e8edff, Offset: 0x19f
// Size: 0x1b
function function_92290a260dcb23b()
{
    return createstruct_scoreamountsettings( 200, 100, 0, 10, 0, 1, 0, 10000, 0, 1000, 0 );
}

// Namespace namespace_f4242316def354f7
// Params 6, eflags: 0x4
// Checksum 0xe7948976, Offset: 0x1c3
// Size: 0xb3
function private function_eb09e516ad9f9306( original_position, search_radius, var_d694302ae71dbd1f, score_amount_settings, var_20dd47a443f5a68f, var_76ef3e81fbf7cf60 )
{
    findnearbyspawnpoint( original_position, search_radius, var_d694302ae71dbd1f, score_amount_settings, var_20dd47a443f5a68f, var_76ef3e81fbf7cf60 );
    var_20dd47a443f5a68f waittill( #"hash_b9495af24e3775c3", selected_point );
    
    if ( !isdefined( selected_point ) )
    {
        findnearbyspawnpoint( var_d694302ae71dbd1f.player_origin, search_radius, var_d694302ae71dbd1f, score_amount_settings, var_20dd47a443f5a68f, var_76ef3e81fbf7cf60 );
        var_20dd47a443f5a68f waittill( #"hash_b9495af24e3775c3", selected_point );
    }
    
    if ( !isdefined( selected_point ) )
    {
        selected_point = var_d694302ae71dbd1f.player_origin;
    }
    
    var_20dd47a443f5a68f notify( #"hash_5c2ff3ac36ee1341", selected_point );
}

// Namespace namespace_f4242316def354f7
// Params 6, eflags: 0x4
// Checksum 0xcfa5e1c3, Offset: 0x27e
// Size: 0xec
function private function_5fdf84eaae9df65b( original_position, search_radius, var_d694302ae71dbd1f, score_amount_settings, var_20dd47a443f5a68f, var_76ef3e81fbf7cf60 = &function_ba9b4fe6ab64fc88 )
{
    offset_positions = function_58969d3dd76c7b7f( original_position, search_radius );
    function_d36a9efdc9b8e4bb( offset_positions, original_position, var_d694302ae71dbd1f, score_amount_settings, 2, var_20dd47a443f5a68f );
    scored_positions = undefined;
    var_20dd47a443f5a68f waittill( #"hash_135fb497bbc90ccc", scored_positions );
    selected_position = undefined;
    
    if ( scored_positions.size > 0 )
    {
        var_e24892419d77be3 = function_8dbd08933218621d( scored_positions );
        selected_scored_position = [[ var_76ef3e81fbf7cf60 ]]( var_e24892419d77be3 );
        
        if ( isdefined( selected_scored_position ) )
        {
            selected_position = selected_scored_position.position;
        }
    }
    
    var_20dd47a443f5a68f notify( #"hash_b9495af24e3775c3", selected_position );
    
    /#
        function_b2b94e9a6cd9b7eb( selected_position, scored_positions, original_position, var_d694302ae71dbd1f );
    #/
}

// Namespace namespace_f4242316def354f7
// Params 6
// Checksum 0xf0f177b3, Offset: 0x372
// Size: 0x48
function function_d36a9efdc9b8e4bb( offset_spawn_points, original_spawn_point, var_d694302ae71dbd1f, score_amount_settings, var_3e4e0ac9ecf747cc, var_20dd47a443f5a68f )
{
    thread function_9e9add39533fa820( offset_spawn_points, original_spawn_point, var_d694302ae71dbd1f, score_amount_settings, var_3e4e0ac9ecf747cc, var_20dd47a443f5a68f );
}

// Namespace namespace_f4242316def354f7
// Params 6, eflags: 0x4
// Checksum 0x5cc39ab1, Offset: 0x3c2
// Size: 0xdd
function private function_9e9add39533fa820( offset_spawn_points, original_spawn_point, var_d694302ae71dbd1f, score_amount_settings, var_3e4e0ac9ecf747cc, var_20dd47a443f5a68f )
{
    scored_positions = [];
    var_2b281f788e30ab00 = function_5918594658d3ffba( original_spawn_point );
    frames_waited = 0;
    
    if ( isdefined( var_2b281f788e30ab00 ) )
    {
        for ( i = 0; i < offset_spawn_points.size ; i++ )
        {
            offset_spawn_point = offset_spawn_points[ i ];
            scored_position = function_a9e41aef631cb1f9( offset_spawn_point, var_2b281f788e30ab00, var_d694302ae71dbd1f, score_amount_settings );
            
            if ( isdefined( scored_position ) )
            {
                scored_positions[ scored_positions.size ] = scored_position;
            }
            
            if ( function_3a8243eccae1229b( i, offset_spawn_points.size, var_3e4e0ac9ecf747cc ) )
            {
                frames_waited++;
                waitframe();
            }
        }
    }
    
    if ( frames_waited == 0 )
    {
        waitframe();
    }
    
    var_20dd47a443f5a68f notify( #"hash_135fb497bbc90ccc", scored_positions );
}

// Namespace namespace_f4242316def354f7
// Params 1
// Checksum 0x345105f5, Offset: 0x4a7
// Size: 0xd6
function function_8dbd08933218621d( scored_positions )
{
    var_e24892419d77be3 = [];
    highest_score = -1;
    
    foreach ( scored_position in scored_positions )
    {
        score = scored_position.score;
        
        if ( score == -1 )
        {
            continue;
        }
        
        if ( score > highest_score )
        {
            var_e24892419d77be3 = [ scored_position ];
            highest_score = score;
            continue;
        }
        
        if ( score == highest_score )
        {
            var_e24892419d77be3[ var_e24892419d77be3.size ] = scored_position;
        }
    }
    
    return var_e24892419d77be3;
}

// Namespace namespace_f4242316def354f7
// Params 1
// Checksum 0x14ad77a8, Offset: 0x586
// Size: 0x14
function function_ba9b4fe6ab64fc88( var_e24892419d77be3 )
{
    return utility::array_random( var_e24892419d77be3 );
}

// Namespace namespace_f4242316def354f7
// Params 4, eflags: 0x4
// Checksum 0x85e8ea94, Offset: 0x5a3
// Size: 0x26c
function private function_a9e41aef631cb1f9( offset_point, var_2b281f788e30ab00, var_d694302ae71dbd1f, score_amount_settings )
{
    if ( !isdefined( var_2b281f788e30ab00 ) )
    {
        println( "<dev string:x24>" );
        return;
    }
    
    var_2925544bc48cf4b4 = function_5918594658d3ffba( offset_point );
    
    if ( !isdefined( var_2925544bc48cf4b4 ) )
    {
        println( "<dev string:x95>" );
        return;
    }
    
    var_92273332a69648f = score_navtrace( var_2b281f788e30ab00, var_2925544bc48cf4b4, score_amount_settings.var_e5d0cedec0151efa, score_amount_settings.var_97f9ab240504c7e5 );
    offset_point_final = drop_to_ground( var_2925544bc48cf4b4 );
    
    if ( !isdefined( offset_point_final ) )
    {
        println( "<dev string:x104>" );
        return;
    }
    
    var_e20ec450ee911859 = score_collision( offset_point_final, var_d694302ae71dbd1f.collision_sphere_radius, var_d694302ae71dbd1f.collision_z_offset, var_d694302ae71dbd1f.var_f55b1be0e8c7454b, score_amount_settings.var_578afc0a936de1a4, score_amount_settings.var_339d36e288c6050a, score_amount_settings.var_631da543d79ed973 );
    var_43531ccb3d71eb42 = function_2ba06dec13ab7687( offset_point_final, var_d694302ae71dbd1f.player_origin, var_d694302ae71dbd1f.player_angles, var_d694302ae71dbd1f.player_fov, score_amount_settings.var_ea270c79fcb2f355, score_amount_settings.var_630a1dca736cf53a );
    var_2bccf2208ed2da34 = function_99c6ee3809d9b1b1( offset_point_final, var_d694302ae71dbd1f.player_origin, var_d694302ae71dbd1f.player_angles, score_amount_settings.var_b0a0ebd0b9462787, score_amount_settings.var_3f151c1e116fc9a0 );
    var_169595a2b23bf197 = function_9e4b679ddf01fbda( offset_point_final, var_d694302ae71dbd1f.player_origin, var_d694302ae71dbd1f.var_934f593ed1c06d97, score_amount_settings.var_3ab5e276405152b5, score_amount_settings.var_77717eda1015cd9a );
    scores = [ var_92273332a69648f.score, var_e20ec450ee911859.score, var_43531ccb3d71eb42.score, var_2bccf2208ed2da34.score, var_169595a2b23bf197.score ];
    total_score = calculate_total_score( scores );
    scored_position = function_29af79dd6f3c1cd( offset_point_final, total_score, var_92273332a69648f.computed_data, var_e20ec450ee911859.computed_data, var_169595a2b23bf197.computed_data );
    return scored_position;
}

// Namespace namespace_f4242316def354f7
// Params 7
// Checksum 0x991c270c, Offset: 0x818
// Size: 0x90
function function_eba1cac9e953fe77( collision_sphere_radius, collision_z_offset, var_f55b1be0e8c7454b, player_origin, player_angles, player_fov, var_934f593ed1c06d97 )
{
    return { #var_934f593ed1c06d97:var_934f593ed1c06d97, #player_fov:player_fov, #player_angles:player_angles, #player_origin:player_origin, #var_f55b1be0e8c7454b:var_f55b1be0e8c7454b, #collision_z_offset:collision_z_offset, #collision_sphere_radius:collision_sphere_radius };
}

// Namespace namespace_f4242316def354f7
// Params 11, eflags: 0x4
// Checksum 0x34727f78, Offset: 0x8b1
// Size: 0xe0
function private createstruct_scoreamountsettings( var_578afc0a936de1a4, var_339d36e288c6050a, var_631da543d79ed973, var_ea270c79fcb2f355, var_630a1dca736cf53a, var_b0a0ebd0b9462787, var_3f151c1e116fc9a0, var_e5d0cedec0151efa, var_97f9ab240504c7e5, var_3ab5e276405152b5, var_77717eda1015cd9a )
{
    return { #var_77717eda1015cd9a:var_77717eda1015cd9a, #var_3ab5e276405152b5:var_3ab5e276405152b5, #var_97f9ab240504c7e5:var_97f9ab240504c7e5, #var_e5d0cedec0151efa:var_e5d0cedec0151efa, #var_3f151c1e116fc9a0:var_3f151c1e116fc9a0, #var_b0a0ebd0b9462787:var_b0a0ebd0b9462787, #var_630a1dca736cf53a:var_630a1dca736cf53a, #var_ea270c79fcb2f355:var_ea270c79fcb2f355, #var_631da543d79ed973:var_631da543d79ed973, #var_339d36e288c6050a:var_339d36e288c6050a, #var_578afc0a936de1a4:var_578afc0a936de1a4 };
}

// Namespace namespace_f4242316def354f7
// Params 2, eflags: 0x4
// Checksum 0xbb4dbf0d, Offset: 0x99a
// Size: 0x2c
function private function_3a0491a22412bb3b( score, computed_data )
{
    return { #computed_data:computed_data, #score:score };
}

// Namespace namespace_f4242316def354f7
// Params 5, eflags: 0x4
// Checksum 0x3e609e3f, Offset: 0x9cf
// Size: 0x68
function private function_29af79dd6f3c1cd( position, score, nav_trace_result, collision_trace_result, var_662a99951e435daf )
{
    return { #var_662a99951e435daf:var_662a99951e435daf, #collision_trace_result:collision_trace_result, #nav_trace_result:nav_trace_result, #score:score, #position:position };
}

// Namespace namespace_f4242316def354f7
// Params 4, eflags: 0x4
// Checksum 0xb5204879, Offset: 0xa40
// Size: 0x80
function private score_navtrace( position_from, position_to, score_amount_pass, score_amount_fail )
{
    score = score_amount_fail;
    navtrace_result = navtrace( position_from, position_to, undefined, 1 );
    
    if ( !isdefined( navtrace_result ) )
    {
        score = score_amount_pass;
    }
    else
    {
        fraction = navtrace_result[ "fraction" ];
        
        if ( fraction > 0.95 )
        {
            score = score_amount_pass;
        }
    }
    
    return function_3a0491a22412bb3b( score, navtrace_result );
}

// Namespace namespace_f4242316def354f7
// Params 7, eflags: 0x4
// Checksum 0x9ee173bd, Offset: 0xac9
// Size: 0x104
function private score_collision( position, collision_sphere_radius, collision_z_offset, var_f55b1be0e8c7454b, score_amount_pass, var_288a6bd4da8df011, score_amount_fail )
{
    score = score_amount_fail;
    content = 0;
    content += trace::create_world_contents();
    content += trace::create_vehicle_contents();
    z_offset_position = position + ( 0, 0, collision_z_offset );
    sphere_trace_result = trace::sphere_trace( z_offset_position, z_offset_position, collision_sphere_radius, undefined, content, 1, 1 );
    
    if ( !isdefined( sphere_trace_result ) || sphere_trace_result[ "fraction" ] == 1 )
    {
        score = score_amount_pass;
    }
    else
    {
        hit_position = sphere_trace_result[ "position" ];
        var_b732f46aeb8a0f30 = function_74f794735e856083( position, collision_sphere_radius, hit_position );
        
        if ( var_b732f46aeb8a0f30 > 0.95 )
        {
            score = score_amount_pass;
        }
        else if ( var_b732f46aeb8a0f30 > var_f55b1be0e8c7454b )
        {
            score = var_288a6bd4da8df011;
        }
    }
    
    return function_3a0491a22412bb3b( score, sphere_trace_result );
}

// Namespace namespace_f4242316def354f7
// Params 6, eflags: 0x4
// Checksum 0xd7c2b5, Offset: 0xbd6
// Size: 0x6e
function private function_2ba06dec13ab7687( position, player_origin, player_angles, fov, score_amount_pass, score_amount_fail )
{
    score = score_amount_fail;
    is_within_fov = utility::within_fov( player_origin, player_angles, position, fov );
    
    if ( is_within_fov )
    {
        score = score_amount_pass;
    }
    
    return function_3a0491a22412bb3b( score );
}

// Namespace namespace_f4242316def354f7
// Params 5, eflags: 0x4
// Checksum 0xa3ec8f3f, Offset: 0xc4d
// Size: 0x3e
function private function_99c6ee3809d9b1b1( position, player_origin, player_angles, score_amount_pass, score_amount_fail )
{
    return function_2ba06dec13ab7687( position, player_origin, player_angles, 0, score_amount_pass, score_amount_fail );
}

// Namespace namespace_f4242316def354f7
// Params 5, eflags: 0x4
// Checksum 0x264283f8, Offset: 0xc94
// Size: 0x63
function private function_9e4b679ddf01fbda( position, player_origin, var_934f593ed1c06d97, score_amount_pass, score_amount_fail )
{
    score = score_amount_fail;
    var_662a99951e435daf = distance2d( position, player_origin );
    
    if ( var_662a99951e435daf > var_934f593ed1c06d97 )
    {
        score = score_amount_pass;
    }
    
    return function_3a0491a22412bb3b( score, var_662a99951e435daf );
}

// Namespace namespace_f4242316def354f7
// Params 2
// Checksum 0x8bac1001, Offset: 0xd00
// Size: 0xa7
function function_58969d3dd76c7b7f( position, offset_radius )
{
    offset_positions = [];
    offsets = function_2cf3f3c42d5a3999( offset_radius );
    
    foreach ( offset in offsets )
    {
        offset_positions[ offset_positions.size ] = position + offset;
    }
    
    return offset_positions;
}

// Namespace namespace_f4242316def354f7
// Params 1
// Checksum 0x846f5795, Offset: 0xdb0
// Size: 0x45
function function_2cf3f3c42d5a3999( radius )
{
    offsets = function_11ffc47973d3f0fd();
    
    for ( i = 0; i < offsets.size ; i++ )
    {
        offsets[ i ] *= radius;
    }
    
    return offsets;
}

// Namespace namespace_f4242316def354f7
// Params 1, eflags: 0x4
// Checksum 0x3a03f095, Offset: 0xdfe
// Size: 0x4c
function private function_5918594658d3ffba( position )
{
    var_6e670a8036bfd1c5 = 0;
    ground_pos = drop_to_ground( position );
    
    if ( !isdefined( ground_pos ) )
    {
        return ground_pos;
    }
    
    var_c641e39bd083fb0e = getclosestpointonnavmesh( position, undefined, undefined, undefined, var_6e670a8036bfd1c5 );
    return var_c641e39bd083fb0e;
}

// Namespace namespace_f4242316def354f7
// Params 1, eflags: 0x4
// Checksum 0xaf8de27f, Offset: 0xe53
// Size: 0x14
function private drop_to_ground( position )
{
    return getgroundposition( position, 1 );
}

// Namespace namespace_f4242316def354f7
// Params 3, eflags: 0x4
// Checksum 0xadf9c13, Offset: 0xe70
// Size: 0x37, Type: bool
function private function_3a8243eccae1229b( position_index, positions_array_size, var_3e4e0ac9ecf747cc )
{
    return position_index != 0 && position_index != positions_array_size - 1 && position_index % var_3e4e0ac9ecf747cc == 0;
}

// Namespace namespace_f4242316def354f7
// Params 1, eflags: 0x4
// Checksum 0xf0f90723, Offset: 0xeb0
// Size: 0x93
function private calculate_total_score( scores )
{
    total_score = 0;
    
    foreach ( score in scores )
    {
        if ( score == -1 )
        {
            return -1;
        }
        
        total_score += score;
    }
    
    return total_score;
}

// Namespace namespace_f4242316def354f7
// Params 3, eflags: 0x4
// Checksum 0x102e5132, Offset: 0xf4c
// Size: 0x3a
function private function_74f794735e856083( sphere_origin, sphere_radius, trace_hit_origin )
{
    hit_distance = distance2d( sphere_origin, trace_hit_origin );
    return hit_distance / float( sphere_radius );
}

// Namespace namespace_f4242316def354f7
// Params 0, eflags: 0x4
// Checksum 0xc410d644, Offset: 0xf8f
// Size: 0xcb
function private function_11ffc47973d3f0fd()
{
    var_14d764a6436b80a2 = level.var_9db11e5a8a2840b0;
    
    if ( !isdefined( var_14d764a6436b80a2 ) )
    {
        var_14d764a6436b80a2 = [];
        cos_45 = cos( 45 );
        sin_45 = sin( 45 );
        var_14d764a6436b80a2[ 0 ] = ( 1, 0, 0 );
        var_14d764a6436b80a2[ 1 ] = ( -1, 0, 0 );
        var_14d764a6436b80a2[ 2 ] = ( 0, 1, 0 );
        var_14d764a6436b80a2[ 3 ] = ( 0, -1, 0 );
        var_14d764a6436b80a2[ 4 ] = ( cos_45, sin_45, 0 );
        var_14d764a6436b80a2[ 5 ] = ( cos_45 * -1, sin_45, 0 );
        var_14d764a6436b80a2[ 6 ] = ( cos_45, sin_45 * -1, 0 );
        var_14d764a6436b80a2[ 7 ] = ( cos_45 * -1, sin_45 * -1, 0 );
        level.var_9db11e5a8a2840b0 = var_14d764a6436b80a2;
    }
    
    return var_14d764a6436b80a2;
}

/#

    // Namespace namespace_f4242316def354f7
    // Params 4, eflags: 0x4
    // Checksum 0x8ba4394c, Offset: 0x1063
    // Size: 0x71, Type: dev
    function private function_b2b94e9a6cd9b7eb( selected_position, scored_positions, original_spawn_position, var_d694302ae71dbd1f )
    {
        var_8c402de26a0ab420 = getdvarint( @"hash_eff5e2218caf8354", 0 );
        
        if ( var_8c402de26a0ab420 )
        {
            var_c0f37f28ef4a185a = getdvarint( @"hash_1ed3e490fb83235e", 999 );
            function_21fc7d0988d3e55e( selected_position, scored_positions, original_spawn_position, var_d694302ae71dbd1f, var_c0f37f28ef4a185a );
        }
    }

    // Namespace namespace_f4242316def354f7
    // Params 5, eflags: 0x4
    // Checksum 0xfa27c248, Offset: 0x10dc
    // Size: 0x211, Type: dev
    function private function_21fc7d0988d3e55e( selected_position, scored_positions, original_spawn_position, var_d694302ae71dbd1f, duration )
    {
        var_a73008dc901d4283 = ( 0, 255, 0 );
        var_da83835d32d2c11d = ( 0, 100, 100 );
        var_4f39188b955711ca = ( 0, 0, 255 );
        var_1dd4fbfdf6d631b = ( 255, 0, 255 );
        var_175d07730d778d4a = ( 255, 0, 0 );
        var_822a40f07b7956b9 = ( 255, 255, 0 );
        debug_draw( original_spawn_position, 8, var_da83835d32d2c11d, duration, "<dev string:x185>", undefined, 0.5 );
        debug_draw( function_5918594658d3ffba( original_spawn_position ), 6, var_4f39188b955711ca, duration, "<dev string:x19a>", 0, 0.5 );
        
        foreach ( scored_position in scored_positions )
        {
            if ( scored_position.position == selected_position )
            {
                color = var_a73008dc901d4283;
            }
            else if ( scored_position.score == -1 )
            {
                color = var_175d07730d778d4a;
            }
            else
            {
                color = var_1dd4fbfdf6d631b;
            }
            
            debug_draw( scored_position.position + ( 0, 0, var_d694302ae71dbd1f.collision_z_offset ), var_d694302ae71dbd1f.collision_sphere_radius, color, duration, string( scored_position.score ) );
            sphere_trace_result = scored_position.collision_trace_result;
            
            if ( sphere_trace_result[ "<dev string:x1c2>" ] < 1 )
            {
                sphere( sphere_trace_result[ "<dev string:x1cb>" ], 3, var_822a40f07b7956b9, 0, int( duration ) );
            }
        }
    }

    // Namespace namespace_f4242316def354f7
    // Params 7, eflags: 0x4
    // Checksum 0xf59e99e2, Offset: 0x12f5
    // Size: 0xb1, Type: dev
    function private debug_draw( pos, radius, color, duration, optional_text, optional_text_z_offset, optional_text_scale )
    {
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        if ( !isdefined( optional_text_z_offset ) )
        {
            optional_text_z_offset = 30;
        }
        
        if ( !isdefined( optional_text_scale ) )
        {
            optional_text_scale = 1;
        }
        
        if ( !isdefined( pos ) )
        {
            return;
        }
        
        duration = int( duration );
        sphere( pos, radius, color, 0, duration );
        sphere( pos, 3, undefined, 1, duration );
        
        if ( isdefined( optional_text ) )
        {
            print3d( pos + ( 0, 0, optional_text_z_offset ), optional_text, ( 255, 255, 255 ), 1, optional_text_scale, duration, 1 );
        }
    }

#/
