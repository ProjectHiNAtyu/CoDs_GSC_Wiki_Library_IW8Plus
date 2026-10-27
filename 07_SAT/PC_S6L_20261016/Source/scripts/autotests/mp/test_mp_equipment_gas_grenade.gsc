// scripts\autotests\mp\test_mp_equipment_gas_grenade.gsc  (hash_04a757eb43af7fc1.gscc) (size: 3438 Bytes / 0xd6e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x56e9c6ff (1458161407)
// size ...... 3438 (0xd6e)
// includes .. 6   (offset: 0xc8e)
// strings ... 9   (offset: 0xcbe)
// dev strs .. 0   (offset: 0xd6e)
// exports ... 12  (offset: 0x6a6)
// cseg ...... 0x1b1 + 0x4f5 (0x6a6)
// imports ... 33  (offset: 0x886)
// animtree1 . 0   (offset: 0xd6e)
// animtree2 . 0   (offset: 0xd6e)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_agents;
#using scripts\autotests\mp\autotests_utility_equipment;
#using scripts\common\utility;
#using scripts\mp\common\equipment\gas_grenade;

#namespace test_mp_equipment_gas_grenade;

// Namespace test_mp_equipment_gas_grenade/testautomation
// Params 0, eflags: 0x20
// Checksum 0xf3bcd975, Offset: 0x1cf
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_equipment_gas_grenade.gsc", #"test", &start_test, &setup_test_suite, &cleanup_test_suite );
}

// Namespace test_mp_equipment_gas_grenade
// Params 0
// Checksum 0x9762d4b8, Offset: 0x1fd
// Size: 0xee
function start_test()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player found?", player, "scripts/autotests/mp/test_mp_equipment_gas_grenade.gsc", 22 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 0.1;
    autotests::push_function( "Test gas grenade brainrots agent" );
    test_result_int = function_7bad775f37a6d332( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test gas grenade brainrots agent", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_equipment_gas_grenade.gsc", 26 );
    autotests::pop_function( "Test gas grenade brainrots agent" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test gas grenade assigns turning player" );
    test_result_int = function_b0a1e54e615b2e32( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test gas grenade assigns turning player", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_equipment_gas_grenade.gsc", 27 );
    autotests::pop_function( "Test gas grenade assigns turning player" );
    autotests::test_assert_return( test_result_int );
    return 0;
}

// Namespace test_mp_equipment_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x5e20eabe, Offset: 0x2f4
// Size: 0x27
function private setup_test_suite()
{
    if ( !autotests_utility_equipment::function_431f880b3bd252a2( "equip_gas_grenade" ) )
    {
        return 0;
    }
    
    setup_brainrot_probability();
    autotests::function_5c8c87763724c132();
    return autotests_utility_agents::setup();
}

// Namespace test_mp_equipment_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x8fa23b3a, Offset: 0x324
// Size: 0x17
function private cleanup_test_suite()
{
    cleanup_brainrot_probability();
    cleanup_gas_grenades();
    autotests_utility_agents::function_822b5642b4c4993d();
}

// Namespace test_mp_equipment_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x601fa84a, Offset: 0x343
// Size: 0x10
function private cleanup_single_test()
{
    cleanup_gas_grenades();
    autotests_utility_agents::function_822b5642b4c4993d();
}

// Namespace test_mp_equipment_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0x2349f1e9, Offset: 0x35b
// Size: 0xe2
function private function_7bad775f37a6d332( player )
{
    enemy_agent = autotests_utility_agents::spawn_ai( player );
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Is agent not experiencing brainrot?", enemy_agent utility::callsharedfunc( #"zombie_utils", #"hash_ed46e37d3efd53d3" ), "scripts/autotests/mp/test_mp_equipment_gas_grenade.gsc", 63 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_equipment::function_985cc981faf48b19( "equip_gas_grenade", enemy_agent.origin, player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Is agent experiencing brainrot?", enemy_agent utility::callsharedfunc( #"zombie_utils", #"hash_ed46e37d3efd53d3" ), "scripts/autotests/mp/test_mp_equipment_gas_grenade.gsc", 67 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_single_test();
}

// Namespace test_mp_equipment_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0xdb02c6b6, Offset: 0x445
// Size: 0xc7
function private function_b0a1e54e615b2e32( player )
{
    enemy_agent = autotests_utility_agents::spawn_ai( player );
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Does agent not have a turning player assigned?", enemy_agent.var_fb2e0070ae6f04e4, "scripts/autotests/mp/test_mp_equipment_gas_grenade.gsc", 76 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_equipment::function_985cc981faf48b19( "equip_gas_grenade", enemy_agent.origin, player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Does agent have a turning player assigned?", enemy_agent.var_fb2e0070ae6f04e4 == player, "scripts/autotests/mp/test_mp_equipment_gas_grenade.gsc", 80 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_single_test();
}

// Namespace test_mp_equipment_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x86f57e2e, Offset: 0x514
// Size: 0x5c
function private setup_brainrot_probability()
{
    var_c0e0101cfb2c733b = utility::getsharedfunc( "equip_gas_grenade", #"hash_fd15fd23829c9df7" );
    level.autotests.test_runtime.var_c0e0101cfb2c733b = var_c0e0101cfb2c733b;
    utility::registersharedfunc( "equip_gas_grenade", #"hash_fd15fd23829c9df7", &function_591ddbb78df6d17b );
}

// Namespace test_mp_equipment_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0xa010c7d2, Offset: 0x578
// Size: 0x9d
function private cleanup_gas_grenades()
{
    player = autotests_utility_player::get_player();
    
    if ( !player )
    {
        return;
    }
    
    foreach ( trigger in player.gas_grenade_array )
    {
        if ( !trigger )
        {
            continue;
        }
        
        trigger gas_grenade::gas_destroytrigger();
    }
}

// Namespace test_mp_equipment_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x334638e0, Offset: 0x61d
// Size: 0x7c
function private cleanup_brainrot_probability()
{
    var_c0e0101cfb2c733b = level.autotests.test_runtime.var_c0e0101cfb2c733b;
    
    if ( var_c0e0101cfb2c733b )
    {
        utility::registersharedfunc( "equip_gas_grenade", #"hash_fd15fd23829c9df7", var_c0e0101cfb2c733b );
    }
    else
    {
        utility::clearsharedfunc( "equip_gas_grenade", #"hash_fd15fd23829c9df7" );
    }
    
    level.autotests.test_runtime.var_c0e0101cfb2c733b = undefined;
}

// Namespace test_mp_equipment_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x771c192b, Offset: 0x6a1
// Size: 0x4, Type: bool
function private function_591ddbb78df6d17b()
{
    return true;
}

