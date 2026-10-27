// scripts\autotests\gscunittest\test_gscunittest_cond.gsc  (hash_5a35cebc9b1c5c5a.gscc) (size: 11024 Bytes / 0x2b10 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa428ef04 (2754146052)
// size ...... 11024 (0x2b10)
// includes .. 1   (offset: 0x2378)
// strings ... 119 (offset: 0x2380)
// dev strs .. 0   (offset: 0x2b10)
// exports ... 4   (offset: 0x1dd8)
// cseg ...... 0x865 + 0x1573 (0x1dd8)
// imports ... 7   (offset: 0x1e78)
// animtree1 . 0   (offset: 0x2b10)
// animtree2 . 0   (offset: 0x2b10)
#using scripts\autotests\autotests;

#namespace gscunittest_cond;

// Namespace gscunittest_cond
// Params 0
// Checksum 0xb42d18cd, Offset: 0x883
// Size: 0xd3f
function vars()
{
    x = 0;
    y = 1;
    a = x < y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x < y: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 17 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( x < y );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!( x < y ): ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 21 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!x: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 24 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !x + y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!x + y: ", a, 2, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 27 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( !x + y );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(!x + y): ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 30 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x != y && y != x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "(x != y) && (y != x): ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 33 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( x != y ) && !( y != x );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(x != y) && !(y != x): ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 36 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( !( x != y ) && !( y != x ) );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(!(x != y) && !(y != x)): ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 39 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x != y || y != x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "(x != y) || (y != x): ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 42 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( x != y ) || !( y != x );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(x != y) || !(y != x): ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 45 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( !( x != y ) || !( y != x ) );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(!(x != y) || !(y != x)): ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 48 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 1 && x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ONE && x: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 52 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x && 1;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x && ONE: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 55 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 1 || x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ONE || x: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 58 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x || 1;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x || ONE: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 61 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 2 && x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "TWOF && x: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 64 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x && 2;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x && TWOF: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 67 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 2 || x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "TWOF || x: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 70 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x || 2;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x || TWOF: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 73 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x && 0;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x && F: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 76 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 0 && x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "F && x: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 79 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x || 0;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x || F: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 82 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 0 || x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "F || x: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 85 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 0 && x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!ONE && x: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 89 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x && 0;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x && !ONE: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 92 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 0 || x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!ONE || x: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 95 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x || 0;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x || !ONE: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 98 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !true && x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!TWOF && x: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 101 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x && !true;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x && !TWOF: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 104 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !true || x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!TWOF || x: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 107 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x || !true;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x || !TWOF: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 110 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x && 1;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x && !F: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 113 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 1 && x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!F && x: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 116 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x || 1;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x || !F: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 119 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 1 || x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!F || x: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 122 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x && y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x && y: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 126 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !x && y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!x && y: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 129 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x && !y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x && !y: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 132 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !x && !y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!x && !y: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 135 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x || y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x || y: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 139 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !x || y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!x || y: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 142 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = x || !y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x || !y: ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 145 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !x || !y;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!x || !y: ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 148 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( x && y );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(x && y): ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 152 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( !x && y );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(!x && y): ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 155 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( x && !y );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(x && !y): ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 158 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( !x && !y );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(!x && !y): ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 161 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( x || y );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(x || y): ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 165 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( !x || y );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(!x || y): ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 168 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( x || !y );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(x || !y): ", a, 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 171 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = !( !x || !y );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "!(!x || !y): ", a, 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 174 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_cond
// Params 0
// Checksum 0x13ca3dc7, Offset: 0x15ca
// Size: 0x7f6
function iftest()
{
    x = 0;
    y = 1;
    
    if ( x )
    {
        autotests::function_d84657f448aaeef6( "x: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 184 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 188 );
    }
    
    if ( y )
    {
        autotests::function_d84657f448aaeef6( "y: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 193 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "y: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 197 );
    }
    
    if ( !x )
    {
        autotests::function_d84657f448aaeef6( "!x: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 202 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!x: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 206 );
    }
    
    if ( !y )
    {
        autotests::function_d84657f448aaeef6( "!y: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 211 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!y: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 215 );
    }
    
    if ( !x + y )
    {
        autotests::function_d84657f448aaeef6( "!x + y: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 220 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!x + y: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 224 );
    }
    
    if ( !( !x + y ) )
    {
        autotests::function_d84657f448aaeef6( "!(!x + y): true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 229 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!(!x + y): false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 233 );
    }
    
    if ( !( !( x < 0 ) + y ) )
    {
        autotests::function_d84657f448aaeef6( "!(!(x < 0) + y): true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 238 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!(!(x < 0) + y): false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 242 );
    }
    
    if ( !( !( x < 0 ) != y ) )
    {
        autotests::function_d84657f448aaeef6( "!(!(x < 0) != y): true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 247 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!(!(x < 0) != y): false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 251 );
    }
    
    if ( true )
    {
        autotests::function_d84657f448aaeef6( "ONE: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 257 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "ONE: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 261 );
    }
    
    if ( false )
    {
        autotests::function_d84657f448aaeef6( "!ONE: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 266 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!ONE: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 270 );
    }
    
    if ( false )
    {
        autotests::function_d84657f448aaeef6( "F: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 275 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "F: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 279 );
    }
    
    if ( true )
    {
        autotests::function_d84657f448aaeef6( "!F: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 284 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!F: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 288 );
    }
    
    if ( x && 1 )
    {
        autotests::function_d84657f448aaeef6( "x && ONE: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 293 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x && ONE: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 297 );
    }
    
    if ( !x && 1 )
    {
        autotests::function_d84657f448aaeef6( "!x && ONE: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 302 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!x && ONE: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 306 );
    }
    
    if ( x && 0 )
    {
        autotests::function_d84657f448aaeef6( "x && !ONE: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 311 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x && !ONE: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 315 );
    }
    
    if ( !x && 0 )
    {
        autotests::function_d84657f448aaeef6( "!x && !ONE: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 320 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!x && !ONE: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 324 );
    }
    
    if ( x || 1 )
    {
        autotests::function_d84657f448aaeef6( "x || ONE: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 329 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x || ONE: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 333 );
    }
    
    if ( !x || 1 )
    {
        autotests::function_d84657f448aaeef6( "!x || ONE: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 338 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!x || ONE: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 342 );
    }
    
    if ( x || 0 )
    {
        autotests::function_d84657f448aaeef6( "x || !ONE: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 347 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x || !ONE: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 351 );
    }
    
    if ( !x || 0 )
    {
        autotests::function_d84657f448aaeef6( "!x || !ONE: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 356 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!x || !ONE: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 360 );
    }
    
    if ( x && y )
    {
        autotests::function_d84657f448aaeef6( "x && y: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 366 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x && y: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 370 );
    }
    
    if ( !x && y )
    {
        autotests::function_d84657f448aaeef6( "!x && y: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 375 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x && y: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 379 );
    }
    
    if ( x && !y )
    {
        autotests::function_d84657f448aaeef6( "x && !y: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 384 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x && !y: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 388 );
    }
    
    if ( !x && !y )
    {
        autotests::function_d84657f448aaeef6( "!x && !y: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 393 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!x & !y: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 397 );
    }
    
    if ( x || y )
    {
        autotests::function_d84657f448aaeef6( "x || y: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 403 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x || y: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 407 );
    }
    
    if ( !x || y )
    {
        autotests::function_d84657f448aaeef6( "!x || y: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 412 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x || y: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 416 );
    }
    
    if ( x || !y )
    {
        autotests::function_d84657f448aaeef6( "x || !y: true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 421 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "x || !y: false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 425 );
    }
    
    if ( !x || !y )
    {
        autotests::function_d84657f448aaeef6( "!x || !y: true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 430 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!x & !y: false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 434 );
    }
    
    if ( !( x && y ) )
    {
        autotests::function_d84657f448aaeef6( "!(x && y): true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 440 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!(x && y): false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 444 );
    }
    
    if ( !( !x && y ) )
    {
        autotests::function_d84657f448aaeef6( "!(!x && y): true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 449 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!(x && y): false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 453 );
    }
    
    if ( !( x && !y ) )
    {
        autotests::function_d84657f448aaeef6( "!(x && !y): true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 458 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!(x && !y): false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 462 );
    }
    
    if ( !( !x && !y ) )
    {
        autotests::function_d84657f448aaeef6( "!(!x && !y): true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 467 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!(!x && !y): false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 471 );
    }
    
    if ( !( x || y ) )
    {
        autotests::function_d84657f448aaeef6( "!(x || y): true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 477 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!(x || y): false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 481 );
    }
    
    if ( !( !x || y ) )
    {
        autotests::function_d84657f448aaeef6( "!(!x || y): true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 486 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!(x || y): false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 490 );
    }
    
    if ( !( x || !y ) )
    {
        autotests::function_d84657f448aaeef6( "!(x || !y): true", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 495 );
    }
    else
    {
        autotests::function_d84657f448aaeef6( "!(x || !y): false", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 499 );
    }
    
    if ( !( !x || !y ) )
    {
        autotests::function_d84657f448aaeef6( "!(!x || !y): true", 0, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 504 );
        return;
    }
    
    autotests::function_d84657f448aaeef6( "!(!x || !y): false", 1, "scripts/autotests/gscunittest/test_gscunittest_cond.gsc", 508 );
}

// Namespace gscunittest_cond
// Params 0
// Checksum 0xd62f5581, Offset: 0x1dc8
// Size: 0x10
function main()
{
    vars();
    iftest();
}

