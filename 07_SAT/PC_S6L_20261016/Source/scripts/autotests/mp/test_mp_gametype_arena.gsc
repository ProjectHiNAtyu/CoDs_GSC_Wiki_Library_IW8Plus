// scripts\autotests\mp\test_mp_gametype_arena.gsc  (hash_131cc90c86f287aa.gscc) (size: 6406 Bytes / 0x1906 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f49a335 (1867096885)
// size ...... 6406 (0x1906)
// includes .. 5   (offset: 0x16ae)
// strings ... 35  (offset: 0x16d6)
// dev strs .. 0   (offset: 0x1906)
// exports ... 10  (offset: 0xff2)
// cseg ...... 0x3b3 + 0xc3f (0xff2)
// imports ... 36  (offset: 0x1182)
// animtree1 . 0   (offset: 0x1906)
// animtree2 . 0   (offset: 0x1906)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;

#namespace test_mp_gametype_arena;

// Namespace test_mp_gametype_arena
// Params 0
// Checksum 0xfd9a599, Offset: 0x3d1
// Size: 0x8, Type: bool
function validate_initial_state()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_mp_gametype_arena
// Params 0
// Checksum 0x7dacdd84, Offset: 0x3e2
// Size: 0x18
function test_cleanup()
{
    setdvar( @"player_sustainammo", 0 );
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_gametype_arena
// Params 0
// Checksum 0xb9fdec1f, Offset: 0x402
// Size: 0x3b6
function start_test()
{
    level.arena.skipendgame = 1;
    level.allowlatecomers = 1;
    level.skipondeadevent = 1;
    player = autotests_utility_player::get_player();
    autotests::push_function( "Wait for countdown to finish" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Wait for countdown to finish", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 30 );
    autotests::pop_function( "Wait for countdown to finish" );
    autotests::test_assert_return( test_result_int );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player found", isdefined( player ), "scripts/autotests/mp/test_mp_gametype_arena.gsc", 31 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    enemy_team_players = utility::callsharedfunc( #"team_utility", #"getenemyplayers", player.team, 1 );
    
    while ( enemy_team_players.size < 3 )
    {
        bot = autotests_utility_bot::function_e4afe0f2cd6331a6();
        var_63a718d91714219d = autotests::function_36ed835262a19e53( "Only " + enemy_team_players.size + " out of 3 players found on enemy team. Spawning bot...", bot, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 39 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Bot is on different team as player", player.team, bot.team, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 40 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        enemy_team_players[ enemy_team_players.size ] = bot;
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "3 players found on enemy team", enemy_team_players.size, 3, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 45 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 1;
    level.skipondeadevent = 0;
    autotests::push_function( "Test team health" );
    test_result_int = function_c183323f5b660b91( player, enemy_team_players ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test team health", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 51 );
    autotests::pop_function( "Test team health" );
    autotests::test_assert_return( test_result_int );
    
    switch ( level.objmodifier )
    {
        case 0:
            autotests::push_function( "Test capturing OT flag" );
            test_result_int = function_1b0fb259a5088d71( player ) ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test capturing OT flag", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 56 );
            autotests::pop_function( "Test capturing OT flag" );
            autotests::test_assert_return( test_result_int );
            break;
        case 1:
            autotests::push_function( "Test capturing endzone flag" );
            test_result_int = function_aaac2e9e6ddaf97( player ) ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test capturing endzone flag", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 60 );
            autotests::pop_function( "Test capturing endzone flag" );
            autotests::test_assert_return( test_result_int );
            autotests::push_function( "Test capturing OT flag" );
            test_result_int = function_1b0fb259a5088d71( player ) ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test capturing OT flag", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 61 );
            autotests::pop_function( "Test capturing OT flag" );
            autotests::test_assert_return( test_result_int );
            break;
        case 2:
            autotests::push_function( "Test taking carry flag" );
            test_result_int = function_b991924ee8716f4e( player ) ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test taking carry flag", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 65 );
            autotests::pop_function( "Test taking carry flag" );
            autotests::test_assert_return( test_result_int );
            break;
    }
    
    level.arena.skipendgame = undefined;
    level.allowlatecomers = 0;
    level.skipondeadevent = 0;
    return 0;
}

// Namespace test_mp_gametype_arena
// Params 1, eflags: 0x4
// Checksum 0x7ec7d7a9, Offset: 0x7c1
// Size: 0x12a
function private function_1b0fb259a5088d71( player )
{
    var_1634357e3928adde = [ "arena_overtime_flag_captured", "capture" ];
    utility::callsharedfunc( #"arena", #"hash_a2c6c6b047059003" );
    player_origin = player.origin;
    var_8b70d8aedcddc58c = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", level.arenaflag );
    player setorigin( var_8b70d8aedcddc58c );
    var_63a718d91714219d = autotests::test_wait_any( "OT flag captured", level.arenaflag, var_1634357e3928adde, level.flagcapturetime + 0.1, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 86 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player setorigin( player_origin );
    utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_d7f5cf7eefee4ed7", level.arenaflag, "none" );
    utility::callsharedfunc( #"arena", #"hash_4b2010a7914e3680" );
    return 0;
}

// Namespace test_mp_gametype_arena
// Params 1, eflags: 0x4
// Checksum 0x798b64b6, Offset: 0x8f4
// Size: 0x129
function private function_aaac2e9e6ddaf97( player )
{
    var_1634357e3928adde = [ "arena_endzone_flag_captured", "capture" ];
    other_team = player.team == "allies" ? "axis" : "allies";
    endzone_flag = level.arena.endzoneflags[ other_team ];
    player_origin = player.origin;
    var_8b70d8aedcddc58c = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", endzone_flag );
    player setorigin( var_8b70d8aedcddc58c );
    var_63a718d91714219d = autotests::test_wait_any( "End zone flag captured", endzone_flag, var_1634357e3928adde, level.flagcapturetime + 0.1, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 106 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player setorigin( player_origin );
    utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_d7f5cf7eefee4ed7", endzone_flag, other_team );
    return 0;
}

// Namespace test_mp_gametype_arena
// Params 1, eflags: 0x4
// Checksum 0xb7dea307, Offset: 0xa26
// Size: 0x246
function private function_b991924ee8716f4e( player )
{
    pickup_notify_strings = [ "arena_carry_flag_picked_up", "picked_up" ];
    hold_timer_notify_strings = [ "arena_carry_flag_hold_time_elapsed", "hold_timer_elapsed" ];
    drop_notify_strings = [ "arena_carry_flag_dropped", "dropped" ];
    return_home_notify_strings = [ "arena_carry_flag_returned_home", "reset_done" ];
    carry_flag = level.arena.carryflag;
    player_origin = player.origin;
    var_8b70d8aedcddc58c = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", carry_flag );
    player setorigin( var_8b70d8aedcddc58c );
    var_63a718d91714219d = autotests::test_wait_any( "Carry flag picked up", carry_flag, pickup_notify_strings, 0.1, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 127 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::test_wait_any( "Carry flag hold timer elapsed", carry_flag, hold_timer_notify_strings, level.flagholdtimer + 0.1, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 128 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player setorigin( player_origin + ( 120, 0, 0 ) );
    wait 1;
    utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"carryobject_force_drop", carry_flag );
    var_63a718d91714219d = autotests::test_wait_any( "Carry flag dropped", carry_flag, drop_notify_strings, 0.1, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 134 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 1;
    return_home_time = utility::callsharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_b20564599f08f013", carry_flag );
    player setorigin( player_origin );
    var_63a718d91714219d = autotests::test_wait_any( "Carry flag returned home", carry_flag, return_home_notify_strings, return_home_time + 0.1, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 141 );
    
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

// Namespace test_mp_gametype_arena
// Params 2, eflags: 0x4
// Checksum 0xd07ad539, Offset: 0xc75
// Size: 0x29c
function private function_c183323f5b660b91( player, enemy_team_players )
{
    var_32ca0645bd36c85a = spawnstruct();
    var_32ca0645bd36c85a.damage_result = 0;
    var_32ca0645bd36c85a.notify_result = 0;
    thread function_9ff112e16e57dd78( var_32ca0645bd36c85a, enemy_team_players[ 0 ].team );
    setdvar( @"player_sustainammo", 1 );
    player_forward = anglestoforward( player getplayerangles() );
    player_test_origin = player.origin + ( 0, 30, 30 ) + player_forward * 90;
    skip_last_player = 0;
    
    foreach ( index, var_cda59cc8b5ebd6c2 in enemy_team_players )
    {
        if ( !skip_last_player || index != enemy_team_players.size - 1 )
        {
            enemy_player_origin = var_cda59cc8b5ebd6c2.origin;
            var_cda59cc8b5ebd6c2 setorigin( player_test_origin );
            wait 1;
            target_angles = vectortoangles( var_cda59cc8b5ebd6c2.origin - player.origin - ( 0, 0, 10 ) );
            player setplayerangles( target_angles );
            player startforcedfire();
            damage_result = var_cda59cc8b5ebd6c2 utility::waittill_any_timeout( 0.1, "damage", "death" );
            player stopforcedfire();
            var_cda59cc8b5ebd6c2 setorigin( enemy_player_origin );
            var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Enemy player damaged", damage_result == "damage" || damage_result == "death", "scripts/autotests/mp/test_mp_gametype_arena.gsc", 178 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            skip_last_player |= damage_result == "death";
        }
        
        var_32ca0645bd36c85a.damage_result += var_cda59cc8b5ebd6c2.health;
        waitframe();
    }
    
    setdvar( @"player_sustainammo", 0 );
    level notify( #"hash_f2bd390bbb440f1c" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Team health correctly updated", var_32ca0645bd36c85a.damage_result, var_32ca0645bd36c85a.notify_result, "scripts/autotests/mp/test_mp_gametype_arena.gsc", 191 );
    
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

// Namespace test_mp_gametype_arena
// Params 2, eflags: 0xc
// Checksum 0xa4b15b4f, Offset: 0xf1a
// Size: 0x87
function private function_9ff112e16e57dd78( var_32ca0645bd36c85a, team_name )
{
    self notify( #"hash_ef0a43d7411457e6" );
    self endon( #"hash_ef0a43d7411457e6" );
    level endon( #"test_finished" );
    level endon( #"hash_f2bd390bbb440f1c" );
    
    while ( true )
    {
        result = function_5788830cf9762ec7();
        
        if ( result.team_name == team_name )
        {
            var_32ca0645bd36c85a.notify_result = result.health;
        }
    }
}

// Namespace test_mp_gametype_arena
// Params 0, eflags: 0x4
// Checksum 0x1c64a944, Offset: 0xfa9
// Size: 0x48
function private function_5788830cf9762ec7()
{
    level endon( #"test_finished" );
    level waittill( #"hash_38603932c3d6f61b", team_name, health );
    return { #health:health, #team_name:team_name };
}

