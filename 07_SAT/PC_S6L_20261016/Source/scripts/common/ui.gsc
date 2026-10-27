// scripts\common\ui.gsc  (hash_569b10679fe8cf60.gscc) (size: 2796 Bytes / 0xaec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16d4442a (383009834)
// size ...... 2796 (0xaec)
// includes .. 1   (offset: 0xa94)
// strings ... 2   (offset: 0xa9c)
// dev strs .. 3   (offset: 0xab8)
// exports ... 9   (offset: 0x70c)
// cseg ...... 0x7e + 0x68e (0x70c)
// imports ... 17  (offset: 0x874)
// animtree1 . 0   (offset: 0xaec)
// animtree2 . 0   (offset: 0xaec)
#using scripts\common\utility;

#namespace ui;

// Namespace ui
// Params 2
// Checksum 0x229760f5, Offset: 0x9c
// Size: 0xaf
function lui_registercallback( channel, callback )
{
    if ( !isdefined( level.lui_callbacks ) )
    {
        level.lui_callbacks = [];
    }
    
    assert( isstring( channel ) && channel != "<dev string:x24>" && isfunction( callback ) );
    
    if ( !isdefined( level.lui_callbacks[ channel ] ) || !arraycontains( level.lui_callbacks[ channel ], callback ) )
    {
        if ( !isdefined( level.lui_callbacks[ channel ] ) )
        {
            level.lui_callbacks[ channel ] = [];
        }
        
        level.lui_callbacks[ channel ][ level.lui_callbacks[ channel ].size ] = callback;
    }
}

// Namespace ui
// Params 2
// Checksum 0x16835501, Offset: 0x153
// Size: 0x84
function function_c2505ff7b7fc55a4( channel, callback )
{
    assert( isstring( channel ) && channel != "<dev string:x24>" && isfunction( callback ) );
    
    if ( level.lui_callbacks[ channel ] )
    {
        level.lui_callbacks[ channel ] = arrayremove( level.lui_callbacks[ channel ], callback );
        
        if ( level.lui_callbacks[ channel ].size == 0 )
        {
            level.lui_callbacks[ channel ] = undefined;
        }
    }
}

// Namespace ui
// Params 2
// Checksum 0xe23a2d46, Offset: 0x1df
// Size: 0xd3
function function_6c9f8c2a6da4d92b( channel, callback )
{
    assert( utility::issp() );
    assert( isstring( channel ) && channel != "<dev string:x24>" && isfunction( callback ) );
    
    if ( !isdefined( level.var_7885951511acf7b5 ) )
    {
        level.var_7885951511acf7b5 = [];
    }
    
    if ( !isdefined( level.var_1042038ec3eff6a4 ) )
    {
        level.var_1042038ec3eff6a4 = [];
    }
    
    if ( !isdefined( level.var_1042038ec3eff6a4[ channel ] ) || !arraycontains( level.var_1042038ec3eff6a4[ channel ], callback ) )
    {
        if ( !isdefined( level.var_1042038ec3eff6a4[ channel ] ) )
        {
            level.var_1042038ec3eff6a4[ channel ] = [];
        }
        
        level.var_1042038ec3eff6a4[ channel ][ level.var_1042038ec3eff6a4[ channel ].size ] = callback;
    }
}

// Namespace ui
// Params 2
// Checksum 0x30a058d8, Offset: 0x2ba
// Size: 0xbb
function function_770abf131329ffc7( channel, callback )
{
    assert( isinfrontend() );
    assert( isstring( channel ) && channel != "<dev string:x24>" && isfunction( callback ) );
    
    if ( !isdefined( level.var_8140645f7e3c6266 ) )
    {
        level.var_8140645f7e3c6266 = [];
    }
    
    if ( !isdefined( level.var_8140645f7e3c6266[ channel ] ) || !arraycontains( level.var_8140645f7e3c6266[ channel ], callback ) )
    {
        if ( !isdefined( level.var_8140645f7e3c6266[ channel ] ) )
        {
            level.var_8140645f7e3c6266[ channel ] = [];
        }
        
        level.var_8140645f7e3c6266[ channel ][ level.var_8140645f7e3c6266[ channel ].size ] = callback;
    }
}

// Namespace ui
// Params 1
// Checksum 0xf2cb40d7, Offset: 0x37d
// Size: 0x59
function function_52f4e497797fadd8( channel )
{
    if ( !isdefined( level.var_1537394bb444852c ) )
    {
        level.var_1537394bb444852c = [];
    }
    
    assert( isstring( channel ) && channel != "<dev string:x24>" );
    
    if ( !isdefined( level.var_1537394bb444852c[ channel ] ) )
    {
        level.var_1537394bb444852c[ channel ] = channel;
    }
}

// Namespace ui/lui_callback
// Params 3, eflags: 0x20
// Checksum 0xddca181e, Offset: 0x3de
// Size: 0x297
function event_handler[lui_callback] lui_notify_callback( channel, value, value2 )
{
    if ( self )
    {
        if ( level.lui_callbacks[ channel ] )
        {
            foreach ( callback in level.lui_callbacks[ channel ] )
            {
                self.var_b458a7ace288c777 = channel;
                
                if ( isdefined( value2 ) )
                {
                    self thread [[ callback ]]( value, value2 );
                    continue;
                }
                
                self thread [[ callback ]]( value );
            }
        }
        else if ( level.var_1537394bb444852c[ channel ] )
        {
            if ( value )
            {
                utility::flag_set( channel );
            }
            else
            {
                utility::flag_clear( channel );
            }
        }
        
        if ( utility::issp() )
        {
            args = strtok( channel, "," );
            channelarg = args[ 0 ];
            
            if ( level.var_1042038ec3eff6a4[ channelarg ] )
            {
                foreach ( callback in level.var_1042038ec3eff6a4[ channelarg ] )
                {
                    if ( isdefined( value2 ) )
                    {
                        self thread [[ callback ]]( value, value2, args );
                        continue;
                    }
                    
                    self thread [[ callback ]]( value, args );
                }
            }
        }
        
        if ( isinfrontend() )
        {
            args = strtok( channel, ",", 1 );
            channelarg = args[ 0 ];
            
            if ( level.var_8140645f7e3c6266[ channelarg ] )
            {
                foreach ( callback in level.var_8140645f7e3c6266[ channelarg ] )
                {
                    if ( isdefined( value2 ) )
                    {
                        self thread [[ callback ]]( value, value2, args );
                        continue;
                    }
                    
                    self thread [[ callback ]]( value, args );
                }
            }
        }
        
        /#
            thread debugnotify( channel );
        #/
        
        if ( isdefined( value2 ) )
        {
            self notify( #"luinotifyserver", channel, value, value2 );
            return;
        }
        
        self notify( #"luinotifyserver", channel, value );
    }
}

// Namespace ui
// Params 1
// Checksum 0x8e863e59, Offset: 0x67d
// Size: 0x38
function function_ca488d3659619c7( shouldbevisible = 1 )
{
    asnumeric = shouldbevisible ? 1 : 0;
    setomnvar( "ui_toggle_subtitle_visibility", asnumeric );
}

/#

    // Namespace ui
    // Params 1
    // Checksum 0x6e08ba51, Offset: 0x6bd
    // Size: 0x4f, Type: dev
    function debugnotify( channel )
    {
        if ( isdefined( self.luinotify ) )
        {
            println( "<dev string:x25>" + self.luinotify + "<dev string:x3b>" + channel );
        }
        
        self.luinotify = channel;
        waittillframeend();
        self.luinotify = undefined;
    }

#/
