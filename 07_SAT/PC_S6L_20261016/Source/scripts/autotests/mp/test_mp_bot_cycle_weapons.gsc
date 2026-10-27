// scripts\autotests\mp\test_mp_bot_cycle_weapons.gsc  (hash_1be11c71c4a61694.gscc) (size: 3243 Bytes / 0xcab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53f57e83 (1408597635)
// size ...... 3243 (0xcab)
// includes .. 7   (offset: 0xbd3)
// strings ... 12  (offset: 0xc0b)
// dev strs .. 0   (offset: 0xcab)
// exports ... 7   (offset: 0x667)
// cseg ...... 0x14b + 0x51c (0x667)
// imports ... 37  (offset: 0x77f)
// animtree1 . 0   (offset: 0xcab)
// animtree2 . 0   (offset: 0xcab)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_video;
#using scripts\autotests\mp\autotests_utility_weapons;
#using scripts\common\weapon;
#using scripts\mp\common\utility\weapon;

#namespace test_mp_bot_cycle_weapons;

// Namespace test_mp_bot_cycle_weapons/testautomation
// Params 0, eflags: 0x20
// Checksum 0x4f2fef0a, Offset: 0x169
// Size: 0x30
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_bot_cycle_weapons.gsc", #"test", &start_test, &setup, &cleanup, &parameterize, &asset_types );
}

// Namespace test_mp_bot_cycle_weapons
// Params 0, eflags: 0x4
// Checksum 0xc14dbe5, Offset: 0x1a1
// Size: 0xc
function private asset_types()
{
    return [ "weaponblueprint" ];
}

// Namespace test_mp_bot_cycle_weapons
// Params 1, eflags: 0x4
// Checksum 0x7300ca0c, Offset: 0x1b6
// Size: 0x6e
function private parameterize( test_setup )
{
    attachments_test_mode = test_setup.var_875fc462a0bca171.named[ "attachments" ];
    blueprints = autotests_utility_weapons::function_dc598beaf588c3d0( test_setup, &weapon::iscacprimaryorsecondary, 1 );
    
    if ( !attachments_test_mode )
    {
        return blueprints;
    }
    
    var_bbf037f010ab46e2 = autotests_utility_weapons::function_dc93bcf214d1e2ab( blueprints, attachments_test_mode );
    return var_bbf037f010ab46e2 ?? [];
}

// Namespace test_mp_bot_cycle_weapons
// Params 1, eflags: 0x4
// Checksum 0x4c7e4a7, Offset: 0x22d
// Size: 0x198
function private setup( datasets )
{
    autotests::function_5c8c87763724c132();
    player = autotests_utility_player::get_player();
    autotests::set_dvar( @"scr_devchangetimelimit", 0 );
    autotests::set_dvar( @"cg_drawgun", 0 );
    autotests::set_dvar( @"cg_draw2d", 0 );
    autotests::set_dvar( @"bot_disableallai", 1 );
    autotests_utility_video::function_5826175e5df28fd8();
    waitframe();
    testbundle = autotests::get_test_bundle( self.test.xhash_ref );
    autotests_utility_player::function_30be7535f53dd7a1( testbundle, player );
    botdata = autotests_utility_bot::get_spawn_data( player, 50 );
    spawned_bot = autotests_utility_bot::function_978126f411fc8a11( player, botdata );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Bot spawned successfully?", spawned_bot, "scripts/autotests/mp/test_mp_bot_cycle_weapons.gsc", 75 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_video::function_2083bbbdfedfe07e( testbundle );
    level.autotests.test_runtime.bot = spawned_bot;
    wait 1;
    var_9c3e5f01815e7a47 = ( player.angles[ 1 ] + 270 ) % 360;
    spawned_bot setplayerangles( ( 0, var_9c3e5f01815e7a47, 0 ) );
    wait 1;
    var_e586be9e102e7ced = anglestoforward( spawned_bot.angles );
    spawned_bot setorigin( spawned_bot.origin - var_e586be9e102e7ced * 15 );
    player function_ffb0711adb6d8d0d();
    return 1;
}

// Namespace test_mp_bot_cycle_weapons
// Params 0, eflags: 0x4
// Checksum 0x1694fabe, Offset: 0x3ce
// Size: 0x26e
function private start_test()
{
    var_23986f5ff3f49f24 = self.parameters[ 0 ];
    weaponinfo = autotests_utility_weapons::get_weapon_info( var_23986f5ff3f49f24 );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Is weapon info defined?", weaponinfo, "scripts/autotests/mp/test_mp_bot_cycle_weapons.gsc", 96 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    config_idx = 0;
    attachments = undefined;
    
    if ( self.parameters[ 1 ] )
    {
        config_idx = int( self.parameters[ 1 ] );
        configs = level.var_ac6454f7b690a35b[ weaponinfo.assetname ];
        attachments = configs[ config_idx ];
    }
    
    base_assetname = autotests_utility_weapons::get_assetname( weaponinfo );
    asset_name = attachments ? base_assetname + " config " + string( config_idx + 1 ) : base_assetname;
    autotests::set_current_asset_name( asset_name );
    
    if ( attachments )
    {
        autotests::report_info( "Testing " + attachments.size + " attachment(s):" );
        
        foreach ( att in attachments )
        {
            autotests::report_info( "  " + att );
        }
    }
    
    waitframe();
    created_weapon = weapon::buildweapon( weaponinfo.assetname, attachments, undefined, undefined, weaponinfo.variantid );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Was weapon created?", created_weapon, "scripts/autotests/mp/test_mp_bot_cycle_weapons.gsc", 121 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bot = level.autotests.test_runtime.bot;
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Is bot still valid?", bot, "scripts/autotests/mp/test_mp_bot_cycle_weapons.gsc", 124 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bot autotests_utility_weapons::swap_to_weapon( created_weapon, 1, undefined, 1 );
    autotests::set_current_asset_name( "" );
    return 0;
}

// Namespace test_mp_bot_cycle_weapons
// Params 0, eflags: 0x4
// Checksum 0xa7c06c1e, Offset: 0x645
// Size: 0x22
function private cleanup()
{
    player = autotests_utility_player::get_player();
    player playerexitautopilotmode();
    autotests_utility_bot::kick_all_bots();
}

