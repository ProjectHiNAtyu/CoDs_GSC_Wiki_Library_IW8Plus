// scripts\autotests\mp\test_mp_gametype_flags_of_war.gsc  (hash_07c5aa907dd7b981.gscc) (size: 5387 Bytes / 0x150b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9c6df8b3 (2624452787)
// size ...... 5387 (0x150b)
// includes .. 7   (offset: 0x133f)
// strings ... 22  (offset: 0x1377)
// dev strs .. 0   (offset: 0x150b)
// exports ... 11  (offset: 0xcb7)
// cseg ...... 0x3b8 + 0x8ff (0xcb7)
// imports ... 32  (offset: 0xe6f)
// animtree1 . 0   (offset: 0x150b)
// animtree2 . 0   (offset: 0x150b)
#using script_382bf8d77c4fd348;
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;
#using scripts\mp\common\gameobjects\gameobjects_shared;

#namespace test_mp_gametype_flags_of_war;

// Namespace test_mp_gametype_flags_of_war/testautomation
// Params 0, eflags: 0x20
// Checksum 0x487e2842, Offset: 0x3d6
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", #"test", &start_test, &validate_initial_state, &test_cleanup );
}

// Namespace test_mp_gametype_flags_of_war
// Params 0
// Checksum 0xe7f384fe, Offset: 0x404
// Size: 0x8, Type: bool
function validate_initial_state()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_mp_gametype_flags_of_war
// Params 0
// Checksum 0x4bd6f1b0, Offset: 0x415
// Size: 0xf
function test_cleanup()
{
    wait 0.5;
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_gametype_flags_of_war
// Params 0
// Checksum 0xa6cb6321, Offset: 0x42c
// Size: 0x276
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::push_function( "Wait for countdown to finish" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Wait for countdown to finish", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 36 );
    autotests::pop_function( "Wait for countdown to finish" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Initialize Flags Of War flags" );
    test_result_int = init_flags_state() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Initialize Flags Of War flags", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 37 );
    autotests::pop_function( "Initialize Flags Of War flags" );
    autotests::test_assert_return( test_result_int );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player Is Alive At Test Start?", isalive( player ), "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 38 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bot_spawn_data = autotests_utility_bot::get_spawn_data( player, 90 );
    opponent_bot = autotests_utility_bot::function_978126f411fc8a11( player, bot_spawn_data );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spawned opponent bot", isdefined( opponent_bot ), "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 41 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Opponent bot is on different team", opponent_bot.team, player.team, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 42 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::push_function( "Player can capture an active flag" );
    test_result_int = function_933be5cb16baf275( player, "none" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Player can capture an active flag", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 43 );
    autotests::pop_function( "Player can capture an active flag" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Player can capture enemy flags" );
    test_result_int = function_933be5cb16baf275( player, opponent_bot.team ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Player can capture enemy flags", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 44 );
    autotests::pop_function( "Player can capture enemy flags" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Flags can be contested" );
    test_result_int = function_682db1e4f435fa0b( player, opponent_bot ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Flags can be contested", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 45 );
    autotests::pop_function( "Flags can be contested" );
    autotests::test_assert_return( test_result_int );
    return 0;
}

// Namespace test_mp_gametype_flags_of_war
// Params 2, eflags: 0x4
// Checksum 0x358e142e, Offset: 0x6ab
// Size: 0x1cc
function private function_933be5cb16baf275( player, initial_owner_team )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "At least one active flag exists", isdefined( level.active_flags ) && level.active_flags.size > 0, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 52 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    objective = level.active_flags[ 0 ];
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Active flag objective is defined", isdefined( objective ), "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 55 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Active flag trigger is defined", isdefined( objective.trigger ), "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 56 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    set_objective_owner_team( objective, initial_owner_team );
    starttime = gettime();
    
    while ( !( get_objective_owner_team( objective ) == initial_owner_team ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 3000 )
        {
            autotests::function_d84657f448aaeef6( "Failed to set active FoW flag ownership before capture test.", 0, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 59 );
            return;
        }
    }
    
    var_8b70d8aedcddc58c = objective.trigger.origin;
    player setorigin( var_8b70d8aedcddc58c );
    waitframe();
    capture_timeout_ms = function_38e4a7bb8234058( objective );
    starttime = gettime();
    
    while ( !( get_objective_owner_team( objective ) == player.team ) )
    {
        waitframe();
        
        if ( gettime() - starttime > capture_timeout_ms )
        {
            autotests::function_d84657f448aaeef6( "Failed to capture flag from " + initial_owner_team + " ownership.", 0, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 65 );
            return;
        }
    }
    
    return 0;
}

// Namespace test_mp_gametype_flags_of_war
// Params 2, eflags: 0x4
// Checksum 0x376fa4b8, Offset: 0x880
// Size: 0x282
function private function_682db1e4f435fa0b( player, opponent_bot )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "At least one active flag exists", isdefined( level.active_flags ) && level.active_flags.size > 0, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 72 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    objective = level.active_flags[ 0 ];
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Active flag objective is defined", isdefined( objective ), "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 75 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Active flag trigger is defined", isdefined( objective.trigger ), "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 76 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    set_objective_owner_team( objective, player.team );
    starttime = gettime();
    
    while ( !( get_objective_owner_team( objective ) == player.team ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 3000 )
        {
            autotests::function_d84657f448aaeef6( "Failed to set active FoW flag to player team ownership.", 0, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 80 );
            return;
        }
    }
    
    var_8b70d8aedcddc58c = objective.trigger.origin;
    player setorigin( var_8b70d8aedcddc58c );
    wait 2;
    start_owner = get_objective_owner_team( objective );
    opponent_bot setorigin( var_8b70d8aedcddc58c );
    wait 2;
    contested_owner = get_objective_owner_team( objective );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Flag ownership unchanged while contested", start_owner, contested_owner, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 91 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_e25cda8e3e4d4c9a = var_8b70d8aedcddc58c + ( 500, 0, 0 );
    player setorigin( var_e25cda8e3e4d4c9a );
    capture_timeout_ms = function_38e4a7bb8234058( objective );
    starttime = gettime();
    
    while ( !( get_objective_owner_team( objective ) == opponent_bot.team ) )
    {
        waitframe();
        
        if ( gettime() - starttime > capture_timeout_ms )
        {
            autotests::function_d84657f448aaeef6( "Bot did not capture objective after player left the zone.", 0, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 98 );
            return;
        }
    }
    
    opponent_bot setorigin( var_8b70d8aedcddc58c + ( 200, 0, 0 ) );
    wait 2;
    return 0;
}

// Namespace test_mp_gametype_flags_of_war
// Params 1, eflags: 0x4
// Checksum 0x73d51ec5, Offset: 0xb0b
// Size: 0x14
function private get_objective_owner_team( objective )
{
    return namespace_277c922f0d0dc523::get_owning_team_name( objective );
}

// Namespace test_mp_gametype_flags_of_war
// Params 2, eflags: 0x4
// Checksum 0x5107490b, Offset: 0xb28
// Size: 0x31
function private set_objective_owner_team( objective, team_name )
{
    utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_d7f5cf7eefee4ed7", objective, team_name );
}

// Namespace test_mp_gametype_flags_of_war
// Params 1, eflags: 0x4
// Checksum 0xb0333cd7, Offset: 0xb61
// Size: 0x38
function private function_38e4a7bb8234058( objective )
{
    capture_time_seconds = gameobjects_shared::get_use_time_seconds( objective ) ?? 15;
    return int( ( capture_time_seconds + 15 ) * 1000 );
}

// Namespace test_mp_gametype_flags_of_war
// Params 0, eflags: 0x4
// Checksum 0xd6f74fc3, Offset: 0xba2
// Size: 0x114
function private init_flags_state()
{
    starttime = gettime();
    
    while ( !( isdefined( level.total_flag_count ) && level.total_flag_count > 0 ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 10000 )
        {
            autotests::function_d84657f448aaeef6( "flags_of_war::init_flags did not set level.total_flag_count.", 0, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 125 );
            return;
        }
    }
    
    starttime = gettime();
    
    while ( !( isdefined( level.objectives ) && level.objectives.size == level.total_flag_count ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 10000 )
        {
            autotests::function_d84657f448aaeef6( "flags_of_war objectives were not initialized to expected count.", 0, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 126 );
            return;
        }
    }
    
    if ( isdefined( level.middle_flag_index ) && level.middle_flag_index >= 0 )
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Middle flag index is valid", level.middle_flag_index < level.total_flag_count, "scripts/autotests/mp/test_mp_gametype_flags_of_war.gsc", 130 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    return 0;
}

