// scripts\autotests\mp\test_mp_gametype_dom.gsc  (hash_5134b22070912369.gscc) (size: 4375 Bytes / 0x1117 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec253c1b (3961863195)
// size ...... 4375 (0x1117)
// includes .. 5   (offset: 0xfab)
// strings ... 19  (offset: 0xfd3)
// dev strs .. 0   (offset: 0x1117)
// exports ... 7   (offset: 0xadb)
// cseg ...... 0x217 + 0x8c4 (0xadb)
// imports ... 25  (offset: 0xbf3)
// animtree1 . 0   (offset: 0x1117)
// animtree2 . 0   (offset: 0x1117)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;

#namespace test_mp_gametype_dom;

// Namespace test_mp_gametype_dom
// Params 0
// Checksum 0xee15a1d2, Offset: 0x235
// Size: 0x8, Type: bool
function validate_initial_state()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_mp_gametype_dom
// Params 0
// Checksum 0x7d30d4fe, Offset: 0x246
// Size: 0x9
function test_cleanup()
{
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_gametype_dom
// Params 0
// Checksum 0xc339090b, Offset: 0x257
// Size: 0x3fa
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::push_function( "Wait for countdown to finish" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Wait for countdown to finish", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 24 );
    autotests::pop_function( "Wait for countdown to finish" );
    autotests::test_assert_return( test_result_int );
    autotests::function_36ed835262a19e53( "Player found", player, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 25 );
    objectives = level.objectives;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "At least 3 objectives found", objectives.size >= 3, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 28 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    foreach ( objective in objectives )
    {
        utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_d7f5cf7eefee4ed7", objective, "none" );
    }
    
    autotests::push_function( toupper( player.team ) + " capture all objectives" );
    test_result_int = function_5093c4a3d587e735( player, objectives ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( toupper( player.team ) + " capture all objectives", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 35 );
    autotests::pop_function( toupper( player.team ) + " capture all objectives" );
    autotests::test_assert_return( test_result_int );
    bot_spawn_data = autotests_utility_bot::get_spawn_data( player, 90 );
    bot = autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, bot_spawn_data );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spawn bot", isdefined( bot ), "scripts/autotests/mp/test_mp_gametype_dom.gsc", 39 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Player and bot on separate teams", player.team, bot.team, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 40 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::push_function( "Neutralize all objectives" );
    test_result_int = function_321df44832a1c168( bot, objectives ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Neutralize all objectives", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 42 );
    autotests::pop_function( "Neutralize all objectives" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( toupper( bot.team ) + " capture all objectives" );
    test_result_int = function_5093c4a3d587e735( bot, objectives ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( toupper( bot.team ) + " capture all objectives", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 44 );
    autotests::pop_function( toupper( bot.team ) + " capture all objectives" );
    autotests::test_assert_return( test_result_int );
    
    foreach ( objective in objectives )
    {
        utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_d7f5cf7eefee4ed7", objective, "none" );
    }
    
    autotests::push_function( "Contest all objectives" );
    test_result_int = function_f51d6171aeda4f58( player, bot, objectives ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Contest all objectives", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 51 );
    autotests::pop_function( "Contest all objectives" );
    autotests::test_assert_return( test_result_int );
    return 0;
}

// Namespace test_mp_gametype_dom
// Params 2, eflags: 0x4
// Checksum 0xffa5380, Offset: 0x65a
// Size: 0x145
function private function_5093c4a3d587e735( player, objectives )
{
    var_1634357e3928adde = [ "dom_flag_captured", "capture" ];
    player_origin = player.origin;
    
    foreach ( objective_key, objective in objectives )
    {
        var_8b70d8aedcddc58c = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", objective );
        player setorigin( var_8b70d8aedcddc58c );
        var_63a718d91714219d = autotests::test_wait_any( toupper( player.team ) + " capture " + objective_key, objective, var_1634357e3928adde, level.flagcapturetime + 0.1, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 66 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    player setorigin( player_origin );
    return 0;
}

// Namespace test_mp_gametype_dom
// Params 2, eflags: 0x4
// Checksum 0x3cc0fa6e, Offset: 0x7a8
// Size: 0x175
function private function_321df44832a1c168( player, objectives )
{
    var_1634357e3928adde = [ "dom_flag_neutralized", "flag_neutral" ];
    player_origin = player.origin;
    
    foreach ( objective_key, objective in objectives )
    {
        if ( !utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c0f9f3bdd5af6c8", objective ) )
        {
            autotests::report_info( objective_key + " does not require neutralization" );
            continue;
        }
        
        var_8b70d8aedcddc58c = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", objective );
        player setorigin( var_8b70d8aedcddc58c );
        var_63a718d91714219d = autotests::test_wait_any( toupper( player.team ) + " neutralize " + objective_key, objective, var_1634357e3928adde, level.var_e56cac0580f1c92c + 0.1, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 90 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        player setorigin( player_origin );
    }
    
    return 0;
}

// Namespace test_mp_gametype_dom
// Params 3, eflags: 0x4
// Checksum 0xb461095b, Offset: 0x926
// Size: 0x1b4
function private function_f51d6171aeda4f58( var_242f2a39fff032b, player_2, objectives )
{
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Players on separate teams", var_242f2a39fff032b.team, player_2.team, "scripts/autotests/mp/test_mp_gametype_dom.gsc", 99 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_1fda08f469111626 = var_242f2a39fff032b.origin;
    var_bee53300808525dd = player_2.origin;
    origin_offset = ( var_bee53300808525dd - var_1fda08f469111626 ) * 0.5;
    
    foreach ( objective_key, objective in objectives )
    {
        var_8b70d8aedcddc58c = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", objective );
        var_242f2a39fff032b setorigin( var_8b70d8aedcddc58c - origin_offset );
        player_2 setorigin( var_8b70d8aedcddc58c + origin_offset );
        wait 1;
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( objective_key + " contested", utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_97db60d016bf64fa", objective ), "scripts/autotests/mp/test_mp_gametype_dom.gsc", 113 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    var_242f2a39fff032b setorigin( var_1fda08f469111626 );
    player_2 setorigin( var_bee53300808525dd );
    return 0;
}

