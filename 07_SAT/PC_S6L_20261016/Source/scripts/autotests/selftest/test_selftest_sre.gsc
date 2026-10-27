// scripts\autotests\selftest\test_selftest_sre.gsc  (hash_10737eeaec1d1c5a.gscc) (size: 504 Bytes / 0x1f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbdf3d7f6 (3186874358)
// size ...... 504 (0x1f8)
// includes .. 1   (offset: 0x1cc)
// strings ... 0   (offset: 0x1d4)
// dev strs .. 3   (offset: 0x1d4)
// exports ... 3   (offset: 0xdc)
// cseg ...... 0x58 + 0x84 (0xdc)
// imports ... 4   (offset: 0x154)
// animtree1 . 0   (offset: 0x1f8)
// animtree2 . 0   (offset: 0x1f8)
#using scripts\autotests\autotests;

#namespace test_selftest_sre;

// Namespace test_selftest_sre/testautomation
// Params 0, eflags: 0x20
// Checksum 0x7e6b8b02, Offset: 0x76
// Size: 0x20
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_selftest_sre", #"test", &start_test );
}

// Namespace test_selftest_sre
// Params 0
// Checksum 0xe433f32c, Offset: 0x9e
// Size: 0x3e
function start_test()
{
    println( "<dev string:x24>" + getxhashsourcename( #"test_selftest_sre" ) );
    println( "<dev string:x30>" );
    
    if ( undefined.size > 0 )
    {
        println( "<dev string:x5c>" );
    }
}

