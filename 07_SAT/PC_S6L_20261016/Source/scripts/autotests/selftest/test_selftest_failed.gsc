// scripts\autotests\selftest\test_selftest_failed.gsc  (hash_18a342b42a64ac91.gscc) (size: 630 Bytes / 0x276 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x89d8756 (144541526)
// size ...... 630 (0x276)
// includes .. 1   (offset: 0x256)
// strings ... 0   (offset: 0x25e)
// dev strs .. 2   (offset: 0x25e)
// exports ... 4   (offset: 0x106)
// cseg ...... 0x58 + 0xae (0x106)
// imports ... 6   (offset: 0x1a6)
// animtree1 . 0   (offset: 0x276)
// animtree2 . 0   (offset: 0x276)
#using scripts\autotests\autotests;

#namespace test_selftest_failed;

// Namespace test_selftest_failed/testautomation
// Params 0, eflags: 0x20
// Checksum 0x9ef75ede, Offset: 0x76
// Size: 0x25
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_selftest_failed", #"test", &start_test, &setup );
}

// Namespace test_selftest_failed
// Params 0
// Checksum 0xb7b7e4f3, Offset: 0xa3
// Size: 0x1f, Type: bool
function setup()
{
    println( "<dev string:x24>" + getxhashsourcename( #"test_selftest_failed" ) );
    return true;
}

// Namespace test_selftest_failed
// Params 0
// Checksum 0xaaad0253, Offset: 0xcb
// Size: 0x3a, Type: bool
function start_test()
{
    bundle = autotests::get_test_bundle( #"test_selftest_failed" );
    println( "<dev string:x2e>" + getxhashsourcename( #"test_selftest_failed" ) );
    return true;
}

