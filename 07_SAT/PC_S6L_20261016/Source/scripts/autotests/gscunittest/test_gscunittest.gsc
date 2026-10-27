// scripts\autotests\gscunittest\test_gscunittest.gsc  (hash_6fce61c4e1e1d07b.gscc) (size: 4487 Bytes / 0x1187 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x81ecf2a6 (2179789478)
// size ...... 4487 (0x1187)
// includes .. 14  (offset: 0xfd7)
// strings ... 14  (offset: 0x1047)
// dev strs .. 0   (offset: 0x1187)
// exports ... 17  (offset: 0x873)
// cseg ...... 0x1d0 + 0x6a3 (0x873)
// imports ... 33  (offset: 0xb1b)
// animtree1 . 0   (offset: 0x1187)
// animtree2 . 0   (offset: 0x1187)
#using script_5d57c26dd1487f0e;
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

#namespace test_gscunittest;

// Namespace test_gscunittest/testautomation
// Params 0, eflags: 0x20
// Checksum 0x2a313547, Offset: 0x1ee
// Size: 0x1c9
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_gscunittest", #"test", &test_empty, &setup );
    autotests::register_test( #"test_gscunittest_atomic", #"test", &test_atomic, &setup );
    autotests::register_test( #"test_gscunittest_call", #"test", &test_call, &setup );
    autotests::register_test( #"test_gscunittest_cond", #"test", &test_cond, &setup );
    autotests::register_test( #"test_gscunittest_entity_field", #"test", &test_entity_field, &setup );
    autotests::register_test( #"test_gscunittest_loop", #"test", &test_loop, &setup );
    autotests::register_test( #"test_gscunittest_ops", #"test", &test_ops, &setup );
    autotests::register_test( #"test_gscunittest_patch", #"test", &test_patch, &setup );
    autotests::register_test( #"test_gscunittest_private", #"test", &test_private, &setup );
    autotests::register_test( #"test_gscunittest_switch", #"test", &test_switch, &setup );
    autotests::register_test( #"test_gscunittest_threads", #"test", &test_threads, &setup );
    autotests::register_test( #"test_gscunittest_undefined_struct_array_object", #"test", &test_undefined_struct_array_object, &setup );
    autotests::register_test( #"test_gscunittest_variables", #"test", &test_variables, &setup );
}

// Namespace test_gscunittest
// Params 0
// Checksum 0x11bd5487, Offset: 0x3bf
// Size: 0x8, Type: bool
function setup()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_gscunittest
// Params 0
// Checksum 0x571e4018, Offset: 0x3d0
// Size: 0x52, Type: bool
function test_atomic()
{
    autotests::push_function( "Unit Tests - atomic" );
    test_result_int = gscunittest_atomic::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - atomic", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 47 );
    autotests::pop_function( "Unit Tests - atomic" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0xa85d5435, Offset: 0x42b
// Size: 0x52, Type: bool
function test_call()
{
    autotests::push_function( "Unit Tests - call" );
    test_result_int = gscunittest_call::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - call", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 53 );
    autotests::pop_function( "Unit Tests - call" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0x9e2e9381, Offset: 0x486
// Size: 0x52, Type: bool
function test_cond()
{
    autotests::push_function( "Unit Tests - cond" );
    test_result_int = gscunittest_cond::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - cond", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 59 );
    autotests::pop_function( "Unit Tests - cond" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0x2026359, Offset: 0x4e1
// Size: 0x52, Type: bool
function test_entity_field()
{
    autotests::push_function( "Unit Tests - entity_field" );
    test_result_int = gscunittest_entity_field::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - entity_field", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 65 );
    autotests::pop_function( "Unit Tests - entity_field" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0xa441979, Offset: 0x53c
// Size: 0x3, Type: bool
function test_empty()
{
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0x232ee41f, Offset: 0x548
// Size: 0x52, Type: bool
function test_error()
{
    autotests::push_function( "Unit Tests - error" );
    test_result_int = gscunittest_error::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - error", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 76 );
    autotests::pop_function( "Unit Tests - error" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0xc58c6682, Offset: 0x5a3
// Size: 0x52, Type: bool
function test_loop()
{
    autotests::push_function( "Unit Tests - loop" );
    test_result_int = gscunittest_loop::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - loop", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 82 );
    autotests::pop_function( "Unit Tests - loop" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0xc4dd160d, Offset: 0x5fe
// Size: 0x52, Type: bool
function test_ops()
{
    autotests::push_function( "Unit Tests - ops" );
    test_result_int = gscunittest_ops::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - ops", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 88 );
    autotests::pop_function( "Unit Tests - ops" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0x9cd8ce4a, Offset: 0x659
// Size: 0x52, Type: bool
function test_patch()
{
    autotests::push_function( "Unit Tests - patch" );
    test_result_int = gscunittest_patch::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - patch", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 94 );
    autotests::pop_function( "Unit Tests - patch" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0xfcfed3f4, Offset: 0x6b4
// Size: 0x52, Type: bool
function test_private()
{
    autotests::push_function( "Unit Tests - private" );
    test_result_int = gscunittest_private::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - private", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 100 );
    autotests::pop_function( "Unit Tests - private" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0x5016f3c, Offset: 0x70f
// Size: 0x52, Type: bool
function test_switch()
{
    autotests::push_function( "Unit Tests - switch" );
    test_result_int = gscunittest_switch::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - switch", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 106 );
    autotests::pop_function( "Unit Tests - switch" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0x41762fec, Offset: 0x76a
// Size: 0x52, Type: bool
function test_threads()
{
    autotests::push_function( "Unit Tests - threads" );
    test_result_int = gscunittest_threads::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - threads", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 112 );
    autotests::pop_function( "Unit Tests - threads" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0x2bf18991, Offset: 0x7c5
// Size: 0x52, Type: bool
function test_undefined_struct_array_object()
{
    autotests::push_function( "Unit Tests - undefined_struct_array_object" );
    test_result_int = gscunittest_undefined_struct_array_object::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - undefined_struct_array_object", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 118 );
    autotests::pop_function( "Unit Tests - undefined_struct_array_object" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_gscunittest
// Params 0
// Checksum 0x7eeaafcd, Offset: 0x820
// Size: 0x52, Type: bool
function test_variables()
{
    autotests::push_function( "Unit Tests - variables" );
    test_result_int = gscunittest_variables::main() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Unit Tests - variables", test_result_int, undefined, undefined, "scripts/autotests/gscunittest/test_gscunittest.gsc", 124 );
    autotests::pop_function( "Unit Tests - variables" );
    autotests::test_assert_return( test_result_int );
    return false;
}

