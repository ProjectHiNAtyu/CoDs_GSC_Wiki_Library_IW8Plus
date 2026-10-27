// scripts\autotests\gscunittest\test_gscunittest_ops.gsc  (hash_6b1a8780e4915610.gscc) (size: 18389 Bytes / 0x47d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb2ab4ba (3408573626)
// size ...... 18389 (0x47d5)
// includes .. 1   (offset: 0x3da5)
// strings ... 166 (offset: 0x3dad)
// dev strs .. 0   (offset: 0x47d5)
// exports ... 18  (offset: 0x2ddd)
// cseg ...... 0x7c8 + 0x2615 (0x2ddd)
// imports ... 27  (offset: 0x30ad)
// animtree1 . 0   (offset: 0x47d5)
// animtree2 . 0   (offset: 0x47d5)
#using scripts\autotests\autotests;

#namespace gscunittest_ops;

// Namespace gscunittest_ops
// Params 2
// Checksum 0x8a2ebf84, Offset: 0x7e6
// Size: 0x27
function plus( x, y )
{
    z = x + y;
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0x227fe86c, Offset: 0x816
// Size: 0x27
function minus( x, y )
{
    z = x - y;
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0xb3de7e8e, Offset: 0x846
// Size: 0x27
function mul( x, y )
{
    z = x * y;
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0xa71ae149, Offset: 0x876
// Size: 0x27
function div( x, y )
{
    z = x / y;
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0x7ea90eab, Offset: 0x8a6
// Size: 0x27
function function_20238e474103b6d7( x, y )
{
    z = x % y;
    return z;
}

// Namespace gscunittest_ops
// Params 4
// Checksum 0x138aa375, Offset: 0x8d6
// Size: 0x4b
function eq( x, y, xstr, ystr )
{
    z = x == y;
    
    if ( !isdefined( xstr ) )
    {
        xstr = x;
    }
    
    if ( !isdefined( ystr ) )
    {
        ystr = y;
    }
    
    return z;
}

// Namespace gscunittest_ops
// Params 4
// Checksum 0xeaa4aec6, Offset: 0x92a
// Size: 0x4b
function ne( x, y, xstr, ystr )
{
    z = x != y;
    
    if ( !isdefined( xstr ) )
    {
        xstr = x;
    }
    
    if ( !isdefined( ystr ) )
    {
        ystr = y;
    }
    
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0xc525dc26, Offset: 0x97e
// Size: 0x27
function lt( x, y )
{
    z = x < y;
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0xaf95fcd3, Offset: 0x9ae
// Size: 0x27
function le( x, y )
{
    z = x <= y;
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0x26d105ef, Offset: 0x9de
// Size: 0x27
function gt( x, y )
{
    z = x > y;
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0x4c61251e, Offset: 0xa0e
// Size: 0x27
function ge( x, y )
{
    z = x >= y;
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0x1b134aab, Offset: 0xa3e
// Size: 0x27
function sl( x, y )
{
    z = x << y;
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0xe11c77c6, Offset: 0xa6e
// Size: 0x27
function sr( x, y )
{
    z = x >> y;
    return z;
}

// Namespace gscunittest_ops
// Params 2
// Checksum 0x654ab72b, Offset: 0xa9e
// Size: 0x20, Type: bool
function limit( i, str )
{
    return i + "" == str;
}

// Namespace gscunittest_ops
// Params 0
// Checksum 0x30987902, Offset: 0xac7
// Size: 0x215f
function binary()
{
    level.autotests.test_runtime.t = 2;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Plus 1: ", plus( 0, 1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 99 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Plus 2: ", plus( 0, 1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 100 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Plus 3: ", plus( 0, -1 ), -1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 101 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Plus 4: ", plus( "hi", "bye" ), "hibye", "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 102 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Plus 5: ", plus( "hi", 0 ), "hi0", "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 103 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Plus 6: ", plus( 0, 1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 104 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Plus 7: ", plus( 0, -1 ), -1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 105 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Plus 8: ", plus( ( 0, 1, 2 ), ( 3, 4, 5 ) ), ( 3, 5, 7 ), "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 106 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Minus 1: ", minus( 1, 0 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 108 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Minus 2: ", minus( 0, 1 ), -1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 109 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Minus 3: ", minus( 1, 0 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 110 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Minus 4: ", minus( 0, 1 ), -1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 111 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Minus 5: ", minus( ( 3, 4, 5 ), ( 0, 1, 2 ) ), ( 3, 3, 3 ), "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 112 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mul 1: ", mul( 1, 1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 114 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mul 2: ", mul( 1, 0 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 115 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mul 3: ", mul( 0, 1 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 116 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mul 4: ", mul( 2, 3 ), 6, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 117 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mul 5: ", mul( 2, -1 ), -2, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 118 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mul 6: ", mul( 1, 1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 119 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mul 7: ", mul( 1, 2 ), 2, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 120 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mul 8: ", mul( 2, -3 ), -6, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 121 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mul 9: ", mul( ( 1, 2, 3 ), ( 3, 4, 5 ) ), ( 3, 8, 15 ), "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 122 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Div 1: ", div( 0, 1 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 124 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Div 2: ", div( 2, 1 ), 2, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 125 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Div 3: ", div( 9, 3 ), 3, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 126 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Div 4: ", div( 9, 2 ), 4.5, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 127 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Div 5: ", div( 4, -2 ), -2, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 128 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Div 6: ", div( 4, 1 ), 4, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 129 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Div 7: ", div( 5, -1 ), -5, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 130 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Div 8: ", div( ( 12, 9, 8 ), ( 4, 3, 2 ) ), ( 3, 3, 4 ), "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 131 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mod 1: ", function_20238e474103b6d7( 0, 1 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 133 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mod 2: ", function_20238e474103b6d7( 2, 1 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 134 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mod 3: ", function_20238e474103b6d7( 5, 2 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 135 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mod 4: ", function_20238e474103b6d7( 5.1, 3 ), 2.1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 136 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mod 5: ", function_20238e474103b6d7( 4, 2 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 137 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Mod 6: ", mod( -4, 2 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 138 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 1: ", eq( 0, 0 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 140 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 2: ", eq( 1, -1 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 141 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 3: ", eq( 3, 4 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 142 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 4: ", eq( 3, 3 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 143 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 5: ", eq( -1, -1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 144 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 6: ", eq( 0, 0 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 145 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 7: ", eq( "hi", "hi1" ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 146 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 8: ", eq( "hi", "hi" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 147 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 9: ", eq( ( 1, 2, 3 ), ( 1, 2, 4 ) ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 148 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 10: ", eq( ( 1, 2, 3 ), ( 1, 2, 3 ) ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 149 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 11: ", eq( &plus, &plus, "plus", "plus" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 150 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 12: ", eq( &plus, &minus, "plus", "minus" ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 151 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 13: ", eq( &allowfire, &allowfire, "AllowFire", "AllowFire" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 152 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Eq 14: ", eq( &allowfire, &allowjump, "AllowFire", "AllowJump" ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 153 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 1: ", ne( 0, 0 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 155 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 2: ", ne( 1, -1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 156 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 3: ", ne( 3, 4 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 157 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 4: ", ne( 3, 3 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 158 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 5: ", ne( -1, -1 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 159 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 6: ", ne( "hi", "hi1" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 160 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 7: ", ne( "hi", "hi" ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 161 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 8: ", ne( ( 1, 2, 3 ), ( 1, 2, 4 ) ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 162 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 9: ", ne( ( 1, 2, 3 ), ( 1, 2, 3 ) ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 163 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 10: ", ne( &plus, &plus, "plus", "plus" ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 164 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 11: ", ne( &plus, &minus, "plus", "minus" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 165 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 12: ", ne( &allowfire, &allowfire, "AllowFire", "AllowFire" ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 166 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "NE 13: ", ne( &allowfire, &allowjump, "AllowFire", "AllowJump" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 167 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LT 1: ", lt( 0, 0 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 169 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LT 2: ", lt( 0, -1 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 170 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LT 3: ", lt( 1, 2 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 171 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LT 4: ", lt( 2, 1 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 172 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LT 5: ", lt( 1, 2 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 173 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LT 6: ", lt( 1, 2 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 174 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LT 7: ", lt( 3, 4 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 175 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LT 8: ", lt( -3, 4 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 176 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LE 1: ", le( 0, 0 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 178 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LE 2: ", le( 0, -1 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 179 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LE 3: ", le( 1, 2 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 180 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LE 4: ", le( 2, 1 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 181 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LE 5: ", le( 1, 2 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 182 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LE 6: ", le( 1, 2 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 183 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LE 7: ", le( 3, 4 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 184 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "LE 8: ", le( -3, 4 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 185 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GT 1: ", gt( 0, 0 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 187 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GT 2: ", gt( 0, -1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 188 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GT 3: ", gt( 1, 2 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 189 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GT 4: ", gt( 2, 1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 190 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GT 5: ", gt( 1, 2 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 191 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GT 6: ", gt( 1, 2 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 192 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GT 7: ", gt( 3, 4 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 193 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GT 8: ", gt( -3, 4 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 194 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GE 1: ", ge( 0, 0 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 196 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GE 2: ", ge( 0, -1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 197 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GE 3: ", ge( 1, 2 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 198 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GE 4: ", ge( 2, 1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 199 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GE 5: ", ge( 1, 2 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 200 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GE 6: ", ge( 1, 2 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 201 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GE 7: ", ge( 3, 4 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 202 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "GE 8: ", ge( -3, 4 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 203 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "SL 1: ", sl( 0, 0 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 205 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "SL 2: ", sl( 1, 0 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 206 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "SL 3: ", sl( 1, 2 ), 4, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 207 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "SL 4: ", sl( 2, 2 ), 8, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 208 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "SR 1: ", sr( 0, 0 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 210 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "SR 2: ", sr( 1, 0 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 211 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "SR 3: ", sr( 1, 2 ), 0, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 212 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "SR 4: ", sr( 2, 1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 213 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "SR 5: ", sr( 4, 1 ), 2, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 214 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 1: ", limit( 0, "0" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 216 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 2: ", limit( 1, "1" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 217 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 3: ", limit( 255, "255" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 218 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 4: ", limit( -254, "-254" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 219 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 5: ", limit( -255, "-255" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 220 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 6: ", limit( 65535, "65535" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 221 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 7: ", limit( -65535, "-65535" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 222 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 8: ", limit( -65536, "-65536" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 223 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 9: ", limit( -2147483647, "-2147483647" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 224 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 10: ", limit( -2147483648, "-2147483648" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 225 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 11: ", limit( -2147483649, "-2147483649" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 226 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 12: ", limit( 2147483647, "2147483647" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 227 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 13: ", limit( 2147483648, "2147483648" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 228 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 14: ", limit( -4294967295, "-4294967295" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 229 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 15: ", limit( -4294967296, "-4294967296" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 230 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 16: ", limit( -4294967297, "-4294967297" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 231 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 17: ", limit( 4294967295, "4294967295" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 232 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 18: ", limit( 4294967296, "4294967296" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 233 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 19: ", limit( -9223372036854775807, "-9223372036854775807" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 234 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 20: ", limit( -9223372036854775807, "-9223372036854775807" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 235 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 21: ", limit( 9223372036854775806, "9223372036854775806" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 236 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Limit 22: ", limit( 9223372036854775807, "9223372036854775807" ), 1, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 237 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_ops
// Params 0
// Checksum 0x6d232645, Offset: 0x2c2e
// Size: 0x197
function types()
{
    x = 1;
    y = 2;
    z0 = x + y + x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Type 1: ", z0, 4, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 247 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    z1 = z0 + x + y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Type 2: ", z1, 7, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 250 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    z2 = z1 + 1;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Type 3: ", z2, 8, "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 253 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    z3 = z2 + "ok";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Type 4: ", z3, "8ok", "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 256 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    z4 = z3 + "bye";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Type 5: ", z4, "8okbye", "scripts/autotests/gscunittest/test_gscunittest_ops.gsc", 259 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_ops
// Params 0
// Checksum 0x3a24f26d, Offset: 0x2dcd
// Size: 0x10
function main()
{
    binary();
    types();
}

