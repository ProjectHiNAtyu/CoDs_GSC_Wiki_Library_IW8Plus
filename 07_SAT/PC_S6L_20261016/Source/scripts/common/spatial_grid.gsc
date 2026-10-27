// scripts\common\spatial_grid.gsc  (hash_46d1e884b696efc3.gscc) (size: 3214 Bytes / 0xc8e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b7d4326 (461194022)
// size ...... 3214 (0xc8e)
// includes .. 0   (offset: 0xc36)
// strings ... 0   (offset: 0xc36)
// dev strs .. 7   (offset: 0xc36)
// exports ... 11  (offset: 0x8b2)
// cseg ...... 0x58 + 0x85a (0x8b2)
// imports ... 12  (offset: 0xa6a)
// animtree1 . 0   (offset: 0xc8e)
// animtree2 . 0   (offset: 0xc8e)
#namespace spatial_grid;

// Namespace spatial_grid
// Params 3
// Checksum 0x26a8a8cc, Offset: 0x76
// Size: 0x164
function create_category( var_7bdff97009197402, var_c64b7d522b7f4728 = 0, var_214e4112306fa828 = 0 )
{
    assert( isdefined( level ) );
    
    if ( !isdefined( level.spatialgrid ) )
    {
        level.spatialgrid = spawnstruct();
        level.spatialgrid.categories = [];
        level.spatialgrid.var_6e5b98a5775cb1fd = 1;
    }
    
    if ( isdefined( level.spatialgrid.categories[ var_7bdff97009197402 ] ) )
    {
        assert( var_214e4112306fa828 );
        return level.spatialgrid.categories[ var_7bdff97009197402 ];
    }
    
    level.spatialgrid.categories[ var_7bdff97009197402 ] = spawnstruct();
    category = level.spatialgrid.categories[ var_7bdff97009197402 ];
    category.objarray = [];
    category.intid = level.spatialgrid.var_6e5b98a5775cb1fd;
    category.var_c64b7d522b7f4728 = var_c64b7d522b7f4728;
    level.spatialgrid.var_6e5b98a5775cb1fd++;
    assert( level.spatialgrid.var_6e5b98a5775cb1fd < 254 );
    return category;
}

// Namespace spatial_grid
// Params 1
// Checksum 0x951c26ba, Offset: 0x1e3
// Size: 0x23, Type: bool
function function_9610dcc083b0f8c8( var_7bdff97009197402 )
{
    return isdefined( level.spatialgrid.categories[ var_7bdff97009197402 ] );
}

// Namespace spatial_grid
// Params 2
// Checksum 0x4bcbda94, Offset: 0x20f
// Size: 0x4d
function add( var_7bdff97009197402, obj )
{
    assert( isdefined( obj ) );
    assert( isstring( var_7bdff97009197402 ) );
    category = level get_or_create_category( var_7bdff97009197402 );
    add_helper( category, obj );
}

// Namespace spatial_grid
// Params 2
// Checksum 0xa17ed1fc, Offset: 0x264
// Size: 0xb4
function add_array( var_7bdff97009197402, objarray )
{
    assert( isdefined( objarray ) );
    assert( isstring( var_7bdff97009197402 ) );
    category = level get_or_create_category( var_7bdff97009197402 );
    
    foreach ( obj in objarray )
    {
        add_helper( category, obj );
    }
}

// Namespace spatial_grid
// Params 2, eflags: 0x4
// Checksum 0xdb6c4c19, Offset: 0x320
// Size: 0xcc
function private add_helper( category, obj )
{
    idx = category.objarray.size;
    
    if ( category.var_c64b7d522b7f4728 )
    {
        category.objarray[ idx ] = spawnstruct();
        objelement = category.objarray[ idx ];
        objelement.obj = obj;
        obj.var_93644fc0c12b68b2 = spatialgridadd( category.intid, idx, obj.origin );
        return;
    }
    
    category.objarray[ idx ] = obj;
    spatialgridadd( category.intid, idx, obj.origin );
}

// Namespace spatial_grid
// Params 2
// Checksum 0x1b6ad623, Offset: 0x3f4
// Size: 0xd3
function remove( var_7bdff97009197402, obj )
{
    assert( isdefined( obj ) );
    assert( isstring( var_7bdff97009197402 ) );
    
    if ( !isdefined( level.spatialgrid ) || !isdefined( level.spatialgrid.categories[ var_7bdff97009197402 ] ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    category = level.spatialgrid.categories[ var_7bdff97009197402 ];
    
    if ( !category.var_c64b7d522b7f4728 )
    {
        assertmsg( "<dev string:x56>" );
        return;
    }
    
    if ( !isdefined( obj.var_93644fc0c12b68b2 ) )
    {
        assertmsg( "<dev string:x7b>" );
        return;
    }
    
    spatialgridremove( obj.var_93644fc0c12b68b2 );
}

// Namespace spatial_grid
// Params 1
// Checksum 0xbcffc808, Offset: 0x4cf
// Size: 0x131
function remove_all( var_7bdff97009197402 )
{
    assert( isstring( var_7bdff97009197402 ) );
    
    if ( !isdefined( level.spatialgrid ) || !isdefined( level.spatialgrid.categories[ var_7bdff97009197402 ] ) )
    {
        assertmsg( "<dev string:xaf>" );
        return;
    }
    
    category = level.spatialgrid.categories[ var_7bdff97009197402 ];
    
    if ( !category.var_c64b7d522b7f4728 )
    {
        assertmsg( "<dev string:x56>" );
        return;
    }
    
    foreach ( obj in category.objarray )
    {
        spatialgridremove( obj.obj.var_93644fc0c12b68b2 );
    }
    
    level.spatialgrid.categories[ var_7bdff97009197402 ] = undefined;
}

// Namespace spatial_grid
// Params 4
// Checksum 0x6f01b4e6, Offset: 0x608
// Size: 0x104
function move( var_7bdff97009197402, obj, movetoorigin, previousorigin )
{
    assert( isdefined( obj ) );
    assert( isstring( var_7bdff97009197402 ) );
    assert( isdefined( movetoorigin ) );
    
    if ( !isdefined( previousorigin ) )
    {
        previousorigin = obj.origin;
    }
    
    if ( !isdefined( level.spatialgrid ) || !isdefined( level.spatialgrid.categories[ var_7bdff97009197402 ] ) )
    {
        assertmsg( "<dev string:xe5>" );
        return;
    }
    
    category = level.spatialgrid.categories[ var_7bdff97009197402 ];
    
    if ( !category.var_c64b7d522b7f4728 )
    {
        assertmsg( "<dev string:x115>" );
        return;
    }
    
    if ( !isdefined( obj.var_93644fc0c12b68b2 ) )
    {
        assertmsg( "<dev string:x138>" );
        return;
    }
    
    spatialgridmove( obj.var_93644fc0c12b68b2, movetoorigin );
}

// Namespace spatial_grid
// Params 3
// Checksum 0x96e3baae, Offset: 0x714
// Size: 0x13f
function query( var_7bdff97009197402, origin, radius )
{
    if ( !isdefined( level.spatialgrid ) || !isdefined( level.spatialgrid.categories[ var_7bdff97009197402 ] ) )
    {
        return [];
    }
    
    category = level.spatialgrid.categories[ var_7bdff97009197402 ];
    queryarray = function_37c8b3d275041e4a( category.intid, origin, radius );
    returnarray = [];
    
    foreach ( idx in queryarray )
    {
        if ( category.var_c64b7d522b7f4728 )
        {
            returnarray[ returnarray.size ] = category.objarray[ idx ].obj;
            continue;
        }
        
        returnarray[ returnarray.size ] = category.objarray[ idx ];
    }
    
    return returnarray;
}

// Namespace spatial_grid
// Params 1, eflags: 0x4
// Checksum 0xf97cfe79, Offset: 0x85c
// Size: 0x55
function private get_or_create_category( var_7bdff97009197402 )
{
    if ( !isdefined( level.spatialgrid ) || !isdefined( level.spatialgrid.categories[ var_7bdff97009197402 ] ) )
    {
        return create_category( var_7bdff97009197402 );
    }
    
    return level.spatialgrid.categories[ var_7bdff97009197402 ];
}

