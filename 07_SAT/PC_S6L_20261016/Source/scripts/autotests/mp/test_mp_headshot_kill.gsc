// scripts\autotests\mp\test_mp_headshot_kill.gsc  (hash_20d049dd2fcd5941.gscc) (size: 4858 Bytes / 0x12fa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x70d148bd (1892763837)
// size ...... 4858 (0x12fa)
// includes .. 6   (offset: 0x11c6)
// strings ... 19  (offset: 0x11f6)
// dev strs .. 0   (offset: 0x12fa)
// exports ... 10  (offset: 0xb6a)
// cseg ...... 0x1c5 + 0x9a5 (0xb6a)
// imports ... 40  (offset: 0xcfa)
// animtree1 . 0   (offset: 0x12fa)
// animtree2 . 0   (offset: 0x12fa)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ai_mp_controller;

#namespace test_mp_headshot_kill;

// Namespace test_mp_headshot_kill/testautomation
// Params 0, eflags: 0x20
// Checksum 0x49a16da8, Offset: 0x1e3
// Size: 0x2a
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_headshot_kill.gsc", #"test", &start_test, &setup, &cleanup, undefined, undefined, 1 );
}

// Namespace test_mp_headshot_kill
// Params 2
// Checksum 0x4c2cdf97, Offset: 0x215
// Size: 0x35
function on_bot_killed( deathdata, context )
{
    if ( deathdata.meansofdeath == "MOD_HEAD_SHOT" )
    {
        context.var_78ae57c8d1c30375++;
    }
}

// Namespace test_mp_headshot_kill
// Params 0
// Checksum 0xc411bb5a, Offset: 0x252
// Size: 0x697
function start_test()
{
    context = spawnstruct();
    context.result = 1;
    context.var_78ae57c8d1c30375 = 0;
    context.target_bot_id = 0;
    level callback::add( #"on_ai_killed", &on_bot_killed, context );
    level callback::add( #"player_death", &on_bot_killed, context );
    params = level.autotests.test_runtime.parameters;
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    context.var_5fc17e155195cbe = ( params[ 0 ] ? int( params[ 0 ] ) : undefined ) ?? bundle.var_99c4197936f19886 ?? 5;
    maxtry = ( params[ 1 ] ? int( params[ 1 ] ) : undefined ) ?? bundle.var_5cef6d01ced4ee91 ?? context.var_5fc17e155195cbe * 2;
    var_c074c0edb7ae9711 = params[ 2 ] ?? bundle.var_c074c0edb7ae9711;
    
    if ( level.autotests.test_runtime.is_dmz )
    {
        var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Valid agent type?", var_c074c0edb7ae9711, "", "scripts/autotests/mp/test_mp_headshot_kill.gsc", 44 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    context.var_5fc17e155195cbe = clamp( context.var_5fc17e155195cbe, 1, 300 );
    maxtry = clamp( maxtry, context.var_5fc17e155195cbe, 600 );
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player Is Alive At Test Start?", isalive( player ), "scripts/autotests/mp/test_mp_headshot_kill.gsc", 51 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player.var_24be19543bc8efc = "start";
    primary_weapons = player.primaryweapons;
    
    foreach ( weapon in primary_weapons )
    {
        autotests::set_current_asset_name( weapon.basename );
        break;
    }
    
    wait 1;
    level.var_a5ecc4fd7d64db7b = 1;
    availablebots = level.players.size > 1;
    
    if ( availablebots )
    {
        availablebots = 0;
        
        foreach ( botplayer in level.players )
        {
            if ( function_2fbd616281b92ced( player, botplayer ) )
            {
                availablebots = 1;
                break;
            }
        }
    }
    
    botkilled = 1;
    
    while ( context.target_bot_id < maxtry && context.var_78ae57c8d1c30375 < context.var_5fc17e155195cbe && !level.gameended )
    {
        if ( availablebots )
        {
            foreach ( level_player in level.players )
            {
                if ( function_2fbd616281b92ced( player, level_player ) )
                {
                    bot = level_player;
                    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Checking for Bot to perform headshot kill", bot, "scripts/autotests/mp/test_mp_headshot_kill.gsc", 90 );
                    
                    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                    {
                        if ( autotests::function_561cb32cd7469145() )
                        {
                            return;
                        }
                        
                        autotests::test_assert_return( var_63a718d91714219d );
                    }
                    
                    if ( !player autotests_utility_player::set_player_location( bot, 60, anglestoforward( bot getplayerangles() ) ) )
                    {
                        continue;
                    }
                    
                    wait 0.25;
                    player autotests_utility_player::function_a29ba7836e10842e( bot );
                    wait 0.25;
                    autotests_utility_player::function_46f72ef9b143f2f1( player, bot, 5, 1 );
                    wait 0.25;
                }
            }
        }
        else
        {
            if ( botkilled )
            {
                bot = function_a2af76bb628d893f( player, var_c074c0edb7ae9711 );
                var_63a718d91714219d = autotests::function_36ed835262a19e53( "Checking for Bot to perform headshot kill", bot, "scripts/autotests/mp/test_mp_headshot_kill.gsc", 110 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                bot.nocorpse = 1;
            }
            
            player autotests_utility_player::function_a29ba7836e10842e( bot );
            wait 0.25;
            botkilled = autotests_utility_player::function_46f72ef9b143f2f1( player, bot, 5, 1 );
            wait 0.25;
            
            if ( !level.autotests.test_runtime.is_dmz )
            {
                bot utility::waittill_any_in_array_or_timeout( [ "spawned" ], 5 );
            }
        }
        
        context.target_bot_id++;
        wait 0.25;
    }
    
    var_4fb0264ef88dffdc = context.var_78ae57c8d1c30375 >= context.var_5fc17e155195cbe;
    
    if ( !var_4fb0264ef88dffdc && level.gameended )
    {
        context.result = 5;
        autotests::function_d84657f448aaeef6( "Match ended before obtaining " + context.var_5fc17e155195cbe + " Headshot kills, obtained " + context.var_78ae57c8d1c30375 + ".", 1, "scripts/autotests/mp/test_mp_headshot_kill.gsc", 136 );
    }
    else
    {
        context.result = var_4fb0264ef88dffdc ? 0 : 1;
        autotests::function_d84657f448aaeef6( ( var_4fb0264ef88dffdc ? "Succeeded" : "Failed" ) + " to obtain " + context.var_5fc17e155195cbe + " Headshot kills.", var_4fb0264ef88dffdc, "scripts/autotests/mp/test_mp_headshot_kill.gsc", 141 );
    }
    
    wait 1;
    autotests::set_current_asset_name( "" );
    level callback::remove( #"on_ai_killed", &on_bot_killed, context );
    level callback::remove( #"player_death", &on_bot_killed, context );
    return context.result;
}

// Namespace test_mp_headshot_kill
// Params 2, eflags: 0x4
// Checksum 0xc99a9495, Offset: 0x8f2
// Size: 0x79, Type: bool
function private function_2fbd616281b92ced( localplayer, botplayer )
{
    if ( !localplayer || !botplayer )
    {
        return false;
    }
    
    if ( !isbot( botplayer ) || !isalive( botplayer ) )
    {
        return false;
    }
    
    if ( localplayer.team == botplayer.team )
    {
        return false;
    }
    
    if ( botplayer.sessionstate != "playing" || botplayer isspectatinganyone() )
    {
        return false;
    }
    
    return true;
}

// Namespace test_mp_headshot_kill
// Params 0, eflags: 0x4
// Checksum 0x788fbab3, Offset: 0x974
// Size: 0x7f, Type: bool
function private setup()
{
    level.autotests.test_runtime.is_dmz = getdvar( @"ui_gametype" ) == "dmz";
    autotests::function_5c8c87763724c132();
    autotests::set_dvar( @"player_sustainammo", 1 );
    
    if ( level.autotests.test_runtime.is_dmz )
    {
        autotests::set_dvar( @"ai_enabled", 0 );
    }
    
    return true;
}

// Namespace test_mp_headshot_kill
// Params 0, eflags: 0x4
// Checksum 0x1ee0fb66, Offset: 0x9fc
// Size: 0x3b
function private cleanup()
{
    if ( level.test_bot )
    {
        level.test_bot autotests_utility_bot::cleanup();
    }
    
    level.autotests.test_runtime.is_dmz = undefined;
}

// Namespace test_mp_headshot_kill
// Params 1, eflags: 0x4
// Checksum 0xa7148e63, Offset: 0xa3f
// Size: 0x2b
function private spawn_mp_bot( player )
{
    botdata = autotests_utility_bot::get_bot_data( player );
    return botdata.bot;
}

// Namespace test_mp_headshot_kill
// Params 2, eflags: 0x4
// Checksum 0xa85b2a07, Offset: 0xa73
// Size: 0xa6
function private function_81bbfc04e21abf6f( player, agenttype )
{
    spawndata = autotests_utility_player::get_spawn_data( player, 60, 0 );
    aiorigin = spawndata.origin;
    aiangles = spawndata.angles;
    agent = ai_mp_controller::spawn( { #category:"reinforcements", #priority:"absolute", #spawnangles:aiangles, #groundspawnorigin:aiorigin, #agenttype:agenttype } );
    return agent;
}

// Namespace test_mp_headshot_kill
// Params 2
// Checksum 0xbcae98e9, Offset: 0xb22
// Size: 0x47
function function_a2af76bb628d893f( player, agenttype )
{
    if ( level.autotests.test_runtime.is_dmz )
    {
        return function_81bbfc04e21abf6f( player, agenttype );
    }
    
    return spawn_mp_bot( player );
}

