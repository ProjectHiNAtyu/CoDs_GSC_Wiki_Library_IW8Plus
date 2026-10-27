// scripts\autotests\gscunittest\test_gscunittest_all.gsc  (hash_1d8cee07c9034983.gscc) (size: 2655 Bytes / 0xa5f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfbfac5ee (4227515886)
// size ...... 2655 (0xa5f)
// includes .. 13  (offset: 0x8cf)
// strings ... 13  (offset: 0x937)
// dev strs .. 0   (offset: 0xa5f)
// exports ... 4   (offset: 0x533)
// cseg ...... 0x122 + 0x411 (0x533)
// imports ... 21  (offset: 0x5d3)
// animtree1 . 0   (offset: 0xa5f)
// animtree2 . 0   (offset: 0xa5f)
#using scripts\autotests\autotests;
#using scripts\autotests\gscunittest\test_gscunittest_atomic;
#using scripts\autotests\gscunittest\test_gscunittest_call;
#using scripts\autotests\gscunittest\test_gscunittest_cond;
#using scripts\autotests\gscunittest\test_gscunittest_entity_field;
#using scripts\autotests\gscunittest\test_gscunittest_loop;
#using scripts\autotests\gscunittest\test_gscunittest_ops;
#using scripts\autotests\gscunittest\test_gscunittest_patch;
#using scripts\autotests\gscunittest\test_gscunittest_private;
#using scripts\autotests\gscunittest\test_gscunittest_switch;
#using scripts\autotests\gscunittest\test_gscunittest_threads;
#using scripts\autotests\gscunittest\test_gscunittest_undefined_struct_array_object;
#using scripts\autotests\gscunittest\test_gscunittest_variables;

#namespace test_gscunittest_all;

// Namespace test_gscunittest_all
// Params 0
// Checksum 0xef921b35, Offset: 0x140
// Size: 0x357
function test()
{
    autotests::push_function( "ops" );
    test_result_int = gscunittest_ops::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "ops", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 24 );
    autotests::pop_function( "ops" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "call" );
    test_result_int = gscunittest_call::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "call", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 26 );
    autotests::pop_function( "call" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "variables" );
    test_result_int = gscunittest_variables::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "variables", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 28 );
    autotests::pop_function( "variables" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "cond" );
    test_result_int = gscunittest_cond::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "cond", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 30 );
    autotests::pop_function( "cond" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "loop" );
    test_result_int = gscunittest_loop::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "loop", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 32 );
    autotests::pop_function( "loop" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "switch" );
    test_result_int = gscunittest_switch::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "switch", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 34 );
    autotests::pop_function( "switch" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "threads" );
    test_result_int = gscunittest_threads::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "threads", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 36 );
    autotests::pop_function( "threads" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "patch" );
    test_result_int = gscunittest_patch::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "patch", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 38 );
    autotests::pop_function( "patch" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "private" );
    test_result_int = gscunittest_private::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "private", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 40 );
    autotests::pop_function( "private" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "undefined_struct_array_object" );
    test_result_int = gscunittest_undefined_struct_array_object::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "undefined_struct_array_object", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 42 );
    autotests::pop_function( "undefined_struct_array_object" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "entity_field" );
    test_result_int = gscunittest_entity_field::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "entity_field", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 44 );
    autotests::pop_function( "entity_field" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    autotests::push_function( "atomic" );
    test_result_int = gscunittest_atomic::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "atomic", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest_all.gsc", 46 );
    autotests::pop_function( "atomic" );
    autotests::test_assert_return( test_result_int );
    waitframe();
    
    /#
    #/
}

// Namespace test_gscunittest_all
// Params 0
// Checksum 0xd3adbdad, Offset: 0x49f
// Size: 0x2
function error()
{
    
}

// Namespace test_gscunittest_all
// Params 0
// Checksum 0x4ba9246f, Offset: 0x4a9
// Size: 0x8a
function main()
{
    setdvarifuninitialized( @"scr_unittest", 0 );
    
    while ( true )
    {
        wait 1;
        unittesttype = getdvarint( @"scr_unittest", 0 );
        
        switch ( unittesttype )
        {
            case 0:
                continue;
            case 1:
                test();
                break;
            case 2:
                error();
                break;
        }
        
        setdvar( @"scr_unittest", 0 );
    }
}

