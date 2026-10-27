// scripts\autotests\mp\test_mp_gametype_koth.gsc  (hash_63a806cabad53f3b.gscc) (size: 3461 Bytes / 0xd85 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x73e85303 (1944605443)
// size ...... 3461 (0xd85)
// includes .. 5   (offset: 0xc61)
// strings ... 14  (offset: 0xc89)
// dev strs .. 0   (offset: 0xd85)
// exports ... 7   (offset: 0x809)
// cseg ...... 0x251 + 0x5b8 (0x809)
// imports ... 24  (offset: 0x921)
// animtree1 . 0   (offset: 0xd85)
// animtree2 . 0   (offset: 0xd85)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;

#namespace test_mp_gametype_koth;

// Namespace test_mp_gametype_koth
// Params 0
// Checksum 0xbff7d37c, Offset: 0x26f
// Size: 0x8, Type: bool
function validate_initial_state()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_mp_gametype_koth
// Params 0
// Checksum 0x2cd2a650, Offset: 0x280
// Size: 0x9
function test_cleanup()
{
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_gametype_koth
// Params 0
// Checksum 0x3b953123, Offset: 0x291
// Size: 0x1b4
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::push_function( "Wait for countdown to finish" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Wait for countdown to finish", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_koth.gsc", 24 );
    autotests::pop_function( "Wait for countdown to finish" );
    autotests::test_assert_return( test_result_int );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player Is Alive At Test Start", isalive( player ), "scripts/autotests/mp/test_mp_gametype_koth.gsc", 25 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    zone = level.zone;
    initial_zone_origin = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", zone );
    autotests::push_function( "Holding hardpoint increases score" );
    test_result_int = function_da0c855d83c41fca( player, zone ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Holding hardpoint increases score", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_koth.gsc", 28 );
    autotests::pop_function( "Holding hardpoint increases score" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Hardpoint zone can be contested" );
    test_result_int = function_7c2c9b710ec42a6e( player, zone ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Hardpoint zone can be contested", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_koth.gsc", 29 );
    autotests::pop_function( "Hardpoint zone can be contested" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Hardpoint zone moves throughout match" );
    test_result_int = function_6423181edcedf768( zone, initial_zone_origin ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Hardpoint zone moves throughout match", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_koth.gsc", 30 );
    autotests::pop_function( "Hardpoint zone moves throughout match" );
    autotests::test_assert_return( test_result_int );
    return 0;
}

// Namespace test_mp_gametype_koth
// Params 2, eflags: 0x4
// Checksum 0x3d8ea02d, Offset: 0x44e
// Size: 0x111
function private function_da0c855d83c41fca( player, zone )
{
    zone_origin = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", zone );
    player setorigin( zone_origin );
    var_63a718d91714219d = autotests::test_wait_any( "Hardpoint zone captured and score started", level, [ "update_team_score" ], 30, "scripts/autotests/mp/test_mp_gametype_koth.gsc", 41 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    initial_score = game[ "teamScores" ][ player.team ];
    hold_seconds = 5;
    wait hold_seconds;
    current_score = game[ "teamScores" ][ player.team ];
    var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "Score increased while holding hardpoint", current_score, initial_score + hold_seconds - 1, "scripts/autotests/mp/test_mp_gametype_koth.gsc", 49 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    return 0;
}

// Namespace test_mp_gametype_koth
// Params 2, eflags: 0x4
// Checksum 0x71fdd8f5, Offset: 0x568
// Size: 0x192
function private function_7c2c9b710ec42a6e( player, zone )
{
    zone_origin = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", zone );
    bot_spawn_data = autotests_utility_bot::get_spawn_data( player, 45 );
    bot = autotests_utility_bot::function_978126f411fc8a11( player, bot_spawn_data );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spawn opponent bot for contested zone", isdefined( bot ), "scripts/autotests/mp/test_mp_gametype_koth.gsc", 60 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player setorigin( zone_origin + ( 12, 0, 0 ) );
    bot setorigin( zone_origin - ( 12, 0, 0 ) );
    wait 1;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Hardpoint zone is contested", utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_97db60d016bf64fa", zone ), "scripts/autotests/mp/test_mp_gametype_koth.gsc", 67 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    contested_start_score = game[ "teamScores" ][ player.team ];
    wait 5;
    contested_end_score = game[ "teamScores" ][ player.team ];
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Score does not increase while contested", contested_end_score, contested_start_score, "scripts/autotests/mp/test_mp_gametype_koth.gsc", 73 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    return 0;
}

// Namespace test_mp_gametype_koth
// Params 2, eflags: 0x4
// Checksum 0xcaf6413e, Offset: 0x703
// Size: 0x105
function private function_6423181edcedf768( zone, initial_zone_origin )
{
    max_wait_seconds = int( level.firstzoneactivationdelay + level.zoneduration + 30 );
    max_wait_seconds = max( max_wait_seconds, 60 );
    elapsed_time = 0;
    check_interval = 1;
    zone_moved = 0;
    
    while ( elapsed_time < max_wait_seconds && !zone_moved )
    {
        if ( isdefined( level.zone ) )
        {
            current_zone_origin = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", level.zone );
            
            if ( current_zone_origin != initial_zone_origin )
            {
                zone_moved = 1;
                break;
            }
        }
        
        wait check_interval;
        elapsed_time += check_interval;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Hardpoint moved to a different zone", zone_moved, "scripts/autotests/mp/test_mp_gametype_koth.gsc", 102 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    return 0;
}

