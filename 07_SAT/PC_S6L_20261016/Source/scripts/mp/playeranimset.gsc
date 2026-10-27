// scripts\mp\playeranimset.gsc  (hash_1070be3357c9454c.gscc) (size: 4531 Bytes / 0x11b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1604f27a (369422970)
// size ...... 4531 (0x11b3)
// includes .. 1   (offset: 0x10f3)
// strings ... 5   (offset: 0x10fb)
// dev strs .. 8   (offset: 0x1143)
// exports ... 20  (offset: 0x98b)
// cseg ...... 0xc9 + 0x8c2 (0x98b)
// imports ... 36  (offset: 0xcab)
// animtree1 . 0   (offset: 0x11b3)
// animtree2 . 0   (offset: 0x11b3)
#using scripts\mp\common\utility\join_team_aggregator;

#namespace playeranimset;

/#

    // Namespace playeranimset
    // Params 0
    // Checksum 0x60bb360e, Offset: 0xe7
    // Size: 0xb6, Type: dev
    function init_dev()
    {
        setdevdvarifuninitialized( @"hash_db53798b3c5b4e9a", -1 );
        setdevdvarifuninitialized( @"hash_4f76d4cdd982e0cb", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_7f3daeba250a9d7d", 0 );
        setdevdvarifuninitialized( @"hash_98784b47329ab19", 0 );
        thread function_f3d477b30d47a42( @"hash_db53798b3c5b4e9a", -1, 0.5, &function_9a35edb51f0a3517 );
        thread function_c497dda2c6b56204( @"hash_4f76d4cdd982e0cb", "<dev string:x24>", 0.5, &function_fe6bd588fee80d50 );
        thread function_f3d477b30d47a42( @"hash_98784b47329ab19", 0, 0.5, &function_5079db809423f297 );
        thread function_25c9d73a7964457e( @"hash_7f3daeba250a9d7d", 0.5, &function_359bae875fca1c39 );
    }

#/

// Namespace playeranimset
// Params 0
// Checksum 0x5bf5d1ca, Offset: 0x1a5
// Size: 0x58
function init()
{
    base_locomotion_variants = [ "t10_sprint_variants", "t10_sprint_variant_a", "t10_sprint_variant_b", "t10_sprint_variant_c" ];
    level.player_locomotion_variants = arrayrandomize( base_locomotion_variants );
    join_team_aggregator::registeronplayerjointeamnospectatorcallback( &function_240722675ab9236d );
    
    /#
        init_dev();
    #/
}

// Namespace playeranimset
// Params 0
// Checksum 0xeeb22ce2, Offset: 0x205
// Size: 0xb
function function_beae88adc99a924b()
{
    return level.player_locomotion_variants;
}

// Namespace playeranimset
// Params 1
// Checksum 0x263a343, Offset: 0x219
// Size: 0xcb
function function_240722675ab9236d( player )
{
    assert( isdefined( player ) );
    locomotion_variants = function_beae88adc99a924b();
    
    if ( locomotion_variants.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.teamdata[ player.team ][ "teamAddedCount" ] ) )
    {
        level.teamdata[ player.team ][ "teamAddedCount" ] = 0;
    }
    
    var_96dbf40b1de99efb = level.teamdata[ player.team ][ "teamAddedCount" ] % locomotion_variants.size;
    player.var_3dd213154cf9d516 = locomotion_variants[ var_96dbf40b1de99efb ];
    player function_921130e2e9e03389();
    level.teamdata[ player.team ][ "teamAddedCount" ]++;
}

// Namespace playeranimset
// Params 1
// Checksum 0x31912bf1, Offset: 0x2ec
// Size: 0x25
function function_bc3188b261420638( moveset )
{
    /#
        if ( isdefined( self.var_9f59790cd0c192f0 ) )
        {
            return;
        }
    #/
    
    self setmoveset( moveset );
}

// Namespace playeranimset
// Params 0
// Checksum 0x38c9f246, Offset: 0x319
// Size: 0x2c
function function_b86ccdbd2d66db5c()
{
    /#
        var_7237854e3be197ca = self.var_9f59790cd0c192f0;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    #/
    
    return self.var_3dd213154cf9d516;
}

// Namespace playeranimset
// Params 0
// Checksum 0xdcb98bbf, Offset: 0x34e
// Size: 0x21
function function_921130e2e9e03389()
{
    if ( !isdefined( self.var_3dd213154cf9d516 ) )
    {
        return;
    }
    
    function_bc3188b261420638( self.var_3dd213154cf9d516 );
}

/#

    // Namespace playeranimset
    // Params 1
    // Checksum 0x52d6a25d, Offset: 0x377
    // Size: 0x49, Type: dev
    function function_a4ea9da7cf2d5123( index )
    {
        assert( isint( index ) );
        locomotion_variants = function_beae88adc99a924b();
        assert( index >= 0 && index < locomotion_variants.size );
        return locomotion_variants[ index ];
    }

    // Namespace playeranimset
    // Params 1
    // Checksum 0x1669f5f4, Offset: 0x3c8
    // Size: 0x2c, Type: dev
    function function_8da85f0f432dca08( index )
    {
        overridename = function_a4ea9da7cf2d5123( index );
        function_233829233148c48c( overridename );
    }

    // Namespace playeranimset
    // Params 1
    // Checksum 0xf6b69fc0, Offset: 0x3fc
    // Size: 0x30, Type: dev
    function function_233829233148c48c( name )
    {
        assert( isstring( name ) );
        self.var_9f59790cd0c192f0 = name;
        self setmoveset( name );
    }

    // Namespace playeranimset
    // Params 0
    // Checksum 0x994a9d1b, Offset: 0x434
    // Size: 0x16, Type: dev
    function function_2061413ea8eb0c4b()
    {
        self.var_9f59790cd0c192f0 = undefined;
        function_921130e2e9e03389();
    }

    // Namespace playeranimset
    // Params 4
    // Checksum 0xf76268e, Offset: 0x452
    // Size: 0x71, Type: dev
    function function_c497dda2c6b56204( dvar, dvar_default, waitinterval, onchange )
    {
        level endon( #"game_ended" );
        
        for ( prevval = undefined; true ; prevval = val )
        {
            wait waitinterval;
            val = getdvar( dvar, dvar_default );
            
            if ( val != prevval )
            {
                [[ onchange ]]( val, prevval );
            }
        }
    }

    // Namespace playeranimset
    // Params 4
    // Checksum 0x83e3606c, Offset: 0x4cb
    // Size: 0x71, Type: dev
    function function_f3d477b30d47a42( dvar, dvar_default, waitinterval, onchange )
    {
        level endon( #"game_ended" );
        
        for ( prevval = undefined; true ; prevval = val )
        {
            wait waitinterval;
            val = getdvarint( dvar, dvar_default );
            
            if ( val != prevval )
            {
                [[ onchange ]]( val, prevval );
            }
        }
    }

    // Namespace playeranimset
    // Params 3
    // Checksum 0x722518f7, Offset: 0x544
    // Size: 0x51, Type: dev
    function function_25c9d73a7964457e( dvar, waitinterval, onset )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            wait waitinterval;
            
            if ( getdvarint( dvar, 0 ) != 0 )
            {
                [[ onset ]]();
                setdvar( dvar, 0 );
            }
        }
    }

    // Namespace playeranimset
    // Params 2
    // Checksum 0xbf54a62d, Offset: 0x59d
    // Size: 0xd6, Type: dev
    function function_9a35edb51f0a3517( val, prev )
    {
        if ( val == -1 )
        {
            function_2061413ea8eb0c4b();
            return;
        }
        
        locomotion_variants = function_beae88adc99a924b();
        
        if ( val < 0 || val >= locomotion_variants.size )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            player function_8da85f0f432dca08( val );
        }
        
        setdvar( @"hash_4f76d4cdd982e0cb", "<dev string:x24>" );
    }

    // Namespace playeranimset
    // Params 2
    // Checksum 0x298bcb15, Offset: 0x67b
    // Size: 0xb5, Type: dev
    function function_fe6bd588fee80d50( val, prev )
    {
        if ( val == "<dev string:x24>" )
        {
            function_2061413ea8eb0c4b();
            return;
        }
        
        foreach ( player in level.players )
        {
            player function_233829233148c48c( val );
        }
        
        setdvar( @"hash_db53798b3c5b4e9a", -1 );
    }

    // Namespace playeranimset
    // Params 0
    // Checksum 0xeddb8b77, Offset: 0x738
    // Size: 0xce, Type: dev
    function function_611c31d20f7bfddd()
    {
        level notify( #"hash_b213a6ca1be9d61d" );
        level endon( #"hash_b213a6ca1be9d61d" );
        
        while ( true )
        {
            waitframe();
            
            foreach ( player in level.players )
            {
                print3d( player.origin + ( 0, 0, 60 ), player function_b86ccdbd2d66db5c() ?? "<dev string:x25>", undefined, undefined, 0.5, undefined, 1 );
            }
        }
    }

    // Namespace playeranimset
    // Params 2
    // Checksum 0xe320179c, Offset: 0x80e
    // Size: 0x36, Type: dev
    function function_5079db809423f297( val, prev )
    {
        if ( val == 1 )
        {
            thread function_611c31d20f7bfddd();
            return;
        }
        
        level notify( #"hash_b213a6ca1be9d61d" );
    }

    // Namespace playeranimset
    // Params 0
    // Checksum 0x744ae837, Offset: 0x84c
    // Size: 0x13f, Type: dev
    function function_359bae875fca1c39()
    {
        println( "<dev string:x31>" );
        println( "<dev string:x42>" );
        
        foreach ( variant in function_beae88adc99a924b() )
        {
            println( variant );
        }
        
        println( "<dev string:x4f>" );
        
        foreach ( player in level.players )
        {
            println( "<dev string:x5f>" + player getentitynumber() + "<dev string:x68>" + player.var_3dd213154cf9d516 + "<dev string:x78>" + ( player function_b86ccdbd2d66db5c() ?? "<dev string:x25>" ) );
        }
    }

#/
