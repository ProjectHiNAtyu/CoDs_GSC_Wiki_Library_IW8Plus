// scripts\autotests\mp\test_mp_bestplay_get_score.gsc  (hash_16490ae90231f18e.gscc) (size: 1359 Bytes / 0x54f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x11c5f980 (298187136)
// size ...... 1359 (0x54f)
// includes .. 3   (offset: 0x4cb)
// strings ... 7   (offset: 0x4e3)
// dev strs .. 1   (offset: 0x543)
// exports ... 3   (offset: 0x287)
// cseg ...... 0xe0 + 0x1a7 (0x287)
// imports ... 16  (offset: 0x2ff)
// animtree1 . 0   (offset: 0x54f)
// animtree2 . 0   (offset: 0x54f)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;

#namespace test_mp_bestplay_get_score;

// Namespace test_mp_bestplay_get_score/testautomation
// Params 0, eflags: 0x20
// Checksum 0xf411139b, Offset: 0xfe
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_bestplay_get_score.gsc", #"GP", &start_test, &autotests::function_5c8c87763724c132 );
}

// Namespace test_mp_bestplay_get_score
// Params 0
// Checksum 0xff2b1363, Offset: 0x127
// Size: 0x15f
function start_test()
{
    player = autotests_utility_player::get_player();
    wait 1;
    setdvar( @"player_sustainammo", 1 );
    
    for ( i = 4; i > 0 ; i-- )
    {
        bot_data = autotests_utility_bot::get_spawn_data( player, 45 );
        bot = autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, bot_data );
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "#" + i + " kills needed", isdefined( bot ), "scripts/autotests/mp/test_mp_bestplay_get_score.gsc", 30 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        if ( !bot )
        {
            autotests::test_wait_any( "Wait for bot spawned" + i, bot, [ "spawned" ], 1, "scripts/autotests/mp/test_mp_bestplay_get_score.gsc", 35 );
        }
        else
        {
            assert( bot, "<dev string:x24>" );
        }
        
        player startforcedfire();
        autotests::test_wait_any( "Bot Death #" + i, bot, [ "death" ], 5, "scripts/autotests/mp/test_mp_bestplay_get_score.gsc", 43 );
        player stopforcedfire();
        waitframe();
        
        if ( bot && i - 1 == 0 )
        {
            bot autotests_utility_bot::cleanup();
            waitframe();
            break;
        }
        
        if ( bot )
        {
            bot autotests_utility_bot::cleanup();
            waitframe();
        }
        
        wait 2.5;
    }
    
    setdvar( @"player_sustainammo", 0 );
    return 0;
}

