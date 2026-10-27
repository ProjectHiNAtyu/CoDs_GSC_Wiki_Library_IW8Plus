// scripts\autotests\selftest\test_selftest_success.gsc  (hash_191a65338b3e81cd.gscc) (size: 629 Bytes / 0x275 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x46852722 (1183131426)
// size ...... 629 (0x275)
// includes .. 1   (offset: 0x255)
// strings ... 0   (offset: 0x25d)
// dev strs .. 2   (offset: 0x25d)
// exports ... 4   (offset: 0x105)
// cseg ...... 0x58 + 0xad (0x105)
// imports ... 6   (offset: 0x1a5)
// animtree1 . 0   (offset: 0x275)
// animtree2 . 0   (offset: 0x275)
#using scripts\autotests\autotests;

#namespace test_selftest_success;

// Namespace test_selftest_success/testautomation
// Params 0, eflags: 0x20
// Checksum 0xea1ecc0c, Offset: 0x76
// Size: 0x25
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_selftest_success", #"test", &start_test, &setup );
}

// Namespace test_selftest_success
// Params 0
// Checksum 0xc35e7621, Offset: 0xa3
// Size: 0x1f, Type: bool
function setup()
{
    println( "<dev string:x24>" + getxhashsourcename( #"test_selftest_success" ) );
    return true;
}

// Namespace test_selftest_success
// Params 0
// Checksum 0xd20ffbd4, Offset: 0xcb
// Size: 0x39, Type: bool
function start_test()
{
    bundle = autotests::get_test_bundle( #"test_selftest_success" );
    println( "<dev string:x2e>" + getxhashsourcename( #"test_selftest_success" ) );
    return false;
}

