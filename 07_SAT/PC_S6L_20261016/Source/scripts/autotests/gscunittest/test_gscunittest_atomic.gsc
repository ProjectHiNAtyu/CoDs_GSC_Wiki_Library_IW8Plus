// scripts\autotests\gscunittest\test_gscunittest_atomic.gsc  (hash_7d0ac11c9dcaa863.gscc) (size: 2673 Bytes / 0xa71 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x273ffc9c (658504860)
// size ...... 2673 (0xa71)
// includes .. 1   (offset: 0x999)
// strings ... 13  (offset: 0x9a1)
// dev strs .. 0   (offset: 0xa71)
// exports ... 16  (offset: 0x48d)
// cseg ...... 0x166 + 0x327 (0x48d)
// imports ... 21  (offset: 0x70d)
// animtree1 . 0   (offset: 0xa71)
// animtree2 . 0   (offset: 0xa71)
#using scripts\autotests\autotests;

#namespace gscunittest_atomic;

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x7a884aee, Offset: 0x184
// Size: 0x19
function empty()
{
    profilestart();
    profilestop();
    autotests::function_d84657f448aaeef6( "empty", 1, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 13 );
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0xeeab376f, Offset: 0x1a5
// Size: 0x4
function function_4c30887760688bda()
{
    return 7;
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x85771e21, Offset: 0x1b2
// Size: 0x55
function function_call()
{
    profilestart();
    number = function_4c30887760688bda();
    profilestop();
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "function_call", number, 7, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 28 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x8136a970, Offset: 0x20f
// Size: 0x5
function function_75f82d53501ec7cc()
{
    wait 1;
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0xb83d888a, Offset: 0x21c
// Size: 0x25
function unaccessed_wait()
{
    profilestart();
    
    if ( false )
    {
        function_75f82d53501ec7cc();
    }
    
    profilestop();
    waitframe();
    autotests::function_d84657f448aaeef6( "unaccessed_wait", 1, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 48 );
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0xb83d88b9, Offset: 0x249
// Size: 0x21
function threaded_wait()
{
    profilestart();
    thread function_75f82d53501ec7cc();
    profilestop();
    waitframe();
    autotests::function_d84657f448aaeef6( "threaded_wait", 1, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 60 );
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0xb83d88c8, Offset: 0x272
// Size: 0x21
function childthreaded_wait()
{
    profilestart();
    childthread function_75f82d53501ec7cc();
    profilestop();
    waitframe();
    autotests::function_d84657f448aaeef6( "childthreaded_wait", 1, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 72 );
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x7a884ab7, Offset: 0x29b
// Size: 0x25
function wait_after_before()
{
    wait 0.1;
    profilestart();
    profilestop();
    wait 0.1;
    autotests::function_d84657f448aaeef6( "wait_after_before", 1, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 84 );
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x601e1643, Offset: 0x2c8
// Size: 0x4
function function_b82c87f08289fcb3()
{
    profilestart();
    profilestop();
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x64d9fb06, Offset: 0x2d6
// Size: 0x24
function early_return()
{
    function_b82c87f08289fcb3();
    wait 0.1;
    autotests::function_d84657f448aaeef6( "early_return", 1, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 101 );
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x474486d5, Offset: 0x302
// Size: 0x2b
function early_loop_break()
{
    while ( true )
    {
        profilestart();
        profilestop();
        break;
    }
    
    wait 0.1;
    autotests::function_d84657f448aaeef6( "early_loop_break", 1, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 116 );
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x9ce47c13, Offset: 0x335
// Size: 0x39
function loop_continue()
{
    for ( i = 0; i < 5 ; i++ )
    {
        waitframe();
        profilestart();
        profilestop();
        continue;
    }
    
    autotests::function_d84657f448aaeef6( "loop_continue", 1, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 131 );
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x8ed0bf5c, Offset: 0x376
// Size: 0x9d
function modify_variable()
{
    a = 1;
    profilestart();
    b = "test string";
    a++;
    profilestop();
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "modify_variable", a, 2, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 143 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "modify_variable", b, "test string", "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 144 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x7a884a75, Offset: 0x41b
// Size: 0x1b
function nested_atomic()
{
    profilestart();
    profilestart();
    profilestop();
    profilestop();
    autotests::function_d84657f448aaeef6( "nested_atomic", 1, "scripts/autotests/gscunittest/test_gscunittest_atomic.gsc", 156 );
}

// Namespace gscunittest_atomic
// Params 0
// Checksum 0x66f4163d, Offset: 0x43e
// Size: 0x4f
function main()
{
    empty();
    function_call();
    unaccessed_wait();
    threaded_wait();
    childthreaded_wait();
    wait_after_before();
    early_return();
    early_loop_break();
    loop_continue();
    modify_variable();
    nested_atomic();
}

