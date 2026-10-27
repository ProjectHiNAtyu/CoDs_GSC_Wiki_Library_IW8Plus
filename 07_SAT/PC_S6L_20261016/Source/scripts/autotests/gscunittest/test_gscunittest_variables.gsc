// scripts\autotests\gscunittest\test_gscunittest_variables.gsc  (hash_7991a345ed9b2989.gscc) (size: 28595 Bytes / 0x6fb3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2f672a7a (795290234)
// size ...... 28595 (0x6fb3)
// includes .. 1   (offset: 0x6207)
// strings ... 186 (offset: 0x620f)
// dev strs .. 0   (offset: 0x6fb3)
// exports ... 12  (offset: 0x5203)
// cseg ...... 0x127c + 0x3f87 (0x5203)
// imports ... 23  (offset: 0x53e3)
// animtree1 . 0   (offset: 0x6fb3)
// animtree2 . 0   (offset: 0x6fb3)
#using scripts\autotests\autotests;

#namespace gscunittest_variables;

// Namespace gscunittest_variables
// Params 0
// Checksum 0x757ed4e0, Offset: 0x129a
// Size: 0x8be
function local()
{
    a = 0;
    b = 1;
    c = "hi";
    d = "bye" + 0;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "constant 1:", a, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 21 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "constant 2:", b, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 22 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "constant 3:", c, "hi", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 23 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "constant 4:", d, "bye0", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 24 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a = 0;
    b = a;
    b = 2;
    c = b;
    a = a;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "assign 1:", a, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 32 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "assign 2:", b, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 33 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "assign 3:", c, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 34 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "assign 4:", d, "bye0", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 35 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    c = 0;
    a = 1;
    b = 2;
    d = 3;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "constant 2 1:", a, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 42 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "constant 2 2:", b, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 43 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "constant 2 3:", c, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 44 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "constant 2 4:", d, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 45 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    v = ( 0, 0, 0 );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "v0", v, ( 0, 0, 0 ), "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 48 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    v = ( 1, 0, 0 );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "v1", v, ( 1, 0, 0 ), "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 51 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    v = ( 1, 2, 3.1 );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "v2", v, ( 1, 2, 3.1 ), "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 54 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    x = v;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x0 1:", x, v, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 57 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x0 2:", x, ( 1, 2, 3.1 ), "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 58 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    x = ( a, b, c );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x1 1:", x, ( a, b, c ), "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 61 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x1 2:", x, ( 1, 2, 0 ), "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 62 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    x = ( a, 0, c );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x1 3:", x, ( a, 0, c ), "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 65 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "x1 4:", x, ( 1, 0, 0 ), "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 66 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    u = undefined;
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "u", u, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 69 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    s0 = spawnstruct();
    s = s0;
    s = spawnstruct();
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "s0", isstruct( s0 ), 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 74 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "s", isstruct( s ), 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 75 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "s0 != s", s0, s, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 76 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a0 = [];
    a1 = a0;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "a0", isarray( a0 ), 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 80 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "a1", isarray( a1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 81 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "a0 size", a0.size, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 82 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "a1 size", a1.size, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 83 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a0 = [ 1, 2, 3 ];
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "a0 size", a0.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 86 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "a1 size", a1.size, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 87 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "a1 element", a0[ 0 ], 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 88 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "a1 element", a0[ 1 ], 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 89 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "a1 element", a0[ 2 ], 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 90 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_variables
// Params 0
// Checksum 0x3fff78f2, Offset: 0x1b60
// Size: 0x143
function defines()
{
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "DEF_STR", "foo", "foo", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 95 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "DEF_INT", 22, 22, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 96 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "DEF_VEC", ( 1, 2, 3 ), ( 1, 2, 3 ), "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 97 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "DEF_EXPR", 23, 23, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 98 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "DEF_MIX_EXPR", "foo" + 0, "foo0", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 99 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_variables
// Params 0
// Checksum 0x854f809d, Offset: 0x1cab
// Size: 0x485
function local_array()
{
    a = [];
    a[ 0 ] = 0;
    a[ 1 ] = 2;
    a[ 2 ] = "bye";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index: size", a.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 111 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index: val", arraycompare( a, [ 0, 2, "bye" ] ), 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 112 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    b = a;
    b[ 0 ] = 1;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index a: size", a.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 116 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index b: size", b.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 117 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index a: val", arraycompare( a, [ 1, 2, "bye" ] ), 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 118 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index b: val", arraycompare( b, [ 1, 2, "bye" ] ), 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 119 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a[ 0 ] = 0;
    b = arraycopy( a );
    b[ 0 ] = 9;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index a: size", a.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 124 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index b: size", b.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 125 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index a: val", arraycompare( a, [ 0, 2, "bye" ] ), 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 126 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index b: val", arraycompare( b, [ 9, 2, "bye" ] ), 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 127 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a[ 0 ]++;
    a[ "foo" ] = 5;
    a[ "bar" ] = 6;
    a[ "baz" ] = "no";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array string: size", a.size, 6, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 134 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index(after): val 1:", a[ "foo" ], 5, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 135 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index(after): val 2:", a[ "bar" ], 6, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 136 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local array index(after): val 3:", a[ "baz" ], "no", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 137 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a[ @"dvar" ] = 8;
    a[ #"xhash" ] = 9;
    InvalidOpCode( 0x58, 10 );
    // Unknown operator ( 0x58, t11, Black Ops 7 )
}

// Namespace gscunittest_variables
// Params 0
// Checksum 0x1581d893, Offset: 0x26be
// Size: 0x70a
function level_array()
{
    level.a = [];
    level.a[ 0 ] = 0;
    level.a[ 1 ] = 2;
    level.a[ 2 ] = "bye";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array index: size", level.a.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 199 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array index: val", arraycompare( level.a, [ 0, 2, "bye" ] ), 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 200 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.a[ 0 ]++;
    level.a[ "foo" ] = 5;
    level.a[ "bar" ] = 6;
    level.a[ "baz" ] = "no";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array string: size", level.a.size, 6, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 208 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array index(after): val 1:", level.a[ "foo" ], 5, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 209 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array index(after): val 2:", level.a[ "bar" ], 6, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 210 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array index(after): val 3:", level.a[ "baz" ], "no", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 211 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    b = [ 1, 2, "bye", 5, 6, "no" ];
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array size", level.a.size, b.size, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 214 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    index = 0;
    
    foreach ( v in level.a )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array foreach " + index + ": ", v, b[ index ], "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 218 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        index++;
    }
    
    level.a[ 2 ] = undefined;
    level.a[ "bar" ] = undefined;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array remove index: size", level.a.size, 4, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 224 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    b = [ 1, 2, 5, "no" ];
    index = 0;
    
    foreach ( v in level.a )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array foreach remove " + index + ": ", v, b[ index ], "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 229 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        index++;
    }
    
    level.a[ "nest" ][ 0 ][ 0 ] = 0;
    level.a[ "nest" ][ 0 ][ 1 ] = 1;
    level.a[ "nest" ][ 1 ][ 0 ] = "yes";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array nest: 1:", level.a[ "nest" ][ 0 ][ 0 ], 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 237 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array nest: 2:", level.a[ "nest" ][ 0 ][ 1 ], 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 238 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array nest: 3:", level.a[ "nest" ][ 1 ][ 0 ], "yes", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 239 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array nest: size 1:", level.a.size, 5, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 240 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array nest: size 2:", level.a[ "nest" ].size, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 241 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array nest: size 3:", level.a[ "nest" ][ 0 ].size, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 242 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level array nest: size 4:", level.a[ "nest" ][ 1 ].size, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 243 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.a = undefined;
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "level array clear: IsDefined: ", level.a, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 247 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_variables
// Params 0
// Checksum 0xd80e075c, Offset: 0x2dd0
// Size: 0xa90
function local_object()
{
    s = spawnstruct();
    s.a = 0;
    s.b = 1;
    s.c = "hi";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "object constant: 1:", s.a, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 260 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "object constant: 2:", s.b, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 261 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "object constant: 3:", s.c, "hi", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 262 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    s.a = 0;
    s.b = s.a;
    s.b = 2;
    s.c = s.b;
    s.a = s.a;
    s.a++;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object assign: 1:", s.a, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 271 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object assign: 2:", s.b, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 272 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object assign: 3:", s.c, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 273 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    s.s = spawnstruct();
    x = s.s;
    s.s.a = 0;
    s.s.b = 1;
    s.s.c = "hi";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object nested: 1:", s.s.a, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 283 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object nested: 2:", s.s.b, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 284 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object nested: 3:", s.s.c, "hi", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 285 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "local object clear before: IsDefined: s.s:", s.s, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 287 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    s.s = undefined;
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "local object clear after: IsDefined: s.s: ", s.s, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 289 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "local object still define after: IsDefined: x:", x, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 291 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    s.a = [];
    s.a[ 0 ] = 0;
    s.a[ 1 ] = 2;
    s.a[ 2 ] = "bye";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array index: size: ", s.a.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 298 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array index: val: 1:", s.a[ 0 ], 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 299 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array index: val: 2:", s.a[ 1 ], 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 300 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array index: val: 3:", s.a[ 2 ], "bye", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 301 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    s.a[ 0 ]++;
    s.a[ "foo" ] = 5;
    s.a[ "bar" ] = 6;
    s.a[ "baz" ] = "no";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array string: size: ", s.a.size, 6, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 309 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array string:  val: 1:", s.a[ "foo" ], 5, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 310 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array string:  val: 2:", s.a[ "bar" ], 6, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 311 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array string:  val: 3:", s.a[ "baz" ], "no", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 312 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array index(after): val: 1:", s.a[ 0 ], 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 313 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array index(after): val: 2:", s.a[ 1 ], 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 314 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array index(after): val: 3:", s.a[ 2 ], "bye", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 315 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    b = [ 1, 2, "bye", 5, 6, "no" ];
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array size", s.a.size, b.size, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 318 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    index = 0;
    
    foreach ( v in s.a )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array foreach " + index + ": ", v, b[ index ], "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 322 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        index++;
    }
    
    s.a[ 2 ] = undefined;
    s.a[ "bar" ] = undefined;
    b = [ 1, 2, 5, "no" ];
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array remove index: size: ", s.a.size, b.size, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 329 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    index = 0;
    
    foreach ( v in s.a )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local object array foreach remove " + index + ": ", v, b[ index ], "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 333 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        index++;
    }
    
    s.a = undefined;
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "local object array clear: IsDefined: ", s.a, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 338 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_variables
// Params 0
// Checksum 0xadaae73, Offset: 0x3868
// Size: 0xbe7
function level_object()
{
    level.s = spawnstruct();
    level.s.a = 0;
    level.s.b = 1;
    level.s.c = "hi";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object constant: 1:", level.s.a, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 351 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object constant: 2:", level.s.b, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 352 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object constant: 3:", level.s.c, "hi", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 353 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.s.a++;
    level.s.b = level.s.a;
    level.s.b = 2;
    level.s.c = level.s.b;
    level.s.a = level.s.a;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object assign: 1:", level.s.a, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 361 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object assign: 2:", level.s.b, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 362 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object assign: 3:", level.s.c, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 363 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.s.s = spawnstruct();
    level.s.s.a = 0;
    level.s.s.b = 1;
    level.s.s.c = "hi";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object nested: 1:", level.s.s.a, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 371 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object nested: 2:", level.s.s.b, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 372 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object nested: 3:", level.s.s.c, "hi", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 373 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "level object clear before: IsDefined: s.s:", level.s.s, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 375 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.s.s = undefined;
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "level object clear after: IsDefined: s.s: ", level.s.s, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 377 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.s.a = [];
    level.s.a[ 0 ] = 0;
    level.s.a[ 1 ] = 2;
    level.s.a[ 2 ] = "bye";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array index: size: ", level.s.a.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 384 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array index: val: 1:", level.s.a[ 0 ], 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 385 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array index: val: 2:", level.s.a[ 1 ], 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 386 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array index: val: 3:", level.s.a[ 2 ], "bye", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 387 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.s.a[ 0 ]++;
    level.s.a[ "foo" ] = 5;
    level.s.a[ "bar" ] = 6;
    level.s.a[ "baz" ] = "no";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array string: size: ", level.s.a.size, 6, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 394 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array string:  val: 1:", level.s.a[ "foo" ], 5, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 395 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array string:  val: 2:", level.s.a[ "bar" ], 6, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 396 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array string:  val: 3:", level.s.a[ "baz" ], "no", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 397 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array index(after): val: 1:", level.s.a[ 0 ], 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 398 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array index(after): val: 2:", level.s.a[ 1 ], 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 399 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array index(after): val: 3:", level.s.a[ 2 ], "bye", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 400 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    b = [ 1, 2, "bye", 5, 6, "no" ];
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array size", level.s.a.size, b.size, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 403 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    index = 0;
    
    foreach ( v in level.s.a )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array foreach " + index + ": ", v, b[ index ], "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 407 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        index++;
    }
    
    level.s.a[ 2 ] = undefined;
    level.s.a[ "bar" ] = undefined;
    b = [ 1, 2, 5, "no" ];
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array remove index: size: ", level.s.a.size, b.size, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 414 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    index = 0;
    
    foreach ( v in level.s.a )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level object array foreach remove " + index + ": ", v, b[ index ], "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 418 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        index++;
    }
    
    level.s.a = undefined;
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "level object array clear: IsDefined: ", level.s.a, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 423 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_variables
// Params 0
// Checksum 0xc0fa58c, Offset: 0x4457
// Size: 0x4e4
function local_combo()
{
    a[ 0 ] = spawnstruct();
    a[ 0 ].a = 0;
    a[ 0 ].b = 1;
    a[ 0 ].c = "hi";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 1: size", a.size, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 433 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 1: val 1:", a[ 0 ].a, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 434 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 1: val 2:", a[ 0 ].b, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 435 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 1: val 3:", a[ 0 ].c, "hi", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 436 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a[ 1 ] = spawnstruct();
    a[ 1 ].a[ "nest" ] = spawnstruct();
    a[ 1 ].a[ "nest" ].a = 5;
    a[ 1 ].a[ "nest" ].b = 6;
    a[ 1 ].a[ "nest" ].c = "no";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 2: size", a.size, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 445 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 2: val 1:", a[ 1 ].a[ "nest" ].a, 5, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 446 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 2: val 2:", a[ 1 ].a[ "nest" ].b, 6, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 447 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 2: val 3:", a[ 1 ].a[ "nest" ].c, "no", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 448 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    a[ 2 ][ 0 ][ 0 ] = spawnstruct();
    a[ 2 ][ 0 ][ 0 ].a = 10;
    a[ 2 ][ 0 ][ 0 ].b = 11;
    a[ 2 ][ 0 ][ 1 ] = "yes";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 3: size 1:", a.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 455 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 3: size 2:", a[ 2 ].size, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 456 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 3: size 3:", a[ 2 ][ 0 ].size, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 457 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 3: val 1:", a[ 2 ][ 0 ][ 0 ].a, 10, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 458 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 3: val 2:", a[ 2 ][ 0 ][ 0 ].b, 11, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 459 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "local combo 3: val 3:", a[ 2 ][ 0 ][ 1 ], "yes", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 460 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_variables
// Params 0
// Checksum 0xeb5783a9, Offset: 0x4943
// Size: 0x5b1
function level_combo()
{
    level.a[ 0 ] = spawnstruct();
    level.a[ 0 ].a = 0;
    level.a[ 0 ].b = 1;
    level.a[ 0 ].c = "hi";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 1: size", level.a.size, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 470 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 1: val 1:", level.a[ 0 ].a, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 471 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 1: val 2:", level.a[ 0 ].b, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 472 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 1: val 3:", level.a[ 0 ].c, "hi", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 473 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.a[ 1 ] = spawnstruct();
    level.a[ 1 ].a[ "nest" ] = spawnstruct();
    level.a[ 1 ].a[ "nest" ].a = 5;
    level.a[ 1 ].a[ "nest" ].b = 6;
    level.a[ 1 ].a[ "nest" ].c = "no";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 2: size", level.a.size, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 482 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 2: val 1:", level.a[ 1 ].a[ "nest" ].a, 5, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 483 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 2: val 2:", level.a[ 1 ].a[ "nest" ].b, 6, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 484 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 2: val 3:", level.a[ 1 ].a[ "nest" ].c, "no", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 485 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.a[ 2 ][ 0 ][ 0 ] = spawnstruct();
    level.a[ 2 ][ 0 ][ 0 ].a = 10;
    level.a[ 2 ][ 0 ][ 0 ].b = 11;
    level.a[ 2 ][ 0 ][ 1 ] = "yes";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 3: size 1:", level.a.size, 3, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 492 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 3: size 2:", level.a[ 2 ].size, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 493 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 3: size 3:", level.a[ 2 ][ 0 ].size, 2, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 494 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 3: val 1:", level.a[ 2 ][ 0 ][ 0 ].a, 10, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 495 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 3: val 2:", level.a[ 2 ][ 0 ][ 0 ].b, 11, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 496 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "level combo 3: val 3:", level.a[ 2 ][ 0 ][ 1 ], "yes", "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 497 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_variables
// Params 2
// Checksum 0x2e705180, Offset: 0x4efc
// Size: 0x30
function is_true_print( val, name )
{
    b = istrue( val );
    
    if ( !isdefined( b ) )
    {
        b = "undefined";
    }
}

// Namespace gscunittest_variables
// Params 0
// Checksum 0xeb74629b, Offset: 0x4f34
// Size: 0x286
function is_true()
{
    u = undefined;
    int_false = 0;
    int_true = 1;
    float_false = 0;
    float_true = 2;
    is_true_print( u, "u" );
    is_true_print( int_false, "int_false" );
    is_true_print( int_true, "int_true" );
    is_true_print( float_false, "float_false" );
    is_true_print( float_true, "float_true" );
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "u 1:", u, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 524 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "u 2:", u, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 525 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "u 3:", u, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 526 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "int_false", int_false, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 527 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "int_true", int_true, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 528 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "float_false", float_false, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 529 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "float_true type check: 1:", float_true, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 530 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "float_true type check: 2:", float_true, 0, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 531 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "float_true condition check:", !!float_true, 1, "scripts/autotests/gscunittest/test_gscunittest_variables.gsc", 532 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_variables
// Params 0
// Checksum 0x963f0a63, Offset: 0x51c2
// Size: 0x41
function main()
{
    local();
    defines();
    local_array();
    level_array();
    local_object();
    level_object();
    local_combo();
    level_combo();
    is_true();
}

