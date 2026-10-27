// scripts\autotests\selftest\test_selftest_result_priority.gsc  (hash_4510e42cbd62c160.gscc) (size: 6835 Bytes / 0x1ab3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf5e07cc7 (4125129927)
// size ...... 6835 (0x1ab3)
// includes .. 1   (offset: 0x1873)
// strings ... 35  (offset: 0x187b)
// dev strs .. 1   (offset: 0x1aa7)
// exports ... 18  (offset: 0x113f)
// cseg ...... 0x2d4 + 0xe6b (0x113f)
// imports ... 34  (offset: 0x140f)
// animtree1 . 0   (offset: 0x1ab3)
// animtree2 . 0   (offset: 0x1ab3)
#using scripts\autotests\autotests;

#namespace test_selftest_result_priority;

// Namespace test_selftest_result_priority/testautomation
// Params 0, eflags: 0x20
// Checksum 0x5b16a87, Offset: 0x2f2
// Size: 0x44
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_selftest_result_priority", #"test", &start_test, &setup );
    autotests::parameterize_test( #"test_selftest_result_priority", &parameterize, &parameterize_setup, &parameterize_cleanup );
}

// Namespace test_selftest_result_priority
// Params 1
// Checksum 0xa8a995be, Offset: 0x33e
// Size: 0xf7
function parameterize( datasets )
{
    return [ "setupReturnFail", "setupReturnSuccess", "setupReturnUndefined", "setupAssert", "setupTestFail", "setupTestSuccess", "setupTimeout", "returnFail", "returnSuccess", "returnUndefined", "returnSkip", "assert", "assertAndFail", "fail", "success", "info", "functionAssert", "functionFail", "functionSuccess", "functionUndefined", "functionReturnFail", "functionReturnSuccess", "functionReturnUndefined", "functionReturnSkip", "timeout", "analysis" ];
}

// Namespace test_selftest_result_priority
// Params 0
// Checksum 0xb2b49030, Offset: 0x43e
// Size: 0xbd
function parameterize_setup()
{
    var_da16debf9d60db94 = level.autotests.test_runtime.var_da16debf9d60db94;
    
    if ( var_da16debf9d60db94 )
    {
        function_7d261c49b0e6abe2( var_da16debf9d60db94 );
    }
    
    testname = self.parameters[ 0 ];
    testcase = function_d121ec926c2348ba( testname );
    level.autotests.test_runtime.var_3ab8824abbb2737b = testcase;
    level.autotests.test_runtime.var_da16debf9d60db94 = testname;
    
    if ( testcase.insetup )
    {
        return function_a9c588d68f8e0881( testcase );
    }
    
    return 1;
}

// Namespace test_selftest_result_priority
// Params 0
// Checksum 0xb5d6d173, Offset: 0x503
// Size: 0x2
function parameterize_cleanup()
{
    
}

// Namespace test_selftest_result_priority
// Params 0
// Checksum 0xd4afee2, Offset: 0x50d
// Size: 0x6b, Type: bool
function setup()
{
    testcases = function_b17829fca304a049();
    level.autotests.test_runtime.testcases = testcases;
    autotests::set_dvar( @"hash_2bb0e3f2696dfe42", 1 );
    autotests::set_dvar( @"hash_9e49766c62b3af0d", 1 );
    autotests::set_dvar( @"hash_aa5c2e28a06af46", 0 );
    return true;
}

// Namespace test_selftest_result_priority
// Params 9
// Checksum 0xc3f364a1, Offset: 0x581
// Size: 0xb8
function function_3dd46d8881f50320( insetup, doassert, timeout, ReturnSuccess, returnfailure, testsuccess, testfailure, cancel, expectedresult )
{
    return { #expectedresult:expectedresult, #cancel:cancel, #testfailure:testfailure, #testsuccess:testsuccess, #returnfailure:returnfailure, #ReturnSuccess:ReturnSuccess, #timeout:timeout, #doassert:doassert, #insetup:insetup };
}

// Namespace test_selftest_result_priority
// Params 0
// Checksum 0x36113b2d, Offset: 0x642
// Size: 0x9b
function start_test()
{
    testname = self.parameters[ 0 ];
    
    if ( testname == "analysis" )
    {
        autotests::push_function( "All test results were as expected?" );
        test_result_int = function_c421621c4bb5557d() ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "All test results were as expected?", test_result_int, undefined, undefined, "scripts/autotests/selftest/test_selftest_result_priority.gsc", 133 );
        autotests::pop_function( "All test results were as expected?" );
        autotests::test_assert_return( test_result_int );
    }
    
    testcase = function_d121ec926c2348ba( testname );
    
    if ( !testcase.insetup )
    {
        return function_a9c588d68f8e0881( testcase );
    }
}

// Namespace test_selftest_result_priority
// Params 1
// Checksum 0x7d656403, Offset: 0x6e5
// Size: 0x2c
function function_d121ec926c2348ba( ref )
{
    return level.autotests.test_runtime.testcases[ ref ];
}

// Namespace test_selftest_result_priority
// Params 1
// Checksum 0x5c8d2b27, Offset: 0x71a
// Size: 0x157
function function_a9c588d68f8e0881( testcase )
{
    if ( testcase.testfunction )
    {
        function_c1d2c298f003cd19( testcase );
        return;
    }
    
    if ( testcase.doassert )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    if ( testcase.timeout )
    {
        wait 1;
    }
    
    if ( testcase.testsuccess )
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Success!", 1, "scripts/autotests/selftest/test_selftest_result_priority.gsc", 169 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    else if ( isdefined( testcase.testsuccess ) && !testcase.testsuccess )
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Fail!", 0, "scripts/autotests/selftest/test_selftest_result_priority.gsc", 173 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    if ( testcase.testinfo )
    {
        autotests::report_info( "Info!" );
    }
    
    if ( testcase.insetup )
    {
        if ( testcase.returnresult == 0 )
        {
            return 1;
        }
        else if ( testcase.returnresult == 1 )
        {
            return 0;
        }
        else
        {
            return;
        }
        
        return;
    }
    
    return testcase.returnresult;
}

// Namespace test_selftest_result_priority
// Params 1
// Checksum 0xaa6e123, Offset: 0x879
// Size: 0x7a
function function_c1d2c298f003cd19( testcase )
{
    var_dcf52b1fd46102d4 = structcopy( testcase );
    var_dcf52b1fd46102d4.testfunction = 0;
    autotests::push_function( "Running test case" );
    test_result_int = function_a9c588d68f8e0881( var_dcf52b1fd46102d4 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Running test case", test_result_int, undefined, undefined, "scripts/autotests/selftest/test_selftest_result_priority.gsc", 207 );
    autotests::pop_function( "Running test case" );
    autotests::test_assert_return( test_result_int );
}

// Namespace test_selftest_result_priority
// Params 2
// Checksum 0x1ecce108, Offset: 0x8fb
// Size: 0x64
function add_test_result( testname, testresult )
{
    var_ab35c73bb4ee4d48 = level.autotests.test_runtime.var_ab35c73bb4ee4d48 ?? [];
    level.autotests.test_runtime.var_ab35c73bb4ee4d48[ testname ] = testresult;
}

// Namespace test_selftest_result_priority
// Params 1
// Checksum 0x254031e1, Offset: 0x967
// Size: 0xa4
function function_7d261c49b0e6abe2( testname )
{
    if ( level.autotests.customtests.results.size - 2 < 0 )
    {
        return;
    }
    
    var_5d2e52daf5d5e127 = level.autotests.customtests.results[ level.autotests.customtests.results.size - 2 ];
    var_bdc0f0b4d48394e = var_5d2e52daf5d5e127[ var_5d2e52daf5d5e127.size - 1 ].result_int;
    add_test_result( testname, var_bdc0f0b4d48394e );
}

// Namespace test_selftest_result_priority
// Params 0
// Checksum 0x6916d727, Offset: 0xa13
// Size: 0x18f
function function_c421621c4bb5557d()
{
    var_c35ef3632796f83a = 1;
    var_ab35c73bb4ee4d48 = level.autotests.test_runtime.var_ab35c73bb4ee4d48;
    
    foreach ( testname, testcase in level.autotests.test_runtime.testcases )
    {
        testresult = var_ab35c73bb4ee4d48[ testname ];
        
        if ( !isdefined( testresult ) )
        {
            continue;
        }
        
        var_26558b5fb1489cac = testname + " result " + autotests::test_result_to_string( testresult ) + " matches expected " + autotests::test_result_to_string( testcase.expectedresult ) + "?";
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( var_26558b5fb1489cac, testresult, testcase.expectedresult, "scripts/autotests/selftest/test_selftest_result_priority.gsc", 244 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        if ( testresult != testcase.expectedresult )
        {
            var_c35ef3632796f83a = 0;
        }
    }
    
    autotests::reset_dvar( @"hash_aa5c2e28a06af46" );
    autotests::set_dvar( @"hash_aa5c2e28a06af46", 1 );
    return var_c35ef3632796f83a ? 0 : 1;
}

// Namespace test_selftest_result_priority
// Params 0
// Checksum 0x858b64ec, Offset: 0xbab
// Size: 0x1ad
function function_4f9e7586b4506672()
{
    defaultstruct = { #doassert:0, #testinfo:0, #timeout:0, #testfunction:1, #insetup:0 };
    return [ "functionReturnSkip":structcombine( { #expectedresult:5, #testsuccess:undefined, #returnresult:5 }, defaultstruct ), "functionReturnUndefined":structcombine( { #expectedresult:0, #testsuccess:undefined, #returnresult:undefined }, defaultstruct ), "functionReturnSuccess":structcombine( { #expectedresult:0, #testsuccess:undefined, #returnresult:0 }, defaultstruct ), "functionReturnFail":structcombine( { #expectedresult:1, #testsuccess:undefined, #returnresult:1 }, defaultstruct ), "functionUndefined":structcombine( { #expectedresult:0, #testsuccess:undefined, #returnresult:undefined }, defaultstruct ), "functionSuccess":structcombine( { #expectedresult:0, #testsuccess:1, #returnresult:undefined }, defaultstruct ), "functionFail":structcombine( { #expectedresult:1, #testsuccess:0, #returnresult:undefined }, defaultstruct ), "functionAssert":structcombine( { #expectedresult:6, #testsuccess:undefined, #returnresult:undefined, #doassert:1 }, defaultstruct ) ];
}

// Namespace test_selftest_result_priority
// Params 0
// Checksum 0xb58f11b9, Offset: 0xd61
// Size: 0x226
function function_ff042b07434f7e3c()
{
    defaultstruct = { #doassert:0, #testinfo:0, #timeout:0, #testfunction:0, #insetup:0 };
    return [ "timeout":structcombine( { #expectedresult:8, #testsuccess:undefined, #returnresult:undefined, #timeout:1 }, defaultstruct ), "info":structcombine( { #expectedresult:0, #testinfo:1, #testsuccess:1, #returnresult:undefined }, defaultstruct ), "success":structcombine( { #expectedresult:0, #testsuccess:1, #returnresult:undefined }, defaultstruct ), "fail":structcombine( { #expectedresult:1, #testsuccess:0, #returnresult:undefined }, defaultstruct ), "assertAndFail":structcombine( { #expectedresult:6, #testsuccess:0, #returnresult:undefined, #doassert:1 }, defaultstruct ), "assert":structcombine( { #expectedresult:6, #testsuccess:undefined, #returnresult:undefined, #doassert:1 }, defaultstruct ), "returnSkip":structcombine( { #expectedresult:5, #testsuccess:undefined, #returnresult:5 }, defaultstruct ), "returnUndefined":structcombine( { #expectedresult:0, #testsuccess:undefined, #returnresult:undefined }, defaultstruct ), "returnSuccess":structcombine( { #expectedresult:0, #testsuccess:undefined, #returnresult:0 }, defaultstruct ), "returnFail":structcombine( { #expectedresult:1, #testsuccess:undefined, #returnresult:1 }, defaultstruct ) ];
}

// Namespace test_selftest_result_priority
// Params 0
// Checksum 0xb8cf4b4, Offset: 0xf90
// Size: 0x18d
function function_1ba516e4bbdac3fb()
{
    defaultstruct = { #doassert:0, #testinfo:0, #timeout:0, #testfunction:0, #insetup:1 };
    return [ "setupTimeout":structcombine( { #expectedresult:2, #testsuccess:undefined, #returnresult:0, #timeout:1 }, defaultstruct ), "setupTestSuccess":structcombine( { #expectedresult:0, #testsuccess:1, #returnresult:0 }, defaultstruct ), "setupTestFail":structcombine( { #expectedresult:3, #testsuccess:0, #returnresult:undefined }, defaultstruct ), "setupAssert":structcombine( { #expectedresult:3, #testsuccess:undefined, #returnresult:undefined, #doassert:1 }, defaultstruct ), "setupReturnUndefined":structcombine( { #expectedresult:3, #testsuccess:undefined, #returnresult:undefined }, defaultstruct ), "setupReturnSuccess":structcombine( { #expectedresult:0, #testsuccess:undefined, #returnresult:0 }, defaultstruct ), "setupReturnFail":structcombine( { #expectedresult:3, #testsuccess:undefined, #returnresult:1 }, defaultstruct ) ];
}

// Namespace test_selftest_result_priority
// Params 0
// Checksum 0x31abb102, Offset: 0x1126
// Size: 0x18
function function_b17829fca304a049()
{
    return function_c6c06162c8e6ae75( function_1ba516e4bbdac3fb(), function_ff042b07434f7e3c(), function_4f9e7586b4506672() );
}

