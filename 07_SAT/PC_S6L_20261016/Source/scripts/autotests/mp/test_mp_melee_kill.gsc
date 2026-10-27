// scripts\autotests\mp\test_mp_melee_kill.gsc  (hash_671d2af2a3257fc9.gscc) (size: 2996 Bytes / 0xbb4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34751b7d (880089981)
// size ...... 2996 (0xbb4)
// includes .. 4   (offset: 0xaec)
// strings ... 12  (offset: 0xb0c)
// dev strs .. 0   (offset: 0xbb4)
// exports ... 5   (offset: 0x67c)
// cseg ...... 0x13f + 0x53d (0x67c)
// imports ... 32  (offset: 0x744)
// animtree1 . 0   (offset: 0xbb4)
// animtree2 . 0   (offset: 0xbb4)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\callbacks;

#namespace test_mp_melee_kill;

// Namespace test_mp_melee_kill/testautomation
// Params 0, eflags: 0x20
// Checksum 0x374423a6, Offset: 0x15d
// Size: 0x2a
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_melee_kill.gsc", #"test", &start_test, &autotests::function_5c8c87763724c132, &cleanup_test, undefined, undefined, 1 );
}

// Namespace test_mp_melee_kill
// Params 2
// Checksum 0x64ea826b, Offset: 0x18f
// Size: 0x41
function on_player_killed( deathdata, context )
{
    context.var_ce15b3feb2d4d425++;
    
    if ( deathdata.meansofdeath == "MOD_MELEE" )
    {
        context.var_b10c6ed34c7b7317++;
    }
}

// Namespace test_mp_melee_kill
// Params 0
// Checksum 0x863a8fde, Offset: 0x1d8
// Size: 0x1e
function cleanup_test()
{
    if ( level.test_bot )
    {
        level.test_bot autotests_utility_bot::cleanup();
    }
}

// Namespace test_mp_melee_kill
// Params 0
// Checksum 0x1dd6aa4d, Offset: 0x1fe
// Size: 0x47d
function start_test()
{
    context = spawnstruct();
    context.result = 1;
    context.var_b10c6ed34c7b7317 = 0;
    context.target_bot_id = 0;
    context.var_ce15b3feb2d4d425 = 0;
    level callback::add( #"player_death", &on_player_killed, context );
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    context.var_5fc17e155195cbe = bundle.var_99c4197936f19886 ?? 6;
    maxtry = bundle.var_5cef6d01ced4ee91 ?? context.var_5fc17e155195cbe * 2;
    player = autotests_utility_player::get_player();
    player.var_24be19543bc8efc = "start";
    botdata = autotests_utility_bot::get_bot_data( player );
    bot = botdata.bot;
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Failed to obtain a target Bot for the melee kill test", bot, "scripts/autotests/mp/test_mp_melee_kill.gsc", 56 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bot.var_24be19543bc8efc = "start";
    wait 1;
    context.target_bot_id = 1;
    level.var_a5ecc4fd7d64db7b = 1;
    player function_ffb0711adb6d8d0d();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_melee_kill.gsc", 67 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    current_weapon = player getcurrentweapon();
    player switchtoweapon( current_weapon );
    var_67b38210f107147b = botdata.botsource == "spawned";
    
    while ( context.target_bot_id < maxtry && context.var_b10c6ed34c7b7317 < context.var_5fc17e155195cbe )
    {
        foreach ( level_player in level.players )
        {
            if ( level_player.team != player.team && isbot( level_player ) )
            {
                botdata = autotests_utility_bot::get_bot_data( player, level_player );
                bot = botdata.bot;
                
                if ( !var_67b38210f107147b )
                {
                    bot = level_player;
                    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Failed to obtain a target Bot for the melee kill test", bot, "scripts/autotests/mp/test_mp_melee_kill.gsc", 84 );
                    
                    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                    {
                        if ( autotests::function_561cb32cd7469145() )
                        {
                            return;
                        }
                        
                        autotests::test_assert_return( var_63a718d91714219d );
                    }
                    
                    botangles = bot getplayerangles();
                    player autotests_utility_player::set_player_location( bot, 60, anglestoforward( botangles ) );
                    wait 0.25;
                }
                
                player autotests_utility_player::function_a29ba7836e10842e( bot, ( 0, 0, 6 ) );
                wait 0.25;
                
                for ( melee_attempts = 0; isalive( level_player ) && melee_attempts < 5 ; melee_attempts++ )
                {
                    player autotests_utility_bot::function_aaa2288bee31d766( "melee", 1, 0.5 );
                    wait 0.05;
                }
            }
            
            if ( context.target_bot_id >= maxtry || context.var_b10c6ed34c7b7317 >= context.var_5fc17e155195cbe )
            {
                break;
            }
            
            context.target_bot_id++;
            wait 0.25;
        }
    }
    
    player playerexitautopilotmode();
    
    if ( var_67b38210f107147b )
    {
        bot autotests_utility_bot::cleanup();
    }
    
    var_4fb0264ef88dffdc = context.var_b10c6ed34c7b7317 >= context.var_5fc17e155195cbe;
    context.result = var_4fb0264ef88dffdc ? 0 : 1;
    autotests::function_d84657f448aaeef6( ( var_4fb0264ef88dffdc ? "Succeeded" : "Failed" ) + " to obtain " + context.var_5fc17e155195cbe + " Melee kills.", var_4fb0264ef88dffdc, "scripts/autotests/mp/test_mp_melee_kill.gsc", 119 );
    wait 1;
    autotests::set_current_asset_name( "" );
    level callback::remove( #"player_death", &on_player_killed, context );
    return context.result;
}

