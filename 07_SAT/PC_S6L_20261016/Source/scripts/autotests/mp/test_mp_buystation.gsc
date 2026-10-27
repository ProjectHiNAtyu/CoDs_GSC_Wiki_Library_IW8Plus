// scripts\autotests\mp\test_mp_buystation.gsc  (hash_007dcaab7026970c.gscc) (size: 10084 Bytes / 0x2764 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7603b2d3 (1979953875)
// size ...... 10084 (0x2764)
// includes .. 14  (offset: 0x23bc)
// strings ... 52  (offset: 0x242c)
// dev strs .. 0   (offset: 0x2764)
// exports ... 17  (offset: 0x1780)
// cseg ...... 0x453 + 0x132d (0x1780)
// imports ... 71  (offset: 0x1a28)
// animtree1 . 0   (offset: 0x2764)
// animtree2 . 0   (offset: 0x2764)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_common_item;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_currency;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_kiosk;

#namespace test_mp_buystation;

// Namespace test_mp_buystation/testautomation
// Params 0, eflags: 0x20
// Checksum 0x20aa0889, Offset: 0x471
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_buystation.gsc", #"test", &start_test, &setup, &cleanup );
}

// Namespace test_mp_buystation
// Params 0
// Checksum 0x605010c5, Offset: 0x49f
// Size: 0x26f, Type: bool
function start_test()
{
    player = autotests_utility_player::get_player();
    kiosk = level.autotests.test_runtime.kiosk;
    teleport_player_kiosk( player, kiosk );
    function_365e3b7b730a05ae( player );
    interact_kiosk( player );
    bundle = level.autotests.test_runtime.bundle;
    
    if ( bundle.var_47216c05499a19f )
    {
        autotests::push_function( "Can player buy all items?" );
        test_result_int = function_5bde9d1a66659121( player ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Can player buy all items?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_buystation.gsc", 43 );
        autotests::pop_function( "Can player buy all items?" );
        autotests::test_assert_return( test_result_int );
    }
    
    if ( level.usegulag )
    {
        utility::callsharedfunc( #"gulag", #"hash_aac85e1d99ece289", "circle_index", 0 );
    }
    
    if ( bundle.testbuyback )
    {
        teammate = level.autotests.test_runtime.teammates[ 0 ];
        autotests::push_function( "Teammate killed?" );
        test_result_int = kill_player( teammate ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Teammate killed?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_buystation.gsc", 54 );
        autotests::pop_function( "Teammate killed?" );
        autotests::test_assert_return( test_result_int );
        autotests::push_function( "Teammate bought back?" );
        test_result_int = buyback_player( teammate, player ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Teammate bought back?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_buystation.gsc", 55 );
        autotests::pop_function( "Teammate bought back?" );
        autotests::test_assert_return( test_result_int );
        wait 3;
    }
    
    if ( bundle.var_8342386e0502a424 )
    {
        autotests::push_function( "Player's teammates killed?" );
        test_result_int = kill_players_team( player ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Player's teammates killed?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_buystation.gsc", 63 );
        autotests::pop_function( "Player's teammates killed?" );
        autotests::test_assert_return( test_result_int );
        autotests::push_function( "Player's teammates bought back?" );
        test_result_int = function_aa182487b7b8454c( player ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Player's teammates bought back?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_buystation.gsc", 64 );
        autotests::pop_function( "Player's teammates bought back?" );
        autotests::test_assert_return( test_result_int );
    }
    
    return false;
}

// Namespace test_mp_buystation
// Params 0, eflags: 0x4
// Checksum 0x12ed58e5, Offset: 0x717
// Size: 0x1d4
function private setup()
{
    autotests_utility::setup();
    bots_setup();
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player found?", player, "scripts/autotests/mp/test_mp_buystation.gsc", 77 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_buystation.gsc", 78 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    kiosk = find_kiosk();
    kiosk common_kiosk::restockbuystation( kiosk.overrideindex, kiosk.index );
    level.autotests.test_runtime.kiosk = kiosk;
    player function_ffb0711adb6d8d0d();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_buystation.gsc", 85 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( player.origin, player.angles );
    spawnoptions.isdeathevent = 1;
    player common_inventory::function_71114c5adfb01f7b( spawnoptions );
    player common_item::function_bbba261e6fdc7e52( "gulag_token" );
    level callback::add( #"br_player_respawn", &on_player_respawn );
    level autotests_utility::function_4104f641c0755805( #"br_player_respawn", "player_respawn" );
    level autotests_utility::function_4104f641c0755805( #"hash_906ce08d1b0ca8ce", "team_revive_purchased" );
    common_item::cleanup_all_items();
    return 1;
}

// Namespace test_mp_buystation
// Params 0, eflags: 0x4
// Checksum 0x77edb21c, Offset: 0x8f4
// Size: 0xc2
function private bots_setup()
{
    player = autotests_utility_player::get_player();
    
    for ( index = 0; index < 2 ; index++ )
    {
        botdata = autotests_utility_bot::get_spawn_data( player, 90 * ( index + 1 ) );
        bot = autotests_utility_bot::function_b04d08d80ae08dcb( player, botdata );
        var_63a718d91714219d = autotests::function_36ed835262a19e53( "Bot" + index + "spawned?", bot, "scripts/autotests/mp/test_mp_buystation.gsc", 112 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        level.autotests.test_runtime.teammates[ index ] = bot;
    }
}

// Namespace test_mp_buystation
// Params 0, eflags: 0x4
// Checksum 0x466e14fe, Offset: 0x9be
// Size: 0x7d
function private cleanup()
{
    player = autotests_utility_player::get_player();
    player playerexitautopilotmode();
    player common_kiosk::_closepurchasemenuwithresponse( 2 );
    common_item::cleanup_all_items();
    autotests_utility::cleanup();
    autotests_utility_bot::kick_all_bots();
    level callback::remove( #"br_player_respawn", &on_player_respawn );
    level autotests_utility::flag_remove_callback( #"br_player_respawn", "player_respawn" );
    level autotests_utility::flag_remove_callback( #"hash_906ce08d1b0ca8ce", "team_revive_purchased" );
}

// Namespace test_mp_buystation
// Params 0, eflags: 0x4
// Checksum 0x76109cdd, Offset: 0xa43
// Size: 0xd9
function private find_kiosk()
{
    foreach ( kiosk in level.common_armory_kiosk.instances )
    {
        if ( !kiosk.onmovingtrain )
        {
            validkiosk = kiosk;
            break;
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Kiosk found?", validkiosk, "scripts/autotests/mp/test_mp_buystation.gsc", 143 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    return validkiosk;
}

// Namespace test_mp_buystation
// Params 2, eflags: 0x4
// Checksum 0x585c62d, Offset: 0xb25
// Size: 0x73
function private teleport_player_kiosk( player, kiosk )
{
    kioskposition = anglestoforward( kiosk.angles ) * 50 + kiosk.origin;
    player setorigin( kioskposition );
    waitframe();
    partname = kiosk function_84ad2f70189ee7c3();
    useposition = kiosk function_4951de6fef532028( partname );
    player autotests_utility_player::player_look_at( useposition );
}

// Namespace test_mp_buystation
// Params 1, eflags: 0x4
// Checksum 0x33b4c30a, Offset: 0xba0
// Size: 0x7a
function private interact_kiosk( player )
{
    player botpressbutton( "use", 1 );
    wait 1;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player successfully interacted with kiosk?", player.common_kiosk && player.armorykioskpurchaseallowed, "scripts/autotests/mp/test_mp_buystation.gsc", 164 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_buystation
// Params 1, eflags: 0x4
// Checksum 0x9f7c398a, Offset: 0xc22
// Size: 0x5d
function private kill_player( player )
{
    autotests_utility_player::function_988b6029b82767d5( player, player, 1 );
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player dead?", player::isreallyalive( player ), "scripts/autotests/mp/test_mp_buystation.gsc", 171 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_buystation
// Params 1, eflags: 0x4
// Checksum 0xdda85b5b, Offset: 0xc87
// Size: 0x132
function private kill_players_team( player )
{
    teamplayers = teams::getteamdata( player.team, "players" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Player has correct number of teammates?", teamplayers.size - 1, 2, "scripts/autotests/mp/test_mp_buystation.gsc", 177 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    foreach ( index, teamplayer in teamplayers )
    {
        if ( teamplayer == player )
        {
            continue;
        }
        
        autotests_utility_player::function_988b6029b82767d5( teamplayer, teamplayer, 1 );
        var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Teammate " + index + " dead?", player::isreallyalive( teamplayer ), "scripts/autotests/mp/test_mp_buystation.gsc", 187 );
        
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

// Namespace test_mp_buystation
// Params 1, eflags: 0x4
// Checksum 0xad5acf28, Offset: 0xdc1
// Size: 0x93
function private function_365e3b7b730a05ae( player )
{
    previousmoney = player item_currency::get_currency().count;
    amount = 40000;
    autotests_utility_common_item::give_money( player, amount );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Player received money?", player item_currency::get_currency().count - previousmoney, amount, "scripts/autotests/mp/test_mp_buystation.gsc", 198 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_buystation
// Params 2, eflags: 0x4
// Checksum 0xde1542b1, Offset: 0xe5c
// Size: 0x1a0
function private buyback_player( revivee, buyer )
{
    teamplayers = teams::getteamdata( buyer.team, "players" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Player has correct number of teammates?", teamplayers.size - 1, 2, "scripts/autotests/mp/test_mp_buystation.gsc", 204 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    foreach ( index, player in teamplayers )
    {
        if ( player == revivee )
        {
            reviveeindex = index + 1;
            break;
        }
    }
    
    autotests_utility::flag_clear( "player_respawn" );
    buyer common_kiosk::onarmorykioskpurchase( "br_team_revive", reviveeindex );
    autotests::report_info( "Buyback initiated" );
    var_d6b63e33f7bced93 = autotests_utility::flag_wait_or_timeout( "player_respawn", 4 ) != "timeout";
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player bought back?", player::isreallyalive( revivee ) && var_d6b63e33f7bced93, "scripts/autotests/mp/test_mp_buystation.gsc", 221 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.respawncount = undefined;
}

// Namespace test_mp_buystation
// Params 1, eflags: 0x4
// Checksum 0xedca6c92, Offset: 0x1004
// Size: 0x221
function private function_aa182487b7b8454c( player )
{
    player common_kiosk::onarmorykioskpurchase( "br_team_revive_all", undefined );
    autotests::report_info( "Buyback initiated" );
    var_63a718d91714219d = autotests::test_wait_any( "Team revive purchase went through?", level, [ "team_revive_purchased" ], 1, "scripts/autotests/mp/test_mp_buystation.gsc", 230 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    teamplayers = teams::getteamdata( player.team, "players" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Player has correct number of teammates?", teamplayers.size - 1, 2, "scripts/autotests/mp/test_mp_buystation.gsc", 233 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 4 + level.var_797b14a7ea4df55.var_92537005e91d2306 * 1;
    respawncount = level.autotests.test_runtime.respawncount;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "All teammates were bought back?", respawncount, 2, "scripts/autotests/mp/test_mp_buystation.gsc", 237 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    foreach ( index, teamplayer in teamplayers )
    {
        if ( teamplayer == autotests_utility_player::get_player() )
        {
            continue;
        }
        
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player " + index + " alive?", player::isreallyalive( player ), "scripts/autotests/mp/test_mp_buystation.gsc", 246 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    level.autotests.test_runtime.respawncount = undefined;
}

// Namespace test_mp_buystation
// Params 1, eflags: 0x4
// Checksum 0x294adb0c, Offset: 0x122d
// Size: 0x1f3
function private function_5bde9d1a66659121( player )
{
    var_7aec506ac6322f52 = player.common_kiosk.overrideindex;
    buystationsinuse = common_kiosk::function_c3950de54d46edf();
    
    foreach ( kiosk in buystationsinuse )
    {
        if ( kiosk[ "index" ] == var_7aec506ac6322f52 )
        {
            items = kiosk[ "items" ];
            break;
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Buy station has items?", items.size, "scripts/autotests/mp/test_mp_buystation.gsc", 266 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    foreach ( itemref, item in items )
    {
        autotests::push_function( "Can buy " + itemref + " item?" );
        test_result_int = function_ce797b2ff190267( player, itemref, item[ "cost" ], player.common_kiosk.index ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Can buy " + itemref + " item?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_buystation.gsc", 270 );
        autotests::pop_function( "Can buy " + itemref + " item?" );
        autotests::test_assert_return( test_result_int );
    }
}

// Namespace test_mp_buystation
// Params 4, eflags: 0x4
// Checksum 0xc0d0ea42, Offset: 0x1428
// Size: 0x2e8
function private function_ce797b2ff190267( player, entryref, itemcost, kioskindex )
{
    itemindex = common_kiosk::function_831cebfde57b193f( entryref );
    itemdata = common_kiosk::function_74433c19fcc10b90( itemindex );
    bundlename = common_item_database::function_a4f0a21951180013( itemdata.ref );
    
    if ( !bundlename )
    {
        return 5;
    }
    
    itembundle = getscriptbundle( bundlename );
    oldcount = player autotests_utility_common_item::get_item( itembundle ).count ?? 0;
    oldmoney = player item_currency::get_currency().count;
    oldstock = level.buystationstock[ player.common_kiosk.index ].stock[ entryref ];
    
    if ( isdefined( oldstock ) && !oldstock )
    {
        return 5;
    }
    
    player common_kiosk::onarmorykioskpurchase( "br_item_purchase", itemindex );
    item = player autotests_utility_common_item::get_item( itembundle );
    newcount = item.count ?? 0;
    newmoney = player item_currency::get_currency().count;
    newstock = level.buystationstock[ player.common_kiosk.index ].stock[ entryref ];
    spawncount = itembundle.spawncount;
    
    if ( !spawncount )
    {
        spawncount = 1;
    }
    
    var_4e18a87bf8a4b5de = oldmoney - newmoney == itemcost;
    var_8d3e53f7a29904af = newcount - oldcount == spawncount;
    var_404a64d8f8388cb0 = isdefined( oldstock ) && isdefined( newstock ) ? oldstock - newstock == 1 : 1;
    autotests::report_info( "Money check: passed " + var_4e18a87bf8a4b5de + ", oldMoney " + oldmoney + ", newMoney " + newmoney );
    autotests::report_info( "Count check: passed " + var_8d3e53f7a29904af + ", oldCount " + oldcount + ", newCount " + newcount );
    autotests::report_info( "Stock check: passed " + var_404a64d8f8388cb0 + ", oldStock " + oldstock + ", newStock " + newstock );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Item " + entryref + " bought?", var_4e18a87bf8a4b5de && var_8d3e53f7a29904af && var_404a64d8f8388cb0, "scripts/autotests/mp/test_mp_buystation.gsc", 319 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( player.origin, player.angles );
    player common_item::function_df311537e0426654( item.type, itembundle, spawnoptions );
}

// Namespace test_mp_buystation
// Params 1, eflags: 0x4
// Checksum 0xc783a5ff, Offset: 0x1718
// Size: 0x68
function private on_player_respawn( params )
{
    count = level.autotests.test_runtime.respawncount ?? 0;
    level.autotests.test_runtime.respawncount = count + 1;
    autotests::report_info( "Player respawned" );
}

