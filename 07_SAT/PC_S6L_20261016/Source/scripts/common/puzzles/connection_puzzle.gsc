// scripts\common\puzzles\connection_puzzle.gsc  (hash_7a2175628287e0c7.gscc) (size: 59412 Bytes / 0xe814 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb7145cc5 (3071564997)
// size ...... 59412 (0xe814)
// includes .. 7   (offset: 0xdd14)
// strings ... 58  (offset: 0xdd4c)
// dev strs .. 123 (offset: 0xe110)
// exports ... 74  (offset: 0xb798)
// cseg ...... 0x4ea + 0xb2ae (0xb798)
// imports ... 181 (offset: 0xc328)
// animtree1 . 0   (offset: 0xe814)
// animtree2 . 0   (offset: 0xe814)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\widgets_visibility;

#namespace connection_puzzle;

// Namespace connection_puzzle
// Params 0, eflags: 0x5
// Checksum 0x3ccabd50, Offset: 0x508
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"connection_puzzle", undefined, &connection_puzzle_init, undefined );
}

// Namespace connection_puzzle
// Params 0, eflags: 0x4
// Checksum 0x5d99f4f4, Offset: 0x529
// Size: 0x13b
function private connection_puzzle_init()
{
    /#
        level thread devgui_setup_connection_puzzle();
    #/
    
    if ( !isdefined( level.connection_puzzle ) )
    {
        level.connection_puzzle = {};
    }
    
    level.connection_puzzle.var_7e94add7de9064b0 = [];
    funcs = [];
    funcs[ #"hash_89adc3d6acbad06c" ] = &function_8dfadec4c3b8f29f;
    funcs[ #"gettile" ] = &function_cb0bb261d16a24f7;
    level.connection_puzzle.var_7e94add7de9064b0[ 0 ] = arraycopy( funcs );
    funcs[ #"gettile" ] = &function_e26c17ec3aa1d38a;
    level.connection_puzzle.var_7e94add7de9064b0[ 1 ] = arraycopy( funcs );
    funcs[ #"gettriggers" ] = &function_c675a0a09dfc1c78;
    level.connection_puzzle.var_7e94add7de9064b0[ 2 ] = arraycopy( funcs );
    funcs[ #"hash_89adc3d6acbad06c" ] = &function_2c04d4c25e45c246;
    level.connection_puzzle.var_7e94add7de9064b0[ 3 ] = arraycopy( funcs );
    funcs[ #"getpadding" ] = &function_8feb6016702fd56c;
    level.connection_puzzle.var_7e94add7de9064b0[ 4 ] = arraycopy( funcs );
}

// Namespace connection_puzzle
// Params 3, eflags: 0x4
// Checksum 0x410a8274, Offset: 0x66c
// Size: 0xe86
function private init_static_data( connection_puzzle_asset, instance, spectator_asset )
{
    utility::flag_wait( "scripted_widgets_initialized" );
    
    if ( !isdefined( level.connection_puzzle ) )
    {
        level.connection_puzzle = {};
    }
    
    if ( !isdefined( level.connection_puzzle.grid_offsets ) )
    {
        level.connection_puzzle.grid_offsets = [];
        level.connection_puzzle.grid_offsets[ 3 ] = {};
        level.connection_puzzle.grid_offsets[ 3 ].standard = [];
        level.connection_puzzle.grid_offsets[ 3 ].standard[ 0 ] = { #col:0, #row:-1 };
        level.connection_puzzle.grid_offsets[ 3 ].standard[ 1 ] = { #col:1, #row:0 };
        level.connection_puzzle.grid_offsets[ 3 ].standard[ 2 ] = { #col:-1, #row:0 };
        level.connection_puzzle.grid_offsets[ 3 ].alt = [];
        level.connection_puzzle.grid_offsets[ 3 ].alt[ 0 ] = { #col:0, #row:1 };
        level.connection_puzzle.grid_offsets[ 3 ].alt[ 1 ] = { #col:-1, #row:0 };
        level.connection_puzzle.grid_offsets[ 3 ].alt[ 2 ] = { #col:1, #row:0 };
        level.connection_puzzle.grid_offsets[ 4 ] = {};
        level.connection_puzzle.grid_offsets[ 4 ].standard = [];
        level.connection_puzzle.grid_offsets[ 4 ].standard[ 0 ] = { #col:0, #row:-1 };
        level.connection_puzzle.grid_offsets[ 4 ].standard[ 1 ] = { #col:1, #row:0 };
        level.connection_puzzle.grid_offsets[ 4 ].standard[ 2 ] = { #col:0, #row:1 };
        level.connection_puzzle.grid_offsets[ 4 ].standard[ 3 ] = { #col:-1, #row:0 };
        level.connection_puzzle.grid_offsets[ 6 ] = {};
        level.connection_puzzle.grid_offsets[ 6 ].standard = [];
        level.connection_puzzle.grid_offsets[ 6 ].standard[ 0 ] = { #col:0, #row:-1 };
        level.connection_puzzle.grid_offsets[ 6 ].standard[ 1 ] = { #col:1, #row:0 };
        level.connection_puzzle.grid_offsets[ 6 ].standard[ 2 ] = { #col:1, #row:1 };
        level.connection_puzzle.grid_offsets[ 6 ].standard[ 3 ] = { #col:0, #row:1 };
        level.connection_puzzle.grid_offsets[ 6 ].standard[ 4 ] = { #col:-1, #row:1 };
        level.connection_puzzle.grid_offsets[ 6 ].standard[ 5 ] = { #col:-1, #row:0 };
        level.connection_puzzle.grid_offsets[ 6 ].alt = [];
        level.connection_puzzle.grid_offsets[ 6 ].alt[ 0 ] = { #col:0, #row:-1 };
        level.connection_puzzle.grid_offsets[ 6 ].alt[ 1 ] = { #col:1, #row:-1 };
        level.connection_puzzle.grid_offsets[ 6 ].alt[ 2 ] = { #col:1, #row:0 };
        level.connection_puzzle.grid_offsets[ 6 ].alt[ 3 ] = { #col:0, #row:1 };
        level.connection_puzzle.grid_offsets[ 6 ].alt[ 4 ] = { #col:-1, #row:0 };
        level.connection_puzzle.grid_offsets[ 6 ].alt[ 5 ] = { #col:-1, #row:-1 };
    }
    
    if ( !isdefined( level.connection_puzzle.assets ) )
    {
        level.connection_puzzle.assets = [];
    }
    
    if ( !isdefined( level.connection_puzzle.assets[ connection_puzzle_asset ] ) )
    {
        level.connection_puzzle.assets[ connection_puzzle_asset ] = {};
    }
    
    if ( !isdefined( level.connection_puzzle.assets[ connection_puzzle_asset ].static_data ) )
    {
        level.connection_puzzle.assets[ connection_puzzle_asset ].static_data = {};
    }
    
    static_data = level.connection_puzzle.assets[ connection_puzzle_asset ].static_data;
    
    if ( !isdefined( static_data.widget ) )
    {
        static_data.widget = connection_puzzle_asset;
    }
    
    if ( !isdefined( static_data.spectator_widget ) )
    {
        static_data.spectator_widget = spectator_asset;
    }
    
    if ( !isdefined( static_data.max_tiles ) )
    {
        static_data.max_tiles = scripted_widgets::function_d0e2238a41650c33( connection_puzzle_asset, "Default", "Tiles" );
    }
    
    if ( !isdefined( static_data.var_ee7e4762f16f61fd ) )
    {
        static_data.var_ee7e4762f16f61fd = scripted_widgets::function_d0e2238a41650c33( connection_puzzle_asset, "Default", "Players" );
    }
    
    if ( !isdefined( static_data.var_8c51e0668f8930d6 ) )
    {
        static_data.var_8c51e0668f8930d6 = scripted_widgets::get_data_set_data( connection_puzzle_asset, #"hash_b73c9408242d4c9e", #"animtime" ) ?? 0;
    }
    
    if ( !isdefined( static_data.omnvars ) )
    {
        static_data.omnvars = {};
    }
    
    if ( !isdefined( static_data.omnvars.rotation ) )
    {
        static_data.omnvars.rotation = scripted_widgets::function_73c35dc22a35edd7( connection_puzzle_asset, "Default", "Tiles", #"rotation" );
    }
    
    if ( !isdefined( static_data.omnvars.selection ) )
    {
        static_data.omnvars.selection = scripted_widgets::function_73c35dc22a35edd7( connection_puzzle_asset, "Default", "Players", #"selection" );
    }
    
    if ( !isdefined( static_data.omnvars.controller ) )
    {
        static_data.omnvars.controller = scripted_widgets::function_73c35dc22a35edd7( connection_puzzle_asset, "Default", "Players", #"controller" );
    }
    
    if ( !isdefined( static_data.tile_set ) )
    {
        tile_widget = scripted_widgets::get_child_widget_asset_name( connection_puzzle_asset, "Default", "Tile" );
        tile_params = scripted_widgets::get_params( tile_widget );
        trigger_types = scripted_widgets::get_data_set_templates( tile_widget, #"trigger" );
        static_data.tile_set = {};
        static_data.tile_set.set_num = tile_params.size;
        static_data.tile_set.num_sides = scripted_widgets::get_data_set_data( connection_puzzle_asset, #"puzzledata", #"tilesides" );
        static_data.tile_set.alternate_sides = static_data.num_sides == 3;
        static_data.tile_set.tiles = [];
        static_data.tile_set.name_map = [];
        static_data.tile_set.connection_types = scripted_widgets::get_data_set_templates( tile_widget, #"connectiontype" );
        static_data.tile_set.trigger_types = [];
        static_data.tile_set.var_4dfec929b4a0bad4 = ( scripted_widgets::get_data_set_data( tile_widget, #"hash_9cf7c4beb1ba87a2", #"time" ) ?? 0 ) * 1000;
        
        foreach ( param, index in tile_params )
        {
            static_data.tile_set.name_map[ param ] = index;
            connection_map = scripted_widgets::get_param_property( tile_widget, param, "connection_map" );
            connection_deadends = scripted_widgets::get_param_property( tile_widget, param, "connection_deadends" );
            connection_map_flags = connection_map ? connection_map.flags : [];
            var_f6f931a063df910a = connection_deadends ? connection_deadends.flags : [];
            connection_map_data = calculate_connection_map( static_data.tile_set.num_sides, connection_map_flags, var_f6f931a063df910a );
            static_data.tile_set.tiles[ index ] = {};
            static_data.tile_set.tiles[ index ].name = param;
            static_data.tile_set.tiles[ index ].connection_map = connection_map_data.connection_map;
            static_data.tile_set.tiles[ index ].connection_deadends = connection_map_data.connection_deadends;
            static_data.tile_set.tiles[ index ].connections = [];
            static_data.tile_set.tiles[ index ].selectable = scripted_widgets::get_param_property( tile_widget, param, "selectable" ) ?? 1;
            static_data.tile_set.tiles[ index ].locked = scripted_widgets::get_param_property( tile_widget, param, "locked" ) ?? 0;
            index++;
        }
        
        foreach ( trigger_name, trigger in trigger_types )
        {
            static_data.tile_set.trigger_types[ trigger_name ] = {};
            static_data.tile_set.trigger_types[ trigger_name ].var_b7ad4c4b44311946 = scripted_widgets::get_property_value( trigger.data[ #"triggernotify" ] );
            static_data.tile_set.trigger_types[ trigger_name ].untrigger_notify = scripted_widgets::get_property_value( trigger.data[ #"hash_5ab70dfe997e3d47" ] );
        }
    }
    
    switch ( static_data.tile_set.num_sides )
    {
        case 3:
            static_data.tile_set.get_grid_offset = &function_96245f34e9f90d3e;
            static_data.tile_set.var_2a6c8df0b9a53f82 = &function_72cbb5d7a70b7dad;
            break;
        case 4:
            static_data.tile_set.get_grid_offset = &function_ff2ecad3350fe6dd;
            static_data.tile_set.var_2a6c8df0b9a53f82 = &function_a87d3f87f2f6bd84;
            break;
        case 6:
            static_data.tile_set.get_grid_offset = &function_f4ccd2009baddc10;
            static_data.tile_set.var_2a6c8df0b9a53f82 = &function_15bf88634b9ecd23;
            break;
    }
}

// Namespace connection_puzzle
// Params 3, eflags: 0x4
// Checksum 0x8ca3385b, Offset: 0x14fa
// Size: 0x135
function private calculate_connection_map( sides, connection_map_flags, var_f6f931a063df910a )
{
    connection_map = 0;
    
    for ( input = 0; input < sides ; input++ )
    {
        for ( output = 0; output < sides ; output++ )
        {
            if ( input == output )
            {
                continue;
            }
            
            flag = getxhash( "" + input + "_to_" + output );
            
            if ( connection_map_flags[ flag ] && connection_map_flags[ flag ].value )
            {
                shift = input * ( sides - 1 ) + output - input - 1;
                
                if ( output < input )
                {
                    shift += sides;
                }
                
                connection_map |= 1 << shift;
            }
        }
    }
    
    connection_deadends = 0;
    
    if ( var_f6f931a063df910a )
    {
        for ( input = 0; input < sides ; input++ )
        {
            flag = getxhash( "" + input );
            
            if ( var_f6f931a063df910a[ flag ] && var_f6f931a063df910a[ flag ].value )
            {
                connection_deadends |= 1 << input;
            }
        }
    }
    
    return { #connection_deadends:connection_deadends, #connection_map:connection_map };
}

// Namespace connection_puzzle
// Params 3, eflags: 0x4
// Checksum 0x2426e16f, Offset: 0x1638
// Size: 0x38
function private function_96245f34e9f90d3e( col, row, side )
{
    InvalidOpCode( 0x5e, int( abs( row % 2 ) ), int( abs( col % 2 ) ) );
    // Unknown operator ( 0x5e, t11, Black Ops 7 )
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0xbdc9944b, Offset: 0x16c4
// Size: 0xe
function private function_72cbb5d7a70b7dad( side )
{
    return side;
}

// Namespace connection_puzzle
// Params 3, eflags: 0x4
// Checksum 0xfa63bf37, Offset: 0x16db
// Size: 0x41
function private function_ff2ecad3350fe6dd( col, row, side )
{
    return level.connection_puzzle.grid_offsets[ 4 ].standard[ side ];
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0x4dc30483, Offset: 0x1725
// Size: 0x14
function private function_a87d3f87f2f6bd84( side )
{
    return ( side + 2 ) % 4;
}

// Namespace connection_puzzle
// Params 3, eflags: 0x4
// Checksum 0x3b8debd4, Offset: 0x1742
// Size: 0x6d
function private function_f4ccd2009baddc10( col, row, side )
{
    if ( col % 2 )
    {
        return level.connection_puzzle.grid_offsets[ 6 ].alt[ side ];
    }
    
    return level.connection_puzzle.grid_offsets[ 6 ].standard[ side ];
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0x297fda1c, Offset: 0x17b8
// Size: 0x14
function private function_15bf88634b9ecd23( side )
{
    return ( side + 3 ) % 6;
}

// Namespace connection_puzzle
// Params 3, eflags: 0x4
// Checksum 0x2fc5f0e3, Offset: 0x17d5
// Size: 0x5a2
function private function_df06c1b612940b71( asset, puzzle_data, instance = "Default" )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    dynamic_data.cols = puzzle_data.cols;
    dynamic_data.rows = puzzle_data.rows;
    
    /#
        dynamic_data.was_edited = undefined;
    #/
    
    if ( !isdefined( dynamic_data.connection_types ) )
    {
        dynamic_data.connection_types = [];
    }
    
    if ( static_data.tile_set.connection_types )
    {
        foreach ( var_f3dc352df97f52c8, type in static_data.tile_set.connection_types )
        {
            connection_data = { #target:{}, #source:{} };
            
            if ( puzzle_data.connections[ var_f3dc352df97f52c8 ] )
            {
                connection_data.source = { #type:var_f3dc352df97f52c8, #side:puzzle_data.connections[ var_f3dc352df97f52c8 ].source.side, #row:puzzle_data.connections[ var_f3dc352df97f52c8 ].source.row, #col:puzzle_data.connections[ var_f3dc352df97f52c8 ].source.col };
                connection_data.target = { #type:var_f3dc352df97f52c8, #side:puzzle_data.connections[ var_f3dc352df97f52c8 ].target.side, #row:puzzle_data.connections[ var_f3dc352df97f52c8 ].target.row, #col:puzzle_data.connections[ var_f3dc352df97f52c8 ].target.col };
            }
            
            if ( !isdefined( connection_data.source.col ) || !isdefined( connection_data.source.row ) )
            {
                connection_data.source = undefined;
            }
            
            if ( !isdefined( connection_data.target.col ) || !isdefined( connection_data.target.row ) )
            {
                connection_data.target = undefined;
            }
            
            dynamic_data.connection_types[ var_f3dc352df97f52c8 ] = connection_data;
        }
    }
    
    col = 0;
    row = 0;
    
    foreach ( tile in puzzle_data.tiles )
    {
        assert( isdefined( static_data.tile_set.name_map[ tile.type ] ), "<dev string:x24>" + getxhashsourcename( tile.type ) + "<dev string:x43>" + getxhashsourcename( scripted_widgets::get_child_widget_asset_name( asset, "<dev string:x5d>", "<dev string:x65>" ) ) + "<dev string:x6a>" );
        
        if ( !isdefined( dynamic_data.tiles[ row ] ) )
        {
            dynamic_data.tiles[ row ] = [];
        }
        
        if ( !isdefined( dynamic_data.tiles[ row ][ col ] ) )
        {
            dynamic_data.tiles[ row ][ col ] = {};
        }
        
        dynamic_data.tiles[ row ][ col ].index = static_data.tile_set.name_map[ tile.type ];
        dynamic_data.tiles[ row ][ col ].rotation = tile.rotation;
        dynamic_data.tiles[ row ][ col ].locked = tile.locked;
        dynamic_data.tiles[ row ][ col ].not_selectable = tile.not_selectable;
        dynamic_data.tiles[ row ][ col ].initial_rotation = tile.rotation;
        dynamic_data.tiles[ row ][ col ].triggers = tile.triggers;
        col++;
        
        if ( col >= puzzle_data.cols )
        {
            col = 0;
            row++;
        }
    }
}

// Namespace connection_puzzle
// Params 6, eflags: 0x4
// Checksum 0x7a7807e0, Offset: 0x1d7f
// Size: 0x442
function private function_cbd23a2cbe20d152( connection_puzzle_asset, layout_name, instance = "Default", mixed_types_allowed, time, var_fb235e1b90660c32 )
{
    puzzle_layout = scripted_widgets::get_param_property( connection_puzzle_asset, layout_name, "puzzle_layout" );
    puzzle_mode = scripted_widgets::get_param_property( connection_puzzle_asset, layout_name, "puzzle_mode" );
    puzzle_data = function_e15502a7f37cae1c( connection_puzzle_asset, puzzle_layout );
    assert( isdefined( puzzle_data ), "<dev string:x6c>" + "<dev string:x81>" + "<dev string:x8f>" + layout_name + "<dev string:xa9>" + getxhashsourcename( connection_puzzle_asset ) + "<dev string:xc0>" );
    
    if ( !isdefined( puzzle_data ) )
    {
        return;
    }
    
    /#
        if ( !isdefined( puzzle_data.asset ) || getxhashasset( puzzle_data.asset ) != connection_puzzle_asset )
        {
            println( "<dev string:xdf>" + layout_name + "<dev string:x10e>" + getxhashsourcename( connection_puzzle_asset ) + "<dev string:x11c>" + getxhashsourcename( puzzle_data.asset ) + "<dev string:x13f>" );
        }
    #/
    
    if ( !isdefined( level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data ) )
    {
        level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data = [];
    }
    
    assert( !isdefined( level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data[ instance ] ) || instance == "<dev string:x15e>", "<dev string:x165>" + instance + "<dev string:x183>" + getxhashsourcename( connection_puzzle_asset ) + "<dev string:x6a>" );
    
    if ( isdefined( level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data[ instance ] ) )
    {
    }
    
    level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data[ instance ] = {};
    static_data = level.connection_puzzle.assets[ connection_puzzle_asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data[ instance ];
    dynamic_data.layout_name = layout_name;
    dynamic_data.puzzle_mode = puzzle_mode.key ?? "CONNECTIONS";
    dynamic_data.starting_seed = 0;
    dynamic_data.seed = 0;
    dynamic_data.cols = puzzle_data.cols;
    dynamic_data.rows = puzzle_data.rows;
    
    /#
        dynamic_data.puzzle_data = puzzle_data;
    #/
    
    dynamic_data.var_ba9183ba9ff395d3 = puzzle_data.start_selection % puzzle_data.cols;
    dynamic_data.start_row = int( floor( puzzle_data.start_selection / puzzle_data.cols ) );
    dynamic_data.mixed_types_allowed = mixed_types_allowed;
    dynamic_data.time = time ?? 0;
    dynamic_data.var_fb235e1b90660c32 = var_fb235e1b90660c32 ?? 0;
    dynamic_data.completed = 0;
    assert( static_data.max_tiles >= dynamic_data.cols * dynamic_data.rows, "<dev string:x1a5>" + dynamic_data.cols + "<dev string:x1c0>" + dynamic_data.rows + "<dev string:x1ce>" + static_data.max_tiles + "<dev string:x1ff>" );
    dynamic_data.players = [];
    
    for ( i = 0; i < static_data.var_ee7e4762f16f61fd ; i++ )
    {
        dynamic_data.players[ i ] = { #selection:puzzle_data.start_selection, #controller:undefined };
    }
    
    function_df06c1b612940b71( connection_puzzle_asset, puzzle_data, instance );
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x454f936e, Offset: 0x21c9
// Size: 0x341
function private function_ce77df7f2ad3c65f( connection_puzzle_asset, instance = "Default" )
{
    if ( !isdefined( level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data ) )
    {
        level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data = [];
    }
    
    level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data[ instance ] = {};
    static_data = level.connection_puzzle.assets[ connection_puzzle_asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data[ instance ];
    dynamic_data.starting_seed = 0;
    dynamic_data.seed = 0;
    dynamic_data.cols = 1;
    dynamic_data.rows = 1;
    dynamic_data.var_ba9183ba9ff395d3 = 0;
    dynamic_data.start_row = 0;
    dynamic_data.mixed_types_allowed = 1;
    dynamic_data.time = 0;
    dynamic_data.var_fb235e1b90660c32 = 0;
    dynamic_data.completed = 0;
    dynamic_data.starter_puzzle = 1;
    dynamic_data.layout_name = #"createnewlayout";
    dynamic_data.players = [];
    
    for ( i = 0; i < static_data.var_ee7e4762f16f61fd ; i++ )
    {
        dynamic_data.players[ i ] = { #selection:0, #controller:undefined };
    }
    
    dynamic_data.tiles[ 0 ] = [];
    dynamic_data.tiles[ 0 ][ 0 ] = {};
    dynamic_data.tiles[ 0 ][ 0 ].index = 0;
    dynamic_data.tiles[ 0 ][ 0 ].rotation = 0;
    dynamic_data.tiles[ 0 ][ 0 ].locked = 0;
    dynamic_data.tiles[ 0 ][ 0 ].not_selectable = 0;
    dynamic_data.tiles[ 0 ][ 0 ].initial_rotation = 0;
    
    if ( !isdefined( dynamic_data.connection_types ) )
    {
        dynamic_data.connection_types = [];
    }
    
    if ( static_data.tile_set.connection_types )
    {
        foreach ( var_f3dc352df97f52c8, type in static_data.tile_set.connection_types )
        {
            dynamic_data.connection_types[ var_f3dc352df97f52c8 ] = {};
        }
    }
}

// Namespace connection_puzzle
// Params 2
// Checksum 0xf90b3ec4, Offset: 0x2512
// Size: 0x35
function init_starter_puzzle( connection_puzzle_asset, instance = "Default" )
{
    init_static_data( connection_puzzle_asset, instance );
    function_ce77df7f2ad3c65f( connection_puzzle_asset, instance );
}

// Namespace connection_puzzle
// Params 7
// Checksum 0x2f130a86, Offset: 0x254f
// Size: 0x8d
function init_from_layout( connection_puzzle_asset, layout_name, instance = "Default", mixed_types_allowed = 0, spectator_asset, time, var_fb235e1b90660c32 )
{
    /#
        if ( tolower( layout_name ) == "<dev string:x201>" )
        {
            init_starter_puzzle( connection_puzzle_asset, instance );
            return;
        }
    #/
    
    init_static_data( connection_puzzle_asset, instance, spectator_asset );
    function_cbd23a2cbe20d152( connection_puzzle_asset, layout_name, instance, mixed_types_allowed, time, var_fb235e1b90660c32 );
}

// Namespace connection_puzzle
// Params 3
// Checksum 0x331af711, Offset: 0x25e4
// Size: 0xcf
function set_notification_data( asset, instance, data )
{
    assert( isdefined( level.connection_puzzle.assets[ asset ].dynamic_data[ instance ] ) && isdefined( "<dev string:x211>" + getxhashsourcename( asset ) + "<dev string:x22b>" + instance + "<dev string:x23c>" ) );
    
    if ( !isdefined( level.connection_puzzle.assets[ asset ].dynamic_data[ instance ] ) )
    {
        return;
    }
    
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    dynamic_data.var_2e3bf03447341ea = data;
}

// Namespace connection_puzzle
// Params 8
// Checksum 0x63e03772, Offset: 0x26bb
// Size: 0xd72, Type: bool
function open( connection_puzzle_asset, instance = "Default", is_spectator, var_ba9183ba9ff395d3, start_row, stream_and_wait = 1, var_853514cdb4c68391 = 1, var_1da3c2d0a3f82a67 = undefined )
{
    assert( isdefined( level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data[ instance ] ) && isdefined( "<dev string:x211>" + getxhashsourcename( connection_puzzle_asset ) + "<dev string:x22b>" + instance + "<dev string:x23c>" ) );
    
    if ( !isdefined( level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data[ instance ] ) )
    {
        self notify( #"ConnectionPuzzleClosed", { #instance:instance, #asset:connection_puzzle_asset } );
        return false;
    }
    
    static_data = level.connection_puzzle.assets[ connection_puzzle_asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ connection_puzzle_asset ].dynamic_data[ instance ];
    
    /#
        if ( isdefined( dynamic_data.puzzle_data ) && !level is_instance_active( connection_puzzle_asset, instance ) && dynamic_data.was_edited )
        {
            level function_df06c1b612940b71( connection_puzzle_asset, dynamic_data.puzzle_data, instance );
        }
    #/
    
    assert( !is_spectator || static_data.spectator_widget, "<dev string:x24f>" );
    
    if ( !isdefined( self.connection_puzzle ) )
    {
        self.connection_puzzle = {};
    }
    
    if ( is_spectator )
    {
        if ( !isdefined( dynamic_data.spectators ) )
        {
            dynamic_data.spectators = [];
        }
        
        if ( !arraycontains( dynamic_data.spectators, self ) )
        {
            dynamic_data.spectators[ dynamic_data.spectators.size ] = self;
        }
        
        if ( !isdefined( self.connection_puzzle.spectating ) )
        {
            self.connection_puzzle.spectating = [];
        }
        
        if ( !isdefined( self.connection_puzzle.spectating[ connection_puzzle_asset ] ) )
        {
            self.connection_puzzle.spectating[ connection_puzzle_asset ] = [];
        }
        
        if ( !arraycontains( self.connection_puzzle.spectating[ connection_puzzle_asset ], instance ) )
        {
            self.connection_puzzle.spectating[ connection_puzzle_asset ][ self.connection_puzzle.spectating[ connection_puzzle_asset ].size ] = instance;
        }
    }
    else
    {
        if ( !val::get( "allow_connection_puzzle" ) )
        {
            self notify( #"ConnectionPuzzleClosed", { #data:dynamic_data.var_2e3bf03447341ea, #instance:instance, #asset:connection_puzzle_asset } );
            return false;
        }
        
        self.connection_puzzle.participating = { #instance:instance, #asset:connection_puzzle_asset };
        
        if ( !isdefined( self.connection_puzzle.participating.var_6787895101874fb4 ) )
        {
            foreach ( index, player in dynamic_data.players )
            {
                if ( !isdefined( player.controller ) )
                {
                    player.controller = self;
                    self.connection_puzzle.participating.var_6787895101874fb4 = index + 1;
                    break;
                }
            }
        }
        
        assert( dynamic_data.players.size >= self.connection_puzzle.participating.var_6787895101874fb4 );
    }
    
    if ( !isdefined( var_ba9183ba9ff395d3 ) || !isdefined( start_row ) )
    {
        var_ba9183ba9ff395d3 = dynamic_data.var_ba9183ba9ff395d3 ?? 0;
        start_row = dynamic_data.start_row ?? 0;
    }
    
    if ( !is_spectator )
    {
        var_f0a67f118414c800 = dynamic_data.players[ self.connection_puzzle.participating.var_6787895101874fb4 - 1 ];
        var_f0a67f118414c800.selection = start_row * dynamic_data.cols + var_ba9183ba9ff395d3;
        self.connection_puzzle.participating.selection_row = start_row;
        self.connection_puzzle.participating.selection_col = var_ba9183ba9ff395d3;
    }
    
    /#
        if ( !is_spectator && getdvarint( @"connection_puzzle_skip", 0 ) )
        {
            utility::delaythread( 1, &success, connection_puzzle_asset, instance );
            return true;
        }
    #/
    
    if ( isautopilot( self ) )
    {
        utility::delaythread( 1, &success, connection_puzzle_asset, instance );
        return true;
    }
    
    fields = [];
    fields[ "seed" ] = dynamic_data.starting_seed;
    fields[ "mixed_types_allowed" ] = dynamic_data.mixed_types_allowed;
    fields[ "time" ] = int( max( 0, floor( dynamic_data.end_time ? ( dynamic_data.end_time - gettime() ) / 1000 : dynamic_data.time ) ) );
    
    /#
        fields[ "<dev string:x2bd>" ] = getdvarint( @"hash_d22885815cb38438", 0 );
    #/
    
    widget_ref = is_spectator ? instance + getxhashhexname( connection_puzzle_asset ) : "connection_puzzle";
    
    if ( stream_and_wait )
    {
        self endon( #"death_or_disconnect" );
    }
    
    scripted_widgets::create( widget_ref, is_spectator ? static_data.spectator_widget : static_data.widget, { #under_hud:1 }, stream_and_wait, 5 );
    scripted_widgets::function_dd7a63eea5bde0dc( widget_ref, fields );
    
    if ( isdefined( dynamic_data.end_time ) && dynamic_data.time > 0 )
    {
        scripted_widgets::set_timestamp( widget_ref, dynamic_data.end_time - dynamic_data.time * 1000 );
    }
    
    if ( isdefined( dynamic_data.layout_name ) )
    {
        scripted_widgets::set_param( widget_ref, dynamic_data.layout_name );
    }
    
    for ( row = 0; row < dynamic_data.rows ; row++ )
    {
        for ( col = 0; col < dynamic_data.cols ; col++ )
        {
            idx = row * dynamic_data.cols + col + 1;
            self setclientomnvar( static_data.omnvars.rotation.name + "_" + idx, dynamic_data.tiles[ row ][ col ].rotation );
        }
    }
    
    if ( dynamic_data.players.size > 1 )
    {
        foreach ( index, player in dynamic_data.players )
        {
            if ( isdefined( player.controller ) )
            {
                if ( !is_spectator )
                {
                    player.controller setclientomnvar( static_data.omnvars.controller.name + "_" + self.connection_puzzle.participating.var_6787895101874fb4, self );
                    player.controller setclientomnvar( static_data.omnvars.selection.name + "_" + self.connection_puzzle.participating.var_6787895101874fb4, player.selection );
                }
                
                foreach ( spectator in dynamic_data.spectators )
                {
                    spectator setclientomnvar( static_data.omnvars.controller.name + "_" + player.controller.connection_puzzle.participating.var_6787895101874fb4, player.controller );
                    spectator setclientomnvar( static_data.omnvars.selection.name + "_" + player.controller.connection_puzzle.participating.var_6787895101874fb4, player.selection );
                }
            }
            
            if ( self != player.controller )
            {
                self setclientomnvar( static_data.omnvars.controller.name + "_" + index + 1, player.controller );
                self setclientomnvar( static_data.omnvars.selection.name + "_" + index + 1, player.selection );
            }
        }
    }
    else
    {
        self setclientomnvar( static_data.omnvars.controller.name, self );
        self setclientomnvar( static_data.omnvars.selection.name, dynamic_data.players[ 0 ].selection );
        
        foreach ( spectator in dynamic_data.spectators )
        {
            spectator setclientomnvar( static_data.omnvars.controller.name, self );
            spectator setclientomnvar( static_data.omnvars.selection.name, dynamic_data.players[ 0 ].selection );
        }
    }
    
    if ( !is_spectator )
    {
        val::set_array( "allow_connection_puzzle", arrayremove( [ "allow_equipment_wheel", "allow_spy_cam", "allow_interactive_map", "allow_lockpick", "allow_keypad_puzzle", "allow_frequency_puzzle", "allow_cipher_puzzle", "allow_skill_select", "allow_reward_select", "allow_connection_puzzle" ], "allow_connection_puzzle" ), 0 );
        val::set_array( "allow_connection_puzzle", [ "freezecontrols_allowlook", "in_interactive_UI" ], 1 );
        widgets_visibility::hide( widget_ref, [ #"connectionpuzzle" ], 1, 1 );
        thread handle_input();
        
        /#
            thread function_6d824fc2bd3cf1a9();
        #/
        
        if ( dynamic_data.players.size == 1 )
        {
            level thread update_tiles( connection_puzzle_asset, instance );
        }
        
        if ( var_853514cdb4c68391 )
        {
            if ( !isdefined( var_1da3c2d0a3f82a67 ) )
            {
                var_1da3c2d0a3f82a67 = {};
            }
            
            self enablephysicaldepthoffieldscripting( 3 );
            self setphysicaldepthoffield( var_1da3c2d0a3f82a67.fstop ?? 1, var_1da3c2d0a3f82a67.focus_distance ?? 0, var_1da3c2d0a3f82a67.focus_speed ?? 10 );
            self.connection_puzzle.var_853514cdb4c68391 = var_853514cdb4c68391;
        }
        
        prevent_timer = 0;
        
        /#
            prevent_timer = self.connection_puzzle.participating.allow_editing != 0;
        #/
        
        if ( dynamic_data.time > 0 && !isdefined( dynamic_data.end_time ) && !prevent_timer )
        {
            level thread start_timer( connection_puzzle_asset, instance );
        }
        else if ( prevent_timer )
        {
            /#
                scripted_widgets::function_f15c5dfb6c0f57c7( widget_ref, "<dev string:x2cf>", 0 );
            #/
        }
        
        thread function_bdb95973daf68a0( widget_ref );
    }
    
    thread function_c5c617f8273eccbc( widget_ref, connection_puzzle_asset, instance );
    return true;
}

// Namespace connection_puzzle
// Params 1
// Checksum 0x96968d34, Offset: 0x3436
// Size: 0x4c
function close( var_44df3af69d9c5d25 = 1 )
{
    if ( var_44df3af69d9c5d25 )
    {
        thread utility::thread_on_notify( "ConnectionPuzzleAnimFinished", &scripted_widgets::destroy, undefined, undefined, "scripted_widget_destroyed_" + "connection_puzzle", "connection_puzzle" );
        return;
    }
    
    thread scripted_widgets::destroy( "connection_puzzle" );
}

// Namespace connection_puzzle
// Params 2
// Checksum 0x10952239, Offset: 0x348a
// Size: 0xb7
function close_spectator( asset, instance = "Default" )
{
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    assert( isdefined( dynamic_data ) && isdefined( "<dev string:x211>" + getxhashsourcename( asset ) + "<dev string:x22b>" + instance + "<dev string:x23c>" ) );
    scripted_widgets::destroy( instance + getxhashhexname( asset ) );
    
    if ( isdefined( dynamic_data.spectators ) )
    {
        dynamic_data.spectators = arrayremove( dynamic_data.spectators, self );
    }
}

// Namespace connection_puzzle
// Params 3
// Checksum 0x53d6d253, Offset: 0x3549
// Size: 0x105, Type: bool
function is_instance_active( asset, instance = "Default", ignore_spectators )
{
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    
    if ( isdefined( dynamic_data ) )
    {
        foreach ( player in dynamic_data.players )
        {
            if ( isdefined( player.controller ) )
            {
                return true;
            }
        }
    }
    
    if ( !ignore_spectators && dynamic_data.spectators )
    {
        return ( dynamic_data.spectators.size > 0 );
    }
    
    return false;
}

// Namespace connection_puzzle
// Params 2
// Checksum 0x6c762b16, Offset: 0x3657
// Size: 0x5e, Type: bool
function is_instance_complete( asset, instance = "Default" )
{
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    return dynamic_data.completed ?? 0;
}

// Namespace connection_puzzle
// Params 2
// Checksum 0xc9b72f86, Offset: 0x36be
// Size: 0xec
function function_7734e172f8439510( asset, instance = "Default" )
{
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    players = [];
    
    foreach ( player in dynamic_data.players )
    {
        if ( isdefined( player.controller ) )
        {
            players[ players.size ] = player.controller;
        }
    }
    
    return players;
}

// Namespace connection_puzzle
// Params 2
// Checksum 0xbaffb688, Offset: 0x37b3
// Size: 0x5e, Type: bool
function get_spectators( asset, instance = "Default" )
{
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    return dynamic_data.spectators ?? [];
}

// Namespace connection_puzzle
// Params 2
// Checksum 0x1c4e5bca, Offset: 0x381a
// Size: 0x290
function reset_layout( asset, instance = "Default" )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    
    if ( dynamic_data.layout_name )
    {
        for ( row = 0; row < dynamic_data.rows ; row++ )
        {
            for ( col = 0; col < dynamic_data.cols ; col++ )
            {
                tile = dynamic_data.tiles[ row ][ col ];
                tile.rotation = tile.initial_rotation;
                idx = row * dynamic_data.cols + col + 1;
                
                foreach ( player in dynamic_data.players )
                {
                    if ( isdefined( player.controller ) )
                    {
                        player.controller setclientomnvar( static_data.omnvars.rotation.name + "_" + idx, tile.rotation );
                    }
                }
                
                foreach ( spectator in dynamic_data.spectators )
                {
                    spectator setclientomnvar( static_data.omnvars.rotation.name + "_" + idx, tile.rotation );
                }
            }
        }
        
        update_tiles( asset, instance );
    }
}

// Namespace connection_puzzle
// Params 2
// Checksum 0x8b370dc4, Offset: 0x3ab2
// Size: 0x2d0
function randomize_rotations( asset, instance = "Default" )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    
    for ( row = 0; row < dynamic_data.rows ; row++ )
    {
        for ( col = 0; col < dynamic_data.cols ; col++ )
        {
            tile = dynamic_data.tiles[ row ][ col ];
            
            if ( !tile.locked && !static_data.tile_set.tiles[ tile.index ].locked )
            {
                tile.rotation = randomintrange( 0, static_data.tile_set.num_sides );
                idx = row * dynamic_data.cols + col + 1;
                
                foreach ( player in dynamic_data.players )
                {
                    if ( isdefined( player.controller ) )
                    {
                        player.controller setclientomnvar( static_data.omnvars.rotation.name + "_" + idx, tile.rotation );
                    }
                }
                
                foreach ( spectator in dynamic_data.spectators )
                {
                    spectator setclientomnvar( static_data.omnvars.rotation.name + "_" + idx, tile.rotation );
                }
            }
        }
    }
    
    update_tiles( asset, instance );
}

// Namespace connection_puzzle
// Params 3
// Checksum 0x8e2fb1ab, Offset: 0x3d8a
// Size: 0x2a8
function set_random_seed( asset, seed, instance = "Default" )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    assert( isdefined( dynamic_data ) && isdefined( "<dev string:x211>" + getxhashsourcename( asset ) + "<dev string:x22b>" + instance + "<dev string:x23c>" ) );
    
    if ( is_instance_active( asset, instance ) )
    {
        assertmsg( "<dev string:x2d4>" );
        return;
    }
    
    if ( !isdefined( seed ) )
    {
        seed = randomintrange( 0, 32767 );
    }
    
    dynamic_data.starting_seed = seed;
    dynamic_data.seed = seed;
    dynamic_data.completed = 0;
    
    for ( row = 0; row < dynamic_data.rows ; row++ )
    {
        for ( col = 0; col < dynamic_data.cols ; col++ )
        {
            tile = dynamic_data.tiles[ row ][ col ];
            
            if ( !tile.locked && !static_data.tile_set.tiles[ tile.index ].locked )
            {
                rand_result = function_8bad209c1dd9cd6( dynamic_data.seed, 0, static_data.tile_set.num_sides );
                dynamic_data.tiles[ row ][ col ].rotation = rand_result.value;
                dynamic_data.seed = rand_result.seed;
            }
            
            /#
                if ( getdvarint( @"connection_puzzle_debug", 0 ) )
                {
                    println( "<dev string:x314>" + col + "<dev string:x32f>" + row + "<dev string:x332>" + static_data.tile_set.tiles[ dynamic_data.tiles[ row ][ col ].index ].name + "<dev string:x33c>" + dynamic_data.tiles[ row ][ col ].rotation + "<dev string:x349>" + dynamic_data.seed );
                }
            #/
        }
    }
}

// Namespace connection_puzzle
// Params 3
// Checksum 0x41791b2a, Offset: 0x403a
// Size: 0x252
function function_24bc47a077976162( asset, time, instance = "Default" )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    assert( isdefined( dynamic_data ) && isdefined( "<dev string:x211>" + getxhashsourcename( asset ) + "<dev string:x22b>" + instance + "<dev string:x23c>" ) );
    dynamic_data.time = time;
    players = function_7734e172f8439510( asset, instance );
    spectators = arrayremove( get_spectators( asset, instance ), players );
    
    foreach ( player in players )
    {
        player scripted_widgets::function_f15c5dfb6c0f57c7( "connection_puzzle", "time", time );
    }
    
    widget_ref = instance + getxhashhexname( asset );
    
    foreach ( spectator in spectators )
    {
        spectator scripted_widgets::function_f15c5dfb6c0f57c7( widget_ref, "time", time );
    }
    
    level notify( #"ConnectionPuzzleTimeSet", { #data:dynamic_data.var_2e3bf03447341ea, #time:time, #instance:instance, #asset:asset } );
    
    if ( is_instance_active( asset, instance, 0 ) && time > 0 )
    {
        level thread start_timer( asset, instance );
    }
}

// Namespace connection_puzzle
// Params 2
// Checksum 0x49783136, Offset: 0x4294
// Size: 0x264
function reset_time( asset, instance = "Default" )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    assert( isdefined( dynamic_data ) && isdefined( "<dev string:x211>" + getxhashsourcename( asset ) + "<dev string:x22b>" + instance + "<dev string:x23c>" ) );
    
    if ( isdefined( dynamic_data.time ) )
    {
        players = function_7734e172f8439510( asset, instance );
        spectators = arrayremove( get_spectators( asset, instance ), players );
        widget_ref = instance + getxhashhexname( asset );
        start_time = gettime();
        
        foreach ( player in players )
        {
            player scripted_widgets::set_timestamp( "connection_puzzle", start_time );
        }
        
        foreach ( spectator in spectators )
        {
            spectator scripted_widgets::set_timestamp( "connection_puzzle", start_time );
        }
        
        level notify( #"ConnectionPuzzleTimeSet", { #data:dynamic_data.var_2e3bf03447341ea, #time:dynamic_data.time, #instance:instance, #asset:asset } );
        
        if ( is_instance_active( asset, instance, 0 ) && dynamic_data.time > 0 )
        {
            level thread start_timer( asset, instance );
        }
    }
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0xf04ede4b, Offset: 0x4500
// Size: 0x230
function private start_timer( asset, instance )
{
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    dynamic_data.end_time = gettime() + dynamic_data.time * 1000;
    
    while ( isdefined( dynamic_data.end_time ) && dynamic_data.end_time - gettime() > 0 )
    {
        ret = level utility::waittill_any_return_params_or_timeout( ( dynamic_data.end_time - gettime() ) / 1000, "ConnectionPuzzleCompleted", "ConnectionPuzzleFailed", "ConnectionPuzzleTimeSet", "ConnectionPuzzleTimeReset" );
        
        if ( ret[ 0 ].asset == asset && ret[ 0 ].instance == instance && ret[ "message" ] != "timeout" )
        {
            return;
        }
    }
    
    dynamic_data.end_time = undefined;
    
    foreach ( player in dynamic_data.players )
    {
        if ( isdefined( player.controller ) )
        {
            player notify( #"ConnectionPuzzleFailed", { #data:dynamic_data.var_2e3bf03447341ea, #reason:"ConnectionPuzzleTimeExpired", #instance:instance, #asset:asset } );
        }
    }
    
    level notify( #"ConnectionPuzzleFailed", { #data:dynamic_data.var_2e3bf03447341ea, #reason:"ConnectionPuzzleTimeExpired", #instance:instance, #asset:asset } );
    
    /#
        if ( getdvarint( @"connection_puzzle_debug", 0 ) )
        {
            iprintln( "<dev string:x35b>" );
        }
    #/
}

// Namespace connection_puzzle
// Params 1, eflags: 0xc
// Checksum 0x165391f4, Offset: 0x4738
// Size: 0x53
function private function_bdb95973daf68a0( widget_ref )
{
    self notify( #"hash_fdc3f3b5303f9b10" );
    self endon( #"hash_fdc3f3b5303f9b10" );
    self endon( #"connection_puzzle_on_close", widget_ref );
    utility::waittill_any( "death", "last_stand_enter" );
    
    if ( isplayer( self ) )
    {
        thread close( 0 );
    }
}

// Namespace connection_puzzle
// Params 3, eflags: 0x4
// Checksum 0x8d15e45, Offset: 0x4793
// Size: 0x5cf
function private function_c5c617f8273eccbc( widget_ref, asset, instance )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_c376c2cb3dfbbb02", widget_ref );
    self endon( #"connection_puzzle_on_close", widget_ref );
    self waittill( "scripted_widget_destroyed_" + widget_ref );
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    
    if ( self.connection_puzzle.participating.asset == asset && self.connection_puzzle.participating.instance == instance )
    {
        if ( dynamic_data.players.size > 1 )
        {
            foreach ( player in dynamic_data.players )
            {
                if ( isdefined( player.controller ) )
                {
                    player.controller setclientomnvar( static_data.omnvars.controller.name + "_" + self.connection_puzzle.participating.var_6787895101874fb4, undefined );
                    player.controller setclientomnvar( static_data.omnvars.selection.name + "_" + self.connection_puzzle.participating.var_6787895101874fb4, 0 );
                }
            }
            
            foreach ( spectator in dynamic_data.spectators )
            {
                spectator setclientomnvar( static_data.omnvars.controller.name + "_" + self.connection_puzzle.participating.var_6787895101874fb4, undefined );
                spectator setclientomnvar( static_data.omnvars.selection.name + "_" + self.connection_puzzle.participating.var_6787895101874fb4, 0 );
            }
        }
        else
        {
            self setclientomnvar( static_data.omnvars.controller.name, undefined );
            self setclientomnvar( static_data.omnvars.selection.name, 0 );
            
            foreach ( spectator in dynamic_data.spectators )
            {
                spectator setclientomnvar( static_data.omnvars.controller.name, undefined );
                spectator setclientomnvar( static_data.omnvars.selection.name, 0 );
            }
        }
        
        dynamic_data.players[ self.connection_puzzle.participating.var_6787895101874fb4 - 1 ].controller = undefined;
        dynamic_data.players[ self.connection_puzzle.participating.var_6787895101874fb4 - 1 ].selection = 0;
        self.connection_puzzle.participating = undefined;
        
        if ( self.connection_puzzle.var_853514cdb4c68391 )
        {
            self disablephysicaldepthoffieldscripting();
            self.connection_puzzle.var_853514cdb4c68391 = undefined;
        }
        
        val::reset_all( "allow_connection_puzzle" );
        widgets_visibility::reset( widget_ref );
        self notify( #"ConnectionPuzzleClosed", { #data:dynamic_data.var_2e3bf03447341ea, #instance:instance, #asset:asset } );
        level notify( #"ConnectionPuzzleClosed", { #data:dynamic_data.var_2e3bf03447341ea, #player:self, #instance:instance, #asset:asset } );
        
        if ( dynamic_data.var_fb235e1b90660c32 && function_7734e172f8439510().size == 0 )
        {
            dynamic_data.end_time = undefined;
            level notify( #"ConnectionPuzzleTimeReset", { #data:dynamic_data.var_2e3bf03447341ea, #instance:instance, #asset:asset } );
        }
    }
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0x36487c2d, Offset: 0x4d6a
// Size: 0x59
function private nav_up( dynamic_data )
{
    while ( true )
    {
        self waittill( #"connection_puzzle_nav_up", count );
        
        if ( dynamic_data.completed )
        {
            return;
        }
        
        move_selection( { #y:-1, #x:0 } );
    }
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0x781db140, Offset: 0x4dcb
// Size: 0x59
function private nav_down( dynamic_data )
{
    while ( true )
    {
        self waittill( #"connection_puzzle_nav_down", count );
        
        if ( dynamic_data.completed )
        {
            return;
        }
        
        move_selection( { #y:1, #x:0 } );
    }
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0x78e39350, Offset: 0x4e2c
// Size: 0x59
function private nav_left( dynamic_data )
{
    while ( true )
    {
        self waittill( #"connection_puzzle_nav_left", count );
        
        if ( dynamic_data.completed )
        {
            return;
        }
        
        move_selection( { #y:0, #x:-1 } );
    }
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0xcc8acc9f, Offset: 0x4e8d
// Size: 0x59
function private nav_right( dynamic_data )
{
    while ( true )
    {
        self waittill( #"connection_puzzle_nav_right", count );
        
        if ( dynamic_data.completed )
        {
            return;
        }
        
        move_selection( { #y:0, #x:1 } );
    }
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x6acf63a0, Offset: 0x4eee
// Size: 0x64
function private rotate_clockwise( var_f0a67f118414c800, dynamic_data )
{
    while ( true )
    {
        self waittill( #"connection_puzzle_rotate_clockwise", count );
        
        if ( dynamic_data.completed )
        {
            return;
        }
        
        rotate_tile( var_f0a67f118414c800.selection_row, var_f0a67f118414c800.selection_col, -1 );
    }
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x626478f5, Offset: 0x4f5a
// Size: 0x64
function private rotate_counter_clockwise( var_f0a67f118414c800, dynamic_data )
{
    while ( true )
    {
        self waittill( #"connection_puzzle_rotate_counter_clockwise", count );
        
        if ( dynamic_data.completed )
        {
            return;
        }
        
        rotate_tile( var_f0a67f118414c800.selection_row, var_f0a67f118414c800.selection_col, 1 );
    }
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0x6879ad2, Offset: 0x4fc6
// Size: 0xff
function private select_tile( dynamic_data )
{
    while ( true )
    {
        self waittill( #"connection_puzzle_select_tile", tiles );
        
        if ( dynamic_data.completed )
        {
            return;
        }
        
        foreach ( tile_index in tiles )
        {
            new_col = tile_index % dynamic_data.cols;
            new_row = int( floor( tile_index / dynamic_data.cols ) );
            tile = dynamic_data.tiles[ new_row ][ new_col ];
            set_selection( new_row, new_col );
        }
    }
}

// Namespace connection_puzzle
// Params 0, eflags: 0x4
// Checksum 0xa627f5ec, Offset: 0x50cd
// Size: 0x17
function private exit()
{
    self waittill( #"connection_puzzle_exit" );
    thread close( 0 );
}

// Namespace connection_puzzle
// Params 0, eflags: 0x4
// Checksum 0x7fa63d2, Offset: 0x50ec
// Size: 0x185
function private handle_input()
{
    self endon( #"death_or_disconnect" );
    self endon( "scripted_widget_destroyed_" + "connection_puzzle" );
    val::set_array( "allow_connection_puzzle", [ "allow_movement", "weapon", "offhand_weapons", "reload", "usability" ] );
    wait 0.5;
    var_f0a67f118414c800 = self.connection_puzzle.participating;
    static_data = level.connection_puzzle.assets[ var_f0a67f118414c800.asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ var_f0a67f118414c800.asset ].dynamic_data[ var_f0a67f118414c800.instance ];
    childthread nav_up( dynamic_data );
    childthread nav_down( dynamic_data );
    childthread nav_left( dynamic_data );
    childthread nav_right( dynamic_data );
    childthread rotate_clockwise( var_f0a67f118414c800, dynamic_data );
    childthread rotate_counter_clockwise( var_f0a67f118414c800, dynamic_data );
    childthread select_tile( dynamic_data );
    childthread exit();
    
    while ( true )
    {
        command = utility::waittill_any( "connection_puzzle_nav_up", "connection_puzzle_nav_down", "connection_puzzle_nav_left", "connection_puzzle_nav_right", "connection_puzzle_rotate_clockwise", "connection_puzzle_rotate_counter_clockwise", "connection_puzzle_select_tile", "connection_puzzle_exit" );
        callback::callback( #"hash_6b9543d4417040a" );
    }
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x21c455d4, Offset: 0x5279
// Size: 0x3c5
function private set_selection( new_row, new_col )
{
    var_f0a67f118414c800 = self.connection_puzzle.participating;
    static_data = level.connection_puzzle.assets[ var_f0a67f118414c800.asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ var_f0a67f118414c800.asset ].dynamic_data[ var_f0a67f118414c800.instance ];
    tile = dynamic_data.tiles[ new_row ][ new_col ];
    selectable = !tile.not_selectable && static_data.tile_set.tiles[ tile.index ].selectable;
    
    /#
        selectable |= var_f0a67f118414c800.allow_editing;
    #/
    
    if ( selectable )
    {
        var_f0a67f118414c800.selection_col = new_col;
        var_f0a67f118414c800.selection_row = new_row;
        selection = var_f0a67f118414c800.selection_row * dynamic_data.cols + var_f0a67f118414c800.selection_col;
        dynamic_data.players[ var_f0a67f118414c800.var_6787895101874fb4 - 1 ].selection = selection;
        
        if ( dynamic_data.players.size > 1 )
        {
            foreach ( player in dynamic_data.players )
            {
                if ( isdefined( player.controller ) )
                {
                    player.controller setclientomnvar( static_data.omnvars.selection.name + "_" + var_f0a67f118414c800.var_6787895101874fb4, selection );
                }
            }
            
            foreach ( spectator in dynamic_data.spectators )
            {
                spectator setclientomnvar( static_data.omnvars.selection.name + "_" + var_f0a67f118414c800.var_6787895101874fb4, selection );
            }
            
            return;
        }
        
        self setclientomnvar( static_data.omnvars.selection.name, selection );
        
        foreach ( spectator in dynamic_data.spectators )
        {
            spectator setclientomnvar( static_data.omnvars.selection.name, selection );
        }
    }
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0x4c6cca82, Offset: 0x5646
// Size: 0x42a
function private move_selection( selection_delta )
{
    var_f0a67f118414c800 = self.connection_puzzle.participating;
    static_data = level.connection_puzzle.assets[ var_f0a67f118414c800.asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ var_f0a67f118414c800.asset ].dynamic_data[ var_f0a67f118414c800.instance ];
    
    if ( selection_delta.x != 0 || selection_delta.y != 0 )
    {
        new_col = int( clamp( var_f0a67f118414c800.selection_col + selection_delta.x, 0, dynamic_data.cols - 1 ) );
        new_row = int( clamp( var_f0a67f118414c800.selection_row + selection_delta.y, 0, dynamic_data.rows - 1 ) );
        tile = dynamic_data.tiles[ new_row ][ new_col ];
        selectable = !tile.not_selectable && static_data.tile_set.tiles[ tile.index ].selectable;
        
        /#
            selectable |= var_f0a67f118414c800.allow_editing;
        #/
        
        if ( !selectable )
        {
            while ( selection_delta.x != 0 )
            {
                vertical = -1;
                
                while ( vertical < 2 && !selectable )
                {
                    new_row = var_f0a67f118414c800.selection_row + vertical;
                    
                    if ( new_row >= 0 && new_row < dynamic_data.rows )
                    {
                        tile = dynamic_data.tiles[ new_row ][ var_f0a67f118414c800.selection_col ];
                        selectable = !tile.not_selectable && static_data.tile_set.tiles[ tile.index ].selectable;
                        
                        if ( selectable )
                        {
                            tile = dynamic_data.tiles[ new_row ][ new_col ];
                            selectable = !tile.not_selectable && static_data.tile_set.tiles[ tile.index ].selectable;
                        }
                    }
                    
                    vertical += 2;
                }
                
                selection_delta.x -= selection_delta.x > 0 ? 1 : -1;
            }
            
            while ( selection_delta.y != 0 )
            {
                lateral = -1;
                
                while ( lateral < 2 && !selectable )
                {
                    new_col = var_f0a67f118414c800.selection_col + lateral;
                    
                    if ( new_col >= 0 && new_col < dynamic_data.cols )
                    {
                        tile = dynamic_data.tiles[ var_f0a67f118414c800.selection_row ][ new_col ];
                        selectable = !tile.not_selectable && static_data.tile_set.tiles[ tile.index ].selectable;
                        
                        if ( selectable )
                        {
                            tile = dynamic_data.tiles[ new_row ][ new_col ];
                            selectable = !tile.not_selectable && static_data.tile_set.tiles[ tile.index ].selectable;
                        }
                    }
                    
                    lateral += 2;
                }
                
                selection_delta.y -= selection_delta.y > 0 ? 1 : -1;
            }
        }
        
        set_selection( new_row, new_col );
    }
}

// Namespace connection_puzzle
// Params 3, eflags: 0x4
// Checksum 0xae346dd3, Offset: 0x5a78
// Size: 0x397
function private rotate_tile( new_row, new_col, rotation )
{
    var_f0a67f118414c800 = self.connection_puzzle.participating;
    static_data = level.connection_puzzle.assets[ var_f0a67f118414c800.asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ var_f0a67f118414c800.asset ].dynamic_data[ var_f0a67f118414c800.instance ];
    tile = dynamic_data.tiles[ new_row ][ new_col ];
    locked = tile.locked || static_data.tile_set.tiles[ tile.index ].locked;
    
    /#
        locked &= !var_f0a67f118414c800.allow_editing;
    #/
    
    if ( !locked )
    {
        if ( static_data.tile_set.var_4dfec929b4a0bad4 > 0 )
        {
            if ( tile.var_4dfec929b4a0bad4 > gettime() )
            {
                return;
            }
            
            tile.var_4dfec929b4a0bad4 = gettime() + static_data.tile_set.var_4dfec929b4a0bad4;
        }
        
        tile.rotation = int( mod( tile.rotation + rotation, static_data.tile_set.num_sides ) );
        
        if ( tile.rotation < 0 )
        {
            tile.rotation += static_data.tile_set.num_sides;
        }
        
        idx = new_row * dynamic_data.cols + new_col + 1;
        
        foreach ( player in dynamic_data.players )
        {
            if ( isdefined( player.controller ) )
            {
                player.controller setclientomnvar( static_data.omnvars.rotation.name + "_" + idx, tile.rotation );
            }
        }
        
        foreach ( spectator in dynamic_data.spectators )
        {
            spectator setclientomnvar( static_data.omnvars.rotation.name + "_" + idx, tile.rotation );
        }
        
        level thread update_tiles( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance );
    }
}

/#

    // Namespace connection_puzzle
    // Params 0, eflags: 0x4
    // Checksum 0x5f946e7c, Offset: 0x5e17
    // Size: 0x18e, Type: dev
    function private function_bf409f2bf4b35b94()
    {
        self.connection_puzzle.participating.allow_editing = getdvarint( @"hash_d22885815cb38438", 0 );
        
        while ( true )
        {
            wait 0.5;
            cur_value = getdvarint( @"hash_d22885815cb38438", 0 );
            
            if ( isdefined( self.connection_puzzle.participating.allow_editing ) && self.connection_puzzle.participating.allow_editing != cur_value )
            {
                self.connection_puzzle.participating.allow_editing = cur_value;
                scripted_widgets::function_f15c5dfb6c0f57c7( "<dev string:x37d>", "<dev string:x2bd>", cur_value );
                asset = self.connection_puzzle.participating.asset;
                instance = self.connection_puzzle.participating.instance;
                
                if ( cur_value )
                {
                    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
                    prev_time = dynamic_data.time;
                    level function_24bc47a077976162( asset, 0, instance );
                    dynamic_data.time = prev_time;
                    continue;
                }
                
                level reset_time( asset, instance );
            }
        }
    }

    // Namespace connection_puzzle
    // Params 0, eflags: 0x4
    // Checksum 0xca59cfb1, Offset: 0x5fad
    // Size: 0x146b, Type: dev
    function private function_6d824fc2bd3cf1a9()
    {
        self endon( #"death_or_disconnect" );
        self endon( "<dev string:x38f>" + "<dev string:x37d>" );
        childthread function_bf409f2bf4b35b94();
        var_f0a67f118414c800 = self.connection_puzzle.participating;
        static_data = level.connection_puzzle.assets[ var_f0a67f118414c800.asset ].static_data;
        dynamic_data = level.connection_puzzle.assets[ var_f0a67f118414c800.asset ].dynamic_data[ var_f0a67f118414c800.instance ];
        
        while ( true )
        {
            command = utility::waittill_any_return( "<dev string:x3aa>", "<dev string:x3c7>", "<dev string:x3e7>", "<dev string:x401>", "<dev string:x41e>", "<dev string:x43f>", "<dev string:x460>", "<dev string:x480>", "<dev string:x4a4>", "<dev string:x4d1>", "<dev string:x501>", "<dev string:x52e>", "<dev string:x55e>", "<dev string:x587>" );
            
            if ( var_f0a67f118414c800.allow_editing || dynamic_data.starter_puzzle )
            {
                switch ( command )
                {
                    case #"hash_76db3adf3289ef14":
                        dynamic_data.tiles[ var_f0a67f118414c800.selection_row ][ var_f0a67f118414c800.selection_col ].index++;
                        
                        if ( dynamic_data.tiles[ var_f0a67f118414c800.selection_row ][ var_f0a67f118414c800.selection_col ].index >= static_data.tile_set.tiles.size )
                        {
                            dynamic_data.tiles[ var_f0a67f118414c800.selection_row ][ var_f0a67f118414c800.selection_col ].index = 0;
                        }
                        
                        break;
                    case #"hash_e8c7748746ea8230":
                        dynamic_data.tiles[ var_f0a67f118414c800.selection_row ][ var_f0a67f118414c800.selection_col ].index--;
                        
                        if ( dynamic_data.tiles[ var_f0a67f118414c800.selection_row ][ var_f0a67f118414c800.selection_col ].index < 0 )
                        {
                            dynamic_data.tiles[ var_f0a67f118414c800.selection_row ][ var_f0a67f118414c800.selection_col ].index = static_data.tile_set.tiles.size - 1;
                        }
                        
                        break;
                    case #"hash_3bf3976d307d011e":
                        tile = dynamic_data.tiles[ var_f0a67f118414c800.selection_row ][ var_f0a67f118414c800.selection_col ];
                        tile.locked = !tile.locked;
                        break;
                    case #"hash_91d9543d1e456888":
                        tile = dynamic_data.tiles[ var_f0a67f118414c800.selection_row ][ var_f0a67f118414c800.selection_col ];
                        tile.not_selectable = !tile.not_selectable;
                        break;
                    case #"hash_6f57bdbd613d3741":
                        if ( ( dynamic_data.cols + 1 ) * dynamic_data.rows <= static_data.max_tiles )
                        {
                            if ( getdvarint( @"hash_cc20ecf42c5c23f5", 0 ) )
                            {
                                foreach ( connection in dynamic_data.connection_types )
                                {
                                    if ( isdefined( connection.source.col ) && connection.source.col > 0 )
                                    {
                                        connection.source.col++;
                                    }
                                    
                                    if ( isdefined( connection.target.col ) && connection.target.col > 0 )
                                    {
                                        connection.target.col++;
                                    }
                                }
                            }
                            
                            var_af7c515e12b4d349 = getdvarint( @"hash_50a9d28f1a1206d4", -1 );
                            
                            if ( getdvarint( @"hash_510d670935e36bc3", 0 ) )
                            {
                                for ( row = 0; row < dynamic_data.rows ; row++ )
                                {
                                    for ( col = dynamic_data.cols; col >= var_f0a67f118414c800.selection_col ; col-- )
                                    {
                                        dynamic_data.tiles = move_to_tile( dynamic_data.tiles, row, col, row, col - 1 );
                                    }
                                    
                                    add_tile( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance, row, var_f0a67f118414c800.selection_col );
                                }
                            }
                            else
                            {
                                for ( row = 0; row < dynamic_data.rows ; row++ )
                                {
                                    add_tile( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance, row, dynamic_data.cols );
                                }
                            }
                            
                            dynamic_data.cols++;
                            function_7227ef37be5d33c3( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance );
                        }
                        
                        break;
                    case #"hash_460efdd296b0069a":
                        if ( dynamic_data.cols > 1 )
                        {
                            if ( getdvarint( @"hash_cc20ecf42c5c23f5", 0 ) )
                            {
                                foreach ( connection in dynamic_data.connection_types )
                                {
                                    if ( isdefined( connection.source.col ) && connection.source.col > 0 )
                                    {
                                        connection.source.col--;
                                    }
                                    
                                    if ( isdefined( connection.target.col ) && connection.target.col > 0 )
                                    {
                                        connection.target.col--;
                                    }
                                }
                            }
                            else
                            {
                                foreach ( connection in dynamic_data.connection_types )
                                {
                                    if ( isdefined( connection.source.col ) && connection.source.col >= dynamic_data.cols - 1 )
                                    {
                                        connection.source.col--;
                                    }
                                    
                                    if ( isdefined( connection.target.col ) && connection.target.col >= dynamic_data.cols - 1 )
                                    {
                                        connection.target.col--;
                                    }
                                }
                            }
                            
                            if ( getdvarint( @"hash_510d670935e36bc3", 0 ) )
                            {
                                for ( row = 0; row < dynamic_data.rows ; row++ )
                                {
                                    for ( col = var_f0a67f118414c800.selection_col; col < dynamic_data.cols - 1 ; col++ )
                                    {
                                        dynamic_data.tiles = move_to_tile( dynamic_data.tiles, row, col, row, col + 1 );
                                    }
                                }
                            }
                            
                            for ( row = 0; row < dynamic_data.rows ; row++ )
                            {
                                dynamic_data.tiles[ row ][ dynamic_data.cols ] = undefined;
                            }
                            
                            dynamic_data.cols--;
                            
                            if ( var_f0a67f118414c800.selection_col >= dynamic_data.cols )
                            {
                                var_f0a67f118414c800.selection_col--;
                            }
                            
                            function_7227ef37be5d33c3( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance );
                        }
                        
                        break;
                    case #"hash_2ed5a1d322179fa1":
                        if ( ( dynamic_data.rows + 1 ) * dynamic_data.cols <= static_data.max_tiles )
                        {
                            if ( getdvarint( @"hash_cc20ecf42c5c23f5", 0 ) )
                            {
                                foreach ( connection in dynamic_data.connection_types )
                                {
                                    if ( isdefined( connection.source.row ) && connection.source.row > 0 )
                                    {
                                        connection.source.row++;
                                    }
                                    
                                    if ( isdefined( connection.target.row ) && connection.target.row > 0 )
                                    {
                                        connection.target.row++;
                                    }
                                }
                            }
                            
                            var_af7c515e12b4d349 = getdvarint( @"hash_50a9d28f1a1206d4", -1 );
                            
                            if ( getdvarint( @"hash_510d670935e36bc3", 0 ) )
                            {
                                for ( col = 0; col < dynamic_data.cols ; col++ )
                                {
                                    for ( row = dynamic_data.rows; row > var_f0a67f118414c800.selection_row ; row-- )
                                    {
                                        dynamic_data.tiles = move_to_tile( dynamic_data.tiles, row, col, row - 1, col );
                                    }
                                    
                                    add_tile( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance, var_f0a67f118414c800.selection_row, col );
                                }
                            }
                            else
                            {
                                for ( col = 0; col < dynamic_data.cols ; col++ )
                                {
                                    add_tile( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance, dynamic_data.rows, col );
                                }
                            }
                            
                            dynamic_data.rows++;
                            function_7227ef37be5d33c3( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance );
                        }
                        
                        break;
                    case #"hash_281d2cc9a2912ed4":
                        if ( dynamic_data.rows > 1 )
                        {
                            if ( getdvarint( @"hash_cc20ecf42c5c23f5", 0 ) )
                            {
                                foreach ( connection in dynamic_data.connection_types )
                                {
                                    if ( isdefined( connection.source.row ) && connection.source.row > 0 )
                                    {
                                        connection.source.row--;
                                    }
                                    
                                    if ( isdefined( connection.target.row ) && connection.target.row > 0 )
                                    {
                                        connection.target.row--;
                                    }
                                }
                            }
                            else
                            {
                                foreach ( connection in dynamic_data.connection_types )
                                {
                                    if ( isdefined( connection.source.row ) && connection.source.row >= dynamic_data.rows - 1 )
                                    {
                                        connection.source.row--;
                                    }
                                    
                                    if ( isdefined( connection.target.row ) && connection.target.row >= dynamic_data.rows - 1 )
                                    {
                                        connection.target.row--;
                                    }
                                }
                            }
                            
                            if ( getdvarint( @"hash_510d670935e36bc3", 0 ) )
                            {
                                for ( col = 0; col < dynamic_data.cols ; col++ )
                                {
                                    for ( row = var_f0a67f118414c800.selection_row; row < dynamic_data.rows - 1 ; row++ )
                                    {
                                        dynamic_data.tiles = move_to_tile( dynamic_data.tiles, row, col, row + 1, col );
                                    }
                                }
                            }
                            
                            dynamic_data.rows--;
                            
                            if ( var_f0a67f118414c800.selection_row >= dynamic_data.rows )
                            {
                                var_f0a67f118414c800.selection_row--;
                            }
                            
                            for ( col = 0; col < dynamic_data.cols ; col++ )
                            {
                                dynamic_data.tiles[ dynamic_data.rows ][ col ] = undefined;
                            }
                            
                            function_7227ef37be5d33c3( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance );
                        }
                        
                        break;
                    case #"hash_73d6389f652ed32c":
                        foreach ( type, connection_data in dynamic_data.connection_types )
                        {
                            if ( !connection_data.source )
                            {
                                connection_data.source = { #type:type, #side:0, #row:var_f0a67f118414c800.selection_row, #col:var_f0a67f118414c800.selection_col };
                                break;
                            }
                        }
                        
                        break;
                    case #"hash_cf16486f3856f74b":
                        foreach ( connection_type in dynamic_data.connection_types )
                        {
                            if ( connection_type.source && connection_type.source.col == var_f0a67f118414c800.selection_col && connection_type.source.row == var_f0a67f118414c800.selection_row )
                            {
                                connection_type.source = undefined;
                                break;
                            }
                        }
                        
                        break;
                    case #"hash_1889171a8e83f604":
                        foreach ( type, connection_data in dynamic_data.connection_types )
                        {
                            if ( !connection_data.target )
                            {
                                connection_data.target = { #type:type, #side:0, #row:var_f0a67f118414c800.selection_row, #col:var_f0a67f118414c800.selection_col };
                                break;
                            }
                        }
                        
                        break;
                    case #"hash_2956480911217c57":
                        foreach ( connection_type in dynamic_data.connection_types )
                        {
                            if ( connection_type.target && connection_type.target.col == var_f0a67f118414c800.selection_col && connection_type.target.row == var_f0a67f118414c800.selection_row )
                            {
                                connection_type.target = undefined;
                                break;
                            }
                        }
                        
                        break;
                    case #"hash_4edd1f5c56e40f69":
                        foreach ( connection_type in dynamic_data.connection_types )
                        {
                            if ( connection_type.source && connection_type.source.col == var_f0a67f118414c800.selection_col && connection_type.source.row == var_f0a67f118414c800.selection_row )
                            {
                                connection_type.source.side++;
                                
                                if ( connection_type.source.side >= static_data.tile_set.num_sides )
                                {
                                    connection_type.source.side = 0;
                                }
                            }
                            
                            if ( connection_type.target && connection_type.target.col == var_f0a67f118414c800.selection_col && connection_type.target.row == var_f0a67f118414c800.selection_row )
                            {
                                connection_type.target.side++;
                                
                                if ( connection_type.target.side >= static_data.tile_set.num_sides )
                                {
                                    connection_type.target.side = 0;
                                }
                            }
                        }
                        
                        break;
                    case #"hash_4d77ad033e0d5609":
                        function_7227ef37be5d33c3( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance );
                        function_fd984ea8096e2150( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance );
                        break;
                }
                
                dynamic_data.was_edited = 1;
                level thread update_tiles( var_f0a67f118414c800.asset, var_f0a67f118414c800.instance );
            }
        }
    }

    // Namespace connection_puzzle
    // Params 5, eflags: 0x4
    // Checksum 0x5d3314f6, Offset: 0x7420
    // Size: 0xbb, Type: dev
    function private move_to_tile( tiles, target_row, target_col, source_row, source_col )
    {
        if ( !isdefined( tiles[ target_row ] ) )
        {
            tiles[ target_row ] = [];
        }
        
        if ( !isdefined( tiles[ target_row ][ target_col ] ) )
        {
            tiles[ target_row ][ target_col ] = {};
        }
        
        target = tiles[ target_row ][ target_col ];
        source = tiles[ source_row ][ source_col ];
        target.index = source.index;
        target.rotation = source.rotation;
        target.initial_rotation = source.initial_rotation;
        return tiles;
    }

    // Namespace connection_puzzle
    // Params 4, eflags: 0x4
    // Checksum 0xd1ea85bb, Offset: 0x74e3
    // Size: 0x17f, Type: dev
    function private add_tile( asset, instance, row, col )
    {
        static_data = level.connection_puzzle.assets[ asset ].static_data;
        dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
        var_af7c515e12b4d349 = getdvarint( @"hash_50a9d28f1a1206d4", -1 );
        rand_result = function_8bad209c1dd9cd6( dynamic_data.seed, 0, static_data.tile_set.num_sides );
        dynamic_data.seed = rand_result.seed;
        dynamic_data.tiles[ row ][ col ] = {};
        dynamic_data.tiles[ row ][ col ].index = var_af7c515e12b4d349 > -1 ? var_af7c515e12b4d349 : get_random_tile( asset, instance );
        dynamic_data.tiles[ row ][ col ].rotation = rand_result.value;
        dynamic_data.tiles[ row ][ col ].initial_rotation = dynamic_data.tiles[ row ][ col ].rotation;
    }

#/

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0xb2f20d3b, Offset: 0x766a
// Size: 0xbf
function private get_random_tile( asset, instance )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    rand_result = function_8bad209c1dd9cd6( dynamic_data.seed, 0, static_data.tile_set.tiles.size );
    dynamic_data.seed = rand_result.seed;
    return rand_result.value;
}

// Namespace connection_puzzle
// Params 6, eflags: 0x4
// Checksum 0x106c6399, Offset: 0x7732
// Size: 0x73e
function private set_tile_input( asset, instance, col, row, side, type )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    tile_data = dynamic_data.tiles[ row ][ col ];
    
    if ( !isdefined( tile_data.inputs ) )
    {
        tile_data.inputs = [];
    }
    
    if ( !isdefined( tile_data.var_8ed222d5ef45dd5c ) )
    {
        tile_data.var_8ed222d5ef45dd5c = [];
    }
    
    if ( isdefined( tile_data.inputs[ side ] ) )
    {
        return ( tile_data.inputs[ side ] == type || dynamic_data.mixed_types_allowed );
    }
    
    tile_data.inputs[ side ] = type;
    
    if ( tile_data.triggers )
    {
        foreach ( trigger in tile_data.triggers )
        {
            rotated_side = ( side + tile_data.rotation ) % static_data.tile_set.num_sides;
            
            if ( rotated_side == trigger.side )
            {
                if ( !isdefined( dynamic_data.pending_triggers[ trigger.type ] ) )
                {
                    dynamic_data.pending_triggers[ trigger.type ] = [];
                }
                
                trigger_data = { #input:1, #connection_type:type, #side:trigger.side, #tile_col:col, #tile_row:row };
                dynamic_data.pending_triggers[ trigger.type ][ dynamic_data.pending_triggers[ trigger.type ].size ] = trigger_data;
            }
        }
    }
    
    if ( isdefined( tile_data.var_8ed222d5ef45dd5c[ side ] ) )
    {
        if ( tile_data.inputs[ side ] == tile_data.var_8ed222d5ef45dd5c[ side ] )
        {
            /#
                if ( getdvarint( @"connection_puzzle_debug", 0 ) )
                {
                    println( "<dev string:x314>" + col + "<dev string:x32f>" + row + "<dev string:x5ae>" + getxhashsourcename( type ) + "<dev string:x5d0>" + side );
                }
            #/
            
            return 1;
        }
        else
        {
            /#
                if ( getdvarint( @"connection_puzzle_debug", 0 ) )
                {
                    println( "<dev string:x314>" + col + "<dev string:x32f>" + row + "<dev string:x5da>" + getxhashsourcename( type ) + "<dev string:x5e7>" + getxhashsourcename( tile_data.var_8ed222d5ef45dd5c[ side ] ) + "<dev string:x5d0>" + side );
                }
            #/
            
            return dynamic_data.mixed_types_allowed;
        }
    }
    else
    {
        var_226a0207f0499e92 = ( side + tile_data.rotation ) % static_data.tile_set.num_sides;
        shift = var_226a0207f0499e92 * ( static_data.tile_set.num_sides - 1 );
        connection_map = static_data.tile_set.tiles[ tile_data.index ].connection_map;
        
        for ( i = 0; i < static_data.tile_set.num_sides - 1 ; i++ )
        {
            if ( connection_map & 1 << shift + i )
            {
                output_side = ( side + i + 1 ) % static_data.tile_set.num_sides;
                tile_data.var_8ed222d5ef45dd5c[ output_side ] = type;
                grid_offset = [[ static_data.tile_set.get_grid_offset ]]( col, row, output_side );
                pending_input = { #col:col + grid_offset.col, #row:row + grid_offset.row };
                
                if ( pending_input.row >= 0 && pending_input.row < dynamic_data.rows && pending_input.col >= 0 && pending_input.col < dynamic_data.cols )
                {
                    pending_input.type = type;
                    pending_input.side = [[ static_data.tile_set.var_2a6c8df0b9a53f82 ]]( output_side );
                    dynamic_data.pending_inputs[ dynamic_data.pending_inputs.size ] = pending_input;
                    
                    /#
                        if ( getdvarint( @"connection_puzzle_debug", 0 ) )
                        {
                            println( "<dev string:x314>" + col + "<dev string:x32f>" + row + "<dev string:x5f4>" + pending_input.col + "<dev string:x32f>" + pending_input.row + "<dev string:x600>" + side + "<dev string:x60d>" + pending_input.side + "<dev string:x617>" + getxhashsourcename( type ) );
                        }
                    #/
                }
                
                if ( tile_data.triggers )
                {
                    foreach ( trigger in tile_data.triggers )
                    {
                        rotated_side = ( output_side + tile_data.rotation ) % static_data.tile_set.num_sides;
                        
                        if ( rotated_side == trigger.side )
                        {
                            if ( !isdefined( dynamic_data.pending_triggers[ trigger.type ] ) )
                            {
                                dynamic_data.pending_triggers[ trigger.type ] = [];
                            }
                            
                            trigger_data = { #output:1, #connection_type:type, #side:trigger.side, #tile_col:col, #tile_row:row };
                            dynamic_data.pending_triggers[ trigger.type ][ dynamic_data.pending_triggers[ trigger.type ].size ] = trigger_data;
                        }
                    }
                }
            }
        }
    }
    
    return 1;
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x5f8d0b38, Offset: 0x7e79
// Size: 0x639
function private update_triggers( asset, instance )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    
    if ( !isdefined( dynamic_data.current_triggers ) )
    {
        dynamic_data.current_triggers = [];
    }
    
    foreach ( trigger_type, pending_triggers in dynamic_data.pending_triggers )
    {
        foreach ( var_85712f8ab1cc977 in pending_triggers )
        {
            found = 0;
            
            foreach ( current_trigger_data in dynamic_data.current_triggers[ trigger_type ] )
            {
                if ( current_trigger_data.tile_row == var_85712f8ab1cc977.tile_row && current_trigger_data.tile_col == var_85712f8ab1cc977.tile_col && current_trigger_data.side == var_85712f8ab1cc977.side && current_trigger_data.connection_type == var_85712f8ab1cc977.connection_type && istrue( current_trigger_data.input ) == istrue( var_85712f8ab1cc977.input ) && istrue( current_trigger_data.output ) == istrue( var_85712f8ab1cc977.output ) )
                {
                    found = 1;
                    break;
                }
            }
            
            if ( !found && isdefined( static_data.tile_set.trigger_types[ trigger_type ].var_b7ad4c4b44311946 ) )
            {
                trigger_data = { #trigger_data:var_85712f8ab1cc977, #instance:instance, #asset:asset };
                level notify( static_data.tile_set.trigger_types[ trigger_type ].var_b7ad4c4b44311946, trigger_data );
                
                /#
                    if ( getdvarint( @"connection_puzzle_debug", 0 ) && !getdvarint( @"hash_d22885815cb38438", 0 ) )
                    {
                        iprintln( "<dev string:x621>" + getxhashsourcename( trigger_type ) + "<dev string:x63f>" + static_data.tile_set.trigger_types[ trigger_type ].var_b7ad4c4b44311946 );
                    }
                #/
            }
        }
    }
    
    foreach ( trigger_type, current_triggers in dynamic_data.current_triggers )
    {
        foreach ( current_trigger_data in current_triggers )
        {
            found = 0;
            
            foreach ( var_85712f8ab1cc977 in dynamic_data.pending_triggers[ trigger_type ] )
            {
                if ( current_trigger_data.tile_row == var_85712f8ab1cc977.tile_row && current_trigger_data.tile_col == var_85712f8ab1cc977.tile_col && current_trigger_data.side == var_85712f8ab1cc977.side && current_trigger_data.connection_type == var_85712f8ab1cc977.connection_type && istrue( current_trigger_data.input ) == istrue( var_85712f8ab1cc977.input ) && istrue( current_trigger_data.output ) == istrue( var_85712f8ab1cc977.output ) )
                {
                    found = 1;
                    break;
                }
            }
            
            if ( !found && isdefined( static_data.tile_set.trigger_types[ trigger_type ].untrigger_notify ) )
            {
                trigger_data = { #trigger_data:var_85712f8ab1cc977, #instance:instance, #asset:asset };
                level notify( static_data.tile_set.trigger_types[ trigger_type ].untrigger_notify, trigger_data );
                
                /#
                    if ( getdvarint( @"connection_puzzle_debug", 0 ) && !getdvarint( @"hash_d22885815cb38438", 0 ) )
                    {
                        iprintln( "<dev string:x644>" + getxhashsourcename( trigger_type ) + "<dev string:x63f>" + static_data.tile_set.trigger_types[ trigger_type ].untrigger_notify );
                    }
                #/
            }
        }
    }
    
    dynamic_data.current_triggers = dynamic_data.pending_triggers;
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x499022d1, Offset: 0x84ba
// Size: 0x35c
function private update_connections( asset, instance )
{
    reset_connections( asset, instance );
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    dynamic_data.pending_inputs = [];
    dynamic_data.pending_triggers = [];
    
    foreach ( type, connection in dynamic_data.connection_types )
    {
        dynamic_data.pending_inputs[ type ] = connection.source;
    }
    
    no_contamination = 1;
    
    while ( dynamic_data.pending_inputs.size > 0 )
    {
        current_inputs = dynamic_data.pending_inputs;
        dynamic_data.pending_inputs = [];
        
        foreach ( input in current_inputs )
        {
            if ( isdefined( input.col ) && isdefined( input.row ) )
            {
                no_contamination &= set_tile_input( asset, instance, input.col, input.row, input.side, input.type );
            }
        }
    }
    
    update_triggers( asset, instance );
    outputs_match = no_contamination;
    has_target_outputs = 0;
    
    if ( outputs_match )
    {
        foreach ( type, connection in dynamic_data.connection_types )
        {
            has_target_outputs |= isdefined( connection.target );
            
            if ( connection.target && dynamic_data.tiles[ connection.target.row ][ connection.target.col ].var_8ed222d5ef45dd5c[ connection.target.side ] != type )
            {
                outputs_match = 0;
                break;
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_d22885815cb38438", 0 ) )
        {
            outputs_match = 0;
        }
    #/
    
    if ( outputs_match && has_target_outputs )
    {
        thread success( asset, instance );
        return;
    }
    
    /#
        if ( getdvarint( @"connection_puzzle_debug", 0 ) && !getdvarint( @"hash_d22885815cb38438", 0 ) )
        {
            iprintln( "<dev string:x664>" );
        }
    #/
}

// Namespace connection_puzzle
// Params 5, eflags: 0x4
// Checksum 0xbd10b4d0, Offset: 0x881e
// Size: 0x173
function private function_69f4df2974a10ac9( static_data, dynamic_data, row, col, side )
{
    tile = dynamic_data.tiles[ row ][ col ];
    tile_index = row * dynamic_data.cols + col;
    connection_map = static_data.tile_set.tiles[ tile.index ].connection_map;
    connection_deadends = static_data.tile_set.tiles[ tile.index ].connection_deadends;
    rotated_side = undefined;
    shift = undefined;
    
    if ( isdefined( side ) )
    {
        rotated_side = ( side + tile.rotation ) % static_data.tile_set.num_sides;
        shift = rotated_side * ( static_data.tile_set.num_sides - 1 );
    }
    
    return { #shift:shift, #rotated_side:rotated_side, #connection_deadends:connection_deadends, #connection_map:connection_map, #tile_index:tile_index, #tile:tile };
}

// Namespace connection_puzzle
// Params 6, eflags: 0x4
// Checksum 0x586c2faf, Offset: 0x899a
// Size: 0x276, Type: bool
function private function_9d692ee405d79568( static_data, dynamic_data, tile_index, parent_index, visited, in_stack )
{
    tile_row = int( tile_index / dynamic_data.cols );
    tile_col = tile_index % dynamic_data.cols;
    mask = ( 1 << static_data.tile_set.num_sides - 1 ) - 1;
    visited[ tile_index ] = 1;
    in_stack[ tile_index ] = 1;
    
    for ( side = 0; side < static_data.tile_set.num_sides ; side++ )
    {
        tile_data = function_69f4df2974a10ac9( static_data, dynamic_data, tile_row, tile_col, side );
        
        if ( tile_data.connection_map & mask << tile_data.shift || tile_data.connection_deadends & 1 << tile_data.rotated_side )
        {
            grid_offset = [[ static_data.tile_set.get_grid_offset ]]( tile_col, tile_row, side );
            neighbor_col = tile_col + grid_offset.col;
            neighbor_row = tile_row + grid_offset.row;
            
            if ( neighbor_row >= 0 && neighbor_row < dynamic_data.rows && neighbor_col >= 0 && neighbor_col < dynamic_data.cols )
            {
                neighbor = function_69f4df2974a10ac9( static_data, dynamic_data, neighbor_row, neighbor_col, [[ static_data.tile_set.var_2a6c8df0b9a53f82 ]]( side ) );
                
                if ( neighbor.connection_map & mask << neighbor.shift || neighbor.connection_deadends & 1 << neighbor.rotated_side )
                {
                    if ( neighbor.tile_index == parent_index )
                    {
                        continue;
                    }
                    
                    if ( in_stack[ neighbor.tile_index ] )
                    {
                        return true;
                    }
                    
                    if ( !visited[ neighbor.tile_index ] && function_9d692ee405d79568( static_data, dynamic_data, neighbor.tile_index, tile_index, visited, in_stack ) )
                    {
                        return true;
                    }
                }
            }
        }
    }
    
    in_stack[ tile_index ] = 0;
    return false;
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x56037839, Offset: 0x8c19
// Size: 0x2c5
function private update_closure( asset, instance )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    mask = ( 1 << static_data.tile_set.num_sides - 1 ) - 1;
    
    for ( row = 0; row < dynamic_data.rows ; row++ )
    {
        for ( col = 0; col < dynamic_data.cols ; col++ )
        {
            for ( side = 0; side < static_data.tile_set.num_sides ; side++ )
            {
                tile_data = function_69f4df2974a10ac9( static_data, dynamic_data, row, col, side );
                
                if ( tile_data.connection_map & mask << tile_data.shift || tile_data.connection_deadends & 1 << tile_data.rotated_side )
                {
                    grid_offset = [[ static_data.tile_set.get_grid_offset ]]( col, row, side );
                    neighbor_col = col + grid_offset.col;
                    neighbor_row = row + grid_offset.row;
                    
                    if ( neighbor_row < 0 || neighbor_row >= dynamic_data.rows || neighbor_col < 0 || neighbor_col >= dynamic_data.cols )
                    {
                        return;
                    }
                    
                    neighbor = function_69f4df2974a10ac9( static_data, dynamic_data, neighbor_row, neighbor_col, [[ static_data.tile_set.var_2a6c8df0b9a53f82 ]]( side ) );
                    
                    if ( !( neighbor.connection_map & mask << neighbor.shift || neighbor.connection_deadends & 1 << neighbor.rotated_side ) )
                    {
                        return;
                    }
                }
            }
        }
    }
    
    if ( !dynamic_data.mixed_types_allowed )
    {
        visited = [];
        in_stack = [];
        
        for ( tile_index = 0; tile_index < dynamic_data.rows * dynamic_data.cols ; tile_index++ )
        {
            if ( visited[ tile_index ] )
            {
                continue;
            }
            
            if ( function_9d692ee405d79568( static_data, dynamic_data, tile_index, undefined, visited, in_stack ) )
            {
                return;
            }
        }
    }
    
    thread success( asset, instance );
}

// Namespace connection_puzzle
// Params 2, eflags: 0xc
// Checksum 0x3dbe9ea1, Offset: 0x8ee6
// Size: 0xa9
function private update_tiles( asset, instance )
{
    self notify( #"hash_d1fe6f1abcef6952" );
    self endon( #"hash_d1fe6f1abcef6952" );
    waittillframeend();
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    
    switch ( dynamic_data.puzzle_mode ?? "CONNECTIONS" )
    {
        case #"hash_1b11bbbafd23c79e":
            thread update_connections( asset, instance );
            break;
        case #"hash_d641d1bec7165c02":
            thread update_closure( asset, instance );
            break;
    }
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x75aff423, Offset: 0x8f97
// Size: 0x230
function private success( asset, instance )
{
    static_data = level.connection_puzzle.assets[ asset ].static_data;
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    dynamic_data.completed = 1;
    dynamic_data.end_time = undefined;
    delay_time = ( static_data.tile_set.var_4dfec929b4a0bad4 > 0 ? static_data.tile_set.var_4dfec929b4a0bad4 : 0 ) + ( static_data.var_8c51e0668f8930d6 ?? 0 );
    
    if ( delay_time > 0 )
    {
        wait delay_time / 1000;
    }
    
    players = [];
    
    foreach ( player in dynamic_data.players )
    {
        if ( isdefined( player.controller ) )
        {
            players[ players.size ] = player.controller;
            player.controller scripted_widgets::set_state( "connection_puzzle", "ConnectionSuccess" );
            player notify( #"ConnectionPuzzleCompleted", { #data:dynamic_data.var_2e3bf03447341ea, #instance:instance, #asset:asset } );
        }
    }
    
    level notify( #"ConnectionPuzzleCompleted", { #data:dynamic_data.var_2e3bf03447341ea, #players:players, #instance:instance, #asset:asset } );
    
    /#
        if ( getdvarint( @"connection_puzzle_debug", 0 ) )
        {
            iprintln( "<dev string:x681>" );
        }
    #/
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x9805e089, Offset: 0x91cf
// Size: 0xc8
function private reset_connections( asset, instance )
{
    dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
    dynamic_data.completed = 0;
    
    for ( row = 0; row < dynamic_data.rows ; row++ )
    {
        for ( col = 0; col < dynamic_data.cols ; col++ )
        {
            dynamic_data.tiles[ row ][ col ].inputs = undefined;
            dynamic_data.tiles[ row ][ col ].var_8ed222d5ef45dd5c = undefined;
        }
    }
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0xc1f13960, Offset: 0x929f
// Size: 0x38c
function private function_3fb92bd16a23fa38( layout_file )
{
    data = {};
    
    if ( tableexists( layout_file ) )
    {
        col = 0;
        data.asset = tablelookupbyrow( layout_file, 0, col );
        col++;
        data.cols = int( tablelookupbyrow( layout_file, 0, col ) );
        col++;
        data.rows = int( tablelookupbyrow( layout_file, 0, col ) );
        col++;
        data.var_61999d41dcd4d94f = int( tablelookupbyrow( layout_file, 0, col ) );
        col++;
        data.connections = [];
        
        for ( i = 0; i < data.var_61999d41dcd4d94f ; i++ )
        {
            type = getxhash( "Type" + i );
            data.connections[ type ] = { #target:{}, #source:{} };
            source_side = tablelookupbyrow( layout_file, 0, col );
            
            if ( source_side != "" )
            {
                data.connections[ type ].source.side = int( source_side );
                col++;
                data.connections[ type ].source.col = int( tablelookupbyrow( layout_file, 0, col ) );
                col++;
                data.connections[ type ].source.row = int( tablelookupbyrow( layout_file, 0, col ) );
                col++;
            }
            else
            {
                col += 3;
            }
            
            target_side = tablelookupbyrow( layout_file, 0, col );
            
            if ( target_side != "" )
            {
                data.connections[ type ].target.side = int( target_side );
                col++;
                data.connections[ type ].target.col = int( tablelookupbyrow( layout_file, 0, col ) );
                col++;
                data.connections[ type ].target.row = int( tablelookupbyrow( layout_file, 0, col ) );
                col++;
                continue;
            }
            
            col += 3;
        }
        
        data.num_tiles = int( tablelookupbyrow( layout_file, 0, col ) );
        col++;
        data.tiles = [];
        
        for ( i = 0; i < data.num_tiles ; i++ )
        {
            data.tiles[ i ] = {};
            data.tiles[ i ].type = getxhash( tablelookupbyrow( layout_file, 0, col ) );
            col++;
            data.tiles[ i ].rotation = int( tablelookupbyrow( layout_file, 0, col ) );
            col++;
            data.tiles[ i ].col = int( tablelookupbyrow( layout_file, 0, col ) );
            col++;
            data.tiles[ i ].row = int( tablelookupbyrow( layout_file, 0, col ) );
            col++;
        }
        
        data.start_selection = int( tablelookupbyrow( layout_file, 0, col ) ?? 0 );
    }
    
    return data;
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0x5bbb2ccf, Offset: 0x9634
// Size: 0x39
function private function_8dfadec4c3b8f29f( data )
{
    assert( isdefined( data.type ) );
    return getxhash( "Type" + int( data.type ) );
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x1f852128, Offset: 0x9676
// Size: 0xa8
function private function_cb0bb261d16a24f7( layout_file, data )
{
    assert( isdefined( data.row ) && isdefined( data.col ) );
    tile = {};
    tile.type = getxhash( tablelookupbyrow( layout_file, data.row, data.col * 2 ) );
    tile.rotation = int( tablelookupbyrow( layout_file, data.row, data.col * 2 + 1 ) );
    return tile;
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x82ca9483, Offset: 0x9727
// Size: 0x110
function private function_e26c17ec3aa1d38a( layout_file, data )
{
    assert( isdefined( data.row ) && isdefined( data.col ) );
    tile = {};
    tile.type = getxhash( tablelookupbyrow( layout_file, data.row, data.col * 4 ) );
    tile.rotation = int( tablelookupbyrow( layout_file, data.row, data.col * 4 + 1 ) );
    tile.locked = int( tablelookupbyrow( layout_file, data.row, data.col * 4 + 2 ) ) != 0;
    tile.not_selectable = int( tablelookupbyrow( layout_file, data.row, data.col * 4 + 3 ) ) != 0;
    return tile;
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x573e4578, Offset: 0x9840
// Size: 0x148
function private function_c675a0a09dfc1c78( layout_file, data )
{
    assert( isdefined( data.row ) );
    assert( isdefined( data.tiles ) );
    cur_row = data.row;
    var_3ab8c4d4f5ff0646 = int( tablelookupbyrow( layout_file, cur_row, 0 ) ?? 0 );
    cur_row++;
    
    for ( i = 0; i < var_3ab8c4d4f5ff0646 ; i++ )
    {
        tile_index = int( tablelookupbyrow( layout_file, cur_row, 0 ) ?? 0 );
        
        if ( !isdefined( data.tiles[ tile_index ].triggers ) )
        {
            data.tiles[ tile_index ].triggers = [];
        }
        
        trigger_data = { #side:int( tablelookupbyrow( layout_file, cur_row, 2 ) ), #type:getxhash( tablelookupbyrow( layout_file, cur_row, 1 ) ) };
        data.tiles[ tile_index ].triggers[ data.tiles[ tile_index ].triggers.size ] = trigger_data;
        cur_row++;
    }
    
    return cur_row;
}

// Namespace connection_puzzle
// Params 1, eflags: 0x4
// Checksum 0x8173de9b, Offset: 0x9991
// Size: 0x2f
function private function_2c04d4c25e45c246( data )
{
    assert( isdefined( data.type ) );
    return getxhash( data.type );
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0xc4214342, Offset: 0x99c9
// Size: 0xaf
function private function_8feb6016702fd56c( layout_file, data )
{
    padding = {};
    padding.top = tablelookupbyrow( layout_file, data.row, 0 ) ?? 0;
    padding.bottom = tablelookupbyrow( layout_file, data.row, 1 ) ?? 0;
    padding.left = tablelookupbyrow( layout_file, data.row, 2 ) ?? 0;
    padding.right = tablelookupbyrow( layout_file, data.row, 3 ) ?? 0;
    return padding;
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0x82cc0b15, Offset: 0x9a81
// Size: 0x52e
function private function_af0ab05983ed6d27( connection_puzzle_asset, layout_file )
{
    data = {};
    cur_row = 0;
    version = int( tablelookupbyrow( layout_file, cur_row, 0 ) );
    version_funcs = level.connection_puzzle.var_7e94add7de9064b0[ version ];
    assert( isdefined( version_funcs[ #"hash_89adc3d6acbad06c" ] ) );
    assert( isdefined( version_funcs[ #"gettile" ] ) );
    
    if ( version > 0 )
    {
        cur_row++;
    }
    
    data.asset = hashcat( %"scriptedwidget:", tablelookupbyrow( layout_file, cur_row, 0 ) );
    data.cols = int( tablelookupbyrow( layout_file, cur_row, 1 ) );
    data.rows = int( tablelookupbyrow( layout_file, cur_row, 2 ) );
    connection_types = int( tablelookupbyrow( layout_file, cur_row, 3 ) );
    cur_row++;
    static_data = level.connection_puzzle.assets[ connection_puzzle_asset ].static_data;
    data.connections = [];
    
    if ( static_data.tile_set.connection_types )
    {
        foreach ( var_f3dc352df97f52c8, type in static_data.tile_set.connection_types )
        {
            data.connections[ var_f3dc352df97f52c8 ] = { #target:{}, #source:{} };
        }
    }
    
    for ( i = 0; i < connection_types ; i++ )
    {
        type = [[ version_funcs[ #"hash_89adc3d6acbad06c" ] ]]( { #type:tablelookupbyrow( layout_file, cur_row, 0 ) } );
        assert( isdefined( data.connections[ type ] ), "<dev string:x6a4>" + getxhashsourcename( type ) + "<dev string:x6ba>" + getxhashsourcename( connection_puzzle_asset ) + "<dev string:x6d6>" + getxhashsourcename( data.asset ) + "<dev string:x6fb>" );
        source_side = tablelookupbyrow( layout_file, cur_row, 1 );
        
        if ( source_side != "-" )
        {
            data.connections[ type ].source.side = int( source_side );
            data.connections[ type ].source.col = int( tablelookupbyrow( layout_file, cur_row, 2 ) );
            data.connections[ type ].source.row = int( tablelookupbyrow( layout_file, cur_row, 3 ) );
        }
        
        target_side = tablelookupbyrow( layout_file, cur_row, 4 );
        
        if ( target_side != "-" )
        {
            data.connections[ type ].target.side = int( target_side );
            data.connections[ type ].target.col = int( tablelookupbyrow( layout_file, cur_row, 5 ) );
            data.connections[ type ].target.row = int( tablelookupbyrow( layout_file, cur_row, 6 ) );
        }
        
        cur_row++;
    }
    
    data.tiles = [];
    tile_index = 0;
    
    for ( row = 0; row < data.rows ; row++ )
    {
        for ( col = 0; col < data.cols ; col++ )
        {
            data.tiles[ tile_index ] = [[ version_funcs[ #"gettile" ] ]]( layout_file, { #col:col, #row:cur_row } );
            tile_index++;
        }
        
        cur_row++;
    }
    
    if ( isdefined( version_funcs[ #"gettriggers" ] ) )
    {
        cur_row = [[ version_funcs[ #"gettriggers" ] ]]( layout_file, { #tiles:data.tiles, #row:cur_row } );
    }
    
    if ( isdefined( version_funcs[ #"getpadding" ] ) )
    {
        data.padding = [[ version_funcs[ #"getpadding" ] ]]( layout_file, { #row:cur_row } );
        cur_row++;
    }
    else
    {
        data.padding = { #right:0, #left:0, #bottom:0, #top:0 };
    }
    
    data.start_selection = int( tablelookupbyrow( layout_file, cur_row, 0 ) ?? 0 );
    return data;
}

// Namespace connection_puzzle
// Params 2, eflags: 0x4
// Checksum 0xb8535d20, Offset: 0x9fb8
// Size: 0x53
function private function_e15502a7f37cae1c( connection_puzzle_asset, layout_file )
{
    if ( isdefined( layout_file ) && tableexists( layout_file ) )
    {
        var_cc48735c9f8faaca = tablelookupgetnumrows( layout_file );
        
        if ( var_cc48735c9f8faaca == 1 )
        {
            return function_3fb92bd16a23fa38( layout_file );
        }
        
        return function_af0ab05983ed6d27( connection_puzzle_asset, layout_file );
    }
    
    return {};
}

/#

    // Namespace connection_puzzle
    // Params 2, eflags: 0x4
    // Checksum 0xd0e917d9, Offset: 0xa014
    // Size: 0x63f, Type: dev
    function private function_920fc16d3334fa94( asset, instance )
    {
        static_data = level.connection_puzzle.assets[ asset ].static_data;
        dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
        sync_data = getdvar( @"hash_638803a5cb98272a" );
        setdevdvar( @"hash_638803a5cb98272a", "<dev string:x6fe>" );
        setdevdvar( @"hash_20973a208000269e", 0 );
        
        if ( sync_data != "<dev string:x6fe>" )
        {
            index = 0;
            data = strtok( sync_data, "<dev string:x6ff>" );
            version = int( data[ index ] );
            assert( version == 4 );
            index++;
            assert( asset == data[ index ] );
            index++;
            dynamic_data.cols = int( data[ index ] );
            index++;
            dynamic_data.rows = int( data[ index ] );
            index++;
            connection_types = int( data[ index ] );
            index++;
            
            foreach ( connection in dynamic_data.connection_types )
            {
                connection = { #target:{}, #source:{} };
            }
            
            for ( i = 0; i < connection_types ; i++ )
            {
                connection_type = getxhash( data[ index ] );
                index++;
                source_side = data[ index ];
                
                if ( source_side != "<dev string:x701>" )
                {
                    dynamic_data.connection_types[ connection_type ].source.side = int( source_side );
                    index++;
                    dynamic_data.connection_types[ connection_type ].source.col = int( data[ index ] );
                    index++;
                    dynamic_data.connection_types[ connection_type ].source.row = int( data[ index ] );
                    index++;
                }
                else
                {
                    index += 3;
                }
                
                target_side = data[ index ];
                
                if ( target_side != "<dev string:x701>" )
                {
                    dynamic_data.connection_types[ connection_type ].target.side = int( target_side );
                    index++;
                    dynamic_data.connection_types[ connection_type ].target.col = int( data[ index ] );
                    index++;
                    dynamic_data.connection_types[ connection_type ].target.row = int( data[ index ] );
                    index++;
                    continue;
                }
                
                index += 3;
            }
            
            dynamic_data.tiles = [];
            
            for ( row = 0; row < dynamic_data.rows ; row++ )
            {
                dynamic_data.tiles[ row ] = [];
                
                for ( col = 0; col < dynamic_data.cols ; col++ )
                {
                    dynamic_data.tiles[ row ][ col ] = {};
                    dynamic_data.tiles[ row ][ col ].index = int( data[ index ] );
                    index++;
                    dynamic_data.tiles[ row ][ col ].rotation = int( data[ index ] );
                    index++;
                    dynamic_data.tiles[ row ][ col ].locked = int( data[ index ] );
                    index++;
                    dynamic_data.tiles[ row ][ col ].not_selectable = int( data[ index ] );
                    index++;
                    dynamic_data.tiles[ row ][ col ].initial_rotation = dynamic_data.tiles[ row ][ col ].rotation;
                }
            }
            
            var_3ab8c4d4f5ff0646 = int( data[ index ] ?? 0 );
            index++;
            
            for ( i = 0; i < var_3ab8c4d4f5ff0646 ; i++ )
            {
                tile_index = int( data[ index ] );
                index++;
                trigger_name = data[ index ];
                index++;
                trigger_side = int( data[ index ] );
                index++;
                
                if ( isdefined( trigger_name ) )
                {
                    col = tile_index % dynamic_data.cols;
                    row = int( floor( tile_index / dynamic_data.cols ) );
                    
                    if ( !isdefined( dynamic_data.tiles[ row ][ col ].triggers ) )
                    {
                        dynamic_data.tiles[ row ][ col ].triggers = [];
                    }
                    
                    trigger_data = { #side:trigger_side, #type:trigger_name };
                    dynamic_data.tiles[ row ][ col ].triggers[ dynamic_data.tiles[ row ][ col ].triggers.size ] = trigger_data;
                }
            }
            
            padding = {};
            padding.top = data[ index ];
            index++;
            padding.bottom = data[ index ];
            index++;
            padding.left = data[ index ];
            index++;
            padding.right = data[ index ];
            index++;
            dynamic_data.padding = padding;
            dynamic_data.start_selection = int( data[ index ] ?? 0 );
            iprintlnbold( "<dev string:x703>" );
        }
    }

    // Namespace connection_puzzle
    // Params 2, eflags: 0x4
    // Checksum 0xd3ad6a53, Offset: 0xa65b
    // Size: 0x8dc, Type: dev
    function private function_fd984ea8096e2150( asset, instance )
    {
        if ( !isdefined( instance ) )
        {
            instance = "<dev string:x5d>";
        }
        
        static_data = level.connection_puzzle.assets[ asset ].static_data;
        dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
        function_920fc16d3334fa94( asset, instance );
        file_path = "<dev string:x732>";
        file_name = getdvar( @"hash_b31524a3ea1baaa5" );
        file_ext = "<dev string:x74f>";
        file = file_path + file_name + file_ext;
        file_id = undefined;
        
        if ( getdvarint( @"hash_cee693e3d173cb93", 0 ) )
        {
            file_id = openfile( file, "<dev string:x754>" );
        }
        else
        {
            file_index = 0;
            
            while ( true )
            {
                file_id = openfile( file, "<dev string:x75a>" );
                
                if ( file_id != -1 )
                {
                    file_index++;
                    file = file_path + file_name + "<dev string:x75f>" + file_index + file_ext;
                    closefile( file_id );
                    continue;
                }
                
                file_name = file_name + "<dev string:x75f>" + file_index;
                file_id = openfile( file, "<dev string:x754>" );
                break;
            }
        }
        
        lines = [];
        lines[ 0 ] = "<dev string:x761>";
        lines[ 1 ] = "<dev string:x6fe>" + 4;
        lines[ 2 ] = "<dev string:x771>";
        header_row = 3;
        lines[ header_row ] = removesubstr( getxhashsourcename( asset ), "<dev string:x793>" ) + "<dev string:x6ff>" + dynamic_data.cols + "<dev string:x6ff>" + dynamic_data.rows + "<dev string:x6ff>";
        lines[ header_row + 1 ] = "<dev string:x7a3>";
        line_row = header_row + 2;
        var_bf07db9deb1a4ae9 = 0;
        
        foreach ( type, connection in dynamic_data.connection_types )
        {
            if ( !connection.source && !connection.target )
            {
                continue;
            }
            
            lines[ line_row ] = "<dev string:x6fe>" + getxhashsourcename( type ) + "<dev string:x6ff>";
            
            if ( connection.source )
            {
                lines[ line_row ] += connection.source.side + "<dev string:x6ff>" + connection.source.col + "<dev string:x6ff>" + connection.source.row + "<dev string:x6ff>";
            }
            else
            {
                lines[ line_row ] += "<dev string:x83a>";
            }
            
            if ( connection.target )
            {
                lines[ line_row ] += connection.target.side + "<dev string:x6ff>" + connection.target.col + "<dev string:x6ff>" + connection.target.row + "<dev string:x6ff>";
            }
            else
            {
                lines[ line_row ] += "<dev string:x83a>";
            }
            
            line_row++;
            var_bf07db9deb1a4ae9++;
        }
        
        lines[ header_row ] += var_bf07db9deb1a4ae9;
        lines[ line_row ] = "<dev string:x842>";
        line_row++;
        var_3ab8c4d4f5ff0646 = 0;
        triggers = [];
        
        for ( row = 0; row < dynamic_data.rows ; row++ )
        {
            lines[ line_row ] = "<dev string:x6fe>";
            
            for ( col = 0; col < dynamic_data.cols ; col++ )
            {
                tile = dynamic_data.tiles[ row ][ col ];
                lines[ line_row ] += getxhashsourcename( static_data.tile_set.tiles[ tile.index ].name ) + "<dev string:x6ff>";
                lines[ line_row ] += tile.rotation + "<dev string:x6ff>";
                lines[ line_row ] += ( tile.locked ?? 0 ) + "<dev string:x6ff>";
                lines[ line_row ] += ( tile.not_selectable ?? 0 ) + "<dev string:x6ff>";
                
                if ( isarray( tile.triggers ) && tile.triggers.size > 0 )
                {
                    var_3ab8c4d4f5ff0646 += tile.triggers.size;
                    
                    foreach ( trigger in tile.triggers )
                    {
                        trigger_data = { #side:trigger.side, #type:trigger.type, #tile_index:row * dynamic_data.cols + col };
                        triggers[ triggers.size ] = trigger_data;
                    }
                }
            }
            
            line_row++;
        }
        
        lines[ line_row ] = "<dev string:x875>";
        line_row++;
        lines[ line_row ] = "<dev string:x6fe>" + var_3ab8c4d4f5ff0646;
        line_row++;
        
        foreach ( trigger in triggers )
        {
            lines[ line_row ] = "<dev string:x6fe>" + trigger.tile_index + "<dev string:x6ff>" + trigger.type + "<dev string:x6ff>" + trigger.side;
            line_row++;
        }
        
        lines[ line_row ] = "<dev string:x8aa>";
        line_row++;
        lines[ line_row ] = "<dev string:x6fe>" + dynamic_data.padding.top + "<dev string:x6ff>" + dynamic_data.padding.bottom + "<dev string:x6ff>" + dynamic_data.padding.left + "<dev string:x6ff>" + dynamic_data.padding.right;
        line_row++;
        lines[ line_row ] = "<dev string:x8ce>";
        line_row++;
        
        foreach ( player in dynamic_data.players )
        {
            if ( player.controller == self )
            {
                lines[ line_row ] = "<dev string:x6fe>" + player.selection;
                line_row++;
                break;
            }
        }
        
        data = "<dev string:x6fe>";
        
        foreach ( line in lines )
        {
            data += line + "<dev string:x8d9>";
        }
        
        fprintln( file_id, data );
        closefile( file_id );
        platform = "<dev string:x6fe>";
        
        if ( self ispcplayer() )
        {
            platform = "<dev string:x8db>";
        }
        else if ( self function_787b88bd6601ec4a() )
        {
            platform = "<dev string:x8de>";
        }
        else if ( self function_71b99fed77af9be5() )
        {
            platform = "<dev string:x8e2>";
        }
        
        iprintlnbold( "<dev string:x8e6>" + file_name + "<dev string:x901>" + platform + "<dev string:x916>" + file_path );
        println( "<dev string:x8e6>" + file_name + "<dev string:x901>" + platform + "<dev string:x916>" + file_path );
        
        if ( getdvarint( @"hash_b63e976f8b82405a", 1 ) )
        {
            function_4dd02aeebdccd749( file_path );
        }
    }

    // Namespace connection_puzzle
    // Params 2, eflags: 0x4
    // Checksum 0xceb7ac69, Offset: 0xaf3f
    // Size: 0x181, Type: dev
    function private function_7227ef37be5d33c3( asset, instance )
    {
        if ( getdvarint( @"connection_puzzle_debug", 0 ) )
        {
            static_data = level.connection_puzzle.assets[ asset ].static_data;
            dynamic_data = level.connection_puzzle.assets[ asset ].dynamic_data[ instance ];
            
            for ( row = 0; row < dynamic_data.rows ; row++ )
            {
                for ( col = 0; col < dynamic_data.cols ; col++ )
                {
                    println( "<dev string:x314>" + col + "<dev string:x32f>" + row + "<dev string:x332>" + static_data.tile_set.tiles[ dynamic_data.tiles[ row ][ col ].index ].name + "<dev string:x33c>" + dynamic_data.tiles[ row ][ col ].rotation + "<dev string:x928>" + istrue( dynamic_data.tiles[ row ][ col ].locked ) + "<dev string:x933>" + !dynamic_data.tiles[ row ][ col ].not_selectable );
                }
            }
        }
    }

    // Namespace connection_puzzle
    // Params 0
    // Checksum 0xb10dafed, Offset: 0xb0c8
    // Size: 0x3e8, Type: dev
    function devgui_setup_connection_puzzle()
    {
        setdevdvarifuninitialized( @"connection_puzzle_skip", 0 );
        setdevdvarifuninitialized( @"hash_b31524a3ea1baaa5", "<dev string:x942>" );
        setdevdvarifuninitialized( @"hash_cee693e3d173cb93", 0 );
        setdevdvarifuninitialized( @"hash_b63e976f8b82405a", 1 );
        setdevdvarifuninitialized( @"hash_d22885815cb38438", 0 );
        setdevdvarifuninitialized( @"hash_cc20ecf42c5c23f5", 1 );
        setdevdvarifuninitialized( @"hash_510d670935e36bc3", 1 );
        setdevdvarifuninitialized( @"hash_50a9d28f1a1206d4", -1 );
        setdevdvarifuninitialized( @"connection_puzzle_debug", 0 );
        setdevdvarifuninitialized( @"connection_puzzle_timer", -1 );
        setdevdvarifuninitialized( @"hash_638803a5cb98272a", "<dev string:x6fe>" );
        setdevdvarifuninitialized( @"hash_20973a208000269e", 0 );
        setdevdvarifuninitialized( @"hash_33d8d60aefa7ce3", 1 );
        setdevdvarifuninitialized( @"hash_625521b424364d64", 0 );
        utility::flag_wait( "<dev string:x95b>" );
        devgui::function_9082edeb5db93280( "<dev string:x978>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x98b>", @"connection_puzzle_skip" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x997>", @"hash_d22885815cb38438" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x9ae>", @"hash_cee693e3d173cb93" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x9d7>", @"hash_b63e976f8b82405a" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xa00>", @"hash_510d670935e36bc3" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xa29>", @"hash_cc20ecf42c5c23f5" );
        devgui::add_devgui_func( "<dev string:xa52>", "<dev string:xa73>", &function_c31ed1cd948a0a76 );
        devgui::add_devgui_dvar( "<dev string:xa7d>", "<dev string:xa9a>" );
        devgui::add_devgui_dvar( "<dev string:xac1>", "<dev string:xac7>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xadf>", @"connection_puzzle_debug" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xaec>", @"hash_33d8d60aefa7ce3" );
        widget_assets = getarraykeys( level.scripted_widgets.widget_types );
        
        foreach ( asset in widget_assets )
        {
            asset_name = getxhashsourcename( asset );
            
            if ( issubstr( asset_name, "<dev string:x37d>" ) && !issubstr( asset_name, "<dev string:xb05>" ) && !issubstr( asset_name, "<dev string:xb0a>" ) && !issubstr( asset_name, "<dev string:xb14>" ) )
            {
                asset_name = removesubstr( asset_name, "<dev string:x793>" );
                params = scripted_widgets::get_params( asset );
                params = arraysort( getarraykeys( params ) );
                
                foreach ( param_name in params )
                {
                    param_name = getxhashsourcename( param_name );
                    devgui::function_cd4e263c1f3018ae( "<dev string:xb1d>" + asset_name + "<dev string:xb23>" + param_name + "<dev string:xb25>", "<dev string:xb30>" + asset_name + "<dev string:xb36>" + param_name + "<dev string:xb36>" + 0, &function_53e2c4b65df08d37, 0 );
                    devgui::function_cd4e263c1f3018ae( "<dev string:xb1d>" + asset_name + "<dev string:xb23>" + param_name + "<dev string:xb38>", "<dev string:xb30>" + asset_name + "<dev string:xb36>" + param_name + "<dev string:xb36>" + 1, &function_53e2c4b65df08d37, 0 );
                }
            }
        }
        
        devgui::add_devgui_func( "<dev string:xb4d>", "<dev string:xb53>", &function_49b194b39d5e5311, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace connection_puzzle
    // Params 0, eflags: 0xc
    // Checksum 0xeda0956d, Offset: 0xb4b8
    // Size: 0x11b, Type: dev
    function private function_c31ed1cd948a0a76()
    {
        self notify( #"hash_683a4a7fd0f7378f" );
        self endon( #"hash_683a4a7fd0f7378f" );
        setdevdvar( @"hash_20973a208000269e", 1 );
        
        while ( getdvar( @"hash_638803a5cb98272a", "<dev string:x6fe>" ) == "<dev string:x6fe>" )
        {
            waitframe();
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.connection_puzzle.participating ) )
            {
                level thread function_920fc16d3334fa94( player.connection_puzzle.participating.asset, player.connection_puzzle.participating.instance );
            }
        }
    }

    // Namespace connection_puzzle
    // Params 1, eflags: 0x4
    // Checksum 0xd76cfda2, Offset: 0xb5db
    // Size: 0x12c, Type: dev
    function private function_53e2c4b65df08d37( params )
    {
        asset = params[ 0 ];
        layout = params[ 1 ];
        randomize = int( params[ 2 ] );
        instance = "<dev string:x15e>";
        time = getdvarint( @"connection_puzzle_timer", -1 );
        level init_from_layout( asset, layout, instance, getdvarint( @"hash_33d8d60aefa7ce3", 1 ) );
        
        if ( time >= 0 )
        {
            function_24bc47a077976162( asset, time, instance );
        }
        
        if ( randomize )
        {
            randomize_rotations( asset, instance );
        }
        
        foreach ( player in level.players )
        {
            player close( 0 );
            wait 0.1;
            player thread open( asset, instance, 0 );
        }
    }

    // Namespace connection_puzzle
    // Params 1, eflags: 0x4
    // Checksum 0x8e869c81, Offset: 0xb70f
    // Size: 0x89, Type: dev
    function private function_49b194b39d5e5311( params )
    {
        foreach ( player in level.players )
        {
            player close( 0 );
        }
    }

#/
