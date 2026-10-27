// scripts\mp\ftue\utility\ftue_loot_cache.gsc  (hash_4bcf78b337139620.gscc) (size: 2246 Bytes / 0x8c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72c56eac (1925541548)
// size ...... 2246 (0x8c6)
// includes .. 1   (offset: 0x88a)
// strings ... 3   (offset: 0x892)
// dev strs .. 0   (offset: 0x8c6)
// exports ... 8   (offset: 0x5fa)
// cseg ...... 0x87 + 0x573 (0x5fa)
// imports ... 10  (offset: 0x73a)
// animtree1 . 0   (offset: 0x8c6)
// animtree2 . 0   (offset: 0x8c6)
#using scripts\mp\ftue\utility\ftue_camera;

#namespace ftue_loot_cache;

// Namespace ftue_loot_cache
// Params 3
// Checksum 0x7c92bafd, Offset: 0xa5
// Size: 0x68
function function_3c9f746f062dba86( delta, maxdist, callback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    crate = undefined;
    
    while ( true )
    {
        crate = function_4369cfd4ebf3bbd( delta, maxdist );
        
        if ( isdefined( crate ) )
        {
            break;
        }
        
        waitframe();
    }
    
    self [[ callback ]]( crate );
}

// Namespace ftue_loot_cache
// Params 2
// Checksum 0x6d68c861, Offset: 0x115
// Size: 0x1f, Type: bool
function function_663ccb5308be0bab( delta, maxdist )
{
    return isdefined( function_4369cfd4ebf3bbd( delta, maxdist ) );
}

// Namespace ftue_loot_cache
// Params 1
// Checksum 0x2995bbac, Offset: 0x13d
// Size: 0x62, Type: bool
function function_85e5174946c90517( params )
{
    assert( isdefined( params ) );
    angle = params.angle;
    maxdistance = params.maxdistance;
    assert( isdefined( angle ) );
    assert( isdefined( maxdistance ) );
    return function_663ccb5308be0bab( angle, maxdistance );
}

// Namespace ftue_loot_cache
// Params 2
// Checksum 0xbc5226f5, Offset: 0x1a8
// Size: 0x152
function function_4369cfd4ebf3bbd( delta, maxdist )
{
    assert( delta );
    assert( maxdist );
    var_dec8a38453275dcb = [ "br_loot_cache", "br_loot_cache_lege" ];
    
    foreach ( var_2c67cce493677bbe in var_dec8a38453275dcb )
    {
        lootcaches = getlootscriptablearrayinradius( var_2c67cce493677bbe, undefined, self.origin, maxdist );
        
        foreach ( lootcache in lootcaches )
        {
            if ( !isdefined( lootcache.itemsdropped ) && ftue_camera::function_9e46e8b4ec3a1434( lootcache, delta ) )
            {
                return lootcache;
            }
        }
    }
}

// Namespace ftue_loot_cache
// Params 1
// Checksum 0x5e8c7bbd, Offset: 0x303
// Size: 0x64, Type: bool
function function_1d5a83b08f74c9cc( params )
{
    assert( isdefined( params ) );
    maxdist = params.maxdistance;
    assert( isdefined( maxdist ) );
    lootcache = function_e46704b4fc80a964( maxdist );
    self.var_11133cb0607b498f.closestlootcrate = lootcache;
    return isdefined( lootcache );
}

// Namespace ftue_loot_cache
// Params 1
// Checksum 0x700876cc, Offset: 0x370
// Size: 0x1af
function function_e46704b4fc80a964( maxdist )
{
    var_dec8a38453275dcb = [ "br_loot_cache", "br_loot_cache_lege" ];
    closestdist = maxdist * maxdist;
    closestcache = undefined;
    
    foreach ( var_2c67cce493677bbe in var_dec8a38453275dcb )
    {
        lootcaches = getlootscriptablearrayinradius( var_2c67cce493677bbe, undefined, self.origin, maxdist );
        
        foreach ( lootcache in lootcaches )
        {
            if ( !isdefined( lootcache.itemsdropped ) )
            {
                checkdist = distancesquared( lootcache.origin, self.origin );
                
                if ( !isdefined( closestcache ) || checkdist < closestdist )
                {
                    currentstate = lootcache getscriptablepartstate( "body", 1 );
                    
                    if ( currentstate == #"closed_usable" || currentstate == #"closed_usable_no_collision" )
                    {
                        closestcache = lootcache;
                        closestdist = checkdist;
                    }
                }
            }
        }
    }
    
    return closestcache;
}

// Namespace ftue_loot_cache
// Params 1
// Checksum 0xca81addc, Offset: 0x528
// Size: 0xd1
function function_3b56b334d053def5( maxdist )
{
    assert( maxdist );
    var_dec8a38453275dcb = [ "br_loot_cache", "br_loot_cache_lege" ];
    var_d0e118fca4e319ac = [];
    
    foreach ( var_2c67cce493677bbe in var_dec8a38453275dcb )
    {
        lootcaches = [];
        lootcaches = getlootscriptablearrayinradius( var_2c67cce493677bbe, undefined, self.origin, maxdist );
        var_d0e118fca4e319ac = arraycombine( lootcaches, var_d0e118fca4e319ac );
    }
    
    return var_d0e118fca4e319ac;
}

