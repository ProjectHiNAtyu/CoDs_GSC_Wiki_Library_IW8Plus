// scripts\common\waypoint_objective_handler.gsc  (hash_33603468db56cdce.gscc) (size: 9550 Bytes / 0x254e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72167f0b (1914076939)
// size ...... 9550 (0x254e)
// includes .. 5   (offset: 0x23e2)
// strings ... 15  (offset: 0x240a)
// dev strs .. 9   (offset: 0x24e2)
// exports ... 23  (offset: 0x17fe)
// cseg ...... 0x1b5 + 0x1649 (0x17fe)
// imports ... 68  (offset: 0x1b96)
// animtree1 . 0   (offset: 0x254e)
// animtree2 . 0   (offset: 0x254e)
#using scripts\common\debug;
#using scripts\common\spatial_grid;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint;

#namespace waypoint_objective_handler;

// Namespace waypoint_objective_handler
// Params 0, eflags: 0x5
// Checksum 0x16a350ae, Offset: 0x1d3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"waypoint_objective_handler", undefined, undefined, &post_main );
}

// Namespace waypoint_objective_handler
// Params 0, eflags: 0x4
// Checksum 0x6d0775a6, Offset: 0x1f4
// Size: 0x5e
function private post_main()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 )
        {
            return;
        }
        
        setdvarifuninitialized( @"scr_debug_waypoint_objective_handler", 0 );
        setdvarifuninitialized( @"scr_debug_draw_waypoint", 0 );
        setdvarifuninitialized( @"hash_7aa3c7768aec5c84", 5 );
        thread debug_draw_waypoints();
    #/
    
    function_2b8eb334b08f85d2();
    level.waypointobjectiveid = 0;
}

// Namespace waypoint_objective_handler
// Params 14
// Checksum 0x3e28ae0f, Offset: 0x25a
// Size: 0xcc
function waypoint_objective_handler( waypoint_update_callback, str_objective_start, done_notification, var_2ec40eb41a3473d8, var_1288e7582a6bdb5, waypoint_bundle, var_37b53ff85831ed1c = 1, use_nav_modifier = 1, z_offset = 32, sync_status, trigger_required, cancel_on_death, hide_elevation, objective_offset )
{
    waypoint_array = objective_array_setup( str_objective_start );
    level waypoint_objective_handler_internal( waypoint_array, str_objective_start, done_notification, var_2ec40eb41a3473d8, waypoint_update_callback, var_1288e7582a6bdb5, waypoint_bundle, var_37b53ff85831ed1c, use_nav_modifier, z_offset, sync_status, trigger_required, cancel_on_death, hide_elevation, objective_offset );
}

// Namespace waypoint_objective_handler
// Params 2
// Checksum 0xef4f2ade, Offset: 0x32e
// Size: 0x126
function waypoint_objective_handler_cancel( str_objective_start, var_1288e7582a6bdb5 )
{
    assert( isstring( str_objective_start ) );
    player_array_use = function_6fe3ed5569afe36e( var_1288e7582a6bdb5 );
    
    if ( !isarray( player_array_use ) || player_array_use.size == 0 )
    {
        logstring( "[WAYPOINT OBJECTIVE] Cancelling [" + str_objective_start + "]: no valid players." );
        return;
    }
    
    foreach ( player in player_array_use )
    {
        if ( !isdefined( player.waypoint_objective_state ) )
        {
            player.waypoint_objective_state = [];
        }
        
        if ( !isdefined( player.var_52f632411cc75d51 ) )
        {
            player.var_52f632411cc75d51 = [];
        }
        
        player.waypoint_objective_state[ str_objective_start ] = 3;
        player.var_52f632411cc75d51[ str_objective_start ] = undefined;
        player notify( "cancel_waypoint_objective_handler" + str_objective_start );
    }
}

// Namespace waypoint_objective_handler
// Params 1
// Checksum 0xc9497c1b, Offset: 0x45c
// Size: 0x25
function function_c2eeb9e0ffc2533d( str_objective_start )
{
    assert( isplayer( self ) );
    return self.waypoint_objective_state[ str_objective_start ];
}

// Namespace waypoint_objective_handler
// Params 0
// Checksum 0x9357e986, Offset: 0x48a
// Size: 0x18
function function_22c79c4675aa5cd9()
{
    assert( isplayer( self ) );
    return self.var_52f632411cc75d51;
}

// Namespace waypoint_objective_handler
// Params 15, eflags: 0x4
// Checksum 0xabfb2fc4, Offset: 0x4ab
// Size: 0x368
function private waypoint_objective_handler_internal( waypoint_array, str_objective_start, done_notification, var_2ec40eb41a3473d8, waypoint_update_callback, var_1288e7582a6bdb5, waypoint_bundle, var_37b53ff85831ed1c, use_nav_modifier, z_offset, sync_status, trigger_required, cancel_on_death, hide_elevation, objective_offset )
{
    player_array_use = function_6fe3ed5569afe36e( var_1288e7582a6bdb5 );
    
    if ( !isarray( player_array_use ) || player_array_use.size == 0 )
    {
        logstring( "[WAYPOINT OBJECTIVE] Adding [" + str_objective_start + "]: no valid players." );
        return;
    }
    
    assert( isarray( waypoint_array ), "<dev string:x24>" );
    assert( isstring( done_notification ), "<dev string:x4c>" );
    
    /#
        function_c71fc1075773b9c4( var_1288e7582a6bdb5, str_objective_start );
    #/
    
    level.waypointobjectiveid++;
    var_6040dae1232bc9c0 = { #array:waypoint_array };
    objective_id = "waypoint_objective_id_" + level.waypointobjectiveid;
    var_1bdaa4a84f4f1e6 = sync_status ? "sync_" + objective_id : undefined;
    no_valid_players = undefined;
    var_4a52784a231affd5 = undefined;
    
    while ( true )
    {
        if ( isarray( var_1288e7582a6bdb5 ) )
        {
            var_1288e7582a6bdb5 = function_aa73316886583cc6( var_1288e7582a6bdb5, str_objective_start );
        }
        
        var_b002c58e53b23db9 = 0;
        var_dc4fa75655c6106d = 0;
        player_array_use = function_6fe3ed5569afe36e( var_1288e7582a6bdb5 );
        
        if ( !isarray( player_array_use ) )
        {
            if ( var_4a52784a231affd5 )
            {
                no_valid_players = 1;
                break;
            }
            
            level utility::waittill_notify_or_timeout( waypoint_player_cancelled_notification( objective_id ), 0.5 );
            continue;
        }
        
        foreach ( player in player_array_use )
        {
            if ( player && !utility::is_dead_or_dying( player ) && player isconnected() && ( !isdefined( player.sessionstate ) || player.sessionstate == "playing" ) && player function_c2eeb9e0ffc2533d( str_objective_start ) != 3 )
            {
                var_dc4fa75655c6106d++;
                var_4a52784a231affd5 = 1;
                
                if ( !isdefined( player function_c2eeb9e0ffc2533d( str_objective_start ) ) )
                {
                    player childthread function_e52780920c175c2c( var_6040dae1232bc9c0.array, str_objective_start, var_2ec40eb41a3473d8, waypoint_update_callback, waypoint_bundle, var_37b53ff85831ed1c, use_nav_modifier, z_offset, objective_id, var_1bdaa4a84f4f1e6, trigger_required, cancel_on_death, hide_elevation, objective_offset );
                    
                    if ( sync_status )
                    {
                        var_6040dae1232bc9c0 childthread function_57690f6fb2490a64( var_1bdaa4a84f4f1e6, player_array_use );
                    }
                    
                    var_b002c58e53b23db9 = 1;
                }
                else if ( player function_c2eeb9e0ffc2533d( str_objective_start ) != 2 )
                {
                    var_b002c58e53b23db9 = 1;
                }
            }
            
            /#
                if ( getdvarint( @"scr_debug_waypoint_objective_handler", 0 ) )
                {
                    iprintlnbold( "<dev string:x77>" + var_dc4fa75655c6106d + "<dev string:x87>" + player_array_use.size );
                }
            #/
        }
        
        if ( !var_b002c58e53b23db9 )
        {
            break;
        }
        
        level utility::waittill_notify_or_timeout( waypoint_player_cancelled_notification( objective_id ), 0.5 );
    }
    
    all_players_canceled = function_463dfadacd1dd346( var_1288e7582a6bdb5, str_objective_start );
    function_64af4b43f0e2f06c( var_1288e7582a6bdb5, str_objective_start );
    
    if ( done_notification && !all_players_canceled && !no_valid_players )
    {
        level notify( done_notification );
    }
}

// Namespace waypoint_objective_handler
// Params 2, eflags: 0xc
// Checksum 0x854e5abf, Offset: 0x81b
// Size: 0x12f
function private function_57690f6fb2490a64( var_1bdaa4a84f4f1e6, player_array_use )
{
    self notify( #"hash_1242ac1a08a9b7a1" );
    self endon( #"hash_1242ac1a08a9b7a1" );
    
    while ( self.array.size > 0 )
    {
        level waittill( var_1bdaa4a84f4f1e6, waypoint, player );
        
        if ( !arraycontains( player_array_use, player ) )
        {
            continue;
        }
        
        var_67b1b188d101341e = function_f02c63b99c9614c9( self.array, waypoint );
        
        foreach ( player in player_array_use )
        {
            for ( i = 0; i <= var_67b1b188d101341e ; i++ )
            {
                player notify( #"waypoint_triggered", self.array[ i ] );
            }
        }
        
        self.array = utility::array_slice( self.array, var_67b1b188d101341e + 1 );
    }
}

// Namespace waypoint_objective_handler
// Params 2, eflags: 0x4
// Checksum 0xa1e7b1a, Offset: 0x952
// Size: 0x127
function private function_aa73316886583cc6( var_1288e7582a6bdb5, str_objective_start )
{
    var_cf6e9fbe7341ce68 = [];
    
    foreach ( player in var_1288e7582a6bdb5 )
    {
        state = player function_c2eeb9e0ffc2533d( str_objective_start );
        
        if ( state == 3 )
        {
            var_cf6e9fbe7341ce68[ var_cf6e9fbe7341ce68.size ] = player;
        }
    }
    
    foreach ( player in var_cf6e9fbe7341ce68 )
    {
        var_1288e7582a6bdb5 = arrayremove( var_1288e7582a6bdb5, player );
    }
    
    if ( var_cf6e9fbe7341ce68.size > 0 )
    {
        function_64af4b43f0e2f06c( var_cf6e9fbe7341ce68, str_objective_start );
    }
    
    return var_1288e7582a6bdb5;
}

// Namespace waypoint_objective_handler
// Params 1
// Checksum 0x2441dfb2, Offset: 0xa82
// Size: 0x166
function function_6fe3ed5569afe36e( var_1288e7582a6bdb5 )
{
    if ( isstring( var_1288e7582a6bdb5 ) )
    {
        if ( isarray( level.teamdata ) && isarray( level.teamdata[ var_1288e7582a6bdb5 ] ) && isarray( level.teamdata[ var_1288e7582a6bdb5 ][ "players" ] ) )
        {
            player_array_use = level.teamdata[ var_1288e7582a6bdb5 ][ "players" ];
        }
        else
        {
            return;
        }
    }
    else if ( isstruct( var_1288e7582a6bdb5 ) )
    {
        team = var_1288e7582a6bdb5.team;
        squad = var_1288e7582a6bdb5.squad;
        
        if ( !isarray( level.squaddata[ team ] ) )
        {
            return;
        }
        
        if ( !isstruct( level.squaddata[ team ][ squad ] ) )
        {
            return;
        }
        
        return level.squaddata[ team ][ squad ].players;
    }
    else if ( isplayer( var_1288e7582a6bdb5 ) )
    {
        return [ var_1288e7582a6bdb5 ];
    }
    else if ( isarray( var_1288e7582a6bdb5 ) )
    {
        return var_1288e7582a6bdb5;
    }
    else if ( isarray( self.playerparticipants ) )
    {
        return self.playerparticipants;
    }
    else if ( isstruct( self ) && self != level && isarray( self.players ) )
    {
        return self.players;
    }
    
    return level.players;
}

// Namespace waypoint_objective_handler
// Params 14, eflags: 0x4
// Checksum 0x992524ee, Offset: 0xbf1
// Size: 0x207
function private function_e52780920c175c2c( waypoint_array, str_objective_start, var_2ec40eb41a3473d8, waypoint_update_callback, waypoint_bundle, var_37b53ff85831ed1c, use_nav_modifier, z_offset, objective_id, var_1bdaa4a84f4f1e6, trigger_required, cancel_on_death, hide_elevation, objective_offset )
{
    self.waypoint_objective_state[ str_objective_start ] = 1;
    
    if ( !isdefined( self.var_52f632411cc75d51 ) )
    {
        self.var_52f632411cc75d51 = [];
    }
    
    self.var_52f632411cc75d51[ str_objective_start ] = waypoint_array;
    self endon( #"disconnect" );
    
    if ( cancel_on_death )
    {
        self endon( #"death" );
    }
    
    data = spawnstruct();
    data.waypoint_bundle = waypoint_bundle;
    data.var_37b53ff85831ed1c = var_37b53ff85831ed1c;
    data.hide_elevation = hide_elevation ?? 0;
    data.objective_offset = objective_offset ?? ( 0, 0, 0 );
    
    while ( waypoint_array.size > 0 && function_c2eeb9e0ffc2533d( str_objective_start ) != 3 )
    {
        waypoint = waypoint_array[ 0 ];
        waypoint.data = data;
        
        if ( waypoint.script_flag_wait )
        {
            level utility::flag_wait( waypoint.script_flag_wait );
        }
        else
        {
            waypoint_struct = waypoint::function_82e30c4150fe2cf4( waypoint, waypoint_update_callback, use_nav_modifier, z_offset, var_1bdaa4a84f4f1e6, trigger_required, cancel_on_death );
            thread function_4750464ab8bd19fc( waypoint_struct, objective_id, waypoint_update_callback, str_objective_start, cancel_on_death );
            function_10f548925d73e8b8( waypoint_struct );
            waypoint::monitor_stop( waypoint_struct );
            cleanup_waypoint( waypoint_struct, waypoint_update_callback );
        }
        
        waypoint_array = arrayremove( waypoint_array, waypoint );
    }
    
    if ( function_c2eeb9e0ffc2533d( str_objective_start ) == 3 )
    {
        return;
    }
    
    if ( var_2ec40eb41a3473d8 )
    {
        self notify( var_2ec40eb41a3473d8 );
    }
    
    self.waypoint_objective_state[ str_objective_start ] = 2;
    self.var_52f632411cc75d51[ str_objective_start ] = undefined;
}

// Namespace waypoint_objective_handler
// Params 2, eflags: 0x4
// Checksum 0x84da1c9c, Offset: 0xe00
// Size: 0x38
function private cleanup_waypoint( waypoint_struct, waypoint_update_callback )
{
    if ( isdefined( waypoint_struct ) && isfunction( waypoint_update_callback ) )
    {
        waypoint_struct.origin = undefined;
        self [[ waypoint_update_callback ]]( waypoint_struct );
    }
}

// Namespace waypoint_objective_handler
// Params 6, eflags: 0x4
// Checksum 0x46597959, Offset: 0xe40
// Size: 0xac
function private function_4750464ab8bd19fc( waypoint_struct, objective_id, waypoint_update_callback, str_objective_start, var_3512e2a58aa1084e, cancel_on_death )
{
    waypoint_struct endon( #"monitor_stop" );
    
    if ( cancel_on_death )
    {
        utility::waittill_any( "cancel_waypoint_objective_handler" + str_objective_start, "death", "disconnect" );
    }
    else
    {
        utility::waittill_any( "cancel_waypoint_objective_handler" + str_objective_start, "disconnect" );
    }
    
    waypoint_struct.was_canceled = 1;
    cleanup_waypoint( waypoint_struct, waypoint_update_callback );
    
    if ( objective_id )
    {
        level notify( waypoint_player_cancelled_notification( objective_id ) );
    }
    
    waypoint::monitor_stop( waypoint_struct );
}

// Namespace waypoint_objective_handler
// Params 1, eflags: 0x4
// Checksum 0x12ec1003, Offset: 0xef4
// Size: 0x74
function private function_10f548925d73e8b8( waypoint_struct )
{
    self endon( #"disconnect" );
    
    if ( waypoint_struct.cancel_on_death )
    {
        self endon( #"death" );
    }
    
    waypoint_struct endon( #"waypoint_triggered" );
    
    while ( true )
    {
        self waittill( #"waypoint_triggered", waypoint );
        
        if ( waypoint == waypoint_struct.waypoint )
        {
            break;
        }
    }
}

// Namespace waypoint_objective_handler
// Params 2, eflags: 0x4
// Checksum 0x7718ffaf, Offset: 0xf70
// Size: 0xf2
function private function_64af4b43f0e2f06c( var_1288e7582a6bdb5, str_objective_start )
{
    player_array_use = function_6fe3ed5569afe36e( var_1288e7582a6bdb5 );
    
    if ( !isarray( player_array_use ) )
    {
        return;
    }
    
    foreach ( player in player_array_use )
    {
        if ( player )
        {
            if ( !isdefined( player.waypoint_objective_state ) )
            {
                player.waypoint_objective_state = [];
            }
            
            if ( !isdefined( player.var_52f632411cc75d51 ) )
            {
                player.var_52f632411cc75d51 = [];
            }
            
            player.waypoint_objective_state[ str_objective_start ] = undefined;
            player.var_52f632411cc75d51[ str_objective_start ] = undefined;
        }
    }
}

/#

    // Namespace waypoint_objective_handler
    // Params 2, eflags: 0x4
    // Checksum 0x2bc5d1e6, Offset: 0x106a
    // Size: 0xcb, Type: dev
    function private function_c71fc1075773b9c4( var_1288e7582a6bdb5, str_objective_start )
    {
        player_array_use = function_6fe3ed5569afe36e( var_1288e7582a6bdb5 );
        
        if ( !isarray( player_array_use ) || player_array_use.size == 0 )
        {
            return;
        }
        
        foreach ( player in player_array_use )
        {
            if ( player )
            {
                state = player function_c2eeb9e0ffc2533d( str_objective_start );
                assert( !isdefined( state ) );
            }
        }
    }

#/

// Namespace waypoint_objective_handler
// Params 2, eflags: 0x4
// Checksum 0x4839f136, Offset: 0x113d
// Size: 0xb9
function private function_463dfadacd1dd346( var_1288e7582a6bdb5, str_objective_start )
{
    player_array_use = function_6fe3ed5569afe36e( var_1288e7582a6bdb5 );
    all_players_canceled = 1;
    
    foreach ( player in player_array_use )
    {
        if ( player && player function_c2eeb9e0ffc2533d( str_objective_start ) != 3 )
        {
            all_players_canceled = 0;
            break;
        }
    }
    
    return all_players_canceled;
}

// Namespace waypoint_objective_handler
// Params 1, eflags: 0x4
// Checksum 0x32efe5b9, Offset: 0x11ff
// Size: 0x99
function private objective_array_setup( var_3ca8aff3d1e9fc14 )
{
    struct_array = [];
    
    for ( s_obj_current = utility::getstruct( var_3ca8aff3d1e9fc14, "targetname" ); true ; s_obj_current = s_obj_next )
    {
        struct_array[ struct_array.size ] = s_obj_current;
        
        if ( !isdefined( s_obj_current.target ) )
        {
            break;
        }
        
        s_obj_next = utility::getstruct( s_obj_current.target, "targetname" );
        
        if ( !isdefined( s_obj_next ) )
        {
            assertmsg( "<dev string:x9b>" + s_obj_current.target );
            return;
        }
    }
    
    return struct_array;
}

// Namespace waypoint_objective_handler
// Params 0, eflags: 0x4
// Checksum 0xe25531b5, Offset: 0x12a1
// Size: 0x11f
function private function_2b8eb334b08f85d2()
{
    if ( !spatial_grid::function_9610dcc083b0f8c8( "waypoint_override_pos" ) )
    {
        struct_array = utility::getstructarray( "waypoint_objective_override_pos", "script_noteworthy" );
        spatial_grid::create_category( "waypoint_override_pos", 0, 1 );
        
        foreach ( struct in struct_array )
        {
            simple_struct = spawnstruct();
            simple_struct.origin = struct.origin;
            simple_struct.var_f9e656b1894a327c = int( struct.var_f9e656b1894a327c ?? 0 );
            
            if ( isdefined( struct.radius ) )
            {
                simple_struct.radiussq = squared( struct.radius );
            }
            
            spatial_grid::add( "waypoint_override_pos", simple_struct );
        }
    }
}

// Namespace waypoint_objective_handler
// Params 1
// Checksum 0xfedb283d, Offset: 0x13c8
// Size: 0xf8
function function_ce3c53ff7662012e( origin )
{
    results = spatial_grid::query( "waypoint_override_pos", origin, 150 );
    
    if ( results.size == 0 )
    {
        return;
    }
    
    var_a2621f468b05d4c3 = undefined;
    closest_distsq = undefined;
    
    foreach ( struct in results )
    {
        distsq = distancesquared( struct.origin, origin );
        
        if ( struct.radiussq < distsq )
        {
            continue;
        }
        
        if ( !isdefined( closest_distsq ) || distsq < closest_distsq )
        {
            closest_distsq = distsq;
            var_a2621f468b05d4c3 = struct;
        }
    }
    
    return var_a2621f468b05d4c3;
}

// Namespace waypoint_objective_handler
// Params 1, eflags: 0x4
// Checksum 0x721c9e13, Offset: 0x14c9
// Size: 0x14
function private waypoint_player_cancelled_notification( objective_id )
{
    return "waypoint_player_cancelled_notification_" + objective_id;
}

/#

    // Namespace waypoint_objective_handler
    // Params 0
    // Checksum 0xc4e35a12, Offset: 0x14e6
    // Size: 0x318, Type: dev
    function debug_draw_waypoints()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( !getdvarint( @"scr_debug_draw_waypoint", 0 ) )
            {
                waitframe();
                continue;
            }
            
            for ( playerindex = 0; playerindex < level.players.size ; playerindex++ )
            {
                player = level.players[ playerindex ];
                debugtextoffset = ( 0, 0, 10 * playerindex );
                var_3588a33bc9668195 = "<dev string:xc6>" + player.name;
                waypointstructs = player waypoint::function_9d574fd4df1af10f();
                
                foreach ( waypointstruct in waypointstructs )
                {
                    waypoint = waypointstruct.waypoint;
                    debug::print3d( waypoint.origin + debugtextoffset, waypoint.targetname + "<dev string:xd1>" + ( waypoint.radius ?? "<dev string:xdc>" ) + var_3588a33bc9668195, ( 1, 0, 0 ), 1 );
                    debug::cylinder( waypoint.origin - ( 0, 0, 25 ), waypoint.origin + ( 0, 0, 25 ), waypoint.radius ?? 15, ( 1, 0, 0 ), 1 );
                    
                    if ( waypointstruct.origin != waypoint.origin )
                    {
                        debug::print3d( waypointstruct.origin + ( 0, 0, waypointstruct.z_offset ) + debugtextoffset, waypointstruct.waypoint.targetname + var_3588a33bc9668195, ( 0, 1, 0 ), 1 );
                        debug::sphere( waypointstruct.origin, 15, ( 0, 1, 0 ), 1 );
                    }
                    
                    var_cda9740372d1f095 = waypointstruct.origin;
                    
                    for ( i = 0; i < getdvarint( @"hash_7aa3c7768aec5c84", 5 ) ; i++ )
                    {
                        var_c942709304ebf2e = player function_5cc101312fa3d590( var_cda9740372d1f095, waypoint.origin, "<dev string:xe6>", undefined, 128 );
                        
                        if ( !isvector( var_c942709304ebf2e ) )
                        {
                            break;
                        }
                        
                        debug::sphere( var_c942709304ebf2e, 15, ( 0, 0, 1 ), 1 );
                        debug::line( var_cda9740372d1f095, var_c942709304ebf2e, ( 0, 0, 1 ), 1 );
                        var_cda9740372d1f095 = var_c942709304ebf2e;
                    }
                    
                    debug::line( var_cda9740372d1f095, waypoint.origin, ( 0, 0, 1 ), 1 );
                }
            }
            
            wait 1;
        }
    }

#/
