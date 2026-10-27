// scripts\common\ai\stealth\callbacks.gsc  (hash_7540b06028fffa17.gscc) (size: 1620 Bytes / 0x654 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1fb390d (33241357)
// size ...... 1620 (0x654)
// includes .. 1   (offset: 0x5e0)
// strings ... 7   (offset: 0x5e8)
// dev strs .. 1   (offset: 0x648)
// exports ... 7   (offset: 0x3d4)
// cseg ...... 0x101 + 0x2d3 (0x3d4)
// imports ... 8   (offset: 0x4ec)
// animtree1 . 0   (offset: 0x654)
// animtree2 . 0   (offset: 0x654)
#using scripts\common\utility;

#namespace callbacks;

// Namespace callbacks
// Params 0
// Checksum 0xd55c402a, Offset: 0x11f
// Size: 0xfb
function init_callbacks()
{
    level.global_callbacks = [];
    
    foreach ( callback in [ "_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func" ] )
    {
        level.global_callbacks[ callback ] = &global_empty_callback;
    }
    
    if ( !utility::flag_exist( "stealth_spotted" ) )
    {
        utility::flag_init( "stealth_spotted" );
    }
    
    if ( !utility::flag_exist( "stealth_enabled" ) )
    {
        utility::flag_init( "stealth_enabled" );
    }
    
    if ( !utility::flag_exist( "stealth_music_pause" ) )
    {
        utility::flag_init( "stealth_music_pause" );
    }
}

// Namespace callbacks
// Params 5
// Checksum 0x5da1933, Offset: 0x222
// Size: 0x3d
function global_empty_callback( empty1, empty2, empty3, empty4, empty5 )
{
    assertmsg( "<dev string:x24>" );
}

// Namespace callbacks
// Params 1
// Checksum 0x7fe36b4b, Offset: 0x267
// Size: 0x85
function stealth_get_func( type )
{
    if ( isdefined( self.stealth ) && isdefined( self.stealth.funcs[ type ] ) )
    {
        return self.stealth.funcs[ type ];
    }
    
    if ( isdefined( level.stealth ) && isdefined( level.stealth.funcs ) )
    {
        return level.stealth.funcs[ type ];
    }
}

// Namespace callbacks
// Params 3, eflags: 0x40 variadic
// Checksum 0xc20ef962, Offset: 0x2f5
// Size: 0x42
function stealth_call( type, ... )
{
    func = stealth_get_func( type );
    
    if ( isdefined( func ) )
    {
        return self [[ func ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace callbacks
// Params 3, eflags: 0x40 variadic
// Checksum 0x56354928, Offset: 0x340
// Size: 0x42
function stealth_call_thread( type, ... )
{
    func = stealth_get_func( type );
    
    if ( isdefined( func ) )
    {
        self thread [[ func ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace callbacks
// Params 4, eflags: 0x40 variadic
// Checksum 0xa2c7a0c2, Offset: 0x38b
// Size: 0x49
function stealth_call_filter( type, shouldreturn, ... )
{
    if ( shouldreturn )
    {
        return stealth_call( type, flat_args( vararg, varargcount ) );
    }
    
    return stealth_call_thread( type, flat_args( vararg, varargcount ) );
}

