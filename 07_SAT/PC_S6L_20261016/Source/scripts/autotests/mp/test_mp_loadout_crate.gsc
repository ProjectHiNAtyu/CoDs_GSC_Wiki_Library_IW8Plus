// scripts\autotests\mp\test_mp_loadout_crate.gsc  (hash_3da093960d7c3252.gscc) (size: 7693 Bytes / 0x1e0d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd7878f69 (3615985513)
// size ...... 7693 (0x1e0d)
// includes .. 10  (offset: 0x1b3d)
// strings ... 38  (offset: 0x1b8d)
// dev strs .. 0   (offset: 0x1e0d)
// exports ... 13  (offset: 0x11b1)
// cseg ...... 0x36c + 0xe45 (0x11b1)
// imports ... 56  (offset: 0x13b9)
// animtree1 . 0   (offset: 0x1e0d)
// animtree2 . 0   (offset: 0x1e0d)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_common_item;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\ui;
#using scripts\common\weapon;
#using scripts\mp\airdrop_loadout_crate;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\airdrop;

#namespace test_mp_loadout_crate;

// Namespace test_mp_loadout_crate/testautomation
// Params 0, eflags: 0x20
// Checksum 0x7042c640, Offset: 0x38a
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_loadout_crate.gsc", #"test", &start_test, &setup, &cleanup );
}

// Namespace test_mp_loadout_crate
// Params 0
// Checksum 0x29269348, Offset: 0x3b8
// Size: 0x14e, Type: bool
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::push_function( "Prematch completed?" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 31 );
    autotests::pop_function( "Prematch completed?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Loadout Crate opens?" );
    test_result_int = function_ea3a5caedc1237d0( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Loadout Crate opens?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 33 );
    autotests::pop_function( "Loadout Crate opens?" );
    autotests::test_assert_return( test_result_int );
    cleanup_after_test();
    autotests::push_function( "Crate Gives Loadout (bot's choice)?" );
    test_result_int = function_8b9d9417e8663030( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Crate Gives Loadout (bot's choice)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 36 );
    autotests::pop_function( "Crate Gives Loadout (bot's choice)?" );
    autotests::test_assert_return( test_result_int );
    cleanup_after_test();
    autotests::push_function( "Crate Gives Loadout (custom choice)?" );
    test_result_int = function_ea2c2e6089f18ee0( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Crate Gives Loadout (custom choice)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 39 );
    autotests::pop_function( "Crate Gives Loadout (custom choice)?" );
    autotests::test_assert_return( test_result_int );
    cleanup_after_test();
    return false;
}

// Namespace test_mp_loadout_crate
// Params 0, eflags: 0x4
// Checksum 0x144ca71c, Offset: 0x50f
// Size: 0x17b
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility::setup();
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player found?", player, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 53 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player setorigin( level.autotests.test_runtime.standbyposition );
    player function_ffb0711adb6d8d0d();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_loadout_crate.gsc", 58 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    level.autotests.test_runtime.bundle = bundle;
    autotests::set_dvar( @"hash_307fc239dc43be41", 1 );
    autotests::set_dvar( @"scr_validate_assert_weapons", 1 );
    autotests::set_dvar( @"hash_175e0eab9b488806", 1 );
    autotests::set_dvar( @"unlockallitems", 0 );
    level autotests_utility::function_4104f641c0755805( #"player_used_crate", "crate_used" );
    level autotests_utility::function_4104f641c0755805( #"loadout_given", "loadout_given" );
    return 1;
}

// Namespace test_mp_loadout_crate
// Params 0, eflags: 0x4
// Checksum 0x21d213f2, Offset: 0x693
// Size: 0x5c
function private cleanup()
{
    cleanup_after_test();
    autotests_utility_bot::kick_all_bots();
    autotests_utility::cleanup();
    player = autotests_utility_player::get_player();
    player playerexitautopilotmode();
    level autotests_utility::flag_remove_callback( #"player_used_crate", "crate_used" );
    level autotests_utility::flag_remove_callback( #"loadout_given", "loadout_given" );
}

// Namespace test_mp_loadout_crate
// Params 0, eflags: 0x4
// Checksum 0xfb2c2cd3, Offset: 0x6f7
// Size: 0x15a
function private cleanup_after_test()
{
    crate = level.autotests.test_runtime.crate;
    crate airdrop::deletecrate( 0 );
    autotests_utility_common_item::function_92d66ed1629b0979( level.autotests.test_runtime.testposition, 150 );
    autotests_utility::flag_clear( "crate_used" );
    autotests_utility::flag_clear( "loadout_given" );
    
    if ( level.autotests.test_runtime.botfunc )
    {
        level.bot_funcs[ "select_class_from_airdrop" ] = level.autotests.test_runtime.botfunc;
        level.autotests.test_runtime.botfunc = undefined;
    }
    
    player = autotests_utility_player::get_player();
    
    if ( level.autotests.test_runtime.classstruct )
    {
        player class::trytocacheclassstruct( level.autotests.test_runtime.classstruct, "custom2", "custom" );
        level.autotests.test_runtime.classstruct = undefined;
    }
}

// Namespace test_mp_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0x5f0c37e5, Offset: 0x859
// Size: 0x106
function private function_ea3a5caedc1237d0( player )
{
    level.autotests.test_runtime.botfunc = level.bot_funcs[ "select_class_from_airdrop" ];
    level.bot_funcs[ "select_class_from_airdrop" ] = undefined;
    crate = test_spawn_loadout( player );
    test_crate_used( player );
    waittime = 1;
    player ui::lui_notify_callback( "exit_loadout_bag" );
    var_63a718d91714219d = autotests::test_wait_any( "Crate use stopped?", player, [ "crate_use_end" ], waittime, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 129 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Crate is still usable?", crate.isusable, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 130 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0x696c9d26, Offset: 0x967
// Size: 0x10e
function private test_spawn_loadout( player )
{
    crate = airdrop_loadout_crate::spawnloadoutcrate( player, level.autotests.test_runtime.testposition + ( 20, 0, 250 ), 1, 1 );
    level.autotests.test_runtime.crate = crate;
    var_63a718d91714219d = autotests::test_wait_any( "Crate hit the floor?", crate, [ "crate_dropped" ], 3, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 137 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player setorigin( level.autotests.test_runtime.testposition );
    targetangles = vectortoangles( crate.destination - player.origin );
    player setplayerangles( targetangles );
    return crate;
}

// Namespace test_mp_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0xa5156112, Offset: 0xa7e
// Size: 0x6a
function private test_crate_used( player )
{
    player botpressbutton( "use", 1 );
    var_63a718d91714219d = autotests::test_wait_any( "Crate used?", level, [ "crate_used" ], 1, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 149 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0x5802c345, Offset: 0xaf0
// Size: 0xb3
function private function_8b9d9417e8663030( player )
{
    crate = test_spawn_loadout( player );
    test_crate_used( player );
    given = autotests_utility::flag_wait_or_timeout( #"loadout_given", 1 ) != "msg";
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Loadout given?", given, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 158 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    classstruct = player.classstruct;
    function_38a79d82392f55f8( player, classstruct );
    function_af4039e6c1cda68e( player, crate );
}

// Namespace test_mp_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0x555adb53, Offset: 0xbab
// Size: 0x249
function private function_ea2c2e6089f18ee0( player )
{
    level.autotests.test_runtime.botfunc = level.bot_funcs[ "select_class_from_airdrop" ];
    level.bot_funcs[ "select_class_from_airdrop" ] = undefined;
    crate = test_spawn_loadout( player );
    test_crate_used( player );
    bundle = level.autotests.test_runtime.bundle;
    classstruct = class::loadout_getclassstruct();
    classstruct = player class::loadout_updateclass( classstruct, "custom2" );
    level.autotests.test_runtime.classstruct = structcopy( classstruct );
    classstruct.loadoutprimary = bundle.var_d84cce15e01e8ba9;
    classstruct.loadoutprimaryobject = undefined;
    classstruct.loadoutsecondary = bundle.var_7359e49532eaff1;
    classstruct.loadoutsecondaryobject = undefined;
    classstruct.loadouttertiary = bundle.var_83b5abfeab7a9911;
    classstruct.var_9dcef9a8722c3abb = undefined;
    classstruct.loadoutperks = [ bundle.var_4dcd06b7b41bce0a, bundle.var_7a761672db595af9, bundle.var_5a29768616ba08d8 ];
    classstruct.loadoutequipmentprimary = bundle.var_d05be7233d64f859;
    classstruct.loadoutequipmentsecondary = bundle.var_cc2fe22fadba8d81;
    player class::loadout_updateclassfinalweapons( classstruct, 1 );
    player class::trytocacheclassstruct( classstruct, "custom2", "custom" );
    wait 1;
    player ui::lui_notify_callback( "class_select", 1 );
    given = autotests_utility::flag_wait_or_timeout( #"loadout_given", 1 ) != "msg";
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Loadout given?", given, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 203 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_38a79d82392f55f8( player, classstruct );
    function_af4039e6c1cda68e( player, crate );
}

// Namespace test_mp_loadout_crate
// Params 2, eflags: 0x4
// Checksum 0x474abe59, Offset: 0xdfc
// Size: 0x322
function private function_38a79d82392f55f8( player, classstruct )
{
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Loadout gives primary (" + classstruct.loadoutprimary + ")?", weapon::getweaponassetname( classstruct.loadoutprimary ), player.primaryweaponobj.basename, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 211 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Loadout gives secondary (" + classstruct.loadoutsecondary + ")?", weapon::getweaponassetname( classstruct.loadoutsecondary ), player.secondaryweaponobj.basename, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 212 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Loadout gives tertiary (" + classstruct.loadouttertiary + ")?", weapon::getweaponassetname( classstruct.loadouttertiary ), player.var_cc1262e66dbb1c79.basename, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 213 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Loadout gives lethal (" + classstruct.loadoutequipmentprimary + ")?", classstruct.loadoutequipmentprimary, player.equipment[ "primary" ], "scripts/autotests/mp/test_mp_loadout_crate.gsc", 214 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Loadout gives tactical (" + classstruct.loadoutequipmentsecondary + ")?", classstruct.loadoutequipmentsecondary, player.equipment[ "secondary" ], "scripts/autotests/mp/test_mp_loadout_crate.gsc", 215 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_a1775d2c749f41bc = 0;
    
    foreach ( idx, perk in classstruct.loadoutperks )
    {
        if ( perk != "none" && perk != "specialty_null" )
        {
            var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Loadout gives perk " + string( idx ) + " (" + perk + ")?", isdefined( player.perks[ perk ] ), "scripts/autotests/mp/test_mp_loadout_crate.gsc", 222 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            var_a1775d2c749f41bc = 1;
        }
    }
    
    if ( !var_a1775d2c749f41bc )
    {
        autotests::report_info( "No perks were given as none were specified" );
    }
}

// Namespace test_mp_loadout_crate
// Params 2
// Checksum 0xe957d07b, Offset: 0x1126
// Size: 0x8b
function function_af4039e6c1cda68e( player, crate )
{
    deletiondelay = airdrop::getleveldata( crate.cratetype ).capturevisualsdeletiondelay;
    var_63a718d91714219d = autotests::test_wait_any( "Crate cleaned up?", crate, [ "death" ], deletiondelay + 0.1, "scripts/autotests/mp/test_mp_loadout_crate.gsc", 236 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

