// scripts\autotests\selftest\test_selftest_http.gsc  (hash_18d63e5efa8784c0.gscc) (size: 1555 Bytes / 0x613 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe5ba735 (3193677621)
// size ...... 1555 (0x613)
// includes .. 2   (offset: 0x5af)
// strings ... 6   (offset: 0x5bf)
// dev strs .. 0   (offset: 0x613)
// exports ... 5   (offset: 0x32f)
// cseg ...... 0x120 + 0x20f (0x32f)
// imports ... 15  (offset: 0x3f7)
// animtree1 . 0   (offset: 0x613)
// animtree2 . 0   (offset: 0x613)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;

#namespace test_selftest_http;

// Namespace test_selftest_http/testautomation
// Params 0, eflags: 0x20
// Checksum 0xce5446a9, Offset: 0x13e
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/selftest/test_selftest_http.gsc", #"test", &start_test, &setup );
}

// Namespace test_selftest_http
// Params 0
// Checksum 0xacdddc0d, Offset: 0x167
// Size: 0xb, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_selftest_http
// Params 0
// Checksum 0xe66cff2f, Offset: 0x17b
// Size: 0x136
function start_test()
{
    var_9efdf0fad01acc61 = "https://ta-am-apollo.activision.com/echo";
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player found?", isdefined( player ), "scripts/autotests/selftest/test_selftest_http.gsc", 29 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    data = spawnstruct();
    data.stringfield = "teststring";
    data.intfield = 321;
    level.autotests.test_runtime.var_552e784db1ce905d = 0;
    autotests::http_post( var_9efdf0fad01acc61, data, &response_callback );
    starttime = gettime();
    
    while ( !level.autotests.test_runtime.var_552e784db1ce905d )
    {
        waitframe();
        
        if ( gettime() - starttime > 5000 )
        {
            autotests::function_d84657f448aaeef6( "HTTP response did not come back in 5 sec!", 0, "scripts/autotests/selftest/test_selftest_http.gsc", 39 );
            return;
        }
    }
}

// Namespace test_selftest_http
// Params 1
// Checksum 0xb921f5f1, Offset: 0x2b9
// Size: 0x76
function response_callback( data )
{
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "HTTP request successful", data.statuscode, 200, "scripts/autotests/selftest/test_selftest_http.gsc", 44 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.var_552e784db1ce905d = 1;
}

