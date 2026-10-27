// scripts\autotests\mp\test_mp_intention_listener_sanity_check.gsc  (hash_226f0a6fc1f5f6e1.gscc) (size: 1654 Bytes / 0x676 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa61474b6 (2786358454)
// size ...... 1654 (0x676)
// includes .. 2   (offset: 0x55a)
// strings ... 19  (offset: 0x56a)
// dev strs .. 0   (offset: 0x676)
// exports ... 5   (offset: 0x39a)
// cseg ...... 0x1fb + 0x19f (0x39a)
// imports ... 8   (offset: 0x462)
// animtree1 . 0   (offset: 0x676)
// animtree2 . 0   (offset: 0x676)
#using script_21fd72fd1659366b;
#using scripts\autotests\autotests;

#namespace test_mp_intention_listener_sanity_check;

// Namespace test_mp_intention_listener_sanity_check/testautomation
// Params 0, eflags: 0x20
// Checksum 0xa3ce1e7a, Offset: 0x219
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_intention_listener_sanity_check.gsc", #"test", &start_test, &setup, &cleanup );
}

// Namespace test_mp_intention_listener_sanity_check
// Params 0
// Checksum 0x11f92a93, Offset: 0x247
// Size: 0x135
function start_test()
{
    autotests::set_dvar( @"hash_545c71bca6539094", 0 );
    namespace_77a7a114795997f2::call_intention( "ExampleEmptyIntention", [], "test skipped when wait disabled?", 5, 30, "scripts/autotests/mp/test_mp_intention_listener_sanity_check.gsc", 16 );
    setdvar( @"hash_545c71bca6539094", 1 );
    args = [];
    args[ "destination" ] = "ingame_pause_menu";
    namespace_77a7a114795997f2::call_intention( "NavigateTo", args, "NavigateTo Success?", 11, 30, "scripts/autotests/mp/test_mp_intention_listener_sanity_check.gsc", 22 );
    namespace_77a7a114795997f2::call_intention( "NavigateTo", [], "test with bad args not found?", 4, 30, "scripts/autotests/mp/test_mp_intention_listener_sanity_check.gsc", 24 );
    namespace_77a7a114795997f2::call_intention( "ExampleEmptyIntention", args, "ExampleEmptyIntention Success?", 0, 30, "scripts/autotests/mp/test_mp_intention_listener_sanity_check.gsc", 26 );
    namespace_77a7a114795997f2::call_intention( "FakeIntention", [], "FakeIntention not found?", 4, 30, "scripts/autotests/mp/test_mp_intention_listener_sanity_check.gsc", 28 );
    args = [];
    args[ "wait_time" ] = 5;
    namespace_77a7a114795997f2::call_intention( "Wait", args, "test timed out?", 8, 1, "scripts/autotests/mp/test_mp_intention_listener_sanity_check.gsc", 32 );
    args = [];
    args[ "group" ] = "example";
    args[ "name" ] = "ingame_pause_menu";
    namespace_77a7a114795997f2::call_intention( "Screenshot", args, "Screenshot Success?", 11, 30, "scripts/autotests/mp/test_mp_intention_listener_sanity_check.gsc", 37 );
}

// Namespace test_mp_intention_listener_sanity_check
// Params 0, eflags: 0x4
// Checksum 0xdfed4f3d, Offset: 0x384
// Size: 0xb, Type: bool
function private setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_mp_intention_listener_sanity_check
// Params 0, eflags: 0x4
// Checksum 0x6d45adef, Offset: 0x398
// Size: 0x2
function private cleanup()
{
    
}

