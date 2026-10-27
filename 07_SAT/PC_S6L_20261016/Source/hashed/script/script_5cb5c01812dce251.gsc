// script_5cb5c01812dce251  (hash_5cb5c01812dce251.gscc) (size: 732 Bytes / 0x2dc)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x270d5c97 (655187095)
// size ...... 732 (0x2dc)
// includes .. 0   (offset: 0x2c4)
// strings ... 1   (offset: 0x2c4)
// dev strs .. 1   (offset: 0x2d0)
// exports ... 4   (offset: 0x1a4)
// cseg ...... 0x6f + 0x135 (0x1a4)
// imports ... 4   (offset: 0x244)
// animtree1 . 0   (offset: 0x2dc)
// animtree2 . 0   (offset: 0x2dc)
#namespace namespace_4137a551004cc8ee;

// Namespace namespace_4137a551004cc8ee
// Params 1
// Checksum 0x3c4b569a, Offset: 0x8d
// Size: 0x45
function function_a77191c10ba90df( task )
{
    isdisabled = 0;
    
    /#
        isdisabled = getdvarint( @"bot_disableallai" );
    #/
    
    return isdisabled ? anim.success : anim.failure;
}

// Namespace namespace_4137a551004cc8ee
// Params 2
// Checksum 0xe52f9e99, Offset: 0xdb
// Size: 0x43
function function_525af446221f4d14( taskid, params )
{
    assert( isdefined( params ) );
    assert( isstring( params ) );
    self [[ level.bot_funcs[ "bot_set_personality" ] ]]( params );
}

// Namespace namespace_4137a551004cc8ee
// Params 2
// Checksum 0x558e0d77, Offset: 0x126
// Size: 0x7e
function function_df4acfd9410a4c05( taskid, params )
{
    assert( isdefined( params ) );
    assert( isstring( params ) );
    
    if ( !isdefined( self.var_b0000032ff7f222e ) )
    {
        self.var_b0000032ff7f222e = [];
    }
    
    if ( isdefined( level.bot_think_funcs[ params ] ) )
    {
        self.var_b0000032ff7f222e[ self.var_b0000032ff7f222e.size ] = params;
        return;
    }
    
    assertmsg( "<dev string:x24>" + params );
}

