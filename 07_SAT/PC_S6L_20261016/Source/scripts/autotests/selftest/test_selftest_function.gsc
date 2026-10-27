// scripts\autotests\selftest\test_selftest_function.gsc  (hash_178551461c04cb24.gscc) (size: 2931 Bytes / 0xb73 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ddb0bcb (2379942859)
// size ...... 2931 (0xb73)
// includes .. 1   (offset: 0xa5b)
// strings ... 12  (offset: 0xa63)
// dev strs .. 2   (offset: 0xb5b)
// exports ... 12  (offset: 0x59b)
// cseg ...... 0x1bf + 0x3dc (0x59b)
// imports ... 21  (offset: 0x77b)
// animtree1 . 0   (offset: 0xb73)
// animtree2 . 0   (offset: 0xb73)
#using scripts\autotests\autotests;

#namespace test_selftest_function;

// Namespace test_selftest_function/testautomation
// Params 0, eflags: 0x20
// Checksum 0x59fa8a56, Offset: 0x1dd
// Size: 0x25
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_selftest_function", #"test", &start_test, &setup );
}

// Namespace test_selftest_function
// Params 0
// Checksum 0x70ba307b, Offset: 0x20a
// Size: 0x1f, Type: bool
function setup()
{
    println( "<dev string:x24>" + getxhashsourcename( #"test_selftest_function" ) );
    return true;
}

// Namespace test_selftest_function
// Params 0
// Checksum 0x2fa41d6a, Offset: 0x232
// Size: 0x11, Type: bool
function function_c8b9f202245fee8()
{
    assert( 0, "<dev string:x2e>" );
    return false;
}

// Namespace test_selftest_function
// Params 0
// Checksum 0xe7f4ef1f, Offset: 0x24c
// Size: 0xaa
function function_768831a7fc55c790()
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "testA - Should pass", 1, "scripts/autotests/selftest/test_selftest_function.gsc", 31 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "testB - Shouldn't pass", 0, "scripts/autotests/selftest/test_selftest_function.gsc", 32 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "testC - Should pass", 1, "scripts/autotests/selftest/test_selftest_function.gsc", 35 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_selftest_function
// Params 0
// Checksum 0xeecaf303, Offset: 0x2fe
// Size: 0x3, Type: bool
function function_bae41287a0a25a()
{
    return false;
}

// Namespace test_selftest_function
// Params 0
// Checksum 0x90d69f76, Offset: 0x30a
// Size: 0x2
function function_fb20b368517c9c85()
{
    
}

// Namespace test_selftest_function
// Params 0
// Checksum 0x597b4f00, Offset: 0x315
// Size: 0x9d, Type: bool
function function_18db028e555b0fa6()
{
    autotests::push_function( "inner test function" );
    test_result_int = function_7b41da53d69f91d2() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "inner test function", test_result_int, undefined, undefined, "scripts/autotests/selftest/test_selftest_function.gsc", 50 );
    autotests::pop_function( "inner test function" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "inner test function2" );
    test_result_int = function_b165066100edcfa0() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "inner test function2", test_result_int, undefined, undefined, "scripts/autotests/selftest/test_selftest_function.gsc", 51 );
    autotests::pop_function( "inner test function2" );
    autotests::test_assert_return( test_result_int );
    wait 2;
    return false;
}

// Namespace test_selftest_function
// Params 0
// Checksum 0x45ef6d61, Offset: 0x3bb
// Size: 0x9, Type: bool
function function_7b41da53d69f91d2()
{
    wait 1;
    return false;
}

// Namespace test_selftest_function
// Params 0
// Checksum 0xf9e1d534, Offset: 0x3cd
// Size: 0x9, Type: bool
function function_b165066100edcfa0()
{
    wait 0.5;
    return false;
}

// Namespace test_selftest_function
// Params 0
// Checksum 0x9f275dfb, Offset: 0x3df
// Size: 0x8
function delay()
{
    wait 1;
}

// Namespace test_selftest_function
// Params 0
// Checksum 0x2f353058, Offset: 0x3ef
// Size: 0x1ab, Type: bool
function start_test()
{
    autotests::push_function( "test function should succeed" );
    test_result_int = function_bae41287a0a25a() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "test function should succeed", test_result_int, undefined, undefined, "scripts/autotests/selftest/test_selftest_function.gsc", 77 );
    autotests::pop_function( "test function should succeed" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "test nested functions" );
    test_result_int = function_18db028e555b0fa6() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "test nested functions", test_result_int, undefined, undefined, "scripts/autotests/selftest/test_selftest_function.gsc", 80 );
    autotests::pop_function( "test nested functions" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "test delay" );
    test_result_int = delay() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "test delay", test_result_int, undefined, undefined, "scripts/autotests/selftest/test_selftest_function.gsc", 83 );
    autotests::pop_function( "test delay" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "test function should sre" );
    test_result_int = function_c8b9f202245fee8() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "test function should sre", test_result_int, undefined, undefined, "scripts/autotests/selftest/test_selftest_function.gsc", 86 );
    autotests::pop_function( "test function should sre" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "test function should return undefined" );
    test_result_int = function_fb20b368517c9c85() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "test function should return undefined", test_result_int, undefined, undefined, "scripts/autotests/selftest/test_selftest_function.gsc", 89 );
    autotests::pop_function( "test function should return undefined" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "test function should fail and stop test" );
    test_result_int = function_768831a7fc55c790() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "test function should fail and stop test", test_result_int, undefined, undefined, "scripts/autotests/selftest/test_selftest_function.gsc", 92 );
    autotests::pop_function( "test function should fail and stop test" );
    autotests::test_assert_return( test_result_int );
    return false;
}

