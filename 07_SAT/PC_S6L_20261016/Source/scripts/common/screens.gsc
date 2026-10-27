// scripts\common\screens.gsc  (hash_3b96c3c24cbd640d.gscc) (size: 10128 Bytes / 0x2790 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ecc0d7d (2664172925)
// size ...... 10128 (0x2790)
// includes .. 1   (offset: 0x2550)
// strings ... 29  (offset: 0x2558)
// dev strs .. 12  (offset: 0x2700)
// exports ... 23  (offset: 0x1a8c)
// cseg ...... 0x26a + 0x1822 (0x1a8c)
// imports ... 53  (offset: 0x1e24)
// animtree1 . 0   (offset: 0x2790)
// animtree2 . 0   (offset: 0x2790)
#using scripts\common\utility;

#namespace screens;

// Namespace screens
// Params 0
// Checksum 0x829b32ea, Offset: 0x288
// Size: 0x182
function init()
{
    setdvarifuninitialized( @"debug_screens", 0 );
    waitframe();
    level.screens = spawnstruct();
    level.screens.screens = utility::getstructarray( "screens_system", "script_noteworthy" );
    
    if ( !isdefined( level.screens.screens ) || level.screens.screens.size <= 0 )
    {
        return;
    }
    
    level.screens.screens_flagged = [];
    level thread screens_debug_counter();
    
    foreach ( screen in level.screens.screens )
    {
        screen.state = "off";
        screen group_by_flag();
        screen thread watch_scriptable();
    }
    
    if ( isdefined( level.screens_think_func ) )
    {
        utility::array_thread( level.screens.screens, level.screens_think_func );
        return;
    }
    
    utility::array_thread( level.screens.screens, &screens_think );
}

// Namespace screens
// Params 0
// Checksum 0xead152ae, Offset: 0x412
// Size: 0xcb
function group_by_flag()
{
    if ( isdefined( self.script_flag ) )
    {
        if ( !isdefined( level.screens.screens_flagged[ self.script_flag ] ) )
        {
            level.screens.screens_flagged[ self.script_flag ] = [];
            level thread screens_wait_for_flag( self.script_flag );
        }
        
        level.screens.screens_flagged[ self.script_flag ][ level.screens.screens_flagged[ self.script_flag ].size ] = self;
        level.screens.screens = arrayremove( level.screens.screens, self );
    }
}

// Namespace screens
// Params 0
// Checksum 0x7cf0206b, Offset: 0x4e5
// Size: 0x4d
function screens_think()
{
    if ( level.screens_off_test )
    {
        return;
    }
    
    self endon( #"death" );
    screens_create();
    state = get_state();
    
    if ( isdefined( state ) )
    {
        do_state( state );
        return;
    }
    
    screens_fixed();
}

// Namespace screens
// Params 1
// Checksum 0xa38ce9d3, Offset: 0x53a
// Size: 0x2b0
function do_state( state )
{
    self endon( #"death" );
    
    if ( issubstr( state, "screen" ) )
    {
        childthread screens_fixed( state );
        return;
    }
    
    switch ( state )
    {
        case #"hash_8fc81026b8b609d9":
            if ( debug() )
            {
                /#
                    print3d( self.origin + ( 0, 0, 1.5 ), "<dev string:x24>", ( 1, 1, 1 ), 1, 0.1, 2000 );
                #/
            }
            
            childthread screens_fixed();
            break;
        case #"hash_f4b6b015232fe2c6":
            if ( debug() )
            {
                /#
                    print3d( self.origin + ( 0, 0, 1.5 ), "<dev string:x31>", ( 1, 1, 1 ), 1, 0.1, 2000 );
                #/
            }
            
            childthread screens_flip();
            break;
        case #"hash_21d2e67993db5d96":
            if ( debug() )
            {
                /#
                    print3d( self.origin + ( 0, 0, 1.5 ), "<dev string:x3d>", ( 1, 1, 1 ), 1, 0.1, 2000 );
                #/
            }
            
            childthread screens_fliprnd();
            break;
        case #"hash_b196217e12b52a9b":
            if ( debug() )
            {
                /#
                    print3d( self.origin + ( 0, 0, 1.5 ), "<dev string:x4c>", ( 1, 1, 1 ), 1, 0.1, 2000 );
                #/
            }
            
            childthread screens_static();
            break;
        case #"hash_97430f6c58e61cbc":
            if ( debug() )
            {
                /#
                    print3d( self.origin + ( 0, 0, 1.5 ), "<dev string:x5a>", ( 1, 1, 1 ), 1, 0.1, 2000 );
                #/
            }
            
            childthread screens_red();
            break;
        case #"hash_8c1dea2ed75f68af":
            if ( debug() )
            {
                /#
                    print3d( self.origin + ( 0, 0, 1.5 ), "<dev string:x65>", ( 1, 1, 1 ), 1, 0.1, 2000 );
                #/
            }
            
            childthread screens_bink();
            break;
        case #"hash_c217e57b0068891a":
            if ( debug() )
            {
                /#
                    print3d( self.origin + ( 0, 0, 1.5 ), "<dev string:x71>", ( 1, 1, 1 ), 1, 0.1, 2000 );
                #/
            }
            
            childthread screens_alertflip();
            break;
    }
}

// Namespace screens
// Params 0
// Checksum 0xaeaa3a0f, Offset: 0x7f2
// Size: 0x66
function screens_create()
{
    self.screen_model = spawn( "script_model", self.origin );
    self.screen_model.angles = self.angles;
    self.screen_model setmodel( self.script_modelname );
    self.screen_model hideallparts();
    get_screens();
}

// Namespace screens
// Params 0
// Checksum 0xba3d1366, Offset: 0x860
// Size: 0x41
function screens_damage_think()
{
    self.screen_model setcandamage( 1 );
    self.screen_model waittill( #"damage" );
    self notify( #"stop_screens" );
    self.screen_model delete();
}

// Namespace screens
// Params 0
// Checksum 0xbdd8f75d, Offset: 0x8a9
// Size: 0x3e
function screens_delete()
{
    self.state = "off";
    self notify( #"stop_screens" );
    
    if ( isdefined( self.screen_model ) )
    {
        self.screen_model delete();
    }
    
    delete_screens();
}

// Namespace screens
// Params 1
// Checksum 0x676bab1a, Offset: 0x8ef
// Size: 0x12f
function screens_fixed( screen_override )
{
    if ( !isdefined( self.screens_fixed ) && !isdefined( screen_override ) )
    {
        return;
    }
    
    self endon( #"stop_screens" );
    self endon( #"stop_screens_fixed" );
    
    if ( isdefined( screen_override ) )
    {
        screen = screen_override;
    }
    else
    {
        screen = "screen_fixed" + randomint( self.screens_fixed.size ) + 1;
    }
    
    if ( debug() )
    {
        display_screen = screen;
        
        if ( isdefined( screen_override ) )
        {
            display_screen = "override " + display_screen;
        }
        
        /#
            print3d( self.origin, screen, ( 1, 1, 1 ), 1, 0.1, 1000 );
        #/
    }
    
    self.state = "on";
    self.screen_model hideallparts();
    self.screen_model showpart( screen );
    
    if ( isdefined( self.screens_widget ) && !isdefined( screen_override ) )
    {
        if ( randomint( 3 ) == 0 )
        {
            screen = "screen_widget" + randomint( self.screens_widget.size ) + 1;
            self.screen_model showpart( screen );
        }
    }
}

// Namespace screens
// Params 0
// Checksum 0x137a7a90, Offset: 0xa26
// Size: 0xab
function screens_static()
{
    if ( !isdefined( self.screens_static ) )
    {
        return;
    }
    
    self endon( #"stop_screens" );
    self endon( #"stop_screens_static" );
    screen = "screen_static" + randomint( self.screens_static.size ) + 1;
    
    if ( debug() )
    {
        /#
            print3d( self.origin, screen, ( 1, 1, 1 ), 1, 0.1, 1000 );
        #/
    }
    
    self.state = "on";
    self.screen_model hideallparts();
    self.screen_model showpart( screen );
}

// Namespace screens
// Params 0
// Checksum 0xdb6de7a9, Offset: 0xad9
// Size: 0x100
function screens_flip()
{
    if ( !isdefined( self.screens_flip ) )
    {
        return;
    }
    
    self endon( #"stop_screens" );
    self endon( #"stop_screens_flip" );
    
    for ( start_screen = randomint( self.screens_flip.size ) + 1; true ; start_screen = 1 )
    {
        for ( i = start_screen; i < self.screens_flip.size + 1 ; i++ )
        {
            delay = 3;
            screen = "screen_flip" + i;
            
            if ( debug() )
            {
                /#
                    print3d( self.origin, screen, ( 1, 1, 1 ), 1, 0.1, int( delay / 0.05 ) );
                #/
            }
            
            self.state = "on";
            self.screen_model hideallparts();
            self.screen_model showpart( screen );
            wait delay;
        }
    }
}

// Namespace screens
// Params 0
// Checksum 0x67d07830, Offset: 0xbe1
// Size: 0x109
function screens_fliprnd()
{
    if ( !isdefined( self.screens_fliprnd ) )
    {
        return;
    }
    
    self endon( #"stop_screens" );
    self endon( #"stop_screens_fliprnd" );
    
    for ( start_screen = randomint( self.screens_fliprnd.size ) + 1; true ; start_screen = 1 )
    {
        for ( i = start_screen; i < self.screens_fliprnd.size + 1 ; i++ )
        {
            delay = randomfloatrange( 1.5, 4 );
            screen = "screen_fliprnd" + i;
            
            if ( debug() )
            {
                /#
                    print3d( self.origin, screen, ( 1, 1, 1 ), 1, 0.1, int( delay / 0.05 ) );
                #/
            }
            
            self.state = "on";
            self.screen_model hideallparts();
            self.screen_model showpart( screen );
            wait delay;
        }
    }
}

// Namespace screens
// Params 0
// Checksum 0x4e881868, Offset: 0xcf2
// Size: 0xab
function screens_bink()
{
    if ( !isdefined( self.screens_bink ) )
    {
        return;
    }
    
    self endon( #"stop_screens" );
    self endon( #"stop_screens_bink" );
    screen = "screen_bink" + randomint( self.screens_bink.size ) + 1;
    
    if ( debug() )
    {
        /#
            print3d( self.origin, screen, ( 1, 1, 1 ), 1, 0.1, 1000 );
        #/
    }
    
    self.state = "on";
    self.screen_model hideallparts();
    self.screen_model showpart( screen );
}

// Namespace screens
// Params 0
// Checksum 0xe2cd75f0, Offset: 0xda5
// Size: 0x16c
function screens_red()
{
    if ( !isdefined( self.screens_red ) )
    {
        return;
    }
    
    self endon( #"stop_screens" );
    self endon( #"stop_screens_red" );
    self.reversed = 0;
    
    for ( start_screen = randomint( self.screens_red.size ) + 1; true ; start_screen = 1 )
    {
        for ( i = 1; i < self.screens_red.size + 1 ; i++ )
        {
            delay = randomfloatrange( 0.25, 0.5 );
            
            if ( randomint( 6 ) == 0 && !self.reversed )
            {
                self.reversed = 1;
                
                if ( i <= 2 )
                {
                    i += self.screens_red.size;
                }
                
                i -= 2;
                delay = 0.1;
            }
            else
            {
                self.reversed = 0;
            }
            
            screen = "screen_red" + i;
            
            if ( debug() )
            {
                /#
                    print3d( self.origin, screen, ( 1, 1, 1 ), 1, 0.1, int( delay / 0.05 ) );
                #/
            }
            
            self.state = "on";
            self.screen_model hideallparts();
            self.screen_model showpart( screen );
            wait delay;
        }
    }
}

// Namespace screens
// Params 0
// Checksum 0xdab001e2, Offset: 0xf19
// Size: 0xf5
function screens_alertflip()
{
    if ( !isdefined( self.screens_alertflip ) )
    {
        return;
    }
    
    self endon( #"stop_screens" );
    self endon( #"stop_screens_alertflip" );
    self.screen_model hideallparts();
    
    while ( true )
    {
        delay = randomfloatrange( 0.5, 1 );
        
        if ( debug() )
        {
            /#
                print3d( self.origin, "<dev string:x82>", ( 1, 1, 1 ), 1, 0.1, int( delay / 0.05 ) );
            #/
        }
        
        self.state = "on";
        self.screen_model hidepart( "screen_alertflip1" );
        self.screen_model showpart( "screen_alertflip2" );
        wait delay;
        self.screen_model showpart( "screen_alertflip1" );
        self.screen_model hidepart( "screen_alertflip2" );
        wait delay;
    }
}

// Namespace screens
// Params 0
// Checksum 0xf11e9ea8, Offset: 0x1016
// Size: 0x25b
function get_screens()
{
    parts = getnumparts( self.screen_model.model );
    
    for ( i = 0; i < parts ; i++ )
    {
        part_name = getpartname( self.screen_model.model, i );
        
        if ( issubstr( part_name, "screen_" ) )
        {
            if ( issubstr( part_name, "screen_red" ) )
            {
                if ( !isdefined( self.screens_red ) )
                {
                    self.screens_red = [];
                }
                
                self.screens_red[ self.screens_red.size ] = part_name;
                continue;
            }
            
            if ( issubstr( part_name, "screen_fixed" ) )
            {
                if ( !isdefined( self.screens_fixed ) )
                {
                    self.screens_fixed = [];
                }
                
                self.screens_fixed[ self.screens_fixed.size ] = part_name;
                continue;
            }
            
            if ( issubstr( part_name, "screen_static" ) )
            {
                if ( !isdefined( self.screens_static ) )
                {
                    self.screens_static = [];
                }
                
                self.screens_static[ self.screens_static.size ] = part_name;
                continue;
            }
            
            if ( issubstr( part_name, "screen_fliprnd" ) )
            {
                if ( !isdefined( self.screens_fliprnd ) )
                {
                    self.screens_fliprnd = [];
                }
                
                self.screens_fliprnd[ self.screens_fliprnd.size ] = part_name;
                continue;
            }
            
            if ( issubstr( part_name, "screen_flip" ) )
            {
                if ( !isdefined( self.screens_flip ) )
                {
                    self.screens_flip = [];
                }
                
                self.screens_flip[ self.screens_flip.size ] = part_name;
                continue;
            }
            
            if ( issubstr( part_name, "screen_bink" ) )
            {
                if ( !isdefined( self.screens_bink ) )
                {
                    self.screens_bink = [];
                }
                
                self.screens_bink[ self.screens_bink.size ] = part_name;
                continue;
            }
            
            if ( issubstr( part_name, "screen_alertflip" ) )
            {
                if ( !isdefined( self.screens_alertflip ) )
                {
                    self.screens_alertflip = [];
                }
                
                self.screens_alertflip[ self.screens_alertflip.size ] = part_name;
                continue;
            }
            
            if ( issubstr( part_name, "screen_widget" ) )
            {
                if ( !isdefined( self.screens_widget ) )
                {
                    self.screens_widget = [];
                }
                
                self.screens_widget[ self.screens_widget.size ] = part_name;
            }
        }
    }
}

// Namespace screens
// Params 0
// Checksum 0x70b091b3, Offset: 0x1279
// Size: 0xba
function delete_screens()
{
    if ( isdefined( self.screens_red ) )
    {
        self.screens_red = [];
    }
    
    if ( isdefined( self.screens_fixed ) )
    {
        self.screens_fixed = [];
    }
    
    if ( isdefined( self.screens_static ) )
    {
        self.screens_static = [];
    }
    
    if ( isdefined( self.screens_flip ) )
    {
        self.screens_flip = [];
    }
    
    if ( isdefined( self.screens_fliprnd ) )
    {
        self.screens_fliprnd = [];
    }
    
    if ( isdefined( self.screens_bink ) )
    {
        self.screens_bink = [];
    }
    
    if ( isdefined( self.screens_alertflip ) )
    {
        self.screens_alertflip = [];
    }
    
    if ( isdefined( self.screens_widget ) )
    {
        self.screens_widget = [];
    }
}

// Namespace screens
// Params 0
// Checksum 0x51f9a13b, Offset: 0x133b
// Size: 0x1b6
function get_state()
{
    if ( isdefined( self.script_parameters ) )
    {
        tokens = strtok( self.script_parameters, " " );
        
        foreach ( token in tokens )
        {
            if ( issubstr( token, "screen" ) )
            {
                return token;
            }
        }
        
        foreach ( token in tokens )
        {
            if ( issubstr( token, "state" ) )
            {
                switch ( token )
                {
                    case #"hash_b69937ed5fc0dda7":
                        return "fixed";
                    case #"hash_61d72a335da10598":
                        return "flip";
                    case #"hash_b30cc7411319f81c":
                        return "fliprnd";
                    case #"hash_f872b3e5dcf09621":
                        return "static";
                    case #"hash_b2c7cbae5e07461a":
                        return "red";
                    case #"hash_df190818a771f549":
                        return "bink";
                    case #"hash_d32cec26f4e68bfc":
                        return "alertflip";
                    default:
                        assertmsg( "<dev string:x96>" + token );
                        break;
                }
            }
        }
    }
}

// Namespace screens
// Params 0
// Checksum 0xc9ccc5f5, Offset: 0x14fa
// Size: 0x1d1
function watch_scriptable()
{
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    scriptables = getscriptablearray( self.target, #targetname );
    
    if ( isdefined( scriptables[ 0 ] ) )
    {
        if ( debug() )
        {
            /#
                print3d( self.origin + ( 0, 0, 3 ), "<dev string:xa6>", ( 1, 1, 1 ), 1, 0.1, 10000 );
            #/
        }
        
        scriptables[ 0 ] waittill( #"death" );
        screens_delete();
        keys = getarraykeys( level.screens.screens_flagged );
        
        foreach ( key in keys )
        {
            foreach ( screen in level.screens.screens_flagged[ key ] )
            {
                if ( self == screen )
                {
                    level.screens.screens_flagged[ key ] = arrayremove( level.screens.screens_flagged[ key ], self );
                    return;
                }
            }
        }
    }
}

// Namespace screens
// Params 0
// Checksum 0xc0387940, Offset: 0x16d3
// Size: 0x18, Type: bool
function debug()
{
    if ( getdvarint( @"debug_screens" ) > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace screens
// Params 0
// Checksum 0x79c6bae5, Offset: 0x16f4
// Size: 0x2
function set_screens_to_red()
{
    
}

// Namespace screens
// Params 0
// Checksum 0xde2a2b6c, Offset: 0x16fe
// Size: 0x25b
function screens_debug_counter()
{
    if ( !debug() )
    {
        return;
    }
    
    while ( true )
    {
        active_screens = 0;
        flagged_screens = 0;
        keys = getarraykeys( level.screens.screens_flagged );
        
        foreach ( key in keys )
        {
            flagged_screens += level.screens.screens_flagged[ key ].size;
            
            foreach ( screen in level.screens.screens_flagged[ key ] )
            {
                if ( screen.state == "on" )
                {
                    active_screens += 1;
                }
            }
        }
        
        foreach ( screen in level.screens.screens )
        {
            if ( screen.state == "on" )
            {
                active_screens += 1;
            }
        }
        
        total_count = level.screens.screens.size + flagged_screens;
        
        /#
            printtoscreen2d( 1000, 70, "<dev string:xb5>" + total_count, ( 1, 1, 1 ), 2 );
        #/
        
        /#
            printtoscreen2d( 1000, 100, "<dev string:xca>" + active_screens, ( 1, 1, 1 ), 2 );
        #/
        
        waitframe();
    }
}

// Namespace screens
// Params 1
// Checksum 0xd5823fbe, Offset: 0x1961
// Size: 0x12b
function screens_wait_for_flag( flag )
{
    if ( !utility::flag_exist( flag ) )
    {
        utility::flag_init( flag );
    }
    
    while ( true )
    {
        utility::flag_wait( flag );
        
        if ( debug() )
        {
            iprintln( level.screens.screens_flagged[ flag ].size + " flagged screens activated: " + flag );
        }
        
        if ( !level.screens_off_test )
        {
            if ( isdefined( level.screens_think_func ) )
            {
                utility::array_thread( level.screens.screens_flagged[ flag ], level.screens_think_func );
            }
            else
            {
                utility::array_thread( level.screens.screens_flagged[ flag ], &screens_think );
            }
        }
        
        utility::flag_waitopen( flag );
        
        if ( debug() )
        {
            iprintln( level.screens.screens_flagged[ flag ].size + " flagged screens deactivated: " + flag );
        }
        
        if ( !level.screens_off_test )
        {
            utility::array_thread( level.screens.screens_flagged[ flag ], &screens_delete );
        }
    }
}

