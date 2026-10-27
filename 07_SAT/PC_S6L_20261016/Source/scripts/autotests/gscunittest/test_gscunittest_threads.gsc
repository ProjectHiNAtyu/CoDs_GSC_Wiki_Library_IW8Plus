// scripts\autotests\gscunittest\test_gscunittest_threads.gsc  (hash_6c4b18cf3a82d31d.gscc) (size: 8783 Bytes / 0x224f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x405cb190 (1079816592)
// size ...... 8783 (0x224f)
// includes .. 1   (offset: 0x1fd3)
// strings ... 39  (offset: 0x1fdb)
// dev strs .. 0   (offset: 0x224f)
// exports ... 35  (offset: 0x145b)
// cseg ...... 0x2e7 + 0x1174 (0x145b)
// imports ... 42  (offset: 0x19d3)
// animtree1 . 0   (offset: 0x224f)
// animtree2 . 0   (offset: 0x224f)
#using scripts\autotests\autotests;

#namespace gscunittest_threads;

// Namespace gscunittest_threads
// Params 0
// Checksum 0x255dc1c7, Offset: 0x305
// Size: 0xfd
function thread_wait()
{
    level.autotests.test_runtime.threadstarttime = gettime();
    autotests::function_d84657f448aaeef6( "thread_wait: 0", 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 10 );
    wait 0.1;
    var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "thread_wait: 1", gettime(), level.autotests.test_runtime.threadstarttime + 96, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 13 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 0.1;
    var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "thread_wait: 2", gettime(), level.autotests.test_runtime.threadstarttime + 192, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 15 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_threads
// Params 1
// Checksum 0xe6688c1f, Offset: 0x40a
// Size: 0x76
function f_resume( i )
{
    wait 0.1;
    count = level.autotests.test_runtime.threadcount;
    count--;
    level.autotests.test_runtime.threadcount = count;
    autotests::function_d84657f448aaeef6( "f_resume: 1: " + i, 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 27 );
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x5cb44102, Offset: 0x488
// Size: 0xb1
function thread_resume()
{
    level.autotests.test_runtime.threadcount = 10;
    
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_resume( i );
    }
    
    wait 0.2;
    count = level.autotests.test_runtime.threadcount;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_resume: count: ", count, 0, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 40 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_threads
// Params 1
// Checksum 0x2d4bef3f, Offset: 0x541
// Size: 0x104
function f_notify( i )
{
    level waittill( #"f", x, y );
    count = level.autotests.test_runtime.threadcount;
    count--;
    level.autotests.test_runtime.threadcount = count;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_notify: " + i + " x:", x, 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 52 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_notify: " + i + " y:", y, "a", "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 53 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0xe2e8a40f, Offset: 0x64d
// Size: 0x115
function thread_wait_notify()
{
    level.autotests.test_runtime.threadcount = 10;
    
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_notify( i );
    }
    
    level notify( #"f", 1, "a" );
    count = level.autotests.test_runtime.threadcount;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_notify: count before:", count, 10, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 67 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    waittillframeend();
    count = level.autotests.test_runtime.threadcount;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_notify: count after: ", count, 0, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 71 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0xf65995f2, Offset: 0x76a
// Size: 0x10
function thread_terminate_child()
{
    level notify( #"hash_7b2c5fa1149fbbe" );
    return 2;
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x5028521b, Offset: 0x783
// Size: 0x18, Type: bool
function thread_terminate_wrapper()
{
    level endon( #"hash_7b2c5fa1149fbbe" );
    level thread thread_terminate_child();
    return true;
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0xa291a126, Offset: 0x7a4
// Size: 0x51
function thread_terminate_notify()
{
    x = thread_terminate_wrapper();
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "thread_terminate_notify: ", x, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 90 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_threads
// Params 2
// Checksum 0x6a9b8a04, Offset: 0x7fd
// Size: 0xdd
function f_match( notifystr, i )
{
    level waittillmatch( notifystr, #"yes" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_match: " + i + " f:", notifystr, "f", "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 96 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    tomatch = level.autotests.test_runtime.tomatch;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_match: " + i + " yes:", tomatch, "yes", "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 98 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_threads
// Params 1
// Checksum 0xea06764f, Offset: 0x8e2
// Size: 0x2a
function waittillmatch_wait( index )
{
    wait 1;
    autotests::function_d84657f448aaeef6( "waittillmatch_wait end: " + index, 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 106 );
}

// Namespace gscunittest_threads
// Params 1
// Checksum 0x9775881, Offset: 0x914
// Size: 0xb6
function waittillmatch_loop( index )
{
    level endon( #"waittillmatch_end" );
    
    while ( true )
    {
        level waittillmatch( #"wtm_loop", #"loop" );
        tomatch = level.autotests.test_runtime.tomatch;
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "wtm_loop: " + index + " loop:", tomatch, "loop", "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 118 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        level thread waittillmatch_wait( index );
    }
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0xe0f77ad, Offset: 0x9d2
// Size: 0x15b
function thread_waittill_match()
{
    notifystr = "f";
    
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_match( notifystr, i );
    }
    
    level.autotests.test_runtime.tomatch = "no";
    level notify( notifystr, "no" );
    level.autotests.test_runtime.tomatch = "yes";
    level notify( notifystr, "yes" );
    
    for ( i = 0; i < 4 ; i++ )
    {
        level thread waittillmatch_loop( i );
    }
    
    waittillframeend();
    level.autotests.test_runtime.tomatch = "nope";
    level notify( #"wtm_loop", "nope" );
    level.autotests.test_runtime.tomatch = "loop";
    level notify( #"wtm_loop", "loop" );
    waittillframeend();
    level.autotests.test_runtime.tomatch = "loop";
    level notify( #"wtm_loop", "loop" );
    level notify( #"waittillmatch_end" );
    wait 1;
}

// Namespace gscunittest_threads
// Params 1
// Checksum 0x15e010f6, Offset: 0xb35
// Size: 0x63
function f_endon( i )
{
    level endon( #"f_endon" );
    
    for ( ;; )
    {
        level.autotests.test_runtime.f_endon[ i ] = 1;
        wait 10;
        level.autotests.test_runtime.f_endon[ i ] = 0;
    }
}

// Namespace gscunittest_threads
// Params 1
// Checksum 0x1dd84b90, Offset: 0xba0
// Size: 0x94
function stack_endon_recurse( i )
{
    level.autotests.test_runtime.stack_endon[ i ] = 1;
    
    if ( i < 0 )
    {
        level notify( #"stack_endon" );
        level.autotests.test_runtime.stack_endon[ i ] = 2;
    }
    
    stack_endon_recurse( i - 1 );
    level.autotests.test_runtime.stack_endon[ i ] = 3;
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x676d8dfa, Offset: 0xc3c
// Size: 0x17
function stack_endon()
{
    level endon( #"stack_endon" );
    stack_endon_recurse( 3 );
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x4922b21e, Offset: 0xc5b
// Size: 0x129
function thread_endon()
{
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_endon( i );
    }
    
    wait 0.1;
    level notify( #"f_endon" );
    
    for ( i = 0; i < 10 ; i++ )
    {
        x = level.autotests.test_runtime.f_endon[ i ];
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_endon:" + i, x, 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 199 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    stack_endon();
    
    for ( i = 0; i < 3 ; i++ )
    {
        x = level.autotests.test_runtime.stack_endon[ i ];
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_endon:" + i, x, 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 207 );
        
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

// Namespace gscunittest_threads
// Params 1
// Checksum 0xc3f433bf, Offset: 0xd8c
// Size: 0xab
function f_churn( i )
{
    level.autotests.test_runtime.f_churn[ i ] = 0;
    level waittill( #"churn", x );
    level.autotests.test_runtime.f_churn[ i ] = x;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "churn: " + i, x, 4, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 222 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x29204890, Offset: 0xe3f
// Size: 0x26
function thread_churn()
{
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_churn( i );
    }
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0xf79e3fef, Offset: 0xe6d
// Size: 0x98
function thread_churn_notify()
{
    level notify( #"churn", 4 );
    waittillframeend();
    
    for ( i = 0; i < 10 ; i++ )
    {
        x = level.autotests.test_runtime.f_churn[ i ];
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_churn: " + i, x, 4, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 242 );
        
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

// Namespace gscunittest_threads
// Params 1
// Checksum 0x623dcf5d, Offset: 0xf0d
// Size: 0xb6
function f_waitframe( i )
{
    level.autotests.test_runtime.f_waitframe[ i ] = 0;
    waitframe();
    level.autotests.test_runtime.f_waitframe[ i ] = 1;
    var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "f_waitframe wait: " + i, gettime(), level.autotests.test_runtime.threadstarttime + 16, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 254 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x74eec78d, Offset: 0xfcb
// Size: 0xcc
function thread_waitframe()
{
    level.autotests.test_runtime.threadstarttime = gettime();
    
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_waitframe( i );
    }
    
    wait 0.1;
    
    for ( i = 0; i < 10 ; i++ )
    {
        x = level.autotests.test_runtime.f_waitframe[ i ];
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_waitframe:" + i, x, 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 272 );
        
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

// Namespace gscunittest_threads
// Params 1
// Checksum 0x1fea44d3, Offset: 0x109f
// Size: 0x52
function f_waitframeend( i )
{
    level.autotests.test_runtime.f_waitframeend[ i ] = 0;
    waittillframeend();
    level.autotests.test_runtime.f_waitframeend[ i ] = 1;
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0xb54963b6, Offset: 0x10f9
// Size: 0xaa
function thread_waitframeend()
{
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_waitframeend( i );
    }
    
    wait 0.1;
    
    for ( i = 0; i < 10 ; i++ )
    {
        x = level.autotests.test_runtime.f_waitframeend[ i ];
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "f_waitframeend:" + i, x, 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 297 );
        
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

// Namespace gscunittest_threads
// Params 0
// Checksum 0xfeabc9fd, Offset: 0x11ab
// Size: 0x30
function f_running_func()
{
    for ( i = 0; true ; i++ )
    {
        if ( i == 3 )
        {
            level notify( #"f_running" );
        }
    }
    
    return i;
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x9fc7fda8, Offset: 0x11e4
// Size: 0x14
function f_running_func_call()
{
    level endon( #"f_running" );
    return f_running_func();
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x86a868aa, Offset: 0x1201
// Size: 0x14
function f_running_thread_call()
{
    level endon( #"f_running" );
    return childthread f_running_func();
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x63877d1a, Offset: 0x121e
// Size: 0x1f
function f_running_nested_1()
{
    f_running_nested_2();
    autotests::function_d84657f448aaeef6( "f_nested_1", 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 334 );
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0xaa029092, Offset: 0x1245
// Size: 0x2a
function f_running_nested_2()
{
    level endon( #"f_running" );
    f_running_nested_3();
    autotests::function_d84657f448aaeef6( "f_nested_2", 0, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 342 );
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x8ae4d83c, Offset: 0x1277
// Size: 0x1e
function f_running_nested_3()
{
    f_running_nested_4();
    autotests::function_d84657f448aaeef6( "f_nested_3", 0, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 348 );
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x436135f6, Offset: 0x129d
// Size: 0x2a
function f_running_nested_4()
{
    f_running_nested_5();
    level notify( #"f_running" );
    autotests::function_d84657f448aaeef6( "f_nested_4", 0, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 355 );
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0xdf25f6e3, Offset: 0x12cf
// Size: 0x18
function f_running_nested_5()
{
    autotests::function_d84657f448aaeef6( "f_nested_5", 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 360 );
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0xda7ed1a2, Offset: 0x12ef
// Size: 0xb, Type: bool
function f_running_nested_call()
{
    thread f_running_nested_1();
    return true;
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0x859aa90a, Offset: 0x1303
// Size: 0xd0
function thread_running_notify()
{
    i = f_running_func_call();
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "thread_running_func_call:", i, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 373 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    i = f_running_thread_call();
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "thread_running_thread_call:", i, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 376 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    i = f_running_nested_call();
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "thread_running_nested_call:", i, 1, "scripts/autotests/gscunittest/test_gscunittest_threads.gsc", 379 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_threads
// Params 0
// Checksum 0xe5b54de6, Offset: 0x13db
// Size: 0x80
function main()
{
    thread_churn();
    thread_wait();
    wait 0.1;
    thread_resume();
    wait 0.1;
    thread_wait_notify();
    wait 0.1;
    thread_terminate_notify();
    wait 0.1;
    thread_waittill_match();
    wait 0.1;
    thread_endon();
    wait 0.1;
    thread_waitframe();
    wait 0.1;
    thread_waitframeend();
    wait 0.1;
    thread_running_notify();
    thread_churn_notify();
    waittillframeend();
}

