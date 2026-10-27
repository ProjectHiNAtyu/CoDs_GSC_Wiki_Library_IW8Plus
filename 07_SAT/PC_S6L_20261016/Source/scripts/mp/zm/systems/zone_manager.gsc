// scripts\mp\zm\systems\zone_manager.gsc  (hash_7b92812967b04687.gscc) (size: 33921 Bytes / 0x8481 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8000f05b (2147545179)
// size ...... 33921 (0x8481)
// includes .. 6   (offset: 0x7ee9)
// strings ... 24  (offset: 0x7f19)
// dev strs .. 70  (offset: 0x80fd)
// exports ... 78  (offset: 0x5ac1)
// cseg ...... 0x20a + 0x58b7 (0x5ac1)
// imports ... 182 (offset: 0x66f1)
// animtree1 . 0   (offset: 0x8481)
// animtree2 . 0   (offset: 0x8481)
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\zm\zm_utility;

#namespace zone_manager;

// Namespace zone_manager
// Params 0
// Checksum 0x35ff037a, Offset: 0x228
// Size: 0x1af
function init_zone_manager()
{
    assert( !isdefined( level.zone_manager ) );
    
    if ( isdefined( level.zone_manager ) )
    {
        return;
    }
    
    level.zone_manager = spawnstruct();
    level.zone_manager.defs = [];
    level.zone_manager.inited_defs = [];
    level.zone_manager.inited_defs_volumes = [];
    level.zone_manager.runtime_volumes = [];
    level.zone_manager.force_update_time = 0;
    level.zone_manager.dirty_zones = [];
    level.zone_manager.zone_distances = [];
    level.zone_manager.respawn_groups = [];
    utility::flag_init( "zone_manager_dirty" );
    utility::flag_init( "zone_setup_finished" );
    utility::flag_init( "zone_distance_dirty" );
    utility::flag_set( "zone_distance_dirty" );
    utility::registersharedfunc( #"zombie", #"hash_bad01cbc996e3dba", &function_65305a611c6226d9 );
    utility::registersharedfunc( #"zombie", #"hash_907ea089ee1bd681", &function_427ae6b3bc10b5ac );
    utility::registersharedfunc( #"ai", #"hash_97eb718c4db95479", &function_895c1f0819999b60 );
    level thread function_8d330580ebdd0fc2();
    level thread function_75849c81b2418f9b();
    level thread function_55449e31c0dd4d10();
    level thread function_5ea4dd7b73af9224();
    
    /#
        if ( getdvarint( @"debug_zone_manager", 0 ) )
        {
            set_zone_debug( 1 );
        }
        
        level thread function_a3ec39664f473fc7();
        level thread setup_zone_manager_devgui();
    #/
}

// Namespace zone_manager
// Params 1
// Checksum 0xf0d12ecb, Offset: 0x3df
// Size: 0x20d
function function_10ed552162ebaaef( zone_name )
{
    if ( !isdefined( level.zone_manager ) )
    {
        println( "<dev string:x24>" );
        return;
    }
    
    assert( !isdefined( level.zone_manager.zone_setup_finished ) );
    level endon( #"game_ended" );
    utility::flag_wait( "zone_manager_cache_ready" );
    zone_struct = level.zone_manager.defs[ zone_name ];
    
    if ( !isdefined( zone_struct ) )
    {
        println( "<dev string:x76>" + zone_name );
        return;
    }
    
    if ( isdefined( get_zone_struct( zone_name ) ) )
    {
        return;
    }
    
    /#
        debug_print( "<dev string:xcd>" + zone_name );
    #/
    
    zone_struct.is_enabled = 0;
    zone_struct.is_active = 0;
    zone_struct.var_c96b1c3cfbbd6aac = [];
    zone_struct.occupied_adjacencies = [];
    zone_struct.volumes = get_volumes( zone_struct );
    zone_struct.nodes = get_nodes( zone_struct );
    zone_struct.aabb = get_aabb( zone_struct );
    zone_struct.occupants = [];
    zone_struct.display_name = undefined;
    zone_struct.zone_name = zone_name;
    level.zone_manager.inited_defs[ zone_name ] = zone_struct;
    
    foreach ( volume in zone_struct.volumes )
    {
        level.zone_manager.inited_defs_volumes[ level.zone_manager.inited_defs_volumes.size ] = volume;
        volume.zone_struct = zone_struct;
    }
}

// Namespace zone_manager
// Params 0
// Checksum 0x5c754c33, Offset: 0x5f4
// Size: 0x55
function zone_setup_finished()
{
    assert( isdefined( level.zone_manager ) );
    utility::flag_set( "zone_setup_finished" );
    level callback::callback( "zone_setup_finished" );
    level init_zone_distance();
    level function_2eea6ffa2b383048( 1 );
    level.zone_manager.zone_setup_finished = 1;
}

// Namespace zone_manager
// Params 5
// Checksum 0x80fbad75, Offset: 0x651
// Size: 0x8a
function function_beb7a83eecf1f137( zone_a_name, zone_b_name, var_46f1327fcd04fb1e, auto_enable, var_fc469bc3c700cb92 )
{
    assert( isdefined( level.zone_manager ) );
    assert( isdefined( zone_a_name ) );
    assert( isdefined( zone_b_name ) );
    function_10ed552162ebaaef( zone_a_name );
    function_10ed552162ebaaef( zone_b_name );
    function_7fdd42f2dc036192( zone_a_name, zone_b_name, var_46f1327fcd04fb1e, auto_enable );
    
    if ( !var_fc469bc3c700cb92 )
    {
        function_7fdd42f2dc036192( zone_b_name, zone_a_name, var_46f1327fcd04fb1e, auto_enable );
    }
}

// Namespace zone_manager
// Params 4
// Checksum 0xdf34566a, Offset: 0x6e3
// Size: 0x108
function function_7fdd42f2dc036192( var_e9d4775d5eb7bc3c, adjacent_zone_name, var_46f1327fcd04fb1e, auto_enable )
{
    assert( isdefined( level.zone_manager ) );
    main_zone_struct = get_zone_struct( var_e9d4775d5eb7bc3c );
    adjacent_zone_struct = get_zone_struct( adjacent_zone_name );
    adjacent_info = undefined;
    
    if ( !( isdefined( main_zone_struct ) && isdefined( adjacent_zone_struct ) ) )
    {
        return;
    }
    
    assert( !isdefined( main_zone_struct.var_c96b1c3cfbbd6aac[ adjacent_zone_name ] ), "<dev string:xda>" + var_e9d4775d5eb7bc3c + "<dev string:xfc>" + adjacent_zone_name + "<dev string:x104>" );
    adjacent_info = spawnstruct();
    adjacent_info.var_3f0f2395ff496746 = 0;
    adjacent_info.var_46f1327fcd04fb1e = var_46f1327fcd04fb1e;
    adjacent_info.auto_enable = auto_enable;
    main_zone_struct.var_c96b1c3cfbbd6aac[ adjacent_zone_name ] = adjacent_info;
    
    if ( var_46f1327fcd04fb1e )
    {
        utility::flag_init( var_46f1327fcd04fb1e );
    }
    
    level.zone_manager thread function_2f6b1cac17447b93( main_zone_struct, adjacent_zone_struct, adjacent_info );
}

// Namespace zone_manager
// Params 2
// Checksum 0xd4b0d4fa, Offset: 0x7f3
// Size: 0x1c1
function set_zone_enabled( zone_name, enabled )
{
    assert( isdefined( level.zone_manager ) );
    zone_struct = get_zone_struct( zone_name );
    
    if ( !isdefined( zone_struct ) )
    {
        /#
            debug_print( "<dev string:x121>" + zone_name );
        #/
        
        return;
    }
    
    if ( zone_struct.is_enabled == enabled )
    {
        return;
    }
    
    zone_struct.is_enabled = enabled;
    
    if ( enabled )
    {
        level utility::flag_set( zone_name + "_enabled" );
        
        if ( isdefined( zone_struct.var_20f188d5bc4e8e30 ) )
        {
            level utility::flag_set( zone_struct.var_20f188d5bc4e8e30 );
        }
    }
    else
    {
        level utility::flag_set( zone_name + "_disabled" );
    }
    
    function_fc479cad41a1ae1d();
    zone_struct notify( #"zone_enable_changed", enabled );
    params = spawnstruct();
    params.zone_name = zone_name;
    params.zone_struct = zone_struct;
    params.enabled = enabled;
    callback::callback( "zone_enable_changed", params );
    
    if ( enabled )
    {
        foreach ( adjacent_name, adjacent in zone_struct.var_c96b1c3cfbbd6aac )
        {
            if ( adjacent.auto_enable && !adjacent.is_enabled )
            {
                set_zone_enabled( adjacent_name, 1 );
            }
        }
    }
    
    level thread function_2eea6ffa2b383048();
}

// Namespace zone_manager
// Params 1
// Checksum 0xb2965ebb, Offset: 0x9bc
// Size: 0x57
function is_zone_enabled( zone_name )
{
    assert( isdefined( level.zone_manager ) );
    zone_struct = get_zone_struct( zone_name );
    
    if ( !isdefined( zone_struct ) )
    {
        /#
            debug_print( "<dev string:x152>" + zone_name );
        #/
        
        return;
    }
    
    return zone_struct.is_enabled;
}

// Namespace zone_manager
// Params 1
// Checksum 0xdbadf079, Offset: 0xa1c
// Size: 0xcf
function function_f9e008bb6267b256( substr )
{
    assert( isdefined( level.zone_manager ) );
    var_aa6a7d050293c5f2 = [];
    
    foreach ( zone_name, zone_struct in level.zone_manager.inited_defs )
    {
        if ( issubstr( zone_name, substr ) && zone_struct.is_enabled )
        {
            set_zone_enabled( zone_name, 0 );
            var_aa6a7d050293c5f2[ var_aa6a7d050293c5f2.size ] = zone_name;
        }
    }
    
    return var_aa6a7d050293c5f2;
}

// Namespace zone_manager
// Params 2
// Checksum 0x1f465a7c, Offset: 0xaf4
// Size: 0x136
function set_zone_active( zone_name, active )
{
    assert( isdefined( level.zone_manager ) );
    zone_struct = get_zone_struct( zone_name );
    
    if ( !isdefined( zone_struct ) )
    {
        /#
            debug_print( "<dev string:x187>" + zone_name );
        #/
        
        return;
    }
    
    if ( zone_struct.is_active == active )
    {
        return;
    }
    
    zone_struct.is_active = active;
    
    if ( active )
    {
        level utility::flag_set( zone_name + "_active" );
        
        if ( isdefined( zone_struct.var_aee8766760082165 ) )
        {
            level utility::flag_set( zone_struct.var_aee8766760082165 );
        }
    }
    else
    {
        level utility::flag_clear( zone_name + "_active" );
        
        if ( isdefined( zone_struct.var_aee8766760082165 ) )
        {
            level utility::flag_clear( zone_struct.var_aee8766760082165 );
        }
    }
    
    zone_struct notify( #"zone_active_changed", active );
    params = spawnstruct();
    params.zone_name = zone_name;
    params.zone_struct = zone_struct;
    params.active = active;
    callback::callback( "zone_active_changed", params );
}

// Namespace zone_manager
// Params 1
// Checksum 0x165c79a8, Offset: 0xc32
// Size: 0x3c
function get_zone_struct( zone_name )
{
    assert( isdefined( level.zone_manager ) );
    
    if ( !isdefined( zone_name ) )
    {
        return;
    }
    
    return level.zone_manager.inited_defs[ zone_name ];
}

// Namespace zone_manager
// Params 1
// Checksum 0xa9ce972f, Offset: 0xc77
// Size: 0x33
function function_2bcd755aabfd3cad( zone_struct )
{
    assert( isdefined( zone_struct ) );
    
    if ( !isdefined( zone_struct.script_zone_name ) )
    {
        return;
    }
    
    return zone_struct.script_zone_name;
}

// Namespace zone_manager
// Params 0
// Checksum 0xec1484ec, Offset: 0xcb3
// Size: 0x27
function get_inited_zones()
{
    assert( isdefined( level.zone_manager ) );
    return level.zone_manager.inited_defs;
}

// Namespace zone_manager
// Params 0
// Checksum 0xc8a34e23, Offset: 0xce3
// Size: 0x33
function get_all_zones()
{
    assert( isdefined( level.zone_manager ) );
    utility::flag_wait( "zone_manager_cache_ready" );
    return level.zone_manager.defs;
}

// Namespace zone_manager
// Params 0
// Checksum 0x5574355a, Offset: 0xd1f
// Size: 0xbc
function get_active_zones()
{
    assert( isdefined( level.zone_manager ) );
    utility::flag_waitopen( "zone_manager_dirty" );
    active_zones = [];
    
    foreach ( zone_struct in level.zone_manager.inited_defs )
    {
        if ( zone_struct.is_active )
        {
            active_zones[ active_zones.size ] = zone_struct;
        }
    }
    
    return active_zones;
}

// Namespace zone_manager
// Params 0
// Checksum 0xa51aeeb2, Offset: 0xde4
// Size: 0xbc
function get_enabled_zones()
{
    assert( isdefined( level.zone_manager ) );
    utility::flag_waitopen( "zone_manager_dirty" );
    enabled_zones = [];
    
    foreach ( zone_struct in level.zone_manager.inited_defs )
    {
        if ( zone_struct.is_enabled )
        {
            enabled_zones[ enabled_zones.size ] = zone_struct;
        }
    }
    
    return enabled_zones;
}

// Namespace zone_manager
// Params 2
// Checksum 0x4fab9cf, Offset: 0xea9
// Size: 0x136
function get_current_zone( force_update, check_all_zones )
{
    assert( isdefined( level.zone_manager ) );
    valid_pos_dist = 4;
    check_all_zones = istrue( check_all_zones );
    
    if ( isplayer( self ) && !isdefined( self.var_511369c75f53601c ) )
    {
        thread function_511369c75f53601c();
    }
    
    if ( force_update )
    {
        update_current_zone( 1, check_all_zones );
    }
    else if ( !isdefined( self.cached_zone_info ) )
    {
        update_current_zone( 0, check_all_zones );
    }
    else if ( self.cached_zone_info.var_71926f64e81b08dd < level.zone_manager.force_update_time )
    {
        update_current_zone( 1, check_all_zones );
    }
    else if ( distancesquared( self.cached_zone_info.valid_pos, self.origin ) > valid_pos_dist )
    {
        update_current_zone( 0, check_all_zones );
    }
    else if ( self.cached_zone_info.check_all_zones != check_all_zones )
    {
        update_current_zone( 0, check_all_zones );
    }
    
    if ( !isdefined( self.cached_zone_info ) )
    {
        return;
    }
    
    return self.cached_zone_info.zone_struct;
}

// Namespace zone_manager
// Params 2
// Checksum 0x65bcb405, Offset: 0xfe8
// Size: 0xdd
function get_adjacent_zones( exclude_disabled, var_7cee52120d1f014d )
{
    var_c96b1c3cfbbd6aac = [];
    
    foreach ( zone_name, adjacent_info in self.var_c96b1c3cfbbd6aac )
    {
        zone_struct = get_zone_struct( zone_name );
        
        if ( isdefined( zone_struct ) && ( !exclude_disabled || zone_struct.is_enabled ) && ( !var_7cee52120d1f014d || adjacent_info.var_3f0f2395ff496746 ) )
        {
            var_c96b1c3cfbbd6aac[ var_c96b1c3cfbbd6aac.size ] = zone_struct;
        }
    }
    
    return var_c96b1c3cfbbd6aac;
}

// Namespace zone_manager
// Params 1
// Checksum 0x15e8f43d, Offset: 0x10ce
// Size: 0x41, Type: bool
function get_zone_occupants( zone_name )
{
    assert( isdefined( level.zone_manager ) );
    zone_struct = get_zone_struct( zone_name );
    return zone_struct.occupants ?? [];
}

// Namespace zone_manager
// Params 1
// Checksum 0x927fd21c, Offset: 0x1118
// Size: 0xc9
function function_d4fdae6556d1e5be( callout_ref )
{
    assert( isdefined( level.zone_manager ) );
    occupants = [];
    
    foreach ( zone in level.zone_manager.defs )
    {
        if ( zone.display_name == callout_ref )
        {
            occupants = arraycombine( occupants, zone.occupants );
        }
    }
    
    return occupants;
}

// Namespace zone_manager
// Params 1
// Checksum 0x2a3360d0, Offset: 0x11ea
// Size: 0xfa
function function_f6f925c185a652c( ent )
{
    assert( isdefined( level.zone_manager ) );
    zone_info = ent get_current_zone();
    occupants = get_zone_occupants( zone_info.script_zone_name );
    var_4d5b23254c377e5f = zone_info get_adjacent_zones();
    
    foreach ( zone_struct in var_4d5b23254c377e5f )
    {
        occupants = arraycombineunique( occupants, get_zone_occupants( zone_struct.script_zone_name ) );
    }
    
    occupants = arraycombineunique( occupants, function_d4fdae6556d1e5be( zone_info.display_name ) );
    return occupants;
}

// Namespace zone_manager
// Params 1
// Checksum 0x3811090f, Offset: 0x12ed
// Size: 0x129
function function_9dd25e9fb0ecd45b( zone_name )
{
    assert( isdefined( level.zone_manager ) );
    var_494e0a8e02253114 = level.zone_manager.respawn_groups[ zone_name ];
    current_zone = get_zone_struct( zone_name );
    
    if ( !isdefined( var_494e0a8e02253114 ) )
    {
        min_dist = 99999;
        var_a2dbf16edca3f091 = [];
        
        foreach ( index, respawn_group in level.zone_manager.respawn_groups )
        {
            zone_dist = get_zone_distance( current_zone.zone_name, index );
            
            if ( zone_dist < min_dist )
            {
                min_dist = zone_dist;
                var_a2dbf16edca3f091 = respawn_group;
            }
        }
        
        if ( min_dist < 99999 )
        {
            return var_a2dbf16edca3f091;
        }
        
        return [];
    }
    
    return var_494e0a8e02253114;
}

// Namespace zone_manager
// Params 0, eflags: 0x4
// Checksum 0x5d873dfb, Offset: 0x141f
// Size: 0x20c
function private init_zone_distance()
{
    var_cfdcb332178e0755 = get_all_zones();
    
    foreach ( zone in var_cfdcb332178e0755 )
    {
        level.zone_manager.zone_distances[ zone.zone_name ] = [];
        level.zone_manager.zone_distances[ zone.zone_name ][ zone.zone_name ] = 0;
        
        foreach ( other_zone in var_cfdcb332178e0755 )
        {
            level.zone_manager.zone_distances[ zone.zone_name ][ other_zone.zone_name ] = 99999;
        }
        
        var_c96b1c3cfbbd6aac = zone get_adjacent_zones( 1, 1 );
        
        foreach ( var_1211cf94fc6a6c76 in var_c96b1c3cfbbd6aac )
        {
            level.zone_manager.zone_distances[ zone.zone_name ][ var_1211cf94fc6a6c76.zone_name ] = 1;
        }
    }
}

// Namespace zone_manager
// Params 1
// Checksum 0x21989f2a, Offset: 0x1633
// Size: 0x2c7
function function_2eea6ffa2b383048( force_update )
{
    self notify( #"hash_a4898a147427e961" );
    self endon( #"hash_a4898a147427e961" );
    level endon( #"game_ended" );
    utility::flag_set( "zone_distance_dirty" );
    
    if ( !force_update )
    {
        waittillframeend();
    }
    
    if ( !isdefined( level.zone_manager.visited_id ) )
    {
        level.zone_manager.visited_id = 0;
    }
    
    var_cfdcb332178e0755 = get_all_zones();
    queue = utility::queue_create( var_cfdcb332178e0755.size );
    
    foreach ( first_zone in var_cfdcb332178e0755 )
    {
        level.zone_manager.visited_id++;
        visited_id = level.zone_manager.visited_id;
        first_zone.visited_id = visited_id;
        level.zone_manager.zone_distances[ first_zone.zone_name ][ first_zone.zone_name ] = 0;
        utility::queue_enqueue( queue, first_zone );
        
        while ( utility::queue_size( queue ) > 0 )
        {
            curr_zone = utility::queue_peek( queue );
            curr_dist = level.zone_manager.zone_distances[ first_zone.zone_name ][ curr_zone.zone_name ];
            queue = utility::queue_dequeue( queue );
            var_c96b1c3cfbbd6aac = curr_zone get_adjacent_zones( 1, 1 );
            
            foreach ( var_1211cf94fc6a6c76 in var_c96b1c3cfbbd6aac )
            {
                if ( var_1211cf94fc6a6c76.visited_id != visited_id )
                {
                    var_1211cf94fc6a6c76.visited_id = visited_id;
                    adj_dist = curr_dist + 1;
                    level.zone_manager.zone_distances[ first_zone.zone_name ][ var_1211cf94fc6a6c76.zone_name ] = adj_dist;
                    utility::queue_enqueue( queue, var_1211cf94fc6a6c76 );
                }
            }
        }
        
        if ( !force_update )
        {
            waitframe();
        }
    }
    
    utility::flag_clear( "zone_distance_dirty" );
}

// Namespace zone_manager
// Params 1
// Checksum 0x90104f47, Offset: 0x1902
// Size: 0x50, Type: bool
function is_water_zone( var_3c85708e694a32b2 )
{
    assert( isdefined( level.zone_manager ) );
    zone_struct = var_3c85708e694a32b2;
    
    if ( isstring( var_3c85708e694a32b2 ) )
    {
        zone_struct = get_zone_struct( var_3c85708e694a32b2 );
    }
    
    return zone_struct.script_label == "water";
}

// Namespace zone_manager
// Params 2
// Checksum 0x3a741671, Offset: 0x195b
// Size: 0x164, Type: bool
function is_touching_zone( var_3c85708e694a32b2, entity )
{
    assert( isdefined( level.zone_manager ) );
    
    if ( !isdefined( entity ) )
    {
        entity = self;
    }
    
    zone_struct = var_3c85708e694a32b2;
    
    if ( isstring( var_3c85708e694a32b2 ) )
    {
        zone_struct = get_zone_struct( var_3c85708e694a32b2 );
    }
    
    if ( isdefined( zone_struct.aabb ) && is_touching_aabb( entity, zone_struct.aabb ) && entity getistouchingentities( zone_struct.volumes ).size )
    {
        return true;
    }
    
    foreach ( noent_volume in zone_struct.noent_volumes ?? [] )
    {
        if ( entity istouching( noent_volume ) )
        {
            return true;
        }
    }
    
    if ( !isdefined( entity ) )
    {
        return false;
    }
    
    var_693363986810ef2c = entity.last_valid_position ?? entity.origin;
    navmesh_zone = function_ac62281be3d43322( var_693363986810ef2c, entity );
    
    if ( navmesh_zone === zone_struct.zone_name )
    {
        return true;
    }
    
    return false;
}

// Namespace zone_manager
// Params 2
// Checksum 0x7023f3fc, Offset: 0x1ac8
// Size: 0xc7
function function_984e2bf699c3c42a( var_3c85708e694a32b2, noent_volume )
{
    assert( isdefined( level.zone_manager ) );
    
    if ( !isdefined( entity ) )
    {
        entity = self;
    }
    
    zone_struct = var_3c85708e694a32b2;
    
    if ( isstring( var_3c85708e694a32b2 ) )
    {
        zone_struct = get_zone_struct( var_3c85708e694a32b2 );
    }
    
    noent_volume.zone_struct = zone_struct;
    
    if ( !isdefined( zone_struct.noent_volumes ) )
    {
        zone_struct.noent_volumes = [];
    }
    
    zone_struct.noent_volumes[ zone_struct.noent_volumes.size ] = noent_volume;
    level.zone_manager.runtime_volumes[ level.zone_manager.runtime_volumes.size ] = noent_volume;
}

// Namespace zone_manager
// Params 2
// Checksum 0x8bdf6403, Offset: 0x1b97
// Size: 0xa3
function location_in_zone( origin, var_3c85708e694a32b2 )
{
    assert( isdefined( level.zone_manager ) );
    
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( !isdefined( level.zone_manager.var_44c70a7b3edb09f8 ) )
    {
        level.zone_manager.var_44c70a7b3edb09f8 = utility::spawn_tag_origin( origin );
    }
    
    level.zone_manager.var_44c70a7b3edb09f8.origin = origin;
    
    if ( is_touching_zone( var_3c85708e694a32b2, level.zone_manager.var_44c70a7b3edb09f8 ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace zone_manager
// Params 1
// Checksum 0x18f398e9, Offset: 0x1c43
// Size: 0x97
function function_90e5c3e2272b0130( origin )
{
    assert( isdefined( level.zone_manager ) );
    
    if ( !isvector( origin ) )
    {
        return;
    }
    
    if ( !isdefined( level.zone_manager.var_44c70a7b3edb09f8 ) )
    {
        level.zone_manager.var_44c70a7b3edb09f8 = utility::spawn_script_origin( origin );
    }
    
    level.zone_manager.var_44c70a7b3edb09f8.origin = origin;
    return level.zone_manager.var_44c70a7b3edb09f8 get_current_zone( 0, 1 );
}

// Namespace zone_manager
// Params 2
// Checksum 0x19b85023, Offset: 0x1ce3
// Size: 0xc4
function function_ac62281be3d43322( origin, var_b58cf62a07005be8 )
{
    if ( isdefined( var_b58cf62a07005be8 ) )
    {
        if ( origin == var_b58cf62a07005be8.var_4a12c10c3e90591f )
        {
            return ( var_b58cf62a07005be8.var_c713f483656fb3dd.var_6f9c4e415e80942f ?? undefined );
        }
    }
    
    calculated_tacpoint = function_ca7cf96e29e5999f( origin, var_b58cf62a07005be8 );
    calculated_zone = calculated_tacpoint.var_6f9c4e415e80942f ?? undefined;
    
    if ( isdefined( var_b58cf62a07005be8 ) )
    {
        if ( isdefined( calculated_zone ) )
        {
            var_b58cf62a07005be8.var_c713f483656fb3dd = calculated_tacpoint;
        }
        
        var_b58cf62a07005be8.var_c713f483656fb3dd = isdefined( calculated_zone ) ? calculated_tacpoint : undefined;
        var_b58cf62a07005be8.var_27d115e77227d08 = calculated_zone;
        var_b58cf62a07005be8.var_4a12c10c3e90591f = origin;
    }
    
    return calculated_zone;
}

// Namespace zone_manager
// Params 2, eflags: 0x4
// Checksum 0xdb89c482, Offset: 0x1db0
// Size: 0x157
function private function_ca7cf96e29e5999f( origin, var_b58cf62a07005be8 )
{
    closest_tacpoint = function_a4a0660084b84def( origin, 1 );
    
    if ( !isdefined( closest_tacpoint ) )
    {
        return;
    }
    
    zone_struct = get_zone_struct( closest_tacpoint.var_6f9c4e415e80942f );
    
    if ( isdefined( var_b58cf62a07005be8 ) && !( var_b58cf62a07005be8 === level.zone_manager.var_44c70a7b3edb09f8 ) )
    {
        if ( !isdefined( zone_struct ) || !zone_struct.is_enabled )
        {
            var_696abb1a7cc0f5fb = squared( 200 );
            
            if ( isdefined( var_b58cf62a07005be8.var_c713f483656fb3dd ) && distance2dsquared( origin, var_b58cf62a07005be8.var_c713f483656fb3dd.origin ) < var_696abb1a7cc0f5fb )
            {
                return var_b58cf62a07005be8.var_c713f483656fb3dd;
            }
        }
    }
    
    if ( !zone_struct.is_enabled && isplayer( var_b58cf62a07005be8 ) )
    {
        tacpoint_offset = closest_tacpoint.origin - origin;
        var_b1d15617ea370a9b = origin - tacpoint_offset;
        var_85e6c5eda772549 = function_a4a0660084b84def( var_b1d15617ea370a9b, 1 );
        var_db98d23cb037b271 = get_zone_struct( var_85e6c5eda772549.var_6f9c4e415e80942f );
        
        if ( var_db98d23cb037b271.is_enabled )
        {
            return var_85e6c5eda772549;
        }
    }
    
    if ( isdefined( zone_struct ) )
    {
        return closest_tacpoint;
    }
}

// Namespace zone_manager
// Params 0, eflags: 0xc
// Checksum 0xa3fd077e, Offset: 0x1f10
// Size: 0xff
function private function_97e99f0b47c3ab55()
{
    self notify( #"hash_411710a38be9d4cc" );
    self endon( #"hash_411710a38be9d4cc" );
    assert( isdefined( level.zone_manager ) );
    assert( level.zone_manager.zone_setup_finished, "<dev string:x1b8>" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.players ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            player get_current_zone();
            waitframe();
        }
        
        wait 0.2;
    }
}

// Namespace zone_manager
// Params 0, eflags: 0xc
// Checksum 0x5fac756c, Offset: 0x2017
// Size: 0x39d
function private function_f029e29824b3298e()
{
    self notify( #"hash_afa00e2b0f95e26f" );
    self endon( #"hash_afa00e2b0f95e26f" );
    assert( isdefined( level.zone_manager ) );
    assert( level.zone_manager.zone_setup_finished, "<dev string:x222>" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.players ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player update_current_zone( 1 );
                waitframe();
            }
        }
        
        utility::flag_waitopen( "zone_manager_dirty" );
        players = [];
        var_374ce6fb82545607 = [];
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && isdefined( player.cached_zone_info.zone_struct ) )
            {
                entnum = player getentitynumber();
                players[ entnum ] = player;
                var_374ce6fb82545607[ entnum ] = player.cached_zone_info.zone_struct;
            }
        }
        
        foreach ( zone_struct in level.zone_manager.inited_defs )
        {
            foreach ( entnum, occupant in zone_struct.occupants )
            {
                if ( !isdefined( var_374ce6fb82545607[ entnum ] ) || var_374ce6fb82545607[ entnum ].zone_name != zone_struct.zone_name )
                {
                    zone_struct.occupants[ entnum ] = undefined;
                    function_a743e767d62bb311( zone_struct );
                    level function_89cd44b33550b3d5( zone_struct );
                    continue;
                }
                
                assert( zone_struct.occupants[ entnum ] == players[ entnum ] );
                var_374ce6fb82545607[ entnum ] = undefined;
            }
        }
        
        foreach ( entnum, zone_struct in var_374ce6fb82545607 )
        {
            zone_struct.occupants[ entnum ] = players[ entnum ];
            function_a743e767d62bb311( zone_struct );
            level function_89cd44b33550b3d5( zone_struct );
        }
        
        wait 10;
    }
}

// Namespace zone_manager
// Params 0
// Checksum 0x33a328c3, Offset: 0x23bc
// Size: 0x2c
function function_fc479cad41a1ae1d()
{
    assert( isdefined( level.zone_manager ) );
    level.zone_manager.force_update_time = gettime();
}

// Namespace zone_manager
// Params 2
// Checksum 0xd293a77a, Offset: 0x23f0
// Size: 0xca
function get_zone_distance( var_19ca62a759aa2e8c, var_19ca65a759aa3525 )
{
    if ( !( isdefined( var_19ca62a759aa2e8c ) && isdefined( var_19ca65a759aa3525 ) ) )
    {
        return;
    }
    
    zone_name_1 = var_19ca62a759aa2e8c;
    
    if ( isvector( var_19ca62a759aa2e8c ) )
    {
        zone_struct = function_90e5c3e2272b0130( var_19ca62a759aa2e8c );
        
        if ( !isdefined( zone_struct ) )
        {
            return;
        }
        
        zone_name_1 = zone_struct.script_zone_name;
    }
    
    zone_name_2 = var_19ca65a759aa3525;
    
    if ( isvector( var_19ca65a759aa3525 ) )
    {
        zone_struct = function_90e5c3e2272b0130( var_19ca65a759aa3525 );
        
        if ( !isdefined( zone_struct ) )
        {
            return;
        }
        
        zone_name_2 = zone_struct.script_zone_name;
    }
    
    if ( isdefined( level.zone_manager.zone_distances[ zone_name_1 ][ zone_name_2 ] ) )
    {
        return level.zone_manager.zone_distances[ zone_name_1 ][ zone_name_2 ];
    }
}

// Namespace zone_manager
// Params 2, eflags: 0x4
// Checksum 0x8cc0f5bb, Offset: 0x24c3
// Size: 0x2d8
function private update_current_zone( ignore_cache, check_all_zones )
{
    check_all_zones = istrue( check_all_zones );
    touching_volumes = self getistouchingentities( level.zone_manager.inited_defs_volumes );
    touching_volume = touching_volumes.size > 0 ? touching_volumes[ 0 ] : undefined;
    
    if ( !isdefined( touching_volume ) )
    {
        foreach ( runtime_volume in level.zone_manager.runtime_volumes )
        {
            if ( self istouching( runtime_volume ) )
            {
                touching_volume = runtime_volume;
                break;
            }
        }
    }
    
    var_c043664bd7f5561e = !( touching_volume.zone_struct === self.cached_zone_info.zone_struct );
    
    if ( !ignore_cache && isdefined( self.cached_zone_info ) && !var_c043664bd7f5561e && self.cached_zone_info.check_all_zones == check_all_zones && is_touching_zone( self.cached_zone_info.zone_struct ) )
    {
        set_cache_zone( self.cached_zone_info.zone_struct, check_all_zones );
        return;
    }
    
    previous_zone_struct = undefined;
    
    if ( isdefined( self.cached_zone_info ) )
    {
        previous_zone_struct = self.cached_zone_info.zone_struct;
    }
    
    new_zone_struct = undefined;
    self.cached_zone_info = undefined;
    
    if ( isplayer( self ) && isdefined( previous_zone_struct ) && isdefined( previous_zone_struct.occupants[ self getentitynumber() ] ) )
    {
        function_ce45b62d4566c1e4( previous_zone_struct, self, 0 );
    }
    
    if ( isdefined( touching_volume.zone_struct ) )
    {
        new_zone_struct = touching_volume.zone_struct;
    }
    else
    {
        new_zone_struct = get_zone_struct( function_ac62281be3d43322( self.origin, self ) );
    }
    
    if ( !check_all_zones && !new_zone_struct.is_enabled )
    {
        return;
    }
    
    if ( !isdefined( new_zone_struct ) )
    {
        return;
    }
    
    set_cache_zone( new_zone_struct, check_all_zones );
    
    if ( isplayer( self ) )
    {
        function_ce45b62d4566c1e4( new_zone_struct, self, 1 );
    }
    
    if ( isplayer( self ) && ( !isdefined( previous_zone_struct ) && isdefined( new_zone_struct ) || isdefined( previous_zone_struct ) && !isdefined( new_zone_struct ) || isdefined( previous_zone_struct ) && isdefined( new_zone_struct ) && previous_zone_struct != new_zone_struct ) )
    {
        params = spawnstruct();
        params.previous_zone_struct = previous_zone_struct;
        params.zone_struct = new_zone_struct;
        callback::callback( "zone_changed", params );
    }
}

// Namespace zone_manager
// Params 3
// Checksum 0x8d161d29, Offset: 0x27a3
// Size: 0x77
function function_ce45b62d4566c1e4( zone_struct, occupant, occupied )
{
    entity_number = occupant.entity_number ?? occupant getentitynumber();
    
    if ( occupied )
    {
        zone_struct.occupants[ entity_number ] = occupant;
    }
    else
    {
        zone_struct.occupants[ entity_number ] = undefined;
    }
    
    function_a743e767d62bb311( zone_struct );
    level function_89cd44b33550b3d5( zone_struct );
}

// Namespace zone_manager
// Params 1, eflags: 0x4
// Checksum 0xe91ef6a1, Offset: 0x2822
// Size: 0xeb
function private function_a743e767d62bb311( main_zone_struct )
{
    foreach ( zone_name, adjacent_info in main_zone_struct.var_c96b1c3cfbbd6aac )
    {
        adjacent_zone_struct = get_zone_struct( zone_name );
        
        if ( !adjacent_zone_struct.is_enabled || !adjacent_info.var_3f0f2395ff496746 )
        {
            continue;
        }
        
        adjacent_zone_struct.occupied_adjacencies[ main_zone_struct.script_zone_name ] = main_zone_struct.occupants.size > 0 ? 1 : undefined;
        level function_89cd44b33550b3d5( adjacent_zone_struct );
    }
}

// Namespace zone_manager
// Params 1, eflags: 0x4
// Checksum 0x8c500458, Offset: 0x2915
// Size: 0x3a
function private function_89cd44b33550b3d5( zone_struct )
{
    level.zone_manager.dirty_zones[ zone_struct.script_zone_name ] = zone_struct;
    utility::flag_set( "zone_manager_dirty" );
}

// Namespace zone_manager
// Params 2, eflags: 0x4
// Checksum 0x3a44e4c6, Offset: 0x2957
// Size: 0x83
function private set_cache_zone( zone_struct, check_all_zones )
{
    self.cached_zone_info = spawnstruct();
    self.cached_zone_info.zone_struct = zone_struct;
    self.cached_zone_info.valid_pos = self.origin;
    self.cached_zone_info.var_71926f64e81b08dd = gettime();
    self.cached_zone_info.check_all_zones = check_all_zones;
}

// Namespace zone_manager
// Params 0, eflags: 0x4
// Checksum 0x83ed7aad, Offset: 0x29e2
// Size: 0x4d
function private function_511369c75f53601c()
{
    self.var_511369c75f53601c = 1;
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self.cached_zone_info ) )
    {
        function_ce45b62d4566c1e4( self.cached_zone_info.zone_struct, self, 0 );
    }
    
    self.var_511369c75f53601c = undefined;
}

// Namespace zone_manager
// Params 3, eflags: 0x4
// Checksum 0x422c5875, Offset: 0x2a37
// Size: 0xe4
function private function_2f6b1cac17447b93( main_zone_struct, adjacent_zone_struct, adjacent_info )
{
    adjacent_info notify( #"hash_730ecfe5a479743" );
    adjacent_info endon( #"hash_730ecfe5a479743" );
    level endon( #"game_ended" );
    
    if ( !adjacent_info.auto_enable && isdefined( adjacent_info.var_46f1327fcd04fb1e ) && adjacent_info.var_46f1327fcd04fb1e != "" )
    {
        utility::flag_wait( adjacent_info.var_46f1327fcd04fb1e );
        set_zone_enabled( main_zone_struct.script_zone_name, 1 );
        function_a743e767d62bb311( main_zone_struct );
        function_89cd44b33550b3d5( main_zone_struct );
        set_zone_enabled( adjacent_zone_struct.script_zone_name, 1 );
        function_a743e767d62bb311( adjacent_zone_struct );
        function_89cd44b33550b3d5( adjacent_zone_struct );
    }
    
    adjacent_info.var_3f0f2395ff496746 = 1;
}

// Namespace zone_manager
// Params 3, eflags: 0x4
// Checksum 0xbd2aa2b, Offset: 0x2b23
// Size: 0xeb
function private function_5ca75cfd3878d096( var_46f1327fcd04fb1e, chain_flags, subclass_to_aitype_map )
{
    level endon( #"game_ended" );
    assert( isstring( var_46f1327fcd04fb1e ) );
    assert( isarray( chain_flags ) );
    utility::flag_wait( var_46f1327fcd04fb1e );
    
    foreach ( chain_flag in chain_flags )
    {
        utility::flag_set( chain_flag.var_dee96503c16d20ba );
    }
    
    if ( isdefined( level.gametypebundle.var_d72ac83fac014227 ) )
    {
        return;
    }
    
    subclass_to_aitype_map::add_map( subclass_to_aitype_map );
}

// Namespace zone_manager
// Params 0, eflags: 0x4
// Checksum 0x86acacfb, Offset: 0x2c16
// Size: 0xea
function private function_8d330580ebdd0fc2()
{
    zone_structs = [];
    
    foreach ( struct in utility::getstructarray( "zone_def", "script_noteworthy" ) )
    {
        if ( isdefined( struct.script_zone_name ) )
        {
            if ( isdefined( zone_structs[ struct.script_zone_name ] ) && !isdefined( struct.targetname ) )
            {
                continue;
            }
            
            zone_structs[ struct.script_zone_name ] = struct;
        }
    }
    
    level.zone_manager.defs = zone_structs;
    utility::flag_set( "zone_manager_cache_ready" );
}

// Namespace zone_manager
// Params 0, eflags: 0x4
// Checksum 0xb74afadd, Offset: 0x2d08
// Size: 0x276
function private function_55449e31c0dd4d10()
{
    level endon( #"game_ended" );
    utility::flag_wait( "zone_manager_cache_ready" );
    respawn_groups = utility::getstructarray( "player_respawn_point", "targetname" );
    
    foreach ( respawn_group in respawn_groups )
    {
        zone_name = respawn_group.script_noteworthy;
        assert( isdefined( zone_name ) );
        assert( isdefined( level.zone_manager.defs[ zone_name ] ), "<dev string:x296>" + respawn_group.origin );
        respawn_group.var_f448a26cf56f4a2a = utility::getstructarray( respawn_group.target, "targetname" );
        
        if ( zone_name == "zone_cliffside_close_to_telescope" )
        {
            var_1e94006a2b2e545e = [ ( 4171.81, -153.002, -46 ), ( 4145.39, -110.759, -45 ), ( 4548.83, 132.141, -46.3118 ), ( 4584.81, 67.095, -44 ) ];
            var_9cf251ac3fd48e7 = [ ( 0, 42.622, 0 ), ( 0, 42.9343, 0 ), ( 0, 218.534, 0 ), ( 0, 215.934, 0 ) ];
            
            for ( i = 0; i < respawn_group.var_f448a26cf56f4a2a.size ; i++ )
            {
                respawn_group.var_f448a26cf56f4a2a[ i ].origin = var_1e94006a2b2e545e[ i ];
                respawn_group.var_f448a26cf56f4a2a[ i ].angles = var_9cf251ac3fd48e7[ i ];
            }
        }
        
        if ( !isdefined( level.zone_manager.respawn_groups[ zone_name ] ) )
        {
            level.zone_manager.respawn_groups[ zone_name ] = [];
        }
        
        level.zone_manager.respawn_groups[ zone_name ][ level.zone_manager.respawn_groups[ zone_name ].size ] = respawn_group;
    }
}

// Namespace zone_manager
// Params 1, eflags: 0x4
// Checksum 0x3285b155, Offset: 0x2f86
// Size: 0x104
function private get_volumes( zone_struct )
{
    volumes = [];
    
    if ( isdefined( zone_struct ) && isdefined( zone_struct.targetname ) )
    {
        volumes = getentarray( zone_struct.targetname, #target );
    }
    
    if ( !isdefined( volumes ) )
    {
        volumes = [];
    }
    
    new_volumes = [];
    
    foreach ( volume in volumes )
    {
        if ( volume.classname != "trigger_multiple_set_minimap_floor" )
        {
            new_volumes[ new_volumes.size ] = volume;
        }
    }
    
    /#
        debug_print( "<dev string:x2bd>" + volumes.size + "<dev string:x2c4>" + zone_struct.script_zone_name );
    #/
    
    return new_volumes;
}

// Namespace zone_manager
// Params 1, eflags: 0x4
// Checksum 0xc66d8259, Offset: 0x3093
// Size: 0x120
function private get_nodes( zone_struct )
{
    nodes = [];
    
    if ( isdefined( zone_struct.targetname ) )
    {
        nodes = getnodearray( zone_struct.targetname, #target );
    }
    
    if ( !isdefined( nodes ) && isdefined( zone_struct.script_zone_name ) )
    {
        nodes = getnodearray( zone_struct.script_zone_name, #target );
    }
    
    if ( !isdefined( nodes ) )
    {
        nodes = [];
    }
    
    foreach ( node in nodes )
    {
        node.zone_name = zone_struct.script_zone_name;
    }
    
    /#
        debug_print( "<dev string:x2bd>" + nodes.size + "<dev string:x2d7>" + zone_struct.script_zone_name );
    #/
    
    return nodes;
}

// Namespace zone_manager
// Params 1, eflags: 0x4
// Checksum 0x449acec8, Offset: 0x31bc
// Size: 0x1e9
function private get_aabb( zone_struct )
{
    aabb = [];
    aabb[ "min" ] = [];
    aabb[ "max" ] = [];
    val = [];
    
    foreach ( volume in zone_struct.volumes )
    {
        bounds = [];
        bounds[ "max" ] = volume getboundshalfsize();
        bounds[ "min" ] = bounds[ "max" ] * -1;
        
        for ( i = 0; i < 3 ; i++ )
        {
            aabb[ "min" ][ i ] = min( bounds[ "min" ][ i ] + volume.origin[ i ], aabb[ "min" ][ i ] ?? bounds[ "min" ][ i ] + volume.origin[ i ] );
            aabb[ "max" ][ i ] = max( bounds[ "max" ][ i ] + volume.origin[ i ], aabb[ "max" ][ i ] ?? bounds[ "max" ][ i ] + volume.origin[ i ] );
        }
    }
    
    if ( zone_struct.volumes.size > 0 )
    {
        aabb[ "min" ] = ( aabb[ "min" ][ 0 ], aabb[ "min" ][ 1 ], aabb[ "min" ][ 2 ] );
        aabb[ "max" ] = ( aabb[ "max" ][ 0 ], aabb[ "max" ][ 1 ], aabb[ "max" ][ 2 ] );
    }
    else
    {
        return;
    }
    
    return aabb;
}

// Namespace zone_manager
// Params 2, eflags: 0x4
// Checksum 0x69b38c42, Offset: 0x33ae
// Size: 0x151, Type: bool
function private is_touching_aabb( entity, aabb )
{
    if ( !isdefined( aabb ) )
    {
        return false;
    }
    
    if ( !isdefined( entity.zone_aabb ) )
    {
        ent_bounds = [];
        ent_bounds[ "max" ] = entity getboundshalfsize();
        ent_bounds[ "min" ] = ent_bounds[ "max" ] * -1;
        ent_bounds[ "midpoint" ] = entity getboundsmidpoint();
        entity.zone_aabb = ent_bounds;
    }
    
    ent_mins = entity.zone_aabb[ "min" ] + entity.zone_aabb[ "midpoint" ] + entity.origin;
    ent_maxs = entity.zone_aabb[ "max" ] + entity.zone_aabb[ "midpoint" ] + entity.origin;
    aabb_mins = aabb[ "min" ];
    aabb_maxs = aabb[ "max" ];
    return ent_mins[ 0 ] <= aabb_maxs[ 0 ] && ent_maxs[ 0 ] >= aabb_mins[ 0 ] && ent_mins[ 1 ] <= aabb_maxs[ 1 ] && ent_maxs[ 1 ] >= aabb_mins[ 1 ] && ent_mins[ 2 ] <= aabb_maxs[ 2 ] && ent_maxs[ 2 ] >= aabb_mins[ 2 ];
}

// Namespace zone_manager
// Params 0, eflags: 0x4
// Checksum 0xefeaa07a, Offset: 0x3508
// Size: 0x525
function private function_5ea4dd7b73af9224()
{
    level endon( #"game_ended" );
    
    if ( utility::flag( "zone_manager_init_zones" ) )
    {
        return;
    }
    
    utility::flag_set( "zone_manager_init_zones" );
    zone_map_name = "zmzonemap_" + getdvar( @"g_mapname" );
    var_de290d46c1aace15 = getscriptbundle( "zmzonemap:" + zone_map_name );
    var_61ae499915801b2f = 1;
    
    if ( !isdefined( var_de290d46c1aace15 ) )
    {
        /#
            error_msg = "<dev string:x2e8>" + zone_map_name;
            iprintlnbold( error_msg );
            println( error_msg );
        #/
    }
    else
    {
        var_61ae499915801b2f = var_de290d46c1aace15.var_6c1992fe5aa58616;
    }
    
    foreach ( zone_struct in level.zone_manager.defs )
    {
        function_10ed552162ebaaef( zone_struct.script_zone_name );
        
        if ( var_61ae499915801b2f )
        {
            set_zone_enabled( zone_struct.script_zone_name, 1 );
        }
    }
    
    if ( isdefined( var_de290d46c1aace15 ) )
    {
        if ( isdefined( var_de290d46c1aace15.var_56b73c74b70a97f7 ) )
        {
            foreach ( var_7b275d49aa79edf2 in var_de290d46c1aace15.var_56b73c74b70a97f7 )
            {
                foreach ( target_zone in var_7b275d49aa79edf2.var_f4c83a6e1ffe1e67 )
                {
                    if ( isdefined( var_7b275d49aa79edf2.var_8da6a00f836ce552 ) && isdefined( target_zone.targetzone ) )
                    {
                        function_beb7a83eecf1f137( var_7b275d49aa79edf2.var_8da6a00f836ce552, target_zone.targetzone, target_zone.var_2c44ee86f425ed97, target_zone.autoenable, 1 );
                    }
                }
            }
        }
        
        if ( isdefined( var_de290d46c1aace15.var_cf297ac0af07a28f ) )
        {
            foreach ( var_d59f0cd3e9ece538 in var_de290d46c1aace15.var_cf297ac0af07a28f )
            {
                level.zone_manager thread function_5ca75cfd3878d096( var_d59f0cd3e9ece538.var_2c44ee86f425ed97, var_d59f0cd3e9ece538.var_c8d7e31335fc2d84, var_d59f0cd3e9ece538.var_b0c9fe61c7059d61 );
            }
        }
        
        if ( isdefined( var_de290d46c1aace15.var_f6c27ca245722ec4 ) )
        {
            foreach ( zone_def in var_de290d46c1aace15.var_f6c27ca245722ec4 )
            {
                zone_struct = get_zone_struct( zone_def.var_8da6a00f836ce552 );
                
                if ( isdefined( zone_struct ) )
                {
                    zone_struct.display_name = zone_def.zonedisplayname;
                    
                    if ( zone_def.var_af88b5fa375e40d1 )
                    {
                        set_zone_enabled( zone_def.var_8da6a00f836ce552, 1 );
                    }
                    
                    if ( zone_def.var_aba4e9b3b1a298b8 )
                    {
                        zone_struct.var_4165b555f7abea4d = 1;
                    }
                    
                    if ( zone_def.var_588ef04a50b55fb4 )
                    {
                        zone_struct.dark_aether_flashlight_on = 1;
                    }
                    
                    if ( zone_def.var_d253951b18f2e60b )
                    {
                        zone_struct.round_spawn_disabled = 1;
                    }
                    
                    if ( isdefined( zone_def.var_20f188d5bc4e8e30 ) )
                    {
                        zone_struct.var_20f188d5bc4e8e30 = zone_def.var_20f188d5bc4e8e30;
                    }
                    
                    if ( isdefined( zone_def.subclass_to_aitype_map ) )
                    {
                        zone_struct.subclass_to_aitype_map = zone_def.subclass_to_aitype_map;
                    }
                    
                    if ( zone_def.var_96b821aed30d95de )
                    {
                        zone_struct.var_96b821aed30d95de = zone_def.var_96b821aed30d95de;
                        level thread function_1fc9e501ef1af893( zone_struct, zone_struct.var_96b821aed30d95de );
                    }
                    
                    continue;
                }
                
                /#
                    debug_print( "<dev string:x327>" + zone_def.var_8da6a00f836ce552 + "<dev string:x334>" );
                #/
            }
        }
    }
    
    zone_setup_finished();
    level thread function_97e99f0b47c3ab55();
    level thread function_f029e29824b3298e();
}

// Namespace zone_manager
// Params 2
// Checksum 0x3bb2c132, Offset: 0x3a35
// Size: 0x5f
function function_1fc9e501ef1af893( zone_struct, var_ca908a6a83b8fb50 )
{
    level endon( #"game_ended" );
    utility::flag_wait( "zone_setup_finished" );
    
    if ( !utility::flag_exist( var_ca908a6a83b8fb50 ) )
    {
        utility::flag_init( var_ca908a6a83b8fb50 );
    }
    
    utility::flag_wait( var_ca908a6a83b8fb50 );
    set_zone_enabled( zone_struct.script_zone_name, 1 );
}

// Namespace zone_manager
// Params 0, eflags: 0x4
// Checksum 0x2af80111, Offset: 0x3a9c
// Size: 0x155
function private function_75849c81b2418f9b()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        utility::flag_wait( "zone_manager_dirty" );
        waittillframeend();
        
        foreach ( zone_struct in level.zone_manager.dirty_zones )
        {
            if ( zone_struct.occupants.size || zone_struct.occupied_adjacencies.size )
            {
                /#
                    debug_print( "<dev string:x349>" + zone_struct.script_zone_name + "<dev string:x34f>" );
                #/
                
                set_zone_active( zone_struct.script_zone_name, 1 );
                continue;
            }
            
            /#
                debug_print( "<dev string:x349>" + zone_struct.script_zone_name + "<dev string:x35e>" );
            #/
            
            set_zone_active( zone_struct.script_zone_name, 0 );
        }
        
        level.zone_manager.dirty_zones = [];
        utility::flag_clear( "zone_manager_dirty" );
        level notify( #"hash_26a2077df36d9089" );
    }
}

// Namespace zone_manager
// Params 1
// Checksum 0x9b28e162, Offset: 0x3bf9
// Size: 0x33
function function_65305a611c6226d9( v_origin )
{
    var_8c4fe62d01999d1e = function_90e5c3e2272b0130( v_origin );
    
    if ( isdefined( var_8c4fe62d01999d1e ) )
    {
        return var_8c4fe62d01999d1e.is_enabled;
    }
    
    return 0;
}

// Namespace zone_manager
// Params 2
// Checksum 0xa282fb2e, Offset: 0x3c35
// Size: 0x4f, Type: bool
function function_427ae6b3bc10b5ac( v_origin, zone_name )
{
    var_8c4fe62d01999d1e = function_90e5c3e2272b0130( v_origin );
    
    if ( !isdefined( var_8c4fe62d01999d1e ) )
    {
        return false;
    }
    
    current_zone_name = function_2bcd755aabfd3cad( var_8c4fe62d01999d1e );
    
    if ( current_zone_name == zone_name )
    {
        return true;
    }
    
    return false;
}

// Namespace zone_manager
// Params 2
// Checksum 0x11520851, Offset: 0x3c8d
// Size: 0x5c
function function_895c1f0819999b60( var_c60105d2445aa45f, spawn_position )
{
    zone_struct = function_90e5c3e2272b0130( spawn_position );
    
    if ( isdefined( zone_struct.subclass_to_aitype_map ) )
    {
        ai_type = subclass_to_aitype_map::function_427ae77ce1056e01( var_c60105d2445aa45f, [ zone_struct.subclass_to_aitype_map ] );
    }
    
    return ai_type;
}

// Namespace zone_manager
// Params 6
// Checksum 0xee4a56c6, Offset: 0x3cf2
// Size: 0x34a
function function_aeaa8dd788ed9b16( var_be866219ba036c6, var_77fc4ed806f5cac9 = 0, var_51c533560222849c = [], var_9e41dd30435985b7 = [], n_min_distance, var_d7fea362425ebf7c )
{
    var_d741aeceea421b0e = [];
    var_8f102f6dbc44d25b = [];
    s_current_zone = function_90e5c3e2272b0130( self.origin + ( 0, 0, 32 ) );
    var_462c26d1d75a5e14 = utility::getstructarray( "player_respawn_point", "targetname" );
    
    foreach ( var_1e4139ca72a33905 in var_462c26d1d75a5e14 )
    {
        if ( !isdefined( var_1e4139ca72a33905.zone_name ) )
        {
            var_1e4139ca72a33905.zone_name = var_1e4139ca72a33905.script_noteworthy;
        }
        
        if ( arraycontains( var_51c533560222849c, var_1e4139ca72a33905.zone_name ) )
        {
            continue;
        }
        else if ( var_9e41dd30435985b7.size > 0 && !arraycontains( var_9e41dd30435985b7, var_1e4139ca72a33905.zone_name ) )
        {
            continue;
        }
        
        var_8c4fe62d01999d1e = get_zone_struct( var_1e4139ca72a33905.zone_name ) ?? function_90e5c3e2272b0130( var_1e4139ca72a33905.origin );
        
        if ( !var_8c4fe62d01999d1e.is_enabled )
        {
            continue;
        }
        
        if ( var_8c4fe62d01999d1e == s_current_zone )
        {
            var_8f102f6dbc44d25b[ var_8f102f6dbc44d25b.size ] = var_1e4139ca72a33905;
        }
        
        var_d741aeceea421b0e[ var_d741aeceea421b0e.size ] = var_1e4139ca72a33905;
    }
    
    if ( isdefined( level.var_52e6eeb8c2bff4f3 ) )
    {
        var_7d2a636b261c6545 = [[ level.var_52e6eeb8c2bff4f3 ]]( var_d741aeceea421b0e, var_8f102f6dbc44d25b );
    }
    else if ( isdefined( var_be866219ba036c6 ) )
    {
        var_7d2a636b261c6545 = [[ var_be866219ba036c6 ]]( var_d741aeceea421b0e, var_8f102f6dbc44d25b );
    }
    else if ( var_d741aeceea421b0e.size < 1 && var_8f102f6dbc44d25b.size < 1 )
    {
        return;
    }
    
    var_a87104a582b02a9e = undefined;
    
    if ( !isdefined( var_7d2a636b261c6545 ) )
    {
        var_7d2a636b261c6545 = var_77fc4ed806f5cac9 && var_8f102f6dbc44d25b.size > 0 ? var_8f102f6dbc44d25b : var_d741aeceea421b0e;
    }
    
    if ( isdefined( n_min_distance ) )
    {
        var_b8de083a42b11d01 = squared( n_min_distance );
        
        foreach ( var_25244e005cc4431e in var_7d2a636b261c6545 )
        {
            dist = distance2dsquared( self.origin, var_25244e005cc4431e.origin );
            
            if ( dist < var_b8de083a42b11d01 )
            {
                var_7d2a636b261c6545 = arrayremove( var_7d2a636b261c6545, var_25244e005cc4431e );
            }
        }
    }
    
    var_ba4504ab9b6e7a9a = var_d7fea362425ebf7c ? function_47c86977a18df38b( var_7d2a636b261c6545, self.origin ) : utility::array_random( var_7d2a636b261c6545 );
    var_aa9244ac3dd1149 = utility::getstructarray( var_ba4504ab9b6e7a9a.target, "targetname" );
    var_c4dbda4969a702ac = self getentitynumber();
    var_a87104a582b02a9e = var_aa9244ac3dd1149[ var_c4dbda4969a702ac ];
    return var_a87104a582b02a9e;
}

/#

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0x80007b58, Offset: 0x4045
    // Size: 0x1f1, Type: dev
    function private setup_zone_manager_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x371>" );
        devgui::add_devgui_func( "<dev string:x37a>", "<dev string:x38b>", &function_42e351f25a351212, 0 );
        devgui::add_devgui_func( "<dev string:x3a4>", "<dev string:x3d3>", &function_3f8393adab09cec0, 0, 1 );
        devgui::add_devgui_func( "<dev string:x3f0>", "<dev string:x41f>", &function_84e80ee42a44e129, 0, 2 );
        devgui::add_devgui_func( "<dev string:x43c>", "<dev string:x44e>", &function_cd83b3ac8991126, 0 );
        devgui::add_devgui_func( "<dev string:x46f>", "<dev string:x488>", &function_bee823039db01f8 );
        devgui::add_devgui_func( "<dev string:x4ae>", "<dev string:x4c4>", &function_9df1eba8cf1fe789, 1 );
        devgui::add_devgui_func( "<dev string:x4e7>", "<dev string:x501>", &function_e8a0dbf6e63ad93d );
        devgui::add_devgui_func( "<dev string:x517>", "<dev string:x54b>", &function_3857178b032fdea2, 1 );
        
        foreach ( zone_struct in level.zone_manager.defs )
        {
            zone_name = zone_struct.script_zone_name;
            respawn_group = function_9dd25e9fb0ecd45b( zone_name );
            a_respawn_points = respawn_group[ 0 ].var_f448a26cf56f4a2a ?? [];
            
            for ( i = 0; i < a_respawn_points.size ; i++ )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x56e>" + zone_name + "<dev string:x598>" + i, "<dev string:x59a>" + zone_name + "<dev string:x5bb>" + i, &test_respawn_point, 1 );
            }
        }
        
        devgui::add_devgui_func( "<dev string:x5bd>", "<dev string:x5ee>", &function_81cb4e008f57ba33, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0x7e6d59ea, Offset: 0x423e
    // Size: 0xa3, Type: dev
    function private function_9df1eba8cf1fe789()
    {
        while ( true )
        {
            waitframe();
            level debug::function_298a6c4895b8935d( ( 400, 100, 0 ) );
            debug::function_ce323c1a383e915( "<dev string:x61e>", ( 1, 1, 1 ) );
            debug::function_ce323c1a383e915( "<dev string:x63a>" );
            level debug::function_9de8db536c079b2d();
            flag = getdvar( @"hash_1835d36afaf43562", "<dev string:x68f>" );
            setdvar( @"hash_1835d36afaf43562", "<dev string:x68f>" );
            
            if ( flag == "<dev string:x68f>" )
            {
                continue;
            }
            
            if ( utility::flag_exist( flag ) )
            {
                utility::flag_set( flag );
            }
        }
    }

    // Namespace zone_manager
    // Params 1, eflags: 0x4
    // Checksum 0x52267e0a, Offset: 0x42e9
    // Size: 0x56, Type: dev
    function private set_zone_debug( force_val )
    {
        if ( isdefined( force_val ) )
        {
            level.zone_manager.debug = force_val;
            return;
        }
        
        level.zone_manager.debug = !level.zone_manager.debug;
    }

    // Namespace zone_manager
    // Params 1, eflags: 0x4
    // Checksum 0x3a89db35, Offset: 0x4347
    // Size: 0x34, Type: dev
    function private debug_print( msg )
    {
        if ( !level.zone_manager.debug )
        {
            return;
        }
        
        println( "<dev string:x690>" + msg );
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0x5e61f7a1, Offset: 0x4383
    // Size: 0xd, Type: dev
    function private function_42e351f25a351212()
    {
        level thread function_d23f3189569f0676();
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0xd876bba4, Offset: 0x4398
    // Size: 0x5f, Type: dev
    function private function_d23f3189569f0676()
    {
        setdvarifuninitialized( @"hash_e90b3323aac7694", 1.25 );
        level endon( #"hash_68b500460eaa601e" );
        
        if ( utility::flag( "<dev string:x69f>" ) )
        {
            utility::flag_clear( "<dev string:x69f>" );
            level notify( #"hash_68b500460eaa601e" );
            return;
        }
        
        utility::flag_set( "<dev string:x69f>" );
        level thread function_edffff097aa86c4f();
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0x88b6be72, Offset: 0x43ff
    // Size: 0xd, Type: dev
    function private function_cd83b3ac8991126()
    {
        level thread function_8cef9a807b55b436();
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0x93e710bb, Offset: 0x4414
    // Size: 0x163, Type: dev
    function private function_8cef9a807b55b436()
    {
        level endon( #"hash_b3b22d14f90b16ae" );
        level endon( #"game_ended" );
        
        if ( utility::flag( "<dev string:x6b3>" ) )
        {
            utility::flag_clear( "<dev string:x6b3>" );
            setdvar( @"hash_d1788aec46505244", 0 );
            setdvar( @"hash_3c48eaf332022cd9", 0 );
            level notify( #"hash_b3b22d14f90b16ae" );
            return;
        }
        
        utility::flag_set( "<dev string:x6b3>" );
        setdvar( @"hash_d1788aec46505244", 7 );
        setdvar( @"hash_3c48eaf332022cd9", 1 );
        
        while ( true )
        {
            foreach ( zone_struct in level.zone_manager.defs )
            {
                if ( distance( zone_struct.origin, level.players[ 0 ].origin ) < 3000 )
                {
                    draw_zone( zone_struct );
                    function_963ab40c015db702( zone_struct );
                    function_980bb54c6cc055ae( zone_struct );
                }
            }
            
            wait level.framedurationseconds * 5;
        }
    }

    // Namespace zone_manager
    // Params 1, eflags: 0x4
    // Checksum 0xfbf7dda6, Offset: 0x457f
    // Size: 0x1cf, Type: dev
    function private draw_zone( zone_struct )
    {
        box( zone_struct.origin, 0, ( 1, 0.5, 0 ), 1, 5 );
        print3d( zone_struct.origin, zone_struct.script_zone_name, ( 1, 1, 1 ), 1, 1, 5 );
        
        foreach ( volume in zone_struct.volumes )
        {
            line( zone_struct.origin, volume.origin, ( 1, 0, 0 ), 1, 1, 5 );
            drawentitybounds( volume, ( 1, 1, 0 ), 1, 5 );
        }
        
        foreach ( volume in zone_struct.noent_volumes )
        {
            line( zone_struct.origin, volume.origin, ( 1, 0, 0 ), 1, 1, 5 );
            box( volume.origin, 0, ( 1, 0.5, 0.2 ), 1, 5 );
        }
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0x3896e07b, Offset: 0x4756
    // Size: 0x137, Type: dev
    function private function_edffff097aa86c4f()
    {
        level endon( #"hash_68b500460eaa601e" );
        var_78d6606d597fb76e = 0;
        
        foreach ( zone_struct in level.zone_manager.defs )
        {
            var_78d6606d597fb76e = int( max( var_78d6606d597fb76e, zone_struct.script_zone_name.size ) );
        }
        
        sorted_defs = arraysort( getarraykeys( level.zone_manager.defs ), undefined, undefined, 0, undefined, 1 );
        
        for ( ;; )
        {
            level debug::function_298a6c4895b8935d( ( 600, 100, 0 ) );
            
            for ( i = 0; i < sorted_defs.size ; i++ )
            {
                zone_struct = level.zone_manager.defs[ sorted_defs[ i ] ];
                function_238f98a075dcb245( zone_struct, var_78d6606d597fb76e );
            }
            
            level debug::function_9de8db536c079b2d();
            waitframe();
        }
    }

    // Namespace zone_manager
    // Params 2, eflags: 0x4
    // Checksum 0x81d12a4d, Offset: 0x4895
    // Size: 0x2ce, Type: dev
    function private function_238f98a075dcb245( zone_struct, var_78d6606d597fb76e )
    {
        text = zone_struct.script_zone_name;
        
        for ( i = 0; i < var_78d6606d597fb76e - zone_struct.script_zone_name.size ; i++ )
        {
            text += "<dev string:x6c8>";
        }
        
        text += "<dev string:x6ca>";
        zone_occupants = get_zone_occupants( zone_struct.script_zone_name );
        text += zone_occupants.size + "<dev string:x6ce>";
        text += "<dev string:x6ca>";
        text += zone_struct.is_enabled ? "<dev string:x6db>" : "<dev string:x6e3>";
        text += "<dev string:x6ca>";
        text += zone_struct.is_active ? "<dev string:x6eb>" : "<dev string:x6f2>";
        text += "<dev string:x6ca>";
        spawner_amount = 0;
        var_d6d4228191104669 = 0;
        var_70acf68c789df9d3 = 0;
        
        foreach ( spawn_loc in level.zone_spawn_locations )
        {
            if ( spawn_loc.zone_name == zone_struct.script_zone_name )
            {
                spawner_amount++;
                var_d6d4228191104669 += spawn_loc.var_f75026dba575871d;
                var_70acf68c789df9d3 += spawn_loc.var_2306e1230e900f37;
            }
        }
        
        text += spawner_amount;
        text += "<dev string:x6f9>";
        text += var_d6d4228191104669;
        text += "<dev string:x6f9>";
        text += var_70acf68c789df9d3;
        text_color = ( 1, 0, 0 );
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                if ( zone_struct.is_active )
                {
                    text_color = ( 0.2, 1, 0 );
                    continue;
                }
                
                if ( zone_struct.is_enabled )
                {
                    text_color = ( 1, 1, 0 );
                }
            }
        }
        
        text_scale = getdvarfloat( @"hash_e90b3323aac7694" );
        level debug::function_ce323c1a383e915( text, text_color, text_scale );
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0xf060a253, Offset: 0x4b6b
    // Size: 0x5d, Type: dev
    function private function_3f8393adab09cec0()
    {
        setdvarifuninitialized( @"hash_e90b3323aac7694", 1.25 );
        scale = getdvarfloat( @"hash_e90b3323aac7694" );
        scale += 0.25;
        scale = clamp( scale, 0.25, 3.75 );
        setdvar( @"hash_e90b3323aac7694", scale );
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0xa73df73, Offset: 0x4bd0
    // Size: 0x5d, Type: dev
    function private function_84e80ee42a44e129()
    {
        setdvarifuninitialized( @"hash_e90b3323aac7694", 1.25 );
        scale = getdvarfloat( @"hash_e90b3323aac7694" );
        scale -= 0.25;
        scale = clamp( scale, 0.25, 3.75 );
        setdvar( @"hash_e90b3323aac7694", scale );
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0xa4f6699f, Offset: 0x4c35
    // Size: 0xc3, Type: dev
    function private function_bee823039db01f8()
    {
        level.zone_manager.var_7c5769099d72383 = !level.zone_manager.var_7c5769099d72383;
        
        foreach ( zone_name, zone_struct in level.zone_manager.inited_defs )
        {
            set_zone_enabled( zone_name, level.zone_manager.var_7c5769099d72383 );
        }
    }

    // Namespace zone_manager
    // Params 1, eflags: 0x4
    // Checksum 0x3b4afbe4, Offset: 0x4d00
    // Size: 0xc6, Type: dev
    function private function_963ab40c015db702( zone_struct )
    {
        if ( isdefined( zone_struct.aabb ) )
        {
            mid_point = ( zone_struct.aabb[ "<dev string:x6fb>" ] + zone_struct.aabb[ "<dev string:x6ff>" ] ) / 2;
            dims = zone_struct.aabb[ "<dev string:x6fb>" ] - zone_struct.aabb[ "<dev string:x6ff>" ];
            angles = ( 0, 0, 0 );
            color = ( 0, 1, 1 );
            duration = 1;
            orientedbox( mid_point, dims, angles, color, 1, 5 );
        }
    }

    // Namespace zone_manager
    // Params 3, eflags: 0x4
    // Checksum 0x7647ce6a, Offset: 0x4dce
    // Size: 0xe5, Type: dev
    function private function_2e168859641622fd( zone_struct, adjacent_zone_name, var_1c5646f3c5cecb1 )
    {
        adjacent_zone_struct = get_zone_struct( adjacent_zone_name );
        forward = vectornormalize( adjacent_zone_struct.origin - zone_struct.origin );
        left = vectorcross( ( 0, 0, 1 ), forward );
        color = ( 1, 0, 0 );
        
        if ( var_1c5646f3c5cecb1.var_3f0f2395ff496746 )
        {
            color = ( 1, 1, 0 );
        }
        
        debug::debug_draw_arrow( zone_struct.origin + left * 24, adjacent_zone_struct.origin + left * 24 - forward * 24, color, 1, 1, 5 );
    }

    // Namespace zone_manager
    // Params 1, eflags: 0x4
    // Checksum 0x83d47396, Offset: 0x4ebb
    // Size: 0xfc, Type: dev
    function private function_980bb54c6cc055ae( zone_struct )
    {
        foreach ( zone_struct in level.zone_manager.inited_defs )
        {
            foreach ( adjacent_zone_name, var_1c5646f3c5cecb1 in zone_struct.var_c96b1c3cfbbd6aac )
            {
                function_2e168859641622fd( zone_struct, adjacent_zone_name, var_1c5646f3c5cecb1 );
            }
        }
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0x89d16638, Offset: 0x4fbf
    // Size: 0x3d6, Type: dev
    function private function_3857178b032fdea2()
    {
        level endon( #"game_ended" );
        var_d41e66982f75fa35 = [];
        
        foreach ( zone_struct in level.zone_manager.defs )
        {
            if ( !isdefined( level.zone_manager.respawn_groups[ zone_struct.script_zone_name ] ) )
            {
                var_d41e66982f75fa35[ var_d41e66982f75fa35.size ] = zone_struct.script_zone_name;
            }
        }
        
        while ( true )
        {
            foreach ( zone_name, var_494e0a8e02253114 in level.zone_manager.respawn_groups )
            {
                zone_struct = get_zone_struct( zone_name );
                zone_color = zone_struct.is_active ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                
                foreach ( respawn_group in var_494e0a8e02253114 )
                {
                    print3d( respawn_group.origin, zone_name, zone_color, 1, 1, 5 );
                    cached_spawn_points = isdefined( respawn_group.spawn_points_cache );
                    var_f522935b08b01822 = cached_spawn_points ? ( 0, 1, 0 ) : ( 1, 1, 0 );
                    print3d( respawn_group.origin - ( 0, 0, 10 ), cached_spawn_points ? "<dev string:x703>" : "<dev string:x70a>", var_f522935b08b01822, 1, 1, 5 );
                    
                    foreach ( spawn_location in respawn_group.var_f448a26cf56f4a2a )
                    {
                        line( respawn_group.origin, spawn_location.origin, var_f522935b08b01822, 1, 0, 5 );
                        sphere( spawn_location.origin, 8, var_f522935b08b01822, 0, 5 );
                    }
                    
                    if ( cached_spawn_points )
                    {
                        foreach ( spawn_point in respawn_group.spawn_points_cache )
                        {
                            print3d( spawn_point.origin, spawn_point.occupant ?? -1, var_f522935b08b01822, 1, 1, 5 );
                        }
                    }
                }
            }
            
            wait level.framedurationseconds * 5;
        }
    }

    // Namespace zone_manager
    // Params 1, eflags: 0x4
    // Checksum 0xcfee6e4b, Offset: 0x539d
    // Size: 0xa4, Type: dev
    function private test_respawn_point( params )
    {
        zone_name = params[ 0 ];
        index = int( params[ 1 ] );
        respawn_group = function_9dd25e9fb0ecd45b( zone_name );
        a_respawn_points = respawn_group[ 0 ].var_f448a26cf56f4a2a ?? [];
        respawn_point = a_respawn_points[ index ];
        player = level.players[ 0 ];
        player setorigin( respawn_point.origin );
        player setplayerangles( respawn_point.angles );
    }

    // Namespace zone_manager
    // Params 1, eflags: 0x4
    // Checksum 0x347b4f8a, Offset: 0x5449
    // Size: 0xab, Type: dev
    function private function_81cb4e008f57ba33( params )
    {
        player = level.players[ 0 ];
        current_zone = player get_current_zone();
        zone_name = current_zone.zone_name;
        respawn_group = function_9dd25e9fb0ecd45b( zone_name );
        [ respawn_point ] = respawn_group[ 0 ].var_f448a26cf56f4a2a ?? [];
        player setorigin( respawn_point.origin );
        player setplayerangles( respawn_point.angles );
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0x90b4053c, Offset: 0x54fc
    // Size: 0x486, Type: dev
    function private function_e8a0dbf6e63ad93d()
    {
        rules = [];
        rules[ "<dev string:x715>" ] = 7;
        rules[ "<dev string:x721>" ] = 1;
        rules[ "<dev string:x730>" ] = 1;
        rules[ "<dev string:x73d>" ] = 3;
        rules[ "<dev string:x74d>" ] = 4;
        
        foreach ( zone_struct in level.zone_manager.defs )
        {
            var_e95be439311c8547 = zone_struct get_adjacent_zones( 1, 1 );
            var_e95be439311c8547[ var_e95be439311c8547.size ] = zone_struct;
            zone_struct.spawner_info = [];
            
            foreach ( ai_type in getarraykeys( level.var_6a0ca82b96021d66 ) )
            {
                zone_struct.spawner_info[ ai_type ] = 0;
            }
            
            foreach ( enabled_zone in var_e95be439311c8547 )
            {
                zone_spawn_locs = level.var_1d03be60f0a95b1c[ enabled_zone.script_zone_name ];
                
                if ( zone_spawn_locs )
                {
                    foreach ( spawn_loc in zone_spawn_locs )
                    {
                        foreach ( ai_type in getarraykeys( level.var_6a0ca82b96021d66 ) )
                        {
                            if ( arraycontains( spawn_loc.ai_subclasses, ai_type ) )
                            {
                                zone_struct.spawner_info[ ai_type ]++;
                            }
                        }
                    }
                }
            }
        }
        
        warning_zones = [];
        zone_spawner_num = [];
        
        foreach ( zone_struct in level.zone_manager.defs )
        {
            zone_spawner_num[ zone_struct.script_zone_name ] = zone_struct.spawner_info;
        }
        
        foreach ( var_570a26cf7e5061b8 in getarraykeys( zone_spawner_num ) )
        {
            zone = zone_spawner_num[ var_570a26cf7e5061b8 ];
            
            foreach ( rule in getarraykeys( rules ) )
            {
                if ( zone[ rule ] )
                {
                    if ( zone[ rule ] < rules[ rule ] )
                    {
                        warning_zones[ var_570a26cf7e5061b8 ] = zone;
                        break;
                    }
                }
            }
        }
    }

    // Namespace zone_manager
    // Params 0, eflags: 0x4
    // Checksum 0xa99ca08e, Offset: 0x598a
    // Size: 0x137, Type: dev
    function private function_a3ec39664f473fc7()
    {
        str_zone_name = getdvar( @"zm_start_zone" );
        
        if ( !str_zone_name || str_zone_name == "<dev string:x68f>" )
        {
            return;
        }
        
        level utility::flag_wait( "<dev string:x75b>" );
        zm_utility::open_sesame();
        var_c81f018776f17dae = function_9dd25e9fb0ecd45b( str_zone_name );
        assert( var_c81f018776f17dae.size, "<dev string:x772>" + str_zone_name + "<dev string:x794>" );
        a_respawn_points = var_c81f018776f17dae[ 0 ].var_f448a26cf56f4a2a;
        
        foreach ( player in level.players )
        {
            index = player getentitynumber();
            var_99064b9592368173 = a_respawn_points[ index ];
            player setorigin( var_99064b9592368173.origin );
            player setplayerangles( var_99064b9592368173.angles );
        }
    }

#/
