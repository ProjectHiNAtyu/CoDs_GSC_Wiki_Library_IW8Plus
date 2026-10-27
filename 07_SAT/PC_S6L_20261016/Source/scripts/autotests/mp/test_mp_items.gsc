// scripts\autotests\mp\test_mp_items.gsc  (hash_0bf7f10acba436fa.gscc) (size: 6767 Bytes / 0x1a6f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x669c6a87 (1721526919)
// size ...... 6767 (0x1a6f)
// includes .. 11  (offset: 0x1843)
// strings ... 29  (offset: 0x189b)
// dev strs .. 0   (offset: 0x1a6f)
// exports ... 12  (offset: 0xf17)
// cseg ...... 0x278 + 0xc9f (0xf17)
// imports ... 57  (offset: 0x10f7)
// animtree1 . 0   (offset: 0x1a6f)
// animtree2 . 0   (offset: 0x1a6f)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_common_item;
#using scripts\autotests\autotests_utility_player;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\perk;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace test_mp_items;

// Namespace test_mp_items/testautomation
// Params 0, eflags: 0x20
// Checksum 0x8a2b7ee4, Offset: 0x296
// Size: 0x2b
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_items.gsc", #"test", &start_test, &setup, &cleanup, &parameterize );
}

// Namespace test_mp_items
// Params 1, eflags: 0x4
// Checksum 0x39ba0b67, Offset: 0x2c9
// Size: 0x63
function private parameterize( datasets )
{
    bundle = autotests::get_test_bundle( self.xhash_ref );
    itemtypeinfo = autotests_utility_common_item::function_5ac354a32140c47d( bundle.var_4dacd80f693331dd, bundle.var_738aec820910dd90, bundle.var_62043d3d7251ad39 );
    return itemtypeinfo.bundlenames;
}

// Namespace test_mp_items
// Params 0, eflags: 0x4
// Checksum 0x77da28f9, Offset: 0x335
// Size: 0x256
function private start_test()
{
    bundlename = self.parameters[ 0 ];
    itembundle = common_item::function_90c3e0c1fd55d6b6( hashcat( %"itemspawnentry:", bundlename ) );
    
    if ( itembundle.ref )
    {
        refname = common_item_database::function_a4f0a21951180013( itembundle.ref );
        var_63a718d91714219d = autotests::function_36ed835262a19e53( "Item ( ref: " + bundlename + ") bundle name from ref found?", refname, "scripts/autotests/mp/test_mp_items.gsc", 39 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    if ( itembundle.scriptable )
    {
        scriptablename = common_item_database::function_ca9ca606e66b5911( itembundle.scriptable );
        var_63a718d91714219d = autotests::function_36ed835262a19e53( "Item ( ref: " + bundlename + ") bundle name from scriptable found?", scriptablename, "scripts/autotests/mp/test_mp_items.gsc", 45 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    friendlybot = level.autotests.test_runtime.friendlybot;
    friendlybot laststand::exit( "last_stand_self_revive" );
    autotests::push_function( "Spawn item?" );
    test_result_int = friendlybot test_spawn_item( bundlename, itembundle ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Spawn item?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_items.gsc", 54 );
    autotests::pop_function( "Spawn item?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Pickup and drop item?" );
    test_result_int = friendlybot function_5f654a14ce7db2f7( bundlename, itembundle ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Pickup and drop item?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_items.gsc", 55 );
    autotests::pop_function( "Pickup and drop item?" );
    autotests::test_assert_return( test_result_int );
    testname = "Item " + bundlename + " " + ( itembundle.canpickupinlaststand ? "can" : "can NOT" ) + " be picked up during last stand";
    autotests::push_function( testname );
    test_result_int = friendlybot function_a23d54e7b47d1b4e( itembundle ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( testname, test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_items.gsc", 59 );
    autotests::pop_function( testname );
    autotests::test_assert_return( test_result_int );
    return 0;
}

// Namespace test_mp_items
// Params 0, eflags: 0x4
// Checksum 0xa6a7dfa8, Offset: 0x594
// Size: 0xa6, Type: bool
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility::setup();
    player = autotests_utility_player::get_player();
    
    if ( player autotests_utility::test_prematch_done() != 0 )
    {
        return false;
    }
    
    bots_setup();
    wait 2;
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    level.autotests.test_runtime.bundle = bundle;
    autotests_utility_common_item::function_92d66ed1629b0979( level.autotests.test_runtime.testposition, 150 );
    return true;
}

// Namespace test_mp_items
// Params 0, eflags: 0x4
// Checksum 0xb296dfac, Offset: 0x643
// Size: 0x14d
function private bots_setup()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player found?", player, "scripts/autotests/mp/test_mp_items.gsc", 87 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_bot::kick_all_bots();
    testposition = level.autotests.test_runtime.testposition;
    offset = ( 50, 0, 0 );
    spawnposition = testposition - offset;
    spawnangles = vectortoangles( offset );
    botdata = autotests_utility_bot::create_spawn_data( spawnposition, spawnangles );
    friendlybot = autotests_utility_bot::function_e4afe0f2cd6331a6( player.team, botdata );
    friendlybot common_inventory::function_71114c5adfb01f7b( undefined, {} );
    level.autotests.test_runtime.friendlybot = friendlybot;
    standbyposition = level.autotests.test_runtime.standbyposition;
    player setorigin( standbyposition );
    player setplayerangles( vectortoangles( testposition - standbyposition ) );
}

// Namespace test_mp_items
// Params 0, eflags: 0x4
// Checksum 0x37313074, Offset: 0x798
// Size: 0x34
function private cleanup()
{
    autotests_utility_common_item::clear_all_loot();
    autotests_utility::cleanup();
    autotests_utility_bot::kick_all_bots();
    level.autotests.test_runtime.friendlybot = undefined;
}

// Namespace test_mp_items
// Params 2, eflags: 0x4
// Checksum 0xeafa53b8, Offset: 0x7d4
// Size: 0x132
function private test_spawn_item( bundlename, itembundle )
{
    autotests_utility_common_item::clear_all_loot();
    itemtype = common_item::function_16e8c106491eeaca( itembundle );
    isweapon = itemtype == "weapon";
    
    if ( isweapon )
    {
        common_inventory::function_bcb3b52008443a44();
    }
    else
    {
        common_item::function_bbba261e6fdc7e52( itemtype );
    }
    
    itemorigin = level.autotests.test_runtime.testposition;
    spawnoptions = common_item::function_bc5ff2958b71a708( itemorigin );
    scriptable = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Item ( ref: " + bundlename + ", type: " + itemtype + ") spawned", scriptable, "scripts/autotests/mp/test_mp_items.gsc", 137 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.getitemparams = { #weapon:scriptable.weaponobj };
    waitframe();
    autotests_utility_common_item::clear_all_loot();
}

// Namespace test_mp_items
// Params 2, eflags: 0x4
// Checksum 0x8e50ec97, Offset: 0x90e
// Size: 0x223
function private function_5f654a14ce7db2f7( bundlename, itembundle )
{
    autotests_utility_common_item::clear_all_loot();
    itemorigin = level.autotests.test_runtime.testposition;
    spawnoptions = common_item::function_bc5ff2958b71a708( itemorigin );
    common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
    getitemparams = level.autotests.test_runtime.getitemparams;
    var_39f1710228dd531 = common_item::function_16e8c106491eeaca( itembundle );
    isweapon = var_39f1710228dd531 == "weapon";
    oldcount = get_held_count( itembundle, getitemparams, var_39f1710228dd531 );
    haspickedup = autotests_utility_bot::try_pickup_item();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player interact", haspickedup, "scripts/autotests/mp/test_mp_items.gsc", 165 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( isweapon )
    {
        autotests::test_wait_any( "Equip weapon?", self, [ "weapon_change" ], 1, "scripts/autotests/mp/test_mp_items.gsc", 169 );
    }
    
    newcount = get_held_count( itembundle, getitemparams, var_39f1710228dd531 );
    spawncount = itembundle.spawncount;
    
    if ( !spawncount )
    {
        spawncount = 1;
    }
    
    var_8d3e53f7a29904af = newcount - oldcount == spawncount;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Item ( ref: " + bundlename + ", type: " + var_39f1710228dd531 + ") was picked up. Expected " + spawncount + " got " + newcount - oldcount + ")", var_8d3e53f7a29904af, "scripts/autotests/mp/test_mp_items.gsc", 180 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::push_function( "Drop item?" );
    test_result_int = test_drop_item( var_39f1710228dd531, itembundle ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Drop item?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_items.gsc", 182 );
    autotests::pop_function( "Drop item?" );
    autotests::test_assert_return( test_result_int );
}

// Namespace test_mp_items
// Params 2, eflags: 0x4
// Checksum 0x7ac637f2, Offset: 0xb39
// Size: 0x1c5
function private test_drop_item( itemtype, itembundle )
{
    getitemparams = level.autotests.test_runtime.getitemparams;
    itemtype = common_item::function_16e8c106491eeaca( itembundle );
    var_f0a4f0a9967a62ba = get_held_count( itembundle, getitemparams, itemtype );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
    itemsdropped = common_item::function_df311537e0426654( itemtype, itembundle, spawnoptions, undefined, itemtype == "currency" ? var_f0a4f0a9967a62ba : undefined );
    dropcount = 0;
    
    if ( !isdefined( itemsdropped ) )
    {
        return 5;
    }
    
    foreach ( droppeditem in itemsdropped )
    {
        var_63a718d91714219d = autotests::function_36ed835262a19e53( "Unable to drop ", droppeditem, "scripts/autotests/mp/test_mp_items.gsc", 207 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        dropcount += itemtype != "weapon" ? droppeditem.count : 1;
    }
    
    autotests_utility_common_item::clear_all_loot();
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Item dropped? Expected " + var_f0a4f0a9967a62ba + " dropped " + dropcount, dropcount, var_f0a4f0a9967a62ba, "scripts/autotests/mp/test_mp_items.gsc", 213 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_items
// Params 1, eflags: 0x4
// Checksum 0x594eb114, Offset: 0xd06
// Size: 0x1ac
function private function_a23d54e7b47d1b4e( itembundle )
{
    if ( !game_utility_mp::islaststandenabled() )
    {
        return 5;
    }
    
    getitemparams = level.autotests.test_runtime.getitemparams;
    itemtype = common_item::function_16e8c106491eeaca( itembundle );
    itemorigin = level.autotests.test_runtime.testposition;
    spawnoptions = common_item::function_bc5ff2958b71a708( itemorigin );
    common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
    
    if ( itemtype == "weapon" )
    {
        common_inventory::function_bcb3b52008443a44();
    }
    else
    {
        common_item::function_bbba261e6fdc7e52( itemtype );
    }
    
    perk::removeperk( "specialty_shroud" );
    autotests_utility_player::function_988b6029b82767d5( self, self, 0 );
    oldcount = get_held_count( itembundle, getitemparams, itemtype );
    waitframe();
    autotests_utility_bot::try_pickup_item();
    newcount = get_held_count( itembundle, getitemparams, itemtype );
    spawncount = itembundle.spawncount;
    
    if ( !spawncount )
    {
        spawncount = 1;
    }
    
    waspickedup = newcount - oldcount == spawncount;
    
    if ( itemtype == "weapon" )
    {
        common_inventory::function_bcb3b52008443a44();
    }
    else
    {
        common_item::function_bbba261e6fdc7e52( itemtype );
    }
    
    laststand::exit( "last_stand_self_revive" );
    autotests_utility_common_item::clear_all_loot();
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Picked up as expected?", waspickedup, itembundle.canpickupinlaststand ?? 0, "scripts/autotests/mp/test_mp_items.gsc", 261 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_items
// Params 3, eflags: 0x4
// Checksum 0x26327bf1, Offset: 0xeba
// Size: 0x5c
function private get_held_count( itembundle, getitemparams, itemtype )
{
    item = autotests_utility_common_item::get_item( itembundle, getitemparams );
    count = autotests_utility_common_item::function_322b5c81a9941a9( item );
    
    if ( itemtype == "weapon" && item )
    {
        count = 1;
    }
    
    return count;
}

