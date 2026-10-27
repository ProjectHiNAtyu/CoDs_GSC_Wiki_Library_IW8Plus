// scripts\mp\br\gametypes\br_exclusion_zone.gsc  (hash_4a3480d2e0833b9b.gscc) (size: 4520 Bytes / 0x11a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d86f263 (1032254051)
// size ...... 4520 (0x11a8)
// includes .. 2   (offset: 0x1104)
// strings ... 0   (offset: 0x1114)
// dev strs .. 12  (offset: 0x1114)
// exports ... 17  (offset: 0xa64)
// cseg ...... 0x58 + 0xa0c (0xa64)
// imports ... 33  (offset: 0xd0c)
// animtree1 . 0   (offset: 0x11a8)
// animtree2 . 0   (offset: 0x11a8)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;

#namespace exclusion_zones;

// Namespace exclusion_zones
// Params 6
// Checksum 0x56c4b40f, Offset: 0x76
// Size: 0xf3
function function_13326ea977bfb539( position, dimensions, angles, shape, inverted, flags )
{
    if ( isdefined( level.br_multi_circle ) && level.br_multi_circle.circlecount > 1 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( shape ) )
    {
        shape = 2;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    if ( !isdefined( inverted ) )
    {
        inverted = 0;
    }
    
    if ( !isdefined( flags ) )
    {
        flags = 0;
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( !isdefined( level.exclusionzones[ i ] ) )
        {
            level.exclusionzones[ i ] = function_e47908fae7dc9b80( position, dimensions, angles, shape, inverted, flags );
            return i;
        }
    }
    
    assertmsg( "<dev string:x5e>" + 3 );
}

// Namespace exclusion_zones
// Params 3
// Checksum 0x2533ef90, Offset: 0x171
// Size: 0xb1
function function_1efc19de6199fff6( position, var_c724fd039781a4fb, checkinverted )
{
    if ( !isvector( position ) )
    {
        assertmsg( "<dev string:x8f>" + position );
    }
    
    if ( !isdefined( level.exclusionzones ) )
    {
        return -1;
    }
    
    if ( !isdefined( checkinverted ) )
    {
        checkinverted = 0;
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( isdefined( level.exclusionzones[ i ] ) && checkinverted == function_a34dbb66685ce642( level.exclusionzones[ i ] ) )
        {
            if ( level.exclusionzones[ i ] function_9cf1a617fae87e1d( position, var_c724fd039781a4fb, checkinverted ) )
            {
                return i;
            }
        }
    }
    
    return -1;
}

// Namespace exclusion_zones
// Params 3
// Checksum 0xe0501806, Offset: 0x22b
// Size: 0x63
function function_9cf1a617fae87e1d( position, var_c724fd039781a4fb, checkinverted )
{
    if ( !isvector( position ) )
    {
        assertmsg( "<dev string:x8f>" + position );
    }
    
    var_6af68a8ae99e3917 = function_b88d02630ba5e4ec( self, position );
    return var_c724fd039781a4fb ? var_6af68a8ae99e3917 && br_circle::function_6bf5d4e680297398( position ) : var_6af68a8ae99e3917;
}

// Namespace exclusion_zones
// Params 1
// Checksum 0x31abaa7d, Offset: 0x297
// Size: 0x48
function function_5fc2ac1152c0aa19( zone )
{
    assert( isdefined( level.exclusionzones ) );
    assert( isdefined( zone ) );
    level.exclusionzones = arrayremove( level.exclusionzones, zone );
    zone delete();
}

// Namespace exclusion_zones
// Params 2
// Checksum 0x7d546461, Offset: 0x2e7
// Size: 0x5c
function function_a1a887e23f767ba0( var_c502f2c7f9ea3ed9, duration )
{
    assert( isdefined( self ) );
    
    if ( duration == 0 )
    {
        self function_640eed49e718161c( self.origin, var_c502f2c7f9ea3ed9, self.angles );
        return;
    }
    
    assert( duration >= 0, "<dev string:xaa>" );
    thread function_60a26f9fdb6d6628( var_c502f2c7f9ea3ed9, duration );
}

// Namespace exclusion_zones
// Params 2, eflags: 0x4
// Checksum 0x51d97bc0, Offset: 0x34b
// Size: 0x7e
function private function_60a26f9fdb6d6628( var_99da563e52ac031e, duration )
{
    starttime = gettime();
    duration *= 1000;
    var_80a9d12c32a9c5fb = self function_465f674722f8d216();
    
    while ( isdefined( self ) && gettime() < starttime + duration )
    {
        var_c502f2c7f9ea3ed9 = vectorlerp( var_80a9d12c32a9c5fb, var_99da563e52ac031e, ( gettime() - starttime ) / duration );
        self function_640eed49e718161c( self.origin, var_c502f2c7f9ea3ed9 );
        waitframe();
    }
}

// Namespace exclusion_zones
// Params 3
// Checksum 0xfd3a3af5, Offset: 0x3d1
// Size: 0x5c
function function_f597034a78b33c62( var_c502f2c7f9ea3ed9, rate, linear )
{
    assert( isdefined( self ) );
    assert( isdefined( rate ), "<dev string:xec>" );
    
    if ( rate == 0 )
    {
        self function_640eed49e718161c( self.origin, var_c502f2c7f9ea3ed9 );
        return;
    }
    
    thread function_e085473fa9fffa7e( var_c502f2c7f9ea3ed9, rate, linear );
}

// Namespace exclusion_zones
// Params 3, eflags: 0x4
// Checksum 0xa5881a8f, Offset: 0x435
// Size: 0x148
function private function_e085473fa9fffa7e( var_99da563e52ac031e, rate, linear )
{
    var_80a9d12c32a9c5fb = self function_465f674722f8d216();
    var_c502f2c7f9ea3ed9 = var_80a9d12c32a9c5fb;
    var_60d9562fb06eae56 = ( var_99da563e52ac031e - var_c502f2c7f9ea3ed9 ) * rate;
    initialsign = utility::vectorsign( var_99da563e52ac031e - var_c502f2c7f9ea3ed9 );
    
    while ( isdefined( self ) && var_80a9d12c32a9c5fb != var_99da563e52ac031e )
    {
        if ( !linear )
        {
            var_c502f2c7f9ea3ed9 += ( var_99da563e52ac031e - var_c502f2c7f9ea3ed9 ) * rate;
            
            for ( i = 0; i < 3 ; i++ )
            {
                if ( abs( var_99da563e52ac031e[ i ] - var_c502f2c7f9ea3ed9[ i ] ) < abs( var_60d9562fb06eae56[ i ] ) )
                {
                    var_c502f2c7f9ea3ed9 = var_99da563e52ac031e;
                }
            }
        }
        else
        {
            var_c502f2c7f9ea3ed9 += rate;
        }
        
        for ( i = 0; i < 3 ; i++ )
        {
            if ( utility::sign( var_99da563e52ac031e[ i ] - var_c502f2c7f9ea3ed9[ i ] ) != initialsign[ i ] )
            {
                self function_640eed49e718161c( self.origin, var_99da563e52ac031e, self.angles, level.framedurationseconds );
                return;
            }
        }
        
        self function_640eed49e718161c( self.origin, var_c502f2c7f9ea3ed9, self.angles, level.framedurationseconds );
        wait level.framedurationseconds;
        
        if ( isdefined( self ) )
        {
            var_80a9d12c32a9c5fb = self function_465f674722f8d216();
        }
    }
}

/#

    // Namespace exclusion_zones
    // Params 0
    // Checksum 0x7fd31f77, Offset: 0x585
    // Size: 0x5, Type: dev
    function function_eea18adbdbb5777c()
    {
        
    }

    // Namespace exclusion_zones
    // Params 0
    // Checksum 0x37c83dff, Offset: 0x592
    // Size: 0x7f, Type: dev
    function function_48addf7fcf93d9dd()
    {
        foreach ( zone in level.exclusionzones )
        {
            function_5fc2ac1152c0aa19( zone );
            return;
        }
    }

    // Namespace exclusion_zones
    // Params 0
    // Checksum 0xf5fa6cb7, Offset: 0x619
    // Size: 0x5b, Type: dev
    function function_8970e7e306cc4233()
    {
        for ( i = level.exclusionzones.size - 1; i >= 0 ; i-- )
        {
            if ( !level.exclusionzones[ i ].shape != 0 )
            {
                function_5fc2ac1152c0aa19( level.exclusionzones[ i ] );
                return;
            }
        }
    }

    // Namespace exclusion_zones
    // Params 1
    // Checksum 0x9b636062, Offset: 0x67c
    // Size: 0x18, Type: dev
    function function_2a52f92f8b6d9e94( var_c724fd039781a4fb )
    {
        in_exclusion_zone( var_c724fd039781a4fb );
    }

    // Namespace exclusion_zones
    // Params 0
    // Checksum 0xe8a1fad2, Offset: 0x69c
    // Size: 0x6a, Type: dev
    function function_ba5f14de7783c3f0()
    {
        position = level.player.origin;
        dimensions = ( 2000, 2000, 2000 );
        angles = ( 0, 0, 0 );
        zone_id = function_13326ea977bfb539( position, dimensions, angles, 1, 1 );
    }

    // Namespace exclusion_zones
    // Params 0
    // Checksum 0xfb55d394, Offset: 0x70e
    // Size: 0xca, Type: dev
    function function_3f2c0d88b393edc0()
    {
        position = ( 4000, 0, 0 );
        dimensions = ( 50000, 5000, 10000 );
        angles = ( 0, 45, 0 );
        shape = 1;
        function_13326ea977bfb539( position, dimensions, angles, 2, 1 );
        dimensions = ( 3000, 3000, 2000 );
        position = ( 700, -5500, 0 );
        function_13326ea977bfb539( position, dimensions, angles, 2, 1 );
        position = ( 10000, -7000, 0 );
        dimensions = ( 5000, 5000, 1500 );
        function_13326ea977bfb539( position, dimensions, angles, shape );
        level.var_7bf5a8aeff7aa954 = 1;
    }

    // Namespace exclusion_zones
    // Params 1
    // Checksum 0x4f3547c7, Offset: 0x7e0
    // Size: 0xe3, Type: dev
    function in_exclusion_zone( var_c724fd039781a4fb )
    {
        if ( !isdefined( level.exclusionzones ) )
        {
            iprintlnbold( "<dev string:x127>" );
            return;
        }
        
        position = level.players[ 0 ].origin;
        string = "<dev string:x13a>";
        
        for ( i = 0; i < 3 ; i++ )
        {
            if ( isdefined( level.exclusionzones[ i ] ) )
            {
                string = string + i + "<dev string:x150>" + ( level.exclusionzones[ i ] function_9cf1a617fae87e1d( position, var_c724fd039781a4fb ) ? "<dev string:x153>" : "<dev string:x15b>" );
            }
        }
        
        string = string + "<dev string:x164>" + function_1efc19de6199fff6( position, var_c724fd039781a4fb );
        string = string + "<dev string:x171>" + function_1efc19de6199fff6( position, var_c724fd039781a4fb, 1 );
        iprintlnbold( string );
    }

    // Namespace exclusion_zones
    // Params 0
    // Checksum 0xa5c4cdb, Offset: 0x8cb
    // Size: 0x199, Type: dev
    function lerp_exclusion_zone()
    {
        if ( level.var_7bf5a8aeff7aa954 )
        {
            position = ( 4000, 0, 3000 );
            dimensions = ( 10000, 10000, 4000 );
            angles = ( 0, 0, 0 );
            level.exclusionzones[ 0 ] function_640eed49e718161c( position, dimensions, angles, 30 );
            position = ( 5000, 0, 2500 );
            dimensions = ( 4000, 50000, 1000 );
            level.exclusionzones[ 1 ] function_640eed49e718161c( position, dimensions, angles, 10 );
            position = ( -5000, 0, 1500 );
            dimensions = ( 1500, 50000, 1000 );
            level.exclusionzones[ 2 ] function_640eed49e718161c( position );
            level.var_7bf5a8aeff7aa954 = 0;
            return;
        }
        
        position = ( 4000, 0, 3000 );
        dimensions = ( 10000, 10000, 4000 );
        angles = ( 0, 0, 0 );
        level.exclusionzones[ 0 ] function_640eed49e718161c( position, dimensions, angles, 30 );
        dimensions = ( 1000, 6000, 4000 );
        position = ( 5000, 0, 1500 );
        level.exclusionzones[ 1 ] function_640eed49e718161c( position, dimensions, angles, 10 );
        position = ( -2667, -5561, 1500 );
        dimensions = ( 4000, 4000, 4000 );
        level.exclusionzones[ 2 ] function_640eed49e718161c( position, dimensions, angles, 15 );
        level.var_7bf5a8aeff7aa954 = 1;
    }

#/
