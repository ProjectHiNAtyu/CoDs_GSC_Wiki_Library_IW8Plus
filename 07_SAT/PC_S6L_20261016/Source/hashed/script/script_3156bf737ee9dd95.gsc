// script_3156bf737ee9dd95  (hash_3156bf737ee9dd95.gscc) (size: 2834 Bytes / 0xb12 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b37c808 (2604124168)
// size ...... 2834 (0xb12)
// includes .. 2   (offset: 0xa56)
// strings ... 12  (offset: 0xa66)
// dev strs .. 0   (offset: 0xb12)
// exports ... 10  (offset: 0x62e)
// cseg ...... 0x185 + 0x4a9 (0x62e)
// imports ... 22  (offset: 0x7be)
// animtree1 . 0   (offset: 0xb12)
// animtree2 . 0   (offset: 0xb12)
#using script_3f182ddb21e37fd3;
#using scripts\autotests\autotests;

#namespace namespace_ae9579b9309358c4;

// Namespace namespace_ae9579b9309358c4/testautomation
// Params 0, eflags: 0x20
// Checksum 0x1c3a7432, Offset: 0x1a3
// Size: 0xb2
function event_handler[testautomation] main()
{
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getfunctionlist", &function_e6cc3390af1141c6, "core" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getfunctioncategories", &function_3837900a5764a052, "core" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getfunctionlistbycategory", &function_e80cb53d3b712563, "core" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getgametype", &get_gametype, "core" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getmapname", &get_mapname, "core" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getplayerunoid", &get_player_unoid, "core" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "getplayerposition", &get_player_position, "core" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "teleportplayer", &teleport_player, "core" );
}

// Namespace namespace_ae9579b9309358c4
// Params 0, eflags: 0x4
// Checksum 0xa45ff3ab, Offset: 0x25d
// Size: 0x19, Type: bool
function private function_e6cc3390af1141c6()
{
    return level.rpc.function_names ?? [];
}

// Namespace namespace_ae9579b9309358c4
// Params 0, eflags: 0x4
// Checksum 0x7a92d37e, Offset: 0x27f
// Size: 0x98
function private function_3837900a5764a052()
{
    categories = [];
    
    foreach ( category in level.rpc.function_categories )
    {
        categories = arraycombineunique( categories, [ category ] );
    }
    
    return categories;
}

// Namespace namespace_ae9579b9309358c4
// Params 1, eflags: 0x4
// Checksum 0xcdda4c8, Offset: 0x320
// Size: 0x115
function private function_e80cb53d3b712563( params = undefined )
{
    category_name = params.category;
    
    if ( !category_name )
    {
        return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 13, "RPC category is required. Provide the category parameter." );
    }
    
    category_key = tolower( category_name );
    functions = [];
    
    foreach ( index, registered_category in level.rpc.function_categories )
    {
        if ( registered_category == category_key )
        {
            functions[ functions.size ] = level.rpc.function_names[ index ];
        }
    }
    
    if ( !functions.size )
    {
        return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 14, "Requested RPC category -->" + category_name + "<-- is not found in the registered list" );
    }
    
    return functions;
}

// Namespace namespace_ae9579b9309358c4
// Params 0, eflags: 0x4
// Checksum 0x4cf504b7, Offset: 0x43e
// Size: 0x9
function private get_mapname()
{
    autotests::get_mapname();
}

// Namespace namespace_ae9579b9309358c4
// Params 0, eflags: 0x4
// Checksum 0x4cf504b7, Offset: 0x44f
// Size: 0x9
function private get_gametype()
{
    autotests::get_gametype();
}

// Namespace namespace_ae9579b9309358c4
// Params 0, eflags: 0x4
// Checksum 0x4cf504b7, Offset: 0x460
// Size: 0x9
function private get_player_unoid()
{
    autotests::get_player_unoid();
}

// Namespace namespace_ae9579b9309358c4
// Params 1, eflags: 0x4
// Checksum 0xaad2b59d, Offset: 0x471
// Size: 0x10e
function private teleport_player( params )
{
    res = spawnstruct();
    res.exitcode = 0;
    player = autotests::get_player();
    
    if ( player )
    {
        if ( isarray( params.origin ) && params.origin.size == 3 )
        {
            player setorigin( ( params.origin[ 0 ], params.origin[ 1 ], params.origin[ 2 ] ) );
        }
        else
        {
            res.exitcode = 1;
        }
        
        if ( isarray( params.angles ) && params.angles.size == 3 )
        {
            player setplayerangles( ( params.angles[ 0 ], params.angles[ 1 ], params.angles[ 2 ] ) );
        }
    }
    else
    {
        res.exitcode = 2;
    }
    
    return res;
}

// Namespace namespace_ae9579b9309358c4
// Params 0, eflags: 0x4
// Checksum 0x955a5800, Offset: 0x588
// Size: 0xa5
function private get_player_position()
{
    res = spawnstruct();
    res.exitcode = 0;
    player = autotests::get_player();
    
    if ( player )
    {
        angles = player getplayerangles();
        res.origin = ( player.origin[ 0 ], player.origin[ 1 ], player.origin[ 2 ] );
        res.angles = ( angles[ 0 ], angles[ 1 ], angles[ 2 ] );
    }
    else
    {
        res.exitcode = 1;
    }
    
    return res;
}

