// scripts\autotests\mp\test_mp_perks.gsc  (hash_72125136af036ebf.gscc) (size: 1858 Bytes / 0x742 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc3e5f2b6 (3286626998)
// size ...... 1858 (0x742)
// includes .. 4   (offset: 0x6de)
// strings ... 5   (offset: 0x6fe)
// dev strs .. 0   (offset: 0x742)
// exports ... 7   (offset: 0x3b6)
// cseg ...... 0xc2 + 0x2f4 (0x3b6)
// imports ... 18  (offset: 0x4ce)
// animtree1 . 0   (offset: 0x742)
// animtree2 . 0   (offset: 0x742)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;
#using scripts\mp\common\utility\perk;

#namespace test_mp_perks;

// Namespace test_mp_perks/testautomation
// Params 0, eflags: 0x20
// Checksum 0xe34a7bfb, Offset: 0xe0
// Size: 0x2b
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_perks.gsc", #"test", &start_test, &setup, &cleanup, &parameterize );
}

// Namespace test_mp_perks
// Params 0
// Checksum 0x9f662162, Offset: 0x113
// Size: 0x33
function start_test()
{
    player = autotests_utility_player::get_player();
    perkref = self.parameters[ 0 ];
    player test_perk( perkref );
}

// Namespace test_mp_perks
// Params 1, eflags: 0x4
// Checksum 0xaee37c68, Offset: 0x14e
// Size: 0x74
function private test_perk( perkref )
{
    perk::giveperk( perkref );
    hasperk = isdefined( self.perks[ perkref ] );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Perk " + perkref + " equipped?", hasperk, "scripts/autotests/mp/test_mp_perks.gsc", 30 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_perks
// Params 0, eflags: 0x4
// Checksum 0x1f0c5db7, Offset: 0x1ca
// Size: 0xd8
function private setup()
{
    autotests::function_5c8c87763724c132();
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player Has Spawned?", isalive( player ), "scripts/autotests/mp/test_mp_perks.gsc", 38 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    foreach ( perkname, perkval in player.perks )
    {
        player perk::removeperk( perkname );
    }
    
    return 1;
}

// Namespace test_mp_perks
// Params 0, eflags: 0x4
// Checksum 0x20e32a9d, Offset: 0x2ab
// Size: 0x2
function private cleanup()
{
    
}

// Namespace test_mp_perks
// Params 1, eflags: 0x4
// Checksum 0x75048010, Offset: 0x2b5
// Size: 0x100
function private parameterize( datasets )
{
    bundle = autotests::get_test_bundle( self.xhash_ref );
    testingskills = bundle.testskills ?? 0;
    perkrefs = [];
    
    foreach ( perkname, perkbundle in level.perkbundles )
    {
        if ( perkname == "specialty_null" )
        {
            continue;
        }
        
        if ( !autotests_utility::function_16e4b52e47772eb5( perkbundle, 0 ) )
        {
            continue;
        }
        
        isskill = perkbundle.var_8bb08608ad9c69ef ?? 0;
        
        if ( testingskills == isskill )
        {
            perkrefs[ perkrefs.size ] = perkname;
        }
    }
    
    return perkrefs;
}

