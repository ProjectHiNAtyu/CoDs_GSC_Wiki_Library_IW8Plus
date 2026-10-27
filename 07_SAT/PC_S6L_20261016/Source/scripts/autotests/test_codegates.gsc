// scripts\autotests\test_codegates.gsc  (hash_54f6915f3d0dafbf.gscc) (size: 3276 Bytes / 0xccc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa64fc97e (2790246782)
// size ...... 3276 (0xccc)
// includes .. 1   (offset: 0xb88)
// strings ... 18  (offset: 0xb90)
// dev strs .. 0   (offset: 0xccc)
// exports ... 4   (offset: 0x834)
// cseg ...... 0x35e + 0x4d6 (0x834)
// imports ... 14  (offset: 0x8d4)
// animtree1 . 0   (offset: 0xccc)
// animtree2 . 0   (offset: 0xccc)
#using scripts\autotests\autotests;

#namespace test_codegates;

// Namespace test_codegates/testautomation
// Params 0, eflags: 0x20
// Checksum 0x34af3923, Offset: 0x37c
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_codegates.gsc", #"test", &start_test, &setup );
}

// Namespace test_codegates
// Params 0
// Checksum 0x9d77555d, Offset: 0x3a5
// Size: 0x4, Type: bool
function setup()
{
    return true;
}

// Namespace test_codegates
// Params 0
// Checksum 0x5f52826, Offset: 0x3b2
// Size: 0x481
function start_test()
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Code Gate 'gsc_auto_test_dvar' exists and is enabled", getcodegate( #"gsc_auto_test_dvar" ), "scripts/autotests/test_codegates.gsc", 17 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Code Gate dvar 'killswitch_codegate_gsc_auto_test_dvar_enabled' exists", isdvardefined( @"killswitch_codegate_gsc_auto_test_dvar_enabled" ), "scripts/autotests/test_codegates.gsc", 18 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Code Gate dvar 'killswitch_codegate_gsc_auto_test_dvar_enabled' is enabled", getdvar( @"killswitch_codegate_gsc_auto_test_dvar_enabled" ), "1", "scripts/autotests/test_codegates.gsc", 19 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::report_info( "Disabling Code Gate dvar (bool)." );
    setdvar( @"killswitch_codegate_gsc_auto_test_dvar_enabled", 0 );
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Code Gate evaluates to false", getcodegate( #"gsc_auto_test_dvar" ), "scripts/autotests/test_codegates.gsc", 23 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::report_info( "Disabling Code Gate dvar (int)." );
    setdvar( @"killswitch_codegate_gsc_auto_test_dvar_enabled", 0 );
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Code Gate evaluates to false", getcodegate( #"gsc_auto_test_dvar" ), "scripts/autotests/test_codegates.gsc", 27 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::report_info( "Disabling Code Gate dvar (string)." );
    setdvar( @"killswitch_codegate_gsc_auto_test_dvar_enabled", "0" );
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Code Gate evaluates to false", getcodegate( #"gsc_auto_test_dvar" ), "scripts/autotests/test_codegates.gsc", 31 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::report_info( "Re-Enabling Code Gate dvar." );
    setdvar( @"killswitch_codegate_gsc_auto_test_dvar_enabled", "1" );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Code Gate evaluates to true", getcodegate( #"gsc_auto_test_dvar" ), "scripts/autotests/test_codegates.gsc", 35 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Code Gate dvar 'killswitch_codegate_gsc_auto_test_dvar_launch_arg_enabled' exists", isdvardefined( @"hash_55c1fb4e4013924d" ), "scripts/autotests/test_codegates.gsc", 37 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Code Gate dvar 'killswitch_codegate_gsc_auto_test_dvar_launch_arg_enabled' is disabled", getdvar( @"hash_55c1fb4e4013924d" ), "0", "scripts/autotests/test_codegates.gsc", 38 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Code Gate evaluates to false", getcodegate( #"hash_347d36276c124e4e" ), "scripts/autotests/test_codegates.gsc", 39 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::report_info( "Enabling Code Gate dvar (bool)." );
    setdvar( @"hash_55c1fb4e4013924d", 1 );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Code Gate evaluates to true", getcodegate( #"hash_347d36276c124e4e" ), "scripts/autotests/test_codegates.gsc", 43 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::report_info( "Enabling Code Gate dvar (int)." );
    setdvar( @"hash_55c1fb4e4013924d", 1 );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Code Gate evaluates to true", getcodegate( #"hash_347d36276c124e4e" ), "scripts/autotests/test_codegates.gsc", 47 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::report_info( "Enabling Code Gate dvar (string)." );
    setdvar( @"hash_55c1fb4e4013924d", "1" );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Code Gate evaluates to true", getcodegate( #"hash_347d36276c124e4e" ), "scripts/autotests/test_codegates.gsc", 51 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::report_info( "Re-Disabling Code Gate dvar." );
    setdvar( @"hash_55c1fb4e4013924d", "0" );
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Code Gate evaluates to false", getcodegate( #"hash_347d36276c124e4e" ), "scripts/autotests/test_codegates.gsc", 55 );
    
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

