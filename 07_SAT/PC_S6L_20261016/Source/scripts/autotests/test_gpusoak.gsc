// scripts\autotests\test_gpusoak.gsc  (hash_6acb5b3a345c82d0.gscc) (size: 1506 Bytes / 0x5e2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd39d165c (3550287452)
// size ...... 1506 (0x5e2)
// includes .. 2   (offset: 0x5aa)
// strings ... 2   (offset: 0x5ba)
// dev strs .. 1   (offset: 0x5d6)
// exports ... 4   (offset: 0x306)
// cseg ...... 0x8f + 0x277 (0x306)
// imports ... 18  (offset: 0x3a6)
// animtree1 . 0   (offset: 0x5e2)
// animtree2 . 0   (offset: 0x5e2)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;

#namespace test_gpusoak;

// Namespace test_gpusoak/testautomation
// Params 0, eflags: 0x20
// Checksum 0xb66c33bb, Offset: 0xad
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_gpusoak.gsc", #"GP", &start_test, &setup );
}

// Namespace test_gpusoak
// Params 0
// Checksum 0xbae5f8ce, Offset: 0xd6
// Size: 0xb, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_gpusoak
// Params 0
// Checksum 0x3ddc6bee, Offset: 0xea
// Size: 0x21c
function start_test()
{
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player found?", isdefined( player ), "scripts/autotests/test_gpusoak.gsc", 29 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    /#
        adddebugcommand( "<dev string:x24>" );
    #/
    
    mapinfo = level.mapinfobundle;
    
    if ( !isdefined( mapinfo ) )
    {
        mapinfo = getmapscriptbundle();
    }
    
    assert( isdefined( mapinfo ) );
    minx = min( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] );
    maxx = max( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] );
    miny = min( level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] );
    maxy = max( level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] );
    
    while ( true )
    {
        x = randomfloatrange( minx, maxx );
        y = randomfloatrange( miny, maxy );
        startpos = ( x, y, 10000 );
        endpos = ( x, y, 10000 * -1 );
        pos = physicstrace( startpos, endpos );
        player setorigin( ( pos[ 0 ], pos[ 1 ], pos[ 2 ] + 6 ) );
        wait 5;
    }
}

