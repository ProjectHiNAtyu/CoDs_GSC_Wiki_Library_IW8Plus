// script_3455b106458253e7  (hash_3455b106458253e7.gscc) (size: 2523 Bytes / 0x9db / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf7b1ae65 (4155616869)
// size ...... 2523 (0x9db)
// includes .. 2   (offset: 0x9bf)
// strings ... 1   (offset: 0x9cf)
// dev strs .. 0   (offset: 0x9db)
// exports ... 12  (offset: 0x58f)
// cseg ...... 0x6b + 0x524 (0x58f)
// imports ... 18  (offset: 0x76f)
// animtree1 . 0   (offset: 0x9db)
// animtree2 . 0   (offset: 0x9db)
#using scripts\common\utility;
#using scripts\mp\common\utility\game;

#namespace namespace_be3150865da9d2f1;

// Namespace namespace_be3150865da9d2f1
// Params 0
// Checksum 0xd6aaa27c, Offset: 0x89
// Size: 0x31
function get_linked_struct()
{
    array = utility::get_linked_structs();
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace namespace_be3150865da9d2f1
// Params 0
// Checksum 0xcf71fb75, Offset: 0xc3
// Size: 0x31
function function_6eb7c5946019aa42()
{
    array = game_utility_mp::get_linked_vehicle_nodes();
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace namespace_be3150865da9d2f1
// Params 2
// Checksum 0x6f715787, Offset: 0xfd
// Size: 0x5b
function get_linked_vehicle_nodes_filtered( value, key )
{
    array = [];
    var_563bfc80a346bc43 = getvehiclenodearray( value, key );
    
    if ( isdefined( self.script_linkto ) )
    {
        linked_nodes = game_utility_mp::get_linked_vehicle_nodes();
        array = arrayintersection( linked_nodes, var_563bfc80a346bc43 );
    }
    
    return array;
}

// Namespace namespace_be3150865da9d2f1
// Params 2
// Checksum 0xa84ff392, Offset: 0x161
// Size: 0x47
function get_linked_vehicle_node_filtered( value, key )
{
    array = get_linked_vehicle_nodes_filtered( value, key );
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace namespace_be3150865da9d2f1
// Params 2
// Checksum 0x3ca40c24, Offset: 0x1b1
// Size: 0xa8
function get_linked_structs_filtered( value, key )
{
    array = [];
    var_2425b5dc0dc5550 = utility::getstructarray( value, key );
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = utility::get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            linked_structs = utility::getstructarray( linknames[ i ], "script_linkname" );
            structs = arrayintersection( linked_structs, var_2425b5dc0dc5550 );
            
            if ( structs.size > 0 )
            {
                array = arraycombine( array, structs );
            }
        }
    }
    
    return array;
}

// Namespace namespace_be3150865da9d2f1
// Params 2
// Checksum 0xaa7af650, Offset: 0x262
// Size: 0x3a
function get_linked_struct_filtered( value, key )
{
    array = get_linked_structs_filtered( value, key );
    
    if ( array.size > 0 )
    {
        return array[ 0 ];
    }
    
    return;
}

// Namespace namespace_be3150865da9d2f1
// Params 2
// Checksum 0x3ad042a6, Offset: 0x2a4
// Size: 0xa8
function get_linked_ents_filtered( value, key )
{
    array = [];
    var_d0712797f54da6d0 = getentarray( value, key );
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = utility::get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            linked_ents = getentarray( linknames[ i ], #script_linkname );
            ents = arrayintersection( linked_ents, var_d0712797f54da6d0 );
            
            if ( ents.size > 0 )
            {
                array = arraycombine( array, ents );
            }
        }
    }
    
    return array;
}

// Namespace namespace_be3150865da9d2f1
// Params 2
// Checksum 0xe151448, Offset: 0x355
// Size: 0x47
function get_linked_ent_filtered( value, key )
{
    array = get_linked_ents_filtered( value, key );
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace namespace_be3150865da9d2f1
// Params 2
// Checksum 0x8d2707d7, Offset: 0x3a5
// Size: 0x47
function function_9386db431ab6d1c6( value, key )
{
    array = get_linked_scriptables_filtered( value, key );
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace namespace_be3150865da9d2f1
// Params 2
// Checksum 0x40ee2560, Offset: 0x3f5
// Size: 0xec
function get_linked_scriptables_filtered( value, key )
{
    array = [];
    filtered_scriptables = [];
    entity_scriptables = getscriptablearray( value, key );
    entityless_scriptables = getentitylessscriptablearray( value, key );
    filtered_scriptables = arraycombineunique( entity_scriptables, entityless_scriptables );
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = utility::get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            var_7c4a63493e09272c = [];
            entity_scriptables = getscriptablearray( linknames[ i ], #script_linkname );
            entityless_scriptables = getentitylessscriptablearray( linknames[ i ], #script_linkname );
            var_7c4a63493e09272c = arraycombineunique( entity_scriptables, entityless_scriptables );
            scriptables = arrayintersection( var_7c4a63493e09272c, filtered_scriptables );
            
            if ( scriptables.size > 0 )
            {
                array = arraycombine( array, scriptables );
            }
        }
    }
    
    return array;
}

// Namespace namespace_be3150865da9d2f1
// Params 2
// Checksum 0x6ce9b733, Offset: 0x4ea
// Size: 0xa4
function function_edb66f81f94f3870( value, key )
{
    array = [];
    var_bce359772269ba1 = getnoentvolumearray( value, key );
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = utility::get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            for ( j = 0; j < var_bce359772269ba1.size ; j++ )
            {
                if ( linknames[ i ] == var_bce359772269ba1[ j ].script_linkname )
                {
                    array[ array.size ] = var_bce359772269ba1[ j ];
                }
            }
        }
    }
    
    return array;
}

