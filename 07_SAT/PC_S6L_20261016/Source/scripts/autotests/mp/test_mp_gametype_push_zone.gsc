// scripts\autotests\mp\test_mp_gametype_push_zone.gsc  (hash_4783d5c3c170ba46.gscc) (size: 4501 Bytes / 0x1195 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x418d6905 (1099786501)
// size ...... 4501 (0x1195)
// includes .. 5   (offset: 0x1015)
// strings ... 21  (offset: 0x103d)
// dev strs .. 0   (offset: 0x1195)
// exports ... 9   (offset: 0xad9)
// cseg ...... 0x2c9 + 0x810 (0xad9)
// imports ... 24  (offset: 0xc41)
// animtree1 . 0   (offset: 0x1195)
// animtree2 . 0   (offset: 0x1195)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\mp\menus;

#namespace test_mp_gametype_push_zone;

// Namespace test_mp_gametype_push_zone
// Params 0
// Checksum 0xd9d33389, Offset: 0x2e7
// Size: 0x8, Type: bool
function validate_initial_state()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_mp_gametype_push_zone
// Params 0
// Checksum 0x4af646a5, Offset: 0x2f8
// Size: 0x9
function test_cleanup()
{
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_gametype_push_zone
// Params 0
// Checksum 0xc68c336a, Offset: 0x309
// Size: 0x180
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::push_function( "Wait for countdown to finish" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Wait for countdown to finish", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 36 );
    autotests::pop_function( "Wait for countdown to finish" );
    autotests::test_assert_return( test_result_int );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player Is Alive At Test Start", isalive( player ), "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 37 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::push_function( "Ensure player is on attackers team" );
    test_result_int = function_ff766704b29f8998( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Ensure player is on attackers team", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 38 );
    autotests::pop_function( "Ensure player is on attackers team" );
    autotests::test_assert_return( test_result_int );
    wait 2;
    autotests::push_function( "Capture zone awards points" );
    test_result_int = function_d42297ba1d50e169( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Capture zone awards points", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 41 );
    autotests::pop_function( "Capture zone awards points" );
    autotests::test_assert_return( test_result_int );
    wait 2;
    autotests::push_function( "Capture zone can be contested by player" );
    test_result_int = function_efa2b89efe3b028b( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Capture zone can be contested by player", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 43 );
    autotests::pop_function( "Capture zone can be contested by player" );
    autotests::test_assert_return( test_result_int );
    return 0;
}

// Namespace test_mp_gametype_push_zone
// Params 0, eflags: 0x4
// Checksum 0xc7ee4e3d, Offset: 0x492
// Size: 0x79
function private function_fe148c8b53c02e88()
{
    spawn_timeout = gettime() + 10000;
    
    while ( !isdefined( level.pushzone ) && gettime() < spawn_timeout )
    {
        waitframe();
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Push zone vehicle exists", isdefined( level.pushzone ), "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 56 );
    
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

// Namespace test_mp_gametype_push_zone
// Params 1, eflags: 0x4
// Checksum 0x1b6e3d98, Offset: 0x514
// Size: 0x3a, Type: bool
function private wait_for_player_alive( player )
{
    timeout_alive = gettime() + 15000;
    
    while ( !isalive( player ) && gettime() < timeout_alive )
    {
        waitframe();
    }
    
    return false;
}

// Namespace test_mp_gametype_push_zone
// Params 1, eflags: 0x4
// Checksum 0xd4cf75c6, Offset: 0x557
// Size: 0x196
function private function_ff766704b29f8998( player )
{
    attackers_team = game[ "attackers" ];
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Attackers team is defined", isdefined( attackers_team ), "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 76 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( player.team != attackers_team )
    {
        target_team_selection = -1;
        
        if ( attackers_team == "axis" )
        {
            target_team_selection = 0;
        }
        else if ( attackers_team == "allies" )
        {
            target_team_selection = 1;
        }
        
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Attackers team can be selected", target_team_selection >= 0, "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 90 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        player menus::handleteamchange( "autotest", target_team_selection );
        timeout = gettime() + 15000;
        
        while ( player.team != attackers_team && gettime() < timeout )
        {
            waitframe();
        }
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Player switched to attackers team", player.team, attackers_team, "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 100 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait_for_player_alive( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is alive on attackers team", isalive( player ), "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 103 );
    
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

// Namespace test_mp_gametype_push_zone
// Params 1, eflags: 0x4
// Checksum 0x94a099c6, Offset: 0x6f6
// Size: 0x225
function private function_d42297ba1d50e169( player )
{
    function_fe148c8b53c02e88();
    initial_score = player.score;
    var_808e335762d0eb9 = player.streakpoints;
    var_ad66de543062a7fe = level.pushzone.origin;
    origin_changed = 0;
    destination_timeout = gettime() + 30000;
    var_ed27eb7ddbbb67ef = 0;
    
    while ( gettime() < destination_timeout )
    {
        if ( !isalive( player ) )
        {
            waitframe();
            continue;
        }
        
        player setorigin( level.pushzone.origin );
        
        if ( level.var_6fee3c1d43ed86ad == 4 || level.var_6fee3c1d43ed86ad == 5 )
        {
            var_ed27eb7ddbbb67ef = 1;
            break;
        }
        
        waitframe();
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "UGV reached destination", var_ed27eb7ddbbb67ef, "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 137 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 2;
    score_points = 0;
    var_1c8175b01cca4a0a = gettime() + 60000;
    
    while ( gettime() < var_1c8175b01cca4a0a )
    {
        if ( !isalive( player ) )
        {
            waitframe();
            continue;
        }
        
        player setorigin( level.pushzone.origin );
        
        if ( level.pushzone.origin != var_ad66de543062a7fe )
        {
            origin_changed = 1;
        }
        
        if ( player.score > initial_score || player.streakpoints > var_808e335762d0eb9 )
        {
            score_points = 1;
            break;
        }
        
        waitframe();
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player earned points from zone capture", score_points, "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 164 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Capture zone moved during match", origin_changed, "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 165 );
    
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

// Namespace test_mp_gametype_push_zone
// Params 1, eflags: 0x4
// Checksum 0x5f5e27cc, Offset: 0x924
// Size: 0x1b4
function private function_efa2b89efe3b028b( player )
{
    function_fe148c8b53c02e88();
    spawn_data = autotests_utility_bot::create_spawn_data( level.pushzone.origin, ( 0, 0, 0 ) );
    var_d9084239cc1ec7f0 = autotests_utility_bot::function_978126f411fc8a11( player, spawn_data );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Enemy bot spawned", isdefined( var_d9084239cc1ec7f0 ), "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 176 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Enemy bot is alive", isalive( var_d9084239cc1ec7f0 ), "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 177 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 2;
    contested_timeout = gettime() + 15000;
    contested = 0;
    
    while ( gettime() < contested_timeout )
    {
        if ( !isalive( player ) || !isalive( var_d9084239cc1ec7f0 ) )
        {
            waitframe();
            continue;
        }
        
        player setorigin( level.pushzone.origin );
        autotests_utility_bot::teleport_bot( var_d9084239cc1ec7f0, level.pushzone.origin, ( 0, 0, 0 ) );
        
        if ( level.var_6fee3c1d43ed86ad == 0 || level.var_6fee3c1d43ed86ad == 6 )
        {
            contested = 1;
            break;
        }
        
        waitframe();
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Capture zone is contested by player", contested, "scripts/autotests/mp/test_mp_gametype_push_zone.gsc", 202 );
    
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

