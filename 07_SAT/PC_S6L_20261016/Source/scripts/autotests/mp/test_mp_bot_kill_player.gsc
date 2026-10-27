// scripts\autotests\mp\test_mp_bot_kill_player.gsc  (hash_4f0000fa41ed55d4.gscc) (size: 1538 Bytes / 0x602 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe9b5f50 (245063504)
// size ...... 1538 (0x602)
// includes .. 5   (offset: 0x592)
// strings ... 5   (offset: 0x5ba)
// dev strs .. 0   (offset: 0x602)
// exports ... 5   (offset: 0x2de)
// cseg ...... 0xde + 0x200 (0x2de)
// imports ... 17  (offset: 0x3a6)
// animtree1 . 0   (offset: 0x602)
// animtree2 . 0   (offset: 0x602)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_common_item;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;

#namespace test_mp_bot_kill_player;

// Namespace test_mp_bot_kill_player/testautomation
// Params 0, eflags: 0x20
// Checksum 0xc4d8b13a, Offset: 0xfc
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_bot_kill_player.gsc", #"GP", &start_test, &setup, &test_teardown );
}

// Namespace test_mp_bot_kill_player
// Params 0
// Checksum 0x93c17560, Offset: 0x12a
// Size: 0xb, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_mp_bot_kill_player
// Params 0
// Checksum 0x3e8e0c21, Offset: 0x13e
// Size: 0x6e
function test_teardown()
{
    wait 1;
    var_b3a54ad206ca67a7 = level.autotests.test_runtime.opponent_team_bot.origin;
    autotests_utility_bot::kick_all_bots();
    wait 1;
    autotests_utility_common_item::function_92d66ed1629b0979( level.autotests.test_runtime.var_b3a54ad206ca67a7, 150 );
}

// Namespace test_mp_bot_kill_player
// Params 0
// Checksum 0xdb033545, Offset: 0x1b4
// Size: 0x129
function start_test()
{
    player = autotests_utility_player::get_player();
    opponent_team_bot = autotests_utility_bot::function_978126f411fc8a11( player );
    level.autotests.test_runtime.opponent_team_bot = opponent_team_bot;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spawned opponent_team_bot", isdefined( opponent_team_bot ), "scripts/autotests/mp/test_mp_bot_kill_player.gsc", 46 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    while ( opponent_team_bot.sessionstate == "spectator" )
    {
        waitframe();
    }
    
    spawndata = autotests_utility_bot::get_spawn_data( player, 150 );
    opponent_team_bot setorigin( spawndata.origin );
    opponent_team_bot setplayerangles( spawndata.angles );
    result = player utility::waittill_any_timeout( 20, "death" );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player killed in 20 seconds", result == "death", "scripts/autotests/mp/test_mp_bot_kill_player.gsc", 58 );
    
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

