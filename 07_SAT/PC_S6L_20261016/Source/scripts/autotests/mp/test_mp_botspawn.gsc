// scripts\autotests\mp\test_mp_botspawn.gsc  (hash_6f9fdfb396cc7288.gscc) (size: 1027 Bytes / 0x403 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5bca1528 (1539970344)
// size ...... 1027 (0x403)
// includes .. 3   (offset: 0x3cf)
// strings ... 2   (offset: 0x3e7)
// dev strs .. 0   (offset: 0x403)
// exports ... 4   (offset: 0x1c3)
// cseg ...... 0xa5 + 0x11e (0x1c3)
// imports ... 13  (offset: 0x263)
// animtree1 . 0   (offset: 0x403)
// animtree2 . 0   (offset: 0x403)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;

#namespace test_mp_botspawn;

// Namespace test_mp_botspawn/testautomation
// Params 0, eflags: 0x20
// Checksum 0xf9c887f4, Offset: 0xc3
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_botspawn.gsc", #"ai", &start_test, &setup );
}

// Namespace test_mp_botspawn
// Params 0
// Checksum 0x2d88d52c, Offset: 0xec
// Size: 0xb, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_mp_botspawn
// Params 0
// Checksum 0xf7d01697, Offset: 0x100
// Size: 0xc2
function start_test()
{
    autotests::set_dvar( @"hash_5fdf364fef6ac4d0", 1 );
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    player = autotests_utility_player::get_player();
    botdata = autotests_utility_bot::get_spawn_data( player, 45 );
    bot = autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, botdata );
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Bot spawn on the right team?", bot.team, player.team, "scripts/autotests/mp/test_mp_botspawn.gsc", 31 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    return 0;
}

