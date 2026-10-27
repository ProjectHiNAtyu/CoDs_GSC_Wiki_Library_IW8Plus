// scripts\autotests\mp\test_mp_sprays.gsc  (hash_6f55e2c03433d036.gscc) (size: 2371 Bytes / 0x943 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x85a678ae (2242279598)
// size ...... 2371 (0x943)
// includes .. 4   (offset: 0x8cb)
// strings ... 6   (offset: 0x8eb)
// dev strs .. 0   (offset: 0x943)
// exports ... 7   (offset: 0x463)
// cseg ...... 0x118 + 0x34b (0x463)
// imports ... 29  (offset: 0x57b)
// animtree1 . 0   (offset: 0x943)
// animtree2 . 0   (offset: 0x943)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_video;
#using scripts\mp\gestures;

#namespace test_mp_sprays;

// Namespace test_mp_sprays/testautomation
// Params 0, eflags: 0x20
// Checksum 0xcd19f317, Offset: 0x136
// Size: 0x2b
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_sprays.gsc", #"test", &start_test, &setup, &cleanup, &parameterize );
}

// Namespace test_mp_sprays
// Params 1
// Checksum 0x88930920, Offset: 0x169
// Size: 0x1e
function function_9e8d97b7da0f75e8( parameter )
{
    if ( isxhashasset( parameter ) )
    {
        return parameter;
    }
    
    return getxhashasset( parameter );
}

// Namespace test_mp_sprays
// Params 0
// Checksum 0x88b38d10, Offset: 0x190
// Size: 0xc4
function start_test()
{
    parameter = self.parameters[ 0 ];
    autotests::set_current_asset_name( parameter );
    sprayhash = function_9e8d97b7da0f75e8( parameter );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spray is a valid asset", isxhashasset( sprayhash ), "scripts/autotests/mp/test_mp_sprays.gsc", 29 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player = autotests_utility_player::get_player();
    player gestures::watchradialgestureactivation( "radial_menu_selection_spray", sprayhash );
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "spray" );
    wait 2;
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "spray" );
    wait 2;
    removeallfxmarks();
}

// Namespace test_mp_sprays
// Params 0, eflags: 0x4
// Checksum 0x6fd57aa4, Offset: 0x25c
// Size: 0x8c
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility_video::function_5826175e5df28fd8();
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player Is Alive At Test Start?", isalive( player ), "scripts/autotests/mp/test_mp_sprays.gsc", 44 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player autotests_utility_video::test_setorigin( ( -9926, -54, 58 ) );
    autotests::set_dvar( @"cg_drawgun", 0 );
    return 1;
}

// Namespace test_mp_sprays
// Params 0, eflags: 0x4
// Checksum 0xb2607a00, Offset: 0x2f1
// Size: 0x2
function private cleanup()
{
    
}

// Namespace test_mp_sprays
// Params 1
// Checksum 0x8e61ac7, Offset: 0x2fb
// Size: 0x167
function parameterize( dataset )
{
    starttime = gettime();
    
    while ( !isdefined( level.gamemodebundle.spraylist ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 30000 )
        {
            autotests::function_d84657f448aaeef6( "Failed waiting for sprayList to be populated.", 0, "scripts/autotests/mp/test_mp_sprays.gsc", 56 );
            return;
        }
    }
    
    var_cae8eb56187566ff = getscriptbundle( level.gamemodebundle.spraylist );
    
    if ( !isdefined( var_cae8eb56187566ff ) )
    {
        return [];
    }
    
    sprayrefs = [];
    spraylist = var_cae8eb56187566ff.var_10257c3c5cd3d2ff;
    
    for ( i = 0; i < spraylist.size ; i++ )
    {
        if ( !isdefined( spraylist[ i ].spraybundle ) )
        {
            continue;
        }
        
        spraybundle = getscriptbundlefieldvalues( spraylist[ i ].spraybundle, [ #"spray", #"lootid" ] );
        sprayref = spraybundle.spray;
        
        if ( !isdefined( sprayref ) )
        {
            continue;
        }
        
        spraystring = string( sprayref );
        
        if ( spraystring.size < 5 )
        {
            continue;
        }
        
        substring = getsubstr( spraystring, 3, spraystring.size - 1 );
        sprayrefs[ sprayrefs.size ] = substring;
    }
    
    return sprayrefs;
}

