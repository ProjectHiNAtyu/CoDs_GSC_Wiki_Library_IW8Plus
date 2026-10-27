// scripts\autotests\mp\test_mp_gametype_sd.gsc  (hash_5bca9dec0438df12.gscc) (size: 8646 Bytes / 0x21c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe4410c33 (3829468211)
// size ...... 8646 (0x21c6)
// includes .. 6   (offset: 0x1e0e)
// strings ... 43  (offset: 0x1e3e)
// dev strs .. 0   (offset: 0x21c6)
// exports ... 12  (offset: 0x15ee)
// cseg ...... 0x55d + 0x1091 (0x15ee)
// imports ... 34  (offset: 0x17ce)
// animtree1 . 0   (offset: 0x21c6)
// animtree2 . 0   (offset: 0x21c6)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;
#using scripts\mp\menus;

#namespace test_mp_gametype_sd;

// Namespace test_mp_gametype_sd
// Params 0
// Checksum 0x8e95bbea, Offset: 0x57b
// Size: 0xf, Type: bool
function validate_initial_state()
{
    autotests::function_375124f1db824f72();
    return autotests::function_5c8c87763724c132();
}

// Namespace test_mp_gametype_sd
// Params 0
// Checksum 0x8656afe2, Offset: 0x593
// Size: 0x42e
function start_test()
{
    player = autotests_utility_player::get_player();
    
    if ( game[ "roundsPlayed" ] == 0 )
    {
        setdvar( @"bot_debugdifficulty", "veteran" );
        autotests::push_function( "Wait for countdown to finish" );
        test_result_int = player autotests_utility::test_prematch_done() ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Wait for countdown to finish", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 29 );
        autotests::pop_function( "Wait for countdown to finish" );
        autotests::test_assert_return( test_result_int );
        autotests::push_function( "Round" + game[ "roundsPlayed" ] + ": Ensure player is on attackers team" );
        test_result_int = function_ff766704b29f8998( player ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Round" + game[ "roundsPlayed" ] + ": Ensure player is on attackers team", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 30 );
        autotests::pop_function( "Round" + game[ "roundsPlayed" ] + ": Ensure player is on attackers team" );
        autotests::test_assert_return( test_result_int );
        autotests::push_function( "Round" + game[ "roundsPlayed" ] + ": Plant bomb at site A" );
        test_result_int = function_e8c7b426738485c2( player, "_a" ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Round" + game[ "roundsPlayed" ] + ": Plant bomb at site A", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 31 );
        autotests::pop_function( "Round" + game[ "roundsPlayed" ] + ": Plant bomb at site A" );
        autotests::test_assert_return( test_result_int );
        autotests::push_function( "Round" + game[ "roundsPlayed" ] + ": Ensure bomb detonates after timer ends" );
        test_result_int = function_2c94836be2308bd7( player ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Round" + game[ "roundsPlayed" ] + ": Ensure bomb detonates after timer ends", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 32 );
        autotests::pop_function( "Round" + game[ "roundsPlayed" ] + ": Ensure bomb detonates after timer ends" );
        autotests::test_assert_return( test_result_int );
    }
    
    timeout_countdown_start = gettime() + 15000;
    
    while ( gettime() < timeout_countdown_start )
    {
        if ( game[ "roundsPlayed" ] > 0 )
        {
            break;
        }
        
        wait 0.5;
    }
    
    wait 3;
    autotests::push_function( "Wait for countdown to finish" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Wait for countdown to finish", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 46 );
    autotests::pop_function( "Wait for countdown to finish" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Round" + game[ "roundsPlayed" ] + ": Ensure player is on attackers team" );
    test_result_int = function_ff766704b29f8998( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Round" + game[ "roundsPlayed" ] + ": Ensure player is on attackers team", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 47 );
    autotests::pop_function( "Round" + game[ "roundsPlayed" ] + ": Ensure player is on attackers team" );
    autotests::test_assert_return( test_result_int );
    bot_spawn_data = autotests_utility_bot::get_spawn_data( player, 90 );
    opposing_bot = autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, bot_spawn_data );
    wait 0.5;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Round" + game[ "roundsPlayed" ] + ": Opposing bot exists", isdefined( opposing_bot ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 51 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::push_function( "Round" + game[ "roundsPlayed" ] + ": Plant bomb at site B" );
    test_result_int = function_e8c7b426738485c2( player, "_b" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Round" + game[ "roundsPlayed" ] + ": Plant bomb at site B", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 52 );
    autotests::pop_function( "Round" + game[ "roundsPlayed" ] + ": Plant bomb at site B" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Round" + game[ "roundsPlayed" ] + ": Ensure bomb can be defused" );
    test_result_int = function_a1ddde193225724d( player, opposing_bot ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Round" + game[ "roundsPlayed" ] + ": Ensure bomb can be defused", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 53 );
    autotests::pop_function( "Round" + game[ "roundsPlayed" ] + ": Ensure bomb can be defused" );
    autotests::test_assert_return( test_result_int );
    return 0;
}

// Namespace test_mp_gametype_sd
// Params 1, eflags: 0x4
// Checksum 0x8a2546cf, Offset: 0x9ca
// Size: 0x90
function private get_bomb_site( bomb_site_key )
{
    foreach ( site in level.objectives )
    {
        if ( site.objectivekey == bomb_site_key )
        {
            return site;
        }
    }
}

// Namespace test_mp_gametype_sd
// Params 3, eflags: 0x4
// Checksum 0x9f267957, Offset: 0xa63
// Size: 0xb8
function private function_5628548910e4cd92( player, bomb_site, bomb_timer_seconds = undefined )
{
    if ( isdefined( bomb_timer_seconds ) )
    {
        bomb_site.bombtimer = bomb_timer_seconds;
    }
    
    level.sdbomb.safeorigin = level.sdbomb.trigger.origin;
    level.sdbomb.carrier = player;
    level.multibomb = 1;
    wait 0.5;
    level.sdbomb.stalemate = 0;
    bomb_site [[ bomb_site.onuse ]]( player );
}

// Namespace test_mp_gametype_sd
// Params 2, eflags: 0x4
// Checksum 0x556f3241, Offset: 0xb23
// Size: 0xf3
function private function_be20fc6e7cb5ac1f( player, bomb_site_key )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bomb is not already planted before test", !level.bombplanted, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 90 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bomb_site = get_bomb_site( bomb_site_key );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bomb site exists for provided key", isdefined( bomb_site ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 93 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_5628548910e4cd92( player, bomb_site, 2 );
    wait 1;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bomb was planted", level.bombplanted, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 96 );
    
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

// Namespace test_mp_gametype_sd
// Params 2, eflags: 0x4
// Checksum 0x5ee30b39, Offset: 0xc1f
// Size: 0x214
function private function_a1ddde193225724d( player, opposing_bot )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bomb is planted before defuse test", level.bombplanted, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 103 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Opposing bot exists for defuse", isbot( opposing_bot ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 104 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    timeout_defuse_object = gettime() + 15000;
    
    while ( !isdefined( level.defuseobject ) && gettime() < timeout_defuse_object )
    {
        wait 0.5;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Defuse object exists after plant", isdefined( level.defuseobject ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 112 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    defuse_origin = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", level.defuseobject );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Defuse object origin is defined", isdefined( defuse_origin ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 115 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    opposing_bot setorigin( defuse_origin + ( 0, 0, 10 ) );
    wait 0.5;
    level.defuseobject [[ level.defuseobject.onuse ]]( opposing_bot );
    timeout_defuse = gettime() + 15000;
    
    while ( !level.bombdefused && gettime() < timeout_defuse )
    {
        wait 0.5;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bomb was defused", level.bombdefused, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 128 );
    
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

// Namespace test_mp_gametype_sd
// Params 1, eflags: 0x4
// Checksum 0xe57fbad7, Offset: 0xe3c
// Size: 0x34f
function private function_2c94836be2308bd7( player )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bomb is planted before detonation wait", level.bombplanted, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 135 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player exists for detonation setup", isdefined( player ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 136 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_ba9db69c2f282579 = game[ "roundsPlayed" ];
    
    if ( isingodmode( player ) )
    {
        autotests_utility_bot::set_bot_godmode( player, 0 );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Defuse object exists for detonation setup", isdefined( level.defuseobject ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 144 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bomb_origin = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", level.defuseobject );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bomb origin is defined for detonation setup", isdefined( bomb_origin ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 147 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player setorigin( bomb_origin + ( 0, 0, 10 ) );
    player.health = 1;
    wait 0.5;
    timeout_detonate = gettime() + 15000;
    
    while ( level.bombexploded <= 0 && gettime() < timeout_detonate )
    {
        wait 0.5;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bomb detonated after timer ended", level.bombexploded > 0, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 159 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bomb was not defused before detonation", !level.bombdefused, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 160 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    timeout_player_death = gettime() + 15000;
    
    while ( isalive( player ) && gettime() < timeout_player_death )
    {
        wait 0.5;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player was killed by bomb detonation", !isalive( player ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 168 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_c2f5022f8632f21a = 0;
    timeout_round_transition = gettime() + 15000;
    
    while ( game[ "roundsPlayed" ] == var_ba9db69c2f282579 && gettime() < timeout_round_transition )
    {
        if ( isalive( player ) )
        {
            var_c2f5022f8632f21a = 1;
            break;
        }
        
        wait 0.5;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Next round began after bomb detonation", game[ "roundsPlayed" ] > var_ba9db69c2f282579, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 183 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player does not respawn until the next round begins", !var_c2f5022f8632f21a, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 184 );
    
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

// Namespace test_mp_gametype_sd
// Params 1, eflags: 0x4
// Checksum 0x2a1893e6, Offset: 0x1194
// Size: 0xba
function private function_fc0c11acfcb08ca3( player )
{
    if ( level.sdbomb.carrier == player )
    {
        return 0;
    }
    
    timeout_pickup = gettime() + 15000;
    
    while ( level.sdbomb.carrier != player && gettime() < timeout_pickup )
    {
        wait 0.5;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player picked up bomb", level.sdbomb.carrier == player, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 203 );
    
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

// Namespace test_mp_gametype_sd
// Params 2, eflags: 0x4
// Checksum 0x6631abe7, Offset: 0x1257
// Size: 0x1b8
function private function_e8c7b426738485c2( player, bomb_site_key )
{
    timeout_bomb = gettime() + 15000;
    
    while ( !isdefined( level.sdbomb ) && gettime() < timeout_bomb )
    {
        wait 0.5;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "SD bomb exists", isdefined( level.sdbomb ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 216 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bomb_origin = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", level.sdbomb );
    player setorigin( bomb_origin + ( 0, 0, 10 ) );
    wait 0.5;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player teleported to bomb", distancesquared( player.origin, bomb_origin ) <= 16384, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 223 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::push_function( "Ensure bomb can be picked up" );
    test_result_int = function_fc0c11acfcb08ca3( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Ensure bomb can be picked up", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 224 );
    autotests::pop_function( "Ensure bomb can be picked up" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Ensure bomb can be planted" );
    test_result_int = function_be20fc6e7cb5ac1f( player, bomb_site_key ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Ensure bomb can be planted", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 225 );
    autotests::pop_function( "Ensure bomb can be planted" );
    autotests::test_assert_return( test_result_int );
    return 0;
}

// Namespace test_mp_gametype_sd
// Params 1, eflags: 0x4
// Checksum 0x49649c92, Offset: 0x1418
// Size: 0x1c4
function private function_ff766704b29f8998( player )
{
    attackers_team = game[ "attackers" ];
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Attackers team is defined", isdefined( attackers_team ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 233 );
    
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
        
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Attackers team can be selected", target_team_selection >= 0, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 247 );
        
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
            wait 0.5;
        }
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Player switched to attackers team", player.team, attackers_team, "scripts/autotests/mp/test_mp_gametype_sd.gsc", 257 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    timeout_alive = gettime() + 15000;
    
    while ( !isalive( player ) && gettime() < timeout_alive )
    {
        wait 0.5;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is alive on attackers team", isalive( player ), "scripts/autotests/mp/test_mp_gametype_sd.gsc", 264 );
    
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

// Namespace test_mp_gametype_sd
// Params 0
// Checksum 0x3366f8a5, Offset: 0x15e5
// Size: 0x9
function test_cleanup()
{
    autotests_utility_bot::kick_all_bots();
}

