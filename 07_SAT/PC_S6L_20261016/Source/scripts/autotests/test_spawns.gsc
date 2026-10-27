// scripts\autotests\test_spawns.gsc  (hash_2a6538d474116472.gscc) (size: 1900 Bytes / 0x76c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd185fc9b (3515219099)
// size ...... 1900 (0x76c)
// includes .. 1   (offset: 0x6b4)
// strings ... 11  (offset: 0x6bc)
// dev strs .. 3   (offset: 0x748)
// exports ... 4   (offset: 0x464)
// cseg ...... 0x11e + 0x346 (0x464)
// imports ... 15  (offset: 0x504)
// animtree1 . 0   (offset: 0x76c)
// animtree2 . 0   (offset: 0x76c)
#using scripts\autotests\autotests;

#namespace test_spawns;

// Namespace test_spawns/testautomation
// Params 0, eflags: 0x20
// Checksum 0x604eb4b8, Offset: 0x13c
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_spawns.gsc", #"GP", &start_test, &setup );
}

// Namespace test_spawns
// Params 0
// Checksum 0xeb9868c, Offset: 0x165
// Size: 0xb, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_spawns
// Params 0
// Checksum 0xac0590a6, Offset: 0x179
// Size: 0x2ea
function start_test()
{
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    spawn_errors = [ "NO ERROR", "SPAWN IN SOLID", "SPAWN FREE FLOATING", "SPAWN ON ENTITY", "MISSING TAC POINT" ];
    
    /#
        str = "<dev string:x24>" + getxhashsourcename( level.gametypebundle.var_13262a698a5f782f.spawnpointkey ) + "<dev string:x2d>";
        var_63a718d91714219d = autotests::function_36ed835262a19e53( str, level.var_c28a44c6d6f41080, "<dev string:x36>", 28 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    #/
    
    nspawns = 0;
    nfailed = 0;
    
    foreach ( spawns in level.var_c28a44c6d6f41080 )
    {
        foreach ( spawn in spawns )
        {
            if ( spawn.error_code )
            {
                foreach ( index, value in spawn_errors )
                {
                    if ( index & spawn.error_code )
                    {
                        str = "SPAWN ERROR (" + value + ") at " + spawn.origin;
                        break;
                    }
                }
                
                autotests::function_e50d1006e5d65c04( str, spawn.error_code, 0, "scripts/autotests/test_spawns.gsc", 49 );
                nfailed++;
            }
        }
        
        nspawns += spawns.size;
    }
    
    npassed = nspawns - nfailed;
    str = "Spawns status (fail/pass): (" + nfailed + "/" + npassed + ")";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( str, nfailed, 0, "scripts/autotests/test_spawns.gsc", 59 );
    
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

