// scripts\autotests\mp\test_mp_gametype_cranked.gsc  (hash_6c92dafafd463707.gscc) (size: 23704 Bytes / 0x5c98 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfcde6e43 (4242435651)
// size ...... 23704 (0x5c98)
// includes .. 6   (offset: 0x55d8)
// strings ... 81  (offset: 0x5608)
// dev strs .. 0   (offset: 0x5c98)
// exports ... 58  (offset: 0x3c64)
// cseg ...... 0xcbc + 0x2fa8 (0x3c64)
// imports ... 85  (offset: 0x4574)
// animtree1 . 0   (offset: 0x5c98)
// animtree2 . 0   (offset: 0x5c98)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\callbacks;
#using scripts\mp\cranked;

#namespace test_mp_gametype_cranked;

// Namespace test_mp_gametype_cranked/testautomation
// Params 0, eflags: 0x20
// Checksum 0x3d902f2d, Offset: 0xcda
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_gametype_cranked.gsc", #"test", &start_test, &setup_test_suite, &cleanup_test_suite );
}

// Namespace test_mp_gametype_cranked
// Params 0
// Checksum 0xcdf1ea4e, Offset: 0xd08
// Size: 0x1ad, Type: bool
function setup_test_suite()
{
    autotests::function_5c8c87763724c132();
    level.autotests.test_runtime.var_ed68ea8f15ad393d = level.gametypebundle.var_8c1555a38733ae78;
    level.autotests.test_runtime.var_f87a89a5ade902d8 = level.gametypebundle.var_1a770d7bb00956e0;
    level.autotests.test_runtime.var_5dc833d2c7e5cf87 = level.gametypebundle.var_1771bb45f0bd76e8;
    level.autotests.test_runtime.var_34848ba8e897199d = level.gametypebundle.var_bba4da52eaf1ff50;
    level.autotests.test_runtime.var_33b564dc3a95d048 = level.gametypebundle.var_45cb4433e870ec92;
    level.autotests.test_runtime.var_2c1db14395a321c2 = level.gametypebundle.var_44f713a56ca0cb5e;
    level.autotests.test_runtime.var_2e432860d5dc9f4c = level.gametypebundle.var_f411bb185a8c306b;
    level.autotests.test_runtime.var_c79600d30676f618 = level.matchmakingmatch;
    
    if ( level.crankedbombtimer <= 0 )
    {
        return false;
    }
    
    return level.gametypebundle.awardtiers.size > 0;
}

// Namespace test_mp_gametype_cranked
// Params 0
// Checksum 0x6dd96cc2, Offset: 0xebe
// Size: 0xf1
function cleanup_test_suite()
{
    cleanup_individual_test();
    level.autotests.test_runtime.var_ed68ea8f15ad393d = undefined;
    level.autotests.test_runtime.var_f87a89a5ade902d8 = undefined;
    level.autotests.test_runtime.var_5dc833d2c7e5cf87 = undefined;
    level.autotests.test_runtime.var_34848ba8e897199d = undefined;
    level.autotests.test_runtime.var_33b564dc3a95d048 = undefined;
    level.autotests.test_runtime.var_2c1db14395a321c2 = undefined;
    level.autotests.test_runtime.var_2e432860d5dc9f4c = undefined;
    level.autotests.test_runtime.var_c79600d30676f618 = undefined;
}

// Namespace test_mp_gametype_cranked
// Params 0
// Checksum 0xac07cfd, Offset: 0xfb7
// Size: 0x1cd
function cleanup_individual_test()
{
    level.gametypebundle.var_8c1555a38733ae78 = level.autotests.test_runtime.var_ed68ea8f15ad393d;
    level.gametypebundle.var_bba4da52eaf1ff50 = level.autotests.test_runtime.var_34848ba8e897199d;
    level.gametypebundle.var_1a770d7bb00956e0 = level.autotests.test_runtime.var_f87a89a5ade902d8;
    level.gametypebundle.var_1771bb45f0bd76e8 = level.autotests.test_runtime.var_5dc833d2c7e5cf87;
    level.gametypebundle.var_45cb4433e870ec92 = level.autotests.test_runtime.var_33b564dc3a95d048;
    level.gametypebundle.var_44f713a56ca0cb5e = level.autotests.test_runtime.var_2c1db14395a321c2;
    level.gametypebundle.var_f411bb185a8c306b = level.autotests.test_runtime.var_2e432860d5dc9f4c;
    level.matchmakingmatch = level.autotests.test_runtime.var_c79600d30676f618;
    
    if ( !level.gametypebundle.var_1a770d7bb00956e0 )
    {
        callback::remove( #"hash_d4bbb4278ed1fcab", &cranked::oncrankedhit );
    }
    
    player = autotests_utility_player::get_player();
    player cranked::cleanupcrankedplayertimer();
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_gametype_cranked
// Params 0
// Checksum 0x5818b0a8, Offset: 0x118c
// Size: 0x93b
function start_test()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player found", isdefined( player ), "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 84 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 86 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bot kill starts cranked" );
    test_result_int = function_e7597ea06198b116( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bot kill starts cranked", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 89 );
    autotests::pop_function( "Test bot kill starts cranked" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bot kill initializes cranked kills to zero" );
    test_result_int = function_40ee81bd1188eed3( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bot kill initializes cranked kills to zero", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 90 );
    autotests::pop_function( "Test bot kill initializes cranked kills to zero" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bot kill initializes cranked timer" );
    test_result_int = function_cad0930b2b092b6a( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bot kill initializes cranked timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 91 );
    autotests::pop_function( "Test bot kill initializes cranked timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bot kill increases cranked kills" );
    test_result_int = function_9f9b2c892f5ced80( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bot kill increases cranked kills", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 92 );
    autotests::pop_function( "Test bot kill increases cranked kills" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bot kill starts cranked and fills timer" );
    test_result_int = function_188a76419ec1147c( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bot kill starts cranked and fills timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 93 );
    autotests::pop_function( "Test bot kill starts cranked and fills timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bot kill increases by elim tunable" );
    test_result_int = function_b834164889384c28( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bot kill increases by elim tunable", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 94 );
    autotests::pop_function( "Test bot kill increases by elim tunable" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test on cranked grants award" );
    test_result_int = function_7d092516d88dd9f9( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test on cranked grants award", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 97 );
    autotests::pop_function( "Test on cranked grants award" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test remove cranked removes awards" );
    test_result_int = function_d0274c5819fb7851( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test remove cranked removes awards", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 98 );
    autotests::pop_function( "Test remove cranked removes awards" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test remove cranked removes multiple awards" );
    test_result_int = function_d2a2f491d111a434( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test remove cranked removes multiple awards", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 99 );
    autotests::pop_function( "Test remove cranked removes multiple awards" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bot hit increases by hit tunable" );
    test_result_int = function_247c0e43f74d9e6f( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bot hit increases by hit tunable", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 102 );
    autotests::pop_function( "Test bot hit increases by hit tunable" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test on zone entry starts cranked" );
    test_result_int = function_43a8a0931d4346be( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test on zone entry starts cranked", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 105 );
    autotests::pop_function( "Test on zone entry starts cranked" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test on zone entry grants assist if cranked" );
    test_result_int = function_18e8f304ee56994b( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test on zone entry grants assist if cranked", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 106 );
    autotests::pop_function( "Test on zone entry grants assist if cranked" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test on zone entry pauses cranked timer" );
    test_result_int = function_e1edf9e7c4ddd48( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test on zone entry pauses cranked timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 107 );
    autotests::pop_function( "Test on zone entry pauses cranked timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test on zone exit unpauses cranked timer" );
    test_result_int = function_b9c9470baddadead( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test on zone exit unpauses cranked timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 108 );
    autotests::pop_function( "Test on zone exit unpauses cranked timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test on zone moved unpauses cranked timer" );
    test_result_int = function_25c9ba6fbd12de90( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test on zone moved unpauses cranked timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 109 );
    autotests::pop_function( "Test on zone moved unpauses cranked timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test friendly dog tag pickup starts cranked" );
    test_result_int = function_87d94a4896c4406c( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test friendly dog tag pickup starts cranked", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 112 );
    autotests::pop_function( "Test friendly dog tag pickup starts cranked" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test friendly dog tag pickup increases timer" );
    test_result_int = function_9ae50b69a823b06e( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test friendly dog tag pickup increases timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 113 );
    autotests::pop_function( "Test friendly dog tag pickup increases timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test enemy dog tag pickup starts cranked" );
    test_result_int = function_ff4e150e9432eb21( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test enemy dog tag pickup starts cranked", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 114 );
    autotests::pop_function( "Test enemy dog tag pickup starts cranked" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test enemy dog tag pickup increases timer" );
    test_result_int = function_207f49d0f13427d3( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test enemy dog tag pickup increases timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 115 );
    autotests::pop_function( "Test enemy dog tag pickup increases timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test grind tag pickup starts cranked" );
    test_result_int = function_f7adcad7ece734e( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test grind tag pickup starts cranked", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 118 );
    autotests::pop_function( "Test grind tag pickup starts cranked" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test grind tag pickup increases timer" );
    test_result_int = function_c35d0637670246f8( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test grind tag pickup increases timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 119 );
    autotests::pop_function( "Test grind tag pickup increases timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test grind tag dropoff increases timer" );
    test_result_int = function_97412f2660224724( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test grind tag dropoff increases timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 120 );
    autotests::pop_function( "Test grind tag dropoff increases timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test score override when agent scores" );
    test_result_int = function_a229dfbf61dfdf82( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test score override when agent scores", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 123 );
    autotests::pop_function( "Test score override when agent scores" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test score override disabled when agent scores" );
    test_result_int = function_1c91c4e6966e7409( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test score override disabled when agent scores", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 124 );
    autotests::pop_function( "Test score override disabled when agent scores" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test score override when agent death" );
    test_result_int = function_87cec2882baa5809( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test score override when agent death", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 125 );
    autotests::pop_function( "Test score override when agent death" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test score override disabled when agent death" );
    test_result_int = function_a84051d0dc83ad20( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test score override disabled when agent death", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 126 );
    autotests::pop_function( "Test score override disabled when agent death" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bomb interact starts cranked" );
    test_result_int = function_40ae8d2f00aea7f3( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bomb interact starts cranked", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 129 );
    autotests::pop_function( "Test bomb interact starts cranked" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bomb interact fills timer" );
    test_result_int = function_23635151ed95b77( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bomb interact fills timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 130 );
    autotests::pop_function( "Test bomb interact fills timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bomb interact pauses timer" );
    test_result_int = function_5de7f2896b58eaae( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bomb interact pauses timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 131 );
    autotests::pop_function( "Test bomb interact pauses timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bomb interact end unpauses timer" );
    test_result_int = function_57bfd0a37778159b( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bomb interact end unpauses timer", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 132 );
    autotests::pop_function( "Test bomb interact end unpauses timer" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Test bomb interact success grants all awards" );
    test_result_int = function_702ff6a5fdc50fff( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Test bomb interact success grants all awards", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 133 );
    autotests::pop_function( "Test bomb interact success grants all awards" );
    autotests::test_assert_return( test_result_int );
    return 0;
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x8b252717, Offset: 0x1ad0
// Size: 0xa2
function private function_e7597ea06198b116( player )
{
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player not cranked before kill?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 140 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_9e40e78b823d078e( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player cranked after kill?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 144 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x276d4450, Offset: 0x1b7a
// Size: 0xa4
function private function_40ee81bd1188eed3( player )
{
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player has no cranked kills before kill?", player.crankedkills, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 151 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_9e40e78b823d078e( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has cranked kills after kill?", player.crankedkills == 0, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 155 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xde8fe8fb, Offset: 0x1c26
// Size: 0xab
function private function_9f9b2c892f5ced80( player )
{
    function_9e40e78b823d078e( player );
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player has no cranked kills before kill?", player.crankedkills, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 164 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_72f86eb3c61b728d( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has cranked kills after kill?", player.crankedkills, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 168 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x99e63474, Offset: 0x1cd9
// Size: 0xab
function private function_7d092516d88dd9f9( player )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "gametype bundle has awardTiers specified?", level.gametypebundle.awardtiers[ 0 ], "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 175 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player function_fbda2195f7d243b9( level.gametypebundle.awardtiers[ 0 ], 0 );
    function_9e40e78b823d078e( player );
    player function_fbda2195f7d243b9( level.gametypebundle.awardtiers[ 0 ] );
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xb1e880ac, Offset: 0x1d8c
// Size: 0xa9
function private function_cad0930b2b092b6a( player )
{
    function_bb9724c11a0c2578();
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player does not have timer before cranked?", player.cranked_end_time, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 190 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_9e40e78b823d078e( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has timer after kill?", player.cranked_end_time, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 194 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xd4424d28, Offset: 0x1e3d
// Size: 0xd9
function private function_188a76419ec1147c( player )
{
    function_bb9724c11a0c2578();
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player does not have timer before cranked?", player.cranked_end_time, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 203 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_9e40e78b823d078e( player );
    kill_time = gettime();
    timer_amount = get_timer_amount( #"full" ) * 1000;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has correct timer after kill?", player.cranked_end_time == kill_time + timer_amount, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 210 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x32c3201e, Offset: 0x1f1e
// Size: 0x6b
function private function_b834164889384c28( player )
{
    function_17d4190b273dae57();
    function_9e40e78b823d078e( player );
    var_a0981dfd4eca6cd9 = player.cranked_end_time;
    function_72f86eb3c61b728d( player );
    var_8280ed7eff22cc08 = player.cranked_end_time;
    function_ae516131ffc86172( var_8280ed7eff22cc08, var_a0981dfd4eca6cd9, #"kill" );
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xb8bbb700, Offset: 0x1f91
// Size: 0x7b
function private function_d0274c5819fb7851( player )
{
    function_9e40e78b823d078e( player );
    award_tier = player.crankedkills;
    player function_fbda2195f7d243b9( level.gametypebundle.awardtiers[ award_tier ] );
    player cranked::cleanupcrankedplayertimer();
    player function_fbda2195f7d243b9( level.gametypebundle.awardtiers[ award_tier ], 0 );
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x3c23a1e2, Offset: 0x2014
// Size: 0x10f
function private function_d2a2f491d111a434( player )
{
    function_9e40e78b823d078e( player );
    function_72f86eb3c61b728d( player );
    function_72f86eb3c61b728d( player );
    function_72f86eb3c61b728d( player );
    function_72f86eb3c61b728d( player );
    function_72f86eb3c61b728d( player );
    award_tier = player.crankedkills;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Is award tier greater than zero?", award_tier > 0, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 259 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    while ( award_tier >= 0 )
    {
        player function_fbda2195f7d243b9( level.gametypebundle.awardtiers[ award_tier ] );
        award_tier--;
    }
    
    award_tier = player.crankedkills;
    player cranked::cleanupcrankedplayertimer();
    
    while ( award_tier >= 0 )
    {
        player function_fbda2195f7d243b9( level.gametypebundle.awardtiers[ award_tier ], 0 );
        award_tier--;
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x637b5108, Offset: 0x212b
// Size: 0x6b
function private function_247c0e43f74d9e6f( player )
{
    function_68e9e872a42911c1();
    function_9e40e78b823d078e( player );
    var_e4d5f6728ce1a3ea = player.cranked_end_time;
    hit_bot( player );
    var_a2badfcc4401eaed = player.cranked_end_time;
    function_ae516131ffc86172( var_a2badfcc4401eaed, var_e4d5f6728ce1a3ea, #"hit" );
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x5f8b827f, Offset: 0x219e
// Size: 0xa4
function private function_43a8a0931d4346be( player )
{
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player not cranked before zone entry?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 299 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    enter_zone( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player cranked after zone entry?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 303 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xbd0091fe, Offset: 0x224a
// Size: 0x7d
function private function_18e8f304ee56994b( player )
{
    level.gametypebundle.var_bba4da52eaf1ff50 = 0.5;
    function_9e40e78b823d078e( player );
    var_151ea13df2d5f56c = player.cranked_end_time;
    enter_zone( player );
    var_ae21d20c2a48f26d = player.cranked_end_time;
    function_ae516131ffc86172( var_ae21d20c2a48f26d, var_151ea13df2d5f56c, #"assist" );
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x3f0271f9, Offset: 0x22cf
// Size: 0xa4
function private function_e1edf9e7c4ddd48( player )
{
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Timer not paused before zone entry?", player.var_809ce60fdffd0fab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 327 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    enter_zone( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Timer not paused after zone entry?", player.var_809ce60fdffd0fab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 331 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xc67cf447, Offset: 0x237b
// Size: 0xad
function private function_b9c9470baddadead( player )
{
    enter_zone( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Timer is paused after zone entry?", player.var_809ce60fdffd0fab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 340 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    exit_zone( player );
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Timer is unpaused after zone exit?", player.var_809ce60fdffd0fab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 344 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xa290fda2, Offset: 0x2430
// Size: 0xb1
function private function_25c9ba6fbd12de90( player )
{
    enter_zone( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Timer is paused after zone entry?", player.var_809ce60fdffd0fab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 353 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level notify( #"zone_moved" );
    waitframe();
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Timer is unpaused after zone moved?", player.var_809ce60fdffd0fab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 359 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x1183f8d6, Offset: 0x24e9
// Size: 0xa4
function private function_87d94a4896c4406c( player )
{
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player not cranked before friendly dog tag pickup?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 366 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_4862cf17037cc9f6( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player cranked after friendly dog tag pickup?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 370 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x21c59434, Offset: 0x2595
// Size: 0x7d
function private function_9ae50b69a823b06e( player )
{
    level.gametypebundle.var_45cb4433e870ec92 = 0.5;
    function_9e40e78b823d078e( player );
    var_65681db39433ce25 = player.cranked_end_time;
    function_4862cf17037cc9f6( player );
    var_309d69bda12dcd84 = player.cranked_end_time;
    function_ae516131ffc86172( var_309d69bda12dcd84, var_65681db39433ce25, #"friendly_tag" );
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xf1642375, Offset: 0x261a
// Size: 0xa4
function private function_ff4e150e9432eb21( player )
{
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player not cranked before enemy dog tag pickup?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 394 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_b1a77262017e5857( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player cranked after enemy dog tag pickup?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 398 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xe16afe9a, Offset: 0x26c6
// Size: 0x6b
function private function_207f49d0f13427d3( player )
{
    function_17d4190b273dae57();
    function_9e40e78b823d078e( player );
    var_65681db39433ce25 = player.cranked_end_time;
    function_b1a77262017e5857( player );
    var_309d69bda12dcd84 = player.cranked_end_time;
    function_ae516131ffc86172( var_309d69bda12dcd84, var_65681db39433ce25, #"kill" );
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xef053692, Offset: 0x2739
// Size: 0xa4
function private function_f7adcad7ece734e( player )
{
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player not cranked before grind tag pickup?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 422 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_62a17920130c60b0( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player cranked after grind tag pickup?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 426 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xfc8244e2, Offset: 0x27e5
// Size: 0x6b
function private function_c35d0637670246f8( player )
{
    function_17d4190b273dae57();
    function_9e40e78b823d078e( player );
    var_65681db39433ce25 = player.cranked_end_time;
    function_62a17920130c60b0( player );
    var_309d69bda12dcd84 = player.cranked_end_time;
    function_ae516131ffc86172( var_309d69bda12dcd84, var_65681db39433ce25, #"kill" );
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xb0d9707f, Offset: 0x2858
// Size: 0x6b
function private function_97412f2660224724( player )
{
    function_17d4190b273dae57();
    function_9e40e78b823d078e( player );
    var_78c64e88c14eda11 = player.cranked_end_time;
    function_7e0e9d0a4c08e116( player );
    var_d817c234346ae78a = player.cranked_end_time;
    function_ae516131ffc86172( var_d817c234346ae78a, var_78c64e88c14eda11, #"kill" );
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x7c59c6ec, Offset: 0x28cb
// Size: 0xa1
function private function_a229dfbf61dfdf82( player )
{
    function_ee2d5a311081405f();
    function_9e40e78b823d078e( player );
    victim = spawn_bot( player );
    score = get_agent_score( 1, player, victim );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Correct score?", score == 1 + level.gametypebundle.var_f411bb185a8c306b, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 475 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xb00785a0, Offset: 0x2974
// Size: 0x9b
function private function_1c91c4e6966e7409( player )
{
    level.gametypebundle.var_44f713a56ca0cb5e = 0;
    function_9e40e78b823d078e( player );
    victim = spawn_bot( player );
    score = get_death_score( 1, player, victim );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Correct score?", score == 1, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 490 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x337da997, Offset: 0x2a17
// Size: 0xa1
function private function_87cec2882baa5809( player )
{
    function_ee2d5a311081405f();
    function_9e40e78b823d078e( player );
    victim = spawn_bot( player );
    score = get_death_score( 1, player, victim );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Correct score?", score == 1 + level.gametypebundle.var_f411bb185a8c306b, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 505 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x7921c95d, Offset: 0x2ac0
// Size: 0x9b
function private function_a84051d0dc83ad20( player )
{
    level.gametypebundle.var_44f713a56ca0cb5e = 0;
    function_9e40e78b823d078e( player );
    victim = spawn_bot( player );
    score = get_death_score( 1, player, victim );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Correct score?", score == 1, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 520 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x4d49b480, Offset: 0x2b63
// Size: 0xa4
function private function_40ae8d2f00aea7f3( player )
{
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player not cranked before bomb interact?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 527 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bomb_interact( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player cranked after bomb interact?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 531 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xed462837, Offset: 0x2c0f
// Size: 0x64
function private function_23635151ed95b77( player )
{
    function_9e40e78b823d078e( player );
    var_9a50947456e0f5af = player.cranked_end_time;
    bomb_interact( player );
    var_aa58e70d5712014e = player.cranked_end_time;
    function_ae516131ffc86172( var_aa58e70d5712014e, var_9a50947456e0f5af, #"kill" );
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x841232dd, Offset: 0x2c7b
// Size: 0xa4
function private function_5de7f2896b58eaae( player )
{
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Timer not paused before bomb interact?", player.var_809ce60fdffd0fab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 553 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bomb_interact( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Timer not paused after bomb interact?", player.var_809ce60fdffd0fab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 557 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xd849de8c, Offset: 0x2d27
// Size: 0xad
function private function_57bfd0a37778159b( player )
{
    bomb_interact( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Timer not paused after bomb interact?", player.var_809ce60fdffd0fab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 566 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_71205a77ecb58a3f( player );
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Timer not paused before bomb interact?", player.var_809ce60fdffd0fab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 570 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x2f08ce9f, Offset: 0x2ddc
// Size: 0xe2
function private function_702ff6a5fdc50fff( player )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "gametype bundle has awardTiers specified?", level.gametypebundle.awardtiers[ 0 ], "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 577 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bomb_interact( player );
    player function_fbda2195f7d243b9( level.gametypebundle.awardtiers[ 1 ], 0 );
    function_71205a77ecb58a3f( player );
    
    for ( i = 0; i < level.gametypebundle.awardtiers.size ; i++ )
    {
        player function_fbda2195f7d243b9( level.gametypebundle.awardtiers[ i ] );
    }
    
    cleanup_individual_test();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x93b8130e, Offset: 0x2ec6
// Size: 0x2b
function private spawn_bot( player )
{
    bot_spawn_data = autotests_utility_bot::get_spawn_data( player, 90 );
    return autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, bot_spawn_data );
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x4b2d342f, Offset: 0x2efa
// Size: 0x5a
function private hit_bot( player )
{
    bot = spawn_bot( player );
    bot.attackers = [ player ];
    callback::callback( #"hash_d4bbb4278ed1fcab", { #attacker:player, #victim:bot } );
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x9ce62a0f, Offset: 0x2f5c
// Size: 0x5a
function private function_72f86eb3c61b728d( player )
{
    bot = spawn_bot( player );
    bot.attackers = [ player ];
    callback::callback( #"hash_71281d183072c5e8", { #attacker:player, #victim:bot } );
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x52144fc4, Offset: 0x2fbe
// Size: 0x5e
function private function_9e40e78b823d078e( player )
{
    function_72f86eb3c61b728d( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player cranked after kill?", player.cranked, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 619 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xcc922ac8, Offset: 0x3024
// Size: 0x40
function private enter_zone( player )
{
    mock_zone = {};
    callback::callback( #"hash_af5376dd4fc03b8f", { #zone:mock_zone, #enterplayer:player } );
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xad684eb3, Offset: 0x306c
// Size: 0x28
function private exit_zone( player )
{
    callback::callback( #"hash_dcaaf3c8d874eeab", { #exitplayer:player } );
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x52a00d13, Offset: 0x309c
// Size: 0x36
function private function_b1a77262017e5857( player )
{
    mock_dog_tag = {};
    mock_dog_tag.attackers = [];
    level [[ level.var_5e3de022ab7dace1 ]]( player, mock_dog_tag );
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xdce259fe, Offset: 0x30da
// Size: 0x1a
function private function_4862cf17037cc9f6( player )
{
    player [[ level.var_199ea879c219d932 ]]();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0x7c17b8ef, Offset: 0x30fc
// Size: 0x1a
function private function_62a17920130c60b0( player )
{
    player [[ level.var_1d4d11b58cd611a0 ]]();
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xbaad5362, Offset: 0x311e
// Size: 0x1a
function private function_7e0e9d0a4c08e116( player )
{
    player [[ level.var_feb5ffcd580afd63 ]]();
}

// Namespace test_mp_gametype_cranked
// Params 3, eflags: 0x4
// Checksum 0x95ce1d12, Offset: 0x3140
// Size: 0x2d
function private get_agent_score( score, player, bot )
{
    return player [[ level.var_1fccdf402d0756ac ]]( score, bot );
}

// Namespace test_mp_gametype_cranked
// Params 3, eflags: 0x4
// Checksum 0xddc014a0, Offset: 0x3176
// Size: 0x2f
function private get_death_score( score, player, bot )
{
    return player [[ level.var_2d8ab98961edff5f ]]( score, bot, 0, undefined );
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xd812c06d, Offset: 0x31ae
// Size: 0x41
function private bomb_interact( player )
{
    mock_bomb = {};
    level callback::callback( #"hash_90e8659b0b441f02", { #bombplanted:mock_bomb, #player:player } );
}

// Namespace test_mp_gametype_cranked
// Params 2, eflags: 0x4
// Checksum 0xc9ba1b51, Offset: 0x31f7
// Size: 0x46
function private function_71205a77ecb58a3f( player, success = 1 )
{
    level callback::callback( #"hash_f1f1c4c5d121b7df", { #success:success, #player:player } );
}

// Namespace test_mp_gametype_cranked
// Params 1, eflags: 0x4
// Checksum 0xebb4e918, Offset: 0x3245
// Size: 0x144
function private get_timer_amount( var_d203aaed116116ae )
{
    switch ( var_d203aaed116116ae )
    {
        case #"hit":
            return int( level.gametypebundle.var_1771bb45f0bd76e8 * level.gametypebundle.var_dd5874ef33b5421a );
        case #"kill":
            return int( level.gametypebundle.var_8c1555a38733ae78 * level.gametypebundle.var_dd5874ef33b5421a );
        case #"assist":
            return int( level.crankedbombtimer * level.gametypebundle.var_dd5874ef33b5421a * level.gametypebundle.var_bba4da52eaf1ff50 );
        case #"friendly_tag":
            return int( level.crankedbombtimer * level.gametypebundle.var_dd5874ef33b5421a * level.gametypebundle.var_45cb4433e870ec92 );
        case #"full":
        default:
            return int( level.crankedbombtimer * level.gametypebundle.var_dd5874ef33b5421a );
    }
}

// Namespace test_mp_gametype_cranked
// Params 3, eflags: 0x4
// Checksum 0xd349d315, Offset: 0x3391
// Size: 0x7f
function private function_ae516131ffc86172( cranked_end_time_new, cranked_end_time_old, var_d203aaed116116ae )
{
    timer_amount = get_timer_amount( var_d203aaed116116ae );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has correct timer after increase event?", roundint( ( cranked_end_time_new - cranked_end_time_old ) * 0.001 ) == timer_amount, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 700 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_gametype_cranked
// Params 2, eflags: 0x4
// Checksum 0xbc1f1178, Offset: 0x3418
// Size: 0x761
function private function_fbda2195f7d243b9( award_tier, test_active = 1 )
{
    if ( !award_tier )
    {
        return;
    }
    
    foreach ( tier in award_tier.var_9bc5fa0f0aa30f45 )
    {
        switch ( tier.awardtype )
        {
            case #"movespeed":
                var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Is move speed award active (" + test_active + ")?", test_active ? self.var_2d0e74f429afe5a0[ "awardTier_superSpeed" ] : !self.var_2d0e74f429afe5a0[ "awardTier_superSpeed" ], "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 715 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                break;
            case #"perk":
                var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has perk (" + test_active + ")?", test_active ? arraycontains( self.var_14069be3be1a38be, tier.award ) : !self.var_14069be3be1a38be || !arraycontains( self.var_14069be3be1a38be, tier.award ), "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 718 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                break;
            case #"hash_8e03401d34e9afc3":
                mult_value = self.values[ "field_upgrade_recharge_mult" ][ #"awardtiers" ];
                var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has recharge mult (" + test_active + ")?", test_active ? mult_value : !mult_value, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 722 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                break;
            case #"explosionupgrade":
                var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has large explosion (" + test_active + ")?", test_active ? self.largeexplosion : !self.largeexplosion, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 725 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                break;
            case #"hash_9dde49d9ed7c681a":
                var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has melee damage increase (" + test_active + ")?", test_active ? self.var_1204652ea34834f5 : !self.var_1204652ea34834f5, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 728 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                break;
            case #"headshotdamage":
                var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player headshot damage (" + test_active + ")?", test_active ? self.var_d222e580804b1a07 : !self.var_d222e580804b1a07, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 731 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                break;
            case #"hash_2190015c8a8134fd":
                var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player upgraded health (" + test_active + ")?", test_active ? self.var_9344a898a306ef7e : !self.var_9344a898a306ef7e, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 734 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                break;
            case #"bonus":
            case #"streak":
                switch ( tier.award )
                {
                    case #"hash_148304198d02afc0":
                        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player harp active (" + test_active + ")?", test_active ? self.harpactive : !self.harpactive, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 741 );
                        
                        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                        {
                            if ( autotests::function_561cb32cd7469145() )
                            {
                                return;
                            }
                            
                            autotests::test_assert_return( var_63a718d91714219d );
                        }
                        
                        break;
                    case #"hash_5f054fa72e77b8dd":
                        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player double jump enabled (" + test_active + ")?", test_active ? getdvar( @"hash_b9e0a0a687cd9e51", 0 ) : !getdvar( @"hash_b9e0a0a687cd9e51", 0 ), "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 744 );
                        
                        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                        {
                            if ( autotests::function_561cb32cd7469145() )
                            {
                                return;
                            }
                            
                            autotests::test_assert_return( var_63a718d91714219d );
                        }
                        
                        break;
                    case #"hash_c2c5f76f15752ab6":
                        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player double objective points (" + test_active + ")?", test_active ? self.var_208c55191cf6f7ab : !self.var_208c55191cf6f7ab, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 747 );
                        
                        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                        {
                            if ( autotests::function_561cb32cd7469145() )
                            {
                                return;
                            }
                            
                            autotests::test_assert_return( var_63a718d91714219d );
                        }
                        
                        break;
                    case #"hash_c6cc2bcd30793645":
                        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player double score (" + test_active + ")?", test_active ? self.point_scalar : !self.point_scalar, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 750 );
                        
                        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                        {
                            if ( autotests::function_561cb32cd7469145() )
                            {
                                return;
                            }
                            
                            autotests::test_assert_return( var_63a718d91714219d );
                        }
                        
                        break;
                    case #"hash_fa6f637d8391884":
                        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player equip refresh on kill (" + test_active + ")?", test_active ? self.var_97fdb3fabafcbe7b : !self.var_97fdb3fabafcbe7b, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 753 );
                        
                        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                        {
                            if ( autotests::function_561cb32cd7469145() )
                            {
                                return;
                            }
                            
                            autotests::test_assert_return( var_63a718d91714219d );
                        }
                        
                        break;
                    default:
                        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player bonus is not accounted for?", 0, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 756 );
                        
                        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                        {
                            if ( autotests::function_561cb32cd7469145() )
                            {
                                return;
                            }
                            
                            autotests::test_assert_return( var_63a718d91714219d );
                        }
                        
                        break;
                }
                
                break;
            case #"scoremultiplier":
                var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player score mult (" + test_active + ")?", test_active ? self.point_scalar : !self.point_scalar, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 761 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                break;
            case #"hash_a916ca8427ae4624":
                var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player headshot mult (" + test_active + ")?", test_active ? self.headshot_point_scalar : !self.headshot_point_scalar, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 764 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                break;
            default:
                var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player award is not accounted for?", 0, "scripts/autotests/mp/test_mp_gametype_cranked.gsc", 767 );
                
                if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
                {
                    if ( autotests::function_561cb32cd7469145() )
                    {
                        return;
                    }
                    
                    autotests::test_assert_return( var_63a718d91714219d );
                }
                
                break;
        }
    }
}

// Namespace test_mp_gametype_cranked
// Params 0, eflags: 0x4
// Checksum 0x3d57fb09, Offset: 0x3b81
// Size: 0x5b
function private function_68e9e872a42911c1()
{
    level.gametypebundle.var_1a770d7bb00956e0 = 1;
    level.gametypebundle.var_1771bb45f0bd76e8 = 10;
    
    if ( !callback::exists( #"hash_d4bbb4278ed1fcab", &cranked::oncrankedhit ) )
    {
        callback::add( #"hash_d4bbb4278ed1fcab", &cranked::oncrankedhit );
    }
}

// Namespace test_mp_gametype_cranked
// Params 0, eflags: 0x4
// Checksum 0xc17995a2, Offset: 0x3be4
// Size: 0x18
function private function_17d4190b273dae57()
{
    level.gametypebundle.var_8c1555a38733ae78 = 10;
}

// Namespace test_mp_gametype_cranked
// Params 0, eflags: 0x4
// Checksum 0xee737481, Offset: 0x3c04
// Size: 0x39
function private function_ee2d5a311081405f()
{
    level.matchmakingmatch = 1;
    level.gametypebundle.var_44f713a56ca0cb5e = 1;
    level.gametypebundle.var_f411bb185a8c306b = 5;
}

// Namespace test_mp_gametype_cranked
// Params 0, eflags: 0x4
// Checksum 0x31bc9ba7, Offset: 0x3c45
// Size: 0x1f
function private function_bb9724c11a0c2578()
{
    level.gametypebundle.var_8c1555a38733ae78 = level.crankedbombtimer;
}

