// scripts\autotests\mp\test_mp_serverac.gsc  (hash_1ae4159a8ebd0203.gscc) (size: 3238 Bytes / 0xca6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab2e85d1 (2871952849)
// size ...... 3238 (0xca6)
// includes .. 4   (offset: 0xa82)
// strings ... 38  (offset: 0xaa2)
// dev strs .. 0   (offset: 0xca6)
// exports ... 8   (offset: 0x6ee)
// cseg ...... 0x2f1 + 0x3fd (0x6ee)
// imports ... 19  (offset: 0x82e)
// animtree1 . 0   (offset: 0xca6)
// animtree2 . 0   (offset: 0xca6)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\serverac\autotests_utility_serverac;

#namespace test_mp_serverac;

// Namespace test_mp_serverac/testautomation
// Params 0, eflags: 0x20
// Checksum 0x4011aa68, Offset: 0x30f
// Size: 0x25
function event_handler[testautomation] main()
{
    autotests::register_test( #"hash_96990858eee2c91d", #"test", &function_42cd59071d9b50ed, &validate_initial_state );
}

// Namespace test_mp_serverac
// Params 0
// Checksum 0x6f24d18c, Offset: 0x33c
// Size: 0x8, Type: bool
function validate_initial_state()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_mp_serverac
// Params 0
// Checksum 0x31a6a03b, Offset: 0x34d
// Size: 0x1cd, Type: bool
function function_42cd59071d9b50ed()
{
    autotests::set_dvar( @"hash_9e49766c62b3af0d", 600 );
    autotests::push_function( "Test setup" );
    test_result_int = autotests_utility_serverac::test_setup() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test setup", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_serverac.gsc", 30 );
    autotests::pop_function( "Test setup" );
    autotests::test_assert_return( test_result_int );
    testplayers = level.autotests.test_runtime.testplayers;
    player = autotests_utility_player::get_player();
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_serverac.gsc", 33 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    wait 1;
    autotests::push_function( "Weapon Fire Damage Mitigate" );
    test_result_int = autotests_utility_serverac::function_a4e48481317ca099( testplayers ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Weapon Fire Damage Mitigate", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_serverac.gsc", 37 );
    autotests::pop_function( "Weapon Fire Damage Mitigate" );
    autotests::test_assert_return( test_result_int );
    wait 1;
    autotests::push_function( "Lethal Damage Mitigate" );
    test_result_int = autotests_utility_serverac::function_e17c9be06527a2bc( testplayers ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Lethal Damage Mitigate", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_serverac.gsc", 41 );
    autotests::pop_function( "Lethal Damage Mitigate" );
    autotests::test_assert_return( test_result_int );
    wait 1;
    autotests::push_function( "Killstreak Damage Mitigate" );
    test_result_int = autotests_utility_serverac::function_bbcca9e23639037c( testplayers, function_dc5daf40a8b8fe60(), function_538c0c0b13258ef3() ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Killstreak Damage Mitigate", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_serverac.gsc", 45 );
    autotests::pop_function( "Killstreak Damage Mitigate" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_mp_serverac
// Params 0, eflags: 0x4
// Checksum 0xcfa6cf60, Offset: 0x523
// Size: 0xae
function private function_dc5daf40a8b8fe60()
{
    return [ "uav", "airdrop", "airdrop_escort", "directional_uav", "counter_uav", "radar_ping", "emp_blast", "auto_drone", "missile_turret", "gunship", "hellstorm_missile", "napalm_strike", "rcxd", "air_patrol", "dawg", "sniper_drone", "remote_robot", "vtol_warship", "radiation_blast" ];
}

// Namespace test_mp_serverac
// Params 0, eflags: 0x4
// Checksum 0xc2818378, Offset: 0x5da
// Size: 0x6f
function private function_538c0c0b13258ef3()
{
    return [ "toma_strike", "valkyrie_rocket", "remote_turret", "hand_cannon", "ground_drone_unit", "sniper_briefcase", "skewer", "war_machine_launcher", "death_machine_gun", "m202_launcher", "combat_bow", "smart_gun" ];
}

// Namespace test_mp_serverac
// Params 0
// Checksum 0xcddc7cdb, Offset: 0x652
// Size: 0x76, Type: bool
function check_winner()
{
    level endon( #"test_timedout" );
    player2 = level.autotests.test_runtime.player2;
    thread function_a16614c4aa918090();
    level waittill( #"team_won", winner );
    autotests::function_e50d1006e5d65c04( "Winner check", player2.team, winner, "scripts/autotests/mp/test_mp_serverac.gsc", 121 );
    return false;
}

// Namespace test_mp_serverac
// Params 0
// Checksum 0x88617d12, Offset: 0x6d1
// Size: 0x1d
function function_a16614c4aa918090()
{
    level endon( #"team_won" );
    wait 5;
    level notify( #"test_timedout" );
}

