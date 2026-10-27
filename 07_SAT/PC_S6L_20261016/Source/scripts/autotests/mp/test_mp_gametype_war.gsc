// scripts\autotests\mp\test_mp_gametype_war.gsc  (hash_2e2bebf65fa4ae5f.gscc) (size: 2682 Bytes / 0xa7a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd7bd4246 (3619504710)
// size ...... 2682 (0xa7a)
// includes .. 5   (offset: 0x96a)
// strings ... 15  (offset: 0x992)
// dev strs .. 0   (offset: 0xa7a)
// exports ... 4   (offset: 0x5c6)
// cseg ...... 0x195 + 0x431 (0x5c6)
// imports ... 23  (offset: 0x666)
// animtree1 . 0   (offset: 0xa7a)
// animtree2 . 0   (offset: 0xa7a)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;

#namespace test_mp_gametype_war;

// Namespace test_mp_gametype_war
// Params 0
// Checksum 0x4eb49a84, Offset: 0x1b3
// Size: 0x8, Type: bool
function validate_initial_state()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_mp_gametype_war
// Params 0
// Checksum 0x712bc1f9, Offset: 0x1c4
// Size: 0x18
function test_cleanup()
{
    setdvar( @"player_sustainammo", 0 );
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_gametype_war
// Params 0
// Checksum 0x6694a736, Offset: 0x1e4
// Size: 0x3e1
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::push_function( "Wait for countdown to finish" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Wait for countdown to finish", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_war.gsc", 25 );
    autotests::pop_function( "Wait for countdown to finish" );
    autotests::test_assert_return( test_result_int );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player found", isdefined( player ), "scripts/autotests/mp/test_mp_gametype_war.gsc", 26 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bot_spawn_data = autotests_utility_bot::get_spawn_data( player, 90 );
    bot = autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, bot_spawn_data );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spawned bot", isdefined( bot ), "scripts/autotests/mp/test_mp_gametype_war.gsc", 30 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Player and bot on separate teams", player.team, bot.team, "scripts/autotests/mp/test_mp_gametype_war.gsc", 31 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 1;
    target_angles = vectortoangles( bot.origin - player.origin - ( 0, 0, 10 ) );
    player setplayerangles( target_angles );
    setdvar( @"player_sustainammo", 1 );
    player startforcedfire();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Can damage bot", bot utility::waittill_any_timeout( 1, "damage" ) == "damage", "scripts/autotests/mp/test_mp_gametype_war.gsc", 41 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player stopforcedfire();
    previous_score = game[ "teamScores" ][ player.team ];
    var_fcf4ce45df85bbee = level.scoremod[ "kill" ];
    
    for ( bot_deaths = 0; bot_deaths < 5 ; bot_deaths++ )
    {
        bot_died = 0;
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Is bot alive", isalive( bot ), "scripts/autotests/mp/test_mp_gametype_war.gsc", 52 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        for ( i = 0; i < 4 ; i++ )
        {
            player startforcedfire();
            damage_result = bot utility::waittill_any_timeout( 0.5, "death" );
            player stopforcedfire();
            
            if ( damage_result == "death" )
            {
                bot_died = 1;
                break;
            }
            else
            {
                target_angles = vectortoangles( bot.origin - player.origin - ( 0, 0, 10 ) );
                player setplayerangles( target_angles );
            }
            
            wait 0.5;
        }
        
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot was killed", istrue( bot_died ), "scripts/autotests/mp/test_mp_gametype_war.gsc", 74 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        var_63a718d91714219d = autotests::test_wait_any( "Bot respawned within 10 seconds", bot, [ "spawned" ], 10, "scripts/autotests/mp/test_mp_gametype_war.gsc", 75 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        waitframe();
        current_score = game[ "teamScores" ][ player.team ];
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Correct team score awarded", previous_score + var_fcf4ce45df85bbee, current_score, "scripts/autotests/mp/test_mp_gametype_war.gsc", 79 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        previous_score = current_score;
    }
    
    return 0;
}

