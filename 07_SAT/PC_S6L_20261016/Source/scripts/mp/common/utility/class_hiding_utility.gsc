// scripts\mp\common\utility\class_hiding_utility.gsc  (hash_09cec44d3e5e2a36.gscc) (size: 2194 Bytes / 0x892 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6455071f (1683293983)
// size ...... 2194 (0x892)
// includes .. 2   (offset: 0x832)
// strings ... 2   (offset: 0x842)
// dev strs .. 4   (offset: 0x862)
// exports ... 8   (offset: 0x4da)
// cseg ...... 0x6d + 0x46d (0x4da)
// imports ... 18  (offset: 0x61a)
// animtree1 . 0   (offset: 0x892)
// animtree2 . 0   (offset: 0x892)
#using scripts\common\omnvar_utility;
#using scripts\mp\class;

#namespace class_hiding_utility;

// Namespace class_hiding_utility
// Params 0
// Checksum 0xab68e32c, Offset: 0x8b
// Size: 0x127
function init()
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !hasomnvar( o"hash_fa5bb6076b0a251" ) )
    {
        return;
    }
    
    level.var_c1f961e35dbfa0b7 = [];
    
    for ( i = 1; i <= 12 ; i++ )
    {
        name = "custom" + i;
        assert( isdefined( level.classmap[ name ] ) );
        level.var_c1f961e35dbfa0b7[ name ] = level.var_c1f961e35dbfa0b7.size;
    }
    
    for ( i = 1; i <= 10 ; i++ )
    {
        name = "default" + i;
        assert( isdefined( level.classmap[ name ] ) );
        level.var_c1f961e35dbfa0b7[ name ] = level.var_c1f961e35dbfa0b7.size;
    }
    
    [ var_ff644f7a819c2222, var_6a89ebf7d842b1e0 ] = getomnvarrange( o"hash_fa5bb6076b0a251" );
    assert( 0 == var_ff644f7a819c2222 );
    assert( 4194303 == var_6a89ebf7d842b1e0 + 1 );
    assert( -1 );
}

// Namespace class_hiding_utility
// Params 0
// Checksum 0xc6b43b16, Offset: 0x1ba
// Size: 0x12, Type: bool
function isenabled()
{
    return getdvarint( @"hash_af3bf4cd77d62050", 0 ) != 0;
}

// Namespace class_hiding_utility
// Params 2
// Checksum 0x86a43c66, Offset: 0x1d5
// Size: 0x6d, Type: bool
function function_68e3b15f653b3fd5( player, classname )
{
    if ( !isdefined( player.var_51f583488ef1de93 ) )
    {
        return true;
    }
    
    var_21e819608790812b = level.var_c1f961e35dbfa0b7[ classname ];
    
    if ( !isdefined( var_21e819608790812b ) )
    {
        return true;
    }
    
    var_1373848dd05b736a = omnvar_utility::unpackvalue( var_21e819608790812b, 1, player.var_51f583488ef1de93 );
    return var_1373848dd05b736a == 0;
}

// Namespace class_hiding_utility
// Params 3
// Checksum 0x18cb5bb7, Offset: 0x24b
// Size: 0xe5
function function_be94f77b05514b0d( player, classname, isavailable )
{
    var_21e819608790812b = level.var_c1f961e35dbfa0b7[ classname ];
    
    if ( !isdefined( var_21e819608790812b ) )
    {
        assertmsg( "<dev string:x24>" + classname );
        return;
    }
    
    var_7d3aa8628c32b2ec = isavailable ? 0 : 1;
    player.var_51f583488ef1de93 = omnvar_utility::repackomnvar( var_21e819608790812b, 1, player.var_51f583488ef1de93 ?? 0, var_7d3aa8628c32b2ec );
    player setclientomnvar( o"hash_fa5bb6076b0a251", player.var_51f583488ef1de93 );
    assert( function_68e3b15f653b3fd5( player, classname ) == isavailable );
    assert( isdefined( function_424a4c2ee3c0b6f3( player ) ), "<dev string:x4e>" );
    assert( isdefined( function_5f14c290b4fae2a5( player ) ), "<dev string:xc1>" );
}

// Namespace class_hiding_utility
// Params 2
// Checksum 0x8982b3fe, Offset: 0x338
// Size: 0xd8
function function_aebf5d1d6daa2011( player, classnamelist )
{
    if ( classnamelist.size == 0 )
    {
        assertmsg( "<dev string:x133>" );
        return;
    }
    
    if ( !isdefined( player.var_51f583488ef1de93 ) )
    {
        player.var_51f583488ef1de93 = 0;
    }
    
    player.var_51f583488ef1de93 |= 4190208;
    
    foreach ( classname in classnamelist )
    {
        function_be94f77b05514b0d( player, classname, 1 );
    }
}

// Namespace class_hiding_utility
// Params 1
// Checksum 0x5a68fa62, Offset: 0x418
// Size: 0x6b
function function_424a4c2ee3c0b6f3( player )
{
    var_f0edce8b10f0b1f6 = min( 10, class::function_868832c7872f848e( level.classtablename ) );
    i = 1;
    
    while ( i <= var_f0edce8b10f0b1f6 )
    {
        name = "default" + i;
        
        if ( function_68e3b15f653b3fd5( player, name ) )
        {
            return name;
        }
        
        i += 1;
    }
}

// Namespace class_hiding_utility
// Params 1
// Checksum 0x264ed184, Offset: 0x48c
// Size: 0x4d
function function_5f14c290b4fae2a5( player )
{
    i = 1;
    
    while ( i <= 12 )
    {
        name = "custom" + i;
        
        if ( function_68e3b15f653b3fd5( player, name ) )
        {
            return name;
        }
        
        i += 1;
    }
}

