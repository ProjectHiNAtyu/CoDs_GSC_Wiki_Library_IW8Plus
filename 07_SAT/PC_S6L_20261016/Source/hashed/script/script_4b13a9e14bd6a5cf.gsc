// script_4b13a9e14bd6a5cf  (hash_4b13a9e14bd6a5cf.gscc) (size: 7561 Bytes / 0x1d89 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28eeab30 (686730032)
// size ...... 7561 (0x1d89)
// includes .. 4   (offset: 0x1ae5)
// strings ... 36  (offset: 0x1b05)
// dev strs .. 0   (offset: 0x1d89)
// exports ... 14  (offset: 0x10ed)
// cseg ...... 0x2d5 + 0xe18 (0x10ed)
// imports ... 60  (offset: 0x131d)
// animtree1 . 0   (offset: 0x1d89)
// animtree2 . 0   (offset: 0x1d89)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;

#namespace namespace_541192789d2c75ca;

// Namespace namespace_541192789d2c75ca/testautomation
// Params 0, eflags: 0x20
// Checksum 0x30c9eb2f, Offset: 0x2f3
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_locomotion.gsc", #"GP", &start_test, &autotests::function_5c8c87763724c132, &cleanup_test );
}

// Namespace namespace_541192789d2c75ca
// Params 0
// Checksum 0xab06c1ad, Offset: 0x321
// Size: 0x365
function start_test()
{
    autotests::set_dvar( @"hash_5fdf364fef6ac4d0", 1 );
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player found?", isdefined( player ), "scripts/autotests/test_locomotion.gsc", 27 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    self.player = player;
    bot = autotests_utility_bot::function_e4afe0f2cd6331a6( player.team, autotests_utility_bot::get_spawn_data( player, 400, 1 ) );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could spawn bot?", isdefined( bot ), "scripts/autotests/test_locomotion.gsc", 31 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    self.bot = bot;
    player thread autotests_utility_player::function_9275480f08b78840( bot );
    
    if ( bundle.var_45b0af856d3a7b3 )
    {
        autotests::push_function( "Bot stances" );
        test_result_int = check_stances( bot ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Bot stances", test_result_int, undefined, undefined, "scripts/autotests/test_locomotion.gsc", 39 );
        autotests::pop_function( "Bot stances" );
        autotests::test_assert_return( test_result_int );
    }
    
    if ( bundle.checkjump )
    {
        autotests::push_function( "Bot jump" );
        test_result_int = check_jump( bot ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Bot jump", test_result_int, undefined, undefined, "scripts/autotests/test_locomotion.gsc", 45 );
        autotests::pop_function( "Bot jump" );
        autotests::test_assert_return( test_result_int );
    }
    
    if ( bundle.checkslide )
    {
        autotests::push_function( "Bot slide" );
        test_result_int = check_slide( bot ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Bot slide", test_result_int, undefined, undefined, "scripts/autotests/test_locomotion.gsc", 51 );
        autotests::pop_function( "Bot slide" );
        autotests::test_assert_return( test_result_int );
    }
    
    if ( bundle.checkdive )
    {
        autotests::push_function( "Bot dive" );
        test_result_int = check_dive( bot ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Bot dive", test_result_int, undefined, undefined, "scripts/autotests/test_locomotion.gsc", 57 );
        autotests::pop_function( "Bot dive" );
        autotests::test_assert_return( test_result_int );
    }
    
    if ( bundle.checkmovement )
    {
        autotests::push_function( "Bot movement" );
        test_result_int = check_movement( bot ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Bot movement", test_result_int, undefined, undefined, "scripts/autotests/test_locomotion.gsc", 63 );
        autotests::pop_function( "Bot movement" );
        autotests::test_assert_return( test_result_int );
    }
    
    if ( bundle.checklaststand )
    {
        autotests::push_function( "Last Stand" );
        test_result_int = check_last_stand( bot, player ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Last Stand", test_result_int, undefined, undefined, "scripts/autotests/test_locomotion.gsc", 69 );
        autotests::pop_function( "Last Stand" );
        autotests::test_assert_return( test_result_int );
    }
    
    if ( bundle.checkbleedout )
    {
        autotests::push_function( "Bleed Out" );
        test_result_int = check_bleed_out( bot ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Bleed Out", test_result_int, undefined, undefined, "scripts/autotests/test_locomotion.gsc", 75 );
        autotests::pop_function( "Bleed Out" );
        autotests::test_assert_return( test_result_int );
    }
    
    wait 5;
    return 0;
}

// Namespace namespace_541192789d2c75ca
// Params 0
// Checksum 0xffd7d7af, Offset: 0x68f
// Size: 0x3b
function cleanup_test()
{
    if ( isdefined( self.bot ) )
    {
        self.bot autotests_utility_bot::cleanup();
    }
    
    if ( self.player )
    {
        self.player autotests_utility_player::reset_player_angles();
    }
}

// Namespace namespace_541192789d2c75ca
// Params 1
// Checksum 0xeba36e25, Offset: 0x6d2
// Size: 0x168
function check_movement( bot )
{
    bot autotests_utility_bot::enable_movement();
    speeds = [ 0.5, 1 ];
    dirs = [ 0, 90, 180, 270 ];
    time_to_move_seconds = 1;
    min_distance_moved = 0.01;
    
    for ( var_9141a998d93fc94a = 0; var_9141a998d93fc94a < speeds.size ; var_9141a998d93fc94a++ )
    {
        for ( di = 0; di < dirs.size ; di++ )
        {
            prev_origin = bot.origin;
            direction = dirs[ di ];
            speed = speeds[ var_9141a998d93fc94a ];
            bot utility::callsharedfunc( #"bots", #"hash_af78c5b5a80e13b4", direction, time_to_move_seconds, speed );
            wait time_to_move_seconds;
            var_78462faf6c7ef97d = distance( prev_origin, bot.origin );
            var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "Bot moved? Speed[" + speed + "] Direction [" + direction + "]", var_78462faf6c7ef97d, min_distance_moved, "scripts/autotests/test_locomotion.gsc", 121 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
        }
    }
    
    bot autotests_utility_bot::disable_movement();
}

// Namespace namespace_541192789d2c75ca
// Params 1
// Checksum 0x4e6d904e, Offset: 0x842
// Size: 0x18c
function check_stances( bot )
{
    stances = [ "stand", "prone", "stand", "crouch", "prone", "crouch", "stand" ];
    dz_dir = [ 0, -1, 1, -1, -1, 1, 1 ];
    z_prev = 0;
    minz_change = 10;
    
    for ( i = 0; i < stances.size ; i++ )
    {
        bot autotests_utility_bot::set_stance( stances[ i ] );
        stance = bot getstance();
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Bot entered stance? [" + stances[ i ] + "]", stance, stances[ i ], "scripts/autotests/test_locomotion.gsc", 140 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        z = bot geteye()[ 2 ];
        
        if ( i > 0 )
        {
            z_change = ( z - z_prev ) * dz_dir[ i ];
            var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "Enough stance Z change?", z_change, minz_change, "scripts/autotests/test_locomotion.gsc", 146 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
        }
        
        z_prev = z;
    }
}

// Namespace namespace_541192789d2c75ca
// Params 1
// Checksum 0x8ce4222c, Offset: 0x9d6
// Size: 0x78
function check_jump( bot )
{
    prev_origin = bot.origin;
    bot autotests_utility_bot::function_aaa2288bee31d766( "jump", 0.1, undefined );
    
    if ( abs( prev_origin[ 2 ] - bot.origin[ 2 ] ) < 0.01 || distance2d( prev_origin, bot.origin ) > 0.01 )
    {
        return 1;
    }
    
    wait 1;
}

// Namespace namespace_541192789d2c75ca
// Params 2
// Checksum 0x81071315, Offset: 0xa56
// Size: 0x2e4
function check_last_stand( bot, player )
{
    level.var_28e3415171f7169b = 1;
    level.var_5a32b792b8e156b0 = 1;
    enter_last_stand( bot );
    is_in = istrue( utility::callsharedfunc( #"laststand", #"hash_a53ceb859c8f1796", bot ) );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could bot enter last stand?" + ( is_in ? " Success" : " Failed" ), is_in, "scripts/autotests/test_locomotion.gsc", 173 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 1.2;
    last_stand_hold_time = level.laststandrevivetimer ?? 5;
    bot autotests_utility_bot::function_aaa2288bee31d766( "use", 0, last_stand_hold_time + 1 );
    wait last_stand_hold_time + 1.1;
    is_exit_laststand = !utility::callsharedfunc( #"laststand", #"hash_a53ceb859c8f1796", bot ) && isalive( bot );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could bot revive itself?" + ( is_exit_laststand ? " Success" : " Failed" ), is_exit_laststand, "scripts/autotests/test_locomotion.gsc", 183 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    enter_last_stand( player );
    is_in = istrue( utility::callsharedfunc( #"laststand", #"hash_a53ceb859c8f1796", player ) );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could player enter last stand?" + ( is_in ? " Success" : " Failed" ), is_in, "scripts/autotests/test_locomotion.gsc", 188 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 1.2;
    var_fab0e41c285d4866 = player autotests_utility_player::function_c18463940ac9de4();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Found safe location to revive player?", var_fab0e41c285d4866, "scripts/autotests/test_locomotion.gsc", 195 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bot setorigin( var_fab0e41c285d4866, 1 );
    wait 0.25;
    direction = vectornormalize( player.origin - bot.origin );
    bot setplayerangles( vectortoangles( direction ) );
    bot autotests_utility_bot::function_aaa2288bee31d766( "use", 0, last_stand_hold_time + 2 );
    msg = player utility::waittill_any_timeout( last_stand_hold_time + 2, "laststand_revived" );
    is_revived = msg == "laststand_revived";
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could bot revive player?" + ( is_revived ? " Success" : " Failed" ), is_revived, "scripts/autotests/test_locomotion.gsc", 207 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace namespace_541192789d2c75ca
// Params 1, eflags: 0x4
// Checksum 0xb59136f, Offset: 0xd42
// Size: 0x112
function private enter_last_stand( player )
{
    if ( !isdefined( player.perks[ "specialty_pistoldeath" ] ) )
    {
        player utility::callsharedfunc( #"perk", #"giveperk", "specialty_pistoldeath" );
    }
    
    if ( player.spawnprotection )
    {
        player.spawnprotection = 0;
    }
    
    var_6b2c387ee2c00367 = player utility::callsharedfunc( #"laststand", #"hash_937909b5e3eb98ab" );
    
    if ( isnumber( var_6b2c387ee2c00367 ) && var_6b2c387ee2c00367 < 1 )
    {
        player utility::callsharedfunc( #"laststand", #"hash_cce6b6252122ca0" );
    }
    
    for ( try_count = 3; try_count > 0 ; try_count-- )
    {
        player dodamage( player.health + 666, player.origin, player );
        wait 0.2;
        
        if ( utility::callsharedfunc( #"laststand", #"hash_a53ceb859c8f1796", player ) )
        {
            break;
        }
    }
}

// Namespace namespace_541192789d2c75ca
// Params 1
// Checksum 0x14bd2dc8, Offset: 0xe5c
// Size: 0x149
function check_bleed_out( player )
{
    level.var_28e3415171f7169b = 1;
    level.var_5a32b792b8e156b0 = 1;
    level.var_daa8e6704828e14f = 0;
    enter_last_stand( player );
    is_in = istrue( utility::callsharedfunc( #"laststand", #"hash_a53ceb859c8f1796", player ) );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could bot enter last stand?" + ( is_in ? " Success" : " Failed" ), is_in, "scripts/autotests/test_locomotion.gsc", 253 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bleed_out_time = player.var_57e1d1441440e957 ?? level.laststandtimer ?? 10;
    msg = player utility::waittill_any_timeout( bleed_out_time + 1, "death" );
    is_bleed_out = msg == "death";
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could bot bleed out?" + ( is_bleed_out ? " Success" : " Failed" ), is_bleed_out, "scripts/autotests/test_locomotion.gsc", 259 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace namespace_541192789d2c75ca
// Params 1
// Checksum 0x159b4c2b, Offset: 0xfad
// Size: 0x1c
function check_slide( bot )
{
    return bot function_610650479426a8d1( "slide", &issprintsliding );
}

// Namespace namespace_541192789d2c75ca
// Params 1
// Checksum 0x8a145617, Offset: 0xfd2
// Size: 0x1c
function check_dive( bot )
{
    return bot function_610650479426a8d1( "dtp", &isdiving );
}

// Namespace namespace_541192789d2c75ca
// Params 3, eflags: 0x4
// Checksum 0xa0e95d48, Offset: 0xff7
// Size: 0x8c, Type: bool
function private function_610650479426a8d1( var_203c2fc5733be82b, flag_function, timeout )
{
    thread function_fb10eadce5c40adb( flag_function );
    autotests_utility_bot::enable_movement();
    autotests_utility_bot::function_aaa2288bee31d766( "sprint", 0.25, 1 );
    autotests_utility_bot::function_aaa2288bee31d766( var_203c2fc5733be82b, 0 );
    result = level utility::waittill_any_timeout( timeout ?? 5, "movement_flag_changed" );
    autotests_utility_bot::disable_movement();
    
    if ( result == "timeout" )
    {
        level notify( #"movement_flag_changed" );
        return true;
    }
    
    return false;
}

// Namespace namespace_541192789d2c75ca
// Params 1, eflags: 0x4
// Checksum 0x31f7e6c0, Offset: 0x108c
// Size: 0x61
function private function_fb10eadce5c40adb( flag_function )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    level endon( #"end_test" );
    level endon( #"movement_flag_changed" );
    
    while ( self )
    {
        if ( self builtin [[ flag_function ]]() )
        {
            break;
        }
        
        waitframe();
    }
    
    wait 0.1;
    level notify( #"movement_flag_changed" );
}

