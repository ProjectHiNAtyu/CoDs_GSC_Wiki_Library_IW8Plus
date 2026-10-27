// scripts\autotests\selftest\test_selftest_undefined.gsc  (hash_2f8e5952b4ad584e.gscc) (size: 627 Bytes / 0x273 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x862bdb46 (2251021126)
// size ...... 627 (0x273)
// includes .. 1   (offset: 0x253)
// strings ... 0   (offset: 0x25b)
// dev strs .. 2   (offset: 0x25b)
// exports ... 4   (offset: 0x103)
// cseg ...... 0x58 + 0xab (0x103)
// imports ... 6   (offset: 0x1a3)
// animtree1 . 0   (offset: 0x273)
// animtree2 . 0   (offset: 0x273)
#using scripts\autotests\autotests;

#namespace test_selftest_undefined;

// Namespace test_selftest_undefined/testautomation
// Params 0, eflags: 0x20
// Checksum 0x156833ac, Offset: 0x76
// Size: 0x25
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_selftest_undefined", #"test", &start_test, &setup );
}

// Namespace test_selftest_undefined
// Params 0
// Checksum 0x3c288981, Offset: 0xa3
// Size: 0x1f, Type: bool
function setup()
{
    println( "<dev string:x24>" + getxhashsourcename( #"test_selftest_undefined" ) );
    return true;
}

// Namespace test_selftest_undefined
// Params 0
// Checksum 0xbc704b81, Offset: 0xcb
// Size: 0x38
function start_test()
{
    bundle = autotests::get_test_bundle( #"test_selftest_undefined" );
    println( "<dev string:x2e>" + getxhashsourcename( #"test_selftest_undefined" ) );
}

