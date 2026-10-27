// scripts\autotests\selftest\test_selftest_validation_failed.gsc  (hash_02cd4da5e181d9df.gscc) (size: 628 Bytes / 0x274 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf157e961 (4049070433)
// size ...... 628 (0x274)
// includes .. 1   (offset: 0x254)
// strings ... 0   (offset: 0x25c)
// dev strs .. 2   (offset: 0x25c)
// exports ... 4   (offset: 0x104)
// cseg ...... 0x58 + 0xac (0x104)
// imports ... 6   (offset: 0x1a4)
// animtree1 . 0   (offset: 0x274)
// animtree2 . 0   (offset: 0x274)
#using scripts\autotests\autotests;

#namespace test_selftest_validation_failed;

// Namespace test_selftest_validation_failed/testautomation
// Params 0, eflags: 0x20
// Checksum 0xaeeb9d70, Offset: 0x76
// Size: 0x25
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_selftest_validation_failed", #"test", &start_test, &setup );
}

// Namespace test_selftest_validation_failed
// Params 0
// Checksum 0x87ab275c, Offset: 0xa3
// Size: 0x1e, Type: bool
function setup()
{
    println( "<dev string:x24>" + getxhashsourcename( #"test_selftest_validation_failed" ) );
    return false;
}

// Namespace test_selftest_validation_failed
// Params 0
// Checksum 0xedcbc1ca, Offset: 0xca
// Size: 0x39, Type: bool
function start_test()
{
    bundle = autotests::get_test_bundle( #"test_selftest_validation_failed" );
    println( "<dev string:x2e>" + getxhashsourcename( #"test_selftest_validation_failed" ) );
    return false;
}

