// scripts\autotests\gscunittest\test_gscunittest_call.gsc  (hash_7cab2632a76cc4a6.gscc) (size: 5550 Bytes / 0x15ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1aba620c (448422412)
// size ...... 5550 (0x15ae)
// includes .. 1   (offset: 0x13ce)
// strings ... 27  (offset: 0x13d6)
// dev strs .. 0   (offset: 0x15ae)
// exports ... 14  (offset: 0xc06)
// cseg ...... 0x27a + 0x98c (0xc06)
// imports ... 43  (offset: 0xe36)
// animtree1 . 0   (offset: 0x15ae)
// animtree2 . 0   (offset: 0x15ae)
#using scripts\autotests\autotests;

#namespace gscunittest_call;

// Namespace gscunittest_call
// Params 0
// Checksum 0x60d86c61, Offset: 0x298
// Size: 0x17
function noargs()
{
    autotests::function_d84657f448aaeef6( "noargs", 1, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 9 );
}

// Namespace gscunittest_call
// Params 1
// Checksum 0x7915af39, Offset: 0x2b7
// Size: 0xd8
function onearg( a )
{
    if ( !isdefined( a ) )
    {
        var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "onearg: undefined", a, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 17 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        return;
    }
    
    if ( isnumber( a ) )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "onearg: 1: " + a, a, 1, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 21 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        return;
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "onearg: 2: " + a, a, "hi", "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 25 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_call
// Params 3
// Checksum 0x7aeba620, Offset: 0x397
// Size: 0x14a
function multiarg( a, b, c )
{
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "multiarg: a:", a, 1, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 32 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( isnumber( b ) )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "multiarg: 1: b:", b, 2, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 35 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "multiarg: 1: c:", c, 3, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 36 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        return;
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "multiarg: 2: b:", b, "hi", "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 40 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "multiarg: 2: c:", c, 2, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 41 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_call
// Params 1
// Checksum 0x34d4dd98, Offset: 0x4e9
// Size: 0x65
function recurse_internal( n )
{
    if ( n > 0 )
    {
        return recurse_internal( n - 1 );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "recurse_internal: end:", n, 0, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 54 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    return n;
}

// Namespace gscunittest_call
// Params 1
// Checksum 0xabada66d, Offset: 0x556
// Size: 0x56
function recurse( n )
{
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "recurse_internal: start:", n, 10, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 62 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    recurse_internal( n );
}

// Namespace gscunittest_call
// Params 1
// Checksum 0x944875c9, Offset: 0x5b4
// Size: 0x60
function function_71721577dab8a1ee( count )
{
    level endon( #"vm_execute_context" );
    
    if ( count <= 0 )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "vm_execute_context: done", count, 0, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 76 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        return;
    }
}

// Namespace gscunittest_call
// Params 1
// Checksum 0xcb5a4b5e, Offset: 0x61c
// Size: 0x15
function function_71721477dab89fbb( count )
{
    function_71721577dab8a1ee( count );
}

// Namespace gscunittest_call
// Params 1
// Checksum 0x7a8e8ebe, Offset: 0x639
// Size: 0x15
function vm_execute_context( count )
{
    function_71721477dab89fbb( count );
}

// Namespace gscunittest_call
// Params 1
// Checksum 0xca988d33, Offset: 0x656
// Size: 0x54
function function_2d8c9baee2b14141( count )
{
    if ( count <= 0 )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "vm_execute_stack: done", count, 0, "scripts/autotests/gscunittest/test_gscunittest_call.gsc", 100 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        return;
    }
}

// Namespace gscunittest_call
// Params 1
// Checksum 0xcb5a4b5e, Offset: 0x6b2
// Size: 0x15
function function_2d8c98aee2b13aa8( count )
{
    function_2d8c9baee2b14141( count );
}

// Namespace gscunittest_call
// Params 1
// Checksum 0x875bb1ce, Offset: 0x6cf
// Size: 0x15
function vm_execute_stack( count )
{
    function_2d8c98aee2b13aa8( count );
}

// Namespace gscunittest_call
// Params 0
// Checksum 0x756cedea, Offset: 0x6ec
// Size: 0x14
function function_54c8deb2856c8347()
{
    vm_execute_context( 3 );
    vm_execute_stack( 3 );
}

// Namespace gscunittest_call
// Params 0
// Checksum 0xb116aef1, Offset: 0x708
// Size: 0x4fe
function main()
{
    level.autotests.test_runtime.testsection = "Call";
    noargs();
    onearg( 1 );
    onearg( "hi" );
    onearg();
    multiarg( 1, 2, 3 );
    multiarg( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Method";
    s = spawnstruct();
    s noargs();
    s onearg( 1 );
    s onearg( "hi" );
    s onearg();
    s multiarg( 1, 2, 3 );
    s multiarg( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Thread";
    thread noargs();
    thread onearg( 1 );
    thread onearg( "hi" );
    thread onearg();
    thread multiarg( 1, 2, 3 );
    thread multiarg( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Method Thread";
    s thread noargs();
    s thread onearg( 1 );
    s thread onearg( "hi" );
    s thread onearg();
    s thread multiarg( 1, 2, 3 );
    s thread multiarg( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Child Thread";
    childthread noargs();
    childthread onearg( 1 );
    childthread onearg( "hi" );
    childthread onearg();
    childthread multiarg( 1, 2, 3 );
    childthread multiarg( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Method Child Thread";
    s childthread noargs();
    s childthread onearg( 1 );
    s childthread onearg( "hi" );
    s childthread onearg();
    s childthread multiarg( 1, 2, 3 );
    s childthread multiarg( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Function Pointer";
    var_d765ade5b13fa459 = &noargs;
    var_f616c8a9f2016b5f = &onearg;
    var_ade8a6c294ffd344 = &multiarg;
    [[ var_d765ade5b13fa459 ]]();
    [[ var_f616c8a9f2016b5f ]]( 1 );
    [[ var_f616c8a9f2016b5f ]]( "hi" );
    [[ var_f616c8a9f2016b5f ]]();
    [[ var_ade8a6c294ffd344 ]]( 1, 2, 3 );
    [[ var_ade8a6c294ffd344 ]]( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Method Pointer";
    s [[ var_d765ade5b13fa459 ]]();
    s [[ var_f616c8a9f2016b5f ]]( 1 );
    s [[ var_f616c8a9f2016b5f ]]( "hi" );
    s [[ var_f616c8a9f2016b5f ]]();
    s [[ var_ade8a6c294ffd344 ]]( 1, 2, 3 );
    s [[ var_ade8a6c294ffd344 ]]( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Thread Pointer";
    thread [[ var_d765ade5b13fa459 ]]();
    thread [[ var_f616c8a9f2016b5f ]]( 1 );
    thread [[ var_f616c8a9f2016b5f ]]( "hi" );
    thread [[ var_f616c8a9f2016b5f ]]();
    thread [[ var_ade8a6c294ffd344 ]]( 1, 2, 3 );
    thread [[ var_ade8a6c294ffd344 ]]( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Method Thread Pointer";
    s thread [[ var_d765ade5b13fa459 ]]();
    s thread [[ var_f616c8a9f2016b5f ]]( 1 );
    s thread [[ var_f616c8a9f2016b5f ]]( "hi" );
    s thread [[ var_f616c8a9f2016b5f ]]();
    s thread [[ var_ade8a6c294ffd344 ]]( 1, 2, 3 );
    s thread [[ var_ade8a6c294ffd344 ]]( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Child Thread Pointer";
    childthread [[ var_d765ade5b13fa459 ]]();
    childthread [[ var_f616c8a9f2016b5f ]]( 1 );
    childthread [[ var_f616c8a9f2016b5f ]]( "hi" );
    childthread [[ var_f616c8a9f2016b5f ]]();
    childthread [[ var_ade8a6c294ffd344 ]]( 1, 2, 3 );
    childthread [[ var_ade8a6c294ffd344 ]]( 1, "hi", 2 );
    level.autotests.test_runtime.testsection = "Method Child Thread Pointer";
    s childthread [[ var_d765ade5b13fa459 ]]();
    s childthread [[ var_f616c8a9f2016b5f ]]( 1 );
    s childthread [[ var_f616c8a9f2016b5f ]]( "hi" );
    s childthread [[ var_f616c8a9f2016b5f ]]();
    s childthread [[ var_ade8a6c294ffd344 ]]( 1, 2, 3 );
    s childthread [[ var_ade8a6c294ffd344 ]]( 1, "hi", 2 );
    recurse( 10 );
}

