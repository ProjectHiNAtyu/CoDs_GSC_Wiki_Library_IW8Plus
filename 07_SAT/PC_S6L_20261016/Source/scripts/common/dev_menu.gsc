// scripts\common\dev_menu.gsc  (hash_5b1543900ed6dbe1.gscc) (size: 29566 Bytes / 0x737e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x92c1d28d (2462175885)
// size ...... 29566 (0x737e)
// includes .. 3   (offset: 0x6e26)
// strings ... 69  (offset: 0x6e3e)
// dev strs .. 10  (offset: 0x7302)
// exports ... 82  (offset: 0x50e2)
// cseg ...... 0x32f + 0x4db3 (0x50e2)
// imports ... 129 (offset: 0x5db2)
// animtree1 . 0   (offset: 0x737e)
// animtree2 . 0   (offset: 0x737e)
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace dev_menu;

// Namespace dev_menu
// Params 6
// Checksum 0x2f3eb4c9, Offset: 0x34d
// Size: 0x1b6
function init_menus( x_override, y_override, scaleoverride, var_61f14ca047824354, widthoverride, var_77382f50d0ac454b )
{
    utility::flag_init( "debug_menu_ready" );
    level.dev_menu = spawnstruct();
    level.dev_menu.menus = [];
    level.dev_menu.menus[ "current_menu" ] = spawnstruct();
    init_buttons();
    level thread menu_input();
    level thread aspectratio_thread();
    level.dev_menu.var_bd83bcc58e93351b = 8;
    level.dev_menu.var_a87febf4503894f5 = var_77382f50d0ac454b ?? 1;
    level.dev_menu.menu_hud_scale = scaleoverride ?? 1.25;
    level.dev_menu.var_a5b4eb05baa5b467 = x_override ?? 20;
    level.dev_menu.var_a5b4ea05baa5b234 = y_override ?? 300;
    level.dev_menu.var_ab26acca3fe2e7a5 = var_61f14ca047824354 ?? 20;
    level.dev_menu.var_543da8a721e9d4f6 = level.dev_menu.var_a5b4eb05baa5b467 + ( widthoverride ?? 200 ) * level.dev_menu.menu_hud_scale;
    level.dev_menu.var_679388e6324878fb = 20 * level.dev_menu.menu_hud_scale;
    utility::flag_set( "debug_menu_ready" );
}

// Namespace dev_menu
// Params 3
// Checksum 0x68a7f10e, Offset: 0x50b
// Size: 0x92
function add_menu( menu_name, title, can_exit )
{
    if ( menu_exists( menu_name ) )
    {
        println( "<dev string:x24>" + menu_name + "<dev string:x3d>" );
        return;
    }
    
    menu = spawnstruct();
    menu.title = title;
    menu.page = 0;
    menu.can_exit = istrue( can_exit );
    level.dev_menu.menus[ menu_name ] = menu;
}

// Namespace dev_menu
// Params 1
// Checksum 0x2eb52388, Offset: 0x5a5
// Size: 0x23, Type: bool
function menu_exists( menu_name )
{
    return isdefined( level.dev_menu.menus[ menu_name ] );
}

// Namespace dev_menu
// Params 5
// Checksum 0x29bb9ed7, Offset: 0x5d1
// Size: 0xed
function add_menuoptions( menu_name, option_text, func, back_func, starting_value )
{
    menu = level.dev_menu.menus[ menu_name ];
    
    if ( !isdefined( menu.options ) )
    {
        menu.options = [];
        menu.optionsvalue = [];
    }
    
    num = level.dev_menu.menus[ menu_name ].options.size;
    menu.options[ num ] = option_text;
    menu.function[ num ] = func;
    menu.backfunction[ num ] = back_func;
    
    if ( isdefined( starting_value ) )
    {
        menu.optionsvalue[ num ] = starting_value;
    }
}

// Namespace dev_menu
// Params 4
// Checksum 0xf35ce045, Offset: 0x6c6
// Size: 0xe5
function function_33f22470ada60858( menu_name, option_text, func, starting_value )
{
    menu = level.dev_menu.menus[ menu_name ];
    
    if ( !isdefined( menu.options ) )
    {
        menu.options = [];
        menu.optionsvalue = [];
    }
    
    num = level.dev_menu.menus[ menu_name ].options.size;
    menu.options[ num ] = option_text;
    menu.function[ num ] = func;
    menu.hasparams[ num ] = 1;
    
    if ( isdefined( starting_value ) )
    {
        menu.optionsvalue[ num ] = starting_value;
    }
}

// Namespace dev_menu
// Params 4
// Checksum 0x3366e729, Offset: 0x7b3
// Size: 0xbf
function function_ce4aa2d447ea0a9( menu_name, option_text, amount, value )
{
    menu = level.dev_menu.menus[ menu_name ];
    
    if ( !isdefined( menu.options ) )
    {
        menu.options = [];
        menu.optionsvalue = [];
    }
    
    num = menu.options.size;
    menu.options[ num ] = option_text;
    menu.iterator[ num ] = amount;
    
    if ( isdefined( value ) )
    {
        menu.optionsvalue[ num ] = value;
    }
}

// Namespace dev_menu
// Params 2
// Checksum 0xef82c588, Offset: 0x87a
// Size: 0x37
function add_menuent( menu_name, ent )
{
    level.dev_menu.menus[ menu_name ].ent = ent;
}

// Namespace dev_menu
// Params 5
// Checksum 0x5dd68fdc, Offset: 0x8b9
// Size: 0x18a
function add_menu_child( parent_menu, child_menu, child_title, var_2584ab775f862661, func )
{
    if ( !isdefined( level.dev_menu.menus[ child_menu ] ) )
    {
        add_menu( child_menu, child_title );
    }
    
    level.dev_menu.menus[ child_menu ].parent_menu = parent_menu;
    
    if ( !isdefined( level.dev_menu.menus[ parent_menu ].children_menu ) )
    {
        level.dev_menu.menus[ parent_menu ].children_menu = [];
    }
    
    if ( !isdefined( var_2584ab775f862661 ) )
    {
        size = level.dev_menu.menus[ parent_menu ].children_menu.size;
    }
    else
    {
        size = var_2584ab775f862661;
    }
    
    level.dev_menu.menus[ parent_menu ].children_menu[ size ] = child_menu;
    
    if ( isdefined( func ) )
    {
        if ( !isdefined( level.dev_menu.menus[ parent_menu ].children_func ) )
        {
            level.dev_menu.menus[ parent_menu ].children_func = [];
        }
        
        level.dev_menu.menus[ parent_menu ].children_func[ size ] = func;
    }
}

// Namespace dev_menu
// Params 1
// Checksum 0x9145e93e, Offset: 0xa4b
// Size: 0x18f
function enable_menu( menu_name )
{
    disable_menu( "current_menu" );
    
    if ( isdefined( level.dev_menu.menu_cursor ) )
    {
        level.dev_menu.menu_cursor.current_pos = 0;
        menu_cursor_resetpos();
    }
    
    level.dev_menu.menus[ "current_menu" ].title = set_menu_hudelem( level.dev_menu.menus[ menu_name ].title, "title" );
    level.dev_menu.menus[ "current_menu" ].menu_name = menu_name;
    
    if ( isdefined( level.dev_menu.menus[ menu_name ].options ) )
    {
        draw_menu_options( menu_name );
    }
    
    if ( isdefined( level.dev_menu.menus[ menu_name ].ent ) )
    {
        level.dev_menu.menus[ "current_menu" ].ent = level.dev_menu.menus[ menu_name ].ent;
    }
    
    menu_cursor();
    menu_highlight( "current_menu", level.dev_menu.menu_cursor.current_pos );
}

// Namespace dev_menu
// Params 0
// Checksum 0x7ab2dce0, Offset: 0xbe2
// Size: 0x24
function exit_menu()
{
    level notify( #"exit_menu" );
    level.dev_menu.exit_requested = 1;
}

// Namespace dev_menu
// Params 0
// Checksum 0x1a1ac615, Offset: 0xc0e
// Size: 0x2f, Type: bool
function exit_requested()
{
    if ( level.dev_menu.exit_requested )
    {
        level.dev_menu.exit_requested = undefined;
        return true;
    }
    
    return false;
}

// Namespace dev_menu
// Params 1
// Checksum 0x44074a4e, Offset: 0xc46
// Size: 0x406
function draw_menu_options( menu_name )
{
    options = level.dev_menu.menus[ menu_name ].options;
    page = level.dev_menu.menus[ menu_name ].page;
    
    for ( i = 0; i < level.dev_menu.var_ab26acca3fe2e7a5 && i + page * level.dev_menu.var_ab26acca3fe2e7a5 < options.size ; i++ )
    {
        actual_index = i + page * level.dev_menu.var_ab26acca3fe2e7a5;
        text = actual_index + 1 + ". " + options[ actual_index ];
        level.dev_menu.menus[ "current_menu" ].options[ i ] = set_menu_hudelem( text, "options", int( level.dev_menu.var_679388e6324878fb ) * i );
        
        if ( isdefined( level.dev_menu.menus[ menu_name ].optionsvalue[ actual_index ] ) )
        {
            val = level.dev_menu.menus[ menu_name ].optionsvalue[ actual_index ];
            
            if ( level.dev_menu.var_a87febf4503894f5 )
            {
                hud = set_menu_hudelem( val, "value", int( level.dev_menu.var_679388e6324878fb ) * i );
                hud.x += int( level.dev_menu.var_543da8a721e9d4f6 );
                level.dev_menu.menus[ "current_menu" ].optionsvalue[ i ] = hud;
                continue;
            }
            
            stringlength = text.size;
            var_75c4af92c3c70ae0 = stringlength * level.dev_menu.var_bd83bcc58e93351b;
            hud = set_menu_hudelem( val, "value", int( level.dev_menu.var_679388e6324878fb ) * i );
            hud.x += int( level.dev_menu.var_543da8a721e9d4f6 + var_75c4af92c3c70ae0 );
            level.dev_menu.menus[ "current_menu" ].optionsvalue[ i ] = hud;
        }
    }
    
    if ( options.size > level.dev_menu.var_ab26acca3fe2e7a5 )
    {
        text = "";
        
        if ( page > 0 )
        {
            text += "<-- Prev   ";
        }
        
        if ( page < floor( options.size / level.dev_menu.var_ab26acca3fe2e7a5 ) )
        {
            text += "Next -->";
        }
        
        if ( text != "" )
        {
            level.dev_menu.menus[ "current_menu" ].options[ i ] = set_menu_hudelem( text, "options", int( level.dev_menu.var_679388e6324878fb ) * i );
            i++;
        }
    }
    
    if ( level.dev_menu.menus[ menu_name ].can_exit )
    {
        level.dev_menu.menus[ "current_menu" ].options[ i ] = set_menu_hudelem( "Exit", "options", int( level.dev_menu.var_679388e6324878fb ) * i );
    }
}

// Namespace dev_menu
// Params 1
// Checksum 0x381bd628, Offset: 0x1054
// Size: 0x1da
function disable_menu( menu_name )
{
    level notify( #"stop_all_menus" );
    
    if ( menu_name != "current_menu" && isdefined( level.dev_menu.menus[ "current_menu" ].menu_name ) && level.dev_menu.menus[ "current_menu" ].menu_name != menu_name )
    {
        println( "<dev string:x65>" + menu_name + "<dev string:x85>" );
        return;
    }
    
    if ( isdefined( level.dev_menu.menus[ "current_menu" ] ) )
    {
        if ( isdefined( level.dev_menu.menus[ "current_menu" ].title ) )
        {
            level.dev_menu.menus[ "current_menu" ].title scripthud_destroy();
        }
        
        if ( isdefined( level.dev_menu.menus[ "current_menu" ].options ) )
        {
            clear_menu_options( "current_menu" );
        }
    }
    
    level.dev_menu.menus[ "current_menu" ].title = undefined;
    level.dev_menu.menus[ "current_menu" ].menu_name = undefined;
    level.dev_menu.menus[ "current_menu" ].ent = undefined;
    
    if ( isdefined( level.dev_menu.menu_cursor ) )
    {
        level.dev_menu.menu_cursor scripthud_destroy();
        level.dev_menu.menu_cursor = undefined;
    }
}

// Namespace dev_menu
// Params 1
// Checksum 0xa5acddff, Offset: 0x1236
// Size: 0x1cf
function clear_menu_options( menu_name )
{
    options = level.dev_menu.menus[ menu_name ].options;
    
    for ( i = 0; i < options.size ; i++ )
    {
        if ( isdefined( options[ i ].extrahuds ) )
        {
            foreach ( extrahud in options[ i ].extrahuds )
            {
                if ( isdefined( extrahud ) )
                {
                    extrahud scripthud_destroy();
                }
            }
        }
        
        options[ i ] scripthud_destroy();
        
        if ( !isdefined( level.dev_menu.menus[ menu_name ].optionsvalue ) )
        {
            continue;
        }
        
        if ( isdefined( level.dev_menu.menus[ menu_name ].optionsvalue[ i ] ) )
        {
            level.dev_menu.menus[ menu_name ].optionsvalue[ i ] scripthud_destroy();
        }
    }
    
    level.dev_menu.menus[ menu_name ].options = [];
    
    if ( isdefined( level.dev_menu.menus[ menu_name ].optionsvalue ) )
    {
        level.dev_menu.menus[ menu_name ].optionsvalue = [];
    }
}

// Namespace dev_menu
// Params 1
// Checksum 0xd7fa51e8, Offset: 0x140d
// Size: 0x22
function destroy_menu( menu_name )
{
    level.dev_menu.menus[ menu_name ] = undefined;
}

// Namespace dev_menu
// Params 3
// Checksum 0xe4f9c23d, Offset: 0x1437
// Size: 0xb4
function set_menu_hudelem( text, type, y_offset )
{
    x = level.dev_menu.var_a5b4eb05baa5b467;
    y = level.dev_menu.var_a5b4ea05baa5b234;
    
    if ( type == "title" )
    {
        scale = 1.375;
    }
    else
    {
        scale = 1.25;
        y += int( level.dev_menu.var_679388e6324878fb );
    }
    
    if ( !isdefined( y_offset ) )
    {
        y_offset = 0;
    }
    
    y += y_offset;
    return set_scripthud( text, x, y, scale );
}

// Namespace dev_menu
// Params 6
// Checksum 0xac52f316, Offset: 0x14f4
// Size: 0x160
function set_hudelem( text, x, y, scale = 1, alpha = 1, sort = 20 )
{
    hud = newhudelem();
    hud.location = 0;
    hud.alignx = "left";
    hud.aligny = "bottom";
    hud.vertalign = "fullscreen";
    hud.horzalign = "fullscreen";
    hud.foreground = 1;
    hud.fontscale = scale;
    hud.sort = sort;
    hud.alpha = alpha;
    hud.x = x;
    hud.y = y;
    hud.og_scale = scale;
    hud.archived = 0;
    
    if ( isdefined( text ) )
    {
        hud.text = text;
        
        if ( isnumber( text ) )
        {
            hud setvalue( text );
        }
        else
        {
            /#
                hud setdevtext( text );
            #/
            
            hud clearalltextafterhudelem();
        }
    }
    
    return hud;
}

// Namespace dev_menu
// Params 5
// Checksum 0xcaa5b0ef, Offset: 0x165d
// Size: 0x13c
function set_scripthud( text, x, y, scale = 2, alpha )
{
    hud = new_scripthud();
    hud.x = x;
    hud.y = y;
    hud.scale = scale;
    
    if ( isdefined( text ) )
    {
        hud.text = text;
    }
    
    if ( isdefined( alpha ) )
    {
        r = math::lerp( hud.color[ 0 ] * 0.6, hud.color[ 0 ], alpha );
        g = math::lerp( hud.color[ 1 ] * 0.6, hud.color[ 1 ], alpha );
        b = math::lerp( hud.color[ 2 ] * 0.6, hud.color[ 2 ], alpha );
        hud.color = ( r, g, b );
    }
    
    return hud;
}

// Namespace dev_menu
// Params 0
// Checksum 0x544aecd3, Offset: 0x17a2
// Size: 0x8b
function new_scripthud()
{
    struct = spawnstruct();
    struct.x = 0;
    struct.y = 0;
    struct.text = "";
    struct.color = ( 1, 1, 1 );
    struct.scale = 2;
    struct.isscripted = 1;
    struct.alive = 1;
    struct thread scripthud_thread();
    return struct;
}

// Namespace dev_menu
// Params 0
// Checksum 0x40df0a27, Offset: 0x1836
// Size: 0x204
function aspectratio_thread()
{
    level.dev_menu.var_11a74ac418c65cc1 = 1;
    level.dev_menu.var_7c3bc8780023a4a4 = 1;
    level.dev_menu.dvar_r_mode = "-1";
    setdvarifuninitialized( @"dev_menu_scale", -1 );
    
    while ( true )
    {
        if ( is_platform_console() || getdvarint( @"hash_8488fe3c45241d55" ) )
        {
            [ width, height ] = get_r_mode_resolution();
            
            if ( isdefined( width ) )
            {
                if ( !is_platform_console() )
                {
                    window_width = int( max( width, 1920 ) );
                    window_height = int( max( height, 1080 ) );
                }
                else
                {
                    window_width = width;
                    window_height = height;
                }
            }
        }
        else
        {
            window_width = getdvarint( @"vid_width" );
            window_height = getdvarint( @"vid_height" );
        }
        
        vid_width = window_width;
        vid_height = window_height;
        aspectratio = round( getdvarfloat( @"cg_aspectratio" ), 3 );
        windowratio = round( window_width / window_height, 3 );
        
        if ( windowratio != aspectratio )
        {
            if ( windowratio < aspectratio )
            {
                vid_height = int( window_width / aspectratio );
                vid_width = int( vid_height * aspectratio );
            }
            else
            {
                vid_width = int( window_height * aspectratio );
                vid_height = int( vid_width / aspectratio );
            }
        }
        
        scalar = getdvarfloat( @"dev_menu_scale", -1 ) != -1 ? getdvarfloat( @"dev_menu_scale" ) : 1;
        level.dev_menu.var_11a74ac418c65cc1 = vid_width / 1920 * scalar;
        level.dev_menu.var_7c3bc8780023a4a4 = vid_height / 1080 * scalar;
        wait 0.1;
    }
}

// Namespace dev_menu
// Params 0
// Checksum 0x9d763a59, Offset: 0x1a42
// Size: 0x39, Type: bool
function is_platform_console()
{
    return utility::issp() && isplatformconsole() || utility::ismp() && isdefined( level.player ) && level.player isconsoleplayer();
}

// Namespace dev_menu
// Params 0
// Checksum 0x8f6d84ec, Offset: 0x1a84
// Size: 0xae
function get_r_mode_resolution()
{
    res = getdvar( @"r_mode" );
    window_width = undefined;
    window_height = undefined;
    
    if ( level.dev_menu.dvar_r_mode != res )
    {
        level.dev_menu.dvar_r_mode = res;
        toks = strtok( res, "x" );
        
        if ( toks.size < 2 )
        {
            return [ 1920, 1080 ];
        }
        
        window_width = int( toks[ 0 ] );
        window_height = int( toks[ 1 ] );
    }
    
    return [ window_width, window_height ];
}

// Namespace dev_menu
// Params 0
// Checksum 0x8365e585, Offset: 0x1b3b
// Size: 0xa9
function scripthud_thread()
{
    /#
        while ( self.alive )
        {
            if ( isdefined( self.text ) )
            {
                x = level.dev_menu.var_11a74ac418c65cc1 * self.x;
                y = level.dev_menu.var_7c3bc8780023a4a4 * self.y;
                printtoscreen2d( x, y, self.text, self.color, self.scale * level.dev_menu.var_7c3bc8780023a4a4 );
            }
            
            waitframe();
        }
    #/
}

// Namespace dev_menu
// Params 0
// Checksum 0x1f9d83ff, Offset: 0x1bec
// Size: 0x20
function scripthud_destroy()
{
    if ( !self.isscripted )
    {
        self destroy();
        return;
    }
    
    self.alive = 0;
}

// Namespace dev_menu
// Params 2
// Checksum 0xe38bd947, Offset: 0x1c14
// Size: 0xa0
function newscriptcursor( x, y )
{
    struct = spawnstruct();
    struct.x = x;
    struct.y = y;
    struct.text = ">";
    struct.color = ( 1, 0, 0 );
    struct.scale = 2;
    struct.isscripted = 1;
    struct.alive = 1;
    struct thread scripthud_thread();
    return struct;
}

// Namespace dev_menu
// Params 0
// Checksum 0x7a031219, Offset: 0x1cbd
// Size: 0xe40
function menu_input()
{
    self notify( #"hash_a5adc7661ba7555d" );
    self endon( #"hash_a5adc7661ba7555d" );
    
    while ( true )
    {
        level waittill( #"menu_button_pressed", keystring );
        
        if ( level.menu_input_disabled || !isdefined( level.dev_menu.menu_cursor ) || isdefined( level.debug.debug_start ) && level.debug.debug_start )
        {
            wait 0.1;
            continue;
        }
        
        menu_name = level.dev_menu.menus[ "current_menu" ].menu_name;
        
        if ( !( isdefined( menu_name ) && isdefined( level.dev_menu.menus[ menu_name ] ) && isdefined( level.dev_menu.menus[ menu_name ].title ) ) )
        {
            continue;
        }
        
        modifiers[ "shift" ] = 0;
        modifiers[ "ctrl" ] = 0;
        modifiers[ "alt" ] = 0;
        
        if ( keystring == "dpad_up" || keystring == "uparrow" )
        {
            if ( level.dev_menu.menu_cursor.current_pos > 0 )
            {
                level.dev_menu.menu_cursor.y -= int( level.dev_menu.var_679388e6324878fb );
                level.dev_menu.menu_cursor.current_pos--;
            }
            else if ( level.dev_menu.menu_cursor.current_pos == 0 )
            {
                level.dev_menu.menu_cursor.y += ( level.dev_menu.menus[ "current_menu" ].options.size - 1 ) * int( level.dev_menu.var_679388e6324878fb );
                level.dev_menu.menu_cursor.current_pos = level.dev_menu.menus[ "current_menu" ].options.size - 1;
            }
            
            menu_highlight( "current_menu", level.dev_menu.menu_cursor.current_pos );
            wait 0.1;
            continue;
        }
        else if ( keystring == "dpad_down" || keystring == "downarrow" )
        {
            if ( level.dev_menu.menu_cursor.current_pos < level.dev_menu.menus[ "current_menu" ].options.size - 1 )
            {
                level.dev_menu.menu_cursor.y += int( level.dev_menu.var_679388e6324878fb );
                level.dev_menu.menu_cursor.current_pos++;
            }
            else if ( level.dev_menu.menu_cursor.current_pos == level.dev_menu.menus[ "current_menu" ].options.size - 1 )
            {
                level.dev_menu.menu_cursor.y += level.dev_menu.menu_cursor.current_pos * int( level.dev_menu.var_679388e6324878fb ) * -1;
                level.dev_menu.menu_cursor.current_pos = 0;
            }
            
            menu_highlight( "current_menu", level.dev_menu.menu_cursor.current_pos );
            wait 0.1;
            continue;
        }
        else if ( keystring == "button_a" || keystring == "dpad_right" || keystring == "dpad_left" || keystring == "rightarrow" || keystring == "leftarrow" )
        {
            if ( keystring == "dpad_left" || keystring == "leftarrow" )
            {
                modifiers[ "shift" ] = 1;
            }
            
            key = level.dev_menu.menu_cursor.current_pos;
        }
        else if ( keystring == "button_b" )
        {
            exit_menu();
            continue;
        }
        else
        {
            key = int( keystring ) - 1;
        }
        
        if ( level.player buttonpressed( "lshift" ) || level.player buttonpressed( "rshift" ) )
        {
            modifiers[ "shift" ] = 1;
        }
        
        if ( level.dev_menu.menus[ menu_name ].can_exit )
        {
            page_offset = 2;
        }
        else
        {
            page_offset = 1;
        }
        
        if ( key >= level.dev_menu.menus[ "current_menu" ].options.size )
        {
            continue;
        }
        else if ( level.dev_menu.menus[ menu_name ].can_exit && key == level.dev_menu.menus[ "current_menu" ].options.size - 1 )
        {
            exit_menu();
            continue;
        }
        else if ( level.dev_menu.menus[ menu_name ].options.size > level.dev_menu.var_ab26acca3fe2e7a5 && key == level.dev_menu.menus[ "current_menu" ].options.size - page_offset )
        {
            newpage = 0;
            
            if ( modifiers[ "shift" ] && level.dev_menu.menus[ menu_name ].page > 0 )
            {
                level.dev_menu.menus[ menu_name ].page--;
                newpage = 1;
            }
            else if ( !modifiers[ "shift" ] && level.dev_menu.menus[ menu_name ].page < floor( level.dev_menu.menus[ menu_name ].options.size / level.dev_menu.var_ab26acca3fe2e7a5 ) )
            {
                level.dev_menu.menus[ menu_name ].page++;
                newpage = 1;
            }
            
            if ( newpage )
            {
                old_size = level.dev_menu.menus[ "current_menu" ].options.size;
                clear_menu_options( "current_menu" );
                draw_menu_options( menu_name );
                
                if ( level.dev_menu.menus[ "current_menu" ].options.size != old_size )
                {
                    level.dev_menu.menu_cursor.y = level.dev_menu.var_a5b4ea05baa5b234 + ( level.dev_menu.menus[ "current_menu" ].options.size - page_offset + 1 ) * int( level.dev_menu.var_679388e6324878fb );
                    level.dev_menu.menu_cursor.current_pos = level.dev_menu.menus[ "current_menu" ].options.size - page_offset;
                }
            }
            
            continue;
        }
        else
        {
            menu_key = key;
            key += level.dev_menu.menus[ menu_name ].page * level.dev_menu.var_ab26acca3fe2e7a5;
        }
        
        if ( isdefined( level.dev_menu.menus[ menu_name ].parent_menu ) && key == level.dev_menu.menus[ menu_name ].options.size )
        {
            level notify( "disable " + menu_name );
            level enable_menu( level.dev_menu.menus[ menu_name ].parent_menu );
        }
        else if ( isdefined( level.dev_menu.menus[ menu_name ].function[ key ] ) )
        {
            func = undefined;
            toggle_param = undefined;
            
            if ( !modifiers[ "shift" ] )
            {
                func = level.dev_menu.menus[ menu_name ].function[ key ];
                
                if ( level.dev_menu.menus[ menu_name ].hasparams[ key ] )
                {
                    toggle_param = 1;
                }
            }
            else if ( isdefined( level.dev_menu.menus[ menu_name ].backfunction[ key ] ) )
            {
                func = level.dev_menu.menus[ menu_name ].backfunction[ key ];
            }
            else if ( level.dev_menu.menus[ menu_name ].hasparams[ key ] )
            {
                func = level.dev_menu.menus[ menu_name ].function[ key ];
                toggle_param = 0;
            }
            
            if ( isdefined( func ) )
            {
                ent = level;
                
                if ( isdefined( level.dev_menu.menus[ "current_menu" ].ent ) )
                {
                    ent = level.dev_menu.menus[ "current_menu" ].ent;
                }
                
                if ( isdefined( toggle_param ) )
                {
                    msg = ent [[ func ]]( toggle_param );
                }
                else
                {
                    msg = ent [[ func ]]();
                }
                
                if ( isdefined( msg ) )
                {
                    function_7261637f18c9f874( menu_key, msg );
                }
            }
        }
        else if ( isdefined( level.dev_menu.menus[ menu_name ].iterator[ key ] ) )
        {
            if ( !modifiers[ "shift" ] )
            {
                value = level.dev_menu.menus[ menu_name ].optionsvalue[ key ] + level.dev_menu.menus[ menu_name ].iterator[ key ];
            }
            else
            {
                value = level.dev_menu.menus[ menu_name ].optionsvalue[ key ] - level.dev_menu.menus[ menu_name ].iterator[ key ];
            }
            
            function_7261637f18c9f874( menu_key, value );
        }
        
        if ( !isdefined( level.dev_menu.menus[ menu_name ].children_menu ) )
        {
            continue;
        }
        else if ( !isdefined( level.dev_menu.menus[ menu_name ].children_menu[ key ] ) )
        {
            println( "<dev string:x96>" + menu_name + "<dev string:x9a>" + key + "<dev string:xb8>" );
            continue;
        }
        else if ( !isdefined( level.dev_menu.menus[ level.dev_menu.menus[ menu_name ].children_menu[ key ] ] ) )
        {
            println( "<dev string:x96>" + level.dev_menu.menus[ menu_name ].options[ key ] + "<dev string:xc9>" );
            continue;
        }
        
        if ( isdefined( level.dev_menu.menus[ menu_name ].children_func[ key ] ) )
        {
            func = level.dev_menu.menus[ menu_name ].children_func[ key ];
            error_msg = [[ func ]]();
            
            if ( isdefined( error_msg ) )
            {
                level thread selection_error( error_msg, level.dev_menu.menus[ "current_menu" ].options[ menu_key ].x, level.dev_menu.menus[ "current_menu" ].options[ menu_key ].y );
                continue;
            }
        }
        
        level enable_menu( level.dev_menu.menus[ menu_name ].children_menu[ key ] );
        wait 0.1;
    }
}

// Namespace dev_menu
// Params 2
// Checksum 0x4e1afe5d, Offset: 0x2b05
// Size: 0x209
function menu_highlight( menu_name, index )
{
    foreach ( hud in level.dev_menu.menus[ menu_name ].options )
    {
        hud.color = ( 1, 1, 1 );
    }
    
    if ( isdefined( level.dev_menu.menus[ menu_name ].optionsvalue ) )
    {
        foreach ( hud in level.dev_menu.menus[ menu_name ].optionsvalue )
        {
            hud.color = ( 1, 1, 1 );
        }
    }
    
    if ( isdefined( level.dev_menu.menus[ menu_name ].optionsvalue[ index ] ) )
    {
        level.dev_menu.menus[ menu_name ].optionsvalue[ index ].color = ( 1, 1, 0 );
    }
    
    level.dev_menu.menus[ menu_name ].options[ index ].color = ( 1, 1, 0 );
}

// Namespace dev_menu
// Params 2
// Checksum 0xc5c25156, Offset: 0x2d16
// Size: 0x15
function hud_selector( x, y )
{
    
}

// Namespace dev_menu
// Params 1
// Checksum 0xdd6071d1, Offset: 0x2d33
// Size: 0xc
function hud_selector_fade_out( time )
{
    
}

// Namespace dev_menu
// Params 1
// Checksum 0x89e0e532, Offset: 0x2d47
// Size: 0x56
function menu_get_selected_optionsvalue( val = level.dev_menu.menu_cursor.current_pos )
{
    return level.dev_menu.menus[ "current_menu" ].optionsvalue[ val ];
}

// Namespace dev_menu
// Params 2
// Checksum 0xc39d0fe0, Offset: 0x2da6
// Size: 0x103
function function_7261637f18c9f874( optionskey, newvalue )
{
    if ( !isdefined( level.dev_menu.menus[ "current_menu" ].optionsvalue[ optionskey ] ) )
    {
        return;
    }
    
    menu = level.dev_menu.menus[ "current_menu" ];
    menu.optionsvalue[ optionskey ].text = newvalue;
    
    if ( isdefined( menu.optionsvalue[ optionskey ].isscripted ) )
    {
        menu.optionsvalue[ optionskey ].text = newvalue;
        return;
    }
    
    if ( isnumber( newvalue ) )
    {
        menu.optionsvalue[ optionskey ] setvalue( newvalue );
        return;
    }
    
    /#
        menu.optionsvalue[ optionskey ] setdevtext( newvalue );
    #/
    
    menu.optionsvalue[ optionskey ] clearalltextafterhudelem();
}

// Namespace dev_menu
// Params 0
// Checksum 0x53a1214a, Offset: 0x2eb1
// Size: 0x25
function get_current_menu_name()
{
    return level.dev_menu.menus[ "current_menu" ].menu_name;
}

// Namespace dev_menu
// Params 1
// Checksum 0x200427db, Offset: 0x2edf
// Size: 0x56
function menu_get_selected( val = level.dev_menu.menu_cursor.current_pos )
{
    return level.dev_menu.menus[ "current_menu" ].options[ val ];
}

// Namespace dev_menu
// Params 0
// Checksum 0x2e510f77, Offset: 0x2f3e
// Size: 0x5b
function menu_get_selected_text()
{
    val = level.dev_menu.menu_cursor.current_pos;
    return level.dev_menu.menus[ "current_menu" ].options[ val ].text;
}

// Namespace dev_menu
// Params 0
// Checksum 0x1e3a6bde, Offset: 0x2fa2
// Size: 0x1f
function menu_get_selected_index()
{
    return level.dev_menu.menu_cursor.current_pos;
}

// Namespace dev_menu
// Params 3
// Checksum 0xe77ab6ff, Offset: 0x2fca
// Size: 0x130
function selection_error( msg, x, y )
{
    hud = set_hudelem( undefined, x - 10, y, 1 );
    hud setshader( "white", int( level.dev_menu.var_543da8a721e9d4f6 ), 20 );
    hud.color = ( 0.5, 0, 0 );
    hud.alpha = 0.7;
    error_hud = set_hudelem( msg, x + int( level.dev_menu.var_543da8a721e9d4f6 ), y, 1 );
    error_hud.color = ( 1, 0, 0 );
    
    if ( !isdefined( hud.debug_hudelem ) )
    {
        hud fadeovertime( 3 );
    }
    
    hud.alpha = 0;
    
    if ( !isdefined( error_hud.debug_hudelem ) )
    {
        error_hud fadeovertime( 3 );
    }
    
    error_hud.alpha = 0;
    wait 3.1;
    hud destroy();
    error_hud destroy();
}

// Namespace dev_menu
// Params 0
// Checksum 0x6899d591, Offset: 0x3102
// Size: 0x6e
function menu_cursor()
{
    level.dev_menu.menu_cursor = newscriptcursor( 0, level.dev_menu.var_a5b4ea05baa5b234 + int( level.dev_menu.var_679388e6324878fb ) );
    level.dev_menu.menu_cursor.current_pos = 0;
    menu_cursor_resetpos();
}

// Namespace dev_menu
// Params 0
// Checksum 0x6fb0648c, Offset: 0x3178
// Size: 0x6d
function menu_cursor_resetpos()
{
    level.dev_menu.menu_cursor.x = 0;
    level.dev_menu.menu_cursor.y = level.dev_menu.var_a5b4ea05baa5b234 + int( level.dev_menu.var_679388e6324878fb ) + 6;
}

// Namespace dev_menu
// Params 1
// Checksum 0xf700c59e, Offset: 0x31ed
// Size: 0x39
function add_extrahuds( hud )
{
    if ( !isdefined( self.extrahuds ) )
    {
        self.extrahuds = [];
    }
    
    self.extrahuds[ self.extrahuds.size ] = hud;
}

// Namespace dev_menu
// Params 7
// Checksum 0xe2f4953d, Offset: 0x322e
// Size: 0x5ba
function list_menu( list, x, y, func, sort, start_num, x_buffer = 30 )
{
    level endon( #"stop_all_menus" );
    menu = menu_get_selected();
    selected_option = menu_get_selected_optionsvalue();
    
    if ( !isdefined( list ) || list.size == 0 )
    {
        return -1;
    }
    
    if ( !isdefined( x ) && isdefined( selected_option.x ) && isdefined( selected_option.text ) )
    {
        if ( isdefined( selected_option.text.size ) )
        {
            size = selected_option.text.size;
        }
        else
        {
            size = string( selected_option.text ).size;
        }
        
        x = selected_option.x + level.dev_menu.var_bd83bcc58e93351b * size + x_buffer;
    }
    
    if ( !isdefined( y ) && isdefined( selected_option.y ) )
    {
        y = selected_option.y;
    }
    
    hud_array = [];
    space_apart = level.dev_menu.var_679388e6324878fb;
    arrow = set_scripthud( "->", x - 20, y, 1.25, 1 );
    arrow.color = ( 1, 0, 0 );
    menu add_extrahuds( arrow );
    
    if ( utility::issp() )
    {
        max_items = 5;
        y_offset = 2;
    }
    else
    {
        max_items = 3;
        y_offset = 1;
    }
    
    if ( list.size < max_items )
    {
        max_items = list.size;
        y_offset = int( max_items * 0.5 );
    }
    
    for ( i = 0; i < max_items ; i++ )
    {
        if ( i == 0 )
        {
            alpha = 0.3;
        }
        else if ( i == 1 )
        {
            alpha = 0.6;
        }
        else if ( i == 2 )
        {
            alpha = 1;
        }
        else if ( i == 3 )
        {
            alpha = 0.6;
        }
        else
        {
            alpha = 0.3;
        }
        
        hud = set_scripthud( list[ i ], x, y + ( i - y_offset ) * space_apart, 1.25, alpha );
        
        if ( !isdefined( level.tempstruct ) )
        {
            level.tempstruct = [];
        }
        
        level.tempstruct[ level.tempstruct.size ] = hud;
        menu add_extrahuds( hud );
        hud_array[ hud_array.size ] = hud;
    }
    
    current_num = 0;
    old_num = 0;
    selected = 0;
    level.menu_list_selected = 0;
    
    if ( isdefined( start_num ) )
    {
        move_list_menu( hud_array, list, start_num, y_offset );
        current_num = start_num;
        old_num = start_num;
    }
    else
    {
        move_list_menu( hud_array, list, 0, y_offset );
    }
    
    if ( isdefined( func ) )
    {
        [[ func ]]( list[ current_num ] );
    }
    
    while ( true )
    {
        level waittill( #"menu_button_pressed", key );
        
        if ( !isdefined( level.dev_menu.menu_cursor ) )
        {
            selected = 0;
            break;
        }
        
        level.menu_list_selected = 1;
        
        if ( any_button_hit( key, "numbers" ) )
        {
            break;
        }
        else if ( key == "downarrow" || key == "dpad_down" )
        {
            if ( current_num >= list.size - 1 )
            {
                current_num = 0;
                move_list_menu( hud_array, list, current_num, y_offset );
                continue;
            }
            
            current_num++;
            move_list_menu( hud_array, list, current_num, y_offset );
        }
        else if ( key == "uparrow" || key == "dpad_up" )
        {
            if ( current_num <= 0 )
            {
                current_num = list.size - 1;
                move_list_menu( hud_array, list, current_num, y_offset );
                continue;
            }
            
            current_num--;
            move_list_menu( hud_array, list, current_num, y_offset );
        }
        else if ( key == "pgup" )
        {
            if ( current_num <= 0 )
            {
                current_num = list.size - 1;
                move_list_menu( hud_array, list, current_num, y_offset );
                continue;
            }
            
            current_num -= 5;
            current_num = clamp( current_num, 0, list.size - 1 );
            current_num = int( current_num );
            move_list_menu( hud_array, list, current_num, y_offset );
        }
        else if ( key == "pgdn" )
        {
            if ( current_num >= list.size - 1 )
            {
                current_num = 0;
                move_list_menu( hud_array, list, current_num, y_offset );
                continue;
            }
            
            current_num += 5;
            current_num = clamp( current_num, 0, list.size - 1 );
            current_num = int( current_num );
            move_list_menu( hud_array, list, current_num, y_offset );
        }
        else if ( key == "enter" || key == "button_a" || key == "dpad_right" || key == "rightarrow" )
        {
            selected = 1;
            break;
        }
        else if ( key == "end" || key == "button_b" || key == "dpad_left" || key == "leftarrow" )
        {
            selected = 0;
            break;
        }
        
        level notify( #"scroll_list" );
        
        if ( current_num != old_num )
        {
            old_num = current_num;
            
            if ( isdefined( func ) )
            {
                [[ func ]]( list[ current_num ] );
            }
        }
        
        wait 0.1;
    }
    
    if ( arrow.isscripted )
    {
        arrow scripthud_destroy();
    }
    else
    {
        arrow destroy();
    }
    
    for ( i = 0; i < hud_array.size ; i++ )
    {
        if ( hud_array[ i ].isscripted )
        {
            hud_array[ i ] scripthud_destroy();
            continue;
        }
        
        hud_array[ i ] destroy();
    }
    
    if ( selected )
    {
        return current_num;
    }
}

// Namespace dev_menu
// Params 4
// Checksum 0x3a031d0c, Offset: 0x37f0
// Size: 0xd8
function move_list_menu( hud_array, list, num, y_offset )
{
    for ( i = 0; i < hud_array.size ; i++ )
    {
        index = i + num - y_offset;
        
        if ( isdefined( list[ index ] ) )
        {
            text = list[ index ];
        }
        else if ( index < 0 )
        {
            text = list[ list.size + index ];
        }
        else
        {
            text = list[ index % list.size ];
        }
        
        hud_array[ i ].archived = 0;
        
        if ( isdefined( hud_array[ i ].isscripted ) )
        {
            hud_array[ i ].text = text;
            continue;
        }
        
        /#
            hud_array[ i ] setdevtext( string( text ) );
        #/
        
        hud_array[ i ] clearalltextafterhudelem();
    }
}

// Namespace dev_menu
// Params 2
// Checksum 0xf8c2ea2e, Offset: 0x38d0
// Size: 0x64
function add_universal_button( button_group, name )
{
    if ( !isdefined( level.u_buttons[ button_group ] ) )
    {
        level.u_buttons[ button_group ] = [];
    }
    
    if ( array_check_for_dupes( level.u_buttons[ button_group ], name ) )
    {
        level.u_buttons[ button_group ][ level.u_buttons[ button_group ].size ] = name;
    }
}

// Namespace dev_menu
// Params 2
// Checksum 0x3e4d470b, Offset: 0x393c
// Size: 0x3e, Type: bool
function array_check_for_dupes( array, single )
{
    for ( i = 0; i < array.size ; i++ )
    {
        if ( array[ i ] == single )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace dev_menu
// Params 1
// Checksum 0x4b6d6d92, Offset: 0x3983
// Size: 0x1a
function clear_universal_buttons( button_group )
{
    level.u_buttons[ button_group ] = [];
}

// Namespace dev_menu
// Params 5
// Checksum 0xc29485c7, Offset: 0x39a5
// Size: 0x149
function universal_input_loop( button_group, end_on, use_attackbutton, mod_button, no_mod_button )
{
    while ( !isdefined( level.player ) )
    {
        waitframe();
    }
    
    level endon( end_on );
    
    if ( !isdefined( use_attackbutton ) )
    {
        use_attackbutton = 0;
    }
    
    notify_name = button_group + "_button_pressed";
    buttons = level.u_buttons[ button_group ];
    level.u_buttons_disable[ button_group ] = 0;
    
    while ( true )
    {
        if ( level.u_buttons_disable[ button_group ] )
        {
            waitframe();
            continue;
        }
        
        if ( isdefined( mod_button ) && !level.player buttonpressed( mod_button ) )
        {
            waitframe();
            continue;
        }
        else if ( isdefined( no_mod_button ) && level.player buttonpressed( no_mod_button ) )
        {
            waitframe();
            continue;
        }
        
        if ( use_attackbutton && level.player attackbuttonpressed() )
        {
            level notify( notify_name, "fire" );
            wait 0.1;
            continue;
        }
        
        for ( i = 0; i < buttons.size ; i++ )
        {
            if ( level.player buttonpressed( buttons[ i ] ) )
            {
                level notify( notify_name, buttons[ i ] );
                wait 0.1;
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace dev_menu
// Params 2
// Checksum 0x7d36d5e9, Offset: 0x3af6
// Size: 0xc4, Type: bool
function any_button_hit( button_hit, type )
{
    buttons = [];
    
    if ( type == "numbers" )
    {
        buttons[ 0 ] = "0";
        buttons[ 1 ] = "1";
        buttons[ 2 ] = "2";
        buttons[ 3 ] = "3";
        buttons[ 4 ] = "4";
        buttons[ 5 ] = "5";
        buttons[ 6 ] = "6";
        buttons[ 7 ] = "7";
        buttons[ 8 ] = "8";
        buttons[ 9 ] = "9";
    }
    else
    {
        buttons = level.buttons;
    }
    
    for ( i = 0; i < buttons.size ; i++ )
    {
        if ( button_hit == buttons[ i ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace dev_menu
// Params 0
// Checksum 0x5f85bbaa, Offset: 0x3bc3
// Size: 0xd1
function init_buttons()
{
    clear_universal_buttons( "menu" );
    add_universal_button( "menu", "dpad_up" );
    add_universal_button( "menu", "dpad_down" );
    add_universal_button( "menu", "dpad_left" );
    add_universal_button( "menu", "dpad_right" );
    add_universal_button( "menu", "button_b" );
    add_universal_button( "menu", "downarrow" );
    add_universal_button( "menu", "uparrow" );
    add_universal_button( "menu", "leftarrow" );
    add_universal_button( "menu", "rightarrow" );
    add_universal_button( "menu", "enter" );
    level thread universal_input_loop( "menu", "never", undefined, undefined, "button_ltrig" );
}

// Namespace dev_menu
// Params 0
// Checksum 0x64a3309a, Offset: 0x3c9c
// Size: 0x45, Type: bool
function can_exit()
{
    if ( isdefined( level.dev_menu.exit_requested ) )
    {
        level.dev_menu.exit_requested = undefined;
        return true;
    }
    
    if ( isai( self ) && !isalive( self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace dev_menu
// Params 0
// Checksum 0x6bb08392, Offset: 0x3cea
// Size: 0x10
function init_selection_and_cursor()
{
    thread input_loop();
    thread cursor();
}

// Namespace dev_menu
// Params 0
// Checksum 0x1994b972, Offset: 0x3d02
// Size: 0x15d
function input_loop()
{
    var_41e7ee7ed49c8dfb = 0;
    
    if ( !isdefined( level.g_nextusepress ) )
    {
        level.g_nextusepress = 0;
    }
    
    while ( true )
    {
        if ( gettime() > level.g_nextusepress && level.player usebuttonpressed() || isdefined( level.force_select_ent ) )
        {
            if ( isdefined( level.force_select_ent ) )
            {
                level.highlighted_ent = level.force_select_ent;
            }
            
            level.g_nextusepress = gettime() + 400;
            
            if ( isdefined( level.highlighted_ent ) )
            {
                if ( isdefined( level.highlighted_ent.usefunc ) )
                {
                    level.highlighted_ent thread [[ level.highlighted_ent.usefunc ]]();
                }
                
                if ( isdefined( level.highlighted_ent.onselect ) )
                {
                    level.highlighted_ent [[ level.highlighted_ent.onselect ]]();
                }
                else if ( isdefined( level.highlighted_ent.select_func ) )
                {
                    level.highlighted_ent [[ level.highlighted_ent.select_func ]]();
                }
            }
            
            if ( isdefined( level.force_select_ent ) )
            {
                level.force_select_ent = undefined;
            }
            
            wait 0.2;
        }
        
        waitframe();
    }
}

// Namespace dev_menu
// Params 0
// Checksum 0xc0e6a168, Offset: 0x3e67
// Size: 0xcd
function deselect()
{
    if ( !isdefined( level.selected ) )
    {
        return;
    }
    
    if ( isdefined( level.selectedhint ) )
    {
        level.selectedhint destroy();
    }
    
    level notify( #"deselect" );
    level.selected.selected = 0;
    level.selected notify( #"deselect" );
    
    if ( !isnode( level.selected ) )
    {
        level.selected hudoutlinedisable();
    }
    
    level.selected = undefined;
    setsaveddvar( @"r_hudoutlinewidth", 2 );
    
    if ( isdefined( level.followcam_enabled ) && isdefined( level.func[ "followcam" ] ) )
    {
        [[ level.func[ "followcam" ] ]]( 0 );
    }
}

// Namespace dev_menu
// Params 1
// Checksum 0xd395a39e, Offset: 0x3f3c
// Size: 0x2f
function force_select( ent )
{
    assert( !isdefined( level.force_select_ent ), "<dev string:xe3>" );
    level.force_select_ent = ent;
}

// Namespace dev_menu
// Params 1
// Checksum 0xa360bc24, Offset: 0x3f73
// Size: 0xc7
function select( ent )
{
    deselect();
    ent endon( #"death" );
    
    if ( isnode( ent ) )
    {
        ent notify( #"stop_highlight" );
        ent thread draw_box_forever( ent.origin + ( 0, 0, 16 ), 32, ( 0.2, 1, 0.2 ), ent.angles, 32, "deselect" );
    }
    else
    {
        ent hudoutlineenable( "outline_nodepth_cyan" );
        setsaveddvar( @"r_hudoutlinewidth", 2 );
    }
    
    ent.selected = 1;
    level.selected = ent;
    wait 1;
    
    if ( isnode( ent ) )
    {
        return;
    }
    
    ent hudoutlinedisable();
}

// Namespace dev_menu
// Params 1
// Checksum 0x5f6e88f6, Offset: 0x4042
// Size: 0x36
function add_selectable( ent )
{
    if ( !arraycontains( level.selectable_ents, ent ) )
    {
        level.selectable_ents[ level.selectable_ents.size ] = ent;
    }
}

// Namespace dev_menu
// Params 1
// Checksum 0x82c20001, Offset: 0x4080
// Size: 0x42
function add_selectable_node( node )
{
    node thread print_nodetype();
    
    if ( !isdefined( level.selectable_nodes ) )
    {
        level.selectable_nodes = [];
    }
    
    level.selectable_nodes[ level.selectable_nodes.size ] = node;
}

// Namespace dev_menu
// Params 1
// Checksum 0x9b95543c, Offset: 0x40ca
// Size: 0x7e
function add_selectable_nodes( nodes )
{
    foreach ( node in nodes )
    {
        add_selectable_node( node );
    }
}

// Namespace dev_menu
// Params 0
// Checksum 0xd885b780, Offset: 0x4150
// Size: 0xed
function print_nodetype()
{
    /#
        lines = spawnflags_text_array();
        
        while ( true )
        {
            wait 0.05;
            print3d( self.origin, self.type, ( 1, 1, 1 ), 0.8, 0.5 );
            
            foreach ( i, l in lines )
            {
                print3d( self.origin + ( 0, 0, ( i + 1 ) * -4 ), l, ( 1, 1, 1 ), 0.6, 0.25 );
            }
        }
    #/
}

// Namespace dev_menu
// Params 0
// Checksum 0x37f9d75, Offset: 0x4245
// Size: 0xe1
function spawnflags_text_array()
{
    lines = [];
    
    if ( self.spawnflags & 1 )
    {
        lines[ lines.size ] = "DONT_LINK";
    }
    
    if ( self.spawnflags & 2 )
    {
        lines[ lines.size ] = "IN_OUT_TRANSITION";
    }
    
    if ( self.spawnflags & 4 )
    {
        lines[ lines.size ] = "DONT_STAND";
    }
    
    if ( self.spawnflags & 8 )
    {
        lines[ lines.size ] = "DONT_CROUCH";
    }
    
    if ( self.spawnflags & 16 )
    {
        lines[ lines.size ] = "DONT_PRONE";
    }
    
    if ( self.spawnflags & 32 )
    {
        lines[ lines.size ] = "CHOKE_POINT";
    }
    
    if ( self.spawnflags & 64 )
    {
        lines[ lines.size ] = "PRIORITY";
    }
    
    if ( self.spawnflags & 128 )
    {
        lines[ lines.size ] = "IDLE";
    }
    
    return lines;
}

// Namespace dev_menu
// Params 1
// Checksum 0xbdd2692f, Offset: 0x432f
// Size: 0x24
function remove_selectable_node( node )
{
    level.selectable_nodes = arrayremove( level.selectable_nodes, node );
}

// Namespace dev_menu
// Params 1
// Checksum 0xa35491da, Offset: 0x435b
// Size: 0x24
function remove_selectable( ent )
{
    level.selectable_ents = arrayremove( level.selectable_ents, ent );
}

// Namespace dev_menu
// Params 0
// Checksum 0x32cb33a7, Offset: 0x4387
// Size: 0x18
function cleanup_selectable()
{
    level.selectable_ents = function_5713d46873b29625( level.selectable_ents );
}

// Namespace dev_menu
// Params 0
// Checksum 0x1ec20cc8, Offset: 0x43a7
// Size: 0x51
function cursor()
{
    level.selectable_ents = [];
    level.cursor_pos = ( 0, 0, 0 );
    init_crosshair();
    level notify( #"stop_cursor" );
    level endon( #"stop_cursor" );
    
    while ( true )
    {
        cursor_highlight();
        waitframe();
    }
}

// Namespace dev_menu
// Params 0
// Checksum 0x73fde00c, Offset: 0x4400
// Size: 0x1b5
function cursor_highlight()
{
    start = level.player geteye();
    forward = anglestoforward( level.player getplayerangles() );
    start += forward * 30;
    end = start + forward * 10000;
    trace = trace::ray_trace_detail( start, end );
    phys_trace = trace[ "position" ];
    highlighted_ent = undefined;
    highlighted_node = undefined;
    highlighted_path = undefined;
    highlighted_path_point = undefined;
    
    if ( level.var_370a945b9d228278 )
    {
        if ( isdefined( level.selectedpath ) )
        {
            draw_highlight_path( level.selectedpath );
        }
    }
    
    if ( level.var_912d475630eda396 )
    {
        highlighted_node = get_selectable_node( start, end, 40 );
        
        if ( !isdefined( highlighted_node ) )
        {
            highlighted_ent = get_selectable_ent( start, end, 40 );
        }
    }
    else
    {
        highlighted_ent = get_selectable_ent( start, end, 40 );
        
        if ( !isdefined( highlighted_ent ) )
        {
            highlighted_node = get_selectable_node( start, end, 40 );
        }
    }
    
    level.highlighted_node = highlighted_node;
    
    if ( isdefined( highlighted_ent ) )
    {
        draw_highlight( highlighted_ent );
        level.highlighted_ent = highlighted_ent;
        return;
    }
    
    if ( isdefined( highlighted_node ) )
    {
        stop_previous_highlight();
        level.highlighted_ent = undefined;
        draw_highlight_node( highlighted_node );
        level.highlighted_node = highlighted_node;
        return;
    }
    
    if ( distance( trace[ "position" ], phys_trace ) < 0.1 )
    {
        if ( is_place_clear( phys_trace ) )
        {
            level.cursor_pos = phys_trace;
        }
    }
    
    draw_axis();
    stop_previous_highlight();
    level.highlighted_ent = undefined;
}

// Namespace dev_menu
// Params 3
// Checksum 0xb6eb62e0, Offset: 0x45bd
// Size: 0x41
function get_selectable_ent( start, end, max_dist )
{
    cleanup_selectable();
    return get_selectable_from_array( level.selectable_ents, level.selected_node, start, end, max_dist );
}

// Namespace dev_menu
// Params 3
// Checksum 0xe8e6d78, Offset: 0x4607
// Size: 0x3a
function get_selectable_node( start, end, max_dist )
{
    return get_selectable_from_array( level.selectable_nodes, level.selected_node, start, end, max_dist );
}

// Namespace dev_menu
// Params 5
// Checksum 0xbb06ff75, Offset: 0x464a
// Size: 0x130
function get_selectable_from_array( array, currselected, start, end, max_dist )
{
    max_dist = squared( max_dist );
    dist = max_dist;
    selected = undefined;
    
    foreach ( ent in array )
    {
        origin = ent.origin;
        
        if ( isent( ent ) && isai( ent ) )
        {
            origin += ( 0, 0, 40 );
        }
        
        if ( currselected == ent )
        {
            continue;
        }
        
        point = pointonsegmentnearesttopoint( start, end, origin );
        d = distancesquared( point, origin );
        
        if ( d < dist )
        {
            dist = d;
            selected = ent;
        }
    }
    
    return selected;
}

// Namespace dev_menu
// Params 1
// Checksum 0xad4368e8, Offset: 0x4783
// Size: 0x11b
function draw_highlight( ent )
{
    range = 4;
    color = ( 1, 1, 0.5 );
    depth = 1;
    duration = 1;
    
    if ( isdefined( ent.is_spawner ) )
    {
        stop_previous_highlight();
        draw_spawner( ent.origin, ent.angles, color );
        return;
    }
    
    if ( !isdefined( level.selected ) && level.highlighted_ent != ent )
    {
        stop_previous_highlight();
        
        if ( isdefined( ent.onhighlight ) )
        {
            ent thread [[ ent.onhighlight ]]();
        }
        
        if ( isnode( ent ) )
        {
            ent thread draw_box_forever( ent.origin + ( 0, 0, 16 ), 32, ( 1, 1, 0 ), ent.angles, 32 );
            return;
        }
        
        ent hudoutlineenable( "outline_nodepth_orange" );
    }
}

// Namespace dev_menu
// Params 1
// Checksum 0x8c4b8a9c, Offset: 0x48a6
// Size: 0x6a
function draw_highlight_node( node )
{
    stop_previous_highlight();
    
    if ( isdefined( node.color_override ) )
    {
        color = node.color_override;
    }
    else
    {
        color = ( 1, 1, 0.5 );
    }
    
    draw_node( node.origin, node.angles, color );
}

// Namespace dev_menu
// Params 1
// Checksum 0x94c96233, Offset: 0x4918
// Size: 0xcb
function draw_highlight_path( pathname )
{
    /#
        path = function_9a6ce6983cb7d485( pathname );
        
        for ( i = 0; i < path.points.size ; i++ )
        {
            point = path.points[ i ];
            draw_path_point( point.origin, point.angles );
            
            if ( i == path.points.size - 2 )
            {
                continue;
            }
            
            line( point.origin, path.points[ i + 1 ].origin, ( 1, 1, 1 ) );
        }
    #/
}

// Namespace dev_menu
// Params 1
// Checksum 0x6ad1fd40, Offset: 0x49eb
// Size: 0x18
function function_9a6ce6983cb7d485( str )
{
    return level.ai_paths[ str ];
}

// Namespace dev_menu
// Params 0
// Checksum 0xd7a2621c, Offset: 0x4a0c
// Size: 0x5b
function stop_previous_highlight()
{
    if ( !isdefined( level.highlighted_ent ) )
    {
        return;
    }
    
    level.highlighted_ent notify( #"stop_highlight" );
    
    if ( isnode( level.highlighted_ent ) )
    {
        return;
    }
    
    if ( level.selected == level.highlighted_ent )
    {
        return;
    }
    
    level.highlighted_ent hudoutlinedisable();
}

// Namespace dev_menu
// Params 3
// Checksum 0xa81d1326, Offset: 0x4a6f
// Size: 0x70
function draw_spawner( pos, angles, color )
{
    /#
        end = pos + anglestoforward( angles ) * 20;
        _draw_arrow( pos + ( 0, 0, 36 ), end + ( 0, 0, 36 ), color );
        draw_box( pos, undefined, color, angles, 72 );
    #/
}

// Namespace dev_menu
// Params 3
// Checksum 0x348e66cf, Offset: 0x4ae7
// Size: 0x7c
function draw_node( pos, angles, color )
{
    /#
        end = pos + anglestoforward( angles ) * 20;
        _draw_arrow( pos + ( 0, 0, 16 ), end + ( 0, 0, 16 ), color );
        draw_box( pos + ( 0, 0, 16 ), undefined, color, angles );
    #/
}

/#

    // Namespace dev_menu
    // Params 2
    // Checksum 0xa3994cd4, Offset: 0x4b6b
    // Size: 0x7d, Type: dev
    function draw_path_point( pos, angles )
    {
        end = pos + anglestoforward( angles ) * 8;
        _draw_arrow( pos + ( 0, 0, 5 ), end + ( 0, 0, 5 ), ( 0.2, 0.2, 0.9 ) );
        draw_box( pos, undefined, ( 0.9, 0.1, 0.1 ), angles );
    }

#/

// Namespace dev_menu
// Params 1
// Checksum 0x90381792, Offset: 0x4bf0
// Size: 0x1f
function function_98bb613f3ebdd0e9( delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    self.color_override = undefined;
}

/#

    // Namespace dev_menu
    // Params 3
    // Checksum 0x6ba0367e, Offset: 0x4c17
    // Size: 0xfb, Type: dev
    function _draw_arrow( start, end, color )
    {
        angle = vectortoangles( end - start );
        dist = length( end - start );
        forward = anglestoforward( angle );
        forwardfar = forward * dist;
        arrow_size = 5;
        forwardclose = forward * ( dist - arrow_size );
        right = anglestoright( angle );
        leftdraw = right * arrow_size * -1;
        rightdraw = right * arrow_size;
        line( start, end, color, 1, 0, 1 );
        line( start, start + forwardfar, color, 1, 0, 1 );
        line( start + forwardfar, start + forwardclose + rightdraw, color, 1, 0, 1 );
        line( start + forwardfar, start + forwardclose + leftdraw, color, 1, 0, 1 );
    }

#/

// Namespace dev_menu
// Params 6
// Checksum 0x4d4e660a, Offset: 0x4d1a
// Size: 0x6d
function draw_box_forever( pos, width, color, angles, height, end_on )
{
    /#
        if ( isdefined( end_on ) )
        {
            self endon( end_on );
        }
        else
        {
            self endon( #"stop_highlight" );
        }
        
        while ( true )
        {
            draw_box( pos, width, color, angles, height );
            waitframe();
        }
    #/
}

/#

    // Namespace dev_menu
    // Params 5
    // Checksum 0x652bd20b, Offset: 0x4d8f
    // Size: 0x89, Type: dev
    function draw_box( pos, width, color, angles, height )
    {
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( width ) )
        {
            width = 32;
        }
        
        if ( !isdefined( height ) )
        {
            height = 32;
        }
        
        forward = anglestoforward( angles );
        line( pos, pos + forward * 24, color );
        orientedbox( pos, ( width, width, height ), angles, color );
    }

#/

// Namespace dev_menu
// Params 0
// Checksum 0x60ca4631, Offset: 0x4e20
// Size: 0x56
function draw_axis()
{
    /#
        size = 5;
        pos = level.cursor_pos;
        color = 1;
        depth = 1;
        debugaxis( pos, ( 0, 0, 0 ), size, color, depth );
    #/
}

// Namespace dev_menu
// Params 0
// Checksum 0x96b4f45e, Offset: 0x4e7e
// Size: 0xbd
function init_crosshair()
{
    if ( !utility::issp() )
    {
        return;
    }
    
    crosshair = newhudelem();
    crosshair.location = 0;
    crosshair.alignx = "center";
    crosshair.aligny = "middle";
    crosshair.foreground = 1;
    crosshair.fontscale = 1;
    crosshair.sort = 20;
    crosshair.alpha = 1;
    crosshair.x = 320;
    crosshair.y = 237;
    crosshair.archived = 0;
    
    /#
        crosshair setdevtext( "<dev string:x12e>" );
    #/
}

// Namespace dev_menu
// Params 1
// Checksum 0xd5fcc03e, Offset: 0x4f43
// Size: 0x19e, Type: bool
function is_place_clear( org )
{
    debug_lines = getdvarint( @"ai_place" );
    steps = 6;
    chunks = 360 / steps;
    dist_check = squared( 0.1 );
    
    for ( i = 0; i < steps ; i++ )
    {
        angles = ( -30, i * chunks, 0 );
        forward = anglestoforward( angles );
        endpos = org + forward * 30;
        trace = trace::ray_trace( org, endpos, undefined, trace::create_solid_ai_contents( 1 ) );
        pos = trace[ "position" ];
        dist = distancesquared( pos, endpos );
        
        if ( dist > dist_check )
        {
            /#
                if ( debug_lines )
                {
                    line( org, endpos, ( 1, 0, 0 ) );
                }
            #/
            
            return false;
        }
        
        /#
            if ( debug_lines )
            {
                line( org, endpos, ( 0, 1, 0 ) );
            }
        #/
        
        trace = trace::ray_trace( endpos + ( 0, 0, 42 ), endpos, undefined, trace::create_solid_ai_contents( 1 ) );
        pos = trace[ "position" ];
        
        if ( dist > dist_check )
        {
            /#
                if ( debug_lines )
                {
                    line( pos, endpos, ( 1, 0, 0 ) );
                }
            #/
            
            return false;
        }
        
        /#
            if ( debug_lines )
            {
                line( endpos + ( 0, 0, 42 ), endpos, ( 0, 1, 0 ) );
            }
        #/
    }
    
    return true;
}

