// scripts\mp\common\utility\disconnect_event_aggregator.gsc  (hash_44d041e3f6378fc4.gscc) (size: 1107 Bytes / 0x453 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e675eee (2657574638)
// size ...... 1107 (0x453)
// includes .. 0   (offset: 0x453)
// strings ... 0   (offset: 0x453)
// dev strs .. 0   (offset: 0x453)
// exports ... 7   (offset: 0x317)
// cseg ...... 0x58 + 0x2bf (0x317)
// imports ... 1   (offset: 0x42f)
// animtree1 . 0   (offset: 0x453)
// animtree2 . 0   (offset: 0x453)
#namespace disconnect_event_aggregator;

// Namespace disconnect_event_aggregator
// Params 1
// Checksum 0xc06053cb, Offset: 0x76
// Size: 0x9a
function rundisconnectcallbacks( player )
{
    if ( !isdefined( level.ondisconnecteventcallbacks ) )
    {
        level.ondisconnecteventcallbacks = [];
    }
    
    foreach ( callback in level.ondisconnecteventcallbacks )
    {
        level thread [[ callback ]]( player );
    }
}

// Namespace disconnect_event_aggregator
// Params 1
// Checksum 0x809911de, Offset: 0x118
// Size: 0x9a
function function_589bed54937d9441( player )
{
    if ( !isdefined( level.var_dccc3fee13c73343 ) )
    {
        level.var_dccc3fee13c73343 = [];
    }
    
    foreach ( callback in level.var_dccc3fee13c73343 )
    {
        level thread [[ callback ]]( player );
    }
}

// Namespace disconnect_event_aggregator
// Params 1
// Checksum 0x91866499, Offset: 0x1ba
// Size: 0x9a
function function_c57c9f42e530d106( player )
{
    if ( !isdefined( level.var_b067ee7bb3d45b0e ) )
    {
        level.var_b067ee7bb3d45b0e = [];
    }
    
    foreach ( callback in level.var_b067ee7bb3d45b0e )
    {
        level [[ callback ]]( player );
    }
}

// Namespace disconnect_event_aggregator
// Params 1
// Checksum 0xb37e13d1, Offset: 0x25c
// Size: 0x39
function registerondisconnecteventcallback( callback )
{
    if ( !isdefined( level.ondisconnecteventcallbacks ) )
    {
        level.ondisconnecteventcallbacks = [];
    }
    
    level.ondisconnecteventcallbacks[ level.ondisconnecteventcallbacks.size ] = callback;
}

// Namespace disconnect_event_aggregator
// Params 1
// Checksum 0xcb693be6, Offset: 0x29d
// Size: 0x39
function function_11efe509aba577f7( callback )
{
    if ( !isdefined( level.var_dccc3fee13c73343 ) )
    {
        level.var_dccc3fee13c73343 = [];
    }
    
    level.var_dccc3fee13c73343[ level.var_dccc3fee13c73343.size ] = callback;
}

// Namespace disconnect_event_aggregator
// Params 1
// Checksum 0xd30c17be, Offset: 0x2de
// Size: 0x39
function function_f460203966e88ab0( callback )
{
    if ( !isdefined( level.var_b067ee7bb3d45b0e ) )
    {
        level.var_b067ee7bb3d45b0e = [];
    }
    
    level.var_b067ee7bb3d45b0e[ level.var_b067ee7bb3d45b0e.size ] = callback;
}

