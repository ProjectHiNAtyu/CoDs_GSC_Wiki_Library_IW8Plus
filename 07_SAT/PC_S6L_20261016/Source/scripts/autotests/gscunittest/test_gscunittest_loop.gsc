// scripts\autotests\gscunittest\test_gscunittest_loop.gsc  (hash_5b8d4951d00a1bd4.gscc) (size: 4030 Bytes / 0xfbe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x165df54 (23453524)
// size ...... 4030 (0xfbe)
// includes .. 1   (offset: 0xe7e)
// strings ... 20  (offset: 0xe86)
// dev strs .. 0   (offset: 0xfbe)
// exports ... 8   (offset: 0xad6)
// cseg ...... 0x21f + 0x8b7 (0xad6)
// imports ... 12  (offset: 0xc16)
// animtree1 . 0   (offset: 0xfbe)
// animtree2 . 0   (offset: 0xfbe)
#using scripts\autotests\autotests;

#namespace gscunittest_loop;

// Namespace gscunittest_loop
// Params 0
// Checksum 0xdb43cfb2, Offset: 0x23d
// Size: 0x190
function for_simple()
{
    b = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
    
    for ( i = 0; i < 10 ; i++ )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "for simple: " + i, i, b[ i ], "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 12 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    x = 0;
    
    for ( i = 0; i < 10 && x < 20 ; i++ )
    {
        x += i;
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "for 2 cond 1:", i, 7, "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 20 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "for 2 cond 2:", x, 21, "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 21 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    for ( i = 0;  ; i++ )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "for empty: " + i, i, b[ i ], "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 27 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        if ( i >= 9 )
        {
            break;
        }
    }
}

// Namespace gscunittest_loop
// Params 1
// Checksum 0xe3555ce7, Offset: 0x3d5
// Size: 0x11f
function foreach_shared_variables( x )
{
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "foreach_shared_variables", x, "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 40 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    b = [ 1, 2, 3, 4 ];
    index = 0;
    
    foreach ( a in x )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "foreach_shared_variables: " + a, a, b[ index ], "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 45 );
        
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
}

// Namespace gscunittest_loop
// Params 0
// Checksum 0x5fd14827, Offset: 0x4fc
// Size: 0x112
function foreach_mutable_key()
{
    a = [ 1, 2, 3, 4 ];
    
    foreach ( x, y in a )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "foreach_mutable_key: " + y, y, a[ x ], "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 56 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        x += 1;
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "foreach_mutable_key: mut:" + x, x, y, "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 58 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
}

// Namespace gscunittest_loop
// Params 0
// Checksum 0x2f7d6b4e, Offset: 0x616
// Size: 0x1dc
function foreach_simple()
{
    a = [ 1, 2, 3, 4 ];
    index = 0;
    
    foreach ( x in a )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "foreach_simple: " + x, x, a[ index ], "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 69 );
        
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
    
    index = 0;
    
    foreach ( x, y in a )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "foreach_simple(x,y): 1: " + x + " " + y, x, index, "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 76 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "foreach_simple(x,y): 2: " + x + " " + y, y, a[ index ], "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 77 );
        
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
    
    foreach_shared_variables( a );
    foreach_mutable_key();
}

// Namespace gscunittest_loop
// Params 0
// Checksum 0x9fd0eb44, Offset: 0x7fa
// Size: 0x195
function while_simple()
{
    i = 0;
    b = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
    
    while ( i < 10 )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "while simple: " + i, i, b[ i ], "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 91 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        i++;
    }
    
    x = 0;
    
    for ( i = 0; i < 10 && x < 20 ; i++ )
    {
        x += i;
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "while 2 cond: i:", i, 7, "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 102 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "while 2 cond: x:", x, 21, "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 103 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    for ( i = 0; true ; i++ )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "while true: " + i, i, b[ i ], "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 108 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        if ( i >= 9 )
        {
            break;
        }
    }
}

// Namespace gscunittest_loop
// Params 0
// Checksum 0x59b8a91, Offset: 0x997
// Size: 0x115
function loop_control()
{
    for ( i = 0; i < 1 ; i++ )
    {
        if ( i % 1 )
        {
            sum = 1;
        }
        else
        {
            sum = 0;
        }
        
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "for var exposed: sum: " + sum, sum, 0, "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 131 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    for ( ;; )
    {
        q = 1;
        break;
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "for break: q: " + q, q, 1, "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 139 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    while ( true )
    {
        z = 2;
        break;
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "while break: z: " + z, z, 2, "scripts/autotests/gscunittest/test_gscunittest_loop.gsc", 146 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_loop
// Params 0
// Checksum 0x2c790f5c, Offset: 0xab4
// Size: 0x22
function main()
{
    for_simple();
    waitframe();
    foreach_simple();
    waitframe();
    while_simple();
    waitframe();
    loop_control();
    waitframe();
}

