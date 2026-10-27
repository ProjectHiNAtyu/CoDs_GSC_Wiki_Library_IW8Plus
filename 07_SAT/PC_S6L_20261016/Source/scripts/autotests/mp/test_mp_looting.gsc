// scripts\autotests\mp\test_mp_looting.gsc  (hash_24f559599c59ff6c.gscc) (size: 8075 Bytes / 0x1f8b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3e59c94 (2749734036)
// size ...... 8075 (0x1f8b)
// includes .. 8   (offset: 0x1db3)
// strings ... 28  (offset: 0x1df3)
// dev strs .. 0   (offset: 0x1f8b)
// exports ... 15  (offset: 0x12bb)
// cseg ...... 0x3ba + 0xf01 (0x12bb)
// imports ... 69  (offset: 0x1513)
// animtree1 . 0   (offset: 0x1f8b)
// animtree2 . 0   (offset: 0x1f8b)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_common_item;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\mp\loot\common_item;

#namespace test_mp_looting;

// Namespace test_mp_looting/testautomation
// Params 0, eflags: 0x20
// Checksum 0x4bd3241b, Offset: 0x3d8
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_looting.gsc", #"test", &start_test, &setup, &cleanup );
}

// Namespace test_mp_looting
// Params 0
// Checksum 0xb821af92, Offset: 0x406
// Size: 0x172
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_looting.gsc", 33 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    autotests_utility_common_item::clear_all_loot();
    wait 0.1;
    bundle = level.autotests.test_runtime.bundle;
    
    if ( bundle.var_6f84aadd16f5ce88 )
    {
        reusablecaches = get_reusable_caches( bundle.var_c9e301ab59cdd3e );
        var_63a718d91714219d = autotests::function_e5040106e5cc1c59( "Valid reusable caches found?", reusablecaches.size, 0, "scripts/autotests/mp/test_mp_looting.gsc", 45 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        function_66805bf6ee9cc1cc( reusablecaches );
        autotests_utility_common_item::clear_all_loot();
    }
    
    caches = get_caches( undefined, bundle.var_d153ccf32da07df7 );
    var_63a718d91714219d = autotests::function_e5040106e5cc1c59( "Valid caches found?", caches.size, 0, "scripts/autotests/mp/test_mp_looting.gsc", 54 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 0.1;
    test_caches( caches );
    return 0;
}

// Namespace test_mp_looting
// Params 0, eflags: 0x4
// Checksum 0x6cd5d2e4, Offset: 0x581
// Size: 0x12f
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility::setup();
    autotests_utility_common_item::clear_all_loot();
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player found?", player, "scripts/autotests/mp/test_mp_looting.gsc", 70 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player autotests_utility_common_item::clear_inventory();
    player common_item::function_bbba261e6fdc7e52( "gulag_token" );
    player function_ffb0711adb6d8d0d();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_looting.gsc", 76 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bundle = level.autotests.test_runtime.bundle;
    
    if ( bundle.var_3d5cd7c920f6e160 )
    {
        autotests::set_dvar( @"common_item_spawn_all", 1 );
    }
    
    player callback::add( #"player_item_pickup", &on_pickup );
    autotests::set_dvar( @"hash_fd0c403fee9dc217", 5 );
    return 1;
}

// Namespace test_mp_looting
// Params 0, eflags: 0x4
// Checksum 0x90f378f4, Offset: 0x6b9
// Size: 0x50
function private cleanup()
{
    autotests_utility_common_item::clear_all_loot();
    autotests_utility::cleanup();
    player = autotests_utility_player::get_player();
    player playerexitautopilotmode();
    player function_8b20e85d1fc96cfc();
    autotests_utility::flag_remove_all();
    player callback::remove( #"player_item_pickup", &on_pickup );
}

// Namespace test_mp_looting
// Params 2, eflags: 0x4
// Checksum 0x339ec3b6, Offset: 0x711
// Size: 0x19d
function private get_caches( cachename, var_d153ccf32da07df7 )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Cache name valid type? ", !isdefined( cachename ) || isstring( cachename ), "scripts/autotests/mp/test_mp_looting.gsc", 115 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player = autotests_utility_player::get_player();
    caches = getentitylessscriptablearray( cachename, undefined, player.origin, 1000000, "body" );
    
    if ( var_d153ccf32da07df7 && caches.size > var_d153ccf32da07df7 )
    {
        var_e7a586e546b18833 = caches.size - var_d153ccf32da07df7;
        
        for ( index = caches.size - 1; index >= var_d153ccf32da07df7 ; index-- )
        {
            caches[ caches.size - 1 ] = undefined;
        }
    }
    
    filteredcaches = [];
    
    foreach ( cache in caches )
    {
        if ( cache.onmovingtrain )
        {
            continue;
        }
        
        state = cache getscriptablepartstate( "body", 1 );
        
        if ( state == #"closed_usable" || state == #"closed_usable_no_collision" )
        {
            filteredcaches[ filteredcaches.size ] = cache;
        }
    }
    
    return filteredcaches;
}

// Namespace test_mp_looting
// Params 1, eflags: 0x4
// Checksum 0x9545d742, Offset: 0x8b7
// Size: 0x19
function private get_reusable_caches( var_d153ccf32da07df7 )
{
    return get_caches( "br_reusable_loot_cache", var_d153ccf32da07df7 );
}

// Namespace test_mp_looting
// Params 1, eflags: 0x4
// Checksum 0x8dbb400a, Offset: 0x8d9
// Size: 0x49
function private function_66805bf6ee9cc1cc( caches )
{
    test_caches( caches );
    autotests_utility_common_item::clear_all_loot();
    autotests::report_info( "Waiting for reusable caches to close" );
    wait 5;
    test_caches( caches );
    autotests::function_d84657f448aaeef6( "reusable caches work?", 1, "scripts/autotests/mp/test_mp_looting.gsc", 165 );
}

// Namespace test_mp_looting
// Params 1, eflags: 0x4
// Checksum 0x9e516002, Offset: 0x92a
// Size: 0x7e
function private test_caches( caches )
{
    foreach ( cache in caches )
    {
        test_cache( cache );
    }
}

// Namespace test_mp_looting
// Params 1, eflags: 0x4
// Checksum 0xee70b9a1, Offset: 0x9b0
// Size: 0x4a
function private test_cache( cache )
{
    player = autotests_utility_player::get_player();
    player function_4a16595b53d75b6a( cache );
    player autotests_utility_bot::function_503367f224b96494();
    wait 1;
    player test_loot_spawned( cache );
    player function_8b20e85d1fc96cfc();
}

// Namespace test_mp_looting
// Params 0, eflags: 0x4
// Checksum 0xb50824ce, Offset: 0xa02
// Size: 0x32
function private function_8b20e85d1fc96cfc()
{
    level.autotests.test_runtime.itemspickedup = undefined;
    autotests_utility_common_item::clear_inventory();
    common_item::function_bbba261e6fdc7e52( "gulag_token" );
}

// Namespace test_mp_looting
// Params 1, eflags: 0x4
// Checksum 0x7230f48b, Offset: 0xa3c
// Size: 0xe5
function private function_4a16595b53d75b6a( cache )
{
    forward = anglestoforward( cache.angles );
    position = cache.origin + forward * 40;
    self setorigin( autotests_utility::function_78cce6d4dbd203c0( position ) );
    autotests_utility_player::player_look_at( cache.origin );
    
    /#
        if ( getdvarint( @"hash_9326990549e007e4", 0 ) )
        {
            var_d0001bcf8f86189b = self geteye();
            sphere( var_d0001bcf8f86189b, 5, ( 0, 1, 1 ), undefined, 600 );
            debug::line( var_d0001bcf8f86189b, cache.origin, ( 1, 1, 1 ), 20 );
            sphere( cache.origin, 5, ( 1, 1, 1 ), undefined, 600 );
        }
    #/
}

// Namespace test_mp_looting
// Params 1, eflags: 0x4
// Checksum 0x2904f563, Offset: 0xb29
// Size: 0x560
function private test_loot_spawned( cache )
{
    lootarray = getlootscriptablearrayinradius( undefined, undefined, self.origin, 200 );
    var_ab3a1db2845e515f = 0;
    cachebundlename = common_item::function_33a2c00e46263d99( cache );
    
    if ( cachebundlename )
    {
        var_ab3a1db2845e515f = getscriptbundlefieldvalue( cachebundlename, #"hash_9dcd1e50a04d9a36" );
    }
    
    var_b1fc987a18f27ed = [ "dmz_hidden_container", "br_loot_cache", "br_loot_cache_lege", "br_reusable_loot_cache" ];
    
    for ( index = lootarray.size - 1; index >= 0 ; index-- )
    {
        loot = lootarray[ index ];
        
        if ( loot.targetname == "loot_container" || arraycontains( var_b1fc987a18f27ed, loot.type ) )
        {
            lootarray[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( lootarray );
            }
        }
    }
    
    if ( lootarray.size == 0 && var_ab3a1db2845e515f )
    {
        autotests::report_info( "No loot spawned as allowGroundLootAutoLoot was enabled for cache" );
        return;
    }
    
    var_8cc2edd5fd88b626 = level.autotests.test_runtime.itemspickedup;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Loot spawned from " + cache.type + " [" + cache.index + "]?", lootarray.size || cache.contents.size == var_8cc2edd5fd88b626.size, "scripts/autotests/mp/test_mp_looting.gsc", 249 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( getdvarint( @"hash_9326990549e007e4", 0 ) )
    {
        foreach ( content in cache.contents )
        {
            logstring( "test_mp_looting::test_loot_spawned - cache content " + common_item::function_105527001e21028d( content.lootid ) );
        }
        
        foreach ( loot in var_8cc2edd5fd88b626 )
        {
            logstring( "test_mp_looting::test_loot_spawned - lootAutoPickedUp " + common_item::function_105527001e21028d( loot ) );
        }
        
        foreach ( lootscriptable in lootarray )
        {
            logstring( "test_mp_looting::test_loot_spawned - scriptable found nearby " + lootscriptable.type );
        }
    }
    
    numloot = lootarray.size;
    
    for ( index = 0; index < numloot ; index++ )
    {
        foreach ( lootscriptable in lootarray )
        {
            if ( !lootscriptable )
            {
                continue;
            }
            
            test_loot_pickup( lootscriptable );
            break;
        }
    }
    
    var_216c9c8d0829ce2 = 1;
    itemspickedup = level.autotests.test_runtime.itemspickedup;
    
    foreach ( content in cache.contents )
    {
        if ( !itemspickedup[ content.lootid ] )
        {
            var_216c9c8d0829ce2 = 0;
            break;
        }
    }
    
    if ( getdvarint( @"hash_9326990549e007e4", 0 ) )
    {
        foreach ( itempickedup in itemspickedup )
        {
            logstring( "test_mp_looting::test_loot_spawned - item picked up " + common_item::function_105527001e21028d( itempickedup ) );
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Correct loot spawned and picked up from " + cache.type + " [" + cache.index + "]?", var_216c9c8d0829ce2, "scripts/autotests/mp/test_mp_looting.gsc", 305 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_looting
// Params 1, eflags: 0x4
// Checksum 0xf1be3061, Offset: 0x1091
// Size: 0x180
function private test_loot_pickup( item )
{
    autotests_utility::flag_clear( "picked_up" );
    itemtype = item.type;
    partname = item function_84ad2f70189ee7c3();
    useposition = item function_4951de6fef532028( partname ) ?? item.origin;
    position = useposition + ( 1, 0, 0 ) * 40;
    self setorigin( autotests_utility::function_78cce6d4dbd203c0( position ) );
    autotests_utility_player::player_look_at( useposition );
    
    /#
        if ( getdvarint( @"hash_9326990549e007e4", 0 ) )
        {
            var_d0001bcf8f86189b = self geteye();
            sphere( item.origin, 5, ( 1, 1, 1 ), undefined, 600 );
            sphere( var_d0001bcf8f86189b, 5, ( 0, 1, 1 ), undefined, 600 );
            sphere( useposition, 5, ( 0, 0, 1 ), undefined, 600 );
            debug::line( var_d0001bcf8f86189b, item.origin, ( 1, 1, 1 ), 20 );
        }
    #/
    
    haspickedup = autotests_utility_bot::try_pickup_item();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "test_mp_looting::test_loot_pickup Player interact " + itemtype, haspickedup, "scripts/autotests/mp/test_mp_looting.gsc", 332 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_looting
// Params 1, eflags: 0x4
// Checksum 0xdefcfeb8, Offset: 0x1219
// Size: 0xa2
function private on_pickup( params )
{
    itemspickedup = level.autotests.test_runtime.itemspickedup;
    lootid = common_item::function_779887309ec71dfe( params.itembundle );
    
    if ( getdvarint( @"hash_9326990549e007e4", 0 ) )
    {
        logstring( "test_mp_looting::on_pickup - " + common_item::function_105527001e21028d( lootid ) );
    }
    
    level.autotests.test_runtime.itemspickedup[ lootid ] = lootid;
    autotests_utility::flag_set( "picked_up" );
}

