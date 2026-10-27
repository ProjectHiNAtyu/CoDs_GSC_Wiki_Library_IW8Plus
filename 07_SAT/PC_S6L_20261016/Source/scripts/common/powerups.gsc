// scripts\common\powerups.gsc  (hash_427ce33ec0c820cf.gscc) (size: 29102 Bytes / 0x71ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x349d2613 (882714131)
// size ...... 29102 (0x71ae)
// includes .. 9   (offset: 0x6be2)
// strings ... 64  (offset: 0x6c2a)
// dev strs .. 27  (offset: 0x7056)
// exports ... 76  (offset: 0x496a)
// cseg ...... 0x4e5 + 0x4485 (0x496a)
// imports ... 176 (offset: 0x554a)
// animtree1 . 0   (offset: 0x71ae)
// animtree2 . 0   (offset: 0x71ae)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scripted_widgets;
#using scripts\common\telemetry_utils;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace powerups;

// Namespace powerups
// Params 2
// Checksum 0xb85e90bd, Offset: 0x503
// Size: 0x11d
function init_powerups( str_drop_event, var_52d60db24fd81a96 )
{
    level utility::flag_set( "drop_powerups" );
    root = get_powerups_root();
    root.active_powerups = [];
    root.powerups = [];
    root.powerup_index = 0;
    root.powerup_list_index = [];
    root.powerup_drop_array = [];
    level thread _init_powerups( str_drop_event, var_52d60db24fd81a96 );
    utility::registersharedfunc( #"powerups", #"dropPowerup", &powerup_drop );
    utility::registersharedfunc( #"powerups", #"hudclear", &function_b6d20332b27fa42e );
    utility::registersharedfunc( #"powerups", #"getroot", &get_powerups_root );
    utility::registersharedfunc( #"powerups", #"hash_4ca007fc716f1af9", &register_powerup_dropped_callback );
    val::register( "scorepoints_scalar", 1, 1, "$self", &set_scorepoints_mult, "$value" );
}

// Namespace powerups
// Params 2, eflags: 0x4
// Checksum 0x95cc9bce, Offset: 0x628
// Size: 0x728
function private _init_powerups( str_drop_event, var_52d60db24fd81a96 )
{
    utility::flag_wait( "system_preinit_complete" );
    root = get_powerups_root();
    powerups_list_bundle = get_bundle_list();
    
    if ( !isdefined( powerups_list_bundle.powerup_list ) )
    {
        return;
    }
    
    list_index = 0;
    
    foreach ( s_powerup_entry in powerups_list_bundle.powerup_list )
    {
        if ( isdefined( s_powerup_entry.ref ) && isdefined( s_powerup_entry.bundle ) )
        {
            if ( !level.var_4276627efc461310 )
            {
                if ( !root.powerups[ s_powerup_entry.ref ] )
                {
                    isinitregistered = 0;
                    
                    foreach ( var_7875d0043fbb8d7a in root.var_a6a5825829772acb )
                    {
                        if ( s_powerup_entry.ref == var_7875d0043fbb8d7a.str_powerup )
                        {
                            isinitregistered = 1;
                            break;
                        }
                    }
                    
                    if ( !isinitregistered )
                    {
                        continue;
                    }
                }
            }
            
            s_powerup_info = getscriptbundle( "powerup:" + s_powerup_entry.bundle );
            root.powerups[ s_powerup_entry.ref ] = s_powerup_info;
            root.powerup_list_index[ s_powerup_entry.ref ] = list_index;
            
            if ( s_powerup_entry.var_7c2ee7d43eb79692 )
            {
                root.powerup_drop_array[ root.powerup_drop_array.size ] = s_powerup_entry.ref;
            }
            
            if ( s_powerup_info.vfxgrabbed )
            {
                level._effect[ "powerup_grabbed" + "_override_" + s_powerup_entry.ref ] = loadfxasset( s_powerup_info.vfxgrabbed );
            }
            
            if ( s_powerup_info.vfxidle )
            {
                level._effect[ "powerup_on" + "_override_" + s_powerup_entry.ref ] = loadfxasset( s_powerup_info.vfxidle );
            }
            
            if ( s_powerup_info.vfxintro )
            {
                level._effect[ "powerup_intro" + "_override_" + s_powerup_entry.ref ] = loadfxasset( s_powerup_info.vfxintro );
            }
        }
        
        list_index++;
    }
    
    root.powerup_drop_array = arrayrandomize( root.powerup_drop_array );
    set_powerup_var( "unique_powerup_enable", powerups_list_bundle.var_8541fbf4ae54527c );
    set_powerup_var( "drop_event_incremental_number_per_player", powerups_list_bundle.drop_event_incremental_number_per_player );
    
    if ( isarray( powerups_list_bundle.var_a2b75e993aeb848b ) )
    {
        drop_event_ranges = [];
        
        foreach ( range in powerups_list_bundle.var_a2b75e993aeb848b )
        {
            range_struct = spawnstruct();
            range_struct.n_players = range.player_number;
            range_struct.n_min = range.min;
            range_struct.n_max = range.max;
            range_struct.var_45162660329a9117 = range.var_65560c13c2545f58;
            range_struct.str_label = range.category_label;
            drop_event_ranges[ drop_event_ranges.size ] = range_struct;
        }
        
        set_powerup_var( "drop_event_ranges", drop_event_ranges );
    }
    
    set_powerup_var( "drop_height_offset", powerups_list_bundle.drop_height_offset ?? 0 );
    set_powerup_var( "model_drop_delay_max", powerups_list_bundle.model_drop_delay_max ?? 0 );
    set_powerup_var( "model_drop_delay_min", powerups_list_bundle.model_drop_delay_min ?? 0 );
    set_powerup_var( "model_drop_delay_distance_outer", powerups_list_bundle.model_drop_delay_distance_outer ?? 0 );
    set_powerup_var( "model_drop_delay_distance_inner", powerups_list_bundle.model_drop_delay_distance_inner ?? 0 );
    set_powerup_var( "intro_vfx_label", powerups_list_bundle.intro_vfx_label );
    set_powerup_var( "intro_vfx_duration", powerups_list_bundle.intro_vfx_duration );
    set_powerup_var( "idle_vfx_label", powerups_list_bundle.idle_vfx_label );
    set_powerup_var( "grabbed_vfx_label", powerups_list_bundle.grabbed_vfx_label );
    set_powerup_var( "grabbed_vfx_duration", powerups_list_bundle.grabbed_vfx_duration );
    root.show_splash = getdvarint( @"scr_br_powerups_show_splash", powerups_list_bundle.showsplash ) == 1;
    n_ammo_spacing_min = set_powerup_var( "powerup_ammo_spacing_min", int( powerups_list_bundle.ammo_spacing_min ?? 0 ) );
    n_ammo_spacing_max = set_powerup_var( "powerup_ammo_spacing_max", int( powerups_list_bundle.ammo_spacing_max ?? 0 ) );
    
    if ( n_ammo_spacing_max != 0 || n_ammo_spacing_min != 0 )
    {
        if ( n_ammo_spacing_max > n_ammo_spacing_min )
        {
            root.var_e976cc211ff8126 = get_random_number( n_ammo_spacing_min, n_ammo_spacing_max );
        }
        else
        {
            assertmsg( "<dev string:x24>" + root.str_powerup_list_name );
        }
    }
    
    if ( isarray( root.var_a6a5825829772acb ) )
    {
        foreach ( struct in root.var_a6a5825829772acb )
        {
            _register( struct.str_powerup, struct.func_grab_powerup, struct.func_should_drop_with_regular_powerups, struct.var_73b0c01f8e3a1d0e );
        }
        
        root.var_a6a5825829772acb = undefined;
    }
    
    if ( isdefined( var_52d60db24fd81a96 ) )
    {
        level [[ var_52d60db24fd81a96 ]]();
    }
    
    level callback::add( str_drop_event, &function_7deddab7c77d78af );
    _init_scripted_widgets( powerups_list_bundle.var_c3b00301afe5cb49, powerups_list_bundle.var_eddc3b66598afe6e );
    level utility::flag_set( "init_powerups_complete" );
}

// Namespace powerups
// Params 2, eflags: 0x4
// Checksum 0x879e18af, Offset: 0xd58
// Size: 0x158
function private _init_scripted_widgets( widget, var_59e2ff60bf69c885 = 0 )
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) != 0 )
        {
            return;
        }
    #/
    
    level utility::flag_wait( "scripted_widgets_initialized" );
    
    if ( isdefined( widget ) )
    {
        level.powerup_timer_display = spawnstruct();
        level.powerup_timer_display.container_widget = widget;
        level.powerup_timer_display.var_59e2ff60bf69c885 = var_59e2ff60bf69c885;
        level.powerup_timer_display.max_active_displays = scripted_widgets::function_d0e2238a41650c33( widget, "powerup_timer", "default" );
        level.powerup_timer_display.omnvars = [];
        omnvar_set_data = scripted_widgets::function_73c35dc22a35edd7( widget, "powerup_timer", "default" );
        
        foreach ( ref, omnvar_data in omnvar_set_data )
        {
            level.powerup_timer_display.omnvars[ ref ] = omnvar_data;
        }
    }
}

// Namespace powerups
// Params 2, eflags: 0x4
// Checksum 0x963391b3, Offset: 0xeb8
// Size: 0x1e4
function private _reserve_omnvar( ref, widget_type )
{
    if ( !isdefined( self.powerup_timer_display ) )
    {
        self.powerup_timer_display = {};
    }
    
    if ( !isdefined( self.powerup_timer_display.available_indices ) )
    {
        self.powerup_timer_display.available_indices = [];
        
        for ( i = 0; i < level.powerup_timer_display.max_active_displays ; i++ )
        {
            self.powerup_timer_display.available_indices[ i ] = i + 1;
        }
    }
    
    assert( self.powerup_timer_display.available_indices.size );
    
    if ( !isdefined( self.powerup_timer_display.active_refs ) )
    {
        self.powerup_timer_display.active_refs = [];
    }
    
    if ( self.powerup_timer_display.available_indices.size > 0 )
    {
        assert( !isdefined( self.powerup_timer_display.active_refs[ ref ] ) );
        self.powerup_timer_display.active_refs[ ref ] = {};
        self.powerup_timer_display.active_refs[ ref ].index = self.powerup_timer_display.available_indices[ 0 ];
        self.powerup_timer_display.active_refs[ ref ].widget_type = widget_type;
        self.powerup_timer_display.available_indices[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.powerup_timer_display.available_indices );
        _reset_omnvars( self.powerup_timer_display.active_refs[ ref ].index );
    }
}

// Namespace powerups
// Params 1, eflags: 0x4
// Checksum 0x4d739697, Offset: 0x10a4
// Size: 0x96
function private _release_omnvar( ref )
{
    if ( isdefined( self.powerup_timer_display.active_refs[ ref ] ) )
    {
        index = self.powerup_timer_display.active_refs[ ref ].index;
        self.powerup_timer_display.available_indices[ self.powerup_timer_display.available_indices.size ] = index;
        self.powerup_timer_display.active_refs[ ref ] = undefined;
        return index;
    }
}

// Namespace powerups
// Params 3, eflags: 0x4
// Checksum 0x142e8ed, Offset: 0x1142
// Size: 0x7a
function private _set_omnvar( ref, omnvar_ref, value )
{
    omnvar_data = level.powerup_timer_display.omnvars[ omnvar_ref ];
    self setclientomnvar( omnvar_data.name + "_" + self.powerup_timer_display.active_refs[ ref ].index, value );
}

// Namespace powerups
// Params 2, eflags: 0x4
// Checksum 0xe1193335, Offset: 0x11c4
// Size: 0x6e
function private _get_omnvar( ref, omnvar_ref )
{
    omnvar_data = level.powerup_timer_display.omnvars[ omnvar_ref ];
    return self getclientomnvar( omnvar_data.name + "_" + self.powerup_timer_display.active_refs[ ref ].index );
}

// Namespace powerups
// Params 2, eflags: 0x4
// Checksum 0x925dfc53, Offset: 0x123b
// Size: 0x7a
function private _reset_omnvar( ref, omnvar_ref )
{
    omnvar_data = level.powerup_timer_display.omnvars[ omnvar_ref ];
    self setclientomnvar( omnvar_data.name + "_" + self.powerup_timer_display.active_refs[ ref ].index, omnvar_data.default_value );
}

// Namespace powerups
// Params 1, eflags: 0x4
// Checksum 0x5b723d08, Offset: 0x12bd
// Size: 0xab
function private _reset_omnvars( index )
{
    foreach ( omnvar_data in level.powerup_timer_display.omnvars )
    {
        self setclientomnvar( omnvar_data.name + "_" + index, omnvar_data.default_value );
    }
}

// Namespace powerups
// Params 1
// Checksum 0x8cbbb8c5, Offset: 0x1370
// Size: 0x29, Type: bool
function is_active_ref( ref )
{
    return isdefined( ref ) && isdefined( self.powerup_timer_display.active_refs[ ref ] );
}

// Namespace powerups
// Params 4
// Checksum 0x30957057, Offset: 0x13a2
// Size: 0x248
function add_powerup_timer( ref, bundle_index, time, widget_type = "default" )
{
    widget_index = scripted_widgets::get_child_widget_index( level.powerup_timer_display.container_widget, "powerup_timer", widget_type );
    
    if ( !( isdefined( ref ) && isdefined( bundle_index ) && isdefined( time ) && isdefined( widget_index ) ) )
    {
        assertmsg( "<dev string:x57>" + level.powerup_timer_display.container_widget + "<dev string:x101>" + widget_type + "<dev string:x107>" );
    }
    
    time = function_6e23b8d822e83d13( time );
    
    if ( is_active_ref( ref ) )
    {
        set_powerup_timer_time( ref, time );
        return;
    }
    
    self endon( #"death_or_disconnect" );
    level utility::flag_wait( "init_powerups_complete" );
    
    if ( !scripted_widgets::is_active( "powerup_timers" ) )
    {
        poweruplist = get_bundle_list();
        
        if ( isdefined( poweruplist.var_3842b59bcd04fedb ) )
        {
            self setclientomnvar( "powerup_list_alignment", int( poweruplist.var_3842b59bcd04fedb ) );
        }
        
        scripted_widgets::create( "powerup_timers", level.powerup_timer_display.container_widget, { #var_59e2ff60bf69c885:level.powerup_timer_display.var_59e2ff60bf69c885 } );
        anchorhorz = scripted_widgets::anchor_horizontal( poweruplist.var_dff32fb4d0af5fdd );
        var_cc08fb82477fa218 = scripted_widgets::anchor_vertical( poweruplist.var_284a12a8bbf4a3 );
        anchorx = poweruplist.var_b7820cdcd7846b78 ?? 0;
        anchory = poweruplist.var_b7820ddcd7846dab ?? 0;
        scripted_widgets::set_position( "powerup_timers", anchorx, anchory, anchorhorz, var_cc08fb82477fa218 );
    }
    
    _reserve_omnvar( ref, scripted_widgets::get_child_widget_asset_name( level.powerup_timer_display.container_widget, "powerup_timer", widget_type ) );
    _set_omnvar( ref, #"widget_type_index", widget_index );
    _set_omnvar( ref, #"bundle_index", bundle_index );
    _set_omnvar( ref, #"time", int( time ) );
}

// Namespace powerups
// Params 1
// Checksum 0xb132d651, Offset: 0x15f2
// Size: 0xa9
function remove_powerup_timer( ref )
{
    if ( !isdefined( level.powerup_timer_display ) || !is_active_ref( ref ) )
    {
        return;
    }
    
    self.powerup_timer_display.active_refs[ ref ].var_ea39dccd6be02fad = undefined;
    self.powerup_timer_display.active_refs[ ref ].lifetime = undefined;
    _set_omnvar( ref, #"widget_type_index", 0 );
    _release_omnvar( ref );
    
    if ( self.powerup_timer_display.active_refs.size == 0 )
    {
        scripted_widgets::destroy( "powerup_timers" );
    }
}

// Namespace powerups
// Params 1, eflags: 0x4
// Checksum 0x42247d06, Offset: 0x16a3
// Size: 0x19
function private function_6e23b8d822e83d13( time )
{
    if ( time == -1 )
    {
        time = 0;
    }
    
    return time;
}

// Namespace powerups
// Params 2
// Checksum 0x45efb04f, Offset: 0x16c5
// Size: 0x12f
function set_powerup_timer_time( ref, time )
{
    if ( !is_active_ref( ref ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    level utility::flag_wait( "init_powerups_complete" );
    time = function_6e23b8d822e83d13( time );
    
    if ( self.powerup_timer_display.active_refs[ ref ].var_ea39dccd6be02fad )
    {
        var_dd9a26086a9975e0 = self.powerup_timer_display.active_refs[ ref ].lifetime - ( gettime() - self.powerup_timer_display.active_refs[ ref ].var_ea39dccd6be02fad ) * 0.001;
    }
    
    prev_time = var_dd9a26086a9975e0 ?? _get_omnvar( ref, #"time" );
    
    if ( prev_time > time )
    {
        return;
    }
    
    time = int( time );
    _set_omnvar( ref, #"time", time );
    
    if ( time == prev_time )
    {
        _set_omnvar( ref, #"reset", !_get_omnvar( ref, #"reset" ) );
    }
}

// Namespace powerups
// Params 2
// Checksum 0x793a03d6, Offset: 0x17fc
// Size: 0xbe
function set_powerup_timer_state( ref, state )
{
    if ( !is_active_ref( ref ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    level utility::flag_wait( "init_powerups_complete" );
    omnvar_data = level.powerup_timer_display.omnvars[ #"state" ];
    scripted_widgets::set_state( self.powerup_timer_display.active_refs[ ref ].widget_type, state, omnvar_data.name + "_" + self.powerup_timer_display.active_refs[ ref ].index );
}

// Namespace powerups
// Params 1
// Checksum 0x3e5d0bc, Offset: 0x18c2
// Size: 0x1b
function set_powerup_drop_event( event )
{
    level callback::add( event, &function_7deddab7c77d78af );
}

// Namespace powerups
// Params 0
// Checksum 0x95e2c848, Offset: 0x18e5
// Size: 0x30d
function get_bundle_list()
{
    root = get_powerups_root();
    
    if ( !isdefined( root.s_powerup_list ) )
    {
        if ( isdefined( level.str_powerup_list ) )
        {
            str_powerup_list = "poweruplist:" + level.str_powerup_list;
            root.str_powerup_list_name = level.str_powerup_list;
        }
        else
        {
            str_powerup_list = undefined;
            var_cd16a2e74383ea61 = getactivemapinfobundle();
            
            if ( var_cd16a2e74383ea61.var_cd51ef46319a3cd9.size > 0 )
            {
                foreach ( var_d133ebf480fb7306 in var_cd16a2e74383ea61.var_cd51ef46319a3cd9 )
                {
                    if ( isdefined( var_d133ebf480fb7306.var_ba79544e38e6026 ) && var_d133ebf480fb7306.gametype == getxhash( level.gametype ) )
                    {
                        str_powerup_list = "poweruplist:" + var_d133ebf480fb7306.var_ba79544e38e6026;
                        root.str_powerup_list_name = var_d133ebf480fb7306.var_ba79544e38e6026;
                        break;
                    }
                }
            }
            
            if ( !isdefined( str_powerup_list ) && isdefined( var_cd16a2e74383ea61.var_cd51ef46319a3cd9 ) && var_cd16a2e74383ea61.var_cd51ef46319a3cd9.size > 0 )
            {
                foreach ( var_d133ebf480fb7306 in var_cd16a2e74383ea61.var_cd51ef46319a3cd9 )
                {
                    if ( isdefined( var_d133ebf480fb7306.var_ba79544e38e6026 ) && !isdefined( var_d133ebf480fb7306.gametype ) )
                    {
                        str_powerup_list = "poweruplist:" + var_d133ebf480fb7306.var_ba79544e38e6026;
                        root.str_powerup_list_name = var_d133ebf480fb7306.var_ba79544e38e6026;
                        break;
                    }
                }
            }
            
            if ( !isdefined( str_powerup_list ) && isdefined( level.gametypebundle.powerup_list ) )
            {
                str_powerup_list = "poweruplist:" + level.gametypebundle.powerup_list;
                root.str_powerup_list_name = level.gametypebundle.powerup_list;
            }
            else if ( !isdefined( str_powerup_list ) && isdefined( level.gamemodebundle.powerup_list ) )
            {
                str_powerup_list = "poweruplist:" + level.gamemodebundle.powerup_list;
                root.str_powerup_list_name = level.gamemodebundle.powerup_list;
            }
            
            assert( isdefined( str_powerup_list ), "<dev string:x109>" );
        }
        
        root.s_powerup_list = getscriptbundle( str_powerup_list );
    }
    
    return root.s_powerup_list;
}

// Namespace powerups
// Params 4
// Checksum 0x96a83afa, Offset: 0x1bfb
// Size: 0x7a
function register_powerup( str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_73b0c01f8e3a1d0e )
{
    root = get_powerups_root();
    
    if ( isarray( root.powerups ) && root.powerups.size > 0 )
    {
        _register( str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_73b0c01f8e3a1d0e );
        return;
    }
    
    function_c149fab9d6702af( str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_73b0c01f8e3a1d0e );
}

// Namespace powerups
// Params 4
// Checksum 0xd3b0d3e5, Offset: 0x1c7d
// Size: 0xae
function _register( str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_73b0c01f8e3a1d0e )
{
    root = get_powerups_root();
    
    if ( isdefined( root.powerups[ str_powerup ] ) )
    {
        root.powerups[ str_powerup ].func_grab_powerup = func_grab_powerup;
        root.powerups[ str_powerup ].func_should_drop_with_regular_powerups = func_should_drop_with_regular_powerups ?? &func_should_always_drop;
        root.powerups[ str_powerup ].var_73b0c01f8e3a1d0e = var_73b0c01f8e3a1d0e;
        
        /#
            function_654d981230f75708( str_powerup );
        #/
    }
}

// Namespace powerups
// Params 4
// Checksum 0x7c752d8c, Offset: 0x1d33
// Size: 0xba
function function_c149fab9d6702af( str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_73b0c01f8e3a1d0e )
{
    root = get_powerups_root();
    
    if ( !isarray( root.var_a6a5825829772acb ) )
    {
        root.var_a6a5825829772acb = [];
    }
    
    struct = spawnstruct();
    struct.str_powerup = str_powerup;
    struct.func_grab_powerup = func_grab_powerup;
    struct.func_should_drop_with_regular_powerups = func_should_drop_with_regular_powerups;
    struct.var_73b0c01f8e3a1d0e = var_73b0c01f8e3a1d0e;
    root.var_a6a5825829772acb[ root.var_a6a5825829772acb.size ] = struct;
}

// Namespace powerups
// Params 1
// Checksum 0xbff49b13, Offset: 0x1df5
// Size: 0x2d, Type: bool
function is_powerup_registered( str_powerup )
{
    root = get_powerups_root();
    return isdefined( root.powerups[ str_powerup ] );
}

// Namespace powerups
// Params 1
// Checksum 0xae3b898f, Offset: 0x1e2b
// Size: 0xb3, Type: bool
function function_66b5c6704004966d( str_powerup )
{
    s_powerup_bundle = get_bundle_list();
    
    foreach ( var_3621b6ad3fb45884 in s_powerup_bundle.powerup_list )
    {
        if ( var_3621b6ad3fb45884.ref == str_powerup && isdefined( var_3621b6ad3fb45884.bundle ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace powerups
// Params 2
// Checksum 0xc97ab19a, Offset: 0x1ee7
// Size: 0xbe
function powerup_activate( str_powerup, ent_powerup )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( get_powerup_var( "unique_powerup_enable" ) )
    {
        player notify( #"hash_9b99a0f78b78d7dd" );
    }
    
    s_powerup_info = get_powerup_info( str_powerup );
    
    if ( isdefined( s_powerup_info.func_grab_powerup ) )
    {
        player thread [[ s_powerup_info.func_grab_powerup ]]( str_powerup, ent_powerup );
    }
    
    params = spawnstruct();
    params.str_powerup = str_powerup;
    params.powerup_source = ent_powerup.var_ab9d16e865163dda;
    callback::callback( "on_powerup_pickup", params );
}

// Namespace powerups
// Params 1
// Checksum 0xe0899cf9, Offset: 0x1fad
// Size: 0x1f, Type: bool
function function_7556927e1bf9f775( str_powerup )
{
    return istrue( get_powerup_info( str_powerup ).var_fbe5a107e20cde51 );
}

// Namespace powerups
// Params 1
// Checksum 0x11a1b67b, Offset: 0x1fd5
// Size: 0x2b, Type: bool
function function_b1314e1e06eb5bb0( str_powerup )
{
    return !function_7556927e1bf9f775( str_powerup ) && get_powerup_info( str_powerup ).var_742e5fbc6914069a;
}

// Namespace powerups
// Params 1
// Checksum 0x5467c600, Offset: 0x2009
// Size: 0x2b, Type: bool
function function_184b29863b8ce0ca( str_powerup )
{
    return !function_7556927e1bf9f775( str_powerup ) && get_powerup_info( str_powerup ).var_21670617d54b71ca;
}

// Namespace powerups
// Params 1
// Checksum 0x36d25600, Offset: 0x203d
// Size: 0x37
function function_7dc56e4550f62595( str_powerup )
{
    affected_radius = get_powerup_info( str_powerup ).var_3156c7c5a2f90f39;
    
    if ( isfloat( affected_radius ) )
    {
        return affected_radius;
    }
    
    return 0;
}

// Namespace powerups
// Params 1
// Checksum 0xd4c94293, Offset: 0x207d
// Size: 0x1f
function get_powerup_info( str_powerup )
{
    return get_powerups_root().powerups[ str_powerup ];
}

// Namespace powerups
// Params 2
// Checksum 0x70bc8960, Offset: 0x20a5
// Size: 0x2f9
function get_powerup_players( str_powerup, powerup_origin )
{
    root = get_powerups_root();
    a_players = [];
    
    if ( function_7556927e1bf9f775( str_powerup ) )
    {
        a_players[ a_players.size ] = self;
    }
    else if ( function_b1314e1e06eb5bb0( str_powerup ) )
    {
        a_players = level.players;
    }
    else if ( function_184b29863b8ce0ca( str_powerup ) )
    {
        str_team = self.team;
        
        foreach ( player in level.players )
        {
            if ( player.team != str_team )
            {
                a_players[ a_players.size ] = player;
            }
        }
    }
    else if ( isdefined( root.var_7e48fc8856716bef ) )
    {
        a_players = self [[ root.var_7e48fc8856716bef ]]();
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( isplayer( player ) && self.team == player.team )
            {
                a_players[ a_players.size ] = player;
            }
        }
    }
    
    final_players = [];
    affected_player_radius = function_7dc56e4550f62595( str_powerup );
    
    if ( isdefined( powerup_origin ) && affected_player_radius > 0 )
    {
        foreach ( player in a_players )
        {
            if ( player.b_ignore_powerups )
            {
                continue;
            }
            
            if ( distancesquared( player.origin, powerup_origin ) <= squared( affected_player_radius ) )
            {
                final_players[ final_players.size ] = player;
            }
        }
    }
    else
    {
        foreach ( player in a_players )
        {
            if ( player.b_ignore_powerups )
            {
                continue;
            }
            
            final_players = arraycombineunique( final_players, [ player ] );
        }
    }
    
    return final_players;
}

// Namespace powerups
// Params 3
// Checksum 0xb58b078, Offset: 0x23a7
// Size: 0x121
function static_powerup_drop( str_powerup, v_spawn_pos, v_spawn_angles )
{
    level endon( #"game_ended" );
    e_powerup = powerup_drop( str_powerup, v_spawn_pos, -1, 0 );
    
    if ( isdefined( e_powerup ) )
    {
        e_powerup.angles = v_spawn_angles;
        e_powerup.mesh_mdl.angles = v_spawn_angles;
        e_powerup setmodel( "jup_zm_powerup_vfx" );
        contents = trace::create_contents( 0, 1, 0, 0, 0, 1, 1, 0, 0 );
        v_up = anglestoup( e_powerup.angles );
        caststart = e_powerup.origin + v_up * 32;
        castend = caststart + v_up * -100;
        traceresult = trace::ray_trace( caststart, castend, [], contents );
        
        if ( isdefined( traceresult[ "entity" ] ) )
        {
            e_powerup linkto( traceresult[ "entity" ] );
            e_powerup.mesh_mdl linkto( traceresult[ "entity" ] );
        }
    }
}

// Namespace powerups
// Params 3
// Checksum 0x4e40e23f, Offset: 0x24d0
// Size: 0x5f
function force_powerup_drop( str_powerup, origin, var_ab9d16e865163dda )
{
    if ( !isdefined( origin ) )
    {
        assertmsg( "<dev string:x192>" );
        return;
    }
    
    offset = ( 0, 0, get_powerup_var( "drop_height_offset" ) );
    level thread powerup_drop( str_powerup, origin + offset, undefined, undefined, var_ab9d16e865163dda );
}

// Namespace powerups
// Params 6
// Checksum 0xcfe86807, Offset: 0x2537
// Size: 0x1f6
function powerup_drop( str_powerup, v_spawn_pos, n_lifetime_override, n_trigger_radius_override, var_ab9d16e865163dda, var_55c58166e3028a7f = 0 )
{
    self endon( #"powerup_grabbed" );
    self endon( #"death" );
    root = get_powerups_root();
    s_powerup_info = get_powerup_info( str_powerup );
    e_powerup = spawn( "script_model", v_spawn_pos );
    e_powerup setmodel( "tag_origin" );
    
    if ( var_55c58166e3028a7f )
    {
        e_powerup forcenetfieldhighlod( 1 );
    }
    
    e_powerup.str_powerup = str_powerup;
    e_powerup powerup_spawn_sequence( s_powerup_info.model, 1 );
    e_powerup.var_ab9d16e865163dda = var_ab9d16e865163dda ?? "drop";
    function_5aeaf3be3b4690d0( str_powerup );
    offset = ( 0, 0, get_powerup_var( "drop_height_offset" ) );
    groundent = e_powerup function_17e282bc65b0a5bc( offset );
    e_powerup thread powerup_wobble( e_powerup.mesh_mdl, groundent );
    e_powerup thread powerup_timeout( n_lifetime_override );
    e_powerup thread powerup_wait_for_pickup( n_trigger_radius_override );
    root.active_powerups[ root.active_powerups.size ] = e_powerup;
    level notify( #"powerup_dropped", e_powerup );
    
    if ( isdefined( root.dropped_callbacks ) )
    {
        foreach ( dc in root.dropped_callbacks )
        {
            level [[ dc ]]( e_powerup );
        }
    }
    
    return e_powerup;
}

// Namespace powerups
// Params 1
// Checksum 0xbe5d2ab6, Offset: 0x2736
// Size: 0x116
function function_17e282bc65b0a5bc( offset = ( 0, 0, 0 ) )
{
    movingplatforminfo = utility::function_7c45b71b8e0d3cff();
    
    if ( isdefined( movingplatforminfo.groundent ) && isdefined( movingplatforminfo.localorigin ) && isdefined( movingplatforminfo.localangles ) )
    {
        if ( movingplatforminfo.groundent.classname == "grenade" || movingplatforminfo.groundent.var_c256a5dce9297dce )
        {
            return;
        }
        
        if ( isdefined( self.linkedparent ) )
        {
            self.linkedparent linkto( movingplatforminfo.groundent, "", movingplatforminfo.localorigin, movingplatforminfo.localangles );
        }
        else
        {
            self linkto( movingplatforminfo.groundent, "", movingplatforminfo.localorigin + offset, movingplatforminfo.localangles );
        }
        
        return movingplatforminfo.groundent;
    }
}

// Namespace powerups
// Params 1
// Checksum 0x63efe516, Offset: 0x2855
// Size: 0x54
function register_powerup_dropped_callback( func_callback )
{
    root = get_powerups_root();
    
    if ( !isdefined( root.dropped_callbacks ) )
    {
        root.dropped_callbacks = [];
    }
    
    root.dropped_callbacks[ root.dropped_callbacks.size ] = func_callback;
}

// Namespace powerups
// Params 1
// Checksum 0x4a7831c, Offset: 0x28b1
// Size: 0x7f
function function_5aeaf3be3b4690d0( str_powerup )
{
    root = get_powerups_root();
    
    if ( isdefined( root.var_e976cc211ff8126 ) )
    {
        if ( str_powerup == "full_ammo" )
        {
            root.var_e976cc211ff8126 = get_random_number( get_powerup_var( "powerup_ammo_spacing_min" ), get_powerup_var( "powerup_ammo_spacing_max" ) );
            return;
        }
        
        if ( root.var_e976cc211ff8126 > 0 )
        {
            root.var_e976cc211ff8126--;
        }
    }
}

// Namespace powerups
// Params 2
// Checksum 0xb519dab9, Offset: 0x2938
// Size: 0x11e
function powerup_wobble( ent_model, groundent )
{
    self endon( #"powerup_grabbed" );
    self endon( #"powerup_timedout" );
    self endon( #"death" );
    powerup_info = get_powerup_info( self.str_powerup );
    
    if ( powerup_info.b_disable_powerup_wobble )
    {
        return;
    }
    
    max_pitch_wobble = 40;
    var_4af99d6e3118a32 = 45;
    current_yaw = ent_model.angles[ 1 ];
    
    while ( isdefined( ent_model ) )
    {
        waittime = randomfloatrange( 4, 5 );
        yaw_delta = clamp( randomint( 360 ), 60, 300 );
        current_yaw = angleclamp( current_yaw + yaw_delta );
        new_angles = ( max_pitch_wobble * -1 + randomint( max_pitch_wobble * 2 ), current_yaw, var_4af99d6e3118a32 * -1 + randomint( var_4af99d6e3118a32 * 2 ) );
        ent_model function_df5739f0bfd07279( new_angles, waittime, waittime * 0.5, waittime * 0.5 );
        wait waittime - 0.1;
    }
}

// Namespace powerups
// Params 1
// Checksum 0x3697df95, Offset: 0x2a5e
// Size: 0xe9
function powerup_timeout( n_lifetime )
{
    if ( n_lifetime < 0 )
    {
        return;
    }
    
    powerup_info = get_powerup_info( self.str_powerup );
    
    if ( !isdefined( n_lifetime ) )
    {
        n_lifetime = powerup_info.var_60abd2a73af466c4;
    }
    
    self endon( #"powerup_grabbed" );
    self endon( #"death" );
    self endon( #"powerup_reset" );
    blinktime = 10;
    var_df9bc210fd86790 = max( 0, n_lifetime - blinktime );
    wait var_df9bc210fd86790;
    hide_and_show( &powerup_hide, &powerup_show );
    self notify( #"powerup_timedout" );
    
    if ( self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart( "sound" ) )
    {
        self.mesh_mdl setscriptablepartstate( "sound", "timed_out" );
    }
    
    thread function_a87b25471c92808d();
}

// Namespace powerups
// Params 0
// Checksum 0xd74bb7a9, Offset: 0x2b4f
// Size: 0xaa
function powerup_hide()
{
    if ( isdefined( self ) )
    {
        self hide();
    }
    
    if ( isdefined( self.mesh_mdl ) )
    {
        if ( self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart( "blink" ) )
        {
            self.mesh_mdl setscriptablepartstate( "blink", "blink_hide" );
            return;
        }
        
        if ( self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart( "idle" ) )
        {
            self.mesh_mdl setscriptablepartstate( "idle", "hide" );
            return;
        }
        
        self.mesh_mdl hide();
    }
}

// Namespace powerups
// Params 1
// Checksum 0x565ca1bc, Offset: 0x2c01
// Size: 0xd4
function powerup_show( var_34a7221848717a01 )
{
    if ( isdefined( self ) )
    {
        self show();
    }
    
    if ( isdefined( self.mesh_mdl ) )
    {
        if ( self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart( "blink" ) )
        {
            if ( var_34a7221848717a01 )
            {
                self.mesh_mdl setscriptablepartstate( "blink", "blink_show" );
            }
            else
            {
                self.mesh_mdl setscriptablepartstate( "blink", "blink_show_with_audio" );
            }
            
            return;
        }
        
        if ( self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart( "idle" ) )
        {
            self.mesh_mdl setscriptablepartstate( "idle", "show" );
            return;
        }
        
        self.mesh_mdl show();
    }
}

// Namespace powerups
// Params 2
// Checksum 0xae5878e3, Offset: 0x2cdd
// Size: 0x90
function hide_and_show( hide_func, show_func )
{
    self endon( #"death" );
    var_34a7221848717a01 = 0;
    
    for ( i = 0; i < 40 ; i++ )
    {
        if ( i % 2 )
        {
            self [[ show_func ]]( var_34a7221848717a01 );
        }
        else
        {
            self [[ hide_func ]]();
        }
        
        if ( i < 16 )
        {
            wait 0.5;
            continue;
        }
        
        if ( i < 24 )
        {
            var_34a7221848717a01 = 1;
            wait 0.25;
            continue;
        }
        
        var_34a7221848717a01 = 1;
        wait 0.1;
    }
}

// Namespace powerups
// Params 0
// Checksum 0xa730c5c3, Offset: 0x2d75
// Size: 0x71
function powerup_delete()
{
    if ( isdefined( self.e_trigger ) )
    {
        self.e_trigger delete();
    }
    
    if ( isdefined( self.mesh_mdl ) )
    {
        self.mesh_mdl delete();
    }
    
    root = get_powerups_root();
    
    if ( isdefined( self ) )
    {
        root.active_powerups = arrayremove( root.active_powerups, self );
        self delete();
    }
}

// Namespace powerups
// Params 1
// Checksum 0x49a5eb0a, Offset: 0x2dee
// Size: 0x507
function powerup_wait_for_pickup( n_trigger_radius_override )
{
    self endon( #"death" );
    root = get_powerups_root();
    s_powerup_info = get_powerup_info( self.str_powerup );
    offset = ( 0, 0, get_powerup_var( "drop_height_offset" ) );
    origin = self.origin - offset;
    n_trigger_radius = n_trigger_radius_override ?? 32;
    adjust_origin = isdefined( n_trigger_radius_override ) ? self.origin : origin;
    self.e_trigger = spawn( "trigger_radius", adjust_origin, 0, n_trigger_radius, 72 );
    self.e_trigger enablelinkto();
    self.e_trigger linkto( self );
    
    while ( true )
    {
        self.e_trigger waittill( #"trigger", ent );
        player = ent;
        
        if ( isdefined( root.var_d3bf519d8023999a ) )
        {
            player = ent [[ root.var_d3bf519d8023999a ]]();
        }
        
        if ( isplayer( player ) && isdefined( level.var_56f90d470cc6babe ) && [[ level.var_56f90d470cc6babe ]]( player, s_powerup_info ) )
        {
            continue;
        }
        
        if ( isplayer( player ) && isdefined( level.var_49f88fccd9b10cde ) && [[ level.var_49f88fccd9b10cde ]]( player ) )
        {
            player.var_e1e23a6d9f1887af = 1;
        }
        
        if ( !s_powerup_info.var_a5947be6c50a6f68 && !isplayer( player ) )
        {
            continue;
        }
        
        if ( !s_powerup_info.powerupcanpickupinlaststand && player.inlaststand )
        {
            continue;
        }
        
        if ( isdefined( self.mesh_mdl ) )
        {
            if ( self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart( "sound" ) )
            {
                self.mesh_mdl setscriptablepartstate( "sound", "pickup" );
            }
        }
        
        var_6216e1417cfb194 = player get_powerup_players( self.str_powerup, self.origin );
        
        foreach ( player_sound in var_6216e1417cfb194 )
        {
            if ( self.str_powerup == "nuke" )
            {
                continue;
            }
            
            if ( isdefined( s_powerup_info.var_4dc52de6cf27a39b ) )
            {
                sound_event = s_powerup_info.var_4dc52de6cf27a39b;
            }
            else
            {
                sound_event = "sndevent_powerup_" + self.str_powerup;
            }
            
            if ( isdefined( sound_event ) )
            {
                player_sound playsoundevent( sound_event, player_sound );
                telemetry_utils::function_af2d366f9522f76f( "callback_operator_vo", { #target:undefined, #speaker:player_sound, #sound_event:sound_event, #sound_type:undefined, #script_func_name:"powerup_wait_for_pickup" } );
                continue;
            }
            
            assertmsg( "<dev string:x1b6>" + self.str_powerup + "<dev string:x1d6>" );
        }
        
        if ( isdefined( s_powerup_info.var_45d15f3dfa9e51c3 ) && !player.var_e1e23a6d9f1887af )
        {
            if ( s_powerup_info.var_2e24077939ab6ed9 )
            {
                a_players = level.players;
            }
            else
            {
                a_players = player get_powerup_players( self.str_powerup, self.origin );
            }
            
            a_players = function_abf7ccf3c1367bcc( a_players, self.str_powerup );
            
            if ( isdefined( level.var_15b710391cd54936 ) )
            {
                self thread [[ level.var_15b710391cd54936 ]]( a_players, s_powerup_info.var_45d15f3dfa9e51c3 );
            }
            else
            {
                foreach ( player_sound in a_players )
                {
                    if ( isplayer( player_sound ) )
                    {
                        player_sound namespace_9d8e359c3b1041e5::playsoundtoplayersharedfunc( s_powerup_info.var_45d15f3dfa9e51c3, player_sound );
                    }
                }
            }
        }
        
        /#
            if ( isdefined( player.name ) )
            {
                iprintlnbold( self.str_powerup + "<dev string:x20e>" + player.name );
            }
        #/
        
        level callback::callback( #"player_powerup", { #player:player, #powerup:self } );
        player powerup_activate( self.str_powerup, self );
        player namespace_9d8e359c3b1041e5::dopowerupscoreeventsharedfunc();
        self notify( #"powerup_grabbed", player );
        thread function_a87b25471c92808d( 1 );
        return;
    }
}

// Namespace powerups
// Params 2
// Checksum 0xb0e9ff75, Offset: 0x32fd
// Size: 0xb1
function function_abf7ccf3c1367bcc( a_players, str_powerup )
{
    var_f43eb6e734c44585 = a_players;
    
    if ( str_powerup == "nuke" )
    {
        foreach ( player in a_players )
        {
            if ( !player val::get( "enable_nuke_flash_and_sound" ) )
            {
                var_f43eb6e734c44585 = arrayremove( var_f43eb6e734c44585, player );
            }
        }
    }
    
    return var_f43eb6e734c44585;
}

// Namespace powerups
// Params 0
// Checksum 0xce57506c, Offset: 0x33b7
// Size: 0xc1
function get_next_powerup()
{
    root = get_powerups_root();
    
    /#
        if ( isdefined( level.var_3dcd842934704d44 ) )
        {
            str_powerup = level.var_3dcd842934704d44;
            level.var_3dcd842934704d44 = undefined;
            return str_powerup;
        }
    #/
    
    if ( isdefined( level.var_1972d2e9730827d4 ) )
    {
        str_powerup = level.var_1972d2e9730827d4;
        level.var_1972d2e9730827d4 = undefined;
    }
    else
    {
        str_powerup = root.powerup_drop_array[ root.powerup_index ];
        root.powerup_index++;
        
        if ( root.powerup_index >= root.powerup_drop_array.size )
        {
            root.powerup_index = 0;
            function_961c7bd1e9f77d88( str_powerup );
        }
    }
    
    return str_powerup;
}

// Namespace powerups
// Params 1
// Checksum 0x25a083ab, Offset: 0x3481
// Size: 0xb4
function function_961c7bd1e9f77d88( var_1e7a7b4c5d6da279 )
{
    root = get_powerups_root();
    root.powerup_drop_array = arrayrandomize( root.powerup_drop_array );
    
    if ( root.powerup_drop_array[ 0 ] == var_1e7a7b4c5d6da279 )
    {
        nextpowerup = root.powerup_drop_array[ 0 ];
        finalindex = root.powerup_drop_array.size - 1;
        finalpowerup = root.powerup_drop_array[ finalindex ];
        root.powerup_drop_array[ 0 ] = finalpowerup;
        root.powerup_drop_array[ finalindex ] = nextpowerup;
    }
}

// Namespace powerups
// Params 0
// Checksum 0x861272c0, Offset: 0x353d
// Size: 0x4, Type: bool
function func_should_always_drop()
{
    return true;
}

// Namespace powerups
// Params 0
// Checksum 0x7b88b6dc, Offset: 0x354a
// Size: 0x3, Type: bool
function func_should_never_drop()
{
    return false;
}

// Namespace powerups
// Params 1
// Checksum 0xb706efb5, Offset: 0x3556
// Size: 0x203
function function_7deddab7c77d78af( params )
{
    if ( !function_a5f57e5f455cefa7() )
    {
        return;
    }
    
    if ( self.no_powerups )
    {
        return;
    }
    
    if ( params.einflictor.var_24cdba8441bafdad || params.eattacker.var_24cdba8441bafdad )
    {
        return;
    }
    
    root = get_powerups_root();
    
    if ( isdefined( root.var_fda058ab47aeb2c0 ) )
    {
        if ( !self [[ root.var_fda058ab47aeb2c0 ]]( params ) )
        {
            return;
        }
    }
    
    drop_pos = isai( self ) ? self.var_5e0be30a5816a64d : self.origin;
    var_ff1fcfacc6a3651d = spawnstruct();
    var_ff1fcfacc6a3651d.powerup_offset = self.powerup_offset;
    var_ff1fcfacc6a3651d.var_a13bed1ac47e1b2c = self.var_a13bed1ac47e1b2c;
    params.var_ff1fcfacc6a3651d = var_ff1fcfacc6a3651d;
    
    if ( !isdefined( level.powerup_drop_throttle ) )
    {
        level.powerup_drop_throttle = throttle::throttle_initialize( "powerup_drop", 1, level.framedurationseconds );
    }
    
    powerup_drop_event = spawnstruct();
    throttle::throttle_wait_in_queue( level.powerup_drop_throttle, powerup_drop_event );
    var_6b823e4600bbbedf = 1;
    
    if ( isdefined( root.var_702fcdb304535fd8 ) )
    {
        params.etarget = self;
        var_6b823e4600bbbedf = level [[ root.var_702fcdb304535fd8 ]]( params );
    }
    
    if ( var_6b823e4600bbbedf )
    {
        var_776477bce23becd4 = undefined;
        var_776477bce23becd4 = function_7168dd778230eb8d();
        
        if ( isdefined( var_776477bce23becd4 ) )
        {
            offset = ( 0, 0, get_powerup_var( "drop_height_offset" ) );
            var_46a13a04a82c4457 = isvector( var_ff1fcfacc6a3651d.powerup_offset ) ? var_ff1fcfacc6a3651d.powerup_offset : ( 0, 0, 0 );
            level thread powerup_drop( var_776477bce23becd4, drop_pos + offset + var_46a13a04a82c4457, undefined, undefined, "drop" );
        }
    }
}

// Namespace powerups
// Params 0
// Checksum 0x73872b63, Offset: 0x3761
// Size: 0xc2
function function_7168dd778230eb8d()
{
    level endon( #"game_ended" );
    root = get_powerups_root();
    
    /#
        if ( isdefined( level.var_3dcd842934704d44 ) )
        {
            str_powerup = level.var_3dcd842934704d44;
            level.var_3dcd842934704d44 = undefined;
            return str_powerup;
        }
    #/
    
    for ( n_loop = root.powerup_drop_array.size * 2; n_loop > 0 ; n_loop-- )
    {
        str_powerup = get_next_powerup();
        powerup_info = get_powerup_info( str_powerup );
        
        if ( !isdefined( powerup_info.func_should_drop_with_regular_powerups ) )
        {
            return str_powerup;
        }
        
        is_available = [[ powerup_info.func_should_drop_with_regular_powerups ]]();
        
        if ( is_available )
        {
            return str_powerup;
        }
    }
}

// Namespace powerups
// Params 1
// Checksum 0x7fbb2df4, Offset: 0x382c
// Size: 0x1f
function function_b3ef1ccbc3c4bbbb( var_4387ef00ff87c412 )
{
    get_powerups_root().is_allowed_drop_event = var_4387ef00ff87c412;
}

// Namespace powerups
// Params 0, eflags: 0x4
// Checksum 0xf62d3444, Offset: 0x3853
// Size: 0x31
function private function_a5f57e5f455cefa7()
{
    root = get_powerups_root();
    
    if ( isdefined( root.is_allowed_drop_event ) )
    {
        return root.is_allowed_drop_event;
    }
    
    return 1;
}

// Namespace powerups
// Params 2
// Checksum 0x624c4874, Offset: 0x388d
// Size: 0x41
function set_powerup_var( zvar, value )
{
    if ( !isdefined( value ) )
    {
        return;
    }
    
    root = get_powerups_root();
    root.powerup_vars[ zvar ] = value;
    return value;
}

// Namespace powerups
// Params 1
// Checksum 0xac52b221, Offset: 0x38d7
// Size: 0x2c
function get_powerup_var( zvar )
{
    root = get_powerups_root();
    return root.powerup_vars[ zvar ];
}

// Namespace powerups
// Params 4
// Checksum 0xcc611e16, Offset: 0x390c
// Size: 0xb7
function powerup_hud_show( str_powerup, n_lifetime, var_b1ad48e9b5475ed1, var_fdc18e3ab4c9896b )
{
    self notify( "powerup_hud_show_" + str_powerup );
    self endon( "powerup_hud_show_" + str_powerup );
    self endon( #"disconnect" );
    root = get_powerups_root();
    self [[ root.var_15d850493eb56845 ]]( self.var_8de0e82f6a27e633[ str_powerup ], n_lifetime, var_b1ad48e9b5475ed1, var_fdc18e3ab4c9896b );
    self.var_bb807542a9b20cf0[ self.var_8de0e82f6a27e633[ str_powerup ].index ] = undefined;
    self.var_8de0e82f6a27e633[ str_powerup ] = undefined;
    self [[ root.var_308566e25655dae1 ]]( str_powerup );
}

// Namespace powerups
// Params 1
// Checksum 0xfa548669, Offset: 0x39cb
// Size: 0x1a4
function powerup_hud_init( str_powerup )
{
    self notify( "powerup_hud_show_" + str_powerup );
    self endon( "powerup_hud_show_" + str_powerup );
    self endon( #"disconnect" );
    root = get_powerups_root();
    
    if ( !isdefined( self.var_8de0e82f6a27e633 ) )
    {
        self.var_8de0e82f6a27e633 = [];
    }
    
    if ( !isdefined( self.var_8de0e82f6a27e633[ str_powerup ] ) )
    {
        self.var_8de0e82f6a27e633[ str_powerup ] = spawnstruct();
    }
    
    if ( !isdefined( self.var_bb807542a9b20cf0 ) )
    {
        self.var_bb807542a9b20cf0 = [];
    }
    
    powerupbundle = get_bundle_list();
    poweruplist = powerupbundle.powerup_list;
    powerupindex = 0;
    spotfound = 0;
    
    for ( i = 0; i < poweruplist.size ; i++ )
    {
        var_eeb001bea3c23e58 = isdefined( self.var_bb807542a9b20cf0[ i ] );
        var_795e5c270c053f91 = var_eeb001bea3c23e58 && self.var_bb807542a9b20cf0[ i ] == str_powerup;
        
        if ( !var_eeb001bea3c23e58 || var_795e5c270c053f91 )
        {
            if ( !spotfound )
            {
                powerupindex = i;
                spotfound = 1;
                continue;
            }
            
            self.var_bb807542a9b20cf0[ i ] = undefined;
        }
    }
    
    self.var_8de0e82f6a27e633[ str_powerup ].str_powerup = str_powerup;
    self.var_8de0e82f6a27e633[ str_powerup ].start = gettime();
    self.var_8de0e82f6a27e633[ str_powerup ].index = powerupindex;
    self.var_bb807542a9b20cf0[ powerupindex ] = str_powerup;
    return self.var_8de0e82f6a27e633[ str_powerup ];
}

// Namespace powerups
// Params 2
// Checksum 0x223aed64, Offset: 0x3b78
// Size: 0x1a8
function function_ea221632f2262b8d( hud_powerup, n_lifetime )
{
    assert( isplayer( self ) );
    root = get_powerups_root();
    poweruplist = get_bundle_list();
    assert( isdefined( root.powerup_list_index[ hud_powerup.str_powerup ] ), "<dev string:x225>" + hud_powerup.str_powerup + "<dev string:x237>" );
    player = self;
    index = hud_powerup.index;
    var_87b8bf682995ba90 = poweruplist.var_c3b00301afe5cb49;
    refname = "hud_powerup_" + hud_powerup.str_powerup;
    isactive = player is_active_ref( refname );
    
    if ( n_lifetime > 0 && isdefined( var_87b8bf682995ba90 ) && var_87b8bf682995ba90 != "" )
    {
        state = poweruplist.scriptedwidgethudstate ?? "";
        
        if ( !isactive )
        {
            player add_powerup_timer( refname, root.powerup_list_index[ hud_powerup.str_powerup ], n_lifetime );
        }
        else
        {
            player _set_omnvar( refname, #"bundle_index", root.powerup_list_index[ hud_powerup.str_powerup ] );
            player set_powerup_timer_time( refname, n_lifetime );
        }
        
        player set_powerup_timer_state( refname, state );
        return;
    }
    
    if ( isactive )
    {
        player set_powerup_timer_state( refname, "hide" );
        wait 1.5;
        player remove_powerup_timer( refname );
    }
}

// Namespace powerups
// Params 2
// Checksum 0xd89aae69, Offset: 0x3d28
// Size: 0x16b
function function_d7f163b7c83d9b0f( hud_powerup, n_lifetime )
{
    assert( isplayer( self ) );
    root = get_powerups_root();
    poweruplist = get_bundle_list();
    assert( isdefined( root.powerup_list_index[ hud_powerup.str_powerup ] ), "<dev string:x225>" + hud_powerup.str_powerup + "<dev string:x237>" );
    player = self;
    index = root.powerup_list_index[ hud_powerup.str_powerup ];
    var_87b8bf682995ba90 = poweruplist.var_6b170ffdc629cbea;
    refname = "hud_powerup_vignette";
    isactive = player scripted_widgets::is_active( refname );
    
    if ( n_lifetime > 0 && isdefined( var_87b8bf682995ba90 ) && var_87b8bf682995ba90 != "" )
    {
        state = poweruplist.var_2b4f7fe5f38ce55f ?? "";
        param = poweruplist.var_826b4ccfdbee4d7b ?? "";
        
        if ( !isactive )
        {
            player scripted_widgets::create( refname, var_87b8bf682995ba90 );
            player scripted_widgets::set_state( refname, state );
            player scripted_widgets::set_param( refname, param );
        }
        
        return;
    }
    
    if ( isactive )
    {
        player scripted_widgets::destroy( refname );
    }
}

// Namespace powerups
// Params 0
// Checksum 0xed126997, Offset: 0x3e9b
// Size: 0x66
function function_b6d20332b27fa42e()
{
    if ( !isdefined( self.var_bb807542a9b20cf0 ) )
    {
        return;
    }
    
    poweruplist = get_bundle_list();
    
    for ( i = 0; i < self.var_bb807542a9b20cf0.size ; i++ )
    {
        self.var_bb807542a9b20cf0[ i ] = undefined;
    }
    
    scripted_widgets::destroy( "powerup_timers" );
    self.powerup_timer_display = undefined;
}

// Namespace powerups
// Params 2
// Checksum 0x1c82a458, Offset: 0x3f09
// Size: 0x1be
function powerup_spawn_sequence( model_name, var_bb8518ebf233b3fd )
{
    self endon( #"powerup_grabbed" );
    self endon( #"death" );
    intro_fx = get_powerup_var( "intro_vfx_label" );
    var_44978c9a3f2f2188 = var_bb8518ebf233b3fd && isdefined( intro_fx ) && utility::fxexists( intro_fx );
    
    if ( var_44978c9a3f2f2188 )
    {
        set_powerup_vfx( intro_fx );
        wait get_powerup_var( "intro_vfx_duration" );
    }
    
    set_powerup_vfx( get_powerup_var( "idle_vfx_label" ) );
    mdl_delay = function_2fd94c6529903c37();
    wait mdl_delay;
    heightoffset = get_powerups_root().powerups[ self.str_powerup ].var_b83f3503286f1cd6 ?? 0;
    self.mesh_mdl = spawn( "script_model", self.origin + ( 0, 0, heightoffset ) );
    self.mesh_mdl setmodel( model_name );
    self.mesh_mdl linkto( self );
    self.mesh_mdl.script_noteworthy = "powerup";
    self.mesh_mdl.e_powerup = self;
    
    if ( self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart( "idle" ) )
    {
        self.mesh_mdl setscriptablepartstate( "idle", "show" );
    }
    
    if ( self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart( "sound" ) )
    {
        self.mesh_mdl setscriptablepartstate( "sound", "spawn" );
    }
}

// Namespace powerups
// Params 1
// Checksum 0x5e021365, Offset: 0x40cf
// Size: 0xfb
function function_a87b25471c92808d( b_play_fx )
{
    self endon( #"death" );
    
    if ( isdefined( self.e_trigger ) )
    {
        self.e_trigger delete();
    }
    
    if ( self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart( "idle" ) )
    {
        self.mesh_mdl setscriptablepartstate( "idle", "hide" );
    }
    else
    {
        self.mesh_mdl hide();
    }
    
    grabbed_vfx = get_powerup_var( "grabbed_vfx_label" );
    should_play_fx = b_play_fx && isdefined( grabbed_vfx ) && utility::fxexists( grabbed_vfx );
    
    if ( should_play_fx )
    {
        set_powerup_vfx( grabbed_vfx );
        wait get_powerup_var( "grabbed_vfx_duration" );
    }
    
    level callback::callback( #"powerup_drop_timeout", { #powerup:self } );
    wait 0.05;
    powerup_delete();
}

// Namespace powerups
// Params 1
// Checksum 0x3b0ce5cb, Offset: 0x41d2
// Size: 0x7b
function set_powerup_vfx( str_fx_name )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.str_powerup )
    {
        str_fx_override = str_fx_name + "_override_" + self.str_powerup;
        
        if ( utility::fxexists( str_fx_override ) )
        {
            str_fx_name = str_fx_override;
        }
    }
    
    if ( !utility::fxexists( str_fx_name ) )
    {
        return;
    }
    
    str_fx = utility::getfx( str_fx_name );
    stop_vfx();
    play_vfx( str_fx );
}

// Namespace powerups
// Params 1
// Checksum 0x92277776, Offset: 0x4255
// Size: 0x37
function stop_vfx( str_tag )
{
    if ( isdefined( self.n_powerup_fx ) )
    {
        stopfxontag( self.n_powerup_fx, self, "tag_origin" );
        self.n_powerup_fx = undefined;
    }
}

// Namespace powerups
// Params 1
// Checksum 0xc2f7f201, Offset: 0x4294
// Size: 0x24
function play_vfx( str_fx )
{
    playfxontag( str_fx, self, "tag_origin" );
    self.n_powerup_fx = str_fx;
}

// Namespace powerups
// Params 2
// Checksum 0x94250184, Offset: 0x42c0
// Size: 0x64
function function_f379817a62e3850c( powerup_name, b_ignore_override )
{
    lifetime = get_powerups_root().powerups[ powerup_name ].var_3f03b937c69044df;
    
    if ( !b_ignore_override && isdefined( level.powerup_timeout_override ) )
    {
        lifetime = self [[ level.powerup_timeout_override ]]( lifetime );
    }
    
    return lifetime;
}

// Namespace powerups
// Params 0, eflags: 0x4
// Checksum 0x90ba07e9, Offset: 0x432d
// Size: 0xf3
function private function_2fd94c6529903c37()
{
    root = get_powerups_root();
    delay_min = get_powerup_var( "model_drop_delay_min" );
    delay_max = get_powerup_var( "model_drop_delay_max" );
    distance_outer = get_powerup_var( "model_drop_delay_distance_outer" );
    distance_inner = get_powerup_var( "model_drop_delay_distance_inner" );
    
    if ( root.var_26b80a5124182549 )
    {
        return delay_min;
    }
    
    e_player = function_47c86977a18df38b( level.players, self.origin );
    
    if ( !isdefined( e_player ) )
    {
        return delay_max;
    }
    
    n_distance = distance( e_player.origin, self.origin );
    
    if ( n_distance > distance_outer )
    {
        return delay_min;
    }
    else if ( n_distance < distance_inner )
    {
        return delay_max;
    }
    
    n_delay = mapfloat( distance_inner, distance_outer, delay_max, delay_min, n_distance );
    return n_delay;
}

// Namespace powerups
// Params 2
// Checksum 0x13ef902d, Offset: 0x4429
// Size: 0x20
function get_random_number( n_min_inclusive, n_max_inclusive )
{
    return randomintrange( n_min_inclusive, n_max_inclusive + 1 );
}

// Namespace powerups
// Params 1, eflags: 0x4
// Checksum 0xa10c91da, Offset: 0x4452
// Size: 0xfd
function private set_scorepoints_mult( value = 1 )
{
    assert( isplayer( self ) );
    assert( isnumber( value ) );
    scalar = 1;
    value_states = self.values[ "scorepoints_scalar" ];
    
    if ( isdefined( value_states ) && value_states.size )
    {
        foreach ( val in value_states )
        {
            scalar *= float( val );
        }
    }
    
    root = get_powerups_root();
    self [[ root.var_a53a6962d153065f ]]( scalar );
}

// Namespace powerups
// Params 0
// Checksum 0xffd85203, Offset: 0x4557
// Size: 0x24
function get_powerups_root()
{
    if ( !isdefined( level.powerups_root ) )
    {
        level.powerups_root = spawnstruct();
    }
    
    return level.powerups_root;
}

// Namespace powerups
// Params 0
// Checksum 0x46d52a7d, Offset: 0x4584
// Size: 0x1f
function get_active_powerups()
{
    root = get_powerups_root();
    return root.active_powerups;
}

/#

    // Namespace powerups
    // Params 1
    // Checksum 0x4767ebeb, Offset: 0x45ac
    // Size: 0xb2, Type: dev
    function spawn_powerup_debug( a_params )
    {
        str_powerup = a_params[ 0 ];
        spawn_method = int( a_params[ 1 ] );
        
        switch ( spawn_method )
        {
            case 0:
                level.var_3dcd842934704d44 = str_powerup;
                break;
            case 1:
                function_3f5d414a1bc72839( str_powerup );
                break;
            case 2:
                function_4b7bb717051ea70( str_powerup );
                break;
            case 3:
                function_1c467de2a31cd198( str_powerup );
                break;
            default:
                iprintlnbold( "<dev string:x29d>" );
                break;
        }
    }

    // Namespace powerups
    // Params 1
    // Checksum 0x9a966ba8, Offset: 0x4666
    // Size: 0x6f, Type: dev
    function function_3f5d414a1bc72839( str_powerup )
    {
        offset = ( 0, 0, get_powerup_var( "<dev string:x2c4>" ) );
        v_spawn_pos = devgui::function_97024c0a6d1256a6() + offset - ( 0, 0, 8 );
        
        if ( isdefined( v_spawn_pos ) && isdefined( get_powerup_info( str_powerup ) ) )
        {
            e_powerup = namespace_9d8e359c3b1041e5::droppowerupsharedfunc( str_powerup, v_spawn_pos );
        }
    }

    // Namespace powerups
    // Params 1
    // Checksum 0x43485831, Offset: 0x46dd
    // Size: 0x4d, Type: dev
    function function_4b7bb717051ea70( str_powerup )
    {
        s_powerup_info = get_powerup_info( str_powerup );
        
        if ( isdefined( s_powerup_info.func_grab_powerup ) )
        {
            level.players[ 0 ] thread [[ s_powerup_info.func_grab_powerup ]]( str_powerup );
        }
    }

    // Namespace powerups
    // Params 1
    // Checksum 0xc55153a2, Offset: 0x4732
    // Size: 0x66, Type: dev
    function function_1c467de2a31cd198( str_powerup )
    {
        player = level.players[ 0 ] get_look_at_player();
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        s_powerup_info = get_powerup_info( str_powerup );
        
        if ( isdefined( s_powerup_info.func_grab_powerup ) )
        {
            player thread [[ s_powerup_info.func_grab_powerup ]]( str_powerup );
        }
    }

    // Namespace powerups
    // Params 0
    // Checksum 0xf89043b, Offset: 0x47a0
    // Size: 0xa8, Type: dev
    function get_look_at_player()
    {
        startpos = self geteye();
        viewangles = self getplayerangles();
        fwd = anglestoforward( viewangles );
        endpos = startpos + fwd * 10000;
        playercontent = [ "<dev string:x2d7>" ];
        var_e1c801cb433b89d0 = physics_createcontents( playercontent );
        playertrace = trace::sphere_trace( startpos, endpos, 5, self, var_e1c801cb433b89d0, 0 );
        traceent = playertrace[ "<dev string:x2f6>" ];
        
        if ( isplayer( traceent ) )
        {
            return traceent;
        }
        
        return;
    }

    // Namespace powerups
    // Params 1
    // Checksum 0x7f655df5, Offset: 0x4850
    // Size: 0x11a, Type: dev
    function function_654d981230f75708( powerup_ref )
    {
        tokens = strtok( powerup_ref, "<dev string:x2fd>" );
        
        for ( i = 0; i < tokens.size ; i++ )
        {
            first = tokens[ i ][ 0 ];
            tokens[ i ] = toupper( first ) + getsubstr( tokens[ i ], 1, tokens[ i ].size );
        }
        
        powerup_name = function_5d044133536d0766( "<dev string:x2ff>", tokens );
        devgui::function_9082edeb5db93280( "<dev string:x301>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x311>" + powerup_name, "<dev string:x324>" + powerup_ref + "<dev string:x339>", &spawn_powerup_debug );
        devgui::function_cd4e263c1f3018ae( "<dev string:x33c>" + powerup_name, "<dev string:x324>" + powerup_ref + "<dev string:x34f>", &spawn_powerup_debug );
        devgui::function_cd4e263c1f3018ae( "<dev string:x352>" + powerup_name, "<dev string:x324>" + powerup_ref + "<dev string:x362>", &spawn_powerup_debug );
        devgui::function_cd4e263c1f3018ae( "<dev string:x365>" + powerup_name, "<dev string:x324>" + powerup_ref + "<dev string:x375>", &spawn_powerup_debug );
        devgui::function_77df7fe7dd273e10();
    }

#/
