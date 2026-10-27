// script_7573db1b78c0c729  (hash_7573db1b78c0c729.gscc) (size: 8722 Bytes / 0x2212 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6fdac3d0 (1876607952)
// size ...... 8722 (0x2212)
// includes .. 1   (offset: 0x219e)
// strings ... 2   (offset: 0x21a6)
// dev strs .. 4   (offset: 0x21e2)
// exports ... 14  (offset: 0x1b1a)
// cseg ...... 0x7c + 0x1a9e (0x1b1a)
// imports ... 31  (offset: 0x1d4a)
// animtree1 . 0   (offset: 0x2212)
// animtree2 . 0   (offset: 0x2212)
#using scripts\common\trace;

#namespace zombie_aeon_navigation;

// Namespace zombie_aeon_navigation
// Params 2
// Checksum 0x76ae934a, Offset: 0x9a
// Size: 0x35f
function init_aeon_navigation( dark_heart_origin, var_8597641bb99fda7e )
{
    level endon( #"game_ended" );
    
    if ( !( getdvarint( @"hash_3a8ef2bfa46a43f2", 1 ) > 0 ) )
    {
        return;
    }
    
    voxel_size = getdvarfloat( @"hash_ba83c20aafaac380", 200 );
    padding = getdvarfloat( @"hash_ee96a14af4e81b1d", 100 );
    center_ref = dark_heart_origin;
    var_7089792ded87990b = [];
    var_7089792ded87990b[ var_7089792ded87990b.size ] = center_ref;
    
    foreach ( Holdout in var_8597641bb99fda7e )
    {
        var_7089792ded87990b[ var_7089792ded87990b.size ] = Holdout.origin;
    }
    
    min_x = var_7089792ded87990b[ 0 ][ 0 ];
    min_y = var_7089792ded87990b[ 0 ][ 1 ];
    min_z = var_7089792ded87990b[ 0 ][ 2 ];
    max_x = min_x;
    max_y = min_y;
    max_z = min_z;
    
    foreach ( point in var_7089792ded87990b )
    {
        if ( point[ 0 ] < min_x )
        {
            min_x = point[ 0 ];
        }
        
        if ( point[ 1 ] < min_y )
        {
            min_y = point[ 1 ];
        }
        
        if ( point[ 2 ] < min_z )
        {
            min_z = point[ 2 ];
        }
        
        if ( point[ 0 ] > max_x )
        {
            max_x = point[ 0 ];
        }
        
        if ( point[ 1 ] > max_y )
        {
            max_y = point[ 1 ];
        }
        
        if ( point[ 2 ] > max_z )
        {
            max_z = point[ 2 ];
        }
    }
    
    min_x -= padding;
    min_y -= padding;
    min_z -= padding;
    max_x += padding;
    max_y += padding;
    max_z += padding;
    min_pos = ( min_x, min_y, min_z );
    var_4a1adc98d589c3d4 = int( ( max_x - min_x ) / voxel_size ) + 1;
    ny = int( ( max_y - min_y ) / voxel_size ) + 1;
    nz = int( ( max_z - min_z ) / voxel_size ) + 1;
    level.aeon_nav = spawnstruct();
    level.aeon_nav.var_480e2eca8f8c574b = [];
    level.aeon_nav.min_pos = min_pos;
    level.aeon_nav.voxel_size = voxel_size;
    level.aeon_nav.var_4a1adc98d589c3d4 = var_4a1adc98d589c3d4;
    level.aeon_nav.ny = ny;
    level.aeon_nav.nz = nz;
    level.aeon_nav.var_a0925184b030c5e4 = 0;
    missileclip_contents = physics_createcontents( [ "physicscontents_missileclip" ] );
    level thread function_3cd44a0ee353289c( min_pos, var_4a1adc98d589c3d4, ny, nz, voxel_size, missileclip_contents );
}

// Namespace zombie_aeon_navigation
// Params 6, eflags: 0x4
// Checksum 0x96fb65ec, Offset: 0x401
// Size: 0x85a
function private function_3cd44a0ee353289c( min_pos, var_4a1adc98d589c3d4, ny, nz, voxel_size, missileclip_contents )
{
    level endon( #"game_ended" );
    traces_per_frame = getdvarint( @"hash_fb3c377d6dbbf224", 20 );
    obstacle_padding = getdvarint( @"hash_762335c14c9ee7cb", 1 );
    sphere_radius = voxel_size * 0.5;
    trace_count = 0;
    level.aeon_nav.sphere_radius = sphere_radius;
    level.aeon_nav.missileclip_contents = missileclip_contents;
    var_f54defac515eb0db = [];
    
    for ( iz = 0; iz < nz ; iz++ )
    {
        for ( iy = 0; iy < ny ; iy++ )
        {
            for ( ix = 0; ix < var_4a1adc98d589c3d4 ; ix++ )
            {
                world_pos = min_pos + ( ix * voxel_size, iy * voxel_size, iz * voxel_size );
                key = ix + "_" + iy + "_" + iz;
                var_df37a6b98a331c32 = trace::sphere_trace_passed( world_pos, world_pos + ( 0, 0, 0.1 ), sphere_radius, undefined, missileclip_contents );
                
                if ( var_df37a6b98a331c32 )
                {
                    voxel = spawnstruct();
                    z_offset = getdvarfloat( @"hash_ef06bac91af81aa8", -300 );
                    voxel.origin = world_pos + ( 0, 0, z_offset );
                    voxel.ix = ix;
                    voxel.iy = iy;
                    voxel.iz = iz;
                    voxel.neighbors = [];
                    level.aeon_nav.var_480e2eca8f8c574b[ key ] = voxel;
                }
                else
                {
                    blocked = spawnstruct();
                    blocked.ix = ix;
                    blocked.iy = iy;
                    blocked.iz = iz;
                    var_f54defac515eb0db[ var_f54defac515eb0db.size ] = blocked;
                }
                
                trace_count++;
                
                if ( trace_count >= traces_per_frame )
                {
                    trace_count = 0;
                    waitframe();
                }
            }
        }
    }
    
    if ( obstacle_padding > 0 )
    {
        foreach ( blocked in var_f54defac515eb0db )
        {
            for ( dy = obstacle_padding * -1; dy <= obstacle_padding ; dy++ )
            {
                for ( dx = obstacle_padding * -1; dx <= obstacle_padding ; dx++ )
                {
                    if ( dx == 0 && dy == 0 )
                    {
                        continue;
                    }
                    
                    pix = blocked.ix + dx;
                    piy = blocked.iy + dy;
                    piz = blocked.iz;
                    pad_key = pix + "_" + piy + "_" + piz;
                    
                    if ( isdefined( level.aeon_nav.var_480e2eca8f8c574b[ pad_key ] ) )
                    {
                        level.aeon_nav.var_480e2eca8f8c574b[ pad_key ] = undefined;
                    }
                }
            }
        }
    }
    
    a_offsets = [];
    a_offsets[ a_offsets.size ] = ( 1, 0, 0 );
    a_offsets[ a_offsets.size ] = ( -1, 0, 0 );
    a_offsets[ a_offsets.size ] = ( 0, 1, 0 );
    a_offsets[ a_offsets.size ] = ( 0, -1, 0 );
    a_offsets[ a_offsets.size ] = ( 0, 0, 1 );
    a_offsets[ a_offsets.size ] = ( 0, 0, -1 );
    var_c05225eadb335d26 = getarraykeys( level.aeon_nav.var_480e2eca8f8c574b );
    
    foreach ( key in var_c05225eadb335d26 )
    {
        voxel = level.aeon_nav.var_480e2eca8f8c574b[ key ];
        
        if ( !isdefined( voxel ) )
        {
            continue;
        }
        
        foreach ( offset in a_offsets )
        {
            nix = int( voxel.ix + offset[ 0 ] );
            var_8294d51d9db0c4aa = int( voxel.iy + offset[ 1 ] );
            var_8294d41d9db0c277 = int( voxel.iz + offset[ 2 ] );
            neighbor_key = nix + "_" + var_8294d51d9db0c4aa + "_" + var_8294d41d9db0c277;
            
            if ( isdefined( level.aeon_nav.var_480e2eca8f8c574b[ neighbor_key ] ) )
            {
                neighbor = level.aeon_nav.var_480e2eca8f8c574b[ neighbor_key ];
                b_connected = trace::sphere_trace_passed( voxel.origin, neighbor.origin, sphere_radius, undefined, missileclip_contents );
                
                if ( b_connected )
                {
                    voxel.neighbors[ voxel.neighbors.size ] = neighbor_key;
                }
                
                trace_count++;
                
                if ( trace_count >= traces_per_frame )
                {
                    trace_count = 0;
                    waitframe();
                }
            }
        }
    }
    
    level.aeon_nav.var_a0925184b030c5e4 = 1;
    var_5f7b46f287a5df5f = getarraykeys( level.aeon_nav.var_480e2eca8f8c574b );
    
    foreach ( key in var_5f7b46f287a5df5f )
    {
        voxel = level.aeon_nav.var_480e2eca8f8c574b[ key ];
        
        if ( !isdefined( voxel ) )
        {
            continue;
        }
        
        filtered_neighbors = [];
        
        foreach ( neighbor_key in voxel.neighbors )
        {
            if ( isdefined( level.aeon_nav.var_480e2eca8f8c574b[ neighbor_key ] ) )
            {
                filtered_neighbors[ filtered_neighbors.size ] = neighbor_key;
            }
        }
        
        voxel.neighbors = filtered_neighbors;
    }
    
    var_5f7b46f287a5df5f = getarraykeys( level.aeon_nav.var_480e2eca8f8c574b );
    
    foreach ( key in var_5f7b46f287a5df5f )
    {
        voxel = level.aeon_nav.var_480e2eca8f8c574b[ key ];
        
        if ( isdefined( voxel ) && voxel.neighbors.size == 0 )
        {
            level.aeon_nav.var_480e2eca8f8c574b[ key ] = undefined;
        }
    }
    
    /#
        if ( getdvarint( @"hash_da6a1d946a4d9c9f", 0 ) > 0 )
        {
            level thread function_79d7deb441a0cb01();
        }
    #/
}

// Namespace zombie_aeon_navigation
// Params 1, eflags: 0x4
// Checksum 0xf4c6cab, Offset: 0xc63
// Size: 0x324
function private function_d72e36d9a0e2a877( world_pos )
{
    if ( !level.aeon_nav )
    {
        return;
    }
    
    if ( !isdefined( world_pos ) )
    {
        return;
    }
    
    voxel_size = level.aeon_nav.voxel_size;
    min_pos = level.aeon_nav.min_pos;
    ix = int( ( world_pos[ 0 ] - min_pos[ 0 ] + voxel_size * 0.5 ) / voxel_size );
    iy = int( ( world_pos[ 1 ] - min_pos[ 1 ] + voxel_size * 0.5 ) / voxel_size );
    iz = int( ( world_pos[ 2 ] - min_pos[ 2 ] + voxel_size * 0.5 ) / voxel_size );
    ix = clamp( ix, 0, level.aeon_nav.var_4a1adc98d589c3d4 - 1 );
    iy = clamp( iy, 0, level.aeon_nav.ny - 1 );
    iz = clamp( iz, 0, level.aeon_nav.nz - 1 );
    key = ix + "_" + iy + "_" + iz;
    
    if ( isdefined( level.aeon_nav.var_480e2eca8f8c574b[ key ] ) )
    {
        return key;
    }
    
    var_a078d952792f8cdc = undefined;
    best_dist = 999999;
    
    for ( radius = 1; radius <= 10 ; radius++ )
    {
        for ( dz = radius * -1; dz <= radius ; dz++ )
        {
            for ( dy = radius * -1; dy <= radius ; dy++ )
            {
                for ( dx = radius * -1; dx <= radius ; dx++ )
                {
                    if ( abs( dx ) != radius && abs( dy ) != radius && abs( dz ) != radius )
                    {
                        continue;
                    }
                    
                    six = ix + dx;
                    siy = iy + dy;
                    siz = iz + dz;
                    
                    if ( six < 0 || six >= level.aeon_nav.var_4a1adc98d589c3d4 )
                    {
                        continue;
                    }
                    
                    if ( siy < 0 || siy >= level.aeon_nav.ny )
                    {
                        continue;
                    }
                    
                    if ( siz < 0 || siz >= level.aeon_nav.nz )
                    {
                        continue;
                    }
                    
                    var_3e507f152b7e813e = six + "_" + siy + "_" + siz;
                    
                    if ( isdefined( level.aeon_nav.var_480e2eca8f8c574b[ var_3e507f152b7e813e ] ) )
                    {
                        dist = distancesquared( world_pos, level.aeon_nav.var_480e2eca8f8c574b[ var_3e507f152b7e813e ].origin );
                        
                        if ( dist < best_dist )
                        {
                            best_dist = dist;
                            var_a078d952792f8cdc = var_3e507f152b7e813e;
                        }
                    }
                }
            }
        }
        
        if ( isdefined( var_a078d952792f8cdc ) )
        {
            return var_a078d952792f8cdc;
        }
    }
}

// Namespace zombie_aeon_navigation
// Params 2
// Checksum 0xc53e71ec, Offset: 0xf90
// Size: 0x2fb
function function_5bd26d02aa72e4e7( start_pos, end_pos )
{
    if ( !level.aeon_nav.var_a0925184b030c5e4 )
    {
        return;
    }
    
    start_key = function_d72e36d9a0e2a877( start_pos );
    end_key = function_d72e36d9a0e2a877( end_pos );
    
    if ( !isdefined( start_key ) || !isdefined( end_key ) )
    {
        return;
    }
    
    end_voxel = level.aeon_nav.var_480e2eca8f8c574b[ end_key ];
    end_ix = end_voxel.ix;
    end_iy = end_voxel.iy;
    end_iz = end_voxel.iz;
    
    if ( start_key == end_key )
    {
        return [ end_voxel.origin ];
    }
    
    visited = [];
    parent = [];
    queue = [];
    queue_head = 0;
    visited[ start_key ] = 1;
    queue[ queue.size ] = start_key;
    found_key = undefined;
    
    while ( queue_head < queue.size )
    {
        current_key = queue[ queue_head ];
        queue_head++;
        current_voxel = level.aeon_nav.var_480e2eca8f8c574b[ current_key ];
        
        if ( !isdefined( current_voxel ) )
        {
            continue;
        }
        
        if ( current_voxel.ix == end_ix && current_voxel.iy == end_iy && current_voxel.iz == end_iz )
        {
            found_key = current_key;
            break;
        }
        
        foreach ( neighbor_key in current_voxel.neighbors )
        {
            if ( !isdefined( visited[ neighbor_key ] ) )
            {
                visited[ neighbor_key ] = 1;
                parent[ neighbor_key ] = current_key;
                queue[ queue.size ] = neighbor_key;
            }
        }
    }
    
    if ( !isdefined( found_key ) )
    {
        /#
            if ( getdvarint( @"hash_da6a1d946a4d9c9f", 0 ) > 0 )
            {
                println( "<dev string:x24>" + start_key + "<dev string:x47>" + end_key + "<dev string:x4e>" + queue.size );
            }
        #/
        
        return;
    }
    
    path = [];
    
    for ( key = found_key; isdefined( key ) && isdefined( parent[ key ] ) ; key = parent[ key ] )
    {
        path[ path.size ] = level.aeon_nav.var_480e2eca8f8c574b[ key ].origin;
    }
    
    reversed = [];
    
    for ( i = path.size - 1; i >= 0 ; i-- )
    {
        reversed[ reversed.size ] = path[ i ];
    }
    
    return function_c9b5a5d17d8fb107( reversed );
}

// Namespace zombie_aeon_navigation
// Params 1, eflags: 0x4
// Checksum 0x128c295a, Offset: 0x1294
// Size: 0xef
function private function_c9b5a5d17d8fb107( path )
{
    if ( path.size <= 2 )
    {
        return path;
    }
    
    dir_threshold = getdvarfloat( @"hash_12f3385807736d6b", 0.85 );
    pulled = [];
    pulled[ pulled.size ] = path[ 0 ];
    anchor = 0;
    prev_dir = vectornormalize( path[ 1 ] - path[ anchor ] );
    
    for ( i = 2; i < path.size ; i++ )
    {
        cur_dir = vectornormalize( path[ i ] - path[ anchor ] );
        dot = vectordot( prev_dir, cur_dir );
        
        if ( dot < dir_threshold )
        {
            pulled[ pulled.size ] = path[ i - 1 ];
            anchor = i - 1;
            prev_dir = vectornormalize( path[ i ] - path[ anchor ] );
            continue;
        }
        
        prev_dir = cur_dir;
    }
    
    pulled[ pulled.size ] = path[ path.size - 1 ];
    return pulled;
}

// Namespace zombie_aeon_navigation
// Params 1
// Checksum 0xfe1d8d6d, Offset: 0x138c
// Size: 0x2d
function set_nav_goal( position )
{
    if ( !( getdvarint( @"hash_3a8ef2bfa46a43f2", 1 ) > 0 ) )
    {
        return;
    }
    
    self.nav_goal = position;
}

// Namespace zombie_aeon_navigation
// Params 0
// Checksum 0x6e64b03f, Offset: 0x13c1
// Size: 0x22
function function_70c8f8eedf85e0c1()
{
    if ( !( getdvarint( @"hash_3a8ef2bfa46a43f2", 1 ) > 0 ) )
    {
        return;
    }
    
    self.nav_goal = undefined;
}

// Namespace zombie_aeon_navigation
// Params 2
// Checksum 0xf4ea038c, Offset: 0x13eb
// Size: 0x56
function navigate_to( target_pos, stop_dist )
{
    if ( !( getdvarint( @"hash_3a8ef2bfa46a43f2", 1 ) > 0 ) )
    {
        return;
    }
    
    self notify( #"stop_navigation" );
    level.aeon_nav.active_aeon = self;
    thread function_ca46b08c5cfa642a( target_pos, stop_dist );
}

// Namespace zombie_aeon_navigation
// Params 0
// Checksum 0x86d726c0, Offset: 0x1449
// Size: 0x81
function navigate_to_center()
{
    if ( !( getdvarint( @"hash_3a8ef2bfa46a43f2", 1 ) > 0 ) )
    {
        return;
    }
    
    z_offset = getdvarfloat( @"hash_ef06bac91af81aa8", -300 );
    var_5290e343e7cabade = level.s_dark_heart.origin + ( 0, 0, z_offset );
    self notify( #"stop_navigation" );
    level.aeon_nav.active_aeon = self;
    thread function_ec3ff1cbe468a33d( var_5290e343e7cabade );
}

// Namespace zombie_aeon_navigation
// Params 0
// Checksum 0x656260c4, Offset: 0x14d2
// Size: 0x3f
function stop_navigation()
{
    if ( !( getdvarint( @"hash_3a8ef2bfa46a43f2", 1 ) > 0 ) )
    {
        return;
    }
    
    self notify( #"stop_navigation" );
    function_70c8f8eedf85e0c1();
    self.nav_path = undefined;
    self.nav_path_index = undefined;
}

// Namespace zombie_aeon_navigation
// Params 2, eflags: 0x4
// Checksum 0x9d784e75, Offset: 0x1519
// Size: 0x177
function private function_ca46b08c5cfa642a( target_pos, stop_dist )
{
    self endon( #"death" );
    self endon( #"stop_navigation" );
    reach_dist = getdvarfloat( @"hash_80f0ac08e4327414", 75 );
    path = function_5bd26d02aa72e4e7( self.mover.origin, target_pos );
    
    if ( !isdefined( path ) || path.size == 0 )
    {
        path = [ target_pos ];
        assertmsg( "<dev string:x59>" );
    }
    
    self.nav_path = path;
    b_stopped_early = 0;
    
    for ( i = 0; i < path.size ; i++ )
    {
        self.nav_path_index = i;
        waypoint = path[ i ];
        set_nav_goal( waypoint );
        
        while ( distance( self.mover.origin, waypoint ) > reach_dist )
        {
            if ( distance2d( self.mover.origin, target_pos ) <= stop_dist )
            {
                b_stopped_early = 1;
                break;
            }
            
            waitframe();
        }
        
        if ( b_stopped_early )
        {
            break;
        }
    }
    
    if ( b_stopped_early )
    {
        set_nav_goal( self.mover.origin );
    }
    else
    {
        set_nav_goal( target_pos );
    }
    
    self.nav_path = undefined;
    self.nav_path_index = undefined;
}

// Namespace zombie_aeon_navigation
// Params 1, eflags: 0x4
// Checksum 0x35bf2fa, Offset: 0x1698
// Size: 0x185
function private function_ec3ff1cbe468a33d( var_5290e343e7cabade )
{
    self endon( #"death" );
    self endon( #"stop_navigation" );
    reach_dist = getdvarfloat( @"hash_80f0ac08e4327414", 75 );
    var_f167d93f17687090 = getdvarfloat( @"hash_e6b484eedef6c5ce", 150 );
    path = function_5bd26d02aa72e4e7( self.mover.origin, var_5290e343e7cabade );
    
    if ( !isdefined( path ) || path.size == 0 )
    {
        self.nav_path = undefined;
        self.nav_path_index = undefined;
        set_nav_goal( var_5290e343e7cabade );
        
        while ( distance( self.mover.origin, var_5290e343e7cabade ) > var_f167d93f17687090 )
        {
            waitframe();
        }
        
        function_70c8f8eedf85e0c1();
        return;
    }
    
    self.nav_path = path;
    
    for ( i = 0; i < path.size ; i++ )
    {
        self.nav_path_index = i;
        waypoint = path[ i ];
        set_nav_goal( waypoint );
        
        while ( distance( self.mover.origin, waypoint ) > reach_dist )
        {
            waitframe();
        }
    }
    
    set_nav_goal( var_5290e343e7cabade );
    
    while ( distance( self.mover.origin, var_5290e343e7cabade ) > var_f167d93f17687090 )
    {
        waitframe();
    }
    
    function_70c8f8eedf85e0c1();
    self.nav_path = undefined;
    self.nav_path_index = undefined;
}

/#

    // Namespace zombie_aeon_navigation
    // Params 0, eflags: 0xc
    // Checksum 0x3476685e, Offset: 0x1825
    // Size: 0x2f5, Type: dev
    function private function_79d7deb441a0cb01()
    {
        self notify( #"hash_3c5e9343e0999363" );
        self endon( #"hash_3c5e9343e0999363" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_da6a1d946a4d9c9f", 0 ) <= 0 )
            {
                wait 1;
                continue;
            }
            
            var_c05225eadb335d26 = getarraykeys( level.aeon_nav.var_480e2eca8f8c574b );
            
            foreach ( key in var_c05225eadb335d26 )
            {
                voxel = level.aeon_nav.var_480e2eca8f8c574b[ key ];
                sphere( voxel.origin, 10, ( 0, 1, 0 ), 1, 1 );
                
                foreach ( neighbor_key in voxel.neighbors )
                {
                    neighbor = level.aeon_nav.var_480e2eca8f8c574b[ neighbor_key ];
                    line( voxel.origin, neighbor.origin, ( 0, 0.5, 0 ), 1, 1, 1 );
                }
            }
            
            aeon = level.aeon_nav.active_aeon;
            
            if ( isdefined( aeon ) && isdefined( aeon.nav_path ) && isdefined( aeon.nav_path_index ) )
            {
                nav_path = aeon.nav_path;
                path_idx = aeon.nav_path_index;
                
                if ( path_idx < nav_path.size )
                {
                    line( aeon.mover.origin, nav_path[ path_idx ], ( 1, 0, 0 ), 1, 1, 1 );
                    sphere( nav_path[ path_idx ], 20, ( 1, 0, 0 ), 1, 1 );
                }
                
                for ( pi = path_idx; pi < nav_path.size - 1 ; pi++ )
                {
                    line( nav_path[ pi ], nav_path[ pi + 1 ], ( 1, 1, 0 ), 1, 1, 1 );
                    sphere( nav_path[ pi + 1 ], 15, ( 1, 1, 0 ), 1, 1 );
                }
            }
            
            waitframe();
        }
    }

#/
