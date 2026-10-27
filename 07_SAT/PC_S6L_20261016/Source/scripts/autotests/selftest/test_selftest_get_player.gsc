// scripts\autotests\selftest\test_selftest_get_player.gsc  (hash_3fadd1b728bde9b8.gscc) (size: 518 Bytes / 0x206 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc17ca5bd (3246171581)
// size ...... 518 (0x206)
// includes .. 2   (offset: 0x1f6)
// strings ... 0   (offset: 0x206)
// dev strs .. 0   (offset: 0x206)
// exports ... 4   (offset: 0xca)
// cseg ...... 0x58 + 0x72 (0xca)
// imports ... 5   (offset: 0x16a)
// animtree1 . 0   (offset: 0x206)
// animtree2 . 0   (offset: 0x206)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;

#namespace test_selftest_get_player;

// Namespace test_selftest_get_player/testautomation
// Params 0, eflags: 0x20
// Checksum 0x68c409d6, Offset: 0x76
// Size: 0x25
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_selftest_get_player", #"test", &start_test, &setup );
}

// Namespace test_selftest_get_player
// Params 0
// Checksum 0xde8e5f59, Offset: 0xa3
// Size: 0x8, Type: bool
function setup()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_selftest_get_player
// Params 0
// Checksum 0xcc1bb9cc, Offset: 0xb4
// Size: 0x15, Type: bool
function start_test()
{
    player = autotests_utility_player::get_player();
    return false;
}

