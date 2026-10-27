// scripts\autotests\mp\test_mp_supers_smoke.gsc  (hash_1320acae099efee2.gscc) (size: 5457 Bytes / 0x1551 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeac16d8 (246159064)
// size ...... 5457 (0x1551)
// includes .. 9   (offset: 0x1451)
// strings ... 12  (offset: 0x1499)
// dev strs .. 0   (offset: 0x1551)
// exports ... 17  (offset: 0xb9d)
// cseg ...... 0x1d2 + 0x9cb (0xb9d)
// imports ... 53  (offset: 0xe45)
// animtree1 . 0   (offset: 0x1551)
// animtree2 . 0   (offset: 0x1551)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\autotests_utility_scriptables;
#using scripts\autotests\mp\autotests_utility_content;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_super;
#using scripts\mp\supers;

#namespace test_mp_supers_smoke;

// Namespace test_mp_supers_smoke/testautomation
// Params 0, eflags: 0x20
// Checksum 0x931198ac, Offset: 0x1f0
// Size: 0x2b
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_supers_smoke.gsc", #"test", &start_test, &setup, &cleanup, &parameterize );
}

// Namespace test_mp_supers_smoke
// Params 1, eflags: 0x4
// Checksum 0xe6b2d6da, Offset: 0x223
// Size: 0x38
function private parameterize( datasets )
{
    itemrefs = [];
    autotests_utility::function_8354eb3723f722f4( level.superglobals.staticsuperdata, itemrefs, 0 );
    return itemrefs;
}

// Namespace test_mp_supers_smoke
// Params 0, eflags: 0x4
// Checksum 0xe617bcfe, Offset: 0x264
// Size: 0xfb
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility::setup();
    player = autotests_utility_player::get_player();
    player function_ffb0711adb6d8d0d();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_supers_smoke.gsc", 37 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_bot::set_bot_godmode( player, 1 );
    testposition = level.autotests.test_runtime.testposition;
    
    if ( isdefined( testposition ) )
    {
        player setorigin( testposition );
    }
    
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_supers_smoke.gsc", 46 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    return 1;
}

// Namespace test_mp_supers_smoke
// Params 0, eflags: 0x4
// Checksum 0x2d20195b, Offset: 0x368
// Size: 0x8a
function private cleanup()
{
    player = autotests_utility_player::get_player();
    autotests_utility_bot::set_bot_godmode( player, 0 );
    player playerexitautopilotmode();
    level.autotests.test_runtime.var_f1606a2c8912a00b = undefined;
    level.autotests.test_runtime.var_80ce77473dcfebd6 = undefined;
    level.autotests.test_runtime.var_f642f62c776d498f = undefined;
    cleanup_super();
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_supers_smoke
// Params 0, eflags: 0x4
// Checksum 0x39664135, Offset: 0x3fa
// Size: 0xec
function private start_test()
{
    autotests_utility_bot::kick_all_bots();
    player = autotests_utility_player::get_player();
    bot_data = autotests_utility_bot::get_spawn_data( player, 300 );
    bot = autotests_utility_bot::function_978126f411fc8a11( player, bot_data );
    level.autotests.test_runtime.bot = bot;
    itemref = self.parameters[ 0 ];
    equipresult = autotests_utility_content::equipcontent( bot, itemref );
    
    if ( !equipresult.result )
    {
        return 5;
    }
    
    autotests::push_function( "Test super " );
    test_result_int = test_super( bot ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test super ", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_supers_smoke.gsc", 79 );
    autotests::pop_function( "Test super " );
    autotests::test_assert_return( test_result_int );
}

// Namespace test_mp_supers_smoke
// Params 1, eflags: 0x4
// Checksum 0xa6e735ac, Offset: 0x4ee
// Size: 0x14f
function private test_super( bot )
{
    superinfo = bot supers_mp::getcurrentsuper();
    usetime = supers_mp::function_5edde74ac0c929eb( superinfo );
    
    if ( usetime > 0 )
    {
        level.autotests.test_runtime.var_f1606a2c8912a00b = superinfo.staticdata.usetime;
        superinfo.staticdata.usetime = 4;
    }
    
    var_984b1e514b61cb = bot supers_mp::isusingsuperweapon() ? 5 : 0.1;
    [ var_984b1e514b61cb, var_6fa08818546d70c2 ] = setup_specific_super( bot, superinfo, var_984b1e514b61cb );
    bot botpressbutton( "special", var_984b1e514b61cb );
    autotests::test_wait_any( "Super used?", bot, var_6fa08818546d70c2 ? [ "super_started" ] : [ "super_use_finished", "tactical_super_use_finished", "super_use_finished_lb" ], 7, "scripts/autotests/mp/test_mp_supers_smoke.gsc", 100 );
    
    while ( !bot isonground() )
    {
        waitframe();
    }
    
    wait 2;
    autotests_utility_scriptables::function_9902d3be8a6f6a01( bot );
    bot cleanup_super( superinfo.staticdata );
    wait 2;
}

// Namespace test_mp_supers_smoke
// Params 3, eflags: 0x4
// Checksum 0xe94e45b7, Offset: 0x645
// Size: 0xd3
function private setup_specific_super( bot, superinfo, var_984b1e514b61cb )
{
    superref = superinfo.staticdata.ref;
    
    switch ( superref )
    {
        case #"hash_63ddedf356a573e5":
            setup_super_bubble_shield( bot, superinfo );
            break;
        case #"hash_8ae4dbe034b7a269":
            setup_super_reinforcement_flare( bot, superinfo );
            break;
        case #"hash_9d04f751326fe182":
            setup_super_med_kit( bot, superinfo );
            break;
        case #"hash_d89e93530200ecc0":
            var_984b1e514b61cb = setup_super_trauma_kit( bot, superinfo );
            break;
        case #"hash_55f2a0f8897850b6":
            var_6fa08818546d70c2 = 1;
            break;
    }
    
    return [ var_984b1e514b61cb, var_6fa08818546d70c2 ];
}

// Namespace test_mp_supers_smoke
// Params 2, eflags: 0x4
// Checksum 0x881f9519, Offset: 0x721
// Size: 0xff
function private setup_super_bubble_shield( bot, superinfo )
{
    level.autotests.test_runtime.var_80ce77473dcfebd6 = superinfo.staticdata.bundle.var_4a64e6e075d1821b;
    level.autotests.test_runtime.var_f642f62c776d498f = superinfo.staticdata.bundle.var_1e81197115e9a40e;
    superinfo.staticdata.bundle.var_4a64e6e075d1821b = superinfo.staticdata.usetime - 2;
    superinfo.staticdata.bundle.var_1e81197115e9a40e = superinfo.staticdata.usetime - 2;
}

// Namespace test_mp_supers_smoke
// Params 2, eflags: 0x4
// Checksum 0xf0aba3f1, Offset: 0x828
// Size: 0x8c
function private setup_super_reinforcement_flare( bot, superinfo )
{
    host = autotests_utility_player::get_player();
    var_4c4812f225a76583 = autotests_utility_bot::get_spawn_data( bot, 45 );
    friendlybot = autotests_utility_bot::function_b04d08d80ae08dcb( bot, var_4c4812f225a76583 );
    friendlybot common_item::function_bbba261e6fdc7e52( #"gulag_token" );
    level.autotests.test_runtime.friendlybot = friendlybot;
    autotests_utility_player::function_988b6029b82767d5( host, friendlybot, 1 );
}

// Namespace test_mp_supers_smoke
// Params 2, eflags: 0x4
// Checksum 0xa95c5367, Offset: 0x8bc
// Size: 0x42
function private setup_super_med_kit( bot, superinfo )
{
    autotests_utility_bot::set_bot_godmode( bot, 0 );
    waitframe();
    bot dodamage( 200, bot.origin, bot, bot, "MOD_TRIGGER_HURT", undefined, "HITLOC_NONE" );
}

// Namespace test_mp_supers_smoke
// Params 2, eflags: 0x4
// Checksum 0xcfbb60a, Offset: 0x906
// Size: 0x44
function private setup_super_trauma_kit( bot, superinfo )
{
    autotests_utility_bot::set_bot_godmode( bot, 0 );
    waitframe();
    bot dodamage( 200, bot.origin, bot, bot, "MOD_TRIGGER_HURT", undefined, "HITLOC_NONE" );
    return 5;
}

// Namespace test_mp_supers_smoke
// Params 1, eflags: 0x4
// Checksum 0x12c23e39, Offset: 0x953
// Size: 0x89
function private cleanup_super( var_49dab4db2a5b9f23 )
{
    if ( var_49dab4db2a5b9f23.ref && var_49dab4db2a5b9f23.usetime )
    {
        level.superglobals.staticsuperdata[ var_49dab4db2a5b9f23.ref ].usetime = level.autotests.test_runtime.var_f1606a2c8912a00b;
    }
    
    function_403fc9a80ab0fc9d( var_49dab4db2a5b9f23 );
    
    if ( common_item::items_isenabled() )
    {
        item_super::remove_current_super();
    }
}

// Namespace test_mp_supers_smoke
// Params 1, eflags: 0x4
// Checksum 0x52e9a8f0, Offset: 0x9e4
// Size: 0x92
function private function_403fc9a80ab0fc9d( var_49dab4db2a5b9f23 )
{
    superref = var_49dab4db2a5b9f23.ref;
    
    if ( superref )
    {
        switch ( superref )
        {
            case #"hash_63ddedf356a573e5":
                cleanup_super_bubble_shield( var_49dab4db2a5b9f23 );
                break;
            case #"hash_8ae4dbe034b7a269":
                cleanup_super_reinforcement_flare( var_49dab4db2a5b9f23 );
                break;
            case #"hash_9d04f751326fe182":
                cleanup_super_med_kit( var_49dab4db2a5b9f23 );
                break;
            case #"hash_d89e93530200ecc0":
                cleanup_super_med_kit( var_49dab4db2a5b9f23 );
                break;
        }
    }
}

// Namespace test_mp_supers_smoke
// Params 1, eflags: 0x4
// Checksum 0x3891d7fb, Offset: 0xa7e
// Size: 0x72
function private cleanup_super_bubble_shield( var_49dab4db2a5b9f23 )
{
    var_49dab4db2a5b9f23.bundle.var_4a64e6e075d1821b = level.autotests.test_runtime.var_80ce77473dcfebd6;
    var_49dab4db2a5b9f23.bundle.var_1e81197115e9a40e = level.autotests.test_runtime.var_f642f62c776d498f;
}

// Namespace test_mp_supers_smoke
// Params 1, eflags: 0x4
// Checksum 0xf5fe4f8, Offset: 0xaf8
// Size: 0x5d
function private cleanup_super_reinforcement_flare( var_49dab4db2a5b9f23 )
{
    friendlybot = level.autotests.test_runtime.friendlybot;
    kick( friendlybot getentitynumber() );
    level.autotests.test_runtime.friendlybot = undefined;
}

// Namespace test_mp_supers_smoke
// Params 1, eflags: 0x4
// Checksum 0x2b238eca, Offset: 0xb5d
// Size: 0x40
function private cleanup_super_med_kit( var_49dab4db2a5b9f23 )
{
    bot = level.autotests.test_runtime.bot;
    autotests_utility_bot::set_bot_godmode( bot, 1 );
}

