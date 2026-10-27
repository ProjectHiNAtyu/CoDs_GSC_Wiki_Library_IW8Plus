// scripts\common\widgets_visibility.gsc  (hash_24f7ed44210ca8cc.gscc) (size: 2355 Bytes / 0x933 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74e8261c (1961371164)
// size ...... 2355 (0x933)
// includes .. 1   (offset: 0x8c3)
// strings ... 3   (offset: 0x8cb)
// dev strs .. 4   (offset: 0x8ff)
// exports ... 6   (offset: 0x617)
// cseg ...... 0xb1 + 0x566 (0x617)
// imports ... 15  (offset: 0x707)
// animtree1 . 0   (offset: 0x933)
// animtree2 . 0   (offset: 0x933)
#using scripts\common\utility;

#namespace widgets_visibility;

// Namespace widgets_visibility/event_2edad73f7f06ca63
// Params 0, eflags: 0x24
// Checksum 0xf928ee2f, Offset: 0xcf
// Size: 0x1f
function private event_handler[event_2edad73f7f06ca63] function_7c413ee8cd42172()
{
    if ( !isdefined( level.widgets_visibility ) )
    {
        level.widgets_visibility = {};
    }
    
    init();
}

// Namespace widgets_visibility
// Params 0, eflags: 0x4
// Checksum 0x180088bf, Offset: 0xf6
// Size: 0x15b
function private init()
{
    game_mode_bundle = getgamemodescriptbundle();
    
    if ( !isdefined( level.widgets_visibility ) )
    {
        level.widgets_visibility = {};
    }
    
    data = level.widgets_visibility;
    data.omnvar = game_mode_bundle.var_1fff3d4cd3896d04;
    data.widgetsets = [];
    
    if ( isdefined( game_mode_bundle.hidewidgets ) )
    {
        hide_widgets = getscriptbundle( game_mode_bundle.hidewidgets );
        
        if ( isdefined( hide_widgets ) && isdefined( hide_widgets.widgetsets ) )
        {
            foreach ( index, widgetset in hide_widgets.widgetsets )
            {
                if ( isdefined( widgetset.name ) && widgetset.name != #"" )
                {
                    data.widgetsets[ widgetset.name ] = index;
                }
            }
        }
    }
    
    level utility::flag_set( "widgets_visibility_initialized" );
}

// Namespace widgets_visibility
// Params 4
// Checksum 0xa5799746, Offset: 0x259
// Size: 0x20f
function hide( ref, widgetsets, shouldhide = 1, suppressasserts )
{
    self notify( "widget_visibility_hide_" + ref );
    
    if ( !level utility::flag( "widgets_visibility_initialized" ) )
    {
        self endon( "widget_visibility_hide_" + ref );
        self endon( "widget_visibility_reset_" + ref );
        self endon( #"death_or_disconnect" );
        level utility::flag_wait( "widgets_visibility_initialized" );
    }
    
    if ( !suppressasserts )
    {
        assert( isdefined( level.widgets_visibility ), "<dev string:x24>" );
        assert( isdefined( level.widgets_visibility.widgetsets ), "<dev string:x24>" );
        assert( isdefined( level.widgets_visibility.omnvar ), "<dev string:x70>" );
    }
    else if ( !isdefined( level.widgets_visibility.omnvar ) )
    {
        return;
    }
    
    data = level.widgets_visibility;
    
    if ( !isarray( widgetsets ) )
    {
        widgetsets = [ widgetsets ];
    }
    
    foreach ( widgetset in widgetsets )
    {
        if ( !isxhash( widgetset ) )
        {
            widgetset = getxhash( widgetset );
        }
        
        if ( suppressasserts )
        {
            if ( !isdefined( data.widgetsets[ widgetset ] ) )
            {
                continue;
            }
        }
        else
        {
            assert( isdefined( data.widgetsets[ widgetset ] ), "<dev string:xd3>" + getxhashsourcename( widgetset ) + "<dev string:xf5>" );
        }
        
        shouldhide = should_hide_set( ref, widgetset, shouldhide );
        self function_47457b9ec007482e( data.omnvar, data.widgetsets[ widgetset ], 1, shouldhide );
    }
}

// Namespace widgets_visibility
// Params 1
// Checksum 0xccfccbd2, Offset: 0x470
// Size: 0x117
function reset( ref )
{
    self notify( "widget_visibility_reset_" + ref );
    
    if ( isdefined( self.var_78d2053a29ba2040 ) )
    {
        data = level.widgets_visibility;
        keys = getarraykeys( self.var_78d2053a29ba2040 );
        
        foreach ( widgetsetkey in keys )
        {
            if ( isdefined( self.var_78d2053a29ba2040[ widgetsetkey ][ ref ] ) )
            {
                self.var_78d2053a29ba2040[ widgetsetkey ][ ref ] = undefined;
                
                if ( self.var_78d2053a29ba2040[ widgetsetkey ].size == 0 )
                {
                    self.var_78d2053a29ba2040[ widgetsetkey ] = undefined;
                    self function_47457b9ec007482e( data.omnvar, data.widgetsets[ widgetsetkey ], 1, 0 );
                }
            }
        }
    }
}

// Namespace widgets_visibility
// Params 3, eflags: 0x4
// Checksum 0x854b18ac, Offset: 0x58f
// Size: 0x87, Type: bool
function private should_hide_set( ref, widgetset, shouldhide )
{
    if ( !isdefined( self.var_78d2053a29ba2040 ) )
    {
        self.var_78d2053a29ba2040 = [];
    }
    
    if ( !isdefined( self.var_78d2053a29ba2040[ widgetset ] ) )
    {
        self.var_78d2053a29ba2040[ widgetset ] = [];
    }
    
    if ( shouldhide )
    {
        self.var_78d2053a29ba2040[ widgetset ][ ref ] = 1;
    }
    else
    {
        self.var_78d2053a29ba2040[ widgetset ][ ref ] = undefined;
    }
    
    return self.var_78d2053a29ba2040[ widgetset ].size > 0;
}

