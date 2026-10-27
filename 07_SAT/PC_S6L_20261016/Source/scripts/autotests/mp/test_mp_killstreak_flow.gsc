// scripts\autotests\mp\test_mp_killstreak_flow.gsc  (hash_44f419668e97436d.gscc) (size: 2565 Bytes / 0xa05 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa66264a6 (2791466150)
// size ...... 2565 (0xa05)
// includes .. 4   (offset: 0x911)
// strings ... 15  (offset: 0x931)
// dev strs .. 0   (offset: 0xa05)
// exports ... 3   (offset: 0x5b5)
// cseg ...... 0x183 + 0x432 (0x5b5)
// imports ... 23  (offset: 0x62d)
// animtree1 . 0   (offset: 0xa05)
// animtree2 . 0   (offset: 0xa05)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;

#namespace test_mp_killstreak_flow;

// Namespace test_mp_killstreak_flow/testautomation
// Params 0, eflags: 0x20
// Checksum 0x21ca184b, Offset: 0x1a1
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_killstreak_flow.gsc", #"GP", &start_test, &autotests::function_5c8c87763724c132 );
}

// Namespace test_mp_killstreak_flow
// Params 0
// Checksum 0x9dea86d4, Offset: 0x1ca
// Size: 0x3ea
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::set_dvar( @"hash_5fdf364fef6ac4d0", 1 );
    autotests::set_current_asset_name( #"uav" );
    slotnumber = player utility::callsharedfunc( #"killstreak", #"hash_ea61dcbd28c71abe", #"uav" );
    
    if ( !isdefined( slotnumber ) )
    {
        player utility::callsharedfunc( #"killstreak", #"hash_6a66ab0ca7442bcd", "uav", 1 );
        slotnumber = 1;
    }
    
    streakitem = player utility::callsharedfunc( #"killstreak", #"hash_b60857d4695788d6", slotnumber );
    var_de233d9e6f79f15 = isdefined( streakitem ) && isdefined( streakitem.currentcost ) && isdefined( streakitem.available );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Valid streak item?", var_de233d9e6f79f15, "scripts/autotests/mp/test_mp_killstreak_flow.gsc", 41 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_5fc17e155195cbe = streakitem.currentcost;
    botdata = autotests_utility_bot::get_spawn_data( player, 45 );
    bot = autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, botdata );
    level.var_a5ecc4fd7d64db7b = 1;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( var_5fc17e155195cbe + " kills needed: Could spawn bot?", isdefined( bot ), "scripts/autotests/mp/test_mp_killstreak_flow.gsc", 51 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    setdvar( @"player_sustainammo", 1 );
    
    for ( i = 0; i < var_5fc17e155195cbe ; i++ )
    {
        var_205a671e5ccd4212 = "[" + i + 1 + "]";
        targetangles = vectortoangles( bot.origin - player.origin - ( 0, 0, 10 ) );
        player setplayerangles( targetangles );
        player startforcedfire();
        autotests::test_wait_any( "Wait for bot death" + var_205a671e5ccd4212, bot, [ "death" ], 5, "scripts/autotests/mp/test_mp_killstreak_flow.gsc", 63 );
        player stopforcedfire();
        wait 1;
        
        if ( streakitem.available )
        {
            break;
        }
        
        autotests::test_wait_any( "Wait for bot spawned" + var_205a671e5ccd4212, bot, [ "spawned" ], 5, "scripts/autotests/mp/test_mp_killstreak_flow.gsc", 73 );
    }
    
    setdvar( @"player_sustainammo", 0 );
    bot autotests_utility_bot::cleanup();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Killstreak item available?", istrue( streakitem.available ), "scripts/autotests/mp/test_mp_killstreak_flow.gsc", 79 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    result = player utility::callsharedfunc( #"killstreak", #"hash_c50c090866d6b55d", streakitem, slotnumber );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Killstreak usable?", istrue( result ), "scripts/autotests/mp/test_mp_killstreak_flow.gsc", 83 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 1;
    damaged = player dodamage( player.maxhealth + 100, player.origin, player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player could suicide?", istrue( damaged ), "scripts/autotests/mp/test_mp_killstreak_flow.gsc", 88 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Killstreakpoints ZERO?", 0, player.streakpoints, "scripts/autotests/mp/test_mp_killstreak_flow.gsc", 90 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::set_current_asset_name( "" );
    return 0;
}

