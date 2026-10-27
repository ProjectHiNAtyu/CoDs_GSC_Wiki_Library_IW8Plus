// scripts\autotests\autotests.gsc  (hash_040cb00815c998c3.gscc) (size: 35354 Bytes / 0x8a1a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe010346c (3759158380)
// size ...... 35354 (0x8a1a)
// includes .. 3   (offset: 0x8276)
// strings ... 102 (offset: 0x828e)
// dev strs .. 33  (offset: 0x8872)
// exports ... 129 (offset: 0x57ba)
// cseg ...... 0x6ee + 0x50cc (0x57ba)
// imports ... 175 (offset: 0x6be2)
// animtree1 . 0   (offset: 0x8a1a)
// animtree2 . 0   (offset: 0x8a1a)
#using scripts\common\devgui;
#using scripts\common\ui;
#using scripts\common\utility;

#namespace autotests;

// Namespace autotests/testautomation
// Params 0, eflags: 0x20
// Checksum 0x5a99860c, Offset: 0x70c
// Size: 0xe0
function event_handler[testautomation] main()
{
    println( "<dev string:x24>" );
    ensure_datastructures();
    setdvar( @"autotest_state", 0 );
    var_6c554ac07503ce35 = function_3b2b53df838586b2();
    
    foreach ( var_c9013fcec75e9584 in var_6c554ac07503ce35 )
    {
        register_bundles( var_c9013fcec75e9584 );
    }
    
    level thread autotest_monitor();
    level thread autotest_cancel_monitor();
    init_struct_spawns();
    ui::lui_registercallback( "autotest_restart", &restart_test );
    ui::lui_registercallback( "autotest_cancel", &cancel_test );
}

// Namespace autotests
// Params 0
// Checksum 0xda2279d, Offset: 0x7f4
// Size: 0xc5
function init_struct_spawns()
{
    spawns = [];
    structspawns = utility::getstructarray( "gsc_autotest", "script_noteworthy" );
    
    foreach ( structspawn in structspawns )
    {
        spawns[ structspawn.targetname ] = structspawn.origin;
    }
    
    if ( spawns.size )
    {
        level.autotests.spawns = spawns;
    }
}

// Namespace autotests
// Params 0
// Checksum 0x8ac8a9c5, Offset: 0x8c1
// Size: 0x2d
function function_3b2b53df838586b2()
{
    if ( !isdefined( level.var_6c554ac07503ce35 ) )
    {
        level.var_6c554ac07503ce35 = getscriptbundlenames( #"autotestlist" );
    }
    
    return level.var_6c554ac07503ce35;
}

// Namespace autotests
// Params 0
// Checksum 0x30e6041d, Offset: 0x8f7
// Size: 0x2d
function get_autotest_bundle_names()
{
    if ( !isdefined( level.autotest_bundle_names ) )
    {
        level.autotest_bundle_names = getscriptbundlenames( #"autotest" );
    }
    
    return level.autotest_bundle_names;
}

// Namespace autotests
// Params 1
// Checksum 0x6146b279, Offset: 0x92d
// Size: 0x42
function get_struct_location( targetname )
{
    location = level.autotests.spawns[ targetname ];
    assert( location, "<dev string:x39>" + targetname );
    return location;
}

// Namespace autotests/gsc_http
// Params 1, eflags: 0x20
// Checksum 0x6340f6da, Offset: 0x978
// Size: 0x71
function event_handler[gsc_http] http_response( data )
{
    guid = data.guid;
    
    if ( level.var_9627f0f5044283a5[ guid ] )
    {
        if ( level.var_9627f0f5044283a5[ guid ].response_callback )
        {
            [[ level.var_9627f0f5044283a5[ guid ].response_callback ]]( data );
        }
        
        level.var_9627f0f5044283a5[ guid ] = undefined;
    }
}

// Namespace autotests
// Params 3
// Checksum 0x3cfe20db, Offset: 0x9f1
// Size: 0x29
function http_post( url, data, callback )
{
    thread function_9856c555ae47611b( url, data, callback );
}

// Namespace autotests
// Params 3
// Checksum 0xdf9a845c, Offset: 0xa22
// Size: 0xc3
function function_9856c555ae47611b( url, data, callback )
{
    if ( !isdefined( level.var_9627f0f5044283a5 ) )
    {
        level.var_9627f0f5044283a5 = [];
    }
    
    if ( !isdefined( level.var_b294132cc89197ee ) )
    {
        level.var_b294132cc89197ee = 0;
    }
    
    level.var_b294132cc89197ee++;
    
    while ( level.var_9627f0f5044283a5.size >= 32 )
    {
        wait 0.5;
    }
    
    guid = level.var_b294132cc89197ee;
    request = spawnstruct();
    request.guid = guid;
    request.response_callback = callback;
    level.var_9627f0f5044283a5[ guid ] = request;
    function_51bb4adf849d1242( guid, url, data );
}

// Namespace autotests
// Params 0
// Checksum 0x2d1a8f78, Offset: 0xaed
// Size: 0x1d
function test_errorcount()
{
    if ( getdvarint( @"hash_28dfd17294380da3", 1 ) == 1 )
    {
        return function_515278b2a3cdfb58();
    }
    
    return 0;
}

// Namespace autotests
// Params 0
// Checksum 0xf5778d42, Offset: 0xb13
// Size: 0x47, Type: bool
function function_b26bb8d4484e1426()
{
    var_786aae16f2ad9825 = test_errorcount();
    
    if ( var_786aae16f2ad9825 > level.autotests.var_299b18fe7755901b )
    {
        level.autotests.var_299b18fe7755901b = var_786aae16f2ad9825;
        return true;
    }
    
    return false;
}

// Namespace autotests
// Params 1
// Checksum 0xa60c2ac9, Offset: 0xb63
// Size: 0x104
function register_bundles( autotestlist )
{
    list = getscriptbundle( autotestlist );
    autotest_list_struct = function_676f527a957a9500( autotestlist );
    
    foreach ( entry in list.autotest_list )
    {
        test_ref = getscriptbundlefieldvalue( entry.bundle, #"testref" );
        xhash_ref = test_ref;
        test = level.autotests.tests[ xhash_ref ];
        
        if ( isdefined( test ) )
        {
            autotest_list_struct.autotest_list[ xhash_ref ] = test;
        }
    }
}

// Namespace autotests
// Params 8
// Checksum 0x8092d405, Offset: 0xc6f
// Size: 0x4b4
function register_test( xhash_ref, xhash_category, trigger_function, setup_function, cleanup_function, parameterize_function, var_646db331430d11c9, var_fa6302d97c314ff6 )
{
    ensure_datastructures();
    assert( isxhash( xhash_ref ), "<dev string:x56>" );
    assert( isxhash( xhash_category ), "<dev string:x8c>" );
    
    if ( !isdefined( var_fa6302d97c314ff6 ) )
    {
        var_fa6302d97c314ff6 = 0;
    }
    
    test = spawnstruct();
    test.name = getxhashhexname( xhash_ref );
    
    /#
        test.name = getxhashsourcename( xhash_ref );
    #/
    
    test.xhash_category = xhash_category;
    test.xhash_ref = xhash_ref;
    test.trigger_func = trigger_function;
    test.setup_function = setup_function;
    test.cleanup_function = cleanup_function;
    test.parameterize_function = parameterize_function;
    test.var_646db331430d11c9 = var_646db331430d11c9;
    test.var_fa6302d97c314ff6 = var_fa6302d97c314ff6;
    level.autotests.tests[ xhash_ref ] = test;
    var_6c554ac07503ce35 = function_3b2b53df838586b2();
    
    foreach ( var_c9013fcec75e9584 in var_6c554ac07503ce35 )
    {
        autotest_list_struct = level.autotests.var_dc5c2d60123d0b4f[ var_c9013fcec75e9584 ];
        
        if ( isdefined( autotest_list_struct ) )
        {
            list = getscriptbundle( var_c9013fcec75e9584 );
            
            foreach ( entry in list.autotest_list )
            {
                test_ref = getscriptbundlefieldvalue( entry.bundle, #"testref" );
                
                if ( test_ref == xhash_ref )
                {
                    if ( !isdefined( autotest_list_struct.autotest_list[ xhash_ref ] ) )
                    {
                        autotest_list_struct.autotest_list[ xhash_ref ] = test;
                    }
                }
            }
        }
    }
    
    autotest_bundle_names = get_autotest_bundle_names();
    
    foreach ( autotest_bundle_name in autotest_bundle_names )
    {
        test_bundle = getscriptbundlefieldvalues( autotest_bundle_name, [ #"testref", #"hash_2040eec188988745", #"devguicat" ] );
        
        if ( test_bundle.testref == xhash_ref )
        {
            level.autotests.customtests.var_1d8d80170c7591b[ xhash_ref ] = autotest_bundle_name;
            
            /#
                if ( test_bundle.var_2b2d5b7c209f1772 == 1 )
                {
                    devguiindex = undefined;
                    
                    if ( test_bundle.devguicat == "<dev string:xc3>" )
                    {
                        devguiindex = 2;
                        devgui::function_9082edeb5db93280( "<dev string:xc8>" );
                    }
                    else
                    {
                        var_9c46d6ca6b555e74 = strtok( test_bundle.devguicat, "<dev string:xd1>" );
                        settingblock = "<dev string:xc8>";
                        
                        foreach ( split in var_9c46d6ca6b555e74 )
                        {
                            settingblock += split + "<dev string:xd3>";
                            devguiindex = 2;
                        }
                        
                        devgui::function_9082edeb5db93280( settingblock );
                    }
                    
                    devgui::function_cd4e263c1f3018ae( test.name, "<dev string:xd7>" + getxhashsourcename( test_bundle.testref ), &function_e6567dd848ec73ae, 1, devguiindex );
                    devgui::function_77df7fe7dd273e10();
                }
            #/
        }
    }
    
    return test;
}

// Namespace autotests
// Params 7
// Checksum 0x3ac19c85, Offset: 0x112c
// Size: 0x97
function register_custom_test( test_list, test_name, category, trigger_func, setup_function, cleanup_function, var_fa6302d97c314ff6 )
{
    test = register_test( test_name, category, trigger_func, setup_function, cleanup_function, var_fa6302d97c314ff6 );
    
    if ( !isdefined( test ) )
    {
        return;
    }
    
    ensure_datastructures();
    autotest_list_struct = function_676f527a957a9500( test_list );
    autotest_list_struct.autotest_list[ test.xhash_ref ] = test;
}

// Namespace autotests
// Params 4
// Checksum 0x7d7e12f1, Offset: 0x11cb
// Size: 0xaf
function function_b6d1ca589de535a4( var_226234d9282b67f1, parameterize_function, var_a1bbdb043be1f7b0, var_898ecb8b97918a17 )
{
    bundle_refs = function_e8ac7fa1b7e36705( var_226234d9282b67f1 );
    
    foreach ( bundle_ref in bundle_refs )
    {
        parameterize_test( bundle_ref, parameterize_function, var_a1bbdb043be1f7b0, var_898ecb8b97918a17 );
    }
}

// Namespace autotests
// Params 2
// Checksum 0x4a142151, Offset: 0x1282
// Size: 0x9a
function function_8037d0283ed66d77( var_226234d9282b67f1, var_e64e8709107d3e9c )
{
    bundle_refs = function_e8ac7fa1b7e36705( var_226234d9282b67f1 );
    
    foreach ( bundle_ref in bundle_refs )
    {
        function_e4c8599adaf3a98( bundle_ref, var_e64e8709107d3e9c );
    }
}

// Namespace autotests
// Params 4
// Checksum 0xb6afb2f9, Offset: 0x1324
// Size: 0x8b
function parameterize_test( xhash_ref, parameterize_function, var_a1bbdb043be1f7b0, var_898ecb8b97918a17 )
{
    test = level.autotests.tests[ xhash_ref ];
    
    if ( !isdefined( test ) )
    {
        assertmsg( "<dev string:xdd>" + xhash_ref );
        return;
    }
    
    test.parameterize_function = parameterize_function;
    test.var_a1bbdb043be1f7b0 = var_a1bbdb043be1f7b0;
    test.var_898ecb8b97918a17 = var_898ecb8b97918a17;
}

// Namespace autotests
// Params 2
// Checksum 0xe0638669, Offset: 0x13b7
// Size: 0x5d
function function_a8e1372b038cc18b( xhash_ref, var_842c74925f253023 )
{
    test = level.autotests.tests[ xhash_ref ];
    
    if ( !isdefined( test ) )
    {
        assertmsg( "<dev string:x117>" + xhash_ref );
        return;
    }
    
    test.var_842c74925f253023 = var_842c74925f253023;
}

// Namespace autotests
// Params 2
// Checksum 0xa98377df, Offset: 0x141c
// Size: 0x5d
function function_e4c8599adaf3a98( xhash_ref, var_e71386333bb4c227 )
{
    test = level.autotests.tests[ xhash_ref ];
    
    if ( !isdefined( test ) )
    {
        assertmsg( "<dev string:x150>" + xhash_ref );
        return;
    }
    
    test.var_e64e8709107d3e9c = var_e71386333bb4c227;
}

// Namespace autotests
// Params 1
// Checksum 0x6e21ad8e, Offset: 0x1481
// Size: 0x5a
function function_6aa62ac8ca7fface( input_path )
{
    newstr = "";
    
    for ( i = 0; i < input_path.size ; i++ )
    {
        if ( input_path[ i ] == "\\" )
        {
            newstr += "/";
            continue;
        }
        
        newstr += input_path[ i ];
    }
    
    return newstr;
}

// Namespace autotests
// Params 8
// Checksum 0xbfbc91b9, Offset: 0x14e4
// Size: 0xd8
function register_tests( var_226234d9282b67f1, xhash_category, trigger_function, setup_function, cleanup_function, parameterize_function, asset_function, var_fa6302d97c314ff6 )
{
    bundle_refs = function_e8ac7fa1b7e36705( var_226234d9282b67f1 );
    
    foreach ( bundle_ref in bundle_refs )
    {
        register_test( bundle_ref, xhash_category, trigger_function, setup_function, cleanup_function, parameterize_function, asset_function, var_fa6302d97c314ff6 );
    }
}

// Namespace autotests
// Params 1
// Checksum 0x9fc4019e, Offset: 0x15c4
// Size: 0xf1
function function_e8ac7fa1b7e36705( var_226234d9282b67f1 )
{
    bundle_refs = [];
    autotest_bundle_names = get_autotest_bundle_names();
    script_path = function_6aa62ac8ca7fface( var_226234d9282b67f1 );
    
    foreach ( bundle_name in autotest_bundle_names )
    {
        var_83443779332bd50e = getscriptbundlefieldvalue( bundle_name, #"scriptfilename" );
        
        if ( var_83443779332bd50e && function_6aa62ac8ca7fface( var_83443779332bd50e ) == script_path )
        {
            test_ref = getscriptbundlefieldvalue( bundle_name, #"testref" );
            bundle_refs[ bundle_refs.size ] = test_ref;
        }
    }
    
    return bundle_refs;
}

// Namespace autotests
// Params 1
// Checksum 0x20aff049, Offset: 0x16be
// Size: 0x43
function get_test_bundle( xhash_ref )
{
    assert( isxhash( xhash_ref ), "<dev string:x18a>" );
    return getscriptbundle( level.autotests.customtests.var_1d8d80170c7591b[ xhash_ref ] );
}

// Namespace autotests
// Params 2
// Checksum 0x6d71df43, Offset: 0x170a
// Size: 0x4d
function function_41b85fc97bb5520( xhash_ref, fields )
{
    assert( isxhash( xhash_ref ), "<dev string:x18a>" );
    return getscriptbundlefieldvalues( level.autotests.customtests.var_1d8d80170c7591b[ xhash_ref ], fields );
}

/#

    // Namespace autotests
    // Params 0
    // Checksum 0xa3ac8947, Offset: 0x1760
    // Size: 0x4a, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:xc8>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1b8>", "<dev string:x1d1>", &function_9b36302e7032ffa0, 1, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e4>", "<dev string:x1f1>", &restart_test, 1, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace autotests
    // Params 2
    // Checksum 0xfaa037fb, Offset: 0x17b2
    // Size: 0xb4, Type: dev
    function function_e2b70e08c303f07d( listprefix, autotestlist )
    {
        foreach ( index, testentry in autotestlist.autotest_list )
        {
            test_name = getxhashsourcename( index );
            devgui::function_cd4e263c1f3018ae( listprefix + test_name, "<dev string:xd7>" + test_name, &function_e6567dd848ec73ae, 1 );
        }
    }

    // Namespace autotests
    // Params 1
    // Checksum 0x9f383078, Offset: 0x186e
    // Size: 0x22, Type: dev
    function function_9b36302e7032ffa0( params )
    {
        setdvar( @"scr_autotest_cancel", "<dev string:x1fe>" );
    }

    // Namespace autotests
    // Params 1
    // Checksum 0xa61fa7bf, Offset: 0x1898
    // Size: 0x77, Type: dev
    function function_e6567dd848ec73ae( params )
    {
        test_ref = params[ 0 ];
        
        if ( isdefined( test_ref ) )
        {
            if ( isdefined( level.autotests.test_runtime ) && !utility::flag( "<dev string:x200>" ) )
            {
                print_both( "<dev string:x20e>" + get_current_test_name() + "<dev string:x21d>" );
                return;
            }
            
            setdvar( @"scr_autotest", test_ref );
        }
    }

#/

// Namespace autotests
// Params 1
// Checksum 0x87dd5d1e, Offset: 0x1917
// Size: 0x1f
function cancel_test( params )
{
    setdvar( @"scr_autotest_cancel", "1" );
}

// Namespace autotests
// Params 1
// Checksum 0xc9bda48d, Offset: 0x193e
// Size: 0x13
function restart_test( params )
{
    thread function_c5f687df1afb4c22();
}

// Namespace autotests
// Params 0
// Checksum 0xa4ee8c8c, Offset: 0x1959
// Size: 0xd4
function function_c5f687df1afb4c22()
{
    test = level.autotests.test_runtime.test;
    
    if ( !test || !test.name )
    {
        return;
    }
    
    if ( !level.autotests.test_runtime.cleaned_up || !utility::flag( "test_finished" ) )
    {
        setdvar( @"scr_autotest_cancel", "1" );
        
        while ( !level.autotests.test_runtime.cleaned_up || !utility::flag( "test_finished" ) )
        {
            waitframe();
        }
    }
    
    setdvar( @"scr_autotest", test.name );
}

// Namespace autotests
// Params 0
// Checksum 0x41518974, Offset: 0x1a35
// Size: 0x47
function function_375124f1db824f72()
{
    utility::flag_wait( "shared_functions_initialized" );
    
    if ( utility::ismp() )
    {
        while ( !isdefined( level.mapname ) )
        {
            waitframe();
        }
        
        return;
    }
    
    if ( utility::issp() )
    {
        while ( !isdefined( level.start_functions ) )
        {
            waitframe();
        }
    }
}

// Namespace autotests
// Params 1
// Checksum 0x7e4e176, Offset: 0x1a84
// Size: 0xdc
function function_d3af680806999308( parameters )
{
    if ( getdvarint( @"hash_ff4f994aaf503b96", 0 ) == 1 )
    {
        parameters = arrayrandomize( parameters );
    }
    
    max_parameters = getdvarint( @"hash_490bdbbd3907ce3", 0 );
    
    if ( max_parameters > 0 && max_parameters < parameters.size )
    {
        small_list = [];
        
        foreach ( parameter in parameters )
        {
            if ( small_list.size >= max_parameters )
            {
                break;
            }
            
            small_list[ small_list.size ] = parameter;
        }
        
        return small_list;
    }
    
    return parameters;
}

// Namespace autotests
// Params 0, eflags: 0xc
// Checksum 0x830b8a98, Offset: 0x1b69
// Size: 0x171
function private autotest_monitor()
{
    self notify( #"hash_e9fd047651efb34c" );
    self endon( #"hash_e9fd047651efb34c" );
    function_375124f1db824f72();
    
    /#
        devgui_init();
    #/
    
    setdvar( @"autotest_state", 1 );
    
    while ( true )
    {
        autotest_dvar_val = getdvar( @"scr_autotest", "" );
        
        if ( autotest_dvar_val != "" )
        {
            setdvar( @"autotest_result", -1 );
            function_ee47060132a48e();
            tests = strtok( autotest_dvar_val, "," );
            
            foreach ( test_name in tests )
            {
                test_found = function_2c1ef9ead730c506( test_name );
                
                if ( !test_found )
                {
                    print_both( "[TEST]Test not found name " + test_name );
                    test_start( test_name );
                    test_finish( test_name, 4 );
                }
            }
            
            setdvar( @"autotest_result", function_6f677e2957cdc018().result_int );
            setdvar( @"scr_autotest", "" );
        }
        
        wait 1;
    }
}

// Namespace autotests
// Params 0, eflags: 0xc
// Checksum 0x3b05455a, Offset: 0x1ce2
// Size: 0xbd
function private autotest_cancel_monitor()
{
    self notify( #"hash_666f4584ffa98b9a" );
    self endon( #"hash_666f4584ffa98b9a" );
    
    while ( true )
    {
        autotest_dvar_val = getdvar( @"scr_autotest_cancel", "" );
        
        if ( autotest_dvar_val != "" )
        {
            if ( !isdefined( level.autotests.test_runtime.result_int ) )
            {
                level.autotests.test_runtime.ignore_cleanup = 0;
                utility::flag_set( "test_canceled" );
                utility::flag_set( "test_finished" );
            }
            
            setdvar( @"scr_autotest_cancel", "" );
        }
        
        wait 1;
    }
}

// Namespace autotests
// Params 0, eflags: 0x4
// Checksum 0x17e79fb, Offset: 0x1da7
// Size: 0x90
function private function_c8e7ab8960e3e0ef()
{
    if ( level.autotests.test_runtime )
    {
        if ( !isdefined( level.autotests.test_runtime.result_int ) )
        {
            level.autotests.test_runtime.ignore_cleanup = 0;
            utility::flag_set( "test_finished" );
            return;
        }
        
        if ( !level.autotests.test_runtime.cleaned_up )
        {
            runtime_cleanup();
        }
    }
}

// Namespace autotests
// Params 1
// Checksum 0x24b8802a, Offset: 0x1e3f
// Size: 0x4e
function function_b189f3c3d4ebcbfb( test_cases )
{
    var_6819e2afcb698421 = [];
    
    for ( i = 0; i < test_cases.size ; i++ )
    {
        var_6819e2afcb698421[ var_6819e2afcb698421.size ] = test_cases[ i ].result_int;
    }
    
    return function_1476fcd649055db( var_6819e2afcb698421 );
}

// Namespace autotests
// Params 1
// Checksum 0xd2172696, Offset: 0x1e96
// Size: 0x95
function function_1476fcd649055db( var_6819e2afcb698421 )
{
    result_count = var_6819e2afcb698421.size;
    
    if ( result_count == 0 )
    {
        return 4;
    }
    
    all_equal = 1;
    
    for ( i = 1; i < result_count ; i++ )
    {
        if ( var_6819e2afcb698421[ i - 1 ] != var_6819e2afcb698421[ i ] )
        {
            all_equal = 0;
            break;
        }
    }
    
    if ( all_equal )
    {
        return var_6819e2afcb698421[ 0 ];
    }
    
    highest_priority_result = var_6819e2afcb698421[ 0 ];
    
    for ( i = 1; i < result_count ; i++ )
    {
        highest_priority_result = get_highest_priority_result( var_6819e2afcb698421[ i ], highest_priority_result );
    }
    
    return highest_priority_result;
}

// Namespace autotests
// Params 2
// Checksum 0xc7ebd2ab, Offset: 0x1f34
// Size: 0x49
function get_highest_priority_result( result, other_result )
{
    result_priority = get_result_priority( result );
    other_result_priority = get_result_priority( other_result );
    return result_priority >= other_result_priority ? result : other_result;
}

// Namespace autotests
// Params 1
// Checksum 0xb87006f4, Offset: 0x1f86
// Size: 0xb6
function get_result_priority( test_result_int )
{
    switch ( test_result_int )
    {
        case 10:
        case -1:
            return 0;
        case 0:
        case 5:
            return 1;
        case 1:
            return 2;
        case 2:
        case 3:
        case 6:
        case 8:
            return 3;
        case 4:
        case 7:
            return 4;
        default:
            return 0;
    }
}

// Namespace autotests
// Params 1
// Checksum 0x74af55e, Offset: 0x2044
// Size: 0x87
function function_da7389a0e24bd0cc( test_result_int )
{
    switch ( test_result_int )
    {
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case -2:
            return 1;
        default:
            return 0;
    }
}

// Namespace autotests
// Params 2
// Checksum 0x40f2d538, Offset: 0x20d3
// Size: 0xfe
function setup_thread( setup_function, var_a1bbdb043be1f7b0 )
{
    level endon( #"end_setup" );
    utility::flag_clear( "setup_finished" );
    
    if ( !level.autotests.test_runtime.ignore_setup )
    {
        level.autotests.stateisvalid = level.autotests.test_runtime [[ setup_function ]]();
    }
    
    if ( utility::flag( "test_assert" ) || utility::flag( "test_finished" ) )
    {
        level.autotests.stateisvalid = 0;
    }
    
    if ( level.autotests.stateisvalid && var_a1bbdb043be1f7b0 )
    {
        level.autotests.stateisvalid = level.autotests.test_runtime [[ var_a1bbdb043be1f7b0 ]]();
    }
    
    utility::flag_set( "setup_finished" );
}

// Namespace autotests
// Params 0
// Checksum 0x19467d0b, Offset: 0x21d9
// Size: 0x26, Type: bool
function function_5c8c87763724c132()
{
    if ( level.players.size > 0 )
    {
        return true;
    }
    else
    {
        level waittill( #"player_spawned" );
    }
    
    return true;
}

/#

    // Namespace autotests
    // Params 0, eflags: 0xc
    // Checksum 0xea775c34, Offset: 0x2208
    // Size: 0x2b2, Type: dev
    function private function_3313b86577fd7249()
    {
        self notify( #"hash_fecf2d755182fa22" );
        self endon( #"hash_fecf2d755182fa22" );
        enabled = getdvarint( @"hash_9b96770c4ca977d9", 0 );
        
        while ( enabled )
        {
            if ( level.autotests.customtests.results.size > 0 )
            {
                disable_hud_prints = level.autotests.test_runtime.disable_hud_prints;
                
                if ( disable_hud_prints )
                {
                    wait 2;
                    continue;
                }
                
                xpos = getdvarint( @"hash_aa14ea8c850eb271", 400 );
                ypos = 160;
                yspace = 35;
                size = 2;
                printtoscreen2d( xpos, ypos, "<dev string:x235>" + level.autotests.customtests.results.size + "<dev string:x237>" + get_current_test_name(), ( 1, 1, 1 ), 2 );
                ypos += yspace;
                test_cases = function_47d83c11a21b624e();
                end_index = test_cases.size - 1;
                var_ca99c6e6aa700719 = 6;
                current_index = end_index - var_ca99c6e6aa700719;
                
                if ( current_index < 0 )
                {
                }
                
                for ( current_index = 0; current_index <= end_index ; current_index++ )
                {
                    case_result = test_cases[ current_index ];
                    test_text = function_332c11e6bdc96288( case_result ) + case_result.var_6709691282a42b2b + ( case_result.asset.size > 0 ? "<dev string:x235>" + case_result.asset + "<dev string:x237>" : "<dev string:x239>" );
                    printtoscreen2d( xpos, ypos, test_text, function_8997883e52c2736e( case_result ), size );
                    ypos += yspace;
                }
                
                if ( level.autotests.customtests.function_names.size > 0 )
                {
                    foreach ( function_name in level.autotests.customtests.function_names )
                    {
                        printtoscreen2d( xpos, ypos, "<dev string:x23a>" + function_name, ( 0.5, 0.5, 0.5 ), size );
                        ypos += yspace;
                    }
                }
                
                waitframe();
            }
        }
    }

#/

// Namespace autotests
// Params 3
// Checksum 0xf3351457, Offset: 0x24c2
// Size: 0x1f6
function test_start( test_name, test_index, total_tests )
{
    level notify( #"autotest_start", test_name );
    print_both( "[TEST]Started test: " + test_name );
    sendautotestmsg( "event|start|name|" + test_name );
    parameters_string = "";
    
    if ( total_tests && test_index >= 0 )
    {
        test_num = test_index + 1;
        parameters_string = "[" + test_num + "/" + total_tests + "]";
    }
    else
    {
        parameters_string = "[" + level.autotests.customtests.results.size + "]";
    }
    
    function_3d4fed8635235eb3( parameters_string + test_name, "[TEST]" );
    level.autotests.customtests.var_9f7ebd899c36269d = gettime();
    utility::flag_clear( "test_canceled" );
    utility::flag_clear( "test_assert" );
    utility::flag_clear( "test_finished" );
    dlog_recordevent( "dlog_event_automation_gsctest_start", [ "test_name", test_name, "test_additional_info", get_mapname() ] );
    function_b26bb8d4484e1426();
    level.autotests.customtests.results[ level.autotests.customtests.results.size ] = [];
    level.autotests.customtests.testnames[ level.autotests.customtests.testnames.size ] = test_name;
    
    /#
        thread function_3313b86577fd7249();
        
        if ( getdvarint( @"hash_736ada3bc2c6d246", 0 ) == 1 )
        {
            print_both( "<dev string:x249>" );
            adddebugcommand( "<dev string:x288>" );
        }
    #/
}

// Namespace autotests
// Params 2
// Checksum 0xd8f39ca4, Offset: 0x26c0
// Size: 0x1e
function function_9c128dad47ab53ab( test_name_string, test_result_int )
{
    return function_e496a326e5d58a25( test_name_string, test_result_int );
}

// Namespace autotests
// Params 3
// Checksum 0x30756960, Offset: 0x26e7
// Size: 0x1a2
function test_finish( test_name_string, test_result_int, test )
{
    if ( !isdefined( test_result_int ) )
    {
        assertmsg( "<dev string:x298>" + ( test_name_string ?? "<dev string:x239>" ) + "<dev string:x2a9>" );
        test_result_int = 1;
    }
    else if ( !isdefined( test ) )
    {
        if ( test_result_int == 0 )
        {
            test_result_int = -2;
        }
    }
    else
    {
        latest_results = function_47d83c11a21b624e();
        var_6602498607c739aa = istrue( test.var_fa6302d97c314ff6 );
        
        if ( ( var_6602498607c739aa || latest_results.size > 0 ) && !function_da7389a0e24bd0cc( test_result_int ) )
        {
            var_2a06201d70dbf36a = function_b189f3c3d4ebcbfb( latest_results );
            test_result_int = get_highest_priority_result( var_2a06201d70dbf36a, test_result_int );
        }
    }
    
    test_result_int = function_9c128dad47ab53ab( test_name_string, test_result_int );
    utility::flag_set( "test_finished" );
    test_duration_seconds = ( gettime() - level.autotests.customtests.var_9f7ebd899c36269d ) / 1000;
    result_string = test_result_to_string( test_result_int );
    print_both( "[TEST]Finished test: " + test_name_string + " result " + result_string + " in " + test_duration_seconds + " seconds" );
    sendautotestmsg( "event|end|name|" + test_name_string + "|test_case_result|" + test_result_int );
    dlog_recordevent( "dlog_event_automation_gsctest_end", [ "test_name", test_name_string, "test_duration_seconds", test_duration_seconds, "test_result", result_string, "test_additional_info", get_mapname() ] );
}

// Namespace autotests
// Params 1
// Checksum 0xf1b8ef64, Offset: 0x2891
// Size: 0x20
function function_526731d23b8f63b0( text )
{
    return isxhash( text ) ? text : getxhash( text );
}

// Namespace autotests
// Params 1
// Checksum 0xd87f7f7b, Offset: 0x28ba
// Size: 0x16a, Type: bool
function function_2c1ef9ead730c506( test_name )
{
    test_setup = function_418560fba4a02363( test_name );
    
    if ( isdefined( test_setup.test ) && isdefined( test_setup.test.trigger_func ) )
    {
        function_f37f1566a230a941( test_setup );
        return true;
    }
    else
    {
        list_xhash = isxhash( test_name ) ? test_name : hashcat( %"hash_4ccbd4c240f98b31", test_name );
        testlist = getscriptbundle( list_xhash );
        
        if ( isdefined( testlist ) )
        {
            foreach ( test in testlist.autotest_list )
            {
                test_ref = getscriptbundlefieldvalue( test.bundle, #"testref" );
                test_setup.test_xhash = test_ref;
                test_setup.test = level.autotests.tests[ test_ref ];
                function_f37f1566a230a941( test_setup );
                wait 1;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace autotests
// Params 0
// Checksum 0x963ab9af, Offset: 0x2a2d
// Size: 0xab
function function_9d33f5ee14d8c65d()
{
    level endon( #"end_test" );
    println( "<dev string:x2db>" );
    test = level.autotests.test_runtime.test;
    level.autotests.test_runtime.result_int = undefined;
    level.autotests.test_runtime.result_int = level.autotests.test_runtime [[ test.trigger_func ]]();
    utility::flag_set( "test_finished" );
}

// Namespace autotests
// Params 2, eflags: 0x4
// Checksum 0x894176a6, Offset: 0x2ae0
// Size: 0x71, Type: bool
function private function_297c63dd38a10bbb( test, parsed_params )
{
    if ( !isdefined( test.var_e64e8709107d3e9c ) )
    {
        return false;
    }
    
    needs_restart = test [[ test.var_e64e8709107d3e9c ]]( parsed_params );
    
    if ( needs_restart )
    {
        print_both( "[TEST] Startup parameters triggered map restart for " + test.name );
        adddebugcommand( "map_restart" );
        wait 5;
        return true;
    }
    
    return false;
}

// Namespace autotests
// Params 1
// Checksum 0x13f308f4, Offset: 0x2b5a
// Size: 0x1e7
function function_418560fba4a02363( parameter )
{
    test_setup = spawnstruct();
    parameters = function_4c9832f972f3a1aa( parameter );
    test_name_split = strtok( parameters[ 0 ], "&" );
    test_setup.test_name = test_name_split[ 0 ];
    test_setup.test_xhash = function_526731d23b8f63b0( test_setup.test_name );
    test_setup.test = level.autotests.tests[ test_setup.test_xhash ];
    parameters[ 0 ] = undefined;
    
    if ( isint( 0 ) )
    {
        function_cdc669dbc8ea2101( parameters );
    }
    
    test_setup.parameters = parameters;
    test_setup.parsed_params = parse_test_params( parameters );
    test_name_split[ 0 ] = undefined;
    
    if ( isint( 0 ) )
    {
        function_cdc669dbc8ea2101( test_name_split );
    }
    
    test_setup.datasets = test_name_split;
    
    if ( test_setup.datasets.size == 0 )
    {
        test_xhash = function_526731d23b8f63b0( test_setup.test_name );
        bundle = get_test_bundle( test_xhash );
        
        if ( bundle )
        {
            foreach ( dataset in bundle.datasets )
            {
                test_setup.datasets[ test_setup.datasets.size ] = dataset.ref;
            }
        }
    }
    
    test_setup.var_875fc462a0bca171 = function_32c5b799e250baf0( test_setup.datasets );
    return test_setup;
}

// Namespace autotests
// Params 1
// Checksum 0x9693202b, Offset: 0x2d4a
// Size: 0x1d
function function_4c9832f972f3a1aa( parameter )
{
    return strtok( parameter, "+" + "$" );
}

// Namespace autotests
// Params 1
// Checksum 0xce9f643a, Offset: 0x2d70
// Size: 0x136
function function_32c5b799e250baf0( entries )
{
    result = spawnstruct();
    result.positional = [];
    result.named = [];
    result.paramsuffix = "";
    
    if ( !isdefined( entries ) )
    {
        return result;
    }
    
    foreach ( entry in entries )
    {
        kv = strtok( entry, "=" );
        
        if ( kv.size >= 2 )
        {
            result.named[ kv[ 0 ] ] = kv[ 1 ];
            result.paramsuffix += "$" + kv[ 0 ] + "=" + kv[ 1 ];
            continue;
        }
        
        result.positional[ result.positional.size ] = entry;
    }
    
    return result;
}

// Namespace autotests
// Params 1
// Checksum 0x9636ec2c, Offset: 0x2eaf
// Size: 0x22
function parse_test_params( parameters )
{
    result = function_32c5b799e250baf0( parameters );
    return result;
}

// Namespace autotests
// Params 1
// Checksum 0x71ea14d2, Offset: 0x2eda
// Size: 0x26b
function function_f37f1566a230a941( test_setup )
{
    test = test_setup.test;
    
    if ( function_39ea215b37d43eea() )
    {
        test_start( test.name );
        test_finish( get_current_test_name(), 5, test );
        return;
    }
    
    if ( function_297c63dd38a10bbb( test, test_setup.parsed_params ) )
    {
        return 1;
    }
    
    if ( level.autotests.test_runtime && function_21f7684714a50f7c( test ) && !level.autotests.test_runtime.cleaned_up )
    {
        runtime_cleanup();
    }
    
    if ( test_setup.parameters.size > 0 )
    {
        skip_setup = level.autotests.test_runtime && !function_21f7684714a50f7c( test ) && !level.autotests.test_runtime.cleaned_up;
        skip_cleanup = getdvarint( @"hash_1071f3d5b9959481", 0 );
        run_setup = function_c6d65df7856c5af( test, test_setup.parameters, test_setup.parsed_params, test_setup.datasets, skip_setup, skip_cleanup, undefined, undefined );
        function_120552b5537bff8c( run_setup );
        return;
    }
    
    parameters = get_test_parameters( test, test_setup );
    
    if ( isdefined( parameters ) )
    {
        if ( parameters.size == 0 )
        {
            test_start( test.name );
            test_finish( get_current_test_name(), 5, test );
            return;
        }
        
        for ( index = 0; index < parameters.size ; index++ )
        {
            parameter = parameters[ index ];
            skip_setup = index != 0;
            skip_cleanup = index != parameters.size - 1;
            split_parameters = function_4c9832f972f3a1aa( parameter );
            var_f42131b306f25ae9 = parse_test_params( split_parameters );
            run_setup = function_c6d65df7856c5af( test, split_parameters, var_f42131b306f25ae9, test_setup.datasets, skip_setup, skip_cleanup, index, parameters.size );
            function_120552b5537bff8c( run_setup );
            
            if ( utility::flag( "test_canceled" ) )
            {
                runtime_cleanup();
                break;
            }
        }
        
        return;
    }
    
    run_setup = function_c6d65df7856c5af( test, undefined, parse_test_params( undefined ), undefined, undefined, undefined, undefined, undefined );
    function_120552b5537bff8c( run_setup );
}

// Namespace autotests
// Params 8, eflags: 0x4
// Checksum 0xe0f0eead, Offset: 0x314d
// Size: 0xcd
function private function_c6d65df7856c5af( test, parameters, parsed_params, datasets, ignore_setup, ignore_cleanup, test_index, total_tests )
{
    run_setup = spawnstruct();
    run_setup.test = test;
    run_setup.parameters = parameters;
    run_setup.parsed_params = parsed_params;
    run_setup.datasets = datasets;
    run_setup.ignore_setup = ignore_setup;
    run_setup.ignore_cleanup = ignore_cleanup;
    run_setup.test_index = test_index;
    run_setup.total_tests = total_tests;
    return run_setup;
}

// Namespace autotests
// Params 1, eflags: 0x4
// Checksum 0x6263cbbb, Offset: 0x3223
// Size: 0x11b
function private get_test_name_internal( run_setup )
{
    testname = run_setup.test.name;
    
    if ( run_setup.datasets || run_setup.parameters )
    {
        testname += "[";
        
        if ( isdefined( run_setup.datasets ) && run_setup.datasets.size > 0 )
        {
            testname += "&" + run_setup.datasets[ 0 ];
        }
        
        if ( isdefined( run_setup.parameters ) && run_setup.parameters.size > 0 )
        {
            testname += "$" + as_string( run_setup.parameters[ 0 ] );
            
            for ( i = 1; i < run_setup.parameters.size ; i++ )
            {
                testname += "$" + as_string( run_setup.parameters[ i ] );
            }
        }
        
        testname += "]";
    }
    
    return testname;
}

// Namespace autotests
// Params 1, eflags: 0x4
// Checksum 0x9f3d7138, Offset: 0x3347
// Size: 0x124
function private function_120552b5537bff8c( run_setup )
{
    test = run_setup.test;
    parameters = run_setup.parameters;
    parsed_params = run_setup.parsed_params;
    datasets = run_setup.datasets;
    ignore_setup = run_setup.ignore_setup;
    ignore_cleanup = run_setup.ignore_cleanup;
    test_index = run_setup.test_index;
    total_tests = run_setup.total_tests;
    testname = get_test_name_internal( run_setup );
    test_start( testname, test_index, total_tests );
    function_2aed5ef1cab442f2( test );
    InvalidOpCode( 0x44 );
    // Unknown operator ( 0x44, t11, Black Ops 7 )
}

// Namespace autotests
// Params 1, eflags: 0x4
// Checksum 0x227e43cc, Offset: 0x38b8
// Size: 0xa1
function private function_a79f786388e257d8( test )
{
    if ( !isdefined( test.var_842c74925f253023 ) )
    {
        return;
    }
    
    original_callback = level.onmaprestart;
    level.autotests.test_runtime.var_422d1257ba7b7a66 = original_callback;
    level.autotests.test_runtime.var_1d93cbeafcb731e4 = test.var_842c74925f253023;
    level.onmaprestart = &onmaprestart;
    print_both( "[TEST] onMapRestart hook installed for " + test.name );
}

// Namespace autotests
// Params 0, eflags: 0x4
// Checksum 0x85bd01b0, Offset: 0x3961
// Size: 0x16
function private onmaprestart()
{
    InvalidOpCode( 0x44, 1 );
    // Unknown operator ( 0x44, t11, Black Ops 7 )
}

// Namespace autotests
// Params 0, eflags: 0x4
// Checksum 0x5ea634c, Offset: 0x39de
// Size: 0x55
function private function_857c95e0166e27d3()
{
    original_callback = level.autotests.test_runtime.var_422d1257ba7b7a66;
    
    if ( isdefined( original_callback ) )
    {
        level.onmaprestart = original_callback;
    }
    else
    {
        level.onmaprestart = undefined;
    }
    
    print_both( "[TEST] onMapRestart hook restored/cleared" );
}

// Namespace autotests
// Params 0, eflags: 0x4
// Checksum 0x9312505f, Offset: 0x3a3b
// Size: 0xd4
function private runtime_cleanup()
{
    function_857c95e0166e27d3();
    cleanup_function = level.autotests.test_runtime.test.cleanup_function;
    
    if ( cleanup_function )
    {
        println( "<dev string:x2fc>" );
        push_function( "Cleaning up" );
        test_result_int = level.autotests.test_runtime [[ cleanup_function ]]() ?? 0;
        test_result_int = function_e496a326e5d58a25( "Cleaning up", test_result_int, undefined, undefined, "scripts/autotests/autotests.gsc", 1304 );
        pop_function( "Cleaning up" );
        test_assert_return( test_result_int );
    }
    
    level.autotests.test_runtime.cleaned_up = 1;
    cleanup_dvars();
}

// Namespace autotests
// Params 2
// Checksum 0xab83dc05, Offset: 0x3b17
// Size: 0xb1
function function_1363944e71b914cd( setup_function, var_a1bbdb043be1f7b0 )
{
    level thread setup_thread( setup_function, var_a1bbdb043be1f7b0 );
    setuptimeout = getdvarint( @"hash_2bb0e3f2696dfe42", 240 );
    utility::flag_wait_or_timeout( "setup_finished", setuptimeout );
    
    if ( !utility::flag( "setup_finished" ) )
    {
        level notify( #"end_setup" );
        level.autotests.stateisvalid = 0;
        test_finish( get_current_test_name(), 2 );
        return;
    }
    
    if ( !level.autotests.stateisvalid )
    {
        test_finish( get_current_test_name(), 3 );
    }
}

// Namespace autotests
// Params 0
// Checksum 0xed54923b, Offset: 0x3bd0
// Size: 0x100, Type: bool
function function_39ea215b37d43eea()
{
    maxfail = getdvarint( @"scr_autotest_maxfail", -1 );
    
    if ( maxfail >= 0 )
    {
        fail_count = 0;
        
        foreach ( test_cases in level.autotests.customtests.results )
        {
            combined_result = function_b189f3c3d4ebcbfb( test_cases );
            
            if ( combined_result == 1 || combined_result == 6 )
            {
                fail_count++;
            }
        }
        
        if ( fail_count > maxfail )
        {
            print_both( "[TEST]failcount (" + fail_count + ") > scr_autotest_maxfail(" + maxfail + "), skipping test" );
            return true;
        }
    }
    
    return false;
}

// Namespace autotests
// Params 1
// Checksum 0x12ce0dd3, Offset: 0x3cd9
// Size: 0x40
function print_both( text )
{
    print_value = getdvarint( @"hash_15399c6e73cea7e0", 1 );
    
    if ( print_value == 1 )
    {
        println( text );
        iprintln( text );
    }
}

// Namespace autotests
// Params 1
// Checksum 0x811b561d, Offset: 0x3d21
// Size: 0x3d
function function_332c11e6bdc96288( test_case_result )
{
    result_string = test_result_to_string( test_case_result.result_int );
    return "[" + getsubstr( result_string, 12 ) + "]";
}

// Namespace autotests
// Params 1
// Checksum 0x5eb90181, Offset: 0x3d67
// Size: 0x77
function function_8997883e52c2736e( test_case_result )
{
    if ( test_case_result.result_int == 6 )
    {
        return ( 1, 0, 0 );
    }
    
    if ( test_case_result.result_int == 5 )
    {
        return ( 1, 1, 0 );
    }
    
    return test_case_result.result_int == 0 ? ( 1, 1, 1 ) : ( 0.86, 0.26, 0.15 );
}

// Namespace autotests
// Params 1
// Checksum 0x8c0856cb, Offset: 0x3de7
// Size: 0xf8
function function_503a4695669059ba( test_case_result )
{
    text = "[TEST]" + function_332c11e6bdc96288( test_case_result );
    text += "[" + vartostring( test_case_result.lhs ) + "][" + vartostring( test_case_result.rhs ) + "]";
    
    if ( test_case_result.asset.size > 0 )
    {
        text += "[" + test_case_result.asset + "]";
    }
    
    text += test_case_result.var_6709691282a42b2b;
    
    if ( !function_5a030dd4450c1448( test_case_result.result_int ) )
    {
        if ( test_case_result.file.size > 0 )
        {
            text += "[" + test_case_result.file + ":" + test_case_result.line + "]";
        }
    }
    
    logstring( text );
}

// Namespace autotests
// Params 1
// Checksum 0x1accea9f, Offset: 0x3ee7
// Size: 0xe4
function function_32a72ac8d0486823( test_case_result )
{
    test_name = test_case_result.var_6709691282a42b2b;
    var_edce4594a55c83f3 = "event|result" + "|name|" + test_name + "|test_case_result|" + test_case_result.result_int + "|mapname|" + test_case_result.mapname + "|mode|" + test_case_result.mode;
    
    if ( test_case_result.file )
    {
        var_edce4594a55c83f3 += "|file|" + test_case_result.file;
    }
    
    if ( test_case_result.line )
    {
        var_edce4594a55c83f3 += "|line|" + test_case_result.line;
    }
    
    if ( test_case_result.asset )
    {
        var_edce4594a55c83f3 += "|asset|" + test_case_result.asset;
    }
    
    sendautotestmsg( var_edce4594a55c83f3 );
}

// Namespace autotests
// Params 1
// Checksum 0x72115668, Offset: 0x3fd3
// Size: 0x2d
function function_8829c20450ba3a5( test_case_result )
{
    function_503a4695669059ba( test_case_result );
    function_3d4fed8635235eb3( test_case_result.var_6709691282a42b2b, function_332c11e6bdc96288( test_case_result ) );
}

// Namespace autotests
// Params 1
// Checksum 0x61691136, Offset: 0x4008
// Size: 0x27
function function_c0b1b9071103a81c( test_case_result )
{
    test_case_result_add( test_case_result );
    function_32a72ac8d0486823( test_case_result );
    function_8829c20450ba3a5( test_case_result );
}

// Namespace autotests
// Params 1
// Checksum 0x418d0a82, Offset: 0x4037
// Size: 0x2b
function report_info( text )
{
    test_case_result = test_case_result_create( text, 10 );
    function_c0b1b9071103a81c( test_case_result );
}

// Namespace autotests
// Params 1
// Checksum 0xcafd7ae6, Offset: 0x406a
// Size: 0x25
function take_screenshot( name = "gsctest_screenshot" )
{
    function_3abe1f9532a7887b( "screenshotJpeg " + name );
}

// Namespace autotests
// Params 6
// Checksum 0x752bff2c, Offset: 0x4097
// Size: 0xe1
function test_case_result_create( var_6709691282a42b2b, test_result_int, lhs, rhs, file, line )
{
    test_case_result = spawnstruct();
    test_case_result.var_6709691282a42b2b = var_6709691282a42b2b;
    test_case_result.result_int = test_result_int;
    test_case_result.lhs = lhs;
    test_case_result.rhs = rhs;
    test_case_result.asset = get_current_asset_name();
    test_case_result.mapname = get_mapname();
    test_case_result.mode = getsubstr( test_case_result.mapname, 0, 2 );
    test_case_result.file = file;
    test_case_result.line = line;
    return test_case_result;
}

// Namespace autotests
// Params 1
// Checksum 0xd1e89a26, Offset: 0x4181
// Size: 0x8f
function test_case_result_add( test_case_result )
{
    level.autotests.customtests.results[ level.autotests.customtests.results.size - 1 ][ level.autotests.customtests.results[ level.autotests.customtests.results.size - 1 ].size ] = test_case_result;
}

// Namespace autotests
// Params 0
// Checksum 0x58c9ef35, Offset: 0x4218
// Size: 0x41
function function_47d83c11a21b624e()
{
    return level.autotests.customtests.results[ level.autotests.customtests.results.size - 1 ];
}

// Namespace autotests
// Params 0
// Checksum 0xac807be1, Offset: 0x4262
// Size: 0x1c
function function_6f677e2957cdc018()
{
    test_cases = function_47d83c11a21b624e();
    return test_cases[ test_cases.size - 1 ];
}

// Namespace autotests
// Params 0
// Checksum 0x930b2136, Offset: 0x4287
// Size: 0x57
function function_75c5666e6825d387()
{
    test_cases = function_47d83c11a21b624e();
    
    for ( i = test_cases.size - 1; i >= 0 ; i-- )
    {
        test_case = test_cases[ i ];
        
        if ( !function_5a030dd4450c1448( test_case.result_int ) )
        {
            return test_case;
        }
    }
}

// Namespace autotests
// Params 6
// Checksum 0x1f73f3de, Offset: 0x42e7
// Size: 0x51
function function_fa8a8f2a8961ec0b( var_6709691282a42b2b, test_result_bool, lhs, rhs, file, line )
{
    return function_e496a326e5d58a25( var_6709691282a42b2b, test_result_bool ? 0 : 1, lhs, rhs, file, line );
}

// Namespace autotests
// Params 6
// Checksum 0x45684182, Offset: 0x4341
// Size: 0xa8
function function_e496a326e5d58a25( var_6709691282a42b2b, test_result_int, lhs, rhs, file, line )
{
    if ( !isdefined( test_result_int ) )
    {
        assertmsg( "<dev string:x31c>" );
        test_result_int = 1;
    }
    
    if ( function_b26bb8d4484e1426() )
    {
        test_result_int = get_highest_priority_result( test_result_int, 6 );
    }
    
    test_case_result = test_case_result_create( var_6709691282a42b2b, test_result_int, lhs, rhs, file, line );
    
    if ( self.var_8b1ba281d4d11a1f )
    {
        [[ self.var_8b1ba281d4d11a1f ]]( test_case_result );
    }
    else
    {
        function_c0b1b9071103a81c( test_case_result );
    }
    
    return test_result_int;
}

// Namespace autotests
// Params 0
// Checksum 0x19bee34, Offset: 0x43f2
// Size: 0xc9
function get_name_path()
{
    path = get_current_test_name();
    
    if ( isdefined( level.autotests.customtests.function_names ) )
    {
        foreach ( name in level.autotests.customtests.function_names )
        {
            path += "/";
            path += name;
        }
    }
    
    return path;
}

// Namespace autotests
// Params 1
// Checksum 0x6119cb13, Offset: 0x44c4
// Size: 0x72
function push_function( test_name )
{
    level.autotests.customtests.function_names[ level.autotests.customtests.function_names.size ] = test_name;
    test_case_result = { #result_int:9 };
    function_3d4fed8635235eb3( test_name, function_332c11e6bdc96288( test_case_result ) );
}

// Namespace autotests
// Params 1
// Checksum 0xcfbcbdd9, Offset: 0x453e
// Size: 0x4b
function pop_function( test_name )
{
    level.autotests.customtests.function_names[ level.autotests.customtests.function_names.size - 1 ] = undefined;
}

// Namespace autotests
// Params 0
// Checksum 0x24d8f7ef, Offset: 0x4591
// Size: 0x23
function function_ee47060132a48e()
{
    function_6b67f05524b791ef();
    level.autotests.var_299b18fe7755901b = test_errorcount();
}

// Namespace autotests
// Params 0
// Checksum 0xdd967565, Offset: 0x45bc
// Size: 0x21
function function_6b67f05524b791ef()
{
    level.autotests.customtests.function_names = [];
}

// Namespace autotests
// Params 0
// Checksum 0x95b35e2, Offset: 0x45e5
// Size: 0x41
function get_current_test_name()
{
    return level.autotests.customtests.testnames[ level.autotests.customtests.testnames.size - 1 ];
}

// Namespace autotests
// Params 0
// Checksum 0xbeca5343, Offset: 0x462f
// Size: 0xd8
function ensure_datastructures()
{
    if ( isdefined( level.autotests ) )
    {
        return;
    }
    
    level.autotests = spawnstruct();
    level.autotests.tests = [];
    level.autotests.customtests = spawnstruct();
    level.autotests.customtests.results = [];
    level.autotests.customtests.testnames = [];
    function_ee47060132a48e();
    level.autotests.customtests.var_1d8d80170c7591b = [];
    level.autotests.var_fc25b047e401d99 = [];
    level.autotests.var_dc5c2d60123d0b4f = [];
}

// Namespace autotests
// Params 1
// Checksum 0xbc3a710a, Offset: 0x470f
// Size: 0x7a
function function_2aed5ef1cab442f2( test )
{
    if ( !level.autotests.test_runtime || function_21f7684714a50f7c( test ) )
    {
        level.autotests.test_runtime = spawnstruct();
        level.autotests.test_runtime.test = test;
    }
    
    return level.autotests.test_runtime;
}

// Namespace autotests
// Params 1
// Checksum 0xa8775f7a, Offset: 0x4792
// Size: 0x2c, Type: bool
function function_21f7684714a50f7c( test )
{
    return level.autotests.test_runtime.test != test;
}

// Namespace autotests
// Params 0
// Checksum 0x34d9386, Offset: 0x47c7
// Size: 0x46
function get_current_asset_name()
{
    if ( isdefined( level.autotests.test_runtime.asset_name ) )
    {
        return level.autotests.test_runtime.asset_name;
    }
    
    return "";
}

// Namespace autotests
// Params 1
// Checksum 0xf6626c46, Offset: 0x4816
// Size: 0x44
function as_string( var_4148de87fbe2618c )
{
    if ( !isdefined( var_4148de87fbe2618c ) )
    {
        return "(undefined)";
    }
    
    if ( isstring( var_4148de87fbe2618c ) )
    {
        return var_4148de87fbe2618c;
    }
    
    hashstring = getxhashhexname( var_4148de87fbe2618c );
    
    /#
        hashstring = getxhashsourcename( var_4148de87fbe2618c );
    #/
    
    return hashstring;
}

// Namespace autotests
// Params 1
// Checksum 0x52b86225, Offset: 0x4863
// Size: 0x48
function set_current_asset_name( asset_name )
{
    level.autotests.test_runtime.asset_name = as_string( asset_name );
    setdvar( @"scr_autotest_context", as_string( asset_name ) );
}

// Namespace autotests
// Params 1
// Checksum 0xe7bb32e4, Offset: 0x48b3
// Size: 0x62
function function_676f527a957a9500( xhashname )
{
    autotest_list_struct = level.autotests.var_dc5c2d60123d0b4f[ xhashname ];
    
    if ( !isdefined( autotest_list_struct ) )
    {
        autotest_list_struct = spawnstruct();
        autotest_list_struct.autotest_list = [];
        level.autotests.var_dc5c2d60123d0b4f[ xhashname ] = autotest_list_struct;
    }
    
    return autotest_list_struct;
}

// Namespace autotests
// Params 1
// Checksum 0x470da065, Offset: 0x491e
// Size: 0x33, Type: bool
function function_5a030dd4450c1448( test_result_int )
{
    return !isdefined( test_result_int ) || test_result_int == 0 || test_result_int == 5 || test_result_int == 10 || test_result_int == 9;
}

// Namespace autotests
// Params 1
// Checksum 0x509d4d44, Offset: 0x495a
// Size: 0x54
function test_assert_return( test_result_int )
{
    if ( getdvarint( @"hash_aa5c2e28a06af46", 1 ) != 1 )
    {
        return;
    }
    
    if ( !function_5a030dd4450c1448( test_result_int ) )
    {
        utility::flag_set( "test_assert" );
        utility::flag_set( "test_finished" );
        waitframe();
        assertmsg( "<dev string:x384>" );
    }
}

// Namespace autotests
// Params 0
// Checksum 0xb90b6503, Offset: 0x49b6
// Size: 0x49, Type: bool
function function_561cb32cd7469145()
{
    local_mode = level.autotests.test_runtime.assert_mode;
    
    if ( isdefined( local_mode ) )
    {
        return ( local_mode == 2 );
    }
    
    return getdvarint( @"hash_aa5c2e28a06af46", 1 ) == 2;
}

// Namespace autotests
// Params 5
// Checksum 0x7bd55144, Offset: 0x4a08
// Size: 0x41
function function_e50d1006e5d65c04( test_name, lhs, rhs, file, line )
{
    return function_fa8a8f2a8961ec0b( test_name, lhs == rhs, lhs, rhs, file, line );
}

// Namespace autotests
// Params 5
// Checksum 0x82fb5cf7, Offset: 0x4a52
// Size: 0x41
function function_e4dbfc06e59fa0cb( test_name, lhs, rhs, file, line )
{
    return function_fa8a8f2a8961ec0b( test_name, lhs != rhs, lhs, rhs, file, line );
}

// Namespace autotests
// Params 5
// Checksum 0x3989c748, Offset: 0x4a9c
// Size: 0x41
function function_e5040106e5cc1c59( test_name, lhs, rhs, file, line )
{
    return function_fa8a8f2a8961ec0b( test_name, lhs > rhs, lhs, rhs, file, line );
}

// Namespace autotests
// Params 5
// Checksum 0x5339e7b9, Offset: 0x4ae6
// Size: 0x41
function function_e5041006e5cc3d56( test_name, lhs, rhs, file, line )
{
    return function_fa8a8f2a8961ec0b( test_name, lhs >= rhs, lhs, rhs, file, line );
}

// Namespace autotests
// Params 5
// Checksum 0xda7d1e81, Offset: 0x4b30
// Size: 0x41
function function_e4e4ff06e5a9c612( test_name, lhs, rhs, file, line )
{
    return function_fa8a8f2a8961ec0b( test_name, lhs < rhs, lhs, rhs, file, line );
}

// Namespace autotests
// Params 5
// Checksum 0xb0cd3e74, Offset: 0x4b7a
// Size: 0x41
function function_e4e51006e5a9eb75( test_name, lhs, rhs, file, line )
{
    return function_fa8a8f2a8961ec0b( test_name, lhs <= rhs, lhs, rhs, file, line );
}

// Namespace autotests
// Params 4
// Checksum 0xa7204ed, Offset: 0x4bc4
// Size: 0x37
function function_36ed835262a19e53( test_name, rhs, file, line )
{
    return function_fa8a8f2a8961ec0b( test_name, isdefined( rhs ), rhs, rhs, file, line );
}

// Namespace autotests
// Params 4
// Checksum 0x54ac7f8, Offset: 0x4c04
// Size: 0x38
function function_dbbd10e009ede41e( test_name, rhs, file, line )
{
    return function_fa8a8f2a8961ec0b( test_name, !isdefined( rhs ), rhs, rhs, file, line );
}

// Namespace autotests
// Params 4
// Checksum 0x397e8fb5, Offset: 0x4c45
// Size: 0x35
function function_d84657f448aaeef6( test_name, rhs, file, line )
{
    return function_fa8a8f2a8961ec0b( test_name, rhs, rhs, rhs, file, line );
}

// Namespace autotests
// Params 4
// Checksum 0xee079755, Offset: 0x4c83
// Size: 0x37
function function_ae5837f8e14d9b71( test_name, rhs, file, line )
{
    return function_fa8a8f2a8961ec0b( test_name, !rhs, rhs, rhs, file, line );
}

// Namespace autotests
// Params 6
// Checksum 0xc225783f, Offset: 0x4cc3
// Size: 0x6f
function test_wait_any( test_name, ent, events, timeout, file, line )
{
    result = ent utility::waittill_any_in_array_or_timeout( events, timeout );
    any_triggered = result != "timeout";
    return function_fa8a8f2a8961ec0b( test_name, any_triggered, undefined, undefined, file, line );
}

// Namespace autotests
// Params 6
// Checksum 0x78ff715f, Offset: 0x4d3b
// Size: 0x71
function test_wait_all( test_name, ent, events, timeout, file, line )
{
    result = ent utility::function_f87fb88f9c5add54( events, undefined, timeout );
    all_triggered = result != "timeout";
    return function_fa8a8f2a8961ec0b( test_name, all_triggered, undefined, undefined, file, line );
}

// Namespace autotests
// Params 2
// Checksum 0xb9870ef6, Offset: 0x4db5
// Size: 0xf8
function vartostring( var, expandarray = 1 )
{
    type = getvartype( var );
    
    switch ( type )
    {
        case #"hash_b61583709daf623":
            return "";
        case #"hash_b38a5d117ade0306":
            return _arraytostring( var, expandarray );
        case #"hash_a08ace5b3c23c762":
            return ( "(" + var[ 0 ] + "," + var[ 1 ] + "," + var[ 2 ] + ")" );
        case #"hash_3e4a6f464c850b65":
        case #"hash_4730906c2f53f03e":
            return string( var );
        case #"hash_2ac140ce3b5ea398":
            return var;
        case #"hash_83e3a4585099313a":
            return ( "$e" + var getentitynumber() );
        default:
            return ( "<" + type + ">" );
    }
}

// Namespace autotests
// Params 1
// Checksum 0x9ca6b555, Offset: 0x4eb5
// Size: 0x121
function getvartype( var )
{
    if ( !isdefined( var ) )
    {
        return "undefined";
    }
    else if ( isfunction( var ) )
    {
        return "function";
    }
    else if ( isbuiltinfunction( var ) )
    {
        return "builtin function";
    }
    else if ( isbuiltinmethod( var ) )
    {
        return "builtin method";
    }
    else if ( isanimation( var ) )
    {
        return "animation";
    }
    else if ( isarray( var ) )
    {
        return "array";
    }
    else if ( isstruct( var ) )
    {
        str = "struct";
    }
    else if ( isvector( var ) )
    {
        str = "vector";
    }
    else if ( isent( var ) )
    {
        str = "entity";
    }
    else if ( isnode( var ) )
    {
        str = "node";
    }
    else if ( isint( var ) )
    {
        str = "int";
    }
    else if ( isfloat( var ) )
    {
        str = "float";
    }
    else if ( isstring( var ) )
    {
        str = "string";
    }
    else if ( isistring( var ) )
    {
        str = "istring";
    }
    else
    {
        str = "unknown";
    }
    
    return str;
}

// Namespace autotests
// Params 2
// Checksum 0xba312e32, Offset: 0x4fdf
// Size: 0xdb
function _arraytostring( var, expandarray )
{
    str = "[ ";
    
    if ( expandarray )
    {
        first = 1;
        
        foreach ( value in var )
        {
            if ( !first )
            {
                str += ",";
            }
            else
            {
                first = 0;
            }
            
            str += vartostring( value, 0 );
        }
    }
    else
    {
        str += "<not expanded>";
    }
    
    str += " ]";
    return str;
}

// Namespace autotests
// Params 1
// Checksum 0x8d90e631, Offset: 0x50c3
// Size: 0xd1
function function_dedcdbc878ec820c( var_b7376919b97f5115 )
{
    level endon( #"end_heartbeat" );
    level endon( #"game_ended" );
    time_elapsed = 0;
    
    while ( true )
    {
        wait var_b7376919b97f5115;
        time_elapsed += var_b7376919b97f5115;
        
        if ( function_b26bb8d4484e1426() )
        {
            level.autotests.test_runtime.result_int = 6;
            utility::flag_set( "test_finished" );
            break;
        }
        
        var_63a718d91714219d = function_d84657f448aaeef6( "Keep-alive (minutes) " + time_elapsed / 60, 1, "scripts/autotests/autotests.gsc", 1867 );
        
        if ( !function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( function_561cb32cd7469145() )
            {
                return;
            }
            
            test_assert_return( var_63a718d91714219d );
        }
        
        setdvar( @"autotest_alive", 1 );
    }
}

// Namespace autotests
// Params 1
// Checksum 0x57a2e48b, Offset: 0x519c
// Size: 0x100
function test_result_to_string( test_result_int )
{
    switch ( test_result_int )
    {
        case -1:
            return "TEST_RESULT_NONE";
        case 0:
            return "TEST_RESULT_SUCCESS";
        case 1:
            return "TEST_RESULT_FAILED";
        case 2:
            return "TEST_RESULT_SETUP_TIMEOUT";
        case 3:
            return "TEST_RESULT_SETUP_FAILED";
        case 4:
            return "TEST_RESULT_TEST_NOT_FOUND";
        case 5:
            return "TEST_RESULT_SKIPPED";
        case 6:
            return "TEST_RESULT_ERROR";
        case 7:
            return "TEST_RESULT_CANCELED";
        case 8:
            return "TEST_RESULT_TIMEOUT";
        case 9:
            return "TEST_RESULT_START_FUNCTION";
        case 10:
            return "TEST_RESULT_INFO";
        default:
            return "TEST_RESULT_UNKNOWN";
    }
}

// Namespace autotests
// Params 2
// Checksum 0x9e3ba71c, Offset: 0x52a4
// Size: 0x7c
function set_dvar( dvar, value )
{
    var_de0278ed804bd748 = level.autotests.test_runtime.var_de0278ed804bd748 ?? [];
    old_dvar_value = getdvar( dvar );
    level.autotests.test_runtime.var_de0278ed804bd748[ dvar ] = old_dvar_value;
    setdvar( dvar, value );
}

// Namespace autotests
// Params 0
// Checksum 0x3919eee1, Offset: 0x5328
// Size: 0xcc
function cleanup_dvars()
{
    var_de0278ed804bd748 = level.autotests.test_runtime.var_de0278ed804bd748;
    
    foreach ( dvar, value in var_de0278ed804bd748 )
    {
        if ( value == "" )
        {
            deregisterdvar( dvar );
            continue;
        }
        
        setdvar( dvar, value );
    }
    
    level.autotests.test_runtime.var_de0278ed804bd748 = undefined;
}

// Namespace autotests
// Params 1
// Checksum 0xc1a181b3, Offset: 0x53fc
// Size: 0x97
function reset_dvar( dvar )
{
    var_de0278ed804bd748 = level.autotests.test_runtime.var_de0278ed804bd748;
    
    if ( !isdefined( var_de0278ed804bd748 ) || !isdefined( var_de0278ed804bd748[ dvar ] ) )
    {
        return;
    }
    
    old_dvar_value = var_de0278ed804bd748[ dvar ];
    
    if ( old_dvar_value == "" )
    {
        deregisterdvar( dvar );
    }
    else
    {
        setdvar( dvar, old_dvar_value );
    }
    
    var_de0278ed804bd748[ dvar ] = undefined;
    level.autotests.test_runtime.var_de0278ed804bd748 = var_de0278ed804bd748;
}

// Namespace autotests
// Params 2
// Checksum 0x6a0645d2, Offset: 0x549b
// Size: 0x36
function function_5b8cb4c1e1344b52( asset, action )
{
    sendautotestmsg( "timeit|start|" + asset + "|" + action + "|" + gettime() );
}

// Namespace autotests
// Params 2
// Checksum 0x3101aa0d, Offset: 0x54d9
// Size: 0x36
function function_d2beb5130405ff37( asset, action )
{
    sendautotestmsg( "timeit|end|" + asset + "|" + action + "|" + gettime() );
}

// Namespace autotests
// Params 0
// Checksum 0xe768ae64, Offset: 0x5517
// Size: 0x14
function get_apollo_test_session_id()
{
    return getdvar( @"dlog_apollo_test_session_id", "0" );
}

// Namespace autotests
// Params 1
// Checksum 0x171c85a, Offset: 0x5534
// Size: 0x33
function function_1676d5bbfb60ce82( testname )
{
    test_setup = function_418560fba4a02363( testname );
    return get_test_parameters( test_setup.test, test_setup );
}

// Namespace autotests
// Params 2, eflags: 0x4
// Checksum 0x6ff9deeb, Offset: 0x5570
// Size: 0x49
function private get_test_parameters( test, test_setup )
{
    if ( isdefined( test.parameterize_function ) )
    {
        parameters = test [[ test.parameterize_function ]]( test_setup );
        return function_d3af680806999308( parameters );
    }
}

// Namespace autotests
// Params 1
// Checksum 0x660a9f19, Offset: 0x55c1
// Size: 0x55
function function_3b4985eec125f0ae( test )
{
    test = level.autotests.tests[ function_526731d23b8f63b0( test ) ];
    
    if ( isdefined( test.var_646db331430d11c9 ) )
    {
        asset_types = [[ test.var_646db331430d11c9 ]]();
        return asset_types;
    }
}

// Namespace autotests
// Params 1
// Checksum 0x7057c2ca, Offset: 0x561e
// Size: 0x68
function function_61a59ea25ae0943( test )
{
    test = level.autotests.tests[ function_526731d23b8f63b0( test ) ];
    
    if ( isdefined( test.var_65bea03503209832 ) )
    {
        feature_targets = [[ test.var_65bea03503209832 ]]();
        return feature_targets;
    }
    
    return [ "featuretarget_cer_tu_season3", "featuretarget_cer_tu_season3_5" ];
}

// Namespace autotests
// Params 1
// Checksum 0x85da4422, Offset: 0x568f
// Size: 0x36
function set_test_assets( assets )
{
    level.autotests.assets = assets;
    return level.autotests.assets.size;
}

// Namespace autotests
// Params 0
// Checksum 0xc82c23bc, Offset: 0x56ce
// Size: 0x2b
function get_player()
{
    player = level.player;
    
    if ( !isdefined( player ) )
    {
        player = level.players[ 0 ];
    }
    
    return player;
}

// Namespace autotests
// Params 0
// Checksum 0x9b3ec1f7, Offset: 0x5702
// Size: 0x32
function get_mapname()
{
    var_7237854e3be197ca = level.mapname;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return getdvar( @"g_mapname", "None" );
}

// Namespace autotests
// Params 0
// Checksum 0xd5afe76a, Offset: 0x573d
// Size: 0x2c
function get_gametype()
{
    var_7237854e3be197ca = level.gametype;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return getgametypenamekey() ?? "None";
}

// Namespace autotests
// Params 0
// Checksum 0x731a8248, Offset: 0x5772
// Size: 0x47, Type: bool
function get_player_unoid()
{
    player = get_player();
    
    if ( player )
    {
        unoid = player utility::callsharedfunc( #"test", #"getplayerunoid" );
    }
    
    return unoid ?? "None";
}

