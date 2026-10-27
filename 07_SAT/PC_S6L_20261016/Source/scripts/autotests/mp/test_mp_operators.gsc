// scripts\autotests\mp\test_mp_operators.gsc  (hash_4a6b3668dd676f1f.gscc) (size: 2150 Bytes / 0x866 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbc4692e4 (3158741732)
// size ...... 2150 (0x866)
// includes .. 5   (offset: 0x812)
// strings ... 3   (offset: 0x83a)
// dev strs .. 0   (offset: 0x866)
// exports ... 6   (offset: 0x3ce)
// cseg ...... 0xcb + 0x303 (0x3ce)
// imports ... 29  (offset: 0x4be)
// animtree1 . 0   (offset: 0x866)
// animtree2 . 0   (offset: 0x866)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_assets;
#using scripts\autotests\mp\autotests_utility_video;

#namespace test_mp_operators;

// Namespace test_mp_operators/testautomation
// Params 0, eflags: 0x20
// Checksum 0x72aded99, Offset: 0xe9
// Size: 0x2d
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_operators.gsc", #"GP", &start_test, &setup, &cleanup, &parameterize, undefined, 0 );
}

// Namespace test_mp_operators
// Params 0, eflags: 0x4
// Checksum 0xf17b00bb, Offset: 0x11e
// Size: 0x112, Type: bool
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility_video::function_5826175e5df28fd8();
    autotests::set_dvar( @"cg_drawgun", 0 );
    autotests::set_dvar( @"cg_draw2d", 0 );
    autotests::set_dvar( @"hash_edd37bf430a00f26", 1 );
    player = autotests_utility_player::get_player();
    testbundle = autotests::get_test_bundle( self.test.xhash_ref );
    
    if ( autotests_utility_player::function_30be7535f53dd7a1( testbundle, player ) )
    {
        autotests_utility_player::teleport_forward( player, -100 );
    }
    
    botdata = autotests_utility_bot::get_spawn_data( player, 100 );
    spawned_bot = autotests_utility_bot::function_978126f411fc8a11( player, botdata );
    spawned_bot function_3a7598d6982eb648( 1 );
    level.autotests.test_runtime.bot = spawned_bot;
    spawned_bot setplayerangles( vectortoangles( player.origin - botdata.origin + ( 0, 0, 0 ) ) );
    return true;
}

// Namespace test_mp_operators
// Params 1, eflags: 0x4
// Checksum 0xfe25fdc3, Offset: 0x239
// Size: 0x20
function private parameterize( datasets )
{
    selected_skins = autotests_utility_assets::function_afcf75b6412f73b9();
    return selected_skins;
}

// Namespace test_mp_operators
// Params 0, eflags: 0x4
// Checksum 0x932d399c, Offset: 0x262
// Size: 0x9
function private cleanup()
{
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_operators
// Params 0
// Checksum 0xa69ddfa2, Offset: 0x273
// Size: 0x15b
function start_test()
{
    player = autotests_utility_player::get_player();
    spawn_data = autotests_utility_bot::get_spawn_data( player, -100 );
    front_data = autotests_utility_bot::get_spawn_data( player, 100 );
    bot = level.autotests.test_runtime.bot;
    starttime = gettime();
    
    while ( !isalive( bot ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 5000 )
        {
            autotests::function_d84657f448aaeef6( "Bot was not alive withing 5 seconds of test starting.", 0, "scripts/autotests/mp/test_mp_operators.gsc", 65 );
            return;
        }
    }
    
    bot setorigin( spawn_data.origin );
    skinname = self.parameters[ 0 ];
    autotests::set_current_asset_name( skinname );
    operatorskin = getxhashasset( skinname );
    autotests_utility_video::function_bdc5139799504032( bot, operatorskin );
    wait 2;
    player setplayerangles( vectortoangles( front_data.origin - player.origin + ( 0, 0, -15 ) ) );
    bot setorigin( front_data.origin );
    wait 1;
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "operator" );
    wait 1;
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "operator" );
}

