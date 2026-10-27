// scripts\common\waypoint.gsc  (hash_5ef1ce2770f4ebb5.gscc) (size: 3655 Bytes / 0xe47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc760aa42 (3345001026)
// size ...... 3655 (0xe47)
// includes .. 2   (offset: 0xe03)
// strings ... 4   (offset: 0xe13)
// dev strs .. 0   (offset: 0xe47)
// exports ... 8   (offset: 0x967)
// cseg ...... 0xa2 + 0x8c5 (0x967)
// imports ... 28  (offset: 0xaa7)
// animtree1 . 0   (offset: 0xe47)
// animtree2 . 0   (offset: 0xe47)
#using scripts\common\throttle;
#using scripts\common\utility;

#namespace waypoint;

// Namespace waypoint
// Params 7
// Checksum 0x265c8a76, Offset: 0xc0
// Size: 0xf1
function function_82e30c4150fe2cf4( waypoint, waypoint_update_callback, use_nav_modifier, z_offset, var_1bdaa4a84f4f1e6, trigger_required, cancel_on_death )
{
    waypoint_struct = spawnstruct();
    waypoint_struct.waypoint = waypoint;
    waypoint_struct.origin = waypoint.origin;
    waypoint_struct.use_nav_modifier = use_nav_modifier;
    waypoint_struct.z_offset = z_offset;
    waypoint_struct.is_final_position = 1;
    waypoint_struct.cancel_on_death = cancel_on_death;
    
    if ( !isdefined( self.var_5fb453b72b75ca1b ) )
    {
        self.var_5fb453b72b75ca1b = [];
    }
    
    self.var_5fb453b72b75ca1b = arraycombineunique( self.var_5fb453b72b75ca1b, [ waypoint_struct ] );
    thread monitor_internal( waypoint_struct, waypoint_update_callback, var_1bdaa4a84f4f1e6, trigger_required );
    return waypoint_struct;
}

// Namespace waypoint
// Params 1
// Checksum 0x2f666eae, Offset: 0x1ba
// Size: 0x46
function monitor_stop( waypoint_struct )
{
    if ( self && isarray( self.var_5fb453b72b75ca1b ) )
    {
        self.var_5fb453b72b75ca1b = arrayremove( self.var_5fb453b72b75ca1b, waypoint_struct );
    }
    
    waypoint_struct notify( #"monitor_stop" );
}

// Namespace waypoint
// Params 0
// Checksum 0x728e4003, Offset: 0x208
// Size: 0x18
function function_9d574fd4df1af10f()
{
    assert( isplayer( self ) );
    return self.var_5fb453b72b75ca1b;
}

// Namespace waypoint
// Params 4, eflags: 0x4
// Checksum 0x2f09a7e5, Offset: 0x229
// Size: 0x529
function private monitor_internal( waypoint_struct, waypoint_update_callback, var_1bdaa4a84f4f1e6, trigger_required )
{
    self endon( #"disconnect" );
    
    if ( waypoint_struct.cancel_on_death )
    {
        self endon( #"death" );
    }
    
    waypoint_struct endon( #"monitor_stop" );
    
    if ( isdefined( waypoint_update_callback ) )
    {
        self [[ waypoint_update_callback ]]( waypoint_struct );
    }
    
    if ( !isdefined( level.waypoint_monitor_update_throttle ) )
    {
        level.waypoint_monitor_update_throttle = throttle::throttle_initialize( "waypoint_monitor_update", 1, level.framedurationseconds, 4 );
    }
    
    var_878163f0cddc0d19 = waypoint_struct.waypoint.origin;
    update_final_position = 0;
    var_9735e4b72ec142a5 = 0;
    var_75b292effb7d344e = squared( 500 );
    var_7ae605d773736268 = waypoint_struct.waypoint.radius ? squared( waypoint_struct.waypoint.radius ) : 0;
    var_fb30f75664eaed34 = [];
    
    if ( !waypoint_struct.use_nav_modifier )
    {
        for ( var_9af85792aa0000fc = utility::getstructarray( waypoint_struct.waypoint.targetname + "_breadcrumb_start", "targetname" ); var_9af85792aa0000fc.size > 0 ; var_9af85792aa0000fc = next_breadcrumbs )
        {
            var_878163f0cddc0d19 = undefined;
            var_fb30f75664eaed34[ var_fb30f75664eaed34.size ] = var_9af85792aa0000fc;
            next_breadcrumbs = [];
            
            foreach ( breadcrumb in var_9af85792aa0000fc )
            {
                if ( isstring( breadcrumb.target ) )
                {
                    next_breadcrumbs = arraycombineunique( next_breadcrumbs, utility::getstructarray( breadcrumb.target, "targetname" ) );
                }
            }
        }
        
        if ( var_fb30f75664eaed34.size > 0 )
        {
            var_fb30f75664eaed34[ var_fb30f75664eaed34.size ] = [ waypoint_struct.waypoint ];
        }
    }
    
    while ( true )
    {
        closest_breadcrumb = undefined;
        
        if ( var_fb30f75664eaed34.size > 0 )
        {
            current_breadcrumb = get_current_breadcrumb( var_fb30f75664eaed34, trigger_required );
            
            if ( var_878163f0cddc0d19 != current_breadcrumb.origin )
            {
                is_final_position = current_breadcrumb.origin == waypoint_struct.waypoint.origin;
                
                if ( !is_final_position )
                {
                    waypoint_struct.var_3e509260f3e3f2a4 = int( current_breadcrumb.var_f9e656b1894a327c ?? 0 );
                }
                
                waypoint_struct waypoint_update( self, current_breadcrumb.origin, !is_final_position, is_final_position, waypoint_update_callback );
                var_fb30f75664eaed34 = var_fb30f75664eaed34 breadcrumb_info_cleanup( current_breadcrumb );
                var_878163f0cddc0d19 = current_breadcrumb.origin;
            }
            
            closest_breadcrumb = function_47c86977a18df38b( utility::array_combine_multiple( var_fb30f75664eaed34 ), self.origin );
            
            if ( distancesquared( closest_breadcrumb.origin, self.origin ) < squared( closest_breadcrumb.radius ) )
            {
                var_fb30f75664eaed34 = var_fb30f75664eaed34 breadcrumb_info_cleanup( closest_breadcrumb, 1 );
            }
        }
        else if ( waypoint_struct.use_nav_modifier && gettime() >= var_9735e4b72ec142a5 )
        {
            throttle::throttle_wait_in_queue( level.waypoint_monitor_update_throttle, self );
            mod_loc = self function_5cc101312fa3d590( getclosestpointonnavmesh( self.origin ), waypoint_struct.waypoint.origin, "waypoint", undefined, 128 );
            
            if ( isvector( mod_loc ) && distancesquared( var_878163f0cddc0d19, mod_loc ) > 1024 )
            {
                if ( var_878163f0cddc0d19 != mod_loc )
                {
                    var_878163f0cddc0d19 = mod_loc;
                    waypoint_struct waypoint_update( self, var_878163f0cddc0d19, 1, undefined, waypoint_update_callback );
                }
                
                update_final_position = 1;
            }
            else if ( !isvector( mod_loc ) && update_final_position )
            {
                if ( var_878163f0cddc0d19 != waypoint_struct.waypoint.origin )
                {
                    var_878163f0cddc0d19 = waypoint_struct.waypoint.origin;
                    waypoint_struct waypoint_update( self, var_878163f0cddc0d19, undefined, 1, waypoint_update_callback );
                }
                
                update_final_position = 0;
            }
            
            var_9735e4b72ec142a5 = gettime() + 0.25;
        }
        
        dist_squared = distancesquared( waypoint_struct.waypoint.origin, self.origin );
        
        if ( dist_squared <= var_7ae605d773736268 )
        {
            waypoint_struct notify( #"waypoint_triggered" );
            
            if ( isstring( var_1bdaa4a84f4f1e6 ) )
            {
                level notify( var_1bdaa4a84f4f1e6, waypoint_struct.waypoint, self );
            }
        }
        else if ( closest_breadcrumb )
        {
            if ( distancesquared( closest_breadcrumb.origin, self.origin ) >= var_75b292effb7d344e )
            {
                wait 1;
            }
        }
        else if ( dist_squared - var_7ae605d773736268 >= var_75b292effb7d344e )
        {
            wait_time = 1;
            
            if ( waypoint_struct.use_nav_modifier )
            {
                wait_time = max( level.framedurationseconds, var_9735e4b72ec142a5 - gettime() );
            }
            
            wait wait_time - level.framedurationseconds;
        }
        
        waitframe();
    }
}

// Namespace waypoint
// Params 5, eflags: 0x4
// Checksum 0x14034461, Offset: 0x75a
// Size: 0x5d
function private waypoint_update( player, position, use_override, is_final_position, waypoint_update_callback )
{
    if ( waypoint_update_callback )
    {
        self.origin = position;
        self.use_override = use_override;
        self.is_final_position = is_final_position;
        player [[ waypoint_update_callback ]]( self );
    }
}

// Namespace waypoint
// Params 2, eflags: 0x4
// Checksum 0x5fa0d856, Offset: 0x7bf
// Size: 0x13c
function private get_current_breadcrumb( var_fb30f75664eaed34, trigger_required )
{
    closest_breadcrumb = function_47c86977a18df38b( utility::array_combine_multiple( var_fb30f75664eaed34 ), self.origin );
    
    foreach ( breadcrumb_array in var_fb30f75664eaed34 )
    {
        foreach ( breadcrumb in breadcrumb_array )
        {
            if ( int( breadcrumb.var_a599ed8791c4f860 ?? 0 ) || trigger_required )
            {
                return function_47c86977a18df38b( breadcrumb_array, self.origin );
            }
            
            if ( breadcrumb == closest_breadcrumb )
            {
                return closest_breadcrumb;
            }
        }
    }
    
    return closest_breadcrumb;
}

// Namespace waypoint
// Params 2, eflags: 0x4
// Checksum 0x86e33d66, Offset: 0x904
// Size: 0x62
function private breadcrumb_info_cleanup( breadcrumb, var_cc824048d651d86e )
{
    index = undefined;
    
    for ( i = 0; i < self.size ; i++ )
    {
        if ( arraycontains( self[ i ], breadcrumb ) )
        {
            index = i;
            break;
        }
    }
    
    return utility::array_slice( self, index + ( var_cc824048d651d86e ? 1 : 0 ) );
}

