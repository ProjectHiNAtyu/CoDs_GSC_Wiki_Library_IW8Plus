// scripts\autotests\selftest\test_selftest_crash.gsc  (hash_50fffc51e661a365.gscc) (size: 402 Bytes / 0x192 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb5924c94 (3046263956)
// size ...... 402 (0x192)
// includes .. 1   (offset: 0x17e)
// strings ... 0   (offset: 0x186)
// dev strs .. 1   (offset: 0x186)
// exports ... 3   (offset: 0xb2)
// cseg ...... 0x58 + 0x5a (0xb2)
// imports ... 3   (offset: 0x12a)
// animtree1 . 0   (offset: 0x192)
// animtree2 . 0   (offset: 0x192)
#using scripts\autotests\autotests;

#namespace test_selftest_crash;

// Namespace test_selftest_crash/testautomation
// Params 0, eflags: 0x20
// Checksum 0xecc4a4cc, Offset: 0x76
// Size: 0x20
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_selftest_crash", #"test", &start_test );
}

// Namespace test_selftest_crash
// Params 0
// Checksum 0xa9f55f09, Offset: 0x9e
// Size: 0x13, Type: bool
function start_test()
{
    /#
        adddebugcommand( "<dev string:x24>" );
    #/
    
    wait 1;
    return false;
}

