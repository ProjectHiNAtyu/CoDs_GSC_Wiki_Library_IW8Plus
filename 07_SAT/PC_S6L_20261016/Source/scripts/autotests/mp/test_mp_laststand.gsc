// scripts\autotests\mp\test_mp_laststand.gsc  (hash_431521c905b7ecc2.gscc) (size: 12660 Bytes / 0x3174 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4e02ab40 (1308797760)
// size ...... 12660 (0x3174)
// includes .. 7   (offset: 0x2e9c)
// strings ... 26  (offset: 0x2ed4)
// dev strs .. 0   (offset: 0x3174)
// exports ... 28  (offset: 0x2024)
// cseg ...... 0x329 + 0x1cfb (0x2024)
// imports ... 63  (offset: 0x2484)
// animtree1 . 0   (offset: 0x3174)
// animtree2 . 0   (offset: 0x3174)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_common_item;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;
#using scripts\mp\laststand;

#namespace test_mp_laststand;

// Namespace test_mp_laststand/testautomation
// Params 0, eflags: 0x20
// Checksum 0xd5d97b33, Offset: 0x347
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_laststand.gsc", #"test", &start_test, &setup, &cleanup );
}

// Namespace test_mp_laststand
// Params 0
// Checksum 0x611f1ac4, Offset: 0x375
// Size: 0x340, Type: bool
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_laststand.gsc", 23 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Revive succeeds" );
    test_result_int = test_revive() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Revive succeeds", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_laststand.gsc", 25 );
    autotests::pop_function( "Revive succeeds" );
    autotests::test_assert_return( test_result_int );
    cleanup_revive();
    wait 0.5;
    autotests::push_function( "Early-Out revive then retry succeeds" );
    test_result_int = function_ecfca44597dab13c() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Early-Out revive then retry succeeds", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_laststand.gsc", 30 );
    autotests::pop_function( "Early-Out revive then retry succeeds" );
    autotests::test_assert_return( test_result_int );
    function_a2278f15588492e4();
    wait 0.5;
    autotests::push_function( "Player is finished from laststand" );
    test_result_int = function_ea3f57b67028530() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Player is finished from laststand", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_laststand.gsc", 35 );
    autotests::pop_function( "Player is finished from laststand" );
    autotests::test_assert_return( test_result_int );
    cleanup_laststand_finished();
    wait 0.5;
    autotests::push_function( "Revive stops when revivee is finished" );
    test_result_int = function_2296b3edae3f1490() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Revive stops when revivee is finished", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_laststand.gsc", 40 );
    autotests::pop_function( "Revive stops when revivee is finished" );
    autotests::test_assert_return( test_result_int );
    cleanup_revivee_finished();
    wait 0.5;
    autotests::push_function( "Revive stops when reviver is downed" );
    test_result_int = function_78d48d8fbd6f6234() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Revive stops when reviver is downed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_laststand.gsc", 45 );
    autotests::pop_function( "Revive stops when reviver is downed" );
    autotests::test_assert_return( test_result_int );
    cleanup_reviver_downed();
    wait 0.5;
    autotests::push_function( "Revivee is finished when reviver is killed as last alive player" );
    test_result_int = function_8c33364be438efca() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Revivee is finished when reviver is killed as last alive player", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_laststand.gsc", 50 );
    autotests::pop_function( "Revivee is finished when reviver is killed as last alive player" );
    autotests::test_assert_return( test_result_int );
    function_11b4e06675c76f92();
    wait 0.5;
    autotests::push_function( "Self-revive succeeds" );
    test_result_int = test_selfrevive() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Self-revive succeeds", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_laststand.gsc", 55 );
    autotests::pop_function( "Self-revive succeeds" );
    autotests::test_assert_return( test_result_int );
    cleanup_selfrevive();
    wait 0.5;
    autotests::push_function( "Self-revive stops then retry succeeds" );
    test_result_int = function_d6a094843db7f516() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Self-revive stops then retry succeeds", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_laststand.gsc", 60 );
    autotests::pop_function( "Self-revive stops then retry succeeds" );
    autotests::test_assert_return( test_result_int );
    function_48f0ed5147ea0e4e();
    wait 0.5;
    autotests::push_function( "Self-revive stops then player completes revive" );
    test_result_int = function_e3b04914e67314a1() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Self-revive stops then player completes revive", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_laststand.gsc", 65 );
    autotests::pop_function( "Self-revive stops then player completes revive" );
    autotests::test_assert_return( test_result_int );
    function_58d7e96368f88d29();
    return false;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0xd9d3a2f, Offset: 0x6be
// Size: 0xd0
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility::setup();
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player found?", player, "scripts/autotests/mp/test_mp_laststand.gsc", 80 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player function_ffb0711adb6d8d0d();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_laststand.gsc", 84 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player function_3a7598d6982eb648( 1 );
    player notify( #"bot_suspended" );
    bots_setup();
    autotests::set_dvar( @"hash_307fc239dc43be41", 1 );
    return 1;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x543c0ea7, Offset: 0x797
// Size: 0x20a
function private bots_setup()
{
    player = autotests_utility_player::get_player();
    botdata = autotests_utility_bot::create_spawn_data( level.autotests.test_runtime.standbyposition, ( 0, 0, 0 ) );
    enemybot = autotests_utility_bot::function_978126f411fc8a11( player, botdata );
    var_58d5e298fe16ee47 = autotests_utility_bot::function_978126f411fc8a11( player, botdata );
    friendlybot = autotests_utility_bot::function_e4afe0f2cd6331a6( player.team, botdata );
    var_7d026d94418c48fc = autotests_utility_bot::function_e4afe0f2cd6331a6( player.team, botdata );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Enemy bot spawned?", enemybot, "scripts/autotests/mp/test_mp_laststand.gsc", 111 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Enemy bot 2 spawned?", var_58d5e298fe16ee47, "scripts/autotests/mp/test_mp_laststand.gsc", 112 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Friendly bot spawned?", friendlybot, "scripts/autotests/mp/test_mp_laststand.gsc", 113 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Friendly bot 2 spawned?", var_7d026d94418c48fc, "scripts/autotests/mp/test_mp_laststand.gsc", 114 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.enemybot = enemybot;
    level.autotests.test_runtime.var_58d5e298fe16ee47 = var_58d5e298fe16ee47;
    level.autotests.test_runtime.friendlybot = friendlybot;
    level.autotests.test_runtime.var_7d026d94418c48fc = var_7d026d94418c48fc;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x89832a42, Offset: 0x9a9
// Size: 0x33
function private cleanup()
{
    autotests_utility_bot::kick_all_bots();
    autotests_utility::cleanup();
    player = autotests_utility_player::get_player();
    player laststand::function_39844c1e879cc048( 0 );
    player playerexitautopilotmode();
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0xb1db41a3, Offset: 0x9e4
// Size: 0x1c5
function private test_revive()
{
    killer = level.autotests.test_runtime.enemybot;
    revivee = level.autotests.test_runtime.friendlybot;
    reviver = autotests_utility_player::get_player();
    lookdir = anglestoforward( reviver.angles );
    teleportloc = level.autotests.test_runtime.testposition + lookdir * 55;
    revivee setorigin( teleportloc );
    revivee.health = revivee.maxhealth;
    reviver setorigin( level.autotests.test_runtime.testposition );
    reviver setplayerangles( ( 30, reviver.angles[ 1 ], reviver.angles[ 2 ] ) );
    autotests_utility_player::function_988b6029b82767d5( killer, revivee, 0 );
    wait 0.5;
    thread do_revive( reviver );
    msg = revivee utility::waittill_any_timeout( 2, "revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Revive started? ", msg, "revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 153 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_5523d506d0e52cf6 = function_d1924c942b5866c2();
    var_76e2bf7bf762eb71 = revivee utility::waittill_any_timeout( var_5523d506d0e52cf6, "last_stand_exit" );
    return var_76e2bf7bf762eb71 == "last_stand_exit" ? 0 : 1;
}

// Namespace test_mp_laststand
// Params 1, eflags: 0xc
// Checksum 0x36a12a48, Offset: 0xbb2
// Size: 0x51
function private do_revive( reviver )
{
    self notify( #"hash_7af28dfc109afdab" );
    self endon( #"hash_7af28dfc109afdab" );
    level endon( #"end_test" );
    level endon( #"end_revive" );
    
    while ( true )
    {
        reviver botpressbutton( "use" );
        waitframe();
    }
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x603b8378, Offset: 0xc0b
// Size: 0x11
function private function_d1924c942b5866c2()
{
    return level.laststandrevivetimer + 0.1;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0xfe4af317, Offset: 0xc25
// Size: 0x45
function private cleanup_revive()
{
    reviver = autotests_utility_player::get_player();
    reviver setplayerangles( ( 0, reviver.angles[ 1 ], reviver.angles[ 2 ] ) );
    level notify( #"end_revive" );
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x28c2f5db, Offset: 0xc72
// Size: 0x266
function private function_ecfca44597dab13c()
{
    killer = level.autotests.test_runtime.enemybot;
    revivee = level.autotests.test_runtime.friendlybot;
    reviver = autotests_utility_player::get_player();
    lookdir = anglestoforward( reviver.angles );
    teleportloc = level.autotests.test_runtime.testposition + lookdir * 55;
    revivee setorigin( teleportloc );
    revivee.health = revivee.maxhealth;
    reviver setorigin( level.autotests.test_runtime.testposition );
    reviver setplayerangles( ( 30, reviver.angles[ 1 ], reviver.angles[ 2 ] ) );
    autotests_utility_player::function_988b6029b82767d5( killer, revivee, 0 );
    wait 0.5;
    var_c8f57aaff7b13853 = function_d1924c942b5866c2();
    var_85ad5454b8b0e9ba = var_c8f57aaff7b13853 * 0.5;
    thread do_revive( reviver );
    msg = revivee utility::waittill_any_timeout( 2, "revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Revive started? ", msg, "revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 213 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait var_85ad5454b8b0e9ba;
    level notify( #"end_revive" );
    waittime = 1;
    wait waittime;
    thread do_revive( reviver );
    msg = revivee utility::waittill_any_timeout( 2, "revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Revive started again? ", msg, "revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 224 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_ed0404b0f274cb91 = var_c8f57aaff7b13853 - var_85ad5454b8b0e9ba + function_db9c81d910c25b69( waittime );
    var_76e2bf7bf762eb71 = revivee utility::waittill_any_timeout( var_ed0404b0f274cb91, "last_stand_exit" );
    return var_76e2bf7bf762eb71 == "last_stand_exit" ? 0 : 1;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x4a4d0a54, Offset: 0xee1
// Size: 0x45
function private function_a2278f15588492e4()
{
    reviver = autotests_utility_player::get_player();
    reviver setplayerangles( ( 0, reviver.angles[ 1 ], reviver.angles[ 2 ] ) );
    level notify( #"end_revive" );
}

// Namespace test_mp_laststand
// Params 1, eflags: 0x4
// Checksum 0x78d9c3ec, Offset: 0xf2e
// Size: 0x4a
function private function_db9c81d910c25b69( var_2b03be651bf8f93e )
{
    var_ba45230256e3a9df = var_2b03be651bf8f93e / level.framedurationseconds;
    var_c8fa0f9bb6319b23 = var_ba45230256e3a9df * level.frameduration * level.laststandrevivedecayscale;
    return var_c8fa0f9bb6319b23 / 1000;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x4d4a1870, Offset: 0xf81
// Size: 0x6e
function private function_ea3f57b67028530()
{
    killer = level.autotests.test_runtime.enemybot;
    friendlybot = level.autotests.test_runtime.friendlybot;
    autotests_utility_player::function_988b6029b82767d5( killer, friendlybot, 1 );
    waitframe();
    return isalive( friendlybot ) ? 1 : 0;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x23644df9, Offset: 0xff8
// Size: 0xbf
function private cleanup_laststand_finished()
{
    waitframe();
    friendlybot = level.autotests.test_runtime.friendlybot;
    botdata = autotests_utility_bot::create_spawn_data( level.autotests.test_runtime.standbyposition, ( 0, 0, 0 ) );
    var_df70365426564c90 = autotests_utility_bot::function_1b7c0308a9821886( friendlybot, botdata );
    level.autotests.test_runtime.friendlybot = var_df70365426564c90;
    autotests_utility_common_item::function_92d66ed1629b0979( level.autotests.test_runtime.testposition, 150 );
}

// Namespace test_mp_laststand
// Params 3, eflags: 0x4
// Checksum 0xeaaff4d2, Offset: 0x10bf
// Size: 0x2c
function private function_68b8acc59ce3c6d6( var_80e9f59a8a8527c3, killer, victim )
{
    wait var_80e9f59a8a8527c3;
    autotests_utility_player::function_988b6029b82767d5( killer, victim, 0 );
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x5f63bca1, Offset: 0x10f3
// Size: 0x1e8
function private function_2296b3edae3f1490()
{
    killer = level.autotests.test_runtime.enemybot;
    revivee = level.autotests.test_runtime.friendlybot;
    reviver = autotests_utility_player::get_player();
    lookdir = anglestoforward( reviver.angles );
    teleportloc = level.autotests.test_runtime.testposition + lookdir * 55;
    revivee setorigin( teleportloc );
    revivee.health = revivee.maxhealth;
    reviver setorigin( level.autotests.test_runtime.testposition );
    reviver setplayerangles( ( 30, reviver.angles[ 1 ], reviver.angles[ 2 ] ) );
    autotests_utility_player::function_988b6029b82767d5( killer, revivee, 0 );
    wait 0.5;
    thread do_revive( reviver );
    msg = revivee utility::waittill_any_timeout( 2, "revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Revive started? ", msg, "revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 313 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_5523d506d0e52cf6 = function_d1924c942b5866c2();
    var_80e9f59a8a8527c3 = var_5523d506d0e52cf6 * 0.5;
    thread function_68b8acc59ce3c6d6( var_80e9f59a8a8527c3, killer, revivee );
    var_76e2bf7bf762eb71 = revivee utility::waittill_any_timeout( var_5523d506d0e52cf6, "last_stand_exit", "death" );
    return var_76e2bf7bf762eb71 == "death" ? 0 : 1;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x4dfa4a7, Offset: 0x12e4
// Size: 0x100
function private cleanup_revivee_finished()
{
    level notify( #"end_revive" );
    reviver = autotests_utility_player::get_player();
    reviver setplayerangles( ( 0, reviver.angles[ 1 ], reviver.angles[ 2 ] ) );
    waitframe();
    friendlybot = level.autotests.test_runtime.friendlybot;
    botdata = autotests_utility_bot::create_spawn_data( level.autotests.test_runtime.standbyposition, ( 0, 0, 0 ) );
    var_df70365426564c90 = autotests_utility_bot::function_1b7c0308a9821886( friendlybot, botdata );
    level.autotests.test_runtime.friendlybot = var_df70365426564c90;
    autotests_utility_common_item::function_92d66ed1629b0979( level.autotests.test_runtime.testposition, 150 );
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x766e40f6, Offset: 0x13ec
// Size: 0x1d2
function private function_78d48d8fbd6f6234()
{
    killer = level.autotests.test_runtime.enemybot;
    revivee = level.autotests.test_runtime.friendlybot;
    reviver = autotests_utility_player::get_player();
    lookdir = anglestoforward( reviver.angles );
    teleportloc = level.autotests.test_runtime.testposition + lookdir * 55;
    revivee setorigin( teleportloc );
    revivee.health = revivee.maxhealth;
    reviver setorigin( level.autotests.test_runtime.testposition );
    reviver setplayerangles( ( 30, reviver.angles[ 1 ], reviver.angles[ 2 ] ) );
    autotests_utility_player::function_988b6029b82767d5( killer, revivee, 0 );
    wait 0.5;
    thread do_revive( reviver );
    msg = revivee utility::waittill_any_timeout( 2, "revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Revive started? ", msg, "revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 368 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_80e9f59a8a8527c3 = 1;
    thread function_68b8acc59ce3c6d6( var_80e9f59a8a8527c3, killer, reviver );
    var_76e2bf7bf762eb71 = revivee utility::waittill_any_timeout( function_d1924c942b5866c2(), "last_stand_exit" );
    return var_76e2bf7bf762eb71 == "timeout" ? 0 : 1;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x1ff880d7, Offset: 0x15c7
// Size: 0xdb
function private cleanup_reviver_downed()
{
    waitframe();
    level notify( #"end_revive" );
    friendlybot = level.autotests.test_runtime.friendlybot;
    botdata = autotests_utility_bot::create_spawn_data( level.autotests.test_runtime.standbyposition, ( 0, 0, 0 ) );
    var_df70365426564c90 = autotests_utility_bot::function_1b7c0308a9821886( friendlybot, botdata );
    level.autotests.test_runtime.friendlybot = var_df70365426564c90;
    setdvar( @"hash_a28e203d53e8292d", 1 );
    autotests_utility_common_item::function_92d66ed1629b0979( level.autotests.test_runtime.testposition, 150 );
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0xdd1baf49, Offset: 0x16aa
// Size: 0x27f
function private function_8c33364be438efca()
{
    player = autotests_utility_player::get_player();
    revivee = level.autotests.test_runtime.enemybot;
    reviver = level.autotests.test_runtime.var_58d5e298fe16ee47;
    killer = level.autotests.test_runtime.friendlybot;
    revivee laststand::function_39844c1e879cc048( 0 );
    reviver laststand::function_39844c1e879cc048( 0 );
    lookdir = anglestoforward( reviver.angles );
    teleportloc = level.autotests.test_runtime.testposition + lookdir * 55;
    revivee setorigin( teleportloc );
    revivee.health = revivee.maxhealth;
    reviver setplayerangles( ( 30, reviver.angles[ 1 ], reviver.angles[ 2 ] ) );
    reviver setorigin( level.autotests.test_runtime.testposition );
    player setorigin( level.autotests.test_runtime.standbyposition + ( 0, 300, 0 ) );
    var_a51dcab6fb950c57 = reviver.origin - player.origin;
    playerangles = vectortoangles( var_a51dcab6fb950c57 );
    player setplayerangles( playerangles );
    wait 0.5;
    autotests_utility_player::function_988b6029b82767d5( killer, revivee, 0 );
    thread do_revive( reviver );
    msg = revivee utility::waittill_any_timeout( 2, "revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Revive started? ", msg, "revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 432 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_80e9f59a8a8527c3 = 1;
    thread function_68b8acc59ce3c6d6( var_80e9f59a8a8527c3, killer, reviver );
    var_76e2bf7bf762eb71 = revivee utility::waittill_any_timeout( var_80e9f59a8a8527c3 + 1, "last_stand_exit", "death" );
    return var_76e2bf7bf762eb71 == "death" ? 0 : 1;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0xddb68ba2, Offset: 0x1932
// Size: 0x125
function private function_11b4e06675c76f92()
{
    waitframe();
    level notify( #"end_revive" );
    reviver = level.autotests.test_runtime.var_58d5e298fe16ee47;
    revivee = level.autotests.test_runtime.enemybot;
    botdata = autotests_utility_bot::create_spawn_data( level.autotests.test_runtime.standbyposition, ( 0, 0, 0 ) );
    var_a29cd0887a07f3cd = autotests_utility_bot::function_1b7c0308a9821886( revivee, botdata );
    var_a6d29b245f7d99cd = autotests_utility_bot::function_1b7c0308a9821886( reviver, botdata );
    level.autotests.test_runtime.enemybot = var_a29cd0887a07f3cd;
    level.autotests.test_runtime.var_58d5e298fe16ee47 = var_a6d29b245f7d99cd;
    autotests_utility_common_item::function_92d66ed1629b0979( level.autotests.test_runtime.testposition, 150 );
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0xab5e6749, Offset: 0x1a5f
// Size: 0x128
function private test_selfrevive()
{
    killer = level.autotests.test_runtime.enemybot;
    revivee = autotests_utility_player::get_player();
    revivee laststand::function_39844c1e879cc048( 1 );
    revivee setorigin( level.autotests.test_runtime.testposition );
    revivee.health = revivee.maxhealth;
    autotests_utility_player::function_988b6029b82767d5( killer, revivee, 0 );
    wait 0.5;
    thread do_revive( revivee );
    msg = revivee utility::waittill_any_timeout( 2, "self_revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Self revive started? ", msg, "self_revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 479 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_76e2bf7bf762eb71 = revivee utility::waittill_any_timeout( function_d1924c942b5866c2(), "last_stand_exit" );
    return var_76e2bf7bf762eb71 == "last_stand_exit" ? 0 : 1;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x8c3ccd83, Offset: 0x1b90
// Size: 0xe
function private cleanup_selfrevive()
{
    level notify( #"end_revive" );
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x104967c3, Offset: 0x1ba6
// Size: 0x1d5
function private function_d6a094843db7f516()
{
    killer = level.autotests.test_runtime.enemybot;
    revivee = autotests_utility_player::get_player();
    revivee setorigin( level.autotests.test_runtime.testposition );
    revivee laststand::function_39844c1e879cc048( 1 );
    revivee.health = revivee.maxhealth;
    autotests_utility_player::function_988b6029b82767d5( killer, revivee, 0 );
    wait 0.5;
    var_c8f57aaff7b13853 = function_d1924c942b5866c2();
    var_85ad5454b8b0e9ba = var_c8f57aaff7b13853 * 0.5;
    thread do_revive( revivee );
    msg = revivee utility::waittill_any_timeout( 2, "self_revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Self revive started? ", msg, "self_revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 512 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait var_85ad5454b8b0e9ba;
    level notify( #"end_revive" );
    waittime = 1;
    wait waittime;
    thread do_revive( revivee );
    msg = revivee utility::waittill_any_timeout( 2, "self_revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Self revive started? ", msg, "self_revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 523 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_ed0404b0f274cb91 = var_c8f57aaff7b13853 - var_85ad5454b8b0e9ba + function_db9c81d910c25b69( waittime );
    var_76e2bf7bf762eb71 = revivee utility::waittill_any_timeout( var_ed0404b0f274cb91, "last_stand_exit" );
    return var_76e2bf7bf762eb71 == "last_stand_exit" ? 0 : 1;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x80ceaca8, Offset: 0x1d84
// Size: 0xe
function private function_48f0ed5147ea0e4e()
{
    level notify( #"end_revive" );
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x91379bdb, Offset: 0x1d9a
// Size: 0x273
function private function_e3b04914e67314a1()
{
    killer = level.autotests.test_runtime.enemybot;
    revivee = autotests_utility_player::get_player();
    reviver = level.autotests.test_runtime.friendlybot;
    lookdir = anglestoforward( reviver.angles );
    teleportloc = level.autotests.test_runtime.testposition + lookdir * 55;
    revivee setorigin( teleportloc );
    revivee laststand::function_39844c1e879cc048( 1 );
    revivee.health = revivee.maxhealth;
    reviver setorigin( level.autotests.test_runtime.testposition );
    reviver setplayerangles( ( 30, reviver.angles[ 1 ], reviver.angles[ 2 ] ) );
    autotests_utility_player::function_988b6029b82767d5( killer, revivee, 0 );
    wait 0.5;
    var_c8f57aaff7b13853 = function_d1924c942b5866c2();
    var_85ad5454b8b0e9ba = var_c8f57aaff7b13853 * 0.5;
    thread do_revive( revivee );
    msg = revivee utility::waittill_any_timeout( 2, "self_revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Self revive started? ", msg, "self_revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 568 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait var_85ad5454b8b0e9ba;
    level notify( #"end_revive" );
    waittime = 1;
    wait waittime;
    thread do_revive( reviver );
    msg = revivee utility::waittill_any_timeout( 2, "revive_start" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Revive started? ", msg, "revive_start", "scripts/autotests/mp/test_mp_laststand.gsc", 579 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_ed0404b0f274cb91 = var_c8f57aaff7b13853 - var_85ad5454b8b0e9ba + function_db9c81d910c25b69( waittime );
    var_76e2bf7bf762eb71 = revivee utility::waittill_any_timeout( var_ed0404b0f274cb91, "last_stand_exit" );
    return var_76e2bf7bf762eb71 == "last_stand_exit" ? 0 : 1;
}

// Namespace test_mp_laststand
// Params 0, eflags: 0x4
// Checksum 0x2cc7478a, Offset: 0x2016
// Size: 0xe
function private function_58d7e96368f88d29()
{
    level notify( #"end_revive" );
}

