// scripts\autotests\test_vehicle_huds.gsc  (hash_79f7ddd9ee920351.gscc) (size: 852 Bytes / 0x354 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd59ba116 (3583746326)
// size ...... 852 (0x354)
// includes .. 4   (offset: 0x31c)
// strings ... 2   (offset: 0x33c)
// dev strs .. 0   (offset: 0x354)
// exports ... 5   (offset: 0x13c)
// cseg ...... 0x98 + 0xa4 (0x13c)
// imports ... 10  (offset: 0x204)
// animtree1 . 0   (offset: 0x354)
// animtree2 . 0   (offset: 0x354)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\test_vehicles_seats;
#using scripts\common\utility;

#namespace test_vehicle_huds;

// Namespace test_vehicle_huds/testautomation
// Params 0, eflags: 0x20
// Checksum 0xb7b08013, Offset: 0xb6
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_vehicle_huds.gsc", #"gp_vehicles", &start_test, &setup, &cleanup );
}

// Namespace test_vehicle_huds
// Params 0, eflags: 0x4
// Checksum 0xe40c367f, Offset: 0xe4
// Size: 0x17, Type: bool
function private setup()
{
    autotests::function_5c8c87763724c132();
    utility::flag_wait( "vehicle_init_done" );
    return true;
}

// Namespace test_vehicle_huds
// Params 0, eflags: 0x4
// Checksum 0x888cbf7, Offset: 0x104
// Size: 0x26, Type: bool
function private start_test()
{
    player = autotests_utility_player::get_player();
    test_vehicles_seats::test_vehicles( test_vehicles_seats::get_vehicles( 1 ), player );
    return false;
}

// Namespace test_vehicle_huds
// Params 0, eflags: 0x4
// Checksum 0x9dc33ec5, Offset: 0x133
// Size: 0x9
function private cleanup()
{
    test_vehicles_seats::function_15e328716acd61a3();
}

