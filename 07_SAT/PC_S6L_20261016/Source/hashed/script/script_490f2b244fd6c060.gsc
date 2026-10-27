// script_490f2b244fd6c060  (hash_490f2b244fd6c060.gscc) (size: 1636 Bytes / 0x664 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26b400f0 (649330928)
// size ...... 1636 (0x664)
// includes .. 3   (offset: 0x5d0)
// strings ... 7   (offset: 0x5e8)
// dev strs .. 0   (offset: 0x664)
// exports ... 4   (offset: 0x32c)
// cseg ...... 0x10d + 0x21f (0x32c)
// imports ... 17  (offset: 0x3cc)
// animtree1 . 0   (offset: 0x664)
// animtree2 . 0   (offset: 0x664)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;

#namespace namespace_5d23f1300f341e55;

// Namespace namespace_5d23f1300f341e55/testautomation
// Params 0, eflags: 0x20
// Checksum 0xb03f7def, Offset: 0x12b
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_equipment.gsc", #"GP", &start_test, &autotests::function_5c8c87763724c132 );
}

// Namespace namespace_5d23f1300f341e55
// Params 0
// Checksum 0xc71b8e71, Offset: 0x154
// Size: 0x150
function start_test()
{
    autotests::set_dvar( @"hash_5fdf364fef6ac4d0", 1 );
    player = autotests_utility_player::get_player();
    botdata = autotests_utility_bot::get_spawn_data( player, 270 );
    bot = autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, botdata );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot spawned: ", isdefined( bot ), "scripts/autotests/test_equipment.gsc", 21 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 5;
    autotests::push_function( "Primary Equipment can be used. " );
    test_result_int = function_e9485dd00f52840b( bot, "lethal", 0.5, 0.5 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Primary Equipment can be used. ", test_result_int, undefined, undefined, "scripts/autotests/test_equipment.gsc", 24 );
    autotests::pop_function( "Primary Equipment can be used. " );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Secondary Equipment can be used." );
    test_result_int = function_e9485dd00f52840b( bot, "tactical", 0.5, 1.5 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Secondary Equipment can be used.", test_result_int, undefined, undefined, "scripts/autotests/test_equipment.gsc", 26 );
    autotests::pop_function( "Secondary Equipment can be used." );
    autotests::test_assert_return( test_result_int );
    wait 5;
    bot autotests_utility_bot::cleanup();
    return 0;
}

// Namespace namespace_5d23f1300f341e55
// Params 4
// Checksum 0x1bf0e6f4, Offset: 0x2ad
// Size: 0x7f
function function_e9485dd00f52840b( bot, button, wait_time, hold_time )
{
    autotests::push_function( "Bot used Primary equipment." );
    test_result_int = bot autotests_utility_bot::function_aaa2288bee31d766( button, wait_time, hold_time ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Bot used Primary equipment.", test_result_int, undefined, undefined, "scripts/autotests/test_equipment.gsc", 36 );
    autotests::pop_function( "Bot used Primary equipment." );
    autotests::test_assert_return( test_result_int );
    wait 2;
}

