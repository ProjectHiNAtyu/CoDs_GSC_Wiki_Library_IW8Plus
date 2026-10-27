// scripts\autotests\mp\test_mp_emotes.gsc  (hash_31a88e94a6e9040d.gscc) (size: 2765 Bytes / 0xacd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd422d143 (3559051587)
// size ...... 2765 (0xacd)
// includes .. 5   (offset: 0xa2d)
// strings ... 8   (offset: 0xa55)
// dev strs .. 0   (offset: 0xacd)
// exports ... 8   (offset: 0x49d)
// cseg ...... 0x137 + 0x366 (0x49d)
// imports ... 37  (offset: 0x5dd)
// animtree1 . 0   (offset: 0xacd)
// animtree2 . 0   (offset: 0xacd)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_assets;
#using scripts\autotests\mp\autotests_utility_video;

#namespace test_mp_emotes;

// Namespace test_mp_emotes/testautomation
// Params 0, eflags: 0x20
// Checksum 0x7a6f996, Offset: 0x155
// Size: 0x2b
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_emotes.gsc", #"test", &start_test, &setup, &cleanup, &parameterize );
}

// Namespace test_mp_emotes
// Params 1
// Checksum 0x252fe8f2, Offset: 0x188
// Size: 0x20
function parameterize( dataset )
{
    emotes_list = autotests_utility_assets::function_6cf56b36fc49d848();
    return emotes_list;
}

// Namespace test_mp_emotes
// Params 0
// Checksum 0x785adb83, Offset: 0x1b1
// Size: 0xf6
function create_bot()
{
    player = autotests_utility_player::get_player();
    botdata = autotests_utility_bot::get_spawn_data( player, 400 );
    spawned_bot = autotests_utility_bot::function_978126f411fc8a11( player, botdata );
    spawned_bot function_3a7598d6982eb648( 1 );
    spawned_bot setplayerangles( vectortoangles( player.origin - botdata.origin + ( 0, 0, 0 ) ) );
    autotests_utility_video::function_2083bbbdfedfe07e( autotests::get_test_bundle( self.test.xhash_ref ) );
    starttime = gettime();
    
    while ( !spawned_bot isonground() )
    {
        waitframe();
        
        if ( gettime() - starttime > 5000 )
        {
            autotests::function_d84657f448aaeef6( "Spawned Bot was on ground in 5 seconds.", 0, "scripts/autotests/mp/test_mp_emotes.gsc", 32 );
            return;
        }
    }
    
    level.autotests.test_runtime.bot = spawned_bot;
    return spawned_bot;
}

// Namespace test_mp_emotes
// Params 0
// Checksum 0x531c2bb9, Offset: 0x2b0
// Size: 0xf5
function start_test()
{
    emote_name = self.parameters[ 0 ];
    autotests::set_current_asset_name( emote_name );
    player = autotests_utility_player::get_player();
    bot = create_bot();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player Is Alive At Test Start?", isalive( player ), "scripts/autotests/mp/test_mp_emotes.gsc", 45 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot Is Alive At Test Start?", isalive( bot ), "scripts/autotests/mp/test_mp_emotes.gsc", 46 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 3;
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "bot_emote" );
    bot test_emote( emote_name );
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "bot_emote" );
    autotests_utility_bot::kick_all_bots();
    return 0;
}

// Namespace test_mp_emotes
// Params 1
// Checksum 0x91973d94, Offset: 0x3ae
// Size: 0xa7
function test_emote( emote_name )
{
    self setclientomnvar( "can_emote", 1 );
    self givedebugemote( emote_name );
    self playemote( emote_name );
    starttime = gettime();
    
    while ( !self isemoteactive() )
    {
        waitframe();
        
        if ( gettime() - starttime > 1000 )
        {
            autotests::function_d84657f448aaeef6( "Emote Started", 0, "scripts/autotests/mp/test_mp_emotes.gsc", 63 );
            return;
        }
    }
    
    starttime = gettime();
    
    while ( !!self isemoteactive() )
    {
        waitframe();
        
        if ( gettime() - starttime > 30000 )
        {
            autotests::function_d84657f448aaeef6( "Emote Ended in 30 seconds", 0, "scripts/autotests/mp/test_mp_emotes.gsc", 64 );
            return;
        }
    }
    
    self stopemote();
    return 0;
}

// Namespace test_mp_emotes
// Params 0, eflags: 0x4
// Checksum 0xbbb4228d, Offset: 0x45e
// Size: 0x26, Type: bool
function private setup()
{
    autotests_utility_video::function_5826175e5df28fd8();
    autotests::function_5c8c87763724c132();
    autotests::set_dvar( @"cg_drawgun", 0 );
    wait 2;
    return true;
}

// Namespace test_mp_emotes
// Params 0, eflags: 0x4
// Checksum 0x9c888ac8, Offset: 0x48d
// Size: 0x10
function private cleanup()
{
    autotests_utility_video::function_2bddeed61c9c1561();
    autotests_utility_bot::kick_all_bots();
}

