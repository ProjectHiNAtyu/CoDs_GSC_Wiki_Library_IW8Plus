// scripts\autotests\mp\test_mp_gametype.gsc  (hash_430c239f8f7ddd2a.gscc) (size: 2780 Bytes / 0xadc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd9bf9643 (3653211715)
// size ...... 2780 (0xadc)
// includes .. 8   (offset: 0x9e8)
// strings ... 8   (offset: 0xa28)
// dev strs .. 0   (offset: 0xadc)
// exports ... 5   (offset: 0x594)
// cseg ...... 0x15e + 0x436 (0x594)
// imports ... 29  (offset: 0x65c)
// animtree1 . 0   (offset: 0xadc)
// animtree2 . 0   (offset: 0xadc)
#using scripts\autotests\autotests;
#using scripts\autotests\mp\test_mp_gametype_arena;
#using scripts\autotests\mp\test_mp_gametype_dom;
#using scripts\autotests\mp\test_mp_gametype_flags_of_war;
#using scripts\autotests\mp\test_mp_gametype_koth;
#using scripts\autotests\mp\test_mp_gametype_push_zone;
#using scripts\autotests\mp\test_mp_gametype_sd;
#using scripts\autotests\mp\test_mp_gametype_war;

#namespace test_mp_gametype;

// Namespace test_mp_gametype/testautomation
// Params 0, eflags: 0x20
// Checksum 0xc9958547, Offset: 0x17c
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_gametype.gsc", #"GP", &start_test, &setup, &test_cleanup );
}

// Namespace test_mp_gametype
// Params 0
// Checksum 0xb5116f49, Offset: 0x1aa
// Size: 0xb8
function setup()
{
    if ( !isdefined( level.gametype ) )
    {
        return 0;
    }
    
    switch ( level.gametype )
    {
        case #"hash_5ff8e011d5b9d1c8":
            return test_mp_gametype_arena::validate_initial_state();
        case #"hash_f4a9126c03d3385b":
            return test_mp_gametype_dom::validate_initial_state();
        case #"hash_3c73ee732772c519":
            return test_mp_gametype_flags_of_war::validate_initial_state();
        case #"hash_6efb0f59a62300fb":
            return test_mp_gametype_koth::validate_initial_state();
        case #"hash_d62e8de2ff636388":
            return test_mp_gametype_push_zone::validate_initial_state();
        case #"hash_fa50b0f6bd82e972":
            return test_mp_gametype_sd::validate_initial_state();
        case #"hash_7485fa6c474ec865":
            return test_mp_gametype_war::validate_initial_state();
        default:
            break;
    }
    
    return 0;
}

// Namespace test_mp_gametype
// Params 0
// Checksum 0x7982617c, Offset: 0x26b
// Size: 0xa7
function test_cleanup()
{
    switch ( level.gametype )
    {
        case #"hash_5ff8e011d5b9d1c8":
            return test_mp_gametype_arena::test_cleanup();
        case #"hash_f4a9126c03d3385b":
            return test_mp_gametype_dom::test_cleanup();
        case #"hash_3c73ee732772c519":
            return test_mp_gametype_flags_of_war::test_cleanup();
        case #"hash_6efb0f59a62300fb":
            return test_mp_gametype_koth::test_cleanup();
        case #"hash_d62e8de2ff636388":
            return test_mp_gametype_push_zone::test_cleanup();
        case #"hash_fa50b0f6bd82e972":
            return test_mp_gametype_sd::test_cleanup();
        case #"hash_7485fa6c474ec865":
            return test_mp_gametype_war::test_cleanup();
        default:
            break;
    }
}

// Namespace test_mp_gametype
// Params 0
// Checksum 0xef1fcf79, Offset: 0x31a
// Size: 0x279, Type: bool
function start_test()
{
    switch ( level.gametype )
    {
        case #"hash_5ff8e011d5b9d1c8":
            autotests::push_function( "Test gunfight" );
            test_result_int = test_mp_gametype_arena::start_test() ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test gunfight", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype.gsc", 75 );
            autotests::pop_function( "Test gunfight" );
            autotests::test_assert_return( test_result_int );
            break;
        case #"hash_f4a9126c03d3385b":
            autotests::push_function( "Test domination" );
            test_result_int = test_mp_gametype_dom::start_test() ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test domination", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype.gsc", 78 );
            autotests::pop_function( "Test domination" );
            autotests::test_assert_return( test_result_int );
            break;
        case #"hash_3c73ee732772c519":
            autotests::push_function( "Test flags of war" );
            test_result_int = test_mp_gametype_flags_of_war::start_test() ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test flags of war", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype.gsc", 81 );
            autotests::pop_function( "Test flags of war" );
            autotests::test_assert_return( test_result_int );
            break;
        case #"hash_6efb0f59a62300fb":
            autotests::push_function( "Test king of the hill" );
            test_result_int = test_mp_gametype_koth::start_test() ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test king of the hill", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype.gsc", 84 );
            autotests::pop_function( "Test king of the hill" );
            autotests::test_assert_return( test_result_int );
            break;
        case #"hash_d62e8de2ff636388":
            autotests::push_function( "Test push zone" );
            test_result_int = test_mp_gametype_push_zone::start_test() ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test push zone", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype.gsc", 87 );
            autotests::pop_function( "Test push zone" );
            autotests::test_assert_return( test_result_int );
            break;
        case #"hash_fa50b0f6bd82e972":
            autotests::push_function( "Test search and destroy" );
            test_result_int = test_mp_gametype_sd::start_test() ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test search and destroy", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype.gsc", 90 );
            autotests::pop_function( "Test search and destroy" );
            autotests::test_assert_return( test_result_int );
            break;
        case #"hash_7485fa6c474ec865":
            autotests::push_function( "Test team deathmatch" );
            test_result_int = test_mp_gametype_war::start_test() ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Test team deathmatch", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype.gsc", 93 );
            autotests::pop_function( "Test team deathmatch" );
            autotests::test_assert_return( test_result_int );
            break;
        default:
            return true;
    }
    
    return false;
}

