// scripts\autotests\selftest\test_selftest_async_assert.gsc  (hash_1ec4d5edd87e6257.gscc) (size: 972 Bytes / 0x3cc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc006d41b (3221672987)
// size ...... 972 (0x3cc)
// includes .. 1   (offset: 0x38c)
// strings ... 4   (offset: 0x394)
// dev strs .. 0   (offset: 0x3cc)
// exports ... 4   (offset: 0x1e0)
// cseg ...... 0xe3 + 0xfd (0x1e0)
// imports ... 9   (offset: 0x280)
// animtree1 . 0   (offset: 0x3cc)
// animtree2 . 0   (offset: 0x3cc)
#using scripts\autotests\autotests;

#namespace test_selftest_async_assert;

// Namespace test_selftest_async_assert/testautomation
// Params 0, eflags: 0x20
// Checksum 0x13e618cd, Offset: 0x101
// Size: 0x20
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_selftest_async_assert", #"test", &start_test );
}

// Namespace test_selftest_async_assert
// Params 0
// Checksum 0x6d978dab, Offset: 0x129
// Size: 0x5b
function start_test()
{
    subfunction();
    test_cases = autotests::function_47d83c11a21b624e();
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Only 1 failure?", test_cases.size, 1, "scripts/autotests/selftest/test_selftest_async_assert.gsc", 16 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_selftest_async_assert
// Params 0
// Checksum 0xea581bb0, Offset: 0x18c
// Size: 0x54
function subfunction()
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Sub Assert", 0, "scripts/autotests/selftest/test_selftest_async_assert.gsc", 21 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::function_d84657f448aaeef6( "Set test_fail should not run after assert", 0, "scripts/autotests/selftest/test_selftest_async_assert.gsc", 22 );
}

