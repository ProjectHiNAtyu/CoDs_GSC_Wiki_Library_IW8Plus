// script_29c058da7e4449be  (hash_29c058da7e4449be.gscc) (size: 4014 Bytes / 0xfae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x46157ac6 (1175812806)
// size ...... 4014 (0xfae)
// includes .. 4   (offset: 0xe3e)
// strings ... 19  (offset: 0xe5e)
// dev strs .. 0   (offset: 0xfae)
// exports ... 8   (offset: 0x8a6)
// cseg ...... 0x23a + 0x66c (0x8a6)
// imports ... 32  (offset: 0x9e6)
// animtree1 . 0   (offset: 0xfae)
// animtree2 . 0   (offset: 0xfae)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;

#namespace namespace_c1999f48dcfa9dc3;

// Namespace namespace_c1999f48dcfa9dc3/testautomation
// Params 0, eflags: 0x20
// Checksum 0x97f0a7c7, Offset: 0x258
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_killcycle.gsc", #"GP", &start_test, &setup );
}

// Namespace namespace_c1999f48dcfa9dc3
// Params 0
// Checksum 0xa41a4bc8, Offset: 0x281
// Size: 0xb, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace namespace_c1999f48dcfa9dc3
// Params 0
// Checksum 0xd4f8b3fe, Offset: 0x295
// Size: 0xd4, Type: bool
function start_test()
{
    if ( level.mapname == "rex_mp_firingrange" )
    {
        autotests::set_dvar( @"hash_22b41289ce20ae5a", 1 );
    }
    
    autotests::set_dvar( @"hash_5fdf364fef6ac4d0", 1 );
    autotests::push_function( "player damage" );
    test_result_int = test_killcycle_player_damage() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "player damage", test_result_int, undefined, undefined, "scripts/autotests/test_killcycle.gsc", 34 );
    autotests::pop_function( "player damage" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "player death & respawn" );
    test_result_int = function_fb38b86e656b15c9() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "player death & respawn", test_result_int, undefined, undefined, "scripts/autotests/test_killcycle.gsc", 36 );
    autotests::pop_function( "player death & respawn" );
    autotests::test_assert_return( test_result_int );
    function_40cf5b26f2959d57();
    return false;
}

// Namespace namespace_c1999f48dcfa9dc3
// Params 0
// Checksum 0x22bddc03, Offset: 0x372
// Size: 0x154
function test_killcycle_player_damage()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player found?", isdefined( player ), "scripts/autotests/test_killcycle.gsc", 46 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_fae34d766362e13b = 10;
    previoushealth = player.health;
    var_63a718d91714219d = autotests::function_e5040106e5cc1c59( "Player health > damage to do?", previoushealth, var_fae34d766362e13b, "scripts/autotests/test_killcycle.gsc", 51 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Can DoDamage to player?", player dodamage( var_fae34d766362e13b, player.origin, player ), "scripts/autotests/test_killcycle.gsc", 53 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::test_wait_any( "Player received damage?", player, [ "damage" ], 4, "scripts/autotests/test_killcycle.gsc", 55 );
    var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "Player took at least that damage?", previoushealth - player.health, var_fae34d766362e13b, "scripts/autotests/test_killcycle.gsc", 57 );
    
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

// Namespace namespace_c1999f48dcfa9dc3
// Params 0
// Checksum 0xbee43089, Offset: 0x4cf
// Size: 0xdf
function function_fb38b86e656b15c9()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player found?", isdefined( player ), "scripts/autotests/test_killcycle.gsc", 65 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Can DoDamage MaxHealth + 100 damage to player?", player dodamage( player.maxhealth + 100, player.origin, player ), "scripts/autotests/test_killcycle.gsc", 67 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    events = [ "damage", "spawned" ];
    autotests::test_wait_all( "Player took damage and respawned?", player, events, 4, "scripts/autotests/test_killcycle.gsc", 70 );
    wait 1;
    return 0;
}

// Namespace namespace_c1999f48dcfa9dc3
// Params 0
// Checksum 0x26bc5343, Offset: 0x5b7
// Size: 0x12a
function function_40cf5b26f2959d57()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player found?", isdefined( player ), "scripts/autotests/test_killcycle.gsc", 79 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    botdata = autotests_utility_bot::get_spawn_data( player, 90 );
    bot = autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, botdata );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could spawn bot?", isdefined( bot ), "scripts/autotests/test_killcycle.gsc", 85 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 1;
    targetangles = vectortoangles( bot.origin - player.origin - ( 0, 0, 10 ) );
    player setplayerangles( targetangles );
    setdvar( @"player_sustainammo", 1 );
    test_result_int = function_dffcacb9f71c3a75( player, bot );
    bot autotests_utility_bot::cleanup();
    setdvar( @"player_sustainammo", 0 );
    return test_result_int;
}

// Namespace namespace_c1999f48dcfa9dc3
// Params 2
// Checksum 0x5e07fbf1, Offset: 0x6ea
// Size: 0x1bb
function function_dffcacb9f71c3a75( player, bot )
{
    player startforcedfire();
    res = bot utility::waittill_any_timeout( 0.5, "damage" );
    player stopforcedfire();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Can damage bot?", res == "damage", "scripts/autotests/test_killcycle.gsc", 109 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot alive before shots?", isalive( bot ), "scripts/autotests/test_killcycle.gsc", 112 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    max_bursts = 4;
    botdied = 0;
    
    for ( i = 0; i < max_bursts ; i++ )
    {
        player startforcedfire();
        res = bot utility::waittill_any_timeout( 0.5, "death" );
        player stopforcedfire();
        
        if ( res == "death" )
        {
            botdied = 1;
            break;
        }
        else
        {
            targetangles = vectortoangles( bot.origin - player.origin - ( 0, 0, 30 ) );
            player setplayerangles( targetangles );
        }
        
        wait 0.5;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot died from shots?", botdied, "scripts/autotests/test_killcycle.gsc", 136 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::test_wait_any( "Bot respawned within 10s?", bot, [ "spawned" ], 10, "scripts/autotests/test_killcycle.gsc", 138 );
    return 0;
}

