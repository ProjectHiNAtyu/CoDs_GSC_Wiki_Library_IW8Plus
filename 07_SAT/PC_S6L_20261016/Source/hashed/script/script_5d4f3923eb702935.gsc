// script_5d4f3923eb702935  (hash_5d4f3923eb702935.gscc) (size: 1011 Bytes / 0x3f3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6263e8d3 (1650714835)
// size ...... 1011 (0x3f3)
// includes .. 2   (offset: 0x3bb)
// strings ... 3   (offset: 0x3cb)
// dev strs .. 0   (offset: 0x3f3)
// exports ... 4   (offset: 0x22f)
// cseg ...... 0x7b + 0x1b4 (0x22f)
// imports ... 8   (offset: 0x2cf)
// animtree1 . 0   (offset: 0x3f3)
// animtree2 . 0   (offset: 0x3f3)
#using script_3f182ddb21e37fd3;
#using scripts\autotests\autotests_utility_bot;

#namespace namespace_3637061638c5e37a;

// Namespace namespace_3637061638c5e37a/testautomation
// Params 0, eflags: 0x20
// Checksum 0xeb4c38fd, Offset: 0x99
// Size: 0x2e
function event_handler[testautomation] main()
{
    function_6b8b68fa6ee6a023( "spawnbot", &function_78bf9bfabcac6102, "core" );
    function_6b8b68fa6ee6a023( "kickallbots", &function_62fd8dc6be0c8817, "core" );
}

// Namespace namespace_3637061638c5e37a
// Params 1, eflags: 0x4
// Checksum 0xd1b8dda1, Offset: 0xcf
// Size: 0x14e
function private function_78bf9bfabcac6102( params )
{
    res = spawnstruct();
    res.exitcode = 0;
    spawndata = spawnstruct();
    
    if ( isarray( params.origin ) && params.origin.size == 3 )
    {
        spawndata.origin = ( params.origin[ 0 ], params.origin[ 1 ], params.origin[ 2 ] );
        
        if ( isarray( params.angles ) && params.angles.size == 3 )
        {
            spawndata.angles = ( params.angles[ 0 ], params.angles[ 1 ], params.angles[ 2 ] );
        }
        else
        {
            spawndata.angles = ( 0, 0, 0 );
        }
        
        bot = autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, spawndata );
        
        if ( bot )
        {
            bot autotests_utility_bot::disable_movement();
        }
        else
        {
            res.exitcode = 2;
        }
    }
    else
    {
        res.exitcode = 1;
    }
    
    return res;
}

// Namespace namespace_3637061638c5e37a
// Params 0, eflags: 0x4
// Checksum 0x323344ac, Offset: 0x226
// Size: 0x9
function private function_62fd8dc6be0c8817()
{
    autotests_utility_bot::kick_all_bots();
}

