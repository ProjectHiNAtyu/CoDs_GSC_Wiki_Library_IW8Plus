// scripts\common\max_heap.gsc  (hash_4170b1140b0a0323.gscc) (size: 2667 Bytes / 0xa6b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeeb410ba (4004778170)
// size ...... 2667 (0xa6b)
// includes .. 0   (offset: 0xa4b)
// strings ... 0   (offset: 0xa4b)
// dev strs .. 2   (offset: 0xa4b)
// exports ... 8   (offset: 0x79f)
// cseg ...... 0x58 + 0x747 (0x79f)
// imports ... 11  (offset: 0x8df)
// animtree1 . 0   (offset: 0xa6b)
// animtree2 . 0   (offset: 0xa6b)
#namespace max_heap;

// Namespace max_heap
// Params 3
// Checksum 0x7f556550, Offset: 0x76
// Size: 0x265
function push( ref_hash, element, priority )
{
    assert( isdefined( ref_hash ) && isdefined( element ) && isdefined( priority ) );
    
    if ( !isxhash( ref_hash ) )
    {
        ref_hash = getxhash( ref_hash );
    }
    
    if ( !isdefined( level.max_heaps ) )
    {
        level.max_heaps = [];
    }
    
    if ( !isdefined( level.max_heaps[ ref_hash ] ) )
    {
        heap_struct = spawnstruct();
        heap_struct.heap = [];
        heap_struct.salt = 10000;
        level.max_heaps[ ref_hash ] = heap_struct;
    }
    
    element_found = 0;
    
    foreach ( index, node in level.max_heaps[ ref_hash ].heap )
    {
        if ( node.element == element )
        {
            node.priority = priority;
            node.salt = level.max_heaps[ ref_hash ].salt;
            heapify_up( ref_hash, index );
            element_found = 1;
            break;
        }
    }
    
    if ( !element_found )
    {
        node = spawnstruct();
        node.element = element;
        node.priority = priority;
        node.salt = level.max_heaps[ ref_hash ].salt;
        
        if ( !isdefined( level.max_heaps[ ref_hash ].heap ) )
        {
            level.max_heaps[ ref_hash ].heap = [];
        }
        
        level.max_heaps[ ref_hash ].heap[ level.max_heaps[ ref_hash ].heap.size ] = node;
        heapify_up( ref_hash, level.max_heaps[ ref_hash ].heap.size - 1 );
    }
    
    level.max_heaps[ ref_hash ].salt--;
}

// Namespace max_heap
// Params 1
// Checksum 0x1a687fbc, Offset: 0x2e3
// Size: 0xf9
function pop( ref_hash )
{
    assert( isdefined( ref_hash ) );
    
    if ( is_empty( ref_hash ) )
    {
        assertmsg( "<dev string:x24>" + ref_hash + "<dev string:x48>" );
        return;
    }
    
    top_node = level.max_heaps[ ref_hash ].heap[ 0 ];
    last_node = level.max_heaps[ ref_hash ].heap[ level.max_heaps[ ref_hash ].heap.size - 1 ];
    level.max_heaps[ ref_hash ].heap[ 0 ] = last_node;
    level.max_heaps[ ref_hash ].heap[ level.max_heaps[ ref_hash ].heap.size - 1 ] = undefined;
    heapify_down( ref_hash, 0 );
    return top_node.element;
}

// Namespace max_heap
// Params 1
// Checksum 0xf3704aa9, Offset: 0x3e5
// Size: 0x5b
function peek( ref_hash )
{
    assert( isdefined( ref_hash ) );
    
    if ( is_empty( ref_hash ) )
    {
        assertmsg( "<dev string:x24>" + ref_hash + "<dev string:x48>" );
        return;
    }
    
    return level.max_heaps[ ref_hash ].heap[ 0 ].element;
}

// Namespace max_heap
// Params 1
// Checksum 0x8a0b3014, Offset: 0x449
// Size: 0x4d, Type: bool
function is_empty( ref_hash )
{
    assert( isdefined( ref_hash ) );
    
    if ( isdefined( level.max_heaps[ ref_hash ].heap ) )
    {
        return ( level.max_heaps[ ref_hash ].heap.size == 0 );
    }
    
    return true;
}

// Namespace max_heap
// Params 2, eflags: 0x4
// Checksum 0xae867a96, Offset: 0x49f
// Size: 0xf6
function private heapify_up( ref_hash, index )
{
    assert( isdefined( ref_hash ) && isdefined( index ) );
    
    if ( index == 0 )
    {
        return;
    }
    
    parent_index = int( index * 0.5 );
    
    if ( compare_priority( level.max_heaps[ ref_hash ].heap[ index ], level.max_heaps[ ref_hash ].heap[ parent_index ] ) )
    {
        temp_node = level.max_heaps[ ref_hash ].heap[ index ];
        level.max_heaps[ ref_hash ].heap[ index ] = level.max_heaps[ ref_hash ].heap[ parent_index ];
        level.max_heaps[ ref_hash ].heap[ parent_index ] = temp_node;
        heapify_up( ref_hash, parent_index );
    }
}

// Namespace max_heap
// Params 2, eflags: 0x4
// Checksum 0x8093b771, Offset: 0x59d
// Size: 0x18a
function private heapify_down( ref_hash, index )
{
    assert( isdefined( ref_hash ) && isdefined( index ) );
    left_node_index = 2 * index + 1;
    right_node_index = 2 * index + 2;
    largest_index = index;
    
    if ( left_node_index < level.max_heaps[ ref_hash ].heap.size && compare_priority( level.max_heaps[ ref_hash ].heap[ left_node_index ], level.max_heaps[ ref_hash ].heap[ largest_index ] ) )
    {
        largest_index = left_node_index;
    }
    
    if ( right_node_index < level.max_heaps[ ref_hash ].heap.size && compare_priority( level.max_heaps[ ref_hash ].heap[ right_node_index ], level.max_heaps[ ref_hash ].heap[ largest_index ] ) )
    {
        largest_index = right_node_index;
    }
    
    if ( largest_index != index )
    {
        temp_node = level.max_heaps[ ref_hash ].heap[ index ];
        level.max_heaps[ ref_hash ].heap[ index ] = level.max_heaps[ ref_hash ].heap[ largest_index ];
        level.max_heaps[ ref_hash ].heap[ largest_index ] = temp_node;
        heapify_down( ref_hash, largest_index );
    }
}

// Namespace max_heap
// Params 2, eflags: 0x4
// Checksum 0x244e33e0, Offset: 0x72f
// Size: 0x6f, Type: bool
function private compare_priority( lhs_node, rhs_node )
{
    assert( isdefined( lhs_node ) && isdefined( rhs_node ) );
    
    if ( lhs_node.priority != rhs_node.priority )
    {
        return ( lhs_node.priority > rhs_node.priority );
    }
    
    return lhs_node.salt > rhs_node.salt;
}

