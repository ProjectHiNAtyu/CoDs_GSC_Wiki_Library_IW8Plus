// scripts\mp\spawnutils.gsc  (hash_0fdd8ac7015d0006.gscc) (size: 2215 Bytes / 0x8a7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd6b1539 (3177911609)
// size ...... 2215 (0x8a7)
// includes .. 1   (offset: 0x87f)
// strings ... 2   (offset: 0x887)
// dev strs .. 0   (offset: 0x8a7)
// exports ... 6   (offset: 0x6db)
// cseg ...... 0x77 + 0x664 (0x6db)
// imports ... 5   (offset: 0x7cb)
// animtree1 . 0   (offset: 0x8a7)
// animtree2 . 0   (offset: 0x8a7)
#using scripts\mp\spawnlogic;

#namespace spawnutils;

// Namespace spawnutils
// Params 2
// Checksum 0x9508de16, Offset: 0x95
// Size: 0x9c, Type: bool
function spawnarray_contains( array, spawnpoint )
{
    foreach ( item in array )
    {
        if ( item.index == spawnpoint.index )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spawnutils
// Params 3, eflags: 0x40 variadic
// Checksum 0x6c9a13e1, Offset: 0x13a
// Size: 0x106
function function_268776511d6464f2( array1, ... )
{
    foreach ( temparray in vararg )
    {
        foreach ( item in temparray )
        {
            if ( spawnarray_contains( array1, item ) )
            {
                continue;
            }
            
            array1[ array1.size ] = item;
        }
    }
    
    return array1;
}

// Namespace spawnutils
// Params 3, eflags: 0x40 variadic
// Checksum 0xa6966fed, Offset: 0x249
// Size: 0x125
function spawnarray_difference( array1, ... )
{
    result = [];
    
    foreach ( item in array1 )
    {
        additem = 1;
        
        foreach ( temparray in vararg )
        {
            if ( spawnarray_contains( temparray, item ) )
            {
                additem = 0;
                break;
            }
        }
        
        if ( additem )
        {
            result[ result.size ] = item;
        }
    }
    
    return result;
}

// Namespace spawnutils
// Params 3
// Checksum 0xc2a87500, Offset: 0x377
// Size: 0xda
function function_82a709daf1f7a2d5( spawnpoints, spawnkey, spawnvalue )
{
    spawnarrays = [];
    spawnarrays[ "remainder" ] = [];
    spawnarrays[ spawnvalue ] = [];
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( function_a7814f6d26155db9( spawnpoint.index, spawnkey, spawnvalue ) )
        {
            spawnarrays[ spawnvalue ][ spawnarrays[ spawnvalue ].size ] = spawnpoint;
            continue;
        }
        
        spawnarrays[ "remainder" ][ spawnarrays[ "remainder" ].size ] = spawnpoint;
    }
    
    return spawnarrays;
}

// Namespace spawnutils
// Params 6
// Checksum 0x685da38d, Offset: 0x45a
// Size: 0x280
function function_2e4d707ad64f0c63( spawnkey, spawnvalue, valuekeys, spawnset, setkeys, instanceid )
{
    assert( setkeys.size == valuekeys.size );
    spawnpoints = spawnlogic::getspawnpointarray( "mp_spawn_point", spawnkey, spawnvalue, instanceid );
    
    if ( !spawnpoints.size )
    {
        return;
    }
    
    mainset = { #points:[], #name:spawnset, #value:spawnvalue };
    spawnsets = [];
    
    foreach ( index, value in valuekeys )
    {
        setkey = setkeys[ index ];
        set = { #points:[], #name:setkey, #value:value };
        spawnsets[ setkey ] = set;
    }
    
    foreach ( spawnpoint in spawnpoints )
    {
        setfound = 0;
        
        foreach ( set in spawnsets )
        {
            if ( function_a7814f6d26155db9( spawnpoint.index, spawnkey, set.value ) )
            {
                set.points[ set.points.size ] = spawnpoint;
                setfound = 1;
            }
        }
        
        if ( setfound == 0 )
        {
            mainset.points[ mainset.points.size ] = spawnpoint;
        }
    }
    
    spawnsets[ spawnset ] = mainset;
    return spawnsets;
}

