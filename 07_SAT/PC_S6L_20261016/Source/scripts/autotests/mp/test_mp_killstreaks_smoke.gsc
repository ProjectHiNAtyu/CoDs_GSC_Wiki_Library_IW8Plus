// scripts\autotests\mp\test_mp_killstreaks_smoke.gsc  (hash_53290f26e02d114f.gscc) (size: 5736 Bytes / 0x1668 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b0f0523 (453969187)
// size ...... 5736 (0x1668)
// includes .. 11  (offset: 0x14c4)
// strings ... 21  (offset: 0x151c)
// dev strs .. 0   (offset: 0x1668)
// exports ... 12  (offset: 0xc04)
// cseg ...... 0x274 + 0x990 (0xc04)
// imports ... 57  (offset: 0xde4)
// animtree1 . 0   (offset: 0x1668)
// animtree2 . 0   (offset: 0x1668)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\autotests_utility_scriptables;
#using scripts\autotests\mp\autotests_utility_content;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\loot\common_item;

#namespace test_mp_killstreaks_smoke;

// Namespace test_mp_killstreaks_smoke/testautomation
// Params 0, eflags: 0x20
// Checksum 0xb9ec1deb, Offset: 0x292
// Size: 0x2b
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", #"test", &start_test, &setup, &cleanup, &parameterize );
}

// Namespace test_mp_killstreaks_smoke
// Params 1, eflags: 0x4
// Checksum 0xb39b9bdb, Offset: 0x2c5
// Size: 0x5b
function private parameterize( datasets )
{
    killstreakrefs = [];
    datasource = level.killstreakbundles ?? level.streakglobals.streakbundles ?? level.streakglobals;
    autotests_utility::function_8354eb3723f722f4( datasource, killstreakrefs, 0 );
    return killstreakrefs;
}

// Namespace test_mp_killstreaks_smoke
// Params 0, eflags: 0x4
// Checksum 0x73e11c3, Offset: 0x329
// Size: 0x8f, Type: bool
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility::setup();
    level.killstreakrounddelay = 0;
    autotests::set_dvar( @"scr_trace_debug_data", 1 );
    player = autotests_utility_player::get_player();
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", 45 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    return true;
}

// Namespace test_mp_killstreaks_smoke
// Params 0, eflags: 0x4
// Checksum 0xe65afa2c, Offset: 0x3c1
// Size: 0x9
function private cleanup()
{
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_killstreaks_smoke
// Params 0, eflags: 0x4
// Checksum 0xe6acc9fa, Offset: 0x3d2
// Size: 0xac
function private start_test()
{
    autotests_utility_bot::kick_all_bots();
    player = autotests_utility_player::get_player();
    bot_data = autotests_utility_bot::get_spawn_data( player, 500 );
    bot = autotests_utility_bot::function_b04d08d80ae08dcb( player, bot_data );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot Is Alive?", isalive( bot ), "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", 62 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_bot::set_bot_ignore_script_weapon( bot, 0 );
    killstreakref = self.parameters[ 0 ];
    return test_killstreak( bot, killstreakref );
}

// Namespace test_mp_killstreaks_smoke
// Params 2, eflags: 0x4
// Checksum 0x62571a8d, Offset: 0x487
// Size: 0x45b
function private test_killstreak( bot, killstreakref )
{
    equipresult = autotests_utility_content::equipcontent( bot, killstreakref );
    
    if ( !equipresult.result )
    {
        return 5;
    }
    
    killstreakslot = common_item::items_isenabled() ? 1 : 0;
    streakitem = bot killstreaks::getkillstreakinslot( killstreakslot );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Killstreak " + killstreakref + " equipped?", streakitem, "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", 81 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( !streakitem.available )
    {
        autotests::report_info( "Killstreak unavailable: " + streakitem.streakname );
        return 5;
    }
    
    var_17180d6e00540903 = bot killstreaks::getkillstreaksetupinfo( streakitem.streakname );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Found in level.killstreakSetups?", var_17180d6e00540903, "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", 90 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Found in level.streakGlobals.streakIndexByRef?", killstreak_utility::getkillstreakindex( streakitem.streakname ), -1, "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", 91 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    setup_specific_killstreak( bot, streakitem );
    var_2875ae26d6f7d960 = bot.var_8371af86d4691b34;
    bot thread function_7579128091d0d9ca();
    bot thread monitor_trigger_killstreak( streakitem, killstreakslot );
    wait 1;
    
    if ( level.var_4295719b442b453d[ streakitem.streaksetupinfo.weaponname ] )
    {
        if ( bot.currentweapon.basename == streakitem.streaksetupinfo.weaponname )
        {
            autotests::report_info( "Killstreak Weapon Equipped" );
        }
        else
        {
            var_63a718d91714219d = autotests::test_wait_any( "Killstreak Weapon Equipped?", bot, [ "weapon_change" ], 2, "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", 111 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            wait 2;
        }
        
        thread function_de891c2378f1711e( bot );
        var_c5f2ea434b79460e = bot getcurrentweaponclipammo();
        weapon = bot getcurrentweapon();
        var_d644ecc40ed007f1 = weaponisauto( weapon );
        firetime = weaponfiretime( weapon );
        var_6320808f07ece387 = undefined;
        
        if ( var_d644ecc40ed007f1 )
        {
            var_b89a0a28a5ce3891 = var_c5f2ea434b79460e * firetime + 5;
            bot botpressbutton( "ATTACK", var_b89a0a28a5ce3891 );
            var_6320808f07ece387 = bot utility::waittill_any_timeout( var_b89a0a28a5ce3891, "weapon_switch_started" );
            bot botclearbutton( "ATTACK" );
        }
        else
        {
            for ( curshot = 0; curshot < var_c5f2ea434b79460e ; curshot++ )
            {
                if ( curshot > 0 )
                {
                    wait firetime + level.framedurationseconds;
                }
                
                bot botpressbutton( "ATTACK", 2 );
                bot utility::waittill_any_timeout( 2, "weapon_fired" );
                bot botclearbutton( "ATTACK" );
            }
        }
        
        bot notify( #"hash_44047969bfdb0112" );
        
        if ( var_d644ecc40ed007f1 && var_6320808f07ece387 != "weapon_switch_started" )
        {
            var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Shot all ammo?", bot getcurrentweaponclipammo(), 0, "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", 154 );
            
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
    else
    {
        bot botpressbutton( "ADS", 2 );
        bot botpressbutton( "ATTACK", 2 );
    }
    
    wait 3;
    autotests_utility::flag_wait_or_timeout( "killstreak_use_test_checked", 10 );
    bundle = level.autotests.test_runtime.bundle;
    
    if ( bundle.var_3f9dc73971c14302 )
    {
        var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Splash showed?", var_2875ae26d6f7d960, bot.var_8371af86d4691b34, "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", 172 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    autotests_utility_scriptables::function_9902d3be8a6f6a01( bot );
    cleanup_killstreaks( bot, streakitem );
}

// Namespace test_mp_killstreaks_smoke
// Params 0, eflags: 0xc
// Checksum 0x81f6e565, Offset: 0x8ea
// Size: 0x94
function private function_7579128091d0d9ca()
{
    self notify( #"hash_5b63f2b10a27940f" );
    self endon( #"hash_5b63f2b10a27940f" );
    level endon( #"end_test" );
    level endon( #"test_finished" );
    autotests_utility::flag_clear( "killstreak_use_test_checked" );
    var_63a718d91714219d = autotests::test_wait_any( "Use successfully?", self, [ "streak_activated" ], 20, "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", 185 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility::flag_set( "killstreak_use_test_checked" );
}

// Namespace test_mp_killstreaks_smoke
// Params 2, eflags: 0xc
// Checksum 0x710c6f5f, Offset: 0x986
// Size: 0x9c
function private monitor_trigger_killstreak( streakitem, killstreakslot )
{
    self notify( #"hash_ca42f83a042e5ad8" );
    self endon( #"hash_ca42f83a042e5ad8" );
    level endon( #"end_test" );
    level endon( #"test_finished" );
    result = killstreaks::triggerkillstreak( streakitem, killstreakslot );
    
    if ( !result )
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Killstreak failed to trigger", 0, "scripts/autotests/mp/test_mp_killstreaks_smoke.gsc", 199 );
        
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

// Namespace test_mp_killstreaks_smoke
// Params 1, eflags: 0xc
// Checksum 0xe88d1d30, Offset: 0xa2a
// Size: 0x52
function private function_de891c2378f1711e( bot )
{
    self notify( #"hash_d4c205a7a179cf5c" );
    self endon( #"hash_d4c205a7a179cf5c" );
    level endon( #"end_test" );
    bot endon( #"hash_44047969bfdb0112" );
    
    while ( true )
    {
        bot botpressbutton( "ADS" );
        waitframe();
    }
}

// Namespace test_mp_killstreaks_smoke
// Params 2, eflags: 0x4
// Checksum 0xb090f423, Offset: 0xa84
// Size: 0x7c
function private setup_specific_killstreak( bot, streakitem )
{
    switch ( streakitem.streakname )
    {
        case #"hash_b0491209df7b4b5c":
            botangles = bot getplayerangles();
            bot setplayerangles( ( 45, botangles[ 1 ], botangles[ 2 ] ) );
            break;
        case #"hash_f9603e0a0581899a":
            autotests::set_dvar( @"hash_4cab1e95bf9215fd", 4 );
            break;
    }
}

// Namespace test_mp_killstreaks_smoke
// Params 2, eflags: 0x4
// Checksum 0x7c23212a, Offset: 0xb08
// Size: 0xfc
function private cleanup_killstreaks( player, streakitem )
{
    player killstreakdeploy::streakdeploy_cancelalldeployments();
    
    switch ( streakitem.streakname )
    {
        case #"hash_a34aaabd92f0ff28":
            if ( player.fireteam )
            {
                foreach ( agent in player.fireteam )
                {
                    if ( isalive( agent ) )
                    {
                        agent notify( #"merc_killed" );
                        wait 0.05;
                        
                        if ( isalive( agent ) )
                        {
                            agent kill( player.origin, player );
                        }
                    }
                }
                
                wait 1;
            }
            
            break;
    }
}

