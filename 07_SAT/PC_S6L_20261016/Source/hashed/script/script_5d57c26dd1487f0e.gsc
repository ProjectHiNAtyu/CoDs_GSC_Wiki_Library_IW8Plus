// script_5d57c26dd1487f0e  (hash_5d57c26dd1487f0e.gscc) (size: 8947 Bytes / 0x22f3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x958767fd (2508679165)
// size ...... 8947 (0x22f3)
// includes .. 1   (offset: 0x1dd7)
// strings ... 105 (offset: 0x1ddf)
// dev strs .. 0   (offset: 0x22f3)
// exports ... 25  (offset: 0x1453)
// cseg ...... 0x71d + 0xd36 (0x1453)
// imports ... 35  (offset: 0x183b)
// animtree1 . 0   (offset: 0x22f3)
// animtree2 . 0   (offset: 0x22f3)
#using scripts\unittest\util;

#namespace gscunittest_error;

// Namespace gscunittest_error
// Params 2
// Checksum 0xf7c91de5, Offset: 0x73b
// Size: 0x3c
function error_print( msg, var )
{
    if ( isdefined( var ) )
    {
        util::test_print( msg + ": defined" );
        return;
    }
    
    util::test_print( msg + ": not defined" );
}

// Namespace gscunittest_error
// Params 3
// Checksum 0x808c28a9, Offset: 0x77f
// Size: 0x1e
function func( a, b, c )
{
    
}

// Namespace gscunittest_error
// Params 0
// Checksum 0xe6261220, Offset: 0x7a5
// Size: 0x10, Type: bool
function cond_func()
{
    util::test_print( "cond func" );
    return true;
}

// Namespace gscunittest_error
// Params 0
// Checksum 0x83393432, Offset: 0x7be
// Size: 0xca
function params()
{
    s = spawnstruct();
    util::test_print( "func param" );
    func( 1, "x", s );
    util::test_print( "meth param" );
    s func( 1, "x", s );
    util::test_print( "func thread param" );
    thread func( 1, "x", s );
    util::test_print( "meth thread param" );
    s thread func( 1, "x", s );
    f = &func;
    util::test_print( "func pointer param" );
    thread [[ f ]]( 1, "x", s );
    util::test_print( "meth pointer param" );
    s thread [[ f ]]( 1, "x", s );
}

// Namespace gscunittest_error
// Params 0
// Checksum 0x5b3323b0, Offset: 0x890
// Size: 0x3bd
function types()
{
    x = 1;
    s = spawnstruct();
    a = [ 1, 2, 3, 4, 5, 6 ];
    v = ( 1, 2, 3 );
    p = level.players[ 0 ];
    str = "foo";
    y = x + s;
    error_print( "+", y );
    y = x < str;
    error_print( "lt", y );
    y = x >= str;
    error_print( "ge", y );
    y = 1;
    y++;
    error_print( "inc float", y );
    s++;
    error_print( "inc struct", s );
    y = s && cond_func();
    error_print( "and struct", y );
    y = s || cond_func();
    error_print( "or struct", y );
    y = x < str || cond_func();
    error_print( "or expr", y );
    util::test_print( "array field" );
    x = a.foo;
    util::test_print( "array field ref" );
    a.foo = 0;
    util::test_print( "vector field" );
    x = v.foo;
    util::test_print( "vector field ref" );
    v.foo = 0;
    s.a[ 0 ] = 1;
    y = s.a[ 1 ];
    error_print( "unknown array int", y );
    y = s.a[ "hi" ];
    error_print( "unknown array string", y );
    util::test_print( "vec ref" );
    v[ 0 ] = 0;
    util::test_print( "str ref" );
    str[ 0 ] = "x";
    s[ 0 ] = 0;
    util::test_print( "array ref bad int index" );
    a[ 16777216 ] = 0;
    util::test_print( "array ref bad struct index" );
    a[ s ] = 0;
    util::test_print( "ent field array ref" );
    p.team[ 0 ] = 0;
    util::test_print( "ent array ref" );
    p[ 0 ] = 0;
    y = v[ 3 ];
    error_print( "vec bad int index", y );
    y = v[ "hi" ];
    error_print( "vec str index", y );
    y = str[ 3 ];
    error_print( "str bad int index", y );
    y = str[ "hi" ];
    error_print( "str str index", y );
    y = a[ 16777216 ];
    error_print( "array bad int index", y );
    y = a[ s ];
    error_print( "array struct index", y );
    y = p[ 0 ];
    error_print( "ent array index", y );
    util::test_print( "str clear" );
    s[ 0 ] = undefined;
    util::test_print( "array clear bad int index" );
    a[ 16777216 ] = undefined;
    util::test_print( "array clear struct index" );
    a[ s ] = undefined;
    util::test_print( "array clear player" );
    p[ 0 ] = undefined;
    util::test_print( "array clear vector" );
    v[ 0 ] = undefined;
    y = v.size;
    error_print( "vector size", y );
    y = s.size;
    error_print( "struct size", y );
    y = p.size;
    error_print( "player size", y );
    y = x.size;
    error_print( "int size", y );
    util::test_print( "bad vector" );
}

// Namespace gscunittest_error
// Params 0
// Checksum 0xd15673fe, Offset: 0xc55
// Size: 0x68
function wait_notify()
{
    s = spawnstruct();
    x = 1;
    wait -1;
    wait -1;
    wait 16777216;
    wait s;
    level waittill( 1 );
    x waittill( #"foo" );
    level endon( 1 );
    x endon( #"foo" );
    level notify( 1 );
    x notify( #"foo" );
}

// Namespace gscunittest_error
// Params 2
// Checksum 0xb3a706a8, Offset: 0xcc5
// Size: 0x88
function switch_func( msg, var )
{
    util::test_print( msg );
    
    switch ( var )
    {
        case 0:
            util::test_print( "0" );
            break;
        case #"":
            util::test_print( "empty" );
            break;
        default:
            util::test_print( "default" );
            break;
    }
    
    util::test_print( msg + " end" );
}

// Namespace gscunittest_error
// Params 0
// Checksum 0x2c77b20b, Offset: 0xd55
// Size: 0x53
function switch_test()
{
    switch_func( "switch float", 1 );
    switch_func( "switch bad int", 16777216 );
    switch_func( "switch struct", spawnstruct() );
    switch_func( "switch vec", [ 1, 2, 3 ] );
}

// Namespace gscunittest_error
// Params 0
// Checksum 0xd5ff5e3a, Offset: 0xdb0
// Size: 0x319
function cond()
{
    s = spawnstruct();
    
    if ( s )
    {
        util::test_print( "struct if" );
    }
    else
    {
        util::test_print( "struct else" );
    }
    
    if ( !s )
    {
        util::test_print( "struct not if" );
    }
    else
    {
        util::test_print( "struct not else" );
    }
    
    x = 1;
    y = "hi";
    
    if ( x < y )
    {
        util::test_print( "lt if" );
    }
    else
    {
        util::test_print( "lt else" );
    }
    
    if ( s && cond_func() )
    {
        util::test_print( "and if" );
    }
    else
    {
        util::test_print( "and else" );
    }
    
    if ( s || cond_func() )
    {
        util::test_print( "or if" );
    }
    else
    {
        util::test_print( "or else" );
    }
    
    if ( !( s < 1 ) && cond_func() )
    {
        util::test_print( "!bool and if" );
    }
    else
    {
        util::test_print( "!bool and else" );
    }
    
    if ( !( s < 1 ) || cond_func() )
    {
        util::test_print( "!bool or if" );
    }
    else
    {
        util::test_print( "!bool or else" );
    }
    
    if ( !s && cond_func() )
    {
        util::test_print( "!struct and if" );
    }
    else
    {
        util::test_print( "!struct and else" );
    }
    
    if ( !s || cond_func() )
    {
        util::test_print( "!struct or if" );
    }
    else
    {
        util::test_print( "!struct or else" );
    }
    
    if ( !( s && cond_func() ) )
    {
        util::test_print( "!(and) if" );
    }
    else
    {
        util::test_print( "!(and) else" );
    }
    
    if ( !( s || cond_func() ) )
    {
        util::test_print( "!(or) if" );
    }
    else
    {
        util::test_print( "!(or) else" );
    }
    
    c = 0;
    
    while ( x < y )
    {
        util::test_print( "lt while: " + c );
        c++;
        
        if ( c > 2 )
        {
            break;
        }
    }
    
    c = 0;
    
    while ( !( x < y ) )
    {
        util::test_print( "!lt while: " + c );
        c++;
        
        if ( c > 2 )
        {
            break;
        }
    }
    
    c = 0;
    
    while ( c < 2 && x < y )
    {
        util::test_print( "lt for: " + c );
        c++;
        
        if ( c > 2 )
        {
            break;
        }
        
        s++;
    }
    
    c = 0;
    
    while ( c < 2 && !( x < y ) )
    {
        util::test_print( "!lt for: " + c );
        c++;
        
        if ( c > 2 )
        {
            break;
        }
        
        s++;
    }
    
    b = s ? 1 : 0;
    
    if ( b )
    {
        util::test_print( "struct ternary if" );
    }
    else
    {
        util::test_print( "struct ternary else" );
    }
    
    b = !s ? 1 : 0;
    
    if ( b )
    {
        util::test_print( "struct ternary not if" );
        return;
    }
    
    util::test_print( "struct ternary not else" );
}

// Namespace gscunittest_error
// Params 2
// Checksum 0x588bf572, Offset: 0x10d1
// Size: 0x5e
function is_true_print( val, name )
{
    b = istrue( val );
    
    if ( !isdefined( b ) )
    {
        b = "undefined";
    }
    
    d = isdefined( val );
    util::test_print( "is_true: " + name + ": " + b + " isdefined: " + d );
}

// Namespace gscunittest_error
// Params 0
// Checksum 0x224e6d3, Offset: 0x1137
// Size: 0x39
function is_true()
{
    a = [];
    is_true_print( a, "array" );
    s = spawnstruct();
    is_true_print( s, "struct" );
}

// Namespace gscunittest_error
// Params 0
// Checksum 0x7e5f4239, Offset: 0x1178
// Size: 0xb9
function builtin()
{
    key = getarraykey( undefined, -1 );
    util::test_print( "builtin" );
    p = &getarraykey;
    key = builtin [[ p ]]( undefined, -1 );
    util::test_print( "builtin pointer" );
    p = undefined;
    builtin [[ p ]]( 1, 2, 3 );
    util::test_print( "builtin pointer invalid" );
    m = undefined;
    m moveto( 1, 2, 3 );
    util::test_print( "builtin method" );
    p = &moveto;
    m builtin [[ p ]]( 1, 2, 3 );
    util::test_print( "builtin method pointer" );
    p = undefined;
    m builtin [[ p ]]( 1, 2, 3 );
    util::test_print( "builtin method pointer invalid" );
}

// Namespace gscunittest_error
// Params 0
// Checksum 0x74c2887c, Offset: 0x1239
// Size: 0x9
function n3()
{
    return 1 + spawnstruct();
}

// Namespace gscunittest_error
// Params 0
// Checksum 0xc1e8c1de, Offset: 0x124b
// Size: 0x9
function n2()
{
    n3();
}

// Namespace gscunittest_error
// Params 1
// Checksum 0xafc96fa4, Offset: 0x125c
// Size: 0x29
function n1( index )
{
    if ( index <= 0 )
    {
        n2();
        return;
    }
    
    n1( index - 1 );
}

// Namespace gscunittest_error
// Params 0
// Checksum 0x9df8cd77, Offset: 0x128d
// Size: 0x17
function nested()
{
    n1( 3 );
    util::test_print( "nested" );
}

// Namespace gscunittest_error
// Params 1
// Checksum 0xb2aa84c3, Offset: 0x12ac
// Size: 0x5d
function function_1f0b676f7bbb7b13( count )
{
    level endon( #"vm_execute_error_context" );
    new_count = count - 1;
    util::test_print( "vm_execute_error_context: " + count );
    
    if ( count <= 0 )
    {
        x = new_count + spawnstruct();
        util::test_print( "vm_execute_error_context: done" );
        return;
    }
}

// Namespace gscunittest_error
// Params 1
// Checksum 0x2fe6a092, Offset: 0x1311
// Size: 0x15
function function_1f0b686f7bbb7d46( count )
{
    function_1f0b676f7bbb7b13( count );
}

// Namespace gscunittest_error
// Params 1
// Checksum 0x8a3f84be, Offset: 0x132e
// Size: 0x15
function vm_execute_error_context( count )
{
    function_1f0b686f7bbb7d46( count );
}

// Namespace gscunittest_error
// Params 1
// Checksum 0x59b79eb2, Offset: 0x134b
// Size: 0x51
function function_8156fc615aa39e50( count )
{
    new_count = count - 1;
    util::test_print( "vm_execute_error_stack: " + count );
    
    if ( count <= 0 )
    {
        x = new_count + spawnstruct();
        util::test_print( "vm_execute_error_stack: done" );
        return;
    }
}

// Namespace gscunittest_error
// Params 1
// Checksum 0x2fe6a092, Offset: 0x13a4
// Size: 0x15
function function_8156ff615aa3a4e9( count )
{
    function_8156fc615aa39e50( count );
}

// Namespace gscunittest_error
// Params 1
// Checksum 0x687f7ec9, Offset: 0x13c1
// Size: 0x15
function vm_execute_error_stack( count )
{
    function_8156ff615aa3a4e9( count );
}

// Namespace gscunittest_error
// Params 0
// Checksum 0x2658f532, Offset: 0x13de
// Size: 0x14
function function_5455b14e60f68eae()
{
    vm_execute_error_context( 3 );
    vm_execute_error_stack( 3 );
}

// Namespace gscunittest_error
// Params 0
// Checksum 0x6d1f8e15, Offset: 0x13fa
// Size: 0x59
function main()
{
    util::test_begin( "Error" );
    params();
    types();
    wait_notify();
    switch_test();
    cond();
    is_true();
    builtin();
    nested();
    function_5455b14e60f68eae();
    util::test_end( "Error" );
}

