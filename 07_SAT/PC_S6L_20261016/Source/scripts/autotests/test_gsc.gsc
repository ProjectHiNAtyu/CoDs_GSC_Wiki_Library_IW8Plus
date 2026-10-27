// scripts\autotests\test_gsc.gsc  (hash_03b8d41c76313c77.gscc) (size: 8482 Bytes / 0x2122 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d310080 (1563492480)
// size ...... 8482 (0x2122)
// includes .. 1   (offset: 0x1cf2)
// strings ... 66  (offset: 0x1cfa)
// dev strs .. 0   (offset: 0x2122)
// exports ... 6   (offset: 0x177a)
// cseg ...... 0x82f + 0xf4b (0x177a)
// imports ... 18  (offset: 0x186a)
// animtree1 . 0   (offset: 0x2122)
// animtree2 . 0   (offset: 0x2122)
#using scripts\autotests\autotests;

#namespace test_gsc;

// Namespace test_gsc/testautomation
// Params 0, eflags: 0x20
// Checksum 0x7a33589d, Offset: 0x84d
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_gsc.gsc", #"test", &start_test, &setup );
}

// Namespace test_gsc
// Params 0
// Checksum 0xe64de985, Offset: 0x876
// Size: 0x4, Type: bool
function setup()
{
    return true;
}

// Namespace test_gsc
// Params 0
// Checksum 0xfeb9bad7, Offset: 0x883
// Size: 0xa, Type: bool
function start_test()
{
    function_8c16619fc6867af();
    return false;
}

// Namespace test_gsc
// Params 0
// Checksum 0xe639b051, Offset: 0x896
// Size: 0x6a8
function function_8c16619fc6867af()
{
    arr = [];
    arr[ 0 ] = 10;
    arr[ 1 ] = 20;
    arr[ 2 ] = 30;
    arr[ 3 ] = 40;
    arr[ 4 ] = 50;
    result = arrayrandomize( arr );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize int keys: size preserved", result.size, arr.size, "scripts/autotests/test_gsc.gsc", 42 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    foreach ( orig_val in arr )
    {
        found = 0;
        
        foreach ( var_d911ad28b8df2936 in result )
        {
            if ( var_d911ad28b8df2936 == orig_val )
            {
                found = 1;
                break;
            }
        }
        
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "ArrayRandomize int keys: value " + orig_val + " present", found, "scripts/autotests/test_gsc.gsc", 55 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    for ( k = 0; k < result.size ; k++ )
    {
        var_63a718d91714219d = autotests::function_36ed835262a19e53( "ArrayRandomize int keys: key " + k + " exists", result[ k ], "scripts/autotests/test_gsc.gsc", 60 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    if ( level.players[ 0 ] )
    {
        result = arrayrandomize( getaiarrayinradius( level.players[ 0 ].origin, 20000 ) );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize push func return: size is equal", result.size, getaiarrayinradius( level.players[ 0 ].origin, 20000 ).size, "scripts/autotests/test_gsc.gsc", 67 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    arr = [];
    result = arrayrandomize( arr );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize empty: size is 0", result.size, 0, "scripts/autotests/test_gsc.gsc", 73 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    arr = [];
    arr[ 0 ] = 42;
    result = arrayrandomize( arr );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize single: size is 1", result.size, 1, "scripts/autotests/test_gsc.gsc", 79 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize single: value preserved", result[ 0 ], 42, "scripts/autotests/test_gsc.gsc", 80 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    arr = [];
    arr[ 0 ] = 42;
    arr[ 1 ] = 3.14;
    arr[ 2 ] = "hello";
    arr[ 3 ] = ( 1, 2, 3 );
    result = arrayrandomize( arr );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize value types: size preserved", result.size, arr.size, "scripts/autotests/test_gsc.gsc", 90 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    found_int = 0;
    found_float = 0;
    found_str = 0;
    found_vec = 0;
    
    foreach ( val in result )
    {
        if ( isint( val ) && val == 42 )
        {
            found_int = 1;
        }
        
        if ( isfloat( val ) && val == 3.14 )
        {
            found_float = 1;
        }
        
        if ( isstring( val ) && val == "hello" )
        {
            found_str = 1;
        }
        
        if ( isvector( val ) && val == ( 1, 2, 3 ) )
        {
            found_vec = 1;
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "ArrayRandomize value types: int found", found_int, "scripts/autotests/test_gsc.gsc", 107 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "ArrayRandomize value types: float found", found_float, "scripts/autotests/test_gsc.gsc", 108 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "ArrayRandomize value types: string found", found_str, "scripts/autotests/test_gsc.gsc", 109 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "ArrayRandomize value types: vector found", found_vec, "scripts/autotests/test_gsc.gsc", 110 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    arr = [];
    arr[ 0 ] = "a";
    arr[ 1 ] = "b";
    arr[ 2 ] = "c";
    arr[ 3 ] = "d";
    arr[ 4 ] = "e";
    result1 = arrayrandomize( arr, 12345 );
    result2 = arrayrandomize( arr, 12345 );
    
    for ( k = 0; k < result1.size ; k++ )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize seeded: deterministic at index " + k, result1[ k ], result2[ k ], "scripts/autotests/test_gsc.gsc", 124 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    var_5b1e9c6c84e82e90 = arrayrandomize( arr, 99999 );
    differs = 0;
    
    for ( k = 0; k < result1.size ; k++ )
    {
        if ( result1[ k ] != var_5b1e9c6c84e82e90[ k ] )
        {
            differs = 1;
            break;
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "ArrayRandomize seeded: different seed gives different order", differs, "scripts/autotests/test_gsc.gsc", 138 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_gsc
// Params 0
// Checksum 0xec37648d, Offset: 0xf46
// Size: 0x834
function function_cd70206f4ca6c740()
{
    arr = [];
    arr[ "alpha" ] = 100;
    arr[ "bravo" ] = 200;
    arr[ "charlie" ] = 300;
    arr[ "delta" ] = 400;
    arr[ "echo" ] = 500;
    arr[ "foxtrot" ] = 600;
    arr[ "golf" ] = 700;
    arr[ "hotel" ] = 800;
    arr[ "india" ] = 900;
    arr[ "juliet" ] = 1000;
    result = arrayrandomize( arr );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: size preserved", result.size, arr.size, "scripts/autotests/test_gsc.gsc", 164 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: alpha value", result[ "alpha" ], 100, "scripts/autotests/test_gsc.gsc", 165 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: bravo value", result[ "bravo" ], 200, "scripts/autotests/test_gsc.gsc", 166 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: charlie value", result[ "charlie" ], 300, "scripts/autotests/test_gsc.gsc", 167 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: delta value", result[ "delta" ], 400, "scripts/autotests/test_gsc.gsc", 168 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: echo value", result[ "echo" ], 500, "scripts/autotests/test_gsc.gsc", 169 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: foxtrot value", result[ "foxtrot" ], 600, "scripts/autotests/test_gsc.gsc", 170 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: golf value", result[ "golf" ], 700, "scripts/autotests/test_gsc.gsc", 171 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: hotel value", result[ "hotel" ], 800, "scripts/autotests/test_gsc.gsc", 172 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: india value", result[ "india" ], 900, "scripts/autotests/test_gsc.gsc", 173 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize string keys: juliet value", result[ "juliet" ], 1000, "scripts/autotests/test_gsc.gsc", 174 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    original_order = [];
    original_order[ 0 ] = "alpha";
    original_order[ 1 ] = "bravo";
    original_order[ 2 ] = "charlie";
    original_order[ 3 ] = "delta";
    original_order[ 4 ] = "echo";
    original_order[ 5 ] = "foxtrot";
    original_order[ 6 ] = "golf";
    original_order[ 7 ] = "hotel";
    original_order[ 8 ] = "india";
    original_order[ 9 ] = "juliet";
    order_changed = 0;
    idx = 0;
    
    foreach ( key, val in result )
    {
        if ( key != original_order[ idx ] )
        {
            order_changed = 1;
            break;
        }
        
        idx++;
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "ArrayRandomize string keys: iteration order changed", order_changed, "scripts/autotests/test_gsc.gsc", 200 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    arr = [];
    arr[ #"weapon_type" ] = "rifle";
    arr[ #"damage" ] = 75;
    arr[ #"is_equipped" ] = 1;
    result = arrayrandomize( arr );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize xhash keys: size preserved", result.size, arr.size, "scripts/autotests/test_gsc.gsc", 209 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize xhash keys: #weapon_type value", result[ #"weapon_type" ], "rifle", "scripts/autotests/test_gsc.gsc", 210 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize xhash keys: #damage value", result[ #"damage" ], 75, "scripts/autotests/test_gsc.gsc", 211 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize xhash keys: #is_equipped value", result[ #"is_equipped" ], 1, "scripts/autotests/test_gsc.gsc", 212 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    arr = [];
    arr[ "name" ] = "sword";
    arr[ #"weapon_class" ] = "melee";
    arr[ "rarity" ] = "legendary";
    arr[ #"base_damage" ] = 90;
    arr[ "slot" ] = 2;
    arr[ #"aoe_radius" ] = 0;
    result = arrayrandomize( arr );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize mixed keys: size preserved", result.size, arr.size, "scripts/autotests/test_gsc.gsc", 224 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize mixed keys: 'name' value", result[ "name" ], "sword", "scripts/autotests/test_gsc.gsc", 225 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize mixed keys: 'rarity' value", result[ "rarity" ], "legendary", "scripts/autotests/test_gsc.gsc", 226 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize mixed keys: 'slot' value", result[ "slot" ], 2, "scripts/autotests/test_gsc.gsc", 227 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize mixed keys: #weapon_class value", result[ #"weapon_class" ], "melee", "scripts/autotests/test_gsc.gsc", 228 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize mixed keys: #base_damage value", result[ #"base_damage" ], 90, "scripts/autotests/test_gsc.gsc", 229 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize mixed keys: #aoe_radius value", result[ #"aoe_radius" ], 0, "scripts/autotests/test_gsc.gsc", 230 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    arr = [];
    arr[ "only" ] = 42;
    result = arrayrandomize( arr );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize single string key: size is 1", result.size, 1, "scripts/autotests/test_gsc.gsc", 236 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "ArrayRandomize single string key: value preserved", result[ "only" ], 42, "scripts/autotests/test_gsc.gsc", 237 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

