// scripts\autotests\autotests_utility_bot.gsc  (hash_398ba4a5810103e6.gscc) (size: 5805 Bytes / 0x16ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf69b625f (4137378399)
// size ...... 5805 (0x16ad)
// includes .. 4   (offset: 0x1569)
// strings ... 17  (offset: 0x1589)
// dev strs .. 4   (offset: 0x167d)
// exports ... 26  (offset: 0xc85)
// cseg ...... 0x1da + 0xaab (0xc85)
// imports ... 39  (offset: 0x1095)
// animtree1 . 0   (offset: 0x16ad)
// animtree2 . 0   (offset: 0x16ad)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;

#namespace autotests_utility_bot;

// Namespace autotests_utility_bot
// Params 2
// Checksum 0x5eff19e7, Offset: 0x1f8
// Size: 0x2c
function create_spawn_data( origin, angles )
{
    return { #angles:angles, #origin:origin };
}

// Namespace autotests_utility_bot
// Params 3
// Checksum 0x75d25d8a, Offset: 0x22d
// Size: 0x30
function get_spawn_data( player, spawndist, collisioncheck = 0 )
{
    return autotests_utility_player::get_spawn_data( player, spawndist, collisioncheck );
}

// Namespace autotests_utility_bot
// Params 0, eflags: 0x4
// Checksum 0x7bc24edf, Offset: 0x266
// Size: 0x34
function private function_cabfaf49729f4823()
{
    if ( level.onspawnplayer != &ourspawncallback )
    {
        level.var_c3d69d7a4957aed8 = level.onspawnplayer;
        level.onspawnplayer = &ourspawncallback;
    }
}

// Namespace autotests_utility_bot
// Params 0, eflags: 0x4
// Checksum 0x8745113b, Offset: 0x2a2
// Size: 0x3c
function private function_343757b2d2a5ddbf()
{
    self function_3a7598d6982eb648( 1 );
    self setorigin( self.pers[ #"hash_b93fc0bfcebae51a" ] );
    self setplayerangles( self.pers[ #"testspawnangles" ] );
}

// Namespace autotests_utility_bot
// Params 1, eflags: 0x4
// Checksum 0xf627bc00, Offset: 0x2e6
// Size: 0x43
function private ourspawncallback( revivespawn )
{
    if ( level.var_c3d69d7a4957aed8 )
    {
        [[ level.var_c3d69d7a4957aed8 ]]( revivespawn );
    }
    
    if ( self.pers[ #"testbotspawn" ] )
    {
        function_343757b2d2a5ddbf();
    }
}

// Namespace autotests_utility_bot
// Params 0, eflags: 0x4
// Checksum 0xedb257ef, Offset: 0x331
// Size: 0xc
function private function_cf34d10873711169()
{
    level.test_bot = self;
}

// Namespace autotests_utility_bot
// Params 2
// Checksum 0x797368e2, Offset: 0x345
// Size: 0x2e
function function_978126f411fc8a11( player, spawndata )
{
    return function_e4afe0f2cd6331a6( utility::get_enemy_team( player.team ), spawndata );
}

// Namespace autotests_utility_bot
// Params 2
// Checksum 0xd76fdfd9, Offset: 0x37c
// Size: 0x28
function function_b04d08d80ae08dcb( player, spawndata )
{
    return function_e4afe0f2cd6331a6( player.team, spawndata );
}

// Namespace autotests_utility_bot
// Params 2
// Checksum 0x375f828e, Offset: 0x3ad
// Size: 0x297
function function_e4afe0f2cd6331a6( botteam, spawndata )
{
    if ( !isdefined( botteam ) )
    {
        return function_978126f411fc8a11( autotests_utility_player::get_player(), spawndata );
    }
    
    if ( !isnavmeshloaded() )
    {
        assertmsg( "<dev string:x24>" + level.mapname + "<dev string:x51>" );
        return;
    }
    
    level.test_bot = undefined;
    
    if ( spawndata )
    {
        function_cabfaf49729f4823();
    }
    
    [[ level.bot_funcs[ "bots_spawn" ] ]]( 1, botteam, &function_cf34d10873711169 );
    starttime = gettime();
    
    while ( !level.test_bot )
    {
        waitframe();
        
        if ( gettime() - starttime > 1000 )
        {
            autotests::function_d84657f448aaeef6( "Bot not spawned in 1 seconds!", 0, "scripts/autotests/autotests_utility_bot.gsc", 85 );
            return;
        }
    }
    
    if ( spawndata )
    {
        level.test_bot function_3a7598d6982eb648( 1 );
        level.test_bot.pers[ #"testbotspawn" ] = 1;
        level.test_bot.pers[ #"hash_b93fc0bfcebae51a" ] = spawndata.origin;
        level.test_bot.pers[ #"testspawnangles" ] = spawndata.angles;
    }
    
    starttime = gettime();
    
    while ( !( level.test_bot.hasspawned && isalive( level.test_bot ) && level.test_bot.sessionstate == "playing" ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 3000 )
        {
            autotests::function_d84657f448aaeef6( "Bot not in playing state within 3 seconds!", 0, "scripts/autotests/autotests_utility_bot.gsc", 94 );
            return;
        }
    }
    
    if ( spawndata )
    {
        level.test_bot function_343757b2d2a5ddbf();
    }
    
    if ( isdefined( botteam ) )
    {
        if ( !isdefined( level.test_bot.team ) )
        {
            waitframe();
        }
        
        if ( level.test_bot.team != botteam )
        {
            assertmsg( "<dev string:x53>" + botteam + "<dev string:x7d>" + level.test_bot.team );
            level.test_bot cleanup();
            level.test_bot = undefined;
        }
    }
    
    starttime = gettime();
    
    while ( !level.test_bot isonground() )
    {
        waitframe();
        
        if ( gettime() - starttime > 5000 )
        {
            autotests::function_d84657f448aaeef6( "Bot spawned but is not on ground within 5seconds!", 0, "scripts/autotests/autotests_utility_bot.gsc", 116 );
            return;
        }
    }
    
    return level.test_bot;
}

// Namespace autotests_utility_bot
// Params 3
// Checksum 0xc21e6ac, Offset: 0x64d
// Size: 0x90
function function_aa611d4a3829652a( bot, player_target, distance )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "No bot provided.", isdefined( bot ), "scripts/autotests/autotests_utility_bot.gsc", 131 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    spawn_data = get_spawn_data( player_target, distance );
    teleport_bot( bot, spawn_data.origin, spawn_data.angles );
}

// Namespace autotests_utility_bot
// Params 3
// Checksum 0x92264341, Offset: 0x6e5
// Size: 0xaa
function teleport_bot( bot, position, angles )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "No bot provided.", isdefined( bot ), "scripts/autotests/autotests_utility_bot.gsc", 148 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "No position provided.", isdefined( position ), "scripts/autotests/autotests_utility_bot.gsc", 150 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( isdefined( angles ) )
    {
        bot setplayerangles( angles );
    }
    
    bot setorigin( position );
}

// Namespace autotests_utility_bot
// Params 0
// Checksum 0x45d08747, Offset: 0x797
// Size: 0x9
function kick_all_bots()
{
    autotests_utility::kick_all_bots();
}

// Namespace autotests_utility_bot
// Params 0
// Checksum 0x11aa3f5b, Offset: 0x7a8
// Size: 0x10
function cleanup()
{
    if ( self )
    {
        kick( self getentitynumber() );
    }
}

// Namespace autotests_utility_bot
// Params 5
// Checksum 0x516bd9b8, Offset: 0x7c0
// Size: 0x8c
function function_aaa2288bee31d766( var_203c2fc5733be82b, wait_time, hold_time, delay_time, clear_after )
{
    if ( isdefined( self ) && isdefined( var_203c2fc5733be82b ) )
    {
        if ( delay_time )
        {
            wait delay_time;
        }
        
        if ( !isdefined( wait_time ) )
        {
            wait_time = 1;
        }
        
        utility::callsharedfunc( #"bots", #"botpressbutton", var_203c2fc5733be82b, hold_time );
        wait wait_time;
        
        if ( clear_after )
        {
            utility::callsharedfunc( #"bots", #"hash_c042b2ad22baf81f", var_203c2fc5733be82b );
            waitframe();
        }
    }
}

// Namespace autotests_utility_bot
// Params 2
// Checksum 0xbcd250b3, Offset: 0x854
// Size: 0x47
function set_stance( stance, wait_time )
{
    if ( isdefined( self ) && isdefined( stance ) )
    {
        if ( !isdefined( wait_time ) )
        {
            wait_time = 1;
        }
        
        utility::callsharedfunc( #"bots", #"botsetstance", stance );
        wait wait_time;
    }
}

// Namespace autotests_utility_bot
// Params 1
// Checksum 0x6e5670cb, Offset: 0x8a3
// Size: 0xbe
function function_1121167b947740ee( player )
{
    bot = undefined;
    
    foreach ( level_player in level.players )
    {
        if ( level_player.team != player.team && isbot( level_player ) )
        {
            logstring( "Found an enemy bot !" );
            bot = level_player;
            break;
        }
    }
    
    return bot;
}

// Namespace autotests_utility_bot
// Params 2
// Checksum 0xe529ee47, Offset: 0x96a
// Size: 0xd1
function get_bot_data( player, bot )
{
    result = spawnstruct();
    
    if ( isdefined( bot ) )
    {
        result.bot = bot;
    }
    else
    {
        result.bot = function_1121167b947740ee( player );
    }
    
    result.botsource = "from_match";
    
    if ( !isbot( result.bot ) )
    {
        spawndata = get_spawn_data( player, 60 );
        result.bot = function_e4afe0f2cd6331a6( undefined, spawndata );
        result.botsource = "spawned";
        
        if ( !isdefined( result.bot ) )
        {
            result.botsource = "";
        }
    }
    
    return result;
}

// Namespace autotests_utility_bot
// Params 0
// Checksum 0x227251d6, Offset: 0xa44
// Size: 0x25
function enable_movement()
{
    if ( self )
    {
        utility::callsharedfunc( #"bots", #"hash_4ba43f63e842ff68", "disable_movement", 0 );
    }
}

// Namespace autotests_utility_bot
// Params 0
// Checksum 0x60d73db6, Offset: 0xa71
// Size: 0x26
function disable_movement()
{
    if ( self )
    {
        utility::callsharedfunc( #"bots", #"hash_4ba43f63e842ff68", "disable_movement", 1 );
    }
}

// Namespace autotests_utility_bot
// Params 4
// Checksum 0x7ec24bbb, Offset: 0xa9f
// Size: 0x6c
function function_ec410dcd2cbdb91a( bot, endpos, var_daf264e84998cc32, waittime_s )
{
    starttime = gettime();
    
    while ( true )
    {
        if ( distance( bot.origin, endpos ) <= var_daf264e84998cc32 )
        {
            return 1;
        }
        
        if ( gettime() > starttime + waittime_s * 1000 )
        {
            return 0;
        }
        
        waitframe();
    }
}

// Namespace autotests_utility_bot
// Params 0
// Checksum 0xcc20b660, Offset: 0xb13
// Size: 0x2b
function function_503367f224b96494()
{
    utility::callsharedfunc( #"bots", #"botpressbutton", "use", 0.1 );
    wait 0.2;
}

// Namespace autotests_utility_bot
// Params 0
// Checksum 0xef39b9f6, Offset: 0xb46
// Size: 0x6a, Type: bool
function try_pickup_item()
{
    utility::callsharedfunc( #"bots", #"botpressbutton", "use", 0.5 );
    result = utility::waittill_any_in_array_or_timeout( [ "self_pickedupitem" ], 1 );
    utility::callsharedfunc( #"bots", #"hash_c042b2ad22baf81f", "use" );
    waitframe();
    return result == "self_pickedupitem";
}

// Namespace autotests_utility_bot
// Params 2
// Checksum 0xe09f24de, Offset: 0xbb9
// Size: 0x4d
function function_1b7c0308a9821886( oldbot, spawndata )
{
    oldteam = oldbot.team;
    kick( oldbot getentitynumber() );
    newbot = function_e4afe0f2cd6331a6( oldteam, spawndata );
    waitframe();
    return newbot;
}

// Namespace autotests_utility_bot
// Params 2
// Checksum 0xa531fed5, Offset: 0xc0f
// Size: 0x37
function set_bot_godmode( bot, enabled )
{
    bot utility::callsharedfunc( #"bots", #"hash_4ba43f63e842ff68", "god_mode", enabled );
}

// Namespace autotests_utility_bot
// Params 2
// Checksum 0x42951961, Offset: 0xc4e
// Size: 0x37
function set_bot_ignore_script_weapon( bot, enabled )
{
    bot utility::callsharedfunc( #"bots", #"hash_4ba43f63e842ff68", "ignore_script_weapon", enabled );
}

