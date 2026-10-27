// scripts\autotests\mp\test_mp_network.gsc  (hash_633b4723deebf6a0.gscc) (size: 1348 Bytes / 0x544 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc252afbf (3260198847)
// size ...... 1348 (0x544)
// includes .. 3   (offset: 0x500)
// strings ... 3   (offset: 0x518)
// dev strs .. 0   (offset: 0x544)
// exports ... 5   (offset: 0x23c)
// cseg ...... 0xc0 + 0x17c (0x23c)
// imports ... 17  (offset: 0x304)
// animtree1 . 0   (offset: 0x544)
// animtree2 . 0   (offset: 0x544)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;

#namespace test_mp_network;

// Namespace test_mp_network/testautomation
// Params 0, eflags: 0x20
// Checksum 0xab6cf249, Offset: 0xde
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_network.gsc", #"test", &start_test, &setup, &cleanup );
}

// Namespace test_mp_network
// Params 0
// Checksum 0xb47ff27e, Offset: 0x10c
// Size: 0x59
function start_test()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player Is Alive At Test Start?", isalive( player ), "scripts/autotests/mp/test_mp_network.gsc", 17 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 180;
    return 0;
}

// Namespace test_mp_network
// Params 0, eflags: 0x4
// Checksum 0xedf691c4, Offset: 0x16e
// Size: 0xa3
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility::setup( 0 );
    player = autotests_utility_player::get_player();
    player function_ffb0711adb6d8d0d();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_network.gsc", 32 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::set_dvar( @"hash_1176ec8d80f609eb", 1 );
    autotests::set_dvar( @"hash_b5927301e9f4843e", 1 );
    autotests::set_dvar( @"hash_2703ff676dbcceb5", 1 );
    return 1;
}

// Namespace test_mp_network
// Params 0, eflags: 0x4
// Checksum 0xf77ef471, Offset: 0x21a
// Size: 0x22
function private cleanup()
{
    autotests_utility::cleanup();
    player = autotests_utility_player::get_player();
    player playerexitautopilotmode();
}

