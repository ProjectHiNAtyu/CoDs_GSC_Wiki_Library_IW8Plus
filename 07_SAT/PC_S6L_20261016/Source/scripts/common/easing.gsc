// scripts\common\easing.gsc  (hash_35bc63223ffe235b.gscc) (size: 3763 Bytes / 0xeb3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8a191a23 (2316900899)
// size ...... 3763 (0xeb3)
// includes .. 0   (offset: 0xe13)
// strings ... 13  (offset: 0xe13)
// dev strs .. 0   (offset: 0xeb3)
// exports ... 17  (offset: 0x863)
// cseg ...... 0xe8 + 0x77b (0x863)
// imports ... 27  (offset: 0xb0b)
// animtree1 . 0   (offset: 0xeb3)
// animtree2 . 0   (offset: 0xeb3)
#namespace easing;

// Namespace easing
// Params 0
// Checksum 0x5a766930, Offset: 0x106
// Size: 0x108
function ease_init()
{
    level.ease_funcs = [];
    level.ease_funcs[ "linear" ] = &ease_linear;
    level.ease_funcs[ "power" ] = &ease_power;
    level.ease_funcs[ "quadratic" ] = &ease_quadratic;
    level.ease_funcs[ "cubic" ] = &ease_cubic;
    level.ease_funcs[ "quartic" ] = &ease_quartic;
    level.ease_funcs[ "quintic" ] = &ease_quintic;
    level.ease_funcs[ "exponential" ] = &ease_exponential;
    level.ease_funcs[ "logarithmic" ] = &ease_logarithmic;
    level.ease_funcs[ "sine" ] = &ease_sine;
    level.ease_funcs[ "back" ] = &ease_back;
    level.ease_funcs[ "elastic" ] = &ease_elastic;
    level.ease_funcs[ "bounce" ] = &ease_bounce;
}

// Namespace easing
// Params 5
// Checksum 0xbafd0fba, Offset: 0x216
// Size: 0x40
function ease_linear( start, end, pct, ease_in, ease_out )
{
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 6
// Checksum 0xc8795d8f, Offset: 0x25f
// Size: 0x55
function ease_power( start, end, pct, ease_in, ease_out, power )
{
    pct = easepower( pct, power, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 5
// Checksum 0x82d4b81c, Offset: 0x2bd
// Size: 0x4d
function ease_quadratic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 2, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 5
// Checksum 0xc75090f, Offset: 0x313
// Size: 0x4d
function ease_cubic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 3, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 5
// Checksum 0xa61e08dd, Offset: 0x369
// Size: 0x4d
function ease_quartic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 4, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 5
// Checksum 0x8ca1ab3a, Offset: 0x3bf
// Size: 0x4d
function ease_quintic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 5, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 6
// Checksum 0xa78526e5, Offset: 0x415
// Size: 0x55
function ease_exponential( start, end, pct, ease_in, ease_out, scale )
{
    pct = easeexponential( pct, scale, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 6
// Checksum 0xa78526e5, Offset: 0x473
// Size: 0x55
function ease_logarithmic( start, end, pct, ease_in, ease_out, log_base )
{
    pct = easelogarithmic( pct, log_base, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 5
// Checksum 0xe763c9cb, Offset: 0x4d1
// Size: 0x4a
function ease_sine( start, end, pct, ease_in, ease_out )
{
    pct = easesine( pct, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 7
// Checksum 0xe763c9cb, Offset: 0x524
// Size: 0x5f
function ease_back( start, end, pct, ease_in, ease_out, overshoot_scalar, power )
{
    pct = easeback( pct, overshoot_scalar, power, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 8
// Checksum 0xc05f3e84, Offset: 0x58c
// Size: 0x69
function ease_elastic( start, end, pct, ease_in, ease_out, amplitude, frequency, fade_scalar )
{
    pct = easeelastic( pct, amplitude, frequency, fade_scalar, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 7
// Checksum 0xac3def86, Offset: 0x5fe
// Size: 0x5f
function ease_bounce( start, end, pct, ease_in, ease_out, bounces, decay_scalar )
{
    pct = easebounce( pct, bounces, decay_scalar, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing
// Params 9
// Checksum 0x916246f4, Offset: 0x666
// Size: 0x6a
function ease_dvar( dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3 )
{
    _ease_dvar( &setdvar, dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3 );
}

// Namespace easing
// Params 8, eflags: 0x40 variadic
// Checksum 0xe91f7910, Offset: 0x6d8
// Size: 0x61
function ease_saved_dvar( dvar, value, time, ease_type, ease_in, ease_out, ... )
{
    _ease_dvar( &setsaveddvar, dvar, value, time, ease_type, ease_in, ease_out, flat_args( vararg, varargcount ) );
}

// Namespace easing
// Params 9, eflags: 0x44 variadic
// Checksum 0xfaf55996, Offset: 0x741
// Size: 0x122
function private _ease_dvar( dvar_func, dvar, value, time, ease_type, ease_in, ease_out, ... )
{
    assert( isdefined( level.ease_funcs ) );
    assert( isdefined( level.ease_funcs[ ease_type ] ) );
    dvar_name = getxhashhexname( dvar );
    level notify( "ease_dvar_" + dvar_name );
    level endon( "ease_dvar_" + dvar_name );
    start_value = getdvarfloat( dvar );
    cur_value = start_value;
    cur_time = 0;
    
    while ( cur_time < time )
    {
        cur_time += level.framedurationseconds;
        pct = min( 1, cur_time / time );
        cur_value = [[ level.ease_funcs[ ease_type ] ]]( start_value, value, pct, ease_in, ease_out, flat_args( vararg, varargcount ) );
        builtin [[ dvar_func ]]( dvar, cur_value );
        waitframe();
    }
    
    builtin [[ dvar_func ]]( dvar, value );
}

