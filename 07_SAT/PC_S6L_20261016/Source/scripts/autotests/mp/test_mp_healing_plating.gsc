// scripts\autotests\mp\test_mp_healing_plating.gsc  (hash_3379f08aa431c194.gscc) (size: 4969 Bytes / 0x1369 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x923ee405 (2453595141)
// size ...... 4969 (0x1369)
// includes .. 7   (offset: 0x11e9)
// strings ... 19  (offset: 0x1221)
// dev strs .. 0   (offset: 0x1369)
// exports ... 10  (offset: 0xa71)
// cseg ...... 0x1c3 + 0x8ae (0xa71)
// imports ... 47  (offset: 0xc01)
// animtree1 . 0   (offset: 0x1369)
// animtree2 . 0   (offset: 0x1369)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_common_item;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;
#using scripts\mp\armor;

#namespace test_mp_healing_plating;

// Namespace test_mp_healing_plating/testautomation
// Params 0, eflags: 0x20
// Checksum 0x269823b5, Offset: 0x1e1
// Size: 0x31
function event_handler[testautomation] main()
{
    test = autotests::register_tests( "scripts/autotests/mp/test_mp_healing_plating.gsc", #"test", &start_test, &autotests::function_5c8c87763724c132, &cleanup );
}

// Namespace test_mp_healing_plating
// Params 0
// Checksum 0x496e1fe7, Offset: 0x21a
// Size: 0x1d4, Type: bool
function start_test()
{
    autotests_utility::setup();
    bots_setup();
    player = autotests_utility_player::get_player();
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_healing_plating.gsc", 25 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    wait 3;
    friendlybot = level.autotests.test_runtime.friendlybot;
    
    while ( friendlybot isparachuting() || friendlybot isskydiving() || friendlybot isswitchingweapon() )
    {
        waitframe();
    }
    
    autotests::push_function( "Take armor damage?" );
    test_result_int = test_damage_armor() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Take armor damage?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_healing_plating.gsc", 38 );
    autotests::pop_function( "Take armor damage?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Refill armor?" );
    test_result_int = test_refill_armor() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Refill armor?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_healing_plating.gsc", 39 );
    autotests::pop_function( "Refill armor?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Auto heal?" );
    test_result_int = function_1af65dd26105a853() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Auto heal?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_healing_plating.gsc", 47 );
    autotests::pop_function( "Auto heal?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Revive?" );
    test_result_int = test_revive() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Revive?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_healing_plating.gsc", 48 );
    autotests::pop_function( "Revive?" );
    autotests::test_assert_return( test_result_int );
    wait 3;
    return false;
}

// Namespace test_mp_healing_plating
// Params 0, eflags: 0x4
// Checksum 0x1a8f22ff, Offset: 0x3f7
// Size: 0x1e3
function private bots_setup()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player found?", player, "scripts/autotests/mp/test_mp_healing_plating.gsc", 58 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    testposition = level.autotests.test_runtime.testposition;
    botdata = autotests_utility_bot::create_spawn_data( testposition, ( 0, 90, 0 ) );
    friendlybot = autotests_utility_bot::function_e4afe0f2cd6331a6( player.team, botdata );
    autotests_utility_bot::set_bot_ignore_script_weapon( friendlybot, 0 );
    player autotests_utility::change_camera( friendlybot );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Friendly bot spawned?", friendlybot, "scripts/autotests/mp/test_mp_healing_plating.gsc", 67 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.friendlybot = friendlybot;
    standbyposition = level.autotests.test_runtime.standbyposition;
    angles = vectortoangles( testposition - standbyposition );
    var_f0010f2f186e5e5b = testposition - 20 * vectornormalize2( testposition - standbyposition );
    botdata = autotests_utility_bot::create_spawn_data( var_f0010f2f186e5e5b, angles );
    friendlybot = autotests_utility_bot::function_e4afe0f2cd6331a6( player.team, botdata );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Friendly bot spawned?", friendlybot, "scripts/autotests/mp/test_mp_healing_plating.gsc", 77 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.reviverbot = friendlybot;
}

// Namespace test_mp_healing_plating
// Params 0, eflags: 0x4
// Checksum 0x46c33fca, Offset: 0x5e2
// Size: 0xae
function private test_damage_armor()
{
    var_22446c3a131ef62 = 100;
    friendlybot = level.autotests.test_runtime.friendlybot;
    startingarmor = friendlybot armor::getarmorhealth();
    var_fc3e8295da03323c = min( var_22446c3a131ef62, startingarmor );
    friendlybot dealdamage( var_fc3e8295da03323c );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Armor reduced", friendlybot.armorhealth, startingarmor - var_fc3e8295da03323c, "scripts/autotests/mp/test_mp_healing_plating.gsc", 91 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_healing_plating
// Params 0, eflags: 0x4
// Checksum 0x77f71cf8, Offset: 0x698
// Size: 0xdc
function private test_refill_armor()
{
    friendlybot = level.autotests.test_runtime.friendlybot;
    var_12e152b69c12adcb = friendlybot armor::function_22290101992e4874();
    
    if ( var_12e152b69c12adcb == 0 )
    {
        friendlybot armor::function_164c824617d7e8d7( 1 );
    }
    
    currentarmor = friendlybot.armorhealth;
    armorplatevalue = armor::function_cb22658f54166b6b();
    friendlybot thread armor::tryusearmor( 1 );
    friendlybot utility::waittill_notify_or_timeout( "insertArmorComplete", 5 );
    wait 1;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Armor equal", friendlybot.armorhealth, currentarmor + armorplatevalue, "scripts/autotests/mp/test_mp_healing_plating.gsc", 112 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_healing_plating
// Params 0, eflags: 0x4
// Checksum 0x5f171bc3, Offset: 0x77c
// Size: 0x135
function private function_1af65dd26105a853()
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Health regen enabled", !level.healthregendisabled, "scripts/autotests/mp/test_mp_healing_plating.gsc", 117 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    remaininglife = 10;
    friendlybot = level.autotests.test_runtime.friendlybot;
    var_fc3e8295da03323c = friendlybot.armorhealth + friendlybot.health - remaininglife;
    friendlybot dealdamage( var_fc3e8295da03323c );
    timetowait = 5 + level.healthregendelayms * 0.001 + friendlybot.maxhealth / level.var_6a872024f536a219;
    friendlybot utility::waittill_notify_or_timeout( "healed", timetowait );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Health to max", friendlybot.health, friendlybot.maxhealth, "scripts/autotests/mp/test_mp_healing_plating.gsc", 128 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_healing_plating
// Params 0, eflags: 0x4
// Checksum 0x8afa0ceb, Offset: 0x8b9
// Size: 0x104
function private test_revive()
{
    friendlybot = level.autotests.test_runtime.friendlybot;
    reviverbot = level.autotests.test_runtime.reviverbot;
    var_fc3e8295da03323c = friendlybot.maxhealth + friendlybot.maxarmorhealth;
    friendlybot dealdamage( var_fc3e8295da03323c );
    wait 1;
    targetangles = vectortoangles( friendlybot.origin - reviverbot.origin );
    reviverbot setplayerangles( targetangles + ( 30, 0, 0 ) );
    reviverbot botpressbutton( "use", 10 );
    friendlybot utility::waittill_notify_or_timeout( "last_stand_finished", 15 );
    reviverbot botclearbutton( "use" );
    autotests::function_ae5837f8e14d9b71( "Not dead", friendlybot.inlaststand, "scripts/autotests/mp/test_mp_healing_plating.gsc", 150 );
}

// Namespace test_mp_healing_plating
// Params 1, eflags: 0x4
// Checksum 0x259cfe50, Offset: 0x9c5
// Size: 0x2a
function private dealdamage( damage )
{
    self dodamage( damage, self.origin, self, self, "MOD_TRIGGER_HURT", undefined, "HITLOC_NONE" );
}

// Namespace test_mp_healing_plating
// Params 0, eflags: 0x4
// Checksum 0x6c0b4355, Offset: 0x9f7
// Size: 0x7a
function private cleanup()
{
    autotests_utility_bot::kick_all_bots();
    autotests_utility::cleanup();
    player = autotests_utility_player::get_player();
    player autotests_utility::reset_camera();
    wait 1;
    autotests_utility_common_item::function_92d66ed1629b0979( level.autotests.test_runtime.testposition, 150 );
    autotests_utility_common_item::function_92d66ed1629b0979( level.autotests.test_runtime.standbyposition, 150 );
}

